Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FB4E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D760686EBB;
	Wed,  4 Oct 2023 14:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cuV5VyoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07C987236; Wed,  4 Oct 2023 14:14:01 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C281E86EAF
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0ts16DGhz9sqW;
 Wed,  4 Oct 2023 14:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696421637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mfI5uUrMU5kY6GMUZXnAiZWw7aoHvh9eZJCWUhlQpo=;
 b=cuV5VyoYbSYzu0TO1krdinhP+Bwbclgu5X5BgSv3gYVp3A2UF0sP4Cj+IqZCvxGddZWBat
 QfwjD7GreUqB1flhrog7fo8zzKDbRIsEQDkppp62GGdhAgljx5XQ5XaAYga9PK0blWH2i1
 +sG9cq1gARGXPu/nrBv1VjEFHWtz8RChLXw/qCx0Lsgpu3ZgxbrvWrNSUFdHOl0nM7wklI
 dGexBXUNO08Fa3NAy+FBjeVHtbBWXyaIJAwYwRPDYKDz0SRbo2gJgPGtJc7/Oyl06J9gnf
 5GqV+UwSi7qdmR7Xx2gvIWLRxJIuinhKS1ji/6DvJZpaRidvOiI1yWNK+GO6VA==
Message-ID: <2f51931f-a286-4b30-a91f-ad462b3ce14e@mailbox.org>
Date: Wed, 4 Oct 2023 14:13:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 05/16] arm: rmobile: Add basic RZ/G2L family support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-6-paul.barker.ct@bp.renesas.com>
 <40598007-6c1d-440b-70f8-469ad12693b8@mailbox.org>
 <102be5d1-c0b4-e532-5d7a-8fea14ce8e98@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <102be5d1-c0b4-e532-5d7a-8fea14ce8e98@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c0d262e0c0f0a2321c9
X-MBO-RS-META: ju1zwtjorsyd594n75dammxeqh99eont
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

On 10/4/23 09:58, Paul Barker wrote:
> On 03/10/2023 13:45, Marek Vasut wrote:
>> On 9/20/23 14:42, Paul Barker wrote:
>>> +	help
>>> +	  Enable support for the Renesas RZ/G2L family of SoCs, including the
>>> +	  the RZ/G2L itself (based on the R9A07G044 SoC).
>>
>> Including the RZ/G2L itself ... and what else (you likely want to add
>> answer to that into this paragraph) ?
> The intention is to expand this list as support for the other boards is
> added in future patches, rather than advertising support in the help
> message which isn't available yet.
> 
> The family of boards is:
>    * RZ/G2L
>    * RZ/G2LC
>    * RZ/G2UL
>    * RZ/V2L
>    * RZ/Five
> 
> RZ/Five will be handled separately as that's RISC-V architecture so
> won't belong in a Kconfig under arch/arm.
> 
> The family has no "official" name, but all share the same core set of IP
> blocks so drivers will be reused across them. Typically the drivers have
> 'rzg2l' in the name in Linux (e.g. drivers/clk/renesas/rzg2l-cpg.c), so
> I'm doing the same here. We tend to refer to the group of SoCs as the
> "RZ/G2L family", and the RZ/G2L itself is a member of that family.

So maybe just add "Additional SoC support is currently not implemented." 
or something along those lines into the paragraph.
