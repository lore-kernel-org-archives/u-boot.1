Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB59E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546EF8758C;
	Wed,  4 Oct 2023 19:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u+CIuR8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3E5874E8; Wed,  4 Oct 2023 19:17:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A0486ED4
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 098A0615E8;
 Wed,  4 Oct 2023 17:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D8EC433C7;
 Wed,  4 Oct 2023 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696439817;
 bh=65wN/OPk7VyVnaoHcf2mpY7v09FcPKJdaCZKb1Bz7dE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=u+CIuR8/ePugGDtCtrHAGraYMIAqvKSDUylA0pm9xZwieyDbL+0AGbIHBB9wXKaHT
 OKhgEwYHAaXPM+9f2oWHe1E5tjE2I9l2qdoGK4Z0x4i6dvOyMaBpvTR3yO565gMSFZ
 XDwTKOli+3i+5H3snBaI//sXT+IJMsAiaZsMwDm9gD2WFm8Uxp3zrSQBOQOoosUdn7
 rjRYzgNsuCTkAnPZV3rB/gF92SFvBQKwOOd43tKs/Sq+OvvZG6SImrgu/1xLkkEYK0
 gtfkhX3jt4WO7NzXL0jpoychFyHG0l8RMBpkB7nxyUIg8B/PQF19t0h/ozXWxql/KU
 YVCfGDhLFSfNw==
MIME-Version: 1.0
Date: Wed, 04 Oct 2023 19:16:52 +0200
From: Michael Walle <mwalle@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: miquel.raynal@bootlin.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at, robh+dt@kernel.org,
 robh@kernel.org, trini@konsulko.com, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
In-Reply-To: <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
Message-ID: <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Oct 2023 19:18:39 +0200
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

Hi,

>> >> Add a compatible string for binman, so we can extend fixed-partitions
>> >> in various ways.
>> >
>> > I've been thinking at the proper way to describe the binman partitions.
>> > I am wondering if we should really extend the fixed-partitions
>> > schema. This description is really basic and kind of supposed to remain
>> > like that. Instead, I wonder if we should not just keep the binman
>> > compatible alone, like many others already. This way it would be very clear
>> > what is expected and allowed in both cases. I am thinking about
>> > something like that:
>> >
>> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
>> >
>> > this file is also referenced there (but this patch does the same, which
>> > is what I'd expect):
>> >
>> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
>> >
>> > I'll let the binding maintainers judge whether they think it's
>> > relevant, it's not a strong opposition.
>> 
>> What is the overall goal here? To replace the current binman node 
>> which is
>> usually contained in the -u-boot.dtsi files? If one is using binman to
>> create an image, is it expected that one needs to adapt the DT in 
>> linux?
>> Or will it still be a seperate -u-boot.dtsi? > Because in the latter 
>> case
>> I see that there will be conflicts because you have to overwrite the
>> flash node. Or will it be a seperate node with all the information
>> duplicated?
> 
> The goal is simply to have a full binding for firmware layout, such
> that firmware images can be created, examined and updated. The
> -u-boot.dtsi files are a stopgap while we sort out a real binding.
> They should eventually go away.

You haven't answered whether this node should be a seperate binman
node - or if you'll reuse the existing flash (partitions) node(s) and
add any missing property there. If it's the latter, I don't think
compatible = "binman", "fixed-partitions"; is correct.

>> Maybe (a more complete) example would be helpful.
> 
> Can you please be a bit more specific? What is missing from the 
> example?

Like a complete (stripped) DTS. Right now I just see how the individual
node looks like. But with a complete example DTS, my question from above
would have been answered.

What if a board uses eMMC to store the firmware binaries? Will that then
be a subnode to the eMMC device?

-michael
