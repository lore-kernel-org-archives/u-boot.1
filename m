Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407F606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qc326/iH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LUxRM05D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33C9660837;
	Wed,  4 Nov 2026 12:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQsagsGieVOV; Wed,  4 Nov 2026 12:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54A1D6070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796706;
	b=Hq4VBc5TLwjtk82gCIvi3BzpLqi4RRYMa5y8ewXHmo0cnlL4jq+z7V3Nmo7UIv/n28qt
	 wBkfbbx8q1QKBwcRNxo+0uRehNGaDlWZVawcMonDkhuvUttwoUTrWgJTn0CpbopfnkEB0
	 nJu4mZWy0PnEVSWdxWl3A2Gcz9Fn9jKnVO+R0bodIAYkjoIKLK6XRAIdbciMObsB0V8Qd
	 nCj3Lcf4KooqBaJJDohVLu/yZDNXN83ntYAKeFGkwnFcUHlBj0xBW2v2JD/UKDFElGD7R
	 arPC6RG0g4S6K8BA+DZxfrjIubSG+3H7De7X8K/ADIoHqhF9MKxKPlpsHokqtfr29lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/UvKdURZU4Xbmiq+latld724ZTIx0Skxik4dDH4uZ5k=;
	b=ZYBcRVVWQcMkytFqxl4u5zk8KuYq2qcGew74o1I06wcGtWQQMFRoKP42KeJXf36H/AKO
	 u86b/bJuqVagigkzNZHSl391/8NfTx4SntAEFZIME5jjuvun7cBrgRBABrjT3ZBFEn9C6
	 F3HmIZdkA+Kzy4fBYXNGbYIEfTJ33y/WRG6fmY6Yx4oZpA7ZHE1TN08+xbJPFLUKH0CEp
	 CvU0HKWRp+75I9Ycp+gdMqNI7WoCX6CAd3741djt66sh9Arzekuex6dtdHAAxo12TknDX
	 WOXUtJZDnTL3P3vZLQaQ9rOBCDND9oJ+3RUYfYEVGQ3u9b3daYf61bOqDtSNLSyOOEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LUxRM05D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796706;
	bh=/UvKdURZU4Xbmiq+latld724ZTIx0Skxik4dDH4uZ5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qc326/iH0fC41PKNOe+aF1jqNgSnicboR/oxNmxdvzYSm7E+IHRcC56PzkcQOuJxd
	 0n9TlxT3sopsO5m55J/dg245f6XhxOOPRoDrOcf/an2YyCQ+ZqDilsSzDO/QG0njQA
	 A/tFKM+4QprjMG08nz8vPr2nI6NvpvcDPhfO90vTASDVzrArxRU6Cb0eMHKeEilHGJ
	 IHSuvyPzInuH0KXuPeQv2Qb6dV+vek7avZlS7VjUYWEeWqZweimI0/ga5PiyXzEBvr
	 v22SUovhreW+vFYstZebDSQf0WJ6DLEgc2Y8vl1d911WIhvAqmuvq9w2wowOdgBLZf
	 2d2JmDriyFUeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54A1D6070E;
	Wed,  4 Nov 2026 12:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADDD5341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F4E86070E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEAw4AZIeu40 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF8EA605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796703;
 b=Q6V+IcNBIke2C2Hw1k8Bsc3XuQC9uNbM5ZJJSAx8rFnHRhn9vSliz3tvCH56zgCnfap1
 ooJCfv8iNj2GJX3Pe+yMALo0uShckOxPU+xOI0G54gYjnO4aBWx40f4tcA7GX/zmpPUX5
 jlDciRWfn5USG3y4HSWKM2VIfvEtS0MX7zIqHBhg/UaA5e0vUysbcx3OYP6+/9cs+zv1a
 CZ5vSUXyFxVR2cMY/2dAYKT/JnvOy7ZSqnlYs6C32Y4h22nm4KcqhSMXOSbUp8Ukd3stp
 a0RQn6DqZsCXKKutuMceLKSO1Ysgw9PWVBoVyOmbqe4OCflyYIBGhfvnIAg4BcR6rKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796703;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/UvKdURZU4Xbmiq+latld724ZTIx0Skxik4dDH4uZ5k=;
 b=NfzKIlzH4M9UGmt/v+imPil5kdZffN7UtxKkWjdVI3Kw91Nh7jU5DjEB5lxmlIV8TTZh
 Uf9lhPV+72Hrgvr+FO0+zYDfaXyR298WB35eHD+oJbxzwaNDYDZbJdOhNbbI0el08IATs
 Dm0RBpndKVDMop3iZFTaCmTwQa8msndA8mtoyEqwTGWyEY+heZ9toEuGP4uUSgoAu/wsi
 DXURWgIB18w56TR6vbQUEODB9CXo+sYYEocdTI66QzJBLaqEF8kMLjk2DpWT6bD81BxGL
 mpNUHgBv9fiLkRGCXaDscEGxGL1fSYtTRnWIEEO5bSaB44SUQqGWGtCwXZlWKAzKaeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LUxRM05D; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LUxRM05D
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF8EA605DA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:42 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so781908a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796700; x=1794401500;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/UvKdURZU4Xbmiq+latld724ZTIx0Skxik4dDH4uZ5k=;
 b=LUxRM05D5U29lfnFF5586xqjnPG+MSaMBefrr6ajQc3tHuJZBjI9StTL4hYHx/OGAC
 zQ1HP5N2aggdUduIKsfUGNZpjRIas+gUNFR6rMHY4lRImJWeaJa9lSiSwyh7PKKhqXK/
 tqgaFmYAyXTA5DxWXnhtcTwT2cgpdt0kgiVFxGx4HguDrOmdpmjLDgdJeARBEpQP+cfJ
 hib+c+IBkItNY3yuyAsvK1tu04byBmltRQ05hmIuvawW0pwLq9hV0ZWzB4UKib/xSdZJ
 9fvwgsf0Nd1Tyg2COb9bRycSairvAqymmnCZEtevjVwOWh8WZj/Ua10KkMxeC5423kMo
 XzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796700; x=1794401500;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/UvKdURZU4Xbmiq+latld724ZTIx0Skxik4dDH4uZ5k=;
 b=bfN4nZVUIHi9WYfmmg6P1RWrsvLTgxnwzLOIJ3IMkQlJ7+9O0saV3jUqqxsetBtFS1
 mzA3wuWeh40O+HUUD3hagEogsf3l4B9TvfUKujYg24OOdfA4BivmRlbsosregFo7Q6nR
 TfNaUzeBDVFD8v19nCBhfODyrsvEo/04IUWV4NHPxeriNtuZoUw19w+kL0hsXrY5zxtX
 0HjdMbHSDMwiABVSLPlORs7i0RsSE3HkqeXJGqfYDZeZ1+MqAV+jQ9odUmDaTxeX3zxl
 a5roiaqivdllEBGobzrP82PeBLXNtyRx5upi6xwBtsJ3EeW870sfKTG1LvnCWnre++bK
 cwKg==
