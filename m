Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A372C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48B4A80B22;
	Tue,  1 Sep 2026 14:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yR9GUo6j53y; Tue,  1 Sep 2026 14:03:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788271412;
	bh=wFn9hdKeRYzQB3fQ5QQ3L3r/kF/BLjuwKyDUZMpBrH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VM9UuPlRNhDumGI1/EHgaM2kTtRMS9De51S6GO//22GeReTLjhdCasAX7KNV0zaYy
	 tPM3mg0eBXW4V9Bp9dsXIDrarx/l7TzLsbiVxMjO7h45uwm/5uQWjrpis/62Qn8qgL
	 lyth2NSvcGyY9PXGbzskCMToRQIdMgdPbV3ePu2/IqH4e1B53bVKCrFRFmQFQD/asV
	 znWDVJlEkpjD6CPOL2ge9o3XByL2Q55S3gWhhck71t3H/GZ1K/Bl9ZDxiLyMwFqjzX
	 hXZgBGVqOUium7+lHjLqqvULQDPKfHdC9hYMAfzTFIBYrBDEHyD+hrddoByARt347B
	 iKSGUXARRRzKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F00180AE6;
	Tue,  1 Sep 2026 14:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26309265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17FB240640
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eeskcDGdv5qa for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:03:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U1rA0qza
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5201A40641
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:03:29 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6b31010a387so669204eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788271409; x=1788876209;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFn9hdKeRYzQB3fQ5QQ3L3r/kF/BLjuwKyDUZMpBrH0=;
 b=U1rA0qzaQUnGNAZqDdPRe7TIqUOHrlBCB1p4TJrQbqbJ2zGVVRYnfcbrvuuYcyQqQH
 6YHmyQMvjPm2G25DoMb8GE9eDie/gbaxoJ1vkaRxewZpAGGCmkyIIgbErC5m3wizwN3F
 UhzLBlfNkkrIPVUDiFVCz+RBmjbexJqq2zEUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271409; x=1788876209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFn9hdKeRYzQB3fQ5QQ3L3r/kF/BLjuwKyDUZMpBrH0=;
 b=W/gP/mc/2crjcajGRVgyN+gYN0iMa/EhRWHbitDkmj+eRlW7mgaBfBjIWy3ynT+bS1
 bK4DX7pIVlwQIYyFgm/gTgbZqoCIBoASY2cFHy8jttmWD/FsUjXb8ZrY2uh01jBCIp6U
 fcxFqfUTEWz01bWH6iFnXgzdwoo1DVWrzkc3Q7/H9B+CF7O5Wrytk5dhghaG5tUSWxUf
 Z+5pCf0lFMbcCPX8OLRR02P0DZXW9gBKTOVbL4HsDq8E4KFVXjDk70Lm+hdY8MbuT0Q7
 vChpvph1hSjlGizqaH46zNlFJUlwB+bS456N82OhHKXfycj2VzkUGdRsk5mAaX2K/NiW
 hBhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou/21assipfmj9OhcFOUKyoL041360kQhDaLvwG1LSIR5RyIv58kSxFySCdGnZzbhn9HSwsvo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mKXt4ihpv2y1OdohUwqTXP2Am8tSC1u03En3LtruJfjwwa7SjZ
 4NWBnrZj8XjCIVWod9FJ2mMoueWJkG83sU15cOsLiITLas5s+M+31PITas4Lu1Of6BI=
X-Gm-Gg: AR+sD13kmKq+hnI2XrWmemDGGPODjtGfdoT+gtoKzfUfjhJ88XwzYy0VdVa9IqE0IV3
 xNo8QA9SsEMUEi8Y+SZwYyNyqWsPOaTFQMQ0CEDtPGoLKQrzWmwYHzdBK6nHR0wSa6vZMypBtb7
 DlPDLaOCHC9VGzrvc1Bg0PMqVz5jQkWM9UtIyB0iCs9W0nj8pq+YUL+R/5NHIig5NoaKM+38um/
 L0YHp097dCZ/r81lsN6lzNTZF6FzeJdA59CG6JccNQR69ER+p5xb9hgpJ77Brfz9xIIVDotCgKB
 MuwwsEznDHZYFKTaJwRZRpkdPYHKUt8SBzkALWDIHo3cg3qcAxb5SbQDlXjRXb/zHtVDqfFGz/j
 ucXslDh1Sm5+heodRGupUca9VWs0YQJ/PoehRS9NewiLGIIX4QnNs62kmgs8i2Odk6xhqEjRbsj
 hBcIfY+6rHkYOGjMMgkAfARdB7JeCpv6SviaNFOAIkKxWgA4cyuLqQqrppYQHcNHXUWECbGfPZb
 1E1EuP/ZI1iPq+bBRHCR9NTvakvFX+afRIvVgrTvEvfe7N1cid6tcFjYFJo7VkkBy/ZCaYSv0og
 rQJCddiIaQ==
X-Received: by 2002:a05:6820:1611:b0:6b1:2a4a:ca8f with SMTP id
 006d021491bc7-6b3786611f0mr3754955eaf.10.1788271408597; 
 Tue, 01 Sep 2026 07:03:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce160533sm12853450eaf.8.2026.09.01.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:03:27 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:03:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: naveen.osdev@gmail.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] bootstage: fix unchecked malloc and undersized buffer in
 bootstage_mark_code()
Message-ID: <20260901140325.GD1145425@bill-the-cat>
References: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
 <CAFLszTi+xSGKG7pmjJ+z0KKRPRXht9h81AUx9tX10SwvhNS=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ieBazTnf4vZCq+zo"
Content-Disposition: inline
In-Reply-To: <CAFLszTi+xSGKG7pmjJ+z0KKRPRXht9h81AUx9tX10SwvhNS=gQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ieBazTnf4vZCq+zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 07:47:36AM -0600, Simon Glass wrote:
> Hi Naveen,
>=20
> On 2026-09-01T10:23:25, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> w=
rote:
> > bootstage: fix unchecked malloc and undersized buffer in bootstage_mark=
_code()
> >
> > bootstage_mark_code() allocated the label buffer without checking the
> > result and then dereferenced it, risking a NULL pointer crash on
> > allocation failure. The length calculation also failed to account for
> > the "," and ": " separators emitted by the snprintf() calls, so the
> > assembled string could be silently truncated. Additionally, when file
> > and func are NULL and linenum is -1, the buffer was passed on
> > uninitialized.
>=20
> Please rewrite in present tense per U-Boot / Linux convention, e.g.
> 'allocates the label buffer without checking the result', 'fails to
> account for', 'is passed on uninitialised'. This patch aims to change
> the current code.

Hi Simon,

As I said the other day, please stop telling people to rewrite their
commit messages when it's already clear and understandable. This simply
leads to confusion and frustration among our contributors.

--=20
Tom

--ieBazTnf4vZCq+zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapbbJgAKCRAr4qD1Cr/k
CjOuAQC2hwRtNtgHuZ6O+mjP/DtetFPBX7tGAlKjARBlWJjOpQEAmAtP0LPT8J9B
DAtYnCphRMlFN/YKXGu8uGaZUlVIrw0=
=prXs
-----END PGP SIGNATURE-----

--ieBazTnf4vZCq+zo--
