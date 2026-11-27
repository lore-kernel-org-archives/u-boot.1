Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB04606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fRQ2nE3W;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jeq8h6kf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8303481337;
	Fri, 27 Nov 2026 18:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QN8dfKFFc6I; Fri, 27 Nov 2026 18:00:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3604A8132E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802428;
	b=BDDmWMm1SlwdIbrbvUHi+NdAsbK13/sHy5FfluKlJ2HL0QU34rAw6wyVV/vMjy3TK6g5
	 GMB8ha0J4cJ5EGlFMIEP12b5rPQkgGBgruXWRfcuNfOJOC1Kl+XJrkNE2GTt8kViwFkc8
	 G34ONkbGJG0nEsfqgwZ+AK+sxclQQfj8ZaBmHzaWTTXobOhURoKpG+Cw1HiRAFDmBhNHU
	 sKwMWAPB1TZN6fFUfUk0jA2QyEB0JME5irnzrcxZYIgmeVj7elmofM3KhOcyj9+YGT8Ml
	 fGW1JQqimBmYFteqhNVR91tvpCPGH/mYFbNLu3KchNETYvgyZexO5KQxwj2tDUBrA3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oARuGqTaV6qWiZjMKO/YC5pseZzIG/CHzOd22dttcLs=;
	b=VfOLKy9jzdjVE3ddoBfmBTi4kvy5B0DivKz/GDn392LjVrrlx1y02uuJAhU5csqHVvM8
	 JB/0q3SknNU0PAVU4RJQMakKJhR/up2iNcs743HeNBt3eQ52Sc+kU6SFo05hDPz0U7Nre
	 cC+/wCDAMHljv9cW9S86T/+ZySlwmDSwLKyBpN+bYFV4QbGFoyF+acncPv6ET3FPErcA+
	 yOx88UwvB6WTK2Y8p3fKAVdmI6DjYRyCtCvGiP+NkESNb/C6jooIjlLKyR8edyGDj5Qi7
	 YDNvpfDwV7yQRjokWU3oT6BaJjFM26DpHk57kEf7WyXmiBeZoezNV3LLt3a8Emx3e3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802428;
	bh=oARuGqTaV6qWiZjMKO/YC5pseZzIG/CHzOd22dttcLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRQ2nE3WmzHI/mXCBt58qyqYJzmgfW2UR59uV6xtREcAtaDh0RfNucL61sICpVcL8
	 7ft/Z1C7OoL+LuSC3lNUSDxQGPYp2/rjmpi+aZmvPFL6jHdjZNr69n9eldsW3DqhZi
	 bJ+vHGSu44AFLuvDFowjrJh765cUmQ7jM7lzNhzxzQquP0GsJTC+wXwjMvJrm8N9vL
	 jO3A4pvx/RjuxJhG/CWS1LeZ4PqaTcdBDORa0VxvWAAA97bcMS1RQXfur1IIZO7f+3
	 3hygAS5xIJYdzjqFyqn4FrHM/GnqW4IWx0t6gCdsnqq2I9kStbwEglQuIyGZsHTE5Y
	 PDllWYdlA42fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3604A8132E;
	Fri, 27 Nov 2026 18:00:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01A98373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3AAC400BC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uzp7KEOlcmdv for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1515F405CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Jeq8h6kf
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1515F405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso102563205e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802418; x=1796407218;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oARuGqTaV6qWiZjMKO/YC5pseZzIG/CHzOd22dttcLs=;
 b=Jeq8h6kfkI+sjDw54RTWEkkrL830a1q42NXFZwTD4d6hWHxpq5Gbe7BCLqC3U7BnQ+
 Ed2R0KoRzir3m+2pWlGhglE+e/ryWTaJNSXHnZr5YYsjs5cMoRZjGaSHrvpBeUzYVQKF
 j2G3IaG4WjbmJLdk9lNH5zh5XgwNfBIM+2HD0HQbfKACSIugcbew2OvU8pBntsJFql8b
 uARy6m8v/c+eFJJML8Opdp3rNaArnUSIolvV6nVLzBmEYTvt1KobtnQzybpqBJ6iOQp7
 AjBqvIIUxSvdRf7iN51DIAAH3R4dlXsB87PgIQdRxSlbNJpbXq/pPpMToaRxzr8vgd2F
 ysJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802418; x=1796407218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oARuGqTaV6qWiZjMKO/YC5pseZzIG/CHzOd22dttcLs=;
 b=ZdzOxKa88MOchQQiR/PNRAWvAIxPZEdBusttX1IMFQ284m2Rae8nvfxucSwwVv/3sz
 cI1M8a6a5YAZsEWSn0opjJozWdW6OeSAVUqqn4+1F0DlKqjQdv94p4XWv4JZU7UnNosl
 SoI/m4SkiwKzaLw5vsSOLYbpe/px452B/C/Tp8uh1CNNHP0wB5LkGazz52Pq0ywhXeEH
 YEajkN3AElbL7WDcXh7rtdVuHsBMUcJCReASQ7XKWYn9Ilm0ZaDPlDlH+dfpD4AOPDMs
 ww1YTkkkJ4Qnvb0pgvHpjet8S6uAvrf18uSICh6eGocaJUgxLpP53wihHsPj2ThZhvru
 gClA==
