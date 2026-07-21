Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B9EC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA1E240920;
	Tue, 21 Jul 2026 15:07:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7nXOXdp_ioS; Tue, 21 Jul 2026 15:07:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA1A540854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784646472;
	bh=iDnKltNJJ0Hknw4eDZ2FpTV5v86+oNk5G/H+AIceWYQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aaO0wfe6OaqGtERFWdcmrbr+mGGtwtAfPuBS0Z8tQkD5pW4Ah1m6LR6XVqTeLM95T
	 LMt52HF9A31RkAbpfNbBWZYlyY59ZWnyXp02QR79fyUaMxjJXyLE43bFaKLBbTh01v
	 pcK5f7hWNw12dGp9Yd8GasuADob+IvL8WFVGOgfx3fmqXstWYlLSdQ1gS6Ojpcs4i+
	 LxHi9D5RcYvpYmn4CCk47bRQWgO6f4B1VDVRMjSntHEFUDST9jpCGNMFUmcKlauu1s
	 vCggSfpGaIgf7vyQJ5wEPh0rytAiyb/g1ctKioCgsIC3gi1DUJo8pMRh7xeALYNjd/
	 Wt92BTcIP8jfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA1A540854;
	Tue, 21 Jul 2026 15:07:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4971FFCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F6BE60868
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJhQ4Ffqx7pe for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:07:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3585660865
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3585660865
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3585660865
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:07:50 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a116bd18ebso4314802eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646469; x=1785251269;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iDnKltNJJ0Hknw4eDZ2FpTV5v86+oNk5G/H+AIceWYQ=;
 b=aMYic4lxKt2siZT8jow19JYoAkUtjraMGyEydCut4RogFe6/TZQmfengy2CcZx8eU2
 LGnSSkbY6AubDx8dXoLG5FaCVZEPySgguCaq6SVQq/2MFHgJy7FlDaF9i+m0hwgvzf4Z
 39wXqBC9Aeq/wh0qCJEQCFseyTGvLU4lIEZDKeYPz8N0skXh0zIeTBNlynRRPU0VnNEt
 qXZJbXpH4tnStUmGXNrZwedsAJCNIOv5/+rLcKTkzRNg2OhhsITWcSpkPSSNAr7xS22r
 aqmjZeyEypJCegUg6q2YSCW3l7dehKgpMqjJsPw6iZSUMDpLHTNo/IIg6uZrhgwJbv9w
 HP2w==
X-Gm-Message-State: AOJu0Yzb1X1ZfWMBnfRn6uh84Bq6mrKmjyzOLwNOJON/x5FkRCqRWmEc
 NNYFuO5+rfdhKJZpOiYn6+/HZLHIX1fSKiFIOdppSRW9MQ7CUD2SMoZV46tXpLVev7M=
X-Gm-Gg: AfdE7cnljv+72tCIDSkG4W6uwqH5XInHwtstdxhpVr+MsuJPhhSCSO2fIqh+iTJA5j3
 bv0RJTS4f891YMVDQW38G+TxtFsIjsYXI6T8Gii9wtUwYg7KpKoG7Go9JA/sOkbdehxply3aiyw
 29bC6qwBu3BpBkqTP/oKjUSCeET1GBa+94ig+TbuuWrY6y65F5PvnAvNn2CwxdrwIgR7V7XD+Wv
 ciaa7ZCoufZsavjso/ZOB+bas5uj9pP8t307b+wg8uTa4/3hXo1iEexNd+8j5AUGlX8P9H2yI9K
 7PQGXG6CEa4niuuUh9R+gkoF5HO4LeGz+aEddXkKOzE4xyBCixZyFhb9lpvN7pt4hMPm317tRY7
 3mfgvOUJ1bKAc2xkrSB316UsneWxoJfrfb+GDjB1UIZTamPrKgHBfjSJbi9fk+ns5B4dII7EByD
 7HEfOZ2fTf5eNM2fYbrjWLUZoYOFJ+boaCigmbKkvdfhWHKKN4nN89RNU5q0EL/uxoQdJglKx+J
 OJ3TEOOW1duXBLiUHZyHkkncFAQFf6KO2nARA==
X-Received: by 2002:a05:6820:2224:b0:6a0:f3b5:129f with SMTP id
 006d021491bc7-6a5368026a0mr9145110eaf.18.1784646469097; 
 Tue, 21 Jul 2026 08:07:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aa2d19c272sm205221eaf.4.2026.07.21.08.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:07:48 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:07:46 -0600
To: Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.u-boot-project.org, guodong@riscstar.com,
 raymond.mao@riscstar.com, tanmay.kathpalia@altera.com,
 junhui.liu@pigmoral.tech, peng.fan@nxp.com, leo.liang@sifive.com,
 sszhang@vsit.ai, oyst.lnx@gmail.com
Subject: Re: [GIT PULL] Please pull riscv-for-v2026.10-rc1
Message-ID: <20260721150746.GW749385@bill-the-cat>
References: <jf3kajqvl7zz3xgrhxsmwlki6el6udc3r5drlzuylfrxj4g4u3@uhy5mr6b2cd7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GxLxmiw+SicNbXZb"
Content-Disposition: inline
In-Reply-To: <jf3kajqvl7zz3xgrhxsmwlki6el6udc3r5drlzuylfrxj4g4u3@uhy5mr6b2cd7>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784646469; x=1785251269;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iDnKltNJJ0Hknw4eDZ2FpTV5v86+oNk5G/H+AIceWYQ=;
 b=KHgFvlPhQnlM51vtKXrs1ZgjIp90/zJXdHDm5GgWY1oAy7kcO5Wbbg2KtjrUfX5Y5V
 JFlBwceMAKIt82msAl9otndNUjT6ndxz2bPH9URcC4Z8mQLUYiko3sL4zpWrd+l8pnix
 bkz3gQskZX+b/zcQrVLJXvlDfN1HAhZCWEOIs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KHgFvlPh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--GxLxmiw+SicNbXZb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:50:37PM +0800, Tim Ouyang wrote:

> Hi Tom,
>=20
> This is my first RISC=E2=80=91V PR. It adds support for the SpacemiT=E2=
=80=AFK1 and
> updates the MAINTAINERS.
>=20
> CI result:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines=
/676
>=20
> Thanks,
> Tim Ouyang
>=20
> The following changes since commit 042e45e026c77227319a426940577856ffe62e=
7b:
>=20
>   global: Switch from source.denx.de to git.u-boot-project.org (2026-07-2=
0 11:13:21 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git tags/=
riscv-for-v2026.10-rc1
>=20
> for you to fetch changes up to 0926356edd68e180bbb214f0bb277037d9415129:
>=20
>   MAINTAINERS: update RISC-V maintainers (2026-07-21 17:47:52 +0800)

Thanks. I'm checking this out now. I just want to note there's a lot of
other outstanding RISC-V patches too that need to be picked up.

--=20
Tom

--GxLxmiw+SicNbXZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal+LQQAKCRAr4qD1Cr/k
CrB7AQDXAc0gxrctqK/eTf2weaP1a2Eh/JsENHAuYU/O3M0fAAEA/8eZPjoEzTWG
hk4a6cdk9ghvlKEivpe1jetvp/oUIQg=
=7kU8
-----END PGP SIGNATURE-----

--GxLxmiw+SicNbXZb--
