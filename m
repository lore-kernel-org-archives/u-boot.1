Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72C5C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30D8811DF;
	Mon,  3 Mar 2025 22:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039037;
	bh=rzc5EfJWr8yzdJdnqUVFFVxql03vTUKh9p8AOUIMu40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpGSlkSCwelE1CeFuQ4p5yztXyvQnjOrBAH1umJjs1OVGtuGIrxMvetI/HNWjGKXp
	 6KNxxZ0RGJvE9DgAn19Y1Aev4263VNLbZqljwppU8jcveeh7/V3houM0YrVGrOLJ2B
	 9qMA4018y79aTsBKC8I5qgxydgpWYNlW0YbDfetCboU/3KqYXGCv0s5BjMFDFsg/uj
	 sol5wcrtx6wYGApSmRqjUNN/7PigiYxFndg6SwgIyhoMtFgBW+945azDAAzHQunm7q
	 N+sWyfrGqTpiCQnspeNf66OcL9hUVhzX0iQcky5ow206HF/31FaPQw98xLBQ6yyXGS
	 /fX3QWX1g8Hzg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C728121A; Mon,  3 Mar 2025 22:57:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118DE80786
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fZmN2m1v"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1442510382C18; Mon,  3 Mar 2025 22:57:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rzc5EfJWr8yzdJdnqUVFFVxql03vTUKh9p8AOUIMu40=;
 b=fZmN2m1vRR39LMhnVOjFTepNRqHE5o1S+tQPE3WbzNqCvm0lohguSKD5oepM1AwBkCfpzd
 +oIB3rQEYXKnbDs0CCiaWcruSmGPnIBmQ2r3vEim6HVLqRRhF8TPoXPkQ3Is3b6HnBWhid
 Kd/l3Z845HW9wwC5MCGmLTtVGdUvHwZHn5ImNQdkrBZS9QTjvBjU5xQ6Of0GI5EF3rA5Dk
 GaxWEiqGhxPxWoX5qWCNOMGDysD2Qlez8lOkeeq0dbzZPen1UDHceG411YmUudIySkBxeF
 J8AULxd02IxFqCcAHRt+5ZUhG3llHU6IAenKAYu4/80oQJSFU10uMaQq6k+27w==
Message-ID: <3219f964-a785-435a-a296-ee6850554b80@denx.de>
Date: Mon, 3 Mar 2025 15:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>, E Shattow <lucent@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
 <CANV2PTN0w4XvmC9dt5aQcfcVS2nezShLxwSfJL1Xm-2Z-8=QLA@mail.gmail.com>
 <CANV2PTPrdF7spLK89BZ4fwnD9k8Y_9buMBNPnzJN7CDjBO6pKw@mail.gmail.com>
 <f61045a5-7faf-434e-bd80-3a8c8e49ffb3@denx.de>
 <SHXPR01MB08630123F1A65A231C610275E6C9A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SHXPR01MB08630123F1A65A231C610275E6C9A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/3/25 2:05 AM, Minda Chen wrote:
