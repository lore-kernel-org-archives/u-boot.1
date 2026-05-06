Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6A9CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 07:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C989847F6;
	Wed,  6 May 2026 09:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kYS7s4yS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48EEA847FD; Wed,  6 May 2026 09:14:05 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E613847C8
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 09:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c5361142fso2951265d50.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 00:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051640; cv=none;
 d=google.com; s=arc-20240605;
 b=CQldBBED/Si25vxHZO72j/xhma6qie8UJzyZnXdgvZHlmX7mjXgBBNkk5mahBtsEnj
 ndphFS9BAGfLRl1ThIbR8b1aqX+O/iLj2y+R/WMyiza+z+01IiwIM7by9mvXCO/zEd+0
 YhpftFnkVUNgaBkj3m6tJUcFbvniZ8b1biQzuhn3RzmEe3MnQJ6UYjK6IarKJNE/oy6M
 sp9fSSNXge2VqBteTxLDoiwqP019IL1lpot71gpeGcPzl+cm8+YNYzYAt7S6UAhBNJLv
 x0hkzOHyU7HyaxRzHosV8UGRBRV1f7FpptRnhqo/q5fRMj5q8b9ksf4E7DVAW8Whekhr
 jKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=elZ5gcNBuhEOaJvHbgFn2+yZLrN2bSPsamgqWnCvF0A=;
 fh=XCUHeCYBnU9srSQo3LRguDV5/knMHkG++jawmLvWlH0=;
 b=bFFsofUWPjSPOYlee1SNUYHzxrh6G0WAbsnlVTMnIAUky7Uj502c/VXx81qe8vP+JJ
 ZNAgjpI0W0Fcg5GVa1ytUt92GQBpbQ668oV4/aUz5XcFNzbeRdhag8AykFJKzlcz6ZDq
 WI/AwezDjTzZYuI+ZalvJbqNYzANN/HpNj+MxAOsuTsAoCowWpEBud2NVpimFLGiUyjh
 eOC6iAA62EeK+zjzUwAOiVgz+PYL61wVkUdaIp3vE1zsxQaJMrW/bFxWCRQT82fqaPZy
 sZN88TsRXdIjr/4vFTjF35AT8wBtb5rdhgK/1S5+igFL7TP8pQUOl4W10Jdp1hpPfHTz
 McDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778051640; x=1778656440; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=elZ5gcNBuhEOaJvHbgFn2+yZLrN2bSPsamgqWnCvF0A=;
 b=kYS7s4yS4LV72/lp0cDP/A4r3GFE6h1szb01X8THf/dOKdLc+R8y7p4isgIMUeQGJ6
 qjKZycK9F8XyJvvqsr8W3O8VdiSufpBBMTIQRW4AQHutv9YHEQWNdzxcKnR7PyeldeDi
 OH0jKp7KYJgAUuJWkRwy9HKxtQHvWOtldPGCqaIDe3YiWJA/Vv8LK9eMJeMa5BGfhuRe
 Ejcduqf0XXtNtb9yZetpFt8r2jbx9gWqq3Da5gRtm/kpJUDLrGf9Fh+WtyKWIeZGhExk
 KtlZGZvtlsnv4ued573bRl0V1MINR4+iPpcvb8o6En9uK1GNEoUU4Gh+kf3YLJf1A7Vd
 6ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778051640; x=1778656440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elZ5gcNBuhEOaJvHbgFn2+yZLrN2bSPsamgqWnCvF0A=;
 b=ny1xIuRawYGPypJ1n8uCNVmInWOXL2KYTYvL0siWcTbxgVopcryVOmHjk2oUO0nK8k
 w47i0PYq5EOrsR2e48LtXBWjgFAI1k3m6iGNT+j94zeRGNiH9DoP1YHr0W/3ZJFYS0h7
 21dGKQRD2kmxTfE/+YLpjsT4nsSAtFOiUcU1aYuLKLRySrm+W8dTYacf4SmWMgPRw7e8
 rfLUi4ddUQwPKx62IZ/YqaF3DIX2jnLT13vXgXBuAHz8A7hhpm6jwqi5eqU1Z0u4Myu4
 Y3fIcqha9ZNq3/MTm0wMHJpsjcGJJ4+XQZsuuePlzMorNCpwtvQLMysIPHEH9edGlAH1
 OfTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jEOarGvVaiV/lxGkNg0WQTxDdj7ydyR2pMzXQvtmuF96ivIdyroJz3e98MQRVRNCsAQYYU9M=@lists.denx.de
X-Gm-Message-State: AOJu0YwvEFTV+ostkE3Gcy0qC9t4ZMdbzabOAkmgzHJtnvkJWznm1A1f
 PgYw5AuAKDBWmEL4anQ4DeeFk8sAKXMUNbTKly3pqBTB3/1c1Ot2wKXizzG0QSmE4XUXkLrtJMq
 L1bE70pTFEiX908SeSbE37RCKttbO4A/MoAEzLUTl5w==
