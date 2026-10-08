Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6DCA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 23:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51B3C60873;
	Thu,  8 Oct 2026 23:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kb2nTeudXT4G; Thu,  8 Oct 2026 23:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 616056084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791502845;
	b=m3kNCiA0D6Uzxt65i8EzjRyh+EJ+kGxs9/SMiNxNHmYo2WLuObliXW6n0fU57NAEE3Iz
	 ERWyqyVxV9XgUxzIaoVIZAUGYIGNGynd80EIZ6Jn6T9bscjYVK9ziJ5jSLYag3y1k3wbu
	 x+Vcu2r5D3QHxp9ZM0fNNMKxMPw6VfWL1E03f7hSrfrehBUaRP0MFp1gDM9TaHaX8n8BT
	 CqqjAC6pfGvv0KxfSS8vx6VxAgbXxh1MLcCGKpTx5bYixZeocyxbamhN5QGyvx+8grKIy
	 /5Rjz3ijqUdqFvtEx7XAR2W+yM0/6Y+Dyz+Ic8wsSq9wSA41ndnxNw9lSNg+ev2hvZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791502845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NufXUE5fZx6ezKo0Nq9y9nq/Rk03+a0195URQ2S7FOU=;
	b=ESoNgehJC7tHBDWGnqorVWL1hKII7zpNjAaccrR+Uh2fcL47iy1ckFRrVOJCPiEzZC+r
	 +CLToknToaOkkeTb+LEK0skxUUUI+nmp++FdR5a5SuVbj7U1TnfBlqGxx2bJ0KoZtYfqU
	 PwK55/4PNEw5RpYU4ZYavj7CFyXoAJAovO30Z9ypD8yjzWGwVado3/8hxq8OH/CE6Ky+A
	 quGJosqVOItW0ds+FsGq+omC1sXu5tQwusxV0gUWJjplH1n4mB7RfQGCGyjauAj9EWw8A
	 k9fXBw5D7PNd+uRJsbAQNvfsXFWMY59C1vk+1uU0eAOXr0vkBBLw6rg9kW3Fn0dJAEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791502845;
	bh=NufXUE5fZx6ezKo0Nq9y9nq/Rk03+a0195URQ2S7FOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rdp6ygYw7mkk4n0HzA/ZETrkIKs9jt/yeYCEqXYKa/I8BM1l2eAJep+2MRS+q5+2n
	 eMnLDg8Jy48OV7NIffTuA99h73kimbR3jnMQS6gS2kDK1LiRxqGQJdqSZ7sEzOOXcK
	 +gsQw9NI7gK4pR/1VnHaeJ8vPK0xxhd08+6jcoYvvf5+Ztp7eOGTbkcz7hTLunjnSu
	 fL3RIP0OqTdfN196eSolYeuQWwUl7jQXKhFey86fMoKjPWa7mPuT1QsU1XFsjsgIYS
	 8RjgvPOIerc10jRC8jpP0kXPErwwXP21pruxp3ITSLf3gA7ZMdUyJiYbDN6FwtQvM+
	 HoT4fdU5Q7QUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 616056084A;
	Thu,  8 Oct 2026 23:40:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 939B31A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 855E240098
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71DzZP4HkjNN for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 23:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 82D754006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791502842;
 b=THPZOAsF7xotoAQvQMt6axd+syKIbRQ1T2sk2zTX5FBOtl3jS692r5Dw0HY9qC8Jk+rT
 /PZlQ+d/Xi3b6wamV7nuHFBmvt3djytrmgrzM+Zqm03Cu3DJ3Xbt85vZadM/9biY8Kg/l
 KsHcB++JentZT/jwUk3d3OATWurWYhs91ryRCAaxnhNMb+2+dPlb37lzM1GnSAwAORZ0D
 uH3WYVwp0ZWeHUv6Zo/R61JwL3n7igm3qps1k7igQ6Qbj94RhQHiJfdTHHDHo5s3MF3oS
 0fshtVxgA1mdMj3prQV8WWonr1xmK7c7Uw521MHN6RZA9JiHUS4857Vlap/wApdgjxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791502842;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NufXUE5fZx6ezKo0Nq9y9nq/Rk03+a0195URQ2S7FOU=;
 b=ACr9RZ7UDkw2taJ0tUtjgcwu0JwAR5JhlvTrPNrvHrlNrwfNaLBDuxctBUrKZuD8N+PF
 Cxc7y3WfMu+MtJ5PG/YUzCyKWTMbBObQTemuWrIcPSh+uzdh483gQ72wcD/jFepVHzzCD
 xdUjTEe+DhrgbK1h17cNIjhjGw/5HDR1hJRSZx5f/niF86dtAgZq/Hto77W1F56FNEo6D
 ScoiDT5A3G76DhfwTM8NN1HrkB0tPr9g3XBsiAGZ3UqAr9u9j+tXUudtqJr3aYxQmZXhH
 igLWHYhpLaSkad5XMgGYme1Spk9h/Ey218eiqSXl+J2DK8SFc6Kg2sgil1gaXSAi1cg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ilPjgNaH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ilPjgNaH
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82D754006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:40:41 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-821a4a69647so2570493a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791502841; x=1792107641;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NufXUE5fZx6ezKo0Nq9y9nq/Rk03+a0195URQ2S7FOU=;
 b=ilPjgNaH7oDfa2Xc6c1YtkknjLtt0ggyL0JVQWl7UV+cHgG6mjBdJRP55YeJmTGA26
 +U0BbHkxY7/jPGUbr6ry9RKkJ+51UcNW998hJNkfBwK13PNuNshZIQULYAbe3S8Ga/6g
 ZoYYxPtwNT4ZXBQNPqvL5vH4fGUmDNo4CiT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502841; x=1792107641;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NufXUE5fZx6ezKo0Nq9y9nq/Rk03+a0195URQ2S7FOU=;
 b=LtFpOoP1zJ6pmu00oRobvMJjoNiQxlosqemnMNCOh/7OalHKmN/QvWrwTkyTF6KuXT
 OpD90Q/aSWLa0GyiR74mxol1yXCyieaA2T1amrNJZW//ZHq+Zj/LH0XQh0I8LlhkdJT7
 GwanK4RaarJ517W8WCTJWyfxAyLYLgMrNfo728F0P/T0Zv3yf47afjWu5aB3vmSjVGbM
 VTDATB5UuaAVRgjD+1RkjOmDL2l27IJUhlVCv8kdngQqodr+/fVyo5HSkW7hpE5Y/F7A
 ReuQ4Pl40OfyVMlt/rQqFifZ/lvUL6QKiFuknxrieM5Wi6qIf+2a5UCNUN8PbmoZN8pb
 j+/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAsYRYARME1VzWThJze+C1tlRtYjMrH3AgEbPMlxLER4gjAQ2L7Bso/gfjLUfWKBHq0GVQFgY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m3jv2b6uXeVfYQ7nQghx20IqdN45Hs8aAa5oY7eyxdtQvh50AX
 6I80IFJ1kIRZ2UOQM8IDsuzN4o+bKcZ9+4t595Kr91dLmGGTOp1Ft2FQy8QDzcXaVig=
