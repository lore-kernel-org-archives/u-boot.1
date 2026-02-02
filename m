Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E78E73140
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 08:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728DD83D8A;
	Mon,  2 Feb 2026 09:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JRl15jdh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95E183D8B; Mon,  2 Feb 2026 09:25:37 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A4283D77
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip+5Mq1lLpIIJUMJiGSITF23sRnjHCL4eaywSQym2H9f3jKFTfstyTNMMuRErrhaWrP+fAh20fneBFLiL3KMN977sIT7sTUx3yqQ0zp5OdBMZXtbGWUCyc8MmS3E4csec4i5x3O+IYhn7yd3ogkJrYANDjE0JIzxk5uZ3sIBmKfyXp16qiJ2j83OqT65PO6Htz8wM86djhXA76T4MDDmQwahvYz5VNybRL7ARERpKGZEqtRuiS3CurAkWP0HYbi0tljT1ju7SdWxyBokB2OxwvHfghc50yhIhn4WmmxAuZ0BziPKF5CTZ7/KK/PsA1cXw8zovDbASV7OZ/tikhgGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so67ivX2SV+2mMr4JMtDg+K6KDKd0uSOA5ojwNe0FfU=;
 b=EUa0rPJCfMJzfl8u5PJeWfuLMl0MSPLCO6+9xCsJcMuLdzUGuVkSJyK7alFDGQTxaXmC3HlV69gPN/OhkVG+q4TcAjDqUE0wY4ZiWrBOvzNf7AvbXnrN7+dyOjdtXwqnuLcHR9TH15Dvwqpa4CnwE7eiAr2UUEbk2J2ZzAVtv2cDXlkAHF8zFx2Te5KwBHfHktzIQH1m0rhaCcNOU8CJz53Lpof5pEBFfoTepIAHgKYAxPIeLa0/n6wBfJPN5H6ELmPAdLZrqeJjbuV1j/UQdZeVKlG+1tTpLE79lU7uW66Pc/O0s5kMycC3CoJ9krmszvqCEryz6+DBREURVwn/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so67ivX2SV+2mMr4JMtDg+K6KDKd0uSOA5ojwNe0FfU=;
 b=JRl15jdhIDOG4DPJGqvPt1AAj+OYixfrjUmKVGUJbrzpuHWo8xPtRCl2KYu95+0iXgXNZ5tyfSNdlZXRMCWXfxV7rvxRuYzRQ4AO44nxNZdbGYaCjN+cISXReAAA+zAFWKdHwuNISin7PwW/au8z2n2Yn2H+1Ca3ZUe8pdfhRHA=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by IA0PR10MB7207.namprd10.prod.outlook.com (2603:10b6:208:408::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:25:24 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::9) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend
 Transport; Mon, 2 Feb 2026 08:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 08:25:23 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 02:25:22 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 02:25:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 02:25:21 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6128PKrN1397480;
 Mon, 2 Feb 2026 02:25:20 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 2 Feb 2026 13:55:19 +0530
