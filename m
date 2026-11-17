Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F184606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cHExeJ02;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gqmfql5N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB3A60855;
	Tue, 17 Nov 2026 00:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQw7b3vRwwnv; Tue, 17 Nov 2026 00:06:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DE2360841
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794873999;
	b=Fg9ogaUHygxtWv7WldlYCjYP69cXqVB1GmpY0rRULM6U2NErIh1skpjn5vjMFjoKKHcP
	 xQgiKucutryWn+JeohwDmwalax20tJCz20v0st0A+OycNmtIxCx3tXbC+2dYGF0rU6AHa
	 3uaghVyMbKcMkiK02I8UwZDLVYEStPN8uq5Ho4+vnh+B5x3evszPBtfxGTJla8kFLArfL
	 fEYS5HR0BkMFGbUHr6Jcmjzw53ODFeejrrzeansQx6RGSE7o0h7FpqMyh6VBR9Hr1bvJu
	 zkewQnu7XdVyZBf3LGdiKKQhudtPnKTBZnQUiLc552gCByd+3ErBPZBsjaP/QtQoVlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794873999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T09qSHkTPrd+2fRAWwKXsHVmw/kQ7EZZBvVzEv/3TXo=;
	b=WnzXKoLULj5FxLx4MX4qdcpemwEASQRogJz3g89Ju6lp5RCNt2LpL73jsjBrxG4g+Sp2
	 kWNixaHRb8h4nWpavxRn01hxB7Lr7GKymk5rzv61wdoYuFmaCEalWUZDCEFwQ1LVv/kL+
	 dDyeu5G/XNko3urH7K5lga892givvB66yeNIImPJ9QesVrpNpR+oOQnMuo6N2sTPrJ/9J
	 pPxidyqS2H/7kovniUkbpGzElMbvyLHsN7FwtvIBteWHtDYyi+vxtoaDBXc5JrKh73hkw
	 q3nzQHrMghquDLpUZ7n8Z0DIM3BzjjKvRGJcx02b//PMsB6MwALAHxP0pf3625EeDIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794873999;
	bh=T09qSHkTPrd+2fRAWwKXsHVmw/kQ7EZZBvVzEv/3TXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHExeJ028npZsTAzvFeevMTsZDWZKv2IKp25l7T5vMsuPsPZeW5HXw34PHPg53tnm
	 E49f4uOQSMpHBdXIRJRLMYthZ/HkaG+wK2Toode2o0ZldwN0TOdxB59fblgZriT4CW
	 Fat/cSoBjFNz4SfF0hB3c5Uk881SEcmrJjJjsWJwX7hbdG9/11bV7EEi4v04uvC8AA
	 fk4GVBOTDyimA5Kd6cf+HlScO/egICAbV+VlS6xNNJ+PwMLGW4hrylm7R1mhtKdX35
	 mX1utAIxJHDMIZnkqI0SfwWpxjLy2pjkMVzGATXC3AqmrSY9B5GF52URAUs6fZEjyv
	 Crha714tBEJwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DE2360841;
	Tue, 17 Nov 2026 00:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E3AC70B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F8FB40568
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z3j2mhobsb5H for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 00:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 802F040572
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gqmfql5N
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 802F040572
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:36 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-70b875f6f13so4183649eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794873995; x=1795478795;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T09qSHkTPrd+2fRAWwKXsHVmw/kQ7EZZBvVzEv/3TXo=;
 b=gqmfql5N0mGDj2fasayaFKiFMCjZ+J0mNzd6r+afRfhQVtXwRXASRZjoEj1C8ATDN/
 a9oxuM16qh3hqSSpH9bVWavDq4wLoukkIJ0Pi444CfJg+8DdfexM/lOLzuO7CL/1ydsk
 pdSxKrnEc4rZJfMb+ar6VWF0n3f0/h0AM88Q76qI3IIOsBwIlUO3SW272AuPGeIF9yDx
 lYeRsm/ysM/RhMrn+X1cAFYr5rj+AbYY5/2/1kOU0fmhiUmpVOmzpK0Uw6ADbivS6vN7
 N7MLRTYCeghfp++QChDPth9Ule6nCUO1tyI/cfVKbMRFmb0FxEbDuALMnqpMhu7OBNO/
 xNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873995; x=1795478795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T09qSHkTPrd+2fRAWwKXsHVmw/kQ7EZZBvVzEv/3TXo=;
 b=M0df5JeuyY34xS/KTFI/20IVrsNuRvOCR54pawvqCAkt6x9EN/N2rvcJnWdm8tl0fR
 mR5Fzw6J+qnTZ7egWsD2OO555lrylTRcNkYHZYapT2wMJICs1vbi/Yidpx3T05w/0Z5Z
 XOa2jLeE3a/svBgm3LF3dnXx0nYIY1hdRJqY7rLHcOfS2ymTOYPuKxh4064+CVX77BhX
 uM+wj/PZB+L+sWiqecLrXCJkCS7NzW5JCmeyoNUaD/NcUIroAoQHMOTqDoY34e9/q9SG
 OJ8u3K5setvTI7B6pxdE1biEhLHsdkgC8thHtHIAPxyAb7ZVxOZMFyylG9Uy9oOBcYw7
 IkqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHUkWcfkH3Cd9Wyi6/9oRa1t2uqxoZxSZNIE24IQMKAgb/Ync+scl0sf39LBZD6R7JHexHIhK0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ntMZq3Nh1uYw5cqnEnZOr6GkDnuOvBr6DjKwm0lYtHcCpzJ2G
 C7dEsMc8FVvN3+bM4KLW5+ki1l2Ld5Xc/Egi5XhHH42kVng6ADcmMLxA3xVz6DxFxMQ=
