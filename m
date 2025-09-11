Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA74DCAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE004833BF;
	Thu, 11 Sep 2025 19:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZLzLfTBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA709833D1; Thu, 11 Sep 2025 19:26:40 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAD883390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61bd4a3f39cso254929eaf.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611597; x=1758216397; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IVbPQ0erlBALnsSeMbzU/G0Veec8LJhbfyvgvXP4dlM=;
 b=ZLzLfTBXCKoCDXg9Xsn+DGbRcgvcNwlMjdOAt0LngUfhlPLsVyLPo+ihaVrFlh5ZpI
 PKWh68cV4KbuGBa+E9LCFAg8m7Up7S33v8Lz+RGTTw/Q8eE2ZHdjkGJC+JK8rI8Me5Eb
 kPFr6XlCvTur9laGAxvcXW0sDacmXBVkYKf9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611597; x=1758216397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVbPQ0erlBALnsSeMbzU/G0Veec8LJhbfyvgvXP4dlM=;
 b=qcU6XmUf5SkHIFTvKZ8Kkk1Uujs6+Lol/BVy8Uge3XKc3Qajq27h6E3UUWc4KiDyGj
 McW29JcIK9j9Ah4Iz+MeMl13KQ0H/WBI1WiWS6wuwXAYQi92M1D4wv/+urVEOneZL35t
 WkaIUrwhadDlEtig1/KHdvvwoGzDjpauVthYuKTKCQfxkSx01KRcPn0wCIcImvT3uaiz
 V5vBtJtU5rU7gcnlcatg5GGYTlxQ8NOFf8uZitxWDlV18ngJPFtKAh1gacqS08O1u3aE
 K5XzO/dzKtoE2gPER+IBRiyWl/JNt4/9iUkg4d0Wf5ZKHB9l/L6ZI8Ydq3/j9XG6ZOlT
 j6Uw==
X-Gm-Message-State: AOJu0YzjlodPFrH9pevlrgFFKdpc3yVJ9KgWC8KJgXzbGSXggG2QDLNV
 4pQDd7R+Q8SX0Kecpcok9Qe+tkSB4xhPIKobuUtjLmL36stJXrbrEgo5du/Watdz8/A=
X-Gm-Gg: ASbGncscylgr1z7+ONsVEzUooiEuRdSmS4kZE9MtjUiFT+KTSbfaX3WJpLvuw6PNRbi
 8sjeX15xsAI2WJuciEMf+0eCwmbDa4p58CNkEE+7dhYe8bd2jHq2sMafgTZ+2hG9IfSJk+4qceh
 Q98LXBd6iR15KliBJwUf8sJrBNqnhMhFcDPe3M/xYe6UXJbRF5DCgpQMPiGLJeZDGfFsfsK2o5p
 0GQMGuhXpXEIODTKor4Y12yJT8mesGmRh24DJuEG2pA5c1rFtkb9xGP6yLRl2FsvCtdmo7xWt0L
 HwOIiDxuv6zWyawLqdqDRN0abi0AbD3WXGEG1ywB/BttWIEiVHkP4dOU780fqYR4mjy5CFLsLvN
 9OoLVL+HFunHJKFovoQ6HikEHgTc1wpNI11M1LhAQvnol/YL+IhV/Mb3n+hQXW2bFdhM=
X-Google-Smtp-Source: AGHT+IHl8mBjFYL2OS4jWFL51VDLoJGaR7ZRmBAIh/SAuht9UtTGn5rhpLjIRmYYdGa90MnyIlIikQ==
X-Received: by 2002:a05:6870:a108:b0:315:bbfa:b712 with SMTP id
 586e51a60fabf-32e57802326mr3082fac.40.1757611597469; 
 Thu, 11 Sep 2025 10:26:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d3537ec98sm543466fac.20.2025.09.11.10.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:26:36 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:26:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 06/17] spl: mmc: load kernel image before args in
 falcon
Message-ID: <20250911172634.GW124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-7-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5p/39tWy5VehBXv"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-7-anshuld@ti.com>
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


--V5p/39tWy5VehBXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:02PM +0530, Anshul Dalal wrote:

> Load the kernel image before args in falcon mode to be consistent with
> the load order for other boot media.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/spl_mmc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

For the next iteration please CC some of the people who are using the
TEE case here which I think is non-TI platforms. Doing
"tools/qconfig.py -b" and then "tools/qconfig.py -f SOME_SYMBOL" will
show what platforms enable a symbol (and you can list multiple and '~'
means does not set a symbol) and should give some hints about users.
Thanks!

--=20
Tom

--V5p/39tWy5VehBXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMGSgAKCRAr4qD1Cr/k
CjSMAQDNUPf/mHed7uiPScXdR3Eyoa2bJdZlvpixC+F2am/+4AEAijr/+HxoZ+aJ
PyiSNGmUN7busWsuYf1nYLQC7pmYQgc=
=MXyy
-----END PGP SIGNATURE-----

--V5p/39tWy5VehBXv--
