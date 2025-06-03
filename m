Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65820C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A940682AA7;
	Tue,  3 Jun 2025 18:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Lk6Yh9ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7ED582AAA; Tue,  3 Jun 2025 18:06:48 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8733D82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad51ef2424bso1113048666b.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1748966806; x=1749571606;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ct4FxFzzPHpAI9LG6njc3kcBmDVJbpSAeFh/sAtvSto=;
 b=Lk6Yh9kyJ30+4Pf7TxM6XoEm9ihq8H6jSP9GjOhEtDEmTdectuLnDhA9nzXOqMVGlb
 ls0/3ZHChdLkHoLBS057jdX9gX/mtjP20ODwVAX/NxNEaa8NY16iFba37BOmRLz2DF6O
 KIwGSN/UUd03iOQ1J5wS29ILfmhWDVFZI9Cdlq993uu+iSUW1DgdMlFXszoTSXViG8ll
 kQfPhzQFZUWXT/a8WOdy125w5fp5azTQ2cGYwecb3Ij+9g8gL5cyiD2J1GVx6DQvnqWU
 pX+npqzdk5tmNnIjYeYcWmMG2ATcLn55NhK2zpKdqr6yAw5REHf1QvqSD+CIKxcitsNq
 vh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748966806; x=1749571606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct4FxFzzPHpAI9LG6njc3kcBmDVJbpSAeFh/sAtvSto=;
 b=kTtwjtFVIgD1k2ykp7tASaPxUlnRKNneXwbs6czt8X4412cTG9Xa5XlGOesmPyJKjC
 jmhM5z9GM7dUtdCqCvsZRoT6Z7U6M8mK7Z3eraoe7TNSqgs8c0neJQyYQXy/8rEghe6E
 +EWZ4eE7FncWGyivV27qkV0vgGPbnULc8DEHNSDslZPUO85D5afvAFAOjyC/x3XrRgk9
 0GK0vBtkT1RTP3vK+GSFApBOzQdROWHABVVSOJxZTeaUVv3TO7NbhquFIGuHntLkONg5
 PTgkP5xfZbgai5EU0lESwdWiQSvkajhpuaZIka1BHea5JHo1Q9ETKkDtA4VLHzq3/l3/
 bJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn2MZ12tS953dDBuSHfzItabqHb8IkRTBH07nldv6v28Ab/lyxVvFWSkR3JJTit/hoBx3jSo8=@lists.denx.de
X-Gm-Message-State: AOJu0YxxqX5VVvLFh2cR0UD8As4imuQ3yZ82TOvCgKcMS4H40MC4qB9X
 GjkN/deQRkPyYloibD95EWcEzaDWRM36T5YKIHnsp1iDTPaQe7byAcbSBZN8IC2sUQ==
X-Gm-Gg: ASbGncvC3SzSKwjnE3X37VXcdySXUBitPxsWabAwPZ1Rux/alOBlgZZs98bKmRicCMX
 2T/EMCsrzBdvBwPEQB8E6DSLVio+anopfZkZ9Z7aP5Q/PTZL4LeH7CswwB+bBz6e39WPxlnU0Wf
 34sQ374OYF1yESG4k0OybAzN6/j1Y8zYOVpkZxYKxwxlmjzxXW929TXin9mOVk41msIdcHlBOLb
 dHXw+p0VRm/qnijVwJwl8g5vFNQkSUYpmrqcjRFuIGKfYhWP6avTi9A2adnh2ab9ACmnl8Shswz
 kkFuKjkxhiaMB2esGMuZYEUMxP/ZSPlFXg6K1eGr96sdZWLTdKDM6/BfJGceGihP
X-Google-Smtp-Source: AGHT+IGGkxQY4tSAjD5uWSkzI+TYcWxL5N8TjtHxp4/L3TPVW5JFsERmOgVdnEOwt1qE6rxUMes9oQ==
X-Received: by 2002:a17:907:72ce:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-adb4960fa6cmr1270289566b.58.1748966805504; 
 Tue, 03 Jun 2025 09:06:45 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3d7ebsm969962266b.159.2025.06.03.09.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:06:45 -0700 (PDT)
