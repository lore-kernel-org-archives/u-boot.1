Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C2ECD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4E28487C;
	Tue,  5 May 2026 12:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cPX4BnJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D058E84882; Tue,  5 May 2026 12:45:40 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3138486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so4402317d50.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 03:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777977937; cv=none;
 d=google.com; s=arc-20240605;
 b=KL0ziInXYGeDE8W3I3V7A560762BZ6onpRU/tCd0bxZXs6qj7k60DUpcRKxuaceDWM
 bWLj0N9qFHulGGgD84Oqp7XWXZrIneKGHefDeM6RQVPfh47qaJtKPIbsL07aH/4Io1JM
 GOnRwK0z9oh/rykwORc4JS8O48uCYAehLwivNVoMr0ioUy7Ao+JZe0XYU1qXWj/i0jIF
 taHCvBe0zL9ZNMmE+HogzT75I+XPMUzumcNcBZI3+vDZAwuF08G3L3TG4BsF2GyDxlGH
 UyMHwpcZXMkaJcg+i1UZU6dpqdEoihFDuA8w1oFQb7/zGmsYdrTuMHHDjnRarHOA+2r3
 mUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g3GLV507ZcLvlFP6ZQ/tORYDNU+H6X/LaU/Zsc4IxPI=;
 fh=5kUd394jKrhcOl2ZH+dGyAVzMYd6ZUkwYkyJrAcRQtc=;
 b=g2+e+mXsEhsEXzXwn6Pdv9hjvqnp6Ys5iaCvxjkIMchTvSUKfbUXTGWRFmp6h0riih
 59Pkn11LWIyBtkfv3M1Jf7MTGWrd2R0dH9xx4yd0v+FqOSG8H/xRMq8nqt9eTO4b0ISF
 2JV/hz+ielxe+Eza5bKa3g28fAKmkyVMTwxKCZ4D89cLBUDITKBKPFhnstQ5kwSy2lyz
 BKnO7e3kcz/jLHlckjefB/BWBY/mmxnqN5Ii32FbFLodkDopkFODgRIzruKNsFt/7n8p
 6JEjBP08uK2MsQR5okOWGMiQiysDeK4BbihXZIJkr690vbrPBRXyhz+nPqobDhQJtpAl
 FlJQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977937; x=1778582737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g3GLV507ZcLvlFP6ZQ/tORYDNU+H6X/LaU/Zsc4IxPI=;
 b=cPX4BnJp8zvUuR+9c7xq7B0DjrrT1/NneBQ2zYd7O4jnmntwYcUudNdytY75me3S59
 n9ay76QLGicgpmg2sxiREHrnLZKlFMmU37Jk8Qy6SFkS/0WYeQNAc9TBYhxSJgZQLQ1l
 IQdoD5s1aYjtpC2rBvSrMmm0pntx8KajRnabgnZFVlul0g58w/4mH4AcZuec99GuesqU
 uhKDjzdOg2xxbYHE/NDRUcUa92WRmWAOsKtvrt474DMgLwW2GB2CwGv+KUheAix/uRn5
 mFKQ1ThG7LOhKpHGYWN8o5u0QxYoEv+dYT/+AkqgUNOLlRI1T374tygoloSy/Lkz17UM
 4FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977937; x=1778582737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3GLV507ZcLvlFP6ZQ/tORYDNU+H6X/LaU/Zsc4IxPI=;
 b=TQH0nHRKNbguKRzPuFf6t2iiSgaG2GwyzqKKV8ECrtN0GfV/7T7zUq2RFCmiA5wugi
 OUU2Kok4f/6C9LyiF7F15UAQngWGhd10bEoxXzMalggyXbl7D7MSjG0d9d9Ma/a1+rX1
 LN5gBuIoVPTJ6xg3SpeeKWplMwELg6QfGUNCZUr6oGl8YQv0djVH9vua6tzxxze/4Zu/
 NIQztITxopbJGOsz0DuGoeT/XZ6IzSi7Doa/8NbL13m0ANF7xNjo9gqdTq6lAW4YHcAz
 1nS0lwmnvPfMYweGk2tSr09XD4coIzgwhZoBpTRrPnlnYCWe8lUHl52tqFjSN67fs6ql
 FfxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+se8STs2lCH/DOcdIu+esbk2nB4InxtZv/NDi36TAZCt20O2EVFq5nT38xzvmu47yhCgu7SA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYqFltBuYvA1eY/elIl9sSZSdPo6uZXo8026fXaGWTagviE7y/
 Gx9H1g7ROoMromwrXjJlYbhHvIgNSci2TYqrqHafOQ8F2Pskzmgr2AOUfA+Libna/Bj1BV0/yLS
 HT2uUZfulh88EMCNGfeMxEJGmdf87GcEfj0P2lm27ZQ==
