Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115B2CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 23:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1F487F8C;
	Mon,  1 Apr 2024 01:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uxox5K6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D448879CC; Mon,  1 Apr 2024 01:15:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B790C87FED
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 01:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711926894;
 bh=jrlwW3QpFCLndchumI9HPuSF1BbjtpilxfNtBH/lWb4=;
 b=uxox5K6X6JkPwYX6OpmqN2X27k67TmZavgCoOGF2Dq4CLulloawJtE5p4Q5+s+FpCC1rK3WxE
 4dUsEwzZZi3UHc2BWv2AiFpfEtNIc7WNwAf0MENZnPCRVjyjovTkGpsgsQFVBGHysx5r/WtTVbT
 wvUctMgakjqo1qU/tpwEQmDA7m6j1OQdDbxaqOl42IfRjez+eTFsOj3YPaHw8xLNH6UAD2goG/g
 i9+ZkiFHgmHbsZhOc6Wpz2PjU3M9Gfbk6U+LjmWigL9JN+BV+txClYZwsRwKmuQ6gyu5U58cAD7
 ImaH3P62tKDuZJxdQ/i8eiSBpNyHqG5w+Qh0CKZNeGdA==
Message-ID: <2db72cee-f53e-4b2e-9e35-24883bc63bd6@kwiboo.se>
Date: Mon, 1 Apr 2024 01:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/31] rockchip: rk3399-rock-pi-4: Sync device tree from
 linux v6.8
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-29-jonas@kwiboo.se>
 <3de901ef24bac4a84be53de528b2b766@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3de901ef24bac4a84be53de528b2b766@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609ee6d42b928a7def23f67
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

Hi Dragan,

On 2024-04-01 00:53, Dragan Simic wrote:
> Hello Jonas,
> 
> Please see my comments below.
> 
> On 2024-03-31 22:28, Jonas Karlman wrote:
>> Sync rk3399-rock-pi-4 related device tree from linux v6.8.
>>
>> Add SPI flash related options to support booting from SPI flash.
>>
>> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA 
>> boot.
> 
> As we know, these boards have no standard connectors for PCI Express
> expansion cards, which makes me wonder how many users actually use M.2
> PCI Express modules with SATA controllers on them with these boards,
> and need support for them in U-Boot?
> 
> I mean, it can't hurt, but frankly, I'm not 100% sure about it.

With the M.2 Extension Board [1] and a M.2 to PCIe X4 adapter it is very
easy to convert the M.2 slot into a standard PCIe X4 slot and use it
with a PCIe SATA card. At least that is how I have tested and used this.

I do think there will be many users of PCIe AHCI/SATA, but with this
series I try to get all boards to have same feature set as long as there
is some way to use a feature.

[1] https://radxa.com/products/accessories/m2-extension-board

> 
>> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>>
>> Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.
>>
>> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>>
>> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Otherwise, looking good to me.
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thanks!

Regards,
Jonas

> 
>> ---
>>  arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 12 ++++++++++
>>  arch/arm/dts/rk3399-rock-4c-plus.dts         |  1 +
>>  arch/arm/dts/rk3399-rock-4se-u-boot.dtsi     | 12 ++++++++++
>>  arch/arm/dts/rk3399-rock-pi-4.dtsi           |  4 +++-
>>  arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi   |  7 ++++++
>>  arch/arm/dts/rk3399-rock-pi-4c.dts           | 10 ++++++++
>>  configs/rock-4c-plus-rk3399_defconfig        | 24 +++++++++++++++-----
>>  configs/rock-4se-rk3399_defconfig            | 23 +++++++++++++++++--
>>  configs/rock-pi-4-rk3399_defconfig           |  8 +++++++
>>  configs/rock-pi-4c-rk3399_defconfig          | 24 ++++++++++++++++++--
>>  10 files changed, 114 insertions(+), 11 deletions(-)
>>
[snip]
