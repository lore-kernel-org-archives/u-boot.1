Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABA2FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 03:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F62384869;
	Tue,  5 May 2026 05:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LZCh7hMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C00184876; Tue,  5 May 2026 05:34:01 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A97A84869
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 05:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g8kdK4ZjYz9tk3;
 Tue,  5 May 2026 05:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777952037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgkJ/+YA221nDcmwc2aAZlDSjNhQ5KEELxAPo3s1yLU=;
 b=LZCh7hMg9KwvagSjGu7s2dz8fhq0YzeoYyqzD0CVMW2JAzBlbEXYTSwE+SAYjxezlUUYzO
 6Dr5ca7VOnWAFhORDqfdWMB4goOsHIt9doeE12IC69R9+1V4cmNoamsEw58a5kh4y53Pf9
 32HIM7qK1lBoEsgXmX6SMBxRNitrr2560jetUVFCPUzeL6sDG7P6j7hASfN/aa27EY3yxU
 CkrEThCjZXmWUilKTkMleJeap4DjvxizdMItNK6tdRL/2umEj4Glk5X+aC7RlYWkpImYTk
 EaYp6YrPx+sdHv57G1ocbMgywU2cRQr8foH03xur11lj/VF8YSg/GsSqjzR4Ag==
Message-ID: <bf004f11-d46f-4e0f-8194-d5bc7c191c94@mailbox.org>
Date: Tue, 5 May 2026 01:41:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] misc: Add RZG2L OTP support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 geert <geert@linux-m68k.org>,
 Michael Allport <michael.allport.wm@renesas.com>,
 Marcel Medvec <marcel.medvec.uj@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260422093658.15723-1-othacehe@gnu.org>
 <c9af344e-6342-41a4-9ca3-a683691fcd52@mailbox.org>
 <TYCPR01MB11332159D47D6E4ED78598B1A862A2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <7ac4e375-859c-43a9-9cf2-fc44505e2c30@mailbox.org>
 <TYWPR01MB11343A62FB03012A458C1B1DC862A2@TYWPR01MB11343.jpnprd01.prod.outlook.com>
 <TYWPR01MB11343DA55762DB428EA42B211862A2@TYWPR01MB11343.jpnprd01.prod.outlook.com>
 <9e1786f1-2607-473e-8ed1-dc29c40ec470@mailbox.org> <87cxzkn4rr.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87cxzkn4rr.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sd36sarfhwg6nn9fkbh3qxtxoiqjmey9
X-MBO-RS-ID: 8fa59056fa616fc6524
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

On 4/27/26 11:15 AM, Mathieu Othacehe wrote:

Hello Mathieu,

>> If you do want to expose the fuses via SMC , then the fuse region has to be
>> secure only , so only TFA can access it . TFA can then decide which exact fuse
>> the user can or can not read or program, on a single fuse granularity.
>>
>> By default, non-secure user should be able to read some select fuses (IDs),
>> program no fuses. User should have the ability to expose some select fuses as
>> programmable, for manufacturing purposes.
>>
>> Mathieu, which fuses exactly do you plan to program ?
> 
> I plan to program all fuses (enable secureboot, ROT hash, user
> encryption keys) using U-Boot directly or U-Boot + TF-A during
> manufacturing.
> 
> I then see two possibilities:
> 
> 1. During manufacturing, use a specific TF-A that allows fusing from the
> non-secure world (with SYS_SLVACCCTL7 register). Fuse directly
> everything from U-Boot, using the patch under review. Then, flash the
> regular, default TF-A that does not allow fusing from the non-secure
> world.
> 
> 2. During manufacturing, use a specific TF-A that allows, via SMC,
> fusing everything from the non-secure world. Write a new U-Boot driver
> that performs fusing through SMC. Use it to fuse everything from U-Boot
> during manufacturing. Then, flash the regular, default TF-A that only
> allows specific ID fuse read via SMC.
> 
> Both options require a specific TF-A during manufacturing. The only real
> difference to me is that with option 2, we can allow ID fuse read from
> U-Boot via SMC during regular use.

This difference is in fact a bit more important.

I agree that in both cases, it would be necessary to have a TFA capable 
of programming the fuses, with one or the other mechanisms.

It is possible to expose the fuse block as read-only to U-Boot/Linux in 
either case, but this may be undesired. It may be undesired to expose 
all fuses to U-Boot/Linux, instead, it may be desired to expose only a 
subset of fuses to U-Boot/Linux and prevent U-Boot/Linux from even 
reading other fuses.

This is what I see as a benefit of option 2 -- it is possible to limit 
which fuses can be accessed from U-Boot/Linux with single fuse 
granularity. This is not possible with option 1.

But please look at prior art if/when implementing option 2 and learn 
from their mistakes, Linux drivers/nvmem/imx-ocotp-scu.c is for MX8Q SCU 
which is old and odd so ideally avoid that as an example, 
drivers/nvmem/stm32-romem.c is I think limited to programming only full 
32bit words (?) and does not handle single-fuse granularity. It would 
also be good to design the SMC ABI in a way that maps easily to Linux 
NVMEM API and in a way that is generic, so others could reuse it (if 
possible) and reuse the (generic SMC fuse ABI) driver.
