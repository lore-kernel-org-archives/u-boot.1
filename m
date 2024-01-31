Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B6C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F04887B8A;
	Wed, 31 Jan 2024 13:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ly+kKWaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFD087B8A; Wed, 31 Jan 2024 13:27:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DC187B8F
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706704030; x=1707308830; i=xypron.glpk@gmx.de;
 bh=lII/2PINeaySkGW5wCgh/TcDmJlN5SHUAm3sp+u5Yyo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=Ly+kKWaR+iL1ZpN6Tek+ssBVCsv1kWiUvzY8Z9N9RW67q7hKpXHfqZVk+3POKoiR
 whfZOGZQ5F+iIF44EjykOwGxczJg+ts56AwFFXso2pXoUsIwGaBRtIC8GANp4spaH
 4gMZ4G7EqTDPtvc9psn/hMNDmhILHEBgbvxMgBlNGVaKMMNe/Idtn/Js0I6OY4dhH
 yiS7fbNl+oAK96Zqb2wFEsfMJwfbNL1fEtYZRkgqRPQtQRpEnnJ77Nx1f0Cxy7Y5d
 94Jhlve5h+svSFGpSaQ1bUjcz4DVFAzc6EBEALcnpa8+KhMjtx45jqMJ0DbBG8A71
 e8VzkcmRHx+ebs6kZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1rTlpp1LFX-004G9u; Wed, 31
 Jan 2024 13:27:10 +0100
Message-ID: <73fa55e6-bf78-415c-a8ce-01405fbceb51@gmx.de>
Date: Wed, 31 Jan 2024 13:26:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] firmware: psci: Fix bind_smccc_features psci check
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-2-o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240131111217.30124-2-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wszUbr/VeX0KlPZLWp58Y1CZ1r2sw2OvasPknibvnincMGLWynL
 SNUIRIP3vOKvd36ERVeUzwjccanMiUeSYkb2TCt/Krypl/OrkNH9sFC1G5LfAKLO43brrk4
 6p/keHdgzyRrVB/zNkrQeoxKk5jXhG7vAoYR1Uy1mQX1iJCQfkAr73MLE18+v17vNxmE85j
 H/XvQGzSJGa9ywve/vQEw==
UI-OutboundReport: notjunk:1;M01:P0:FfxsuuyRzMc=;BE/kggDAEI4wbbNUeg4P7DVvMpw
 9SB2mulRoWgoiLmltdM+SIP6DkAYzEl26vlM0PGLJn8mTDaYTZjbG2cBsA/WRqp7+Zf1dka6+
 3wxBe9g1UsLPvX+tqDewGRhuCjDDOnW4IfenY6M2ChPCiixSq65OgKadIjz4Y8woLdJT5z+yr
 x87JKIw+kTMq1k6oCXppIJrrhccTuTdTOZlapX1Lfy83jRXdLXvVJHH+AEl0MUcnBl0GKEtIC
 J9LBerGdp2zKHM4Uoi7NsInI7UqpO3CKUAoUwkrjQ2e/7PbPYxN9qEZR7k+wIfB5wWp06thhN
 J/cm8KKLjSs+T/3hNm2JkYz3PVg3L+T1DQrHKhIGA2Gg0XSvr5IuBJEVqLKFo4dYXcm4oWStI
 UBl/GLnEgzLrO5QM3totr03QVTszSfAxVnnFV18puux/HBxVSovq/KY4xH6uvqM25xA/5Urug
 jBpqWHTyDPvc2Blt7+u+696H9xL9bhi69oymif5TinjWRmLWTNPSnt9+hyMVBOWibP7GRqiMx
 n9GY7hK8d/uTru0zJYPl41dWdS8NssuNWKAmblMO9ZxzF0QVm/cE2C36Y1qqaRSJUOZ+d/pqc
 SOVIa9GxPoD9jL6iVhW7hKTM8AUPcHJFKfn6qDCymuuOoqyP+h8DeBoFt5Rj7TuUs3YRVBh1b
 HWiaMZj1HAhLKsr3QUrOBOECae/ghccS0egTvSehMMKhIg7nnt1xILKszw89SZmGqkgldquWF
 0RKB3V9IZ44ROeYJYkqz5BBhs20PX71FuODoob/XSvlF3a0LbGbRxZ3TqY0WUu3SoezhCDLn/
 OPiO80P5EqcC4UgbJHMZ9rV6RqWPrNgtOg/95GeZ9nuQuXVWDx3tz87cELX5QpKhqIGIdZGpT
 uJm8+4bQ84g7SdwQFRv2y1C8swj0mQ/7ha5cwbWYuyLseIPXH2SZ/wu62YD26XbBidxBWG0A0
 lKlPsQ==
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

On 31.01.24 12:12, Weizhao Ouyang wrote:
> According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
> whether the SMCCC is implemented by discovering SMCCC_VERSION.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
> v2: check SMCCC_ARCH_FEATURES
> ---
>   drivers/firmware/psci.c   | 9 ++++++++-
>   include/linux/arm-smccc.h | 6 ++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c6b9efab41..ed701cd1e4 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev, =
int psci_method)
>   	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) =3D=3D 0)
>   		return 0;
>
> -	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> +	if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
>   	    PSCI_RET_NOT_SUPPORTED)
>   		return 0;
>
> @@ -144,6 +144,13 @@ static int bind_smccc_features(struct udevice *dev,=
 int psci_method)
>   	else
>   		pdata->invoke_fn =3D smccc_invoke_smc;
>
> +	/*
> +	 * SMCCC_ARCH_FEATURES is MANDATORY from SMCCC v1.1, but we still rema=
in
> +	 * the invoke_fn() even the SMCCC version is v1.0.

This sentence is a bit hard to understand. Did you mean,

"but we keep calling invoke_fn() even if the SMCC version is v1.0" ?

> +	 */
> +	if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSION_1_1=
)
> +		return 0;


Why do we leave the function for
invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) =3D=3D ARM_SMCCC_VERSION_1_0
despite the comment above?

Best regards

Heinrich

> +
>   	feature_cnt =3D ll_entry_count(struct arm_smccc_feature, arm_smccc_fe=
ature);
>   	feature =3D ll_entry_start(struct arm_smccc_feature, arm_smccc_featur=
e);
>
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f44e9e8f93..da3d29aabe 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -55,8 +55,14 @@
>   #define ARM_SMCCC_QUIRK_NONE		0
>   #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
>
> +#define ARM_SMCCC_VERSION		0x80000000
>   #define ARM_SMCCC_ARCH_FEATURES		0x80000001
>
> +#define ARM_SMCCC_VERSION_1_0		0x10000
> +#define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
> +#define ARM_SMCCC_VERSION_1_3		0x10003
> +
>   #define ARM_SMCCC_RET_NOT_SUPPORTED	((unsigned long)-1)
>
>   #ifndef __ASSEMBLY__