X-Gm-Gg: AYBFou3zmkVuECM99Z7Pu7KW7dVQTUWdfZG6uJgCbjYhSuAKqFWJHEjQNKTULoK52Xa
 KVEftMUSm73a/odihXU2rvVdP1aKNmD8AQTg88vnl9+Jk7TpSr6TAd9HKPie2dS5bI8Gs3UVIT3
 P4PKnPg1HkuEQXCHMo6r0kqtSNqfrbks84G+SkrmEObmDjiiMwKr3BZOG89qIcCSnfj3rCsfaMo
 VO/1PgLfP4BF47VXd2hLLapnJUg3uC+VlhkLYILxH6ZnPP/Aw/aS4oS5FO4eqAUcaYkjn8dwzGn
 sX3ge7QPEMm+kXWiwoOS6wiIc0uAWyW3wwLsd1mzAuNG4KDGUL1fGLF0tkE7o73UUZysjWpuPlm
 cyBQCWFZy9rc1nMm0c3bNqqQMVZC+7cMRXmvCmSEwhI/sumbTf7VX5DD2KklLD3mlbtbnYJ6vD7
 UIUzWlTAFueV/rQxWLvkWfI5+ivh8+yXc1L5qKsGKzT/w8hBDodQHlareiIUSnURWJj1aK6h0vd
 ArYQP+uqLJAAx6phkp1KRE+3WGM6f+fXEMW2HWH7s/lMeyC8CHp4cvcssNEGizWSGn2uUDor/a6
 a3otvWDw6nxficapf/w=
