Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172B606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F/+e8rBb;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LufmUUM9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7B3D4074F;
	Mon,  9 Nov 2026 21:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5As2REYRCA_K; Mon,  9 Nov 2026 21:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F211D407C7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794261272;
	b=BvqSa+rpr0yFXSEAwU7dg1T+AkDIMNs0xbB357zMYlEEEGqxApYARhtfvFsi/yg5L3G8
	 lv9Tq0tYrlzk1orDog5Lg/Vh6OeVwzD7ViqGM/C7WUBy36Yif0GuImRBzM2W9DUgntL2f
	 zmb/Ex9WhKTLRwrLvBO9jdDL7W+2yM0jGTRWoGWmHjYsMbXYw7EZMHQvYZIXd/aFkeAa1
	 uOBPyytCNwAIqUvjN0iyIoOjjx/VvvQsHbbp0uZ2TFSAFrcxcIy4i/dPqBznMcA+sOehy
	 UC1zgtYA8ecq4KXjtqvNVaPxFw3ZwwR3/dOGM2YGVCCy9SDngYFrcaU2kKCb1yXXGww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794261272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=svI4cYYvvlpATSqyrCuOiawwATjT4QJzuKAEiap3tCk=;
	b=Zwcni6PVFrcfCzvRnPmDMdyh0LIS5DxsDbhgzEgJiqSzRt0Lsp+18r29ipZed+nBQhjp
	 7MUn+BMITgCT+41p5odPaMaf8CbiVhQXOcBCMWpJlqfEz/ZFG4IhImeU9iUvjM5haQStX
	 1lvpd0uft5V3WJi8N3qx9XdkRNsuOeqrzZMztId3vjkh7ll0i116lEtsOnY79m9Eacz+1
	 5/6eea1xPUNezl5rMi5ieP+aGOtKAX1aXj0tMzDqjYtaFKKWEtHcPiYYJ0jjT5Dc1nufo
	 eQHSHvc6xBhu09chJHCV9lQ15sj25vjKoVt21qtJBnnjAN4ulI5G+LvYWSggbESMvsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LufmUUM9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794261272;
	bh=svI4cYYvvlpATSqyrCuOiawwATjT4QJzuKAEiap3tCk=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F/+e8rBb3nSpUTyo/RyHqN2NYMrdpSONUY0n1kD/UQMa6quCa0LW/t4RJYFMt6G/4
	 P4zu3PCAf7enDWC/xAukAp7cmTI03Ng+HGpR0N4jEd46lsdKN7z/SP6iFCgxFWlnCE
	 E3QkLKSOmWmdLCBWEvl04whKiEpktlqQQ3sBcY4+yRIijTEjQvAi3COZMIqsMoicSd
	 8Ej3GEYHGkSd5v+u15+KY9oZPfdEvqTghQ7b1vB5X0ZnoQlf2ugfxHcRZUipo3O2qh
	 y4eiubvz2w7iPizcPeMqpXuYvqjQcomuTMDeFdvdvPuK0x0l37YVnmQu1vy8rW3rrk
	 /zflERkkGuC4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F211D407C7;
	Mon,  9 Nov 2026 21:54:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D84744B8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE59140721
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-SGK4e9Cv4U for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C703740624
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=LufmUUM9
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C703740624
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:54:27 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-8458555b6a8so464721a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794261266; x=1794866066;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=svI4cYYvvlpATSqyrCuOiawwATjT4QJzuKAEiap3tCk=;
 b=LufmUUM9k9A0ubFwyGtmNbnGO1e5ga1QEFbbrHRXRdWzpd2aBvKe18hTRenIdWWt3N
 oCWvOC2wHA0EG/0v7BrENFYn7T9AQ9Nvr+CRhS/cZk+P9+ElEcBT4R1aD6rmE2Enkfs7
 6V22Q0I6ZdU12o8cHJsHRXEWM07DgXjUYi5Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261266; x=1794866066;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=svI4cYYvvlpATSqyrCuOiawwATjT4QJzuKAEiap3tCk=;
 b=metkQEH565eZwsuftIRX1GA4YBV9CqDaau98f+UpWmm0ZPqk5U7w0lsRaJXAKV8Vut
 +rIB+iXTDn0TLv3k5GIIhYDIe+a4hvHbehQg3M6SrYqyHRp8w7gdWPfb+agaYNOrGW9W
 u8seRtBrxZekj1jDF1WaqlLmLGiB+0WJ+ZfBFI1BM+39DOIDXONKTYvyPpW0gnRJagTG
 AbXvwY6eUxDeyEpLJr32PufXYfqtVVWatK3rIfQnjrNym1ZfGKszT1on++M3gC4I0M5I
 TDm93V7GriSOw42WF+ejEvcrwUScDj/tH/JJIXUDceKzsByqp79WFNyEz3VmvSndLPkG
 1k+Q==
X-Gm-Message-State: APuU4Z+0iCsMNHhfVbTMcKXNCR15aB6K6L4GXbzlMDu3H7jAoS0SC45f
 7eZsjEPIlnOL22P22Ku8KL78W89Rrt0qnwbTGmlFppMtZO+gsuYf6GJb7Hh/zVJ73XmIvAzm9d1
 MDukpPxqHctBgr28=
