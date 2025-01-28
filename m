Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3C8C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 17:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3BF81E76;
	Tue, 28 Jan 2025 18:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtA7+fZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC4C81E76; Tue, 28 Jan 2025 18:19:30 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A9181DD3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 18:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d88cb85987so53986096d6.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738084767; x=1738689567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UvNCZrn+u2Xb4+IBZLTlzABEutg0N7I/op3Rjn0vTCY=;
 b=ZtA7+fZcf1b1D8VE/yOB3mOfOse1XZiPhbKBzxq6NlTzVDjn1JKBDN2QeacMvnroys
 +3b+EE7IyojNyK+A49LH7/HKKoVJ+zCJoSQoEDMGuk6KP+Okq7cxllQqjzx8HEMU/V93
 aiBE+7aLJ4MmaVG5cT5PX0nfVv2ezk5GZ31Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738084767; x=1738689567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvNCZrn+u2Xb4+IBZLTlzABEutg0N7I/op3Rjn0vTCY=;
 b=UMhE+ifpC80kH8vTAPpXqnGegFRPasKzKdaNeNbge+NrZn1gK8hCfXDvFJ2CTnEGlo
 zzqWCUuNroy4VDTpk6UJhQ9JeZaL6igO89ryISjzaKLGTDBhBoAiSD/GZMGYNrAtpe8h
 VaJVrBNpgZ6CgWyMsgDChDx+KsffElf9334MHhlGYDqGCjEFDTzOltVS0IjqeJVadN9f
 46/FAqq7hR5AdMm69iWO0+MPAx+B/xoO4VsKZoC1ndtVCdRsIoedLmkqG5qFmlJ4wCvz
 vfg9860mKM7BFzoHtnwo3Mey7KehpOWeLTdKpl46XSWw88UbvzYCVbyMCyFs6D3PvEWu
 kJVw==
X-Gm-Message-State: AOJu0YxU9xpfJTP2Lv64uUmSM90/DVsHQt5vbvz+eZDx7Fa0TO0UoD0x
 LAxk7VfSkjf1LACjK1biPHn/dmrh9nghy+AFULcmf/RVakAJuYvh7pUZvVA0zQPGKKFv/XbW9Mm
 s
X-Gm-Gg: ASbGncsUatqYqByPltjjmnbIpPCJVnVS/W0Gx/C2S3kEA5nu+/7Haea2akvQdyYgOdA
 kNiQqeY2PlEAFOz8BpzQ7W9/66R65phXPDubjPVXjLtbzwoukSVo6t5XWn/qQDkPxvUMqye0GSL
 h42/+cCAXVcbNhqQi/Cxz9icfEbRuWYWqVoJ9nfrTFAp5OLvGJH5lb0msXuiZvuGkUGxp6tn1sg
 rP8tpNqMcKnVj1UIisnxPogkkcCfJDwtRyjez0ImVVZMBrBtV3By/0oR5IkQifP9wQ3ZUHQPMCX
 nyWo6Grzs0fHtpU=
X-Google-Smtp-Source: AGHT+IFxnp+4/vQ8Zgas5psNv7l0uZQsgSbJSu31wax0bAe4Bb5BaENstEflxm24gnPIMy3Dyas08A==
X-Received: by 2002:a05:6214:2466:b0:6d9:162a:27a2 with SMTP id
 6a1803df08f44-6e23684ce96mr59363236d6.21.1738084766630; 
 Tue, 28 Jan 2025 09:19:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c54d8sm47031866d6.112.2025.01.28.09.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 09:19:25 -0800 (PST)
Date: Tue, 28 Jan 2025 11:19:23 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc1 released
Message-ID: <20250128171923.GQ1233568@bill-the-cat>
References: <20250127224021.GH1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gPAnQamHRXKIIeIC"
Content-Disposition: inline
In-Reply-To: <20250127224021.GH1233568@bill-the-cat>
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


--gPAnQamHRXKIIeIC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 04:40:21PM -0600, Tom Rini wrote:

> Hey all,
>=20
> It's release day and so here's v2025.04-rc1. For a -rc1, I think we're
> in fine enough shape. The next window won't open until after -rc2 so if
> you have some outstanding patches that you think should be merged to
> mainline for v2025.04 please speak up (or for custodians, send a pull
> request).
>=20
> As I mentioned elsewhere, I've scheduled a video call tomorrow at 9am
> -0600 and the calendar link is:
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com

If anyone who couldn't make it has feedback about the time, please speak
up.

> and I also send the meeting invite via Google to the mailing list. I
> plan to do these regularly, post release and depending on reception the
> time can be adjusted or perhaps duplicate meetings held.

Here are my notes from the call. Anyone who was there should feel free
to send any corrections / updates. Thanks!

- Introductory remarks from myself.

