Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9CC88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E7DF809F6;
	Mon, 14 Sep 2026 14:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5ssmSaYUIQb; Mon, 14 Sep 2026 14:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E74F080632
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395469;
	b=Ob2tjGw/miA/zbE59CFKEg7aXpJLV+ZhGEYR4HZfN6wl0E2NvF6RaBEZyNkdONeKgTSH
	 /a7jkf+F87yncINrifIp+3oEGFHpfd7QCUX5UiNROtJNmCgy+VqqyOH+0H6JYU4u/eDt1
	 KBbKBUa1gjDTK0UGZue69cJZXth/sp2mA7ecnlDFKhVtdXOCRptMqw1EvdM7Kq7Nkd2Vb
	 7sMSjHN/dSwv4vlQiXeaNJa5IPmGO6a1TAHENAqL9VtvKUwmeiGAstpHSW6iUj4nG+NeT
	 nN1GqfeqQful7LJVawSkRgNgJwN2GUMXAHUi2jeRoWV8B/uoUD2ylXj65sx0NSc+YuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zec6A2Te/yBz6Wi1bUIrojc/ivg3HSSWyNcCc6U26EE=;
	b=ngbiIOL7i09sXNET5L1Cf7Wr7ZePCcermgYKVj13QUf9YUKLPN4TTXJElfDc3P+o01en
	 xbVtUW2WI/tRL2HcTkxIXs6DeFKNwoOqCkugoOItXK8CtzJRTtn+QvFRsPNN4+7MKw55a
	 35uqdBirqtj/IJKbEFDtzBJVA3IskkblMJVUWZ9cJ41LNyW/9CkLCcvrvg391wd1XLzVY
	 xBmrfbJL7w/stGKXcZGg08PNMIQVh2WPI4TzHxygb2H4KQp6Phnc4Azikn5CRMX4tOBqU
	 r11di/AP/OUeP813B4BhFn03+iiuaLsDku6L4W1gNppyqrq8F2ND4lMEQ7ZwoRgckgQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=adUgAFTh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395469;
	bh=zec6A2Te/yBz6Wi1bUIrojc/ivg3HSSWyNcCc6U26EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOVpEgACeFJOpm0d2EoGaWVJV68Sc+oXAt6ELrE5dTD2JpRhHgyawWWK1DLcJLvL3
	 e1Jjq4escEOE2RfzrrVhDObLlAqtNKKVGusGwH1hRCC26xrT8I1OtibTNKysU2Lz42
	 abQjTF428O1VUxfIvNCKrV9c7eyK6LR73a64Dq1lUQ3CVtA8Aubq2w95MBhfnz9NCZ
	 C6Pyn2tX8iairO8z/k4xVI4ci9egoLaCFeJjOeq2LsVbIdGXNUd7Uimp22hToPLH/B
	 P16md7VDKZdrjyuaoWCYcRu5cG3Fsa19WkXw2ckhmy+Nwkuf9WiD8oeKVtMfVzhGjN
	 bKuZX5eKOsQYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E74F080632;
	Mon, 14 Sep 2026 14:17:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4663C701
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3632380D52
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2weCvzVQZCm for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 77A8080D89
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=Uy3/5oL5WnF5/Mgw1stA7r0sCbkzYFsV9sE6ab57OQcn0rIGwxm2k2c8NqTHuepsC9CA
 m4d12gesIXiYpQRnt0OBXaoagbPT/skA6J8Nh7Gs+wY7gEo3D2cIEzces7P9+EyQZ/jop
 ntVQll/bE1uuy9KjEZmyPtUYol9A832GquQ4w073qf+djdeg6KrT5jZOkntlTbK9kOVxd
 V6dg8RTAwvizt/7e3EWSU3buy/4wTACSX/jlelB3nslYSBttDsAypaOIb1LHrkAMNl/eC
 ktVUVV4GcUz8DQOJqnowC8CMiO5oz8oEKL9hQ0RZfuJpC1wBEr0uTRjZtONkXcw+Gtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zec6A2Te/yBz6Wi1bUIrojc/ivg3HSSWyNcCc6U26EE=;
 b=mc4SH9bx5MzDg7ov/g4xZCazwYDT8eyAhzeQVY8MS4qbPoYf8uPIDQUmaW2u+IdPahFG
 mOSsUkUky8YdmfHvOfJ/0X1yvoea5MIKnRbhEWS08bC2ClAxM0VXjRDnqPaZDc3YbfE9g
 knPMU/uCZCbx6OTCUqqz07tacgA5OpRkNhvYiEE8hEQmkmpk7j9zW+WJdyHwOsgaMmDeb
 8dX9N+t56065EASFnNHbKd/rU0vZbkTpARi+rDfQmnBmgIWpFmWqfAy72R8TBj17ZL72i
 PGWuTkifn288TDYUJ1jEu08zolpshbREATymweZAwc9PtDpxPskLgliDYcdJqFOboMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=adUgAFTh; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=adUgAFTh
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77A8080D89
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0681576;
 Mon, 14 Sep 2026 04:01:25 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 189E63F86F;
 Mon, 14 Sep 2026 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383688; bh=fOQmRBAxu1DR7+AlfLTT//0J979qUmAqJ2nfD5STsdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=adUgAFThTHR+WrgmniDpeu9PhbWx8JG+3FGMwyVhSDnwt+rHFPCz0ZZblY6rJUdFs
 HyS2ZKfVdioutiHIr27GeNY2JOKKubPMX4uyFQwxKh+ktaG0yvHC1CEddCwS1B9HM3
 fTbmTp6aMQh93dLpJzI9hdP1PKs6/MoeVxF9zU4k=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 01/22] efi_loader: add runtime memset helper
Date: Mon, 14 Sep 2026 12:00:45 +0100
Message-Id: <20260914110106.1974894-2-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
index 3a4d502631c..9dfea1fd7de 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
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
2.34.1

