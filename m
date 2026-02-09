Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D93E94605
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22AE83C29;
	Mon,  9 Feb 2026 21:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a8Dajghn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D8B83C67; Mon,  9 Feb 2026 21:47:03 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1902805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f8xZW0T1Qz9tW3;
 Mon,  9 Feb 2026 21:46:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770670019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcKwZROwjJQ4qQlL1N4+c/dIEYkSE7iZhC90S6MgXBg=;
 b=a8DajghnlLa2uhIQwC9kXPiZd4XxAPEev0pB82RNw6mwUOdNrf1sD/qvmn6VhVwPme9sAb
 u/JCDtVq1mu5oC9UQ/Fo1G3ii3aWw1erlLAmMv7P70W+6RPfNbbA5shFNPnU17BV99ryK2
 xE565naD8oPnjnPqncP+qPlzMKkpxESMQmLVuCAxTpn9uZPXtpToNEVl0Ae54cTa1BDVVa
 bSW98/k8wAq1nmRVzxGQoic0Ghxd9rIpkQ3I10UzNbFNYg+DT04s4SHwweJeg8Se5kLMBB
 fSpUgCAaBn/twkyBshXPuU+PYp+bBaYeehNK0fVcXpB5GqhbDGMpLhhR8HWVsw==
Message-ID: <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
Date: Mon, 9 Feb 2026 21:35:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260209201415.303190-1-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260209201415.303190-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: df1904941413ffa24b2
X-MBO-RS-META: ggbfi3meqindgujrukq3n7e7ah16s4d3
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

On 2/9/26 9:14 PM, Jonas Karlman wrote:
> clk_get_rate() in U-Boot is documented to return clock rate on success,
> 0 for invalid clock and -ve error code for other errors. This differ
> slightly from Linux where only >= 0 is returned from clk_get_rate().
> 
> Some clock drivers take advantage of this difference and may return -ve
> error code for clocks not fully supported in U-Boot.
> 
> Use IS_ERR_VALUE() to check for an error code in addition to current
> invalid clock check to fix broken and unpredicted behavior when clock
> driver returns a -ve error code for the ref_clk.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
I wonder if it would be better to fix the API discrepancy . Could you 
try that instead ?
