Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92029F8A154
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 10:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C3B840AB;
	Thu, 16 Apr 2026 12:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TKBJQ9Ld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E1F84105; Thu, 16 Apr 2026 12:14:01 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6854083FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651b2f46720so4710865d50.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 03:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334436; cv=none;
 d=google.com; s=arc-20240605;
 b=RX7HkbWTHomPhu5Yy+OEAmh4rpm8PCp7e9ZwBOBpV6VrQhLAQD+kOSY/H/FNf7ae6E
 gLh+3t5keukv5z+0T4HPCDTi52xgHqHYtegTwhs1997JOJpMIwtrfBFnewYrivE0ZbFM
 5yW+vVrrkZk/8koqL5YwkDL0+i3WPzZPYewcGAM6OPRYl6FFRB/1Q4YmMSfHu8pPGAh/
 rwOzrr1ko0kyNsdDjcJq0tRzpbWQAJOEt5bpG5nlSNxCKGNTMSEi9+13VZbJvWmHWy6r
 1GHyfkk37hx5hDmJhYXkq00TXdDuy3bHDji/XDrn4Sa1Rn8dPVsdQ4kceYFpmqm1N74r
 +7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7WDP0wXgeEv34pcMvl4lHd0NEnLOGgOGU/ui1Tm87Tk=;
 fh=a5DpevWUlMn0kvVgwFdhAszlAYlVweVm6c/7ek/0VX4=;
 b=Vjle9cTXl2U/k19INqX5BrRjPCaMzU6tTUjmNSElGSqC2kPDlMnbmhM9+Iu01YIkyG
 DY3E2WBUVZ1GaqgAj/mxTWorKlZgZwzz+Sd9YTg+KjJNdV27KYmH3BGnNDqs39ZdigBK
 xUwD1Ejzmgu3Rdlv2MIFpjnCuFTQm/RcWM8B61kn2vWnR8sW4f0YnBCoMOUogcE9TqyF
 Ki3g7jfbheP9bxI9mDPlnJIYRscZoccOPp4lNsggLteb5TJa/xJqnLCqciGHfqjrqwDd
 70C07X3yO97cPZgnl+++FCZc8Z80vRQjxBp3YhQLehHZKF7N+FytFCTFYu5Qcq2sohF1
 ZBEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776334436; x=1776939236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7WDP0wXgeEv34pcMvl4lHd0NEnLOGgOGU/ui1Tm87Tk=;
 b=TKBJQ9LdItsMCb1GKLaaDj2K5+5yrqNbEc2aRk6eaff/v+51vg+ccbsier3MpNsrty
 PH2DatPww+O90xxGtjAPvK+NJmUPFRAT7zJVCWpZqQPZ8TmREQ6uz+ZsuQvex3LA34Hk
 AfZ+1rAplM4tEKSLeMHx2kx7h8KPUNgDDkzGxbJrd9FsYZT5PWNAowZMBKncC+22u3Py
 IcsX33BuxrzR4zZYTs7xp9lm2ys/c+2myNsGyykBK+afSkqw0nlvktY5bLq5wib3FXK/
 mAMCS2yTAxK5CRNfUjnWn26D0xY6Ejre00Z+CHcZNhSt+hgJdkkzWvpoTeAOjAok3M7A
 r0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776334436; x=1776939236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WDP0wXgeEv34pcMvl4lHd0NEnLOGgOGU/ui1Tm87Tk=;
 b=az2iDMHBq9xhZ+IsRmPj/Jk7fuWBBzpvYatEUEjl3I8A6zoa2T828PbOz15og9ZMFK
 gb+u/yZfwHukHU59nL/l0LsENWbBvSlsOrQz0v5L8IJf8s27JAY2/m4K2fqG7Q5H8/Gc
 UnzvnFgraELeMyWvz6nnVSpxjDSehSKrhe5c/WTS4G3Uj5K19LgAXGBtRmhruiMad2A5
 U/9jqYRGOqA+c9bpZ0cMaSheT0t7TiZZYLDJLzYS7b9BLyXaQo/L2ZfR1Alr3R4Tiwvi
 dYeaHRGSWkXpP/aJD4UnH6WKe9G5VdKNe1yP+lZF1Ok6qxHPOInVsQQ1QXzfxJDlQkOJ
 Ry8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jaefOYcpPO5ars0wx8Q5/nqVpVXYPO2+4trlysM7mt9nVFwm1LUz1VB5F+BNKrSM4ccb/Jvc=@lists.denx.de
X-Gm-Message-State: AOJu0YyomgHO3blR0latty2aTcLN2HRybe55UBIHZIpy6lM8qPaLy3D9
 c8tRfcprRkXVeyTXzEN3qP+EgJPdu2wyBckN85sDMHof6F0wk3EVF7LhhXN5GUc4t6Wn09p5Kat
 6A9RHI9JJpI5qOa1DVGq4BSE4oxNGuSLmkry8HSP98Q==
