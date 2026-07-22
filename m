Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64145C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 22:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22345608C9;
	Wed, 22 Jul 2026 22:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U28mQtZl2c6k; Wed, 22 Jul 2026 22:01:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FEB1608C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784757694;
	bh=yX4511rpLxUCtkLc/uq96JbmNK6+MZzI6fWVc43Mwn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYajnpDPlnf6YVs+MHwYVrnghHHpDSWqqP4/zm8Ic5QgClQNX4lO9jJW+ZYzBWNop
	 cmPjTHVVrWg8JmpXSI7yX2EAcgMiDH7m9nps9eVi76JEDYH8tG22AXRYWuxY8s37g4
	 BkZ4TXRHlV2YoRISMEfcy1YpgeWk8S8n6Y5BcqcRy+IM+61Xkk7S47l+CVMX+Ssm0+
	 sWN9eyXDDhL9zRpv0lCcm/lTS7uMJP8K6lKC7VPa7z4o5YYr+ucHOoRGHrHP6H26FB
	 fYnBDuV4oJs8jFhxjrc2N8mZceBUWRlIvYPVkEpbUkrrYO1ogUWcA/X3/+9FUTP8WJ
	 j7JncoEQu4WRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FEB1608C2;
	Wed, 22 Jul 2026 22:01:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4797DEB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DAD640186
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUfpUhJQVSRU for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 22:01:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0DFA240082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DFA240082
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DFA240082
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:01:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052F18404D; Thu, 23 Jul 2026 00:01:30 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FA683E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:01:25 +0200 (CEST)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb4d532e65so5055753a34.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784757684; x=1785362484;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yX4511rpLxUCtkLc/uq96JbmNK6+MZzI6fWVc43Mwn8=;
 b=n+3TI7+sF3KnAjjf1iD7fGTFyzLXlCDBlbGOkvcPuYun7adi5H3fJXnVvk5sQe30xY
 tVdlawYQscxfzg9TfwJvXfsPDUAG983VoRrZ1zbRQIMn5dKrxeXmsgxHjgp79ThqMpYW
 WGaYJgbslr+mPBBEvm6ixARaC9IzBSBQeuOjoE7HD0WfPhhGnuMD/iT12w4/xBzxljhC
 SixWd4hR1ute/dJiBVhJrlhhZ6KUVYAmDxJIvyPRB3yLKNNm/R8klY3iQ3BlfRaTL+kw
 A6I9hfEaE1dL5+YVZfcous/u6MloxA8fra9dpewj7wbk8ZxBukEn1Uw/5xUBPDTRkmOw
 e0Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBXLkETtyq4+nk+E24izWmK39SvUs6I3IvH8kO+PFFZBpPCRvMnmtYEmsMw4qMLBBjrYus0pU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3wYzT+5q74Egkc5ZO5acR58JW++UcsVOLsFVE5hsn0VwV9vdB
 rbaNCympepd48/yOaBsfHQ5brTdyWQxT5FSJd6FUFCcd2F3AICQ68rItZpG4bHAXnGguFglR/+z
 1OljIkN0=
X-Gm-Gg: AR+sD12fp8U0bK21so2/X//cHKa6ZnuOfG8tzUEkEIP5xguhiL8AA2urjqguC5TNsOc
 fUmnmAVrXpiRFAjXiNZR+EdsUHGxUp/Xr78EJHpAS2g8ncvbQjjj9RWc7l4PG/nwKfETjWb7Q+Z
 MPg1AhGVcsYKJTxU5Vz6dGYY65EY/oUkxUU9U23fEYjcYTueQ44aqK9zj1i5gIzb/KHdCy1pD7C
 sAJ78+2vBzsUje/BUw1JKJzuj8qKuf1uYVOE37Iek4s0b83MBAyL2935rg5WaxXJRyj7Nq6vjmS
 0GqLPCjXsPLKmICI9zryGiNFBSKTe+9WS/u11ikEQ+pgo7LrkxQZIIaB96/LNNc6MO+v/Y9J8OZ
 S6jQ+7ZBfUfe+WfIdYt9PxiDH1SgEDS1Tt4wuIt+7YA70JgkafYJHc3FGzfpJ9hzUPyCV8ig2eB
 XXpDfqOs1QLs76+rk7+I1GzAQUJKBx+Ix5AhyfwMX483SVPGr9+9iz5V2/7rjos3T93AaQ9mAQ5
 E/ojv+EbOyP6BXNVnYK2urw618=
