Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBE2C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6568482119;
	Wed,  9 Apr 2025 00:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7ib8Vq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24148215E; Wed,  9 Apr 2025 00:29:25 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6EC82116
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d071fcd89bso334792fac.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744151362; x=1744756162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1u/E+KvJd3hAFoBMH4Z/5t1Op+Itj8RXoCAiZZ5ac6k=;
 b=s7ib8Vq+4tsaw9i/Vv/rhn8TaZQGEDwWL0JJPuQUZTGo33o7PYJT6CftSNrdo40/Wo
 e5IJrZFOjd3GSAhqG5BlqQ9alpm9ewzECHVc+KlJ1u6g2iQXumY2FJE/0J/2XUyyN0xp
 rY+r0vIQ97TsgaRI4HN9GAlW4toQ3MD8JlHbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744151362; x=1744756162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u/E+KvJd3hAFoBMH4Z/5t1Op+Itj8RXoCAiZZ5ac6k=;
 b=BtE8P+47JT8t2fGzXWbiq6EDLtVtDJil/R7MvAjaallbZhRQ/3rVhVul1/hg1LNHRk
 x0ma8sfekwS16RHO1Z96iS/eNLl8GbQ97A1nNd6JNPI4gnLhITeLqbItj+zb5Fp0gXyu
 Rfjkz/jWSv46TBEriIMIgLEQSrFgFLizMToBW6PCAGy/O42xOQ6PiEipegTFbluQsB/q
 UbgK6fQ9RtsIXFyvYoFg4E90nNmvQ0Ol73chve9ar3OlcL2lzdFxRCnuwCjzUC1plOzN
 8xL+EoREOOsmeTUGfADtolNA7+jmMRiXEWciAYW/UNknR7pmZedyBVojkyyEjag2m+JO
 r0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV60Rxh4CkaolTnWjCYN1SVyc6saYZ0FaejRlDgj1ZZIzUrRu23bffkMALRxRb6qMzL0aO5sNM=@lists.denx.de
X-Gm-Message-State: AOJu0YyQGw8GK/ol2yr9eRo5UNLIt5StiBD6FD94JWM4YFdYyJwGWb3L
 35W5KHGXb7KfPfYYDgymTWUZvHWOZ5GbARX26QTclOLOKSTebNKgaiyD5Jovzqs=
X-Gm-Gg: ASbGncuR4zeJ3lHSWESeisrqGP+uMxYMCKzfnQR+bc2UGrYjz8NkO6j9BqYQPhfzpFq
 P4H8JBL5IDGEIMkgAHfIONY1cgbLfNVWtc9uB4Qk5tz6ygPZ5ETv939P3NsvFm/bA6tHB76rKpc
 GWk7o6AwWr/c3Yuu7ZwuEcVl8To8rFUKJegDsF5dhR/Ql2kT+UZ3+ZS5QynUwYdfKfwSYy8cMvu
 xkHA5lTa9XYBDKvdDruhITY6vViOnYsx7o7TH8EmUMY4+JFpqlzWIiSNtAjVKNrCBur443f/hBY
 /lEb5PKCngKxhr3sAgdiDBR5S0Y+AQuNp8KdoNiHsvqnWyPVIG0NwfheU975mGy6kq6i8jPT6k3
 gBZMnxQ==
X-Google-Smtp-Source: AGHT+IEOcKDl1i5GPkV+qyiUwi1XzIOgUooQOcu30+mT6PsucwtbYoXFXZV2kVBzLlOzDbdTp3tkVA==
X-Received: by 2002:a05:6870:8dc4:b0:29e:7d35:2319 with SMTP id
 586e51a60fabf-2d08dce04b2mr498364fac.4.1744151362285; 
 Tue, 08 Apr 2025 15:29:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0930cf834sm15999fac.13.2025.04.08.15.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 15:29:21 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:29:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Message-ID: <20250408222918.GA1475540@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OvV2OI97qjGRFIRg"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-6-andre.przywara@arm.com>
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


--OvV2OI97qjGRFIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:00PM +0000, Andre Przywara wrote:

> The net_check_prereq() routine in the generic network handling code
> mixes case: labels with #ifdef's, which makes predicting fallthrough
> situations tricky. We had two "fall through" comments in the code, but
> at the wrong places.
>=20
> Remove one unneeded comment (no annotations necessary between just empty
> labels), and move one other instance to the right place (before any
> label sequence).
> This makes GCC's implicit fallthrough checker happy.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  net/net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/net.c b/net/net.c
> index 5219367e391..f191f16357c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1525,7 +1525,6 @@ static int net_check_prereq(enum proto_t protocol)
>  #if defined(CONFIG_CMD_NFS)
>  	case NFS:
>  #endif
> -		/* Fall through */
>  	case TFTPGET:
>  	case TFTPPUT:
>  		if (IS_ENABLED(CONFIG_IPV6) && use_ip6) {
> @@ -1539,11 +1538,11 @@ static int net_check_prereq(enum proto_t protocol)
>  			puts("*** ERROR: `serverip' not set\n");
>  			return 1;
>  		}
> +		fallthrough;
>  #if	defined(CONFIG_CMD_PING) || \
>  	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
>  common:
>  #endif
> -		/* Fall through */
> =20
>  	case NETCONS:
>  	case FASTBOOT_UDP:

So this one is harder than it looks. With clang, we cannot seemingly
have:
	fallthrough;
#if defined(CONFIG_CMD_PING) || \
    defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
common:
#endif

And gcc was failing on:
	}
#if defined(CONFIG_CMD_PING) || \
    defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
common:
#endif
	fallthrough;

Maybe we can move the label to inside the next set of cases, and then
also add CONFIG_CMD_PING6 to the checks, as that also has 'goto common;'

--=20
Tom

--OvV2OI97qjGRFIRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1ozsACgkQFHw5/5Y0
tyymIQv+NFXuvzq72OW1sY7T+cXBk85XlGdYtWdk+u/Nrsv6Dm/CP4x4Y4MHw/bz
9svksc64gW9C9TOiWl5986ViktKfTp0fP5PBijxGBOxoiHk+cJhvfGttafSUY1x7
oqGsl0UvEac29CNyPp+fFK5rANMVNkwbxghesh8Xqj8gRCEHWBMvK6THqIcnZWeq
XlUaPgzum4kkhxQF1Jl311i6mpwXi0+2g7N3z+IIY3DYg6nh+NgOOM8cnO3pQx+v
+2DmxmO8pCZJToSduLAgLNXVO3xnZqo8Nv7Q4nIRqG1kX7YX+yF00nwz/eiRlRd5
M77BRaKngs27WcEiFE7ilsVhB9N9n9NwupwN3ScxJI9NXg02FjZtRxuYop7r8jRW
BtXFYluZERP87B7WF0EXkMdxnhAKy7N8ACdOI1Q9vmhfKd15OACo9dCbDMT9rYzH
NSRNTJ/NPcVyTpEIHuOvB+/6PyeiIaMEvLHEmElau++9D0DdWV1O9nNookooBQbe
wEhqP7cV
=jZqK
-----END PGP SIGNATURE-----

--OvV2OI97qjGRFIRg--
