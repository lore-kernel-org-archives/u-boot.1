Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65DC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896EC87D5C;
	Tue, 13 Feb 2024 12:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707825355;
	bh=1J1Xe3JXzmXp4dWnGD5LWOH5gVm2gYpbw+um3zq9jH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PiaWJCtDtLSiJLSogEURLyvlcJKFK9tkOx4pk0neD2VsP0Fh7ny/oJpQFKGEp7TTV
	 5gfSbigf/ZWISqL5Ib087wfEI3MV37CuqSPBPmtLzC5tS/ajoTlY+yP33OC65/7Nov
	 v9QiLST5DQkv4imoDd3lnfevx4ur7novcG7PAlG3+GOECWrcZ+NeQQmnILcZpteXys
	 WPa8NpJWDRyvuXaKflF3A7bsT9GQuQjxl+Xiv5D9CDP3QyWSS0+d0AO6KUXOUtnrK5
	 NZskL0fINwW04RpnzMCO9MopS0aIikufea33BSLieVkb24Ijpyw1i+4mLIa0hU7Ph+
	 2VPAz7E1/CKAA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A602687D1A;
 Tue, 13 Feb 2024 12:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707825354;
 bh=1J1Xe3JXzmXp4dWnGD5LWOH5gVm2gYpbw+um3zq9jH4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mLxwjeQ0405Rc7uuMEB2kvtQ7dJDVMD50q1W1d9QVDQ7OwboXmBLtlh/BVydjE7G2
 6snqfFn0oiBkK+pL1Z2FclbDIvCgNYM9q9n4iKy9O+E9Fu4mJ8cXsK64u7d3RXkRXo
 7LQ87eYFePsxGeIHc6KR7iBj/YXkEhRr0GLjIVNqZZqINSTuSARA2hOSFfHa1/NSBj
 C3W55W9f7lMNIhLHxEGDTO/9T0bN+XSu/XWjAFlmdK0vDfb6QRnSc+pLPtrMaSaJsl
 MK7g98zDoIq/MwSQ0EN4NuQ+dBlsgMZFCQiRSQrIIFJBzSM3bSbSFCxs6FNlSOW3ab
 Tjbd2W200K1Ow==
Message-ID: <33577a00-d58a-4caa-ae87-30d70aab28a9@denx.de>
Date: Tue, 13 Feb 2024 12:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: add custodian tree info for AV/AVB
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240213073256.1124630-1-igor.opaniuk@foundries.io>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240213073256.1124630-1-igor.opaniuk@foundries.io>
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

On 2/13/24 08:32, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@gmail.com>
> 
> Add information about a custodian tree [1] for AVB/AB, which is
> maintained by Mattijs Korpershoek.
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-dfu
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Marek Vasut <marex@denx.de>
