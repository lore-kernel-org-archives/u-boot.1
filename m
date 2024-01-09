Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08057C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 06:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4F4877EC;
	Tue,  9 Jan 2024 07:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dP+DK4Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D89876FF; Tue,  9 Jan 2024 07:04:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2364687849
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 07:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpXCUscJWDO1ol1Xt/tYI+nrajoslzkYLlpXVVfY+6oKtt9am7y9WdUcXSdCpGtQnHe+YhqqwGErfTRwO6+FZ9iEBpAmjt1xiVItlkwfVSEUVhWMnxkZY0fb9MwRz5xciJsTQwNqUsCc6FVZDrPyI0k/et8I9bXD2+2UqYUUoATruJvDkZFx+EVbkkhxdd2KhY7pOk0LRDjZpCibpniccLuB0PiDM0P6G2Xq3ihEHhi2wJ1RiRz5oy5KwE+wHmTEGeUSNs90XfIuJP70XuHSHqh7EwHzqM9rURfARarYff3iMlN+ECbAihbkjVmpHk0qdo4gBkJUWUZb/+Blm0yU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv2QlKXgaZGH7FRVEiRAk+QJIy0GATY5bG6/8CBTRl4=;
 b=nLwAyI503nZJZ4+zn9YkC/TEXQoYmMTes0GlR0nHKhDpMh8u7fLion//BeVmCgrp6F5BxuPwabOIKCMaFzzRwRvnTwzvbreHvjcIu/Jo/XY92E5Ismzfv6KjolFzN/ErJc/IIheeS54Xs60tBdvj36N2NPfvyzAjK9LTnliC67HDsoxwD6UPTufEc61F3p8ltdwZF+U9k8pThwLXyAzHizaQcsJrwFFLF/v7FRrH7SU+fv6eqULCDgj1x3fSCcuhilGdCAcmPaEfXyJLMycyXYhmQT72pKbwCVg5GjeAlOggJim4+pZqOivverbACttzAePmEjvVHJYapIbBHHb0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv2QlKXgaZGH7FRVEiRAk+QJIy0GATY5bG6/8CBTRl4=;
 b=dP+DK4RnyzAt+3RMhiF2Jx4nQKeg/xmjAA4qS9UT+IqucGQUY0o9YCwdOtb1QA5qNbaz0LuxsTdSLvgHIQb6EQmqISv00yT+n3sXjCVZZeiW4wnhT3nwIeshsZXyr0qUWIyGB9wPyRcZkpsqtpE4ZazoRDnMkemxGncA2Jthz/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:04:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:04:19 +0000
