Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A35CFA765
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F118312A;
	Fri, 21 Nov 2025 11:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PBOHP0T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1DF833C6; Fri, 21 Nov 2025 11:04:22 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47D1802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk0lGjabuvsrTHi2kq8BHLwZFMkuyyFKylyxgysoP4Ysit0G3qK5mVreTbuympZiZWLQKGAPcOne21karW2RgFkctlEKfje1BMOWgbMM7HbnZgeNh+HUeH+4kCSaNlq8M752YPvukt01ri2QkUx7gyVveVHyzqvsvplyna/j1oe0haj07sW1leCOluoqA2OeSK/LWP+ivJuOWFp+/4mWN8kQC/1zL7aDTLbtRp2N+vLmkuXncdUNeFLCehSqSi+V9fJxiKnb+gdJPXNPalvv5WMW6ZkkEmIR9C9OlKdcOCWICBQqDiGiZjhKeuRzNIaePS3HPmJOBEecazPSKWNXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fni7Dh6DqnlBNDcUVIaHqAUMRaWaW5+0OZtNY66LIOw=;
 b=KSCAiLS+rJTN+PfStJ1nCRttxoOvGiLPwGipGQaSQfibxw0dSEjL8ui1YSTMSxdqYd80SJmRJ5kUbHEY3Byh0LmykuVj1r1PLhdQK18jYGyUYvooF5d45hTR//j9fvJOikyLngeSDc/F0eSPvLFOU+zBGCuKBMd4UIScTrifeatP+TZk9SUxynkQjRRawkukUI0vE34YinMKANlM2lduyGVX3KCB5hzithbt37bwkryW32+S4rNEEszUPR79wKBBORSdbspmZVBq/v328RXxLOVgE6OWY3PpOlVB0P/kpRxPR7SPQEWdKEsBAAUtSSouYCV3HSQ3eRTJAEFTq0qH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fni7Dh6DqnlBNDcUVIaHqAUMRaWaW5+0OZtNY66LIOw=;
 b=PBOHP0T5jmCOYeWsDeZypzfhWFL5X3b+IJLuHcrb1R2nmehnt/yrOGBb3F3uG0RrzFgYXBkBAC4/4Ojxcdqq+KYW+MhW+pk8ExttWU58b8rVW0WNzxnEGpkKiTu1z1j6Cs9sZZKg5baIzknpW1iNCCQwuYZ6QXIzOffFimVwTKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 10:04:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:04:17 +0000
Message-ID: <3c13926c-c3b2-4404-9a3f-e207b53d5d69@cherry.de>
Date: Fri, 21 Nov 2025 11:04:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] boot: pxe_utils: Fix incorrect allocation of
 overlay_dir
