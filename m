Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81061C3ABC3
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 00:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6182C828F8;
	Wed, 14 May 2025 02:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dqz7BgBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A525D82952; Wed, 14 May 2025 02:22:01 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E3980107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 02:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c1425fbfcso4810704a34.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747182115; x=1747786915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AcQiBaqVCOosluIrYWMX5MmTW/jOm8hdsOdljZO7mdU=;
 b=dqz7BgBx/zBGxEtcXBgPO2bxOuTR6dY6wDFLEYYseCALZ/7mw34RqET7Wn/x3qAuc5
 k2QhW3xu2wLf5iwMppEkB96rQNaDxqO5A3CVlT6G+TkCaY3ZBg+grCLTCpZCx0Voglsq
 OUYFzI/iVB9y0HWhRAnzJSwdXT8YsaWSqEOYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747182115; x=1747786915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcQiBaqVCOosluIrYWMX5MmTW/jOm8hdsOdljZO7mdU=;
 b=KsCiY5Y1/tS/5i9s073HOhsT6TWip9ruHBBcJSBo6VBLu+Y810SSsQu656ul/On7G5
 k6vB0XtgbMgai1GVVaiJWme4SNKw1BoRjMscHodmRkxHv9yTqpi0FVfpAV1dGjaFfA5A
 87/yuT5//OGJ/vwDGlUhkI0IILYzDR/dlMbbKBAYGnYto+sDJne3hn8J/MJFTwa+Ltla
 hzrr5oexZiY8wB+3Wz5GB2w4tg/g7Wg/4ItJkia06Wola78TsOhlsiFOCftXF7+lKDEK
 eOsBN2hN0MMZJh0Maieosove1HZA47SHC8YoHIdTvyGvvy7/oemuwhW3rk5JUMgZfwaP
 okAg==
X-Gm-Message-State: AOJu0YyghwFSeeEVIb+C4Gs8rlT3qLfIzBq0u+UZco/5LPlxHLaODmcB
 1SyobJNS5Fxpp6R4Lq+epTcHBH0nTPZDf694pav4S3TN8Lo5VFCLmMP54b+d7vJc47in8w2AEjb
 1
X-Gm-Gg: ASbGncvKTFaAvNLINY++JgwySAvJCKH5QbbDBkyMnlq7sEPUqLneiRQrJ6r03WRJCNI
 tD787A9fI329qrhATOWGfo65QeiGALqd8Hv2Gr/Cv1nKx028CGddIS+QyG9FjaLN07cxEp3khPG
 k0FYKi032kDHMy7BiXDtrfErLDrjBZcEqrojjEFMWtwRVWB9FEojK8+PL2EUH9d/EcG+hWhGqGa
 VwbLFhM4aFupfCVe6QjS0K5pGF7X1CVE0durirvaeAE93rcxiI1uX4ECbU1Fayo64giILjiwqY2
 9DzWlarzum2VHbEnPcM6yyCEKsfGOi1NjMnWd0mrgGQ2/zBBE7ejaIFDE8+x+XWWHlOhFdm8kBw
 Qp6sdCVBcNBk8
X-Google-Smtp-Source: AGHT+IFlpWF1g3pGHCwvu1ah+L2CHP5otISuPNXxGF7D3PfzJnllahYdIVAzKudL8cnSWFD7Za/EaQ==
X-Received: by 2002:a05:6830:4702:b0:72b:9f83:1155 with SMTP id
 46e09a7af769-734e14f8fc6mr704990a34.17.1747182115319; 
 Tue, 13 May 2025 17:21:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52229sm2147505eaf.17.2025.05.13.17.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 17:21:54 -0700 (PDT)
Date: Tue, 13 May 2025 18:21:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc2 released
Message-ID: <20250514002151.GV603748@bill-the-cat>
References: <20250512203501.GR603748@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7952LSlLsWgFcLRG"
Content-Disposition: inline
In-Reply-To: <20250512203501.GR603748@bill-the-cat>
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


--7952LSlLsWgFcLRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 02:35:01PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. As it's
> -rc2 I've now also updated the next branch and so we should focus on
> fixes for master rather than new features. I tried looking over the
> patchwork queue as a whole last week and so I picked out a few
> outstanding patches that I had assigned to others but that had been
> reviewed and looked reasonable.
>=20
> We're continuing with a community meeting following the release and is
> the same time as the previous meeting. The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> May 13th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

Small and quick meeting today.

- I gave a quick status on -rc2.
- As there was a question on IRC just before, I noted that for updating
  the dts subtree that v6.15 should be out soon and once it's out and
  tagged the next branch will update.
- A new person to the call, Haider Ali joined and noted they've been a
  user for a while, and implemented various things at work and would
  like to be more involved upstream, and wondered where to start. I
  suggested that looking at the documentation around what they've been
  using and then improving it might be a good start as as that also
  highlight areas of the code which need improving too.
- Jesse T asked about regression testing. I noted that there's some
  platforms that I can test in my lab, and that external labs also
  monitor the branches and report back issues. Jesse is going to look in
  to setting up a her own lab and noted that
  https://github.com/Mr-Bossman/SD_Swap is an sd-mux board she designed.

--=20
Tom

--7952LSlLsWgFcLRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgj4hsACgkQFHw5/5Y0
tyyRMwwApCTaXZFGWmhstIG+m/tJc3Ib69a8Ko1GvZd/hHrMKAtvyr2hJWsG9M3L
QP/BBKX78ROvdDHAPkvafnTU9t/8j52hrDKW3DzR03DQonCjpoOed/OcgkJCEP6J
CBF1eAQJs0j429AjgYogK9qIhMbW91VvNBXai7WSdrCVMyVF+OjiNB/We8Y6rQNL
GGEfA+Ljl+JavakSXqC6QwXg3NBS9LboyWOq8q24TV/YSdAN/bl2IpJWLOVEeplg
cKKw/OaEvNyo5z9Vrm6m7jh1ZZ8hYGWBP7CzhNHmcJsfZC7yXIPV+Vgtoc+3kWpB
31sXNF/VDu2Tsv8tX8WD91YSuJNBsciTE7rXj09JSGuw5w59bh3B1Kz5k+ThbGJa
ehZ6Xzpsn/fzMlZviDs0LmsUn3sZ2+9Gwj/ehJykDQpFiFHCQl6CCdEDjbXr9iP8
RwruxDQz6Jne3uPh5S7EXl7EdYBpQ6jdUhcZXoHVzhzefY83g0sI4lGbry214goT
zX2fXffr
=UCzc
-----END PGP SIGNATURE-----

--7952LSlLsWgFcLRG--
