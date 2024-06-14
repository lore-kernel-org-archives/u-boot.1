Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E23C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 20:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58CB2889EC;
	Fri, 14 Jun 2024 22:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R4tYD3xn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OkyyRci/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D7188A00; Fri, 14 Jun 2024 22:26:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08996889EC
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 22:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W19lz6N40z9scL;
 Fri, 14 Jun 2024 22:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718396783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JilIVDJcavGoyQI6dnN3FlJvSflBPQdVrdijbp1c5GM=;
 b=R4tYD3xnXAi7b4B6zyDEAHk02NcC3ZGBhSGpEFJRUwWX49uP/dn45XXxFZqUpU31oKAn+B
 x77MVXaFJ5qz15ofdy3ty/ffY2e+OHMqw3nJ8E427x2Q9Y5KaVCNyaOeqleH4gvksYgjCX
 djVeDKvF56ybfkMOISZmeT72yhgDl7ZDDgMJgN7EUL0+aQ8CQ+m7lxRiUKdKxfr/gwl4Hw
 a/i3ExF4PfC1/nYMu1661w+KZXxv4kGk+OTwXgYYwdI2PRiwUiLVYGCDi2/g0XymajmUMQ
 Zocrg+TvJFYu1Uf1TN9e4ravjg+7dFyRopRjNMv/y+Z/VnJFwNQBzUDL5Ub/ug==
Message-ID: <663b950b-11cc-4598-bf6c-75644d613859@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718396782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JilIVDJcavGoyQI6dnN3FlJvSflBPQdVrdijbp1c5GM=;
 b=OkyyRci/GXoTdd5Ob087QuB2CbrcRod/PH7WXKOtFxpF47eDo1RcfPzpkc0DK3UAk+qyqs
 MrwBPUIwUWj7U+90wdaWxMxmveVEqBUehO48nSnjjY3IfDLkruf0V9xEv4XoUwVZm6rJVV
 aSdF4iLIoCrHwk+zM1jaNVkd0HIMWUYRgJjbvqJ4zt5fQSNJeCLDZXTLn8PfvXagShbFFd
 4s6E2Z8QudrTYxHdS2/7QP+TOpMhpI9oMZJzKwsyPhTxUUys82tmSQ3Jx0gOwmI61BHh7c
 qBkTKEXR/kXTrcwkOKCiH3/A33Q1QMyS1NQrkgoPZ+4xmskaxl35q7a/5h5yBA==
Date: Fri, 14 Jun 2024 22:26:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] net: phy: Turn default auto-negotiation timeout into
 Kconfig symbol
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <171837686047.2655592.885719495890320459.b4-ty@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <171837686047.2655592.885719495890320459.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: e67z3qoethfao3rchq3zmcboeb55dqbr
X-MBO-RS-ID: bafaf7fac8121f472e2
X-Rspamd-Queue-Id: 4W19lz6N40z9scL
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

On 6/14/24 4:54 PM, Tom Rini wrote:
> On Fri, 31 May 2024 18:47:16 +0200, Marek Vasut wrote:
> 
>> Let users configure default auto-negotiation timeout via Kconfig
>> instead of specifying it in board configuration headers. This is
>> the first step toward converting this to Kconfig fully, so far the
>> legacy PHY_ANEG_TIMEOUT in configuration headers takes precedence.
>>
>>
> 
> Applied to u-boot/master, thanks!

next, right ?
