Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB81C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17CB87570;
	Mon, 20 Nov 2023 15:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="APTvSHZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7BA86FDD; Mon, 20 Nov 2023 15:05:08 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2407287561
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 15:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789923612dso273342585a.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700489103; x=1701093903; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O1utHz6SEBuXj/C8hItWJ4GHOQwZnkD7u/GtZBnirmQ=;
 b=APTvSHZk8AjMGo7GLa2jxCqhAHIjSruoYWiULIMAcGHKwee5B67sfpRNGiKex8tAGl
 s+7j7pwmMsH661Uuq4kwrrheGjM50MlvBscE0oradLMHPo0bImpqg7U4v6WetsN4ldvy
 Najl8RXxQBGxi0EwdoAbioEqdxW2nb7fvqLwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700489103; x=1701093903;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O1utHz6SEBuXj/C8hItWJ4GHOQwZnkD7u/GtZBnirmQ=;
 b=jHyHbn/MsXPUBVxXgWYRxr39U2DIPtuM1UgCdZWg66YA6r6O6sqfzlLcFab7qE7LGF
 zllzaq1XMcjdDiIZVRzzT5yPRMFPSJH02mf0kIr1K6Pw8K2UpgCJG3x0x2rkNmiFrZEp
 MSITfP1HLfRfks61iwpWY60zyt1VmkkJl+CBv0YGISl4tdOckVKA8h+jeS/Tt9LawPrk
 03WtgqSQTbaEXXfOw+tQPakY+VGDDvXydF6tee4qtHM7isXnGPBqNLlPukmnVx9IwcZH
 H0ssmaFrjdKjOsDv6hH6EgCi+Qx6iND7lwPzdnKiWWciUUaYg755Bdd2Bl+fePbF9CYn
 xfag==
X-Gm-Message-State: AOJu0YwTqcT+jX01l+RuBYBrXQ0XZO0QRVv9wZ5xA6cwXRvVZ3UO3vtE
 D6thfMX+LeGKyyHMjYjVtTkoZGWmjmr+vc3mZPoghg==
X-Google-Smtp-Source: AGHT+IGm67S3LCqKtSJMb2pUF+vycSLc9OVPwInw//3zc7IpWv7PK0+ymf9HA24CfxOQUBvc8hqbHA==
X-Received: by 2002:ad4:5de4:0:b0:678:f4bf:8fda with SMTP id
 jn4-20020ad45de4000000b00678f4bf8fdamr7614997qvb.58.1700489103727; 
 Mon, 20 Nov 2023 06:05:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a0cebc9000000b0066d818fa482sm2910169qvq.115.2023.11.20.06.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 06:05:03 -0800 (PST)
Date: Mon, 20 Nov 2023 09:05:01 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc3 released
Message-ID: <20231120140501.GH2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M6oXGkx/iwSv1tb3"
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


--M6oXGkx/iwSv1tb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc3. I think I've been good about taking
only fixes in to -master at this point an pushing everything else out fo
-next. I'm going to do my best to continue that pattern, and there are a
few fixes out there still that need to come in.

In terms of a changelog,=20
git log --merges v2024.01-rc2..v2024.01-rc3
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on January 8th, 2024.  Thanks all!

--=20
Tom

--M6oXGkx/iwSv1tb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVbZ40ACgkQFHw5/5Y0
tyxU0wv2L2o9CGm1HzXY8vWOG1BKaSdGCbiF6YVpGO4FdZZHd+Dalv2SmliMkGeT
J75+yjAcNPdLN9vDpDcAEW1jVhLgG5tEFokKvkEGQzzHGYAmtTvQEaI/fBtkqiKs
Gap8TVLNlTGWoDzHFJPDayMzlXT+ZPN7M9j4ycPfS8THz9Fy65B4ZBW4ImAs/Yio
OEYNm3kCFhLiA3p/Nq5GUWKQB7tIKW/nFCN+T3l171yN8OTDb3QNzgpaSxFyyXxZ
2iI2hkfelDwKorFq7dr2EquGB8hxG1DJpUKPff873ShxfIjpoAi9vch1s6dpX+3D
jOXbCHv+bKJQyE1wrSTsOY6POMtgTAXaX6v4yZHxdbjLMETKy3mpHthCvNJRy1G+
FLRxz9xZMfFu8xnbqUgVfCQvyzkerFJ3jXKFS8nHCxx86egJKXSVOikAWrZHNC0A
+Y6HT31KjKxFdbu24t12sABOJgL90YgLCOHAcFp7VySadLgNt/bPlI24sF63Zmpb
lXdPErw=
=wytO
-----END PGP SIGNATURE-----

--M6oXGkx/iwSv1tb3--
