Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC4C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 20:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F1888002;
	Tue, 20 Feb 2024 21:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KfG+KhjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D14888002; Tue, 20 Feb 2024 21:05:08 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730638800B
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 21:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc238cb1b17so5488192276.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708459498; x=1709064298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vnRHFzCRt7+YKUcvSJK6yvDtm4YgT250xgOCBeppl08=;
 b=KfG+KhjTT5zlMo3AH8gQpz+LM4znNZNJRxM0/5qcvas1KIV4BYhOeSVFq58kLhJSYk
 QdK3Pp06Aa0xEr8t7fnUTNYxtwt+RQxsjHYFEZ8csanedCwLE9BDPtaSqV+7E05NJNFY
 SH8UW2WenmngFJq0OVhOguySbB7BmrqiA46o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459498; x=1709064298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnRHFzCRt7+YKUcvSJK6yvDtm4YgT250xgOCBeppl08=;
 b=P8cUbQ7F5w0ftzPZlJE0ULKGMfqlnhDvnNs/7AmL2z3DKhq7DqfNttwMRbq+C52fMj
 mB/qEkUM18Y67EVmsH335j68ignTZTfueZ8OT7U6AxZNixFfh2iPFWylkrgT7s1Pzk3C
 p57ji0ru4ZLdKYqJXWyA++xfN44vs2KuML3c6xX6zhHRNIHrCFrm3iRsIt+RERHGT0su
 8z+EfXajX4X2DDGtYCigFt+RSdAprdHoPJdvX9r/e6Lhxd5672Q6ARUIYFgYO7GB5Y4R
 BitLrP0P5aR8lpkklmaKM6NAhhmBNcLU3k+/ZtJrEZTA69TsjzH8l4wGtOP86cJgcdRP
 3HIw==
X-Gm-Message-State: AOJu0YyNc45IWQ84NIzVNlB+KbJjvaFCYOi26++eIuhAdXia749Zn407
 yNBi9UqfLaRlv0EYilECOi6228jevnhTzujUYqeZf38xO5e4fUHNYwxcXBUyow8=
X-Google-Smtp-Source: AGHT+IFq3/60MbFHX4je+lUE3/xfoCWFeVVW79PIWerYQOwhgssr1hGW5z0lRcQYKKFN/GeDlHrgOg==
X-Received: by 2002:a81:73d6:0:b0:607:60a5:8448 with SMTP id
 o205-20020a8173d6000000b0060760a58448mr16333483ywc.0.1708459497902; 
 Tue, 20 Feb 2024 12:04:57 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 a191-20020a0dd8c8000000b0060871d7e03bsm245013ywe.123.2024.02.20.12.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 12:04:57 -0800 (PST)
Date: Tue, 20 Feb 2024 15:04:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240220200455.GR3040305@bill-the-cat>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mkTrhJmKhBV8cTCg"
Content-Disposition: inline
In-Reply-To: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
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


--mkTrhJmKhBV8cTCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:

> Add a test for reset commands which performs resetting of CPU, It does
> COLD reset by default and WARM reset with -w option.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--mkTrhJmKhBV8cTCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXVBeQACgkQFHw5/5Y0
tyw7AQv+PSXrJ+FuPPcf8UC+dQ8XVIhWBRz8g91UgsOcrBv4HfAjqVtD14mPMSHQ
eyI5B1Z+vSQP4YKZybilB8kQMbc56dS3m+iRq+2x6xLng+0x05Ar+xbiq3TGJU6T
nPOrSTDNM93HKigICP4PjqnEhrtTx93ZOVESRmkmhwJxWtQKtP5/JzE81nUNsNg7
KJzroBd8DRUQTkGQFPvcwPoWWwWAOWiCr9BaeOgQ6HQHjr4CTTwydSzLSmJfCuvG
lUK9QoVGkFQ5oxh+CFhJ11BYQunvl5xZpTzqMZONfAB+zVpaynAEHVWzkQB9SWq7
e4hKthH4aOSta4EA6lis/1TH1spO+opviMQrCfMlIHlmqIC6Bx9LlunODA4qay9K
nvE9uWUeWFQMLo5wCt+uzEODiBFcWU0eUSaDcViVf6uIoeZ6+FcGPqqaBYQtpm0n
cImJ8yAABVBdu5xYOeNAR7NEx8mJQWezluhhfXY3o9Myx80vWBFm/elJ5hFPwHBZ
telQ5a/G
=hd6Q
-----END PGP SIGNATURE-----

--mkTrhJmKhBV8cTCg--
