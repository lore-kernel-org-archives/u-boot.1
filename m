Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D14C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629FC88DCF;
	Tue, 17 Sep 2024 04:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NmxDiwA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2638988E4A; Tue, 17 Sep 2024 04:31:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EAB88D9E
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7Ovj/23VVxkauNWqkAkghqamPE+F0HFg35HfGAVh20Bqxz2ak6V3EReq6VLdZkoQtKJdPQ9WdUod2qX4eKOdo+9WaQhjV989XHzhpH+qIPrJSQ7ZIY2nTokGH93ccLa6drG+ZA4lq93S1LJF/GO8KYEB7A4pjJ7SVNePQxEYGGlCpgBKISnZk3pn4ldcPdu7Hn1oD8Aa7/RexwUOQ8SsHkp4TbWzRFFSfKDQDMFR1+V/EPUFx3l6zvxZX/3CC0SHPGUmZCwPqOVXGNxExPxrx8vE+kY0FwzLytjseEKroc1OskLQXWyRidfH59i/rB9Mrz5dF4IDeNt2fSox4kmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNrBUsU+18UvsRaUelQn5D2NZvjjglmKpU7Wqi9zasc=;
 b=OBmlZrmFDg0AZLn0obVuIkljyp/ufs0xk+lOHmvis3f4OrDMU6ke2zLnFKK6PRdCn6Gk9jGX9nzkmKCUXnCNAwRB/FKXx1VA+AZuybtM7SFtwZtkR6PfOjeVwTwEDYPhaR3Gl78rq4vNKKnVbuBCMvAN1DxPwywzGxiFmIAQ1IzHGW4OmEfZtuN82VYfk8RfUr6muO40Xa8Svr6I2kA3EePe8FQsV0H6FgIwUfwSFDRo5aGBNgO97ZpcY7VdWIiVkbPiQGke8Xq6xgh9IWOiU6ofb0R8Ly0OOLuBUxYSHKnpb28q5HA0K5656wVu81dSJW0e9OL2WV0TUxaHlh/x+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNrBUsU+18UvsRaUelQn5D2NZvjjglmKpU7Wqi9zasc=;
 b=NmxDiwA230HLYTGTpmEXFwKUuDEzSW+pmHCnKK0DQ+Ylkk5zMU+egGjtwV3aBD7Ca1nvUYednYcqyQLooZCHOn74CZxX4G35X/HRceZgU/K9aM8gycnE+zP0egs9BhqqgYmXRuWGr0yNuKRmzMsUQYh6zlBfqvONWMxyrqyDnyPuz6Y8l9gaY6ZHuB2foJ7adHmIc6uxu797yUYAcbdTkXWeuEC1PRC3CUaPjL+YPBx8xJRLVZ3168cB2i/pTF2XUk2NtyjJ3HYncYu5QXUJFqK0Z85H081Vuzyw+Gq5sh0B8EvoSH39Kk19RAv3i9sImR4zMQsB7V9mL0j+arup0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:05 +0800