X-Gm-Message-State: APuU4Z+Exm8p7ZqvjnPdEeJq2AloZ5IbWSiIg5723P38FR2OJprYHQth
 r0CLz/Nyu6nbtfZ0pxWWBy+RJbuly0Y7jsDLhw6SodFO3pXU7di+PmVhK0F7z6G/F6M=
X-Gm-Gg: AYBFou3MoxQ/czYa747CiJTmXvOliWZ8Sjk+fdvILBPqpIPGAY4QQx9/LRArUzJu4eh
 wVBZPiVDVzisIgqMAy5XgVJHcmxp1cGVt2+sZtWf6rzYiHARUbsYnoTS/LboKw9RAcOTCI1K3QD
 DBifQhMyFAAV+p7CMHGTlG/4pkZz+ij0zXDLY7mKUFj++BE3V9xaaG2V/troZtVE8Jxqa29Ga4L
 7l0fSd0j4UEWQGxStz8nDGJFHBWgEyMqSqruY9ZqlniubRL66w25Y4Gc0tX1cDQ+Dv9neh/5CsM
 I0ORA7cvY+omSBqPjapqyIQ9dJ7Jygbqpq+MOcTaKZ8lf8EtgSG2/txCnjRQHdqr6dF9MKg5RWJ
 8+zbVHtja7gwMswDIk0bzg+f+1J1x2WjXw6KOszTTLP3/m2ue8ih1hrj/JnFi9C6b6lQM8Jid8M
 oQwUAQh2F0fHztgTJM5Z2so8pYnBXfXXRyalSyAZfXYJA8m65GaRUxQZhHk0nZAhEvwfsiW5BAA
 Hd1vqZZzSJjZbtQzpYHrZGYN7JWTOXzvL0Uzh4FFASPP2YGbIjgzNzYZTlcS5HccP0HQVBgaRxU
 k9+WkdY4XPyG57U9MOfg2lubY+0KiRM=
