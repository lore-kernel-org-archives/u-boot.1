Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42035606D808
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DWDzvbY8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWFzANYD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DB8E80D66;
	Wed,  4 Nov 2026 12:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hz2dGYAgffUB; Wed,  4 Nov 2026 12:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 405F780F95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796661;
	b=SNvhmjADtw8RR7lnk+DGYNvZaSndkW3chCNcvN8pss6QRqxQjI0x+DcrR93spki2RsTW
	 B06ku/p2vMBBnmFS+g9owsbNEv8ubES8TFzXwxbN0qXz0SUY+SSLwH9xMn85puIfc2Prx
	 FrhhS0MOyAgGciH7A9LJ3+47+rjtSljiRQE19XM8ZhpxCWFe3jZdMK71PTayFkx+57zHv
	 KErn9p2tUvlFFm+rXGWx3h7+UH9vdGxrdFlNlNp6SLiANWmOrq944VvTHmUR1YvQsxNgn
	 Ko/lWZAjLsCECkUtwUw646XpVvSAhgkJlBp/Fk3Q9b00tDba8h30C/lkikki4XIjE2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
	b=DWS4vkt5rvZA+CH6Zh+k5YCn0xXoqBR4ByI36afiE54UKGFWRPrXjd0/G9cK+OvpJC5X
	 tC4u9ynKq9HJJoyja9/q9SRVbYAnhioPVvMr/mMc2ulJYZsHVz3C7L+1bYRgccDG+IrIo
	 0P3y+3dr3G3aU6cK+wLNr/wBmq+2cmf/pOVe/wMQG+75UlbZgf2mZGYr8V/LJWVuDjOBv
	 nmeHBr3frJKEfMjvsQQplKiW8OELc8ddm/O/lDYbOSrzJmKHk+awkLp8+ZxxurMS+xhY+
	 Y/CZKasZSKQekhPv4yrBe80koUoUdaFalAnO9p5sHNLGLhN4k1mXLrTjb3t573uJJPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796661;
	bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DWDzvbY86Agbr4c3/clltg8RNeuxd6t1XkiRfizWqYz3Oeer596UFU/MGl4kcMUWi
	 VAkrCVxdFBfS8NhSfoFBEfTH4BxYbnnVor5vw+x12ncbfWY+/93/oyQwwmfTI2j39e
	 AQwpFefw9NHTEJjMS+tr9uLjWD/qvfWUQG5myfNQavpRwI6wL4ymu3gKF4sIwcPrRE
	 A7fQbyE0iGZsxCmH5ncGa7wTlSS0z6BLoMw0PtnArDLG25Aki7Hu6S6Pvh4T3JgEqZ
	 rCCyg9+cv26DiarLJVh8e0Zq4/sI+TFIgCrIolhqGTF/R8GNE/mfxNPd1Xt1OXFCld
	 7DyRWyAYH0fJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 405F780F95;
	Wed,  4 Nov 2026 12:51:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F546341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74CAA400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQlo_ROCd1FV for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6310A40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796658;
 b=c44iH4SfFGNjrY0J1a2WYgfDREfWJlY2WlnI2l1KMHoXiRU1gkstccBU7zfFrfZxFx9O
 r1SW1VHaRcM1FPQAxOXg56JXkGvvp0F2SefU4+UBxeVDKG4vwioKlK/JzGhKVQXAhKMx6
 C9M235W67vcOT2xVzinp5W1EKXioVSKT9Xc5WqBh6C25cA3zxi6h+QfoLIGjL01UTjwpP
 /FEvkYiBdQCL79wX+Ly9yUkHmcMF2Bj5j8k8G9mZKGkt8WzK0pzMwHMCrEG6ddVGWtGyg
 Ii/dAJXsJAU5tJTY3EScvRDUuxYVSns8p6OGQiniNblg/wCY1E31uogfzIHdpfVPDSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796658;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=rita0gK/ghzy9ffQMJPe4GLL89fEGlroICtMaEAxYzOH2QqOlm+YQpGibvohPVU78lcw
 oNKTlpxnvHKQgz07xTBvM7/gYZynM2jVIFIx+9GNdSJmZlT/Oo5tjn3SxipvJNpWk7mab
 xzcx8cMFFKkEmB+iYZ6d9LmguNpGli3mxt8fC/hA9zB92r4lMTfF8e1bARkK0CmO/daRX
 0hL64TBkFa2hF0ekyOJ4HIvQ5agylzyZk7j4HfXyIOL3XixudrxJCVIHz6WCvWKNeHgd/
 Pj7VxiVSdlCsFzFwNiP+TDyVd1oCSJDVXKDUYYgbJKhapPJdva8sGB8/9Ug4Y/h1eVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DWFzANYD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DWFzANYD
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6310A40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:57 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c4ced671398so94755566b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796656; x=1794401456;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=DWFzANYDgVNQYvRe8nY152EYpOPiu7e6/++WCLYUGhU4SxhXmykD0gLF0AgPhYdC6h
 MUUDsI24/7gLxa4xo+a1VUrlAMqsWF1xSrkKXpvwoRN4nM4Wvq/l8dkb+ST8yqtBeXcd
 KgHRgSJonJ4n7GRUmQgUY3g0c6OwVvoNd/fUQUHZA3NvJ+2xuH3jK9ONRZulTfOUJRoQ
 KW+SNumONovBvuyRjPth7iwJUgJ5KiUXaEXgLNYHv2WxDbBaZeShXqlCYJ0OV16VDWC6
 aqf7LfskP0tTIuvVc//2yELbvYQkiGihMwbI8Oo2WCDJShF0pTtFxCBOKcrdyO6Y06zg
 BHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796656; x=1794401456;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=f8trBsVoGutkVwSsZIlTO2Xl9rfxsvcv9XrWctEMTFg/c36mLhym6abjXRGhQ/1Rk8
 sayTGTB4UvPUWLAtQZzVLug3ztA1bcHsMCSKaBEI1pIwyHiIqdNo5ntSLocsE4Fxko7q
 P2PC1dymHBMGDcAkNn9nF0u7YmbpZr7S/BI2Uy32RZmdjMZLgdFBWat2izkQ4TMxNqsn
 Bcy4tk5Xnce0Hwfk53pKNOUrixWmce8ZWf4skepL5cAikgOADKKDVjBaH2ZyaVHvFhA0
 GMvVh3/CADiypAKm9SkS3jqeMIRwTeoQESdVOJnnOyEGp4FIiDaOlLgt/PV4ft0ZxRDs
 CyAw==
