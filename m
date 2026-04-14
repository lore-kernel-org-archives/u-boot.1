Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D5BF531D0
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 03:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFAE8352B;
	Tue, 14 Apr 2026 05:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TO2zPBVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523A7839D5; Tue, 14 Apr 2026 05:01:46 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65D180517
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVxUGA2SkECwDlvhd5R47LFzlztf3zB6QGCwzBkKyO77SxXVwXp4V1mpOYgFcXdSzgwyBT1+kwwrRdJMrbdKbMfKV63a3U59MatV6mYEv/pBCgjy47F5ciCSrY3ctWQD1ltUZtlJibTr8P02Ahk/N2G56xorG+GniId3514Fl7Tck3n1J+nUjtGJzExHV//8FV/exY/EEuNqD5Wzv8W257FREScZ7OmpZyZDKfvaHxFZbOzKXVi2yGWvapfvDEemyI6rfPexcyH/8kItK6RWLwRwZLJe+ibdmrni8osqQ5XJRHDyr043y0CpVRfqjttoadiJKZoPwv4wYjTcxVc4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCuMwS3EooKSmvkd+/BstTRI+6NLooKrnSJBdJjZZUI=;
 b=lJTETnSzxrbOFMguGxa70w5YSM2A7uNq/RiSqOH2PHkrRx7K+aJwOjqIQF5/wj29KtVpVjrJGolHg8otngUV8Ta/of4LGKG9oyJqx5AInjWv/4KjKOF7mwhCH2YZRfro8PgsYjyjUEKv8bWA4dfhHElicCkGQ7QWLM6JfVIP2JWk7u65QJnT34qRXjCEKNzzeOWpE6GgvRj5NaaN7K1apqnAJY88YD153cCQFIe9sEbX7MHT4HJih4FNwd/Ua+WAY+UpJjFLKCfyNVVhdfecNwGEHQekXhvWODeOx2C2jKoqMvzpSPhDP4wTRGwaoBFEplbmIggJpiNL3b1iqxblPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCuMwS3EooKSmvkd+/BstTRI+6NLooKrnSJBdJjZZUI=;
 b=TO2zPBVP/P1vID6vQiyE0LJfl4uWs60FJb/bKcUy7WgMrYMqyIB6j/DwMWb26CKuMScYe9VoVoupqPyPA+83nckMHW4X9L6xWsWSCmDSZz/wLVNs6DBZ9TTmZpztpsfakmxZQklaP1FkW0CwX25nn5y6TU3fVBTsKvlzBG5hLYpIkW29OknHNqydtqn2piQJ+zcXm0YbKSzxVO5Ct2TpwpO9K3RcWpJzdI9jULfEz8vCC2KCstYcK3wjiWc9qeHx29yR5tdXghnZiQmCSZWCdSGg2aa0qWO3385rh7tIRWrDiYzbaPNgwR0n1z68NIONMFG+X0O8RNhSX4wmV8z4mw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 03:01:39 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 03:01:38 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, 
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: Re: [PATCH] arm: socfpga: Remove confusing timer related words from
 watchdog reset
Thread-Topic: [PATCH] arm: socfpga: Remove confusing timer related words from
 watchdog reset
