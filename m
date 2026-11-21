Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96918606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qe7CnBvy;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NNR87x/m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0DA40A23;
	Sat, 21 Nov 2026 12:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v310t71mZjsK; Sat, 21 Nov 2026 12:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04EE240A7E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264555;
	b=HIgnj4+g7CevrNc5mVN7xdA+Ao9wGgy8sMyCPSq5OURI6AokuE+Ht4P3O8cg5eRQgXxz
	 uICTbY4CPj3PrOtfOQw/HGuS0oUIB98a0ZI9+FfZizNXN7MEELOXfvNpIjaBNQ2zIVFTL
	 Sst1ykEwn8vKeYdBDRELVDM0GiEA9Bj11VlyCBuBeBlqhd4oYm+hI/xw7EMqZh++Pec9P
	 81Lw/SXHj33Rzs2jVbWflICVxNzIaC/GvrCzfUXn+8cUxnxMe9rk5RX/bItRH5JOCop3h
	 tKo9JBZ85cz/HryC/KQ6CdPFN7Bajru4xEFUpZZmq3xEQZlX1/AYq4kCuawEc3kFUzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gy+Prt5mqtqN0v7KQhVmImZULDVPHqy6qf/puUt/Hvc=;
	b=jLKjFvCLfONnEKXmneeQWFddOIItViKB+ZK/1sgLdDrYlb9s9YL30ejsnKN1LhqjPAKo
	 CtnYstieHdNmu8He9T7p0srg9dOtmEZ51AwEs8LQs8k4UjfdQer4giSFjNZ++lt1lnTYC
	 D7m392EppRPgdO3FuFPN5s2Po/VpLaS0NobOg/yNQiV7VuQYkghHMGJWA8ru2iur0in9d
	 qZZlazSfOkq6lrPvj1RQNj6duko+JMATZdhffayTx6QDNYnP/R7J6dAgesJJYVtyjRGrH
	 3J7oqyZVhb6uUMkmQ9GdwDQEdRzWPrJhuMzFKTGFD85jah0rbFAc6Dklrv5wZFsMoZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264555;
	bh=gy+Prt5mqtqN0v7KQhVmImZULDVPHqy6qf/puUt/Hvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qe7CnBvyE9hhzOGEmKsn8n2xk+I/9QAprb1bdX58thfcAfSjFKLWkQLNyNvEJYrmI
	 Z5E4LOzsJmaPP6o4mUrDFnlz7ZBqtND4v0snyubnYCE5LPH1x6quQKCstGEdmJtqHn
	 M4xU+kdXkGSOBpU/tCSEFF/SF14Tq5QOX77mOwr9Rx8rIZx6DJLLCcn/U7+bXiyfUY
	 RVGyMZhL3Y8FngRh4DzNcLrTIqA9spJxuEDhK50xqg/14HLuGfgLAs2mKVF5DRfpZN
	 feJiqRUqkp87Irtd5m0RaGc1sXlKZ29lE01BCFpskLkCDxjfYaoM/gEOJLBsXr9fOz
	 i0JCs184FiBQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04EE240A7E;
	Sat, 21 Nov 2026 12:35:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7361A3A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 656B480E8C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sk4Z7Zn7Ffxw for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4204780E22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=NNR87x/m
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4204780E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:49 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso1205599f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264548; x=1795869348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gy+Prt5mqtqN0v7KQhVmImZULDVPHqy6qf/puUt/Hvc=;
 b=NNR87x/mT1mGiJtmhcr0h4KW1NbvOxGMO1CO3mSr96OV4DxxIZHrEldwGSaVQV6KE6
 R+MPHA0a2JsrtwgQtHpaowOydeChvdcnxaeIcjbXt8IN9fA+jteWyLpdK9bv+Hb5dCwS
 K02goPE1wC1BVlg8J/Wsta04/4grmPS3HoqpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264548; x=1795869348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gy+Prt5mqtqN0v7KQhVmImZULDVPHqy6qf/puUt/Hvc=;
 b=dWmMpyQ1S1zOqhpYvn1k3qFYV59FC5+xfZBRDmhbHfux89BLLjVssV8Smq4RaoX4ZM
 TfclkVnAVv45dZKPoI3kHTx0WANHpnfM+Y+7dl9glE7h/0aD31pGZzJo+khbAMz65AB0
 qHbYPZCJfpYWnH2PF0TjJtRbNKYgLQrLprzWPq2goQtCGOesFyPyWrDtMfMBS29Fofg3
 0kiVwzx/vPH4h4tDSj6yTHx0sVRJbonmgUUJx4wkd+QFFHvjUoJDEz15lz0L8QBg36dV
 wcbcnNWfBDeUxfClRAGpCC9xBCn8p1gJFHdUUQnOomH9y0p52Vosx5Zk8Cy34kyFvyAB
 9TLQ==
