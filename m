Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E10AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EE787578;
	Tue, 31 Oct 2023 07:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC67879D3; Tue, 31 Oct 2023 07:47:49 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B6687571
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39V6lc8B098791;
 Tue, 31 Oct 2023 14:47:38 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 31 Oct 2023 14:47:34 +0800
Date: Tue, 31 Oct 2023 14:43:52 +0800
From: Leo Liang <ycliang@andestech.com>
To: merle w <merlew4n6@gmail.com>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, Anup Patel
 <apatel@ventanamicro.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 "Chanho Park" <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
Subject: Re: [RFC v2 2/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <ZUCiKNIAc68zPTty@swlinux02>
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
 <CAJ8bkywF8v+JA8D=di=agqmvdsUdrmUvhyeb16_4dDr07A0ejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ8bkywF8v+JA8D=di=agqmvdsUdrmUvhyeb16_4dDr07A0ejg@mail.gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39V6lc8B098791
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

Hi Xiang,
On Tue, Oct 31, 2023 at 02:16:22PM +0800, merle w wrote:
> drivers/rng/riscv_zkr_rng.c:10:10: fatal error: interrupt.h: No such
> file or directory
> 10 | #include <interrupt.h>
> | ^~~~~~~~~~~~~
> compilation terminated.
> 
> Where is this interrupt.h?

I think this file is created by the first patch of this patchset.
"[RFC,v2,1/2] riscv: allow resume after exception"

Could you try to apply this patch and then test again?
It should compile without error.

Best regards,
Leo

> 
> Regards,
> Xiang W
> 
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> 于2023年10月29日周日 16:46写道：
> >
> > The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > provides an interface to a physical entropy source.
> >
> > A RNG driver based on the seed CSR is provided. It depends on
> > mseccfg.sseed being set in the SBI firmware.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         Resume after exception if seed CSR cannot be read.
> > ---
> >  drivers/rng/Kconfig         |   8 +++
> >  drivers/rng/Makefile        |   1 +
> >  drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 125 insertions(+)
> >  create mode 100644 drivers/rng/riscv_zkr_rng.c
> >
> > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > index 994cc35b27..4f6e367169 100644
> > --- a/drivers/rng/Kconfig
> > +++ b/drivers/rng/Kconfig
> > @@ -48,6 +48,14 @@ config RNG_OPTEE
> >           accessible to normal world but reserved and used by the OP-TEE
> >           to avoid the weakness of a software PRNG.
> >
> > +config RNG_RISCV_ZKR
> > +       bool "RISC-V Zkr random number generator"
> > +       depends on RISCV_SMODE
> > +       help
> > +         This driver provides a Random Number Generator based on the
> > +         Zkr RISC-V ISA extension which provides an interface to an
> > +         NIST SP 800-90B or BSI AIS-31 compliant physical entropy source.
> > +
> >  config RNG_STM32
> >         bool "Enable random number generator for STM32"
> >         depends on ARCH_STM32 || ARCH_STM32MP
> > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > index 47b323e61e..a5d3ca4130 100644
> > --- a/drivers/rng/Makefile
> > +++ b/drivers/rng/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_RNG_MSM) += msm_rng.o
> >  obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
> >  obj-$(CONFIG_RNG_OPTEE) += optee_rng.o
> >  obj-$(CONFIG_RNG_STM32) += stm32_rng.o
> > +obj-$(CONFIG_RNG_RISCV_ZKR) += riscv_zkr_rng.o
> >  obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
> >  obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
> >  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> > diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
> > new file mode 100644
> > index 0000000000..8c9e111e2e
> > --- /dev/null
> > +++ b/drivers/rng/riscv_zkr_rng.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * The RISC-V Zkr extension provides CSR seed which provides access to a
> > + * random number generator.
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_RNG
> > +
> > +#include <dm.h>
> > +#include <interrupt.h>
> > +#include <log.h>
> > +#include <rng.h>
> > +
> > +#define DRIVER_NAME "riscv_zkr"
> > +
> > +enum opst {
> > +       /** @BIST: built in self test running */
> > +       BIST = 0b00,
> > +       /** @WAIT: sufficient amount of entropy is not yet available */
> > +       WAIT = 0b01,
> > +       /** @ES16: 16bits of entropy available */
> > +       ES16 = 0b10,
> > +       /** @DEAD: unrecoverable self-test error */
> > +       DEAD = 0b11,
> > +};
> > +
> > +static unsigned long read_seed(void)
> > +{
> > +       unsigned long ret;
> > +
> > +       __asm__ __volatile__("csrrw %0, seed, x0" : "=r" (ret) : : "memory");
> > +
> > +       return ret;
> > +}
> > +
> > +static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
> > +{
> > +       u8 *ptr = data;
> > +
> > +       while (len) {
> > +               u32 val;
> > +
> > +               val = read_seed();
> > +
> > +               switch (val >> 30) {
> > +               case BIST:
> > +                       continue;
> > +               case WAIT:
> > +                       continue;
> > +               case ES16:
> > +                       *ptr++ = val & 0xff;
> > +                       if (--len) {
> > +                               *ptr++ = val >> 8;
> > +                               --len;
> > +                       }
> > +                       break;
> > +               case DEAD:
> > +                       return -ENODEV;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * riscv_zkr_probe() - check if the seed register is available
> > + *
> > + * If the SBI software has not set mseccfg.sseed=1 or the Zkr
> > + * extension is not available this probe function will result
> > + * in an exception. Currently we cannot recover from this.
> > + *
> > + * @dev:       RNG device
> > + * Return:     0 if successfully probed
> > + */
> > +static int riscv_zkr_probe(struct udevice *dev)
> > +{
> > +       struct resume_data resume;
> > +       int ret;
> > +       u32 val;
> > +
> > +       /* Check if reading seed leads to interrupt */
> > +       set_resume(&resume);
> > +       ret = setjmp(resume.jump);
> > +       if (ret)
> > +               log_debug("Exception %ld reading seed CSR\n", resume.code);
> > +       else
> > +               val = read_seed();
> > +       set_resume(NULL);
> > +       if (ret)
> > +               return -ENODEV;
> > +
> > +       do {
> > +               val = read_seed();
> > +               val >>= 30;
> > +       } while (val == BIST || val == WAIT);
> > +
> > +       if (val == DEAD)
> > +               return -ENODEV;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dm_rng_ops riscv_zkr_ops = {
> > +       .read = riscv_zkr_read,
> > +};
> > +
> > +U_BOOT_DRIVER(riscv_zkr) = {
> > +       .name = DRIVER_NAME,
> > +       .id = UCLASS_RNG,
> > +       .ops = &riscv_zkr_ops,
> > +       .probe = riscv_zkr_probe,
> > +};
> > +
> > +U_BOOT_DRVINFO(cpu_riscv_zkr) = {
> > +       .name = DRIVER_NAME,
> > +};
> > --
> > 2.40.1
> >
