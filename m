Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293EDC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8757A87F41;
	Thu, 23 May 2024 17:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="iWjbPDEa";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtGaM5hh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E8287ED1; Thu, 23 May 2024 17:39:19 +0200 (CEST)
Received: from wfout4-smtp.messagingengine.com
 (wfout4-smtp.messagingengine.com [64.147.123.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39914877AF
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 792E51C001AD;
 Thu, 23 May 2024 11:39:11 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 23 May 2024 11:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716478751;
 x=1716565151; bh=vuV32L97REH+FgP4WQHEW1n3PhvT8qX0u28udyt10d8=; b=
 iWjbPDEa2lyyW4fTXZ1gcgvfgbSS7/bHSEuCoUVmFw1/QHc2PcMRn+NK8ERjWYKi
 DOAQQo3fUAlb8j7Ygy7HT/ddCSzLwjfiaKe831w119bhNU8fe3Y7qsIjezNJjaKd
 E3MczcKRFmYuYcXl63kXSSKqY3oTKtVqdnxmhnlGZafsYJNDnaYki2JdobAmnsR3
 dPpXq/kSTh3KmZUOOXzQFaXgMxA0PHgGsh0oumiT4E9+hgZKMy1xCfwSwPdZemgB
 UTlFJjhRCjj7ijxnmxRlshT+T3lqq/xAMhDUEb0qE1I5ucomwj7EKRJsnFACvPZd
 SIjm3Iv5DmfiDjc6U7Cfww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716478751; x=
 1716565151; bh=vuV32L97REH+FgP4WQHEW1n3PhvT8qX0u28udyt10d8=; b=j
 tGaM5hhFKvgskEW4U7Utc8lSgIUezm5SbqviV1JoncyPgRfu1zJ7HL43Fy7osTBg
 ZShEvKOCwwKGjnKEpsxVK5WEnySTc0BOQ3DVatHYbKhHZ5ZRTmWsvreCSH63/mBS
 O3g+7QrVomQOYGfNToTTwHBJyb5LneY3au8EnjoNLuOCdRYI1NxRz5cyrPw1ONlw
 3xik95WHvJofi04ADlMaeQtw4PmP5KsJQVt696X3jfkSv4FFWLWAYhLGhsEFe485
 fvjxWiRzmKiW/+aEUR6R+crryl4APFh+5P/gbVgLAJ/tGeiLS047CoCtwn9KgRUj
 oxpjZV1uED63QNjfTNqCw==
X-ME-Sender: <xms:HmNPZl_ic7pFJih_tketiltTLbzdpFlh42PTyF1bOTi2JuppPmdTSg>
 <xme:HmNPZpvYQtqwLXDZ9046o1MUoba0hn70v_yNi52AI8N_Y-Qdd-qRsDcrnrfi_ZzXv
 vtJ8nu4Q2FanC2ORWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeeujeduheeltdeffefgfeffhfevgefggefhffeftdeu
 uddvtdekuedvkedvtdfhieenucffohhmrghinhepuhdqsghoohhtrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:HmNPZjDUVQ0YRyAvgR-IYIVYoZsYEagwoFHrbRz0oaABGlrg2l-1yQ>
 <xmx:HmNPZpfkUUsgPRFa76oAQmq3mdrfioNBob9oXBjJni6DKhANWF30lA>
 <xmx:HmNPZqPCtY7ygkuU9_ERfEIw3Lf6BnsuUovqRpnaNkMGp6zqPVrP9A>
 <xmx:HmNPZrntbFknI6xLwstQocSdNg_cNGKhnO-tPAvr03JBoMxGT7SHYg>
 <xmx:H2NPZnoMVwwlcVdar3jVyQqYPQWROeJT-nygQ1C_mW7oCSD6aCOGOlU2>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C190E36A0074; Thu, 23 May 2024 11:39:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
In-Reply-To: <20240523152540.GR2568172@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240523152540.GR2568172@bill-the-cat>
Date: Thu, 23 May 2024 16:38:52 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: "Simon Glass" <sjg@chromium.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] LoongArch initial support
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=884:25=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:
>
>> Hi all,
>>=20
>> Sorry for flooding the mailing list recently, yet another huge RFC se=
ries ahead.
>>=20
>> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, as=
 suggested
>> by=C2=A0Heinrich.
>
> My big feedback here, and it applies to all of your other series as
> well, is to please update CI to make use of and test this. On the Dock=
er
> side, update tools/docker/Dockerfile as needed. For Azure, you can tell
> it to use a different image and then follow the documentation on
> https://docs.u-boot.org/en/latest/develop/ci_testing.html and for GitL=
ab
> you can at least use their "linter" to make sure that your additions
> have the correct syntax. Thanks.

Hi Tom,

Thanks for the feedback, I thought CI is for custodians only :-)

Do you mean I should include azure/gitlab pipeline file to create
pipeline for those new qemu targets?

Thanks

>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
