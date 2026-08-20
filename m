Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA62C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73EAC6088B;
	Thu, 20 Aug 2026 12:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjaN8mpsjolY; Thu, 20 Aug 2026 12:14:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787228046;
	bh=IjmtFjj9wDDLVusKodWp+tcRAfG+TVpsLAv0golDfD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XsRzvSFL4OJg6Wdh0qF0qhMDhMt7pRFpW7d5fO6HuJ1tNsdhE9MCNbFiSi0jyE2m2
	 9bXQTeiSaz+FZ915tc6bENRztmdrJqDSkB5YDcmG2FCWkbdZ1Cw9OgVKnSQiVoBnY8
	 7u5KNZh+IRcha200q4KoiWcACmjDrivPylN2lHIS6lh0NLTMUHNi6Mka73S/RetWCD
	 RJPknCndPKDVsz6UE3p03qT3TD4J5onE356uL7xW5M8oDmJ37B47zJjAEmMhQ70Ofn
	 G63GJP/rluHreVHzOxWPD0AFnik5o07/aDfgiXopW38S22U4iBa0Oy8KsKGGxpxF8d
	 3TtQ06gqnRSFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDFBD60873;
	Thu, 20 Aug 2026 12:14:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 486B6323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A854405F9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DzOzCYdhwce for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:14:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=i5T8+vsz
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A315405F5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:14:03 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d5655cc850so24623845ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228043; cv=none;
 d=google.com; s=arc-20260327;
 b=oAPDLfgl13autdVHVB9m4kPEDYcEa8JfHyOZjvv2+J0EtMlKijJVHgymahRQ6igTud
 t9uxZa6cJ3/mo6Ysj+oa1S1YoZ38qIqv+5iyXWi06gdtXvMFJKTDy53WfWhZvoDC5XR1
 eAFf+97dayGslf/YPcMT3emSCPccKl8/3EwSZyNp0LWcJTwIAw99a32GZxV5w8BHLgrn
 NwEhxVXMTE5jL1Coo50BikzfjnTfs2W88ZgWOeQFeFz44MHG4ZUi8PUlU8aaegIktngv
 FG69bm2Ya9PKZ2q7b64FfabHxRk61PSRPiT/vukv/Wmgh5qM188D48yJ0R9omQJ2eZY+
 dFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IjmtFjj9wDDLVusKodWp+tcRAfG+TVpsLAv0golDfD0=;
 fh=hZNzHcNED/Jbka1F5PQ0cvO7ZaeVkq/pwaWi2F+fncM=;
 b=n/2zjq5EEcHYIp8fKOSd2+RYll6ag6qxSJt9tHK5l8rHvGrTgtVb+/X4UV1beUikLG
 IgWwrY0vFIt+q7RC3iCTR/tI3JspEzvl/wV6p5GwbPWFO3bphgzJ1XyofFytppzEPj0R
 E/zoyZukdk0oaDw3Wt/klzt77zdSKj99zx+3Dzn+HneO/YfMK0wHc2wV0KRVY4OlNr4b
 Tc00zWp45bezXpy5CBHRV307vYkLWaOpHnnBn6eonOL+vHRzDwwsl7kFw1tOk4OCjYfr
 CdMtmOjipoVRdnpyuIofsk2BUEHio7yH6ReJi7qpNxohy7rkUPziNzoIjsZzl6+EnbBn
 II/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787228043; x=1787832843;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IjmtFjj9wDDLVusKodWp+tcRAfG+TVpsLAv0golDfD0=;
 b=i5T8+vszoQZL0ivq5iqgcAr8Ju4a9ImTdxgIVJPduDIgf2ziNvpCilIrfYm6avHaP0
 EEK1W/d/RiOq3LQG0akmVOFHkewEmfm8CtQm/OOFqotmvVraSBvVI4xSkIpw77VNlEl/
 ZM/tozmRcjiO//vbtVS5dZrdSR5v0NuqH7vVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228043; x=1787832843;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IjmtFjj9wDDLVusKodWp+tcRAfG+TVpsLAv0golDfD0=;
 b=kfd9eFAEw/LeStJaajjwrTdMAAdNxB2RDYninbxlgwi8uQwFZGNtiDh2Tm3Z92I51d
 oUEtAZIcxYT9bQtmocbMyvO34ufBN58of01XpbuA5+YTqROIX/fZNNIwCoLtC7H11WFb
 b0gtEcUtOKp6QWO5EbyKgNVSNFpVey8grcMMi2UXUpmjWYX14i0VT5YsWBlEqSujLDAh
 eEV60TolK/FbMflObsFcr3VlqyfZS7uqnArWATKiXbe3smowlOkybZUM5LWk/kcNQ5o4
 mBRilsjVaybTic0yi+7/weEP7Gw2OSikXHRmpHXmxSeGkYBwwpv/y97IIiqTNvQZDTjU
 wx0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJ+LHk4yUpU3XUkuNgOaXq8J4W3DNrZUpQ+lrc0tl6HlXWHKvQk+gAuahd+P9H1MCvACDmWBw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw8NorPo+EVo0wmsZBlBU8+fC8u+9NGdDP2qXvQztQN/fIYa4n0
 wEqJkF+k7KE3h5dNRjEPAqc73sW3+JjiVipHq0f23XgEZ+Y2Lorf7qeD9c060qsSRUKWtuo4VzD
 UtqWqIP6YaNbey3fK10D3Y3lsRo2BZQtf0M567+xT
