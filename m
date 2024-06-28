Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2555CC3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 15:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881CE88453;
	Fri, 28 Jun 2024 17:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Itn6aqea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257958851E; Fri, 28 Jun 2024 17:55:55 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212FC88254
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719590152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN/oD8qDxLbgjTJWlvDkCqfemPrbx0X2PQm32bQWg9Y=;
 b=Itn6aqea2isgPrN/ZnrNl8eUwT4BI+E5o2/7i6JP1lIJBDLG3BCRUsziU7S8i/WRui5tao
 gu+xR/2lH68iA77jS0aaGQ6XUtZAQhkkjunGFq+kTCkTw1CBfCt3ycw82wmzLhwRMld7Zy
 vVsrXVblnzPRFPDeXM9k5DwJKZu9jnS4MEAl8fdcyemeqMrmxcl4l2M1sm7qLUstAJJIN+
 jTbTYdTX4n4/zzlmmdSqO8ew9LQ1RUvHTB/b7VKOi+Qz0cAHewm07qkhltrTUiFizJ+c8/
 QzYT4HC/d+Hl5v9DU4QiMjzp7RlkRCYAu1KvWbujbbwk5rwkvTFcrDBxmfPp5Q==
Date: Fri, 28 Jun 2024 17:55:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, Ramon Fried <rfried.dev@gmail.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, u-boot
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
In-Reply-To: <9d618818-f3f4-4e03-8696-dcbc5b944006@imag.fr>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
 <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
 <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
 <a7dbf00b11304f80cacd5821a5e19127@manjaro.org>
 <273b4022-4192-4df8-ab69-db8d05b091ea@imag.fr>
 <0487e16e-9a4f-4a1d-be80-312a2969d258@cherry.de>
 <9d618818-f3f4-4e03-8696-dcbc5b944006@imag.fr>
Message-ID: <4a8a302f361a436ead42ea4cfd003c85@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello,

On 2024-06-28 08:51, Etienne Dublé wrote:
> Le 27/06/2024 à 14:27, Quentin Schulz a écrit :
>> On 6/25/24 1:42 PM, Etienne Dublé wrote:
>> Le 25/06/2024 à 12:25, Dragan Simic a écrit :
>> Another option may be to name them "rtl8169@<hexa>", with "<hexa>"
>> reflecting the PCI region address (so it is unique and stable). What
>> do you think?
>> 
>> I guess that's one way, I'm also wondering how systemd renames those
>> 
>> to be unique but stable on the same machine, maybe we could take
>> some
>> inspiration from them for that?
> 
> Systemd also allows renaming of network interfaces using some rules
> predefined by the user, so there's also the possibility to rename the
> interfaces in U-Boot to ethernet0 and ethernet1, using fixed rules
> that would be based on the PCI region address.
> 
> OK but the renaming occurs in the rtl8169 driver, that is used by
> several boards, whereas the PCI region addresses come from the
> device-tree, so they differ from board to board.
> 
> I'm of the opinion that we only care about stability for the same
> product, not for different products with the same Ethernet PHY on
> different SoCs/products.
> 
> I agree, but my comment was more about how u-boot code is structured
> (network interface naming is done in the driver, and the driver code
> should probably not include board-specific code, so we are quite
> limited).
> In theory we could just name the interfaces ethernet0, ethernet1,
> etc., by using the PCI region address as the sort key, and maybe this
> is what Dragan was suggesting. But in practice when driver->bind() is
> called we don't know if more interfaces will be discovered next; and
> renaming the 1st interface when the 2nd one is discovered with a lower
> address is probably not the kind of code u-boot code experts would
> like...

Good point, we don't know how many Ethernet interfaces will be there
in total.  I'll see to go through the source code, to see what options
are available for stable interface naming.
