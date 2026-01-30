Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1010D73EB2
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBC2841A2;
	Fri, 30 Jan 2026 03:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZxUfYvHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF8C84199; Fri, 30 Jan 2026 03:15:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C0784181
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f2KNv28Zdz9vCt;
 Fri, 30 Jan 2026 03:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KENWgaqq/8/ccxrmK9yYmvr6YnWrOF9LOHTSe1N+5pI=;
 b=ZxUfYvHh1q9AbDG6bVelN1ZXn2Gqb0wrL/Qkz93K0+UFMu/ZTbwKCN1zgnIhwsNb/O3LOL
 HEm8yLMSH2K+BXOgPSK+xyyBbeyz7hRASzT/pWfZqYxPak+quHbMRn6Fwy34J2N4sN9zH/
 1+V4pE9PYzKOLkZJ7IrzgiRffLnwTHNBje4HqLCBrLhaQaPn28SBTzLXrfu6Csc/y0s/eo
 LqC0OLzJ2eYlbqVK4Oo0ICHv0CyBItq+w/6TTu4N5qg1hzjBUViownLfSVJZsebNHWQogd
 jx31pMaKFbX64g55qBblasqtbCqjYT7g1GLNIoBHMQpbyDYGEfdOMJz9HEUmTQ==
Message-ID: <b251561f-936f-44be-bd01-eb1d08c0bdfc@mailbox.org>
Date: Fri, 30 Jan 2026 02:26:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] usb: eth: asix88179: Use a fixed URB buffer size of
 16 KiB
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-3-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bcb13b480597c52170c
X-MBO-RS-META: 54hos9uzsggoz9ru6n78jnhh4d3abrwt
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

On 1/30/26 1:29 AM, Jonas Karlman wrote:
> The commit 05278af8b3df ("eth: asix88179: packet drop when receiving
> large fragmented packets") adjusted the URB buffer size to allow large
> fragmented packets. However, this change result in use of a large URB
> buffer size for slow speed connections, e.g. 10/100M use 26 KiB.
> 
> Using a ASIX AX88179B USB 3.0 or ASIX AX88772E USB 2.0 Ethernet adapter
> on a Rockchip RK3528 with a DWC2 USB controller this large URB buffer
> size result in invalid rx_hdr and result in unusable Ethernet.
> 
> The data read back from AX_RX_BULKIN_QCTRL after being configured also
> does not match the values in the AX88179_BULKIN_SIZE array.
> 
> Change to use a fixed URB buffer size of 16 KiB to fix use of Ethernet,

Why 16 kiB and not something else ?

Is this a USB controller related problem/limitation ? Maybe the DWC2 
driver needs fixing instead, to handler larger buffers ?
