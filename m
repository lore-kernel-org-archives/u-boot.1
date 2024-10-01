Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADB2CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EAD891D5;
	Tue,  1 Oct 2024 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vw7if2Xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65172891C3; Tue,  1 Oct 2024 14:25:51 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6444B891A0
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so2883272f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785549; x=1728390349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ww65GyTXJipvU5QT85dU2fN88IMg6eQZxeBYxlbxRpc=;
 b=Vw7if2XhPTE4PyrKGyu4mpKavOfFCZluBodesfeYyKjfiAG7xqBYc2hSKC8ybvJrxp
 Lfztz+X/pjekDK1AXJfo991Sw2Oy9o+z6mpneNx74ZDe4wSXK35oqYRfngTqF6WTJzAW
 dpHDStImlcoH4/hdYdNH27mPY8aUN2l5wUka7vKkpA9nhHq6eVaGNJbro+sHbWlHPIDA
 5TKzjoCwaPnn0JXiiyl8+vkloU/OYrN4eeWJUCCxuEy7IZvftKdijYpQfI7z80YLU007
 amQcOBsLz7u9D+p4jePUXIIpG4xZHJ+RGVi1892rK5HZT0bTbJc0aOKIC/wvB/EWPKgi
 Aqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785549; x=1728390349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ww65GyTXJipvU5QT85dU2fN88IMg6eQZxeBYxlbxRpc=;
 b=Kv0idQvOxQG/V5mH01GaX3HCyVIC0dMS2ZpiMI88Y9xYEx9bQ46C3SQGipgB1RJEnz
 80i8AEcY+OBEQPdGnBYKV77fFi1kzI2I4k9ilA6xjJ0n0bDYcapthKF/O8O0wRfCdlZF
 7fJNVk3A+AAjyoXeJ4dgcbinThEmbF57WoP7K3Sr3zzannZB38FEO4CCm9rf83eIUia8
 dzYMhsyNVc6k63CTOrM+SxrEGThI7Hh3Fvcaj5ltspp2bI4U3Ok9FspZt0HC0FvNVqan
 5VDbcHicCOrYxwqxaqG9oPnwIvmQS1x7sJUSXzE7hraKG9wwYNfDEU6c9v2TK8pH0BIg
 qj2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8C8RVBZ7UQomLSw82Y6rG9ghHr5wPuPH5AXjdX1r0CytSjW9o0mjh0T7UFYO0TnRKfD3wwZg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjx/iX/qUa8xsTjmyuzVuuP613ltzbag/eFO4Ik654m1OXE8Ii
 LVuxNHf6SZDgjPmQL47ZocJWBUFIBNmcJfzTiB2Rwc72SARi+OGc
X-Google-Smtp-Source: AGHT+IEhVuLZALJQI5YwQzqBau5Z9eEVONgi/4CWEsujo0bpyKzBFvGumjiXKEwYQHTlfaFmIZTZVg==
X-Received: by 2002:adf:e80f:0:b0:374:bd93:9bd4 with SMTP id
 ffacd0b85a97d-37cd5b07419mr9007834f8f.56.1727785548640; 
 Tue, 01 Oct 2024 05:25:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 02/11] dm: core: implement ofnode_options helpers
Date: Tue,  1 Oct 2024 14:24:35 +0200
Message-ID: <20241001122511.8832-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
adapt to the new way to declare options as described in [1].

[1] dtschema/schemas/options/u-boot.yaml

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

