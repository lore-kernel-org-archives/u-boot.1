Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD5606A336
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nA/hTYvu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbqieuci
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 785368108E;
	Wed,  4 Nov 2026 12:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HlUx37o82UK; Wed,  4 Nov 2026 12:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DDB88101F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796698;
	b=hBVp7gFAcLZ4NPE/vrNULZlXm4wilkOFfcufqO1wbqM/KM2uqrOjctI2H+sSo/vaDeKz
	 L1WKyZVnwZsCAjzq007hJiwNkFaG4+1HD73ejCMJTlJjy4+vIW5OVTVIVd9AS1V6Pu2+b
	 9qmiKtvgYZkEd7nPkvTmGZw/5849rmWvghobrlB8Z/w5rZ2IkklzLcjOfdAvGpuoL0sKC
	 OZpo8LOuhRtpzdP2qbDvmgSfIsvXds3v+1iumLM1NCkbDd5ZagQu0Iee/nRudEqyiyA46
	 BGDfAYR4r1RQ0fRTJpJAv6Xr3+CnD2TJRHX/5hrO5MTXdOZU3z9FnBLSEpF3cN4z9tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=whYlU00TF5ZERk8Gbd2TK+E7ZSmBafPcI7B/wxwDmtk=;
	b=bDcHlyLc7J1M+yCZRODNLxZ2gZkkVC7LZtSnzxP8SSfpk3zHbKc9MHP04DPeIkycKpMS
	 IykEtGOqVcwBqUragxVfXEz6mMDOs+rcUTCikYjPHIYMOrVIp92S8J66sxjAXokEel+tI
	 NYoCJFfu+CtYe2ME2/9nul4aEWD43EWrXBEBPTuAAuZv/T03EwNaIWl+1OF+w+0eyWDBJ
	 +UhiK5wFxSegbCRvFvnBhN/ErLVRTw8RCwUfHz5IoQKaevTeP+aOsK96ufI2/MocChhTs
	 7fASScTF0rhw4WBlEhO+hxDGRecjFWkt7qHDW542QglkqFVdAjbq7YEWtx/6a9whgKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796698;
	bh=whYlU00TF5ZERk8Gbd2TK+E7ZSmBafPcI7B/wxwDmtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nA/hTYvuhp4E0rMJo9RGiJRPigk8Kocq03mGu9V71poEcsMPS3ts5/d0fPkr0M1OR
	 9swoCSWMJf3IZGVgVKMkSSKOBMQsDSpoxYi1YBmLZGiU79oVx2gsp8GnJaiGhqkkUz
	 QR2JvINNI2bdwybVCbxHViie6OYpkRLi+vNw1NffimPNmqhbjkUfMYfBuyEDJyMEDr
	 C0qchI269ogFOeNXBoCKVnu7wbIIsW7lIchUR8cNnfsNJFAZvmdF9OrFzaBEObwQ9B
	 GLY3a++kh1zVneDE6aBbKKnwc1zyfm2a8fMs1c/KQhdWdCCP1U6zL2laPrRF+1eQoq
	 M0vwyae1qaIlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DDB88101F;
	Wed,  4 Nov 2026 12:51:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B065341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CF04400B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKPf-GeGpHVA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 45EEA40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796696;
 b=BG7PsSzNd5wSZ/SxR1jrRTehnc8yL6Xl/VupDnOyTRSfVLQ4TBO5wRMRVkePXRKKXkyH
 MFd0S597WPu8jOouwu/q6HBo7DKzUzlmIeJdhZfsXLMOTtWmYOp74BZCVzp41enbVm1Qd
 q01arsHKzXjXXJ9D4SilkThka9mteTag+Fk2EH9Ejlo0Ptk6trAIZZAOSqc5iE9s85Q2N
 c5eISyemVn0p5pmkmUj3eIL6s/+GUf8vgqKUd5pqbdOBIP0Xec9mF5velWAU7fmeOf2B0
 BQ7DOGtLCNT5PYx8Jb5JklVjg5FBbLPnr3MXLPyrBBbNfBFiP0JtQ4PP3O9UM8d47kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796696;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=whYlU00TF5ZERk8Gbd2TK+E7ZSmBafPcI7B/wxwDmtk=;
 b=dZ2QpFB04Bda5U41n0GqgjsXms0Nu0mtHOsK1D0b0LKPpE4KX5UTAp7jytscQQDp2o+P
 hvueWLRD+FKLXFBhLo9K4hgk+6A+VsBPc22RnCFIrb4BH7fF9hfGDtkVEF7W75zVSxTyj
 jCPO4Vimv72LnLUKBqgwjwAsEXRSZhgkIuQWVMJeenr5RDuORmxynRQCvELxb1sBZ3PUz
 9i9v2lLEI+opzhuvsTkrjn0TrRM6JTKX1j/w19/OzsZ2ueIKYx+dbSvhh040WN0pKE2lt
 YP/+/WoUxrIiMNpm0siT41CdFuRiBjXyAxItJ6LJjtD8qoHnrYsVHflXk1HqYc2YXoQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xbqieuci; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xbqieuci
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45EEA40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:35 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so99991966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796694; x=1794401494;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=whYlU00TF5ZERk8Gbd2TK+E7ZSmBafPcI7B/wxwDmtk=;
 b=xbqieucipP5Z6LAKMD6LCRzaAi3YkUq/BHeEQPJv6qP+jqokLENIrCcLgMiVqq0AhE
 hLC0W2E7kCmMNtC4agWMrz3x+ASNqMlGj1K+sZ2VbSYdE5x73RFBMx7t8HIZUL2yPUEQ
 JmSLO14SIJ9zaXGZYk7o/75tsNXV5RUKCjrGIFFUQTxoAcYb4+AGUunEpO1a1NInGBTU
 7T0dOjH/M454b+25YfdDyWa1khnJNuVmunqGS+5CxxZRLiV2y96fGmxyXC5Vb9GNhsk2
 1tdWdl9OaU9lTog7kruCO75avoZbPhyPfnUY/c5UULZmdN3Fs6zujLDq8yCqZt20U5T2
 PaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796694; x=1794401494;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whYlU00TF5ZERk8Gbd2TK+E7ZSmBafPcI7B/wxwDmtk=;
 b=RnjmYx2HXLBBrPBd3OuDkMPi9EdAxys24iqfECDMS5G1XhjpmtHKakmFXPdyLYKi/1
 +GIbzJ1UqEDkI3/KsNNXqpUc3yPfUxYbb3PCM8VJcOACoRJdbJ0BnXWaep5D/1R+snlB
 FMaN79Q2P7X9oePTNpj3T1Xs/H4kE5GFGRHWgk8NLbiX9AI5PaORkfFK6VR5g6gjtqTB
 42aixGKyJyCq/O5I8QhRd2kY1m5i29ji+kkjfkfP+5ZouUGxeE7+chO0k17A1f9Aagvq
 J8b4v1VTBskOZJ8/2iX9Rm2H8MAX0PDqMXvCBP7XW8670KKwcu1lmiq141Oi3xsSG+UM
 PRYg==
