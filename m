Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F4C3601E
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4C4839B7;
	Fri, 11 Apr 2025 04:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HRWnZMhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11655836E7; Fri, 11 Apr 2025 04:46:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8F2839B7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwDUv7izNi5K9k/fTxiMV/aEXhjPKc2FnRSG8Bvg1/yHep0ntWuOMTV0rD5Ro0kXVoJ/aQk4MoP4uA7FbDFXx9soqXbrAuY9Q/aUYoVKCDUG9h1R0IYaCdvZareYgZsZO/43o+X9+pdvGf6EzYcniu+LfxtBCRimXIbETo9VFEumUo7SVeT8YdzpFv+c7C2W2JY6HOlz8kn0rtKhkJ/r00u2h417Pe8eNDIbAqjA1W9LtHb3cz3QEhDTwUTW0DEysmF82dqKs3tMgj/cX4XCII0ZqMELI/EXSihkrJSk7N1ukfD/hgyGllJf85wX5XL7thohjZln7ZF6zLvn/0HaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrDum+N7LWMpYj7Qbxo7cRALIMSZTSMjKYN/t16nGGc=;
 b=UfqD6Mi6Sc/aZ9NmNAvJbA3y1HBdJo4Oa3vOslfRN/TzYiufk1I3YDrDWuIe5bmqLlgUYKoNaxXX9CR+bkpeQIG8AKbJYD8dnImpOzndY3yYgYEKFGOit5Bc7CANyNtGxiCX/I0hdBW4cffauMi/INV8iSWPnm3eyi1Dqrw7AIpy9hEu6BLCsl3F/EdHhkLWQt8e+MIZsStukkCRcggvUu5strElNcuZJHgLFnDAq0Mc+qbi5md707yGavKdyUULygl6FEocg43dWtKpI+aGuMBotTDsYmgv2hVOoPwD8WxBB0D+fNV/x7m6uQtji38rF4Ltx++o8rZnVaIFngpNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrDum+N7LWMpYj7Qbxo7cRALIMSZTSMjKYN/t16nGGc=;
 b=HRWnZMhOE6gwEtcam6pwNwAeqCdsMiAFwdU1TQFIMVccmZsJLDW0ttIOCqPvgAehC7t5Ll9f53pMrp5s7TIR2SpNAvWG6KM0tuna1wVO5Y0Cudl2Dbv6ytJrXEnx6pU5Z5Rg01Gh1ahF2OA7Zk38ZodkVnPm9tzaKWC+V1PGBONnFWOXJJRaJGVK5cwJOitqhWchgT7/+PzkYKIe7+YSLcF5WfFS/W90j0jkC0kiwsU4TH++0pFy2yPLdt69+75Jkwc92RmFly9vNYrbxxG/LIyF+bpyiiEtwBEPTOGyWmcle0sq4ELaPlbBQ9qxGPexWA9X80mYlz32/xpVEXxVcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Date: Fri, 11 Apr 2025 11:54:21 +0800
