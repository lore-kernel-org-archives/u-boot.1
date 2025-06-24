Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DFAC71157
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E645A82DF2;
	Tue, 24 Jun 2025 15:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lQ5bmXH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968AD82DA1; Tue, 24 Jun 2025 15:55:36 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A74982C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4067106dd56so3545689b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750773333; x=1751378133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EYvedzHhxX/GF/+T/BXZi2wpjTABwNtU998KMB3QBVM=;
 b=lQ5bmXH5ti+UV3y8d6CvU20ouEg+DAFeKgXcfJ5Y/nNPQS39A0qAxcCRE7p1Sgcdq5
 0v5wnv04GiUXFjD6b1hWagIvQZZZP97/D0gu7MgmyVc6EvhxtaZdbAOVELUKPtGMaEwa
 LMICzckHPjq4IL6Tc4mt71Y+cPM266le+Nkns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773333; x=1751378133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYvedzHhxX/GF/+T/BXZi2wpjTABwNtU998KMB3QBVM=;
 b=HKjZAnfynPiRMPetnsKeGPgprqMnBE8YA/LyCurou72mmXxFS+rX5/iw++2etammHd
 mPgob7YB4Ho+YyVzielzNgx3FnRLSWwK4afdzR76FxVCpHQR0Rz80Yt5RmJPMQRWjvu0
 sKnN5TACAyK1BX7RQlte/qsuiZNcNsxl5n8+Ouxwun8SpwOe3kKPX2418SAlmmVo6No8
 adiGRlzKlaFfwFt3SZZKHuGfeNbU2WJpEns012sUV2ErzF3Ab5hAUIAAEd8M0Phe70nG
 EGRSwgyCFpKBDUAVtBchabD9J46/XofzbtjOKqqvohxvySncLeF37llHJBBf/HIlQOWg
 9CFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvj2oQf2oUmB5GyxZK+i1AWCRG6zz3BddUAH3KQhgUvaTXNqfpLiX/nZ8SqHP/+uU5qmwWtic=@lists.denx.de
X-Gm-Message-State: AOJu0YwuyRQqhfegk6U76KH3gv7x6gHN9SWLRwX4dsCZ0JZwWgMvg2Lu
 cSY/wIglBx7vP+1PfROMZS757s1It2xUZ1O6nEoddnjApsaCkJW7P/WKTxEvYjkUJiY=
X-Gm-Gg: ASbGncuDeT7LXyO5mzr+dqPZQJnCNYyIbADT63YsedCc/u4fYZJqQ099NDuU/YxnuwQ
 TBEFyZPTzfgTNjp2SV13b2xWO7HguD477D95vj7cUACLNa3hVfoK8k2NAjlzPOdzUutccy0gQDF
 AA0a2dx29JX2mYoEN4jQ3VeJIGLRHOPycdU/+9vWePIAULhtwH2jN6rd2omhKev8VLkNeaGfod4
 QSS0ZMOYTcFP1bXQb4tZXG5M9p5rY3hcTNayZR0VW/xnJ8OnC0gAyEAen1LKiHeFa4wx+pBQ4mU
 8K2pOPPSuRvrezKVdKH2PkDymqlFFiUW7lL715E1LTHNgXJ/iG/4n3rpRc/mX5jAMQ7UCnwi+42
 Qb+mK49AuZVgLr6keolaAUho=
X-Google-Smtp-Source: AGHT+IGU+5nrZ6fCCtwKmIY3MCLeXX2qj8OkBlZd4ejxLjjm0r1u+HkgHR9Jvk6gviaE+/XTCgBC6A==
X-Received: by 2002:a05:6808:3010:b0:401:e8b5:4e4a with SMTP id
 5614622812f47-40ac6fc914bmr11687082b6e.1.1750773333146; 
 Tue, 24 Jun 2025 06:55:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6c30ab2sm1832395b6e.12.2025.06.24.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 06:55:32 -0700 (PDT)
Date: Tue, 24 Jun 2025 07:55:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 George Chan <gchan9527@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom-next-23Jun-1
Message-ID: <20250624135530.GK4003484@bill-the-cat>
References: <20250623234640.126706-1-casey.connolly@linaro.org>
 <f45d2fed-eee2-42d9-a4d9-1adc49d8acaa@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DXnUwKRmaGkAugs5"
Content-Disposition: inline
In-Reply-To: <f45d2fed-eee2-42d9-a4d9-1adc49d8acaa@linaro.org>
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


--DXnUwKRmaGkAugs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:12:28PM +0200, Casey Connolly wrote:

> Hi Tom,
>=20
> Please could you drop ("78f177fcc2ed qcom_defconfig: Enable AUTOBOOT_KEYED
> support") from this PR when you apply it, it was picked by mistake. Sorry
> about that.

Yes, OK.

--=20
Tom

--DXnUwKRmaGkAugs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmharlIACgkQFHw5/5Y0
tyy3oAwApWTR+nnXdyaP+DJeY9Z2ZIaN2TRQLfn6a3vf0gRDB+ubsuH4ZSJMGBaL
aJDlYXDidm7LQZKYPf5qkcxEAKvn0kEB+jFTJCX+w7y3jwlQs769Ct1AIL+gk+TW
6Ry+cYY8S7wVfZRxFYWoTMhCQXrc6Q6jTF6Mi3P7k8UFKfbQUmtc+CUklZARp/3T
QiTMX0cUP0ktWPuSsE+sQCRvC4bXMncFmyqcW6QBK5h8JqufMpcirKdDhtMiGyTO
TLcMipQLRkQxDNMe/bCJjHlDODlfAPtNJjGXg95Lcn4yqPd3YULkLdsNlOY7+/1b
2gHQlkHAQyZGFC8U3geCYotX/mtjV8vbjaMKZ9sHxxBZ+6b3Zd4/PMl5oDIXNO7f
MgfAN+gwafLibYBOSI/6lLlGb35KH/3UOLRxTgPMgTkQ1QNehXmRb9ucTL7FBFkl
YDzd1foo5230eoufgEZ7fGWURV7fA60cptyemTFpN/33JLUbq/P8gRd8wbJtkaAn
6qF0LRfv
=z+O1
-----END PGP SIGNATURE-----

--DXnUwKRmaGkAugs5--
