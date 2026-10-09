Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4B0CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E282810F9;
	Fri,  9 Oct 2026 06:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGowoAbMdiYn; Fri,  9 Oct 2026 06:58:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71778810FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529087;
	b=Rjy3x+rSWwG0K7SnwsDzIo3fMqMSiWmVU5JCmuaqFbMwi9imCaEBHN+CIiQWMynGjSZ/
	 X1YbMdV5M/phDP4heSOvnfz8ZSu4u7sqpCY4/o3heQOPdzRjQ+RooatCZFdZ2ltfSf8y8
	 6ZyP1yJllBoW9V5tshOl02MghjGjILFX3rz5l3rSZPqwBFWAwPTqFHA7laJ4f8P9C7SK9
	 FWMllF7iA3pqCW+CQVa95Z/Grw3xRxyKC0n7Fh63TW2jmKNpwuz6RB53WWx/FI6PYNXbw
	 sN/YXzn9GhDqT5HybJLFFfMrt2mAKH/gdYD5CXpZdw0z/YiyXcL3lNFX5iVQQb7EjtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
	b=azj6FvI/ws0E0RAnFxIBfzwBlJJhnUk7YEDuoVF+i06XTXqc2m9tjZurX6KCaLxlk7Ie
	 PpgDJcfJwPQjJG/dYTNzy9daQrrq7wXSNfR9gfPeaD5yjvpaXpTg/AllhQUn6zN0U6LLH
	 ZKSiOvcMUjWl4aaOcm5lHhUhptbKyCMIEhfjWhSe1+WjIHrlkEM+Y3GMwhkcEXt/M33lh
	 971vOX5JBUDt19W+tPNv1pszqJAP/exDLFIJFqz24oKCpcZlaVM8EMylZX+Cvpxyv+tiL
	 nlEiR2auCseWdjNO/EijrWY2cHS9MafaFq69LwubxTRXUT7HVaFLMs0VOmgcmuy92QQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529087;
	bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XlLaKUj8pGtdrkYczNywlCgOau/5ac+0psD/jUDagfu7u/ucOQHgvByRpMF+ULi4I
	 chKeUFBxUV/Uqe1Veoc0Pb2oup92phOBgteoP6w2MPatgWuuMcGNXMESZ+He1caVHx
	 IH6Iox2UNWoSkcgsIPnE6OpCS7dp8LleKMmPk9V3M5umHAgCLAXOcIsJN2z4bThMqA
	 iXPGcAmBVnqJhOlv6eqHHo1frK/JGSm/9HsW8lFzH+erV9S3gaH4tIzSoFwKa0Jgr1
	 Iu0w4Rh7E6rJPYqm8R6/12U0lQq8RxXnuymKeGKJkMffln0ROwwmZhytzOn3Im0B72
	 eM1y1O4CvOwvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71778810FB;
	Fri,  9 Oct 2026 06:58:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 080A31C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA186066F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0GPDRuQV-d3 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D970760658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529085;
 b=ZQxzzNumOhJgJRHUQFEXQ+5/Jny2Hr9SXBKwg9nPgYVnnDrNrKv0DnZ+kKL8QCwrUExz
 CDLkS4O7nCVHt2b5tFDBdoHxAJYiDSsklAYcMA11+13gYSrjGKiYuluBmbw6xA4Cw9HCa
 +RJQWzED68uQQzlXrPyaaIrr6f2mQeM8lJcbDCB673chAsmniIJxvG/idftNRyzOXF8t2
 DLDzBhgSzKc6KgUlF8QaB9liyobbk5QiMnOY9NM4N5u6yrspeqTnHIWXLm6X3xz1MsKYq
 vvpXDnQHyNe8UezUs1E2m7dSf5tJZt342Femv5Emt29mhRw8bKDi8F0czev7OWbTfzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529085;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
 b=IInUaSNpV79kzXhyGzc9S8cvY6zrNo4uWg+op7t37eU8KKfn0rncyBNQ3tQHhkE3I2hj
 Xa2V2a5Tsqy2EWO3N/lC17ysOcJLin8ZrFPamfcxBRHu2VGMozIP4JOxFioKDWyVCq0Dq
 1/JPvcTxEPec/dvcYuo9z36Wtcw67ndfURN/6N840KwLLTtiIqIQlneguOcsN99t9SVHI
 G5omzSOGjX5ChshxCrfQw/C3/LuRL1//b7j2XERPGWZEaQ5k9sXAKftj7gZmETpqk2iiI
 fvURYBaeVmoIf0fXXuK+SDiil4Y8+p4k42Gdjfkm8VaITksR/aSTzSIrFJ5c1F/FIpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Q6UlyhrK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Q6UlyhrK
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D970760658
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:58:03 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso5084748a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 23:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529081; cv=none;
 d=google.com; s=arc-20260327;
 b=isJ+eW9CdQtQM4izoFJzXX7g2ncVXUMYZ/6e+dkdvuJjw3o5iFvY4/JNu5QPa4XN2w
 s9UMU1IpILjE9AJ4Scb/m6HfT7wUDnvLPqOvCS5mlwKikW2LhsXFCfcUYgiRcPHdGx7b
 xeoZEpJ8C3DjHPQS5tTbsOoeV3xBVfOYdTgNGsY7Z+/eAcuZ+T7i+TGFW/iiJNV+6SL/
 RuF/tFa3VsYfma3co1MIjuiPwndCSp+TbFYG0nyher7Ns8CxH9V3T8sWQVs38cWOqDhL
 sICqt6ZwY/QP61owOWqvL18xtdXcVk62wtbtYzT1fGMjoe3cYsiNQoM/bu16v03++kaI
 J3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
 fh=WtmmfRrZljW4yBA/qodIwmg0Ple5YJWOzrc4N+DzYvo=;
 b=dxyYqWL7/D0oUntYVY7gf9SK7qzL3++ZditbHkuczAm/IivESUKSlICAZL05jzO4cW
 tXzF4QJZIeSmHHZ13xtVsgT85wnJyylOveSExbkAYJuQF2815qw05oJplH4JDfeq+W1+
 +tW5QMiGTc41kd5Etyb3iIpQvI5dtnPHbukdOu+SlkbrB+7ZvOmrSuy+f13AOmjNk9Oy
 vQDcT5aPSPFkCi1r++QLae5a2Z6++8OFtMwIjBwOOTwgYjb7y4W4wl068S0lP1Oq0VYu
 h+TnV7iHuNYbx1uEiZtFEgKqUZuDQRjTLotlSZMSekSpRfk6PH/wy1253uVcp7zjLSxz
 fiXA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529081; x=1792133881;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
 b=Q6UlyhrKx5sFJmMBjkpY9U9V3dBUHhJ9H+AMxkdlzlFfSdLpCYjxrfo7BwsIe+xWmG
 JLCFpOykXpjnGLfun8Z4VdC8Ej2A6BugMSjaiF+7+p0+cpVgItyHmCW5zUxq4tWR+xGj
 1Yx4CJcyd9gH4M+huGHQej39KYyKpkxzYqxpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529081; x=1792133881;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Q+NpFJMJJ7nx2SlGNgyzzbW/rrYYVTbtYtkOcfynK8=;
 b=Rt4etnUmVfjEURoAqvMF8zps6ctWcoZVtujWXoSI7sGLLc2dA0HJXA3LbejFUvm+VH
 3z4r33E44dwMMPvp0MS6vMpjihCoOHCg6x/jXUMqBFjY/ne8FlwqGduxIvCamV6LVNz+
 h+aV980Tcbk70oXFXqbNc2CuHwU7OmcXiDofcIzazGDDIU/j0OTMytWFNnH8x/VOFOwL
 HFfJqh8sKzAt38Qwx3Q4b5WWLU7+qqHmmUgCtUHbyfRDtslPFv66Ar291vVTF7OyqW/N
 QpWAoNWAFCSnV8woRBhTjoLnbBFvNi8YC+bJHcPoU0NL6+V7tSjs12fTKEcGTQ+9X0eo
 teow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC6sD1RTp5R+Ij9wR6SmGt2t9cFbRuOubaekHFBdIn4JSbel+DkQrU2S0nsFq6K860bHPGyWg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIx8MJydJmCaLEIineVpnrppPavEC+JbExngK3ijh+H61SwO1IY
 +IxiUjWQpbCKujAQ/sjFSJEt+hMDTUumiLTWJR42XOMZu9A2nxvGNA/VhICF+War3032/4hCWNl
 NP6SjaL1/W/RSXGz+gLABNyXPl9Kr8g2q5oQjvOVcg33akl8/ysj/thot
