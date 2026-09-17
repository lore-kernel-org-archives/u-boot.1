Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687EBC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 23:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A4E740A6D;
	Thu, 17 Sep 2026 23:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EgSaFndntzGe; Thu, 17 Sep 2026 23:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72B3F40A70
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789687771;
	b=W5hxvY343FIMYeTEMWieb4w+2D2mHkaT42J/wSMq9Jix2g4IiSZ9UIOhVVbLAIcsg3/w
	 Z6FsR6kHzIv5IZAu/8pQnbiklkSaw9b7K3O2pClubsde6WaKf7LdOrJILBaMXlu3LT591
	 ISpbzLhTc5p+0hlaTZBEFZEd94YiDsST1a5rYq42wnsxQ+113XOlya6euYc7q8F431p7X
	 YkOO5Bylbkqbc350ike+x3lGxHSi8UUSnB6laUMJqQ7sfHU25JbeUZmtNVBsA1QAjXQ89
	 zxPeOio86YDV48iap/A8BRyF9vRttdYgbgOzhoZAReFWj2YtF79C4eBYGOMuGnBPMtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789687771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LI4EmMFW8mhtTsEBJfxBOUTP+Bjhr9PitrhRRifjeRU=;
	b=pUiMtu+Z8S6UI+rbhDNuHfoQSY+LoXa9r2/NdslV4lpRuP/UxymO2ObP7doSGNIY+kE3
	 Dqm8GSUNl/Azeu+FqMDXNUz66rXdMlujwXpunhE4cmYhNj7Ii2yJ19DIDSDZGn8Z6O1y3
	 m2d21yccdOw4lBG/2+ek5wUdF1Upb0fLHP1A9dPOBoAXg4o9pHiEL4ZD0weqLPaRbtyCW
	 SiDDkQGvc9OSnw+uevWArjtVWM4OU6NzhUz1Ii3GdvWKArKeQ2W9lYF1GcizyiNBiXmOL
	 E70keyK1rSUcxREAhFn1pQgbVIj/KO+TjbkVRbU4SH7mT1un6E7+WDktHixemcMjZjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789687771;
	bh=LI4EmMFW8mhtTsEBJfxBOUTP+Bjhr9PitrhRRifjeRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VFh4pLU6YSPt4fNPBePK0JKUaRCGYOaMUPApUt1QtB/u7HoE/Cnb4ION8dng6yPtq
	 IBBMd4egZDeczixq7WFgcf3WJz9ezJZwcwDC2efQdZBkeL7KsVojAuBYutV1DwQNEx
	 em+TCZRnuyng/YSOKPInVB4S/2R2n5zTerTUz5GpFiA1Ts6ByxBxYKSyP/sQANTWCZ
	 U1fVfs1ZAUDt4AXecEpYnkPfiqh1XQMIyJwdxguRA5w/FayX+HHzC8FVnzzFSJ61oZ
	 zzNCwfOxlV9jkklXPuIKDsN6DGo6o2m1LYt6+J1D7EGC/if9Hc/7vsyst4XPVHLTgt
	 fs2AVv9mP8xpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72B3F40A70;
	Thu, 17 Sep 2026 23:29:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FE163B6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 918A181100
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBn30ewDoiCt for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 23:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A9AF810A5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789687768;
 b=QY4G0SQtSmFYZCJR6iHjfCZ4FzzRCFzlW+6cyFAVgS3+MTXTHfjkqrJlFWlWQODRxers
 eEXKiE9sDB8xWZ+mngW5o95KMD+ag316lRzjbTEA3o+DmsVgr0I2m67BU86Cn6PY+UCcy
 ZfqON3iSoJxq3APv6i1WO75s9ooSZx30xEdGlZYBgEH2IC64KnE13/TwqAUul6c8A2F4m
 NQy+cqRnDWx783niqFlDKO3D/tdjCgCdP0iUwls63odMQcpdd1D46S/s3qgRo6Iq3EHck
 /engRovFEok5GWqVUaih2H4f5Rs/0WKUsldXspwCEKo02ud3nluC2ShXRSXG8zCNVOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789687768;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=LI4EmMFW8mhtTsEBJfxBOUTP+Bjhr9PitrhRRifjeRU=;
 b=ClR4lPf7uVjcgwYNGOxFdnphmCM1vRRKBRF/N2ESYVbG32q/vfxMHiSVZBTT+UwP8BbO
 88Zcrp6y0ju1dm5GR2NaQsVLKYkPojHlhiizxAgY72Crf/A8M97nX0dreCuesAOn9hF0W
 4KwGo34cItcHU/xcfHljiEwL0F4siv+VWX1u7ZC9pjCxLIwE0uDhjCVdJXVxJS8o2pRBU
 f/nRP1Ay98r8Y9XCcYltDYPGdeukVV4YW2ZNtbUr1vvhM81ByPY/jWYVinLpGkF/4awo1
 EXN8wHM9qTTY0oLJCOJU/dJYVtprLIrZtjetFKjDCaVK9bm64xhaKkx6t8ID5+2bIZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=mQuDPHE3; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ktJkFpkC; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=mQuDPHE3; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ktJkFpkC
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A9AF810A5
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:29:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hmBmP4PhGzKnvw;
 Fri, 18 Sep 2026 01:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789687765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI4EmMFW8mhtTsEBJfxBOUTP+Bjhr9PitrhRRifjeRU=;
 b=mQuDPHE3mq0XJgig4GT/ihfjHw+rkIMHcYtFu+yGiAWu2szHW+LuNMTMB+XK6O4ArrS4VY
 R6BSIel0nodIC6iOteZohBOTeZIgef67zPUNt8DG7ygX1xUFivnV05Iu1j5XfSvufkeorM
 ZRD0Gn6PrnHxek3EyPEt4/VdSIntlH/kpqFykgdXwxBhtVcjBvY9OD8mhZQd+cfG17GAif
 7i2bYhkfjPzQbg4JTWPghhDQIRJoiobgW4l0Fg4XuItxMyzIcHGtrRu8bVNdTJTqFcU0By
 XFcoWTxDVW+QV8xg2S5Z2Tt5UotWC9zSWBGUmKzBl3wfX8QraHutuSJcMC3xuQ==
