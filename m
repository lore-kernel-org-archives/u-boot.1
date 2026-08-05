Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F10C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 672A980BD7;
	Wed,  5 Aug 2026 21:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNAfmB2TBC3h; Wed,  5 Aug 2026 21:59:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CBF280CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967151;
	bh=0HOUglhm0wmM4/PCHwKPxfQtVTkl9dTNulnzHRxML2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FphnkCGUKJxBjmymbNP97fiBTt0AylixE6mDFmepRt08I8/woPZColN5tPIQxoBqT
	 WL3KShn/V7Zc3w16JnTBJlAOLWERvlVujfbeuD1RaeCZTH0jvkpdv7Mg//259ljQXG
	 Dz8uSU6gcRPg5GIe2ydhAibcCWnmQ4nFRPexUWmYjmpZMOJR/YU/8hYT7mG0MTBpGA
	 QAkWT10D+4Jsiy6abFKF0ldSKzswql0NoaCRAKWjCvQU383l89ambP7wWMxbANgBq5
	 Y87X/u+bqzAq17ZZY2aCvTLpqKlnQAnUUU9/K4rRcrNTYR8nPz0N7ByvgewnfDLzRK
	 7SqcxFTs2QvXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CBF280CDA;
	Wed,  5 Aug 2026 21:59:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6212218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D818980DB0
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zC0tksgxT3Z1 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:59:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F026A80CDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F026A80CDA
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F026A80CDA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:59:09 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so57998166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967148; cv=none;
 d=google.com; s=arc-20260327;
 b=G26YoZfLdBgWAaDI2+A/tI5vZ0UiFpnpCA14+3jlqnaz4+SDD+HlfUbedj21aqS97l
 urBK36TODp7K/LukzDNhg/Gi2vEXHu/RGRxLtzyDSCaDszOT1lNJxwa3PDi6U6BEg/qi
 SUYqnchApQB+BRTXZCKsqafoR9kpMqWj47i10eoh+GhprzfLwSRVILlp176TBHnrxW4r
 AswjvCPez6LbI4jz3FNppylWLf3rLDq4tol6CToJTnaJ6PLspCHUgd0cc0EDU4jSBBQx
 dgD8erFsaHeygBOKeqbUMzD81Pwylu48ULvjE5cipt4Eh2lBsqJTBHV8rljGv8h9GF9W
 nsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0HOUglhm0wmM4/PCHwKPxfQtVTkl9dTNulnzHRxML2E=;
 fh=HyFQaPPEQeDUys4T1Vgoss3sukzzAbWkhM4W77NfPuw=;
 b=R/WCgSvsxOdb/VmalRnWw3eIswka48GDhdRpm7vbPRHz2Lnz3pI4x65wEJbpvRJYPs
 GiDarQ/RWec5gLv4kNAUalrfSRGAUTCop/KLXapX54XKdQ/fbrIHM+1fKXsYnFWir7nk
 Qpn5ju9UCAsWpvkcfYfVkYs/zS+N8B5jlI46Cb8rbzhXCHwVkGmnTGglAq33PwU2ZZPE
 Ep/XiGJVfCrxhukm/AAwXZWZGjVtVATvqqYxxhw16obk7NuGL06L4VT+C8lInmxndyVE
 7ig1LqGPo4xGptrp7b9QW4BPCq4ngMtLXGi4wbUseJhXC6H14P2zw5Y5995iiqT1OTmF
 WlcA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785967148; x=1786571948;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0HOUglhm0wmM4/PCHwKPxfQtVTkl9dTNulnzHRxML2E=;
 b=NKQJH5OKyXnLB+/yHRO1h4RJd5YTnXECiCChI2XN+BPKfnxA0ud9/53w8o6Aewr/oF
 cj2XIo2+ON+emZ/NrQYn0T6C2WDWZp0wWNja38GHcvxSP3JfUn/coidze1pl7WO9PZfw
 hZKS17+gUN0G37JYZNdR6tF8fCmNqb9kcuC5k/ecv1+4SufCxQ3PPISNkhVcCaTWm1Lh
 owjOw/g7mdGoluoFZy6/SkL5Inwl/31w0XsHGqQBlWXgBjSQTcyCPJsujcqUM26KReTw
 YOAVzkr5eGygSEPhir+T5Cy1FhciiWgDfqKOX45exPrHTPLp6/zTAdwNaGpxAruaZqKG
 4UIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQoeFIHCE2KL5Oj3pP61xV4+k0E1DOFfCnTnWnrOAIzaHWpPUUQpEdAUsNZj1krM6nFnwFXCc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YySlYeaW0AAZD72MfWO42xH+9cAps/laINrMiy0hxvUrpo43zRq
 MidBpu70UqXNX2yc856mknidJ7+19sniblmpcrAPGF97h/l6QsNoVZ60XvCTMTtSBYNFU4WtK5e
 w5+LJ8wrf6Q50v/+MtVArLTRKM7hmVUrC1pNA1F2O
