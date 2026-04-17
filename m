Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83FEF436A9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C36484286;
	Fri, 17 Apr 2026 15:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fF62hL20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2DA842CD; Fri, 17 Apr 2026 15:59:35 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893588427F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxxMR5d8gz9vBB;
 Fri, 17 Apr 2026 15:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776434371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P71ye3uDjIrgZRaxfa82DVYB92obt+YwmIimsRdgJ7w=;
 b=fF62hL2056DzXutztQwrkg3UYVCbjR0+yJR/4KpUVpoFri5OOSofrMZqtMuKSb+dCyWNfW
 M3+eNRxw0N4+rGkHJBBjxz6piw0UXSsMOlmPpLsME1WCHAXGNKe0Zc+tR4W0q2cVflV6PN
 DbH1NjRx7rWLB2/vep9Q5TPWJ10dk2Yj1sS4FkvwVGc4tQ/ETYxT+K2AlSUf9kVHxwk4c9
 /YKcoDVMUSOcFRk9XVzlK1aRJogxxUDyhcahJqIjionhQ1yqikZGZ1uEpu88O54/q3piYp
 bbHuyeHDn5omyExVJPIptztDMIaHAtG0QHW37oy2gWbIXuR7fzK+siUDZvWe0Q==
Message-ID: <1f4fb105-9f77-4dec-871f-00d90fa0d169@mailbox.org>
Date: Fri, 17 Apr 2026 15:59:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] misc: Add RZG2L OTP support
To: Mathieu Othacehe <othacehe@gnu.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, u-boot@lists.denx.de
References: <20260414091422.16952-1-othacehe@gnu.org>
 <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org> <87wly6rp7f.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87wly6rp7f.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a99b8c75a13ceedcdd0
X-MBO-RS-META: ri879nqfdkwqgdxymuxppfrwrk1xt9zx
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

On 4/17/26 10:00 AM, Mathieu Othacehe wrote:

Hello Mathieu,

>>> + * XXX: To enable direct fusing through U-Boot, the trusted-firmware must
>>> + * allow the non-secure world to perform fusing operations. This is controlled
>>> + * by the SYS_SLVACCCTL7 register.
>>
>> Is there some SMC call to perform the fusing via TFA ?
> 
> No, there is a fusing driver in Renesas OP-TEE fork[1] but that's it.
> 
>>> + */
>>> +#define RZG2L_OTP_BASE      0x11860000
>>> +#define RZG2L_SYSC_BASE     0x11020000
>>
>> Can this be parsed out of DT ?
> 
> There is no entry for the OTP_BASE in the device-tree. There is one for
> the SYSC_BASE though.

How about adding a new node into the DT which represents the fuse 
controller ?

> I took the rest of your comments into account and sent a v2.
Thank you