Message-ID: <d5d00e93-e803-44e8-9f20-915e324395c1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789687764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI4EmMFW8mhtTsEBJfxBOUTP+Bjhr9PitrhRRifjeRU=;
 b=ktJkFpkCR+CDn3AANLSoI21hs5ND9viMk96nLtPHRQSFG7HvIrMpEPZzA2T57S+pnj2Ku7
 2c6qtc80g3akypRgTJWIbuZt4x+rxH+sawzjfpnhZhLg6M2ewt4L8I6ku78CCwPoyUkUEF
 NVYMaE69bJdLagzZ/A7l+qOVqiPaFSVtFIpTChf9dWDRiUHuYb/FYMpVqgXmpGCLzRMIyR
 Y964/6LWM8+bYG+BfEi80w3FucOeloaRJdjWMw7DHFJDTRFrAMKalJ0RoDzJSAJJ2l57X3
 oaqmVzI4leP38e+U1vYoIbT72fVS8ZTwuIxc3DVjQbVcu0r/hheTKJxcVsyGhA==
Date: Thu, 17 Sep 2026 16:26:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3581ff07caaa7424932
X-MBO-RS-META: yx5jzs685xgwb5udi446wdsee3mmmyue
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/17/26 10:58 AM, Patrice Chotard wrote:
> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
> it may take a while to get the control back on the console,
> sometimes around 1 second.
> 
> By removing the if (k == 10) test, it increases the CTRL+C responsiveness.
> 
> Tested on STM32MP157C-DK board.
I still have two questions:

First, do you have actual timing figures here -- how long did it take 
from one ctrl_c() invocation to the next ctrl_c() invocation. Use e.g. 
get_timer_us() to time this.

Second, does this increase in break condition checking impact throughput 
of the UMS ?
