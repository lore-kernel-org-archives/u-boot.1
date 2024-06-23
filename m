Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03465C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 22:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A4F88137;
	Mon, 24 Jun 2024 00:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E4888204; Mon, 24 Jun 2024 00:13:38 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E0483989
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 00:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpsz6t1719180770t77mw9d
X-QQ-Originating-IP: 6kz5tm6G9cnJ0TfRXhTK7DnSoycRfo/EcoBhUe3oyDk=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Jun 2024 06:12:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18180637249425120379
Message-ID: <5AEFEE5FF2F3EDC3+57d807ce-f231-48e5-a46d-dee9f70cfa99@radxa.com>
Date: Mon, 24 Jun 2024 07:12:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: add support for Radxa ROCK Pi E v3.0 which uses
 DDR4 SDRAM
To: Dragan Simic <dsimic@manjaro.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, heiko@sntech.de, krzk@kernel.org
References: <20240623041542.50137-1-naoki@radxa.com>
 <6ee01ffc7cf4965e3c7404359d45098f@manjaro.org>
 <CALeDE9Mc3GUNnEu0EAZnpWFJhJe=k8LwvFGLFE0u2gjZLpkHTg@mail.gmail.com>
 <783a6595ac7cc97035644cc004e8e632@manjaro.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <783a6595ac7cc97035644cc004e8e632@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

Hi,

thank you for your comment!

On 6/24/24 05:22, Dragan Simic wrote:
> +Cc: heiko@sntech.de
> +Cc: krzk@kernel.org
> 
> Hello Peter and Fukaumi,
> 
> On 2024-06-23 15:08, Peter Robinson wrote:
>> On Sun, 23 Jun 2024 at 13:21, Dragan Simic <dsimic@manjaro.org> wrote:
>>> On 2024-06-23 06:15, FUKAUMI Naoki wrote:
>>> > rk3328-rock-pi-e-v3.dts is identical to rk3328-rock-pi-e.dts in
>>> > upstream. only difference between v3.0 and prior ver. is, using
>>> > rk3328-sdram-ddr4-666.dtsi instead of rk3328-sdram-ddr3-666.dtsi.
>>>
>>> I think you'll need to get the device tree resolved on the Linux
>>> kernel side first, and then imported into U-Boot following the
>>> rules of the OF_UPSTREAM approach.
>>
>> I think the question was more "given the only difference between the
>> two is the memory is there a way we can do a single U-Boot build that
>> supports both" and I think the answer to that is unfortunately no,
>> even if the DT, config etc are all the same. I would be interested if
>> you come up with a solution as I have a couple of devices like this.
> 
> Good point.  Maybe we could employ an approach similar to how the
> bad CPU cores will be disabled by U-Boot on RK3582.  Though, is it
> even possible to detect the board revision on the ROCK Pi E, e.g.
> by reading the statuses of some GPIO lines that encode the board
> revision?  I went quickly through the v3.0 schematic and haven't
> spotted anything like that.

unfortunately there is nothing which encode the board revision...
(zero3e/3w and rock3c have it. hopefully new products do the same)

as you know, I'm preparing new dts for v3 for upstream.

 
https://lore.kernel.org/linux-rockchip/20240623201415.3205-1-naoki@radxa.com/T/#t

I'll send new patch for u-boot after above patch is merged.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>>> > here is console output from ROCK Pi E v3.0:
>>> >
>>> > ```
>>> > U-Boot TPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09)
>>> > DDR4, 333MHz
>>> > BW=32 Col=10 Bk=4 BG=2 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>>> > Trying to boot from BOOTROM
>>> > Returning to boot ROM...
>>> >
>>> > U-Boot SPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09 +0900)
>>> > Trying to boot from MMC2
>>> > ```
>>> >
>>> > there is an another way which can share same u-boot-rockchip.bin
>>> > between v3 and prior, using ddr blob from Rockchip instead of TPL in
>>> > U-Boot. is it acceptable?
>>> >
>>> > Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>> > ---
>>> >  arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi |   43 +
>>> >  arch/arm/dts/rk3328-rock-pi-e-v3.dts         |  445 ++++
>>> >  arch/arm/dts/rk3328.dtsi                     | 1943 
>>> ++++++++++++++++++
>>> >  configs/rock-pi-e-v3-rk3328_defconfig        |   97 +
>>> >  4 files changed, 2528 insertions(+)
>>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
>>> >  create mode 100644 arch/arm/dts/rk3328.dtsi
>>> >  create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig
> 
> [snip]
> 
