Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE93FF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD3D8426C;
	Tue, 28 Apr 2026 05:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CjipjeqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1110C84119; Tue, 28 Apr 2026 05:23:44 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 515FF841DF
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mX7eqZ5H9n6/EQxELNp0pjbpXf3JayExx01JWnJcC54qUmzW/vlvP+n3bTW1u6kPYI7ELr5IyePGe1hdd9b7Xn1XeYMaxVqQ1cgetR5r1rApdMPsmMhZIW2hJBmBXyIr9q8sML2vMOmyxEdQszf42ddF9Kl6S5UfwUyAfDX0MzeiEwRbDRdA2EyR7+ArydQnyZKnYUMmd0/ztqDzJvRiCmf8T9/naGy/jfd7F7/OlOJakgV+8YLpuxNt384epWRrAoQL8aH0+u5BcuZ47bjgQLTkw+WyeXxLqWk0buYlu6oJBImRdr6ix4314TJ+K+nfejkx1+UipGuioPwAIMuMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2OO/Tv0Xm+pbNytCkDVGGSVthz2B6WKRFw4+ssEWBE=;
 b=kUZsZQS1qL8WmA5StxyHHUM7FfYGN3K+0hc3N6ITZM29d0+0wZ5SVFDogOfUYSjvR1+/Ihdddkq7o/orRE/rDn6PxqE+ymtUg4X4BC4KWo6D94KjhyNOpvi7MsyoNsUmmk/utHwyoi/6PvIByhBM7lc4pmDtzz2CRMLZA0wp+UNgGYWm9z0K1MUJL97tcluVO3ZVOAuaQJwL4O4PBHBsPCsW4wqQC1NygdmbHpzts+DWEeuhoDXDGjVd2oBFrrPegwrNCNVOQtnnJGY1E9XTogsx/3mbW/Lf7B5V3t2SdLi1cP8zAsLVQdlL54Jm/7i8aYFVl62CLjJF5G7CFlwz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2OO/Tv0Xm+pbNytCkDVGGSVthz2B6WKRFw4+ssEWBE=;
 b=CjipjeqJZ0QVWu/t0j1ilm0HjVTKnS3rbo+MOZtAAkfNVHEdwUuocuP9AKYFZuI6I4fM+tQMkx9tHPr7VOF/L4SMRprF0aGTootD2pE+koHplSiCE0OLUQaBfmjWnhsl2Jurhx32gJnBUz38Q0u1W1stqJOP5Ll57y5ucPngoBhxyCds0X/zG7Mu/KS0Sxnr3ATE+XIStq0XAhFUoVK8RaE3MzUOS8l5kmrOozWC5HkGt2zJlOoqTT6KDSkFC46gHciqe308eyPH/0uKmZ6KBebxV071OpSY2QkkV+PGkYFWcsW8WXSiJdkC+7atJ6QEDm+I+sPl3oO6hE8d1ZJsLw==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5266.namprd03.prod.outlook.com (2603:10b6:a03:22d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:23:38 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:23:38 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: Re: [PATCH v1 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
Thread-Topic: [PATCH v1 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
Thread-Index: AQHcwxExh79YBJW2LE6qx7t21H8gvbXpWU2AgAL19gA=
Date: Tue, 28 Apr 2026 03:23:38 +0000
Message-ID: <9ce0f5fc18174720b5dcd257d25e241d382e4863-6fbe-4099-9175-16728f13c94f@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-10-alif.zakuan.yuslaimi@altera.com>
 <c895a993-b7d7-4951-a45e-14078e56f366@altera.com>
In-Reply-To: <c895a993-b7d7-4951-a45e-14078e56f366@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-clientproxiedby: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|BY5PR03MB5266:EE_
x-ms-office365-filtering-correlation-id: 15dd7937-09b4-45dc-9132-08dea4d58a22
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: KaOsv7aPCs/oyk6Og6fW2yPQP3AbpfWZNoStMZTp1A0DslhNaiCYn/+17B7QqUIFts4joDXw0ZgnHOp7yQLicFuOqBm/PLV3oOuFYES6f1GXmeh4cXGrGsUPlzUv8QJBYGaPQA16phQP5ulPFB02b2XwPG9/IiNakj17MaL7IXxHPM0f35CMCL1rlbHRWO69jYiGa4brfCNkPpEoOOp0f93hBV0dK4tsCEIadMP7+0PMBoActWPBMUzbue5DwyUqb0GezxMZzDLLxMSuAeoi0WTZU97q5rcMpv8mCrkM762cPOFlo8qatB8Mp0KjAVym3mgFolVoCfSNeKY5BV/Dsbhn8EEqDzbWL9C77PWalkC65G3qi9T+e8l1WXf/vJyvHqTn+Kv2LgRvYSifaa4gZ9LU4FQIkZ5ASFm4noMnjrIAOoY08TgS892mWGTzku1Ry0RpE9iypwmXfnHByo50mYkU+KlWpjgDKwwVUx8DDSNdHsXBCdsbKVUk2T8nZlfcsNRGRtlCEbVdxhZCsEdbUtHPD6JSjmbXSiPZz/u0gR8Uqd6RxTD08fBZArHlirPFP+hCjGTIjQWKiREHi05Jy7chh9SGN+6Ah2hTkDtMZWGP9NEJ93NiyRWnXIyzllDW3YnXMg8ILiVqdIF8sHsOG53v6+o51KgUE216uI1I/bOsdsCrycoLi1KfzcIkYzrWamsU0zs1CjsMwZL6exDD1hbJzj7EUiWl9787Ziq1z7P7wJNXTH00xehvMlsd4tPNYqBySSPjbsyw8g7YtV+0u/+wXgVVVsYqr0LPrexbZKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fwc4eTNRr9tBTjH+1WX4AZXCzSEOX+rcZFaVpZNaoFht3iueZBksGgKkoO?=
 =?iso-8859-1?Q?+Um1TmD9MXnq1cDCAOFlkziXaSbK7M6UqKEO/sS6ioxXZOU+XAE8uDqOwL?=
 =?iso-8859-1?Q?PrMl/BGVVI8SVBLFe/cPWbPrih/qnsRWsD62hy6jFv/YMrHmsi476wv0G1?=
 =?iso-8859-1?Q?vZ1QG6Ezdid8X2VjHlMhJyMI7xhLROPGGU+6LVhrIUXCXLZroaIQ5hmCfb?=
 =?iso-8859-1?Q?PVE0DwMIMRRHwZyywpp0qj23BTwzoHUCMl546HCsPuuYfXj0/JErUygmaK?=
 =?iso-8859-1?Q?za8Ywq0+uodr2rL+r+jdYF8soNrfv1W1HM2mrXtXdoTPvucQTmgEwNz2bD?=
 =?iso-8859-1?Q?I88w48B43uHsjNxWlyvXXmCIsRX8MTbVY21WNLUdw3hdLD6GIzHGqZEAwU?=
 =?iso-8859-1?Q?H6FaeESB5pPX8snQSKdXliEQrJPtSCtzObeiQ59G5iRgf7w/liNiGSB29O?=
 =?iso-8859-1?Q?+CddpJNIa6U4A9BNgwpcXSosysZNZrtf+sCVrrr4AMV4+K9ZcFidg7RwOI?=
 =?iso-8859-1?Q?SkWxLLHEwf7u84Q7VETrEMK2RxKHnxUHIJMN33HSsCZvKIPsc+UNTNQUbh?=
 =?iso-8859-1?Q?9c2EAbt9euvbH26snyop3I34eplme9EHt+BNBzxMcehYtDjo7PQDr2EB0b?=
 =?iso-8859-1?Q?0ph8Qwp7/Tul6on2EjzabtB3swFjQIa4zoUPTv+9A+lWiF0YHyHd+6AYoY?=
 =?iso-8859-1?Q?/I9MOI+IPpjaUXORQrbJ4owpnVMQ57IxbpzoDq+5cxygPEyjrxe6uLrbu2?=
 =?iso-8859-1?Q?g8LbyRRyGMRfarjIBT+Had0M7R9EaTbCdVODdYnc0dW6Zk1bMuTSnSCut9?=
 =?iso-8859-1?Q?UaURLdBQzB98pPG2p3iWlp6yl59/OKug7OFQHldNBlUiujMRJE6XSsjDlq?=
 =?iso-8859-1?Q?U9NiIV8Gdw5KV1gVYcVVNad3ZYxxwtZEg5wqCQAeooEM2UvcWyc/ksT2uA?=
 =?iso-8859-1?Q?MdsXNVgiLXrYhsdQwCteAuXRwql5b1+MgFLrA0CC0eW7jPoVa/HHEuhyy8?=
 =?iso-8859-1?Q?0Qt6hWkhMcKUgm/Wqpukw8O4tK/qmcuCp8Z5o0zdR9DrT6aQ4KEobWZS+I?=
 =?iso-8859-1?Q?xUa5ABzxD4NiDR9CTby60W6D5v2CDf5BrUhQ747zTQ+Hy0sGqFRT8Z0Dh0?=
 =?iso-8859-1?Q?epGhEZVQgk+J66VaRCXHkBOXBs+i+djVaLX+68Qi2BPacP/9jvtXVlne8u?=
 =?iso-8859-1?Q?E1IFnWw+yfAYriAfXgFgnHpxuMjedDvkjqXxkfAmmutquDyiaE7pO6gSNP?=
 =?iso-8859-1?Q?p02DxL82RN/QCLYZUGJCd/YloAqwhNIINI72PwU5zywTg3hgHwqVcY/1G7?=
 =?iso-8859-1?Q?4Yygzg+L971K0XCOMBZY2g56dRFTOVjReEkKgYSebv8o7WP7zxxiB8G6gT?=
 =?iso-8859-1?Q?AuFGgf7JgpMTDwfy0ftqCvZpel0BrL/UQIxz31zIxd3A2lTUK7ydZnjLng?=
 =?iso-8859-1?Q?gdg0DC1R++hszlMB76TK3rIQeW/pnn4XsiyiSo7RjXnOpMU5DXagPkuXrO?=
 =?iso-8859-1?Q?uQ4ivA/EyP01Hm5KtXiziHgOzT2CIX786p1dJN7zVHS+rSDmBdpGWYNy4P?=
 =?iso-8859-1?Q?RtNQTOtjVcPiXxuj3IDrm+r8QRlTPtjuZwJalZxvJpcN3lp/JPcES7GJ2g?=
 =?iso-8859-1?Q?WWgVegbY9GgYbbPCLbrhZWG9i6zYTrqwY39Fg9dhs89fHAGnkdlc732Ppc?=
 =?iso-8859-1?Q?q1+PMwuedyjM+yS8Qx9/sCx97q0EjTd36oYC6+Fw3h0C0tSerLieDVH0FB?=
 =?iso-8859-1?Q?oxYiRpVf8y8M/VyRn1DzxWIxI7v8IhR+5allMP8kxH3sJW1rCjpahWrwAp?=
 =?iso-8859-1?Q?QEXM15QAPSqg7GpkVi/Td7wdIKBt9f0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EB6EE70A1259414781F7FB2DFE2F0051@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dd7937-09b4-45dc-9132-08dea4d58a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:23:38.5162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvtkLJ4UbZR759b9ERE3Bf/OSTNHxSv+nvFznzHmA0kQA+0pC6J9gnTn6GtgFClox8cttQoXLsKBn/x0Zxxmk1B/CYm8PNPv98ouAoJgzOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5266
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

Hi Tien Fong,=0A=
=0A=
On 21/4/2026 5:17 pm, Chee, Tien Fong wrote:=0A=
> Hi Alif,=0A=
> =0A=
> =0A=
> On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:=0A=
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>>=0A=
>> Watchdog needs to be fully executed in the onchip ram. Enabling watchdog=
=0A=
>> before initializing other components such as DDR in Stratix10 SPL=0A=
>>=0A=
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>> ---=0A=
>> =A0 arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------=0A=
>> =A0 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/ =
=0A=
>> spl_s10.c=0A=
>> index ace029557f3..588dca4fcd3 100644=0A=
>> --- a/arch/arm/mach-socfpga/spl_s10.c=0A=
>> +++ b/arch/arm/mach-socfpga/spl_s10.c=0A=
>> @@ -18,7 +18,7 @@=0A=
>> =A0 #include <asm/arch/misc.h>=0A=
>> =A0 #include <asm/arch/reset_manager.h>=0A=
>> =A0 #include <asm/arch/system_manager.h>=0A=
>> -#include <watchdog.h>=0A=
>> +#include <wdt.h>=0A=
>> =A0 #include <dm/uclass.h>=0A=
>> =A0 u32 reset_flag(void)=0A=
>> @@ -54,13 +54,6 @@ void board_init_f(ulong dummy)=0A=
>> =A0=A0=A0=A0=A0 writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 socfpga_get_sysmgr_addr() + SYSMGR_=
SOC64_WDDBG);=0A=
>> -#ifdef CONFIG_HW_WATCHDOG=0A=
>> -=A0=A0=A0 /* Enable watchdog before initializing the HW */=0A=
>> -=A0=A0=A0 socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);=0A=
>> -=A0=A0=A0 socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);=0A=
>> -=A0=A0=A0 hw_watchdog_init();=0A=
>> -#endif=0A=
>> -=0A=
>> =A0=A0=A0=A0=A0 /* ensure all processors are not released prior Linux bo=
ot */=0A=
>> =A0=A0=A0=A0=A0 writeq(0, CPU_RELEASE_ADDR);=0A=
>> @@ -80,6 +73,13 @@ void board_init_f(ulong dummy)=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 hang();=0A=
>> =A0=A0=A0=A0=A0 }=0A=
>> +=A0=A0=A0 /*=0A=
>> +=A0=A0=A0=A0 * Enable watchdog as early as possible before initializing=
 other=0A=
>> +=A0=A0=A0=A0 * component.=0A=
>> +=A0=A0=A0=A0 */=0A=
>> +=A0=A0=A0 if (CONFIG_IS_ENABLED(WDT))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 initr_watchdog();=0A=
> =0A=
> =0A=
> Either move initr_watchdog() before the ALTERA_SDRAM block to match the =
=0A=
> stated intent ("before DDR"),=0A=
> =0A=
> or update the commit message to accurately describe where it is placed =
=0A=
> and why.=0A=
> =0A=
> =0A=
> Best regards,=0A=
> =0A=
> Tien Fong=0A=
> =0A=
Switching from the legacy hw_watchdog_init() path to the driver-model =0A=
WDT (initr_watchdog()) requires clocks and reset to be valid for=0A=
the L4 watchdog block, and so it must run after the clock manager=0A=
(uclass_get_device(UCLASS_CLK)) succeeds.=0A=
=0A=
Enabling watchdog immediately after clock init keeps watchdog coverage =0A=
as early as possible.=0A=
=0A=
I will improve the commit message for v2 submission.=0A=
=0A=
Thanks for your feedback,=0A=
Alif=0A=
=0A=
