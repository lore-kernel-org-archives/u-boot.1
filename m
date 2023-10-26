Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D71C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794D787B5D;
	Thu, 26 Oct 2023 14:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aT7updkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E193874FA; Thu, 26 Oct 2023 14:47:55 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC5C874D3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-778940531dbso67631185a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698324470; x=1698929270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O0ex5JYYGmXBSsSDcsvFAh3PyJiC1t1r145l3lxaCtU=;
 b=aT7updklVMzbyOyXL4RwVFtTDAdTPJJdnzXP3qsq99mD7kvSCLO0BP2Ll94MQtm1+/
 q4p47epblzhqOeOW5XQBS6IqF8obtlcBAOF7P//oAuvNx/DoftNzhdWq6xt6eco4ZiP/
 IjgqaUQnTzLJd+ohtBilwUQsyunzD10G7KCIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324470; x=1698929270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0ex5JYYGmXBSsSDcsvFAh3PyJiC1t1r145l3lxaCtU=;
 b=ctAxuGUF7TlPCh79otRi7AEae/4ffWTet5UrfPtCHnQRg/Cyt71FBc7hcC5q/OqVdX
 HJsBG89rSBvnaGS3U+n9eGvbECKrpuymeCC4vdsHshIUCp/KqDGTW7nAYlWaBk4j896J
 G+RUZs+yMhIw9CKC/Up7sXy4+be+yAc1+E7b9vtuVYIpC+tBJRJoVrcbuzoaA3hVbI2L
 6IWCE62n3kiLa1+RxvK/61tTmVUYVS0ZkW9wSzmHfOPajVZjk8nMlthjFR2l1OkNiN2A
 y3nxNr6WlEmDeHouqGWyzOsGgrtxq+IlVxwwX2TRjeQyVWfj01V78gLz0FYSJ6fRurMj
 JluA==
X-Gm-Message-State: AOJu0Yxc//C+bvLdCI8NnJi4uoHMR72G6PtVQXybx3ltKTDSh7azrbRd
 1QFaKPOeCahrvJ+bJBbsV9djWw==
X-Google-Smtp-Source: AGHT+IFO+O3n3i9J/LdFdkCUeiqXkQYPI87zloMPbmFpZ5Yoe75T9ypSkAckuVB9ZtAZ7x/b1BWmhQ==
X-Received: by 2002:a05:620a:1708:b0:774:131c:8552 with SMTP id
 az8-20020a05620a170800b00774131c8552mr18076134qkb.62.1698324470593; 
 Thu, 26 Oct 2023 05:47:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 t29-20020a05620a035d00b0076d74da4481sm4964588qkm.23.2023.10.26.05.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:47:50 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:48 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 00/13] cmd: bootefi: refactor the code for bootmgr
Message-ID: <20231026124748.GE496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J5U6vHrd5CVVFaFI"
Content-Disposition: inline
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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


--J5U6vHrd5CVVFaFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:30:39PM +0900, AKASHI Takahiro wrote:

> This patch set is motivated by the discussion[1] regarding
> CONFIG_BOOTEFI_BOOTMGR option.
>=20
> At the end, bootefi.c will be decomposed into two parts, one for
> providing the command itself and one for implementing helper functions.
> EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
> CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.
>=20
> Then, EFI_LOADER library side will be further split into two options
> for fine-grain control:
> CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
>     loaded by U-Boot's load commands/functions or other methods
>     (like a jtag debugger?)
>     It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"?).
>=20
> CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
>     It supports bootmeth_efi_mgr as well as "bootefi bootmgr".
>=20
> As such, We will no longer need CONFIG_BINARY_EXEC if we want to only
> make use of the boot manger for booting a next stage OS.
>=20
> Prerequisite
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This patch set is based on top of Simon/Tom's [2].
>=20
> Patches
> =3D=3D=3D=3D=3D=3D=3D
> Patch#1-#11: I hope that those commits show step-by-step refactoring
>     without introducing degradation.
> Patch#12-#13: Those are not directly related to the patch's aim, but
>     they are necessary to compile U-Boot on sandbox (sandbox_defconfig)
>     without CONFIG_CMDLINE.

I'm very happy to see this. In general, I need to make a v5 of my series
as that will also include Heinrich's patch (v3 of it) to have sandbox
enable --gc-sections and that in turn means that some of the work
around handling unused functions should be easier.

--=20
Tom

--J5U6vHrd5CVVFaFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6X/QACgkQFHw5/5Y0
tyz1xAv/eVTYPxzIyN79XP1wrWEviktuwvAPHa9/BGTurjWcTifLQViZZd6mTH53
k0BcXJ1kNPo26QsF6BeuEpvRL9kfcdYi4C8T6Ss85MpL7sOBAs2wWjyFhXTepJmD
edETrBH5MFQoAPZK3sqIcLCJcQ4nGZTw+1/pZKwr0PyytmDg3wcK8F75cZCIB7G3
XNtLA3cvOv8VQz85zZnwpVFSFuFo00LfYgVlfRPtW4oAP47HSUR3b3yryZSsJ+ef
3p9iZV/xYFiNjLQXoqRmqMUWyKCuLyhkrU+jVCl0y+9vwERAYhuS5+LVCkNXvvDT
LCTAlUoDxf4UIW4jbzH0PKbsbVmwXpOdQ5M47fxiTqzs9SWhJ0Ltr9qC6ouM6o4s
uhcWuAbeRSUEID0eCJakM0BFE1xbKvfKjJR8wGyYr00MJbOuFlsubpFdXNV92JDJ
aCKSptiSe0KEfUEO68uQ/jwAUhWJRuqMA511dPx6098rq0YPM+oHTFDmMmWTEG65
y8mOOWmv
=VMf4
-----END PGP SIGNATURE-----

--J5U6vHrd5CVVFaFI--