Message-ID: <79190e2c-4a6d-4a7f-967d-1d316ca4d733@monstr.eu>
Date: Tue, 3 Jun 2025 18:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] pci: xilinx: Add probe function and improve memory
 region handling
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
 <20250603133744.278790-4-uros.stajic@htecgroup.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250603133744.278790-4-uros.stajic@htecgroup.com>
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



On 6/3/25 15:39, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> This patch adds a `.probe` implementation to the Xilinx PCIe driver
> to initializ bridge registers and determine the ECAM region size
> at runtime.
> 
> Additionally, writing the PCI memory base and limit registers is skipped
> for the root bridge (bus 0, device 0). On platforms such as the MIPS
> Boston board, writing these fields results in incorrect values being
> reported (e.g. base = 0x0, limit = 0x1600), causing Linux to fail
> memory space assignment for the bridge.
> 
> This workaround allows a MIPS Boston board to boot Linux & let Linux
> successfully probe the PCIe bus & all devices connected to it.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>   drivers/pci/pcie_xilinx.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
> index 63058e8e7c5..3b6a8ced848 100644
> --- a/drivers/pci/pcie_xilinx.c
> +++ b/drivers/pci/pcie_xilinx.c
> @@ -132,6 +132,15 @@ static int pcie_xilinx_write_config(struct udevice *bus, pci_dev_t bdf,
>   				    uint offset, ulong value,
>   				    enum pci_size_t size)
>   {
> +	if (bdf == PCI_BDF(bus->seq_, 0, 0)) {
> +		switch (offset) {
> +		case PCI_MEMORY_BASE:
> +		case PCI_MEMORY_LIMIT:
> +			/* Writing the memory base or limit causes problems */
> +			return 0;
> +		}
> +	}
> +
>   	return pci_generic_mmap_write_config(bus, pcie_xilinx_config_address,
>   					     bdf, offset, value, size);
>   }
> @@ -186,6 +195,31 @@ static int pci_xilinx_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int pcie_xilinx_probe(struct udevice *dev)
> +{
> +	struct xilinx_pcie *pcie = dev_get_priv(dev);
> +	u32 bridge_info, ecam_sz, rpsc;
> +
> +	/* Disable all interrupts */
> +	writel(0, pcie->cfg_base + XILINX_PCIE_REG_INT_MASK);
> +
> +	/* Enable the bridge */
> +	rpsc = readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
> +	rpsc |= XILINX_PCIE_REG_RPSC_BEN;
> +	writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
> +
> +	/* Discover the size of the ECAM region */
> +	bridge_info = readl(pcie->cfg_base + XILINX_PCIE_REG_BRIDGE_INFO);
> +	ecam_sz = bridge_info & XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_MASK;
> +	ecam_sz >>= XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_SHIFT;
> +
> +	/* Enable access to all possible subordinate buses */
> +	writel((0 << 0) | (1 << 8) | (GENMASK(ecam_sz - 1, 0) << 16),
> +	       pcie->cfg_base + PCI_PRIMARY_BUS);
> +
> +	return 0;
> +}
> +
>   static const struct dm_pci_ops pcie_xilinx_ops = {
>   	.read_config	= pcie_xilinx_read_config,
>   	.write_config	= pcie_xilinx_write_config,
> @@ -204,4 +238,5 @@ U_BOOT_DRIVER(pcie_xilinx) = {
>   	.of_to_plat	= pcie_xilinx_of_to_plat,
>   	.probe			= pci_xilinx_probe,
>   	.priv_auto	= sizeof(struct xilinx_pcie),
> +	.probe			= pcie_xilinx_probe,
>   };

NACK. Defining second probe to overwrite original one is definitely not a good 
approach.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