To: Surkov Kirill <fanra3.tk@gmail.com>, u-boot@lists.denx.de
References: <20251120191846.110041-2-fanra3.tk@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251120191846.110041-2-fanra3.tk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0148.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0004cccd-8e1d-4420-6924-08de28e554b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFRFclZoNFovRHNXcmYrdnduVU1iMEU3NDI0eEVhRVJXQjdNQlArdWdBRUxp?=
 =?utf-8?B?d0VyN3ROWFpXQUNxY3FkSkUxaDZrMHJJcnNmbStTNW04VGlLYVlwSFdQUFBl?=
 =?utf-8?B?U2NLbHFRVWwrektJSlNranpqalJVUTFCaGU1bXhkNzhiaTRsTFFDL3FjY2t1?=
 =?utf-8?B?YXNSSThUcEdERmdPUnZMRW1LQ2JHa0ZjbjBjbXRyb3dHMzlCVjB0eVhNSk5Y?=
 =?utf-8?B?YmZTZDg2K1BkK21KN3EwRTZSa2o1SG5nZ25GSzBNMWhYanhFM2YyOUQ1dDNq?=
 =?utf-8?B?TEdrR0tuTWpYY0VicHdxbjVWSmNRWWlmd3NVRVNUSEFsM3BPV3VhMkg5OHlo?=
 =?utf-8?B?dTd5Vmw3T3h3aVRtanlpRENmdEJTUlE3cWVUbERYMFBUM0E0NWZHZ1RiSVZ6?=
 =?utf-8?B?OVN1VWFVSHB0WVJxUWFxQW11azVZNXJYdTdzWjZrRTdSbXZWdEtFNTZITmZQ?=
 =?utf-8?B?bTBpN3F1V3NLZjdnUk96VWhVTG9xSmo2amZFMGNPWDRxUHNoNGtHd1ZpbDRQ?=
 =?utf-8?B?V28zczJMWjM3TVBwNHdpV1VTTDlTUExsRm00VExQcysvMFpDUFNtV1BsRlE5?=
 =?utf-8?B?UUdlYjR0a21SM3UyTWxzdENWeG5JWGtiQi8yMmx0d2JaL3kxNWZPR0lCc3ZW?=
 =?utf-8?B?dElXcCtuendOVlFHRVJBay85cGowQXpyaG9mWHdadHF2NGg4Ukg0bC9FYWtI?=
 =?utf-8?B?eGFkR0c0eENDbDE5NnM0QkZibnEvK01xSnZPWDhHMXpHeXFkcGFmKzdWTEFY?=
 =?utf-8?B?elhwRWs3NmdmbmIrS0hPUXNKcXo2SWVXbVAwRjRueER2bEx1TmNpU2FvcmIx?=
 =?utf-8?B?akpJemtxd0ZObnJ6NDQxOG1pUzhFRGFEaytEclNNVmNCam5jOXg5cjdFVGpG?=
 =?utf-8?B?amZtMmFuY0FncU5mMloxUUVwTENVKzdnSVBSdkRBZVl5WTRHRWtFT2tYZUhR?=
 =?utf-8?B?TWwwbk9uWU9HYXdabjE2bi9PWG5IT0Y1Mlc2RHhVcUhvb3RwOG5TSDJ6VlZu?=
 =?utf-8?B?ek1nWE1Mb3lwcDRkcTFiSEJBdmpZQmIzUGpkei9LSHdhRkhsNDN0YUsvWThn?=
 =?utf-8?B?eGxDSUpVOUFWRUJGR1Q2b3ZsV2FGdzFnNzZmMndKbmgxZWdIWUFRUkhmN28v?=
 =?utf-8?B?ajZsUmowVlhQek1SSGFXcHZjRE0zNnFWV3MyRmpKYzBLcWZBZ2hYZk9LRlFK?=
 =?utf-8?B?elRrT2cybnI4ZnRpRDlrRXd3QzRaTGsyUk5nZFNDRjFROWZYcEVxU05JQXRB?=
 =?utf-8?B?YTdGRDd2MzNnSTl0ZTVEQXRZRU9seWNaYlFkWG5zSHRGTmVYU2ROKzdIUWF2?=
 =?utf-8?B?TjduY2RzRGVUUjJKOWdCT2NzUE44VGRIT0V1TDRiQ016Y2UrUlJYbjBCTWtH?=
 =?utf-8?B?Vmw0c2Q4OWpJbG0xSG80UHRTUnVWSmYxbTZ5TGZ5UGlCNFRoREhPM2pUYXhZ?=
 =?utf-8?B?cXQ0azdLZGdGQVlUVGN6ZUJyS09QK28velNBbGdKNStRV0hGYjJpbEc5RkUz?=
 =?utf-8?B?SWducjJUQ2FEYWxWdVMyUmtaaGFHc0I2OTNZeUFOM21SREdMd0k0c1p6MWtr?=
 =?utf-8?B?R21SS2E2WjJaQmRmWVhMWEZucGxvemxYRlp3VENnaWJPcjFOajNxU25QR0xu?=
 =?utf-8?B?bGsxWnVMY0NQalhhdGwxK3ZLRTlDSWhXMXA4VkJlTkp1U3hNeGJDaXd6ZzFm?=
 =?utf-8?B?VndscEtVS1FkcEc5TURvSXJpMmZnZnlWaWlXZklFNW9DZzZWcHU5Tit1aW1j?=
 =?utf-8?B?Y1UrNEV2M2JPaC94Y2NVaU5mS0QzZ1BEWkRIb1lmT0VqMXQyT2NGOUpQYXdr?=
 =?utf-8?B?QlpDVzBxa0tlSXBrS2gvWWRFbkJzNTVpRkI3R2NBcnA5TzdTdXg1NzM1M2xR?=
 =?utf-8?B?TEx2K2FZcjl0YithcEtUREZob2NOaE5NblhkRndBTzdUOXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhEak8wemd6MXZJTXRLMDNFVUh5cCtRaktkTUJBNllWeFladC8ySHFXUGZr?=
 =?utf-8?B?TEtadUM4ejhMbWsrZ0ZDWG52N0w3eW5QcGc2a2hvRUJQTnlGVHIrNXEyYlRN?=
 =?utf-8?B?c3FVL1FnTngxdXBlMEFVYitEbUxtY0ZvWGFhT2pSeDdJdnV5eWFBS0h5T3JN?=
 =?utf-8?B?V0FPOUVZaExTYllCTXM5REZrTDVqNFRpZUhucEx6REFzMnQrWUFLT1k2ZVY4?=
 =?utf-8?B?MUhHU3FINnYwMlpLTzlYQ3QxZjJ0aWt0d2dxOWMwa0tSUUMwRFRYVjFIaHNH?=
 =?utf-8?B?NVE1M05HekovbUpXaU1scUFpMllCdWlRUVdXMzJZL2MrQXp5ckVZenVxaGtX?=
 =?utf-8?B?OG1BSW04T0dzcTRTazhsemJTRWFYMFYvbFl5NDZHdnRXdVJUWnNCdnZFMVQ1?=
 =?utf-8?B?bUppalIrMlRlYVlOODdZY1AwaC9MSGN2NEFRRjlyOEg4OXlsdHdYNGtvQk5r?=
 =?utf-8?B?MU1UQysxWDR4YVVBN1hqK01tdGdJYkNuT2d6Mm9tRzZxQWh5b2Rid2J5bjFl?=
 =?utf-8?B?QzcvNXF4YWNJaElLaFBjNWxObFFJVVRlVGp3cHpTYzNDYTIweGJGRTVDSFFn?=
 =?utf-8?B?SlZNQUIrVUJQNTUxWTZlaWVTTjU4WUpDaWFzYURMNURHSFB5N2k5ckhZK1JG?=
 =?utf-8?B?SWhmQmVhWTdjRHU3blp0dXY3YXQ2VlpHaFBUVGlIV0VHUnd0blZFbCtOZHgr?=
 =?utf-8?B?ZGxnWkJxbktVV3VRMlpKc2ZYc3QxTlE3ajRoNStoa2QxVHFoNGlKZmFoK0Ns?=
 =?utf-8?B?RC9pVUp0Ty9tWjEzbUx5dWJucG9aUVQ4djhVVTFQd21lL29HWHM0aTIxNmVy?=
 =?utf-8?B?UUhNY0JBcFdPY0tuVzRwZFZyWk1LLzFKc0JjMm0xckhFZ3hYNkJKVjExeGJs?=
 =?utf-8?B?emMzaURuYzFxd3dvSnRkcGZjeEwxVk9saXB1RnVnS1FvTVZrODJmK09tak9V?=
 =?utf-8?B?YnpNSnliN3JLZTRERU12WHpQZEQvL3hjdWNVV250U0FHMUNpc1B6OElYZXJW?=
 =?utf-8?B?NGpGOXFuU1dnT0gxY1FuTUhWZVVyY1pwY1dHb3JERXBtQzN4NlREOUgyTGZw?=
 =?utf-8?B?TVlUSE5HYU5GcGlVOE1hZWNYU1k3dEtkRXU4a2FCUGJzcFZzbDBmMjdnTzFy?=
 =?utf-8?B?VUJqckhlN0MzbDZLWTZGSEpLSGV2V09iM1ZTQytyMVF6d1JTOVVpM1llWG9q?=
 =?utf-8?B?MHNQSlUwamN4aXEyMFRLcmV3YXFxMEJ2N1lTSXdOUkNERHgrWms2SkdQQnJI?=
 =?utf-8?B?NE9MclYyM1FFYnBmWFhmQzVzSUVjektPcC9KcUlPWDByUFhmUGdyemlLOHMr?=
 =?utf-8?B?M21uRVd4NDk1MWZFMjNmNDdSbzhDT1RKaFZ6dmJ2K1p1VDBCenB3V2QvZ0tr?=
 =?utf-8?B?MENEZGJ5QUs2NjlYZEFuVWFsSHJvU01NMUw3Q1FPdnVUYURFYXpYUEFMWVVX?=
 =?utf-8?B?TVVGRzZUQkxEelM5R1Y2VTVpMlRjSTYzWE5UZHhEY0tHQ3NVUU9tWTFWbDNK?=
 =?utf-8?B?WU1Eblcyam8zV3M4MFBUSlVscTBsZHV3VzE5NjJ5LzVYQ1YzNkgrUnIxejB3?=
 =?utf-8?B?OUNkeXdxdFgzQ3lpSWVhTys0L0xSWlFRY1dQRHFFTUtXZkEwS0l1TkxyY2JX?=
 =?utf-8?B?aTBHcjFqRWJTV1BvTllFUlBLOWxWQlh4U3F5bGtvZWlaRVNtVVZzVWRhaXhp?=
 =?utf-8?B?S3FiNkYybFpLL0VvK2JMZFlCL0t1bnBDSWNrZVpweEZSank1Q2ZYd25XdDU3?=
 =?utf-8?B?Qnl3cTR4cVFyTE5OZ2Z0VkFDSTBpQVliL2RQMWtwVUo4OFZ2YkJXQURwMlZF?=
 =?utf-8?B?amVLemdKSEoxdmcxZGJ1K0ozbEI0Z1JMdmhodVlUUVBaOTB6K2ljTWs0S1c0?=
 =?utf-8?B?emx5c1J3a1BrVzlTWEpBa1kvMFR0Z3pKdlpVdmFUK0kraG1ZVXVlMFBrZFpT?=
 =?utf-8?B?dU9HM2NjRkROYlo0dUZvNElGNU5aOWVJWXd4TzZnK1VaZFRCRmh6d1VtU0JV?=
 =?utf-8?B?QWNzS3N1SUp6cDRlUDdROFZ4dHBObGVwaGhRNlVvZnFQMVZFdDJsazVxU20v?=
 =?utf-8?B?VWNOcjl0TXdvdlZRVDVscFF0aE9VMGR2ZDN1VEJ0K05HeisxT1VxL1RUOGZ5?=
 =?utf-8?B?amNBdi81L2pUQXA4UWlnQngwU0huc1pBMlA0dHoyd3NORmV3R3hNZEV6Uk11?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0004cccd-8e1d-4420-6924-08de28e554b5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:04:17.0049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXGNQxrkJNz0VKBLnmjKZHyN/P8y/TStRTCEe9uauMTMly+2/d9rlW9n6hnEhlXxwXzn2QUrvaS7fMmo6FphpWq64RvRM5wtdFsbQjWivD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
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

Hi Surkov,

On 11/20/25 8:18 PM, Surkov Kirill wrote:
> [You don't often get email from fanra3.tk@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The function label_boot_extension() calls snprintf on a buffer
> overlay_dir. However, this buffer is not initialized properly. In the
> "if" branch it is initialized using a variable "len", which is smaller
> than the resulting buffer. In the "else" branch this variable is not
> initialized at all. This results in a crash when calling a "sysboot"
> command.
> 
> This commit fixes this issue.
> 

I believe we already have a patch submitted for this issue:

https://lore.kernel.org/u-boot/20251117152308.900316-1-kory.maincent@bootlin.com/T/#u

so please give that a try and a tested-by/reviewed-by there.

Cheers,
Quentin
