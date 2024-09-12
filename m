Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC70EEE271
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7838389103;
	Fri, 13 Sep 2024 01:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726182719;
	bh=P0kLXtpHi5EGHdwqawkF0Y+tVCa1Y3r3RXv/QFRCLhE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8LJR78GiQTyjesy/qrtwVbNz80d3QkFeNXxwgByE/hY2xnQt2JSBv/y7cHXGeC9z
	 ni/8kOxY4kIWyz+t6Iq2zxEzuRKMMSDyaKXkct7a8lyd9i8OnAexXTd2Mc83Z5le68
	 te2jQkS0UFwEF8Hk7+Zv2+Copd7pWvmbPY00a+8qqvxQmFuk43LWNgpieYaLtcCOJm
	 +OUUjjB+bcxKTHWIqPYgyWbcZu1U3hQbhK+OEm6VabV9MpG1+xMeZPPhQWHx+E0kaL
	 UX8qvegwrxbXLvpcGnHUMeCYSQVleRtnRHCA9O6dqnUldjNAl4xISBj3DQkcIu43KH
	 oVKYhO2+HvmyQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0AB6D88B9C;
 Fri, 13 Sep 2024 01:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726182718;
 bh=P0kLXtpHi5EGHdwqawkF0Y+tVCa1Y3r3RXv/QFRCLhE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=0KXboGmK8cHqMyGRiGQQEQl2zeq2qqXEu/1DfnzA3n7ISV5SHJZ70E2BF8PD0dJv0
 8Q9on/4obDHpTA4yPz7NoPAqIyBURWrGmcAH31KdwnxxyrGXyTXaWoMoNgsOu0BqjA
 yyy58/gxg6HLIBbAfbKLJTqiKlXLKzJYJ6SrabgNHDXSFlGZOjTIImKOjxcK3ISOcB
 EX9kS0pl596ifymRO8wAMhjm5WCk1y9lKGlU4SQSo1OrAQixyFTp3bhwKoIN57NJhm
 WRCpeaXQeHAE+nBKH5nBcl6htRt+2vhrDAWWrQIK5uCwb6Wa5RLOSb6RTRaScHyfZP
 ph3KqWLRyFELQ==
Message-ID: <960222cf-03dc-4fbb-98b1-1d38f9956636@denx.de>
Date: Fri, 13 Sep 2024 01:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] doc: board: enclustra: add Enclustra Intel AA1 SoM
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-2-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240912060649.190-2-l.rubusch@gmail.com>
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

On 9/12/24 8:06 AM, Lothar Rubusch wrote:
[...]

> +Mercury AA1 Module (Arria1 10)
> +==============================
> +
> +- SoM: https://www.enclustra.com/en/products/system-on-chip-modules/mercury-aa1/
> +- Carrier board Mercury+ ST1: https://www.enclustra.com/en/products/base-boards/mercury-st1/
> +- Carrier board Mercury+ PE1: https://www.enclustra.com/en/products/base-boards/mercury-pe1-200-300-400/
> +- Carrier board Mercury+ PE3: https://www.enclustra.com/en/products/base-boards/mercury-pe3/
> +
> +There are slightly different variants of the AA1 SoM, going by the identifier.
> +
> +- Me-aa1-270-2i2-d11e-nfx3
> +- Me-aa1-270-3e4-d11e-nfx3
> +- Me-aa1-480-2i3-d12e-nfx3
> +
> +The u-boot setup is specific to a quartus design. Generate handoff files from
> +the design. Pass them to a python script to produce a handoff.h file. This is
> +needed as input for building the device-tree for u-boot. Eventually, building
> +the final u-boot depends on the particular Quartus design, the particular
> +carrier board, the selected boot media and boot mode.
> +
> +Enclustra provides reference design examples which can be built with yocto
> +using their meta-layer.
> +
> +- Reference Design AA1 on ST1: https://github.com/enclustra/Mercury_AA1_ST1_Reference_Design
> +- Reference Design AA1 on PE1: https://github.com/enclustra/Mercury_AA1_PE1_Reference_Design
> +- Reference Design AA1 on PE3: https://github.com/enclustra/Mercury_AA1_PE3_Reference_Design
> +- Yocto meta-layer: https://github.com/enclustra/meta-enclustra-socfpga

OpenEmbedded .

> +Quick Start
> +-----------
> +
> +- Setup and build a Quartus design project
> +- Obtain the hps.xml file from the Quartus design project
> +- Generate the handoff.h file for u-boot
> +- Adjust the device-tree file according to your setup
> +- Build u-boot
> +- Flash u-boot
> +
> +Build U-Boot
> +------------
> +
> +The Quartus design produces a design specific ``hps.xml``, an ``emif.xml`` and
> +a corresponding ``id`` file contained in a folder ``handoff``.

s@folder@directory@ on unix systems.

[...]

> +.. code-block:: bash
> +
> +    $ sudo fdisk /dev/sda
> +        n,p,1,2048,+20M
> +        t,1,c
> +        n,p,2,409600,+1M
> +        t,2,a2
> +        n,p,3,425984,<REST>
> +        t,3,83
> +        w

Have a look at 'sfdisk' tool, scriptable fdisk , that is preferable .

[...]

> +Boot Media
> +----------
> +
> +Alternative boot media are possible as officially documented by Enclustra.
> +
> +* Micro-SD card
> +* eMMC
> +* QSPI
> +
> +NB: eMMC and QSPI can be flashed from off the u-boot shell. Usually after

What does 'NB:' stand for ?

> +flashing, the coorect boot mode needs to be set by a BSEL switch. Approaches
> +are described consistently in the offical Enclustra documentation according to

"official", typo, run the docs through e.g. aspell to catch those typos.

[...]