X-Received: by 2002:a05:6830:4182:b0:7e9:b4d0:53a9 with SMTP id
 46e09a7af769-7ee44209175mr370154a34.26.1784757683629; 
 Wed, 22 Jul 2026 15:01:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a03d1besm2114671a34.14.2026.07.22.15.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 15:01:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:01:20 -0600
From: Tom Rini <trini@konsulko.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260722220120.GZ749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
 <20260720222158.GL749385@bill-the-cat>
 <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
 <20260721135414.GR749385@bill-the-cat>
 <alpine.DEB.2.21.2607211504130.14485@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vAcpCXaO0Abo0OsT"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2607211504130.14485@angie.orcam.me.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784757684; x=1785362484; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yX4511rpLxUCtkLc/uq96JbmNK6+MZzI6fWVc43Mwn8=;
 b=B9sDz3UiEJMnFoNor2cycd2j80GcP/IbsuTG4WMM8Gvc8svG6bu2LlvQtUBiVb4Mew
 FS1DzeIFFfxJvS3Izam7jgoGi+f8ZPMgkJfemNKnL99zNf8D4Ez21TmQz16y6+85YiO1
 j2P5eqWKNqMV5FHQ0ivUwmO7xexiQrkVmlp2s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=B9sDz3Ui
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B9sDz3Ui";
 dkim-atps=neutral
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


--vAcpCXaO0Abo0OsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 03:29:23PM +0100, Maciej W. Rozycki wrote:
> On Tue, 21 Jul 2026, Tom Rini wrote:
>=20
> > >  That's going to break patch submissions, isn't it?
> >=20
> > Looks like it's working:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260721063050.18756-1=
-dinesh.maniyam@altera.com/
>=20
>  It breaks for `git am' though, such as for picking up patches directly=
=20
> from the mailing list via the MUA (hmm, why hasn't this particular patch=
=20
> arrive here?).  There are other issues with the rewrite, such as the=20
> inability to sort messages by authors in the mailbox, but the former is=
=20
> possibly the most painful.
>=20
> > Not my favorite that it's going to have "... via U-Boot" in patchwork
> > only. And we already have "... via B4 Relay" in others. We aren't the
> > only project OSU OSL is hosting mailman for, so I'd assume this is a
> > solved problem.
>=20
>  Yep, GNU toolchain lists I'm on that are used for patch distribution=20
> (such as <binutils@sourceware,org>, <gcc-patches@gcc.gnu.org>, but not=20
> <gcc-help@gcc.gnu.org>) simply disabled such rewriting, after numerous=20
> discussions (not sure what OSU OSL is though).
>=20
>  Up to you to decide, I just wanted to share my concern.

So, thank you both, Maciej and Mark for bringing this up. I relayed this
back to OSU OSL again and it was indeed really a misconfiguration on the
migration and not a policy that we had to keep. It's now been fixed.

--=20
Tom

--vAcpCXaO0Abo0OsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamE9rAAKCRAr4qD1Cr/k
CpLUAP4zf9jeopSAQsfDw3dc12e19HTfnlZIStlJVkjG9nV0eQD/QTnmPnHhnYPd
D27rl/FNkUoA6p+ktp1pmT6pfIEeZwQ=
=vtR9
-----END PGP SIGNATURE-----

--vAcpCXaO0Abo0OsT--
