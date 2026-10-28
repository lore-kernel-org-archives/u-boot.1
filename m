Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F41606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rxBtQnAP;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=dgUR0yOY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF8AD409BF;
	Wed, 28 Oct 2026 18:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ssQCEcLqklt; Wed, 28 Oct 2026 18:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2C2B409C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793213465;
	b=HsLQqzmKeAM35708diEYPfYndAH9QefVphz+vCitoEz4BX5pdzUUkzunF1V7S8W18Zwu
	 Wp+q/fAau7AONHWr5BynJc/y11+PQRT6wOPVdZ7scDKsfo0n+/7NSVcRyzophuTtgbM45
	 n+alS9MtNBYREHZ+iP4BjRWMtyVhAuJEAtz9wB2GeXojqVArMfNt+nZKAsoeaXYeMjhvY
	 2RyS567vy43w75egAREK37IIUwtSVs0dwnS4rq1ePHPhjefltTTYnVuylHvzaAWixKUcc
	 wGeHcLDUSmhN62ooyjWJVXtPNPodEB3pQckbUdpEOeS1gkGI66cFB5nXbpy/6S80yXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793213465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IK4aDyrsM5FQoqvsjwXPtvAGhN4ISjNMiMwXTQq1LjU=;
	b=XU0u1U/+gx1LmpFx4ppa6sTzdiWHKOX7c7ACXUTaq64DyRJVZlg9TIkPI/VrFTMS+vOo
	 PI/M8t/6BKeJts09Jg28cSMelcDjOZcMk4lp1HvuWQ5Ms8cgLIhpH6jjhXoTrs5nTx1Qt
	 T0dvqHBWCedRjrjeniJYj8OspSAeDcC2zHa/OFLKsKduhg+7uYFHykYmWUMjp/k0ewIXg
	 f/WTHaOtrmSk9k9UnuKeZmFocNTF1Sm1pYoVQXp8qWM6xrMKX8MFYQehaBylGoJPG3hLG
	 J4051Luva0LIKQSxpixJunOtOkbThXDnOYpC2u1TNA6fYXDNdTWcEhQC4R9zsmwJihA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793213465;
	bh=IK4aDyrsM5FQoqvsjwXPtvAGhN4ISjNMiMwXTQq1LjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rxBtQnAP7fQJo1PcD2JKfjFx0BGRmcqUUzkwEYHV/uKiga1b7pv+KVB/XRHtk7qYe
	 JVLYjk6/q8OKxlhHp0e4AJLSDzqqzoDzxzmtvdpIJPiV61iBdiSlN8norqL6pKT8jp
	 mBbtE+162AalpzFCTmusXTfCL8ZMU+wAIRBu/bdFzxNMrtxJuK8O6av4vKnwTMBLw7
	 t2ZB8Zx1Z4DtHbqmP2bcseAIH3Q7ZVy5CxnMNhRXLyqEjstVzesZR2YwwFfipRZ1nh
	 ISCwF63Oahrhc6/MeciSDZmsPiB+9pAF6vSiVNdjNbXub4/zgd185k1AwIHHXypjLA
	 isZBCLwC8rNZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2C2B409C0;
	Wed, 28 Oct 2026 18:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BFD0529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DE6880DBF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ud2Rwtrl75HS for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4940580D66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::42aa"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213463;
 b=erpgcjCOshNLqLtMt93Utf7xeoDkmXN8SzETpj3FpA/ykc0MfzlrgjYgHWYQY2tsLgaA
 HAuoGivtmsxcSOkRwkg2OpeBhLNsb2zMKVBqos3u1JCXg0DmIHHeVyVE1nYxu5Md5MwM5
 ms1ssE/aq1d+0Nc2aTCfFVpzu5oHOT6jVfIhxgiFTp5gdcZnCUlKU+StN4AT9NbQHi/Xh
 Sz0JbIHrHxbbTaibfT4b8vASOr5/1xPuLdVdLS0bxx1va9n+d63BtAxdMipcZVX787tJB
 iZx7/EojJFjxh50+K2F+yr7clhh0yjY+weh+7hUjNsvuZ4YXjwzVIUYsBY51aUvjoXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213463;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=IK4aDyrsM5FQoqvsjwXPtvAGhN4ISjNMiMwXTQq1LjU=;
 b=JeWKZKNNpEF9fyGzInMlcZxoh6U+ir9nP+D2f9vsMgQYhb0KL8V8X1na+1uaaXgedwS2
 1xTnsy0reuGxqaWgPxo/FJIUm60sJTOTxtRgJJR0rAqE8Xj/rtyMD3BvQKMi4X2Ti3qmz
 3O1riWUpWjyv7v6lxRc19XrzBGgHzaHsFF+4t1n2bI73tr7sq6hBHzcgeM/60b4bnP9pV
 Kf1lK8tWFifAi63aqNCcEYHVCdrobNxCFpcAldckhIeq8QNjyRZom5zhJUB1arEC6KM8O
 +NWpDGzRLBXsJsQ0oQYBlmAfdIhWo4JEJ4XDRFF+MfL5i3/Aq7B8Ob3NfvOAg/7a1Yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=dgUR0yOY; 
 arc=none smtp.remote-ip="2001:1600:19:38e0::42aa"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::42aa; helo=smtp-42aa.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=dgUR0yOY
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::42aa])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4940580D66
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:00 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFGfB3QL3z1Rtr
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 19:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793213458;
 bh=IK4aDyrsM5FQoqvsjwXPtvAGhN4ISjNMiMwXTQq1LjU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dgUR0yOY2AO6b8jwzxQLD38ebcdiWJe/Jl/Ge+phI9mgU8IrEdl7ogxh1gIqcOChZ
 t3F9sIEW/rBOjTgX+sHljCdcyyQt42V19PKOsxVIFpNWDSH6ieEfYfo9mFu8nVV858
 ZGvMrMMRmLJURJ/EHi2+lc90Tmy9Ob5CE6ovyY/cIA8CUXdSNvMAveExMBBhcPBxcB
 Ho8Nej93djLtfVI+uP26zocULxTTe9T1vw2OhF1zRV6YdQzJocbSA99P5Ajkranaop
 pKVdJPC0SO0KZwbpm2wQJnV3CP9qSzduXuV4ipguj0Y3WlxCNtsw1xGDFznEn+bPlv
 b56oy95ftuVMQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFGf92NbnzRMr; Wed, 28 Oct 2026 19:50:57 +0100 (CET)
