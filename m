Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE8BC5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE27660849;
	Thu,  6 Aug 2026 21:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dy8PvDqQPyLa; Thu,  6 Aug 2026 21:15:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C45EB6083A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050906;
	bh=oa9+KvpNdBYKoP382wXb0kLLXt7YLmyEUHfdw//t7nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VJkf8cTku2YgXBq0Y8qN34sNfKNi3XykK8sj7qZMDtH59Af77kqYIuRllFURPSTTS
	 a58aW/h02tVwtDbhcC8I51kHrNPdR6Fv2QfQRy9xYIb25tvXS7Ntub1UOrEGDLJfo2
	 VbEwInO8cW7Me3tb42/XBY7whrq7rCsNxeZ3VRo9scxh2JoRyGkcc2bjx4Ype9FGNH
	 73XitndNVLFnT4nRT4meJSxrlhxVM0rRHcxmLlz6ARA30AoZpNQQvnYXBWJmPmOBy/
	 HcxOX7qOk9Flh9eA551DCGDlMTxxUrgSObRfFKkp+mnYbZ5cALUtpJUN4B0HMTY2dE
	 EaflrTy9F0U2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C45EB6083A;
	Thu,  6 Aug 2026 21:15:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F4D23F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 693A780F34
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RB82inGWaHrV for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:15:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8326080F30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8326080F30
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8326080F30
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:15:04 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6acbbcd3798so1682025eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050903; x=1786655703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oa9+KvpNdBYKoP382wXb0kLLXt7YLmyEUHfdw//t7nM=;
 b=tAutfKGnN3/BJ5N3XoiFWZWJce+nm5bwkGQkU7085opFg6JrScYEiCyWMwXwKB3NCj
 1TvmmrZzWSZLwCMZ5f9jwxkjDDpSPlm+KHskThqY+rFS3hYAeLtUxLXUUgUMS1VqsFML
 mAs6OWVR7ZCbZ6W5flbymdJ3KKGphDyIvuqioyOUiLC4nqlifelBI+Aszt/B1c9vs6xf
 uD8i/qV9KnE7bAMjJGIKFcvvvnN+Kw7nrUtRAljyUp4+Alt2fO6kXOtyMFXUSaAJDl4I
 K0IHbU38kqnZX3D930YTVeVwE8OF5Lo+XZNQBS5u/vd32or6iIQACOwKdV0WQvd1DhXz
 fBug==
X-Gm-Message-State: AOJu0YwiPH14TLGlUpnal6bT8bONRdGTifi4p0aAB1oV2MMEUUi0CjM8
 R1Dhiuw0jE5d3iObIHcHvbZiKDwsOUxJIo6ntmOudZK3yE+vLYo+pS4cwHOcvnZFpVA=
X-Gm-Gg: AR+sD11zLr0W/Mn5/SmhTdl3ZFVFLJfxv3AuPqioMDWEsOzcJRWMlAstgmMgovLEYPv
 Zrtq0P5Hr+xViCuc5PsrxpYnvc5nrp7JKVcIJvb7CuriuLiT+zpfEE0yp27QqN/4wvJHIYNbqJz
 o+93eA3uUOj32zdyaor3/x+cuDemFw4EkxXtC36zgWNWx/JDWtmMqcDbamdsKsUir3gvAM51Wz8
 OWzA8HQLIWtPIIdBPzMTO33CsLWtzeJ7jPVdouBBrPxCAn3K510XGzb1AYRF3BMSy1fjg7k6KBB
 T5sE1SeGAkipXE456NpXkwTycXPXDR3Kq+oC+tINSXvoP8ElQYUpIaqR8LBoTrwXmpsftXke0Mv
 mKSwbEoGjGb3cvBlCnd7eIvrnk23LOvKyvkalaD9VLY+sDcjqzrr2E/TGIgsySLPqt5kzL+yjiA
 n7CO0ZdUWlscVzWiDvMpzvIJiSPWwJQkbYrl2vxKNyQIo3B88wbwqnFdoQ0Vp8bjcbNcWVcX5EN
 oisaiSgqlJXl8gczR2B7McHuePyOpec0yMolCIfPi+sgvsDJbnjDnx7LxG+lCHI7Y5MPooGMsPJ
 KnobI5tbRg==
