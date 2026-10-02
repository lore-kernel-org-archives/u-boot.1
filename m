Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF44CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 15:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92BF940BFB;
	Fri,  2 Oct 2026 15:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tovQvO954rQ; Fri,  2 Oct 2026 15:29:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D28B540C88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790954982;
	b=X8pCsIY/QggsUiqPPa5jFEP1CFaj4qiCQAHhkK5bghzcTIK9VVObeiT/1CnWLrtqcrfP
	 hXuxuXOwwFjDoChTTYW4lau+FfajTloDh302LswgyTkEE14EweUP0p063sXkli0oXapQV
	 SDpqEL00XYIJ5dpfjK7dooRBfi455CiBJpSpUee9w6vw7Ee0aMz69SjMmV1xYkEv5jEQ0
	 9WeJJhAtKt8AnGD3CBbQ6E/EClrLi46Wp2ccNfARYQQ8Wum8HsfAXpbMiQ0Oe8pLCA0jd
	 ONs3AUMlT7lK2IYhm9U+ilXTmVyUkv1w93UhPGZ7G9VFRRxfn6V6Vc4s7FzDH/Dg7ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790954982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Es0oei5jxGFKhMQZZmxD92aAdUx2siW58CCDfoSHA1s=;
	b=td6nUkn8f6HLONwBzXFy5KKrntcQaT4wcM7RqWztGFAozGQ/b9KlH6fRbk7T40xkgA6S
	 J/8uV5Q4DDn/XLIve3GbujLqIwaVuK/qLyxZ31QOH7/z+uz4wDyTcqT9wUcWIjEmPBqii
	 5QoM0CNC3VTgr/2XATSPksV9bdWHH1vn+D+j5rU1YzslCOz0DjSUBG2b1xRV3unbTmN4D
	 dUNQMbFC5KpWHUIfxzwi3Qu8H+q509AbPMKRGHFvk8Jr4SL0SgyLn19WbeLB5MiClxBtq
	 IcjdeUm9yvE2nu7sQFB0/UgQRfulz4vfslk7Ke3f1lCq4eJ5Gq1Rk1RSuPPUNsBDjuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790954982;
	bh=Es0oei5jxGFKhMQZZmxD92aAdUx2siW58CCDfoSHA1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5usqdbelS/bo8xXXwubl8+d8emjMCy/il8UVwERooGAqvXdQbuGn3XEFdEJnbZOf
	 knWGBwtRjQ7vWTVHdcZok63V4yJPFeUUL6TrLgFxRuztCy30NSNrmTKB+RcSxWWyPq
	 CSGlU5WVKpqIHrV0BhslnUN2Sfze3+TfuypQJ6AgaZqq8x84r5RQKhArdMlE9V4zLa
	 SBUtso2TguoXEnAFBhFDHXOYySSU+ljR0k/yor/GgW7QuHCx8nzYk/JPn954FwhlCH
	 bRhg2R2z6JHjGUtUQS72kLwyQtgjb0BNTWV2W+xQvLh2nmvUuS9WD6ZwrBwN8lQMdp
	 I0tJsKXOmqTSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28B540C88;
	Fri,  2 Oct 2026 15:29:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEE7C435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0457812DE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKAy603In6py for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 15:29:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07C678128D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790954980;
 b=le1qLVL70TjevuYHhqBWIW7T/ov5OnNAj+eAgUBccBP3BM3UmZ32uMbf0U5qXb/j4EzG
 YSQl1ijCf7GFlNmyu3zvwXwHSlxirAy8UU+8nLYypIRoefYgBLB/8l89YSJQkAdblOO7/
 UJhFoCTDG9ROzkRqDnFJsJ9LVlEIAxMgKvrEBwE35qjRYopNPj99S3Zn6w6qqyyEtQyPE
 9hjG8l34TjRcKfcCBRbqbXVeW7x/GAcVsS7Fhe/o6J24P+yD8ofywpdyf28k7caXG429A
 X4lLwyyC/f5Wxm9o1vI+Ps6Ec4wLNHaipngmdJ56Als8g4WxTbjw4FlD0wUdEOXiWIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790954980;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Es0oei5jxGFKhMQZZmxD92aAdUx2siW58CCDfoSHA1s=;
 b=MoCU7+55zNL+FzcU5F1+Ea1uyxwiPdEJs6EhFXhJNUt7VFZ+tBFyewMEftoAwVrzA9ih
 IJNNWqX1cVc0HVWXANHAwUMQ+Xo+rToqr86TXVxSKgeSPHxvM9oQ/Do3QG/g9UodXyxzF
 VI4spKakvc44dertg31ITbEZfhq57gI7tK28vkmMHWNdhbHabq3PcEQBjwJcCVG7x0qcs
 Wt7PnbaWfc3qyDmen2ll8vHurBXl2WCcYd4tajAMm3R7ejneuaTWjj6Cdl+uN1o44ufdM
 aEVsD65ITf/oCR+Bifv3HH8+bWOgWkXVMjNHybsOBssVEvJ4FKAmBzZSNYw+2Vf6vbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="bnVhGev/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bnVhGev/
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07C678128D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:29:39 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-48f0056ef38so7302099fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790954978; x=1791559778;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Es0oei5jxGFKhMQZZmxD92aAdUx2siW58CCDfoSHA1s=;
 b=bnVhGev/bBFowvrZhIjLI1Ie1M/WZY1NXNnyll1MwufFOl/dicyJxYxyJCFBBvWY9z
 W1hU82OPmvLnonXjv1Hc54b1w1sDCslO7Ac3wbjyZBwGM1QdX9YYTa+bdX8+i3HvpdJf
 Oh4VTULQSIefq4SBe/X7kov0aXsbbEBWV8g48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954978; x=1791559778;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Es0oei5jxGFKhMQZZmxD92aAdUx2siW58CCDfoSHA1s=;
 b=G27v6VjwFK1zHmerZjlg/jhlMCcjXDHvOPCzOv0WCuWlv9lADDjjainhkJg2U77bOi
 NFPudoVUeofhvMjqfsO1JG7E2sFB+lgOZGQv4y2LGx85tgf6pD+iYA5tcn0eSaiF8OmG
 KoQKk9vrUZruV7PI/LaC3bc5bBd159t2ruQzB9Vj+wENpg/ObapmpxkQhSBQyNGTzM0j
 eTG3UsY+nSWvaNMe8OP3drDCCn+qDXLAUtZnCvg6ctHDzx3n3wlrAInE1BnSvfGP7SLQ
 i3okbxL/+N7MZFTxpqW3TV1F8Ma4R7/HpoxIU9EVhKrtU1/mcBwONRZm9i3dRJ4oXIQC
 VuNQ==
