Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2D4C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF37B80548;
	Wed, 30 Jul 2025 15:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FrelFV/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A162A80C93; Wed, 30 Jul 2025 15:12:56 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A8C803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi/W7nRmb4CiCEYOnTqIy5Bjhb+xD/APVYolxTs0AGZARS/Qqun0h5LTxfA/Be8bPJmTTOBoTtYPjxYcdBhgK+TW5+xTyXxAUjyD/eMm4hhZ2/lMJWMJo+HpXbAJ47fgjNKZYNXJRQmQ5a0aQH4Ib9oCqpkHb/yLu2vtzOt6UKtBd2bps/T0gM7JxEUPjOlbycoQdYg31Qs6QrZCCAIjWJq+6Z3Mxp1mbsNJTux38AVlAPyABK9ZKFmnr7t8KlZhMkVTnIQsgJfd8gERGMKrSZ0NTUablSKKl9+xV8NfOcTZPilTfzr8daQedZwmkR8kVcJiTTWHMSdc1HPRTi6oVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cydlvuvV4XHYm1odqSLOj6viGYFZd2v3ETcnTya1pc=;
 b=ebCdFS0JyZs3zzzCqUEiWxbJgbBoPGB7aQMy6rPMYqhZaNzNtK5FZ4YaCpHlkl0aW5IR3AFDnQgEIRM05oL853tE/6B8UjCrJCcGFiUQmvhi+9KW70nDRigrnbqvFW1yketyWP3ySc1j4MPln1MUB0dBJkCzBQJ+fS6j+xi7NEJ9IkucwicVRwPrinlh6ye72vS2XRac/jWnnadKOprf/fcaWKTctpVPDlX982T51pzsawMRCR+mbzi0t3JfIALSQeWawcfnzbGhQukTmQuE6Xep18BWSPfcedDA492AEwKt4/Oi5/AVdaA/q/qO0i/E3objLB/lAtqGbFVJZc4umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cydlvuvV4XHYm1odqSLOj6viGYFZd2v3ETcnTya1pc=;
 b=FrelFV/DqnXJXX7RQ1Slyw8dyLtpVqNJEP9RjLZVchrQ01aXKq32v40yU9Bqm4/FmaICKERlFHzG+65tYX+mpFZ+8k/EWqVGr1Pz2PdHrcd6FaWx2OReBP1kgZolTCx+k20KdSpaigZILsTNMdPmt6jW0+/Q9AtV+Ka9KzZcNHlVwEWV2kH3kdAkA0Vm8rh7PKKD5hiUwOozLM3tLMMGRoeyxcHSgUfKkSnVqCaRNuR/lsAfuONZ+kX++Tkohv1O3/DAfDSCoVeQFNLxkOUMLdoqAj2A2w2UUzCnBk+8snj6tO7g+xWA36XAK3jbbIhVZiUWe/BJQuIOz6or6zY3wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAXP195MB1414.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:289::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 13:12:51 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 13:12:51 +0000
