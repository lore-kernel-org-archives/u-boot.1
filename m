Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45637C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 21:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D65281DD3;
	Tue, 28 Jan 2025 22:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738100213;
	bh=h8BmdtnQXV6eCD0wjPDstqjBIsJH4fxT/xFxQjGpBR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bWRJuEt6pGYc9HknSjKyuKhZiyqNJlA8rgdTxSM3GEcFVUs7vU7r7IbSsXzMK5bg4
	 oEVpexAWMYGKvCfYPJUusueYt5YHdPLUZET+4QBWbDNklrya2Jk7XfPkHTDCmLFojq
	 SC2bZA/yyb3vprPVCKYIf90wLzENbDtGA3lTAzc8VK2nhr4QPrlH7Ko3kvI9AwEfFu
	 9getZf7zQi6gwDMbaRNhhL/+ifKBmZLxzTUxliYdMk6q9fdPudBNi6n5GFkE+tHGyZ
	 93vwCsph9AKe6f7LKAS10yFxiG80x+G7dk+zZG2kLmOGzypTT6p3Hqbffs3gJyBx8v
	 hZ6GxBBhaI7DA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B1181DFA; Tue, 28 Jan 2025 22:36:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F6481D27
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 22:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CIhLYX/w"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA6D110382D08; Tue, 28 Jan 2025 22:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738100209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8BmdtnQXV6eCD0wjPDstqjBIsJH4fxT/xFxQjGpBR0=;
 b=CIhLYX/wk8DFNAF+8Hu0xE0SywY1QnRMWOK73V2K0ogLcvi5LWqGtUvfkfLUaRJ2bdjcw+
 6X+wdIRfDpYKZL+Y4n5pveAgIgKBYmX0MHvD70Tfx4R4KaBi/EenBb/0j4QptRgyPG29HF
 TqqFyeGhbvkA7V3ErbG+BPFQT4UVGZ+PTnra+jxwe6Pk+Jh444K8dpFYFN0SnovzX2MPqW
 Ub5AdCMQcWAXmO45IMEER9WeByBkif2kGLraRYuPJjjxQYkETyY5FEbFgb/VyVlPdHOzeC
 yoRzGu29hhm0Z8jbXGQnyGBNQokP0UIkivnqmBh63k/bPCKTuP5PSDUXbyo7TQ==
Message-ID: <84a3ccfc-3d35-4018-9978-2c320f00e33c@denx.de>
Date: Tue, 28 Jan 2025 22:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] usb: scan multiple buses simultaneously with
 coroutines
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dragan Simic <dsimic@manjaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <58d6721203ea81b9c20f162ef40f79bc73243a42.1738059345.git.jerome.forissier@linaro.org>
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

On 1/28/25 11:19 AM, Jerome Forissier wrote:
> Use the coroutines framework to scan USB buses in parallel for better
> performance. Tested on arm64 QEMU on a somewhat contrived example
> (4 USB buses, each with one audio device, one keyboard, one mouse and
> one tablet).
> 
> $ make qemu_arm64_defconfig
> $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
> $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
>      $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
>          -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
>      done)
> 
> The time spent in usb_init() is reported on the console and shows a
> significant improvement with COROUTINES enabled.
Have you considered using the cyclic framework ( cyclic_register() and 
co. ) to fully offload USB operations away from the main thread, i.e. to 
make the U-Boot shell and e.g. 'usb start' run fully in parallel ? That 
could then be extended to block transfers, which could run in 
background, and ... we would also get a concept of shell pipes to move 
data around like we do in Linux.
