Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EECC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C4088BC4;
	Fri, 16 Aug 2024 17:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TtfgOJCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4D988BB9; Fri, 16 Aug 2024 17:47:29 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78DF88BA5
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a1da036d35so140026785a.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823245; x=1724428045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GAJNKWAuba+wxxbEcSf2zFQIm9kC5cWBy2zJjrxZQg=;
 b=TtfgOJCYTX/ibhNWqOupY2y455OhAiNmhp3NMlhntj3pJhTMq/LFhHZrr+hsCUemJJ
 kow4oDRMdd7onywlkDY4jLjlIxj139R3oHJ/mQtJQiagLL8b02fRwnBf7ERr0OcMBb3C
 sWyYqUtvXJrjPoY+ZG1J6PfHQ3snSySX/uizj7Ji/vSF4dnQpB+5xHhjes89VOORmlQE
 W94RSIyqVwq6uFIFlw9ms91fHkWLqDZFVGhGpaJLgmqRoNj2/6UBZLHdLTOFeBJFiHA2
 dDjQEiwf+ONmgEZqqUb7wTwfovFbRG1hOg74PvysAo6jN12svEJN3LO152TGMnWhITxn
 5ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823245; x=1724428045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GAJNKWAuba+wxxbEcSf2zFQIm9kC5cWBy2zJjrxZQg=;
 b=qJhbblBPBm4fppWXhb1QW5UcHbXWOAk5mow5wmQQjcUi60rthOAKR7B4lPU2jZGcE+
 ZEwILGhrerJBXLHS7Y13qqS8Gpn0jDrd9Qmay3abEMryTkgJFitm9hsuJmg4HlYE/xag
 Mq9xJumylpCTgqwHa7J2b8P13m3VJtm0DLP6YnYCNra+xvKfWVxDiHQ/uIq7yHaJcwDt
 grqZ4fROPT/EofTyOzdyPc4XyFvCqgGf3EXZ9kSrRJBBP/41nEOSOFeGiV2sHfYBB9Ji
 u7DE0G3qp4iCpatXHIavAeBcpD0AUCxg7lZVZi5PDex8juhPMg4PV7jvFa7dJPN/TEa4
 OdPg==
X-Gm-Message-State: AOJu0YwYMM7BxI+8fBhHXWnJF6KPSbhyVJerk2XbS3bml4ZwWPzsMxAD
 QWZQCZSE8lUm5LaQ8ySP+lcQ16lJ66plWmlJZBUpewz7ovrnrY20sBU+TiVsltVQhxtRjPl+V60
 sjfE=
X-Google-Smtp-Source: AGHT+IFH0lpuff1lMey4wgtQ6q6Hzwd8XFGJ9Qh9LYcaNb/2IPb1zW+YxCy+b/wA225YE2gkBClZ6g==
X-Received: by 2002:a05:620a:2943:b0:7a1:c40c:b1f1 with SMTP id
 af79cd13be357-7a5069dd10amr358150885a.58.1723823245338; 
 Fri, 16 Aug 2024 08:47:25 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:24 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Stefan Roese <sr@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 01/10] sysinfo: Add sysinfo API for accessing data area
Date: Fri, 16 Aug 2024 08:46:44 -0700
Message-Id: <20240816154658.1866186-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

