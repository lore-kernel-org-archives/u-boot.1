Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7366C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B501C876D7;
	Wed,  1 Nov 2023 18:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGEKxpkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFCFB875DC; Wed,  1 Nov 2023 18:11:03 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C90F87CF5
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-457c134a702so6763137.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858658; x=1699463458; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/DVyx7HV1QtHnJQKbe6LRy4VncbddBPWfDdtcBheIM=;
 b=CGEKxpkS+cc9S/1x+O+rxqmgl1R8Y7+pu+Vr5qwd2eJkEo4JUVguBceV4dYxO6w5tf
 jlpCAKugfAuXr4JUR2kogDeCGDJ9EbJDsVrZ5rFYo79hf8rmw9pd63BddZyQXRl7Jj0l
 AcNkTIgoAiZJRxaI181oqraJdUcEtkl2Kn42xXkUoZAmV5QLJ+zh5079Uwd/wZuE8ZKt
 YotlI2RQxFjWRGLog/SG7BT5xww5nbRED8lv/33qVsmrVh/w+kIjDEnR4CiTiMEwOm65
 xnUruORzhIoNx38U9NQf/3SHRcqtGnOyGGKa209WnTuphDOWIdG666nyW+JlOVR7x9xs
 gGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858658; x=1699463458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/DVyx7HV1QtHnJQKbe6LRy4VncbddBPWfDdtcBheIM=;
 b=EGE6VSI/RqYEB3buULXI+pkcqBN0H4PPqeZwB1bEinT3/bUpPL0ajFqKF+VsNI508b
 2BHUSZALmTBPAap1YSpwo+YmfAaGIKoavuLXFXja3sRMNlEQJmKH5fcCW8914ZMdbI+n
 EGBruEUgL+DpSwLgu3fcdxHJu5peVme2kwmoP0A886trVkSgu7swpPCNbpsMuGmFHdPX
 diWhwUFIrqEb5qjxIbvwo6Rgn/D9pl4MbZusvizqdQj3/rOZijphOQG0AdjRf7EV81PD
 CySGQBfpOE865FXxbijszSmB0DkqfpZpqYeEqfGDflDV/kwzYlMUfruSxGF3ac2HBo/L
 8qgA==
X-Gm-Message-State: AOJu0YwE+SF/7HTLRNWYd2E183AWnQ8nDZ4QknEdognY4rO89idtF4Cq
 ZHw0bhxWtkEOzGSFZ1/KWNc=
X-Google-Smtp-Source: AGHT+IFlvUnuSsp0RjozNueg7ItSkpx0jpzbbVQ2lc6wIYn+7vbHuSRFiC1NogWAWIAxfT7fDQYCEg==
X-Received: by 2002:a67:c896:0:b0:458:3bc1:c816 with SMTP id
 v22-20020a67c896000000b004583bc1c816mr11460758vsk.16.1698858658174; 
 Wed, 01 Nov 2023 10:10:58 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 de43-20020a05620a372b00b007788d2f3d4asm1592402qkb.39.2023.11.01.10.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:10:57 -0700 (PDT)
Message-ID: <c1c4205c-edb0-7dd2-3ff0-3be1c6a79104@gmail.com>
Date: Wed, 1 Nov 2023 13:10:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] cmd: clk: Use dump function from clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-7-ivprusov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/17/23 12:56, Igor Prusov wrote:
> Add another loop to dump additional info from clock providers that
> implement dump operation.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index c7c379d7a6..90cc6fa906 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   int __weak soc_clk_dump(void)
>   {
>   	struct udevice *dev;
> +	const struct clk_ops *ops;
>   
>   	printf(" Rate               Usecnt      Name\n");
>   	printf("------------------------------------------\n");
> @@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
>   	uclass_foreach_dev_probe(UCLASS_CLK, dev)
>   		show_clks(dev, -1, 0);
>   
> +	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
> +		ops = dev_get_driver_ops(dev);
> +		if (ops && ops->dump) {
> +			printf("--------------------------\n");
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

So this produces output like

=> clk dump
  Rate               Usecnt      Name
------------------------------------------
  26000000             0        |-- osc
--------------------------
  Rate      Enabled Name
------------------------
  26000000  y       osc
  780000000 y           pll0
  390000000 -               aclk
  390000000 y                   cpu
  390000000 y                   sram0
  390000000 y                   sram1
  7800000   -                   clint
  195000000 y                   apb0
  195000000 y                       gpio
  195000000 y                       uart1
  195000000 y                       uart2
  195000000 y                       uart3
  195000000 y                       fpioa
  195000000 y                       sha
  195000000 y                   apb1
  195000000 y                       aes
  195000000 y                       otp
  195000000 y                   apb2
  195000000 y                   rom
  390000000 y                   dma
  390000000 y                   dvp
  390000000 y                   fft
  390000000 y               spi0
  390000000 y               spi1
  390000000 y               spi2
  97500000  y               spi3
  390000000 y               i2c0
  390000000 y               i2c1
  390000000 y               i2c2
  390000000 y               timer0
  390000000 y               timer1
  390000000 y               timer2
  390000000 y           pll1
  390000000 y               ai
  0         n           pll2
  0         y               i2s0
  0         y               i2s1
  0         y               i2s2
  0         -               i2s0_m
  0         -               i2s1_m
  0         -               i2s2_m
  13000000  y           wdt0
  13000000  n           wdt1
  26000000  n           rtc

And TBH I don't think it's particularly clear (at least at a glance) where
one clock ends and another begins. I think something like

diff --git i/cmd/clk.c w/cmd/clk.c
index f55911db7a3..7bbcbfeda33 100644
--- i/cmd/clk.c
+++ w/cmd/clk.c
@@ -73,7 +73,7 @@ static int soc_clk_dump(void)
         uclass_foreach_dev_probe(UCLASS_CLK, dev) {
                 ops = dev_get_driver_ops(dev);
                 if (ops && ops->dump) {
-                       printf("--------------------------\n");
+                       printf("\n%s %s:\n", dev->driver->name, dev->name);
                         ops->dump(dev);
                 }
         }

would work a lot better. This produces an output like

=> clk dump
  Rate               Usecnt      Name
------------------------------------------
  26000000             0        |-- osc

k210_clk clock-controller:
  Rate      Enabled Name
------------------------
  26000000  y       osc
  780000000 y           pll0
  390000000 -               aclk
  390000000 y                   cpu
  390000000 y                   sram0
  390000000 y                   sram1
</snip>

which I think makes it clearer that we have a new clock tree getting dumped.

This also doesn't really address multiple interacting clock trees (such as
e.g. if I had another clock derived from a k210_clk in the above example)
but at least it's a start.

--Sean
