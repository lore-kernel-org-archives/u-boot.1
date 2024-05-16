Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DFC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E6780E9A;
	Thu, 16 May 2024 13:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="GdiMO55b";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+1HzHcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5162E88297; Thu, 16 May 2024 13:59:12 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF1187ABC
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 1CA1A13800E9;
 Thu, 16 May 2024 07:59:09 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 07:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715860749;
 x=1715947149; bh=91aA5KveZ47WXqEQZTIRg7SiNuZ9VvSHpGDd9QsBMyo=; b=
 GdiMO55bCCBxBAums81TcgYbwmiDE/q4DPG8Am1mATSCgi5xl33YYDztCLwVsnhK
 2SJRCKTKBeb2DpR+D102Xb8is03sE2XLnzLDhOAEh6KbjSC7Z4W52b28IeXak0KE
 Q9B57TLK7+LGFgxtXt2X8Gpz5ym/u79baTjKr1k+QPDIT/eophJBd4z7bkuAF7aA
 ujiwLDVWsNFfAf61eRxs2197532aMyV4wywo/aXu9lqKy8LQOWlt0nTUqROwCnfG
 CdMQap66DZqN0YZzd5hbmuGNZBCOg02ukj1PXBxPnHfiWN2g/Y9MzOAa/PnuthN+
 tnqw8TllQd+1qolugAmMbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715860749; x=
 1715947149; bh=91aA5KveZ47WXqEQZTIRg7SiNuZ9VvSHpGDd9QsBMyo=; b=S
 +1HzHcZmwsIj0YUqhQHXknUq65AH/m+nUiDqSG8PXmEsW3ZrPXZZJMa69y7ulOEI
 xlTFUETpHioAJMefio5qI8s0kACd8oxlVeA2PzBeuxBa8fwNVoB4B8/gAU4mRJeV
 kRZ6mafop0xR5aNkxetPXpfOJnRPgEJATAJbQd3Cl9UUV0Ix5IRMTW801ixebidZ
 D9WqprxHG8rSSAtGCh8UnB8dRsCJnipXARXMzgZ/Qjxyhro7M9PZbQa3W11LeED2
 J4wfmhKO9w8d7U47NhZe9gcavjm/jlWsBRJRX7qyGH3fqUr/fwi6tU6guAZa9Sgx
 HF0fzm+0wOmA5XIoFKU4A==
X-ME-Sender: <xms:DPVFZig0Af6QVa-3zVRkWnFZyIM8lA-SLgJ2LZ63PfnDYNp3bTZGbQ>
 <xme:DPVFZjBBNUhJ8-aSoJO1BV-QBIqNxdfO7BBv9YDmteIvw_Eof-hEZ6gyN4pOTqJ7K
 4FoTxeC8O05sbnw-SM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DPVFZqE53kb0uoUUOP6Frul7EdrRBfq-ck3bl5Vgx7wTHwV-BWGNkw>
 <xmx:DPVFZrSbtNeedDqj7XhbhqpOJiMKLOGRkJizcdvUdv0GpG_5MN9CoA>
 <xmx:DPVFZvzH_flanulgObeZKz7CkNjL0w6Yl2bSFvSeQx4ftxLuz3ku0A>
 <xmx:DPVFZp4q8deZokCKalkSmqmtB5epgeHj40r1smtBOt_m4dbzhpPWpQ>
 <xmx:DfVFZmnMgm8Q0IpEnxfBpJS4WQHyr8WT1AvdZn3pBLIYzFJnmhrd1isu>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C9F5536A0074; Thu, 16 May 2024 07:59:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <0d2fd774-7f63-4b3b-abea-6dda6a9159cd@app.fastmail.com>
In-Reply-To: <CAFA6WYPapa8PUqOQ-wJRkD4bOfX+2eBCk_5voamQB-XbAhhBcg@mail.gmail.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-12-fac96938417e@flygoat.com>
 <CAFA6WYPapa8PUqOQ-wJRkD4bOfX+2eBCk_5voamQB-XbAhhBcg@mail.gmail.com>
Date: Thu, 16 May 2024 12:58:50 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Sumit Garg" <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, "Michal Simek" <michal.simek@amd.com>,
 "Tom Rini" <trini@konsulko.com>,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Simon Glass" <sjg@chromium.org>, "Lukasz Majewski" <lukma@denx.de>,
 "Sean Anderson" <seanga2@gmail.com>
Subject: Re: [PATCH 12/13] MIPS: boston: Migrate to OF_UPSTREAM
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8814=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=886:45=EF=BC=8CSumit Garg=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
[...]
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +&plat_regs {
>> +       compatible =3D "img,boston-platform-regs", "syscon", "simple-=
mfd";
>> +       bootph-all;
>> +};
>> +
>> +&clk_boston {
>> +       bootph-all;
>> +};
>
> You can try to push these overrides to upstream DTS as well, so you
> won't have to maintain them in U-Boot.

Hi Sumit,

Thanks for your comments! For the compatible override, I already sent
patch to upstream. However, I have a question, Can we really do bootph-a=
ll
in linux upstream?

I don't think it's documented in upstream dt bindings.

Thanks
>
> -Sumit
>
[...]

--=20
- Jiaxun
