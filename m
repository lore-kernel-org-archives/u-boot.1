Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143CDD16275
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792188911B;
	Mon, 14 Oct 2024 16:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W/hHZtPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92BA89121; Mon, 14 Oct 2024 16:19:51 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C9F88D75
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7afe994d519so428947585a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728915589; x=1729520389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u9yU4ir8W808DEUyfOjE33pG6PLOdAfoo5cVmCFlnrQ=;
 b=W/hHZtPokI9KYEzMSBbuKLXiG8fagF0rjD9CpEZ5eo7ma+UncWo4GlQMlw6fejjB+u
 hNe2Eit+RdTVft3AqZkzBkUYsRazRmORlt2qkZjaCzd1MotIzqOXZS0r3etDcPZcVheB
 9Z6GK99wFrQQ9ms2e79eL2jlKLILf8PbenTyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915589; x=1729520389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9yU4ir8W808DEUyfOjE33pG6PLOdAfoo5cVmCFlnrQ=;
 b=I+MLscEDO5sm6W6hYlvfvlJ47aMiIi0SxONcfxwtEircIyCXBJMe9WQ+gEQcWV5viy
 1t5T21xTJE4qf87dQcSSebvQWuvd2O0i1dvG4lPBakUvuaLYGlgSTsAyAK8nJmdtSVcr
 Et3exO3E8R/G9pfHI/2d3irTGBEovKzgl3k+Jo+uhki2s0L/kKrHKhsjUCd/D+ps/e2/
 m+gPUbklu12M4ndu827ZCcnk12ZLYNryCnqORdehnuIa2LEyrxW9prjWhDPBAOKfDmsc
 dUSMn4n9FJu9FsijwwnfFgytyhOAevsTy8ZW0dwyWTbHZzPfzUUp02DvKn4AAMXDy/UE
 TNuQ==
X-Gm-Message-State: AOJu0Yz/FT+huYxol/potCnVzgWePeWsCLoJEEf7Rd6dd8iS0yioAl8Z
 yjvpn8YstKX3sF1zAzLhJkarfzzsgnPaRzKvoz1LFDVoT0lCCfZtjXYN4ytw3F4=
X-Google-Smtp-Source: AGHT+IGDIAZSMeP5ZYdQ1sQyzzbOUPhsQwL3LrA/aZjPV1B6/iWMiuwtY7WO4fCl3oK4NJ0uxw6LQQ==
X-Received: by 2002:a05:6214:5c01:b0:6cb:22ea:5e07 with SMTP id
 6a1803df08f44-6cbf9d5e400mr147692306d6.30.1728915588632; 
 Mon, 14 Oct 2024 07:19:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe860b783sm45824316d6.83.2024.10.14.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:19:48 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:19:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v8 36/37] configs: Add RPI4 ACPI defconfig
Message-ID: <20241014141945.GI53053@bill-the-cat>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-37-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0W7sZwdDI1oYPN1B"
Content-Disposition: inline
In-Reply-To: <20241014131152.267405-37-patrick.rudolph@9elements.com>
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


--0W7sZwdDI1oYPN1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:10:52PM +0200, Patrick Rudolph wrote:

> Allows to build the RPi4 with ACPI enabled.
>=20
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=3D1 in config.txt
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0W7sZwdDI1oYPN1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNKIEACgkQFHw5/5Y0
tyz1uAv/V1Ocv0djXGVVyGaLBoDhO6uD5eq9K7TgEx8V8ecHeP5TCyOSBqvXQH4v
a5AGCAVZOmd1WwMqS7mtejHFPkbv16YFCXR/OTExWSnMXgvh8v3WylbDua5jqvN+
1rqY1dB79K+eAGemnzajBL1tKeTVUi4i+lPPE2fd0K/VVYLo5xrH9gUWidWBfxsD
mE3HdbRY1xUGsPwiU3pl8313GcduULF0Hsrkg+LSHYcQmNejFf+p1kFL+DDC3pPg
HuTnQvrRTvtOyii1MJIaVrMrotKj0aCx0QnTb1GfJ/W1bsFU/HDcvHlGee5ejCjC
5P9Z+1Hvu1fbX08GK8CEClDKfirTRNkhxkUjE9Ggsh2Oo5IW+IMTUyRxmGzxyet3
XOLXxqY2Czc12PBjaUMzpYPeHb9678JFVgv+1MLWBSkWpGHbFz9qm2nQD44RnCI9
LKY3E88vx7vAjFHTNN/w81em/YOP1FTEWW21sxeW2jqQwgRqounjO1RDWPBgl1GT
//ZAhIVo
=TDOF
-----END PGP SIGNATURE-----

--0W7sZwdDI1oYPN1B--
