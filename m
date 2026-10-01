Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE765CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24390810D9;
	Thu,  1 Oct 2026 20:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAvqC9fvea_0; Thu,  1 Oct 2026 20:41:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 09F478113C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887263;
	b=WWlH0ftBVyg75TBWpz0ktS7qn5LPNn+obmE4HnV/m4L431gVAd8Nr1/38AjxNeUESDPk
	 cMs12LHUQZat2yGrbGroHU+aahCeakcJKne29pZOIwtkXs45D3dBXsHK7nrEIWl6Wg/Pb
	 6pAW7LdkgNntP739h+OweaalyX5MoMnFx5qulEQh4zeGC5z3yBTnJgcKuYePnw9EIcpA/
	 KwF8o5E6TW8f/pY7Z5tUEwl8N/i7QtN0czoCP7qTAEv+Hdj0NTaFfjYbJc3/RZWoL/lHv
	 kKRQMaYE4dmEuEcmRuWM6n1Q6oj+GhMsIvJbNeoWbf96SB8TdPeXUK0bC7yKgamjdEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NAfcA/Ag7z2wKT7lnNNCZIt5Iq2bv5M8SU9K4VR0rAk=;
	b=DfzpziLGxTL4+I0jSuADmHhXRIW0+LndP3ZYQEdXxz7BDxiRjkjpswt2P62ghFdIcd1K
	 prob46ZjnaiidmOIgz7s31dBRngVLgVxZzr2pJSy3B0h26WJO0XUJEPmB/vcjhiHOMwS+
	 90Rafe4fQTW+p6in8Qi9zyvhUMj/x3vuZ0dKUwxAujwQlTbbz1tyRJT6y/msAXvTzoNO2
	 Z6dVUhttZV0OMYmmXTQ/cUdIqA6Sc6Dl7L7aybp9X9cdqJaeL+Eaike2nlyW8WgHSZUTK
	 goFLva+svbRAeC9L07VRQlH1BB/kJKVPbeiFm/vpb0yPU6WLetYhnkLHhbhXDS/aX1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887263;
	bh=NAfcA/Ag7z2wKT7lnNNCZIt5Iq2bv5M8SU9K4VR0rAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vWi6XymcvOW1GsceKQ5z+2X9iubYwqDwX8si4GbFQ352u/k6z6AG610X+R0r7aty7
	 SUgH+39X1JPs9olikV9nMu0GMj5f2yOIctCM2OG4X8s/BRX7AabrZAVmHbXm9U9hvQ
	 ZdPLhBFtCGTsP29P4IVPu9H1ZVa6llfteHpVAcWIvV0CLVyFgpSVRdfx4ZRaFWCkGN
	 Lj5JJInTIzd5+VV8UpMvrFnraieNc+sHuz0QIiDv6bECbfxJgsgwe18K/NWXG7LWUD
	 SNnE3hhvlYypGQda4GQ5bdhFF0T5jNc6/tiAjKEmU1xPp8oxfHVVm24qOtm00qIu8d
	 AgLi9564q+xXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09F478113C;
	Thu,  1 Oct 2026 20:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 12F7222B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD1860660
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xnXeVmqE-ll for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 999796063F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887260;
 b=YdrMsY/g1thhx78faHDtFlv9Kql58ch3ZGMDigeibJ+fiVCqtCnoAXukJUotV5AP3Kla
 jXlPMu4rRt/dto2RRGaqOXuASlsS+hHOfdOuBO+qhOK1ENk6nAKUBMTfDdh+7KKVr8JwO
 hqsG406huvtUyJXZ8YftQdNLi0uugBCvjrUCaCT5k43uTMTtTlnvsdPTyKf33OVUJQk5H
 6QU5dcX+eaF6abX5RqABdupNtHnqNQigIywAE8X1U9Zwk5u8ijDJZXdu5YcIseoRA2Toy
 4QP0awNvMq93LVUvnAAjaJZgBmnK7jKNuveDDpE9expnjgFG/lY2SjDM+tuJWdY6uWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887260;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=NAfcA/Ag7z2wKT7lnNNCZIt5Iq2bv5M8SU9K4VR0rAk=;
 b=R2etP1OPXmZylMSXY8+nUVCR1CY0AIg3k0wYc1Puu/6uHPipI2WKukokkmh/M3/nD25V
 Zai0FB6hpPkXGlAyGsTEs0q4HBLeToGp4ejtWHK0tNY5n+/f/tesq+8wg2IzONsfMd26Y
 reU4zKmn9n5xtjiYagObrGu1lPoerP3sWR+CthCBwf5tAg5MlRiw9GC1fFzpjMkE+EjdB
 1C3AyGNXxQBq5wLhpVaK+VIa19s3/lJ+noJrEl3KOrLopP7nwEsGnDjqoErBSnRMIdgxg
 h7cu8fUMnLQitfN1uH3U9+dmIUO6slC0Qx8w9RR0FTKn72iPWwaitawvjv34ABe6yaA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=T5NfTWj1; 
 arc=none smtp.remote-ip=212.27.42.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.2;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=T5NfTWj1
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 999796063F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:40:58 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:4c30:72d6:1cef:7a3c])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 25A522003A4;
 Thu,  1 Oct 2026 22:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887255;
 bh=yBA5wwuTwf8MU3SBBh2ZVH/u/JMOCYB1oFrnnEz6q+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5NfTWj1WzfPO0kWaG6ojityEFj32RCLvxCMDrZO9nbrzvFWySJjP+KymKg7PkU9u
 5h+N3RpS5GkS/WxvvgBcxk4EogrpPBp6bsShR5+6nI4g2eQaKU7FPKM5EzxyP4At+w
 ZmeILbGJM0Ha35bfxZLn7DJ81s7YitiUg1VKBQU9mj7aWkwA/1rBQYNZcEQyhn00tu
 bQGhh7/XYS2gW+be87dJyFCNGeo26WqDN91MV7m4bCeWRAGT1unX6saG+mbU7szB/Z
 H1/dbImrbj/oHA1wca+RzJ5WMsQDYbG9u1P+ihdBlrrhkhtYBnAT3lvXpqjrHqybFN
 oHvk9TbqXqpxw==
