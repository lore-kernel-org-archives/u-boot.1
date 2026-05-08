Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8313CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E6D84DAB;
	Fri,  8 May 2026 19:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ch3bv8o8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d7bF5wKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBC684DAF; Fri,  8 May 2026 19:25:27 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2778984CD2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBwxJ14pzz9t14;
 Fri,  8 May 2026 19:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778261124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdbdOOCxpF2aNuuGzkfi5ObLkP5Xa8Ageg1ZTTQzvVE=;
 b=Ch3bv8o831pIseiPEoJ0QibnFXqxvZdm7EW4nKjltCUMv6Hie0fe7mTtLOr2sZbMWhZk6X
 nG4t7A/CE1poDJzGbFWzXImyq8k/s8K1gwqQciUhFvr9ayElXN6YkE9Hfs34785eHoVJ1s
 mFkPd0Ht4EeZ1oEMRjA1S0fADfRF+dLRWQXisIWXrpFkoT9ChDdKvvPep1xMl0S9M5nNKy
 Sg9T4bduQqhdSiPSgGEXIpRyrgAd9KZv2W1axUtPhTjeYCix+SeBOAzK3f33ijdvWNepe4
 AgqgYnSfukvxrwoeG+fyPVAHUyZVs61KqaEr0nTTxnFGYoxJptF72FJJZf3n5w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=d7bF5wKP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fae30eed-0d1a-4b7b-ba2f-a1b7f48c4991@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778261123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdbdOOCxpF2aNuuGzkfi5ObLkP5Xa8Ageg1ZTTQzvVE=;
 b=d7bF5wKPWXK5PGrMURCo0ZURC3C60rn33W8WzLtpW4CW3EsffIHGFhxQSHHxH0sVpjPs8s
 ONBVX6kveVAtoqthYpp1i4OcUxZqINLK/bKjeM+MIXqPlkkt9CtEtUaCzaZjQ+TKnQtQ58
 BeppPHwr17tcG9vbBMUeIxc7YNThWPO5paPohqBy+a3J4NJsgzvD+C7e3JgPMJkX5CK+a9
 PZvWMyN4yDO0NJrUo03QKdwXEkYhTJ1F3xXM/3U3bhuKetvhsaoS8kQEtd08zn69EbiSo2
 DbFFx5qSN7kmOmQhigOwre5AL2A3v+LIJS11yV4KMXrLL3YORWUbVXD+MaBc+Q==
Date: Fri, 8 May 2026 19:25:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] misc: x86: Staticize and constify driver ops
To: Simon Glass <sjg@chromium.org>, marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
 <20260507220725.209205-3-marek.vasut+renesas@mailbox.org>
 <CAFLszThbW0CUojf7zpuy_eUS2PYOU41pVGRTujrvo8G19z1Xkw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszThbW0CUojf7zpuy_eUS2PYOU41pVGRTujrvo8G19z1Xkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ijiowrmgeofaosnoesqeauo9nsm4d7xd
X-MBO-RS-ID: b2937893f65e9980b55
X-Rspamd-Queue-Id: 4gBwxJ14pzz9t14
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

On 5/8/26 6:59 PM, Simon Glass wrote:
> Hi Marek,
> 
> On 2026-05-07T22:07:14, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> misc: x86: Staticize and constify driver ops
>>
>> Set the ops structure as static const. The structure is not accessible
>> from outside of this driver and is not going to be modified at runtime.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> drivers/misc/qfw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
>> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
>> @@ -152,7 +152,7 @@ UCLASS_DRIVER(qfw) = {
>>        .per_device_auto        = sizeof(struct qfw_dev),
>>   };
>>
>> -struct bootdev_ops qfw_bootdev_ops = {
>> +static const struct bootdev_ops qfw_bootdev_ops = {
>>        .get_bootflow   = qfw_get_bootflow,
>>   };
> 
> How about calling this 'misc: qfw: Staticize and constify bootdev ops' ?
Sure, some one those files didn't have a good consistent subject tag I 
could dig out of git log .
