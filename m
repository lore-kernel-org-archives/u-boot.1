Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3CECEB2F1
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FE083A9A;
	Sun, 16 Nov 2025 01:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uxcMwJ2u";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dFVG3Wmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A73839E4; Sun, 16 Nov 2025 01:20:23 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B795983A61
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d8BNN3Rb5z9tKj;
 Sun, 16 Nov 2025 01:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYCAoOl2sg/xB64WtNqmVsHFL3+o++A6nh7rhrDdUWU=;
 b=uxcMwJ2ulQTO91A/uw2YIsD+YtL+Q2Pc40Xg7KwIkrA2TVOri3zDsXs7Gk8/bVE0+LQCTM
 xahUw8XNxE2ZFATM81+cgKeu4/q6qfz4qaaMrUMK/RcBoaCX75IOdjEh1LBJfYShkfIxsv
 nYnKOxXBzRscBlfth5DDvKkCK1lpYg8cVjS87xS8vRg6pljF0yGBqK55uztimJfszcoIcs
 6E9x3xEB0Xs3QupGfiWzQVD2KKw/N4FFtF2mmSQhlQstIjbOzxYSfmCAaLHTeXWpd2IZmf
 cfsXPXOIbEvz2Pz5mbiFw7slPnteZRKcvX1f1WG7EQ4ZDVjYC7C5aF7Ju7OlcA==
Message-ID: <4ccf5adb-6e66-4842-8e4b-1c6f37ec966d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYCAoOl2sg/xB64WtNqmVsHFL3+o++A6nh7rhrDdUWU=;
 b=dFVG3Wmz8w1W5sdt9UtRwoMlPB7XosSmn0tFj/y54/bwOn67DyGnt5BRqIsFPap0C3DR3U
 M0fBpl0E5eFdBEh6CCrnxH43koM+rBATu91D+zuNcccme62IbfSZCFoN13Zy60mC6JeIIv
 gPjDDqbQHfevTfyuYebxHzGaURf2tnenez1CBaHKpVOFbNuup8YhhMf+SyUGr5vOs/Iv6m
 qf+XnbrK4Yr8q6zfZPZxYQUynwWpTv2i8ih3m1pw+mNlmY7/puheIdHhcjK35WiHax8LVX
 caY4MTuLTwwRTIiC61PwXHRbafCyafHnO/K3xZX6MmrEWBk9M696ga23FFC9vw==
Date: Sun, 16 Nov 2025 01:16:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
 <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
 <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
 <20251114143609.GZ6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251114143609.GZ6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 323663efcdb1c21a571
X-MBO-RS-META: ckhf9u38aydzr8stto874eawzotwsrd5
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

On 11/14/25 3:36 PM, Tom Rini wrote:

Hello Tom,

>> We would need a wrapper for almost every libfdt call, which isn't really
>> better.
>>
>>> What does fdt_getprop() return when the offset is -1 ?
>> If can_assume(VALID_DTB) , then crash on NULL pointer dereference .
>> If not, I think FDT_END (premature end) or an error code.
> 
> How are we now getting in this state is a question. Are we being passed
> an unaligned DT and trying to work around/with it?
This is superseded by:

[PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset

It turns out the problem was yet another unaligned appended DT, on 
xtensa this time.