X-Gm-Gg: AeBDievBEd6TzLF44uaidhlQdeskgqqJhhPzVm2iPyK4uB2f1sBWFURHXBQDZyXYKBE
 36W2vdu0DPPrQobvt7QbqC/nmUII0STqggkclcafuNG7tEm/Wqdo1OkMdBU5ssiiUgO1hUE69qZ
 QRuaiJq3KN42ZPw6Y4+/vxfU25AlE/NE0Ig7HAsS3mwi2nt+jTNS1HSRzRJg61ribfWXnsBv75K
 5VpwqRFRggmTq76MX+Jv8nQPM7wc5VRLsDKbeUiM6U+54Bd8Rbn0RRHSdyw/FiMyjGmlW/iUlWn
 tHHpXP1Jco4fB9R3VOwJ7FKeI1D2T+MQ1iBFYPAYIVhNXMZ5Ro4pvjnCbKzEC8aVF2wNtxIoS++
 +u20iXaJD++LFJEYtDQWQmp4vudBhc1MBDLzqgEvcNzBe7aZ5RjHEt+n29RqgFdCeANzYVy/9DH
 4ETvuUgZ0P73Hm9ADyT3nn67HbmzDsONdBeU1WL41doBwrqz+G3UvAbLs74Q8Sp/qZYq1Y7+Jmi
 j5SE5/fuVZVQkMhhrMml7/rFMx8D91rI3IZ2HWWT9gUTnPRSxIT1GFJ6vNBRy8ghfKe6rjESXMg
 /3c5nRzI4oeKsz+VZZJZ8IrCrc/RfcdxG+HrJiTONrwhM0u2BX9UuR8dK3p0jo9gBiT+KaW6Kl6
 qyJESuPicAspX+Zqb
X-Received: by 2002:a05:690e:1246:b0:650:1724:f63c with SMTP id
 956f58d0204a3-65c3d9ca0c9mr12589985d50.20.1777977936779; Tue, 05 May 2026
 03:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260422170946.3394481-1-rs@ti.com>
 <20260422170946.3394481-3-rs@ti.com>
In-Reply-To: <20260422170946.3394481-3-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 13:45:00 +0300
X-Gm-Features: AVHnY4LswW6x8DKn6F7RmitAuVei0HtcY8sFvTsuaskRudgLdgdWDvf4U8pE_tU
Message-ID: <CAC_iWjKHYxzptmN35UKObMyGvbpFq39oFMO0_y6L0jeG=3zWLg@mail.gmail.com>
Subject: Re: [PATCHv5 2/6] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
To: rs@ti.com, Simon Glass <sjg@chromium.org>
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

Simon,

This looks ok to me, but I haven't been involved with the bootm code
much. Can you taker a quick look?

On Wed, 22 Apr 2026 at 20:10, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add a free flag and an initial call to free allocations covered by the
> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
> occur before the transition to the new device tree, thus we can access
> the currently active device tree through the global data pointer.
>
> This allows us to clearly indicate to the user when a device tree
> reservation fails. How we handle this can still use some improvement.
> Right now we'll keep the default behavior and try to boot anyway.
>
> This functionality was broken in:
> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>

