Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D978DE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5B680655;
	Thu,  9 Jan 2025 03:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jq9gPHop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744E3806EB; Thu,  9 Jan 2025 03:23:36 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767D4806DB
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9x6MTrgvwzqsi6dYYOASFjm8NkqenOyUkHPLHINYNH73mQor3z26unAW4HO7dMoRmWyKSuTW4GMNG6HOkJLlim6Mc+5ULjTqa1vVPk4JLdv+rlCV/2RQNSZWF1zTp47EKy8fcWQGh2qVcoymAGNUkJyGH22tJPgLzg1Cxe+1zdfK4zhnUYoTNXqyVuNaUzPThWqLUY5E492s0YOnn7ae9BNuwHUerXGj4+sgt61VxbBz/KCwGDSTS8kWNAgVNNGrXW5KPIaCKev0ljYs3eiCOAq2zFHhRCf2eqJGDQAQMHLXB4OmEAxrB7AUR0m9gFEPqbC7ZojCObY7rAyDzpDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=GyaPDDWf85Nb4JAF1gBbcVtknNJJk6yydIp2GYZSPH8+DFix9eehibd0x26fiw8qwY0ybs/ONK0DidnxTOdg102SfdLtHf3/1MwTpudescC9T6jUpuZP3pz6NJC/xPdIeFdLskkRvXPrf87KuE9m85eh+1rzSC4lmbSWKKIt+IN/QH042Zi72iegLWfIDQO5w/6ddlYBsDIB/lyiMex1LNacAjtFw0bKwm9q4Jb30T0u2e+RCvwoeZN8f0gd7QQa/j4Wmk1WyTqrfNvELHRasjk6a0UiCpCtdQpZ48HrQcUYwV/MJnQKR7o9HM35WRfP3uCjAfEo126r+LpO8yktug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=Jq9gPHopLANCwn3urdBihFsYOChXPftYF4tgSzrlmDvhMYQ1ECHaL9ct462wbwRsVom6kr+NsfZUfOh4I663wFYErbwOewYFWnzUPnSnYn7B26SZON60b/fKJs2PRmKGXqPcmwBUeHuMqzLG4kkziLjeFaARueEd9QvFOl2e0Gj3oa9EVkwv9gDvWN73MNhwCx2Th/dNSAfHiDXWhNNfcA89RNqljlAWsJ95CH8jM0p58ta83EpaXzYRJglFNOwGEc2c2Bu83tiGgVV3h95zktRI7VBXDofTLFZXm1GmKSxeAgxbTZlnRXjHSsVQbmBMVz6XCC9P5jDb53b4R42Yhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:33 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:11 +0800
Subject: [PATCH v3 10/17] imx: imx8mm_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-10-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2ceffd-1cfd-49fa-e982-08dd30549d3f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXUwMi9JcDNMTjhBcDJ5UFJYSk1yOG9PM1hqbThEaTZLalhtRkdOaTFyZTIw?=
 =?utf-8?B?NHM1aEFFcklqbDUxSGF6cFQ4RkNzRlJSVmVyMVVDREhuNzQwbk81ZGo0cUNR?=
 =?utf-8?B?MGE5dTJCcEFyb2FvUHBreDhjWXdRdGNKNmNxdlRGSTFBS0dETXUveVQ2bzZr?=
 =?utf-8?B?ZlNlYStEbXdObHg0UVJqb1dRWUVNeXNaOGU4Z3RuZTZoRGhNMDJKaGVKeXFp?=
 =?utf-8?B?YkpEbnVaWjYyQk0yTE5TeE1FYUpZc2JoZEFXUEJKdDhzcngzYy9kMUgwOXdy?=
 =?utf-8?B?cmlXVmkvRnk1U1FjaEZjbjhzOHFQUElBM0VJVlFGZHFzNTM1QzdzVWtyVkU5?=
 =?utf-8?B?cFRnUGhwWXhhNy96KzVrdDNKL3F0a0dNMDRJb1BtamsxUDVuTXkxM0drWW42?=
 =?utf-8?B?SEdJWmhZVjNPZUt5YUEybEl0VHBPS2hHOUdQaWZ1U1VXUHhZa1EyeURadWM4?=
 =?utf-8?B?V04vQ0RZeGtoK3diUU85VGltT0g4YWVhNERNdHhJTVVvM3YxOW83blZkbFls?=
 =?utf-8?B?cW1xYjVsY1JYKzR4cmVOeDhta3lDZ1kzYjY1MTNzT2p3a05LSThqZHNvd2xz?=
 =?utf-8?B?ZGRrMHROUTI4NmM4UzlNSHFzRFFEQ0F3SS9hazhyM01WMGlXWCtXRW1ZckYw?=
 =?utf-8?B?aXBuWEhSUUZNNnZKR3hMQUo4WlpLaDEvZ3JLd3hIMlVBVDRXaGlTZmRUN28v?=
 =?utf-8?B?MGc0M0tOTXR5VzBJZVN6bXFMUEhzdFpGNk5Xb3FnWWdhQW5ZdDBLVElaU291?=
 =?utf-8?B?ZHc3L2tMRWVacS9OYVA2cnZvWjhCbXVvMkRhRHZ2TmxJZDJ0SGxRYWRDOHI3?=
 =?utf-8?B?eTB3V01Td2lCT1I3b3J6bTVIckdEYnc1cjZVK2c1ZUNWVXNPVk1LTit2VzFX?=
 =?utf-8?B?bjVOaWtVV0NGUU54UytHT2F0LzJQMUR0b1puOHBHVmI2a0M2NWZybUdvTHc2?=
 =?utf-8?B?V3hxYVI0RVFLSTNqb1dDL3RvUzZqS1V5dlMrS3hsNzk5OVpacXFISDN6S0hL?=
 =?utf-8?B?VGkvNEhXNGxUSER0R1k2ZjE2WXVWd0Y4K0FGMXRRZVBMVUIwTHlERHFKNlhN?=
 =?utf-8?B?MjdWcHNQeExtL0F4RnRlVmh2MmNyTXFsZ01iZDg4RGJtNTkrQy9pL3k2ek5y?=
 =?utf-8?B?WXBwNnFFb2tZc1kyNEI0UlRQOThQbk5CQkZ0TFNBWnpvbysyUUdYYlJwL3VT?=
 =?utf-8?B?TzZXVEFGQWRKMGJwbVMzRHBzNEg3K3JZd3JBWEVaSGx6dEc5aXhGUjBHSlov?=
 =?utf-8?B?elEwQjJ5ZSsrOU9NTzFwUDhHRXVxU0hVZ1NzL0JtUnN3VWJJSzN6bG5vRmVq?=
 =?utf-8?B?MkN4azd0QmIvdU1HSmthaVhRdjlZV1d6djVLY3AwZXNOOW9SUDhxYmpaNGZV?=
 =?utf-8?B?NE1OcGg3Y3NGUEFjb1BPOWVRMXRDTUllNmY3aEFnZHVXV0hCR0pqV0svMXJ6?=
 =?utf-8?B?VFpmRVdnQmdWTnRkMXc3cGRsTWZPQVk2Um5hWHRIbDZRVzVmekxYTFRwQWts?=
 =?utf-8?B?Ykp3eUpaV0YwY2dwaWxsYjUxWTM0c3UvNlRhTXl4SkdqMEozSjhTQ2M3TjdZ?=
 =?utf-8?B?MmpzQTdDb2tRbmtIVUhVSFpGSHJpbVc4bC9rcDJvUHpraHJyS2tLMC9hS011?=
 =?utf-8?B?SmhTaGN3M2NXb3FuV0huanBjU2NXVFQ1T1RlR1hVUE42V3htbVJ0RCswMlRI?=
 =?utf-8?B?MEFHYnNHYUdEYnd2UExidjdVOHVFK29OQ3J3bXhWY2dmaFJac2xFVEtTc1F1?=
 =?utf-8?B?UXZqRGs0ZXVNaG5oSXhjMVVkVkNXeFQ5eW5CWkhsekdtaHg1ZnM0eHVERGdx?=
 =?utf-8?B?cUVmNFdSYkEvbHEwVVhlNWlSYnpHaVcwWE0ycVBwaHpUTHpRUmZnamgvQnMr?=
 =?utf-8?B?UE10NE1lYmVpQ093bVM2SWNpZUNRellNMHBUOXY1b29pcmlTL25zTEtmNjJn?=
 =?utf-8?Q?5yO3LD+OvSSsT7G67N5u3cu4asQf7Klp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1gxRUZDWDE2Vmk3TTRmT29UTDhRMllPVHU4d3RHTnJhT2piQVd4eTErd0J6?=
 =?utf-8?B?amR3VEdLd3htVXNmem5HcU4va0dxTEdIcEl6eUNyN3NnRDJyNklSakQwZGtN?=
 =?utf-8?B?OXd5bFI1bTNlVmR0V2s0VkVuQjErMmRGWHdHR2R2MThjbkhDYkF2MzB1VENX?=
 =?utf-8?B?NVhCRmI3NkY4cHVRaVRvYnZrbGNsMlZCc0xrT0NkTThaRHNsckhKeEZDL3po?=
 =?utf-8?B?QUNMQTdVbE5EVHBjZzVDSDBTTG9ScVg3Y29UR3RGT21RK0Y5ZXNTanZOajBH?=
 =?utf-8?B?VzhwVkxtSkJ4b1pkNXcwTDlnTVNTdjFoWW5odTkwWGhiRmVITE5ub3lvZHRw?=
 =?utf-8?B?STUyaWpETXVsT3MxYjJwaDJ2U1M2QnIrdzdwL3grb0FDcG5zUE45UmMxNXM4?=
 =?utf-8?B?a1M1blZReVhYOWhQTjhQSEdabUNsVUFCSnlzczlGQWw4dWxIaWVHdVNFNDEy?=
 =?utf-8?B?bE85MExFNURQUU1ia2ZkSXpPNTBHbWJyTHpOYVBTdFo4NmU5NFIwYkpNYlBI?=
 =?utf-8?B?T0s1VVhRQ3ZRYVpEU3JWMXFQRHp4OElLa0pXN1Yva2doVXB3SC9ka3k3RG14?=
 =?utf-8?B?bkxXUDRnNGUrUzRaaVJRTFFUTGxHamo3T2pkUmM1aENJQ3c0aGpSVVJGdTBr?=
 =?utf-8?B?UVk0OGNRMHNKOStYSlE0ajgxZ0RVY2JmK2d1end1YVhNYjlWVXkyQW42RG1v?=
 =?utf-8?B?dXBuVm5VSmFuRHd1b1dpTnZXMVdENzRYSlgvUE51N0t0eE1WdWtNK2FJdXNz?=
 =?utf-8?B?aUlJUlF2bmZnTTVXVENBZTVsYzJrV3NrQXU5eklMQWswd3doU0xqZjhIZStK?=
 =?utf-8?B?eWhJUVNtWC9Dc1NremVUeXRQNG5HZHB4dHBJdmZPbDcrdGlMKzdLd29qTVZv?=
 =?utf-8?B?U01DV29Vc1hRVzdQbDJQUkZuQXYzamJ3cUdxVU9qelZ5SjZOV2EwM25BbFBo?=
 =?utf-8?B?aG9ZR0xWNzVybm1NUUx5a1pOd0dDbGR6R052bmtEeThJSUhSaFo4amF5MjF6?=
 =?utf-8?B?YW9pUFkrazVwL1kxNW0yT2xQV0l6U1pnaDVzUG5PdHFkRWJSSFlGaGh3ZTNQ?=
 =?utf-8?B?V0p2VVJuSkRSN3pzQmJ3QUsySzQzNWVvRE5xbm41OTBwMDBhT3lkUVVvV1dH?=
 =?utf-8?B?Mjd2N2lTSkNVWnI2b0FOSjhhUnJzSWRiOC9TVTZ0NU1JUUNkZUJYeFpGdFdH?=
 =?utf-8?B?ZENVREpOaTlJZVZrSGozR3RzTk5Hcis5cGdESVJqcWdzWGVZU2lXc0hLSnRj?=
 =?utf-8?B?dmU0bTNUVU9BWXBjUHBqdm1lQlJVUU9ncnFiVktqMFlmUWFic05Qa0l1TTVE?=
 =?utf-8?B?MVlJekZWaEt6TkcvUjd0ZlYxWjhwVm9KMThjZGhjWnRsZU45R3RyWG1YM251?=
 =?utf-8?B?ZmdsbW43bDgxd2xDMVp5ajZxcU5RRHNIczc0S0hzWjl4TjZTMTNsaFdFeFQ5?=
 =?utf-8?B?N0ZSZU9QQzhYZktVc2lxN2NHRTJmWUpsRTkwaTROMmlzNHE4cTROZk9iRUd2?=
 =?utf-8?B?VnYvVDltNUNvVStIRDVHYjN5dXd4SUxzUHlMRmpRZGlYN1cxUTZpSDRWaGwv?=
 =?utf-8?B?N0hqTHg1S3BabmhFS2l0L1RGR002eUdIV0M1R0RyMzlTcEgzc1hKWkxyNWVx?=
 =?utf-8?B?djBxOHpodXJxbjI3ZStTalgzb2dYNVp3Y0lWbENScERWRG8yNEpHT0c0QVlk?=
 =?utf-8?B?UmlCeXl3ckdsL0NuY2lvTElkejRpU21YNGRKYW1zWGpVQUhUQ3I1R2tQaGxJ?=
 =?utf-8?B?UjQvTld3WkczcW9OUnpoZ2Nza0d0aUdkTmJTVVI5ZU0xOFpScFRzb2U2eVZa?=
 =?utf-8?B?RG9aVWdCc1djR0dXelNWWjRnNFNwb2NnWXFGOVFob0daWndIc2JWdXo3YUVl?=
 =?utf-8?B?RXl6bEIrbWs1bWdDZUlYbUFmNFRsdFpUa2dxVnA2MTBDa1BsV09qN2NOaFBL?=
 =?utf-8?B?TDd1cEF6YmR0YlAxWFdpMWVCcnNoVVI3MWNDeFl6TEgrU0RMVFFJekp0WnYz?=
 =?utf-8?B?ZVd3TUM1S0JCSVNEK3NxdVROZEpxVHB5YWJVb1hmQy9IdWxnRTlFV2E0NEM3?=
 =?utf-8?B?R2ROTDc2NExpSnlmZW80THo4MTIxWi9QTUZ4R2xEZkF0K1FGbVBwVmRqNmdV?=
 =?utf-8?Q?VXrCjesI9yDSnr1zjg9KzpvX7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2ceffd-1cfd-49fa-e982-08dd30549d3f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:33.1188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiRPN1v/LqKn6IKy7+PTZFU4wjJBKbWVjYXOSCCiZodPN0GWyRgceCvGMQYSp7ZA1IN5LkO2ac1q9vimzWHW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MM-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index 4c4436af3b1dd7e796e48458488d2df4e60c182a..d41db8d31d81b44b86a7aab5fa57d97d99e41a05 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -59,6 +59,9 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
 	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
 		env_set("board_name", "EVK");
 		env_set("board_rev", "iMX8MM");

-- 
2.35.3

