Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B4E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B010E87526;
	Wed,  4 Oct 2023 14:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HjOR42PC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8448187526; Wed,  4 Oct 2023 14:17:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FAE87520
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0txN3fY7z9spn;
 Wed,  4 Oct 2023 14:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696421864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWJJMIcQ9hKDAOFEa78v3CMfhAB8auAANMT/+2kFdsA=;
 b=HjOR42PCzd218YkRwTDxYR1TakmbYD5qs8pNw3ds6pBXhUo5UqCIOBQj6/SpyHKHKOPGBJ
 lUVB4ZtYMebYB4bvFW61Cx9Jyzt1vDH8nK0kumdnM3a8ZW34iePpxNHTPwaDrPYk/f4fBf
 tIqND8pOU+hbbja6BDFImGN1ml6bbcR4/YxfXgDma5yVItWNf13g1WY/sLbSXSHzGsFvMz
 Xc0Gf2XsWvw1orOAtcadSdd9Zjoil4G9iJXPFhxDsSSPlR7z+r8YEr2D96BgYFaSFwb0e4
 1WgUBj2rrXwiGl3an86IwZfEHu6FpmqaN1UF1JfdnGW9ZekOvPtfqoKzhIhBUg==
Message-ID: <28064fe9-a696-49a0-99eb-1e233d924bac@mailbox.org>
Date: Wed, 4 Oct 2023 14:17:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 07/16] clk: renesas: Add RZ/G2L CPG driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-8-paul.barker.ct@bp.renesas.com>
 <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>
 <44532c66-f21c-c930-9ca7-963add3196db@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <44532c66-f21c-c930-9ca7-963add3196db@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1f665d324aac0535157
X-MBO-RS-META: 36h9efqq1yxna5t9jynn11nkiondudoa
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

On 10/4/23 10:15, Paul Barker wrote:

[...]

>>>    config R9A07G044L
>>>    	bool "Renesas R9A07G044L SoC"
>>> +	imply CLK_R9A07G044
>>
>> Why not CLK_R9A07G044L (with L at the end) ?
> 
> The driver will also support the RZ/G2LC (R9A07G044C) when support for
> that SoC is added in a later patch series.

Ah, please, do add this explanation into the commit message.

This is really valuable piece of information to de-confuse whoever is 
looking at this naming scheme, really.

>>> +/* Mux clock tables */
>>> +static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
>>> +static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
>>> +static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
>>
>> Is this mixed tabs and spaces here ?
>>
>> (please fix this in Linux too)
> 
> I've tried to minimize changes between the u-boot and Linux drivers, so
> this mixed tabs/spaces issue, parenthesis around numbers in defines,
> etc, is an exact copy of what was accepted into the mainline kernel. The
> hope is that we can more easily port fixes from Linux to u-boot if the
> code remains as similar as possible.

Send patch to Geert on Linux side too and problem should be solved.
