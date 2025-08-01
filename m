Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC75C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 09:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01F783A1C;
	Fri,  1 Aug 2025 11:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DccotSVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5C283A05; Fri,  1 Aug 2025 11:54:13 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ACC83A13
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 11:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783ea5014so400432f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754042048; x=1754646848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lTukS27oYCucSASAInpMBahtzHjguq7iNg2FVwjXyFM=;
 b=DccotSVnrVOUrZdpIG9c/vj4tlhHIEasqXYjU0QBv5Gr026GpyB9XVmSLvw+LvHtK0
 Qnp5JLBaPVP4WGYD2aggslIxgbcBRUgUG3ABlU5yagEpHx+q/GBoVaznA071vSMEYKtN
 xIHeIeUKnfkssY9Q6cTT/y4j4qHKtHZlifZ7+58/vAuzWsQsi3KSpMYtJSd8P0P0it7P
 4BOZNX+d3JBb0w5i4jVCDivi/wHGfvaa5ix/05zQsV5uTgk2sw29ieCC60zWVxARIswS
 3I2Q4DeZE1pXudjySSx2kpBxt0mbgFhMeFBXPXZce5CUuBGcTVtmpDb68a6I93fTzNd4
 YQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754042048; x=1754646848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTukS27oYCucSASAInpMBahtzHjguq7iNg2FVwjXyFM=;
 b=tMaaKhwNksD2xuC5/ZgYL7FMCnHxpW5jJhWjggwpY9D4fCTy7JqNzAyXVARxcBLryf
 RhOGnpcT+SNeUBhNdhqzTcM8oewVEAjhyItGuidNo+NwF2kkX21HkrEMjaKZFS1B1BDu
 TCnuCGL0eeV8Z0MLowVfIia3dfiBNYfZPwDzSmXoaqMg/6ekK+IPfWRP3dOYwZ4BeKLN
 qznIyw3rQYB79If7Mqz+KsqlxbkohYpAcsFHCJhvNX/1IZbBpwShQ82nXq+YhwSnwazy
 VPl7RgK8TfEqrEdd9z1r+j6f3QV/glohPNZq4HodX2RgcGof666KM6oBPi3b37IZLo5F
 945g==
X-Gm-Message-State: AOJu0YwtOS129RKwDSVH4Mk1IENnICyy++YkG7yPDl/+kN0cjhc2XvI8
 Gtd3LFeP+fjpOVAOI3OSEknr+l0dzBx1ofFOny/O/1/VGkuSKPV8tSxIbCAjqTDbkN8=
X-Gm-Gg: ASbGncvqODoLI7cKHBnZk8OGKDHb25YO++4VTB72eN/lPs7blxTshZdNUYB8wEnqmyy
 RyQmgxpmlj9O6an5/Q/c21jH98E8zcfVPy/m+vG10BnrNR8IM/s5tZpg4ULQrQzwHHqSIK9SnIB
 DZmks6HuHlnw60oUR6ddP/lHYu8Jv5UknfL6XTqKQmCkSm44UDjYyJ8X8+Ug8EeKo4RMQaV/Hjw
 nriNLBH9hEZI6I+fasw5pjfQK5dlmzB+iN/GzBnODqebdrzYrq++9TP2MM5eD/2zei49wdlSlaj
 /FPTkXlu8Ud6RN/Lnd3p/+WIwTVAwUhwZmiTI7FsM+BSlU29tk8s+R4E4YDU6t+iX4yOKyWU2ul
 HQBRy4XxckiZvbY52jzF3BBXTWSBjc072QOo/WZC84UCkT7cDg9oCq7a/chiQGQ==
X-Google-Smtp-Source: AGHT+IEnvDPy9yRHp2u21vcKkv/p45dhMkTI7R15PqOOKGw/5LoFLBEYEixIlA7HzBzlgUFee2NptQ==
X-Received: by 2002:a05:6000:2891:b0:3b7:b5c3:5dd9 with SMTP id
 ffacd0b85a97d-3b7b5c364e2mr4633104f8f.57.1754042047808; 
 Fri, 01 Aug 2025 02:54:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eba17sm95280515e9.24.2025.08.01.02.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 02:54:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 10:54:06 +0100
Subject: [PATCH 3/3] mtd: rawnand: mxs_nand: Ensure err is set for error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw-v1-3-80c316f5bb99@linaro.org>
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
To: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
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

In mxs_nand_init_ctrl there are a couple of error paths that do not set
err which could lead to the errors being silently ignored despite the
function not completing. Rather than just using if to detect these
errors use err to collect the error return value from the called
functions.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/mxs_nand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index ba67466069b..fecf1f5ba91 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -1640,10 +1640,12 @@ int mxs_nand_init_ctrl(struct mxs_nand_info *nand_info)
 		nand->setup_data_interface = mxs_nand_setup_interface;
 
 	/* first scan to find the device and get the page size */
-	if (nand_scan_ident(mtd, CONFIG_SYS_MAX_NAND_DEVICE, NULL))
+	err = nand_scan_ident(mtd, CONFIG_SYS_MAX_NAND_DEVICE, NULL);
+	if (err)
 		goto err_free_buffers;
 
-	if (mxs_nand_setup_ecc(mtd))
+	err = mxs_nand_setup_ecc(mtd);
+	if (err)
 		goto err_free_buffers;
 
 	nand->ecc.read_page	= mxs_nand_ecc_read_page;

-- 
2.39.5

