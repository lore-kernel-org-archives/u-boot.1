Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9589C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AABDF40533;
	Wed, 26 Aug 2026 15:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OuvtTCYDLvn0; Wed, 26 Aug 2026 15:05:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787756745;
	bh=o01tzAWqK6vLQd6pjXlEzlylIFm8Eh6KxX+YMh9Xk1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hv2V+t5PIHLvThQxC8vd1vRpXI+nLw642aBHH/EeELwJ+suYVE4q7cI1wR4bUYpey
	 O95HPaUFx01V2AzbuGsi8s7k3zxdMnEQpV5yHHEw27LExJ6j3d6Emf66IzhpnVcSL+
	 llxGIfp5r9/H55mn0wOeBm0/QMmHL+oq2rW0rSrv39UoISlaRviXFwE4Sfd9sW6V5J
	 Yr69O0Y3PI/XONyhBAOhYarZi1tGmRNREnYqahWRLmKJPQLJ3museos+qwF6BXWdKO
	 umrKZ+ze8e2zH74vHfImqnXjkt+0mYd+nUfOyaULuF4o6ukkjhOD38wsOajirM+azP
	 XHJ6oqXhWIwjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 299FB403F1;
	Wed, 26 Aug 2026 15:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A313E118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A2B040115
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hktK2RqcAvB7 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:05:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IPVKPHMG
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A798E40064
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:05:41 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-49ec9d117f2so123916b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787756740; x=1788361540;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o01tzAWqK6vLQd6pjXlEzlylIFm8Eh6KxX+YMh9Xk1o=;
 b=IPVKPHMGmbLbUXUDdk7p6m0XVvITvfhZDWeVr48g0yzbrjGmgI57Xvn6xQz4sVD/0s
 ELd7dn9cMOMKmzGVl1MoH6i7U5FT2RMVu0R90JSp4JCJmRXIsqyWNZFhKQoXmm/FEoVi
 c4X/edqRFUksnResVh2ln1wBITKXP4mKGEI5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787756740; x=1788361540;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o01tzAWqK6vLQd6pjXlEzlylIFm8Eh6KxX+YMh9Xk1o=;
 b=pTwM46Dn+TginO1+Qz3yccUUIG9QTyGE3dDUozfcIVK2IYo8XfY1WDth6ls56zn3Wr
 4fwUyOX8/6h7W5bmg3WtFRTdbzrgFuDIhFh9/VXbg2rL/apD9yQc80kS1lIw0OdczY7u
 SPTIkm1bn7NcAAfltuT0D8HdbbDKidx7u7aE2PDWxAiJnbT2ZgIxyK/1QvRJlK7NRAA/
 OvqGPJ8MYxIoS/BosQKAUowDk+PcGiFd3QTvg4EUZOPmCo/RkzDeyLW8B2TWkc+JtkaX
 IhB+SHR2+wAjQCUuTuc0exaL5WnkyWHqHlRa6lg0JTvYJ2jrfr0b0uDGS6l//VbQiiYZ
 /68w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9h5UmsZTQe53VFL5BSgWL3w7NVeGWYjfLiPGzRtSGXxJKg1p4E1hZ/rELyWeBTdSMGvgUub0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lyKFlm6HVW0K3RbWFntxEZRuwWpCmBn3RhJHP0xsLcXzekUiSU
 Be/e1JmujMfrIGqN0LNsAySTK4FkjfGp+5A61LjzxWl56mCKfzd9iYqFVeFtoIkzhyQ=
X-Gm-Gg: AR+sD10WbwMxxgT1JsxdZ+b3OBvHQN3TDA0T2o51aI59S0yVQorBHGH9vuM9+bkBe+l
 CwvoIa6AHjLG4t3aghI3W+++8UxJ7JpCEM9QomYJ7Fo8mmkLhGAOyZkvQDEWeLZVM2VY/mdbmnq
 7om5ab5MxTC8xghto1ziPFzrzDEb0U3Vj6A9eg6VQDDi0OWyP1L4IsOJqO+yhjMiVIU+GDLVlot
 VlQ9jJm/lh6MDdste1yixdFfH/lFosy3W1eUjyqp1+4CPa7nqWJVK865f1eML8+GfpzGg18bFmu
 1jFSMVNLtrkvlxdJ+A7OFjta4cE8Sxdng/o2UCeaHLvIu3ZOKIz5l1J7KkTtWQaawRX0Bee5xXG
 kWcd8GGeZjP7F1MKISi7T6GdbZK5hqRyaoGnH41vndSn4SriDp8535QeaIe4P7pC3+/RrXW6zG+
 A7mArDiHcopUomwTN1I87PJXzFfbVXuc3eAwdB5UCQ0Aj+Mb6XUQrpTp0IJUjR65Xf0lTSHf+n8
 jdvOT9JN5KYu3s15jGzo3oLUVpH54So7WlOBtc21kPdsG4C8TdjuXrOsgX8/gCLzBsEBWZy+Ljm
 LpW7Ue30oQ==
X-Received: by 2002:a05:6808:6542:10b0:4b3:75cb:b856 with SMTP id
 5614622812f47-4b375cbba3cmr1630703b6e.9.1787756739782; 
 Wed, 26 Aug 2026 08:05:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b37ad01459sm166174b6e.4.2026.08.26.08.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:05:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:05:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Matheus Sampaio Queiroga <srherobrine20@gmail.com>, maskachoska@yahoo.com
Cc: ansuelsmth@gmail.com, daniel.schwierzeck@gmail.com,
 dario.binacchi@amarulasolutions.com, frieder.schrempf@kontron.de,
 jerome.forissier@arm.com, marex@denx.de,
 michael@amarulasolutions.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528)
 SoC support
Message-ID: <20260826150536.GM523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <kSKs4kbLRy20mVMgtwFdmg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zn2/cl7bnGhT/USX"
Content-Disposition: inline
In-Reply-To: <kSKs4kbLRy20mVMgtwFdmg@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Zn2/cl7bnGhT/USX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:26:18AM -0300, Matheus Sampaio Queiroga wrote:

> Dude, if you're going to get other people's patchers and not even mention=
 that someone else used the base, don't even send the patchers, I just made=
 a draft for the SoC en751221 and en7528, on the openwrt forum itself I sai=
d that the boot was unstable, especially the ethernet of the en7528 and the=
 spi0

Posting someone elses work violates the rules in
https://docs.u-boot.org/en/latest/develop/sending_patches.html#attributing-=
code-copyrights-signing
and specifically https://developercertificate.org/

--=20
Tom

--Zn2/cl7bnGhT/USX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao8AvAAKCRAr4qD1Cr/k
CpURAP4hvUUA2PoEsTr32lwXmbOfqpdQM21aafz1hItJh/LrEwEA5dlfk0yRZ0C7
WtpArrwxaIkHpE9F4tTJNLxMzbzNuA4=
=97QW
-----END PGP SIGNATURE-----

--Zn2/cl7bnGhT/USX--
