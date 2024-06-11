Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B30C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6164A8869A;
	Tue, 11 Jun 2024 15:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BeXznDuU";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImyMhHxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091D58869E; Tue, 11 Jun 2024 15:30:01 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6471B88660
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 389EA1140116;
 Tue, 11 Jun 2024 09:29:57 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 11 Jun 2024 09:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718112597;
 x=1718198997; bh=NuUqVyRrcoAmamEvKvW503ee9mHGlkkmRKf3zXNieho=; b=
 BeXznDuUzrOAF/+MgCJc9oX8qQPXbyNktGj1PicHCmS3Gucj7poJ0NgieUOxBXGN
 QkFnMSwQ8PWPJzgAJwjZ3rg2O+Rjgu5Wn0udKB7jDBYM5my9SOKgMYabUBvvSi6N
 FPDxa54BVHsALN9/zb4A32RjQhRPCPBt8rUsz6p/25m6IqwSXML4msNDcjMdB/2Q
 GO4ahUhL4LrtssWixek+ttebr3udIFOYgUHRHMJ2oHoXW4iGmvB6scfjs0oAylbf
 q70x64Zv13hMZqQmVgISu99/abt9AeRQAsDS+99cmfx0SLptPLD54G0SxtNTC4nK
 d3wreXQb1O5zB/JiicdUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718112597; x=
 1718198997; bh=NuUqVyRrcoAmamEvKvW503ee9mHGlkkmRKf3zXNieho=; b=I
 myMhHxusMDLWX09sLRTBKu6fFaenrTzYj8bNgEl1NRSA3q4jpIccxU0Eqe3HqI5W
 hycIEt2K067ttTmL2PqjWTEDl4gfjFmVwkf0s66HIKNAFP3txDiFYJdOJ/TIkwPS
 zx1dRG4P64fXXNv29BXUURf2CP4q9gtHQHpZqaeoIETGq8kxcbTq8IbbuBIxYIzr
 e0WW/F862UAv3wD/GBmb2LuTQKDmvEQxcc7Co5i+FpdGCRFfUB30w3dKQXWD7Q2J
 LqD3sjpk3Eg4TcbOFhIG5Wgblz4tKPXWBrEl3vjmXQuURjllrbuVFb6v+Zw4Libb
 9kB7SK5LtRdlquEmulzMg==
X-ME-Sender: <xms:VVFoZkj90GY365LhjOezorw--RwY-W5xCofRPJnTU_V8gTLCF12CXA>
 <xme:VVFoZtCj4MDW-OJb_KYKRCNdJya_zya-Yi5v7wXgQg49_mE_xh8Cab4rWIEQpnzFr
 RlAyxPxMC1ATJsIo2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgieefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:VVFoZsH38k3ZujdRNq2AOuQqaymdHr3EjUDFoq_QiR5TaH3-a4JnyQ>
 <xmx:VVFoZlRP2oNjV0_hhWNLg_PRZgD15PZOe6HgesjorBvongCKvx0vyg>
 <xmx:VVFoZhwD7XxB6_nTmLt7Wyi3WjlHQ8hEROFzFr7fQSeT6RDwol17dQ>
 <xmx:VVFoZj4XbMhxv68jbZ75vfjnUWm5_l4nm-Uotcpo9HxR25bz297OEQ>
 <xmx:VVFoZjurCJeuCefDRYt_Q2aF66QtDzX0QOpSppCl0Wb04Ed72P0gJuyE>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D94E336A0074; Tue, 11 Jun 2024 09:29:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <43b029fc-2910-455c-93d7-6555c65bf189@app.fastmail.com>
In-Reply-To: <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
 <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
Date: Tue, 11 Jun 2024 14:29:38 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 03/16] image: Take entry point as an output of setup_booti
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
=8D=882:02=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> On 22.05.24 17:34, Jiaxun Yang wrote:
>> For LoongArch the start of the image is not the entry
>> point to the image.
>
> Looking at arch/loongarch/kernel/head.S there seem to be two cases:
>
> * The kernel has an EFI stub (CONFIG_EFI_STUB=3Dy).
>    The legacy physical entry point is available at offset 0x08 of the
> header.
> * The kernel has no EFI stub.
>    The kernel entry point matches the start of the image.
>
> Where do you differentiate between the cases?

Hi Heinrich,

In case there is no EFI stub LoongArch would use elf format vmlinux, the=
re
is no real "raw" image for us.

bootelf can't be used at the moment as it doesn't setup FDT and other en=
vironments
properly.

I'm planning to implement a bootlinuxelf command for this case, as MIPS,=
 LoongArch,
xtensa are all using ELF as default kernel image format.

Thanks
- Jiaxun
>
[...]

--=20
- Jiaxun
