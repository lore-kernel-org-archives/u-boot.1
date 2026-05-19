Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E799CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 18:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3008846CF;
	Tue, 19 May 2026 20:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QNHbQkxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45831846E6; Tue, 19 May 2026 20:46:41 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C3F8039B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 20:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so4799573e87.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216398; cv=none;
 d=google.com; s=arc-20240605;
 b=b52vQtT9MbIOd02kVjV/gNL8nfCVOfwGVB0wnW+cZVTtidNvCbA9yECw8LaYP1/wjJ
 LLDV/msdWzsRdi75cOTDqx0XzLJJVK4BHLNrLwV7xKhmIwJwbOum0zyLXfc5gBxfBPa5
 JBiyp1U/5yUdb0LFhCnT/JndlvF43Pdq0qmOdgClXkOJPf03iifNLzvVwZfMeGnu2s4U
 VnK6fyxM5ciuoGQzY4QGnTNLVrBupLgxQ/gPTfOhTUcyFIJWoAG6BAbjH1txjpnoTFjU
 msO0o6mx++kJBKwB24BjosWSZpk9blQ/l4PNSDJx/lIYYUoLr1CuRZqJVEeGXr16m6MP
 gLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IBUk6P9aJEd100DGWRarg1P0gjsCBX8KN+SzGfyI5JQ=;
 fh=1YFjU5b9WB3jclHra/dbEKs8P1MocCIZNzaX587XNzA=;
 b=ElJXOU4e3avpjLkRulvi1gTv4/Fq3+L/9BZK5uL/7LAYeZInELI0Eaiudan1ktqlQz
 XIQeXXqBTN2kzenRjBcUlBzma8P2TQj8YvesWvDcUpL5LHDZBz/tuGIU3vQcRekxB6tZ
 O+WdKjRuOOrvgfOZJOFPlBCBO/vKkj9CkjaaZMnJSN0ygQzmJvGPdArzQLw2jJDcDoWN
 FS7O/kBB5FGvNykGOevYtDNRwY+sCENVZxhIrY2yJn9TkTTgFeSQIVPQfpUv+poyxc3D
 q2dgtg4HDlOEYND8o/Hld7c2h/i4vBvXNz8x3yXh864LqgPArpuqw83kn0I98tzJyE2j
 wjtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779216398; x=1779821198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IBUk6P9aJEd100DGWRarg1P0gjsCBX8KN+SzGfyI5JQ=;
 b=QNHbQkxcte95fIuF2wxytFXp7yz5D1wzaLoEqQDOd8s5Qw6KwFvCcq8tLtgS3uC1pW
 5Ik6D5tkjNITOZV4cVsjUOKWp82YyKTAWZyXL3CnO+xxO4XIXVr53VVbvTHtGDZj1kr1
 NWHBd1lHkjKozyfHKxUf0jp61D1nXKuLNOyJhyA/phAa7PRucoZ+HgRY80jlMhq4cea3
 eNCwc3hpFsY0K4z3OJudj3G1kdetF8ikTDaWyfAR+NfhL4O6k2sZxQxeE4WgSN2ylogi
 7OVMfXQ77f9vcxULa4WD7MUG1327HFJ8ysV45IaFQcpU24ngmUWc1ISmyrUuI59fVHKg
 TQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779216398; x=1779821198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBUk6P9aJEd100DGWRarg1P0gjsCBX8KN+SzGfyI5JQ=;
 b=RPDyHatTZlpSWAvXFEFeLqguEpdkxAa4GW+7BUG9YJh54GN1R6cHdkyE29oLcwdJAU
 0FP38qrYUFhGRRE8va8cQCSsUEs3BD9HpqORN3G7y8KOirgNKAEjMDc0gMdN23IlTBxc
 tCM/sTdcr6wco3DriucfJ/ZTQDEYULuBXmUz5ZtHPicCbnG4IC7pDgSoqcjOQCvqqYlc
 NmVsBYlUIx7/caUqoU/4C4WRV1Wl+oYx5Jp30ToxTubI1i/mOlXRvAsDr9qR40cZga0t
 9hFqEWVajf8WEKVKbLnrhTnNlJNanNUswndpOUHNapGEz61MCeg+kjpe4e8OOQhQ+rcH
 p2QA==
