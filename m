Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E013FD6101A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48EBE83EF9;
	Thu, 29 Jan 2026 15:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qbFrQZXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BA983F2E; Thu, 29 Jan 2026 15:53:34 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3545983D1A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f22Fk2ZRsz9tlj;
 Thu, 29 Jan 2026 15:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769698410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKan0ajurHMVdH6n0EDTRM+XaajF5dfbq+Bcf/4so+E=;
 b=qbFrQZXGC2uofMIOxXtuL7CiEYMYircx15oqVW23nFfSN/yB2poHZxt4DaE8X3VWntlNix
 gQHBuFjcPNb4xXQImmc8PRlST0rwVWl5d/IaHwkmsmqw1va9mlA2ffNgjh4G859789LGhc
 1x3AhFCTcwa5+qjg2pLgP0jLenrMTIidaHdV+BDtsTdv9PfoejFVIooKwLFPwk9Liei6J6
 rJrv9i7Jci1LpwJrptUi6xVeOln/vLMnW8XZIUfZekj3blvKmEBgaKjxhcUwLdPLB23g+m
 +WTibsOZToAkgXQ7c9LXSSVSdhWmu6zgC2lxb4f0YGUCKL4OIl5zw7S5Tm5bCg==
Message-ID: <f5ec9ab2-5f20-4121-a3bb-f97d7d108c1b@mailbox.org>
Date: Thu, 29 Jan 2026 15:53:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: lwip: wget: rework the '#' printing
To: Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
 <fb3183eb-c389-4508-9316-33c88824bbf1@arm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <fb3183eb-c389-4508-9316-33c88824bbf1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 43fcabffc67d5273caf
X-MBO-RS-META: 9bx1hgm56pn6sx6eqf4ojrbscd6wk63w
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

On 1/29/26 11:18 AM, Jerome Forissier wrote:
> Hi Marek,
> 
> On 29/01/2026 01:23, Marek Vasut wrote:
>> Currently, the LWIP wget command prints excessive amount of progress
>> indicator '#' for very long file downloads,
> 
> So true! ;-)
> 
>> limit this to one line
>> that scales according to transfer size.
>>
>> The HTTP server does report the size of the entire file in protocol
>> headers, which are received before the actual data transfer. Cache
>> this information and use it to adaptively print progress indicator
>> '#' until it fills one entire line worth of '#', which indicates the
>> transfer has completed. This way, long transfers don't print pages of
>> '#', but every transfer will print exactly one line worth of '#'. The
>> algorithm for '#' printing is the same as TFTP tsize one.
> 
> That's not one line strictly speaking, it is 50 characters.
> Like I suggested re. your TFTP patch, perhaps a percent-based format
> would be better?
> 
> 0%....10%....20%... etc.

I would like to retain as much compatibility with the old network stack 
as possible, to make the switch over easy for existing users.

Is there already such a "pretty printing" function available somewhere ?

> In any case:
> 
> Acked-by: Jerome Forissier <jerome.forissier@rm.com>
Thank you

(it seems someone rm'd a character from the AB string above, so I 
reinstated it according to the source email address)
