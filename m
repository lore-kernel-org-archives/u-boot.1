Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13EBCA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C241F81376;
	Fri,  9 Oct 2026 07:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8grO2rBX45J; Fri,  9 Oct 2026 07:01:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7600D811BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529271;
	b=j7K9x/1m2W487Xgl9PhBIbIswA2aASoyTPa5zmJe0cXH/5JJAnhgg4gQX3z3p4kNfAwW
	 x/VveJOO4tHAfufEF3SDyhnqTcxVfX5fN2MGvB1rfk8Ifsw72Enjtm3E2pMypvH0Eg77O
	 t5msSWkB55sfdoljReaShCM4XUP74NXP9V6mRX0CTNU6suyFWmyiWhYOPimhVVQY/A3gn
	 dzzoeDcEmEnK+9VY0U5ZOJsHEH4fjyLrBmtD+PXUQBb5wStOfjaMsmKKZOHj/8S/Co3DQ
	 +n8tMXI41ytLG1nn6l07EFN+PyYblmwHcibAhcomSOO2ocLkmbt0H6+JfbtnKB4IW3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
	b=kzcEvZf4AU4PxL7CCdb9BUMOlX8hJWBZ8vkG1Coicbdo3kI/pP3LjJK35dND8Iqc1fs4
	 s9aE3touMCPEP6HMPWRKWzL42cUHiOi6qsy6Yc15E0ktu7AoedopJ5dy65Na7V+fyTFAd
	 CGLj5H61B8X0yl163W7UIf2gPBRBCpNaSPvL/y7p4p2gfpSLeEFUA3uJnduAXA5SM7zeO
	 RDeZRftSU5d0mXA4HLCLdZgjuMXddZOtWWrOUmFP3suEdCMI2Rxa9iQw0OnpfZiu4ATTe
	 1A/Zd1Ld+aMnc6ci9afvIOchikmycD11iI47Znqx0pTAQJ0GLuNlVSI3DYGW5FCBewQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bGQaP7QZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529271;
	bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GFFmT1dylnRp25dTAa4P1YaYqsAydQ1rgDzpTTnLwK6A7MlG3tbbhqjocD5MbSTdG
	 veAcsz2xkjtKEeHTFUtUvMDYiiumUGqGP2LOS0G1dYFddX71UH+LWvec75gue4aU4o
	 /BHdz5jMStxuRwa4ou41HCO2fJ6EsjJupiQLPtprclR6MwILyVzXAVVgTzc2yh02nH
	 VV16+n3dPRUlCstC4TNxinYDDOVMs0/lQE1+UP8i85/pPAHfUWo18y3om8DrxWWhdL
	 i0cTgYOpNAHWWCNRgaSqR4RpE7tkc/G4fvvnayFxGaxIs87n9SW40wi3lzLyuCT5QG
	 izsyS3uzgRVJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7600D811BD;
	Fri,  9 Oct 2026 07:01:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB87075
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8A41811BD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id In27hK2eECcb for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2EF181155
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529267;
 b=mdqodrY6LKqrKr/WyHiryCTaoTXgjgNEe8xyXwfASFnjV/JBL+SB3BKE0Sbqs4G2D7tx
 mNTn6lA+eWT1v2wsNNfVkA3z5VFw6wLqz9Q3POMJMgjZIUDYwkvXcNnUznv79mCuiTIHs
 trucgBMB8Rg+p7eGCmNdThH1kmZhkFSU9CsX3G2K7YoEvx1dJotfgtDxQ06HS9FMLxeuO
 3Da83RKeXTVOzJ2Zl4JGDghR1BLhG1hpqMQvFLpzmVS+IDwkfIY1+glCpFEceoWaitH5G
 /ita81IA0b4VF8j6qyvLfBjww7Uu3L0xoFXvKczRiBXBo5Idf7tY2E0LIZ/P5zmD57w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
 b=acxnSo6VGsIXKr5xyTrTSExJMp2pc/1Ur1F+vgnueo9nRvaWjEEZxePVRp2+rxHyOZtA
 3BAS+/TXK5PnEFX6gesAjvNPi8zICTK401pGpZibaNb6jzd/nf4VWo8BLtErflhj5qpRT
 mEjcTVMzSF30B2K3RtcOHqqT4cxwbyUXnTzQxqNBL47UHyQNNquTs7T6KFvEJnTVqKVK1
 ToMewoONdZIHjr5YJoLVOD72EjrIcVgS2UwT/G8lnGE3JtRwlvHxKecANXJt77FOtTtce
 tCVGzlV/ht7GNJ3MubdjDcLLg5fleAeJHHa1MvMd68lS1ymoIV03YgLpU3Hecaf8Z8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bGQaP7QZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bGQaP7QZ
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2EF181155
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:01:06 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6afe8d3980aso4607946a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529264; cv=none;
 d=google.com; s=arc-20260327;
 b=EmWsr3TcCbuNi1yhDm3yoveAF+a4JwHIpRoQ+jRro6GBOcoB90mUAF2PXkKLUCzcvT
 VR6k3Hj/faalkbqLlRLe0huXePOSlEmvxKJ5e7otdGmW5ugKu1CzFyhnvz8/Yq2MvcWl
 SjAomYwMyNJ9zxNjusyEpofiDsXdmil7TLdKqpjo1UMn/BEfK8ugEODStxu8wZQb170t
 sX3WWHxDgAkZcsbV28s2MYdoKGiYVAQn+a05ZvdS/bURrLFCxE6nuV8bTl/efM9gWCHg
 73lVv4rKOYhGOr+CzeRw8H8Chm0FuNGqc1FDhKsT7nLSLvNZBQjj5mCm9/TofY/A/5Hg
 mc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
 fh=KO+N9rDVG8oED9imVwAtmElOU+C+d9ci/tu6TAhBpYs=;
 b=S6hTWJhMRjogToG1w0CFiF38Kx7qZDB9VMw7ZWM3fId6RzaTPDGfje1n2jIHWgFFqP
 jXNWsnDr4xWND2Erk5rqfgGtGXf9/CAb8NuONZK4JjpQC7jt8u/lXuo7Qr2UvhhPeRDi
 +SzMAPp+Kzhfsp+5sTaLSAtael2AKBLoFl7mNsnHV5pbKNVanisd0jT5tFfVXuWfx3g4
 6CnOuMKaRNU20T7tE5SQ2oQgI8Osc1yyreKqP9pkn/7bMSsvEBflYZieEtGMxWbiRGtS
 FdHqGO2jeZ4hLjMh6jgwgIXlSF2b6pzXwAvrlKwxladPFadIUHy3eUG6SjtEVoWpuHAE
 EK3w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529264; x=1792134064;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
 b=bGQaP7QZX3qNc3wA7OCaTijfXScAeY41lT0ZYjHLyiRMihhs7xzTiMYdVQpGE+ZCTE
 oAKHUuqZvrsOlpwlRW6bKBBnf+jFaknrGWr60RTUoIuS9tT6i3r1eXIo1w00vEqmhp5j
 RI0QMHAz4LDs4gUZDpkF3CFxNhyuxw4JYdlUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529264; x=1792134064;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sWIu5Db0SBpDbhq2gWR132ueRklGBQ8nziU9jZYcrDQ=;
 b=kAU5dCKUFHDDuzZuTjt3c+Ff081eVQur63ZKDnYpTBykprwblMo+mhd0bCvkmVVA3M
 0aFhSAJJy/c8IAgrmwJs3pj17B2+k3wwl2jeKLVMVfobtidVmBmUS9p2usDgDoUGLWFA
 RFSmHF/wT1iQPUC6axOfFvkmYjMH18Ut/VFaTO6x9+w69BFytlXU5YqQUMdlEiB3sdI7
 l/kcsVQ+2bpTxorAx1qOQ+NoTIv8B+spC51ViidK+mugJpK33HOyZI7BV3/md6N0+njs
 ZFFO0Kkh6lF60CqZNz+YHy42Xn+MNsfgMYNRGpyBgHPC/YgPJ8JgQJyQbG/8UPwkTkhn
 I5tw==