Message-Id: <174434362339.24440.10543026192875667256.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250115020737.230558-1-trini@konsulko.com>
References: <20250115020737.230558-1-trini@konsulko.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fca7067-10e8-4d06-e04b-08dd78a30e08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW5IWGFpQ0V4elNRb2VSR0R0VDNGSUtjTjVNa2d0MlI1b090ejFya1JENFlz?=
 =?utf-8?B?OGIxYzE2UytkRHZvODl5czRBRXBlMXBudlo2Uy9seHBFd0tEbGt1ejJNdlkr?=
 =?utf-8?B?SldRblZmNk1leWxUNFpSaE9PbGwwODFBZnhJRCtIdWYzYU44bnMyNklBV1JQ?=
 =?utf-8?B?OVo2dkFROXF1T0dubisrRWQydDJSS0VabVBVVGtENHBId2FrR3ZENm5MWGZz?=
 =?utf-8?B?R1BsdmtUTVlJeDg3ZnYyaUZLMFduRktKMWpyVkhXNjRRTFFiaUM2RGRQb2t2?=
 =?utf-8?B?ZUdIempDNTNrYUhUWUdSWlZkODMwb0lrQXllQ2hSRWhYRUNBb09rZHBIU3BZ?=
 =?utf-8?B?ZVpBWWdZQzhhdzc5SXpGUEVGZC9ZdUtiUHR2N3dkUUh2VEcvZHF0d3VBRDd1?=
 =?utf-8?B?VkFzcWZHVmpoQS9GZGdicWgvcUdNVG1WSU90Q3RRS0NzM1Z4YTc0enBvLytm?=
 =?utf-8?B?bWJ3QXlKVDAyTDZIWk5vOGJoL20vVXNyOE5vODMyVlVSWnByWFpzZ2ZMVDNw?=
 =?utf-8?B?dERFZy96cnA2cmRFREtZcVloMmVSTHFUam9RTXRPT2QvMDNQb2wwUVA3NlFD?=
 =?utf-8?B?MjhidS84R3RlZ1Z3bXcySlhkVjlWWlVSMnFYdVZxdVRHSENhWGFZV21oWDhB?=
 =?utf-8?B?ZUljNHlkSy91dVlpSGQyMnU3Um9xQks3Mk5laVErY2tleFJrUUdYbWVBalp6?=
 =?utf-8?B?YWFBVXJhdU1jb29NK3pPNWczdkk2QnRpSHNUYXB5amVVZUd4SU95VVpCN3Yz?=
 =?utf-8?B?Vk0yaExldXNJS2dtVVhqZVYrS0M4eDJDL21hajBjcnJOdkpwQy9qQzlFR0ox?=
 =?utf-8?B?REgyUVk4dnJXSVp0ZjV3SHRHMHpBTjlIUnRxRTBRRnBWbUVuRjBTUUNoWW1D?=
 =?utf-8?B?eFY1SnpFREdQL1Ixbnd4NDBIL2ZYQXNmdHFicmlnRUU0RWIxc2ZoTzYzSDI4?=
 =?utf-8?B?V2t0dnFNWFZFcHo3cElsT3hoRmlTSkhZbVZENXJIS0RwVlBWYlpoY2JWQ0JZ?=
 =?utf-8?B?KytZYUxGWC84K2NudmFGQ2tFMHRXMWVpbGl5L0oyZDJLRW95aGJxOFZUYm9j?=
 =?utf-8?B?NkRvdTF3ZnRiVHZidnkzWHExSldiOVVsVVJXbzhxWTZLOXNnKzJqekJrVTM4?=
 =?utf-8?B?WEdKWkdKMUdyOFNKU2Z0U1hoWmZUcU4wY2xOWW82SThYamFJN28yVzRvaGpK?=
 =?utf-8?B?akpXSzAxVmtYOXpBNHUvQ3kyWU5iWk1NejRQWUlFdm9VNUhYYmZDUmNmSEhM?=
 =?utf-8?B?N2VFc2pZaTAwb3MvRDJUY1pnRFJ5bnpEOHlZTDdXeWlzTFd6RjBrcVdJMjFx?=
 =?utf-8?B?b1BiQlpPOGw5OFcwckMzQmhTdURzNjhlMVgyTHhGRlV0RjdPdHEvWUo2RW5h?=
 =?utf-8?B?c1c3dlhYRDBoM0dLcWFrb0tFMVZCQ0ErTDdxUk1JdDZ3di9nQzFqOTRkWW0v?=
 =?utf-8?B?VG50c3B1enZ4cFEvNXRqbVYwVkxPSzFJKy9STkZLWDZya0k0bzJDeXVFOUh2?=
 =?utf-8?B?Z0llRjljM1FDVittdDFIeW03eTBvVWsvd01IdVZaVzJrNE52U2UyY0syc0p2?=
 =?utf-8?B?d1hkcnp1NWUvSzhpOUxOSmEwR281N001dzBpU0ZZSC9jMDNIVWQ4RllYVlpK?=
 =?utf-8?B?QXpjdTg4SC83bDR0cm5TK1JBak1rNzV4N25ZeE5GTWdLM09TVW05U0FLenh6?=
 =?utf-8?B?TGltUWg3Smg0OVJuUjQ2WmJuNEQvNm9JUU5FVmk4U0NDZTdVZjBJLzBBSW9Z?=
 =?utf-8?B?Q1ZObytMTU1KUGt5MFdNT1VHaDJGZzE5V0YwdFIyb2VHRXV6MVVsNFZTbm5p?=
 =?utf-8?B?VmUrbWFCWlB4cEJKMnhWemNBQm9JZE5ObklMWkpsVHdqSVZYNEF1N2ljY1ZV?=
 =?utf-8?B?TW44enNIL1RHcTRHdGtzaFkvOERJMUNDcDVZK1l3bUdMNDFkUHVHUDdDbndw?=
 =?utf-8?B?VlYreWdtbndXd3B3UUlQZ2NBZ3BrS0VhRjFGcHNsRVJHeXc2U1VRU0RIMmVC?=
 =?utf-8?Q?+Rl+xI8YG+6skIbzOfzdr3a1butXFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVpeThKMldrRExTRi8yWW9Ub0ZEWlhYMzFQVmdRWnJiNG9DaS9TS01iQWN0?=
 =?utf-8?B?WWwyZmZzS0hzdGgzZXk4SUhxZXVlZkNvNnRMNEhra3drZENGN054SnhuR1dr?=
 =?utf-8?B?eUtFOWlPUlVnZ0U0UTFqL3hHaGxZSHRDdXJ4Y1dmbmpBRE8xb3dLZ2F3S250?=
 =?utf-8?B?MzAzZnNHdnRKd2E2eGxCSkg5SDhmMnVRdEVZL29ENE81RXB0RElvYWw3NjNW?=
 =?utf-8?B?dzcvb0ZwY05hSFQ3ZzVuTnBVN000VkFVSEd6Yi9PczJBUWJwZnBXc3EzNXVX?=
 =?utf-8?B?Y3dvSkRLai9pMnNPWWpPajFGSG9MVlVOY3gwcm9Bb3FHd0F1WWhlTFhVSis5?=
 =?utf-8?B?S3RkcnovYm9vU2NiY1FHOGIrZW5kOXFDNTZyMk9kTjVzbU1aWHJZYVZXWXBn?=
 =?utf-8?B?WTl3V3F3RWp1R1NiOUdPanVLY2VJbS9maWVnMU9QME9yUDZBend3S3VIaTFQ?=
 =?utf-8?B?QmJHUk9BSEJXTytkSlhaam5yVm11TWJQMUVIZjJCb0ZyYjJWU1hDcDQ3T2RN?=
 =?utf-8?B?OU5WQ0FkdVI0S3k4b3g0QnpsUWp2SWo5TlU2S3daUFZYTi9KbXc4SFBzVG8z?=
 =?utf-8?B?U3RtSDRNQW4ySHpGVjVxMTF1emNaWEo3Rzd4SDJLd1oyd1NiLzR3Rzlnejgv?=
 =?utf-8?B?eUFXYU9ublkzTkdyR3h0MmlQRk9ZNS9OWXlNRjVKUlhiYTZjbGxxVjJXcXVi?=
 =?utf-8?B?RW5NeW5QVjNPdHJQUFhsKzdsejl4Z2tVL0ZHQkhLdFVnKzJHTTc1VEpaNlhX?=
 =?utf-8?B?WXArbjNRbk85Yk9HR1U3b3BkWWFpOVA2djBPVWhhRTVmQTdzR0JhSkVsaWFj?=
 =?utf-8?B?a2RHR1o0dnFwUmxEaXZ2VnN6bVd2bGFFWkNMMmwrblFpaWJ3L0lDdERhdkR4?=
 =?utf-8?B?Q25sQ0RLWmx0U2k1dHpqbWZCNXZxVis1dXg0ZkVycWZwUXVKWkdTSVVab0Z2?=
 =?utf-8?B?VHJacUxHcTFDN3g3WmMyTW9lazJGTHJvSnpuWHFOYkhJeU1WdTkzaXA4clBy?=
 =?utf-8?B?ampYVDBXZkVLZktBeUlBa05rY2VEQU1pWWlUMU15NFlmaDFURitsdW53Ly83?=
 =?utf-8?B?SDFVMGlBNmVvRy9nZy81VDR3ekJCNzZHM3U3TEpEaUkxUE8zQkFYRUZBdnBV?=
 =?utf-8?B?Zy9zdGFQQ29sNXdyTGxYa0NYOEdVcVBPMGNIYWpNbE1ZVjZTT2p5Mk9iNzVv?=
 =?utf-8?B?QWtLUzZURVZyeEpIZk8xejVzR3hqcGtOaWFnNGc0NnRFVTRtSmIvMktVTGxn?=
 =?utf-8?B?VmRFVHRWbnhoaWRlT0FnQ1VrK09JS2hRT294SUZ1cGUxdlYxQktrQXQ0OWFz?=
 =?utf-8?B?YlNwS2ZSN0Q3cWFwZjcwQUFjQ3J6MlJON2JydG16Smd3amErbFNLUXpyVEs4?=
 =?utf-8?B?SitJa2JscmtmekJMT1lDSG56dzZ0NmhIM2lRa3IxZisydWEwL1lsMy9TdlY5?=
 =?utf-8?B?T05QVVVTTmFTKzNtNXJ2a2Q3dkNtdkJxVUVKVllSbjhqOTVhQ0VDd0dNRFZW?=
 =?utf-8?B?NmZ3c0htOTVOaFBLYS9PS3B4UmxWd2lWR2d4N2tLeGhCTlRUb0FpZFowTk12?=
 =?utf-8?B?c3p4Rlowc3NVck1SWDVWRjhnejBWQkNSSE5ET1pBN0hjTG91UkFaYnQvR0dD?=
 =?utf-8?B?cTBuUGVFbGQ5YjJHMlRXM0xMMXQxYkZWNTI0Q2JBREcwUmxNUTlHZ0FIbUhl?=
 =?utf-8?B?dFMxOU5vVEZYSmRtczhIMG9sTDFJOWNtcGYybXgwYzJEbFMraTZaTTN4OFlH?=
 =?utf-8?B?MVdFUDgwT1dhQXRnSHBsQ2oxS3RoVUY1Y2RORnJaWitDaTBaSk16VDcxODJW?=
 =?utf-8?B?QjhEN0libXJpZzQveUV1eExyMlBrZzRCbTgwWTZaTm9pYWNKUGdWVVF1NW1Q?=
 =?utf-8?B?eE56UVdRVWFNRnVobG1zaVFLekNQVFVyekljVXIrenBIdEtWaHcyeDR4WGt0?=
 =?utf-8?B?dWpWTUphM2g4R3h4MFVuVGJJNmh0SmhsWUNKcjBPVzVjN1pwSFkrOGFLZDJp?=
 =?utf-8?B?VEtxT0pOZHRIWlNnbVFUZisyS3RqSGxZclAvMmIySE5DVTRXUnJ2bGdaaWY5?=
 =?utf-8?B?UjFlTVJ1OEFid0lUdDZMNzJvc2luaklWNktra1ZueGNERnNyWU55RHFvdGhj?=
 =?utf-8?Q?pOo227XDOtUrwqMVE4heZ80b2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fca7067-10e8-4d06-e04b-08dd78a30e08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:27.2853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao/ClWWHfkTZfQqZ2iT/x5oQLvomRGHg4LHmxe/CFVbByGYnwEuNmoqO3RKnDtJwoRYcodFCwn901Y99QLPiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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


On Tue, 14 Jan 2025 20:07:36 -0600, Tom Rini wrote:
> The option MMC_SDHCI_ADMA_FORCE_32BIT is only tested or used when
> MMC_SDHCI_ADMA or SPL_MMC_SDHCI_ADMA is enabled. And for
> MMC_SDHCI_ADMA_64BIT the same is true except we also require
> MMC_SDHCI_ADMA_FORCE_32BIT to be disabled.
> 
> 

Applied, thanks!

[1/1] mmc: Kconfig: Correct dependencies SDHCI ADMA options
      commit: 53bb8fdea12a346ceda1ac109ebb05d2c9625e5d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
