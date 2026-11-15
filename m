Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5D606A329
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RZZOGQP2;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oC/1mfvZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E906360650;
	Sun, 15 Nov 2026 20:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjsugxPJ55-Y; Sun, 15 Nov 2026 20:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 008AF6061A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794775997;
	b=Wu6tazj7gIYq++NmNJx2X/EoJi2ru93gbhzis1qINKtZg/sRyj3BTWM9j/J0NNhp+M0v
	 cXXDMZEpS1DMnfCg1DY0g9GO4gSgdFbBpmLOUgHyMmDt3sMIFBUWoyxBcZeKc9BeZmFJY
	 4loXSIRDIkEi47fMWxyFW5NoKuQiwS5GmUoQu4WBvlEJLX/czwn157CVj7wtQq5dQnBlw
	 +cLLLKIVldUpOaT1BMcK9pHLAO68TvWowFuzscxT4uH8IwQ+kXy5eW9k2pO9/9Z1ZMc2S
	 WcSMzRTF9IEMVkFfkti1cmgBDhjfUjYgZLYfT9OUFXhr4kNLqrvTmI8cclI+8aA5EMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794775997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sSugjLiyUA5/coVv8WTK3Ay/XJHdaYfI+OvVzCoLq0o=;
	b=qrkFYZEOvRIGf8t6C41Rsf0NqMZHgCuCvofRxD0FueqsMI+TPkc2J5nUogC7YHU29FOe
	 Gr1rtZ5tuhMujNIYZvSfq7CvPN1oaES9I8KBc/hUDT+q5f/lCOpOXDiwUaCUqDs7AjBVL
	 mDn3D18eLWWW9clkdCMYk9e6JkPuvUYEgv9hgFSB40i3M7PY1Lw53ErTSFTbq+LG/EG9Y
	 qfyVDAfk8gdAnYD82M06MVztEPtplR32hc3kvKkP1EuDTA3ds60WBGuLPiA9Dm9qq/2z+
	 zlPCtTwwfef61BG5WAGVPjMD0UGgjdP/4mddlLcdERxrv1NlpNkXMU3e4DUrPNMYwRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794775997;
	bh=sSugjLiyUA5/coVv8WTK3Ay/XJHdaYfI+OvVzCoLq0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZZOGQP2jY0vfw5Oppq5jcxqmnJoO/JmqeeWyLnTjehir35Ezj3OEV2phAtiiFL12
	 fc+TWmoY/yz5UjAj1EhYhe3zVA8md2SPy0gbawYmXvs0QETQf0iKpxuPOUOgvJMVsX
	 T4niJnVW8K/05DotBckbbsEHSQoIhXrkjjA3AnTn8f/Zg4PTFsIgbdgnt69gB2f0df
	 NA9b6QbvZUV26OLogIh/NmzJ98HFSHi4X0/9Atl26q4E/XLAScCl8Jsx5C12B9I5rV
	 AaS304X6lI/LRP4OE0Hv6567Ra5N5hYNpidzrwL35JDlAsTsDXgoQnlKLiVi6pzFOx
	 BCndE359fc7DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 008AF6061A;
	Sun, 15 Nov 2026 20:53:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C21962FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A896340080
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37CtUTM6hJ-Q for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 20:53:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A9B2140048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oC/1mfvZ
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9B2140048
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:53:14 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-706113e92f9so2305692eaf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794775993; x=1795380793;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sSugjLiyUA5/coVv8WTK3Ay/XJHdaYfI+OvVzCoLq0o=;
 b=oC/1mfvZXQ/G9mp71UQ/yo3eHIFYFGnvCHTos28z+OiVwDz78mSYy0LtRMocJDUfCX
 hS1zuQ15pHH3Z8yGwfl45NzlwbIsmwZP8pJvL5JJ04cptCAG5IKIX2Q9eLfFHgWowvzk
 VwQO1DbqYZ7SjnP4ancQylc4jGBh+3ulyfzyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794775993; x=1795380793;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sSugjLiyUA5/coVv8WTK3Ay/XJHdaYfI+OvVzCoLq0o=;
 b=Xx8eYFNq+blLdrmPagfVMtRteZN+k2YVHAcdVLHEfWDGeP//I49falLh/2hWqBgs67
 xJeVuR2es9RYS743o//36tDwve4lNfpE2MK64CAQwAUui3YF0ov0kl5lXZiGYRvF3kLP
 B13IWqKkxKQiIsZO90AnLw+hfXiLxLU9hS4SOYOcr0sELbu8RzybOF4bCjchAbLI6Pfa
 pgc8LllcF9mr7sRMHpdKFnQrXkPi6S2vc+MdemLPT8yOdiJ0VNPI+pN6wttFlyDgp3+4
 dba7sOGy/3iARw/ZQ9QYBLVwWCT+CdvFqOLOMCE9vydlKQ25xcYIih5hQvQ+ZdZ3afBJ
 2aEw==
X-Forwarded-Encrypted: i=1;
 AL+hErF5qMcHFk2IFv/jl9oShtOxtuAeWa8V3M1ZL66gFQfgjda+1NfiX8nRshD9fdpZExbEDZN3Xlg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9xa06yLGCc/2m8GK3m44Hj6fBVyp4sroAX52FROIWPMzyyCzZ1
 DBFIhR+9zHyAbCBmP32lJfqyk+o7wU3x6AdOgR3W6QCT9P69L2n4MNmlmWSVxI3FkstMxkC98uf
 L72mheA3keA==
