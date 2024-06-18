Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E159CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D05C88315;
	Tue, 18 Jun 2024 16:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="V2X92JUf";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Si6Oqm5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A73883CF; Tue, 18 Jun 2024 16:19:34 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7025D883F6
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id AD6631800101;
 Tue, 18 Jun 2024 10:19:28 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 18 Jun 2024 10:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718720368;
 x=1718806768; bh=hhGJj3rsoUG+729jUWTiqltcei71HTxs5tsZCO36B8E=; b=
 V2X92JUfiJsLteJpWXSAJDVUN84WngJTQM/drRKlWW+qNMzMJeN2QBhQ1G6zxgh+
 vVWw3uoNtSf0OzHJk5xBXB1Hv53ZqKqsIGfwyINgix3jvpAk6FaEZKNrywDuF9gK
 VofbjZl8+5sCiXca/Vo3wpJKG/chDBFoo3C2q5kokj9mw0Ufh6ZD1XbhzIrsHHa8
 WLycveEblJiR8Rd1Rje7oH7Nc8mXMnRiEtj7a1SLwCO3ViETZdUHmB2Yv4moM2vr
 u5c94T2DvpH35DOcHmsyYZmBf4FHwqVGt4GRNPVXyuf212FKO+n9HWHZupWIER35
 aPwEAIIzf3UC/nAUv06gBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718720368; x=
 1718806768; bh=hhGJj3rsoUG+729jUWTiqltcei71HTxs5tsZCO36B8E=; b=S
 i6Oqm5tKfOk9uLbPqgNiCE37VvVev/6As3rjdKT87sGt4pJdRrNHK+zFHEOzimzN
 fWZ1euyHxrMeYXsL33IEgZxaLtxtYe5QSiJoihHmeRIReixc6KCjG8sloxeMpWuN
 GiyrsbuBNLJO2/NF7DvQZImF5jJLz6OqxbFaIJfDtsQ+FGjTiiIOoOmGzXOSBqFg
 zPD0s5blzjZnzkv4PH/lJR/6J2+26QhodYzwDAYcEt7nX3ohu3ScCuEqqVyPCNFj
 UTGecBvaIUdUPYUuoM/5pvch+WWuj6RXP7iUG/tBNLwwJ9MaXf0nSIH4wQ6tGVEo
 WI/AaNugGftCCMyE3kLiQ==
X-ME-Sender: <xms:cJdxZsJAOqLCfRDPxqE9FMRe5gm9Fr-GIxth-08IyaaH-XMc0e7EbQ>
 <xme:cJdxZsL6yZ9wYMTPSuyqJlju_MkBYOSNppiFuxGCcbPzL0Z17gXPHnsX660RDfE7Y
 cjtt82WEO_ojfXrW0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
 ufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjih
 grgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeu
 vdeikeelfeelheekvdffvefhvdetteehgedthfdtkeelfeeigffgteegteeuieenucffoh
 hmrghinhepghhithhhuhgsrdhiohdpsghoohhtlhhinhdrtghomhenucevlhhushhtvghr
 ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgse
 hflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cJdxZstogt5TCO09tTFBUOYoLVjVuI8iuJyyNMrqEheuwPV5KlO9Jw>
 <xmx:cJdxZpZstNGxl6hcveYzt0Nkx7pk8EXISzme7HzKEOXrW4B1AjNBxQ>
 <xmx:cJdxZjbE7M3mmYlqcTryxuutS-tIEB7z2gK_y29rP0RAyjiIjSZGMA>
 <xmx:cJdxZlCrxpww8y_j7QhU0nGEfCPn14_0X37lhP-G3xbJHDa6fwmwqA>
 <xmx:cJdxZiVuhbiKOrPAr1papyp-H8DN5Xxsw7Mqr9Hj3CIay75SZoelp1zR>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1040936A0074; Tue, 18 Jun 2024 10:19:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <561150e8-e856-4993-8026-4872b1a8d55a@app.fastmail.com>
In-Reply-To: <bed8f4d9-957a-4e18-a9e2-8e52db4a60c8@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-7-1407e0b69678@flygoat.com>
 <630db8ca-d954-4fe7-b113-0057d5ba9563@gmx.de>
 <db487a2b-4e1b-44c8-b132-7547b7db515d@app.fastmail.com>
 <bed8f4d9-957a-4e18-a9e2-8e52db4a60c8@gmx.de>
Date: Tue, 18 Jun 2024 15:19:04 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 07/16] LoongArch: lib: General routines
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8816=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=885:00=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
> The "LoongArch Reference Manual" is available at:
>
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.h=
tml#_cacop
>
> What irritates me in
> 2.1.7.1. Cache Coherency Maintenance of Instruction Cache
> is the word *can*:
>
> The Cache coherency maintenance between the instruction Cache and the
> data Cache within the processor core *can* be implemented as hardware
> maintenance.
>
> Maybe you have to consult the Chinese version.
>
> =E5=A4=84=E7=90=86=E5=99=A8=E6=A0=B8=E5=86=85=E9=83=A8=E6=8C=87=E4=BB=A4=
 Cache =E4=B8=8E=E6=95=B0=E6=8D=AE Cache =E4=B9=8B=E9=97=B4=E7=9A=84=E7=BC=
=93=E5=AD=98=E4=B8=80=E8=87=B4=E6=80=A7=E7=BB=B4=E6=8A=A4=E5=8F=AF=E4=BB=
=A5=E5=AE=9E=E7=8E=B0=E4=B8=BA=E7=A1=AC=E4=BB=B6=E7=BB=B4=E6=8A=A4
>
> The cache consistency maintenance between the instruction cache and da=
ta
> cache inside the processor core *can* be implemented as hardware
> maintenance.

Hi Heinrich,

Thanks for the investigation! Impressive effort on decrypting Chinese
semantics :-)

I had consulted Loongson folks, and they told me that all current hardwa=
re
implementation do have I/D cache coherency maintained by hardware, see
implementation[1] in kernel.

For dcache I'll implement it with cac_op.

Thanks
[1]: https://elixir.bootlin.com/linux/v6.9.5/source/arch/loongarch/mm/ca=
che.c
>
> Best regards
>
> Heinrich
--=20
- Jiaxun
