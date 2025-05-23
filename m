Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A93C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2BA8329B;
	Fri, 23 May 2025 16:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ok2Gg7Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065648329C; Fri, 23 May 2025 16:09:39 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8409C83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so9798799a34.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748009375; x=1748614175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F5zCCMK7wBDWSIgrCVSRFdU/Fwh+tS6H/IMWz59N/1k=;
 b=ok2Gg7Ex07qbX3q9hKpbcNEGu3+++CLju6egxqM5SQre2ru9bnrVveAK02jKRy6mP0
 lqTWltbH2bCf6uH3faf0MB6xJLXuEeWxHKjyb3TEYkG5BjpXLPbTber1dQsLOMDWhMSg
 PLs54dSZtL9X0Fjs3pUTRZhQBJOmKbgfqK2JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748009375; x=1748614175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5zCCMK7wBDWSIgrCVSRFdU/Fwh+tS6H/IMWz59N/1k=;
 b=SzhxKPo5oLWPBgdhA/0hSZQyLVwblkbEoYr5TgylvWqSswAM76l4O6jTg98vNIAnRT
 HYs6hVT4jNBuxedzpY5NuknR6LLHnnsauzFm/In7Dj2zD5ZThJ01s45wXofDFFlcTbKv
 yTIoO3EQu8c10XvfR4W+zYc7SL8eXfybohaAejCDlb3bcPTPOm4tda5m7PeY8HLGAw7/
 FZksv9DxyugpSFfVvFcEACJ4nN+cDnBn7oOtyylq6LyiCs2yLKi0JfehuhBiFdw7LUDr
 RY1JOHuzJtlHpnO/+HM93Hy1p54n0ZaCcqWoJva4yenU5Q3y1TXSwY4cqMSMfUAEECak
 w3kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAA4CQUYusNAf6ayVezoIuTFBG8GT5ZiKLGRKx3PkaVlb0V8CbgZ5QMkPI5ooANnGjZ6N8DZo=@lists.denx.de
X-Gm-Message-State: AOJu0YxgqZZjImCr4CJTEMRhRvDwywHUwThTOdPqkHbSEfdHZA9teDgY
 jeKAgYcnVyu2O/ZzUiDfBtA3YYTvemKjWlCoeIEqtx5Y3OA8JcJQ3Cq8KVnduSOkenWUDkXlEHR
 iRzuAotA=
X-Gm-Gg: ASbGncvmf7OmYuQAX+SX9uAwoDrENZmSQo5Bfnb7We3wyOEFPQegLCnZD9q4NJTwacb
 11vqz4DiXURhzg9vM3EkvfzupA3IxvAv5KEjGI8XmIZoMCAGLrXnweDBigfvurDlPmpOGyBXDFJ
 6Zl2j9X5s9xY6U3WnNvSBIo9mn9SZxZ6HLxhKZl+yli8+w1vNmob2/DQe3x+YriRYGeMSkymPSP
 e/o3zBBCiw8vb/6deCc9Dse/0O78NPhAvJ9iEMbH6ROvnS1zROivIP0PRmMNGIx2KR1pFXcAzUj
 z/m5kB7WvhgpQyyGwmPfNmbBXkutJTPvAqqlABoRl23CWYv8Ci7XXewsEAHzz5+cQGcsAmioD/N
 7BBBRV72XT1KB
X-Google-Smtp-Source: AGHT+IH1nbxK45aN2aQxG9JiPvEpuI3pF8wcKv7PhRD3Migjm0qtbt7iyD1yM8OkTqtSvXFxokyOXw==
X-Received: by 2002:a05:6830:3909:b0:72b:8889:8222 with SMTP id
 46e09a7af769-734f6ad688dmr24556886a34.8.1748009375223; 
 Fri, 23 May 2025 07:09:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a7f762sm2886362a34.19.2025.05.23.07.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:09:34 -0700 (PDT)
Date: Fri, 23 May 2025 08:09:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, afd@ti.com, hnagalla@ti.com,
 n-francis@ti.com, jm@ti.com, u-kumar1@ti.com, m-shah@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable
 split mode for MCU R5
Message-ID: <20250523140932.GS100073@bill-the-cat>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
 <20250522144505.GK100073@bill-the-cat>
 <20250522154832.2phhu7i4e2t5dnrn@mountable>
 <c99863f3-2b55-46e2-8079-64b1aa7f9437@ti.com>
 <20250523115400.s5ikojqjueowfxpn@cubicle>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KW9+uaiTqCxFIGgc"
