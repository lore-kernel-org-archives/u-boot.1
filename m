Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E6C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 02:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACED8859F;
	Fri, 28 Jun 2024 04:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719542923;
	bh=uW4Y0R2eP7L1aIUtBpLN4VJ2B93Benkxv+hgoZQzC64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=My/kcM67JDnwYEizeZ3xL/85DJxus3YafCugL0FZY8wQ4stRYHVJmIiJ6rUcmDNBQ
	 qB9j1UmNDsV6AP2ZXZ28cCacEgKss9aOILPwoRQOIq0kO1ZzB5VWojhAtuaB/UZ1S+
	 CsxmC7vhss+Aj3CWHL07gsa/AJPxOfTbM+7L17SOwsQYhwaGGk3/UBNk/s3LkhF2PA
	 gXhvhpKpmBEJPgixyDVThM5DZgoJO+EwIdt92NlAF41MMxE8wRtCr1nTwc4ZiNig9r
	 jiNLWWu5WjeN51WXPITN1mPpqC6DgpntpMfFGjgJepbW5w7IsN/LPoCwcdjMmUDnEy
	 0iD78JXeVyfZQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C8B7688580;
 Fri, 28 Jun 2024 04:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719542923;
 bh=uW4Y0R2eP7L1aIUtBpLN4VJ2B93Benkxv+hgoZQzC64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jTZrv0Pe//EXs4h5VEoljzxQpw31PBUrkuL1lFPPDrSFMOxf6gr3t6W0ufuhDeq3H
 TL51imvrE2Ypsg2MdkaN9hk6K8ddGRQF7CbKpWWeyVf3DVJcl+NQaKR6n0AQsgs2Yg
 0nkCAd6nu6bY750JfpPOvb+RbsOc/LpBsuBruSEh+WNW4ovi2HTEewnNO5jCDnfOiT
 rmUZJ37IU8o9vOLhVsjc/x09qRzJvIUfzg0TaHFfdWKX56SQd/bK9vB8dFLTi8aRY3
 Nl7lu5oUGIVd/N86+kQbQwWPHZMJDnfzr4U4cO2VkTCT+ks5pLBICpxQBdVM/j7wks
 5NAzImfqhuU4g==
Message-ID: <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
Date: Fri, 28 Jun 2024 04:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
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

On 6/27/24 2:42 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 6/27/24 1:58 AM, Marek Vasut wrote:
>> Insert /u-boot,<dto-name> = <index> property into the U-Boot control DT
>> during SPL DTO application process. This can be used by user to inspect
>> which DTOs got applied by the SPL and in which order from running U-Boot.
>>
>> Example:
>> ```
>> u-boot=> fdt addr $fdtcontroladdr && fdt list /
>> Working FDT set to aee9aeb0
>> / {
>>          u-boot,fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
>>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
>>          u-boot,fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = 
>> <0x00000003>;
>>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = 
>> <0x00000002>;
>> ...
>> ```
>>
> 
> Shouldn't this rather be in /config node?

This is what I had there originally, but then I realized that some DTs 
might not have the /config node in them (or am I mistaken?), so I moved 
the new properties into the root node, which surely exists.

It also keeps the code simpler, as it doesn't have to fiddle with 
creation of the /config node if it doesn't exist.

> Also, I am highly suggesting to have an additional prefix aside from 
> u-boot to avoid unfortunate name clashes between DTO and existing 
> properties.

OK, fixed in V2.

> Or could be in its own child node of /config ?

Please see above.

> In any case, can you please add or edit a file somewhere to define this 
> new dt-binding.

Done in V2

> Additional question, what is this index for?

To indicate in which order the DTOs were applied by the SPL. It matches 
the order in which the the DTOs are stored in the fitImage and the order 
in which SPL iterates over them. In case the SPL skips a DTO using 
board_spl_fit_append_fdt_skip(), the integer sequence might have gaps.

> I am wondering if we cannot simply have a string array with overlays 
> applied left-to-right or right-to-left instead? Or u-boot,fdt-dto-N = 
> "imx8mp-dhcom-pdk3-overlay-rev100";

We can, but that is much harder to test for presence of specific DTO on 
U-Boot command line. It is easy to test for presence of boolean or 
integer DT property using 'fdt' command.

Thanks !
