Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC8C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09322874B1;
	Tue, 14 Nov 2023 14:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xH8iJeTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF54F87499; Tue, 14 Nov 2023 14:48:56 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5318744F
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so33704925e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699969734; x=1700574534; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YJfp5QS/eefmKujbF78pe1VSO00cljqoNnqX74yAIow=;
 b=xH8iJeTna2sICgwfkk9LK7pfAOdpdmlc4VrTq5QuMBqvmGibLD6Gi0noBxE5JrWFOp
 kVL4y5iD8uJXbX2v+gNRM7o4AQer1a1l58kKeQ+E+Fmogq2EUeBbwjLF88hVTQdepJDn
 DJ6z4oyMq4QkkFEt1lrIJ6lHBDuqCpKbmkMbTasYP51gClmeeFQ6cBDo/wZOD2gsivYu
 ImQNJWqd9FDc+W0nMHnA54xw+hEAUKcMa+UMLOl4zS48Yyvt1NNJq/MksvgHcilBbLq4
 13bLVOMDo7UVLXbQmF2BjBmFacZzyZd4Hict0rTwTV3uXvM3FPl3DGkw6RLIwppm+URP
 DwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969734; x=1700574534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJfp5QS/eefmKujbF78pe1VSO00cljqoNnqX74yAIow=;
 b=VBjffOitM/cFRDLLI/NcGV2vqewOfQZiVLkk4riwWccVgWndddZfhK5PX+y0h9MJag
 53bAYZJVls7jJ8HcBczxRY0Aa4Yjqs2wfPEaini9k8uRCoXXN5t+et6UKlSj9Pxv5Ywy
 LeRVrzN2ZBXpoiu3dzXWqWGIDy+Dr1qwy94mdZ4ORlZin5bHEBJmwsOfNuLuxpcAfzP5
 r0xUf1b05S6aUZnGUf+fJ/e6x1WV421hrrDQ01rYCgdXqqQraNrmtETsn1vOexDosaKI
 EhsiytvxYDMU8PYDsTQiTQbwC/OQX2fts/AXgT/tvMQfK5LayNV7nc/HxS7Dn0F0XHEj
 W9uQ==
X-Gm-Message-State: AOJu0YzS89R4dvhh8y//5XXwNZSzcR57uIvaDl2qzQseCFngjBbxxFL8
 w3zDZNS+4EmE90TUEHWEqGXgsg==
X-Google-Smtp-Source: AGHT+IFUubhSOhGxgndYzZtjS/NW9EzrpdXzrkoS8bWmL1HMff0f0DtxyBvL96tJwWdQud55jvo0iA==
X-Received: by 2002:a05:600c:231a:b0:40a:3e13:22b0 with SMTP id
 26-20020a05600c231a00b0040a3e1322b0mr7425000wmo.41.1699969734438; 
 Tue, 14 Nov 2023 05:48:54 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003313426f136sm7804220wrs.39.2023.11.14.05.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:48:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 13:48:51 +0000
Subject: [PATCH v3 5/5] pmic: qcom: dont use dev_read_addr to get USID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-dt-compat-v3-5-88a92f8f00ba@linaro.org>
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=pJOwgwuqESk9m96peXOf3uui++e6fZBT/bur0vD18ic=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgqgOLdW023unRL97xtvXZ71NVV5fWlZY03W3p3ijfM
 1f+evafjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRzZcYGTbcbvUUD3QQ85RY
 YTdjmmRg0pS13bPN7p65w6Td/eDKaTaG/7lJje9XvJqosXTbokM2K47/t7w2d6Xlk/ld0iKZjnE
 /TwUBAA==
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
2.42.1

