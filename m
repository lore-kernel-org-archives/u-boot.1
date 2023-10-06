Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F20E81DE8
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E54286E2C;
	Fri,  6 Oct 2023 13:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TGYJoUyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D55386E70; Fri,  6 Oct 2023 13:41:23 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09522869C4
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=brainfault.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=anup@brainfault.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-54290603887so1425214a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1696592479; x=1697197279;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zv9eNeQAgQzBZ1Afz0Kh+7OIj+bJLjicPuFgFhI9EWQ=;
 b=TGYJoUyh7eZ5nMtaBAOMW4H7wlr1Yr1qe8OBk2z8Kg8dYDxau9dJSBsBRoJSP7sEr0
 0CnJzQxAQx+NKk8vqd13V96mYL4QRZCcwXg3BnhAvKGuwt1/whBmsSYNYUeDI8D5kWlF
 vR4OsKWHddZJW8akWyNtd1rRkXGC4GfrNA7nZo6Z5XFnMXoH+uu3Ntzvw1IxHGIyIcr+
 SoxvW7eMbRGH1UCbnH1ZwWXUBgfWQe/KrxIE1ITNPgvvbSHVaq94E6C1DN0bfDq+FOrH
 rJO0DXk4if/ANRsparVJDI2l2XvJPrjLaQcNkF0ERuXUInkfkdWNpE21z8agwCbgQVB0
 lR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696592479; x=1697197279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zv9eNeQAgQzBZ1Afz0Kh+7OIj+bJLjicPuFgFhI9EWQ=;
 b=D91k49tpaRQFqSFFSpJWRO+TyPSwzht1VcPq7iZU56PM1c2Zt2mpgi2t2iGZZjJTQL
 tYp9/x/HO3JynNEDtkqF4u/VkMOZpzePDUDCEmesYd1OX10T0Ee+gRNDvflvA8MNslTF
 wYeyimFKdwRrgJn21FLi99EZCbOXc3eBaxY6SuJulRQIFvWlHuY3iRtodAtEP/FVoZ6r
 NC9RpIdKVvZaHUWc+xeN7vZSMQt/eYthDMOPugW30zzR5fUsKEzeLwXukdXtLTKH3grs
 sEl0x3N396PJy3Ew0sHf5uPcWsgUdIjgiYR8tvNi/UHu9Mqx0c44p8Zc3xX7sJQuFk0S
 e1Ng==
X-Gm-Message-State: AOJu0YzV2gGhhqgcDlZQBx4gH898n1xejgvuaGfPfetcLr81A8HIbYTq
 KrWxtc81YRa3y9f1wV/9237zesCPhbE0ADQNK/FMmg==
X-Google-Smtp-Source: AGHT+IEfTvkp9X7qPYps6Haqhze2Uy993i8sIibwCSlZj8RPHkWj63r5XVvZdMl/vb+YjuQwuvLJhlFg5CKoDdu42C4=
X-Received: by 2002:a17:90b:3ec6:b0:269:55a2:952c with SMTP id
 rm6-20020a17090b3ec600b0026955a2952cmr7050046pjb.40.1696592478990; Fri, 06
 Oct 2023 04:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 6 Oct 2023 17:11:07 +0530
Message-ID: <CAAhSdy3FWds0+MO9_yLvHnwRAk=_BNZUxNfon-7njMJ_uQSPbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: remove dram_init_banksize()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 Fei Wu <fei2.wu@intel.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 26, 2023 at 12:47=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove dram_init_banksize() on the architecture level.
>
> Limiting used RAM to under 4 GiB is only necessary for CPUs which have a
> DMA issue. SoC specific code already exists for FU540, FU740, JH7110.
>
> Not all RISC-V boards will have memory below 4 GiB.
>
> A weak implementation of dram_init_banksize() exists in common/board_f.c.
>
> See the discussion in
> https://lore.kernel.org/u-boot/545fe813-cb1e-469c-a131-0025c77aeaa2@canon=
ical.com/T/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/cpu/generic/dram.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.=
c
> index 94d8018407..1b51bae9b6 100644
> --- a/arch/riscv/cpu/generic/dram.c
> +++ b/arch/riscv/cpu/generic/dram.c
> @@ -20,19 +20,3 @@ int dram_init_banksize(void)
>  {
>         return fdtdec_setup_memory_banksize();
>  }
> -
> -phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> -{
> -       /*
> -        * Ensure that we run from first 4GB so that all
> -        * addresses used by U-Boot are 32bit addresses.
> -        *
> -        * This in-turn ensures that 32bit DMA capable
> -        * devices work fine because DMA mapping APIs will
> -        * provide 32bit DMA addresses only.
> -        */
> -       if (gd->ram_top >=3D SZ_4G)
> -               return SZ_4G - 1;
> -
> -       return gd->ram_top;
> -}
> --
> 2.40.1
>