X-Gm-Message-State: AFuF++mqQWI7oK9m2i1U+OCS0YXhN5S914SjBVxbZKnT0Rs7SGrn7N9F
 zAmDbzL5b+C0ieJAlhIZrakvkTc7pybC+gHbbONKLa37odjv/qNk7YGj8K0kpR97xZA=
X-Gm-Gg: AYBFou159ueNKtPhbOrzjqwvnBuJMYsNjuTknX0vue1n5UxHxrQL27fNOvLBI83T8Sc
 FIE4KG7sDkCLHdJ7F0QNZCrrDjv/d+lKw5r/UFpsfS/CsnyYqkSX8PwUAKxPpgB8h3N+TJjhPvo
 9OY3/rfgv3y9eoKzb+4P4sBAPDF+y6mZVLjKzntbMQLIsvpkdLxIuSW+t9Zm47bYE8w7N+D91Vq
 K3JFmks5/llgQK7nhO4IZ6cdLuhof/zADih9qKPvj5dqGbPvK0AtXsQBY5qTZ/nieREPVezVtg/
 wbywvUvC/DK2WWylaJVv4FxcYxiNFUNBF9cngJhJt/dyjeomaCPWjtBiI3dZ57rarP4KCzxQlxV
 KCHd72zcpAIbY48LDqVYfgDdqF1xYu5MpwcHKYeVnGAYECL7cTWn2y7aPRpVoTTc65MY9ePaOru
 ATOj4ZK0dpIW/62Ohj2CmKC7tJLyKrOsbfy2D9DtCXNnxZI8orsfxkGoOV2Mt7ZVmNfpWzL0bDm
 X9eXPpbxaj2iL0SJsHitsioU3lneBwtFeJdGZjXUkrxPrnFSMqtaTD7OtiD+LWW4ijXP1zY/e7Q
 OkTl0zADsk3r/pDcgpHv5MK0EHO9eQ==
X-Received: by 2002:a05:6808:301e:b0:4ea:18f:64a5 with SMTP id
 5614622812f47-4f529d29bf9mr2276595b6e.12.1790954978446; 
 Fri, 02 Oct 2026 08:29:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16ead0dbsm2285029fac.12.2026.10.02.08.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:38 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:29:35 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 06/10] mmc: metanoia_sdhci: Add SDHCI driver for Metanoia
 MT2824 SoC
Message-ID: <20261002152935.GV858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-6-bc44cf0e0289@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ussiupiGRIv35Wo+"
Content-Disposition: inline
In-Reply-To: <20261002-mt2824-v1-6-bc44cf0e0289@bootlin.com>
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


--ussiupiGRIv35Wo+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 03:02:24PM +0200, Beno=EEt Monin wrote:

> Add an SDHCI driver for the DesignWare Mobile Storage Host Controller
> (DWC MSHC) integrated in the Metanoia MT2824 SoC. It supports eMMC up to
> HS400/HS400ES and SD cards, and implements the MMC driver model.
>=20
> The controller is a DWC MSHC instance, but its PHY programming,
> voltage/speed-mode handling and tuning model are silicon-specific
> and differ from the existing DWC MSHC drivers.
>=20
> The PHY pad drive strength, receiver select and weak-pull settings
> depend on the card type (eMMC vs SD) and are re-applied on every ios,
> whereas snps_sdhci.c uses fixed pad values.
>=20
> High-speed modes force 1.8V signalling and HS400 uses an explicit PHY
> DLL lock sequence (set_control_reg()/set_ios_post()), which snps_sdhci.c
> does not implement.
>=20
> Tuning relies on the generic SDHCI core tuner, whereas snps_sdhci.c uses
> the hardware auto-tuning block.
>=20
> Keeping a dedicated driver avoids per-variant branches in the shared
> DWC MSHC drivers, matching how snps_sdhci.c, adi_sdhci.c and
> cv1800b_sdhci.c are already split in U-Boot.
>=20
> Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>
[snip]
> +static const struct udevice_id metanoia_sdhci_ids[] =3D {
> +	{ .compatible =3D "metanoia,mt2824-dwcmshc" },
> +	{ /* sentinel */ }
> +};

I don't see this compatible in Linus' tree currently, so what's the
status on upstreaming all of the device tree parts? Thanks.

--=20
Tom

--ussiupiGRIv35Wo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/N3gAKCRAr4qD1Cr/k
CnEuAP4pjxvcyXXa71uH03T57oduFDNwiFaXcZbeU2PqI0A0CAEAurcnQCaGEWuE
xLq8KRD3efcagJDBE4y8DNWq4W7Pgg8=
=EmrO
-----END PGP SIGNATURE-----

--ussiupiGRIv35Wo+--
