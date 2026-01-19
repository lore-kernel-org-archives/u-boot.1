Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14587D29C46
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F98B839E8;
	Mon, 19 Jan 2026 17:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="LdQhCwrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAE283015; Mon, 19 Jan 2026 15:49:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AE28003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 15:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNIMPGWmn5rklhhJhqCqhm5E7txafi+Zw04VVR4zgt9iFIoTE+cl6IDcn5DekIItL7zCSGlCQKI1FK3ucZGDdlqrFSnEesp0DCq0+5Q2rmrlTxy7PLu72kpIgK9w49D+43usSQIyx8BOTcFC3Sv/LTKPzNhh4LdZViKdnhfTS1hsSmIt0EeltsAtPUWMI/6aVyP4DtEkJPBdNJceyozMRJt08ZIe4Msb0R/WT3girO/y2L+WItVTuPn91ppzk5eSd3LvbDvQpAAtknG5GP8oMGpNf/+czcteMLnosVfPXrO1L3ERJZATSZzV4o/bO7AlcspxaNHp/lRikiObDAiy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/XwX4u2UoB0YEFc4FHsfuncf7HBXh+y/MIua0YStZI=;
 b=oSEjZgyDJeEbgBiPLUBlQpIEFilNM4QEfJeIBszGRAGevD7MaMAJ5IintHjMmMaT8CIKH02lZXCsJC3K8fzux95DfO9pTpuPrejoLF2pq07vfuLB/GNqzP4fC+Sij7+rIQKeTiTb9GGdx+iIzS1p+xzQZpwlUran3i8fS7TSUgIZaLMQdsqiivIHUN8FulRxQjdC1ZjaNsTD1T9CfEoj/rZZaUiH2Y2TvZzWuACvBqbN/ee6tjdu+iGH+TuR5yaaDSti94SS/scx/sJVzCnz8j8II2pt2cFoVg3VkMhyaeR9GLM3WT0tvEI7RxIdSLZKHe1Xe8cKqD0BqkcELEBdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/XwX4u2UoB0YEFc4FHsfuncf7HBXh+y/MIua0YStZI=;
 b=LdQhCwrtK+4+XFBtT8y1r8n7l6ypNIbY/HRtkD8sNrEBosdPKywthG7R+frzvIWqXmZpF9enXAWiOFORLSveRjs7vAXQ3jUonpBujx8dJ+CItTgo4QA8LiRrOg9qyOZNYRlQj5cAN6vqLjZzexKfy9dvWbG5pBDtlOM9pej7n9SLlA8ceuoWh0HAHX1dN9FuF5LglDe/OfGhP/YRFC/uicIhjCdQ6COsM14rN3lXpBwgq5dATAq8GfGKk6s2nXLDRJMzeiQX6DqQPspJs+co5mXWbgM063nxm+Tp50/AyPnZJVOQLod7lkdtZNY5KUT2VP9IF9Vz4HKAUk10E72Gbg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS2P194MB2071.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:5f4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4; Mon, 19 Jan 2026 14:49:08 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%7]) with mapi id 15.20.9542.003; Mon, 19 Jan 2026
 14:49:08 +0000
