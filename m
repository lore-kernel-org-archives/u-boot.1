Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95888C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E97388354;
	Tue, 18 Jun 2024 16:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="UaW8/k5j";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcNm5J6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F936883F6; Tue, 18 Jun 2024 16:01:17 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569F38839F
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 282F21C0007D;
 Tue, 18 Jun 2024 10:01:11 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 18 Jun 2024 10:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718719270;
 x=1718805670; bh=g30G/sepot5wzxB+opzHD1oJS3nktSVZ6tIprfkRIuo=; b=
 UaW8/k5jKwaYYK8bnvjBWvEddwxQlwFETR6mtagdmetqUSIYRHarFBiVI//fHNXd
 lzXgbFR5ek46RRnbCK/XkuYEfrcsBOXTyGZ0/YEY2t+ITsuwvW0AbTPb1Mo4oo0Q
 T9rii7c+9QISnfNMWLgQ2iC37EEpFvXRD9g/ErD+FsX5uCrWbOWpx7KpyACi3KJP
 aWgKGf7AnYtsUUvngi4z+z2YgbXInMIhePob7WX3gicUPiQSmicjeCmSMJZVUv3C
 4xRQHj/DVZqiLCp6TgBTsD1YUdMSRRyWyjn2Xf+jA+AR4K/lMNehdygiimyk18ll
 oPgAMRkJzwbQyZO3W6SI6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718719270; x=
 1718805670; bh=g30G/sepot5wzxB+opzHD1oJS3nktSVZ6tIprfkRIuo=; b=J
 cNm5J6sBCdD7u5M6i80k6ziAyBwNdhewtWr//XrfGu7UHaIWafP8J0b8s8oq7tuR
 gidfei+V06z2hnxEFgLcApB89ps7M15ZabuF8F++tomRb2EJ/9jznqU+SpnkIqKZ
 4pTCDv2a8/QDJOLy5coJ1J91tECMVnX8rN6RC7aROCi2lRFq3+kueEAVhDpdLCoF
 VCwTLNdDcmkuNtFMUQWIQ8mSJTNIRiZLipgUN8JMVOzdn75Wj4V7KZPxiifOzEyX
 QFp69x4EAlcSm6gKRlFIhVxZPz46Xb86S6X24DTrLI8qFb8YkCgtddxFE00Y5QfY
 rPIpMpcZODftNJG2vxJew==
X-ME-Sender: <xms:JpNxZnpRJb9w60pP0hzTcABiQaDYbhDXS6Yren_w4CPuCtdKC52GzA>
 <xme:JpNxZhpphRrIdhM4Du8oa8WIeSTJtpNSnlNAb88w1a_cg-QWy5z8V2jVcQAVhpveJ
 HcbEWcigunC8sNJxig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeelleekkedtteekleeffefggeevfffhtdefudeuiefg
 ueeiudevffeludejffdtffenucffohhmrghinhepohiilhgrsghsrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:JpNxZkN0k47Vy0tXcDNKZkMQPE5Od4CUU4Q4B4k5AD4hijWqhy-siA>
 <xmx:JpNxZq4e5LsQ3xt2rNzIUzPeM-wqqKv0dj6kdckzxJvSGgPh0BDWJQ>
 <xmx:JpNxZm4oXVyat62dRPrTFvXKZC07bwOHbyL8HML_BMulpQiZ6MR09g>
 <xmx:JpNxZiinSzAanjOTNbn_8ELfAUTn0b6mBJwCDMiDhSSt65JaCTk7PQ>
 <xmx:JpNxZtZt4xgFx28--F_IxrT6nP2bivOzA0nKdVChALuYvP7rSgEvd2qD>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 534ED36A0074; Tue, 18 Jun 2024 10:01:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
In-Reply-To: <20240617232904.GL68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
Date: Tue, 18 Jun 2024 15:00:50 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>, "Stefan Roese" <sr@denx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Aaron Williams" <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8818=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8812:29=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> Acked-by: Stefan Roese <sr@denx.de>
>
> Can we please get either this, or
> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.195329=
8-1-rasmus.villemoes@prevas.dk/
> merged for master? The number of false negatives in CI due to this is
> big issue for getting more contributors to use CI. Thanks.

It seems like CYCLIC doesn't have it's own custodian tree.
How are we going to handle it in this case?

Thanks
- Jiaxun

>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
