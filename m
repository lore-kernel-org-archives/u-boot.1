Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE7CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E845188DDC;
	Thu, 19 Sep 2024 04:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CEdiiWb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D4E88F6C; Thu, 19 Sep 2024 04:58:16 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C23188DB6
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vwizrwa+qMjzCGBqY96pQZeAjodGIWxw3QJbd4TopxMd/hqhBbG17ra02fKPQzwiyWmNb40e3/9xIZLIuDCvzYCSXR2cxDtIHGH9aAw8EfWPTt9FPmNREiBb0ucDQZGQ5twVCUFapD6uzzitD26mlz+81yCckapMjpigQ9BTsVrN/MS5PnFsiHBQmaECu7yvKMuMx7SHT5hD4cfrlEgJQAq3yR5s5qpT8DeMoAX9GBEE+6ghzUnnsKaWRbSpH4c2mcn9MZ0g3mCz0nEcvctW4ucPBw8or46bvOaUFGNsihcx3dyzx+qWfuIOSAu87+yEDgLeHxd1oKWFPQT8IMUZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmp0f0YfsKoYo/Uwk8z5HQYDeIMuU+6Kx/tCXg2ddNw=;
 b=xkqA5A+7A7PwfTifaC4ABeZ4v6yieEtMD3OA2ilW3ZTiyX9+ynqkl0v9rHZG4epdvrE1Su69VG3ZsCg2mdgGqk7m7vACv9UTinnPfkA7TAc9yiJpmV6g6ZPyKErwwaQPeLX350HJyHWGWPHhpgGtsnse+9z9KZLihEdLsUyLwUmWurJEjzHl7s5Cx/cNZ50yYRsU2AeQ99vO2lskdjDx98Yim5wnfgMcFvZpfSTCHjL7erFmgAqPqDNKBPGg6YB/LbtYe7KzytCsEA/lqj6LNFwM92I6gbTZEhenQ847ZCMI0kRkwX1Qaq1SjojeaIBNbEgK1PGdDIBMFgXcCw3IfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmp0f0YfsKoYo/Uwk8z5HQYDeIMuU+6Kx/tCXg2ddNw=;
 b=CEdiiWb7an4EJrdnCS2Cf7xOJ8Nl/ZCvELXOHv5R0+jRl5JJH9q2ML3MfwD8qF4Id2epc1nfwXtwKORZSRe/yPAP/tV+cMa6zwUAqsNywCOVpekTGT8dJgigIqeJVH7nKvMkJtpahom0mICMrmIuQnKhLICdn13rqHz/yMFWIdqgYUFmZPEGX5J4nCrFM5LaXmcHe6J7zZQAr4uc4zXpaqQewB4pTxaqsfh8fP7X0cZR45p3jRmEOJaJ/pq0RQfFVrlCWODuvmmGbn6Gsnk8+YrGnzTs/aL1OJQYf7JBImugQlrbO/ornPD56cY3rGxzj/Jf3vd9JzSVvoL1n8ag/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:22 +0800
