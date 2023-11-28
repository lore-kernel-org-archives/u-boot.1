Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7128CC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 18:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF05877B5;
	Tue, 28 Nov 2023 19:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KNr9E46W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC01787759; Tue, 28 Nov 2023 19:21:29 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F017F877B5
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 19:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d226f51f71so1768077b3.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701195679; x=1701800479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WkH2wz0IKADiOfopvlIzPrhACAUVDApPJh1rrubWYxE=;
 b=KNr9E46WLYQDnWrhOnjvnoCA3D/VRQt1ao/aZoeZsf1+KXhmjGAHlOnMhq5f+0oVk5
 QtNVKRCQatgBfqtWiiqdGVgstnqaAJZzl2njT9HGRH1qL8r8Dhl+crwg+tDoPUuQqDzz
 1jKzqW97uklI6+3/p5iHesk+8Eei8BKsjZeo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701195679; x=1701800479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkH2wz0IKADiOfopvlIzPrhACAUVDApPJh1rrubWYxE=;
 b=hNU4pknOy7x77E/ArzR+ePObglAkZVnL0S1G/BxfxI4NM/Cy3BvHfVWIvQbfy4belc
 i1fM/LkGh7t3/xugWf13MjLS67PO2Rh346Smaf0O87wjKXwtDzN/NO7mASuMqGwBSdK8
 g3RCbBvEe82jfo2HMT08/PPPObbJ5DHgtLTLcpGlg61hb4fqGR2I1ofx2RMoCJ/Bmcmf
 FbJiu1v6buuFZz/v/Sg7izLPUOpTFdO0n8Vzo7tWgZqBWxjAVUMD+kSWaW7Kq46rCn/c
 6SIXwfrEnXQoDhW/urRm1Z6wQl9ARO9qjxjScjnlTb76q4/f3/W1jZmHTwq4WaNegMcq
 /eEw==
X-Gm-Message-State: AOJu0Yzjl2KdrUUaWLCLDILAgQcvR/gHtaCwcfuQQCteAcHFEPBZwtp3
 q3zW/7G+FyNcEBACe/Ono2Ih3Q==
X-Google-Smtp-Source: AGHT+IHsORqh15t+acJ0YmgrNQXl/WkYkK+pEEMhiA5y+oTXW0wg+F2N7fM6BX3mlu9x7W6kXz7p1g==
X-Received: by 2002:a0d:e5c7:0:b0:5c9:8366:33b2 with SMTP id
 o190-20020a0de5c7000000b005c9836633b2mr17950504ywe.44.1701195679487; 
 Tue, 28 Nov 2023 10:21:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 u64-20020a814743000000b00582b239674esm4074480ywa.129.2023.11.28.10.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 10:21:19 -0800 (PST)
Date: Tue, 28 Nov 2023 13:21:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH v3 31/32] bootstd: Introduce programmatic boot
Message-ID: <20231128182117.GA2513409@bill-the-cat>
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-32-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vs053lj8MeJakqXz"
Content-Disposition: inline
In-Reply-To: <20231118210547.577026-32-sjg@chromium.org>
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


--Vs053lj8MeJakqXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 02:05:19PM -0700, Simon Glass wrote:

> At present bootstd requires CONFIG_CMDLINE to operate. Add a new
> 'programmatic' boot which can be used when no command line is available.
> For now it does almost nothing, since most bootmeths require the
> command line.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Overall, this seems fine. The only ask I have really is, can we think
about how to handle both this case and the case handled by
cmd/bootmenu.c in a common fashion? To me, one is "show a menu of boot
options, based on env variables" and one is "show a menu of boot
options, based on C code" and the "show a menu of boot options" should
have a lot in common.

--=20
Tom

--Vs053lj8MeJakqXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVmL5YACgkQFHw5/5Y0
tyzwbQv/U3FD+HwSn7CfpYPuuaGCMpDyiRYQsZR2IuY1u3T8seJAHITwdCEAjcOD
MvmD8N8sNKDKa50UOyRlP2IKAkpPbNoetImDlu5tgalNNfWxq3Cx5fWE5Oia1pOK
BGWKT+8iZvNmtfwX1u9QEmdWGU7jw49KS8uhK2Rmc6w3buFsAwu/k21ObSUB0Ic0
3KKuUejsOy0Ec2WBC8TC0MueHWWXfexnZNhcAnaxEH/ceBzbQAzkhcVb01odeT+Z
SFIwDFJopaEr1yFVtXleTARO0084ya4PqWtpkPMcEkAnhF7hkcxtSj3T3Dpvy2UV
gfnY4mNv/XQkxjZOqXMnFZK0ryx6sR08RMRISPD9Gy64NLzIkDxjBnPw4uOM8Rwh
szgo50S4WXmo0o6pbZkdOYaCyQ2C2z6VavEiBxyGm9G2BEGTX9BeAgjdwWglZgJL
qhQZNSWJ1VYDxeVEiMEqOHGmq/qRovLxNSIqVe2LGHxT29Ak0RvJhV0vBxqrBy4i
DQp919N8
=2ysU
-----END PGP SIGNATURE-----

--Vs053lj8MeJakqXz--
