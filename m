Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11844C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F45C87677;
	Wed,  8 Nov 2023 17:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PeplDznr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BE887702; Wed,  8 Nov 2023 17:21:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621B78755B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a62d4788so9670691e87.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699460466; x=1700065266; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=018DhIg4oU2avzPOOIk9IL8QILD9VZBX7XSKEIBDpeg=;
 b=PeplDznr4B8dqmYjOppuCIlSwv3SZLYaTWq6xAyAJgERRTvWyIcbXmBCPBgVeQIjDU
 56YTXt4UPDUek5qXif31IwaUnZjPTrHfclaaU6mAa1bD6h72R0V3oCFeub7QSKPGGGHY
 S+yN6UzoPYZIZWHD5jsAWpbtB7PfKM0N9PXAfKJGw8oi+bfGjlrtoPUXc9mzRzkdjhSi
 G9IlMsvxuDD85fkr6gcDgg3OvRlEETBQoZtr2w7IG+W/rQuQQ1rxg31xv81g3MS//PTS
 Q+bLM+UUlrWgCU+t8QdP3cnYZLQtG07WXb6aMV3bx5r3tHTvRez+SnkkFYv93V81YLUZ
 t7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460466; x=1700065266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=018DhIg4oU2avzPOOIk9IL8QILD9VZBX7XSKEIBDpeg=;
 b=a4ZXQDbUBajL7QCWYsWEmiltMov3qAGpVvQyB81XAdBInmTvsw1UZbZv+uQcVUYFjY
 m/ALxmdhSPS1gTzVnrjPYECFg26R2W/O2yWmHUYGVQ13KB2aqeq/IQAQsejjE397ceGK
 4qV8vy9ZvakAZ7hhbIeflYCP41gVp8ZubhvFQgapejBtfgY+m9mZ/WtCmvw2UWv6zAr5
 4C5qdzmeT4JaOR2MQN5OBj1dcfmQNnrZCTiRiwqI/39jvbN3NSPrzU446Tlbhl1PxhVy
 0Vvo9e3KAUWIOYjvzqqzg4MtslN0TskFNE/9StETKW5RVWcC7zTeoDnT7sckqdfklz0W
 ZXiw==
X-Gm-Message-State: AOJu0YxdYAGQvUBhdybpSy8IolhPz4BcExsXuiDHgLjjsiMogfP/EWi4
 qYkfplCbv+v0LHcEKTQtPFNVuQ==
X-Google-Smtp-Source: AGHT+IGheHfbORjRjm8Wu6CC9h35YXQw0VuAjvlaO+PL0s5LrHR75oq9OhJxAz22gyz0/Is+nhjKRQ==
X-Received: by 2002:ac2:4a81:0:b0:507:a33f:135d with SMTP id
 l1-20020ac24a81000000b00507a33f135dmr1786038lfp.4.1699460466635; 
 Wed, 08 Nov 2023 08:21:06 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6607000000b0032db1d741a6sm5273660wru.99.2023.11.08.08.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:21:06 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 08 Nov 2023 16:20:57 +0000
Subject: [PATCH v2 5/5] pmic: qcom: dont use dev_read_addr to get USID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-b4-qcom-dt-compat-v2-5-713233c72948@linaro.org>
References: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
In-Reply-To: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5K5TojjS22iKoGc3mT5WWQT3H8v2KeEZTGL2lkHxY9A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTvrTktc8Q/+927cYjNynlZ9cRJRdJCVybyb9r5onLuy
 sVbzV4kdZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJdG5hZJj3fEfPgnm6JyNa
 i75Ii86SVvxiqn6patIrtQbnO1k2M7kY/icbHd6S98L5fpUYf9+eOea2d9dknN5Tc2bC0rBGjQK
 tJA4A
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

