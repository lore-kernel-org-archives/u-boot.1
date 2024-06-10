Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5AEC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BE288669;
	Mon, 10 Jun 2024 19:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kL9BP/PW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DCB88641; Mon, 10 Jun 2024 19:03:03 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3271488651
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCrWapwFa79b4vwqWiRYhoQAynFy6WquXm5jmfmD+eOwr6ChwRzBWdy9L26BqlTwTSpnppLvr2FidGdkQHvZL3PJXjVPhzhRqNCQn6SLNVnZcnp9rD3W5yAu7ib3nikkMJCKknO+XO49vf4p197+jTxWlBYSYLhiMG/VaQiOKq6+mDTe1X+BbLxSJ0xvxfqnpZfxJLKNbMbCfbTbcF/OyNjl8oYWMW92yMk2s04XqSEEsvQoxDCZDQiuKsjSBZ+zSUNwyG7pf6MvBUh8DLGkEhx+aFypmymrB/yEY9tE0VhXBzodjFuksd2HKDE3nZqf0qC6X+Z7v/NW2x7AuBvjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RN8P3giOakKaSozssQf40AsYcPF8mp/E92URK0eyVw=;
 b=LfN6jv7OpwlEFf+j1hHF0C0yh6BTI9JWnfOK9/SEtjCIh1SK+wd2doNpjd5Nt/gr/5K28XlDlr4YfIkZS3CYaVcuiC7OAIRusdHjxrQwx85OtsYqczSZ3mdXormO9r4W7gX2yMOTWUh85R4PKRr9cp+ubzB0eLE0lKDQTk9IB8HLSJv6m3QoUPPsu1d7Yj7Thf0gym2RciZXLvzy1avEWEnxhVOHm11Uw0o5oFyHd4TxnkBPaRYYB9fiEJDs1uOrHd3YpJzFOekFgFrFc0JQMM5Ov7RoUBqZgL234MYIhJhsEQMchl7TtzBBuacYmMn/iQPzEdYs7Mii0voxtrnqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RN8P3giOakKaSozssQf40AsYcPF8mp/E92URK0eyVw=;
 b=kL9BP/PWmsG+LqIFDdBEWHKCGgb81woAt6w3gjjpXZKxxRm7rAaqVyczcaApBxrofQ2PrQx2JlxkKwDZYk7ZRcVp90sxKhLgUDIT6fDak7shQ7tgEAIRPBrtovygVRKm6uNsNSJt8FMOtidxv62nnX+Pxp15IJWCwlYOCI6Hr+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GV1PR04MB11063.eurprd04.prod.outlook.com (2603:10a6:150:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 17:02:57 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 17:02:57 +0000
Message-ID: <576352c5-54fc-4c64-8797-f33d51879a6b@cherry.de>
Date: Mon, 10 Jun 2024 19:02:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] rockchip: veyron: Add logging for power init
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240610145920.3302001-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GV1PR04MB11063:EE_
X-MS-Office365-Filtering-Correlation-Id: e01fcef6-b887-4723-4705-08dc896f2d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnV0cWtyT1cwaWpIQSthVzBNM0JjOGRZeS9MUXZPUGlLS3ExdGVLUFhqeklX?=
 =?utf-8?B?NEdWZUI3dGlLMUl2blB0Vm1qN3dnVmVKai9WVWFyYVFPSUpDQUZLaWZGaitM?=
 =?utf-8?B?c0pnd08vc2huRHpiSVBvOEY1eGtYMTNSbWFpRm1sK1lnU0pJNmQ3WUxDTXJ4?=
 =?utf-8?B?Wkowc3lLYnJhL0tHU2syRkdONzNlSlFOdmJUZ0RsTDE5OEMyY2VmZStXTkJW?=
 =?utf-8?B?RFFTelZNblFDU3h5WlRWRmhLV3Rrb1E5bEM4ZDFtQ3plekNaSG03OUhkUE84?=
 =?utf-8?B?NFc4cVRwcG8xZkE5R09hWnl3UzE1c1pPc1JuNWpIdUQ1MEVEYlRLYU1zWmVY?=
 =?utf-8?B?Zk43VXdibDNGeTFWdlJ0MHlRYkNVMmdXTzBLdTVoZ2JrYUNiQXdFK1FMMTZ1?=
 =?utf-8?B?T1ZQUTFyNW9PamFJdzFBdW5ILzVPY3BNV2tNTDYxbExla2cxenllR0JjcDlt?=
 =?utf-8?B?eU5iZVdqVy9YZnBLZ2lNN3prLzJMRUtJTG5hZzc3K3RRckpCQnFJeHRxV1hv?=
 =?utf-8?B?c0ZvVmw1bE5iSnpkNkl0bXRJczBjWUt6L3ora3VHdjVFcm9IbUhTSkdzM2dr?=
 =?utf-8?B?RWRwODlBc1lHdmJmd3lrSjM4YzU3VVFMWlZMZzJ4eDRkLzQwNEdDdjg1bWtR?=
 =?utf-8?B?dk50bUpnZit0bGFBTmtUcHlYc1VOdjVuWEJVRTZCOWxWaUNxYWZtNlJaMTU3?=
 =?utf-8?B?eFErQXlRR2phMG1IRUZ4b01ibE1PR0lhVnRLdVo4LzIxNjB0OWIvcWRtb3Jz?=
 =?utf-8?B?UXVxMjFKSmhRYmhjS1NzV0ZKUjlrV2RWb2p0N00yZEdUM1VJVC95M3l6UlRR?=
 =?utf-8?B?S0kwTzlDNThFS01HQVhvbkpTREh3c3ZwcURCcXpqTnJaeU53UUU0TlBhSXBI?=
 =?utf-8?B?djhwcXFYa0hOb1E1WnJGZnlMQVFLZjZVeWxhM3BCTGZMUzZvc1dVM1dENFdu?=
 =?utf-8?B?UDUyUWpHclZ6ajd6b1pNYm8rRkk0NC8xcEpnVEl2TTR4OUhJU29ueitoWGNs?=
 =?utf-8?B?Zm1sTmFrWCtHbmRUODBKemRzejJpSDJObFZHOFFHT0xkeE5FcysxRzBjTUhU?=
 =?utf-8?B?d1R4NTFmK0lBeEVIeXRhaWE3OU1YNFgrZW5DYllMRHByRHpKN3dSZFB5MDZS?=
 =?utf-8?B?NzdFM2pPcjU5elVBNC9CSytob0VQdXJNY0pveFBtb1BIbDhjcFVIMThCQXpW?=
 =?utf-8?B?RjlRMW44Vm9SZmhkY1l6d096cEJ2dE9UMXYxZzcvZFhwMVM5V1hvNkV4RUF0?=
 =?utf-8?B?c0dBZE5seEpwWGptK09hS2dQUHhkMkFYNkxESVFHdlArMkJ5aTgzeHhmemtR?=
 =?utf-8?B?ekdXbG1SY1pGb1NmKysyWE5VeE9kMGlSVUFHZGhNUk4vRnI0aG02aTROeUhV?=
 =?utf-8?B?Wnk1TjlLZ3ljdld2dTNFcGV5U3JGNjQ3WDFCNjRKaGg0VEZZTjY0RU5XN1RV?=
 =?utf-8?B?d1M3Zmp6b3FVc0pmSWw1QkdHVGVWQjJ0MTgzR2J6aWMzZUdQVWtLaklWUmtV?=
 =?utf-8?B?TEU4R2RDSkhITWYwS3hjNHRNTG1YQVY2YTJaQWM1Q1pJYU5seFdTZlFqTDJa?=
 =?utf-8?B?SDNXVjRaUFZoWWNyVVc2UDBLaittSU9wR002Tzc3czlSNVB1Qm1HRU9wZ2pV?=
 =?utf-8?B?a0lyMnpnaElBZ0M1YkRaRTFzN0dnbDVrTXgyZ2lDQmRoTldUQnpJWWVVanNj?=
 =?utf-8?B?NlpGNDlxZElTcW9Xby9wMm9KcElSQmZpbkJjM0dLcGw4UVBqSzMycDJ0TkU0?=
 =?utf-8?Q?UQ5Gs+UpGKxY04mGGH6txDME+wWNjaniz7LLu9P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpkdWM3RFJKczF5MzlvVzYvb0FnNHpmZXZCVlV3eDdNNmlOcmRoZVFXOFlH?=
 =?utf-8?B?QlN1b0t3cU16YjFKTUYvZVN6QjRRYkUrVmlDL2tCV0FVOHFsRDNoVUk0Q1Ni?=
 =?utf-8?B?RmRtZjBwZjV4NFpYRUhDYWJ4c21nRFMyYjZHbzZ5RWZyZm1zbWd1U2svNWgw?=
 =?utf-8?B?ZFpqRDdLZ0pFVDIzK1NrVzBielRNMnZOU0ZRVlQ2SWRGaTZEMERiYm9QM05u?=
 =?utf-8?B?RnN3bVdjcWFtblR1VEpJVXpBeURNSEF5M0UzL2wwRUY0bjBuVFUyaGNRMllH?=
 =?utf-8?B?aXFSNzhPemRmRmQzaUZxeW85M1htaXJENWhYZmZVYmJZU29QNWFCNC9ySEZC?=
 =?utf-8?B?VGdIS2swcjBGTElyREtaK1UvNWFKb0VGVGJhWWVSa3l1Tkw2M3YyellQTUwy?=
 =?utf-8?B?N3l2V0kydW1KMDRlZ0pnTmIydTExSDJ5eVIvMmFQamVHeXpsd3hDVkJoMHAy?=
 =?utf-8?B?STNjUVgxUjFnVEtZMjlFbHhEUEpycXpTRkxQaEhQMDJ3VmFITGNUTXZMem9Y?=
 =?utf-8?B?M2t5VWZjU1gyZ0NMcXRCNWhLeHBrQUxPaWM3MTZRSGlFbFpkU1ZTZkxUbWVu?=
 =?utf-8?B?NGZmRFNTeHFnVTdHNXUyWmlmQ3RhUTg0cExRUml1YzgrbHlHMjQ4TVNXWTRz?=
 =?utf-8?B?NW15Y0FPZHFhWHd6K0NPK3BTNjI2R3RpVUI2TEpNbllXR2dCN3R3MXFnazg3?=
 =?utf-8?B?WU0vOVNPK3BOSjdXYlEwUUYraU5rQ3ZwWUpSRVZQUkEwbWZEVXppOWczT0w1?=
 =?utf-8?B?TG9pbGpaYmRPV2pGZDNGYS91Y25CVkxPQ3pFQUppUnp4QzlJTWNjWThiWEUy?=
 =?utf-8?B?MjhqQXpOcHlkVXRKcjFLM3Jkd3VSbjZuNk41R0FkNUYzbENMYW5FbENWY3Rn?=
 =?utf-8?B?bTRORHhQb1lYTHBmR21JNUlVZ0RxNVFacWo1aUNzSExUYUNnZHhlYmRBMk16?=
 =?utf-8?B?SmlwaStIQjdIWDlJYzF3dDF3V2tmNHp3SWVxemprR1V2NFFFaXRGeElqNG1j?=
 =?utf-8?B?OGpsQmtXVUZxWjg5L3crSHpkcWFybVhVWjl5WHRTZERhdG1sNzFxZnhxM0pK?=
 =?utf-8?B?NFlMSFQyNFJyQ0JyN0VkVVF4YVpvYUd0MVpMZ3RnUFpyRHZKQjdBQTl6MFRz?=
 =?utf-8?B?ejI5a282eXMwQXNkMkcvbXJLSmg0N2pFVmU4MXlucFhvMzYwK2F6T0lxcmdH?=
 =?utf-8?B?a1E2RkxwQkVOWHUxdGNyZ084dWxwblo0UFJNV1pPb09OL3JBZythL1h5ZTJa?=
 =?utf-8?B?Tk5FZFdXWS9BMU0ybmlqWll5aFdqMHVDZVJVZWlXV3ZIeVg2dStyTHNLVStO?=
 =?utf-8?B?cTlYbEFkOTdMQko3b2lETUJieEpEUU1KUjhXVU1hT2lWWTBLLzZ5NXV5V3FK?=
 =?utf-8?B?ekxEcFdtejRaNnhySHI3blZnNFhCczBEZ0dmS2ZWY0dVOHI1cmFoT3pHNndW?=
 =?utf-8?B?VzN2TExXdHJDVjIrbUp5ZUc2YjN5eUZ3RGFuYjNlWHpnUEJTbXFSU2ZIZnF0?=
 =?utf-8?B?aC9HNlI1NVVzSS8vdzdPbk1TMHQwdVhJeUdlSlNjSXJ0N2xjMUptN3JHSk5t?=
 =?utf-8?B?anRiQ1VEZU9zdHFFanAyR1lhVkF1RW44dVE1UkJNdEt3UUNPOTNUUE5qeVNy?=
 =?utf-8?B?OFk1N1BuTWx1aEtsTUFJMFhwSzI1clFTM3grV0hsa2M5RnVKVFZ1a05MWmM2?=
 =?utf-8?B?UE5xaVJSVVkydU1zd0cvdkUyMlVkSzhIL0JsOURxUTVINXZMOXMzaGYxalZ4?=
 =?utf-8?B?eFZZUERreENpL2xaMmROb2VPUTA0MWpOd054SVV5djZFblVEakorY2E1Ynpq?=
 =?utf-8?B?ZDM1ekFkSjdjTmtMVno4MzI0WmtlT1Z5Q2hQbDI1SnBWSFFIWDBKQURnanJV?=
 =?utf-8?B?NVRKTlpoTWxJaWc5Wk94NFJUeVBySytrQXdaWFZMMmEreDhTc2k0WXpMN2Er?=
 =?utf-8?B?aXFBdDNtQUhYVEltWHJ3VEpxRnoyd0F4TkVGUmpjVHgvS1R2ditzMXR6RTZs?=
 =?utf-8?B?ak53QVpXZkNpL2RNOHFWMUtqNXZCUUQxcVV6TjFuODRBYURPZlVrc0lid2hN?=
 =?utf-8?B?bnRyNkVWdkV2ZVY0YmhjWjc4Q1dsZGgyelZuYlRNbHF4eDlxWU1ESEQySkNh?=
 =?utf-8?B?cXZ2SFZTdVkzVGtYNHo5Vm9VaUg2SlU4cUkyUjJ1N0xNMUJiZmRxSTB1a2pB?=
 =?utf-8?Q?t1fKhnin454s3WEWQ4hYx2I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e01fcef6-b887-4723-4705-08dc896f2d25
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 17:02:57.3500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj1CsRLYe2mzAEXG/gswFa3ROx94PCys+j8IDL2yYCfrHpvOdFU4i9JHhK8A/c3B+lKPKFQao13Fhz1c3H41yhuSdJPT9q+3384ZSrCWUkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11063
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

Hi Simon,

On 6/10/24 4:59 PM, Simon Glass wrote:
> Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
> be enabled.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
