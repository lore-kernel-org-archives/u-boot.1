Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CBC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 829D160DAD;
	Fri, 18 Sep 2026 18:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xwnsew1JRpEc; Fri, 18 Sep 2026 18:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8F62C60848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789756348;
	b=pitronIGtV6f5a8mfPKktqr0jn1WJqnWS1BxD0fQMUUimuqcSQLp6VUdeBSWtvsjCoFU
	 FGfC11Jvhq1parpt41MrbfFXfj3w7KszuKjSXD3O+X1gnegDts2jFEJFPDEgPobMZRzNm
	 yQoFXrpmWhrgy7TwPRo4ncTtfGjGygMUZ5ngFupWBQsbw+ECvgN3+ssdB06rBEDumkIkl
	 DnRJsQr1fPkRYk2PpL+i6ROqKZYo+FRCYlnUP3WdM/S3ngGLOSQyNcji4V4fBRCLb8QVs
	 U18VGPKCGnjkljci4c7EQnuMIMKsK8Oo38c4O/YOWlxyXm82eV9bzFHMl5Rwi1PxieA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789756348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
	b=UcR36/EMVyKTg66lixexDUJtbpuJfaYi2+Maa+nACj3CXQc9kqvBpwZteHX8MJV2kUlF
	 bjRfujlCiHezK7nhA2AcocQO+7lZA3W+agsHxIYxB8z0BlxJk42JyV2UrI+SpF9PbA+Sb
	 kSQU59Ts4ld0zBvFtfBiNqYfariOIMfquEorBX9NDpMoRtfzFZTeEe7QaZa+ghz3fZ7bF
	 earyY6UFZP5aeh10TsjDglbViP4HtNWt4ZdIA3L1yAE+PHWORpvODjPNVoUxPgPAIQVpl
	 9u8XxNUZ8PjENC5wpf6r/zEBIFSqDbzvmZUOzjQ2LMi4PukeNTN43fufC/n5MNm4kQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789756348;
	bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGxfeyaNuthrXnq8XbiTfxuRhgfxM/tZ7rP3V/inAJkY/KhHnx91123cE2jV30bjm
	 S8fkHvcA8n/UnltLhIGriSIoNxBSIvaGlcBHBv/U2cc7BDN3x8PXHJcKN82mLIIdc+
	 in7R1x00mBbKzCWnnUGAwqNpCwM4xJt1UzU5xIfXxZ/DZg/AsdXboksCVBy3AQI0PN
	 B6ZPdGfgp1mXbM/SpofoMf3wDcmDFvX4xvE+C2bJEtIiuJolOhbzkA8vVfZV/ujqFp
	 L4eM3HIsslWd3hwi0TQC91Kmf7m4XqhgIrenU2UG9EuJcY24DWUwTG13XsgnJr+a6q
	 qlL3Z2IBlKhSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F62C60848;
	Fri, 18 Sep 2026 18:32:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 563073B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47EC7400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55qZDUtTiAIz for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1BD254006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789756346;
 b=fRIhXPgINOkGsKRVFMzES+iutH7G8TcoW+6fib7zfsAtd7fGfu6pyrLdaXAvP1HCQ143
 0Wm1tu/njjrM8E7Aswbn1Y+uLK1rxrfIWIPJSK4Rflgl2765W8ZWeQjfZpQSVeuSuCbWe
 5MPE/n3Asj7fHBoFd0gm8oWrJBLN3wM/XJCeBe5DEQUOTevEYXowrO3qlBlddWhl7Vyl0
 ebJwbIB+CBH22fOzScbTTeeyDPr8Smkx7aLHcLBvypj6To5S2V25myY7qbYK+DHpT9CGK
 u9s6if+wZvZxm+0dHrzl6Dm2iZzgL8hNKfWFMKsnzALNlhxwmZD589G9R31aRV+n2SA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789756346;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
 b=pt88MbwRqBSZyfoXSkb4nuis2dOo/GFWGKxipeaUuz5bv3Q1z1U0YiN5aZsxp2vWVqie
 q8WzTxVkOdUdyfDtkkx6NKjkcjhW59qQeAb1wJ0eXIrNvWLxLSKzRWjBGVhhYtXaOnVvu
 RSNEAYnXJS68Y4gqkW0AE6iXqbL3w9Ot8GPBLd7wbUeYhLhKQaKW4HmqX6sP/Rov3pquT
 0Gz+5NIq+JHj/ukXo4Nx+HeshWxtw4ckEhrAI9HOuQEqhtiD73v5dVnJyFEAg071RO0Nl
 532bq3dbnuI8Sfm3oC+jrBOCmv0eew2Sq/j7U3taMHgdprd8IbNXHvgyi+QyMNTwdSA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0CG+yHYa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0CG+yHYa
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BD254006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:32:25 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a605844571so1415087a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789756344; cv=none;
 d=google.com; s=arc-20260327;
 b=Sxkw7Aond3buE5+kAXSwfp7fkQvlgybCpcA/8WmGb4ldswIKJg86fy7YGMYZ43j8Bo
 G1rvQ+/TuQtbyZiVf1SYLZe/5p0Fh7O75Tzn6CPRfYDFUpcElPmRrKViBJV7tuQH5iMi
 a9693ZwWm/75pHvuYz1rOPy8S33vCbSAcds6VU4nRMxO5Qbt6SzWt3e5/DyhGvVSVbwV
 DK+goUtLDDsz2DNALwSHA0dJnUNsGnHhapM3CwX8qtuYkOccEW1yUZJlmPnW5dvrllbl
 vi70IGXgyaypZqwPr8xOxfp3VwyFkGfUgeMz059oGYzl917CWFvsaQSV4T0BP+zON7md
 NUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
 fh=+1nyciEg8VuOQmBByT30mDibn3jCsBKMAGK/ePlfZV4=;
 b=JIntR5bki/U2B5bmF89o1OH4ULTsBqZLCdZzu1bfsTj2ic5YgQXsknCkyaSm+Cxgas
 gLuoX6To2ZxKAPgfhkHywex46Sw0t2mgVJi9jxMYp91bM1bsW2L76An4VJuT7ccQyZkz
 nXbt9kLQLrys8w9qCw8cAOn7NYNfMCIIzvRd17t7UlubSd9HanoFS18/y7GAwk/NFfqB
 zXE1zrFax3I2bVN6hnrJtByySvTDsntydwFH+oaAojkDjqEwIyYcrXqXnRFcdcjXZUq3
 WKlXGuS4JpMDnH+l0uLtV8935a7H5DzO98RzirlTUi2Lo/KklyXmGBf9F0uifrJ5HfxL
 enuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789756344; x=1790361144;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
 b=0CG+yHYaz6sk+CPFbFmj/Rb9/WpGZ/Vm7epmjR1RDkiHxizSkEWkesvJeUggCm1T40
 ARY8lKaqE7D0HUpeN2Oobe7hE49s336NQUa+a4ILgDCUDHtYN5kYyM0MpOIGRXbG6TVV
 MJXqrrpZ1C5iYmY6LoJ5eXRf0IIaK4//eC69R+CR2GkkQMHhHR9ygGNlF89yNU8jLDe1
 zU7KpMJu0VSWyVokQf1Uj8YhHNtdezBIcQQwGCm0hEk1F5NfKfUaSWTk8fUeKnX5rq8v
 ATxGo9CgG20+Xe9sPXLqu4A0k2p8xcessspD8DxBjK0DbvNtH000K1B8LgEbxy5gJIg7
 KzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756344; x=1790361144;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bSTBnkNaAON3neG6ihSdNXxLJRQ1c5yY3mkenC+2Kjc=;
 b=sCd2hceO0WRGCbAYLbqqi7LeNghsnkwfqSPDpGdeferuCn0NOdI6eiPIdiwvv5JyRE
 qVNEtwD4DGMYI670Svxp2cGnBA2Lkv0J+5iqzTl2I5K7rmoc8OYVFC4PnymLbLIi7s78
 ijpj9WYPXln2cMx2D6pSoMGQbWNuO9pmkBoUq9ozQ1FEsS8s8Ox2bzsru87L9gj2HfBv
 kjRXmsZcv7ayxuCGSHjtY0J2YvMy/kqXXPUocI+VaDaVzNg8Nx41ZgiZzPXZ/y/ex4u5
 BaXrVM1MtWb2SCt0QzLOaxMZxGYV5u50kQukPogH9oHaMuEfBdu8me69/5UkIYsvE9Rz
 UFoA==
