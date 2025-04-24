Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0026FC369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B1582054;
	Thu, 24 Apr 2025 08:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJ74CBIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18B281F54; Thu, 24 Apr 2025 08:34:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27743806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kod3Cplk6SW5Ti5HTu7oADbxD5LT70birCF/HD1ABzOxTCAd30o+sel1jzECuAokT7aHhBtlXg95viH2KXEEb5d7y4n7fNqBCdFBYvilJJ2LBhjWZD8qCZOsizLRJQHKMjgZWIg/4irHdfMJniG030EJn4Zigs7LXUSJQmSoQ1xUOfdgr8VC/j3nLDowg18CKlEUXHPdCKQl+KObdG2ZFwzQHjBdLP8sp1wb4qOJ0SFH/oe71394I+xkB2MTUHILjvobDKn3UczbitobslyzQEINqF1c87sTKf3kyld/X1IfeI0YSwqbPeR9/99bOYG387J73f+cdrNUEHcBIC2G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PncURoVU2uBLb7U0sHGjp2rZ0i2oKIJPjpGwWRU5XQ=;
 b=MVPQN3i57ScrLDkU68Zn/J47dboXfa5cXWYvmJJ63Na6L77dhX3KdTdAokGV1a/SDERCMV8xCd5RyMwdff8GOI69Vb+rMgSL6EQ89uYg+DBrBgve/BhsgtdDNqzclxm4BSQmEo52MWLTtI/Hbctt+1VYwV8djlzISqsrpcD++YyzIxvGZLIhbxm42khFV42c4m3nILZy0V320Dvu1QDd+GEiffrEyaITCu8VUUO5h1PGLEeoUJbGqaAc6ylRA6rSXkXXJDM0zkAC/4gmbsXRuFBqxHCzxGpawDJzGgUFg45/48F8GfgX/76Zy8wE4PGyCCh6MmpjSSPDdhUbg0aYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PncURoVU2uBLb7U0sHGjp2rZ0i2oKIJPjpGwWRU5XQ=;
 b=MJ74CBIEGek5AKphCpT1NPnXBe4kBY/tl3hZFNAfIS8q7eGnrXnxOnHHJwfIG0RCIVb1JqHBLZUGze4P7XQrwRn/8gtTvJ+qGUqVodcaKB3o4la/x/feLePto1/pP3rD2ffYNtXXOpGIWlwe3CMQcyfJm50RxLNuaMD/KYKoxLloVOfULEK+pPdPqhJc/8HJDde87kmI+YD6o5kPcfAehYzFusluoMZp5dna74dDR6mwOCWqzp/FkLX85gEshToUbUBRMdYI4lXEnMFXNrMHrnwHxlbJNcnWVS1V+p7dPFajpNw0E7l3dpg8WAGucFd6oOYW4mIIxAPkVDm+d6mjmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:02 +0800
