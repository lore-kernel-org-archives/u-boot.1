Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E23D358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50D983E9F;
	Thu, 29 Jan 2026 10:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TAoFy4kE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAAC83E88; Thu, 29 Jan 2026 10:39:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD5F83D9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9Egmb9hIswwh4dVqqq8XrHL5pkbzdMyDQZMb3RfljfoI3JaNN8Bx2PPGqrs3tLGpqo0hd9NZcD67tbw/lUBRx+eCbDSbjHoN5dGv1VIph4qJlMcBd2dxItago8GnsB7T6SzlV7WnSNKnkEMLFixfz0MTeZBRHLdEiqqveFfFGPyG5oRZM4OhmJlMyKBD+i/bQ7dp5sqH+3u/NNKtVPqvsjeHwe9rlQYVAgMvtEh/U8ztsEQU0uvxNu5Y2gB9ddYpcn2mVwE8CDGYsFj+4d42bOf9HzSN55L5sOE2hR4v5I9feyMBoE0WGvQevunc0rJhl+fD5SsO1rNxLYtKi3Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAy4nTZglhTJUvy7lQqKjhhDwGQyZ5cDv60LkLZLVQ4=;
 b=UrUvVYgyCsG2OquasFgr42FGI+HR2wPpy+aTyihA4nwSPAOAJyWSDlN2liRZkRdTUHd57zQvVpiYLL2HfumnzuXY5Wb22c27UiyMjk+ISNv7Nc0d33IytyVhnqOr5/8NHbNqRZO9aa1mmLqxafu7UdHXweXMag9C5e25qfcOLDQswSRtEuFIcN0L3C2/vP2ewoNUQ17QwROJTdNEXF3Ovih4BzxEynJ0INJXbDUoI5PHL0StcqDx4UKKt5rxb28DHmZw8S1F3GkKkKYR9bqAhgaFnvSSTBCvs+vCGuRyr2k/uls+UWhS+Le2psY56wAs64pwhwnpHnclq/XjboV76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAy4nTZglhTJUvy7lQqKjhhDwGQyZ5cDv60LkLZLVQ4=;
 b=TAoFy4kEgTmsf9BYMW2mDQNvxFayYNgr6njAlUIiHJwrk6nLGhyTHnaREFZNoF8xs58g6xmPTUmb8tq/8ubB8jbWeEiEZ6Jpf3iaEbdQU5y2uXyCnW627GIxYa4Bpde7fkikBdpPQy79r41uvTcmgQbTlsBy2v2HGkqvoONn8X+zIEHY+lXult9yAoWcS5AJOV2Korin1bbnOUtvH7BQMlD8COiiFZbkHaDTLCDxM1dsx32UuzxMC48aadzkVrBMk6tNAzKILhDKts9CTWWfiRHHEf3mwT7uZVVxwitqR3qZKnQpIUxTA06dl6WT5011qBND4cYeXYHl3OJkNUSo4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:06 +0800
