Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5CDC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 602BE40BE0;
	Fri, 18 Sep 2026 16:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2M-DKucUk6o; Fri, 18 Sep 2026 16:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19E2640BA7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789749450;
	b=mOL36DGnXPKxhYb6HtmDb7KeOYdzrhBZvgNNEVcAkEq1ThhKpTQMALVItc76Qs+iQbzD
	 lET5+l37zJZLDr9khHqnBIZ0ZTwcU9M7BC13wLRS7Kjr/pUDwYGPiC7zxvd7I4aeWhIBT
	 gMnEDaSkapgiLcfLrGaN1m5/HqnuHQuT7uZkJRUjlXJNMciPrLq9pIms9clJfBNAjCyb0
	 gbkHP2ftvHvI6g2vVlszFZMUtRsHgQgtmw8bSCbYJEAmCyY8E+eRg4I3VUKy3rNrxy8iK
	 Gy9AALVP2x5p8jts4bDtdbXK8rjQp0SFnwqwV/xs8YWS45MEmVjg1l8/BGMX7DoWPNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789749450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pBPr0/lbTzotiCDQAhtUHiLKbccvDH9GS6wvS4uZnuE=;
	b=CF3f/30BRhMuQdfQkQpk99SeAyeqNwR5F2zQi0a1z5d5HRxWmOoG9CELXMplv7ix37HX
	 kbddbC23iiQu0yhHqIDAAWxxqWHf2ai+mPhLmkwCjttUUGisXWsVgZuC9AkutRp8eo9u0
	 lkRKrg2pNxIpUruCsZkfjRxYtA4EhpsyOOn44XUcy8cjnXlwXxRzhD9daDlJpqtLXb5WO
	 Hd8pDpmpu9E1Mbm3ZYvkHvYutMSKrNkjJ8plWZZYIF3aQXK2rt2fpXpAsNrqk8A61EPRG
	 aSVSodpNSmQg/bfdVkma+ZKjihUGbWE3RnvWBQlaLFzwS38n9jnDB5pdtk24NgMIuPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789749450;
	bh=pBPr0/lbTzotiCDQAhtUHiLKbccvDH9GS6wvS4uZnuE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkBE7UzJsTT4xop06/eq7I4e8Gq0HDjI0dof+XAYUEu/9zhU6t1aEY+/6D/1Od31X
	 R3cv36WLf3dmdqkNoUsPP/GCaSj5nKjCSxx9fKGshhDCqNaWltwCGODBukEmSYwbpf
	 yxO0Kb5KZ6OTnb1toDH8VyALsWSGPtXDD3YQdtJ8ZlmVBYztAnfJw7RjLbhzzaScP2
	 tuT7xc8S85abhtLr4WI+xlaqyu+Zv/Mw3YyUcID3WKhEClMjN4nM2P+2lR1lN1rF4C
	 P+BIk4Y/LwL3CMJqK8Ag5ebCP71DbxZ5+t8ujG5G+5oNMkF8DYkwscrYYBg4ue+u0j
	 4xh8GH4zY8erA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19E2640BA7;
	Fri, 18 Sep 2026 16:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F65224
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCCF58087E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gvub7MJvs4aD for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:37:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8E6B8098A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789749447;
 b=sV9sXEO4BCaxvqzerDgYOl0fdJVb/IoohsyM4P083c5GfqxShaMJj5cGYTQtXFJziv13
 2VOoKz4ntwnC+l+2knqly1MNKYmUxxbVuTlSCX7Nbkt5FZOLNZqjIXabWkzjv0sFwjqJj
 kH3Hn7Akualizg7nGRsauC4K5eAJ0j19L1mfUX4I1XCe1uorn/0pRk751pddp4IBroDNX
 DIkgisXGhwUzL6YlnbsMrO0wlD9v1wqmmQ9Jw3UUqHQrwV7OaTgsHDzhC4Lfm+BRLRbYF
 EhMQhGnzT/g2G2ZqqDuM3sXSyjcXtQoeqeXb8g8xI0PdHn+ieSCjDcHi63jiNPAH5qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789749447;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=pBPr0/lbTzotiCDQAhtUHiLKbccvDH9GS6wvS4uZnuE=;
 b=iPU3r0M+b33UZFGjh+7c6WCBVDKrvp2sVpRKNgUKdnn0Mkg3P2TGw1g5+SQukmvRN/Zf
 vFT+L0zSA9zFvzB5heSIsaSrCIqrCSCk9WcNk7SIR5tbw7+ys6c8YEZZY+yC6U+TEiTc+
 WzWxFYLAOtGjD1a4k34zzHLuepVwp2pvQFfFNiVPUAJasJ+SRQPXi+BTEEBJPCoa16EaI
 0C9Hm0F3bHWQJ31t3CgLkoMRM+sX5Am4SGRorSTRRhzkAzYij9cCj/MWyr5HyBJLd8HnD
 kWpiyLJcuOPoquxDAyt9+IK+9148C8hCPxdaqF89hFaZ0kq45mxm/1GPUrFrDvPzdgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ap3PtwGW; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ap3PtwGW
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8E6B8098A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789749438; x=1790354238; i=xypron.glpk@gmx.de;
 bh=pBPr0/lbTzotiCDQAhtUHiLKbccvDH9GS6wvS4uZnuE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ap3PtwGWN+NN9V5VHXAWilH5rMkTomvk8k8CUC/Q5wsX1L0sxWiVO9NILS/sYbtu
 DrTaTsWHpGYN2oBWS7gqtShHZe9Y3hV67FfqMhD+pOR8NS0vbV60P6T2glD83q0F0
 IytZQ36T6pDBg2sdK95VGwes1r6cQrueRpDlMpqspIGV/2zIyxyzUt4miBjcxjPWl
 SuwO/IGwsd50Zx9FzxZHN3N8zadjOeRZv0rIptotmXaknaFeyGLUo/JJ8lUdSffTD
 ylBkd/e0FuHlYau7QDEl/W0HNAFP0mGcK0BYGJ8XbQP1+OqsyhV86T2+bo5c2yaXx
 djtLOJakX7IfbcePGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1x0hoi2fdp-004cwN; Fri, 18
 Sep 2026 18:37:17 +0200
