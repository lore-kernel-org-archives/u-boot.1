Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523BCCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D89F40A4D;
	Sat,  3 Oct 2026 13:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9eP_za6eM2p; Sat,  3 Oct 2026 13:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6321340A5B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034989;
	b=YNnCPstq0hPaHN8tZ0OgvzcApFRgiwV7PcCeUbOZX7K70HwooK/1EZmnCuLTouAJRRZG
	 LiPS7swPazsOrfAFwhiMLCookAC5+BilTLanHReihSZgHSvV4G+cjp8ulZvfQeBo8lu3W
	 CfYYXxXYihMUAikCiKf26noQgP8tnzFA0wFYUc8sBrlntwyA23D1uuSQGnQbeG4y5QR8l
	 /mdfWnL+L/6QY4LZDVLFUTuahCfZuByPhH7SEi2hLREkH1cKWOccaMYcAv1aRuS4c0z+d
	 E0KV++ufGXVRnOXjEnFIwWkJIy6f0dnuyavTCuVnmYsQosxAkVs8j96LEEzIhs9sTxg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
	b=ZDjXBVGAfGLwZF2Xm2qeBAz3BSrfHHzee1LZ3yvHTlyqInUSTdftPqOtU4WeSz2nLTQj
	 FbF/6QnrDHEr2mGVssgEnBfMNdY0pP6G5pjAkZkLDgB5fWSsUl7VV47sdhcZnXW9YYa3W
	 7Pw/iqFBBtarfQGqBbdnpHEUxNU9HKGcjxXR6bk7WpHLik++QBzz3qAPCRT/GE+VClNP3
	 OsAZpyKoVK/5Q/j687VC4nTXPd3PMB4Qw5HxrX2BPhihRm68d4SHIl3B3nqO+l7uOqT3e
	 0rENE84qcKzbFRXYElgnFtujvnwUKaLgTQl1VphOzyiSv9UdDAHatXIwiPx8y8h28zQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034989;
	bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=niPPSngK3NNTvnboXtkU8L9LmIWlXax1eacSaA+tUiY8i/v/ENgxRVrBbaMwVem/N
	 R8bXAMG+tsRHJEq3kVtfF3leO5dAbkRvuY1FX/b5Y3mvP5n4gf55sjt7Wod2jl7Kxy
	 9BryQkWs1MnDwe2paCk9+W7q+SGET6HePgI5qtKoPwvlG8XHZyk5LUpYWe/HsXfEvB
	 egtI6o8UFflsdaxOGH3d6Y3K9QsYY2aLb6Pk337olL2UiVFuWzdvRwPIIlpEpB9jOp
	 wZAd4RBcapOgw9BoiH8aQmPO9vM3UIPyeBKu7zqyu7yIDIrXMLFMHyz5hI/Eub1Y1/
	 RJgyfByNM73KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6321340A5B;
	Sat,  3 Oct 2026 13:43:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFA31335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5A3D60F0E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyCMTRBFjnxA for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C453F60EFE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034987;
 b=cgHRtHJ+8nyZw97LXf/G3ZtAYMDagk5YcBMRDJ9QkSY16zYn9xwSd5P8E7R/sAxyc3kJ
 vChvmXvjlrwMkYs8ZlXy/gGzwVhxO0EiwmyQ90KVRlolb/dKgKY2LlE0m2XSuibLFOIQT
 0Gg26NSdsC2KOqD8tW2PI/auy62BzdEdur1YpQ/ZRg0NjPEOX0Id6Vbwgz0K0P3hxQQK0
 JCx3OdjgkxO+Gupkk0wrQjda33e45WSITOmtC7YuR1xBwQM1wOeFxGgIngPc6aQ3kL49d
 nt66iq6lv8TXtyQwiHvfKaVk+uNG/U4RGABbv7m0xEJXNnGXDGX3+kexug7XGEbXo7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034987;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
 b=DxQH4R0g+zRKJoTHFhUZpL/sL3GKmd9SBIPTr5lGo1Ww/H+aLgh4XNFLQ1dSHCKZhYU3
 uy4a/ggtEB2pxvbsoZloldZ2yq3ST/XX9vYPA74jL3wyPwZS35l0Q+JbU+bsBI0dc8ejG
 3toghI/9z1DVW8oFrAA6d62kDHFxoMtIGUgerYJay4cqk8ju5KiH2wbulNPhY4IZw+/UQ
 XPuJ5k+MPhQeFLfeqwIwUQtbbFVxItcb0re1QsSy5DHO0VU43hstj5kaKq800IXgGj7/E
 RVx8xNgtBdNx306Ig5FVcL8Wv2VK1ZsXdWQCTgn+CWUnylwe4GuJaeGMpx06w12z+9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f7UKTRsr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=f7UKTRsr
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C453F60EFE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:06 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6ab006eb282so561611a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034984; cv=none;
 d=google.com; s=arc-20260327;
 b=h04Rt9wpQq73CfvEy6+BXQBfOTDG4Wt2Y8Rssg3rs2R/aeX08SA8ArGrFI4Y0tkJdG
 MyIipy7C5qbEizqzcn9NB5F6QtpDFlszbQzBkMWM/M46OScU22HNBSvhSjHtxxoemXHr
 33bfcIksZUZUVvDZJmH29gmMyK5a6W3ir9nsv1SSDFhrO5yyMAl8duKJsCEI/tKfMToN
 7bE79wRQqaYqFZABY8OkdZSkuVkAN+0AAVvg8FqjKFfKRJvzwi9U0HO1wafE++pYprOY
 iDHnP3WyPhCBNWE4Ry3BXMICANCRt647z4BOrb75A9rE29ScTDz7KNz88HNhKxVLLUhe
 xKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
 fh=gfhgsB5kmREgBC8popE1L/sKuos7PQJXqWzBBz+Q3JM=;
 b=NXyUsPTDU7Ge0RO3K3iECod/vmtCNNcxp/AKiQo2T5I8dds2naBGbWkRfM63qmYh1H
 L9snw9ZAwhMsYoca6JzXoyobZw/IjPYbcaSAObqMCdYmhJsz667fUWA2g6zXFaWc0aEx
 vRJSeiII+mT0NGTFIoR9n7dIpaeRSFyKzP2hlWa5utuA7llHdj5sIJytivJY47jz7sQP
 5EJon/9600s9J/E51VYmyUSuEMag+ZAhEmds5Okim7t77AQuH+NGhLXrf7Aa/S+opzvr
 Q2R7uINnoqpgZSIuVs6aiqVIAPzpUXrbvSJNCSpgKUpwCpgHyk21xFRUswvT2k88PcTX
 VjEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034984; x=1791639784;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
 b=f7UKTRsrl81c6FFB/UfR6E2jbvvJkkVcMHDoca2Ktndtq0bmI7C+SkY8bAKT+F4hVn
 ArNrdzQ1MT8sFZgG2J9icEcqv1KWGDN6VLPjCI7yFTpu96kEm6Mr9XntmVw9d7my0iYP
 s/MrdXr2bdeMhW7udr56xGwXEdBROB1YuJRXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034984; x=1791639784;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YURl884SRJoXQRwFhAUqGnkvaB0MWAw7sHK0ifYAHew=;
 b=cWuUEqXcg/zpuUtFVYEnyfCGnkVJHYZAD/Ftzu8PanuRRV1r6ZDUQcIq4W/vnh23O0
 PftTq77ML0vMe1UxUE4LIywvDl5/GQmakVWSK9FiA3kit+C+1NMHXMnZwJL84Y5/6/72
 OWD3bXZ/pI44yUqo7ngowFiWtxLxA7SRzCd8sDHC6iErk+OtaH2+7/psO/hcp+j0L4kT
 CTxq0YJtkuCi14xVImxuaV8jrG8WnjkSrvILQ8pQYmLhfRlzy3wNVu8w4cea4qXrTGEA
 hqc+2b8kc5rv7gi++DbCFjtZMyrauIn/v/pp7Gp0xlFGjr8RZ+sp7RHTnuunPxX9lW5H
 Oc2g==
