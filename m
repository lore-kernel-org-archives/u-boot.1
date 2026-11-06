Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C6606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YUWoO0bT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ekZeDNSu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F32E860DDF;
	Fri,  6 Nov 2026 21:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtDK3fVFZT59; Fri,  6 Nov 2026 21:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 831DD60DEC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001029;
	b=hZZZsllirEzG1I4s/peoDA7qVaEEOWGUw4dud1vEBM7Xnn46hr6zFe+H7KZ24eMnTd/j
	 tIUN1v7oS2HKfWNwHxA/ry6//QdkF4qAFA3IhSnvG1zaiWvuefZKSBQWa2zuvEOWBCk9k
	 gBbehIcVacSNKGUNU84ug11+kBdZPRrRbiAwf27N+qJSCn624bE+8roqCBriCuXEl5ya2
	 SmhtGbgURvFQeGT6I8TYFhrvP8yLMN1s/gIWwQem5ONB5J2zY3nx68k76p2qCG7nigIAJ
	 70SlFwftSW29VCZ5f+qdY3WqSGFMFlBMD+a8XlqzATmABjAJ8ev0R5oGrRQCY6yoyUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GJjcgOsKpuJKP15cUQ4XDuzPJWsejbjqzeev2K41ppM=;
	b=RB/4j38xNP2OrpCDPk/cN3J3b/kNZlenrc+CpW7otTHdWpFbsZJ2SSuP/kD5UuTCnp/V
	 pinA7bxPObdjoE+rrZyqVwdQj1lR7ke17iHtG9htOgJbiSr99zZgf7SI8DtmNfKvWGmec
	 zREVurXgBHxuX6qkHUZbcxg2FaQbUgnplun+Tzhvc193vJYqnoQSOrSF4jmYExhLqamXe
	 8ycm7pPK+8oeickjk9kVawXQMHSgrUyXfldLFYK4U5Yb6V8S5EBihInaf5fgdh4IRd58e
	 ot6TmrWPxr82RtaY1CU/A6eFVNeMUhlViN71hpy9mWA4s6eHmheGa9AxnvRJV8LBuzA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001029;
	bh=GJjcgOsKpuJKP15cUQ4XDuzPJWsejbjqzeev2K41ppM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUWoO0bT+W+cvbIBY+5h/F/9aJ6dNlNCnjM7qncrEsnRxUphK6EhH1ZSEXJMs+Q93
	 nCzDKBhTYR18c/zEICRMTFPLs9sdokZqlVM+0SAayEMbqcmeftAE4mMQGPUpv/kbvY
	 fHB1BHGswe+8jAaY0rpmMxAttCKVNmFXOh7G/GOiwEuk2chHKiJaTAumGtAWWhW5yg
	 bpX+vwSI6HMm/rMN0OKWdCrqvujN9sX6P7ZHsGgYevgEPvMGzFSm/FzGGFJ5IpL/Cr
	 fcaauXhEFI1UGQ2sn4LYAIHPlGhauMomurHSmeFe/y3cg1ntW3pd4QRuB5ue7/F2qH
	 nnrjlg7IYtb8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 831DD60DEC;
	Fri,  6 Nov 2026 21:37:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E1A31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99D9D40401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ieEGJY0tQgRC for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:37:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C2D20400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ekZeDNSu
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2D20400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-823e4047037so739682a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001023; x=1794605823;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GJjcgOsKpuJKP15cUQ4XDuzPJWsejbjqzeev2K41ppM=;
 b=ekZeDNSu04nhI3h68of3U84i/A0kIWIB5lBdynLeUWfjUINfpqlr3KaKArBECDBobj
 LOGQ09Dfrk8oFZtsmkuMyeYKp0M7b958Zvh78BjItsYZFriHuKFORQhupJAAJK7ad2Vt
 Wb/HaEgA+G7V+9dVTQjDeaOwIwMkzojh+fljYl8ooo1OseQZ8Uk+6cSnoflKVJa0oK/Z
 mmOD/p/uXi8UhFqb1wqNF4FNPo0dc30ciCjIzg7IR0kyu1Kt4+jGQgcCQrgw+FydwFt8
 xsPoWnFi2MvxuAXYRdKQrC76dcn1B5q43JKEGJeIgfAMX9IG19m6H/cjiflRD09Y5aDx
 qmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001023; x=1794605823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GJjcgOsKpuJKP15cUQ4XDuzPJWsejbjqzeev2K41ppM=;
 b=kSV3sw8clt3OPrSy33tHLml6IJJI6TCT6lydMM7Mt3+U5bc32jrMU6KcC0tqMio5cq
 fPLXv4Q4zH7XamdpN7haVIe21YN7tggcPiHkOjSSWM5wDGaXH/ygCWKt17HMzyjG+qBt
 1j2W7IkfnlqgY6/ijovA22T8dks6G6wKW85faLGssi4j5/5uW/suWO5RRhC5dJSxVLFn
 99zb/e4GCRpQxzi0fqR2YhHiRFtF6wh/KhDPcmrEtkU2SgIX2GYHw3MWXdXaHknl8N9Q
 4bXfGB/yNDAzL1eHTrMU7Txt8JhQpAUqNO1WHVzjRj30y1cjtQVst+nz3w7ZF96Ts2UC
 gAuQ==
