Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD0C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 09:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6CB87483;
	Thu,  7 Dec 2023 10:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KcFhbOkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E298745E; Thu,  7 Dec 2023 10:19:05 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792A8871BB
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 10:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3334a701cbbso717814f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701940743; x=1702545543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIRbBgzEcdaHWJ7fVa5JIsDJda65F2tSuL1aji2tJ5U=;
 b=KcFhbOkMkvXbThdeAeI92+uSdN5LvKdwae+36Z/jz0Hg0yPDs5v8UqeDt2d+NaSlh9
 GERy8kIMCopTcJ13FoUM8Ok4PBSMRSDxbJo4lLaGIbddw7hcit4uxhJfTAL8zKxnboMU
 YBZPC/E2NjWklmJx6p4zmLeXS5IzncTaDE9z2XFMRGrJ/KLqpTvwOp/nf57jP/kdIxpe
 Q7vWAhVY8gC19ogSD41RB4ixA0HefI6xKq6fAl2GwvRlOvCEGAcVdpbl8aj5R8qEOSVT
 BsuqzbDXHlQI6L9Y++Yqe89LcKMRoAWqHrgOuO3eBwnEp2jjjzV8G24mTFD+4wso1ERo
 mIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940743; x=1702545543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIRbBgzEcdaHWJ7fVa5JIsDJda65F2tSuL1aji2tJ5U=;
 b=pee1V3/z6lW4enMw0ueHvBJJXGhNLq7KccXmY4QkXfVRLXGBOedbBwQH1KXDxj/gJs
 RZ/KhsEvPN4qeqrqpeOnQoDBQs3QarjlsMHmlhnlBZMpgPKTJyg5MEpZPAlnfqZJkd4A
 vMMYc1fZ+alT5gfZjdzpLypC2sOj9yC3ktb8ZYXQGQzN7yCYrQnBHgiYn3vDDaHMaQNH
 n73RxiQNWJs9Ekow2hxk4l2FDpvlwuiFr9y+dnuzo5TvpbgaDbj64tcqxalnusBw3jKC
 fE6r5cob553rh/ZM/bVJD/PIXP+LOSUHyiqJG+7KpEpSAY984EIHkKFRRbLHSIuwBAK+
 wTIw==
X-Gm-Message-State: AOJu0YwQcpf2rvKZHAPWsPT7fH7x3sa+mhF5kDJ557Oe9zwmQc4v6NzO
 ZFEgE8KlljYnqibJKd2JdRCP6A==
X-Google-Smtp-Source: AGHT+IEfJolrJ5g6Qgn465DsdBpMZMW+cn6kVgLvehQIXNT7VcXYfkBvC8Hf5zXnl7Q5Yto7bS2tOg==
X-Received: by 2002:a05:600c:d5:b0:40b:5e59:99c6 with SMTP id
 u21-20020a05600c00d500b0040b5e5999c6mr940484wmm.230.1701940742953; 
 Thu, 07 Dec 2023 01:19:02 -0800 (PST)
Received: from localhost.localdomain (ppp046103111243.access.hol.gr.
 [46.103.111.243]) by smtp.gmail.com with ESMTPSA id
 u21-20020a05600c139500b00405d9a950a2sm1299003wmf.28.2023.12.07.01.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 01:19:02 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo nodes
 are missing
Date: Thu,  7 Dec 2023 11:18:50 +0200
Message-Id: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
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

In order to fill in the SMBIOS tables U-Boot currently relies on a
"u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
that already include such nodes.  However with some recent EFI changes,
the majority of boards can boot up distros, which usually rely on
things like dmidecode etc for their reporting.  For boards that
lack this special node the SMBIOS output looks like:

System Information
        Manufacturer: Unknown
        Product Name: Unknown
        Version: Unknown
        Serial Number: Unknown
        UUID: Not Settable
        Wake-up Type: Reserved
        SKU Number: Unknown
        Family: Unknown

This looks problematic since most of the info are "Unknown".  The DT spec
specifies standard properties containing relevant information like
'model' and 'compatible' for which the suggested format is
<manufacturer,model>. Unfortunately the 'model' string found in DTs is
usually lacking the manufacturer so we can't use it for both
'Manufacturer' and 'Product Name' SMBIOS entries reliably.

So let's add a last resort to our current smbios parsing.  If none of
the sysinfo properties are found, scan for those information in the
root node of the device tree. Use the 'model' to fill the 'Product
Name' and the first value of 'compatible' for the 'Manufacturer', since
that always contains one.

pre-patch:
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Unknown
        Product Name: Unknown
        Version: Unknown
        Serial Number: 100000000bb24ceb
        UUID: 30303031-3030-3030-3061-613234636435
        Wake-up Type: Reserved
        SKU Number: Unknown
        Family: Unknown
[...]

