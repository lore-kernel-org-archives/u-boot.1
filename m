Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105E0CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D64888C6D;
	Fri, 11 Oct 2024 12:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uv7AAzwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F1088B6D; Fri, 11 Oct 2024 12:11:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DAC8929D
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8SlGtLrN+TiDTu7hj2qh/H5jnDhTfrYHcKPFuQPnlRqFaM9mIkJw+PHMnV05za1P8nXBDBnPYu0khdpCOvPU1zW79+5jcq4G8FswU4LO6vGUMePHmPVJHE38vcIzIPxoEEFlg7J39BmbyLwuDfgd9H8RRQ1KSApd+2EB46eX1zK6dK/GOZRYKJCwhcetaEbgGYeo96YZo2DypgQwi4w69Wt2Y+fgKPLQsnI/4QoXEjCgWakwcHsQFQXYiISSDTeXm+Yn7V3HVhNbxUzwcv4iR/vEClRT67++6Zn93usMRLwEsHHP4R/cDPlDnVfcTh2q2kZYxuZlBcvajNXxbeGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9yoGef6M73yS67zffwJX+vnyXW4UWM9kqzfcklYtws=;
 b=Iwi4LlI8VedOe3tUlTONWg4/c8vxaTYMhUVIB4YbDgXd9lrUidup7daOKTxdISSaLfl03F+7ITuT4gdZlU7IoEkycoDrswSIeX7mpDuyDd/8ytSJjL7NAHb7SJ9OW3AshK8VevKbiuMfJLCx55/Tq1q9nrcR3Y2z/OTQt/Dz5InPSR3DjWCtiMliqvqkqkO/FjxmSaATsateNO1BXvPfaVqQGummiXee/IfFPFTS3fV3ln6O/38fawFifAvTLAEbP5NPMAiO4QVUFIPHNKhxD5laigoKT4p5kyB3+xExrdKk9c/eFGSo79OAINkp1q2fFWwG15ItuZtGJgjYhlYQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9yoGef6M73yS67zffwJX+vnyXW4UWM9kqzfcklYtws=;
 b=uv7AAzwO6Lo7WDguXZoK61u4JO4zfpqDLNxKf9OPK2ZUHFdrH4pfnUS+vlZq4h0jQi8napXF8vuPyl5Ep+HtJ+RmMj/0jqjfsL+OLEb/+gnWeGpUCUjK1cnmhFf4Xj/1IkKhNcd97/Ze1Ch36HtGpYneaIwR/cI2STLgQ2Bvu1HcuX6FNzg38C3ymwL9c8RpsRs+D3lGjk6EuBlog/MTAdgsFmiXCFnhwv/ISGKKV2QqW4VkmAftQSG+eLD5va/a4BvO0Gk9/mtVhbFDREh0TPeuoiKe5nGS4w5tv/vIEhy4weBdggdBPsjkmI8/JtExIhBf2VZDbPYoDUWGR4wliA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7397.eurprd04.prod.outlook.com (2603:10a6:10:1a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 09:54:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 09:54:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	gilles.talis@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Date: Fri, 11 Oct 2024 18:58:27 +0800
Message-Id: <20241011105827.7729-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: b9efede0-913a-4ca5-cfea-08dce9dab7ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3plbVZ6VUo0cEcvcjB5REd3TmxSaWQycVdrdGV2MmpQZ3EzR3o1VElGZUhT?=
 =?utf-8?B?dGlQSlEySkhqcU0yYVVmTkgzUnNzSXRkVlVpMlJ2OFhTaXh5blNsY0x0KzRq?=
 =?utf-8?B?ak5YcGRIb2JiTHNIOHZQR2RKMUYvUjVZb21uaUJmRTMvcHlzTXlSNnQxYjVW?=
 =?utf-8?B?TXMrMlY1WTdIUzE1Yyt4ZElGV0lDODRMTStnZXh1NWpYcExucHRQUXU2eGVR?=
 =?utf-8?B?UHZLVE9PK2pFZ0lIdHQ1YzJtK0JsaDErSzF2RVI3YjNRQkpvVXpJTU8yeXJn?=
 =?utf-8?B?ckovSlNFcmpieDArY005MjNVUmpqazk1SmJSR05SU1c2VmZyK0E0M1dvREpi?=
 =?utf-8?B?QjhlNnpIYzYxTHN4anIzN1FHcnFhM2JuY0orYWhqZytHYzdzeWFqdXhtNFVl?=
 =?utf-8?B?c2MwQ1pRb2htVVA5VWpRQmx3dlJMQ0JXdGhRU0pOMFlacndMMFk2dEFIVHk4?=
 =?utf-8?B?YTE5ZStIN2Z0ZEhJcS95c3lHQVdZSmQ4YlhXNlhWaVJNN1l5OUw2bUhWWmVr?=
 =?utf-8?B?WWhlcWc3OXRqVmd6REYwUjFBSjBBRkVTRDNOdmNsQzYwMmJXR2xxVUtJcUxp?=
 =?utf-8?B?RXRSUlNWQ0o3RDlRQW1xdDhmeDJPc0lMOWIyNnFqRzBwRUM5UnRzYUQ1MjJ0?=
 =?utf-8?B?YzZaMlNVWU9sREpteDh3YmRMdVF2cVhNelcyVWpLekdMVklXVGxHNVJxWlpP?=
 =?utf-8?B?ckZobENFYWQrYUV4dkN6ZkttTU9XTk5QZXlXVkg1UUJRK0JIY0pJNmF6U3Vx?=
 =?utf-8?B?RWJ6ZFZBOXRaSW1VeHdnbVFVUUczelJNdFBtSmJ1RWFrbG5rdHF1d2M3TUVS?=
 =?utf-8?B?YjBCV3dreHByTGRMbXdCcFpJZFExTXUvNFNraGNrelBpcGNsMVV6cWY4US84?=
 =?utf-8?B?cXgybnc1bE80VWIxT1MrUVNiUFpOUGE1M1JvSjJoLzRNY1NiWEN5eVpvUXp5?=
 =?utf-8?B?aG02WGpvSTRCN25SYXcvQWNKUnlGV3B0STRqZEJPS2txc2VyY1ZQNm13WFdR?=
 =?utf-8?B?ZEZyU0o4SUVwN3k4S3ZkakM5MlJuSWM5RnpRSkFsSUpNZ1NDYjRlK052cDVU?=
 =?utf-8?B?aklqejV3Z3EvTUloSjdrQVpLbVVXQ3RyWG1JVnVnaHRjTjdXbHV2cDdYdHEw?=
 =?utf-8?B?MFBZc3FBUXpvYTJFMjNuSmxVcXQ4NC9NVCtGeFozYkVQdU9uTGEyOXE0bnJG?=
 =?utf-8?B?MDU3S1d0d3RjMjUyblVVSS9PNG1POTg0a0pqL2FYUERlZHlaTVFYeUgrd1VZ?=
 =?utf-8?B?MWNFa1NSeDBvbWQ5ZzA1d2Zjc3c0VHZ4TXFpWW1pb3kvalcwaXlWMU1tc2tH?=
 =?utf-8?B?TTRWNlcvekNYOWhEWUFTYUdPV0lEQjhUQ096blc4MktKU2tiMllza2pMb3hJ?=
 =?utf-8?B?RS9wdE9NYzR5RkNseUhlbTZucUdoY3hDMnVic3lmWEFVZ1FQREE4ZFQ4R1Ew?=
 =?utf-8?B?RDV6RVk5UldwYytZWmpsUmFORnJiS1pQVURNc0NWa1FsVWdHcUE3bjVhNzFn?=
 =?utf-8?B?djc3ZHFDNkt2Rm1wOGhUeWQxaEpwQnpsbkNlK0ppODkzT3A0RmZGejNPWTFC?=
 =?utf-8?B?ZWdWQ0VIWUpxUXhUQis3WXdETzczMFQwdnBPNVpQT2lRTURTOXh5YnFScHJ3?=
 =?utf-8?B?MGVid3BzdlBRaGw4V3NjWFQvRWRXeVN2d1BQVEZxWERRSjhBV0ttYlhnaVgx?=
 =?utf-8?B?T3ppU2hmUXN5YnRRWU5TVEptVm8rZnRpSzlpaENKdkdhVzM1YXZCemtEay8x?=
 =?utf-8?B?U2VCMzB3dVNrSkVlK09wWXpRUTBxZW1PZGNVYXRhbHRONGZUbmZrVWxaWGtW?=
 =?utf-8?B?czNRWlcvRnVNcUM1V0ZjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5GR3kySG1nNUF0b3hCOTJ4UmZzN001YjBHUWpoL3VuZHQ5NzJRcmUydUxE?=
 =?utf-8?B?Z2d0c2ZRc0xzcE9LaHlVUGw2Zk1WeUdIZm85VndvTDFIb1ZsMGN6cHFJNmta?=
 =?utf-8?B?c0h4bHNWREtVYmVmY3JJMDkvYkdEVlRocnhKN1phdFlJNWZyOC9hdjJWcWhF?=
 =?utf-8?B?NGt6ZFRRcytFOUcwVUVzYUlrOXA3NENXTGtkNnRCQVExek5VZWpxYi85MVVm?=
 =?utf-8?B?L21lZTR2L29jWnloSnUvYkFnak4vYzBCUGthTGpwc21FbWtENkVsc1ZkL3BD?=
 =?utf-8?B?MVcxSzBGWlFOKzdWR1FMUmZENWdjL3MzYnhiVlMyakJSakduengyNGdGODdT?=
 =?utf-8?B?NUtQQTl1aSsyd2E4dzNVV01UV2wrS2Y4RUhxVU02OU1TT1pJWXM2OURQSkdk?=
 =?utf-8?B?VWJzTGQ0ajRjZnJ0RHljK29uVks2RVZFeXczYlplalNBQzNMQndXUmtaTENR?=
 =?utf-8?B?S05MK3dPSWhxL29oYmV2RjdQUUpMZ2thV1JDc0pxTXZtTjltV21aalVjUS9u?=
 =?utf-8?B?VlJ2cWx0cy9zOWN2L2FuME9EU1dOKzFuT1FYM2VVZzVoR2VWdWgwQUZjbTlW?=
 =?utf-8?B?R1ovWEQrU3lvMEg1RDVEZTBzdUlMUkNBY2N4UkZRSzFnOXUwSHQyZGVkNjdQ?=
 =?utf-8?B?ejBQYjZLUkpUb05KK3B5QThDeWJVaUw1NHdockI4dnRjYTYyZW5wL1dRV2du?=
 =?utf-8?B?a1YyRVJkV0kvTDluby82S1ZJL0hmN1R2RXFVVFl1dC9iNWI1QzZ1MjNpVmZB?=
 =?utf-8?B?bnpGZFA2UCtBcGt5SWNTNW0vRklDN3R6R2lyQ3g3SUtGaFN3MW82ZzZRZDVB?=
 =?utf-8?B?T1V0S2pNbEVWWnZTUkVWZGFDdVBCTytaaE1lQnk3emIzSEF0dE5CdmR4NFZQ?=
 =?utf-8?B?Sm8veFZHL3dsRExUM2VpWHNyNysrOEV2KzZSS0JFQ1JBSHduVm5YNi9UcW13?=
 =?utf-8?B?QUdHUVhoVVo3SnE3MzEwQjNGUkd0ZUhqZUMvdlUzMVp3WmVESXprVXJ0UjNz?=
 =?utf-8?B?MFdKeHNrWDc0bFRIRjVyemd1VDh0MExOaUgyVC9ObC9ZZzhnWWxqUFhQNUpG?=
 =?utf-8?B?MEZqQVAxMTQzM2xqR05rMzhPSkVQeUxsVEtoemFQWFRaS0pNOW1BT1dUTjN0?=
 =?utf-8?B?V0plQ3pCZWt0ZVlEcEFMU3FDNk5ySnk2M1dkL0szd2QvQy9GNVVsZ0p6TWNv?=
 =?utf-8?B?RUNkdUh2QzlJVGdqdHFXMUJRUWo2UkQvV1lWYUxybVAyOFZYY0RjNUMzWm4r?=
 =?utf-8?B?d25QdEhDQW9XQkRxM1laZEZ2MzVlUStFdnFSRlFBR2dyd3c4REVoeXFITzVL?=
 =?utf-8?B?VmJ6WDJ1SXdLeEN5ZWxrcHlIZVhFYU5ZdFMzZ2N5MmFDTDJTUGFrSVh1Q20z?=
 =?utf-8?B?c041NGoySTNOcTdUTHNBVkdmTUxhQXJvMXQ2UGZlVk9lYS9NQmZ3MkY3NFpW?=
 =?utf-8?B?RDhZaFZiTHdhSDNoT3hmcUpFY29JUzEvalFkSWNSZ0RUL2dnTWpweU9pSDZJ?=
 =?utf-8?B?QUhsVlZhVXJrRWk2U25PVytLaTJIZXl0am5qamU2b2FBNXVzMkVTMnNNWjJL?=
 =?utf-8?B?UDRKMm12eWxOZkJjQXAwcWpYWkpMK0VtK1VicVFiMGxZRnFuRzYyQjh5aTBX?=
 =?utf-8?B?MzRkSzBSUC9PWVQ0VkFtYnhtMWlDVXA4TUNuMURyMVJ3RzhkSURDaVdSSFRx?=
 =?utf-8?B?V3FBVVh1bVkyTVVEQVJOeklTcENjMmJhK2svbTdjR3k1NlBVRlE4ZWdSdWNJ?=
 =?utf-8?B?bHNYMDRQd1hPbGZCTXhQUzdrMXlxNnFJQ2JKN1lXT2ZDYjFsWmVidXc4dVNI?=
 =?utf-8?B?ZDlObE0rY05tUlM2Sll6WU1CK3lka2tmeFJ1bDJWbDFqU3NpZ244K3VRNWF0?=
 =?utf-8?B?VjhVQkRFcWxwYVNFU2RJMk1nMitVc3A3UDNWTFkvdDIrbENNL0tITmtnUWZo?=
 =?utf-8?B?T1ZlQU1OUnFQVmxZMGJOelkzbDRVd0ZlLzNpKzBrSXFrdHB6dGZ1YU9ZWk1w?=
 =?utf-8?B?bDFNNStveWdUemlpOThrTWozbUUwd2hYcklmOFpTbUFnOG9QalNLSWZ3c1FE?=
 =?utf-8?B?OEE2NElvWWFIVmJlSnFVd2tYZUxTWi8razhRb29lQ0xPOGs4Y2lnNXB4WDZI?=
 =?utf-8?Q?uMRrAmlI/tOPfxNEQIb7Z5PWb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9efede0-913a-4ca5-cfea-08dce9dab7ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 09:54:38.2418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEuwI7StxHNNfQJwOLcu7nam7fXvddnyvJD+fPZamyNGPggBv3A+WgmLnkS/leQPdCDe+qD+m7bq90ikODEazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7397
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

U-Boot device tree is padded just after U-Boot proper. After the whole
stuff loaded to DRAM space, the device tree area is conflict with BSS
region before U-Boot relocation. So any write to BSS area before
reloc_fdt will corrupt the device tree. Without the fix, there is
issue that “binman_init failed:-2” on i.MX8MP-EVK board.

Move the variable to data section to fix the issue

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 6c0a8c0cbe4..19c65c7ce47 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -71,7 +71,7 @@ static const char *get_imx_type_str(u32 imxtype)
 
 static const char *get_imx_rev_str(u32 rev)
 {
-	static char revision[4];
+	static char revision[4] __section(".data");
 
 	if (IS_ENABLED(CONFIG_IMX8)) {
 		switch (rev) {
-- 
2.35.3