Thread-Index: AQHcphZ151akfoo3CEqN9HwoMyEdsrXeKLmm
Date: Tue, 14 Apr 2026 03:01:38 +0000
Message-ID: <LV8PR03MB8137C7B134EDEAFD87A98A40A7252@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225051911.14324-1-dinesh.maniyam@altera.com>
In-Reply-To: <20260225051911.14324-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV8PR03MB7493:EE_
x-ms-office365-filtering-correlation-id: b80923ed-6da9-4d43-1dd9-08de99d225c3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|55112099003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Hc1YO9LNGgRK4AhflvAIMXmX2wUP/5b6TzHGotKv/aKCvhYnaEMb2t07fw+cWWvaGLVevar1By/+/cT4sfsKDGyZ0JxgrsHtgTFx1nvIbssmxBdlQ1T65hdFlgeMeQ3D/Ar6TTmREM4MulDnHlm/ZHcPYtQeouk78Ws4be7wzFQap1RZoMWy+aHGWM7E78lu5V4B6d5tsbSHeqZE/qa68Km6FDQKCLx4qIEnpcP4HIMb0HGZ10sSX53hz+S+oobKrPq3dDTzK2l0/55YAhR9ddgm4WTXW63RGzb47nYAcsvQF//JtEUm9FY4sQEXsIcnHnrefWJQc2DlZu1D1+9Vos/pX5LaK/GDMxovS9syBJs7iMqhlFbebsAZrSbeFznLEkMCK4nMaiAMeFwyO9tKyUGJKra1gVdJ+YzpfIgyNGy8qHxNFzQ6FHvkaREDmzfq1bXDDK4OH3GycYbunxVQlPkHVycbe1mWggj341s/p2YFhbdmB812xu+UlzV+cBi6LeeehKZKYy96m3GUpw1HP1YOwifHRasYdxrxWXmXRKdPLWrqt3SHHNcejnI3n3bMXuWZAMly5KGmjpAGfiZNxB7lt0TWDXS1g24VR7YTbmCvUJsmAM5qMVwL28h6IINQVBL+ZBMjTW49DwopfiW1EDpbPVtghTuicIwIb5DudBt7aMKdpImZPWN+fe8SUE+68+ygoQbuC8r/JbyMYhuKszooMvJ7UMV02ixPUeMvz8wkxX7RRfaDz+sKNbDf3t+h3vcLg5FWTnq8W72oEopWa6T0n6i0MZ5xXVgbQrxHf8I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cBvOPOL0jtvBZCdLGngGQKFN/jWZq+oeH48Exu6/AKAYpRNZit/0UuNxBO?=
 =?iso-8859-1?Q?vh9OckW4IdMB5UgDyjE/kgsiaSUz2eUqd2RmynWGIhC/5vQZvWb2hePYSZ?=
 =?iso-8859-1?Q?ab38nAdSoPzwzuBOd+t2fQNvqc1BLMfiOIeROFuNb/AQOi3dTDUClW4Y7a?=
 =?iso-8859-1?Q?2hLQeOxW5l6uo/1haoNB35e+2RJGOuEkhSR7PajuTHAoGeJI1v7/93dOdv?=
 =?iso-8859-1?Q?yC56qkmv0XV8E6+Z7LrSH/RrRsJvYaBzR0GUFn7xMX98eC8lAaklknaG6m?=
 =?iso-8859-1?Q?YFvgRSPcQOK2E8ae6Yet94Yr2GoFil3lSrg7Jq7SuBGRiOSvrerUmmr/qT?=
 =?iso-8859-1?Q?RZxIyOc/H9WI/85lnxMuNdTACWKdKvYqBbmkGzGDXT+iLNSOir72E9UfCQ?=
 =?iso-8859-1?Q?RcaYL/5zuhJMhiSAlHHXsQMBhFkG510EDc9e4XPRQtxpUHwZTtqqDEflwB?=
 =?iso-8859-1?Q?4aoKYBEu58J+apK4O6Virsc42eHgSiOmQo4gkU4RBf8POW6gA5966r4Pbt?=
 =?iso-8859-1?Q?G3Ol9LNEclbcuA+AAiQ7Chf18s7vxwPuOMYYz+8MyYaZYiZXaWj5YnEvfT?=
 =?iso-8859-1?Q?WpPm4uvtQAC8aidK3xfc6j1uCw/qmC1agBUPmRgjF8DhuNtEhmhy0/woKs?=
 =?iso-8859-1?Q?2DYyoF76wWl+DTt1p7zkpa5CF5bPrnHUdRyCIWw307M6Xg8kP8cDfoRZL0?=
 =?iso-8859-1?Q?PzqqBLWwUk8CcCV1v6TTBQ7VPThxGUMWiUQG0KckEtAf58TZO91MD1l1GO?=
 =?iso-8859-1?Q?avDeTys/Y/yRLMbpSrqfm/94W9fL+jzt0cbbV7B0frIV7VpAzg2tN4MlEA?=
 =?iso-8859-1?Q?JW5x/7rqapKsYWYcd7CEGMHMCd9ZtxqeLpC8BfHVxmiuKkOmacpX9os+ut?=
 =?iso-8859-1?Q?zQ5gl2noEW8bsi2DQ6fgPDUUbuxTxZp88HituZejoAcly9zqQQYznUNcA9?=
 =?iso-8859-1?Q?Eogu0CIj2mBfmfTL3sAlFCq1LRMPxGgT5ZpU2U0HNtWMbK3vAPctxEJuG5?=
 =?iso-8859-1?Q?+BESR67+B/F9XXfDX4QKnSXrGC8h7w0bis1rOcuEwwjGGp57HAkN5uJuu2?=
 =?iso-8859-1?Q?4msFHNO3gnKTZlqR8cSCdbMS1KCdFrUg29oP3uOjhf92Vn2mVD7LcEUUGd?=
 =?iso-8859-1?Q?p2zRZF0jt+7656rd2iM0gbnL3ItUwWS5CH8AFCsMM+FZd9d8ywgln63IYT?=
 =?iso-8859-1?Q?xKMOlC+YOrzipKAqcz1MEMZ/UakTo62BNTIpGLLbQhebvjg22zz+DZmWo2?=
 =?iso-8859-1?Q?rdxHsKo+RTunr7/vnLaWiqPIRvVpk1QJEPjZzYYjITQK9qBziz9J6ovnMt?=
 =?iso-8859-1?Q?ArHgRbWE2qLCm80SJKWNmTimyWs7wUM+wmy4FFDwLMuD6nIahu+M+IoKyi?=
 =?iso-8859-1?Q?Yu/NpLYXi9FZieBXzCb5yzjzDxMS8KR+m7ztYKWaU6Vgc1VgI5+ZGdEf2P?=
 =?iso-8859-1?Q?Te5iBm18rUFkBLm2Ous+B8F21bq/yRIfk/Bw/9FLBphwOsPhOnrhhc8tMH?=
 =?iso-8859-1?Q?Nzz+fXmuWhBxnXDZ7bveg9VTtRiY713EzPicjsVZBLO/wjrQGllGj6sfKX?=
 =?iso-8859-1?Q?AnyoDdb+RazE7z50vf67gvPaBqThLhnmyCPxn+hn2G1ROppcQd2OMozN7n?=
 =?iso-8859-1?Q?oESwh+77VNS/YSc3kJRX9D71v2JHbyGt/g8k1KXRqRvVzjqw9Xa3eWdmIY?=
 =?iso-8859-1?Q?/YDn5zTkVID97veq3xfQ6o1WOA39CMW5S/qO8mgCHPdw4/SBHknti2RsQW?=
 =?iso-8859-1?Q?VmK5tFBr33HXGDI5k6XJm+r7ykrR0qpWlUYZwM/TDolj4dj/k8C4FEL1x5?=
 =?iso-8859-1?Q?7aS4tSwm/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80923ed-6da9-4d43-1dd9-08de99d225c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 03:01:38.8730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1XYUK/qwgTESIfGWlvBKhgNnwjlyxxBr9DQ+EWIARj12rJ19p0B1rbE+fWECI14n1uThB5n1pwKuBYeymoe69dPUj+D7psBOtaB1jVN8mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
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

