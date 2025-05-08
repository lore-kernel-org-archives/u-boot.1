Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93640C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 23:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE0E8269F;
	Fri,  9 May 2025 01:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B478283E; Fri,  9 May 2025 01:38:34 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6294D806D8
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 01:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip4t1746747493t1dff9b9a
X-QQ-Originating-IP: Y+zDUJZ0NLPI1GZ8Xc8YAmwwWpOkX85WYowDiBoIhxo=
Received: from [IPV6:240f:10b:7440:1:a1e5:ffb0 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 May 2025 07:38:07 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14983227706439958645
Message-ID: <0CABE58EF9324D3C+977e581c-dcd7-4b33-982a-179a22c2b46f@radxa.com>
Date: Fri, 9 May 2025 08:38:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] rockchip: Add boot from USB OTG port
To: Kever Yang <kever.yang@rock-chips.com>,
 Arnaud Patard <arnaud.patard@collabora.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, jonas@kwiboo.se,
 quentin.schulz@cherry.de, jagan@amarulasolutions.com, dsimic@manjaro.org,
 pbrobinson@gmail.com, liujianfeng1994@gmail.com, macromorgan@hotmail.com,
 michal.simek@amd.com
References: <20250211053340.92919-1-naoki@radxa.com>
 <40162793-5cf1-4e29-8621-b5863e8cdeae@rock-chips.com>
 <f7d10c18af03f3879a765f190614dbb17d4b300a.camel@collabora.com>
 <a67949b4-227c-49e1-92d8-ef18f8bd0b42@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <a67949b4-227c-49e1-92d8-ef18f8bd0b42@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OfaQ+Y0DiXSP+C2g3Oet4errOKwpL7GNx412WzCTjgqm16uyO6kjc+5E
 vBEC/tzoRvwUfyyzUuLqO88SAPZ3g04i6ffSApZN482j/SYHp7sh1/qe4UGQuL1fT4ZEHdP
 ZRBayPNm83ujZR8W+Ti0osrn4wHqYtB3FgBGInMYamnnIv2eMVZNwDQkbIuDBuIzItYSw9X
 gEaqVZwVLaFmkEHOWKTYp2NOzvGXX0jlyB+alfROkHa499mltavEIDxHjiDHg27MranmEp7
 nyeNkq0Ze73aKGvmAPPfvbeQppqOfDMFvrhftkkpXHlXTLUz4SDhSKdbzP2gZ/GXWpX7HH8
 YaQsXscvzwb9PZlWJVMzI5xPAcQcMPTCusudb+3lN43Z/ueYnmWcD0lei1FkaDbtQV2+uPr
 hdJRt+Do/FxFsSAqyJCnoftDJ1Q8NtVrrOSG8CSSnecLmSo8gEOepL8F+01pXxNKjEHpefm
 V1r480kxgZOuS1DfKQZ61oiAqS33ONGZ4Crudpmf4LTw7eec49Z4ILFZtZEMthm6Fe9x+Tb
 MlJBVUfl9blbxtOlL+BjXY+KAh8gpkhz6d/eGjEqr4SwTIZVedptvioShNGJVxNGDdi7ztt
 nam85bStqtaJBysM2DMji6841QYuNoea2LfTWM5yQJNldxlvkqVp90U9ubrVZNW2t0NM8en
 TcxiMEc6wFp3jyn5dabHduv6AzZHTNfm+xYBVpFRCqQC04JqHgX/tk2LkvuZhfXu/kcojRO
 pmESEqo/+xWM2s4ss0z44WbkY6lR+evwUpwzxj3Q541kUPeh4TN+QsM6w3NEFx8bnPyijSr
 FAOF4Q1OZJ6yl5wT4DNd4SO8QYXlP/fONhnUVPmsMGBVLMaXUqljWfhvJ+fNNqYoKPomP3C
 nimdpvPIOuEPtHOknSma9tgfAvZY1MMFIfOFYpjetTQ2Zn2dt5mxGYkoLg+RaW8vhqtnmjI
 DEP+ZcsLkueBqoq+pZ5yEuafLdVZ1GDJA7SzUZdKalMjftREH2NJrhkV08cmesrkmYGZ48R
 U+I4E6w7wG2yNr/bjT
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
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

Hi Kever Yang,

On 5/8/25 12:43, Kever Yang wrote:
> Hi Arnaud,
> 
> On 2025/5/7 23:31, Arnaud Patard wrote:
>> Hi,
>>
>> On Tue, 2025-05-06 at 15:53 +0800, Kever Yang wrote:
>>> Hi Naoki,
>>>
>>> On 2025/2/11 13:33, FUKAUMI Naoki wrote:
>>>> This patch series adds the ability to boot from the USB OTG port to
>>>> the RK3588, RK3568, RK3566, RK3399, RK3328, and RK3308.
>>>>
>>>> Use rkflashtool[1] or rkusbboot[2]
>>> Does these two tool have the same functionality? I don't know the
>>> second
>>> one :(
>>>
>>> And I know there is another tool named rkdeveloptool from rockchip.
>>>
>>>>    to download TPL and SPL from
>>>> MASKROM mode, and dfu-util to download U-Boot from DFU mode.
>>> What's the main target for this patchset, boot from usb with ramboot
>>> support and without any eMMC/SD/SPI driver?
>>>
>> I can't talk for Naoki, but my use case is to test easily u-boot on my
>> rockchip platforms without having to flash u-boot or to have some
>> storage.
> 
> Yes, I agree the usb boot+RAM boot can help u-boot developers.
> 
> But this function can be done directly in BootRom mode with rockusb 
> protocol;
> 
> or add support for it in U-Boot Proper gadget(rockusb or DFU).

Does this mean I should use rockusb or DFU on U-Boot to test the new U-Boot?

>>> I would prefer to keep using one tool instead of two or more tools,
>>> so I
>>> don't think
>>>
>>> enable DFU in SPL is a good idea, using rockusb in SPL is better
>>> here.
>> To test u-boot, I'd like to use snagflash/snagboot as it's not rockchip
>> specific.
> 
> Two more tools other than rkdeveloptool/rkflashtool/rkusbtool/rockusb :(
> 
> 
>>   So, this means adding support for maskrom (which I've already
>> written) and rockusb protocols to it. With DFU in SPL support in u-
>> boot, this would mean nothing to do as the support for DFU is already
>> in snagboot/snagflash.
> 
> I understand your requirement, but you didn't say why you need SPL DFU.
> 
> There are two modes for usb download in rockchip platform:
> 
> - Maskrom mode (in bootRom), may have speed limit due to bootRom driver 
> setting,
> 
>      for download bootloader including U-Boot which size is not big;
> 
> - Loader mode(in U-Boot), all the speed including CPU, eMMC has promote 
> to performance mode,
> 
>      for download all the big size image including system and userdata.
> 
> Of cause we can add any function to the SPL, and it's simple because it 
> already in U-Boot,
> 
> but do we really need it for all the user and product?
> 
> We should keep the SPL simple and fast, and get into U-Boot proper 
> quickly with full function.

I agree that SPL should be simple and require fewer tools.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thank,
> - Kever
>>
>> Arnaud
>>
>>
> 

