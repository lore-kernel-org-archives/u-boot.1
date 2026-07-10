Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFEDC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 01:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B7C8484A;
	Fri, 10 Jul 2026 03:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Es2kG6NC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08D98498B; Fri, 10 Jul 2026 03:11:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B18D1843B6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so219658a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783645880; x=1784250680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ud9zCr5XUH5RcSpWFBNvSQ4BiVG1WjvFGQo/74aEvfA=;
 b=Es2kG6NCcbiLfVqrm2+FtfMgk4DvK6idMytVlu7nUObwDTXpeCzwN5IpE26UhWNjA6
 LDRIgIy1Ev+4H1nHmci5Nb93u776a3JhEQxIGsSNIFSxWb1auCiRT9/JHoti5AXwn9gR
 ITRCUfqebD0hNH/tt7HwiQ6qg+Y1ypsp+JBYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783645880; x=1784250680;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ud9zCr5XUH5RcSpWFBNvSQ4BiVG1WjvFGQo/74aEvfA=;
 b=UWPpXixZ1WEh/eyMr95kkBUW4N0X85pSUrKQKhX7RgdGJ7y3KaFGChfLsp/+0hN+VG
 XCmCY2/qphRm5qPFGgJGidTBv3v8cC7du7qdIME9lW8gak/BZxU86BtZgxPTe7s/yEZ4
 +SE0Hr/Jk25TA+0ixGcAj7mZT6pMOksT4yERNMak3He7OyiwUUGs1WEk8cJgifqP52dy
 yxfxTu3ngmiz1QCU2WQKDExQGark/ezwQre72fl4kmcAtX32N5QTemYHMPRsdcupGt2e
 wtvog4TiYlG3a8+DxcIqlGgzpzwDFZfY1P6oRYdaAUEBEnJI8qtoZHdzOoae2vyiAnfg
 /onA==
X-Gm-Message-State: AOJu0YztqHD3lHHDH/iTJDvQSIVmzeCVQIXHuVTopTLAyIQW1lPL8mdj
 0ZsZKl4W7Y2whbsZ/+ocI+DoI6rpQ+FDQNApv6+dhGYt5LiyRNuO4kXHhelYx1QuOcQ=
X-Gm-Gg: AfdE7cknnsplgaJl8EVKdPm9+P0ma+5in3VZcBiAUkIvoYQgNzYm/T4D3BpyeWUOTEp
 lpWEjwe7IV3QrMgRFjrm76buQ3SUMv0gNiV37kOljthyYLbmVfeyw80yh+qkhAHWQlshe/Km3W3
 BfxgNeHpb5t6oKUAIefQEMaAw+Bi4LLqVlyVqFgIrR94zWzBqhis+Md2WNSabXEJzfMHbnWJMv7
 wAmb+9IWRh6/g45o6RFlpBVEhU2/07LtegZe1QQE6lSVmRaQqGfDs9QnZM75JLt2n21XVQ2ajJg
 dLD6DFzuSquvkxAFer5BAY8OfZJCTm9pyO4pjzOvnYqZs6KHzRIEBZsa0ShmvSZ8N7bYcR4cI5J
 1U71dC0luOTltUXbK9c5U6FKO6x0/cfCs7nylqFfbjvXAIif814IuLEW+BowoXXx6WoI1Gvwphx
 994gMSt01drLeSqMlCSVrgmdx+nb5MAieXlOmb6y3OtdVxqVaOnBIu6wG3vdcVYl524cdjDBw2L
 kDRs+9PPD6pqvddknMi4fpdUCv751Xsr8RD4A==
X-Received: by 2002:a05:6830:2701:b0:7e6:fdea:7ab1 with SMTP id
 46e09a7af769-7ebcfe968c4mr7574099a34.8.1783645880388; 
 Thu, 09 Jul 2026 18:11:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae177c5sm5477141a34.5.2026.07.09.18.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 18:11:19 -0700 (PDT)
Date: Thu, 9 Jul 2026 19:11:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Julien Stephan <jstephan@baylibre.com>,
 Coben Han <cobenhan@mediastek.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20260710011116.GG749385@bill-the-cat>
References: <7f4e54a5-00ba-56d8-891a-a29f987e703c@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xemS6hJUtMA+1R/P"
Content-Disposition: inline
In-Reply-To: <7f4e54a5-00ba-56d8-891a-a29f987e703c@nabladev.com>
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


--xemS6hJUtMA+1R/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 05:24:19PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from
>=20
> The following changes since commit ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc=
3d:
>=20
>   Merge branch 'next' (2026-07-06 18:26:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git tags/i2c=
-updates-for-2026.10-rc1

Please update the .git/config to have an https url and then git@ for
pushurl.

> for you to fetch changes up to 0ded029735303c0db04510792bfc5f0dcc62f5af:
>=20
>   cmd: kconfig: i2c: add missing I2C API dependency (2026-07-09 07:18:18 =
+0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xemS6hJUtMA+1R/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalBGsQAKCRAr4qD1Cr/k
CrEeAQDgD4w+/FkssoaA/ahGXgll2SIFE/fRtsebyvih+6zaoQD/dk69wZL845g8
6cVxUURL03u2PbJAEFlLo5ENBbZBOAQ=
=w2tY
-----END PGP SIGNATURE-----

--xemS6hJUtMA+1R/P--