Subject: [PATCH v10 06/21] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-6-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec78072-ead6-4b9f-130f-08dd82fa086b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk5VYTdLNWZnMEZjaGk0WUJIWWtuUDBOdmkzMjVFalZzbzU5RTdFL1BNcVRM?=
 =?utf-8?B?QmJxVGpra29PT0VEZ1ZPd0ppNk5nOUpwelc4QlJISmpZR3g5ZHh5eHBjcDdo?=
 =?utf-8?B?RW5pajB5QzAyYTVGY1BhTkYvZ04xdStFVGd0U2RQRi9pcDVMcUJoRzhNNXNX?=
 =?utf-8?B?QlY4bE94TW9jRXQzZDBvKy9SZEpwbk53QmtlNWpZU0ZtZFZocWV5Q3IyNlJ3?=
 =?utf-8?B?UHNFV3VMY0lIWXdLZ3hZaXU5UVRYc0NBSVhLUU9sSXBFSkR2bTdYVmJSN3hz?=
 =?utf-8?B?ZWJFTmlNY3lrM0M1Z0pCYWVwS3dNWmJSbUkyUGMwNjAvKy83VHlTQk9OdVFZ?=
 =?utf-8?B?NTRyMHNESHRWUFFkaU9oYzY3dHRzRVhPajI5enFGQm5vVnpaWDFNMmhFSVBF?=
 =?utf-8?B?eFQ0OVJHUVZEYUxhMkR0dVJhc05YZnlSWkpZOStHbG1CRlRLcHhxL214MXE4?=
 =?utf-8?B?Z1lHODRpVG50UDBoQk1YOU9PaXRsb0xCY3Q2YXZpby96U2dPeDJia05DK3Av?=
 =?utf-8?B?TzllUWhITi9MdmtlSDhHV0xxd1VBQ0hTUFVKY2V1cmNYdTA2SjBnYVBQaSt5?=
 =?utf-8?B?UDJ1eWNOaU9HYVN1MWJhcDdqOUlLOFN4QXpqV2xCM1FkdUcyTnlVOUlqMDdq?=
 =?utf-8?B?TC9BU0hIeEprSERlZEN6WEtpbkVxZHlOM3M1QmdQNmZ5cFN5bndrTkU0SHVP?=
 =?utf-8?B?YWV5T1ZHUWw2bUpSRkgxR2tPM0tPQmFZQWd3Ni8yNHpxRmhiK1NVRnRGV2FP?=
 =?utf-8?B?enJjLzZIV2ZGN2o5TnZpalZEYUtXNVNJZUlsTmJzdGE0VkNlM3VZekIyRi93?=
 =?utf-8?B?ZFVOMUpZaWM4ZzNpdHM4Ym11SXhLZGFadmx1eW1OQkxpbDZVY2ZlWEpyRWxG?=
 =?utf-8?B?eklDSURaRGlVS2VieXl5KzRnV3ViMVNrZWg1cUFqZDlnbk1LSEdEQUtuQm85?=
 =?utf-8?B?NWMrTmVFS1ZHb2t2dDFXVzk5allrSVFHbXVxbXN2RnJVRjRlZnRPQXBOcVRR?=
 =?utf-8?B?ZUxoeGo2UHh3dktIa2xTSzByZW5wQ2ozR2VoTTZPN1FQZlc0NUFMck1SQytj?=
 =?utf-8?B?RDZWbVJaZjVMaG9TMFN1NFJBQ0JIQVkrMHhVcXFXZ1BmbTdmcTUrdWY1R0xZ?=
 =?utf-8?B?ckMwSkp0ZXM3VVBSOWdESEJGUzc5V0dBSnNsd2dVRDV1Vm5TL3ByTXE5bmZu?=
 =?utf-8?B?VFdtbW9UaWQxZ3hQK2NZOU0wTXk0TS9pcXBWZVphMUd4azF4TkNSc1l0Vk03?=
 =?utf-8?B?blZ4TW9MVTFkcnhjUmJIV0RtWkNIcHJ1Z3gyTmc5Tkg0b1hQVUlYUXBsRktB?=
 =?utf-8?B?cXlYV29neTlERGNQc2haQ2tkVGFuRjRkdDJmeVdHL2E5S0NxZ01HTDViL21B?=
 =?utf-8?B?UnJYZzRTMGtzUTM2OUtLVzFRbVBRNlhXR3BaY3BWN1MxQlJaZXNQRG1RVVFs?=
 =?utf-8?B?RFp3cnJwc2g3MWRsM3Y3eGZKYWFpWVMzVGNQb3RoS3pEMkFRNGZoT2lKSFRu?=
 =?utf-8?B?OFoxUUp5emV5WUw1Y0E4dDFvUGNYcWo3RXlEalpyb0hLWnFnaXZFcGRDYjRK?=
 =?utf-8?B?OXZ0SWd5dk1GS0hpSXVWenBNNU9jRjlmR1BQMW9QWEdRMURKUzdUcmY2akRU?=
 =?utf-8?B?dmswelFicTJGNUlVOWpRdWFZeTdIQStDRmhLS2NVSTJRY0tteGovZjlLMjFr?=
 =?utf-8?B?cGQwdUFTMi9TbXREY2pXYThBbFo4UlpvN3VhTDU3cVJyNjlOTXE0N0pKdWVT?=
 =?utf-8?B?blBzdlFHdTlvWmpTcm1zcFA3UzJXeHFnWEhaUXNhQ1JGdG81aHl1VDNxbXNu?=
 =?utf-8?B?L3FLV00wdUZPeWNUMG5ENFhOZjBOQ3R0ZjFza1dXcCtId3gyN2c3M3ZwRVhn?=
 =?utf-8?B?dDZJelZEZEVobjJSdlVkdFFrRnhiLzF5RVNrQWxtUFNEUXNjUFJIb3R2eW90?=
 =?utf-8?B?NUd4bjM2bWFvWkNwWlRoRjQ1ajZFTU5KRnpseFExNzBPMVBYMTVCMWtpT3oz?=
 =?utf-8?B?M0I5bHBMR3BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T213VGNILzVrWTNDYjh6UzBIQVZoYS9qUmlpWk4wL000eFNvWDhkaXc4R0pv?=
 =?utf-8?B?Njk1dllHeFVOOG1SVHlSYTd6YXNZM2E2TElvbWswc1JrdHdDS2FjejQ5YUdT?=
 =?utf-8?B?WEltT2ZXekhEbVNGT1pkNTIxRkdjZC9YTFhocUROZlE3QWg4azBKZ0R0ell4?=
 =?utf-8?B?b0JOOTlrR3huSExZczhZYXlrTnZLTHEzQU9WNVJlc20yN09oWCtOdlBybm1k?=
 =?utf-8?B?OGtWU3JIaS9rdHFCQVYwUm9kZXFFdkVlaVdiazl2dDZTeXNVWFVaN2NzM3Fo?=
 =?utf-8?B?VTdnOXc3TGowZ0lZcDUyOXRubDQxMURkcDRKU2tyRmh2VUV3SnlZeG9rQUp2?=
 =?utf-8?B?YmlMWXh3MmtYOUNDL09qbERqOUZMbEsxY2pRSVg3R3o3SE1FSjNuV0FHaVkz?=
 =?utf-8?B?eUZYYnZtK25IT2JKRWJQZlUweWNWMFRVcHdJZkNSOXM0enllS2JUNTMrRmtl?=
 =?utf-8?B?U1JyTE4yL3NKaXFXZkdmL1A1d2VCSU1PTXJJNmNpcExwSncrOFhnTmJ3TnhB?=
 =?utf-8?B?T0RrbFFvMUZaa1lkMW4wVXB1NnQ3bFlPdHRwSy9kNjQ0S1JZdVNWTEhCSFIv?=
 =?utf-8?B?bkNqUVQ0OG5hQTB0TTZRMnVseG50b2h1YXFMZ2w1N3V5VWw3R2lNMFdjQldM?=
 =?utf-8?B?bmRPYlArK3VycEFGd2ZJSGQxQzlBSG4wUXBqZzVsKzI5azR1WVRvTURZdnZE?=
 =?utf-8?B?a0xzSDRUTnJRQyt5ajRoMjlrTmE5a3UrZkZFZE5ZWWYxNm9ZWDEvS0FRMzZq?=
 =?utf-8?B?OEl5MnJwbWZjVlBTSTAySytpRHhHT05kVFU0ckFNeVo0UkxidldXUGhHUmJ2?=
 =?utf-8?B?OGJCZGpzZnZBTFhrV0VnWHY0bCtTc1FnaWFGT0M3eHRKY0UyQXJkcGxySjVr?=
 =?utf-8?B?aTFpNkYwMy8zdEE1a2JPb1M0ZEJhRTI2UW9Kc0NOYWdZZWQ1Mk9YSkM1NWFM?=
 =?utf-8?B?d3pBVGVtdkwyUWliem9vR2pWTUk3Tjl0eTBxSnk0bEd2ZlVXbENoRnphc2lW?=
 =?utf-8?B?VTJlNDBYNUNxdHovcVVwTE8vUGtQczg2YUtBOXVkdHBvZCtNZmJMTUhPYk1S?=
 =?utf-8?B?RmNHekpQUUM1RUs5WHhXZmhZZUh4bDh0OGJWc2ZHcHU2b01wN1cwUjZESzVE?=
 =?utf-8?B?YUVHbE14ajZLemdUSzNQY0YvUy9oQ0ltVXpWL0dmcEpyRGRyY0tDdGhORnFH?=
 =?utf-8?B?TkdFQlU3eGZOZllDdEswd25VRkZKN0cvYUxDbThISjRhcDQrWGx6bWQxT215?=
 =?utf-8?B?MDhaSHVJU1J2a0ptUWJzdmJrQlRQTXpiMEtROVRpTE51U1Jua2pvQWpNNy9E?=
 =?utf-8?B?UElidVhEamxwM3ZES1NuTDRobGdJUEh1Mmhlek51dm9iMkhqQjE3ZDhsbUVp?=
 =?utf-8?B?eVVMNGZOU3Q3dktUb2VudVB2VmpIYUNiaWRkSFJLOTFGay94VjVOU3A4NEI3?=
 =?utf-8?B?b25iOHUyZ0gwK3NpU0FraXNCdnJFdU1ITXBOYXlsWloyTXhjSDBvaG0zZnUx?=
 =?utf-8?B?QmJXZFZBT1ZUa25EaDVwNklwdk5UNU9TUng1VzNlZVNIT1FIYUxBZnFma0k1?=
 =?utf-8?B?ejhIbzhKVjNVbjI3MjNEWG5rOW53MWhkUjhabWQ0WG5PSEE5aGJFUTQ2OS84?=
 =?utf-8?B?d3hOZ2hWazB6VmxCWGsvYkljb04xTUZlRmh6ZVVNbU9icXN2YTJhUU5rZVpp?=
 =?utf-8?B?dHpoeXpnK2g4cGdRMXBZNUNLZVhHby8vUlZXS04xbC8yYzArUEptb0dJckVG?=
 =?utf-8?B?ZWIvenJPb2RzYWFrckFoMkJmczBTL2htNDNKUGFGeXlqTDFnMUw2K2hOdnVN?=
 =?utf-8?B?RFlMNXhaTHZQY1VLOUg5STdLdGhVYWUzTWpJeXF4M0RDNHVSbmlDRkZzOWdr?=
 =?utf-8?B?TVNnci94QkVNUzUwem4zLzJWRVgxZVBGN3ZiNWtsckNvR0RVNTY1amFxVG1M?=
 =?utf-8?B?TjRTT2JPcVJkaDVsR1ovakVERnZyR1JwaTZVc1FQbkZsbkJQT1F1TVdyS1c2?=
 =?utf-8?B?WmN4Wk1nRVFza3JTMkdiZzRhLzVQYkU0TUVIbzZPV0ZHS2FVc2xYU2dPdzdK?=
 =?utf-8?B?cDZ3QmhsdFFvSFZMc1M4VkErcGt5U2p5YkgwNmhPSDRjOHl3Ukl4NkN3SFR4?=
 =?utf-8?Q?9NWPEOcIulmTqtf0j8IZfTPq6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec78072-ead6-4b9f-130f-08dd82fa086b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:15.3255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ywTpz/hSqj3kG4pkcOxhVn5HndbjuwEN5zulM+/Xb0l96tVJs2HzXcIEmY4dKZKPDEzMrICX2nu4PjAPEj9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f8..34f272c448c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

