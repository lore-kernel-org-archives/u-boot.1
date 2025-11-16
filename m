Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380ADCCD19A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 22:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5609C839DE;
	Sun, 16 Nov 2025 23:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xOrv7SlO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HaDhyyCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8103383ABF; Sun, 16 Nov 2025 23:55:49 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B24839B1
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 23:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d8mSL0H77z9tYM;
 Sun, 16 Nov 2025 23:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763333746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IB9BwD0fa2tqEmf5pU4PgLdue+I/7JxSG+rcPHy716A=;
 b=xOrv7SlOxPGkzsReKDJ4SC4B1L+JDPTqBwoAFliPG/7gCXK4kx+n/U4BQHlwSmnxoSbsAM
 +T5cb7/vidg25b0egW7AO5xQn7+2u6Hs8ak67GyFJOFpqVOjTv1LS9QukgYV54Ife0EfNp
 Y7JqWtJL4wb/1TCKFqV/jCLviueSrp4xyzR8qt4VjKMGVE/8zes6JhuHAa3r3lBzwpRyoP
 O8HGih0lVxHGaR/FEXNZd9r5zaLcvdTLtQswYhBjPMn5likaGvvXe8T92M535o7U+i0lAB
 oS+3diZ9X3bbzkEs36MNodnSBkEv1ZIo0ReStwqEWhOB+ZI2wgF6MhV2GlmBzw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HaDhyyCY;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <93432931-3bfb-4c2d-a3a8-fe938d3ddf64@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763333743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IB9BwD0fa2tqEmf5pU4PgLdue+I/7JxSG+rcPHy716A=;
 b=HaDhyyCYso9NZRhcBj7clQ/z5PpZ8y1sHuImEwuHkAG2SBSyTPaeADol+47lxa2Il+ECq0
 qRujwMH6pN/kBpmt51CyaCAFQqaWxSY/IfjNWBKTatXQ/7u2LCT5Ci7TvMhsNV7TWQV6yP
 Lq2kncSIipTRgEtAZUsmdo/ggNF/rxvdrA9NFDhPQK25V83Ooz+J7+wwzl9KVMT26VR7nM
 bwq/4xR5Y9l2tjA8rvD4iEoK3e4k7r44KGXVblUrvGtxJ+n8iT4LO+rXFvZPf/+dl2ok6Q
 qPMj8gZDz+QLbobHxKFlc32ZuMQRdtefT4Xx0nr0d9LGJJliBtz3Iy2rCMBHpg==
Date: Sun, 16 Nov 2025 22:28:28 +0100
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
 <4ccf5adb-6e66-4842-8e4b-1c6f37ec966d@mailbox.org>
 <20251116141321.GD2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251116141321.GD2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dj5kpedtebfrb7s988nwtokrozy8nu3t
X-MBO-RS-ID: deb2725e69577e5e8ba
X-Rspamd-Queue-Id: 4d8mSL0H77z9tYM
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

On 11/16/25 3:13 PM, Tom Rini wrote:
> On Sun, Nov 16, 2025 at 01:16:53AM +0100, Marek Vasut wrote:
>> On 11/14/25 3:36 PM, Tom Rini wrote:
>>
>> Hello Tom,
>>
>>>> We would need a wrapper for almost every libfdt call, which isn't really
>>>> better.
>>>>
>>>>> What does fdt_getprop() return when the offset is -1 ?
>>>> If can_assume(VALID_DTB) , then crash on NULL pointer dereference .
>>>> If not, I think FDT_END (premature end) or an error code.
>>>
>>> How are we now getting in this state is a question. Are we being passed
>>> an unaligned DT and trying to work around/with it?
>> This is superseded by:
>>
>> [PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset
>>
>> It turns out the problem was yet another unaligned appended DT, on xtensa
>> this time.
> 
> I wonder if we have still more places. I've seen patches in your series
> for many but not all of
> https://lore.kernel.org/all/20221215115825.827111-1-eugen.hristev@microchip.com/
> and I don't recall how many of those were done individually instead
> afterwards.
Was there any reason why that patch (or subset of) was not picked up ?