X-Gm-Gg: AeBDieu0OYUSQT6G8LrWDuC9N6Prm4Hhk5PyG6LQa/861e/2Y3uMakGI3ktVthLv1By
 o27FU5HHZInTxTg1P9u4A4AQupx6n9Wmd1I0tccyG+G0g+qU1GjeMklNtD+3/PhN9umrP8/A153
 21BJr1BuD7ZqB+tomDiLe4q9G25+taFYKk/C/l+MNna4wc2w88EXXzLL6c3qNCS7P7x1dW5G/5y
 CgUlV0aVPdALgGh5jQlWSaNTT++/p6jB4HFFjEHSG+Q1RkaM1/5/8LCv4BC2oGKTmqIr8pJAZ4R
 YAjWJFEK9q81ryHJ5TJvOMyp7aqxxb3u1QsotyQ3zTjJxq4Wa8CISZZSZQ1SiWTgAXt0ghZRmyN
 81Scy3A+K1UsNkRUmpHfw0l4+dWb+oo2tC+JFnnt77U49BVnqEtW1WQDSN5t5TcYcRuGf3wkdOZ
 mjppBciUuJumgTRqg7zOVgnfv7ogWNK4jd4tNg3MTAEAOC+K8gVaBL7Xl6fNdzvW9STPvPfGp43
 uPdSBtQYn3V+hw79+lgtE16Vz9QjNQWOcJ/XqSKc1VyfywNvr7XzMbxm6pF4AARR5ck8eveHsi+
 OueywhW1JQczIFkVHBt3gvqUE3hxFkCTV9mFcHzqT/575ttavC1PVqGEZuFzxa52GqtikR2JwwD
 h8+LuQ2m0pk4KY27lYcjF+A1A5gA=
X-Received: by 2002:a05:690e:c47:b0:654:fd9:2e92 with SMTP id
 956f58d0204a3-65c79939098mr2894401d50.27.1778051640256; Wed, 06 May 2026
 00:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260504183721.646712-1-casey.connolly@linaro.org>
In-Reply-To: <20260504183721.646712-1-casey.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 May 2026 10:13:24 +0300
X-Gm-Features: AVHnY4Jsbq_QIxmfPpL3XAqCusrmaAGYG95cVzcYXOTsoNAyQ3qm3UPzyENaE0Y
Message-ID: <CAC_iWjLkz8oMSvGsv-_1UTwNkuLGd3uzEoY90ERWLeeyWCP-_g@mail.gmail.com>
Subject: Re: [PATCH v2] armv8: mmu: support unmapping regions with
 set_one_region()
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Casey,

On Mon, 4 May 2026 at 21:37, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Currently set_one_region() implicitly assumes that we want to map a
> region and aggressively splits blocks into tables to do this, but when
> called with PTE_TYPE_FAULT to unmap a currently mapped region it may
> try to unnecessarily split blocks which doesn't make sense if the entire
> block should actually be unmapped. In the end it then has to walk every
> single page and create a bunch of empty tables.
>
> Introduce a check for this kind of behaviour and optimise with a fast
> path, if we're unmapping a region >= the size of this entry then we can
> just unmap the entire PTE and whatever it contains.
>
> This fixes some bogus empty tables being left behind when carving out
> reserved memory regions on Qualcomm, and should improve the performance
> of the break-before-make in mmu_change_region_attr().
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes in v2:
>  - Update pte_type() to correctly check the PTE_TYPE_VALID bit
>  - Explicitly unset both bits of PTE_TYPE_MASK to be extra safe
>  - V1: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
> ---

[...]

>
> +       /*
> +        * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
> +        * then the PTE we're looking at right now, in the first case we can do nothing and in the
> +        * second case we just need to unmap this page/block.
> +        * Otherwise we will needlessly create new tables until we have traversed every single page
> +        * in the region.
> +        */
> +       if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {

You need an alignment check (with is_aligned) here instead of just the
size and levelsize. But then you have to measure if that makes a
meningful difference on the time it takes to run.

For example imagine you have two 2mb block mapping and the user
requests to unmap 2mb starting at 1mb offset. Something like that:
Mapped memory:
0x0-0x200000
0x0000000-0x4000000

and the user reqeusts to unmap 0x100000-0x300000
The size >= levelsize will succed in this case, but if I am reading
the code right you'll end up unmapping 0-0x200000

Cheers

/Ilias
> +               *pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK);
> +               return levelsize;
> +       }
> +
>         /* Can we can just modify the current level block PTE? */
>         if (is_aligned(start, size, levelsize)) {
>                 if (flag) {
>                         *pte &= ~PMD_ATTRMASK;
> @@ -1081,8 +1093,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
>
> +       /* If we were unmapping a region then we're done! */
> +       if (attrs == PTE_TYPE_FAULT)
> +               return;
> +
>         mmu_change_region_attr_nobreak(addr, siz, attrs);
>  }
>
>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
> --
> 2.53.0
>
