Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62970CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C6E846D3;
	Tue, 26 May 2026 14:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="LmR134IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EF9846FA; Tue, 26 May 2026 14:52:48 +0200 (CEST)
Received: from outbound-ip199a.ess.barracuda.com
 (outbound-ip199a.ess.barracuda.com [209.222.82.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD96846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020113.outbound.protection.outlook.com [52.101.61.113])
 by mx-outbound10-78.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 May 2026 12:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWAXZOArx7IhAkmol0G8+UpWsOLlkiWWzSvumWcHqPu4ED4EejOOwpN3IO5B8D+3AomQ8VKotpQUgKfyxvLPsbq+4vb46ZsA1TLTsa6Ro/Q0wgK2Dwx+UUy9KVokMr14pbDhghMJDj8K7rEmOrKjC7OSuCrDJ62dy4d4OIbJopAlFvDvKnhf96iNSQQnTVU3wkSy2aSEmg6WmYadU/lznLyaKV5cYvLwIHPWIuu2zKaZr00lSto+K6NHXOlY8lG/cNwT5Tr6LopflSFR4yqm2LrRKcpErqQXAped9CIp+pCoiZUTHJRg67E9u0Vhvho9SWFYSh7Kt2GmSWLLmwvsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ELuHj8wbayb0yLKdbCjH2MEPO7tetXfCtz7E0vKMj0=;
 b=DeAp2coXCa8tobpL9e/jMMnume3YSiJzfQhjGdTmgIhAi+2RUZma0IOswyChpiX9I3D0cpSVU2LpuH/JX+MVH8s7mI0wesq7aLBp/VB8MP93z8+/9LCkq1wASXMyakCGt8tw4jjyXarKVNnNbPbzRBp2GIpEMzmAhgx/L8rz7iQ9RzZMa92J0dWoBCkIFMjWrKfvPe91cw3bCMebq55ZmMBsL6H4O4Tkbf0qJla3plkzdf0mbzEVs8NmMizbbV3C9s60YKmp37/ghACQzVnzaR4GE/qyzqCy3XnD3njS3jw9Ei5RoQK6lNECQz7SUl0AVNPuye6qRRg9uma7DJ0DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ELuHj8wbayb0yLKdbCjH2MEPO7tetXfCtz7E0vKMj0=;
 b=LmR134IRbrrt1SRzFDum+sLTTkiP2Ev4DLiNjfhuZHhrP74LRhJMnnhknvFTYfA5f6ez7fuWgE/60y8ropSJxmNqXPM0hSHp7ln+Pu2cbgrsbk5c+CHAdfKhpBQriw45sMYOsq0v2aAo6kevoyKhxKF4LMZ9mlcS6Lqe0lSWbI7Tcj3BgvE0f/Hgw41z6ihCqM5y+FTtsW3D18gEfhiiY5f8xImRj8FaTHQyxv53TcifZ9mz8vRuXEpcgQDq/fTmkb1cyYCN1A33hp/O/fbTuEtc9RHPu6Fa3ZFeq1i0+Iv0yDvfjYAWU2LMedA6zHKP0vJjtpUgmGJyY2D2PItAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by BL3PR10MB6092.namprd10.prod.outlook.com (2603:10b6:208:3b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 12:52:40 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 12:52:40 +0000
Message-ID: <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
Date: Tue, 26 May 2026 14:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
To: u-boot@lists.denx.de
References: <20260521165122.17475-1-josh2@disroot.org>
Content-Language: en-US, es-ES
From: Javier Viguera <javier.viguera@digi.com>
In-Reply-To: <20260521165122.17475-1-josh2@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|BL3PR10MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5420b241-ce7b-4e2c-db66-08debb25abca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: GAV3EPCBc8RvNFq0o4NxvjpQ5YCS8N6QeWl/H1LfxWATgezg3wWo0P4NNoPLUUJB594LV3xnxlFJvBwaWvC1ISi+00gVAuOXXlNP5RjPd8WQ200IwKrcGBQoxF7zvlV/VftfL5VDnIAKDdMsolGKPcm5wFgk5MhssYKJH6Dcb4HbQLcoDqq4rf4lC+tmfuAbf/A+X6npm2kq7WByI9MK74pgq3+VjWofTF5WndCwuwLx6m58As7ZR9cBMgZV0xJfpw8XRgjC6AtosSfgXDDCyI8IZbbc7u+04rnoWaTeIm50taIAKAz5D25MBOPNu8NkLeCFeDyzm0CXnCNNVC/iRgrC3QtviuwTwfKo2BSZAMaZDMccRbMx90DMQexRtIvcaUDTBevjckHynSrsUPoCZrEUNzgwJQMv6pfoV4jQHhh1Li9RNjNmVd6p4QN3ahSVWBempmlOBE2hgAf1skvo/fahMC91QtuK869+GqXvlOxDw+337MbiNzWuedqIBJkuioqDcpcbKcJED0qo+2pmx7qBtiEi0O49j1lTY58x7js03e0cTlxLF2DUpnXOJq8XUTXkWAG2WNCxxmZlscVDAUDt2d4dxovHuzZ++6slobu28hTCvOJ9mA7330IsrkIaPU2vHy3GObs9E/Ac9KafucNllCxMmp4AjYQ/P+f3eWKEolgWIM9JC6E8DCDYgfIup4kzr1C9V1ouqomLFCsmXdRTFtSTcZ3iI2HjFkGRpjmaWVz/VkGUvlm8C2d0zSxj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJYcEgxU0NIUTVJVWlJNXVLcWZ6bnc2SDVNWFVkL3FiMXNwK3g3NE00M1N1?=
 =?utf-8?B?UzVvV0pHaG8xdVpzZmZZT0V1Y0FCNEpBbnhBSXc0YzRBUmZDdWM4T1lmL0lP?=
 =?utf-8?B?cHQxS0Y3cFZ2bDNrL2V1S2JvSkV5a29FcW5Jd01NUlBrNFFWZTU0U0tubDFx?=
 =?utf-8?B?UFovOUlEc2l3dk1zRWlOSWFlM1NBOVVmQ1Y5RWFYWlBqQUUxVm55WlF2RGo5?=
 =?utf-8?B?dklKN1JJMzhRYVlTczFPUGJYMGVPdkUrMTJPN0VUWVprc1VXcFNsemR0VkRv?=
 =?utf-8?B?WVdPMVl1VHp5UGxZVzM0R3BEdWdGYkt3NC82Mml0cDBMaFhDbGE0cDNPUU9X?=
 =?utf-8?B?OXJwc0oyenlRMTBkZGlOMkp2b2ozSzNPbm9ZUVg5ajZVM2lRaVcvcE5HRVhu?=
 =?utf-8?B?YkpPV3U0ckNLQ1ZLZU5lMEliY3lHQkl4a25YZGNzWkxRM3FXdm05UWFYZG1r?=
 =?utf-8?B?YkJrZmlZeWJhS0FsU3QzV292aFhoR2l0S21JYTMxM0dYNUZqOUVGUVZHWFFm?=
 =?utf-8?B?ZDJocU14OU9vUzBrK0RQNHErcEJ1QmhSMVc5Wm1zejhBNVhiV01qdXVGOEZ2?=
 =?utf-8?B?b0lJMmJqc1MvYVA5ZG85OTZuS0NOYzQxVTZzSU5IWUhML1A1UjhYaUd2and0?=
 =?utf-8?B?STJtWkR2RkdlTTRNalNMbVdDc0daTGhPZkZrOEQ0bjdiSU8xVEthRCttY254?=
 =?utf-8?B?akdnSkdCYU1ZWnE3U0FaNDJGamcrcGk0VUNvZ05OOXgzZkdmMFA4RFBlS2J4?=
 =?utf-8?B?MERZTjF6U0IzSmp4TDZwbkxGSkFYUGNlOEhSTlg5cWdFL285ODNxOGhiNElI?=
 =?utf-8?B?Zm8yZ3VhUktWd2xkZXJiNktmbmhMY2ZDMHIwaVhuZWw2ZVJic0lkTVNyK28z?=
 =?utf-8?B?OGlJekxHaVpuUWVIRmE0cEtZK3NCMWJ0R0RYSFc1NjFsVEpyelBkeDJwNkRU?=
 =?utf-8?B?UUJhVERKdFN0Vi9TWHVIRXhDdS81VGo2L1BJY1grZjFzRlZrMWRoTldVRysv?=
 =?utf-8?B?ay9jQ3J6ZW51VFhIU0VHZ2ZtWWN0ZnJpaWI2NmJIc3VSMTU0MzFwWEg0WTFu?=
 =?utf-8?B?NUY1T25YaUJWNW5kdkQ5SEJ2UnFMeVZhOGpuNEU3Q3EwNllxQUkzVnFqcmZU?=
 =?utf-8?B?dWtUMkZQdm1TcjM3SGt6SE1PVXdoaWRiVmJheEJidHozRjBEcGZhVHVVOTRZ?=
 =?utf-8?B?YWhOd09GajFkdDN3TDF2NUZ5VE9ibFJlbVlWSldTS0dDaW1ZWEhrQVRobHpB?=
 =?utf-8?B?U0xKZGtxZzdHVENkY0RPNnBTK2dqaWxWUlVvcmNad0laNmsvdUd3eUlzTzVV?=
 =?utf-8?B?cWpLNVFUMXhuZEpUbVREZm1RalVUQklCZVBVcVk0OVlmMEcxTnlRbndTQ2pG?=
 =?utf-8?B?SVlnbzkrcU9qOXFGZDZLaTg5OVNDUnMwM05RUE13OGJVV0tHcktSNGdYM2NG?=
 =?utf-8?B?UE9SbkY2QnVmUGNMYWRPZS9STmYvQ0VIQnkxTzhrMnpad0pZbXVlYjNUOFZN?=
 =?utf-8?B?MVF1a08wb1VZelhBaTl6ZWRiZFU0OTg0S1Z2RGFpemkzc256Z3F6ZzhBWDlL?=
 =?utf-8?B?Um9ha1pYYnVLUCtWTDZ6anFBZ0prMUtpMGR5REIvdHdrV2kvMDNvdzVCS2hK?=
 =?utf-8?B?S2lOT2pmUStIdXJvQzVydXA3Z0ZWUGhNdTc1SzhRbjVZT0REejdSMURDakRF?=
 =?utf-8?B?eFN4NUF2Snh1bVp1RDJyT0RHWWRlN1BpcVpRb3FaZThOS2dHenN6S3pIUmdt?=
 =?utf-8?B?MU5oOG1ERGdMUTRJemw0cW9zcWd6cVhZL3BYTEViMXRyeWpSMkdINHVCQTVF?=
 =?utf-8?B?RUQvcDV3TDdmTFYyVXJYZmJXQzFqelUwQnFlUnhlNFN6OThncTJpRHZwcjQ0?=
 =?utf-8?B?czhEWDE3RW4rZUM0Ni9hNWRzcXZVbU1pY21SeG1yektVd0hkTmovQU5zS3R2?=
 =?utf-8?B?WTJiLzJDL0p4ZENFSVJObGp5VTRnZVdHZzh4R3E3RnI5TXMvQ2U3NnJSWHZy?=
 =?utf-8?B?ZlVjWnlXc1hnbUFHYUUwcXBYc3FvRk1hS3VOT2orcGMzWGo4bXE4Wk15VjRQ?=
 =?utf-8?B?U1R2QnZXZG9CVFRzREdJWE9qbzRoc085amFKLzQ2d1E4K29KZEJEbVR2dWUy?=
 =?utf-8?B?WWp3N2thVWc0UmF6UE1Sc0ptc3N2T254VVF0akNPK2J6WmxHQXFOd0VLM013?=
 =?utf-8?B?aWhqQmZ4alpVYTBsR2FiSXdBQnZXOXdmbjlCL0RPenFLK3NrWkZmclRHQkwy?=
 =?utf-8?B?UVNVU3A0VmJHYU1qQ2JiaThWaGR5UXNZdlYxQVg4MDBvZU4vd3QxZDRkYzFM?=
 =?utf-8?B?S3VGUFNUSkN3dlkrUk55NUl3NTdkNTJsNmRjUmJyVXVITVBkODhDZz09?=
X-Exchange-RoutingPolicyChecked: HVHDcURPLNJsoC3/aVhXKGjlMSmr7bI+yNMQyxAhG8aKZe6ZhOqRTlx6dnP7ka/VrXcgCmiq++v0gPiOd94i2uk/8oDDVYadDwnGTwwtdnnYqmtrgdrRe5Llt8u5jfWqMFxmMZk29RJ/opS9LSOqNjcu2vT9IZ9XJY+gVWxo6a9q3xUWwPhMT5GW1XTuCJ34i6fvwlBA4qxd31ZBbwALHEiNVcJGBDcIsqWvyXRrv/omH4cxHgwxpr3EbvGyX+5fTEtNaIbtGNgvgypc47RGJDhpenfSHt3HWKFu+USnkh7kIbazdI5aiytwHAv0J2+xpj2Dvle6mJsq0QybAwTuEQ==
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5420b241-ce7b-4e2c-db66-08debb25abca
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 12:52:40.6912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drsQrfgWNMB+9gPOJP5w8fJ1Mobt/f5cmUtcjeWbfUVs/PROv8uSfsaz1ZNg2BLGA3kV82UHUlglW9mkdIAK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6092
X-BESS-ID: 1779799963-102638-7707-3830-1
X-BESS-VER: 2019.1_20260519.1529
X-BESS-Apparent-Source-IP: 52.101.61.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWhkBGBlDMMM3EwNjU0NjcKM
 Us2TzFwsTM0MDc2DDV3NLUwjDJwEypNhYAA4HNsUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.273465 [from 
 cloudscan18-212.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

On 5/21/26 18:51, Josh Law wrote:
> Hi folks,
> 
> Since I am a new contributor, I would like to introduce myself first. I
> am 15...
Wow, we have a "Benjamin Button" case here. I seem to remember he was 19 
in the kernel mailing list ... :shrug:

--
Javier Viguera
Digi International Inc.