X-Gm-Message-State: APuU4Z+IKwDS6IbLFvi/7sjWBQ0FwU2E6eKIU5kLeXlkMg5EAInz4BdD
 WbtEpcsekswMhGI1cNF5FVEhK2ctENLkXTWCm09QbgyPSvJZA5NaZQYacLqIbV5GjmXo5l+Pqr2
 Ah7Nt
X-Gm-Gg: AZFdTZfb5Nh9DrOgs/9Xhea7N4pwLox530Tl9RIxWC6YpauNE6jfeRM/fj6goTOht9Q
 hBtMDCxOp2yaDEXxFY6up8xDqkO2w+eKgsM3Mkb4rJiJ5dpfGkGH74l/Pb/PQ/xsyP62/tI3us2
 L287+NnXYcYg9HPJlO1NzEEDpLdmjZSvw0ihpktfwu7gAPxaekOGDzz+Ip4QKw1aJqwDx31HxuL
 X8Z2LlCPacHztlV998sc6n5b/+L8ZdbqabIdIPKTZ5Cw3zBjm7urdeJUQO03vHJh76xsnQVmQcF
 mMnzz/MHNSHMCkvhqdd61ilq6Z1wb0VrysxdWb2Mwd0aLzQIa/9tWHkGGfW01uEnSOemF3MjOj1
 lXw+XatHN1u7Vwm0RFjrEsfnMG9N1qkY4CCgzHaFcm+Gf31/TIP3XvrPd46YPtZ48Ce5rwYJFnY
 zTANs/8en6e+eD3B21PixeoQHNzr4s8Q4x4UnpFmwpkPJ8Q9sgRbH6OzncOBJNDbr7MLEC2q0Nu
 eZeG53/aMPigODIlNFOTvZC6aln/n9KClIaWkICMDc5rMM54AYNtEtBJn5Eq/x9/Z4CijXbarOs
 m5n3tnQo/eA/JZ+igq5ll4P1vgSxS77q7r7cRKc4PUp0UKefoKhlGNZ+4pb7hcc4WIPESAi6SsW
 Rfx/8OhsVIlkomb9zyXZ/ThzbDBkk0e49ezjlSb/RBljXMXBYlHcBsxX0RIQbxKyccnEmN52faG
 9nTdLC/+bcCujNBozmhlYa8L1pbw==
X-Received: by 2002:a05:6000:2583:b0:4a4:ee9f:a3d2 with SMTP id
 ffacd0b85a97d-4abb85f09c3mr12402733f8f.55.1795264548092; 
 Sat, 21 Nov 2026 04:35:48 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:47 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/25] imx8mn_bsh_smm_s2/pro: add splash screen with BSH
 logo
Date: Sat, 21 Nov 2026 13:34:15 +0100
Message-ID: <20261121123451.2471185-26-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Display the BSH logo with features VIDEO_LOGO and SPLASH_SCREEN on
imx8mn_bsh_smm_s2/pro boards.

With CONFIG_SYS_VENDOR = "bsh", the logo bsh.bmp is selected, loaded at
the address indicated by splashimage and centered with "splashpos=m,m".

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 configs/imx8mn_bsh_smm_s2_defconfig        |   3 +++
 configs/imx8mn_bsh_smm_s2pro_defconfig     |   3 +++
 include/configs/imx8mn_bsh_smm_s2.h        |   1 +
 include/configs/imx8mn_bsh_smm_s2_common.h |   4 ++++
 include/configs/imx8mn_bsh_smm_s2pro.h     |   1 +
 tools/logos/bsh.bmp                        | Bin 0 -> 10644 bytes
 6 files changed, 12 insertions(+)
 create mode 100644 tools/logos/bsh.bmp

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index fd463981d91f..ac61617814a7 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -121,10 +121,13 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 304e8dd0266b..6e42f5451608 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -110,10 +110,13 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
 CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
 CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
 CONFIG_VIDEO_MXS=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
