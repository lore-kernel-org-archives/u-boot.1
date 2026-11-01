Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843A606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FCVQqErY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n3IFRX8v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B01EA60602;
	Sun,  1 Nov 2026 07:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5867GrjJNHi; Sun,  1 Nov 2026 07:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00A25607E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516592;
	b=tbym0Yjr/QVRhnEKwTnP4aXKgPQtlDH8eI8qQ+94T5S20xfTgeEnB0wceNedFJjIj8O/
	 QlC7HOPqPrPTOfbbfjRgrfKAzriAmXybD4tE5nK9kRe39pSAX9TYVgdnx4T4B6QrvVwng
	 yzMBHB+PpAA+HOhXCth482ZJhHOjTbFtOQc4SRT9QwlnMagaW4mf77QeYB1V30Zb+vhoK
	 1b0AzXMX/ynmIoBYW8Mw4v2RS5m2JfE8DtA12Df41K0NfRNs6uM3pwpgzp5gyQQN4aycd
	 cxxXFPLbN5LyigciRvAN0hQOr/SCZduFwXc03HmUQoo9LREM91vxuNvEnNhULtVoQGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=guC+2E17GgnDMltamcxsBEkXyroTf1d9MHVenGqI/Pg=;
	b=QAfCdaRfXbSBgUiOKVjKjNgvFq9m9Qm/vb1jUyjl9hSale79C32257RoDqdV3IiWyFQW
	 NOikBGhkuLVgo2ooTSG5U6TvseIj2YN3qZQq0Q/da+5I/giMGcPr0Yv0pUyOcTppF1n18
	 +uXs9kq078bSo14/snt/uPesg/2Lxzr4NjahcDNKYjoyahVpk3ubuiHXVUidJ28h1hvJx
	 OHKiwKA1ISkrJTvZlju2+lrMQ6WwGgyS+v+9/JqGTXyNXHvyMXkD1Jkcvih+aAv61ZFFG
	 bLvABijWvNDFQ4Jq5T/4p8UgVbq5S9ZxgvH25rhO9aXCxGxgXjs8tVzMmMZSbXEAIAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516592;
	bh=guC+2E17GgnDMltamcxsBEkXyroTf1d9MHVenGqI/Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCVQqErYM14QegxD2m4qU4iqmFzqOeevEmSdlMSv+zlbfjcIIsznmzUsyKU+O728n
	 bu0l9rJX21nAL2HF81OdNl72Qgqoqj6wqxBHGRwogqd52aSF+chtItID+xHsj8D7/z
	 rY3etggkVFFSS7V1ix1kiGu8kxmJjiLPvJRkjFXF0P8r7DIccYTgj3vi93tBrIJAxP
	 V95AbVIcpFAujoF5Ir2QcHec6pwJWUrwf/YTVfRgaYhNsZhLjcz70PRI2JGxaIenxO
	 s1o9i9rNl8763sZkIKdX7+ctgKxCO2QS6ngpSO/7cY8u8aOfO4LytMIrynj+mtFnOs
	 q6xeh8FJI8vZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00A25607E5;
	Sun,  1 Nov 2026 07:03:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 629D2380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 523708115E
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDnyBi6FSxJt for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 493E48110C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516589;
 b=DOguZBqz871zZaKIgkOuuVN1tyqZzOPX4zFmmqygDvJrkIVU/ogWasxwdJSnkkCa2GWE
 bTJy3MKvTd7tTVauYHFaMcssL927Jaz7Gkh9j+jFLLbwitbOCewm+K4HuOmwTodN5s+Ty
 Z7mnsakssIh7FDRil4xueOuWeBHr8WxLaDUXUcfI0tn+2VOgbgwBs8HCVGZRuz68XFx09
 2h3577kY4JbvY28/q9qqrX1gVuMhSkNPEmgLb788WEsGgOJSi9IBpshFcFZ9WOuRLusFF
 lUGAiUwAvreS8kw88Ro62siFQtcmY2yWXKYXM7S0vy9btmddc9ccQaVSM/zxjFG5Vsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=guC+2E17GgnDMltamcxsBEkXyroTf1d9MHVenGqI/Pg=;
 b=LbTKgusl0oDZ3XQ7aoXS86/W7GmJYl0pIEGVjAAIMVgf4bCISOIdebOAsVe4t2b2r2DL
 Wp7ek9cArntuoPiD58illAKx8yOAuCiHlQT4KfbjDhvK8YVMzH39KSZZEYgB2jMQQ8VLa
 Gt9I60vOVtq2NBlrvUAXLRa+fZzSgay3jVvhIRY6qWSv7kvSs721KC8VWZiaXiHOoii8W
 jLCCdqyOLI1Rh7OmpYcaGaDgn0tsWGA0Km/AZjqpgdU2QRI4oyn3oX7tymoNCKlMD5czw
 V8T3wuukCsVpTAtW+zR5UoN3skk0KmQRkmA7S31y1GN4S0G31Wr8FrZxzfM3FwEnDsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=n3IFRX8v; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=n3IFRX8v
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 493E48110C
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:07 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so403104f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516586; x=1794121386;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=guC+2E17GgnDMltamcxsBEkXyroTf1d9MHVenGqI/Pg=;
 b=n3IFRX8vTCbNU0U9vTDh5XNLCCc2vROl7bOfPF/LafbXzyUVEl8KhVNsVDvb3WfCza
 HFGzDSTcV7qV+/0YAVledDyHL+v6SucSX2JxO0iSw919b96ye3sMqCt2lNC2F3zF+paR
 b1c+uk5tTkwYaBLlBiKqn2Q9ThfhxvfczN/7yr0qw3t4HEDYnr91QtLONRFkqDgjdkcD
 KJxyY/ZU7EcygOerO9fU9+BBvdELHuVFd/Vn+NJ6b9pP+Xq5GoNL9Y92vuWHGBskw8+e
 gA6gXoYs24/dafA+asFq9z6aFawRKwqqCG0C6XVWqmmoiQIyuAJAA3yLH+Ud2Agkl1A8
 TpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516586; x=1794121386;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=guC+2E17GgnDMltamcxsBEkXyroTf1d9MHVenGqI/Pg=;
 b=EtPZY49EoI5nmMVJsSRjCjDVc1WsDUOIgsyajRqg+wLCyr6E+o6aTymjF0458RYuFG
 SVmC341cJ/OxKF0KJTJD+k62KI072HM4I1HZBkqV7+iMxWPheG+kgYhn1d/AnCRx5ilo
 rlRCuoGmfg+ai0a9YLRi0iXYBuj6NN2gOdWBsb2QdasIAZtZXHJa8wbHxHcMJlvK2Uvu
 PWJhC/UP+oC2dDox9Zg8Lc2DKQFsjUQ82ovgBq5ERUMRlWj7LqhKV+LBCLn2M5EJBHSS
 j0DmiwkJ+zvFRqcOA/UbfNUkexu96LfHYITgE5zTPOHl/3iRqx3JJmkK0jDUZlAgKB/G
 B/Uw==
