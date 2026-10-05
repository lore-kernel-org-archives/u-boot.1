Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D29CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 06:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7654040653;
	Mon,  5 Oct 2026 06:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPqRmxC1-VJg; Mon,  5 Oct 2026 06:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B16F240637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791182664;
	b=YqHKTfUe5dBVls4E/AJ97JxHG/dyjU2FOPKcHgmhv4IhvzwUwru8+7nTvtv3SrOreuWb
	 zu6I5NYTW9KzMv22+xk2Xi23EFDNYFzYw8w28dXpvWmoNOuHHPeKkYW2/I8HBM2Qyh693
	 f3IQilbu+ka2jPMqDyFS6OcHCR17uG0VKNyK5RdMSo29E1GMjoPvTWymeWQBqXnu4CGil
	 0rCRVazLdWK5HaCsyTqmIjtzoFMO9LVY+wXWtivmph0aU7ZwS/HIqz7cGS2DZ0V5tNlQB
	 ZCi9INkmaAQt+49gK+FUcSen1f6MK6hqD5rd799gQ1PQbus8a04/hqH+sppJI9vmq5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791182664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
	b=UnW7TCKZuCvfCk05VREV1MMDdFIG/gXsF6G1EMfqbDGHMhAxRl2W7aWKwUMchhMeGV3e
	 iaCW3sSam5Ro3wkg5GBFvh0lQbMJAur2AYxw9ZBTjKkFADy1UV8F6hFfyMv3o6AyZVnSx
	 C+Y9Ktw3faxmzbb2A7oYid3iWqABQB2/rjRmpWpkTtLCW+DG4x9MHp/o8DqbxUjIKXzLy
	 QrSxn3jjer0t21/KDHEgN7kIEmH6uTZWBuvIQw094cZ1gD9dga/x5ubZYYrki0vS/rEN3
	 Fm+G6reMVBgN8PiFjRzwRjOlKb7Uge7L0fa/K4u8w9bHIs02hPGQXHP+0uZ0JHEORag==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791182664;
	bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sRdejRcbVGkLLhDRZrArZxR6KBOIV45eVSTU3fSpjrKp0OkYyNTX/Eyb6bemcS/ng
	 g4MOvTm9BLnbeT2+3MwmXdQjesg2BgKkh3MIUwQWwV36ooVL2Xy3ALAS8QYBEtXpQd
	 Qmk0nn/nBVjImKGy3RJjWV76LLIsp2v9vbmKIvKYtoiVz5Fj7X0cu9U5MwqwpAFhfI
	 mdDVw460bYw2f8J1QN2Iq0aBeDPBG7vpJFfyiGR9kNKBUk5htPOKU2LL0kuUvV6nis
	 EfR0Ee1LO+a1DGw7LiWTroVCQ2j5XVKyQSXYVn9TIGHlDG4iOgK/A6Ae0FwzFscoti
	 jvOAEdaUnpMcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B16F240637;
	Mon,  5 Oct 2026 06:44:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01309335
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2DC3400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAJdMpWhkECi for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 06:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D6EE140051
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791182640;
 b=cY1I3QsaWUp5662bDWAalkb+j6599R0g5fi6QxtNW6dZvWdQRN7fBrRccITrdkGLEfYn
 cY8fYT7nPYefUGzWOxTOX3skNdX+HyD7sHT6HJyzQPOi0JsedeakQ9qPSVc0c6iaG6DlW
 5nfxucW9G8FM/gN21BkYplzQQHg5ehaEDJ0WIQSVXHn75e3iN0YRskL51779MU9JSepzR
 Mwbp1bSkRTzZqI1OGosg2GoAhciS2Elvkcwsm/4DWudn8VOcu/FR+8+Hlb6krpBTHSLb9
 /x3YLFVYjbrq4VB9MCRVPx0BIBIt6EDdwuJZgT0TRvN4+ztqisNTHBx2QhJOLrggOTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791182640;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
 b=SLpMVQ6bEDpCVWmBRWG6/1drBEGF1TdISGDrZhCM2xWcGFDNaA/3+gRUwsdBbr1sXlTJ
 ZnEBJa4cgUUwKehe6t+vvNAdlu7sID2zFaV8LwngMAEA5HVlqE7CkIoESE5ltq58/nwgx
 1bVvDtLHd5qeG/sP1No+5TQE7clbocyGWblYnCQpJzb+QBlsoyhgv7sn+VlxaCMfOvlga
 M0yi3L6tHWHK3exPtq2eoAI5V/lO2EPD8FoXTbnZpjpUQR8GveiAjRD6ni7HmVnlkAq8O
 gtJqXEo8lFkIWmoQHoLfa2xcdKRyjBy7+CoDOYoHqV7vOO2xkP+9gAuXkvscgRfwsgw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HqKDcF7d; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HqKDcF7d
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6EE140051
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:43:59 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb6b726b5so2093100a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 23:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791182637; cv=none;
 d=google.com; s=arc-20260327;
 b=bc1sb+P3rMUsn0YrmIdMMteqWnRb6LssUndL7uSEhCXdyH15of0DassT1bsuPzDj9C
 3lJLHWEKb8f+PAwquo50+gvYK0O7owBduAf6kE4PtTMBAUN1POIOIhxKuZpf9jiNAU+n
 CQws29tVx+vkbZDCNe5B9bsfPX309N0muB8de2PinU7p95YpxKlaoeNqXzRYAwxCPHBB
 Ddppt6iFQTdRTaiXa+SrhOpkgioareqEiJWSUbujconOMz/1PX+7NC3WKPCH/Dfdh6tS
 c1f7dHdXhfH/B6+KyUysfTUHodXr/o5dkriWGM3BOa7cr/bIXuhwKhJVkZ8CA3IYp1cP
 M6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
 fh=OuNQo4rYlzYVgzFaZ/fWDFMuyQFm/6/wZ9CRwDzoMrM=;
 b=YLTnr0Y5uU0WWl0xMTxlV7dsTfJj8BWAvzrxd/bsXgLFBzgQVw6TsM32XLws9+1HO2
 IMqLzR7qNefy1xvaQ88VcHw3ygduM7tPfJTx0gZJpvz33wTGEEMwRvS56Bj5LpexCuDv
 43f6T+uGVX7wm4YWtoXxgmRwVp+zcdd9+KEuzgVwwfXsA+bcfu3Bf4EHULs/cmypOwNf
 A5a5H0EVRQ4arbR3v6eFMGo9KRIq0c3n27HRLrvqp14CmMDbPblk+iXA3tlJk0efOygS
 Y10pLRB9tR+fDr7m2QADNRDNu3wprJQdcS/M1SE0VqmuydUH3U1/gWnTCiEk8cPnWxr/
 7dQg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791182637; x=1791787437;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
 b=HqKDcF7dmLXAdsUSC2jwTuDSIXlwzeO1svjY/qqv1Q9i1hJUhXe70vSrPj1N7ji4DK
 TvTtJhm5Fuy8FwWAZa40QVEbbxrpgvtoCPAm0lEThPtOhCpuLMgPsNN30lAWy0cla9C+
 8BhQlFu10kIyxQfSGOmSj1w1G4xYITeJvUI+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182637; x=1791787437;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h2FBaWii8sGATsWquMDttShiwwgyNInZzi9cYPwShkg=;
 b=S8XeN883kFK3gQYDqn4ATdjUgFFoFGmrU7GUDZfNBKfrI0BgGaBLA2w2aerIzCRmZT
 PcAs4jzPP8v1b8Rur0LaMebS3szHj+O2xM5Pf2Bw6+2Hxe0X1B3OhdEPPrLARTH8n0hg
 kXlqC03udkQv855f3JZWSzPXMliDd0fOL/pUZMP2HAIDJCFlB0+Kv3vrwipHkzkyT2Pi
 98kZwTbfrt1XY9h1uOwVMQpmqf2LXQZDlO6S7YD/byJJwtSUJrUcBVnhLAMN3J7rA2Gn
 jtSgMLo+QbTjSXkAWdhNoxuwrbjxpP7E2Mf8/JcKV9LKjUn7tb6sg3iLz/oUx3MvbM3z
 tIWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLr4JoVMhkWPiFUnCV2pGViPgJxHHcnmcQLvaIeYMaT2zpuqO++xwFlE+ox3YTPXzf32OkrGI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYICQzbsCDJknyKFGKYYQh62J5V90Pn4K4LJtsy4YwDoDF2PbpYr
 Lgrrv3Lg5Rz0M2SVrrpzjjxgrYzX7BxWwWvzPCmbwEBADPYVBHCKbybfFpfyMbuIqNR8/GwL8hZ
 6wqbU82Q6r++JJZQjea5OKo0e0YazkAuLRMhmrnA2
