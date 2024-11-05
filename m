Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1531BD1CA38
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617D688EDD;
	Tue,  5 Nov 2024 07:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QHiQHZid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF81E88F77; Tue,  5 Nov 2024 07:48:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C59D88D35
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 07:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730789267; x=1731394067; i=xypron.glpk@gmx.de;
 bh=3eZSoaTpnSCHigldls42oW7vyu3BR/q8FerHTLdX7RU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QHiQHZidlHe8v5LKm8YoXS4hQoS72N5iqnMkmrvCy6lVmL4scdsp7NWzewenhnwi
 CvrHJD0udvJOilFskh0RDjn2ZZJbGMiC4+EBW8PuNIeI3++axIoLpSso/DzUpMlsJ
 j0NyRA0Q8ABc8Cep6scL04CePyhZukJfeLYMQWL6oclDz3DfPYFOFv98uvOwu26T3
 MzH1f4MUE7gSiny5Z6h32651QEm4LUtGo1E+TlvENjjcGM6vRSzfDWNky06ep+tyk
 aSnToKe1FS9BaG3rcaPLFeD+etdmX1D2s85aAE/Bt9/Xk5tKVMDSTNOW7yYsEVqHJ
 qvU+GFuLI/pVGx/JJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1tdN2m3pfG-00kBMx; Tue, 05
 Nov 2024 07:47:47 +0100
Message-ID: <e0ee937c-5e73-4055-affb-2a6314608c87@gmx.de>
Date: Tue, 5 Nov 2024 07:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
 <20241105034328.56439-14-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241105034328.56439-14-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aIvsCaY6pHifBip/5JktDsWx4pbn80cpB+VFX1mfWB1n5kOrBqr
 KDiPhjDHL6XzHmfTNira50vP5xj1DwHa+CgRRvI07symVv/5dPvJqhuPEEMzfWCqTwIbY94
 rKCTuBxUByB5c4MPP09JfPXZsLcDNgQ3sSA9Jb6Yn+gZdcsXu2Vx2MsNUb3/xjMHUWaVDKw
 s2JM62HSJZ8sp20EzqH3w==
UI-OutboundReport: notjunk:1;M01:P0:/HTMVFSVZUA=;hrhbS3HDW+tad1wcd+njDqEdlj2
 jrSzk4KJlQ4SPlOWNfWxXaGE1+sa96zCTVjMy4L6P+jckpBS8xFuxf86XJBj/My/19xQCfWKO
 Vwj1OK8mJVhskhooKI7dB4Px3iN5V1bMnABW9PGJ66ofBeU+Bdn/3JDbX/3+L1HNYtPbQwDHJ
 IWQ9N4p3QV7hzzOpINy5a1tK1cTlAXYhsqfP5zZ29+3bxU1u6ba+AsauYd3LQEIXVxiEX1mGo
 RjA+NL+8ET5KO53Oc0RgJdPYwrWRdEb1CxRQ1yrWh1pRoxzAFW1n10leOVWDdPJt+ej5rqMA1
 xKnjj4jZdxkke9+Q+oa6Y/zAdoB6PXeLfHY3axBQtG2oC2lNxuBBOGg5SCc6gi/908n7SzoLN
 b9SzgnUtjkh1YspcuMCWYVVl4DSlRJkPPhGW/kplD3UyPuXj4LVKyFy6O1HhU607uywfSLf+H
 LktkEjDKD7rY8l6G88YtzYSZZd2RtKzS0eqTcQF/ztwbGdwa957t4vRHXz0PsshngLaga1oWM
 rWkkcznU0JfLHUJnVo3U7lmEmKc6pRoskgmyyGiHRSlA5mefB1dz8XvbhHbU7/kmdsXOhkKb8
 j0gUVyFG0C2Pi3mioQRW5PhZ3WaujdWjhHk62JJOPGB7pGrSl/MFV5XoCNvGM2J0PryuGdofP
 Dhb3Uqpe3nkZGv8On02y5IfOO0rrEcDmozzA6Id4UbQJF2MXatNz4JZW83Gjm1NI34UnKv5iy
 BvluUcfoL1Pe56RxCwNcHxCmMrWmHuEEHNLwjJIAbZt+9GeVPb6NXZsqFrSpRfmx9TZBUxKfE
 BiDH7XY+WogpGcUkepKHvDMw==
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

On 11/5/24 04:43, Hal Feng wrote:
> Get product ID and PCB version from EEPROM, use them to select
> the correct DTB.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   board/starfive/visionfive2/spl.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfiv=
e2/spl.c
> index cf7f39d5c5..4396583026 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -113,7 +113,28 @@ void board_init_f(ulong dummy)
>   #if CONFIG_IS_ENABLED(LOAD_FIT)
>   int board_fit_config_name_match(const char *name)
>   {
> -	/* boot using first FIT config */
> -	return 0;
> +	const char *product_id;
> +	u8 version;
> +
> +	product_id =3D get_product_id_from_eeprom();
> +
> +	if (!strncmp(product_id, "VF7110", 6)) {
> +		version =3D get_pcb_revision_from_eeprom();
> +		if ((version =3D=3D 'b' || version =3D=3D 'B') &&
> +		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
> +			return 0;
> +
> +		if ((version =3D=3D 'a' || version =3D=3D 'A') &&
> +		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
> +			return 0;
> +	} else if (!strncmp(product_id, "MARS", 4) &&
> +		   !strcmp(name, "jh7110-milkv-mars")) {
> +		return 0;

Hello Hal,

I have seen

Milk-V Mars CM:      MARC-V10-2340-D004E016-xxxxxxxx
Milk-V Mars CM lite: MARC-V10-2340-D002E016-xxxxxxxx

Obviously here they got the eMMC size wrong. Milk-V should have used
E000 for the lite version. But at least they provide a correction
procedure in
https://milkv.io/docs/mars/compute-module/update-eeprom
and confirm the usage of the values MARC and E###.

So here we should be able to detect these two boards, too.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +	}  else if (!strncmp(product_id, "STAR64", 6) &&
> +		    !strcmp(name, "jh7110-pine64-star64")) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>   }
>   #endif

