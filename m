Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BACFA774
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134F988C7B;
	Fri,  4 Oct 2024 14:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728045813;
	bh=Ng+qsYpINVxV7AJxV1fVpjw5JKGTLyn7uZ8Lk2dmfxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zm0DZ/GLJCpMjzOmcke/IhSsUA9Wk/hzbVk6vxXw2UDRqosgh/Qt9ueMtgmD+A3b2
	 l6VEVJXleRgmOjgh2EkCuCAg7tgm8Q6huCkzJMEFsAfqQrDQLAlJQxLsaYUFhTwuOn
	 YBaQyb4pr33HmXzmCcTIpGr5VxzIqJBv6HW0cnLURqiaMkL0B5WaiUEiqHjiX3QQpY
	 jjum/8KCZfKGMNgRQ6vpJA3PJZKvqsa5fdhnomqoNhbOEwqS3Booy4V8YPMnXB4QXB
	 GGwEG9iMcYP1gKdoZqZg+eQxGYPXz2JXz2EkUOCBxE+9iLzxUJh37oZqwVJePKJr3W
	 HTNnZLMXClQxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD75A88CD9; Fri,  4 Oct 2024 14:43:31 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C06D88B63
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XKpB80Nwyz9sbv;
 Fri,  4 Oct 2024 14:43:28 +0200 (CEST)
Message-ID: <fa3f9053-0f40-402d-bf59-18398a9318f6@denx.de>
Date: Fri, 4 Oct 2024 14:43:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] da9063: Add watchdog support
To: Fabio Estevam <festevam@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, jh80.chung@samsung.com,
 u-boot@lists.denx.de
References: <20240917135550.3164425-1-festevam@gmail.com>
 <3ec25b5a-2c9b-46fe-a9b9-0b99f72d83a9@denx.de>
 <5293f5a0d44059960aa2d5e8b114456f@denx.de>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <5293f5a0d44059960aa2d5e8b114456f@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Fabio,

On 10/4/24 14:32, Fabio Estevam wrote:
> Hi Stefan,
> 
> On 20/09/2024 07:00, Stefan Roese wrote:
> 
>>> Changes since v2:
>>> - Use u8 instead of char. (Stefan)
>>> - Keep the Copyright header from Linux. (Stfan)
>>
>> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Would it be OK if I take this patch via the u-boot-imx tree?
> 
> I have a patch that adds the DA9063 watchdog support to the imx6q-lxr2 
> board.

Sure, please pull it in if this makes sense for you.

Thanks,
Stefan