X-Gm-Message-State: AFq9FYI3SN/IUBEK5NNoeaogHMUWkgJIT0Lop3zxd6rPpi7v3sYXneT+
 hgmv5yXpJwTDmbCJFQvaXxrhiPYKyLA2yFAHZQSxlk+oQ/OKLTOSA/DB97LIuK9eW5ou+gPhnkv
 H5+Qp/yQnq9ygy83V2B0RQmRiCsuFm/rBZigfCRPT
X-Gm-Gg: AYBFou3LPavL9aaTjFUMUmEJbJwIvxOoTV1k/TiUy7ZCOQFG5XEsoO3K8/Fobbz8dYR
 cV9bTzq4qELTl7uAuC5JtamcU5lNGDZwAW86FHSLHGaQYUu/kcAGamAH+3p1CIMFmZLyIwzxQql
 8aZNv3KfLFjteLGZrMI5QcwHmyUlhi88pnjvywFEmrVWf+9ZeHqJni4hPlAy+TEdTFtuHhE04rI
 YcEGQbHpWnjrrDWGvHKIvKNMfTAeGX4RVpixeRfR4olVJ7kbB8fHQQgHMLgDOiBPnMyOGYDVhX+
 GbspiPAXYzk1TTYpeN7WEzcDj8yGF82cDMJ7Bh+7wdNBwbPjmdSGR1Y=