> From:=A0Maniyam, Dinesh <dinesh.maniyam@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 1:19 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Marek Vasut <marex@denx.de>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Chee, T=
ien=0A=
> Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.co=
m>;=0A=
> Maniyam, Dinesh <dinesh.maniyam@altera.com>; Ng, Boon Khai=0A=
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan=0A=
> <alif.zakuan.yuslaimi@altera.com>; Tien Fong Chee <tien.fong.chee@intel.c=
om>=0A=
> Subject:=A0[PATCH] arm: socfpga: Remove confusing timer related words fro=
m=0A=
> watchdog reset=0A=
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> It's confusing to have timer related words along with watchdog reset=0A=
> dessert function, because the function is only release watchdog from=0A=
> reset, so it has not related to any timer setting.=0A=
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>=0A=
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> ---=0A=
> =A0arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h | 2 +-=0A=
> =A0arch/arm/mach-socfpga/reset_manager_arria10.c=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 4 ++--=0A=
> =A0arch/arm/mach-socfpga/spl_a10.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4 ++--=0A=
> =A03 files changed, 5 insertions(+), 5 deletions(-)=0A=
> diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h=
=0A=
> b/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h=0A=
> index 26faa628a05..9aacf3e2c62 100644=0A=
> --- a/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h=0A=
> +++ b/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h=0A=
> @@ -12,7 +12,7 @@=0A=
> =A0void socfpga_watchdog_disable(void);=0A=
> =A0void socfpga_reset_deassert_noc_ddr_scheduler(void);=0A=
> =A0int socfpga_reset_deassert_bridges_handoff(void);=0A=
> -void socfpga_reset_deassert_osc1wd0(void);=0A=
> +void socfpga_reset_deassert_wd0(void);=0A=
> =A0int socfpga_bridges_reset(void);=0A=
> =A0#define RSTMGR_A10_STATUS=A0=A0=A0=A0=A0=A0 0x00=0A=
> diff --git a/arch/arm/mach-socfpga/reset_manager_arria10.c=0A=
> b/arch/arm/mach-socfpga/reset_manager_arria10.c=0A=
> index da335f4292c..54ab7b13439 100644=0A=
> --- a/arch/arm/mach-socfpga/reset_manager_arria10.c=0A=
> +++ b/arch/arm/mach-socfpga/reset_manager_arria10.c=0A=
> @@ -108,8 +108,8 @@ int socfpga_reset_deassert_bridges_handoff(void)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask_noc, false, 1000, false);=0A=
> =A0}=0A=
> -/* Release L4 OSC1 Watchdog Timer 0 from reset through reset manager */=
=0A=
> -void socfpga_reset_deassert_osc1wd0(void)=0A=
> +/* Release Watchdog 0 from reset through reset manager */=0A=
> +void socfpga_reset_deassert_wd0(void)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 clrbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_=
A10_PER1MODRST,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ALT_RSTMG=
R_PER1MODRST_WD0_SET_MSK);=0A=
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_=
a10.c=0A=
> index c20376f7f8e..320e090e57b 100644=0A=
> --- a/arch/arm/mach-socfpga/spl_a10.c=0A=
> +++ b/arch/arm/mach-socfpga/spl_a10.c=0A=
> @@ -266,8 +266,8 @@ void board_init_f(ulong dummy)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 cm_basic_init(gd->fdt_blob);=0A=
> =A0#ifdef CONFIG_HW_WATCHDOG=0A=
> -=A0=A0=A0=A0=A0=A0 /* release osc1 watchdog timer 0 from reset */=0A=
> -=A0=A0=A0=A0=A0=A0 socfpga_reset_deassert_osc1wd0();=0A=
> +=A0=A0=A0=A0=A0=A0 /* release watchdog 0 from reset */=0A=
> +=A0=A0=A0=A0=A0=A0 socfpga_reset_deassert_wd0();=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* reconfigure and enable the watchdog */=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 hw_watchdog_init();=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
