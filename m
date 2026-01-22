Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9064FC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 10:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E3C80086;
	Thu, 22 Jan 2026 11:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UFdKnbAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D9780077; Thu, 22 Jan 2026 11:15:53 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934F380077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MABd/Oi+KyqSy2TAbvaoXbEQozFMDFWGosQyxXvS3yoV5IeRHoGrCKdbXM83RSYyomcxzEMP6AAO3LLoANOR8Ee+JJreQY3biuM7d0+IesRyO12DDRhjlLP4YuYWAg0G5DfSvyUQDgn9vb9/Cd3CtNMDD+l3Jp4q1/yjlH1W6iIFFdcsCy06CJbFKANcSwQXl34wpetsWTS/pTWOjY+1byhj4140i9pCKZuhkfq6iAG1EguDc3W5DAAo8axoV9donFSSX1b6rc+YRAuZRJzM7OJuKrTmWXMzbvFJRTH4DE2zJHEf9WlER0Zgl0OoGQ13GKmat0ZHym4s6YtpKqit3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z0ACi+k0wR2Vfu5w3RH0f53THbuxYLwdOBMu8K8tKQ=;
 b=Gl0y1uSXksH8smEuT4Uh7JuFhw0fQzlr9qDX+66ybXmVt0N8sttBDIJodYtKnv36BLPDw90NKgnMCFcFjm3EIt26EwEPqgIVz46JxiXDC2+81zW0O3E9chFiQMRL/o+BWxvS6dC3Wj1Yk8M/DxiK/uqJAagzdu9pL4WlImoWrhC3sUjGb65jRTaOEFpcOJtvVktcxdrKMQVnQd33TfbaMZVWh8m6I46KgO71bDPTGy9SPz2wDsItjuaEzYVP1O6LrMXHQICKBGuWBvnogqjJIlbEfS+gNfqjNvIp5ElaJF/xTkQFu8232WlXX3RHre61ggmDCw9ZIxEXveiRDJP1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z0ACi+k0wR2Vfu5w3RH0f53THbuxYLwdOBMu8K8tKQ=;
 b=UFdKnbAHpNj3nyrlblHIHJe2aWjALh5vgFZZMe28IOeTbv76Rjdl6xPnz/onATlHsM9tNdNP/N57u6F9/r6Yfa2CG2tfxGQR989wrAaMikOe5fes+P+TdtkPrhfq1pL7az4k3ZeBP+zTcdFcvKyQJfulKdx9s+DXCFONNI6Qlz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by VI2PR04MB10834.eurprd04.prod.outlook.com (2603:10a6:800:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:15:41 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 10:15:41 +0000
Message-ID: <32928d7f-ff2d-434d-b6d4-a1a2a8704246@cherry.de>
Date: Thu, 22 Jan 2026 11:15:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-3-hs@nabladev.com>
 <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
 <3c02e1a5-aceb-1528-078f-80b695f741dd@nabladev.com>
 <77fbaee4-777b-4d8a-afa5-239d8e0974e2@cherry.de>
 <1c9a6853-9acb-9665-78f4-d5c051bf9d2f@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1c9a6853-9acb-9665-78f4-d5c051bf9d2f@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|VI2PR04MB10834:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f6c96a-b4d1-489c-6127-08de599f3236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTBqRkt0Yzd5bDJGRks2UXQ0aWlSTWJYem1hWHlFQzhUSENVT2ppNXBqTlZr?=
 =?utf-8?B?UWV5VjVUQlMzbEV2U1R2em4rTzFxaVhDVENRQkl0TTdPbmhRcUVaTHQ2Tzc2?=
 =?utf-8?B?clF1NDQ2ekI0ZXI1L2xBYWtkWEFzdkZzYlVVOUllaVlPcGZyekc0U0pkWWFo?=
 =?utf-8?B?ejRIaHRZNzlmTGFhMG9rWWo4bjRoODNVTDZHSFA2b0J5di9VcmJoVnNMTXAv?=
 =?utf-8?B?WGpPQU5DZ20wa1MxVmZlZUR1ZlB1NzNLbDFISjUxV2VYOUxhMGdISDdqc2pH?=
 =?utf-8?B?WWt5Rm81anlFVnNEYXZBQTJmYTlRZmR6cVkramw2Q010WUVGZzVHYWJQMGxk?=
 =?utf-8?B?VVNjdEZHRTk3U01wQS8ySGlyZ2RZM1JkUVV0eUIvK0FlM0JSUDV1a1JUTjND?=
 =?utf-8?B?a3FPSjJNeXhlakJsZFJqQkxlSllPWWpiQXRIVjd3clo1cFNYc2VENlpaUU1i?=
 =?utf-8?B?aDBLQ3o1QVEyR1FRMVU2RmpBOUxlYXVqaVFSVDNyUHQwSDVCOWo0Zk5PdGVG?=
 =?utf-8?B?WFRlVEk5b090cU0xS3FuQ0xzd2dWL0NUeDg1eDJKc0Z5dEZyYzM5Y09VTEUz?=
 =?utf-8?B?ZmFVeHZ2anRRL1AzbDdBbWo3cFE3bHBuWjBEUDFDNlZ2eTZGeURXcVlrdjhK?=
 =?utf-8?B?bVA1T2ZpZVNJUGlaS1FMZ3paZDhPRmRCNnM0NVBHVzNYNWJrNUZlZVJQZUQw?=
 =?utf-8?B?eC9jQXBkdEpGL3U3MGo2UzZMUzh4NG5UL1pLVlRDNTlkdENIMEtTMVR1YTdN?=
 =?utf-8?B?QU54Zmx0ZXhGODZwZ0xNaVNpUHFNTmU3KzVPS2h4ODd3SkIyenpPb3pHdUla?=
 =?utf-8?B?ZXNmbElIcC9ubEs5ZG1MZ3NwTnBqTHBzL1BiUXpBVUhmVEIvSnFxL1lEWDl0?=
 =?utf-8?B?UnlCVERpVzRIL09KN24raHQ3cFFoRjg1YWNGWkcwcWF0WVZDK013aFY3TEVn?=
 =?utf-8?B?TTk3Y0ZIaUY1L00zaG5CV2pGUHFwYk1xbUFLbW01a090VGxKOXhhcWd3UEw4?=
 =?utf-8?B?MEhFclhFQ0pmK012aFBDa1FnWUFFM25JM05nZTJrS0RiZzdocU44Vk9VVUo4?=
 =?utf-8?B?aklzOEFmdEdUR2oxYnltUHFuMjNuZU1ZSFljYnpDc3FncEd4YUhZMFZMN3Fy?=
 =?utf-8?B?cVplTzhSckdtQ0hpZ0hmRkdFcnBRdm5KZGc3blMvU3NuYjMxYzRPNzVXbk1w?=
 =?utf-8?B?YnljMjU0N1hJdk1QV2lkNVprVk5raHJiVGpCYzhzUGRwdS9xcENJdXBnMUdW?=
 =?utf-8?B?TlhaeXBuenNzZ0l5M3NGZXBYb0NJZXpTVnYyamdERUFsRVdraGxOVnluWThM?=
 =?utf-8?B?YmY4MmlvdlRUQXZUdFJONXcvaWw1QUxFU1Y4aXFVL1NBQ2R5ZEFaNkNYdEgr?=
 =?utf-8?B?THR5MzczS2tNVHFHMUlldU1ldTh2T1MxakJXRlBieHJHZ0dMN3d1MjF4bXgx?=
 =?utf-8?B?SE5KR3dVZXRCRjBETlg3QTlYeGNpbjcvY2w1bDBYQ296VmsvZ3lEY0NaM1Q2?=
 =?utf-8?B?ckpSMmtHQjFjb0V2UWFKK1ZueVI4MXM0a0c2ODVqdU9jcjd6d0VwcWZRUW41?=
 =?utf-8?B?dVgrWUJTTEhXUC92WWExOG80eFhZUlZZaU82MFVTeVlsODQrVEtWWTZtb0Fj?=
 =?utf-8?B?MDNaanpwdFhHbC83U2YvMnQ3NDNxSlVIa0pIbWNKNUJyRmgzYVpaQUJ4dWdQ?=
 =?utf-8?B?UlpKTVRTV0pEV2R2M09GSTc5eXJYZlUrem5FLzUwQ21TdU9OQ0VxNkZKd01F?=
 =?utf-8?B?ZHlXMjgxQlZRdndlRWV2ZFNWMW85NjRSVFJZd3BCaENFUXY3MjlBNzF4MWFC?=
 =?utf-8?B?ZHpLMFlNU21MbmRDczlaMkwvU1VoVjRpK2Rvc1pGUkxpVlg4Z1dnd3N0VUFp?=
 =?utf-8?B?UFVxa3VsSFJTWFlPMUVQUTBiVjVhSXN5MUd2bnBzZzJ5NEtzTEZXWlJjTkpB?=
 =?utf-8?B?OHV5L09tTkdQQUNtQS8rZFA1U1N4Zlg3OHI3QW9aYk5Bc2Jya25hRlp5cHBk?=
 =?utf-8?Q?tFOt1oIYIQWlL+z6rk8BP2Xz8opVPY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFc2NjN0UU81R3B1Smc3OHJWUGlULzFRK3dBZW9BMy9Kc29CSnZ2ZVhlajFO?=
 =?utf-8?B?cndhbkdROTdKWXJuMmwzb0REM1cxeUJzZUxmN0FqWXRzNzV0N0lqYVJPUGFB?=
 =?utf-8?B?VXVXV2dPM1R5V3pwck5Ed3l0ajZMelI4TkNrdjBuU25hZk9pVWJqL01ONWd1?=
 =?utf-8?B?TTJVRlJ6TmdrU0toaTJSUGJHZEhhZHdQdk9ZN0pvWnJJeVpkRGxodXZrMXlh?=
 =?utf-8?B?YUlVWHY0SHk1M0xHTmtHVkFBWWZGSFduMGw5Y2daTjZnaStiYTNjQ1RRWFdU?=
 =?utf-8?B?RVFlYWQyZnZ5R1hsRnFwRUo4YURuMjRFVy9XMEpNajRrVXNyRnRNUjVMaXVU?=
 =?utf-8?B?cWp5aVFHTWtYSU14M3NmbmdhNlRISFR6VUUycGRVYklpd1lFWjZyZ3grMXoz?=
 =?utf-8?B?VWNESTBuRlpRMzB4Rll5UGx3M0cxUDk1Uy9OMkpZakhmZjRIVlUrZ0lqS1Jy?=
 =?utf-8?B?YTVmVkVQaDJkUThudjc1KzJWa0x5SXBtZnR2RkNERVdKM3ZlQ0Jwd21aQy84?=
 =?utf-8?B?cXhhYU5QOHBUb0ZMc3pMTnd2dmVoT2s2Z1Jrb015eTMrakNvcWtEL1IzZEMw?=
 =?utf-8?B?dHBBdVlzRDBZTWFGUUtMRnNnTE9xZ1JOT2xtNld0OW14YTBocjRLQmVObzBm?=
 =?utf-8?B?M2lUNVdlTEg1cXRvQ1dRRVpVdnJleG5DajJXa2ZQc0hkTkpzTEp1bXVselFB?=
 =?utf-8?B?ZHF5MGJSOGZ1bGJMZW1BNFVHR3hGTjgwUWo5UDhXUFl3YlQzVTBNNFUyY095?=
 =?utf-8?B?YWYvbHV6Z0JFNGhlYk9UampzNEJDY2l1d2VRd21ZdGtKZ0Z4ZEp2YlZGZTFm?=
 =?utf-8?B?eU1BQW85bDA2K0psNDM1bytCa0FCN0MzL1gydlRsZ1JleG96ZmRHVHYxSGI3?=
 =?utf-8?B?c1krVjhTRGlYaGxuM2tzMVdwQWtZcEpnVlg2VDVMUDdpTFAvZkJkRnJhbzFr?=
 =?utf-8?B?Ri85L2dTSHo5NWRjNU9iMHZKbkl0Zmx3VUlmYURDWUdvRDd5ZXZLWnZ3Y0pF?=
 =?utf-8?B?cUNUcG9qZ1pIZ0QvVTRvc2JDVE1yeVo4ckMwckwwbFhxRUVHMTFnaUI2SkU4?=
 =?utf-8?B?eHJYL3pLTmxXRi9lM3FZL2pzeTV5eGpqUGZVUkxCRmxDVlV2Uk9JQjZUZFh3?=
 =?utf-8?B?NWhoL1Q0NHYrcGIyYnBZS3Fsd3N2UVNIZXR5VDkvQmhiYUVVY3dVUDhzREtP?=
 =?utf-8?B?TFZiVzRDSGVnVVRBSXhBczI2NDY0UExDcDlJTStuQUxBQ3hiY1NLeitzMWJ2?=
 =?utf-8?B?emtRNnYyY21PMHh6cVZNY0xKdFdOekhoSVNJc0xGaGFsbzZzeVNiWEhDNHdm?=
 =?utf-8?B?QldISFhsY2FUaEdUOFBUNzJ6SXdNMkc3ZlhLT2hZRS9rUHZISDdoUUs1NzR5?=
 =?utf-8?B?QWtnTisyYzRyK1RBUXBlL2NPcVpHMFlQZ21sMDJRWE92RjFzR1ovNitYRlpJ?=
 =?utf-8?B?NmlXQURrc2F6bXgvRmNTd1N4VjRBVFoyN0x0V3lUL2plTGdwVDRQWGFQNlVZ?=
 =?utf-8?B?eDRLUmFpQmF6MnFLRy9lY1ErRmxFT0ZwTnROZjlEQXdLMFhXSTltaWt5ZzFz?=
 =?utf-8?B?UFBLY21NVzFZMG1nZTVJazR2UU5vRUJ6MEdTY2JZZnJjcll0L0FWMGcrVkQ0?=
 =?utf-8?B?L1pidXFqSkxqaDdicVk1YXlqM0ZvMlc3T1dUZEJITEVzWHZ3akhaRlkvbWo5?=
 =?utf-8?B?cDJYVkJGMlZ1NEJOYlZ2Vzd6UW1qTUVBQ2FGbWpxMERWZ3Z3eWlvUHBxeFZr?=
 =?utf-8?B?MXh2WGpXc3R6d09pMlF0dWhkazJieHJxMmZVTk8wZmVSNWliOExqMjMxT05W?=
 =?utf-8?B?c2pOZ0lGS0J4SFhxbmxhMmNBbzlIWmlFUndWSEtvTnAyWWdlU25LQnVMaFo2?=
 =?utf-8?B?aWZHWWNLVmprQitlVXRTaENwMGtINVVrUy9uVnUzaEJpK1ZHeFdvTTRqZzE5?=
 =?utf-8?B?WjI4VVZRbmF5SEdrTFNCTnZ1aTFEejFVNFRzdlVQS3JMRmZJVWhQTEl3aENl?=
 =?utf-8?B?cUpBWSs2dEh3TTNqMmlIMm9POVRwUnpTbzVaQjJSYkJ3V3F1RVhuZjlieXBS?=
 =?utf-8?B?Q1NNSmVjcWRZbFdVb3Y1NUVzd0hkYlhSSzVVMmJYOUZVWFhsQS9ueVFsNExr?=
 =?utf-8?B?VzErZUVxY28xaVZHNEZneUtkSDJKYjNPOHBQOXFHR0hRM2dlSDNUMUFDQjJu?=
 =?utf-8?B?RFlUd3JJUkVVb1c0QWVKRGUzS0k2RUM5SnRYcFRXTmxmTEd4UGtSQVNPa1hj?=
 =?utf-8?B?SEV4OG9CRFVDUVJpTDlrc2NEQzZWdzlhS2piaWpEUkt4bElRcUtEbnVMSWRh?=
 =?utf-8?B?RWJMek9VVFNJdGNhV0pISCtBSGNwTGM0bGt3M2JMeEJzZndrck9aQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6c96a-b4d1-489c-6127-08de599f3236
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:15:41.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ5Nas9iD/HUtNae/sO4MWs/CDbJ19TDW5DIap2B0HdSxUIWfH1CtDDo1KnfBWNUiZXJ9JmJ8PFfkzDunnLd0edzKlDVrA2dS0aRM7SSn4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10834
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

Hi Heiko,

On 1/22/26 10:40 AM, Heiko Schocher wrote:
> Hello Quentin,
> 
> On 22.01.26 10:24, Quentin Schulz wrote:
>> Hi Heiko,
>>
>> On 1/22/26 10:12 AM, Heiko Schocher wrote:
>>> Hello Quentin,
>>>
>>> sorry for long delay...
>>>
>>> On 14.01.26 15:22, Quentin Schulz wrote:
>>>> Hi Heiko,
>>>>
>>>> Typo in title, should be doc: and not doc_.
>>>>
>>>> On 1/6/26 3:14 PM, Heiko Schocher wrote:
>> [...]
>>>>> diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
>>>>> new file mode 100644
>>>>> index 00000000000..3b157779a0e
>>>>> --- /dev/null
>>>>> +++ b/doc/usage/cmd/sm3sum.rst
>>>>> @@ -0,0 +1,117 @@
>>>>> +.. SPDX-License-Identifier: GPL-2.0+:
>>>>
>>>> Use the canonical version:
>>>>
>>>> GPL-2.0-or-later
>>>>
>>>> c.f. https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0-or- 
>>>> later.html&data=05%7C02%7Cquentin.schulz%40cherry.de%7C752a802f23394270c5f808de5996472c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639046699157004614%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=hFPbf2cm4pcD17T8ORnYC%2FL9VOWm2s%2B8Ebnb6TMjru8%3D&reserved=0
>>>>
>>>> (Do not end it with a colon either).
>>>
>>> okay, but I just copied from other files... for example
>>> doc/usage/cmd/dm.rst:
>>>    1 .. SPDX-License-Identifier: GPL-2.0+:
>>>    2
>>>
>>> So of course I change it... but does that mean, we should fix all other
>>> files too?
>>>
>>
>> It's unnecessary churn so I would say no. Considering I had other 
>> comments on the patch, I allowed myself this nitpick but if that was 
>> the only thing I was bothered with I wouldn't have told you. It's 
>> still clear we're talking about the -or-later version of the license. 
>> The biggest issue would be with GPL-2.0 or GPLv2 for example because 
>> it isn't clear if it's the -only version of the -or-later version 
>> since it matches none of the SPDX license identifier.
>>

https://spdx.github.io/spdx-spec/v3.0.1/annexes/spdx-license-expressions/#simple-license-expressions

specifies we can have the short form identifier with a unary + operator 
to mean -or-later, so this seems fine actually.

>> I don't think Tom will want a patch to change all SPDX-License- 
>> Identifier from GPL-2.0+ to GPL-2.0-or-later but maybe I'm wrong :)
> 
> I think not :-P
> 
> What is with ending ":" ... above example has also the ending ":"
> I removed it as you suggested...
> 

Ah. I don't think this is valid.

https://spdx.github.io/spdx-spec/v3.0.1/annexes/spdx-license-expressions/#overview 
has the exact syntax of a license expression.

https://spdx.github.io/using/license-id-in-source/ specifies how it 
should look like in code and I don't see a trailing colon. Whether that 
will trip license parsers remains unknown.

I think *this* specifically should be fine for a doc/-wide patch.

I think this may stem from editor plugins automatically adding colons at 
the end of a string started with ".. " as that's the start of a 
directive in rST? Or maybe the first contributor made a mistake and 
everybody copy-pasted it :)