X-Gm-Message-State: AOJu0YwlO/h6WHM70SgY2pYNw2Lz5onquPyeYd4zDwd0+quF+XQ23l2k
 M98s8AbaW515Az3yUy54GpULE1Y+Fa+lVuviweddVtj4sivo2LdO57VjzuLT10dpccVKLA++ajV
 YvRTePpcQHYZG/FTrobJ6ljMrnIE9/8ecD2+HOhW2Bw==
X-Gm-Gg: Acq92OE8iwUIHRobS56ZAql/ICbGETcH3uF0pyfzO2gbT0zCDrg+7I/3BgDK/MCs6KR
 Nu2wWw2JIADXQXVrw3fRoILxhcpE2LRvzfeOGjob6zc7bD9NJqoZVs+spK7mHEd4Km+jaLAoKrn
 lENZfUC7WNQSJEpkSQ/lENi+T1lhxCF3p+DPWoNAmiQrCsLayYSBCaAZzX1RnSfgBBfHFDht2PX
 IpXY+JlOr9wKBn5BMseedTwIjZR+9JE7tOiwKHsKd7uwA9mFJrm1Yazopk7ipIIcOqsxvT+iZVr
 ytYYuvPfL8/QboVvKlfJjWvQEx/F3L6gZqHDZn8c75Dx2DZNJvXOL738kilANIXFLxP3YTF08X+
 xvH97LUMtmPEavlR1BOUyGUcjlocc7sYHa2lqDLSWoKpU1dxtVVfN5KIl3yteCTaVytT7M1+u0V
 mbIMfEelJSktg9Dn4P+o+wOnUCj6adjtEzpopR/4CG4Gnxf2t/40XVVv5KPvkHD1EFYy/0L50RM
 nWPDF88sp+YIJij1is2fJoqoe4LxWaSdyz31yrmdalYPOLvEsSCpc1CfdcRKjWEuHGSKL/tpppT
 1iAtn3qAOq7mV7k6CyIOctpn5eXtZbM1oEZNEQPnbLvQ7r8FrEr0sW4+HqEVUCMymH/1WO5SECj
 202vP
X-Received: by 2002:a05:6512:39c2:b0:5a8:f2ff:f501 with SMTP id
 2adb3069b0e04-5aa0e7450b8mr6310395e87.28.1779216398023; Tue, 19 May 2026
 11:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
 <20260518-am62_firewall_exception_fix-v2-2-bd6e816ec23d@ti.com>
In-Reply-To: <20260518-am62_firewall_exception_fix-v2-2-bd6e816ec23d@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 19 May 2026 21:46:00 +0300
X-Gm-Features: AVHnY4Kr630SsT8d_9NjCxJ1iazUl1SYFGuFSK0iMblLadfF1v2Eew76KVNl1MA
Message-ID: <CAC_iWjJ6ajFbAC-nppHdwhj66uRsGY5-YAam-3mmzdM+6qhEmg@mail.gmail.com>
Subject: Re: [PATCH master v2 2/2] mach-k3: enable mmu after reserved memory
 is unmapped
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 18 May 2026 at 14:54, Anshul Dalal <anshuld@ti.com> wrote:
>
> Currently the sequence to enable caches for the A53/A72 core on K3
> devices looks as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables (done by mmu_setup)
>  3. Enable MMU
>  4. Unmap reserved-memory regions
>  5. Enable caches
>
> However there is a brief period of execution between #3 and #4 where the
> core can issue speculative accesses to the entire DDR space (including
> the reserved-memory regions) despite the caches being disabled.
>
> A firewall exception is triggered whenever such speculative access is
> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
> by re-ordering the sequence as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables
>  3. Unmap reserved-memory regions
>  4. Enable MMU
>  5. Enable caches
>
> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
> Reported-by: Suhaas Joshi <s-joshi@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 396018b7a7a..9bebc0b1106 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -295,6 +295,7 @@ void enable_caches(void)
>                                __func__, ret);
>         }
>
> +       mmu_enable();

You added mm_enable() on the previous patch a few lines above. I
assumed it was to keep the code changes confined to one patch without
changing the behavior, but you have to remove it now. You can even
skip it entirely since dcache_enable() will do it, but I don't mind
having the explicit call.

Cheers
/Ilias

>         icache_enable();
>         dcache_enable();
>  }
>
> --
> 2.53.0
>
