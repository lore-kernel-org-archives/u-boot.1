Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122BEC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981F688629;
	Sun, 30 Jun 2024 07:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725045;
	bh=OpMbvTt4JFqxcl2NM3gXuoKTcNiA+iqub+Ats+CcuV0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4+hl/JoVNryUgaIG7Fm7GJfPSGubrmTPgYeqaWxYaki3gkvkoZcVcUkekUZyl/L0
	 KRuzPIHDytMY2+INM391VG7gw3Ax2xO6HG5pg4Z3Z32QMZi9/o4/hlzkikLntN6rOg
	 eo2S3vVBPezc20iw65cws7VR2FHInzuEkOTIHzjcquIk85+y0rN+6bvk9z72wtqQf3
	 VwyeyrfHsdFlxx532dvsn2vJu9eR8XZ6jXd4MgDnJGWMk6KMGncIYlAKJk6PwqTvEZ
	 ooOy5ZSVU3yZWga/iu8tb0xQZXkP2JfAypkHARwRLpmY9zeiicQVGiFvUouN0+qfKV
	 HXQuEwRriLvCw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6A3D788617;
 Sun, 30 Jun 2024 07:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725043;
 bh=OpMbvTt4JFqxcl2NM3gXuoKTcNiA+iqub+Ats+CcuV0=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=p9voqsojkgBAJBsTAXosCX/B2h6cdSKqZWVCeKsyITNsA+eZdonF8YTnLVzYBI3YX
 eCPQD9kXRk6r6cNSs+2pCZsHF85OfSA5pBkRJlnPrA+RnDtmK4g9xgu6j3pax/tkn0
 lmIar8o6vHBDoyWNwXvlOMv94ytt0h4XjLlso6NOLacxNuy5s0/YlbRhKhK0XSknuS
 f2gqqHslm4sZJMWyKoE54jHi3W/dy6h3nnVuDD8EK1wmYw8m0X1NwceY/ATC4DqtOM
 FWihY8ZIe6oGEKvVlFu2qoIegg5cUePf/ZmM1/nX6yO4hV3v0cTjwUGtNiwOYo5ID2
 5h1yg6l5DOEMA==
Message-ID: <f873b919-a4de-4d06-9f6c-b964cf0699b7@denx.de>
Date: Sun, 30 Jun 2024 04:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
 <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
 <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
Content-Language: en-US
In-Reply-To: <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
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

On 6/28/24 10:27 AM, Quentin Schulz wrote:

Hi,

>>> Shouldn't this rather be in /config node?
>>
>> This is what I had there originally, but then I realized that some DTs 
>> might not have the /config node in them (or am I mistaken?), so I 
>> moved the new properties into the root node, which surely exists.
>>
>> It also keeps the code simpler, as it doesn't have to fiddle with 
>> creation of the /config node if it doesn't exist.
>>
> 
> I don't think we should pollute the root node with this. If we want to 
> be able to expose this in a proper binding to the upstream DT binding 
> repo, I'm not sure this is going to fly :/

The other option is to add more code into SPL, that's not great.

I can check if /config node exists, and if so, add it there, otherwise 
do nothing. That should be some sort of compromise between bloat and 
config node. What do you think ?

[...]

>>> I am wondering if we cannot simply have a string array with overlays 
>>> applied left-to-right or right-to-left instead? Or u-boot,fdt-dto-N = 
>>> "imx8mp-dhcom-pdk3-overlay-rev100";
>>
>> We can, but that is much harder to test for presence of specific DTO 
>> on U-Boot command line. It is easy to test for presence of boolean or 
>> integer DT property using 'fdt' command.
>>
> 
> Not sure dt-bindings people would love to hear that we adapt the fdt to 
> be easier to work with from the U-Boot CLI :)
> 
> In any case, another few thoughts that popped up overnight:
> 1- do we want to have this for SPL DTB modified by TPL? If so, I'm sure 
> we want it different from the one passed from SPL to U-Boot proper IFF 
> we start from a clean sheet (new DTB) and/or add the DTBO we applied on 
> top the DTBOs already applied by the TPL to the SPL DTB before passing 
> it to proper

As far as I can tell, TPL currently does not support loading fitImages 
and applying DTOs from them. When this is available, I suspect the 
prefix of the newly added property would change from 
u-boot,spl-applied-dto- to u-boot,tpl-applied-dto- and that would be it.

> 2- Add info about which DTBOs were applied to the kernel DTB?

SPL DTOs or DTOs applied from kernel fitImage ? Or a merging of those ?
