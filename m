Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE8EE78480
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 18:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6895F86406;
	Sun,  1 Oct 2023 20:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pLdXtcOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B208640F; Sun,  1 Oct 2023 20:52:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289EA85DEA
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 20:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=MIME-Version: Content-Transfer-Encoding: Content-Type: In-Reply-To:
 From: References: Cc: To: Subject: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696186356;
 bh=j0tFoRqXuZIwYNOCy9g2MVAxMCInOxpgwO7K8Qy44J8=;
 b=pLdXtcOk6Eq2gWQNPFdY/vZ+3IjAjwWp/UuqwTQHEwVS9P51rcuVUdS3qzHMC/a6KxPDpWlv7
 /yGwKcsgs1Xc7KALxeZtaeqxYkDqDx7Q8K0qMm50tqBUa9sSVD1Telwr6EIR/U/vSukOCMCFAvA
 jClbhl6PFnZafrjSvMdMmcUrasvUb/Gw2UtDKR5CAjNzDYFwYroKPjthkyVWBHUCSXQ/2G98d6s
 X15tr87ohKR6EuVTcT7vJ1TztSVhZ34VIE7LP8IqdxZGoHvpE6hJtae5p6uF4mOmdstYX0Ft56E
 x0g9ln3z7KFtKwNLDjGbHh1J/Yu+jv937yMCVhS7WseQ==
Message-ID: <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
Date: Wed, 27 Sep 2023 20:07:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jon Lin
 <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, John Clark
 <inindev@gmail.com>, u-boot@lists.denx.de, Sebastian Reichel
 <sebastian.reichel@collabora.com>
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
 <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6519bff4cda43bba9610d955
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

Hi Kever,

On 2023-09-27 03:57, Kever Yang wrote:
> Hi Jonas,
> 
> 
>      Basically these patches are feature update and should be merge and 
> send in next MW.
> 

Great and thanks!

> 
> I have question about PCIe bifurcation, does this also merged in linux 
> kernel? I do check the status
> 
> in kernel mailing list but forget to feedback with you, I didn't see the 
> pcie node in rk3588 dtsi.

The snps-pcie3 phy driver should match what has been merged into mainline linux.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c

RK3588 DT nodes for PCIe2 and PCIe3 was merged for linux v6.6-rc1 in:

arm64: dts: rockchip: add PCIe3 support for rk3588
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/rockchip?id=0acf4fa7f187cd7e3dad93f1ee14e9509687621e

arm64: dts: rockchip: add rk3588 PCIe2 support
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/rockchip?id=8d81b77f4c49f8ee1432c20c22bf0f03c2937a88

And following two pending series add PCIe nodes to EVB1 and Rock 5B.

RK3588 EVB1 PCIe support
https://lore.kernel.org/all/20230918141327.131108-1-sebastian.reichel@collabora.com/

RK3588 Rock 5B PCIe support
https://lore.kernel.org/all/20230918141451.131247-1-sebastian.reichel@collabora.com/

This series was tested together with a device tree that should be very close
to what was merged for v6.6-rc1 and above Rock 5B PCIe nodes.
https://github.com/Kwiboo/u-boot-rockchip/commit/d040547bad665f7c6ea9e83c55ed8cca1ff73a5b

Following patch should sync latest rk3588 dtsi and add pcie nodes.
https://patchwork.ozlabs.org/project/uboot/patch/20230905114736.22585-1-naoki@radxa.com/

I expect that there may be a need for one more DT sync after all this
have landed in next/master.

> 
> I have a little bit confuse about how the phy init for different controller:
> 
> eg: if the hardware use pcie3 phy as 2lane + 1 lane + 1 lane, how to 
> write pcie/phy dts?
> 

This is an example from rk3568-radxa-e25.dts

&pcie30phy {
	/* First data-lane is routed to controller 1
	 * Second data-lane is routed to controller 2
	 */
	data-lanes = <1 2>;
	...
};

&pcie3x1 {
	/* Use 1 data-lane */
	num-lanes = <1>;
	...
};

