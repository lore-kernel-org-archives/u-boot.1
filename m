Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD8CE77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 18:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7243A807DA;
	Tue, 24 Dec 2024 19:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAAr18LT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6F5807DD; Tue, 24 Dec 2024 19:08:08 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4167F807A7
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 19:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so47149361cf.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735063682; x=1735668482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fH8Iuqxyl8TnD456K0nAN3YVsd4h9vRApcomqkE/VII=;
 b=XAAr18LTNUOVJVoh3xKClGG6i1s0c0aRTWuAXoyS1mmD/96PZkQMS/mc2MKE1pHRKQ
 dnMlOfSjaOoDmA+pVZ6uMYMxNQ+qE+p7z4lRHgHsBn5Zax8bCzVN3qlshzyhcRQzMcpD
 tk9CtoaI2d5iCJtNrcUaa8o7jbCQA6+z6j0zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735063682; x=1735668482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH8Iuqxyl8TnD456K0nAN3YVsd4h9vRApcomqkE/VII=;
 b=Qc1OmsYY4Uhh/JXbc4v6rMovjRN7IFvOnvJmSw9yRTIDOXFeCvDFKM+uCEsCn5uoJx
 BaJxejhAr6tAvO4RTzhsNUKuFV5Picr+G7rSrIzP0/ZhOlv4N84/calUOZrYfnE5KpeG
 ixCiJb1bTVxxXfXEI6aOhnHB1thy4v5WqOLU/FJwPaBZ7F1TF+CNTTBzWc1YKovFtvNA
 WIrE6V034CJhRFmq5BjmldMSgkQyNlPp6yCEwRn7IsRlOsfLzE8z3Z0M+nTRMKrUCFhE
 kZRGgJRFIUz7/xNOuKWVzklHvzSW9nssYGHOG9JRCfM/yGhnS2Rr3xoRaAZAs3rsvLIL
 8jXQ==
X-Gm-Message-State: AOJu0Yy5IRNIZwseiA1aVP0OeeoqoEgZ9w21dZ9uueF4EP+KT0DDhUI+
 FgXVK53awLtRwz8kyBjUK2Gjnhm4Kjj2SeOG6KXWT6zqhbBs7hc7f0Jj8qAIALw=
X-Gm-Gg: ASbGnctqwxIeJ3Odf7CAQtIWSucv7u9iHvOHJ6OFzgee9r8/xOVpqcO8tT0Iu5R3rfr
 M4+Z+3g2Kc7ClL2t55eK6BaQllzv4WmpYMPeWcqEfiGGpO7lPRZ1Pv2arsldHtVMQTzKRcN/8v7
 WCtYfyA82LW7M8oMbof10cMiiFaMxpcosnnimwldht95euFjilYgVLnSN1gW+7LIDBhVzAuJq+j
 X3ET76au44VQbuBfq6P3otS6JjtZ5K1yg1U9DS2ZMQAT23TC9f0LxCCUA==
X-Google-Smtp-Source: AGHT+IFLP+8vQWJsO1l6W92K4MgktDYMwmtx8BOMcWOqP49AOijHdiYLxfMnY7+QQ3zN8wvnya+vcA==
X-Received: by 2002:a05:622a:1802:b0:467:7b65:383 with SMTP id
 d75a77b69052e-46a4a970364mr320940791cf.35.1735063682081; 
 Tue, 24 Dec 2024 10:08:02 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb2b550sm55226221cf.81.2024.12.24.10.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 10:08:01 -0800 (PST)
Date: Tue, 24 Dec 2024 12:07:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: DT subtree sync for v6.12
Message-ID: <20241224180758.GW1505244@bill-the-cat>
References: <CAFA6WYMvXXi19tjxhi-N4D3-tbVkbJQeUHwzuC5FME6vzPir=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ziT6ZFk5/fSXVTDl"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMvXXi19tjxhi-N4D3-tbVkbJQeUHwzuC5FME6vzPir=Q@mail.gmail.com>
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


--ziT6ZFk5/fSXVTDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 12:54:22PM +0530, Sumit Garg wrote:

> Hi Tom,
>=20
> Do you plan to perform DT subtree sync for v6.12 which seems to be due
> for some time now?

Yes, thanks, I'll see how that goes shortly.

--=20
Tom

--ziT6ZFk5/fSXVTDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdq+HIACgkQFHw5/5Y0
tywqxQwAkvOz1eZaGCXkOqTToYdS/CfgX0z8SFv3cAq1DaWIO9DKD0CidPKekTjG
fW65OGtvch1z/KFAHj+1ogjBNQVWzBvHxeNgxXiZr9DQrQkAogUWyLsqx0jyeEU/
0urfh1tdZQBzqYeLyBlFmLQLYLfVzOvdwj+HHiJ+A7zvcthuJBJbt6NbVVrBWUO6
H6dV09HCHYjR7BviZqkFBIT35CqsVRT/0+2XLETb7x9CjkxmeTKZH6EClaYQy069
F5RQ7ab6y665H5eSv2ok3udt8lx8L9tM7gpqyPC5SdVoPXHgc2jSKDuCVXenmVE3
uaCe0oGrN8gXxgizjqfe0xOBSBSBem/g80Hp3LAhDBL4dlgXpVPOQexi7zSNMZOf
9Txa8mt2cUdb/EXWJu3NiG/ZeKXeGuOcq4+lLgBmuhOlxI/4aHiK/KhQgcl6RR6d
SFs9NEHOaETu0V1BrCy7HP1r/VzW/tBvbgXdqcgq5g28u73l7Tx4bU8ydDIxlgLO
pvao0wNQ
=b9UW
-----END PGP SIGNATURE-----

--ziT6ZFk5/fSXVTDl--
