Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F07D30CC0
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 20:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A0780081;
	Tue, 13 Jan 2026 21:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShFUB+9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14359800AB; Tue, 13 Jan 2026 21:03:23 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03BD80077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 21:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b87113bd83bso476820266b.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768334600; x=1768939400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qyQAkyYvhDfh633dqR0HbmOzyrqbiAeaXVvpEaBxgk4=;
 b=ShFUB+9qdIKDKQ9J2HTyK6iXqwGz7XWnEmmItTp82/Ebs+hdVcjaLgecTpVdF1P+4T
 yZsSmttaJvQmbe+YCiRIbCFR5ST14B63pbxYTA+p4FluoKRlRTcZ6BE0pXgtlIoomRDT
 7NmRs3zAcmhT/KzvtiHs0UScgVMvvlq/pn3ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768334600; x=1768939400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyQAkyYvhDfh633dqR0HbmOzyrqbiAeaXVvpEaBxgk4=;
 b=tnl1F8VEJFC8krxPMWLgGrx/567Wi4F0sOQ+60SAkCk9rGbJtNmvS0z0JNGjeiuOq7
 frWahjFw33unnukBvCBnQ/25Il3+F3ViT8yGWHDD5Oq+8E2PpA4vDpGheKrP24dCi97t
 u/fviEFqI1hWq00naE3BG8Waazdz2oNbZXFXqizYk6qObRCoBf5I/xGEowTS2u2/S8s3
 PoVPLZTl6o3tsh7iA3VhuFEjfN2K8dojOnbliNn9tX43R24OMfExioqo6A7FDPgHpB2i
 A1qdQ5Ik/KvdcaezwdU9SVJgm5kGvAF/n/xFVNjTzs4JJdHa+I7VutU6AZhiwdyu1/oX
 AR8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUs+vXFKcdNFep/fAF5FX5ccKw1OObPxpdw4+dPuEIxVtPZ3XX51FUqpHjyuDq3bWtsfksY5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxFgWLkMSqbRqqpW3GzvjC4RRyORXwPQ6b+IPLZoYJh8f0v+GkF
 R/1SeI/9K5M8EwVPcIfDR94GC51SOaGa2ySlVFK92PxyG/Dq4nYvNo3Ljxsv8CjvRswHR0V8FB3
 e9J5NeoQUzM4HtqrRro3p3fTE3QZXko3mT46cm0jYaHqKMs8nE6I=
X-Gm-Gg: AY/fxX5WzsnIZVJvnDYqxDtz6/S5C4BQrDa8Ix+BsaAcUuNpEAmCGSaufrvmo3iMNMf
 mPpco6+kSZ6iO77Pai3qa8UvEP+MksMhg6VD/PiqCdU6OR9z/LzmJm619VPZ+YxqoREUkkH+lXL
 cQp2VYi4/QmSMEm8GiLb6BCGvQkOtEgxvWsvaSdA4zE9MRCy/kodb2o31zJ5O+Au3iIR+MHwh1/
 8se9rT8dvsYyRjmrwgIorVBY8eH5cq/6kmym9bAx65rRMu69BAct/QzDqQtpvSKpf3Atg==
X-Received: by 2002:a17:907:961c:b0:b86:f81d:66b6 with SMTP id
 a640c23a62f3a-b87613dc1b7mr23909666b.52.1768334599908; Tue, 13 Jan 2026
 12:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20260113012037.2566942-1-sean.anderson@linux.dev>
 <20260113012037.2566942-4-sean.anderson@linux.dev>
In-Reply-To: <20260113012037.2566942-4-sean.anderson@linux.dev>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Jan 2026 13:03:07 -0700
X-Gm-Features: AZwV_QjsJGlNvYnnfSc0TTYiuWsNQYMqs5Gtqn72f_BFzDYw_LKXn_flAuAYjMc
Message-ID: <CAFLszTiAmgPYUGKPc1UGLunkmg9CuisCJkgddi054p_gkdE6wQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: Add power sequencing driver for PCI slots
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, 12 Jan 2026 at 18:21, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> Extend the PCI bridge driver to enable resources associated with PCI
> slots like clocks, power rails, and resets. This is modeled off of the
> PCI power control subsystem in Linux. The traditional compatible for PCI
> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
> pciclass,0604 so add that as an option.
>
> Add a test to make sure the clock/gpio get enabled and that we skip some
> of the delays when PERST is already asserted.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> Changes in v3:
> - Add a test
>
> Changes in v2:
> - Return early if there's no PERST GPIO
> - Only mdelay if we need to
> - Use CONFIG_IS_ENABLED to set .probe directly
>
>  arch/sandbox/dts/test.dts   | 12 ++++++-
>  configs/sandbox64_defconfig |  2 ++
>  configs/sandbox_defconfig   |  2 ++
>  drivers/pci/Kconfig         |  8 +++++
>  drivers/pci/pci-uclass.c    | 65 +++++++++++++++++++++++++++++++++++++
>  test/dm/pci.c               | 57 ++++++++++++++++++++++++++++++++
>  6 files changed, 145 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

