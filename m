Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE67C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 034F060738;
	Tue, 22 Sep 2026 09:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QsDu1gw9zZSF; Tue, 22 Sep 2026 09:15:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5494960628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068531;
	b=egmFXRvH6QEjXPnFerAb4pCgwD2GTxIIEAczPJD7RltMoJZ1dXPpX952SX+HbCz8BCda
	 xskc8BuO81WqGMpEUUBr8C4AXP3divPEhdGJukL2JKzPIL4p4vzOrEeLaeG69fvTDVMBX
	 HrlTc22YL0FZBFuVEf6VnLZsjZJidB8qi5QZP9cV3I40RyyBdmB/E29y1QpOBBeFLJJIy
	 Whu7jnVrq9gW0GNNGPgXKrld66UxQ2zcr5reVzpQZbHYdeamGT4WX3Bc2IQKP7rypvNyQ
	 MdSXJcTTRrgBrVjOSz0Y3I87m9zXGpkKgTQ4CD2P2+iQLbTvc0hdIshW4KaDOy8bLhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M3q+y2kg0HCMVZsLB0b6RvIJzf3zEKHjCQ2Q9KP4WXw=;
	b=kL7ElUv2uuBFtDdSJStXcjzjqWA7XtnAe1CkZZA/JGtnMvhdBM/21F50XNe5tug7/g1W
	 WnnqWPtlT5VT/NKihBgzwV8jd5slBaClQeGb5Ydo7SoCtWNMb5Ny6ZyJVkATnMKmwJQws
	 egasl4uYhS79oUzZdKZ9D6LYJKuR29RekM+va5Trm1jdf9yjhc0Daw7H7tlaWIwVR/JYE
	 +2tQv0X+spuZh91I+OrIgdxV+rM4JRPKK5ug6BcOUnO96xxySOJNDlYInGzJLLa/mtzYE
	 k6ZI3uXFOabYGUDOkXMmchkXajaNd6z0qfM1/4nJrVciH6a8AI/aSD0TOiw1aLPcdXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790068531;
	bh=M3q+y2kg0HCMVZsLB0b6RvIJzf3zEKHjCQ2Q9KP4WXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QU/MoBe5vvS4wZUYH4jXmqudNNqKxSLVE+VZV2AbHzzyx1f8hTBKILeS+fqxrs4zf
	 fMebZUlXUxmBZjO01zpWiKkzEmZJjFMqmTsdijO4a/alxA3o2ZTAVLvJ1Ya/ar2l3f
	 3sqKkF1fpcYVfPsJ8GJibbRMlQKUWhV72HKxIgbuK1ehrxvezgV8TuMSbspRSDKhQE
	 Qj1lqTq+jFe7ZYa9mvl49xYVJhbP6luP6rJKUa8J5yqD0RjG/a8gpz74tVxcjfLGkl
	 bv4OIPPCysvC+Be9P304u1aorNji8Fsf48Ct5iuDOfJXyvTq77tqIGphPlYv6H/tjN
	 iWnJ5uFNCYLBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5494960628;
	Tue, 22 Sep 2026 09:15:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DB533A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EC5E40194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0rg5p5o0CPz for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 56025400F9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790068525;
 b=DRPSnf1Tj/CcsHvk9LHofG6EfOpSFNQQAd7znd6h+/dINIDjD1THd6lhT1/QDMIBakSg
 oyFTygtu10u/peV4cxkrpj5Ia8rXD6EvyGdbgD9ZS2vz1XJ5Y1apKFnVIiWBB1x80TEcL
 RDqEIkZo4cwRjYST7pxG2p5pH4sMw/5ty3+Qj+jxRlpaUchmZrx1ommTRjjZZFI0Y0pSD
 +TldU6Fz/hnmN5SkUYcotfV8xfnEdFR8JkTetvCNG4HpkeXT2bd27pg9uI49g144iRO6p
 ksYtFTjABm1l/z6ID9g36Gedq3HOjrLp1JTiLeBiavvcvlSZaAVdjbKC3SOv1UbwLug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068525;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=M3q+y2kg0HCMVZsLB0b6RvIJzf3zEKHjCQ2Q9KP4WXw=;
 b=impl5476p7oXaMl8+KcwrqrEuv+C8ChI4b7yjGh5/zBZ+F7ij6KWC4OJX3hbgwV3U3z2
 iUtLutD3Qlng4cX8ctOWc8/bxPp5BBr7CJlanM0YgT5Wu9+d0UZJE1vCU0v3mKIC1e+WK
 LSI+SESOAOixvUDLXSeRRsLSyP2W06tNBxpEpHSmlqv9cDJ2bVSIphtC0vs4xQw4wVKEO
 Y7NfXeTXc+FcFsRCspl6eXBYgf/0kHx3qdWVK7iLpBqFrLxlaHsXVo2zgQy8FLw2/gHtp
 FLyfcioL/byVb7mHTBj5XiERminde4Ob/q3lHZgynxZ4XKMNdQqmMCF3VgqQn1opZjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=AG6aumBL; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=AG6aumBL
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56025400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85E91BA8;
 Tue, 22 Sep 2026 02:15:20 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79C13F9A2;
 Tue, 22 Sep 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790068524; bh=iEtctYYq0uaDTOEvkpVB/jfUjfjzqZYG6YbqTpGCt5M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AG6aumBLuAobOiNKwWyx2gzyOQO06s+nvyVJJlpXFRumcbZo7sbCP7TdqDPQngKjt
 mFkV7Vp8nrB25Js0b4iOXyrI1Xa8ycOIrGW3C8nEZMst3LcnCXR/QbUXB/5vPpgVgd
 Eah/8wMfH6ok5P2iIM0mfbMoXsjSCb/njV7hLsD0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 22 Sep 2026 11:15:17 +0200
