Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF678E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 18:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3638E80104;
	Fri, 13 Dec 2024 19:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WlKHCggJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC25E80137; Fri, 13 Dec 2024 19:08:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47104800D9
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nexjeG84OY93S/9T2dSt8tA4DwL547BPrMpOzmrELszYd8iHfLrNpb+KwY/cFBk8kJbJO8VDP/wiaxysb/69BmTzHGUXdZegnGK/VvtVE4M4cAoaPvKZpoFNnPCjlSoXXUm557sL8z1MCvaKoENp8w8+cwglFSml60oGoUbpiZ/uCUUspWmiFIipuyfPLET64Uuz0mimsuxVpxuByTzvB9fjDbZG1ZCdttq+l6Xuw2FEyZjwLxWEQkLNqU15jN1jM+lDC6y67REiiO9i01bnWybB5wBqMbuOkCmegU8v/gfwW6xTwwc+PF+2xQTkL17wZ4ZDAky5xZgx8bFhlfpt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX/K71iwBUeKuqksdViSUOF0he7NUAIInwBH5y78EIU=;
 b=cmnR3+ad2hJswFPSc9Gp2d/HWvCiwMQklV2D1Dx5gDJID8l7Necrcp8t/aWaM6PDbvXPbgs8kyrqjlMDVhq/Sk0fwwgjZEfMr4kiMJi32RxEg9JgkUNNeLw1W7SPchaa90ylGZSzJEPXX6Tg7sBhCZN6GVvARM9NtdTyjZIOGMMpZtUK4xbKso+RsDv0ie6KwR5emam+L+nVpXReyXo05Kl4Wd6xyhEkA70cpMuodIK/eGYV4T0bVmT/tLX7MjwxrHow8suTC9vaQd1I5OUN0DikGQOHNI2DRBITNsKJkMt9GU7GboboUld7dEMPlANlXMXnQLb41fDxw9//bPJ4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX/K71iwBUeKuqksdViSUOF0he7NUAIInwBH5y78EIU=;
 b=WlKHCggJbpX0FI6I0dtFCTp5G7nwBhEwkje39ePFceZBOVzazk3DuVG6w1X5QIdanQJWHiljJCMPoo1AXwUA/IPp96NVineOicO3iLJBOwZefy4cHSgVmO1gtAMJ5+BBQFGBSPQHfKFuNc5VPPHbt1zg12Vqk/NbMp0o/Ws58nQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GVXPR04MB10109.eurprd04.prod.outlook.com (2603:10a6:150:1b7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 18:08:20 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 18:08:20 +0000
Message-ID: <48defa98-9718-4997-86cb-b171187708a6@cherry.de>
Date: Fri, 13 Dec 2024 19:08:19 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: devicetree-spec@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RFC] Adding bootsource and reset-source* to /chosen
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0168.eurprd09.prod.outlook.com
 (2603:10a6:800:120::22) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GVXPR04MB10109:EE_
