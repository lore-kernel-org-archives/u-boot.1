Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44B7CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1375D848DC;
	Mon, 25 May 2026 19:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JDnucyzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E6F848DC; Mon, 25 May 2026 19:06:33 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09A1847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4854166e1efso4113049b6e.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728789; x=1780333589; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=92wQu+tvm+B1nzAnhTnWx2rlZjXSTOGTMVkk5xy1Z8k=;
 b=JDnucyziZ8pVr5FxTo5+lKhtpgrMgBSMglGzHL6wLooLku+ZdeAF+IeMIGdEGyJ/bs
 7Da6zxgp6ghSc4k2qC5tGV5g89Dp9ukizVMHdJYPNlIX8Hs08AJ3JPMhxyVG5anCO8bO
 hIISqxtEvymACvHKxlq+64ZcKq7IRIwL9bDv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728789; x=1780333589;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92wQu+tvm+B1nzAnhTnWx2rlZjXSTOGTMVkk5xy1Z8k=;
 b=Ru8WoZFZRtd/Mdp+s62oNsptZrP22cY3iQLXm8CL6D06Zi3immor866hjKqgpOMu6a
 V9qIYtsPc136t//8eJa/3+RBjT92kCcLXiORWJL0MbBGtbAL1pNVX7MZF0FI0PbpGy4v
 i+W8SoKLMa3zlHo23QhipRuvoyiykyMA/Y6vWlAzXrus80GbQU9cZPGY0cbElDK3G00d
 Z8MWsWZJ7MMvp0tBq7wd0ZQ2repnvWKewcuhC07Qf6+42cp3+7n3sS0i+fiaQnACKZhr
 UBOjHio+4TSiBInlJs9BXJnpVFjupfBkTvKUYVsztBb8mq3PXf/3cJs9itTDKOujS47K
 GwTQ==
X-Gm-Message-State: AOJu0YxiVe3PW77lHcvLBAlEWRH5GT8MAndMqlFHHYYhN97bKIUhab4J
 aP4L73qjWSQ+gpopSo3s7Mah3mAjaLM7RhuJJT1bg+DjxBRqEuzxMhEfUFn2XVFd/V+acCPUUb+
 8EryQKrw=
X-Gm-Gg: Acq92OF7MLsqsq2JCzOefYEDNnDrG93iuWfemRyjd3Erc14dh4AWDAWEnejKywb9bE+
 B99uB8VEOHhcIcNgcbrPfXS/2lOVrU/UZZ90qhA36kOvF5tFEs761csj65IoK1eEWlM2tqW11Hh
 UWKBWCauJIQMreuvGbZ8AZSlBGiC6H0YMil9l6JLPP5Ymfwz2zLLDQzj3TECxAKll37Anv4x2wG
 2teEGCGt9HtgwWqIv254k0syDWlhedtigaISB8VGceUDv0r7gH5n5ZJcGRRas0oxyV5ORGgjNWf
 f58z2kp2OfdBEGK/DnDKIunNhmqpxvp99j9eAWu2oANjaUufJZBg2oJZDZ6tGsOBl8gI61PRWYo
 hgMarPfMurosXP3SrmO6tYX9HxzL93HwiGM4ipG+MYe+PuFV2nGFhRsUWkHQRS3cGp8aS80Wj4e
 /jRxjID3aszQKj2EZajo3xaFmt4ueV4fQsJ6mlKJHF4NLsl9cydq4eqL+iC0rdiuY+IxmixeK8B
 mkZN5udjsCzC2BBhD7fns33BwpDQ92kd9t1ERdZrWfNeq042ZVLQ+B2
X-Received: by 2002:a05:6820:a011:b0:694:a17f:759d with SMTP id
 006d021491bc7-69d7ec42ce7mr6083066eaf.28.1779728789655; 
 Mon, 25 May 2026 10:06:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83733c1asm5189190eaf.7.2026.05.25.10.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:06:29 -0700 (PDT)
Date: Mon, 25 May 2026 11:06:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07-rc3 released
Message-ID: <20260525170627.GO1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qjtm5bGaiityrst4"
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


--qjtm5bGaiityrst4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

Continuing with what I said in the -rc2 announcement, I've updated all
in-tree references to use u-boot-project.org. We're working with OSU OSL
on infrastructure migration and once the next part is ready to move,
we'll talk about a schedule for that.

The delta between -rc2 and -rc3 looks good to me, and I expect just
fixes for things moving forward. If there are fixes people know to be
outstanding and haven't been applied yet, please reach out and let me
know.

To repeat what I said in rc2 (and will keep repeating) is that it might
really be time to retire support for running our tools on Windows under
MSYS, rather than something like WSL. The move to support more modern
OpenSSL versions has hit a lack of support problem in MSYS[2].

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
May 26th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog:
- Platform fixes for Renesas R-Car, STM32, Apple SoC, PowerPC QorIQ,
  Airoha, TI K3 and AMD/Xilinx
- Fixes in our I2C, FWU, EFI Loader, Documentation, UBI, DFU and NVMe
  subsystems.

I continue to plan to do an rc release every two weeks and the final
release will be 06 July 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/20260511174116.GJ1858239@bill-the-cat/
[2]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/

--=20
Tom

--qjtm5bGaiityrst4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahSBkgAKCRAr4qD1Cr/k
Co0SAQDpDlLvEgd2YzyWhfiDl+FG878hUCE6vRof7oZrHFr5lQEA9G+ayC4fSZSU
ZaNYS/bjQqSH3gbhA3LMYBwvGg3ZQAI=
=Z3qQ
-----END PGP SIGNATURE-----

--qjtm5bGaiityrst4--
