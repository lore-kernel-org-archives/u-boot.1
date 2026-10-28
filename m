Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD1606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RsmB3tNk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhhgKCUP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09D8680D1C;
	Wed, 28 Oct 2026 05:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyvXG7mzPipL; Wed, 28 Oct 2026 05:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0790C80D00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166625;
	b=SA1JSHJqQzS18NFO+a0eToWe/YNPaJfTvBBCVMhIKi6mb12/aH2eURZPijC3vQs4bieP
	 HNRhzjedsgUlfGXyRkOQltzcYUhc00XjriiWacyzPlszNPf/+t0mGI4GNi67hCGbCA3tj
	 4TgyFhlvr9Oc1U/i8rIwywf4j23fOkW06eqRh5PlUe9NBveXRtGee/LjZUtlVzqMmGzzI
	 Ir5Wj7pFBqg4vmV3E3zk23j5uk3FaurBdvDCa5IG1tZrTw8lTEldRojM+tOqXokKqWdgV
	 10KAb9ZBwIMD/c3F2VNADrvqz0dxkQDked1lu3ZVrU8IP+XNrPXaCAZSapJgwKCk5wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hZagqb4Ij8K6inDBhMtzdGj57P75L7k5W2HMPjLaFLQ=;
	b=afmJr15/Jo+HMZHLgSa9lz8zh48KhqqnT0B3bE2+qUscLQ2XPjPsv0MZ8QyG/YjNMikJ
	 J5aQe9i8/vfVpsXmK0wS4yA+dzg94jm/9ck3dyIaHhSIQcVwU+BIeNrWo/96sOuDSxTII
	 BNJeVBMAOtisfemXy0CxBy5+r/FjFvYWw2qKc9JlruxN9DPg3gAq6P+ykTFQfx3zP4lAP
	 Fld7IxOVII0QFoXnerPGNCIgr9UwIlKU/cLhiHjzGYoe21AfQurmdbVJ5j+Ynl22ukJNq
	 SJNY9V1l1TGjnO/DvpLSSHThMlKEpkrQF5dFjc9yq3Ddq0jn22owhe/WOxx1XXsjacQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhhgKCUP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166625;
	bh=hZagqb4Ij8K6inDBhMtzdGj57P75L7k5W2HMPjLaFLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RsmB3tNktLIvdKFlIH4moeC7CAM+CBrlzfw6mXjEjNUNxmSNMmwijm+56tAMaQJQv
	 usLeDJU8ACsHuZfBJWbkMOgYe0zIr4WBDeOOmdgwbx/uSdYaBPi8DR873ci85jn4Y3
	 qDw+Sn+orgZRWP6c3K6CV0GRIwXGcgot57I/AUHAbr1ciC224iMjk39/9QGswA7vrb
	 0Xa149uuYDuLSQn1Scy9fx/heT1icK3cIoTe7TcWeB+lVPD5eB2irFkUF0sYi3Xwkk
	 Wr6bfGkTZHNk2bXzp8lUme50FlQBFhIQEfScxiR5vnGByPpzipgTePG2gtB8jT1I1V
	 fiTzebwxgfyRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0790C80D00;
	Wed, 28 Oct 2026 05:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B45662E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A643D80D00
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsWWQIiEo6-D for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8641980CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166622;
 b=S+4IpcLmlPtWDIzC4J6KQce1Jbnx/KxyotZTndKTml+DCVLbYnMxX73S/Hi0P6xeb5WH
 SR6FJblJNB0joIaht20EA0L6nvzj7lhixQwflwlRaBWrcpYj6FQ8xPhDFM0OGy9LZVFyH
 d4Cxyq9LnGv8ol0olW3py/anLP05+BEQ7Sf+aeDMhNyBkqeshIJaXjoE5wW+QvLHmwdKd
 eW7JndHy7Ywd6ss3S2ymRU6Jemt2n9KbThJaEaR8kRh4A3t57VBuN1/UXGKWDsgLWh7uo
 AUioeFuDKtyLse+xh8mDF+RC+fVwdFG6vw/v2n1a2x8uS7AXsGIUQuOKje6Png3G7fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166622;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=hZagqb4Ij8K6inDBhMtzdGj57P75L7k5W2HMPjLaFLQ=;
 b=RF40r9NZbRRYkT/DHxfvHuv+LgOd1haUHMEZRHAyHNdHBYs1Hce9IHyzd2YsIIbtQG65
 OGZpSuQ4nD1wI/1+z7M9s+hKNDqRlS5kRxMAVJ6ompATrN7uIChucuPKCEwygWmUkqbmY
 NShis43IhihqVvEfuXmQmHviDUu7uP6lJ1Z00fGVTzhKn8TuBzNJRq+AfoH5kTesPCzer
 Sd2+J+4lnhHxOJ630KpE1jP4cn8VrOXG9kZqwqT74kgBjsf6uGt/rLP922JKLA6V9xE70
 rUyLc4q/mKRCm1ghXZsoyqpOWZeobkRWjxZXWzwVMtV2F2+tIPslTGx59UAGGGKL88g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lhhgKCUP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lhhgKCUP
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8641980CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:22 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso4037995e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166620; x=1793771420;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hZagqb4Ij8K6inDBhMtzdGj57P75L7k5W2HMPjLaFLQ=;
 b=lhhgKCUPCnSs4gXGtGGV/mCulEv73ByjhD0XlDRaNsgD1EHTDatDm+Q668DmvH4dyz
 RgDxqv6vbO72bf0xZVk8rj0spEktPDY2R3VO6IK5UFAb0r5XeEMusVGXK1+dU2AMh5yr
 ECRLU6ItY8+xFHX+f94N1nX1wZsZUwG7pm6VUJvcy2v3iZsSh4FDIs4p1x/FT+RpOj0k
 oI8AUNUSl8mcD6Axb6dI+b8BKgro5pg/BFzmA8KnuNMGrniK8IRm7bVVq183GcUmI+lj
 8hxy5Upeqpk81KZuyF654qKbKafNuhl74i7EzgcJDzj/yM7bUMmIhkyeqZLWWZo+CbJr
 Traw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166620; x=1793771420;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hZagqb4Ij8K6inDBhMtzdGj57P75L7k5W2HMPjLaFLQ=;
 b=jcE5a3gH2w+a+WKUMm0MXDs8OdcCNq0IHBPN4fSzn2pYVckCAqMqGsN66SobQfc/L+
 dHgAIfcD1mYVjbx2JActG5KsWDMy+YXOmNhNMWWEdJLiZ0w8I5yaQfnP3RFp/GZ6hkTX
 e6/IMFL0xpRlvDvBfIKLLkMt2mCRFhy5pLw9t+NDSSS57ZHKSq5028aYBYOeA2Hnjck5
 VXEYR+/LGzrcqrQUe7FpvBzYQ2x8VgbNP81cC+nN2BJUEZYcx841PnaZmYrswtk98+2+
 VZw/6KcCKK4vcnHPhJUTsFR76O5UYJgnP0kJSzh/idfjn7e+Q/1BkQfnXvdsR3EBksb2
 uJLg==
