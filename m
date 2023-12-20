Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07ED87878;
	Wed, 20 Dec 2023 22:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rdRpzmnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2EF87872; Wed, 20 Dec 2023 22:02:15 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8B88786A
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6dbaee3a31eso44194a34.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106131; x=1703710931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SRMbCbzIQNB6INiOEguBHHy+ZjbNnrRim40W7DHVlvY=;
 b=rdRpzmnKzGVbJpyurxlk/UGMG+VyDW+uww2x4wua7TnQqhsbLh+6W+UOgHalXAAIEp
 seXidmp1P08NodpEuGOy/SrBO5jsD667Q0no6+kW5cNmzA9mMuBiGRqpAfAvRn3uv1jj
 HAEzgNcTPSx/CHFq5/Kp2S8IhwknY2LsKj6To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106131; x=1703710931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRMbCbzIQNB6INiOEguBHHy+ZjbNnrRim40W7DHVlvY=;
 b=gi3x2p7s55c6I8DD+zC4kDTYNA4clAHhUpPkgM7DMXuDxXNBrK//MPbOjWzbgBcUEB
 gW7elZZ2iYWN6DY/4EOnJblpXvKobVd36CRwBTR05xGrX13SxFTXcxcO0uP3JIwBMwyl
 agbZX2nX5m99+rOUNBbCisq/2POO8NnCNr2CE9wdnqup15Xz1DteHKvmvzW22jij766Z
 smpaPE+Pmb3LSRGeJBUGJgS2F2gLY6e9Wgivg0HL1/JvxqSeDGWL/RImeBUqYFVCoLgJ
 Xs7N+enFGSDWvejdEwWBWwUKlAsfSj+3Bro9nxg+6lGOjaQ9U0NSvqF5+IZcUnYgF3vt
 JOow==
X-Gm-Message-State: AOJu0Yz67qMmhy2kSNltdjY7/QGIuB3SXeWFlFsImvpmQ6w6V7o1Fj6a
 wLdfIqdlIhT1dPMTPhONAV8DHQ==
X-Google-Smtp-Source: AGHT+IF5XUfMbYD2ItMIzOih1fRS5m38J+lO1uA85AyMQ9FdU/HtKTcUvIHAaT+1yDwookqUbLt3Ow==
X-Received: by 2002:a05:6830:ed1:b0:6d9:cbc4:efd3 with SMTP id
 dq17-20020a0568300ed100b006d9cbc4efd3mr20201342otb.69.1703106130935; 
 Wed, 20 Dec 2023 13:02:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a81b401000000b005e7b1884183sm230224ywi.21.2023.12.20.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:02:10 -0800 (PST)
Date: Wed, 20 Dec 2023 16:02:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] command: Move command completion temporary buffer to
 stack
Message-ID: <20231220210208.GA2513409@bill-the-cat>
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
 <20231202205255.169670-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kfbGWSHSkh1Bi3iQ"
Content-Disposition: inline
In-Reply-To: <20231202205255.169670-2-marek.vasut+renesas@mailbox.org>
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


--kfbGWSHSkh1Bi3iQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 09:52:31PM +0100, Marek Vasut wrote:

> The command completion temporary buffer seems to be only
> used by the argv tokenizer, move it to stack. This saves
> 2 kiB from the binary size (depends on configuration) per:
> $ aarch64-linux-gnu-readelf -s u-boot | sort -n -k 3
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--kfbGWSHSkh1Bi3iQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVlAACgkQFHw5/5Y0
tyzDqAv/f2SDjol+nVqsjJY2UqIh4IukU4by6YhJMm6Pit6vHcnsqUBXgBVtXinP
Yr//uYwflvKLHvFKUwVYLfFWrv5/F0BTrfQHt8XoZ+aBxvXenSKNh1QBJxVeIvJI
NwgyYczcpaewIbbKf+DoUp0ACAoTuvksnqxKvvUrnlaPMvmRNHcJK1koomWtj9Hn
tElpn3mcu1HuloFQypWn5d5YwUBgdnwuryDVL3YXRrsI1/Z2spCZNoESkPlsboDb
o43KVLgaRnexMgA8JPh79nrZila6lWFAjJ5dHLuoOzjT5/Hu13DP7BPCKfqwm8mu
m7xe1ToC86/F4DC9eSibs2b8J72MJmcb50+T5FccjznJVKlDmCV6i+r9f+65RNkt
d1HZtFYcgfVG7rQQMFwHOP50dNrOqtPpLM9/R2vPUjoTE4LzM/StbKFRI3Xvq/4d
pv12FpEUEVdgDlgKF8MldvMj0X/Q+Hry9SU7ngwRyEImFCJm12VyeBFL1yJMtD/V
oY6IpEpU
=fdr1
-----END PGP SIGNATURE-----

--kfbGWSHSkh1Bi3iQ--
