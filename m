Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F01CC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 09:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52F588BBC;
	Wed, 21 Aug 2024 11:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N8/Sw0yB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDF988BC6; Wed, 21 Aug 2024 11:12:33 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C122889F8
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a1d81dc0beso422398885a.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724231550; x=1724836350; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5brP43sDlLHgFI8dJkHi+T/ZHMcjF26gFEeFM41qM8Q=;
 b=N8/Sw0yB/Zf6fwWxcy0IhnaKa9imqEnHIlg1Ssjr7CpnHi4cT5YGoO3pyhsV1spNiq
 M6++rCOqh+UuYr59RZtXYRWoolIU2SJhJvY60FLgGr5TPTS17Sel0Tq50OoWyu9+A80T
 nZn2LKDdGZ+rnPMsxt/FJMeOlYvWHG/ZOWcQHHYyBZ2ywVxk1wbxqftOHAl20q0jNlng
 w54LX+JKbpMKIqftxmoIIEkekg1gucuJNG7ml+ioL3WKXJVb5r67oTQqtSTvRBHJOaFc
 Ygr+a0584D5XwQESMqH4r1vcf9IEOKHFm627HMJ/sipVxgruLpfilHyrNXsM8gtS+GNZ
 psDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724231550; x=1724836350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5brP43sDlLHgFI8dJkHi+T/ZHMcjF26gFEeFM41qM8Q=;
 b=KPxtcvnRVBq3R7u8g3npLrDv8evYVIDevpZm+GUI0Yrd6rqkdodjglMKzeS8UK+JMk
 5nh3Z6WGgnXzB1LU4v26XYIUmU03OVVYWEftYiucVbzmGVMazEszEGiwT0tlt3YIVuZQ
 7CTXzhGmPVTpJUGa4qRWg1dKh0IM5NMOMRFX/XoQfxGDGtZUmrukK4ntJMKwAgWjuLfd
 VZgX5QrdOv0FgDyrWcXWSZ/X26+kZ5fwQNB63jmDHIBkOwGBp3ZwTZbvkrShedAj6/OQ
 2nMK9t7KvcIHxLykLznyjC95jHbX6s/KpuIDOcg+y0mNpixtxu0kg8WJOPRrSjZdzXh6
 c8Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKja3svkdlqzbVpyyODq7YTVXFApFUQHtZoYtocBB1pkREP8QBKbXwl4mSOOcG6jiQkNn7uTc=@lists.denx.de
X-Gm-Message-State: AOJu0YyFC028/4WHeEq25z8d/2JqURECNVGKSrxHZGwxgiDEoR5S8ZZB
 5TfZgXBaZVJYWVu9y7EKzWjm5hawTinLAQobno+OhebM1AUJe4+vF4eoi6rY1abeYfSJzzMlLGT
 ifUullw/Mlpr2jqrjhwzFzYIUSlHUeZ6FtzhYPA==
X-Google-Smtp-Source: AGHT+IFdVR2Hjn8Ikh6Tgh15yZuLCgddkyr7xIAXPhiDf5BK65alDcDuAZfSPEIjA+EIEm0Qq2GUC1zZPyrPl/YRIT4=
X-Received: by 2002:a05:620a:458c:b0:79e:fed9:7937 with SMTP id
 af79cd13be357-7a6740b9a15mr213619185a.43.1724231549995; Wed, 21 Aug 2024
 02:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
In-Reply-To: <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Wed, 21 Aug 2024 14:41:53 +0530
Message-ID: <CAN37VV6uYHZyOnAUuJ2viHem7Q88HD=-_+r3F5cAF=JOpAaKJA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Samuel Holland <samuel@sholland.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 u-boot@lists.denx.de
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

