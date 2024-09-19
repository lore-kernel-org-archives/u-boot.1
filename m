Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F1CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5513F88FF8;
	Thu, 19 Sep 2024 04:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kr1CURA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DA488FC1; Thu, 19 Sep 2024 04:58:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9887D88F6F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icPnxsM4cTLP9E0GRMSsYZmg1RvmXaj6TnolXk0RyZvtvS8vLqcOfj5wPth2IojxxrStYewwLp65S4ksHPIvx3bNGsQYwgCXxac7xStdXI9Ym/UfkbG+8ScG6BIVyrmsDdpcPvjRC/g+fjWZ6aPyae7z0xvQD6cv1PGGQZlN2sRj1vwkUWS+LhAlgZFD2CoFdoTcB53LFQC+tHR36NcbdY+a0uBum14gr3wEg4UJt8Bp320XoI1A7dc/a2aYM4MJOgx88CX7zR0hENnDv+Ih3RdIKjxfe0vH2UhcVz9ASJjjnTcU1gkZXI2jQfAW+eCUKO3MFczZeEtg7NkuQfZDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8VSEslBTO6jlMSOICAuX9JJ5XxoInQ4R0x95AIgIKI=;
 b=bzp9HOOmq8Rz/7zZNbIrhmu30bITOiIzfh5fshquzQ47P2hw+kIDkWquomRDKW/XwEiDiGQKMYTeJzeR/aFAK2cciXB9npoDPwril41Fev9Q56OZuEsyDXS7FLckdOHeCrmif+PFWbOoUdEkzfbW3ijp883T7Nk0PAWWJMnz0ij+/acLPb7quIvGf2riQBo3ouPURsQQk7Trz6Y2CUxjOO07cszsV27bgsByJzHSUcxBN/ikAhT/6+l6fZDLN+ddAo4WK18ptDNpycwCdW55wxRISmVzZUg5jlZcliDs+cuAOwkL3oPL91Y2nDUW2RRFFAdn2DAr0tLTKEonIWucbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8VSEslBTO6jlMSOICAuX9JJ5XxoInQ4R0x95AIgIKI=;
 b=Kr1CURA//OMRXwUM/RluniUBExKYxDKuMmMghycP/tbKKA0XaJuBivJ0xyl/NJPy8CQA9ZriBFX5ieHAWWblF0lkFGCUK/wRKll8hl/YqjHRWkCnen7FDGeg4xAI6hCmIYYI0eYWgWhJ3b8mo1Ui+kvA5hA4yK9zcFqAArX1ycOrWjl2YjBijE7dDpcXEgxX5GrV5w1FwAOAoerC+fyLPwerit63BVGmMHOwblf2cCZa9bUodbzB8URKQ5jiFepZIxbo0r0TBl2ijEwwAk2iA5Q0e2NV7E0+FLNyQtVhnY/wr+lF8DsQT6BMXC78B+UpmzwzaMhW4KZ9nj8oHKbaWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:23 +0800
