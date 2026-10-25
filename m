Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EE606A322
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bHvoLo9Z;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=lUM8arMm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8048B80D64;
	Sun, 25 Oct 2026 20:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GPDDspuxmFBs; Sun, 25 Oct 2026 20:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D90D80D5B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792959546;
	b=mps521W72ZU/KiHAn75zxGXuH85DkuDkYpslyp1chuoCKVI/4wwlIkK+Cs7oQZdRtvAw
	 CBIUYlF2cPLv3vVxMupzfy74mVy8Ar8kTxEFLbOlNUW/tICRQcCTunDcA3EcnjT6xe47t
	 j0psYWEV42/lH9kJ+wMHIjC+Fmaw503nPxgTanRn9ZUxxptiywDYNSYISTjZeRzJ277NF
	 ZkAFLpTPexYPc4eSvFOYdGxHYYUhiOOESx+hRWhPPytV1xveMkUl6/b7GYe7e4xpuFokZ
	 QsKK7/8gBlWMKuMnNbvSZpSSxrtKCNnAYrngA4kOm0RxCn8dPuTRKKIU8zCTksCIGjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792959546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wbz6isT/TDT/vAx1KjF+JUxSfNfzdWmQYYtCmsCl1ro=;
	b=eAGP56ebRAvjS4J12NAtEgQEjQW7Ge0Irkznbt3HCz7LSKPBkulGE/hpiQ+Hs9Fn8XXa
	 5nWL49qItUZMIoyMDUrNVfnqbahsR0uvBJsoxn5DgJSvEexGwsLWnccIK4D5oSx97lT39
	 RgQysVp77oc9IgXgLhKn+NhP3I/g4dyZ1jNlVGAAyjQ2mL0SYwlhd29ypWVgW/AocsmoJ
	 O6/+aET55HTUhFglXicJzvnTVeLcO4ZRvJaasjzZh1j1Upws92eniyoaySoTDSKiDoJDJ
	 Y/dNsAvyUang9Ub44EmLxsVWN431j8c0Qjnc+cspi9hcO5YmLdDSZvHovxwbxBPUBOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792959546;
	bh=Wbz6isT/TDT/vAx1KjF+JUxSfNfzdWmQYYtCmsCl1ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHvoLo9Z/GP7l3WuC4Cut+y5tE7XzKigrpWZE9L+Qh9ewlYa9PSYEKbfDVTYNCfUq
	 EcGIV4AeCl3HdqUecu/EPVn7hAR1smrg+7ofP6WXA5YHNV38b8gJuBclu5I/7gjO0M
	 eyemkNIjj4MnFgnkXM+nrT4PuBUE6AI1ZEPna7l2AlvtF3rXoVrmFjIFNIpnK/PjJB
	 ETiSqicVV/742i5yN22mS9D7k+3UH0WRRaxL2OayvqFYdl1gS0NE0Vy39kUP4Cm6PH
	 +jkI3zcoAYQ8XPUjdHwBLnqR4dCFiR9gJnfS/78OhmRuRybPdqLC6Zpy2hc4r3BoH9
	 o1dH4x87MTKjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D90D80D5B;
	Sun, 25 Oct 2026 20:19:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B02984D1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9603F40593
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cq-XOEtg1g4P for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 20:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40D0140591
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792959541;
 b=UCXPTAoJXbUb8jVPij5aQWOA8ODAb5sykwu3cE4FAwhHaIs/FiuSMlDxepg1NcUjaiQu
 ERprVRzGIgpSoWEfM4OqvDWCITv4JaqpoRV9mG27e+VgWhQts5qqnXbzbV3up+iqOd3xk
 CBVslaZzNcGlROxqcvaOoXLLLp7GSXg/R7vVo1/zcXHonFfyohIMWxnTpSvA13h6goWyn
 Vv0MtsOi4g0QbD1PseaK/el2DxzucO3kv4RvTOCcdmav8OdtChX9K9EDLkYtxbwaZwO1T
 DtQmpXpgMFKQQzNb+whmdm1JoAS2BTwJ5MqHYaNIn+Za6I1NkV1v3YNHA+xpRiMvkzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792959541;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Wbz6isT/TDT/vAx1KjF+JUxSfNfzdWmQYYtCmsCl1ro=;
 b=iiEUTJnhbDiBAX6RKlUCKA1WItqnJYi0uq/xlakxh/30qlrHDpjxSdGcsZRseCUMWV1V
 hi/zW1N6i+ZDv3s8XeMs+oj0NYne+XG+PAxSPRhSh6Smlr9rTik1fOxSdB6pliazURxoH
 OQvcn9fF9CklPrvUUCK5lHPgKTvdZ0k1UzT/urAPo7QfFof/zzBR/Gv+TX2/ZeDC/TOph
 0+tQKw38y2IdefYIND3Pe9chDeBIIxtqa2GXluyiM5aI/LVRR9Iig+EuGzKcb9VuEgsmk
 Nuca9kY4J7z0vNRoJAOUYzy9mjuQrDgENP6pSFzPZ4tRGbZ7RWrFX52qH2ZPmNyEjhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=lUM8arMm; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=lUM8arMm
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40D0140591
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:00 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E34842A98; 
 Sun, 25 Oct 2026 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792959539;
 bh=Wbz6isT/TDT/vAx1KjF+JUxSfNfzdWmQYYtCmsCl1ro=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lUM8arMmFJeisMczruLEwE8TDnYn+TZIz2hx8fcZMopZWErjBDIAPLEqTW4AhH17X
 hXxyhAcupq89nTlFlduz3FJKjQRE26N/0MCrQnTu0lQfmhc1r5LkRc2IyTNa0HMGvo
 arniHoQ5teWw9ND9jKm8PQWo3slO/n4A4KxT1crApokn9T0umo46vHk2IFCDcvErNp
 FadJFboms71+TkokKsyVk0lzkYa0LQSZ4/O7eujHBrosm8IOHODdeDyY2GbKJhrRZi
 H8H/Xk8xFi/2ZTvkEohNuDVLHnRXQE5n30GuoFZlgDninPBClBoPh/5kCe95NcKxVK
 iJRcvyRcRq2U3BevsHJ+bVuyCcF/LvBMNcTmdfCV437u7QQngFevS0UBoAP1LuLwYd
 09HWIfX4gLlJUXAwesXW7y4LlH1xnSrtWVi3Gg8bX+ypz6mA6dQ22XHqcXRb9lCURI
 /gXhVsFYd5zxyLBVhN2frKs1yNDo/fN7TvzmgX+KJTWER2hSIr4Ojh12irKdCYNAFT
 /w8ZTvPj5xYmw4afTJ9sREft8xEh0Ff7DJgnLkufeJsntuBdwKPgctwrqXT9WA95N/
 qsushp0aLRcDruNC5Bv/ZhO5oJgWHz+5UG/9DBwVT6VmRzpPxyZVwVH8aI0huYr8Uv
 /hUeL4I/ERGaKjOphnWorj5A=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] efi_selftest: factor out a module with fdt helper
 functions
