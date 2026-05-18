Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1806ACD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 18:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFD984119;
	Mon, 18 May 2026 20:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otzcDIl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F2E8460E; Mon, 18 May 2026 20:16:00 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E2A80433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 20:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-464bba3a9easo1735746b6e.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779128157; x=1779732957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IQCx3UXqbyu+eze8ZcN04Uw1YnxgEr+129PVm9JTRJA=;
 b=otzcDIl5NgKMPjqWtfjP3MjEdGhbGy+YLbQxWq7ofwNj67Yh8l9nxG0Xm4YEYybBmz
 HGeCHe/E7JvrbGk9dMR0OJAbfVOCQeCosKUyx+SsLImTpWaQ0vBuU/gOVWFPhROPfd4o
 1ffIacqGgcC8otsnGWSh1XIKo6e3+xBnL8xOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779128157; x=1779732957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQCx3UXqbyu+eze8ZcN04Uw1YnxgEr+129PVm9JTRJA=;
 b=mqcD67NgfqcrRn/EkIn9elHyH1oJhB9vbRZRmhTQCBI0Ks9xefVsYzKjHE3Wnbwd16
 inYLIjmZCRJHiuNtBDsPUBqurZiF4pkEYOH3yjc8IRgTDR3XqaFYfSk9s3MnOwEH8chU
 FsO1VmEjpuCQIngaTLqct4RCBdGd+ruuj7jjBzVVx1cdKK43iq9p22A7pDenB/D5num8
 k2/tGWP/otTuzHZ11qe+OHYYS2a/vTmVcTTa6bRhYk2tbVSNEBZAZTMITfhhJO0+90St
 52hR/gHtlqQtHHhdjk4YPMGC+jflBymfvW55LXIo3yvN32accKWG2GywFJJPpBm2PjWV
 fc+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D7DJkq3L2Mw+JWRUV6L0rGeX1NqZWxFzKsjH0IQXdizETwdNy3sd67yywJuLah+Jgqjjb5Yk=@lists.denx.de
X-Gm-Message-State: AOJu0YwsWp/j3dqBcumCol9TPQ4FFhy0DmeOIbVmkNFQfILOILhAgTYg
 j+2I6rQJ5UNYYsR7GcbKwS59aHfJjw4kXcrWvQfWyjG3uPQ1dgLpS97KOoKec/SNGBM=
X-Gm-Gg: Acq92OGxuLpY50EzZBnpaNH9L74sOnL+IsgI/AYGZbiHb596auqDDt1aEZJ7fSsTp+e
 dunvPVg0d7XGccbK7LH0NDAU/wE9TYKMId0s+dLdeqZdk1ZyozOQ21yzS8eelvyIz6KZqUkK3UX
 fHvvnTrV4AufQA17dlEA22E5Z6F7fcH0YvEKMVaMKQFFzYLHpVqQsEAziwEuKEvJQBArQglWrIV
 2NwPigKoXcbGzBhMIkvrEj7Hfw/28DYv2EBqe+ocR/AfiTz4ficygPTb6O5NaVvFknia4xaxgKM
 GCVaG55a0FKgF1cUYwMQrD2E6u0kKhWaZVlK54mzGVNhnLTOSNlLK8+tJmxwO5zBwRWwZm2uQcY
 SreHW5nZfKYBHpYOeCEeltcRWwLCKrEgPTD1BlEaoW+8f1kSG799YntpClKmDP86Xz1nsHrTHy9
 AyBwNIvwm6dNUFojD6ORl6d8TfTJfimbFp43IUGoti25xSni5bCz44lVy7lfmuCd2l0UnJL3tpq
 D0Ph2zaqItJRyAe8t4JZWUTd20XXX2XFePGxY1RiWIq1bxcucX8nxhZA2EJ1g==
X-Received: by 2002:a05:6808:2f0e:b0:479:d605:64a0 with SMTP id
 5614622812f47-482e54e90cfmr10995535b6e.0.1779128156650; 
 Mon, 18 May 2026 11:15:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm4692779fac.16.2026.05.18.11.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 11:15:56 -0700 (PDT)
Date: Mon, 18 May 2026 12:15:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 0/9] fs: add change date to ls output
Message-ID: <20260518181553.GU1858239@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2fwZZD+4raTnncyY"
Content-Disposition: inline
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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


--2fwZZD+4raTnncyY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:

> The ls command currently only displays the size and name of files and
> directories.
>=20
> * Add the change date to the output on FAT and ext2/3/4.
> * Use the actual date when updating the change date in ext2/3/4
>   file-systems.

What's the motivation for this change, and how much of a size impact
does this have in general?

--=20
Tom

--2fwZZD+4raTnncyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagtXVQAKCRAr4qD1Cr/k
Cl9hAQDrJiMUJYd5KyIAvY47Ufiq1qHppMjikiKvdFCcP4pCuAD+NiM0k2wncptd
zxRLRYeUlZ7NtgTF50blOaVzxQ5WlQA=
=K9Gk
-----END PGP SIGNATURE-----

--2fwZZD+4raTnncyY--