Subject: [PATCH v3 05/21] imx9: soc: Change FSB directly access to fuse API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-5-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: c72c0601-b985-484a-caa1-08dcd856e879
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW00T04rdjF1azF6WlRsSEFvUmhmWThyajVQazdiWENFcGlNajJ5WmVmUDVs?=
 =?utf-8?B?V1ZUclUwNjNZNGM0RUhNQ1ZoRjFndVJIQ3VONlBkMnFyRmN2Nk5tTUgwUCtz?=
 =?utf-8?B?TkNQUWpmR0Q5UGVXazc0dlBzemtDRHBhSWNGcnViQ1g1NVBTMUJLemVadE1u?=
 =?utf-8?B?Smx5YkNmbWsvQXZGYTBwdzJWZHd0Um1QQjlIK0psbmdLa3FQQXcrSGZzQ1lw?=
 =?utf-8?B?NXNqZS9qbjJKdm1qL0ZsbGdCRkhXaFF2NFJlSFFqZkZPMjhJWWRrOWFJWkxa?=
 =?utf-8?B?WVFJbG9ISThRVmZQb3lHbUxtbS9FR2VoL0FNdlErNDBZaUptTzczMzZmVi9E?=
 =?utf-8?B?Q0FCSHpZMU1xWHZrTkxPYzB3RmFWNWtwSy9sOTh2K1o5SVltbW9JVGZoN1lM?=
 =?utf-8?B?dCtoRDJ3U0thS25DK0RRZTA2cHVCZXJyc2k0bmYyVUtHZktlTGdUaEM3SGp3?=
 =?utf-8?B?SzJRV3A0WUwzT1lsZVFUWFdJakdLVVlYZ3hHbDQ0ZTltOVh5WEQyTU5yMVNr?=
 =?utf-8?B?RjF5WGIxc2xMbTJCeURqOG40dytxVmxsMmRWMit0cm40R1g0Q3hTN3VseFAv?=
 =?utf-8?B?VEdJUVBwYml2WitnbzRQZWNWT2FoanlYWTNPMDZCSmNyV1Jqd2R1L0VPaUJ5?=
 =?utf-8?B?OGxVVlQ2Umd1SDFMNlV5OHBvVUhrdXdTUHlJRVpxYlp0dklubTVHSVJSMUN0?=
 =?utf-8?B?Y0lnb1MwS1A1TnRIc1NnOStVd1JjK05XNCsxRlNEUUo5U3BnUlp1Q1Jxa04x?=
 =?utf-8?B?dmtqcEFPN0IrVy9MWldMVlBPR0MxQTcrTDk2M3o2cVoxelpXOHRQeHVnclpN?=
 =?utf-8?B?NU1mZEFkYXBSc1EwY2F3U0NnV000ckVHMG5oS3o0STg3OS9LMnNjdFhESmF5?=
 =?utf-8?B?ZXAyeTkwSTdSLzA5MmM5R2ZodC9JYUQzRndHSEN0QjNOSlFka2E5ZnFjQlk4?=
 =?utf-8?B?azFPQnl6c0FIclJZazhBZ3dRRW9sZWc4N05TY1ZOazZUUkExOElDWmNjWXAr?=
 =?utf-8?B?SnJHWUlJdDRsVE1qaG05YkhoZmwzQ0xJOEVrVU1JeE1DcGdSNzNxcmRZQmo2?=
 =?utf-8?B?K0NGMWFGSGJvcEU4Mmh4TDk3Qm43MHNYWXluQUxaREYyOHVjRVZaQklLa1NQ?=
 =?utf-8?B?Ti8wZE1PT1FQVjd4K0J0WnUwRHRYYk5lUmhwZXB6c3FDTHNoQmJwc0ZzU0Jj?=
 =?utf-8?B?NGxma2xNc09CRXBkZXI2bkk5bkxwNndQV3UrdHoveXF2dG9Gak8zOUowcksv?=
 =?utf-8?B?YjcwekpVaW1VbVMvL0ZhSzFuOWk1b1VyTGpyT3Q3b1BkMmpFK3BSNTZCNlVa?=
 =?utf-8?B?aGhjM1QxcC82MzN1dDMrWHFtRUhKa0hKQjFjSVpPWUlEUjdNWXhYc0Y5Qzhm?=
 =?utf-8?B?b3cxSGQ0N3JnK2xMWmpXR1NjdGJOaWdubjROLzhCOHZQckQ2d3FJYXlTWXZ2?=
 =?utf-8?B?NVprS094VFd2ZXlrWkNIV0VkQ3JFTUlFc09YWlMxRDVIV2dWdmVycXB1eXoy?=
 =?utf-8?B?dFVzRmliVUlTS0k5RUJVMDZXR3Z6S3FOYmhQU3lwV21OU0dYM2JOMG5MY1Rh?=
 =?utf-8?B?OUdFVXJyWjNsdk9adXJ4U1lDUWxKNXJtL3FCS2JvSm9RcjR2cFVCUTA1Mnpr?=
 =?utf-8?B?ZVE0Ynl0dHZsemVHbXNRM2ZjWGowS05ld0tQRWF1ZXZzTjBJL3N4c0ZhR2hp?=
 =?utf-8?B?L3k5bS92a3NaMUJqeEsxZldJMTdWVjM4aEJwMjFZWm55VEFIdzNaaTNpVExi?=
 =?utf-8?B?RlNzZThrN0wzNzBhVHpCSHcyR01zcXJsdTZvK2pkMktUL25XakhMbE1EL0J6?=
 =?utf-8?B?L1hJci91K1pPSnNQVmwrcmdSYy9hc2tHNXN0TU82cEVHeTBoNUh2RXhITlc2?=
 =?utf-8?B?VHVUV3ZTK0ZSZGl3NUdMbWxaM0taT25PUDJPelNIUzdqZkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE96ek9rTVJGdEU5MEwxZ2llRlI2L3g4eG5hNzJUdUZmakRxRUh3MGkyL2Ew?=
 =?utf-8?B?MjdDenVoK3k4VGdsM2kva3RWKzBoTlM0dDdqcUZxYlFzdThMYXdYSHRsa1F0?=
 =?utf-8?B?R3dENGN6NUVXRURTV25NcGM4dzQ2WDdWM3dLczY3a2t0NEUvVFp3cmY4Nk82?=
 =?utf-8?B?N0JBdkd0aGJMb1MrM09NNm1WRndhTER0MWFjRENucW9oWnZhWTk4TDYzQlBB?=
 =?utf-8?B?ck1BS0hJWFE4VXE1ZldIeHNHTEhOdUdqUENocnFuc0E3bVRLcXdYUkh4Sk1V?=
 =?utf-8?B?amhyRS9zWFVPYklWaWdDNFBSZVh3VS9UVUFrZld4cHBPVnVqZC9iZ2NWTldJ?=
 =?utf-8?B?M2NtNGRRUVZRM3VLTTdrMTVhM3Z5TVVmWFcyaXkwUnVEdzJVdFFFUm9CV2k1?=
 =?utf-8?B?Z3A5bndzbVhGeTduRFNkTE9INWU3QVZla0xSWnNLZW9aaXFHUGthdWJqa1B1?=
 =?utf-8?B?NVpwZFNENlo1dTBndUlOcVBTc01ncDhjenJYc0ZSYzlEOW5QRUtwMU5sN095?=
 =?utf-8?B?aFZXVnpDbGhOR2JlczEwVzFwVnBSV1YyVHlDTkRMUUl2WWRRY1Nsb09mVGta?=
 =?utf-8?B?R2RWaU9zbUpKald5eXdWS3lwckFDTEZrTWVRUHVCcGNPNi8reWRrdEVhbER0?=
 =?utf-8?B?anlLeTR2R0htWXpxTE1Sc0Mza21WbitvbVRmdzlrNDRYcnlURXh5SjZUN243?=
 =?utf-8?B?aHN0Y2FINWJkQmVVaEVOUW90V2hFcmxvYThWNFQxaEc0YXlKOENDYzl5MUdo?=
 =?utf-8?B?c054ZDhiOUl6SHBQS0FyenZ6emZ6V1NmOEM3TjNUaWJDNW9lcDIwbWZJd3E2?=
 =?utf-8?B?RGtRS2FTMUZ6SzVUMURLMklXMGhpUkxmZFRwS3ZmekxtQ1hFZGU2a3dKZGpy?=
 =?utf-8?B?YVllWHAyTVRYUVByQ0N2ck1vc1orSDYwMFhBWmJDQVl5VGNWZjRoSVgwNzhS?=
 =?utf-8?B?WWJGNktZL3pjVWpRaGJnNnZKN0MwQk0vOW4xU3ZCNkw5L0hxcDVuZ3dPM1Y0?=
 =?utf-8?B?dEJVV0hJRzdiSkZqSlo0TEl2amdaNVZFR295WFoyTUxIQVhHY1l0QkRoLzVL?=
 =?utf-8?B?M1pHbmFiaFNGVWFYNnNLUTBJM0ZpQ3hGZnRQaWdBcW9YMy8rQlNsWFpIdndv?=
 =?utf-8?B?dzZZN2N3Tmg3OXRsNVArYzJma0w4eHFiK3dHQlhJV2FzOVRBaENuVmp1djNX?=
 =?utf-8?B?dWt6MXZ0TENGa3VwQmR0NE9JZ0NIVmZkTHRMVTI5RDk5NFVOYVZYaC90UEVu?=
 =?utf-8?B?dWZ3K0RlQnlFa3cxWlFzYnIwSjFaNTdYTzlrUW1MVWtza3NCOW9IN0JhYk9s?=
 =?utf-8?B?OCtBOEpLWmNIRHYyRTg5Y0J4NXMxZWJuT1M3WHNkcFlXaUxrUGVNWEYzRjJ3?=
 =?utf-8?B?RUdJL0JFOTlzQ1g3dzNwRnhhQzZnSjk3YnZWMnZsaXEvbS81RHVjNWk2RVU1?=
 =?utf-8?B?Y3k5aTd5NDhHM2E2RlFVRDJ0QUFiaVpoOEhibnE3VXZ3aUo1czNPVmFXWWU4?=
 =?utf-8?B?WlE3a0dHOTdhZng5T1RCQmZ1U3dyTXVobURTQzZxdnkyMVpYbWpURVRqRFFw?=
 =?utf-8?B?STFCYU83QlNFSCtEMjZFTzBlOWdrbEJha2U3WGVYbldaZTN3UnRDSTBWYWFl?=
 =?utf-8?B?WkFhTGlXQlJZNVlxUFBkYjdCUUF3TTFzUThRUWJUQ3NpL2dtRnB0V3oxb3Vi?=
 =?utf-8?B?RUtjYkFwTHNsU0xkUnlxRHQ2d0RsY0NrU2tBWlZxWkU5L3g5c1k5ZFZXMmhZ?=
 =?utf-8?B?VUNFSFBabTVJeHBJdGNqVjkyMzZqaCtId1UrYnAzMS9QUXVpSHZTcTZ2amFh?=
 =?utf-8?B?UHJHUDB4RC8vK1V0SkI3VXQ2ZnhHdy9UU2NqMlRBNFJzTWF6QTZLd2MvZ3h2?=
 =?utf-8?B?SzdHSXdEZlh0YzNEZ003VmFPZlZoMXpKTVpYWENEQU5adlhkWWE0b2liazJB?=
 =?utf-8?B?SldZMmFpb0FaY2ZXUkwxQ29DK1NyYjlRcFVndUFaT0UwYUdja2NWNkpLdmE0?=
 =?utf-8?B?TzZZWFZ4cUErcGlVaUZHZ2tLR1N2M1RrRkQwWHBrSjdtS2ZZNUM0eUFXUDRh?=
 =?utf-8?B?TUo1VnNXWDhxVCt3K3NXSTgyZlErcDBrcndxSVRXdGgzU2RWQVRTb1RPZzNi?=
 =?utf-8?Q?3Zds8DCJ9vYos0RD4xIDmcpuT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72c0601-b985-484a-caa1-08dcd856e879
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:15.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dy4+W63r1wH2JVrnyZS1hZydEjfNG+ZZCsEQxXHbKxoBh7944acd4Z/D2bi44JhhPXkqE0Il3LQ4OCxzzDvP7w==
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

