Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24624CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 07:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C94644068A;
	Mon, 19 Oct 2026 07:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1FyM0VhR2No; Mon, 19 Oct 2026 07:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A5964068C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792393450;
	b=FGxWsC9QOVGrhsV4vHGNs+C2R6Yqw3pKQOJcBaLrBj0ICLNCfUCHzOwzEwOWzSPMHHTj
	 ydtQFJxLdh4LNgJIM2pesYMs6ZbCa/Vmw/OIU0rOMYrsqDTi3xUZT31ex8YJ/k72RlgpB
	 Sf3T/hFDzCpXVvSVGX/Ny4V6fXKt72rJETHrkhYwe2khyuvT/l2T9n/SBnQorvj0y9L2y
	 Hst7BSqJus5OGQc5diszJaN31IaZ51TEKzkGQ5mM36xzGlrS2+ibA8so1gTJgcx6YEDVi
	 FhmuG5o8SoXR2iefAp4f9MUo3zo4OuhrcwiDii4j2irDs17oi7zQ+nOZVcX3Aroh7cQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792393450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
	b=tKSTbbjvkG4z0VwfSH4CkEo97ZVl6CwOVrgbtZeG4pR62deY0MXpSHLgA96ej2jZJIh9
	 DfSmaiQFnm//C0ZPUh5tr+HVxm1Fjticw33U3g2GEzUgTBbQGCgh7snOy7q6x6bynYcrG
	 ZITRAuK78OlsXtnPAdtkzPVYav5nxHL8NaVIwjM5es8n9yV00ztNkWoxAmL79axTExzvA
	 4irDcbqkZ2PV0b1/5iBIhXeVqL7IUD4BK2VPHCNpLtph5VL0Oic5jAcj0LI1Qk+xir3AP
	 b0iIbTOFrN/5w4JWnQcWWEP+rcfuV4wNDLoss3oWYBGhoPLPGAXZ/4U6v2Ey5bwvNDA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792393450;
	bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SVuIz6PR6TAV9cVbuH5Xec2WJHehkpK5UWNlS8u6nx7twYbjHSkW0eUnKFeOEURPZ
	 0BknXEjcjFSfSjpIRw3BXn23LVovCrnEbvuf+fLuXbj5Ox7DVEni+MZBndnxNtyhnr
	 +sHzZcEDvUxWQ47/ZdUubJtmkPiXXIffdIlWVup9vKEDS6vYxXWzyyC5rGgkghUh8l
	 4rC5AqnmfDLgVMiGAcauNFtBZWx+3Sr51iN+lkSf2PseLVsqJVGj83mUNr1dwugnkk
	 eeou42X/MSVaRs7Ny3PGs5ZzmJEOLjMo1Ge6Ghy3FzdoL1Oz7gHxjOODqItWqVG48i
	 041J3GE3D39qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A5964068C;
	Mon, 19 Oct 2026 07:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 368D21AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C29A80D10
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 745412mOzs1E for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 07:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22E9F80CEE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792393448;
 b=IPXkaVqIYqyiLzNLDR13g/OM6gnSQ2v3X0CBf6jGWMS5HQSwjuB6KFu08lPVp1MVka9l
 yNK+o3uKIHZQPsX6f6lso1bnl4Oz+F3LpKWV2joKey90LfZE8FPi2++FGyyvdUYc9tHm7
 0KmkY1b2W2RKlOID5ADjotAPjIp/lhebXZGWd9iY8LmOmfc6HSopMznDuXZi608hG8vci
 VyxAWPGMateQueBFM/wXaFHnPvo0X6ljvKNQkambwv9teLxWoNcCoVfsyTehEyqSLjqoA
 Xcg+GzzLRjfa7XP6l0xpjyKLIMl/TnNTl4eXmf0KS50YYZT06oewSuxC43YVbB+Tk+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792393448;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
 b=K2A/kI/pbI231Jkc4hdXytWcLQV5J00AoT8Lar4YOwLvRtCb7l3D1fDuZlJGMaHcgPE7
 33KuGGKUQYRKk9BR5Pmnbt4vrVgSFGXow6S8mhL3nYUoDGgnCZKPtKE+hn1SidO1hfLnu
 S5e+iCh0BapIqiad6oofafKtg65X+4s7X1k7Ap80MbJNOX7eNvjvbel4ObvxLrsyMQxMl
 FrxGcBP2l1CKK1ZcHkYDtqFUFiojeCyYhw4GQuqDVGwDDhrGULeUBfg8a/3pFJGTm5X1Y
 NZ1tsePH3PqVv/rG4tM3AI1BrCH3Mj+NpeutpFmUqcUGDZScwyhuj4xye2Rh20kU3hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QqF4gfCL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QqF4gfCL
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22E9F80CEE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:04:06 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab38a051aaso13284147b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 00:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792393445; cv=none;
 d=google.com; s=arc-20260327;
 b=cNALF16D8DI9kVJ2HWvo/c9NsOmNc95cHO25x2efX8RIGSkpjBrlG8Ir54+qtMSC4P
 Sk8F+qGsQHWpV17Sv0VNHIWpeAj8cI2eNi3Fl5iNKgPORS0pXgFRJ6+V4R+D83uwOR5b
 ZTbdSYZztzfC8d2vABI+wQy7TLDvtI8ID8ONoWd3V8nw4qhEpqvwCDw2rrbXK/s5PjSR
 Q2pfVV1hNDWmDTjSrfQ3bWSfViIQ/Fy1gl/uuDJaAFeCY5gXZxw0UoMzjNStnkI3xvpO
 EErAKvMKDKCEGTliB7xrD+cnPejgt8vmJNZpX5toFNSVC9MtX8EB8sF2zQxOSZj0EzgS
 zzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
 fh=5jAyG0z1y1vt7kDHpvQqesI05SavPNL9BEc7XAG3o4Y=;
 b=JLLHBSLN/oi9qkXv99yjjasy4B0xMNJVX4Qt0jQ8I0ZvJW/0o2MFnx3oV5aYi5S3g1
 qaWSp19FdMLrcI3vx6KNzFvx/Qxiz7vllxbQ0ShIqeYAcdZxKmdPG2S76f4yRYznTvSG
 MwfY3hUssCbH6i3NjkWBmKTlldR3t3W9hUFyoVrSEqYquEGUzqA47yLhJF238lO+NaKx
 Tk/iw93lF4EZnXK/Rc7wlBLIlwVruS/A8C28N1n+wbkaf3+zGUa7gS9BSWLxSwToolom
 9HwyUF9A8xNuGZiJIvVTlLfFe+sRD+PyDp9k3heaBtCVqTfsIuXPziF8JNm0+fOBKjiW
 l1fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792393445; x=1792998245;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
 b=QqF4gfCL88Y1OLprd8YIz38H9r7N8dDmZUl04i9QhFdoOXh+pxFHSV+rnpjboCzp1A
 YHTUDwdudD5a7Wtf5GKf+Swi4IcwJ6wtq6abDIzbX8wvKEgMabDdkDhcj/SALxXG4umb
 X41PqxMmsz28LHb5flKF2B0WX5bYoQpxQqzyZ7Mono61JJm82Di0NaZ5950Cih2j5lg7
 w1eMY7TW+sIufYckxSocWL5SHVWAhwJLyB78C43CMyDdUbA9XhVCx8UkPqgplugMPAlR
 5hCQtdDiOlDbDLFPK0PrGIuqkmmS+L3YxrobbHiufp3DDBTdEwhh/jAqd1V1GzJWijL7
 mTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792393445; x=1792998245;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qc6kd2LtIP92U9JBShGOFHRm/PnlAt7zoVtLD/BePpA=;
 b=VMwkjYX7vLHtMpNZcCVXZcypmCWVjzqVEL1QIVQ0CbM1iUYTd6joaPKKTOWAeKbgNW
 oBEJiJoQPpX4JwdqpAw/PuGY3Ai1JmsWu1aohRKxl5nsdPPoeQT7R0tNl2r8CD4igqYf
 Qq0UwaEhEaoaLUuDkK/GQpQRmh/NnzJfZKU1gvStIhjFi/A3DQrMJuWHdKnC2F3sW7bq
 jpLF1qRcSr9JA6yZqvkzLmmqLWvv7rTwbwXTe4jzcsdNHeV1bWvcaB2lUYSQdXSOTvXh
 oBSPmiJo7VeVjz/NIaivjzZYisJStZ986j1KfXjT57pqp5BFJ3twgUSy2Jn+g5d8APoV
 s9Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4nOO97dstt883QKUKGdzsrvdxr5lRXGmqL1CcnBdUVjUrfglktA7y1eHfVF9WKuMekZPnqbY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKopuv8S22yKm78u+dcQ5pKNRc9pnA2BFqLeEkxgn6St3n4DXdk
 yOx41XB5BIRtPjMJZtwKnexAWfJl4QBfnKP4SdtoV631stvHlm6RuX9i53Z628bfax4HW8rGJbe
 DM+6UNeMyU0XjZfSgw0x8i39uO8Fz0vkr4G4YZ++95A42CNnb2RD9b0hCzg==
