Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AA6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 01:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F301E8871F;
	Tue, 30 Apr 2024 03:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HXYsIB3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6699788725; Tue, 30 Apr 2024 03:49:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A08C8870B
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 03:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VT35M3PqTz9st3;
 Tue, 30 Apr 2024 03:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1714441735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DDHWUJFd2elbMJcEsu3VjzoonLvX8UY6aFel+z5gH8=;
 b=HXYsIB3Y5OyNCU8oIkmJ6C5LqPVbhi9hdoaOBt4pg0CoFsG0LxFjfnhm6dNUUPqRZgQyUo
 qcooCXjTzQZq0/4FOHxyNKG4t4YGKfZLx5EUKsa96EnONSmMRnYIGs58Izcha2OL+3LE6l
 kqrRPFHT4PTXzfE7h2Mk1qfayWbpsVsQmiLDtIzpeGA1VcWUMWhVqRiwQj4DHZDPDH2HP+
 /KQ8aeeeOF2R0l5gbjzRmoQs6kVaPOgov7dpTQgCXF8X1v2Pv+I41J/tDF+IhPkpjuO5zg
 ptLaJslJYPnFC5NNFMuF5bT+OxoLzHA5DPRfy0bplTgVwANw/Z3taChqEoZAOA==
Message-ID: <d1eb5f12-0718-4a85-bfe1-3c141ee6b049@mailbox.org>
Date: Tue, 30 Apr 2024 03:48:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: 'Peng Fan' <peng.fan@nxp.com>, 'Simon Glass' <sjg@chromium.org>
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
 <CGME20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470@epcas1p4.samsung.com>
 <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
 <000001da97a2$d3247950$796d6bf0$@samsung.com>
 <e55e21af-7208-4b4d-9398-ee1e4825f69b@mailbox.org>
 <050401da9a85$b24539a0$16cface0$@samsung.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <050401da9a85$b24539a0$16cface0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ftsmhntk9dadfyimxpz6ji6qbgdkdthj
X-MBO-RS-ID: b2d81e36e215aa429fd
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

On 4/30/24 12:36 AM, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Friday, April 26, 2024 8:41 PM
>> To: Jaehoon Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
>> Cc: 'Peng Fan' <peng.fan@nxp.com>; 'Simon Glass' <sjg@chromium.org>
>> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>>
>> On 4/26/24 8:27 AM, Jaehoon Chung wrote:
>>> Dear Marek,
>>>
>>>> -----Original Message-----
>>>> From: Marek Vasut <marek.vasut@mailbox.org>
>>>> Sent: Wednesday, April 24, 2024 8:18 AM
>>>> To: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>
>>>> Cc: Peng Fan <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>
>>>> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>>>>
>>>> On 3/16/24 9:13 PM, Marek Vasut wrote:
>>>>> In case the cyclic framework is enabled, poll the card detect of already
>>>>> initialized cards and deinitialize them in case they are removed. Since
>>>>> the card initialization is a longer process and card initialization is
>>>>> done on first access to an uninitialized card anyway, avoid initializing
>>>>> newly detected uninitialized cards in the cyclic callback.
>>>>
>>>> Any input on this ?
>>>
>>> When I have applied your patch from patchwork, it didn't apply directly.
>>> If you're ok, I will apply after touch your patch. Is it ok?
>>
>> Sure.
> 
> After touching your patch, I will inform again to you.

btw. what is the problem with the patch ?
