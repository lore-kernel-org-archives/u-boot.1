Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CA606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fh6CckUr;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UKJ+Irb+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647B260829;
	Tue, 24 Nov 2026 20:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6h3y33y_fdQ1; Tue, 24 Nov 2026 20:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BAA66069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795551473;
	b=XahzfMdbvN31cRXCAOAP8D3d2ycQcXKH1lD3oQC5BySQLaXhvSMAxgUpisZkkMr5l2dW
	 Ga7yPTYp88gp6f1nqDI1vPnI31k2wP0e9ggONRIXhBseogMewdkQNveMu0FTt/4u8qmTx
	 t+DM7W8qU4cUzYnMgrBdYYU6LJKDSGhDvN2sKpK+ksJ+d1SwUalOC93sHSPoMLX+GQM21
	 Om2mhOqU3j1dgSNY7+p2RJ/0uX6tp5+dcQpRYqyetoetxKhdw2/Mg1a/56JeobQqWdaeL
	 ayL4dAskymACAiIPYNazKkcpWndggCdk82o8jnHk3M5LFfD3+ybtxGhtv1wJq4OGckg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795551473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3NTUR42x3/pOxbIE2cziDx3iTCBO6hSLOFhE7qsKVD8=;
	b=Y54U9NgCNWt9GUJSmmdFEny50RI6DrszrmRcH5MH014wqeLF5rUV962ia/oFcHSIjcsB
	 BfQXai5vtLQe+7hztwyxGUSp3jyu7SLgy0ecghOAwRHbM7Xm+aOtUlm7agZeloUeolcbD
	 VkiRmLHCGuDpxszBgmMUWbSXtWuy/izTxgMVVf8vcl4G4CL2xIZgo/5Yb2oQnX2i6B2Kp
	 bgOvC9jvGXIFGYA1S1dShwyjTk2TgwWZTSdpSRAmmrsQN+/kFRDEqEG+MoCFYzBlSLviQ
	 xs8ytacVIFK3YdOaiIFUW8hJb4UzRy8T0n5tNx5srexOd6LAK0+RXDgA2s0YL0rPb1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795551473;
	bh=3NTUR42x3/pOxbIE2cziDx3iTCBO6hSLOFhE7qsKVD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fh6CckUrwJZ1b+2vAtnrjx728tbCHIvIx+xHvzYZf2rxXsmLU8L8keTNQrnp/qBgb
	 EbvPdhBwAPoGILlSS7EcRbL4pv8OhTxwt6EtbTkfTAObSQINjo1xNpuM4QfQBMnoKs
	 DaEGWtu1Nl31jvho+/7RE/z29slJGaifu0HuDho/tYNKmiamQge0EklRDjEF87URTZ
	 H2P5SPLjHpDV4IK+LnyDuCHCdcvdcZK7Vgi3rOs5zomvkpBHpQpTEfEsxRJoBwXoRI
	 tOykgENw9qo9OgEyxzCLzbl8bTt7+BJPMoq20s0c4el4Ec7B54kXIkaJUhDJCyqAKn
	 w0/5ec5n+Gd5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BAA66069B;
	Tue, 24 Nov 2026 20:17:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5384C325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A640400AD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cll8DetooS3c for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3611A40071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UKJ+Irb+
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3611A40071
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:17:50 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-8629c7cc36eso2852470a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795551470; x=1796156270;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3NTUR42x3/pOxbIE2cziDx3iTCBO6hSLOFhE7qsKVD8=;
 b=UKJ+Irb+8bXk6WQJU3V6IeXmKm8w5BA/QAtUHhHPt88Q36FQ6liD0yJEjb5yOe1S16
 C4uVDpWdbd04sgeB6gLhXZhTJhoYsqlBDxDDYiUwjZ30C8/r+0AiFFjMoSPd4mT1uzdn
 qZ+AvUnrbHXW+s9nY+KVU+w/FoWHbcqnUTeY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795551470; x=1796156270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3NTUR42x3/pOxbIE2cziDx3iTCBO6hSLOFhE7qsKVD8=;
 b=u7JqVUV2vpnktHwZz6BzqdySasqhaaBk18CHKiQ/tLu0zYrRD+GxycmWO6qI1CQEKV
 u8H3/NOupNxNHVVEXs3sxeAAPba51gsvqGFSqDirX13aPfFtVga6GyNhZAN0XzG1AGdg
 WqA75D33cfpt1r/V/mbOQ8P1pJZC3zqc2m0bDtHp7ah5oqMpNiI3OLJHfOe8rAUp4NmO
 akkZ/lAftmYyL53JY6S8LkHk5qHgXk1xq+AXRRNtWcZ2NRONpZe77z9ew6uN0zFxJsoX
 EjVIGZy2csLeEkYlXuh4trmih2tQluyLiDZ7V2IUOaobu7BWSnLTmc6E+YTSgvPHvHWS
 aYig==
