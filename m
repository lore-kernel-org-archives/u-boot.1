Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B29AEEB58C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A207186A56;
	Sat,  9 Sep 2023 15:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nNqayA3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4357E86A51; Sat,  9 Sep 2023 15:31:12 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A51C86A4B
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59205f26e47so28451537b3.2
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266268; x=1694871068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jan1U82KnyY2uVRoREsLB0mY2LQk80XTOC2Mvy57OVY=;
 b=nNqayA3mtW+3htA1Ran31zNIW/nlgmcppzSXudARUNELVdKgutqNvWt4KqMi3FbDrV
 PauLntk6iQkeDMEl8tUsJgTSye5/ryvYcnQVsEgtLsa1PhaTwRFkjQexgixJP638S68o
 3uA0t3kh5CT4Pst+yBnXWMr+MQlD2/O6bDa9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266268; x=1694871068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jan1U82KnyY2uVRoREsLB0mY2LQk80XTOC2Mvy57OVY=;
 b=Lrr1XVGitS4w8q4WGO51VvYA4erMUD4MoWAHx9Wtzqmptvn7HqnqJfcutXG54W1KRN
 hGdCn+Uv9id/OFSr1RXs+6+1q5nFoOM6VGcCwGsUrVrXOPkrh3QwdbBIkOePnjqWyHLy
 cUp07xA2eoQdcHS33wnhrGlxb8n8hv37gihWW9Dmv/6XW0USDP3+rABT5xBXPJXc+8QV
 UHjrh1eZIYzotRoBNYXTv3nBTENu1ufEYuT1BvYCNcQ1hH2hMr6xFq4Y4b1rxTe9Co6E
 E4OSw3tKAIwKdrb0N61bi1FAGX6r9+n83/24rVv4HMhWBfGDcTczbna+2Ay9L022xrsS
 7evQ==
X-Gm-Message-State: AOJu0YxSGviD/nsRBDv/JVlrXK6nBasU8dSyMMW7Gm+R1WLYgEJFXA/6
 649kYJ7nfak8CluIYE9IHe5GEA==
X-Google-Smtp-Source: AGHT+IG7KKb085S0eeB7nhFkzDfYS6F0XE+xU6cqEBnvB4yC03Pg3u4ilNKQt45L+ATlcLSfGVJh8g==
X-Received: by 2002:a81:8485:0:b0:577:24d9:4001 with SMTP id
 u127-20020a818485000000b0057724d94001mr5247440ywf.13.1694266268371; 
 Sat, 09 Sep 2023 06:31:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 e129-20020a0dc287000000b0059af121d0b8sm946405ywd.52.2023.09.09.06.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:31:07 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:31:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: bb@ti.com, m-chawdhry@ti.com, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH] arm: dts: k3-j7*: ddr: Update to 0.10 version of DDR
 config tool
Message-ID: <20230909133105.GP305624@bill-the-cat>
References: <20230828114405.2537829-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7C3sUp9uRuwm1fnL"
Content-Disposition: inline
In-Reply-To: <20230828114405.2537829-1-n-francis@ti.com>
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


--7C3sUp9uRuwm1fnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 05:14:05PM +0530, Neha Malcom Francis wrote:

> Update the DDR settings to those generated using 0.10 version of Jacinto
> 7 DDRSS Register Configuration tool.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--7C3sUp9uRuwm1fnL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c5kACgkQFHw5/5Y0
tyzYUgv/SnPkJqoeG2AUHskiTOHzrg5YZ3abodsdTuJxQUNH1sAx1QgoGQOfhC5o
6n/Sdf9zJnlSlWUOVFmncH4/Lx+d61nqwGvWs7Af6z9x+fyn9EG2Myey8SMWCiZT
w8VRhvrTAB86i/2IRTX7UFtLHCN3WQAthEf0GCNwhDlAB06lc0POaZlUdOVmqsYO
lJ3L36092ie1OMLvVKSaK5qDuG1F1nxBxGWhaeBWnpALo+0ooEjxug4O0/DRH/4U
T84r5Rgc3HwXriQI4V9Dzah8gLNHsgqvT0KYmyi91ZHObz4gixas8tjmub9PJbcU
gLbeONvig6Py0XkJZN499p6+3OTTuTLsKa8uPEHn64mIx/grq20xDc6Jf7AK2ycR
7XKag6dt5K2msyDtPcjZCsZp9hfb03yQFEJmV/LI2GgTq0DoIio048syZ88XFkni
GyCl1owTpb1dZ7qa8S7k+MnCfdRZUBW8LurMT+rEoRfGnXnyr87vJFHmxZyURenj
NKvpkJSQ
=SuDF
-----END PGP SIGNATURE-----

--7C3sUp9uRuwm1fnL--
