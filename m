Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E402C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D0F87136;
	Mon,  6 Nov 2023 21:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRWoOAoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBE3870ED; Mon,  6 Nov 2023 21:57:59 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36FE86F5D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507adc3381cso6338228e87.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304277; x=1699909077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=018DhIg4oU2avzPOOIk9IL8QILD9VZBX7XSKEIBDpeg=;
 b=ZRWoOAoOROC8df2HGJVVOFRYWo4p4/tN9tMQqa2w6XkSFKj7b0/4FxMgu2oMhI6zKP
 B69ztqoU7BvOwrEuE46oW3gJSgiJyj/cu9HTGn1eIxba09oFP9Slr2wO7ug5BLHSlZtx
 95cCah/rORcMp77ggPKqu4sEAkfzH7t8Pmf32l2mUY5D76m949qn0m+1MPS8OGnauoQX
 oCwKYKXp7fl4nBkhpBjeXvfp3We1r7Lhg/QU1Sv3RmpgXDR6Qq4JHY8UjwyKRD3q4Ce9
 jSxZkH/YurgSd1Xm4TTb/6b1Wsgwobei8RXM6ER1nWjZMalzgagCIGaR31W/zvLPAc/w
 ehVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304277; x=1699909077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=018DhIg4oU2avzPOOIk9IL8QILD9VZBX7XSKEIBDpeg=;
 b=gLx8+Jkfd9s6sbRO6WL2hXHZam00S+WttxHMcHl4gaU+LGkNmh/V52cgqeAExuvStu
 nXTMIwB4n86CADJcWZ9OXmvMmli5FjQyq4eEXxgsigMQnFJVmaB6KTQwKQQwf5+hAxwM
 PpGCdOsm2vKf2har4Mp2qL5ZioyIbjI5U1embX09mGtaHUr+g2/sSV3gt2ry0M0mS0gI
 qzxnpdYfSEvqWXPatdSAVqwKjPaG/GIW8za7s12eV1OuNPixw/6PpOXmo3E9mYpmpytl
 Sm+Fvj8KZqcHkE8+JHvefaqGMLFv3SR8lb//qPBJ/AlBRdVAZYdFYdzzNMqmNHM2OE4R
 hrOA==
X-Gm-Message-State: AOJu0YwqsLBVphpgdegByk6G9D+JieCHkRdpr3zKKsTYS+dQXeLIRZPR
 EBAjB4g6LjzlYoPqKMQWdo186w==
X-Google-Smtp-Source: AGHT+IE3/q8EW6zaJOah/qCL0+1ASwPnviYqS9XWeHvJgGyxEIaZA+C/ENZwTcEHVAEZq5JfwYZqcg==
X-Received: by 2002:ac2:504d:0:b0:509:4a02:49f7 with SMTP id
 a13-20020ac2504d000000b005094a0249f7mr10295381lfm.44.1699304277349; 
 Mon, 06 Nov 2023 12:57:57 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:56 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 20:57:33 +0000
Subject: [PATCH 5/5] pmic: qcom: dont use dev_read_addr to get USID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-dt-compat-v1-5-0ccbb7841241@linaro.org>
References: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
In-Reply-To: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5K5TojjS22iKoGc3mT5WWQT3H8v2KeEZTGL2lkHxY9A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYP863ofa5rPevJcNqdxfktGwn2Uh94E7Sbax5xUev
 JldGXKxo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk80WG/yXRmx+Fe6mlSLT9
 1m+XPNn6INpp66wT3W3vOr/I+FwV+8Hw3yfut4L17UIu0etTl6ssXBi67OqhW2vFD+/U5vMS3Vw
 ikgQA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Linux DTs stuff a value indicating if the USID is a USID or a GSID in the
reg property, the Linux SPMI driver then reads the two address cells
separately. U-boot's dev_read_addr() doesn't know how to handle this, so
use ofnode_read_u32_index() to get just the USID.

The Qcom pmic driver doesn't have support for GSID handling, so just
ignore the second value for now.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/pmic/pmic_qcom.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
index ad8daf43f06f..f2ac6494811d 100644
--- a/drivers/power/pmic/pmic_qcom.c
+++ b/drivers/power/pmic/pmic_qcom.c
@@ -66,12 +66,19 @@ static const struct udevice_id pmic_qcom_ids[] = {
 static int pmic_qcom_probe(struct udevice *dev)
 {
 	struct pmic_qcom_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	priv->usid = dev_read_addr(dev);
-
-	if (priv->usid == FDT_ADDR_T_NONE)
+	/*
+	 * dev_read_addr() can't be used here because the reg property actually
+	 * contains two discrete values, not a single 64-bit address.
+	 * The address is the first value.
+	 */
+	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
+	if (ret < 0)
 		return -EINVAL;
 
+	debug("usid: %d\n", priv->usid);
+
 	return 0;
 }
 

-- 
2.42.0

