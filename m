Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD7606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k+y1B2U8;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=KRdYNDwa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D468780D84;
	Sun, 25 Oct 2026 20:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VB8p30wQBfIZ; Sun, 25 Oct 2026 20:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11BAA80D7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792959549;
	b=lhEKNOQg2GCMWzOM/6hbmXvZZkMnJfKKoEuNXnnIVtnY6+5G+CKsGzts6j8Lsk2QrZzg
	 KFpWrlerJM1FPbgtc8LzthNNiqoDV6UPBAFzcMy+87jMIdfurhavNlU2nQbbcJDEfHmXl
	 whMRoLkjoCjU/NoG/rB2Pca+i0vpCuRWxAO5F9Q5S7B9iBAo0Ro75dZICcIdIBnyrbFiD
	 E33l+gJqgtTfpCUb1Gpl8SYKFqtLBldfv7J7BcfZXY+DZKfPEXno2tMDD5BPRXTdO8DiE
	 4foB+wCmrySYOqHGQZ49cAw49mpJTFRfymmLW4wAIpOZdF/rdIQr+ttnGV2mzIa033A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792959549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yEMkhF7nUEiWIIpfeFiyV1E5NK6IfGizRJdEgglvwSU=;
	b=WHkQhEgwpWZWCrRiafLHLonMUut4DBTs9QP+wdagqIigrx6xGwsVYmiJEX7j42ypkV4a
	 XYLRGMuG0EfqzLfDnBQeaFBht/4SpCpuGlCOeeGOHi77J2kPziKdLXWz5sni8iUIhYUmb
	 a2CU8hyZBfXoRRckm3nPcvPmB25WuoDVDhDu85tK32XM2T5ezmN1twu5qwg6g0ArCtSAn
	 rMEtzsQYyG9ZYb5htQEzkzDbJax1mK9/tH/NpqHnYEPmhevFU3zmPMIR7MeKA2ITLiLTN
	 /qUkprZrUvAmWc9xY2MUuTfE1TWG+qCfS0tGF9DnetSv1wjvnobbsAMQhxzjJ4F4kpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792959549;
	bh=yEMkhF7nUEiWIIpfeFiyV1E5NK6IfGizRJdEgglvwSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+y1B2U8zaNnUhNKPA5ifDrf39M90s2lI9JS76GgKnjiz+sHShBiGItmGClSyGVVY
	 1mk4zJU0CwGA2vE1fOyx30HleYvtaOsC/o2THzuvWCF8ft/xf3dZTixfS0WUOYZI5p
	 kSweokIYd6wt9Sci3k+Ztf75EVxpRnAYtz57zUWOso8G/TxXyaGvtfCvh8Cspk+Jjh
	 NjwtGZExZkKpGqG2PZVXFEHHIW1DZ5VMXf/DYVhCmHwpF+2ZXit6RhaDQYqPUuuS3W
	 SutbD3z7C3DJ3m+0nFkrsKG0prDG4sCkWHwgKXsDGYc+YfMqcPlE3NrrfQeFEQsrbW
	 kJbkxMW06nvTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11BAA80D7C;
	Sun, 25 Oct 2026 20:19:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A8DC235
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C43D40593
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjKO6Qtue60q for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 20:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A8A440591
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792959543;
 b=HcrZ/qSrT2jakVC3scMwJu/qpsq9EFFTJ9pKAVpwPbjCGJSsgE71JqVDEFPeXX85NIv6
 q4EQhKivo12tFOfdAwBiyfw7gVdDqWq1WodFksimZpRUqVvZCnHN41SOXlNtIQ4RuSsdC
 b173Zm+HHgbiVgCyW/UqCl7MTf2M0gMe09QtbLrGPvJiGzlwEgkNDHkujfuXeNlPhDxtQ
 yls49lB83OoHPIvhYArFRchdLE8UtTizJzbi66yTH8HVlZaqlD/X3xIjwxar8jGwIiqDf
 RCCUQWiUTkOubMsXFvCWyqfduAsMKrgRty/m+67Ihw+FGJiBzS6+1J2TuPXwFflUSPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792959543;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yEMkhF7nUEiWIIpfeFiyV1E5NK6IfGizRJdEgglvwSU=;
 b=mtvEPq3nDW1WHBaQfIBv6A8ZCXgrFceAumIAF1BcSWDI4Six0mEZ2XsEXkxi5eYFWBQD
 XYa1/iJz06LdgOi5BuqoAJBTWqH3dUo4y4DXlH3XxZOLtlqFdYXo7QCSyNhBReXZaSK41
 1/tKHgsVg0Z5NtGKHUqiR5/fpNCgL05fHDHKHCtkotOLnx8uk78qAQD31b32XqBleyqKw
 ARVmum8l0zJEDiFS5LZXvOWuzvR4bUFnYaG73IxuYQl0dHyreldvRv6N0p/WBybCakEQR
 8J9lrZQrs4ZTtPJjQbnp64+wU5miK6m7O3dADa1XTS6eJjQ3ny/6/B4CxylQZpV8Ceg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=KRdYNDwa; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=KRdYNDwa
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A8A440591
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:19:02 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E028B41633; 
 Sun, 25 Oct 2026 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792959541;
 bh=yEMkhF7nUEiWIIpfeFiyV1E5NK6IfGizRJdEgglvwSU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KRdYNDwaqwcYocnCP2hIei0MJmCunsphX8ac2gT0SqxyO0fnxMBtBDz4R3qLZbyun
 xDutnsg4wpEInJQZFsSkL3AWR8ASjNBn7BU1nbEJpgdkPYSShjwdUtsD1IjW746qLv
 ctJpbmA4kT4hAbPnkz7T9ra0fW1O6vrotRVTdSfwOJq6eim0rO/DXcOxz7yXwIBKne
 A9M5QtcQp1/Z0TCYEBMNLo5Qa2vD2ySMYHBTFLSuTnTSstJHp8qEosl9wUz6LsLS5M
 E1wzYErjK2Ufq1oOTOeNGMnp0ZeRlzrMG1W91XpeIGVQyId5qLm29utfRUwetlBkPw
 6NDVLeQNbc9aLrD4PUHgVb5iNonIS7DeofI9wney9dv8yM0sKrR8dnkvY71Vvi0AgJ
 UkbhqCZ8rmiFMmQ//Iap6sFLEtWWWI2zNUO3sHhcnHm20Jy0aeecOjYne8G07mzyl+
 DLq7FfoOkoERcXk+T+siF/bytppVTmjydzgZDEd+vOUDz+R/BZRNqDnCfB4KzYecOz
 SIL6yQZQsJbHhuVplMMoOsyJZHwvgpIYx1tMyuOK/bgn8rTKh+o4WEExbztL8VNrNr
 xE/Z9tRD3DeHw2lZtaN7osf98Z/Wjy56IHMk41n8lt1V+GQetNqKOhDn9/bUneQUCW
 TQfApBAx3oghCDoMp+Gg4fB4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] efi_selftest: test for EFI_DT_FIXUP_PROTOCOL
