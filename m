Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A07C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 05:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4996481B42;
	Sun, 23 Mar 2025 06:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UMu8jyd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476EB81BC0; Sun, 23 Mar 2025 06:09:10 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F67780F0E
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 06:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZL43M176Zz9sby;
 Sun, 23 Mar 2025 06:09:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742706543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Nb4+dgIY5o2jLwurQl4RU4VjzHewYCZLHzdk7OStP8=;
 b=UMu8jyd2LDAIMhQ0OMW2dLecqUWpQ5D30wLH33/1HylUqcpNepWLe064SUMH4dWr5JNjau
 GKK+YNxzyuD+QmPoSbXoPrNuP5o5w/lS0pWus1PDPhJQB2RSkaBvQCicIB2AU8lkNn72M9
 M1R6/4ZCb8nn7ct1sECJYwnrQL7+YqEPP30wanN4hq56e1UNFojx73ZxrWgoLatjuPeCvL
 3235lyuikBuq9lMXSY9gT/+4btgrZdAMzDMVd/JjYwZAeqnPrNcFb0VjylxV5/GSUFjtb8
 1DVuPO9QlrZrgFqple1bbKaFlPzG8AHK85CR1ha1Xtll0dujkqTr0zfOtpSyCg==
Message-ID: <fca93a21-adc9-4261-9756-e88fcf5fc5ce@mailbox.org>
Date: Sun, 23 Mar 2025 06:09:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V3 5/6] imx: imx8: Imply CPU_IMX by default
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com,
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Enrico Leto <enrico.leto@siemens.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-6-aford173@gmail.com>
 <e4d40a3f-d082-4144-8947-5fb523eeada8@mailbox.org>
 <CAHCN7xLJ0dB3Du62A5pOrAYFjSXnaf=CG-SdLKn4Kfi5csUXpw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xLJ0dB3Du62A5pOrAYFjSXnaf=CG-SdLKn4Kfi5csUXpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e5557f68ac81bb59113
X-MBO-RS-META: mgqi36kndhbrcz89ikuhrf6cqsj8ps4t
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

On 3/23/25 1:00 AM, Adam Ford wrote:
> On Sat, Mar 22, 2025 at 6:31 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/22/25 7:38 PM, Adam Ford wrote:
>>> The imx8_cpu driver is a CPU Driver that supports the i.MX8Q
>>> family. When it is enabled, it acts as an alternative to
>>> arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
>>> model where cpu.c does not.  Imply this newer driver by default.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>>    arch/arm/mach-imx/imx8/Kconfig | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
>>> index 9a43beda6fa..257c14e61b6 100644
>>> --- a/arch/arm/mach-imx/imx8/Kconfig
>>> +++ b/arch/arm/mach-imx/imx8/Kconfig
>>> @@ -9,6 +9,8 @@ config AHAB_BOOT
>>>    config IMX8
>>>        bool
>>>        select HAS_CAAM
>>> +     imply CPU
>>> +     imply CPU_IMX
>> Shouldn't CPU_IMX select CPU ?
> 
> It does not currently.  Right now, it depends on CPU being set.  There
> is another Kconfig option for CPU_ARMV8 that also depends on CPU, and
> I would prefer not to change both of them.
Hum, OK, thanks for clarifying.
