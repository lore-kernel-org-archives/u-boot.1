Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB547C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4EE81D52;
	Tue, 28 Jan 2025 12:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJcx2qRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813FC819B1; Tue, 28 Jan 2025 12:09:41 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4471D81D67
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqR9It82S58vGOVCjDVmJVPRLle1XtKAndpUdEc4zNesKRJps66UvA18qh7HmXdXK0963F4R4pWZA/UJmgkWadsR/UfuhD7SmyxUrPNkVfdPAI9tOXoNdaLb7NmTuEngHLNYr6/9cLBmZRZqfWqdZVQCr/1cRVUHkmjWTFGeQnxkBM6pqcJ/3Jmp9MdzywPDMzcoDWCsDrJFpsm+cNJPuPtYkdk5xgJNHFJLlAAQ1D/GhN3ZE5OlvsULwrGYo/xfjkTEIQ0uVeLsW9tXhC9R+XBbjDccxYJdrG5nGyB4mGz7fRewIVyAZp6JbrMA6iwG989rgAwp37wjG569rwXrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ShVvU0OVf5kF21tPMVlMWHSxDL7G4oq/yMDwW70nWY=;
 b=nJ0YqNrdVfJHiNopy9UgW8jzBMTSQxXTBN4wMVFBoGyrKEgjnuzYk8X32p7auovuGJ6BYtfL2he0K+ejVH/3cehAyfaGGeAdeyYyZZjWjrfCQRZnwFnOfbKwHzxjH9Jzra79qdvMQMLrCS62OMk1VylVsPhuDhSxzlD3MSzmKC0QDc5S3+8/O+RM3U5JKMruSxg0SfVpLgGFXDeP6jWh144Q39uSTnYPiqHr/aq5ZlnHVXlhmTKtibLRAGb/EdbdRxz7nGX8jmArh3PyiZTwmK5uCkVhGyrNfZ/Fy1VsGrcjnRBpWo0hafIjEubHLUmKbKEjTe2CMBtfXveizabTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ShVvU0OVf5kF21tPMVlMWHSxDL7G4oq/yMDwW70nWY=;
 b=TJcx2qRTOeX/QXEDSkLaUc6LrEgcHvAxYxIZzgZryDq2JvgnEimHQbtu8pS83ONnp0MBYrUSgaMdMf/16uDgmCSUk8QXkfK5ne7eC8wuTS1Xf8UeVxm3A+EdaM4GzeLzrTC3LeemOVOyoB2JNaj3GpeRokFg1KSrdrhxQQ4HxgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 11:09:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 11:09:35 +0000