Date: Sun, 25 Oct 2026 21:18:45 +0100
Message-ID: <20261025201845.328650-4-heinrich.schuchardt@canonical.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the test the /chosen/u-boot,version property is in manipulated.
The fixup protocol should reset it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/Makefile                |   1 +
 lib/efi_selftest/efi_selftest_dt_fixup.c | 201 +++++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_dt_fixup.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 401e9e01281..2fc7fffc423 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
 
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 obj-y += efi_selftest_fdt.o efi_selftest_fdtlib.o
+obj-$(CONFIG_EFI_DT_FIXUP) += efi_selftest_dt_fixup.o
 endif
 
 ifeq ($(CONFIG_BLK)$(CONFIG_DOS_PARTITION),yy)
diff --git a/lib/efi_selftest/efi_selftest_dt_fixup.c b/lib/efi_selftest/efi_selftest_dt_fixup.c
new file mode 100644
index 00000000000..190f09a39ce
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_dt_fixup.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_dt_fixup
+ *
+ * Copyright (c) 2026 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * Test the EFI_DT_FIXUP_PROTOCOL.
+ * In the test the /chosen/u-boot,version property is in manipulated.
+ * The fixup protocol should reset it.
+ */
+
+#include <efi_dt_fixup.h>
+#include <efi_selftest.h>
+#include <linux/libfdt.h>
+
+static const struct efi_boot_services *boottime;
+static const void *fdt;
+static char *u_boot_version;
+
+static const efi_guid_t fdt_guid = EFI_FDT_GUID;
+static const efi_guid_t dt_fixup_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
+static const efi_guid_t dt_fixup2_guid = EFI_DT_FIXUP_PROTOCOL2_GUID;
+
+/**
+ * get_dtb_size() - get size of the device-tree
+ *
+ * @dtb:	device-tree
+ * Return:	size of the device-tree
+ */
+static efi_uintn_t get_dtb_size(const void *dtb)
+{
+	const struct fdt_header *header = dtb;
+
+	return efi_st_f2h(header->totalsize);
+}
+
+/**
+ * test_dt_fixup() - test a device-tree fix-up protocol
+ *
+ * @guid:	GUID of the protocol
+ * @current_proto:	true for current EFI_DT_FIXUP_PROTOCOL
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int test_dt_fixup(const efi_guid_t *guid, const int current_proto)
+{
+	void *interface;
+	const char *version;
+	efi_physical_addr_t addr = 0;
+	efi_status_t ret;
+	efi_uintn_t buffer_size = 0;
+	efi_uintn_t dtb_size = get_dtb_size(fdt);
+	efi_uintn_t pages;
+	void *dtb;
+	u32 len;
+	struct efi_dt_fixup_protocol *dt_fixup;
+	struct efi_dt_fixup_protocol2 *dt_fixup2;
+
+	ret = boottime->locate_protocol(guid, NULL, &interface);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Device-tree fix-up protocol not available\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (current_proto) {
+		dt_fixup2 = interface;
+		ret = dt_fixup2->fixup(dt_fixup2, (void *)fdt, &buffer_size);
+	} else {
+		dt_fixup = interface;
+		ret = dt_fixup->fixup(dt_fixup, (void *)fdt, &buffer_size,
+				      EFI_DT_APPLY_FIXUPS);
+	}
+	if (ret != EFI_BUFFER_TOO_SMALL) {
+		efi_st_error("Fixup did not return EFI_BUFFER_TOO_SMALL\n");
+		return EFI_ST_FAILURE;
+	}
+	if (buffer_size < dtb_size) {
+		efi_st_error("Fixup returned too small buffer size\n");
+		return EFI_ST_FAILURE;
+	}
+
+	pages = efi_size_in_pages(buffer_size);
+	ret = boottime->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DATA,
+				       pages, &addr);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("AllocatePages failed\n");
+		return EFI_ST_FAILURE;
+	}
+	dtb = (void *)(uintptr_t)addr;
+	boottime->copy_mem(dtb, fdt, dtb_size);
+
+	version = efi_st_fdt_get_property(dtb, u"u-boot,version", u"chosen", &len);
+	if (!version || !len) {
+		efi_st_error("Missing property 'u-boot,version'\n");
+		return EFI_ST_FAILURE;
+	}
+	*(char *)version = 0;
+
+	if (current_proto)
+		ret = dt_fixup2->fixup(dt_fixup2, dtb, &buffer_size);
+	else
+		ret = dt_fixup->fixup(dt_fixup, dtb, &buffer_size,
+				       EFI_DT_APPLY_FIXUPS);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Fixup failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	version = efi_st_fdt_get_property(dtb, u"u-boot,version", u"chosen", &len);
+	if (!version || !len) {
+		efi_st_error("Missing property 'u-boot,version' after fix-up\n");
+		return EFI_ST_FAILURE;
+	}
+	if (memcmp(version, u_boot_version, strlen(u_boot_version) + 1)) {
+		efi_st_error("Incorrect u-boot,version after fix-up\n");
+		return EFI_ST_FAILURE;
+	}
+	ret = boottime->free_pages(addr, pages);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("FreePages failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * setup() - set up unit test
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	fdt = efi_st_get_config_table(&fdt_guid);
+	if (!fdt) {
+		efi_st_error("Missing device tree\n");
+		return EFI_ST_FAILURE;
+	}
+	if (efi_st_f2h(((struct fdt_header *)fdt)->magic) != FDT_MAGIC) {
+		efi_st_error("Wrong device tree magic\n");
+		return EFI_ST_FAILURE;
+	}
+
+	u_boot_version = efi_st_fdt_get_string(fdt, u"u-boot,version", u"chosen");
+	if (!u_boot_version) {
+		efi_st_error("Missing property 'u-boot,version'\n");
+		return EFI_ST_FAILURE;
+	}
+	if (!*u_boot_version) {
+		efi_st_error("Empty property 'u-boot,version'\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * execute() - execute unit test
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	if (test_dt_fixup(&dt_fixup_guid, 0) != EFI_ST_SUCCESS)
+		return EFI_ST_FAILURE;
+	if (test_dt_fixup(&dt_fixup2_guid, 1) != EFI_ST_SUCCESS)
+		return EFI_ST_FAILURE;
+
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * teardown() - tear down unit test
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int teardown(void)
+{
+	if (u_boot_version) {
+		efi_status_t ret;
+
+		ret = boottime->free_pool(u_boot_version);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool failed\n");
+			return EFI_ST_FAILURE;
+		}
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(dt_fixup) = {
+	.name = "device-tree fix-up protocol",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+	.teardown = teardown,
+};
-- 
2.53.0

