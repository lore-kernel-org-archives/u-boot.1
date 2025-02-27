Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A793C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642F4801FB;
	Thu, 27 Feb 2025 03:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axXqKezD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52259805C3; Thu, 27 Feb 2025 03:58:44 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F748006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-30a303a656aso5320571fa.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740625121; x=1741229921; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=un1TOrBfUGaDTxmPBBtIJtZ1Eie+P52smBLtyKMouQQ=;
 b=axXqKezDT1aOvDu26y3gtQKWrK+87uwR8DPNKZQiNFvRmHz7jviXGe+s1ja3af6EOl
 eYgX3ch7vt7RaZISKaIduktiAnVZFo90WqBbb/jkFX4O1Gg7aB3ewfuQvKyIi6eRxIo4
 50B6C56PZENmqrEtvFjs/Nx+sLOv6b3ihjXxAd+JB5el7jYPCiUXI63DRrihHkBZsyfh
 57b3aw7LobHCKO2NozTWOFfnh5egNjmamwb6TT6cy48cEkkun9oCiTfipKdeG3ILXpbO
 sqBptdljM+1obyjA5YqrnSxk3lLffnRcJZo9w8IJI4MzZUnmhD5xRiKxrYa3Z00bjiUX
 3ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740625121; x=1741229921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=un1TOrBfUGaDTxmPBBtIJtZ1Eie+P52smBLtyKMouQQ=;
 b=R0Knf3Ern2hWYsKlJxQqlBU2SL4uegL3BBCyabgtvyDPgXQiJVLlbRDsKE/vek+MeI
 RRwEgvEeVarNUmzt2pcghT/8MePhcVrmt2TnILBSpkBdGLmgHAWIyWQNFYy8oJSEAF2I
 TxCe/wC1nVotv/+4uFaPyPPLkeL4elCLqEzIxeJ28Un0Ohivro8e5FZHjVQfVgPHfayl
 hHpB13fwOYpCSN87OxLyc7CkU9AUapasr2tzxxjtIScdPiqxFGw9aHf13ghJIFjUaTT9
 d5cnR5fdLxyyeGnF2NtmUoA0oKc0ioAkY0JsE3fMcZNdUDNO6SVH+lAKC9mP3wUVZiUL
 VLcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqgPHWUX7CN+m4YgBeiGEHaga6oPpQD2mqVpJgyLaUhWa93crDY97VPyVRGpQp3pLM7OByOyI=@lists.denx.de
X-Gm-Message-State: AOJu0YwqRMjvRTMSDqXYAHOfPXGWp424ksoxE+A8if1GNn6t3AnonLR2
 ofhsAXmIcUM3+CMZAvMQSPSK/iiMlhUams0h2clg6AIQzMkRxVtmd/GHgAq6t/HdDZV+4NDHGG3
 ZfX/afXouoa64Igb1bpbTV2/pA+k=
X-Gm-Gg: ASbGncvb/nfYaLewDnjQ4TLgJhgbQzod68Hu7YtikC+87FPlTYBNEbJdcC77CD65yaK
 UwHLtSCEWKzIonddCkWBdV68vut6p8Vt6J39f/bT2/biPlDNJz4JbcKw3x0vntEzGC6cKd8Or32
 i0ScyN5cpw
X-Google-Smtp-Source: AGHT+IGo1DpG4bt5+B/DpJ5IAkPlHzOwIUys69+FTqv11JLMiR+/tbcxja4hP1s2vVxmjuSmsPuLIP4jeY2nk9xqRjs=
X-Received: by 2002:a05:6512:3d8f:b0:545:b9a:b4b4 with SMTP id
 2adb3069b0e04-54839263a0cmr11327395e87.52.1740625121194; Wed, 26 Feb 2025
 18:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <20250227022748.GS2640854@bill-the-cat>
In-Reply-To: <20250227022748.GS2640854@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 23:58:27 -0300
X-Gm-Features: AQ5f1JqNwrEdjg_hNrj4D8UifMIFMhRtQdzV9_X4aDD2D8smkOMTC4pFkoKQ0qU
Message-ID: <CAOMZO5CeOjL0iNSQeC-S0u10vx-T-Kkj82-E9Aes5jKTB227tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: Tom Rini <trini@konsulko.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 26, 2025 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> Did you reset the environment at some point to be the new default?

Yes, this was the issue, thanks.

Besides that, I also need to set kernel_addr_r for the boot to succeed:

--- a/board/freescale/imx93_evk/imx93_evk.env
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -16,6 +16,7 @@ mmcroot=3D/dev/mmcblk1p2 rootwait rw
 mmcautodetect=3Dyes
 mmcargs=3Dsetenv bootargs ${jh_clk} ${mcore_clk} console=3D${console}
root=3D${mmcroot}
 prepare_mcore=3Dsetenv mcore_clk clk-imx93.mcore_booted
+kernel_addr_r=3DCONFIG_SYS_LOAD_ADDR
 loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=3Dfatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}

Tomorrow, I will send a formal patch that sets kernel_addr_r for all
the i.MX EVK boards that have been converted to bootstd.

Thanks for your help
