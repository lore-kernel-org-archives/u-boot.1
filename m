Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D2FC982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52F6A81287;
	Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZiEyM5fT555; Fri, 18 Sep 2026 12:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7327E81288
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733655;
	b=aUL0gESTKaS1c3eukaNhyLR5pwnzUZC93CvVquKEZ4tJXaEF/mqnYS0777y3vu4r3ed9
	 wc6mXOaA7gUOPC5n3Gfer7uNXllpLwgfFekrQKXD9+IYXKoe+nMX6XQh6Ogweg6uk42sz
	 5uCxh1dOkNQoP9GyWk1GeaNThu6tquJduT+uaGOuBGEHBQ90YN6htC09pD8Dca967XFK1
	 f11dJKORAZ+GiAtbsosXucRRHYKsUJfsWR3/3kzfBZHhQ7mbNRmWErTH2oJR024ZJZr7j
	 Xx/q4FKxAQDkcImPcdqSms6k7BuksI3ODNXwXXGolzq7UEpR9CgZjbKpt9nHZ12vHPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HnvS0WTjXxvzadnpK8jzJOWzLwD8nLzzCdOz9GJZFlg=;
	b=WsInFtyVHImbxOF6A1Y0mp7SikuLI/8qVjB/09xlnJjHA45txuUeY2DScFmzjGJs5qsr
	 FnsDYI4wtD7uacYSSuCIRG9U4PBtT0xloVNLXRlKltECcUOW2w/IFeOxhnKsddqDcQToJ
	 ucjtAX2bkbce9CZ8/NxqvxgBcedMqDuuBmPzN5v6k3hCv3QD3Xb9SHhRWPAH55GmiJsYq
	 4y+6ZySZk1WVCaSX7MX85LKJ0f5YzOwS1u1ZPIeP+ZXIz8DOl2sVr3qbKy7pvpuOU+eOh
	 IuNmaSEc2tawKlWEefHlRElQq6G92yJXR1AR43h2Eznosmhkt+IltMZzO1GFRAc4Oog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733655;
	bh=HnvS0WTjXxvzadnpK8jzJOWzLwD8nLzzCdOz9GJZFlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JlwQ9+OFmaTnUNJJ76oLENuS56usHzlABcpBjn8HN9ol+nK5iqINBZlhmi2kJ9onk
	 LAYi6PDSLstYuXr9dqXsK1Q1TBxjMtdjnp3NKc7fR4yBhGYOeCoYMnX32fTqI4mulV
	 j3BIUO1TNL8biM3T7+8XApAk9f8NsKyVAntdFaITK7A5KPXYk3EDSs2CMeNCHXPvZu
	 Gz865f420vKaB2c1Jz+6LiqjTxDAUTWkulay6JQTWDxkOszmPRxlI7kLH8Rs9cs6mJ
	 GawXOCbGoysdKHQg6mVjpwrpVbDbTBG3dpfh5O0Tbl0KtwGfxqT9AGcjvtxEmr6oty
	 uaS6Z2VpRDtng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7327E81288;
	Fri, 18 Sep 2026 12:14:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CDE313D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72F5660D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JUpfV12qYin for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6D3A160B9B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733652;
 b=JfVnmgai3v4zePKLUFC7BGOK/KGtYcw0IIt4tu2i7Vzb+bqhB1z2M9lYDB/beONgahYw
 mRzMBw9NiIlkndg6tlf4RirQ4iXFEhfpvjcMdtsNhdOc8ka890dNqkj6Do3cFB0efKrBJ
 6QG87eT61JcVMpVdRIGLApe4lQVeZ3Ul3G12r1VF8IYTpmcNCIlofdkNma61cBju1DLMK
 YN8S0zDWKS4nMn30iVax1iBpH0vfpEbUp/SRNoGe254VZFz+6Fiis+kGNQrvZsk4O5iX4
 sIRVcN9VDPSTAasXw0kXGpEGdDEyIk4piXPCraHeZShJGksodHiR0SCmQXBEjv+BuGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=HnvS0WTjXxvzadnpK8jzJOWzLwD8nLzzCdOz9GJZFlg=;
 b=loCjkmxcL7IzXAAa5jo5R5uSJieZPdJEx8bJAdV61Rqpap3XgvmzeWExV4HsnSHb/dLe
 693pjKBTeAap1D8kE/wovYdI8UJrBZaqgYfoJFQ72OQUEYJ62ZcfmJ+J0kl9FHlMfwM3K
 JeBMdS6EV2BTp1HZP20aCRPf25C0i/Re4pxJsy4vessUXT17lowjLPq0g9adAE2mGcILr
 yEnqoZuiFrDkLRTFJmxfol9I6u1DTJ79aVAe5noGWcxcY+KWOIjjkkmpygTQlLZzkMwvX
 6CAVk0JZ8oRL7gQ3POy6NBUkzPQr9vDA4FDDsn7sHno3gx52R36fDSalGVb+bEXMigA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=NFniI6bI; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=NFniI6bI
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D3A160B9B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:12 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so4952895e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733650; x=1790338450;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnvS0WTjXxvzadnpK8jzJOWzLwD8nLzzCdOz9GJZFlg=;
 b=NFniI6bIuGdoh+D4upxZlsqK8oc1fqOAuaGQuV4ogbzHdcRTiTQJPWDs4i87nhBgN4
 2UhKQeBkEWGd49vWNL3gFq2SVU22rqBMXe16vwDKEuW8/P+9Jt5x/nzfavHiuf6/Siy3
 EQmrOq9GgF9M94CckZuUebU+l88+SJxTgsphhKpjcMDDXgROcaz8Qhq5RqF39GR+bbKA
 3tOFo1iealsl4Ao6nhpy0u/B5ZA1NG1ZjuYnZq1/FV6i1M0XM2TmHV9URrUI32fhVd9k
 JCWE7TBs5g1e9vKBkotmSZRDKeEANBZs5vQMWWuKpHzIYmfokFnCbiKSxGmpKkIo65+o
 2d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733650; x=1790338450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnvS0WTjXxvzadnpK8jzJOWzLwD8nLzzCdOz9GJZFlg=;
 b=KgVjtjoSzS1cmbfxaZXFEN1p1I0Pr5+IMAf6kGcRqFOlPpnCi2QY58G6fown6t0nvY
 IDyWsL50kxwX8dlhEEPeJuYSBK2i8SLUvWGUl3mWAyssrBdnAVB5SAvtYPIBLKLB5adA
 iJdivTeod6k4TSDYv1sMEblfdJdeHZmXO42uE8LE9kAJmrGeAygFOjl6lYG/nFuqZ2wT
 9tUov22TEMeA1vDww2MqrGVTmHATq2/Cui3AAM5jodPPyBsoepy3m+7gv+r0L8i3ivBN
 ITRKXho2now+QJTFtir3XWp2dk7RG+lELGwAQWPpQNPUQHWSQLdiFg2d2dXGbwWVKZBc
 UKJA==
