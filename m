Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B58BCA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC14A80DCF;
	Sat, 10 Oct 2026 13:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjW22FRC3R1o; Sat, 10 Oct 2026 13:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1340880DC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637939;
	b=nqywUXLKBr1AV5gUlDDh7xnjFdg2rDKAWBLjW6ULTlC/KXi3MVcq7YieXoqJSmunN++N
	 OPXp9EyQfCJS+HUpKSW6RsB6qwu5YCzs1zQhj7w6o1f2PCLLihptHfLNWos5BjTeoT8N1
	 iyX+5IWOndlbzt3ZTbqNM/KoX+GMGy9Q4TMid1LE8e8HhyUfOQ0MzWD4uAQnAJR1U2f5P
	 jJfE2ItLJEhga9RY1SLsWrK9S4/t/tNspsZgYm15NaS9SLdGQZ8Ts/nSEElgBrpQyoKFe
	 UcM+jyoL2QgFYG2YERi6V7WPQB8Rwcjas749YkVzpPSj6W6jmdk96MT5QghaYcE3UjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QQnpLoAiDHf0OZrSkuJoBSj1JSuzt28gqgogkJRg0EI=;
	b=WWT2a7S8UspfAYI5P6cnQphrG1hhM3d/q+pf4qTLkh9Z7nCnibT0R4JgHGCDoh8SCq7o
	 aFU8jPUNMrape40uFy6auSrcMVTZvls0QDhTcvOthR4l1htVfkNQ012eqsrPsHxt1n8zc
	 ViGEKPQQq07QZQAw5Lhl0YHjcByR+886f318D1vevVisqFM0TIBLZzKwKqaIaco/r0cYj
	 YyFrf82vxJ09XPF+sEPTY2OkYpUO3gK6Y6sl2gRZRIsSU4+BD+ncAzFwB9ybM3vhlHGal
	 SdS7O1wvM8Elg3mVPultQ5yAa3Npb+ZhrU0xGxA0+JAMo9H5WmXzkHb7T6i8u+tV1gg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=Cb7tD+My;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637939;
	bh=QQnpLoAiDHf0OZrSkuJoBSj1JSuzt28gqgogkJRg0EI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srqpSVHDFHVQMAGMHM3UmrSGKDwrXSV/ZcmuDKfmpQUaKJvf5FUXD+mSkK4iBnog9
	 9SiOU5ybSKaNw/BbnK7QJuWNcnIVHPtrqmjH/8FuYC2xREpQSPUwEMs9hhs3sRmgU2
	 uhV/w8LurUE7FZmrQtIAbejZJO50LDNTS0FjHqaLVWXpfikoPyZ8ci/EoVJKdlTULK
	 AYjla/YiiT/w9J0WhCqkJ4/0CLRZKbLbaoCwAEJw8Tf/Fuh0aMyFOs6NM94krxwU1K
	 3rb67Sh/kYdOCt3xNHdUIWnCbgxb36D1RseaXwFXnbi4Z/10TUQ9rcf5P4RR1JeUBx
	 TxOKcZfPL+NuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1340880DC7;
	Sat, 10 Oct 2026 13:12:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60297235
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 622F7806AF
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-POaUnzMY40 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17EAA8120E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637931;
 b=U4MAsurDBU8uiumZ7FqrBnM5rzeFi8ZDFBxYMy1t3HCDlvuVIQlSnDZGNNyzXzf45D5e
 CoIq3/K97ghYOr1DPGTKEGNH+npP9kJ6yTi0/NniLTJEyjakeg+laQc1FC+ZC3Jwy7FnS
 UM9br/ns8Nn2pC0SVVMgg4TIXrDQzruPjSMGXk76JTeQvUUWE6M4JHNB6dzESoJmPJole
 kaF1mgO/Bh0a9SH7U+ddSojv/gRu0Uos07jdsfjAl+48r870AzoV5tiESB7a7VKiuUFAu
 JW9q+LBXrk//fkqida3gGcrzN4tURX3St+Jm/R0S+qwkreEgX6CIyjRvqxWjiFGWwhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637931;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=QQnpLoAiDHf0OZrSkuJoBSj1JSuzt28gqgogkJRg0EI=;
 b=HvA3J3OsSDvr2c7JC87qVjOITI03LtpCcFN1Lsoy0gxd3dICelkKsjIBrf6cAUug6nz8
 vbBrAiKI55q9bxfEzNEsFHgrw+TD3UgFz41ShTJFqIYP84CURq6GCA1qFOsUdNf3Im4uR
 iJj9f4eZS8y0vZ5Xc5DPNRHR8NFo1oXcUSGhaDyDKwIsqDiAFka8Hyxpz3rt3vqnJDtjR
 Rd4FJMxJBZrR0wbFqXUlhMFIhTlKfOKOz8BaniDccLJpgWp6OInk4T8r3pGGD1TTALN7J
 VFVweNdPFXYR4voe8MpHPgRqujyjVQsToBpYy6t1jjeuOg6oBTrjEAbMad98lf1wnpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Cb7tD+My; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Cb7tD+My
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17EAA8120E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:10 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so99300866b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637928; x=1792242728;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QQnpLoAiDHf0OZrSkuJoBSj1JSuzt28gqgogkJRg0EI=;
 b=Cb7tD+Mya5U6DfNN4rTHda0u/H5WMYsWmQbb4zyyJvO/KqF8cPmR2KTOJWc7+bks3f
 H6RU3eTJuEjM4JKJg4JdjWkLNyJQzvtnOKxUbbZTvGqZXanumKPhbz/w7lC1iA84DM6d
 3sO+Wl6AxpMQbF7oPiXpgvCdoQywicnw78kqCnhMFx+sFIU8nCCduaHDOFeoRuFSzUul
 9yqiq4tltrUoBHAiRcmqATYIW+Yv7b8SFxHEkTmu36njqAtdw6mtamiifxL1ffYtcgtf
 UZPSQDoVxJd8EFmSQKws0KW6b2D6cJvwKaQZvF8F975LthcVuYtTQOxymfQRtG63k8Rk
 bVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637928; x=1792242728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QQnpLoAiDHf0OZrSkuJoBSj1JSuzt28gqgogkJRg0EI=;
 b=x8MNQB1PRLBl0hwjlmJPP2GpoDek6STDRJZ/P7BPXIV6aW2DO5kOSRTDV2c4OPqyLU
 b30KfeAwcheDclpUt0g2MgND8owjHtgr4uhEkAi0f/3BkoPOI9BZP6qxkPIeaaKDwzR4
 rcvTUP/BmBOEcEf1DJUDuDzTuzVDCsuy/yXpFjG1W+Kdb77tiqp8w62C1y2sz4gTBf/F
 eHcuTh8XkcSa97jrPkAFIPBPXKK1pvC+HpeyUwT9Pi2zI9Wcarlp6CHzeIWtzGcJq50s
 vMHWp7a3455d7NZ9vMowaRIdaPbqNY+DtIdQfliJHV7hsrUFoso39xrW6EonoAWoAbIU
 G5mQ==