X-Gm-Message-State: AFq9FYLqdw29hO/ftDqv8N4oXlbIpy4Qgsp4KSLHc5FrXSRgr8Fe3Atq
 RHnzJa9XxXOZeTo+xmczdb5pOpUr3U4+jkfuXmjPpCDxKE5THuRGCyGm4Xv3047ds9w=
X-Gm-Gg: AYBFou3NvxTrE1ZHV/1wdQuy+HNQ9v6zdif6XVOgbXkGiQnYhUSJ5X4Yo+k9jH/pcha
 785gx2M4D/GE+q1vyICYpnndBslvkOH6ku3GFk3ms5s8hcUnMoebYf8O9aK6LAK/QDlCtvhcgp8
 BL356KIny3/4DXhLsSRmYodK9Y773tVVxf21g56jfwCMgLKflsGZ2/QPAqIKpBZhTfCBZ+AzZV8
 o1h4h5SQTXWh4aIk7PHUVAm2LT4tTPkTdGwCpIHgrNacqL/4NPTR8qXY176IyXZVQ6oDN/CLmyJ
 RypTl66U5vSCQqQg+EMq2RYqmkAWYakFx10l+htKimx4H24IC7VXRpF5bARgucPngj/lvUUEmBa
 DvyPdGOSedOy2wRCv2d0FvvNBYQOvnnJ96cYt7T3v0VGK9hHeKfEgCplVmdb52nxviFcgOPH4bo
 GLue64kdd9KC1djTAjyRSVgjYXaym+hsaOpoO1AmayU+0WtVBKaxJPOLfRxX+gc3gfgpON2pYZi
 Dy3isGrOpv2WEHohuz3pfrTmneoy53CnoG3D+yMkvSOu9oONTGuAAKAlH0qdo7OCa7JoE4nm7IL
 x84s/9p5UhN6i2ziMg9RhmJSpNjT4dw=