X-Gm-Message-State: AFuF++mSpJlQAayX6cXLtz9SotLB0DPQSFgrqJILtUKA2yO5A9oVDaRF
 6V4B8nLkmM13zu06sr2IM1WYOQ10QQNUco33bonjgHx/uhgmR6rsCqJ6Eb/PbBEko6et2DoO3pP
 33cL6X14qkPkmDR0jd31nGMZJFHzedWpUIafR9h99CQ==
X-Gm-Gg: AYBFou3BlDM0wiZQBKW4Z8QDUFGdqQhprCFrXQEcoXq2RlT5IUQj7LN0QfwPtmjBRBA
 tS54UFQi60x/bn085H1myvOxsnd7Ee+1Nqy4WEIZ5P0MHzV1w6rBgozAeMYKv0upWrBv6bF7oNr
 jmptDufokwP929WyUzkD+wNMkcuEzZ4hqB2ujEckUxVKeue8hJI8YmZdQrr9jh6GJxVyO1V1q9p
 Fnry+AwnlZdr3WkJTQpPTP3Utofrq8qz8c8TLFlwZnpCAP8c0enXN8I0hSuFpKoGAiDcbCxSM9y
 TTQpJdCETAzRznCgyptHFWdQo8crPwxiDCeHgNnpC5RharIOpy+8bQF9lHL5tUYTIHZSHzdE67l
 +2p5FUs3YLYfX
