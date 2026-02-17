Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E63E83852
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 04:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C4783B8A;
	Tue, 17 Feb 2026 05:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LO3iQDLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F2F83C61; Tue, 17 Feb 2026 05:45:59 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E354D83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt9PQ8OUDvt88PVEyCpHGcBClRWRHYfIbrypK0/gklYGO1D+QxI54vvQ4+xO+8JZDbB/i904Gn0Tn4sNy658/p6hW8R+wvY6yZHaRz2y7tUWXTPwy3C9C9bdya7rdSW0rVKUUmptCF0MHqM8ji+Ms8awpeNjcKXMga8V7u4DpuHXQQHj9yKuDlw6wr6oG7jhOOJtwxZqAnPPBiBOyY81ywrarzXMFmrN7S95etHd22Zxf1RmTNWYym6Is2YsvEfPqx5EYKt5IK8e1LhVhltOaA7XYvj7AOa1QqjY0FGjvNjKzcRNolumwiBEmVHoxuenKS0YP65R1/uRKm4MdFaVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5HFMvb5Qhxho5cH/2q9Ml3mTBrkBYa6sAeYwj0MZuE=;
 b=M3x7zmerc2QM2ir0MgEuEMTGtgYln/5fM+LUIMWe1C4qJQArXE2YbPThnU+q55WHWFfOHt1Li3SHzR0Z5vrH37T85MJGAOZeg8JE/ya3U+sjQGJMR0IiUb1DdHPpcy7oHAwdrHEcQJr8uGzDL3OajXAUBHBrGtyB8JSY+VqOhQNuMuhWxw7cPpyQCTlbHZ7jMCywzakNBR3hRq+/3rIGnOXLOyetCVeOpvUCWdu6uM+cQgk/uDogBWFADnzct/Mt3YwTghnZJfePFkP4FYAA5wwaQ4egxlgX0PmrZyoNdHiAoXxLKaGx4wJ4i87mym0Q4eC843WvunQwy14UEap4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5HFMvb5Qhxho5cH/2q9Ml3mTBrkBYa6sAeYwj0MZuE=;
 b=LO3iQDLUJM4P1AdgVYw2aCj04g9q4I4sOkZftZMdB3OU2rovDrKKfvFCuTzXTu4aqYegkIzjAiyO8lNtIW1Y0ZO0NLbccmB5XsSYfPuC+klsAc4Zyyc2kY+6g8plPLnbgaacLL/XrSp7uqvzGmz9GjT+6C1OxIaR6DJSDfCMz/s=
