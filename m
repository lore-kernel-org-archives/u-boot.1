Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48FC27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E9C8882F;
	Wed, 12 Jun 2024 18:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="30beIW+L";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSXBYR5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E5688835; Wed, 12 Jun 2024 18:15:11 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400F0883F5
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 365F11140085;
 Wed, 12 Jun 2024 12:15:08 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 12 Jun 2024 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718208908;
 x=1718295308; bh=VgJGg4e/i28g1OcAHCslacBn7gnoZ0apBeG+TwNex4E=; b=
 30beIW+L5FwyVYWY+hphPdqn2InTxeXsUv+5vjDtT9OBvdGTO3APnrk9POIoQINV
 qqH7cYDr3LymsW+EYUiK1qN8Fivkx80D+i+6Nw1b8WXIdzPQCXLTOqqwxnN1RENV
 7TRE8ENeniRO/ePV4poZ1a4TVCDRBRpuztguFaVf/poE9fXqq81iqxePQGKejdaZ
 WU0S7ACFWimvKqXQjXY1+C2LqS6iU7FMeizbL0o4zGqkkny9hR1gxl72f10qQWYU
 VgIjChBwijPjm9mDX3OWakJv6Xp3yegUPYtI/cswrMJG6gpJyVCxNssRJL+DIInw
 taT/U7bsyaAGzJtxp80t5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718208908; x=
 1718295308; bh=VgJGg4e/i28g1OcAHCslacBn7gnoZ0apBeG+TwNex4E=; b=V
 SXBYR5Dwb/H5j4Oazmvpl+WilW6VDHK5D0rt6WAGa5khxbIQX7YANl5UcNkP9zCh
 JX1w0zY+jmkyWKfiLPQ9/WLUz+6w6k01/xoCEzl74qHThT15obIEOBWJtRs04MxX
 KKnyB4xvyVlrIFtv0uICrJ/02EV8IN4NNPVQhQaJa7adH1PJeX0yk6Z4od+zEUdD
 wFCKUlbmKndm7S1YASAnK45slHycj5Un9t6B0yk0ZCkk0sEwSU1QBuH5fRkLxoF+
 RjwP2JuPDFjhK+8TQjS3qz+ggINtJqMBw2qqywme/3g3jmkgOOV3J+ut8QtDALEy
 vZwqtWneS+IeSsJjgG9Xg==
X-ME-Sender: <xms:i8lpZjLjRxvsNQ7WMtLp2-RWkMQUh-uot3uyQnToLZePlb-BQsLYsQ>
 <xme:i8lpZnLEyEmXGuilsRoQEqhmZaPFKZWUblD03QNyStgjF4cJBQI_e4BgL5e5l3lq_
 6FVYYBEeDfw9aP71i0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:jMlpZrtocrdFUpUoDOn-CcNt2FyUxKNKaQ1tRmbuAunDQFqqtDQwVQ>
 <xmx:jMlpZsYFFuHMwMN_IsTPBb2JyIAVqHZVDkue5SvFFx1ji4bPAk9TxA>
 <xmx:jMlpZqYdXOIu4U-fdv7Q1ktXri3vhJglBESKdqfsX8IJGWfxmZ9TSQ>
 <xmx:jMlpZgBgyu0xVWPv6vaKrQkuX0cCffxgUIaPUlIosDaysBveNiERDg>
 <xmx:jMlpZvN4HNvLLj7ZMfTfwK4P2oUiIUu0tiIx5fx8SqC-urDWJhaqHDNo>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D99BF36A0074; Wed, 12 Jun 2024 12:15:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <894fd87b-ece7-48b6-bf20-2c6621e7224e@app.fastmail.com>
In-Reply-To: <20240612160104.GU68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
 <20240612160104.GU68077@bill-the-cat>
Date: Wed, 12 Jun 2024 17:14:46 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Aaron Williams" <awilliams@marvell.com>
Subject: Re: [PATCH 14/20] CI: GitLab: Split build_world tasks
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=885:01=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Jun 11, 2024 at 10:04:13PM +0100, Jiaxun Yang wrote:
>
>> Current build_world task runs for too long on public gitlab
>> runner.
>>=20
>> Split the job as what we've done to azure pipeline.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++--------------=
----------
>>  1 file changed, 59 insertions(+), 44 deletions(-)
>
> I don't like this. The list in Azure is because of the time limits the=
re
> and in turn we:
> a) Have to tweak it periodically to keep things from running too long
> b) Have to tweak it to ensure that we don't miss some new SoC/etc

Then it will render running CI test on gitlab.com impossible again :-(

Thanks
>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
