Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DAFC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 10:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99ED48397A;
	Wed,  6 Aug 2025 12:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uycB0Sod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17372839B5; Wed,  6 Aug 2025 12:43:52 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D704A8396C
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 12:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so3835110f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754477029; x=1755081829; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xIhPL8TYVr6FeGIgm6WW3E+Ceig2BEpD7cqkpA+Tj9M=;
 b=uycB0Sod7PCEXX9UKILAMld02+hdWqNWDd56ZCCbMw8EtNM/i3kAE4A0hPYG8AE5Wp
 PyK4K1CTlbVtH1X2XKW69Qfw9ZowXRwCogD0SCKuLCksWdSFwjXrECXCZt6+Q5DxJu3g
 ImoHMHLA1OdMY1wbVBbSq5/jzmaHvY0CSJnU7zPqCNfWI1q8ABAwuyPn8eSy/JdUsQQh
 yr92muPNDikF7AS0eH2z4yZBKetJsEhlsomGBxzM4wqNmrRiCTauPujL8B/mJEYoOxFe
 /YPlQkhpJjhBL24hdGYJUJsYEShcYe3EVVb5IBvGuU/ORDtBk/9sMOyPWyuWhZRzHD2d
 DmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754477029; x=1755081829;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIhPL8TYVr6FeGIgm6WW3E+Ceig2BEpD7cqkpA+Tj9M=;
 b=nJOXzxKiZzZd7WqQcbjcNvjfCNO5GLdOG1rjY/1H2ZSYDmtYyPpiSFWZHV59uVGklE
 I65GJbE5Suq9TTf+5calynXUvwvPyAmrU+T4vPgf8QWg4CglBBe3dtIIUER4CVAz1dbL
 rHm88JmF1aXeCfT+TS7LMAHrG+D9iT3/AzuWAV+Jil9Sv27XOHsAk91TVInG9GKR5LHN
 c/PDw9Eu0VfQXygd/Dh4Q1VuyXmj02OmQTFunb6jE3pCd01mSaa9oATSPwy0bIznu4+i
 GCoEJ3t//BcM/R3kg7/JeTt3jOUNj4S9JCmf3VbvPSab6BZgPVIJ5uMNVe9B8/gTkmnf
 uwIg==
X-Gm-Message-State: AOJu0YwFYCVKKoSg4h+NsD31FR1/nF9RmhskPp3DAlQ7HQI49NxznUln
 cCMKDXxd2VvNZyz2dyudJa93jlEPxAzz73vjzbu+3GJXepB5ABfNLcIzCOS3K4K9GGQ=
X-Gm-Gg: ASbGncuU+HxoPvj3v2AKHp4U0vlUs+flAgsx9d3LhvMHjr9/YMGlutQAPithTuTBK4x
 9AkKtTdTBzQRbA08OOou1OqS0tGNLMBdyzI0JC5vNLnvkqCU4U4z+PNEJpTG3LVyLW7M/Jim8yU
 +KY1424Zq6JIcfNhqBOzAQUJ0+FP6LUqE8sJzjdW1XK03RhQmDHFNHwelTdWVrvXcvbGWA5RXaZ
 MZSow8bhMfL2jewPYcPMh0dxoiCH4HPn6BjJ1Blago5fzxePTHx+HFRKYiv0SNp6JIVTwnZrc6K
 VsF/a+pUwZOS4EIVia49PJ500IK0cIMX8wd49YglbrpXPdbMS3x6Oi5eLPZe39q0JBFpugEVPqq
 GavCj8lSsYjEgUZyDl5mPUoF8eaK0wuf8wGH2UxIbDLGadNHcHNs=
X-Google-Smtp-Source: AGHT+IGQLYH3ytdQif6HdFAv0NGwL/RQZi8CyDvTVqpOFzKbQIxBXDniM684V5JM3N2V3scPxhhZ8w==
X-Received: by 2002:a05:6000:26c9:b0:3b7:837c:5679 with SMTP id
 ffacd0b85a97d-3b8f4923dc2mr1585707f8f.40.1754477029148; 
 Wed, 06 Aug 2025 03:43:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abec8sm23434500f8f.8.2025.08.06.03.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 03:43:48 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 11:43:47 +0100
Subject: [PATCH] net: ti: am65-cpsw-nuss: Initialise ret
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_ti_am65-v1-1-aa819f488ab6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOIxk2gC/x2NywqDMBAAf0X23EB8JEh/pRRZk7XuwVh2gxQk/
 97ocRiGOUFJmBSezQlCByvvqUL7aCCsmD5kOFaGznbOjtabRHnKPOHmnXHUx+BjH5dhhFrMqGR
 mwRTWq9lQM8klvkIL/+7N613KH0VBUfR2AAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In am65_cpsw_phy_init it is not certain that ret will be assigned to
before it reaches the 'return ret' statement. Initialise ret to ensure
that ret is valid.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 9b69f36d04d..723dde284fb 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -628,7 +628,7 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct phy_device *phydev;
 	u32 supported = PHY_GBIT_FEATURES;
-	int ret;
+	int ret = 0;
 
 	phydev = dm_eth_phy_connect(dev);
 	if (!phydev) {

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_ti_am65-5e3dc6d3df48

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