&pcie3x2 {
	/* Use 1 data-lane */
	num-lanes = <1>;
	...
};

Above works with this series in U-Boot and also in mainline linux. Not
sure the RK3588 bifurcation part of driver have been verified on real HW,
rk3588 boards available for testing have typicality not used bifurcation.

For 2 lane + 1 lane + 1 lane I would expect DT to look something like:

&pcie3-phy {
	data-lanes = <1 1 2 3>;
};

&pcie3-1 {
	num-lanes = <2>;
};

&pcie3-2 {
	num-lanes = <1>;
};

&pcie3-3 {
	num-lanes = <1>;
};

See bindings for data-lanes property:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml#n29

Regards,
Jonas

> 
> Thanks,
> 
> - Kever
> 
> On 2023/9/26 05:30, Jonas Karlman wrote:
>> Hi Kever,
>>
>> It would be nice to get some feedback and plans for this and the
>> following series :-)
>>
>> rockchip: rk3568: Fix use of PCIe bifurcation (this series)
>> https://patchwork.ozlabs.org/cover/1816140/
>>
>> rockchip: rk3568-nanopi-r5: Add missing PCIe options
>> https://patchwork.ozlabs.org/cover/1816147/
>>
>> rockchip: Port IO-domain driver for RK3568 from linux
>> https://patchwork.ozlabs.org/cover/1823769/
>>
>> I also plan to send a v2 with small update based on the little feedback
>> I got on the following:
>>
>> rockchip: Add GMAC support for RK3568 and RK3588
>> https://patchwork.ozlabs.org/cover/1817469/
>>
>> Regards,
>> Jonas
>>
>> On 2023-08-02 21:04, Jonas Karlman wrote:
>>> This series add support for use of PCIe bifurcation on RK3568, and as a
>>> bonus support for the RK3588 PHY is also included. With PCIe bifurcation
>>> supported it is possible to enable PCIe on more RK3568 boards, e.g. on
>>> NanoPi R5C and NanoPi R5S. This series only include fixing the mini PCIe
>>> slot on Radxa E25.
>>>
>>> Most parts of this series was imported almost 1:1 from mainline linux.
>>>
>>> Patch 1 fixes configuration of number of lanes in pcie_dw_rockchip.
>>> Patch 2-3 refactor the snps-pcie3 phy driver.
>>> Patch 4 add bifurcation support for RK3568.
>>> Patch 5 add support for RK3588 to snps-pcie3 driver.
>>> Patch 6 fixes use of pcie2x1l0 on ROCK 5B.
>>> Patch 7 enables the mini PCIe slot on Radxa E25.
>>>
>>> Changes in v2:
>>> - Fix use of signal from comb PHY on RK3588
>>> - Add fixes tag
>>>
>>> The RK3588 PHY part was tested on a ROCK 5B together with device tree
>>> files picked from Sebastian Reichel's rk3588 branch at [1].
>>>
>>> Patches in this series is also aviliable at [2].
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/tree/?h=rk3588
>>> [2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk35xx-pcie-bifurcation-v2
>>>
>>> Jonas Karlman (7):
>>>    pci: pcie_dw_rockchip: Configure number of lanes and link width speed
>>>    phy: rockchip: snps-pcie3: Refactor to use clk_bulk API
>>>    phy: rockchip: snps-pcie3: Refactor to use a phy_init ops
>>>    phy: rockchip: snps-pcie3: Add bifurcation support for RK3568
>>>    phy: rockchip: snps-pcie3: Add support for RK3588
>>>    phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588
>>>    rockchip: rk3568-radxa-e25: Enable pcie3x1 node
>>>
>>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     |  11 +-
>>>   configs/radxa-e25-rk3568_defconfig            |   1 -
>>>   drivers/pci/pcie_dw_rockchip.c                |  58 ++++-
>>>   .../rockchip/phy-rockchip-naneng-combphy.c    |   6 +
>>>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 230 ++++++++++++++----
>>>   5 files changed, 241 insertions(+), 65 deletions(-)
>>>
