Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541CECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCE588F9C;
	Tue, 10 Sep 2024 11:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UiIqqj83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5988088FDB; Tue, 10 Sep 2024 11:50:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDF888F9C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso12184215e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961815; x=1726566615; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mrl4DVgfVspjBhaS8wZ41H4N1ax33wp/NdwErCC4h9Q=;
 b=UiIqqj83ZNhvGYzQoy1W06aCNrm5jcWJodnqj9kFCQVIP4A9Vn5pZ179wmUN2qxZgk
 IihYVa5J8A7ieWbWtAT9o/CwXDImsYxg4FSV/fW0NN5itWdYS0S0EMKPvYGDZktmJCf9
 kWFbnQIgp2h9HIBPYnbztMAeXkSqvdyxT9DyIeK2iL5QAMYw/Gmozvoxxb77UAF0ocbN
 qY3/YLaahptSbekcxc2EUTrDHEklBTFIFB2Ly+QmBFxa1Fhmd2Xk3cEEOBlIb0VovoHf
 CtxesbrIljy2uPRL19/YpQy8oF92Woq3ZStFA/U5X8G8qaz/hHQLzWClgWgjsbgqriuQ
 97yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961815; x=1726566615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mrl4DVgfVspjBhaS8wZ41H4N1ax33wp/NdwErCC4h9Q=;
 b=dRb3BpvwSvFLjs+IGdTZ7lfXyyUkNM4AWl1YLm1kR2wtb7vq8gXdUSEu8d2Kr9apVq
 1+NL9D7tYo4qtf96yuj/KbPd5WkTf2wcGycp21Vqskv1n06MBV41DvkhMRK/gXtFH0Pw
 3BZ8Jt2/kUf2boLMtxd/rs1H7uwtD20Z/bpDsx/fuG4Y+C5Fh3i8/2NiFlHGASF8OkXS
 Gq4JxuSN0sKcYTa0aipzJgWlgJL1iaZoICHUDMEaq0l+bN0+n15CCvbgsnwblOoaIxw8
 F7fyKu+/hrPUhkKa38rVHiB+GQaBR90ilhmI6LM73ozjxsOXk3NfehfBB4HMh2CxusTS
 dpSA==
X-Gm-Message-State: AOJu0YxVVcA5QsWtbMt9Y218tNHyrD+HY3CK9sMnjw8uuZBxuL0gnbaj
 Bk38leLhxPGF67pAfHJMBYefie3W9hYIIph/epQfhiuiriz/CdkWRzyfKv6fWqA=
X-Google-Smtp-Source: AGHT+IHUuOoiTUWF6T/tTw2ckBaNwLVV9pR77NvZ4G+OpkNYBN2JshkFHTWZKcu1Z6DW4Jyi8PtTfA==
X-Received: by 2002:a5d:4ec9:0:b0:374:c4c2:5ad5 with SMTP id
 ffacd0b85a97d-378a8a792fcmr1428968f8f.27.1725961814724; 
 Tue, 10 Sep 2024 02:50:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3738sm8364030f8f.69.2024.09.10.02.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:50:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:50:10 +0200
Subject: [PATCH 1/4] ufs: add device_reset callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-controller-v1-1-54c0d2231b10@linaro.org>
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zKPp3bheL4MlkG+SNNaa74uWjsT0ac9V/26Go9Z7VT8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4BZTvCKL7SyQPdNbv8mXFv65iHxVYOmKtZTQ8uy5
 SQF21i+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAWUwAKCRB33NvayMhJ0RlmEA
 DO+LSKM2l266PtSRTrytuti6BlZBUD4wJs3b1YCBf5lMZwe34tbqaPQpzHBsy5ec//7Pv87JfWmZ7+
 XssxGD4IjAWgyVtP6zLFZRDm/Ycv8iYW5t4q+Ro/qfFCoYc2orElhkWVtCqNWi/1Y58acVsQz5p5Il
 WRuM1E50JJhlTLbMSHpxC8JKjzRltbAQlhncqcLYJVd9OF5eRw2i3mmpO3/+kz0yRUHbJEy0S6g6e1
 6xhPWKE+c6nDe9JYpgy1ppshE/AvqnWpsUdOTQCDS1MvrM73yeWrZpHTsSYJogvqs5d2QabaEJS/Yb
 KSfv5sGHO5JrsQSwz6Y+AtfrzC0pWttohiX4T/tmAYb5jTyK2CTcWq8qeaHeIWWXiXguEYd7QZ1TIO
 f+cEHFeZWmIKoqhjhwQyC/JVevU3BbFAytzfI004JzlOPUDI8g59guTWpvcKnLuImY7tX+KAPKtLYL
 a4YwAtW6i34vICWRFYvYstlBby8waCCEUSRL9udqDeNgvB8fdTYMJnkyAkfQ1l9rXSjGRUEuHVGPxZ
 lNPSCG4RrZ0NHJ40tF+Qs8/7Hw3p6xtgWpIXxzPPsq+cvWgBqsSTxwxW8c5LbBpwBa4fWTFWUIAL7w
 0XLAwHAq6l4r3ZKkEfkBRpLIO3M96ZNTmGt5+MSE9709L9wuZ0XmgeyA6USQ==
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

Add device_reset op to permit resetting the UFS device if
the UFS controller drivers supports the operation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 ++++++++
 drivers/ufs/ufs.h | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index e34e4586224..de8ba011d57 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -125,6 +125,11 @@ static void ufshcd_print_pwr_info(struct ufs_hba *hba)
 		hba->pwr_info.hs_rate);
 }
 
+static void ufshcd_device_reset(struct ufs_hba *hba)
+{
+	ufshcd_vops_device_reset(hba);
+}
+
 /**
  * ufshcd_ready_for_uic_cmd - Check if controller is ready
  *                            to accept UIC commands
@@ -1997,6 +2002,9 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	mb();
 
+	/* Reset the attached device */
+	ufshcd_device_reset(hba);
+
 	err = ufshcd_hba_enable(hba);
 	if (err) {
 		dev_err(hba->dev, "Host controller enable failed\n");
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index e8a14411560..faaebf1f9f7 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -701,6 +701,7 @@ struct ufs_hba_ops {
 	int (*link_startup_notify)(struct ufs_hba *hba,
 				   enum ufs_notify_change_status);
 	int (*phy_initialization)(struct ufs_hba *hba);
+	int (*device_reset)(struct ufs_hba *hba);
 };
 
 struct ufs_hba {
@@ -878,6 +879,14 @@ static inline int ufshcd_ops_link_startup_notify(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
+{
+	if (hba->ops && hba->ops->device_reset)
+		return hba->ops->device_reset(hba);
+
+	return 0;
+}
+
 /* Controller UFSHCI version */
 enum {
 	UFSHCI_VERSION_10 = 0x00010000, /* 1.0 */

-- 
2.34.1