Content-Disposition: inline
In-Reply-To: <20250523115400.s5ikojqjueowfxpn@cubicle>
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


--KW9+uaiTqCxFIGgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 06:54:00AM -0500, Nishanth Menon wrote:
> On 12:05-20250523, Beleswar Prasad Padhi wrote:
> > Hi Nishanth,
> >=20
> > On 5/22/2025 9:18 PM, Nishanth Menon wrote:
> > > On 08:45-20250522, Tom Rini wrote:
> > > > On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:
> > > >=20
> > > > > Previously, MCU R5F runs in lockstep mode. Enable split-mode on M=
CU R5F
> > > > > as the support to shut down core1 and use it for loading other fi=
rmware,
> > > > > while DM runs on core0, has been added.
> > > > >=20
> > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > ---
> > > > >   dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi             =
 | 2 +-
> > > > >   dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi             =
 | 2 +-
> > > > >   dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi            =
 | 2 +-
> > > > >   .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi       =
 | 2 +-
> > > > >   4 files changed, 4 insertions(+), 4 deletions(-)
> > > > Please don't post DONOTMERGE patches. If the series can be applied
> > > > without this patch, because the functionality is backwards compatib=
le
> > > > put these changes in the cover letter or link to a gist or similar =
to
> > > > show how to test the changes locally. If the series can't be merged
> > > > until the DTS changes are ready too, please mark the whole thing as=
 RFC.
> > > > For clarity, what is the case with this series?
> > > While I appreciate the energy to get upstream,
> >=20
> >=20
> > Thanks :)
> >=20
> > > <vent>
> > > I think this habit of jumping ahead of kernel should be
> > > stopped.
> > > https://lore.kernel.org/all/20250522073426.329344-1-b-padhi@ti.com/ w=
as
> > > posted, but not reviewed or accepted. I understand that there is a
> > > latency in picking things up in upstream kernel, but creating churn is
> > > not the right way of doing things. It took us an year+ to get
> > > OF_UPSTREAM settled down. At least wait for kernel maintainers to que=
ue
> > > things up before attempting to sync u-boot with non-mainlined patches.
> > > </vent>
> >=20
> >=20
> > Actually the functionality added in this series is independent of the DT
> > patch. I posted this DT patch here as DONOTMERGE just so that folks can=
 know
> > how to test the functionality.
> >=20
> > I understand your concern, and if it was the case that these changes we=
re
> > dependent on the DT, I would have waited until the DT patch is picked up
> > before posting this series here.
>=20
> use gist next time if your intent is to show how to test it.. Let us
> continue the discussion on the kernel list for the dts portion

So it sounds like the bindings being used here aren't settled then? I'm
going to mark the whole series as RFC for now then, if so.

--=20
Tom

--KW9+uaiTqCxFIGgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwgZwACgkQFHw5/5Y0
tywXvwv+OxmWvKG4E+N+a8WnoxvzLor2rueAUuZBO5QIg3W8BX+Qx2qmRHkmuESC
uVMGrj7ueyMmCnW3v8+M2J5isNkD4Mc8MgxAjLu2Umd4mLgRT5PBS0ncT8FZqy1I
Rss+U7B1WgoNWtx0j8gziHSd7c6L0c8yULTLceGkLtn3j8uhimRj3PwKjkDNPXQv
bVLOToH8DtstLrJrnXCDa33dhSCF6SvmDgWQhnTiXM6YCP+YKS9hsMaKCxd3Lv7N
1pFX/QGEqb75iRovTKPHPBwD7Ye4SCQ3ihiodsEoqHj7hnpJQvLvK6r2F5sf4dkO
o1TV0YGIjhOTgWMxlYDePuJLmlbtQSLqf29oRI7dHm+AGuIOQFyGur4odgC9HuQ/
UQ2ODnTOzsgsNINVvg3R2PPkWHp3Po0p0BS3Q4EPKSz6bzmc4nLf8ubUdmg4/HZC
tiKEPjpcU0Wedi+grMMmc58id92TYknZDjXZ75rBcuhyNRwI8q9SQN4Y++NwpUEy
t1pWawBJ
=cTsy
-----END PGP SIGNATURE-----

--KW9+uaiTqCxFIGgc--
