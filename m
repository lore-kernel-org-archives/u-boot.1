Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B7C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 18:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C3088D91;
	Tue, 20 Aug 2024 20:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724178241;
	bh=WR1OSLr549xOxLBt+o5lAAJlMEYP4qrQkB1FdZlGzYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCok8B6V/UplhMaZOZvDHxx9iAYcntV1Hq/cBDqwKE3mT5Am4iMY1QM+JXCFbIpzP
	 h4NUlKBsMEyOaIMcvHkmZpbYEnYKj5tGy8t6VfwutlL5/lZxzE+5uJVjqcvlet5FA0
	 DfvnI1OXI++MHh4xBYZ0WafDiXLO9zeZ5Nzh7RKwyGukjRz8fwRp5aOqWJPCgcByLD
	 FI2AMIbpazV3f6QbhjJLOHt4cw4dru+lnybZ4F1gqi/0c6KfJBcgIFxxsxo+WAu2wD
	 8VK4YZGYZ5Zx8AeMvTlYisfa71OzPcVz4m29gY8L+V8jKz+jLZrayVcTiC3/0zXFH+
	 QuApP0E71FBaA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AFF8088A5F;
 Tue, 20 Aug 2024 20:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724178240;
 bh=WR1OSLr549xOxLBt+o5lAAJlMEYP4qrQkB1FdZlGzYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ocDtXD2WGv7+wlkmCPea01yCqOyyXLRtDJMClNkdsWZIJfkMEzIqbI7nSlD11qzVQ
 WzANOFPDhuaOGReldLRC1+Jg9hnCEE+HEG07FAJnGMn82bru4hAnODdd2ZnU+w2ICG
 QG2qygcmFT8tKeOzxtnjPM753PGEYB8f83vsFp8cSHrO2zU+LBdi5bhHQMgWeeecag
 FV4p/GfvaqfTH1xSSY7U3SkzEOp401q+JWwCEVJAoWtDdT5P0SNfwySE4ZJ8rvgi8I
 zCYRUAwOzQ/ll8Z5QXa3K8G8pD+2B3WtfLb5rPw1PGcU0Yv2MzOS1XxYhJ8wb/ncrD
 B5ynjBLWp6sOA==
Message-ID: <c6d9d714-c44c-4d97-bbea-66dc2f410b60@denx.de>
Date: Tue, 20 Aug 2024 19:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration in
 start and stop
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240726083102.380719-1-admin@hifiphile.com>
 <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
 <87le0ruqcj.fsf@baylibre.com>
 <d280f437-c873-47b7-8ff9-ebd42da7e572@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d280f437-c873-47b7-8ff9-ebd42da7e572@linaro.org>
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

On 8/20/24 7:11 PM, Caleb Connolly wrote:
> 
>> Instead, to enable usb ethernet, we should manually bind the UDC driver
>> to the usb_ether gadget.
>>
>> For example, on Khadas VIM3 board, this can be done with:
>>
>> => bind /soc/usb@ffe09000/usb@ff400000 usb_ether
> 
> It would be great if this could be done like ums where the UDC index is 
> given rather than having to figure out the magic DT path incantation :D
> 
> => ums 0 scsi 0,1,2,3,4,5

Yeah ... I wonder if we want an 'udc' command ?
