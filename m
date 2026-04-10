Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35CEF36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 02:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3AA84099;
	Fri, 10 Apr 2026 04:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TrI5Kg65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF29B84099; Fri, 10 Apr 2026 04:05:05 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC1183DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbf23885dfso969485a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775786701; x=1776391501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mENjeSZbQFdRu98npBznOH1cdhHqEuwLMg7t0UAPzVY=;
 b=TrI5Kg65TZpQd9zbLf4UXmJx4jo4q2X6vXwOpfo2DhQX+FiWHfhqF62ydIyX82h9QI
 TjqZn3gpklewYyUSmz1lnThyM0obfCyy8VWwVcJGUyNPCBPQnYd9m1gQpl/1/aWs7VEn
 4Y3orBbY9u6wJljDJ35fsmspElyH+uiMjkeNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775786701; x=1776391501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mENjeSZbQFdRu98npBznOH1cdhHqEuwLMg7t0UAPzVY=;
 b=o+1N1a7H+chYY3ImJNSvaTnw9On2+GX8Y8nkueryi0FVIsf1iYadE6K6AZEaIiUhij
 fiIIyc0eQux7O03rCGbDzB+Ls9IlMfLZNQAiP49zwaPIicgweWyiQbGRWhfTxN61akQ/
 pka/OhmbWrE7HVIh2ouIe+2hcMryujDJ3LDmyIU9VLPeTFnkdcOGBVGcZhztyAm620Go
 rKnVzgle2Ply4JtKzOzB8m0/XFdyNxr38yuHJnSwpbrxCfkJ2xdwGzfCVe1b/b/t6+ZV
 Q503Dw8/OaF7LvIe/jhRjRkmXoAONoYGZcRqvJw7ar79JY56zn1xxO46A/Yut4dqN+T+
 GOSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8pH3uRuvwWVY6jMHoSYUfVj7YJBBdM1Z/rUKVqCn0gRo25PNjpK/ZA857mvEIvvWk58bfm6M=@lists.denx.de
X-Gm-Message-State: AOJu0YxaDG89c+dI/GJTsRC5HMPaSJRrbm00zdYs86oMVpJLi7KXccmP
 r8llHJjWbDVLNoSZLxZZ1kFSmG3LLk7JQ/Ip/ZRyo0a1xgmlZWtRPPKK3UqadcKeUgQ=
X-Gm-Gg: AeBDievP+KwwVpLqehOGLBnJksRf6NMyeBxNA/s7dEmZB5YlKnfHsbNVlIpYSrg4oMx
 I98sAUOP/jTVGRx0qcSDnWCOCa+8TmuF/IUSPBz7/0PNZtjvRy59bFKf/Rm1MXAEwTyhZjGKDSX
 N63N6ixtEByDr7+5I/6f5PGcbHL5zfFUX/RTkt8+YrePH82NzeRyhjJ/pOhXNyX2qsa4KFGpuoV
 ZwJpwZMJ7mQVIREHx5V7M886U52hxyaSiFKZZPj20mxFdSmv7W5omc7z6zVnT9JTeUQrshE2du5
 D9t3rta1kbR6VRVVGNqO+jpfEafmSsI7E/RCa+VkpfojuvVdqmO+5R9Eokg+P6xIrpbAiUnIVVx
 X7V5blkaznrIpgN2SIh9YuC41zkx2BHDgB8xnEtnIm5/L5eHNWSN7DnD0a2dKvfSBTQgZysYFDf
 93GfB9gb3PfrpMp9UcR/rqNBnOF+0eCsqYn701tLAP0iu8XYpdj3XBrqaCF0VRYxz0R+q8YKMuv
 dLbQ7OvxayPSOVC1csdxiHOWL2DaKsIGLWaXMB8q47YrGc9Dts=
X-Received: by 2002:a05:6830:81d5:b0:7d7:57ef:384d with SMTP id
 46e09a7af769-7dc27f0b2demr935810a34.16.1775786701097; 
 Thu, 09 Apr 2026 19:05:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc269402b9sm929859a34.20.2026.04.09.19.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 19:05:00 -0700 (PDT)
Date: Thu, 9 Apr 2026 20:04:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] arm: Add ARMv8-M aarch32 support
Message-ID: <20260410020457.GS41863@bill-the-cat>
References: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
 <c8a97353-0c3d-4d98-8252-c0bb91a658a5@ti.com>
 <a03ecada-fa00-41ce-99ff-cc1a2a8362b3@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1IrrSZDnp07q61WJ"
Content-Disposition: inline
In-Reply-To: <a03ecada-fa00-41ce-99ff-cc1a2a8362b3@mailbox.org>
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


--1IrrSZDnp07q61WJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 03:24:10AM +0200, Marek Vasut wrote:
> On 3/31/26 8:04 AM, Kumar, Udit wrote:
> >=20
> >=20
> > On 3/30/2026 4:44 AM, Marek Vasut wrote:
> > > Add configuration for ARMv8-M aarch32 core, which are currently
> > > Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
> > > cores, except the code has to be compiled with matching compiler
> > > -march=3Darmv8-m.main flag . These cores have no MMU, they have MPU,
> > > which is currently not configured.
> > >=20
> > > Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
> > > SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
> > > initialization code is built from from arch/arm/cpu/armv7m and not
> > > armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
> > > for devices using these cores do come from arch/arm64/boot/dts .
> > >=20
> > > To avoid excess duplication in Makefiles, introduce one new Kconfig
> > > symbol, CPU_V7M_V8M. The CPU_V7M_V8M cover both ARMv7-M and ARMv8-M
> > > cores.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Casey Connolly <casey.connolly@linaro.org>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Udit Kumar <u-kumar1@ti.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > > V2: - Rename CPU_V78M to CPU_V7M_V8M
> > >      - Isolate V7M specific and otherwise option bits in cpu.c
> >=20
> > Thanks for v2 Marek,
> > Apart of name of config discussion over v1 [0].
> >=20
> > For changes,
> > Acked-by: Udit Kumar <u-kumar1@ti.com>
> >=20
> > [0] :
> > https://lore.kernel.org/all/30108d25-efd6-4ff6-9bfe-0dc55670a83f@mailbo=
x.org/
> Tom, is the naming now OK ?

I'm unable to come up with something I like better, so, yes, I will
merge this soon, thanks!

--=20
Tom

--1IrrSZDnp07q61WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadhaxQAKCRAr4qD1Cr/k
CufsAQDzw2Gx0r3IXsBjbyBN4unb6wf1r+OodahF41PLCjS+aAD/QHgNeX13II3u
+rMoS+d2xysXSSn0LQ8IgmleZApIXQc=
=eUqZ
-----END PGP SIGNATURE-----

--1IrrSZDnp07q61WJ--
