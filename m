Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77CC61CE8
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 02:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B819682B07;
	Tue, 10 Jun 2025 04:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nITCuYgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D45382B18; Tue, 10 Jun 2025 04:43:20 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB00682AA7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 04:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egha0bg9aMbzVkUnO4wfBw70PWGMZ8K6QpLXkpQ+5Z4fGbHTfN9rfSjTC1daBy7kYlg5kM9ERIAD3hAJB1P5DxDmQTPw0U938fYfdppDWAZmChg/JbSk8jJqRJdtHdsFKnUshaxWJMeXNIU6PW2MB5fTzeDGQrl8djorhQ94HKWpZYn5ufzpne60PLjyjlyoQ8DRrM23XED8ka21HslhAZ6A7ouSR9iOem+pqQyvQMxEsT5+UFcF+Dq6uZMIVSLELq55SusrDnhaDePWYHzGWxTr497eRITt8BujxU2/12fam0UtnK/XUPIB6RaS5+eaWODA0QJnu0IudGw+/x9mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkYNPz7thmS0MAJIGK9Uf5F/KderWGkA4UdAg89MjWs=;
 b=jXKMUwgtDWsTpDLNkqr/xm3QqxyrNbz2LCox8tdXnlLunAzCM78I8NiqpxIKFRqha/AJ9msBA0KAAumjwEIaB+PzaiKpq9ppIfo766xVERjQP4GKxyAd/mejtNqIjSAsYE+/IjFSdBNNs+FZD2aVsSEc1ujdHO6aascsin9icl2sICA0/QEA1uxaQlfDWrv2bZSKubzgHN/IoRMOp2dnEv5gPKWoLMK3biWFHS/z/x3Z+dstXwrnXP7zuHJKHYopaZn3zmvTiOiYuaaJEAzKGwVfF9uPZiLPAbkgCrCSy5sCStC5BDGc/hd60WJRKVJ0Dvwl5TLH/+Emx6hJSfifRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkYNPz7thmS0MAJIGK9Uf5F/KderWGkA4UdAg89MjWs=;
 b=nITCuYglgdkkt0TCGD6pVxFIao9QHhEduJ7y1E/Jc3cR0frclTdNI5ZVNbEQozsuuUvyYIl2qm1ruv66XOD+38pdWVI6caLtyfkTh69/gqS3btGER7dTT7a8Qfzuz+RN9HlX3BHkWeAVZW9i8xfyGlNym3iG15fwxUpDAows20nAlAAcWYk479tcMJDyJmO5NG/dhb7ZoeDrqFnKklObU4yXHfGA/+WhaORI6cDSBInXTNbItmoO1P/4V14cO5rz7B2p2XOlNOCZHFhAQ3i6kyeLOrB0A5XPhndFNp6QMZyMiPi6MFlUbrK7FVZxlS68rLV6EEer4eW2V23MBqMfTA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB5031.namprd03.prod.outlook.com (2603:10b6:a03:1f0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 02:43:14 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 02:43:12 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Romli,
 Khairul Anuar" <khairul.anuar.romli@altera.com>
Subject: RE: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop
 issue
Thread-Topic: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop
 issue
Thread-Index: AQHb1H5WcHApnh3EGkCpdVfg0SYlX7P7txzw
Date: Tue, 10 Jun 2025 02:43:12 +0000
Message-ID: <LV8PR03MB8137FCCEAD1F63670203F560A76AA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-8-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250603115442.19971-8-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BY5PR03MB5031:EE_
x-ms-office365-filtering-correlation-id: b26014fd-3035-4012-e7b4-08dda7c88b1c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YDCBfG8RT8aaHbkeKDPlfvjCDWofSAxPYtqrV9tjft4TdYzA7UErqpW5AGdl?=
 =?us-ascii?Q?3ZlCNK5o7GOIXmK9Oo1VaCl46XI1feT43ieuEPIQ6kcZi9FcvXaqW2Jl62Bl?=
 =?us-ascii?Q?EseloTCS/I3BG8tbK8XjkJl6xYHDxcmuL76RAMoOWA1mzwoxYUmE8lBDwN8P?=
 =?us-ascii?Q?9N+Ji30emopfOxdzcmnfsqZAg2h/98NtWCLiz6ePiAOtlzVBHIZdHBNsTqsb?=
 =?us-ascii?Q?WPKGRtou+iJkYaoUbFDtvT8g3Jy4jLwwj1qFtcNKz4ZJgERrRgKnwPQl/ALU?=
 =?us-ascii?Q?ghL+C3KYeZ6NRjjvlMVUM+v3CHBiHeUo+QoaLwC3NQCl+XBjlCoVd/7RAbNj?=
 =?us-ascii?Q?E5JNB9hH3re5PTDrJu0K2V4tSIm5dqspCfk4KlvRVivdO3IpqhJ38Mq1op8Z?=
 =?us-ascii?Q?Icr3/62mflMRrQYI6upt9CfBX/ViYsVpKhwp+qGz6/2JysAMQMh0QSLbUbU6?=
 =?us-ascii?Q?W9WL2ns4Ah9GfPxuSztJ80DxU2YF9vzcpADeGXhkUm4rAwKbXQzcu8J5ZGdy?=
 =?us-ascii?Q?/HmVPbbZ+qEuIiokCOelBDhq99VCsIdE0xWKXFSVt1tj1JjGHysJEfUXHqNG?=
 =?us-ascii?Q?rtNTpCcDX0asys6zEUHUx2yKkUBc/pLvTdcTLxWH3rI66QFMGvYcQ0I1pPTH?=
 =?us-ascii?Q?h23csDN30UOLRx3a7QqYnCCfPlw1Z8eZxqC/vBYLwPgloJGzbCwCMbKzBFG5?=
 =?us-ascii?Q?KpXNyn8r3O4CXIknBbCqyClq1Wpt6eVzCEY4L5ZAmypDxp2E/Tvjhg9naux5?=
 =?us-ascii?Q?hNViHYNk+0WNFSIeX+dPL167uEB8zCqh9kZNQPhC2OzWSehpV7zwc+CdFahB?=
 =?us-ascii?Q?JPvfJoDgKUadgNxCIYYdjztWNLHnQ0Eoq7vKhSOCnznCSr9OblW+b9Iyglg6?=
 =?us-ascii?Q?WdnOXbGcuUVkz6uJBPyBgfTD+9TvPlkjGuMrQmTEyePr6NMhYuwpq+BnnxI6?=
 =?us-ascii?Q?ILmshq8SYOTWO2x7rp22zdlwjBh+ZrGFFGJIRMhKt1IWLbXRi7SV7ebQ207i?=
 =?us-ascii?Q?NlmhGrZMSJsoFL/a69LqYO+9p8CqSG5J+jqvW9dDtbTW7tdhIW1xh7rFohdD?=
 =?us-ascii?Q?Ygj528V84hYgdJ9LpfLdms6pfcVpwIQciv9Rj7a8BzJ68+8c4MGT/Z/fFcuE?=
 =?us-ascii?Q?NtINL1rPghbSYutbzwjYYLrCGgjIBGtNARZUSiEMMugpGwrkvsyvx07rOhhM?=
 =?us-ascii?Q?8iFA8SnP/Ff072V5Wx00CfWkrZX4z1aaGaH6La72ga8LbtJLp+CbJzSZK5Rq?=
 =?us-ascii?Q?QHBi1Grs7GkmDOytieMBuU3xrVgELAFXU56Y2GMSt8IHR2vgLvqonaaPZYns?=
 =?us-ascii?Q?NDfskHuAbwIPqiBhJSR3gd5LcCpiQ4zOTVu6qRnHVKuV9n3Thqb78RlxVZZF?=
 =?us-ascii?Q?g8QxdHKF/TkbwUq++hLUze51W2iF9K8IXHwOykJDJmIwzpq6JWBjJmhE9WEE?=
 =?us-ascii?Q?4S/frVpDe1Bs/KkC5wlONPuNzBIcXDrCnSx4DXkCFCXY5Vurpxbc2NKMebIi?=
 =?us-ascii?Q?uCjAdOEr7L0jvqg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ktDEn917FStfeuqAk2ltzHaON/UxicMH+z5Clhx7WAIy9EWnarlUAsG63ni?=
 =?us-ascii?Q?0mvaGuzUJF5YjwpjWPaEaL0UA2cAqHnGC5vvg7qiZgt109db358SnUU0sACV?=
 =?us-ascii?Q?8nS/QIpATolG3w8o7z88znM+Q/2MDeFzX2dxSFvMOROIOFJxWkVNOYYkDskp?=
 =?us-ascii?Q?DpKbOBc3l+XjGkvAbGwO5t4WSJI0ibcjhYadPfnQjnI1kH1gbl7ravEuuYfc?=
 =?us-ascii?Q?x4YajZ5IL7L5ePMH6fDcaofWV0CWW7Sjx6Whd4HmAjE5w7MmmhJ7ll52ckrE?=
 =?us-ascii?Q?5eSeF4D+wXYyafwC7Dw0N/fV/+/9I7fh1PPOkx2vH9YpZHIjTa0t0zh5bhkE?=
 =?us-ascii?Q?KxUeslnk8bHzTQu6MBBDnWEMvFH38HxtjA5IrmZ920Z7FZSMrqbUiXZg5+xi?=
 =?us-ascii?Q?0Et5MlQLGGfryZF8MTFLJf3gkvQ4JvQ5lISciSZe1MxgWYYe1SJS9fUk0NBA?=
 =?us-ascii?Q?XnhS/ZJSCYPVZJS8FeSMa4SwcXDi97FsPQvBx1GRGvPwx68CkQ42v+7XNGms?=
 =?us-ascii?Q?3EH8131foushwzv99jxLkgvhJHk2J/3v43hj+2bDJ8rmWAIm1JhvLXdpE88y?=
 =?us-ascii?Q?MdD1Npdjeq4XuejcADFZujaNYWBEpHVditSx0o9LafTDJYTWSRTFFvNi6BML?=
 =?us-ascii?Q?Aa2AN5NoRgdaFmlw+1PWvchCewbJEsmXPgc37qcX572w7nmSNMliBUUAkmBn?=
 =?us-ascii?Q?0M5qjGNo3f0Uq0bv1W+o4zJPqFLlhVT4ExBeL3qtgTAljJNtB3xdJBzLMc8d?=
 =?us-ascii?Q?LRmbteG6y/6EfKITxtymZKK8Tw1nTbJCN5VRjYkPvy96IjBDfYHFA9I0hDM2?=
 =?us-ascii?Q?tmptqY4YUQM1OjUnQ/EM6yVZi2ywEFCdbAMd8/LL+rrkaYJsTE6iY51KbhEO?=
 =?us-ascii?Q?r02w4ItrvUbPg7PJL/TvokO9Xjw1nrWJHcpUq2MMnSStEcWKnSiqhKtRe85q?=
 =?us-ascii?Q?Az4M80lLYojZF5gxuhOJ+WpzQfg3zOSYpk0m3iUCb7c6EKkxQVka6Xh4pemz?=
 =?us-ascii?Q?3T7EvvY8qbFg+wuon+HxBAA5UEyV9jGqCklfuF96FydtNZrJdqSjdh5N9j7o?=
 =?us-ascii?Q?/8edWFxe0eILR6CcqDyKoz5LNgyeyLUAWcteSeT2ICEhPaOeEN1c4b/7fHCc?=
 =?us-ascii?Q?XYpZ2wxUcDEjVmX7PGEGDSTd+gW2GnYSLdP3dv+6Jj/V+x92raYlm4iYFQnW?=
 =?us-ascii?Q?AxEP55Y0xpqc2VQvxycpddF6E56vSg198oQxQsX+I+I0UEhdS9vRb1hbqEQa?=
 =?us-ascii?Q?DWL90og5XxSvzsc6rKcaqXhX/6/XqbwjYgHOvRL4gxXZPuZOeQWeLJz9q8Zf?=
 =?us-ascii?Q?5uIxd/3bJ7FgSWZQJMs+B0RPU9k5Rz2BEPJlIco6evaocazCIVziNwFIUhPU?=
 =?us-ascii?Q?VKdC2IpY2zSqDjLy8Q6dYMtDFlW3EZaWsLvRxP+i7eIPW8feQCgAuPrX0Zim?=
 =?us-ascii?Q?qRDWIFWlbfuQdgNRgtLv3BbIeL7CS47hkOAy4xCFVpX+kbR39k6jdsJQJMG2?=
 =?us-ascii?Q?fcfqXBJlda8rfFdOxkIzfo2EfWTXe4bh204+6Eu3MCPqbJOg8YcATvGKoTlW?=
 =?us-ascii?Q?MJ8nXE6rd7UxVnwzofLp/PKM89ip44ilbGuO/uBt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26014fd-3035-4012-e7b4-08dda7c88b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 02:43:12.5355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRWW9v4BFDp7WOtbbsSH7Cw1PQDz0fUAVfOtMU1RKbf6zhnR+TmdcIg3hOIwg84QiAjqagZ6qz4KhDO/lm/8qZTA3QmVWsFr4pbi/k8SgjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5031
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

Hi,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, June 3, 2025 7:55 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>; Romli, Khairul Anuar
> <khairul.anuar.romli@altera.com>
> Subject: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop =
issue
>=20
> Hardware watchdog configuration is handled correctly to resolve the SPL
> boot loop issue on Cyclone5. When hardware watchdog is enabled, it is
> reconfigured to make the defined timeout valid, else, making sure it is n=
ot
> running even if it is enabled in the preloader.
>=20
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_soc32.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_soc32.c
> b/drivers/ddr/altera/sdram_soc32.c
> index 5cdf48d2d01..f63360f17d8 100644
> --- a/drivers/ddr/altera/sdram_soc32.c
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -8,6 +8,10 @@
>  #include <linux/sizes.h>
>  #include "sdram_soc32.h"
>  #include <watchdog.h>
> +#include <wait_bit.h>
> +#if !defined(CONFIG_HW_WATCHDOG)
> +#include <asm/arch/reset_manager.h>
> +#endif
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> @@ -51,7 +55,26 @@ void sdram_init_ecc_bits(void)
>  		memset((void *)start_addr, 0, size_init);
>  		size -=3D size_init;
>  		start_addr +=3D size_init;
> -		schedule();
> +
> +		if (IS_ENABLED(CONFIG_HW_WATCHDOG)) {
> +			/*
> +			 * In case the watchdog is enabled,
> +			 * make sure to (re-)configure watchdog
> +			 * so that the defined timeout is valid.
> +			 */
> +			debug("%s: %d\n", __func__, __LINE__);
> +			hw_watchdog_init();
> +		} else {
> +			/*
> +			 * If the HW watchdog is NOT enabled,
> +			 * make sure it is not running, because
> +			 * it is enabled in the preloader and
> +			 * causing boot loop if is not handled.
> +			 */
> +			debug("%s: %d\n", __func__, __LINE__);
> +			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +		}

The legacy hw_watchdog_init() function is being removed, and the watchdog i=
s either not used or has been migrated to the driver model framework.
There is a risk of watchdog timeout during boot, especially in SPL when cle=
aring large memory region.

DM for watchdog is preferred instead of legacy API, you can check how this =
was implemented in Agilex.

>  	}
>=20
>  	dcache_disable();
> --
> 2.35.3

BR,
Tien Fong

