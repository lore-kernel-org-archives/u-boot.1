Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A159CC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 20:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 491BD407C7;
	Mon, 27 Jul 2026 20:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8yBc50vsRci; Mon, 27 Jul 2026 20:35:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C731D407A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785184513;
	bh=U/Y2I1bwfec2Y0PuyYDboagR4NU2UWllpaHVaX8JIPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=obbKovpKJxFhMAigcbT6uVh0C+G5OIKNplP9tIRXwMrIw2sSHyEoAg/UM+glXQWoQ
	 JqHQga+hYNdKuGS0xnUWLSaXcIyp2MRNYL03NnfB5mjInWEB1QpMbe3tcoeSH8q13z
	 tyjKa0jmGycB4DsyfRoez8gq4mGRws/Nl68ng0awsWJKsgbv3jmIV301wqbc8zzz5/
	 0BQ/LTtpHHBkNHDH4WcLB7Z9QNiRK/JbPAf0NsposKRFukQHqGnHG/w+gtfeliJvYd
	 t5t9Nb3RHq8a61cmAVoZt2ft7YsK2jGqpb3ZAihDCJTq1jv0fF139AZhjmD5gS4+3e
	 BN/RbQW3uQPFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C731D407A3;
	Mon, 27 Jul 2026 20:35:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE73194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51893401CC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isrmggRqRQMF for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 20:35:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 392384005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 392384005F
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 392384005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:35:10 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-45837e52d8aso522797fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785184509; x=1785789309;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U/Y2I1bwfec2Y0PuyYDboagR4NU2UWllpaHVaX8JIPI=;
 b=Heo/vsrsjMD8nIRnLntV8hEZYyqFL69GnpWEAscfWaRXxUrsAsHYkmBMyRJzE13QxA
 X5T79wXdFsDQGpcq2Z9351iw9QO6gCzVFC3SKaYTLGpKxhMpWinGgwrslYD7gW/AitOk
 0mpW1DJxNZVysjbNJdipfGQUCXNB51cpVgOCp/+D0+7hN6SH8OIodoztNa7jyfJBvWuH
 6AGhXbj8SbFuAVKNdeMr5SB3zigsy6ZciAMxNCNx3wUvGsjSAFfdEIegfpSLQMwxvAVq
 3ZOethnOYzh1sxs3NOiHCkpGqBs1CH2FQt0DmqWktYOVnsmDZ7b8fsTT9yHpPVyHAANp
 cj5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEMQ22ZTJI7DxXTSWdfzhKdhMJYXXdJwobFBtubRBMQHZ4Lt7uGdCRm4reXy0QF8uZUjplA4M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzCfRNIHTi+hr1a+wwEujDTYmZDYoZExg9Pb2FTpAFQ5I1+wIG0
 rT3HaqHbSOMn6Q13WRjgoxmdGA6sAD/sdZU7QPdKbij8JXm5Bn5s708zwP63mFHfwbZedpwi11e
 ledTXywY=
X-Gm-Gg: AR+sD11IHJmZwRt5esiIt3rNXURfs7Prl8cReFb3Lqa5bCu1CFcIPt/Zs+FyIzEX9a4
 5n6Pb93mhNrA0ROK777afEpIduMP3SWzkH9EmXOIEryx9JLSV5+PFREYJdNe3E+KGvSVfDQgrfN
 9FiEXUYeROIkUyWZpQZDm2FL1JzmKh3CqhCwg3XFOCq3s1bBZqGhL94y1ykuc3JywWgU+lFUZd0
 8IkRxRFk/8UVXKAmuFtS4MqRTkwvOQKYzDnwIQ3Yo8EjhYYdPnF2mx15zVpHElCOoZLK0+s8BvC
 nkT9KWb4UlRZjNlhSqQP1sB9kpK710SqW94pGAsLXDPS5kNK8lY+wJFmhfgDrmhYVRskc+cm6vO
 Aw+DeojdaHD/o8YIhRV2Yk3TSy+BCcTMXRqk8jUYjLnqG/h3vF+j9epHV/PCMoxA6dFFbehQXSR
 3VixXnJmzdzSqERaQWHzDpm3p9fD2GiL+tOoWVge2KRkFxm0P0AD7CC+MVASkZZ7SaccrXO13TM
 Qas8vAesdP1l1K2K+NZfhY0Wyg=