Message-ID: <DG4BZ97UWPF0.FCYZ7RUNHS94@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Paresh Bhagat <p-bhagat@ti.com>, Vitor Soares
 <vitor.soares@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Andrew Davis <afd@ti.com>, Gowtham Tammana <g-tammana@ti.com>, Vignesh R
 <vigneshr@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA0PR10MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 083354c1-bb2b-4fbe-d4bc-08de62349c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SndZWlpMaHVEQmUrTDB2LzFlOWFHcTN0aFNaR0hWL3BNQlIxVzVlYmRCQXh5?=
 =?utf-8?B?Rjh0VnA2aE1KTWU3a3N4TGZWVXVUMzhNa2V4VmZDa2ZaQVQ2NmI1ZFRtYlFi?=
 =?utf-8?B?TFExemF2Ny9nck9FbUl4d2VVczhubFN1cEdwdXpLZDNCbjhJcFk4U294bUx0?=
 =?utf-8?B?YUZYS0JqWnN5QlJNVW8wUnhGVGVxU3hwOTNWNUNxUkRPa2MvN2kzUUNBNjZt?=
 =?utf-8?B?Qi9DU1BJaTRWZnNMeGVhQ0U5K3lhYjlBRkxWaXUzRlNXQlNFcjVQMVFDZHEy?=
 =?utf-8?B?ZUh3Njl5UFhCZFZRZUNWUG5QdXRGcDYxb2JJcUljUjVIdzdrMTQwZE1tYTJi?=
 =?utf-8?B?YkcvNzlsT3UyNk1XKytzYnBoKzJKL0F4WkNMdHZpeEE5cG5acThHbi9KZDlX?=
 =?utf-8?B?RDBtTjU3ZUhBQ2ZDTmhIZW4vSkhZd0JDMWFzVm9EMXhFcWRXK1crbURpV3dF?=
 =?utf-8?B?Sm9OL29tOGpoRkkrMk0wR25GVkJMMklhRDU4bDQwMUdFaW1ucTd6eElLSDdj?=
 =?utf-8?B?TjFiWGIyQk8ySUtQN3dzazdhTVdCVGhITURKczNtSVh2M1RsMlVXZUx6ZkJx?=
 =?utf-8?B?OUdGTlZOa200OGc1QWl3cmtRTWZvcGUydjdZblc1Q2JtazZYd01YMEcweElQ?=
 =?utf-8?B?ZmxIWlRtSVhTQXVkd0w2c3RaRnljdUdDN1JNSC9GNnphY0dTSUdaMmQ4MEEx?=
 =?utf-8?B?cTRVZ2dvcVJnS3UzeXliTG1lV1B6RFROOExUajlGdVRWL1JVRldlVFc5MW1M?=
 =?utf-8?B?VE5HcXBWelJMOGVaZm9ydUF5eG1wMkV0L3RWT3JEaWlBcGJEc1NiQlI2V3lN?=
 =?utf-8?B?T2E5SmNYNmVxODFJeHlXRURwRXVncFNTNlk3KzhBRFJzWm9UaU5qdGF2VDJE?=
 =?utf-8?B?TGJXUjNhR2VzYzhKSWxSRk5wT3JlbXgwWU42TzBGYVIvVUJieXNheHErL296?=
 =?utf-8?B?c0lBSm1KcHdhcHdTTGZVTkhLeW1rQlplczJxMmlEZ2d3S0xNSW05MEFtMnNI?=
 =?utf-8?B?WWxFdnFkV1QvQ29yTFBGRlYvcVExTHJ6aEgvY1FwMHd5cVNZa213RTlPbmsv?=
 =?utf-8?B?UUtGamdSYUFJM3NRY2QyaG9tZEhlVUtkUmFPcm5pMnRVZTZvTVhZdWdmTXQ1?=
 =?utf-8?B?TDRIekNnamZIdXUwQ3VvQ1A0aXBoVitLS0pQSzkrVUhkTlpRVmNFdDNBZWtN?=
 =?utf-8?B?bHJGNkl3S0lEdHFNVFhYOFpEbXJKUHhZeVJReDQxS0IyY2FncVNjNlpCS0lI?=
 =?utf-8?B?TTBpSWRocUdnSDI4YVRqRDZrZ1VSWUpHQ2Ivb0t1alB6UG1FZ3FOMzVCWW9J?=
 =?utf-8?B?UzNwOU5MdXFacVdBcDlhQ0toYVYrRU1YLzc3UEt3aUljYm43Qk05OFZtV3NU?=
 =?utf-8?B?QVFCWXlmeC9NdjFKaGRkSGlQUEdYNGxIUkMzT0hDSjZaTWdLZ3VhMWRVUTFs?=
 =?utf-8?B?dHlQY1pIMU9uMjJ3MFNEMVVLYmsvdUtCL0ZnVUpiWmJFN05Ccnl0SjNoVjI1?=
 =?utf-8?B?OFhVRk92dHJ1UHREZnZxUVZxVnJodTExMDJqbWJzaGNESVd3V1Nzc0EvNFVZ?=
 =?utf-8?B?Q2hsdFRJSWJXdklhMEtUbVlSZDlRN2tBVHZseXdKQVNTMGhpVncraThySWph?=
 =?utf-8?B?M2VSRzZ0bmlvSFhzQmVIVzN1T2RXRnRFWlQ1S29LdSt1ejdWNDcweDJXQjVN?=
 =?utf-8?B?Ym94WG93a2Y0NFE2aGRPdzVaOGUxUXRyWW4vVmU4LzNMMnJoR2FjTEEvTjlw?=
 =?utf-8?B?YWZ5alc4VWR1TWJVWnE5TGlSV2hhSHl2bnF0bWhkSUZHK1lVSnV1cENqTzJG?=
 =?utf-8?B?eStyV0lLZDEwOWRvTVo2djF0T0JsRE5rZ3JtVkd0QU5Zcmw5KzQ1UkxQU3cx?=
 =?utf-8?B?WUVJVG4zMHNxbmFWTElDK1lxVzV1eGRmYlFrd1hYSURYWUFHNHh4eE1WSzlP?=
 =?utf-8?B?dTNEZUlWMGZmaFd1UUJIdXRGM1VZQ0FsU2MybC9tUFdPMHJuVTUrbUh6cVFu?=
 =?utf-8?B?K3RCQmJRakhSNEZjMy9PQ1k3R1FUdjh1U0dSMmNlR25TR2t5azArVlYrS2RP?=
 =?utf-8?B?MDkzT0kzdnJuZnFMRWUrOU1PTk1uMlN1dUZ1VmZITE0xRVFHUW1BQ3V4RGhW?=
 =?utf-8?B?d0N6NFZ4bGxnOGxob0JrenlZS2RocE1BQzBqU3VSVVFwTHhRZU5XTlA0MnI4?=
 =?utf-8?B?akFwRHdmNm1MYkovTHRrTWxSb2lVN3NXNU5FQm5td2xzUnBuTy9oUHNKcFFq?=
 =?utf-8?B?TE9RdjBZYTcvNVZkV2FHMnI5dUh3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 08DnYU+8YVWoXejY0JlPUBHKtG9FcwdbHEVpRtDuK7rDw19UqwVbrqW/tfAtdlWh0yIDjrsTsluCBFF+QF0zRozC84Fcfkbc6eCbUUTUxb8fGBlw7ZB3aeO/Qk2UCVorwjRMUqbvq9kgXPzrTU4rTtZuqcPYGqasUsfRVpHvOcViD83coCvSGVnWOl+TScHlpbpHwS0YRIayXVF3ysQ4MT/yrh2f4e/QGjZHip3OeoDCxWUIkAJP0GT9I85d6ytdBCA2XckAzAyJBbV2khVc9thNaAio5Ln0blnq5YVj3zIq39SklHeWUfKkiDeaV1eL7cXl8tAwvnfpaPsSKUR1RmgWp4uzkYRoGCoRMUzfvPH8EmhYSnhKJDbZLKV/vxQI5afEFKzpuzSbdl3NtQc1HDVOklHGzxSa9Y1SJIZb/okY7fEPPfS3jdPPoej2ozlE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:25:23.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083354c1-bb2b-4fbe-d4bc-08de62349c47
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7207
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