X-Received: by 2002:a17:906:ef0b:b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c4ca7acfb4cmr1480916066b.43.1793796700375; 
 Wed, 04 Nov 2026 04:51:40 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e46a465sm67017166b.58.2026.11.04.04.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:39 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 12/14] efi_loader: Measure the GPT the partition driver uses
Date: Wed, 04 Nov 2026 12:51:38 +0000
Message-ID: <1ec766e6-46f2-4cb5-ab1b-50f37bf5d86e@gmail.com>
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

tcg2_measure_gpt_data() reads the primary GPT and measures it into
PCR 5 without checking it, while the partition driver uses the backup
GPT when the primary header or entries are not valid. So PCR 5 may hold
a GPT the partitions were not found in: a change to an unused primary
entry, which is not measured, leaves PCR 5 as it was while the
partitions come from the backup GPT. Nor are the sizes in the header
checked, so an entry array size that wraps in 32 bits makes the walks
read past the end of the entry buffer.

Measure the GPT the partitions are found in, read by the partition
driver's own code through a new part_get_gpt(), which checks the sizes
too. When the primary GPT is not valid, measure the backup header as
the primary header that 'gpt repair' writes from it, so that PCR 5 is
as for the repaired disk; a primary header marked to be ignored
(ChromeOS) is never repaired, so measure the backup header as it is
then. If no valid GPT is read, measure no GPT event but return success,
so that the separators are still measured.

EDK2 measures the GPT its partition driver uses too, since 7c12d4359abd
("SecurityPkg/DxeTpm2MeasureBootLib: Use GptLib parser"), with the
primary header that driver restores from the backup.

Add a sandbox test that checks PCR 5 for a valid GPT, an entry array
size that wraps, a backup GPT that differs from a broken primary one
and an ignored primary header, and check part_get_gpt() in
lib_test_gpt_sizes.

Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v3)

Changes in v3:
- Rename part_get_gpt_primary() to part_get_gpt(), and say in its
  comment when a backup header is turned into a primary one (Simon)
- When the primary header is marked IGNOREME (ChromeOS), measure the
  backup header as it is, since gpt repair never rebuilds the primary
  one then, and correct the comment and commit message that said
  otherwise (Simon); test that case too
- Name the device in the warning when no valid GPT is read (Simon)
- Shorten the commit message (Simon)

Changes in v2:
- New subject: measure the GPT the partition driver uses, read with its
  own code through a new part_get_gpt_primary(), so that the CRC of the
  entries is checked too, as EDK2 does (Simon)
- When the partitions come from the backup GPT, measure that, with the
  primary header gpt repair makes from it, rather than no GPT, as EDK2
  measures the GPT its partition driver restores (Ilias)
- Say in the commit message what the bug does to PCR 5 (Ilias)
- Keep validate_gpt_header() static, as efi_tcg2 no longer reads the GPT
  itself
