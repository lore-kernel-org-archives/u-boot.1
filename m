Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165BDD1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F56841B1;
	Thu,  8 Jan 2026 16:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bs9f28FS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D955C841CD; Thu,  8 Jan 2026 16:59:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D5C84158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8J0JI9zhDLwW+vsRh3lJh7Usm/A5z5ja/AivpzoCcNLgzKo7Iy4yq2hjqInzOxVGsQE+aQvH3k/Bd5oDmxy76FLIIgysOnicaGFbncbCFK811GVApw0ePXLk9cGSPtjnMecVlFbco1J7+AElRm7CLv0/Mn22OIYC96/p5Rx9An7qZdQhpiBWqj2fiYJg4jkWJR5HNWyWqitvHE4TvmAUez62QIn8OyGblw0Ar9KriKuuMhVFGdQBbAoa0MMQD9uaxwt70L1TRI49/Juh3V1y2adUnpmGQLgzFi8+ZkWxVgV0UZyjkkrcQpT1hcZI3i+p76pQaagjEtl1WyVMbh2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq+RSJ//jrAnGmLJLkVcJb7EeQyxbCI8m4vwY3t8ITs=;
 b=kfGa822hzjk2FOQsqEYRMxBNcSahuL8rl/LsmJwm496rKLU2Qz1N27Rej8qZDs+KAgTdYEjDiDYl7tnlIk4RcVmKotR2XT5eFKx0YdnzD61RLi0gu6Sxg6UcrhWq3ScRqrvnXhSNKKLZxpZxv1uaOld3H716ltLx8OeE0K7LI/F7eNsTAjq62g4fgmc02waIVqeT6OV9CWDaq+0MK7hdPiy5++vo7BCcV8OL0XZz12wcnBXNy5mQqckGv3CZe36NEI40mbqIhGJXVPvywidWv7wiKt7qXz6N0J0Kefh84a3bPnBMK/c8W+ul8zT17JgEtspUQTKfDd7XgicF26EnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq+RSJ//jrAnGmLJLkVcJb7EeQyxbCI8m4vwY3t8ITs=;
 b=bs9f28FSiirujoPYR6q+W0g35/JC07qoYTHTvhYI0MMBYsl5oUav+8w8sbWcpmOOFeUCp1VoijmAYPd8IKyJjjGJ3ceOBfxSr2+MPau+opS+0LbK1wqksIGknUX1oGp8PW8zdjzawBiAU+Grxm5UzXCjVHe+aeI+R+KbMbDjXJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8209.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 15:59:03 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 15:59:03 +0000
Message-ID: <a1a22e85-8812-4064-8b9a-d779884edbbd@cherry.de>
Date: Thu, 8 Jan 2026 16:59:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: unclear license identifiers
From: Quentin Schulz <quentin.schulz@cherry.de>
To: oliver Fendt <ofendt@googlemail.com>, u-boot@lists.denx.de
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
 <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
