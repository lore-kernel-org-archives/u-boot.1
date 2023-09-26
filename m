Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEBFE8181F
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 05:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDA486B09;
	Tue, 26 Sep 2023 07:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dxSiv/0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D084786B93; Tue, 26 Sep 2023 07:07:33 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847A886B05
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=apatel@ventanamicro.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690bf8fdd1aso6097717b3a.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 22:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695704850; x=1696309650; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3GZz3FshFtZpe70DZzr5uOWMA0s+hLNB6Zlo+Uuhzo=;
 b=dxSiv/0/8bwSuo7BskFmDmVSsl3Qfhm2WHNH7WLuYL3jGdE21PEVrbIt3jGeBRly66
 0CSaak3F+K9D3Owbveo+2adj6230nimB8lkuZ44WQsREp4gIjggD7udAVa0IVtPRd5Vs
 c5SSCj79pcEuRRCXM09r2s49SDx+T7v//+8lr5vkwYIYH7i0dBI4eqx9HdmQJPTA5w6m
 3CuaPD1qdmof8dKgmsoLtDyj3fbjV+LUiwlGrmdf/eJFsr7KRrfoWLUn4pqT9+cZsyCm
 0RkEFVoZ4b+SkBtmMM9S+YhpCVQy23HbOEyH0ipqaVsaV9NpEOD7vcgdra9j0ktt/a+e
 K8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695704850; x=1696309650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3GZz3FshFtZpe70DZzr5uOWMA0s+hLNB6Zlo+Uuhzo=;
 b=EuRIXvztSvq/cbmC2Z/vhOCU3KBS76Fkb4ui37TAt77mxGthYhI4ujurlZXeTKE7jP
 CInwrOm+2MWUGMJqG6rRLo112DRyvevuFLs3dfByCv5WF4TWMeetgJTXRzT2s5V+hPHF
 6xgL0rOWzd1AJM2k033RoZLS5QlwYxEN6PEWfa6ty/oQqWkXeWcYajBbwJlKBYA7hHoP
 Rpq2yXWXIdcYOoN6xigDNDvTpaXgFnafqmwP6+4iCEYQ39qY3PTmKJtjs4wEdMTRj4EZ
 uKAR4yyoZkKCfHc4JxjEMTBhxxeNM+VY9q3NZUg5zrh8O9hWt0XQdSqk3ySb2TcSCWB+
 jHPA==
X-Gm-Message-State: AOJu0Yx4gWOGJhty2TPfs/Kj6L0hthZ+XlWaJr1XTKz/cTiCy1t6CNAK
 icArvHZhysK80m+hDPs9HhSRd8atb6cmsVtjvwVcGg==
X-Google-Smtp-Source: AGHT+IEV+8sQejGBr8JL/iN6EI7v4oUw2JtaBH5+eBFif1KDwu4mmc8xtLVOhN/AswrToi6IoSilGA3Es9HRcko6xIk=
X-Received: by 2002:a05:6a21:4982:b0:13d:5b70:17da with SMTP id
 ax2-20020a056a21498200b0013d5b7017damr6241103pzc.26.1695704849650; Mon, 25
 Sep 2023 22:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
In-Reply-To: <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 26 Sep 2023 10:37:17 +0530
Message-ID: <CAK9=C2WzoyTr15PrR+TZ+KAq+RGVxJk7yrbUX9nR+kUWq0qGug@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Wu, Fei" <fei2.wu@intel.com>, rick@andestech.com, ycliang@andestech.com, 
 bmeng.cn@gmail.com, sjg@chromium.org, u-boot@lists.denx.de, pali@kernel.org,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
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

On Thu, Sep 14, 2023 at 12:49=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 9/14/23 08:48, Wu, Fei wrote:
> > On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
> >>
> >>
> >> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>=
:
> >>> In order to enable PCIe passthrough on qemu riscv, the physical memor=
y
> >>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram=
,
> >>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot set=
s
> >>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
> >>
> >> This should move to 7GiB - 1 in your example on riscv64.
> >>
> > I'm describing the current implementation of board_get_usable_ram_top()
> > in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
> > changed? Is the comment about 32bit DMA device still valid?
> >
> > phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> > {
> >          /*
> >           * Ensure that we run from first 4GB so that all
> >           * addresses used by U-Boot are 32bit addresses.
> >           *
> >           * This in-turn ensures that 32bit DMA capable
> >           * devices work fine because DMA mapping APIs will
> >           * provide 32bit DMA addresses only.
> >           */
> >          if (gd->ram_top >=3D SZ_4G)
> >                  return SZ_4G - 1;
> >
> >          return gd->ram_top;
> > }
>
> The comment above says 32bit DMA is board specific and not architecture
> specific. So it is wrong to have this board_get_usable_ram_top()
> function on architecture level. It makes usage of devices with all
> memory above 4 GiB impossible.
>
> It tried to pass through a SATA controller but received an error:
>
> # modprobe vfio-pci
> # echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
> # echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
> # qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
> -device vfio-pci,host=3D0000:06:00.0
> qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: VFIO_MAP_DMA
> failed: Invalid argument
> qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: vfio
> 0000:06:00.0: failed to setup container for group 5: memory listener
> initialization failed: Region riscv_virt_board.ram:
> vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =3D
> -22 (Invalid argument)
>
> With which version of QEMU were you able to use PCI pass through?

