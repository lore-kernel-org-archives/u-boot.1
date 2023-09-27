Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80471E7F14B
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 01:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C2E8692B;
	Wed, 27 Sep 2023 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GExRviT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1055586B05; Wed, 27 Sep 2023 03:58:07 +0200 (CEST)
Received: from mail-m92238.xmail.ntesmail.com (mail-m92238.xmail.ntesmail.com
 [103.126.92.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260D486537
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 03:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GExRviT3e8ifWDT+9pxM3uaKwQgRejsT6WdsHty68Wd9x6o7eIUnQcJ74keJljZLGYniTekarpDJMZJq6h0C75wmO61P+jHjej2zHqZWvb2hUMJoiay1jm99VVyNyuPKRLX7eilWqIYx79dtCNB//cL3ODi3YTTTthYVAWgzkQI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=C90dUHKJWcHLWDQbXo++fEYLvGP8WrLtYdidZIc2gQ0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 34C6E400276;
 Wed, 27 Sep 2023 09:57:53 +0800 (CST)
Message-ID: <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
Date: Wed, 27 Sep 2023 09:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktDTVZNQk9NTB1PSh0YGEtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad45b627c2eb3kusn34c6e400276
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6HRw5SDw3FDZLLw0sHi0O
 ATEaC0NVSlVKTUJOTExCQ0xIQkJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQkJMNwY+
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

Hi Jonas,


     Basically these patches are feature update and should be merge and 
send in next MW.


I have question about PCIe bifurcation, does this also merged in linux 
kernel? I do check the status

in kernel mailing list but forget to feedback with you, I didn't see the 
pcie node in rk3588 dtsi.

I have a little bit confuse about how the phy init for different controller:

eg: if the hardware use pcie3 phy as 2lane + 1 lane + 1 lane, how to 
write pcie/phy dts?


Thanks,

- Kever

On 2023/9/26 05:30, Jonas Karlman wrote:
> Hi Kever,
>
> It would be nice to get some feedback and plans for this and the
> following series :-)
>
> rockchip: rk3568: Fix use of PCIe bifurcation (this series)
> https://patchwork.ozlabs.org/cover/1816140/
>
> rockchip: rk3568-nanopi-r5: Add missing PCIe options
> https://patchwork.ozlabs.org/cover/1816147/
>
> rockchip: Port IO-domain driver for RK3568 from linux
> https://patchwork.ozlabs.org/cover/1823769/
>
> I also plan to send a v2 with small update based on the little feedback
> I got on the following:
>
> rockchip: Add GMAC support for RK3568 and RK3588
> https://patchwork.ozlabs.org/cover/1817469/
>
> Regards,
> Jonas
>
> On 2023-08-02 21:04, Jonas Karlman wrote:
>> This series add support for use of PCIe bifurcation on RK3568, and as a
>> bonus support for the RK3588 PHY is also included. With PCIe bifurcation
>> supported it is possible to enable PCIe on more RK3568 boards, e.g. on
>> NanoPi R5C and NanoPi R5S. This series only include fixing the mini PCIe
>> slot on Radxa E25.
>>
>> Most parts of this series was imported almost 1:1 from mainline linux.
>>
>> Patch 1 fixes configuration of number of lanes in pcie_dw_rockchip.
>> Patch 2-3 refactor the snps-pcie3 phy driver.
>> Patch 4 add bifurcation support for RK3568.
>> Patch 5 add support for RK3588 to snps-pcie3 driver.
>> Patch 6 fixes use of pcie2x1l0 on ROCK 5B.
>> Patch 7 enables the mini PCIe slot on Radxa E25.
>>
>> Changes in v2:
>> - Fix use of signal from comb PHY on RK3588
>> - Add fixes tag
>>
>> The RK3588 PHY part was tested on a ROCK 5B together with device tree
>> files picked from Sebastian Reichel's rk3588 branch at [1].
>>
>> Patches in this series is also aviliable at [2].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/tree/?h=rk3588
>> [2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk35xx-pcie-bifurcation-v2
>>
>> Jonas Karlman (7):
>>    pci: pcie_dw_rockchip: Configure number of lanes and link width speed
>>    phy: rockchip: snps-pcie3: Refactor to use clk_bulk API
>>    phy: rockchip: snps-pcie3: Refactor to use a phy_init ops
>>    phy: rockchip: snps-pcie3: Add bifurcation support for RK3568
>>    phy: rockchip: snps-pcie3: Add support for RK3588
>>    phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588
>>    rockchip: rk3568-radxa-e25: Enable pcie3x1 node
>>
>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     |  11 +-
>>   configs/radxa-e25-rk3568_defconfig            |   1 -
>>   drivers/pci/pcie_dw_rockchip.c                |  58 ++++-
>>   .../rockchip/phy-rockchip-naneng-combphy.c    |   6 +
>>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 230 ++++++++++++++----
>>   5 files changed, 241 insertions(+), 65 deletions(-)
>>
