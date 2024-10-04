Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C2DCFA74D
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 07:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E0589034;
	Fri,  4 Oct 2024 09:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lIDcFUg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B321B89034; Fri,  4 Oct 2024 09:13:51 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FFCC8901F
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7db0fb03df5so1254129a12.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728026026; x=1728630826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Btow0UA2duOZfu0a1UxtSIGZRnGH/UoIxFK5Nz1iP2g=;
 b=lIDcFUg/Pmb1u4Dp3t7C4fCdeBph+tTlcpuTkFZ1yhm9Dhr8MZr/RLXP6xhtMNsx3B
 BvtePVwXd33DlcHFfRi8Qt10ozt2HJxmMnIVVB3HD033qgDUzZfnU7Rva3biL7szeh2x
 iiuhHsOI7FsCGMNvQTfeaSt97z1eBuFg7jBPFZyxkMmqXvrRQu+endiEeXzV7+lX+TPY
 EbqvWCiwyD+iApy1Zky9mVKMO+AYJLzOxvmEQGtu6Ec5Cc2liM4NYc2F4SMkSYp1Rda/
 cc6S4mfocYdOnkmYTsxW+uPDFRu64YTVA5/Rn+iXvYhimRxD+JJuRMo9sp1OpxXwR3Cs
 re4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728026026; x=1728630826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Btow0UA2duOZfu0a1UxtSIGZRnGH/UoIxFK5Nz1iP2g=;
 b=CI4jh1B5mRX8yFGnONK2Z1jusLZ67uGNS/lyA5UOsrx4ELGpCw2ZdYwYfjBIzpej2I
 6NR0sXUhawIPaJa3O+YYi6zYrRFPC3lEbiWOEWT9yDnJjfkmP5t7FqBhJZH53qviyyXj
 Al05/7UE6PrnunIhT+HyNM117MNGgwFhNS/bSENm9zAKEr/RVho51QHcqcw+xUNxvMPk
 V/1AhHnhOLSRYlS15IdZwZdELY9cIwFG+U4py0Ca7+0sdC2SaUNXH72hyxewT6VpXGfL
 BPcSaFDFnU4HzDHFr0KxqW6EnyRcJW1eAxR5JqtKunQ/oTY9rQbFFOZf8poIdZf+8f/t
 NRMw==
X-Gm-Message-State: AOJu0Yy5bp4CFn0K6al4Hn/naOZJjCIgQ9YMzoQ8F8ziQcAooiqIANO4
 4dSVLJNPdXIPMbC5rDybm9Dcb4R+KM6qRVuAvnnat8sVzabCUykbed5kmmLBSfkVyfVdPIR3/6X
 EbpQPA/O9+py/zXsP7j3wWy6HOvLkYoof3m3IEw==
X-Google-Smtp-Source: AGHT+IFyQl8E9QFammSZu7PhJ4I+k3hAtNKrm6aNFt26XVJRnA4L3F7l+DAyV7olZ5gBeH0Eiuh/VM+DLblBVR92HgE=
X-Received: by 2002:a05:6a20:c68e:b0:1d3:b30:44a2 with SMTP id
 adf61e73a8af0-1d6dfa25a50mr3436043637.7.1728026025754; Fri, 04 Oct 2024
 00:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1cc1dda87239c68cfa30430f08911b78cf4c69fd.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <1cc1dda87239c68cfa30430f08911b78cf4c69fd.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 10:13:09 +0300
Message-ID: <CAC_iWj+9XQ9q4GNrBjRPCvGHC_M9zhjYRhzyAGSn+aRG1FpLLQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/29] sandbox: add dummy driver ETH_SANDBOX_LWIP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yang Xiwen <forbidden405@outlook.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philip Oberfichtner <pro@denx.de>, Boon Khai Ng <boon.khai.ng@intel.com>, 
 Robert Marko <robert.marko@sartura.hr>, Jonas Karlman <jonas@kwiboo.se>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
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

