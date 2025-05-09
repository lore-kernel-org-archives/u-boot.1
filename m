Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A8C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 11:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90F8806D8;
	Fri,  9 May 2025 13:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OwnvGDAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4418210D; Fri,  9 May 2025 13:51:55 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1768059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uie7InAgdK9SsvgQpWs6H55rWfyqORCwMR3iWbwjD9T8aBR3jZPGAxXpH+5WaBD24+9HIFfHARo4ZSIvTDApxGYL9LAX/v6B+fuwj7Hm5VxnAoAHcVsD8zpVNzlpkDclLzYnPp6UOxVz4xxQK5bqWnJlaw5RCH6vqkY8X0sc30IDal6ZOPJEhoswHScE0WfPCNrAoDWwLiBkoPV0us7+WK/FH6EWCY63Udz8D5nXzA2sCvmiUev4GxCf5iCTV0t7ZFk6u8AZ78CWAq+jngnGlXsruj+CHK6THhGk0SU2qfkfTbP99CuBAAf8t7opVYSsdvu0p6EiQvsUujcKCdsaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtIHmvdvkOnMg0C1kHn8TPfcBvHMOP/SMDVqQ21TwD4=;
 b=fzkJdAeB9XhCLOqE4cDfxpXhyzjH3FHsGy1PX2SA3m/ua9rVkxAHYOn0Cuda/ENPavKlwmLKol7XDqDwdSSJdQbffvXivD2ra/oV9S2eb4pdfWMGOTSVYswz1+lU4lWdRzU1heqdPSmQ+KGWzrFMz6adRH9qTmUwWjuv9Ydd6Uq5+e5H4mDdmZufDavEGP9gQ8DsILc0ZwWT6kfHpMBnYoQaIgWouIzew1gVphauPxgJdTiGVYt6tT+Q0Jlj0aE8TQxw7LLQ1Vz3kxAZ6slAYJDxMDXsOWWkljSHLdwzOmMOrJF1I3e4a6W4uP/RG5L0Lmveiht2YRVc77tmNY4MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtIHmvdvkOnMg0C1kHn8TPfcBvHMOP/SMDVqQ21TwD4=;
 b=OwnvGDAuKiWTVtcLPc5jQ+Q8eku3Ym7gs/t8ofxjC6uiX4BC/4/595pnnxUwyqaEP4dAStd/lKtg0b+Wt5jEdkF2jhm+p/cwNsNAmNtYVNs424gc4uc6bm/n1Ky0RKpGXadSokSGgxQS+GyWKfr3+x3O6RP6xd+eGLYAwNOoYBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7185.eurprd04.prod.outlook.com (2603:10a6:208:19d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 9 May
 2025 11:51:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 11:51:51 +0000
Message-ID: <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
Date: Fri, 9 May 2025 13:51:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: a08e89c8-0416-491c-ac86-08dd8eefe2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2s3QURoSUNiaWdEKzRFeTV2WjY1b1l1SlZwd1gwT3NyWVNod1FUNmdTbTdt?=
 =?utf-8?B?b25oZ2x6RTYxMVV0UHU5dW5WWnVqTG5DZ3ptS2JDanVUTlpZVVRTY1ZraTB6?=
 =?utf-8?B?MkVBNWpBazk5VktYYjZ3ZXFudlRpQ2xyWEtoZ2kvcHFYWVZtNG1zbXhEWmJY?=
 =?utf-8?B?bkZkdU1XQk5Tem15a1QrOFpiOUNFWXVVanBSam1TYitvek15RS8vM0RvS1J6?=
 =?utf-8?B?TUhmMkZZb25ua3VObVAzdGxaSVN1cmcwejBxd0N0MHBZMGdpVXQ5ODBOUG9V?=
 =?utf-8?B?WFg4Z2lOWUMwVTRVN1VJV3ZBUzdwRlcveXp0R2hTdjI5Tm8vWC9yWXN2Qm1U?=
 =?utf-8?B?OHJzdEtUOGhZUVFEdkJuSS80V1hoTnJHZGR4U21QWHFqYUhlanFERVhaZkdM?=
 =?utf-8?B?QmNCVllyT21RWE50ditReGRsY0dZL2Zpem8yZzZ2RHZrZTNvekwvc3JXTGdv?=
 =?utf-8?B?TWxXdE8zUXZKQmtHaE5DT01sdmtaOTNHb28waGU1SXp2eXdRVi9FK2xNZnY0?=
 =?utf-8?B?d3E1R0ZjVjdic09tRVU3Y0lPVUFZQk1lMjV2OFM2ZmUyZllXR0FIbVJqb083?=
 =?utf-8?B?OGJNeXIxRXJ4K1F4NmtKbGhSZHRMZW9jTjh5dXowZEhERFhLSjdnVHBXMHZa?=
 =?utf-8?B?cW5ZbFFSaEcyclFiZkxrZ291Sm9qYnpRZGlXNXJUcTRJWmpIb0hmbzNYV1kw?=
 =?utf-8?B?YnBqZUo4L054bmphQldjYlAya3B6enJvcFU0aXNjZ2o2dE04VjZqbTUvdDFz?=
 =?utf-8?B?L1I3S09pR1A2c0diaUd6aVZrb3A1a3hGeHhoUmVOeHAwWGVLTmlScjZSUGNs?=
 =?utf-8?B?T1QwWVpUZzE0SVlvWkpXSmg2YXQvNmppMFArR2p1OURJYXppOTNpL2tXUlFu?=
 =?utf-8?B?MzhIUVplY1BvaXVWR3NRb3ovbDBkMmdzVkVjTXIxdlVxZTVJRFFwcnRvbm15?=
 =?utf-8?B?WC9mRVRKV1NINFlnNUlDOTVvckhEZndkcVRCbG41TU1icHAxYjlXdmROaHlR?=
 =?utf-8?B?VEcxN09FcllaSXlSbWZuRVlSYVhrRE5wTUtVM2puZ0llSjRzZjBqdmd3OEVM?=
 =?utf-8?B?VjhQYnNYTzJpTExRMTg2RnBTMnlYWkJxS2plQ2paWVFRUEgxQXRpbVN0SzhL?=
 =?utf-8?B?MzNYT0Q0a1kra1I5UTgzcGgrNlBYb1QzUmtZSjBNUHJRVWZiS2lwZWpEWUVR?=
 =?utf-8?B?Ump5U3dNQzluV1RRenprK2RTTU1aLzMzUy8rdi9YZlhJRm9DcVV5azdieXBu?=
 =?utf-8?B?SFpnS0tMVml0SnlmZ0dYTEFxZlk0Z3BlYkk5SGRBYXR2UkxxWVFUN05DUWtU?=
 =?utf-8?B?bTNGdjFMQzdTU0toUmZaNkpiTGJEZUI2SVlWZi8yUW1OOUo0TVNXK1ZLVXRY?=
 =?utf-8?B?SUozV0hLL2ZKK05CYitVWjFHMVBwUXZ6SUFXdG9HWlpuU0JxczFhQlZzc1VN?=
 =?utf-8?B?R2dmUS8wY21pVzU2dEtpbTlZRDZSZ2pCejlMZnhGUjEybGpRNWNacWk4VzRB?=
 =?utf-8?B?RjN6U1FnZjR4V3NXSWNLT2RTVlhESjFIT0wwaDY4Q3pRZzJGaUMvODR0cGlz?=
 =?utf-8?B?S0xLUHJ2MUYvTHJudE5sSHJiSVVka3BVRlEwaHlqRWVsMmhndTZJRE5vUXV3?=
 =?utf-8?B?ZTNraXA5azFvY3B2OURKZ3Z4bDAwelozM1Y4cGkwMzFNeStPNUdpSXpwZWxS?=
 =?utf-8?B?em12ajNaWVlhVUN4bVhvVmRnR0FMU3RrYnEvRGprNTdNN2ZPS2tKSGxZOHBu?=
 =?utf-8?B?V2VEalhuencxUmR4MForQWVZVkhJSmJwcENFZnViWWVBTURrdHdoVlY3TnJ0?=
 =?utf-8?B?UXFKV0RqaTQrNWp1Y0g1dGswODEvN2J0NExmeW85bTNOcEI2ckd5dGZCVHVm?=
 =?utf-8?B?RHNHRGN2MlE1ZmZZaG5MbTBlRmtLb1FDZ0VIZ1BlTE5iQVFodFFmamY5N0tx?=
 =?utf-8?B?ay9JRmlDcElETHAxeTB6ZkU2SlNOQmJIUFRsT2gvOUMyc2YvTzNEVDlsRkdI?=
 =?utf-8?B?S1JRb1RkZWRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhXbUJaU2NKV3FqV1libGp6aGZhTWZITS9hSlUyandJYzdqcGRES0RIdVhK?=
 =?utf-8?B?V0hUWWFrY081b3hscEttQW14YksvRmRxV1k1UFl1U3lSc3UzanNMbnNkSFdV?=
 =?utf-8?B?dUYyR0wzWlBZMEtSVXltWnJmdFNFbWVpMENmTzZaR2dIZHJ6SkRjOElaazds?=
 =?utf-8?B?Y3QwaSs4NDBHUklwNndGalFvOElPM1YwUFVkUFBuM0tyN3FXeEZ2bUx0bS9B?=
 =?utf-8?B?NkNJeFc0L2lUZ3p6emhtMFlDWFhoK2UzR0FzUmNNTTBwRDI0aldmSm4yMFRX?=
 =?utf-8?B?Q280YTh4cTFGZ2lHZE04NU9iV0hVdHhmUFBQM0lkV1VDN3ppZHlKdUZTUXdY?=
 =?utf-8?B?NUVLcXJkL2Z1bW5vb1YwclpONWI2cEtZUHNicnphamJmNCtHS0gxR3c2OGs2?=
 =?utf-8?B?aUlOaEQ2RWtUQk1LMDlIa0NMbGFheTQ0OVZzdE1vcEFWcHJQU1pnRk1zaGJC?=
 =?utf-8?B?M3BJeVJLMGxGcTN6WVJRMzhBdEJOWjRJMkhBblJZV2E0U3l1djhCQVRnNnZR?=
 =?utf-8?B?b1gyWTN4WlRMVTlRaWJXdFZYQS9xNEZvbExyUGRFdUNXWDZ1c1VPLy9ZYkdt?=
 =?utf-8?B?S0xGOTRUUUUwV2FFeEI3bnA1NXpoUGc0cVhJVzBNQmV0UE5rdFlWQkcyZ04v?=
 =?utf-8?B?Y1VaTi9EZjEyMXFHa3JRUFVhUDRqdytCKyswMm1xbHQyNlBPbndIbnZ3elNN?=
 =?utf-8?B?b2wvZnhtK0VFSXJXYkJaZFZoSUtvU1JsTjQ2ZHJLRkZvbXYybERUTW9qVFY2?=
 =?utf-8?B?N3pjdTBFQ3J0RDVSQUUwSE9CYjhWRUJuYVY3RnNveStVNE1aeXNkd3NVY2J6?=
 =?utf-8?B?SnNHNFZodXAwSEJVTk5MMTRBeEplbGlTdmxhTXpiQ1Z2SXNMRjYzendkQnR1?=
 =?utf-8?B?ZHQyR1dKUXUyN3BUZXNIczVnL3lwaWJocHZDV3Y4R1RkRUJVZ2RFemt6Y2pS?=
 =?utf-8?B?ZGtLdzlmMzQ2eVNWRmVnL2VEZEZJVTlMZWZoMHlDSDd1dUVGVzd0YmFCYjFo?=
 =?utf-8?B?SDBaVnc2VHgycjNIN01NVmZhdmtZV0dlWFc0enpnd3RScVQxdEgxcTd4VGRO?=
 =?utf-8?B?Z0pWcktxdDBsSGJrQWJTUWMxWDF6K21WUWVheFNZbXlrN0pudXRKMEVWNDJk?=
 =?utf-8?B?bm9HWHlhUXJNMXN0cHBPTHZyVnkvVlNCZXlWZzBXV1Y1S2FmSVJ4SGd5bFlZ?=
 =?utf-8?B?L3JMdVJCWEpBSVg4OEcvckc5V2tEdFgvZEhKbnIxWXljL3JPOWNwbGNTMmhw?=
 =?utf-8?B?cmlVTytmcDh3cmVoNUQyTDV2SHVMNm5yTWdCdXlwWE1kL252Qit2YnVOQVRU?=
 =?utf-8?B?UzhOUXFvd28yZnZpS1pOZm1wOVJDRi9ZVUw1TTI2ZWRkc2pSclRVNDV2UDVX?=
 =?utf-8?B?SHlvYS9TRDZzK2dIeXF6QzdWRlEyK0J5TE9DQW9QbHJ2VEo1UE13Um1SRW1C?=
 =?utf-8?B?VmVOcDdXOVlKOE44by9VRjZiUFpjMm1zZWRXbE1ZMGFEMWpuUkZTNzdjUVZR?=
 =?utf-8?B?VTRzZ28yb2EveHFWOGxvQm0xMjhDSzBBTGRCNlBZMVJid0hldlZPcnp5Vnh6?=
 =?utf-8?B?Z1YxbHltR2h1MXl1Vm85K1d2ckg1bjh6ZHQ5QTNzUDdCR1AwVDNOZWJWcGJj?=
 =?utf-8?B?aU9iS242TmdQRTkwNlZXNUtlWVozTGYxUnRuZDNONGp4TDBnMDZ1NHlINkpl?=
 =?utf-8?B?ekJ4YjdlWG1lcTlabGJlV2x6NHhIalAxejBOMWhDc1hodk5OL3VWeVI2a3lv?=
 =?utf-8?B?K1MzcjMvZmtQMUEyUE9yVklaalJSOTY1QzQ1M0dIMUVzTXgyZEVTT0lUVHoy?=
 =?utf-8?B?L0d5ZmJFdllVTG9DZTdRWjB0SVQzL2lGUHlpZmJBc1pzSW84cFB0VWlwaVNi?=
 =?utf-8?B?L2prUXNDWkhFajNSeFhxKzdRVm85eXlST0dvcFR4eDE5YW4vazNJSkZPOUpx?=
 =?utf-8?B?Vm84ejE2QXdaWis5d25pRlBqNFY5YmQxNU85YzhVSnBmc2JtUk9Ba1BrVXJY?=
 =?utf-8?B?ekJ5eWYvN3BMbFN2cERCS1cyYjF0dU50cW5MbnVvdzhCcHFsVThjMVdRWk9B?=
 =?utf-8?B?S3NHblZZeVRxYTZoUlI3ekFnV1YxeGppdlJrNWlBejBGdHBha1lnSHRBSllu?=
 =?utf-8?B?b24xWUc1M09KWVBoLzcxZi80NGFUVTdMQkdDUk5LMDh6QTVQOVBFaVFsYjVR?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e89c8-0416-491c-ac86-08dd8eefe2d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:51:51.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2ZnvMv8QvwYOHBsvSvuZWpUfNEJUcFZipw3jGhtkLBZk9HTbEu7Ia4GvTqKjbDoLI4p9z90VtGxKhAZn2GMyhN8CQG2MrhfPyz/jHSB6XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7185
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

Hi Neil, Anand,

On 5/9/25 9:57 AM, Neil Armstrong wrote:
> On 09/05/2025 09:02, Anand Moon wrote:
>> Add conditional compilation for the usb5744_i2c_init() function based
>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>
>>    CC      net/net-common.o
>>    AR      net/built-in.o
>>    LDS     u-boot.lds
>>    LD      u-boot
>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function 
>> `usb5744_i2c_init':
>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/ 
>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined 
>> reference to `i2c_get_chip'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot- 
>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): 
>> undefined reference to `dm_i2c_write'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot- 
>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): 
>> undefined reference to `dm_i2c_write'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot- 
>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): 
>> undefined reference to `dm_i2c_write'
>> Segmentation fault (core dumped)
>> make: *** [Makefile:1824: u-boot] Error 139
>> make: *** Deleting file 'u-boot'
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>   common/usb_onboard_hub.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>> index 1242513c631..92e3f3a92c9 100644
>> --- a/common/usb_onboard_hub.c
>> +++ b/common/usb_onboard_hub.c
>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>       int (*init)(struct udevice *dev);
>>   };
>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>   static int usb5744_i2c_init(struct udevice *dev)
>>   {
>>       /*
>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>       return 0;
>>   }
>> +#endif
>>   int usb_onboard_hub_reset(struct udevice *dev)
>>   {
>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>>   };
>>   static const struct onboard_hub_data usb5744_data = {
>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>       .init = usb5744_i2c_init,
>> +#endif
>>       .power_on_delay_us = 1000,
>>       .reset_us = 5,
>>   };
> 
> I think you should completely disable usb5744_data in this case
> 

I would recommend to go the same route as the Linux kernel which has a 
special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds 
the necessary dependencies.

We probably should be careful and figure out which boards are actually 
using the usb5744 and add this symbol to their defconfig so they don't 
regress.

Cheers,
Quentin
