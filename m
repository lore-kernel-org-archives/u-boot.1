Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE6C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D073877A9;
	Mon, 11 Dec 2023 19:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xMjqW5FS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2606787786; Mon, 11 Dec 2023 19:41:55 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0784A8778C
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso50244655e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320112; x=1702924912; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=esdg88iugBcHdkv6Rxg93Yj6K3dKwfUKOJAXrCPjscQ=;
 b=xMjqW5FStQxlt9W3KVUy9dB0oKXLFVMO0RAse/VQ8W40x7DHGULXy5zuzPRQKtR/i3
 fdx8C3WbETqCQxsARUA6SMCPu9zjqogNekyKJtHzx44vpCH1O2ATY+36uoQS9nd6B7qo
 hwJ5gUATRUKpmnTw72oeN1givCoMiK5MB+npSao+xDXoOoNSXyL4I+l1sLlIW5+8ajef
 gQZVx/GJc2mdMaoMLXJw1BMku4VtNOwCWxCQ/iv6oKKtVM53X9fFk3b4lydJXC4giBN0
 v22bQph5JF5CLj9A3wrw5nGP1BNtwiwy9YUo9tR6UmTMqyZr/JxuJrEWtNL4mKy4dLQz
 V42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320112; x=1702924912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esdg88iugBcHdkv6Rxg93Yj6K3dKwfUKOJAXrCPjscQ=;
 b=KEYzKOKvi1jkDuCSfhjzW91BHwpXQTOhH7ADbEWWg9x1riDTJ98ZRw/U+QRt+G974W
 5W2mciVJsZWdmI2cQkQCySZb7aekpfSFf/Otna2562DdqtVyLHSOBsw6Xb9MhLG/uR/n
 plvUGm6o1KQGsVhCQudFdOeWLexxLpyGMoaetUhIA9RQehHBDYi4vgC3nV15g7uGpVAw
 ylbLA5hd6rui/YfbJo7E8xnnmiAmVKppgQ2NG5bAfDCko+ULDrl+fMzTwAbVn5TzmNhI
 D8a5fxaIs2c7xT0lkCf2L2msz63BKR9n0TIPBVbZft4/ojXt09qSZifWj4Q0WvpjD7jr
 lTVw==
X-Gm-Message-State: AOJu0YwoxltSQDg65hl+tO+/aM6b0CS8ZgS4mVs/UkW0Vja4nFYqHcfO
 g2NosnQhNSKDs+/OHMEaB4hZQg==
X-Google-Smtp-Source: AGHT+IFK6ylweOI+5pkd/bbGeSFJfm1/8zOp0RBeDsYYx5b4D3IPOml902Jh/n2ZN1beKrm3ljC3cw==
X-Received: by 2002:a05:600c:2d84:b0:40c:2c6d:c833 with SMTP id
 i4-20020a05600c2d8400b0040c2c6dc833mr2325879wmg.137.1702320112542; 
 Mon, 11 Dec 2023 10:41:52 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a05600c4e0100b00405959469afsm13910422wmq.3.2023.12.11.10.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:41:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 11 Dec 2023 18:41:41 +0000
Subject: [PATCH 2/3] iommu: add a connect op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-b4-dwc3-qcom-v1-2-46275113b4f2@linaro.org>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
In-Reply-To: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=p8PtdPV//82CwCtpBc4aMkN0WaHiVDJ3tFOBOlykfCQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTy8LeGK7hO7JmQe0F5aV6atbeiyoR5faUZCpyno3sqV
 ucusZLvKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNhv8LwT+1XkcbKEB2faXLz
 Z0w9svFqjH1Vs9G3Bx4qiw/v3/Q6dQbDH840x7bqssRalcqOmmS584dKpsyy+ir9KrZ5/cSohzI
 THgEA
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

Add an optional iommu callback to be invoked before a device probes.
This can be used to configure the IOMMU in preparation for the device
(e.g. by allocating a context bank)

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/iommu-uclass.c | 11 +++++++++++
 include/iommu.h              |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index 98731d5e2c44..6babc0e3a672 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -77,6 +77,7 @@ int dev_iommu_enable(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
 	struct udevice *dev_iommu;
+	const struct iommu_ops *ops;
 	int i, count, ret = 0;
 
 	count = dev_count_phandle_with_args(dev, "iommus",
@@ -98,6 +99,16 @@ int dev_iommu_enable(struct udevice *dev)
 			return ret;
 		}
 		dev->iommu = dev_iommu;
+
+		if (dev->parent && dev->parent->iommu == dev_iommu)
+			continue;
+
+		ops = device_get_ops(dev->iommu);
+		if (ops && ops->connect) {
+			ret = ops->connect(dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 #if CONFIG_IS_ENABLED(PCI)
diff --git a/include/iommu.h b/include/iommu.h
index cf9719c5e91c..b8ba0b8e7077 100644
--- a/include/iommu.h
+++ b/include/iommu.h
@@ -4,6 +4,15 @@
 struct udevice;
 
 struct iommu_ops {
+	/**
+	 * init() - Connect a device to it's IOMMU, called before probe()
+	 * The iommu device can be fetched through dev->iommu
+	 *
+	 * @iommu_dev:	IOMMU device
+	 * @dev:	Device to connect
+	 * @return 0 if OK, -errno on error
+	 */
+	int (*connect)(struct udevice *dev);
 	/**
 	 * map() - map DMA memory
 	 *

-- 
2.42.1

