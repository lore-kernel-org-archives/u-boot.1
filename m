Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF32FD29C28
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 13:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD088397A;
	Mon, 19 Jan 2026 14:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C2083981; Mon, 19 Jan 2026 14:22:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A567783956
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 14:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0739D497;
 Mon, 19 Jan 2026 05:22:41 -0800 (PST)
Received: from [10.57.8.47] (unknown [10.57.8.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613E13F740;
 Mon, 19 Jan 2026 05:22:43 -0800 (PST)
Message-ID: <ddb336ba-61eb-4d7c-b70c-9c2b050dec24@arm.com>
Date: Mon, 19 Jan 2026 13:22:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from
 integer without a cast
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Richard GENOUD <richard.genoud@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-3-richard.genoud@bootlin.com>
 <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
 <2a1824b5-e514-4eb0-8e08-2d4307f86c44@bootlin.com>
 <CAOf5uwkHyKJ_x74v4uXaexWMvM0e=0UXtxhCwaLOa5p7NxLLMw@mail.gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAOf5uwkHyKJ_x74v4uXaexWMvM0e=0UXtxhCwaLOa5p7NxLLMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Michael,

On 19/01/2026 13:14, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Mon, Jan 19, 2026 at 2:13 PM Richard GENOUD
> <richard.genoud@bootlin.com> wrote:
>>
>> Hi,
>> Le 19/01/2026 à 12:12, Andre Przywara a écrit :

....

>>>
>>> The rest looks fine, thanks for adding that function.
>> Indeed, I can drop it and add a comment to warn future users in this driver.
>>
>> @Michael, do you want me to do a v3, or just apply this v2 and I'll send
>> a fix? (or you just remove those lines when you apply the patch?)
>>
> 
> No, I will do by myself, I will send a new pull request by today

So are you sure that the series is really ready for merging? I think you 
mentioned you wanted to apply the patches that have been reviewed, by I 
see only the first half of them having tags. I was about to have a look 
at the rest, but got tied up lately in other things, so didn't find time 
yet.

So are you sure that the patches are fine, given that nobody has looked 
at most of them? Or did you do a review, just didn't reply on the list?

Cheers,
Andre


> 
> Michael
> 
