Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F08606A335
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NdICUQ76;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Dt4vuOtN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C542060A3C;
	Thu, 12 Nov 2026 18:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ICIGBN8q6-Y; Thu, 12 Nov 2026 18:41:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 168D0607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508883;
	b=jvcP1BBO1zymhJ6x3LxtJpvJRNWtH8ozRIPAMnzdBsSxqCjUfa3CLd58SjzfJ4SRDKnp
	 tLqO8HcowusYIhoEHJxNmGkMs3R9wbMllCiPrixC1vzY1+SEMocw+QlxjhYF2Cy0aluXD
	 16OV2CGIXSdJ7hoEt2TKk8TyBub5UjtUYeek/VpkDoc87jsPKks7R3jClmLRxCfdX9TCm
	 BOvk/Jjr53I/2noskc3V/fARCU6SPaXvwBQC2muWdKcgVzV5+sCSALY1EnhyjMwp7qMKp
	 R0mqYbIIA8OK4yOwEyNFPNogXmMMppkM47bhlnK/YnZw/KdaQJ2jZice/u9r42AUkRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZzlW0b+9NZu/lQtTov+n5KSFKh6b3+3PBUiknm7yWSQ=;
	b=rSFd8AINVVa8nNtTETyEGto0dlftPa28NXIMUI0fiiMp8cnPbpPCw0K321KlYaumbMYE
	 bY8ytUBu2U5bTvZPc7+tGxBMtFr5w480ZGYNJ558Lg75OTn0usjxSyBWu/pf+GTiLyqEK
	 zENp89w2afzyprOoQSfbWS8/h25iw8QCmg8yT+asfybzIk501aiyvUBrzFwleDnLEhRe4
	 q9xfKMhZjPPEApLbDvK0RrBmNYtAUhVwhsh0fb2DPLe126c3vco6KFppj/ThWKdpzAn9E
	 wTscYbxGFicePHWRB2hcMWBlkBMnI+diRAle8I0OPnzBRGyh12x5Aa4VFA+aX0+d/NQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508883;
	bh=ZzlW0b+9NZu/lQtTov+n5KSFKh6b3+3PBUiknm7yWSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NdICUQ76Jxe3ZwMxBW7O4opiLUzR6PM8UfVsTxASXcEV+RnAD3WYhQN+XhhfGVWnr
	 3GKg/mTebsAc3nPob0StJgbN56v3kQhq80+sK2/NmRPGu630CCThgZm+sWZVDIsaJL
	 wFiNiWUf5504TWBh4CeOsSyYxNw05dLprGBtccqL+ViWR2H/Y22SLpH7UeFh0gh76d
	 gJBX23D+/9oU0+26VipmF0mBQVdiq9nMZHV7jpmz//5OgK8za0qs6AmTUELacterEm
	 9nRTSjiHY14ueWSGy1hg2lZKKO2jdzJkQacQtqXGTGMu0M9OH0VahYvckEylkfaooa
	 pb3tdRApq3PZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 168D0607F7;
	Thu, 12 Nov 2026 18:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 449ED1370
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35FB54073C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNS1dGP6DFAn for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70AFB40707
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dt4vuOtN
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70AFB40707
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:41:20 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-70b875f6f13so58249eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794508880; x=1795113680;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZzlW0b+9NZu/lQtTov+n5KSFKh6b3+3PBUiknm7yWSQ=;
 b=Dt4vuOtNiNbfSAZC7wAqDOkJr9F7PQgX+wMs6gGDzNuvaKQ9MrFerjDAfpg4WxiFn1
 uU6eyg2/NrUpNjMMw85RfW5sJWoHIAgsApx9/dNmw3B6azGnfalt9Y4VIZJR+zRygXTa
 2/oB+AkKGagHSTtrmeocGRWm3Sy9OzKdG0tng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508880; x=1795113680;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzlW0b+9NZu/lQtTov+n5KSFKh6b3+3PBUiknm7yWSQ=;
 b=a2/aXwHez2lkz3pKX0qSKDjdkYgcOoPZgdAq5u1WOXRjvGw8Z2ivBG6TgUxkDLZ99u
 tatVHiFAPVTVMm1/uA/qBf59V+T/48lksL3ZxVq5f7Ko4wZuXNcIb+oRG4s8994sOjlI
 8AzGBNki55LeL42bLQfXS7myIslgYawT7q9YRlOzGiirOTgp2pw6h1uRDqZaOVqdyz5H
 ArY6tqe5Rg7XJsbXNVWLKTRhaRYLRoue1qxRl4DpJte5O6WlOYRxJhhb9klj0o0KFDj3
 3Wjg5K5G5hdXKS2YSL1i+pUVOEv2w16NjGCyFB3joknUnrySUzyy1Rvq1mPbHVx48+Un
 /v2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFnZsFLGQJjTUjqIgAlmyakCFv7uCgFM+vXMvQfFdTQqdWfp/e4VazsAoIbksmEiju7lrC5NSo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ziZc4rq8PxYJAeVfARuazLxTJklNhKfvAOhId4XEAYP2u86ro
 a8BxVwUenpwaAETQ2gv8CwHkcDmRoWGhR9yCQQjrxuL2FGFMo/Hqw8VhSMx337u85OE=
