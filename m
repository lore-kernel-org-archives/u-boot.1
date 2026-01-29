Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5999ED61020
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BDA83FBF;
	Thu, 29 Jan 2026 15:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="leLZl0RZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703EE83FC1; Thu, 29 Jan 2026 15:54:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414AF83FBD
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f22Gz5wxRz9scN;
 Thu, 29 Jan 2026 15:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769698475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSl0A5EL/xcYWHi/6EfvCc/q1/CLu35RAgp1n4HVrFg=;
 b=leLZl0RZ2qv55usr6y2S7R57BpKgtP4x3pj4v09ztZOyyKFdqgqtzFWX6L9IuKKg6u2wvb
 mDFJW4v2uyM1buhGtV/efniSMNwjzilFsCCszOWSRNiVTRfoDgtUPanLG3U/r+Jur636ts
 mDMZwhbEdXcLv9umY7GgHzdkozadmpEvXvF3DW7Q7jK7EjFzgSPml2XeMCZLAQpV9F3cLQ
 9d3CgipwF+eDBraK+fi5eVquStZ75avJh1RUX0AbyUYwjX58y0gJX6nE8hhO3ViytgcIS1
 JW40+SoXBlk4b7RyJ/XweNfs9xk0Q7xBzEJwJAPcqpIHvYXdMB/YGXSy0rmkoQ==
Message-ID: <674aaf9d-bda1-4480-afd9-2f68e25e4ee4@mailbox.org>
Date: Thu, 29 Jan 2026 15:54:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: lwip: tftp: add support of tsize option to client
To: Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <20260128234351.405945-1-marek.vasut+renesas@mailbox.org>
 <51b1c31a-427e-400d-9692-14e4b90c0a2c@arm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <51b1c31a-427e-400d-9692-14e4b90c0a2c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: upsh6cc1nmh1ne4hyymr6y53zuc7zemj
X-MBO-RS-ID: fdccb4c2776bf6b5195
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

On 1/29/26 11:04 AM, Jerome Forissier wrote:

Hello Jerome,

> On 29/01/2026 00:43, Marek Vasut wrote:
>> The TFTP server can report the size of the entire file that is about to
>> be received in the Transfer Size Option, this is described in RFC 2349.
>> This functionality is optional and the server may not report tsize in
>> case it is not supported.
>>
>> Always send tsize request to the server to query the transfer size,
>> and in case the server does respond, cache that information locally
>> in tftp_state.tsize, otherwise cache size 0. Introduce new function
>> tftp_client_get_tsize() which returns the cached tftp_state.tsize so
>> clients can determine the transfer size and use it.
>>
>> Update net/lwip/tftp.c to make use of tftp_client_get_tsize() and
>> avoid excessive printing of '#' during TFTP transfers in case the
>> transfer size is reported by the server.
>>
>> Submitted upstream: https://savannah.nongnu.org/patch/index.php?item_id=10557
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Nice feature! One minor comment below.
> 
> Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Good to have you back

[...]

>> -	if (ctx->block_count % 10 == 0) {
>> -		putc('#');
>> -		if (ctx->block_count % (65 * 10) == 0)
>> -			puts("\n\t ");
>> +
>> +	tftp_tsize = tftp_client_get_tsize();
>> +	if (tftp_tsize) {
>> +		pos = clamp(ctx->size, 0UL, tftp_tsize);
>> +
>> +		while (ctx->hash_count < pos * 50 / tftp_tsize) {
>> +			putc('#');
>> +			ctx->hash_count++;
>> +		}
> 
> Nit: with this format being the same as the non-tsize one, the user has no
> way to know how many hashes to expect. How about printing percentages instead?
> 
>   0%....10%....20%.... etc.
> 
> (functional tests may need adjusting though)
Do we already have such a pretty printing function ?
