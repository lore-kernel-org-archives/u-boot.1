Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B076EC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F2E831FE;
	Tue,  8 Apr 2025 09:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uUEWFqQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1710E83211; Tue,  8 Apr 2025 09:10:20 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A148A8312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGvqKnn/oE2WNflmjntp6lLJcB6l2YPtHCE0HLGb15MbP6bEkRtMnnNabi9BYOw3Xh1ax2LcdxzwHJuV1j2x1Czg+Fj/oucLPDxffoj05x3HfhU6Yi5LWy24pYxnor0153WR2uTmmElXlZJnY5AUrDn8NeRuGZopGZAIXqoA6eHo50hksSgtXl2ePCB9G32hiUTzG7h/Mb8Mgy6QTz6+l2iF6WxzxWbpKY/+TVUSgRBxdMonQRSvho0eRXHCMGoSP7vUE5nZeVeUQT7WypvcovG9LVka8yECTElKvTRbTxsEWBFvI1hzeTgXTPAiSOgIJ094kdwr8rzONURCv1wtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k2R2XihE1lPGIKWFxJWULU069ixsNskV79h6WgsDsQ=;
 b=LTleCcBmIdDqeY9jAHdNwDMlb4OhfxxgzlNM23eUbchrc6lzyef+k6LssRNgs69sXQUtVeZv9Yl22xRO5pNZChhYPHE9iZsaYPXVdP2zmyK6jcOS1EJR+eB9rlBhfTo+XXYjbPN55VEqxwJWslvCs4l2RT1w0JV3B5tn0+3uo7FiHW07bfkyhtPlwblDf6jSVJODRMqqbjUz6x3mwjXdGzKgeZRODG5RCyxv5oX/Gwam59xoCkCwbfZBOW9UJsAI8hcCQW5+xRms/AqIUVb8cj5wffxUma7VovlBBA9DThdrfExLXnxlPC+dm4Xm0kzaiXWNQnug+7NZ0DmX3lNfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k2R2XihE1lPGIKWFxJWULU069ixsNskV79h6WgsDsQ=;
 b=uUEWFqQIlON6ivWA/W19vEWcw5JVdf4zB5wRz2LHr13j23i5cfzs9w0ch3/5uMBE4Qrk2SawD5bRbXbj7XeH/frjPfOE6h8T10yXiZufwo8ujZ/azon3lk8cd4A+W3A4iCovC1VOJoklWnUoXEsmtcs0DMLL9eiFx1wR+nEGd56vXbmgiQuLQej056zhxjl7/ymMJmBs/iG6oq/7VIi92mINVD34m+g55RaWeULUpCEE2OAxpwkoVT6SmwF8aoD/1hnjdRtUp6TshjmlticGIDZQtHDC8QJkkWNjz2LlrzNBHP52fNkuy0sJvQcJDAPveFx4aRzOq13CQ1+FYJq/WA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN8PR03MB5140.namprd03.prod.outlook.com (2603:10b6:408:7d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 07:10:15 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:10:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Chin-Liang See <chin.liang.see@intel.com>, 
 Dinh Nguyen <dinh.nguyen@intel.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] configs: Enable partial reconfiguration support for
 Stratix10
Thread-Topic: [PATCH] configs: Enable partial reconfiguration support for
 Stratix10