Subject: [PATCH v2 04/12] imx8mp_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-4-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a785fcc-59dd-4410-f274-08de5f1a5085
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXJRQWtVVlMweTVEN3E3dzFpaEk0Rmwzb3NBd1ZWU2ZRZkR2NWZhd1pKemY2?=
 =?utf-8?B?OE15bVMwc24wU1VIWWRqMk4vY2k1V2ljUEI1VFg0dkxqb3NGdUNlcmdMNmI1?=
 =?utf-8?B?a2xJSmF4c3JjNEZjVW8wN3NRdzNXVmJ4bXQ2V1hWcS8zakdVSXcvMWVTaG9T?=
 =?utf-8?B?WkZVQkphemw2VExVd0wrVEI0U1dhakQ0MHIzaUdpMjRyc0U5ZDZxZ3FrdmRk?=
 =?utf-8?B?M1djZTBpRWNyRE9ndG1yRjl3RXVyOU5ZelY4dFhnNk0reEpNVGRnY1c5bjV0?=
 =?utf-8?B?cEZ2NnFDVXJxbFNsSzhsQjhEWFhmdGRTSVNIMlpZbWIxUFU4S09oZlJGalNV?=
 =?utf-8?B?NzQ3WWVBNWxIUDFKeDJFRFlxb09pNFBhSlZjVjhjZEEweXFVN21rdDduM2tN?=
 =?utf-8?B?a0VUaXgxaldvd1JSblFUQUpsbDkxVDRpVmxSNjNRTFJXN3hJb291bGczQktV?=
 =?utf-8?B?SUc1R0VmZWttb205WHFUUkhMWjhEU2tNRk1iMEZsU3h2azVlVUxKNXNxamVD?=
 =?utf-8?B?VTlCUERGeGttc3dRZmdyTkdhcmYvV0ZXOUlMRUNrOSs1Q3JubmtGWEVuN24w?=
 =?utf-8?B?b1BzcDBRalVVTFIxVFFxTktmOHdTVDFXZURoUUlEQTNpak9xK0YvQW9ZZUJ0?=
 =?utf-8?B?QTczVFZUY0cxYkE1eHUxZjRHcTIzaGJINFFXcWRuQ0kyRnQzdWJ3Z2J4MXdU?=
 =?utf-8?B?MVUyV2R3a3FGSUdOMkVBREZxU2tzZ2kwOVMyWldhS3laMHRMVW9jMEFudXBF?=
 =?utf-8?B?ZTJkNStGdWNTTEFYNnk3bWZJZzhBOHNPT1JBc0tNdUZETEg3Ym0yTExTMlgw?=
 =?utf-8?B?UGVQdnNXNW5FTWg2YXF2V0U1QlF2azN5ZlkvSFdQS0lGZ3I2WXNwbDZhbDhO?=
 =?utf-8?B?RjkvdS8yWHozVHVqZ2cxSWx1R3pZeDFRd0w4ZUIzZEp5QnEwZitERkZQZEpy?=
 =?utf-8?B?RjJxU1liN0FWZ2hkL3ZwZ2pPODhmUXJDYXlJOHRMZGVDaElLMkM5VmpsUlVr?=
 =?utf-8?B?OGEvUlF4TGxpam5ZekRNNnc1K1N1VVpSVkhrZGVzbXJaajRSeWg2WU85OHk3?=
 =?utf-8?B?bi9yMEJmZm9kZGRxNDd4dGFTSVBYM2dUNktwREEwSWQ5cmF3S2N3VU1uTjVM?=
 =?utf-8?B?bnhVbVovYVhRYlY0SzJDd0hxOGhYY1ZjV2ZxelN3SnZNbGNxcjFsV3F0NHJn?=
 =?utf-8?B?Y01aWXZQZWZHbGlVSSt2V1VVVUVPd0lCc3ArUEhlek50UDZwdWllWXZON280?=
 =?utf-8?B?dldTN0V6V0l6N1BmZDlBYzlxeC9EYyt3S1gzMFlOcGJpVElqUGZZT0hjQ2pm?=
 =?utf-8?B?SUVuUHlDSlZwRVpoQ3g1WGsxcXM2a0F1NitIdWZJWjZjakRHMXhrMHFNdTVX?=
 =?utf-8?B?ZU5kcGc0c2R1QXpObUJOZHZWZ0UyYkNIWW1ndlVLVm4vZ2RMK2sxdkRyaW40?=
 =?utf-8?B?UXBwa3drSVhPMUwxS2JqNko0dEk3UHFkQVJ2eXRmMXF4UUxJSkhjV2hHdy9N?=
 =?utf-8?B?NTFkWjJ4dXBHRC9wQUpzOEhmRDkwNjhDL2VHM0dkQTQ1N3B5dUlKWkgxVm5n?=
 =?utf-8?B?bGFBZ1E2YWRDN2hqYWtlQ3FBcXphMzF0em5aVnpFYzh4TElNcUtRNFBTZW5C?=
 =?utf-8?B?NkFSV0swL1pEeVorcXR0a3JFU3NHOXNzUys1NUhFNDYxanhrb0ZKcW4yTVh5?=
 =?utf-8?B?c1lGM3JzdmJ4ZklWc2tDUlNseU00aVlrcjAxaGx0YzloemYvS3lsQVVmTFVv?=
 =?utf-8?B?cHpZT0VHbVBxRmRpM0ozSnNCeUpvOE5pMGJQajJQbVZ0QWlCZlAyUDl0ZkZo?=
 =?utf-8?B?clJhQ25IQlgxQjhrMU4wY3lXc21ZMkthc1dCM09QeG11bjk4SUVnWkFuSXAz?=
 =?utf-8?B?ZU9NSGNRdjJKY1BCaVJiUEpDcUk3SExNaW1tZVkxSjAxZWJZSnQ5WVFiekF0?=
 =?utf-8?B?RWZkYzJqODRGampGdnZHalRlZGMrbTRjYk9mb1VVTVBNS2JkVWJGaDJNSjYz?=
 =?utf-8?B?U1FNNVM1LytlVlpXNjlXZkZEekV6dVFETU1JRXRyUS9pcGQ5OHpPS2t2VUR2?=
 =?utf-8?B?emZCM3hPSkhQUW14NnJFTW9pUGtEOG16bmVHeVpLVFo0VHV2TUpmVkNNYXd5?=
 =?utf-8?B?Sld6MHdQSDBXQWNPM29MNVJrK2RaSmJhMVI1dXZrUWlETDJLSnBZNGdocjJH?=
 =?utf-8?Q?OZn794JRZ5Q4xRgMed3xIIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9hdjc2YitaOVFvTlhOcEY2OEI3M3M3YWRGQjlXTmpFdnlPOXV0djJTaEhk?=
 =?utf-8?B?bUg5RUZxVWVsMFBabXhIcGtpbCtNbUxhdVZtMXMyNVFHV3ByTnJGM2VpRStr?=
 =?utf-8?B?WlBZUFNYbnlXSnVndHRaWlBQcURVYU4xT3R6ZGV4ajAxcjVTWTVzNzJoa3JH?=
 =?utf-8?B?MVJ2WnRyT2NtUW4rYzRBZWgrZ1o1L1UxaGM5akRvYXJFbCtvSXBLZDEySUh4?=
 =?utf-8?B?WjlhOTgzZ3FRLzVtb250c1FMaFo4SUtoUG9tRVBIektxeWNCTEI3RjgxdGJi?=
 =?utf-8?B?QmdRMHQxNVJIdC9KRWJzanJwZTRTNStJWFRua1llaDg2YXZ2bGR3M1ZkRyt2?=
 =?utf-8?B?ZG81dkVPTno0b0RxS05DNk8zc29TY0tHTnZhRGdyRHpUMldOS2xQZm9WTUdE?=
 =?utf-8?B?UVRhenp3WFpKcm9mZHdkc2FPSlVJUU1XT0NCa2ZudjUvcnFxcitRSzlyWnJO?=
 =?utf-8?B?alU1MjkzSmgyK3BJalNuU1ppVEhNclUwYmRWOVhhbHY2THB6bGxEQTQ4NGd6?=
 =?utf-8?B?NzFSQmxaMlVaamVKZmdUVVRxMENtYnBOeVRKempHb2RCQWN5NCtBaUxyTGpD?=
 =?utf-8?B?by9aUDRkUDJxUW5BNXhQekVXS0VLdTVXeFJGZHJ5em1uNE5KNlMrMGF2NFpv?=
 =?utf-8?B?Z1VmWWxXWGlva085c3owaWVmbU5wTEFScEFUTkdxSEpEQVdHaHdKQjM4Ris5?=
 =?utf-8?B?YThUSWpCMVVhNjdaUHhveWoxZzE3NldaSmNBdG0wMjNVUjVEbjJoU2U4aWFC?=
 =?utf-8?B?V0hGK08yYzBhcW01NzRlY3c5WVNOdEZHZDAzVUR5dVBNcjJTenZWM0JTVE11?=
 =?utf-8?B?SVJJemkzZVNoZjVVL0FCWU9mRFEzMFNDcGZKUDlmaEZzSEJieWUzQ3NJS0Fp?=
 =?utf-8?B?TGlkdldhN1FiR1lIUzBGTklaeFRiUzRVSHUwNFZickdueFB3OVplSStrcDJ4?=
 =?utf-8?B?WGFxcVowWVZLNnpNaEdIVCtXRU5GTGFheFFrdndSMUYxZnFBNXBvSW9iVU9o?=
 =?utf-8?B?TVlNRGNKMTNyZW5QMEpOS1JnblgvUk9KbVRzckt3eTRwK2MzYnl0KzBNNTFS?=
 =?utf-8?B?NFJYNkJJVUR5L3l5a0lKZ2hqbytWS29Ka2RHS1l4eGc3RWdJSVR6T1NMRDQr?=
 =?utf-8?B?K3pKR0w0aXdYRFUyendlWXBMUi92bFdya0pQM2R5ajJDRlRLTUhWaitYQVVt?=
 =?utf-8?B?VUdDWGsvTk9XQXJHWXhCNXcwWVJRRGY3d09Sbk1CQVlyOVJHejNhdDc2WXVM?=
 =?utf-8?B?NFZGakVzeWZzYlczRHJtZjkxK2czc1JaNUVCY2RFZjFiV1hYVyt5SEJZYXZq?=
 =?utf-8?B?MVdHTDFvK3Y3MXFJZnQyUnFoOUhZbzg4OGE2TXNqampDUG5mbXR0U0toRzZB?=
 =?utf-8?B?Mm5KbnRuRW9zRWJsNXN0TGN6NUcxSlFuVFBidnkwWFBOUHhVSXA1bWhsa2Jt?=
 =?utf-8?B?eis1QlE5L0I4eU94bDgyQ1d0NXJVQnZHR3BHMFYxV0FKUnNjazdHbGVrbVpB?=
 =?utf-8?B?bGhNVTJRK25sK2hpMVBuZFZQVU9IVGl2REp5RUg1bjZGT0xuZk1ZQ3BwQTI4?=
 =?utf-8?B?OERYRnl1KzA5TktJamlZMDhMOEd0NGwwOFRxS3FhaEdYMDgvSmR0UEdIb1ZM?=
 =?utf-8?B?WEo3OUZlbjlQMk5yczJ6UVNZTFg1TlV3NkFPMVVMeDJ3Rk50SDdGRThZV04v?=
 =?utf-8?B?b3lwcWRFTS8wZW5GWGZmRVdYKzluTVJudEc3NnRKbjFqNU9YZ21seHA5MlJM?=
 =?utf-8?B?WDFzSFkxQWFSUXFoak9YTHNEeUsreXBQc0trQTQxYTA1NkVTMnFVNEg0RktV?=
 =?utf-8?B?Rkp2cjhKaEhQdDhlRDUyK01HQ1pSbXd6dHpSV1R6a3ZUSDh3SjFyRzJKNGlj?=
 =?utf-8?B?OGsxcVRaMjlEdW5xcG51bGkzQTc2Y1dOMXhPL3lCQXlTWjZSQU1GOFIyL25N?=
 =?utf-8?B?NHlucXR5cE9mU1VRYzl3N3crWTZuNXEyRUxZUjY2SjNKQU90MGdPN0k0VGNl?=
 =?utf-8?B?MUk2clo2aGtzYmlIYys4RnNpVnNXRVVBMEJaN3JCaUp1VjhzdlBLa1FhWU1E?=
 =?utf-8?B?VjRtRFk0Zm9ZNTJXRHdYSENoN0xOSzYzN2tLTEpZM05zN0w4aWQ4U0hHWkdv?=
 =?utf-8?B?Y0p2aGdXTzVwY1lCa2grQUkvWlZ0bldkWUVhUktVQlV2NVk4OERiYWVLSEQ1?=
 =?utf-8?B?VVozUlhmQkNSc2VGWWZzTzJGVVlnMFd0UVNhM2RnKzdvekRROGdiTndHZG1C?=
 =?utf-8?B?WGdZUGFvblZxU1lEdmVTcWE5ZVVQdUhiK1kwT04vanZOTm90eGh3TUxjTzNv?=
 =?utf-8?B?dzhNZG0rM1ZFeitiOExTbkt6NGRLNGtFWVJVSDg3VTVKZW04NURKUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a785fcc-59dd-4410-f274-08de5f1a5085
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:36.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSp/06qbKE07hMOyRmyed9/UZ5EZ+0FDajShInPBlGM9dl/30M2EuLlcy+vD1xsZoaxaCUXcJXasdDsSL2A8Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mp_evk/imx8mp_evk.c | 2 +-
 board/nxp/imx8mp_evk/spl.c        | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/board/nxp/imx8mp_evk/imx8mp_evk.c b/board/nxp/imx8mp_evk/imx8mp_evk.c
index 732c0fa561d..489e5ad4d43 100644
--- a/board/nxp/imx8mp_evk/imx8mp_evk.c
+++ b/board/nxp/imx8mp_evk/imx8mp_evk.c
@@ -3,10 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/arch/sys_proto.h>
 #include <config.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <asm/arch/sys_proto.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 4e6a5830b07..5b4aac42830 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -7,15 +7,13 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {

-- 
2.51.0

