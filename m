Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E935D41C00
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21468894E8;
	Wed, 13 Nov 2024 06:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xB/dEi3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62C8894F3; Wed, 13 Nov 2024 06:09:44 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4FC88C0F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa1f1f2d508so96569866b.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731474582; x=1732079382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V3qbSGEhVxxKLIcrYq2faMiNq6QqZgNMoK53D0Qu75I=;
 b=xB/dEi3+YwRP6qKmAkKjtI16Yzhv0IlwekzhCJSeLcKkC6N4yMD/FSBwT/pvYsI2aO
 77iQAw0AKBkTF7AnN+v4grEfC0FHjSoZKx99LkiCCyjyduJycrogz7EWMAuCuy3hSMuu
 HGn/er3VMODaitECWxDNUS7s5vpqc0S0GsZAF+LEFAfKv5XerWmJOTSZ1bMNzYcT0fie
 Ztc6Cm/XfqgPZhSZYZyxX3arxIeSw5KfEQgMKqHjjfBCcbeFVeQCI6Fc4weIRWHqYC9a
 X86WusrfETf24reNOGdtg0hl27/RhiKI8UcRYFyP8zvE/p2FRL34hFHvJFkcZ91z22/3
 BJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731474582; x=1732079382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3qbSGEhVxxKLIcrYq2faMiNq6QqZgNMoK53D0Qu75I=;
 b=cQLJq8Ves4A92CaYvJOWZG3Yatyu3zImmZkm9KqVkRVNSHKKXZuBUqScnJ9XGbjAdR
 mEcfMz1AgZar0mViOsU1sEW99ywj+GXqqB/ZCy/sx/BnXaxnElpwsn7o/uQSCRhmsiaZ
 2zkB+37W4qFnQ1rqaCux+j/vzpUjVP79B8A575KMbgiXoGqU1oM0RTwqIEeemSMhVGKk
 wr4VNbglf7HWu8R04xemR1EbNhQrNB/u8wU3Qn512V1HaDKWxDoUGMNEfiN0zGGp+sTd
 XAligYHf0vtxq8FI6dDwINW1dXfopBxzb8igAWCiBmv6VgGOW16+7Jvi5mkFi/yiK8eM
 hkAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBMYotcJqjGJ5YD0x7vR27qnEA1APfptFI5F7gNM26j+zp6063uk6vkIHC3FHJHm2YZ6nnYfs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/h3G0SeELqWN9Vb09lHX0P8CvKuqOQ0S700f95XFQmsYnez9c
 MKPT3ajK4JkGq/WibCLDapLjV626E3pzWFFWLv22u+lAyUNbiWxqsfvEfeCxr3c=
X-Google-Smtp-Source: AGHT+IGi8Wb6ZqE2op3ktwKXpHSotQnoCVtiiiUd1cGBU31F5oQv8v6fbH/IHYdZthFTGRIJzevwXg==
X-Received: by 2002:a17:906:d554:b0:a9e:8612:eeca with SMTP id
 a640c23a62f3a-a9ef001710dmr1900189666b.48.1731474582302; 
 Tue, 12 Nov 2024 21:09:42 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc4cbdsm827746166b.108.2024.11.12.21.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:09:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] iommu: qcom-smmu: handle running in el2
Date: Wed, 13 Nov 2024 06:09:24 +0100
Message-ID: <20241113050931.1853447-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

We only need to configure the SMMU when running in EL1. In EL2 the
hypervisor isn't running so peripherals can just do DMA as they wish.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 1b5a09bb7b39..7b7b3ba01a07 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -90,8 +90,10 @@ enum arm_smmu_s2cr_type {
 struct qcom_smmu_priv {
 	phys_addr_t base;
 	struct list_head devices;
 	struct udevice *dev;
+	/* SMMU is not needed when running in EL2 */
+	bool disable;
 
 	/* Read-once config */
 	int num_cb;
 	int num_smr;
@@ -276,8 +278,11 @@ static int qcom_smmu_connect(struct udevice *dev)
 	priv = dev_get_priv(dev->iommu);
 	if (WARN_ON(!priv))
 		return -EINVAL;
 
+	if (priv->disable)
+		return 0;
+
 	mdev = alloc_dev(dev);
 	if (IS_ERR(mdev) && PTR_ERR(mdev) != -EEXIST) {
 		printf("%s: %s Couldn't create mmu context\n", __func__,
 		       dev->name);
@@ -347,8 +352,10 @@ static int qcom_smmu_probe(struct udevice *dev)
 	priv->dev = dev;
 	priv->base = dev_read_addr(dev);
 	INIT_LIST_HEAD(&priv->devices);
 
+	priv->disable = current_el() > 1;
+
 	/* Read SMMU config */
 	val = gr0_readl(priv, ARM_SMMU_GR0_ID0);
 	priv->num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG, val);
 
-- 
2.47.0

