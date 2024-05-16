Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B95FC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781418847B;
	Thu, 16 May 2024 23:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D4imF9cP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F5E88481; Thu, 16 May 2024 23:13:52 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E872888459
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b25cee6b7bso410578eaf.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715894028; x=1716498828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kIc/+MinzOVbR9dMe3FKjlURb7OykckxWvYsowjJLQ0=;
 b=D4imF9cPcxA6s8nJUaiAlIuatQLWFAPGyZlHG4xU/56SDITqbkBKRBa/won14FQ7QA
 qVa6rF8xxmxn1CeD4SC/i5bPELrFwrGhn3ss85hVw//+xSPqGLeTksOafoRtFQ2OdUzU
 uTs620Y0RKkTW004GX2yzVrrhoWEaC2Qzmbfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715894028; x=1716498828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIc/+MinzOVbR9dMe3FKjlURb7OykckxWvYsowjJLQ0=;
 b=c2jbi1HAxnIgYZh2dPAEMCHm4NhU1ktKeJZo5m5GUnsX7XbHAhKyBD/ewDMwMcvuq/
 DyQoJTu2z38oFVdpF4enCrSdeeGs67EOMvfZJpl/rLe2zaC+N+ZcxMF6iY1NXTvuGO9Y
 DjuZ4jWq14hO2PGcBi4C4uPV3dx3Rf1bN5RxZiUdxnySY/qVJOLuQcKyqoD39+gs1Cyq
 yMd3CeNIUGrr+dNYJx4a0C5txt6vr6DkYD8qXIeeenqUhhywCv6IbK8XqezimIH0SDTR
 MOgt+VqsxKP9qHnB70Z2K0tienWxYnD0giraUhMlhKGjWMwdBytE90GDFggPt6y40gtd
 m3vA==
X-Gm-Message-State: AOJu0YwGHy2Wz6Rd9zKWMVGxc9pwttf3rWAy62/zoTwrdEBB1lDjmjg1
 1uzmTjw++j3I0yzjb797kb3pVRXs2wY6J45go7YBWp19UyiD7yC4T1uiOBSx15o=
X-Google-Smtp-Source: AGHT+IHrIl1z4Y0Qi80deJt5Q2GvRP74NO6gtXb/0l9LBKvoMOBTz+1JMcuDWJC7hMr0JtKYqzKEEg==
X-Received: by 2002:a05:6358:8a8:b0:184:fdb:6cc8 with SMTP id
 e5c5f4694b2df-193bcebc8e0mr1721679355d.24.1715894028455; 
 Thu, 16 May 2024 14:13:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e2e4e1419sm34225331cf.51.2024.05.16.14.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:13:47 -0700 (PDT)
Date: Thu, 16 May 2024 15:13:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Phil Sutter <phil@nwl.cc>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Tony Dinh <mibodhi@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH v3 4/4] include: Move snprintf to stdio.h
Message-ID: <20240516211343.GF2568172@bill-the-cat>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
 <20240516211156.1819939-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="deZRbRp+FrvGZ33w"
Content-Disposition: inline
In-Reply-To: <20240516211156.1819939-5-raymond.mao@linaro.org>
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


--deZRbRp+FrvGZ33w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 02:11:52PM -0700, Raymond Mao wrote:

> Move snprintf to stdio.h since it is needed by exteranl libraries.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--deZRbRp+FrvGZ33w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZGdwMACgkQFHw5/5Y0
tywEWQv9EtmDN1D19n3CVAVGIN1EW4ideq3NTW8PDbjm16yqaL9P1tPM4nx/e90m
M7lXMF0y61ZI4T4iYgFlD6voVeEdoln3vomr/qi/fIBQpvha0Khems2+T6I89pIT
tZ6zIIaQja7FfimThYHZDtJP6/Oj7kfoRaaMRx/kuH55Smj8uSKyrwLaFGF4Zngp
oKKXujaxAQtOZYYvVsSqG4VN7I0eCIAoR/8crYCUZZ3GK9qUqmoQue5B7sBVok+M
/FCT9M3kZm2R0nn9fbdDNZPCJA3szHLE/8Ls1ifuEKF/VtgsG6QoRw+K6fm0x24P
7O9XA2UX5QhadK7Xv7ppq1cFy8gZCzKG4xHDvky7VSOWbWe0dhD5ZdZ/VMaDrmwi
Ocua1aArQDLFy7RxtbMWROyokCQRSAgpmkoOVNQzhtUDGnbIxKFEvRPXp6UtXtNm
OVVnI2dWD8JZk5Dz+F6EFU4b8ZxUXg9UrGZmwsDwfMCkoi0zUUh9oclkV2JTm9aR
fMkpzEbo
=GV8v
-----END PGP SIGNATURE-----

--deZRbRp+FrvGZ33w--