Received: from BY5PR17CA0050.namprd17.prod.outlook.com (2603:10b6:a03:167::27)
 by PH0PR10MB997640.namprd10.prod.outlook.com (2603:10b6:510:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 04:45:53 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::be) by BY5PR17CA0050.outlook.office365.com
 (2603:10b6:a03:167::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 04:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 04:45:51 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 22:45:50 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 22:45:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 22:45:50 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61H4jjJ22784342;
 Mon, 16 Feb 2026 22:45:46 -0600
Message-ID: <ef7bbd84fca55d137d66f7f29d050714dea84d37.camel@ti.com>
Subject: Re: [PATCH v5 06/10] configs: am69_sk_r5_defconfig: Disable PCIe
 boot configs
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 17 Feb 2026 10:17:13 +0530
In-Reply-To: <0de97221-047c-420b-aeab-3b5eee74f97c@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-7-s-vadapalli@ti.com>
 <0de97221-047c-420b-aeab-3b5eee74f97c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH0PR10MB997640:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b06c04-ac4b-46e8-d2a5-08de6ddf6db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|18082099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anhyR0ZObndNTi9wTFZ4cmhxdGtGKzA3WnptSW1wNlBIS2picmducVU4Yy9K?=
 =?utf-8?B?ZHp2UEoyUk5kc2FxNWlOM2ZnOGd5S0ZWYkVERGRxWWoyL2N1U3JxeURVNDFu?=
 =?utf-8?B?cHFzVlpQZHRXWi9UMnhqa0FSejJqWTJPa2s3NlF3VjJrdkw4TVhWeUFMNndq?=
 =?utf-8?B?WFlTVGo4K0UrUGd6eS96UEp6UkFTTHdvUzJoeDh3N3ZoTnpZQUFIdzY5Q0Nm?=
 =?utf-8?B?VXBiMmZqb1o2UkUxclZhUG5IVlU0WWJuM2xkVHY4YzdyT1VENXllNmhyVjA4?=
 =?utf-8?B?M25FUzk3aU4yTDFJOUl6T0kvaERsdWpxV2F5WjFLQThKQXlLUHRwbTF3SUxs?=
 =?utf-8?B?ZHBsTUp4Q1B3czN6TENxL2h2b0tCTFZXN2hRZEpVWW5tWXVwc2JxdWx1VDNr?=
 =?utf-8?B?Q0NBUWw5cEd1SFU3RWdUNHFsa3l6bXJlQ1U1dEYwbmpLVnc5RHdwRVR6bkVB?=
 =?utf-8?B?eFExQWZhZGhDRlVvOVRKZUtQS0hFYlRlNnZVeW5OL1BxNHdodnpiTTNKZjJO?=
 =?utf-8?B?ZU13VGpvS2hya1BYeGg2TWdnK2xOYnFRQ283ZElxMlVvSEFqK2xVcHJXM2o0?=
 =?utf-8?B?QjdzQ3N2V1BoazlRUW9nK3VGUzlmYitvQjhicnNFSTVZcmQxYTRya3R3Unpx?=
 =?utf-8?B?cGg2TUpDOUV3elBGQU82TW5WYy9nWkJtcWRuQWFYUjZFOHFobEozN0ZPaVEy?=
 =?utf-8?B?ZEZTWFdpSVlBamw2bk5aeW5rSlovdlJoOG1uRDVGZ2NHaGFGWS91eXdxY2JG?=
 =?utf-8?B?TlJRTUtvdElBUzJtNDlVZUg4VUl3L3A5T2k1K3F3N3hSaFJ0U1JTMU9BZnFq?=
 =?utf-8?B?QWU4cWhpZjZtYnVxM0d5cVF2ZWFFSkdXc1p5cW9zNWF0WnFaa3BqNWhURU5L?=
 =?utf-8?B?WVNOcXZVMVA0RHB5eDMrU0RHN0d3bG9FbDFKN2lzTnVhVTh5RUIrbDZjS0pi?=
 =?utf-8?B?YXdhUFV0MWZ4Ujl0cUxkakQvQkcyMGVpQ0REcFJ6ODhPSDd5aHNodGlEWGJu?=
 =?utf-8?B?TjY0UmdqVUVFKzdJdVpzVlBBZ1Z3WTgrV0kramFpc3FnallSOWNsTm9sb2Y4?=
 =?utf-8?B?NTlFOHNXWTQvckZhMmJuVzhzN2RpVmdXaW91czZobWFVYTdpK3pmeVRJNnpR?=
 =?utf-8?B?NHQ0Y3NyWXI5Y3V2UGV5dklHLzJkY2FVMTZDRUtVOEhNZjdGeUdQS2JVTjhE?=
 =?utf-8?B?L3BIblJ4OEtpaTBQWGtlTEZRVEEzQmZBSFpzMTh6NHlUZ01RS3o3Y2NSUDc1?=
 =?utf-8?B?K3g4Q0hzMy9lN3ZrbUxOcjIwQWJZVUMzTmtvUTR4cHFnRlZpRzlxUUhjcDBY?=
 =?utf-8?B?TFBud0JlKzU1WDBMTUh6dXo5eWM2bVBVMFkwbGtNOHAzL1U1TUk5UWhZaWxM?=
 =?utf-8?B?V1lNZjlFVDBDTlg5Zm5XcEVlRm1NM1FoNWdLcVNHMHBaNEd0WFplWDBsY3Az?=
 =?utf-8?B?NzZYUVVoVGhDREVxRE9PS1VQZWJFaGY5angxU2VOOTQ5L09vMUFROFVzT2VV?=
 =?utf-8?B?WFowNjhzeWU3N2VOc3c1cVU2VWs5M29md0hNc0xyRUM5K2JzNTFYWXluRWFt?=
 =?utf-8?B?aDRLdVBtZGgyVVgwQUxYVDQ1UjBZRndHOXg5QWcrTUp2Q2M2Sk1NRFdJd1pK?=
 =?utf-8?B?N1Y2VmxBZzNHTU5YSmJxVDhBcldIVEdKaElUcFpaTGc1c242YVFEUDNWY2VF?=
 =?utf-8?B?bldRK2RPS3J4cWJiZm9nTHJPTUpNbXlEVGVVRFA3WnpVVXBRTms0UnM3bWlw?=
 =?utf-8?B?OVJKZVFtK2piak03eWc3cTMyWGNoSjNEVFlKcEd3QjVoYXRBS1Q4QU1zK1h2?=
 =?utf-8?B?YmRNRndteHF6WFg5bEhMbStKOE5ZbldwamxkMVB4RkFIZG50RUFzcittQ0Ez?=
 =?utf-8?B?NkowYldqc3FTdERKdThsTGhKNEhxTzdnK0IyTjEzSjR6M1JWeFFnUmk1d052?=
 =?utf-8?B?Y3k0cm9BQzVmdmluODlMQ3o3RjJZUlh0ajhBNm1BejRFNU1wbFVXS05yNEdR?=
 =?utf-8?B?NEhmZGkySDRsVmhiYnAzT0ZyWXpxTm9wWHZDbjJ3RzA5NVY5NWpGRnhrYldD?=
 =?utf-8?B?Z0ZIdWxCK2g1emJoT09ZU3d1L3hUWUNkTnovVU1rTVhRckJuc0k2Z2JMc1pM?=
 =?utf-8?B?L0lpNW1uWUVDYzZXWUU4MG5rc3ZOL2tsR0VYUE5IY1pVQWtvNVpIYVNEVkR1?=
 =?utf-8?B?ZjdjblYvVVpzbTNoSWdOTUhjYVNmL3h6SjVFekhvT0F5MDRqQ1I4UEE5YXdw?=
 =?utf-8?B?MFV2ejhUUyt3aGVOQkRZcVc4cGl3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nNyzaE0DqpcpauxXzqNdSRJJUWuk8spKsnvOyd8UpCFH+T77R2AMf3EX4fceswstMDwmJO1c1AHz3f/YYTJXYsz1ZrpFIhl+tWiS+7NyM4Zmt9zSLB484sKQLgQMhXzgnGR6BGxZwlL5b7e6BgJrigQc37U8ZBGAHMAfzr08MtxG0QZSc7oN8iXWDrXmVFprAeWBvOmHEbQpyDp8N6v+XuvxIL03XWJReF8Oyh3OIcDUi1oIFbAr1tKZP1KeQ94Q/r5ARu9zfesjXh+x2Vj+DoUcWATktLGF2pJO+R/MpUi/kHKfK4L7FlJWFwhjG0K+TrpAI0dsES+LESXxziTgnThrmVEu8sy7YpcO8oTAbJeWyiJiLRjEZ8IdNkM9KYccGFxN42iSRL/c8YmqtvgUINPUsDWQpl6JtorZtIchdsI0eRr/qRh+F5qUCbZUo6PM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 04:45:51.7739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b06c04-ac4b-46e8-d2a5-08de6ddf6db6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997640
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

On Mon, 2026-02-16 at 11:39 -0600, Andrew Davis wrote:
> On 2/16/26 4:28 AM, Siddharth Vadapalli wrote:
> > From: Hrushikesh Salunke <h-salunke@ti.com>
> >=20
> > AM69 SK does not contain PCIe Boot in the list of supported Boot Modes.
> > Hence, disable PCIe Boot related configurations that are not applicable=
.
> >=20
>=20
> The board does not have PCIe Boot selectable on the DIP switches, but
> those switches are not the only way to set the boot mode. I'd just leave

PCIe Boot is not claimed as a supported Boot Mode in the AM69 Starter Kit
User Guide on purpose.
This is because the Boot ROM supports PCIe Boot via PCIe1 instance which is
connected to an M.2 Key M Slot (intended for M.2 SSD) on the AM69 Starter
Kit board. Even if there is an alternate method for setting the Boot Mode
Pins for PCIe Boot, it will still require the usage of an M.2 Key M to PCIe
Edge Connector Adapter which is _not_ sold along with the AM69 Starter Kit
on ti.com.

Hence, I interpret it to mean that PCIe Boot is not intended for AM69
Starter Kit board.

> these enabled unless you know of some hardware issue that would prevent
> PCIe boot on these boards.

Due to the 'hardware challenges' mentioned above, enabling it in Software
and testing it on the AM69-SK isn't straightforward and is HACKY (alternate
mechanism to select PCIe Boot).