Content-Language: en-US
In-Reply-To: <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 88068432-2849-4a36-8001-08de4eced83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFTUURlSXVTSStGZEFJUTZURmM0NldOTlFTb01UK0hjcFk3SndkOWdSZEpZ?=
 =?utf-8?B?Z0hHc29vUy9CaDFaVThsU0FOeVdNNW45MDRFdjBwZFc5WlI4OVJiUnh4cjhl?=
 =?utf-8?B?VTVpNGNZWWoxOURqckM0aUZ2QTd0RlVrOXBLb3FtSUdrdmt6bG9BclI0Ulhv?=
 =?utf-8?B?VDFNdGlJd3BIckNCV282NEE1UTVsUlE5bUd4SlM0bEM5anoxaEJ3elp2R1pP?=
 =?utf-8?B?ZUluY1NyU2VjNWtVemcvcGFwQkNpeDRCM3NqUVBCczU0eXJKVEdSUktadWpS?=
 =?utf-8?B?dlU4RmZLNDl4em93eS9Kc3BZK011NHFsT1BUTzZycGRabXU0eEx4bnZKOTk5?=
 =?utf-8?B?Q3hmUmVVT09PR1UrdmRVTGlJKzdaMFJqVld5SDFJVkl2VXorTnlMeHNvRUpH?=
 =?utf-8?B?WVNuMmp2eXlLZjMrc3ZDUEp6T1VUcDJvbmtrcTVDTStOYm1CekgweFY1cDhO?=
 =?utf-8?B?TDlLYXdRakRDMS96V0tsTCtESGE1MHdvRlM5V2RhUjBMVlcydkpOVHVJNXZE?=
 =?utf-8?B?R21xVXVRSng3MlFZTHYrY0ZZVFBYTEg4ZHBIRm0rMFRBOHpvTXBSVzZnMlNU?=
 =?utf-8?B?aHc0ZW9LdEJZVWVDaWZ5cjNKT1JQZmxtQ2lKZ2lDQ0pCUDdMV05nRDRGaWVi?=
 =?utf-8?B?cmZwd3hQcFlJTFdwV2RPM1ZEa2tSTEl1enpOMTVmdkw0Mk5iUTVyYUxtMXpI?=
 =?utf-8?B?OHdEaUd6aWFMZTFBM1drUGo1Q2tSNW9Lckt0Zjd3Ujl4UTRnUC9McDRiM3Q3?=
 =?utf-8?B?VTY2WmtLdHhHUlE1ZUJtTFBrT1ltRzd4aEtLTXk1MDIzNFdYaE1YYVBvaG14?=
 =?utf-8?B?azJtbnluMG1YS3o3WmJxaGUvL3NTZzR3L3dLOHJ0b25ybDlodmk1d0NrVzV6?=
 =?utf-8?B?YzBHM3JscTBOYUU5M21jZVp1K3VIRjM4bTBCWXVxalhuN3RhaFUwSWppUlgw?=
 =?utf-8?B?UWlyei9vQ0NzNENzbzErTmpGWlRvQWp3L3JjcmZFWlNFdkNkYkl1aVNiZUgw?=
 =?utf-8?B?dElSTHhWQlU1Y0VpUE8rUFd2Y3NvdTdqOEFqZC95cS9rZHV1UXFNQitGYXFC?=
 =?utf-8?B?clpzNmwzSVZvdUEvNTVOMmdiVHY3WERqL1NpVzFVZjkzL1hYdE82ZU55Smw3?=
 =?utf-8?B?OEpvWDA3YXREWjU1WFU5UFlVZVc0eVh1RTB6cFpPbUxjR1ZCOXFlRTI2MlQ3?=
 =?utf-8?B?YVdUMitSWFpwZnRqVDBVWXFLbWtVb1doZ29lMzQzUXZvMElaemFsQ0ZWaS9o?=
 =?utf-8?B?bktYb2UrU0U0bjd3bFZGb0xMM0VJV0JkM2VHcXIvcW9IVnBpSFJ0dzFiQlJr?=
 =?utf-8?B?MVYxczJMWFN2c1BaaHUzZy95WEZ0ZWZ2QWtkUEFvTG00RktMclRuRzhKK3Jt?=
 =?utf-8?B?dUhLR1o4WjFCNjJzNW9PVFRIYk5yb0lXMDZDR2c1azB3WnE3a0lVQ0ZFR3M1?=
 =?utf-8?B?eHVWVjFja1Y4M2lRejJ1UlhsMlNHOTVXNWdXUlhMUnYvbnBMeVVTZWlwM1Q5?=
 =?utf-8?B?Ui9oejd3djhpaXhTdXhiS3ovbC83MkFMaDVEWlppeGwrZEJ5dTdtbm1oalA3?=
 =?utf-8?B?QTJIRVNtRE1mUzhFTWVPNEphd3hjbjBrRks2cGpLWVJUUGdrcTlkTCtDUUlu?=
 =?utf-8?B?T1k2YnhpVzc1azlyRE45amV4a2EzYUZaQXZNNkhUZHJFSFV0L2FyUWh6MUZ2?=
 =?utf-8?B?SWduUEYwZXpXYllzam5Ta2ZlZmhjYVk1TzJQK0M0M21DZ0FMWVEyekVlSjZL?=
 =?utf-8?B?b2FFMnZMU3QrZVJwUUdDdDdDbUx4US8yZ1FZNUxxV1d2SEJUMzNZVGYvbzJq?=
 =?utf-8?B?bWhkN2Z1S3MvOEtJbWFZb0U0ZjlyeURMSFVaNDBNcGhsajlPZlJUQXhaTVd2?=
 =?utf-8?B?QnN1N0lvK2QveDBBVEZpNW1uaVJsWXJiNytsNHV3MGxoRXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUR2YWxNRzlPZlF2bHhtU2JuNDhveEZ1czVoTmdNSHRmTlBMdVpHRkZOZGFK?=
 =?utf-8?B?MVVCVDh3Z2lGdXlHVkV6clJHNVVBTUFWQkhUWEpxSFNYcGh5OFQzQjZuQitP?=
 =?utf-8?B?N2dEbWlYR2FmanpUVUZqVTRnaFdpUXlPb0dlYlVING43ck9VZy8wL3BwQTVV?=
 =?utf-8?B?a2M1REUvS1lvV2ZWcW12QnVwZ1g1dzh0V0NLNmZmZFpVc0RnVFNpMlFqZ0Fw?=
 =?utf-8?B?T2hTcEJnZHMxUEFLOGpnOG5VTXJUelcvZG9WMmxsUlN6R3l3RlcrNUVJTytY?=
 =?utf-8?B?dHpudE45WklOTnFQUGV2Wk9zUXAxcm9iNitsUUlFRDVWekpKOGpZTFg0NFNM?=
 =?utf-8?B?cGo2OGUyL3FZN1RMTEFpQUtqTHVYREYrR3N2bjBhYys0ZjBkZnZzVnBiWnJM?=
 =?utf-8?B?dHBmN3NEL0ljYzRlaVZNS2Q0czhvT2xSWkN1MUZ3MXdMU0FVS0xEVjNDMlBq?=
 =?utf-8?B?SWtYcW9iTWVOTzFCQWVLZVpVcW11ZFd3T0crenkwaDF0NXc4cENJaW44Wm5R?=
 =?utf-8?B?ZjlYanVIeFVUUDJmNmZiK3hOaFZzK2ErSkVMZHZZa3JPVlZTT3ZzRG93VmxD?=
 =?utf-8?B?dUtPdWtXY1l0d0RFY0ozRHFuRXBCcC84L09icmhOMUxWdmdXQjR3b3YwTkRa?=
 =?utf-8?B?d1ZZeXhsMHc1cEx2WUpndDM1ZmU0aW0yQXY2a21IdVZOWTRzQUtzWnZHMDVm?=
 =?utf-8?B?S1lpblFLcU94NVBQYnlvUzVjSFFNOWcrNjNmNDVVdlBpODJ6RnRKVE9JV01F?=
 =?utf-8?B?UURaL1hmNmtaamVxaVNQY25oTGRHejVMYWRPRnRSL3JycnZRNVhwZ1VQOHBR?=
 =?utf-8?B?UFZOUC85YkNrM1BZeFdIblFwLzRReE1DczJSWnYySHd2UDUyN3kvTEJ4dkVu?=
 =?utf-8?B?MzNUaDRnekpJWm5BNlh5VmVGak9ZSnpUa01TZThrSHdXa0Q1Mk80aTVWd255?=
 =?utf-8?B?TjkvK0lla0R4U2xLTGlubGZ6UkFXQmRVbW1IUVl0MU1YSFJLY1F2NjlSNlA5?=
 =?utf-8?B?Mm1qNDVSZDBsQXlBUzNodDhoeXR1OVBEL3ZoT1NYM1dCc3RRWndXTnV5SmdD?=
 =?utf-8?B?OTdwNWI1UDZudCtKSWloVm85cmdJUi9kZ3Z3R29Xb1pCSUNkejllYkdnb3do?=
 =?utf-8?B?RzFhOHR6SEhwdisrU2lNSGlwUXdXdU8zTEhCa2ROUzNwU1dzOE02T3dIZlNC?=
 =?utf-8?B?dVptd2hGQ3RpUy9Ea3ZWd2lyYldyRjAwbnhZV1RLR2tuOHZoa3dkbUlYSG9X?=
 =?utf-8?B?ZUxqVG1DNC9KUGdMZkZ2S2dQcDB3czNnRzY2dGxhZlJkNGszMmhWV0VVb2ta?=
 =?utf-8?B?Zm9Ia0xSdWhmZzM0SE4wYzRERjR1QVMzMHBBSHFMY2FmRmc2TGx6R1o5VWpZ?=
 =?utf-8?B?L0hnUHF6TWcxZVgvZWE2NkJBRUMvM2hqT0crbjNLc0VNdjAwZGRHdjk4cmx6?=
 =?utf-8?B?Sk41QXluWmovakMzVGNmNE5Zd2Z6YkNudkowNXMxaktDNmFwbTc1YTJLbklI?=
 =?utf-8?B?NXpGdi9xVEpRQytKbmY1SytyUkR2Znczek8rUmJQSkRRUDhWaXZFWjY1NW9k?=
 =?utf-8?B?amltZ0hkV1lVRUYyTnhVZ241Y3JzeGlCcGwxeXJtbUJ5Q1JvUGFwY3VjbG1O?=
 =?utf-8?B?c3lFNy8wZnk2WVQ2WWhLcTVvQTZFN25xUW1MZGs5YlZ6QzJQNnc0b0tBVE0r?=
 =?utf-8?B?YlhHd1kycE9ZZFhOWk05aEZNZ0JZUUpXa2ZMaWhSYUFld3A3MDRob1VXNGdZ?=
 =?utf-8?B?QnlhWXY0cGw3dFJ1QUhXQzJlb0V2Nk1aZWFVTncwZllEbTRKUDBCYU5hRU1D?=
 =?utf-8?B?NUllZ3ZUTS9IcHNXQkRJSE9UL2lUSC9DR1FPWFZYYVROZVY3Zm9LT0NBSGlT?=
 =?utf-8?B?OTR6Zm8wc25OcVc3a2I0RTR1NmtjRTRibnRPSlBTU2oreEhaSEIzSFZHNnhJ?=
 =?utf-8?B?YnpCbU1qMmg2N0hmTmdzLzdyVDFZeWY4amNnUWljMVU2bGoyWGUraWpFeDh4?=
 =?utf-8?B?Rk1zVnZCVDBsU2szL0Z5c01IOVpGVTdNajFqb0FPRTJqYlRSc3M1dDV0ZTlp?=
 =?utf-8?B?ZTBzdDBjVWVyRnMranFOaGlRSWNub2pET1hyQW1zRjMyNHlzbEN2UkZNeFJD?=
 =?utf-8?B?TXJwT291UlNNV0NQUWJrZzRUbEFsdXg4aVBJYW9LM2xkRHNVT29JWi8zd3cr?=
 =?utf-8?B?TDdQUU9mMjhnOFJoMHZVbWU1bmdMMmk1N2l6bTExbFQwQXNzM1Bad3dvcTlO?=
 =?utf-8?B?emxSSjh5ZFNVMHVFNGRwNWdEZ2dkY3J2MndqSUtHamlxL25SR2RBY2wyUThE?=
 =?utf-8?B?a1UxQXV2T3BmTFNMYk9mc2xMSmNNMlE5YTRlSzJpMFRacU1RSHlUQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88068432-2849-4a36-8001-08de4eced83e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:59:03.2280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9dDjZeolZf3wJsDLXwH6HpM9AG8CnEqQ5rxIPQhSeSYLorN66NDAIepkuKaEHMV0iFcQsUyop8IISIWDhRnIpnX3r/+uJYHcAlZy7PiPvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8209
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

On 1/8/26 4:47 PM, Quentin Schulz wrote:
> Hi Oliver,
> 
> On 12/19/25 4:51 PM, oliver Fendt wrote:
>> [You don't often get email from ofendt@googlemail.com. Learn why this 
>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi all,
>>
>> I recently did a license analysis of u-boot an I came across some
>> unclear license information in files. I do not know whether this is
>> the right place to put my points, nevertheless I want to share my
>> findings.
>> 1. the file https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Fdrivers%2Fmmc%2Fsdhci- 
>> cadence6.c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc65d5ed72ac94f3ad7b908de4ecd611c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639034841193276491%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=qKgOGalLMURaimcVrCtxVnwN0EEldwTGB1I15M7RdsU%3D&reserved=0
>> contains the following information SPDX-License-Identifier:
>> GPL-2.0-or-platform_driver which is not a valid license identifier, I
>> think GPL-2.0-or-later is meant here.
>>
> 
> +Cc @Kuan Lim Lee, @Alex Soo, @Wei Liang Lim who contributed the driver, 
> they should be able to answer what the intended license was (I assume 
> the same as you).
> 

Mails are bouncing.

+Cc @Hal Feng, @Minda Chen from the same company.

[...]

Cheers,
Quentin
