Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D758C7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A3782D5E;
	Mon, 23 Jun 2025 07:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TKmfe3KO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF0882E20; Mon, 23 Jun 2025 07:52:30 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AA582D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvWWD4AkPD0b7Vj7cyQfhdGV2WPknMGOu/Uz9i/2+zUIhBZ7ZRI1r0vmZHqUFiYVCnjXsj5fzc1nOTRlPmhAMQFwcXDkkgirHVPA5dMlcBLfZCSdJ5sLhIr9H4PTGgKATe42Eqp7RPkUwybofOteru76C12iuBybZGozsM1XQmfzP8G0AIEr2sGggerm8/MBGJDG3f+QWFsznl+rbXfulRaPV0JjPkKfqG/UjD9+EZ+GPtC6afhw5Fz26sAKfekFlkxGvOcYXYuoxoxgNyCGJzgfTKY2aFRFmT+HUhcXi6xRcmdSmukEnBsvdzolJ9S7sHZ1rwvAjsxyWZF82Jo6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1Dopci5v3GxEb4tM9+8EX29QAfxHTdlsjo/G+hXS3g=;
 b=qK8MWgptEBHtmXIbQ8fxjIPpryXFG7Ci7kxufXiSJat66nvhMtDoT47k23Qto0Ugwis0mkkz14YuEEOxPNJFyDX/f9CCCjzRczdPKPD1vjpKKaRVm0KXko1M0kENi2u+DrfqUQ5Ccxs/7m10Sj1AgHtqq1nhuVkHPlwkkXShtCzIYTbCzYKh9vnfECCSTDnoB0MxpCJ2wpKJiOYZXuKQ+xp1pKpWAb1+4KzAjlsJrtMI9QnG/Ts7uZNdROfEjSakc51EG2qdBmTjw4M+kD+InKKEsyIWb2IOttOzCWn0zJrAx6LB/8EAa7TXL4MML2oXBQfJ1AvC5KxE69vUuShgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1Dopci5v3GxEb4tM9+8EX29QAfxHTdlsjo/G+hXS3g=;
 b=TKmfe3KOlJwrMeErs3yfCcb31Av6e3jY1JU549FDH5wLXyDl4ov7PHSElvUpTdumQuSpOYhfYfVfwrUfDSZYsWvC25yoPngRx5vYmGiSGJhT062iLFMSbwJrGsg4v2Sey+GJ6GSbxQsAgftWH/o5CLPuDUZ/mHpx0qVfuFyDpvtQNqLNI3uqhhffbyXJDZUeYgtLQiiNGJu3QEQKKGjFTvcAu86f5VzhZcXjXhXIuwfV10R31qgJVpPLA+0+pjsSSI/mRQeSZXMbomWMM7uGodWjYJ0zgrZJzez4SJfxkUtg72SbthgwpJwZTBv7XGoX0LsP+iUmyW1+cP8AO6Akgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 23 Jun 2025 15:02:32 +0800
