Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41A606A338
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jjbTVNu4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mOwp4tZj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3403607CD;
	Wed, 11 Nov 2026 15:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPvyQvT0X06n; Wed, 11 Nov 2026 15:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFF9A60784
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794409960;
	b=SGF7Tka94jJzXbb6eRhIlB1B2Q4AyDUG1YkQC4oRtNWhZVqLp+CE5odoi6yDhMlPxKb8
	 kow/qVAOg7cY1MEGPr1XVMCm1p0o377JJjMA3X9nlW6IrkRSjFzzlRkZNbx7uzVW/sEbR
	 wg8WShJG3e6fvo1HgVc2KsOb43L4aP/kkPBV6azYpv7Zzi24CpeLe46sYTPSsW9LtV+5y
	 W3HmAonJ5JHC/1pqzA28P+YkOH0SvkdKg5igAkTG7AnRzKU3mRq3Esqf83ZShNozZZ2Ab
	 DT2Zu7e9PQ+plVW9HLnnBfIbfoMKxCPjXgD3RtfHjwoD5FY3f4nWpxQcEbb4I1dJ8EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SrljmTZhoe7GnZ34akD2+CEsdYSHOTPyY46Ikdjx+DA=;
	b=tPEXWHTpYdNZTg0U6w+wrHs03JA0ztcvkJ18ejKZvOhhbskH26dbKBq6Of8RaItn1hPO
	 2DmTF7AE+HqXPZXNO3eLeMHuIxFSDNqeiN5HjBvIe7vDUW/+c6fklrhS0Yr6PT39KcFap
	 1OAkjlzGxSfHIEUHIsBIEQ5i8Ws2dBvFoNRjGxFrL0e1njSifSzg1vALl3ut/nnz0h3dr
	 cznwRJ1jHfVPKOJqsm1phAdricdbLwWzhDMKTcKlBzCFfB2HP3OgVHnbTrep3EMUSAurm
	 e+xLEN5hxYKjLi7V9rx0Y7d/L9KZ1DB95mREc5dBnmcxeWoXrksJn11jIkoUmqeSbdQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794409960;
	bh=SrljmTZhoe7GnZ34akD2+CEsdYSHOTPyY46Ikdjx+DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjbTVNu4EpN4mvtWLOEPqhk1syPt7hCaP2podz6sSnpUDt9Hnj1Gn8B8YRJJ7QPGq
	 ZpFxzuwrMyx65C0ndbfiTTwTg/b7pXryFtGn5xoF17Idq2ubuIcNQq5YhZY02vsywK
	 DbqKPggbKGkmr1tRmuJVQzWQ2BK/uT5kjmpY6cU6LG7BkVaSxWahBztbRqUg+9/bE/
	 zmhLmy2MksYY7xz9b+FPSykHS47WLc42ruabToErWZWoOblgTp4UdR0Cgn4Lx80sop
	 UnU9+c2Z+THjZoYb2U0EdcA2dqySlitcDgfwK0VdL/v1RLX9M6VbYhOJtMwI0ta6vi
	 nHJuw1AbSArVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF9A60784;
	Wed, 11 Nov 2026 15:12:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C792A31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD3244084F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xxiuaj-UesMG for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FA154084B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::8;
 helo=mail-oo2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mOwp4tZj
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FA154084B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:12:35 +0000 (UTC)
Received: by mail-oo2-x08.google.com with SMTP id
 46e09a7af769-860f8b7b943so187973a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794409954; x=1795014754;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SrljmTZhoe7GnZ34akD2+CEsdYSHOTPyY46Ikdjx+DA=;
 b=mOwp4tZjwFXltHRM0er1dujA4QQs82zE5BmUsOonVkbb2xR+h/psuBt1XaNibi9OVF
 wYe7U2CrWc2kfsb+g6b4jcBNaPQLlkC3lVnS9Ya7IIHCwdwvCA5D4sV5rhwQaVXVdMJX
 Qk7pj7tLID3n+UG4rbNyr5aHqTJCszUYCq4I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794409954; x=1795014754;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SrljmTZhoe7GnZ34akD2+CEsdYSHOTPyY46Ikdjx+DA=;
 b=LYclr12XPnrOuX5Nh2EjZtSA4fbZLSMuHRT5VP32JgZjTmDs3IHiaqEgL0/s/3FIFp
 KLmjicoQAb8aiPXv+nV6lP1kriWjiZ/X6z681Ab9bwxOxO5HBXi9GifF31GG3mtBZ/PE
 jYZhBt6/x61goRRIvVCVkhzuSCL+1tonhuem3t6Z83LGVhGkwVJ+hdMX4p6OTkw5VhBN
 STammNUTE6aCe3g9B63WBm/xDHv7ulIf2MwH2NiXg9gGzoJdDTZwggCD1frokpRF52hG
 V0UYbPUOmDTouf11iHtP/MZ4Za/YU6mdPnMEB9uHfsn453viMQj2tWbbketgHOQ6H9h6
 4Dow==