Date: Thu, 1 Oct 2026 22:40:45 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 08/13] board: lx2160a: serdes: add serdes1:2x40g
Message-ID: <ar7FTdJUk30BviBl@L30177.local>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-9-vjardin@free.fr>
 <20261001145529.k6qqeqdl7ebdwwsg@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001145529.k6qqeqdl7ebdwwsg@skbuf>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Vladimir,

On Thu, Oct 01, 2026 at 05:55:29PM +0300, Vladimir Oltean wrote:
> So it's *not* that for 25G you need to multiply by 2 and for 10G you
> don't. It's the fact that a single PLL can produce a single clock net
> frequency, and no clock net frequency can satisfy both 10G and 25G.

Thanks for the explanation. I'll update it into the v6 comments,
something like:

 * A PLL makes one clock net, and each lane takes its rate from the
 * clock net of one PLL, through its own BY_N_RATE_SEL. 25GE and 100GE
 * lanes run at 25.78125 Gbaud, twice the 12.890625 GHz clock net of
 * PLLF. 40GE lanes run at 10.3125 Gbaud, which no ratio of 12.890625
 * GHz gives: they need the 10.3125 GHz clock net, which only PLLS
 * makes (PLLnCR1[FRATE_SEL]=00110b). So the lanes move to PLLS.

> Technically "does not power PLLS up" rather than "powers it down".

ok. I'll word it for the v6:

 * Protocol 13 does not use PLLS, and NXP's RCWs for it power it down
 * (SRDS_PLL_PD_PLL2=1), which leaves PLLSRSTCTL[DIS] set: software can
 * clear it.

> > PLLS then gets the values a board booted with
> > protocol 20 reads back.
>
> This sentence doesn't make too much grammatical sense

ok !, I'll reword it.

> So SRDS_PRTCL_S1 does not influence the refclk that the PLL expects,
> instead SRDS_PLL_REF_CLK_SEL_S1 does.

I just checked the RM:
for 40GE, the PLLS bit selects 156MHz (0) or 161MHz (1).
NXP's protocol 20 QDS RCW and ours use 1.

> Technically, the board does not *have* to feed PLLS a refclk
> frequency. We have the SRDS_INTRA_REF_CLK_S1 option

ok
So, the code only needs 161MHz at PLLS, where it comes
from does not matter.
On nbxv3 both SD1 reference clock inputs are fed 161MHz,
so I have not tested SRDS_INTRA_REF_CLK_S1.
v6 names both sources.

> Is this what you intend? It doesn't necessarily read as a conscious
> decision.

It is a conscious decision, but the comment did not say so.
Only 161MHz is supported/checked, because it is the only one I can run.
For 156MHz, PLLSCR0[REFCLK_SLE] would be 00010b, and I would also
need the CR1/CR5 values the SoC loads for it, which I cannot check.
It can be added later, by a board that handles it.

v6 will state so, and also that the PLL lock bit does not prove the
reference frequency:

 * Only a 161.1328125 MHz PLLS reference clock is supported. It comes
 * from the SD1 PLLS reference clock input, or from the PLLF one when
 * the RCW sets SRDS_INTRA_REF_CLK_S1=1, as 25GE and 100GE already need
 * 161.1328125 MHz on PLLF. 156.25 MHz, also valid for a 10.3125 GHz
 * clock net, would need PLLSCR0[REFCLK_SEL]=00010b and is not handled.
 * Nothing here can check the reference clock: PLLSRSTCTL[LOCK] does
 * not tell its frequency.

Thanks,
  Vincent
