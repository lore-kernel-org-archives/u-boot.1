Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C3BCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758EF8460E;
	Mon, 25 May 2026 13:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BSeK45oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6516B8469F; Mon, 25 May 2026 13:41:05 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF63844CF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7bd65714dcaso92819237b3.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779709261; cv=none;
 d=google.com; s=arc-20240605;
 b=Yjc9qIVZz6p9X8JGzaw9FqPJUXL/VGC4SwwHwIFfpxvJ4W8Yc85XIsA4okMpn9XTtr
 lyY2JbI3aS2ek+R08ByCzdu3zS88LjMXxDe+q9x6oYaKndWP5Bgsom1yaV1LXmyxKRhb
 xXFo2lQTJQiW0y5YdbwA+KZvPViCSqtmR5fhAN2mRcD3ohsb5Gas5mN2kIvCwdzsjINB
 sE0SnvEVqyQ2pbOxq1f+KinUcdkGzfe44hBQT8sC/TQiG0x+hm+dCGqkGmeG0DggEAts
 Y2mImrUhp7+pFodU9JdhTl6Wis2H/7e1w/1uajkhD0CwK7PjoiCuU4MS8K+Z4vgF8RnI
 HOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dauR+uvO2T6cvQPN29NUo97gvuTk/FExKJpkhNgL1MU=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=gTaDETOOya+piThWkSzpXZhQa/iYk1ug7WTrCl3sgFRQGiiYsRRHp9pybrLmY5hPfw
 7AL8zVQwcWAESZldKwGUe09GtOsdxjPRQYwwRj/XNVIbIv735dIO1qSuXNFUEHqEqcpj
 eawu76SKVtY2u+TrqqBSAXVYD7WRwlNbN5Y7IXdAmao9DDRxsn/vt+z3lKjQ9NJNOkpY
 HYFhUC5Q0JBssW9Yz+yt68mlyv7bxxxi4kWmHyRXp8CM2v12Zdm3j1uEDhV7d/FKRMvZ
 FsH7kaZ7LLL4moMlJNEkk7LLHkdQ8rS1awq/DgeTdy/FNqnlGR2aUmrIy6biYaVvZzFr
 +rIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779709261; x=1780314061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dauR+uvO2T6cvQPN29NUo97gvuTk/FExKJpkhNgL1MU=;
 b=BSeK45oGowSf54h+A9UV0V333WZ662GLh+fBbNQ483AMvbitq6uvwV58s2ne2D4kDU
 vg/s4AxulYpEjBKcnOquvzrisoXFXanbaFyB3ByssL7TYNxNqpJxawU0HaW3km5gG8vk
 ke3bfP0Q1h9zX67K19MK+bqIkKL5OIclSV2nGWstRbs35J54HRTAgMJq8glaaRBKyYYw
 7R0G1yhCIvgPqxg1ObbdUrpKnlsxpTyXn06Jm4P9HNapvCe4rbW4aXpT3rSkHpQSPmqf
 0vwdRPY3X/wUTNtIry+SUaQim/j4VpDP3a2jiHnaqWgO/SwiKrzo1kV7rCLt6NijYRhd
 jKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709261; x=1780314061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dauR+uvO2T6cvQPN29NUo97gvuTk/FExKJpkhNgL1MU=;
 b=Qk6q4kY0SNxV2rTjqTJ4hvJrt9WudstHp0LeiD/aRyxqBZxX34JmgBJ+UTwwAQzKua
 WQXsEh87LuhEySK+vkt8ovUOpUZZmQf3aliWsziehHZ/E05MLyO1/h4JgrTQmuOpFJky
 D/kjYk+Ua6AFWJtX4q/lmIXNlNDL1sSrnA2gvhaq3xqYV1YT6TWaoInOnIFACfxWoOvd
 KOYQLnJLL6ZdD1CP9NwXoJ2TiBBP7VRtVGMbc7mJwt/PijiX1BDSWUgW2vUmiF7mT2t6
 gl+Zgn5v+ZHSevyq8iNqaS6BGZNebTriSM/ibIqtzC4cN0KANhDCC1CLKn4cA/mtIReY
 LTcA==
X-Gm-Message-State: AOJu0Yy0GMHJkhQ16HVadftZJ00PKWX3yk/cDSSv4lQfsyooe57EBKiD
 2dskDW2bA/CiqvRG8AgSDkK+MLhSGDqXctmPaBaP5oKRuVJiCfza6J3Htv0UohebDzN4jiIyh09
 QO1x00yCmDRgAUsaO+sD7/kvABh+CBtpASyI3rlzMdg==
