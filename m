Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EF4C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3092588018;
	Fri, 15 Mar 2024 18:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ohXd+J9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE8588019; Fri, 15 Mar 2024 18:16:54 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3D087CB7
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-690de619293so14090146d6.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710523010; x=1711127810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ll3up3j//uOV26OsWWRgJISMRzMvJsgNr6D/ezEr1M0=;
 b=ohXd+J9qdP0J4esvcg6+5xAXmSpc3khXhpsjq1HrQG5gMnL2tLh3XjrXFdhfbyW4/Q
 DV4LmjxqMs/8Lu9iOwr46pAm/ZJFATnJIC9KsFcBP9MpBcKzsmhxd9C9iv3XRtJ857go
 7RNIx0U86fTW9MoZoG3KdgzCQLVvSoFXy/DBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710523010; x=1711127810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll3up3j//uOV26OsWWRgJISMRzMvJsgNr6D/ezEr1M0=;
 b=lG2me+Dp/eglc1f0GoAPf4kl+c6RIdDT77FsJjl5SieACWCQXC0rV8P9B/zTNukwoK
 LHgGXNV65Ib6tdwl/ySNx5yVV1Q2H9uv4l1E280oCM95cvXNaBAX/e7ARdyuGK6ecBRK
 gzGz2MkvDm+jtF9Nm1yN0XS0YNshpt+okmzQTITk7/QvsDDW48rMc7oec/rTZKrmF2Ly
 +6GmyH36sz36COzrLk/prhciJuxO4EdyHrQ31q+TMewLjCTwLFZkzTJ9StK0DsErcWFV
 B2DgHQsE+nBbLhgKsS9SucwTpwQKpG1+5UKSExVO89TuosyXjZxMlRm0U6czCFUfnlSt
 i3zw==
X-Gm-Message-State: AOJu0YxCBdQUhawaouS0ONt2YXpIWxBU9nJVwE6bhAoymkEf/B9aF2cn
 /fZIWO/osvGGJP5oJq1ZtmqksU2kFrcqW/+w+qii9pK4DS70xzrknsO7gXpQF/yeKR74UsNKSNh
 Y
X-Google-Smtp-Source: AGHT+IGuYVwb7e0ZVMGVi5rCkNgskb5CJkDMW52C/a/xraAXeETNfdGUOx/t8wD4gp4ZF8pxvZnKvg==
X-Received: by 2002:a05:6214:178c:b0:690:d606:1b57 with SMTP id
 ct12-20020a056214178c00b00690d6061b57mr5242231qvb.5.1710523010471; 
 Fri, 15 Mar 2024 10:16:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 iu10-20020ad45cca000000b006914cd7a8b1sm2201668qvb.48.2024.03.15.10.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 10:16:49 -0700 (PDT)
Date: Fri, 15 Mar 2024 13:16:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip/for-next
Message-ID: <20240315171648.GX3442575@bill-the-cat>
References: <20240315005734.1052500-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PbXfnLMKksZU3Hgq"
Content-Disposition: inline
In-Reply-To: <20240315005734.1052500-1-kever.yang@rock-chips.com>
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


--PbXfnLMKksZU3Hgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 08:57:34AM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> This is for next;
> Please pull the updates for rockchip platform:
> - Add board: rk3588 Generic, Cool Pi CM5, Theobroma-Systems RK3588 Jaguar=
 SBC,
> 	     Toybrick TB-RK3588X;
> 	     rk3588s Cool Pi 4B;
> 	     rk3566 Pine64 PineTab2;
> - Add saradc v2 support;
> - Add PMIC RK806 support;
> - rk3588 disable force_jtag by default;
> - Migrate to use IO-domain driver for all boards;
> - Use common bss and stack addresses for rk33xx and rk35xx boards;
> - Other updates for driver, config and dts;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19951
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 20a0ce574d6642e0dfe651467159039fac48cc=
4f:
>=20
>   Merge tag 'v2024.04-rc4' into next (2024-03-11 15:27:20 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240315
>=20
> for you to fetch changes up to 12bc1a5462a22f6dc5b91ecbf092cbaf94e66820:
>=20
>   rockchip: boot_mode: fix rockchip_dnl_key_pressed requiring ADC support=
 (2024-03-14 18:20:04 +0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--PbXfnLMKksZU3Hgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX0gnwACgkQFHw5/5Y0
tyyYnQv/ULGrePiEzNdKhD6bFZbY8D1rIjHBdAYuj4JfkBsUA6+PTg+LVJrT631/
OkA50M1Rk6j3gGzdJ+lgdbcSFEU5ZL/KVWa4HFCDhkdRNo7FcY81EYUnCqS0MZmD
Bv1ALPIwhLuEUHCHJtrAy7PL4ZQlfTdUuFo0e7tGa5/eS4XAB2Mm3S/K+xLBKk6K
HeuP4my7HCQc1fjOkiHNGR9Zhpvspt4PDWveZEcmgrrlFG7XJ9DRMUsRzikfs19s
JYszPqOuiAG9NWFYfMgwLdqHPftm3DmDCzp15kAe4CeQRBj61psO6DmjxXjrpDNx
qOwzRbbXQ+ZlVlrg0vmU7BaSutFl1Tnd2oi6FJIXamwajzz47kkDtKaVHPhRh93w
jCEWoTKrdTaGIAzJmM6hWzEbsvV6C7wSdbzECNHb6nZIQRJlhUMZ6Dcnfs2bE745
0dqX8/vhu92BZSXWhpyKA5C17YqyjXLvibDLWqrTkNyeT0qM/FIZnzrHu46AZuKl
oTtqdgyv
=fi8A
-----END PGP SIGNATURE-----

--PbXfnLMKksZU3Hgq--
