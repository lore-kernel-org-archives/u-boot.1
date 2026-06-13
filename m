Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD93CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC0984894;
	Sat, 13 Jun 2026 20:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ixb3s0mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE03B84894; Sat, 13 Jun 2026 20:04:43 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0EA84874
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6e41cf7aeso1085368a34.0
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781373880; x=1781978680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rrm+LHmR9Y5UOrhfnk29GsJZd0bv32WZjHFx2bSN20k=;
 b=ixb3s0mDr4VVGheLWBSzA3/mDducs6xlcSz4k0OKb04K/aK0qJYnV/zmpRyDFmmMVB
 p4gvVxhasRz858oShbu5+9M5+hykVQejQ6ggSWdfde9carqN1cRVeIkpVAHL5W+8iaNF
 2qaiMVccKBwNUA8ynxtGHagAoDfBFRg2MOJW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373880; x=1781978680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rrm+LHmR9Y5UOrhfnk29GsJZd0bv32WZjHFx2bSN20k=;
 b=R99HYy58T3jHfXDv46608sbsD6Th9/R0BUl+yHouIyoK2HW6PYY6axYaOEZ0fYnvoT
 priCv2iLNl/mJUP1baaQsAH6Fixw2zAiU1OQ242g2AgwEluwJ2QU9b4lhyxmhTKSkJ02
 chMK8NyxmECAPclSmTZjN9rVvukkh3tBSoCatfT9DBGxKdgiHwXmWpwKwtFAMyPVVxgW
 mfC2AOUx8vEgpiuH0UtFrs57VblYHMo/k9+BNHJP0sz503VZh2xC5RGFV+4J+CAheNv1
 6m/9nxp3CWJOeAyA1G7sw+sIDs8t5uILv07NC1NzBwZHgIp39rYuu8i3d2HRN+BCj5q+
 fhXA==
X-Gm-Message-State: AOJu0Yzx7ECyggRUetJj/b+C3MmRMgp4M5UkO00mE5TE7aHw89hjde1s
 /EzK5V0n3MyCBaBCSEtWoW7v81ZPw6Vx0HGL7vUrcwmadRMkOO8dhtRBb/o2dAaeFBgivp9M8Aj
 pCc/0cGc=
X-Gm-Gg: Acq92OHdDOS8LbVRGWGUrzSlY7cR9T0jyHH32kKNPg7p0wk5iL1XyGh6mGFgFotJmSC
 5itB0k4CG1JCGSb3VDPcCPuEOTl2/+jhZJsAyo0FA2AK8Fk5INJK2czaW3lGUX3uPV7OexQ3K+G
 m9wycfp+8IPwGbzQEyR7mqp88vlmgoBOMAIkyHjE65+QBwGNV8+MN1HhGPJKy2zBs9jANZeEmU9
 03n/itGJa6PHxEhfsWL1443vA4EjAV4lRpAhxmLPhCnSpVAohjKdbIk830yCxl0hJYROXJbgmK2
 vXNVn2WZ3rkQprzo2miHbAGhgTTB4tTtfX5uFz01OFWB3Q75tlgSGui2zakrxdaTwFc9oHdKNnA
 F5xzwUGTL+OUxr1IiADoawlQS3aa4rOwgPbHEY+0B4O48DIK4EnWmb6hLecc+iiKRbTI0gBonpm
 ytuElM0TKQV+UMqKpkainj0TLLf9ZUROf9flwNYDS8/XPd1nVZJycDV10srMTqHhSPlNRE17Qj8
 2J+daUzbK+/BBvMtxAfCZGPyVzPjy0qInEgY9Ro5cQeCtM5LW9b6nwR3xk=
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr5332867a34.22.1781373880429; 
 Sat, 13 Jun 2026 11:04:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78177f40esm4693048a34.25.2026.06.13.11.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 11:04:39 -0700 (PDT)
Date: Sat, 13 Jun 2026 12:04:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, sjg@chromium.org, vr@binarly.io
Subject: Re: [PATCH v4] fdt: Check return value of fdt_get_name() calls
Message-ID: <20260613180437.GX382693@bill-the-cat>
References: <20260527111553.82161-1-anton@binarly.io>
 <20260602182752.59282-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="02a9pZ1ESkr8n6qw"
Content-Disposition: inline
In-Reply-To: <20260602182752.59282-1-anton@binarly.io>
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


--02a9pZ1ESkr8n6qw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 07:27:52PM +0100, Anton Ivanov wrote:

> fdt_get_name() can return NULL and set len to a negative error code.
> fdt_find_regions() does not check for this, leading to a potential NULL
> pointer dereference and a buffer out-of-bounds write during signature
> verification of an untrusted FIT. fdt_next_region(), fdt_check_full(),
> and display_fdt_by_regions() also lack validation.
>=20
> Add NULL checks and propagate the error code from fdt_get_name()
> to the caller.
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--02a9pZ1ESkr8n6qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCai2btQAKCRAr4qD1Cr/k
CkZAAQDTpXuadMfJiW4WjEQWLpmflunEqF8UwFdyUuEDMF6KCAEA1vLoCtQ09S8y
IIpGWMmnmnNqxuODzdiAgqKdLzT7uQs=
=jHk4
-----END PGP SIGNATURE-----

--02a9pZ1ESkr8n6qw--