X-Gm-Message-State: APuU4Z+jU+P3dVIU0+da2pOrgYryshlhk8K95hsN2g+ysfL7iLtRj1qQ
 61a4ySBwfhApfJs9rVA2O5PUR8zTibthF6rxPpBSczbWHpNKT19IDfyJ
X-Gm-Gg: AYBFou1CoMUMZjYPnEjiVcffWQZiG5mYKi6GpUMY5tDgeXwSizHx1r8v3cFAsoue6KS
 M2/bjS2fLiSUVZgh28r4eY+0YPtkc4OjvTEYvrFcmlHKWFf4d2L+rSIGq9WpUuivMy5LsszsIJC
 RwSbYTyW9dCSJVVcMJ187B8v+obc/Tt7Zg5y7JGKmKW9e80SaisnJFqviSh4UahYfw4OHpeKJnN
 1NaqaO/4U/Kmp7e91yiLcf2pUBiuT1Ahzao3ko6Yxrl0Cu9ZwULGSicTupsJRelCYSe/AkdGzwk
 Ec11/qIqeUqVeL3U+zEG3UwCw4vQENndtjM1SFUvNcIJpaT9ITA6bL7KEy6ZoQm90xBPW3fYmdL
 5+juxTZjlFEe8jip4vnhj8w1DHYK4/IlbbaAO6//UEXYp1HmJHMjH6WcLlAqChND3XdtvW50CkY
 MsKvYvU3dVvDeJi7yeeRPG6G9jEyjHwA1WLEjyu4L7shOYKbeG6KevNYLN71POrN0hBB4P+OZgv
 n19wGWULtP+TdMYU1RzUvxBUJ0DDsJwx8ME9kg2p+QaRremqlFcCdAD2GCOVGMPrV4Ap3X1PEW7
 uggIulB5W5O3Zobca1h6CWcVFofRj+U=