X-Gm-Message-State: AFq9FYI9Z1eactYIec/NiFpBRK4KkucbYn7/8dxLc+Jryj54+txrpSq6
 Ieox+scCXd4CdLx673AsJUC6W/VOganDvn6ZXnyNDDyHaBQsYgGURGnzpnaKjdTqnkugR07U0sf
 SE+tm12hU2tjiBfoBNKQTS6h4OUK8ZMHd5p9TIfD8
X-Gm-Gg: AYBFou0n13QzTgNmIpu0ruRVeX8cZqvqicNNfOGT1aPNa/VF4OVoJCT46jYDWbxA0nF
 5dkcotCPphMYnwl6WS29tmfdRa5kstWaEHWXq+ocjWZbFe3g05HLq2ULIrMajFV51Cyg3Ih70kP
 hvK3qFLYP3RezE/lq6me5VdI1EXT7nNqOLQdvAD+Inp+BcVCxbO9+a2yEggZH4V1GwgMf4/MPlT
 rKAujlXOMpuJCqoz0iaw3QXy5QnJ9hHBpRUOnBjmmo9tw4LGxNC9GlIEsjFJMru9pdjPHZ+43JS
 YvijijGSHj7yoASP4oRS/ObxETj/N6eN297wmDXQrUnBXYYncuNkN3M=
