Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DEEC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F768895D;
	Sat, 10 Aug 2024 22:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lPhs8GrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACADB88960; Sat, 10 Aug 2024 22:52:40 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C515E88709
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81f96eaa02aso150242239f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323151; x=1723927951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0njl8yqJX01Yq+s/niiQGUvL86siz333V5iJssWIWjI=;
 b=lPhs8GrB0jWezLbm2rtHncACYUSYOnREYd/FTQU+d9Kc/1xmRsLehQjmJ26CXmrVQb
 WqA9NqZkacwe+YQ1NLPffQzfuFj4pWwzvK/C8rpozrIXz3XkdPb1M4dMM4FMOdulkmyG
 GEnsDIsxbsFMaDH6om6x0MMmKEt/vFVwutY64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323151; x=1723927951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0njl8yqJX01Yq+s/niiQGUvL86siz333V5iJssWIWjI=;
 b=s9W6BKg5dGOqAD+b9iGpUhsDiXphSg/YXjY30pVwWPIOZ5eMmjnTjSvPbyROmFpFjI
 Z4ugUdQ3EBT6IWokXopZHx9gpXziNdCg0ojyI6KSc5RDU5SKeYa7cz/cGhWswIqPowIk
 Dy+9gSQEOsYS5P/4jF2bFryT8zfXFxb4RZAnS1RVR4L86wczD4UEKM8HDbSJfzbkoqdE
 ReB3QyNWhvMrNR+J0wZprkR6yu+06ZHx844r37Uw/hdZKD55Otgtpb6f9p+nLYVdhyfm
 mSk+1+4ONzA3blxseB7zVjySL0MVU9nQdzkqJmEvEYGWpgv0I/K9IvgLOsjpx1rxSOD4
 XPAQ==
X-Gm-Message-State: AOJu0YyhuEzxqgjfHg+NOf4oGAwqcJyWgaghoHhsT92a/4RYbvu96AUG
 gjiHKWG4sfD/6XgrtkhsFQwgZpQ7mhp5aA5Me7JlIuBXXjXsjA2cGvS+fF64YoSDk5lBRmegomw
 =
X-Google-Smtp-Source: AGHT+IHCdfQiOB6f3J8vUgf6Yn698f0XEyAabF7fpu9dwo+M37neNO362i7sqN0/S7SBg8wdaLHVNg==
X-Received: by 2002:a05:6602:2c82:b0:807:f0fb:11a2 with SMTP id
 ca18e2360f4ac-8225ee39362mr850167539f.13.1723323151317; 
 Sat, 10 Aug 2024 13:52:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 12/21] test: fdt: Check internal-function return values
Date: Sat, 10 Aug 2024 14:51:56 -0600
Message-Id: <20240810205205.3403177-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Some functions are using asserts but the result of the functions
themselves is not checked. This means that if a test fails, the result
is not noticed until later, which can be confusing to debug.

