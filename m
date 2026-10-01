Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC268CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71B3060B18;
	Thu,  1 Oct 2026 16:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKABMI2_XkzN; Thu,  1 Oct 2026 16:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A64C860828
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870400;
	b=cYQgY1i4K7l+2djRSVABV2T9pLpdr6ABoSCUxrDdth5iyBZLYeXgmmX2/Ws3/T/YqSjs
	 YMhdaP1vz0wW9Eji5l+d7yyn8NwdfaOwFguBheiydtjB9uTpnZOLuEi9vxBQJjRWwF9RP
	 nPgfTPf2260aB0IsivXbSjCZFfiI5PQWz7s9Pu9hoNKwGwFoAcnNNDRfFboRXrxBHP6fK
	 ETTGmlF/5akVpw6w4GWgSToPOQ6xSOoc105XxCMySLXQE9jM0UG1REMpVlnDEARZxCUPc
	 q13WH+ld6iyvv1M3XF3cs2YdxQ+5ESEneOERiGIenmi3n9l/PzmKpaZFc4ktW1W96AA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
	b=nJdSy9lZLwSygMhGBLgZlOc4k0gOZ1ZkdNjz5wWfc2XTN0fRn3EuBSiEDcJfkJNG8J7e
	 CS15cSjVY5YqfA84LiSDYuVObUka9bvRabzG6os6j84C05tXQ03FlKZdCRdy1OIv1cSQE
	 mpXExWxGpesyPP5oyG8qVnj+8ruX+u9F/5FzMk409bz06OkaPzL+TiEr6AGIf3E5cP+GF
	 +itYCbHRcgvLc1VYSn9gTR+Oxro+Ts8IHs9a+Cc5pl3esO76LBcQaIIe7j0rXIU7GP5fl
	 PCloPIJYNm6vWLLPaDaOUla0LtU3pM/VBPPmpw6VanyTNCyvd9S38qAJTAsGa8oGdlg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870400;
	bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUgb19JEk3bRzTzRxkbpP+k6WI86RDFa5i75S0SNiUlw9J3MW5CNM5hK8jVbnzEkZ
	 qlyF5ngmB8YDPiJgcEfEnDCUn7FvyP3fqwJaAXVDBYTXVAVjoGedosLmDqJL99RjbZ
	 XDZF5CKtWpXWRPI7MhIv6vv0TEQaaklzpVCW69rT+eA8H+hh5Ssveqrezrkbnic/jb
	 BctLfqTVYa9kAmS2fW0Do5MlbOwcbyc4KAD+mNiDEAbtUMIu08h/s7BnZJa9YAxEh9
	 3ZtE8Ft66PFOrcnRKBQKNPJpas0wfJQtX6p2M4NHo6+idgU5yG54bUJvwq6DqDaBX5
	 eX23hHkVb4hpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A64C860828;
	Thu,  1 Oct 2026 16:00:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF80032F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4FE440CBE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNF2ad5qi0lH for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A044540CB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870398;
 b=GnjyX5BbHDEmgDmzFYKhSCTf3FiNLUYPF6a4NnzA6qtp/ygjsevT/wP9knqGHntvlVmY
 sgK1wdr/DOg/VwqQl5SAPCnmeuv8G2k8IJmuX/wu+mmgbSc+AmjtzaxNtoJcpyDVj7cqU
 E3FX0cfmpvkSrSDOT+jDLhAl9IZIrF73kyYBt1gfzxsTrwR0svoz/YOneF4qu435JyX4E
 I6AzGHyeHWrP/Udk+hLsvuCaGdR5xZ3nzxCOT6m3QNcRHVZHFxxmUQOXMd490cR3IfQ01
 DRGpQvvB21TTGTQuD5ARaapk/hrcSpT20+p+BvAuXjlWGTevN4MDqrUoMYPoMYbijbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
 b=HlQvODjJo7GjhHDwNr98ndc+6sy4hQEDfADQ1Hl+1n5tu7vC1m12zJWAFOR18958JCTq
 fSTmpYBmwElZfAhO1rIM/ss0dDqHY0AgjXRajIRo7vTHGEtekZWS0Mu1Mx153+Z4wUuF4
 yt1rVu6lh6RUpSv29jTxqfLOS5f1I0zjRhFdw464Glm4GkY/LUDACxyOqMYQF0rnzUjWn
 wpUpBn1javSr7UCOg8qMOxqsUQolAMkWtjCOzhyO/kgQK9NcbiDby2dZKhDBAkC2Parkr
 Kq+dHi1HztBLu68TjuykcZy52Wqx9N+q2hyNoNmxyvmX6othvMy4Adm/BaYXaq2ARjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cQn9HMZj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cQn9HMZj
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A044540CB0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:59:56 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaf10bf094so9765299a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 08:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870395; cv=none;
 d=google.com; s=arc-20260327;
 b=hQGwI9J+bkq+ett1V7VZRR5zpIG0vEjXl/QwuQMFBzWr/yuSDOMQUmwUxKfIQh5e6+
 fmxLL7hvsv6Dkw7LlIn9Q0BlxuVLRBfhKOJwh1qF0FgcVBtnOFUkhGKDC23XD9l2eX9L
 Kef9vqOgdR0TLsERIzDlxt+XbbIAdO8uKUFqw8mmn3kuJ2MclgE8KcHaKCvzJTrX6iJ/
 x1p9GPWoP1AvIK+aZLpYSkSfYxbGShAQ9krimiJ5kVA2rymJmsMm6oLv0/jUQpWgiSGW
 MJwsOETKQS0TMzqji/f2K+udYAdV+NUmMl6cezRWBdzB0JbDkVByWk7pYRkl58HMQqI7
 0+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
 fh=9cm6Iccx0xZRJVFqEoZOk9A1y5F4RO/H5MXuti4jeLI=;
 b=DwzdCav3AhRQS5xiYxrLU0r3i0lCCRXXk6FvlyrjNleAwkshAn1vfJ3zTvRiqH3sT0
 yLcbJu8P3NRCetL1RsByI0ehbDTLnaXPKU0roZe0oumyMYWNLdu8pDueasLotMbwovyQ
 SNI2A03s1ZC7DCbf1JmY9Tt0u2bsPvoa7Axxo9TSCqysKfgmY9QqgbIvS9a2U+/CdPxv
 b2TDy7HNM7oW8hKy7Pq3V0jMVaCwVcd+g2lxeeHQLGrpdrx/MhFw5h1jBzhAuVIt6dd5
 VS2q0bGOt/+Jcf/EnSod5zAY0I7/Aazk1n6PD9PRVe1kVtLxKBKEjpDemZzrhMsBJTID
 2+1Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870395; x=1791475195;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
 b=cQn9HMZjjdWVGl11v0Qy6YZAxfI3V24csCJUg7SzcgDWssR6xgbIaFRNzAqaMkMkEp
 cmi2va7nuYgsyt+KrlMkgCEcWVhZfXxZ8thK5fX6saG858oimm1c32iy6LI1GZV9Ku76
 7IpjaH7MY81s5ZZGqsA9I3F3V++a6e1vb1Gg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870395; x=1791475195;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z9AYOyEwgYqmiwpExLKhnrEOifpoHcPqaS2iXhqVN98=;
 b=fRRy+LKnFcaNbVL00qn93uytS3uj6948A5dhVnjk5hK7itRmhLoL4dC/LIkxBQi+mX
 HyPVJ3BcrXQgTvdkmEI21hkG4xpd7QnDrE8mtBXnkVGrIIncqav72ochNSyFvuK9dXvj
 mtabqCct/rAgNoHHhjMK5p4ycw6X3Ly5mwTbbpKBoMSgscQ8WVZH9molC/6SNjwDr/zB
 dZor/d2VJMKnpQaIurD86/RqybDAhJh5WNFjL6u+sUEdWdHbE9GaEcF2LCUmEpXF3h40
 qnbXAW5ha9BqQemEMqjXfVbnJXxt3utRkoZsi8PVprzbCGDACb9PzB+OKTbxm2EFtWYv
 KJsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY6fjrmSCdRYzXxd+7VH7cAAIfqaKdW1Y1fwNL0WtrU+0CIGuh9vHzlVGqrcOoMBG8vgV0WHE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJbqPm3atFL5XyBlB0BwmgSXTnMPxT4e5qY9vBBaDue7etFzVnn
 Pqcn8J6C4L2FVFgYXOg6l2kARjo5L0poRSmVzTkfH5vx0lZ8QNGzl6+/b0gM2v8URRyEREJ3CIU
 cMNLDC2szHoH5CQwvlQvPV7++9edbMV5msnW74ltv
