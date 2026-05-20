Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4D5CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447DA844CF;
	Wed, 20 May 2026 15:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+gKvAhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD3F846E6; Wed, 20 May 2026 15:16:19 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE918341A
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu3p4W0yzCv2Dj60rtDOSsBz6H/b1tLoQDuDhF1V81flBS0zS+HIUwWzRXhwNDk8yzpr1dz2ypAYehnXwHikdw/35Jg/i3XgXr9wii3Qo33H0NjMwcN+SK0QkX60w5pTUTuN8CHhNKt91sXalK1aFhLb8hMLWk6BS5McxLVE5lsOdxIwsAP54Fh2l/z9gPzNPEONPqZtJdPa7vb3T1oaZnbdXI1rGFgT7pS5aoQzvdGZBZ8Nz9Ab74//RoBORWf8oQr8DFecpu+kuIRkMNHWTLDX5NgsQCsx9O8aUNRO7XHsD8Pfs250V7xh/jBd6CpJbd/ZHwKeh+q2jOgDga6BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ipReeKLWI8cQCaPHfQNz7GqYoO8welmT4SWqh0lY28=;
 b=FzzSatpUUOuFjCwt7P6lG52zbYRAJlrz8S9IDDJyFftNXr0KVvY8U/xmOZVONHk5/01JAa0y3t4BtcKA/lfwFE4jko00Yaz3BOaa5Q5+Lu+8P/bmMMpmjd8uEW866DUxJF1J51KXdnZG/5kTUm5mbrRXT4cbIbztR2fhmshTx9RPJVK41x2xnV+E57CjNUY0qqPTrOuWP9kMtXmhFsYAV2WxqWGGbIb3FT3L0FtlAsQ2Kj2/5RWT193H+R5UkR63crrLt+ujD3dfpvXh6ovpGNhP8/cacrt8fFyF2/8Vv7c2/xU7Fc7fu3SbwyjlNmlLzXRWI4MOZbnGb3mIhRWejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ipReeKLWI8cQCaPHfQNz7GqYoO8welmT4SWqh0lY28=;
 b=g+gKvAhbbAbTGTieMtcATZxyJ9QCeUw+3lfxJWVpcx2q9q1diIcKCD75zdp6PGdWwrGd/+50hNZMYVuAMkRFmFqhQi/Orxk/p2gnHyMCD75gZl2WUw4Qjuk8sl9MAIz5TC9sV9DpZBl2+cHLc9UmVjwqFkpIWhkZicFadh3JXA2xrnTOlw1iMEkDVVZGOENuH/iPIRUjDowu+xqpTslspBgtDA6iNPsWmkNrF/49UNH4DO5wviLngScGhcrtZQaQlkJx7b5A/qx831bZIskXsaS9O3Bd55Pd01K2wppFAQs5cjguRSweWPBNUX5Aih06kFC9f8twosPauB04mG/gWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:16:13 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 13:16:12 +0000
Date: Wed, 20 May 2026 15:16:07 +0200
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] ARM: tegra: tf700t: Align panel timings with Linux
Message-ID: <ag20A7Ll8oR58P4y@orome>
X-NVConfidentiality: public
References: <20260520091155.44696-1-clamor95@gmail.com>
 <20260520091155.44696-2-clamor95@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jg5k3qe3whw4glph"
