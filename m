Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181ECC47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B6B8793B;
	Thu, 18 Jan 2024 18:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="BMVLOQBS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8V1PADz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD94087B93; Thu, 18 Jan 2024 18:56:55 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52596878D3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 15B8E5C00BE;
 Thu, 18 Jan 2024 12:56:49 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Thu, 18 Jan 2024 12:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1705600609; x=1705687009; bh=axVkNa1NI3
 YIj6bCRb1c5jam8Zv+4EhXsNMHEmtr7MI=; b=BMVLOQBSx19Tf8mR2TLZpRk1qn
 4fDgt5umHXGbGUEIdnP20XCWOgWEZr5DWR3D6A+CWoTwt+LlK+yOI2v2f984rSgH
 OGDxXQ+1c0DyXuxgaOKSIzGp7ogMPIbYxuyY8aBkr5AaePvFmKh5q9KCihA2N6DO
 z/Wkxe8vf+qy/WRMrEDZz5HahkQ4Yn2iL6R/LiahWWyooh2g3X3XwdPtsjMmm8/h
 w4nnQSY8XtnE5Tt7TqsCdBq42YKoSUzqMWMjH68HidKPYwraee8l4wVnSJ2gDNh/
 g/scakGNsmhEUQR3cYNNZBWOobA+DkmCSsjykHdq4DJ0sKV+05fnk47htX1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1705600609; x=1705687009; bh=axVkNa1NI3YIj6bCRb1c5jam8Zv+
 4EhXsNMHEmtr7MI=; b=O8V1PADz5L8wn3Pttk/HmxsBlCgMTPjN7onG2bOlMrDC
 jLDoKK/xUm29c/Va5CrNwT3D2dWFvr8CEXXbPAPPHr1QpK339bUs0oD91Nv2Waq6
 rho5Ep8kgp75BTjZUDCnVUcrC+FgbC+xOz+sAD5MbVMDLHjqTuXEH3z/F47GnQDo
 pHvSp/8bkZSN6yimlJC/YRauTMZ5VA5GuYLQA8AnHPuwQv7/r8M3MrHg87dib75f
 +eoNZj9UGVgeJn6wnEtlVVpj+5WCeibRt69XazcGnDbvL8zx16D0CGF89Da6MmhK
 W5OOehteNJUkv3uRakvSp8jdGDr7UGX41tPXxbrL3g==
X-ME-Sender: <xms:YGapZcnFmbhifhjM7OHjtpaNDFvImjH5yRYlf3Tn4c0T6Me8_Rk-mQ>
 <xme:YGapZb3obawdIxb6HcjPbOBSjHlQHEokLFxUZhUSljb-k0YMdjxeR2qWomOKKfSJJ
 pN33nL6G8H7r3ZrvGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfgr
 nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepfeelfedtgeduteefleevgfeukeehteevtddvteeuveevfeeuvefgveekuefhheei
 necuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgpdhkvghrnhgvlhdrohhrghenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghn
 nhgruhdrnhgvth
X-ME-Proxy: <xmx:YGapZao-gpWti1lNQJmtvl3iUFmaSX795bVD1VvchOvtwX7kMwj28g>
 <xmx:YGapZYnWXCLY1nDdNAUKNVVH7EnwkCRf2BmrVAFrV2AiFCouiXJwDQ>
 <xmx:YGapZa0y1tq4vA702sqGWGqMYPcyiiE_qu6z7SQ0udwDbl7Igzxu6g>
 <xmx:YWapZfyn34UJiVW9FbwY9d5-O6PfWuUO308iC-_8s2e2y4z6ViwrUw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 850093640122; Thu, 18 Jan 2024 12:56:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
MIME-Version: 1.0
Message-Id: <0e90a932-1b07-4a58-82ab-da39388d3146@app.fastmail.com>
In-Reply-To: <4ce6fe84-0897-4eeb-9b0a-34add92de8b8@gmx.de>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <4ce6fe84-0897-4eeb-9b0a-34add92de8b8@gmx.de>
Date: Thu, 18 Jan 2024 18:56:28 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: "Simon Glass" <sjg@chromium.org>,
 "Andre Przywara" <andre.przywara@arm.com>, u-boot@lists.denx.de,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Anatolij Gustschin" <agust@denx.de>
