Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B792C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B40886CF;
	Tue, 11 Jun 2024 15:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="MS8pmGA1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DhEVuVVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D1E886C3; Tue, 11 Jun 2024 15:48:17 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E372288685
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id DD3C013801AA;
 Tue, 11 Jun 2024 09:48:13 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 11 Jun 2024 09:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718113693;
 x=1718200093; bh=jIMlGXFCDIh4ujoW3tbJ/Ou+1G9YcHFeqS/iNY+f5xs=; b=
 MS8pmGA1w5m4yZPIzQmccOO6PQ9H9T88twXs0RLNhxk57XpkFpgCbB9OLYDvwjcs
 CxEH5193Wn7eQzjN+CkkpnyT5z9H4GFszIIzlTrhVmV9R1ZwRLhx1mtGCUnDBjFd
 QL1Vae8bail6Q8j7MoMfsneBVYP2kFsX010wTriAd/XJ571UECFDIgc5CcSzu17O
 S6yJOqstZDhdUGH/qvxfwEDOqV1wceKWYmRQHKwhFNQDEKNgHvWtoW8QMWTeIVha
 otXyKIxcJiJs2Tc3+jJi4d5v8DupA2al54ntX3CTt/e+yI2d9xHGYk1ARCSxYm3o
 Htv+4Zyu+c7NtXueIXHqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718113693; x=
 1718200093; bh=jIMlGXFCDIh4ujoW3tbJ/Ou+1G9YcHFeqS/iNY+f5xs=; b=D
 hEVuVVikVLMIOq2S+DMaAUBFjrG48UO+5skSJBfRCV6zjs38j7DqopU8dqbwae6n
 4FKH7zgWJuE53O0OyrSRXxkZM1D1DHg+KnFxQQvFGAjOdbZ9Q5+MCLp4R4RoOnNc
 fXxGFhSLso7iV9km72DfdMbRIYJKemeZtZuqBZEZ0uBD6rSsbGoVErfD3qm5H133
 jGr+Ro+mKqDFxWOsJmS6BEwcInVCqyE2XsqtqMB348zzyjhetJlJFeYMPyDcBmDv
 +2Yx7aqFRS5U/OdUxPHNmcOADW7EKxBUaMmyRjSHwLkwVvpPLw0456j7L60DaFe0
 jN3gYK572Y2SBnNwN4lpw==
X-ME-Sender: <xms:nVVoZiWD8yO5vgeadUN1H-XebjZAFNrCwCol6wXeq3ibjXqLnk9Ddg>
 <xme:nVVoZukwlFo924Zr0VeYWbEonsAPDNkdmDBNTXRO4Yy1tpSIxKULxTsdgMn-CxpXp
 CfPDTrU6LWzlYJGcPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nVVoZmaBNtFsLxD-rdDiz19XwCaaw2DnkLXw00_W651kcFeO-kDdbg>
 <xmx:nVVoZpUoYg-eqzCL0SrR-V_OG3SRmMdE_y9seWyJ7Jm1J8Y9eilqgg>
 <xmx:nVVoZsnp4JjqBnIOHx7Tv3mnL7GRS27SL0KyfB4juUye4aiAlsNCtg>
 <xmx:nVVoZue8AH4bnhhn1sT4G6k-IMRZI7fXncHIblXJ2EbNxAJygTUpzw>
 <xmx:nVVoZtAT5MpMf6k2z_idTHlkjXpy4vwW2W06IWdZn1n06jJw2a0RIu6t>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9342036A0075; Tue, 11 Jun 2024 09:48:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <5bd109ff-73ef-4bda-8b5b-2ab583c064d8@app.fastmail.com>
In-Reply-To: <b723aa8e-1d29-4904-953d-160caf097136@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
 <b723aa8e-1d29-4904-953d-160caf097136@gmx.de>
Date: Tue, 11 Jun 2024 14:47:49 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 01/16] lib: fdtdec: Handle multiple memory nodes
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=881:26=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
Hi Heinrich,

Thanks for your comments, will fix most of them in next reversion.

[...]
>> -		gd->bd->bi_dram[bank].start =3D (phys_addr_t)res.start;
>
> The conversion is superfluous.

This is necessary as phys_addr_t can be unsigned long or unsigned long l=
ong.

>
[...]
>> +	__maybe_unused const char *final_name;
>> +	__maybe_unused int final_reg;
>
> '__maybe_unused' is superfluous.

This is necessary as when LOG_DEBUG is disabled these two variables won't
be referenced. Compilers would complain about it.

>
>>
>>   	gd->ram_base =3D (unsigned long)~0;
>
> gd->ram_base =3D ULONG_MAX;
>
>>
[...]

Thanks
--=20
- Jiaxun
