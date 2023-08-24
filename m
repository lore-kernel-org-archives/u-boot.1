Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93150C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E3E865FB;
	Thu, 24 Aug 2023 16:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="lEYrTCmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BC1865FB; Thu, 24 Aug 2023 16:58:46 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9EB864E9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 437F430A;
 Thu, 24 Aug 2023 16:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1692889123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlsq3Sy6Xm8bgSqBCc+kxEGOyZDpN4p883v+weqgxhI=;
 b=lEYrTCmkcAqptx/VnC8bO9IL+I/YyMbyl3wY3v456E7B4AWuRFIO9nspA3s2cuq0nwOQin
 G+3FT92I5TaoFehqg0lG6EV0eKg6ZNqUaBQvJZt5PXB7kPZLuMymWgeomvIwxRqe2aM6ld
 PPa50ohEE0t1mjizCpwoohVI8WN+gn9GC5sU51xT/itAzqIRIO1xt8aR5NW+NuDFHB3CCS
 Iqk/JkQ++yg6aJUFnWh/cM3ikhQgQLK4a9oYDjCNR8aytTBuUtv+YzFAVXwjXVmnxxzIOu
 S0H+jkaaw7smS+CEmSoWkoHz5afH+jki5OUBdFdBvUHTTQOPuLNSWa7KcZj2Jg==
MIME-Version: 1.0
Date: Thu, 24 Aug 2023 16:58:42 +0200
From: Michael Walle <michael@walle.cc>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: remove Vikas Manocha
In-Reply-To: <20230824135441.GJ3953269@bill-the-cat>
References: <20230824074436.2929639-1-michael@walle.cc>
 <20230824135441.GJ3953269@bill-the-cat>
Message-ID: <65e136440cd981cc84b5388569c7934b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

>> The mails are bouncing with
>>   550 5.1.1 User Unknown (in reply to RCPT TO command)
>> 
>> Remove the entry and mark the ARM STM STV0991 arch as Orphan.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> CCing other ST people, maybe someone want to take over instead.
>> ---
>>  MAINTAINERS | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 84de9de531..57ede4bea9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -641,8 +641,7 @@ N:	stm32
>> 
>> 
>>  ARM STM STV0991
>> -M:	Vikas Manocha <vikas.manocha@st.com>
>> -S:	Maintained
>> +S:	Orphan
>>  F:	arch/arm/cpu/armv7/stv0991/
>>  F:	arch/arm/include/asm/arch-stv0991/
> 
> This misses board/st/stv0991/MAINTAINERS where he's also listed.  So,
> someone needs to step up to maintain it all, or we should look at
> dropping it.  Thanks!

Ah, dang. I forgot about u-boots special per board MAINTAINERS. If 
there's
no reply (maybe in like a week or so). I'll respin and put the board on
Orphan.

-michael

