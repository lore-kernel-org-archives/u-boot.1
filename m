Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E7CC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 21:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A6A80FF7;
	Thu, 13 Mar 2025 22:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NCyVomqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F406810E8; Thu, 13 Mar 2025 22:22:37 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FF880756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 22:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c04df48a5bso138109185a.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741900954; x=1742505754; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j71dXX/2MuG+OeNOSkeCq3G+a5vl6KlbAlMRfjL4jms=;
 b=NCyVomqnT6ugnB6vWpKhFnYWIfM42y/al+XchyaDEUjqA90X2N26mz0Zji3RmhWoqc
 GHqxdLDbZCRMgyaJWWd8+Ooz2vqXnGNDH/I3WnkwvL2uSMWg0rpdvftEln244ouVKLJp
 +TzSGQJuouDWaUrYjzZT1+9RxGnPrU/hKiKVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741900954; x=1742505754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j71dXX/2MuG+OeNOSkeCq3G+a5vl6KlbAlMRfjL4jms=;
 b=DfqyqPJoeqRiSOurQzlVkEFqlVjH0xNLmhEfZIntBfeEM51nso2c1ryVYaQtZXfKvd
 jIuyRMVndSeVY0m6rp47nNDlX2mQFmkO1Qlw6Zo15Hp4sJceCF9FSKV8mkc0i+LwSIqq
 fdHnDlAlf/vex6ExXsJy1Ndphl4ZA9ljnCwqSS9T/AjRyXyIo7J0JrfxKV9HaPzepMtc
 rRJmh7JK1SVjc39sdh5nfHFaZOlNvhr9j8FZfBrnKWkfFp1Qpz+nrKx9VIQ77EUD5CzI
 f1SMnoxp2Yz3UjT8j7U2cuH/1lIXRXpPu2z7Nu33+yDUQJj/tLDYx/zJ5zrTgCQWJsg/
 Jqbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlsFNGRMb1lWyoeFzyHurzhkyr46eqf0ONDZXv69ljaESXqnIoUh3ETgvbhOi2YjOH7NEBIMo=@lists.denx.de
X-Gm-Message-State: AOJu0YzBNmCW+QLjBAvf+ThOOmuM5tlpTGR+s2f6bdKARdEHkwtcZhxk
 W7rzkX8KTaPp3GMBb32jYyNqVOWPozcqfCIDyVl4NZUtIM9+NC9+PUVvefE/q+c5Kb5o9dHqcXD
 +
X-Gm-Gg: ASbGnctyh4WipfyvkIyf5P39bj1LgLiYue80sZXkMqZ0G8kTuQfpbNqha30mUzXcqzT
 boNqKzLKjxUTw52jCTvnnz1GYCCdPcK6Vudi7YzOV7omeHTJNw/a1jmfZztbRyDmDG4oFOKka49
 u9NA4xcA5/f9MkBL3ZVox18wwye33RaIsRJNtIp7engBGV6sZ76Jp+5rq6RKFNzv/Ztcw3cVWAx
 xSq/FdLvXpyJm+8yWDe6wg6q71cxvz67y7axDDxd/KC2s5YpvSPMeXBMmnlQzMmiL/laIKR4zHM
 c9/JiVZxfXu3gwk2g1jklR+KQXmXWReETL/nbf+MHAY1JQ==
X-Google-Smtp-Source: AGHT+IE2K1r/wy8VnuTPgInrlVDeUdlbDvLrGMQzHBtnmTcxuk5aHiVe65H2YC0g48U3p7VjH4F2nw==
X-Received: by 2002:a05:620a:8810:b0:7c5:3ca5:58fe with SMTP id
 af79cd13be357-7c579eec857mr200651685a.22.1741900954080; 
 Thu, 13 Mar 2025 14:22:34 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4f4easm146759285a.7.2025.03.13.14.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:22:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:22:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@dh-electronics.com
Subject: Re: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6
 DHCOM DRC02
Message-ID: <20250313212230.GK2640854@bill-the-cat>
References: <20250311013430.510151-1-marex@denx.de>
 <CAOMZO5BuSS7Q2h_GOOkhcDyH4UNibe9FJHvHBmB8z+Qy9ZJP3A@mail.gmail.com>
 <da9bee03-b143-4d94-90c3-4e7a08a26e62@denx.de>
 <CAOMZO5DBWfNR2wx1fLbRWX4jjsZ2Nuqt+RQaKqHqhMi=x2b6XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k3cwLBbWB35zTegx"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DBWfNR2wx1fLbRWX4jjsZ2Nuqt+RQaKqHqhMi=x2b6XA@mail.gmail.com>
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


--k3cwLBbWB35zTegx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 06:10:07PM -0300, Fabio Estevam wrote:
> On Thu, Mar 13, 2025 at 5:06=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>=20
> > This is a bugfix, so should be master.
>=20
> Tom, could you apply this one directly to master?

OK.

--=20
Tom

--k3cwLBbWB35zTegx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTTI8ACgkQFHw5/5Y0
tyyikAv9Fbm5YkBX8DpIqCe0a241c/HaosJnoqZmTJVW9spg5ZoH3fu7SvaVrlFn
0CyRFn0IPglKQCk2NRdDlkA8orlnaWOnR8gGA73yieFD4XKpbH9rj5ea3WcbZift
ppMBI23f6ZGeLo/cpZQcIeeVTgh6YKxG+CELQGUWc8mC7bP0rAV5Sy/SiGfK9DXF
eUuZ9gXxqwd1IigkkMIXNe8+pFCmSxz1vc6/VAQ82nDqyyAsjL1rU4QE5eQMBU91
KYSLSeYPMw5k+e9SPV8/kXCxODap2OIP2P5D9I1gcMeloFyFjXqzW5cqedDeGopd
u1RIdZuBt9G2M9cQmPS/tVOJ9rVI8RS6JAoi9pz5JukAeTLRS74ikZkoLPo7BZSf
jdflXuGomGqkKKtb7vpozvlbg20l9ymHpQHrCTTEfKCindr+uwVN8lltS3CnQtom
qmsZx7TcLRj8fUGutzRR/QtAf6+BYhZacNaaozMjOA177NtUiM2bdW2H7RrDsnrG
yPhkk+mq
=JE5Q
-----END PGP SIGNATURE-----

--k3cwLBbWB35zTegx--