diff --git a/include/configs/imx8mn_bsh_smm_s2.h b/include/configs/imx8mn_bsh_smm_s2.h
index deeed9c2f582..c8bd55fd3744 100644
--- a/include/configs/imx8mn_bsh_smm_s2.h
+++ b/include/configs/imx8mn_bsh_smm_s2.h
@@ -38,6 +38,7 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	MEM_LAYOUT_ENV_SETTINGS \
 	NANDARGS \
+	SPLASH_ENV_SETTINGS \
 	BOOTENV
 
 #define PHYS_SDRAM_SIZE			SZ_256M
diff --git a/include/configs/imx8mn_bsh_smm_s2_common.h b/include/configs/imx8mn_bsh_smm_s2_common.h
index 204fc4b31647..5d6b22e04139 100644
--- a/include/configs/imx8mn_bsh_smm_s2_common.h
+++ b/include/configs/imx8mn_bsh_smm_s2_common.h
@@ -21,6 +21,10 @@
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"bootcmd_mfg=echo Running fastboot mode; fastboot usb 0\0" \
 
+#define SPLASH_ENV_SETTINGS \
+	"splashimage=0x5bb00000\0" \
+	"splashpos=m,m\0" \
+
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
diff --git a/include/configs/imx8mn_bsh_smm_s2pro.h b/include/configs/imx8mn_bsh_smm_s2pro.h
index 8619fdde7fdb..dd26e0b885d2 100644
--- a/include/configs/imx8mn_bsh_smm_s2pro.h
+++ b/include/configs/imx8mn_bsh_smm_s2pro.h
@@ -25,6 +25,7 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	MEM_LAYOUT_ENV_SETTINGS \
 	EMMCARGS \
+	SPLASH_ENV_SETTINGS \
 	BOOTENV
 
 #define PHYS_SDRAM_SIZE			SZ_512M
