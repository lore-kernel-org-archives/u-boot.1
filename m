Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67EBC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2D283280;
	Tue,  8 Jul 2025 15:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ctCvX0rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7338331D; Tue,  8 Jul 2025 15:01:26 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CADC830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRMzTiQOS7wFs2xN4batNuF9vHtAKEPWdO+VjNph8UAMUBX6eBbPb/anxGrgrB9qKwy0uXXTao1HWWQo7CtPULT67cZlZy1gJ2Iiu/okbRmNcnOsIu5mx1s3oCcPoSEQr9EVQ2tQyxVS3jQ+4jTylFLQC7+GI6pEZ3sSDkghmKeFDIeQ+ArFHrL8FzCrIWDUn54sC8O2ewjS7xE/2dT3AO4gA8+GhQ34zV1lzeMIK7+MrXQazCHPok2c3i8L/ounfuv/LLl0m73sSkQxEpOcAlhFBwZzLaGRa+Wz/0yFlK503GjCMYoihWfA1i9KLvzt6tu/qxRfBHhxXNK7613kIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6C1zA2/rE0s5Qbti4euosA85k2fKPX3WAu5W6vLuU8=;
 b=uFcTMu0mTFvy42j0C9AWTaVcmuoDs0kFPAiStvcGonU7LvKdaluGCx9azNet3Qq5HsKA9TX4AyvBYiPrc1LFHEEbX0oMK5zz1gj3FyDTEFwlsa8BrJkYa53zvson8CF/li4+gAfNKTECxHq+ppURyTOevuvObXfvsxF1wz59lWkbdFQxL581+zXNUfULl97s6rfX9thXH3zpuMPlHujd3qKHv+94yEEbv4MdJ/2ysoaZPi8h4n1CUEsOKuvG2P+hFqKneJECeReE2Bs35LDeiaqCbXPwJ/JBO2L0CscRRoWQxSoL494UK1K88ezR2QFzlCrhc8H5rZio8Mvx0VDaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6C1zA2/rE0s5Qbti4euosA85k2fKPX3WAu5W6vLuU8=;
 b=ctCvX0rtj1d93wFYzKcOteb/s9IeYFm8/DkBzXhMEwuaCHdFSGaw+L7pe2yyF7l3ZFzo4QuG6JwbvvNQGSCfvqNX3zo3E6jcABwZUvxWEXCYJkMwN3fpDGAYbtsJLzPXhpT3PXyn+xFCBHcIR69WgKMa4/5aVX5GgHzXP8Wbq/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:01:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:01:20 +0000
