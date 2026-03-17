Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8068FFB5EAF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A62840CF;
	Tue, 17 Mar 2026 06:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZzbT8uVZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I4GxgTq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE86D840CF; Tue, 17 Mar 2026 06:07:23 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6CF84056
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fZg1h02ydz9t3Y;
 Tue, 17 Mar 2026 06:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p3DB5tl1/cfhnsrQuFJa11rUN4bRBnswyu8oMxm2IM=;
 b=ZzbT8uVZDV0j+IKvGJwqIkxw1RXMCYzLOCmiKtR07bwdZSCDwd4EGwfcWJ64JgrCy0gS0E
 p1Bl4kbrgo2m9iUdqw3+dtrHebMFpLYXsNknEhuGP9XPwc5Jq2mVONTjOZgcgGKCOxN8XD
 pwSCcQTf/vXQ3LGBy5mTLbe6sFFQxe9YxfnbknpvCFcWogS7L0Nk0V/BFaOn0Lx14TBGmQ
 p1RsQh3LoHNJ9JAXYZpgEg5Y/MLdlNyakIchpaqjJX++q4wxKExhCWs6L4dy6hBx1reBoK
 lRYZy2IxOhcCjQfCifZT0jNfEuqZS2Z+nMk7Wsrlsh8f5E7GuTawpXp6R9EFBw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=I4GxgTq0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0bd82057-5f84-45ac-aded-33b7798a5716@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p3DB5tl1/cfhnsrQuFJa11rUN4bRBnswyu8oMxm2IM=;
 b=I4GxgTq0k6CW2kcUqP6MaEk/kV2xipESTH3s385kRUS5nEEyZPtlKXX94rJiYfNQPZIK1p
 ekskQvbRXAj8F7u7nsJDQI+EJfLZrtsO+GndnJCNgUMDUoNzQrBqh/Jm8kCjsZvwP2PtkF
 3jMqlCHGQPsOkHF+J7l81Vz51RXQyEpac2x74M29yQ3K2ln0vW27uARJQZw0pS26p5IJfB
 F+jQWIBwojgzMPj2L07jof3EnH28tWXB1HYqWKU/70RyQrLZTRL+Um4ubb3hk3ibOMtfGq
 1YhHG2w6DEfC0yI9GsGw04sUgRa3tqmlvg0aUvuxUMsAYRJ7mFLr23spzggiWQ==
Date: Tue, 17 Mar 2026 03:35:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: isp1760: Correct dependencies for USB_ISP1760
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
References: <20260317012416.4162318-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317012416.4162318-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k488b9fr6ujtnfadokxsk8hcmio5r9w7
X-MBO-RS-ID: abe39765e176b756efa
X-Rspamd-Queue-Id: 4fZg1h02ydz9t3Y
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

On 3/17/26 2:24 AM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for USB_ISP1760. It depends on DM && OF_CONTROL being set and
> functionally requires REGMAP. As part of fixing that issue, we change
> "tristate" to "bool" and remove mentions of module support as that's not
> a thing in U-Boot.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

