Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56F8C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 18:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFD287618;
	Fri,  8 Dec 2023 19:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="tk9q3Pq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D457E87618; Fri,  8 Dec 2023 19:42:24 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494568760A
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 19:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-58d3c5126e9so1219646eaf.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702060940; x=1702665740;
 darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nzsO/PJXaBD55jGeZmt6GaAio6QeV0JTKRsWFU15fKo=;
 b=tk9q3Pq4tWZBfWoSdZfeisRTvJwmyn3NA12WzhjkgCvlN+GqO7m1LA2ZJ25o0guQR0
 LjqgUsel/e0+ttwkP2b/eEYnqdjnTLTS9MFPa8+v8ELW0KZyf3eqjmXHmjFO/FNYJt+d
 hLAxCNNDjYRuTd3Ld4ewc86327AVAufoelPIK3ypk45Q3U0EyuxmeV34pyW0cGGQQk01
 RNwLodfxZy6YpH/jTZzVQ+V7HjcY9oZ5JRlmEXPkg5IYjuOJjcNjR3w59m2HSpZ9orJC
 Bv7zrBbhAekh0Frn4dZXbjvE49vOKgkvDPZ8qSTlXrOT5pew8PORs1R7EiF4jAxNj3vh
 ZauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060940; x=1702665740;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nzsO/PJXaBD55jGeZmt6GaAio6QeV0JTKRsWFU15fKo=;
 b=Vdcq8JCRIp+MjWV0gW9CnY8mdG/mDcrSEWF5B9n81K9s6+Sj8npQikr966Y1KHbOY5
 wudsEFodGVCQJK4FVEue67hfqFXcpgvYrhjVoK039Ix5urgL8HNh2iduDd3obeN0eMba
 5cEKKZQnJ7qP1TuL22GKdDyuSTJaonR9wzaaxZzPPnhQWLfYxeVBKB/vQv6EIsWRXxgf
 FSOxQwFSFEc+HUeUEWQR/XrXp/qJGj+H5Z4yKXriv18X4yzzFpQSyEBK7DwWF5ICEN8f
 LXlxMzcjqVbNL0TYNQu6AQowCAS2rAztJrcZAYTU5qBUhjK54Wi+X2HTVtLP3GgGp4p6
 hE8Q==
X-Gm-Message-State: AOJu0Yyn5TEjNYNLdn5ke5xy4RmQAg9wWuVLHPhFDZPz88oe/y6i2rxl
 t+xyHWuxGMNZfIJDEZrc8FSN9swQ4Yxp4WViMUzfW3bu7pVjNVusMa0=
X-Google-Smtp-Source: AGHT+IEG6Ci4U2ix2WwjGJgrBbwONacEzrf8Lw96lGfki7AtLDlI8Mhq+cGADjxMRfQop50lJqCCyIm5aW36niFgNng=
X-Received: by 2002:a05:6820:1ac9:b0:590:87c5:2b0c with SMTP id
 bu9-20020a0568201ac900b0059087c52b0cmr570139oob.7.1702060940575; Fri, 08 Dec
 2023 10:42:20 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Fri, 8 Dec 2023 15:42:04 -0300
Message-ID: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
Subject: iMX6, CONFIG_IMX_HAB and fuse_read()
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 08 Dec 2023 19:43:22 +0100
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

Hi!

I am currently not subscribed (already filled the form waiting for
confirmation), so please CC me for the moment.

I am trying to enable Secure Boot/HAB on u-boot 2022.07. In a previous
version this was achieved by enabling CONFIG_SECURE_BOOT, which was
then renamed to CONFIG_IMX_HAB.

Now if I enable this option I get:

```
| arm-tdx-linux-gnueabi-ld.bfd: arch/arm/mach-imx/hab.o: in function
`imx_hab_is_enabled':
| /home/lisandro/myproject/build/tmp/work/apalis_imx6-tdx-linux-gnueabi/u-b=
oot-toradex/1_2022.07-r0/git/arch/arm/mach-imx/hab.c:875:
undefined reference to `fuse_read'
| make[2]: *** [/home/lisandro/myproject/build/tmp/work/apalis_imx6-tdx-lin=
ux-gnueabi/u-boot-toradex/1_2022.07-r0/git/scripts/Makefile.spl:525:
spl/u-boot-spl] Error 1
```

Now without IMX_HAB enabled CONFIG_CMD_FUSE is enabled and actually
works, ie, I can read the fuses from u-boot's command line. So I'm
suspecting this is just a missing condition... somewhere. But so far I
have not been able to detect exactly where. Can anyone give me a
non-NULL pointer on this?

Thanks in advance, Lisandro.

--
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
