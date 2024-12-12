Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D1E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F491801B0;
	Thu, 12 Dec 2024 23:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dk0OPCCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795B1801BE; Thu, 12 Dec 2024 23:14:35 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09B6800D7
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso86537385a.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734041671; x=1734646471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TRN9myjHu9bMOqJAsnNtdSik2yJF/SlFKhMxs1oyzxU=;
 b=Dk0OPCCDBqu1x7Ir26P5/5LDJmhzrQafyXs/0P+/z8PmMyeLyLpDGdHCXi4carAkJx
 jbLGz+uRtcZaI45QqMhkeXe7oNVwpasBB8WNBwNZSDIwnvK3EvN4b8ZoEERvW8wcJ2xR
 /JqOcDudwiVEmC3TkglAsQxh0BbsXbsDFNgog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734041671; x=1734646471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRN9myjHu9bMOqJAsnNtdSik2yJF/SlFKhMxs1oyzxU=;
 b=Ws/tG5h1u6MI+9OfGhu3UNpnGo3tMYKbJJogy2vJWfvkO2qFYIlsYSuMuzD94SJMP4
 LGt3EwwYczuGAo4UjLC76MXt7837ObV1ASfpyXyH46kq+5slWpEElnoxEMn1zbdA1BwJ
 T7tCM9NoBp9QYa+JNLqFS2aC9mF+AaepTH8sOrZrk0Xl2ZjTCLh0+KT/7hcE6BUQmRPi
 /LGtFIzTknrXG54B82lj9u7UVj3SWJXbs10fwLjszeGPZixWGqafopYKw8XSdtQfc2H+
 i0DUCw0NEEfxRy7OK7m6FhVUyJIC90+4puc726aDJWxKLOSockgMjqkKluOFOEndjvHx
 ZC7Q==
X-Gm-Message-State: AOJu0YyR7gAJccsB8DQt6y7McjMq5fIW3g1oKOLmapUs0V0E9MbxERAA
 mdW8j/2oHXNy5jDLuFDhiZ+IXZErN8wj40Z4zYAANeWDTeUvBLzbAViBbYDFBpE=
X-Gm-Gg: ASbGncunds5mUZBrgxumBSgzrBVmvOuH0YmtPkmXAzCxN+2hVjHLRWTLI1RZaDcqP/1
 GbIciIBexmOuPS5x/GqlCLD93EaykEWlxaDPkD6wWEzCAABwVoCPt7dSkWtiShmlkgykwHeW0fU
 KsD2yn7YMmSTyjskdL6CApgUyFV2tenSitK+dYK7uPc0XpUXu/vS4z8sTlhwoJDnNliu3ORxhEP
 p0OmqR3ShZzW7uNc/RHbVHocLzAGSSMZPtqmCxMYzmVONOeRfr+Ylse
X-Google-Smtp-Source: AGHT+IGTFWnQHTVPjw2D6ZFlzPhNcVj12FiTDir2vDKuHesqFodKkeWF4OR8Ci8oZKygvdjgBIvjjw==
X-Received: by 2002:a05:620a:2716:b0:7b6:668a:5a7 with SMTP id
 af79cd13be357-7b6fbf79679mr17676485a.62.1734041671620; 
 Thu, 12 Dec 2024 14:14:31 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6fbf9a8basm2981785a.35.2024.12.12.14.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 14:14:30 -0800 (PST)
Date: Thu, 12 Dec 2024 16:14:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Burak Gerz <burak@gerz.io>
Cc: u-boot@lists.denx.de, Daniel.Venzin@mt.com, eballetb@redhat.com,
 manut@mecka.net, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/2] fs: fat: Implement FAT file rename
Message-ID: <20241212221427.GM1505244@bill-the-cat>
References: <20241212220635.25971-1-burak@gerz.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="up3YQPt7cifqVG6O"
Content-Disposition: inline
In-Reply-To: <20241212220635.25971-1-burak@gerz.io>
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


--up3YQPt7cifqVG6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 11:06:27PM +0100, Burak Gerz wrote:

> Hello
> This patch series is a first implementation for file renaming on a FAT
> filesystems. This implementation does a file rename only (no moving
> between directories) as needed by bootloaders like systemd-boot [1].
>=20
> The renaming process is tried to be made as fail-safe as possible, by
>   1. Writing the new, empty file
>   2. Copying the address of the start cluster into new directory entry
>   3. Deleting old file
> This can decay in the worst case to a hard link
>=20
> Additionally, make use of the FAT file rename in /lib/efi_loader
>=20
> [1] https://www.freedesktop.org/software/systemd/man/latest/systemd-boot.=
html#Boot%20Counting

This is useful, thanks! Can you please extend the existing tests in=20
test/py/tests/test_fs/ to cover this as well?

--=20
Tom

--up3YQPt7cifqVG6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbYD0ACgkQFHw5/5Y0
tyxUyAv9FUCOTZLeynQ+IPihaSt77wlK2cqkx6D1Cd5U1uSbijqap3wALAxAA/ve
oME9X/X2f5Upq2XOVW4K/kbT9C4ZgFxK1yDV2wrNnntCM7KT5BD7sMnrOmrnDQy+
q0WnOtiUaZOAWtw4hi9HRMNXXrrIbBvisfk/8zmd4vdwtSkIcix6VQKqU+Se7qRS
S/ZR4bMm9TsTzMXTSVfu+LKOX7BIGhkx43ZH6caS8na6rrzt2e1sTc5D//X5RSLD
5IIuPdSnMk1FtKmDx6reWMrIveOui6W44GpMArhJfYj6JbNiDfZp2b3ZKEnAEVoc
03LHEQ7A0dB82C8AUEB5Gw5HkQ+uXu0/1sZmU0CfeOgDe5Tf9mzxCmK7Q5gYnyUn
c6WyJwDeYXvpp9N26jGQPEWuu1i8FPOWjjDGqBV2qip5K5Tnms22Vp9ZCT4hn+Js
UB+Qocme5iwfwzzsP/ZU2vZ7M6StvCi8bQjpvYenKP8NQWkYIIHp6uXERN1L5bWm
78DzNM9o
=aUAj
-----END PGP SIGNATURE-----

--up3YQPt7cifqVG6O--
