Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32FFC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B0C86548;
	Wed, 30 Aug 2023 20:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EPAfIxB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9738486543; Wed, 30 Aug 2023 20:05:41 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F085A86516
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7923ae72111so2513739f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418735; x=1694023535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCEdU2BaJFCn3yYOY/j088Zx+fz32rIojqqiFsMiYP0=;
 b=EPAfIxB7vsS+f3CI8GzLIQh8Ces+RescUaspYmSh7CRBxUS8bBJGSGBSqxSpHXzkRC
 yfg7iPd4SgxufcnzbAjvTOnHAYUPMnIfUgjFhmCnAQmG6NCh01I7rRf83UI/vFz8lHOq
 zEh/DKzmRjbysYUiuUeEXptbcK0gE8P2cYJ24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418735; x=1694023535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCEdU2BaJFCn3yYOY/j088Zx+fz32rIojqqiFsMiYP0=;
 b=kLtogxDFc5ZO1xTgxElXlGwsmkEKi/81zDP28CYDiItLmW74T8pzPbNa+H8DQE7otC
 r/58pAWWMFPlCIjZ6mYj2yNaKXYFNen5t7nFrUHX1dxRCeiSSeHsuE+Lofq/K2q1XrcX
 y85mAYRCtt2Fwb1YQzGf1r0xvjVZVnxnuhvLkuqzE3pR0zC1EI6pAGBTM8sxQ8RobCXm
 2XyYJA7rXcHZPPSwk2WUJ61F+AXm/Uy24ubrNzSAA5dLYJLTMKLKhfW/HwNxcdig6m2N
 FUMoUgHWVx1/XdXQhI5e77hTo09JvibZMlLiGZ6T+RGKinJ+Nd/75UfhQbIOwf5KrVri
 PF/A==
X-Gm-Message-State: AOJu0Ywjqt/r693lZhyxT7fHArf5MsjtYPIlHiyrUMoHRgrqusBcMj4S
 ZBZqFzkrD6JiDPUJ3DT7RAC+FMDSRj3gleVNhpw=
X-Google-Smtp-Source: AGHT+IGgyNIoGmhuGljnUPoVQi+2Qf9kRAO1rcXS6f3hu7v3xn48oMk69KYjNGcLh3s00u3UXt9ZzQ==
X-Received: by 2002:a6b:d902:0:b0:790:fab3:2052 with SMTP id
 r2-20020a6bd902000000b00790fab32052mr3249019ioc.5.1693418735427; 
 Wed, 30 Aug 2023 11:05:35 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 01/32] dm: core: support reading a single indexed u64 value
Date: Wed, 30 Aug 2023 12:04:32 -0600
Message-ID: <20230830180524.315916-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

From: Michal Simek <michal.simek@amd.com>

Add helper function to allow reading a single indexed u64 value from a
device-tree property containing multiple u64 values, that is an array of
u64's.

Co-developed-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts |  1 +
 drivers/core/of_access.c  | 16 ++++++++++++----
 drivers/core/ofnode.c     | 30 ++++++++++++++++++++++++++++++
 include/dm/of_access.h    | 19 +++++++++++++++++++
 include/dm/ofnode.h       | 12 ++++++++++++
 test/dm/ofnode.c          |  8 ++++++++
 6 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b48456aebee..a413cbe4989 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -301,6 +301,7 @@
 		uint-value = <(-1234)>;
 		int64-value = /bits/ 64 <0x1111222233334444>;
 		int-array = <5678 9123 4567>;
+		int64-array = /bits/ 64 <0x1111222233334444 0x4444333322221111>;
 		str-value = "test string";
 		interrupts-extended = <&irq 3 0>;
 		acpi,name = "GHIJ";
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 57f10445b12..1bb4d8eab70 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -570,26 +570,34 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
 	return 0;
 }
 
-int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp)
 {
 	const __be64 *val;
 
 	debug("%s: %s: ", __func__, propname);
 	if (!np)
 		return -EINVAL;
-	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
+
+	val = of_find_property_value_of_size(np, propname,
+					     sizeof(*outp) * (index + 1));
 	if (IS_ERR(val)) {
 		debug("(not found)\n");
 		return PTR_ERR(val);
 	}
 
-	*outp = be64_to_cpup(val);
+	*outp = be64_to_cpup(val + index);
 	debug("%#llx (%lld)\n", (unsigned long long)*outp,
-              (unsigned long long)*outp);
+	      (unsigned long long)*outp);
 
 	return 0;
 }
 
+int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+{
+	return of_read_u64_index(np, propname, 0, outp);
+}
+
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
 {
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index a4dc9bde085..8311282abf6 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -344,6 +344,36 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 	return 0;
 }
 
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp)
+{
+	const fdt64_t *cell;
+	int len;
+
+	assert(ofnode_valid(node));
+
+	if (ofnode_is_np(node))
+		return of_read_u64_index(ofnode_to_np(node), propname, index,
+					 outp);
+
+	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+			   propname, &len);
+	if (!cell) {
+		debug("(not found)\n");
+		return -EINVAL;
+	}
+
+	if (len < (sizeof(u64) * (index + 1))) {
+		debug("(not large enough)\n");
+		return -EOVERFLOW;
+	}
+
+	*outp = fdt64_to_cpu(cell[index]);
+	debug("%#llx (%lld)\n", *outp, *outp);
+
+	return 0;
+}
+
 u32 ofnode_read_u32_index_default(ofnode node, const char *propname, int index,
 				  u32 def)
 {
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index c556a18f7d9..9361d0a87bf 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -333,6 +333,25 @@ int of_read_u32(const struct device_node *np, const char *propname, u32 *outp);
 int of_read_u32_index(const struct device_node *np, const char *propname,
 		      int index, u32 *outp);
 
+/**
+ * of_read_u64_index() - Find and read a 64-bit value from a multi-value
+ *                       property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @outp:	pointer to return value, modified only if return value is 0.
+ *
+ * Search for a property in a device node and read a 64-bit value from
+ * it.
+ *
+ * Return:
+ *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if the
+ *   property data isn't large enough.
+ */
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp);
+
 /**
  * of_read_u64() - Find and read a 64-bit integer from a property
  *
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0f38b3e736d..0a85db31f36 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -434,6 +434,18 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp);
 int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 			  u32 *outp);
 
+/**
+ * ofnode_read_u64_index() - Read a 64-bit integer from a multi-value property
+ *
+ * @node:	valid node reference to read property from
+ * @propname:	name of the property to read from
+ * @index:	index of the integer to return
+ * @outp:	place to put value (if found)
+ * Return: 0 if OK, -ve on error
+ */
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp);
+
 /**
  * ofnode_read_s32() - Read a 32-bit integer from a property
  *
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 6fbebc7da08..b74f5c2ebcf 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -967,6 +967,14 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 	ut_asserteq_64(0x1111222233334444, val);
 	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
 
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
+	ut_asserteq_64(0x1111222233334444, val);
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 1, &val));
+	ut_asserteq_64(0x4444333322221111, val);
+	ut_asserteq(-EOVERFLOW,
+		    ofnode_read_u64_index(node, "int64-array", 2, &val));
+	ut_asserteq(-EINVAL, ofnode_read_u64_index(node, "missing", 0, &val));
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

