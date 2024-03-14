Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC3BC54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F29C87F6F;
	Thu, 14 Mar 2024 01:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCfhEIHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E9F87F40; Thu, 14 Mar 2024 01:39:30 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB0587F87
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42eeb5c2d08so1497841cf.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376766; x=1710981566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHHG0MNpIl369d0BqSysaicexHxE5ZjPbkzdVz1Y7O4=;
 b=uCfhEIHo0Ojw6lIPJGsKGdvhBGMUyVcmAI+7ngcsyhbskETlErc+qqsRK5L9MKBcqA
 aslcqBWm/ZkG5zBFVXMj/qRdrcqjKTPYWCAaBVH252GNa/gt7JCRFNWmZWp7rbjghydO
 elXtRlgiinGreW3E4klkpV870t5Bb0MlsyTMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376766; x=1710981566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHHG0MNpIl369d0BqSysaicexHxE5ZjPbkzdVz1Y7O4=;
 b=SwyZLiQG/mRaQraSX3ln/bJpPBzQiAmmKQUvw5eoqqBg8zM53dXLgIrWFUHSRxJkyG
 LfiDKO/iUnZp12Nhiks3In0KfXNvrg1VPbni6aYPoJ6cJOC1GiAi7iRfJ7NMvh4KdEAi
 moWfVqdiuPxwFRfdrqlB8D+SsKkUntSHbKBqETm4x1UDGYy5HAwRyLDIUBcjIQJNNDJg
 JO/IOVZi2/BGFhpM576lB+0SDauNRqUI6u1pCPiC9YbMQFmQjxOaaP9VGGOLrE0vY6rx
 mUHmRjjeFgbV3jUlnNqPpFM1y95WJLoAr4kwDg/8YZkVkK+bd5V6BsShiFR6DUOsVQdW
 d4wQ==
X-Gm-Message-State: AOJu0YyQgZ0+4WKq7/MRiYI6j1ASQz3FZGQ1H+TJGn2aA8ZDBOXCowjm
 3FlkuJ3bowI9+MhRNgeN4eKvB9QKVAwtZzO9g70fjKd5eAxbhPDdZwiGW/eNjds=
X-Google-Smtp-Source: AGHT+IFUmipkI5SIxolT0I0Cr6UQTWc0ACAtcUhxIw2xR2dA1pexzaF54dqcLAqeijS+wGV+5/nb8w==
X-Received: by 2002:ac8:5783:0:b0:42e:b90c:c5a9 with SMTP id
 v3-20020ac85783000000b0042eb90cc5a9mr256426qta.51.1710376766370; 
 Wed, 13 Mar 2024 17:39:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 d6-20020ac86686000000b004308bdcfc2csm140601qtp.6.2024.03.13.17.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 2/3] cli: allow users to determine history buffer
 allocation method
Message-ID: <20240314003924.GI3442575@bill-the-cat>
References: <20240305073734.14483-1-hanyuan-z@qq.com>
 <tencent_D787FFDC25291C1400FDC6EB5F8396029B08@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3slejbPLrCWz9g+r"
Content-Disposition: inline
In-Reply-To: <tencent_D787FFDC25291C1400FDC6EB5F8396029B08@qq.com>
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


--3slejbPLrCWz9g+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:37:35PM +0800, Hanyuan Zhao wrote:

> This commit allows users to choose the appropriate memory
> allocation method between static allocated and dynamically
> calloc. The previous static-array way will not obviously
> contribute to the final binary size since it is uninitialized,
> and might have better performance than the dynamical one.
> Now we provide the users with both the two options.
>=20
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>

Applied to u-boot/next, thanks!

--=20
Tom

--3slejbPLrCWz9g+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRzwACgkQFHw5/5Y0
tyzWVwwAk93MXQfIsDl1eX2PHT6rf9CVq/3WzHDTnh87m3hosiL79BwfqDNt6EvB
bpMA28lzrrP9h3y0rfLsE0N68T/4R9wP+aML/c0XRGA64jk16XDvLD64IRwjzcA7
i/nSAEQpFfWPOFL9CMyVfYzQb3lH9LEfC0sYCj2ZXhT5G7e9siY9mTduA0+4FAsR
062A0zDPqMWyj7HyM/IMFLL2EDJpZUZgO6ec87sRaLWIH9oAIOghfhX6Rk7x+iHM
q584eG486WHFvKu31c0KWs3n1L7j4y9JYvv/pAu6TlIMTeYPO36VRxUX9UB5fqdZ
KgJEu9Wbme+q27UN2SEuMLNMmn/ogy+sXFTu0bp9mt8pDtNAjvQQbkQtplRBuaUu
meK6bGXlm9vA2XqCnJxDldqRWa7B9JQ+hD7SOD94p6t76RdCuWfF74xbRbkdMEQE
XYchBm0ir1tflr/zwG8uM17TG//X6J1XK8b9TRSPqGQqSdunV1dcrw+/BkTfQcuW
qSTTsvC1
=kvWD
-----END PGP SIGNATURE-----

--3slejbPLrCWz9g+r--