X-Gm-Message-State: APuU4Z/v2LbBp4qqutWp2s66eb1ZDpzOE8Z0iPpIx4l5MG8Eh7R+WOm4
 Jo2iEqb2DjN4PuI4L2zDrdBRzLH72k7hMH3qjxenraWCXm212Syyc/Ml
X-Gm-Gg: AYBFou3iz8ALQbMBkdEoP7ZHXbE1mMXb4FFnukKtsBuZk9M8vvE28lJoWgQWCuBE5CY
 V/5ErovnHM/4Ok4415pBw+kUNhf50rMd1vmF0+W01QfR4mrHvFcI1fOAWHhHLnySxuHgqTlXjO5
 kjc4GJu2CGhxjU11NYou188iegUWfH/jt63iROmHbaf2eYPv6nLx3XF0k/cUZABOlsktUoSHAfo
 FEkyeUEp6B7Bh9WbEeszL6c+uwRGtl7vLw3Nq0ll2NdMxMdQkmcI4ImLDZFcAqcjlBK/siilGg1
 zZmezlgn8W/QYJ4bLvbogJdNZDKtgrWnuh1tYcLWi2jijZRPe7BZ9sWwvYf3yiVFSxfebWBsGHI
 LUbxbEVBN220qEQ+bCnI0cu12pWp4AUj+RqrZAkdoAkXjbYUOhjQuxZvq57JGUjOOyByNnbHrO/
 J7GKlABot79UPE1VdSW4HkDKdbkzTBNFG/Wsy62ev2EqcH5Ji/jCWkEscRRmA+C1r80R5+YtWsj
 yJSzUV6vjHpKIR31rkf76AlfGHxZo1WAYUvkYkvXt3RUZrX8eTCAJAkRIMxaZM1bF0A+tub3rZU
 bCy2nnj6VirigKy/W5+c8xHb5Xd4rXq9
X-Received: by 2002:a17:907:c23:b0:c2e:3a72:ffbd with SMTP id
 a640c23a62f3a-c4ca7ad10edmr1435922466b.41.1793796693885; 
 Wed, 04 Nov 2026 04:51:33 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e140f93sm65938966b.6.2026.11.04.04.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:33 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 11/14] disk: part_dos: Number at most 255 partitions, as
 Linux does
Date: Wed, 04 Nov 2026 12:51:32 +0000
Message-ID: <c6adb9f0-ca33-4d3d-9f33-ce211ca84e81@gmail.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

