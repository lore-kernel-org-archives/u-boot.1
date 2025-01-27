Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6861C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F7F817D8;
	Mon, 27 Jan 2025 22:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738015110;
	bh=7MkCJ9KSh7V0DzdmEuy40ZPjctpNuoOMrfWke8M/NYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upNHhYZADjYDXh/+caRwE+xdc/8t4av4N+2Z3QRCScrf6SzENDFxaQ/yjfUGFTP5O
	 9KDuhXotKgwkR30zltD99yXhNWQQ79oWRa/ZtIBiK/Js+g7Rmhm97noLFtWzTfbJvO
	 AoWJkzcrtXfBZbz5rwBmCH2GCHzC34/ge96L0kpJYGkYvKU3fzgdkaihRGOvV7phyT
	 OWXrvnQjXXukzKyQYX4QLNifeQUjhSw5vMN6P7HwS1gZZWbW2rV+vwkEgO715l3zoV
	 JAgEEd/3VV7FfmEJzttMYMn/mKkQz/k5fcGKlDjIkhDoDW0RjfBGfJHEps8cDgzkB+
	 jRLfC6/ZOUPqQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA31812BB; Mon, 27 Jan 2025 22:58:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A60781671
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hzKvcHXH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 833C4103802C1; Mon, 27 Jan 2025 22:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738015105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MkCJ9KSh7V0DzdmEuy40ZPjctpNuoOMrfWke8M/NYk=;
 b=hzKvcHXH9gwvFvWdfrhnPIL0aRtIt7bvYYKAr2vO56sASzKVi6wvL2ajE3prLot7Xt1Z9x
 CK/MKW7DeTqkrfuPmMR+fO9hmemJAgsqxusqB4uLj+X/6FyQiHUsHeYlpp6e3ZagEs03M0
 AzetKXD9oJE4DP/o4Dge0wiXFLU4mfTfCTbLrGPkqLDSSQh3cMS2t5gB55oWwOiH7SfgRF
 xboANItjecuA0yqB4GFcYcquOkrmmvk7c1v2wD6DHsMNNqt9QGEGrQgifvJjzARullIw3I
 jEJ5IpWt5z5hyRvc+XxRfBaWxj8+VfNlKJ+mbjqVqBjpcRpQPmKo5pmUV+fZzg==
Message-ID: <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
Date: Mon, 27 Jan 2025 22:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin"
 clear
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: Dang Huynh <danct12@riseup.net>, Piotr Zalewski <pZ010001011111@proton.me>
References: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/19/25 7:50 PM, Dragan Simic wrote:
> Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually prevents the
> CONFIG_USB_KEYBOARD option from working as expected, i.e. USB keyboards end
> up not working as console inputs when "usbkbd" is properly specified as part
> of the value of the "stdin" environment variable.  Describe this clearly in
> the two relevant Kconfig files, to prevent any possible confusion.
> 
> In more detail, the console_init_r() function ends up overwriting the "stdin"
> environment variable so it contains only the devices available at that point
> (which doesn't include "usbkbd"), while the "usb start" operation is performed
> much later, at which point the probe_usb_keyboard() function cannot assign any
> discovered USB keyboards to the console because "usbkbd" is no longer present
> in the "stdin" environment variable.
Wouldn't it be better to patch console_init_r() , check if "stdin" 
variable contains 'usbkbd' and if so, start USB and register the 
keyboard as stdin device at this point ? This is called after 
relocation, so starting USB should be OK to do here. The behavior should 
then be less confusing to users too.