X-Gm-Gg: AYBFou0TVDifXWbUg8BOkbnO2z/OlTgn9kDknBBOsQF5qQRaDFfZZ8tqsbUIMkxFQXR
 kRtPvp4dzPIRU576zDdv5kFnnoLbbvMmg2E5s/3iA3aB79vYbtWvM76tYlNK/kJ4QvciBj+kYTF
 SG7i2zv6+VSOpRJrFOLPTfo/T7EgNbUDqH6B7kho8dyqcGrfRO3ZPYSWtQLLVVmB62VGnr+1QvF
 pvNyk8vgY0YM3fz63y7UNct1f++30ZJS14WxPWk0d3VA1eVKdc53Gr19ppAYWcUMdCIV+jVBXT7
 1R7AkV69dYH/4L1F5lUGHNe4pFwtqLBacmp5aUJeDJKfGuoIp2yABN4=
X-Received: by 2002:a05:6402:2087:b0:6aa:28d7:5b15 with SMTP id
 4fb4d7f45d1cf-6b17c252b97mr521694a12.16.1791529081544; Thu, 08 Oct 2026
 23:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
 <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 07:57:49 +0100
X-Gm-Features: AclHuK-mYe39iqkLSIU3YbcmZw5RvAkrHkPDSzBKy5xBd0XzKuhuD_159s3yRiQ
Message-ID: <CAFLszTieAvVj1vKawqsu9H7wWvtX_VxHzEW7MdqcDsb2FNtHPA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
To: jayaramudu.desapogu@amd.com
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org
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

On 2026-10-08T13:50:24, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
> x86: cpu: x86_64: Detect CPU vendor and device ID using cpuid
>
> When U-Boot is configured as a coreboot payload on x86_64, the current
> code leaves the CPU identity at the default Intel vendor and device ID
> 0x0, even on non-Intel platforms.
>
> Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
> to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/AMD
> when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
> store cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
> detected CPU identity.
>
> This avoids relying on a fixed vendor value and keeps vendor-sensitive
> paths (e.g. TSC calibration) aligned with the actual CPU.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
>
> arch/x86/cpu/Makefile             |  1 +
>  arch/x86/cpu/i386/cpu.c           | 51 ++------------------------------------
>  arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/cpu/x86_64/cpu.c         | 24 +++++++++++++++---
>  arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++++
>  5 files changed, 92 insertions(+), 52 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