Subject: [PATCH 13/21] imx9: soc: Disable cpu1 for variants that only has
 one A55 core
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-13-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cba97a8-1994-4629-4470-08dcd6c0c8ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEV4NkNZbTh5d2hPL3hwZytpUi9UYm1jbzFhNkM4SHdLU1FFYjl6SnR6Z1pk?=
 =?utf-8?B?dFVDK1JxSllDQVU5T2pkRW5tdHRCWnJiT25tYUsyMmZqMkF5RGxxQjQramRl?=
 =?utf-8?B?SFZnQk1FS3VqQTkvaERxVWo1UHBpUXhFczIrc1o4YWxKOVhXZ2ppNThHQ0d1?=
 =?utf-8?B?VkxkSGx3bllYRGhZMHZBU0c2UWZsVnIwOUNvQmpMWlQ1VlFLRXBJMVRkaHgy?=
 =?utf-8?B?Mm15akZabE1KM1RuUFo5ODdHTFBEN1duUlR1VlUwYVZValVUaWR1UVJMYlNN?=
 =?utf-8?B?YklDYU8yN0J6QnZNY0hyMVgyOWJJQ1dMZzA3UkV4R21RbnlSQSthK21nY0NH?=
 =?utf-8?B?bDZMR1NSZWQrR2JHaDdUYkg4aUdWd0Q3RG96MUdkcGFFa09ockJiSzJPajh2?=
 =?utf-8?B?Sjh2SVc0UVhqdVlOVmk5ZXhxcjYxdnRRRjhiMmQ0MmZDRVNmY1lhYmVHazFT?=
 =?utf-8?B?ZTBveWZCSXdQbWhuOEg5VnFkRGZqbGw4S2RqSnB5SWo3U3VoSXVYR29DVjRD?=
 =?utf-8?B?UWNNL2Z3OVJMUVFuLzBvWllUWTNnSUxLYWxibVQyWmp0Y2JpS2x0eDV0OVVr?=
 =?utf-8?B?RFh0T3pGOFdGYWdCaFRZdC9wNEZhR1NzN1p4aFFCWGpSTXpaeDNXTE9XT2pj?=
 =?utf-8?B?OWFWNXpBempDZnAvVk9lTW5BTnliQnhHemFEMVlibGRTVnl4dHpZWkpwQjJk?=
 =?utf-8?B?clNDK1F6bXRMcVZuYlZlMkZrUmpTdVIrYzJKcndienBNMFliU2tpc1dTWWxK?=
 =?utf-8?B?dm1MQmRibERDTVJ0cXpXMWRUNUlqc0U2MzBEOEozUkVQcFRIN296V3Y5QUxz?=
 =?utf-8?B?MEpSZGJKWW9WeTFZUSs2TTNtZHVtd1QwbWJWK3lnRFlqM0N3THlaMmxkRERG?=
 =?utf-8?B?T3RCRTY0L3NnL0JTVmJCdGs1c3h0V1NMamY3VW5KTkhUdjlHdi9UR0tGeUtF?=
 =?utf-8?B?QVBJdDNxSEs2ekd6YXVYUFMvRTVzWVJoejRCY2FnSW1ybmNiSHNvOTQrVHBa?=
 =?utf-8?B?TXhNMlQreFJERzNYYitOSC9TWEVvamhEOVhsMVRWeUgxRkwxdCtJcmV0ZlFV?=
 =?utf-8?B?MFJRWnpEWDRycVlkSndnZ2xYVzRJSXFrS25pR2lrdHB2R043ZVYwaHJLQ2ky?=
 =?utf-8?B?aElkMGgyb0Urc3JvRU9DSGxOdVhJU0VXeHBHa09JL2ZkemFVTWhBdmt3RWJr?=
 =?utf-8?B?eDc4dUNZdGNNTTRMWVNNWWlhNWVjd3ZzTVB3SWlIbjV2cnVJek1FY3Vab0gy?=
 =?utf-8?B?OFVGTDFhSSs1QlB4Y3pGenB0TGNONldIaFZJdDRWTDhPUGU2WTYvWDhseVNh?=
 =?utf-8?B?R3puQ1RjQ0UwRmhyNTNLNlM0SG9Ocmw3dE5ITmFFa1pLSGlHVm9TM0xhRUNF?=
 =?utf-8?B?eGQ4MUZKTkRpQ3llVDhMcjZ3Mlo4YVl2WU55WGtXMDAzTUd4Wk5CYkFLYzdC?=
 =?utf-8?B?NDRMa2QybDR4Y2x0SXZ2ekxOUm9mMGJKNk1Ga0lBWm01ZHRITnFJRkhHek9s?=
 =?utf-8?B?eUZrOCtpVVJXTmt6UkpVY2dkMDAxTlJSUERvakZwaVlINTVvQXlsYnNMbjVq?=
 =?utf-8?B?ZGc1YmkvZjYzSnpvWXVGcStXRktVMmVWWVdwK21RT3NVeWlUU3p2M3lSLzdn?=
 =?utf-8?B?cGFGMlVtTzQ2K2lGL2JEUGJ5Yk5OeXZubmlqbk02YTZaN1U0SFExOURiNC9V?=
 =?utf-8?B?bEZnTkljSGZ4UnRHQ1hhRDdLdVpnNUFFS0J3enVaNkZkcFpXaDRHdncvTWlY?=
 =?utf-8?B?ZStObVF3U0s2V0JoakJFWWNkcDYrdGNublNxMHowa3pRRzY3NUNyRkxORm9L?=
 =?utf-8?B?cFZDTGlBWVVtS2NPYVpYc0YxUGxuRXhVcnN4MUUwQkdVeGJCMkszTTFHZU5l?=
 =?utf-8?B?UlJpOSswZnpHYzcwZmlSQmFaR2JSOTBteE5wWjhtM1MxN0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3o1eExRTmtVd3J2WFJuZ1A3aGxyN2J4aThNZzY2T0pvcTNWdkY2ampvK3Ji?=
 =?utf-8?B?cC9GTDBmTDFtSlpIM3Rma1hWeTY1aUNzaEprNlYrWi9KUktxUXkzZGdwUm1R?=
 =?utf-8?B?T2UxemVHbW8yNU0zVGlFb2pac3B2NjdDRUUwd2Q1Mmg1RE5NOU14SHkrSGRt?=
 =?utf-8?B?VHZjeFJRNmVMOEFydmRTOGtqZjViSEhMY25CNU1DUjdXTk41SENxdXZJNU9N?=
 =?utf-8?B?d1VxNWc5Z0JIakNjb25SWHJ5dDNZQWFPa2FYMUl5a2hIUkZTS1poREV3V0dy?=
 =?utf-8?B?bTJMRmxBUU5QZnVNV2NmZlRERTJrTG4yV2tsWFJUR3dYdkI2OGp1NlhlWjJ0?=
 =?utf-8?B?ZmlWdW5IM0RzRGRsM0dkZEMxcngyRWlLc3BVcTNvVkY1bkdHYXFJU08wV0cw?=
 =?utf-8?B?MEtNaGIyTFFUVlhXVlVJTVBOeXBWQk1sV2IzaXJzdk0xRXhidzQyZGp0STA1?=
 =?utf-8?B?bmpzMnAvS0czUkQxMTV5WVJmZXhGWHE2NmxDMmdreXh2dytYcXF2anBuTTBo?=
 =?utf-8?B?MTZpNk9ncENSS2QxSlJvdVZhbllISi9xVUZOUEZKVjhpN0t4YUpRTk1JVXFq?=
 =?utf-8?B?OUZGSXdlSy9vRHVIdzdoOGkycisrK1Z3TzJpam01b2xmNFRiT2tINlZaVVZo?=
 =?utf-8?B?SEJwNnJsWE9ISmg4RFNSV3cyS3JuWjJhMXFYaDVyY2JBVXpxZjJqU1g3cnYy?=
 =?utf-8?B?bllGcUMrKytHVmdJVGVacWRERXBKZXBhelJwVWxFUjkvOTFzT1hwUGprem5x?=
 =?utf-8?B?ek4vSmZuSitpTGNkNUprcllhamo3Y0pGNTJ2eEhEV0FQNkZqSmYySWRlejJt?=
 =?utf-8?B?U3kwNkt1OUhCU0pCYVMydnM4TFJzemlIWGxKd2hFNTlHTmk1a0drd080cWl0?=
 =?utf-8?B?citwOFMyaVRlWXBEMHpSVzNkVWpZSVNFV1RmZ3dwNGNlSUFJajlRSVlFaERC?=
 =?utf-8?B?QXp3UGR1MTdiTkV1ODJJdCtnY3UybGlpSFIwLzdoMjBEdDB5VVdhcnFvaEhn?=
 =?utf-8?B?Y0xmV0I2M2dLa01YcVZxZGdtNWhtMC9CSUkvcklZWHNjMjVFdTFBeTh1T01E?=
 =?utf-8?B?UUZ1ekR6NGxjUHdBcndsS0FlazVoeGlxUytwb3U3SHdyMncrSUlZakgwNUJO?=
 =?utf-8?B?bGJtSHM2b0I3ak9uaFBITzVZUERBWEFGYnlKUkdOaWJFRkszWDFpK2k2ZWo3?=
 =?utf-8?B?d0tvWVZERE1wblAzUHRoVXkvbi85eENZOEJiTUZZRTAvaThoU0FRNFJmazRZ?=
 =?utf-8?B?dmZJeW1oT25mU3BsNmVVS1RQcG80K1FVSG9OUHBNNXZ5NmZOak9HSVJqVTNi?=
 =?utf-8?B?N0NGZTFQOXJJY3NKWndZWDVGeFJVSzhsRW50T3R0UWgvcUZTVUlrNnZnMHRG?=
 =?utf-8?B?UnhUK3VPZTVkcldFdkxsMTdnTVhXRDdkRjkxbGRFL0JnQkNYanZEaWwyN28x?=
 =?utf-8?B?QURabUR3eVVTUWhvN3BqTkFONU5XRTZPcENGeS85ZnBSeFBqV2RzR0JKaTRF?=
 =?utf-8?B?d3dndHFaZkk2VnphVmR4QW1VU0pZNzJ3M3ZIVXpNMUNxSEZxNnhZV3RnVENs?=
 =?utf-8?B?dXNUdHB3SHRLTGRVVWxIK2ZQNm1YT0sweGdiMHNWNGRmVE5iSHczd3c1T2tG?=
 =?utf-8?B?U1dTYWlyNERsNWJlUnpPbjZWblZ2UkR2Sm5TV1VMbWlFY3FYM2MyMWs0aVdj?=
 =?utf-8?B?YVZjQnlZMEQ5SmdOa3ZyU0V3L1hHbFdTazFOK0czMWwxdFY0ckFtbG9OV3pj?=
 =?utf-8?B?VWdCYzlnV1FMZWxOSFRxSlg3R3hNcVhqVlQ2M2FZelVJdEhCMkNmaFlhRVUy?=
 =?utf-8?B?UzhKNUhNODRZYzV6czlLNjNySmpMMHgrbHdmYkl3UllnQm4wRUdSNFhhSllW?=
 =?utf-8?B?UW9vR1lUQmh1TTVHbnZjd3RhZUJRVE5hMFlzb1FDSEpxL1M2TkpjSUR5QWJk?=
 =?utf-8?B?K3FpQVdDbjJKdm5kenBWTm1uWXdpMUhhcjR0WU9VRmFRT0ZYZFNKVFdzTnM5?=
 =?utf-8?B?c2kvbUJxN3huZHFlbCtqYnJSTGVpNFdpOXBHWll0RmZJSFhuQzBxUWwza2lz?=
 =?utf-8?B?VlJJblM3MzNHdVRYMHlDbkZna0RremxJaTF6a1dOMXV6a2RZaEdyVisydTZ4?=
 =?utf-8?Q?+s5VdXqv12KcdZUuI/lce7oCw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cba97a8-1994-4629-4470-08dcd6c0c8ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:07.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejBmzzAvk/JAG/VWkLRmAgelmRz5WCqY5YyYX3huFlf8rKOQiXZ8eQ8/vRt1x5u8hWAUpsEuyfT4QgKEeJGTSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451
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

From: Peng Fan <peng.fan@nxp.com>

Disale CPU1 for i.MX93 variants that only has one A55 core and update
cooling maps.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/Makefile   | 7 ++++++-
 arch/arm/mach-imx/imx9/soc.c | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 47e2cb8d943..f8903afc92e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,6 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
-obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
@@ -22,6 +21,12 @@ obj-$(CONFIG_IMX_HAB) += hab.o
 obj-y += cpu.o
 endif
 
+ifeq ($(SOC),$(filter $(SOC),imx8m imx9))
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y += fdt.o
+endif
+endif
+
 ifeq ($(SOC),$(filter $(SOC),mx5 mx6))
 obj-y	+= cpu.o speed.o
 ifneq ($(CONFIG_MX51),y)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index a73e73adfe6..0f8ea55eb51 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -688,9 +688,17 @@ int board_fix_fdt(void *fdt)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@100",
+	};
+
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+		disable_cpu_nodes(blob, nodes_path, 1, 2);
+
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		low_drive_freq_update(blob);
 

-- 
2.35.3