X-Gm-Message-State: APuU4Z9LVXFZ0rB1uYJWOxcTZpojZx2hyzHumseeMo8KkYvr+JIuPG0y
 N0jQd2u8L6T8TpBTv8eVz5dL8uCu0JhHSXOYO3R3OZMSzAl1oEHkRigP
X-Gm-Gg: AZFdTZfQnqj1tOS5/B0vcoeuHPW7Doq1JaRQQK+XgP1qKd99l6F3XZPY1d/L8txgGFI
 SmO2FUlixVhWpTcMQwiFI6hWQilmzZQsH68JaRd4At2xV7cywPL7n0vHBMEk6/2gVi+dxfLaZnI
 BoRftDDS0QblLJYqMord84wg2SmkBfW6T8W9/cga/nwNFpOmNCY62+AE/EbfR3Ia3FWctTmKnlP
 4TDurMe8gQswMiqgLxlyXrAkK0hFtXLFBmQvlxUVy6wWpMD761kUnpgFHVSI7Oo63BZn09ihq8Z
 fLTtkXxKeNFS9O1t+ZXJiOijXdv3F3+jzHAPPInAc7ww3wvzLHCdg9lixnYIVRjcoL+6K/gaFyC
 z7zaCidwbH2rfkQDnOxg0UjaKc/CGKofOfonC1WkaQoh9OWAMpb5WzNmfG3ZuJgmQM2dgi11zXE
 t9McO+8BKnpQdxVuMGWya3eUGKZlZup7bT45y7GKTDZlKFc0gtFxwP/vkeAI2LE6iTBG9sDlxUL
 gYB4IGTCrSiahsJ8dmwA1fKCls9SI3HWfPSk57PyiyNV6wRueyPre8Z9yMW8QcKDqmlwzxh0OxA
 j49GhbaHeLZpwOa0uOv99CDMymRF8NbQjcX9EUI=
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id
 5b1f17b1804b1-4bb88819940mr594846185e9.30.1795802417764; 
 Fri, 27 Nov 2026 10:00:17 -0800 (PST)
Received: from [127.0.1.1] ([151.71.203.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm695638385e9.1.2026.11.27.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:00:17 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 27 Nov 2026 19:00:12 +0100
Subject: [PATCH v4 3/4] ram: rockchip: raise error when configuration is
 unsupported
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ddr-multi-v4-3-c66608f3e06f@gmail.com>
References: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
In-Reply-To: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PX30 and RV1126 SDRAM drivers support more SDRAM types but only
one type at a time, really. The type to support is selected through
RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
more than one of these options is selected, instead of relying on a
debatable and embedded priority order to choose the one to support
among the selected.

The RK3399 SDRAM driver supports DDR3 and LPDDR3 types, or alternatively,
LPDDR4 type, but not all of them at the same time. Raise a compile-time
error if RAM_ROCKCHIP_LPDDR4 config option is selected together with DDR3
and/or LPDDR3 options, instead of silently ignoring the DDR3/LPDDR3
selections and prioritizing LPDDR4 support.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/sdram_px30.c   | 7 +++++++
 drivers/ram/rockchip/sdram_rk3399.c | 6 ++++++
 drivers/ram/rockchip/sdram_rv1126.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 0b6d3723409..139e6eab060 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -123,6 +123,13 @@ u32 addrmap[][8] = {
 
 struct dram_info dram_info;
 
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	defined(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct px30_sdram_params sdram_configs[] = {
 #if defined(CONFIG_RAM_ROCKCHIP_DDR4)
 #include	"sdram-px30-ddr4-detect-333.inc"
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 5bc6f3a39fd..3daad319a57 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -26,6 +26,12 @@
 #include <linux/err.h>
 #include <time.h>
 
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
+	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
+	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
+#error "This driver only supports DDR3/LPDDR3 or LPDDR4 at a time"
+#endif
+
 #if !defined(CONFIG_RAM_ROCKCHIP_DDR3) && \
 	!defined(CONFIG_RAM_ROCKCHIP_LPDDR3) && \
 	!defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 2d101d6af3a..c914e976bc7 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -66,6 +66,12 @@ struct dram_info {
 
 struct dram_info dram_info;
 
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	defined(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	defined(CONFIG_RAM_ROCKCHIP_LPDDR4) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct rv1126_sdram_params sdram_configs[] = {
 #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
 # include	"sdram-rv1126-lpddr4-detect-328.inc"

-- 
2.34.1