Subject: [PATCH v3 04/21] imx9: soc: Print UID in big endian format for EL2GO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-4-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 103208f9-643f-449c-24b2-08dcd856e68d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnN2eDNFSVlnYjdvZWFicEp3WjRVd2twWUhGQ3FzMC9kajljVW9yYnhpUEth?=
 =?utf-8?B?d1FkM0prMGhua3FobGpRdmhvRDhYcXUzZVVDWXdtU0x4WlZJT3N6eENKWko0?=
 =?utf-8?B?MUd2RGdIYmlHLzJCQlJaUEhPSjhFMmdKTnR3WUY0ZzVtU29SeUQ3cEF0aExG?=
 =?utf-8?B?TXZNRTRVT0tVbG1XMkFMbm8zSDRSblArcWVteTcrVGlIY3pMdVdweWZMWlJm?=
 =?utf-8?B?ZHVYbFhHMnZ0QXovL3Q3NFdleUpTUkI2RVVaaXpQdXllZXdrcnZLOEEvclJq?=
 =?utf-8?B?dUlQUzRDeFNSbFk2OXBRdXNRODRPR2pVUWIxZm02OG9DZ24vNGxUUVlsalBu?=
 =?utf-8?B?WlBsK0pReDNwVDRFeU52cHdFZTFxbk80NnVHYUQ3dUNuaWpGVGZYUEZuMlQz?=
 =?utf-8?B?bGlJL2c2em42bWdlZEoxcWZpcG9ORzRaY0lJalo0dUp1QjlpYlRiNmhseG5w?=
 =?utf-8?B?SFF0VVBiV29sMTFVQnc4NFZrcVMvMWdQVGVMWllXY1BIbFFLaWFZMlA1Rkp2?=
 =?utf-8?B?ajk4OEZXL2JlUWVuWC9rNEJFT0JoOEw5Q3lsSEYrK1JIQTRLdE14MDdXRWM4?=
 =?utf-8?B?Vjhac2RUa2R4bmNQWHpuY1dpVFVEVG1pa1pPbjJ4TlNIK3czWXhwYVBKK3I4?=
 =?utf-8?B?d2QvVnZodkVZbXZrUk5YVFd4N1ZjdjQvdWIzZVRkSVU3RTJ4eWtiMm00QXVv?=
 =?utf-8?B?WnA2RFk5UlVITTZvd09mM0x2eWRiWmFwVzc2ZS9qU3A2ZnpreURnM01PZXA4?=
 =?utf-8?B?ZUhZNWk0dmd4T1c2dldZL3pzVS9zNDBkcVduM0FEdzBta3BYVldLYnNoRXlk?=
 =?utf-8?B?bWRlMjc1dFVDNUw5MDZoMWJsS28yRkM0Tko4KzVKenZKdDloZS9kZVlnSGsz?=
 =?utf-8?B?R25LRmJrbjF0WUJ1VjFsUjhSRS9ZaGJiRlIrM3UyVjBPRHJGSStNaWYyUHpq?=
 =?utf-8?B?N1JWQkp3WE1KUUVwTXVFcjlCZUNmLzRSVGZGTktNcFVqVU5Rc0JIbGlybEFt?=
 =?utf-8?B?aDl5QnRBNkpmVjNmOWZseUYrWXV5VFN3OGd2VkhLeXNUamZpWUhmbkZKc0lR?=
 =?utf-8?B?UmxtMm5jbWNvK1FVMnBkWkRTS0k3VkUwcjlRSXFRcFdYUDFSS00yK2NscnMr?=
 =?utf-8?B?UU1kRmxhU2JQZmwrd3BRMVZGaFFWU25ESXVQMG1MbTdsNTYxeHMzelVSYjd6?=
 =?utf-8?B?eFpDZko3RFFDWjQxYnNOS3JQdWtCMG5Sa0RBcmVxNzJKNU9sUHBZeGwzQ1h6?=
 =?utf-8?B?WXpMMVZZcnBnWnd6bFAwOVM2dTBvTFJteHRFaEtGRnRhUnVvZVE4cUx3N0dM?=
 =?utf-8?B?RGY3VUp3OUNyU2c0VU04TVRuQkdZNy9FRWxuYk12OUpEZmxXR0tkQWp3UHdn?=
 =?utf-8?B?QVlkTFRjTDNxYTlGdmRsdE1GdEpablVZRUVtVHVGUnJUZFpxdTNmbmlvcHlU?=
 =?utf-8?B?SG14bEc2TnFvakpFbzdJdmJvT2xhcVR0Zk1UVXhydE1GR0JhbVROK0Z0b3hl?=
 =?utf-8?B?Zk1tZUIxUXV2d2hnN1B5S0g4eFZOT3FiZ1BJeHRLWVRmZldhcVNoMkRZYjhi?=
 =?utf-8?B?VkVsVmQyS1hXc1B4R1V0TGRZSmczUEZMS1I5QWgvdTdhMWJVcXBKUktsVEk3?=
 =?utf-8?B?Wk5TS1VRcEE0SFpyaTRUZWduM0ZSWkloczkxRVlxSUJkMzZtR2l5YllJYlZj?=
 =?utf-8?B?TUNiaHhGNUI4d3BrdGRqWTRmSTVwbHhWUHRwOFJuL0NRQ2JLRHFTaFdtY096?=
 =?utf-8?B?c3B1UW1QbmJKTjZHWXNIbGFiRUhjNTFkMWZlTkJITVcrTERvbDBnZ1hIQ0do?=
 =?utf-8?B?L0JycXVRaUJOcXdWUVlPa1hrL1dtWmh5d20rWHRMZ1VON0xmMWlpN1ZJR0Rj?=
 =?utf-8?B?ajFmSzB5WllWbUx0Z3AzSTN6UElmanJrakxmUTg0MGJJemc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T250VGF6ZzhGdzB5QW10T0owMjdXWGVlVEJyZWMyVG9SSGVpTmFUT1psTUVh?=
 =?utf-8?B?Wis3RllKTVhUdG5JdWI1eGxCcGViQWJyN2F0M21rMlZRS0lkSHppMUhwWHVw?=
 =?utf-8?B?bTA0bXVvWkU2dXNlUGhqUEtIMElLT3Z4OFQzV3BOUHFFYWxrQ0ZJck9Gek1m?=
 =?utf-8?B?Y3Z0OHJaNDNoTHdNZHI0ZzdNWmFvSzNoeW5TekVRUHRCa0x3SkIyaGRvdHk4?=
 =?utf-8?B?dUpQcnRoQmd4eDJQSG5ncGVkeGRSYkFob2FhSkZKRHE3NHhwbVk1QmJjNnZS?=
 =?utf-8?B?N0NiUVRtczZMYnBhcngxdW53WmhxbEVSNlNVOWRHcjBWM2RkaEhDRjFYT1VK?=
 =?utf-8?B?NWNNQ0sxdEZTTndldE9jNjBDdkozbWxpdmNCNml5d2RwVjhTUXFkTHlzOEJ0?=
 =?utf-8?B?QnBSZVBMTlJ1Nk1iNHp4Q0U5SlhJY2JZNjRqd0hyakZpdWw4N2paeUNJbmNv?=
 =?utf-8?B?TGVEOVF6OC9LdlI3UFVLQWN4dUh3YnVPME9jeUlDbDgvdnQxUUhYNXlwMmZC?=
 =?utf-8?B?cGR5RGY5di9pZ0hKT082MngzMm5mYllHZWxDcjJoR3FxTEkwMVFHZnljaHZx?=
 =?utf-8?B?M2k0QXlTSFdYcE0wR1VKWnNBMFlVL0lQejh6QWlLTzJQSURhNGV2Q2dEbTRn?=
 =?utf-8?B?RXRZRUtwRFdGeURtMmVOdnE3NWVJRVRGYVBsVlIwbkQxNW5CV241UlBxSXBN?=
 =?utf-8?B?OGxBSWt3UVlDVmFKeGk5N3BEWnNydXVVVWpMbnpqUHlwOWY2MDkzYU9SYVBK?=
 =?utf-8?B?dXVHdlpQUkFrQzBER0c0emFlamZrZU14RmJQb1paMkJqend4V3p4ZkQrSjhq?=
 =?utf-8?B?TWtqN2ROblVLQURSS2hIRU5GZzJpRm9JNE1CV3hiTi9wOWFpaGhPOVUyblZT?=
 =?utf-8?B?ODRVdVNnRVp1R0xQdmpMOVArd0U1ZVJOdzFoK1JlN2gzT2wyMFhMM2RQUHFR?=
 =?utf-8?B?ZU5BTEY2NUptNHB2QlNzc3lLNEZubkFBVENJQVpWWWIyMjNhZnBDc1ZGQjJv?=
 =?utf-8?B?MFlNUTEwcEduUGRlMlpPclc4U0t4N0VOaHNhSVlpOWRnVEVqMXRSTUpVS2xH?=
 =?utf-8?B?aHpJRmF2MUVlQU9zNERFVmQrbUVuUk8xL0FPYnVhaUpVeVE1QUhzYTBsdWhw?=
 =?utf-8?B?S0g5T0xOSklVd3h4WnFQL1pNVWdIM0VnOUwzaFo4c1JVdjBFMFdOSGdvSnJs?=
 =?utf-8?B?em5HOFd0UVB3V0RRSVZ0bFU2dlcvTGUyTVNsUUxraVBRaEdqOVdFaHJNb3kw?=
 =?utf-8?B?R3k2WTQ4cStaZVVHdGRDdGlWOTZBVGt3QlFZYlE5ZERmUXdSd3NUazFtY2dS?=
 =?utf-8?B?a1ZMcDJBZW12N1NTTlRkTTUzazVQSktpdkdFRlBSU3R5OFNJNHUrK25pU0pi?=
 =?utf-8?B?NUxRRXcwYlRKdmRtSlpVL3FFVzNXNnRmVXR0UmVRSlU5QUVHY1owMit3OW9D?=
 =?utf-8?B?Rmw5YllveHRUdFpIY0s3cG56dDFPM1NzOHhmRVY3akNaeDJ3aVlyZ1orWCtq?=
 =?utf-8?B?NkhmMTFKb3l5SktNbjk3WW04VFpzcUF5emoybnRjSlJ4ajlmNkNOcjRMWisr?=
 =?utf-8?B?bmhrWGRSaXlTQUt0QVU4M0xkdGNUMEZScjM5TTI2UFZzQkxXSjR3N2w3aVZK?=
 =?utf-8?B?WHJ1eGdpZytjd2tRdm5QMHlnT0lGWjFSWnhaZWpXY0cxa0E2OUZKQlVIWHVq?=
 =?utf-8?B?VmxWTHBRUGU3a3o3NDBqckRBSG13RkdLb05WdnFlN3c0Ui82eTQwazFXUWdx?=
 =?utf-8?B?UkE1QjVTTWE5cHFNT0IzcTduTEUwOTNrTUNtb0YrL2ppQ21Cd29jUHBPaEdZ?=
 =?utf-8?B?S3RQUUtEMkRXRXBWQ2JEYU84UHlSY1UxSDJJbVV1b3dIdU1nQXdKSC9LSHZk?=
 =?utf-8?B?ZVo2TVRmd0c1OC9BYjhaTzZPVzdVVEZUUWorTllOc0wrZXBxaGgyNkwvRVUz?=
 =?utf-8?B?RHVWOWtVODNib05rWitjMkpmc3cxU0IvVHYwRTV6TFY0UU1TZlhMcVh3U0Zi?=
 =?utf-8?B?YWJqUVowTnZPVjFQajhaZi9yWG1TUlhHOERrN0hGeGtGWHZGWWFvVTF3Rk1R?=
 =?utf-8?B?ZGJVTkUralU0a3FScExmSFhNQkwvOHJGZkwyeWNXeURZMjdCQTJJd0pORnQ5?=
 =?utf-8?Q?BGd8pIj2KhqbEvvE7p/wjCHIv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103208f9-643f-449c-24b2-08dcd856e68d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:12.7533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIWl9ycDa4z/aGl3jXmDKxSwhUsz4mUM2PkC6fdRVASTmI2GewpZ4A9QH3X58xuhJEZBsXnJ/6Vrs5gwl3MwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Ye Li <ye.li@nxp.com>

Print UID in big endian format and as one buffer of bytes, so customer
can directly use it for EdgeLock 2GO.

Before:
UID: 0xf6c8ae93 0x0f46b326 0x10d61eb3 0x0583c2d2

Become:
UID: 93aec8f626b3460fb31ed610d2c28305

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 6dcf0c4612d..bdc569b4ae4 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -560,8 +560,9 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 #if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
 void get_board_serial(struct tag_serialnr *serialnr)
 {
-	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
-	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
+	printf("UID: %08x%08x%08x%08x\n", __be32_to_cpu(gd->arch.uid[0]),
+	       __be32_to_cpu(gd->arch.uid[1]), __be32_to_cpu(gd->arch.uid[2]),
+	       __be32_to_cpu(gd->arch.uid[3]));
 
 	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
 	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);

-- 
2.35.3