X-Gm-Message-State: AFuF++kGvHibIZiFFtl6q8cwLXW5exqvNfEy5Do6CdgKRHxAtRHE5cfW
 3BjWgl2HkpBKj4MhUtitFK/ZXF8PCJuxbBJ/G+ACaXNxI3SG4hAcLBymIH7Sti54afFGkzbEVI5
 +mX1f
X-Gm-Gg: AYBFou3Q3YwVDU6n4Ltquy8UdgueFBeUe4loYKIVSQeUQXjOjLuXA+MAkZq3dccNvBD
 GPDM4ZWEhccBJs+KWay/p655XeXEPORxR7ld8d3FiuyWZyuHIv+qNBmVqHO5tEfv2sfqCS3T836
 dzgwmHDjvESJp+e+k/LRVFVREh6Sap0iG2L82hLy7DFwXeNIzRwtGsm0euU7RLYqlVNDp2YCqWB
 rQl0U8mvSRXZxHdh579xTnVwzKs0XbDVKO0wnEMBBzSaTNnW79TrlYR4ypP9lM8I3B50kttkPX8
 hgdn3bC59ETTDpxqmWcp18qnGmKHmmllutghgn1HbZWok6iex2zparblaBD/9J9Tu4JMRRQZ0Gu
 f84ZGHySP4gSKe2o3LnN55ugWA4FPxC2yUOlz7U+7IJP3psrXMhl/Z7JWGHHBY4EAXlcbk+pwDi
 CeKaquMAqjZHorBPOkkgANuO2XF1ap/45pVhy8IAvhTK/iYL1Rjgv1JiIocATZjj+USlt3u3fJc
 IZRfR3aU4KZ3qZg64KAS4wVrJ4R4QDLXIu9I7DGrDaDmTJSX0E=
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49fc5671650mr29566975e9.3.1789733650234; 
 Fri, 18 Sep 2026 05:14:10 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:10 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:51 +0400
Subject: [PATCH v2 2/7] disk: part_efi: Add missing endianness conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; i=alchark@flipper.net;
 h=from:subject:message-id; bh=bQ9B6Q2aTaET9ul6GOcFMYVadU+cu+tL16lGLf+TJ5I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1eY1NA7iVJZxPfY0cMGkB0dfnFBVOXVX4E2ZgWvv7
 ft9H8LVOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqcWGGf5oc6l61U+5/UpC/q3flsLmt3fMYh8f/RO8s1bXddCK3S5aRYcb+540
 q27J37X5SfC3u8Ky2afk8rqLKZ9m+7zoko6z7jxcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Several GPT fields are read or written without converting to or from
