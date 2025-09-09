Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0ECAC589
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 07:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AAA830B4;
	Tue,  9 Sep 2025 09:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6470E83106; Tue,  9 Sep 2025 09:41:42 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF3080422;
 Tue,  9 Sep 2025 09:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.30]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AF397B22003F;
 Tue,  9 Sep 2025 09:41:38 +0200 (CEST)
Message-ID: <5291c19d-c200-4f56-b180-62b705b23b38@freeshell.de>
Date: Tue, 9 Sep 2025 00:41:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2025.10-rc4 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20250908162046.GS124814@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250908162046.GS124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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


On 9/8/25 09:20, Tom Rini wrote:
> Hey all,
> 
> It's release day and I have tagged and pushed things out and will merge
> this to next and push once CI completes. One thing I should mention up
> front is that in terms of project organization, we're moving ahead with
> SFC and they'll be joining us on the community call that follows the
> v2025.10 release itself. I would strongly encourage anyone with
> questions or concerns to join and speak up, or reach out privately if
> desired. If anyone knows of regression fixes that need to be picked up
> still please reach out.
> 
> We're continuing with a community meeting following the release
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> September 9th, 2025. 9am (GMT -06:00)
> 
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=1307528552322&hs=1
> 
> In terms of a rough changelog:
> - Enhancements, improvements, fixes and new platforms on atmel, tegra,
>   rockchip, stm32, renesas, samsung and TI.
> - Documentation cleanups
> 
> I continue to plan to do an rc release every two weeks and the final
> release will be 06 October 2025.
> 
> Thanks all!
> 

Hi Tom,

Please merge
https://lore.kernel.org/u-boot/20250901112748.676541-1-e@freeshell.de/
"[PATCH v1] configs: starfive: Add visionfive2 CONFIG_DNS enabled". This
fixes the regression in DNS functionality for that board only. If there
are other LwIP users they should possibly add this to defconfig(s) as
well. The regression is that with LwIP enabled previously DNS was
working when enabled; after the LwIP DNS code refactor this
functionality would have required to enable CMD_DNS so we have since
merged the new functionality for adding CONFIG_DNS symbol; This
improvement alone does not solve the matter it must also be turned on in
each board config that is affected.

I don't know what other boards (if any) are affected that would need
CONFIG_DNS added. At least for StarFive VisionFive2 this restores the
missing functionality.

-E Shattow