X-MS-Office365-Filtering-Correlation-Id: d4600ea1-6c2a-4637-cfa4-08dd1ba12044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFZpSFN2WEhwTDk5S21CK2dhMGZLdkFNRkpqQmx0VVdmeXovZEIxdlFWaEpa?=
 =?utf-8?B?QlJQeDVWSFFMMTJLZjdLVmd0OWY1RmdzSXNManpCR2hjVEJiUW4xTVhPejFn?=
 =?utf-8?B?WlVwMVN3ektGQ0hmU0ZWNmUvcjBuTXhhN2p1Rm95NEVMaUtmanJKR2R4YVF5?=
 =?utf-8?B?QkQ3UER3TS9UMzlUMGdvNlVETFRCVVZVSUUvUTdMR2xyRUFWNUNKS29MWnJi?=
 =?utf-8?B?aU41eHNrU0R3YmlkNUVDeGJKZWJRTGpZU0hLZFF4RTlNS0J4eXYwR2R1NllJ?=
 =?utf-8?B?Z2VKUmJCR0F3T0lMSzl0ejYxMitjVEdiNjF3K2lSNjl2ZFc3OTVCWGNEQXZ3?=
 =?utf-8?B?U2Nld05mVDRQOUJ6QU1QZFFwL1E1VWkwVWtWOVVqRTVrdGJ2cE9EZ3E1WDlk?=
 =?utf-8?B?cU10Rm5zZmRudlRTK0FHcjNjZitGYUtMc0E4UURyN2ZSR0N5L3hjSVhreEpv?=
 =?utf-8?B?SlRtaXBGakMyZy9RcDAyM3A5OGtQR2lQaG5FVm45Zy9lMVAzTFVoWUVqZlBB?=
 =?utf-8?B?MWNsVjJiVXB0QVJrUFhTdE1VbWx0WGhHWW11bUduTEdqV3JjWEsrbGNaaFV1?=
 =?utf-8?B?ajVtNnVOWmZ4cmo0am9sbmpGMjZvMExOUEhFaytpRVB0Z0h6MFU1QXlxZHp5?=
 =?utf-8?B?TDVkKzQwMDNLLzhxd0YyK1RDZFF4MzRTcWljOXlZY1I2ZHpnTVdNVFExUG8w?=
 =?utf-8?B?K090VnlwS1dqcmVGUTI4bFpXRDV3TVBiUnZZaEs1eEpkU2IwUnptTGZZWDJo?=
 =?utf-8?B?anE2NzlzRHB4Mm8xSkpBcHpFdC95UUJKY3E1Z2hFN0xjOTBZOUN6TVN3eTBz?=
 =?utf-8?B?RTFuTU1PMnRpWXNnd3ZLOGFySERPZk5MZkhPcjNkWi82cERwa3NROTlVSS8x?=
 =?utf-8?B?eUltdnFUZU9hQ2FTSmdzOU0zYWpIOGpSV2VHWnRjM0wwa0piSlVSeE13M2RG?=
 =?utf-8?B?WWZvcXNtVjhYZ0xhQmIyVjE2N0d2b2dJeXhSWDEzY3VEOUt0Q2o3aXhhRDVV?=
 =?utf-8?B?OUE2N3hqS3R6Lzg5ZFBCZk4yR216VllaV05xcTI5SThDTVFBWVFpLzNrcGRj?=
 =?utf-8?B?ZkJMZVgyYlBKb2lRcUVBTlhZZUFrbWZ5WHRBcnBJZ2RCWWYvM2VWMXo5VUhW?=
 =?utf-8?B?UVFpdmQwK1dMNVBOc0h2Q0o4cklwUzYwNzNBUjRYME9UM0F0bUdNRndhbzlC?=
 =?utf-8?B?N0dUSHRtS1JUaTZkWFZUVC9UejhhZDdCQklmU2ZMclRYa2NMNnNQSGhYMHF2?=
 =?utf-8?B?RjZxVEQyUmtkT2tIOHdoUUIwc1B5V0ZKUEZNd01FL2R2dHNjVEhYY2V1UnQ3?=
 =?utf-8?B?WSs1SzMrL3lJNW0za0pKaUlNZTY4ZEhnb0lBdzZ5YnB0aUZVVjBmY1ptd213?=
 =?utf-8?B?M1FIZzZHdndWSFk2Q3pwNUgwRjRVTk5SL2V6UmtBdUQxcnRwL0ZKa1gvOEQ1?=
 =?utf-8?B?RmtwdnhEaTJvamJyTDFkYmVKNDNEUUkzY1dKUXJXeGpGWmE4d2I2WUJpU3ZN?=
 =?utf-8?B?dFYrbURrOVpxTDJZajVzcXJQVjQraHRKM3BHUXNqV3FXaFY4ak1ycFhDdW12?=
 =?utf-8?B?b1ZQYlN0V1ZSVE1wK3lja3FiRmlTVS9GcCtPM0NERXJsaCtkdjJZMEpkaXpX?=
 =?utf-8?B?aE0wejljSmhETGJWcDhxeVJDVDMzcUNNS0tSTWdqMFNuNlB4Y3VMVjdZcEJm?=
 =?utf-8?B?QTNpb01iQUlJUTRPNm8wQjNOU0lMVVR0SHBHenpzNlFZQ1BUamtSMDNqUXdW?=
 =?utf-8?Q?DD08zlhluM6NmPERpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJKOS95VXp3MlVXS2FNekpVT29sWllraW9ZdTZqRW0wQjhWVHVWVVM5bTZ1?=
 =?utf-8?B?V1paR3BkSTdldWZDL2ZEbkIvUHorQzZsTXBVWnc1Y1lUUEtYeXd0SmxycDBJ?=
 =?utf-8?B?Mk45K29Jc1NNSEJBZHNSdXdLeXphQk01ZjZMWllHZlJ5Q3JFRExKa0s5QTNQ?=
 =?utf-8?B?ZUdCOHlEQUNoOFhVaFEwSUI4YlNmTXVwaFNYSjYvNCs5VjhVMWJkMDBlZEtB?=
 =?utf-8?B?WnkwWDAyU3hXdmxuekt4bm5VNDhVeEVrbmZmL1IwTE05cHNJdmJkcjd0a3Jj?=
 =?utf-8?B?MVRTYktzUStrME5jaEpoMC9YOC9DR2xlcnlmSm9yN1VBdzR6MkxNcXVHYU9L?=
 =?utf-8?B?OWR1eEJ2RnlxT0JEaHB4ZGZ6WWh4ZkM4Y0lZcVJLM3NVM0ZpMDd3R0NFZktE?=
 =?utf-8?B?UmFrcGsrK0JOaDlYVmR4V1Z5UVFRVVNKOWFER2pHMCs4TGIrUGMxRExFdzN3?=
 =?utf-8?B?Z0g1bjNEa29McWEyNWdiaXJMemV2cUJpbm1vakJXL1h1V0o4M0NrTDdBbS9P?=
 =?utf-8?B?S0I3SUE5TExLTHgrWEhVZFdZcFhnOTRIV3dEVU5SZisxYndFSXo4RCs1My8x?=
 =?utf-8?B?alpTY1BmZVFyVTFsenZZc3ZUOGp2c0VXM1ZSdGIyMmpoMkcrY2VQQjZQdzYr?=
 =?utf-8?B?RFdhSms2bnhoUFN0N3lNQnVTa0dWSXA1SzR0Z1dkVTQwSmk3VHZMclZPSW8w?=
 =?utf-8?B?L1BHQUltZzhqNkwzcXNTY1NYQW0xUVJnR1ZTWTR0QWYwcG9VVENsamcrSGRP?=
 =?utf-8?B?ZVN1SHV4UlVhYTJtZDFSVEdwVERuZUdVUDRUa1BWT2x5bHZuVWdFM3kwY0p0?=
 =?utf-8?B?VWdTMmVKazZOT1ZHY1lwZjFRbWhpSUxLK0dmRUdUMlRPRkpheWxTTkozbTN1?=
 =?utf-8?B?NEdXT0hkOXg4c3ViL24rVDdSOVl2QWFoendpbXE1M2tyUWFsRVYveG1FU09Z?=
 =?utf-8?B?QW1INVhXcVp2aE5CU3lBdzFSazA4SFBBK1lnOS9yTkR0S2pMYkN0dXRNNHVQ?=
 =?utf-8?B?bjZ4amtHSXRGREg1VFZBN1VWUjM0RUMvazkyRjJGMWsyZjRCelBpQTA5STZK?=
 =?utf-8?B?bUloayt0YnJsZmc2RExtNG4zOFJxSTBia2V4VW8wRnJEb2lOUzVTNU8rcGth?=
 =?utf-8?B?cVVrS3o2YjROdGxKK213U2dWN1NUN2dUMGgvVmpFd2twaFNXWGQ0M2Q4Y1I5?=
 =?utf-8?B?dTNma2VtZjN3WWczOER5RUZSTlFhL1pKTG40SG11TUxuSkFldjl0V2w0OXZS?=
 =?utf-8?B?cjZ2SlpDRFdLRGtRdXpYbE42WmJWcEw1U0hIRU5NV1BudkhqMTFOMStUSE4x?=
 =?utf-8?B?Y1NWWXdmSkVpTzdPcVRobEROR1VqSVlYdWJ6L0ErR2hUOU5TRWVwNWVpWTJi?=
 =?utf-8?B?aW1NWStvQWJ5T1BoRGpQRWpHOUZ2TFVBeG9pUnJKdTRPUVFjRlVaY3p5UUUw?=
 =?utf-8?B?dnFjbmJNWEVveE5OS28zc1Z1TjZTbkJhdWVMZ1NkckVpbks5c0tGNkcyNVJU?=
 =?utf-8?B?OFNvZVNCL01CeXIrY3dxM2s5Q0MvODNYQ1doUThDL0ZoVWp1eE0vMlBnZ0t1?=
 =?utf-8?B?cHVlZW5vMFdGVitMMkxCdzZ1SFFnUGI4NEFOSktVaHNjYWczQ1ZBajNUblVx?=
 =?utf-8?B?VE9id3JTOGhFUitYL2RHSnRGVis2QmEvN1NNVmhrZU41bkFSbndMSGd2WkFI?=
 =?utf-8?B?SmNra1VjeTR0Mlp2dWhUYzd2bGFSTDJudUxRUys5TFV3bEs5WmFlUG1yRlpG?=
 =?utf-8?B?MVM4TnIwYVU5NFRkZERkTXRPSmFsN1lGMm5SYmJYNjlsU3FBMFVqSms1RGtp?=
 =?utf-8?B?dUdxaUQvR1UrQmZkSE5tZGI0MFErbkRTa0RUVTRSa2pWTjFFL0hSSEVETytz?=
 =?utf-8?B?L0tydnhYNEtyY1BwWU5ybTFsUUxTUDBoeDllWDk4bFBqZVFlRnRSbUtzaXov?=
 =?utf-8?B?SnY5T1Z3K2NEbklJelV1Q0Fha1lzb0NZTWQ2b3VlU3RFOVlpUzRXMzNyY000?=
 =?utf-8?B?YmEvTllHREdjZkNSc2g5UWtCcXRMWlZ5b1VLZmR5Q1AwM21qWCtNYklrQW5w?=
 =?utf-8?B?YWFPZndicjZBUGRxVy9kY0NtWno4aFBpSUtLczBmSmFQNENsdG5QQWZnWXJP?=
 =?utf-8?B?bTJ6ZnF6NFoxaU1ZYUQ5SHF3Nkc4QVhmSWVLcEZ2UUpneGF0NnUzRGcya1Er?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4600ea1-6c2a-4637-cfa4-08dd1ba12044
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 18:08:20.3214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgvc5yRUi6IMqhYoetPrZcbRM3tk5xqC5JIylMhiq5wopKZpuT2zKCu/+KBscFZfh9pZY6kcIPW2NmK3G+QT4r0FEPTtXeSK9HA7mKAlbnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10109
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