X-Gm-Gg: AYBFou2VEhUMVaiQh3vFQVocBiT7Y4c/4qOdi3jMdTeNCZhY1+aSZajc6vtQjuVJPbo
 D7X1V3KzTYvVBgit5ab/E5FaK5Dm4kz+TfR8BO1Wl2ePGMDih28mU2yATi9DoKFSLych+Xx4b8K
 djLp7vVTqJMG9fHaqPE5OBvaurQLSf15pZDSbiMWwW/O9CrSAuJ10wHhN3OPGQDUx2yJQCftUnh
 n9Fj+CValL8HpQpNdBqStG/bnva0eVauH4m++OU2iPtwEhgc3bzDDYazxo7oz+SDUsihXkuU+Wq
 tQ1rQSpxhzffylN09yiMVWsN2VdanyBhBFvaW8w1rsAXepm69xVgYVlb5uqwqaruaJw=
X-Received: by 2002:a05:6402:52c1:b0:6ac:8e1a:2b68 with SMTP id
 4fb4d7f45d1cf-6af9e2ea408mr7086447a12.13.1791182637428; Sun, 04 Oct 2026
 23:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
 <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Oct 2026 07:43:42 +0100
X-Gm-Features: AclHuK92Bpimzdb8JdYUEE6dxuFUI_VjGWt23tqWTkQNgj7KUR4B4HunD5XfjhU
Message-ID: <CAFLszTjV5eYvy6h9_tOpBsCaWvp-FGUijUqb-ZQ7i3EPayRwJw@mail.gmail.com>
Subject: Re: [PATCH v4] x86: cpu: x86_64: Detect CPU vendor and device ID
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

