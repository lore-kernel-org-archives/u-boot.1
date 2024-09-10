Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB2ECE58B
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC06288FEE;
	Tue, 10 Sep 2024 11:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N47orUMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C86C88FE1; Tue, 10 Sep 2024 11:50:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DC988F86
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c3400367so4586637f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961816; x=1726566616; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFbCpCXNQ2oFvJ0OwTmzHLLg6eVTDVdlQGkQ/GCAF6Q=;
 b=N47orUMMRRBpnL3EDXdcURDiqb0Ct8glQ+FOxYKiQxIA7LjmC3OHwrWrEB4dWJxBZL
 Yh6h53Cfsi2IQi/uFbLEEJBpEBW1/WsVWtdvRrDg3g0QXA9FjCtvVQzE/3TUBDVTRHnI
 nWLT0Pcr7yOd1ogTpdUYRT9pBQGS3PcS6c/bdKCuvKsN70Xy7ZxbLRC0+NXw+7S5z4rG
 RL3LHRRIfpx5qBOlyHsSbCTGnrQboYrLLivOVDxkmue+Epanbt+rFEYdXVwxWCNWGWBb
 XAF2R6THhcaWbNZeB9LcdZwjmPBUQOp1LZbLlzb6Pbb3ORvpPZAtBfo6KeWV4ZGYE+To
 GIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961816; x=1726566616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFbCpCXNQ2oFvJ0OwTmzHLLg6eVTDVdlQGkQ/GCAF6Q=;
 b=rx7R6i7eEswZAg7uQrb6/lAppIvjBL+LMt9ukL2TMjBwX6MS6JiuojOsYvUMAWIbhr
 wWrSbyTAbE45ssDa5lTpJ2Nw/SinKWEp6EZhHKZzeNCj82SoGV/CZCe9KlgeEu9d4Sgo
 HSGdPnobMJ0h6dU9A0evPhP9F8TJGevqyLNbhG2OErGWbI8Alk3d89loJJQCBcS31BnC
 oAf0eaPuU2Ke10CCo014oXq0/laQni98KO5Blrsw5F/m7Ltk1YvtGTajz9Gia1VuvUW8
 LNSl6nPGD0o4UpVfr7VZM8oQOclTBlsOUc+cBsCCQ3e2vfrEmWOcgmUpU4am6xCDDOmB
 s3Zw==
X-Gm-Message-State: AOJu0YxRksPxv4khdNuI7AMNbpxmtncRfvA7Vag7ZhfAEenrRm9IgwAX
 qj7iMNf27MQmpb6b8lfbHk+CfPU7e1vahp+2A7h7Pu7y7D6Vu2w6dtWmHfYu9Jk=
X-Google-Smtp-Source: AGHT+IEomd95af/7ryWF+vcrd/5sTl26CD84ZIs1w3Z6c4VOabihilm3asEyBmofFYCUv8SL1GVwRg==
X-Received: by 2002:a5d:4d4c:0:b0:374:c6af:1658 with SMTP id
 ffacd0b85a97d-3789229bbd1mr9028995f8f.1.1725961816357; 
 Tue, 10 Sep 2024 02:50:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3738sm8364030f8f.69.2024.09.10.02.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:50:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:50:12 +0200
Subject: [PATCH 3/4] ufs: allow UFSHCI version 4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-controller-v1-3-54c0d2231b10@linaro.org>
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+O4kyc+2xs0bUM6eE+d/GOviOCk72KzMUJmprwwXrNs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4BZU+MCSPqFTpeQwgn7jlZO7Q/+R/B4aSgKhwWS2
 wMeZuICJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAWVAAKCRB33NvayMhJ0SwvEA
 C/PlfNX+7PZirD5ot6gxvyzMjXNR1Or+fw2Qg2cIjaah47+2nVb8TbNV5TRascLK8bG4Oi4HN8MxT/
 JGG6L6c3t74UsBIFLti1JOjZx8jJFmrC7Wc/E34NkRyUm/Y64gP+2HwxiEqBnI8bAzx7n3q9wNSyaO
 dW9KVyZnF+6sxwimzZE9o5ksQtSiWubPAGAIZ8xNbaG3gYvVRz40uQ543SOm7/QUYOp4irLhsHtTPh
 V3ubxXuzCtdHKaup+GhAD77byEZmnmBKK3ZZF5KJBJv9MACogamTKvn/EgZYvh/yNae69QZ5m0UkBu
 Rq9TewJgGKb5bTV+ZgONY5GrSXhUi/nixfKHLt9Gj3Hw61sNG36515xSnss299p0XciMzpXxRponNz
 eXXL6s+ZlO1B6zXAC9xNgOUzxoFszl7o6OYIgjDRnNQ0gfjWq9bLuy18nJObkHX4m1/yohLPiLr/kj
 VzwRLoX16cgs73GeyKIjS9+dRs6i6RT4GYGEee7QYQYfV/Wysjgj16WAv7J8IoonCV9/ah/M3ZDPw0
 YVsKp8j27RtQi4tmcCeS9QcoNq6tLFKoT3XvGsxFynI9R4nE9CgTQzu9o0/phrO7EhAmFZ46ZYwBpL
 3aznp2pRiHSkJBA4RjOMQwRv3MjowIQ9dJwFi1qD2SIqBleVpq4+3kSxirfw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add UFSHCI version 4.0 found on the recent Qualcomm UFS Controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 3 ++-
 drivers/ufs/ufs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 1edd31677b2..f7d8c40c448 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1974,7 +1974,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	    hba->version != UFSHCI_VERSION_20 &&
 	    hba->version != UFSHCI_VERSION_21 &&
 	    hba->version != UFSHCI_VERSION_30 &&
-	    hba->version != UFSHCI_VERSION_31)
+	    hba->version != UFSHCI_VERSION_31 &&
+	    hba->version != UFSHCI_VERSION_40)
 		dev_err(hba->dev, "invalid UFS version 0x%x\n",
 			hba->version);
 
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index fb47d0cd3a4..2ab593455e9 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -906,6 +906,7 @@ enum {
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
 	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
 	UFSHCI_VERSION_31 = 0x00000310, /* 3.1 */
+	UFSHCI_VERSION_40 = 0x00000400, /* 4.0 */
 };
 
 /* Interrupt disable masks */

-- 
2.34.1