Message-ID: <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
Date: Wed, 30 Jul 2025 16:12:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAXP195MB1414:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeb4b9c-e08a-44c3-d2d0-08ddcf6ac9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzF1bHp6UzNNZmk4dmZKNVBldkx6ekFPbXpvVWxFcEREcEhQZ1A3WlRoQ1Fy?=
 =?utf-8?B?aEJIZmJiTUlETHhBcVFwbE55T1VzWXV5Q1ZwQk5oN1FjeXp1eUpZS05aNC8z?=
 =?utf-8?B?MUc5QndWUVdJamlBdUdTZVpjL0o5U0R1eWJTckZiZEdxZUtnZnNRa1pQdnlQ?=
 =?utf-8?B?RnVOSE9MbVFPMzcwWFFZVFJ1c1lnUmJFakVDM3RRcXltMnYxQ1ptZEtqelMz?=
 =?utf-8?B?d0M4MkJHNjZzL3gwR0ExWE1ZckoyMUl2MlBuZjlHS0dJdjRudEtra0ZpT2s3?=
 =?utf-8?B?WnpzZjhiVUtrZ3ZoN3MrYzZqRTJNbWU0SHN0MXZSMFUrU0hGV2tYOER5STBF?=
 =?utf-8?B?OXRrVEZqUFU2anY0eTdLTUtuaXpMNDFZYitnMGl1bnVNcXMzTDMrbW1tU0pu?=
 =?utf-8?B?RXF1TS9uV1lDOWtvUnRrZHYrUGtvdGNtWTFkbmh1d0pTdHVEU0FZSEJuUDlD?=
 =?utf-8?B?Uit3V3gzWEkzSC9PbVhIaUdmL2VHSWZLd0VuRzFkbEUxQktCL1o5U2piVW1r?=
 =?utf-8?B?eDBXbmlOUVdyYW1ieDM4aDdhR3NMOHhEbVVSSGVadGZEajBCODM1ZGxqK3VI?=
 =?utf-8?B?dUFBdGlBYi9sOWhwMHFlb0hEQ2VWQXN5Vm5CbytpZjZMdklZZ0k3NFRzS3k4?=
 =?utf-8?B?eFRwSjNMSDZYeVFIUGR4eGI1Q21BRy8yK2Yrd0NnSmp4U2dRSThraFpjNHIr?=
 =?utf-8?B?dmRSZm44L2xoSEFlUWIvMDBhTnluaVFiNk5Zek0yQU13YXA1ZHNZeDBPZ0Zr?=
 =?utf-8?B?aHd2MzBKbkNwY1ZRek9HY3ZIUGN4THlhWWpMUllydjJiMTRMRXRXSWxYenNt?=
 =?utf-8?B?VGxRVUkwTG8yY1B0ck1UVm5OVjBFY2ZoTDRIZEJlaGdjWkxUODBteFlXbXA0?=
 =?utf-8?B?UGxwVW5NOTJuZEtlSERieEZhTlVwNSszcGtwY1lQcE14eXVjelkwakVqRnVT?=
 =?utf-8?B?TkFhaFZ6d2FjeC9wTTRPaUJCS0svT2gzZWptOVl6cHBxQ2o4VEdlNmoyVlpM?=
 =?utf-8?B?Mm1rMzlscFVOWnA4SWZ5ZDJJL25zU0RDbDkzdXBiaG5YTmRvcHh5ZUpNL0Jn?=
 =?utf-8?B?QU9MWDZBQU16TDZIaUVscHZpa05RVURSSTFacnh4Q1BDamlvc2ZkL2luVENs?=
 =?utf-8?B?Zmp5TTV3amRJSlRudGdHKzd1V3pHYmdtNmhlRTgvMUIzTGdiUlJtZWdURXQ1?=
 =?utf-8?B?cHY2NC8wc3FudGxYRngxMmxBblRLc2hRcjBiUVREY0dvOGhlQWtxUml5blVP?=
 =?utf-8?B?SVY3YlQ3OSswOUkxWGdDVEgzeUlMM0NHbmdZN1ViSFpMaTNKZlZXWXh6dFVv?=
 =?utf-8?B?TExCVzFLcXpEYnNEMlRQZ1ByNVlYeUhQYnlxeU01K2U0eXEvV2hVcStmWk5C?=
 =?utf-8?B?ZXU0MkV5NnEyWXpMVENLOHl3cGgycHREWUs3YU03SzdMUmcwNENjc2FNRURT?=
 =?utf-8?B?VExNRmU0eVVLcHhKZ0JxREN3VC9rYlEwMlFVbldFQ3R3ZklQUE1tT05YdHNm?=
 =?utf-8?B?ZllSMHdKWm1zM2IvTVJIRjYxMDVWT1BsN2F6ZUlHOEcwRm5HaHpGUWw0VTA1?=
 =?utf-8?B?dXBEZXJWWlliY3BiYlpucDdaSTdPUUlqYnlseHVmTzdDZUdSWmpId0NWaEJI?=
 =?utf-8?B?bkU5MGhhMkJKSDMzc09OZTAvNWU3TGxscmN2dGM4OWYyOUIvRm1wS1oxTUQ5?=
 =?utf-8?B?ZmdpQ2VTR05RWlFqTlBDUHlkUDhITTViM1ViZ3NYQWdVeEh1V2plT0dOYjN5?=
 =?utf-8?B?R0F2SUplOGVJa1Z5amZPNVRtL1htV0pzcnVDMzAremFrQVpNcWxzdFVpcjA4?=
 =?utf-8?B?cU84K2lLekprcExKL0JFRDBkSjFYY1I5WDBVTjhEcG5zNlBxRzVSZ3hrTm1W?=
 =?utf-8?B?M1dHYWhCSWFaYUliZXBqdHNVWjkxZklHWWRFaDNmSE9sbnFMVFVUc1N6ZWtF?=
 =?utf-8?Q?NtfDM+E2Pio=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkN3SzFhK0lRTUl2NVcvN2VJQktVTkVxMVpsdjFkbVZZT29xcUhUaHpTWHFz?=
 =?utf-8?B?ZDJQclY5b1YzU1dBZlFEbzNhZmlYK3FCUEpPblZienZ4L2FuRVFWWWFPZkkr?=
 =?utf-8?B?YURFZXJnYm1BWFhwQUlaVVVqOTk5cVlULzQ4RTlpdWdYQ3R4Y2ZlMFJQSEpw?=
 =?utf-8?B?RnV3UGdVa1ZxSlhMQ3RHNWZwUmpYY2JZQy9aS3Zna240dUxqSTA5cjlzZ0xm?=
 =?utf-8?B?R3JJZStHc3BFSDh3K0NjbmwrSng1NkhzcHRPVGd0NXA3SWJHTU9jbEliZUZL?=
 =?utf-8?B?c1NYOWZjelhuTW1kTWNFSlNpNkhCSDdKUy9tVzgxdDdSc3g4K2pULzNGRkJm?=
 =?utf-8?B?b284dzBJdlFxMHhSNzQ5dVl6bWJIVFhCUk4xYUFxQzdmbkFtT3I4bkdUai9C?=
 =?utf-8?B?ZjlHZ0VMQ2pVSjFZNDluMnZIMlpDaHpQdGtpZUZhVzhSeU0xSWFXNU5UR2Zs?=
 =?utf-8?B?TTVEVDJGTkEzYVVlQTdpVEVSZ2J1TmFKUjE2U3FGNnVueXpwRWxwWVNtODRI?=
 =?utf-8?B?WVJqTk1BZmlEZy9YbjRZVFpaQklkdFFkS1VjVUt5VzQvYVRqdWthbXBuUFR1?=
 =?utf-8?B?THFxM2VZTXZUbXBpZmZ4ODhzZnNmN3JMc2E0OUxmc3ZVR2p5VHY2RDczc0R6?=
 =?utf-8?B?cU5YWXVPMFlTZnNOelNxV2dSUDFFMFM5bGlPcGh1ZVIwK3BaV0IrNTVWUXFK?=
 =?utf-8?B?M3FEcml4T0l6azJySWtOR0RqaDU1MTBoV25ZTVZVNTQ2Y3FCUmlORWhIRFQv?=
 =?utf-8?B?dC9nS0xRams4ak94aWM1Q3pzeWN4RHdEK3Z1ZEZMNDNYdGUzTXYzem14QWtV?=
 =?utf-8?B?eFkzZHFpcjVjZUpuUHlSNEYrZVFLNXB5WHE4NG0vcFJRTG5jSGIyc1hmazJB?=
 =?utf-8?B?ZS9JOEZPQ0ZUQnVwV2pzWkpqTjR5KzlEVGpzVVZGNW5BZTZvWEE5Ky9PS0Jj?=
 =?utf-8?B?WVBzWUhJZWlZY0lxdzRWWFlyL1Y2MEJUZWg2SWZ5OFY2L2dUeW04V2NKUTNq?=
 =?utf-8?B?VFU0aTRUSzdPamVUZm9OeENCT2hCMTJGQ1FoLzBBeEtPMjZKaDY4NXBrN2oz?=
 =?utf-8?B?MnFpSU5FQ1YxZEJxVXpENlV4VjBCb1JSRTB2ckk3WnEvZysyWk5lL0ZNc1J3?=
 =?utf-8?B?Szc5bmw0WTZicHZjUC9RRlNjblVVMXVUZ011TUxDTTFDVmUzWE5nY2hodzZV?=
 =?utf-8?B?N041Tlp6RWM5MUdlSHpuZytjdjI5bXN0aVlZcVh5Snpicmw1c1pCdU5qZ2x2?=
 =?utf-8?B?QjNuV1FZUFd3eFViWTluR3M2K01hVlRnUmE0emg3UTRrKyszN0xuQVdMRm1E?=
 =?utf-8?B?N29zakJqRWYzOUV0SVBicWZFV1lpQittRG92bHZuRFEzRWFKQVpBeVVXemxI?=
 =?utf-8?B?aXV5aVljamx0UDhycDJDeUQ0N2pvcjI1VXpWV0g1a1dBNnNpcUJQdFBoaHRZ?=
 =?utf-8?B?MG9tK3hIcjQxVjI3a2x3cSsxdnc2VVFQODEwc3ByN0pqNCtEVVdKQStCYVRu?=
 =?utf-8?B?cUdZOHZ0OGExdVlCcHhKVWVsdE1pVkVlNVI2a2RPSENqVXdNZG9EcHYzU2NY?=
 =?utf-8?B?YnduSjZ4bmMvUFR1elpDR2llbHp0dVdldUNnQTNlVnRtcHRqak1QRUhlTXg4?=
 =?utf-8?B?Q2syeG5QdXB4REhEVUp0WGQyMEN3dmNRMTRKT2hVYW9IVVg2NFgxV2pIQ3JU?=
 =?utf-8?B?SEdDVmlaTFV5Z1BPR1NUVnYrUUQ1U3U4SnRpVGs5TEVIVUxzRnBmclhVYmFM?=
 =?utf-8?B?K1dZRXNMeVZZcUVOcy8wUmJYU2luOFNjUTRoSVRCTEZmajd5TmJUYVl4L2Y1?=
 =?utf-8?B?UkpLa1FFWU8xVnBQRjNJU0dxa1VNRzg2ZHZLSEJINWo3R2IrQjJlVXlYSXRW?=
 =?utf-8?B?cVh2ZFhiMllzbWx5VDdST2VyWmc5eW5mbU1YSDR0MStqWGEwaTlwZEcxdGdH?=
 =?utf-8?B?TEd3UWpDa1Zvanp4NHBROHBmUHRPK0U2OXdSdmYvRWRSdWlyREx4ejVOaEwx?=
 =?utf-8?B?SXAzcVlTQ0xtZmJseTJRVy9HVTErQUVaOUhmNCszMkxvSFErcFAzU21Ub29P?=
 =?utf-8?B?c2NUNlphL2JJSGhGUTlHcjBBMk5qWGoyaVh3YitjelMrcEJwSkt3bjRYUVRJ?=
 =?utf-8?Q?8rd8TVmUhg5lLq2WozOgGpMRD?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeb4b9c-e08a-44c3-d2d0-08ddcf6ac9d8
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 13:12:51.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+Wl5E2D68UhuvOrQFpJQh8nI94hncsWxJrnFm1Hw2xI8j90COHT/Jw7WeHLycE4XOwxa6g6DpyeJPc3VUpr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1414
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



On 7/29/25 9:36 PM, Bryan Brattlof wrote:
> Hello Everyone,
> 
> The AM62Ax was created right when TI was shifting to their high security
> (HS-FS and HS-SE) processes. During this transition a small subset of
> AM62A parts where configured to use the old "GP" security for internal
> and for select groups of partners but never sold for the wider public.

I guess I will need to update my hardware to an HS-FS device :/


> 
> To help simplify the build and to avoid any confusion of which security
> configurations are supported going forward remove the GP builds for the
> AM62A SoCs.
> 
> Happy Hacking
> ~Bryan
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
> Bryan Brattlof (2):
>        arm: dts: k3-am62a-sk: remove GP tiboot3 builds
>        arm: dts: k3-am62a-phycore: remove GP tiboot3 builds
> 
>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 182 +-------------------------
>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 181 +------------------------
>   doc/board/ti/am62ax_sk.rst                    |   7 +-
>   3 files changed, 3 insertions(+), 367 deletions(-)
> ---
> base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
> change-id: 20250729-no-62a-gp-c699073eb64a
> 
> Best regards,