Subject: [PATCH v2 4/5] imx93: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-sr-v2-4-e97fc53f0f8d@nxp.com>
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf8d3f8-5c41-45a6-72a5-08ddb21a223c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3J0SzduWTlRdmlvZ3VEeUxDWjBad2E1T1hhbE5yUktpclFZbUFhLzZwc3FK?=
 =?utf-8?B?WEtXVXFRTHVvK2pMNGdKS3VvNXJoaCtGV3p3d09GR0VDUHllcFQybU5MMU53?=
 =?utf-8?B?RHpoRGFoTzBNbk0zcmxRRjVtMEZGTUtvUUhpV3JQUzljQ3dOdVBOU3gxUjgy?=
 =?utf-8?B?YnNDYlgxajZiUDhVMmUyaDFuQzZ0L1B5RW4zejZ5c3p3ZkRjOWVvcHR3Y1Ja?=
 =?utf-8?B?c1VxWllUNWI2bENMcUtvMllaV0dFcVhOWTlsRys5dFZvQ0FJNkh4V29GaERt?=
 =?utf-8?B?SVdxb2F2c1MydXFxMVRtbmM2RmM2UUszRzQyUDN2NXVtMkxIa2FYVzNtVEhE?=
 =?utf-8?B?NEVkNWtlbVUvZXpta0JPM1phU3VTTXZ6d0pRd1BrbVhPYVZvQ21KTU5lUHdI?=
 =?utf-8?B?SDhnWFVDd0E0R0lvUmVldVJGTWxjY3EzZUYvY0FpQ0t1dkw2ZHljQ2dOcnNS?=
 =?utf-8?B?OFdrQzl3dzZ4NnNoemk2ZFozblFkK2lNNi9FVUQ0bXdBYnBYTmZpWndrcjk2?=
 =?utf-8?B?VHhnVlVCbEFsVGNrNW5WWGJmdTlZRXJwSkptTmNZdzdpUGIxUjNwK3Zjb01Y?=
 =?utf-8?B?NjdhbksvL0huWWs4VkFNSEllankvdEx1ekxKL3JRK2FQdzFyU1Y5NHIvUFA5?=
 =?utf-8?B?cUNaeTZjOWdmcFd6ZzBqMitkNnhKRlJrVUwrUGhjOVhvY3FUejMxYzlLRFZs?=
 =?utf-8?B?K2hJVUxJakR1QlBnTnpwL080bWdoaHRIaFZEcjIzTUtYbDl1c1V6OFFTa3F1?=
 =?utf-8?B?Nm4xUG5TaDhYb1FMUjJoZG1OYU1jendRQU9yd3JTT3RQNVdYZ3hGK3RBbzIr?=
 =?utf-8?B?UmI4T3RQV2ZJMUJCeWZlcDgxMEFVaTROWFltUXZ1bE96a3EyTUFKL0dvdUx6?=
 =?utf-8?B?SEVIQmR0dmtyTUpOOERycVptVlp4bGJwRjdWcWh1NEdvelkxYURXTFFqUjhp?=
 =?utf-8?B?amVNUzRzNUhtZFJ3cmdTZnB6dDV5WlIzUXVhSk9QNkZrOFBQbC94ZVJreG05?=
 =?utf-8?B?UHIxVDdXcmNkekNJTjZhN1RxZ2xoWjBOV09SSy9hUWpDWjk0THk0cVdTelln?=
 =?utf-8?B?N1BMTmtjRVJUR1g1VGswdVdxdmQzbDlYWFBHRHY4VkJwWS9VYk5pQTMxcVdM?=
 =?utf-8?B?d3BnUHQvQ3ltcUZoalhBSUtYY0Z6bnJrU3ROWW51a09PWkwvSHQ3MUJzMU1m?=
 =?utf-8?B?VytpZldRR2dVcFlSL1crejhXRy9YQXl5eCtKZG1sWVFsSUtLd3NraCttTEdK?=
 =?utf-8?B?YW1WRDNpbzVQUStwVkE3WXowbGZDWXUyRDFNR3RuQlRzYThsR1VBdlQvYTlI?=
 =?utf-8?B?bXZKZ1BCU3RNRGY4T3RCZE1INEtlZjdFdHdGbktHMUpmd3RwY1V2NzFid1A1?=
 =?utf-8?B?Vk9pT2hXbGpBeVJvdG4vdEZlejVPSjlmcjVoQ01VVWdqaTYzRW5IWi9hNjJu?=
 =?utf-8?B?NEszQ2Y5SngybVJJdE5VcWFiTHJMVEQxcVBqcFQvL2hKMjNKYVNFVmdWRlV3?=
 =?utf-8?B?TjUzL3htQlNacURvZzZ5aUdrb2xiQlhNbm45a3NHNk9qQzVzZjlaK3dOcmJH?=
 =?utf-8?B?eE5JbzhzQXY4QmdKNnp2akt4cTJHQm1ybEVORk90OXdpRjVsYnJkUFJSNjND?=
 =?utf-8?B?c3V5N3JBRHJNeHM5dGhvRkk3OG1tTUlVSmk0d3lKVlBaNlhicWhQOWdjTGhU?=
 =?utf-8?B?Vkp6V0R6M2N5enphakxtYzlhMzZhdE85d25hN3JPNXZXSkpJT1ZLL1IzZ2VG?=
 =?utf-8?B?ZmVTWHFSK08wamZDYW1ZWmNQdXp5bmljTlczc0QxOG5SdkZlWGdYeG41OWJx?=
 =?utf-8?B?c0xEVFBNVUk4aUpRd2FJU0lBcE5SOWRKWnZDVW1qUGZNUFhUMUV0R2hUY3FS?=
 =?utf-8?B?UFhxMDdPa3pYeGJ4UVpwMGlPL3BXRkVvUjNGcWpncHdwTzdKR3M1K0Vsc3RZ?=
 =?utf-8?B?c24wWlZHeENqTVczK0lUa0puMWtQZ0xXRTNUSklzckpqak1RUUpRemRMbHBu?=
 =?utf-8?B?eTlCWHdIRG9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdLZndpZXZnWjVGTE5wZU9zdFpjWkJVMlhWbVE3ajJZaHZGTG1udkFJYThV?=
 =?utf-8?B?QWphUFkvVVU0ajFCMmpFelBJNTROZW43M0llZjRONzI5dC9seFkvRHhhUSsy?=
 =?utf-8?B?SGNtM2Vsb0ZNRndmZ0JWd0JBRFJma1VOVHJBb3RHeWZDSm04V3htNnZtQU51?=
 =?utf-8?B?b3ZDU3FkQThTc3NDZ2Q4NlZIODcrWnp0WGlZTDhzbEdoMnNnU2xHU2ZlalM1?=
 =?utf-8?B?aGhDbW0yUnppOGgxWGZwN0c5cDFxOGNuWXhvNjUxUk1naXNMMDhLUVBVekdP?=
 =?utf-8?B?U1pSdWJSMVZhSG40R2lZbEE2QVVTWXFPZFpLN042S2dVTytwZUZZdUpLcEJE?=
 =?utf-8?B?VWdkek5WSXhzbnFXNXREQTZTUWVDRnd1L1FlSGFwNmNyK0hoQjlqbUlCMFJj?=
 =?utf-8?B?WlhEbklrcUM4T1JQZFloRzQwUi8zeHlSWkhhYWMwbEpHcUxzMnZjQjhqaytw?=
 =?utf-8?B?N0hBWkNkeEx1NG52SC95UXMrRTZia1hFeFpqekpHRmFwRGVjUHZYZ0s3YTBa?=
 =?utf-8?B?bnpFb2h5dktQWGtucDRBd2dBSDZWRVVEVXAzQ0pZVlJQdkw3b1dabm1ZV1hE?=
 =?utf-8?B?aGRsamJxdUlYSmYrNm10eHZvMnpzc1FyR2p5bisvTENKZ0NJbXU4cmNia3lG?=
 =?utf-8?B?WHJ6aUFpbjV5QnNtQlk4WkVPTDRnRHVsMG45RlFOSGZnQzlsVzErdzFYaEtV?=
 =?utf-8?B?d2ljd0F2VmdLemNNTG9JeWI4QzY0bnhRRXNxbFo4a0FqMEVJWTVNOHB1QTE5?=
 =?utf-8?B?ZXVyRVljd3NFa25MMncrcXJqenJ3cnZheFBOblZmemFsMU9lbmY4b2g1dDlU?=
 =?utf-8?B?K2c2eEJRMXlsTUxwV1FKT1g2aDN1dysrT0E3K1BLQmZCTlByYmoxdVpZT3ow?=
 =?utf-8?B?RENBWTU1c2hzbnFKTnR0QU5ZQ281TnM5eHBLbmV3OXZ3YTBpNVRFdkwxMDZH?=
 =?utf-8?B?b1NjUkpQL2JhSXRab0dBTnZISkxmakdPeG44YUNIT3V4cGJvb2pIYkwzR0I0?=
 =?utf-8?B?VlJTMWZIYmx1bGtuZVFGUnAwZithOTk2ZFVzZXpjRXZYSW1EeVNQZ0Nva2Fv?=
 =?utf-8?B?U1ZBM0NibjlTSE1GM0gvYUFuMDJCNm5wSFZuTTZEWWtEeHE4TjZzSkxlVDZH?=
 =?utf-8?B?amQ3YlBRaThLeWkzMDVZWUlHRU9RQ2hlR3Nnejd4UkhEclVsYklLdWJVTnJW?=
 =?utf-8?B?Y3d5Z1R0OXVwVW5xS3R0OHhsNzdtQ1JsRE5DTXNnRzlBTE4wSVVuVU42ZFFX?=
 =?utf-8?B?RW9Nd1BBSEhyaGY1OGVQQUgrazU2UExuaDlsdFhPanFXcHZlbEJQaUdaRyth?=
 =?utf-8?B?RlU0SUM2aUdjL3hjRGJaSlRWQVlkL2o2YUMzUjlmU3FtSkdNeWkzSjMrMFhB?=
 =?utf-8?B?TWpzVzI0UHkzam9NdkZlSWlqNDhhbXZvVWxCODlaZ1pWUXBGdEl4ZUtQb0xn?=
 =?utf-8?B?d2ljWmxjRnlmRUdHVERkdXZhbTk1TGlOT3d1N2lXb05ZeFVMcmFCRmdYSnlp?=
 =?utf-8?B?K1RxZStzMkppRFpNaXRDTE94WFJib3dXbGVOMG5CaXZqUkRobFRBdk4rUFBG?=
 =?utf-8?B?YVJlN0N5Ym1oKzJTMEdnU0lGdmNCcDRsU0tiU0toamQ4MklIM2xwdFNKeS9V?=
 =?utf-8?B?RldTYkFCeUR5cXN1YmEyK2FzWWl6V0RQdHN1NTRWcUV4ampjVk5UdXVpSFIr?=
 =?utf-8?B?NEhWQnZyNDA5Q0o4bDVkdG5CbFpSa2tIVW9lb3Bqb1lUYlliN0lNdkVnOWk3?=
 =?utf-8?B?T05NRmRJNkJCQmJJdXR0Z2lCTDkxa0dKb0NpVkF1UDBJUnk1U2V0dzVqS0xR?=
 =?utf-8?B?dWJFYzFleUx6WTdBSUF0SmJHQjRleDR1UVpsY1VtaXlEakUySVNTYjZhZEVL?=
 =?utf-8?B?MDVYSDBXcC8vSjR2UUM1QURJakprS2FsYTRBVXF1WWxVVVp3S2cxRVRrK3Fj?=
 =?utf-8?B?UDdQNW9mNFRkcVF0dUEwSlFtc3VRR0Q5T3hRS1ZxQ0FQVlpuTERLcmxGT0F1?=
 =?utf-8?B?UW8vcGhmS0RpbUZRZ3lpUkorV3piSjAwK0pYaHAvSldxN05TOGRLT011UXpm?=
 =?utf-8?B?Ry94R1lZamlCK2VVdkVVcjJ1dVRoWWtqdlVsd3pNRnVRWVp3Rmc4cGRuNXRk?=
 =?utf-8?Q?TyHsjLGcpWr3jM5ZJ0QNtIaAB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf8d3f8-5c41-45a6-72a5-08ddb21a223c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:27.0584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1VbHFZAtQ01XMyakRzthoW7R+z9N+GilXDfooiCgPwpEwW43WvTiQMTm3nekLgwdPebO9NLi7voO0KsoWW4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

