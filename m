Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0BC3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026308859B;
	Fri, 26 Jul 2024 14:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RgzDsRdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EE187B84; Fri, 26 Jul 2024 14:59:06 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F2D87B77
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-66a1842b452so17587997b3.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998738; x=1722603538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2kMwGQj2KrnfWzs4dRWgKsdfLlEzFc7f6QEoeZwjUC4=;
 b=RgzDsRdMD2Ngu72CnmcO5agHClcmuerTv9+EyQd2hLAtOh16dxvsj2t099vCx20rEK
 v+OwrRz7EwmyRrTl9Y/F4ydelsGHCYM75VFAJ7+miAjU1AWYGP4cFNLPnHfjcjRjwUwN
 rMqbTvgRWSheD0nLfk0Zg81NhnYRrYFtn4BBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998738; x=1722603538;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2kMwGQj2KrnfWzs4dRWgKsdfLlEzFc7f6QEoeZwjUC4=;
 b=TFIl6d5+gU4+IFsKVXDXb8RDx4ibZXLeqfEQ9Q5KWK8AGaOwCMfXqAExa8DGAuIcZQ
 rwS5V1soX6/YNqLtmtvPWHTrbXf7BICF36Ney1wNvL+iWh8RaOu4JHQkV36ysct1Gh5H
 vyU+NSktvasOrZi52zbRpnYB84wqm2F2gBtgHPf0I3/cHFWZerNlY+XpU7A9JBg+giyP
 UpjBg1FGlSrT5CipAbDOjbJgCjbhx7+Y9RpE30iJql7Fs1ZAd/QQLwRxflaFa0YT4Qny
 ReXv1bfzEyL1mzok0icmyyUwK6W41bviJlUdT2LU0JkQAI2V+5H53r4Uo531aIUOBKME
 x2oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJe8a8uOqJvQKAZC9NeRhpzslYZM71HBMwC2AKtMI+8KILm+cPUJHCpiIR+w9epscF9z0njX560UsDfQry2rR+EQDdQQ==
X-Gm-Message-State: AOJu0Yyl818nFVfCeKNs64qsJbsBioD/Hzsg7hpn/N/hFxkaU/m8ieLo
 f5zKL9Zn6QGWcRczMC+6Ro4zf0/GSNom/fxcikpuKAkFR84sVY8udHtz6R2IKHL/so3T84miOQ3
 Ukaf9n8RXbYtgH7a32yfb3W5vtDhbwyp4kj5c
X-Google-Smtp-Source: AGHT+IG9nfq7ZFfAZdJlxgAC7caPkk7gCkp+A+vNj96+xmgDeiD49gFdVxIPXiEmj1cU4d7dnMyIOr9joGBkTL3+vAk=
X-Received: by 2002:a0d:ef42:0:b0:646:5f0b:e54 with SMTP id
 00721157ae682-675b8811f24mr55010987b3.8.1721998738004; Fri, 26 Jul 2024
 05:58:58 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-20-sjg@chromium.org>
References: <20240717155712.2913651-20-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:57 -0700
X-Google-Sender-Auth: L--5kzVb10CsNc2wL7stXmwRxlA
Message-ID: <CAFLszTgcbaVBGVoJSKKu2v_mT9teVTpGoznoNg7ve2u3yY4V-A@mail.gmail.com>
Subject: Re: [PATCH 19/24] qconfig: Move progress output into the class
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Rather than create these outputs separately, put them in the class so
that the main program doesn't need to deal with them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

Applied to u-boot-dm, thanks!
