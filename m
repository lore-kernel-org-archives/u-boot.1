Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16FCC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B278789F;
	Thu, 25 Jul 2024 20:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721931850;
	bh=cyCCP0lPfUYsaHaJee7O+N8z8aE02tc+xUkduQLV42g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MpTetEfo8wYkkakNUrn2oK/5+RYMqlyHgPerPHfMz7iwveFBfEO6z/ExO3cVsdwN+
	 yTP+qn+QaSSD2wh3aVMtpoP//YODYX/vU2A5tV+N7A+V2gXzxGYqpJQzibg648ePGD
	 uey2H/UNv1p7a4jEm9WSZwmmXnnmihomF34HewkXQH3N7L4aCTzVPnlr9xvsBd2XfM
	 4YFdaaacMbwRFQlcr+j60/5XpMUncsu307yy4mnel4JBh/gOCLVMNkTpJzIQs/IvDL
	 KJyOjFMvuWizdeZi/2wbafg20aVL5lxGe1blSnB9dtSLmevSd/sKnl5EeOPl3CqdwI
	 BCak9qw8cmJTg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BEC2588100;
 Thu, 25 Jul 2024 20:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721931848;
 bh=cyCCP0lPfUYsaHaJee7O+N8z8aE02tc+xUkduQLV42g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xwAWRKTIeOigD/+sg8yeMtNAZSlhrcdpf3qLeB4hOxa6AbbUM0w1Rwl7uvvG4vHLt
 b4qE3g0U5q7jo3WYxhq5KxQSkIAZfiCixVdv2cXn/FPVe0kPLnNDdrQGUw1TrkU5de
 rS3iWOA01tnDWgttfeCJCFacOj3FU1acIKvZTXIEjIFHM6xJZtapMoPln09VHklJeX
 nJssDdDPj2cfGFFggx7WyxcXctnvY1JKABCfE93lMqA1kxDfO/p3XKwgkycDIxYLuc
 Z+xo1H4DaKVQCc+BT9RJ8T8JO0ya6Q3AdJBQK2AcKGuFGj63Jjk7IgqZdM7DJgdzt4
 6q21xzGPgfQKg==
Message-ID: <0e0a053a-56b8-470e-98bd-80e61417e5df@denx.de>
Date: Thu, 25 Jul 2024 20:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and
 DM_USB_GADGET support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240725153204.358925-1-admin@hifiphile.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
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

On 7/25/24 5:31 PM, Zixun LI wrote:
> Changes in v4:
> - Release clocks if probe failed
> - Add missing endpoint data free
> - Addressed comments

Please collect any AB/RB/TB tags that were provided in v3 too.
