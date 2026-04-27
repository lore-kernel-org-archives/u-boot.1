Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5072FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3401784106;
	Tue, 28 Apr 2026 06:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmAVKDIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD0284119; Tue, 28 Apr 2026 06:02:50 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9A784099
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8ef5776530bso703491985a.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777348966; x=1777953766; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=djWNV1Ug9iw3oST0AT9jWwvGxXJp0ibox2umG5kTso8=;
 b=jmAVKDIL8Jq9bjPrKzr1nC4VUZmaz4MObRGNEV5v1fcupgHF86pnA7vzV672BiuHcy
 VL6TV4lGmpv/6alKVZfi89lRHzkaLTPR4naHZLM3T1eWAou8/KskvDV7eXzZeil0wjvB
 fpCOBZoWNU/9sNmt/9HK4E8Lmun7dBeWTbAcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777348966; x=1777953766;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djWNV1Ug9iw3oST0AT9jWwvGxXJp0ibox2umG5kTso8=;
 b=m9I+Csjcwn6HFPvpFsVpDoiDJpF/hnQT94QAonJCNUGlkCDdo0HRxAhN/+ALI/izLH
 LtN4ImNTYACrPakdN1Yiv9lDrIxDj4CpWI4kRoyU5Gz5X5z7ki0D+wlzkA+XuiV4xUxq
 Rn758NkQRssdPvIkWsd40MWqlZrmKorEPbwrUzV6T1KYlteNBiCl4GKYdHoRU+SQ2gJn
 AmW9B+gq9TEb6agHlKZroi2dCazFZ49HjPDDmn3ss1ScF2XkXqOmCei/J2kYpnu5DXOq
 pihRuO4HAqzy1/JVM4e63XwucSElObQoEOwircNszFI7grK/vpaovQQFyHmP5vE+5qRw
 26rw==
X-Gm-Message-State: AOJu0Yye+jyb7JQnBxoRHiAFNyowU68xz+bO0Sx9iNGplLqrcRNEsB3q
 oVhsMbkXA0HbK7su+R+/J9HN+I6k4H9pm4gr92fsOjIqbzLampVEbJdFEgXyT5+EFNRwP2oYzDq
 yrDTMcfCkeCLN
X-Gm-Gg: AeBDietXuR5SPME9kLslsDXVwPfY0x7tLbiFhu7fnztqx8hI1YJ8gNKnXahLb/WnzIb
 ujBJjZusuqZUFixQUIK8eYWQoGSEq6vyps6rxI5MuUD5OBMPqpTqsT185zkcymrhL2DnYuHfbfd
 cstI7bDwB4TClb0JKKjQ52qnQw/fnPgJc6jRVg+89SWkrqW/FKqNOEbfn7P+/1V7YqJp86Ey8PG
 yGqJFLlTIvg58/bphzbSaIgTTeIEGnepAQKzWScAuZ7BQ5R7r5vAf03VTSDpRPX5yfvC3+A4lbl
 sjxwMH5y2ihy9+9xmdX3UHfo/UQOdFq9rRfVnyOYqSNXyKPFrrxZWIAO6Cts7HkffAVPebzGSMU
 QjmyEnKi5b+Sc/rga23Wal9ssFwU6bpMrT1WKymxsUrLzL7UVSB+LAnU17cN2hoxtKfoqP6CsN7
 6zTqy6T4r0Hp96Ds/i8fGx+FGs/RL1cL/sdcAYGyCXf1d7yRUwSSm/dfbJOfc+pd0z+KWcCFrOa
 mBjv7xM0lxFvFKQmBzEDtW/HIOrt09rfDGHhNP+Wsbpi0r6KNKye3uxK9wiPg==
X-Received: by 2002:a05:6830:3813:b0:7dc:dd58:50ab with SMTP id
 46e09a7af769-7de9a0b5f96mr512589a34.14.1777331125004; 
 Mon, 27 Apr 2026 16:05:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de986d6cd0sm626659a34.22.2026.04.27.16.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 16:05:24 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:05:22 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07-rc1 released
Message-ID: <20260427230522.GP41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/MLUozQ11QqC8XP3"
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


--/MLUozQ11QqC8XP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

As I believe most people are aware, we had an issue wtih our mailman
server last week. We have a migration plan and have been working on it
as quickly as circumstances allow.

With that, content wise this was a regular merge window I believe.
There's a few more things I'm expecting, and others I'm hoping for
before -rc2 happens, but I think things in general are in fine shape.

One thing I do want to bring up is that it might really be time to
retire support for running our tools on Windows under MSYS, rather than
something like WSL. The move to support more modern OpenSSL versions has
hit a lack of support problem in MSYS[1].

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/yyx-dsaj-iwr
April 28th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog:
- We have synced with the v7.0-dts tag for upstream device trees /
  bindings.
- Lots of platform updates. This is always the case with -rc1 and I
  never know which ones to emphasize.
- Fixes in our UEFI, SMBIOS, MMC, DFU, USB, networking, UFS, pytest,
  virtio, hush shell commands, squashfs, environment and FWU update
  subsystems.
- Global cleanup of "gd" inclusion in code.
- The legacy LED API has been removed (thanks again all!)

I continue to plan to do an rc release every two weeks and the final
release will be 06 July 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/
--=20
Tom

--/MLUozQ11QqC8XP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae/rsgAKCRAr4qD1Cr/k
CrT5AQD+5PiJ6zO7Fg5B9SjRHhwQDDG3hVOfQTXFVE9XwiChhQD+MSWcewydk+ON
8IFQOdDodzNS1ZGVcP1TH0bNYN2WqAE=
=MQ9K
-----END PGP SIGNATURE-----

--/MLUozQ11QqC8XP3--