X-Gm-Gg: AYBFou34pAKwxz5Q002rviy6pVOPR3FpmslWwU3sm/hwAPiIsQMAz9jf2kpySR65rtZ
 pEUbpuDmGyZ7tDbfn/uOi+JFnpx+YbNa4YAuR2kCDfvwOCbtxrkd4IrR71TUJyy97Z+8CC0wUNC
 BmBH7jpEP/AEUbrGzrDXRhYNseQpfYjzOaOjBl/CQE7sBERDYxukAusc+BNbT1XLB0ek0+ECwMJ
 hfX4sx+VDGLY9GZv8Wwvm01smQoDjXf8Xv6lv1snybYjKgsviSNLzFIAiKv1m/Ol/Q8CzxTx0De
 jff/gn3YTJvzaf4TZ/JzY8MQ24xR4x3BjAVaBhvyILEP9ecTnAojgzlqT4j3jpwxahMiPPNWZUf
 STE00LRR/Xqq1aUtZxP43ZacInv+/bkavZrA4qtgZ2rSaeODSkULzWoroBEQFcl0SIVvK7tOcRl
 E/ghPgnxX8ab/QBzrtSdhikw9TcVYCEBEsQ3vswPTLb13WfZQ65f7IXWSAZXyVxkAsOq4M+Mu96
 PBNSG4i2byqnIlq+vPp5haJJGr9x9WQRahibyVmJ5JfOB/u+HJ/mXxpF5eb6bGQEukFNRwKBSp6
 GiJgjGTRT13cJZFLNVxemTQN/tDuXiXncQ==
X-Received: by 2002:a05:6820:617:b0:715:21d1:b70 with SMTP id
 006d021491bc7-71ab4d06633mr8236094eaf.4.1794873995179; 
 Mon, 16 Nov 2026 16:06:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862beb11508sm5097254a34.3.2026.11.16.16.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:06:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 18:05:55 -0600
Subject: [PATCH 3/3] doc: board: mediatek: describe booting Genio 520 and
 720 from SPI NOR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-genio-720-spl-nor-v1-3-7a926f80dc78@baylibre.com>
