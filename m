Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64253C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC76880F1;
	Thu,  9 May 2024 16:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKt+nRIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0DC880F1; Thu,  9 May 2024 16:54:01 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900ED8810E
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-792bd1f5b28so74058885a.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715266438; x=1715871238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ktHT8LvbePJtaS/n7feRwXxIJQuM7aIMt4nnMqNMjw8=;
 b=rKt+nRIoBUVJNspnKW+0JdDytcD3fb+NUkSAWZ9Kl8R/+XouRz8+xqTqDkDN2GRLAN
 15hwG68LJYAkD5Rhn/5ZXWQYqk1gPyypCk/8jUPOXGKZKen1luTVXMgixCMkv53x0MZF
 m6zI3pYi7LLDicjAgkgCtCaCjgnUxnFAIPTtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715266438; x=1715871238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktHT8LvbePJtaS/n7feRwXxIJQuM7aIMt4nnMqNMjw8=;
 b=ACtLeGP8HQrBSLvq4CCVPGbR8rFJHPYpYnsNLNBX8cQOS0PuwohI2qyiO56O1uTwDz
 r7zTZHbVHRUZw91vjLbMq8lwXR6QtNeyvNJiMIw1HgvTNTdXZIL22xFoZgm9SoXvXX+P
 xqEHpYjfy7pzNHhVxQSdLoj/Se7znguKYrCQDLu+2we5IQQyborSYp2vhZuxrEYcnpnV
 dH6+TSpXW77jnlxyNSvxy6IWZhLkCgI4RfzI23f6Cwz5OrD8ZQYNEsVcJTuR282DkEFF
 +vmSQwaszko9Y1fpceG7V2PbyCwcGqFYcDuu4xb2bA/G1yPai/vuZDq9aAkUc3PNWVJY
 sKzQ==
X-Gm-Message-State: AOJu0YzpfZncwh6ATjkck32HnjnMsEqe9stNMjaYcryGBEKKVsOxMhzn
 v0lWQpIPZFB49eds1oR/DSIMH3YBoLo11bRv5i9+CO/k5ARzGyficgt43LiIPy4=
X-Google-Smtp-Source: AGHT+IHVx7pMwRGG8v0ZVye3zGv5fWiouxpWqUlTo7ruWiPGrm2E5Vc9c594BUs31te72B3x3lZ9Vg==
X-Received: by 2002:a05:6214:dc9:b0:6a0:bb9d:e890 with SMTP id
 6a1803df08f44-6a1514bebd6mr79468106d6.41.1715266438473; 
 Thu, 09 May 2024 07:53:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1872f8sm7743936d6.55.2024.05.09.07.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:53:57 -0700 (PDT)
Date: Thu, 9 May 2024 08:53:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH 3/4] md5: Use typedef for MD5 context
Message-ID: <20240509145354.GI2568172@bill-the-cat>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z0vXQnvY6nnxZxFl"
Content-Disposition: inline
In-Reply-To: <20240509143743.1496210-4-raymond.mao@linaro.org>
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


--z0vXQnvY6nnxZxFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 07:37:40AM -0700, Raymond Mao wrote:

> Use of typedef is beneficial for porting with other crypto libs
> without changing the API callers.
> Secondly, it is for the code consistency with other digest libs.
> SHA1, SHA256 and SHA512 are all using typedef for their context.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--z0vXQnvY6nnxZxFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY844IACgkQFHw5/5Y0
tywc/QwAs6QsOObNVP4hyNAzdkimXt5OYTNHzd6lsQaWXVocZE4z8bylcAG4vLoy
X6YSoK8Mxf93kE6PJIAfWRacdXsvEKHh6gjwVWfiRX9nOc2lxNjW6INzvoHGTu7C
0BXI4cpCdzKavsvmKkyO1uJ0rdz72IBt/loAaGuq9K9BDAnjVlyChvObQbG2e3r0
Bg63OXlze3KxsVj+o6orA/RISBjvvMzX+MmV4O7KxhXeTuzY6q46OkMMQ53BZW7t
TKBLnmrb+2D9iLDtoH7Jk9+04JTAzw9FYmUlr2xjJTBvxpnlHAtMC0LIMvj7580H
XaVEor9lTrpT3ssBVIOeIvLD2JwfFMXhnznevcB+fSaVhsFvS/EdZiExIpfLEkft
3vSoqq9UYUZCVnaOs2GIVon07pTniqKNUruljE8Bj5/fSXL4CIb+wUOk57GBykqs
tW92I6YLzkziywWWu7j1d2EOsYeyipkUx4FX4l5Ipz3kMCd80QJ/wCP21Bb5s3eA
o5IzfFMs
=esC7
-----END PGP SIGNATURE-----

--z0vXQnvY6nnxZxFl--
