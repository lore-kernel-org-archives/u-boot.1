Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18695C5DF67
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDEB58111D;
	Fri, 14 Aug 2026 11:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A8CJNrqcn0wz; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ED3781121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706488;
	bh=C9L1gx+NrCp63ncZWqh/FdxQ6hrI72jvcVDFkr/Z+L8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s465TaOad4Gp86Ye82r0YVd1sRKcPKNQsAvCybXTV1uxXFZ2vQzNuPngKt3dW16Oi
	 bhmJBKIS770xuG068+I4MFZCwl6OJ8EOUDOeEbDKZlYNxU5cRf+34Riz1vySVHpYsg
	 w5PO2duKG3qzcri8/EANLYanRVHmeo7rrnZ/lwDvTbalgSxlwDoVX3QnjRUcKFa0h1
	 IR5a2ck8pOBq8B0plT/0rknrWtq41hpEIsX9BRTpXqa09hOstJBz8Cgp+zgUOEDwJu
	 CJJ0oZn2dueQtXZtBtzTKCaTiTbl/j9InYwmEClGRQIbAT8xPHCpb8DtIu6AJCfz/Q
	 meaHN4/7ZJILA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ED3781121;
	Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F00EC33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6A488109F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUvExIkFXzYd for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C348680EF8
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C348680EF8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fP3s+Lgz
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C348680EF8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:24 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4998590d392so9509575e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706483; x=1787311283;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C9L1gx+NrCp63ncZWqh/FdxQ6hrI72jvcVDFkr/Z+L8=;
 b=fP3s+LgzSvGLPFRojlDCSVdtnL6VH1r5+xe6OslEdI4U2J+TsRb3QYlD5MIkMIS6B3
 3fxWClt2CqDDDJSrPSjLlQ6BccMI/Lrv2n/yVmuIwlL8UnN0uz1kfAFNJNZO7aFVqBhc
 c0J4dnuF+Px5olXneOegFRBppg1CN3XaJa+7UvISE0rrpVg6R/iDFMD8Ot4qCnl2RNMS
 n7i9NoXtsJKYHMPO1N2Zfb6tgRJpD/5KKbMspUCZCasQ5D3A4hl755xJAy8avb0KkCHm
 90eMxdniVlSo+EoHUHH75u5h50wGSs2vD+dVX86hbNB+8g94obx3YdCn1VePYU7cUdoc
 abAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706483; x=1787311283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C9L1gx+NrCp63ncZWqh/FdxQ6hrI72jvcVDFkr/Z+L8=;
 b=SotdChRwLKHcvWAcibEAfTqAgkHaVHZQO0yyUnM7GzlkPy9rjCD/t1w5Km15XmmWWr
 qU3Zm9j7UVnPb5hpJbUsS2zdk13l8bGIlsM9xZN/+Q602ekyf643jBEyLG83OGufB8U5
 36gI3n2ncG3n2ZaYbGO+UnarrSzHIz9WRXU8D5Jsc3DfUBC7zID++YZjKsiLnNvEgZpR
 fEipINlNR624i6vzrSB27aljk9B+tBhwVHWzTxByIxjLx1/E4SN10ZaT7aNcdYKu5qF+
 /ZjLjqnREEkZn/Ue9BzFBvT+ALxU921UquAc418yMF2Vi+hXnO2Qm6BA0W58gWFEpgkA
 okdw==
X-Gm-Message-State: AOJu0YzIz1GRMOxfYFkLnly4jDhMtbSxCnox0djwYfu2QPStRjGDXnhd
 yAf0S8UhGlgoZr+cSdrpaAhs272ImePVw+qv/ZdHkv6o//7Qe9dyPbKr
X-Gm-Gg: AR+sD10ifE721r/s2e/pdtnkxUXQWlbx3aMQdzAtM3QcjaJOxBjv03ir0+k09QyMqKb
 c8CIVo/3nMoYbV6HhkpWAymx4XgCdVrQVWi6zyau+QsTyBYDqJUNlaKZmVp4jiu972/9xqlVeWH
 kAlSApMbID2xYZVjbTvQiHd59dsZ3+geL+7HiQJeS5AkrGyLqA4zWrzI+2o3ZEopXdT78kKw0tR
 PnKiJG3PriYxNFABNr86xCz59mGCaLSgpYzlBMtAshirZh9agsBYt490ePDDaCR9xagUZKDMeLd
 /Y58omnp3LyqHgyMbCwQGM2NeQyfCtXsKLgnGIKcOfeP1fKGJfWUbMSEvo4jHZdrjVgcW3gpnx4
 hDbP5JPzIrQWK/xNwdri8+IXkzhTuD40NcVKwpmigru0FiGMcPBN5z+6bc2dtZIPY/gM1HH2za+
 qBMfLlYFjZxoWEuCpuSn9ehrtRqvT/3Ri4cJwVsNemqOEkmWJ2lzYjVTLeTVqydIX57DY9W5HZz
 +c1hsxX6Vork7Sj0+c4Pkw2fyRmKgXDsplLso6F9LlXLscMCouwQFaSTgeuoANoWz9p43Jr5xFL
 r552CbVLQlwLrMKe+ae6252CQDj/5NnCNLA91ptrz7BKAVYO
X-Received: by 2002:a05:600c:8b05:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499879923ecmr74082325e9.13.1786706482628; 
 Fri, 14 Aug 2026 04:21:22 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:22 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:17 +0200
Subject: [PATCH 2/8] toradex: verdin-am62p: Set WiFi DTB as default for new
 PIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-2-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the Verdin AM62P uses the Toradex product ID table
to determine whether the module is a WiFi or a non-WiFi one and sets the
DTB accordingly.

In the progress of decoupling from the Toradex product PID table, use
the WiFi DTB as the default for new PIDs.
This change is safe, as on non-WiFi modules this leaves the WiFi and BT
devices unprobed. Further, the SDIO/UART signals are exposed to the edge
connector on non-WiFi modules and can be used on the carrier. However,
no Toradex carrier board makes use of these interfaces on the carrier
and it can only be achieved with a customized board. For customized
boards, it's expected to override the default selection by setting the
'fdtfile' env variable.

Since there is only one Verdin AM62P PID, completely remove the PID
based late selection.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/verdin-am62p/verdin-am62p.c | 32 -------------------------------
 configs/verdin-am62p_a53_defconfig        |  3 +--
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 1e7fcc9fd9d..7c680b46c92 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -103,38 +103,6 @@ void ft_board_setup_ex(void *blob, struct bd_info *bd)
 }
 #endif
 
-static void select_dt_from_module_version(void)
-{
-	char variant[32];
-	char *env_variant = env_get("variant");
-	int is_wifi = 0;
-
-	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
-		/*
-		 * If we have a valid config block and it says we are a module with
-		 * Wi-Fi/Bluetooth make sure we use the -wifi device tree.
-		 */
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_AM62PQ_2G_WIFI_BT_IT);
-	}
-
-	if (is_wifi)
-		strlcpy(&variant[0], "wifi", sizeof(variant));
-	else
-		strlcpy(&variant[0], "nonwifi", sizeof(variant));
-
-	if (!env_variant || strcmp(variant, env_variant)) {
-		printf("Setting variant to %s\n", variant);
-		env_set("variant", variant);
-	}
-}
-
-int board_late_init(void)
-{
-	select_dt_from_module_version();
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index a397684dbd8..70a9f2389f4 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -35,12 +35,11 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_BOARD_SETUP_EXTENDED=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am62p5-verdin-wifi-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_BOARD_INIT=y

-- 
2.43.0

