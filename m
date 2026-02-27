Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD68FD7F98
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 12:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D53D83BB1;
	Fri, 27 Feb 2026 13:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p0UNDx9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410C883D1A; Fri, 27 Feb 2026 13:01:38 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9D283AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 13:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fMn3w4yZyz9v9m;
 Fri, 27 Feb 2026 13:01:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772193692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIJLEb/54n8ROxjZLe8+0Hv6FrjF74h6p7STeDqmzXc=;
 b=p0UNDx9D5GSXgMaIZsjstrSQPqYPWQ8m5rDphW47xWHVUE21FbcGXbWJmt4uXI7eiyVjPP
 b67Ud5RtxVL+55m926umtLwQihtTfqt3mp5kXWJzwsU5sNVE6vr8owBzI5mDWAqIT5gPzF
 nbp18+zTeFD7EHM0AR39p6ErKJ/nFYZfB9qqqsrud7mQbswwJbmHQh9Iqop4TWQCprcJ51
 i5JGo3aQq3tYrLYQ3afHNtJs/be8PpuLP+dpYcdpNUL6C8qHFIDvIjmv03X7xMF+Ob5swX
 Y8dQFbMeUHKXWwEBJhdyRyF4xrFFhHRuNMVNIEABhEKgHA/3pEoJC68aVOYxqg==
Message-ID: <321c50e3-2557-4b46-924e-13e66281f1e8@mailbox.org>
Date: Fri, 27 Feb 2026 13:01:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: xhci-dwc3: Call xhci_deregister() before
 asserting reset
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260224151828.20838-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260224151828.20838-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: io7m1cujn5jiybrnf6g4r9n46fyw65de
X-MBO-RS-ID: 50f30be4d011cae7c5a
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

On 2/24/26 4:18 PM, Boon Khai Ng wrote:
> Reorder the remove path to deregister the controller first (and return
> early on failure), then shut down PHY/clocks and finally assert reset.
> 
> This prevents register reads/writes after reset and avoids undefined
> behavior.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