X-Gm-Gg: AYBFou2taUUHHpQRp8zlhReGguQflI5zSlCuIrx61tF8ltKbr6vCFY3rHrRqXsn19st
 yohyeeIVZqO9HZrnjLbBQYv3dPIKV2zViNbJ+uRNeBzMCXAANXdk9hwJF8H4MlYVVHqp4kquBre
 +g1vvjdqDu4wIvpapjFX7+dNla8y4K9pNlqb2WkO2YQ+HTwFHH6F9KX9S+BARH3GkjxZMdihDK1
 /BhLY4WPfIWkoiy/b/sh4REPbZS264CBdAt3Q2KxJkcck184muZTstZd6bTDEybpCjmq1+x74hL
 /7U6H80p/eqLaLdg7v/KBI1shxYszwfCaROz0hfshB72ZBtMuIz9PqMZh0+r3AYp4qQWaeFB0x/
 4jPzkdmqUVCrPfyiHR6nD0JqT8+yEulm5rm2YQgw41M+WSeXcAjPbkq8LQ/u46gIITWEjEFzdHg
 Cf+w94Xc/YReHNT4VrByQJwyP7IuwOoYR58Ej+8XUz2HG71Fw9GrEA+Joet0A2kskS+0y4F8VD1
 LUyG61yShhcYi0PGSlcYhyutKrU1DahnRQkj/TY0DP+De+nDY375uKyrrwfLspY1lkgpdYggCj6
 ipvsxT91lJRp11Lzu+V0KfPxGSl8JNMuCczHjkn3Kv2X8Dub51282CN5ccCeupiFiP3F20Y/1qb
 QgWETFrtYsy3FZCZGRH+s6bHxp6J7syfzIYCbDaSlXnNmPiaUO3S+QzAXEfLmIEQlgPQCU4qkN9
 IzdGdmU1iEl/J87v3Dpol2L+SWytSWV+4=
X-Received: by 2002:a05:6820:a74d:10b0:716:d70f:1c09 with SMTP id
 006d021491bc7-71ab510c5aemr3653059eaf.79.1794775993274; 
 Sun, 15 Nov 2026 12:53:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab430598csm7144392eaf.10.2026.11.15.12.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 12:53:12 -0800 (PST)
Date: Sun, 15 Nov 2026 14:53:10 -0600
From: Tom Rini <trini@konsulko.com>
To: George Kola <georgekola@google.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] configs: netspace_mini_v2: disable default netconsole
Message-ID: <20261115205310.GX554944@bill-the-cat>
References: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
 <20261115180628.GV554944@bill-the-cat> <avn83NoJA8ZKi1q7@localhost>
 <20261115190204.GW554944@bill-the-cat>
 <CAOTQ16JK6uKASoNGK1XFXuw-W+dc9ofZRJEV_ZqHMVbAjXhPPA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="COrNanbz38SOrsak"
Content-Disposition: inline
In-Reply-To: <CAOTQ16JK6uKASoNGK1XFXuw-W+dc9ofZRJEV_ZqHMVbAjXhPPA@mail.gmail.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--COrNanbz38SOrsak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:39:12PM -0800, George Kola wrote:

> Thanks for confirming. I was trying to secure our setup where we do not
> need this and  I will move this into our repo.

Interesting. What setup is this, given we're talking about a very
specific board configuration, and not a new one either. Thanks!

>=20
> On Sun, Nov 15, 2026 at 11:02=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > On Sun, Nov 15, 2026 at 07:41:32PM +0100, Simon Guinot wrote:
> > > On Sun, Nov 15, 2026 at 12:06:28PM -0600, Tom Rini wrote:
> > > > On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:
> > > >
> > > > > netspace_mini_v2_defconfig runs dhcp and activates netconsole in
> > > > > CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthentica=
ted
> > > > > UDP port 6666 console that accepts broadcast packets and drops to=
 an
> > > > > interactive U-Boot shell over the local network.
> > > > >
> > > > > Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and
> > drop
> > > > > CONFIG_NETCONSOLE=3Dy so the board boots directly from local USB =
or
> > SATA
> > > > > storage by default.
> > > > >
> > > > > Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to
> > Kconfig")
> > > > > Signed-off-by: George Kola <georgekola@google.com>
> > > >
> > > > This is feature working as intended, presumably.
> > >
> > > Yes, netconsole is enabled by default on purpose on the LaCie
> > > Kirkwood-based devices.
> > >
> > > When installing mainline U-Boot, you need a way to access the U-Boot
> > > console in order to configure the environment for booting the OS you
> > > are installing. The serial port is not always an option, since it
> > > requires opening the case and using a serial adapter (that you may not
> > > have).
> > >
> > > Here is a guide describing how to install and configure mainline U-Bo=
ot
> > > on these devices: https://lacie-nas.org/doku.php?id=3Duboot. Much of =
the
> > > procedure relies on netconsole being available.
> > >
> > > Note that you can disable netconsole support either at build time or =
at
> > > run time if/when you don't need it. But I think it is better to keep =
it
> > > enabled by default.
> >
> > Thanks for confirming.
> >
> > --
> > Tom
> >

--=20
Tom

--COrNanbz38SOrsak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavobsgAKCRAr4qD1Cr/k
CipJAQC3O1hdRiERJpb/soZcWAHjaYVX42mOmj8bjnUW2ZbyUQD/b1d/GkyQXkpt
bkz/FuQTtBwkTz4O326bg6MVwe+01Qo=
=ILAm
-----END PGP SIGNATURE-----

--COrNanbz38SOrsak--
