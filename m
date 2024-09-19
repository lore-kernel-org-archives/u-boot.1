Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7840BCF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C3489196;
	Thu, 19 Sep 2024 16:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=agner.ch header.i=@agner.ch header.b="MVstqjId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01AEE89189; Thu, 19 Sep 2024 16:01:48 +0200 (CEST)
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154BD89197
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=stefan@agner.ch
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 555FA5CA5D7;
 Thu, 19 Sep 2024 16:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1726754504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mp2WfBSR6Rh1lJBK9Ye6zJH/hRDYmsnmUR0RC4cQQ6U=;
 b=MVstqjIdpEaRQ5DcJk6m/UbJlZne5Yj8V0T/M/OqULyD1gfD2bpigwD3D1glsMU1TFCBos
 FcVulrH9v4aJddfWQl1A19qCfBETmL92eOot3UGSyRKKlKlFoSjgvquZywTDQB8h4nGy2k
 N2FXNLeNdUWMmvo/a/5nTzHJExXOezs=
MIME-Version: 1.0
Date: Thu, 19 Sep 2024 16:01:44 +0200
From: Stefan Agner <stefan@agner.ch>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, Dmitry Malkin <dmitry@bedrocksystems.com>, Thomas
 Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 =?UTF-8?Q?Jan_=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
Subject: Re: [PATCH v4 0/6] rpi5: initial support
In-Reply-To: <B1136352-B9D3-4990-B5E5-7C318809C957@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
 <9943877347134e40cee8c0d9cc7f641c@agner.ch>
 <B1136352-B9D3-4990-B5E5-7C318809C957@suse.de>
Message-ID: <1c9ebab90accb47abbd7ef2205c6b409@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
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

Hi Ivan,

Thanks for the quick response!

On 2024-09-19 11:52, Ivan T. Ivanov wrote:
> Hi Stefan,
> 
>> On 19 Sep 2024, at 12:36, Stefan Agner <stefan@agner.ch> wrote:
>> 
>> Hi Ivan,
>> 
>> I am looking into enabling NVMe boot support using U-Boot on Raspberry
>> Pi 5. Which brings me to some questions wrt PCIe support (see below).
>> 
>> On 2024-01-10 13:29, Ivan T. Ivanov wrote:
>>> 
> 
> 
>>> * I am dropping PCIe patch for now. I made some progress on porting changes
>>>  from vendor Linux tree to U-Boot. Unfortunatly testing it is little bit
>>>  tricky. They are many devices behind PCIe, but more or less all of them
>>>  requires missing either "reset-controller" or "clock-controller" or
>>>  "pin-controller" drivers. I was able to probe "cdns,macb" device, but
>>>  access to ethernet PHY over MDIO bus is stucking. Then I ported
>>>  "raspberrypi,rp1-adc" driver from vendor Linux tree, but it requires
>>>  missing clock. And on top of that machine that I used for developing this
>>>  crashed and I lost my PCIe changes :-|. Anyway.
>> 
>> Have you tried using a M.2 HAT? This likely won't require much in terms
>> of enabling the device.
>> 
>> You write that you made some progress, is that compared to v3? Do you
>> mind sharing the latest version of your patches?
> 
> 
> No further progress on PCIe for U-Boot from my side was made, sorry.
> 

So v3 the patch you've shared in v3 is your latest state? I was
wondering since you wrote in this v4 patch set "I made some progress on
porting changes
 from vendor Linux tree to U-Boot."...


> Stan is working on adding support for 2712 PCIe in Linux [1]. Perhaps
> once this is complete we can work on adding U-Boot support for the same,
> unless someone don’t beat us, of course. 

Hm, it seems the link did not make it. I guess you meant to link this
patch set [1]

--
Stefan

[1]
https://lore.kernel.org/lkml/20240910151845.17308-1-svarbanov@suse.de/T/

> 
> Regards,
> Ivan