Message-ID: <264b622c-f9d4-49ef-b2cd-1b666426e171@amd.com>
Date: Tue, 28 Jan 2025 12:09:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] Introduce coroutines framework
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <912af13c205a31080cc61d40bec29d7402185d6e.1738059345.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <912af13c205a31080cc61d40bec29d7402185d6e.1738059345.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5f875c-09f7-4792-0697-08dd3f8c3f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUpROUZiNFkxMzFXbm5mQ3ZxemlOV2ZjaTN3WnBmakgrQXNZTnhPTmZrZ09j?=
 =?utf-8?B?b09QZkkrMitxQ0pRa256RDhzOEZ3cTd4ekJLTk0rWk1vTitRQlAwTXhsamps?=
 =?utf-8?B?a2Vmb0xNeFRoTW12T2ZpTVdwZVBqaVFzeGZOTlBjQjFCSmhvNmNyRFJhcWRi?=
 =?utf-8?B?QW9BZllHeXc5eDZmd0ZtM0dYcllQbVpYQjFYWDY1YVZ5N3VrNmErMkEzL3hG?=
 =?utf-8?B?TjcrL3FGMUtkZ1FZWFZncnYwbWNOSVNJRXFMbE02RWZRTjd1YWNESlJsc05Z?=
 =?utf-8?B?OUFWLzhiNlZqeERZc1ZvU3pDSkRkZjQ1STdhSWJ0SHBVOW0zOGZUaGxJV1Jk?=
 =?utf-8?B?aXBaaEJ3dGhjaHVPNm9hcnZLMFgyYStIN3czc01aNFNVSHNGUERYV1hvbHhF?=
 =?utf-8?B?TXg1WjJUblpXUDJoc3d1WkVzWXhUdTFwTkowVTV1MFA2eXd0cVR5bnV3enQ2?=
 =?utf-8?B?T3lZZHdTckNGWDJxWjV4TW52eDMwWFN0YlhUbGUzRWZ1a0J1YS9iRkRiQ0Rz?=
 =?utf-8?B?ZjE0SkhYU2JCMXFsb0cwYW1HRVg1YXlQODFGNHk3UkpCVGFrQ0J3Z3pDaEtP?=
 =?utf-8?B?aGJoeUNKS3Z2QW41cGdMMjkvd09iYVdJRUZqYVBjQmhQOW04bXg2QnUzS1RT?=
 =?utf-8?B?ZW9SVFJTVzNHK1M5cXAvUzFYczIwenNSWS9lUWc3R3JFbVp2bE9HM3F5aUM3?=
 =?utf-8?B?NkF0N0F5N3lja0tJd1dia1dLK0JLV3lTUnA3SCtzMG5mcXRuOVZzNFh3MjQx?=
 =?utf-8?B?VEVqUjB0RXp1c1BXcCsvTVpuejJ5QkpnUkNWOWxTcFpVWldMa0JRZVpQZW1V?=
 =?utf-8?B?VDVWbzRMVUhPMVl6RUlFR1FweGJ6MGdSdVpzbXRNcUtMcnRya1VZeEV3Q1NK?=
 =?utf-8?B?Y3RmMnlPc01PMjE2UmxzY21jQ21PZkkxZjd0ZjBpWXl3MFpDN3lSVXlXcGpQ?=
 =?utf-8?B?dWFDcGU5QTRkUUc4bnY0UHVMajdZWURjS2Z4TVFBdWt3ZG1tOXN5ZFk1d3VE?=
 =?utf-8?B?dUpzbzloYmVKeDYvcDJmUVp5SHg0WmVqVitVRnJnT1NsTEVjM3dlMlhNTm5I?=
 =?utf-8?B?K1F4UGtRVGRDWWZTU295ZWQwVDN5eXFiVmJJNkJSNSt4MGJwdDNqWFMvR21O?=
 =?utf-8?B?WnB0YzgzTmxlSHh3THVDRG1tT3puK3JJQWNjYzRUWGN4dGoyaS9ldWpzOEJX?=
 =?utf-8?B?ZlhKVWh4UU9oZUhzUzJkbXhHczV6anZDUzdPN2RjWThXdE83RGQ1UE1qZEk0?=
 =?utf-8?B?QU1BaVo2R2FENEtrUlpoK0dkVEp0TkNHZzFma1JmNVQ3Wm4rakVwV0QwbzFj?=
 =?utf-8?B?VE45TmFNTUhkaEtUQWVHNEI4eXd6UXQvL3ZYSzVFV092K1V6Q3ZzRllDRE1G?=
 =?utf-8?B?S085TUJ6QWZQM2NFR2NCK1QyZVZBdlFBblR1U0FONjNlWW5BT3JheFJ4SGRo?=
 =?utf-8?B?djd6TlRXcFJNU1ZNMWE0Qm96d3hCcGpFSXZqOGdURkg2dDJJZEFOOU1tc0oz?=
 =?utf-8?B?NXR0dEo5eUk1MGlXQklCNVBiNFFOK0I4S0E5TGsweGFRY2U4SkY2SVZNQmVM?=
 =?utf-8?B?TDEvUWZ2NC9YUDFvUFhWZmJNbHBiNEV4bUVBRmx1akJGbXlHVnNjU1FIYnpW?=
 =?utf-8?B?MnVRMUgvc2s3NDJLckdDQ2UyUjdTQnJvQkNFR3pqalhSZnlHVUZJME1lWkhB?=
 =?utf-8?B?Qm5zYkJsUC9wL1Fmcmk1WFpPTkQ1YkZoWWdHTEhoejUvWmlFb092QjdEVFY3?=
 =?utf-8?B?SVVvbHNaT2hjazRBZXh3TmNTdmU2dnREaG9jQUdqWUE0MEVJbk5nQm1EYzly?=
 =?utf-8?B?WmUzUzM0OGhUSHVKLzhEYkxiY0NDeDI2K1pXS0ZJb0IxZzB1b1lNdXZOcy8r?=
 =?utf-8?Q?/FQX36GsGJzAn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dQWVN2VWJha1QzelNCZHQ4UXFDL3dlcHJXc1IxQWRBSDZYM1pacEZialNv?=
 =?utf-8?B?Ny9rNHNwNDdtdlJOeG1SRHA4T3A1Y2ZobTBpb2dEaWEwMTlNQThEUXlnWEgr?=
 =?utf-8?B?RmhSTEo1bjlUOUJCU2UycnQ1bmJ0SWYwUkNIYkl4a0FIcmx3azRLR01vdXBs?=
 =?utf-8?B?M3dDeFJDWFh0dlN6dWhhR2lNWU1KRkZIbUlKVGFXZXh6cWhNTUg4UVpUKzVE?=
 =?utf-8?B?V2pqR1M0ZDgrb05jLzdMRCtiK05CbSs2K1BSYmkwYWJnK21rejE2M0VSZ2hS?=
 =?utf-8?B?RlJSYnZ2V0F0ZXFRUmlaNkhCOEpITHV4eTdaWW9UQTBabXllSVJlT0RZZGtY?=
 =?utf-8?B?bGwzaTJqK0JMVWZ2YitrU2VBRGRueDdpY2JlK21FeGNuL2lNc0NuQUlvczZW?=
 =?utf-8?B?QnEyTGRFTXZIaGtFZWc1c29sK05YMnBaUXNWbHlnbHczTWlERFVwMStCVGhJ?=
 =?utf-8?B?eW9xNmNJcTRyaE1FaUlJYmVrYlcvY0JIcGNUMnpPMlBZNC80RCtsaTZCSEpn?=
 =?utf-8?B?aTI2eGxNcTBlb3ZMZnNwcjNXazNRU1MvZHlDaVZra2diMzdLbmhIczl3Wk5R?=
 =?utf-8?B?UDJITFRzTUxVRjdMQUlaMVoxdXlFRkdLVTdKQ0RIZnJQKzBQSUxRZlpKUW5V?=
 =?utf-8?B?UDFnSFBrS0M3cXlpMHJ5Rnh1bHRWRXovd01wNm5TVTVnb2FSVXVaQVV4blkx?=
 =?utf-8?B?aENkLzZPaUdrZEpDYkNjTy9rcEdscnhabWxnbVJBRm81ZERkVzdHdlhKZmY2?=
 =?utf-8?B?RkRHRUNoUXF2T0FNOTgrTVZHT0NQMSttT1c2aTdLd0ZFTUoxTFA2VE53OXZV?=
 =?utf-8?B?OWZnUUtWQ2dROEExYmRuQk10emthMC94dDhzUWw4QTdiL28rOTMzZXRBWi9U?=
 =?utf-8?B?YVlRNmk5N04rK2xJcmpSZmF3ZVhIQUY2a0RxNVF5QXZ0OVRwOC8vRXJvVktq?=
 =?utf-8?B?M3p0Y0tDTzBIQjlxUFprSDEwbkpRSDZkcnpwWEs5QkVoa2I5cnNEbUtnUm5E?=
 =?utf-8?B?VS9DMzV1SzZVcVJQQjBLVzFsV1VNS1BNR2NteWovVGtjUUg4MjJqbXZKaWVj?=
 =?utf-8?B?VUFPSkxQb2hRaGFwYTVjQkY3YnRNa0JaTFlmNXU3YUFDM056RSsyMldCM3Iv?=
 =?utf-8?B?RytCeFJSeGhkUkZDdFgwaktTQXZUT1F6WVhVRFlHKzFpZGJ6ZDNHQ2dQQy9D?=
 =?utf-8?B?cWIvMjVERVhYbmN6cEltK0sxSE82TDdDQlo5NGVqUldMY2duaWp6QVBhQnZT?=
 =?utf-8?B?b3NwTEZYM1ZLbVFwSnZBcXV2R3p2QndjZFdma2NLTWNrdnBDWHZ1MU1INWNr?=
 =?utf-8?B?Rk9JNG5FUjdBL3NQQitNNWVmYUFwdVQrMWJlVEFRaWN4L00rbU1mdkNwVmhS?=
 =?utf-8?B?RG5oYkhnQzA1QWFZM2dEdVRVZFNSRzNDMGFQUi9XeVhCSFg5c3QzRzRpVmw5?=
 =?utf-8?B?RGNlcml2aEtpSDlYWkR3K2RtY0cvK0RBa3RSU0RvSUhMQ3BkaTVKajFvYkc5?=
 =?utf-8?B?cWdOS241Q0R0RGw3WHFtaEFXaTBUVVhNa0YrV2FNTW5YUlp4VUk0d2Evd1lX?=
 =?utf-8?B?QVNZdkVMbkt1eWZtdktXMlJpQ3VHNzlaTkpibHFtQWxmUTY5amYrT2RGaUpW?=
 =?utf-8?B?dUtTOHBubzZqRGZwTk9hR0RiOG9CZU5KejNLeDg0OVYrdVlnUFJYNnlrMVV5?=
 =?utf-8?B?NVF4K0tRMCtjY2NpN3FJZ0lvaDF2L2QyV1lUY2dZcXRSTjhXZDVJZ3M1WWJp?=
 =?utf-8?B?SEJjWCtnT3Nia3lvb3pYbkFPWWJva044TVJpTjZ2T1ZiU3dMc2JoeDJ1d0NG?=
 =?utf-8?B?TVRmNm9mandWaFo4Vis4Tm9ib2tuVnptTGd0SmUxcEVMQTRUOStPMTF5SkVq?=
 =?utf-8?B?L05HdHBMcityb0tBY1FCSHVGZTNpVzg2TC9iSkswTmQvbkNqQmF1WXVGS2ly?=
 =?utf-8?B?RlN5Q2IvUmxXZ2V0eWZRRS83VjNLczRzMlo4a0xkWWZ5ckdvYWZyUEZTQXNT?=
 =?utf-8?B?RE9tc01FbkNPdFdKZC9tV3dOM0RvV3JFTHZDYlNPVGxpYmthVFFOc0h5aTli?=
 =?utf-8?B?emlYem43VkxqYzhKVVRka2dXbnZ6VmhHdTVuWTZzVnRocVpJZTAvc2JjSWZM?=
 =?utf-8?Q?CpessES34jhfm7MdyiQgl1kXl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5f875c-09f7-4792-0697-08dd3f8c3f57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 11:09:34.9542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnwTY8RJ+80AfzgO8qjzKFeK+glGpfla+FB2n95GihFIRdqQWFeeYUd02Zhmys/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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



