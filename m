Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8DCCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 11:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9422A8466E;
	Sat, 13 Jun 2026 13:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ayjmG7He";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08597846B0; Sat, 13 Jun 2026 13:55:28 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC1983FEC
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 13:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5aa612bf6efso1602123e87.3
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 04:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781351725; cv=none;
 d=google.com; s=arc-20240605;
 b=YqQT+mtgnGqbl4WDsRb+bICuCP0297Fpy8dk1TwfKQ93kffeHd/7hb0k1ySix8vJvb
 HZMFDdETp4VI6T2oETdvhr7rDtCJjgDallYztEA6rid7viyfrf+JoFsh1uvQPyioAOE+
 eE9R3dTTXMHZzLp3KuSMuiRTdTaH1G6PylJR3nRzuQvaULIzbg9rqBjeYMxmAYAOacr3
 5q/1q8aKmXHLOWtFHLBrTkeD8e1mCDgWlM8F1kfE8re4Q5xt69ApVybC1ivwcGx2y6c1
 ZWnLtiS2We7Ev6yyGNaLRrLCvh6Jjz8ZQyPdO1A7DI3RXpa2QXNRl8GNWqa1Pv46qy+T
 Mi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=wMzxS2l5XydzzRMQCVp6tUAWRnpwVWFBDPdqRC2a0f0=;
 fh=IMFaAc2Zke+u6yiaMfd0GzzSzcCGawo1pukQs9uw2ic=;
 b=CHZsNbchspfff62L1u+VlrCDT0Zth1Xm86fjcYCWZYUVHncMfTqlpJM7zsWP2NnU/I
 IqP/3Cnw0ZuD2voM9qU2jX6mqLRiZsVWPXvQGDY2mnBGB17y3cgs8sToV6I7ZzcISPUP
 H6xHoLR3PyojJKRQ8qw1pdTkLLXDFdf6TFkZJdHyA37foRcxCM8su7znNfxlVLsle1zZ
 kH0145zyyF7hf5vfsYZ8H6wKJTxS8Gxizexm0IM9uKU5fMGyQAa7bM+c0HCVFq6uNwRv
 ODJ/O02FOc9A9UiXaabUXGLnlClGBUBuphAMERAEql9l8aByM8LtFilwgI7zzdRTPTHA
 nJjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781351725; x=1781956525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wMzxS2l5XydzzRMQCVp6tUAWRnpwVWFBDPdqRC2a0f0=;
 b=ayjmG7He7n85sc38sVvAr3vPj4itflNA9FGIPLu5S1oMNh20Wms0Lkoq9HnZtSTwBz
 Zx7KJBUb34Nx431rHqqgvK414Nssjjjm0CRlNvdU4ZXWuq3EABZOXeTJXqfnAkP/puu7
 Vd4l35y0F3JEn+0Sv3luhh18x9JIgEAK+sVkqwcADtalNKokU9DNPrSO3WO+IZNzRWUt
 vveZdwz4A9/QUuGYM7AiTBRk0iNamCv/lnjLjQD4lk/KfVAxBrXQ6IGhTH7hiFaxAPZj
 xC+VCrBe8YP5I3ZO+qPisWfODeCpNyeUPOLtaVFnAZMw/Jej6z7rbS+FfWLLbujw8vGY
 k31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781351725; x=1781956525;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMzxS2l5XydzzRMQCVp6tUAWRnpwVWFBDPdqRC2a0f0=;
 b=OitDcEqLt5+2anDmy1Dwuxhh3DcQcBY/+z/4IAtArwbY1VaplenO9oaGJVx8UDriPo
 Y8pxTvkbJvmFTFRyJxBrgnPjrI81hQEktyRSAWe1BD2YWO7KgPDBuigrGXvvbLMlB+np
 9nGmSIBg31MooIAKMejvjis6qQ7EVruneoR/sqMDKNR7zoEGwmtlrsV77yQF4irzV700
 r5iCflzdWIVZiHtdYMRDpmQsdfChdQ0M9OENLLY6DL1b5SY1+jsiqImQMZ0YRFXuAC7O
 56O3k+5nCx3Lg5NF1by0zsxolYP5ICdwWpd3hm7QV784sN769BNfDuG14jYdZfySVCSS
 HKbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tpsasx2eZrO1SB8pS2TDrmXx2op8q29uy8QDjE3rvdmGhDoT04o9kCPQ9v4nPp5pTiiQ1qXo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs41xKIG23wtIz9V7GaTDbOpjWpaJQUz8ErcIybcQS6t1Tsbs/
 g7OTHhJuSGHh6SmDpbGEgCR6d+RCrm/J2ISYggmzQnG/wfMfJTEwbP++nZk1zhikzXadd9lNqOr
 NG233BMQc8oYBgoTXBHvWaipxdS0HHoU=
X-Gm-Gg: Acq92OG1z6nlVgXSiZrNcaAap7K/dhC0Xz+3MXzAuxuxDuJHZXO9B2h7Dh5hNRDD1pR
 qRYlui0IXnFtZGsq2Wnn61xdIWrWB46t+Tb6ilX98y/qfgsTXgYqcBx9AzJjQ92ye9MkVk+1fpd
 G0zU+Zvv5/9svr+Febsg5FfOeddIrgjBLvVY8N8XqUNPv07wfo+JUrmJNh/9j6w2yzbuZhxJgdx
 mIe1nTotj3tVFzyQlpueodYOu/6ApEuiOoOjHhtWe0vuXp6n64UMHnxkKoVMB7N7dh3dwW00fZl
 XMTD8swYDaz+5GdIXyj9naKjkDv97Oac+1HlLvx8T5QTOeZi9CtQJ7T2YwK28+IP8ZsFkbwC
X-Received: by 2002:ac2:4c12:0:b0:5aa:8822:b1ec with SMTP id
 2adb3069b0e04-5ad30dddcf2mr561693e87.46.1781351724869; Sat, 13 Jun 2026
 04:55:24 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Jun 2026 08:55:13 -0300
X-Gm-Features: AVVi8CcVRWY1SBYJ2U-HEXRt0kgQeQ_-L20DXsvO5yq4DwESsjrAS5nIcp0ory8
Message-ID: <CAOMZO5D9ndCxsDxx_pBG+_DfZFSviLfvFwmdPxngvQPOC5qfaw@mail.gmail.com>
Subject: i.MX95: Secure Boot support
To: Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Stefano Babic <sbabic@nabladev.com>, u-boot-imx@nxp.com
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

Hi Ye Li and Peng,

Could you please confirm whether i.MX95 secure boot is supported in
the U-Boot mainline?

Are the changes below enough, or more is needed?

diff --git a/board/nxp/imx95_evk/imx95_evk.env
b/board/nxp/imx95_evk/imx95_evk.env
index 19f9bd5c16e5..596c819a7d1e 100644
--- a/board/nxp/imx95_evk/imx95_evk.env
+++ b/board/nxp/imx95_evk/imx95_evk.env
@@ -1,4 +1,8 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
 sec_boot=no
+#endif
 initrd_addr=0x93800000
 emmc_dev=0
 sd_dev=1
diff --git a/configs/imx95_19x19_evk_defconfig
b/configs/imx95_19x19_evk_defconfig
index 542b71f5c075..313f3e8dec03 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -1 +1,2 @@
 #include <configs/imx95_evk.config>
+CONFIG_AHAB_BOOT=y

Any pointers on this topic are appreciated.

Thanks,

Fabio Estevam
