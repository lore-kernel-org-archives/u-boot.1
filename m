Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7BBC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF3C8759A;
	Thu, 26 Oct 2023 10:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xpHFiWJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5834875A5; Thu, 26 Oct 2023 10:48:38 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8446287591
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9d132d92cso1264345ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698310115; x=1698914915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN1Ja05RMi+ATdlfIHMWRhzn0UxHDvTi1dEADBPue5w=;
 b=xpHFiWJHAli7KWgDtQQJ03uTXtPKjIs1Pm7cd+tU6JlYFIa/iqJnbMh2Pwyh67+25h
 5yz8fXdX9HM4IBAIYz7Og/98qokxcFct+hdd2aVl2R5RJaezGFOCbOieguJHaXacJHUM
 wWA+wLjEgkdO1r8gHYaODaHpEAYmXMovMMmry+tcYVrp+8qrvg53RcobGv/Ep3y3Txhg
 ZzNhJciPlcwmMb3RU7OwYJNpQKtXMkfRPJHS0rrSHqQ8dHB9TX7gfhx1xo8kIqZECay3
 OtsiH0p+aNozDoMswc1y2ciroFnd9bAjPoOQlOkFOx9lgGaKcAlH2MP6SMAP6uyKGHp2
 uMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698310115; x=1698914915;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XN1Ja05RMi+ATdlfIHMWRhzn0UxHDvTi1dEADBPue5w=;
 b=FjTgEw68qN/Fjp1iF1iyFLkCWRqZKBq7UUYCX1NXGnN6ekaU2jUbttjo6yX+s8Gcsa
 ja3Bbox6ufq6bsbUnsnWC25dQ4r/Obuu5JR4FlaKKGMkD1B0QAw6fJGml4W0KN80s5mn
 PW20r6scvtcw2SDojFUspTesV3Yx4hRp/Cw9EE8mcBCgH5SoHLk73JD2PT9DR0Ovjlzi
 J5RUHpqTEeY5IByG7QGdtTf/4WaATS1x9q89fNO99YTo3AMqH2oJqFi58RbHNK2KuNOf
 25vkIN9dZ9b06Z7aO+O+EyPTiSd6ZhRw/WUgnJYpoKbSznNIZ7Qvzd2bTLaGmus4S/Bf
 0hFw==
X-Gm-Message-State: AOJu0YxeJxZ/Vbo0m/4b/JgpKlpOdNV4ynmw/r6NoEw2XsFtXCY3BNPP
 8nrkeBajPp0U8znalOotP+cBXQ==
X-Google-Smtp-Source: AGHT+IG8HqxK8aAQG+E7qP/mcqDikM2yw1TBraPO22esrDtIxp7ViQNp6pR0J5uob5P/28RaVnO5kQ==
X-Received: by 2002:a17:90b:1d0e:b0:27d:1593:2b08 with SMTP id
 on14-20020a17090b1d0e00b0027d15932b08mr20286121pjb.0.1698310114470; 
 Thu, 26 Oct 2023 01:48:34 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 gd22-20020a17090b0fd600b0027dafa55306sm1179713pjb.40.2023.10.26.01.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 01:48:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 17:48:30 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 11/13] fs: remove explicit efi configuration dependency
Message-ID: <ZTon3nThWP/XmkGd@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org, jbx6244@gmail.com,
 u-boot@lists.denx.de
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-12-takahiro.akashi@linaro.org>
 <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
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

On Thu, Oct 26, 2023 at 09:58:53AM +0200, Heinrich Schuchardt wrote:
> 
> 
> Am 26. Oktober 2023 07:30:50 MESZ schrieb AKASHI Takahiro <takahiro.akashi@linaro.org>:
> >Now it is clear that the feature actually depends on efi interfaces,
> >not "bootefi" command. efi_set_bootdev() will automatically be nullified
> >if necessary efi component is disabled.
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >---
> > fs/fs.c | 7 +++----
> > 1 file changed, 3 insertions(+), 4 deletions(-)
> >
> >diff --git a/fs/fs.c b/fs/fs.c
> >index 4cb4310c9cc2..70cdb594c4c8 100644
> >--- a/fs/fs.c
> >+++ b/fs/fs.c
> >@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
> > 		return 1;
> > 	}
> > 
> >-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> >-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> >-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> >-				len_read);
> >+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> 
> This function should not exist for CONFIG_EFI_LOADER=n. There are other places where the function is invoked. Please, review all of them.

Please go through the whole patch set, especially patch#8
"efi_loader: split unrelated code from efi_bootmgr.c".

efi_[set|clear]_bootdev() will be nullified if not necessary.

-Takahiro Akashi

> Best regards
> 
> Heinrich
> 
> 
> >+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> >+			len_read);
> > 
> > 	printf("%llu bytes read in %lu ms", len_read, time);
> > 	if (time > 0) {
