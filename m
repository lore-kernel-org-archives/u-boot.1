Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DCEC2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 18:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11402805CD;
	Sat, 16 Sep 2023 20:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694888926;
	bh=8pWsYorJg+Bl6wXzk23rRl/ssYhRJNXwArkPPDQUJj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHGTJXbda2jaXnE1GWB1WciTOtJTk9f1mGqwnHauXeEp5fNvUBWNbT215iglvir3n
	 2n1e2bJlgw1aL8p0nxP93qbZjnXT/0Mav2Mh1bWTrf9JQ9Hps4djUAFgGCxP6m70zP
	 p0yfMLxOmOh8EnTSWqS0n/dzu47ul6MjtQ5P7yc7TjxM4/7ibjMu9blDzGKnsKb/Fa
	 kCHuttF60qPNNVqHwwKxWhCnK26wisTTtkJ4a4BvG121TkefNBZMSLSTmPfvZ0xZMN
	 Ovb8C8KODx38+ktwTgpb24rFGbMqGL51GFs8Z6FkOZzdGwsLWtJzFOz7y/nRvuk+7S
	 Rul10NH2alfAQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D9640803AC;
 Sat, 16 Sep 2023 20:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694888924;
 bh=8pWsYorJg+Bl6wXzk23rRl/ssYhRJNXwArkPPDQUJj4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tReuD/E/tHyoE6j81UEcrb+LnCDA+icajYN5sxYN+hPImcK2yIhah6ESXgUbC6fT4
 gcCyzFFalsh+gVoDnLcczsPwXXzto0yZI2CcJ5MQnkh6GdwULUWHP1q5Bdn9J54NBs
 TGwgDsKxPITDUZfbI50qpkQyWvC1U2SdwJPmDJ5epWPpZNmqy4mtYV8SjnnqH2m/SN
 tzolFkznwJBYJ8OtjZIpijB/6hZZmLMF7iVvLFhmj1QhV3ANMoNN16yLBU2ZHawqlP
 td0ebSBR6MXvaKBc89wVTZ0NX4YDvcKDEY6glgKbp+Y5BkwgNaTe5DS7eXBEPzg/7o
 ZdCbkbVCsTzQA==
Message-ID: <aefff609-c793-0513-ca34-29abbb798f4b@denx.de>
Date: Sat, 16 Sep 2023 20:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Aw: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Language: en-US
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20230820160004.44880-1-linux@fw-web.de>
 <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
 <f00dad5e-bbe7-7a4d-e955-ce317cefb932@denx.de>
 <E81B855A-F7F8-4405-B4A7-8261D55C075D@public-files.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <E81B855A-F7F8-4405-B4A7-8261D55C075D@public-files.de>
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

On 9/16/23 18:45, Frank Wunderlich wrote:
> Am 16. September 2023 18:07:44 MESZ schrieb Marek Vasut <marex@denx.de>:
>> On 9/16/23 16:18, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> just a friedly reminder. would be great if it can be merged in next uboot-version.
>>
>> +CC Tom
>>
>>> regards Frank
>>>
>>>
>>>> Gesendet: Sonntag, 20. August 2023 um 18:00 Uhr
>>>> Von: "Frank Wunderlich" <linux@fw-web.de>
>>>> An: u-boot@lists.denx.de
>>>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <kever.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>
>>>> Betreff: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>>>>
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> Add Bananapi R2 Pro board.
>>>>
>>>> Till now evb dts could be used, but iodomain is different
>>>> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
>>>> and with iodomain driver this can cause hardware fault.
>>>>
>>>> Devicetree in mainline-Linux:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>
>> What would be real helpful is a commit ID from which the DT was copied , so it can be easily updated in the future.
> 
> It is no plain copy...i removed parts not relevant for uboot now (from current linux version).

Ouch, please don't do that. Instead, if you really do need to drop some 
nodes from U-Boot control DT, say board.dts, introduce new file called 
board-u-boot.dtsi and add '/delete-node/ &the_node_to_remove;' lines to 
remove nodes while DTC is processing the DT into .dtb .

This way, the imported board.dts from Linux can be later synchronized 
with newer version of Linux DT, and the U-Boot specific changes are in a 
separate file.

The U-Boot build system will first concatenate the files, i.e. cat 
board.dts board-u-boot.dtsi > temp.dts and then run DTC on the temp.dts 
, so whatever changes you do in the board-u-boot.dtsi will be processed 
after the original board.dts is processed by DTC (DTC processes the 
input DTS in order).

> E.g. switch driver is currently bundled in mtk ethernet driver and using different devicetree structure than linux dsa driver. We have to separate it before we can use it on r2pro. But this will take some time...also pcie(-phy) does not have a driver yet,so before adding dead code i dropped these parts for now.

See above, that should do the trick.
