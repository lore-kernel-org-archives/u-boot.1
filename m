Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E114188815;
	Wed, 12 Jun 2024 18:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="HD1/EJl6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqFV2Kgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B158881A; Wed, 12 Jun 2024 18:14:00 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812F8883F5
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7DD9713800F9;
 Wed, 12 Jun 2024 12:13:56 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 12 Jun 2024 12:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718208836;
 x=1718295236; bh=qY5tIW/NTdh+WwnECBI5/QXSZBc35p6WN6pN2GH2th0=; b=
 HD1/EJl6yIhEaAsINHvFiWT6u0Lj7qrdpI3RE2tfhYOrKBQMPBDh1rfv34f1vvVa
 om+2km+nHvSFBsMqeoBSmxtJwA+ddz7MUb7lEH9cXyNaXOEBCqk/q2C1akmsBoX5
 g5kQxgvK9xCbHwA/NQeiLWVmH9xW2OHUKFDkLQE9MD23NzGx1bbfNuY/lj9j8nzY
 U7Pn2WpiRuHE70rYMglrB+fcFaW6C52a+XxSbVr24FBJ4igZ34d0jqgPdNzW5Rsm
 Lm4kOtOaFRmZaDWWr3x1/+lv9vGpVGf11xDWuR2glNIp8Rwnkz0ShPEMbEq9tfoU
 LmXEGPDawnhrMZ9raYR7Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718208836; x=
 1718295236; bh=qY5tIW/NTdh+WwnECBI5/QXSZBc35p6WN6pN2GH2th0=; b=e
 qFV2KgrBkoZoM5ox0eqX5tO9hnNBJwEM53+mY8RXOP3+pCeuqvxZCMPn4SDaKViL
 +/ONgkgfqYFrFO0qQGIKk21c37tNhLW5SI+JlG4I5SRHzUJOG3lmItc1vYH5iheV
 ZI2RDmT6ekRiKgeVUbwd0wiXS+I0NKU+FWXD5ZifQrpvV2tCm57DU7waqXQnyV5P
 zFp6n3FMHS72BpSIhYr97EJAkpQbNSthZ8D0zuyKSwuQxLIMdFAqaV8s2y5umH7m
 uaoaxpjlr/4UvKzp0yrLtbRfzmZWY5FlTX8slHJn1QGjhxqGaP02+WCoNZZsKoC6
 bNM5s88tRKtiUV0m9HlhA==
X-ME-Sender: <xms:RMlpZh3mG035rE4X0TLS_gst9nVCnQ-tfiu1tyqDOnkNXI7RAYkWJw>
 <xme:RMlpZoEkUXZMrzDUfNP95KRUN0fYFXFf_pFDZf8pYlUtm_JwoTii7lObasN7X2Umq
 2X6MOJTTM4wtSOmeY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeelleekkedtteekleeffefggeevfffhtdefudeuiefg
 ueeiudevffeludejffdtffenucffohhmrghinhepohiilhgrsghsrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RMlpZh7JpMMT1z3ShhjyS2Ftkv-7o4qFvX7oBDMXyPBRA30CmOCXXw>
 <xmx:RMlpZu0BZgpSonGDQz3RaPzAxAk3Qjf9755XLfLWctYE_JA7YhWucQ>
 <xmx:RMlpZkGE6ZuCyADBRH3An5AFIy6ppmO9Z1K1eVI6796LFbK2edMetg>
 <xmx:RMlpZv9REvpfWJKmXRd8eYqk1V2M0YDOC2ANclotxy-8g3_NVba8Yw>
 <xmx:RMlpZp4Mc5zcrXQ-RoolfQtN4t1V60Cb6GTeOPoPLMKXkYc6P171Hfrp>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0311836A0074; Wed, 12 Jun 2024 12:13:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
In-Reply-To: <20240612160053.GS68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
Date: Wed, 12 Jun 2024 17:13:37 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=885:00=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>  configs/octeon_nic23_defconfig | 1 -
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> This seems similar to:
> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.195329=
8-1-rasmus.villemoes@prevas.dk/
>
> at least for CI. And for outside CI, I'm OK with just having the value
> be changed in the defconfig as needed. We do support using config
> fragments, so keeping such changes locally isn't too hard.

So the default value is a little bit too hard even for some of the actual
hardware.

I think being permissive here can prevent people hit into the problem
only after enabling cyclic on their own board.

Thanks
>
> --=20
> Tom
>
> =E9=99=84=E4=BB=B6:
> * signature.asc

--=20
- Jiaxun
