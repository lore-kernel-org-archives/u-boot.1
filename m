Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73706D116E0
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 23:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE49083D13;
	Thu, 27 Nov 2025 00:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="ZE+tYFCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105F183F70; Thu, 27 Nov 2025 00:43:25 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139F383B72
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 00:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764200551;
 bh=8Z5kXulIyfbh+kfdzYAsoBG61yowpw+BTIK1fhtOw1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZE+tYFCC+Y27rTG4kgw8CoXLuUi5fOuKyJUn31rq+H7Ah2U9obO/2phSV8xH8Jdbb
 gqJLCDHru+NyXu0aamiTpOgtyhngXPHTIowVf2dHmPuHxynMXSV9LUYjPXQDvY1T06
 Nrrdgh4/m7qxQSJqadGAfCBHsg17jGh3BwmAlz/MLvmQlQt8eAI/itcgCzShiQjdEa
 R3gw7Jv9wbZGnd+QFuMF6wBR/hEoHbKn7XX/DYV25OoFtttygBdUu6oAD3Mh4wsfak
 EFLJNIbmJumBzSKN9G8afXcDFC4vpyPGel9RKbGfsNvZqwBi/nxob9LK1pFnlsR93A
 ZxPKWp3tGnEoA==
Received: from [192.168.2.54] (unknown [98.97.63.250])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D6000B2201A1;
 Thu, 27 Nov 2025 00:42:29 +0100 (CET)
Message-ID: <1cb6747e-a54d-4b54-8cbc-f41932e1a29a@freeshell.de>
Date: Wed, 26 Nov 2025 15:42:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Add upstream board Xunlong Orange Pi RV
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <uwu@icenowy.me>
References: <20251126221552.87574-1-e@freeshell.de>
 <B7BF64B9-B3C7-4885-B1F2-767D69298313@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <B7BF64B9-B3C7-4885-B1F2-767D69298313@gmx.de>
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


On 11/26/25 14:34, Heinrich Schuchardt wrote:
> Am 26. November 2025 23:15:25 MEZ schrieb E Shattow <e@freeshell.de>:
>> Xunlong Orange Pi RV patches are now queued up for the next merge window
>> to Linux v6.19, so let's introduce support for this board.
>>
>> Note: The content of EEPROM is not known to be unique on this board, and
>> in this RFC there is a placeholder value of "XOPIRV".
> 
> If OrangePi is not providing a unique value, shouldn't we create a separate defconfig (including the vf2 one) and override the output of the eeprom reading function by a configuration value?
> 
> That way we can reuse most code and avoid that users have to update the EEPROM to "XOPIRV".
> 
> Best regards
> 
> Heinrich
> 
>>
>> E Shattow (4):
>>  riscv: dts: starfive: Add Orange Pi RV from upstream Linux for-next
>>  board: starfive: visionfive2: Add Orange Pi RV selection by product_id
>>  riscv: dts: Add placeholder files for pending upstream Orange Pi RV
>>  configs: starfive: Add Orange Pi RV to visionfive2
>>
>> arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi | 76 +++++++++++++++++++
>> board/starfive/visionfive2/spl.c              |  3 +
>> .../visionfive2/starfive_visionfive2.c        |  2 +
>> configs/starfive_visionfive2_defconfig        |  2 +-
>> .../src/riscv/starfive/jh7110-orangepi-rv.dts |  0
>> 5 files changed, 82 insertions(+), 1 deletion(-)
>> create mode 100644 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi
>> create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
>>
>>
>> base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
> 

Sure I'd like more testing data about these boards, I don't have the
board myself so I don't know the answer to that.

What is the content of EEPROM, for reference?

If it's all the same as VisionFive 2 and boots with dts from VisionFive
2 (1.3b?) then it might not be needed to do more than add documentation
for the board to reference the VisionFive 2 and explain how to properly
set fdtfile. Inventing a new board identifier when the manufacturer has
not provided one sounds convenient to me, and it is not to the exclusion
of a separate board config just for that special situation. The
documentation can explain either or both situations, expanding how to
compile for the board.

How does network and eMMC function with the series applied, not changing
the EEPROM content (remains what I was understood is the same as
VisionFive 2), and manually setting the fdtfile variable?

-E
