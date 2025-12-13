Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5823D5AE41
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23ED835FD;
	Sat, 13 Dec 2025 15:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WbBuMFN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB7A83642; Sat, 13 Dec 2025 07:42:31 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88A083045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwnOHTzVGUBlUImhRU1kp2XEm3ihJmaJqequpda49McG18yvEO7aIEPdvYXgpvcoudzg2jzjuJ24Qaye3U7SwFXydG5oRf1dKE6q3zfgeahnfZjuEpqFVtPJrz+9NmbPlKYT4w71djNfGF9Qp7CrPaNqZC3stV5m/9QrE/eU2NmcbEHrbcvDIuDa5e7BTxkDS1h0xT7NlbD1OdKPYgF4NIDFN+vsDzSfHptlGix16eRcRjAV+EEXlIpf7F6hh965DzKr1v2CLPjHhb1sZ9VJTfZ7peoQr4DqCujl0mTxZsOi3L11iIgiuJsVpLoHJyWxxEVIohFayJYIyq2QOG5SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js92h/H1V8165czzxYLcLJ6hPazvKgw+YnWAIcciSwE=;
 b=TXJioZ0lU/hKlJNuXWn5CPu0BXarGBb65UHunZCE/mcmUKNIK3X66QjH6zTmizIQZhQU96s4pMqaLg5fszVNuAh8ep9Ift7Bl551ynj40gJ6mW4WfS53hJBjFxCdncJI9jUnBn/4htxwTWWQfKqqSWiSMmYL2XuJYHikqskoMiuAhb9AQ0j3oQt4imS3hV9bEOcJo3I/i2NdwhB3xMMEp3CtsHvYw/jKX/Q5Q5D9jFRP6bbI1HLwDHbb+ZOKmQcFM4l7hYIbl3CVjNY6U3/qkk6Qa9lEgZnRjjvbHPRAyi1WGhZ8Xc4SSVREPvK8SZSKFWQScguVvVEc7FhPC8FRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js92h/H1V8165czzxYLcLJ6hPazvKgw+YnWAIcciSwE=;
 b=WbBuMFN5wT2FH8jU42GTZXJbiZFZsOD/+CakA9/PmDDatYrB5fPGpuHSrZwWGnCEswm8J1aB+dERlWD7PzYwWGibX3NcU3vXLSAU0ut79ZksuI2jGut1oKplRN8At7lOOQLtcneYw9gD395KOvVw0UujR2KqfVZ3MffXe/XAnsk=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.11; Sat, 13 Dec 2025 06:42:25 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::38) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Sat,
 13 Dec 2025 06:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:42:24 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:42:15 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:42:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:42:12 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6g2YI3327571;
 Sat, 13 Dec 2025 00:42:03 -0600
