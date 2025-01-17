Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B087C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 21:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70D980423;
	Fri, 17 Jan 2025 22:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iZ4RuGQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C918069D; Fri, 17 Jan 2025 22:46:28 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23638036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 22:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6ddcff5a823so23022876d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 13:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737150385; x=1737755185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=maGyJADiu4kizlLNTKM6SDmZez9y8hR4o01avw+ihFA=;
 b=iZ4RuGQrPq4wn+jqvkozIfqXm0oNu+CICbG2qL7n5P+5qgUT0fCAwpCZHV7tCtznbG
 vuSqmC3tkMjrK2FdmgY09bJ4L7DJzLS68v13qbPcXrZHzvBYTUvmsBJcgFFDIhLhrUpY
 hl7Qhcf17Dvck1bElgO4sCu0LbDB5YhvBYfp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737150385; x=1737755185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maGyJADiu4kizlLNTKM6SDmZez9y8hR4o01avw+ihFA=;
 b=aB6+4/6tTyJ+H7xSOVXa0Bm7xwMmZhexYnqKoPT62ExJKpeqb5e4Zc05C1ceTjw8qe
 scp2uy5MddupwK9Kzs82cEUfN3PboArLZaQwfDT7mQt5eW1zeVrH6o0NSW+N+v2e4NRl
 hn8fIO4upO/kg/AKyEY1ahwGVigLLfSDCDBo4cW1TsMuSR/+/Fn1SZHmR5cjiftQmGR6
 Y1oQCYC0REiRuH+iTKXYFSuAyXVIcGi4tG5Tbjqa/4rkq9fBxu3oVpQCHOMx4VBMsuB+
 GtIqGpgo3tVCc7oCVFtrNSjwPszp+FHale6kSr3qMfw1eOE7/5aLIZ7j4/r5h+dDBPs6
 yHZg==
X-Gm-Message-State: AOJu0YxQhqxAlMQ7Tz3wfXnYvMFZIbMgVodFxcMQP7ql5zZ7ZlfxDJkU
 xgK+WOw6h6+RN3LLfv3yw2tZiQFxgWtgA8ghQr+leaJk/CKlwB6YJy9RzHnCbvM=
X-Gm-Gg: ASbGncvUQw/JjlVO85KeVBxTTtjKOuPug+ys+07Wt8o0+XV420uft+E2/Vt5zG1cBmO
 zieidnVG0ikR52pDRY+1UnBvFUZgTSgcX7T26S1ffb1C5YF819dLdez5UJBAToYnTsJ5KbADdNB
 6OPvED7JbeSR0A1LlaH/Y+Q7OgQ2l8oy+PTNjRDYKp7GnQs4/uhxjC0J9liR7leI+QdwTZaN1TB
 27FSdop2K17++uPysjwWoT+hBR0GV/eIYGUMi3eJx8sP8EmfscyNg==
X-Google-Smtp-Source: AGHT+IEPMXSEgZGR0R1I3KV+2Z4dyPsleQZkqrtruwzN8rgik4nFkSIRnRJYs8XMFvMZH5SLE1DXJw==
X-Received: by 2002:a05:6214:5782:b0:6d8:88cf:e690 with SMTP id
 6a1803df08f44-6e1b216ff3fmr68893826d6.3.1737150384761; 
 Fri, 17 Jan 2025 13:46:24 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc233ecsm15834156d6.57.2025.01.17.13.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:46:23 -0800 (PST)
Date: Fri, 17 Jan 2025 15:46:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v4 0/2] Static initcalls
Message-ID: <20250117214621.GA2503843@bill-the-cat>
References: <cover.1736174204.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PsgnB2PFqxL+pBEG"
Content-Disposition: inline
In-Reply-To: <cover.1736174204.git.jerome.forissier@linaro.org>
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


--PsgnB2PFqxL+pBEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 03:40:12PM +0100, Jerome Forissier wrote:

> This series replaces the dynamic initcalls (with function pointers) with
> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>=20
> Execution time doesn't seem to change noticeably. There is no impact on
> the SPL.

This fails in CI unfortunately:
https://source.denx.de/u-boot/u-boot/-/pipelines/24241

--=20
Tom

--PsgnB2PFqxL+pBEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeKz6IACgkQFHw5/5Y0
tywkFAv42P8KlCEoTpB+aWG2Dq94HJqt/5KNT2YbSPAIrBqzwiWTdr4YkFEdCbm9
T8BJEjkTNUFTLjF2vLJfGztEuT8NmKinAmgX/ATiKOQmq6JqffJs7u+tfXP2Z4hd
ZW8DUif8k4R55NA7oIP8lqOZpBhFDo9Dz7n2VnXGDjrh8XzlBY34QaY35XkPUeTL
B0zTNAF4lt0UjNYZQhd+9Q17GDFk9rmwzMx/3cPx4q0nhmZmh7UsPhpDmpF1qWFy
wOwBF8AygToVx0Y2p+1IblMcV9dka0roWdHPNl/Y3aR6gMCNclxwLzYzAg74xZfF
48TE/bYjNeciwDcIqNbCYh38CXINPoEh5QB+pESdpbWv8Qom5d+5z+82ef4xYLyO
30rKY0pjyAxB2GKhoZvzFFT2nEbBD8FzYy/hz/JdYFaj+NVGnFSJt5lrAQVXDfwA
3JR8nWoZ3PMvWwRQRYvkSZRPgcfnaU71f5XmFczrkjuqOe6Gm/XuUfvGiuCjr4H+
htMHCMY=
=AEsf
-----END PGP SIGNATURE-----

--PsgnB2PFqxL+pBEG--
