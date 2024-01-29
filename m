Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8FAC47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D8187D78;
	Mon, 29 Jan 2024 18:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XOFtTmKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE8D87CCE; Mon, 29 Jan 2024 18:55:38 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FDB87DB1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc21d7a7042so2734876276.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550935; x=1707155735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yePN9WzUa6+JcjegVtwHb6idpT8dXXTA6xlMEdnuLjs=;
 b=XOFtTmKEFz+eBARmIZNMN0oY1Ba0OtQRbgmAoKl4hICgNryJn46Fhjr7+0bDdD3PEX
 rw/n4B/XiivGq2D1F7mA54tZYDy9uTZrskeA6CrFviDyyAkOE/uxCyteQySeLMcsoNtG
 0mSuhYYrB3/F7l6zKhf2Y0eF+YEfDhNWpu4jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550935; x=1707155735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yePN9WzUa6+JcjegVtwHb6idpT8dXXTA6xlMEdnuLjs=;
 b=WbXEi+XichsKMAf94pCa3vqSz6+dM7yEJgJFRrjX1UORLCWhlJj7ZzIzK+rFbHB306
 C/qnJ866l0KhDhljNFpXfPeauH+n0CRxxnQAIxHRBO3HQfTIljCQ8J9yw8Prqspuz4j9
 cKFeKgdpZ1+GCtLelb/RPOUW8UKc/Kb0Pmy0h1sXp412m8w9hyPn8Y7/Wb2Yzs1UWQOZ
 pzp140Lhff5cCqtAiv6NXSaOtnOFWpLLsR6s4noXf8Mo2Xf9FDQzThsZAr12/hZofegU
 +hhLJZ6EKCU3a9FKHyjMl5tOPPWs7rXMSEqistqwMgGavSB8k0YEon1xy8WynRt0hL9V
 Z6hg==
X-Gm-Message-State: AOJu0YyLxtEeUDGLQYI7HshDFr+v0gGKIPUSz0Tm3tB7erV4W+ec21pP
 3JbWh5w1/V+zIL3/TtukYRV8SbLlS7yhA22VApOYEbOJroLLp7LcktIfC5/GAjQ=
X-Google-Smtp-Source: AGHT+IGTyIUr3qkZLryymW5usaM9njroLR7ThsS4vJnWB/JmoYWzt4P6CB1PqMQC3a5f+B5Uu021cQ==
X-Received: by 2002:a25:fe0c:0:b0:dc2:46c6:979e with SMTP id
 k12-20020a25fe0c000000b00dc246c6979emr2696926ybe.76.1706550934850; 
 Mon, 29 Jan 2024 09:55:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v29-20020a25fc1d000000b00dc25d5f4c75sm2402288ybd.10.2024.01.29.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:34 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: mmc: Add tests for MMC device
Message-ID: <20240129175532.GJ1152441@bill-the-cat>
References: <dd6718c22ebb1e48cd66cba196769098d040f7f0.1705667387.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WIYkltJl1XwJcyYE"
Content-Disposition: inline
In-Reply-To: <dd6718c22ebb1e48cd66cba196769098d040f7f0.1705667387.git.love.kumar@amd.com>
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


--WIYkltJl1XwJcyYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 07:55:50PM +0530, Love Kumar wrote:

> Add the test cases for mmc commands to test its various functionality
> such as mmc list, dev, info, rescan, part, ls, load, and save. It also
> adds different file systems cases such as fat32, ext2 and ext4.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--WIYkltJl1XwJcyYE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35pQACgkQFHw5/5Y0
tywg4AwAmYh0dQuEFHGsXiVKopCUvXdmvENi67oZY9+69WazrOZlghSD6g/F/m8C
VnZJUMEtFclMMYBXNIzAD8gVF1et3gFK5oIi9nYRKi7+WMpLjs5LC43xwNqf4lkl
hZjDIssO9XTkCC3wDZCGzWm8/+B7kP2URZrP3LvQnecPwoWgvqh622dRD/pESKAP
aOXW/pOJFIyt0OjwdY+EEjUPMWYP5WwYnESSJWRt/0KtlOvH37jgz5eRf6b4qaxG
rwmy+dDgg7YdXB94OoICvpCWRAk3UKNl/JhwnQLRehCfzuGqu8jsDiwRB407gt6H
nnWsqvJ+Dndi8UBuwJ8548XC+l4rxvAqI1SChSxCQ/UHAZ2IW4CslPRoOAI3wKRN
9FV2oxfQMFvrChO3tjIIVRjOD98HmMN3DUoA/SnrA1WcVRdWBqb8nuwbzoknM5aG
tjfzyNAzJb0OC7jkLVshkVKN5Kcxwvieecz6wAJtA71cK0dUydmcjQa6YAZSESh8
fm+JOSxQ
=KxpJ
-----END PGP SIGNATURE-----

--WIYkltJl1XwJcyYE--
