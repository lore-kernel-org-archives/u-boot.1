Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C30FC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5974080885;
	Wed,  5 Feb 2025 02:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qp6PLQFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE0D805E7; Wed,  5 Feb 2025 02:57:08 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED47800B3
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f4c111991bso213574eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720624; x=1739325424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRfYnfEcnqSuEXCbiUUUujcD1iJiv9LH9MZDSN6eB24=;
 b=Qp6PLQFR40N/YPqCgMq95JPEDoaj138ON8vtrUl+xyezlmgqy/nPjmxZ2HTB7ElfPN
 xE41XJPXklaRJRk+fCFYEGqYlOt06z6o7YuKv6YJEM5ATO/OjRFHqeoUqUHYThP+j7Th
 rAyvt/QFUJDSsFqRhW0PFWPgpBqdsJyaePwIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720624; x=1739325424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRfYnfEcnqSuEXCbiUUUujcD1iJiv9LH9MZDSN6eB24=;
 b=RtOZMJHSfB667tD3N6hUx8FwK9lSfhFq4XRh0CJEhPgVVKbnDsxhnfZzGWJX+B8dAL
 /Uco5H6R958xewVSsMAaNbwskdCNTsK6rUAE/6hJefF0rN0A6irCxu0PU0K5muBhn8/b
 5tTJi17IuAT9ix8i6KHwi0mBrEBmNhNw4G4Hsfs6mOPuhp/nRlOKCdM+7UVFyVR42QUr
 igUmSwf6gDygbaEho9yaQo0zT+BZph8ckPWx9BETrO/clxXaIlgSTgotIPf4krlUj70H
 e2A+CZHxhipNZTddjraqdX0180dvGnAsbVcqIbOEOoQqjMKJwCU89PnAgYX2Y9RGeSIS
 iByg==
X-Gm-Message-State: AOJu0Ywelts4f2/FxjXSyoMnb4xe+8CL1tMJhgd0wkBQ/tzR6UD5d4Fj
 XDKqkodkGUTfB0pYXKF+KGwDElqft70QyCqkTU1xFJB1hUVIvXNw26xWJBNuRk7sg5c0UMxQuks
 =
X-Gm-Gg: ASbGncsYGsKDivDbLzyXTS1HAIbzHiZkHM3A0spj/qeWxxK6zLgHMXpNSLFsvlLWtJo
 eAuKcIQDn3iDsVXvND3vGLXtHWvqIMRWnDfPGSm94q1q2WTuwMDqutCWWr16wEN4MBlDXvUAdFN
 0Vf5panjWRFLvAJxn28URgVUANi/poB5qhPmbRt/QLsWjC4CO4rMOaJASUica+1lCnf2OLoFrRW
 v1cXHoqMIpLB3lKzZUapj+4Q4jWDAd6KBcYo6LTA//KL/ms+Y2l51jFe0f+yL7e3scQeAXZHDF9
 lvhTvgmaSS4/9ep3kG2yT5y/jxlINxTmAh0QF9wuqQhU11Xnv3hV
X-Google-Smtp-Source: AGHT+IGKnJO6kZHRvRQQh+izNaCETyGlxQy2b2jUILn4TzmwfsDIP2Q8TlQupivjmjCmEJ0vmsVgSg==
X-Received: by 2002:a4a:c816:0:b0:5f2:b1cb:3efe with SMTP id
 006d021491bc7-5fc3bf86f09mr3287517eaf.4.1738720624331; 
 Tue, 04 Feb 2025 17:57:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 14/29] rockchip: Add SPL into the main FIT
Date: Tue,  4 Feb 2025 18:55:04 -0700
Message-ID: <20250205015606.2686149-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 7cce213c32e..39908495894 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -72,6 +72,25 @@
 		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 		fit,align = <512>;
 		images {
+#ifdef CONFIG_VPL
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+#endif /* VPL */
 			u-boot {
 				description = "U-Boot";
 				type = "standalone";
@@ -172,7 +191,11 @@
 				description = "NAME.dtb";
 				fdt = "fdt-SEQ";
 #ifdef CONFIG_ARM64
+# ifdef CONFIG_VPL
+				fit,firmware = "atf-1", "u-boot", "spl";
+# else
 				fit,firmware = "atf-1", "u-boot";
+# endif
 #else
 				fit,firmware = "op-tee", "u-boot";
 #endif
-- 
2.43.0

