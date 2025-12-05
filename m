Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE6BD33981
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 15:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DC884209;
	Fri,  5 Dec 2025 16:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Arjp78VV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547FB84212; Fri,  5 Dec 2025 16:40:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C7F84047
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 16:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C947Xs37IZSXYD7tbNOBIUhE6sHs1YyB/E+O2Pw9J3KZUXUPRWYuNaBIIaJsd+k79gORczgfE2mjVWucTg2K7gbK8gfCscpSP7iwG48q481ym9Pb1pgBcn8FdZBEQTut31uqHO9/S62+9Ei6BpywnpjsSqKi5cjCQ93BdQNCxsi5thtNqxIfdNXjfSWbXw2G6rFc7RAHKecd8VRHI/LknVbCqhObYgEgRcvbuJjsKJ0GwJ26nlHz/3ovjG16OKqz0xHYUHOgvydSB3IRKvqeEcTYqW76O6prmKYHvEsj8T6JjFqskNJKkpJQKQ7ZfnOHs6/rO63n+smIzyLgcZEiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG5s/q/PSsTX481nBrTO7q2fP/ISa0D4fnlgy84qsio=;
 b=w7ZFO4AWccDHmqto2Fj94HvLpK3f8Xs/gnqOJFsShLeBJWMB4llUmuNkPJ98HmkyjffMPapZHdmul7sv8B4EFAl6p8VzA0NGuPYQOIeILbN8gQruGHHreZ1Mg1AtqgkSrIJoecIEsWmUP8YHXUMzl6l/lNml1O30eURvoHHCdVxS2YHfF9RUmy3Ij1Rg7lxd4iY9JbeCmxu6vziIi13S1sQ1/vbvZxd35dT0P4DYMD1o8fcKT5qnae7Sy6YlHIuDrBxqYpF9ZTqh2k1Mkm36NUgvVf6NIoG2QeqO5BoBTAwo0ygXLBYbp7jCDjV0WgnEA8GqNPP+EBILGVk2Xjj5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG5s/q/PSsTX481nBrTO7q2fP/ISa0D4fnlgy84qsio=;
 b=Arjp78VVBc9yR/MZQpn/q8j9cXhG/mC/XHxU1MMRZU1dI+ma99sUh317OWJxDF3T55mUCBnxORkq9qUhTYoKfWGCpz2PvNM5Aa/IQBIQuBSice3yPVI32JmttVU6HFssPZvEACG4MJqVZcu3jCIpXvpMDW2wbmPcVO0Z/jMBj3qVd/GUt44mwFwC9XNMr5oAJqpSjRkPqs7YcqjDTdKe6wAs7fIdR5etd3t9KYHr0EGeHo0WzKdF6Q/DMrzG+Cw79poEw2quJiMdHOsPLo4ZJIoV+TU9J8ZMX4FHYOL0HjDv5aEev5tAQ5GsYpXgaFGRYD79dNRn9bMETcRx7JShAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by VI2P195MB3006.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 15:40:44 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 15:40:44 +0000
Message-ID: <26dfb03f-ce98-447e-a931-ba9a34b2f8be@phytec.de>
Date: Fri, 5 Dec 2025 17:40:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 2/3] board: phytec: phycore-imx93: Set
 boot_targets dynamically
To: Primoz Fiser <primoz.fiser@norik.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
 <20251205111044.3195322-2-primoz.fiser@norik.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20251205111044.3195322-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0110.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::39) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|VI2P195MB3006:EE_