X-Received: by 2002:a17:907:6d17:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c2a15aeb6c4mr338194166b.27.1789756343815; Fri, 18 Sep 2026
 11:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
 <9759D684-EEB9-48F6-BF64-7F5FC8CCB7A1@gmx.de>
In-Reply-To: <9759D684-EEB9-48F6-BF64-7F5FC8CCB7A1@gmx.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 22:32:10 +0400
X-Gm-Features: AcwNN1XKXtHm9r9mxNMzxKK2enxvIIOhQW3Z3vApIMfjcmbboPkrPcxkdFI4EG8
Message-ID: <CAKTNdwFEb4gtowTxrqd2EoxOE0LHVKFTUWeCopT515eMOZ=bvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] disk: part_efi: Add missing endianness conversions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Denis Mukhin <dmukhin@ford.com>,
 Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 18, 2026 at 8:37=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> Am 18. September 2026 14:13:51 MESZ schrieb Alexey Charkov <alchark@flipp=
er.net>:
> >Several GPT fields are read or written without converting to or from
> >little-endian, which is wrong on big-endian hosts.
> >
> >gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> >the region a partition must not overlap, so on a big-endian host both
> >bounds are byte-swapped garbage and the overlap check does not do
> >anything useful.
> >
> >gpt_verify_partitions() compares the loop counter against
> >num_partition_entries raw, so its "More partitions than allowed!" guard
> >never triggers. It also swaps gpt_part_size, which is already in host
> >order, having been computed from two le64_to_cpu() results a few lines
> >above; drop that conversion rather than adding one. Left as it was, the
> >size check on big-endian rejects a correct table with the memorable
> >
> >       Partition first size: 256 does not match 256!
> >
> >set_protective_mbr() stores the MBR signature and the protective
> >partition's start_sect and nr_sects straight into __le16 and __le32
> >fields. is_pmbr_valid() reads them back with le16_to_cpu() and
> >get_unaligned_le32(), so on big-endian part_test_efi() rejects the table
> >U-Boot has just written: 'part list' reports nothing and desc->part_type
> >stays PART_TYPE_UNKNOWN. Linux and the UEFI specification expect the
> >protective MBR little-endian too, so such a disk is useless everywhere.
> >
> >gpt_fill_pte() writes partition names as native efi_char16_t, but the
> >specification stores them as UTF-16LE. The two readers here then
> >disagree: print_efiname() takes the low byte of a native u16 and so
> >matches what was written, while gpt_convert_efi_name_to_char() walks the
> >raw bytes and follows the specification. gpt_verify_partitions() uses th=
e
> >latter, so on big-endian verifying a freshly written table fails with an
> >empty name. Write the name little-endian and read it back the same way.
> >
> >All of this is a no-op on little-endian targets.
> >
> >Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >---
> > disk/part_efi.c | 19 ++++++++++---------
> > 1 file changed, 10 insertions(+), 9 deletions(-)
> >
> >diff --git a/disk/part_efi.c b/disk/part_efi.c
> >index ede8bcddce1f..d8751297fbe9 100644
> >--- a/disk/part_efi.c
> >+++ b/disk/part_efi.c
> >@@ -67,7 +67,7 @@ static char *print_efiname(gpt_entry *pte)
> >       int i;
> >       for (i =3D 0; i < PARTNAME_SZ; i++) {
> >               u8 c;
> >-              c =3D pte->partition_name[i] & 0xff;
> >+              c =3D le16_to_cpu(pte->partition_name[i]) & 0xff;
>
> Partition names are not restricted to ANSI characters. Please, convert to=
 UTF-8. Look in charset.h for the right library function. Check if the libr=
ary function works correctly on big-endian.

This code is pulled into SPL on 405 boards, and some of them have
really tight SPL size restrictions that won't tolerate the inclusion
of charset.o in the build (e.g. stm32f746-disco_spl has
CONFIG_SPL_SIZE_LIMIT=3D0x9000).

Adding non-ASCII support sounds like a new feature, whereas this
series was meant to be fixes. I can look across the tree for lossy
conversions to or from UTF16 strings as a follow-up if that's helpful.

[...]

> >@@ -560,7 +560,8 @@ int gpt_fill_pte(struct blk_desc *desc,
> >
> >               for (k =3D 0; k < min(dosname_len, efiname_len); k++)
> >                       gpt_e[i].partition_name[k] =3D
> >-                              (efi_char16_t)(partitions[i].name[k]);
> >+                              cpu_to_le16((efi_char16_t)
>
> UTF-8 should be converted to UTF-16 here using a library function.

Ditto: size :(

Best regards,
Alexey