On 2026-08-26T11:35:15, Desapogu, Jayaramudu
<jayaramudu.desapogu@amd.com> wrote:
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
>  arch/x86/cpu/x86_64/cpu.c         | 25 ++++++++++++++++---
>  arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++++
>  5 files changed, 93 insertions(+), 52 deletions(-)

> diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
> @@ -68,6 +68,22 @@ void cpu_reinit_fpu(void);
> + * @name: 12-byte CPUID vendor string (optionally NUL-terminated)
> + * Return: One of X86_VENDOR_* values, or X86_VENDOR_ANY if unknown
> + */
> +int x86_vendor_name_to_id(const char *name);

Thanks for fixing the ARRAY_SIZE() problem and switching the fallback
back to X86_VENDOR_UNKNOWN. This comment still says X86_VENDOR_ANY
though, so please can you update it?

> diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> @@ -61,6 +79,7 @@ int x86_cpu_reinit_f(void)
>
>  int x86_cpu_init_f(void)
>  {
> +     setup_identity();
>       return 0;
>  }

This is new in this version and the commit message doesn't mention it.
On x86_64, x86_cpu_init_f() is called by qemu, the EFI app and the EFI
payload, not just coreboot, so this also sets has_mtrr = true on those
platforms. I suspect that isn't what you want, at least for the EFI
app. Please can you either leave x86_cpu_init_f() as it was, or
explain in the commit message why those platforms need this too.
Moving the has_mtrr line back into x86_cpu_reinit_f() would also avoid
the problem.

Regards,
Simon
