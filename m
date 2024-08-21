Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273DEC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 09:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFCF88B52;
	Wed, 21 Aug 2024 11:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jvFtst4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735DB88B58; Wed, 21 Aug 2024 11:11:55 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C7F889F8
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5de0e47b9so3543499eaf.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724231512; x=1724836312; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ju5LqlzDISd0AW3lg83F4370/RAckLGTsxynzdm923I=;
 b=jvFtst4NdRar9sFwskses4TwYUGjhg1uKrseARUneCbfbhxJT0U2tYwqI5ldyzrNHQ
 s+E/gmGE7cIdzb8u7udrJIZOF/sTQrlgcaNXPiIiWsdpIHR4BA4rQ8C8Blbr7thD6qyO
 Xz4ToBhf2EQ6Ms2UzDFni79gsLgvXWx7W86x+Ono4Sk82RkD0jYexCwLjNEzI5xjVa4M
 Sau3clx+/pq9ducRHYlr/Ymo5xjhpiG9joMta3PXWHRHHmCseEHevI4can4ZEJoxLOWE
 ufdRcS1SBmVFT0i939G3joZb7yzc+/YzwPmdQXkpkQnDd/EYoUNXtd3g1LaChBDMTR5t
 slJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724231512; x=1724836312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ju5LqlzDISd0AW3lg83F4370/RAckLGTsxynzdm923I=;
 b=q0X21hPtkmFejjixQvMzlrbYKdiXYhOptoD5cohVrlMCW/5W/mzfC7Cr64x7FRLP7b
 7xE4qtXKGO0iSM1DmzkDeG3Tmue94LXkOP++JCEOXJnj6VUuSOVGQ8tT80PqCFahYDT5
 FD75H7ieSnpOEcnqy8gB4Q44dyJysOSQnkHCGVJbZsoy6m1ltWYzg3Ih2Gqi44SB2EpU
 TzQqN9pySadrxvmrNCNumyrVY+BRPtD0BSDRzgQh4qwCaMh2H/DrDy70UWQ3MRcPHjq9
 wkitNB6ZGvUarWhsKzr0bNZqGwcIdCw+LYr/MeQBBo62tFVyF/SoQF3kFPPo7lKKrSaV
 ZG+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyQlmzsJeq4vFyl8s3l/nWLnvsUDjyBtYUNzYScwgQV70A9unAoCQNq3UV6ni+IF1ivXhD4ns=@lists.denx.de
X-Gm-Message-State: AOJu0YxqL140P9QT4nXrSvS28csvycF2FJaAuSDKdcxlaFLBpKk0S6bC
 haS6q4nVsDyrMXXisrl26UQ3vls5x32AcfIgEuR4hVDqkiyyOedfxpV3qUSXGDOt6Jsua+kEXjS
 zipmBXhiWwGmpKsaUP+hewt9nawzotHMqMSJKbQ==
X-Google-Smtp-Source: AGHT+IGqaaA+3kQcZ3CwSZSfEicGooDrLRdSe0v9MnPNbVX0hNOY/19pME14vc86ckzizpJYeG5N7DwgO/gjCloVGOI=
X-Received: by 2002:a05:6359:4589:b0:1b1:a666:2bba with SMTP id
 e5c5f4694b2df-1b59fce1afbmr232154055d.24.1724231511660; Wed, 21 Aug 2024
 02:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-4-mchitale@ventanamicro.com>
 <d7363b19-5cc6-4590-adfb-0889ea3aaf5f@canonical.com>
In-Reply-To: <d7363b19-5cc6-4590-adfb-0889ea3aaf5f@canonical.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Wed, 21 Aug 2024 14:41:15 +0530
Message-ID: <CAN37VV4+YkL3=H+M0qahnaPA6oHzGU_pnp4-MqftUK3fty2jhg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] board: qemu-riscv: Override enable_caches
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de, 
 Rick Chen <rick@andestech.com>
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

Hi Heinrich,

On Tue, Aug 20, 2024 at 5:43=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.08.24 11:37, Mayuresh Chitale wrote:
> > Define enable_caches function for the qemu-riscv board which probes for
> > the cbom-block-size dt property when RISCV_ISA_ZICBOM is enabled. Also
> > add flush_dcache_range and invalidate_dcache_range functions which use
> > the corresponding CBO ops.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   board/emulation/qemu-riscv/qemu-riscv.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/=
qemu-riscv/qemu-riscv.c
> > index e5193e31e3..1795d2f831 100644
> > --- a/board/emulation/qemu-riscv/qemu-riscv.c
> > +++ b/board/emulation/qemu-riscv/qemu-riscv.c
> > @@ -14,6 +14,7 @@
> >   #include <usb.h>
> >   #include <virtio_types.h>
> >   #include <virtio.h>
> > +#include <asm/cache.h>
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -70,3 +71,18 @@ void *board_fdt_blob_setup(int *err)
> >       /* Stored the DTB address there during our init */
> >       return (void *)(ulong)gd->arch.firmware_fdt_addr;
> >   }
> > +
> > +void enable_caches(void)
> > +{
> > +     riscv_zicbom_init();
> > +}
>
> Enable caches may be called multiple times. But riscv_zicbom_init() only
> needs to be called once.
Ok.
>
> > +
> > +void flush_dcache_range(unsigned long start, unsigned long end)
> > +{
> > +     cbo_flush(start, end);
> > +}
> > +
> > +void invalidate_dcache_range(unsigned long start, unsigned long end)
> > +{
> > +     cbo_inval(start, end);
> > +}
>
> The ZICBOM extension is not specific to a single board. We should not
> add this code to board files but into the central place for cache
> operations, i.e. arch/riscv/lib/cache.c.
Most of the code is already cache.c. I didn't know if it would suffice
for all platforms so I decided to override the weak functions like in
ARM.

> E.g.
>
> static int get_zicbom_block_size()
> {
>         if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
>                 return 0;
>         if (zicbom_block_size)
>                 return zicbom_block_size;
>
>         uclass_first_device(UCLASS_CPU, &dev);
>         if (!dev) {
>                 log_err("Failed to get CPU device!\n");
>                 return 0;
>         }
>
>         if (dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size=
))
>                 return 0;
>
>         return zicbom_block_size
> }
>
> __weak void invalidate_icache_range(unsigned long start, unsigned long en=
d)
> {
>         if (CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) && get_zicbom_block_size(=
))
>                 cbo_inval(start, end);
>         else
>                 invalidate_icache_all();
> }
>
> Cc: Rick as one of the RISC-V maintainers.
Ok.
>
> Best regards
>
> Heinrich
>