X-Gm-Gg: AR+sD10WsUk7x6DAu4GFK92jpIYh+3iickwoNiB0TCQ9BmNV8OWHIF7zBXCAa6dKAGU
 NZC/DYejvlBWwR0PDVRoc7J5r0dWZ86pOBM3Ty78InG1R0gYoOe2o8AQGlABdCqnFzlbccemo+B
 9nD3aG8MFxIgL+5Fg4XnJDAJNp7vJMGPxbp4vt7BCOiP85ehZxzPl7kkyAkcPxNizzSMUqMmEZ5
 toIFxx2V5UdlxhAl4nRogrWfOBMcYv7S/SnXvmfRaGmBG9bVijIBvkY2LGn3M5WL/PyzmPry5VE
 6wUuQkRKELgiRS+lPAq3DRetqG4liCFdiwqMtVPaNbY=
X-Received: by 2002:a17:902:e74e:b0:2d6:3c2f:69b with SMTP id
 d9443c01a7336-2d63c2f085dmr22382425ad.8.1787228043196; Thu, 20 Aug 2026
 05:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:13:49 -0600
X-Gm-Features: AcwNN1UzKO4U6dwvAWxcg89noEv1iBdRtjAmQ8xM9oJAPVQsR97bC6CUtKmTVz4
Message-ID: <CAFLszTiyey8-T_ZVLQt9KqX6E-CgwgOEhoEDCBiMjc4A0sY0XA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
To: jayaramudu.desapogu@amd.com
Cc: sjg@chromium.org, trini@konsulko.com, bmeng.cn@gmail.com, 
 u-boot@lists.u-boot-project.org
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

On 2026-08-14T17:18:29, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
> x86: cpu: x86_64: Detect CPU vendor and device ID using cpuid
>
> When U-Boot is configured as a coreboot payload on x86_64, the current
> code leaves the CPU identity at the default Intel vendor and device ID
> 0x0, even on non-Intel platforms.
>
> Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
> to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/AMD
> when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
> stores cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
> detected CPU indentity.

Please use imperative tense - 'Also store' rather than 'Also stores' -
and fix the typo 'indentity' -> 'identity'. Also missing a space in
'paths(e.g.'.

>
> This avoids relying on a fixed vendor value and keeps vendor-sensitive
> paths(e.g. TSC calibration) aligned with the actual CPU.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
>
> arch/x86/cpu/x86_64/cpu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

> diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> @@ -50,8 +50,21 @@ static void setup_sse_features(void)
>  int x86_cpu_reinit_f(void)
>  {
> -     /* set the vendor to Intel so that native_calibrate_tsc() works */
> -     gd->arch.x86_vendor = X86_VENDOR_INTEL;
> +     struct cpuid_result res;
> +     char vendor[13];
> +
> +     res = cpuid(0x00000000);
> +     memcpy(&vendor[0], &res.ebx, 4);
> +     memcpy(&vendor[4], &res.edx, 4);
> +     memcpy(&vendor[8], &res.ecx, 4);
> +     vendor[12] = '\0';
> +     if (!strcmp(vendor, "GenuineIntel"))
> +             gd->arch.x86_vendor = X86_VENDOR_INTEL; /* native_calibrate_tsc() works*/
> +     else if (!strcmp(vendor, "AuthenticAMD"))
> +             gd->arch.x86_vendor = X86_VENDOR_AMD;
> +     else
> +             gd->arch.x86_vendor = X86_VENDOR_ANY;
> +     gd->arch.x86_device = cpuid_eax(1);

This duplicates logic in arch/x86/cpu/i386/cpu.c - see
x86_cpu_vendor_info() (declared in asm/u-boot-x86.h) and the
x86_vendors[] table. Please refactor so the vendor table and the
leaf-0 read live in a shared file built for both i386 and x86_64, and
call it from here. That way you pick up all the vendors (Cyrix,
Centaur, Transmeta, etc.) for free and there is only one place to
maintain the mapping.

Note that identify_cpu() in i386/cpu.c uses X86_VENDOR_UNKNOWN as the
fallback; only the TPL fast-path uses X86_VENDOR_ANY. Please stay
consistent with that.

The trailing '/* native_calibrate_tsc() works*/' is missing the space
before '*/' and reads oddly on the Intel branch - either drop it or
restore the original comment above the block.

Regards,
Simon
