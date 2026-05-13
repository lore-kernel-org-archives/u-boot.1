Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C44CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D78838BB;
	Wed, 13 May 2026 11:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l9YcajfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C2083E36; Wed, 13 May 2026 11:40:24 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBB98341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c21049dafso6040579d50.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778665220; cv=none;
 d=google.com; s=arc-20240605;
 b=E2dQJKoGfTgk7bDfn4nFlklEC6rtMMUxIJje0Q2gg4aozy1LeJtd2ha2wSfKv+7LoN
 +gqgpfXKd1BQxrw31Z5+Zgqdut/5x7ZCFPxHZUBJNdMEjrFWmmoRcvNUj//Sapwl/Sv9
 S5pR5ywlCCeFaAwk2As8aOZscqEs0pQhfxtIp2eSFGdPYzgy9cCwwS3aSPlM5IWz5Pvp
 79INW8Y5RVj/0EgHoa9NkwBt3MwDyYBJ2wFx4OZwoEP9q8yy5/WChFpb0ZWRJkeQrNbV
 nKW4pMHgGwc5zuL6YjiPi51kqWv+UaYzvTCbl8Y/61JnPWGd3+cToJ8PXK9R7+HkyMVc
 RoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GSyWG+JKVk8g51NqdMpMwmwdm6ifZpn7c0pH9d9JN5o=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=F/Pc7k/hohN34P6vUaILDGp8heCbHdCMKDH0KxMQf0ruo70dFC7dZJvNKFySLgoHXs
 WgqENkIjLD+QuM47vUYmRFhS3/hTIf5gWxDR+35E0IYBTvjAnfubtWa6wxasL6EKJt2x
 RI2znTJDtEM2er+07PGzda5cdZ4x5dPf0+py/Ncu3wYersij7DCWMAb1wMT2Ac2Ymxqh
 EjbrW2JwieH9lGzswNdcJtax+82yLccGrX0ZXrFr2GHLkRsssj0oD9ruQKeEXUEKT8Ut
 Be8bCSUwJH4vA4Fycn9j1qiHAlA5t5hjCdHoAix/MCA99Jeh1qXlhps9JUtZ19iEEleS
 CBrg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778665220; x=1779270020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GSyWG+JKVk8g51NqdMpMwmwdm6ifZpn7c0pH9d9JN5o=;
 b=l9YcajfGtUuRGDnudW28xn6OWpO2YybZoYcTzkKddqwbhye296XGGA2w+Fdq91bouA
 Nbrgv4tglU5N0ss//omfehL0EdlgFY5QTO66iX8a+NSKMq4myUK2g7HQihe3Cn/1tBZK
 WHiMG9rMW6wNFJY+NuGq0nas1h93xF7GNJb2BIbLWLygHUU/PJfJW+yzPm63qVsUbLfo
 wN2HmZGnTLoo0asaLo3RtxdPx3XidjvBoXYuruvAUkOEaSoYazin/iBxDs2ndVbD+y7C
 XS8TbmqnqlLfl5rZvqOmM5x3SGGFLuq6gff/0PR3zfU6jACxXqSM7OayRqWyYpfy6K9P
 L84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778665220; x=1779270020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSyWG+JKVk8g51NqdMpMwmwdm6ifZpn7c0pH9d9JN5o=;
 b=YbU8lB18PUWkMXOxo/OrvM2kdlBhFciVmHz7CaMPsoHcv0iEaiYBd3tYetsP2duunU
 XSYWLKMLCLqZ72H21b4mXQARc02LHtaakqRFT48Nwxn7blbG8isms91pYOD2I2Us3oGR
 lQAPFj2IJAx3ZoQH0rwKb3YiK+KBOzO80JGRqyBvS/q5St+ckyExVGZDF37mZanjTM9h
 7o3OHIO9FgigNTVA7KpyOtDAEDyZLPNN3fiOu4Xac18PkoAqPAjktysMDwAZhMitViUW
 9k40tc/Y9jB6piT2YJ6Exe1tvw+agyE3fSyOwhlccuThe4HKnYYbabWMlvYxzrZtupc1
 IZ+g==
X-Gm-Message-State: AOJu0YylT7iopGE8zbDnz1c4EqOHpIp/nxatXQxeNoQI3EZtQV8yD1XD
 EVn7sn+MwmGrfdFOGBfRGbrLD3B/j/TjL5+mY37B/wFrainL8o4SVbq11rV5LJh8rXP1AjcSus1
 irEoBczPHvneObWZnvacLBkWBmIBZiy6UmXCp6KJ3cw==