Hi all,

In U-Boot, there are multiple stages which can be loaded from different 
media each. On Rockchip SoCs, it mostly goes this way, SoC BootROM loads 
from a medium (storage or over USB) and executes the TPL (or SPL if no 
TPL supported), the TPL goes back to BootROM and reads the SPL from the 
same medium and executes it. The SPL will favor the same medium for 
loading the U-Boot FIT image (containing TF-A BL31, OP-TEE OS BL32 and 
U-Boot proper image), but in case it fails, falls back to other possible 
media. In U-Boot we have the storage medium used for loading the U-Boot 
FIT image stored in the DTB under /chosen/u-boot,spl-boot-device 
property. But we do not have a property for the medium the BootROM 
loaded the TPL (or SPL) from. This could be useful information. For 
example, I have some CI where I want to check whether the BootROM loaded 
the TPL from the expected location (important when checking that they 
all work and don't depend on a bootloader flashed in a fallback medium 
for example). Another usecase could be to detect whenever one loads the 
TPL from USB (not a USB stick, some USB transfer; see rockusb for 
Rockchip for example) and decide to do something else in U-Boot or the 
OS depending on that (could be starting DFU for flashing the device, or 
fastboot for loading the rest of the system).

Barebox currently does that by setting /chosen/bootsource to the full 
path of the device the BootROM says it booted from, but that isn't part 
of the DT spec so before I add support in U-Boot for that, I'm asking 
whether that's fine or if we should correct course in Barebox and use 
another name and/or location.

