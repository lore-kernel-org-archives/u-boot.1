Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7464C54798
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 15:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0E387D26;
	Sun, 25 Feb 2024 16:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="AK54ryT5";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIT3D+n6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DF987DEC; Sun, 25 Feb 2024 16:28:46 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E6B87D26
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 16:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 4C6E83200A06;
 Sun, 25 Feb 2024 10:28:38 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sun, 25 Feb 2024 10:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1708874917; x=1708961317; bh=P+oZYz1CBa
 tTnWBRQmgaBxJYEVx4mXafL25G8t9Ow8Y=; b=AK54ryT54c5VfpoTmwUYZMBBlS
 LJ5KbEN2oE8B12bpLhNjpQoFs8J7E58TmUOlOthJdCT0mTa72D7G7ZELQMgcHsvw
 SfibmEC/bdzlzpbKEIe6Ko52OMc7BojIx6sVWpuDIOjsFzM2xvPmymA3Uc3qv2TG
 5McZPZ7eIORPJYslCyizFP6ltONLSAISvjn55FP3ocUn/0qJs8C5OZizN3OtHgfH
 o1zZ24qIycjPbs1lWUIWcxOkbddDYRwCmhydRcdtr83uH/QB1lfT5uG364aFOfov
 iTJK4qCUEGENpyQsCTEyN1y44XI5XhLuB69tjOYZnHjfF43HmI33FQyRCPhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708874917; x=1708961317; bh=P+oZYz1CBatTnWBRQmgaBxJYEVx4
 mXafL25G8t9Ow8Y=; b=fIT3D+n664QZ5qdwQKXf7898PQJDNclmuA2m1WsSGZ8j
 T9OgbmghJU2gdYjZAB3CqEnkluNTyqI2FrFRkXUXPTpk6BvVT1RDBWWqHCDe0Yf7
 sHzJYNuxXOZGOmi2D2JaUxfMC4J3izdQdzeNcSjRRiJqdM6qqbUMKOPDxm+SH6+t
 THKcLF5BOt/Ai1F3ozT1z4QTntQk1Q/TlqNyXUqF4u60tX1hMBjaPzh3F4oER832
 YvFURuYzt/ee1UdP/9vEYmGDpRjBqtwaM5OHgaIjoV81kQ8zpJjOE4uKs/4Lg15b
 doTJnn5Z/ioplAk8NK4wTyv8sPOPifS3+M9ZP3Opjg==
X-ME-Sender: <xms:pVzbZWRyaYwo-g81BlVMXyW4UbaiSkESZ8G3aOcUGk1DKfFEWre_bw>
 <xme:pVzbZbyo0fnmp9oA0upAM__CRGQtCLzPRBspz1xlIqCvukhjA5F52yo_Yn4AOCfe9
 hYkdqkyXwEt_GesxfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedtgdejhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghn
 nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
 hnpeevvdfhtddvvddtgffggfeuteduhfeigeevfeffueekheetffekjeehjeefhfeitden
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrg
 hnnhgruhdrnhgvth
X-ME-Proxy: <xmx:pVzbZT0YjkhrQ2IxNnstNVFZqy55YyMjMhnyV1npPnfHZvt4yMq0VQ>
 <xmx:pVzbZSCMZhFUw6-kv9Urjv39ayWTDyWu4El_fJ5h1IQG6EDev4YMVw>
 <xmx:pVzbZfgtUrRikutNT5UqR7U1kn1MuZMAVjGja8T4I00tg0tLu9i_4Q>
 <xmx:pVzbZSsCyLLsk5m0_gcgpGnmB7dzjpF-i_aBLTmeLYwp9pJMaIYBNA>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 713EC364006F; Sun, 25 Feb 2024 10:28:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <b0c41f38-abf0-4713-a80a-c78f074b7b4d@app.fastmail.com>
In-Reply-To: <9cb3370e-770a-40e6-b890-ae9b5a15bd44@denx.de>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
 <9cb3370e-770a-40e6-b890-ae9b5a15bd44@denx.de>
Date: Sun, 25 Feb 2024 16:28:13 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Marek Vasut" <marex@denx.de>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
Subject: Re: [PATCH 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
Content-Type: text/plain
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



On Wed, Feb 21, 2024, at 13:39, Marek Vasut wrote:
> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>> From: Janne Grunau <j@jannau.net>
>> 
>> Apple USB keyboards carry the HID keyboard boot protocol on the second
>> interface. Using the second interface in the USB keyboard driver does
>> not work since the xhci has not allocated a transfer ring.
>
> So, what does this patch do ? That is not clear from the commit message.

rewritten for v2:
| usb: xhci: Set up endpoints for the first 2 interfaces
|    
| The xhci driver currently only does the necessary initialization for
| endpoints found in the first interface descriptor. Apple USB keyboards
| (released 2021) use the second interface descriptor for the HID keyboard
| boot protocol. To allow USB drivers to use endpoints from other
| interface descriptors the xhci driver needs to ensure these endpoints
| are initialized as well.
| Use USB_MAX_ACTIVE_INTERFACES to control how many interface descriptors
| are initialized and useable. Currently defined to 2 as that is enough to
| make the Apple keyboard usable.

>
> btw. missing SoB line.

added

Thanks

Janne
