Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BA2C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 23:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EE482153;
	Thu,  8 May 2025 01:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="Qj1uirY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1440082162; Thu,  8 May 2025 01:36:32 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C118212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 01:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746660988; x=1746920188;
 bh=8jEF/AgIGOrkP5GREd+jF70Gv8PYjrALk5m2CGfWsWs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Qj1uirY5tlCScNhSqv9lx22GMEh+7FsS3pvCsDHVBuK/kZ4hnyQc4WNNTnEJidvrA
 AYQCdXRJ6fhqpOhwC47dGSil8SoYjnKlB3LKJtyTJyGbRS++KeV7QuA0ncTQGdtmc2
 HB8oRk/qbPxQc379JmN3L/BXHo2ad2gZ46OVTxutRKFSnXh1WeFKX8NXI3Em1q38G0
 HAeG3EwV2by9h6Yw6qU/LUZrOjNiNLCG238uuYzNA88FtnBV/QH5DNonSCwzvpzYlN
 hjA/RE7+TWbifrlErPMqOJvAmKwtVSI2/swaHtwNG9edQhYC6GJuhltcAvoO1CxPes
 0Gs7b6Jz2uVzQ==
Date: Wed, 07 May 2025 23:36:23 +0000
To: Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: cpu: armv7m: add required .type name,
 %function directive
Message-ID: <3897e0c4-c71a-4604-811b-e58998d446ab@krotti42.com>
In-Reply-To: <20250507225123.GR5430@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
 <20250507225123.GR5430@bill-the-cat>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 863cfee2d43c8d9e5c2f40ee1d51686ea8ceda0c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Tom!

On 5/8/25 00:51, Tom Rini wrote:
> On Wed, May 07, 2025 at 07:07:03PM +0000, Johannes Krottmayer wrote:
>> Hi Tom!
>>
>> Okay, STT_FUNC is an alternative spelling for %function, didn't
>> know that before. So my question is deprecated.
>>
>> Sorry, for wasting your time.
>>
>> BTW, I will add the required macros and also try to add the VFP
>> support. But I think it's better in two different patches. First
>> patch with the ENTRY/ENDPROC macros and later with the VFP patch.
>=20
> Ah, thanks. I too didn't know about STT_FUNC until now. So I think that
> means all we really need then is to use ENTRY/ENDPROC on that function?
>=20

I have added the required macros, also for the 'reset' function.
There were also the .globl and .type directive used.

Additional I added some comments, if they are not needed I can
remove them.

Also have changed in 'c_runtime_cpu_setup' the code 'mov pc, lr'
to 'bx lr', because I think for newer programmers this is sometimes
misleading. Also for me at the beginning on ARM in the past.

Here is the full code for start.S, which I have modified:
/* SPDX-License-Identifier: GPL-2.0+ */
/*
  * (C) Copyright 2015
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */

#include <linux/linkage.h>
#include <asm/assembler.h>

/*
  * Startup code (reset vector)
  */
ENTRY(reset)
=09W(b)=09_main=09@ Jump to _main (C runtime crt0.S)
ENDPROC(reset)

/*
  * Setup CPU for C runtime
  */
ENTRY(c_runtime_cpu_setup)
=09bx lr=09=09=09@ Jump back to caller
ENDPROC(c_runtime_cpu_setup)

If this is okay for you, I will release a patch v2 for it. if not,
(coding style, ...) then please tell me that.

Kind regards,

Johannes

