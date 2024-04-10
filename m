Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77321CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C62881A6;
	Wed, 10 Apr 2024 19:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YxlkRUn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52E587A00; Wed, 10 Apr 2024 19:07:14 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9258815A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a51d3193e54so422955966b.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712768830; x=1713373630; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=02zx0nKuszz8w4M8rcBUaVZHu951fIoW3vmJjCnRxRI=;
 b=YxlkRUn4WkjqMw8z/0H7J9Yzm+Rd9VY4MspkYuV44UiQ1m1Bq+IlvYShY3ZtAFtopQ
 6Xyd5qtEwPzXX7MB+SDzZLPUpJY9z/W/Q6PkRaVJ+RmupTAoCS8oZEDsB1dr1WFdNCw1
 My1Hcdmv+IfOesmMWAqiil4eXfLeJE1L/txFrFbAN6Ad8syo+x+K3iNNhoaRbDERbvcV
 lb8EuEKwEzAjxmt5D5Anjdbi47aC9EJhf0t+sF/3MOUuC7Gn/oQuXYRlHL8PdMcczsTv
 5XtFuSwlHokzj3B3RIO8J33KsGeTvOYOz5LWiIUkHYYgFsu/2lp9lKbRLGybKm53PAit
 VygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712768830; x=1713373630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02zx0nKuszz8w4M8rcBUaVZHu951fIoW3vmJjCnRxRI=;
 b=T/QpXvv3YMM1VgPzb/YB7e1VAFwGflT7S8E58IfHMZIZI497CQnMM0NOMwaUWdz/wn
 eHWvcNgZ6lHfR6ZfwxDymqi+/F6PcuvaDtFnVh+tZ94/w6qp5B+hJ3IFz1Ga6J9mKYHT
 95RN7V+r/tXqEjDLV98IZ7UXZxZFjF3oKeAQVrxO4XJPag9APHR377lwicTDo9mSwjN/
 BsIxrMXYiDhNIvhn3AMO7B6I0E2QRiKbWTNtV7kZQARvKAq7h0tLQB0vZH5fuKJEvSiW
 sDAUJVwYSgn26QbDWBu3/696691XgAFfo/3xWos/9VH0QBZD7RhoQg+LTgAx7N0t5lJD
 VELw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZGBtlc5jfhePi1wma/PsUYZ0Mr1kz7rPYOJcJzaLcs8ZVPYxecQCei1lMqpfRplOvvz7pjaR3Nzbgag6b0eWU5FNCkA==
X-Gm-Message-State: AOJu0Yz2LyrWIhuMq5ooulCfz6OR9+H6AfioxQl/vxIIhU5Nq93kDyb9
 fETkMD+iFi4uJFFCn13YD9fDlOFSW+5T7ZhEgzn+7wPGG49sa4oaImAOmJm6R/A=
X-Google-Smtp-Source: AGHT+IFl6OnMsLwkH7TwWe+xbuR36hz09wRiilZ3b9Ruur/2iS3YSyVCLJ/3X7RUhZ7bIe69kL2nIg==
X-Received: by 2002:a17:906:168e:b0:a47:3312:b32a with SMTP id
 s14-20020a170906168e00b00a473312b32amr1919786ejd.58.1712768830205; 
 Wed, 10 Apr 2024 10:07:10 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 fw14-20020a170906c94e00b00a51def4861bsm3331881ejb.91.2024.04.10.10.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:07:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:06:57 +0200
Subject: [PATCH 1/2] dm: core: add support for fallback drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
In-Reply-To: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uW3PK2f+vNh4A0TYpzbXWCElmio+ONn45bjBs9aUpF0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFsc7YF0BDVZO+uz5tupQgE07BKp8Ga8CO2qp9
 hox89OoEr+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbHOwAKCRAFgzErGV9k
 tkOOD/0SKIDh/houY3Vc1EjRfU89aK1EFjC00epK1FvezX141IgzZ09dqoVNGNGd/snA1StVIgQ
 XJJANgWevmKq8no0jP9Hl8ERYQRSabpmIfjiwYCKBoPhWrhwf4paUyCG3lI6JtDkb5OrTpCEH+k
 m3bKNijBP6LgGbyYPWRWMN9aNLFtDGYqmHglPZHWJmXXnjDsmg486vJcIpitGNpqULk9ZExEUmr
 ZiPkvsJOx/1l3Lq6fx6hB2MHA3EzHPLHz6Vo5DGauYoELr/FICtmSelMbdm76mvvWWN3kwlIDQS
 A877anXpMNxYLpWWsOszX/FxthHjLZEKFC6eQBcva/AI9X3sFLzg88cDY1dsGk3LIuX6AGYilKJ
 bCfGqObCderWBuCjIV+mygAyrULbS4GLwD79mBST2PPb+qK9i6FGx/9s0iHIn+icfuD5b4n02eu
 yoZ+WV1P6CqjHENkc3gGc/qDo+bmAbyIOZStS1LWrX5zP7035k+qhIaiBoDu0Az1k2S4w/N2xNw
 Wgkr1WT6Wsoee/SOgt/Rf/7qQNnBSZlujUwJcThoJHMCVbAQMjNTj7X9pBJHKuwQJ3rWTkT4li/
 TKb20UnbFHKueU+hHNwVEeZoDSmmGVLJGaknY0qMdBufm7abR7x05hrln9NTT/6oRPAqqBpef9P
 eEOVafkRsRNQOfg==
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

