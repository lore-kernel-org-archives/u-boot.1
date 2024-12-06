Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB4DE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930E289434;
	Fri,  6 Dec 2024 23:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y2Q5K5tb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6408870D; Fri,  6 Dec 2024 23:55:25 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1389434
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4667931f14bso39690841cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525721; x=1734130521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndZkRBz8e+oOX0+xXuTU1p45dhwl7oHAgnohSTQkqZI=;
 b=y2Q5K5tbo1r8RsZ9Y5t2aus+hxjWmWTf3aawiqSxrqY6vxAO2eXR4tW9fapzO1ES5x
 F6Yli60X9jCrHXGnWGYBWlIskezcxSEHi//6FVrBJwWyj8/gkH+wdrHjFfRBizn3E0SM
 M33ySj3Fc3fKC+CoY6wQZMqdSgcSofySIq+OBTmszwqWnr3mkiqFB0kSwy+1sJww1sZE
 +9XSOXuzpZdQBqZ34Dxf6toaKa8Hxd0bsCgk7FdUfge/uhbLLZLjak534O6r4qVTcC1H
 YSMwRIQjN1IpakOU3lYEED53F0pXkO3Kb0g0HhhbQg2u78lCcK3jd4Aa+T9XUhCmgbQ0
 w3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525721; x=1734130521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndZkRBz8e+oOX0+xXuTU1p45dhwl7oHAgnohSTQkqZI=;
 b=ncQ9p8U3DtskDPfymnnxVf6JKfhXN6CqgFntLIB3FLsnFNKoR+1UsXBfmDXoVtvboS
 36ANjD6Nm7A8y17OxIGZN7Xq3NVaxImYN09yRQV86HXO3ozru6gDbteHH4IjNuD0uxGN
 CjltsOkGZWQlr6nQa+ymXZqeqv8xuiwwrZd+9avTV1aaDm+7M3Nxd2tthKX2L5bpU9or
 bW3v5HVjcTIMGLl3mATXQfBZtAEcVuHejJySn1U73dcjUVCnY//BGduar1aazOK3kdTI
 SZb3zH5E2HqVEUnhfMUESEP2AHx3O/HsOmKYciHi+n/mkXRPZ9Aq+2Zajh9kAWJD6Xki
 NFlg==
X-Gm-Message-State: AOJu0Yxc1KWUrnJWGwGlb4dcBqQIGg86b4OHVzVc9IRc6+0aaBKERAoe
 W96xPRxgJz/W4XFMpw7iEPQjZRHVxtora5Xp7FYYUK0o1s8io0dBNmc5kC0bV7k8JR1QZPY3/ja
 3
X-Gm-Gg: ASbGncs3Csy/1xqQrhfw3FER+6SW56j6NbkWpWIuMU8cfOsCkJ3DQIuTUuMzKfSHzXv
 9cBpvQERzETZm/OTVeAymGAwBQdyB+oCDRlfgmGwIHj5QdJIcr/jb+VBNarVvw2zs784Y9GvUzj
 P/oazA58wk2IVkoWma1A3RhRot36+VPgCNkpqIoRqW+b5p7bwEoSmMMr44ELuVz9UWpmSnxV2WP
 I02dQ7rYcx133EzhhhAaw3UDYvmF7kE8hnw525QnleQV4EWpXuB/y/oYuH2KNsrINf0yKZoWS7t
 n207TWFzIzcaF0XPXK6WICEZ8M7Jn3Txe9Y5oh2es8D9pJdm
X-Google-Smtp-Source: AGHT+IEh0kDW4uB+ylrMI5/74JvkCPZ7udgonwZ4ItxxUZMo0b9pDqf6KVpldG1WWmcCWzYuk5xj2g==
X-Received: by 2002:a05:622a:1490:b0:466:85eb:6118 with SMTP id
 d75a77b69052e-46734cbceaamr83933911cf.16.1733525719998; 
 Fri, 06 Dec 2024 14:55:19 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:55:19 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 02/10] sysinfo: Add sysinfo API for accessing data area
Date: Fri,  6 Dec 2024 14:54:19 -0800
Message-Id: <20241206225438.13866-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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
Changes in v3
- Use void pointer to avoid casting.

 drivers/sysinfo/sysinfo-uclass.c | 20 ++++++++++++++++++++
 include/sysinfo.h                | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index d77d1e3ee44..3c0cd51273e 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -99,6 +99,26 @@ int sysinfo_get_str(struct udevice *dev, int id, size_t size, char *val)
 	return ops->get_str(dev, id, size, val);
 }
 
+int sysinfo_get_data(struct udevice *dev, int id, void **data, size_t *size)
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
index 027a463dc33..cb6cf326535 100644
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
+	int (*get_data)(struct udevice *dev, int id, void **data, size_t *size);
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
+int sysinfo_get_data(struct udevice *dev, int id, void **data, size_t *size);
+
 /**
  * sysinfo_get() - Return the sysinfo device for the sysinfo in question.
  * @devp: Pointer to structure to receive the sysinfo device.
@@ -241,6 +265,12 @@ static inline int sysinfo_get_str(struct udevice *dev, int id, size_t size,
 	return -ENOSYS;
 }
 
+static inline int sysinfo_get_data(struct udevice *dev, int id, void **data,
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

