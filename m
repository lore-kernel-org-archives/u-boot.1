Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A98CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 03:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC21848A9;
	Thu,  4 Jun 2026 05:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DWTIOJx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29373848DC; Thu,  4 Jun 2026 05:57:31 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D3D8467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 05:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gW9kZ29Pyz9t1g;
 Thu,  4 Jun 2026 05:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780545446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHyAgT1mUbUYSnAmkfer0/iNs8UNJS1CfVtJixXy3Jk=;
 b=DWTIOJx6eVE806ICu3J1sXxT3CxvZEPv1+5Cee7W2XSad6Jh8geDJKz3uyPAG5LFXfK22t
 chghkVT0RsUI/8uXO9+DLvmx2KEj81bUjvfI5pm7T0DP7HLbxCOnqMytrwgt7iEhslHjiL
 /ArPcEOpEHzay7BvGAnuDiAaUqfUUBPfu9hSzrVFdg03sVINijER80o70GgIpm3lWhDZP3
 45tBzz5bFjhJglQ54jkeTSTtWot2djY/TWbnXhHabjzPXvISCwI4eTWIEb+wEiqqDo9uGq
 d4bjer6ULTLmDS5inA8IQM348ZpuDzPksxURUGXhC8tZyK337gBAsv8smAc0/g==
Message-ID: <81507d81-3be8-48f2-8501-eeb41f35fd4c@mailbox.org>
Date: Thu, 4 Jun 2026 02:54:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 02/10] usb: Kconfig: add SPL_USB_DWC2
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
 <146467ba-dba2-4a31-81b5-8cfdf24e6bb1@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <146467ba-dba2-4a31-81b5-8cfdf24e6bb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 16c5ec3c606de00b1b3
X-MBO-RS-META: inetjkjro9i9nqbte1b3mmz481h41i67
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

On 6/4/26 1:49 AM, Johan Jonker wrote:
> The config SPL_DM_USB gives the user the option to be more
> selective in what phase the USB drivers should enabled.
> 
> Pass this concept to the dwc2_usb driver and make a SPL_USB_DWC2
> config available in SPL to load U-boot (full) from a USB disk.
U-Boot