Date: Sun, 25 Oct 2026 21:18:44 +0100
Message-ID: <20261025201845.328650-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025201845.328650-1-heinrich.schuchardt@canonical.com>
References: <20261025201845.328650-1-heinrich.schuchardt@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* efi_st_f2h() - convert FDT value to host endianness
* efi_st_fdt_find_node() - find a device-tree node
* efi_st_fdt_get_property() - return location and length of an FDT property
* efi_st_fdt_get_string() - return string value of a property of an FDT
  node

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_selftest.h                 |  50 ++++++
 lib/efi_selftest/Makefile              |   2 +-
 lib/efi_selftest/efi_selftest_fdt.c    | 138 ++--------------
 lib/efi_selftest/efi_selftest_fdtlib.c | 214 +++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 124 deletions(-)
 create mode 100644 lib/efi_selftest/efi_selftest_fdtlib.c

diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 874f8b5efe7..7e84081b029 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -141,6 +141,56 @@ int efi_st_strcmp_16_8(const u16 *buf1, const unsigned char *buf2);
  */
 void *efi_st_get_config_table(const efi_guid_t *guid);
 
+/**
+ * efi_st_f2h() - convert FDT value to host endianness.
+ *
+ * UEFI code is always low endian. The FDT is big endian.
+ *
+ * @val:	FDT value
+ * Return:	converted value
+ */
+uint32_t efi_st_f2h(fdt32_t val);
+
+/**
+ * efi_st_fdt_find_node() - find a device-tree node
+ *
+ * The root node or one of its direct children can be retrieved.
+ *
+ * @fdt:	flat device-tree
+ * @node:	name of the node or NULL for the root node
+ * Return:	pointer to the first byte of the node, or NULL
+ */
+const void *efi_st_fdt_find_node(const void *fdt, const u16 *node);
+
+/**
+ * efi_st_fdt_get_property() - return location of an FDT property
+ *
+ * A property of the root node or one of its direct children can be retrieved.
+ *
+ * @fdt:	flat device-tree
+ * @property:	name of the property
+ * @node:	name of the node or NULL for root node
+ * @len:	length of the property
+ * Return:	location of the property value, or NULL
+ */
+const void *efi_st_fdt_get_property(const void *fdt, const u16 *property,
+				    const u16 *node, u32 *len);
+
+/**
+ * efi_st_fdt_get_string() - return string value of a property of an FDT node
+ *
+ * A string property of the root node or one of its direct children can be
+ * retrieved. The caller is responsible for calling FreePool() for the returned
+ * buffer.
+ *
+ * @fdt:	flat device-tree
+ * @property:	name of the property
+ * @node:	name of the node or NULL for root node
+ * Return:	allocated copy of the property string, or NULL
+ */
+char *efi_st_fdt_get_string(const void *fdt, const u16 *property,
+			    const u16 *node);
+
 /**
  * efi_st_get_key() - reads an Unicode character from the input device
  *
diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 9882d9f2748..401e9e01281 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_EFI_GET_TIME) += efi_selftest_rtc.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
 
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
-obj-y += efi_selftest_fdt.o
+obj-y += efi_selftest_fdt.o efi_selftest_fdtlib.o
 endif
 
 ifeq ($(CONFIG_BLK)$(CONFIG_DOS_PARTITION),yy)
diff --git a/lib/efi_selftest/efi_selftest_fdt.c b/lib/efi_selftest/efi_selftest_fdt.c
index a4b0cef20e4..f73716a0513 100644
--- a/lib/efi_selftest/efi_selftest_fdt.c
+++ b/lib/efi_selftest/efi_selftest_fdt.c
@@ -25,123 +25,20 @@ static const efi_guid_t riscv_efi_boot_protocol_guid =
 				RISCV_EFI_BOOT_PROTOCOL_GUID;
 
 /**
- * f2h() - convert FDT value to host endianness.
+ * get_boot_hartid_fdt() - return boot-hartid property of the chosen node
  *
- * UEFI code is always low endian. The FDT is big endian.
- *
- * @val:	FDT value
- * Return:	converted value
- */
-static uint32_t f2h(fdt32_t val)
-{
-	char *buf = (char *)&val;
-	char i;
-
-	/* Swap the bytes */
-	i = buf[0]; buf[0] = buf[3]; buf[3] = i;
-	i = buf[1]; buf[1] = buf[2]; buf[2] = i;
-
-	return val;
-}
-
-/**
- * get_property() - return value of a property of an FDT node
- *
- * A property of the root node or one of its direct children can be
- * retrieved.
- *
- * @property	name of the property
- * @node	name of the node or NULL for root node
- * Return:	value of the property
+ * Return:	location of the boot-hartid property, or NULL
  */
