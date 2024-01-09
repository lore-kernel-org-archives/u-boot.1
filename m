Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3105C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 06:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED78F877EC;
	Tue,  9 Jan 2024 07:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y4u2XfKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD5A876FF; Tue,  9 Jan 2024 07:03:45 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1CF8783D
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 07:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXOEFe8RgX8KKXIkBXQoOcFct8Ry/xUtdO5fVl83VaT8Sgs5TpnNuUgy+s4gP8r3Fi3NKC8ScqZnHJ73lVbreV2eFgX4zddHkg6EFMUp5nFa7sEkYu6z7iSGT+p79TlFeJOG3Qs+XOZbkA5hNlouPzjRg6L3WPG0UrEK/clo/Z2nhZpzpRGImhH09pZW4i0L+JEbuAN66Duee5IB+fBLEL9H9XJdISBs7ZOYMY+YDgFy6xDSnAuukepUh9dGGG8rYxD6IIR+bz4Ddl0vlmBAgxB5vy4ScBgQnTCeNFdyOUzeqEl09TyqTSZSs5IUWAVnxtCd4n9X+rUi2lByiHo9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7VUgrC+VzkM6wuBoBuvUhPQq28cbbMt/M3RwAxi+Uk=;
 b=EWsScNAGu7Tz2Uwhgv/B7ATCdSB2oSA1FJR0+3745XEjvj2CZLv13qVrXO7xMczaHDk9R6+DvadiunFxwx3QClK+A4Waizpwj58KlecetQ7GKKzoUK8PsQ3wN8bpGOyRTQPzWLDQo6sc0RnzGIVpotLYKrb0yA+sck6/vTOrJsnisI+P1N96J2RPvI/onuIYcpNvvEkAz4jWWEZk+f7aDC3nhor7yzoIBZ5hYYY256ry7DOKZGqat3jfzav1cnVubEeJMvVorkU5httVgQKoRDTDI/qDCDWRgvd1Q5SHuY08ZA4z2PMkizL4kcbEoZ79D9bZZQXUYkpeVLZCa1erFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7VUgrC+VzkM6wuBoBuvUhPQq28cbbMt/M3RwAxi+Uk=;
 b=Y4u2XfKZFgrrVbOpjBCBFH9+9ZgoWcOW2n2TYh6RUIB+/QlrcAcUpFOxkLcsiz0tpZ2XSqL56pvUQLTnKgRhrYTfkJBD1h0mzsFMkFE9TWdt62xMtYwSzb8dK4KOKcDtfgFK6/YvZ5XbWT362w7u1y4SfEfsSMYyOFgx5QFqjoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:03:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:03:41 +0000