Capsule update is EFI based firmware update which is widely
used in various OS distributions. This feature is required
by ARM System-Ready compliance test. So
 - Define image array and GUID
 - Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 21 +++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig     | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index c9171df330e2ffe519807b5f04ec2b7bdadf84f9..d84d56be5e1f863d50cb1a832040acf009f011ff 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -4,6 +4,7 @@
  */
 
 #include <env.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -28,6 +29,26 @@ static iomux_v3_cfg_t const uart_pads[] = {
 	MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
+		 0x2a, 0x44, 0x8e, 0xda, 0x6f, 0x21)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX93-11X11-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_early_init_f(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 16596a89d60930a0bd906a955d218fa1b096513a..98f6bc2390ca1c42caf6af8b843d3dc94dc25856 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -26,6 +26,12 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
@@ -51,6 +57,7 @@ CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
@@ -60,9 +67,11 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
@@ -89,10 +98,12 @@ CONFIG_ADC=y
 CONFIG_ADC_IMX93=y
 CONFIG_SPL_CLK_IMX93=y
 CONFIG_CLK_IMX93=y
+CONFIG_DFU_MMC=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -122,9 +133,12 @@ CONFIG_FSL_LPUART=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
+CONFIG_SHA384=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
 CONFIG_UTHREAD=y

-- 
2.35.3