From: Peng Fan <peng.fan@nxp.com>

To support OSCCA enabled part which has disabled FSB access from SOC,
change directly read from FSB to use fuse_read API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  3 +++
 arch/arm/mach-imx/imx9/soc.c              | 38 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index fb6de533d12..cb6b8a59cad 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -52,6 +52,9 @@
 
 #define MARKETING_GRADING_MASK	GENMASK(5, 4)
 #define SPEED_GRADING_MASK	GENMASK(11, 6)
+#define NUM_WORDS_PER_BANK	8
+#define HW_CFG1			19
+#define HW_CFG2			20
 
 #if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
 #include <asm/types.h>
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index bdc569b4ae4..5699623027e 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -96,10 +96,16 @@ int mmc_get_env_dev(void)
  */
 u32 get_cpu_speed_grade_hz(void)
 {
-	u32 speed, max_speed;
+	int ret;
+	u32 bank, word, speed, max_speed;
 	u32 val;
 
-	fuse_read(2, 3, &val);
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
 	val = FIELD_GET(SPEED_GRADING_MASK, val) & 0xF;
 
 	speed = MHZ(2300) - val * MHZ(100);
@@ -122,9 +128,15 @@ u32 get_cpu_speed_grade_hz(void)
  */
 u32 get_cpu_temp_grade(int *minc, int *maxc)
 {
-	u32 val;
+	int ret;
+	u32 bank, word, val;
+
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
 
-	fuse_read(2, 3, &val);
 	val = FIELD_GET(MARKETING_GRADING_MASK, val);
 
 	if (minc && maxc) {
@@ -160,9 +172,21 @@ static void set_cpu_info(struct ele_get_info_data *info)
 
 static u32 get_cpu_variant_type(u32 type)
 {
-	/* word 19 */
-	u32 val = readl((ulong)FSB_BASE_ADDR + 0x8000 + (19 << 2));
-	u32 val2 = readl((ulong)FSB_BASE_ADDR + 0x8000 + (20 << 2));
+	u32 bank, word, val, val2;
+	int ret;
+
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	bank = HW_CFG2 / NUM_WORDS_PER_BANK;
+	word = HW_CFG2 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val2);
+	if (ret)
+		val2 = 0; /* If read fuse failed, return as blank fuse */
+
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);

-- 
2.35.3

