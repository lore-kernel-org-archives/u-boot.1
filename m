Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58777C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 22:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE0A812BB;
	Mon, 27 Jan 2025 23:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Z1jKutRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488A1812C8; Mon, 27 Jan 2025 23:21:03 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB5881265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 23:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1738016460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4HK3pP10KcecU+toKvcfH4MBfdItCfgaFtm5RxAUe4=;
 b=Z1jKutRpyiYhQGAAzgQr88Di5hiuKMNdZs0FdROn2ImBccWeowCeXTuQ8O9kQlvLzv8sh0
 mG7c5F8T56SCtd163a8/+f3fi4XjxsRAdruEBztZeMrNlhtCfrFVw5S772+AwPLEY5Ze0z
 0PxVVuqIj4jTpNTEPFYXJOYNQI3GbcEzU1pDGS0AHwCtDirEYx5uW91lKQlVQxrzt0a17a
 EjMWBGhj3/tjLB5sIaWIDHE27QykCfGGwgxJ/IKkHgN9g7gjDuphCyxAdmt0hO7pJjfV/l
 2EgMGOkgDE0sIZvIRogPnvKZAeQm1cB8zpnZX4kE3VtutT0RxMa0fVKYM2UkRQ==
Date: Mon, 27 Jan 2025 23:20:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>, Piotr Zalewski
 <pZ010001011111@proton.me>
Subject: Re: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin"
 clear
In-Reply-To: <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
References: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
 <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
Message-ID: <6e2b3f3cdfbed67122725d22055d8877@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Marek,

On 2025-01-27 22:55, Marek Vasut wrote:
> On 1/19/25 7:50 PM, Dragan Simic wrote:
>> Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually 
>> prevents the
>> CONFIG_USB_KEYBOARD option from working as expected, i.e. USB 
>> keyboards end
>> up not working as console inputs when "usbkbd" is properly specified 
>> as part
>> of the value of the "stdin" environment variable.  Describe this 
>> clearly in
>> the two relevant Kconfig files, to prevent any possible confusion.
>> 
>> In more detail, the console_init_r() function ends up overwriting the 
>> "stdin"
>> environment variable so it contains only the devices available at that 
>> point
>> (which doesn't include "usbkbd"), while the "usb start" operation is 
>> performed
>> much later, at which point the probe_usb_keyboard() function cannot 
>> assign any
>> discovered USB keyboards to the console because "usbkbd" is no longer 
>> present
>> in the "stdin" environment variable.
> 
> Wouldn't it be better to patch console_init_r() , check if "stdin"
> variable contains 'usbkbd' and if so, start USB and register the
> keyboard as stdin device at this point ? This is called after
> relocation, so starting USB should be OK to do here. The behavior
> should then be less confusing to users too.

Please correct me if I'm wrong, but isn't "usb start" deliberately
left to be executed as desired by the supported boards, or as part
of distroboot, i.e. in include/config_distro_bootcmd.h?
