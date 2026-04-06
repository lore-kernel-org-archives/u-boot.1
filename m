Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88127F46C66
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 18:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1627A8405F;
	Mon,  6 Apr 2026 20:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgUJWB90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9976A840ED; Mon,  6 Apr 2026 20:00:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605C383FA3
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 20:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbba5076c8so1399546a34.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775498423; x=1776103223; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbNaoVVEsWwWtgo6/Ah2JfDGgmTMX0UnxhCX4OuKL+U=;
 b=hgUJWB90PS7G+k9dahZncKfm4bPkwNUe9la2VUTg2D3KbpZsugSKoBGYz1CTCKK0Sj
 Lo9Pe24wLJhlyfw20hd3mr1lC3yF9L1s6Yxw4sS0eEV6gJr0xv6Cskb9k13EGQ7j80yh
 jV+Yq/hGg7n/PnsoeXEkivgQyzxO8iluZBrck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775498423; x=1776103223;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MbNaoVVEsWwWtgo6/Ah2JfDGgmTMX0UnxhCX4OuKL+U=;
 b=NDR/afeqryfMDFuw3QFcLkqBm+8roe932Avl4b0QvToh3jTZG/Re/Z8GipDyp52Bdf
 RlBDVAYhkVyWrc/es73dGvhsDf/E53ccmsRx8WLzDqibaQfKI59eZaxASlaxLvKFIsRC
 fXICD0O0iEAEat+1XZDdRET59vu8KMWYsucc7wk1gbQbP2KUgBzYo8RyOjoRkt1x27ow
 mk3LlyvAvvXPCDdrD+NKrAdF2W91Ksq7QB2c9cQj+ClY24GG95Szf8sjMJpSSb2ADS9F
 R6a/OOQw8n2I2GZV0yCQDN2z+oSZuqFBZebzf2EFyrknPtuLl54qiBtxBOP/0cspvKd/
 pNjA==
X-Gm-Message-State: AOJu0Yyd7jwJh+6Rxt5L+cFvaIq+GqOu99/PoQC8VVd4FiY6skVEJm6N
 CAXmQIaXGyCHXiUeArMj0KD8ZIz3L+6HgCOtNviQgW50BjgURToPvQgNldwPCeqN2c63VvxD20Z
 3rhArn88=
X-Gm-Gg: AeBDievhoS8WPdkIFATuE55+kyA+GNnkF6COyTHOftArNAsFcqzfjKOZSI67dnx3Z69
 VPTmdlZiM4/ArUZ3LlNrZ9m5eTpsaQyEC2Y0VnC18iM04Zo81vL3WKD1Baxp4XkaONReHFd0+HV
 OvZncxNT0KqvK9FKKHhbQsy7RX9HuAi/zCIypoXU7pP/LrT2sBRwOgOQ/f0VALggTcS4CZvn/4U
 oYQDTH0kuAuh/OrllrHrmImChl+n7HeNZM94ktVnutWcn6iPu08VnLI7lxYUUJO6T/tiGbJvg4O
 dBBWh4Asp6PyXIEm/UnJ0aDp/DVXAmO4BM4Gz1zPaBRRjuU2kD5sNlqzPBwE+izbZDB3j/8BGCE
 Pe6JLdYq6l2Pq/F2QazZTEwNARiVf1eu7qVHAyUhXWw0OtJtKLV7i/KsvtjxhUCrRRHLx7eu2lF
 qcuRywylV1MFI6Rp0RGJcRn2yEjLmrMcbQ7kh+cvuLIDpUetPv4v0oD+VBeiActyXjNmUiCWkdu
 r6EM2F5gevkh7PXWuWm1lFssScWutA70KcjXtS0W9N0pgKs
X-Received: by 2002:a05:6830:2409:b0:7d7:c92a:1d73 with SMTP id
 46e09a7af769-7dbb73b3f48mr10502625a34.8.1775498423015; 
 Mon, 06 Apr 2026 11:00:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb7c3a0c8sm7941070a34.12.2026.04.06.11.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:00:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:00:20 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04 released
Message-ID: <20260406180020.GX41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+y9AdnuTH5FDSxFj"
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


--+y9AdnuTH5FDSxFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's time for the full release, and so here we are. I've tagged and
pushed everything out. This is another release that feels like it's just
good stable iterative progress on that last. The big change here is that
we resynced out libfdt code and finally device trees must really be
properly aligned. I am optimistic we have caught all the cases where
this was not true. But if you upgrade from v2026.01 and suddenly fail to
boot with little output, this is a very likely culprit.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/icv-nvmv-dbf
April 7th, 2025. 9am (GMT -06:00)

To join by phone:
https://tel.meet/icv-nvmv-dbf?pin=3D5493171900556

Condensing the changelog from the -rcs themselves:
- Our dts/upstream trees are synced to the v6.18-dts tag.
- As mentioned above, we've re-synced the libfdt code and now enforce
  and require proper 8-byte alignment for the start of the device tree.
- Lots and lots of platform updates. Rather than call out what seems
  like most modern SoCs, I'll let custodians reply if there's anything
  specific they want to emphasize.
- A number of bugfixes for problems found by Smatch and Coverity Scan.
- We now support clang-format and prefer that over the old
  scripts/Lindent option for formatting code.
- Numerous documentation updates.
- Many subsystems have also had a number of updates, and I'll again
  leave it to the custodians to point out anything they'd like to here.
- We now have "allyesconfig" supported in CI. This isn't quite how the
  Linux Kernel works (we do not assume 0 is a valid value for hex/int
  questions, by default) but it's catching more issues now that weren't
  before.

The merge window is now open, I'll be merging next to master shortly,
and we'll have our usual bi-weekly releases after -rc1 comes out in 3
weeks with the final release being on 06 July 2026.

Thanks all!

--=20
Tom

--+y9AdnuTH5FDSxFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadP0tAAKCRAr4qD1Cr/k
Ci63APsFjxJzpYKiqMh3SgqB7KZxX9CXDiSZDAgxN5ZhZDTBNQD/a+Yb/zYZaKOa
zKaaJjftwVIK3YngBMs7TXJBnZ0HPAk=
=vMfU
-----END PGP SIGNATURE-----

--+y9AdnuTH5FDSxFj--
