Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B73C48297
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1960087B8E;
	Mon,  5 Feb 2024 14:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="FiiLYbyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E802B87B50; Mon,  5 Feb 2024 14:51:28 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB457877CB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707141086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMsiWNvdwAK9/hOZjwKPYYVBWoHCs/YI5VUyMiWQ230=;
 b=FiiLYbyZrKfktHCcDOzCh9sAjg3I5mbshyYm0YXQ2IaqpWczsUUHsT+zCok40hs7hkNvu2
 TM9Mb3iTVmn6IafpOlaTDGxnuObXD7N6F1H6wp6rCqCkvIEQ3jw3SX1bWSgqh6GCT+QThg
 YU3XdQU7kOkjCc1hheXbKD9w6jPjJ63g8z0h5Pq1i5iRls1AltjNOOHT0Avelv6QiyalIm
 HpySgP77VcxKR2fxeXSyprQ5o1NNeFQ0FNPlz2JHfyYDOSJSyZaSCv9E0hke6Cjm1OQ8wH
 68UR1+iiPupte3t5ZQAF10Chk3EFE9cDap1Tq7MgkA1bw2JurEL+bWzOg0xuqw==
Date: Mon, 05 Feb 2024 14:51:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, Andy Yan
 <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
In-Reply-To: <be5b2bd5-f855-4585-b59d-c6d0c1df16d4@theobroma-systems.com>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
 <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
 <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
 <be5b2bd5-f855-4585-b59d-c6d0c1df16d4@theobroma-systems.com>
Message-ID: <e1c70a4b74cd4da978e98927dc08485f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-05 14:45, Quentin Schulz wrote:
> On 2/5/24 14:40, Dragan Simic wrote:
>> On 2024-02-05 14:24, Jonas Karlman wrote:
>>> On 2024-02-05 10:40, Quentin Schulz wrote:
>>>> Shouldn't we also remove cap-mmc-highspeed?
>>>> 
>>>> I assume this is for MMC_HS? Which we discovered doesn't work
>>>> reliably?
>>> 
>>> Writing in lower speeds on RK356x does work better then on RK3588,
>>> however HS200 still seem to be more reliable overall and give more
>>> speed.
>>> 
>>> For RK3588 they could possible be removed, but since reading does 
>>> work
>>> and similar issue also existed in the fallback MMC legacy mode, I did
>>> not see that cleanup as important, or maybe more correctly it did not
>>> cross my mind to also remove these props :-), the fully broken ddr52
>>> felt more important.
>>> 
>>>> Since it could be in a different patch if you wanted to, for the
>>>> changes in this patch:
>>> 
>>> Agree, a possible cleanup of cap-mmc-highspeed props could be done in 
>>> a
>>> separate patch.
>>> 
>>> Alternatively any missing and appropriate modes currently in
>>> u-boot.dtsi
>>> should be added to linux DT and they can then be synced back to 
>>> U-Boot
>>> and any override/addition dropped from u-boot.dtsi files.
>> 
>> How about waiting until I fix the mode selection in the Linux kernel
>> drivers?  As I noted already, that's already on my TODO list, and
>> perhaps it would be good to test a bit again under Linux with those
>> fixes applied, before actually removing the buggy modes from the
>> kernel's RK356x and RK3588(s) SoC dtsi files.
> 
> While I appreciate there's some work that can be done in the Linux
> kernel for those low-speed modes, the properties in question are
> removed only from U-Boot's DTS and your future patches for the kernel
> wouldn't impact the bootloader anyway.
> 
> The issue right now is that U-Boot is currently broken because of
> those properties, which are only in U-Boot's DTS.
> 
> Not sure exactly why we should waiting on Linux kernel patches for
> merging work-arounds for U-Boot? What exactly are you suggesting we
> wait for? What can improve the situation?

Ah, sorry for the confusion, let me clarify a bit...

I just replied to the Jonas's remark about the need to eventually
have the same fixes and mode removals in the Linux kernel's SoC dtsi
files.  In other words, all I wrote was about those changes, not
about the changes on the U-Boot side.

Of course, there are no reasons for delaying these U-Boot fixes.
