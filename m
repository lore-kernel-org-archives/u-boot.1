Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB74C44501
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 02:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D129B8497A;
	Sun, 12 Jul 2026 04:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jIcpFW3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB08784A0B; Sun, 12 Jul 2026 04:15:11 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6096848A1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 04:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gyTfz0lfPzKn78;
 Sun, 12 Jul 2026 04:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783822507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tnnihez9Hk7LyAxLXBzv6LuwbAvihTX4so5izo9qTIs=;
 b=jIcpFW3Z0ronNF+TTQ99dnCSMvKRwoowOZmaKaIGgHe8bs5r5MLFJyN1bVUVsqs3rVx18G
 +oSoOUoGxi4uim3ulCcz2KSoRDtjgUTXQ3kxfVN0wU5JCW/tsOr6eU5l0bjUJ4EN5CTmZh
 +8X4r+VTIqYw11btL/GnU9cO0blx/PEqrLCQrlkD8BfRXf3Hkl1xL7MdTzwN61OuMHsk9x
 /f49Zh+FS482QorXfb96Bm1JSTsmtXvUW8v3jQfBd4si8eJbQmgRs/NyTuj8zCn8Gf3nab
 ZmsILwexpZ63G8g8AwpTUFRxF2VXU8Y4+amhN6ZPhqbGDZwF9betdpycQQJHSw==
Message-ID: <2801bed2-d476-4b4b-b531-b182ecc5210b@mailbox.org>
Date: Sat, 11 Jul 2026 21:57:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] usb: eth: Add CDC ECM support
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-6-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260711160808.2022242-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d714dc64a4b39433fe2
X-MBO-RS-META: c5xssss98du1bwz14x36xwcaz1mykimt
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

On 7/11/26 6:08 PM, Jonas Karlman wrote:
> Add support for CDC ECM (Communications Device Class, Ethernet Control
> Model) devices.
> 
> References:
> - [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
> - [USBCDC12] USB Class Definitions for Communications Devices 1.2.
> - [USB20] USB Specification 2.0.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Is this pulled from Linux or is this written from scratch ?
