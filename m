Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC55CD1280
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F4E88145;
	Thu, 28 Mar 2024 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711630889;
	bh=F+cGPyMy0YE8IlxdU1HqFFlRy+xR0NnMaKD97VCG8jg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCr5DoH5sUoaGNSoJBWup6Ts9m8hjr+9TXHmTJbvPIQVzNXUB3atol3Z2lJNLJzV4
	 F2mI5fIQZe2J10mUWTfl0khFFJpUBGSImpk6UY/8tC9qJ3uXXXUcK5yB6WHHc94/0K
	 eyVH8MaODFqTuLogVdo5UfUa5gp7teuQQAAZO+kbsgtj+ZGpMQSODvr4QqMPqdPzdK
	 rk6jZ4wlx9rKlALwDWdROzOE7DoAdKo6+jo9Oqqei6FZ0EZIFvzkFBDYJdCUlwXl3B
	 Fph7k4CvwaIdPjKBXQz8ksHMzRk8xEZQXHPsoR+IdeqVS8FqEh8RsjhkaCdGcd5hcp
	 L+yu6JHT3gHnQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8071888073; Thu, 28 Mar 2024 14:01:28 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9941879E2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V53ZW3nrqz9ssM;
 Thu, 28 Mar 2024 14:01:23 +0100 (CET)
Message-ID: <16784d38-8456-40da-9ee1-180c10e8d905@denx.de>
Date: Thu, 28 Mar 2024 14:01:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 11/18] arm: mvebu: system-controller: Add
 support for SYSRESET
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-12-kabel@kernel.org>
 <81922125-aa47-4be2-9e0c-c7dfd57c4ebc@denx.de>
 <20240328122133.12b0e83f@dellmb>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240328122133.12b0e83f@dellmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V53ZW3nrqz9ssM
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

On 3/28/24 12:21, Marek Behún wrote:
> On Thu, 28 Mar 2024 11:04:45 +0100
> Stefan Roese <sr@denx.de> wrote:
> 
>>> +static int mvebu_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>> +{
>>> +	struct regmap *regmap = syscon_get_regmap(dev->parent);
>>> +	uint bit;
>>> +
>>> +	if (type != SYSRESET_COLD)
>>> +		return -EPROTONOSUPPORT;
>>> +
>>> +	bit = MVEBU_GLOBAL_SOFT_RST_BIT;
>>> +
>>> +	regmap_update_bits(regmap, MVEBU_RSTOUTN_MASK_REG, bit, bit);
>>> +	regmap_update_bits(regmap, MVEBU_SYS_SOFT_RST_REG, bit, bit);
>>> +
>>> +	while (1)
>>> +		;
>>
>> A comment before this endless loop might be helpful here.
> 
> The code does the same as reset_cpu() in cpu.c, and the while() cycle
> is not commented there.

Sure, other code might suffer this undocumented endless loop as well.
And again, this is more a nitpicking comment than a real requirement.

> But we can add something like
>    /* something has gone wrong if we reach here, so we may as well stay
>     * here */
> 
> What do you think? Could you amend the patch?

More something like this:

	/* Loop while waiting for the reset */
	while (1)
		;

And yes, I can fold this into your patchset, if I don't forget about
this. Still, if there is need for a v4, then please add it yourself.

Thanks,
Stefan
