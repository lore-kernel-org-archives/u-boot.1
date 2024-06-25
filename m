Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F2C30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02137884B2;
	Tue, 25 Jun 2024 10:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ouuDfN8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDDF884BA; Tue, 25 Jun 2024 10:30:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34D58844C
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 10:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0f7a=N3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719304197;
 bh=Dqkp6fYKbsVgRQ9VJxKWoAP/SgSajadtGgh0n2bboHQ=;
 b=ouuDfN8Bf+IIXxw03FJC9KVU3pP+OMVy5xqnKL9lguLZhy9oo9wVLecX1hV2t/G9CJ3okuVBO
 Pk5VwcuZEjqvd5BwZu3XpSE2+yPPFK5GnQBmQI0m3c5FQSYI27CDc/or8+exkziTWh/PH0Wg4Es
 USKyuv2OiKJevDn0qMuJdWeIOj71XIf0c10V33qkNBx/Vf1n6Rs63VnfoyiJ4QrJiarHDJQfCd3
 bOTbNumCjrt+jofw9EK1jCrWqSaD37ATWzrogbR57XHflS4MXKA6ESJyiceBsSFGsT/jdSJA6U4
 oJ63X82uPrsFCjbWgR2P6M88L5LE664V0WbeFAseUMEA==
Message-ID: <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se>
Date: Tue, 25 Jun 2024 10:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
To: "=?UTF-8?Q?Etienne_Dubl=C3=A9?=" <etienne.duble@imag.fr>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, joe hershberger <joe.hershberger@ni.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, Ramon Fried <rfried.dev@gmail.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, "u-boot"
 <u-boot@lists.denx.de>
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
 <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667a8001d393be1057f6cdc9
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

Hi Etienne,

On 2024-06-25 08:47, Etienne Dublé wrote:
> Hi Quentin,
> 
> Le 24/06/2024 à 15:15, Quentin Schulz a écrit :
>> Hi Etienne,
>>
>> On 6/24/24 2:40 PM, ETIENNE DUBLE wrote:
>>> One of the PCI ranges was wrong in this device tree.
>>> When testing with a FriendlyElec Nanopi R5C board, the
>>> 2nd ethernet interface (labelled "wan") was not working
>>> in u-boot because of that.
>>>
>>> With the correct value (found in FriendlyElec's downstream
>>> u-boot repository), this 2nd ethernet interface now works.
>>>
>>> Signed-off-by: Etienne Dublé <etienne.duble@imag.fr>
>>> ---
>>>
>>>   dts/upstream/src/arm64/rockchip/rk3568.dtsi | 2 +-
>>
>> dts/upstream is only for patches coming from **merged** Linux kernel 
>> (i.e. releases or -rc releases or master branch from Linus Torvalds).
>>
>> We do not accept U-Boot-only patches in dts/upstream.
>>
>> Please submit the patch to the Linux kernel first and it will 
>> eventually make it to that directory either via a 
>> dts/update-dts-subtree.sh pull or dts/update-dts-subtree.sh pick. 
>> Depending on maintainer's opinion, fixing the range in 
>> arch/arm/dts/rk3568-u-boot.dtsi could be an option, but we really need 
>> the patch sent to upstream Linux kernel community first.
>>
>> c.f. https://www.kernel.org/doc/html/v6.5/process/submitting-patches.html
> 
> I see, I will look at it.
> In version 2 of the series I will remove this second patch and just 
> mention that we are waiting for this problem to be fixed upstream, in 
> the cover letter.

I do not understand the need for such/this patch. The changed address is
the internal io address that is shared with the pci controller and
devices.

Do you have any issue in linux or is it only in U-Boot?, I suspect this
change is only a workaround to an issue only found in U-Boot.

The rtl8169 driver or pci system of U-Boot may be of fault and should
probably be fixed instead of changing io addresses to work around issues
in software. E.g rtl8169 has a static ioaddr that is shared between all
drivers, something that may cause issues.

Regards,
Jonas

> 
> Cheers,
> Etienne
> 

