Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8C1CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BC183965;
	Mon,  3 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iaZsJlKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CFB83700; Mon,  3 Nov 2025 09:18:54 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEC88331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 09:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghO2QcJKCJOflbcuuBQDE8naJW8+icj6806OMdEYGxpeh7FLc1Bx+d5dFAdH+MeSnAYv+JCw7argkH5RC71JO0a7n7iLhLpv0eZpKBOaZzVp/gDKN6FKV/YRmKDr2FMNyTTb5Ypg8j46r07HhQsX+ipXBDC/tapGca4LoAldsHxUa5/llLlSD/fAFmqME/xCeponXzlhV2c89bsUZdf43BAqhAI+JcdLmjgw9RyN7GeGMHBJwb74ZIxxskoVz6usHTsUFnFN+W/FGhJ0Gk2/oV9Q4Yf1GaL1gsQLNXQmJwi0JGSVBAsMO4lxXeZy274yHiKMzu6o+ZWlCQJziwtKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4XfEIycpsxHpklFH1nhsVXayH1BBjnXDs2xSRGn8NI=;
 b=pKpy7dnnvAZGgdGoUb1aj8pAoB9fugxHjOzE8xoEhFEc/bUDXKchv35LmPoIw89MKTKXqrdMqO5Q6sfinnXAUeMJsOrSZ3lpJ+6ruiGIdp4QIFJRft4Zd4XlrVxLVoX/O6mN2WVm3+j9G3N2Cv74GcvY84xBAxWlkBjdYNhZ6OgCjROaekqHnteaJXXjgUIOR3DulsoMqmPoIxf5XzTkqKcPEzjid5Etn/AZ8fivagOYjFfWdzSn0zjh3Iv9TvWawm5pwYEAjVo2orxJ6EaWEXXIhnD6sndf5+0SqPOIyypvLUpH4lgV5Vo4K7AzLTByDF75afcypoqMlJjSefkDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XfEIycpsxHpklFH1nhsVXayH1BBjnXDs2xSRGn8NI=;
 b=iaZsJlKjtRnCHOifeLxRd+xM49gXuG2tEHyrhKOHAb3tSSZuFVIHJiGj9A4td5xXEl4b/Q3t5ymhXV66AD4X8HJmqPf5GLWvSbrpZqG/pn/OVoErCNlVykA/0/B/QLfRnICU6UTwiBbrBybWHfLoCGNAm4lEImsrn6593ThRHrc=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 08:18:48 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::97) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 08:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 08:18:46 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 02:18:41 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 02:18:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 02:18:37 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A38IaXM3777933;
 Mon, 3 Nov 2025 02:18:37 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 3 Nov 2025 13:48:36 +0530
