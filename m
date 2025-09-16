Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA10ECAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 17:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112A081E13;
	Tue, 16 Sep 2025 19:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GXoFp4Sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6D783071; Tue, 16 Sep 2025 19:44:09 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D98803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 19:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74c1251df00so2917598a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758044646; x=1758649446; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JMS+VNdwj4koFH/wRAcDOMrdFaKFUhSp0Te2PSL3gNc=;
 b=GXoFp4SyOhfCs41QWGh74YOluADTX8aUXK6absrMKBuEMt+9evxCRvod2ESAFA6Rvb
 SbmlDJzLAFQBvvdKUdz/7Zrj50cEthqKNWXhbIEfWv8kqWLiBuWk4EJZI3+rWPxkmc4C
 iqWZ+eFUlwZVZjT7xMLGvV1OLGZHl/mP3KXes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758044646; x=1758649446;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JMS+VNdwj4koFH/wRAcDOMrdFaKFUhSp0Te2PSL3gNc=;
 b=d8ZayydsN+/Mm7Ni5vutqdBzBTh/XT5t7YjdRTHwkBmgD+EDmC5e2ssD1QkeKvSZws
 XaNkGnL95nCK57+PpZIs6/OVY+C5NfNA35VYsb6iszjCa5gBgumQ8mAHvXNpugAWman/
 7mRDk2GTZzbH8gKMKDNgygA3S2GXTokkm8wHjan1ETl6AuUj+MTsFB8YHKXgOjCC2hBp
 JT0ZRoex0SRf/abppN5FVbDDwuQzKAYRn4DcIbZAu3czrTZVy7YTwwJoUStyQhzbZXj6
 PI1EvAV+CkREJZzalWM6M9cfXM454P8hBUwus/oBWfCZgybw6x7WvnSwTwI4REOaS8SE
 oQuw==
X-Gm-Message-State: AOJu0Yw8giZbOLYcq9v3ghT6yvRS5W3Cf8dH/KyhMqqfybZGBHa0zuSE
 t7r/RqsUpD158+TroxFqHtCUjUUidJKjfErw2v1SJ150pgkOn+Le5F9Sx9L+8lT5UMo2Re1i3ST
 ANKenQew=
X-Gm-Gg: ASbGncsTC9CaGd0upmj1KQ6zTAvzN6wjdEEA1ALYEz3MhFHRd5vwrqoDlRNU2qbxKmH
 RtmghOPRbwMCzXiL36cKmbg9bXMhjf60EDI5/Bc3Aq3GKov/VGOfFQs/vpAvSSlWQ7bPhIC57o8
 MMg/msi8+VYoPdCXhH9A+ZShsFW81z3R1HbYm1XFp/V6rjPDxirVJD9aBtNJuNpB/FOjRyclA8Q
 d4pWEXdUrI/Kekhj/+GZmJTKB+Zix39lnd/VIxzhfPVUs5jj7kEalaU9VKL0vpxL9IWzejaGBdA
 VJc4HXXuSPx1AXpRMUPnOZ71zOZnSs+5CXkRABLpWyv/pbvjjF+P9jARlQwIVUwcMdTSIsTAvde
 JyV4WlM73rzyTfU0ehPpQzabrsjERWYEFMGCO/+MNgDtLguBzPuefzVFF
X-Google-Smtp-Source: AGHT+IHHsHGQC/NkSAhsKy7pFJvj97QO3AXHP7qDECdOgFoE6KHg+CDzfK9D1yEyqIWJTByv5l5lYA==
X-Received: by 2002:a05:6830:33b8:b0:758:71cd:895a with SMTP id
 46e09a7af769-75871cd9072mr2896458a34.29.1758044645692; 
 Tue, 16 Sep 2025 10:44:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7d22e0asm1816526eaf.13.2025.09.16.10.44.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:44:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:44:02 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Gitlab CI slowdown
Message-ID: <20250916174402.GV124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iWHlEJO4T4hx1FsE"
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


--iWHlEJO4T4hx1FsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Currently, Gitlab CI runs are going to be extremely slow on the final
world build on arm64 hardware task. While we had previously had 3 fast
machines available here, one of them was decommissioned unexpectedly a
number of weeks ago and the other day the UPS another one was on died
unexpectedly. Currently this is expected to be restored in a few days.
Our third machine was disabled for a number of months due to some issue
with the machine itself that seems to have been resolved, however it
also allows for multiple concurrent jobs so it will be slow when two or
more pipelines try and world build at once. Thanks for your
understanding and patience.

--=20
Tom

--iWHlEJO4T4hx1FsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmh2wAKCRAr4qD1Cr/k
ClLVAQDihRI3nD2Ag34TWjoLGWFvhK46XFxEP93IHf5b6jlg5gD+JUyrFn0SURQR
gNwAcsYOgwQxsJPybi5NHABL1u0lqgk=
=y0Cy
-----END PGP SIGNATURE-----

--iWHlEJO4T4hx1FsE--