Subject: [PATCH v2 2/2] efi_selftest: test set_string() HII string table
 realloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-ptr-v2-2-58817a31c67f@arm.com>
References: <20260922-ptr-v2-0-58817a31c67f@arm.com>
In-Reply-To: <20260922-ptr-v2-0-58817a31c67f@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5521;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=iEtctYYq0uaDTOEvkpVB/jfUjfjzqZYG6YbqTpGCt5M=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqskcmXi8jyzu517Y8GNn23zwT0thySqLh3GBIL
 ApMj0R2uKCJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarJHJgAKCRDLSfhWdqMG
 lKaiB/9lC/YtH89XKrHYmGVIoabR9vvYmXLoIQOh+X52NItbKxXZesUe1WMRM2hpCooTd6bj3nz
 lS12DiGjTOFk91tdqZwSmLOWPUrBzZxik7yg+tyLTydQUkr5A6qPleTWzLtaR9fTZISzdpyuIZ9
 0JZpHkEem/gGL9KDgVvTbFs8KARK4d07QFlZeHF7V0Hq9xBfQ8DHWGHb+vYquAGrBXY5zm5rzP/
 JSn6Ziw/J4aIm1L6VPuqsE68zmSBSmO778uY4mdZgCWD/I4Zhe01nwurEXm4uFDRDoW1Qs2r/TU
 5cKsZe2pzkDzfxCHHbUePD+rXDu0MVjvbTUa/PZ0Z85muYiY
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Enhance the HII selftest to cause string table reallocation with
set_string().

The test method is the following:
1. Add string packages with two strings for en-US, and only one string
   for fr-FR.
2. Set string 2 for fr-FR, causing reallocation of the string table.
3. Get string 2 again, to verify that we did not forget the new string
   table size.

This can be tested on the sandbox with the following command:

  ./u-boot -T -c "setenv efi_selftest HII database protocols; \
                  bootefi selftest"

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_hii.c      | 44 ++++++++++++++++++++++++++
 lib/efi_selftest/efi_selftest_hii_data.c | 53 ++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
index fdbb08fb417..2d7151b638f 100644
--- a/lib/efi_selftest/efi_selftest_hii.c
+++ b/lib/efi_selftest/efi_selftest_hii.c
@@ -820,6 +820,8 @@ static int test_hii_string_set_string(void)
 	efi_string_id_t id;
 	efi_status_t ret;
 	int result = EFI_ST_FAILURE;
+	u16 string[32];
+	efi_uintn_t string_size;
 
 	PRINT_TESTNAME;
 	ret = hii_database_protocol->new_package_list(hii_database_protocol,
@@ -849,6 +851,48 @@ static int test_hii_string_set_string(void)
 		goto out;
 	}
 