Add the missing asserts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/fdt.c | 153 +++++++++++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 63 deletions(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 721345f0288..35d9e84c3d1 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -459,11 +459,10 @@ static int fdt_test_get_value_string(struct unit_test_state *uts,
 	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("fdt get value var %s %s %s",
 				 node, prop, idx ? : ""));
-	if (strres) {
+	if (strres)
 		ut_asserteq_str(strres, env_get("var"));
-	} else {
+	else
 		ut_asserteq(intres, env_get_hex("var", 0x1234));
-	}
 	ut_assertok(ut_check_console_end(uts));
 
 	return 0;
@@ -473,16 +472,20 @@ static int fdt_test_get_value_common(struct unit_test_state *uts,
 				     const char *node)
 {
 	/* Test getting default element of $node node clock-names property */
-	fdt_test_get_value_string(uts, node, "clock-names", NULL, "fixed", 0);
+	ut_assertok(fdt_test_get_value_string(uts, node, "clock-names", NULL,
+					      "fixed", 0));
 
 	/* Test getting 0th element of $node node clock-names property */
-	fdt_test_get_value_string(uts, node, "clock-names", "0", "fixed", 0);
+	ut_assertok(fdt_test_get_value_string(uts, node, "clock-names", "0",
+					      "fixed", 0));
 
 	/* Test getting 1st element of $node node clock-names property */
-	fdt_test_get_value_string(uts, node, "clock-names", "1", "i2c", 0);
+	ut_assertok(fdt_test_get_value_string(uts, node, "clock-names", "1",
+					      "i2c", 0));
 
 	/* Test getting 2nd element of $node node clock-names property */
-	fdt_test_get_value_string(uts, node, "clock-names", "2", "spi", 0);
+	ut_assertok(fdt_test_get_value_string(uts, node, "clock-names", "2",
+					      "spi", 0));
 
 	/*
 	 * Test getting default element of $node node regs property.
@@ -491,13 +494,16 @@ static int fdt_test_get_value_common(struct unit_test_state *uts,
 	 * but only if the array is shorter than 40 characters. Anything
 	 * longer is an error. This is a special case for handling hashes.
 	 */
-	fdt_test_get_value_string(uts, node, "regs", NULL, "3412000000100000", 0);
+	ut_assertok(fdt_test_get_value_string(uts, node, "regs", NULL,
+					      "3412000000100000", 0));
 
 	/* Test getting 0th element of $node node regs property */
-	fdt_test_get_value_string(uts, node, "regs", "0", NULL, 0x1234);
+	ut_assertok(fdt_test_get_value_string(uts, node, "regs", "0", NULL,
+					      0x1234));
 
 	/* Test getting 1st element of $node node regs property */
-	fdt_test_get_value_string(uts, node, "regs", "1", NULL, 0x1000);
+	ut_assertok(fdt_test_get_value_string(uts, node, "regs", "1", NULL,
+					      0x1000));
 
 	/* Test missing 10th element of $node node clock-names property */
 	ut_assertok(console_record_reset_enable());
@@ -522,17 +528,13 @@ static int fdt_test_get_value(struct unit_test_state *uts)
 {
 	char fdt[4096];
 	ulong addr;
-	int ret;
 
 	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
 	addr = map_to_sysmem(fdt);
 	set_working_fdt_addr(addr);
 
-	ret = fdt_test_get_value_common(uts, "/test-node@1234");
-	if (!ret)
-		ret = fdt_test_get_value_common(uts, "testnodealias");
-	if (ret)
-		return ret;
+	ut_assertok(fdt_test_get_value_common(uts, "/test-node@1234"));
+	ut_assertok(fdt_test_get_value_common(uts, "testnodealias"));
 
 	/* Test getting default element of /nonexistent node */
 	ut_assertok(console_record_reset_enable());
@@ -668,23 +670,31 @@ static int fdt_test_get_addr(struct unit_test_state *uts)
 	set_working_fdt_addr(addr);
 
 	/* Test getting address of root node / string property "compatible" */
-	fdt_test_get_addr_common(uts, fdt, "/", "compatible");
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/", "compatible"));
 
 	/* Test getting address of node /test-node@1234 stringlist property "clock-names" */
-	fdt_test_get_addr_common(uts, fdt, "/test-node@1234", "clock-names");
-	fdt_test_get_addr_common(uts, fdt, "testnodealias", "clock-names");
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/test-node@1234",
+					     "clock-names"));
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "testnodealias",
+					     "clock-names"));
 
 	/* Test getting address of node /test-node@1234 u32 property "clock-frequency" */
-	fdt_test_get_addr_common(uts, fdt, "/test-node@1234", "clock-frequency");
-	fdt_test_get_addr_common(uts, fdt, "testnodealias", "clock-frequency");
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/test-node@1234",
+					     "clock-frequency"));
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "testnodealias",
+					     "clock-frequency"));
 
 	/* Test getting address of node /test-node@1234 empty property "u-boot,empty-property" */
-	fdt_test_get_addr_common(uts, fdt, "/test-node@1234", "u-boot,empty-property");
-	fdt_test_get_addr_common(uts, fdt, "testnodealias", "u-boot,empty-property");
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/test-node@1234",
+					     "u-boot,empty-property"));
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "testnodealias",
+					     "u-boot,empty-property"));
 
 	/* Test getting address of node /test-node@1234 array property "regs" */
-	fdt_test_get_addr_common(uts, fdt, "/test-node@1234", "regs");
-	fdt_test_get_addr_common(uts, fdt, "testnodealias", "regs");
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/test-node@1234",
+					     "regs"));
+	ut_assertok(fdt_test_get_addr_common(uts, fdt, "testnodealias",
+					     "regs"));
 
 	/* Test getting address of node /test-node@1234/subnode non-existent property "noprop" */
 	ut_assertok(console_record_reset_enable());
