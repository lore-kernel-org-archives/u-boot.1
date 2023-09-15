Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE93BEEEC00
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 19:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE8C86560;
	Fri, 15 Sep 2023 21:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EN2YLzm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3C586284; Fri, 15 Sep 2023 21:02:10 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A8986571
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c0b5f984aso11941877b3.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694804525; x=1695409325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJgC3tzlKCLn+MNM5nmtQAcFmtodGKdPirYXOKeNH9Y=;
 b=EN2YLzm5V0PLGgA3J1MniAbI41HnOTXRikA1I5L2yU7gZX8ayapw9CEsbTmSOPd52m
 OquOezknvvr+FYuEreLVJj86UgftZ9SuN+pKRkOkzeKXpXgpNvYCPRXxJ2BMm+P8PhBX
 Yetrxls20mYHwBPjqq92SGcrwanHwRA2NQloQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804525; x=1695409325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJgC3tzlKCLn+MNM5nmtQAcFmtodGKdPirYXOKeNH9Y=;
 b=nBBDm7rkAOj0YIwuixv31yjcm3V1iq74lOmT+/mg18gY7rrO6W73rYkNzSqq0t0GyT
 P13cscFYR/OiPe1Md1MOCIRml4VM3Av7yaRUNabG3oD3rdzpcLPjqlwtZIgfQbfH2GLk
 g3bBs8TPSSJstpIknLDr/II0VLLisZvT5J6uDKfWVSJHuQkFa0bq5p/3aX7K9/cREx90
 1HxIllHv+DoJrkGVOyjMW/nigVX241xzgiUsDGn0eWyaMuj+3qDl4le7tfI1k2V8rn70
 5FK9Xc/Esbl8oTx60xSbMkSVtZ7JsKfDpsMYYkVIuVSFGJM45nsHtikOmc6tTmerrJT4
 cZWg==
X-Gm-Message-State: AOJu0Yy21lZN2BSbcv3zwhWhQR006iAAJAjh5z61H30JN5IzvYEt2vRf
 8N+ZapuBxfDt05o5prle6daTDQ==
X-Google-Smtp-Source: AGHT+IEFzqbntRk2IfOyIbxMHbv8HCbjhbyvIVJq5/chj207zHZJQgyBhJORBXUqGX9Lu19jBZwdSQ==
X-Received: by 2002:a25:d4c4:0:b0:d71:6b6e:1071 with SMTP id
 m187-20020a25d4c4000000b00d716b6e1071mr2503471ybf.32.1694804524899; 
 Fri, 15 Sep 2023 12:02:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ba48-499c-2259-fcdc.res6.spectrum.com.
 [2603:6081:7b00:6400:ba48:499c:2259:fcdc])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a25aa0d000000b00d81479172f8sm953749ybi.5.2023.09.15.12.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 12:02:03 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:02:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Harald Seiler <hws@denx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v5 00/21] Kconfig: Tidy up some options
Message-ID: <20230915190201.GA2897477@bill-the-cat>
References: <20230914165615.1058529-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WA+v8CuDXxxuddyZ"
Content-Disposition: inline
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
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


--WA+v8CuDXxxuddyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 10:55:38AM -0600, Simon Glass wrote:

> The view from 'make menuconfig' is confusing in places. This series aims
> to improve the top-level menu and also the boot menu.
>=20
> It also groups FDT-fixup options tegether, at least the ones I could fine.
>=20
> Finally this series marks the distro scripts as deprecated, so people have
> a pointer to standard boot.
>=20
> Changes in v5:
> - Add back the Makefile condition, for efi-app builds
>=20
> Changes in v4:
> - Just move these options to driver/video for later consideration
> - Allow TIMESTAMP without FIT
> - Add new patch to drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRE=
SS
> - Add new patch to make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
>=20
> Changes in v3:
> - Drop comment about an update/ directory
> - Drop extra newline and quote
> - Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
> - Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'
> - Drop patch 'video: Move BMP options and code to video directory'
>=20
> Changes in v2:
> - Add new patch to move bmp code to drivers/video
> - Fix FMU typo in the subject
> - Drop now-unnecessary depends on FWU_MULTI_BANK_UPDATE
> - Mention in the DISTRO_DEFAULTS option that it is script-based
> - Expand and rewrite the commit message
> - Use the word 'Mark' instead of 'Make' to improve the English
>=20
> Simon Glass (21):
>   lib: rational: Move the Kconfigs into the correct place
>   Kconfig: Move API into general setup
>   video: Move bmp code to drivers/video
>   video: Move the BMP options
>   FWU: Avoid showing an unselectable menu option
>   test: Move POST under a renamed Testing section
>   boot: Move fdt_support to boot/
>   Move fdt_simplefb to boot/
>   boot: Move some other fdt-fixup options to the same menu
>   boot: Rename Android-boot text
>   Kconfig: Create a menu for FIT
>   spl: Tidy up load address in spl_ram
>   spl: Drop SPL/TPL_RAM_SUPPORT option for SPL_LOAD_FIT_ADDRESS
>   Kconfig: Move SPL_FIT under FIT
>   boot: Make standard boot a menu
>   Kconfig: Move TEXT_BASE et al under general setup
>   Mark DISTRO_DEFAULTS as deprecated
>   Make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
>   boot: Join FDT_FIXUP_PARTITIONS with related options
>   boot: Drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS
>   boot: Join ARCH_FIXUP_FDT_MEMORY with related options

Thanks for iterating on this so many times.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--WA+v8CuDXxxuddyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUEqh8ACgkQFHw5/5Y0
tyzLEgv/ap4MPeatlleGm/yanu5hD3ECopASsSD7sGKo9NSaJpmkap1iQ0Jw2mku
UKNgoCv7r14jxMu7kAUbc8n6zv9yy4ZUORunCkms8bsjnUD333pZ08CWxh5MKXdF
7qDdvNQk+b9ULYBezSW0/Yx/RAgnM+KDoPHkDHaP2KUegYamyWn/vyRh47mL3tQo
1auvyf21dIiQBeqkC5AnltKrtiHsZCycxVdwTULDE4Dw+momkVLfgNDVdXIHcx29
OOgEQEB+omWyYEG5719qFpcY5/b1jcHuI2WZiwfG7WFn8mIr9fpcpWosh2OQyrre
IBfydIj9KTWlTlLHrgCkbm28oxj4qUnMlzuiKi0N0+kOEGPXd9UPdUfzjil8iuIK
TMrgSGqOL6vhT7Haefs1QkaphAMFdlCAugFtVTdTmE5pSY9eDtkADTYpqKhM5gua
qV2/cqBJQb4q0KrWH4X5p/pniXNktiH31dmH83n/vl6ARsN82yicimSJvFd1YwXs
fRCGtGdk
=Bm5R
-----END PGP SIGNATURE-----

--WA+v8CuDXxxuddyZ--