X-Gm-Gg: AYBFou22ilWPdD0Msfwz2nen05ttSdX0/T4sZ6ZauvR8XfpACuuxsCFdU+BLeeKa7+q
 nFciuw/E0dPmyzX5kKpP7cwTazM2gnIcftT6t/0KBcV67g62TiknMgdMxdpTbUCJYuirFHJyY7c
 dB5/g7S4ZIU4nifhcpp+mHONwRdXNkyLtI5qA4tm+yxjJzjCMynwgVqUoQvHMQfdHJ+2KcNGdn5
 zsMnG6jDta1FtAWC9pBRKCfcaSvigKx0LmC9c5K4qSMAWkdz5ZW9ElRMpOdziFxxlnMf/g/TTp5
 bI+kC2D62ewdrtbXHulOzo5FWG4kV/7hdkrtk2QTSgGYfib9mK6HzT31TeQsUBEQh9H3uK3DyGQ
 NkzfNu+kdz8oeiiMxMlbYrvZFOcr6COUyZCdkK5SNuf6PBFk7r58/HB5cU8tSzqej06TtivwP7r
 y0cCd9fOuK3cWayKKyofvKpA+DZ9Mg7FrNDnCTRGWwChD3ZoR0cSLs8gXp+QBaK8P7d01nI3fGA
 vicSDj5YUbCp7bkQaWTFlkdCDo1FIx6wdT8jkDchKdjuc8Ztmqfbk4LnY1N3S2B/YVk8m+uq3xi
 GIDL4WL8rQcJ1gG3DSUf/Lx3x8in82fQoBAkHPPd8vdw74ksJeUkjgbpo8RjuHojJx67YwveXtt
 jNdG9NEte7u6BZkMYddX4gbqI3KPQ6espSH6to3AMRcr9ATli7j6OiQ==