X-Gm-Gg: AYBFou3LnOPZqQihxg8eKBnAujUS5xJ/ZVGmgYhCR2WjxL8tJGb5hbGN92unLLvat+7
 EjnGoOjxtdP3XBBF+VMjF2e8B90yaSo3M7LpspKhYsraM7VoadO8QxxLu0db5C/SqCOSc/N0UBF
 Cxh7Wk6GgFwDShZUeTiq6g3PTECEQw4n00BDq4T9j4iF/HTP2dsHT2jHttQvPWEoo7Foakj9cpR
 BpzO2nUOC51+xO8GFn9eL58wJ3rGWRJAHOBqOF2wB6PQR7YY5LMYyw7knB6iYo1F4sdyScLNx6h
 aTN1vVtWwDStjwu0dtGjU6toOqk0w5tDMdqGeBahOjCo3+8mti97UNex/T8RFvM9XldihZYUI0r
 Akn32o/cwUSSAQ87xqRmN+Wsif4besTzRayecbuNYS4HBQszuzbIS/a+TjG9dCIA+e2HrNFwz+7
 tYSm26fFlfTPNcKWLJHGx6YnJn4Erf8bHWrCD7x4I/ALo2bv982EDIwiGTLCGlpzfB8k8+LNcSe
 j4HX1nhuxqkHw/ETuUE//1if6uQTp9oa4Bj3/uhnzQ6j3M6/Qj0HPXj96KOK3XZstjCkqR8p6Hy
 EqA8rtrinjnsvPfNQHQL6dUHlLkbwIAh4kSU3PGnR/e6InTfWk/7ppP62GoReiywGlXOSqKlwmz
 WClrMR++1+L53Ef3IBb2PMPJdYBKvXbX9Yi7Xz3KF0wxI+V4flSlu21VWcAIqIwCikQCxSTvFua
 9ZuAavNM/yU1yOqhSmAdAT2gYBh8mGanB7YGJBAspZVn50+PY/XEI=
X-Received: by 2002:a05:6820:a518:10b0:718:968a:75fc with SMTP id
 006d021491bc7-718a5a58235mr180967eaf.24.1794261266358; 
 Mon, 09 Nov 2026 13:54:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae229c6501sm314977fac.0.2026.11.09.13.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:54:25 -0800 (PST)
Date: Mon, 9 Nov 2026 15:54:23 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2027.01-rc2 released
Message-ID: <20261109215423.GZ3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R6CR5d7XRaCr0g7o"
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--R6CR5d7XRaCr0g7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out, and as it's
-rc2 the next branch will be updated and open shortly after this.

In terms of important project news, last week we removed Simon Glass
=66rom the project:
https://lore.kernel.org/u-boot/CALeDE9Pu2rzu_zaWr=3DXAux88nV-LJ9_AYfLB8D6EE=
Cgm-BbeCg@mail.gmail.com/

We've now also asked for help on writing a Code of Conduct:
https://lore.kernel.org/u-boot/20261103172036.GS3309461@bill-the-cat/

As well as input on forming a Technical Steering Committee:
https://lore.kernel.org/u-boot/20261103172044.GT3309461@bill-the-cat/


With all that, we've gotten most of the pull requests I had hoped for by
now. I think sadly the USB DWC3 series is likely to get pushed out a bit
more, but that's something to talk about on the community call.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DNjh0Zm=
kzajgyNnZtM3FvMmM1azkzOTAxdXJfMjAyNjEwMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
The meeting details itself are:
October 26th, 2026. 9am (GMT -06:00)

Video call link: https://meet.google.com/hir-pkrc-ngg
Dial: (US) +1 636-707-2454 PIN: 996 784 524#
More phone numbers: https://tel.meet/hir-pkrc-ngg?pin=3D1444832752708

In terms of a rough changelog:
- Platform updates for PowerPC, Marvell, x86, i.MX, QorIQ, AMD/Xilinx,
  RISC-V, U8500, TI OMAP4, airoha, sunxi, TI K3, Rockchip, Renesas R-Car
  and Qualcomm.
- Fixes in our watchdog, networking, TPM, documentation, EFI loader and
  UBI subsystems / drivers.
- VGA BIOS emulation should now be usable for RISC-V.
- Assorted correctness fixes for LMB, Virtio, mkimage and pstore
  support.

I continue to plan to do an rc release every two weeks and the final
release will be 04 January 2027.

Thanks all!

--=20
Tom

--R6CR5d7XRaCr0g7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavJBDwAKCRAr4qD1Cr/k
CmXUAPwJ1Ot8heQe99ZPLVgL7fRVW9b4FQc+4fdCO6RZt4uGxAD/fAW9H3YB/QMw
APHMHpjJ2cWqPdCI2o2rQ1W9LFUK0wQ=
=oRYz
-----END PGP SIGNATURE-----

--R6CR5d7XRaCr0g7o--
