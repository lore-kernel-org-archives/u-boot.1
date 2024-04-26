Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D5AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 11:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AA389083;
	Fri, 26 Apr 2024 13:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uu68TCZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F63890FE; Fri, 26 Apr 2024 13:41:12 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CB88903D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 13:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VQrQX1Ml1z9sWd;
 Fri, 26 Apr 2024 13:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1714131668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cf72ZBs5GBDKm099w0lDkdo4mgE5gd/p1ZUNDjLcfOI=;
 b=uu68TCZ7OxpUWgm/pjZBRK7EeZBI6ob2DkRQ5oB3XNzeh5MJKXkmWqYwzqPjy+uKgHUBmr
 fXO9fZB0H5CyBHTNahTC+td/lV5FLbK/nxBT1ORjpxj0QcqLM/VvK9X+MyCeFcpj2N3kr5
 L1lKexjZGXAgRmPN7+uhNfLx0g5KhmqFYaJUkK0jlYDIzJryoZ9us/8Cqky02VIJ2boWel
 fSVhUQ+fVTaQ/6hTrnvL4JkhHctwR1Jwxv4vpczDNZrMzH9N9FSWKnmEYTfUxSfAarNgZW
 PQSpjXZVlBGVm6XgHFvJx+/LLSa+Nur9kAz5TBBcmMdVJB/bRWBJfDit+0i3Bg==
Message-ID: <e55e21af-7208-4b4d-9398-ee1e4825f69b@mailbox.org>
Date: Fri, 26 Apr 2024 13:41:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: 'Peng Fan' <peng.fan@nxp.com>, 'Simon Glass' <sjg@chromium.org>
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
 <CGME20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470@epcas1p4.samsung.com>
 <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
 <000001da97a2$d3247950$796d6bf0$@samsung.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <000001da97a2$d3247950$796d6bf0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: juu7gk7herz1uydacfz4mqyiq8xph5ap
X-MBO-RS-ID: 2014cb48a170c09852a
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

On 4/26/24 8:27 AM, Jaehoon Chung wrote:
> Dear Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Wednesday, April 24, 2024 8:18 AM
>> To: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Peng Fan <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>
>> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>>
>> On 3/16/24 9:13 PM, Marek Vasut wrote:
>>> In case the cyclic framework is enabled, poll the card detect of already
>>> initialized cards and deinitialize them in case they are removed. Since
>>> the card initialization is a longer process and card initialization is
>>> done on first access to an uninitialized card anyway, avoid initializing
>>> newly detected uninitialized cards in the cyclic callback.
>>
>> Any input on this ?
> 
> When I have applied your patch from patchwork, it didn't apply directly.
> If you're ok, I will apply after touch your patch. Is it ok?

Sure.