[...]

either operation.
> + */
> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, bool free)
>  {

The function name is not accurate anymore. Perhaps call it
boot_fdt_handle_region()?

>         long ret;
>         phys_addr_t rsv_addr;
>
>         rsv_addr = (phys_addr_t)addr;
> -       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> +       if (free)
> +               ret = lmb_free(rsv_addr, size, flags);
> +       else
> +               ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size,
> +                                   flags);
> +
>         if (!ret) {
> -               debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> -                     (unsigned long long)addr,
> +               debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
> +                     free ? "freed" : "reserved", (unsigned long long)addr,
>                       (unsigned long long)size, flags);
> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> -               puts("ERROR: reserving fdt memory region failed ");
> -               printf("(addr=%llx size=%llx flags=%x)\n",
> -                      (unsigned long long)addr,
> -                      (unsigned long long)size, flags);
> +       } else {
> +               printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
> +                      free ? "freeing" : "reserving", (unsigned long long)addr,
> +                      (unsigned long long)size, flags, ret);
>         }
>  }
>
>  /**
> - * boot_fdt_add_mem_rsv_regions - Mark the memreserve and reserved-memory
> - * sections as unusable
> + * boot_fdt_add_mem_rsv_regions - Handle FDT memreserve and reserved-memory
> + * sections
>   * @fdt_blob: pointer to fdt blob base address
> + * @free: indicate if regions are being freed
>   *
> - * Adds the and reserved-memorymemreserve regions in the dtb to the lmb block.
> - * Adding the memreserve regions prevents u-boot from using them to store the
> - * initrd or the fdt blob.
> + * Adds or removes reserved-memory and memreserve regions in the dtb to the lmb
> + * block. Adding the memreserve regions prevents u-boot from using them to store
> + * the initrd or the fdt blob. This function will attempt to clean the currently
> + * active reservations if a new device tree blob is given.
>   */
> -void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> +void boot_fdt_add_mem_rsv_regions(void *fdt_blob, bool free)
>  {
>         uint64_t addr, size;
>         int i, total, ret;
> @@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>         if (fdt_check_header(fdt_blob) != 0)
>                 return;
>
> +       /* Remove old regions */
> +       if (gd->fdt_blob != fdt_blob)
> +               boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);
> +
>         /* process memreserve sections */
>         total = fdt_num_mem_rsv(fdt_blob);
>         for (i = 0; i < total; i++) {
>                 if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
>                         continue;
> -               boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE);
> +               boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE, free);
>         }
>
>         /* process reserved-memory */
> @@ -131,7 +151,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>                                         flags = LMB_NOMAP;
>                                 addr = res.start;
>                                 size = res.end - res.start + 1;
> -                               boot_fdt_reserve_region(addr, size, flags);
> +                               boot_fdt_reserve_region(addr, size, flags,
> +                                                       free);
>                         }
>
>                         subnode = fdt_next_subnode(fdt_blob, subnode);
> diff --git a/include/image.h b/include/image.h
> index 34efac6056d..68dfa4716ab 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -827,7 +827,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
>                  struct bootm_headers *images, char **of_flat_tree,
>                  ulong *of_size);
>
> -void boot_fdt_add_mem_rsv_regions(void *fdt_blob);
> +void boot_fdt_add_mem_rsv_regions(void *fdt_blob, bool free);
>  int boot_relocate_fdt(char **of_flat_tree, ulong *of_size);
>
>  int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8f12c6ad8e5..9a8c70b778a 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -581,7 +581,7 @@ static void lmb_reserve_common(void *fdt_blob)
>         lmb_reserve_uboot_region();
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
> -               boot_fdt_add_mem_rsv_regions(fdt_blob);
> +               boot_fdt_add_mem_rsv_regions(fdt_blob, false);
>  }
>
>  static __maybe_unused void lmb_reserve_common_spl(void)
> --
> 2.53.0
>

With the change above
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