Subject: Re: [PATCH RFC 0/6] video: Add UTF-8 support for UEFI applications
Content-Type: text/plain
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

Hej Heinrich,

On Thu, Jan 18, 2024, at 17:47, Heinrich Schuchardt wrote:
> On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
>> Andre submitted 2 years ago DM_VIDEO improvements for UEFI applications
>> using UEFI's EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL but did not follow with
>> suggested changes. This series takes care of the UTF-8 support which
>> required to draw symbol and box drawing characters used by UEFI
>> applications like grub2 and sd-boot correctly.
>>
>> Compared to Andre's version this version has the following changes:
>> - use and extend existing conversion functions from lib/charset.c
>> - convert first to UTF-32 to support the truetype console as well
>> - conversion is conditional on CONFIG_EFI_LOADER
>> - use escape sequences in tests as proposed by Heinrich
>
> Hello Janne,
>
> to correctly render GRUB I think you need the following:
>
> * Use truetype

a truetype font is not necessary, the arrow glyphs used by grub are in codepage 437 (code points 0x10 - 0x1f, see  https://en.wikipedia.org/wiki/Code_page_437#Character_set ). grub2 and sd-boot render correctly with this patchset and bitmap fonts.

> * Add a mono-spaced Truetype font which has all the needed characters.
> * A bunch of code fixed.
>
> This is the font I once suggested.
>
> [PATCH v2 1/1] video: add DejaVu Mono font
> https://lore.kernel.org/u-boot/20210301181534.7618-1-xypron.glpk@gmx.de/
>
> Which font have you been using for testing?

The 8x16 and 16x32 bitmap fonts and the included Anker/Coder Narrow truetype font. All render the grub menu correctly but the bitmap fonts are missing some of the glyphs in the international character efi_selftest by Andre and you.

> At the time these additional patches were needed.
>
> [PATCH 0/6] efi_loader: Unicode output in UEFI applications
> https://lore.kernel.org/u-boot/20210227130840.166193-1-xypron.glpk@gmx.de/#r

That is functionally identical to this patchset except for the Unicode mapping for code page 437 code points 0x01 to 0x1f (Patch 3/6 "lib/charset: Map cp437 low chars (0x01 - 0x1f) from unicode"). I wasn't aware of this and stopped looking after Andre's patches. It looks like patches 5 and 6 were never merged. Was there a reason for that?
best regards
Janne

>>
>> Link: https://lore.kernel.org/u-boot/20220110005638.21599-1-andre.przywara@arm.com/
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>> Andre Przywara (2):
>>        efi_selftest: Add international characters test
>>        efi_selftest: Add box drawing character selftest
>>
>> Janne Grunau (4):
>>        lib: charset: Fix utf8_to_utf32_stream() return value doc string
>>        video: console: Parse UTF-8 character sequences
>>        lib/charset: Map cp437 low chars (0x01 - 0x1f) from unicode
>>        efi_selftest: Add symbol character selftest
>>
>>   drivers/video/console_normal.c             |  6 +++--
>>   drivers/video/console_rotate.c             | 16 +++++++++-----
>>   drivers/video/console_truetype.c           |  8 +++----
>>   drivers/video/vidconsole-uclass.c          | 18 ++++++++++-----
>>   drivers/video/vidconsole_internal.h        | 15 +++++++++++++
>>   include/charset.h                          |  4 ++--
>>   include/cp1250.h                           | 12 ++++++++--
>>   include/cp437.h                            | 12 ++++++++--
>>   include/video_console.h                    | 10 +++++----
>>   lib/charset.c                              |  9 +++++---
>>   lib/efi_loader/efi_unicode_collation.c     |  2 +-
>>   lib/efi_selftest/efi_selftest_textoutput.c | 35 ++++++++++++++++++++++++++++++
>>   12 files changed, 116 insertions(+), 31 deletions(-)
>> ---
>> base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
>> change-id: 20240117-vidconsole-utf8-uefi-fa23b4ac65d6
>>
>> Best regards,
