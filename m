Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F336C28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 02:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349618070C;
	Mon, 10 Mar 2025 03:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=testtoast.com header.i=@testtoast.com header.b="MMx++aCE";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXX6FOVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C97809A4; Mon, 10 Mar 2025 03:36:44 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C448004F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 03:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan@testtoast.com
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 26B221140113;
 Sun,  9 Mar 2025 22:36:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-13.internal (MEProxy); Sun, 09 Mar 2025 22:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1741574201; x=1741660601; bh=imDwWPN2j0ieYUj5D2vQxi/r5MfhjOWb
 zk/XtH9q3zU=; b=MMx++aCESxesUnpemYpyKmO3HVUtlf7STcCtX/rRRcyDFl33
 MLknT9oo3OhiLBTFC+BmJlJnJ5UkebQZpAzk0Kx6svHs6SQskKNk1VcYK2N+v4VZ
 1s0z1b/fnmCdmVKxkTxmyEl8bzPMqm1cU+Zvwe0aSBuSTQIheB0flYzjaIfjpX/g
 Pb6MJgieVZtm21K2UBZ8XXYY6wlaKf9iGqB+ok2oUDcFZcPkw3UU5NAAduR2k5Pd
 +W4nNLr6FwXMHzWKCnVngBFNh3kZWi/PfBNg/N4aTRm3bshbOkQC/wyORA+qZRhk
 T+TpCBnlMGoKvDGElGm/JSjbuoJ84YgMlCpqpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741574201; x=
 1741660601; bh=imDwWPN2j0ieYUj5D2vQxi/r5MfhjOWbzk/XtH9q3zU=; b=G
 XX6FOVtOHZP9lHlBw3tkbRgvt1/i6fwmeH5pVb1XvRfkmQ1rwhIf+15O84ZZ0UY3
 99PQ2UKDhZJYQ6/MjvuNJ0YDmJoXtLzxVcp8J2LI1Eb2BksZ6t7nt5lyqA4qR+tu
 03ZLnB9HP7tad40AMWPESS57tTLFhasgWXZ1lF/tIVURYCNiwxO9Zp8kfMvTNmzC
 YzJFG0hsw8xHXx2okj5fS+uobIeCJPMwB+Yk/tj2Vliag2dJHTFgpOzhWJjkhWkw
 3zcO4+arxkTdhMyJVVfPFosEKv5s8iD/7ktiDotMKY51uJKoS4joPJSZ9KxO0gGG
 f7ngM6yEPXI7bmRZ3fxIA==
X-ME-Sender: <xms:OFDOZzi1gQgXHKrHdh4pkDKcKv3pXiUoSOJweYFm3Mju0PGETFD8gQ>
 <xme:OFDOZwCVoA_u-2rQdsupk5t9VyRphebvl2LDvY12vW1RDw3Hld0v7Q_0qYEI5mYOo
 FVgZWzNHhnzi4kcSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
 tddtnecuhfhrohhmpedftfihrghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtth
 horghsthdrtghomheqnecuggftrfgrthhtvghrnhepjefhueekjeejgfduvdffheevveej
 hfdtuddthfduuddvveefjeffgfdvleefuefgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheprhihrghnsehtvghsthhtohgrshhtrdgtohhmpdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghgrg
 hnsegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopegrnhgurhgv
 rdhprhiihiifrghrrgesrghrmhdrtghomhdprhgtphhtthhopehjvghrnhgvjhdrshhkrh
 grsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggtrhhomhhorhhgrghnsehh
 ohhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtoh
 hmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthht
 oheplhhinhhugidqshhunhigiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:OFDOZzHJnUA-xzEgMRRw2JUclLokI_YAVEckXVpR03UZlsvID3Qp5w>
 <xmx:OFDOZwQcAIIGWbItamvfQ5LmpoCVWmJpWSv6RZ8_gEh-XS5kU7lvEQ>
 <xmx:OFDOZwxKK_t-Y_B_y5Njk5DcXpRlWy2eKpGZcPNbz8TMi8RA0oSHww>
 <xmx:OFDOZ27r6wGyHCq03InThJ-fCEydPOqGSWTGfS6va-nX08sOhL7d4Q>
 <xmx:OVDOZ3nYJvXTQdg5SWVDMCrt5zL70LjUTW5D8ccMq4fBneUjNP9756mT>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9A261BA006F; Sun,  9 Mar 2025 22:36:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 15:36:19 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>,
 "Andre Przywara" <andre.przywara@arm.com>, "Tom Rini" <trini@konsulko.com>
Cc: "Chris Morgan" <macromorgan@hotmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Message-Id: <10b26205-6798-4ed4-b170-4555265e08ac@app.fastmail.com>
In-Reply-To: <20250309063143.62859-3-jernej.skrabec@gmail.com>
References: <20250309063143.62859-1-jernej.skrabec@gmail.com>
 <20250309063143.62859-3-jernej.skrabec@gmail.com>
Subject: Re: [PATCH 2/2] sunxi: H616: dram: Improve address wrapping detection
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Sun, 9 Mar 2025, at 7:31 PM, Jernej Skrabec wrote:
> It turns out that checking just one write is not enough. Due to
> unexplained reasons scan procedure detected double the size. By making
> 16 dword writes and comparisons that never happens.
>
> New procedure is also inverted. Instead of writing two different values
> to base address and some offset and then reading both and comparing
> values, simplify this by writing pattern at the base address and then
> search for this pattern at some offset.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 58 +++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)

Tested with H700 devices with both 1GB (RG35XX-H) and 4GB (RG40XX-V) of LPDDR4; reliable detection with over 50 boots combined on both devices. Previously ~1 in 10 boots would mistakenly incorrectly detect RAM size, in particular 2 or 4 GB RAM on the 1GB device.

Tested-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan
