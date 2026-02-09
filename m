Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42382E94617
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 22:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27CC78341A;
	Mon,  9 Feb 2026 23:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="quMXZqrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F91683BF4; Mon,  9 Feb 2026 23:52:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D83805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 23:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f90Lx2zGNz9tWy;
 Mon,  9 Feb 2026 23:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770677529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPXxcsiLB4Kuc+N5tmuBgIl3dJMWsZLFVXEKDLXDGl4=;
 b=quMXZqrtE5CbSAj74eFpFZ5puRQ/1OJB9jh8wMTZKQKGK/FlZnB5HAcBFuABlNp9xFVUlm
 Le4Z2GjO+siJjc2/+33vldHpJGbbog/64Cq0oGjDyPGl7dTq5Sm58CDNnW3ADLu02GREQl
 Eq7wjYKskmzi7wYUUAaJT+hkqTXz3PayeUdyQHVBWRsYV7YiF7kiEZo3P43T5K1ziSvbm8
 o6e0E/okuRS2YnjbfKJYhaifmnbL7zfTLf8mSiq6GkdSX2pF8Plxen67KtJDaqBwSMj58X
 3UaHqwIp/jFgHBIHrZFk1FFYxgF3pU4o3zWsVh/xR9aeSOMiyPm4zBDNz4nIPA==
Message-ID: <f5dd98cd-be29-4587-8ddf-3e43fcb7a811@mailbox.org>
Date: Mon, 9 Feb 2026 22:46:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
References: <20260209201415.303190-1-jonas@kwiboo.se>
 <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
 <20260209205126.GK2603314@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260209205126.GK2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a253070565110aaf6f5
X-MBO-RS-META: hx536w38rted71h7rgwjq1m3kaos1xk8
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

On 2/9/26 9:51 PM, Tom Rini wrote:
> On Mon, Feb 09, 2026 at 09:35:54PM +0100, Marek Vasut wrote:
>> On 2/9/26 9:14 PM, Jonas Karlman wrote:
>>> clk_get_rate() in U-Boot is documented to return clock rate on success,
>>> 0 for invalid clock and -ve error code for other errors. This differ
>>> slightly from Linux where only >= 0 is returned from clk_get_rate().
>>>
>>> Some clock drivers take advantage of this difference and may return -ve
>>> error code for clocks not fully supported in U-Boot.
>>>
>>> Use IS_ERR_VALUE() to check for an error code in addition to current
>>> invalid clock check to fix broken and unpredicted behavior when clock
>>> driver returns a -ve error code for the ref_clk.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> I wonder if it would be better to fix the API discrepancy . Could you try
>> that instead ?
> 
> Which API discrepancy? clk_get_rate behaves the way it behaves
> intentionally and there's some fairly long and recent threads about that
> resulting from attepmts to change that.
Align clk_get_rate() between U-Boot and Linux kind of discrepancy .
