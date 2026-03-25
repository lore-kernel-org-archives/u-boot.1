Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CA1109C045
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1413683F60;
	Wed, 25 Mar 2026 17:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+78WT/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D942840A9; Wed, 25 Mar 2026 17:56:00 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC7083F14
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4670676ba03so4154b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457756; x=1775062556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPZrYSxXbZ+OmQTMVIZsw9ndLdvsZe1NNg3On48OkS8=;
 b=P+78WT/Tei/iI2ketJKVgTApfSUqGflvqomNlusVuLzKt4uKrMZspdkkGbhER3DkhI
 ecb2l/KCKNi61tfv2HljvvbXUdvf/JVrkWeufAnmfmP2nq05xmdrfgNXmHHyM1wKCxQN
 sYmUi+vm1O1EEDVmhUebrbv7KF22obFhw3Y5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457756; x=1775062556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YPZrYSxXbZ+OmQTMVIZsw9ndLdvsZe1NNg3On48OkS8=;
 b=ljoFNHDm6m6sBfct7HkzvXE33eMALVdT1YdcPRNkjfl2LnuiN0SE/q4NFZDQGbBasr
 0YLwbstgSWButBF3GFm4xedeMA7E/phZV+4DzKB8Xnjq04ma1MIBZ69EmR+1Ujc8u5wI
 96J6FWg/7AQnFCZY6Nf3NeVpamE59c+qIbePVBaYTKaS/DsRKg8SmujQghkqf73cZBDW
 sj8dTpwvFvVlnhTQfvPXJTHDKcfL/6UMV3zl9lDLucFj4zix0ffx3QH+ORtsowCraV02
 oJRWDKbRT8GR4+ErbjX9rmkhFyMkXJebj24FetFy5Is2uROHeuiwoU5OoFui/ZpVcXMo
 Z1pA==
X-Gm-Message-State: AOJu0Yyc3NP4HWVEGF+EHyMJQMmX1chVkk6L/ggfbtutfdRRPSMFp9FI
 076nvlt2HWdfYEuOplK0QrkkZ/LCbV2cYP2YtmLxVuXrXAflpPFi/zm79wAxEsfRiZMhx4qmhe/
 YtOWx7g==
X-Gm-Gg: ATEYQzwNcXaPN77Nw4fclALgEU9EIJymFQRaNrNODBRxo/gg7Qh9vjjoteOJkKWwis+
 jr3gUwUE2NLTC+qBLdbld22x2wkjIPep5KcHAymaNQhKFr22wF9K3UCGCYdsiUva0VwyxudXwRf
 b0CwUzlqe4kaAI6+v7TjdqfZs8lI+M0N2QkuLaOKOUuuMV59vE93+rcZaMzlm9dzYdgUTm7xRrU
 kCp0Al4KW4IfntYfN+TuiIuaODjUS+G6PDcTDoEfK4XbBp+ZFmTPNbuL/QKm78BK5P9GFLSdGRm
 3BdFYml003zHgG8ItIL9IwU+7Gig6xp3d0rV+UMhJn2OsvcwrvTu/wEB3igyRab56JqAD3M2qMp
 OxffGGB/WSMYG8nceMB2ixhMIsp6xig/JRaPYSS5VS6Jgi0COuo7UmrQ6CClQbdBZZryjJt/MxB
 LUVwIHz3g8Ng6stjLaKw==
X-Received: by 2002:a05:6808:8897:b0:46a:6d33:65a8 with SMTP id
 5614622812f47-46a6d3365ccmr367368b6e.32.1774457755548; 
 Wed, 25 Mar 2026 09:55:55 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] boot: Drop unnecessary data variable
Date: Wed, 25 Mar 2026 10:54:21 -0600
Message-ID: <20260325165431.1027591-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is always the same as 'buf' and is not needed by the caller. Drop
the return of this value from handle_load_op().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 749cbe19ade..34876b66fa0 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2407,7 +2407,6 @@ static int decomp_image(const void *fit, int noffset, const char *prop_name,
  * @image_type: Type of the image
  * @load_op: Load operation to process
  * @bootstage_id: ID of starting bootstage to use for progress updates
- * @datap: Returns buf
  * @loadp: Returns the address where the data was loaded
  * @sizep: On entry, the size of the image in bytes. Updated if decompressed
  * Return: 0 if OK, -ve on error
@@ -2415,7 +2414,7 @@ static int decomp_image(const void *fit, int noffset, const char *prop_name,
 static int handle_load_op(const void *fit, int noffset, const char *prop_name,
 			  void *buf, ulong size, enum image_type_t image_type,
 			  enum fit_load_op load_op, int bootstage_id,
-			  ulong *datap, ulong *loadp, ulong *sizep)
+			  ulong *loadp, ulong *sizep)
 {
 	ulong data, load, load_end;
 	int ret;
@@ -2462,7 +2461,6 @@ static int handle_load_op(const void *fit, int noffset, const char *prop_name,
 	if (ret)
 		return ret;
 
-	*datap = data;
 	*loadp = load;
 
 	return 0;
@@ -2480,7 +2478,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *fit_base_uname_config;
 	const void *fit;
 	void *buf;
-	ulong load, data, len;
+	ulong load, len;
 	const char *prop_name;
 	int ret;
 
@@ -2507,7 +2505,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		return ret;
 
 	ret = handle_load_op(fit, noffset, prop_name, buf, len, image_type,
-			     load_op, bootstage_id, &data, &load, &len);
+			     load_op, bootstage_id, &load, &len);
 	if (ret)
 		return ret;
 
-- 
2.43.0

