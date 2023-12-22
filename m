Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D937C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACBE7877E5;
	Fri, 22 Dec 2023 06:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qi9iic8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B443386E7E; Fri, 22 Dec 2023 06:46:51 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62EE3877E5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3cfb1568eso13380935ad.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224008; x=1703828808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXDiBDOuklrWro36zokvpc4Gu6GgP5AmL7Z29IfEAyI=;
 b=Qi9iic8nvw2NfOHP6UrbRjaCUZyCFSpPkylo+Gj4oiuwfJYPONDd0zW032lAXwHF9J
 xNTGPMZacOX+mdzVyTlMC+Wo5FR7ARMXG/wlBuwaYWVnfD4G3nQaXqHruRS/4TMz73oE
 UbGxU4ogYiJR4tzc26OhluvXmKez4FN3Xltbu4feag8dYyWhBP9sp5N0uqdgKMU9IDac
 QIxR/jwqlaQhf7C1I/m3mJ9SCfMA9Os4rY6rcqnXqJxP7vA380CSzonvl6YRewKARMRN
 N78APZFZB9c5QMm3tFK6tO9Cx5eGe0f3/L4Y1BclYacTSNRqwIEl+v1+vL9vUzwpc4va
 w2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224008; x=1703828808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXDiBDOuklrWro36zokvpc4Gu6GgP5AmL7Z29IfEAyI=;
 b=s8JONGRSC/nJ/GWwqdiMtVltR3m2G5GMO4lZzC+ewsanG6xjOPPsxw213t23ZdWAt5
 P/28uygIXVFSkb7HOuqctHY7vpIOzIuia8JrZTju4lMcP3oKnhMdY/WhbnqSXX5zNKBp
 NmmhW6h9atlrgyjgizV4BwoRNVkaCvlHxJVtc24uNg4IJYG08+SmjFNZaVQynZ/TXR/J
 6wS7KS4Q8ZQNcZL2mfQu2iYknJP3Q1mJTLEZ4GzXpDp/DC3JEoSWQmxMf0jSFeTZ5JpU
 NH3KBkhyTfCiUgkF5ldd8qg3a3DYsS92m4vSyE5/g+tIxQd89rJV+B4LBxvEgoYf/3N3
 n75Q==
X-Gm-Message-State: AOJu0Yx0bZYuElblOBF74oYahvsx+CHT9ltuUKIfEsUhiLeyyUmDfe3/
 w3k/701yzHnB3+Ok26URtXVKBfZ7zdE=
X-Google-Smtp-Source: AGHT+IEIr9uuyw8ofoWrD6m00ovcxQuVh5Zqq/ZPiZB90rNNGbFMEzW3SLzua+T3yXqkrofo145bDg==
X-Received: by 2002:a17:902:760d:b0:1d0:6297:150a with SMTP id
 k13-20020a170902760d00b001d06297150amr853601pll.47.1703224007731; 
 Thu, 21 Dec 2023 21:46:47 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:47 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 5/9] mtd: spi-nor-core: Rework s25_mdp_ready() to support
 Octal DTR mode
Date: Fri, 22 Dec 2023 14:46:02 +0900
Message-Id: <590a68b594f61e8ec2315f3c0b17e7dc43a21a5d.1703220284.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

s25_mdp_ready() handles status polling for multi-die package parts that
requires to read and check status register for each die. To support
S28HS02GT(dual-die package with Octal DTR support), rename function and
use nor->rdsr_dummy in octal DTR mode.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 20e82aaa65..fe5579db4d 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3340,13 +3340,13 @@ static struct spi_nor_fixups s25fs_s_fixups = {
 	.post_sfdp = s25fs_s_post_sfdp_fixup,
 };
 
-static int s25_mdp_ready(struct spi_nor *nor)
+static int s25_s28_mdp_ready(struct spi_nor *nor)
 {
 	u32 addr;
 	int ret;
 
 	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
-		ret = spansion_sr_ready(nor, addr, 0);
+		ret = spansion_sr_ready(nor, addr, nor->rdsr_dummy);
 		if (!ret)
 			return ret;
 	}
@@ -3416,7 +3416,7 @@ static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
 	 * all dies' status via read any register.
 	 */
 	if (nor->mtd.size > SZ_128M)
-		nor->ready = s25_mdp_ready;
+		nor->ready = s25_s28_mdp_ready;
 
 	return spi_nor_default_setup(nor, info, params);
 }
-- 
2.34.1