X-Gm-Gg: AYBFou0Fxkpco2b1mtV8S7htycoQqaHeO1mESKavKdS3luC6RGQ6DgeDyjYuzOJJexR
 hkV64xjM6xpNuSSHVzZUy+HSzW2LJvCoYF1/mQGsbZtdhIK0RKDD0W0/eSKD6ShDOQ/oDB59lTh
 JxvFVwrCxxb4JwSScc69zX2oAzO+7hWmKDmzAzVMItvv/EtxwzFpDWZ70Tbf2NWjGUxYAZ1Y78y
 gwPd7UHRb8VEgakpVYDz9tT0CE867HiX2XywQhhwG8TJ5KLBmZy57n6tN/3MVSYXwHqTN6czLZK
 sm/Ay2CHIOT/QuJI/CJWLD/s2vjc9Mn81PnA/z2e4rqzzSdy61fqW8xozpgzry0fFbnbyhmUhCQ
 UcBgJC3bxNZTtimt1nuT4cX+n7EuPbp6iZpWz7vdWWB6eeGQDiwkhqGgPbEYJIvyU0SsGk8WtOC
 otInVlAetAPpQsRYrDQuUnA9gd/uvD5+qGa5wX3P1Atkttka3pz0JQ2UZpP09Us7JFgIb9AgBbx
 1/Z4Sxkf2N9avGeecgiKXxeUxIed5TjQiRYw+55QV3mx1l9HE5Y6e5xaNlobaRKbWUeg6efAXrO
 GUpph9VBSI+oh44EayCOX+pBkGhl6zI+bNwuOtK6Domo6gQ3mHKrkk9ETnooWxxfPnpXG0l7UCX
 8t63dZIQCk7QijVvLiYxzpeR5IjYV5S9PrutBGQd9N4mppcqZjwbF21pOIffNp3DyGPJPTXEjNM
 SDTRZxmywrQpAbtAsr7Dtyj/cM4iWoxFve
X-Received: by 2002:a05:6820:7091:10b0:6e1:f7c5:9561 with SMTP id
 006d021491bc7-719179abc37mr3153328eaf.77.1794508879759; 
 Thu, 12 Nov 2026 10:41:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880e98ebsm412750a34.12.2026.11.12.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:41:19 -0800 (PST)
Date: Thu, 12 Nov 2026 12:41:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: marek.vasut+usb@mailbox.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: host: ohci/ehci: halt the controller before booting
 an OS
Message-ID: <20261112184116.GH554944@bill-the-cat>
References: <20261112182838.2792025-1-jernej.skrabec@gmail.com>
 <20261112183546.GG554944@bill-the-cat>
 <dyaPjPzbR86eIzIO25L6WA@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="THIRNKIquB6HtqJF"
Content-Disposition: inline
In-Reply-To: <dyaPjPzbR86eIzIO25L6WA@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--THIRNKIquB6HtqJF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 07:39:35PM +0100, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 12. november 2026 ob 19:35:46 Srednjeevropski standardn=
i =C4=8Das je Tom Rini napisal(a):
> > On Thu, Nov 12, 2026 at 07:28:38PM +0100, Jernej Skrabec wrote:
> >=20
> > > Currently, OHCI is not stopped before OS starts booting. This means H=
CCA
> > > is still being written into during OS boot. This may cause all sorts =
of
> > > random and hard to catch errors, if same area is being used for some
> > > other needs.
> > >=20
> > > Mark OHCI and EHCI drivers with DM_FLAG_OS_PREPARE so remove hook sto=
ps
> > > both controllers during OS boot.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >  drivers/usb/host/ehci-generic.c | 2 +-
> > >  drivers/usb/host/ohci-generic.c | 2 +-
> >=20
> > I think per:
> > commit d610f703f937ebf7681e5cc36905586666e7ceb8
> > Author: Jacob Procee <sn125164@gmail.com>
> > Date:   Thu Oct 22 18:58:08 2026 +0200
> >=20
> >     usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag
> >    =20
> >     xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
> >     controller keeps running after ExitBootServices or bootm. If a devi=
ce
> >     was enumerated by "usb start" (for example by the default preboot
> >     command for USB keyboards), the controller keeps polling it.
> >    =20
> >     On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
> >     USB device that is connected while U-Boot runs is then not detected=
 by
> >     Linux until it is unplugged and plugged back in. Running "usb stop"
> >     before booting avoids this.
> >    =20
> >     Add DM_FLAG_ACTIVE_DMA so the controller is removed, and its DMA
> >     stopped, before the handover.
> >    =20
> >     Signed-off-by: Jacob Procee <sn125164@gmail.com>
> >     Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
> >=20
> > We're preferring to use DM_FLAG_ACTIVE_DMA here instead.
>=20
> Ok, no problem. Should I respin it now or do you prefer to wait to
> potential other comments on it?

Maybe wait a day to respin? I believe Marek is happy with this as the
general solution now but I could be wrong.

--=20
Tom

--THIRNKIquB6HtqJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavYITAAKCRAr4qD1Cr/k
Cr4cAP9ewGsi367Hs3K75Uct26rP0/2ZgzR0tmWbFDmrRLJDRQEAoqQmYKIcJPsh
OfaWSQcA8wv92+/70OMfrHQD2O/gFQQ=
=D63i
-----END PGP SIGNATURE-----

--THIRNKIquB6HtqJF--
