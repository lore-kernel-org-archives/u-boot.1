Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF56CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC860884D2;
	Sat, 21 Sep 2024 04:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KcVXHRDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7A3882EF; Sat, 21 Sep 2024 00:51:46 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED686880A5
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so20447475e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872703; x=1727477503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VRN0d6KfaqLDmqpqJCnUxWCRaEWyqozsT4FxZ4aAWj0=;
 b=KcVXHRDOxsEguD57WYPLpjqDt+BZ4jwmdpjAjhhei+exrgy2Njg1UF+/Nb7c2k5Z0J
 Wv/GZ5oH/DkaLI/5Qsoi7peIwBC3NKeYGXR0QslW1HApPNux0GpqRFz0pRhirRjpTVK/
 rcoVzKs+O6B2kfZZBJgOtsas/dsKHhLCnOI1uRBtzIm1PFp+zzKLTUXiRnc2WYV+9zr/
 2Ncz3DEkaxOhiLy2yaDIVr5h6NBIaXG2ngfzG1pDPaAJTmCd8bQorcsCa9Yy9ZUf9edu
 FDkZZRR3QSDjzLpRiLnMrIh1A5D14lUCC9RSl5ShYJiB9juRF2lfXA8ar162gKnDDkIg
 ERZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872703; x=1727477503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRN0d6KfaqLDmqpqJCnUxWCRaEWyqozsT4FxZ4aAWj0=;
 b=ZSZl1Giy2dFUQ7zOopvDeKFaSujSdMx6zK5PkDfirIAEjEZaf+85dqPs+6sGty9W6F
 nGZ4E2PPCzJP/K/jxqp3z7JfuWaI3yAgg61CX3gKI6qSF41j8x/w27yL9/FpYwxUVRnv
 RS7XgrTL29anRwbIjZBg5mkohaY78Q3foeXSOQAHPJr78hbKdpSQqP7rc7946A7AZQAb
 KgX12Qf9OHzmEjsHnLhbRJtrmxDjODlHKEoL3ZmnYlwG9iZpy2Y4vw4D93ULApSzkcnV
 xFn42YIxpeJQ3xejQxSB2wrC0MtgCGeF2G+DDevnqhg7ZytR3/veqioZjvxJNNky9drq
 Jx2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX9qUz/Cv7rqBdg7WYATINoxbdTRatne9bAxJZemlGq5vLF+J88kQ71GGLM6loBK8d+DjD2GQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzcPVHWXfTf5CshoBbu8OI2fOGF6V09wOBDnBmeEDCxYhl+/+DJ
 N15qdwwFKMM9cSaPwWCRX2nlMf/irjkOWysa47oOj1TESbP9E0XQ
X-Google-Smtp-Source: AGHT+IEXnIHgmTjiwHQeVGUYhqIeyYgeiCaYkRnfxtmz4m+5ZSX5tBLFmzcaK2D0olGjrTD2jL5JuA==
X-Received: by 2002:a5d:4fc4:0:b0:374:c4c4:efa5 with SMTP id
 ffacd0b85a97d-37a431a6f79mr2349185f8f.53.1726872703128; 
 Fri, 20 Sep 2024 15:51:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 02/11] dm: core: implement ofnode_options helpers
Date: Sat, 21 Sep 2024 00:49:55 +0200
Message-ID: <20240920225101.2008-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

Implement ofnode_options helpers to read options in /options/u-boot to
adapt to the new way to declare options as described in [0].

[0] dtschema/schemas/options/u-boot.yaml

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/ofnode.c | 33 +++++++++++++++++++++++++++++++++
 include/dm/ofnode.h   | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 4d563b47a5a..4404c4f4bab 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1734,6 +1734,39 @@ const char *ofnode_conf_read_str(const char *prop_name)
 	return ofnode_read_string(node, prop_name);
 }
 
+bool ofnode_options_read_bool(const char *prop_name)
+{
+	ofnode uboot;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot))
+		return false;
+
+	return ofnode_read_bool(uboot, prop_name);
+}
+
+int ofnode_options_read_int(const char *prop_name, int default_val)
+{
+	ofnode uboot;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot))
+		return default_val;
+
+	return ofnode_read_u32_default(uboot, prop_name, default_val);
+}
+
+const char *ofnode_options_read_str(const char *prop_name)
+{
+	ofnode uboot;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot))
+		return NULL;
+
+	return ofnode_read_string(uboot, prop_name);
+}
+
 int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
 {
 	int ret;
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 5795115c490..0787758926f 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1587,6 +1587,47 @@ int ofnode_conf_read_int(const char *prop_name, int default_val);
  */
 const char *ofnode_conf_read_str(const char *prop_name);
 
+/**
+ * ofnode_options_read_bool() - Read a boolean value from the U-Boot options
+ *
+ * This reads a property from the /options/u-boot/ node of the devicetree.
+ *
+ * This only works with the control FDT.
+ *
+ * See dtschema/schemas/options/u-boot.yaml in dt-schema project for bindings
+ *
+ * @prop_name:	property name to look up
+ * Return: true, if it exists, false if not
+ */
+bool ofnode_options_read_bool(const char *prop_name);
+
+/**
+ * ofnode_options_read_int() - Read an integer value from the U-Boot options
+ *
+ * This reads a property from the /options/u-boot/ node of the devicetree.
+ *
+ * See dtschema/schemas/options/u-boot.yaml in dt-schema project for bindings
+ *
+ * @prop_name: property name to look up
+ * @default_val: default value to return if the property is not found
+ * Return: integer value, if found, or @default_val if not
+ */
+int ofnode_options_read_int(const char *prop_name, int default_val);
+
+/**
+ * ofnode_options_read_str() - Read a string value from the U-Boot options
+ *
+ * This reads a property from the /options/u-boot/ node of the devicetree.
+ *
+ * This only works with the control FDT.
+ *
+ * See dtschema/schemas/options/u-boot.yaml in dt-schema project for bindings
+ *
+ * @prop_name: property name to look up
+ * Return: string value, if found, or NULL if not
+ */
+const char *ofnode_options_read_str(const char *prop_name);
+
 /**
  * ofnode_read_bootscript_address() - Read bootscr-address or bootscr-ram-offset
  *
-- 
2.45.2

