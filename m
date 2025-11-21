Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6912BCFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA36583959;
	Fri, 21 Nov 2025 15:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uklun7fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DA683966; Fri, 21 Nov 2025 15:26:38 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842C38388D
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e898ba2a03so1368046fac.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735195; x=1764339995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0W4rym8uNVpuka4kosK2ooLTwuz8W5u2V+n2vEtRCDg=;
 b=uklun7fA5ClQiPAXxj6ozfvthM8zNmsqnZ0Mjfru2uuKkjHaSgdtHFL6fMcrv4yUfV
 uj2bCPb20iLor9UZYnx/DHTv624PudSap3vFdS98dViE3PDpU54Tat/e1FFEVRlMWE6S
 DBV4faAKR0Zv9oRY5NS+rv81Ra1/wtwprPBsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735195; x=1764339995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0W4rym8uNVpuka4kosK2ooLTwuz8W5u2V+n2vEtRCDg=;
 b=uZpNuzrr+8annDKx4iqSYi96UNd+dKIKtKOQJU0KlBRZ25FGJWIcyhyt3DAIsWlDfI
 3cBarkWuoHKkDcKuwQk20H1PXqREkg+cMr5DYZGXqW1CC/twcwOOCfjpJGR7Yy8UEF4Q
 Wm7D3MZFxr764PK9j2JLCz7xjbXdxi0qI9KTfmbaNSif++1kc/tBI1dvPH2vNqjIyxaM
 9woVu9QNBo5Eo3ccHFXOzXxk0oNuE/XCnjaxHuVZKHh7Wyas/jnkRhzUfr/wr+jHgpPD
 WMI0KAnbI0oNmt1HCRFOaK06m7AtHpSHVyvfWd3SVSs20xQno5U6T6IPnrBZ4leJWRZ/
 lCGg==
X-Gm-Message-State: AOJu0YxOLNN4z8P9u30KxMdR66KCxgSDgpAqsbYWxCpM1HWfFNIpvshU
 gKry6yQXqSzMdk4NMNoXz6ZSnFAaoxzMjZTIbteUCLPmDcTiEv3fQ2b6ejbv9H+Ppk8=
X-Gm-Gg: ASbGncteYtnEw/uWfuKeWxtxG2Rigi+rAgTDvAOUq2XTZp0K8awtR/wzo6qPFDRH3+W
 Tsn4DhseK0BxWn+K9wI5qnc7yaVgf0EPVZVHKqthE0fRVkzBYhGfDjmoMlLGEi3NmYiSh93171R
 P6FVSKUsM7UQF+l+PxZsgXikdzXIh14BX7hjqiORqsCTIawSg4toidMrmW6ptgieoo3FrK8uORx
 YqaRbGMhOQiucbVh3lf2SQG6/p5ky4/AbSKBneucCZe6wN8jhcjowYve3gmOEoBfl9dGuhXJ2R+
 JevCB7+oJ1MW/Pp1mJQWyfh8yziUQ5qPuhtx3cGki1tEqN2eAIcmbaugyBz7CTG7XyMS4h0g4AG
 qlW1ICKedLhlL97MDX2i9e75b8cuRjhvIgHPAHZEMjiboWqM3lNTDupV7WtyRsYuODg1FOULX4A
 vRD/5Lbm7VuHy7UFk9bT6wSDnbmCPE1YNKyh/eV16SHpptgfTdyA==
X-Google-Smtp-Source: AGHT+IGoeoDwzppAjtgC+k8J7kpOGv0XdrHFDfJm1uhGAfPjIKC70rGjsoLivlTzlGkt+xZVt/bbKg==
X-Received: by 2002:a05:6808:6f97:b0:441:8f74:fc1 with SMTP id
 5614622812f47-45112d7bd92mr945880b6e.62.1763735195247; 
 Fri, 21 Nov 2025 06:26:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c2d0e96sm2695251fac.2.2025.11.21.06.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:26:34 -0800 (PST)
Date: Fri, 21 Nov 2025 08:26:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 1/3] CI: use GNU mirror for grub (and switch to HTTPS)
Message-ID: <20251121142632.GT2125796@bill-the-cat>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
 <20251121-gnu-mirror-v1-1-548e6cd2665e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d6QCFfEkhm0BHanb"
Content-Disposition: inline
In-Reply-To: <20251121-gnu-mirror-v1-1-548e6cd2665e@cherry.de>
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


--d6QCFfEkhm0BHanb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 02:22:14PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> GNU announced they activated mirrors for git servers[1] in May this
> year.
>=20
> The main git server keeps being very unreliable and switching to those
> mirrors seems to improve reliability (albeit somewhat slow).
>=20
> Yes, the URL in this patch has nothing in common with the URL in the
> linked mail, it was extracted from the Clone section in the mirrored
> cgit page[2].
>=20
> While at it, switch to the HTTPS clone which is "more secure" than git
> protocol.
>=20
> [1] https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.ht=
ml
> [2] https://cgit.git.savannah.gnu.org/cgit/grub.git/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--d6QCFfEkhm0BHanb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB2mAAKCRAr4qD1Cr/k
Cr08AQDYEdJFvgmYqC+gi6987RzE4MrbvW0vcbbDlDHJ0gYhPQEA0R5+JGgJe1RM
kHMMgUk1d0lDtTjX7x35kTAzMjwFoAY=
=RPzp
-----END PGP SIGNATURE-----

--d6QCFfEkhm0BHanb--
