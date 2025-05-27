Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E14AC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 19:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9885B8388D;
	Tue, 27 May 2025 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JdclOYxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E7D838A2; Tue, 27 May 2025 21:44:52 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33C68312E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 21:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c2c754af3cso2830079fac.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748375083; x=1748979883; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oC6bysBm+rgJKyzlVGDMZgncoNN+kz8g3DbELA8l17w=;
 b=JdclOYxmrbo+oMK1NZUFsONXIcGYq3qunbZMcLNII+fzKyIoFht2INCuMxCs9ikLWE
 w7IgWg9gbNgNhqUY2VexzOVIu0lbiPXNLih03o1eN1ouqQJ+9ksuQSOna+RxJm24npbz
 gKFiywUCxkVCiWyzCQ6B3lWmgTjgCIX4HMtYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748375083; x=1748979883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oC6bysBm+rgJKyzlVGDMZgncoNN+kz8g3DbELA8l17w=;
 b=CELFjt3xOyREQvhc+ymrfPBBqUoMtXcRaCKSJHgIW91/VwFlOEZI98mjjaR06leceN
 8srRt9P7Wx8cZFkuKjiK4IHoeAL6BJtYSBbc6j2daA5HQ8hOWCw4VtPDjyK6+Sy6aHkp
 uGUqCL2DVHMSNIa0B/wOu2jN/3BmK9prOzryjHL9JETwc2IhC1VtGDx0nzWgNK3QiKZR
 bd7XB4CBXnMmdBG11uKddI1+HPU6OE+1SFwlBr5JbLYGtmQC+wM71wwtMaeJOG3uD/rP
 fhzXmBpdPO8z0sfuWo6oET80IAYnG+MWbEDaPh+a9NpBSNeyYJNJf+c2LnChH6SurfPW
 LTCQ==
X-Gm-Message-State: AOJu0YyLE4LX26t4MQs/Igl5wxsBn6+llUXqeKibKijL/VFz+t+laAg9
 0cm3SWlOLvcT08N/R15OA3xtYQLbQKruiGShXFsdjlMTvtCWvITmS12QDcIVKcyqA34Fo6D8wTp
 SEjDTSVU=
X-Gm-Gg: ASbGncuOnK0heVnmQ5w/jb3t5HCnVceHuamp4HIFBhYzf1ixYkHuBHGIAODklhcBaBC
 J/v/jbKrvbYKCFlOXYWIERM40jX7kqVwk/PcrEkm19NRt4ZGoqk5DiHaYJYvbuKV+r4tNY5QFd0
 3lKSCvLq7bb9SOjFQ9h/soDaPDh2/bI6C8Tj7hWPC7KLnX9G7d4AaXrNcNpGJ5xjjoSHl2Xr3OH
 u0OGiyt66AaoYqoxl0SO9+VsWPuLoIelGy0sIn41eeg6wYxHlB4YWb7VkuwMAt3/QBrcXc45Fmj
 nmm+3cecyTXQtHVO6TXz0/7iyZce5mYz5Z7N3L6Tyvz6byNJ8JYkr4wf9WBbF/BSG9B7VssDKvJ
 yg4N/IfLM/Y5r
X-Google-Smtp-Source: AGHT+IGaD7ZvSV3mbaKwMIBa5K0WCKoemMZPuhdMRhr7x5iCPrQaPXb4IBxMNYYvoTgA02a3NRc1zg==
X-Received: by 2002:a05:6871:210d:b0:296:9c08:51a3 with SMTP id
 586e51a60fabf-2e86224b7cemr6435548fac.39.1748375083581; 
 Tue, 27 May 2025 12:44:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c075b1fdsm5546720fac.24.2025.05.27.12.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 12:44:42 -0700 (PDT)
Date: Tue, 27 May 2025 13:44:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc3 released
Message-ID: <20250527194440.GM100073@bill-the-cat>
References: <20250526220311.GF100073@bill-the-cat>
 <20250527193448.GL100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O8fUaRNVjhG1cFSz"
Content-Disposition: inline
In-Reply-To: <20250527193448.GL100073@bill-the-cat>
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


