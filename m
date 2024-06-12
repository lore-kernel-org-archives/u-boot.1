Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D7C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C200B8883F;
	Wed, 12 Jun 2024 18:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="UnX1TrUT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3sHRDxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EC988842; Wed, 12 Jun 2024 18:20:02 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3072888805
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 473E311401EA;
 Wed, 12 Jun 2024 12:19:59 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 12 Jun 2024 12:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718209199;
 x=1718295599; bh=vnymMsY4LxXpS6BamNGVlnpVdjfC+bDsBmwh4kgp+28=; b=
 UnX1TrUT+cwLo0Wrx3GN46NKbmasxy/z0aGZnxlrrDEXbqkL1Ocn9AphPhR5F6rz
 QZY7UG59tN4cLTHYDvme5R8hmqq5gCMK4i7+kbQK2sPhVpTTbF5ma9CI0r4G/fu1
 1ZfY5zsw7QoeQnpyAXcGe86oc2Js0BYlRHQ75kwf0USk+Zf4Ub3Axa8iJbOIWVN0
 00xp/8yMQ96obb+ew3zjPp7QyVUfuzcrDsF8rGc9KoFeeDGgxjgA+T6vIJ5LSXQt
 CdD3OvErrBdxzAJPNwkXrSm0l1nFIG88GTXoD9iM4VgurkSricAIpOOF5o6sRRKU
 4BpVCvAyez9SlvF+600H+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718209199; x=
 1718295599; bh=vnymMsY4LxXpS6BamNGVlnpVdjfC+bDsBmwh4kgp+28=; b=b
 3sHRDxlEY6I3iVUZLVh+3xrXPuqf+Z+U8ZXnVBnWZ772g9PnZZmgwmNpPEn9ovdC
 TVwH8f8if3g6+UOWOwQjf+W6DWk8a6HDCVap17ffFjHgPY1bTgPaLdz6ovk/3fg3
 /IcSOIoVI6AQrT5VzcVcz+26eJ5LzSTVdnqB3e8a3VJbi6NR12RhioETCQSmIdRV
 T5gS14Yl042mPZLwnVeebCiwFdNJSJPLneRODU84EYze9qqtuB/uXGyhXX9SFtbZ
 f79vOqtppXH+W9y6eFb5DtvH9LtTvrclBZvcDL1yglsPSmTbVWQzHbBFepWOsz49
 uJ30B32MoNCxm2wnS6t9g==
X-ME-Sender: <xms:r8ppZj6cxR-VozFyhQCoXBuh8KLD5VCWfKStdWqHQphuBBqGKJ8BLA>
 <xme:r8ppZo5WoSbec65rhx7eGfa6T_Runn4BxEfgSHaUdwBk6Zf2sKWRsVHZ6yFJ3OIZB
 uqxFxDksZq6iTKSQNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:r8ppZqfGvUydnxpjUMZQXnjyir3cFXk2n95Jm4SrFT5uLBm9ZqX1Wg>
 <xmx:r8ppZkILH2bTjufYtMqcl3o4YSthQi8OKyTrI53zDgk3eCfj2XHhTA>
 <xmx:r8ppZnLbcDhI6UM9ZW-MaB-ndCUh8wCsO62mER95zNgCNC_2e7swUg>
 <xmx:r8ppZtx3NBda_kerd8zHt6eAdbD-QDaJPIMZICPfqd6Ck3IJrTFApg>
 <xmx:r8ppZv-M6lPDwcu9TK07SOAYlZzOEoiBw0w7vYgyd2-r7lTRwRElD5PB>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EEA7A36A0074; Wed, 12 Jun 2024 12:19:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <b8076240-8b63-4921-9cbd-ec74ed14c127@app.fastmail.com>
In-Reply-To: <20240612160109.GV68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-16-51472eb70357@flygoat.com>
 <20240612160109.GV68077@bill-the-cat>
Date: Wed, 12 Jun 2024 17:19:38 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Aaron Williams" <awilliams@marvell.com>
Subject: Re: [PATCH 16/20] CI: Dockerfile: Bump various software version
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
=8D=885:02=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -2,7 +2,7 @@
>>  # This Dockerfile is used to build an image containing basic stuff t=
o be used
>>  # to build U-Boot and run our test suites.
>> =20
>> -FROM ubuntu:jammy-20240227
>> +FROM ubuntu:noble
>>  MAINTAINER Tom Rini <trini@konsulko.com>
>>  LABEL Description=3D" This image is for building U-Boot inside a con=
tainer"
>> =20
>
> For reproducibility I keep us on date-tags and not just the raw
> release tag/latest. Also, I'm not yet ready to move us past Jammy
> without a big reason. Once 24.04.1 comes out, perhaps. So it's good to
> know at least this wasn't too much work to move forward. Also, we shou=
ld
> keep the bumping of various tools to their own commit, each.

Ok, I'll add tag back.

My purpose to move CI to noble is to test against all new pieces of soft=
ware.
I was hit by those issues when I was trying to run tests locally with my=
 ArchLinux
PC, so I decided to fix them and bump CI to ensure we don't introduce mo=
re in future.

I think as we can pass all CI runs it's good to move forward :-)

Thanks
>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