Additionally, this series is for enabling PCIe Boot on the J784S4 EVM. So
even if it may be possible to enable PCIe Boot for the AM69 SK in the
future, at the moment, this series doesn't do so. If and when
the support for PCIe Boot for AM69 SK is added, the configs may be enabled.

I hope this clarifies the reason for disabling the 'inherited' configs in
am69_sk_*_defconfig.

>=20
> Andrew
>=20
> > Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >   configs/am69_sk_r5_defconfig | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfi=
g
> > index 2186b9a0490..166f774aade 100644
> > --- a/configs/am69_sk_r5_defconfig
> > +++ b/configs/am69_sk_r5_defconfig
> > @@ -5,6 +5,12 @@ CONFIG_ARCH_K3=3Dy
> >   CONFIG_SOC_K3_J784S4=3Dy
> >   CONFIG_TARGET_J784S4_R5_EVM=3Dy
> >  =20
> > +CONFIG_MULTIPLEXER=3Dn
> > +CONFIG_SPL_MUX_MMIO=3Dn
> > +CONFIG_SPL_PCI_ENDPOINT=3Dn
> > +CONFIG_SPL_PCI_DFU=3Dn
> > +CONFIG_SPL_PHY=3Dn
> > +
> >   CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am69-r5-sk"
> >   CONFIG_SPL_OF_LIST=3D"k3-am69-r5-sk"
> >   CONFIG_OF_LIST=3D"k3-am69-r5-sk"

Regards,
Siddharth.