The kernel doesn't have any of this kind of strings and it specifies how 
to specify the license for rST files here:

https://elixir.bootlin.com/linux/v6.18.6/source/Documentation/process/license-rules.rst#L80

>>
>> [...]
>>
>>>>> +Description
>>>>> +-----------
>>>>> +
>>>>> +The sm3sum command calculates the SM3_256 Hash from a
>>>>
>>>> Are there variants of SM3? From what I understood, it's "equivalent" 
>>>> to sha256 in terms of security and efficiency, but it's SM3, just that?
>>>
>>> As I know, there is only sm3_256 hash. If you look for example
>>> into include/tpm-v2.h
>>>   33 #define TPM2_SM3_256_DIGEST_SIZE 32
>>> [...]
>>> 277         TPM2_ALG_SM3_256        = 0x12,
>>> [...]
>>> 301 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>>>
>>
>> So I would say we should use ``SM3`` here, instead of ``SM3_256``?
> 
> No, as linux also use the same define, see linux base:
> *   6c790212c588 - (HEAD -> master, origin/master, origin/HEAD) Merge 
> tag 'devicetree-fixes-for-6.19-3' of git://git.kernel.org/pub/scm/linux/ 
> kernel/git/robh/linux
> 
>   include/linux/tpm.h:
>   55         TPM_ALG_SM3_256         = 0x0012,
> 

/me shrugs

No strong opinion.

Cheers,
Quentin