Message-ID: <7d5ab66d-1b25-451d-be99-979f0324b6d5@0leil.net>
Date: Wed, 28 Oct 2026 19:50:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Kobol Helios64
To: Igor Velkov <iav@iav.lv>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
 <b102efbe-548b-42b5-bdba-c744449db9e6@0leil.net>
 <20261028-h64-uboot-v1-review-reply@iav.lv>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261028-h64-uboot-v1-review-reply@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 10/28/26 7:45 PM, Igor Velkov wrote:
> Hi Quentin,
> 
> On 10/28/26 1:25 PM, Quentin Schulz wrote:
>> Can we have you as a reviewer at least, so that any patch modifying
>> either of the first two helios64-specific patches are sent to you and
>> you can review/test them? Is this something you'd be ok with?
> 
> Yes, as R:. I can't review schematics or drivers, but I'll boot-test
> helios64 changes on my board.
> 
>> Please work with the Linux kernel to get the vdd_log and vdd_center
>> parts reviewed and merged there.
> 
> Sent on 21.10:
> https://lore.kernel.org/r/20261021-helios64-vdd-log-center-v1-1-4cafd110e0e5@iav.lv
> I'll send v2 once it lands in devicetree-rebasing.
> 

Ah, should have checked myself. Thanks for working on this proactively!

>> This is already the default (except it's a lowercase f by default, hence
>> why it appears in the defconfig), please simply write it lowercase so
>> it's using the default value.
> 
> Done, the line is gone.
> 
>> You said SPI flash boot wasn't tested, maybe don't generate an image
>> that we don't know is valid?
> 
> Tested now: SPL loads U-Boot from SPI, then Linux over TFTP, 6 of 6 boots.
> 
>> Is the offset used by the Helios64 original support known?
> 
> Kobol's U-Boot used 0x80000, which also boots here. I'd keep 0xE0000 like
> the other RK3399 boards: an update rewrites TPL/SPL as well, so the old
> offset doesn't matter.
> 

Technically, you could flash TPL/SPL and not proper and maybe still 
reach U-Boot proper (so new TPL/SPL + old U-Boot) or vice-versa. Using a 
different offset means you need to make sure both gets updated in 
lockstep. This is also not powerfail-safe (imagine a power cut between 
updating TPL/SPL and proper (or vice-versa), then you would have a 
bricked device. RK3399 Puma has a different offset as well, due to 
historical reasons.

Up to you in the end, but I guess it makes things easier if users don't 
need to figure out where to flash stuff (well, except if they use 
u-boot-rockchip-spi.bin at the actual expected offset).

Ack for the rest.

Cheers,
Quentin
