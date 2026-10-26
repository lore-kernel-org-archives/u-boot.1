Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB90606A321
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FykAJRuv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bwydYNRQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EDC6406B3;
	Mon, 26 Oct 2026 13:19:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AncyLeKpdWak; Mon, 26 Oct 2026 13:19:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73E7C40435
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020775;
	b=nQXEV2jasne14x1zvwtnKjh2BlLdxmuJxeo0erdGm5FDogcoVNkXArQ9s6L8PzWIy4di
	 rf0QMTeFveTaXFVwUGL+SbFCwYJgP02r7j/YXgjl7bx5cFEJFumvloMLZ/5hJQdrHH50d
	 L4pdSI+bmM8qCgsNdc5KU+QbPJVD3MGXbDO9h74lkAdmmGZyN7DEGYiVL1B6pxi70uhHa
	 8/LZdE3NGv8p2Txo3kkou8ndQnupOhYbTldjbmfUQ1QI2PJaBS5QIPk5iw8jVIp+2GaHj
	 etTZDkgbMPu7N5PRBAwizqYednY5UR9KBEgmnAeANaflV7w6O9PMa/nQB3MQ0wnrUQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pjLMOsSHIGb9+TbV30X1QvkJcA7KB7c3FeV9/nkNQoU=;
	b=rePOMKhj8w+wJnF2lmutuc32RzAzB0rMxUbSqQG9Wr131NUzP//TwBGKScygkzMqsQGn
	 fNkkVmhDHuxps27yU7FMXZBsK4QYqcwZ2htgGL8h+Uuhx945oZf4w3cUu10h4uWXfO9Xk
	 33XaJuXRXjYoz/TwZC/y3Cfu9kmVBU0jK0QMMJWA5bl7wYfCKb07XSl5mQJahbRDEhceh
	 7p8dtPAjUtaQ30f4ZtwXRw2CrWzGMxrasJDQMM/Tpw3/F2WSEnyadc8+3GEieYRKR0chQ
	 hjM+jdiyln3zTEtqYHubJWn5AQ7kefdNDqplNlU1n3MC+jQja9LVrYYaf9E++t9FpQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020775;
	bh=pjLMOsSHIGb9+TbV30X1QvkJcA7KB7c3FeV9/nkNQoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FykAJRuvnGMYLm45tWpZqJD6K3s203ExbwBUQqKLHkOIuQj+8jgDiJbbZd8toNjEl
	 StM5oz24c3eEXvK4pxCISrEgAx8Qhcs6wvYQgLPp/93+Jvbmga7r+SQ2je4YheO8Z4
	 CJsx2SUfNUMrbAvbjxG7ehiNZREeUwoY/Lxb10nkNe6DRxIx79zb60r8Q0+pMqx1Qd
	 nFkLVWmGP9jeIGF8XbLIAgqNZo7dtYYe1ubEBbOdmfX0KQBAO0VcE53FDTl1iPn3Bs
	 c7nowEfc4IXrpAjK8LnvI3vGyuhDZPpBlsmtEzEAp0+loqiB7KyBZjWGts5/e9b2Ei
	 jJrjoxWn/t0ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73E7C40435;
	Mon, 26 Oct 2026 13:19:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C418C279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5A4D80D34
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14zvPimFojng for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FBAE80D62
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020773;
 b=FefdPEe6RSA6fqDy4mKEB+T8N9wEn6tTvcSw20stBjCFBQpZKYcMX++sVx5KJ2BSME4h
 A7Lizzs0DnkLKvxAXPZfP7FPbmoHaPGPd18YjXeWIla/1ZjSzvrI+TYMQWeXbiWcDshhI
 yWt5Plg/viuP26XiWwkM/fgcy/tl0HeyB42obWSE6Gx8Ug45iaU8HwUxjUmgHNFhyZnMB
 /pfK3xyufGkGmkcVPef38LER8dbWGwKRL2Pbah8n92kF0DotPK37x15v7rdj4NcK0E+zg
 RlFJ3TifgW9nxan+UrXCeQtFuiabfMtbfoYAdz4RtBxQL0X189cE8O1hzeIGv8gflow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=pjLMOsSHIGb9+TbV30X1QvkJcA7KB7c3FeV9/nkNQoU=;
 b=CzIfGI2Uzd06sNQ/2h/GZGaJ+F6X8UvcZZveg+Y8PJi3WJ5fPBB3v2kLCqWeXqBdrbSm
 rGyJbwY2tMFEfExwDpxRYHRhE+ZPyp4QBTfhtOtpAGLH1BaOdQ0lEfxAJlnt6qtjkZZd0
 EcNcHXFnLyLUaableLUbs0P8ZsVIfEnJlc/op0b8BCwONew/dwypwAgMu4iBYwIYvKoYl
 sAlrzaTactF+a4rOJzClJuN/VRUPJAR5b/lkHQ5glWERVxopJevwzfRNerOe0jvYFl8Jq
 2ML+E4Uzq6brUOTW1urYSRuElpIKKPSEWq0aINJw3du2FScaYv6yL8LRaB1NRVgJ8Pg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bwydYNRQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bwydYNRQ
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FBAE80D62
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:32 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so2598569f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020770; x=1793625570;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pjLMOsSHIGb9+TbV30X1QvkJcA7KB7c3FeV9/nkNQoU=;
 b=bwydYNRQoEiQLbymLzgn+EeP8XHTjYvnYLItg9t8S2P17w68hPspngqp4ovVW2zWpm
 zPiK45rx4jxYnC3UlSb+TqNiGkn/7kNALVPLUAl3T38laUckwg4Ib+jZniuiApYHQmpD
 rBId28BfNbKTI+uFLNLxryBwICX5C0x87HRfe45RiYsUpFR3MUACXH5NP9K83Sp+MN5I
 x4d5h99y53nTxr40jYVLV+dG8m6Khs8vT7epipl+kAgCVWu0ccZukeLci+V5E3AQ+XJY
 ZpXiXbpETBevnJuJAcdJVavUXF4BgUG3qgx+BhZbFSPG5EkS2cw3ZHikhmcPSi/fB0qs
 +vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020770; x=1793625570;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjLMOsSHIGb9+TbV30X1QvkJcA7KB7c3FeV9/nkNQoU=;
 b=voxCyitH17xzSdr3Wv0gy5pV9EUMa2ZQTI+acxBkSstoG7P1OkQgd0nBuvg+yORtO8
 1/1L2wwGnxstGf5lnAL2PFICHIZLl2prLyiaM15i+c2RJpOel0Fqxv6o8xB8Gt9rbbfr
 2uJ8YomjwS4tvMjQ1sSkcJTmmSyNegznHWdd9ZqbGDUr/ulGIMsWNe4ZXrRSOlyVU/74
 VGLhttyOY0P/WCFf4We+r4pkTWLvmE5sPpW2ewUlAHVIbM+8a/b/bmpDttzy/xZjdgcs
 z/I9oHqUdQ67TxyAXTcQ5JL6V741AUsJ2lbK5ulWglheimFfRjSE+MEQYWz5c2CIae3a
 wa2Q==