--O8fUaRNVjhG1cFSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 01:34:48PM -0600, Tom Rini wrote:
> On Mon, May 26, 2025 at 04:03:11PM -0600, Tom Rini wrote:
> `
> > Hey all,
> >=20
> > So it's release day and I have tagged and pushed things out. I will be
> > updating the next branch shortly. There's still a few things that need
> > to come in for the release, as fixes, but otherwise I think the next
> > branch is where most changes should end up.
> >=20
> > We're continuing with a community meeting following the release and is
> > the same time as the previous meeting. The meeting details itself are:
> > https://meet.google.com/btj-wgcg-euw
> > May 27th, 2025. 9am (GMT -06:00)
> >=20
> > To join by phone:
> > https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
>=20
> For today's meeting it was suggested to try and use Google's
> transcription service to take notes. What follows is a lightly edited
> copy of the transcript. I will say it took a good amount of time to read
> and re-edit. I will follow-up with a lightly edited Gemini summary, just
> to finish evaluating this idea.

And here is Gemini's summary of the transcript:

Release Updates

* Tom Rini announced that Release Candidate 3 (RC3) was released the previo=
us
day and things are generally in good condition.
* There's an outstanding issue and revert for the ext4 overflow issue that
needs addressing.
* Kernel release v6.15 is now in the device tree rebasing repository, and p=
lans
are underway to sync and test it with CI.
* The community is encouraged to test the current state of the master branc=
h on
available hardware in preparation for the upcoming July release.
* Regression fixes should be brought to Tom Rini's attention with links for
tracking.

Kbuild System Updates

* Ilias Apalodimas initiated a discussion about updating the Kbuild system,
which is significantly outdated.
* There are two approaches: incremental updates with detailed commit messag=
es
or a large diff to bring it up to speed quickly.
* The consensus is to prioritize updating the Kbuild system over maintainin=
g a
detailed commit history.
* Ilias has been working on porting patches to bring the system up to v5.1 =
and
plans to split makefiles into an include file for easier future syncs.
* The aim is to get the current updates into the next window and work on
syncing with v6.15 afterward.
* There's a desire to enable compiling with LLVM for catching more bugs due=
 to
its stricter default flags.

QEMU Issue

* There's an ongoing issue with QEMU on the vexpress_ca9x4 platform,
particularly with TFTP crashing.
* There's debate about whether the issue lies with QEMU or the U-Boot
implementation, with suggestions to engage QEMU developers for further
insights.
* Peter and Richard Henderson from QEMU have been consulted, and there are
assumptions that the problem could be due to unaligned accesses and the MMU=
 not
being enabled, but these assumptions might be incorrect as the TFTP crashes
early.
* Ilias plans to debug the issue further by the end of the week.

Continuous Integration (CI) Discussions

* Jesse T asked about making reproducible builds in CI, similar to Buildroo=
t.
Tom Rini explained that the focus is on using pre-built toolchains to avoid
compiler build issues.
* There's interest in setting up a CI bot to test on boards. Ilias Apalodim=
as
has past experience with Buildbot and can share configurations. Haiko has a=
lso
worked on tbot and integrating it with GitLab CI.
* Jesse T raised a bug found by a professor on the DE1 SOC, possibly a comp=
iler
issue, and shared build scripts for review.
* A CI discussion about running OSS was initiated by Simon. Ilias mentioned=
 a
missing kernel module in Alpine, but is working on adding it to Yocto for
easier testing.
* Simon has a test that boots Ubuntu 2404 Desktop installer on his lab, but=
 is
interested in CI testing with smaller images like Alpine.
* There are challenges with booting OS images from RAM using EFI and handli=
ng
ISO images in CI, leading to discussions about network booting solutions.

Other Topics

* Jesse T mentioned a bug on the D10 standard board, not the D1 SOC, and sh=
ared
pkg builds via IRC.
* Simon Glass and Ilias talked about a hang when running QEMU on an ARM64
machine with KVM enabled, possibly related to out-of-memory issues with blob
list.

Conclusion

The meeting covered various topics, including release updates, Kbuild system
updates, QEMU issues, CI improvements, and other specific problems encounte=
red.
The community continues to work on enhancing U-Boot and ensuring its stabil=
ity
across different platforms.

--=20
Tom

--O8fUaRNVjhG1cFSz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg2FigACgkQFHw5/5Y0
tyylYQwAjNF+VlUQ50QlR+y0CC0+rT8gBZJV6XB+WkuxJT8nHOUlm9e1rdEWyMi/
ysN5PEFy1pxEJmX7DvIjjujOSmql9oVtshiFkxC0Fvv/2leGtGrVog/XqhoXUcpa
d/26+0cb9vG8UqqAZnaeEYOQ+ZpRvy9gyyF0RcPffoBYBFZINTfn2fdGTii6cFPB
+36qCRfndhuJNGYyB0uiFp2RGsiKZLtO7fAPttBQAfyIFWBfFQSOfxTsFR4XTF+t
g7+NsXcNhiHB/WhYRX1vtWsOqwdb9oLB5wYwFwwIStjoTL52XjYXl+e2j0SgCkew
QZCC0anXeRA8Xyh9gW2pH8jjxHV203UVpZnk2nZTCwWWC+G0aQSbKUjXQ6YZKV7P
Tp4QrZo+kz7EUNcCktlPp/47QMx1FwQPSZMxBg8muOqgbErWUYubDdQ2187OK2AR
aJq6LsMGG3jxFUM4EsHVKcEX62q3UwKeiGq5nTbViv6cRviv6tsA8S3W3s06GHjA
GNlC5HEB
=6d0z
-----END PGP SIGNATURE-----

--O8fUaRNVjhG1cFSz--
