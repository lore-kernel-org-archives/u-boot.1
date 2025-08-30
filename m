Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4964FCA0FF0
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 00:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF05A83542;
	Sat, 30 Aug 2025 02:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oGgtWcw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C76835EA; Sat, 30 Aug 2025 02:00:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA9383526
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 02:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cDFdm2mnXz9shw;
 Sat, 30 Aug 2025 02:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756512044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRJThMGoyz3v+LFkZ5/dVh7GlOmqY2do1D2AB+fGjzk=;
 b=oGgtWcw2Nqpcrr+zcmRueFzZNZxT/FOgW6jcn8oz67EVAVqGD3lvPC/NoFuYe8C/gmTe+E
 xCCiMXStYuWHfy58WKtApzJIxX1pI9O2seH7zfR6XcHFvyaEvzjGnTmwJ140p1xrNnFuuU
 gwUKA4wESkKWy67hb+wSBCBirdLXmuueWobiKOX3RDVTE8MthBLu4moWvVrnZbuZzcJcmR
 n6Rj3ZVUYntCPprlMgmqsGiiAn698aKP83KIOpMZjXq+f5OGGU/VWM88GXUY26GL7X1Wkm
 m8TS62A5lrMiT2DAjqiX4Njd9WLLgv8SycSC8nAiaQjDDhEo+rGUfEJSlfmfdg==
Message-ID: <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
Date: Sat, 30 Aug 2025 02:00:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5df740eb1546888ab21
X-MBO-RS-META: fmc57afag13yhnma65tikmtwef9ztaye
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

On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
> 
> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>
>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>> Some USB devices need more time to be initialized. Hence,
>>> increasing the default USB Hub debounce timeout value for
>>> devices to be discovered, connected to Agilex5 boards.
>> Is this really hub debounce timeout or usb_pgood_delay ?
>>
>> Which devices are those, include that in the commit message.
> 
> Yes, timeout is related to USB connect/disconnect signal bounces not 
> about bus stability during init.
> 
> Issue was mainly observed with legacy flash drives. Maybe I will change 
> commit text from "Some USB devices need more time to be initialized..." 
> to "Some old USB flash drives need more time to be initialized during 
> connect or disconnect events ..."?
> 
> Note that I am not modifying the default Kconfig value in general; 
> change is only made for an SoCFPGA devkit we tested.
Does this same issue go away if you set usb_pgood_delay to 2000 or 
higher too ?
