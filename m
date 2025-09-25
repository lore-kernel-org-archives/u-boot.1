Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5917CAC5AE
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 03:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436BF836D1;
	Thu, 25 Sep 2025 05:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FvHHqoUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45BC836A3; Thu, 25 Sep 2025 05:07:46 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CFC836A9
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 05:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jii0F/JxuZnDgslbvCyfUUjtqMnwTPyUf3oCfhH6MnuJyJjlfbvpjsEy8fMDCtKH4EjgDFBDn+9jVlcIWmVBdEIymaMSzLb4Qng6EnGkpUIQtu6FN7SF/H/CMBiZmS5mjfqaS9blq/g/faQ2b5pNlEvUDZnVAUi/zumTMeoLNO/Ywpwl0qsT+zL0aEhRR/VIAYOL5pDyWhENH1blodb55vrJlt21Jn5Osvac1SYlM3clTOfSWXn2dBkzfTPXiFAWkMHKkrPwr21W8mR0QmFpgFgOdxN2JisrTysR763AQl9Kzx1k9GFqHcP5tVu7zmhzL6NI99bq0ZZYftpEMIHVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULBkubVxO85FZK07Dg/cGRGwy9dgCOeWtZGizMJ7EyQ=;
 b=PoBtpx3IcYWLD2BfHw2XnnBOLcrERyRdebHF+IjGbVFEthnWAIXSa/FRaR/chX0QlZN5REF5ghoyOEKAu0yr7dxj7QTgvU9U1CUqqARtp1lyOD1EJ5kOEi3SG3dURsmWGOc4ArWH12ikV3lYJ7a70q1+cFPpPrrYwJAdWPSDBMYH3CKDlP0erbxnRH9WjLzALlGFe7EEuLa2fc00ca3drI2ff+mwVoR8yjTf+ChdffaK5NR1pV82NVYUkvD8BKo3LeIrUQUZCvsunCot6gCF0thcoulwXbz02c8OC/uN4IwdgmhMRctETAg5KMGqCkEnHMEhqGmkcz/GYvGLVSQSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULBkubVxO85FZK07Dg/cGRGwy9dgCOeWtZGizMJ7EyQ=;
 b=FvHHqoUtuszR2iy+ZCGo9guCqmJsxpEPzHI9CuGD0yFpp+0we8Bm5pznYiXFtGKmsrOGxJFHUJTQmGlNXPgG3+yaO2XAhI05rjqxCffiFN891FY9eF3mGc3XYVgDnqtzmYZ8BUvj64fp+OvmZEV90JR8yll7uZDemAr5mc1mkTz4UfkGzwaSYZjoMR77G5Ca+at+jf8DK6bgD8TQ+584MNcbMMt1H1i15zhWi+zSSQBo/+JskqfADhZIPJ768ooDcHVKK/Qz2Hw8GH/fNikIRu/b27o+hwKoy4GqrXxYB5HcOEVTYBTEJGRIxP+2dP6be9v3j7eL6NBGKoYi19phXQ==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by LV3PR03MB7657.namprd03.prod.outlook.com (2603:10b6:408:291::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 03:07:41 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 03:07:41 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Ng, Boon
 Khai" <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] arm: socfpga: mailbox: Remove CONFIG_CADENCE_QSPI
 guard from QSPI mailbox API declarations
Thread-Topic: [PATCH v1] arm: socfpga: mailbox: Remove CONFIG_CADENCE_QSPI
 guard from QSPI mailbox API declarations
Thread-Index: AQHcLCnd4Kz7uvGxoUq/kwuUxnF5ULSjOqQQ
Date: Thu, 25 Sep 2025 03:07:41 +0000
Message-ID: <CY1PR03MB8121CC82A3443D3C47967C7BA71FA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250923013147.17996-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250923013147.17996-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|LV3PR03MB7657:EE_
x-ms-office365-filtering-correlation-id: 1afacee6-4075-4324-dd7a-08ddfbe0b0d2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p555nc0cY6xxIITZgrFPZRbQVuTEPeBnQ23FLwL2q1LVthj2v3c2RGEI5rhY?=
 =?us-ascii?Q?lKjmRpqmZDC4AWf44UL/OiOCSlLsBFfZtxr9yDsyni0oK4dlI/g69BsStKCe?=
 =?us-ascii?Q?MypJCIN8xtZjnQzSJIuqFE7dMett7rh19mnJknwvjVaGxCNfa5/yw/yJ/hhk?=
 =?us-ascii?Q?YeXH8ApT5edvL4XslmeqyE0ieZ1ZhQosIoS/FwhGG71st4+xAqrT4J+2HHJU?=
 =?us-ascii?Q?9Le0ya60NaEsnW/kIWdyQYepe5Qa6zm/q5DhqymoDs4fq0AtKfm2U9JfnYc3?=
 =?us-ascii?Q?5X0+28PjwLwBprPZegJVcvIM2e/il50KcOiccGmvgd9ROcDT90cpfOI3+NS2?=
 =?us-ascii?Q?FpeUMwtPJx2lsrweQPDf2hylcpqSm2PgE741XXIVESEltLmy8bCQ6fMAe8/B?=
 =?us-ascii?Q?/QaALrmqfe6fQSnIn0LC+iZ9PHAH30i0iu7aMIUtTDsI8FIclBhENEZQd2GX?=
 =?us-ascii?Q?Dt7LfzaDCq13qS5Cj05nKuxEn/URJeGudTvzNhvS2b6yp9C/kXo4E7qq0BwJ?=
 =?us-ascii?Q?vHNC6T+imWwTpISt8ffGhNRR3nn2BGc9iGPS2Xm6rx+ZS5ruAmrYsY/R59gb?=
 =?us-ascii?Q?YnqYpJ6d9VfJefzvm019lMXpftwG0qPejhLKI4EiSw0Yegj1iE25pty/C7IK?=
 =?us-ascii?Q?WU+Lg6zgE3CAkMFiBvnvOuZkTmExcA0aNMRVixsKQdp9XLt+ARxIIB4HDjon?=
 =?us-ascii?Q?+u/3Xv9MpylTMSEyjvTTRVo4bw+g1MFUvwDb08oz/ZGAnMlA2JikN9WurPW7?=
 =?us-ascii?Q?2ESfJT9MRFg2aFTDXx5tIFw415iFXYg6mCoiXgKMV6utILAFPLF/e/30NuSb?=
 =?us-ascii?Q?6fUp4cadaLMnArikiDz0MRf4M8hVgYbUv5Zyg6MM98IEAhxfXs/Gq+1wBAU4?=
 =?us-ascii?Q?DFhFiYVXHKHqNtFy1OloGxW2PVvk3G3aAl3RvuWLymWGcrcMcDFe63eVjxfG?=
 =?us-ascii?Q?jMrZ86HXOS+S80wx7dQM+uIyQYFBNmyfbTh0+7Mw8L9Mt+EexSFr36BRgURB?=
 =?us-ascii?Q?dGLwhMxzpFB0S8bBjRmZZupAPAbVN3ljFMwhwkIHQqZ4eyMC2Js5yz2Wtjfa?=
 =?us-ascii?Q?PSFvd6+09GY41prbALnEqxD4xWCtH7YjkQY9qVztyyS7/IsG1x7VAMAPCBqd?=
 =?us-ascii?Q?ee6pTYRPcLAWm8NWkUt0GGA3mpPv5IwEJXHJh49E/5ZhtVOIjh3JPtry4ONT?=
 =?us-ascii?Q?6M9ytPKteIneXaMB79O54EbmHlaTPScGpkKVxzPwruFpsqnpIwxl4l5Cdrdy?=
 =?us-ascii?Q?7QkyZmbRpyWWBFT3RTfCGun9ti5Lnyl9kzvYMmvqkXi3phslcCo0sNs7C3Lh?=
 =?us-ascii?Q?aMPYPhHZv/EI9ikm75cDYoSw02Hlq/xbjj7DCmlZRbFhZ7e1smgPGSyPi3cy?=
 =?us-ascii?Q?gUSW5tyC0V9N5F3M6bC1igLpnGcpRIJPXTYEinFBEg40V0/491e+ptsktKBo?=
 =?us-ascii?Q?sNLjAr/LsqyMFvngNOfHgvYxaYZq8CYBKkQhALIBPepR5ttDQWlHQ5paWsLE?=
 =?us-ascii?Q?yOqeWKN9mzieOz0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YN5yJdX1407nfxt0mdYRAl9pICrKlgUxEiYVgmOmnaKlHxyligcbt7iGOp7B?=
 =?us-ascii?Q?GvIceRYy6F2nK6BLSxQY9NtHt3w4fY4yMQfUR1U6KoszNc/npdUeKidZcA9v?=
 =?us-ascii?Q?ahSw+AhTqnvR5rKZKQoxcYFQefcR41hvfbgmsjjIVtdgta51kqemSD9I5RGL?=
 =?us-ascii?Q?sbWOjiD9DYtnAfilMhTY22qF9i6cGqm5O1BUMpcC1iOUgsi9T9zJDNF8BpQM?=
 =?us-ascii?Q?dE4u1LFbOut/FengCdRVDE5Rp0RavMKZ1vk7MuiReEEaOh6tV+OBLlrhosWB?=
 =?us-ascii?Q?X+W6/+ZJUyIKLRP45RbHUnKpMwgbGeq5M3KqCMdEvfTZwq9YOVRGV64VBBzY?=
 =?us-ascii?Q?EP1+V7vb2/mTyEj/0f8CV91404sFspQOky/bYYuiTn0eC64ODh0E+4Qj6Oyq?=
 =?us-ascii?Q?WAFNkUF8sqI1neVYkSOPQqMoVhEERgFlxv9z7hm8KmKxBQX4ME55RLi9s/Nl?=
 =?us-ascii?Q?gnIV8syiFHydaCcrFTZH4aMBFkIAPlUGkBDpmlSRgPOmgKaNXqmi/m+ejKoR?=
 =?us-ascii?Q?QQZoQsh3NDujuEvVg/T/0nvsg7JlTMsHfrtdF2G8Wwnmz4j53XJiTtcCiQj7?=
 =?us-ascii?Q?WXU+bl7KP96oKF4qEb/bvIGQDqdeDVPsqyrxzp/W0MuwaWKJjN697IqQ7cUB?=
 =?us-ascii?Q?Qjb/G4sGxDBQsfoaJqqTegtLbZNApBgGyRNVMkGYvK2X8TDd3yd8OVKAnRv1?=
 =?us-ascii?Q?EMbCUsFnc8rzueUmjP3mhhFVtD/+t2Og3xRPFsOOGK1P9YutP2xTYWJjzT3v?=
 =?us-ascii?Q?0a6SaniRn9DkLIYIN1yNPxZRITWoESBSY2yVzC8TXIGaHQv+Jg9vRhf7WAUx?=
 =?us-ascii?Q?T3GGyatLvWfCCiFG8Y/bDLQ/lQRWx1pfozsIrlc1OIrvsJCiBiPQYS+dPAn0?=
 =?us-ascii?Q?mHLQNZaf21h2g3PkTc4uy+49w4U7Rh5Apcr/b8RNUdrPOdClKHJvDXTJM8+J?=
 =?us-ascii?Q?Qut0eNMaMiVHnGIgdFJqihdz5Wlwnfj/82pa04SXdTWGaubJ2ckJa72YSLFA?=
 =?us-ascii?Q?BS1yFfZVM2Y4Ez9JZRN2CO0goaDlNK9uKWZFduDSyod763ADRUuKkwaAyiDa?=
 =?us-ascii?Q?NrY3dsWiOe2Kg6rqDwUA3OPZjhq6XhpbM0hisjXOop7Byjgz//FunxVvVPm1?=
 =?us-ascii?Q?tKyk8AEcEnm7d4qoNhJizD1em44FZslqxRCXFBqKAVcAlQRy+0A6ngQSsxZx?=
 =?us-ascii?Q?0cO2JYz8SPcw9/RtLA8V43MFKBn017HML2SIY1NQrW6Rwbvu2O3D3otAz/Q6?=
 =?us-ascii?Q?Cj46fd/cenkQx0uwQZGbwAy/VM2IIYPJP7EQtj6I+S4gD8IJLKt8AmdKY7qk?=
 =?us-ascii?Q?FBiJ1gi8bEPEGEnySJAgl0Wg+8/xIzAiVCLhnf+o4XU9MyxPbUnLpVhgOxGH?=
 =?us-ascii?Q?6KjiS0gya3Zl25hVz5YcmuUV1gZ5VO+Af06/nqextlO+iTyOhY0e8tSv+XjR?=
 =?us-ascii?Q?23TknGNlVNyO5zVJ7n4vmwfhopRbssxbjuE9qf2Z+8g22xI+Ay8CXgRcE8re?=
 =?us-ascii?Q?zewUzRlQKgBoUxPiG67w1aDsNUSxPM3J8S0dlJJxoYfPfU9TnkbytmLsowpU?=
 =?us-ascii?Q?qf6zGtELF6Rg6nTwB0KT9o+41Fw3vAV73EySPnGw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afacee6-4075-4324-dd7a-08ddfbe0b0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 03:07:41.3738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy888cQhCs8Dw+EKRIRgw8OBf/XZCkfbZ1KLZfKbq7r0tkwvurjxuGQ8CEq0v4ZBb0Qh+KT0y3GYCW8SgoYaqZxtrqBP1KzxEEhQ9TxRM4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7657
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, 23 September, 2025 9:32 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] arm: socfpga: mailbox: Remove CONFIG_CADENCE_QSPI
> guard from QSPI mailbox API declarations
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> The QSPI mailbox API function declarations (mbox_qspi_close and
> mbox_qspi_open) in mailbox_s10.h were guarded by CONFIG_CADENCE_QSPI
> preprocessor conditional. This prevented their prototypes from being visi=
ble to
> code that may use the stub implementations when CONFIG_CADENCE_QSPI is
> disabled.
>=20
> Remove the CONFIG_CADENCE_QSPI preprocessor conditional so these
> functions are always declared, regardless of the configuration. This avoi=
ds
> potential build or linkage errors when stubs are used.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/mailbox_s10.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> index 2099c51b682..1a461de4819 100644
> --- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> @@ -398,10 +398,8 @@ int mbox_rcv_resp(u32 *resp_buf, u32
> resp_buf_max_len);  int mbox_rcv_resp_psci(u32 *resp_buf, u32
> resp_buf_max_len);  int mbox_init(void);
>=20
> -#ifdef CONFIG_CADENCE_QSPI
>  int mbox_qspi_close(void);
>  int mbox_qspi_open(void);
> -#endif
>=20
>  int mbox_reset_cold(void);
>  int mbox_hps_stage_notify(u32 execution_stage);
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

