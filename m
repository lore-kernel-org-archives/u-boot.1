Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD378C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 08:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFB2882DC;
	Wed, 29 May 2024 10:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c1wvt/Zz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6853C87C7E; Wed, 29 May 2024 10:23:14 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F438851B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 10:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N95P028192;
 Wed, 29 May 2024 03:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716970989;
 bh=rqqJ3/J1Yoqxp2bJmX8rQrQQyKMVoqVLIqd70FBKRTE=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=c1wvt/ZzIMn2Sr1GfYADrd+pVy30Blb30B1aeTBK7p+9IX1SYk9uKqn769M845Cqu
 kUGMaLNYCCRkdVHp6bqSFrsrquX+c4DPd7Y84GSO35UmL9GXRHthpgHhRLGeecigjx
 3Hwz8CKSmPclIWUc2kE67avJvphWvR4xKF7U7QiI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T8N96R048797
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 03:23:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 03:23:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 03:23:09 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N8tj085377;
 Wed, 29 May 2024 03:23:08 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <c-shilwant@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <bb@ti.com>, <u-boot@lists.denx.de>, <sjg@chromium.org>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH] arm: dts: k3-*-binman: Make default DM file optional
In-Reply-To: <20240529074849.363281-1-n-francis@ti.com>
References: <20240529074849.363281-1-n-francis@ti.com>
Date: Wed, 29 May 2024 13:53:07 +0530
Message-ID: <87fru19gd0.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Neha Malcom Francis <n-francis@ti.com> writes:

> The default DM firmware path is non-optional as of now. Make it
> optional so that users that choose to provide DM via TI_DM argument
> instead of BINMAN_INDIRS can do so without build errors.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi | 1 +
>  arch/arm/dts/k3-am62a-sk-binman.dtsi | 1 +
>  arch/arm/dts/k3-am62p-sk-binman.dtsi | 1 +
>  arch/arm/dts/k3-j7200-binman.dtsi    | 1 +
>  arch/arm/dts/k3-j721e-binman.dtsi    | 1 +
>  arch/arm/dts/k3-j721s2-binman.dtsi   | 1 +
>  arch/arm/dts/k3-j784s4-binman.dtsi   | 1 +
>  7 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index dfd38d64f63..eddf05594d5 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -149,6 +149,7 @@
>  		filename = "ti-dm.bin";
>  		blob-ext {
>  			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  
> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> index ec3bf7ce913..6f82f26bf85 100644
> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> @@ -152,6 +152,7 @@
>  		filename = "ti-dm.bin";
>  		blob-ext {
>  			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  	ti-spl {
> diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> index dea14945bf5..2233921d320 100644
> --- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> @@ -72,6 +72,7 @@
>  
>  		blob-ext {
>  			filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index e8020fec2dc..a524b246187 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -281,6 +281,7 @@
>  		filename = "ti-dm.bin";
>  		blob-ext {
>  			filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  	ti-spl {
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 1514d897634..0483fc5dd3f 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -310,6 +310,7 @@
>  		filename = "ti-dm.bin";
>  		blob-ext {
>  			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  	ti-spl {
> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
> index 46297ebef9e..d121d8c0c54 100644
> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
> @@ -149,6 +149,7 @@
>  		filename = "ti-dm.bin";
>  		blob-ext {
>  			filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  	ti-spl {
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index e4dd6e14a66..146cd7652c9 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -170,6 +170,7 @@
>  
>  		blob-ext {
>  			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
>  		};
>  	};
>  
> -- 
> 2.34.1
Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