On 1/28/25 11:19, Jerome Forissier wrote:
> Adds the COROUTINES Kconfig symbol which introduces a new internal API
> for coroutines support. As explained in the Kconfig file, this is meant
> to provide some kind of cooperative multi-tasking with the goal to
> improve performance by overlapping lengthy operations.
> 
> The API as well as the implementation is very much inspired from libaco
> [1]. The reference implementation is simplified to remove all things
> not needed in U-Boot, the coding style is updated, and the aco_ prefix
> is replaced by co_.
> 
> I believe the stack handling could be simplified: the stack of the main

Please use imperative mood.


> coroutine could probably probably be used by the secondary coroutines
> instead of allocating a new stack dynamically.
> 
> Only i386, x86_64 and aarch64 are supported at the moment. Other
> architectures need to provide a _co_switch() function in assembly.

Likely should be updated.

> 
> Only aarch64 has been tested.
> 
> [1] https://github.com/hnes/libaco/
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/arm/cpu/armv8/Makefile    |   1 +
>   arch/arm/cpu/armv8/co_switch.S |  36 +++++++
>   include/coroutines.h           | 130 ++++++++++++++++++++++++++
>   lib/Kconfig                    |  10 ++
>   lib/Makefile                   |   2 +
>   lib/coroutines.c               | 165 +++++++++++++++++++++++++++++++++

