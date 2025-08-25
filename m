Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DAFCA0EFF
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 03:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1A98304F;
	Mon, 25 Aug 2025 05:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OvuNLukv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F5282DA1; Mon, 25 Aug 2025 05:06:30 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926E882DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 05:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da/KX2PUKwjy8emceJcuZDdrWFnZaxoF3xCge7UtCBb+QfQQkcqwy5CHz3II2BfhHc4gtjOQ6VrStsZbtExOxa22858BHUduXgG8IwSsuTovCUBW9Y7XueUQ1IiryLcRboUoKnq0U66MGeDYp1i859Q4NyZcfmZB08V7f45bkfJtliXbaJ1wHHNsYGLdMM2cf3z3l90xm2y71uPWbIAycK62DN/PzJVNRWBCh1JFaPSQYz1woBsl4pV6wTLQ/fbLMoKTFClMGg2u2hRoCIeiZipBgJPtk2udanGddzho7nn4msG6dS9WZOx9IdVtXNcanTPIUNb/LRXy/e3/s83gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhJ+rIarhJfI2zcVuudQhs+FUbuG/dbpBbhykiQnNpE=;
 b=gDKKQNSDv8xIRtIujzPv5pH6wmoONqFeQw1bouRnuig4KwEO0IpWEYMQUUgOWqyOfl+byUUwU9r4eszkPxl82LYyk3AyiTsq2VAyridxW/I4BP4CNEpYSk2qzwQXCPAqc7kOsGMyZuCFKOJkIyp7kNQ4Sq1U90mRbR0mHDISQwGxa4reepeVTUaUzuTjkH+JKFVVpRdFdGCzxowalVv7EB88+FAfjHu4BUp8AQYDTeGtrVycUbWw7r5CcXb4IEmvbftFE8tr2/SkigwxWrSwHAAWotq2wsaqpGC/1XoiyYMnYLfP1t1Pl4ekvOeviT7n2y2X2FM8/eCJ2vmXx9zjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhJ+rIarhJfI2zcVuudQhs+FUbuG/dbpBbhykiQnNpE=;
 b=OvuNLukvHjS9n0I+GQdBJo8Q8n3uZZe7ZMVoiTmL2WqCPQjhBnfnnwuysvd2r6YXQ0jutA8Qh+smAr4wqt9Pv1DsGJpbDBMfGItyabD7Sr9ppzKvoEFpJB5Fxq6XxrUo26WOmTx+nOs8YMvwR0xVcoiYGhLotc5RIq6QpTCepLlvY3RSh8iJfDpPZ9voJwY7L2sxQw4hGRRVZavMO2y7VvJzjR/cnBL82lmaUqoeJevYNLNqVITBg6cU4euZcBskgnHMD2AZVdA/0Jw8tyvFaIhycoGB4H29dKrlHWgFQFuQV/XGUo0DIQK0Zv2Zg/Fj7FkcgVcecD1o6nYGoT1GRg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA2PR03MB5900.namprd03.prod.outlook.com (2603:10b6:806:11a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Mon, 25 Aug
 2025 03:06:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 03:06:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Topic: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Index: AQHcCEvTNZRtdj/rs0qwILI+2bwH1bRyxc7g
Date: Mon, 25 Aug 2025 03:06:24 +0000
Message-ID: <LV8PR03MB81378100F4DD4F43A8F92ADBA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-5-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808100412.9320-5-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA2PR03MB5900:EE_
x-ms-office365-filtering-correlation-id: 1658e0f6-f3ea-4251-bcce-08dde3846026
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PF4fFK04oHXCItelbLkUSvVYR61rYMK7Jf68lZua7I+1V6K1q2hIChAaX+71?=
 =?us-ascii?Q?04J2e6iFRIlNp/rhrti8HaQieIm5xDzsMHvPCHsEknHrHo5HT6j/3ZD1YOXb?=
 =?us-ascii?Q?7YXQM8O8TrLYWH7THbubB96ciqVAmi5ubWDw1botnZO3LFvpCcD2ldG3pzmS?=
 =?us-ascii?Q?EZlCM6sHO2TJCkizcufGO6ywAw/PCYAQcjkrevV08vs3Ty+yHAchfL0ns43g?=
 =?us-ascii?Q?Mz8NUPAlLPk8u7loQDe9MzDzYXvUJ4JJ+YA6k6kl0S/C/cIFyPzqv7uu2iGL?=
 =?us-ascii?Q?8Q5oivA8nIE8uD/MDBzmpEPopC6pX9271zt/ke6CzvcaxWlpKsDPMxUxsi1Z?=
 =?us-ascii?Q?Dtyo0Rsol8cRII0DrT2KHC1JHUzooe84Io0Td72bD7P3HS3SJ+o/8Nx/fjRC?=
 =?us-ascii?Q?QUZK630vrlDnYh43pG7X4qfjpidhs1H4M0doz15zP4mvN1orWwCaELZ2RJWd?=
 =?us-ascii?Q?Y1WWQKbvChTybmpJceGpNX04/ZLz1q7sZR5bxBslVW47Usk7Gof6ZSM2oH3N?=
 =?us-ascii?Q?MXHKQuQEjRIyg3fd9liCce1ftfl7Y2PKL08ToxBUTj854bgMUjldeSaVNXtt?=
 =?us-ascii?Q?PLN6ulsdS9/464Zd837uDNK3klLKhpPqjlnRFiRQW48Eejv/J50BvTagPj9P?=
 =?us-ascii?Q?MmCV1laX9UkAnA9i/RkC2JzKtPkmmdrLK4gze3H15VWNGgjsGZ5Mj6jYng5b?=
 =?us-ascii?Q?wPtIBY1L3XjxGCMkes0Duo1LIBaai+HteKin4B9LonKmS6pwo+4MvEdc3QiK?=
 =?us-ascii?Q?QZiRkoHiAOQ1AfDdIa0tjEzJd4LORX/+P8Jmc5QIRB4RtJSP9OLZ/hHuG0ZV?=
 =?us-ascii?Q?junLU1hDTp5bMBFaff2N3YV8n7kLmlk0zaCvzpe47oAv15+6twg5YhQboUkS?=
 =?us-ascii?Q?lpCoxZJ5F+K56csDYTbDHeV6PTxvWXobJm/OX2TlpJelmB47QQHCipvQYREp?=
 =?us-ascii?Q?2tRsYi0ag+XnwS8Wi6Zf2CR/i8/YNtHS/b2FGm7V2W4EstqyXGsaoBZsYaod?=
 =?us-ascii?Q?2sXnJj6u2zB1K/uQRzWTXYHCn0/1XxPpinMX+Nw00hyZd41HKk6RQdHYI/tx?=
 =?us-ascii?Q?uU8PsvCqFhC8x/NPRgNcMHzRwrHGwcorkG1KYZwTl2t+9J8U698+wiX0xdNG?=
 =?us-ascii?Q?UryQaS6hLs2X8YLG2Y8i+jS+UEBqsQ40iv48ybzQPz/GDH6Rz/u7vi1H8iuq?=
 =?us-ascii?Q?h4Uv0NTXjIeg+NOjlz1wZgM9moLyaBjczq8cpKC2t3uuDrrcMS1cRKN7jte4?=
 =?us-ascii?Q?fPsb0hCEW4piCxwUM86vg4QvZZRU/kySXPygWNG6JXz3+QEpEIwc1IMzlEPo?=
 =?us-ascii?Q?Aj7qDkdA5BHwA3LN9D/RpOrSY+viFtImlsn7IrDogAUXeBnV+h/UO3ej65Vw?=
 =?us-ascii?Q?MdPaUkWdbEyIP5eqOlQmsppubTlcAW9uVa4xfWvJzVm8nc2tc3eUA8yZzkP+?=
 =?us-ascii?Q?gy+F6AunGn3ktQZ6iUrlP9caq3Y9RVdhYYxSpRL/1z8hhzLYJpuyqw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ewlJNp+WM7Nn5FqKgqlRY7dX4uWDny1Uq6KZZMv3RT0E+EbdPS4+LPJ0Rvvo?=
 =?us-ascii?Q?5pUcFUfeO9i4OcRZ3JtSsNq+bfOhQkLUk+y8QT+ZWeuCDiY7vU2GS3LOZFPN?=
 =?us-ascii?Q?FZSSwgIl4VpTobMzS/0wxYZVevArpLnD4eSSjga9tKMJ14Omw4A6x0+WCxy9?=
 =?us-ascii?Q?RrzMPMjZwyuFCEp/woemLVfUxDWSblUvLg6ovZrt16nhe04m0DohN668WL+N?=
 =?us-ascii?Q?VvEeSqAViKyz16H2SSBkdTS3NGyt/DNJ8CgjQ+f4n02OXhSrJ4MqDL/nIugy?=
 =?us-ascii?Q?EckDZ9/jxBCiYvaRwen93hy8+WLd1fIR41UDjgoE+SCWvxP/ceGvPoXtebhj?=
 =?us-ascii?Q?pBLD4r8Q2CbRKkWmC+mTqoz+c3WdhDyzk4ZdQTbPvF9t3ifEn6F7sP2r4OIz?=
 =?us-ascii?Q?H45mr7IAkvx11tX/bSTnz57Ef0iSkOmFKB9Zk4wwVwgg6LU/OpgRiLjZvPP+?=
 =?us-ascii?Q?IVgYRhBkQPnl7ynU7KlSPuJNkDQ5gdi+9938EgKMXBpf7zQDaC9cMpngLxm7?=
 =?us-ascii?Q?MGZqlPtsvCkiuTyNN+N7o4QmNgvQNAHBeMXHif2Op/CfFyUF1amaO5/h8+zT?=
 =?us-ascii?Q?ZHO59cTJIC+/FZ/RTvE1tZD7qr2QHPmhb3mQkPo+oXaOSMsj9NB0XObKzKmN?=
 =?us-ascii?Q?lA7f1X6JHxnhzYeKLAkHNX+H/wooisB7xBf635M3OrQJGExq5tRtZ23Ji+oh?=
 =?us-ascii?Q?2YenJOKT9hIicimRMJSxIgBv3HfPiHhEnR+pAZing071QYwTq1X0VeoIPms1?=
 =?us-ascii?Q?DyEEIhbI6FEAvcXosTwxhdSQN3trSjkWpUjk5N24CeyV7X267w4DP8q1LNrD?=
 =?us-ascii?Q?nRcW8YBsfMNQ31YvaUeNTjbhcoayj8YrNWx+/up0ro5Q5x7hmByMxNbtwBNb?=
 =?us-ascii?Q?xHB5PP912EF2QvXDiz6MQf8+ZTfYitRYE6qgjEtsuH6UP/Q0gnJAfk18H5JT?=
 =?us-ascii?Q?aOCqX+GfQbpSU+vfr8ckFPCNRZ7QSfEc9wQfmzMJakAqoHzVM+TiXSee6fsr?=
 =?us-ascii?Q?23iM+QiFBpzPxn6oWjQLP61QKW4Y3sgyaYc3UBmhoQS88ODNkhOEapa3abxe?=
 =?us-ascii?Q?6mxI/cCvaO+5oLFa9RjpqrH3S30tdJ2MVyQXtwcsffDdefxa1lQyVvp4znnF?=
 =?us-ascii?Q?PfJHe2/WqyxoeICdw6vI3gKMpESpliQw5H2Eb7S6xZR/okpkYiMWbh4i0jCf?=
 =?us-ascii?Q?jHE/pHI0oj9ohBmSkt/F0nxHtaxjFVA+twRwF+1UdNXj79VUFN7ena40l5ic?=
 =?us-ascii?Q?fWBATROXt663K40hx+XNG2jTQoCs6k/praURRlKao6GQLUIFL3B9/lA0xDJB?=
 =?us-ascii?Q?pCuTUei9hTV4ueJ1Egwcy9Ixsx6wn8YDeh7+5vDZLNe5XsFIXa2PbYHszOdN?=
 =?us-ascii?Q?ZmHE7HFJByqpJT/MZj9J56zC8eShlKM52DwbJWfyYg8QJTj7RFTkGXl884fs?=
 =?us-ascii?Q?Se6Wzn7Yp7rGzpKEyMTmKuBYZ8PqpIlrdc2+mQ3Ok7ggOuz20K4nwLLS5MMA?=
 =?us-ascii?Q?8F0+lX2LEH2opdOMAGSAQh2lyPULQS+VkO2fmf4L1jldvvXYZOdafGv8bjTA?=
 =?us-ascii?Q?x08MsPzhF8RQmAL7sxyj6fswsVmPAD/tCdY2se0Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1658e0f6-f3ea-4251-bcce-08dde3846026
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 03:06:24.4570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0B2b8KPNICTrITCp6w8Tz22vmR7BvaqNe4a26S6aqo/gsAPDooD6a5PKoJmLG8tdrh9MZ9Lo7CVTyaDNUXwr5vkcaaCL4kS2hxkDnmb/9/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5900
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
> Sent: Friday, August 8, 2025 6:04 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
> registers
>=20
> For successful reset staggering pulse operation, reset pulse override bit=
 is set.
> Port overcurrent bit 1, which in reality reflects PIPE power present sign=
al is
> set to avoid giving false information of Vbus status to HPS controller.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  .../include/mach/system_manager_soc64.h       | 12 +++++++++
>  arch/arm/mach-socfpga/system_manager_soc64.c  | 26
> ++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index c2ca0a50e35..8a7d47bee44 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
>  #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
>  #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
>  #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
>  #define SYSMGR_SOC64_MPFE_CONFIG		0x228
>  #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
>  #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
> @@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
>  #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK
> 	BIT(0)
>  #define
> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_
> MASK	BIT(0)
>  #define
> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
> +
> +/*
> + * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
> + * Bits[14:13] Port Overcurrent
> + * Bit[12] Reset Pulse Override
> + */
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR
> 	GENMASK(14, 13)
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
> +#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
> +// BIT 1 actually reflects PIPE power present signal

Using /* ... */

[...]

Best regards,
Tien Fong
