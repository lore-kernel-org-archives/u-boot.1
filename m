Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A5CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54E684852;
	Mon, 13 Jul 2026 02:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TMU47qwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EABD8494B; Mon, 13 Jul 2026 02:52:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A865882991
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gz3nL6VtGzKv6w;
 Mon, 13 Jul 2026 02:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783903958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXHph85Xoz5nMXDcFA2MZeeNNAhFMzSugjuWi4gA2H0=;
 b=TMU47qwtBuXO+lToKNytZJQ4NNAdCzkN6MpHMZ3LoYVT4l+m3/YYQUqKj0hP95mVBzxs/9
 ulrEn56NTF5n83YWUOkDph7XkRG99zmmA8Rh2VlVU662I/Rjmp1+6UBGPPO/RfxFwYFc1v
 uSJeGBc+Rhfw3UmSAQQaerpa5qmyk+FKMi5Mx58dNc0PlLjf+XrKBRjohOOeqA3H2zDKQr
 jWDZTNX1mr751zRb904Gt551r4w2k7FTatFbPepsbZs0PtSKjUM20dm70Y0pw/ITLHGE97
 +T6jMW7DQw9Mdg6VKbtGC10kcbZ1sYOywwWggErJVQeI4fmaOo1HrKKJRhTzJg==
Message-ID: <669c9f59-d912-43e0-91ad-2b2f83cc7182@mailbox.org>
Date: Sun, 12 Jul 2026 15:21:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] usb: eth: Add CDC ECM support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-6-jonas@kwiboo.se>
 <2801bed2-d476-4b4b-b531-b182ecc5210b@mailbox.org>
 <e46068aa-1276-4501-af7e-db841de7e291@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e46068aa-1276-4501-af7e-db841de7e291@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 004493d251d3961e15d
X-MBO-RS-META: 6k15egmspszryy3qbb6zcconotfxi4gu
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

On 7/12/26 11:08 AM, Jonas Karlman wrote:
> Hi Marek,
> 
> On 7/11/2026 9:57 PM, Marek Vasut wrote:
>> On 7/11/26 6:08 PM, Jonas Karlman wrote:
>>> Add support for CDC ECM (Communications Device Class, Ethernet Control
>>> Model) devices.
>>>
>>> References:
>>> - [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
>>> - [USBCDC12] USB Class Definitions for Communications Devices 1.2.
>>> - [USB20] USB Specification 2.0.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Is this pulled from Linux or is this written from scratch ?
> 
> As stated in the cover letter this driver was written from scratch.
> 
>    The driver implementations was created based of the CDC ECM 1.2 and
>    CDC NCM 1.1 specifications and was tested on a few different USB
>    Ethernet adapters using ASIX or Realtek IC.
> At some point I looked and compared to Linux to ensure ordering of e.g.
> control messages and size limitations where closely matched.
> 
> In more detail the NCM driver was first created and tested on AX88179.
> Later when tested on RTL815x there were some issues, so I also added the
> ECM variant and tested that on both AX88179 and RTL815x.
> 
> The ECM variant is likely enough for U-Boot purposes, however NCM still
> has some good features such as custom MAC-addresses. So, I included both
> in this series, with NCM being preferred over ECM due to driver list
> sorting.
OK
