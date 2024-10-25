Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86184D116EF
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 05:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0429988FBF;
	Fri, 25 Oct 2024 07:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHgysY+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5430C88FBF; Fri, 25 Oct 2024 07:23:40 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C2E88E65
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVN4IIZF3CsSxMoGZ560hE+re90GmmCIqJ/a2ptSHOJY2PxIBkd9TqON7gDIM9A6sQcdV6phOBpuNpEHni8+jLu5ers8rxzUUVVaZ5ojGGxozvbI4xvaDgvJTiIbzA0AxsUSBUY71BJqldbDBDz/DCXxAoMEIqaHRlndJ+A/Jzmzlo1yYG35yFDukeCf8r6AjqDACFgnYX1SjI/ouY11O6T4rBmKgMGhh7Iv2+FAzq0COuG+kDo1EmjCsIr9WSU6opX01x94ANyc6mLSSSChRJ5wQCGWhBp7/d0vC8XSXH68RtzCBICmwWclWaTX83wRFjfO+ubICKrvRMTHmd7HPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtmJFClr8x+uIQ0koc3Bzetiv49UJHzx/n6nY92P5UE=;
 b=hHu7gAY+VzLV+S1u9k/5usmoh/cgUCjXfNiuTjBuC1M3uvPmlD9HRy+hngJdLAm6FNy18dPOOwTqInTWMFD2Euy3dX+sNzRbXJOaYP3d4ySQOSZDxWb/0qfCNOWOJs4W+QdYd5CB0CQhxbHc8Z1d9BTMVsbT0+xaob4Rz1tPQDABlTlNFA6nhOhN+liZYjZPiLyqDMa0pGhls91gud2dhAWQX1Ek2jD3MogkJgwUFM7+G5FpOe36oiB0AixVpaL+xgsn5HuU0HzByVPKT3ykkcdID1WI2bZvnCDUNHl6DmM4AEOjj9EtIqa0v2CIAtgbiReHjM5sZnxDxxuQ19vfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtmJFClr8x+uIQ0koc3Bzetiv49UJHzx/n6nY92P5UE=;
 b=pHgysY+m+ub0IkSy0kji3ili+mFAAPIDvRDHMfEGdIBUTurtnuYcCNPz5oqOaQjAC83ZBjdPiQP1uSCtO6p1hoYcNLKka62SdU3bRuMgMcdZsdneFvf0wllHw88ulkTIk5K4wUMbg+Fkh317oLIF9sPPtEU7/llUcWSkDnA3B6E=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 05:23:32 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%4]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 05:23:31 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@xilinx.com" <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH] riscv: mbv: Align DT with QEMU
