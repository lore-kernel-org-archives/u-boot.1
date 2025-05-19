Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A90C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 06:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA0781E72;
	Mon, 19 May 2025 08:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747636293;
	bh=sIS/b7ukHk4DvoEA0RKPNCnn5smdAytb6edPQfah6v0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJ/WQy+6HgKODkvUDwKqA346amoCkpuMWbEyfZ4Le/pZDn2OTybC0+oQR8vl8C/pp
	 Epvu0AtGxwjgpHRr6OQOPvvZTwf0tZQOchisQ8kew9fN5xlLaGUtIK9EKZw2vUINk7
	 kjogi04yKP63IsWuriJGvIv2B5e4ShGzvyqh1GqZGeat8ufpEHr9+ttraJFpbzkj/d
	 pHkj/RGInkAIpRxh0N4bB1yYQkl0OKv7Gsprlkna/Jt/qNBiRdtlDOK+JdQk0QlWQF
	 sQ1flxuy2hKYZJmMY8zpA5YSpMlOFrlshqgBwk7+DMZseyFUWZtzFTUQI/FKfOYc3+
	 CUiI5ToCDLiug==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1574C81F66; Mon, 19 May 2025 08:31:33 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB63803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4b17B906Qnz9ss6;
 Mon, 19 May 2025 08:31:29 +0200 (CEST)
Message-ID: <9810a0c8-9052-4667-b91a-d3b3499d5f38@denx.de>
Date: Mon, 19 May 2025 08:31:28 +0200
MIME-Version: 1.0
Subject: Re: Please pull u-boot-watchdog/master
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <f5f977a1-34fe-4e2a-a604-0f0695f3bc7b@denx.de>
 <20250516191837.GN100073@bill-the-cat>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250516191837.GN100073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4b17B906Qnz9ss6
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

Hi Tom,

On 16.05.25 21:18, Tom Rini wrote:
> On Fri, May 16, 2025 at 06:42:11PM +0200, Stefan Roese wrote:
> 
>> Hi Tom,
>>
>> please pull this next batch of mostly cyclic patches from Rasmus:
>>
> 
> Oh, and can you please update the .git/config here like you did for the
> marvell PR? b4 doesn't like the git@ syntax so I had to do this manually
> :)

Ah, I knew that I missed something here.

Thanks for reminding - changes are made.

Thanks,
Stefan

