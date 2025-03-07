Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A30AC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037F1812C8;
	Fri,  7 Mar 2025 15:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4LAcskN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C1F803CC; Fri,  7 Mar 2025 15:23:08 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AF58141E
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e6182c6d52aso1328589276.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741357380; x=1741962180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KIvYXF9emjqCuYP63hp9hk40m2VUXYGZv3p6HcXeHTk=;
 b=P4LAcskNaQkq5XWHGldyilwvqTyVnOroWFCvH4fepBeJNYQ+dJiwEnGkCdGJXgvHi7
 QZKz1L3JNSaPUGtr7vVL5+53V/gnRP7TdnsBPJkXxZospn7XB8EEzz0esOeNLcg/UPji
 ItJ3cVHC5OBTNB+1azGBJCfQqDMzzWqbgeGcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741357380; x=1741962180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIvYXF9emjqCuYP63hp9hk40m2VUXYGZv3p6HcXeHTk=;
 b=n5HM2lklx+S9I4g6QiB35KW9RPuNINyfl+ubCstiaUB2L3ILfFC/vKzQCImw92SEau
 jUR5fhh9ePgxXAtS7l8l1cHxZDljTyFfF9fppLlALUJnyiu8Fmb5aq1QE+afiMwX4c2K
 4a+nzzuDZPH6fE5N8tNjACzVnd9wq5YzppQTMe/wy+2B0+aDHqlVNGzLqGQXYDqxtJAx
 dNJpwfnG1XBfKXafycVz/mxVtshwjFsfhDlZ4++JSE3Lj99kuWL8BMYHrPTPJDEb20W/
 W5dZslB0kWW/O/5R2pCLJwhIeV1QmnkOZh1E+kezlEMAzf9i366nQi5SsqR2TSEnciAh
 caDQ==
X-Gm-Message-State: AOJu0Yw+Xl50pOcldY0Df7uc5B6p6FC4CryH4w/IwgHzrnMXDRNyqzT1
 sCaqZPgsePrer/36G8ILI2uJC0hypLYWmhvcG8oknr+GVU3qzkF44257wqPYRac=
X-Gm-Gg: ASbGncsEz7kUr6r9H0p1dat2QsecbV8uALpUY0nASmTo1pdMwL5glO5jAqmQT4gyhkq
 v9X7yZG+8Ax+n62ttmKJWzKksWUrgSAx9AOiT4SBFN2Nkhr2Tt8ThpTqFOuYfamfRVjZUUFZ9cw
 Qlw66k6IKdTSTlwPlrccAsUPZvQlpDEF4JMS1CjrGLH4I7NvljNHifQGMikJ9AdkSk7SwmT3DhS
 brpcRYLSXZ2XUq2n70XlDapdql7S4UMHBT6hT+2ZvlydzVtFG8quDzQaDZiTyLdlvKsmdKV4HWD
 tEM6CzJqH9hRmw6gZ+dIifzNko2KbtJt1ZOSSURqjlzEtw==
X-Google-Smtp-Source: AGHT+IEwfO3SCfGR8JTwnypQ7c1K8e5E9yx/FK2eyPLNbqQknJZvJqri4d1bEFPO/uS+5ug2IOkT4A==
X-Received: by 2002:a05:6902:2884:b0:e5d:e23d:5603 with SMTP id
 3f1490d57ef6-e635c1c40b8mr3531534276.38.1741357380086; 
 Fri, 07 Mar 2025 06:23:00 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b85493esm803485276.26.2025.03.07.06.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:22:59 -0800 (PST)
Date: Fri, 7 Mar 2025 08:22:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250307142255.GL2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gk0dqMtvAFAUNhfe"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
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


--gk0dqMtvAFAUNhfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>=20
> In v3 some e820 patches are included to make booting reliable and avoid
> ACPI tables being dropped. Also, several MTTR problems are addressed, to
> support memory sizes above 4GB reliably.

Do you plan to rebase the prerequisite series' this requires so that it
can be merged?

--=20
Tom

--gk0dqMtvAFAUNhfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLAT8ACgkQFHw5/5Y0
tyzWUQv/aBQH/dA1/o1urgt8WrBqX/d9HQj3wotUJRB0gsv2MH9MEumYFmfl244o
b6MIs4BwYjl7xIA7zgK0Su6qg1ltDBREahic0ykiyxcS1ytUxsZ3s0I58g9jZ2tY
mRjmJmnVqQqomeoG0d+6wpC7r56fI3CUyhbel33X3dEUgI8ZzQQCIiru0o7ZH9h2
fZNM01c9u6F41qb1rCmcMpMJlyffn1No/b2dlxPcWeRuKp7um9HExVlW1jMZCL7n
o3DvPiX3CIwof6m8GEBZ6O1U8Rq93oWfbl1f/PzUX6aO7ETYUR76w6dJ8l4a8oVb
KLXpnaBKMX7joy0QPIkfds2PJdhG4zaWIwfFvK3lx8skazaa8vqkk34m7yzDLw9M
juVt4y+o0EzxyaU7FSJlIbVn4s98nbY0pJ1W7CcRu1vfsjGiftnWrDgfi9+pBPwe
DBQJISbE6+yVz9aKjiWoz3WpcV5mgDbr0dRFq+ts5Ji4vljiBawVim1AxnGfn43v
wBNk9f2X
=2V4Y
-----END PGP SIGNATURE-----

--gk0dqMtvAFAUNhfe--
