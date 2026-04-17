Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5639F8E4B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0509383FC0;
	Fri, 17 Apr 2026 10:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="HOeOP16P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE0C841C2; Fri, 17 Apr 2026 10:00:48 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421CB83B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wDe81-0003u8-Bg; Fri, 17 Apr 2026 04:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=7y8w/RUwHUcnULW38yDVlJxMHR0wUx/VXJ/O88R9Fvk=; b=HOeOP16Pl/5It0sQHluv
 cpGzTLqXpaGQ4uh4wljJNbI740NuBcuiajD1UqX3FmUWvW5J9xeVwHSgZaJKWjoE9WhSg9CChZG1n
 bPCXuSbq2P9crfXHJp15PYpuOPWc5tg08BUTvo46rxSLhwdGNMEsFKnOJ6Cs0jmclUJBM6coWG3rE
 nfZ+Q3mR4QARozgjp5ood+rOPF913m7srwiMr9F450P1ciaDuNBSzpnUEkAGRwkT2LEcdE/C3V3u0
 iPTdT8GCO2fp5y+YI7huJYk9mbEcvsedaVPLfzHki8uKQO9xuaWP9KZGH8pT3FrDvaz9DSOxqGjtz
 HZJEynwyARqsdQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,  Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,  u-boot@lists.denx.de
Subject: Re: [PATCH] misc: Add RZG2L OTP support
In-Reply-To: <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org>
References: <20260414091422.16952-1-othacehe@gnu.org>
 <a0bb44a6-1805-4c0c-b7a5-0d9d31f9d6b7@mailbox.org>
Date: Fri, 17 Apr 2026 10:00:36 +0200
Message-ID: <87wly6rp7f.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
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


Hello Marek,

>> + * XXX: To enable direct fusing through U-Boot, the trusted-firmware must
>> + * allow the non-secure world to perform fusing operations. This is controlled
>> + * by the SYS_SLVACCCTL7 register.
>
> Is there some SMC call to perform the fusing via TFA ?

No, there is a fusing driver in Renesas OP-TEE fork[1] but that's it.

>> + */
>> +#define RZG2L_OTP_BASE      0x11860000
>> +#define RZG2L_SYSC_BASE     0x11020000
>
> Can this be parsed out of DT ?

There is no entry for the OTP_BASE in the device-tree. There is one for
the SYSC_BASE though.

I took the rest of your comments into account and sent a v2.

Thanks,

Mathieu

[1]: https://github.com/renesas-rz/rzg_optee-os
