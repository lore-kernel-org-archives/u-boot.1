Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA771C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 03:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D4789115;
	Fri, 26 Apr 2024 05:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714103700;
	bh=3KhkjoqHI3Sy8tK1dZ2eQf8fpEfQAIg54JsDAnwUDss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0ZEa4aD41GRN5+DcZ2QHzJv8FOS63chzS7Ry2KJYIKp3hadB8+VlDOCyYIplD0kf
	 7rY+c2gXy7t6/ZB2HI4irB4LK199lgWSX0kOCF63t0GiVijR+FggZJApvTm32djZ6V
	 V+3tef2jc9wIIoIZNG1qRH75U1Tiys6JX4giDIB1nfLX0DjCNQRH7QtvaPRfz5Qk5P
	 IsYvyv1P26kISI+teKVy8wE1hTwzjtFhXgAs77cXf/df7sqAFk59goo9pYXNr0JBwr
	 R1joBv5+yHFPa1s+DZLyjYe8WM8sMum3VEZE+etPWGLK8V7lp3UmsPM0VYg5g+cAIb
	 O1bz2wWK5DPfA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ECCCF89116;
 Fri, 26 Apr 2024 05:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714103699;
 bh=3KhkjoqHI3Sy8tK1dZ2eQf8fpEfQAIg54JsDAnwUDss=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QYmQtsERWuerL+XOhpqdo/D7cBKNXNC9/n9O2b3RxMOr0KWe4rXp1NRDxUTl3DorB
 abUCxTD3ICGuA4ZA6A+h8hvEavPEuaEnk7g1lAA/RNO894uZ2e/98/77dhV4QMbAkN
 bADMUzDpigPhZS+LAWOgJBwToPCPq4eqMg7JEBKqApzunQM3EmAU/0nURswHyeasxP
 1CU9gLCwc9jfSieQsIDBTvjXewRr4UTNFOHzi02QqHZtduUuea5Sat/3NLCYLnAUmM
 cg4WZi4sBW/TZ/PpjVsSugY4E2Aqs7h0dMOCCxhlyuM7QhULmA7I4QDcAr+s5lYjGv
 43httCWgmqBWA==
Message-ID: <245c3907-b72b-42fc-97ec-d4d70afa35aa@denx.de>
Date: Fri, 26 Apr 2024 01:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
 <CAJ+vNU1fvffzukqr0-u92EyLqXHiwRkvs3CA+1K_A+9p6xrgUg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU1fvffzukqr0-u92EyLqXHiwRkvs3CA+1K_A+9p6xrgUg@mail.gmail.com>
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

On 4/25/24 10:34 PM, Tim Harvey wrote:
> On Tue, Apr 23, 2024 at 11:33 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Rework the flash.bin image generation such that it uses the new binman
>> nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
>> order using plain binman, without any workarounds or sections assembled
>> in special DT node order.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> WARNING: This is very likely to break corner case uses, so please do
>>           test this on your platform.
>> NOTE: This also opens the implementation for proper CST signing etype,
>>        the CST signing would look similar to nxp-imx8mimage section, and
>>        it would likely wrap the whole topmost section {} in the binman
>>        node.
> 
> Marek,
> 
> Thanks - this is neat and I look forward to seeing a CST signing etype!

The whole collected batch of patches is here:

https://source.denx.de/u-boot/custodians/u-boot-usb/-/commits/test-cst?ref_type=heads

I believe this will need tweaking, we will probably need more DT 
properties to configure the content of the CST config file more 
precisely. But this could be a start.