Message-ID: <028a6405-6fd7-5be0-1da9-642656fbfc59@oss.nxp.com>
Date: Tue, 9 Jan 2024 14:03:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] doc: imx93_var_som: Adjust the underline length
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20240108211140.3270595-1-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20240108211140.3270595-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 967f1c69-8a41-4f40-4a1d-08dc10d8baa3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbtvhLzAV4B8r17QwYpFcb3cZVnBVHXfXw2xVy0EVHV/T+dBr99buFHFn+Y44MI6VK8QLnAG8cIM9F1cgSShXcmFpvzbtym2H8KFExZSC/ql6nsspx3W7u0Fb3nNEucSSETIRs732LJNkMq0q2MznkvE6bzg0nzj4XbQUyRm29naOt9pyHbKcINqwNBrE+nscFymHiCKRZu9vQeIrKZ5vZW4X030NuqcU2vQP57aNZhLcD7gT6AsG95iQofxsWB6r3U+5ntiVDdSMKSz+ueB20KViPsD6NCvGBHQd6YluY4RI55JIdg3j0nTTdX9YzUwh/nwgb6a60FkzYcskUADDKlXYp826hoqegeMw0Rk7ZTordvbp9sj7n0I8F39pM0xRPmezwHNlV7OQWzjkiCBa4vqCDih4yaYWt8U8oLjXjBgHUxJSU8S29ZinHjTrTDcWZ3jqJzhItYjmf8q27uQzg2uIPaOoyCK1qQGA2lW6pgCFG8rodYY9Bt3pqMQSBNnrb5m8O9IkjnbKf0wtuodruiSZLz5ICtfQHGY0QLpDmaWCDV8aoEGvpF0Y2Matk4Lzsvdyj+R2sY/+juApMnWTI0iyha3xFT3icrZnv56ZJ8UGO7Ubz2/25rsYtYG1uSXZXu8m4MlzczqcrlSkai5UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(66556008)(53546011)(66476007)(478600001)(66946007)(86362001)(31696002)(558084003)(6486002)(26005)(2616005)(5660300002)(2906002)(6506007)(6512007)(6666004)(44832011)(38100700002)(41300700001)(316002)(8676002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWwwZUhyNSs5R213M29ZTTRLWlJxZmpzank0cmVkYk9QUVAwaXRGckhKeHRW?=
 =?utf-8?B?b0dPei81dE9hTGt1QTI4UWpsNTBPRUdESFN4T2xWdW9TV1lOOXFBTzRCY1Nl?=
 =?utf-8?B?bXFRYkFpU3dzbGZBaU5QSFR0Y1NqbFFJMFhWMjFtNWszeHJSeWhUdVpXM0F5?=
 =?utf-8?B?S2tsbksydnVPeTl4ZXFOY2Q4ZWhJVUZyMkZCRy9HS1owUXU1VVhHd1ZxUlg4?=
 =?utf-8?B?eHYyWmdYNXdFcFFvZWMyUHAzc29GYU8yUE5ueUxBNGwxdjZaZFMzbXdDSEdB?=
 =?utf-8?B?ZXRmc3A2YzQ0UjNMQlpyZGdDT08yMkxZcXM1N25MRGl1ZTJlck44ZWozYno4?=
 =?utf-8?B?cG5vVzU1REdKK1lXSzdmSHdBZWovTXBmdGxvdTRSMHBIQ3FDRjZlOG4ya3Ez?=
 =?utf-8?B?QzNrMGh3ckI5R21NbjhjeUltOFF4SFc0amdkMnd6U25ldEhrN214M3ltN1c3?=
 =?utf-8?B?NnlWeDZZekRTeFFsZFBMakxYSTFUdFBPWm51VC9UcGdWWW5IenNrSWhQRXMy?=
 =?utf-8?B?SWxrZ0xrUkE2WUJ3ajg0a0JQQ3Bud0pha1lkWWZFMEdWaXdHdmJ1MjROZ3Ry?=
 =?utf-8?B?UVZ6MjdQM1FTWWJIODRzSmZuNzczYXUxYitjVWNNdEdYU2NYY2hSRUdRNkpj?=
 =?utf-8?B?b2lJRFhETGtweXpvTzJtSkJzTzBMTnJrN3MxdlNYSzNBNXRrYks1ZktvTVFo?=
 =?utf-8?B?L2kvY0RDRmsvaXJVUk9mNjNPV3RxaGxSdzYxa2JFMnQ2MXl5eG5tQlZqWE1s?=
 =?utf-8?B?SFFWckd0WXBZQUM3OEVXRXE5L0xvYS9pa1VnWXZBUzlKZjFqZkFHNWw3KzJX?=
 =?utf-8?B?elFWRjZDdlBzTnpSOW5TU1VzcTdHOTZobTVHdnA2WWJnZGhMclU5eGp3WDRo?=
 =?utf-8?B?MXE2SXJVNXkxdEtRZ05JKzcySG9MUEQrenRmZXJtR2VEVHU2cGdLNHVvMlRn?=
 =?utf-8?B?eFZ3cG8wdFVzOC9FVmdKaWVwRkxkWkJEa0o5NHI4eHNHMy9pU3NYWlVQazdq?=
 =?utf-8?B?UFBxVmdTNFZDWlVpWnkxZWZHYnlXM2hpVk8vdE9LQnRTbUpvYWpkcVluQS9F?=
 =?utf-8?B?RmRWQW5MeGcwZVFpWkNlMVlPb2QwM3VDUzIrK28yallNQXdpZXVOci9kRStQ?=
 =?utf-8?B?L2plajJNSVpUVGp0SENxaTVJTVNia1JrL1A4bFdna0F4SXJ6WHovZFYySWhy?=
 =?utf-8?B?cWRsVGhvbkVVSlBhMXVJWTd2ZGUwR0RpendqbXhNVHNNdUdBL1Q5K2hlQUt2?=
 =?utf-8?B?WjFidUxrM0M1ak5tbmtGVVdEYnp4Y0ZybzVJN1FkREswVFQzM2ZiajJVeEpP?=
 =?utf-8?B?bDVKNzFmYjZSbFZxV0Z6RG55L0VqVmUzSDh3ZTdvWVVCUndwVmRxUFNSNEJS?=
 =?utf-8?B?RTNINGp3YTFJSmtzbk1vbXNjRjJQSk9leFNmZE9SZ0FPdmN4Y0h5SjlWOFYx?=
 =?utf-8?B?Wm5KNlVXeVMwM3QrTkc1R0tRSmlFV2Nma3paOVBzeDlNbWRIK0pDTTZqdkp5?=
 =?utf-8?B?L2FSeFMvdzE1cUxBcWNIc2pPUjZjbFpEVFIvUG1UVW8vN3hQRUdTblRCdnA4?=
 =?utf-8?B?dDk2V1BJM0owK1NrdjFqME5STC9EemVHZHhqUGQ0VmFJUEZielVZQytkQllo?=
 =?utf-8?B?a01xL1hIQUZyT0NLL1p3WUQxa0ZMSEJZeDM5U3REWE94dU1KRHR5bmJPOW5B?=
 =?utf-8?B?RDVlZkdqTGQ2eUdpbUNLOGVmQUhqOHlsK2xEb01KcmszZGtPa0VxSTFTRjVo?=
 =?utf-8?B?RWQ5bktaU0RQb1ZxUm1IK25hUlhHc0hGTk5UNEcvVVpTQ2NvUmlOSDdrMHRz?=
 =?utf-8?B?bVh0YVRpTHRCRG5VRE5LVWVxQURlU3NzcmFyd3hsL0lzbjl6RzVaWUx3REx3?=
 =?utf-8?B?YUNVNzB5L29IYWFKQXJldCtMTE5pV0ZxWHZkMDV0ZGhOeGgwUS9oblE5ZVRN?=
 =?utf-8?B?S2U5bUV0L2RFVUhITWpDeExwSkRkaDUrcURmWm9zNkdYbkpSeVAwZ3lUM3Mw?=
 =?utf-8?B?NEp0U3VkQTNyNEZYbVNqV2l2MmN3Q2dHbFIrQi9jbEl1aUNWRkhRcFhuSE9K?=
 =?utf-8?B?andJdC9uZmR1UTFWaVBLaVNVaWZFN1RWQ0pMZDcyYVhSY2UvYTA2M25XTXpO?=
 =?utf-8?Q?WgyNvVoDXWnlyAbay/oyet9Ej?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967f1c69-8a41-4f40-4a1d-08dc10d8baa3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:03:41.3396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8Ndi5KBnEva7V/1NGiKLyXuCX1c01KLpYcP3325fD6PZywTNLM1VoJe/qiDuCyRgoCuHQcyDwn39DInUWGSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
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


On 1/9/2024 5:11 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Adjust the underline length so that it matches the title length.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
