Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51791C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 00:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DB183102;
	Tue, 29 Jul 2025 02:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HRcFrWgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A4B82F14; Tue, 29 Jul 2025 02:24:07 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A0A82CFA
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 02:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30063371404so1444967fac.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753748643; x=1754353443; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMan8vwIRi5v7J9xBjRvS3MvBmY/Z12QssQ0cR5eYvY=;
 b=HRcFrWgpQDsKfd0CWORb8COyV+Pfc1RC7qMt7DcnEd17w2j/oJyad3+VxwCpamwp7f
 TmHL2g7rKxFL6b2I3WFK+bM+OqgcGnxa4hbX79AopfvVE/mCDG2ZKD1c1jaapEuM5yHb
 oOkN+edl6/PFy2Nr3FaJyQ7EfLlbbOU7Hkia4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753748643; x=1754353443;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMan8vwIRi5v7J9xBjRvS3MvBmY/Z12QssQ0cR5eYvY=;
 b=kdxgiQ4Vu9MYyGt1gBNdCkERO1CKRc+on+L0RDNxqkd7GFkqhVPiY7/k6y00yqx2nL
 ZBg81jLwU/XQwI5CVG4Hll3ggqzsbUkCAXHizdTHgz2V87hfjiMS9bs4Sb/3ZO4+skge
 X+iTVdVguazLLhgOdO28PMTtMql/nBnp/pKG2v6yU2ttwLHUkCDfK6MFb5aJOsrUGPxr
 GVF4RD1kPYzaMYIHJ8zC9uUk14Hxsc+hPVOb0iQweRuuegNBtrlucELOSJap9BDXxkaP
 h1JpvtppIYBHIxiwfKYpLFPgisDyji3VB+k1Y29GnHaeNx7yeOLTkV5qWcH3/e5IpMAu
 vxqg==
X-Gm-Message-State: AOJu0Yx5PTBW7q8a6zNScy8+TyA25lc0wmJ5lUkY2/qI9Q11eQO4S6A7
 BeykY1ZtGtydooXcrIDSOgSCy8UpwptKPfJUiwDgM2xUvsahILTruR8z6gC3/bBkUA+5veXnrml
 A5AmkkSo=
X-Gm-Gg: ASbGnctwnnhigMECpSugk452ESjdus58Ml3X0fIw5pCPxN+M9BY33Y2m5r8zUzW18S7
 tLfbJ0fNCyZBh0ohqOaStctk33yharMNw5RE/7ipRLH5O8RznHoWyOHArK2cDlm+F8OfN0ZR26I
 U8n67AQnV3i70y7GGc6Ul7SmV57Q923HDbO4+BsXwPNGdjj1EkWVrc6JCoUrA136RjqzhaQIRxI
 4MyOjfmLUM2+vAtMn2gpxd/8cZINqY8YUW6ueGb99cWV/12nwXo1FCgHl52Pg5DbjPYsiz303nx
 ts2YVXfljqS4R3ex1L9AYNwarBykat/TP17OLPWxyKn69NhDtk4zvUwAc+7HAxkMTgunR0JtRhr
 wDv9mbWaBq5r6LR5suxCpM05LZtVvILVmXvxeFkv/jzjwOS7M7CboLi3j99C4iaX73lc=
X-Google-Smtp-Source: AGHT+IHVs811LS9QhRDZE6qADt2NwQyr15SEkndFYG+upjoo96RSS5TE9xBxTyr2FmG0pX1R2FiSkA==
X-Received: by 2002:a05:6870:249c:b0:2ff:9953:42f7 with SMTP id
 586e51a60fabf-30701b47bd4mr9555766fac.35.1753748642999; 
 Mon, 28 Jul 2025 17:24:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74148246f0fsm1238433a34.51.2025.07.28.17.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 17:24:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:24:00 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10-rc1 released
Message-ID: <20250729002400.GJ1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="si12pG+XY0qR8+Ca"
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


--si12pG+XY0qR8+Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. Looking at
my own queue, I think it's in reasonable shape. I do think there's a
few other pull requests that need to happen still and I am optimistic
will come shortly (but I've not reached out to anyone in particular). If
there's anything big that people see missing, please speak up.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
July 29th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- We're on v6.15-dts for upstream device trees/bindings and I will move
  to v6.16-dts as soon as possible.
- Environment can now be stored in a SCSI device (such as UFS).
- A lot of cleanup of implicit #include usage.
- Our Kbuild infrastructure is now based on the Linux Kernel v5.1 and
  not v4.20.
- Migration to DM_SERIAL is almost complete now.
- Standard boot now supports RAUC.
- Enhancements, improvements and new platforms for TI K3, i.MX,
  MediaTek, STM32, Atmel, Renesas, sunxi, RISC-V,=20
- More improvements for some MMC drivers, various parts of the
  networking stack, TPM, DFU, Xilinx, Qualcomm Snapdragon.
- A lot of issues found by smatch are fixed.
- A lot of issues found by trying to build "allyesconfig" have been
  fixed.
- CI has been updated to QEMU 10.0.2

I continue to plan to do an rc release every two weeks and the final
release will be 06 October 2025.

Thanks all!

--=20
Tom

--si12pG+XY0qR8+Ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIgUnwAKCRAr4qD1Cr/k
Cv4TAP9upPc0qvkqk5D7gIBop1+XpQ9wcqnc/Wqi7DoN2gFnGgEA0yPNoZDieWh1
qDrzNiexBbBmsjL6qq3M42IPn6QDqAM=
=Umt3
-----END PGP SIGNATURE-----

--si12pG+XY0qR8+Ca--
