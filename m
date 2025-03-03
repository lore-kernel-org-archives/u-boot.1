Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9BC282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 23:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFA180786;
	Tue,  4 Mar 2025 00:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gn+REKLC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uxno76DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC6181249; Tue,  4 Mar 2025 00:16:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C461780786
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 00:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z6F7K3GQbz9spd;
 Tue,  4 Mar 2025 00:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741043789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPMM7Eku0UieC9TxdSTC55rqhXWkUbp8DY5Faq7BiL0=;
 b=gn+REKLCA2COPB/MtCek+RUr/HfIFerTfneeCsY7upK4CDzF6mHazyFBkSfCSjHKklXC35
 Kx2FYG7ur9ivfxm1KQNRz5x960UDyADVadeATf8TPuVr8cwjbHLqSn8j6wKNUIPdt/VTg6
 9YwIcLAmr4jSzchV981xFLD+6gz7IV+9U2bIz4wc4LvLlhv92his6VPMI716hU5EBfhxUf
 1aG9Wlw7C7igfeNBwA0X8jzrVTjFQml8YHWGUI7KqsQvBC+5rlY2/00ReVf9FSbwEt62OB
 RX61h353uVEqSzwPVVpF0UUq8NEitFEGjLpg7a3wOnQdMLKK9laSPR0+1pe2IQ==
Message-ID: <81b02e3a-3fe1-4b52-a646-194ca003b82e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741043787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPMM7Eku0UieC9TxdSTC55rqhXWkUbp8DY5Faq7BiL0=;
 b=Uxno76DCVdE6Pzch54gdBCpJNP2i0doBkEbU6VXuR95CvXZ/0+oWVkqR5vIpwqBoKH1Sss
 6+lcr277Y2EiEDn5VfdNUKTkD05KHRytZ7WyDa1I/Yq6w2LhQpYaNZxxgOh2lguTPl/49H
 KFt9NHhW5e+2AjUYV/GxTkIbMkBjhwIquMBCa/VHpqJULm1QENTWKh7mq8p8FfpyT67FmL
 jOmBfyK2DGMn64IX13939r4PYE5sHojd6yanQT+l1M+t526PlXrhNQdC79CuK+eXjX70IE
 5aqtz/CkqMIwGbsYKKW9hfS1O4Ri2Vke/xb4WfAVKKKnbhCsHpy5j06nXmOKAw==
Date: Tue, 4 Mar 2025 00:16:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] net: miiphybb: Split off struct bb_miiphy_bus_ops
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
 <e4c44d9e-cc95-4f87-be9c-746c21a7103e@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e4c44d9e-cc95-4f87-be9c-746c21a7103e@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3ffcae70dacc6bf3c63
X-MBO-RS-META: 6yhd6exu8etdzsec6ctfx4bxh1daiz6o
X-Rspamd-Queue-Id: 4Z6F7K3GQbz9spd
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

On 3/3/25 8:29 PM, Paul Barker wrote:
> On 02/03/2025 01:24, Marek Vasut wrote:
>> Move miiphybb operations into separate struct bb_miiphy_bus_ops
>> structure, add pointer to struct bb_miiphy_bus_ops into the base
>> struct bb_miiphy_bus and access the ops through this pointer in
>> miiphybb generic code. The variable reshuffling in miiphybb.c
>> cannot be easily avoided.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Hi Marek,
> 
> I'm a bit lost trying to review this series. Could you include a cover
> letter summarising the change to the bitbangmii API? We also need to
> update `doc/README.bitbangMII`.

In short, this splits ops from the bbmiiphy structure, which is entirely 
removed in the course of this series, and so are all the bbmiiphy 
alloc/free functions again. That in turn fixes the missed mdio_free() 
update, which no longer has to be fixed, as the drivers go back to 
mdio_alloc() to allocate the MDIO bus.

> This also means I need to rebase my Ethernet patches again.... I have a
> few bugfixes for R-Car & RZ/G2H, plus some refactoring and the addition
> of support for RZ/G2L which all conflict with the churn in ravb.c.

Sorry about that.

-- 
Best regards,
Marek Vasut