X-Received: by 2002:a05:6402:4490:b0:6aa:924d:900 with SMTP id
 4fb4d7f45d1cf-6afada2730dmr1937288a12.38.1791034984409; Sat, 03 Oct 2026
 06:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
 <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-2-daefa4792e9f@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:42:52 +0100
X-Gm-Features: AclHuK-Y_yYiqaG9D_m6_PnwaXY9-J-BFmh4ieRHYnA13H1z-1CBG-futp77fW0
Message-ID: <CAFLszTjv-fHHCAMoT_fnxaQiPaHXqpnK_W_w3UXArFJqEYzhTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] disk: part_efi: Add missing endianness conversions
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Denis Mukhin <dmukhin@ford.com>,
 Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-18T12:13:49, Alexey Charkov <alchark@flipper.net> wrote:
> disk: part_efi: Add missing endianness conversions
>
> Several GPT fields are read or written without converting to or from
> little-endian, which is wrong on big-endian hosts.
>
> gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> the region a partition must not overlap, so on a big-endian host both
> bounds are byte-swapped garbage and the overlap check does not do
> anything useful.
>
> gpt_verify_partitions() compares the loop counter against
> num_partition_entries raw, so its "More partitions than allowed!" guard
> never triggers. It also swaps gpt_part_size, which is already in host
> order, having been computed from two le64_to_cpu() results a few lines
> above; drop that conversion rather than adding one. Left as it was, the
> size check on big-endian rejects a correct table with the memorable
>
>         Partition first size: 256 does not match 256!
>
> set_protective_mbr() stores the MBR signature and the protective
> partition's start_sect and nr_sects straight into __le16 and __le32
> fields. is_pmbr_valid() reads them back with le16_to_cpu() and
> get_unaligned_le32(), so on big-endian part_test_efi() rejects the table
> U-Boot has just written: 'part list' reports nothing and desc->part_type
> stays PART_TYPE_UNKNOWN. Linux and the UEFI specification expect the
> protective MBR little-endian too, so such a disk is useless everywhere.
>
> gpt_fill_pte() writes partition names as native efi_char16_t, but the
> specification stores them as UTF-16LE. The two readers here then
> disagree: print_efiname() takes the low byte of a native u16 and so
> matches what was written, while gpt_convert_efi_name_to_char() walks the
> raw bytes and follows the specification. gpt_verify_partitions() uses the
> latter, so on big-endian verifying a freshly written table fails with an
> empty name. Write the name little-endian and read it back the same way.
>
> All of this is a no-op on little-endian targets.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> disk/part_efi.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
