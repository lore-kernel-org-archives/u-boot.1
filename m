Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB45CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085C88946B;
	Fri, 20 Sep 2024 10:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtV4ahxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03EB89463; Fri, 20 Sep 2024 10:13:52 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C76089445
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-536584f6c84so2372809e87.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820027; x=1727424827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQPA2oNB9PirJfGQvYQXRZyYTRomUj/E2bnlK+2Zh+k=;
 b=TtV4ahxXXc8H5mCfl9Hjg1IZrTPxLXS5QbeBAqvw7L+3Lj1ApmdScE/iRi09jVISVb
 NCccxv59VzJtsWnybjbmuTDRsaEvLXOlNkq6UkcIPe1tverlsZn+QZ7FSFWSenClqb2R
 1zi+a45ItziVtGZXe1afD9nnRpaI8Y0Did5Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820027; x=1727424827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQPA2oNB9PirJfGQvYQXRZyYTRomUj/E2bnlK+2Zh+k=;
 b=itPkPs3mT7AEZOXvI47A52vDr4GqZpycRwkHOritIQGgry4zyG/qGK7SsHTDrFiILq
 GmlQi1XlnQjwsTKnliE7eD8XdaDjLy7QoE0bUrId+g3HCBrJHer1GZ8lMwYJMo7YpmUU
 GFtvQMqTUNtkUltjPzqGJQcHUgzTt8kPlXbQHNcDUef+ty6me7O2Fj7VfQ9oNIa9bnNt
 Ht+2LgQmKfFcWjzU1LIfHHvwXsvEIvvPsf8w9zC2gBa68fjsryq10esPwMOYUgFPBAme
 zyTf6DOTYuiXUMhiKrDNhbCdNcRYpGerQXX/l6R7wXpec/NODA45Df79cLPYQFbHQqAG
 v0Cw==
X-Gm-Message-State: AOJu0Yx5CXCDchHcj2lR5owCmloTNXIz1+sg8vvITtBTuaVeebfkLySC
 9uPalWz4Kl7gS3Po18LkQM01oomry+r6t+t/inMlhSPlRfCbr2rgO2fY6fMVhAA5jkn8GEZbthq
 EIfgt
X-Google-Smtp-Source: AGHT+IE5Ogq1iiDE9nIzOrwLFmm00tIzmCzzUX2apCGzlktHvkADzR7U2sWXfLqa0V4MFH8QtMlvzw==
X-Received: by 2002:a05:6512:3089:b0:536:9ef3:3b0d with SMTP id
 2adb3069b0e04-536ac2d64abmr1187325e87.2.1726820027101; 
 Fri, 20 Sep 2024 01:13:47 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/18] lib: Allow crc8 in TPL and VPL
Date: Fri, 20 Sep 2024 10:12:55 +0200
Message-ID: <20240920081309.140426-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

Provide options to enable the CRC8 feature in TPL and VPL builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'depends on SPL' to depend on TPL

 lib/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 4f754c255e8..eca5f8ecb39 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -699,6 +699,24 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config TPL_CRC8
+	bool "Support CRC8 in TPL"
+	depends on TPL
+	help
+	  Enables CRC8 support in TPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
+config VPL_CRC8
+	bool "Support CRC8 in VPL"
+	depends on VPL
+	help
+	  Enables CRC8 support in VPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
 config SPL_CRC16
 	bool "Support CRC16 in SPL"
 	depends on SPL
-- 
2.43.0

