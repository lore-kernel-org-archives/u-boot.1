Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B5CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2387384979;
	Thu,  4 Jun 2026 18:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+dcQ1ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED45849A4; Thu,  4 Jun 2026 18:06:08 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BC2848D8
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b5dfde3cso482418a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780589165; x=1781193965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zmZs/0NbKdAbrHry9u8kI0LrNwl/NEl5fOtuFKWI8wM=;
 b=L+dcQ1tycbXqzHhvG4uZqqICRJfawh9Z0v+mZ93HBM7LXHnoAgCCF2SNyW/53hu7l2
 HLk7OU2xJAITpSWI+o/NDwWdiAm6C5VgevyEUqGRerdogNlUCVEb5J/IiL6O3++/Z45g
 fxzZwCFgiuz8jJf6CjQWxfL6HkzERrspn6Q/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589165; x=1781193965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmZs/0NbKdAbrHry9u8kI0LrNwl/NEl5fOtuFKWI8wM=;
 b=r4nRUIasQsdVcyNWRjqSubl59xQGErPJsx5dafQLKROvLO+qRMGtuUVQU40tLLjTDU
 1fTHDBZ1/8S6gDtORAM5UvQL+Cub9d1ZVKQm0NgGhfX/Qiu01iMqt5WL4Cknr4REpy8Y
 JD54xU/gGjbOB0XP6bqLfi3djgWayprHeTbKcpOLOkaM7rmbfXHcKxJaasrQZYL9/ONI
 H3m0+Hdbf/eOwZpEtL3mdNrQi56qvr6hnK6ntTTAQjbBID8Jfzzkhmo8+jpV+9yJGlWP
 nHVdV2taHYAFY3/yHvLevngPm3IgYjkg1oIe+T/r26EhBqMSu8JQN1ykRqwrznZg1W7U
 IlRQ==
X-Gm-Message-State: AOJu0YwnNXpoERdKY9oXx+em56Tt1j67IGDCzfPpj1Uw4IwywubBHpbJ
 vc5+QjdoX8HaBqNY7ZYClWpCZw8k/7u1qqyWRRxG9EoyWtytWHs+R6vRxT3J1VbzlAI=
X-Gm-Gg: Acq92OH3ibKrLCsJtUDsx5dn3v2ljtXH96kA1ddcQ2pmJcLW37ZCzvRRErb3AzgjyXe
 9HbR6WduBXF4YTrBw9Sa0qSiVOgj5jnrCFXxPkVp1RBX+mIYZJjw1ws/CbA1+9sXa9cRRTp3Wn0
 9Ep6Nm+rteVYwyThitEfWIW4MnxZ+bTWIRhap44gWQ0KoaH0dBVwZ9o5D03rcnCKG3InZLvf4Xy
 eGSCJciyY5rc7qfcm531/7wsK9cI+NDt2QcMYmjh1HihDkJ8otlDeQH/XDub2gvTgkHNtAzh103
 8ajaeh6a6zfYfzF2hhOqNNn2kAUfFsuCjFv5n+ag8W9F2F+RgobrkR5oO725phSxFbI6VzB1QAL
 oL3VlyZfD92AOkgoqxr/Zn2RO4r+Rw70BooR6qXX7dok2Wb7/q3YfP34qIzL712mUQbs8ySJ5/1
 SEmVW/m3kMfaFc1QTRXGc9xHpIahxof0RgnOWzFyiW7sC/bBmxtnxqN9EsqCIS0jt3kK+bJiTQ/
 y2ueR6bxkiVaE921PAwV7ugExaFRGCMSLMjNfaZJj9AU44BRYN7aZNWsVtILQ==
X-Received: by 2002:a05:6820:c95:b0:69d:f0e8:3226 with SMTP id
 006d021491bc7-69e47defc30mr5017702eaf.10.1780589164812; 
 Thu, 04 Jun 2026 09:06:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46450223sm3664510eaf.14.2026.06.04.09.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:06:04 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:06:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 2/7] pxe_utils: accept "options" as synonym for "append"
Message-ID: <20260604160601.GT627328@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-2-4ce6d1ee4711@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w85Qasm/PxtBVcWg"
Content-Disposition: inline
In-Reply-To: <20260604-bls-v1-2-4ce6d1ee4711@flipper.net>
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


--w85Qasm/PxtBVcWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 07:31:07PM +0400, Alexey Charkov wrote:

> The Boot Loader Specification [1] type #2 entry files use the keyword
> "options" for the kernel command line, which corresponds to extlinux's
> "append". Recognising it here lets the existing pxelinux parser ingest
> BLS entries unchanged, paving the way for a BLS bootmeth that reuses
> the parser instead of duplicating it.
>=20
> No effect on existing extlinux/pxelinux files: "options" is not a valid
> keyword in those formats, so it cannot collide with prior usage.
>=20
> [1] https://uapi-group.org/specifications/specs/boot_loader_specification/
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--w85Qasm/PxtBVcWg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiGiaQAKCRAr4qD1Cr/k
CnfgAQDNb2wu9UezmoRJlm2EHEAH0RQmdQtFCx+5EYjDiU6eTgD/aKadCkUps3cW
b4jZwEaXGAjVg1tBuSq+tBw9PRcDrwo=
=jEyu
-----END PGP SIGNATURE-----

--w85Qasm/PxtBVcWg--