Thread-Topic: [PATCH] riscv: mbv: Align DT with QEMU
Thread-Index: AQHbJRHExLf+X4uhxU2LBUaSfXNvrrKW8L5g
Date: Fri, 25 Oct 2024 05:23:31 +0000
Message-ID: <CH0PR12MB52662D50768835B6CF462DDEEC4F2@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <077311f948de84c055ce2529370734b8ce310ad6.1729663597.git.michal.simek@amd.com>
In-Reply-To: <077311f948de84c055ce2529370734b8ce310ad6.1729663597.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|PH0PR12MB8774:EE_
x-ms-office365-filtering-correlation-id: 76f4d9f6-cdf1-4416-433e-08dcf4b52a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KGbd7GyoKbx/ThOZCzn2IKNy51YiYPf6Z3eyKGUTOrm1JRB2THUgynupvgol?=
 =?us-ascii?Q?+yOAZayDYLC2c30Bc68yxuWlHw0QAsk9fgKpXnXio3i31342njyupCpS8aHH?=
 =?us-ascii?Q?HXYQp+8pLoHGbpJ4Nx3N6aQ92orAAip0QKo8PmWMAytGf8yYD1ukECz5zdtq?=
 =?us-ascii?Q?GNLm0F/MVLQ9sF1qHuGHK7mgbIfwy3SmZ/KaNODSL8DxRUKKPCxqqMK3MZVI?=
 =?us-ascii?Q?U7EzYNDOH2soSX9Bt/3Da8/O8ktndTlUUC0PA+B4i4VDGuEN88lxyOSukrF2?=
 =?us-ascii?Q?SriGIdmLlXgMkzX6HMFv15dK+92IIN35JgLZ+q0/Lo6JdhS1WC7NsshNC68x?=
 =?us-ascii?Q?27cjrM0GQ7Z3fDHKIjkbK6K9qJkhURHwwRPR+yg/djsk5pPfFnwTSZqY2Lii?=
 =?us-ascii?Q?vO1GtmnxeIoHdSNT3EYlmxfnVD0thfzfkwIeD20eGXfEzK/8tlSQu4Jo10Qy?=
 =?us-ascii?Q?3aTP0qIREzhP6PaYZ4JebDyi3+JdM7C8/sGNQWUfnekwIuyEa+K5+1DKZ7/B?=
 =?us-ascii?Q?04MbYwaHXPPvQ1xq5iUbS3P7mvpWOIsZ/lHazKjo2LAzee9HjF048EppSZoW?=
 =?us-ascii?Q?+5nlIxWcko8rKxxV1t48xyX1s6eKlm0NvOg3qBZrhQmWiVQsvcvJ/fSTGLc0?=
 =?us-ascii?Q?pwEuA6GmOyQiamWOt/HX5Ef8eOonIzZwQYWH/rX4IdT9k+SI+DVmqGH18DNP?=
 =?us-ascii?Q?EB9QmFmkZX6m4T9xtAOROy0NfJW6dv76nkisESOIou56K1tKMDf8vGA/ANFD?=
 =?us-ascii?Q?8wM4hdXXUdxrl0D+8gdZLCwEMUSJeUzXOUjDhnJahZxpht/YI1AC6h3lmqLM?=
 =?us-ascii?Q?5VlKXCTAHJij8PrVXBdAp2Mc6QUrcUxuyTZggGPDR9ruAxZ1cuNMdzIY4xnb?=
 =?us-ascii?Q?wc1kk4nQAXWd2WnzX0Z+vqBtXxJ+2EDUG3I7iFuxK0Ir5stk403l4MIGyxL+?=
 =?us-ascii?Q?Bq7HQQ2eYR7XDwUPNN+oPl/wDxesR6KxooTk5ysWsfpPVXopdjBMVsACoHPw?=
 =?us-ascii?Q?0emZjfYU3FS7cuYHqYzQvricALj7trtWs+vyPvXaTbqa5FvFaAyMAdda1474?=
 =?us-ascii?Q?tKQRoEjKu9xYlO9F58U6V7nFMn13Edg3F9sXEZY6hpZ7g8lgBUCxXe271Ns3?=
 =?us-ascii?Q?yWuDpC8iZZS3m5oqRo033bOV+U8PXGfwrh3PSvgUXWV4Wf/hvyV4nju1phvq?=
 =?us-ascii?Q?E3hFfBB5NuL1egRQQ3TBzSpecucI71JFpGUDVqJSVDZM5lQLMX+KPwLF+oZS?=
 =?us-ascii?Q?IifHiLWvxPup/DDv5t7wv8ao8J5gpu6tv3wrmfq07GnPi01YL8W9Lg2zwbiA?=
 =?us-ascii?Q?bVHpLD+kvYSlBRMsrQsSZk7RQ7QSdw4Zck5AUOz4fYpxeS9qSur3UEeKVBGQ?=
 =?us-ascii?Q?pGQJg7o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UUuHWbuK++ho8ZCSP3M9YIE2We4dWLIYRWviQW9BfTkACJDN4NLOrbNE5+QP?=
 =?us-ascii?Q?Tm5Lui/w3DWXp3qQQUV28f6SmuGtPH2cWntNsoCo7g5x6FHqnhX+cCEMhRUW?=
 =?us-ascii?Q?N/eTAGiNRMlRtvtbH5UmIFYf7jwfAq2m0Ac1VnqD6rUQTLd9JdLYw23BorvN?=
 =?us-ascii?Q?rWfLdKtWsrZP3UMcPzPPN0BlgBDYHd0r3ccGH2tgO23vXL2PY693u0FxHkRB?=
 =?us-ascii?Q?fKqw2+Y2xvpFtOPxqiVaPqruO3YjIiW2ibHK7A4GfB3JCx3kD8wcCO+kK//d?=
 =?us-ascii?Q?hOiQnp4rvoTrcIcA4MkjPtZIj925+EhQ6ds+Lcy9qlYiGMrj36C4jGbBP2YA?=
 =?us-ascii?Q?VkFMebfdWIo2Lp+v9z8DSzYVeRUssNh4b1I9kMk+bTUPUFXyLMA4Eum3Jnps?=
 =?us-ascii?Q?7aSGwI+c39J1EDjQhPudj8E1esIXbB0/tpehS001XCu6zAwo6j+0WgFBdt4d?=
 =?us-ascii?Q?EByXp7AL6FCRjaXgi+C2WtNK61SuNLlylI2iT92DZLcDjCL65eNJ0whA26bQ?=
 =?us-ascii?Q?INTlAO2pBrMQmRWRHvrYFEIq3iaujUgI0GCUPu0kPFmzCpktqY0vwxqzUhIY?=
 =?us-ascii?Q?/+5IeH6UpzKkWgMySTRFDwuSEKxFVyFr1F5KPwo2JQmUK2LGDFKYIXn/M21B?=
 =?us-ascii?Q?KicdZeWEuCWpO3TY26maDkaFNZR69/k8OX5FP//BK/xGKT3GjoBYc7HwybWz?=
 =?us-ascii?Q?7Bq80LLfLPHVWOYWKdYWRhf/cnerp8DHqTEO/zLSQTepUFRuPAyG61BINgyk?=
 =?us-ascii?Q?IasB23JBVdTCMSwJenqVA13WQTMf2fR6+xCXn9a+hVo4A+gnM1N+ggRsJYMz?=
 =?us-ascii?Q?FQoTRXrgPSS1sfqkBd4dOMieosIJbIt9y1wqXwbVkox7eFmRXDp5bbXj/hYk?=
 =?us-ascii?Q?gQghL3hm6O+oLUdIY9dadiIqakO6dpS5udQr6damFIXbV/zb5GUgJhh/6jaT?=
 =?us-ascii?Q?QPoIv3gUKNOIJSkrmfvHdGEVGQrtLhsJDQ8pKKhBoH/IAeWm8a8bC5j9zslO?=
 =?us-ascii?Q?X9WGfPysy/XulzHtMVFSQtuGaaEso3lhc2j533FlIniaeCn1FRslUJXF4Y9f?=
 =?us-ascii?Q?1l00P1ULrYzQI3TZLj+2EqZIkVzBOrZZbHu3+rCdB9MkZXMj0v4Z96UPVhfU?=
 =?us-ascii?Q?ETmSrs0FltbhMMqCrBT+KQtUWGZiCMTHd+NLvPjIM1lXft2WpcGxjihW+C0b?=
 =?us-ascii?Q?TxKMfMo4iviv0XoBFCMMSKvfEpmKzNlfE/c/IlMubKwx6T1x9V4Ta5bPMhmP?=
 =?us-ascii?Q?xN8PTn9g7JBxxTMmgamn95BVn6j+6ZtOUEIHGfCYCfs4oydSm7+Tblg5eMdU?=
 =?us-ascii?Q?5U7ilJ61h3nMxwWWFWJFSCDYtyvzB2ayniP7YFuIuRUVaCzzgDWN4MXXvdcQ?=
 =?us-ascii?Q?QiMQX1hlJr2Udqo2+TzQxDt32A2ptLSSK7Uo894vTgtR1oRgK6UXdJ/sTTUy?=
 =?us-ascii?Q?jmIo28h6PcTB4K6TxyCRVTdMtMO2dcCrYPD6o/d8kbwgQr840ezVLK219+ZH?=
 =?us-ascii?Q?upuZEV0F0DKPQ8HJK32BmT2UXUk3bYcP03lzmkcS7MeZVCz5+3Ly6B1Vcn10?=
 =?us-ascii?Q?glOSsorJxPM/Pes7ZFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f4d9f6-cdf1-4416-433e-08dcf4b52a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 05:23:31.5817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYhTNOYY7o8eG6SJNQNOgDDH6577NnAk4/6DhbZteO8gK/6RfKtpk0LjdsLMQFRqRYdDTO/XQg8PBItEIZ7Zmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

