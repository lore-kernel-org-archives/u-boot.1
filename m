Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2001C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBCF8834E;
	Tue, 14 May 2024 18:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L7us8GjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018DA882FA; Tue, 14 May 2024 18:15:27 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3A387CF8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-de462979e00so6197790276.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703323; x=1716308123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=phUwFPtnBsmBguY66erzeEqD2UNSFzDI6XconeW8E+4=;
 b=L7us8GjV5G49KkNGUwmG6qNTcLbUcx7T6RMM/qMdhpFhbhA5AGgOkoho5rr4IbwEtQ
 aRgZjzXkGC1Wby8QKa4Rp+DNjsoYkhOw79uC1WCPmvNgEAlorP+pojTbsE2gBwf1jy6R
 0Ir953UAwQz3+Asv5sHwTrSbjknWZXJxMkVk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703323; x=1716308123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phUwFPtnBsmBguY66erzeEqD2UNSFzDI6XconeW8E+4=;
 b=AwV+PCHz7gLPfcypw0atmOcfT2Ecl/2HF7ZP/IpzygmCHEzcDSdzgv4FNEbRE8Zw+Y
 YEMwfYAVRJC2HjssJ0N9DS5XR88ngHWSa/7R8jAUYQGRsBLO7zFxc176KNxpSuywPW+o
 riDEMiiwpmwD5PdRJSD3ROLu9UlDlGSZZ2e98nJYUCIp7OaKQgfm1KDCgosxp/oLMj9q
 fli7WJsKlrrrmXTcjUnPgDQUoeJ2OZMlB/A4eZM/B6xGlviWC0wTfBrgga/j40Carl/R
 jnVpM7iXCrMrFNYgWNauBkoZGvF9FT1Xl1Z85IHdrI3yry9JNOtldkLEoF+dWRnWFv+n
 z+5Q==
X-Gm-Message-State: AOJu0YwYit7EZ7bpsFWpxrxsu98CrSnSE22z+qiBBx8h3uaMO2q2UUc8
 ONfpB1Ebhs1Nqm3YvIUdpGxoUKwvJJNXGBim1MOH7CfGifkKD4k9qCbLgjY8y4o=
X-Google-Smtp-Source: AGHT+IEoO69kY1m86iIdf7/VLT3hNGelXrtD7hZmoAFlswf12unkx965mAKGVQTj/OsGIgnx3G5srQ==
X-Received: by 2002:a25:8746:0:b0:de6:aef:fc2e with SMTP id
 3f1490d57ef6-dee4f3aa085mr11446514276.41.1715703322588; 
 Tue, 14 May 2024 09:15:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194871sm54814366d6.59.2024.05.14.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:22 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Hoyes <peter.hoyes@arm.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com,
 neil.armstrong@linaro.org, sr@denx.de, michal.simek@amd.com,
 patrick.delaunay@foss.st.com, sjg@chromium.org,
 patrice.chotard@foss.st.com, quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v2 1/2] arm: Move sev() and wfe() definitions to common
 Arm header file
Message-ID: <20240514161518.GN2568172@bill-the-cat>
References: <20240501081633.120913-1-peter.hoyes@arm.com>
 <20240501081633.120913-2-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t7fGb7kHZ43JnHdR"
Content-Disposition: inline
In-Reply-To: <20240501081633.120913-2-peter.hoyes@arm.com>
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


--t7fGb7kHZ43JnHdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 09:16:32AM +0100, Peter Hoyes wrote:

> From: Peter Hoyes <Peter.Hoyes@arm.com>
>=20
> The sev() and wfe() asm macros are currently defined only for
> mach-exynos. As these are common Arm instructions, move them to the
> common asm/system.h header file, for both Armv7 and Armv8, so they
> can be used by other machines.
>=20
> wfe may theoretically trigger a context switch if an interrupt occurs
> so add a memory barrier to this call.
>=20
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> Reviewed-by: Andre Przywara<andre.przywara@arm.com>

Applied to u-boot/next, thanks!

--=20
Tom

--t7fGb7kHZ43JnHdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjhYACgkQFHw5/5Y0
tyyGBgv+IGHtZe3NNhylZHwMTjjm0YKFQGahkd8/t+mKAS6yF8JMpcdxIRTXbryG
oyixAQ3azukcED8zC1mRiVRriH65D9yjeVh1TVGTJRx+eLSoQvd6zrDHhgTbCrec
uFdRvVR2Uon0HfwLkEaWogUhxzVaLZu/TJE8zrmCl6EHoluVbuHehOGCIOylgcub
9efikScRGXfEpMk6bXhwmRLp097TztmRToFE8NW0VGb/3PtN14Vq/W0q9tUwG5HD
cYfFRVcnZr608njZuop9I+jXlcsCx4szWu0GH5LUggfDQuAt4Ei0nLgztxveSAMN
Vt9KG3GfABAUzfim9LWJ5opkcn/MATy6DzndQ1cxXeRrK00VWWp5K2rJuLctPhM5
oNwMYfxZfKgyJupMuG9U04TH14bhSYfEtL36D5uhqimhCA7ORWPQMNZXYJk1RFjo
hdOot9Jvw+TEt6S7yk2/F0XbhBhvoVWw30TC1yaMDRNsQERFDq7PtF80f7AwtcN+
ssXXCFk4
=te/c
-----END PGP SIGNATURE-----

--t7fGb7kHZ43JnHdR--
