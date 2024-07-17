Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC88C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA1F88A5D;
	Wed, 17 Jul 2024 18:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="fZxWm7La";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="STXwC+El";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C869588A68; Wed, 17 Jul 2024 18:44:30 +0200 (CEST)
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F225B87E2E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 18:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id E7EBB11400E1;
 Wed, 17 Jul 2024 12:44:26 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute8.internal (MEProxy); Wed, 17 Jul 2024 12:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721234666;
 x=1721321066; bh=5chi9njm4vXhT0rbos1b8FZEglGoNX1lxS4vJz6+rbQ=; b=
 fZxWm7LaduLXsS0DV+SF7OmxMYRsko260XxiN0Dgz+30VxvLX0RyjWryNAgTerxp
 rcPAewaSBfIV9sgnrVY+GKno8KjvcgCNa3PYzhynJyJ0tLdTRTbJzMXip5jacUHq
 5iSaUHXRV4NC7IhD/yU7HFIcLTR5yzhrn7EKXXEU2zMLOS0OdgdbM6b5EM9kWvGX
 sVval4+FvnybTKWs0roAHCAMhydjEpWDn7MXgCySD0+RlrNYyxK0YdjhR9m5z3RB
 +++Mj4wiL/aNZ7l8h34maRos1SWOWPEZFgFoeGMjg5cJNPSsiVsTseUhVuTWZMqp
 57tK7tVXMjCbJzh+aVxgRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721234666; x=
 1721321066; bh=5chi9njm4vXhT0rbos1b8FZEglGoNX1lxS4vJz6+rbQ=; b=S
 TXwC+El5kRZSosalp4+8N+NFos+xgeIDzL+JLSSBbAvljHwkVwdet8qM4ablojgN
 9idTzJAY11J1AV4IzntHAQmJsBVPL9nD2GYcNIEkLuLKEWYVgizgiEejA64EVM6j
 k9I+WFEjBAcsSsPcDW3CHkV83ywVKhov4XuUKBgxAxz7m8Q/dw5NgnITsLVIl84q
 vn21hOTejgopnciJiYgHgvLiAhncJtrihRGM2rYD4sEnWOmviBgtORZF2mpBAvhh
 QIDDYb6wkN9UwzxrimXGwT2aVQaQa/1RbNCz90CCFEEiRCS/3CLHRckd/uvKGtUa
 acJyHIW3O/Z840/GMcqcQ==
X-ME-Sender: <xms:6fSXZsMLZcgMa_IizP66XGpj1zTen-PSiDPjP__Q5-45yw8XIdG02A>
 <xme:6fSXZi9QUVU0TNR7r3-D771rlak5zJwiGuKeNqh0lGiD3u7snm6cScSxl5fVxGv6T
 -5IgqIQXjQ_NeVzIww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeejgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepueejudehledtfeefgfeffffhveeggfeghffffedtuedu
 vddtkeeuvdekvddthfeinecuffhomhgrihhnpehuqdgsohhothdrohhrghenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6fSXZjS2XQYkwTG2Z2LIx2ZNaxlDFXcWdRoa9oqAsVZ2oRmnN_No_g>
 <xmx:6fSXZku4bDy0Z62u5hW9bXNVYUhNcbtAwFySMnqlO8-iSlDlmFDWaA>
 <xmx:6fSXZkeeRZM6Rh5wcLMLjFMwHE4W9JdpOU0CEvI8sWXcbWdn9k9BJQ>
 <xmx:6fSXZo3KMj0oRwnerFPlguKqL-O3cgmGcJeVX9b8MrauDpaJ-5prxQ>
 <xmx:6vSXZlqNVe9l7KHf9AFFyu9l5SUF96Ww45FZ1KOYxfEtYZ9gK4ULvA1l>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7E99736A0075; Wed, 17 Jul 2024 12:44:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <f7dca457-d947-4fe4-972d-2ce388d4311e@app.fastmail.com>
In-Reply-To: <9caf5b15-971f-43e6-be8a-c6a2f4bd0bb1@cherry.de>
References: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
 <9caf5b15-971f-43e6-be8a-c6a2f4bd0bb1@cherry.de>
Date: Thu, 18 Jul 2024 00:44:03 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] b4-config: configure `b4` for U-Boot
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8817=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=8811:26=EF=BC=8CQuentin Schulz=E5=86=99=E9=81=93=EF=BC=9A
> Hi Juaxun,
>
> On 7/17/24 5:12 PM, Jiaxun Yang wrote:
>> `b4` is a commandline tool to make patch-based development easier[1]
>>=20
>> Provide a .b4-config file to match U-Boot's patch preference so it wi=
ll
>> be easier for people to use b4 with U-Boot development.
>>=20
>
> I've been using b4 with the default settings for a few months already=20
> (i.e. without arguments, without .b4-config), is there something=20
> specific that made you want to override the default values?
Hi Quentin,

As per U-Boot's contributing guide [1], it is preferred to send patches =
to
u-boot@lists.denx.de and cc custodians.

But B4's default behaviour is sending patches to custodians and Ccing
mailing list.

Thanks
[1]: https://docs.u-boot.org/en/latest/develop/sending_patches.html
>
> Cheers,
> Quentin

--=20
- Jiaxun
