Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F91C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDE583045;
	Tue, 29 Jul 2025 18:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QnCClH/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8E0831A4; Tue, 29 Jul 2025 18:16:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AECE82F00
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso57201575e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805779; x=1754410579; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=me7DcGCMJxl2VSVGe1i1MtnORMPqtHdBH7NZfh+M8LM=;
 b=QnCClH/wePAhmKufx7gu+30/44ZdKiJ/GMKNhgF0aI77nx4cpEv6rVGTAFRKg8qbOp
 /hXIgOhRdpEn5Dpvtkv3g1XW868ab4ifKVNUhXTCIuxwivKUba4xE2/V8ESPMgcMH0F6
 OzGlu8ji4X/IiWrkXoKbBali38K4uJjbIakGXjhH0KrlRn+euz0+VSpardTtgTAw1LmB
 oRxMfaDvQLSM0HUldvXH9HIf73eRoOHvcTrBgyHwcX1ZfIK71VUzBoHJH4Bjou3euBnq
 v2vDeU9RNoqZ6kqne4xwZhLrjM904qnwSmtjkXf23gbtQvSnDtcQM0IZVOONibSCwWE1
 5aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805779; x=1754410579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=me7DcGCMJxl2VSVGe1i1MtnORMPqtHdBH7NZfh+M8LM=;
 b=YIrRTh3KM6yGMuHin2+muE5cN3GA2iXgg0RxH58iaTSsnuuuhOk78SRVt4lZa65b5p
 f71428c/nfTqpoRGxS9NG4senwWXsMwaesWODDbwwE6WBGUzTmYdDT08xdBscySlQycB
 gBxmaHwRH/afrpEFYOdUjuet/JKdHgHVeRn2sgWd1S/4OMapGHPj17sFeoj5wUjEwN3B
 4ypf+jBb9miPPtzbwFzO1P7IwBDtICs3TNwjsmRpzJ/lr6A6trYcpH3is5gJFOE/+1sy
 Fuw/w86Ns1ha+Ge2Habvo4pWimk5lRKEi6O2bHPPGI0VWugSNtkNUdhOHhVHF5/2+Xu3
 +WEQ==
X-Gm-Message-State: AOJu0YzovADrK0cWf4VNa6PdJ+tl8qiTyoYy14FmlnPM52bboKpdNZvI
 O+3XIOejvBlaA9dwrtllZ9ui/qes9cS0ioMvYkY/ZPEFAZ/EpWnkGInlxM1yvaFJq3g=
X-Gm-Gg: ASbGnctwC8NOzU/Nq4LCdaRsZkLz8kXbJepgUFcr9OH2c6vOs08KPjk9WQ98tzIhDKx
 1u/lmnz5rdtZNKaSUz2dVvLIq/2/3iuNlznJe7Y9699d064bvoJwzWFyqfE50S98xxfKOhBKFF6
 cvDLkhoDWK8WTbjoaxeGk8PUwIY0117aN9+aIUJMN7DGLlmLoiKfzPzte6BtFgcW8jTT6lidY5B
 KR7jxkyCej9nXsl+0Nj0VCFkSeKjLHXvkhWJxobuqArft7xvS6h2JC75tmzGGUOYpMzuxmLP4Gf
 uuzTz57Xt5Q0x1lumBp2oOsx42Hz/GXy/Wpmx1+cGurfp1be9J1X4tZzAfyVmYo30Md/E5Li8/R
 Ugk+e4xqqfQDbbitxoSXD4XFAz4GHhL5oi17oTugUa+Lmwl40lPbJ559+uZlyMQ==
X-Google-Smtp-Source: AGHT+IFtV+bq/lYxG8cHBITUj6DK1/o/EKVopz5NUuhoRP7ePx3D1IUUE+lBl90/QE151HP2ChpLUg==
X-Received: by 2002:a05:600c:3512:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45892bcfbf0mr3291935e9.26.1753805778875; 
 Tue, 29 Jul 2025 09:16:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5da136sm29993275e9.23.2025.07.29.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:16:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 29 Jul 2025 17:16:17 +0100
Subject: [PATCH 2/2] mmc: gen_atmel_mci: NULL check variable before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-gen_atmel_mci-v1-2-ea0fddf587a0@linaro.org>
References: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
In-Reply-To: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
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

In mci_send_cmd the pointer 'data' is optional so guard its use with a
NULL check to prevent any attempt to dereference it when not provided.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/gen_atmel_mci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/gen_atmel_mci.c b/drivers/mmc/gen_atmel_mci.c
index 62aa6b3cb0b..838b4f4a65a 100644
--- a/drivers/mmc/gen_atmel_mci.c
+++ b/drivers/mmc/gen_atmel_mci.c
@@ -263,13 +263,15 @@ mci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd, struct mmc_data *data)
 	/* Figure out the transfer arguments */
 	cmdr = mci_encode_cmd(cmd, data, &error_flags);
 
-	mci_set_blklen(mci, data->blocksize);
+	if (data) {
+		mci_set_blklen(mci, data->blocksize);
 
-	/* For multi blocks read/write, set the block register */
-	if ((cmd->cmdidx == MMC_CMD_READ_MULTIPLE_BLOCK)
-			|| (cmd->cmdidx == MMC_CMD_WRITE_MULTIPLE_BLOCK))
-		writel(data->blocks | MMCI_BF(BLKLEN, data->blocksize),
-		       &mci->blkr);
+		/* For multi blocks read/write, set the block register */
+		if (cmd->cmdidx == MMC_CMD_READ_MULTIPLE_BLOCK ||
+		    cmd->cmdidx == MMC_CMD_WRITE_MULTIPLE_BLOCK)
+			writel(data->blocks | MMCI_BF(BLKLEN, data->blocksize),
+			       &mci->blkr);
+	}
 
 	/* Send the command */
 	writel(cmd->cmdarg, &mci->argr);

-- 
2.39.5