- Test a backup GPT that differs from the primary one, and rename the
  test to test_efi_tcg2_gpt

 disk/part_efi.c                |  27 ++++
 include/part.h                 |  27 ++++
 lib/efi_loader/efi_tcg2.c      |  52 ++++---
 test/lib/part_efi.c            |  61 +++++++-
 test/py/tests/test_efi_tcg2.py | 246 +++++++++++++++++++++++++++++++++
 5 files changed, 385 insertions(+), 28 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 85945634915..a274a268764 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -875,6 +875,33 @@ int gpt_repair_headers(struct blk_desc *desc)
 	return ret;
 }
 
+int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry **gpt_pte)
+{
+	int r;
+
+	/* Find the GPT as find_valid_gpt() does */
+	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h, gpt_pte);
+	if (r == 1)
+		return 0;
+
+	if (is_gpt_valid(desc, desc->lba - 1, gpt_h, gpt_pte) != 1) {
+		/* is_gpt_valid() may leave a freed array here */
+		*gpt_pte = NULL;
+		return -EINVAL;
+	}
+
+	/*
+	 * If the primary GPT is not valid, give the backup header as the
+	 * primary header that gpt_repair_headers() writes from it. A primary
+	 * header marked to be ignored (ChromeOS) is never repaired, so give
+	 * the backup header as it is then.
+	 */
+	if (r != 2)
+		restore_primary_gpt_header(gpt_h, desc);
+
+	return 0;
+}
+
 int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte)
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..4b1d40511db 100644
--- a/include/part.h
+++ b/include/part.h
@@ -680,6 +680,33 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
  */
 int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
 
+/**
+ * part_get_gpt() - Get the GPT the partitions of a disk are found in
+ *
+ * Read the GPT as the partition driver does: the primary one if it is valid,
+ * else the backup one. If the primary GPT is not valid, the backup header is
+ * turned into the primary header that gpt_repair_headers() writes from it. If
+ * the primary header is marked to be ignored (ChromeOS 'IGNOREME'), the backup
+ * header is given as it is. Nothing is written to the disk.
+ *
+ * @desc:	block device descriptor
+ * @gpt_h:	buffer of @desc->blksz bytes, filled with the header
+ * @gpt_pte:	set to the partition entries, which the caller frees, or to
+ *		NULL on error
+ *
+ * Return:	0 on success, -EINVAL if no valid GPT was read from the disk,
+ *		-ENOSYS if GPT support is not built in
+ */
+int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry **gpt_pte);
+
+#else
+static inline int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h,
+			       gpt_entry **gpt_pte)
+{
+	*gpt_pte = NULL;
+
+	return -ENOSYS;
+}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 5f9bbe97455..97fce462138 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -16,6 +16,8 @@
 #include <efi_tcg2.h>
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
+#include <part.h>
 #include <smbios.h>
 #include <version_string.h>
 #include <tpm_api.h>