@@ -728,30 +738,38 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 	set_working_fdt_addr(addr);
 
 	/* Test getting size of root node / string property "compatible" */
-	fdt_test_get_size_common(uts, "/", "compatible", 16);
+	ut_assertok(fdt_test_get_size_common(uts, "/", "compatible", 16));
 
 	/* Test getting size of node /test-node@1234 stringlist property "clock-names" */
-	fdt_test_get_size_common(uts, "/test-node@1234", "clock-names", 26);
-	fdt_test_get_size_common(uts, "testnodealias", "clock-names", 26);
+	ut_assertok(fdt_test_get_size_common(uts, "/test-node@1234",
+					     "clock-names", 26));
+	ut_assertok(fdt_test_get_size_common(uts, "testnodealias",
+					     "clock-names", 26));
 
 	/* Test getting size of node /test-node@1234 u32 property "clock-frequency" */
-	fdt_test_get_size_common(uts, "/test-node@1234", "clock-frequency", 4);
-	fdt_test_get_size_common(uts, "testnodealias", "clock-frequency", 4);
+	ut_assertok(fdt_test_get_size_common(uts, "/test-node@1234",
+					     "clock-frequency", 4));
+	ut_assertok(fdt_test_get_size_common(uts, "testnodealias",
+					     "clock-frequency", 4));
 
 	/* Test getting size of node /test-node@1234 empty property "u-boot,empty-property" */
-	fdt_test_get_size_common(uts, "/test-node@1234", "u-boot,empty-property", 0);
-	fdt_test_get_size_common(uts, "testnodealias", "u-boot,empty-property", 0);
+	ut_assertok(fdt_test_get_size_common(uts, "/test-node@1234",
+					     "u-boot,empty-property", 0));
+	ut_assertok(fdt_test_get_size_common(uts, "testnodealias",
+					     "u-boot,empty-property", 0));
 
 	/* Test getting size of node /test-node@1234 array property "regs" */
-	fdt_test_get_size_common(uts, "/test-node@1234", "regs", 8);
-	fdt_test_get_size_common(uts, "testnodealias", "regs", 8);
+	ut_assertok(fdt_test_get_size_common(uts, "/test-node@1234", "regs",
+					     8));
+	ut_assertok(fdt_test_get_size_common(uts, "testnodealias", "regs", 8));
 
 	/* Test getting node count of node / */
-	fdt_test_get_size_common(uts, "/", NULL, 2);
+	ut_assertok(fdt_test_get_size_common(uts, "/", NULL, 2));
 
 	/* Test getting node count of node /test-node@1234/subnode */
-	fdt_test_get_size_common(uts, "/test-node@1234/subnode", NULL, 0);
-	fdt_test_get_size_common(uts, "subnodealias", NULL, 0);
+	ut_assertok(fdt_test_get_size_common(uts, "/test-node@1234/subnode",
+					     NULL, 0));
+	ut_assertok(fdt_test_get_size_common(uts, "subnodealias", NULL, 0));
 
 	/* Test getting size of node /test-node@1234/subnode non-existent property "noprop" */
 	ut_assertok(console_record_reset_enable());
