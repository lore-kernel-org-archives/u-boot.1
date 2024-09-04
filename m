Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9CFCA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 14:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE0A88B99;
	Wed,  4 Sep 2024 16:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="pycz8Ac2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFD88876E; Wed,  4 Sep 2024 09:56:11 +0200 (CEST)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2530F88C91
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 09:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1725436568; x=1725695768;
 bh=cJnmqig9074zPV7AJo2pu0U/wBKaLn9r6MR8cxmbvHU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=pycz8Ac285JuwoRF/Fc+B/XfOa/4rvzXZ9A2pemxo4HbEwN9dMxund/BYtmOeeAqj
 CSM5IY8+1dNi7UP6o5hBWNUpDOnutPNXxszGx+afCvR44EgTLYoj6k63zPS3elMtNn
 /SvT4ohOpQzp+eLWpaZUUgZ0pFRM0QbNPPe9inaNBkagFC6OEqDWqb8TYc+17wp0vf
 suXVB7uzeTco7QsRqxLoQU7Mu/6orW5wgPl3BvRjX2/T+yDdfW/3zrgRLKNr919S97
 0/Io3v6SpCWJYpGLqdWvjoIoo2ANyeeKPmPLafVdXuiB8AxOJDJx26ywvVROfnGbWN
 mtGIBQ1lITk5g==
Date: Wed, 04 Sep 2024 07:56:04 +0000
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] scripts/Makefile.lib: do not include
 CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list
Message-ID: <jmzczjiktqhkkafm2vkan3saklqycnvi3cnp2esgukaijhb27t@hzc52xfmf2cv>
In-Reply-To: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
References: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: ebb21d094ff1852476ac16e75fdb6d9951e97ef0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Sep 2024 16:09:57 +0200
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

On Tue, Sep 03, 2024 at 23:59 GMT, Rasmus Villemoes wrote:
>  scripts/Makefile.lib | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index df754d1d9f0..5dfb4b6e46f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -185,9 +185,6 @@ endif
>  dtsi_include_list =3D $(strip $(u_boot_dtsi_options_debug) \
>  =09$(notdir $(firstword $(u_boot_dtsi_options))))
>=20
> -# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
> -dtsi_include_list +=3D $(CONFIG_DEVICE_TREE_INCLUDES)
> -
>  # Modified for U-Boot
>  upstream_dtsi_include =3D $(addprefix -I, $(srctree)/dts/upstream/src/ \
>  =09$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
> @@ -350,7 +347,7 @@ quiet_cmd_dtc =3D DTC     $@
>  # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TR=
EE_INCLUDES
>  cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
>  =09(cat $< > $(pre-tmp)); \
> -=09$(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
> +=09$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TR=
EE_INCLUDES)), \
>  =09  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>  =09$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc=
-tmp) $(pre-tmp) ; \
>  =09$(DTC) -O dtb -o $@ -b 0 \
> --
> 2.46.0

Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>

--=20
Emil Kronborg

