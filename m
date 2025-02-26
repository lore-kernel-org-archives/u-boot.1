Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3C1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665FD80FEC;
	Wed, 26 Feb 2025 12:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AM7TYcV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6284480FC2; Wed, 26 Feb 2025 12:44:08 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E85180FBC
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso968490266b.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570245; x=1741175045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDhD5776OQIoZ6dxTfkyYHpnDIUzzKtljIRR7VJ35l4=;
 b=AM7TYcV91PeaAACePpwhAhSPmtusSmxdN2GDA6dNF9MHJtmYBM6WP5pLmjkjgDfe5f
 C1V+w9z+c23HzEcUIEtD5t9uuL3eibYH1DrXDBEax92rnOxBDjWa4TqgD6ZvICjtP/iV
 B8Kt5tlrDbV0Yf2YSsRnsmcZEl/ZLzNnDjbNwnJ4Q59HAjeadL1ERflNtPkrUrRsqzOO
 VWHx+UuZlBBVYB/QIIIFwxhlIGSAqN8i1g+Z4+2/IuuftWNWLb2/y0cxkiZSAGEBQK/w
 +r4kFInPX/jg1MCYH+iOZN0AqE3JAbVOCndqCHvt7PGQNWYr7BioPZpHMCL+jvgf8QcD
 Tnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570245; x=1741175045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDhD5776OQIoZ6dxTfkyYHpnDIUzzKtljIRR7VJ35l4=;
 b=LzVhgLRj2esAHegTr96RCbOaWYOM+gOJq+lvWbiG/4byIP2TXxiKJF/XpMYDYz48wx
 mL1AxZDkJWvoERds/IapgfPWctbSnkPtAx01qxBOuU2/TeIUIA10pKOKsKTiYMVjevdv
 f+OdnYS20cF/ne0Iveg6bc5LstukbjygDYhX1ZwBFlFxsRs/foB1EX5i/MahF7i3DTaw
 tQbmhsIEVRz7cSAAkVoIBH9vTv1M7FPmQIc6U6uRKRqbroU5mZ7RV2tyAY7MOYMq75JL
 psevBJa5KsRbZ4QLPlm9mRlCid/RTMWaHGZ83h5PKT7KT/FzvtdOUbMTyP0+oPFvvML1
 j+xQ==
X-Gm-Message-State: AOJu0YyYpnWq4B3HE715GtMiSRWncv9xBWtm7PIUpS/f8DKMhghwgqnU
 YtTFzStjBRRFJ/h+eIsHg4fUkmiInXD+J+6Sx7wOpJfrFqkdCdtG
X-Gm-Gg: ASbGnctGq+XUWtpyL23NoVBK6OBPh5ljbYyE5Ma3Aw/PmmqW5KOgLDvrDmuNzKR+TWa
 IIWHAj27z37u0ykTRGBH8SrGcJ1fI7kUKGWuMONBKXfxZEq3grAtxJTT1E4HQBjAuk0Chbe/hk2
 JWxczc9mRqqi4s4zGZD0Rp8EnssomcQyimfX8syXvK3f+SQsHzmGF/avgipQHXpjQAl/lG438OK
 yQ9/4ouwy/jsLDvOTqEmq+aBiS0m6ciPgMdqqz8ZIe8FpHm9u780rl36ia15xqcmwaA1iZlIJwg
 JJ1yD27vFN9XPFWGMQ==
X-Google-Smtp-Source: AGHT+IE7DeuTb6SlKlnp9+3PeexQPxnlpmMNxacajgUF3AkW6ioIo+8EqGzOjcjwFgkTVs9UqiX/1w==
X-Received: by 2002:a17:906:2a4c:b0:abe:fed3:9eb8 with SMTP id
 a640c23a62f3a-abefed3b1abmr71241166b.41.1740570244442; 
 Wed, 26 Feb 2025 03:44:04 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/7] video: tegra20: dc: dsi: add Tegra K1 compatible
Date: Wed, 26 Feb 2025 13:43:35 +0200
Message-ID: <20250226114340.42191-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226114340.42191-1-clamor95@gmail.com>
References: <20250226114340.42191-1-clamor95@gmail.com>
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

Tegra K1 is fully compatible with existing DC and DSI implementation
using Tegra 4 data.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c  | 3 +++
 drivers/video/tegra20/tegra-dsi.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index e366df9ab51..16a2b5281bf 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -553,6 +553,9 @@ static const struct udevice_id tegra_lcd_ids[] = {
 	}, {
 		.compatible = "nvidia,tegra114-dc",
 		.data = (ulong)&tegra114_dc_soc_info
+	}, {
+		.compatible = "nvidia,tegra124-dc",
+		.data = (ulong)&tegra114_dc_soc_info
 	}, {
 		/* sentinel */
 	}
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 079b00e0f61..25cd4db0061 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -1118,6 +1118,7 @@ static const struct panel_ops tegra_dsi_bridge_ops = {
 static const struct udevice_id tegra_dsi_bridge_ids[] = {
 	{ .compatible = "nvidia,tegra30-dsi", .data = DSI_V0 },
 	{ .compatible = "nvidia,tegra114-dsi", .data = DSI_V1 },
+	{ .compatible = "nvidia,tegra124-dsi", .data = DSI_V1 },
 	{ }
 };
 
-- 
2.43.0

