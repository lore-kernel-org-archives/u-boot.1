Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2D7D2F7E1
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5B988DE1;
	Thu, 17 Oct 2024 05:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MKQGvKbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F005488D40; Thu, 17 Oct 2024 05:11:16 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC7488DE1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460a415633fso185301cf.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729134670; x=1729739470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w5xgd/IqNOkKb3hcb/jTZyThiWGmJRroD0FekBsQrPs=;
 b=MKQGvKbWi2Mevp0wki15Yz6/vyZMPtEtlpKAkJDO2vSE7BtFmERrx3MjC6DDcA7SU9
 OBkwQz4KZR0UKQPChFuDqPLoDTcKF7BklHgA3WoQR6IBgkpsB0aja88bIgBjLtDpfCpF
 isomAhPIr90h6J7Nxhg+OyrBctF/UAXuvzan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729134670; x=1729739470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5xgd/IqNOkKb3hcb/jTZyThiWGmJRroD0FekBsQrPs=;
 b=BlOq3ZTLgzCuKFz2pgACafiatDGu17IwNfeMYgHRkPwWa/IKR//Ko5gQ8y/UsEQhCD
 qYr52AKU8YncoeE+OKuDt4uDmBDgTZ6WbGU6o7twEHlFfj/udXZRyaPnsUcn2aGseTrV
 LbHJ3auSAXpC4PFX/bI51OCkm5Jj57cNHHToj5oZrz6hQUhAJr2mDvsm8Zmxl7iQo3ME
 aQBJbl5S1f0YfaJufydfTnYFqrJd+mtIoH306FQEwWtjiJysglR8XN7l1Z03ldn8NhXl
 5nSP/TDw4ThZPb9/WHHX59wOzC4j22CpFxXJo4ybkXmoAOMvSkNJ1EuOgqCFuYnFkg73
 +/LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAG7GJo7fEAVSeeiWOCynCYK42hS5JLAi2SOQeeFE2mVtoluJmakp0UbPQSBGvoSqQTA+jDHg=@lists.denx.de
X-Gm-Message-State: AOJu0YxkYuWr0Lgq6Jw7x0SrjfTxKAamLRu1vuVW+hGy1s0XuPVqaJ+t
 fIuh9rZxFtHNO4VCfP9vcbz/Xlo8BxgqDdJ/ramlFQO+zRA4KsGJRY/yYFk6ZVc=
X-Google-Smtp-Source: AGHT+IHTM5Ljq1rcwwGMEXYjANLLiTnY4XSpRaYTlL8JDfR+C0cCODe5i7ZSdBQ9mLc+ZVOPOjwW5w==
X-Received: by 2002:ac8:7d04:0:b0:45f:8c1:41af with SMTP id
 d75a77b69052e-4604bc4dd68mr276107031cf.41.1729134670040; 
 Wed, 16 Oct 2024 20:11:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b38ce69sm23226691cf.90.2024.10.16.20.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 20:11:09 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:11:06 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 uboot-imx@nxp.com, gilles.talis@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017031106.GA55137@bill-the-cat>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9c29rE44hImoAhdY"
Content-Disposition: inline
In-Reply-To: <20241011105827.7729-1-peng.fan@oss.nxp.com>
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


--9c29rE44hImoAhdY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 06:58:27PM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> U-Boot device tree is padded just after U-Boot proper. After the whole
> stuff loaded to DRAM space, the device tree area is conflict with BSS
> region before U-Boot relocation. So any write to BSS area before
> reloc_fdt will corrupt the device tree. Without the fix, there is
> issue that =E2=80=9Cbinman_init failed:-2=E2=80=9D on i.MX8MP-EVK board.
>=20
> Move the variable to data section to fix the issue
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/cpu/imx8_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> index 6c0a8c0cbe4..19c65c7ce47 100644
> --- a/drivers/cpu/imx8_cpu.c
> +++ b/drivers/cpu/imx8_cpu.c
> @@ -71,7 +71,7 @@ static const char *get_imx_type_str(u32 imxtype)
> =20
>  static const char *get_imx_rev_str(u32 rev)
>  {
> -	static char revision[4];
> +	static char revision[4] __section(".data");

After my last mail, I pulled up the patch itself and started looking at
the driver. Why is "revision" being done like this? This is not a good
common practice.

--=20
Tom

--9c29rE44hImoAhdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQgEoACgkQFHw5/5Y0
tyzeqAv/XYHwTSmQje0nuVXCrjK9AOpXaK1+LtAxXNuP4443hFxAXhXtfNzH7yw2
SDxgKtCncDZlHN19x59lIdR9BISY1LoHpLYl9JrdiRkGB669cCMjp7tnws6VfPJS
d5alKkZ0HJUHC+YSpyraL+ULHVUtQbcX02UcKB5q54OZhgzDM0WAdm86j0TtEcig
g2GeY2iXD8pqkd8tgYAYTP+dW1FKGgXrmtT4q9atmQvXRd+7vyfiZCaCMIzgMzgZ
YdVnHZi3TOtZZIOIKxW9mteYvF2CKiJ1CE55RmgSkzbogpLt77UAwcrU8Cb3Ze6X
mx53AjYmqfNHvgNm90S34+I7A+iq1NaVk43zhoilFwTYFJS1tpdAPrFv3HM+nMxB
XwnocWs5lGdotiXPJaJ3ePEiJK10tzCYhFVBMB09wpRKkrykG34NF3pSRBLL1fF5
VdlqhjkqRMHMsbZAgWNcCAT1BjBhfzJriCJYt8lHbkzgMomOcn/cHEetRt9j4FUc
wDVWvjLj
=k0Ob
-----END PGP SIGNATURE-----

--9c29rE44hImoAhdY--