> 
> 
>>
>> On 2/21/25 8:41 AM, E Shattow wrote:
>>> On Thu, Jan 23, 2025 at 6:51 AM E Shattow <lucent@gmail.com> wrote:
>>>>
>>>> On Wed, Jan 22, 2025 at 5:01 PM Minda Chen
>> <minda.chen@starfivetech.com> wrote:
>>>>>
>>>>> Add Starfive JH7110 Cadence USB driver and related PHY driver.
>>>>> So the codes can be used in visionfive2 and star64 7110 board.
>>>>>
>>>>> The driver is almost the same with kernel driver.
>>>>>
>>>>> Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
>>>>> The code can work.
>>>>>
>>>>> The Starfive JH7110 has enable CONFIG_OF_UPSTREAM. The dts is from
>>>>> kernel
>>>>>
>>>>> - previous version
>>>>>     v1:
>> https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.19600-1-
>> minda.chen@starfivetech.com/
>>>>>     v2:
>> https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.55117-1-
>> minda.chen@starfivetech.com/
>>>>>     v3:
>> https://patchwork.ozlabs.org/project/uboot/cover/20240719013822.101374-1-
>> minda.chen@starfivetech.com/
>>>>>     v4:
>>>>> https://patchwork.ozlabs.org/project/uboot/cover/20240829013058.6178
>>>>> -1-minda.chen@starfivetech.com/
>>>>>
>>>>> - patch description.
>>>>>
>>>>> patch1: Add set phy mode function in cdns3 core driver
>>>>>           which is used by Starfive JH7110.
>>>>> patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
>>>>> patch4: Cadence USB wrapper driver.
>>>>> patch5: Get the dr mode from wrapper device node.
>>>>> patch6: Add JH7110 USB default overcurrent pin.
>>>>> patch7: config update.
>>>>> patch8: MAINTAINERS update
>>>>>
>>>>> - change:
>>>>>           v6:
>>>>>           - patch 5 format changed.
>>>>>           - split v5 patch4 to v6 patch 4 and patch 5
>>>>>           - delete v6 dts patch7 because the StarFive JH7110
>>>>>             CONFIG_OF_UPSTREAM is enbled.
>>>>>           v5:
>>>>>           - patch 2-4 format changed.
>>>>>           - For pareparing enable OF_UPSTREAM, patch4 get the dr mode
>>>>>             from parent device dts node not the cdns core device dts.
>>>>>           - patch2 add a common usb syscon setting headfile.
>>>>>           - delete v4 patch8 and the star64 dts setting can be setting
>>>>>             int star64 board dts configuration if the OF_UPSTREAM is
>>>>>             enable.
>>>>>           v4:
>>>>>           - patch 2 Add usb split setting, default set USB 2.0 only.
>>>>>           - patch 5 move to spl stage.
>>>>>           - Add a new patch 8 for star64 board usb host, vbus pin setting
>>>>>             and usb 3.0
>>>>>           v3:
>>>>>           - patch 1 Move the added code to cdns3_drd_update_mode().
>>>>>           - patch 1-4 correct the code format.(follow Rogers's comments.)
>>>>>           - patch 3 using regmap_field.
>>>>>
>>>>>           v2:
>>>>>           - patch 1 Move the added code to cdns3_core_init_role(). Must
>>>>>             set PHY mode before calling cdns3 role start function.
>>>>>           - patch 1-4 correct the code format.(follow Marek's comments.)
>>>>>           - patch 2 Add set 125M clock in PHY init function.
>>>>>           - Add new patch5.
>>>>>
>>>>>
>>>>> Minda Chen (8):
>>>>>     usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
>>>>>     phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
>>>>>     phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
>>>>>     usb: cdns: starfive: Get dr mode from wrapper device dts node
>>>>>     usb: cdns: starfive: Add cdns USB driver
>>>>>     spl: starfive: visionfive2: Disable USB overcurrent pin by default.
>>>>>     configs: starfive: Add visionfive2 cadence USB configuration
>>>>>     MAINTAINERS: Update Starfive visionfive2 maintain files.
>>>>>
>>>>>    arch/riscv/include/asm/arch-jh7110/gpio.h    |   5 +
>>>>>    board/starfive/visionfive2/MAINTAINERS       |   2 +
>>>>>    board/starfive/visionfive2/spl.c             |   3 +
>>>>>    configs/starfive_visionfive2_defconfig       |  10 +
>>>>>    drivers/phy/Kconfig                          |   1 +
>>>>>    drivers/phy/Makefile                         |   1 +
>>>>>    drivers/phy/starfive/Kconfig                 |  21 ++
>>>>>    drivers/phy/starfive/Makefile                |   7 +
>>>>>    drivers/phy/starfive/phy-jh7110-pcie.c       | 239
>> +++++++++++++++++++
>>>>>    drivers/phy/starfive/phy-jh7110-usb-syscon.h |   9 +
>>>>>    drivers/phy/starfive/phy-jh7110-usb2.c       | 162 +++++++++++++
>>>>>    drivers/usb/cdns3/Kconfig                    |   7 +
>>>>>    drivers/usb/cdns3/Makefile                   |   1 +
>>>>>    drivers/usb/cdns3/cdns3-starfive.c           | 182 ++++++++++++++
>>>>>    drivers/usb/cdns3/core.c                     |   3 +
>>>>>    drivers/usb/cdns3/drd.c                      |  14 ++
>>>>>    16 files changed, 667 insertions(+)
>>>>>    create mode 100644 drivers/phy/starfive/Kconfig
>>>>>    create mode 100644 drivers/phy/starfive/Makefile
>>>>>    create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>>>>>    create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
>>>>>    create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
>>>>>    create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>>>>>
>>>>>
>>>>> base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>
>>>> There are spelling and grammar errors in the commit messages for this
>>>> series that I would like to see corrected. I will leave that for
>>>> others doing code review to provide suggestions.
>>>>
>>>> This series can be applied as-is and does set the USB over-current
>>>> register which allows USB function in Linux -next (i.e. Pine64
>>>> Star64, Milk-V Mars). However if you want USB2.0 functionality in U-Boot
>> (i.e.
>>>> Pine64 Star64, Milk-V Mars) then it is depending on at least
>>>> dt-rebasing 6.14-rc1 which is not there yet as of this writing, and
>>>> USB3.0 then additionally
>>>> https://lore.kernel.org/linux-riscv/20250102183746.411526-1-e@freeshe
>>>> ll.de series to reach dt-rebasing which is not expected before the
>>>> close of Linux 6.14 merge window.
>>>>
>>>> Without regard to code quality or spelling and grammar mistakes, I
>>>> have tested this series both with and without the anticipated changes
>>>> from upstream Linux. All features are working to the extent that I
>>>> would expect. For the series:
>>>>
>>>> Tested-by: E Shattow <lucent@gmail.com>
>>>
>>> Can someone take this patch series? Else does it need another revision
>>> from Minda? -E
>>
>> There is a bit of feedback on 5/8 , so yes, V7 please. Then I can take the USB
>> parts.
> I will send v7 in this week

Thank you
