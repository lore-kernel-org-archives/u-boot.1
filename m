Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3537E748E7
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 21:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC03B8708E;
	Sat, 30 Sep 2023 23:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696110756;
	bh=ljobuY6p64nbAF5BQhmmphw8oWcdRHgdwgXAB1VHyJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbHOYraE/W5+R9sREh2Vh+wWWphSH6HMpJW/nnJbKNgeWXojj449wG5Y6EQ9NN/Pk
	 o9MK9UAFdcZwJsyyw0eh9YJp2O7fIqWfZYCjVNJmVTz5STNfNmFW7XLzx3pogG7XR3
	 4ioqI9Qhgkd92h/CvyrAgTvLANnfdSHuFWTOLoF1rQ35Lj2lLg6oXDU9tl7zVSLz9K
	 R3KHKr8fu4mrXx0cDZKTN0sj4hrvUj2KoDFk5PGnTHHxqCe77d7fMHn1QltK7Mozub
	 7qc2imnQmICHsZv3XwYKiqUJ2b2eKLhaEXonZGShfIrrVQmyeNV6XihQcFNqF818Gt
	 7lgQQrQVfI15A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2282587078;
 Sat, 30 Sep 2023 23:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696110756;
 bh=ljobuY6p64nbAF5BQhmmphw8oWcdRHgdwgXAB1VHyJ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G/ynmGuf8bIj+PMyCRFGt9kMQ4ldA01TRJ3Fjbk4tEvn4OfAWHfkw6srqZbr2+rzW
 zCmILa8NVYF3rVKQ4iJ/Oir2J+XWE6ejK99KaU8Hx3deV2n0IzPrrycCpzBTWRmXfJ
 q5PJsiapReSW1lqcUwxCLCc0Kk6YJhD2kLYxVwlUGYPFHFiFRf0MB2byL07aES6bdZ
 VbepcGwRCiGQzyTbgV7eQuHms3hz3O/+k6yGo38V5ixNRi2Rj0Q2Yz3eJuezUqxoWa
 iNKzeM75do3E1RfRFRZ5h1psl6clvvIVtQQ+oOi/03V5CsadDihtQaOnXrtKJ6AdcE
 Y2P4q7GBnTjpw==
Message-ID: <7abc460b-54c2-67b0-2f1e-e67a6878666e@denx.de>
Date: Sat, 30 Sep 2023 23:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
References: <20230901095003.352930-1-marex@denx.de>
 <20230922120012.6e24645f@xps-13> <20230927155901.10c5d520@xps-13>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230927155901.10c5d520@xps-13>
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

On 9/27/23 15:59, Miquel Raynal wrote:
> Hi Marek,

Hi,

> miquel.raynal@bootlin.com wrote on Fri, 22 Sep 2023 12:00:12 +0200:
> 
>> Hi Marek,
>>
>> I'm answering here as there is no cover letter. Just to let you know
>> I'm still concerned by the series and want to test it but did not had
>> the time to do so recently. Hopefully next week.
> 
> The series looks good to me and works as well on a Beagle Bone Black
> with no visible functional changes regarding the use of the UDC. The
> whole series is:
> 
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> By the way, following your initial series there have been three
> followup patches trying to improve a little bit the doc, one got merged
> and two others were delegated to you:
> https://patchwork.ozlabs.org/project/uboot/list/?series=367635
> 
> They are almost 2 months old now, would you mind acking or merging
> them so both your initial USB gadget rework and the additional
> (related) doc can be in the same release please?

Can you resend those and CC this mail address ?

That said, 1/2 should be in some sort of README instead, and the 'dm 
tree' command depends on CMD_DM=y .

The usb_gadget_probe_driver() is code synchronized from kernel, you 
likely want to add any such clarification to 
usb_gadget_register_driver() . That said, the 
usb_gadget_register_driver() should be reworked into some new functions, 
which takes UDC controller *udevice pointer to avoid this binding 
heuristics.
