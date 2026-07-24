Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A2EC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB5B640AD1;
	Fri, 24 Jul 2026 12:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3jARjcjiWou; Fri, 24 Jul 2026 12:35:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE8D540B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896511;
	bh=HfNHj2HL21TRhYmVwosle5SfGK5ReUw9wpsiqOVayKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aG3ub0dnuQRSirkez/6xuD6V+kFKcr9l6YvYIEus2MH8lwNCNAgsS2XT4RZ0mqF5F
	 prcCCFY9Bjzmc0qWw6joxXeuPsnOQ4HnOuLnXMlQY5GVCPcyLiZVexNgFEtj052Dwa
	 Nl1RZl0bRdoEarmVXpN6pcGr+t6FSJs/8LcOwP4u12e+f6xPKcLmaDTwxVjbYlw3R7
	 5II2y1qg/VlTDw7xjQzOTP5xysMyxoPX8ZLFpnbZfAcrrMLft67FJ7QG6VSryTqvIB
	 JjCzj5/hU00tAU8fP29wbloUnUEEzCY5YJJRlzPl31rbmgNo5tEh8YN7TrmJV6Yn+m
	 WhxkmfhFBKXXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE8D540B0B;
	Fri, 24 Jul 2026 12:35:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86FC4350
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CEE18119E
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NykNNf2FqHQe for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:35:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DA2DC8119B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA2DC8119B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA2DC8119B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:35:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C5383E76; Fri, 24 Jul 2026 14:35:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C95800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:34:57 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81C6243437;
 Fri, 24 Jul 2026 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF27D1F000E9;
 Fri, 24 Jul 2026 12:34:55 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 1/2] libavb: update to AOSP 1.3.0
In-Reply-To: <20260712-avb-libavb-1-3-v1-1-44a50dfe2f23@gmail.com>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
 <20260712-avb-libavb-1-3-v1-1-44a50dfe2f23@gmail.com>
Date: Fri, 24 Jul 2026 14:34:53 +0200
Message-ID: <87wluk7ehe.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784896496;
 bh=HfNHj2HL21TRhYmVwosle5SfGK5ReUw9wpsiqOVayKk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=SvRv87BATBTn82ZSlLHkIxlJkiN2txDbBA0Vj8+TxS4l7AeLHxMO64aYlXFYB1Uym
 +yR64eXdc9vydlScB+aDMe2qHrsQygR2o+QjlfZkmjr5gConWTnmPlzre72BDjIm2y
 d4XKaTXAeqx47fOQxnmo1a7flDCUF+XG4HRYKngSAjHKtv2z3DGmtYLuBM9b2TPo19
 hgMKnj6DVlSNopwgNPiNE2s69lY0XAUBUW98OgjkA0p1E4b5KZQTwVLMYPJZW2X76e
 uS2262Lx7zA7iMsspvd+DZPKjS04tMQQJrkOqj/Uxfmbqi9S/mXBrAiP008YKgdoG3
 YMnxESPcJsA1g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SvRv87BA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SvRv87BA"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Igor,

Thank you for the patch.

On Sun, Jul 12, 2026 at 16:07, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Re-sync the vendored libavb from AOSP external/avb, moving from the ~2019
> snapshot (v1.1.0) to v1.3.0. v1.1.0 rejected any vbmeta whose required
> libavb minor version was greater than 1 with UNSUPPORTED_VERSION; this
> lifts that ceiling and picks up the accumulated upstream fixes.
>
> Synced from commit a1fe228b8654 ("libavb: support chain partition no ab"),
> which is where AVB version 1.3.0 was introduced (the vendored files match
> this commit exactly), for more details check [1].
>
> Functionality now parsed by the library:
>   - AvbVBMetaImageHeader.rollback_index_location (v1.2)
>   - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
>   - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
>   - AVB_HASHTREE_ERROR_MODE_PANIC
>
> The AvbOps callback set is unchanged, so the integration layer in
> common/avb_verify.c needs no changes.
>
> U-Boot-specific adaptations are preserved rather than pulling upstream's
> BoringSSL-oriented crypto restructure (sha/, boringssl/): the U-Boot port
> in avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
> avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures are
> unchanged, so the retained implementation is compatible with the updated
> code.
>
> Imported files keep U-Boot's SPDX-License-Identifier header style
> and their upstream per-file licenses (avb_rsa.c stays MIT OR
> BSD-3-Clause). The unused, Apache-2.0-licensed avb_crc32.c is not
> imported.
>
> [1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

I've reviewed this by comparing all the files with the reference
implementation from AOSP's external/avb.

This looks good to me, thanks!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