X-Gm-Gg: AYBFou0pctQDGlvLGrCR7V24scirLBzUckAfdylfdMkjwAMkANABAoiNws2Io2oUrJJ
 gy4iFnEm6AWF8QCzbYQX6AfrI3x6OgsHiZBXKA/JMQJDDjXXM4n/GDqGWCcoU0TYTVhVVLxdYPd
 ccU25Qw3siT7rqzfv0FcU5klcbveBQ6MAx/UpGYlLjFm3P+WPYlBh5ZY5pnU9ooOflhFygfhqbm
 +PXiGHaSIothJPTtxcZcYIyvhNjKi0/z434BdDvUh8nnfTAVZoVs9A2WJ9LO2yfSZ1KMsbgPVPb
 aXtnZjy7Lcx5+O0WLeeyP4Yx5DWYjZIepK8Z+g3jhqPLSosBhWWbzkGy
X-Received: by 2002:a05:6402:2082:20b0:6ae:1a0a:ae9b with SMTP id
 4fb4d7f45d1cf-6ae1a0ab0e4mr3271545a12.25.1790870395007; Thu, 01 Oct 2026
 08:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <891afb4991f1e6825b5715fc918e9a9eda210bd6.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <891afb4991f1e6825b5715fc918e9a9eda210bd6.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:59:39 +0100