X-MS-Office365-Filtering-Correlation-Id: e9653449-a51b-4fd6-9691-08de3414a761
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alBzZ05JYmdGa2ZNUW13Ym04amtZZnZwbThXckh5ejJlbW9VQlN4TjZ6NEhZ?=
 =?utf-8?B?N1owSllZU3gweS9CdVFKNktnNHFsWDNHRjVQdWE4S3dqWHVIaTNMVUNhTWQy?=
 =?utf-8?B?UVJuNEtyZkdpT09WOXk5RFJxa1daZ2RoY0JTc25iRzFVT0lxeHNrcm5YUXVu?=
 =?utf-8?B?MmxERDJHbmNiaDFqdW00azkzSVJKOXJkL1JUdnVsRUtyQUE5OFpETVZ2LzJD?=
 =?utf-8?B?U24wSjlka2NXVkl2RTk4RHVGUkovbmE5czVrL0NKbGsrLzBpNTJkanhhaEx3?=
 =?utf-8?B?N3AvdDRFZk1OZUZLeERqdjZTaVhJdTlibzlOdU1lL1J6WDFrVVl4SlBpWFFS?=
 =?utf-8?B?RUJYK1ZNSkdqMkg3bVozSVh6SEorTTZYcHNqNThHdUFINFhQbmFGWFV6T1JJ?=
 =?utf-8?B?dFV5cUVWZVY0b0tXOEU5VmZOTGFqYzlUQTlaelI4THFObFBYd3E1R01FenNw?=
 =?utf-8?B?L09hVHd4cUUzSktJVzFsT0VKSVdUdEN3THZ4SVEySUlNaDRXam9iaWo4cGFk?=
 =?utf-8?B?U1c4c0RFOTdPc3hCOTd2SHNKN0lFOUhMYmVtZEVDSHZKdThtNmowYVEvV2hJ?=
 =?utf-8?B?NVh3ME5leW10STQzaWovcm1ObXVic0lyTnMwcGJPZHU4NTdDNURxeVRXZ1pH?=
 =?utf-8?B?d2tnVkQ3d3A1emt6VlovVFJ1a05IRnd4OHhXaytQbVZuR2E4cGtxcktNczMy?=
 =?utf-8?B?YWRScUV6ZkFoakFKYjRzSExDNDY0VHhCVmRRMjVBZjUzWkpURWQrWW5uc2Y1?=
 =?utf-8?B?T1MvYlBBdm9JdG1paEZScktYQlFMTzA4S253alcyZ09JV3ErUGpFK3ZaZkY2?=
 =?utf-8?B?cG90MzR3VElKNFVuaXYrUmNqdG11V0V1S3pjOHczakVYOHNDNS95TEY5Szd5?=
 =?utf-8?B?TzVDN0JEcnh0TnBOMnZQTm5TcEIxdVJWRnRERUJSd0xFa0NBYTdNTis5T0tW?=
 =?utf-8?B?KzZ2K3hOV2hRVi9JVWx6VHZqbnI3ZmE3OXFrbDdaZ2o3SUU5dkZORzYyQzBG?=
 =?utf-8?B?ZkI1ZnFLeEtTRGFQcWJyU3VLQmk5R0hLTGNHdm9OWkR6azBjS1RlaHlBOTY1?=
 =?utf-8?B?dmZpQnFzUS9zTi9XbE1wbjFpRlI4RVI1Y2IwdUs0U3BoS2RYUDM5bzFCQVU3?=
 =?utf-8?B?VWk0SER5Myt4NTVnMUVuN0svYTVwQk4xV05Oa0duNmp0NkltZFM2VnZrMGlm?=
 =?utf-8?B?KzhtQmN4TDlsT2RiZXdvaFdmaDJaUHo1ZHFKZWVETGxVakRPRnhVQ3NFOEtM?=
 =?utf-8?B?aWpsWmMyeEtFV0tnUTd2ZmFZdnRneExHcU9rUWdYQ2ZFcy8zNzZFUTV6MVd5?=
 =?utf-8?B?TVZaMlZxUzQzUG5IaHVDeGFIZjVVbURxdDJ4bEdCeVorVlI2OElqK0NIMGRZ?=
 =?utf-8?B?Q2U0V1FacCtmQkh5Y3F4MkRWRDM4RU8ycU5vNkluaVUwNllNNGh4NzNreHZE?=
 =?utf-8?B?NTFrT3NGd1VaWngvdi9WdWNTSGVGMWE4NUZ3UENvRG1hYWUyZnQ3ek5HV3hr?=
 =?utf-8?B?Z0pyQVR2T3RsMnVmRDVYTmVzRlJ0OHFPbTdkRTFJM1Bsakl0bjJtZytXMUp2?=
 =?utf-8?B?anJ0bW9UTU85S0xRMUpGWnJ3bXFqbVlNN3ErMCtFczBPZVU1Y2JWOFNkMndt?=
 =?utf-8?B?LzBudGlBcVpxdUwrZE1qUm82YmZ2ZlJRVWRJODJyNXVpT1JJZ3FjclBlZVNa?=
 =?utf-8?B?M3lJbW9sVXdlekk3YldiOTZUNUxGYnNiUEMwQ3dJemVXS2Vqbnd2RmRCR0VZ?=
 =?utf-8?B?VkVRMS9CWmVva3NTMXI1TmZ3cTF3dGhVTS9POVhTQ0Jrai9IMFExS2RkVWpl?=
 =?utf-8?B?aTRnU2grejR4a1I5SDZDUHRtMVlHeXVvUC8vUGVmZDlqb1dUSTQvRmpWU3Zl?=
 =?utf-8?B?aWVpc3JaZlNzVENMYUtkTzNzc09HSG9UTDZvL01INXdQUzRIbFlxLzk2ZEpu?=
 =?utf-8?B?T3hoL3M5WnFPdWNJazlvQ294RTVYdGhNMmJnaDRITlB4WlppTG9BajhmajlD?=
 =?utf-8?B?QXg4ZVZJOHlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJSM09xNUJjYW1OQUNwQ0ROUEhpblNGY3F0VTUzQXNmVnhWdHRtdHJENXY5?=
 =?utf-8?B?Yi91WDBLR2RMSUtHQXVhNzU1dDZWdmdXMFlrTS9wd1BVTlZzTnp1QlRnMHhM?=
 =?utf-8?B?dzlxVi9lUEdBSXpFSitUS2NvclBwRHpGYXIvTkpjTW9welNPbDZmRW11WURt?=
 =?utf-8?B?QkY2TzJJU1h1WTRoSmdyNnF2SlpBeDRpbWFBeVRJSlhOeEpLa1VYYzNheDc0?=
 =?utf-8?B?TGNlZjZEWWhJY3hqZVNoVFpkVndZSkUwdWxISWh4SSt1WXU5aFc4b3VHSFFY?=
 =?utf-8?B?VEtrejBuRGJvdjYzNStwUUVrMnRBV1ZhdzZ2K0p1aDY3RmZaZ2xDL1YydTNH?=
 =?utf-8?B?TTNPbkNldy92Z2NsRlYwZnp5cE9nVFlOLzBkMlJSNFAwWWg0d2pJRC9hV05F?=
 =?utf-8?B?OGVydEFBekNpWkt6eEc3MkQvVjZPRGZzK2RyYnpvazM4WGdzc0owQVRDV1B0?=
 =?utf-8?B?M1JOaEIvMW9kNDhrRjBoWTBpTFN2bTZIdTlUL296Wm9MVFZHUklzT2NGOE0r?=
 =?utf-8?B?M05FeTBNRHcvNUphYU4wRXU3d0hPekJsWnNEd2UxVGpSS0d2SXc2VmRXUUhW?=
 =?utf-8?B?MWJYU3E2c2xodFQyUmFzMGF6UFpVeWplbVNhUUx0M2ljUmlIMEhOaWtiMlRT?=
 =?utf-8?B?WEJIOGFUQ1BrM2Y1K3g2dUpFQWo2UUdXOFNFNUsxKzhpV2gzYmdNTkdWdUVx?=
 =?utf-8?B?UjMrSU5lRHBOck54eDNlanhCSTBsMC9sVWlYSENXbEM0RDJqVk5lNVZzMG1V?=
 =?utf-8?B?bUlRRndFWDROaTBUUk5EYmlrMW5JYUhEWVVKTDN1dGpRc29GdUhoVXVIQnlh?=
 =?utf-8?B?SGhhbU1rd0tNeTZTemJuTnp1SG1nMjE4VkJKWHRXcWtFb2xkMis4S0FENGJ4?=
 =?utf-8?B?VUIxbkIzbGsxT3RDTThvbzNIbnFUdzRiNmg3S202QjRtNG9HS0hvUDZWVVpR?=
 =?utf-8?B?N29mdS9sY3VUNmZQL1dENEdTSTRHVWF3bDBGRHRKRjdweEovV1JCVTZCd3o1?=
 =?utf-8?B?S1JGbjVEajlYVDlTMG95T0V2QjRvTWwwa2RRSG5MWTByQTFZYzQrK1lKSjFq?=
 =?utf-8?B?MWFKdnY0OGlKUExpV1FZU1lSREE5emU2M1BCeDIvR2JINGlIMTFmbUlFYkkw?=
 =?utf-8?B?Um5idWV0cDBIZ2lSRjFlc3JJMEcyd0VCb1ZqdjNuU0JJUmN2RjNoT2dMbmlU?=
 =?utf-8?B?M2tyT3Z2alR4dzJZUEVOU2RYdW1kdWUrTFErQmREMkxNc0Q5d0pLeFBjVFhy?=
 =?utf-8?B?Rit2a2lSREd3RldmSVBhOHJIQkJWVGdaaFRQcHNBTzQzSnNWTlJJNDZXNUVz?=
 =?utf-8?B?WS9KSXNKaXRtT3M4RldiTTZxcHY2N20vRGFqdWtHdjNIOTlTdDRBQm1FdG1m?=
 =?utf-8?B?RmcwUnR5ZUJaUTkwZ21mUUFuNTk2Q0pnZHpPdlNTUG9tb1VyV0hQMnlZd1R5?=
 =?utf-8?B?U1J3VlYzQU82M2xvazdwU1o4aTRHVS9PMDZyMEh4SzZSM3cxVHJ0ekZEL0lD?=
 =?utf-8?B?NTVVSDBHRlQwVzY4Mkt3OFFIelFweWM0YjlhbFlTVWdkdzdoSVNMakxLTFdW?=
 =?utf-8?B?L2NwRHNrb0xUdS9tNmNCdkp5M0NTNURxSjh6MW52NHAvU0JmaVFndjlHMkR5?=
 =?utf-8?B?Wk83eEhFZldYWjRpMC9FMFZHRHdqTXFodWZ4QytuWTVBRjA5NjZyL2lndWNj?=
 =?utf-8?B?Sy9MQUxrOTgzWW82dlVlS1FQWkFiaFNDSEw2a05ySkVRRlBXR0xqMGJ0anNW?=
 =?utf-8?B?ZkUrSGRmT3kyL0ZhYlljbDFZbGxUVFVHay82QkxZVkdFYVFXbXpLblJZR2ww?=
 =?utf-8?B?QzRZZnlHdXdiSmhkQWVielJNZnF1bThNY2EwWDYzWm5SMHZqSVFkbzQwNEJx?=
 =?utf-8?B?VmE3amtnUTFOVE1WOWxmUXIzK2xVbWlycERQY1dBMmova2tqZU9tUEZHSHdD?=
 =?utf-8?B?RE9RRTcvTExrMkttaWVPS1IrYkxzSU05TjM4cXIvVndLbXJnUmxyNStUb1Z0?=
 =?utf-8?B?VlNSdmhhc2VVNU5hUEN6UDB0THFWSi9NcDByWG5VUVZtR2w1VmV1cXZOcFkw?=
 =?utf-8?B?UEREdWk4MmxQNUdhLyt3aEFlSUFxaUJPcVFYSExRK2Y3eUgwd3JLcG9NMDd1?=
 =?utf-8?Q?soNnraF9v0FIFJNhcqfunMRMh?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e9653449-a51b-4fd6-9691-08de3414a761
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:40:44.6873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TMeksNzeDnxdYz97YF+6AVtihFoJkiuiLoZkNgc0rRfXH5tZm4zyNyB6v4cjEh0qaxz/NBxkxa+15Swr60GlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3006
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



On 12/5/25 1:10 PM, Primoz Fiser wrote:
> Set boot_targets environment variable dynamically, so that when booting
> from SD-card, boot binaries are also preferably fetched from the SD-card
> by default. If the user decides to set their own boot_targets, we should
> not overwrite them.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
> Changes in v2:
> - no changes
>                                                                                     
> Link to v1: https://lore.kernel.org/all/20251204080744.3868067-2-primoz.fiser@norik.com/
> 
>   board/phytec/phycore_imx93/phycore-imx93.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
> index c6a4e923b074..cfc6d91f20f2 100644
> --- a/board/phytec/phycore_imx93/phycore-imx93.c
> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
> @@ -38,6 +38,8 @@ int board_late_init(void)
>   	switch (get_boot_device()) {
>   	case SD2_BOOT:
>   		env_set_ulong("mmcdev", 1);
> +		if (!env_get("boot_targets"))
> +			env_set("boot_targets", "mmc1 mmc0 ethernet");

I guess you don't define boot_targets in your env so you don't need to 
check for default env here?

If so,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

>   		break;
>   	case MMC1_BOOT:
>   		env_set_ulong("mmcdev", 0);