X-Received: by 2002:a05:6870:b016:b0:457:3f27:4e0d with SMTP id
 586e51a60fabf-4585e52b6ebmr893204fac.40.1785184508964; 
 Mon, 27 Jul 2026 13:35:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4581ac3f9e5sm5395036fac.6.2026.07.27.13.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 13:35:07 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:35:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: Re: Mails to old mailing list rejected
Message-ID: <20260727203505.GP749385@bill-the-cat>
References: <bd1ea941-a8c7-44f7-8d99-587e702c6163@cherry.de>
 <tiog0q.sgud5ojm2xxy@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qCXZfATYHeEFRj+i"
Content-Disposition: inline
In-Reply-To: <tiog0q.sgud5ojm2xxy@postmarketos.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785184509; x=1785789309;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U/Y2I1bwfec2Y0PuyYDboagR4NU2UWllpaHVaX8JIPI=;
 b=FO5q8UDsuPqVvX1EpzXNyOLsb8RcrZcZUk/I1NU77U8AFOOhrfs9l2q/SfOufbLU9w
 jzHSZrB5QGE0pL2MrSxvCRla99uY2o1+xeXFzDCN9i+czEa2ImUrvGOX1ym3yF6BF8qP
 ERtTjtU7NtFV8d0Wmw4QkmjTf9SnUIspB6eeE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FO5q8UDs
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--qCXZfATYHeEFRj+i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:29:21AM +0000, Ferass El Hafidi wrote:
> Hi,
>=20
> On Fri, 24 Jul 2026 10:10, Quentin Schulz <quentin.schulz@cherry.de> wrot=
e:
> > Hi,
> >=20
> > I (and at the very least also Ferass) am hitting an issue when sending
> > mail to the old u-boot@lists.denx.de. But only with my personal mail
> > address (@0leil.net).
> >=20
> > I think there's some redirection/forwarding in place from lists.denx.de
> > to lists.u-boot-project.org mailing lists and it does it incorrectly.
> >=20
> > Ferass nicely sent a paste
> > (https://ircb.dersco.re/uploads/funderscore/a9b0c0b1-f_-paste.txt) of
> > the mail he received. I essentially have the same content. I believe the
> > important part is:
> >=20
> > Message rejected due to: SPF fail - not authorized
> >=20
> > I weirdly don't have this issue with my pro mail address though, and I
> > don't see how it's different. This tool shows what the SPF entry is for
> > 0leil.net, postmarketos.org and cherry.de:
> >=20
> > https://mxtoolbox.com/SuperTool.aspx?action=3Dspf%3a0leil.net&run=3Dtoo=
lpage#
> > https://mxtoolbox.com/SuperTool.aspx?action=3Dspf%3apostmarketos.org&ru=
n=3Dtoolpage#
> > https://mxtoolbox.com/SuperTool.aspx?action=3Dspf%3acherry.de&run=3Dtoo=
lpage#
> >=20
>=20
> For what is worth, @postmarketos.org email is hosted by Migadu
> (https://migadu.com/), so it is not self-hosted. Migadu also hosts
> @linux.dev email.
>=20
> If there's something not working right on their side I can probably pass
> it around.

Thanks for the report. This was another configuration problem, specific
to forwarding from the old host to the new host, and has been resolved
now.

--=20
Tom

--qCXZfATYHeEFRj+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamfA9QAKCRAr4qD1Cr/k
CnK2AQDoCAf3AAzTkgm/4igM0s2vwQD8hI/sbXchBZo946srDgEAxj4c6oX9OXX0
v2U61tJYBP5SfausH5IHyAQAYEAQpww=
=s66S
-----END PGP SIGNATURE-----

--qCXZfATYHeEFRj+i--