X-Gm-Features: AclHuK_eQ09OJp1PFwWn2b7yDH5Mcrfx0TQbo1-By7IG29llGVwDTjP584QfRU4
Message-ID: <CAFLszTgKXnNihqhE5hHv0FU6ZwTzX8y-65i-KjaLF3y_Y+fuzA@mail.gmail.com>
Subject: Re: [PATCH 01/11] mtd: bind the block device without leaking on
 failure
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> mtd: bind the block device without leaking on failure
>
> add_mtd_device() allocates a slot to hold the mtd_info pointer that
> mtd_bind() keeps, but drops the return value. mtd_bind() only logs and
> returns on failure, so the slot leaks. A failed kmalloc() is ignored
> too, leaving the master without a block device and no hint why its
> partitions are unreachable.
>
> Move the bind into a helper that frees the slot when mtd_bind() fails
> and warns with the errno in both cases.
>
> Fixes: e8a7453824b7 ("mtd: bind an mtd_blk device for non-NAND MTD masters")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> drivers/mtd/mtdcore.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> @@ -396,6 +396,31 @@ static struct device_type mtd_devtype = {
> +     /*
> +      * mtd_bind() keeps the passed pointer, so it needs storage that lives
> +      * as long as the block device; an MTD master is never removed.
> +      */

I don't think this holds for SPI flash. With DM_SPI_FLASH, 'sf probe'
calls device_remove() on the existing flash device before probing it
again (cmd/sf.c:135). spi_flash_std_remove() then calls
spi_flash_mtd_unregister() -> del_mtd_device(), and the new probe
calls add_mtd_device() again. Neither del_mtd_device() nor
device_remove() unbinds the mtd_blk child, so each 'sf probe'
allocates another slot and binds a second mtd_blk device under the
same flash device, while the old one still points at the old slot.
That leak is more frequent than the mtd_bind() failure fixed here.
Please can you either skip the bind when mtd->dev already has a
UCLASS_BLK child (device_find_first_child_by_uclass()), or unbind the
block device and free the slot in del_mtd_device(), as patch 3 does
for UBI? Either way, please update the comment.

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> @@ -396,6 +396,31 @@ static struct device_type mtd_devtype = {
> +     kfree(mtdp);
> +warn:
> +     pr_warn("mtd: %s: cannot bind a block device: %d\n", mtd->name, ret);

mtd_bind() already does pr_err("Cannot create block device\n") on
failure, so this prints two lines for one failure. Not a big deal, but
you could drop the message from mtd_bind() (the SPI NAND caller in
nand/spi/core.c already checks the return value) and keep this one,
since it has the name and errno.

Regards,
Simon
