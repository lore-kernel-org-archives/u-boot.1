Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA04C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF675406E5;
	Tue, 25 Aug 2026 22:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jl9uLM13ne-e; Tue, 25 Aug 2026 22:54:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698443;
	bh=oE0rxuKG4XKsZsEt+EWzeqF6D9ZCFeur8aRvDnmd3Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nv/r6kNEORu1Kr/H5TnVBTpEuYPGOHKQIRimaSp3ACfPfSIhZmxIvxJP+/okwFdRb
	 GR2XLSrOh35nu9ZuzfWq5wTukf920y1TC4lbdHPRTEyeqKWIY10pcVPPwJB8s25q6b
	 2OzL2Ipn9wldKWZGSTL62FY1zyMNPRUX21OL9PSRBfA8tMEptFxXM4Vjow1LyHqdin
	 TcMjPjAt7IU/iNn1VBAmzJJLVXqICqK0AEy/ig/DCv0lc9K+i2BkUkGEN8sP6Fxsa5
	 1899bk72HHnk6031WFAB3TIZNnseDMlvvMuiQEaRDFxtD2rlu3gZIzi3Kki906H40P
	 La5O0ZpU9r/WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00EFF406AB;
	Tue, 25 Aug 2026 22:54:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC3BE334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B2F80698
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Iu_kIZsXAVA for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=S2rg+Kti
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D9258068A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:54:00 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a475409044so229501b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698440; x=1788303240;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oE0rxuKG4XKsZsEt+EWzeqF6D9ZCFeur8aRvDnmd3Ww=;
 b=S2rg+KtiUJbnMcvkDVQ+SgQe2kutMJQe5hFJvUQ1w3lnLlSCPJxJL92IXtRMY2vffK
 PtBuCsMboCtArcPuRXhqLauIui2gPj2XezQpAtYtecs0rfqCshJ8UxXrnD8thv/L4ekl
 8hJoP7h8Wdpx7gBXSlsiQv9cvM6PDZMpUESlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698440; x=1788303240;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oE0rxuKG4XKsZsEt+EWzeqF6D9ZCFeur8aRvDnmd3Ww=;
 b=RnQcq9KDegXLcS4Gef1nYExwU7Exr5vQPHpNCI5pKPIb0ydY/USs+c6cslLQexle/s
 +tMH3DSIydGvyNGmZ9Htg0d+QeLmb6Fvda7rLf55XORZBmfyVIWVoY+pPlzVVjl/3oKI
 q0yuQu3f71OxhCwL7P8Lm1WDXqEcFk4NrWUEZv5tbb5WtQy1hThrN7IMI/LDErZY8ISD
 9RIlJ/XuiJCOWWdBL5nbLk4IVa7nwe8Eh7PNYk2sUnzwWNjbe7ODbVesk34UeoNG5R1J
 jrvqE7X4jRnzo6LQEyDfFd3pRukoS0u5rsQ5QDvWksv0u21p8u6fQ6CMuzsL3hjtLJgM
 34Ig==
X-Gm-Message-State: AFuF++kSLQbqKpSVc9IVhyy/NR0OSzoW1+c9V9VRDPsO9fsmvmAPoYl3
 BvFoLWbhvuwcRFL6sIAVphwW0CkXzyZHHD+vGvgYhVZyucppporCke3DDJSqpuOWerE=
X-Gm-Gg: AR+sD13pwIKfN4dkDQQ523B0HEzqywTcZtzsFOFG5IyovCr6VF/DQwXa7gcygphyqHZ
 8a/CEv5uNfxN315N7x/FE/JMjgXwLyO4vtLFMYIusu1vdo4leHBOPs48ldvSGskvwAyVQVUZUWD
 7/ZpUDDQD9pN2ovYiDYkxOAQYsr0Lj9pZC9I4KIc+BhmSY7JPSBGDmIaGROKFsVYckewSX/av4w
 YQ4VuZkTaj/7gl9EfuYnx9SuXcNZ4fkT/TCRx3BLm7LJ5uSRZG+7jEOW1Tk/QcehfjrkQSvOvlP
 ZRiSYzV9dQBLsdbyXM/QFsqCjrV0riPd4+mkudqECOPoSfruROvwhaqH0Ltjm9FXPgDr11sTgVT
 RsszHnRI3jELUCUFqY1qiIRmYoFbZYZnAQ5e5EPxE/51L18HZYYdzz1z0ID7Zq9/1ig2ag6Geab
 BCsu8oQQp9PvrSQ57lvk0/yW9RSLhp5yEYQMrwjdioQJaDvySmQGlxfJrQHH/oUERhaw/O0jdLg
 Kn9/dV0oK/vNAyuq4pQ5FbCNo/ii2nnY81I6Tb9ha+Fxo6Egz5grKAsxccNrFY9FWVgdpZNb69s
 YOdf/HOztA==
X-Received: by 2002:a05:6808:c235:b0:479:f7e7:4a81 with SMTP id
 5614622812f47-4b36635caadmr3178874b6e.0.1787698439725; 
 Tue, 25 Aug 2026 15:53:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab734ddsm179670b6e.14.2026.08.25.15.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:53:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:53:56 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 02/12] mips: en75xx: add TPL and SPL early boot stages
Message-ID: <20260825225356.GD523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-3-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MmCpgRg1EBPOfZSh"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-3-maskachoska@yahoo.com>
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


--MmCpgRg1EBPOfZSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:11:57AM +0530, AK Sharma wrote:
> Add the TPL and SPL stages for the EN75xx. The TPL brings up the cache
> and SoC straps, runs the vendor DDR calibration stage from flash via the
> early SFC (serial-flash controller) reader, then the SPL loads U-Boot
> proper.
>=20
> The DDR calibration stage is a vendor artifact read from flash at boot
> and is not shipped in-tree; see arch/mips/mach-en75xx/README.ddr-blob for
> how to obtain it and its checksums.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
> ---
>  arch/mips/mach-en75xx/README.ddr-blob |  21 ++

Documentation needs to be in rST format and under doc/ (and then make
KDOC_WERROR=3D1 htmldocs must be clean).

--=20
Tom

--MmCpgRg1EBPOfZSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4dAAAKCRAr4qD1Cr/k
Chw8AQC9NfkifRoTc0/5B/pXT7GDmHfXIE6HL9m8Y/wCnoSiswD8Clz+7/WF0znh
w48bgqVyGfJmaiA2F8E+zlUPg5o5GQE=
=9CkO
-----END PGP SIGNATURE-----

--MmCpgRg1EBPOfZSh--
