Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D48C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9819D8843E;
	Fri,  5 Apr 2024 17:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712329974;
	bh=ulEARfXWYhejj07AfEZcHQvS0PukF2coDZMTnB0OWP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Puw0eRlNGd2d4iWwLfGSLBYy6ioD53A3bR91GtjjiOXBA+G0OeVZZ2XKgdng0qCTG
	 WqYM9RAmraNaVFMLR+C8nVuwaKW1NJnIgFpmX+1O8CsnbWbyG9CXkiRCxBycBuOKJM
	 86IGHhKlUl/rGVKatdovnXOef6IXldqlpyIOIlPMBRoyjgjO952z6bpnq/N26iSonT
	 qMWydWncnikPbELXFVgz3LSJlUYsoCvXQZHFbgMpQYbxId5s+lbjuzQIpYTRYBkxeb
	 1nZrdiD3F8F5HeNXcHjzsa99yGY1tbBoHhfrFKIU8bBUaYLVhi4KyQ6WmN3QIkcIX4
	 ZP4I2ZYLX9Bew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 49AEA883EA;
 Fri,  5 Apr 2024 17:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712329972;
 bh=ulEARfXWYhejj07AfEZcHQvS0PukF2coDZMTnB0OWP0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l/0cFlPugXTVEAXudyX+diN/cCU+Satbm07JJy5P/RLkOLGz59JDwDqzfzV1iPaWq
 5XZ60YvOnxf8Vti5Rt3aGPBRkHqUw9rsAR2RLriJqtS0dcp3lLXMu+OdNtnc6wJ6dm
 RawRndvfYewbFwBRHN34sQmE2kAUhaoj39hUbxoCmHP8HA8sFmp5/JincOPAkMVfdh
 EFrd3ERYhLl57gD7GIHkmRoZwciO7+li2bpB1qaOrCtJ3EWZZudQygKkebci0UFgFF
 vBiBsWex2jaIvluZGGN2HY1WMEQ1X9505UM2o59S+eIWVF8QrDr1e9fMHySdTJH0mU
 m3K8EliPzfFoQ==
Message-ID: <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
Date: Fri, 5 Apr 2024 16:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
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

On 4/4/24 8:25 AM, Janne Grunau via B4 Relay wrote:
> Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
> keyboard protocol is unfortunately not described in the first interface
> descriptor but the second. This needs several changes. The USB keyboard
> driver has to look at all (2) interface descriptors during probing.
> Since I didn't want to rebuild the USB driver probe code the Apple
> keyboards are bound to the keyboard driver via USB vendor and product
> IDs.
> To make the keyboards useable on Apple silicon devices the xhci driver
> needs to initializes rings for the endpoints of the first two interface
> descriptors. If this is causes concerns regarding regressions or memory
> use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
> option.
> Even after this changes the keyboards still do not probe successfully
> since they apparently do not behave HID standard compliant. They only
> generate reports on key events. This leads the final check whether the
> keyboard is operational to fail unless the user presses keys during the
> probe. Skip this check for known keyboards.
> Keychron seems to emulate Apple keyboards (some models even "re-use"
> Apple's USB vendor ID) so apply this quirk as well.
> 
> Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
> single keyboard block this kind of devices from the USB keyboard driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

I picked the series, but CI indicates build errors, can you have a look ?

https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20215

Thanks !
