Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F419C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8086E807B1;
	Fri,  6 Jun 2025 16:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qNebCaRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B704F81FEE; Fri,  6 Jun 2025 16:19:50 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B4E800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2e8f7ca7ca3so1393479fac.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219587; x=1749824387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zFiuzlfJoAjrMX5vu4i918Z66uQ3J9v4QNuyuKhnQNU=;
 b=qNebCaRgjOQ49Q5XzemThdDx8jqW+U7jivfSTu1KQNbjhTTSVJLOBf1dJwCC496CoE
 FUZ1HgGM3T621RNyHNbGydTyoo6Bfs9oUvQF4PMabRtTXB1ukLkNZNpfq6/qW7mJaEBC
 gGuBg45P9zIjrnQwVo08HZVl+KzHkFOptUXBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219587; x=1749824387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFiuzlfJoAjrMX5vu4i918Z66uQ3J9v4QNuyuKhnQNU=;
 b=VEWrIl/th8LIAaaUTRKY2icq273i04ms8QitXMy7K0Q6PxTMgJUDLH4C8QC7OW/Csd
 e3E1UKgOIjZ2ShWkLCrZ1z2hc87C04AW55DsENbGlmyv7lvryRc7525FZeSf9YG+Amov
 8tuWp0CmFVGndxO+1Mc7ShjwNjW7eVGkCOPsXMO3luZgYfMHNt6Vdm2eIOU2P6CVHkMM
 rt9gXIqoph8E6IK28nJpUiSl3S55CzXYYGZFGXq+OEbbuZMtNXuKPTj2eoXNICMaXvL3
 LsCWEuXFtS0SjaCLC+Wie8O44d5tm81ufS5/nlhmMlXhNcz4Y4/BuNngqYYRITjUXmjt
 /URw==
X-Gm-Message-State: AOJu0YxQHf6e2iUcLrMDQiCkq/hFUxo8uNv4EIJTvDtqb0uAtcyrFA2W
 RXekcvjFIVTPbl+UX+DyOMH43Kt/WDpeygISyGGwKxnSVdnjiBvSe6LXUGiFGaif8hw=
X-Gm-Gg: ASbGncv5wlmKdVHs6MOeKOoNySO5wMp4mh6vwiRXlhV/EXIz4LF72vL+RtZ3xVZUBCy
 UG0lt3kpJFgdbjZAMF/UTq9ufKQWajbl0G3g3R4Gma11Rqt9+DWtfMyNAI+837ELmYA0UU3eJut
 0W4W0x80i+eoMcHA/C5L9bmGsPw1j/zIbUB/fslcGP5Ci5dm7deEFxgPhN+H6YP3y+dn3wSESzT
 L99EAeHF7hAxBGWefjNsQ3GxzNV5MDQv33NMTyJ+ockTjyG1wwcE9R6p1o4GB21jkLd0RTTT7Fc
 OAycTivbKYCivwqTglbTNDMg6O/bwGBc0fzHjfceg1dsKU4AHJ/7Ujbww48hYQDcSyLDN8+akh5
 1bd2HbESnkEY1
X-Google-Smtp-Source: AGHT+IEpMEFr5hlu9uxtU8BS7I//UTb4P7j9o5E+iTpGsEacz57540Bpe5rBvngZ0JbGD7f/jKDeVA==
X-Received: by 2002:a05:6871:5b1d:b0:2bc:7d6f:fa85 with SMTP id
 586e51a60fabf-2ea009b4463mr2099559fac.16.1749219586968; 
 Fri, 06 Jun 2025 07:19:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea0707a8c8sm328032fac.12.2025.06.06.07.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:19:44 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:19:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 07/13] lwip: dns: do not print IP address when a
 variable is specified
Message-ID: <20250606141942.GO1382132@bill-the-cat>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-8-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GmfDf9/amu909Pu4"
Content-Disposition: inline
In-Reply-To: <20250606064211.3091237-8-jerome.forissier@linaro.org>
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


--GmfDf9/amu909Pu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:41:43AM +0200, Jerome Forissier wrote:

> When calling "dns <hostname> <varname>", do not print out the IP address
> of <hostname> onto the console. Print it only when no variable is
> passed. The reason is to be able to call do_dns() from another command
> in need of the DNS services without polluting the output.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

As I do not know off-hand, how does this compare with other commands
which can be used to set a variable? I assume it's similar. And then,
oh, we don't have doc/cmd/usage/dns.rst to start with. So, follow-up to
this series please, document the network commands that we have in both
lwip and legacy stack and please note where there's differences if any.
Thanks!

--=20
Tom

--GmfDf9/amu909Pu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+P4ACgkQFHw5/5Y0
tyxufgwAqleF/mcrZN+wlVB7nNnwuKpx+qqZO07gQ23HKDzDUElxDvo40K2nB36a
KcINAcJOnbVcmFnaI9v0QfOGIK1NR8aJTdWkNpEeMb1maeWmNv1c5ZHY42LxiM7t
PZbFqqtPKScoXe3b9eWBMLirzY3XSZ193AbznZOMmgztdrevJJxZOAOQf5ent6MS
IdsPlo+NY243BB6oV++KqBCMqr/BKrOpteeob9VM6YiLwv6MZFiTzvwQX8onRBSl
lAS+uHz3+/BujJq+sdtJB/nE8tAMVHUxhUu/0mU41WIGHqjV9V9SXJQz16NPSpgw
jOnWxhmVBS6JIXGI5/RMkytcIs/hFL04DNgkP/6eXkaxvbeXBOVKN+T3MhyGYu/w
ZmgWg0MYlS/Mj84xszhsftYPEIXLfPCXzZCBRSCt3GPbc4X4cUzI6RSi+vjIrncb
C2bbom0m4622ZrlNHlqJfdghihfOWZoaseRrlgEWvEXOy5SwFjpdsqUMb7MFRxpQ
gNTu8268
=3AED
-----END PGP SIGNATURE-----

--GmfDf9/amu909Pu4--
