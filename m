Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F951C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 22:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CFC8269F;
	Tue,  6 May 2025 00:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e1Zzjf8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A24A8004F; Tue,  6 May 2025 00:10:48 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D6F82928
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 00:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c14235af3so3144032a34.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746483045; x=1747087845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UsD3bCyPtGCTV9XzxDQvBF4V0xSU9ZZgOKQETI55vNY=;
 b=e1Zzjf8GiH/0Z4Uu7TN1fk9DrF5t6JNgBr8AyEv3hwdYr2/qYkL/i+7ZJHzH5ilDYv
 5pFwx/SOQwbcyddx7HAu3fzIrnzegpriL6cA/X64S7qZaT6oNcZSznp2xq50YtAGitZm
 0J7Po/GKQ9ALP6kGzQYNr2zVGMCByeCLF+Rik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746483045; x=1747087845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsD3bCyPtGCTV9XzxDQvBF4V0xSU9ZZgOKQETI55vNY=;
 b=flsHVZORZ2yEmJpU5NnhErgrMcNSUdvjjTborwmxDWslphdyCrSEn6fQwE31PPftMD
 vGxNU1MXtQSKtpIrEDTMs2Lkf/Jnbm0fINX98lVnZuseYv5eicTRG+VzAaJWJFVF0Yqx
 XqjZd2k7rFKPS7QsOG9x7x8u5CgY3+6xcb9/02TyZ0MhnzRsXdCUHEbTz+fSgr/wjwQa
 8bsBUBUL1dm+s88bMwfnsz3SUJen7kHKokAqDCz6WCsHWBdjUwOI3NOB+wLIZGaft4eH
 +8vS/SmtXv1y32A/oLLfwNJ5j9IIaCnn7p15LoZ1eEFdqTGb4Hao+JOHumnl7Kuv9cg2
 pcLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA9pU4rkYWW+xEnwoZZ9iy8IHG7xYyzpAw6g8Hvl5VKQyKhN5AMWVAr3BDzGC4hni6AxuyTQo=@lists.denx.de
X-Gm-Message-State: AOJu0YxG0hkHX/9X5YB8Uk8XXm1qW+L28teaI+E4b+oIBUyEZS2B1TkI
 qPo8HJZCB6eYMEBIM40qF0TIGN6Z048KsjiOW5UBMCqCv31M/3jxLXUaCmJc1j4=
X-Gm-Gg: ASbGncsiByOfJWfCBGI9XpM7fDS9XUHPIJqL4PbPJCVM3wSOPKOp+ShSW21nniXSPdi
 2t9KWobWUy/FROhEkKPjMmDrNxJ+3JWmYFZkZsRKymie02yycA/ccKuGXkYRBIgTBwuCyJ1/JQU
 FnXwoc1LKnBHyP3W4XnoTooyABOclfMiaM1ktSPuwnIL1oda1H8QghbvnAYrMXlQCZiLmWPGtEI
 pn8ePuXSHXHnmohZcI+lshatoLUHavbqCRMibH3WiyGePUsvL+xaz/srZpyHymMqI3oIhcZ2X9a
 t4S4Wg7EXHvvD3rTxmKWAsdQqOG1SUn2z+6pvtfR0R2SGkKOaP5QiLnOgqvNd38igPeIr6xv80E
 K9A==
X-Google-Smtp-Source: AGHT+IGiXL5Lxw98uKN2QTXylvoem2Y411MdvaKm0g+tGpAj00DdBR5ZmqGpM1oAy46cMeNFykJc7A==
X-Received: by 2002:a05:6830:6119:b0:72b:98d9:6b1c with SMTP id
 46e09a7af769-732062a3492mr922096a34.21.1746483044723; 
 Mon, 05 May 2025 15:10:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31c751fsm1716993a34.16.2025.05.05.15.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 15:10:44 -0700 (PDT)
Date: Mon, 5 May 2025 16:10:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: kirkwood: Convert to DM_SERIAL for Kirkwood boards
Message-ID: <20250505221042.GS5430@bill-the-cat>
References: <20250505220853.23679-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jC9clkFwxcSaiAAM"
Content-Disposition: inline
In-Reply-To: <20250505220853.23679-1-mibodhi@gmail.com>
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


--jC9clkFwxcSaiAAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 03:08:52PM -0700, Tony Dinh wrote:

> Enable DM_SERIAL for Marvell Kirkwood boards that have not been converted.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jC9clkFwxcSaiAAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZN2IACgkQFHw5/5Y0
tyxrnAwAlpdgecec6pIzcvRpxyxfyu2ozx3Zkk+ajG36/k9BOwbYANeBiiuUI90d
CZdJyvORpuFJxLGkbXX/Nr7RcsJ/SPdzf8CeiRO4MWS0NfojODv2HG6C6518QH9f
sZIIrigMEbczANVT28QpWPNxA8QLiqrNBW3Pys6N3VbzCNDc2hqeT/t3xQcszjJz
Bag+bZkC9SxHROgMkDyR2VsVL6jBGgn/QSvBMQrfggyOnFMU+mdnhBJDtGXRiTLt
GwMHoZQs8x+v14Bt9l0eR4J+qBl9ftw5vqipShJ5YqwKsExOp2f5qcEsdhdHlYNy
CD5qPomuJA6dSU1BsJvZ7xwjPe58C1ZSvNA88WPS0zmnGjokDXhyeTvIEfF1oFs/
0+K6JQ/+kZZ+EXA4RLtkVtht8MbjnfQE8AUsW3ZhUmCojU6UFXCD85yYWtGJhnHj
AtbSvbmmaYMCov2RQsNl3rD6JUQZC7/6Wtujgm2OSy8IVO0V7n0AzSXl+O5lK8Kr
4GbUSiZF
=21/L
-----END PGP SIGNATURE-----

--jC9clkFwxcSaiAAM--