X-Gm-Gg: Acq92OFMYrvZhiveK+j6ZWpIvv26WsLx/dbMynEvI2lzOLIVZAppp0slDJPDdtKARot
 rcCRaUYa8xDih77ciTPG+etJFlpzJIxhIxQUTIosJy/Ui0bRH2uURtrrtA+/uzi4JIOsLIfrLP4
 svbpI0zO9gRBkOTOfjMjTgD0POdbMeYy8PJhlYrVUnURi8W98aZPeSvwWKoIS1ujQouJ5rmtSfG
 gpekxPOGHsWVj0RDxF19o0JRmiKEjAmm0PC+lnXvsE4tED9x/YTNU6w1IgQKZNkax7AU0Ptjipc
 oFNxAgIO1ChE8DE5/QP+C66RuZmCb3aUah6mt/elvkTGs4SAWWInMjl6KIjT+tg+EqfDG3N4k5S
 UaTaZeqUQpJktika4cLQOj322ldF1VrBms13oPj4dRQHtke1aIacTtEmkpLYKxShjdQ8OT0t56+
 uWhkj5WxEHrfy18d1LRAx7LKPkmi2rhTHnatVJCO+tzXqaqdeLUcWlZmnMTFC5CH+g31zebb9n3
 2I/HtBPe3OXCzmddQOGLOECF2QNsygnWWIm7E6+N8RYPRK0nTrECzw7Q7OoRlWkB6SEwjLskgPH
 75dNSQBGpPnDUfJPtQlnVnC+epeAZ8nCM9Jlh6Y4x0952ZremhKshhrgum8g5yPnAMKEZzoynBy
 ifcFKAw==
X-Received: by 2002:a05:690e:d8d:b0:65e:4981:3630 with SMTP id
 956f58d0204a3-65ec99e3e24mr14787564d50.62.1779709261457; Mon, 25 May 2026
 04:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-3-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-3-7802245a40a2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 May 2026 14:40:25 +0300
X-Gm-Features: AVHnY4JE_pj9M59IO8eWBLDotjVsrWb1jSs9XKRRE7TxA2ArAlPj6okQRAoYc2M
Message-ID: <CAC_iWj+rECveJy5_dEPkhcim+XAuru1x1vPJYV8oDBcafactcw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] armv8: mmu: commonize the set_one_region() loop
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

On Mon, 18 May 2026 at 12:00, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> This loop is duplicated 3 times, put it into its own function and call
> it instead. This simplifies the logic in a few functions.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c | 94 +++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 66 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 2800ba57a464..889c566df105 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1033,8 +1033,30 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         /* Roll on to the next page table level */
>         return 0;
>  }
>
> +static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> +{
> +       int level;
> +       u64 r;
> +
> +       /*
> +        * Loop through the address range until we find a page granule that fits
> +        * our alignment constraints, then set it to the new cache attributes
> +        */
> +       while (size > 0) {
> +               for (level = 1; level < 4; level++) {
> +                       r = set_one_region(start, size, attrs, flag, level);
> +                       if (r) {
> +                               /* PTE successfully replaced */
> +                               size -= r;
> +                               start += r;
> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
>  void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>                                      enum dcache_option option)
>  {
>         u64 attrs = PMD_ATTRINDX(option >> 2);
> @@ -1052,28 +1074,9 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>          * we can safely modify our primary page tables and then switch back
>          */
>         __asm_switch_ttbr(gd->arch.tlb_emerg);
>
> -       /*
> -        * Loop through the address range until we find a page granule that fits
> -        * our alignment constraints, then set it to the new cache attributes
> -        */
> -       while (size > 0) {
> -               int level;
> -               u64 r;
> -
> -               for (level = 1; level < 4; level++) {
> -                       /* Set d-cache attributes only */
> -                       r = set_one_region(start, size, attrs, false, level);
> -                       if (r) {
> -                               /* PTE successfully replaced */
> -                               size -= r;
> -                               start += r;
> -                               break;
> -                       }
> -               }
> -
> -       }
> +       set_regions(start, size, attrs, false);
>
>         /* We're done modifying page tables, switch back to our primary ones */
>         __asm_switch_ttbr(gd->arch.tlb_addr);
>
> @@ -1083,31 +1086,11 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>          */
>         flush_dcache_range(real_start, real_start + real_size);
>  }
>
> -void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
>  {
> -       int level;
> -       u64 r, size, start;
> -
> -       /*
> -        * Loop through the address range until we find a page granule that fits
> -        * our alignment constraints and set the new permissions
> -        */
> -       start = addr;
> -       size = siz;
> -       while (size > 0) {
> -               for (level = 1; level < 4; level++) {
> -                       /* Set PTE to new attributes */
> -                       r = set_one_region(start, size, attrs, true, level);
> -                       if (r) {
> -                               /* PTE successfully updated */
> -                               size -= r;
> -                               start += r;
> -                               break;
> -                       }
> -               }
> -       }
> +       set_regions(addr, size, attrs, true);
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
>  }
> @@ -1116,38 +1099,17 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
>   * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
>   * The procecess is break-before-make. The target region will be marked as
>   * invalid during the process of changing.
>   */
> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
>  {
> -       int level;
> -       u64 r, size, start;
> -
> -       start = addr;
> -       size = siz;
> -       /*
> -        * Loop through the address range until we find a page granule that fits
> -        * our alignment constraints, then set it to "invalid".
> -        */
> -       while (size > 0) {
> -               for (level = 1; level < 4; level++) {
> -                       /* Set PTE to fault */
> -                       r = set_one_region(start, size, PTE_TYPE_FAULT, true,
> -                                          level);
> -                       if (r) {
> -                               /* PTE successfully invalidated */
> -                               size -= r;
> -                               start += r;
> -                               break;
> -                       }
> -               }
> -       }
> +       set_regions(addr, size, PTE_TYPE_FAULT, true);
>
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
>
> -       mmu_change_region_attr_nobreak(addr, siz, attrs);
> +       mmu_change_region_attr_nobreak(addr, size, attrs);
>  }
>
>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
>  {
>
> --
> 2.53.0
>