X-Received: by 2002:a05:6000:402c:b0:48e:76ab:7906 with SMTP id
 ffacd0b85a97d-48e76ab7f39mr9350095f8f.9.1793516585810; 
 Sun, 01 Nov 2026 00:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm12234705f8f.18.2026.11.01.00.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:03:05 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 13/14] efi_loader: Index the GPT entries directly in
 tcg2_measure_gpt_data()
Date: Sun, 01 Nov 2026 07:03:04 +0000
Message-ID: <e420f3ec-7b16-432f-a3dd-5eeaa7cfb1c9@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tcg2_measure_gpt_data() now measures the GPT that part_get_gpt() gives,
whose entries are always sizeof(gpt_entry) bytes, as
validate_gpt_header() refuses any other size. So index them as an array
rather than stepping by sizeof_partition_entry, and read
num_partition_entries with le32_to_cpu(), as the rest of the GPT code
does.

No functional change on a little-endian machine.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v3:
- New patch (Simon)

 lib/efi_loader/efi_tcg2.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 97fce462138..4045af9afa3 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1168,8 +1168,8 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	efi_guid_t null_guid = NULL_GUID;
 	gpt_header *gpt_h;
 	gpt_entry *entry = NULL;
-	gpt_entry *gpt_e;
 	u32 num_of_valid_entry = 0;
+	u32 num_entries;
 	u32 event_size;
 	u32 i;
 
@@ -1235,17 +1235,15 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	}
 
 	/* count valid GPT entry */
-	gpt_e = entry;
-	for (i = 0; i < gpt_h->num_partition_entries; i++) {
-		if (guidcmp(&null_guid, &gpt_e->partition_type_guid))
+	num_entries = le32_to_cpu(gpt_h->num_partition_entries);
+	for (i = 0; i < num_entries; i++) {
+		if (guidcmp(&null_guid, &entry[i].partition_type_guid))
 			num_of_valid_entry++;
-
-		gpt_e = (gpt_entry *)((u8 *)gpt_e + gpt_h->sizeof_partition_entry);
 	}
 
 	/* prepare event data for measurement */
 	event_size = sizeof(struct efi_gpt_data) +
-		(num_of_valid_entry * gpt_h->sizeof_partition_entry);
+		(num_of_valid_entry * sizeof(gpt_entry));
 	event = calloc(1, event_size);
 	if (!event) {
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1255,17 +1253,13 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	put_unaligned_le64(num_of_valid_entry, &event->number_of_partitions);
 
 	/* copy valid GPT entry */
-	gpt_e = entry;
 	num_of_valid_entry = 0;
-	for (i = 0; i < gpt_h->num_partition_entries; i++) {
-		if (guidcmp(&null_guid, &gpt_e->partition_type_guid)) {
-			memcpy((u8 *)event->partitions +
-			       (num_of_valid_entry * gpt_h->sizeof_partition_entry),
-			       gpt_e, gpt_h->sizeof_partition_entry);
+	for (i = 0; i < num_entries; i++) {
+		if (guidcmp(&null_guid, &entry[i].partition_type_guid)) {
+			memcpy(&event->partitions[num_of_valid_entry],
+			       &entry[i], sizeof(gpt_entry));
 			num_of_valid_entry++;
 		}
-
-		gpt_e = (gpt_entry *)((u8 *)gpt_e + gpt_h->sizeof_partition_entry);
 	}
 
 	ret = measure_event(dev, 5, EV_EFI_GPT_EVENT, event_size, (u8 *)event);