The original S-mode SiFive unleashed board support was using the
generic CPU under arch/riscv. We have Cadance MACB ethernet
device on this board which is a 32-bit device and can't access memory
beyond 4GB.

For more details, refer "git show 26f4fd1cb4f2"

I think we can wrap the board_get_usable_ram_top() implementation
in generic RISC-V CPU with a #ifdef Kconfig option which allows
certain boards (such as QEMU-virt) to implement their own
board_get_usable_ram_top().

Regards,
Anup

>
> Best regards
>
> Heinrich
>
> >
> >>> board_get_usable_ram_top(), but that address is not backed by ram. Th=
is
> >>> patch selects the lowest range instead.
> >>>
> >>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> >>> ---
> >>> arch/riscv/cpu/generic/dram.c        | 2 +-
> >>> configs/qemu-riscv64_defconfig       | 2 +-
> >>> configs/qemu-riscv64_smode_defconfig | 2 +-
> >>> configs/qemu-riscv64_spl_defconfig   | 2 +-
> >>> 4 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/d=
ram.c
> >>> index 44e11bd56c..fb53a57b4e 100644
> >>> --- a/arch/riscv/cpu/generic/dram.c
> >>> +++ b/arch/riscv/cpu/generic/dram.c
> >>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
> >>>
> >>> int dram_init(void)
> >>> {
> >>> -   return fdtdec_setup_mem_size_base();
> >>> +   return fdtdec_setup_mem_size_base_lowest();
> >>
> >> Linaro is working on allowing to download a distro image via https and=
 installing from a RAM disk.
> >>
> >> We should not artificially reduce the RAM size available for U-Boot by=
 restricting ourselfs to 1 GiB.
> >>
> >> We must ensure that ram top is in the upper range.
> >>
> > How do they handle the case of >4GB? board_get_usable_ram_top() attache=
d
> > above always returns <4GB. And it seems like
> > fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
> > just picks up one, but which one is selected depending on fdt.
> >
> > Thanks,
> > Fei.
> >
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> }
> >>>
> >>> int dram_init_banksize(void)
> >>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_de=
fconfig
> >>> index 9a8bbef192..aa55317d26 100644
> >>> --- a/configs/qemu-riscv64_defconfig
> >>> +++ b/configs/qemu-riscv64_defconfig
> >>> @@ -1,6 +1,6 @@
> >>> CONFIG_RISCV=3Dy
> >>> CONFIG_SYS_MALLOC_LEN=3D0x800000
> >>> -CONFIG_NR_DRAM_BANKS=3D1
> >>> +CONFIG_NR_DRAM_BANKS=3D2
> >>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> >>> CONFIG_ENV_SIZE=3D0x20000
> >>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-risc=
v64_smode_defconfig
> >>> index 1d0f021ade..de08a49dab 100644
> >>> --- a/configs/qemu-riscv64_smode_defconfig
> >>> +++ b/configs/qemu-riscv64_smode_defconfig
> >>> @@ -1,6 +1,6 @@
> >>> CONFIG_RISCV=3Dy
> >>> CONFIG_SYS_MALLOC_LEN=3D0x800000
> >>> -CONFIG_NR_DRAM_BANKS=3D1
> >>> +CONFIG_NR_DRAM_BANKS=3D2
> >>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> >>> CONFIG_ENV_SIZE=3D0x20000
> >>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv6=
4_spl_defconfig
> >>> index bb10145e6e..66dc2a1dd9 100644
> >>> --- a/configs/qemu-riscv64_spl_defconfig
> >>> +++ b/configs/qemu-riscv64_spl_defconfig
> >>> @@ -1,6 +1,6 @@
> >>> CONFIG_RISCV=3Dy
> >>> CONFIG_SYS_MALLOC_LEN=3D0x800000
> >>> -CONFIG_NR_DRAM_BANKS=3D1
> >>> +CONFIG_NR_DRAM_BANKS=3D2
> >>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> >>> CONFIG_ENV_SIZE=3D0x20000
> >
>
