Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCD1C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0551881026;
	Wed, 26 Feb 2025 12:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2UdYyKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5832680FFC; Wed, 26 Feb 2025 12:54:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3078081100
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so1142436966b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570857; x=1741175657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwZLfmhbxwK+26E/jO3zs0lTZenODwUZrbE8CwwZsaI=;
 b=j2UdYyKt+CDZNA/o0vyvzpcT8rCPTpAQ+JGZlolJC1of08U0RKziBPyW3xCNkfu+tz
 zez5RgckqIZfe1tPpOW73kXdNe+q0BIjY20KuswiTgSbAfN9lzn7G4Hhyboa9vUTvBtY
 Y2YajeIeWRokRXxvTBLc0l7BzjhHBHJfeZmtJWJg1+EMzcu1/hUhvnJ+XPc1y36X7x9N
 IzySgK787S/C61tqks1Xn8iCNIC8wfHqUShneaGPlyHtDNtb3gV0p+yLXO7266Kyv/t5
 iEa+kIQ1Awo242E4etH0q6+BTDIvei8oWJJ+0B3wLVqPVFgQe4qiFrqj//g+yGCMJbju
 Fvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570857; x=1741175657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwZLfmhbxwK+26E/jO3zs0lTZenODwUZrbE8CwwZsaI=;
 b=Xfn24uJ8khBcgA1TqjzGyueVtPWS6bTrYUGyaJpjFJQ0WF/SyZNG+PNuFmD6XJbP6C
 5HVDn0F9wiYPv1YC2FC6Roh5CKrT84maXyd8PN3ohplEL8eDfGA3WTEvLvpFIfFu4KRP
 NnSGJ05fgg9pOXVkCrfH9lhJooqFK5Ot72HE6vRdv9mMytBG0VL6NmycVXgijb9FG8aE
 Jn04KjZ0kj3HeZ/rSiz9UGjXWy2qLI5Hj92MLY4qBCTsg19ysRwLHLChBUI9neOw+VxB
 8XVSKg4f8dMzkCrgdMqGY2oqyPcOaBdMCuCOSBjwIJ6OTlxEHgfg8Pcl35knCouPj9M8
 q/Dg==
X-Gm-Message-State: AOJu0YxuogTvn59gGReMBQIHcYLMD3qFGfQi1IjeMPmDEXYNn91HWTwh
 cuvRYjnQldAty0tHJyWV2kbGHampjeCqhDZeYcgBY9DK4flbjoY6
X-Gm-Gg: ASbGnctFLs+3mEB7igWh8LkANhKVtIZmpeKYgVmKrZVIcTeokZLLiv96nkMxsIxuCcm
 m6fWEyQCJX0tN8cRgqq6VTnaV3sIEqFDb0LUAwrQXHIlA0mWIreKt1/dL6e0hKvp+j5vtjXgnS2
 ItgG598Xh8qUuL/S3TbXemXp1EDGJ5lug8mqyShQc284iyyoxLGCLrhvrtgCYTwX3VTrNwRw2bv
 85C6OuQtxWxUXVEAmD0Ux2h9dwiJqou1tO848tXXdV6hL9INu480EBGQLhp/pHLBCUpwiqrCPFV
 wU5J4ZWsTYwe6OZgGA==
X-Google-Smtp-Source: AGHT+IHYoOZuHIVibsjzhhBiBEQoxvRc0PvoFGXuyNnlH3XIv3xPl5EjFoAaPuNDAqoS4bxMVtTrgw==
X-Received: by 2002:a17:907:96a1:b0:aa6:8d51:8fdb with SMTP id
 a640c23a62f3a-abed0ce9953mr659856966b.19.1740570856520; 
 Wed, 26 Feb 2025 03:54:16 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 09/12] video: tegra20: dsi: calculate packet parameters for
 video mode
Date: Wed, 26 Feb 2025 13:53:35 +0200
Message-ID: <20250226115338.42832-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Calculate packet parameters for video mode same way it is done or
command mode, by halving timings plugged into equations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index e1502d8d60e..2beb9ec9f24 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -697,12 +697,19 @@ static void tegra_dsi_configure(struct udevice *dev,
 		/* horizontal back porch */
 		hbp = timing->hback_porch.typ * mul / div;
 
-		if ((mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) == 0)
-			hbp += hsw;
-
 		/* horizontal front porch */
 		hfp = timing->hfront_porch.typ * mul / div;
 
+		if (priv->master || priv->slave) {
+			hact /= 2;
+			hsw /= 2;
+			hbp = hbp / 2 - 1;
+			hfp /= 2;
+		}
+
+		if ((mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) == 0)
+			hbp += hsw;
+
 		/* subtract packet overhead */
 		hsw -= 10;
 		hbp -= 14;
-- 
2.43.0