X-Received: by 2002:a05:690c:a6c9:b0:893:44af:ceaa with SMTP id
 00721157ae682-8b0f205bc82mr16985087b3.5.1792393445424; Mon, 19 Oct 2026
 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261014190605.2229511-1-alan.tseng.cs@gmail.com>
In-Reply-To: <20261014190605.2229511-1-alan.tseng.cs@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Oct 2026 10:03:29 +0300
X-Gm-Features: AclHuK8b7kynO7mCzzoBQXRtKhZvi3bKb1v6EMbsFCMc84TrnaN6X6JnOgo6F8k
Message-ID: <CAC_iWj+nJ1vZWaypiUqtu=+RBUsLebkM0CEPY9RGcqJc2O7y3w@mail.gmail.com>
Subject: Re: [PATCH] tpm: v2: Fix the size of the random data in
 tpm2_get_random()
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
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

Hello Hung-Chun

On Wed, 14 Oct 2026 at 22:06, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
>
> tpm2_get_random() reads the size of the returned random bytes with the
> "w" format of unpack_byte_string(), which stores a u16, but data_size
> is a u32. Only its lower half is written, so its upper half keeps
> whatever was on the stack, and the "data_size > this_bytes" check
> fails with TPM_LIB_ERROR whenever that is not zero.
>
> On qemu-riscv64_smode with a swtpm TPM, this breaks the kaslr-seed
> fixup on every bootefi:

Just a not here, kaslr-seed is not what you want for KASLR. Having the
EFI rng protocol is better since it randomizes both the physical and
virtual placement of the kernel.

>
>   tpm-rng tpm-rng: dm_rng_read failed: -1
>
> Under gdb, data_size was 0xffffffff before the call and 0xffff0008
> after it, for an 8-byte request. Whether it fails depends on the stack
> contents, so unrelated changes can hide it.
>
> The size field of a TPM2B is a UINT16, so declare data_size as u16.
>
> Fixes: 06bea4980980 ("tpm: add TPM2_GetRandom command support")
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/tpm-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index f443b738f..4c7dfc556 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -977,7 +977,7 @@ u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
>         const size_t data_size_offset = 10;
>         const size_t data_offset = 12;
>         size_t response_length = sizeof(response);
> -       u32 data_size;
> +       u16 data_size;
>         u8 *out = data;
>
>         while (count > 0) {
> --
> 2.43.0
>