On Tue, Aug 20, 2024 at 5:49=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 20.08.24 11:37, Mayuresh Chitale wrote:
> > Define CBO inval and flush instructions and use those for the
> > dcache inval and flush operations respectively.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   arch/riscv/Kconfig             |  4 ++
> >   arch/riscv/include/asm/cache.h |  3 ++
> >   arch/riscv/lib/cache.c         | 90 +++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 97 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fa3b016c52..0f89d07be7 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -310,6 +310,10 @@ endmenu
> >   config RISCV_ISA_A
> >       def_bool y
> >
> > +config RISCV_ISA_ZICBOM
> > +     bool "Zicbom support"
> > +     depends on !SYS_DISABLE_DCACHE_OPS
> > +
> >   config DMA_ADDR_T_64BIT
> >       bool
> >       default y if 64BIT
> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/ca=
che.h
> > index 874963d731..42dbce5b4f 100644
> > --- a/arch/riscv/include/asm/cache.h
> > +++ b/arch/riscv/include/asm/cache.h
> > @@ -9,6 +9,9 @@
> >
> >   /* cache */
> >   void cache_flush(void);
> > +void riscv_zicbom_init(void);
> > +void cbo_flush(unsigned long start, unsigned long end);
> > +void cbo_inval(unsigned long start, unsigned long end);
> >
> >   /*
> >    * The current upper bound for RISCV L1 data cache line sizes is 32 b=
ytes.
> > diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
> > index afad7e117f..456353d9c1 100644
> > --- a/arch/riscv/lib/cache.c
> > +++ b/arch/riscv/lib/cache.c
> > @@ -5,6 +5,95 @@
> >    */
> >
> >   #include <cpu_func.h>
> > +#include <dm.h>
> > +#include <asm/insn-def.h>
> > +#include <linux/const.h>
> > +
> > +#define CBO_INVAL(base)                                              \
> > +     INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > +            RS1(base), SIMM12(0))
> > +#define CBO_CLEAN(base)                                              \
> > +     INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > +            RS1(base), SIMM12(1))
> > +#define CBO_FLUSH(base)                                              \
> > +     INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > +            RS1(base), SIMM12(2))
> > +enum {
> > +     CBO_CLEAN,
> > +     CBO_FLUSH,
> > +     CBO_INVAL
> > +} riscv_cbo_ops;
> > +static int zicbom_block_size;
> > +
> > +static inline void do_cbo_clean(unsigned long base)
> > +{
> > +     asm volatile ("add a0, %0, zero\n" CBO_CLEAN(%0) ::
> > +                   "r"(base) : "memory");
> > +}
> > +
> > +static inline void do_cbo_flush(unsigned long base)
> > +{
> > +     asm volatile ("add a0, %0, zero\n" CBO_FLUSH(%0) ::
> > +                   "r"(base) : "memory");
> > +}
> > +
> > +static inline void do_cbo_inval(unsigned long base)
> > +{
> > +     asm volatile ("add a0, %0, zero\n" CBO_INVAL(%0) ::
> > +                   "r"(base) : "memory");
> > +}
> > +
> > +static void cbo_op(int op_type, unsigned long start,
> > +                unsigned long end)
> > +{
> > +     unsigned long op_size =3D end - start, size =3D 0;
> > +     void (*fn)(unsigned long base);
> > +
> > +     switch (op_type) {
> > +     case CBO_CLEAN:
> > +             fn =3D do_cbo_clean;
> > +             break;
> > +     case CBO_FLUSH:
> > +             fn =3D do_cbo_flush;
> > +             break;
> > +     case CBO_INVAL:
> > +             fn =3D do_cbo_inval;
> > +             break;
> > +     }
> > +     start &=3D ~(UL(zicbom_block_size - 1));
> > +     while (size < op_size) {
> > +             fn(start + size);
> > +             size +=3D zicbom_block_size;
> > +     }
> > +}
> > +
> > +void cbo_flush(unsigned long start, unsigned long end)
> > +{
> > +     if (zicbom_block_size)
> > +             cbo_op(CBO_FLUSH, start, end);
> > +}
> > +
> > +void cbo_inval(unsigned long start, unsigned long end)
> > +{
> > +     if (zicbom_block_size)
> > +             cbo_op(CBO_INVAL, start, end);
> > +}
> > +
> > +void riscv_zicbom_init(void)
> > +{
> > +     struct udevice *dev;
> > +
> > +     if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> > +             return;
> > +
> > +     uclass_first_device(UCLASS_CPU, &dev);
> > +     if (!dev) {
> > +             log_err("Failed to get cpu device!\n");
> > +             return;
>
> Please, return an error code.
>
> > +     }
> > +
> > +     (void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_si=
ze);
>
> Please, do not ignore errors.
Ok.
>
> Best regards
>
> Heinrich
>
> > +}
> >
> >   void invalidate_icache_all(void)
> >   {
> > @@ -72,4 +161,5 @@ __weak int dcache_status(void)
> >
> >   __weak void enable_caches(void)
> >   {
> > +     puts("WARNING: Caches not enabled\n");
> >   }
>
