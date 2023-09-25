Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBB9CE79A1
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 21:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2ED86BA6;
	Mon, 25 Sep 2023 23:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="Pb49L1bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB64D86BB2; Mon, 25 Sep 2023 23:31:02 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613A186B8F
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=G/PWuisN9Vc8XwJoi0u4afw20ET42g7eb0y9pYc8zuw=;
 b=Pb49L1bbD7INxq1VPeNxtMvPjnF9gIsPDyKqNT4+29iof72wsvS751P1oETNvosDcyKN
 LIs2kKtYb8UgEQ3lPhzLfKWwVD6Wyoyv23RM3JbmE5jcHmEWUD+gRrYOcewnHDmYBDONSO
 Q+FBFp77iiudaJzLYvgWXI+2vlk1/7XPrCN523o0C9Re46RvMTi4jGqw43QhHDbJYtlYAX
 aKNSnET4Gl3SGgONCE4yUR3TwwhR2GkfxHBsFkfyNASu54l0SJZzqQJIeTeoix47K1Lvs5
 FVkpFnISAYNLKpCpH3WJu6BvRxBqkF1VVNxvBu8s1Vpxtd53meACLZnHMUCWrQ7w==
Received: by filterdrecv-84b96456cb-hq7z7 with SMTP id
 filterdrecv-84b96456cb-hq7z7-1-6511FC0F-7A
 2023-09-25 21:30:56.08298353 +0000 UTC m=+11915544.337525000
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-6 (SG) with ESMTP
 id p33lwBGMRIK1q6MhicBCkw Mon, 25 Sep 2023 21:30:55.675 +0000 (UTC)
Message-ID: <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
Date: Mon, 25 Sep 2023 21:30:56 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
Content-Language: en-US
References: <20230802190424.2963185-1-jonas@kwiboo.se>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230802190424.2963185-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h3wyWKWgjmsC317k7?=
 =?us-ascii?Q?MU00J1rXdaHJfSvE+mx5HMdgzYNAf5Yc+udEdqB?=
 =?us-ascii?Q?dklxMCrnpcsAEO6NFH7LJrGDzhmaBgCBEEf4=2F6W?=
 =?us-ascii?Q?Dn9soQaKASaSoBkLZWPdc28OOfuZ82+L7KFSk43?=
 =?us-ascii?Q?qDvsFWJhhsanWnqjo99GpJpzEgT4r4lwn9Zfaf?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jon Lin
 <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, John Clark
 <inindev@gmail.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

Hi Kever,

It would be nice to get some feedback and plans for this and the
following series :-)

rockchip: rk3568: Fix use of PCIe bifurcation (this series)
https://patchwork.ozlabs.org/cover/1816140/

rockchip: rk3568-nanopi-r5: Add missing PCIe options
https://patchwork.ozlabs.org/cover/1816147/

rockchip: Port IO-domain driver for RK3568 from linux
https://patchwork.ozlabs.org/cover/1823769/

I also plan to send a v2 with small update based on the little feedback
I got on the following:

rockchip: Add GMAC support for RK3568 and RK3588
https://patchwork.ozlabs.org/cover/1817469/

Regards,
Jonas

On 2023-08-02 21:04, Jonas Karlman wrote:
> This series add support for use of PCIe bifurcation on RK3568, and as a
> bonus support for the RK3588 PHY is also included. With PCIe bifurcation
> supported it is possible to enable PCIe on more RK3568 boards, e.g. on
> NanoPi R5C and NanoPi R5S. This series only include fixing the mini PCIe
> slot on Radxa E25.
> 
> Most parts of this series was imported almost 1:1 from mainline linux.
> 
> Patch 1 fixes configuration of number of lanes in pcie_dw_rockchip.
> Patch 2-3 refactor the snps-pcie3 phy driver.
> Patch 4 add bifurcation support for RK3568.
> Patch 5 add support for RK3588 to snps-pcie3 driver.
> Patch 6 fixes use of pcie2x1l0 on ROCK 5B.
> Patch 7 enables the mini PCIe slot on Radxa E25.
> 
> Changes in v2:
> - Fix use of signal from comb PHY on RK3588
> - Add fixes tag
> 
> The RK3588 PHY part was tested on a ROCK 5B together with device tree
> files picked from Sebastian Reichel's rk3588 branch at [1].
> 
> Patches in this series is also aviliable at [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/tree/?h=rk3588
> [2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk35xx-pcie-bifurcation-v2
> 
> Jonas Karlman (7):
>   pci: pcie_dw_rockchip: Configure number of lanes and link width speed
>   phy: rockchip: snps-pcie3: Refactor to use clk_bulk API
>   phy: rockchip: snps-pcie3: Refactor to use a phy_init ops
>   phy: rockchip: snps-pcie3: Add bifurcation support for RK3568
>   phy: rockchip: snps-pcie3: Add support for RK3588
>   phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588
>   rockchip: rk3568-radxa-e25: Enable pcie3x1 node
> 
>  arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     |  11 +-
>  configs/radxa-e25-rk3568_defconfig            |   1 -
>  drivers/pci/pcie_dw_rockchip.c                |  58 ++++-
>  .../rockchip/phy-rockchip-naneng-combphy.c    |   6 +
>  .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 230 ++++++++++++++----
>  5 files changed, 241 insertions(+), 65 deletions(-)
> 

