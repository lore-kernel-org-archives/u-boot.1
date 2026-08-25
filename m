Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCCC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1B380C6E;
	Tue, 25 Aug 2026 18:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0e2dZiVOb3P; Tue, 25 Aug 2026 18:18:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787681926;
	bh=9lQYDCg7v4pOARDfvoVMdh7qL5sR4oUTc9yOwPf6uTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ltPl4aMR+A8OhQ5CoXhCxyy5PbI+gZ53Tic3q2tGaL1gTvjdWVppm7n1wsPXZgGZQ
	 4JjZRIvYrA1J3D8CkKgmZ5vaXDKY7npeNFi9w4cVpI8fsXKQKAnz0pwl78TYtvxvpg
	 A7+tkrTp9Jah/gyWRMiYWKNBjGqAcR7fAOpMtGrsRptqgIwGgI9CpDJcaHpxPUIBMe
	 Ze3txTrySZllncmkHGJJD3It1qmWKO8RcRv+4cI7Hp0HWer9XbxQQDYqf9Lt100Wf8
	 MWNpFoG5c6fy+CmKnED47FKRTSa5l4kn3iG0s8Z/Zm/4jQxIHNF5JWcNZw9wvbhwgx
	 y6xJblzSf0JDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0043180C5D;
	Tue, 25 Aug 2026 18:18:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09A38118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4112606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvKLHM11PIbV for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:18:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VTpT0RQ3
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0460A60604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:18:43 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so729298066b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787681921; cv=none;
 d=google.com; s=arc-20260327;
 b=BxgxGEE1CGgzJPJJLFdmLn9lDcqR+cy8YZFwIttmMz717LaejF5Y41ErK7bqsRnCOI
 YcjryZrwy1/pWsu0pD6FFvWz/y+aTTcpTR2tiu4onniff5Y0yhPvHx5dN1Ei57MHzQXK
 l8sBR1/b9YCcwkhfiX8xveSPnTxFESXnI+g4s0Q7EhGAPF+J4nDag3z4158bmDd2cKdQ
 pIkzU5L9stniDu6z8CirXF1w6GnDk6tgQPuZfRJUiAN5hrCv+d2V2d0Zwax2TlyIHT5X
 n5XhmUZZccRyBw5s7vw5jtQql+xgnvi1Xu6Wz/RjqyEBfmKNLXvB6U/vRu37Z7Dqo3CD
 aiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9lQYDCg7v4pOARDfvoVMdh7qL5sR4oUTc9yOwPf6uTY=;
 fh=FQoXY7PY3FAZ4DswGv71AHrr+XBEkwPNxhtcuVE6PNA=;
 b=ULf09pdaIkaT7p+c+IeD/NeRHXsLZyqFoRXVeKqx83KYxKqVSf82KjHZkT/u9ShYZ5
 gPd5BeBapzQ7kzZ+2U2hwyBJghqAjPtCpRdmn0NJgluA5tfH2vr5LW379X+WTIDO70Wb
 dtNTI9fH8tBYBYxXPjpv4hGRpQwawmyYag3FZ3ZWQ+iuvrEJwm50qFcA8BZeSgYe7dxN
 YQVPWewaL01fR3ScZpU60NvgHfDd7avXMksLTq+Mx8tqK2CuO3gx5UI5Ak820IlrB86/
 qkQNcr8P8R6e0L8VWNyrQTRRIVc9/IhV3SuogKAoSVjQJEck8YIEv7k//P8ldnUCLgP8
 xwTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787681921; x=1788286721;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9lQYDCg7v4pOARDfvoVMdh7qL5sR4oUTc9yOwPf6uTY=;
 b=VTpT0RQ3OmKO527FlwJd2aq3iVvNpI4KFzc+AmcUWwemSoA9tcQhV64PfqIHbOjlMs
 jlAjy3RL9BcjfU7fdq50tzdMJ+9iLD8orev7Qo8g0MGY6b0OV35P+oSqcxbec81qz0PG
 GAYoyK1j9aGIj4D0abNa54kvtH1nr8th2t3v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787681921; x=1788286721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9lQYDCg7v4pOARDfvoVMdh7qL5sR4oUTc9yOwPf6uTY=;
 b=s3sHCzIk4cp0JZIa5kbNwMZN8mcQ0bGQWKuxq8vf7vfj2xtFOHIe+CGxbCHA1zJQAD
 N46mILD30qVdQuFpn2mNWhyE87W1wCra060YdocJOfA4Iuc3UiknuQN/ZPrG8suHZrS9
 rUQ9jNMfRskyQpZ75QO6eB2azfkgYZ1Q4j1OGrJTGYCTsPnFz1SZqvdAOve5dtlYf88s
 2Ees3ZEuq8QAaf3SzW/a8EHO2s2yUZiMizZx800d1zDXsq7yemxNHcYCZpyTIgaLSBOE
 QaZf4o3eea2FeJnA8YdSo6XQbTMr/VgUDGxA4+WGrOg9UlLqyByADp8AnDUlX+bJLKO1
 sywA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfLJyXiHE2q9J1sj5glAb0hCeIrRSRFCwh16ziDx3EvWPg7bG7+xCxrkLGdmGD3CElGQD4A+k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kUB8Jv/eDE2Q+Z9/mdifbBikMYpuP4TX7pRIJ/I1gjvZtSnrxs
 bL+dW5lk42PEGGepX3HY+Gl1ikb8pCk9SrEkwUPa+OHZZatDcFV1qWRvEVvo08nkIq2IQSNl547
 JB4hlsK+rC9QEIChxpZIrdAvpfsznSd3JcqowRgk5YjAiuF7afpbl8g==