X-Gm-Gg: AeBDievOIGZvrSKUiYEEU6WkDQFAAdebNtTPjYdWsG2HPOYUigrr+Vkz08Asjli1ZTX
 lSKUvXXan9t9dRopQI0NjmtgGXh3Q8zxHnexIAhZnQ/ynn5OrKkQO/WAuYiYTX0f/RhDTbL13gz
 fSzXN8C/ejp55TtYIBxYZKjHQ51KtUgjnAqYDDI+vBb9yuZu/rWRnOTrgI5CQ9N7KIE2Wra2gAk
 A/MMbCiJb6AI/reiCtOxBcYat8JKIBBktrEM+m2LGycDdqi4sXPP1Uddf9b3B2ym/why7Oa41U6
 12yrzX3fmF1Cuvbn5J69v59bPos1otq/PZsI2PtbtG6vmj6zI5sHrdf2h2WlrPDeAJLFKZ1XeGS
 WCL20NhSvNyWT7a+9j8TDdnCsIK4kTsBkFzhBkWuT+OLYQKeVR6SknbIlG1XkpjTkjRMj2AWKG7
 HJJxtE4kZifIQyAaVc1dbfMr338hX+CidoIn7/MVSuBS4SIwxbh+x4UHpn5SfFSc9sT2GtbGoCF
 2KrYVvHfo8WBVclLkX7X7JL8rX7dTedvtI92Y9uHKdeOpizy8Y1gCBfiFvRdL/Bdk9Kmsnlpo8n
 +owbDkJHZC9HHEK95U3/A3mJqBkcm3ffKFPQ8rwRjOt7
X-Received: by 2002:a05:690e:130a:b0:650:95e:2fc with SMTP id
 956f58d0204a3-65198b566f5mr24287525d50.40.1776334436048; Thu, 16 Apr 2026
 03:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-6-rs@ti.com>
In-Reply-To: <20260413203555.1990337-6-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 13:13:20 +0300
X-Gm-Features: AQROBzAf50DcTNJWJn5ybR4DV6jhKIxK_LrkYm3ctoooruzkPpdpdb3UW5tgTIo
Message-ID: <CAC_iWjKbAqzjRJ=0CLM4UJD2dLukuhna_UXSd-EfWEL=TXxYPg@mail.gmail.com>
Subject: Re: [PATCHv3 5/6] efi_mem_sort: use list_for_each_entry_safe instead
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Use list_for_each_entry_safe and comparisons against the current and
> next efi_mem_desc. This reduces the computation required for merging
> regions, prevents unnecessary additional iterations of the list, and
> requires less temporary values.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_memory.c | 48 +++++++++++++------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc..b3b292ebf56 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -128,44 +128,30 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
>   */
>  static void efi_mem_sort(void)
>  {
> -       struct efi_mem_list *lmem;
> -       struct efi_mem_list *prevmem = NULL;
> -       bool merge_again = true;
> +       struct efi_mem_list *curmem, *nextmem = NULL;
>
>         list_sort(NULL, &efi_mem, efi_mem_cmp);
>
>         /* Now merge entries that can be merged */
> -       while (merge_again) {
> -               merge_again = false;
> -               list_for_each_entry(lmem, &efi_mem, link) {
> -                       struct efi_mem_desc *prev;
> -                       struct efi_mem_desc *cur;
> -                       uint64_t pages;
> +       list_for_each_entry_safe(curmem, nextmem, &efi_mem, link) {
> +               struct efi_mem_desc *cur;
> +               struct efi_mem_desc *next;
>
> -                       if (!prevmem) {
> -                               prevmem = lmem;
> -                               continue;
> -                       }
> +               /* Exit when we've got nothing to compare with */
> +               if (&nextmem->link == &efi_mem) {
> +                       break;
> +               }
>
> -                       cur = &lmem->desc;
> -                       prev = &prevmem->desc;
> -
> -                       if ((desc_get_end(cur) == prev->physical_start) &&
> -                           (prev->type == cur->type) &&
> -                           (prev->attribute == cur->attribute)) {
> -                               /* There is an existing map before, reuse it */
> -                               pages = cur->num_pages;
> -                               prev->num_pages += pages;
> -                               prev->physical_start -= pages << EFI_PAGE_SHIFT;
> -                               prev->virtual_start -= pages << EFI_PAGE_SHIFT;
> -                               list_del(&lmem->link);
> -                               free(lmem);
> -
> -                               merge_again = true;
> -                               break;
> -                       }
> +               cur = &curmem->desc;
> +               next = &nextmem->desc;
>
> -                       prevmem = lmem;
> +               if ((cur->physical_start == desc_get_end(next)) &&
> +                   (cur->type == next->type) &&
> +                   (cur->attribute == next->attribute)) {
> +                       /* There is another similar map coming up, reuse it */
> +                       next->num_pages += cur->num_pages;
> +                       list_del(&curmem->link);
> +                       free(curmem);
>                 }
>         }
>  }
> --
> 2.53.0
>
