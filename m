Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D0FCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B1E280C0C;
	Mon, 12 Oct 2026 22:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sf0saqoTl8oD; Mon, 12 Oct 2026 22:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FB0780BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791845972;
	b=QY18ZDYo1DQCQjX17wSb4Vu6XM2iet2JvmtZaC7xGnNFeqsTImNNwSDEb2eq2rxYGkJg
	 I+uBRLyvagHZi4+o5qAIsH8ZEoiUX6Z0GWhbWvxgSDg31mWhaVMOvP83HDndKIhGg3kfr
	 rhnlOFMGmDZ30bKJzyC2Cokm58t3CNOcpG+k3rUEdNU2/QKrYlfNwrxVvGiS1UMl3BpZR
	 lb7Na45pXgLm2ckYUvH852q33SZpsXAJuFTl5Q2jSGhSpslx6NVITy2Zet9Q8LXY7xrlU
	 Q+8XFw3E0hzuEJlldET8rUXA1Fl6vJjaXcmmBAUwA6KVP+KhYn/fcEduGECKmLu5lNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791845972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FOsg4i4GqkyR2aYylN+yMNvO3Cu2fsz7u3odFRrxPkE=;
	b=asEkRnb614rwpmeDwxv8owCnod3hrgkRgs1w4Zkh+mmP1ojZb5jqWrKTwE3ZcjOfBlK+
	 NQz8xQ3qLka7uLQyVhTXBj3IjOQwV4Qh1imG/QpoNY14f2UeNcSLWzQ/AA5Ep+V0eZ3N8
	 Hz/XN/7K1zjqzEDp48BBs1+sXNX5Hkvfp1FpjnOP9uLdJFmeH8QOknUrZCV0ZN3uONwMT
	 xL5LtjPHCmDTXt4s13phT3Ohr6etNpENCQ9+FkGpaoN7FO7INFDgIjNVS0P4U6nUTEbR5
	 NgXkOMxaBl2TMaYmu/lUmrsNAdxHPJla4nsapW4D/53eWAR8QDAYclv8l7quIrC8oyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791845972;
	bh=FOsg4i4GqkyR2aYylN+yMNvO3Cu2fsz7u3odFRrxPkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+6urFdah1qJ3U25Py6SDlcR901keVguDLmsmCFqGIu7nvbvIHfscU4KWGVPqzxGs
	 Gr8L404qFplTMwpAPMSgtijBgeaU1AxST7hQYgccNgBdrjZqsRry3VACfDaZWbwRHz
	 Vt6tbGsEI7n1NQwT1VCJHNrFPnS5v5uo66OzBtdkkIIPCjHSaU4Rr7uCOiwvI99f3+
	 gM7PkSd1w7DcDkKzdZwqrl0lOOQnMm3z06Qzde9YNfb7k8st6mB8C7dZBaAoy6Mtp+
	 3WW2wNPZ5tM9+jHD9v39tw0zBM4rLJkv1Ir7Vm5+Iyc9hy+nX1stL5ze/6E/sXWLyP
	 M3KnZAcU4eMig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FB0780BDD;
	Mon, 12 Oct 2026 22:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9637362
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEBCA40226
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ND9A8p2Co5h9 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:59:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E67540212
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791845969;
 b=YYMn/1tZWRoxT6qojvxy9L3IaV40AX0lFnoNzxUTKJOwLPJsPbaEVhHVYSlzvljL8pK/
 UeFbRyQBCWDbgQW02f7CuMGEnK8LT/1TQqB8iXGsKVORCdBpYdUJwDiwBY5XByjQW6705
 ZZDvMuDTO8bNs3A40hizQ2yzSJ4M5HwnUjCp0zr1fpyMSs+WRs0WoUW+hUrgnRYPqc8Jj
 Nyei7PqFidSCXWiqgR/nYVL8o75aiXldh0wamGcPtxVrs9QRYdFr0eXJq3eAIBz41MLRJ
 NmmevelIqgGjhoJXma7KIek12jkHvJPL+g0FSni4l4ukQcOXrhjN+qsM0AgMolcAvhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791845969;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=FOsg4i4GqkyR2aYylN+yMNvO3Cu2fsz7u3odFRrxPkE=;
 b=bii/UdE80xe18lb2f5oaO2KRFNtaP2BBUraud45ipnHmHX9mV5MinwHzLp0UiI6BCUA8
 +7/U7CZx7k8ASkS75eqhiMMHJfYh9RS6ba3XBb697DfhANoyy0IDoLigQsn+VCYLiBPUy
 lpGU7os8y+QPhnDXrAwzaZ2i1I5He65Z8q3EGQ9yLIaWElvIZ/zvKx45ilRHhs5yIKht0
 PvB7J8VA90DKPEaZzZ/RqmvIJVdtcZZJO7lm6+EtbN0wBagLStqpocAtNzqEC2mj1Rd3X
 b8RQr16a8u1GUVxYn69/2XTpJNdE3nDzVX8hcEwJ+P71YT2XlzmsHUNsR2Y4L8gqQSw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Wkre1k5Y; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Wkre1k5Y
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E67540212
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791845951;
 bh=FOsg4i4GqkyR2aYylN+yMNvO3Cu2fsz7u3odFRrxPkE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wkre1k5YnfFM0qvaAMIp4J0OF2UYWMwZzo+aYYX9I8NUrdJfj7awUec3pUETGi40q
 gbp4bPtMfDQzy05gBKyBvoRzMdoy5KYC2pfRAb0+GtogeF44+kJkzuzLOvujAuJ6MM
 1JqM9zhbv/UmFmmJQM5scwNviYu7PTFn48hGFhIL+jVdOWygIk5K5gfnobvMNIopuB
 xADGOJNzBa2kJgvxSM9Mh/LIZflGqlfLbd4Jw7WTwzgME99bgaMYm3zVNiruRNwdr/
 QmjzMVasl2K+zDYKLLa/ZTjnb5lWU1YewkcccCfKsPKaxmk8DDT4jNSAJnsuWS0vyM
 hzY5drWlaODfQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F285EB2200F5;
 Tue, 13 Oct 2026 00:59:09 +0200 (CEST)
