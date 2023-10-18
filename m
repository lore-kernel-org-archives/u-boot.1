Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7A4CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AB086F60;
	Wed, 18 Oct 2023 12:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626321;
	bh=nQSEbYO6PBsdgPHyBFKsAhLUJG6CgpEfN8mNyLmuHxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVcHfoyrM1aclB5aZQ6idRyIGd5PfyX0doh48eL/XClaX/nX+DxdLZbzp8JE+lAp1
	 ZLViZf0DX1ZheULZ6VF/7MWm7jlx8Oq24WGQ1FgIpA/rByA74GlJvXa8UNauwD2wGj
	 CakkJWD6FMGfNoTjoT8LWzISAxWQb6d39lP0KlQvbn3v3iiXa/PUCQtUhePkEisE6O
	 SLVtGSqjvpfa54esO70rgQ141+7zFjlcALXj8JQrI8+gn2VhShXLFwxe0AoDei6aoo
	 JEJZgkMYVxa4IJblT0mPJyqpmy4zF5ZpvLYQPEKY2VGyKj7UBog0b16/4xnYEuPE0m
	 a56PVNubuDHAQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 745788269F;
 Wed, 18 Oct 2023 12:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626320;
 bh=nQSEbYO6PBsdgPHyBFKsAhLUJG6CgpEfN8mNyLmuHxo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tXL4q+g/5VLLrxIGYhK1yCVi2Zb/a5vD63L4VKONNkTwyYgMDBDbcBjHI0QJaRmYN
 3A2tO2O0qY65mjlmWrJsfCAdjeuIar4O2P3k9sGlMFiBT98Eem7CCdBr0AzUpmkLok
 gHkyR+oPX5I7kR5igJ32kJ9UA7POpng9ooUaWoADyVyuVosMYSA7oISIaCqddXhz0h
 l2GjRNUU7Ck1Vbg1NUlUwkPe9YRi+b6NQXudEqdAmqecjfbYzzemBZv83VRIP0MmVk
 Mb77Z2drM9qo0nK/vhfn4uJtn0qYhqzIkorVBCsAaYosyX+ZmMTFA7o04OvH/T4oFw
 7mHxnHHHfzb3g==
Message-ID: <f169a8a9-1b7c-4e9d-b443-9f1f5983ee27@denx.de>
Date: Wed, 18 Oct 2023 12:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
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

On 10/5/23 15:04, Mattijs Korpershoek wrote:
>>From discussions with Marek at Kernel Recipes, it seems that the USB
> subsystem in U-boot need some help.
> 
> Since I've been asked and I'm willing to help, I've added myself to the
> maintainers entry.
> 
> I have also added myself for fastboot since I'm interested in keeping
> that functional as well.
> 
> Note that I have no previous (open-source) maintainer experience so I
> will do my best to learn.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thanks. I expect Lukasz to chime in in a bit too.
