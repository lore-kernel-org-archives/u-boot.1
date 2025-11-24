Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F3CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D54C83E3A;
	Mon, 24 Nov 2025 16:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mhgpXVng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823EA83B85; Mon, 24 Nov 2025 16:29:24 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C68C83DEC
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-656de56ce7aso811343eaf.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763998160; x=1764602960; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vSAPJIR8+0xhNdx+RoOl2VHR0pwlBz05sfV11b6sUk=;
 b=mhgpXVng6HEDLRbpXwzcXEAWWtUMjzlhoOkNXCJf5doThs8zLRZNz3zmq9nNhwdDMC
 v9Nu42XF8XmeGl++1xhd5K/j5KFTuDtiX6ym1rwm2FzAT8MEvp/xe3EN2Ug6/qq3Xc7g
 nWFM5QnoZDLGb35m7KvXsWjF16reEAxT6rVZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763998160; x=1764602960;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7vSAPJIR8+0xhNdx+RoOl2VHR0pwlBz05sfV11b6sUk=;
 b=h0MkUGShglBo9GgKDdvEJQiL6vrXZmfHKqhEAwr8u0entMnZlQoNTesk85yyAZpOBT
 Havo90CDXbCqsCJ7w9CfRu7zzjYGwMENd04W7rqYtEVNjzs4yZe+BysV7TBrj+l7QWRx
 JBjVi0vFhPJWoOz2XvNr41+9oo16Ok7u0BECK/x8YWTUMDZLbReonEqTI6NDcIZiFaVt
 UraeZv4vJxSi/jJgQtv3oloUQ4JF2LHwWj0ayV5+8oXrW6qoF0sRNKFfQBCbzYNRA6Aj
 GIvFPnJ6h+v/d1XEvjF0FkAzqH8gGq+6caXIvrqEcCFwPbPLVp6URVMQ370XN9GEM0XD
 iK8w==
X-Gm-Message-State: AOJu0YxEPOjaKUUFMD+drMmRWXwOptcb4NxIJVvz+GAuDQ0u0DDNx1IR
 1rWybKeLjGlN6bQ2nqwr3mauFsdf5FkolrqTVoBK8R9BP9oYG7aHO4vI8D9UKDTjMNtWdcJ7Lik
 FIHYKaJs=
X-Gm-Gg: ASbGnctvbQlbX+Dn9ti1gCzOo0oEZ/BGRfv8qs3BsXJmA5TR62M66neJygw2dtRqgMO
 juVGi7xzj1GnhvXAE3b+iusQj+9P4xpheUFKSJfCBvKN/FJh7kpoj7JiiqmP/YdKR1ZKW1vE0sX
 bQ0ucI7i9gZ2KpaOU6DCyGGedF2S7e8Vieg4S6sWFND+vU/CHEPnYgv/a9yO8FjEokRF7ABdGS3
 FkGiqSIpkOQhIGTIVogWW39J4eY8OAYuImUACKX9kEBpoN+6XMTXlvwVL510EYgAxXeeI4Cusru
 SxdT3fMettHW+azFu6mPS1TRV+gOXzNL44zw2KZHIuBdN+M6xhjpYR6D5K4ci58AmsRw/oXcKad
 WkBAcmZdynoGUBgvUwLhnhwu/pzs0X+2yV9+BC8NvU5F7LsI2Qhxrv5oKPRqPWl0Pt/WBygplyF
 QWaDI8qtImYvrUzOIhpbkWx87ukPMuCIdceiUQMGbdf0IJ5k28Iw==
X-Google-Smtp-Source: AGHT+IGpUDC0MzncMOFcVy70E/SK06uhSRvQy9Viu1+uh0ygbCFTBXUBZ2fK7w+gVXmUMb3RNtX7oQ==
X-Received: by 2002:a05:6808:2110:b0:450:cb51:a55c with SMTP id
 5614622812f47-45115b63664mr4581105b6e.65.1763998160044; 
 Mon, 24 Nov 2025 07:29:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffbe9a88sm3789234b6e.0.2025.11.24.07.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:29:19 -0800 (PST)
Date: Mon, 24 Nov 2025 09:29:17 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.01-rc3 released
Message-ID: <20251124152917.GL2125796@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="axdbDVRd2b8SzQG3"
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


--axdbDVRd2b8SzQG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. Looking at
my own queue, there are a few fixes I'm waiting on being respun, or were
respun just in the past few days (so I'm giving people time to review).
There's also a few changes outside my own queue that I'm expecting to
get taken care of by the relevant custodian in the next 2 weeks, or I'll
likely end up picking a few things for known regressions directly to
master. At this point in the cycle, people should be aiming changes at
the next branch, and I'll update that shortly after this goes out.

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
November 25th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Second batch of LLVM fixes.
- SCMI fixes
- Dead code removal
- A few outstanding platform fixes (Renesas, STM32, Xilinx)
- MTD and UFS updates
- Spelling and testing fixes

I continue to plan to do an rc release every two weeks and the final
release will be 05 January 2026.

Thanks all!

--=20
Tom

--axdbDVRd2b8SzQG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSR5zQAKCRAr4qD1Cr/k
ChC0AP9VkBM6YeR85JJk6rlfSbru2cA1IxUgeOwY4t7xYecDVAEAyMAqoaGoCeGZ
tK1pd3+hOFaZ158xoC8+LQbArylvOAo=
=oMQk
-----END PGP SIGNATURE-----

--axdbDVRd2b8SzQG3--
