Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA47E88D6D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 22:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F7E8413A;
	Sat,  4 Apr 2026 00:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uN3nQayz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BdtBSEZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B0684106; Sat,  4 Apr 2026 00:48:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE1E84106
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 00:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fnYmh4NSgz9tZt;
 Sat,  4 Apr 2026 00:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775256532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt+MWonX314MDk6RQL+LmUwbsOUa7psLf8GNY5HKr18=;
 b=uN3nQayzjQ2vHme69o+YXKZCvVB/PUEIM9H5e0lx1tE8DzWdH7HnLPATgyNLiH6O8DhxJM
 fRiOByBlIEGrhKdI4W9/wegZ7L9SKV8mWCEKiFIfjsQutElpRc+waKaUobD1UIaB39LeoF
 9W4qAaapvbjU91OU2urmfZyXsZkjDOLl5gXAAHvg/IZikd7kGuMpySPjqtiPDdg6Rl8zzM
 vHQ820icuv06aosIv5094/cOa6uHkTMqfGYAH+Xb+5ka+bQb0KnzGhbmv8x4vq3/JPSAXo
 bINWEw/yp/PN1gs6A/EwEQ9EeFAnUnG+uPQZnros/ooafMm/nKtCmZ9fpe9EiA==
Message-ID: <c4978d28-2b16-4079-bb0b-22648f4d7337@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775256530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt+MWonX314MDk6RQL+LmUwbsOUa7psLf8GNY5HKr18=;
 b=BdtBSEZeN1jn03pVU4UUFkbO+MLsIVRu6Zbh8ohgU1C5+Hlrgl23FHY8UaRPCmM91J31+n
 CmQIWfVfRGJ96BFMysqn5WQAuleI8eLUD6uR8hwSGKApZ4xaxGoMzAuwWnd6bDo4S3fcau
 MSs2JtKGIbB1/7AGYRwUU3M7wuCKKifXfIHYChfmH0wQZBNJjd5M9dgEj5SA1tvR0NL5VR
 48mxVknE1XLlXvphqW0FPXgz/yL1akhG1AeWYbhML+ZNBY140BfaaC2/dq7Thob4iUPpoz
 DShQ3pLQlpEzWWY8G49TbA0RR/wc91zqJAhWh1M7WuffTUFWCsEHGxre6axj6g==
Date: Sat, 4 Apr 2026 00:39:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Prasanth Babu Mantena <p-mantena@ti.com>,
 u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com, vigneshr@ti.com
References: <20260312133247.2192335-1-p-mantena@ti.com>
 <20260312135019.GA502704@bill-the-cat>
 <c57a8801-8282-4df3-a813-3ba7948cc054@mailbox.org>
 <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
 <0c4f352c-7de8-46ad-8e4d-60fa187d6160@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0c4f352c-7de8-46ad-8e4d-60fa187d6160@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ebd306af78b33dcbfd0
X-MBO-RS-META: 7o1d94jcmk6bh79k9a8im6rtwas7p5cs
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

On 4/2/26 1:03 PM, Siddharth Vadapalli wrote:

Hi,

>>>> Adding in the USB custodian as this revert is intended for master and
>>>> v2026.04 I assume as the commit being reverted is also in master.
>>>> Thanks.
>>> This may be related to
>>>
>>> [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and 
>>> probe parent
>>>
>>> ?
>>>
>>> Can you coordinate with Siddharth Vadapalli ?
>> Please refer to my response at:
>> https://lore.kernel.org/r/17a341aa-4711-4389-8ea1-a8169616baeb@ti.com/
>> on the patch quoted above
>> ([PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and 
>> probe parent)
>>
>> A common .probe as a stub will not work and probing the parent in 
>> cdns3_bind() doesn't seem to be acceptable. So reverting the commit 
>> appears to be the only option at the moment to fix non-USB Boot Modes.
> Please note that this revert patch is required to fix non-USB Boot Mode. 
> If you have a suggestion for an alternative, please let me know.
I replied to [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning 
error and probe parent now, we can continue there.

If this patch is a stop-gap measure to avoid breakage on TI platform for 
v2026.04 release, then let's pick it up.

And I'm sorry for my slow response, I am buried in email.