@@ -1157,11 +1159,11 @@ tcg2_measure_gpt_data(struct udevice *dev,
 {
 	efi_status_t ret;
 	efi_handle_t handle;
-	struct efi_handler *dp_handler, *io_handler;
+	struct efi_handler *dp_handler;
 	struct efi_device_path *orig_device_path;
 	struct efi_device_path *device_path;
 	struct efi_device_path *dp;
-	struct efi_block_io *block_io;
+	struct blk_desc *desc;
 	struct efi_gpt_data *event = NULL;
 	efi_guid_t null_guid = NULL_GUID;
 	gpt_header *gpt_h;
@@ -1170,7 +1172,6 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	u32 num_of_valid_entry = 0;
 	u32 event_size;
 	u32 i;
-	u32 total_gpt_entry_size;
 
 	ret = efi_search_protocol(&loaded_image->header,
 				  &efi_guid_loaded_image_device_path,
@@ -1202,40 +1203,37 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	if (ret != EFI_SUCCESS)
 		goto out1;
 
-	ret = efi_search_protocol(handle, &efi_block_io_guid, &io_handler);
-	if (ret != EFI_SUCCESS)
+	/*
+	 * Measure the GPT the partitions were found in: read it with the
+	 * partition driver's own code, which checks it and uses the backup GPT
+	 * if the primary one is not valid. Only a block device of U-Boot's has
+	 * partitions found by it.
+	 */
+	if (!handle->dev || device_get_uclass_id(handle->dev) != UCLASS_BLK) {
+		log_debug("Not a U-Boot block device, GPT not measured\n");
+		ret = EFI_SUCCESS;
 		goto out1;
-	block_io = io_handler->protocol_interface;
+	}
+	desc = dev_get_uclass_plat(handle->dev);
 
-	gpt_h = memalign(block_io->media->io_align, block_io->media->block_size);
+	gpt_h = malloc_cache_aligned(desc->blksz);
 	if (!gpt_h) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out2;
 	}
 
-	ret = EFI_CALL(block_io->read_blocks(block_io,
-					     block_io->media->media_id, 1,
-					     block_io->media->block_size,
-					     gpt_h));
-	if (ret != EFI_SUCCESS)
-		goto out2;
-
-	/* read GPT entry */
-	total_gpt_entry_size = gpt_h->num_partition_entries *
-			       gpt_h->sizeof_partition_entry;
-	entry = memalign(block_io->media->io_align, total_gpt_entry_size);
-	if (!entry) {
-		ret = EFI_OUT_OF_RESOURCES;
+	/*
+	 * The disk may have changed since its partitions were found, or not
+	 * read. Measure no GPT then, but return success, as an error would
+	 * skip the separators.
+	 */
+	if (part_get_gpt(desc, gpt_h, &entry)) {
+		log_warning("%s: No valid GPT read, not measured\n",
+			    handle->dev->name);
+		ret = EFI_SUCCESS;
 		goto out2;
 	}
 
-	ret = EFI_CALL(block_io->read_blocks(block_io,
-					     block_io->media->media_id,
-					     gpt_h->partition_entry_lba,
-					     total_gpt_entry_size, entry));
-	if (ret != EFI_SUCCESS)
-		goto out2;
-
 	/* count valid GPT entry */
 	gpt_e = entry;
 	for (i = 0; i < gpt_h->num_partition_entries; i++) {
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 42de9109360..696b73f28a7 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -328,6 +328,7 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 	struct blk_desc *desc;
 	struct udevice *blk;
 	gpt_entry *gpt_pte;
+	gpt_header orig, written, backup;
 	void *entries;
 	int i, ret;
 
@@ -341,6 +342,8 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 	disk_partition_set_uuid(&parts[0],
 				"a2a0d0eb-e5b9-3344-87c0-68b6b72699c7");
 	ut_assertok(gpt_restore(desc, str_disk_guid, parts, 1));
+	ut_asserteq(1, blk_dread(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1, hdr));
+	memcpy(&orig, hdr, sizeof(orig));
 
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		u32 header_size = cases[i].header_size;
@@ -365,6 +368,22 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 						      header_size));
 		ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
 					  1, hdr));
