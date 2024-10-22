Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC23CDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E76891FE;
	Tue, 22 Oct 2024 22:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mOlBMU7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6EE88FA7; Tue, 22 Oct 2024 22:06:45 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3C5891FE
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so44433056d6.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627602; x=1730232402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmamfntYTLN2Q9kpXc6G9q8faIjO5He49ZDhNO3zcKY=;
 b=mOlBMU7Au5YPjonwJPmyU1ylfu1RKMWyovdj2omKYiV5EACwm6Rg3L2hEhZTSl96sy
 lrTdwxXJyz3pi0+RPm2vTEiYY3BroDSEh/f/odTKY7YWRjljG2MmSDWxlqxltZLwM4Yb
 QQPAowQta/V5lFVk0qVxJ1PmR/WTnqnXND+QV1L0f7bGJ2gfN9nCgXKdZlcUwMcDgZZk
 AhQCZUjJrFanZsowui++Rv6UgOM4vQgRjVhNAyAf6pA6ZVG29lSLaj8XQh6OcG1g2qoe
 mzvTuVEsccKnuwR6UIPyrdR3tAeb0Lu7DoPUcSGDbjXl1AF8PnrDCiM4C9Z+L/ubpb9U
 gJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627602; x=1730232402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmamfntYTLN2Q9kpXc6G9q8faIjO5He49ZDhNO3zcKY=;
 b=QuHHdEBGj7aUT8JF9kR41jEJA9TfnQwCFZFn4ObL8Z1fjVrK6gU8JKHC3/dKuyzLfQ
 f9OhonRk4Wr4sVjVZF6HpXQ3I63FniGKB8QydTJimoqQY/urcBHmLkYTOu96shggYLVJ
 a256l0sIEQ5Rzkrnyrdr+xK+mbk6ebaASFNeWsXY3GwBItne5eVS6SSgZlA2s3VQuez9
 kjuPgq1rjyfuBQUTa+4uDvCYhXfI24bNVa1pRrDO8OtkHo/JNr8pXL0jpX16Lkg1pO/m
 AKdtyJ3ivS9Z31otyvuIr7mRvlfUSpiKJnOHxxb2KhokjDUNa4EKW5fdylfis1LqLWqn
 lulQ==
X-Gm-Message-State: AOJu0YytwQgX/Lab2z5XQz51ZOvKJ2IxGHTUKOaAIm/yMufWnXrIFu3g
 9TKQn+NrXiv4GZbO66jFAciwEJDiM+rqpbglpEUXy6fqJYAX/nU8bzzh9Iab8T6Q7MDbnWK/8jY
 FLhw=
X-Google-Smtp-Source: AGHT+IGx0p3asx4ninznY1Z6NzCxICEXYz1lxHDhhX25hxtlyCjNRQIjWbeSGKg8f6VSqa2q8LS5iA==
X-Received: by 2002:a05:6214:2f02:b0:6cb:99db:bdd5 with SMTP id
 6a1803df08f44-6ce342ca49fmr4109266d6.39.1729627601993; 
 Tue, 22 Oct 2024 13:06:41 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:06:41 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Jonas Karlman <jonas@kwiboo.se>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 2/8] sysinfo: Add sysinfo API for accessing data area
Date: Tue, 22 Oct 2024 13:05:23 -0700
Message-Id: <20241022200543.116343-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
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

Add interface for sysinfo to access a data area from the platform.
This is useful to save/read a memory region of platform-specific
data.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 drivers/sysinfo/sysinfo-uclass.c | 20 ++++++++++++++++++++
 include/sysinfo.h                | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index d77d1e3ee44..04a7748834a 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -99,6 +99,26 @@ int sysinfo_get_str(struct udevice *dev, int id, size_t size, char *val)
 	return ops->get_str(dev, id, size, val);
 }
 
+int sysinfo_get_data(struct udevice *dev, int id, uchar **data, size_t *size)
+{
+	struct sysinfo_priv *priv;
+	struct sysinfo_ops *ops;
+
+	if (!dev)
+		return -ENOSYS;
+
+	priv = dev_get_uclass_priv(dev);
+	ops = sysinfo_get_ops(dev);
+
+	if (!priv->detected)
+		return -EPERM;
+
+	if (!ops->get_data)
+		return -ENOSYS;
+
+	return ops->get_data(dev, id, data, size);
+}
+
 UCLASS_DRIVER(sysinfo) = {
 	.id		= UCLASS_SYSINFO,
 	.name		= "sysinfo",
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 8a77ef44856..17b2b9c7111 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -115,6 +115,18 @@ struct sysinfo_ops {
 	 */
 	int (*get_str)(struct udevice *dev, int id, size_t size, char *val);
 
+	/**
+	 * get_data() - Read a specific string data value that describes the
+	 *	       hardware setup.
+	 * @dev:	The sysinfo instance to gather the data.
+	 * @id:		A unique identifier for the data area to be get.
+	 * @data:	Pointer to the address of the data area.
+	 * @size:	Pointer to the size of the data area.
+	 *
+	 * Return: 0 if OK, -ve on error.
+	 */
+	int (*get_data)(struct udevice *dev, int id, uchar **data, size_t *size);
+
 	/**
 	 * get_fit_loadable - Get the name of an image to load from FIT
 	 * This function can be used to provide the image names based on runtime
@@ -186,6 +198,18 @@ int sysinfo_get_int(struct udevice *dev, int id, int *val);
  */
 int sysinfo_get_str(struct udevice *dev, int id, size_t size, char *val);
 
+/**
+ * sysinfo_get_data() - Get a data area from the platform.
+ * @dev:	The sysinfo instance to gather the data.
+ * @id:		A unique identifier for the data area to be get.
+ * @data:	Pointer to the address of the data area.
+ * @size:	Pointer to the size of the data area.
+ *
+ * Return: 0 if OK, -EPERM if called before sysinfo_detect(), else -ve on
+ * error.
+ */
+int sysinfo_get_data(struct udevice *dev, int id, uchar **data, size_t *size);
+
 /**
  * sysinfo_get() - Return the sysinfo device for the sysinfo in question.
  * @devp: Pointer to structure to receive the sysinfo device.
@@ -241,6 +265,12 @@ static inline int sysinfo_get_str(struct udevice *dev, int id, size_t size,
 	return -ENOSYS;
 }
 
+static inline int sysinfo_get_data(struct udevice *dev, int id, uchar **data,
+				   size_t *size)
+{
+	return -ENOSYS;
+}
+
 static inline int sysinfo_get(struct udevice **devp)
 {
 	return -ENOSYS;
-- 
2.25.1