X-Gm-Message-State: APuU4Z8iDomVRJaW0rjzajPV2Ro6h6qvMzj866R0dGgKO5K0zVfwtLZw
 6ZdjX8XPKFTxJR4xLj0jVQFh2qvGbFXGspo3n2LlHbIw35qc9uoFqwQ09Vgd0xbc+HsSBIo0Bod
 Hy5KkwJ3XZFNE
X-Gm-Gg: AZFdTZfUkrwmD+jHV38640qM8Xewfbh1qKjq9/RJawk/N6KIBdW2+3w7kHT5DUIYi52
 H/dJDJYDYDK654jw/RF+Mx2TEXcp7dfj5kJBLgw6OLL/gTGeEFR9zbu8h3m6ebybyENm8WVaEfx
 bUWv38N8RrgkUJ0ZZ5nTEEKHW5RZJpC/mF34MALT/mDdpaony/wPUSQ74Jn4BS7vl1v64c8gDYP
 j7fmkhI+WCwbYwJOhRA2nXutKSBdlUG883Ra9foUdSmimeccc/DR39YcSNEpHPZ7kI6z2Y2ie6h
 RVvSzr1Qc+zbTXwVDDBOM9usemxsjofMSZRCDfEWvqQcuysEroAzs5zMyjjjdgbEL9sskGZe3nA
 CNP0Xev8LdtSrfJrhgkQLe0SKBZxhFnuT44UJRbJO+lFd/UrtAy3kfN6+cgGy6M/YI8mzziGQ0G
 3dizIjbFG2wuc0jn4czTTUEjRJUI9S4qQ8e0+RhpDlig9vx9KKuaUfxjm3IPCQd9mT6f2FuQ7dQ
 S+6Gc0tt/169eRR8MEhhdvusITnRdZ6PNkSpzSTbSpwUTm+dEcVdeNglpcZ6HVy9m3aJuC4vyeu
 cDg5DeQVJt0gGT7kUHV13A5rA7iAvqxYFt++5iTm7EVE2s1BhghZnpReDXfE4epW/uaOlg9hfRf
 jkOtcrgZcAxPbZSpvQkb+wxMh7F6MdPkyZ2II/B/3yMOfty/sXom399Md54WpEvpPPtejCPiH58
 DVr7KooLJH48oKn6UcDtMZB4PFiATDn2k=
X-Received: by 2002:a05:6820:5608:b0:716:cfac:bc29 with SMTP id
 006d021491bc7-71b396032e3mr8745327eaf.85.1795551469901; 
 Tue, 24 Nov 2026 12:17:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86322db2d1asm10103022a34.4.2026.11.24.12.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 12:17:49 -0800 (PST)
Date: Tue, 24 Nov 2026 14:17:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] samsung: smdk5250: Add Alper as a maintainer for spring
 and snow
Message-ID: <20261124201747.GC3176972@bill-the-cat>
References: <20261124192912.242000-1-alpernebiyasak@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7JtUSAOs4NMR4MBV"
Content-Disposition: inline
In-Reply-To: <20261124192912.242000-1-alpernebiyasak@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7JtUSAOs4NMR4MBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:29:10PM +0300, Alper Nebi Yasak wrote:

> The Exynos5250 "Spring" Chromebook is due to be removed if nobody picks
> up maintainership. I believe I have this board (an HP Chromebook 11 G1),
> but it's in uncertain condition and want to try my hand at getting it to
> work. I also have the "Snow" Chromebook (a Samsung Chromebook XE303C12)
> in working condition.
>=20
> Add myself as a maintainer for both "Snow" and "Spring" boards. Drop
> Simon from maintainers per project decision.
>=20
> Link: https://lore.kernel.org/u-boot/20261118155218.GX554944@bill-the-cat=
/T/#u
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Thanks for picking this up!

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7JtUSAOs4NMR4MBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXw6wAKCRAr4qD1Cr/k
Cj1/AP4v3v+hgzwvO145o3zuZPS3GyoagJnVR3Y0WvgNOSzZegEAtNpQhu+CmaYY
uDuAu8MUMu0dD2PTXOSNtzApiPwP/gA=
=PIis
-----END PGP SIGNATURE-----

--7JtUSAOs4NMR4MBV--