Content-Disposition: inline
In-Reply-To: <20260520091155.44696-2-clamor95@gmail.com>
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 79421f95-5778-4dd5-3413-08deb671f6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: 4xaakV0e2S12nQQ9JULIhkbdJPNt2sw6hZ/CEbYCQy3vwkCLOy+gRHHg9GmiRfW1IqtX3Ff6vST9r7Cqe8NA6rwV60+ePzihKFjKHi/Yev4oJNCvURzhlrvDRw3XmVG2hYllOWDmFd55cAEjl72HmijK2LdXlinrAd15/d9Eyb5Un4qyIAvdWJ/bHyVkNcXJKvFzPLrhdVtvb+XBa93ECzfI+AGpzqyUYCXwwMIrDWPm6IVSH5qpoqSK9oqIF2Ui6JdMDtYkXa/mNCHsyck6jkQFtAGZzwe/w3L7/RzfnSxwyB6ljxvtBUxY6H+JBkVGSwtk1GlbdJ3roRAmMDTZNyiAu7Oxu1CFFAFIN+JzmpbhQr+x33bnS6j+e/4NhN8sT2cfa6BK/YnaJMq0g+ew2ABdDC1wYUlbKmwYwxDUJXSQGI2WxtCEwMsOEWQdSiZdsEMo1aGvCxUWbEOeC1sC71D0Ez02S9Nl0v4gd84v39+sawtbJRE+nsOxAN+Nc+emmTYokpnUGCrqHIzjIT++JNrsySjMT1+VggvqKvPRMTHIW5v3+e8WZ7301hfuI9SBtA3+kHtFWuaDz9M8o4ttPh8RP76hxf7lzsJyWh8OBgC2dP6KpYusGWrJH/2EgResk33OgTbBq1iYqpi/JTYqbAqAIxBbfnOfc5wGWGfpYCPGy6fgd4bZPmVX+zxs2QsE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzB7kS9ojdBRylBnNgwUPKKI+h+w4zh1G2SNfufy9/CCpmVq6p0iJ8W1U7e+?=
 =?us-ascii?Q?ddjaSnj6Gt97Y8CKiyLV5Yu7Zjm78QTRcFvjCmgQ9VUH21bf60u31PfqWbBp?=
 =?us-ascii?Q?hyj6XmdngmRnPofhdL6uSxNXQiZgdhcPfxMhvuw2rxb/sxp4xFLPut99bxN3?=
 =?us-ascii?Q?bV3+XEQtPGjVibzBo0GPz10Lvx0Td3ZswoJJdCbpaAUSSmNHEgoS0mgB+rVt?=
 =?us-ascii?Q?wKEExdNasAY7mqjmcc1saIzIyv2uUaO8zQvO2Cbued9vcuPRBVilXmB2DQnA?=
 =?us-ascii?Q?3qczyr7bhVBxtW1OM4xOxlMtYrpVjhodau1Qf/BoVLij48sxZuYsuCXJmxuY?=
 =?us-ascii?Q?gBK+JT0YH2bhaNptY174kimiNcASbdIr7IjupHftv2hWqU+amefY9a1hYPgv?=
 =?us-ascii?Q?zxQJd1mNBsija5hYnWRig1oqfv+BarQkPfVxOLd2KFRIa6WQgCFo6YkQx/5U?=
 =?us-ascii?Q?eD1yC0P7xqZW9V+iyQGDGzTDuUuhlvuquqbqO8HQTUHgOBoWpxU/Q8Jfp6wB?=
 =?us-ascii?Q?22hINNGsRimmxcE+f5q9HcVenYXS2Qn/jEYt30AEmF1UreHSfxfyludRiQV+?=
 =?us-ascii?Q?LO9ViK050RKKweM9XA+hLRYrCiyidu12nLFVwwRKjCObUI9Mh2mAxG/8gcnn?=
 =?us-ascii?Q?jSGvASYdQeSAZ7970BKCnivyz6AR1HZzz1YVhPZ3iiEZ+gPCpIUMJ7Qelfik?=
 =?us-ascii?Q?vdSDEx+wv8v+vsX/EWbug8ry1HvSJViPvwVu5dzRH+dWHT2tlM73njMaJmQT?=
 =?us-ascii?Q?HH550y9oxMhRYKOoOSDi0xMK8zuUj/vWt5Qw8Dxq6y1KkkX6DZ3OtSKwSZDX?=
 =?us-ascii?Q?Z3yebSjgEJX8mqTMV3h5yiBGVvaRKosq1ICMeATgXAJUMgCZhVnbeBZY7Qst?=
 =?us-ascii?Q?6LB97jOLvjWR+1PoUd9xF4BAuPV4FWFewkYcWc3mzaxBS/0sGpPBjmI0ZmLj?=
 =?us-ascii?Q?jNYW1DTjtTMGpVN/PAl9SbrOQvOn3888xVOt+CbSsnFM5mlshPbz+nwnvSgl?=
 =?us-ascii?Q?XzbIDro5jDlqP31iFQaa6YJ0nPUOUCCFuCHgMpO7V8SPFZAsfi5xVSDAzzWB?=
 =?us-ascii?Q?vr3RPr9S0iCyZB9dP+AJMkAxGucvZM1SQUHt/kHfFZ+xKhTrPtOHf2zNTUd7?=
 =?us-ascii?Q?72sP7IhzDYx26iS6UAFqpLdtp2wjwIIbSRjWPzj6Rpo0Ym3PKjAwmv09JT6d?=
 =?us-ascii?Q?YgqaDuq17cebqRblzdmnWPgcMYkIO73SOt/lh3R3zQ20nIZdzOIfihrWi8OU?=
 =?us-ascii?Q?qqJdr0Jn/66zZvhCSiqfyo7nbkdq6Q2ilTSIG/G/buLTepzE1jdTlrQiCZYl?=
 =?us-ascii?Q?N6ziW+DhyzQcmIAoYlaO64W/GR6aGCNYwZ087iTFwlgIqA3lGDDoammgwZW1?=
 =?us-ascii?Q?r12erEiVNeUwo0D9DbE76o0IfQPISqEn75wAAtJ2boQxUEtovzwn44B4nQTR?=
 =?us-ascii?Q?3GljrMccdi+7jDLRqtpPvHip9oZDZaNxHlAVvvuHgUzlpcNzN9D1ZVsbQjVp?=
 =?us-ascii?Q?edQxRWWvDTAtdQLUZ/3Z25iyQVsM/oagStwkxThnASb87B9gR+AQ3nbxR9oP?=
 =?us-ascii?Q?pK7vqCNMDlfwsfqyxf1s74c79NIpANTCwo0N/zbZ1bd8QMN5kfsBJLpKiVkT?=
 =?us-ascii?Q?4aE7C1S8o0cLKqoDqlaPKTcGkT9vvMp56QP9Vne191klrT+2jkY2Hl5Kj01G?=
 =?us-ascii?Q?mLVIM0oXQ5n9sFqG3pGw/G2U022fBQocGKaznk8abW3vBZRwznLqAAtQAkID?=
 =?us-ascii?Q?SVCQVffBrkqkhiptlYzKBKrgSDFKmPEpkFD++IHvqqxb9yJ6LKtAVLzrcQNo?=