On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Introduce ETH_SANDBOX_LWIP which enables a mock driver similar to
> ETH_SANDOX but without the dependencies on the legacy network stack
> (NET) so that it may be enabled when the lwIP stack (NET_LWIP) is
> introduced. The driver does nothing at this stage but its presence
> will allow dm_test_iommu_noiommu [1] to pass.
>
> [1] ./u-boot -T -c "ut dm dm_test_iommu_noiommu"
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/Kconfig        | 11 +++++
>  drivers/net/Makefile       |  1 +
>  drivers/net/sandbox-lwip.c | 85 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 drivers/net/sandbox-lwip.c
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index e7d0ddfe25a..2f39ec05ac7 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -350,6 +350,17 @@ config ETH_SANDBOX
>
>           This driver is particularly useful in the test/dm/eth.c tests
>
> +config ETH_SANDBOX_LWIP
> +       depends on SANDBOX
> +       depends on NET_LWIP
> +       default y
> +       bool "Sandbox: Mocked Ethernet driver (for NET_LWIP)"
> +       help
> +         This driver is meant as a replacement for ETH_SANDBOX when
> +         the network stack is NET_LWIP rather than NET. It currently
> +         does nothing, i.e. it drops the sent packets and never receives
> +         data.
> +
>  config ETH_SANDBOX_RAW
>         depends on SANDBOX
>         default y
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 4946a63f80f..f5ab1f5dedf 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_ETH_DESIGNWARE_SOCFPGA) += dwmac_socfpga.o
>  obj-$(CONFIG_ETH_SANDBOX) += sandbox.o
>  obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw-bus.o
>  obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw.o
> +obj-$(CONFIG_ETH_SANDBOX_LWIP) += sandbox-lwip.o
>  obj-$(CONFIG_FEC_MXC) += fec_mxc.o
>  obj-$(CONFIG_FMAN_ENET) += fm/
>  obj-$(CONFIG_FMAN_ENET) += fsl_mdio.o
> diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
> new file mode 100644
> index 00000000000..3721033c310
> --- /dev/null
> +++ b/drivers/net/sandbox-lwip.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015 National Instruments
> + *
> + * (C) Copyright 2015
> + * Joe Hershberger <joe.hershberger@ni.com>
> + */
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <net.h>
> +#include <asm/eth.h>
> +#include <asm/global_data.h>
> +#include <asm/test.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int sb_lwip_eth_start(struct udevice *dev)
> +{
> +       debug("eth_sandbox_lwip: Start\n");
> +
> +       return 0;
> +}
> +
> +static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
> +{
> +       debug("eth_sandbox_lwip: Send packet %d\n", length);
> +
> +       return -ENOTSUPP;
> +}
> +
> +static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
> +{
> +       return -EAGAIN;
> +}
> +
> +static int sb_lwip_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
> +{
> +       return 0;
> +}
> +
> +static void sb_lwip_eth_stop(struct udevice *dev)
> +{
> +}
> +
> +static int sb_lwip_eth_write_hwaddr(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static const struct eth_ops sb_eth_ops = {
> +       .start                  = sb_lwip_eth_start,
> +       .send                   = sb_lwip_eth_send,
> +       .recv                   = sb_lwip_eth_recv,
> +       .free_pkt               = sb_lwip_eth_free_pkt,
> +       .stop                   = sb_lwip_eth_stop,
> +       .write_hwaddr           = sb_lwip_eth_write_hwaddr,
> +};
> +
> +static int sb_lwip_eth_remove(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static int sb_lwip_eth_of_to_plat(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static const struct udevice_id sb_eth_ids[] = {
> +       { .compatible = "sandbox,eth" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(eth_sandbox) = {
> +       .name   = "eth_lwip_sandbox",
> +       .id     = UCLASS_ETH,
> +       .of_match = sb_eth_ids,
> +       .of_to_plat = sb_lwip_eth_of_to_plat,
> +       .remove = sb_lwip_eth_remove,
> +       .ops    = &sb_eth_ops,
> +       .priv_auto      = 0,
> +       .plat_auto      = sizeof(struct eth_pdata),
> +};
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
