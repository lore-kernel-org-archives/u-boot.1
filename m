Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6965CC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9B38766A;
	Wed, 22 Nov 2023 21:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uKtdkr0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34BA87655; Wed, 22 Nov 2023 21:49:48 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF86A87674
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so2181677b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686185; x=1701290985; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MtMpBov75oYJbk6i/DnYPwgo2pILRIoZVIloGksmxnY=;
 b=uKtdkr0Eo8suj6i0LTMZ0+zBcGWLdLx0fJLoWRLYb7GGbr5nAI4S6TUE0Wk+8vQbMh
 NSlnkeHBWXHX99lHlWmzhQxcBXuNELSHyrxqcpLah4eKJWSQ5RY3BmQxB7p4DT609tlW
 5bkIwXs4r6U7ovQaU9i/Z1zSS7kMLBFPNdgvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686185; x=1701290985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtMpBov75oYJbk6i/DnYPwgo2pILRIoZVIloGksmxnY=;
 b=ShKzVTkB+b2nMBohkc5M7SLs2BoRS5SFCtzu8udO42KVNsW/u1Sm6QMDeKZpjr+X5G
 aWRPSzEnKaXawPe61uth7Dxodrua3/58EEwzxTFeZRiBXWjY8GtajX5BojADi5yE2mQE
 X46TV0KwQgjY4DWF8GLsZcJrKpcQHUdLipwVczPtm9hDLUTNKKrBAkz1qt9Zq5Fipv2g
 L129x8KJK3BVIMThjqpICF1NWEPR81JVAmrJ0l2onCHmdPxg3nOvdsK6Zi6Hgj5k3lKV
 NsSH6h9ONOiq4ovcO7zTBmEPPah5KxhAw45fzOxrA5gyDPJjIwlw5IKTOSbmF3FB/ALz
 5EeA==
X-Gm-Message-State: AOJu0YxaT6fFTsgonuMAGpKBfQsnDPeto6AwSuRJhLTSZlAe8KHQKSe2
 vQbN0FoTSj7WXCzXscDekxTqDg==
X-Google-Smtp-Source: AGHT+IEC3a07vD2pSKrYJIdo6g2+EXR1hBOP/TxBJ/n5UzeAj3fdBWORuyeaDdxAflsj4Mf3XM8MmQ==
X-Received: by 2002:a0d:e8d1:0:b0:5a8:204c:5c9b with SMTP id
 r200-20020a0de8d1000000b005a8204c5c9bmr3874687ywe.18.1700686185531; 
 Wed, 22 Nov 2023 12:49:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 s64-20020a0de943000000b0057d24f8278bsm85164ywe.104.2023.11.22.12.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:45 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, nm@ti.com, u-boot@lists.denx.de, vigneshr@ti.com,
 u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 2/2] arm: dts: k3-j721e-*: Sync with kernel v6.7-rc1
Message-ID: <20231122204943.GG2513409@bill-the-cat>
References: <20231113043023.2126690-1-n-francis@ti.com>
 <20231113043023.2126690-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s6So/kerpDGMvCwN"
Content-Disposition: inline
In-Reply-To: <20231113043023.2126690-3-n-francis@ti.com>
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


--s6So/kerpDGMvCwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 10:00:23AM +0530, Neha Malcom Francis wrote:

> Sync the U-Boot DTS files with those of Kernel v6.7-rc1.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--s6So/kerpDGMvCwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaWcACgkQFHw5/5Y0
tyzBEwv/QNCFAPpMUYvbP58FC6M9Psk59eXT1KGVZQWCMJOA6Isjmuw26ZqLNqfL
ruBZ5r/Zdle5j3Uf7v626xSXDA+/zdhUxlN+482xCJMAoMa4iAPceNZbVn4s7OZv
9rtkq/DYOpBUMoTJKUAMvBgWRvWz0jmFK4xmMB8cyuz+pdIyKPc9Inige+Ejntq+
YmqS9/Onq2x5ZHcKlw5t6aTFhsJhuDbtyThqBNem2lhMFQV+5+VnAjbQx1J0tncy
fS14hJo3YfzHOj3LLcWl7rZfPXbE6dFz10q0p9UU4KgHzuZYaSaoEbr7A3p7H3I4
IW4Ad80mL30T0/PyUJ//lmxaCfnOy1GQyICEzsAMy9sBYp8G6mEFxM8yjvpvxcvC
SXVMRRttNxssvZu6jaAaOQcRS74XSJqUH9+dm1o8e8abMsCQCmp8po90JPjMAj79
GDJ7M7ayABePyVn8rUMr2vUfE9JQu/OJO/x0EgAjTlPLG5dXvTywp+0X2cUtZYH8
qd+ejttc
=kXgq
-----END PGP SIGNATURE-----

--s6So/kerpDGMvCwN--