At some point we should have a static inline to skip delays on
sandbox, e.g. arch_skip_delays() like we have arch_reset_for_test() -
that would avoid the #include and the #ifdef

>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 962d364f9b2..913dea30fb0 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -632,6 +632,13 @@
>                         clocks = <&clk_fixed>;
>                 };
>
> +               pci_refclk: clk-gpio {
> +                       compatible = "gpio-gate-clock";
> +                       #clock-cells = <0>;
> +                       clocks = <&clk_fixed>;
> +                       enable-gpios = <&gpio_a 26>;
> +               };
> +
>                 osc {
>                         compatible = "fixed-clock";
>                         #clock-cells = <0>;
> @@ -822,7 +829,7 @@
>                         gpio-controller;
>                         #gpio-cells = <1>;
>                         gpio-bank-name = "a";
> -                       sandbox,gpio-count = <25>;
> +                       sandbox,gpio-count = <27>;
>                         gpio-line-names = "", "eth1-reset", "rtc-irq";
>                         hog_input_active_low {
>                                 gpio-hog;
> @@ -1308,6 +1315,9 @@
>                         compatible = "pciclass,0604";
>                         reg = <0x00002000 0 0 0 0>;
>                         ranges;
> +
> +                       clocks = <&pci_refclk>;
> +                       reset-gpios = <&gpio_a 25>;
>                 };
>
>                 pci@1e,0 {
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 440e5efa340..624a44eef59 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -139,6 +139,7 @@ CONFIG_BUTTON_ADC=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_CLK=y
>  CONFIG_CLK_COMPOSITE_CCF=y
> +CONFIG_CLK_GPIO=y
>  CONFIG_CLK_K210=y
>  CONFIG_CLK_K210_SET_RATE=y
>  CONFIG_SANDBOX_CLK_CCF=y
> @@ -201,6 +202,7 @@ CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_NVMXIP_QSPI=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCI_REGION_MULTI_ENTRY=y
> +CONFIG_PCI_PWRCTRL_SLOT=y
>  CONFIG_PCI_SANDBOX=y
>  CONFIG_PHY=y
>  CONFIG_PHY_SANDBOX=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 92fb5f844b1..1403ca1d9d0 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -191,6 +191,7 @@ CONFIG_BUTTON_ADC=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_CLK=y
>  CONFIG_CLK_COMPOSITE_CCF=y
> +CONFIG_CLK_GPIO=y
>  CONFIG_CLK_K210=y
>  CONFIG_CLK_K210_SET_RATE=y
>  CONFIG_SANDBOX_CLK_CCF=y
> @@ -279,6 +280,7 @@ CONFIG_MULTIPLEXER=y
>  CONFIG_MUX_MMIO=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCI_REGION_MULTI_ENTRY=y
> +CONFIG_PCI_PWRCTRL_SLOT=y
>  CONFIG_PCI_FTPCI100=y
>  CONFIG_PCI_SANDBOX=y
>  CONFIG_PHY=y
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index ea9868425d0..efac18b33f6 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -100,6 +100,14 @@ config PCI_ENHANCED_ALLOCATION
>           Enable support for Enhanced Allocation which can be used by supported
>           devices in place of traditional BARS for allocation of resources.
>
> +config PCI_PWRCTRL_SLOT
> +       bool "PCI slot power control"
> +       help
> +         This is a generic driver that controls the power state of different
> +         PCI slots. The clocks and resets for the PCI slots are expected to be
> +         defined in the devicetree node of the PCI bridge. Say N if your PCI
> +         busses don't have software-controlled clocks or power rails.
> +
>  config PCI_ARID
>          bool "Enable Alternate Routing-ID support for PCI"
>          help
> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> index c370f8c6400..6f0e6c2f8cc 100644
> --- a/drivers/pci/pci-uclass.c
> +++ b/drivers/pci/pci-uclass.c
> @@ -6,6 +6,7 @@
>
>  #define LOG_CATEGORY UCLASS_PCI
>
> +#include <clk.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <init.h>
> @@ -14,6 +15,7 @@
>  #include <pci.h>
>  #include <spl.h>
>  #include <asm/global_data.h>
> +#include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <dm/device-internal.h>
>  #include <dm/lists.h>
> @@ -1893,13 +1895,76 @@ static const struct dm_pci_ops pci_bridge_ops = {
>
>  static const struct udevice_id pci_bridge_ids[] = {
>         { .compatible = "pci-bridge" },
> +       { .compatible = "pciclass,0604" },
>         { }
>  };
>
> +#ifdef CONFIG_SANDBOX
> +#include <asm/state.h>
> +#endif
> +
> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
> +{
> +       struct clk clk;
> +       struct gpio_desc perst;
> +       unsigned long delay = 0;
> +       int ret;
> +
> +       if (!clk_get_by_index(dev, 0, &clk)) {
> +               int ret = clk_enable(&clk);
> +
> +               if (ret)
> +                       return log_msg_ret("clk", ret);
> +
> +               /* Delay for T_PERST-CLK (100 us for all slot types) */
> +               udelay(100);
> +       }
> +
> +       if (gpio_request_by_name(dev, "reset-gpios", 0, &perst, 0))
> +               return 0;
> +
> +       /*
> +        * If PERST is inactive, the following call to dm_gpio_clrset_flags
> +        * will be the first time we assert it and we will need to delay for
> +        * T_PERST.
> +        */
> +       if (dm_gpio_get_value(&perst) != 1)
> +               delay = 100;
> +
> +       ret = dm_gpio_clrset_flags(&perst, GPIOD_MASK_DIR,
> +                                  GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +       if (ret)
> +               return log_msg_ret("set", ret);
> +
> +#ifdef CONFIG_SANDBOX
> +       if (!state_get_skip_delays())
> +#endif
> +               if (delay)
> +                       mdelay(delay);
> +
> +       ret = dm_gpio_set_value(&perst, 0);
> +       if (ret)
> +               return log_msg_ret("clr", ret);
> +
> +       /*
> +        * PCIe section 6.6.1:
> +        * > ... software must wait a minimum of 100 ms before sending a
> +        * > Configuration Request to the device immediately below that Port.
> +        */
> +#ifdef CONFIG_SANDBOX
> +       if (!state_get_skip_delays())
> +#endif
> +               mdelay(100);
> +
> +       return 0;
> +}
> +
>  U_BOOT_DRIVER(pci_bridge_drv) = {
>         .name           = "pci_bridge_drv",
>         .id             = UCLASS_PCI,
>         .of_match       = pci_bridge_ids,
> +       .probe          = CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT,
> +                                           (pci_bridge_probe), NULL),
>         .ops            = &pci_bridge_ops,
>  };
>
> diff --git a/test/dm/pci.c b/test/dm/pci.c
> index b6fee7b3bb3..f594783444b 100644
> --- a/test/dm/pci.c
> +++ b/test/dm/pci.c
> @@ -5,6 +5,7 @@
>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> +#include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <asm/test.h>
>  #include <dm/test.h>
> @@ -16,6 +17,7 @@ static int dm_test_pci_base(struct unit_test_state *uts)
>  {
>         struct udevice *bus;
>
> +       test_set_skip_delays(true);
>         ut_assertok(uclass_get_device(UCLASS_PCI, 0, &bus));
>
>         return 0;
> @@ -30,6 +32,7 @@ static int dm_test_pci_busdev(struct unit_test_state *uts)
>         u16 vendor, device;
>
>         /* Test bus#0 and its devices */
> +       test_set_skip_delays(true);
>         ut_assertok(uclass_get_device_by_seq(UCLASS_PCI, 0, &bus));
>
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x00, 0), &swap));
> @@ -65,6 +68,7 @@ static int dm_test_pci_swapcase(struct unit_test_state *uts)
>         char *ptr;
>
>         /* Check that asking for the device 0 automatically fires up PCI */
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x00, 0), &swap));
>
>         /* First test I/O */
> @@ -116,6 +120,7 @@ static int dm_test_pci_drvdata(struct unit_test_state *uts)
>         struct udevice *bus, *swap;
>
>         /* Check that asking for the device automatically fires up PCI */
> +       test_set_skip_delays(true);
>         ut_assertok(uclass_get_device_by_seq(UCLASS_PCI, 1, &bus));
>
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(1, 0x08, 0), &swap));
> @@ -141,6 +146,7 @@ static int dm_test_pci_mixed(struct unit_test_state *uts)
>         ulong io_addr, mem_addr;
>         char *ptr;
>
> +       test_set_skip_delays(true);
>         ut_assertok(uclass_get_device_by_seq(UCLASS_PCI, 2, &bus));
>
>         /* Test the dynamic device */
> @@ -201,6 +207,7 @@ static int dm_test_pci_cap(struct unit_test_state *uts)
>         struct udevice *bus, *swap;
>         int cap;
>
> +       test_set_skip_delays(true);
>         ut_assertok(uclass_get_device_by_seq(UCLASS_PCI, 0, &bus));
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap));
>
> @@ -258,6 +265,7 @@ static int dm_test_pci_ea(struct unit_test_state *uts)
>          * use emulated device mapping function, we're not using real physical
>          * addresses in this test
>          */
> +       test_set_skip_delays(true);
>         sandbox_set_enable_pci_map(true);
>
>         ut_assertok(uclass_get_device_by_seq(UCLASS_PCI, 0, &bus));
> @@ -303,6 +311,7 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
>         ulong io_addr, mem_addr;
>         fdt_addr_t size;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
>         io_addr = dm_pci_read_bar32(swap1f, 0);
>         ut_asserteq(io_addr, dev_read_addr_pci(swap1f, &size));
> @@ -334,6 +343,7 @@ static int dm_test_pci_addr_live(struct unit_test_state *uts)
>         struct udevice *swap1f, *swap1;
>         fdt_size_t size;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
>         ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f, &size));
>         ut_asserteq(0, size);
> @@ -351,6 +361,7 @@ static int dm_test_pci_on_bus(struct unit_test_state *uts)
>  {
>         struct udevice *dev;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &dev));
>         ut_asserteq(true, device_is_on_pci_bus(dev));

