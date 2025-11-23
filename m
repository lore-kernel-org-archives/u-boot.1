Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEF8CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 00:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBDA83C54;
	Mon, 24 Nov 2025 01:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UwTAoB/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212CF83B95; Sun, 23 Nov 2025 21:45:19 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379FE83B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 21:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=chbgdn@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64180bd67b7so4790086a12.0
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763930717; x=1764535517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oqniA/RZ2MrXpOTh0gTuINxqWukcB0COKWfly5yhRaI=;
 b=UwTAoB/9F4OF5TDTRBf2S24WBze0ih+oVb61B+j1tFbKwvfGNEYN/qLHm/RmgncW4m
 I1yCv8pxOFx01dZE2aZPOteIDdf+tWjUId57xQfK9jl5WiHNv8fgh8FUraco+8SB5q/6
 QUpttV3fn0dNm8BzWWwpmNIQptaweuv3ALzy4jbid4bPJvYVv9/jaCMdAyJkAJoA0q80
 xexWQIIMGnn0cop4Rvt5p8okruSxCbSLRB73iQDrQZWLhHfprU3JT0LlFi3DcGwr0HNi
 RsI9L2+jbjmvRKKEmGFq0Et4uLOYcRyRqchSJyE5/4dsmhYZonrdyUCr3PIrbEywcrGK
 5I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763930717; x=1764535517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqniA/RZ2MrXpOTh0gTuINxqWukcB0COKWfly5yhRaI=;
 b=IMTblAuI+PmJnkhKCo4g7ZcyG78t+YXvtotju+x4K4QEHYtmsV9SBGSWa8JizPSEls
 dWOz4Gz/OyNhRt4u2KgWLHY4Pj0G83BkhlQC+lCfgzE05ZY/U23fRcPa7l3z6BXUpXXJ
 n0Bc6pgYv8/EcSH47T8JyHCbmTU+MpGHPuH5x5vng7nAyCe7AsaNGPucsmUjRi0RpepR
 Ri7y3cz07zyC3Kq85+dGyiC6eBq3TNvbhWglJkYlmm32UzLWpd00eh/OHrkKxdaXAS4q
 sUFWSDOxhBKEnTvgXmAOPmQmivEniOz/TxrswhbB9WxGz7GseBH5c5LROkw+NHnQD+g9
 ggEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1rAq11jitSdFnPqow7EEocuPd4RGGNtV4pHPP7gMSg+WzfBUQ2/qNgaekzla133iFwRCau0o=@lists.denx.de
X-Gm-Message-State: AOJu0YykBojMMG50zXjaSKl+qAo2vzvC959vQkSmY2rKbspLRY1JJXmm
 d5p2cJRa6h2ZOk3nAIEwIFPsi/4EIX3VpldrgbnG9QduwSS6Fkv1a3KD
X-Gm-Gg: ASbGncv4ft0hF4OdxJ6IdGN0tQx8zmBQRRWdOnDFe1vaCbd0Ob5YRRmDx12DWqCVwGk
 3sPJUnF4kmnXx/NCub3y1aBUCe1N/AlHcnblOr9F1n8HV2cxbc3+ZeUz94lId4bAgfxLh8KFy97
 8NYurhSZp0cPQcFzuhLjL90BuCYNQBzd+4VtNbyS7e/aQ3CFyAQzh/fyAv4UESZQHdMLnGpGG+P
 yEoM7OxlCRBTGLf5Ag141mQs3PgToviOwZAOL+l1D0xVD+dZA3/5n7kWwINaWQXSbgQA/RHWnTu
 +eKxR9xI/2krFtdQkkwr/l1aKiRo5HOgjhiwUHMoZWa4N1Ipa5MhfBKk0ayItqsCzu5T+XfjZGi
 0HhdEtDYUaYlgnev/0iTitPJXl9MW6rNE9XcFS8G0B/yOUHXPNND/cBzrsvXzpg==
X-Google-Smtp-Source: AGHT+IH2D//ldftTLqefMSvHDQWdHu13K/D1YmYvWA9WjcX6Fyf9gR3Y7mIMpra023Ueu/IRsYaOKA==
X-Received: by 2002:a05:6402:4146:b0:645:cdc7:ed91 with SMTP id
 4fb4d7f45d1cf-645cdc7f149mr699254a12.32.1763930716440; 
 Sun, 23 Nov 2025 12:45:16 -0800 (PST)
Received: from Bogdan-PC.lan ([2a01:d0:9759::4cbb])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64536443729sm10056168a12.24.2025.11.23.12.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 12:45:15 -0800 (PST)
From: Bohdan Chubuk <chbgdn@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de,
 Bohdan Chubuk <chbgdn@gmail.com>
Subject: [PATCH] sunxi: avoid double vendor prefix when CONFIG_OF_UPSTREAM is
 enabled
Date: Sun, 23 Nov 2025 22:43:46 +0200
Message-ID: <20251123204346.1847095-1-chbgdn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Nov 2025 01:56:21 +0100
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

When CONFIG_OF_UPSTREAM is enabled, the device tree name provided by SPL
already includes the vendor directory (e.g., "allwinner/board-name").

The existing logic in misc_init_r() unconditionally prepends "allwinner/"
for ARM64 builds, resulting in an incorrect path like
"allwinner/allwinner/board-name.dtb".

This patch modifies the logic to only prepend the vendor prefix if
CONFIG_OF_UPSTREAM is NOT enabled. This ensures compatibility with both
legacy builds and the new upstream devicetree structure.

Signed-off-by: Bohdan Chubuk <chbgdn@gmail.com>
---
 board/sunxi/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 2929bc17f08..c68b51d370d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -834,7 +834,10 @@ int misc_init_r(void)
 	/* Set fdtfile to match the FIT configuration chosen in SPL. */
 	spl_dt_name = get_spl_dt_name();
 	if (spl_dt_name) {
-		char *prefix = IS_ENABLED(CONFIG_ARM64) ? "allwinner/" : "";
+		const char *prefix = "";
+
+		if (IS_ENABLED(CONFIG_ARM64) && !IS_ENABLED(CONFIG_OF_UPSTREAM))
+			prefix = "allwinner/";
 		char str[64];
 
 		snprintf(str, sizeof(str), "%s%s.dtb", prefix, spl_dt_name);
-- 
2.52.0