Message-ID: <BESP194MB2805AC7C1861BF2283BA065FDA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 19 Jan 2026 15:49:06 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] tools: Handle realloc failure in strlist_add
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0066.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::23) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <6d0616ae-6188-4ce0-8359-f9d2ae977e34@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS2P194MB2071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0c13d4-c6ce-4a53-262b-08de5769e662
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayGKAlIIivN7fIKgPET+ZtPoPS3HF2YjxAuRVjMCHtKKqt+WK2UOU2txXwN9LKCafRcAvkMVkrQp9CH5HfrBxaJ0ipplZzJPvqALAWzRbyosVlI6ISe+irYf9dbx7mtWVWC5uogLjRhlUQIuQP3YU1KrgIKOYNHVQFU1QGPk0WMVs1rhSoVOTs20tQxIIQUbw79MA85i3jC7u3pam1FnMqopInWK1vVBWEqPt1lZY9yNE/7IUnBioYK3VXJQ87VJ2TAKvbzaVOV9hA4l8OMSEKiabsNONFcYtN3UrMxHfoZEYttxauamMxrfVAKIxcLkWZs7ZqN5l8BzwPkz4LEEWcQ8ortt509dGL10W7nK9jdAx3PWYuYW5etATTb3AjfD8w7X9iPZuS+dh28LcbTusOFTGxxTMXPKQ393RpKg//hl0f3w8WQU2NIRSt17H8lbCv6Pr6gn0MtLhudCtD4/dfYdH8UTrCTpaZKbNtwJPxuqGIrFhHBzwTbWLULXnN1Imr0jeFg1D08JwYcSo6uF0G/jzA3J0UlWMqUxlpTBbpuIE6CCDmcsJap9MnS1npgnpvZQVMZlYxpHthMf95pRObNRN2ho/0iNRj7WTKeyfuTSt6LfnMBj9eokLnhRvId8G5GknwKbFGVqsQoRRdeOZ738kFYODuXsbvL997qYyCWl+KNgYKzlZv899vv6U358saduFH0MmtHA7+9emPPP7+b1Ue+usSoXr1I=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|6090799003|5062599005|5072599009|15080799012|23021999003|19110799012|51005399006|8060799015|41001999006|440099028|3412199025|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qmk5cHVqeHZlR3MxR09PMUcrMXR5ajYyYzRjeFpRdkhvWForZ3N1WUJZVmRN?=
 =?utf-8?B?N3BiN3h5SUpnNHFHbmIyREpEc0crd2RsL2x5SExZOW9wbTMwbm5XSStKTzlx?=
 =?utf-8?B?VStHVmZpVkFLcW44OUdjR0o4cGpsRHdBdWs3SnNsK2l5NUVJOFpUa04wYUd4?=
 =?utf-8?B?Y2p3L1dUSENKSTFqRmxsQVZpbHYvWHJOencrTFdZUUc4WGhoc0M2cHNkM1VK?=
 =?utf-8?B?bzQyV0J4NkNSL1kybENmd1MxZzZHZnBpUkFqQnBPU1JQdTB1SW9CODN0RUx5?=
 =?utf-8?B?dlA4TjhmNzM1eDlQRlpsUVRhSFlXWFIwMFFxeUhPVXF6YTFidjNrT2VMUmdj?=
 =?utf-8?B?MVlqUW9RbUIvWHBHcStJUS9odjFuL3c2ME9zemhBUzd4WmZjR2RIVGY4WWhq?=
 =?utf-8?B?RU9wRFdIbmpvSXA3bTh6N25pdzNvdjZZMVBidmJBNXVYMjQrMWkrcTY1MG80?=
 =?utf-8?B?QUFOMGRwWVRHSlJyWTdxdmE5dGlJQTNaejdibEViaTdaYmRzV3NjTEdyVVJz?=
 =?utf-8?B?aEpZTmVKYXhJTDZUK3dLcUNvUVNiRHViSEJwYk9LeHB4U3NSKytnTTkyWWZj?=
 =?utf-8?B?b1ExeGZMMmRGUENVMlh4Vi96S29hVWdsampkTi8wNjV6d0RLSW1WaXBaaTF5?=
 =?utf-8?B?NDkrdVljTnp3WFlydlZiQmxCRnRtS0tIb1lzNEFPak1CeW0veFpUZjZ5d2V6?=
 =?utf-8?B?S2MrdUVKMHloZVN4bDNwdFZzM1dpTldka0JFWE9lQU9aaTl0RjRlUUFIOFVT?=
 =?utf-8?B?WitaNlQzTERHb1RadEdpOWtrZGNpZkpWRTAxaUQ1VSsvd3A2QU13bHpKVUhk?=
 =?utf-8?B?b1ZOK2ZFTjdXT25wY2JiNjcya1lxKzBDZmZGTTMvMGM1dkUyMjg0UlRTcFN4?=
 =?utf-8?B?R2xMdFY5b3NPemFDNzA3eHVkQzFQajU1UGk2VHhKZ1ViTGRsV3l0S1p5Z2g3?=
 =?utf-8?B?QVdrMHdxS1h4ZHlYQzUzenZjOHdBdHNCUGhIck82R1lVOXhjQTZILzFkM1BK?=
 =?utf-8?B?bU16OFZWS0dwcm8xV0hlUFc3VVJSSFpnZHBmQlZoRG1Sa2RockVuSXAvaHFs?=
 =?utf-8?B?VFdxczRLaEhyVzB6RDh4bXZQWDEycFRBb3RDMm9qd0pOY2N1MDYrTnNVN2Jm?=
 =?utf-8?B?L0J6MjdOa2VJcm9neTZQM3Y1VlRPWldrL1NkOERtaXRhdE9nVE5zSHFnamc2?=
 =?utf-8?B?UTVOdDcwbSt3Q2h1UDJyS3d5ZDlrUEpNZlE4Tm45UXR0UjJvLzI4UzZ4M0d2?=
 =?utf-8?B?aElhWE5hV3JKZDlhUmoyNFAybEtmQVFEbFBxZEFRK01INzJES1pHOERMbTBa?=
 =?utf-8?B?YTAyTHFONWpXOURPY3BXeWRhNzlQLzh2T2lTaFkxc1hJWk14Q2lqUnVHWnZV?=
 =?utf-8?B?TXNvRXNHNW5Bd2VUbWhER3pUeEFURUcrekFtTVBIUVdiL0ZVL3o3bW5WUmZ1?=
 =?utf-8?B?NFdwekE1dzJnREFEUWV3V3Z4VGZ3L1VjS1h0c0o3MlRZMGlDeTdRTlB6UXBa?=
 =?utf-8?B?WUJXWHV0SmNWN2J1QmI2d2RVRUxyNE5ua3ZOQkU1aXd5OVQ2ZHVBN2dXZmgw?=
 =?utf-8?B?N2l5QXRKckJlSGhEdDF3OG1lZmk0MEsyQTRVODhpLzdkL0k0SVBSaXg2dm1I?=
 =?utf-8?B?TTlZSXJjc3dJbHZUTDNxVzJtUWxKUVE3SndkNXhkbUMxbXlsNjJZV0hSTUJ2?=
 =?utf-8?B?SjExVTVYdUJEVkk1ZnhOQkcwQlJEYytUOHVuTWFIK0paaE5CWENwTzNrQ0dp?=
 =?utf-8?Q?gUfyVC+SND3KcFnkr4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9VUVJJem9wMDhpWFJqRStac0M4eTl4N0J6UXBHc1dwV25RMDNiVUlMMjNK?=
 =?utf-8?B?Zm9ZeWxNTU5idzQrVGJTVUttNHB6UGEydkhLcHYzbzI1TU9Ib1ZlTmxOQSt4?=
 =?utf-8?B?clFhQmo2TG1zbGlXMStNbkg0a1NEWjB2Q0plSmVXQ1VzTE1TcVlobkVwMmxW?=
 =?utf-8?B?MlZ1dVlrek92L3AwNXNoUnNzZjQxZVU3cWZpTEdnMkZ3WWFvazNnZll0UEFl?=
 =?utf-8?B?V2xWQ3dLZHVUWm91cHEwVzFoeFE2RlJIdXJUTVFpNXJrcW9vVWtSckZPYzk1?=
 =?utf-8?B?QTVvbkxUSEliU3JNVUVZTFFGa3dGNTFkeWJXa05Hb2pXRkZ4aEdPTWFaUTg4?=
 =?utf-8?B?QWtzU0p6ZHFNcEVKaXVUTnN1cCtzdUowZU5qMGl4V0c4VlQ2MEJyWG9NOGJK?=
 =?utf-8?B?bmh1d2ZXRzU0MU1CVzFZNmV6bnVTd0lBYWJNSHJQQzlsWXhUTkoyRVlpcUkx?=
 =?utf-8?B?bzk2aFR0R25MdHJtVWRNMkUwQ2NGNHRXblRIWTJtNFE2eFpENHFVdmtDUHAx?=
 =?utf-8?B?UGxCTVcvcmFBL2xZbHE4bVV6SGYyOVhqUEhUYkpDekdkTGNTeVdrMm1reUJx?=
 =?utf-8?B?bEdlQkFmSFMvd25oZy9GZlpUUStXYVBjM2ZodCtqa0k1R0hhUzQrN1N2azVm?=
 =?utf-8?B?eWZYNStFdEw2TU9tZDZxQ011ZU00aEdJNVYzZTNzZ01YV1FaRGx1M1JOOUlF?=
 =?utf-8?B?QzRPRXZZdG5KYnBianZUVTQ2Y0xLZFZpbGNnbFRRTFVuQW5JeW15UXg4V25L?=
 =?utf-8?B?Z0FEeGRFNC9OSVVaNERoUGJQZTdkbW5mNEErR3ZlMlUzZGJVdlViRXRXR1h3?=
 =?utf-8?B?R1l2YWhpWHFNeHo2eUhoZG1PTllreG9sLzgxN0RDT1hNcEVQTGZnY1JBL2or?=
 =?utf-8?B?VjFPZlpWQm1YUWhFUTJPQ1Fmbll6ZlNXTG4yS0VhVlZVN042ODhkL0oyekRq?=
 =?utf-8?B?Tk9Wc0crRUZOSWFRL1VubjRqaUVhZ2UyelNZcTByY3lhVDlmUzZNcUZqdWxr?=
 =?utf-8?B?bUE0cm81c3FzQkxIS2lNUk1lUWEyRWo2OUNMVmVoT3VXYlVKZnIvQWQzdEY2?=
 =?utf-8?B?ZHAzMmdZc0JCK3dHaTVXcGVyTmNNVW9zQ28xRVc5UXFySjhXeGpvdFhORFly?=
 =?utf-8?B?dkErUmdaRE9PeVQyeDlkZXRpVCtqUGxtcHk2bTYzMzlOeUdjL0RxUVBpNUo5?=
 =?utf-8?B?MnhIbmZPQ244OHd1MEw5QndOdnQrcnBpNGpXOFpYQWZ2eU1LdHFoQ2lFdi9o?=
 =?utf-8?B?eUlFWkNKTThWb2I2dDY3SE9TSm5KVkR3RjNSKzJwWDFqUXY2MWd4dktnaXVM?=
 =?utf-8?B?YlROWkRROE9rcnZKVlhqc251anY4YnRIR1grVWtxNEN5cnRORE5OYllrWHRU?=
 =?utf-8?B?SkFEdktsYVJPYkpVTTg0VTZSMWRDRkVGaWhJTS9sZjBHbldxd1NjL0ZPOFMz?=
 =?utf-8?B?eDdpMDFtNlJqSnkvVlRGVm41a3EyMzd0SWQrOE9kZzFuTFNmRVBHd3pwVCtR?=
 =?utf-8?B?NkdYWnV5bUVRcnRkUDNTU3gycXZOTnNEdjlUTW9SSVVKejFOSmJWcktPZUM1?=
 =?utf-8?B?ay9POHBxMk5RR1Ivc010WktUdUNoTTlkQXlPVlNtNG1LemV0aDd5UEJHUVVt?=
 =?utf-8?B?ZnkxM21ENUQyV2p0QWErM2dDSUVjMndsR05FaEViTHdBamdmWUgvLzhaRUhr?=
 =?utf-8?B?Z3NpZE85NWhaekdlSXQ1THJNck5yMWdpMHBhUE40bGM3ZCtNRlhGOUVJVmZQ?=
 =?utf-8?B?cGw4VVEyaFJWZmVNeStoTFN3anMveUJmUmUvR3pERXozYk50SHpRZUxQRlI3?=
 =?utf-8?B?Q2FIU3hnTlU0blVGdGlSSk1KSWdJbDN1QjlmYk00eEU2SmVVNURGcWt2UXZB?=
 =?utf-8?Q?eWQB5JG5v656S?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0c13d4-c6ce-4a53-262b-08de5769e662
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:49:08.3581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB2071
X-Mailman-Approved-At: Mon, 19 Jan 2026 17:33:56 +0100
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

If realloc fails, list->strings was set to NULL and
it would create a leak. This commit ensures that if we cannot
add a string to the list, the list stays in a good state.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 tools/image-host.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 54df86316ae..48d69191c92 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -733,6 +733,7 @@ static void strlist_free(struct strlist *list)
 static int strlist_add(struct strlist *list, const char *str)
 {
 	char *dup;
+	char  **tmp = NULL;
 
 	if (!list || !str)
 		return -1;
@@ -741,13 +742,13 @@ static int strlist_add(struct strlist *list, const char *str)
 	if(!dup)
 		return -1;
 
-	list->strings = realloc(list->strings,
-				(list->count + 1) * sizeof(char *));
-	if (!list->strings) {
+	tmp = realloc(list->strings, (list->count + 1) * sizeof(char *));
+	if (!tmp) {
 		free(dup);
 		return -1;
 	}
 
+	list->strings = tmp;
 	list->strings[list->count++] = dup;
 
 	return 0;
-- 
2.43.0