Message-ID: <62b3e14c-1102-4169-bd9a-12acc36e7ebd@amd.com>
Date: Tue, 8 Jul 2025 15:01:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmd: Introduce CMD_HELP
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 git@xilinx.com
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
 <87frfeuca1.fsf@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <87frfeuca1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: ee50c950-58c4-4be4-29a7-08ddbe1f888b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjloTnZtUi96TFZwL2prWDNEZUo1dE11L25JaFhHRHJFOHZmcFA2Y3RURnFP?=
 =?utf-8?B?SkNWVHBmdHoyWXNKd0FiZ2dqUUVONmNaZTVmWU9yN1QyT3lKYXU5elcvWjY4?=
 =?utf-8?B?aFEzdU05NlZYTldvV0pELzlKZGtBc0ZJcVFDQ05QclYzaVlZNHg1NWlFKzFH?=
 =?utf-8?B?R3ZPZy91Zi9jbGpVS0U5ZnM1ajZKZjM3azByMjlJakxJRWdncjZQR1NidUNG?=
 =?utf-8?B?TElsM3lsZllsdnVOK2U2ek8zNTNSeEFyOC9wNEdsU0I3NWxjZnpqeG9teUFV?=
 =?utf-8?B?TGZ1enZMUUNVTzY2ZVVqM3dMMWwwYjR1Wnp4NTJ2SC9tK3krVStQbTZBcTNF?=
 =?utf-8?B?R08yb3JwT1VFbC9hc0YxVzc5V1BTUFdRSjFTUlpLOUNuaER0SG1RdFF3ZEd0?=
 =?utf-8?B?UFA2VFZac2hUWmtWL0hsN2lXMFZiWjM0WWtLT0Y3M3R6TC9hejlqQ242Y3JM?=
 =?utf-8?B?Q3JIUnV3dEczMWpGT3VzWXBZTm9wQmxrQnlwbnJyeFBmMjRvZlJFWjViSVdy?=
 =?utf-8?B?Q3ZLcGRadENmL0lnTTFNeTFTY1ZwemVmYUxqL2JHd1kyYUdSTW9OajNQSG9B?=
 =?utf-8?B?dzRubENwc3pNbDBmOGZBWFZZRGxJRFA5OWphNnpza1d4aWVDZWdheVpzTUtT?=
 =?utf-8?B?TVVXcFpLRTdVcWlMVkZNeXpPQWtZdmI3VFl4aTNVL2RWdUJNcWtrMFZBRzRq?=
 =?utf-8?B?UjdGb29IaGxJWFVoNUcyanJUUjJZZkhYcEpnSkhlSk50VkIxSjVubGxPbWtZ?=
 =?utf-8?B?dVNjcnBaT01wZmJpeFNrWWp5dTE3OWRKOHZvUVpCUEp4TkZvKzF4RGt4dDYx?=
 =?utf-8?B?SkF2bkdTR1kwZ3llbzhQZnBDUDl0ck0wWDJyNXFuNS9VSGxFVUdDTU1NSzhG?=
 =?utf-8?B?RnJVajlTZXNZUnoyLzBmZHFHNTg5ZWtFVGdaazVETnRxekdYZkN4SEM4RHpS?=
 =?utf-8?B?Q2JYMjAwaEg2dnphWFpCTG9xRUxTWlNlYXlCRkFLSHBzTittYWdMVWsyQzRK?=
 =?utf-8?B?V3NkN1NCM09VSGZCcHNTOW4wNWM1NnR2RkZtaDhrbmVYZUNoNkdhakszcVVy?=
 =?utf-8?B?ZU9HUEtCTnpxRTJxcTV1MUhiZnV3VDZkcVoyUTZqd0piYmJhdC9HY21rZ1FY?=
 =?utf-8?B?M1plYmR6amlKTVhBTmUyOEs0N21jMXFYUC9tZk9TZDZJMGorWmwrK2pDa2JF?=
 =?utf-8?B?Ym16eUdyU0FmS1BUanp0TXhGMmx6RVRhcnpFREVDeWNvQi9XdVBSbkdaaTRK?=
 =?utf-8?B?ZzNuR2FWOUkwRE5TeStRUm5DaWVFTVEzQ0MxNW9DSTVMOVB6VVdxcDZFTzRC?=
 =?utf-8?B?MVFtSTYxM0NDSW9WZHFVZ0JvNHZzV0loSUM0U2tER2tiUTkzUWtnSHYxOUxq?=
 =?utf-8?B?dEFXU2dGbHFYSlNZWlJjR1B0cGdQaG9EMUViNTBkKzNKekdSeDk2dUVnbnBY?=
 =?utf-8?B?K3NlWkgvejVzQW5mZmVqcDU5WWJmQUc5NjF2RXBLbnVwdUtweWxOWHZENkNq?=
 =?utf-8?B?VExKYk5QUDI4YWJFeEE2ZVloWVNnZ1RjNzU2TFJodFdjZTJoSjRXZlN0L1Nl?=
 =?utf-8?B?NWJXU3JGcDB5dGdwQzM2ekwyR3RNSjR1bU81NXhXUTB3TU40K1YySGRXdXJk?=
 =?utf-8?B?dlRTYlVINnBoWk9Nc043NWF5dXIzdGpncGF1a05TWHIwYTdOMTFaa09mVWlk?=
 =?utf-8?B?MEZiRkpjU1N1bGpsK0QrU2I0bC9odnNQUE13RE9HK1dxWjRpdHNpejRMNTJ4?=
 =?utf-8?B?TmFpRVlDNlhOQU5ya080Tk5vWUppMy9KRDQ0Z3dtVEk1V2JUQUN6Z2RJcCtl?=
 =?utf-8?B?eVlqUHFGWGQ3R1pOallJYW12N2RxM2hyOUZQY1FHRkhtdno4SWJGUUh6Q2p0?=
 =?utf-8?B?clJrTHU3SVNoMVFwTnZodGVDdXg2WVUwV1hrSkVDRlF3Znc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmt4K2V6RHZiN0Fyb25YYlFXOEMwTCtmRUh5Sm1rbHEwUGlPSXZ0d25wYzRu?=
 =?utf-8?B?UVNvdjRaa1JzYnpGbG5uLzdzZEx0azlBQUMrTEg1MVk3dndVQm13S25aSkdq?=
 =?utf-8?B?NTZzUS9OL1FhY2dNUTVMOVYxcUpuQmZZeHNONnNRMkk2bWZUKzQrSmh3RnlM?=
 =?utf-8?B?YlpsUnJjenJtQnJnMFVIemk5Q25UaG1zK2t3aWcvSFFTc3djMWlsc3RYMXZp?=
 =?utf-8?B?R2RXT0g5dEtYTzlhSFhiSkh3NDd1U25OYVNvUldOL3VnSzR0R0ZiOHRLcWNL?=
 =?utf-8?B?ZVJNSkdLeDc1WVpmQ0dhakxwQm54aG4xR2VJK2c0TTcvYkdnNElGUVFTK0ha?=
 =?utf-8?B?aGpYaTY3bldvdC9PdXV6YUpuN1pUZWNxN2lyOTBwN0lNZ0FCVFVMYStpaUNW?=
 =?utf-8?B?cDduNjRzb0FSYTduRkFhMjFpVFRSZGxZRWFtOCtKUjlzd01RZDFrZXpNRXp5?=
 =?utf-8?B?OWNyeG1VbUR6dmlKNG10ZlVDcERFRnA1bUtTbHNYWHI3MnZhZ092MitUeWRT?=
 =?utf-8?B?U255Y3IvOUwvOXd3Q3RWRTRoOFBlYzh1QW95UVc5YTN2cTcwdnlOV21vOFlG?=
 =?utf-8?B?di9jc2tJRG1xVVU5MlJyZnhuVGhuUzFuWGxJWGdkY2hFSnZFeDVuSXlmNTI1?=
 =?utf-8?B?OFcrYmRzSmNnS29LVUh2VVZ4MTd2cWZNZ0RWQUxmaVVzS0NSU0JHd3JsdVdI?=
 =?utf-8?B?ZCs4SjZoY1k3cFNSOEN1MnZlQ0xwUmpjUWV4cmU5eVFKNHdWaE85bWFTM3lY?=
 =?utf-8?B?SFk1cVhsbTRJS01CYVp0M1F4cTJnTjBGRXZxSFJSQytnbGRNcmhXcU8xVys4?=
 =?utf-8?B?WWhOVFJCY2pXNGZaR3BUNk85TldyeU1PblduaE56SFhUT3B0SzduMkVzM25z?=
 =?utf-8?B?enJyR3RzalNyRDEyQUFYSE5nN2hrSzNNQ0RWbjhCaHRrY0lpbHZ4UlBPV0V3?=
 =?utf-8?B?VGxIc1FHS1FkMmUwRGQ5NitkUjVzQ2NIWGNwYzBHYTNRVFh2MjN1SzhYdlpK?=
 =?utf-8?B?TUhwK2krcFJ0QzdFeGpWN2k4MEk2cEY4dW5jTzFtTzcyMXc4d3dRUVQzUGFP?=
 =?utf-8?B?OFBPMTBLNzFpWThacmVUTVFwVDZiRTlCTGV1Yy9aS08wUkl5K0x0OExnRXE2?=
 =?utf-8?B?VWl1SDlzKzV1ejQ5Wm1XaFlBbEpuZTQxa045aVBsNE5XN2Z6RjlKOFF4UmFZ?=
 =?utf-8?B?SEdUaGZrYnU1QXAwMWl4M0I2Vlk4WWVjZFVoeHFpSitXWmFVdWUyUHNrdWFP?=
 =?utf-8?B?Y1ZEOGlua0hlTWt5M1ZXYjFhT3hEYjNCdk9iaW92RlRtbkFyd3dtY01sRlJy?=
 =?utf-8?B?NXRDS0JIN291Rm4wZStnd1pEdnZ6b0hUNER0T3I4TWZwSkZUZjNCQnZwRmZQ?=
 =?utf-8?B?STJ3L0ZIa3k0NVFPR3FxM3kvYUw0SERVWit3dHV1ejRSS3JHYkE2elN4RXVh?=
 =?utf-8?B?YXl2L1ZxdHN5YWl0Y1ovbkV3eXZ1Ny84Q3EyRWE1WHY3VDNqQzlNbGRUUkNX?=
 =?utf-8?B?VDVjZGZWUVcwSWtJb0VlYWUrK05Pc2tVNlJianhtNDRpcjltMEdoV0dkdW84?=
 =?utf-8?B?ZElROWlLb1F2WHNqbWY3OHliSHRRbmhuWW1sMW1GYm81dzR1US9jK2tieHg2?=
 =?utf-8?B?UTJwTFY5b1lrMHdJS3NuYzNMWFgzQ3ZVMWxIdVdUcjlsaFd0aDUrZVg3VmVj?=
 =?utf-8?B?blAyL3MxTUoyeEFnd0tXTjJkc0psNW1aeFpDY2FCYm13V3d0OUpvNmxSaVVz?=
 =?utf-8?B?T0ljSS9pZDdhekE3d2hiSmlXY3BoRWlkbENMVjBLcnF2UTd1cjYyTlpvVzIv?=
 =?utf-8?B?aERCU0NhdEZramRqN3IySEI1aWMzQTYrNFJxZ0taK2ZCQjV2Z09TN0ErT3Ex?=
 =?utf-8?B?RE91SkVvVTEwR0JwOEkrT1ZVc1lPWks5OE5hbloveTQzZ01IclZGaEY0RGpM?=
 =?utf-8?B?bkRtRmF1MllJbG90SU1PZzhrSjdjRTNqRWp4L2RiVkgrOVE2Qis0eXZBSUJH?=
 =?utf-8?B?WnRkZllVekJldCtuOFNyMllITy80UGlFcHNUV2NTWnBHU2pDT1drcHBpK0Q0?=
 =?utf-8?B?QUpWTmlyWmNyaUVyRG1DVWJRd3lNRmNnWVBobXBVUndhS0VnQ0c1MlFwUEZj?=
 =?utf-8?Q?zC/mtaNgo6cQgpcSK8pK8Y/gX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee50c950-58c4-4be4-29a7-08ddbe1f888b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:20.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNK8gm+uycs5PeYGkMPrxK3XtBZDewYEZ4L4Jn7POkt7lt6znqeULQcdKgCx+6FT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/2/25 12:17, Mattijs Korpershoek wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Mon, Jun 30, 2025 at 14:21, Michal Simek <michal.simek@amd.com> wrote:
> 
>> Add option to disable help command in size constrained systems to save some
>> space. There is also no need to have ifdefs around CMDLINE because all
>> commands bepends on it.
> 
> s/bepends/depends/

I fixed this directly and applied.

M
