Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D44C3ABD8
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B782082B0E;
	Mon, 19 May 2025 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kf1ONWij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7F381F66; Mon, 19 May 2025 10:46:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A14803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so50984365e9.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747644394; x=1748249194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iasu8tCinqbhSor1J++C1Q3fycjajRSfvyPET+TiAy4=;
 b=Kf1ONWijtbX0DQyfpAyz4tn+f5Qc8iCzFyJQbLbaWv5o5tVfqJlugiZtN8MbLI4a06
 1W5V9HQvni+0PUy9lSMDPFBzhTV3a1wWV3cO4WV1di9V3A9SImDchM527hB1dvxWeYTE
 p9a945PUFb2MSRUlBam4lDV+Og68h7qc7nKJpJQj7B0TfyMGjbWVoK+5vGL6hbyucyXt
 +vBxcXbb+1/+EZf2ts6TSMdz9G9WYAy+ANPedJGNExhJRcrF15jzldDYPiCghi00XgIX
 Bqh3D+zlG9FAF4QiAH3qi3yG1ooYxFrFXiucCRvjZ2doQAYdnN6xXbRHZW2OFZP9RE1c
 oBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644394; x=1748249194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iasu8tCinqbhSor1J++C1Q3fycjajRSfvyPET+TiAy4=;
 b=psVNm0JLe4EYK7F0VWtD/7aD0m9mMGIbEuYGU0+UMWyesZOlBLUdLcKhmaPEh4KUAk
 I+ZeMkvFjzeMn++VEm2Q1NuNzKGW1J0AcEbExrBz78SyaD9wDRa94IKAAVwjx9n5h9qu
 HjtHlD7HltRMdfkbncx/Tp27ePPVGBDPFQpGTAcE6q+MYEK97jM6UnrPntwH/JzXQ4ap
 /6fgBn9sWQnN39kyoaq4DH+AouLk8hzVJUpShplRXWXtZ95bv/bS81tqlvpivQGqt3mE
 Zndb5jZ/+kKEKJzgY7KhaT+IT6q7PEP5voF/m0SWwxGsfePxvUIcqZltg/ISDvWNGgVd
 7Fzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtmz3cyxa8nzuc2WbuX6BKphQG2DJE6ASkMDQb59f3r8tNW/tbIhIOkhFq3JxK/SAWtnK246k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx682s+TphMZC+oriajirHjG4Cpckc/u4yabL/zoGyqZtYCnnDN
 2UCqLBla6JAQ4MUlnoYSqvr+RlaPwWM0poCoK6cpeBXlUoem2SynRm0Q
X-Gm-Gg: ASbGnctrYKYHvcjC9HNjj7nbuhCXWCbTEGXyLn2g5a2SbhEaX5Ect7ObLIz07jipCpB
 EKk5b4NrSJF9vyeGSftDotcLQQGQ6xRcVrvirySqefV+70non7PUvdDAp/NOJa0sxm91Js13Lzx
 C/eA9xEsOKWdFFh1cyCExN6E8/Y/XTTms2ULpd6BJVqDs4bHeCV7pY+A0ZbFWwgm7kmCNhnmKeS
 L7rSSmXkfXa5t64OmqKO58L2VIw6+RpqOLTS7DEaO+q9RC5ngaNuNOUbIXO9RrhO82EVJNx1dgz
 S05lLkOh2c7pamzrBWAKCPL7zgw80gGeUfmJIYg2mIJW5PI=
X-Google-Smtp-Source: AGHT+IG57nQI4j4Zo6MdGq3jg17Q6rs4d9BzN2WjF8xsqoTqvq+K4LZvxRH21hvKHOb/Ch9siloadQ==
X-Received: by 2002:a05:600c:4f42:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-442fd60a5bemr108025895e9.5.1747644393864; 
 Mon, 19 May 2025 01:46:33 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:984:e6e4:a4ae:d95d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab3esm133143205e9.40.2025.05.19.01.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 01:46:33 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1] toradex: tdx-cfg-block: add new pid4 support
Date: Mon, 19 May 2025 09:46:30 +0100
Message-Id: <20250519084630.376452-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 May 2025 16:11:31 +0200
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

