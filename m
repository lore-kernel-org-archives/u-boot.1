Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D0AF8FA7B
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3AE83BC4;
	Tue, 21 Apr 2026 15:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j4AOv95c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6398C83BC8; Tue, 21 Apr 2026 15:33:24 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD7283A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g0NbL6nnJz9srT;
 Tue, 21 Apr 2026 15:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776778399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YgbI0qlshRBmg5x6S8H6amNJl1onYXOCChkyGaTprc=;
 b=j4AOv95cA4y6jUgvrqeSmJgW2l9NNLy0wFu2Ls6o45smnWDo3yqEVlHB08bLKS1OrTshXD
 mMs/CGnP5mQOk1b3xzXs7X1ugv74TjO5+VLIPaCT1STJ7eupphUwQAq5kJOxyXweKB8WIf
 k+cPRGFaWcxUMv99A6oBJhaxzEHKwmiZxj/fTbrIHp7Ew5FvROTKS3K9Hd5KaImsOW9aLs
 0e1pOUknDXnpkLOZ/fcHmauPaX/oNuRswNymc8XU7sPfHCVKjpm/3edl2z7Z1IezJUcm7X
 rMg27g4IY1THPv6ysnDPO9mrShu/QXVYGA5S9CDVZAtn/Ke+1ZH/s7irSll9kQ==
Message-ID: <1d13b276-429d-4b25-8568-b6f1b9262c98@mailbox.org>
Date: Tue, 21 Apr 2026 15:33:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 8/8] board: ten64: start USB stack in late init
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-8-eaa81288e393@traverse.com.au>
 <81f45736-4304-4d3d-b073-a34646d13407@mailbox.org>
 <d33dfdbe-f5d0-48ac-a2ad-5081d72fac01@app.fastmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d33dfdbe-f5d0-48ac-a2ad-5081d72fac01@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7yre6oofjnettyfmfgdzeb81se8spsfk
X-MBO-RS-ID: 338f28f6677efb5d327
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

On 4/21/26 3:29 AM, Mathew McBride wrote:
> Hi Marek,
> 
> On Tue, Apr 21, 2026, at 10:44 AM, Marek Vasut wrote:
>> On 4/21/26 2:04 AM, Mathew McBride wrote:
>> [snip]
>>> + /* Ensure usb storage devices are available to bootflow.
>>> + * Additionally, if there is a USB hub on the board,
>>> + * it needs to be started to become usable both in U-Boot
>>> + * and in any booted OS.
>>> + */
>>> + if (IS_ENABLED(CONFIG_USB_STORAGE) || IS_ENABLED(CONFIG_USB_ONBOARD_HUB))
>>> + usb_init();
>> Why not place 'usb start' into 'preboot' script instead ?
>>
> 
> I was not aware of preboot, but it looks like that will solve this issue nicely.
> I will roll another revision with CONFIG_PREBOOT="usb start" instead of the usb_init() call.
> Thanks for the tip!
Excellent, thank you.