X-Gm-Message-State: AFq9FYLGUtLTB9azSu4KKmJn/H26qbB8gozlA6V1mutf+VZhlxmU5FCh
 FJfkTHKgsz7/rNzQiFQFc4N694+YvrbeouhKP4j9sVkdSDeYGluNdxaVoRaeiLXK
X-Gm-Gg: AYBFou2AGcmX261Ul4tifmcuXPmSu3jnib3llDLsgrTLlmofFNJPx4C808h8vwSsmyZ
 6vC5qSurOd0D++upzUD/iNkb4Kw2RklqX3iubKVMS48Lk0OOgPt89FTYPSNl8JoWyzQpEkD1s5u
 nWi8ilRirM7Z96qrOznyG7+B3iwcmfZOiA0hfi7T9nnfts6qDumoV8QfrBdpF1LrolOdAjO8CUG
 Ba8Q30vrkc6fksiIAlbPfIxszDM9kOFwfDfMDTmTg5iBH4uCHCRqOT8b56CutK1j6+yAgGPumsF
 9wKrQlyJ/qS+HEpUmPjBZgYclf80mHUa/LHlV/+S1EXdATmcHyzlw4X9e7XbkU77a5J6JAodpeF
 Ka4sx0HMI/j9OkVslEM3mFApG61mD6i21Zu16f/XYga1lf8TOK5/5QsZjUaB+ChVNZFrNd+h0ec
 GXP1RuRh7Rty/5LeUy89bJdqgVkMAs2iUWVuHhzBuFHIAFJJNj/QCtVcapT1OkeZSGjy8iHEev7
 uNTzqksgjU7duHKN9HHNONtJnEUZbLCxdaCjhAj1U7lTQjSbqPnrokpog==
X-Received: by 2002:a05:6000:3104:b0:48e:4ac2:52b7 with SMTP id
 ffacd0b85a97d-48e4ac253b9mr9077010f8f.41.1793020770214; 
 Mon, 26 Oct 2026 06:19:30 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm16320643f8f.34.2026.10.26.06.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:19:29 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 6/6] test: lib: add tests for the capsule size checks
Date: Mon, 26 Oct 2026 13:19:28 +0000
Message-ID: <38f3c18f-2523-4284-910f-6b68c2c58950@gmail.com>
In-Reply-To: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
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
 test/lib/Makefile      |   1 +
 test/lib/efi_capsule.c | 193 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)
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
index 00000000000..7e4e1e69540
--- /dev/null
+++ b/test/lib/efi_capsule.c
@@ -0,0 +1,193 @@
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
