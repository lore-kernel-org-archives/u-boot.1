Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00378C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76104883A0;
	Mon, 27 May 2024 19:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LLEdjDdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93E087DAB; Mon, 27 May 2024 19:17:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B70387DAB
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so1332666b.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830275; x=1717435075; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TajqXz5uKy7T9xe3F+Q4vB1gyPUhstwuDhj/02ms4uk=;
 b=LLEdjDdRt9X/+g5ptZYr3b3asdLj1T4qGPc19TcEzAQhXqb6uTJ1VFOQPCZpT18y+O
 9A1c/W7yGwX4wlg2IhibayGZi9YanFXA7fpDe3Ag6urKF3TdsTKKL67AERZnO5bVkH71
 gRWuTTfCDDALjQbWmk9OkRCTmqm/DGaT8UE+UZXMMrbFqUDCji5N0Ve40PM221XRZBuV
 J05E5OGJk/RCLkQcN4k06D0AbyyzN/m0EbGVpL3//nP4KjF09HcmX/jnHJ7G8PM87Kpc
 Ugl7qEIf2tQJ0Jjb7M8+2mTxYh/7O/2MMsTbJ+TCpOAGI+6kdoExNivoWUUV1Pm7+prx
 LQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830275; x=1717435075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TajqXz5uKy7T9xe3F+Q4vB1gyPUhstwuDhj/02ms4uk=;
 b=xSukbXfEd+kmgy8ACBqjiOfnkTwa76CDzo/XnK+e8MF51htteCtTUhjj89JZBFRn2/
 eXOWetZUinqEXwRuYIGW0uZvmQOH2n0tPN6OLoVUvKnyWlF4x5jw6jywlYOh/AS7G9RG
 gY0m4+GCXJt5iIAzwZb4jytd1lSvY0fiK1JscnkeJIxFbjIkzTt4XrblMKqMB8lGIZN/
 QESOnsnLSKkkqzKZ+09RX8dctdeuba9B4Erxbv+UVbzga8+m1gWF9gKVUVpsMq8PDmlG
 TnGoobY93UcuU2hTeerW+XD0mnKMPFNHGRhSVmp6Qq58p/w9/ETS2CTsH4etpi3iiOAq
 F6fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcKHT85rJr7qz1EDt+BRfgfmm1PrtHC14LLURwNo3P8w8aUfpi5K1JrDOSl9NV1/7fy4178fWLxKbWBYLSpZFZDYgAnw==
X-Gm-Message-State: AOJu0Yyq2Gd32nKlKzlZ1FqhhXy4TIF5GZrIXKriK73DA35rYZEE5Y/1
 ZynRCLruyu415cO/R8TCAC84SnQHbrGSHeM9fgRwWdKWtA+c0pkPWuXLv4oxZAc=
X-Google-Smtp-Source: AGHT+IGcEVCpsJPl9geQyKLzZxljsokD6KvAMqRDaYZbN7E5NX14sos5Af0glhbHQcWM8KqG9Pbn1A==
X-Received: by 2002:a17:906:714e:b0:a5a:6f71:7bd9 with SMTP id
 a640c23a62f3a-a623e8db7c7mr1149960066b.14.1716830274804; 
 Mon, 27 May 2024 10:17:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:51 +0200
Subject: [PATCH v2 3/8] mmc: msm_sdhci: work around a bug when writing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-3-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bXkm5zNNG/TPVcsDJJEaNdVNsrhwM9K8G4lc11zkT1Y=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA957au07gEifRJUA/QhE3wSSjcySafBXeke
 hiGrZ2uRMaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPQAKCRAFgzErGV9k
 tmxcD/9YxnFKUOc349eb4knSU0a/XJB6KolIi+1KDpWa47eB4bxPs4cBNJSRKIqt/jIDacb71ZG
 2SeDMhyxpefEW0XNMBdyDltue/jmG/0LV5eCa2rjr6VejsGfdtpxIo0jcPNfHEfTaWtvvZglLlM
 tcShUkSRxcD01F4esDyS+ITNVRSmIBTyC6kaXM5/NijuzcXY0R0JMRToe5tH/aXM0UjVKFBtSfq
 /z8OfFwRUIX250E99aKq97DiSiEk/dTpKLcc7KFLpaiAwlzAizPLgfebVOZ2f5TU5171NrGFooS
 Q8eKxqwd+o5rn/P1JUzIhovVnhv2e5KbL63E2eEdKlEuMMZ5e8wSKuJ7dc/TmXe59gj7RDTn8nq
 sjgU/CswB565SOMJXERMmnM9wwgiwsBEUew6j8orFultyBQ81QpJXZNXHgRX7jZL6Kk/O6uwg01
 f6lrgG8dNHq34ZvlJQzBbanXa2J3warzkCp0bTf3s1iwttzKIYhHiX18UCkOGz2fsUIhQ7Bay6r
 TNMMfq9BmQ0NH3znXwk62ARmfyAD+uxr5cAK2/PDZ1NRVPkMVWs92a0BGtgj4ldvHfRK09E2o8w
 XefbKqbc7cGA6y/IfR+Y10ptTbZvZ86v4u3i9gd7c8qujLuyDqCCJ0l8/nqvepoEVw/2HLe1TW8
 2hoKEOhcuzE5r1g==
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

For some unknown reason, writes of larger than 1 block always fail with
a checksum error on Qualcomm v5 controllers.

Until this is resolved, work around the issue by setting b_max to 1 for
these controllers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 4ce0de6c47d8..fc3e8d101b6e 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -195,8 +195,15 @@ static int msm_sdc_probe(struct udevice *dev)
 		return ret;
 	host->mmc->priv = &prv->host;
 	upriv->mmc = host->mmc;
 
+	/*
+	 * FIXME: v5 controllers have a bug in U-Boot that causes all writes
+	 * greater than 1 block to fail. Work around this by setting b_max to 1.
+	 */
+	if (var_info->mci_removed)
+		plat->cfg.b_max = 1;
+
 	return sdhci_probe(dev);
 }
 
 static int msm_sdc_remove(struct udevice *dev)

-- 
2.45.0

