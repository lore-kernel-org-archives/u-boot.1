Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA1E87834
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E20C842E1;
	Tue,  3 Feb 2026 16:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TC4nv82w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FB3842E1; Tue,  3 Feb 2026 16:00:16 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675368423D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45f053b7b90so3738176b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770130812; x=1770735612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=acvzOy6aXZvE3OqW7axDKaphNmrGk4KkUL+W7+sk35I=;
 b=TC4nv82wmCMT8ya1F1JBpRQtcX0Yelz38ZBMFpoNc4Izr51B9eF5eifJRq8tkjg0GA
 Po12vj5DcMuXhDbzx1KxV9tiURmo78VO5fKqvkkiejVwPKY83khkGSQ/nVuuGbTa7m4E
 rDyznHO4Ia38Yf9PuIWOSYpLOC8uy79jZ1T/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770130812; x=1770735612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acvzOy6aXZvE3OqW7axDKaphNmrGk4KkUL+W7+sk35I=;
 b=QL+dqnnBQM9retFhGDiNYaTBr0jySFtppXd7/yvZIZG3TSmhi5UVOc+PFcv5Sd1jkr
 sU5pSGhhLd3Y1fxYukaUK97EwFMWoJK8C9CAGCjtlKIiIZPO55U1PZxVIdLXIOlaXszP
 QTrG7EhXBHh4J4hL5QfOvyIW1MOlAZvc5JDx1ZQbMzOSc+AfDmL7zHYE5DTw6eivR+dT
 0+TJwIocRyB8Gt3p1u5GjhGsP+99m97IcBfs1wrTwKQrzOsiJ3YtshkaxomGCr7WOau9
 /w/hER6qZCP3Hj0vFhabYZE1KS/69dJU0iRtSxNMf/EZotFE3yosKu/WEKUuc+6Zxdhi
 tvTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnHdIl8eJo4PAmw6TEqV4aAu1uRW7TeVNxkwUrJLq0BqukmkyGs9LFzxdQOsqicgJLh8Rnn2k=@lists.denx.de
X-Gm-Message-State: AOJu0YyAPJimaeM2KUIypJMZKEXq2sMJnPUqIzxx+bkOU7GzuaP01eCw
 7zL7vg6XImyAGrG97v7R4W26CH+A32PI4vsTE3TidVL+gtoRmPNsDv7gyUKohBVBvO4=
X-Gm-Gg: AZuq6aIWUvH57cYGPtFmuqD1p6ygoyWYf4qqObvLYE6GMtdThqEkwtd9v/W7kOJUJRE
 QPnK6HeqAXd8JiOdRPCMlPE/MnpeLLzQXOmyS3zQ163faaGN83AII072l03KwKQoM1/ZslIUNUP
 9ChWXeZwogjii0Y1MVdQbFQTw5V41WVn9aGDb9RjjT64vEW7gr5AgoenGzZRYeN0fMd1XK9vJbX
 oXMrk3DSPwF5BhcjvvxkO7/TU1ZZX+oTxW17WsP8UhZRbbTBiQ626IpeFBJzUqeKZi8TXm/EHoI
 s8xUdQkJewWYvjfQZ1Iv2EAuNRA1RkJmuFaQDUWAsivvGE+fUVSy57IH3mvu0vNH9huy2Bbn+70
 IsuhByv2yAgbL1hlIkdrFrgdR74HHyagZJg+8iR9kRBCx8Oq6ZoXcAq0ucJy+2smMTA0R79nGAo
 BH1CBCJE1QIuIg1DKzVxj4UIRT3XN+qEnGJbIGsWrzaYZJG9mXtua5grquDKh6okV6KVYVms+5+
 F0GJikSINV2UvTx/+o9u+W0yfDltpY34lIbWx0=
X-Received: by 2002:a05:6808:190:b0:462:aa0f:4374 with SMTP id
 5614622812f47-462aa0f4450mr2488174b6e.8.1770130812049; 
 Tue, 03 Feb 2026 07:00:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095756e77fsm13069081fac.19.2026.02.03.07.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 07:00:11 -0800 (PST)
Date: Tue, 3 Feb 2026 09:00:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Message-ID: <20260203150009.GK2603314@bill-the-cat>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <PAXPR04MB84594DBC04C4957716EA9C79889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20260203141630.GG2603314@bill-the-cat>
 <PAXPR04MB845957CDB8EF1B3B8B4E0D32889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZjLNbyUgbEG22SDx"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845957CDB8EF1B3B8B4E0D32889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ZjLNbyUgbEG22SDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 02:46:26PM +0000, Peng Fan wrote:
> Hi Tom,
>=20
> > Subject: Re: [PATCH 00/14] treewide: Clean up usage of
> > DECLARE_GLOBAL_DATA_PTR
> >=20
> > On Tue, Feb 03, 2026 at 11:42:04AM +0000, Peng Fan wrote:
> > > > Subject: [PATCH 00/14] treewide: Clean up usage of
> > > > DECLARE_GLOBAL_DATA_PTR
> > >
> > > B4 fails to send the last 2 patches. And I am not sure how to send
> > > patch 13 and 14 in the same thread. So just resend, but seems resend
> > > still fails for patch 13 and 14. (:
> >=20
> > I like the idea. I suspect 13/14 are just too big or too many on CC and
> > the mail server rejects it (gmail rejected this at first so I just kept=
 it to
> > the list). So it might need to get broken down further.
>=20
> I see. I use "b4 prep --auto-to-cc", so the CC list is too long. I will t=
ake
> care in future.
>=20
> Patch RESEND 13/14 has been sent out in a standalone thread, sorry
> for this if this brings trouble for you to manage the patches.
> Please let me know if you need me to make all patches in one thread,
> I could drop the big cc list and resend all.

Unless there's changes requested, I'll just work with this as-is,
thanks.

--=20
Tom

--ZjLNbyUgbEG22SDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYINeQAKCRAr4qD1Cr/k
ClHhAP9tjiaRNVkU0pdEoruYL30r3/xYYkf84rnN23e5oEk3awEA3dUU70fibiND
A/7fkjVv0CPH93QybHf3/JVbInYpmQw=
=+AcN
-----END PGP SIGNATURE-----

--ZjLNbyUgbEG22SDx--
