Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBE7C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 21:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BE883438;
	Thu, 17 Jul 2025 23:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ivV7k38W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9A083479; Thu, 17 Jul 2025 23:27:09 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84244833FC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 23:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73e82d2ea1dso130042a34.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752787626; x=1753392426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AvxW9AwRno0IK7fNCZROanOonsUTRlGnEFxV7ICk0JQ=;
 b=ivV7k38WCrcAjOVN3W0zo9byOoCojWZHQqGNSu18zXMhgkq+gWLuw5I4K7S7UYSpkS
 yPkLhkHmddVY7LAyXUFDaxRPl8uEZ0DE3TW/QrK3a2yv4HPIZCT5YDUwBancI/PBvdsw
 qTNbFvZXv/lEurSt+8Q38pE3Vky+qoBj5IzZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752787626; x=1753392426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvxW9AwRno0IK7fNCZROanOonsUTRlGnEFxV7ICk0JQ=;
 b=ci2OmNUfJ9ZgPiS+B1icr5WtiG0KWfoIAygz3C27/O4dkDvAbn0yvnJ+aYuxvb+A7r
 RpL5Gu2r4Ws8DKCGOfRtxT4BU3qQ6hSIKA2lNqHFfL3ZVUOrtVc1rO0dgZYeT9JKVm1M
 lPlHR68IUSFUYraW9EeyXidogSQEIWJfiQr5eBDogiMvrudZtx4MqTFVTYzRNfq+Kj2D
 Z60CxAlaw9/wYKPw/gBm9VBaqkHUGS8nseXethJkfFBZ/Ba996m4qK5yN9R5T6wmrJIt
 m2RQupl+Oq3xWE4Act3twuHyl5LslVvZpQWWKZF6AJTdhDjC+iOM45nRqaU48glDR4iS
 rNSQ==
X-Gm-Message-State: AOJu0YyfYDgXoaDTTEAksGexAn09q1iTvUo3akR4haEf7V0cAaaujrbD
 CiJ3othWDvsFY077py2/ldjKLYjyFxHcEg5doum1AIBh64QMxURaNYcaaokPmbJ8XDc=
X-Gm-Gg: ASbGncuR8XcbZuBlBAai9X9q2grcQZqxaBqsHQCPDIpZBcXwscGc5M/mI+7dqc4jyyu
 c8wnDjyi89drP91mVHM/mZp9FspynmR7A9FgOzvnGybwXmhgwDdhBZe/mE2PzHfHMuKQtDOeJvy
 JnPF5Kiivo9bG5rqlLmjw5MoBlO2i/e0GKk8QUDVefbQOuPbzBzUl0PVtFDd55FBLlpXyeXOnH5
 RfjCsr8DADDzLXNLzwnfDx0xpMhAnDN0B7LQNVIH0zw7y1X8LmkkwO73nssKpU6GdHTCxykxCNY
 +fyeX8wpnW7Xk37EaXlKx6e/A58EDHyQbUMkLCN3t2Rv0RnY5mHTghEnt9muC6OAJPW29rWKVuY
 EHvK+nE090NBbjVaqD9TUfSzB4Vh93HWeD3jMPU016ap4jaQf68Vr5js4
X-Google-Smtp-Source: AGHT+IHgF3piIPVahJ2KH7AnTE8RfbusYjAElm1oHFgR4eS61HIKDWsAaDIM2JAO15Ub7P0BkwwvLw==
X-Received: by 2002:a05:6830:6110:b0:73c:976b:6c93 with SMTP id
 46e09a7af769-73e661bfb32mr8903779a34.21.1752787626152; 
 Thu, 17 Jul 2025 14:27:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83623107sm108140a34.18.2025.07.17.14.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 14:27:05 -0700 (PDT)
Date: Thu, 17 Jul 2025 15:27:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Casey Connolly <casey.connolly@linaro.org>,
 Sam Day <me@samcday.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] sysreset: psci: Fix SPL dependency
Message-ID: <20250717212703.GS193579@bill-the-cat>
References: <9233da992c6bdc0b77e63631da18178ec9d64a99.1752741690.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rn8QS0Up35ISDrvt"
Content-Disposition: inline
In-Reply-To: <9233da992c6bdc0b77e63631da18178ec9d64a99.1752741690.git.michal.simek@amd.com>
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


--Rn8QS0Up35ISDrvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:41:32AM +0200, Michal Simek wrote:

> SYSRESET_PSCI should select SPL_ARM_PSCI_FW only when SPL_SYSRESET is
> enabled/required. This change saves 1.6kB on Xilinx ZynqMP Kria platform.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Rn8QS0Up35ISDrvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5aqMACgkQFHw5/5Y0
tyzyPgv8C1AExRSBv1qsXKfjPZZhmuaDx89Bour2zR5i309TT9wyDiQROsQ5ucyF
WM5a/9MT8WpJAgTODPyggK9jmkcmVHJh6+3x+pCQ29/FNkBFhMCfXexN62CLpIi+
IDo62Nfi6+2Yi6GgRyNoPNbrtHIi9O3JNtNFRhBldGsZG7+yClePUnAuU75QcF5d
eNQPKlI9aTU7Y6tEJSIGhuS6sMGsCGIFVXItMAKS1hjmDdvYK3O+qvDojH8CGbey
yV/nbzgu98nrJKokP8hP1/aCvDQ7PEUE1IIGZ1AQbMVAmtz2vgXEntKr8IgdKGsB
F1h9Sk2uQ+OLirM5c9dhN/nwId5OHTx1FJiuLAnka32Ab53NRayAFF6PpcTyQit9
gQexGMRUMXhpdsfnPW9OhZ59uhTj2Tkv3U4pspdXR8RyvNL9Up64t5k5ifAeho/Y
vkr0EOv3jLixco4n0PD6OMiIwZ/KzgLwDgypc8BSI3RZdkHuzc3gQXGlml8jWjXs
xuV+cI5c
=8/tN
-----END PGP SIGNATURE-----

--Rn8QS0Up35ISDrvt--
