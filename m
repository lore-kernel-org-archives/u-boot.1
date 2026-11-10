Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6C606A7D0
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tQAomoIF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VRSXQFka
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5DD6812A0;
	Tue, 10 Nov 2026 13:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUr4rXTbdXUK; Tue, 10 Nov 2026 13:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAC9C81281
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315929;
	b=fzVM8bJ/48HzpATROj/+z0gQ1ziPcrI+q2TvbM6zYveMBd4DiqndVsowGCDCYtglrQch
	 UziWA2inFR8ueXivlRg/dDg2lYVvBa4S7u66r7Ohdsw7wwJHUAqkSumpfn2kgv7OVAeUq
	 mqp+lAzOA61Iwc364c5HYO7oHYLI7i9pWAdOG7KVBT7wAzKkrMosdMaGSpLlO6Qx57/re
	 hdn2WwFh5d45ddO1YBGyPKs74PAUzDjenPmV6xoJlzSaShlUHxbo7L+e+tF+kFappH2CI
	 cRBQMi5B0wZzi/mdBzaB38hcxPgZ3AIF2f8Kl/8Xqptp+5bB8GqNOCkA5VQqChQvjeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qPSb7vZImGxdz0PgHIdgkf+juEs2EtYM0QjOwSyoJ1k=;
	b=IiEfJhWLNBms0o2hvj7zMyA+CSw4xWk7kOEpt7qmziO/vep/eQ/PSf3Xfc1I0B8r43d4
	 tVu8ZEMu8x5N+w8Kc9kkC2GMwPm6xDTYekUjrsMmkLsNlXx8pZ0OgYhkUCJ48bW4r9s/q
	 0HD/VxjACqO/QjTAx+6/8oSsVrfBCRKePHhDaHFOP4AAtouxFAR0u/h0hjL2GagoQg9MW
	 IHNHefAOlEpCNHvtwy65sdDIoHphdMUEewiVh2yI5bi31H1VCWbKz+fYHDg+nv29K4tRJ
	 9XZOpLKc75t4xnRIb2BlULO0kgAPfgD1bahHieRd2600PW57GgB1V1NUfwMoEJtbj5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VRSXQFka;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315929;
	bh=qPSb7vZImGxdz0PgHIdgkf+juEs2EtYM0QjOwSyoJ1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQAomoIFjpzBG4jgqsYfY3ihxXIn8rayiqAVtZ8fjGALidXSi63bKV6MSjA//Xuib
	 LUK2mg93AQyhVxFvMK2T85VmGQYdVGXqZrwZfUE+OQpxcAmGYAH+P2FC8GiAiBf1BM
	 OAdwp1hnEzwq21LSY906L217DQqbj3LxBZrV6wihUHzSgk9Cak1d+83vNlMAh1rff5
	 U/x9XXAnPk7UJ4YVyUIBzXX01TdBbapKPT6zqoMvvKnJcJgDaR9jkbyEldvUiNHypG
	 LM+8WWpwsmOrSmraq+Ep1ju8zGajPFxzgJfV03k8ebBA8k4p8Yi5QIuo3/cu3shLjB
	 FVtJlXYr6VvUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC9C81281;
	Tue, 10 Nov 2026 13:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E491D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A8C88110A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5a9InqLvMA2o for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E11248112D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=VRSXQFka
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E11248112D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9B11E7D;
 Tue, 10 Nov 2026 01:58:10 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735F83F632;
 Tue, 10 Nov 2026 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304693; bh=+lg28YJQ4dNZJpOolWpLN76jYM8x33gwAHfqF+iCTuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VRSXQFkaflkVwqwSqdGGM9lfripALELCJtMMhZtOB4ll7tHgpAhVg3Z4reMKZ35Ho
 XBl473G0Om8EzSeT8bXu75i3isu5mFZSZj507dtw8zAqMTo6S+0UFUu6FiJz3t6L7D
 wPFvCbOL8dC+1TLMfNC2AZL5vcl6fk4DMKTkmH+A=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 01/22] efi_loader: add runtime memset helper
Date: Tue, 10 Nov 2026 09:57:42 +0000
Message-ID: <4d442c9fa2bab660c83086a41330d7969a9043ef.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add efi_memset_runtime() for EFI runtime paths

This keeps buffer initialization in runtime-resident code after
ExitBootServices() and avoids relying on non-runtime helpers.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Fix the `efi_memset_runtime()` comment and kernel-doc style
- Drop `__efi_runtime` from the header prototype
- Align the definition signature with nearby helpers
- Cast the stored byte to `u8`
---
 include/efi_loader.h         |  3 +++
 lib/efi_loader/efi_runtime.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7b865fe900a..95873b347e9 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1149,6 +1149,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
 /* runtime implementation of memcmp() */
 int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
 
+/* runtime implementation of memset() */
+void *efi_memset_runtime(void *dest, int c, size_t n);
+
 /* commonly used helper functions */
 u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
 			     unsigned int index);
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c..c0182931c42 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -233,6 +233,26 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
 	return 0;
 }
 
+/**
+ * efi_memset_runtime() - fill memory area
+ *
+ * At runtime memset() is not available.
+ *
+ * @dest:	destination buffer
+ * @c:		byte value used to fill destination buffer
+ * @n:		number of bytes to set
+ * Return:	pointer to destination buffer
+ */
+__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
+{
+	u8 *d = dest;
+
+	for (; n; --n)
+		*d++ = (u8)c;
+
+	return dest;
+}
+
 /**
  * efi_update_table_header_crc32() - Update crc32 in table header
  *
-- 
2.43.0

