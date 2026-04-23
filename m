Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D60FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 21:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5048E842CE;
	Sat, 25 Apr 2026 23:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="b7WHaHXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE5B84314; Sat, 25 Apr 2026 23:40:28 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D9184258
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wFtNT-0004Ia-Fy; Thu, 23 Apr 2026 08:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=WQwuPSJIlu8mK0+OwDp48DOEvNKDxYpeP88cUII/CLY=; b=b7WHaHXfRlMGq4D3Hs+R
 jTutkSLLuZdDOmtzlmBiGsRSHqLSrOcHBz0OEFGveGNH7M8ERkG6MiV0owfFMdA/iMcZETVn8tvgD
 wvNLhj5UwlQhVzd9n6IifY6/JIGSMcpoEM26T8pp0m0jB6w7+J737c2FiO5DDdgiHp4Br+NphXlfB
 xl2ojqGvr/mKsrr6nNtXIIWZ6GkEbnoRUWPISAxY54M+JFQkhpM3LidKy0+5efEEYKBvkpmL34Q3r
 NMT5DSeEm/MuxNLKAwN9ynfMZ5aswnOO7Bp72idebsVlW9mHlT66ISC6dHH/MZ6Nqt0XcADLBh8m3
 7kZgprf46bKkgg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,  Tom Rini
 <trini@konsulko.com>,  Paul Barker <paul@pbarker.dev>,  Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>,  geert <geert@linux-m68k.org>,  Michael Allport
 <michael.allport.wm@renesas.com>,  Marcel Medvec
 <marcel.medvec.uj@bp.renesas.com>,  Chris Paterson
 <Chris.Paterson2@renesas.com>,  "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] misc: Add RZG2L OTP support
In-Reply-To: <TYCPR01MB11332159D47D6E4ED78598B1A862A2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260422093658.15723-1-othacehe@gnu.org>
 <c9af344e-6342-41a4-9ca3-a683691fcd52@mailbox.org>
 <TYCPR01MB11332159D47D6E4ED78598B1A862A2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Date: Thu, 23 Apr 2026 14:41:06 +0200
Message-ID: <874il197dp.fsf@gnu.org>
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


Hello,

> Is there any reason for not using SMCC to access OTP region?
>
> Currently we use SMCC for reading various bits in OTP region.
> We could add SMCC handler in TF-A for fuse programming
> rather than exposing OTP region to normal world

My original reasoning was that the only existing way to do the fusing
was to go through the OP-TEE fork of Renesas. As, I do not want to use
OP-TEE (even more a fork) on my project, it was not suiting my needs.

Now Marek also raised this point, but I wasn't aware of this SMCC
interface between U-Boot and the TF-A. On the TF-A side, I can find this
handler[1], but nothing on the U-Boot side, even on Renesas fork. Am I
missing something?

If there's already a communication channel that can be used, then we
would need to add fusing support to the TF-A, and turn my driver into
something way more minimal that would just perform SMCC calls to the
TF-A. That would feel like a better option overall, as it would not
require a TF-A modification to allow fusing in the non-secure world in
the first place.

Thanks,

Mathieu
[1]: https://github.com/renesas-rz/rzg_trusted-firmware-a/blob/v2.5/rzg2l/plat/renesas/rz/common/rz_plat_sip_handler.c
