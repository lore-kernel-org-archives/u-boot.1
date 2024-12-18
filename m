Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC1DE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601C98022B;
	Wed, 18 Dec 2024 13:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N0/XJ4o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6840E80214; Wed, 18 Dec 2024 02:46:51 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3333B801CE
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso861028166b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734486408; x=1735091208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ulrUte3wEkAEMsUTkzNS8oTVKUq+jtyv9VT60HHI8B0=;
 b=N0/XJ4o04mv7beIP31CuKHnZyx/PgkH3VzKt1RwN5Yq4XRq46qg5JOTaOwkfF7k/6C
 Pmx0/wZ2nuFG09jueJhAo7/FKYepEjLbSRSWv0O0s5HKNgSdUS4hHSE2nQM4mCKrNF8o
 wHnTBFR0mstA7gfDzDflWBxkaK01k0sKRX2MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734486408; x=1735091208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ulrUte3wEkAEMsUTkzNS8oTVKUq+jtyv9VT60HHI8B0=;
 b=Ctbp6uWeUMACKBld/gwDCcOOQ4InP7xputHssy0FbWq9daNNzOxm6inAFPEc2LcfZ7
 VAtSBsTCfw1B2NzCwlzhFpPrzdkKxBFImCa4aOyzV4KnkMS0O1DapCePz1xok8/hr2sv
 Ceki/IV4I+gsIystrb8WDBIlNLO7mJtiDV+WpiqJ9iSmV9sO7Fjj8wXXX032LdMWSmbe
 jkphDeiNGGuzg5HXNigSMlbKouo52WI8kbSX/QhPZKJ1TPnMSTk65ytQfpGJ0F0UdK19
 uaECFMTijZxra40NkkFppr/jshsQDE+MFmxv7LppRkgkWcmx3HedacNBvGm/enQqA+X2
 QrlQ==
X-Gm-Message-State: AOJu0YzfyGkhTyeFRhLbK5RbGKtqmQJwNPige1rOC7X702ONMPiWJbVs
 g8grzClTafBZuNcB5yHxPYfyXpA0UaehQm+PGNmUew7Zw2OyzjLT2kiy8ZuvyQJibte2TJpsADc
 ued8Qh2zqvM518YZs3lDq90KqMnRrj410weve
X-Gm-Gg: ASbGnctWqgabn2cdEawaf+Mjnr+6oNdpyhFCvm/2C11PkSjBagXPHGZv8LvGkxGLS8A
 aG0ik2cdx+drySKs3l+QFhMiQFapHwzAQ/Kfd2CA=
X-Google-Smtp-Source: AGHT+IGRXCKgFE/Z3RG/DDP12mP3NeOPsRNTbana0r+mk4nfglClvG0yTGJmIQN6PyWPO8hwPgGwQijafEt6eVFEy7M=
X-Received: by 2002:a17:906:f5aa:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-aabf473fe7emr64984466b.14.1734486408588; Tue, 17 Dec 2024
 17:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20241102174944.412088-1-sjg@chromium.org>
 <20241102174944.412088-2-sjg@chromium.org>
 <280e1d54-89ff-496f-93d3-0de7a9797bc9@foss.st.com>
In-Reply-To: <280e1d54-89ff-496f-93d3-0de7a9797bc9@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 18:46:37 -0700
Message-ID: <CAFLszTjyxf9m4twDCQw6K99QXA5DmM9nAt-ryH5M3gb5bKyBzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fdt: Swap the signature for board_fdt_blob_setup()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, Alexander Graf <agraf@csgraf.de>, 
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 David Feng <fenghua@phytium.com.cn>, E Shattow <lucent@gmail.com>, 
 Eric Curtin <ecurtin@redhat.com>, Francois Berder <fberder@outlook.fr>, 
 Green Wan <green.wan@sifive.com>, H Bell <dmoo_dv@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 "Ivan T. Ivanov" <iivanov@suse.de>, James Hilliard <james.hilliard1@gmail.com>,
 Janne Grunau <j@jannau.net>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, Matthias Brugger <mbrugger@suse.com>, 
 Michal Simek <michal.simek@amd.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sam Day <me@samcday.com>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot-qcom@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Dec 2024 13:47:35 +0100
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

