Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48761E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 22:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BCB805D5;
	Mon,  6 Jan 2025 23:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hwuqyjZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7E3805F7; Mon,  6 Jan 2025 23:23:22 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425748058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 23:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46788c32a69so7875451cf.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736202199; x=1736806999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uf0twyOZ5hlPpkTD+XG1A3roIkFfHo4EbY4fh3N3D40=;
 b=hwuqyjZxppCAQvRAfHHKXgd+PRKh+Q0726PmgAMGu1+R/tLST+yr09CATMxck1M/kP
 IXUQJDhykMGpQwRE+dWb0cD0hF+dWX+ZlD6w/pJp9pJ07b1kkicIb5N3cqwPRfMXfWSg
 C+viIs4XN3OktoKa+GWd/cJCIGBcSZ+BTcGH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736202199; x=1736806999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf0twyOZ5hlPpkTD+XG1A3roIkFfHo4EbY4fh3N3D40=;
 b=JPZOe48HgUZ5QO1u07/nbz16rERpg4mfBckfVB/ntmrdmzJDn6LQgJFmpUE/5yEB1o
 RWgDf/Jt52yhy2O41fp6cKMz7YXN/evxPrw0K6gFIiyVcVwoESv2KZx3slP1Vun/DmZS
 Nug/BjSne/9CYXXlzUpaFB+m1Dv8z2WNhOLPb/k38YB2G3qjogfutTE/M1xkgweQT+nq
 FI5CB3nIga1vqZ2teKNY+KW6OmQw6eqpNWmQ1th+5nEinnZTe840tga5eLmbk9YjHP41
 CoQA1XwWhOIR8X0tXgYMUY9mtFREd5viVygKLi0SlMlaA/9CTgJnuY8rwo4OYf0niu3l
 BLMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFonG4JLpWJg+zc3B/wn9LbRQ4DE5PVRUGsYLdTiD7TQ7SnHEhbNO3nXfCDiCo1CttBcMD9mU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywmh3srGjaj0r5Be07uSPP/t2HJnWojc8lwk5b1ucwolx70c683
 4c4doPcsRBzLognFzu3B5u1FzEyCvZaPjmiKj49DLVjl9eFumIkYfPv67tC+nPaIfpzyrC2KkjT
 d
X-Gm-Gg: ASbGncvY3fhSsMDJtCZPaldRRftiuMte6UoHisGE9cNI+Rzi6UN75nOb9VDfBlX1UiO
 AERisTUvxHCt/TLA8BC+qviyhRrDJXrxyZ5SuXhexpkRzoUd3x7z/qSbdLSwMkkcVqebJbmJc3G
 s8ckLAEMec65HaJCyVYd5EPSvjSuMWaVnOkcfeI8vo7TDb/nmDjRvBvLT7GE8dLTAggwi7A1/fz
 BGwcKqrKraQqsvfcKMb+geqz0kmcSr1ru1I9I1QJ9slyVJdb8R1tTM=
X-Google-Smtp-Source: AGHT+IEgFpYv6knXiehl87z+9Gga6DFVhu4cO1zMFk4Fr2ktrcC/Y/n+fwLkr1B6kjQWUiAtheiYQw==
X-Received: by 2002:ac8:7e8f:0:b0:467:5836:a9b with SMTP id
 d75a77b69052e-46a4a8cc47bmr901510031cf.15.1736202199081; 
 Mon, 06 Jan 2025 14:23:19 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bbc62sm1541500385a.4.2025.01.06.14.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 14:23:17 -0800 (PST)
Date: Mon, 6 Jan 2025 16:23:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: sjg@chromium.org, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com,
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com, a-parmar1@ti.com
Subject: Re: Proposal for a New Command to U-Boot Fuse Programming
Message-ID: <20250106222314.GF3476@bill-the-cat>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GxOJBSL7K/qk6Fet"
Content-Disposition: inline
In-Reply-To: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
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


--GxOJBSL7K/qk6Fet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V M wrote:

> I would like to propose a new command for U-Boot's fuse programming
> functionality to address the challenges posed by the current implementati=
on.
> While the existing fuse prog command works well for programming individual
> fuse values, it becomes cumbersome especially when dealing with large-sca=
le
> programming requirements.
>=20
> Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
>=20
> This command programs one or more fuse words starting from a specific <ba=
nk>
> and <word> with the hex values given as input.
>=20
> While functional, it lacks the efficiency and robustness needed for
> programming a significant number of fuses or handling structured fuse
> configuration data. Repeatedly specifying values for each fuse bank and w=
ord
> is not only time-consuming but also prone to errors during manual input or
> scripting. This approach does not leverage the ability to process
> pre-structured data in memory. For users with complex programming needs, =
the
> current method becomes an obstacle rather than a tool.
>=20
> Proposed Command: fuse writebuff

It would be good to provide some documentation links to the fuses that
you're wanting to deal with. What we have now works on a number of
diverse SoCs, even if for some cases it might be best to write a
script that's run rather than copy/paste things live. Any sort of new
mechanism needs to get feedback from users at other semiconductor
vendors to make sure it's generic enough for everyones needs. Thanks.

--=20
Tom

--GxOJBSL7K/qk6Fet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8V7kACgkQFHw5/5Y0
tyygbAwAolxbbwWixcypfCD4EA5GyKCc+VHIrUBjKs+HEpSjsfg9C5cb0nTWffId
RRV4dV8s8q4l4SWMNB5R/mQ/uNEPjRGRODFvx7pzLfm6x+KiE0SA7octzVNy8SIT
u9yoAnbpekgAVSo/+CYFUdeDFgIasJwM2Z2IMesaaS+cqXQ9PEAm21zdG547DZmu
R4QSTdfYgW4x955+w6S6zKn2KZ6c6zzg5Y60KU8EsJxg9WQ6qFkzKTef1b/zSQju
oHuoH5MCP9IUUvKci+dmcLmfY61J+wf5Pn74JEsIs3CYA8Wqhl1yg2/8lObe/mH4
z0X8PUxHHV2jHq4TFQmSHUm7wg2y6vWceEqf0NlDSFifYK1z5xip74mQXneUdZOB
4aA05NdoB0OsjqYHXIz3AvGpL/kWz2wf3Da+AQPOqW5YXDz+68bS459mncsX67pX
PasM/b/1qJsFCRZGSRepR5Nzt1FyqucnM3AbYHM+u6QntdI4G/0lKe7r9LT7x02F
m1BvMbV5
=fEXl
-----END PGP SIGNATURE-----

--GxOJBSL7K/qk6Fet--