X-Received: by 2002:a05:600c:530d:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a966774cbemr20798645e9.22.1793166619889; 
 Tue, 27 Oct 2026 22:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97cebfa16sm29784095e9.13.2026.10.27.22.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:19 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/7] test: lib: add tests for the capsule size checks
Date: Wed, 28 Oct 2026 05:50:18 +0000
Message-ID: <0129c381-c806-4921-a002-b3f85e79c5c5@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add unit tests that pass malformed FMP capsules to efi_update_capsule()
and an image with a certificate longer than itself to
efi_capsule_authenticate(), and check that they are rejected:

- a capsule header running past the end of the capsule;
- a capsule ending inside the FMP capsule header;
- an item offset list running past the end of the capsule;
- an item offset that wraps around when the image header size is added;
- an image or vendor code larger than the rest of the capsule;
- a certificate longer than the image.

Each capsule is built inside a larger zeroed buffer, so that without the
checks the code reads the bytes around it and returns another status
(for the certificate, a wrapped image size) instead of faulting.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Test a capsule header running past the end of the capsule

 test/lib/Makefile      |   1 +
 test/lib/efi_capsule.c | 212 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 test/lib/efi_capsule.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 9fc4a1a9b5d..0fb6c6eabde 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -10,6 +10,7 @@ obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) += ecdsa.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
+obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_capsule.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 ifdef CONFIG_RISCV
 obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_clz.o