Message-ID: <DDYWUJ11G4H4.6L4O0RW036AE@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 00/13] am62: IO+DDR resume support
From: Anshul Dalal <anshuld@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: e6863f6f-1c2e-4c00-361d-08de1ab19c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|34020700016|36860700013|7416014|376014|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MndyZFFMTVNjdGM5elZkMy96U2FsdXJUb2hac1hta0VjMUtvL2RreFFKWGJ4?=
 =?utf-8?B?azJqaXlXSnUwMVVFMCtEMjdvTHRYMEh5UEg5Q3FhVGVaSmNMSGd2WUlkWTBx?=
 =?utf-8?B?YnVhRXJJeHZYYU1NeFh4K1pydlRqczljS1ZFU04xZjloTjJvcDlJUmlXUFFU?=
 =?utf-8?B?WmdUdFFUd01hRUN6RzdpNWJJSWF4VnhIUnJjeFNKYVZQT2prcU1lRHpGTytt?=
 =?utf-8?B?ODBPUXF1M21vTmFzV2RlaHd5L1ZpWkdFRUQxZmNVNkZZME5VNTI3QkVQeE5L?=
 =?utf-8?B?aWNMcTZBRDBvbEtTY294OEJ4dXFBZG8yNmRKczRxSHY3TWsvTGJvWHpXb0dy?=
 =?utf-8?B?cUZSYzIvZHAxTE8vOVJvbldiSkQwNXkzOGd3c2JEenVNekpNWFVXN2xsNHQr?=
 =?utf-8?B?Z0I1YmlVd1VENUhBWExoY3VZRFV0U0xFYTlXbWdGamQ5Sll2dmR2YzJCdVl1?=
 =?utf-8?B?TTF2cTFiOUl0RkcrWm96cGVtZy9IWElxbDI1czZjN2Q2ODYvaHFSUTBqYnd1?=
 =?utf-8?B?bW1jaEl4L1QvV2FqRTVPRm9QV1Y5R2Z1Tm5ONUR6MWh6YmE0cTBvcHYyb2JX?=
 =?utf-8?B?cDB2VlU5Y2lzV1NsZlJGblNYRmVVUlg3Nk1LVUwzeXBtS2g5ODJoSXVPL1hx?=
 =?utf-8?B?YzBzWDNjREk4UGFuajIxQVduK293MG5qVm1STDZpMUEwYU1UTW9NMFRJWGVT?=
 =?utf-8?B?bTB0b3JrNHVZYnpKTlFZbFhnZGo5MndoTzI0U1BGalRvWHVxVkF0MmZJWDV3?=
 =?utf-8?B?QldCRjdyY3pMSXlXbC9wZjNIZVBTSzAwMW16MmxsQ2Vsc210a3IxNnovWE1W?=
 =?utf-8?B?U1hkYnBwcGtLQVFkbXM2T3oya0F0UDJkV25pZ1VPK2x3QlFGblV3SWR5WUpv?=
 =?utf-8?B?YmkycVZBYTNGMlMyZnphQTZaWFRaRGFUbnBweHVxeXpwcHRKU2d3U2JneWZL?=
 =?utf-8?B?UGVwVXd4SDRQc1Nnc01TUjVsVXA2QTU3MDc5RHladUVqR1pCWFBndVc1eUxk?=
 =?utf-8?B?NmJSbzZRSTQwemZTQS9LTTM2bW4yZHRoelRucTdsOE5IU3RTRVpQdXBCM2NG?=
 =?utf-8?B?TGdNRCs5SFBrbWVLYnNHT0F3N1AwanljRjZZakU4OVdCYjZ2OHJkZVlJekkv?=
 =?utf-8?B?bFRCNE1pK2dvNkhxcktlZkVKcWwxMnVDN2s5QzlpelgyWW9JUmNYL2pxb0NV?=
 =?utf-8?B?RUc1M3RJcGEwTGIvYjc2SE8xa1BkTTFJelZmUWhIOTQvZTNGSGVjOXE2bzhR?=
 =?utf-8?B?Q2RVSHhZMmF4Q0x1UzdDcEMzY29hNytIb1huT2gvamdpei9BTXFmSmJUUTli?=
 =?utf-8?B?aDhyckFSL3FuRmtwTHhyZ2k2YmpaRVB2ZkdpM2hoeEVVOHlBaUczZUNCQlow?=
 =?utf-8?B?MWZoMk1DMGx4YzVGVnp1b0I4QWdXeGNUOUliUGx5OUpRY29GOWozYVN4cjJD?=
 =?utf-8?B?amxnNzlhdFlaNGRTRGNVTXdaR2ZGb3pyOUc0TkJ2Q2FkbSs3Ky85VDlNTjBQ?=
 =?utf-8?B?Q2t2V1lzS1JOVUxvZlQ2NXNjMkoyOE1SZ3FDd0V2T2FIWWxMK1QyVXBvcmJB?=
 =?utf-8?B?YlZ1MURwbjNFeGg2a0VlRDNQUi9WZG5jbDVMb3NOc0lXejN5UDdUUGd5S1Vr?=
 =?utf-8?B?SVp1QlpKSkNaekNtQjkzdncxOTBvc0gzVFNTVGxIaFNLdllWYTdveUR3Zk84?=
 =?utf-8?B?MUhERlNoSytEVTExRGZzRDBsWEtmTytSVUZzaTYra0N2VDRLKzk1L1AvOFpr?=
 =?utf-8?B?Qk1wZlduV25JQW5tZVBjZmtIUUpsNS9rbkJSUE1neE9NMVJ5UWtlU2NYNjVD?=
 =?utf-8?B?RDljbFRON2hSbVVtRlo5M1ZzWjB6Y1J0TVBuUkJRSEJrWEo5VDFabmN0dW9F?=
 =?utf-8?B?Z0E5Y1pYOWVjTHlrWnVsVm5hSHhLSGptRzRjd3pvbG96SU9GbCt2OVFua1hE?=
 =?utf-8?B?eGJWK3VGMGhZUFdwL0hJQ1c0NE9UUVBhTGtZOUdvZEY2a3hIM2ltZ3ZCVlZJ?=
 =?utf-8?B?OFpMRk4rQmVGS2dJWkVrTXJHMWt5bWJ1eG82dVQ5c2QvdS9BMFY5bkVkV0xD?=
 =?utf-8?B?K3pEd0lJaFVqWkdiVkltRGRZSmwyVmsvU1lZbE5FQVgyTWhRVVZxLzNNUXow?=
 =?utf-8?Q?Q8BM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(34020700016)(36860700013)(7416014)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 08:18:46.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6863f6f-1c2e-4c00-361d-08de1ab19c52
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6124
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

Hi Markus,

On Thu Oct 30, 2025 at 3:29 PM IST, Markus Schneider-Pargmann (TI.com) wrot=
e:
> Hi,
>
> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
>
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
>
> Afterward a specific address determined from DT is used to get the
> metadata that stores relevant context addresses. The context is restored
> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> further initializations are skipped and uboot SPL directly jumps into
> the DM resume address which takes care of the rest.
>
> k3-ddrss is using absolute register accesses at the moment. I am trying
> to submit syscon DT patches upstream to access these through syscon,
> unfortunately there is ongoing discussion regarding syscon.
>
> I tested this on am62a.
>
> Best,
> Markus
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

For the entire series with AM62p:

Tested-by: Anshul Dalal <anshuld@ti.com>
Boot logs: https://gist.github.com/ArchUsr64/4fe8433590c6c575a685d808aebb62=
71

Regards,
Anshul
