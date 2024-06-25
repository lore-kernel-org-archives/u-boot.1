Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B699C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 06:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8DF88356;
	Tue, 25 Jun 2024 08:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="vFPbyvfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12028841D; Tue, 25 Jun 2024 08:38:58 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B2987C40
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 08:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719297536; bh=6Ek/4USYiEyfUoqKiif5UpCqzA4xVz0eq7Ld400vcLo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vFPbyvfWjlY2oxEBn8xv5mqszpLTqEjNlWBDbo9j9HKkxnAqmyGF3LAmPmmWyvNBA
 b0V4ECgDuorabJ7yfA1lLgg2Kk8NKfkGJ+IEifrMmbrowGqDtrAkGdibA/pQ0iNXPb
 WGjIZsvLlB+fsQ+SBf7hW5BBr9FXRxqBMNdI2LH85TnYnE/S4e51AloBLNFpFtVHxl
 Lz3wQUjE3E4Q9qposSGM9TxuPZebbll5LzVEPRuA6mp+Z+/5jhTD5E5CvecTT8Sa4o
 vP0qXTGL9tJRC7hdui32XtRCb9cctX9P1hVT3pT7BH78ryzETfPInZcJwbz2L5hHj4
 fxSkzZJTQ6xIA==
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2F73F40306;
 Tue, 25 Jun 2024 08:38:56 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 2BCB6100075;
 Tue, 25 Jun 2024 08:38:56 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id F17BA4007F;
 Tue, 25 Jun 2024 08:38:54 +0200 (CEST)
Message-ID: <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
Date: Tue, 25 Jun 2024 08:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (41)
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

Hi Quentin,

Thanks for reviewing my patches.

Le 24/06/2024 à 15:08, Quentin Schulz a écrit :
> [...]
>
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
>> index 93e83661ce..b30d51731f 100644
>> --- a/drivers/net/rtl8169.c
>> +++ b/drivers/net/rtl8169.c
>> @@ -1091,6 +1091,16 @@ static int rtl8169_eth_probe(struct udevice *dev)
>>       return 0;
>>   }
>>   +static int rtl8169_eth_bind(struct udevice *dev)
>> +{
>> +    static int card_number;
>> +    char name[16];
>> +
>> +    sprintf(name, "RTL8169#%u", card_number++);
>> +
>> +    return device_set_name(dev, name);
>> +}
>> +
>
> I don't think we can guarantee bind order so this may not be stable 
> over time.
>
> I'm wondering if there isn't a way to use the "ethernet" (ethernet0, 
> ethernet1) alias in DT instead?

Actually the ethernet interfaces are not declared in the device tree, 
only PCI buses are (at least on this Nanopi board).
The ethernet interfaces are only detected when running "pci enum".

Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
reflecting the PCI region address (so it is unique and stable). What do 
you think?

Cheers,
Etienne


-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431

