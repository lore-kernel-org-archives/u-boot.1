Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35978CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 02:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97318709F;
	Thu, 19 Oct 2023 04:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GDx4kWO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB8C870A1; Thu, 19 Oct 2023 04:32:59 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A5A387092
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 04:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7b3d33663so100513487b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697682776; x=1698287576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XXYAVoSUJkgDsMyWaFfVJAuGsXtdkhXA7B2tyGwvuC4=;
 b=GDx4kWO4b7Ild0WTZlTJsDGTqgX7gL+LwB7UA9TENSXuPQ7iIFCumVJFBR41Uu+Dr8
 otu0j6ML6GWv+cTL/5k119Rez16c8Jlp8e1vwbQHt4Sf+I349ow4GvYluB+ymD/+bfOJ
 uGV9USHogNtVrks+fqI85jS93s6MMLdNYHaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697682776; x=1698287576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXYAVoSUJkgDsMyWaFfVJAuGsXtdkhXA7B2tyGwvuC4=;
 b=HdlTiz2BlUFC1V8DpfQbdWDT2UhvLoL+iFZSk143GhfJiy9lBV3ylAiXo/+9Krf/Y+
 pFn6GJ7IbDnVHA+h/0eq+9S0gN0GTSetin751pMlGuNeIyILc8XwVd+Ijc5cyTygj1Va
 ttf8r9yC4FVl1MUkBk40NTDAFtVFZXFO/OlpvJh+KSKEYuogH9bj0ebs2lgGHOvGI1oF
 /+1xbR9H6lfAyPaaMxLUEVAllxjBShtDZcQufSuZzhy4z5NkVungDmxPIbUFQe+rvDpx
 fX5GTRPV7+pa2Gt1oUGFBt9quiSXGpLBHkabHKVV8sghDmB1BZ+dO1blif4wykkJrhUn
 oc9w==
X-Gm-Message-State: AOJu0Yz0VlG31D24507ne3NXUfPx6UHxHXD1f6XXNWSbcvAbsz5hOd+4
 AogwezltkVlQdATJ1leYqTpHLA==
X-Google-Smtp-Source: AGHT+IFy4TgN2zgxkIdRMu0SIOzffFiGUjNUMNluAB7yRCy6cOMG+vTG10IOx+X5qdSG2WdETgyDbQ==
X-Received: by 2002:a0d:d40e:0:b0:5a7:e462:84ef with SMTP id
 w14-20020a0dd40e000000b005a7e46284efmr1026715ywd.19.1697682775819; 
 Wed, 18 Oct 2023 19:32:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 j66-20020a816e45000000b005a7bf2aff15sm2078753ywc.95.2023.10.18.19.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 19:32:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:32:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
Message-ID: <20231019023253.GA1856856@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-33-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oEDyiVfai2KYNfE3"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-33-sjg@chromium.org>
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


--oEDyiVfai2KYNfE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:23PM -0600, Simon Glass wrote:

> Now that everything is working, add a test to make sure that this
> builds correctly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> Changes in v3:
> - Rebase on Tom's LONGHELP series
> - Correct 'of' typo
>=20
>  test/py/tests/test_sandbox_opts.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 test/py/tests/test_sandbox_opts.py

This is not doing the equivalent of:
make sandbox_config
sed -i -e 's/CONFIG_CMDLINE=3Dy/CONFIG_CMDLINE=3Dn/' .config
make oldconfig
make all

--=20
Tom

--oEDyiVfai2KYNfE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUwlVIACgkQFHw5/5Y0
tyzC9wwAhoXAgS9cTDFva68FgNOyh/yNi32dtuosKxWB8G3ECI4HX83Nk4CxA38d
9Q5WPLj25taXZ1ZYqAkqxIS9UGtNbAf+k9qKbdzb+7bRvu9C8LBqP5KUvYQ82rFm
p5CjwgCNvayBHMSHTzgV+jTp3Oqk+dcayk+KOqQ5wQYnLsSRqpg5ciQw0uKMxFpW
O+C0k8l/JyCkbTMU/wj83mW6PcHwC4ygWIFMT171MPfukGqVb43yAPLTSjQvlQXC
WFCZBSU+GIMQXQw2lDB/QCB7KIHQjhjCcqWGUiLya7ZqjHl3q5NzQ16S+E5/yiPH
IyrDFB9Fd4ry6N7jVWjkB7i6AtvPgBnAe/Lvb/nnXkooSZMlw86s7GleQMJFiaJc
3v0uBE475crbmdiZ7nwhvahruIidjIf+wkmlFgfnF4HU7DZ71EHVlK8DwDytA1lP
aZLxosdUDgGRsUBbv55uI77emOe8n6Cqqz/VCz1J/AeN+KQ4OnQKkngZx0IFPD2f
R9sKolvD
=uL4B
-----END PGP SIGNATURE-----

--oEDyiVfai2KYNfE3--
