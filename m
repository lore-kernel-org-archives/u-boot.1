Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0028C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75530406F9;
	Mon, 10 Aug 2026 22:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAfHjHx9so7E; Mon, 10 Aug 2026 22:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D6EC406ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786402182;
	bh=/RByJ10W6tO0shaXtcgVKtGo3e/VDpu9i+ZSk0/weWQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IMcAdevMjJE9mAfUKrhPBPVyfku5W+bLJ4QddWkiA+w/fy/FIv8S32l1s02tRdKGW
	 l4XNc0hQ2J/QjYt9jWiTBtjx0UFQd6z8jwM51dQOUzj7LaRM+nOZnqswLGGNAhioF5
	 VmcHNStHta1MndNGGI06YReWHAa8zOR4jsLwXAhGfMW16EbcwW7ZZoqZZJCL9OjRGy
	 3nUAMCJmmdUoMwuo8MEgMYQl1qkp5soAZBNrQkwgVRIARvINZ6Tut4Rbc3wc5aK9ky
	 mATKexb4RubZ9bLRJpfb0h+TjZgUyK/Hg4pbJwrPsAXZeZcg3RdwyT0OBH+dUoUeLd
	 KsbS+nndQ2Fcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D6EC406ED;
	Mon, 10 Aug 2026 22:49:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3699D4E0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28E9A60628
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-FJ9100C1wD for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:49:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3864D60792
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3864D60792
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3864D60792
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:49:39 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb64085c45so1919457a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 15:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786402178; x=1787006978;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RByJ10W6tO0shaXtcgVKtGo3e/VDpu9i+ZSk0/weWQ=;
 b=U2B9nnVbgLul9roZRo+rn5vxSE7G4HMYmRD26+dBMIAtq6p/aEhvE1mDHxkPt2PbfK
 gnugeIoE58mAQD7l3iQ3Yy0Sb90CMq2eLXVmwIA3/XzLodgK+weNHH6HAE8s3KfbQKDt
 kLioL/TpIXSS1unax8llHhjZavFZ48ibB107fgtB5eM9F6CRKGG83FRue2Hx3oxm+dyD
 uGI96SOWgBFRGanEszG0fKr0cNKblt3PUa8risVd5i9sAR738x5OE2zkNDw4GO0HYTm2
 NDS5Epck6qBRtp2JUN3jKKFnmbqVJZPyw75/poH2TYmFKTacGiRRd2F4SSOM9WRwGflP
 GCaw==
X-Gm-Message-State: AOJu0Yx55/nTlYcydnE83sFlNsgmiEpvWmZMjXOAKRp968d6uRGFs6Fx
 h945tp0pXTR9yu4O4Yh5rIStGMsSfNhWBWQ2PxMLTTtnt6OKzz+ZxI6EWqRHEFr0vGXGfu669S0
 cG+zbzSY=
X-Gm-Gg: AR+sD139hwAxBHvO6b+q8D53Z/ggTaHkFatVwEiU90xiFNS1DBhfFkx/enl7FkCnVQY
 0OFnW2laWzOELpBPDmaWXGLBvTbywxF1IOJDeoze6gLF2dcW2ksfRMGp0aC+2FUq35dtp1dAjyz
 BbJBMkKpJuzLanv3w3aGMPr5uYh0siaDc3PmCeZgqTV1WJox8hwtaIL73SL7WosS3lhAup3T6au
 HFAL3kmKvCDE7C2CIPDL4Rb4Mro6lWn+ntYofAqW3FUm3paHQhuSHKlQL4fvuzcGP5jLaBnMBuh
 JXH1/qtSujEGQK4XmoCgTVwRKRwtg7Zq7TMBJNAUiwCRgYKIKu6j53UJqtTSkXjRdCcz55bLIfH
 Tnx315Su7FFY9TeK1d6U6ZpD7zf6Z1qJwboQ91PdUniIPyNd/MlSdhGhQl0PRvVxNW57HWftjLs
 s+CThMIym/LzrAfKUMicO+ekGs88ZWSRhDbd+V8ggPZ9wrBAH+rlPqxrWcRsQPAItkjXdBN3LlG
 xcEVwolm8hflg8JDBSNbiNaOsmlZcVgmGOvKHBXggNa2TFgTnaKgKi4mohYqBrUrScVmLXkjTAG
 zlX3a0ooyA==
X-Received: by 2002:a05:6820:3388:10b0:6b0:4c0b:9698 with SMTP id
 006d021491bc7-6b04c0b9762mr7467280eaf.18.1786402178034; 
 Mon, 10 Aug 2026 15:49:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be475f7sm9662681eaf.9.2026.08.10.15.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:49:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:49:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10-rc2 released
Message-ID: <20260810224935.GG1160436@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T4//gx2+ehAe1QEH"
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786402178; x=1787006978;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/RByJ10W6tO0shaXtcgVKtGo3e/VDpu9i+ZSk0/weWQ=;
 b=hlcphqpSa3XmPp6UEtjHuYicWh2uc9I/X4KVdfZplivLAJofVkE6TSAW600pUR8yxZ
 flpph09+nQkrbbDDKWwwSJQtZuSCbHonzKqctbD+EBvqREjqyrfw9qHRoMUhJ0bkC1P3
 A048bs4xNPt79QxcfHo0ySq80spYeYIW+7fzE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=hlcphqpS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--T4//gx2+ehAe1QEH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

First up, we should revisit things I mentioned in the -rc1 release. The
mailing list migration had a few more hiccups after, but we should,
hopefully, be set. That said, I do see one more issue that I've raised,
which is that I believe due to how DMARC works, some patches authors are
being rewritten not in patchwork, but in lore (patchwork has a fixup in
place). I'm keeping an eye on pull requests and will do more fixups as
needed, until we have things done. But that means good news,
lore.kernel.org has caught up with the move and the backlog and I don't
see anything missing. And, the move of our Gitlab instance to
https://git.u-boot-project.org/ has been stable. If people need access
and have not yet gotten an account, please do so soon.

So, the git tag has been pushed to
https://git.u-boot-project.org/u-boot/u-boot and the release itself is
also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/

At this point, the next branch is now also open.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZ2IwbH=
R2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/jwj-pqka-bnj
August 11th, 2026. 9am (GMT -06:00)

To join by phone:
Or dial: (US) +1 929-277-5781 PIN: 115 674 167
More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090

In terms of a rough changelog:
- Platform updates for i.MX, TI K3, Marvell, atmel, Renesas, RISC-V,
  MediaTek,=20
- Fixes in our DFU, Documentation, EFI Loader, UFS, NVMe, MMC, USB, FWU,
  watchdog, and BTRFS subsystems / drivers.
- Update to v7.1-dts tag for dts/upstream
- FIT images can authenticate a dm-verity roothash.

I continue to plan to do an rc release every two weeks and the final
release will be 05 October 2026.

Thanks all!

--=20
Tom

--T4//gx2+ehAe1QEH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanpVfwAKCRAr4qD1Cr/k
ClckAQCOJy/052lnTKRuQIYYZury2Vhc79PeRx8d2RiKOa3ImwEAyK8OFlrvzDTT
8nq5dBZVeug2VeRKsuZQjluzJjhk7AI=
=kG+S
-----END PGP SIGNATURE-----

--T4//gx2+ehAe1QEH--
