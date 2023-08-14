Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75A7C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 162C5869A6;
	Mon, 14 Aug 2023 23:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wTbHixxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A369869A5; Mon, 14 Aug 2023 23:55:44 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AC3869B4
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso28266205ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050139; x=1692654939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00WHPCM3Lkgw/Cfu1ET9WrLHzjZyA1rQi5iyaTqafhA=;
 b=wTbHixxjZyDmxNaDXus5wQDhh9Qsf1qb3ZK//i+sTD+C1LpGtcY9vSMkY9EKl8UTnF
 BGTMjG2nW33hQQ5eSk2EViaiAy6p/6BSpqA5sRSlbymvvuFCezrXUZ2SdQtKzbxDClis
 QIU8CaK8ZhzjAtSXyiEmC6xI+urCRnA+m5JBec5L1PPEoQJz9Qd5pgZgnTHsbPnmVTfb
 c0bjV28xF81Gm5YKbO816OgIhJLsC7eF5v6Q5+8TglInTfhWP+W62lhtMPIQg8B1383s
 1gVJngTBzAPtWt93tTOaKhV0g/ux7I5wog78JlDC3g/Hh3mm1jp+5gAyk5WqUYzmC7Yk
 UGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050139; x=1692654939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00WHPCM3Lkgw/Cfu1ET9WrLHzjZyA1rQi5iyaTqafhA=;
 b=OY+SGZ/Gvax6SZe8geqgr1X7ZpeXhtOJ5IB1Zzo1b2+lvoYIclbmbIbdAAGDr729hv
 bMrjPb5F9jAny6Om0ZVp1tsxQAEXvsJAePQWk+RHax3cbeIELn1WO4/yFKo3H7t6itx+
 Zk+mxMrJMTvdZ7ZEYejmozAJjYjQkoBucPpAGzTe8jmTqfyw6TlgU4adlgbsTj6FB8NQ
 uIhjHfdNg+A6mvtXrErF64sSaVEnzzpQPdc7/UAOs45xswOdYWNlOYR8hARy5QjK2PTQ
 yebsYmlrw1GwjXVoja3nuYeSapWFBMjmSEux7av17IuHkHZibp10Y9bqgE8ZD3NM3GLu
 4zHA==
X-Gm-Message-State: AOJu0YwfPkM+HvSTTp3XupZ38m1v9m+EwwyVT63r3pno7N4ata4ojhmu
 rr2IJlLsr/le59DAFHHZjOcJR4+tTFbOuUMqSqA=
X-Google-Smtp-Source: AGHT+IHLsJGxZ+K8XQRh10SU9jsJaZhFCgxfQExto2KktTxOg+W7fq0f88MeN0EeiohVSgQChAV8yg==
X-Received: by 2002:a17:902:ea03:b0:1bc:4f77:e34f with SMTP id
 s3-20020a170902ea0300b001bc4f77e34fmr11743434plg.27.1692050139483; 
 Mon, 14 Aug 2023 14:55:39 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:39 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 07/17] ufs: Add support for probing UFS controllers newer than
 UFSHCI_VERSION_21
Date: Tue, 15 Aug 2023 03:24:47 +0530
Message-Id: <20230814215457.4075025-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

UFS Host Controllers on Qualcomm Snapdragon SoCs support versions
newer/ greater than UFSHCI_VERSION_21. So, modify the driver
to just print the UFS HC version and not bail-out for newer versions.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 25639a6d24..b2c3af429e 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1894,12 +1894,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	/* Get UFS version supported by the controller */
 	hba->version = ufshcd_get_ufs_version(hba);
-	if (hba->version != UFSHCI_VERSION_10 &&
-	    hba->version != UFSHCI_VERSION_11 &&
-	    hba->version != UFSHCI_VERSION_20 &&
-	    hba->version != UFSHCI_VERSION_21)
-		dev_err(hba->dev, "invalid UFS version 0x%x\n",
-			hba->version);
+	dev_info(hba->dev, "UFS version : 0x%x\n", hba->version);
 
 	/* Get Interrupt bit mask per version */
 	hba->intr_mask = ufshcd_get_intr_mask(hba);
-- 
2.38.1