X-Gm-Gg: Acq92OFH0GP76gC6GeK9jQFL2M+Z574Xm1BieEtOBLSniZX2PKPOt74hQZgbAl5NQJL
 IDiBsVK74ehkukJjfw1gR+YxQ2yzLgCr5PY76seJWdF0US3W8Q+dFMkv4gdJHjMFrW7sWtN7j5u
 mKtKMNQOGaee1RjPdaf2xb7zNm9STwJjGNNPDPzQiVxgiQ5ztX7C5Q9y1NKfDVIZDSNlaXy62/q
 JZJgJQl7tLR5o+Y4f1LmtMd0JtJgLvXWaBeHTIqYJ+kOKZoYL8AzQS/pVtfNPC3iLrteaN+KWZ2
 MogwV4v9VvmoFYHSG0Pav0O8nX5cOkT1SH9P34woN3RywTvuTfNsW5pPBoneeutA8cPXxvkBK8s
 xXfDiKB0op2DElEw6fz/N+3Fxp8CkfnT/7B6BXHLyvgLpQcuM9ZPNaGbq2XgF1ZS94cWwNcrvnL
 EKYRHR0psIaje5ih9DFftCwYpNJ1kCrpFB0DwUI5E247EUuwm9tu2erUE8GUVi1PsODPxZw+3H8
 cFPDJjAtHcwyrZQhuBsrY9ygKsFnmrBnKXc4wW51QgxvslTtikHRGXzxtWKt4fo37d3saD6+BzD
 s1C8MCTySlZyAE84mXQXgkvsgyNvHZ9HExywNdp1MdW5HCP/0ppo8LeXwXGbt3H4nxjGMofyjEG
 8oOcyxQ==
X-Received: by 2002:a05:690e:12c6:b0:651:b40a:d6ce with SMTP id
 956f58d0204a3-65df621ea75mr2363985d50.14.1778665220097; Wed, 13 May 2026
 02:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-1-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-1-fab802f647c9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 12:39:44 +0300
X-Gm-Features: AVHnY4KN_XEzSts88N-W8hfTYCvZJcNLktr1OrA9noCwqAolCYEABN2s-U_ZZKg
Message-ID: <CAC_iWjLwTAhL0iTLupqAuRNtWoaO9aP0DH9zAVi5_eWdna7nKw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] armv8: mmu: add a function to help debug TLB
 lookups
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Implement a super basic software TLB walk which can look up a single
> address in the TLB and print each stage of the translation. This is
> helpful for debugging TLB issues and will be compiled out if unused.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 49 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h |  7 ++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21f..368c622cd18e 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -733,8 +733,57 @@ void dump_pagetable(u64 ttbr, u64 tcr)
>                va_bits, va_bits < 39 ? 3 : 4);
>         walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
>  }
>
> +/* Do a software pagetable walk for the given address */
> +void tlb_debug_lookup(u64 addr)
> +{
> +       u64 tcr = get_tcr(NULL, NULL);
> +       u64 va_bits = 64 - (tcr & (BIT(6) - 1));

Any reason you can't use va_bits from get_tcr?

> +       u64 ttbr = gd->arch.tlb_addr, *pte;
> +       int lshift, level = va_bits < 39 ? 1 : 0;
> +
> +       printf("Performing software TLB lookup of address %#010llx va_bits: %lld\n", addr, va_bits);
> +
> +       addr = ALIGN_DOWN(addr, 0x1000);
> +       pte = ((u64 *)ttbr);
> +       for (int i = level; i < 4; i++) {
> +               int indent = (i - level + 1) * 2;
> +               lshift = level2shift(i);
> +               u32 idx = (addr >> lshift) & 0x1FF;
> +               u64 _addr;
> +
> +               printf("%*sPTE: %#010llx. addr[%d:%d]: %#05x (offset %#07x)\n", indent, "", (u64)pte,
> +                      lshift + 8, lshift, idx, idx * 8);
> +               printf("%*sL%d: %#010llx -> ", indent, "", i, (u64)(&pte[idx]));
> +
> +               pte = &pte[idx];
> +               _addr = *pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
> +
> +               switch (pte_type(pte)) {
> +               case PTE_TYPE_FAULT:
> +                       printf("UNMAPPED!\n");
> +                       return;
> +               case PTE_TYPE_BLOCK:
> +                       printf("BLOCK (%#010llx)\n", _addr);
> +                       break;
> +               case PTE_TYPE_TABLE: // || PTE_TYPE_PAGE

Get rid of comments with // etc

> +                       if (i < 3) {
> +                               printf("TABLE (%#010llx)\n", _addr);
> +                               pte = (u64 *)_addr;
> +                               continue;
> +                       } else { // Page
> +                               printf("PAGE (%#010llx)\n", _addr);
> +                       }
> +                       break;

I think we should add a default here, so people can add more cases if
they need them

> +               }
> +
> +               // We did the lookup!
> +               printf("%*s[%#010llx - %#010llx]\n", indent + 2, "", _addr, _addr + (1 << lshift));
> +               return;
> +       }
> +}
> +
>  /* Returns the estimated required size of all page tables */
>  __weak u64 get_page_table_size(void)
>  {
>         u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 8aa5f9721c4a..ee81619a1843 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -186,8 +186,15 @@ void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
>   * @tcr: TCR value to use
>   */
>  void dump_pagetable(u64 ttbr, u64 tcr);
>
> +/**
> + * tlb_debug_lookup() - Perform a software TLB walk printing each stage
> + *
> + * @addr: the address to look-up in the TLB.
> + */
> +void tlb_debug_lookup(u64 addr);
> +
>  struct mm_region {
>         u64 virt;
>         u64 phys;
>         u64 size;
>
> --
> 2.53.0
>