+		memcpy(&written, hdr, sizeof(written));
+
+		/*
+		 * efi_tcg2 measures the GPT this gives: the header just
+		 * written if it is valid, else the backup header turned into
+		 * the primary one, which is then the header gpt_restore() wrote
+		 */
+		memset(hdr, '\0', 2 * blksz);
+		gpt_pte = NULL;
+		ret = part_get_gpt(desc, hdr, &gpt_pte);
+		free(gpt_pte);
+		ut_assertf(!ret, "case %d: GPT not found: %d\n", i, ret);
+		if (cases[i].ret)
+			ut_asserteq_mem(&orig, hdr, sizeof(gpt_header));
+		else
+			ut_asserteq_mem(&written, hdr, sizeof(gpt_header));
 
 		/*
 		 * Read it back into a buffer as large as the one above, so
@@ -396,6 +415,45 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 		ut_asserteq_64(parts[0].size, info.size);
 	}
 
+	/*
+	 * A primary header marked to be ignored is never repaired, so the
+	 * backup header is given as it is
+	 */
+	memset(hdr, '\0', 2 * blksz);
+	memcpy(hdr, &orig, sizeof(orig));
+	hdr->signature = cpu_to_le64(GPT_HEADER_CHROMEOS_IGNORE);
+	ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1,
+				  hdr));
+	ut_asserteq(1, blk_dread(desc, lba - 1, 1, hdr));
+	memcpy(&backup, hdr, sizeof(backup));
+	memset(hdr, '\0', 2 * blksz);
+	gpt_pte = NULL;
+	ret = part_get_gpt(desc, hdr, &gpt_pte);
+	free(gpt_pte);
+	ut_assertok(ret);
+	ut_asserteq_64(lba - 1, le64_to_cpu(hdr->my_lba));
+	ut_asserteq_mem(&backup, hdr, sizeof(gpt_header));
+
+	/*
+	 * With the primary header valid again but not its entries, and the
+	 * backup header broken, there is no GPT left, and no entries either
+	 */
+	memset(hdr, '\0', 2 * blksz);
+	memcpy(hdr, &orig, sizeof(orig));
+	ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1,
+				  hdr));
+	ut_asserteq(1, blk_dread(desc, le64_to_cpu(orig.partition_entry_lba),
+				 1, hdr));
+	((gpt_entry *)hdr)->partition_name[0] ^= 1;
+	ut_asserteq(1, blk_dwrite(desc, le64_to_cpu(orig.partition_entry_lba),
+				  1, hdr));
+	ut_asserteq(1, blk_dread(desc, lba - 1, 1, hdr));
+	hdr->signature = 0;
+	ut_asserteq(1, blk_dwrite(desc, lba - 1, 1, hdr));
+	gpt_pte = (gpt_entry *)hdr;
+	ut_asserteq(-EINVAL, part_get_gpt(desc, hdr, &gpt_pte));
+	ut_assertnull(gpt_pte);
+
 	return 0;
 }
 
@@ -403,7 +461,8 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
  * A GPT header gives its own size and the size of its partition entries, and
  * its CRCs cover only what those say, so a CRC does not show that either size
  * is one the parser can use. Check that a primary header with a size the
