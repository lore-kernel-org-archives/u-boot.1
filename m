Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B9FEC1136
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E62883C39;
	Mon, 23 Feb 2026 21:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ig0PYyWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C8583C39; Mon, 23 Feb 2026 21:44:04 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E3583935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d4be94eeacso109307a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771879440; x=1772484240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zywsBUVcNnqjLcE1IruEzKo0kQUEBoT43q0s/Xl5Dr8=;
 b=Ig0PYyWjb2mscG+StymlOTbn+0IOPP78UYzmz+q8f7Yg6aTh/QEXU0Aal0jkvxdLmI
 hkUG+27tyMGN5ybDOnjgBP67311f1ISwd882RLnWvv7pucw+O3XnKZTGDY4ZAKcpIszq
 8kycmaM+PDy6NisyJjgRSKWDsn5RWnA0UfomY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879440; x=1772484240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zywsBUVcNnqjLcE1IruEzKo0kQUEBoT43q0s/Xl5Dr8=;
 b=t8ahKk4CUUZ1/k+arsjsFiLdmiVNsBn4NRQY1z7tZETP/b4MiVYltNEXslq+1vlPCw
 eGkr1WqhwGygz+IypXKM69osmTMTKvl//pnNVSCG345PluBUJc/HEN5cIhMl4h8XmOhV
 UA2YjfN8eIH0wpwvnrt2/ElOh8+r5ETwcf532LyuSfDWO6XTxlN+KASunZRG+0hAXKeD
 t9GZQ0DeivimtVnyHWNmWu5ryXZwMaE8sn161lAGsZaZSomyMj+7qs0TqBflwvPaiitX
 MgCR1l3YZN1yDifygPcjkO7ziOhT39fYjZWDgSoI132IXGma+5HiNa35ZUaYchmTIfRS
 SuRg==
X-Gm-Message-State: AOJu0YyMbn7/JotwjpzHhMo+r/lDnBupz4Hn7Fwhjijd7GHe6O3ekSSR
 CwNHADls5G/VNAxV0GC8a9AojBix5WpWBwmXBxb//BmKQ4p28XxHCJ6Le0Z2+aFORw0=
X-Gm-Gg: AZuq6aID9LLlELbVzW4w0FQMseo7rkRiJfL8EvqtxKWQMx6xspzFBAKOjwG74Dn4SqX
 U7/fEYXfSJWTUoP/XJuhsCQ++x8y5ddvXBVvAhgSbM8hd4KKfe03bvVaD5Z0zgIRaZdGIU/vmCl
 bf8QAsf9gFIuLmmqy76VKSPvXAzkmQSqC6y4L3pgz7k+d/ABljIK3pd1YB+EMew37j9ALy8x+5x
 IGcS98/rA7o40n/JInfBodtg2juqV6TCH/mR5+7sAJeYC/pfHdjJ4kDr9bCtE2n33yWRtRC1aZA
 qKPmZz5L9rPRh/tEkX0JG2GIOU16s+v5E8nSVRHNQgYF8pad0lvR4S1UoJP7Y+PXmpggiEsfM/p
 C3/K8B9S7WfbrMtgBxUyTWfYnDHX00iojeqbWeocdZEmIJ+S5rzzHrFdN4Z65ZLcQ35WxoDkvvv
 1AQHa6tIVCBqVCrwAXoyGcfxJOX840ESwas/S6IdxuE/k2A90KdFS+7RTWkgoxRFHtqQQqYzeuy
 B/JO99gTDqZllo7JSKDlHBHHl8VA/FCF4sc0/yEuTRpfTlkOLg=
X-Received: by 2002:a05:6830:638b:b0:7cf:d8c1:8e19 with SMTP id
 46e09a7af769-7d52bfbc5d5mr5620612a34.25.1771879440343; 
 Mon, 23 Feb 2026 12:44:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f42dsm7976551a34.9.2026.02.23.12.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:43:59 -0800 (PST)
Date: Mon, 23 Feb 2026 14:43:57 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH 1/1] boot: fit: validate FDT/DTO payload before
 fdt_open_into()
Message-ID: <20260223204357.GJ3233182@bill-the-cat>
References: <20260223204005.2705968-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3dYRlVyh1Mr7Kzfn"
Content-Disposition: inline
In-Reply-To: <20260223204005.2705968-1-james.hilliard1@gmail.com>
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


--3dYRlVyh1Mr7Kzfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 01:40:04PM -0700, James Hilliard wrote:

> boot_get_fdt_fit_into_buffer() calls fdt_open_into() for both the
> base FDT and overlay DTO blobs loaded from a FIT image.
>=20
> Those blobs come from FIT payload data. In the overlay path,
> fit_image_load() is called with FIT_LOAD_IGNORED, so the IH_TYPE_FLATDT
> header check in fit_image_load() is skipped. This leaves fdt_open_into()
> to consume header-derived offsets/sizes from unvalidated input.
>=20
> Validate the full blob against the payload length first with
> fdt_check_full(fdtsrcbuf, srclen), then proceed with fdt_totalsize() and
> fdt_open_into(). This fixes Coverity CID 644638 (TAINTED_SCALAR).
>=20
> Fixes: 5ebf0c55a23 ("image: fit: Apply overlays using aligned writable FD=
T copies")
> Link: https://lore.kernel.org/all/20260223195109.GG3233182@bill-the-cat/
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Thanks for such a quick response.

Addresses-Coverity-ID: 644638 (TAINTED_SCALAR)
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3dYRlVyh1Mr7Kzfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZy8DQAKCRAr4qD1Cr/k
CqWuAQDfr1IlTO1OdupFJwmj4iV8BfU/MZzU4P6Xpgx4J0t7ZQD+IQK8tX2phQK0
G5HnPBVqZDZOeI09FP5wk+M/JtiQKww=
=AvLQ
-----END PGP SIGNATURE-----

--3dYRlVyh1Mr7Kzfn--
