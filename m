Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A607C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3DF81E1C;
	Fri, 14 Mar 2025 17:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1Imop3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D8A81E64; Fri, 14 Mar 2025 17:15:27 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A832781D0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso23751186d6.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741968923; x=1742573723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NcTc7U/3uRNF4t1rp0DN3sBibIAe72yFIo/CzTfNTw0=;
 b=Q1Imop3bfunk2y7t+hidyRHSra+L6XTouL8CEBijXv8fAQYo2iPMruIVT2abuXVuLm
 G/OdL6P6pcjrwWzk+4FVbBarX48dQsutCYV1koZRlX5tTflefDNFW9YGTomVp98JYDtL
 fIQqkYs2a3Hf0dbNkA5mmGjDmSdV9DbGMoVmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968923; x=1742573723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NcTc7U/3uRNF4t1rp0DN3sBibIAe72yFIo/CzTfNTw0=;
 b=FeoA4yxnFWOZoRsRLBHhbis/+8/HyuxC1HmZAj0ZLYmv7RlZe2ncLpNk9VlIC3oCf3
 hpaVkW2RHwSFE4EAJIWvpVYlPtBUStOU56xwuzHcuveyi1m3aJWBimgJba/3vMjs9rIx
 V4ke/kEAwU8xapIdi9jcVJh5+gsFkMD7bzfjqGykWGFCGzQPQCQcZcoldncnPkLSrlMS
 y4zSYuvS3XGmfX+XGr1fhdldOQbft+2CjG9LTEng819UZaWgE1pOKFj9KTX2AZT7TBlP
 VBAwMWjT8s+ZphZLouCCXXpbO+wPzKNXh8HtPWO1Kjm3Y/Tejw6Q/148RBHjmVWJckOM
 PFtw==
X-Gm-Message-State: AOJu0YxRIm9qzIhAojqkw6XoSG5gOimUhiRulgYoq9mTcxnOckOzaUhk
 YIJWLDGKTzyW0dbAo4Fq9051VDW6syFY29ecgabQkSnaHTSCogn56ETx/c5EB20=
X-Gm-Gg: ASbGncvgXLaYo2EpFVP88LRenvj684yNCMR52byyMyV/WRV3iyQNP/8A8oQq/9CrGLh
 qEUKXKB1coqtqvfGmQPKn2IT64ohxkQ1lVB6b7PwA+cLmN6rkc+ObKWfbkLC2HhkK2/AqywHZl2
 b77v3aToS5hYK5fmydR+Ikv318jY+o041nuRUh9EkbF5upnWLz10mrJABmZUtY8ZHob7SzNOTnJ
 zC+b/KDcF9p6Scz5AGsK+jVhtXRtEKHMPXGAgyLCOEVV6kq6ixlfqnKW3X6nknsexZf7V2jwdPi
 FQY4cD0WncLEk5QJKiCsJEmKepyIcjaV+ZBYWcdznNyFSQ==
X-Google-Smtp-Source: AGHT+IGOPmo14e7ZhMU2qX2U2EVJZ2zdgfoqMoJx+XvTDeCsJ63JtjvwLPMIuFVTCZRLteUOI/XtXg==
X-Received: by 2002:a05:6214:4b04:b0:6e4:5a38:dd0f with SMTP id
 6a1803df08f44-6eadded9961mr104055916d6.4.1741968922370; 
 Fri, 14 Mar 2025 09:15:22 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade235623sm26105016d6.27.2025.03.14.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:15:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:15:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 46/47] RFC: test/py: Deal with timeouts
Message-ID: <20250314161518.GT2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-47-sjg@chromium.org>
 <20250307142436.GM2640854@bill-the-cat>
 <CAFLszThxRPX8N8pnJfEkm60OJ3BxJx18YbbfVE_0janzmOdWvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8w8y7ZJgFPSZYZWh"
Content-Disposition: inline
In-Reply-To: <CAFLszThxRPX8N8pnJfEkm60OJ3BxJx18YbbfVE_0janzmOdWvQ@mail.gmail.com>
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


--8w8y7ZJgFPSZYZWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 02:44:00PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 7 Mar 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:04:13AM -0700, Simon Glass wrote:
> >
> > > The distro test takes a little longer to shut down and restart, so
> > > add more time to this operation.
> >
> > In the test, make use of u_boot_console.temporary_timeout(val) ?
>=20
> ensure_spawned() actually sets up the initial timeout, so I don't see
> how I can do this in the test. It is immediately overwritten by this
> function.

We use this in a number of other tests today, so it either doesn't
actually work anywhere and we luck out, or you need to look harder at
how your new test is written? It would would be good to know that it
doesn't actually work if that's the case..

--=20
Tom

--8w8y7ZJgFPSZYZWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUVhYACgkQFHw5/5Y0
tyybmwwAnCNVfMO4qc+DgoJt0NEXJgEaUlV2XOJ4JR740uPDpjAR0AR9QtujLrNd
QwlqG4PlcN9Y+yh6OlW3XnWq4gA93t8/E6JTFgSy58RCXURRpC1YjW2nJkwmMoEl
nq0UM0iMI/wWriOCPPeB+WCn1JKbpygOEoGDN0bBvj915v9gGjYIaxL4PEY2p6yA
TveNs3hLxseGdOo4IYEtuBgn1g4GWFy7a0iAl2GcA8goG1/bvtDuaVHTlJfLWw90
Y6EuZ4AOCUKOVwEld9lKaaQXx9vDb2zopVpkrgNu+VCCrstQ4GR4u9W5TwEySs5I
dMrBjt7nm7B5rPL4F8JGJN5as4M9tL0xr13HB5QwU6xqlqnFw7PudPtAXYMqkfeb
/ybpea/ePvTrOxbBHIE06xWM+YFoIjGq7RLpJs1C/1D69kcUWucnBhTu5qsFc3C/
cpkqM8aTLr+16x5uXSngZ4V98ALSR1OzMvJEFWTel0tuaOYaDiUDX6U+cYu/azh7
OsOSJt1T
=+m92
-----END PGP SIGNATURE-----

--8w8y7ZJgFPSZYZWh--