- * parser cannot use is refused, CRCs or not, and that the backup is used.
+ * parser cannot use is refused, CRCs or not, and that the backup is used, for
+ * the GPT efi_tcg2 measures too.
  */
 static int lib_test_gpt_sizes(struct unit_test_state *uts)
 {
diff --git a/test/py/tests/test_efi_tcg2.py b/test/py/tests/test_efi_tcg2.py
new file mode 100644
index 00000000000..4a17b839ab4
--- /dev/null
+++ b/test/py/tests/test_efi_tcg2.py
@@ -0,0 +1,246 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+"""Test the measurements made by the EFI_TCG2_PROTOCOL on sandbox
+
+The sandbox TPM starts with every PCR clear, and the events measured when an
+EFI application is started (boot variables, GPT, separators) are only measured
+the first time one is. So each case restarts U-Boot, starts one application
+and checks PCR 5 against the events it should then hold.
+"""
+
+import hashlib
+import os
+import re
+import shutil
+import struct
+import zlib
+
+import pytest
+
+import utils
+from tests.fs_helper import FsHelper
+
+# EFI System Partition
+ESP_TYPE = 'C12A7328-F81F-11D2-BA4B-00A0C93EC93B'
+SECTOR = 512
+
+# Fields of the GPT header, by offset
+GPT_HEADER_SIZE = 92
+GPT_HDR_SIZE_OFF = 12
+GPT_HDR_CRC_OFF = 16
+GPT_ALTERNATE_OFF = 32
+GPT_ENTRIES_OFF = 72    # partition_entry_lba, num_partition_entries, ...
+GPT_NUM_ENTRIES_OFF = 80
+GPT_ENTRY_SIZE = 128
+
+
+def extend(pcr, data):
+    """Extend a SHA256 PCR value with the digest of some data
+
+    Args:
+        pcr (bytes): PCR value before
+        data (bytes): Event data
+
+    Returns:
+        bytes: PCR value after
+    """
+    return hashlib.sha256(pcr + hashlib.sha256(data).digest()).digest()
+
+
+def make_gpt_disk(ubman, fname):
+    """Write a GPT disk image with helloworld.efi on its only partition
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+    """
+    with FsHelper(ubman.config, 'vfat', 1, 'tcg2') as fsh:
+        shutil.copy(os.path.join(ubman.config.build_dir,
+                                 'lib/efi_loader/helloworld.efi'),
+                    fsh.srcdir)
+        fsh.mk_fs()
+        with open(fsh.fs_img, 'rb') as inf:
+            fs_data = inf.read()
+
+    # 1MiB for the primary GPT, the partition, 1MiB for the backup GPT
+    with open(fname, 'wb') as outf:
+        outf.truncate((2 << 20) + len(fs_data))
+    utils.run_and_log(ubman, f'sfdisk {fname}',
+                      stdin=(f'label: gpt\nstart=2048, '
+                             f'size={len(fs_data) // SECTOR}, '
+                             f'type={ESP_TYPE}\n').encode())
+    with open(fname, 'r+b') as outf:
+        outf.seek(1 << 20)
+        outf.write(fs_data)
+
+
+def gpt_event(fname, backup=False):
+    """Get the EV_EFI_GPT_EVENT data for a GPT of a disk image
+
+    Args:
+        fname (str): Filename of the disk image
+        backup (bool): True for the backup GPT, as it is on the disk, else
+            the primary one
+
+    Returns:
+        bytes: The header, the number of partitions, then their entries
+    """
+    with open(fname, 'rb') as inf:
+        disk = inf.read()
+    start = (len(disk) - SECTOR) if backup else SECTOR
+    hdr = disk[start:start + GPT_HEADER_SIZE]
+    entry_lba, num, size = struct.unpack_from('<QII', hdr, GPT_ENTRIES_OFF)
+    entries = []
+    for i in range(num):
+        start = entry_lba * SECTOR + i * size
+        entry = disk[start:start + size]
+        if any(entry[:16]):
+            entries.append(entry)
+    return hdr + struct.pack('<Q', len(entries)) + b''.join(entries)
+
+
+def set_num_entries(fname, num):
+    """Set num_partition_entries in the primary GPT header and fix its CRC
+
+    Args:
+        fname (str): Filename of the disk image
+        num (int): Number of partition entries
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        hdr = bytearray(outf.read(SECTOR))
+        struct.pack_into('<I', hdr, GPT_NUM_ENTRIES_OFF, num)
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF, 0)
+        hdr_size = struct.unpack_from('<I', hdr, GPT_HDR_SIZE_OFF)[0]
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF,
+                         zlib.crc32(hdr[:hdr_size]))
+        outf.seek(SECTOR)
+        outf.write(hdr)
+
+
+def ignore_primary(fname):
+    """Mark the primary GPT header to be ignored, as ChromeOS does
+
+    Args:
+        fname (str): Filename of the disk image
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        outf.write(b'IGNOREME')
+
+
+def corrupt_entries(fname):
+    """Change an unused entry of the primary GPT, leaving the header as it is
+
+    The CRC of the entries in the header no longer matches them.
+
+    Args:
+        fname (str): Filename of the disk image
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        hdr = outf.read(GPT_HEADER_SIZE)
+        entry_lba = struct.unpack_from('<Q', hdr, GPT_ENTRIES_OFF)[0]
+        # the name of the second entry, whose type GUID stays zero
+        outf.seek(entry_lba * SECTOR + GPT_ENTRY_SIZE + 56)
+        outf.write(b'x')
+
+
+def copy_backup_gpt(src, dst):
+    """Copy the backup GPT of a disk image to another of the same size
+
+    Args:
+        src (str): Filename of the disk image to copy it from
+        dst (str): Filename of the disk image to copy it to
+    """
+    with open(src, 'rb') as inf:
+        inf.seek(SECTOR)
+        hdr = inf.read(GPT_HEADER_SIZE)
+        backup_lba = struct.unpack_from('<Q', hdr, GPT_ALTERNATE_OFF)[0]
+        inf.seek(backup_lba * SECTOR)
+        hdr = inf.read(GPT_HEADER_SIZE)
+        entry_lba = struct.unpack_from('<Q', hdr, GPT_ENTRIES_OFF)[0]
+        inf.seek(entry_lba * SECTOR)
+        data = inf.read()
+    with open(dst, 'r+b') as outf:
+        outf.seek(entry_lba * SECTOR)
+        outf.write(data)
+
+
+def boot_and_read_pcr5(ubman, fname):
+    """Start helloworld.efi from a disk image on a fresh U-Boot
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+
+    Returns:
+        bytes: PCR 5 after the application has run
+    """
+    addr = utils.find_ram_base(ubman) + (4 << 20)
+    ubman.restart_uboot()
+    ubman.run_command(f'host bind 0 {fname}')
+    output = ubman.run_command(f'load host 0:1 {addr:x} helloworld.efi')
+    assert 'bytes read' in output
+    output = ubman.run_command(f'bootefi {addr:x}')
+    assert 'Hello, world!' in output
+    output = ubman.run_command(f'tpm2 pcr_read 5 {addr:x}')
+    assert 'PCR #5 sha256 32 byte content' in output
+    digest = output.split('content', 1)[1].split('\n', 1)[1]
+    return bytes.fromhex(''.join(re.findall(r'\b[0-9a-f]{2}\b', digest)))
+
+
+@pytest.mark.boardspec('sandbox')
+# EFI applications are built with the sanitizer but cannot run with it
+@pytest.mark.notbuildconfigspec('asan')
+@pytest.mark.buildconfigspec('efi_tcg2_protocol')
+@pytest.mark.buildconfigspec('efi_partition')
+@pytest.mark.buildconfigspec('cmd_tpm_v2')
+@pytest.mark.buildconfigspec('bootefi_hello_compile')
+def test_efi_tcg2_gpt(ubman):
+    """Check that PCR 5 holds the GPT the partitions are found in
+
+    PCR 5 holds the GPT event and then the separator. When the partition
+    driver refuses the primary GPT, it finds the partitions in the backup
+    one, and the GPT event holds that, with the primary header it restores,
+    or the backup header as it is when the primary one is marked to be
+    ignored.
+    """
+    fname = os.path.join(ubman.config.persistent_data_dir, 'tcg2_gpt.img')
+    other = os.path.join(ubman.config.persistent_data_dir, 'tcg2_other.img')
+    separator = struct.pack('<I', 0)
+    try:
+        make_gpt_disk(ubman, fname)
+        expect = extend(extend(bytes(32), gpt_event(fname)), separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # an entry array whose size comes to one block in 32 bits: the
+        # backup GPT is the same GPT, so PCR 5 is too
+        set_num_entries(fname, (1 << 32) // GPT_ENTRY_SIZE +
+                        SECTOR // GPT_ENTRY_SIZE)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # a backup GPT whose partition has another GUID, and primary entries
+        # that do not match their CRC, though the change is in an unused
+        # entry, which is not measured
+        make_gpt_disk(ubman, fname)
+        shutil.copy(fname, other)
+        utils.run_and_log(ubman, f'sfdisk --part-uuid {other} 1 '
+                          '0a6a1f54-1b55-4d0c-9a52-6d1e5e0e5d01')
+        expect = extend(extend(bytes(32), gpt_event(other)), separator)
+        copy_backup_gpt(other, fname)
+        corrupt_entries(fname)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # a primary header marked to be ignored, which is never repaired:
+        # PCR 5 holds the backup GPT as it is
+        make_gpt_disk(ubman, fname)
+        ignore_primary(fname)
+        expect = extend(extend(bytes(32), gpt_event(fname, backup=True)),
+                        separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+    finally:
+        for path in (fname, other):
+            if os.path.exists(path):
+                os.remove(path)
+        ubman.restart_uboot()
