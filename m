Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F67C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0A187DCD;
	Fri,  8 Mar 2024 11:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aEPD0pEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F8F87DCD; Fri,  8 Mar 2024 11:50:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB79987DB3
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1763=KO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709895005;
 bh=2TcmNEXbU3dMQVW7ZPA2C9KOqirFzgag44j5MyrpvRg=;
 b=aEPD0pEFq28Mf7IIHj+7gLdLZYFInqowCoW4b9Nn7iN3gbPucMuy78IKrr1dOS+tkG64Sj6r4
 35SX0bvGbXU9B2ogTfINUt70FQCHGYHYCNztCslC55F58K+VohModvX8oCSXsba8mTxAK20oCuL
 2+ccCbYe/pXUSV2SP08Ryfcp35Jn0KGzOkRGZBvL4VJlbqWrxQX4LFr1Hwin6AE8EDkRg73LYc+
 eH+KnIgxlprGy6nKCKj6LA23N3JQWyZFJvZdaqQu4N4PSWffEVlveHlcf+KwVhPydu2SSnctwIF
 CSrq9WBQIaX5caE52AV7jCR2J0iMQ0hQ5KiAV463mDFA==
Message-ID: <81676a77-2066-433a-87ae-88451dcbcb51@kwiboo.se>
Date: Fri, 8 Mar 2024 11:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: Migrate to use DM_USB_GADGET on RK3328
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Banglang
 Huang <banglang.huang@foxmail.com>, "Matwey V. Kornilov"
 <matwey.kornilov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240226230822.2430391-1-jonas@kwiboo.se>
 <20240226230822.2430391-5-jonas@kwiboo.se>
 <80cbff4f-c911-42c3-b0df-e1f6bee5bed3@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <80cbff4f-c911-42c3-b0df-e1f6bee5bed3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65eaed5b8d33672eeb7320fd
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

On 2024-03-08 10:29, Kever Yang wrote:
> 
> On 2024/2/27 07:08, Jonas Karlman wrote:
>> USB gadget is not working fully as expected on RK3328, it uses a
>> board_usb_init() function to initialize the DWC2 OTG port.
>>
>> The board_usb_init() function does not intgrate with the generic phy
>> framework and as a result the USB phy is not properly configured before
>> or after USB gadget use.
>>
>> Having both USB_DWC2 and DWC2_OTG enabled for the same board is also
>> causing some issues.
>>
>> Trying to use rockusb or ums command after usb stop result in a freeze
>> due to usb stop is putting the phy in a suspended state.
>>
>>    => usb start
>>    => usb stop
>>    => ums 0 mmc 0
>>    --> freeze due to usb phy is suspended <--
>>
>> Fix this by only using one of USB_DWC2 (host) or DWC2_OTG (peripheral)
>> depending on the most likely usage of the otg port.
>>
>> The nanopi-r2 and orangepi-r1-plus variants share OTG and power using a
>> Type-C connector, mark these boards dr_mode as peripheral, the most
>> likely usage is for recovery and image download.
>>
>> The rock64 and roc-cc currently use dr_mode as host, remove the DWC2_OTG
>> driver from these boards to ensure that the USB_DWC2 driver is used.
>>
>> The rock-pi-e board does not enable the usb20_otg node so both USB_DWC2
>> and DWC2_OTG is removed from this board.
>>
>> Enable RockUSB and UMS on all boards with a otg port in peripheral mode.
>>
>> Also with the migration to DM_USB_GADGET completed the U-Boot specific
>> change to reorder usb nodes in the device tree can be reverted.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks, I will send a v2 of this patch, that will change to use
XHCI_DWC3 for USB 3.0 host mode instead of DWC3_GENERIC to avoid
generating a build error with dependent patch [1] being rejected.

[1] https://patchwork.ozlabs.org/patch/1903946/

Regards,
Jonas

> 
> Thanks,
> - Kever

[snip]