-static char *get_property(const u16 *property, const u16 *node)
+static const fdt32_t *get_boot_hartid_fdt(void)
 {
-	struct fdt_header *header = (struct fdt_header *)fdt;
-	const fdt32_t *end;
-	const fdt32_t *pos;
-	const char *strings;
-	size_t level = 0;
-	const char *nodelabel = NULL;
-
-	if (!header) {
-		efi_st_error("Missing device tree\n");
-		return NULL;
-	}
+	const fdt32_t *prop;
+	u32 len;
 
-	if (f2h(header->magic) != FDT_MAGIC) {
-		efi_st_error("Wrong device tree magic\n");
+	prop = efi_st_fdt_get_property(fdt, u"boot-hartid", u"chosen", &len);
+	if (!prop || len != sizeof(*prop))
 		return NULL;
-	}
-
-	pos = (fdt32_t *)(fdt + f2h(header->off_dt_struct));
-	end = &pos[f2h(header->totalsize) >> 2];
-	strings = fdt + f2h(header->off_dt_strings);
 
-	for (; pos < end;) {
-		switch (f2h(pos[0])) {
-		case FDT_BEGIN_NODE: {
-			const char *c = (char *)&pos[1];
-			size_t i;
-
-			if (level == 1)
-				nodelabel = c;
-			++level;
-			for (i = 0; c[i]; ++i)
-				;
-			pos = &pos[2 + (i >> 2)];
-			break;
-		}
-		case FDT_PROP: {
-			struct fdt_property *prop = (struct fdt_property *)pos;
-			const char *label = &strings[f2h(prop->nameoff)];
-			efi_status_t ret;
-
-			/* Check if this is the property to be returned */
-			if (!efi_st_strcmp_16_8(property, label) &&
-			    ((level == 1 && !node) ||
-			     (level == 2 && node &&
-			      !efi_st_strcmp_16_8(node, nodelabel)))) {
-				char *str;
-				efi_uintn_t len = f2h(prop->len);
-
-				if (!len)
-					return NULL;
-				/*
-				 * The string might not be 0 terminated.
-				 * It is safer to make a copy.
-				 */
-				ret = boottime->allocate_pool(
-					EFI_LOADER_DATA, len + 1,
-					(void **)&str);
-				if (ret != EFI_SUCCESS) {
-					efi_st_error("AllocatePool failed\n");
-					return NULL;
-				}
-				boottime->copy_mem(str, &pos[3], len);
-				str[len] = 0;
-
-				return str;
-			}
-
-			pos = &pos[3 + ((f2h(prop->len) + 3) >> 2)];
-			break;
-		}
-		case FDT_NOP:
-			++pos;
-			break;
-		case FDT_END_NODE:
-			--level;
-			++pos;
-			break;
-		case FDT_END:
-			return NULL;
-		default:
-			efi_st_error("Invalid device tree token\n");
-			return NULL;
-		}
-	}
-	efi_st_error("Missing FDT_END token\n");
-	return NULL;
+	return prop;
 }
 
 /*
@@ -206,7 +103,7 @@ static int execute(void)
 	char *str;
 	efi_status_t ret;
 
-	str = get_property(u"compatible", NULL);
+	str = efi_st_fdt_get_string(fdt, u"compatible", NULL);
 	if (str) {
 		efi_st_printf("compatible: %s\n", str);
 		ret = boottime->free_pool(str);
@@ -218,7 +115,7 @@ static int execute(void)
 		efi_st_error("Missing property 'compatible'\n");
 		return EFI_ST_FAILURE;
 	}
-	str = get_property(u"serial-number", NULL);
+	str = efi_st_fdt_get_string(fdt, u"serial-number", NULL);
 	if (str) {
 		efi_st_printf("serial-number: %s\n", str);
 		ret = boottime->free_pool(str);
@@ -228,29 +125,24 @@ static int execute(void)
 		}
 	}
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
-		str = get_property(u"kaslr-seed", u"chosen");
+		str = efi_st_fdt_get_string(fdt, u"kaslr-seed", u"chosen");
 		if (str) {
 			efi_st_error("kaslr-seed with measured fdt\n");
 			return EFI_ST_FAILURE;
 		}
 	}
 	if (IS_ENABLED(CONFIG_RISCV)) {
+		const fdt32_t *prop;
 		u32 fdt_hartid;
 
-		str = get_property(u"boot-hartid", u"chosen");
-		if (!str) {
+		prop = get_boot_hartid_fdt();
+		if (!prop) {
 			efi_st_error("boot-hartid missing in devicetree\n");
 			return EFI_ST_FAILURE;
 		}
-		fdt_hartid = f2h(*(fdt32_t *)str);
+		fdt_hartid = efi_st_f2h(*prop);
 		efi_st_printf("boot-hartid: %u\n", fdt_hartid);
 
-		ret = boottime->free_pool(str);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("FreePool failed\n");
-			return EFI_ST_FAILURE;
-		}
-
 		if (IS_ENABLED(CONFIG_EFI_RISCV_BOOT_PROTOCOL)) {
 			efi_uintn_t efi_hartid;
 			int r;
diff --git a/lib/efi_selftest/efi_selftest_fdtlib.c b/lib/efi_selftest/efi_selftest_fdtlib.c
new file mode 100644
index 00000000000..2d681eb7904
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_fdtlib.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_fdtlib
+ *
+ * Copyright (c) 2026 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <efi_selftest.h>
+#include <linux/libfdt.h>
+
+/**
+ * efi_st_f2h() - convert FDT value to host endianness.
+ *
+ * UEFI code is always low endian. The FDT is big endian.
+ *
+ * @val:	FDT value
+ * Return:	converted value
+ */
+uint32_t efi_st_f2h(fdt32_t val)
+{
+	char *buf = (char *)&val;
+	char i;
+
+	/* Swap the bytes */
+	i = buf[0]; buf[0] = buf[3]; buf[3] = i;
+	i = buf[1]; buf[1] = buf[2]; buf[2] = i;
+
+	return val;
+}
+
+/**
+ * next_fdt_node() - skip the name of an FDT node
+ *
+ * @pos:	position of an FDT_BEGIN_NODE token
+ * Return:	position of the next token after the FDT node name
+ */
+static const fdt32_t *next_fdt_node(const fdt32_t *pos)
+{
+	const char *c = (char *)&pos[1];
+	size_t i;
+
+	for (i = 0; c[i]; ++i)
+		;
+
+	return &pos[2 + (i >> 2)];
+}
+
+/**
+ * efi_st_fdt_find_node() - find a device-tree node
+ *
+ * The root node or one of its direct children can be retrieved.
+ *
+ * @fdt:	flat device-tree
+ * @node:	name of the node or NULL for the root node
+ * Return:	pointer to the first byte of the node, or NULL
+ */
+const void *efi_st_fdt_find_node(const void *fdt, const u16 *node)
+{
+	const char *fdt_pos = fdt;
+	const struct fdt_header *header = (struct fdt_header *)fdt;
+	const fdt32_t *end;
+	const fdt32_t *pos;
+	size_t level = 0;
+
+	if (!header) {
+		efi_st_error("Missing device tree\n");
+		return NULL;
+	}
+
+	if (efi_st_f2h(header->magic) != FDT_MAGIC) {
+		efi_st_error("Wrong device tree magic\n");
+		return NULL;
+	}
+
+	pos = (fdt32_t *)(fdt_pos + efi_st_f2h(header->off_dt_struct));
+	end = (fdt32_t *)(fdt_pos + efi_st_f2h(header->totalsize));
+
+	for (; pos < end;) {
+		switch (efi_st_f2h(pos[0])) {
+		case FDT_BEGIN_NODE: {
+			const char *c = (char *)&pos[1];
+			const fdt32_t *next = next_fdt_node(pos);
+
+			if ((!node && !level) ||
+			    (node && level == 1 &&
+			     !efi_st_strcmp_16_8(node, c)))
+				return pos;
+
+			++level;
+			pos = next;
+			break;
+		}
+		case FDT_PROP: {
+			struct fdt_property *prop = (struct fdt_property *)pos;
+
+			pos = &pos[3 + ((efi_st_f2h(prop->len) + 3) >> 2)];
+			break;
+		}
+		case FDT_NOP:
+			++pos;
+			break;
+		case FDT_END_NODE:
+			--level;
+			++pos;
+			break;
+		case FDT_END:
+			return NULL;
+		default:
+			efi_st_error("Invalid device tree token\n");
+			return NULL;
+		}
+	}
+	efi_st_error("Missing FDT_END token\n");
+	return NULL;
+}
+
+/**
+ * efi_st_fdt_get_property() - return location of an FDT property
+ *
+ * A property of the root node or one of its direct children can be retrieved.
+ *
+ * @fdt:	flat device-tree
+ * @property:	name of the property
+ * @node:	name of the node or NULL for root node
+ * @len:	length of the property
+ * Return:	location of the property value, or NULL
+ */
+const void *efi_st_fdt_get_property(const void *fdt, const u16 *property,
+				    const u16 *node, u32 *len)
+{
+	const char *fdt_pos = fdt;
+	struct fdt_header *header = (struct fdt_header *)fdt;
+	const fdt32_t *end;
+	const fdt32_t *pos;
+	const char *strings;
+
+	pos = efi_st_fdt_find_node(fdt, node);
+	if (!pos)
+		return NULL;
+
+	pos = next_fdt_node(pos);
+	end = (fdt32_t *)(fdt_pos + efi_st_f2h(header->totalsize));
+	strings = fdt_pos + efi_st_f2h(header->off_dt_strings);
+
+	for (; pos < end;) {
+		switch (efi_st_f2h(pos[0])) {
+		case FDT_PROP: {
+			struct fdt_property *prop = (struct fdt_property *)pos;
+			const char *label = &strings[efi_st_f2h(prop->nameoff)];
+
+			if (!efi_st_strcmp_16_8(property, label)) {
+				if (len)
+					*len = efi_st_f2h(prop->len);
+				return &pos[3];
+			}
+
+			pos = &pos[3 + ((efi_st_f2h(prop->len) + 3) >> 2)];
+			break;
+		}
+		case FDT_NOP:
+			++pos;
+			break;
+		case FDT_BEGIN_NODE:
+		case FDT_END_NODE:
+		case FDT_END:
+			return NULL;
+		default:
+			efi_st_error("Invalid device tree token\n");
+			return NULL;
+		}
+	}
+	efi_st_error("Missing FDT_END token\n");
+	return NULL;
+}
+
+/**
+ * efi_st_fdt_get_string() - return string value of a property of an FDT node
+ *
+ * A string property of the root node or one of its direct children can be
+ * retrieved. The caller is responsible for calling free() for the returned
+ * buffer.
+ *
+ * @fdt:	flat device-tree
+ * @property:	name of the property
+ * @node:	name of the node or NULL for root node
+ * Return:	allocated copy of the property string, or NULL
+ */
+char *efi_st_fdt_get_string(const void *fdt, const u16 *property,
+			    const u16 *node)
+{
+	const char *prop;
+	efi_status_t ret;
+	char *str;
+	u32 len;
+
+	prop = efi_st_fdt_get_property(fdt, property, node, &len);
+	if (!prop || !len)
+		return NULL;
+
+	/*
+	 * The string might not be 0 terminated.
+	 * It is safer to make a copy.
+	 */
+	ret = st_boottime->allocate_pool(EFI_LOADER_DATA, len + 1,
+					       (void **)&str);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("AllocatePool failed\n");
+		return NULL;
+	}
+	st_boottime->copy_mem(str, prop, len);
+	str[len] = 0;
+
+	return str;
+}
-- 
2.53.0