- Michal Simek brought up the "SPI issue" that we had in testing
  v2025.01. He reiterated that it was tested on AMD hardware but only
  there as it's what they have access to. Ilias Apalodimas is trying to
  setup access to testing on Linaro HW, and has been for a while so this
  is still ongoing. Ilias noted in response to my concern about HW
  longevity that SPI NOR should be fine to test on, but that SPI NAND
  might need to be tested only weekly or similar. Michal noted Love
  Kumar posted the SPI tests that AMD uses. He agreed that weekly
  running might be OK, but they (and other HW vendors likely) have
  plentiful HW access, for their own at least and so wearing out a
  component isn't a concern. Finally, Michal noted that they want to get
  their HW working and can isolate the code as needed to not break other
  platforms.

- This segued in to Ilias noting that we have the general problem as
  well of getting things tested. Ilias asked about perhaps being strict
  at -rc1 instead of -rc2, just like the Linux kernel. Would people test
  next more if it was required to be used more? I said I was unsure as I
  had thought that I had been good about being strict with the -rc2
  cutoff in 2024, and the problem being a lack of testing of the next
  branch in general. Nishanth Menon talked about what TI tests as well
  (and showed some graphs/etc), on the topic of can we get more broad
  testing run. Ilias noted there's some outstanding patches that will
  let arm64 boot and run an OS image via dram, and this could help
  expand functional testing. Nishanth noted there's many testing
  frameworks in use, noted using a common test framework would be good,
  and that while we have pytest it's not been able to be integrated to
  their framework. Michal Suchanek suggested moving our pytests to UT.
  I asked how do we handle FS tests for example? The answer is that we
  would have to create the images outside of the testing framework in
  some manner and tests will expect them to exist. I suggested it would
  be good to see someone convert some of the more complex tests to UT,
  and we could use the Dockerfile to create the required images as to
  not have to rely on unknown binary files. I also noted that Simon
  Glass has noted a number of times that pytest is much slower than just
  running UT for a given set of tests. Ilias noted that using pytest is
  a bit of a hard learning curve. Ilias talked about how his TPM testing
  works, including using a VM to boot an OS and check the TPM output. I
  talked about how this could work with pytest as well. Nishanth was
  saying that in terms of a framework to enable the community to do
  tests, the kernel community seems to be ahead. He sees 3 key things in
  testing frameworks which are, the capability to do distributed
  testing, scale up from testing at the developer's desk testing to
  testing in corporate farms, this means having reference builds
  available and moving to a pull not push methodology and a centralized
  reporting system. It is a bigger, but tangential problem of scaling
  and standardizing testing. Ilias noted that some of those are
  orthogonal. Michal Suchanek said this is where testing diverges. I
  noted a reason for pushing for Labgrid is kenelci uses it and in turn
  this could be a good window in to existing hardware farms, Michal
  Simek noted problems with getting corporate IT to allow labgrid even,
  and this can require a separate lab. He suggested getting common
  reporting of common testing would be good and gave the example of
  being able to record the commands and results used in AMD testing
  environments. I mentioned perhaps saving/reporting pytest xml? This
  can be viewed in the pipeline page of a recent build (artifacts aren't
  kept for too long due to storage needs).

- This had a short follow-up with Ilias asking about if we can do
  sandbox tests on arm64 hosts in CI and I will follow up to enable that
  as the patches look to have been merged.

- Michal Suchanek asked about building 32bit sandbox but doesn't have
  time to look in to this right now, will file a gitlab issue instead so
  it's not lost.

- At this point no new topics were raised and I thanked everyone for
  their time and contributions and reiterated we'll have a meeting again
  in two weeks at this time, post -rc2.

--=20
Tom

--gPAnQamHRXKIIeIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeZEZYACgkQFHw5/5Y0
tyxQfgv+JGn1ngRf503TLfkLH/N/pbbd76M4R45pt0zA9aZp6/z6/XHq4vbVFgrk
Wn/rUXG02tx5+nZL4aZ9jdEdNgeJ6mO1PV9u4og9mAsNfrYsUaoIgC9RmAzG2K+j
cK39UoQux+yaOn/PfpL+TvmM1U98IFxoQmtcUVHbtzYri8H31GA7dWMcqzC4/hIa
bCkgUAm4EjrrPc6rkfluERZiard9gtcOI88XC8pvAnGBLr39GOJniSFCB4uv9t62
B9uox+hhB/JtpeA06aAjFPkcV5ZofJVRNE7TdnP+d229Pjy5hzEFQ7CbAXsSMyki
YCKHvYnudQxB/9yUqFss4yusA58xpkk1iA3Lz6OV8v3WPF57BM3aHo5WSw4yyiAM
lFXFVD/BOA7n1jZu2r3X43vDNA2duW2pbj9nw/BTF9JtSlJoT+jcr7kAKI/l6q/V
tmS9iPGtcwnZkTOvRmzHPJne1M5Hh/iAkoURTjqw0XMjkSkdxDqIryeFlgqJxSQ+
hx38RQRw
=A3Oq
-----END PGP SIGNATURE-----

--gPAnQamHRXKIIeIC--