Date: Fri, 18 Sep 2026 18:37:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 2/7] disk: part_efi: Add missing endianness conversions
User-Agent: Thunderbird for Android
In-Reply-To: <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
Message-ID: <9759D684-EEB9-48F6-BF64-7F5FC8CCB7A1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6LEPmvV2fHCAxom77X2JqbQu1acr/bNUS+sfDyRjntj4up0xuyP
 l8HZ+8anjll36gP6F9S/l7QyAImLV9nweyAwGjXycCbAJMG/bvOa9T+l2tb0QdorgSBK9+i
 7hztrGV0eqeS5PuCXlMBWeXIY1pkrKJCUWLPW0X7YBjst11ZArNSv/KK4pI7DvPi+9l2Lwp
 QKU+GowbSeGPbCpkUFbLw==
UI-OutboundReport: notjunk:1;M01:P0:RBgxFjHHeI4=;Cxq6YRTucWgR9L+i7dVmi6ygsky
 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
 mZ52qCobgy1c6QXvC9ws8Puo31GbIa38FFA==
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

Am 18=2E September 2026 14:13:51 MESZ schrieb Alexey Charkov <alchark@flipp=
er=2Enet>:
>Several GPT fields are read or written without converting to or from
>little-endian, which is wrong on big-endian hosts=2E
>
>gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
>the region a partition must not overlap, so on a big-endian host both
>bounds are byte-swapped garbage and the overlap check does not do
>anything useful=2E
>
>gpt_verify_partitions() compares the loop counter against
>num_partition_entries raw, so its "More partitions than allowed!" guard
>never triggers=2E It also swaps gpt_part_size, which is already in host
>order, having been computed from two le64_to_cpu() results a few lines
>above; drop that conversion rather than adding one=2E Left as it was, the
>size check on big-endian rejects a correct table with the memorable
>
>	Partition first size: 256 does not match 256!
>
>set_protective_mbr() stores the MBR signature and the protective
>partition's start_sect and nr_sects straight into __le16 and __le32
>fields=2E is_pmbr_valid() reads them back with le16_to_cpu() and
>get_unaligned_le32(), so on big-endian part_test_efi() rejects the table
>U-Boot has just written: 'part list' reports nothing and desc->part_type
>stays PART_TYPE_UNKNOWN=2E Linux and the UEFI specification expect the
>protective MBR little-endian too, so such a disk is useless everywhere=2E
>
>gpt_fill_pte() writes partition names as native efi_char16_t, but the
>specification stores them as UTF-16LE=2E The two readers here then
>disagree: print_efiname() takes the low byte of a native u16 and so
>matches what was written, while gpt_convert_efi_name_to_char() walks the
>raw bytes and follows the specification=2E gpt_verify_partitions() uses t=
he
>latter, so on big-endian verifying a freshly written table fails with an
>empty name=2E Write the name little-endian and read it back the same way=
=2E
>
>All of this is a no-op on little-endian targets=2E
>
>Signed-off-by: Alexey Charkov <alchark@flipper=2Enet>
>---
> disk/part_efi=2Ec | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
>diff --git a/disk/part_efi=2Ec b/disk/part_efi=2Ec
>index ede8bcddce1f=2E=2Ed8751297fbe9 100644
>--- a/disk/part_efi=2Ec
>+++ b/disk/part_efi=2Ec
>@@ -67,7 +67,7 @@ static char *print_efiname(gpt_entry *pte)
> 	int i;
> 	for (i =3D 0; i < PARTNAME_SZ; i++) {
> 		u8 c;
>-		c =3D pte->partition_name[i] & 0xff;
>+		c =3D le16_to_cpu(pte->partition_name[i]) & 0xff;

Partition names are not restricted to ANSI characters=2E Please, convert t=
o UTF-8=2E Look in charset=2Eh for the right library function=2E Check if t=
he library function works correctly on big-endian=2E

> 		c =3D (c && !isprint(c)) ? '=2E' : c;
> 		name[i] =3D c;
> 	}
>@@ -377,10 +377,10 @@ static int set_protective_mbr(struct blk_desc *desc=
)
> 			MSDOS_MBR_BOOT_CODE_SIZE);
>=20
> 	/* Append signature */
>-	p_mbr->signature =3D MSDOS_MBR_SIGNATURE;
>+	p_mbr->signature =3D cpu_to_le16(MSDOS_MBR_SIGNATURE);
> 	p_mbr->partition_record[0]=2Esys_ind =3D EFI_PMBR_OSTYPE_EFI_GPT;
>-	p_mbr->partition_record[0]=2Estart_sect =3D 1;
>-	p_mbr->partition_record[0]=2Enr_sects =3D (u32)desc->lba - 1;
>+	p_mbr->partition_record[0]=2Estart_sect =3D cpu_to_le32(1);
>+	p_mbr->partition_record[0]=2Enr_sects =3D cpu_to_le32((u32)desc->lba - =
1);
>=20
> 	/* Write MBR sector to the MMC device */
> 	if (blk_dwrite(desc, 0, 1, p_mbr) !=3D 1) {
>@@ -465,10 +465,10 @@ int gpt_fill_pte(struct blk_desc *desc,
> 	char *str_type_guid;
> 	unsigned char *bin_type_guid;
> #endif
>-	size_t hdr_start =3D gpt_h->my_lba;
>+	size_t hdr_start =3D le64_to_cpu(gpt_h->my_lba);
> 	size_t hdr_end =3D hdr_start + 1;
>=20
>-	size_t pte_start =3D gpt_h->partition_entry_lba;
>+	size_t pte_start =3D le64_to_cpu(gpt_h->partition_entry_lba);
> 	size_t pte_end =3D pte_start + gpt_pte_blocks(desc, gpt_h);
>=20
> 	for (i =3D 0; i < parts; i++) {
>@@ -560,7 +560,8 @@ int gpt_fill_pte(struct blk_desc *desc,
>=20
> 		for (k =3D 0; k < min(dosname_len, efiname_len); k++)
> 			gpt_e[i]=2Epartition_name[k] =3D
>-				(efi_char16_t)(partitions[i]=2Ename[k]);
>+				cpu_to_le16((efi_char16_t)

UTF-8 should be converted to UTF-16 here using a library function=2E

Best regards

Heinrich

>+					    (partitions[i]=2Ename[k]));
>=20
> 		debug("%s: name: %s offset[%d]: 0x" LBAF
> 		      " size[%d]: 0x" LBAF "\n",
>@@ -854,7 +855,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> 	gpt_e =3D *gpt_pte;
>=20
> 	for (i =3D 0; i < parts; i++) {
>-		if (i =3D=3D gpt_head->num_partition_entries) {
>+		if (i =3D=3D le32_to_cpu(gpt_head->num_partition_entries)) {
> 			pr_err("More partitions than allowed!\n");
> 			return -1;
> 		}
>@@ -880,7 +881,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> 		      (unsigned long long)gpt_part_size,
> 		      (unsigned long long)partitions[i]=2Esize);
>=20
>-		if (le64_to_cpu(gpt_part_size) !=3D partitions[i]=2Esize) {
>+		if (gpt_part_size !=3D partitions[i]=2Esize) {
> 			/* We do not check the extend partition size */
> 			if ((i =3D=3D parts - 1) && (partitions[i]=2Esize =3D=3D 0))
> 				continue;
>

