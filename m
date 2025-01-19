Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A169C02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 10:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D7F80141;
	Sun, 19 Jan 2025 11:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hm8lwZ+Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RykVj0ix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5021801F5; Sun, 19 Jan 2025 11:22:11 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8254F800CF
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 11:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YbTzj1YGvz9sWS;
 Sun, 19 Jan 2025 11:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737282129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIvJyuCoUNyfxLsWKVtfm9CBtTgeE2QcVIMFPA4I43A=;
 b=Hm8lwZ+Q1dFiyi81PW+Xjqjxi7zPOTRsWYtg6T2ASgOviDRBM4eXjZgz12wQgzgjRjRVgC
 DKma1RQfnQB9+qeR0DMk0mUDd1s9ISSFOlciBoaDy7UPw65WKbVsWDh/aDCYsSbTUZ6Zi5
 QBeEflLFo10EqHj4m35h/7Xcx89nkRLo0Z9b9fNfwK8S5+7SlQpKgwVXFgd5JakzlVHz93
 98xMd6FnGVe8Hes2o4WXTtVQZmFoUt0LaYi8Yk0jWQ+zKOj8Z6/IIxCwnyIJ8h8tFmvFce
 /yxVccSyafzG+kzkh/ixThUT+gtR11zxYZdErvgYAl0+gbAw5JlkDpHKmrfi6A==
Message-ID: <77adf4a5-44ae-4593-80c4-863de53c4272@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737282127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIvJyuCoUNyfxLsWKVtfm9CBtTgeE2QcVIMFPA4I43A=;
 b=RykVj0ix5jAwu2ZYIRlnXrtqsLTfJyJ5qSlfBBwZ32k7cRdanewt8G3tKVNkSmhmwwmRPe
 a/bJCZjaH/JG+/Q9IiOFboi6IzDmy8NcAimpvYQMTtlBX5/wAbc0A0k4sNisRNDZZjDkd5
 H28AZ5sDMEy073zxnbkwYBCn9yZdLRTC2XIXSxh4TdSs5nBFx17cXiaSFUSx3B1a3zMJ1n
 qVjidzIiE/DYX4c62f3+b84FD92mLq1OpLzdEVg9nRR0LTbX2EhbZ+Z3ruYjCcViGzbPTS
 56MyXDqxB35FZYxw+gZYxOXEv4t0xKIw0P27qskxLbXOUmDoqiJchzQnXc2EpQ==
Date: Sun, 19 Jan 2025 11:22:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
 <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
 <3cc475db-8546-4855-991c-5e678bef0fef@cherry.de>
 <ce662fc7-da77-46a3-9f34-081b3377cac4@mailbox.org>
 <413c1e5d-8e8a-4d12-9e50-bc22816a89f1@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <413c1e5d-8e8a-4d12-9e50-bc22816a89f1@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: czkrdrkafbk65aogzj3upcc3edm3ggcg
X-MBO-RS-ID: 3763f5e560681235bc5
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

On 12/5/24 7:58 PM, Paul Barker wrote:
> Hi Marek, Quentin,
> 
> On 01/12/2024 18:57, Marek Vasut wrote:
>> On 11/25/24 6:23 PM, Quentin Schulz wrote:
>>
>> [...]
>>
>>>> @@ -446,6 +474,10 @@ static int ksz9131_config(struct phy_device *phydev)
>>>>                return ret;
>>>>        }
>>>> +    ret = ksz9131_led_errata(phydev);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>
>>> This seems to work but is happening a bit late.
>>>
>>> Indeed, I need something to call the network stack for this to be
>>> happening. Meaning until I e.g. run `dhcp` in the CLI, the LED is still
>>> following the bad behavior.
>>>
>>> I assume we cannot use the probe() callback for writing to registers?
>> I'm afraid there is an inconsistency between U-Boot MAC drivers and when
>> they configure the PHY. This is well visible on MX8MP, which has both
>> FEC and EQoS/DWMAC MACs and they behave differently in this aspect. The
>> question is, whether it makes sense to initialize the PHY before the MAC
>> has been used, probably no, because that brings up hardware and adds to
>> boot time. But at least aligning the behavior of the various MAC drivers
>> would be nice.
> 
> Is there anything we can do in this driver to fix this?
> 
> Or should we merge this as-is and improve the MAC drivers later?
I'd say merge it for 2025.04 , since this is an errata fix, but it would 
also be able to clean up the MAC driver mess eventually.