and post patch:
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: raspberrypi
        Product Name: Raspberry Pi 4 Model B Rev 1.1
        Version: Unknown
        Serial Number: 100000000bb24ceb
        UUID: 30303031-3030-3030-3061-613234636435
        Wake-up Type: Reserved
        SKU Number: Unknown
        Family: Unknown
[...]

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Simon, I'll work with tou on the refactoring you wanted and
remove the EFI requirement of SMBIOS in !x86 platforms.
Since this code has no tests, I'll add some once the refactoring
is done

Changes since v2:
- Spelling mistakes
- rebase on top of patch #1 changes
Changes since v1:
- Tokenize the DT node entry and use the appropriate value instead of
  the entire string
- Removed Peters tested/reviewed-by tags due to the above
 lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 444aa245a273..3f0e1d529537 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -9,11 +9,14 @@
 #include <dm.h>
 #include <env.h>
 #include <linux/stringify.h>
+#include <linux/string.h>
 #include <mapmem.h>
 #include <smbios.h>
 #include <sysinfo.h>
 #include <tables_csum.h>
 #include <version.h>
+#include <malloc.h>
+#include <dm/ofnode.h>
 #ifdef CONFIG_CPU
 #include <cpu.h>
 #include <dm/uclass-internal.h>
@@ -43,6 +46,25 @@

 DECLARE_GLOBAL_DATA_PTR;

+/**
+ * struct map_sysinfo - Mapping of sysinfo strings to DT
+ *
+ * @sysinfo_str: sysinfo string
+ * @dt_str: DT string
+ * @max: Max index of the tokenized string to pick. Counting starts from 0
+ *
+ */
+struct map_sysinfo {
+	const char *sysinfo_str;
+	const char *dt_str;
+	int max;
+};
+
+static const struct map_sysinfo sysinfo_to_dt[] = {
+	{ .sysinfo_str = "product", .dt_str = "model", 2 },
+	{ .sysinfo_str = "manufacturer", .dt_str = "compatible", 1 },
+};
+
 /**
  * struct smbios_ctx - context for writing SMBIOS tables
  *
@@ -87,6 +109,18 @@ struct smbios_write_method {
 	const char *subnode_name;
 };

+static const struct map_sysinfo *convert_sysinfo_to_dt(const char *sysinfo_str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
+		if (!strcmp(sysinfo_str, sysinfo_to_dt[i].sysinfo_str))
+			return &sysinfo_to_dt[i];
+	}
+
+	return NULL;
+}
+
 /**
  * smbios_add_string() - add a string to the string area
  *
@@ -124,6 +158,42 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
 	}
 }

+/**
+ * get_str_from_dt - Get a substring from a DT property.
+ *                   After finding the property in the DT, the function
+ *                   will parse comma-separated values and return the value.
+ *                   If nprop->max exceeds the number of comma-separated
+ *                   elements, the last non NULL value will be returned.
+ *                   Counting starts from zero.
+ *
+ * @nprop: sysinfo property to use
+ * @str: pointer to fill with data
+ * @size: str buffer length
+ */
+static
+void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
+{
+	const char *dt_str;
+	int cnt = 0;
+	char *token;
+
+	memset(str, 0, size);
+	if (!nprop || !nprop->max)
+		return;
+
+	dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
+	if (!dt_str)
+		return;
+
+	memcpy(str, dt_str, size);
+	token = strtok(str, ",");
+	while (token && cnt < nprop->max) {
+		strlcpy(str, token, strlen(token) + 1);
+		token = strtok(NULL, ",");
+		cnt++;
+	}
+}
+
 /**
  * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
  *
@@ -137,6 +207,8 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
 static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 			      int sysinfo_id, const char *dval)
 {
+	int ret;
+
 	if (!dval || !*dval)
 		dval = "Unknown";

@@ -145,18 +217,30 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,

 	if (sysinfo_id && ctx->dev) {
 		char val[SMBIOS_STR_MAX];
-		int ret;

 		ret = sysinfo_get_str(ctx->dev, sysinfo_id, sizeof(val), val);
 		if (!ret)
 			return smbios_add_string(ctx, val);
 	}
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
-		const char *str;
-
-		str = ofnode_read_string(ctx->node, prop);
+		const char *str = NULL;
+		char str_dt[128] = { 0 };
+		/*
+		 * If the node is not valid fallback and try the entire DT
+		 * so we can at least fill in manufacturer and board type
+		 */
+		if (ofnode_valid(ctx->node)) {
+			str = ofnode_read_string(ctx->node, prop);
+		} else {
+			const struct map_sysinfo *nprop;
+
+			nprop = convert_sysinfo_to_dt(prop);
+			get_str_from_dt(nprop, str_dt, sizeof(str_dt));
+			str = (const char *)str_dt;
+		}

-		return smbios_add_string(ctx, str ? str : dval);
+		ret = smbios_add_string(ctx, str && *str ? str : dval);
+		return ret;
 	}

 	return 0;
--
2.40.1

