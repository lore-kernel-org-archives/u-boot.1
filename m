Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99406CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33BF847C3;
	Wed, 24 Jun 2026 19:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XI9d+Aze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE87847C8; Wed, 24 Jun 2026 19:10:27 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971F98460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4glpNH38FRz9tsW;
 Wed, 24 Jun 2026 19:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782321023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5MT0KRataUY72Hf4oTFmFW1YuE5gA0RwyzB4mbep0I=;
 b=XI9d+Aze3HLeBvfONHRijhpa0cW5N0Ws8ttUdpZbcyPc8C0YiEPDtnlOiuHepz8uhOAhos
 VSFZy1qeRUHhyGpeB/hsVpZzVFxW77w/CDfuO5yOgPivXf4ECgxyyeW86XboPMYtX5NMyF
 W916DsZ+DVJORD8SMGBZad4jtV4w1XXVGQOVqrU7cbrHA+a/ZRN3M+gbNtVFb8DHzcQ/+I
 OpmCOqcOT4trrCwUOfcnxmIXEF6asU2hawEZcfoi1twGU5ZZUcZWTXrabUK5ZXKZhS9VPt
 iMuzkb4bJ6OnH0ixOZdoJyR9K3v2NsEhsuMSPxqhCUE46Q2ZtNi9IQrDwX5hCA==
Message-ID: <8381c99e-ad00-4686-b1d7-a2b90dc89dc1@mailbox.org>
Date: Wed, 24 Jun 2026 19:10:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
 <14653d07-924c-46bc-9d3a-f1681e85053b@cherry.de>
 <317edc52-aaad-4778-bae3-7ce177f49e84@mailbox.org>
 <171792c2-fd8a-453f-8eff-a5b3f44adbf9@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <171792c2-fd8a-453f-8eff-a5b3f44adbf9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: s1wiu7iirysq3wkumprf4wod7whncmck
X-MBO-RS-ID: e33d2c0c82d48f774e0
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

On 6/24/26 5:22 PM, Quentin Schulz wrote:

Hello Quentin,

> $ ./scripts/get_maintainer.pl -f common/usb_onboard_hub.c
> Tom Rini <trini@konsulko.com> (maintainer:THE REST)

Sigh ...

> and this patch has been sitting reviewed for 6 weeks and the status in 
> patchwork is still "new" so I thought it somehow got lost. I did miss 
> that you were the delegate (or did this change recently?). My intention 
> was not to bypass you, my apologies if it was taken this way.

No worries.

> Would you mind if I send a patch to MAINTAINERS to add common/ 
> usb_onboard_hub.c to the USB entry so that it's clear you're the 
> maintainer?
I'll send one, and an update to email addresses in general, thank you 
for the reminder.