X-Gm-Gg: AR+sD12rdXj8u5Tw7SuYyZRI7iBng1U7IIB3RZnISMuplcMxI2NtE+gTd0ONWQa2OpG
 n1w6WvP8ZbT54bATmDZy1/N+85n5lRtx8QMPwb/8IOEldcBGm6c5R6tZ78AYGnhGvWPk0XwUFNS
 sv5j7xuSEnGxSGU4Gu+o4prcEihA5miVuO9uj4TfQfvzXo1arwmGAMh+Y8sU/BQfdqxiQYRx9nw
 MCxd3ib27UWmyfUkidt275YamKnXt53u4LrA6OveN4woJMRcyFMYGd39NKOTh+QNUVoRRXX7KAL
 JnY7+ps0hIBMVNDDRvyJPrj1YgjnmZr/BmgniurnFkE=
X-Received: by 2002:a17:907:a091:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c250c32b778mr64961566b.22.1787681921340; Tue, 25 Aug 2026
 11:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
 <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 12:18:28 -0600
X-Gm-Features: AcwNN1XB3_dk7ZjZHfwkc5B7NvmTpJrnHm0_t977PWoR1206F60BaSd-YJsNnZE
Message-ID: <CAFLszTj5gWZbd71x38JLcxLjB50+j9dbe1CP5nDHvr=TjtJ1LQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86: cpu: x86_64: Detect CPU vendor and device ID
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

Hi Desapogu,

On 2026-08-25T14:44:21, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
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
>
> arch/x86/cpu/Makefile             |  1 +
>  arch/x86/cpu/i386/cpu.c           | 51 ++------------------------------------
>  arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/cpu/x86_64/cpu.c         | 20 ++++++++++++---
>  arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++++
>  5 files changed, 88 insertions(+), 52 deletions(-)

> diff --git a/arch/x86/cpu/vendor.c b/arch/x86/cpu/vendor.c
> @@ -0,0 +1,52 @@
> +int x86_vendor_name_to_id(const char *name)
> +{
> +     int i;
> +
> +     for (i = 0; i < ARRAY_SIZE(x86_vendors) / sizeof(x86_vendors[0]); i++) {
> +             if (!memcmp(name, x86_vendors[i].name, 12))
> +                     return x86_vendors[i].vendor;
> +     }
> +
> +     return X86_VENDOR_ANY;
> +}

ARRAY_SIZE() already expands to sizeof(arr) / sizeof(arr[0]), so
dividing again gives 11 / 16 == 0 and the loop never runs - every
caller gets X86_VENDOR_ANY back, including GenuineIntel and
AuthenticAMD. Please drop the extra division.

> diff --git a/arch/x86/cpu/vendor.c b/arch/x86/cpu/vendor.c
> @@ -0,0 +1,52 @@
> +     return X86_VENDOR_ANY;
> +}

identify_cpu() in i386/cpu.c uses X86_VENDOR_UNKNOWN as its fallback,
and folding that call site into this helper silently changes it to
X86_VENDOR_ANY. Please have the helper return X86_VENDOR_UNKNOWN and
let the x86_64 caller substitute X86_VENDOR_ANY itself if it wants
that.

> diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> @@ -48,11 +49,23 @@ static void setup_sse_features(void)
> +     if (cpuid_level >= 0x00000001)
> +             gd->arch.x86_device = cpuid_eax(0x00000001);
> +     else
> +             gd->arch.x86_device = 0x000004000;

Where does 0x000004000 come from? It not look like any encoded
family/model value I recognise - identify_cpu() in i386/cpu.c just
sets c->x86 = 4 in the equivalent path. Please either use a named
constant with a comment explaining the encoding, or drop the else
branch (leaving x86_device at 0 is no worse than a bogus value).

Regards,
Simon