X-Gm-Message-State: APuU4Z99oVeb7pkwQlfyFC1hoyxz9IL2qeT4V5//1W0WPqifZ8cfHJvm
 dVz49hwHBq5Ev8euFYdPxttK04oQMfz9IhxUdbqey6jd8bawyU0nCQOIMczLCKIq3ck=
X-Gm-Gg: AYBFou0gFRyn0bgnD1EhgkPymLsvgb6Nt8Tr2+sXt9864qLqDMk4ig210y4l6BTcsbW
 lq8ZPjGWulqIuhKeog2sC4Tt02rU9XCyHQPv4QgwaQ+1pfxZCr9c913XAtSeOMcs23raAW/Umwj
 pvUUC4iPTyWkAx+g+LY9aMlSr+ZdgHOyGN0j2eb0N0XThlLIEltqOUv9bwExpp+5F4LT6vA5lCl
 tTSTxxKdTWZ+6X2sFlihbRTIwbvtvEjQ5TipXeKDInGJs1Z4uEFMSEMbD4LeSQ9q979CELTpkl0
 PqRzppLp0nbR6xWqLCjv74D5Y9UfrtXtUaSdLURJT/57pAJ+nTmyaoau6oH/UqCShQqckWBmDkv
 JhLZfWa2yNogUd2bojbajwAzzE5Oyu/Xv570ggc9GPuq5+v9Kxvl0eK6s920Y3rzydwra9MTWXg
 B7oZ5JQqzvVWVpZvsDJqHCYN4zCqj7uNFbYQpQe8bujdbxQLGB/Uh8mPztIpwCePKiTnlPCDOBb
 3XSeIl78bvfDIRx7xgmzojAhkMRly1VQf608oMvivaxfcYsqvc+ne/v9CtyiZe7+mU6TmV9wf02
 WY9sfQBdcPr3G2iGm9CDJ7koowDLsDzp8Q==
X-Received: by 2002:a05:6808:f0d:b0:549:572c:fd42 with SMTP id
 5614622812f47-567e13616d2mr2633621b6e.47.1794001023062; 
 Fri, 06 Nov 2026 13:37:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:37:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:57 -0600
Subject: [PATCH 7/7] doc: board: mediatek: describe booting Genio 520 and
 720 from UFS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-7-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l41Byt19JTRkzK19BZRDQ8K2zFA4tsDlHbetiMG01sY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khoTiS7MVj0uYsgFpnp4OUF9CUCp9I9C917Z
 SClfNkn3UCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IaBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZLcH/A/MLkw2F+lkRQq43Yyr3nrcryyslbk19jkdRmU
 N1U1WPZdx4lXXEm8KySHq5ydQ3kcPTYqyYIXUihmcPFD0p1YfVrNAbLojepO5hpIgabfP+CzAnX
 s4QG/GRiL86eIvS3YORfwOtQXqoMoXp0aE67MvIOSh5jrYpv8mmJfBs9Pf3qaDLi/BVfPxsNZvj
 l9PTJ3QnASX2o2zmbhMa05NdLYzxh69Yaxqk+N6Rch7kKbJ5zTZIRx/l6PGk+81nGm1P8gfPEKo
 TjFRTheteZKq2k3qnhk6dJZNCcRaYie4bIOxgKrx9PGJydURvXESpze5RuipVDTO+JlVtNT6W+u
 RMvI=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how to build and install the firmware images for booting the
