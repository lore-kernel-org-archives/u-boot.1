Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B0CD8C8B
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 06:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B6D838D7;
	Sat,  6 Jun 2026 08:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DHlWIIZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD05839DF; Sat,  6 Jun 2026 08:32:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA1A83314
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 08:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gXT4V1F13z9t0F;
 Sat,  6 Jun 2026 08:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780727546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGNPdnNqa5ZCVzFSwn7jHR4Qaat7GyQBy11baGnOCv8=;
 b=DHlWIIZZhPuUi7khE/9O6wPg20Dw0vBh+nse7qxEfI6ROVKNJiJoCSFMKW32MHtX+Z4J7Y
 0GlIRGL+LljBFgGulsqSfdJYb15C0LEEK7+WYzESZ+25qPdvNMpKn9NumgVx9DdEUn0zxe
 aN4GIpBMaX3xNe8lJuQYReNKN/DMQv/VwvlpUeP7XhPxSPZBW4duX0ovD3hRLA+DepyQzN
 aEBO4tXiBU3hh7RRREUizEqk+LbMyCn2yuYPIopSSIvbymsxCfSH4/P7HI8xml37Yx+ALQ
 bQrkR9obEwYiG7ibjVHI9P3PXxKc7avbJzOnbeXqQkqFdKl5Av0w2JvKQ7XCbg==
Message-ID: <98b9ff7c-0e4a-497a-a54b-dac618e3e46c@mailbox.org>
Date: Fri, 5 Jun 2026 16:30:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] usb: gadget: atmel: use calloc() to allocate
 endpoint list
To: Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260605-udc_malloc-v1-1-ffe202cd2656@hifiphile.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260605-udc_malloc-v1-1-ffe202cd2656@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 22e3535bd7478fe8b58
X-MBO-RS-META: ncuejgsd9ooahc5cpu5ko14gbz7esyrm
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

On 6/5/26 1:19 PM, Zixun LI wrote:
> malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated.
... and that is a problem because ?

The _WHY_ part should be included in the commit message. Why is this 
change needed ? What does it fix ?
