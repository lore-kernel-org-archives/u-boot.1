Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD9C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 23:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3E0807D9;
	Tue, 11 Mar 2025 00:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hi5DbdB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3E3807D9; Tue, 11 Mar 2025 00:32:28 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150BE806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223a7065ff8so16567135ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741649539; x=1742254339; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+WOi/lq12rnNttQfCCwiIQrfl6tiFiaqUFE3xX7AZQ=;
 b=hi5DbdB5+HKq93VslRUqwag3QIhdzuQOj9ZEwkUNM7Hf05Xr/170VQpHcjQ0txLI0/
 8UdIQFjDWBLjUOaiFB6pClKCNDauiznRMV+d+744pSKZ93jtABCySoq+1Ho8nkusbYjh
 521eLq43Ju95OPavw3fW+cMO2any66/8D9yRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741649539; x=1742254339;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+WOi/lq12rnNttQfCCwiIQrfl6tiFiaqUFE3xX7AZQ=;
 b=hd1BE5L7+s8yw9uHlyv6AmuyHDdQ8PHpyTFljHqMRsO+X58cb6c1PAskvj47x3FGxV
 Np9ckXj8jZa1YfWvPRuzGA7dtN3T30ui32KK3b3txbj2qbCDVjEY/sUMN408OxUVV5nR
 IwR865TdIteqbF+chFjscakKhwDdRX06qzv6T4i/f0+Sy12UlFctd1SftBOic9zIBhsR
 IQu3+NhSRqZVRDlKBytWW0ssHM21mphR4ynLek6RhZriXxpm95bzMQSh7gcl6TlW4TiZ
 EuFWdfTNHOL724gX8W6ppWH+L8yJnM2NcqH+kmUHCj/gKvhgyPiyeQP+0IEGzvyePHVd
 P7hQ==
X-Gm-Message-State: AOJu0YwhhXUWba4/7+fcrvJ/d5wTEHPR7EZGlK2Xr4jw9vylZbVWNIhD
 9zTzOeaSw6/V69XC+gMWFxwBzUc1pBwNXUhqFZ/Wm+DFZcnq2gWxF01SRlsPlfW1bTZv3itfPXg
 w
X-Gm-Gg: ASbGncuo75qwNPshOHBkyOCy2Qc2GwsaheGC2IRG6/ks5lRZfkIQsgzIhJxCu8YGTGk
 3sKdZ+hO+6U3c8XqZJ4kzKN1yt9GlFiZQh/KFkeDeL1nTPraQpsaHBCZCq4Ly6tHmFR0gzUgx62
 7Zy1x0442yh/QCSeGtcwiih2aruQlfnIpQ2qvXQjC2IaiOcDno7qd+vM5fAYauPomYJVeut2coz
 t3Rifv9qhepGXMPsWv8Hb5NhPuI1BYXj2tR8TFjtOLwBZb7X73xiefZTeFrvuSRQjydQdv07jNW
 EOy19cxMVxIXOYk90gNd32iCpfHU1SbbF9QP4eC9S0tDow==
X-Google-Smtp-Source: AGHT+IHx7R8qDl9Q1zO84qoduETjOSoNbWoSfIpF6/2rKdeYS87yQyJOKRF4O9a7rYQ2g5VLoLvscg==
X-Received: by 2002:a05:6a00:3c87:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-736aaad21dfmr22971829b3a.21.1741649539494; 
 Mon, 10 Mar 2025 16:32:19 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af287c2d533sm7757964a12.23.2025.03.10.16.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 16:32:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:32:15 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04-rc4 released
Message-ID: <20250310233215.GP2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jYk3LPhd5hCrx+g2"
Content-Disposition: inline
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


--jYk3LPhd5hCrx+g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. This will
be merged to -next shortly.

Continuing on with what I started after the -rc1 release, we had a call
today and the link was
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
March 11th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

Repeating what I said on the -rc3 release,
I've been looking in to seeing how we could get modern project
governance setup and some umbrella organization to handle financial
matters, etc. To that end, I've been talking with the Software Freedom
Conservancy (https://sfconservancy.org/) and they'll be on the call
tomorrow as well to answer any questions people have.

In terms of a changelog,=20
git log --merges v2025.04-rc3..v2025.04-rc4
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I plan to have one more rc after this and then the final release will be
07 April 2025.

Thanks all!

--=20
Tom

--jYk3LPhd5hCrx+g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPdn8ACgkQFHw5/5Y0
tyz++AwAiZ3ozANxfa1LjBLNIlAkqUGGwgDLmmpQhSbf7t5J45fWh/Ht/WuEWraP
4J9AUZv5+znedBVVfdbpEtchZrkLy+5iE68IdBL8CjFXzlVT4UkiENhDtN71n9R3
TiZOR0qqpVB7QR1Sg4OrjKJo0DvumFR9kWFwjfyKm8emJPBkub5tZMqfvhyOhZRF
2AOK5kNUgvhFHlRfDY92VsFsIOE2aRXXCOqk5FTH4ej4kGzX949F9lsfuIKfBM94
gSWPMSNPG8hG3NYSJUFKyOM9qRLpJkqSCuz6opN/ISuoc2E8GSVJ15F1HbZr9+ya
R0tysEQfFvGc+w10XPNLzLikt2Eeo32D/YFd31Fu38RLZpBTUImbigdJbm6Qb6jA
UCEjHsEE5xr4sj5t0uixbKC1xR65OOCJhnQukTlPbmw2nUcp15fnISi24yGES8Yj
LifEw/5XY+K1l5tVJLQRl051fkO54LTAG5VqmHPN1P3lwASc3nGZdmrS4I55c+ui
k46AmnTp
=6xRn
-----END PGP SIGNATURE-----

--jYk3LPhd5hCrx+g2--