Introduce support for a uclass to provide a fallback/stub driver which
can be used when no device is found for a given node. This might be
useful for handling non-essential clock controllers like the RPMh on
Qualcomm platforms, or during early bringup to get UART output before a
real clock driver has been created.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/core/Kconfig  | 10 ++++++++++
 drivers/core/uclass.c | 24 +++++++++++++++++++++++-
 include/dm/uclass.h   |  3 +++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 1081d61fcf01..09075b9b7a15 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -466,5 +466,15 @@ config BOUNCE_BUFFER
 
 	  A second possible use of bounce buffers is their ability to
 	  provide aligned buffers for DMA operations.
 
+menuconfig FALLBACK_DRIVERS
+	bool "Enable per-uclass fallback drivers"
+	depends on DM
+	help
+	  If a driver requests a resource (like a clock) from a node which
+	  isn't bound to a driver, the driver model will look for a fallback
+	  driver to "stub" the resource. These stubs usually do nothing and
+	  are therefore only suitable in instances where the resource is not
+	  required.
+
 endmenu
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index e46d5717aa62..91d3a48d77b8 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -378,8 +378,26 @@ int uclass_find_device_by_of_offset(enum uclass_id id, int node,
 
 	return -ENODEV;
 }
 
+static int uclass_bind_fallback(struct uclass *uc, ofnode node, struct udevice **devp)
+{
+	struct driver *drv;
+
+	log(LOGC_DM, LOGL_ERR, "   - binding fallback '%s' driver '%s'\n",
+	    uc->uc_drv->name, uc->uc_drv->fallback_drv_name);
+
+	drv = lists_driver_lookup_name(uc->uc_drv->fallback_drv_name);
+	if (!drv) {
+		log(LOGC_DM, LOGL_DEBUG, "   - Can't find stub driver '%s' for uclass '%s'\n",
+		    uc->uc_drv->fallback_drv_name, uc->uc_drv->name);
+		return -ENOENT;
+	}
+
+	return device_bind_with_driver_data(gd->dm_root, drv,
+					  ofnode_get_name(node), 0, node, devp);
+}
+
 int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
 				 struct udevice **devp)
 {
 	struct uclass *uc;
@@ -401,9 +419,13 @@ int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
 			*devp = dev;
 			goto done;
 		}
 	}
-	ret = -ENODEV;
+
+	if (CONFIG_IS_ENABLED(FALLBACK_DRIVERS) && uc->uc_drv->fallback_drv_name)
+		ret = uclass_bind_fallback(uc, node, devp);
+	else
+		ret = -ENODEV;
 
 done:
 	log(LOGC_DM, LOGL_DEBUG, "   - result for %s: %s (ret=%d)\n",
 	    ofnode_get_name(node), *devp ? (*devp)->name : "(none)", ret);
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index 456eef7f2f31..b99e36485bc5 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -67,8 +67,10 @@ struct udevice;
  * @child_pre_probe: Called before a child in this uclass is probed
  * @child_post_probe: Called after a child in this uclass is probed
  * @init: Called to set up the uclass
  * @destroy: Called to destroy the uclass
+ * @stub_drv_name: Name of a stub driver to use for devices that are not
+ * supported by any other driver.
  * @priv_auto: If non-zero this is the size of the private data
  * to be allocated in the uclass's ->priv pointer. If zero, then the uclass
  * driver is responsible for allocating any data required.
  * @per_device_auto: Each device can hold private data owned
@@ -98,8 +100,9 @@ struct uclass_driver {
 	int (*child_pre_probe)(struct udevice *dev);
 	int (*child_post_probe)(struct udevice *dev);
 	int (*init)(struct uclass *class);
 	int (*destroy)(struct uclass *class);
+	const char *fallback_drv_name;
 	int priv_auto;
 	int per_device_auto;
 	int per_device_plat_auto;
 	int per_child_auto;

-- 
2.44.0