X-Gm-Message-State: APuU4Z/riZAqIbIhsxWBlqU34MLseSE7fqDYuvqWSkrHy2ng6RzTpZcy
 i25dvGuAeqmBwy1NhhHlv0p43T595s2s1s7Lm/gEPorI8X2BlJJn76wf
X-Gm-Gg: AYBFou1dVqJEjxaoGCtc9QQ2ukT7WTPxJjk4m2EvKBdM6D0TkaEIkdrnF9AKCyHLMc/
 9Um9bmsYfGsVzRtWxTz7FUHcjt9YBmCCsMGs9kJtGIop6K8f1JRGCy9PcDI3srUPfKP918k1t9F
 ot62KJ/Li49VC3/JxKdlwrJEFpUoy8H5MOjQUDE43pttHv6sReUPIPDa8ufuc75m/9mZxOl2vUw
 hPBhb+uvluChf2xHGjTsOReT6j04kg5I8Z6y9Fmfhy2djRNrbi6FoglTgGAyKDkX0Pa079lCVS7
 Mb8Rp6ilKWg6W2EA+eO8g07tbEm49P6bcWCXY3gRucJqYrWE+bZ+ipMzg+mQMErTfZxt4SHLCeK
 xoNuGiVoN0ESY7tEaXHD6ch+lMf+qzeWF6vPrrN1tNba5TgzO2++GQfmMkahCbf7zz1yqw0MMt+
 OxdAUFh/bjmbY53hGbV+f0+G1VxiCidH7BRFL6LU1lCC8zM8Cc7jfvJyT8YrFIBUDk96YEP6unc
 dm2HetQVkHq9YqnrGJus5tnvD9j6ZNIHWu4D1J+t83tzq7QOmfSiXJGCcD27fLglc1LSpnuZWAH
 HOwfhNLd5WDVU7uNpJ8Wh9Sb8a1btks=