X-Gm-Gg: AR+sD10yDQoy6sInGNuJICU2HdR6TlWdpn6JJ5er1ue6cye2jRl41L8jNcELG9J+jk2
 b1BGAlcCQF+Ig5EeiAQrsFpHC+lEBrxtKFmSwFljPta2nTz7rnY+aUaz4WdAa/53Ru5Thg8+agO
 c7ejnEJGS/SV3RztvfiHaNa/lSxrOVaRrxwTCo5G3bBMiO4wLzqvtNG6SGbqwDU2GjEGiqp1zZC
 W3pTbtC7Dm/PznX7lClzy5KXcZ6JNds6FoBwWkjbnjzcOaV/D9CudACOpvnOJLjoUlw+m+o9Ndu
 gd/VP7CafbZDdggei0faZUcA4dkaPdYzG3EszqBCkHrPxYu/3ohr9A==
X-Received: by 2002:a17:907:94ca:b0:c12:c5d2:bf37 with SMTP id
 a640c23a62f3a-c2058057245mr117173466b.12.1785967147908; Wed, 05 Aug 2026
 14:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
 <20260730-math64-resync-v1-3-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-3-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:58:52 -0600
X-Gm-Features: AUfX_mwHpopBTwPWf5ZL2Z3njzRPEY9r5xUJlsrVpxUHX7svKVfKEcaMBWqyQBg
Message-ID: <CAFLszTjCk=uYhSbvtwBog_7BCfuUjCLxiUDJc+bhVZjNb7iJag@mail.gmail.com>
Subject: Re: [PATCH 3/5] lib: div64: inline __iter_div_u64_rem() into its only
 user
To: alchark@flipper.net
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785967148; x=1786571948;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0HOUglhm0wmM4/PCHwKPxfQtVTkl9dTNulnzHRxML2E=;
 b=EczPxcti862ZecL5L9QPmn/davipjE2L6n1hZTQjIn/TiX9azOLIfc1MeRaI2De1Xb
 PMFUDXgiefe0aMqj4a1EJwFb+01lY/HryLNv28G1mupfbW8fzvFnPjXFHsbvAMxo7SCx
 8upbFAcqK4az6wSDFC4gp4C1L7sS6EnNhxVYA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EczPxcti
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

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:
> lib: div64: inline __iter_div_u64_rem() into its only user
>
> __iter_div_u64_rem() is only split out in Linux for its vDSO header, which
> has no use in U-Boot. Inline the body of the helper directly into its only
> user, which is the iter_div_u64_rem() wrapper in this same file, and drop
> the static inline, so that a subsequent resync of include/linux/math64.h
> against Linux does not have to carry an exception for it.
>
> include/vdso/math64.h is deliberately not created: its only other resident,
> mul_u64_u32_add_u64_shr(), has no U-Boot user.
>
> No functional change: the generated code is identical, verified by
> comparing objdump -d of lib/div64.o before and after for
> evb-rk3288-rk808_defconfig. The compiler was already inlining the sole
> call.
>
> iter_div_u64_rem() itself has no in-tree callers either, but it is
> upstream API and is left in place.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> include/linux/math64.h | 19 -------------------
>  lib/div64.c            | 17 ++++++++++++++++-
>  2 files changed, 16 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
