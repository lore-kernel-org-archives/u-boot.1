Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17840E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3581805FC;
	Fri, 20 Dec 2024 05:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L3kloQmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EE9805ED; Fri, 20 Dec 2024 05:06:50 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD5F80608
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so292376766b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667606; x=1735272406; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7hvo7t8bHC6p6/FZEQlYcjbs+xiwa0fcwhjIi//yx8=;
 b=L3kloQmnN3dSBgke84Z26HcJP7gH+fjaPNgQKcRL/VfoBSQa1wKu+KGF80EOePKADK
 tpEjyyosToycZcQGP518kExuhO2cQQiGa6DLE5pCHzXvl76cY2cnNzmE9VxnuYf+ukJE
 YXUn3JUnjMfJ7DfGsmSPcZXmWfXM8hG8z7KYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667606; x=1735272406;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7hvo7t8bHC6p6/FZEQlYcjbs+xiwa0fcwhjIi//yx8=;
 b=pyFSC/4mJnZ+EO4VFKly5VcHbM1P8MDhNiuDhda8rW03uXEY+Lampqf72YTUCIZhlP
 SAr07V1umQycNnplf3UkPfAaxZK1ae/hvEkmZW7oaF2by62ysljs6vwr2ScX0uhwExLW
 8HQYyLGLmCGnoXeLTYIZUjX1oTFSMuAVHhaPNZ2u/rcKMWPdnAoy2eB9W/pzEV1Pz7NX
 L7bCt6f1kYTuk7mtTlrKu3jbDIhyYUjM/oG82VUyg8flBRXXh76YKn0GFYBQ7454weSW
 tJpHYdOf/HXqcjQIO98k9eD+4acPneR02eGGf4MHwX47ohPsWd4TpmfJXNbYNHO7Yy3G
 vtnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrCoEd/vfkqYxkZrNRk5/CSofYjawTDjgXtqLpLbJI9B+zeSaOCSNoDh+/vNR+VnKyB2P61tw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/NI0V9eHC9fadR7yH4U9iyKwoIcBJpLj8XbKEPEMaqdNuXRS8
 VCQaydcO9Gn8FLqMXsfegPqAKzO0WFWMsfaLPg8WZbd3M4E6/0N2UeUna1txk3Oi/tju0C/vZBV
 bRZBcwp1LSho+qBTWa7S0UnhbOWTiZyq/vcle
X-Gm-Gg: ASbGnctUFk5APjNR/4wc1YUWCXaO7Z9IBmgmFp+lopqkKFPQG3DBpijQWUrEsmc57qn
 z5AODtx0NgZkuBBf/fEA595m009pi9yKRysFfW1g=
X-Google-Smtp-Source: AGHT+IHrHa7Ebk4SKXl2F+FxPekFSYy09t5A82L38VBt2elI3VlfVhzJDS3xsf4UlwVDCbfMKZUomYe+JTwRUm99TpY=
X-Received: by 2002:a17:907:c10:b0:aa6:74a9:ce6e with SMTP id
 a640c23a62f3a-aac2ad7fa23mr94145266b.16.1734667605984; Thu, 19 Dec 2024
 20:06:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:44 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-8-sjg@chromium.org>
References: <20241206023626.2456858-8-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:44 -0800
X-Google-Sender-Auth: mFPF8VOuhKACcqVxTl587ZonF9c
Message-ID: <CAFLszThsXyo4oxhiWDwv8ujvyyrmeLPu5mYQTbnx9973xUazvQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/46] bootstd: Correct display of kernel version
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

The address of the bzImage is not recorded in the bootflow, so we cannot
actually locate the version at present. Handle this case, to avoid
showing invalid data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 13 ++++++++-----
 cmd/bootflow.c        |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