X-Received: by 2002:a05:6830:6b06:b0:821:c75e:5309 with SMTP id
 46e09a7af769-83095164fe8mr22432a34.7.1791502840873; 
 Thu, 08 Oct 2026 16:40:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-830383cd670sm431549a34.6.2026.10.08.16.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:40:39 -0700 (PDT)
Date: Thu, 8 Oct 2026 17:40:37 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 00/22] Introduce resume for J7xx SoCs
Message-ID: <20261008234037.GA1328652@bill-the-cat>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QqKNUhm9gsEIg1Z7"
Content-Disposition: inline
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
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


--QqKNUhm9gsEIg1Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 02:35:11PM +0200, Richard Genoud (TI) wrote:

> This series allows J7200/J721s2/J784s4/J722s to resume from suspend.
>=20
> On those SoCs, a magic value is set in a PMIC register by the DM
> firmware just before suspend, then everything but the PMIC and DDR is
> powered off.
> At resume/boot time, the magic value has to be read back by U-Boot SPL in
> order to know if we are indeed in a resume situation.
> That's the purpose of j7xx_board_is_resuming() introduced here.
>=20
> Then, if the SoC is resuming, the DDR has to be brought out of
> retention, at full speed and get out of low power mode.
> Between those steps, the DDR_RET pin has to be de-asserted. But the
> DDR_RET pins of all DDR chips are tied together on a single GPIO, so
> it's impossible to resume one DDR chip after the other, they must be all
> resumed at once.
> That's why it's orchestrated from board_init_f() and not in the k3ddrss
> driver.
>=20
> Once the DDR is fully functional, the next steps are:
> - retrieve the LPM memory region from DTS
> - authenticate certificates from LPM memory region and apply firewalls
> - ask TIFS to restore TFA and its own minimal context
> - start TFA on remote proc
> - load and jump to DM
>=20
> Disclaimer:
> ---------
> There's a potential attack vector in this sequence, because OPTEE could
> be modified before being reloaded.
> Also, if the certificate replay is skipped, then TFA can be read from
> MSMC.
>=20
> Patch 1 and 2 are from AM62 LPM series:
> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-=
0-7e33f2c77dbf@baylibre.com/
> Patch 1 adds support for DDR in self-refresh for am62/j722s
> Patch 2 adds capability to call TI_SCI_MSG_MIN_CONTEXT_RESTORE
> Patches 3-5 add LPM helpers for all SoCs
> Patch 6 adds the resume detection for all SoCs
> Patch 7 adds common code for DDR retention pin
> Patch 8 enables GTC at resume
> Patch 9 detects IO+DDR resume state for j7200/j784s4
> Patch 10 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
> Patch 11 sets the PMIC NSLEEP triggers
> Patches 12-14 add the DDR resume sequence for all SoCs
> Patches 15-18 add the resume flow for all SoCs
> Patch 19 updates the pm-cfg and schema to a new version
> Patch 20 removes now unneeded background firewall on DDR for j7200/j784s4
> Patch 21 extends the firewall for ATF region to TIFS
> Patch 22 add the resume flow documentation
>=20
> Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
>=20
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisc=
i-msg-min-context-restore
>=20
> It needs lpm_memory_regions described in DTS [updated to v4]:
> https://lore.kernel.org/lkml/20260921145325.300025-1-richard.genoud@bootl=
in.com/T/#t
>=20
> It also needs a bootph-pre-ram property in PMIC-B for j721s2:
> https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pr=
e-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/

Given these needs, should it wait to be merged until we can pull in a
devicetree-rebasing tag that contains it all? Thanks.

--=20
Tom

--QqKNUhm9gsEIg1Z7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasgp8QAKCRAr4qD1Cr/k
ChsqAP914tMvJRa8dUcy5QFQCc5YKTxuzTZbMZ7PQsWH1DUjgQD9H96Kg406753Y
fVcV2fxASMyF4bvNNJRTtOC3i8840AA=
=E+WQ
-----END PGP SIGNATURE-----

--QqKNUhm9gsEIg1Z7--
