Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F75C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3368580548;
	Mon, 24 Mar 2025 15:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742825534;
	bh=p22+M3kv519HXqtxif8xuIBgNBRc5Lsrh3BLan9/Aac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZkB5vWKm/581iL9E9z4uTe1Ho0qEda8oO1GlE4Wesm5QsYIO8JnV5SmwDtnl7XZZ
	 fPxeyh3WpzixWYTALoW8KN6aNoBAXXmmw9Dr2wLxxG2sMTmPjczJnn+nh4ta4a1xx+
	 As/tVrT8yD0iVSXU0P+BwpnIbY3UmteUcU6PbgsD7nExaYBC8/Zi6zEWkc88ZoTdhM
	 FNk0lL0OPaVDo/at9UFIic8YF8dh29+Aoz62uSRpxt7UrKubjRM8CtKwLMc6Vd2gTD
	 rgZa17svz9piz+h/us3g0u/t65L22Rx6omw6szVF+pPpPKhwyntz+gyBkHfKjgE4Gd
	 CNWKL2zu1JQ6w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91321810FE; Mon, 24 Mar 2025 15:12:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCAF805C3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ISJ6ywMp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 695D41029025A; Mon, 24 Mar 2025 15:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742825529; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=p22+M3kv519HXqtxif8xuIBgNBRc5Lsrh3BLan9/Aac=;
 b=ISJ6ywMpCLyLQJv1AZD2xzAtI7hzq3tJYK8Q/AkJToWiQaZysHCx05roF+iKfP1Le2FaZL
 lC5utKfgYL5scoK7c2E/EyICu4dkLIrWjWzDYibQHDiiXGNYtmjAH+fXeJyrQ25rabTDbs
 RR7/WAi9jUBeeR+ItHZNABO1MhMJoTcX4AODKmCJM+5cLyTl4EXYtGL/CUvvUkLDQYt+K0
 Sakd7iLztVqEc3pGwvRw12o3MXmYLdSlLFEAMbUDhhYeiGeymkKh0iqHtqBvCeNl4b2g2u
 eA/Wo8OQ6YUrB4CpGjcQJ180XEtXOyQwrwHg69iyMCi8slWu0UIqusHNnmlA3g==
Message-ID: <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
Date: Mon, 24 Mar 2025 15:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb:composite: data abort on second ums launch
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
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

On 3/24/25 11:42 AM, Zixun LI wrote:
> Hi,
> 
> I encountered a data abort on the 2nd "ums 0 mmc 0" command on
> u-boot-at91 2024.07 with sam9x60-curiosity board.
> 
> U-Boot> ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
> CTRL+C - Operation aborted
> U-Boot> ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
> data abort
> pc : [<27f93428>]          lr : [<27ef7e80>]
> reloc pc : [<23f16428>]    lr : [<23e7ae80>]
> sp : 27ef4cf0  ip : a5200000     fp : 23f6915c
> r10: deadbeef  r9 : 27ef7e80     r8 : 27f7d2a0
> r7 : a5200000  r6 : 00000000     r5 : 00000000  r4 : 27f01668
> r3 : 00000000  r2 : 00000000     r1 : 27fe1d88  r0 : 27f01668
> Flags: nzCV  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 45ac d017 68c5 4667 (60fd) 60af
> 
>  From backtrace the abort happened in fREe_impl(), with some debugging
> I've localized the abort in fact happened in fsg buffer allocation in
> fsg_common_init() [1]
> 
> It looks like the buffer is not freed on driver unregister since
> fsg_common_release() is only called if fsg_common_init() met an error.
Can you reproduce this on u-boot/master too ?
