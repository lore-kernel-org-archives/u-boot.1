Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9664CCCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 22:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A77083977;
	Mon, 27 Oct 2025 23:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g6KjQcap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B9B83952; Mon, 27 Oct 2025 23:11:19 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0608391C
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 23:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-654ee101473so680722eaf.3
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761603076; x=1762207876; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HHMMPzM6paEVn9stgYu+qDbXe++haekz2uqbJJILpG8=;
 b=g6KjQcaphak781IQ9JJaOondcBzu20PwwcVdnvn/24fJNS0ZpZjkMh9G0u3wvgA685
 Tvi2JLmhI65KxGN1ymgoMU8dBuY7YWA2I37QZGZFu1a6cRqJX1sFH0mqIavdiz86v/z/
 gzWnD+5jbmdGjOILklsSTWtQoW/qgfeOvVwzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761603076; x=1762207876;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHMMPzM6paEVn9stgYu+qDbXe++haekz2uqbJJILpG8=;
 b=MkaE/P4HZbzmbH1eUzgg3M+hkjzELmyNV9cX833ny9diQNWXOkKEm/bWNBmMvVWJ4y
 a95VUWWrlPVl5QuiXO2Zv4My+6Zl6gwjewsSyvcpRJ1BfwUKZZO3VN2EAL118azWH791
 a9zH39MVfbpVdrsH185hBa6g3EIlqicAanhzpbWUoCk8cQq1Cr+aAA9tqT/dcok5i5k0
 c/5qqWDUC8nv8TGGSetc/bIC2RkMp7SmXVXEm14inVtWRL9EXds2eiMUOg2Fy5b+0jSB
 Kh5debV2JK4VYgQrHWQofEhtgJk9NVlK72jWNR688hIBqHTAMUqqEKqDViLkL0CQbFrU
 1y0g==
X-Gm-Message-State: AOJu0YyVrzcd/WZW+TRwUVVmaJt7GmnvmUHNI8ya/ny0pYDvs4lM5912
 BJPv9vCMEauVL1JxZn/MIDRan2PLzmejHVaj6mJHK5PiR8bPKQu0Bc+iatgTZWeyv9WtiW2axv8
 2j53A5b5GD7tc
X-Gm-Gg: ASbGncvUgLDK8ID84525yJSseLC9W/iz1X3Wx/2yHw5yF9qalf5lWHuTuL1CcQ8AFmy
 3UuTBI7Zd/k51efuV4BSUrITN0uqCgJuDe7FavK/tKBpZ0ilquj8aBf1LRvIo6X7R1gQz9j8DzU
 AT24OW9nC9pE2zqZFtIHxbGarZ61zJdZtlTSlHf+r6zm1oD1YKtZP8NyJ+I+l1AcQ8jmaJNxCR9
 hHgYQ6ZJ3nmTUyw77g3THMY4UYNbM+AgJ/RJqH644GEqhSK49BPKA7K6D7YtO4POBBlb8ocj1D7
 EVvxSAjTZcmZbXjc4P/ANaEdi5ZsXn6Mqz/anyZfYRykh7Ldv4qtTJHVzveUHV5dstl9UuCgYCU
 ITOrD4uVA/nrkftFOKx1mJlw1YpzjGPGD5LpU615ZUxsyKxGBY15MC2L93JBeSE2qlXYiALEyrA
 yqz581bx/SVgQ2BGLEdxwrgngphYYPJRfH/9zJdCw=
X-Google-Smtp-Source: AGHT+IH7AegDRhSctRjQgTuvfXniqptr89mEzu//iEjGIMCTGwg/muKwSGP9/UzrAWmy9rpus9s8uQ==
X-Received: by 2002:a05:6870:1699:b0:3c9:4782:7c4c with SMTP id
 586e51a60fabf-3d5d75db256mr612921fac.7.1761603076040; 
 Mon, 27 Oct 2025 15:11:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e3544457sm2912868fac.18.2025.10.27.15.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 15:11:15 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:11:13 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.10-rc1 released
Message-ID: <20251027221113.GB6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PWuGESrfWEax9kT9"
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


--PWuGESrfWEax9kT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. Looking at
my own queue, I think it's in reasonable shape. I do know we just had a
regression reported on some TI K3 platforms today and that will need to
be fixed, and I am also expecting a few more PRs soon.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZGNsNT=
h2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfMjAyNTEwMjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
October 28th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
  tag will be too late for our release cycle so I expect people to be
  using the cherry-pick method to bring in dts changes as needed.
- Lots of platform updates. This is always the case with -rc1 and I
  never know which ones to emphasize.
  - That said, we've removed ATAGS support from some platforms as it's
    very legacy these days.
- Lots of fixing of issues reported by Smatch.
- We now support clang-format and prefer that over the old
  scripts/Lindent option for formatting code.
- Continued work on improving our old pre-rST docs and converting them
  to rST.
- Fixes in our DFU, MMC, PMIC, USB, UBI, SCMI, UEFI and networking
  subsystems.
- Some cleanups and improvements to Falcon mode, with the aim of being
  able to support this feature in secure boot contexts.
- More patches required for "allyesconfig" to build have been merged,
  but some are still outstanding.

I continue to plan to do an rc release every two weeks and the final
release will be 05 January 2026.

Thanks all!

--=20
Tom

--PWuGESrfWEax9kT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP/uAAAKCRAr4qD1Cr/k
CnygAQDS7vMpGs9B3oLAL/lpauRbGzUN8agQAHhqchzfyGgClwEAq5UDjtF12os+
hMBfyvPcXvSoYJMD2rwZyA9/OAeZsQs=
=IJYZ
-----END PGP SIGNATURE-----

--PWuGESrfWEax9kT9--
