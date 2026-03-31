Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364DE10F9304
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 21:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9FC84020;
	Tue, 31 Mar 2026 23:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pSKoe47Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1B184035; Tue, 31 Mar 2026 23:33:21 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D3583F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 23:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66d65646c65so705157a12.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 14:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992799; cv=none;
 d=google.com; s=arc-20240605;
 b=e8GPH8x+e/V2QCZRRlVnaVFyHd7R0sqEQFMx5T9JAWmdTxZ6e3nboGxnIqcGx30MXn
 lMA8F/Y0ZDYcXoxdBYTPe2Uhk8d/bPczMkXNappdQ5peFcAbGU6xBl3T/QYY0h2nDRrz
 CUsoFO7ma6o6zzgVnkWdXaAWce4W2cw9NqN7+osycIa8CR/Eggj4r3+zaNpfB8Oq7ta3
 4HRZyT2BlX3uxNLujZvjBXJBiVEAkZrUlI+vZM83OsyO7zlhxxaopfQ9z+DB3lAXbuVh
 AJpItUpPmqEpSgNgw7nqu6uTBHarTBnb9CSsCfhw2wMrtiWq6u2G2bDDijRFKq8ssgn1
 isSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Y4QIRGv3tOqJSWLeC3gnhrjorDmgyjnb9ELE2YcPdI=;
 fh=16cYdFODRNnwBkQ7u7RvpUZ+s4uHsvcSvsV3ZCVmlXw=;
 b=CZkjNbakEfJBFxheD8pQ58jRoVH/dBAz1vG04dZrpACsTGqkr8Xcd+s1PP641MD7lq
 T1rRdXkPx2vJi/jIk717WZj1ZRw9pTsYxyT1VWBWkg0IQpaasLxkGVRsUrMATcq8j0tZ
 KSw3COWiYMC8N0ItJfYj+1pTlfh6awpxx7bQ20EUDPPodakuwHNSaHh6qJ6vyIiBMK4v
 q5xmWEiRaEPBxxCyy23TP1obPAgqqpjKE5lCTXMfJUrdolFcW5YtrnIWuMGPBGi2B6nA
 vdHPpz/3e+/SLDv+RhOnZ+Dn78U6B4oeQhkTM1vkDkIUh6gtj0gMHE5av3Yk/RLNpe7y
 oU7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774992799; x=1775597599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Y4QIRGv3tOqJSWLeC3gnhrjorDmgyjnb9ELE2YcPdI=;
 b=pSKoe47Y0RQ9GFo0+GAsHm6OjLDa+8jjPPYNpYECQpk6PHeMF324n3NdX3iBv2Qd5D
 mVr3p6wA7GYhVObqD+vM3Ysk39Iq6gfuinCy2H8snEf7aNduNH0zRJj3XIjrzPE/NWeB
 Weg9iMmbdGyTP6qS8IDs/iL9drfM34Ir9QLSiJ2CMTQeVN84A3ZGfRbub0MPZZxAgfFf
 GjRAZ0+vJ8reGatU4mB/QN7LfzgbRULxbB5DcD1KYZPQKlr+/ZBznu3iIctVyf7UZ3Zs
 6BG7K9q5sUOXkKIMbRJpiaJk/omsmQB0BQ+4XY+IcBBSb+WKQkoH81jB99w8SinVn5Ai
 JiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774992799; x=1775597599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Y4QIRGv3tOqJSWLeC3gnhrjorDmgyjnb9ELE2YcPdI=;
 b=P/vIF0p68dJcARSFjLe93fvQuxVLbigOtEpnEKTuygE99LJKl2Hh5mhrD36Sw4zm+B
 UDqZRNmSwQWjs81tCi9VA+K+I6wFwkaf0+ek+mVMlpZEwd1epLo0gF3pHLaUPtXlKaX3
 B+uwHoZP4xeveYK0mIcXsILi1U4Bfvjl395F1nRr7RXpTHMifazYk+sCTbwIeqHdsJMh
 eP0Sizk6FArjfGsG7QIUhNAvE8937eacSuJClj0cGt1M0yw80zCEnbYhc5q6sByBED1V
 0afAZhAnWCwJFm9XKNUrx7wRKMN6UviY5IYQcYaf1czCUBZXtA0LDgK7E0/KTq1K5dvz
 1B3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjCNRA5MbrK5rzmyb7V/9n/Nkk8Yxroi9M6NqlsvxHYNPuJxVaD14G0NfAKOBzPYCXJUkrRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyAZD2YQYpTejNqe1qfNBXrDdZyLPD/XxdOz5hmcEbpbK4Qq0gh
 oQPDyhj1g0wwXKASI+CK2H1jn7ulXSAeOWo/2Mg2lY8Fm+I9G1W5CzTIj4XBsmLQ6ei8dceLxDA
 0QZlEJHNzDCK9vzxfFyb9tBza48QjRx4=
