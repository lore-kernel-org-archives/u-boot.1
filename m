Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3269AC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 22:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E0E8857D;
	Sat, 18 May 2024 00:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="X+qscpCr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rav29bbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496BA885DC; Sat, 18 May 2024 00:14:54 +0200 (CEST)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5275F8856C
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 00:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7B02F13814FA;
 Fri, 17 May 2024 18:14:51 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 17 May 2024 18:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715984091;
 x=1716070491; bh=nKdFcULqh6VrAT+JJGIgf2cDJWH/pFZ5B6cBX2DEj4Y=; b=
 X+qscpCrDKGiBbDaGWkmRRtl3oEBg+Nh6b3fc4cZ0IzF7Hz51Cq3hwBjdL0ng5+8
 gYCIgdc7j+iZ220SiIV61JL1aP3VX7oXfuJvzCG5ul88/bN5THaeC29wy4hHfJ4z
 wSYnCyEOYZxlqEe/x71BB8IjEoqgYq6QPeBfprHdaUqYnJshBBckRwZi9p55RJWd
 NkaALrHtUm//Td6mYpzMp5ZeX3Nzei87pjAtnG/TXBs1qlUbGypWXe1+esijGhLk
 /NOcD+w/6EFeZ8mzaxTNqUZ0mnw/4+16/6QW6yCLnd7liDp4cDAbw6ZRxZdU9AlZ
 FCAybVijsNJr3ZRT+MK+8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715984091; x=
 1716070491; bh=nKdFcULqh6VrAT+JJGIgf2cDJWH/pFZ5B6cBX2DEj4Y=; b=R
 av29bbDtYlhxj2u8PFnQj0djlVdcWFP+eE/v0rAROFbwjDZswm0NAIupyLXOq100
 fFnuhi/w/olD1JZ9xtOwvBI5SxaWLzIrTMfjicZ5Pvyk4qeBQNtP+pDadZ9YLegV
 veGMNtiW0Q56R+AGZAEAVuB398htIFvJZiGxVd5nfxeTyGzzcvtxUvmGJZXrWH8p
 HM7e90JaE+WCHWiOfX0SVAXiSQhk8mpxF2xA5H7ZRQlIRvC2wnxoKlliwz3rqsw6
 nw0kLkNDIFuw42Pq8e1IU5q0qHHFNhuPp6W3O6w5rmF4fdXw8x4mOEIsfu5Ahw1x
 ONYNW0aYIM6tvVAyMGrSw==
X-ME-Sender: <xms:29ZHZoDncqj6iYEw6ACyOcSqKB6WPOddt-wofX071vW-4bumxUvTTw>
 <xme:29ZHZqit36aMHqpT5zysVs83GP9PqNoc18R9EXE3TnrUH7qMaazz4XvaLnPIChoWT
 1kbSAiypVoiPAKOlGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:29ZHZrk4gsHjhsujlCN-X4YfcjzGXHCvt-w5zOzQP_NnPASQsQtJdQ>
 <xmx:29ZHZuzI12Btx0vibo8aS2mLf7Twgg6mFNp8rysN7aQ0iY0NmIwPYg>
 <xmx:29ZHZtRYODg9R99W12bDY6HiGE9UECn3D-szFWsIRMnwAMJ3nOqBpQ>
 <xmx:29ZHZpbmIsxvjztdBmEBhSxAtKwU5yKLyNaH4U_kg8cQMNP23piEPw>
 <xmx:29ZHZrOafZBJTmIVfhPEyZK2K4x9fsUQytvBAgaslBmJ5Zj0RLKT5keC>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2FD4036A0074; Fri, 17 May 2024 18:14:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <db8b728a-e3ea-44ab-9cf0-c873dbc488d2@app.fastmail.com>
In-Reply-To: <2283C936-E570-4015-92F2-06433E3FD506@gmx.de>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-1-79096e3ca3b3@flygoat.com>
 <2283C936-E570-4015-92F2-06433E3FD506@gmx.de>
Date: Fri, 17 May 2024 23:14:22 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/7] MIPS: Implement setjmp
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=8810:11=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
> As the jumpbuffer is only used inside U-Boot we should be able to use=20
> the same register sequence independant of the bitness.

Hi Heinrich,

I chose to use ABI's stack frame because GDB requires it to perform prop=
er
unwinding and it helped debugging a lot.

But I'm fine with unifying them if you think it's necessary, what's your=
 opinion?

Thanks
- Jiaxun

>
> Best regards
>
> Heinrich
>
--=20
- Jiaxun