References: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
In-Reply-To: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rSbM+MgMuVgUOps2pgTmE7E5cCFG5V3800hgR8o9fEU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+5p4zE4W4GR4+4rGdRhdivF9/XslHPeqHhXBa
 qS9iOZcMSmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuaeBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWq8H/2iZKQL4cAooVutPBeWWljDU9uf02yYvyu5gHJY
 sZUGNeib9fZOjtPM7jsi9KcRPrvFWNqUKQVxJJTrFbpwYeiR54bN3/INw4Edguq7o2KGqP/Gopd
 zscwPnH43fdRwU6Nz7i/nq0WuhES0eQdF1A6LKm2aZoO8glr6DCeOdIscp+jMkYJaDfT/ppgb1u
 kI5rQbgAW8JUrsOTV/0VVSp/fx2rrHCeBTTN5FV2XRIMcuK2j7OW/9xKlkeReuqEcdIYEXqz1EK
 5oTbhQifuuejSb0lT5P3s+QOha+ZYHbCK3mrSupFwNiZ9iy6733MoUOuZALn//p8qIKrBuTO4wH
 MyPo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how to build and install the firmware images for booting the
Genio 520 and 720 EVKs from SPI NOR with U-Boot SPL. This needs the SPI
NOR config fragment and a DDR loader built for SPI NOR. The devicetree
still follows the storage that holds the operating system.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8189-genio-evk.rst | 34 +++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index 897dbd7cf81..d33ac8ccab1 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -106,6 +106,15 @@ variant of the devicetree, as shown below. The BootROM then loads
 ``bootloaders.img`` from GPT partition 1 of the main UFS logical unit, which
 is SCSI device 2. SPL is built without MMC support in this configuration.
 
+To boot from SPI NOR, set the DIP switches and jumpers for SPI NOR and add the
+``mt8189-genio-spl-nor.config`` fragment to the configuration. The BootROM
+then loads ``mtk-boot.bin`` from the start of the SPI NOR flash, and SPL loads
+``bootloaders.img`` from offset ``0x200000`` of the flash, which is
+``CONFIG_SYS_SPI_U_BOOT_OFFS``. SPI NOR has no on-flash partition table, so
+this offset is fixed. SPL is built without MMC support in this configuration.
+Select the devicetree for the storage that holds the operating system, eMMC or
+UFS.
+
 DRAM description
 ~~~~~~~~~~~~~~~~
 
@@ -279,6 +288,14 @@ UFS devicetree and pass the directory holding the DDR loader built for UFS::
 
 Use ``DEVICE_TREE=mt8371-genio-520-evk-ufs`` for Genio 520.
 
+To boot from SPI NOR, merge the SPI NOR fragment into the configuration and
+pass the directory holding the DDR loader built for SPI NOR. Add the
+``DEVICE_TREE`` setting for UFS if the operating system is on UFS::
+
+   $ make mt8391_genio_720_evk_defconfig genio-boot-images.config \
+         mt8189-genio-spl-nor.config
+   $ make BINMAN_INDIRS=/path/to/nor-firmware
+
 Binman produces two deployable images and one intermediate payload in the
 build directory:
 
@@ -308,10 +325,12 @@ Use the board provisioning tools to place the images as follows:
 ===================  ================================================
 Image                Destination
 ===================  ================================================
-``mtk-boot.bin``     Start of the eMMC boot0 hardware partition, or of
-                     the UFS boot logical unit
-``bootloaders.img``  GPT partition 1 in the eMMC user area, or on the
-                     main UFS logical unit
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition, of
+                     the UFS boot logical unit, or of the SPI NOR
+                     flash
+``bootloaders.img``  GPT partition 1 in the eMMC user area or on the
+                     main UFS logical unit, or at offset ``0x200000``
+                     of the SPI NOR flash
 ===================  ================================================
 
 For example, with `Genio Tools
@@ -323,6 +342,13 @@ a prebuilt Genio image for the target board::
          bootloaders:/absolute/path/to/build/bootloaders.img
 
 With a Genio image built for UFS, the same command writes the images to UFS.
+With a Genio image built for SPI NOR boot, write the images to the ``nor_bl2``
+and ``nor_fip_a`` partitions of its flash layout instead, which start at
+offsets ``0`` and ``0x200000``::
+
+   $ genio-flash -P /path/to/genio-nor-image \
+         nor_bl2:/absolute/path/to/build/mtk-boot.bin \
+         nor_fip_a:/absolute/path/to/build/bootloaders.img
 
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path while testing.

-- 
2.53.0

