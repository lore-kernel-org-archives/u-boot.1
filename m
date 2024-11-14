Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B8BD6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA0888B99;
	Thu, 14 Nov 2024 19:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GD4ym6RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4449588CEC; Thu, 14 Nov 2024 19:59:41 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C689B88606
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-851f5d3001fso408161241.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731610777; x=1732215577; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LmyaJTy0P0D0Xkyj/Ucld+TRFm4Kl/uDXkKb7tYsPFc=;
 b=GD4ym6RWzGHMXntCQnRFgNgeV+Ff6cL9IxGlCF9NnGBKtJ3bJghcsVcUqrowFSpAIF
 K5uCbe+t89mcY5p3EiAnhtjRr3Iy7Gu2N2B56FQ7DyPhbfFClU+NujTS9OBdDi/RjtKt
 gfqVkNuGJDnClraHOIJ6azjYbhEX1X9oAVlDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610777; x=1732215577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmyaJTy0P0D0Xkyj/Ucld+TRFm4Kl/uDXkKb7tYsPFc=;
 b=Y5WrGlEKOM/8Dif1rLiLz5bexTkk9RvbXpTrZnvaHe22B+9Ppl6waBrTc27jEgslWT
 BhzkxzTdChcrdTqWKk6EvZj1LGpKZSeg8xQ8aSg4YNwu6IZyP4ml7+vunXWMi+8sAQlG
 rxDu+mDXO6S5VDVzIGQk2cKTMpUZ8aa6Ym7q7LT7KYc482ImHD04ypJyk6ZcMcBclG0e
 lwoz2GwPR9AVwNWY8SaNVKm7ZCAmWdovssUMRsc/IxjY9sn+dQO+IbAFJeF/bjODroHM
 2CDlQHWhJGydzbCeJ1IgXvIFdSNETq1hscIttVWiqhlU6hRvJukEv/zg27ewk8Fm6R3H
 hayQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0W7+/jGL3i4Va1lwN/EF8/C+qVDBh/JVUfpByu1ehIav7tJQyPgAEV51dx//M/kACJK5ZfYM=@lists.denx.de
X-Gm-Message-State: AOJu0YyhYJWmTN8LBOoEdPZXyTiLzLkZ9GDv2u3GCRSZPnl0KLEqdFS+
 C3006MDYkef6Q3iRMmPjQd9DdsHjBG4cLJQ1m7W8XAWLd4LPriAqpPFdxo39Pe0=
X-Google-Smtp-Source: AGHT+IHCVeJCTCdL5GKp5pegN395jvV0QZcNOEVuLTh492zzOzcKoViKi/ueSlMPot8LqhmcZD8RHQ==
X-Received: by 2002:a05:6102:50ac:b0:4a4:8fc3:9b7 with SMTP id
 ada2fe7eead31-4ad62b9073bmr193946137.14.1731610777586; 
 Thu, 14 Nov 2024 10:59:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c99d7ebsm78486985a.35.2024.11.14.10.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:59:36 -0800 (PST)
Date: Thu, 14 Nov 2024 12:59:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20241113
Message-ID: <20241114185933.GL3600562@bill-the-cat>
References: <6d6d1630-838b-460b-ac4f-1c4923bfb40b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oK9y9Wdc7YaOm40N"
Content-Disposition: inline
In-Reply-To: <6d6d1630-838b-460b-ac4f-1c4923bfb40b@linaro.org>
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


--oK9y9Wdc7YaOm40N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 06:45:23PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Here's a small fix for khadas-vim3{l} android config, and a drop of
> obsolete dtsi and include bindings in favor or the upstream ones.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function=
 calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20241113
>=20
> for you to fetch changes up to 1cdb4e03e684d94456dee0cc30c935d7e25b263d:
>=20
>   dt-bindings: interrupt-controller: remove arm-gic.h from include/ (2024=
-11-13 17:25:07 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--oK9y9Wdc7YaOm40N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2SI4ACgkQFHw5/5Y0
tywYUQv6A5GLwvO2YgrKax6PHubBrhnF+OqcJnDUDnkb+oc4y+u5wttgR+jZf3aL
Zj2KpDGuKzPKYzQS7+ufJW9l7h37IHiEFd7evwLt/LziMu0rRYc0wjxz57ov+6cq
ZCgakI2th9pjFAR6zj+iRfARVJafAuB/oNL1wS0skzt4tgyPITrR5KA6DkcqB5Je
lynYPqcQxBM/9J6KDqtKxjqsC9Q3uWHm3NzG/eE+Oe/jYIcOCP2UYdc+Q2AiFYaa
DaoR4FjB5dQj+vvPiYWtkGd1V9wLPF9hOQy28tQC9fkS0KJ/tSit+LFahbULPYWL
o05XQ0+aeAUnsgl76lh5CtkJ0iNNM5UqlSfbPDTPKQ/PIRJwk0ZvmV18rx0S8avY
s2KIlctRRnmrJ3B7RQ2bnaZWr5oJOpQCs+OJg5ZdZdSHNXaypGqP1lT9DtqcnAIn
WF48Unx8efSx32QQ4YK0eNDPNBFOkZAkqdzSr8u4Nvt0umKcyFu84u9h7956jSot
QEwZlGMr
=7nJ7
-----END PGP SIGNATURE-----

--oK9y9Wdc7YaOm40N--