Add the new PID4 to the ConfigBlock handling:
 - 0098 Aquila iMX95 Hexa 16GB WB IT
 - 0099 Verdin AM62P Quad 2GB WB IT
 - 0201 SMARC iMX95 Hexa 8GB IT
 - 0202 SMARC iMX95 Hexa 4GB WB IT
 - 0203 SMARC iMX95 Hexa 4GB ET
 - 0204 SMARC iMX95 Hexa 2GB WB IT
 - 0205 SMARC iMX95 Hexa 2GB ET
 - 0206 SMARC iMX8M Plus Quad 4GB IT
 - 0207 SMARC iMX8M Plus Quad 2GB WB IT
 - 0208 SMARC iMX8M Plus Quad 2GB IT
 - 0209 SMARC iMX8M Plus Quadlite 1GB WB ET
 - 0210 SMARC iMX8M Plus Quadlite 1GB ET
 - 0211 Aquila AM69 Octa 32GB IT
 - 0212 Aquila AM69 Octa 16GB WB IT
 - 0213 Aquila AM69 Octa 16GB IT
 - 0214 Aquila AM69 Octa 8GB WB IT
 - 0215 Aquila AM69 Octa 8GB IT

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 17 +++++++++++++++++
 board/toradex/common/tdx-cfg-block.h | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 6c1cea77c8ce..a89c5bf2c19c 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -166,6 +166,23 @@ const struct toradex_som toradex_modules[] = {
 	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ,  "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
 	{ SMARC_IMX95_HEXA_8GB_WB_IT,            "SMARC iMX95 Hexa 8GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 	{ SMARC_IMX8MPQ_4GB_WB_IT,               "SMARC iMX8M Plus Quad 4GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ AQUILA_IMX95_HEXA_16GB_WB_IT,          "Aquila iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(AQUILA_IMX95)         },
+	{ VERDIN_AM62PQ_2G_WIFI_BT_IT,           "Verdin AM62P Quad 2GB WB IT",          TARGET_IS_ENABLED(VERDIN_AM62P_A53)     },
+	{ SMARC_IMX95_HEXA_8GB_IT,               "SMARC iMX95 Hexa 8GB IT",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ SMARC_IMX95_HEXA_4GB_WB_IT,            "SMARC iMX95 Hexa 4GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ SMARC_IMX95_HEXA_4GB_ET,               "SMARC iMX95 Hexa 4GB ET",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ SMARC_IMX95_HEXA_2GB_WB_IT,            "SMARC iMX95 Hexa 2GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ SMARC_IMX95_HEXA_2GB_ET,               "SMARC iMX95 Hexa 2GB ET",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ SMARC_IMX8MPQ_4GB_IT,                  "SMARC iMX8M Plus Quad 4GB IT",         TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ SMARC_IMX8MPQ_2GB_WB_IT,               "SMARC iMX8M Plus Quad 2GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ SMARC_IMX8MPQ_2GB_IT,                  "SMARC iMX8M Plus Quad 2GB IT",         TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ SMARC_IMX8MPQL_1GB_WB_ET,              "SMARC iMX8M Plus Quadlite 1GB WB ET",  TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ SMARC_IMX8MPQL_1GB_ET,                 "SMARC iMX8M Plus Quadlite 1GB ET",     TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ AQUILA_AM69O_32GB_IT,                  "Aquila AM69 Octa 32GB IT",             TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ AQUILA_AM69O_16GB_WB_IT,               "Aquila AM69 Octa 16GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ AQUILA_AM69O_16GB_IT,                  "Aquila AM69 Octa 16GB IT",             TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ AQUILA_AM69O_8GB_WB_IT,                "Aquila AM69 Octa 8GB WB IT",           TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ AQUILA_AM69O_8GB_IT,                   "Aquila AM69 Octa 8GB IT",              TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index f4dd853306b3..db612811c5c5 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -124,6 +124,23 @@ enum {
 	APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ, /* 95 */
 	SMARC_IMX95_HEXA_8GB_WB_IT,
 	SMARC_IMX8MPQ_4GB_WB_IT,
+	AQUILA_IMX95_HEXA_16GB_WB_IT,
+	VERDIN_AM62PQ_2G_WIFI_BT_IT, /* 99 */
+	SMARC_IMX95_HEXA_8GB_IT = 201,
+	SMARC_IMX95_HEXA_4GB_WB_IT,
+	SMARC_IMX95_HEXA_4GB_ET,
+	SMARC_IMX95_HEXA_2GB_WB_IT,
+	SMARC_IMX95_HEXA_2GB_ET, /* 205 */
+	SMARC_IMX8MPQ_4GB_IT,
+	SMARC_IMX8MPQ_2GB_WB_IT,
+	SMARC_IMX8MPQ_2GB_IT,
+	SMARC_IMX8MPQL_1GB_WB_ET,
+	SMARC_IMX8MPQL_1GB_ET, /* 210 */
+	AQUILA_AM69O_32GB_IT,
+	AQUILA_AM69O_16GB_WB_IT,
+	AQUILA_AM69O_16GB_IT,
+	AQUILA_AM69O_8GB_WB_IT,
+	AQUILA_AM69O_8GB_IT, /* 215 */
 };
 
 enum {
-- 
2.34.1

