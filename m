Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB36AD6EBFF
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 11:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521B789392;
	Fri, 29 Nov 2024 12:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732880069;
	bh=TC6e20VJk9kwKLIuMF7GcnTYGg/DtSzg0ciCik8LiIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJLRBpvtc+ENWeNIhDXBhUQjoNFjaqHXxlnknJ0M35nrn3qFgf5SmT5pVHdgCtyZE
	 hqBCJrJbe/PVIu9OLWlX1A2Nw/5LMmI3XACPx4RwipC9hV4pRtopdiL0YbRhW1f/e8
	 wUVPj+RPtBC/wKEKe85FaGRW0TVAYSDkhwfFJoRPSKi/qmJec6VzO6TXV79B5d1Bhl
	 JZoXZhcXtkN2hDzoWCCndb0XU9/Rz/LIyfch528X2Bq+aPEI/5tJsGLimnIJLvz6En
	 2f+xWgEaIYvrVjJd6a05ugIZxA8S46fnKiP3dXujGCo2mVGK/+dTj0/M74fFcTkasU
	 e+SnDgmtSke9Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 175BB891AB;
 Fri, 29 Nov 2024 12:34:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732880067;
 bh=TC6e20VJk9kwKLIuMF7GcnTYGg/DtSzg0ciCik8LiIA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KWROGqDpRKm2tBoQYDo1gUN/sRoS0kN5BpyUK1LAAu1G3D7VR+cA2KHGWf2KpfY2u
 HMrAYYLaAnBj77uZQ0oCVGm8h47GwzH3c9Oh8H44fgm1xa5lqN1Azzhw4/FmHBczt0
 L4zWoMOjHcubwk+IoT16zVEX9PIN9K6sQm/NK2CsBq6oDXc+/Bse02DESUKq454sfR
 CuTb7XPatlH1QNiqas96i6EC3eW9EkgeI3LiaSUZnFTI2877qj2JFEKGgN+X9glDx6
 5LVuMINpKcZ44wiqcnAIuu9gn3l2LYLEL3Be82ykx3Ef37LtaRwaJYyOu2582Rhuc9
 91oyyrpHaWKlg==
Message-ID: <7364a50b-1802-4172-87a7-76a6cbacd236@denx.de>
Date: Fri, 29 Nov 2024 11:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM
 on PDK2 carrier board
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241105230724.159755-1-marex@denx.de>
 <CAFA6WYME8D9WkC_0gDLT2LKOPk4EXULKgxtdniVKTme5j+uMag@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYME8D9WkC_0gDLT2LKOPk4EXULKgxtdniVKTme5j+uMag@mail.gmail.com>
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

On 11/29/24 8:12 AM, Sumit Garg wrote:
> Hi Marek,
> 
> On Wed, 6 Nov 2024 at 04:37, Marek Vasut <marex@denx.de> wrote:
>>
>> Add support for the DH electronics i.MX6DL DHCOM SoM and a PDK2 evaluation
>> board. The evaluation board features three serial ports, USB OTG, USB host
>> with an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, analog audio,
>> PCIe and HDMI video output.
>>
>> All of the aforementioned features except for mSATA are supported, mSATA
>> is not available on i.MX6DL and is only available on DHCOM populated with
>> i.MX6Q SoC which is already supported upstream.
>>
>> Backport from linux-next commit
>> c3f5d76a6e03 ("ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK2 carrier board")
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>> ---
>> Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
>> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Cc: Fabio Estevam <festevam@denx.de>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> ---
>>   .../src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts     | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>   create mode 100644 dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
>>
> 
> I didn't realize earlier that this patch is directly modifying
> dts/upstream subtree.

That's what Tom suggested.

> Modifying the subtree is likely going to cause
> conflicts with the next subtree pull. It looks like this board is
> targeted for v6.13 release. Let's see if we get lucky with automerge
> being successful for this one but let's try to rather use cherry pick
> or wait for the board support to land in devicetree-rebasing tree. You
> can maintain U-Boot DTS for the time being.
I suspect this patch will simply disappear on next sync , let me know if 
it doesn't or causes any problems.
