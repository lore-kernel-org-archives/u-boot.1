Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB40AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265A9805E7;
	Mon, 10 Feb 2025 23:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SWLpQzFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6054C805E7; Mon, 10 Feb 2025 23:02:03 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D76803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f7031ea11cso46895217b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739224915; x=1739829715; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XTNQ/67n31JahXlCwrqi304QlkRKTeQKAJXblozhsYk=;
 b=SWLpQzFRTO5oT4Nlvx9cVU1m0LaL61f/vbAalLwgMBEvDxTC8WkvVH/irsiPqc4w0g
 GP6w+CF/Xe/MYUMXTxSWRpzXc6T0D6J5WtY2XeVhMi98kb26+98eSDasNF+gd83oWbVJ
 fzf62vF8pmssW8dqKzFQBQmBhW8mLBpkSdoEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739224915; x=1739829715;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTNQ/67n31JahXlCwrqi304QlkRKTeQKAJXblozhsYk=;
 b=V2vi7CM+ZI2GHMbvkBplGfSXvFgkuUeFA9DUv4QSFQ+PIUU2nvyufOIWEQkQsi3dIv
 E0xtK8hTs8cPtLH2FUxDNijv3DsW84xjuV77HSAPR1nEVTy9ZqrKuJnniIACTDaLKpTh
 IorHrCuoiWDrJlb7WqbowO4u387MmGncxgJ8aVxBMf4vuwCpaT3NAuObSEoDIsWVgTUZ
 P4ltcy/RNA8EOWKKiTncqOCf9epqvOK8Z5IcrCOZx2jdgiocHyLFq7L0jJmClSARNsug
 P2mIjoOfjSDJL1ZsDOptQpv3MdXghYCZAsCXZle0X/38P5vO5DNAxqxJYIMPjqKI1VzN
 Swvg==
X-Gm-Message-State: AOJu0YyRhAOvKNbY10jPz89pxHm7Skz6ypy04pkgdJBqsrZmENtlfLu8
 gS9TU4v+ISGKaU/wUBc8Cg8EYaNh8DBz8Ocnci5MAEE2+5eTww+kqKZWcq9W6Oj5+CaU/hYRwnQ
 Z
X-Gm-Gg: ASbGnctUirJcItMWZQzqiWpyjS58l+RCZ3g5nwEAgV8Htv9uGcD23aX0cR4GeQM1xvj
 0unmDW+DEnadWyD3FBLXIU6g1/t7tkmmCJmqsliMfBDg4doA41G9kG/3qDVqtOVAs7vfm0ezlg4
 Tv2seiCMuQPH+P6bP/tntp3ATJ6cbUduvjLNCBfpzunRLnGwemIJH1SO5iYnul/YxqebqbS8qMF
 gHcwdlB69VLltZcZb6ZHFTfh8gNhSh+80IFR8n7XYPDPtWS9/sOGYAPl4WYheyzHlWX6XW3n4y2
 F92bjWfxcCPTVQE=
X-Google-Smtp-Source: AGHT+IHWbyfPa2TulEmDqeJN0+k212Y2/TY9jVUNHSg0VLqqmtkjNh3ol08kOQK/iTVIq+JDiJBrNQ==
X-Received: by 2002:a05:690c:338d:b0:6f7:ad8d:f566 with SMTP id
 00721157ae682-6f9b2a1a03bmr136288157b3.36.1739224914064; 
 Mon, 10 Feb 2025 14:01:54 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1fa90sm18443567b3.45.2025.02.10.14.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 14:01:53 -0800 (PST)
Date: Mon, 10 Feb 2025 16:01:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04-rc2 released
Message-ID: <20250210220151.GR1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o4XHMhhhGY9gRYtF"
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


--o4XHMhhhGY9gRYtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here's v2025.04-rc2. As this is the -rc2
release, I've now also opened up the -next branch and will be stricter
about what I apply myself, and what I see coming in for pull requests as
well moving forward.

Continuing on with what I started after the -rc1 release, I've
scheduled a video call tomorrow at 9am -0600 and the calendar link is:
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and this is the same as last time. I've edited that event to be
recurring and will tweak it as needed as we aren't quite every 2 weeks
every time, but close enough.

In terms of a changelog,=20
git log --merges v2025.04-rc1..v2025.04-rc2
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 April 2025.

Thanks all!

--=20
Tom

--o4XHMhhhGY9gRYtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqd04ACgkQFHw5/5Y0
tyy8pQv/TY0kx12RyBfWMj4ticQ4EQ6Eo3HELXcsZVLIn76is7NHsvcdabMB+DGY
ltpKK3SMxSXcexiwOKeIVSPPmNl0zjJoydi40niV4RygqV04OpmDorf0rFFWas6F
VxUvuYmDhminomPOHJAOZ0JjlWHKMGDzTzjL1iERvkpU7NXJ5ku41d82uIexDSI5
a2tRfT1r3paK4fJ/Ss+simRwb5TLPGwNMCwSv3N4PXLzmAwoos78Oc4QMXwyEO06
0aLzr7uirvJ+ajVcgaZ65xJ7IoZO5knCIw9BeIyNwiqz8/GNF6C6apD+9aBp7bo+
2OhmSDJKwZZWBCUMyDxug6TUyIDum2K1ATniYm6kzh8Whqhfq+4H9ArW5i/cocby
5wanI8dz0hwM9loUt8pOYXE9SLzGUM4bM+BpUnTT1KdyYKqmBBLkoSEiYLLM69mm
Hkdo81WE9S2Rgb0/CHyx5dYmGThU+oGGbhS2mF3OQVPi8mWodW5wOBreAldhYZJO
8ZyAMCDK
=boV0
-----END PGP SIGNATURE-----

--o4XHMhhhGY9gRYtF--
