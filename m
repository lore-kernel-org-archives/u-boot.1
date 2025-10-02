Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21AFCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 20:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF9B8366F;
	Thu,  2 Oct 2025 22:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mdX0Facp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D1A83692; Thu,  2 Oct 2025 22:15:53 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896398366F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 22:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-92cebee95a8so62561339f.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759436150; x=1760040950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7rJs1s8FXEY0N6s0ahbTBwLXxMwqr34DavxzYVa8kjo=;
 b=mdX0FacpMvWUGbYxF5O3bahCpNE++To9E0gpmm3w5hLDd/7eaJ6uebl7Utc6VyPyhO
 RK6rMKU/7Q+s0V7sRUH/1LNHKtBioVOqPiJSK2TpjgV2YhNmxDPvdOC81Ie+gena9XAA
 CRHk/A7oFNzGWXC0eTc+h/RRWK6edIvYsSVGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436150; x=1760040950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rJs1s8FXEY0N6s0ahbTBwLXxMwqr34DavxzYVa8kjo=;
 b=iMFCut0m3MOqxgNPemrogfgzxk/Zp6G0+/TQoeA2MPe9eaqgzBXj24fkB2FsaJAA5v
 KRPUT504E9TKCcTvXH3cDSQQEMByD2SXMS5ezXpp8LkzgV78Lb97wjAXrEwLQsETbgCZ
 vUITEsV7X+YoUS2aw3j4VHAzo29l5D5cVDKXTatJZ0CaKoZVIkwFjGJfFLq6x0y3DXLY
 MwJ/HW3aHFMP5aLzv6C2Lddq/mPzN950f2KLkm8OrqJztUQsGFCm+ghAgtKJywxPVtEp
 9vM8Lj74XjOJJ2kZlSJuEgTlMdEPdMzMz2kpyKpi1nozfK1w9IskTm45TMMWPyNoW2iW
 n/Bw==
X-Gm-Message-State: AOJu0YyLqVfSR9pduGacB/TpxJlZRYTwZvvVqMvKhe3yL3Z4oWpEgJCT
 FbvlO1faLmfuFbLlvWB96GjPygvE3GGSMBybrBIR5Kl3xDqODWx+jhxydX3qdHYzwOaV+f6wRrx
 RI8yn4Hc=
X-Gm-Gg: ASbGnctRaf+xs1CXaEhDynWR3M9XK+KKOxQw7/BBR4Z8vHhVXubCmtrljK1OLiEdkbM
 yR9fIhaDblcmEUFbWRPTyPoe6up2FC1W1vkLT0CfEEZYoEKViX9vAF8TCFvXgMIa7nOqaSNaZiy
 993cH4d6CfTQLG0MxCSHHB+AjTLlvTwwgHZ5UQrk95jHJjWN4dHgJT7Ww+JoyHaJZNErvqIq/4U
 12N9H6jdkMJbJTW1VMW8oPSCK5ZnUw68XzQfnK0M+lJ9+6FM9TExbV6fw54vbq2tpns6blUi7sd
 dyYQ1THUljw4ctU00PhKZS/9A/9nN1YmwMdp+EeTZHexXRDOOOmiKaL4rZ+CDmfewAn7GUa+v4N
 nuwTEkuYuvtb+FbyZrTzPPeEnd6Zv0wk6Z54xqahGlCgzXUmTvVXuFP4qEVURUrRp6dw2Dktan6
 9H7yVmDE3UXg==
X-Google-Smtp-Source: AGHT+IG5f2uSw9TGPoLD2UntQ+YwbGtfH/A4x+qBLgn7TR5MTomSRyxVAEJFmN0s1n7Jvcf8OVl/4A==
X-Received: by 2002:a92:c269:0:b0:425:70b9:243c with SMTP id
 e9e14a558f8ab-42e7ad2fdc9mr8016325ab.14.1759436150161; 
 Thu, 02 Oct 2025 13:15:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b294e65sm13063405ab.30.2025.10.02.13.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 13:15:49 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:15:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 16/17] boot: Run the EFI bootmgr just before network
 devices
Message-ID: <20251002201546.GP6093@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s7vHGnlzmnYYPvzZ"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-17-sjg@chromium.org>
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


--s7vHGnlzmnYYPvzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:41PM -0600, Simon Glass wrote:

> At present the EFI bootmgr scans all devices in the system before
> deciding which one to boot. Ideally it would use the bootstd iterator
> for this, but in the meantime, give it a lower priority, so it runs
> just before the network devices.
>=20
> Note that if there are no hunted network devices hunted, then it will
> run at the end, after all bootdevs are exhausted. In other words, it
> will always run.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This does not apply cleanly to master nor next as the test portion
fails to apply.

--=20
Tom

--s7vHGnlzmnYYPvzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN7dcgAKCRAr4qD1Cr/k
CqKEAP9iZrtLwDTwuL5I1UAZvGsENtQhNKCsSzXRjclHpJ+T7AEAq04ci3U75ILc
thbzNfBDo15SC1FeZ3YAzl98hV8CTgA=
=fqKN
-----END PGP SIGNATURE-----

--s7vHGnlzmnYYPvzZ--