+	ret = hii_database_protocol->remove_package_list(hii_database_protocol,
+							 handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/*
+	 * Test the reallocation path.
+	 * We create string 2 in package fr-FR, which has only one string.
+	 * This forces the reallocation of the string table.
+	 * Then we read string 2 again, to verify that we did not forget the
+	 * size of the string table.
+	 */
+	ret = hii_database_protocol->new_package_list(hii_database_protocol,
+			(struct efi_hii_package_list_header *)packagelist3,
+			NULL, &handle);
+	if (ret != EFI_SUCCESS || !handle) {
+		efi_st_error("new_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	ret = hii_string_protocol->set_string(hii_string_protocol, handle, 2,
+					      (u8 *)"fr-FR", u"Realloc", NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("set_string returned %u\n",
+			     (unsigned int)ret);
+		goto out;
+	}
+
+	string_size = sizeof(string);
+	ret = hii_string_protocol->get_string(hii_string_protocol,
+					      (u8 *)"fr-FR", handle, 2, string,
+					      &string_size, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("get_string returned %u\n",
+			     (unsigned int)ret);
+		goto out;
+	}
+
 	result = EFI_ST_SUCCESS;
 
 out:
diff --git a/lib/efi_selftest/efi_selftest_hii_data.c b/lib/efi_selftest/efi_selftest_hii_data.c
index 2d29bb045d3..7ab70c61148 100644
--- a/lib/efi_selftest/efi_selftest_hii_data.c
+++ b/lib/efi_selftest/efi_selftest_hii_data.c
@@ -424,6 +424,59 @@ static u8 packagelist2[] = {
 	EFI_HII_PACKAGE_END			// 1
 };
 
+/*
+ * This package list is meant for testing the reallocation path of set_string().
+ * It contains two strings in en-US and only one string in fr-FR.
+ */
+static u8 packagelist3[] = {
+	// EFI_HII_PACKAGE_LIST_HEADER, length = 20
+	0xd3, 0xde, 0x85, 0x86, 0xce, 0x1b, 0xf3, 0x43,
+	0xa2, 0x0c, 0xa3, 0x06, 0xec, 0x69, 0x72, 0xdd,	//16
+	0xad, 0x00, 0x00, 0x00,				// 4: total 173
+	//
+	// EFI_HII_PACKAGE_STRINGS, length = 77
+	//
+	0x4d, 0x00, 0x00,				// 3: length(header)
+	EFI_HII_PACKAGE_STRINGS,			// 1: type(header)
+	0x34, 0x00, 0x00, 0x00,				// 4: header_size
+	0x34, 0x00, 0x00, 0x00,				// 4: string_offset
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	//32: language_window
+	0x01, 0x00,					// 2: language name
+	0x65, 0x6e, 0x2d, 0x55, 0x53, 0x00,		// 6: language "en-US"
+	EFI_HII_SIBT_STRING_UCS2,			// 1
+	0x45, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x6C, 0x00,
+	0x69, 0x00, 0x73, 0x00, 0x68, 0x00, 0x00, 0x00,	//16: "English"
+	EFI_HII_SIBT_STRING_UCS2,			// 1
+	0x55, 0x00, 0x53, 0x00, 0x00, 0x00,		// 6: "US"
+	EFI_HII_SIBT_END,				// 1
+	//
+	// EFI_HII_PACKAGE_STRINGS, length = 72
+	//
+	0x48, 0x00, 0x00,				// 3: length(header)
+	EFI_HII_PACKAGE_STRINGS,			// 1: type(header)
+	0x34, 0x00, 0x00, 0x00,				// 4: header_size
+	0x34, 0x00, 0x00, 0x00,				// 4: string_offset
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	//32: language_window
+	0x01, 0x00,					// 2: language name
+	0x66, 0x72, 0x2d, 0x46, 0x52, 0x00,		// 6: language "fr-FR"
+	EFI_HII_SIBT_STRING_UCS2,			// 1
+	0x46, 0x00, 0x72, 0x00, 0x61, 0x00, 0x6e, 0x00,
+	0xe7, 0x00, 0x61, 0x00, 0x69, 0x00, 0x73, 0x00,
+	0x00, 0x00,					//18: "Français"
+	EFI_HII_SIBT_END,				// 1
+	//
+	// End of package list, length = 4
+	//
+	0x4, 0x00, 0x00,				// 3
+	EFI_HII_PACKAGE_END				// 1
+};
+
 static efi_guid_t kb_layout_guid11 =
 	EFI_GUID(0x8d40e495, 0xe2aa, 0x4c6f,
 		 0x89, 0x70, 0x68, 0x85, 0x09, 0xee, 0xc7, 0xd2);

-- 
2.53.0