X-Received: by 2002:a05:6402:2547:b0:6aa:1cf5:6076 with SMTP id
 4fb4d7f45d1cf-6b17c1de908mr660693a12.1.1791529262668; Fri, 09 Oct 2026
 00:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-2-hs@nabladev.com>
In-Reply-To: <20261004040657.3156402-2-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:00:50 +0100
X-Gm-Features: AclHuK-ws77xJ-oBkAXgiTH3mf-IJsHD14GCeP2xSL_5x-LSJDavyJxJh3aTAuM
Message-ID: <CAFLszThVWu+8sLzkyyDHgEh5ipM6YjBH7xLsP=xi=p9JccuR8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mtd: refuse an erase on a device that cannot erase
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> mtd: refuse an erase on a device that cannot erase
>
> mtd_erase() calls mtd->_erase() without checking that the driver has
> one, so a device which does not provide one will end in accessing
> NULL pointer.
>
> MTD_NO_ERASE flag exists, but nobody reads it yet.

This sentence is confusing. spi-nor-core.c already sets MTD_NO_ERASE
for SPI_NOR_NO_ERASE parts, which still have an _erase and a non-zero
erasesize. This patch doesn't read the flag either, so it would be
clearer to drop the sentence or to say why the check uses erasesize
and _erase rather than the flag. Also, how about 'jumps to a NULL
pointer' instead of 'will end in accessing NULL pointer'?

>
> Linux guards mtd_erase() with
>
>         if (!mtd->erasesize || !master->_erase)
>                 return -ENOTSUPP;
>
> so do the same in U-Boot, but with EOPNOTSUPP as the error code,
> as checkpatch asks for ("ENOTSUPP is not a SUSV4 error code, prefer
> EOPNOTSUPP").
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> drivers/mtd/mtdcore.c | 3 +++
>  drivers/mtd/mtdpart.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> @@ -930,6 +930,9 @@ EXPORT_SYMBOL_GPL(__put_mtd_device);
>
>  int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>  {
> +     if (!mtd->erasesize || !mtd->_erase)
> +             return -EOPNOTSUPP;
> +

From what I can see, but 'mtd erase' never gets this far.
do_mtd_erase() first calls mtd_is_aligned_with_block_size(), which
does do_div(size, mtd->erasesize), then mtd_div_by_eb(). With
erasesize == 0 both divide by zero.

do_mtd_io() also calls mtd_is_aligned_with_block_size(mtd, off) for
every page, so I think 'mtd read' and 'mtd write' hit it too. The test
in patch 5 calls mtd_read() and mtd_write() directly, so it doesn't
catch this.

Please can you make mtd_is_aligned_with_block_size() cope with
erasesize == 0 (e.g. treating it as 'no blocks'), and have
do_mtd_erase() bail out early with a message for such a device? A
small test that runs 'mtd read', 'mtd write' and 'mtd erase' against
the SRAM would cover it.

> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> @@ -654,7 +654,8 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
> -     slave->_erase = part_erase;
> +     if (master->_erase)
> +             slave->_erase = part_erase;

This is fine, but please mention it in the commit message: a partition
only gets part_erase() when its master has an _erase, so part_erase()
can't call through a NULL master->_erase either.

With the above:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