On Tue, 26 Nov 2024 at 10:10, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 11/2/24 18:49, Simon Glass wrote:
> > This returns a devicetree and updates a parameter with an error code.
> > Swap it, since this fits better with the way U-Boot normally works. It
> > also (more easily) allows leaving the existing pointer unchanged.
> >
> > No yaks were harmed in this change, but there is a very small code-size
> > reduction.
> >
> > For sifive, the OF_BOARD option must be set for the function to be
> > called, so there is no point in checking it again. Also OF_SEPARATE is
> > defined always.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Set up the existing FDT in case the board wants to check it
> > - Update snapdragon to return -EEXIST
> > - Set the existing FDT before calling board_fd_blob_setup()
> > - Update sandbox to return -EEXIST if an fdt comes from a bloblist
> > - Update do_go_uboot() to set the existing FDT
> > - Drop unnecessary setting of FDT in vexpress64
> > - Tidy up redundant RISC-V code
> >
> >  arch/arm/mach-apple/board.c                   |  7 ++--
> >  arch/arm/mach-snapdragon/board.c              |  9 ++---
> >  arch/arm/mach-stm32mp/boot_params.c           | 19 ++++++-----
> >  arch/sandbox/cpu/cpu.c                        | 34 +++++++++----------
> >  board/Marvell/octeontx/board-fdt.c            | 12 +++----
> >  board/Marvell/octeontx2/board-fdt.c           | 12 +++----
> >  board/Marvell/octeontx2/board.c               |  3 +-
> >  board/andestech/ae350/ae350.c                 | 23 +++++++------
> >  board/armltd/vexpress64/vexpress64.c          | 33 ++++++++----------
> >  board/broadcom/bcmstb/bcmstb.c                |  7 ++--
> >  board/emulation/qemu-arm/qemu-arm.c           |  7 ++--
> >  board/emulation/qemu-ppce500/qemu-ppce500.c   | 12 +++----
> >  board/emulation/qemu-riscv/qemu-riscv.c       |  7 ++--
> >  board/highbank/highbank.c                     |  7 ++--
> >  board/raspberrypi/rpi/rpi.c                   | 13 ++++---
> >  board/sifive/unleashed/unleashed.c            | 12 +++----
> >  board/sifive/unmatched/unmatched.c            | 11 +++---
> >  .../visionfive2/starfive_visionfive2.c        | 11 +++---
> >  board/xen/xenguest_arm64/xenguest_arm64.c     | 14 ++++----
> >  board/xilinx/common/board.c                   | 26 ++++++++------
> >  include/fdtdec.h                              |  9 ++---
> >  lib/fdtdec.c                                  | 14 +++++---
> >  22 files changed, 152 insertions(+), 150 deletions(-)
> >
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index 0b6d290b8ac..2644a04a622 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -691,11 +691,12 @@ int dram_init_banksize(void)
> >
> >  extern long fw_dtb_pointer;
> >
> > -void *board_fdt_blob_setup(int *err)
> > +int board_fdt_blob_setup(void **fdtp)
> >  {
> >       /* Return DTB pointer passed by m1n1 */
> > -     *err = 0;
> > -     return (void *)fw_dtb_pointer;
> > +     *fdtp = (void *)fw_dtb_pointer;
> > +
> > +     return 0;
> >  }
> >
> >  void build_mem_map(void)
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index 2ab2ceb5138..cd49de540f0 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -147,12 +147,12 @@ static void show_psci_version(void)
> >   * or for supporting quirky devices where it's easier to leave the downstream DT in place
> >   * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> >   */
> > -void *board_fdt_blob_setup(int *err)
> > +int board_fdt_blob_setup(void **fdtp)
> >  {
> >       struct fdt_header *fdt;
> >       bool internal_valid, external_valid;
> > +     int ret = 0;
> >
> > -     *err = 0;
> >       fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
> >       external_valid = fdt && !fdt_check_header(fdt);
> >       internal_valid = !fdt_check_header(gd->fdt_blob);
> > @@ -167,10 +167,11 @@ void *board_fdt_blob_setup(int *err)
> >
> >       if (internal_valid) {
> >               debug("Using built in FDT\n");
> > +             ret = -EEXIST;
> >       } else {
> >               debug("Using external FDT\n");
> >               /* So we can use it before returning */
> > -             gd->fdt_blob = fdt;
> > +             *fdtp = fdt;
> >       }
> >
> >       /*
> > @@ -179,7 +180,7 @@ void *board_fdt_blob_setup(int *err)
> >        */
> >       qcom_parse_memory();
> >
> > -     return (void *)gd->fdt_blob;
> > +     return ret;
> >  }
> >
> >  void reset_cpu(void)
> > diff --git a/arch/arm/mach-stm32mp/boot_params.c b/arch/arm/mach-stm32mp/boot_params.c
> > index ebddf6a7dbc..2d058edc419 100644
> > --- a/arch/arm/mach-stm32mp/boot_params.c
> > +++ b/arch/arm/mach-stm32mp/boot_params.c
> > @@ -6,6 +6,7 @@
> >  #define LOG_CATEGORY LOGC_ARCH
> >
> >  #include <config.h>
> > +#include <errno.h>
> >  #include <log.h>
> >  #include <linux/libfdt.h>
> >  #include <asm/arch/sys_proto.h>
> > @@ -16,20 +17,22 @@
> >   * Use the saved FDT address provided by TF-A at boot time (NT_FW_CONFIG =
> >   * Non Trusted Firmware configuration file) when the pointer is valid
> >   */
> > -void *board_fdt_blob_setup(int *err)
> > +int board_fdt_blob_setup(void **fdtp)
> >  {
> >       unsigned long nt_fw_dtb = get_stm32mp_bl2_dtb();
> >
> >       log_debug("%s: nt_fw_dtb=%lx\n", __func__, nt_fw_dtb);
> >
> > -     *err = 0;
> >       /* use external device tree only if address is valid */
> > -     if (nt_fw_dtb >= STM32_DDR_BASE) {
> > -             if (fdt_magic(nt_fw_dtb) == FDT_MAGIC)
> > -                     return (void *)nt_fw_dtb;
> > -             log_debug("%s: DTB not found.\n", __func__);
> > +     if (nt_fw_dtb < STM32_DDR_BASE ||
> > +         fdt_magic(nt_fw_dtb) != FDT_MAGIC) {
> > +             log_debug("DTB not found.\n");
> > +             log_debug("fall back to builtin DTB, %p\n", _end);
> > +
> > +             return -EEXIST;
> >       }
> > -     log_debug("%s: fall back to builtin DTB, %p\n", __func__, _end);
> >
> > -     return (void *)_end;
> > +     *fdtp = (void *)nt_fw_dtb;
> > +
> > +     return 0;
> >  }
>
> For mach-stm32mp:
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Thanks
>

Applied to sjg/master, thanks!