X-Gm-Message-State: AFq9FYLUHXK3v8Hg3xKprccjb6gR9FqjP0IkTp106oVIoCNsFu9g3dVm
 CDLYBv5QYyr3xz9410OZ464YMK3uDKe3DeDZ30StCQzwW0C8lgxSq54t2ATg4cdKRbQ=
X-Gm-Gg: AYBFou1kfCHNwLOEXRiepnjf8W6ucvAUQtc78bfkC4VtNx3WJUMtLUUqV9paRV7aibv
 1TrKJ8GhsGOfN5AU6D7t5ee+e7lMIfQdTYnHcwShzsOikW+Dl3Ic7pnaa0DEDHMwPIaTo4Ul1Yc
 FM4F4D9qK3Qb/8jbczvnmURWmYQKbR8NhHIZMj5PyNNFVHn7QZxvgpLh33Oz0Uz2vTt+LtZ77rw
 kHXFpa4/+2PnL3E5ZTn1+p3ndpDvijGiBUYEn9L8srWzPj0tICSC04zXvikptjz1km80hGAO7vi
 gU1t7mp8wH0VIT9FuqhR7zqAT+v5UgiFhUVHjL2WQeNP/tbtelUkV+rJa4f7LYMkWaHwKe/91FY
 w+AxyMYmpm3FFOd5AEzTt5qBN8H9meujStAT6+1xji1N0gi6cJCpB62KtUSN9GqmQRHPzytZDJ5
 Z3KBMsIogQT0C35kCc+RnpyeUcOquyTHKaCU8smCxRTh/cH6BQhGBJLX1s+dsxjcRJOBDOureQb
 aa5zzJ1FCnueYDRtsgJ
X-Received: by 2002:a17:907:9485:b0:c2d:f76e:f030 with SMTP id
 a640c23a62f3a-c31a9d09764mr516914766b.13.1791637928437; 
 Sat, 10 Oct 2026 06:12:08 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:39 +0400
Subject: [PATCH v3 2/7] disk: part_efi: Add missing endianness conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-2-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/V+6QD3jWMF6LIxbcKEmJCVNuYWTIGwVuyL8HubkCRE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslz4Wll5XchFHu63Wbl7P4hZmTYsW72qIt6wq2GTz
 Zmt4ad+dExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVnZ8Z/vApfD913OPBGScN/hl+vTfMrm4oXVLoc1nFmiOLLcnN4RvD/7yGc/w
 nNqcH3b86RcfuPUvg48s3fKS1jnd2bLi5VPjVDEYA
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

