Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D843BC48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1824488057;
	Wed, 21 Feb 2024 16:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708531116;
	bh=j4s/eCJe9+xUOvNoe28h+lHhDKA32lj8dxUTf0J9TyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJOeAjcz9VdyBT3QWjCd+YUcmLSksqoTakWqxpakqLzgzKdDaCr99KuIlKswI2R6h
	 g9mctpjtuRlePTvYuipv/2BnDAze9TDfx2BOkVm7pcRoSKJwpqbitrV6X8+64X5X3m
	 //QhSF+N0DiiPJrbTtSSeWVDXsjbES34yKDumoPJqgtY90gJM7koUPKDoJAYW9SB7F
	 NRE79KatakfASB4zc9a3YDj58bkGbu5AGeYxbGMDAWsZM6lwoRWtLfoz/isZ5MOjEp
	 vSXZ7NySeOBLcj6R9UvHE1Gg93GmvRYZpaklW7jaXO6azZ9oLp1HYKzJ3tBwX0e478
	 ZCg3fVpHirSkQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 76D408802E;
 Wed, 21 Feb 2024 16:58:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708531108;
 bh=j4s/eCJe9+xUOvNoe28h+lHhDKA32lj8dxUTf0J9TyE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=osfoOtDAnEFu8uJrM9V0sdaITY8ymLAE/lOdC3kOtq2/lftboQ0uvYR+EDnojZkOP
 G0peEZceM8Cvg7PX3Mi0PnTo2JxJ6g9bc7zfKN7CdGW8YVg/VzwIN4mCPGIVbDfZ03
 UqU3r5bpmI7UntNNPkrYx86m6esW80DViKOXcJOwXI2OdmlE5SRCHUf9v/39WhGH+B
 6MWgZSLv5YoHlPnomWDwiIwur93x3mkI1GXzUeOrMg2DZwNOrmYS07GSZeWsbY6Cwo
 WuFZ+VwhBW1DhBnbQmEpzBNaSUXcmGSx9BbBkhKnIS2Gi6H2/QipEmRm1Auy1Gx5WF
 O9ULyN66MHw2w==
Message-ID: <1f064fc8-6f73-4b55-a1df-b77236c52c82@denx.de>
Date: Wed, 21 Feb 2024 13:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] usb: kbd: Add probe quirk for Apple and Keychron
 keyboards
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-6-814b2e741790@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221-asahi-keyboards-v1-6-814b2e741790@jannau.net>
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
> Those keyboards do not return the current device state. Polling will
> timeout unless there are key presses. This is not a problem during
> operation but the inital device state query during probing will fail.
> Skip this step in usb_kbd_probe_dev() to make these devices useable.
> Not all Apple keyboards behave like this. A keyboard with USB
> vendor/product ID 05ac:0221 is reported to work with the current code.
> Unfortunately some Keychron keyboards "re-use" Apple's vendor ID and
> show the same behavior (Keychron C2, 05ac:024f for example).

Uh, fun.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