diff --git a/tools/logos/bsh.bmp b/tools/logos/bsh.bmp
new file mode 100644
index 0000000000000000000000000000000000000000..5b6fb1ebd50d70c7f5ce4a51042271e9634d8d81
GIT binary patch
literal 10644
zcmeI2eOy%4)_~XQUh}nk@sis0dX-ZAhBT2#Ny(20Qj*A^GBYuaRLsZ-%1<&s((=``
zt{GWmp;?v|R#;eMWQ9c*Rv1NP)bu?~Uz643efB<w!I|d&_x(eD&JWJsXFY4Jeb!!k
ztuu}ucSnD*KP&$#GM~Q&9VfCzMO6NWkH`tVMP6+0eC&W3lp`(w?8WHx@z<5?`Ke!S
z<;f>?U;34fOib)pl9$(KWM1C!Wg9lM8-BvOf9ZAE>cQsbmLJrG{B%F1r}XIFOJaNU
zmY%VFq-W1Q(yM1*>D{ZJ^y%GS`u2&FetqMmf4@^Du0Nl+0TLfKP)?0MO$MAgNCpl_
zkkbYZmO-Z_O2QyM38%~8gd|BEe1@E!I7E_8A1Y@gCCiXAl4a<SGiB(|VUj#_xSW}s
zBE!x+ONI{{At}R0$XO{PWyD#dWW<QkGIGS(GHPV1j2?B4oIN^CQqNA4b5heK?VNKZ
zEp3dXr;n9$(=%kux#!8)G3QCf*l}`RMy8BA?|d0IE=w{qFOc&y$4l1v<K=>^3uXKT
z*>d6d9Lc`$BFWCaSaNbMk&F0Te9;8C<l;+Z!X*>s(g~Nz#7ig1#EF;7WtUBsNqjD!
zlq-`jpCY-FuaGIZQ{{>&)8vXPu9T@$uas%i^5n{CS4rNL)8(qX88ZE<nKEN~zRZ}B
zFEeM(lKlLuWmf)dxq8+$GW+TRxn}mYQgF>2DJYmD*Is*_%$ZXt*Uh<J3a=}Y>kEse
z==vL^xQI{jjdH^cbLGYx=gHg~=gYjg3uOMhg|cA&LRq+Akt|$TB8wK?Bqb$_<))i%
zmc=(Mk((DUktH`Tm8DCT$<n3EW!bV@Wcl(Ha?33%WyLMG%E}eD%B?GJliO}xCAZ!7
zzp`r8YFWMdc3H#c_BCr|?d|Ji-P${3-MTyFjywJ%ciy>P*8k@&xoiCf*>Kn0a`%Q(
zx%=*Wq_lLS+;h*pvT@_Ra_`3b<i2~$r0l-?<^Hlwa{v7g$fivX$^#EPC=WhZF6HH$
zWpnu!*|PZ|d1%X4dFY{sW$V_5<>7}Pkw+fcCfl|>Dvxe^Odfl5yKH}Khiu=zLw4+V
zTpoY?33=j)3aO~rDLX5klqYvSB~Ly1v^@3H)AIDwl~P%`OLpygMxJ@*S$X!EDye#Q
zx9qOsv->%D?z!jX`RA*py7~oq;e|c2XU~iBBA=QUYow;;C3)$ky|Q=j%kuKeugEK}
zyehB0S}V1D_SNo_efwUM*Is*FUVpt#>gwK*H{RGU`}gmcH}}6OZ@u}Jy!BSS)Yl)7
z0|(xgx8Ht8-g)O8dH3CSrQzKMIoNPe4jz0@-g~c68XMo2_uqeCKKS4RX=-Yc51T%e
zk3RfJKKkfm`S{~Qa_G<}^2sNkNON<ueER99^4VvfiRUwqcs!rW=bwKeUwrX}eEH><
z^3_*g$=6?hE#G|ejePsfxAN_`Uh#Up^4)jeiO=Vg@4x?Ee)!=B`SHge<)<HilAnJ1
zS$_WcXYu>}^2;y3$l=3><=0<-mEV5*jnD7$`|rO?AP|s0{`f<V93hXmKSu&b0)qpj
zm1Dn;t;4Z6IJOV|kMqET0rekWs}1=9_3^uLK|nqH_S{BnmIpMpjc7;p&*U!c#NWM{
zuRC5e*PUO?-&>KL#qVn761XQyeYZN&hg7*9!~8zxr!v2q-=$`Db3oIXQ*C0_m70%k
zZOiB|_l_;xy@Yuyg>(+r4J#dK$DUYb9hu?GS2AC0=C`;OF>7U*i-Frk53g`$tq;uZ
zG!o3t<9CIbdnllTxid<=DFJQPI^Crey7jnn-Ksluj~-NCY(Tpi7E%YTe_5{FS{NIK
z1higDwNTTvo9f?1WB6;H?o?k)K<64Q$fY3PRz0_%Z(5*Bq9*?(RWmh5C+I9K(RJvm
z*5;F2JWEbAmaNlk?etG0m!W0q`*(}>?7;zDc|wjZ?-|hYzvZa!9|0{x&nk!BN3<&v
zi?p_DKrd$ez-flNR#Q~FiAHOI9_kXbD1r4lK{ONAg1?D+VEME?*2X)uIO9*D*8R&_
z>!JYxt<_v@*TdK~TRoj!-Qk?*fKEks?Q-k!sph$7YAtuWPbDtEIuFOz4!Z82MrRZ{
z2S%XOK$+oCP7_wda}t&^w!L3Kt27z=Qni^et8Gx2Hzx+PFWhMLEwgqEG7(YPDWHw^
zIcD}Te`O62?W7fq8eRDj7|R(icL)i_la<^%3T_*1?iJ82+7`=H*E8y9^Rwb1tBM`X
zR%5C|NhHcU26PkL6%d-VU1t-4(b^sRqEB*Wt=4c-hk$0FS+#Mg_2_g6jQKR0(YW5k
zb+jRk)H%e=9?1UV&Fn!UY%X!x<{!if_dC|4MWAoPrbP~$c*r<0hc!>tB<-(VI~cuH
zNKfaU8tnFI7veoui+B=#eDvsY?Gk0~+7Yy~X<*n|Fyrjx?m;b0M1U8@3gWhHd(qC?
z3~eu3^6+RwI}>Y@bT`rC)#-MRMQH<f7+Xui`K;?4#;cat^}&ZGc8*t<X(uepM0-3d
z)n0v&2XbE&QQX8%sn)Lek_^?cu15rJJ@-#&<#sb3PlQ^H)Jo>cU{?Os_&>?+=0h3}
za}~1%#v=AkNK_CnN!Zd(y*CGKB?l}+W(YDKZNuzHVl?A8(FCpOVaEF6QM7v5U&fkA
z5t!>4U*AeRC7^{6s~~2<BXY3v04usc{p|V%je=OhtZU1uf40)A?T}0gVfr-zxyi`w
zK;HtaZ056`u@36PI%`EZi+wtgyXzMR{q4?*A;SrR%wg?<o|sIY3}fYtIGTq<;8ekx
z)5>9O;*r^kJw?n^jtgih*I8UoFdE~-ydvVdqpOqpZwlH1V;(Yv$TT361H-3n$&PKU
zbw*=h1kNJHw}nu4LK#M+4MPK2A5JPGHE@m2&gv)og+v0@G}-)+5yJ7RqCE;yDLU4`
zDTK2I&O)OzoWlM{g|FIN67-3)s|zwdWSktE0A(E`QyFoyU<6J%{N*7O6L(EmlFLlp
zdE_pxv$%FO_7C$2Tl_XB^$npUBUOh~HI!LU%D7J9+UQ#m&fv_M!FbK0qrFK(;sATR
zH=cG-e?~x8Fp>zv$$|YNP->w}4WSH0rU}XtW;Vl^ZS3IMW;RZikf+0GX>tZJy6|XA
zdh={l{YW`gPZ}H(x0#F>jd>9`s~9h9r4Vt4H407)J7cVUc1>e!c7{_xesFVD-#=UA
z)IcdAtXiZ}A#FuV37mQCdvhvTt>Fx^;&`j^;DVr6*s~hOLKtqfb*{-dQE>LdaWYa$
z1X2YW=Y?>Fz^NjxZRSf4Xf}+FT)R1lToJOySmW&eZmkq@!+t1KqsW>1ZBiOfjC?zV
zYopO*oe&CnyqNLI`9Y6hjE6CuSTgyIDle5>tqP?QikopFa2o7>%xNW&M|VL|TMMm2
z%lgq~m1c2X#X`4Phs+vc4=0411Lg%SBEvUpH%OVpm7Cv2aoXuX&gM0cZ0?CbvN@oY
zLv`uZB*!9F&t|!^%%09ug%qQH_{sQ82I8y^x6922tvqZ!sBt`{Vpee%{uK_Vil;)=
z6UoJBF#6Yqld!^Ogt<ZgxYJJ^5Dh6o{ZQRJJJj$OYg|XF3N*O-Bk*i)XyuVfJX%Se
zY$}Ux+Jr`%{gRAz3pIgiDMmf$nT&mPoM<7Qvf6H@xUt2;P0_n_n{K8eF43tvTsu)Q
zb=ErWbn;<Fg7KhI^EJj+WwmHDHqDN}Hu+<VLmn*JR~v~pHzN)(K5o`aG`fp<29?B*
z+gp*7jg6^28#SNj=RvcRLDC%(H70c~d(mcLva?sqHA~xdHSt@82BUSWp`3{{+%a|^
zH{D=8q!#U>W!UQE!@gvpN~GJy(93BZROh5gKT6)@i^Y!g03*HJR!27X@_fAPm)<9v
z$j?<TT(^sZ)S}<b6%HZJ<mF4W0=+ixqQ^%!5_O8`P^}`ajkYB%(s(nQ>*``_dq49e
zwsYFM`IgxVjX`phR*`l5+7VA<kCHW6VX`CJ->mXv-OqZNe7BKRJxmp>_#LfNw1#op
zv%<7?Lvj1QBC9*zcsNNt*zM+4p1WVO=$YIO47-fJ+@lD#19aqBxoF*hbhdpO4MgPF
zf14+k&C~M^3iiA_uNM7|o@7U!NT_b#NM%;5HS`oK@ue@hC0G4qCzI{WzMS<hlMi!s
zyZRCXYP6TO@K|Tl?KNEA66Z~1@kVx>scVze1EnjLb!C5Ur>l%%M^)+JGg`b&HXNcd
zspnRkF+K21cU{!VV<(y?*#=9K)XS4Jxwe9g<<-vY>dsWsdxt?WR<QaZ`;fSCJHNu9
zedMRz+6meySWdpphE`0zQ96Ojvs?=zuuKQIqm_hDd$ld3Wsuxno9yn@C^DhaGc=3}
z>gTD3TjuQhtX3W?eHXO0T2K6MMAs^4D`2H+{n<|cSrN|R&XKHd8}(cl^pF@ZRdP0S
zZifpefjrhm*PhdoZ?Yng%FwwogtHwEwL2u+>2ex3!HLq{oUO)V^r9`qGpp71@*yO4
zE36`B_n;*o(k3EAb=$daFCWffP4l?3c23YQES?1;ff={IrsgStQb5(=zCVaSG5z)Q
z5K4vh%8M<_m@9{p!AO*P#=3s;Btm>5isSH>j{e%Ct!YAcB^0;IhBFvWE)|*88G*6_
zeValUJ{X(uC<8t#O+{&H-g2tc{*FeXEZml6+oPraiL(lh?WCc^LaB#hG@5fXgh5uz
zbo3P*?N1}Nl)!K@Yj-H7vh+Z4J&eFH`WA*zYM`uU#cV%Jy>F^-FZI9cA^R`f7Qc4J
znwSvEDk$Yp>fuj>k`1L1iq#j+ApaF|->z$p_9hF0$=_~=NnbY?Ml}rAzX%kgZ9*%B
zXlk}QT-6K7beHSkm@cH0e$jeJ?g;URPGBhB&|l9ES_5YR)+Avk*@4+4C{0i%La{m{
zP^`9A2GP`@ZJ`vSVG@??hY?Heq(gw>dP%knx5m}jO5!Q{bO<EXdRV5zEPz#nJ?4b;
z@UG6sxn=c-^BA|fuMYagD*7~?tS~0tsWs?sd7oDgElL~7?;AKf*!f7h9eo6*wV{>C
zY8=!A&Y>!pCD^wW`%)k#sgJd+<4vZ?J@qhcXHR|$@w(NLSwTCw$HP0Lc2Ki9Q=NKb
zEZizqB2|6((ah;&-XxENYb}bvHP$@RN@dSC@E(>oNaX2G>Y@HhgFrV7ISq2G?uOEg
z<|zILz$VB&m}iYRC&O)ayYV1>#@~yn2lMn|`!+0I+u3(v+Xe=7Ggd4?L!<4Il!~&R
z-C9N6+=htgqF$b>v2<Iw7Cd+D%eN~-)wh=SaenQ9RlV6~Yw;sR@8bEHHQK}})|nNX
z4bQbM0?|~A%N!o>Iu}vN+L{MiE~jb~)ou=66!9*w$a<5c9jqsHP~Ezf^B`n3u+#12
z9qvGLF0LQ!yy2e$*{^BTK5exOhSeWV;7R0T*PfZyPwwradrlA5LzXZm-uT+UGjVlA
zVAyKXVQ{w+A>JhSn*vtcuQR9~yJ{)gOy#<VcnI->XXSqDFvHqGy{MY5bwgSzpke4N
z)%Ly2IxSWo_gjq-IJUlYD1FUYRG<xKq7AJLFq$-jx8t3(L_Ms(TghT!xHWE->2P|Q
zU6jQ42D{Zi+^KttiPmaOp?*!$^|s!#dc#S?j9YO|w|;eqMQ0*1sqBRu;&Fx+>k{Ip
zTAN0@-(=`vc781p5JiU*$NYgaT2{fljR~<7zNtRv8v3j5_a-*eR6y>pN=z!9&jh}&
zXk-<F?-ZPB)0J{7Eb0ayc9c>@PQkVeY)o^%1zARwT%%rUKC5kkQ(f-73azzHg~Lvs
z+0wChW!~-3-8*c>l<)Tc%noN4(fQ^%@=h-l&%7(e9j2dMZRYp6^$oLbw?5z4X-<cD
zcivVJ%v%{`O%1m1N@QOP)+5;F$}nHe{496gRvO6WGFHc&shD_kHO-NBD+uPT4D+VD
z+iYfE57q|Ex>8u?Q~>Gj9nI#uJLVht?L)f0O|90Mxnuv|;Mo7WIQIWej_rg0FL^-p
EzX&OIXaE2J

literal 0
HcmV?d00001

-- 
2.43.0

