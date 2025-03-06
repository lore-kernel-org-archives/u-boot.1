Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796C7C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24D680E94;
	Thu,  6 Mar 2025 18:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GyRO9iGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511E580E94; Thu,  6 Mar 2025 18:40:41 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5C9805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 18:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUocrNIPxdDDc8QtBLV+lYPZJ+QNPDuBkixnMaprL3Cuo2MPe3gcfbbBcfvJyy/2rQEN32gI9uoOSUBqds2cXIXdATZnvI7tVaThzK8KE94CiEYo6WB6IPDbmZ/PSqX/EU6v9SEIgjt2+zgrjRrpOG67ROZ/7tEUX1MdZd+cxzYATwQ5El85jPCkAjQStx4gPT9KnBnpdK6Hts+j8i8HL11l5NshrHZOk9lxXp34GUHw6reiaQv0t7CydB8AXdZNNO4ioUMiYsyzV43eXovvtAQyTAaRYri6DrDq3F+KSV82RGMalZelu3s8i6wClr8QTHh5mv0mAcSTeK6pKf7uFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLvu9IsWmHz6RCC40c9T9zx7PmpNeEDJxUdi4Q8Btg8=;
 b=tmHnWyloEhuH9ea5g9DVV9tRUYXJzTIDUDaGZZZahNyCog22kHYFfSwLv0N5x03xDPZxRJ6ywo0AP8V8hh5yJmB58dtB0mOeGNC390xO0aI+tm9pE2F+8Gtp8n1eFrSKSCfyuUr17treNIzV1DOLhemqH4aAMP0l0ld+zrdsE04cWLvwLGYZWjyWkVGRB7hxhHiidBIknX/8vjLVMEt2i/l33FrbpoMPJ+EEdLrm/sCSvaPyt69VQBUWPukYVdC8dQ0Pg+bcU5X6rkEyJQlO1GBnCTcvnqu2kIW6bAsNtxNrTZP9AaLjVvu+TXlhNbQHWvwK/to4TRMfUblGRbKjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLvu9IsWmHz6RCC40c9T9zx7PmpNeEDJxUdi4Q8Btg8=;
 b=GyRO9iGbfDxih39FZdlahNW4UQWKAx6+6WIwEXO5MJupmdOWW+bT1nUgKVyvr0dLwIlweP8ZilksDuPkD9lMXSMidLo3dJi4S6sQysvf0sY7CbHxGyA6EQv2tu4bPQVYaxqnY/F5ZR3TEBJjT8upSG4Lpmz+zE4fg8H9i2qIEuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11168.eurprd04.prod.outlook.com (2603:10a6:150:278::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 17:40:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:40:35 +0000
Message-ID: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
Date: Thu, 6 Mar 2025 18:40:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
To: Hendrik Donner <hd@os-cillation.de>, u-boot@lists.denx.de
Cc: Oliver Graute <oliver.graute@kococonnector.com>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Prasad Kummari <prasad.kummari@amd.com>, Fabio Estevam <festevam@gmail.com>
References: <20250305183544.40525-1-hd@os-cillation.de>
 <20250305183544.40525-3-hd@os-cillation.de>
 <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
 <edbda604-e8f8-4f4c-b506-2dfb528fe10d@os-cillation.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <edbda604-e8f8-4f4c-b506-2dfb528fe10d@os-cillation.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11168:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d46ee0-9acc-4e5e-1b60-08dd5cd5fff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0ZXeVdGTmJzVWFsYzI5RDdxMDJEeUV2WnRMSVRoSHFlK1pzeFJCVC9qcFVn?=
 =?utf-8?B?TUNUQmJHaUh2ZVhaQWhQdUtJdWR5WGJLakExbnlCM2xVZ0l6WmJsVFNVZFB1?=
 =?utf-8?B?bzBON0laNXo0aERKSVBuQ3A2MVc3M2RFNy9BWkhIM2ZXaUFjbUhRMzJCZjJM?=
 =?utf-8?B?Q3RRUVdTNHZnTXI5cGxCZ3F0Wkg4ZVVob2J5WHh1amxzNXh0VVoxcjF4WlZy?=
 =?utf-8?B?KzRTR3Y2UUdMOHh4LzVDM3UxeXRaNDZRMUN6VXlCc1VlWkduSkRYODJXd3F3?=
 =?utf-8?B?d2lMTEJvWDkvVXhOcm9WUUpQMG1HNTdsaVFGMUZDV3pLN1VSeVFMa2EvQmU1?=
 =?utf-8?B?aHF5ekJrY2IxendvSndrSnVnUjlWVjI4NmRQN1o1RFNkanFIVDE5SjI4cFFl?=
 =?utf-8?B?MjRpUUZRTzFna2l3b3BLeEowbWNHZldmb25Sek5BQmFMU3J3S0Rzc2NhY0FS?=
 =?utf-8?B?VDZNak1WQU1HTkRsdlF0aFljWkREaVMvS016dllwSG5WcUNaVk1lbGlHMDJQ?=
 =?utf-8?B?S2VVTXVRdmFORSs4b0I3NnJ3RnYvelBvRjhhY2o5Tm8xL01YKy80dU1iK2Fn?=
 =?utf-8?B?RGZ6RThpYmY5YUp0OWdBRFF6eXVNaVJaK0FQSXVSQzd3TWdmdDg1UWVuZ3Vw?=
 =?utf-8?B?SWwydjJ0azVLL2VYMU4zcFdWaVhtaW5JWmN1RWlqRmxjTEMxTkZhSEJGVGRF?=
 =?utf-8?B?MVFEd2JPWitScDdCMTUycXYwdm8wRnNtV0ZzbHdsbVg4S2JPY2x3UG1hWWdD?=
 =?utf-8?B?Tk15OFVSZ0hyY1czTzN6MFBzL1VGOXVZTmlXTTUxZ2JEK3dEZGhKdGpPL1l0?=
 =?utf-8?B?d0JUOTFLejRGSDl3T0k4ckxrQkNvNkFXNFVXbHh2RkVHTlFZZ0t2TVNPZXU2?=
 =?utf-8?B?NlVzZUJDWnZhY0h6eGk0WnFqUnc5dzQxVXZQL0RvS0lwU2NZcmUvU2VHYWgv?=
 =?utf-8?B?TmdvRGZKc1pacldJUHRrek4vbnJMd3RDTTIyeldld0Nhb0dyUUl3ZXNYYno5?=
 =?utf-8?B?ZGhkWURjMkw4alVraCt0Sy9XU09vbFE4b0pveStWSU1RenU4VHZWN3pqREpH?=
 =?utf-8?B?eTRGcWlDSWRLY2FlMWhyV2RPSGlXMGErQXN6Mjd2Nlo2QVh6bHNSSHVNMEJw?=
 =?utf-8?B?Tjl0TVhncjVpcE5OaDNRSlhkaWVmZjJac2NMWEhsK3BUZG9mbzZsY3lnNml0?=
 =?utf-8?B?bUVsd3hDNFk3Mk1tOWhpUnI2azZ4WVVSeTQvQmNPbXFHd2R2Ry9BU1paRWFI?=
 =?utf-8?B?R3dmZG9lZUVWSkRUVjhndTNNREVTVWUrdDhXbWNxQUdkbGpQNUxzOTA4R2k5?=
 =?utf-8?B?cDU4aVFOT2lXRHpPY1pKTXdWK0hrWEN2UHRVbnBzb25xOVRDTkxwa3VJWTNq?=
 =?utf-8?B?L0FabzJIRmhkd2xQL1pQNHhURXMzYmMwajFYbTRoZTNhRTkzdWQ3M0dZcXFl?=
 =?utf-8?B?Z2hxTW1HTmdOY2lpL1RpR0hKc3NhdnJkZndTbzYrV252ZXBmQkFkVVdlSmtx?=
 =?utf-8?B?MHNSMExYcGkrOVVlSk5FeHBqeC9vOXRnbFY3WlNNcGw1SHZIdVprWkFUVVhD?=
 =?utf-8?B?VThSVHFDeWlwSS9xTHp5MVUzempVUkc0NXlmUVV2WUJ1Q1lCVUhhajlvWllz?=
 =?utf-8?B?UEd4ZjVDYU5UNEZOTmJyQUo3QXRCSDdGN0xxQ3Q5cUp5SHpaZURhQUt3MU5K?=
 =?utf-8?B?YTd6UWtuTUJvNFd6Z1RBSnNmYW1JR1lpSzd1eTZyWWd5b3lMN3VWNm1VTGZL?=
 =?utf-8?B?RnFvQllOZ0VVdXp1ZVlZYThRVkt0VmRIZ2hJcE9UeXJMT3BsWm1COVVnNHRh?=
 =?utf-8?B?OGlkUTkvUFRHeHpESHhnMDBwdXd6dGI4QkE2K0hmT2l3a2VCT1dvc1lNWnBT?=
 =?utf-8?Q?M/KRxQVbgBQyu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFxVDE4OWFJRUpXdmhjTXA1SVNSTDR6Ym1kNTY3UDdleTlZWkZZKytiS2Ji?=
 =?utf-8?B?MU44RWxacG96aHpVTUllNTNyMzhjeVFCTjY2a1dQc3lqTi9RdUZSQXFDeUFY?=
 =?utf-8?B?K3gycUNYb0FxMFlZWWtGcUt5YmZMN2U1ODd2VzBOVXNVaEExYXc2bUUwUWo0?=
 =?utf-8?B?YUZKZi9FSTJ2cllXYituSy9yRStIR0NaS3FId0NlaXFGVzcrU0h2b1Q1amNw?=
 =?utf-8?B?YmJUOHphUTlvd216MlpXRHU3aDlEM3drckZKWUlyemZHdy9HTG5VRTMra01R?=
 =?utf-8?B?aS8xemlna2swL2t0akNJTlZYaGVnNkFrb004UERJbmZkQytZZ2VtbUZNcnJD?=
 =?utf-8?B?RVJmbjRWcEFYeFEvSXRYSk5rUDBTejJBaEtPbmVKdnMxSCtKbEQ4cm8zVFV2?=
 =?utf-8?B?MWZlbVFTNWwvYkEvaElGRnJKcW0wYy9VRXMvNFhjd0F0bFF1aGZsREhkUjVT?=
 =?utf-8?B?WGVLdFRicXRnN0NUNVZ4TzR6L3VQOXlhT1BEKzhxL0JkeENJT3NGWDQzNXh1?=
 =?utf-8?B?M3hRd1Zjc1J1d0gwcmRYOXJhSFQ0MWZBUkZxc21PRE15U0EzOEN5RC9FbGtU?=
 =?utf-8?B?YTB3TlhjYnl6VFVvZUdDNytHdnVYVklXS1JVNVVxY1JiM01tcTlBN3hQNXBM?=
 =?utf-8?B?cVlaNDJydmVUa1JUQXZuNEJtUVFRM3YrdnZqaWd1U2RBTXZGekhPcjAwN1lW?=
 =?utf-8?B?S1RTbG9tTm5ra3pTUlhEMHU3UW5SWEZTUWtyZ3FLSGFDU3BtL1B1bmJHK2pl?=
 =?utf-8?B?ZWJpR3hobUhwN3dURE1oRGg5d0F2TWpUeEd3SjJQQ0JXdmFHMFJqS1J1T2Z3?=
 =?utf-8?B?NGg3NnQzZUdyQTNCTVpMaTNraUR3QkUvU0xpNmZmaUdxYlMrazJyV1VRbHNr?=
 =?utf-8?B?aUhmeFUrZHNNWjlJanVsMDdiWDkxMmRVY25UMDVLUS8vdWx0Q0paclJQY1I0?=
 =?utf-8?B?NWNkRFkrYmRxc2lPaEJLdFB0dGxzWGdHcDY0cHE5QXhLeDFFWm5BM0pwekQ2?=
 =?utf-8?B?dGxxbEY5VXZPTnJNZUg4VzRUOExpcHJmSmNRdzRTbzY5OFBybkZIcE1oVmFU?=
 =?utf-8?B?S2s1NjdnOGhzQ2ZJbC9vUkljZEU1RWJ1YUZITHhhVUdMenQ1eE13MDJBRTlQ?=
 =?utf-8?B?TjBwZWZ4SEhXVUd1dUU0d3NYZ3ZhSTNBWlpmMG8zNkMzM3RTclhLV3RjSm5y?=
 =?utf-8?B?WGVjMUhsbEVFNkZ3TTRxQlc1cjNiU29CSUl5eTdkSVpZeWx3N2k4UDdLNzlE?=
 =?utf-8?B?TjVHdStNUGw2eVNBNU1VejR3RXdoU3BqWGVxUm1YNXFjVDZ6VjQ5NnBxUUtK?=
 =?utf-8?B?UXc2dFBxa0NFOERrU1JNaUkxblk0eFBpZkNhcUJoUFhzV2xRYllTbFZaQ0Vo?=
 =?utf-8?B?N0hRVnpacGlnZ3YwMW5tZTFBSDBFZ3BnbHZmN25VK2NBTlBQNXIwTkc1czU1?=
 =?utf-8?B?STZ1d0t2ZU53cWlpa1dVbEFGeGFVQTY0QURWVmlrc3MzcmVhaWYwN1RFQndp?=
 =?utf-8?B?YVdwYTVXM1Z4TEVNK25VazhmMElTS05NZ0x2K2N3L0VYTFU5eEp6WHl2T2p0?=
 =?utf-8?B?TW44blNkWmRjSjBGOHZSVnI4MjNRaFRvTEprY1B2Z01Wc2JKNzZMWUJLWXV4?=
 =?utf-8?B?Q0VPMnF0MUlTTlNleUFxR2FLUmdaMG5WNjJ0SUUyR3lyS3FWeldzMFc2bmYw?=
 =?utf-8?B?bGs0TmJwNkdsekc3dEdlMnZOV2xrekZ6amZta3ZEVmxnWk9tR1FTWklKZ0xG?=
 =?utf-8?B?ZGd3T3pHSUpMeStVQ3ZFaEVRdlgwREc0NG9EWGd4WStoQTdvSTEyOUEzcktj?=
 =?utf-8?B?ZmtnSWIyUmpYU2xLdEtoMWRKTEY4WWFxSXBTdTRYbGxsQmVmRUxRcUJWOEE0?=
 =?utf-8?B?Y2g4RlM3Tmlya1MvWGtWMWJadDF5bUxjMjI2Y1NjeUs3V2F2RUp5aFh6cDA5?=
 =?utf-8?B?YndhTmNmcXFEVHY4MmJ1bjJBcUVYWGh6S3lYWWZldytKbiswTEpwVkFxR3RL?=
 =?utf-8?B?TGVKaFduWFVPdlN6cnlJSzdENG5QK2d5RCsrUUg4NVdFOWcrUlVHVXVtNk9i?=
 =?utf-8?B?Q2c2SFpoWStxcDBTTkVpYVRNZWF2b3hBUGlwdUk0RVNiZS9SUEFjR1NXT3Fw?=
 =?utf-8?B?TGsxbWRrNllIZVB4MnRUc2NtQ1BERG83RGNKVzErS09LeFpZcW5DWXZvTnRG?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d46ee0-9acc-4e5e-1b60-08dd5cd5fff0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:40:34.9887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg04cFz3Rsy4V4Cyp6qKshjmRbZlpPMsXNMBsUWjthBuWM1+lHWTdDQ6wf0JA+jsHHyA5zrkB0srUi8ND72qm01jRIslwK9YdRBCgtP8lY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11168
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

Hi Hendrik,

On 3/6/25 5:28 PM, Hendrik Donner wrote:
> [You don't often get email from hd@os-cillation.de. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello,
> 
> On 06.03.25 11:18, Quentin Schulz wrote:
>> Hi Hendrik,
>>
>> On 3/5/25 7:35 PM, Hendrik Donner wrote:
>>> [You don't often get email from hd@os-cillation.de. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> The CONFIG_*PL_BUILD defines are currently not defined when
>>> preprocessing the dts files, leading to build problems with binman. Set
>>> the defines based on the related CONFIG_*PL values.
>>>
>>> Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
>>
>> Please have this person publicly answer they tested it instead of having
>> it already in the v1 of the patch, too easy to impersonate someone and
>> give a false sense of trust into a patch that may not actually have been
>> tested.
>>
>>> Signed-off-by: Hendrik Donner <hd@os-cillation.de>
>>> ---
>>>   scripts/Makefile.lib | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index 54403040f00..dd2c6363224 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -217,6 +217,16 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -
>>> nostdinc                    \
>>>                   -
>>> D__ASSEMBLY__                                          \
>>>                   -undef -D__DTS__
>>>
>>> +ifeq ($(CONFIG_SPL),y)
>>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_SPL_BUILD
>>> +endif
>>> +ifeq ($(CONFIG_TPL),y)
>>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_TPL_BUILD
>>> +endif
>>> +ifeq ($(CONFIG_VPL),y)
>>> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_VPL_BUILD
>>> +endif
>>> +
>>
>> You don't actually explain what you're trying to fix here and why this
>> fixes it?
>>
>> Why would you need those symbols for the DT?
>>
> 
> well they are already in use in tree ([1], [2]), which breaks the build.
> 
> The history of both files is that the guards were introduced as
> CONFIG_SPL, which builds, to CONFIG_SPL_BUILD, which should break the
> build, haven't tested, and somewhat recently to CONFIG_XPL_BUILD,
> which is when i noticed that it breaks the build for me.
> 
> Now the guards are around SPL specific nodes, so i didn't question it.
> My understanding was that those are needed not necessarily during the
> SPL phase, but only if SPL is defined at all.
> 
> If i understand you correctly none of it should have been introduced
> like that in the first place?
> 

Yes. I believe we should keep CONFIG_SPL in there and not CONFIG_XPL_BUILD.

+Cc Fabio as author of the (assumed) breaking commit.

As far as I can tell, it's because the mkimage used in the 
/binman/spl/mkimage node expects the same external blob as 
/binman/itb/fit/images/seco, named mx8qm-ahab-container.img.

If you do

dd if=/dev/zero of=mx8qm-ahab-container.img count=1

and recompile, then it fails a bit later on with:

```
binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n 
spl/u-boot-spl.cfgout -T imx8image -e 0x100000 
./mkimage-out.spl.mkimage': parsing spl/u-boot-spl.cfgout
New Container: 	0
CONTAINER Sector size:	00000400
CONTAINER FUSE VERSION:	0x00
CONTAINER SW VERSION:	0x0000
Platform:	i.MX8QM B0
Failure Read header 0
```

which I assume is expected.

This file seems to be required because of its presence in some 
IMX_CONFIG script? Is it actually required? Maybe we should make it 
optional (at least for the seco node, that shouldn't be too difficult by 
adding "optional;" in it?).

I assume a probably more proper way to handle that would also be to 
migrate the script handling IMX_CONFIG into full binman with a new 
`entry` instead of relying on mkimage to find the dependencies and all?

> I noticed it's broken in the uboot CI run too, but since the boards
> need firmware blobs the CI build is erroring out in the first place, so
> i guess no one noticed.
> 

c9713c155127 ("imx8-u-boot: Fix SPL guard option") essentially entirely 
removed the code block as you discovered. So yes, the error isn't here 
anymore, because the code isn't run anymore.

>> For removing nodes in xPL, you can use one of the bootph- properties.
>>
>> The DT is supposed to represent the HW, so having a different DT between
>> stages is very likely wrong. Note that having a subset of the full DT in
>> xPL stages is a bit of an exception here, for size purposes (usually
>> because of limited SRAM) or boot time purposes (you don't need to enable
>> everything in the DT in the first stage after BootROM simply to init
>> UART and DRAM :) ).
>>
>> As for binman, why would it even need to be run during the xPL build
>> stages? Can you provide more context on this?
>>
>> We have some big nasty ifdefery in arch/arm/dts/rockchip-u-boot.dtsi for
>> example, which has some logic on whether some symbols are defined, but
>> they are defined regardless of the stage and I assume binman gets run
>> only once, and not in xPL build phase? Is this something not applicable
>> for (I assume that's the user of that) imx8?
> 
> The arch/arm/dts/rockchip-u-boot.dtsi ifdefery is based directly on
> CONFIG_SPL, not CONFIG_SPL_BUILD nor CONFIG_XPL_BUILD, so maybe the 2
> dtsi i mentioned should have kept using CONFIG_SPL in the first place.
> 
> So move those back to using CONFIG_SPL?
> 

I believe so, but maybe some more work is needed? At the very least for 
the CI, no clue what this external blob is, how you generate it or get it.

Cheers,
Quentin