X-MS-Exchange-AntiSpam-MessageData-1: h/ZJnWp3TTLbAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79421f95-5778-4dd5-3413-08deb671f6e8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:16:12.6382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skS/DccsHDTcV7jJ7s3gppGO8vEka3iFJW139zsEOvC2nrnEEV2CUMUvZYfhCPRnYrzeNErGayLqDBPCOM1Pyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
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

--jg5k3qe3whw4glph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] ARM: tegra: tf700t: Align panel timings with Linux
MIME-Version: 1.0

On Wed, May 20, 2026 at 12:11:55PM +0300, Svyatoslav Ryhel wrote:
> Downstream timings provided by ASUS do not allow enough time for the
> bridge to set up properly. Switch to the timings provided by the Linux
> kernel's simple panel driver.
>=20
> Suggested-by: Michele Brocco <brocco@perceptos.de>
> Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/dts/tegra30-asus-tf700t.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--jg5k3qe3whw4glph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoNtBMACgkQ3SOs138+
s6E/VA/9G6XlgQcYVtz5xL7QpguJh/LCnjt7JZPetVwB1KBzwFdWdzKllzAl7bfz
9ndgjL03eu2YSDUhArKL8znj7aUkjHtEqS14BsQLJINjaVJ7oCH1VW6h/F36Bqf4
+OlXNGW/xVnt8ThTnNrVeH6zePSPHzQhARGmwH2Dx1piXz1p4NmRsk3qIeF51kN/
7lqAf7l4woIH+INRK6TvoMl80ICQE9tzXBSuI6lRiSnP8wwu+RK7UXt+BHaLtIXB
FSohVVd5XqnYDTU9WGz1r6/1zuq4bvAhtouzsqVL86sxfPN9x8AfAHpW7nG3BADg
R+i+rb0YVt7QaW1Ww4psSQ0lKGgxV6xyT+YDEitbAvafMfGYV27wY1pG70+2D9hw
ialzyKLY0vJ+Yk852Q26Vza+R299I4o/4+juDDB9IwdJnD+5Cx5nALBTtZqc0quX
yJV/JYWjb/raH1FD4WuPmiit6ofTSkZsyS+S9uHwI/GEsm/RsP6h7wYqGGnDuPXA
iztMyVgLjTX0V/KcaelpLAioetZY6zc4fjro7u21xqSZvjLBlmVnREaUG4SJxgso
13ljhxYKgExh2n3OdSurCfOLOhJse8TU2hVYJz29jxdnWh0leGrU9e7exCVm3flY
nyJGsHbUu6Qz/k3B3I+kIhNoyQqKrzUk1EO+vVcSZXpkop6jKmo=
=+sXi
-----END PGP SIGNATURE-----

--jg5k3qe3whw4glph--
