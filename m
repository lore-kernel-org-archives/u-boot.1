Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFAC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7B0C607D9;
	Fri, 14 Aug 2026 11:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b746sB6hIaK1; Fri, 14 Aug 2026 11:21:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A580960635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706492;
	bh=vYYS1J/1c62Qmqf9tTRnI0bq5bl0fRqekJ/oL7faXRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQGVbd98uHaZBsKWcj9C00HPo2/ZckCM20nzV/cnueo5whPtAfzZ8H4FCu4pCoxYt
	 jyvYzX+I0qFBVLetR3mbGagVaNUfGvpIVhs3MDsZw/TydAlns2+jFbgqV4IyKrDoWt
	 0CEDWixPb2Eh0+NtC1gJtxke27zYdh9MnSkDnh6daHlf0gA9XeefzNgKzIBZFgyFlS
	 rfv5pQ7esPxafyNvJkM3EP+GIZavTWwYcHYFOBWpCbbvqsbUtfyS4IF9c4TNiiKFQc
	 QCv3fmaoeBrn7mpwedg9FqfV2bPUlz9rg3rkJNM+5Sp1wf3ehZmM+u9T2Qy12rtrnU
	 nIM6kxd4Ms0mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A580960635;
	Fri, 14 Aug 2026 11:21:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27679392
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1643281099
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWpAVntDdev1 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2689A81011
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2689A81011
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RwGnPoQz
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2689A81011
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:26 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so7515445e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706484; x=1787311284;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vYYS1J/1c62Qmqf9tTRnI0bq5bl0fRqekJ/oL7faXRw=;
 b=RwGnPoQzLZHUUiJEtjx7HdfHvx8nmRv2I2Tv1YChI8r/v5aTy7RXwcN26mfxOLzQP+
 LbZNHi1bI8rN9P9gszW9e12EZl08XiFKSgSG9P1LR0j7NmIyye9lO8U/R9Z9+of6IsnQ
 /0gfmNBsjOF+Qetv78mXM4wckuw5pv25XBp8RvIvL8G93c6zDdPIZGuLHihcNbK28Ofm
 MZKe2Qq1los+NuYQ38RXY0fhDLlPxtuslIigFCC8PSHg12/6u0bomU4ldtNj+jRVtibN
 HV8dDFaZMc3eyaSqY90xwX1TUKRb2X814YpCy+fQR4gHVtwpQ+2vNnXr/y8YEjynpFbT
 X9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706484; x=1787311284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYYS1J/1c62Qmqf9tTRnI0bq5bl0fRqekJ/oL7faXRw=;
 b=RU/wpey+z6+wgOXvo+o0HTuzQSlHoStQIRaWGuM7mXMnYVgbj1uwg3EPZAZNCn0rV+
 I/GOVQXtZ+JFBEU8Z+VpeGFYV/d7q/VZPSR+G46vsUgehey5M5CbCvsTZB3TlLuiLo9t
 GrZVBvsY/G1EZX/w30iUhjOfjoh8YxfKiTqYW3cG3OGftzHWOtS0ezLW29O1XuaEPsKU
 VgKQkBUe+PojyJgvbcLyIYOgyI4F68tkrDYrMFyWpgEs7b77WN14715Di/OO/PFNraSO
 uAd4AR94rP9botnMnP8e0QJ12trzOtQXZcM3W/mj2sp5mDL5AHr2CX5OjwhR0JN/gK3L
 p37g==
X-Gm-Message-State: AOJu0Yyg+j3xq5/R0fXj2yR2WxWHSuzD9//yRD9ycsIfAo2reRHEKA6Z
 1fWFzXk7i81hHv9K9kXn2iPOFJMXPTE7t/6H0SzcVeNueBHCOazlgDCW
X-Gm-Gg: AR+sD13WuTQUE0lkxA59o0kGuwwKl6UKDRSCjReLw2I/TpJQhw0EhsbmtNKWaO4AkeR
 FlbyPYvYytmjOuv0gIUzryRcAD4CCBUO2xXrcSaNOocpCRPE0ff0uFJqL9mbnaYL05F85svGILt
 tF9A5YaN+WZmp0QLqzKzKcMdQvV9wYmjENtsjZAppxdxXAtnh9AQLS5y63e9aeKtFxWFw5j9W3S
 B0tRqv/RkE27A0fSSb/DLMrfx6xn3/RzVZN296aYsDESUwzv/1I29YWHUexfGuN+uFG7dyrK/q9
 ZNCVYZNhmq5t7jQCe2iw9iMxMzOl1iLCT2Os/7EWFMcMmBcy0Evig1jdZfrXJ6d8oqJsxvTrJhQ
 L0/cVocoYQgG5tsW47kUmdxb49Mt9NZtb4i/kSNaNB9MWdJkXcenl+4g0012HaMzBr15NjEk/vJ
 mE3kkdjke2hPO8GMHhIeum5OYhn+T3tFZtiirqJEL1z0pB8RQwd8Tcj5e7NJTtf4NY+rCHP44C/
 hGVkOy4mB40ucVc8ly5yzxkDrPGKcHzUH1UUdGNbu++DUAuxoZuubRlIedCIFYxkAwIJVINP7Qt
 hPLidcpMAytZcyNUz8ceM7k5/K4mZqnnWQTNtA==
X-Received: by 2002:a05:600c:4f12:b0:499:491e:4b0d with SMTP id
 5b1f17b1804b1-499879c627bmr72610625e9.19.1786706484156; 
 Fri, 14 Aug 2026 04:21:24 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:23 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:19 +0200
Subject: [PATCH 4/8] toradex: verdin-imx8mp: Set WiFi DTB as default for
 new PIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-4-b8605ac094d0@toradex.com>
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

Currently, the Verdin iMX8MP uses the Toradex product ID table
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

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/verdin-imx8mp/verdin-imx8mp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index 1209da593f8..343e56bf755 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -69,19 +69,17 @@ static void select_dt_from_module_version(void)
 {
 	char variant[32];
 	char *env_variant = env_get("variant");
-	int is_wifi = 0;
+	bool is_wifi = true;
 
 	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
 		/*
 		 * If we have a valid config block and it says we are a module with
 		 * Wi-Fi/Bluetooth make sure we use the -wifi device tree.
 		 */
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_2GB_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G);
+		is_wifi = !((tdx_hw_tag.prodid == VERDIN_IMX8MPQ) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_IT) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MPQL_IT) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_4GB_IT_64G));
 	}
 
 	if (is_wifi)

-- 
2.43.0