little-endian, which is wrong on big-endian hosts.

gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
the region a partition must not overlap, so on a big-endian host both
bounds are byte-swapped garbage and the overlap check does not do
anything useful.

gpt_verify_partitions() compares the loop counter against
num_partition_entries raw, so its "More partitions than allowed!" guard
never triggers. It also swaps gpt_part_size, which is already in host
order, having been computed from two le64_to_cpu() results a few lines
above; drop that conversion rather than adding one. Left as it was, the
size check on big-endian rejects a correct table with the memorable

	Partition first size: 256 does not match 256!

set_protective_mbr() stores the MBR signature and the protective
partition's start_sect and nr_sects straight into __le16 and __le32
fields. is_pmbr_valid() reads them back with le16_to_cpu() and
get_unaligned_le32(), so on big-endian part_test_efi() rejects the table
U-Boot has just written: 'part list' reports nothing and desc->part_type
stays PART_TYPE_UNKNOWN. Linux and the UEFI specification expect the
protective MBR little-endian too, so such a disk is useless everywhere.

gpt_fill_pte() writes partition names as native efi_char16_t, but the
specification stores them as UTF-16LE. The two readers here then
disagree: print_efiname() takes the low byte of a native u16 and so
matches what was written, while gpt_convert_efi_name_to_char() walks the
raw bytes and follows the specification. gpt_verify_partitions() uses the
latter, so on big-endian verifying a freshly written table fails with an
empty name. Write the name little-endian and read it back the same way.

All of this is a no-op on little-endian targets.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part_efi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index ede8bcddce1f..d8751297fbe9 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -67,7 +67,7 @@ static char *print_efiname(gpt_entry *pte)
 	int i;
 	for (i = 0; i < PARTNAME_SZ; i++) {
 		u8 c;
-		c = pte->partition_name[i] & 0xff;
+		c = le16_to_cpu(pte->partition_name[i]) & 0xff;
 		c = (c && !isprint(c)) ? '.' : c;
 		name[i] = c;
 	}
@@ -377,10 +377,10 @@ static int set_protective_mbr(struct blk_desc *desc)
 			MSDOS_MBR_BOOT_CODE_SIZE);
 
 	/* Append signature */
-	p_mbr->signature = MSDOS_MBR_SIGNATURE;
+	p_mbr->signature = cpu_to_le16(MSDOS_MBR_SIGNATURE);
 	p_mbr->partition_record[0].sys_ind = EFI_PMBR_OSTYPE_EFI_GPT;
-	p_mbr->partition_record[0].start_sect = 1;
-	p_mbr->partition_record[0].nr_sects = (u32)desc->lba - 1;
+	p_mbr->partition_record[0].start_sect = cpu_to_le32(1);
+	p_mbr->partition_record[0].nr_sects = cpu_to_le32((u32)desc->lba - 1);
 
 	/* Write MBR sector to the MMC device */
 	if (blk_dwrite(desc, 0, 1, p_mbr) != 1) {
@@ -465,10 +465,10 @@ int gpt_fill_pte(struct blk_desc *desc,
 	char *str_type_guid;
 	unsigned char *bin_type_guid;
 #endif
-	size_t hdr_start = gpt_h->my_lba;
+	size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
 	size_t hdr_end = hdr_start + 1;
 
-	size_t pte_start = gpt_h->partition_entry_lba;
+	size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
 	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
 
 	for (i = 0; i < parts; i++) {
@@ -560,7 +560,8 @@ int gpt_fill_pte(struct blk_desc *desc,
 
 		for (k = 0; k < min(dosname_len, efiname_len); k++)
 			gpt_e[i].partition_name[k] =
-				(efi_char16_t)(partitions[i].name[k]);
+				cpu_to_le16((efi_char16_t)
+					    (partitions[i].name[k]));
 
 		debug("%s: name: %s offset[%d]: 0x" LBAF
 		      " size[%d]: 0x" LBAF "\n",
@@ -854,7 +855,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
 	gpt_e = *gpt_pte;
 
 	for (i = 0; i < parts; i++) {
-		if (i == gpt_head->num_partition_entries) {
+		if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
 			pr_err("More partitions than allowed!\n");
 			return -1;
 		}
@@ -880,7 +881,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
 		      (unsigned long long)gpt_part_size,
 		      (unsigned long long)partitions[i].size);
 
-		if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
+		if (gpt_part_size != partitions[i].size) {
 			/* We do not check the extend partition size */
 			if ((i == parts - 1) && (partitions[i].size == 0))
 				continue;

-- 
2.55.0

