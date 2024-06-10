Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5879C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 19:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C878867B;
	Mon, 10 Jun 2024 21:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G9BXFgwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D59F8852E; Mon, 10 Jun 2024 21:37:56 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F33F88684
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 21:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f9bcb57482so713618a34.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718048271; x=1718653071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RgmnJGsx7jdFH9JfPt9yEkjf05qyP/ztgwtURcBy+q4=;
 b=G9BXFgwMAvl6Opiokl7g4Tp34y0KHgSSNIB7TUEKHyN3NOqtXyblbwkBor2D3I4Qph
 lji3/a1NYjLJubNDIWkum+HcvZ8Xch+IT0yE0DFuJUD0ELaGPy/3+rFOcYUfaXA2dRYq
 NMIyr+N+m80+ts5xvB1w1r6vgIzcqaoquUzf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718048271; x=1718653071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgmnJGsx7jdFH9JfPt9yEkjf05qyP/ztgwtURcBy+q4=;
 b=r5SEW1t8zQWsUXQtQkcelohCpahWlEySgspGrPBpGqH0UScRcw8rL3IUpB/gk0GVwP
 XWGxum/OM2yWCwitorqUqWONvxdERjEFF6NuSk8IKqHRuh2lpR2mPTE//zVeOni5wrqh
 QBf0IdGgiQAJuPE/ykiEEa1nmBU+FYulyXZvfnX1SNOGw57WS5trtLWzXAhDB3ASMctO
 6Aj5LbpGzA348WxG4i2nDp4qAtmNZsZAwLrr6GS9U1OcHjU9PhYmB4OY8URnrDfUr+7M
 u+brYFzl8yE+t88WAVAjKnQU7sB5IQMxERaH/qMTY95WjNU5ExvO6IKjKuXx5OY9nAlN
 484A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSm/RyHPXinqYLFyOvvSPG6/jjsaoKADP7v3RlZasxwOH56XKI23PDxeXrHt5njeuBTFHN57Bj7fZgVlqoF850m+Yklw==
X-Gm-Message-State: AOJu0YxY5MsSYFvSADByppmkhf8kbcbwEC+R4qqUuZfGucZprH/4XFsU
 ua+8XYuVaQctWWZzapVZVnxUtpUuAo0tgRulNFwSaVCBcWUClGiaPpc+2JRB5cM=
X-Google-Smtp-Source: AGHT+IGqHzJFBLb8I7qzUU4GEmJdMvbuxvx3TMT2bocEO4WkKb5VkAaBq9Zy7EJpHNKJ2MkswjfY+w==
X-Received: by 2002:a05:6830:12da:b0:6f9:7389:a1ae with SMTP id
 46e09a7af769-6f97389a4f4mr9596620a34.5.1718048270951; 
 Mon, 10 Jun 2024 12:37:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f977ccd4aasm1010468a34.65.2024.06.10.12.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 12:37:49 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:37:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch,
 quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240610193747.GY68077@bill-the-cat>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fLFlO0+gGUDYgK3k"
Content-Disposition: inline
In-Reply-To: <20240610185116.353604-2-vassilisamir@gmail.com>
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


--fLFlO0+gGUDYgK3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 08:51:16PM +0200, Vasileios Amoiridis wrote:

> Add support to save boot count variable in a file in a FAT filesystem.
>=20
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Thanks for doing this.

Reviewed-by: Tom Rini <trini@konsulko.com>

Would you be able to do a follow-up that converts doc/README.bootcount
to rST as say doc/api/bootcount.rst ?

--=20
Tom

--fLFlO0+gGUDYgK3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnVgEACgkQFHw5/5Y0
tyzc1gv5ASWneDph0A7Nm5mBn2QwCl4yj0cL91zMJWf7T6uCCN6LICcFLBPOxdiY
BRLBrg/wW7rr2a9ngCTTidN6rdljNBOF/TyhVN9gmty2SyvuAOSbPMBWanpMRZwR
sl/QfJMqQFScwqKSxeUIzldK/JBGst0MWPnLWrHgBeC5qEGaNCceiHrONPD9j+d9
L5ASF1uCZQ+hAstrBPuYhU+oZrMZA8Sz7+aP2f5Vpn7rD+UIeygxCg75eM+Y2mxh
DnC9nRXQlATh6I/2pPf4rL2kq07a1xJbuqrcUCFBB2vGGoX5YNEtbFAC/Q+reuIx
rr4Ee6ZBEymJ3eMQewoNNi41NTS2aLapVWBEbsxfifsx9KsnNWYPKit10O7E6xdv
NfV+8VHnQwg73LCyJDMvr/kPwCul5ZabEANDTUjDfeEuPNQZ6eyRY7U+YILiPoJa
0lIKTCpc3CLpk2Cq/uClAjnnahU2L21l54EYvdMDsTYNIJMlKx9Ip/X3decDCAB7
pT9unUU4
=IoR7
-----END PGP SIGNATURE-----

--fLFlO0+gGUDYgK3k--
