Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74DFD2F7D7
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 01:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537F488E14;
	Thu, 17 Oct 2024 03:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729127492;
	bh=TAVkKtX/OVKUbzBeoZPEQ7SOE14zNcStvUqqa1XM3c8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0vJYaA4gplrd3RiPO6UOASN4qMv35nivyEry837ZOQ15jCxxbhlavoGJrBn5jWRj
	 HAiWlCjXmrgqyIJF7lsUIiTMxYnST88ueVImE+vU3KLkAGIDp9m8tm4D3YDU4NGprl
	 5RyLDu2nvMu+H/CI4k9qmY8yopP/96v3+OS1nyKY/OV/jrkZy6B32eKuFWBjoLxZIX
	 wE+gKQ5KUy+Z+xaKaVv6nJrg4tvRJckbG/jCd/F9+VXdYcTg5WWU2EfuTkI10ObJyD
	 JyZPwYapP2vPqZdxZ9WE8GilQXFrWMpWNueih/nOS01ZDtQ/V5MO0vlMJVFXDKjlMk
	 fX1JFFtPgXLGA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5E4B888D7E;
 Thu, 17 Oct 2024 03:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729127491;
 bh=TAVkKtX/OVKUbzBeoZPEQ7SOE14zNcStvUqqa1XM3c8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ILmo4Gm3ZXZmqCsOql8Dj2rZ+mlgx425RqYWQYYlNRySudK4AvJMDbvXvpQK05zIF
 ZMj2gf9SNYvGwGf3Co5T73pvA86M5l2SFHQ+eGLG/neWSFVKbha/VTNAHyzoi9DhDT
 qBbZp0h4dz44AwdhLwGaMd7xGM42ltC/7SdbOJNwJnUjr1zensC2QTjRiGCJGYrZ8x
 E4QFtn9xStU1abK3btQmxlW3sNxBiuLVatnoY/UxRicqAMB66nW0TPGrtch8eZB4DC
 7QtRNX54QV7elXT4WwuizJ2skxW2BqaRfrcYArfTEmmZK5Rkbu5FL3sRDjiOxfkDsd
 S2Nv6Mb9Y/WHQ==
Message-ID: <dc206c39-f977-4524-8cd3-4d5dc5f3b9b2@denx.de>
Date: Thu, 17 Oct 2024 03:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
 <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
 <CAOMZO5CGjRXC8kqq8FhDW133Eiw0319we+D9rgjvrs14DMYk-A@mail.gmail.com>
 <CAOMZO5DWaBG=XS+GyP-dCy0kXOBQzwq3BWh4P9uZgbJ6ivDagw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DWaBG=XS+GyP-dCy0kXOBQzwq3BWh4P9uZgbJ6ivDagw@mail.gmail.com>
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

On 10/16/24 8:42 PM, Fabio Estevam wrote:
> On Wed, Oct 16, 2024 at 3:34 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> On Tue, Oct 15, 2024 at 5:22 PM Marek Vasut <marex@denx.de> wrote:
>>
>>> This should now apply on u-boot/master .
>>
>> Thanks for the heads up. This will be part of my next PR to Tom.
> 
> Hmm, still fails to apply. Please check.

I sent a V4, there was SPL->XPL symbol rename that git couldn't resolve. 
V4 should apply fine on top of:

608a31bdec62 ("Merge patch series "Introduce the lwIP network stack"")
