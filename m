Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26200CE8D6B
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 02:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C508416F;
	Sat, 15 Nov 2025 03:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OkVE0Rau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAEB84183; Sat, 15 Nov 2025 03:21:39 +0100 (CET)
Received: from mail-m833.xmail.ntesmail.com (mail-m833.xmail.ntesmail.com
 [156.224.83.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B118415D
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 03:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.lin@rock-chips.com
Received: from [172.16.12.165] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29a9f9e79;
 Sat, 15 Nov 2025 10:21:29 +0800 (GMT+08:00)
Message-ID: <ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com>
Date: Sat, 15 Nov 2025 10:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, krzk+dt <krzk+dt@kernel.org>,
 conor+dt <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, =?UTF-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday> <aRUvr0UggTYkkCZ_@geday> <aRazCssWVdAOmy7D@geday>
 <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
 <aReSPbRxCgdNRI9y@geday>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aReSPbRxCgdNRI9y@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a85514c4609cckunm48e2a22b4fe54e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk8aGlZPSxkZGhhDTEoZSExWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=OkVE0Rau8ZcS49W5FkYWVPEVseZOuBmXemzSCxTH3JXT0XCeVR0NHLZhFDDykAl88/Mir5HmZQIkS7SHXHT2nrvk2Wkjnli7GWi+T/yPdtny9sj+CM7uBZvIOaY6Py4ekP45aeOdzGzIKycYnM1cOE10FmPlEbaa5In/e0SQNzk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=SbuBNQczlLUG9KXdbmoq6UM3KotrjW3EyKj2mpRpQqk=;
 h=date:mime-version:subject:message-id:from;
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


在 2025/11/15 星期六 4:34, Geraldo Nascimento 写道:
> On Fri, Nov 14, 2025 at 05:16:21PM +0800, Shawn Lin wrote:
>> Don't worry, it's helpful, so I think Ye could have a look.
>> May I ask if the failure only happened to one specific board?
> 
> Hi Shawn,
> 
> Yes, testing is restricted to my Radxa Rock Pi N10 board.
> 
>>
>> Another thing I noticed is about one commit:
>> 114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before
>> retraining")
>>
>> It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
>> But we issued an errata long time ago to announced it doesn't, you could
>> also check the PCIe part of RK3399 datasheet:
>> https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> 
> OK, I'm partly responsible for that as author of the commit in question.
> 
> First off let me say I do not intend to send any patches setting
> max-link-speed to TWO for this platform.
> 
> I understand you issued an erratum, but are you absolutely sure about
> that erratum? Because my testing shows otherwise:

Sure.

The reason is that Gen2 is merely functional, but this does not mean it 
is 100% production-ready. It has some inherent issues that cannot be 
resolved, which may lead to failures beyond imagination. Even if the 
probability of occurrence is as low as 1 in 100,000. I cannot share 
further details. Therefore, the official documentation should be your 
primary reference, rather than relying solely on simple evaluations.

> 
> ---
> With max-link-speed = <2>
> pci 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> 
> /dev/nvme0n1:
>   Timing cached reads:   3002 MB in  2.00 seconds = 1502.21 MB/sec
>   Timing buffered disk reads: 2044 MB in  3.00 seconds = 680.79 MB/sec
> ---
> With max-link-speed = <1>
> pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> 
> /dev/nvme0n1:
>   Timing cached reads:   2730 MB in  2.00 seconds = 1366.15 MB/sec
>   Timing buffered disk reads: 2028 MB in  3.00 seconds = 675.71 MB/sec
> ---
> 
> As you can see, not only the kernel PCI driver recognizes 5.0 GT/s PCIe
> link but there's even a marginal increase in cached reads as measured by
> hdparm, the gains are of course limited by CPU performance.
> 
>> Also we set max-link-speed to ONE in rk3399-base.dtsi but seems another
>> patch slip in: 755fff528b1b ("arm64: dts: rockchip: add variables for
>> pcie completion to helios64")
> 
> I can't speak for patches I haven't authored, but I believe you're
> welcome to send a correction.
> 
> Thank you,
> Geraldo Nascimento
> 

