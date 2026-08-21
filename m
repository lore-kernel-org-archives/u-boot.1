Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23CFC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 19:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44B4581204;
	Fri, 21 Aug 2026 19:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6rys2TOo6kK; Fri, 21 Aug 2026 19:44:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787341498;
	bh=JXLS3f/xNqDBU2YBfUY9yrKDluC2j90fHIZdEuAYpuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJBquS5fjlyB+dSBrsJIkyl6t40/gqojIsCtZr8k0ZHKJFqFIpHq17nA0UR+/neNM
	 eGaqBuY5OacmYvSpuPEJsJURuZ6RAyl7qztV5AMcn5DmbWnILBgJeAqlxGzM8xCyQt
	 DRLHdy5NjGcCxsk955p0OI1x2ixq6nj2QKossw9yjMmLQq6cQxMMzMXI1lkUJeBFff
	 i/vH8ghDE9eqxO6MX1hFvZDNa1KCabiFQO//SHa67cbhJcJV0whyyq2bHeBZAE1LJw
	 Mf8xYw0MO/GSdr05Gqv4NLYvE02ucO93vCGJh/3QDMGdL7ahc7Tj/scJxbre8ue/d5
	 Pfk0UaIo+L17Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C629081158;
	Fri, 21 Aug 2026 19:44:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A606E476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FEA6400A6
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncp7OaV_Q2fb for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 19:44:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=khYO65Qd
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D351340096
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 19:44:56 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-45eb2e6402aso857394fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787341495; x=1787946295;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JXLS3f/xNqDBU2YBfUY9yrKDluC2j90fHIZdEuAYpuI=;
 b=khYO65QdeoOmMWn5bRyjBbFD9Ib9QE38dWm7JLIU1rQl3MoRIime20jTFMhmsDUunN
 EDw9aEQzSDOlqh8EJjd2YfJ9rj5uH55acnzAHZ0H9l4hljQ5FmMdBvXZPkPI7ljO2aHe
 MYmpCxGkBS/U0D4fMYD8J6AfeLyZ6IdGsR+lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787341495; x=1787946295;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JXLS3f/xNqDBU2YBfUY9yrKDluC2j90fHIZdEuAYpuI=;
 b=hPeGERtgDh6CTbv6vcULeohAQmpWQrkh+D/uU041Tj+TCcYIYvlafeJwWyb2+3yF6c
 AzMgnaOt46XP9cdFErn5LAUBl3f65Dg8FkmCJ09ZAFURXqFAFdFoGCXaxxJVY80d63HO
 b9rK4YYmflZnEhyBRNqK6X815jF8J5HGGQU9z21cK6nWUj3Y28/VYQyWKKGKo7ODrUyZ
 O7ET++mGQMo3fM3vmpQZ460dOVyKN49cvNiu7+AmA0zJTfkkGKBaqwWQrp479SK0SeRr
 /SykDJ4I/bx2Yi6SAuPt4gqSzBOBgRUT/X2bi1ptRGCc/PmZnuZEPJ9ROEUUv+gEQq4J
 TygA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro96/nc96cffWSmMBS02vEbpNDsrTrRBEal9hHAG4Xu7i5jeRzMRU+/7XBV+otlgI83zHCWKWo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw+m5Nff8UIMbogxllJYQB5/i97sQe259KmLDMIgDK00FtYO8DT
 7CNgZpfk2wmhPx9finpZ6ZxDiyPQJi6o+ta/xGZL9QhdA6SwQHSphjzJ7E+Onpfc1WM=
X-Gm-Gg: AR+sD12ZgLN2o+lyh+oTWHr39wv/lz/8UgEi//cflZokr7feEtZlVfwYwislxpBzPZ8
 EChbhKRlmqmWBb3u5zi5GN2Ub2CRD7YFlCfx3WUbOUXWdGyWq3y3Blpuj3TqUyFCFDImlLhTOHD
 nTuIT6ieUdJOZzJkhcvMWbuc2RB7zKUNHsg7w+lBNPU32DSBjPB8IAfd+pXX4yxiH3q/QsyORRk
 z4d/Vw3iih2rJ0vwQdrK0gxnP+8A85QWNzkzfIgagMesnmlOcEYAgIMs1t4Wcae8fOi/ig3SVbq
 2JXylfSlWLUx1nYlTEoeeqsFBxI6PHi3qCLDycKubXcrF7hh7PJ4YG1/JKbKOYWmz8dmEIrlxWt
 b2A878y1AEyobcitCg/9ip5AsMEEdfPWo7YhdClih2Ih/deixhWP6mIBRkNVbMLH2YoBW7fgqts
 AxxpDspI/+Ac6sX3OQ4FsIXM1w/9O+CuvK4vK7x1hXGAHwp0yQtl5DxvMBoIhcWYtog1hVpit9K
 j4J6fMM990+v5IhmWL2D6XRVhLVaCCle2rfHXfS2/Mewh7Jp8ZGEmTXy6XMR9xoGXaOYtmht3Ic
 Jxr1aBEBqMk=
X-Received: by 2002:a05:6870:3c05:b0:45e:de9f:e019 with SMTP id
 586e51a60fabf-46351626d3dmr10584075fac.21.1787341494995; 
 Fri, 21 Aug 2026 12:44:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463831397f0sm250117fac.3.2026.08.21.12.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:44:53 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:44:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from
 kernel v6.16
Message-ID: <20260821194451.GA3890585@bill-the-cat>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JNRHdqmxq1GK2q7n"
Content-Disposition: inline
In-Reply-To: <20260821084829.2070426-2-anders.roxell@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--JNRHdqmxq1GK2q7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 10:46:37AM +0200, Anders Roxell wrote:

> From: Jerome Forissier <jerome.forissier@linaro.org>
>=20
> Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
> is needed by the updated DWC3 code.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

For the current series, the cover letter is missing in lore, and the
last 3 patches are missing everywhere. I think at this point we should
split this up as:
1. A series that resets the driver, and brings it to v6.16. These
haven't changed in a few iterations of the current series, aside from
collecting tags, yes?
2. A series that makes it all work again.

When being merged, both will be required, but this split will I think
make review and iterations easier for everyone. Also, for the next
go-round, please drop some of the old email addresses. Thanks.

--=20
Tom

--JNRHdqmxq1GK2q7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoiqrwAKCRAr4qD1Cr/k
CoUjAP48JNv6c38qmlBYC8iOU/JR4hzITTxLHnW4If12hJwQdAD+LLAGUEv3jfxE
hacAYuYh8YpNI2JUnrUpLCM8dDebhgs=
=AFM+
-----END PGP SIGNATURE-----

--JNRHdqmxq1GK2q7n--