X-Gm-Gg: ATEYQzwAdPfXW1Ty0pBZUU75aCTBF98ForGlZoSDma8SkCX+1w4k3TBWn/2ARzmNZ6b
 lSTe7Q1UP/hmCrrH9SDYWGT6Ai7FG/0KP7DinMI5sFjguGMQyVV152ndfBYK3aUNLA40rRNH5jt
 pb4AY+GSXeAgIWt/+Tn/9pGwlBhcaufMLvjKeHzYS5cRVq07W9LlRsSk9smI3XQeh8VY2LqGSwK
 Oowwz2WrF/yWX30l+CoTsYjc3Z9LIYn+gD0pqY5F6PWqPPQinIE8eNfI89AUEu04T6KXetFowAH
 C6mwoUceWw38/oV7wD4QiFh9l0f2qsvgCb9g/UtEF4y9zr6A4Gd1mAtARYxqPwGrLOwHu/1ADyH
 pa/H/2LXRmxzcXbnkhEKHRAJl3Rb4qPLs9ZX8u8uKcdr7zeEgoVN9k8y+E8Rs2HljuG/R6ewNR/
 oSJA1EHacULMs=
X-Received: by 2002:aa7:c896:0:b0:66c:191e:3802 with SMTP id
 4fb4d7f45d1cf-66c3388f0b5mr1919307a12.16.1774992798626; Tue, 31 Mar 2026
 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260227152046.42DE068B05@verein.lst.de>
 <20260227152348.BFF2568BFE@verein.lst.de>
In-Reply-To: <20260227152348.BFF2568BFE@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 31 Mar 2026 22:33:07 +0100
X-Gm-Features: AQROBzCKxoeAH-wp3zlHuVZd1HvMGvmcaltL-6mAEI41pM4sQc-QR3n4w1yeN-Y
Message-ID: <CALeDE9M24UYMJYrFE=Fa7J5tmoo1tQadrnZJ6-zcjz0iqHzmXw@mail.gmail.com>
Subject: Re: [PATCH 8/9] pci: brcmstb: rework iBAR handling
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
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

Hi Torsten,

> Rework the setup of inbound PCIe windows: use the convenience functions
> from Linux kernel commit ae6476c6de187 to calculate the BAR offsets and
> factor out the setup code into a separate function.
>
> The Linux kernel first allocates and populates an array of inbound_win[]
> and sets the BARs from it later, while U-Boot does it all on the fly,
> in one go, so the code is not 1:1 comparable.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>

So in testing I've found this is causing a regression on RPi4 USB, in
particular with booting from USB storage, at least on my "Raspberry Pi
4 Model B Rev 1.1" and a RPi400.

The USB works fine up to the prior patch.

2026.04-rc5 with a USB drive I get this output:

PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
starting USB...
USB DWC2
USB XHCI 1.00
Bus usb@7e980000: 1 USB Device(s) found
Bus xhci_pci: 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

2026.04-rc5 + your patches up to and including the iBar patch with a
USB drive I get this output:

PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
starting USB...
USB DWC2
Bus xhci_pci: Port not available.
Bus usb@7e980000: 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

Let me know if there's anything I can help testing with.

Cheers,
Peter




