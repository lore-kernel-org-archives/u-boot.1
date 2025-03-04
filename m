Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFBAC282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD56A801CF;
	Tue,  4 Mar 2025 17:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UCXZe1yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE55808A2; Tue,  4 Mar 2025 17:53:49 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6CD8004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so49713217b3.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107226; x=1741712026; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=srBmz/tlEttvask9Q3p8IdnNHJHVCH67ZA7vW5tWT5U=;
 b=UCXZe1yFxsMBE2KbqoykW0xgjH8Zm+e5YQS8IlrdXypIHCIHX0hrsyhYMiLhvIxk8c
 lWEVixsbaF9t4STPO7AvCPCFeG4kaRJHoU5xkWglHU8oNpPlqpNZw47h+UaWzB30YiPJ
 SN5pY7XfqdKmm3/f2vPikLWXt5zx0FzlsNmZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107226; x=1741712026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srBmz/tlEttvask9Q3p8IdnNHJHVCH67ZA7vW5tWT5U=;
 b=XA//l3I3JgqZrDFTIDj0SrPPZGTuISSQMnq0MZ87HSj/dS+XJz+N5IXSCGzYZkZ91G
 bI1MYeD1ueDKM85LO8u6ARrCnAFqEif72lJ3ruFHJaM3F9CQDsjGzceM5uGNmZrQsxIQ
 hd/PMpvjy/pX+h4UKTVJ2woZcHaMR0nJ4fVAgXAgv9GRSXlewr2dnH5PBsCudQVk7ZON
 27UUcemCwo/1pxZOWKxyrTTBDOV3pGvY91G3WZBVp462Ei9ojPAhEAl/42SckvTJtr9G
 +r37GjdYKcAJQrFywGl1x+34ndRaVU8XIG5BuCD4D2bMhEjKkF7ddES8tSY49it1PhXn
 I5WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMfgo6cy5NrTAdSGiB88KshHYB+bVEHUYn8YCBW+5tBFXV+/284nZswQh6uiENJ6TYVZrOwlY=@lists.denx.de
X-Gm-Message-State: AOJu0YxTt3LF/raWjkb5uTiFau/+9zTIBRjpdpo9YepvXlJ8TK5DSyrE
 zM8HSJYdgIYRXR5k8+KIkhCfAFhEx6xD7LgoBvj58VkhioAbYkwSEjN33acM6xekyjV3TiHiU4L
 q
X-Gm-Gg: ASbGnctPse72eLBHMW/N3/RG3xBnevtYy+9c1H0iv+cdIw6EL2G55FpfMwoA1mseoyg
 kxEOlcHAianIyUvrkW7wdFRzPelNrXaHgLsITMLLixwOs9JEXAEv/JKB2FKbISPyzHBmCkiiyrU
 mWtUaAMvQeX2O+h6bzvINSftAIBwiVk3wbU38IXftN9RTmCQRWR6F12W0Augt3tBck8cWbDWBI9
 BAfe7ZATN7VqsOsFSJY/AR/+oC02ABoGSoI2/DRuMk7LgBbN454oAw4GwBFD/TG7eHc80C0j3lT
 7l4Mnb4St8FlXoe7vuT4ZQ6hkZ1Iuf+TmeSfP1/m77o=
X-Google-Smtp-Source: AGHT+IFJK1IQ/DXimqZwU2gANOnfofmAxhIYt3f0OE+xRyANzynZALrWe7gA+XJ/tdyHujVQzK53gQ==
X-Received: by 2002:a05:690c:6f0c:b0:6f9:7b99:8a29 with SMTP id
 00721157ae682-6fd4a16c21dmr236069677b3.34.1741107226149; 
 Tue, 04 Mar 2025 08:53:46 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca6848fsm25409437b3.68.2025.03.04.08.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:53:45 -0800 (PST)
Date: Tue, 4 Mar 2025 10:53:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] vepxress64: add guide for running FVP with TF-A
Message-ID: <20250304165343.GE2640854@bill-the-cat>
References: <20250304165204.53097-1-harrison.mutai@arm.com>
 <20250304165204.53097-3-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WRsl0D96JKAveIag"
Content-Disposition: inline
In-Reply-To: <20250304165204.53097-3-harrison.mutai@arm.com>
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


--WRsl0D96JKAveIag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 04:52:02PM +0000, Harrison Mutai wrote:

> Add documentation on how to run FVP with U-Boot and TF-A. This helps
> users configure and run U-Boot correctly on Arm models.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--WRsl0D96JKAveIag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHMBcACgkQFHw5/5Y0
tyzPUwv+N+KJohXCoPEMj2S+jR160mLa4xa2Um1AllwWfpDaZh//uf6daO5GBQ8O
DcSINTy334sFPTuORkYnO+MQBDdYZWZSI+1uxDaJ1S985Klg8L4zkZVn5qzNgqtU
EE2vr6TBkEA0Ci+j32q4dj4aY8U1LVoOeoZIq7gJWdjJlJ4+SKJ2OxMr/5AbAGf7
Av1MP9ihPfyxUPnvgs9tBTPK+os2Te+dRoTTegZyIDXoj6yYgs9bEza8D8nYhdKr
ofnM2b0TlhHlwMx38yJrvYlG3BfnDWCo6rznL5Sul1L7U+IgsOASanIwhEHABjHe
Crng3+XkNgxskxXBP+oxgK0yE2LAxYkVlmRh6BNJFAsfE1+l3M6cAC03XhCVvsdD
Cnou3Ywab/nweFuMFlpPz9n8lDaZAOV893LfIbpB8Aa28Hm9iwUo3dt71A8K9IPa
At6jHsM0SnTdhsqIJWAcmwH0oomLAVdhLUAYddRVpqdVvH5Jb/ikUs3GHlDTwX6i
qljZVlVw
=5LH6
-----END PGP SIGNATURE-----

--WRsl0D96JKAveIag--