Message-ID: <5d323a11-da4e-4071-bdeb-ab5c03e8f85e@freeshell.de>
Date: Mon, 12 Oct 2026 15:59:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spacemit: k1: add Milk-V Jupiter
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, Raymond Mao
 <raymond.mao@riscstar.com>, u-boot@lists.u-boot-project.org
References: <20261012151530.1564771-1-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261012151530.1564771-1-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hung-Chun,

On 10/12/26 08:15, Hung-Chun Tseng wrote:
> The SPL already maps the Milk-V Jupiter EEPROM product name
> "k1-x_milkv-jupiter" to "spacemit/k1-milkv-jupiter", and the upstream
> device tree for the board is in dts/upstream, but the board is not in
> CONFIG_OF_LIST. board_fit_config_name_match() therefore finds no
> configuration for it and U-Boot proper starts with the default
> (Banana Pi BPI-F3) device tree.
> 
> Add a u-boot.dtsi for the board and list it in CONFIG_OF_LIST. The
> board is close to the BPI-F3: the EEPROM is at 0x50 on i2c2 and the P1
> PMIC at 0x41 on i2c8, with the same buck1/buck3/aldo1 rails, so the
> dtsi follows k1-bananapi-f3-u-boot.dtsi. Like the MusePi Pro, the
> Jupiter has an SPI NOR flash on the QSPI controller, so mark it
> bootph-pre-ram as well.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> Not tested on hardware: I don't have a way to recover the board if the
> new boot chain fails, so this is compile-tested only. What I checked:
> 
> - The FIT built from spacemit_k1_defconfig now has a
>   "spacemit/k1-milkv-jupiter" configuration (conf-2), and the Jupiter
>   DTB carries the bootph-pre-ram and regulator-name properties from the
>   new dtsi.
> - On a Milk-V Jupiter running Linux, the EEPROM at 0x50 on i2c2 holds a
>   TlvInfo product name (type 0x21) of "k1-x_milkv-jupiter", which is the
>   name board/spacemit/k1/spl.c maps to "spacemit/k1-milkv-jupiter".
> - On the same board, the P1 PMIC answers at 0x41 on i2c8, and the SPI
>   NOR on the QSPI controller at 0xd420c000 is a GD25Q64, matching the
>   nodes this dtsi marks bootph-pre-ram.
> 
> A Tested-by from someone with a Jupiter would be welcome.
> 
>  arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi | 132 ++++++++++++++++++++
>  configs/spacemit_k1_defconfig               |   2 +-
>  2 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi
> 
> diff --git a/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi b/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi
> new file mode 100644
> index 000000000..24bc87669
> --- /dev/null
> +++ b/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 RISCstar Ltd.
> + * Copyright (C) 2026 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> + *
> + * Based on k1-bananapi-f3-u-boot.dtsi.
> + */
> +
> +#include "binman.dtsi"
> +
> +/ {
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
> +	};
> +};
> +
> +&uart0 {
> +	bootph-pre-ram;
> +};
> +
> +&osc_32k {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_1m {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_3m {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_24m {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_mpmu {
> +	bootph-pre-ram;
> +};
> +
> +&pll {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_apmu {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_apbc {
> +	bootph-pre-ram;
> +};
> +
> +&i2c2 {
> +	bootph-pre-ram;
> +
> +	eeprom@50 {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +/*
> + * The kernel pmic@41 nodes use the standard regulator-* properties only;
> + * U-Boot's regulator framework looks up suppliers by `regulator-name`.
> + * Carry the U-Boot-specific names (vdd_core / vdd_1v8 / vdd_1v8_mmc) here
> + * so SPL can program the bucks that DDR training depends on.
> + */
> +&i2c8 {
> +	bootph-pre-ram;
> +
> +	pmic@41 {
> +		bootph-pre-ram;
> +
> +		regulators {
> +			buck1 {
> +				regulator-name = "vdd_core";
> +				bootph-pre-ram;
> +			};
> +
> +			buck3 {
> +				regulator-name = "vdd_1v8";
> +				bootph-pre-ram;
> +			};
> +
> +			aldo1 {
> +				regulator-name = "vdd_1v8_mmc";
> +				bootph-pre-ram;
> +			};
> +		};
> +	};
> +};
> +
> +&qspi {
> +	bootph-pre-ram;
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&emmc {
> +	bootph-pre-ram;
> +	max-frequency = <204800000>;
> +};
> +
> +&sdhci0 {
> +	bootph-pre-ram;
> +	max-frequency = <204800000>;
> +};
> +
> +&binman {
> +	u-boot-spl-ddr {
> +		type = "section";
> +		filename = "u-boot-spl-ddr.bin";
> +		pad-byte = <0xff>;
> +
> +		u-boot-spl {
> +		};
> +
> +		ddr-fw {
> +			type = "blob";
> +			filename = "ddr_fw.bin";
> +			align = <64>;
> +		};
> +
> +		u-boot-any {
> +			type = "section";
> +			size = <0>;
> +			offset = <0>;
> +		};
> +	};
> +};
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 39c490438..8e8ecbb6d 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -65,7 +65,7 @@ CONFIG_CMD_EXT4=y
>  CONFIG_CMD_FAT=y
>  CONFIG_EFI_PARTITION=y
>  CONFIG_OF_UPSTREAM=y
> -CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
> +CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-milkv-jupiter spacemit/k1-musepi-pro"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y

Please firstly send a series upstream that adds such trivial nodes as
appropriate to all supported upstream spacemit/k1-*.dts boards.

Reading for reference:
https://lore.kernel.org/lkml/20260324220950-GKB767626@kernel.org/

Any trivial -u-boot.dtsi nodes (binman, max-frequency) must go upstream
to Linux. For reasons mentioned by Yixun when there is not any working
SPL in mainline U-Boot then it is not yet possible to test completely
the bootph-pre-ram nodes for inclusion upstream and anyways they are not
needed by anyone at that moment.

Since then, as we are seeing progress to mainline U-Boot with SPL
possible on K1 SoC, the bootph-pre-ram nodes are now appropriate to send
upstream. Any "max-frequency" nodes not possible to be accepted upstream
are likely a driver issue and should be discussed further.

If you carry these trivial nodes in u-boot temporarily is fine however
when doing so I recommend there should be acceptance upstream first by
the subsystem maintainer and then here include a mailing list archive
link or commit id for where an upstream Linux subsystem maintainer has
accepted the changes. The reason I suggest this is to not burden others
with this work and make it easy to remove entirely any per-board
-u-boot.dtsi that is carried here.

I suggest to focus on sending nodes upstream that are a requirement for
a bootloader following any of all available K1 BootROM boot modes, and
to make these changes land (where appropriate) into k1.dtsi,
k1-opp.dtsi, and/or k1-pinctrl.dtsi common shared includes. Per-board
bootph-pre-ram nodes would cover board-specific additional peripherals
not contained in the K1 SoC. The patch does not need to advertise U-Boot
because upstream dts describes hardware, so the commit message
justification should be any boot loader SPL following the K1 SoC
BootROM, and T-by tags would be appropriate when mentioning what
specific boot loader is tested.

Thank you,

-E Shattow