I've also been made aware of other "sources" that are added to the 
/chosen node in Barebox, reset-source, reset-source-instance and 
reset-source-device. I am not entirely sure what those exactly are for 
BUT it seems that this is of interest to U-Boot as well since we do try 
to report a reset cause as read from the CPU for Rockchip SoCs, c.f. 
https://elixir.bootlin.com/u-boot/v2024.10/source/arch/arm/mach-rockchip/cpu-info.c#L14. 
I believe /chosen/reset-source would be the reason, e.g. "POR", "RST", 
"WDG", "WKE", "THERM", etc. /chosen/reset-source-device contains the 
node path to the device that triggered that, that could be useful in the 
event there are more than one thermal trip point (e.g. CPU or GPU), or 
more than one hardware watchdog (I for example have a system with 
potentially 4: SoC, PMIC, 2 separate in an external MCU). I guess 
/chosen/reset-source-instance is for HW blocks that expose the same 
reset but from two different sources which aren't modeled in Device 
Tree. Again, this would be useful for the bootloader or OS to decide to 
do something else based on the reset cause (e.g. have data on why some 
devices reboot in the field, e.g. because of thermals, power loss, 
brownout, etc..).

I'm reaching out to the devicetree-spec community before I add code in 
U-Boot to implement this so we don't add unnecessary backward 
compatibility code, were the properties or locations to be modified to 
match the spec.

Does anyone disagree with adding this to the spec? Does anyone have 
another suggestion for the naming or location of the properties?

Would you prefer a patch to the spec and discuss "code" directly there?

Cheers,
Quentin
