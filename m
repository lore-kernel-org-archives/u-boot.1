Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46603C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698D684B14;
	Fri, 10 Jul 2026 20:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N4KSj345";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DFB84B07; Fri, 10 Jul 2026 16:33:18 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2F784B32
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso1086897f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783693995; x=1784298795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bc2f4P4Z0Y3E5xN9NgmndVxRAm/CV4IfTAhGn189JlQ=;
 b=N4KSj345ZO6EhiuVThK/y3HXzgaT7TJ+cXwRE/cPTOH4xPnz4Dw5tu1Xsz1IiySmhi
 halLqH1RZr14QE6nlv3WIdZjiIgFB+2adFAk+oN8niWZbBDF0TPrHXxlwpK2N7fZgFiX
 kJBa+0TT3S6mtmqFLLL9AkK3UKDVNpMF+w5WZ4x23DffNEvjh0urfT0jr5Tc62ZqYSwq
 brdrGi+qMzlzqodIzRgV8NKM9cZEd0La5ApIjJ58DSUl3Ib5TatEJDUX80hQOJ3SfR8u
 JTOP1yGn7KSNjAyVK7xgSDY1JLkV77o1kIdbayk9m1dTpO7xew2lZeHcRIp6qmgkO4I/
 rRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693995; x=1784298795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bc2f4P4Z0Y3E5xN9NgmndVxRAm/CV4IfTAhGn189JlQ=;
 b=j64KMD9ICEUk3WUM80Y4EUsTH5gP6BVaR8Anp780e2MZrcLk5GXMbpdcksfhzy2MzO
 YsFgJL22xNfKjD3TPdB/NYMXBYzpf6gzTOqQN+TAIZBaUNLjoj/TSUk86WN2PXtLcHQr
 vSmPy/j0Sx7RPygtKQ6djvcqGbcZQQzpG4uRCS3aA6XusIDTQY2+/3frC0xzTxmK5kni
 dkpa03JuLT1cJWBi4nXM/7MpaYH/fYOa5Im3bwYfzCXng9J0oH2MOvN0uXZPZVVXpg6U
 Z+XGEW1nKA1jOEeisWaw/qvFSU4vZN9fRC12hhjkUTi2lsb1YPiyXP+KbeDI/eDs4V9L
 xSgA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk9EjO4l/AjSYhvY2QKw70eYNnCM4G4ftjpleM40bOBykXWv6WtIqyRKiTiqsQDGAZ25ctmj0=@lists.denx.de
X-Gm-Message-State: AOJu0YyoqpW382JeqGwxtLBil3iE3HMAiCL4Pfg/q6fi0mNX/kVe9xAt
 u8W3/RUuqGSVuS1TS+3YjxGjNXCBk9nulzeJpXav6JkS6w1y4POHwJmS
X-Gm-Gg: AfdE7cl8fTnLyNVn11QLoVbpt/0TAJ/yRtbtfIBP8473oOFVXju7qaU+5sOE2mjGxml
 Y5azb2gC1hQspIdgzLaR/riyitotcqgUwaN+TTcsvhmO8z4gd30wxfIeSM901OvKjR1Bl/e6JYr
 4sjEpAaNDyflFP8G6KXkbXgrE4kWy9dauBHFq9rWmwoMWJOaA/BWc1skVLONvf4NWri5api8/xg
 4rU7emFtQ39eiNfQSPKsvPr2UhrZ6NvBe/2qUAPxyfj53t1Zc19vhHSJVxQcqfmCR279GYLuCLD
 92tlcV9ua+Kf0Jo6WcmHjZ7qoR6yGM1m5Mhxn7NpVEwpmGDZjAJnaUTu2ZqtFQPoEIhG/4+9Gnf
 wObj0/msCz4n9z6WXX3x4N8kOIO1p5/SEj+nykC08xKJBww8Q365ZA6b0UMtHeR/yu9aE2yb/db
 JLgAmFo5W3ArBoO/w=
X-Received: by 2002:a05:6000:238a:b0:46f:a0f1:c33f with SMTP id
 ffacd0b85a97d-47df0797e16mr13529251f8f.32.1783693995078; 
 Fri, 10 Jul 2026 07:33:15 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:14 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/7] toradex: tdx-cfg-block: Add smarc imx95 0229 pid4
Date: Fri, 10 Jul 2026 15:32:59 +0100
Message-ID: <20260710143258.285091-10-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the new 0229 PID4 to config block handling:

- 0229 SMARC iMX95 Hexa 4GB IT

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 896a0d3bd126..c46dd46ca981 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -190,6 +190,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX95H_4G_WB_IT,                "Verdin iMX95 Hexa 4GB WB IT",          TARGET_IS_ENABLED(VERDIN_IMX95)         },
 	{ VERDIN_IMX95H_4G_ET,                   "Verdin iMX95 Hexa 4GB ET",             TARGET_IS_ENABLED(VERDIN_IMX95)         },
 	{ VERDIN_IMX95H_16G_IT,                  "Verdin iMX95 Hexa 16GB IT",            TARGET_IS_ENABLED(VERDIN_IMX95)         },
+	{ SMARC_IMX95_HEXA_4GB_IT,               "SMARC iMX95 Hexa 4GB IT",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 9a96bddfbe17..3ff7c2b6376a 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -153,6 +153,7 @@ enum {
 	VERDIN_IMX95H_4G_WB_IT = 226,
 	VERDIN_IMX95H_4G_ET,
 	VERDIN_IMX95H_16G_IT,
+	SMARC_IMX95_HEXA_4GB_IT,
 };
 
 enum {
-- 
2.54.0