Checkpatch is reporting some issues. Please fix them.

total: 17 errors, 19 warnings, 1 checks, 359 lines checked




>   6 files changed, 344 insertions(+)
>   create mode 100644 arch/arm/cpu/armv8/co_switch.S
>   create mode 100644 include/coroutines.h
>   create mode 100644 lib/coroutines.c
> 
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index 2e71ff2dc97..6d07b6aa9f9 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
>   obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> +obj-$(CONFIG_COROUTINES) += co_switch.o
> diff --git a/arch/arm/cpu/armv8/co_switch.S b/arch/arm/cpu/armv8/co_switch.S
> new file mode 100644
> index 00000000000..4405e89ec56
> --- /dev/null
> +++ b/arch/arm/cpu/armv8/co_switch.S
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* void _co_switch(struct uco *from_co, struct uco *to_co); */
> +.text
> +.globl _co_switch
> +.type  _co_switch, @function
> +_co_switch:
> +    // x0: from_co
> +    // x1: to_co
> +    // from_co and to_co layout: { pc, sp, x19-x29 }
> +
> +    // Save context to from_co (x0)
> +    // AAPCS64 says "A subroutine invocation must preserve the contents of the
> +    // registers r19-r29 and SP"
> +    adr x2, 1f  // pc we should use to resume after this function
> +    mov x3, sp
> +    stp x2, x3, [x0, #0]  // pc, sp
> +    stp x19, x20, [x0, #16]
> +    stp x21, x22, [x0, #32]
> +    stp x23, x24, [x0, #48]
> +    stp x25, x26, [x0, #64]
> +    stp x27, x28, [x0, #80]
> +    stp x29, x30, [x0, #96]
> +
> +    // Load new context from to_co (x1)
> +    ldp x2, x3, [x1, #0]  // pc, sp
> +    ldp x19, x20, [x1, #16]
> +    ldp x21, x22, [x1, #32]
> +    ldp x23, x24, [x1, #48]
> +    ldp x25, x26, [x1, #64]
> +    ldp x27, x28, [x1, #80]
> +    ldp x29, x30, [x1, #96]
> +    mov sp, x3
> +    br x2
> +
> +1:  // Return to the caller
> +    ret
> diff --git a/include/coroutines.h b/include/coroutines.h
> new file mode 100644
> index 00000000000..b85b656127c
> --- /dev/null
> +++ b/include/coroutines.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later */
> +/*
> + * Copyright 2018 Sen Han <00hnes@gmail.com>
> + * Copyright 2025 Linaro Limited
> + */
> +
> +#ifndef _COROUTINES_H_
> +#define _COROUTINES_H_
> +
> +#ifndef CONFIG_COROUTINES
> +
> +static inline void co_yield(void) {}
> +static inline void co_exit(void) {}
> +
> +#else
> +
> +#ifdef __UBOOT__
> +#include <log.h>
> +#else
> +#include <assert.h>
> +#endif

Do we need ifdef at all? Are you testing it out of u-boot too? Or is this just 
untested code?

> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +
> +#ifdef __aarch64__
> +#define CO_REG_IDX_RETADDR 0
> +#define CO_REG_IDX_SP 1
> +#else
> +#error Architecture no supported
> +#endif
> +
> +struct co_save_stack {
> +    void*  ptr;
> +    size_t sz;
> +    size_t valid_sz;
> +    size_t max_cpsz; /* max copy size in bytes */
> +};
> +
> +struct co_stack {
> +    void *ptr;
> +    size_t sz;
> +    void *align_highptr;
> +    void *align_retptr;
> +    size_t align_validsz;
> +    size_t align_limit;
> +    struct co *owner;
> +    void *real_ptr;
> +    size_t real_sz;
> +};
> +
> +struct co {
> +	/* CPU state: callee-saved registers plus SP and PC */
> +	void *reg[14];  // pc, sp, x19-x29, x30 (lr)
> +
> +	struct co *main_co;
> +	void *arg;
> +	bool done;
> +
> +	void (*fp)(void);
> +
> +	struct co_save_stack save_stack;
> +	struct co_stack *stack;
> +};
> +
> +extern struct co *current_co;
> +
> +static inline struct co *co_get_co(void)
> +{
> +	return current_co;
> +}
> +
> +static inline void *co_get_arg(void)
> +{
> +	return co_get_co()->arg;
> +}
> +
> +struct co_stack *co_stack_new(size_t sz);
> +
> +void co_stack_destroy(struct co_stack *s);
> +
> +struct co *co_create(struct co *main_co,
> +		     struct co_stack *stack,
> +		     size_t save_stack_sz, void (*fp)(void),
> +		     void *arg);
> +
> +void co_resume(struct co *resume_co);
> +
> +void co_destroy(struct co *co);
> +
> +void *_co_switch(struct co *from_co, struct co *to_co);
> +
> +static inline void _co_yield_to_main_co(struct co *yield_co)
> +{
> +    assert(yield_co);
> +    assert(yield_co->main_co);
> +    _co_switch(yield_co, yield_co->main_co);
> +}
> +
> +static inline void co_yield(void)
> +{
> +	if (current_co)
> +		_co_yield_to_main_co(current_co);
> +}
> +
> +static inline bool co_is_main_co(struct co *co)
> +{
> +	return !co->main_co;
> +}
> +
> +static inline void co_exit(void)
> +{
> +	struct co *co = co_get_co();
> +
> +	if (!co)
> +		return;
> +	co->done = true;
> +	assert(co->stack->owner == co);
> +	co->stack->owner = NULL;
> +	co->stack->align_validsz = 0;
> +	_co_yield_to_main_co(co);
> +	assert(false);
> +}
> +
> +#endif /* CONFIG_COROUTINES */
> +#endif /* _COROUTINES_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 8f1a96d98c4..b6c1380b927 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1226,6 +1226,16 @@ config PHANDLE_CHECK_SEQ
>   	  enable this config option to distinguish them using
>   	  phandles in fdtdec_get_alias_seq() function.
>   
> +config COROUTINES
> +	bool "Enable coroutine support"
> +	help
> +	  Coroutines allow to implement a simple form of cooperative
> +	  multi-tasking. The main thread of execution registers one or
> +	  more functions as coroutine entry points, then it schedules one
> +	  of them. At any point the scheduled coroutine may yield, that is,
> +	  suspend its execution and return back to the main thread. At this
> +	  point another coroutine may be scheduled and so on until all the
> +	  registered coroutines are done.

newline

>   endmenu
>   
>   source "lib/fwu_updates/Kconfig"
> diff --git a/lib/Makefile b/lib/Makefile
> index 5cb3278d2ef..7b809151f5a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -159,6 +159,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>   
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>   
> +obj-$(CONFIG_COROUTINES) += coroutines.o
> +
>   #
>   # Build a fast OID lookup registry from include/linux/oid_registry.h
>   #
> diff --git a/lib/coroutines.c b/lib/coroutines.c
> new file mode 100644
> index 00000000000..20c5aba5510
> --- /dev/null
> +++ b/lib/coroutines.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later
> +
> +// Copyright 2018 Sen Han <00hnes@gmail.com>
> +// Copyright 2025 Linaro Limited
> +
> +#include <coroutines.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +
> +/* Current co-routine */
> +struct co *current_co;
> +
> +struct co_stack *co_stack_new(size_t sz)
> +{
> +	struct co_stack *p = calloc(1, sizeof(*p));
> +	uintptr_t u_p;
> +
> +	if (!p)
> +		return NULL;
> +
> +	if (sz < 4096)
> +		sz = 4096;
> +
> +	p->sz = sz;
> +	p->ptr = malloc(sz);
> +	if (!p->ptr) {
> +		free(p);
> +		return NULL;
> +	}
> +
> +	p->owner = NULL;
> +	u_p = (uintptr_t)(p->sz - (sizeof(void*) << 1) + (uintptr_t)p->ptr);
> +	u_p = (u_p >> 4) << 4;
> +	p->align_highptr = (void*)u_p;
> +	p->align_retptr  = (void*)(u_p - sizeof(void*));
> +	assert(p->sz > (16 + (sizeof(void*) << 1) + sizeof(void*)));
> +	p->align_limit = p->sz - 16 - (sizeof(void*) << 1);
> +
> +	return p;
> +}
> +
> +void co_stack_destroy(struct co_stack *s){
> +	if (!s)
> +		return;
> +	free(s->ptr);
> +	free(s);
> +}
> +
> +struct co *co_create(struct co *main_co,
> +		     struct co_stack *stack,
> +		     size_t save_stack_sz,
> +		     void (*fp)(void), void *arg)
> +{
> +	struct co *p = malloc(sizeof(*p));
> +	assert(p);
> +	memset(p, 0, sizeof(*p));
> +
> +	if (main_co) {
> +		assert(stack);
> +		p->stack = stack;
> +		p->reg[CO_REG_IDX_RETADDR] = (void *)fp;
> +		// FIXME original code uses align_retptr; causes a crash
> +		p->reg[CO_REG_IDX_SP] = p->stack->align_highptr;
> +		p->main_co = main_co;
> +		p->arg = arg;
> +		p->fp = fp;
> +		if (!save_stack_sz)
> +			save_stack_sz = 64;
> +		p->save_stack.ptr = malloc(save_stack_sz);
> +		assert(p->save_stack.ptr);
> +		p->save_stack.sz = save_stack_sz;
> +		p->save_stack.valid_sz = 0;
> +	} else {
> +		p->main_co = NULL;
> +		p->arg = arg;
> +		p->fp = fp;
> +		p->stack = NULL;
> +		p->save_stack.ptr = NULL;
> +	}
> +	return p;
> +}
> +
> +static void grab_stack(struct co *resume_co)
> +{
> +	struct co *owner_co = resume_co->stack->owner;
> +
> +	if (owner_co) {
> +		assert(owner_co->stack == resume_co->stack);
> +		assert((uintptr_t)(owner_co->stack->align_retptr) >=
> +		       (uintptr_t)(owner_co->reg[CO_REG_IDX_SP]));
> +		assert((uintptr_t)owner_co->stack->align_highptr -
> +				(uintptr_t)owner_co->stack->align_limit
> +			<= (uintptr_t)owner_co->reg[CO_REG_IDX_SP]);
> +		owner_co->save_stack.valid_sz =
> +			(uintptr_t)owner_co->stack->align_retptr -
> +			(uintptr_t)owner_co->reg[CO_REG_IDX_SP];
> +		if (owner_co->save_stack.sz < owner_co->save_stack.valid_sz) {
> +			free(owner_co->save_stack.ptr);
> +			owner_co->save_stack.ptr = NULL;
> +			do {
> +				owner_co->save_stack.sz <<= 1;
> +				assert(owner_co->save_stack.sz > 0);
> +			} while (owner_co->save_stack.sz <
> +				 owner_co->save_stack.valid_sz);
> +			owner_co->save_stack.ptr =
> +				malloc(owner_co->save_stack.sz);
> +			assert(owner_co->save_stack.ptr);
> +		}
> +		if (owner_co->save_stack.valid_sz > 0)
> +			memcpy(owner_co->save_stack.ptr,
> +			       owner_co->reg[CO_REG_IDX_SP],
> +			       owner_co->save_stack.valid_sz);
> +		if (owner_co->save_stack.valid_sz >
> +		    owner_co->save_stack.max_cpsz)
> +			owner_co->save_stack.max_cpsz =
> +				owner_co->save_stack.valid_sz;
> +		owner_co->stack->owner = NULL;
> +		owner_co->stack->align_validsz = 0;
> +	}
> +	assert(!resume_co->stack->owner);
> +	assert(resume_co->save_stack.valid_sz <=
> +	       resume_co->stack->align_limit - sizeof(void *));
> +	if (resume_co->save_stack.valid_sz > 0)
> +		memcpy((void*)
> +		       (uintptr_t)(resume_co->stack->align_retptr) -
> +				resume_co->save_stack.valid_sz,
> +		       resume_co->save_stack.ptr,
> +		       resume_co->save_stack.valid_sz);
> +	if (resume_co->save_stack.valid_sz > resume_co->save_stack.max_cpsz)
> +		resume_co->save_stack.max_cpsz = resume_co->save_stack.valid_sz;
> +	resume_co->stack->align_validsz =
> +		resume_co->save_stack.valid_sz + sizeof(void *);
> +	resume_co->stack->owner = resume_co;
> +}
> +
> +void co_resume(struct co *resume_co)
> +{
> +	assert(resume_co && resume_co->main_co && !resume_co->done);
> +
> +	if (resume_co->stack->owner != resume_co)
> +		grab_stack(resume_co);
> +
> +	current_co = resume_co;
> +	_co_switch(resume_co->main_co, resume_co);
> +	current_co = resume_co->main_co;
> +}
> +
> +void co_destroy(struct co *co){

obviously this is not u-boot coding style. I expect checkpatch reports this too.

> +	if (!co)
> +		return;
> +
> +	if(co_is_main_co(co)){
> +		free(co);
> +		current_co = NULL;
> +	} else {
> +		if(co->stack->owner == co){
> +			co->stack->owner = NULL;
> +			co->stack->align_validsz = 0;
> +		}
> +		free(co->save_stack.ptr);
> +		co->save_stack.ptr = NULL;
> +		free(co);
> +	}
> +}


Thanks,
Michal