Genio 520 and 720 EVKs from UFS with U-Boot SPL. This needs the UFS
config fragment, the UFS devicetree and a DDR loader built for UFS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8189-genio-evk.rst | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index 637aa21e271..6879a1e9060 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -99,6 +99,13 @@ by name.
 Make sure the DIP switches and jumpers are set for eMMC, and use the default
 devicetree.
 
+To boot from UFS instead, set the DIP switches and jumpers for UFS, add the
+``mt8189-genio-spl-ufs.config`` fragment to the configuration and use the UFS
+variant of the devicetree, as shown below. The BootROM then loads
+``mtk-boot.bin`` from the UFS boot logical unit, and SPL loads
+``bootloaders.img`` from GPT partition 1 of the main UFS logical unit, which
+is SCSI device 2. SPL is built without MMC support in this configuration.
+
 DRAM description
 ~~~~~~~~~~~~~~~~
 
@@ -188,6 +195,8 @@ Setting                                Value           Size
 The DDR loader must:
 
 * initialize and train DRAM,
+* when booting from UFS, leave the UFS device powered, out of reset and
+  with its reference clock enabled,
 * copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
   (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
@@ -200,8 +209,8 @@ The DDR loader must:
   register convention.
 
 SPL obtains platform information from its embedded control devicetree and
-initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
-drivers.
+initializes the console, clocks, pinctrl, watchdog and boot storage through
+U-Boot drivers.
 
 The MT8189 BootROM loads at most about 930 KiB from eMMC boot0 and does not
 start a larger image. The loader and SPL regions together occupy 896 KiB,
@@ -221,7 +230,9 @@ firmware images:
 ``ddr-loader.bin``
    A MediaTek DDR loader which initializes the DRAM fitted to the target board
    and satisfies the handoff contract above. The input may be shorter than the
-   configured loader region; binman pads it with zeros.
+   configured loader region; binman pads it with zeros. The DDR loader reads
+   its DRAM calibration data from the boot storage, so it must be built for
+   the storage that the board boots from.
 
 ``BL31``
    The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
@@ -258,11 +269,23 @@ Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
 set for both configuration and compilation. Do not deploy images if binman
 reports that it used fake or missing external blobs.
 
+To boot from UFS, merge the UFS fragment into the configuration, select the
+UFS devicetree and pass the directory holding the DDR loader built for UFS::
+
+   $ make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
+   $ make olddefconfig
+   $ make DEVICE_TREE=mt8391-genio-720-evk-ufs \
+         BINMAN_INDIRS=/path/to/ufs-firmware
+
+Use ``DEVICE_TREE=mt8371-genio-520-evk-ufs`` for Genio 520.
+
 Binman produces two deployable images and one intermediate payload in the
 build directory:
 
 ``mtk-boot.bin``
-   A MediaTek eMMC image with load and entry address
+   A MediaTek BootROM image for the boot storage, with load and entry address
    ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
    ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
    ``CONFIG_SPL_MAX_SIZE``.
@@ -287,8 +310,10 @@ Use the board provisioning tools to place the images as follows:
 ===================  ================================================
 Image                Destination
 ===================  ================================================
-``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
-``bootloaders.img``  GPT partition 1 in the eMMC user area
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition, or of
+                     the UFS boot logical unit
+``bootloaders.img``  GPT partition 1 in the eMMC user area, or on the
+                     main UFS logical unit
 ===================  ================================================
 
 For example, with `Genio Tools
@@ -299,6 +324,8 @@ a prebuilt Genio image for the target board::
          mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
          bootloaders:/absolute/path/to/build/bootloaders.img
 
+With a Genio image built for UFS, the same command writes the images to UFS.
+
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path while testing.
 

-- 
2.53.0