Message-ID: <4403b38d-741d-93f8-0fbb-497f9f2983b0@oss.nxp.com>
Date: Tue, 9 Jan 2024 14:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] imx9: Select BINMAN at SoC level
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20240108211140.3270595-1-festevam@gmail.com>
 <20240108211140.3270595-2-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20240108211140.3270595-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7222b4-e0b5-443f-58c5-08dc10d8d166
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgylOmwAqX4WsOsh6qxLAxLNFb6GrAFZzRoF2I4CvxlkZUGsx9p9Z6HuNj2SnXWrNCPf2XBsKPFYquvLIfniMwdpLNuZyv2awgqz4fXK9UShtt4w85YPR744WEjoRBCQtpQ7AXeQ1TyfZP1ZGPVl0LYBemxffDOOYE0zYfLpwtwj+Ts/zlhLsRwviEfXdqOrTOis4UMF9BCpBQX1gZEMnp6UeZ68Ja8P66/dqIBUie43s7xgWfELDKZ+jPBOjMQbGBbDq+wxfdNkZ4xLqjTYn7tueiTtlwK8WVeD+46t53XVWkx0uZOB74mCDfmx8lvEo8VKExMzw1Io4oTIH2aqZP2iivCtRgLg7tLGFe8zNum9Hj8Lqo01CQgnR/xojEd9PZ7QKowjGzgig1PhLFgv3LJ0f6hw9brv90QFl7NZRUYkbRmg9UdjLPSaDUgQCLSv3v2Qc5J29JrsKSlajNMXXWHs4/TAuDKNp46DucxiEYM4vMtC6L2wknI0OZZZWxtffAM2ohi8wRAZJc/kCOwGT7mGhrWT0NI5Z91MGCVGE21LclIHHNGGaTmac48ppS998WgSTC+EWDnd8ju1st/NlUe3KuCx/+kKFcGbM4Duk1HG4Bd6UPG8sFw88VxxkyWlruXpkmI2Z0Tt/FP7nlXW6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(66556008)(53546011)(66476007)(478600001)(66946007)(86362001)(31696002)(6486002)(26005)(2616005)(5660300002)(2906002)(4744005)(6506007)(6512007)(6666004)(44832011)(38100700002)(41300700001)(316002)(8676002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmQ3MlF1Uk9CaXFNY2ZjNVlaOG5YczZVUHRRQXQ4UjNXa1FBcHp5aWg1UEMz?=
 =?utf-8?B?NDBsSjg4Q3g3SGI5Q0xUSmtKYWI5KzBqdlRtNVlaQ0VGdUFNMkN2a3gzMGpr?=
 =?utf-8?B?bTJsVkRzLzRjK1RFUjE1ZDl2REMwaGt5eHpLS29nNEJkVGkrYWI3NjNBck5J?=
 =?utf-8?B?TlAvYVlrTERoUjViSi92YjZMQ3k2RG16ZG1zVDZMM011d1p4MDUvYi9WOSs3?=
 =?utf-8?B?V3NhNGxUanJnL3pGYTZZVjdHYnhLaCtkZk5CUHRFL2UyTlZVelQvUERLa0tM?=
 =?utf-8?B?bkNsdHhDaDZ1aHo2OEtsUlhCVTJPYS8yUUg3QWJjbXJXc1FUK21uQU1VRmlY?=
 =?utf-8?B?VkZBQkZLeENOWVI0OU5vNDU3blgvWE9Eb09WTldkTnVUcUwyblpMSjlxYVNz?=
 =?utf-8?B?YnZrZ2o3RXhxVXpOMEZsdVRyeWd5c2I1UmhEYmZpUDRNZEF1alBLVEppUUVT?=
 =?utf-8?B?blZ1cFl3YkFzN3VUcnBvbnE2MlNpTHdnY2xlQXFDdDM5YUZSOVJScDRDM2VB?=
 =?utf-8?B?WldjNXhEZDR4MGlRRlZVMHkvTEhJUGlhZUFxenhXOTRwbklFUWFkUFJzOEVj?=
 =?utf-8?B?WXovbHEvbGNxb3J2bkQyK2RUSjhpUzdQU0wrUDZxZEswbjcxOVQ2ZDRnMFNX?=
 =?utf-8?B?cjl0VTJJRG8rVDlYTmVBY2UrUGRlZmY4MXNmM3J2Y3kwdlhWVWpFTVVZRFps?=
 =?utf-8?B?Vm1Ld3JWMDhCNXo4eFN3eklidytnS2tPWTRhV1A1czViNld5dFNMMmRaNG0x?=
 =?utf-8?B?Qi9uVm84SlF1N3pOQU5qaHpZaWVoME9RVm9SZEpjamE1Y1lQQkdoZlJZK3Rh?=
 =?utf-8?B?MURGbWxMSnBUZDNIbDVRTm1iaUt0YUNzZTdEMzJ5STJIdW5QcmlYYWlCN2tk?=
 =?utf-8?B?U3BtT3J1N1JlTkZwNmt5b0dBMzVSQ2lSRmZhVi9SbUJMeTNsZGV6MVZUZG45?=
 =?utf-8?B?Z2xSWi8yZW5ZZklkeUp4ZXJjYXNTRENtZ2djbW1VZ0hRRlZnWUdYM2xFWlpM?=
 =?utf-8?B?NW9qQ1Z4ZFdSWDk0TXZUM29KdDZMeFVaK1B6aENVWkZyTDF2NjJhajZkcDJM?=
 =?utf-8?B?STlqcG9CSUZINUFjeDVFSjNzSlpmNUVvYXBzdkp0Q1RITmJuYmRsRnlYTlpy?=
 =?utf-8?B?blg0Z2NNbXQwL2pwbEtrSERUUWMvNG13SGZXYWdNekQxV0hXVGQ2Y294N2s1?=
 =?utf-8?B?czhNSXRBWHJQMlZIYlh6RzlFZzhJOStHRFlOME9McHZDbHdTd1lkaXE3SWx5?=
 =?utf-8?B?aVRYbVllT1FNYTBQRDFvM0w4MTdueGZqOWVyNnFNSVpMYVlKcEtUT1ozNkd3?=
 =?utf-8?B?YnJKdms4RGhxczM0c1EvQUNJakJ5RzB6TWY3eUNONGxZS2JybHJTQWhSTE16?=
 =?utf-8?B?RFVxRE95bFhTbkZIZ0R1ZFh4UXhxVSthMG0wbFNzTFA2WlFYMlpMWVFPblJm?=
 =?utf-8?B?eDJYZ2dnN1Zvb3VTWVYwNzJybGJuTjVkeTh3WWl5cGczVnlLUFo0NEY2ZlNy?=
 =?utf-8?B?R1lqbDd2ekZtR2xTdW45UXdieHJCNFgyallHeCt3NGJJMVNVd0hvQWp5SzN6?=
 =?utf-8?B?czRSV0dNODl1eGRoNEdXYzFITkRJa3BMa0dLenIwY1FjVHMwQ2hMa1NNTVdB?=
 =?utf-8?B?WlNJLzlZdUs4Q0RkaVp6eGhXL2NuTzE1UUxrVmZ5b3VwMXJJdE1Ycmo3M0VF?=
 =?utf-8?B?SjloS29IeXJ5MlM4ckREaE5TSUFqNVVwMVN1MHVzWThCRC91Z3d1VTF5N2Vk?=
 =?utf-8?B?cnd1aTJWYmF4SDJqSGQ4WnhlcloxRi9VWThoZ0F2aXlodEpBMnJoaTV4ZWhD?=
 =?utf-8?B?NDhabmpoR29lTGFMdStCdTViOWxNSHJaSklRZXF5MkFmeGlBaGwvTW56dERT?=
 =?utf-8?B?SE15eERHaTBoblJOeVhOeXl0Q2JpVHU2cFhkeDBhcXl6S3hhV1g0ZUpHeVVs?=
 =?utf-8?B?WHllVWw2V0hsUjczcm5wbWJ3T0M1ZGw1K2tET1JmK3NhYWkwTG5EUzc5eXox?=
 =?utf-8?B?ZUUwQ2ZlM2hUMCtSVlJZYlNQVFpYcnV4K1Rmekg1UHByRmUxajZTOXI0S1Z6?=
 =?utf-8?B?c25WMnRJZlhtUkU4NXFab1BudE41YS96SUhzYUp3WGVUYThNMHE3VUlSckMv?=
 =?utf-8?Q?27UCl42kS4DKPEN1mGTCF/7YT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7222b4-e0b5-443f-58c5-08dc10d8d166
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:04:19.5262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K9sghBd/jCSTHXgKqdGkN896JXb6JFNpkyPav0DBd2V/MQfo3L0VFFEJg9H8wAMIH1sK4KmkaqXiU5KqGN9jA==
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
> From: Fabio Estevam<festevam@denx.de>
> 
> All i.MX93 targets rely on using binman to generate the U-Boot
> binary.
> 
> Select it at the SoC level instead of per board.
> 
> Signed-off-by: Fabio Estevam<festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