X-Received: by 2002:a05:6820:2016:b0:6ac:b07c:b34b with SMTP id
 006d021491bc7-6b0211ae9acmr2643421eaf.4.1786050903357; 
 Thu, 06 Aug 2026 14:15:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bbbdba8sm515338eaf.1.2026.08.06.14.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:15:02 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:15:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Arthur Chan <arthur.chan@adalogics.com>
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, David Korczynski <david@adalogics.com>,
 Adam Korczynski <adam@adalogics.com>,
 "security-cvd@anthropic.com" <security-cvd@anthropic.com>
Subject: Re: [security] Report of possible arbitrary memory overwrite in
 U-Boot's EFI PE/COFF loader (ANT-2026-1K18JRMA)
Message-ID: <20260806211500.GA180789@bill-the-cat>
References: <7beb5eee-9eec-4200-af3a-9934fd76c606@adalogics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qkR640M17lQdLE92"
Content-Disposition: inline
In-Reply-To: <7beb5eee-9eec-4200-af3a-9934fd76c606@adalogics.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786050903; x=1786655703;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oa9+KvpNdBYKoP382wXb0kLLXt7YLmyEUHfdw//t7nM=;
 b=EZHOO1pSEDSahCPspsoD+jNatrAsquif0SEUgR0SL6ikSOEjT6qr9DpESBVmbcTs9I
 +mpi5upz5HYJu62mvFu5AHj9I96bUN4Xhd1T5olBKBJiEtbqzIIuBdu2OhJCE/ZEbrTa
 2rJEi1cjbQSqM3Ven6kqbfdFuCPZzrHuHFIMI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EZHOO1pS
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--qkR640M17lQdLE92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2026 at 08:43:59PM +0100, Arthur Chan wrote:

> Hello U-Boot (EFI Loader) maintainers,
>=20
> I'd like to report a High-severity security issue in  U-Boot (EFI Loader)=
 (https://github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/=
u-boot) related to possible arbitrary memory overwrite in U-Boot's EFI PE/C=
OFF loader.
>=20
> I have attached 3 files with this email as described below.
> 1) report.md: A full description of the vulnerability and how to reproduc=
e it, together with suggested fix of the issue.
> 2) Dockerfile: A Dockerfile for demonstrating the issue.
> 3) driver.c: Work with the Dockerfile to demonstrate the issue.
>=20
> Attribution
> -----------
> Please attribute Claude and Ada Logics. This issue was found by Anthropic=
 from using agents to study security of open source projects, and I am from=
 Ada Logics helping validate the found issues and creating the report manua=
lly and notify the maintainers.
>=20
> Disclosure
> ----------
> This report follows a 90-day coordinated disclosure deadline. I'm happy t=
o coordinate on the exact timing and to provide any further detail you need.

So, this applies to all of the reports you've been generating. I want to
point again at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D36d49bba19f2c19c933d13b25dcf4eb607a030b3
because these reports I believe fail most of the guidelines there. And
in short, addressing issues (and following
https://docs.u-boot.org/en/latest/develop/sending_patches.html) is much
more valuable than just passing on reports. Thanks.

--=20
Tom

--qkR640M17lQdLE92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanT5UAAKCRAr4qD1Cr/k
Ci1iAQDdK7ZSmCOb83PM+H4123aWqFrxGFCf8DBnhQNsUxpWLQD/ZouEWERVHQlg
DRtPpLMnhOfKItDLpfiPVKRWRx//dgI=
=Qsqb
-----END PGP SIGNATURE-----

--qkR640M17lQdLE92--
