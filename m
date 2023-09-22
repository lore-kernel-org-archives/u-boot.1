Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB7AE7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B16863DE;
	Fri, 22 Sep 2023 09:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="H7B3NLtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C62385E44; Fri, 22 Sep 2023 09:01:34 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCE386501
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Fri, 22 Sep 2023 09:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1695366086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=0BcL+WTgRXAIf16CXfF6OgVTvSjsk8au5GRCzq8Wkkg=;
 b=H7B3NLtUUJi/KVeGiBXepUvThdXC00VTpUP8Or5tdPKbwo4dH1LqX0wvJpIFsMLfLO1B+3
 6VVRZnb22yyn0TVxXaHWqpLKh9Nte/3y16t3yp2eLb4zWLTatTY3ENQSd6GqY8PiGhnCvy
 33YP0SdzlffKAVEyjenIL8DOkzDZAGCID6wEJROfpgJIKY0io3ixP0QadF/05wcTVPb4XB
 +BRU4M8XTtVpIxghanRhFgKHel/ObZmgJIqd6qM7gcEb3fQimxdLgCb9HHfeIP79bsh4xW
 PKedjUr4hpPNpi2+spUJB1+CWuwKRYX75C+JZ2vPraT+zE4LfRLzVB8XQOKnMA==
From: Alexander Dahl <ada@thorsis.com>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: u-boot@lists.denx.de, hari.prasathge@microchip.com,
 varshini.rajendran@microchip.com, cristian.birsan@microchip.com,
 nicolas.ferre@microchip.com, balamanikandan.gunasundar@microchip.com,
 Eugen Hristev <eugen.hristev@collabora.com>
Subject: Re: [PATCH 0/4] Add support for sam9x60 curiosity
Message-ID: <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
Mail-Followup-To: Durai Manickam KR <durai.manickamkr@microchip.com>,
 u-boot@lists.denx.de, hari.prasathge@microchip.com,
 varshini.rajendran@microchip.com, cristian.birsan@microchip.com,
 nicolas.ferre@microchip.com,
 balamanikandan.gunasundar@microchip.com,
 Eugen Hristev <eugen.hristev@collabora.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921170631.45752-1-durai.manickamkr@microchip.com>
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

Hello Durai,

Am Thu, Sep 21, 2023 at 10:36:27PM +0530 schrieb Durai Manickam KR:
> This patch series adds boot from NAND support, configs update and 
> fixes. The changes has been done on top of u-boot version 2023.07.

Well, interesting.  I sent patches for NAND flash support on that very
board some weeks ago which were already applied to the at91 custodian
tree:

https://source.denx.de/u-boot/custodians/u-boot-at91/-/tree/next?ref_type=heads

Tom already merged that to the mainline next branch.  I suggest you
rebase on next.

Add Eugen to Cc, since he still is officially listed as maintainer of
the at91 stuff.

Greets
Alex

> 
> Durai Manickam KR (4):
>   configs: at91: sam9x60_curiosity: update
>     sam9x60_curiosity_mmc_defconfig
>   configs: at91: sam9x60_curiosity: Add
>     sam9x60_curiosity_nandflash_defconfig
>   ARM: dts: at91: sam9x60_curiosity: Enable NAND support
>   ARM: dts: at91: sam9x60_curiosity: fix eeprom compatible
> 
>  arch/arm/dts/at91-sam9x60_curiosity.dts       | 106 +++++++++++++++++-
>  board/atmel/sam9x60_curiosity/MAINTAINERS     |   1 +
>  configs/sam9x60_curiosity_mmc_defconfig       |  14 +++
>  configs/sam9x60_curiosity_nandflash_defconfig |  92 +++++++++++++++
>  4 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 configs/sam9x60_curiosity_nandflash_defconfig
> 
> -- 
> 2.25.1
> 
