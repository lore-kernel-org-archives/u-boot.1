Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB77C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AAE88387;
	Mon, 10 Jun 2024 10:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Eu8k1nMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C698883DA; Mon, 10 Jun 2024 10:33:57 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E08882ED
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkmTDp7bPXG2ymk2slq6bCX78RBdgeZWn47F4FL8MQoSmLgqnQxK0QXgUXTxaLGqZrHh+dm6TqlmCjOhYJMiDXniTwyKe4Pp4UQft9b4GFqXwABcAHW1cB26o3RVI1Z/ezRNnd8NY765zNACV1ICZ7skyPPxpxNe+LtcvelA+6JMgl+q+yPF/iB9gyhUvxdsPCL9HEi/wSt1fyeQ8xQk+8/pL1l83D/SjvpLJK4pkx/u5EO4kMNk5jYjdqCpVUNKUiUkBsMza2g+5XUy/PgEF+6R2AmbkFU29yd+oFLK0cQtYjBoxuQUO1mnmKPEaN1Bl9hNFI3qxhHUP9Aj6JHyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaLTElxzCzdxGz4BW9WVZF9tY/Q4ljkl+5eQqyypFKc=;
 b=apD2rxdflkmOFTg/pIys9zW5Kr4a6FE10ndqnVR1eytE+nwAP9Y+XfGwF2IUK4vl/Kg0dTW7jrqp5XdLi7mtMSXcBCKRrrIJsVWfxWYGRav8jymVZ9YqQ2wyjLYCyhhDnbxgk107zOox6Cvl9bj5lYhC/5k8c+SqDNWZv1aCdgVW+S6Lctngmt5GjW78gRx96pPyEJLXiwvSz+xA3wtuF5gHLvaWvyFAD+lYeP5mhJd/mBPPxVoswA+C6RRPTlpXu3CqJnlgn3rFDzg+lTthA6JSMqq+25oQ4Y+Oql6J4TT8Wqhqj9OMNvsnmE7lV4VtwpTaUn2AYlkyC7xTo0ik9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaLTElxzCzdxGz4BW9WVZF9tY/Q4ljkl+5eQqyypFKc=;
 b=Eu8k1nMTPM1OMrIgxf13BPDHouvohq06XQzjhQAHDiDpOeSqfzsooluJ2L2xwJENucGffJZHMRtbxtUKZwE7tYCWqppFh2F/IM+mEquvTgPkmyJ8xCPl43RH0dK5W7EIoP5I+m7o9APLE6D+LkShzsPtSH5CvO5RZz7R63EeRHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8334.eurprd04.prod.outlook.com (2603:10a6:102:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 08:33:51 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 08:33:51 +0000
Message-ID: <5df3fe93-5e1e-4000-aebd-ff2090abf68f@cherry.de>
Date: Mon, 10 Jun 2024 10:33:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dm: typo prbing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: df18cc5a-545c-42e7-c470-08dc89280e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFg4Q3RKaVoreDFGOHRkSWNRc0FSV2NkQnpwRHNDdm5QVmliUTc3UXVVY0dk?=
 =?utf-8?B?WVFreEdzRmxYdVAvQkJzSnJ1NnBHd2FDT0htM0RjWlFxaHBwN25VRGhGRnhL?=
 =?utf-8?B?WUN2Z2lpeDB6S3JBK1orbHB5dE0xSmVWVDhISkdTSkhJU3JONkJWVFdYemFu?=
 =?utf-8?B?YSsrcFBlb0hpTzJLVmNzeG5BeGNZdjR0NWVpTlM4QmtkODhZa0NCcU5QZENn?=
 =?utf-8?B?QS8yYXI3K1ZPN251UE5RaS8zbFQrdEpRc0NQbjVYZ1J1cG8rRmdwZkdyYzRE?=
 =?utf-8?B?WVlTZExFNTgrcGVHV2lOYkRtYVY5RjN1QStXY0hSSk8yWlp2TG5YcmYxd3JQ?=
 =?utf-8?B?WjdxUjdjWDNQZ0RWcXFwQS9DUmRYVjR0VHZZQVBOYnFmWkVCMjJ5cFVvcXMv?=
 =?utf-8?B?TjYzRXVRM0IrVHpPTE9JUDFBOVFNQ25aVFdrcTVPdEtjRUxhNWwxRTVYNXlY?=
 =?utf-8?B?K3I5RHpRWElPU3J6QnBaMVFxQS82eDdlZFV5a21WZ0EvNzY5QkV0eE9qdVNL?=
 =?utf-8?B?QnRJdll6RGM0NUxNNVc2bHlVZzRjZ215WmpzMmhoYitsY3BNR3R1LzJCYkFD?=
 =?utf-8?B?WEM5Uk41OWF6SzZZV3BJb0kxQVFtYnNNUzl1QlR0dVVRT29HOEJLMHYzejNQ?=
 =?utf-8?B?Q3I4N1E0aE5qRFRSbkZjd01NU0pMb01ueUU3WldMVzgrZ0QzVDJJRXZPNys1?=
 =?utf-8?B?R3VxK2tpZXBERzJEVkhHN240ZUFDeTNHbDFhelpvUzhLV2RuRC9tT1NYRjBB?=
 =?utf-8?B?dGUrbFMzbFdXSDJKakJqOXNwak53c3ZqTVdGbEVtZWtUS25kYWxBYUxKSjdC?=
 =?utf-8?B?SmJsbitqTzY5QnNyUXh6KzNzUW85RlpERzE1b2ZBZmZMdFlxVjE3dnYrQUt1?=
 =?utf-8?B?OXpLN25vZlB1NU0zdytobUhza2d6VVpWalZyR1VTWmtpQ1FjRkJFaWJ2YzNy?=
 =?utf-8?B?c2lES2pOVVdrUkVQYWFNWElROGROMkRDRHZXVGFTb09oYVl4UmhsTE1PanpG?=
 =?utf-8?B?Y3ozWmxVeHMwR0JoNUErZnVGTnFKSkdLcU9icFhiWlk3bWd5Zm1ISDJaM0Rz?=
 =?utf-8?B?TXpXRHM0eEhoN1VQOTNreVg0dVFzV2RYQXQvS0ZsTlV1RnI5RHRUUTRialZY?=
 =?utf-8?B?Mi9oZHJZa3c3ait2MXllRkJiaEtueWRnUU9pTVl0UFVBeDhyakY4YkhuRDFu?=
 =?utf-8?B?bU9mMk1uVXdXMWRickRNbHc3dVZmc20xRGJyMWhLcUJkdTFOeHdrVkw3K2hr?=
 =?utf-8?B?NmpoU2VyNmNxME8wK2dGNXU0N294MDAxT2dEenNSTE1ueFhzTXRmUlg2bDVm?=
 =?utf-8?B?QUhtb3VQRll3M0hQMzBQSGx0TkV5alB4UFJ6cGNFbkV0VktEL1NZRzhBVk01?=
 =?utf-8?B?K0RvaEJhZXF2N0hzQnVlLzZJc3F5NXZSdGhSMG9JZ0ptNEdoaWpacnVIdWsr?=
 =?utf-8?B?empoRjFVQ2VBcDRGT1pXS3kvZUl1VGVxQU1TazlhQXJocStMdVAvd1pOQ1Fa?=
 =?utf-8?B?YmEvSGtvUlRFNFNSdDRWMjlSdkNuTGcyMnhJQmVKdjNCcXA5WENvbTdDam50?=
 =?utf-8?B?VzlzUmp2dlZZK2Z2MlUwREZPcGhiRlFSZkN3RVArR0J2WXk4eXBnWmRiQmlU?=
 =?utf-8?B?TFAwZStQZkp6WlhrZlpJbVVsVjFIZ0JiMG0wbzFWUXdhZmRIL056eW5pakNB?=
 =?utf-8?B?alc0Z1g1QUlwcmhpdHBWdTBVSUVtWjcreFRRM2NpN3hIbWNVdzRXWlc3U2sv?=
 =?utf-8?Q?Y33w77jaCylBhKxoG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0tReWNudXZVV21MbHJwS3A2ZGhvSCtLT2k5SW9XaW1wbXBYWGZJc2JmYnlh?=
 =?utf-8?B?QjRKM2d5cE9TY3E1NHA2TUFNbC9XNnVyN0dKWWpqMllNZTVwYWw3QWxUd2lI?=
 =?utf-8?B?SHZqelBEUUpBNmVaNDF4S3ZSNXZaUmFPL1RORGl6dVQwTzJ4dnhSRitGWDZB?=
 =?utf-8?B?cWxOeFU3bWxRRXRtamYzeG5xakJieU9DRml2ci84UEd6TkNGNzRHZ2JtNUpt?=
 =?utf-8?B?eHFCYUREWVVqZ002WWFhblUzZXJpeWljYkM3anpuWmdQNHFnUnFTRVU1NDd1?=
 =?utf-8?B?c3RtMTBZR0gzOHc4UkxGZE5tcThTcnVhWUVnZEY4MC9HT1dTYTdJVXVJZVdB?=
 =?utf-8?B?aW1nRWdzVnlySFpGZnVMUzBTakNaSzVaZDU0ZmQ3NURHbUFpRWZrYmxXKys5?=
 =?utf-8?B?eVUwK3BnK3NYSWpIaG1SUG9aS0dOdWpMNjhJQjRxeWlqbzJEOSsxbXRvRlk0?=
 =?utf-8?B?MU5EY2JKekJGdnJZT3RQR2NPT2ZYNFVWUkZtWG1CL2M3NGxETytlekZIQ1Er?=
 =?utf-8?B?bHJGa1pVUFRwNEZDY0JGNm0rbkloQ01DTXVxVkNGWFpKbUQ4YURNR25MNzlx?=
 =?utf-8?B?Mm5XdGZjenMyeFBzdTZBekhQd2hMcEpzbXozRC92MDRTYzFJck1XRm9lVU5Q?=
 =?utf-8?B?YXE5ZiswcmtvRTc5ZHdXQ29UdE5JOUZpTG1tczFDT3dHNVZTY2NoL3FtVndS?=
 =?utf-8?B?b05wRGtrYVRVeC9qNHA3MVlkR1VlalcrbVJrMzJ3SUd6VU5nS0dBWWtTeGQw?=
 =?utf-8?B?VVp2ZjJxWW5mMytzK3o2MGJLV2puckdSMmZmc0IzbUJtSHJBRmI2Tnk3cWxJ?=
 =?utf-8?B?c2lvQWlLUDI2NDlFY0ZyMHUrQXJUQm52b0wvWVBZK09FUllpd2k5dHpFRmJr?=
 =?utf-8?B?Rll2Q2ZaeXZ5NkZxWm1IZ0hjWkczakdjT052QnNraVpWTjFLZWVuSGwzWGxS?=
 =?utf-8?B?ZjJJVlZUZ1Nqc1JiL25OY21HM1BpbzNrck9RWmRjQXA5QytBZWYrVWljbkxy?=
 =?utf-8?B?SnZ1WGd2em0wUHpjVFBjSXNEc0pqYURmVmQ1TDZUdERycVAra2g5Mi9wQUV4?=
 =?utf-8?B?SU5mVFJBNGduVUpsQWt1MXZvaHVzNGFaYlg0NTArbHNOdzZhYlFkSFIvN0dx?=
 =?utf-8?B?UEtHcjBERVZDSXNrWlpJWnp6NWkxYzlTWnRzYmhiMHRtcGNmdTJ4WVVtWG5v?=
 =?utf-8?B?elVCRkZpWXdaQnErcklxTUpSSDhONDFjMlRubHZNdUpWeVNFZEVnODdDNzFP?=
 =?utf-8?B?ZHlPbnhlU3IvSDJWdUdXenFXVkRsRC9yNEFrVE0yZTZDUkVGMFJuT0Y2WFRm?=
 =?utf-8?B?dlBzVDZ2a1R1aUpYQXFvU3JnZTZCRDJjdm9GN3hLQ2NpMHhOMVFIa2RoVk40?=
 =?utf-8?B?ZzdiM3JwaU9wdC83SmZtdE1mT1FLMHBUczIvcWF3T1U1YTFOTVg2Qm4rM0RT?=
 =?utf-8?B?MWNQK3hKZ21VNEZFdGxuWk12UG95L25ZT2JrM1A2N1d1TGtHcDVuSDI3SVpl?=
 =?utf-8?B?YzkzN1BBMXhtS3pQb0FnSHprNlZLTTZWRUVMejN6cXFoL1NWalNibkxERXhO?=
 =?utf-8?B?ekEzR3RSUlJJSndwbmJoRmtuclFWZlp0dFB2aWI3OHlwNnJiSTNjRUlGa1J0?=
 =?utf-8?B?OUo5d09EZnZZM2VSVHFnVzNQUEMvekFZRUVCdW93ditBMmp4Y3V3QW82UG5I?=
 =?utf-8?B?K01IMzFaQWY3RnhKSXQ2Vm5waU12SHhIaWx1bVd3WW5jRlFLVW1NNGt3M2w4?=
 =?utf-8?B?bGRXRnQ3UHN0czNUanRLZjJUUHdPRGVhQy9vUjdVeE5tS2dSTGE1bFB5VVNh?=
 =?utf-8?B?ZVVoWmVqUlc1ZHdmSTVLbEllV3c4L2VkVXBmUEIvbHMyUVUyeFE2ek5BTmpy?=
 =?utf-8?B?WVFad0NhMzVOYXhKOVVzNENhbGRKeWpkSXJyRklBWjRlQkdVNStzY0dEc2Na?=
 =?utf-8?B?b2wxa3ZrSEhncVJCOGZiMUlQK082YUtIckd5dVJOUSs4cEhCQVBybStLdVNE?=
 =?utf-8?B?eUYxRmZ4MzlDRlhEMERVMG9DUHNYQ1VDMVI5cTdCeUFGeDVMMWlwM3dPcVRy?=
 =?utf-8?B?OXJXK1JNdnpKYWQyVTNrQWZLeUpubDRvTjlZQXdnWTdLb20xY01US3AxdDhs?=
 =?utf-8?B?c0pZT1BoUTJ6VDRTZjcvWWZYWFdXNW5uRVF1Y0l0c1Y4UGV6cU8wZVJqdHY1?=
 =?utf-8?Q?ZGXxWrBcPgTB5QlR9Nk1wK0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df18cc5a-545c-42e7-c470-08dc89280e81
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 08:33:51.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK9am1nYdOugeDkllKoOX0N7y60G0R4czCjORP83P+m3hMGZEhx0/GM8om1O1EyaoHlOOlai5ZEf+mh1N3UD8GZ5AZ570rzrguFbJiNFM1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8334
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

Hi Heinrich,

On 6/8/24 6:12 AM, Heinrich Schuchardt wrote:
> %s/prbing/probing/
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