part_get_info_extended() makes up the UUID of a DOS partition as
"%08x-%02x" from the disk signature and the partition number, into a
buffer of 12 bytes. That is enough up to partition 255, the most Linux
numbers (DISK_MAX_PARTS - 1), so that its MSDOS UUID always takes 11
characters. But MAX_EXT_PARTS lets the number reach 256, and as it is
checked once per table, the entries of the last table read can take
it up to 259: their three digits make sprintf() write the terminating
NUL past the end of the buffer.

Lower MAX_EXT_PARTS to 255 and check it before each entry, as Linux's
parse_extended() does, so that no partition gets a higher number and
every UUID keeps its 11 characters.

Add a test with 256 partitions, which catches the overflow on sandbox
with CONFIG_ASAN.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v4:
- Number at most 255 partitions, as Linux does, so that the UUID keeps
  its 11 characters, rather than making room for a three-digit
  partition number (Heinrich): lower MAX_EXT_PARTS to 255 and check it
  before each entry, and test that there is no partition 256; new
  subject, and drop Simon's Reviewed-by

 disk/part_dos.c | 13 ++++++-----
 test/dm/part.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index bc40d9d2829..bd9504a05bb 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -24,9 +24,12 @@
 
 #define DOS_PART_DEFAULT_SECTOR 512
 
-/* should this be configurable? It looks like it's not very common at all
- * to use large numbers of partitions */
-#define MAX_EXT_PARTS 256
+/*
+ * Number at most 255 partitions, as Linux does (DISK_MAX_PARTS - 1), so
+ * that the UUID made up for each from the disk signature and the partition
+ * number, "%08x-%02x", takes 11 characters
+ */
+#define MAX_EXT_PARTS 255
 
 /*
  * A link to the next extended partition table adds no partition, so tables
@@ -214,7 +217,7 @@ static void print_partition_extended(struct blk_desc *desc,
 
 		/* Print all primary/logical partitions */
 		pt = (dos_partition_t *)(buffer + DOS_PART_TBL_OFFSET);
-		for (i = 0; i < 4; i++, pt++) {
+		for (i = 0; i < 4 && part_num <= MAX_EXT_PARTS; i++, pt++) {
 			/*
 			 * fdisk does not show the extended partitions that
 			 * are not in the MBR
@@ -302,7 +305,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 
 		/* Print all primary/logical partitions */
 		pt = (dos_partition_t *)(buffer + DOS_PART_TBL_OFFSET);
-		for (i = 0; i < 4; i++, pt++) {
+		for (i = 0; i < 4 && part_num <= MAX_EXT_PARTS; i++, pt++) {
 			/*
 			 * fdisk does not show the extended partitions that
 			 * are not in the MBR
diff --git a/test/dm/part.c b/test/dm/part.c
index 4938d962144..89190d8bed6 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -423,3 +423,62 @@ static int dm_test_part_dos_ext_empty(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_dos_ext_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/*
+ * As Linux, number at most 255 DOS partitions, so that the UUID made up for
+ * each from the disk signature and the partition number takes 11 characters
+ */
+static int dm_test_part_dos_uuid(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	dos_partition_t pt[4];
+	struct blk_desc *desc;
+	int part;
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
+		return -EAGAIN;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	ut_asserteq(512, desc->blksz);
+
+	/* an extended partition from sector 2 */
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 512);
+	ut_assertok(dos_write_table(desc, 0, pt));
+
+	/*
+	 * holding logical partitions 5 to 256, each of one sector after its
+	 * table, with the tables two sectors apart from sector 2 on
+	 */
+	for (part = 5; part <= 256; part++) {
+		memset(pt, '\0', sizeof(pt));
+		dos_set_entry(&pt[0], 0x83, 1, 1);
+		if (part < 256)
+			dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED,
+				      (part - 4) * 2, 2);
+		ut_assertok(dos_write_table(desc, 2 + (part - 5) * 2, pt));
+	}
+
+	ut_assertok(part_get_info_by_type(desc, 255, PART_TYPE_DOS, &info));
+	ut_asserteq(2 + 250 * 2 + 1, info.start);
+	ut_asserteq_str("00000000-ff", disk_partition_uuid(&info));
+	ut_assert_console_end();
+
+	/* there is no partition 256 */
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type(desc, 256, PART_TYPE_DOS, &info));
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	/* and listing them stops at partition 255 too */
+	part_init(desc);
+	ut_asserteq(PART_TYPE_DOS, desc->part_type);
+	part_print(desc);
+	ut_assert_skip_to_line("%3d\t%-10d\t%-10d\t%08x-%02x\t%02x", 255,
+			       2 + 250 * 2 + 1, 1, 0, 255, 0x83);
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
