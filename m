Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A4C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 15:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F1D8129B;
	Mon, 21 Apr 2025 17:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IkHcrcK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247B6812BC; Mon, 21 Apr 2025 17:30:49 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2AA81273
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 17:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so2118148fac.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745249445; x=1745854245; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5KQJMNiJ1E/s1e7pihPIY1MEjsPLw5t7x9Dhg5k6C8=;
 b=IkHcrcK2trZmDxLolrkPFA6NpQB3xenolcJ+o/DLyeVWGevdGWx3UFig/V38kwsGsQ
 yTSzMwUAVlo5Mh6DsUvfOsv6x+u/U1d3RqmxpTpGWQZz4dGgxdukm6UyN1u25DUeYrEY
 21LCSJ5bXGmopZ5kDIhcKpO8+D+kLIHonU9z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745249445; x=1745854245;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l5KQJMNiJ1E/s1e7pihPIY1MEjsPLw5t7x9Dhg5k6C8=;
 b=Ewx37EZlLb4w7lj+8M8JhTj61FYEw7JmdlMQbbM97Fe6kCJnnKZ7RCiUkeKSz6niFd
 dJYBjlUNwuVAfk1A5tPB6zSuo6JHfrZC2e+LgJDRLfkINoti1tlf6G+VzvRG7A4TC6tx
 YUFgB6A7Gnnqs22BSGxMDf6EV9fZSBn2HLBAc6yzthuUcAGyzcRK6QyoK/U3jHOSlvUo
 /g+N+SLs0kNkLCCZbr7/iAc/zx0kgyZQkDxH9/anZ92uxifLD/a9LZrl4cKwFF0CIwa0
 67ePKuXE9B6ir5Ft1bzfwDDV99bp3Sv6MajxcL4gI4iWwRpETr0X4Ar5jzdlw8gXb1/3
 twEw==
X-Gm-Message-State: AOJu0YxWHS/A0tCHhtgmaILe3n9iECqDGXRml0G3hj8QKrO6ym8dE56G
 Ac+MqTom5TtwC5ZS1dApq1ynALhLjhDpk4tiniOml3492XWZlUq0VtdwCclKb1nhwmi05bw9z5k
 p
X-Gm-Gg: ASbGnctoFFzGcZmi83NiR1pVfmgKzfRfXJjFxoXD+IYpNJIvgnlLcwNTpnV8TazBoo3
 BIn4l7DtGjLK16UxfKWQGjbr9V74J10UHTDMt0J9oGyNXvjEjYaty9DSvyBdyl2a9VGZ1v5obHa
 7O+1O8JjsgDRujkosFdVV4SykT5f+qKCIMPbjltj6DFjh4B+Q5AZ+Y1IiWBP20O9/z+BB6ZaSqD
 eixxIkDAwFmF3846N1HLjH5oXlL5cRH+euvE36DWjf0aqmdljdAX/UOX74JLsnzh9NYp8xyefVO
 gVINhaLRLNx4nWOtphlJT0vXGz7bZwmaVudRENhsnY1rf5T2W8eeq5k8yzAqXmAc1ErseyOs9he
 K2gqscKMNI9lG
X-Google-Smtp-Source: AGHT+IHdHUVcyFZP4PgvsksLD7yjl2BQv4+7MI7y1yW2gr/HxmaNcxMfpwZ8qdumS0yFWGCVY1rBTQ==
X-Received: by 2002:a05:6870:9c87:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2d526d5690amr6377011fac.30.1745249445294; 
 Mon, 21 Apr 2025 08:30:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d5a3607ffbsm434125fac.50.2025.04.21.08.30.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 08:30:44 -0700 (PDT)
Date: Mon, 21 Apr 2025 09:30:42 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Community meeting tomorrow (22 April 2025)
Message-ID: <20250421153042.GW5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zIvv9UBDUDV/hdFr"
Content-Disposition: inline
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


--zIvv9UBDUDV/hdFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As a reminder we're having the next community meeting tomorrow. The
details are the same as always:
https://meet.google.com/btj-wgcg-euw and the calendar link on
https://www.u-boot.org/ and the dail-in numbers are at:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D3D1307528552322&hs=3D3D1

The meeting will be on Tuesday, April 22nd at 9am (-0600).

This is slightly off-schedule in that merge window is 3 weeks and
release canidates are a two week cadence. Last call it was suggested
that we have a meeting mid-merge window.

--=20
Tom

--zIvv9UBDUDV/hdFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgGZJoACgkQFHw5/5Y0
tyxJnQv8Dk7zYnGiO/RfVllAeenv39nldtUTZnVGqYBmPzF/efNu2aajNBHKnr1C
oezLg7Kbsy+mcCo4Q7qVJVp2jAfAMmenU1X6I5P8fRBy2h3lUbDDh4VZVWtCyaYd
N+nFtA5vXPfnAqNyI7bCNGmOn4LYcdIRhv36gBngszzQu7UTI+7xy+tvZs3XGb00
Wu93JdNegCceoNK35fuyPS00gbelWoTB3gXGaaVgvFfdBerTUrYDsH5R4WUnNJ2Q
J1tvC2l0tBMSiB4kfvn5c19STWsh9Ycj3ZPlWkNveNMATzlQuFx6BzBKByQM3H26
cvQMJVYsxPzbZ3PRhDIt35++9mjECsSI61Sq9rJ4L4eXtjVVoDc6DxflhlpOuu5z
/1XXljvz3GS+BjLFO+P9ywmRadEfaKwluAOypuCx+zfn6EMWn5m4PDbFTUVvNu3I
oAE06pu2eGnYS9EygW4ZNCyXU4I0W8MWASwyPf7LFKOhRcbI4+fCaTechCtXn52p
Ntanb9cu
=Onco
-----END PGP SIGNATURE-----

--zIvv9UBDUDV/hdFr--