> From: Simek, Michal <michal.simek@amd.com>
> Sent: Wednesday, October 23, 2024 11:37 AM
> To: u-boot@lists.denx.de; git@xilinx.com
> Cc: Leo <ycliang@andestech.com>; Padmarao Begari
> <padmarao.begari@microchip.com>; Rick Chen <rick@andestech.com>; Tom Rini
> <trini@konsulko.com>
> Subject: [PATCH] riscv: mbv: Align DT with QEMU
>=20
> Align U-Boot with QEMU amd-microblaze-v-virt platform to be able to wire =
it with CI.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Padmarao Begari <padmarao.begari@amd.com>

> ---
>=20
> I am sending it to be in queue. Qemu patch hasn't been merged to qemu yet=
 but
> here is the latest version.
> https://lore.kernel.org/r/20241017072507.4033413-1-sai.pavan.boddu@amd.co=
m
> ---
>  arch/riscv/dts/xilinx-mbv32.dts | 30 ++++++++++--------------------
>  board/xilinx/mbv/Kconfig        |  6 +++---
>  configs/xilinx_mbv32_defconfig  | 12 ++++++------
>  3 files changed, 19 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv3=
2.dts index
> 48ee11549566..4050ce2f051d 100644
> --- a/arch/riscv/dts/xilinx-mbv32.dts
> +++ b/arch/riscv/dts/xilinx-mbv32.dts
> @@ -20,7 +20,7 @@
>  	cpus: cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -		timebase-frequency =3D <102000000>;
> +		timebase-frequency =3D <100000000>;
>  		cpu_0: cpu@0 {
>  			compatible =3D "amd,mbv32", "riscv";
>  			device_type =3D "cpu";
> @@ -28,7 +28,7 @@
>  			riscv,isa =3D "rv32imafdc";
>  			i-cache-size =3D <32768>;
>  			d-cache-size =3D <32768>;
> -			clock-frequency =3D <102000000>;
> +			clock-frequency =3D <100000000>;
>  			cpu0_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
>  				interrupt-controller;
> @@ -46,15 +46,15 @@
>  		stdout-path =3D "serial0:115200n8";
>  	};
>=20
> -	memory@20000000 {
> +	memory@80000000 {
>  		device_type =3D "memory";
> -		reg =3D <0x20000000 0x20000000>;
> +		reg =3D <0x80000000 0x40000000>;
>  	};
>=20
> -	clk102: clock {
> +	clk100: clock {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> -		clock-frequency =3D <102000000>;
> +		clock-frequency =3D <100000000>;
>  	};
>=20
>  	axi: axi {
> @@ -77,30 +77,20 @@
>  			compatible =3D "xlnx,xps-timer-1.00.a";
>  			reg =3D <0x41c00000 0x1000>;
>  			interrupt-parent =3D <&axi_intc>;
> -			interrupts =3D <1 2>;
> -			bootph-all;
> -			xlnx,one-timer-only =3D <0>;
> -			clock-names =3D "s_axi_aclk";
> -			clocks =3D <&clk102>;
> -		};
> -
> -		xlnx_timer1: timer@41c20000 {
> -			compatible =3D "xlnx,xps-timer-1.00.a";
> -			reg =3D <0x41c20000 0x1000>;
> -			interrupt-parent =3D <&axi_intc>;
>  			interrupts =3D <0 2>;
> +			bootph-all;
>  			xlnx,one-timer-only =3D <0>;
>  			clock-names =3D "s_axi_aclk";
> -			clocks =3D <&clk102>;
> +			clocks =3D <&clk100>;
>  		};
>=20
>  		uart0: serial@40600000 {
>  			compatible =3D "xlnx,xps-uartlite-1.00.a";
>  			reg =3D <0x40600000 0x1000>;
>  			interrupt-parent =3D <&axi_intc>;
> -			interrupts =3D <2 2>;
> +			interrupts =3D <1 2>;
>  			bootph-all;
> -			clocks =3D <&clk102>;
> +			clocks =3D <&clk100>;
>  			current-speed =3D <115200>;
>  			xlnx,data-bits =3D <8>;
>  			xlnx,use-parity =3D <0>;
> diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig index
> a3a6f2125770..c52ba1870b0b 100644
> --- a/board/xilinx/mbv/Kconfig
> +++ b/board/xilinx/mbv/Kconfig
> @@ -10,14 +10,14 @@ config SYS_CPU
>  	default "generic"
>=20
>  config TEXT_BASE
> -	default 0x21200000
> +	default 0x81200000
>=20
>  config SPL_TEXT_BASE
> -	default 0x20000000
> +	default 0x80000000
>=20
>  config SPL_OPENSBI_LOAD_ADDR
>  	hex
> -	default 0x20200000
> +	default 0x80200000
>=20
>  config BOARD_SPECIFIC_OPTIONS
>  	def_bool y
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defcon=
fig index
> 3983b20c2d80..7333413267ec 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -2,17 +2,17 @@ CONFIG_RISCV=3Dy
>  CONFIG_SYS_MALLOC_LEN=3D0xe00000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x21200000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x81200000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"xilinx-mbv32"
> -CONFIG_SPL_STACK=3D0x20200000
> -CONFIG_SPL_BSS_START_ADDR=3D0x24000000
> +CONFIG_SPL_STACK=3D0x80200000
> +CONFIG_SPL_BSS_START_ADDR=3D0x84000000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> -CONFIG_SYS_LOAD_ADDR=3D0x20200000
> +CONFIG_SYS_LOAD_ADDR=3D0x80200000
>  CONFIG_SPL_SIZE_LIMIT=3D0x40000
>  CONFIG_SPL=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0x40600000
> -CONFIG_DEBUG_UART_CLOCK=3D1000000
> +CONFIG_DEBUG_UART_CLOCK=3D100000000
>  CONFIG_SYS_CLK_FREQ=3D100000000
>  CONFIG_BOOT_SCRIPT_OFFSET=3D0x0
>  CONFIG_DEBUG_UART=3Dy
> @@ -20,7 +20,7 @@ CONFIG_TARGET_XILINX_MBV=3Dy  # CONFIG_SPL_SMP
> is not set  CONFIG_REMAKE_ELF=3Dy  CONFIG_FIT=3Dy
> -CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x20200000
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x80200000
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_DISPLAY_CPUINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO=3Dy
> --
> 2.43.0