diff --git a/test/lib/efi_capsule.c b/test/lib/efi_capsule.c
new file mode 100644
index 00000000000..c99b4827110
--- /dev/null
+++ b/test/lib/efi_capsule.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test the size checks of capsule updates
+ *
+ * Copyright (c) 2026 Ana Bobillo <anabobillo3@gmail.com>
+ */
+
+#include <efi_loader.h>
+#include <pe.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static const efi_guid_t fmp_capsule_guid =
+	EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
+
+/*
+ * Capsules are built in the middle of this buffer, so that the bytes
+ * before and after a capsule are zero and can be read without a fault
+ * if a size check is missing.
+ */
+static u8 buf[1024] __aligned(8);
+
+/**
+ * fmp_capsule_init() - set up an FMP capsule in the middle of buf
+ *
+ * @fmp_size:	size of the FMP capsule following the capsule header
+ * Return:	capsule header
+ */
+static struct efi_capsule_header *fmp_capsule_init(size_t fmp_size)
+{
+	struct efi_capsule_header *capsule = (void *)buf + 256;
+
+	memset(buf, 0, sizeof(buf));
+	guidcpy(&capsule->capsule_guid, &fmp_capsule_guid);
+	capsule->header_size = sizeof(*capsule);
+	capsule->capsule_image_size = sizeof(*capsule) + fmp_size;
+
+	return capsule;
+}
+
+/**
+ * update_capsule() - pass one capsule to UpdateCapsule()
+ *
+ * @capsule:	capsule header
+ * Return:	status code
+ */
+static efi_status_t update_capsule(struct efi_capsule_header *capsule)
+{
+	return EFI_CALL(efi_update_capsule(&capsule, 1, 0));
+}
+
+/* efi_capsule_update_firmware() must check the capsule header size */
+static int lib_test_efi_capsule_update_header_size(struct unit_test_state *uts)
+{
+	struct efi_capsule_header *capsule;
+	struct efi_firmware_management_capsule_header *fmp;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	/* The header ends past the end of the capsule */
+	capsule = fmp_capsule_init(sizeof(*fmp));
+	capsule->header_size = capsule->capsule_image_size + 4;
+	fmp = (void *)capsule + capsule->header_size;
+	fmp->version = 1;
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_capsule_update_header_size, 0);
+
+/* efi_capsule_update_firmware() must check the FMP capsule header size */
+static int lib_test_efi_capsule_update_fmp_header(struct unit_test_state *uts)
+{
+	struct efi_capsule_header *capsule;
+	struct efi_firmware_management_capsule_header *fmp;
+
+	/* The FWU checks reject a capsule before it is parsed */
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	/* The capsule ends after the version field */
+	capsule = fmp_capsule_init(sizeof(fmp->version));
+	fmp = (void *)capsule + capsule->header_size;
+	fmp->version = 1;
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_capsule_update_fmp_header, 0);
+
+/* efi_capsule_update_firmware() must check the item offset list size */
+static int lib_test_efi_capsule_update_item_list(struct unit_test_state *uts)
+{
+	struct efi_capsule_header *capsule;
+	struct efi_firmware_management_capsule_header *fmp;
+
+	/* The FWU checks reject a capsule before it is parsed */
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	/* Room for eight item offsets, but nine items */
+	capsule = fmp_capsule_init(sizeof(*fmp) + 8 * sizeof(u64));
+	fmp = (void *)capsule + capsule->header_size;
+	fmp->version = 1;
+	fmp->embedded_driver_count = 8;
+	fmp->payload_item_count = 1;
+	/* The ninth item offset lies past the end of the capsule */
+	fmp->item_offset_list[8] = sizeof(*fmp);
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_capsule_update_item_list, 0);
+
+/* efi_capsule_update_firmware() must check an item offset without overflow */
+static int lib_test_efi_capsule_update_item_offset(struct unit_test_state *uts)
+{
+	struct efi_capsule_header *capsule;
+	struct efi_firmware_management_capsule_header *fmp;
+	struct efi_firmware_management_capsule_image_header *image;
+
+	/* The FWU checks reject a capsule before it is parsed */
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	capsule = fmp_capsule_init(sizeof(*fmp) + sizeof(u64) +
+				   sizeof(*image) + 16);
+	fmp = (void *)capsule + capsule->header_size;
+	fmp->version = 1;
+	fmp->payload_item_count = 1;
+	/* Offset plus image header size wraps around to zero */
+	fmp->item_offset_list[0] = -(u64)sizeof(*image);
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_capsule_update_item_offset, 0);
+
+/* efi_capsule_update_firmware() must check the image and vendor code sizes */
+static int lib_test_efi_capsule_update_image_size(struct unit_test_state *uts)
+{
+	struct efi_capsule_header *capsule;
+	struct efi_firmware_management_capsule_header *fmp;
+	struct efi_firmware_management_capsule_image_header *image;
+
+	/* The FWU checks reject a capsule before it is parsed */
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+		return -EAGAIN;
+
+	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
+
+	capsule = fmp_capsule_init(sizeof(*fmp) + sizeof(u64) +
+				   sizeof(*image) + 16);
+	fmp = (void *)capsule + capsule->header_size;
+	fmp->version = 1;
+	fmp->payload_item_count = 1;
+	fmp->item_offset_list[0] = sizeof(*fmp) + sizeof(u64);
+	image = (void *)fmp + fmp->item_offset_list[0];
+	image->version = 3;
+
+	/* The image is larger than the capsule */
+	image->update_image_size = 17;
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	/* The vendor code does not fit after the image */
+	image->update_image_size = 16;
+	image->update_vendor_code_size = 1;
+	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
+
+	/* Both fit: there is no FMP driver for the zero image type */
+	image->update_vendor_code_size = 0;
+	ut_asserteq_64(EFI_UNSUPPORTED, update_capsule(capsule));
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_capsule_update_image_size, 0);
+
+/* efi_remove_auth_hdr() must check the certificate length */
+static int lib_test_efi_remove_auth_hdr_length(struct unit_test_state *uts)
+{
+	struct efi_firmware_image_authentication *auth;
+	efi_uintn_t capsule_size = 64;
+	efi_uintn_t image_size;
+	void *image;
+
+	if (!IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
+		return -EAGAIN;
+
+	memset(buf, 0, sizeof(buf));
+	auth = (void *)buf;
+	/* The certificate is longer than the capsule */
+	auth->auth_info.hdr.dwLength = 256;
+	auth->auth_info.hdr.wRevision = WIN_CERT_REVISION_2_0;
+	auth->auth_info.hdr.wCertificateType = WIN_CERT_TYPE_EFI_GUID;
+	guidcpy(&auth->auth_info.cert_type, &efi_guid_cert_type_pkcs7);
+
+	ut_asserteq_64(EFI_SECURITY_VIOLATION,
+		       efi_capsule_authenticate(buf, capsule_size, &image,
+						&image_size));
+	/* The image size must not have wrapped around */
+	ut_asserteq_64(capsule_size, image_size);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_remove_auth_hdr_length, 0);
