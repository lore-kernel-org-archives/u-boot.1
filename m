Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4FFCCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 08:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F024F8307F;
	Sun,  2 Nov 2025 09:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=internet-e-mail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=internet-e-mail.com header.i=@internet-e-mail.com header.b="KQIL1+Bc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNS2fXT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2414830A0; Sun,  2 Nov 2025 09:06:48 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D248A82A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 09:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=internet-e-mail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew@internet-e-mail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 598D21D00064;
 Sun,  2 Nov 2025 03:06:44 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
 by phl-compute-05.internal (MEProxy); Sun, 02 Nov 2025 03:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 internet-e-mail.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1762070804; x=1762157204; bh=IFqUhueWQv
 9afPVaWPZuoH1o5gf8PpDMmEyhKCk9UC0=; b=KQIL1+BcdIiXQHAsaD1KRtBJCi
 Lt+gF8BQZzWbkYmX6z15vJnSNb6tkmmBlHA1F6Y1JZ5wG1NVT033Yn84tHXoSn4r
 FJ6lcb32OOu4Y5vqy1qXPJtzPDXELoDDsNw9mDkWNbXuugYSbKajNzEmKsy8IZFy
 Af3veB7dbW3iFgGl0SQVU2ikPrjiVet4mXZKoXKnmiHOAb087MGqGguCa97VQFp0
 9nbEcEuWQlodraHX1GaIr4XFkjNe1eXgCD5t5UpkAO44v9GIgIrtyRsBHPVITNPM
 c9+KaBUAbLMSaVPUFkFf9HBgu1qTSm5alXza69GyG0aU3d/t1D63QTTSFV4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762070804; x=
 1762157204; bh=IFqUhueWQv9afPVaWPZuoH1o5gf8PpDMmEyhKCk9UC0=; b=r
 NS2fXT+aeiXJrrhRCvKvHhWzbpUMm0Sy8GTZQu0CPjMT1on9FytV1xfM14/sSGIu
 DfME0Kd3IXODvFiUnB8C+M9oAGmnFwQ2kNwhdWRRDAoXclxCOoHcSCsmz5zCkshw
 CvIdHnATNFF+aJtDlCrVEEtInUzRMMnvMZstlPiq3nKJLlJX/h+r6Lcuy6Aj0D41
 WdmGHdbqHAln1X+qbi9b3Rc6hdTHmrXf9i0lIHLRPpqYUBXvABq0vDiFTJVcx5Vk
 mCziin1IM4VaCmsFzBQWdhLOhheMCYC/dnuOGk/Ba2rXxqZYLpAGVsysBIFP49NU
 rEBU5WeFi7ZgKRppuKHfg==
X-ME-Sender: <xms:FBEHaTm4eIa-cUFI0BEwQuqZqFQ9Y0XpoueDDP0wD0c6AzK7-9SHKQ>
 <xme:FBEHaRp6BNXMfhhqsKoT5I9U0oTNqOZacUP6izhTFjXlC9B__Nt56Ff_iF3id-e4P
 aDS9wvH7QmDzwipNyVY0lGoF2Ap_0KXopIGcGSRc2A-NsvL9qhlLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpegrnhgurhgv
 fiesihhnthgvrhhnvghtqdgvqdhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeffve
 dvheevieelhfefkedvgfekgfdtgeeugfehleevjeehkefhkedvvdetueeuleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesih
 hnthgvrhhnvghtqdgvqdhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpd
 hrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:FBEHaaSfNesevZEC0RZN3cTDZFsEyroYyaWjnRVdPNGCOJkufaaNkA>
 <xmx:FBEHaduZTN6ix-JwaNhe0h3S7nn2Nq-_ogxucBhJ_lWxizVNKDuNVw>
 <xmx:FBEHafbBgiK_Kx0cgmDO-WfIWdmZdVJVOyiJHiUy4njTyGuysNRe7w>
 <xmx:FBEHaSuFT-w0vAwKdm4q7g8Ij9W6PtfnpI4pr-vu0pLvo9cL0e9UIw>
 <xmx:FBEHaTBoSkUEUONElGU84UMh8QmdrmShM0VmSabtoC6-BT-jLV8EV1Rt>
Feedback-ID: i72864837:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id EF3A618C004E; Sun,  2 Nov 2025 03:06:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AAA4Jum9We7J
Date: Sun, 02 Nov 2025 03:06:12 -0500
From: andrew@internet-e-mail.com
To: "Fabio Estevam" <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Message-Id: <b1a58116-3587-4ab3-ad0b-97f7eb56b6f9@app.fastmail.com>
In-Reply-To: <CAOMZO5BD=Q6_VamiPr-qAomfmszU41g8ML+q0sOnSn=Bj3ooPQ@mail.gmail.com>
References: <63bb0a47-d02d-4d73-a63a-3f6b37caa09e@app.fastmail.com>
 <CAOMZO5BD=Q6_VamiPr-qAomfmszU41g8ML+q0sOnSn=Bj3ooPQ@mail.gmail.com>
Subject: Re: building u-boot without pxe, dhcp, etc.
Content-Type: text/plain; charset=utf-8
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

This seems to work for the latest u-boot but not the version I'm trying =
to build (v2023.10). I did figure it out though. "BOOT_TARGET_DEVICES" i=
s defined in u-boot/include/configs/[board].h and I just had to remove t=
he lines for PXE and DHCP. The comment at line 12 in config_distro_bootc=
md.h explains the odd-looking error I was getting.=20

--=20
 =20
  andrew@internet-e-mail.com

On Sat, Nov 1, 2025, at 2:44 PM, Fabio Estevam wrote:
> On Sat, Nov 1, 2025 at 12:15=E2=80=AFPM <andrew@internet-e-mail.com> w=
rote:
>>
>> I want to build u-boot without a network stack (the target machine on=
ly needs to boot from usb, nvme and mmc devices) but disabling pxe cause=
s a dependency problem. Does anyone know how to resolve this?
>
> Try passing CONFIG_NO_NET=3Dy in your defconfig file.