@@ -873,14 +891,14 @@ static int fdt_test_set_multi(struct unit_test_state *uts,
 static int fdt_test_set_node(struct unit_test_state *uts,
 			     const char *path, const char *prop)
 {
-	fdt_test_set_single(uts, path, prop, "new", 0, false);
-	fdt_test_set_single(uts, path, prop, "rewrite", 0, false);
-	fdt_test_set_single(uts, path, prop, NULL, 42, true);
-	fdt_test_set_single(uts, path, prop, NULL, 0, false);
-	fdt_test_set_multi(uts, path, prop, NULL, NULL, 42, 1701);
-	fdt_test_set_multi(uts, path, prop, NULL, NULL, 74656, 9);
-	fdt_test_set_multi(uts, path, prop, "42", "1701", 0, 0);
-	fdt_test_set_multi(uts, path, prop, "74656", "9", 0, 0);
+	ut_assertok(fdt_test_set_single(uts, path, prop, "new", 0, false));
+	ut_assertok(fdt_test_set_single(uts, path, prop, "rewrite", 0, false));
+	ut_assertok(fdt_test_set_single(uts, path, prop, NULL, 42, true));
+	ut_assertok(fdt_test_set_single(uts, path, prop, NULL, 0, false));
+	ut_assertok(fdt_test_set_multi(uts, path, prop, NULL, NULL, 42, 1701));
+	ut_assertok(fdt_test_set_multi(uts, path, prop, NULL, NULL, 74656, 9));
+	ut_assertok(fdt_test_set_multi(uts, path, prop, "42", "1701", 0, 0));
+	ut_assertok(fdt_test_set_multi(uts, path, prop, "74656", "9", 0, 0));
 
 	return 0;
 }
@@ -896,18 +914,20 @@ static int fdt_test_set(struct unit_test_state *uts)
 	set_working_fdt_addr(addr);
 
 	/* Test setting of root node / existing property "compatible" */
-	fdt_test_set_node(uts, "/", "compatible");
+	ut_assertok(fdt_test_set_node(uts, "/", "compatible"));
 
 	/* Test setting of root node / new property "newproperty" */
-	fdt_test_set_node(uts, "/", "newproperty");
+	ut_assertok(fdt_test_set_node(uts, "/", "newproperty"));
 
 	/* Test setting of subnode existing property "compatible" */
-	fdt_test_set_node(uts, "/test-node@1234/subnode", "compatible");
-	fdt_test_set_node(uts, "subnodealias", "compatible");
+	ut_assertok(fdt_test_set_node(uts, "/test-node@1234/subnode",
+				      "compatible"));
+	ut_assertok(fdt_test_set_node(uts, "subnodealias", "compatible"));
 
 	/* Test setting of subnode new property "newproperty" */
-	fdt_test_set_node(uts, "/test-node@1234/subnode", "newproperty");
-	fdt_test_set_node(uts, "subnodealias", "newproperty");
+	ut_assertok(fdt_test_set_node(uts, "/test-node@1234/subnode",
+				      "newproperty"));
+	ut_assertok(fdt_test_set_node(uts, "subnodealias", "newproperty"));
 
 	/* Test setting property of non-existent node */
 	ut_assertok(console_record_reset_enable());
@@ -1160,16 +1180,23 @@ static int fdt_test_header(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Test header get */
-	fdt_test_header_get(uts, "magic", fdt_magic(fdt));
-	fdt_test_header_get(uts, "totalsize", fdt_totalsize(fdt));
-	fdt_test_header_get(uts, "off_dt_struct", fdt_off_dt_struct(fdt));
-	fdt_test_header_get(uts, "off_dt_strings", fdt_off_dt_strings(fdt));
-	fdt_test_header_get(uts, "off_mem_rsvmap", fdt_off_mem_rsvmap(fdt));
-	fdt_test_header_get(uts, "version", fdt_version(fdt));
-	fdt_test_header_get(uts, "last_comp_version", fdt_last_comp_version(fdt));
-	fdt_test_header_get(uts, "boot_cpuid_phys", fdt_boot_cpuid_phys(fdt));
-	fdt_test_header_get(uts, "size_dt_strings", fdt_size_dt_strings(fdt));
-	fdt_test_header_get(uts, "size_dt_struct", fdt_size_dt_struct(fdt));
+	ut_assertok(fdt_test_header_get(uts, "magic", fdt_magic(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "totalsize", fdt_totalsize(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "off_dt_struct",
+					fdt_off_dt_struct(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "off_dt_strings",
+					fdt_off_dt_strings(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "off_mem_rsvmap",
+					fdt_off_mem_rsvmap(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "version", fdt_version(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "last_comp_version",
+					fdt_last_comp_version(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "boot_cpuid_phys",
+					fdt_boot_cpuid_phys(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "size_dt_strings",
+					fdt_size_dt_strings(fdt)));
+	ut_assertok(fdt_test_header_get(uts, "size_dt_struct",
+					fdt_size_dt_struct(fdt)));
 
 	return 0;
 }
@@ -1244,8 +1271,8 @@ static int fdt_test_memory(struct unit_test_state *uts)
 	 * so far unsupported and fails because of simple_stroull() being
 	 * 64bit tops in the 'fdt memory' command implementation.
 	 */
-	fdt_test_memory_cells(uts, 1);
-	fdt_test_memory_cells(uts, 2);
+	ut_assertok(fdt_test_memory_cells(uts, 1));
+	ut_assertok(fdt_test_memory_cells(uts, 2));
 
 	/*
 	 * The 'fdt memory' command is limited to /memory node, it does
-- 
2.34.1