X-Forwarded-Encrypted: i=1;
 AL+hErElx3sNMADyiqweJWm6hOndmCccC7e9zNCfO71P3kaSXkYGuenfvl+Zw1xP2WhrgyOxnIn5iRo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/u/zTy6xva0JKw3E8J/1bhBVpqtF9okXATbfF+Fk+6G/FT+hl
 iE5HT8q9lMGD+Ijg7jHX7AkBxO98VoUkNCb+y/sxIn9IgwD8VVz1H9Vr94adWSyFzp6Cy3QtR34
 Xzx7jhoxa4ufVecQ=
X-Gm-Gg: AYBFou2Hb92Yc6wuVC9xCsBtesnBNjXSCuE+R6gQIM019R4E0nF4aQji2AZhEnjL6f1
 fxx/xGosmrEjQ0aXCinqeWu2l5YJFWY/QcAJsoEUJkM5YriTowt0/YdVZ7qSAfYQ5q7ZjMV2poy
 /E+VDnv1g9thBib5kvJZRuF6cTS/wLyVYkMkCeFQWvFFxW9perY9Jt1uGyBUvhny6CqZ76TYeKt
 nSqFZDASc2ID3LbWSxhu75/Y0H/+kRgVKOd2k4qYmbbQZ9t0We5eXgFQxcDaVEWhXUj1F2EfHwp
 qfBEG87HT3zEE54ZJZfSautNkuHPPN8BXkDH5iUMNjjrzSI/Xpq4CgsJv4YEnf/p+LUm9X/mwGi
 Kdqu2gjzuzCaP+9KGi0IM9DmEPFVbfmmb28ck12KGcmoq5VolDcTnaGADysojXKzyYEK1jaCjza
 ThRN5AtHGo+BFD/VMU4HNCMewBQFyyNkOGNtKcrAupHDozHy67yjdakoDmKiIEqJvSkQkwAAJ9H
 Y6MiU3aLXoMOY5AoF+v1llyetX3t7n0L1YZD2mPm4PqydlXx7a80depoCJeOr24K/cwPvt4x0N/
 Nn67nDt059jz/0CCukqVUNWjra3QYGyCbW/RaJ//wvQefIUcSBzRj4F77vaj7/htCmjlLqziMKG
 NB7On0SZbNUxxB/Djex1ZKe4cxhKzDlsIO97FvRCQ7M8EtQDN/aIgD1XQc2YojjGwjZtCJ3KRhN
 3JGzjRfOgPiPFHX1RTWqXTggRyB73U8J2h
X-Received: by 2002:a05:6808:c40a:b0:4d6:9113:25ad with SMTP id
 5614622812f47-56b97e28726mr1932464b6e.48.1794409954479; 
 Wed, 11 Nov 2026 07:12:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae2302d8ffsm3664178fac.13.2026.11.11.07.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:12:33 -0800 (PST)
Date: Wed, 11 Nov 2026 09:12:31 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [RFH] Writing a project Code of Conduct
Message-ID: <20261111151231.GD255403@bill-the-cat>
References: <20261103172036.GS3309461@bill-the-cat>
 <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
 <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
 <cae8d4f7-faa2-43d9-866a-cf2ee5d07efa@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mFlYZflgFMnTR9R7"
Content-Disposition: inline
In-Reply-To: <cae8d4f7-faa2-43d9-866a-cf2ee5d07efa@freeshell.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--mFlYZflgFMnTR9R7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 06:54:40PM -0800, E Shattow wrote:
> On 11/10/26 07:12, Heinrich Schuchardt wrote:
> > On 11/10/26 11:32, Mattijs Korpershoek wrote:
> >> Hi Tom,
> >>
> >> On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
> >>
> >>> Hey all,
> >>>
> >>> Getting back on track with project administrative tasks, one thing I
> >>> have talked about the project needing for some time is a code of
> >>> conduct. In my mind, the best starting point here is, are there code =
of
> >>> conducts in other projects that people use and they feel would be a g=
ood
> >>> example for us to adopt? Thanks!
> >>
> >> Have you considered the Contributor Covenant Code of Conduct?
> >> That's the one Linux uses, see:
> >> https://docs.kernel.org/process/code-of-conduct.html
> >>
> >>>
> >>> --=A0
> >>> Tom
> >=20
> > https://policies.python.org/python.org/code-of-conduct/
> > is another reasonable code of conduct.
> >=20
> > Best regards
> >=20
> > Heinrich
>=20
> I observe copyright license violations as kind of status quo for
> embedded vendors taking U-Boot code and stuffing it into SoC BootROM
> without adhering to the copyright license terms. Writing down rules for
> social expectations is not on my radar until the legalese is well sorted
> out for the code contributions. We must not set impossible expectations
> on top of undefined parameters.

I see these as generally two separate issues. A code of conduct is to
help the community itself grow. It's not a "legal document" of some
sort. Copyright infringement is another matter and if you have specific
examples, we should have a separate conversation and involve SFC in it
as well.

--=20
Tom

--mFlYZflgFMnTR9R7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavSF3wAKCRAr4qD1Cr/k
CpiDAQDxXa9U/ZhYVXcj9wxopCHyNbLCcvE8H5uLXZzNPVpl5wEAgN/Khs90lrEW
g90XlH4hvPB3MGtj6vg5Lh2xxE//6AM=
=1Clf
-----END PGP SIGNATURE-----

--mFlYZflgFMnTR9R7--
