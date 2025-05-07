Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2154C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 09:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4BC81F32;
	Wed,  7 May 2025 11:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PVgbzA0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66D1820EB; Wed,  7 May 2025 11:40:30 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3845A8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 11:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5479eMqk785458
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 04:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746610823;
 bh=gR3Pb/i0oELbBaRdTM8nhOJla9E18jmO/silAvkN25c=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=PVgbzA0A5EsHU3Jl/kKTWnD9byUU754O3SWRn5mYkRuY1ZYzkEG4JZNoBOFR/d8zn
 acux3JTyh4CrreIpbBPU660CbMItbWVWVnwM7Vwbx8G32ozUOFEQkZpdyNErTCvlv6
 2OBbG2k44Gg2+rMMp0c8cQ2ZN1wPo9ZdU4YSydA4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5479eMTJ030951
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 May 2025 04:40:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 04:40:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 04:40:22 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5479eLjo062810;
 Wed, 7 May 2025 04:40:21 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 7 May 2025 15:09:59 +0530
Message-ID: <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
From: Anshul Dalal <anshuld@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>, <afd@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com>
In-Reply-To: <20250506104202.16741-5-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
> and used by R5 SPL to boot the HSM core. By default, point to the
> firmware for HS-SE device type. This needs to be changed to point to
> appropriate firmware when using a different device type.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> None to this patch.
>
> Link to v1:
> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>
>  arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>  arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-=
binman.dtsi
> index 73af184d27e..9c8b29f53bb 100644
> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
> @@ -273,6 +273,14 @@
> =20
>  					};
>  				};
> +#ifdef CONFIG_K3_HSM_FW
> +				hsm {
> +					hsm: blob-ext {
> +						filename =3D "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
> +					};
> +				};
> +#endif
> +

Why do we have the hsm binaries pre-signed? Having a common binary like
the DM with signing using ti-secure might be a better option.

Regards,

>  				dm {
>  					ti-secure {
>  						content =3D <&dm>;
> @@ -306,7 +314,11 @@
>  				conf-0 {
>  					description =3D "k3-j721s2-common-proc-board";
>  					firmware =3D "atf";
> +#ifdef CONFIG_K3_HSM_FW
> +					loadables =3D "hsm", "tee", "dm", "spl";
> +#else
>  					loadables =3D "tee", "dm", "spl";
> +#endif
>  					fdt =3D "fdt-0";
>  				};
>  			};
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-=
binman.dtsi
> index cb1fbc65923..7c8e580a8a3 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -159,6 +159,16 @@
> =20
>  		fit {
>  			images {
> +
> +#ifdef CONFIG_K3_HSM_FW
> +				hsm {
> +					hsm: blob-ext {
> +						filename =3D "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
> +					};
> +				};
> +
> +#endif
> +
>  				dm {
>  					ti-secure {
>  						content =3D <&dm>;
> @@ -194,7 +204,11 @@
>  				conf-0 {
>  					description =3D BOARD_DESCRIPTION;
>  					firmware =3D "atf";
> +#ifdef CONFIG_K3_HSM_FW
> +					loadables =3D "hsm", "tee", "dm", "spl";
> +#else
>  					loadables =3D "tee", "dm", "spl";
> +#endif
>  					fdt =3D "fdt-0";
>  				};
>  			};

