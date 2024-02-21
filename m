Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A3C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C95187E25;
	Wed, 21 Feb 2024 16:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708531113;
	bh=WIzfjaBAEjkLhIsoNUXTLDkm0woLaw8EudwwKdTR584=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IuRJ3TLxevj9hAIF0TaLvsQemfvYOb/LBnDcf9Uqb3ftZXIYv592dI5LqoIH5wUiN
	 4vbKknBdwtosHueOH4+98lD1LOp2rI/cpuHj19PLvqqqrA7NeHlQZRAL9ZfhOqKD1n
	 mGebhqTdTTbE0XAQ3lVBq7OMHg2qntxoo4zZewrg9UkUPSo0y4Yp3df6d6jgopYorN
	 YL+yBPvwtuFNeitlOxctTlAnBbNDyTafbHDVgPPdGD94AtgbUda4ju5eVSMVrX2gxD
	 zmRa2O2PG1hCUnGISBEQPuGtPlPT0p6TBpyLuj45xe0NzQZ6fPy/BKxYqXOPeowDw9
	 /zLKbJOeeilog==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9C97787C86;
 Wed, 21 Feb 2024 16:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708531107;
 bh=WIzfjaBAEjkLhIsoNUXTLDkm0woLaw8EudwwKdTR584=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yhsGUOxyJd4B/I4t+5ZGfaL6x+mpvyRJPg6b0dIl9tD7ospqfz/h8JuV68fYZwyXD
 Nra5KtpzJRN4ePupz/Uim7lWcDZFEgrjvf9h0zHZc+LbQ57nVG1M5ptP0WJAZkmumC
 3AAd24qskI8Kb2m1afQVOBDmY6nnmJ59e/moFl4JNKmvbYrmG0PvCYub7w6gIefzZ2
 2nCGn2PC8pDHqdIiIriK3b94fW8ho91ovx9RvlovoudaT4w05ISWksJJm+0LbM8zpv
 V8ku7Gj7ETAyweMcv4PEM/IJRe02ownRnm1XyCAFhAwk1OsO4bwE9Y7Pv7GTEZ5sK1
 E0f/pHzdLorMA==
Message-ID: <9cb3370e-770a-40e6-b890-ae9b5a15bd44@denx.de>
Date: Wed, 21 Feb 2024 13:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
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

On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Apple USB keyboards carry the HID keyboard boot protocol on the second
> interface. Using the second interface in the USB keyboard driver does
> not work since the xhci has not allocated a transfer ring.

So, what does this patch do ? That is not clear from the commit message.

btw. missing SoB line.
