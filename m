Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6562C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D198C8813A;
	Wed, 15 May 2024 02:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="WT+suhHb";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IitBgK2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CFD88179; Wed, 15 May 2024 02:12:40 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CF68813A
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 02:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 95B6E1381494;
 Tue, 14 May 2024 20:12:36 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 14 May 2024 20:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715731956;
 x=1715818356; bh=J78KLYtcaiOuFV+MmGvA67kMEMKsh/+edugWtG71M0o=; b=
 WT+suhHb+nbl7QyKrVzzYTqDx7Rgf1DwyKi4BxdcKX+hZUVDznxWLsRefoVtQ9gX
 fQNm9U7dZY3OULHON++uB5jWdrzp1/axgZJCMAtty0A15xsNe1VuTTcZu0lDhvTC
 GD6x5v11IFz6YqfzVFMUHpuY5MlLWWx+xTsNxoZoREVuiIT3ggUwvjX+/LKGCfM5
 RKcTQ+tuhTWvelM2tmeRaEBRnUItuf0mmKLnGrK7ZFh8tTDUYyLoP4EFBI6AXZJh
 gqbMx0eEndDiJEUiZoh7OhkapNElLPOwvqDy7XAc2n7D6Ih5umJRVagm4TyeAR90
 sFXn346FLHCejXbgh/ZOEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715731956; x=
 1715818356; bh=J78KLYtcaiOuFV+MmGvA67kMEMKsh/+edugWtG71M0o=; b=I
 itBgK2uWxv8MEF8DbpdhAxfBxj43eRcOdKug4zTRqmvDuYLd2POlKyvbpI8zSvUb
 i0LQko5N1sQqke1hSu99GJoBDVS6hjX2PZxAorIHVYGGtLm2dQA9PYKSYtn0J19Y
 8Dh23v4RbyQjhb2X17vuj56x7CGZy6fyf6hPentT2U59VMS8dnMlMUmHJLC5zt8B
 /nlIhML7MKhiVanIHjGOotI46TNfh5VIOleFgD6eW0MD342gO3znuPeTgx9kdbBo
 pg3AUGMQiivv2/n0icxIhqH2rOfVMaXENG5Q8+BCGBq11fIKWWup/Of5TeqVr9ht
 C/AXe7eh+bYASFRiBNdig==
X-ME-Sender: <xms:9P1DZoobj2HtTxVRcEjeVfVGJLdnGHDEwWLDUR4-31sZPfRgyGCSsA>
 <xme:9P1DZurR2nMGJs46awtiH9fi-3ZVwQsp72Vn2cHO5OOzYQgG_XbBJKgvJkMvfbqYz
 hgvvoapSi3CE8cLjEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:9P1DZtP021MsaCapRsjT9ZuQU1tZNN_7_6_-PLlup35OQs7UXMUhSQ>
 <xmx:9P1DZv47BET3_iMBmHmd23NOlm5T2TN4A_a8gWbGd0KArEYkHtNaHg>
 <xmx:9P1DZn6DH5K0P8XvfpzkU5q1uKJ0VeJN6PJx-e3nFP6zFzH6olg3wg>
 <xmx:9P1DZvjMnIQhg-ptde4XBLE5VtcvtnCBkQhnf1WMx36BF-Vdlj1JNQ>
 <xmx:9P1DZkFYuNmHe6Mc5Tht_tQtTnv3Odx2GJ-5bR9mQvWRPMk3AiCC4b0B>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0B14936A0074; Tue, 14 May 2024 20:12:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <c2881dc8-153b-4233-b123-a89cd596c4ec@app.fastmail.com>
In-Reply-To: <6bbce6d6-35a2-49f6-b9a1-36dbebfdb9e3@kwiboo.se>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-9-fac96938417e@flygoat.com>
 <6bbce6d6-35a2-49f6-b9a1-36dbebfdb9e3@kwiboo.se>
Date: Wed, 15 May 2024 01:12:15 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Jonas Karlman" <jonas@kwiboo.se>
Cc: "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Simon Glass" <sjg@chromium.org>, "Lukasz Majewski" <lukma@denx.de>,
 "Sean Anderson" <seanga2@gmail.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 09/13] syscon: Probe device first in syscon_get_regmap
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8814=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=883:50=EF=BC=8CJonas Karlman=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
[...]
>> +		return ERR_PTR(ret);
>
> Please explain in more details what the issue this is trying to solve.
>
> Typically syscon_get_regmap() is called on a udevice returned from a
> uclass_get_device call, and that should trigger a probe for the device
> and its parents.
>
> Adding device_probe() here possible just hides an issue that exists
> somewhere else. In what instance are you ending up with a call to
> this function with a udevice that has not been probed?

Hi Jonas,

Thanks for the reply, my problem is in [PATCH 10/13] I'm using dev->pare=
nt
directly to get parent device and then use that pointer to access
syscon_get_regmap.

There is no chance to invoke uclass_get_device_* as what we need is just
the parent device.

I can think of two solution without touching syscon code here.

First would be performing uclass_get_device_by_ofnode against parent's
ofnode, which seems a little bit overkilling.

Second would be trigger probing in dev_get_parent.

Thanks
- Jiaxun

>
> Also, please add a new test to test/dm/regmap.c if this solves a real
> issue.
>
> Regards,
> Jonas
>
>>  	priv =3D dev_get_uclass_priv(dev);
>>  	return priv->regmap;
>>  }
>>

--=20
- Jiaxun