ut_assert(device_is_on_pci_bus(dev));

>         ut_asserteq(false, device_is_on_pci_bus(dev_get_parent(dev)));

ut_assert(!...)

> @@ -374,6 +385,7 @@ static int dm_test_pci_region_multi(struct unit_test_state *uts)
>         ulong mem_addr;
>
>         /* Test memory BAR1 on bus#1 */
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(1, 0x08, 0), &dev));
>         mem_addr = dm_pci_read_bar32(dev, 1);
>         ut_asserteq(mem_addr, 0x30000000);
> @@ -393,6 +405,7 @@ static int dm_test_pci_bus_to_phys(struct unit_test_state *uts)
>         struct udevice *dev;
>         phys_addr_t phys_addr;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(1, 0x08, 0), &dev));
>
>         /* Before any of the ranges. */
> @@ -446,6 +459,7 @@ static int dm_test_pci_phys_to_bus(struct unit_test_state *uts)
>         struct udevice *dev;
>         pci_addr_t pci_addr;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(1, 0x08, 0), &dev));
>
>         /* Before any of the ranges. */
> @@ -620,6 +634,7 @@ static int dm_test_pci_bridge_windows(struct unit_test_state *uts)
>  {
>         struct udevice *bus;
>
> +       test_set_skip_delays(true);
>         ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x03, 0), &bus));
>         if (_dm_test_pci_bridge_windows(uts, bus))
>                 return CMD_RET_FAILURE;
> @@ -628,3 +643,45 @@ static int dm_test_pci_bridge_windows(struct unit_test_state *uts)
>         return _dm_test_pci_bridge_windows(uts, bus);
>  }
>  DM_TEST(dm_test_pci_bridge_windows, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL_SLOT)
> +/* GPIO 25 is PERST; GPIO 26 is REFCLK enable */
> +static int dm_test_pci_pwrseq_cold(struct unit_test_state *uts)
> +{
> +       struct udevice *bus, *gpio;
> +       unsigned long start, end;
> +
> +       ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio));
> +       ut_assertok(sandbox_gpio_set_value(gpio, 25, 1));
> +
> +       start = timer_get_us();
> +       ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x04, 0), &bus));
> +       end = timer_get_us();
> +       ut_assert(end - start > 100000);
> +       ut_assert(end - start < 200000);

We do have get_timer_us() so another option is:

start = get_timer_us(0);
ut_assert(get_timer_us(start) > 100000);

> +
> +       ut_asserteq(0, sandbox_gpio_get_value(gpio, 25));
> +       ut_asserteq(1, sandbox_gpio_get_value(gpio, 26));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_pci_pwrseq_cold, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
> +static int dm_test_pci_pwrseq_warm(struct unit_test_state *uts)
> +{
> +       struct udevice *bus, *gpio;
> +       unsigned long start;
> +
> +       ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio));
> +
> +       start = timer_get_us();
> +       ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x04, 0), &bus));
> +       ut_assert(timer_get_us() - start > 200000);
> +
> +       ut_asserteq(0, sandbox_gpio_get_value(gpio, 25));
> +       ut_asserteq(1, sandbox_gpio_get_value(gpio, 26));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_pci_pwrseq_warm, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +#endif
> --
> 2.35.1.1320.gc452695387.dirty
>

Regards,
Simon