> ---
>  drivers/pci/pcie_brcmstb.c | 107 ++++++++++++++++++++++++++++++-------
>  1 file changed, 88 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 8a25fb04563..e5c848c9e8e 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -50,6 +50,29 @@
>  #define SSC_STATUS_PLL_LOCK_MASK                       0x800
>  #define SSC_STATUS_PLL_LOCK_SHIFT                      11
>
> +#define PCIE_RC_PL_PHY_CTL_15                          0x184c
> +#define PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK          0x400000
> +#define PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK       0xff
> +
> +#define PCIE_MISC_UBUS_CTRL                            0x40a4
> +#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK      BIT(13)
> +#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK   BIT(19)
> +#define PCIE_MISC_AXI_READ_ERROR_DATA                  0x4170
> +#define PCIE_MISC_UBUS_TIMEOUT                         0x40A8
> +#define PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT              0x405c
> +#define PCIE_MISC_RC_BAR4_CONFIG_LO                    0x40d4
> +#define PCIE_MISC_RC_BAR4_CONFIG_HI                    0x40d8
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK                0xff
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI            0x4110
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE         0x1
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK                0xfffff000
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO            0x410c
> +
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP               0x40ac
> +#define PCIE_MISC_UBUS_BAR2_CONFIG_REMAP               0x40b4
> +#define  PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK   BIT(0)
> +#define  MISC_CTRL_PCIE_RCB_MPS_MODE_MASK              0x400
> +
>  enum {
>         RGR1_SW_INIT_1,
>         EXT_CFG_INDEX,
> @@ -437,17 +460,75 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
>         writel(tmp, base + PCIE_MEM_WIN0_LIMIT_HI(win));
>  }
>
> +static u32 brcm_bar_reg_offset(int bar)
> +{
> +       if (bar <= 3)
> +               return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
> +       else
> +               return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
> +}
> +
> +static u32 brcm_ubus_reg_offset(int bar)
> +{
> +       if (bar <= 3)
> +               return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
> +       else
> +               return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO + 8 * (bar - 4);
> +}
> +
> +static void brcm_pcie_set_inbound_windows(struct udevice *dev)
> +{
> +       struct brcm_pcie *pcie = dev_get_priv(dev);
> +       void __iomem *base = pcie->base;
> +       int i, ibar_no, ret;
> +       u32 tmp;
> +
> +       ibar_no = 0;
> +       /* pre-2712 chips leave the first entry empty */
> +       if (pcie->pcie_cfg->type != BCM2712)
> +               ibar_no++;
> +
> +       /* program inbound windows from OF property "dma-regions" */
> +       for (i = 0; i < 7; i++, ibar_no++) {
> +               u64 bar_cpu, bar_size, bar_pci;
> +               struct pci_region region;
> +               int ubus_bar_offset, rc_bar_offset;
> +
> +               ret = pci_get_dma_regions(dev, &region, i);
> +               if (ret)        /* no region #i? Then we're done. */
> +                       break;
> +               ubus_bar_offset = brcm_ubus_reg_offset(ibar_no + 1);
> +               rc_bar_offset = brcm_bar_reg_offset(ibar_no + 1);
> +
> +               bar_pci = region.bus_start;
> +               bar_cpu = region.phys_start;
> +               bar_size = region.size;
> +
> +               tmp = lower_32_bits(bar_pci);
> +               u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size),
> +                                 RC_BAR2_CONFIG_LO_SIZE_MASK);
> +               writel(tmp, base + rc_bar_offset);
> +               writel(upper_32_bits(bar_pci), base + rc_bar_offset + 4);
> +
> +               tmp = lower_32_bits(bar_cpu) &
> +                               PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK;
> +               tmp |= PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE;
> +               writel(tmp, base + ubus_bar_offset);
> +
> +               tmp = upper_32_bits(bar_cpu) &
> +                       PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK;
> +               writel(tmp, base + ubus_bar_offset + 4);
> +       }
> +}
> +
>  static int brcm_pcie_probe(struct udevice *dev)
>  {
>         struct udevice *ctlr = pci_get_controller(dev);
>         struct pci_controller *hose = dev_get_uclass_priv(ctlr);
>         struct brcm_pcie *pcie = dev_get_priv(dev);
>         void __iomem *base = pcie->base;
> -       struct pci_region region;
>         bool ssc_good = false;
>         int num_out_wins = 0;
> -       u64 rc_bar2_offset, rc_bar2_size;
> -       unsigned int scb_size_val;
>         int i, ret;
>         u16 nlw, cls, lnksta;
>         u32 tmp;
> @@ -488,23 +569,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>                         MISC_CTRL_CFG_READ_UR_MODE_MASK |
>                         MISC_CTRL_MAX_BURST_SIZE_128);
>
> -       pci_get_dma_regions(dev, &region, 0);
> -       rc_bar2_offset = region.bus_start - region.phys_start;
> -       rc_bar2_size = 1ULL << fls64(region.size - 1);
> -
> -       tmp = lower_32_bits(rc_bar2_offset);
> -       u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> -                         RC_BAR2_CONFIG_LO_SIZE_MASK);
> -       writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> -       writel(upper_32_bits(rc_bar2_offset),
> -              base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> -
> -       scb_size_val = rc_bar2_size ?
> -                      ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> -
> +       /* Enable 32GB memory to be accessed from PCIe in the SCB0 */
>         tmp = readl(base + PCIE_MISC_MISC_CTRL);
> -       u32p_replace_bits(&tmp, scb_size_val,
> -                         MISC_CTRL_SCB0_SIZE_MASK);
> +       u32p_replace_bits(&tmp, 20, MISC_CTRL_SCB0_SIZE_MASK);
>         writel(tmp, base + PCIE_MISC_MISC_CTRL);
>
>         /* Disable the PCIe->GISB memory window (RC_BAR1) */
> @@ -521,6 +588,8 @@ static int brcm_pcie_probe(struct udevice *dev)
>         /* Clear any interrupts we find on boot */
>         writel(0xffffffff, base + PCIE_MSI_INTR2_CLR);
>
> +       brcm_pcie_set_inbound_windows(dev);
> +
>         if (pcie->gen)
>                 brcm_pcie_set_gen(pcie, pcie->gen);
>
> --
> 2.51.0
>
