Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A090C02188
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 01:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAC881951;
	Tue, 28 Jan 2025 02:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738029003;
	bh=Be3GLMnn9ZV+ePEa+CY15N9rDzioCVss4hXlvaFZVj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wLJzHTFLc4LtoqgdtHNW2SoH783VPgcl/f3hvhknRyGwR7mwMrIGWVPVOx/kaE9UJ
	 Wnl6J4ZK2L/YY8Lgqp+q72RHp1ngDLlpGFby7aSUhSCv+YHlFehkVpqbj5BIXZv28p
	 /wh6TE7SwNKzEld90DVyMdI4cRSyeRGWWXGA0P1c1O/puWUn5HnASpAfMZuKUG52dd
	 e39dWDbXJMRdDJFHyZTKScatHvTjdXAH6c2wWxX1IV4JeD7ayP1zlNcQR8oXIoFiD5
	 mZ+EZ6eASpK7koaXMQitjEopQhy202MNT9J00vmNIUvvbyd7Fd1BRtI3DixSTa5+28
	 LWS72Dg1cof6w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE808191C; Tue, 28 Jan 2025 02:50:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B732F81111
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OV21ROXU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8DD6F103802C0; Tue, 28 Jan 2025 02:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738028999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Be3GLMnn9ZV+ePEa+CY15N9rDzioCVss4hXlvaFZVj8=;
 b=OV21ROXUKo2nnwEeVCVyErzFH5byiRmXDWCUrTMla8g4+eLUR5BHvbAeINWr+waSK/bk9w
 0+nb3CoaCVBwWLGDjG6Rh+IzCMyxTAdeXnq67lL/MvJZ26CJMIVKD8AV18Xo4c31IbtYN4
 kjOzgEvkifcVUOlE4nNl7CZT6bz1hJKAOBCJK9MQecs10Rw2SUF927f+RSIjhNr44qLa1+
 lFmBl2KUy1Ai27cQVegllpQUi8zDy7nQ7b466kBZl3BVZfDhXUjozsP1RcFZ+/XnxgFhca
 dFZugqUT6Z0NCm6L5C/g10j4QPFM2n4tPCWhSZldhrfKnQ5lwrFAUE7Tb5LbNQ==
Message-ID: <ce6b56d4-454e-4247-93c4-caa00ab52925@denx.de>
Date: Tue, 28 Jan 2025 02:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin"
 clear
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>,
 Piotr Zalewski <pZ010001011111@proton.me>
References: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
 <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
 <6e2b3f3cdfbed67122725d22055d8877@manjaro.org>
 <5f794a65-eab4-4dde-9b44-eec6c97ff335@denx.de>
 <828c2c778a42fb2bad8d2318b24956bd@manjaro.org>
 <8628a4ca-ca32-4f07-889f-0df66d6dee59@denx.de>
 <34164148c3973297ab7eda29bf292846@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <34164148c3973297ab7eda29bf292846@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/28/25 12:22 AM, Dragan Simic wrote:

[...]

>>> Maybe another good option would be to modify the console_init_r()
>>> function to simply leave "usbkbd" in the environment variables when
>>> USB_KEYBOARD is selected, so the "usb start" executed later can
>>> actually make USB keyboards work?  I think such an approach should
>>> have the lowest potential for causing some issues or regressions,
>>> while it would pretty much eliminate any confusion.
>>
>> Yes, this looks like the best option, because if 'usbkbd' is in
>> 'stdin' environment variable, the user likely expects the USB keyboard
>> will show up later, but it is not available this early yet and
>> removing it from stdin variable would be unhelpful.
>>
>> Please also update SYS_CONSOLE_ENV_OVERWRITE Kconfig symbol
>> description to reflect this change .
> 
> I'm glad that you like it, I'll move forward with that approach.
> 
> I was also thinking about making sure that "usbkbd" gets removed
> from the "stdin" environment variable if there are actually no USB
> keyboards detected during the "usb start", but that would actually
> be wrong, because a USB keyboard should be detected after being
> plugged in (in interactive mode, of course) after "usb start" is
> executed, followed by executing "usb reset" on the UART console.

That would also be problematic in case the keyboard would not be 
detected on first 'usb start' run, but it would be detected afterward, 
on the next 'usb start/reset' run.

Thanks