On Thu Jan 22, 2026 at 7:38 PM IST, Anshul Dalal wrote:
> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Any updates on this patch?

> ---
> I have verified the DT delta before and after the patch and there is
> no difference except for the addition of "tick-timer" under /aliases and
> "clock-names" under the a53/a72 cores on some platforms which should
> cause no functional change. An exhaustive diff for all DTs is provided
> below[1].
>
> The following affected platforms have not been boot tested:
>  - k3-am625-r5-beagleplay
>  - k3-am67a-r5-beagley-ai
>  - k3-am642-r5-phycore-som-2gb
>  - k3-am625-r5-phycore-som-2gb
>  - k3-am62a7-r5-phycore-som-2gb
>  - k3-am625-verdin-r5
>  - k3-am62p5-verdin-r5
>
> Though I'm not sure if the patch should be split per SoC for ease of
> review?
>
> [1]:
>
>   k3-am625-r5-beagleplay:
>    --- build/before/spl/u-boot-spl.dtb
>    +++ build/after/spl/u-boot-spl.dtb
>    @@ -31,6 +31,7 @@
>     		remoteproc0 =3D "/bus@f0000/sysctrler";
>     		remoteproc1 =3D "/a53@0";
>     		serial2 =3D "/bus@f0000/serial@2800000";
>    +		tick-timer =3D "/bus@f0000/timer@2400000";
>     		usb0 =3D "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>     	};
>
>   k3-am625-r5-phycore-som-2gb:
>    --- build/before/spl/u-boot-spl.dtb
>    +++ build/after/spl/u-boot-spl.dtb
>    @@ -10,6 +10,7 @@
>     		assigned-clock-parents =3D <0x02 0x3d 0x02>;
>     		assigned-clock-rates =3D <0xbebc200 0x47868c00>;
>     		assigned-clocks =3D <0x02 0x3d 0x00 0x02 0x87 0x00>;
>    +		clock-names =3D "gtc";
>     		clocks =3D <0x02 0x3d 0x00>;
>     		compatible =3D "ti,am654-rproc";
>     		power-domains =3D <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
>    @@ -31,6 +32,7 @@
>     		serial2 =3D "/bus@f0000/serial@2800000";
>     		serial3 =3D "/bus@f0000/serial@2810000";
>     		spi0 =3D "/bus@f0000/bus@fc00000/spi@fc40000";
>    +		tick-timer =3D "/bus@f0000/timer@2400000";
>     		usb0 =3D "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>     	};
>
>   k3-am625-verdin-r5:
>    --- build/before/spl/u-boot-spl.dtb
>    +++ build/after/spl/u-boot-spl.dtb
>    @@ -10,6 +10,7 @@
>     		assigned-clock-parents =3D <0x02 0x3d 0x02 0x00 0x02 0x9d 0x16>;
>     		assigned-clock-rates =3D <0xbebc200 0x2faf0800 0x17d7840>;
>     		assigned-clocks =3D <0x02 0x3d 0x00 0x02 0x87 0x00 0x02 0x9d 0x14>;
>    +		clock-names =3D "gtc", "core";
>     		clocks =3D <0x02 0x3d 0x00>;
>     		compatible =3D "ti,am654-rproc";
>     		power-domains =3D <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
>    @@ -29,6 +30,7 @@
>     		serial0 =3D "/bus@f0000/serial@2810000";
>     		serial1 =3D "/bus@f0000/bus@b00000/target-module@2b300050/serial@0"=
;
>     		serial2 =3D "/bus@f0000/serial@2800000";
>    +		tick-timer =3D "/bus@f0000/timer@2400000";
>     		usb0 =3D "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>     	};
>
>   k3-am62a7-r5-phycore-som-2gb:
>    --- build/before/spl/u-boot-spl.dtb
>    +++ build/after/spl/u-boot-spl.dtb
>    @@ -10,6 +10,7 @@
>     		assigned-clock-parents =3D <0x02 0x3d 0x02>;
>     		assigned-clock-rates =3D <0xbebc200 0x47868c00>;
>     		assigned-clocks =3D <0x02 0x3d 0x00 0x02 0x87 0x00>;
>    +		clock-names =3D "gtc";
>     		clocks =3D <0x02 0x3d 0x00>;
>     		compatible =3D "ti,am654-rproc";
>
> power-domains =3D <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0k3-am642-r5-phycor=
e-som-2gbxa6 0x01>;:
>    --- build/before/spl/u-boot-spl.dtb
>    +++ build/after/spl/u-boot-spl.dtb
>    @@ -10,6 +10,7 @@
>     		assigned-clock-parents =3D <0x02 0x3d 0x02>;
>     		assigned-clock-rates =3D <0xbebc200 0x3b9aca00>;
>     		assigned-clocks =3D <0x02 0x3d 0x00 0x02 0x87 0x00>;
>    +		clock-names =3D "gtc";
>     		clocks =3D <0x02 0x3d 0x00>;
>     		compatible =3D "ti,am654-rproc";
>     		power-domains =3D <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0x89 0x01>;
> ---
>  arch/arm/dts/k3-am62-r5-lp-sk.dts              | 82 +-------------------=
----
>  arch/arm/dts/k3-am625-r5-beagleplay.dts        | 72 +++-----------------=
-
>  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts   | 76 ++------------------=
--
>  arch/arm/dts/k3-am625-r5-sk.dts                | 86 +-------------------=
-----
>  arch/arm/dts/k3-am625-r5.dtsi                  | 88 ++++++++++++++++++++=
++++++
>  arch/arm/dts/k3-am625-verdin-r5.dts            | 81 ++++++--------------=
----
>  arch/arm/dts/k3-am6254atl-r5-sk.dts            | 86 +-------------------=
-----
>  arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts  | 58 ++---------------
>  arch/arm/dts/k3-am62a7-r5-sk.dts               | 60 +-----------------
>  arch/arm/dts/k3-am62a7-r5.dtsi                 | 69 ++++++++++++++++++++
>  arch/arm/dts/k3-am62d2-r5-evm.dts              | 72 +-------------------=
-
>  arch/arm/dts/k3-am62d2-r5.dtsi                 | 75 ++++++++++++++++++++=
++
>  arch/arm/dts/k3-am62p5-r5-sk.dts               | 69 +-------------------
>  arch/arm/dts/k3-am62p5-r5.dtsi                 | 77 ++++++++++++++++++++=
++
>  arch/arm/dts/k3-am62p5-verdin-r5.dts           | 76 ++------------------=
--
>  arch/arm/dts/k3-am642-r5-evm.dts               | 81 +-------------------=
----
>  arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts   | 76 ++------------------=
--
>  arch/arm/dts/k3-am642-r5-sk.dts                | 81 +-------------------=
----
>  arch/arm/dts/k3-am642-r5.dtsi                  | 84 ++++++++++++++++++++=
++++
>  arch/arm/dts/k3-am654-r5-base-board.dts        | 74 +-------------------=
--
>  arch/arm/dts/k3-am654-r5.dtsi                  | 77 ++++++++++++++++++++=
++
>  arch/arm/dts/k3-am67a-r5-beagley-ai.dts        | 67 +-------------------
>  arch/arm/dts/k3-am67a-r5.dtsi                  | 70 ++++++++++++++++++++
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 82 +-------------------=
----
>  arch/arm/dts/k3-j7200-r5.dtsi                  | 86 ++++++++++++++++++++=
+++++
>  arch/arm/dts/k3-j722s-r5-evm.dts               | 81 +-------------------=
----
>  arch/arm/dts/k3-j722s-r5.dtsi                  | 84 ++++++++++++++++++++=
++++
>  27 files changed, 768 insertions(+), 1302 deletions(-)
>

[snip]

> ---
> base-commit: fd871fc6bb497c6ddd7b39622480b89add78f57b
> change-id: 20260122-r5_dt_refactor-4535f5177593
>
> Best regards,