X-Received: by 2002:a17:906:c14a:b0:c46:cc9e:a143 with SMTP id
 a640c23a62f3a-c4ca7a4a9f2mr1516746966b.26.1793796655848; 
 Wed, 04 Nov 2026 04:50:55 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e424f94sm65801766b.24.2026.11.04.04.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:55 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 05/14] scsi: Refuse a block size the block layer cannot use
Date: Wed, 04 Nov 2026 12:50:54 +0000
Message-ID: <fba2720d-fc6b-4162-92af-a9d367a49fbb@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

scsi_detect_dev() takes the block size from the READ CAPACITY reply of
the device as it is. do_scsi_scan_one() then hands it to
blk_create_devicef() as an int, which drops the upper bits of the
unsigned long, so the block layer may not even see the value the device
reported.

Check the block size where it is read, so that no block device is
created for a disk reporting one that blk_valid_blksz() rejects.

Add a test where the sandbox SCSI disk reports an unsupported block
size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 arch/sandbox/include/asm/test.h | 10 +++++++++
 drivers/scsi/sandbox_scsi.c     |  8 +++++++
 drivers/scsi/scsi.c             |  4 ++++
 test/dm/scsi.c                  | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index e5590d01a92..76e2f11b059 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -133,6 +133,16 @@ int sandbox_usb_keyb_add_string(struct udevice *dev, const char *str);
  */
 void sandbox_flash_set_block_size(struct udevice *dev, int block_size);
 
+/**
+ * sandbox_scsi_set_block_size() - Set the block size a SCSI disk reports
+ *
+ * @dev:	Sandbox SCSI controller
+ * @block_size:	Block size in bytes
+ *
+ * The host reads it when it next scans the bus.
+ */
+void sandbox_scsi_set_block_size(struct udevice *dev, int block_size);
+
 /**
  * sandbox_osd_get_mem() - get the internal memory of a sandbox OSD
  *
diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
index 5f0b01d86d5..34fc7cda915 100644
--- a/drivers/scsi/sandbox_scsi.c
+++ b/drivers/scsi/sandbox_scsi.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <scsi.h>
 #include <scsi_emul.h>
+#include <asm/test.h>
 
 enum {
 	SANDBOX_SCSI_BLOCK_LEN		= 512,
@@ -118,6 +119,13 @@ static int sandbox_scsi_probe(struct udevice *dev)
 	return 0;
 }
 
+void sandbox_scsi_set_block_size(struct udevice *dev, int block_size)
+{
+	struct sandbox_scsi_priv *priv = dev_get_priv(dev);
+
+	priv->eminfo.block_size = block_size;
+}
+
 static int sandbox_scsi_remove(struct udevice *dev)
 {
 	struct sandbox_scsi_priv *priv = dev_get_priv(dev);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 736dccfcbff..55d68cc701a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -543,6 +543,10 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 		scsi_print_error(pccb);
 		return -EINVAL;
 	}
+	if (!blk_valid_blksz(blksz)) {
+		printf("Unsupported block size %lu\n", blksz);
+		return -EINVAL;
+	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
 	dev_desc->log2blksz = LOG2(dev_desc->blksz);
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index 66859c991df..7617ee54893 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <part.h>
 #include <scsi.h>
+#include <asm/test.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -36,3 +37,39 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_scsi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that a disk reporting an unsupported block size is refused */
+static int dm_test_scsi_blksz(struct unit_test_state *uts)
+{
+	static const struct {
+		int blksz;
+		bool ok;
+	} cases[] = {
+		{ 256, false },
+		{ 520, false },
+		{ 2 * BLK_MAX_BLKSZ, false },
+		{ SZ_4K, true },
+	};
+	struct udevice *dev, *blk;
+	struct blk_desc *desc;
+	int i, ret;
+
+	ut_assertok(uclass_first_device_err(UCLASS_SCSI, &dev));
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		sandbox_scsi_set_block_size(dev, cases[i].blksz);
+		ut_assertok(scsi_scan(false));
+
+		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
+		if (!cases[i].ok) {
+			ut_asserteq(-ENODEV, ret);
+			continue;
+		}
+		ut_assertok(ret);
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(cases[i].blksz, desc->blksz);
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_scsi_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT);
