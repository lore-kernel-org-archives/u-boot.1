Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC006C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559FF875E3;
	Sat,  9 Dec 2023 23:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702159547;
	bh=tT5fx3VFhV41AZ7lZwdlzWqikUYcYUCkyKCrnDVEw10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5glLCkhqwVYitS0HoE1c7N0ueQNufLVGnSC5sCxY2YIWCzN/dnZToXxvsLJxzyJL
	 jnT9b5RvJwoIy8AVZlQSoAjxL+Lf79VDz/TwW+mJDZ87ODWIZqxF/0MD7D/dr6X00B
	 3lBvj31zpr722HCbcEJUZ3zEw70OZlYDZKbQpzUpqXqMCNRsDS67kd6TxlXfWnP/D7
	 L4uca6LJKQyMNhwSp6QlG/tRKNnscZjOt+DJKGHgpvqoOScXITSE7oVaTJrX5JSbo7
	 /euyYwaoxbis5uAWqU98NA6kyPfIJJCq8HSFE3psFJHhciY9t2BzifEWQiErGmRhSm
	 JwR/vrts088YQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AD4E2874CA;
 Sat,  9 Dec 2023 23:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702159546;
 bh=tT5fx3VFhV41AZ7lZwdlzWqikUYcYUCkyKCrnDVEw10=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dRXEFh92QvQzoOLgAmkby2CEX3wIexR79IKPkA9B29Af8aUBD7p9RiUsWxenqmBjI
 n++KmH1FP4iSSGGPsj99lBvJ31YsmcqVVXSX4M+q6/ELJcRqG6J/gi79ahgGKQ4JFf
 QNKQW4Gdj6YjQ2+qjFOvqt+jYoj7ElDaqwLWo1dEJMciZyamRmFyStYbMmRGPWfNel
 596UW1blDbEPtMyZi4kODLQxE90DNKNEV1qb6bM0vf98aVKyrQna08vtsSbi2kt2DY
 cLSD3kf34vn1EUyO5tJe+p9jA7O+uGFUNKUdGS6Uzw7kaFFWbhwiFRPHnjq6mRkbgE
 0fw9eZDzNsB1A==
Message-ID: <e9e44210-0330-4ecd-96e1-629ef519202d@denx.de>
Date: Sat, 9 Dec 2023 23:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
To: Shantur Rathore <i@shantur.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
 <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
 <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
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

On 12/9/23 18:57, Shantur Rathore wrote:
> Hi Marek,
> 
> On Sat, Dec 9, 2023 at 5:31 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 12/8/23 01:09, Shantur Rathore wrote:
>>> USB port regulators should be controlled by phys
>>
>> PHYs
>>
>>> so we remove always-on property and let phy manage the
>>> regulator.
>>>
>>> Typec port has misconfugred
>>
>> misconfigured (typo)
> 
> Thanks will fix both typos in v3
> 
>>
>>> phy-supply in upstream and
>>> now that we are removing always-on, we need to fix the
>>> phy-supply until its fixed upstream.
>>
>> Where is the upstream Linux kernel patch ?
>> Was it submitted already ?
>>
> 
> No, there is no patch yet for this in Linux upstream.

Why not ? I would expect the fix should be consistent between both 
U-Boot and Linux .
