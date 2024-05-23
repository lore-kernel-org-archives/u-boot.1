Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222DEC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C7487E9D;
	Thu, 23 May 2024 19:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="PQcqg1cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2118811D; Thu, 23 May 2024 19:24:53 +0200 (CEST)
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch
 [185.70.40.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210CE87E83
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1716485090; x=1716744290;
 bh=WqAzqdDpgv5ExtAhYmBHfGgNSDnMzLh62fBGKDhMYS4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PQcqg1cdWnmWa9x1FtNHrZ/4FTYzJZTEEcahHb4oslBYnddifdKNWDnLIDmpQfPWQ
 wME/4KE0/+F17V0EpFvOMmyoLp7kkXoFX2E9FA/ofsWc+I99/FwuloJfuqUhwGYidI
 la5FvnbVbW5Nf/nk1ODfzTlX5KeXfxRrp+Klo3cMp12WUSDarmPKhv6RIUlmlTgA0O
 lXN3Ija7Ig8WvJuHdlo2MMtWtPBVnvXMS7OfielZ5Ay+6mZfg6aDBJElKBJPC3D84b
 iY+1ZBObx2MOXyqyTFWdRWCGlfGtq6zfhVKFvCpExSdkVAYzPHpR39qgaWjYU5y2OH
 Uox0fuyxzGstA==
Date: Thu, 23 May 2024 17:24:47 +0000
To: E Shattow <lucent@gmail.com>
From: H Bell <dmoo_dv@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2 v5] board: starfive: support Pine64 Star64 board
Message-ID: <981qX856A4s2-msnJafAyiVlYr_160Bo66o_7eTK6Mk2anxhpi7lgunyMwDRjpCKm4WcFKuAYkLw9vatgEjyiirOwUC8nRSYA0k4TYIYTEs=@protonmail.com>
In-Reply-To: <CANV2PTOBdVQfaecSRVhtXM76daDVdB142SbG03bZ1rrSPKTvpA@mail.gmail.com>
References: <dcEaD5-kc_SzXGz7v_bxIV4C3Rqg0b0x2bWGjCclG5pS_sL_tWoxtWu7VQqu_2SOx0LN3h9bHcaqsa_l-PiOQAMkZpiJ9G4SQta-kfPDuJw=@protonmail.com>
 <CANV2PTOBdVQfaecSRVhtXM76daDVdB142SbG03bZ1rrSPKTvpA@mail.gmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: a9a5b8c92611ceedf3abe427056edcd7402c47aa
MIME-Version: 1.0
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

On Wednesday, May 22nd, 2024 at 9:40 PM, E Shattow <lucent@gmail.com> wrote=
:

> On Wed, May 22, 2024 at 12:13?PM H Bell dmoo_dv@protonmail.com wrote:
>=20
> > + {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > + "tx-internal-delay-ps", "300"},
>=20
>=20
> Note this 300uS value for tx-internal-delay-ps differs from
> pre-loaded firmware on Star64:
> ethernet-phy@1 tx_delay_sel =3D <0x00>;
>=20
>=20
> I would prefer to this (even if it is wrong) same as the pre-loaded
> firmware has done. Tuning patches can be applied in some
> future series. Is there a noticeable difference in function to change
> this value from how the pre-loaded firmware does this?

I agree that it should stick to the pre-loaded firmware wherever possible
but I found that using the 0 value on the tx_delay_sel meant that the devic=
e
would not properly send packets over the network (and would not get granted
an IP over DHCP), and found (going in steps of 150) that 300 worked.
