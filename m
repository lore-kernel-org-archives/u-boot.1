Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01122CAC58F
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 09:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0741E82FC7;
	Sat, 13 Sep 2025 11:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9286D8307F; Sat, 13 Sep 2025 11:23:06 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501448003E
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 11:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.247])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2E129B22016F;
 Sat, 13 Sep 2025 11:23:03 +0200 (CEST)
Message-ID: <7f8d9074-2b5a-4790-adb7-9ed28824dbdd@freeshell.de>
Date: Sat, 13 Sep 2025 02:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME
 prefix to dtsi search
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
References: <20250826214708.309271-1-e@freeshell.de>
 <20250912142319.GA4060911@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250912142319.GA4060911@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 9/12/25 07:23, Tom Rini wrote:
> On Tue, Aug 26, 2025 at 02:47:00PM -0700, E Shattow wrote:
> 
>> Add ${CONFIG_SYS_CONFIG_NAME}-u-boot.dtsi into dtsi include search order:
>> orig filename, (SYS_CONFIG_NAME), SYS_SOC, SYS_CPU, SYS_VENDOR, no prefix
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  doc/develop/devicetree/control.rst | 1 +
>>  scripts/Makefile.lib               | 2 ++
>>  2 files changed, 3 insertions(+)
> 
> A problem is that today, this leads to failure to build on:
> mt7622_rfb mt7986_rfb mt7986a_bpir3_emmc mt7986a_bpir3_sd mt7988_rfb
> mt7988_sd_rfb mt8516_pum
> pkin socfpga_stratix10 socfpga_stratix10_atf socfpga_agilex5
> socfpga_agilex5_nand2 socfpga_agil
> ex5_vab socfpga_n5x socfpga_n5x_atf socfpga_n5x_vab
> mt7623a_unielec_u7623_02 mt7623n_bpir2 imx6
> q_bosch_acc imx6dl_mamoj socfpga_arria10 socfpga_arria5 socfpga_cyclone5
> 
> Because the problem you're trying to solve is being partly solved in
> another way by others, perhaps?
> 

For example the first in the list of build failure, mt7622_rfb:

  DTC     arch/arm/dts/mt7623a-unielec-u7623-02-emmc.dtb
Error: /root/source/u-boot.git/arch/arm/dts/mt7622-u-boot.dtsi:27.1-6
Label or path snfi not found

This happens because CONFIG_SYS_CONFIG_NAME is "mt7622" and is not the
expected "m7622-rfb". Explicitly setting CONFIG_SYS_CONFIG_NAME in
configs/mt7622_rfb_defconfig does not work.

arch/arm/mach-mediatek/Kconfig:
config SYS_CONFIG_NAME
        default "mt7622" if TARGET_MT7622
        default "mt7623" if TARGET_MT7623
        default "mt7629" if TARGET_MT7629
        default ...

Drop this in-flight change from the above and it compiles fine.

I would expect this to be an anti-pattern/bug unless we are setting
CONFIG_SYS_CONFIG_NAME explicitly in a config file, no?

Why is SYS_CONFIG_NAME being modified in this way?

-E