Thread-Index: AQHblNh9rnQ0TzTmikCn+6AwwOuyWbOZgLnA
Date: Tue, 8 Apr 2025 07:10:15 +0000
Message-ID: <LV8PR03MB8137106F3F09A8EC2C7E1E73A7B52@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250314115902.5702-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250314115902.5702-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BN8PR03MB5140:EE_
x-ms-office365-filtering-correlation-id: 297c3de9-128b-469a-5b34-08dd766c6979
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oIbMNR6/dYfO+lbEAWDqc9DW95yv3xCbtOVWgrzpaCwz8r9/0X7xdkxHztPT?=
 =?us-ascii?Q?aEQLI0o5AatcVJ/7ZvSVUAlSR2p1zRP1XfyDQEIug9detJEuTt7uQ6A49f0q?=
 =?us-ascii?Q?cFxW5Y4r/yWcq67Mme43wNyi7Oh7Iz+EfP2Oxn42/KDpVdHfh8OD3KBII9Px?=
 =?us-ascii?Q?U9UEdzsmNMxYMZZ/40Ri4f/VLb6F6Rpb/bJvzBysh03qBPjIKP3TX0DDJtVy?=
 =?us-ascii?Q?0ADMFJkzDnQrcyilPOn1pAQOE2dvmYZA+lE0M92GRERSubQ1JOBxha08x4kw?=
 =?us-ascii?Q?gSbVt/sRd0KBLvIYtASLeCYschsyif273CEJFMJ44bSMS+YVWRwA7Oo1/JdM?=
 =?us-ascii?Q?SxLJgaaYwh7sv4Z/C7VlENX+iCBTlBRQ8uIPlJK9bUbDSguh6brnZO8DF/W6?=
 =?us-ascii?Q?zRMd+cqf3bIQlXJiDwut8U6Ul551Eoalq19t2tQqCkjSFfcY3WRecA+9buYL?=
 =?us-ascii?Q?dRJ0aQQSiQBEAG+wIkuDZyyM0RW3dhNRtvKkTEMiXx0+Edf3WXQWsNIoCGhw?=
 =?us-ascii?Q?SKZuZG/nDcqfwiHb4TjIDGvK2XK7t8/kI1KBsOYpCa+6mkn0/cI/nX02e6yc?=
 =?us-ascii?Q?bbeGT4CqnTbYzkiHBxzJnwmPAvRNJaWyCTF0Ny7DCL4gqi9sIrzcapObbBCp?=
 =?us-ascii?Q?PwU+ILRpVydDts+UBs8h1Bwoqb8L4R/alQ4PBV+mrE5XaV5oXlWuJYJ3eUkY?=
 =?us-ascii?Q?RR/a3gJMPPBIIr2gB53tTXtZmE9X9bp4rAQimVGbEERejBdvdvKQODMO89lB?=
 =?us-ascii?Q?Yz4M88Vad6lVduo93O3mQQ7obFAyy7oNaHNekEIUWf3FTkzlybgx71cq4OVK?=
 =?us-ascii?Q?frynDk+C3EKjgZ6JSeOcUTrPjOH8wH/lM+4U1Ehz3/7ILzF8FdtxccKNQcCy?=
 =?us-ascii?Q?uOMdhLqK7lIw6IE337HfcWg1BAQhRPR+WvPhSESxZsApFsg3bLy/9NsFsPiW?=
 =?us-ascii?Q?mi30+BT3A2z4nIVYKlKrMQFFnIe2WBMRrupMGfnGLp/yqF/3hPN28DK2G639?=
 =?us-ascii?Q?Bf5ij3HMku+QkcufnPcR0Rh/cwbbB0wr4gnYCufEFFSU4G9tJU7N03v63NTM?=
 =?us-ascii?Q?nJisEXobbbnMk6DTTUb84AM6gYiL8ccoLvUcTlrfsMv51xw9+zPvJoYHybPu?=
 =?us-ascii?Q?7gUYrZxlnk3YduQZVmLR3ahYpXPMhQy6cNCxl27sOqxDiaHPf07DcugTvmSo?=
 =?us-ascii?Q?+/K4qGTaSyAPuOmwv0aphM+gBZ49kLYbQOJ7IaV+D1SyMTQ4PC6A19h1aZph?=
 =?us-ascii?Q?hikN/+JWE4xRjQcTFw+Ln/NnvKZ8eV/cC+4OA/0v4kP09DByj/JP4HB17e9X?=
 =?us-ascii?Q?FggwyKkvJDrbeX5lCt2/s5Oqabat1cOr4BwQ5uHmWX57sEo8Leey5hnuHMMH?=
 =?us-ascii?Q?5lJz06wVugRr9ONnM3woqXqeFfvnm4TNKYwif6MGrZFwx9SVMOJAzY8aA6qd?=
 =?us-ascii?Q?jvYm2C1T5XOWoqRFhSgyYr1vxOLnQm5a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3b9rYWyFAqAIUwzqAACGO9Fhf8exPalNd9EXtoOjaxF7uBKn1HyKmWeSiq4R?=
 =?us-ascii?Q?AreHF5ZnO/jP3rfuzeIBKII/+WiBcDmvW8jd61XSuiORvcLrHpX6UUuPEv2H?=
 =?us-ascii?Q?P0/pyDBw/VKhwJ/4d+N8P5WDnhNBwhwFajggkRVvsfTWFHMo5kO3rgNGgxh1?=
 =?us-ascii?Q?o7DXgutZRCshcLMsA1s+Ru7Xtq5eJO9owwKjPShla2ELh5k3WrLbd7XVjhbL?=
 =?us-ascii?Q?uWISzknZrNaz2Ccu/KdMpxxIzS2dwWhuUrQj3cPaTBXqdpF+ud0uiaoyW3CI?=
 =?us-ascii?Q?vo8P0J/T8H739NTdbtv8k2b60S9otVoXp5Hs+C55UnWb9EJwb6nDmAxeo+xK?=
 =?us-ascii?Q?mvjlWkpqfdhQgiDfzB8ATw1V+G2VIgWlLaWDCnOzQXGdX42T4n7UVsfEQMDT?=
 =?us-ascii?Q?bh9cMOs89P90x8yWgzWdGpGeBMqkyZY41px9xoPij6br97ebyeXlJEnHawi7?=
 =?us-ascii?Q?NMJ9SUm1e7UjCwJtX4C0bIXqUjKBJiDD12RXk1FtOYg43O6ik9jBZ3tVteMd?=
 =?us-ascii?Q?bCZZTb+HWZTKSmd1gXfwkPNBs0Lti8jWKgwLcP76RMqdlcQsB8BDef4e7NjB?=
 =?us-ascii?Q?ynB/+HxyPt7Oye7Drivftij02UHO/Mq8SxqTt4TZfjVtBymnM4VUUDMXWDmw?=
 =?us-ascii?Q?7FtDAFaGIQ8fZdCbEL83hRy9TCjkiGmKIJkKpAQsCbTEj+YlRH9dJjPXJxSN?=
 =?us-ascii?Q?4jBrfsh2MvcqHONYtaaxNSb2opPWm8og42z/o193eJlZyi6LtRBUA8LhKjrQ?=
 =?us-ascii?Q?oALQL+TH6HjdkSfWa/GrqUgpBqCNN159ZT61iv/co1YDnZMZK3Sdqhu0HP34?=
 =?us-ascii?Q?IqwZIGkZDltABQIsNXSUeCobXb6SJ+x8Vzp2o0c8E2tZnEVsLA4e6uRHQgRq?=
 =?us-ascii?Q?Z4yd1Ww9XqN7E6sq/BiOP4gj3tM3iwZKL/5TOCGQbx89qYczcBJjoKhhVMJW?=
 =?us-ascii?Q?xQ8Fzts3xk7flFCQhs0SAncXfC0vCmJJ2chLHqAd6S+7ecPGoMNbEf5LezRG?=
 =?us-ascii?Q?ks6MoMsxVxaaHmGL7c8U7oPzoE3T9ToOpGpA/rBawuzWG4GvagvEr7Iq7wfq?=
 =?us-ascii?Q?9wg9EeQOPakc6YPuJvF24yV1NnO4UUs4BbkChue8zjwia8IcPxsikKIg5j3h?=
 =?us-ascii?Q?1uvFSQhXKeitp83SMUn2om1DSe0zRPVEColvzpN1Ozkgu/FcjnXMYrSVzdYm?=
 =?us-ascii?Q?8hjX9jurUjHNx7N40kQ6y2jysPlSQaO/upQMbSeNZahFOIzgFL+3gPDA2cox?=
 =?us-ascii?Q?vsxHkWpRTkbCYz0Sl6cZzhPuz43K0XQoHyDUTgIi+ZW9r/i+B4cu5C8gdfym?=
 =?us-ascii?Q?h36Xesnm5JntQ8j/zOZ20V7Px/YpyyvdJLNRTO3H96u56sPJYRerebK2DwLH?=
 =?us-ascii?Q?olkStWh9KiQxwPDy1Jr+VZSBQpaXiT2OtTdM8me7Fhi2OT7o6iVIpzukcqma?=
 =?us-ascii?Q?HOXoYX+wT2ZwdRQYlF0Diu5fvQCwtgtmNzUKz1pLzWpcLEccSnsJavVFGt7K?=
 =?us-ascii?Q?Cn8in/4D+FeEoPwBynQx7O+XeUc1W9S0r12YTLzzJGX7HRtwUm0h92lIQT9u?=
 =?us-ascii?Q?u2sE0aqMB9giFbBoulVN+gnCdtwCiCsQTTlTMDad?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297c3de9-128b-469a-5b34-08dd766c6979
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:10:15.4434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bbeci9pCy3eZrJV/QyVirmx3s8uzLAN18z3yWwE8HFCF8jI6d3eItLtB38Rzov3yIymZZskABI4nOz8thQh2OzilC4QvfUwysOqBRX1L/BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5140
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Friday, March 14, 2025 7:59 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Chin-Liang See <chin.liang.see@intel.com>;
> Dinh Nguyen <dinh.nguyen@intel.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] configs: Enable partial reconfiguration support for Stra=
tix10
>=20
> Intel partial reconfiguration driver is enabled by default for
> Stratix10 SocFPGA boards.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_stratix10_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_stratix10_defconfig
> b/configs/socfpga_stratix10_defconfig
> index 3ea8259847..ff8a74be48 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -66,6 +66,7 @@ CONFIG_BOOTFILE=3D"Image"
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_FPGA_INTEL_PR=3Dy

Please fix this https://patchwork.ozlabs.org/project/uboot/patch/2025031411=
5902.5702-1-nareshkumar.ravulapalli@altera.com/ first

>  CONFIG_DWAPB_GPIO=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_DW=3Dy
> --
> 2.35.3

