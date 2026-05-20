Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C72CCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 14:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661D7846F2;
	Wed, 20 May 2026 16:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FYxnqkaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD53E847F6; Wed, 20 May 2026 16:36:45 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6B844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7de46b8e432so4976795a34.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779287802; x=1779892602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sjR+hUA5XWCvwLLuZ7vIQnEYc8pAl0yaEBP85aiCEUE=;
 b=FYxnqkaSxSlRrbL3EDxEvBrOJcJP6UWFXrHxQOhxKWl+achsPyvQA5sRgxTAZzRSDT
 MImWmOxkASTEevRgxENRfSugyEg0JUA2a668KQc9XJMfEX2bCq/PJJyS826FYvnXMn/1
 sBL7VQy9Hz/DTRcSJKlq/FdAfUdac9u+FBsag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287802; x=1779892602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjR+hUA5XWCvwLLuZ7vIQnEYc8pAl0yaEBP85aiCEUE=;
 b=hkNQCoPbqT5tvbH9qAqjO9cYPDw99GofYgEsrNEbbSuUBXl0GyqG+k7McPSh2l93m6
 U2weXDaCeDHqrdR5j5ymtVYMLJ66nGFzmO2mJrRcK5zJYY/sZnszLclPlWIGuB1+m2ag
 KWFk4ZsV5PUdz/3CTgeRGr4BYprffj028EX2x/vMEO79Zu4rBrfsA4F8zYgAaiaCLL3x
 miFk7srsdH9wUpegunkLXetiZzOUpj1Cyz/SPDF8IuepHe4NsSPQgrXJcK50j5Jo/XJg
 pjmn0pEiF7R/qL39WQyyNud+/Ph9NF/2DOPiZyJCn8RPCHhWihGFsOV/iSephFzL/MCn
 fSGg==
X-Gm-Message-State: AOJu0YxqNsNd026OsHSldNEr7wDR4rGiUaAV/uOqEMJSg2VziUjxJwPO
 W/V+icLnjwd10AdJUAbmQXZBXJlV37R6geXDx6uiWRSyOf13rOFIVWEIOOwDyj80WRM=
X-Gm-Gg: Acq92OFVAgH8XWeeEqqPg/U87QNK+nFnxR7Ypv9M2mF7kqANFbjzkqHPwp1gUs5I4t8
 8wqzRM6GP8Et86JGEY5YqQjMBFfCpopMwl/+F29bxrMfiahYaSvyFjRcXl91rJrXMB6ruRzLKcJ
 cxRqxVkuPRDj66jXOdniXqSVHQYCGo1Hi5TIA6QPPIQe9iB7f56DGnoytx6sF5OSUF/wAsGUnea
 fAooOLHxMIhvQJ3jZQmw8NKFvdooOE0AdYUo5Zh9K7Evs/qruMxS4pqssovWBBYJInnvI/oMay3
 Oo498C8kY5751V2M2IqcJZwgZ2m+z36+M+DrZ2hjIPw0hi9tk+uGwOaHsYErmOc/JXMPMJUBdJ4
 FYKfl1njMU+Dj05uf9iDozcAh3p+lwB2jMYLLwIwWrXvMT+VMjkzVViSEFxAMLvDafAVYvm8cK2
 bg1Z3s00Tm2SIZlhf0Nq5uVMSeMHw9kGiI14Z2k/R69bKrG4+fHeJwtgRoiOMYqzDv3WyuXdWTq
 OW01NUb38NfIZDHZ6rrf1TnR+v4mNqwEmxO/ksEgW0B0IXEvbA=
X-Received: by 2002:a05:6830:3907:b0:7e4:163:49d9 with SMTP id
 46e09a7af769-7e4f2b9e0cfmr16503858a34.17.1779287801723; 
 Wed, 20 May 2026 07:36:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc111d6sm13029785a34.19.2026.05.20.07.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:36:41 -0700 (PDT)
Date: Wed, 20 May 2026 08:36:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, Vulnerability REsearch <vr@binarly.io>
Subject: Re: Multiple vulnerabilities in the U-Boot FIT image signature
 verification logic
Message-ID: <20260520143639.GM1858239@bill-the-cat>
References: <CAPWaX55jG=pc+SD09V_z4T5q8qBcetZ8OJeKnrDF6w7pQ=tr1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TNeI8XNncjX0DBR5"
Content-Disposition: inline
In-Reply-To: <CAPWaX55jG=pc+SD09V_z4T5q8qBcetZ8OJeKnrDF6w7pQ=tr1Q@mail.gmail.com>
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


--TNeI8XNncjX0DBR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:27:00PM +0100, Anton Ivanov wrote:

> Hello U-Boot maintainers,
>=20
> Binarly Research has identified several vulnerabilities affecting the
> U-Boot FIT image signature verification logic:
> [BRLY-2026-037] Null pointer dereference and potential stack buffer
> overflow in U-Boot during FIT image signature verification in
> `fdt_find_regions`
> [BRLY-2026-038] Stack buffer underflow in U-Boot during FIT image signatu=
re
> verification in `fdt_find_regions`
> [BRLY-2026-039] Denial of service in U-Boot during FIT image signature
> verification because of unchecked `size` value of `hashed-strings` proper=
ty
> [BRLY-2026-040] Denial of service in U-Boot during FIT image signature
> verification because of null pointer dereference in `fdt_find_regions`
> [BRLY-2026-041] Denial of service in U-Boot during FIT image signature
> verification because of unchecked properties of image external data
> [BRLY-2026-042] Unbounded recursion in `fdt_check_no_at` during FIT format
> validation
>=20
> The detailed reports are attached. Feel free to reach out if you have any
> further questions.

This sounds like what came in yesterday with:
https://lore.kernel.org/u-boot/0100019e40e72ac1-c3d57c2e-cac3-4f65-a98f-f1c=
6173c047d-000000@email.amazonses.com/

And so I'll repeat myself here.

First, the current stance of this project with respect to AI is, "please
don't" and is well explained over on
https://docs.postmarketos.org/policies-and-processes/development/ai-policy.=
html

Second, if you're going to use an AI tool anyhow, please read
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D36d49bba19f2c19c933d13b25dcf4eb607a030b3
and specifically the section titled "Responsible use of AI to find
bugs".

Finally, our normal patch submission process is documented at
https://docs.u-boot.org/en/latest/develop/sending_patches.html

Thanks.

--=20
Tom

--TNeI8XNncjX0DBR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCag3G9gAKCRAr4qD1Cr/k
CjOcAPoC2NluSaN9NqHbiDmlRykd0ltp9LNql0or8bdyICkMKQD/URgcQqYbx9Tg
zO0sXg28HweT/V93pFSlK7ZKfLC/TQ0=
=WrL+
-----END PGP SIGNATURE-----

--TNeI8XNncjX0DBR5--
