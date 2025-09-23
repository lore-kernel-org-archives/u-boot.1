Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17413CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436DF8341C;
	Tue, 23 Sep 2025 15:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WLq5+FJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A8383448; Tue, 23 Sep 2025 15:37:25 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238D480C93
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-425715aeccdso14461575ab.2
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758634642; x=1759239442; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SF1tEhbiho/prbZMMivq3xQAIPzLqcNN9M2bmanO6bU=;
 b=WLq5+FJ6mB1FVVOGv394R7lryu1BC2+7dSWckNqz+ObkmcQdm5FsNgplKYWKyr0Khp
 m1Pqi7WhQQI7ZQKZwXWlzrGuSt/yLindmLGcBLmIudUXAlye+ocjMeXMgmh5J52GGqUm
 YuF+xxnmLNJ1ElhdFet97wmwv8ExeXwSlcqV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758634642; x=1759239442;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SF1tEhbiho/prbZMMivq3xQAIPzLqcNN9M2bmanO6bU=;
 b=MF9CY/Z38+YJRxfS+mkgAOHXVwIrd1qhLC8U4mcIUkxfGeYHb7gp0JFVWEtWOJHD6e
 jjxukoIGjloAzLjJG/zYcOM6zDmzHJpUVeSYvYQcENe0mmAiE9K3s59rtLVDNnO/m2pQ
 HcMNLAgunHCCKN5PaEcxq5tEfN2WFklBHQ7a0kovrO1xOy4Iq8yl4kcAMTem9IweHEkM
 5ebDRPgufJcr4F1bgYH/r9+3o153MxgqVKBLjLqmKImFZONszvp7UBjSpGuP1DGdD51A
 hGADGfIWsZjdt3Djl/YUWL1Sm17QPbsNeIXNSMnOUmDGZuwfGSxCV1SBUtQV1+ktH4eu
 JVzA==
X-Gm-Message-State: AOJu0Yx7dhxLGQBHfTCJ3ThYB1Pdgdmrbs89a5yLOwfwo865To/x6x5M
 3+hYvqvmqIYB7025RjGIlZCmz4OG+uPUzZzUmrZDxwWeLi8t17fdbbObcDcHGzpGcGYZ/IThPOy
 r6Sk7E2M=
X-Gm-Gg: ASbGnctsHlBfrmQDBbq619M6UyRpKwOV0g4FfNWG3CzkEwbPsBA3kKzzKXc9xIVKm31
 UdnoxWF22mIeMlWMs4DmFubkR9BV9t7tUeCvZOulcXBvYWeSVyZiggzURroXuCptlNEARCVfm3C
 vC4nGaDFPIbK5X0E1qVW1SPLSoYXcDtfIxGtKQLRz8nwcV/MviR9Np4FMh/QZqyycO3Gj17faO0
 3icuuYmY4ag/inCZHv4ivAjssenwjOkYTDEc3ShbH0eqfSwZNiN7Rphgcy8BOOOcH59xnrdmgAK
 yKzA3h1MA3jWtqa6MmiFhqEQK+APAAOjEAf4rgjzzeBlZ49N360OYdIk6UFDV9qTQXXtuzVwWpJ
 fhjDobgBPWgqpKIuhK38l5N13yAHihbLzVwuc/+9tg3daxoxpcON4bsTB
X-Google-Smtp-Source: AGHT+IHdr57OVuk+iPDXxDmaUIy78PYd8x8vVSJkyZFR0uJFZtp7nENGRBlRBSksLQRtSKWlV4cR6A==
X-Received: by 2002:a05:6e02:1a6c:b0:424:b862:831e with SMTP id
 e9e14a558f8ab-42581e7a50fmr39287285ab.15.1758634640766; 
 Tue, 23 Sep 2025 06:37:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-55bbf14c47esm2860939173.41.2025.09.23.06.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 06:37:19 -0700 (PDT)
Date: Tue, 23 Sep 2025 07:37:17 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10-r5 4released
Message-ID: <20250923133717.GM124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5XnD7+5xrBxcRcei"
Content-Disposition: inline
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


--5XnD7+5xrBxcRcei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's a day late, apologies, and here's the next rc. I've pushed this out
and will merge to the next branch shortly. As with previous releases, I
want to reiterate that in terms of project organization, we're moving
ahead with SFC and they'll be joining us on the community call that
follows the v2025.10 release itself. I would strongly encourage anyone
with questions or concerns to join and speak up, or reach out privately
if desired. If anyone knows of regression fixes that need to be picked
up still please reach out.

We're continuing with a community meeting following the release
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
September 23rd, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Small sets of regression fixes on TI K3, i.MX, STM and starfive
  platforms.

I continue to plan to do an rc release every two weeks and the final
release will be 06 October 2025.

Thanks all!

--=20
Tom

--5XnD7+5xrBxcRcei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNKijQAKCRAr4qD1Cr/k
CnSPAQClVWAkmRAGPo+YxptBP1PL6BkIklXkk8wuR4NVyx4hzgEAgvderZvkQrWO
+exZsgFYbOSPPQk/faibKYRJwC9s/QU=
=echP
-----END PGP SIGNATURE-----

--5XnD7+5xrBxcRcei--
