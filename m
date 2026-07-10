Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2238C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F410284B67;
	Fri, 10 Jul 2026 20:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+MvI5ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1090684B32; Fri, 10 Jul 2026 16:33:20 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2628D84B2B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so257943f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783693997; x=1784298797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oya1VG7WAIH04U/xErTr5e/MHUEhDu/1LaIXl14MOfA=;
 b=Z+MvI5ihSjpNjVqVd3W5aO9RTxv/B7mqWt36P9mqMFauS5dJpxV1z+R4m6XJK21/98
 yJVHnnLhgLEuE5gElATExREk6JGR5icY3kqChVjFee1jtwdUoRkAt/7m6fuoTcIwa0y2
 0JptzMNVx+R/MikwIc6xlrnzmAItqK4Y44SvddCvmaeWnj22g7RSxbHChjoBEQpmw/sP
 eYGlKjPIH26iCzMftax1bU2Sb+YO+Yw/bHM+2uIQ4ctw3BfIqB0s59nCGl/ZOmqQJToG
 HgdxvIU3YXBNdG5MGBJ282GieTB3uTQPbJP37dVhXRU/4RzLmAE5w58liWwi22QjWJ8N
 eq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693997; x=1784298797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oya1VG7WAIH04U/xErTr5e/MHUEhDu/1LaIXl14MOfA=;
 b=MJx6HuCE0lz/G5n754/KVvOS3uRoWJGqmF6qPwDWGuDiww6zmW6DLbShgTz7o09Uet
 LK0unxogSIMcj5MKkYx93bGTMumeMvQdiqAVT4QCwCVa55IlhQFJT2j4mtMoc9tQ3UDJ
 SQswgZ+wOj3TuebKm1DVd+9PQMkktabNONRbXsawoy1k3oZQEqZtHeStTH2Gf6Rbnivl
 5qmFQnzbD5nJHx4i9FpuLZTTYE/zvESeT0nOH9GJIugv0xlk98AL2ZC5y8B2qB3mcrrs
 sVTpLzWLhKtZfjSdDc3gArFCj4uzOFEn/81i9q99M1s6pKBK0eDCKuNmZluYOz0xn7Tq
 h34g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfOajLn96OCSRs617JzzVk6nuKsKuoUNcKg/7sTLfQYTS7txyZ5xg+5ugYHsxOYsHA1xQUvlE=@lists.denx.de
X-Gm-Message-State: AOJu0YzN7GGtXiJk1BfvFgFh1Zv2OrjGoYW6ScfpUjdd3a9Tj+a2ObYf
 EIpveNK53r/xD1myBTu4w2YZnX/VSlFJtjj0h7I5WS3qFyUt7VKGrWOK
X-Gm-Gg: AfdE7cmqRZE17IfdADfjkvE0B38/jcLB/VK4XQQwW/AoionN8gPzr8rRT1kMqkOdeh/
 zg554kp/eIBEY27Qe8YdI3JfmO2EB0p+yDOaDS6HKGgBmw27ltHhrGHDkjMhyk3CriNwywuEdzB
 mHpoMp2BBTWvTcQyPqD8J2uZwqfiYnIsqzFQheE5Qha8q/GZToRCjb/TGyEhwiF7waKD34L2e3x
 KcPbVopG+mqbIgn0PxjK7iQ3lnzxTxb0adGfg7oMMdw9jUk8LxbAkZA19TXOwaUBx9DodCSxKRN
 quZjzIvrspKzMW/2JEd1qcggt3VdILggSgL+64Y3zpsmiw778E41g9Ut+NU9ZDz8ouTtJIIm2Qy
 +zSwtX7fng1HWxJNm78o6GCp1BWNDENyp+PuHkdKbSQYr9Q88Ot8QmYGUEOfyi+lomL2hhT8zo8
 ln74VUGg+jUYsbZqQ=
X-Received: by 2002:a05:6000:24c3:b0:462:fdf2:3a50 with SMTP id
 ffacd0b85a97d-47df076a8bbmr12354193f8f.32.1783693997498; 
 Fri, 10 Jul 2026 07:33:17 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:16 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/7] toradex: tdx-cfg-block: Add apalis imx8qm 64gb emmc
 pid4s
Date: Fri, 10 Jul 2026 15:33:01 +0100
Message-ID: <20260710143258.285091-12-ivitro@gmail.com>
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

Add the new Apalis iMX8QM 64GB eMMC PID4s to config block handling:

- 0233 Apalis iMX8QM 4GB WB IT
- 0234 Apalis iMX8QM 4GB IT
- 0235 Apalis iMX8QM 8GB WB IT

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 3 +++
 board/toradex/common/tdx-cfg-block.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 3ac253e69ead..21baa810f2f4 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -192,6 +192,9 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX95H_16G_IT,                  "Verdin iMX95 Hexa 16GB IT",            TARGET_IS_ENABLED(VERDIN_IMX95)         },
 	{ SMARC_IMX95_HEXA_4GB_IT,               "SMARC iMX95 Hexa 4GB IT",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 	{ AQUILA_TDA4O_8GB_IT,                   "Aquila TDA4 Octa 8GB IT",              TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ APALIS_IMX8QM_4GB_WIFI_BT_IT_64G,      "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)          },
+	{ APALIS_IMX8QM_4GB_IT_64G,              "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)          },
+	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_64G,      "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)          },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 8fe76640c461..e6e726f381cf 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -155,6 +155,9 @@ enum {
 	VERDIN_IMX95H_16G_IT,
 	SMARC_IMX95_HEXA_4GB_IT,
 	AQUILA_TDA4O_8GB_IT, /* 230 */
+	APALIS_IMX8QM_4GB_WIFI_BT_IT_64G = 233,
+	APALIS_IMX8QM_4GB_IT_64G,
+	APALIS_IMX8QM_8GB_WIFI_BT_IT_64G, /* 235 */
 };
 
 enum {
-- 
2.54.0

