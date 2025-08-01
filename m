Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1652BC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 10:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6464083A2B;
	Fri,  1 Aug 2025 12:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PQ7Jbszf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5338F83A2B; Fri,  1 Aug 2025 12:39:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1264D839E8
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 12:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so893331f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754044754; x=1754649554; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=By+ODiiNpe6tN3ca2GFeVKCuBlmwUvcWHt5jTcrrBrY=;
 b=PQ7JbszfzhThbjoF9gHPOOON4eGCqjcW4PQqUjKRzFKnbsgk0M9ef69orIAZAR16OX
 PqyzKFjKbsTX+YbgzKmXWwXC/WSWBVtuzyWSHx39ywObNSF2B/Ob1viEB/mNPma3iqHi
 PzbBwe28LpTVQheWsSGb69IiG8YrM+Oxb5gfi5L19WUp1frDayMR5n8dZLmuvbNm1G41
 8OukF+NMbgAcXZRe4avBtj8Qe+rQ1piSLlCXeyTYciC6HxYwmh2tR1RwqqDeuu/79oWn
 srB1zssE24LjI2yx+MGbkQvLX7hR4dw/eC12OQ8f2EnuV7zRjbK4EjZzv6/CPT7w8TXz
 zZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754044754; x=1754649554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=By+ODiiNpe6tN3ca2GFeVKCuBlmwUvcWHt5jTcrrBrY=;
 b=H1P2wIJbm3nwu+IrsNQrs5luz6uuHsK8ZWIl8hwwOmxaud7vNOOTfB+os/iSnmLSZG
 vf7fgaEPcqT8GaiSAwT0YYGz4PkITjAuA42kumXABoqjr+0RD4tYYQUvmkqvEHZPxuJw
 wIqWC3yjORtS/hvmQXJC27NG8mdM7oIgCJDeAtTumFXOyFLes8r8/1vIdGGQeZT1lTJR
 iEpjwNXogypPi7kV+akxqHdoWvx0BrFyFVePi4TZw3Z92qc3Eda+jPsHvGj3i4vViKsr
 tZbJ5jcP3q3zOPPPq+4t1a9mbVibkZYKPy+jMWLfp/yUYAsy8m6G9yk2pzFkcnaiZHmB
 AZiA==
X-Gm-Message-State: AOJu0YxftcpSngAUkap+utTakCd6iVe+wVja7sq6+fj7b4r2ojNRNM2f
 X8fge0PgeDdtuQgjZI/y8S/d97V9VTh2Cs2nZ/zpBSWZlNCSQ2cRIzkhu/2qWMbrk5fOOPCnInk
 AqpcuO8s=
X-Gm-Gg: ASbGncvzEdQqZlxsFWEE2G5Wu8X5oh4rLBadM4iI6vaXWTBF/66baJE9bv0YPWx27fT
 cDUwajpRCMAUWHgXxbf/jYbB9jpJPoonxPQBeEnEXWN5hIl/1KPyg++HYNcz4GIAHZ43R74+nzC
 zZq+qQ3Fwn4F58X0e9uLjzlQeihVm9aiFxMxH3ftAQwT8PdyNs1Ef9tjkKAXblD8tX71G3JjUW4
 FtwtxYv1dAKaVcCg+uNU08N5FOgHl3D4HTJAorOf43Jd9Zlc4tVVqUFbnPLoumFN24oTL9rgDp8
 5KAxGfVSvBZgoRYXRd1GeKfKpp3TOsffzoQxTsjK1T9TYH4KZLhsqLW9i3R6kAmSXS/NgT3Wcta
 fz45RzPvPscASJirTFvcpWOPXmCIRPQ2nHqssgCQ8Nlpc1BYtmiI=
X-Google-Smtp-Source: AGHT+IG2P5wisCBBbReWhVlSOTmHd1djT9g8yJq5/GEKWuAXUJ6ixEaKG25EZKLAYsl/IRslxGMg1A==
X-Received: by 2002:a05:6000:42ca:b0:3b7:951c:aef3 with SMTP id
 ffacd0b85a97d-3b7951caf12mr5974758f8f.38.1754044754444; 
 Fri, 01 Aug 2025 03:39:14 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf5638sm59830275e9.4.2025.08.01.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 03:39:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 11:39:13 +0100
Subject: [PATCH 1/3] mtd: nand: pxa3xx: Free memory on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw2-v1-1-bdabdeb35b46@linaro.org>
References: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In pxa3xx_nand_probe_dt if the function detects an error after
allocating memory that memory is not freed before exit. Add the
appropriate free.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/pxa3xx_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index b78b4e60238..7bf54fa4654 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -1765,6 +1765,7 @@ static int pxa3xx_nand_probe_dt(struct udevice *dev, struct pxa3xx_nand_info *in
 	pdata->num_cs = dev_read_u32_default(dev, "num-cs", 1);
 	if (pdata->num_cs != 1) {
 		pr_err("pxa3xx driver supports single CS only\n");
+		kfree(pdata);
 		return -EINVAL;
 	}
 

-- 
2.39.5

