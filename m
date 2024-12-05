Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63808E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32348955B;
	Thu,  5 Dec 2024 20:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iMSb0AS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0330989530; Thu,  5 Dec 2024 20:56:20 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6E4895C2
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa629402b53so150901266b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428577; x=1734033377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P/CjWu0N4PSye4/emCQ6eM7YDsohhoO8BrHzsivkMYs=;
 b=iMSb0AS6gds8OatuxvZuGeOc1yJ2lPvb2hjLWEOTnKELJuQZuMrQPOWzRECm6MJZ04
 5N1VSs56ryYXx6jUgL3GWjSdepKXf8DtDBWTQZu5bN7lnZw9yeHEecFhpCJjny4pHx4m
 TwMySvryRuMkfqiVYqkfPbXLCKVg2GapPAWCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428577; x=1734033377;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/CjWu0N4PSye4/emCQ6eM7YDsohhoO8BrHzsivkMYs=;
 b=NrUQptM2d2k8UuA0zrkrOekKMNTEARSUZfEyg3mWKQGGl2zkj4z2pSTMI4k3yPbhLy
 bSf63bTkXP+ZTlQuPkUrRxx84oAu6+OiNUV6QHISR0G7OOY4iET5tXCTdQOqNvoSzP0S
 r6yloEs11FM6wq1v+eHijtf5dGjUm3WLujVR5sLLp91rweO8kIk8xj9Yd211p8+9OwBM
 SBTbtscJs+WLCllsaaLDIbMkWjwJ9s/FQwEawShkzPhN0y4aqRw7wt6IRavhN5Cs8iAk
 Y3gKqyYpGJV7dS3+J2yBS02hdsrsMn/WstK6MD/PjhbUmuOWrquILc3qvBBD8lWjU0u1
 C6oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVRgGzBl1unRMhFp3Z8dH1wC2aYwdBQ6Snm5wTsKbmlnTSmi5y0HCYpjqr835fJj0fxVFslv8=@lists.denx.de
X-Gm-Message-State: AOJu0YwJhFN/+LUJ3hlZvKvTDYWD2Yr1ebteEUg1DrSvch0Jmc/oA0Cf
 B9YPU1QCv2L7yf+JRHAkvZq60mXgYoZHUfhvf7IUTlft145BONjILI8UWBORepdyMDETowhCZ2z
 DoHs1gnwaRyCWnNU1dAfWoe7yp2JfdzdZZXke
X-Gm-Gg: ASbGncs0J/rKg1Sg86uLtatJsFq6lScngyKMImXQ+3eYqQqFvuRIVAhSiHu7YY6qSr/
 0mPn0j3HIugjnSQx9RdE7wsygVklQDiEr
X-Google-Smtp-Source: AGHT+IG4ckycNkITHFgESjkU4JX2e19Rg2qODJwyOxuS2OuHs0f8QNksf8jcYDJoTys0gSKFgiBGd2GmHjJ3q6HMjAo=
X-Received: by 2002:a17:906:31cb:b0:aa6:2c53:aee7 with SMTP id
 a640c23a62f3a-aa63a242a80mr6609866b.49.1733428577514; Thu, 05 Dec 2024
 11:56:17 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:56:14 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-2-sjg@chromium.org>
References: <20241115231926.211999-2-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:56:14 -0600
X-Google-Sender-Auth: uhpqyiO7rErQwtW0-zJBgm2ucvU
Message-ID: <CAFLszTg0UpVKOdfKXAi-f+tbPZBJ_hKOqt2j3AoQBZjzSHU4nQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] bootstd: Move bootflow-adding to bootstd
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This relates to more than just the bootdev, since there is a global list
of bootflows. Move the function to the bootstd file and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 25 -------------------------
 boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
 cmd/bootflow.c        |  2 +-
 include/bootdev.h     | 15 ---------------
 include/bootstd.h     | 17 +++++++++++++++++
 5 files changed, 43 insertions(+), 41 deletions(-)

Applied to ci/master, thanks!
