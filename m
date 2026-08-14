Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A2C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EF6A60782;
	Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kbyk9ODrC75b; Fri, 14 Aug 2026 11:21:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D6826062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706487;
	bh=utJKiFzq8iNyeMkQBTYhK5dYmXMk2ipYkfdnoHD43J0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Grv1CdYSKubI12bCCJKCupg4Dm2oT9YJr+/ih/6sEbk2OiqB5aH/bhOLMXFSfQWsM
	 RPhaVOBx4qgu6mz6AK0kM5yaRqM2Xl+K2fNzJn6RzFGGtbD01cncqFcI6x+RFAxKxb
	 c8p9Edy9nEXsYRDcURh9IpoZDQsyX3N+ooUY8cpoRJlAqOdrUe9OETLpUU/Ohm2uvn
	 dGx4Zt7vkkUqOk3Xl5z2XK6g+JAmDN1auSM+Ls+cHuiCDJAP0kiGBSG2bpVOiHwk5A
	 tkyqYR8l+KEUEEjm8DULs6ON+XOU9hVo9UmIpoKsbxHMqgqr0olx/gQ6PmZi2wMwvs
	 IhBAzTREqBVlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D6826062C;
	Fri, 14 Aug 2026 11:21:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BEE43A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E05E80EF8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkffNKduAres for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 67C2E81011
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67C2E81011
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=saoDC2wa
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67C2E81011
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:23 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so771361f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706481; x=1787311281;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utJKiFzq8iNyeMkQBTYhK5dYmXMk2ipYkfdnoHD43J0=;
 b=saoDC2wao288W5Wml1W2kjjkJfX8qeTAc7TJiKtfmZP+mvTzEVZDsmRNPx0eD9tEHU
 ZVtvNnAV9sz3+dBtzbUHfqkxsdu77pcBr2mkrBzK8nGpXlpKQU8nY/l4ktbayQUEc4Eo
 9ol9qm2/d9jacBb6b3ZY9VECDoOJLEeegyifeWz2TRL9D+LT8fHRB6NFr+BuDJDZ2gFE
 HxwLaPld/xyb90n6t0vCG7iWnpo370znINBoRnTpz0otpycQW05JvfJyaoFfSgcIwfzY
 yhgFLJTCVLL+EMqNj85wfyfIhW/LjdEvDkctRYTFoiRnhRJXpCjW4T4UpwFNTeeAiIrR
 JbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706481; x=1787311281;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=utJKiFzq8iNyeMkQBTYhK5dYmXMk2ipYkfdnoHD43J0=;
 b=Gh0tVAGZ4jngUiiIYSX3jHeqXrm9w4DZsmNHROxWs0fk75i4O7Ufo1/mCgYphhPaDg
 +D3R+3qYt8kJqrMAiZ6eaSUNunCIleQsSMBkYWUDhJfxbJ801Tih6b1LnwWfJtUqcwtU
 7yi/AP0MifVqMSv1NOD2+Rh75VfJM2DR28t6F4FdXDVKclgCa5lVq6kUPulQvC9pZX/8
 JL12hglmKTEVrPlDT/F4TzQjhzT97k0w4dLHicpawMS1hNR2dOMSKGw6DzkPOKIfWQZ7
 oSvJik6QgA9s1PayM6pOPo2gqjIpKlK3ykzIXR+ytfzF3TgSAX3GfgNA6k8ZH6leJok3
 8PiA==
X-Gm-Message-State: AOJu0YzFhi3JllPf4lgIq8wVZ8YZ+D/rWBUxdZSTINbYI305Ewm5VjZW
 asGz0zlVYzrX71J8D0lv9SngqH5JztZtXFlWe2JzUDv+L1fr2nyzOW2l
X-Gm-Gg: AR+sD13FUhVn3lal13SNmCd8sBAR/OQZK9A6sqBnYuIN0IOXc3WxfNKUkpkSZIJI0NX
 tDaKas/5mqNTJ6b7S84JnSa9XS0BEEURGabeu/zTzXx46CKwKx9hcWAzd2I4MQNAbr6UELim2Uj
 yC5C90fXDk2qI4ZPpJ5cpp/cGUxFI7Qw0lggDyXAlPOSLWl/GqDnBEOapLXZzoTC3txQkZwUyFg
 dr4YqJN9mSPu17jnYYbh12m5/AeEfEnidwUoGcQ/AS7mLdV+3z/pAiS1H5DsKnd0VTONFDgb5YX
 +BvlVygN112RvB8AtVjJv/aK3dLaJ3H+xj3HXRX4uOkY4+VUHhLUguXzP/WZWOjfOtK+N+arxU/
 Bm/Wgf0DSH92K0npfTLT5ZJhkuJnNZ4wf8SlUGlDgnV2uyR6pO8gwwwK7ydfG015iwdwoUH2SDU
 x3hwoy13ZGEWIEMfL9wFs68WlCPEkJsRMy/3aAgGyrgu4PLfazwgaqFrzkLXzPpQgbB4mxn0FKH
 dNijr6WK3tzscB6ws///q+m8xV3hJjBB511HmYOVGMmcmVa7qlZHz9IaEDaha75HjtH0d9ra86P
 sLMLKj315QjuIi2zAijeWHTlMP3zEerfYqkXGw==
X-Received: by 2002:a05:600c:4f4a:b0:499:484a:7644 with SMTP id
 5b1f17b1804b1-4998795a823mr67798715e9.9.1786706481190; 
 Fri, 14 Aug 2026 04:21:21 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:20 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:16 +0200
Subject: [PATCH 1/8] toradex: verdin-am62: Set WiFI DTB as default for new PIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-1-b8605ac094d0@toradex.com>
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

Currently, the Verdin AM62 uses the Toradex product ID table
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
 board/toradex/verdin-am62/verdin-am62.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 6d55638b44b..6e664f40b43 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -74,18 +74,17 @@ static void select_dt_from_module_version(void)
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
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_AM62Q_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_AM62S_512MB_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_AM62D_1G_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_AM62Q_2G_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_AM62D_1G_WIFI_BT_ET);
+		is_wifi = !((tdx_hw_tag.prodid == VERDIN_AM62S_512MB) ||
+			    (tdx_hw_tag.prodid == VERDIN_AM62D_1G_ET) ||
+			    (tdx_hw_tag.prodid == VERDIN_AM62D_1G_IT) ||
+			    (tdx_hw_tag.prodid == VERDIN_AM62D_1G_ET_GPU_NODSI));
 	}
 
 	if (is_wifi)

-- 
2.43.0

