Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F626D68BD9
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 04:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CC283C6E;
	Thu, 18 Dec 2025 05:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbbdLIZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3B383B49; Thu, 18 Dec 2025 05:23:06 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A8F83C67
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f2676bb21so2514615ad.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 20:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766031777; x=1766636577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufVWzI2/mSqW8rtxrGSvMrBkIuFiaXM9e2tHnCm0C2U=;
 b=CbbdLIZLMcqoAlUGpy0F236YPbVG9wJ1Q7Z+dons6E1j5SSeGekPEOo78vg43ws7nz
 3VjW5jEtnrdlHYDjaahI2RVV3KlA1zGlahrgidBp/g6g/KjdONJwBEMsTo1lAGTYsnxk
 IEGfBaYODUUyPND1bdjHRQcD3/uYjbfVyLHDIzhTWNsj5Ta88qYyVFswZiiGTkv+nsFw
 9LH+zifgx+2vqyXMeQO8i9bxc7/ILOy6A/Rgt6vHqBE98LFCVktTFtK7V0mCLt4UtvnS
 EdeP8QYRdVEBEB+uTJy58Dbo8S/zEN5O+E7EsvwuJjyL+IVSQsjpA8eIN3vG09s6ZHmR
 v6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766031777; x=1766636577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ufVWzI2/mSqW8rtxrGSvMrBkIuFiaXM9e2tHnCm0C2U=;
 b=Ryncl2R9TfIHI5Ak6V60Qo7IBvjq3kn6fyvJYfU/jjjr7i5xv8NpqzZ5oeCAG9NnKC
 q2jI+5/b0RnP3+bdao4RRFWjmR2YJS6kig8B9AzqvFc5HMeUsOO4ZjF9ryKnmLApfbhR
 6Nbe4Fg5fvYOXnY/yn4W9N0ImpIWZpliDTHlXLKNYIu3+SF6ID6UDOz3df4HXZ8VU8sX
 sKyjru5v1M2R8txP7YTDM1946awNBtqRiXDqOJLraujEGesio+QFUu9cORV+RVpw7WyB
 1tGhcngTk6aNivlxRNShNSmzEH733cwki00EPVY8bn54sCMO0Av8DUeBFoYlsLXmS8JH
 8GjQ==
X-Gm-Message-State: AOJu0Yyobr7iJBoDml8jt7hYvb34MLo6SfHwMj/aby86uGI+W+Hn3ETQ
 qEqsl/wyUoiWKH432ZT0v93Z91q7UDYvRnOqJXxVU1TUuv2WiyjMA1zc
X-Gm-Gg: AY/fxX5mdPhTg0ZeycLlj+JVcrg8UuG5S9kLiANNaeUDsunsI877AnB5dWNXDfmH2wV
 aCnzVgTHbP4ciYv1Q7OdGDWgYTAdhwxNajKgD7fybN6pq9Y6FJ2fOtgCQyAyORbOsIXSLXEM7As
 bA4/Tv24nmQZDLg6h+GqmvNaoVo0Qd++yR2mIfFrRvt40x3HIsQV1cEMBnWLKEBJ+xQqCAPqdsO
 +kFaZeqKy7Uqzsi2++E/LibZziJNj8x+lxu8NrsuxPwtSTqnCUENXG9Fzfo+UqfFk0DXs2Pg9HR
 ICUghz+T4Ws9sFjGCLE8hmvOthDTw7L5otd2/r9HyoGEWU6E/lX5h2OLWhHZRMLhT0eVbw8CB3G
 4Tb45Qmf4TRMJf1+ouIyPECIAdDix/a6WIScJNqZ32cdiqc/H+Wf7FpmcQRgZWs4JL21TPXOnZd
 CYjQWLp2pWWOLCm/75ttydHjUZ
X-Google-Smtp-Source: AGHT+IHokbSlswmwkCGkbKhosVu+QxClOyIeQiDnhI+hco4iiMnvmwCcueG9gBvEjhFDW2CkwURBxw==
X-Received: by 2002:a17:903:240f:b0:2a0:a8c2:be5d with SMTP id
 d9443c01a7336-2a0a8c2c178mr174349315ad.5.1766031776686; 
 Wed, 17 Dec 2025 20:22:56 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:73ef:52b5:685b:7c64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d087d485sm9305655ad.16.2025.12.17.20.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 20:22:56 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org,
	seanga2@gmail.com
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 1/3] mtd: nand: pxa3xx: Use pr_err() in some places
Date: Thu, 18 Dec 2025 17:22:42 +1300
Message-ID: <20251218042244.1833380-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218042244.1833380-1-judge.packham@gmail.com>
References: <20251218042244.1833380-1-judge.packham@gmail.com>
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

info->controller.active is not initialised so the dev_err() call ends up
dereferencing a null pointer causing a crash instead of outputting the
error. Use pr_err() instead as there isn't a convenient dev in the
places info->controller.active->mtd.dev was being used.

Fixes: 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx with a device")
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 drivers/mtd/nand/raw/pxa3xx_nand.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 7bf54fa46540..e1d8515bd9b1 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -588,8 +588,7 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
 			ts = get_timer(0);
 			while (!(nand_readl(info, NDSR) & NDSR_RDDREQ)) {
 				if (get_timer(ts) > TIMEOUT_DRAIN_FIFO) {
-					dev_err(info->controller.active->mtd.dev,
-						"Timeout on RDDREQ while draining the FIFO\n");
+					pr_err("Timeout on RDDREQ while draining the FIFO\n");
 					return;
 				}
 			}
@@ -641,8 +640,7 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 				   DIV_ROUND_UP(info->step_spare_size, 4));
 		break;
 	default:
-		dev_err(info->controller.active->mtd.dev,
-			"%s: invalid state %d\n", __func__, info->state);
+		pr_err("%s: invalid state %d\n", __func__, info->state);
 		BUG();
 	}
 
@@ -1560,9 +1558,8 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		ecc->size = 512;
 
 	if (ecc_stepsize != 512 || !(nfc_layouts[i].strength)) {
-		dev_err(info->controller.active->mtd.dev,
-			"ECC strength %d at page size %d is not supported\n",
-			strength, page_size);
+		pr_err("ECC strength %d at page size %d is not supported\n",
+		       strength, page_size);
 		return -ENODEV;
 	}
 
-- 
2.52.0