Message-ID: <5a3ff81f-8843-43f9-9b5f-5500940cb215@ti.com>
Date: Sat, 13 Dec 2025 12:12:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/13] firmware: ti_sci: Add
 TI_SCI_MSG_MIN_CONTEXT_RESTORE
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
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
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-5-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-5-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR10MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 21548641-c45f-427c-c5be-08de3a12c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTgrVDNyZFZHQWtTQnYrWWR6TGtaem1LeFJhc0RHZWk0NFAxYXgwcXNndDQv?=
 =?utf-8?B?WEtFMWdCTjJvNlNsRDlyOFZvZTNHb0ZYQUNSUzVVeSt1UGN4Nzk2SmNnVkVB?=
 =?utf-8?B?bXF6TGRPa3Vub1k4bnRjTnZHOVFGVHp4L2J1d204RGZpczdmWDVNMmtTdEJK?=
 =?utf-8?B?MG9zcGhQS1ROYXF0SXEwU1luYnpOWXorT3RUNmNmbXVQaHEvZnVXVmNZU05v?=
 =?utf-8?B?RDRxc2FiV3AydU5HWEN6NWRKKy85MXlSVnYyV0VBOGdZTnI3WUF4Y1dmd0FW?=
 =?utf-8?B?UG1zMWRPd2VnSmQrZnhpVEw1STlkbHhVZEtDUXd2bGN5YlFjTTFJKytXZmVP?=
 =?utf-8?B?c0M1Umg0MXllaGkxdFJVMDJHZXAvNDNRNUtkVURwR1RnN2N3czBlSFBRbS80?=
 =?utf-8?B?dWVrMW1rU3RuMVdkbFNMZStDeDVOVHZSUndJbUtOWFdrQ2o3OFlTUXpEN3Ux?=
 =?utf-8?B?RE1FWWtVbDJDSDNEVFo0bUVoNEEvYkY0Mm5uMWVOOHhrenBUM1NVQXBYQWFm?=
 =?utf-8?B?Sjk1enQraHlKRkFYbk45SUdubkV1V3Vscm5qNm1hb0JrellaRG1KcWJZRlhn?=
 =?utf-8?B?TDBhL252cHZWcHdZNlJPRFhBRHQvdWxZTHR4T1ZKUWNaeEs5N2JhS0pmRmQv?=
 =?utf-8?B?RFFLZkhXRWZ1TVIyZVV5YnlwQW0rRTh0T0NjSHdTdWZJb2tNYVg4aFh5Q1lw?=
 =?utf-8?B?czBMTVFpQnpScE0wc2FHRTJUOW1waGUvallTYnJENktuTk04TmExbGRuTnha?=
 =?utf-8?B?WU1zN2s5TmFiREs0dWJlMVRWUzVFcEFHN2RDZ1laNWdab3NaUUhwUGx6d3Na?=
 =?utf-8?B?aytCRHA4cjUwSU9XOUZ6Z01tV2RjYlZFZ3pCZkhmSUQ5TXFSTWF1MUpYVTFH?=
 =?utf-8?B?M2djOXBtdVhPNXdyays3YWlNMS9UbjduYUVJYWRZcjFTNURrZlB5UElXeUVE?=
 =?utf-8?B?aVAxZldBbHpVUGx0OXhhTjRjNWtoLzBjeFE5cXhjMDhvQjBlczBDZFZHcWJj?=
 =?utf-8?B?cGdoTm8ycVdsM1R6N0wybXoyRXI3cnhlRzNzSlloWjNGWmpUVTZuWHJURzNV?=
 =?utf-8?B?NFJHaHdPdW90azJidlRPN1VLeTh6dyt5ZmJiYkJvaS9kQnBBZ2RZN2tuSXdI?=
 =?utf-8?B?VXZFS1B0cnl5eTZGaFlYT0VGVU9WOW5ib3VENCs1QllldnZZNWQvOWpXeWJr?=
 =?utf-8?B?TlJUcTU0WVR6Y1RMbWlDVHIrb3BRT0VvTHp1R1hWSXlrQzhUcXh1UVVvdHN4?=
 =?utf-8?B?bzNldFZZNW55bkVDSjB6dlFScFpybFhvSWdLWDdPT0c1anRRem5uYWt6SWw5?=
 =?utf-8?B?azJZbS9ES2Y0bWNxK0FPeDVBUVRGKzQrOEQ1ZC9iUGMvR0duVHUyR25Bd2VM?=
 =?utf-8?B?VG1CQ0xvWjlSK1JnZkp4ME8rSDM5RDh1QWJGOG5lUCt4a2VvWDdzSGdmZWFD?=
 =?utf-8?B?bU5Vd1NOeGFSY1pIakhwWFZZazNyU0VqWlVaUC9jK3cxVEpHK0cyVDFNald5?=
 =?utf-8?B?UFZnL2xnRHR1QmVZaE5GOXpielBCYWVWaHpPRVIrNUVDT3BVLzFKL1JNVUp4?=
 =?utf-8?B?SnhqeWJ1SytzVXhWZzNMRzViQ3pReTg4RW5hSlIzbUJkMklaUlVsVWZ4T2RI?=
 =?utf-8?B?VHVUOStLQ0pSNndVdyttb1JyTEpvWEFHbE5sQ0pVam9veGovSDcza3ZIMGk5?=
 =?utf-8?B?NmM5cFQxbGg4SjZ0bTU3dnk1SVFaaW0xb2V5OEljaVhJL2JSc3BXMEtiTitt?=
 =?utf-8?B?dXQ4YkVudFF6Wm83ejNTRGp3ZkxSMzV3K2puNm1vVk9pZ2gyakl6L3I1Qi94?=
 =?utf-8?B?Nk5NWi9lZ0tVTUdIU0F5N1NTLzA4ZVoxK0paSTh3L01sUlBsMUova0tGSHgw?=
 =?utf-8?B?VmNWZnBidjFSVzFPdkRMTFJBUUloSWJpQ05HV28yN2ZkL21LbFZqNGx4d1g5?=
 =?utf-8?B?SmVUOGx3Z2dyc1NJcEFoYUU2S1NremlhdzRkb0tZWVZBYXE4TFVHOXkvLzVZ?=
 =?utf-8?B?NG9ZeTV0MFBwKzBnN05tYWdJNDVDczczSnJqeUc3QU0vTHBEZGtjdWZhNFlY?=
 =?utf-8?B?Y0NsYjgxUlBmK24vUUhteDhPa0lGMjJ6ZW5mRWdzOGtqVTVUZFUvWlM1Nmdz?=
 =?utf-8?Q?wZ8A=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:42:24.1880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21548641-c45f-427c-c5be-08de3a12c638
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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


On 12/10/2025 7:38 PM, Markus Schneider-Pargmann (TI.com) wrote:
> This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
> The context needs to be restored after booting SPL when resuming from
> IO+DDR.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
>   drivers/firmware/ti_sci.h              | 16 ++++++++++++++
>   include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
>   3 files changed, 63 insertions(+)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 6f57dcfe8de8f874318cd53372c798d182faae73..74e4f162aaa2da8c3ecc1cf393ca11fa5108d83b 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2710,6 +2710,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
>   	return ret;
>   }
>   
> +static int ti_sci_cmd_min_context_restore(const struct ti_sci_handle *handle, u64 ctx_addr)


Thanks LGTM


> +{
> +	struct ti_sci_msg_min_restore_context_req req;
> +	struct ti_sci_msg_hdr *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> [..]
