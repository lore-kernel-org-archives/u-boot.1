Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F04E7BD95
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B9D80FA1;
	Mon, 16 Feb 2026 12:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SyOdCZKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E55783AA9; Mon, 16 Feb 2026 12:19:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855D18063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fF0fg0g9cz9twH;
 Mon, 16 Feb 2026 12:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771240779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/9QYbfxDU7+4qyrnndPXGHVVHBqySF1w3l4Odwd59U=;
 b=SyOdCZKZHNicLIlAKiWpsAGsGpIvs+B2jD1RMG6grGTpu4SDULqRdvOBNVqsazT7L/+ZAQ
 JtC5UA1WTIXBr0rzoKh40sTcE25RBcaTZjMz05lWZnWzKcWwFjhKCDMOB1JB03vB83VVLg
 g6era0lzp8+CgHBUaw7+rodX88Am8Xo5TlpvszBSUyZmVQjMCtl1y28ge7hQus40fW+FK0
 tu/7X6RvHooA2Gk0dNUhfPobGo43/ByJnf39Z0nM7quOhB18td+ETck4mXlKnnScfNfi3t
 Z/x9S5IM9vF+xp6g8Cce2cGDx9t4VJYUF1C4lGslGh8PEWA6af5X2LtJAQHIQA==
Message-ID: <51b791ff-6687-4a03-aaf6-bea27e8a8d25@mailbox.org>
Date: Mon, 16 Feb 2026 12:19:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/11] imx8qxp_capricorn config: add wget command
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260214045703.28051-1-hs@nabladev.com>
 <20260214045703.28051-6-hs@nabladev.com>
 <1a1b9dc9-0ad5-43b9-a8b7-fefb1eb6277d@mailbox.org>
 <2a270c8b-60a0-73eb-5f1e-e149970cf97e@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2a270c8b-60a0-73eb-5f1e-e149970cf97e@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 16e8d8a3411da0c1846
X-MBO-RS-META: h3jbrbk5ex7ga8g6pw95mymhpmn6sbdk
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

On 2/16/26 11:53 AM, Heiko Schocher wrote:

Hello Heiko,

> On 16.02.26 11:15, Marek Vasut wrote:
>> On 2/14/26 5:56 AM, Heiko Schocher wrote:
>>> From: Walter Schweizer <walter.schweizer@siemens.com>
>>>
>>> Faster than tftp.
>>
>> The commit message could use an improvement .
> 
> changed to
> """
> We enable the wget command since it is faster than TFTP transfers.
> """
"
Enable the "wget" command to allow download using TCP / HTTP protocol.
This is faster than TFTP download.
"
