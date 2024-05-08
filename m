Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA9CC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 15:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6601B88667;
	Wed,  8 May 2024 17:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KIaArO9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 002398802D; Wed,  8 May 2024 17:32:54 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D262A87DFC
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 17:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79290c53456so347265985a.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715182371; x=1715787171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QUfL/YBE6WWfYtdKOEkbZZgNFxI+5uMaDW90hZKZOno=;
 b=KIaArO9qb1wWkmeB4+LWo16v/aDqJc6vBuEb+SFT1ofFgApZrwbNJai37+/9U/3xED
 KMjmAs04qgHU4J4SkOVTJkhzgFWtb+Iec/ljSlScLvVVSDky1U2d0ST7bguoRm4yqJKx
 hKkWOjrh4ZAeLREFhaE5e8Muw/Udhdrhocgj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715182371; x=1715787171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUfL/YBE6WWfYtdKOEkbZZgNFxI+5uMaDW90hZKZOno=;
 b=ewiVuEMX65XlrBJytMUx71Tr+VXJp7je9chu/pQy2FO9HDwIc0IT/OFTLs8rdRZM42
 ZEB/8jidUcooHuVSN1UXGOwowRIY/2X+0T69mKWDqamdBlhu+xLDrKRnfIvbhAbBdsKe
 +NTVmF902JWoSisFdb14Jh4DPLfaLEuhS/rsNhrqOH/OAwuM3T+Dwoom0tmfeegaFBsv
 5fKdsw8i8HuqcNZ9A4jqMP7DvmSM59ZIA57pjePcFmLAtBAhk32L/k3NpED7Vdn7/eGg
 f1W2BtQtAc07OLCRYD0HBGnmRJepKLFNi8OWw/biUU6LVeZp3f2HLeAT9A1fmIjOdut9
 7Y0w==
X-Gm-Message-State: AOJu0Yy6TptYZivga4ayCwfMeVj2N9025QoqZ2BP2/oZ7RowXpPdCxp2
 QUWltDHyMo2iTgRH+Q8xYj02dr/P7CH7h+HfaivRE4qM52jq+Am/x0tQ2/BqRtM=
X-Google-Smtp-Source: AGHT+IGHTDabwowS0JO+HRgyZLYVPlMmYM/+A3UbvrCW3tEDSukM+VGFZT96XigE5a7Djwtayxv1ig==
X-Received: by 2002:a05:620a:46a2:b0:790:eedf:42a5 with SMTP id
 af79cd13be357-792b2829119mr425005985a.47.1715182371551; 
 Wed, 08 May 2024 08:32:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a05620a44c700b007929ca64e0fsm2810547qkp.5.2024.05.08.08.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 08:32:50 -0700 (PDT)
Date: Wed, 8 May 2024 09:32:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Edmond <seanedmond@microsoft.com>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Charles Hardin <ckhardin@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Simon Glass <sjg@chromium.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v6 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
Message-ID: <20240508153247.GA3129288@bill-the-cat>
References: <20240429183449.2284935-1-seanedmond@microsoft.com>
 <20240429183449.2284935-3-seanedmond@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Be2PqQ0Yz3nV9jrm"
Content-Disposition: inline
In-Reply-To: <20240429183449.2284935-3-seanedmond@microsoft.com>
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


--Be2PqQ0Yz3nV9jrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:33:57AM -0700, Sean Edmond wrote:

> This patch introduces 3 improvements to align with RFC 951:
> - retransmission backoff interval maximum is configurable
> - initial retranmission backoff interval is configurable
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>=20
> In applications where thousands of nodes are serviced by a single DHCP
> server, maximizing the retransmission backoff interval at 2 seconds (the
> current u-boot default) exerts high pressure on the DHCP server and
> network layer.
>=20
> RFC 951 =E2=80=9C7.2. Client Retransmission Strategy=E2=80=9D states that=
 the
> retransmission backoff interval should be limited to 60 seconds.  This
> patch allows the interval to be configurable using the environment
> variable "bootpretransmitperiodmax"
>=20
> The initial retranmission backoff period defaults to 250ms, which is
> also too small for these scenarios with many clients.  This patch makes
> the initial retransmission interval to be configurable using the
> environment variable "bootpretransmitperiodinit".
>=20
> Also, on a retransmission it is not expected for the transaction ID to
> change (only the 'secs' field should be updated). Let's save the
> transaction ID and use the same transaction ID for each BOOTP/DHCPv4
> exchange.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

On numerous platforms we now get:
+(imx8qm_dmsse20a1) WARNING 'mx8qm-ahab-container.img' not found, resulting=
 binary is not-functional
+(imx8qm_dmsse20a1) net/bootp.c: In function 'bootp_reset':
+(imx8qm_dmsse20a1) net/bootp.c:741:15: error: unused variable 'ep' [-Werro=
r=3Dunused-variable]
+(imx8qm_dmsse20a1)   741 |         char *ep;  /* Environment pointer */
+(imx8qm_dmsse20a1)       |               ^~
+(imx8qm_dmsse20a1) cc1: all warnings being treated as errors
+(imx8qm_dmsse20a1) make[2]: *** [scripts/Makefile.build:257: net/bootp.o] =
Error 1
+(imx8qm_dmsse20a1) make[1]: *** [Makefile:1892: net] Error 2
+(imx8qm_dmsse20a1) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--Be2PqQ0Yz3nV9jrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY7mxsACgkQFHw5/5Y0
tyyurgv6A91MIHIXDQLj8ZwL/wNvvGNKtsC67tJL3axquKqxnSHZ2wkcg6DGmrik
+RehLU6GKqHCICaffTt+nYTmoni4sRtEq417910GW0yoBi2Ntftu7VKXcB7RLVS5
XFFdgWq2VCQGMl1oxlCriQKFaIfyRqu9Ie0qxdPRvt0JAKYp62R9yGDSsKKERj7A
KrVPCgBrepXZhEeyaQDG1PUrtsIJ7lDWepFEbySC0/xUp1tBAbbAzi1PRhMg43c4
w3dwBeTimFwdDKSFEB1uRZ2zvzcxIc5oaQz6TZYQR4xvxd7WITNmJAtBua6SCdcc
ueCXhicYwJxv8RJ9xwnCEULfgTXrtDhFaToGaMISj3w8Uovs4PbBEmR8Mf57V3lI
skUfgYuQI965yBQLfgQMmFpF6uyeRB2cYiOitjAkp+nCA75Z9/PskFZzrcjq3Zg+
Qs+H3LGNZk8TS+53225o0sSjFcvWj0Rx31OThWN6VDH4OOf/saLYSNHuCx9l2Ley
t1udvpLp
=H7p7
-----END PGP SIGNATURE-----

--Be2PqQ0Yz3nV9jrm--
