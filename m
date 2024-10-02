Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A98CF31AF
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 10:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3F888D1C;
	Wed,  2 Oct 2024 12:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OkTBUgtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 896C788CA1; Wed,  2 Oct 2024 12:23:33 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2215A88D38
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 12:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJXGcwzZ06zzPdqRynDjYz9R5sUU3+ngvpHd5KeUzBthRwivlrmvye9XxWfdLODskEbO+n0sLVOdUtt6zHGG0QQG27f+x7Eprys+ymOrYl8r1pu/sTJYOLTO1qj5IQm1FU3LNyahu+UKFfLZwPFLXPPac/v2Xcbzh22syUS7MuU6Whj2VoRDHNPHZl5p5a5XMjjgVZocNQfZ/AQEkVYYB2JJpSJlKlIxcYdEW8PfHSa/MruMoLQhyCZjg/YIErkPg5XZGdTcah00R+kk6vUZdJlF+hsZCvSePeXnd7MCakmVfMmLiTGljb3nbhvAzjVaDushRbMjObjnMdLzs7ceYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1UAV/a69m0iM21SguGsOi2eqXvRygjMRqW0AMJmRZI=;
 b=dssC87BCfOCjJgDXL3WBbmA1u2CLliioEGlwxTMlOHRPFQUC4bCXXjAjfcq2uQX+Ua6ca+r4Z6MooyD10gxjXLFHp6gNhCVXjbgFkf693cn83v5B79vhpPzbx4ufGzeb9E5hqMbguqcotlbRa2ejPChjUlXQ9t38kFDkHCxfM4FGwInWkr7HuVeXPMO/hC/TZKO74tzCF4EC9RA+rf+TI5DUV0UON0kP5D3MRd5A+l1Uj0ROyGm4sAVFT1xrYTRZMf3EMYA5Qq7gTuikWwvLsd9hsnHgYbFY3ihI7cpkqmwI+qBTLqnvYrJnd7JjfMmjFMkj4LuFaQ4RJshn7clJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1UAV/a69m0iM21SguGsOi2eqXvRygjMRqW0AMJmRZI=;
 b=OkTBUgtS6Q1f2Qb6S4q9xAFKd1D30Nb5QoOslkpw8bn0trc/y0+Pnm+NqjYx4OcqC5xKb+Bq67oC7fhB6yvFhkCB2Humaa5O5hnefw398QtLa+MMea4aRFnWGk2hiQKjhHPavuZFySSyqf10jHkA7mTV98M5wP2RQYma0kdO96M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 2 Oct
 2024 10:23:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:23:28 +0000
Message-ID: <2545ab99-d861-4703-84ee-44d91131780b@cherry.de>
Date: Wed, 2 Oct 2024 12:23:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
 <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
 <20241002-wrecker-commute-f1fc4ae3df71@thorsis.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241002-wrecker-commute-f1fc4ae3df71@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 58567435-e16e-4503-caeb-08dce2cc4192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2NreG9uMTh5dnNpTmlzL2Z5SyswNVQwVG9zNEg2ZlNCbEg0TlpBUkg1TUFD?=
 =?utf-8?B?ZFo2TmhFL2xkMDVzU3l3Q0hpQ2FJdW5SWHF2OUQ5eE5aNGZkcnNjeGxSVk92?=
 =?utf-8?B?bkdSZ0plcXc2WFVnV1lkN2hEczNYUWxLVXVYZHNvNllQbi92QmdWZmdoR3pm?=
 =?utf-8?B?a3o0T0tRNERhak1zajZJcTUxRHFEOFUwclZIenJ1b1NGcVpKWmxBOEFSRmE2?=
 =?utf-8?B?eHdURmxYTjFLdkc0Rmo0TGhhcU1OUjQ1RGdXM2tOZXR5b1J0U2NCMGJKRHd0?=
 =?utf-8?B?SnkzU1FJaVpmayt1WlpsVlpxcXFnZzZ1RUNmRUh3RDJGMUV3aFdLL1g2ZWhC?=
 =?utf-8?B?dFYwbUw1OXB1UE5RQVJycVg3cEVQaUJyeFJUTEFhdXVIaTVzcTE1RStWRE5r?=
 =?utf-8?B?cXdvSUFBRDB2bkF1QUd2MTdENmgrSysyYVRHZ1krbDF3NnlrM2pJUDRMZDg5?=
 =?utf-8?B?Q1hTa3IrL3lCUDJ6b2VaQ2hseUNyYmt5eGVkOEtxSGJoRWpCQlVlRTEyY0Fh?=
 =?utf-8?B?dXBlWEVHcU83K3RQVE9tOE9CL1JxNWNmdyt1eCtpNTlIV0JDc0x4RSs4UWxl?=
 =?utf-8?B?b1hpUXZLOUNqVyt0TGVzUnNiREpXd1c3MHA4WFJIZSt5WTlBZ2NrVDRUUTB5?=
 =?utf-8?B?QXBjOStVaFlRZUczTE1FUG9ndHB0WUc4YkNtZzE1R2d3UmNSa3JXejlkN0hn?=
 =?utf-8?B?NDBYMDZnV1luaklqcUpzdUpOU1h1Vm0xSVFJWEQ5Qm41VUxGOGRMSmZzMkN2?=
 =?utf-8?B?OUpycXZueU1wRDlxWTZTcUEvb3IvbS9UcEVkMk5RZnRNUTFtY1lVLzFickN0?=
 =?utf-8?B?ZDVVcUNiMmtWVnNuQWQrSzgxZDRkK1kzYUZ6cGJyR3VwMFdXdm54Tmd3eVRZ?=
 =?utf-8?B?VElxWWFFTi9JZ1dVcE0zd2t5dDZSSVFkampKbTFuVHo4b3JldUZRSnpucmpC?=
 =?utf-8?B?RTNXd2JDQU1Sd1BwenViaWx2dHdzcjBSempkZVh6YnZyTk43TVU3VE5RRk13?=
 =?utf-8?B?SjRXWmVDRUVTalFtWjR4dnhhNXJ0a1I4czdsYUFQczdnd1BsU1N0VUVqcjF3?=
 =?utf-8?B?SG9JOWNYSGRiOXF5TTUrNXVGMUo0RFFVaDBXNWswNTR1Z2E4bVBia0w1UFZn?=
 =?utf-8?B?bFJyamxvY0lySTRUSXNqZHoyM2xFdmRmRTZSRzZKdGh2T3ZybWQxSDRUVXFD?=
 =?utf-8?B?UHdiSVE4elVKazJQYlJkTHc3cnRKcDAxblhKVmoxenFwLzdacG9jSys2TDdM?=
 =?utf-8?B?QVpBcStUNVRXc3lXQ3BYdnhSVGkvN3MxekR6aDBJNEZUczVpWUZlNlMzL0FH?=
 =?utf-8?B?YkJFY042S0FDR2VaamFmcWJTWVhkelArcnpDeVNrem5pd0IyQkhneEJqUW16?=
 =?utf-8?B?YVdWNWRYR3NGTzREMU95VnFZRHorK3dsdGp5QXlhd2tEbnFaamFkMUZyL1V0?=
 =?utf-8?B?bW9PdVFNQUJXdkNIbUYrNzFOckN1QncwV3cyRjdLUTBPQUVjLzI4TkhXQitL?=
 =?utf-8?B?NmpUblBuYnJlL1RlUHZpb2srSm90VFBYU0lBekY5UE5rZjhBbWxGQlMxSTg4?=
 =?utf-8?B?NkhEZCtic1lUNHB1Q2FjSFNtY0gwL3ZkQVM0Z29VRGNjdGJzeURPWWNsZUho?=
 =?utf-8?Q?/9oWzBpGyFfhnFlX1v9AKdSyj49rueKN31K0orz/tCQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRGcWpuUGFzaEpCQ21lOG1mZklsTG9RbVQ1UWt0QVFndGVacXM3eEpZSTJo?=
 =?utf-8?B?Mm9rNG1uTmt3M29PMnpiUzFDMEs1ekFoNXg5QnBMU0pUL2g3ZWgyWHRnOUxE?=
 =?utf-8?B?cldkOUkzb1FXTUNWeHpRQ3QwYXdHN2N6a2RLN1N5bXBTY1lXQkY0RjBhR1ZY?=
 =?utf-8?B?NXZaUEcvdzFybDJDcDNPdlpESUxmbUxSRk5reEpWbEU5c2RZeTM0azRMYWEv?=
 =?utf-8?B?QWZibzdid1dFRjVMQXJhcGFnZm9kblkrYUhMbmprQ3Fxdy92SHk0RElLaEUw?=
 =?utf-8?B?S3UzeXFhakRTbVk5UHdGeTVOUTY3Wlo5ME0zYnBoWGt3VEF6d0R4TE5rT3pu?=
 =?utf-8?B?cTF1RkR4aGJJMFFtZVRyVmhGcmgwalNmTzRDQmdwejNrajFoRytFNWV3dGxs?=
 =?utf-8?B?NEF2QTQ5SjEwTDlFVmVROWUvUTh5K2JxdUlkUnpuUmIwTGZPUXZ4Ump4dnZY?=
 =?utf-8?B?RVFzNm1NSTh3ZlhJbHVVMy81Q2RSTDZrSmpJcXhNdTljOU4yKzRUZmZ2TXRx?=
 =?utf-8?B?dnBCQ0x2QWxnKzNPUjVMUzRrbUxiclY5bUlFdXVVditZRlR6NHhVTXVxUmZw?=
 =?utf-8?B?cUxqY2N2N05rUkVzN0VDQVBsOTlEZEpSdFpDVWc3T29kYUJOdTRMNi9RTUl3?=
 =?utf-8?B?VmtPRVZHMVhiU1NrNzFUZ0F5d1VlelBWdjZzbHhBWkwvVkM5ak1udWpyL2Zs?=
 =?utf-8?B?RzduVmpYVWRNTG1vV0NEQzFDaENoclZaWHFRajRWSmhlM3RuWnJ3SGZTU1kw?=
 =?utf-8?B?TVpSUVVPdXhucERaY2ZxMTk2cFVuUDRCNmxXTGlSYWo2OGp1ZUZBdktlQ1Mv?=
 =?utf-8?B?NjJsUzVldjFuMXRlTUE4V2ZqRXlmOTRrVlNoKzJuU0s4THFMQ2V4dnF2ZXhl?=
 =?utf-8?B?aXR5Rlo5WWhiMWZYeFd1NXErNDlhQkl2K2hIWEo1b2ViT0I2eHNzd2M2c1BF?=
 =?utf-8?B?VDVoME1PeWNrdi9NWlkrM0x5a1JxU1dBS2FkSWxZVmNrTTlZZklxVnpoemFV?=
 =?utf-8?B?NFV0NWFRLzlIYnJNVU82RTRMRW5yRmNUcGVTWGJTM2NuZmFIQS90THl4TjdM?=
 =?utf-8?B?YzVTVVhEN0JkaG13cVJWL0d4eHB3a1hKbGo0cWx2TWZZQTBFK0x3S0tIRGtI?=
 =?utf-8?B?SmtMdzlYelZzSmxvdTAyRHlNMndjaVJvZTdtNFlPMTNUTVJxTGhkNUFBZHNR?=
 =?utf-8?B?QmlCK0ovMWhBWU5GNDZvM2QyVXVrSVQ0ZzJoSFo3cXlPRS92TVRFQ3RMdXdG?=
 =?utf-8?B?L0hMSm5tWm5aSGtiT2hORUlEUUJ2K1N4cmYwa2dMTisxMFJkQkFKcTZMazVB?=
 =?utf-8?B?OEtIcDRlTU1mMDJ6MlZWaDZxZ3FDc3R4ZG5DRzJYZGt5elRZRFFVaFYzT3V2?=
 =?utf-8?B?ck1nRDk4TUpDNkVENlJwK2tXc0VvbzdZUnZFbW9nUndFSjA3dUZuUU5ZQ1Jp?=
 =?utf-8?B?c0JzWFJYWGhGa2oxL3QrTXNMNFFVcTcrVUlZM2FlS2R5QThnMVVrelhmRVU3?=
 =?utf-8?B?TkNObk00Z1BaZUZEcklxRmVraTN3aldXVWo2VXVmWHpDbTQ3dmZsTHUrSUV3?=
 =?utf-8?B?M1VDeVpWdE1hRW81VEhJdiszWlROalJEcU5LUFRzbDM0S042VWg3NFU5MHla?=
 =?utf-8?B?bU1mTXM3SkZMZGczL09BaWp2TmJCdWkwaGhQRXBaRjh4NGVSRVNnZ2N3MmxT?=
 =?utf-8?B?TldYb2RDUU45Zm1HZjdTUmlRM1Z2Rmh4aTNiNGpMVDRJQzdFYUFVZ01jRi9w?=
 =?utf-8?B?VnNwSEpFZ1hxdlJFbkFka05iSkp1QlV3ZlBPV24zYkd3b3U0c0N3NFlIQnI1?=
 =?utf-8?B?VTZHZi9jZ2QyOCtpMzdsN3lYVitWbi9kTWFiRks3QWxaRzNkUjVQQUgyV2ZQ?=
 =?utf-8?B?d2tJeVZHY3hUUk90NnkxK282d3U3Y29qUzBqWFVDZktGOGpEb2ZBbHM5OXNX?=
 =?utf-8?B?YVVSKy9qNmVENkpVdE5sNkxtOEFEVU9GZGNIUXRtc3R3TURGU3MvYWVNbFJr?=
 =?utf-8?B?UitZRGgyeWxZVmlmMk5zZzJQWXhEb0pkdktwKzA0ZGtDMkdVRHduV0ZOUGVO?=
 =?utf-8?B?VjhLRTdpTm84cXpFZ0pSZ1cyQkx1VHpjN0JBY3JhVXZvSEJXTm0rSmVWUG1j?=
 =?utf-8?B?dEViOGRpdWRvS3RGc3ljMFhvb2s2bEYyMXN6TnF3VmVoN2x1UWdTdnhyV2hM?=
 =?utf-8?Q?YvlPNxwCz+04N+JH83URfdI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 58567435-e16e-4503-caeb-08dce2cc4192
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:23:28.2553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne3i42kqUHEJyFCw0l61jkkQn/h9/AktZJQMpa3DfaOCaWJ+bcZ6ZK0sZn2GH3wYGjb2MCGYaZYRNNZPiz65eW+moXPz4v9YbV+5iE4fMtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
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

Hi Alexander,

On 10/2/24 11:51 AM, Alexander Dahl wrote:
> Hello Quentin,
> 
> thanks for you quick reply, see my remarks below.
> 
> Am Wed, Oct 02, 2024 at 11:25:38AM +0200 schrieb Quentin Schulz:
>> Hi Alexander,
>>
>> On 10/2/24 10:37 AM, Alexander Dahl wrote:
>>> Hello Quentin,
>>>
>>> sorry for being late to the party, but I just tested v2024.10-rc6 and
>>> my console output looks like this now:
>>>
>>>       ofnode_read_bool: bootph-all: true
>>>       ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: false
>>>       ofnode_read_bool: bootph-some-ram: false
>>>       ofnode_read_bool: bootph-pre-ram: false
>>>       ofnode_read_bool: bootph-pre-sram: false
>>>       ofnode_read_bool: u-boot,dm-pre-reloc: false
>>>       ofnode_read_bool: u-boot,dm-pre-proper: false
>>>       ofnode_read_bool: u-boot,dm-spl: false
>>>       ofnode_read_bool: u-boot,dm-tpl: false
>>>       ofnode_read_bool: u-boot,dm-vpl: false
>>>       ofnode_read_bool: bootph-all: false
>>>       ofnode_read_bool: bootph-some-ram: false
>>>       ofnode_read_bool: bootph-pre-ram: false
>>>       ofnode_read_bool: bootph-pre-sram: false
>>>       ofnode_read_bool: u-boot,dm-pre-reloc: false
>>>       ofnode_read_bool: u-boot,dm-pre-proper: false
>>>       ofnode_read_bool: u-boot,dm-spl: false
>>>       ofnode_read_bool: u-boot,dm-tpl: false
>>>       ofnode_read_bool: u-boot,dm-vpl: false
>>>       ofnode_read_bool: bootph-all: true
>>>       ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
>>>       ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
>>>       ofnode_read_bool: bootph-all: true
>>>       ofnode_read_bool: bootph-all: false
>>>       …
>>>
>>> This goes on for several screen pages, and clutters the usual output.
>>> I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
>>> All I had done was setting CONFIG_DM_WARN …
>>>
>>> Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>

[...]

>> The issue I had was that in order to be able to see those messages, I had to
>> to select DM_DEBUG, which does much more than just enabling the debug log
>> level to be printed and eventually makes my boot unsuccessful (see original
>> commit message), which is not acceptable :)
> 
> It just adds -DDEBUG to driver core cflags, so DEBUG is defined in
> preprocessor.  What you call "much more" are only implications from
> defining DEBUG, right?
> 

Correct.

> You wrote in your commit message assert() calls fail.  In my
> understanding those should not fail, and I would look to fix things
> leading to failed assertions.  IIRC standard C lib help texts say,
> assert() is only recommended for helping programmers finding bugs,
> because it's a noop in non-debug code, which would just hide problems
> and making things blow up elsewhere.  IMHO if code fails due to
> assert() you have some serious problems you should debug, not "solve"
> it by disabling debug.  In other words: your boot should also be
> successful with DEBUG/assert() enabled, shouldn't it?
> 

That's probably true. But I want to avoid the situation Hal from Malcolm 
in the Middle find himself in when trying to fix a light bulb 
(https://youtu.be/AbSehcT19u0). If I want to debug asserts, I will 
define DEBUG and start looking at those. If I want to see debug messages 
from DM, I want to see those, not that suddenly I cannot even boot 
anymore (which may make debugging impossible if the assert fails before the

>> Can you explain what you're trying to achieve with DM_WARN enabled so we
>> have some idea how to properly fix address your concern?
> 
> The help text promises warnings I wanted to see in my own drivers or
> drivers I patched (very few), so I don't mess up things accidentally.
> Up to 2024.07 this seemed to work fine.
> 

Is it possible dm_warn is being abused as a debug tool here rather than 
defining a logging category for those drivers at a logging level that 
you'd find appropriate?

You could use log_* functions and define the LOG_CATEGORY in your 
driver(s), but... we would still have the issue with global log level if 
you only wanted to raise the log level for one particular driver. I 
guess this could be done by unsetting and resetting _LOG_MAX_LEVEL to 
the level you want, in your own driver? That's as hackish as setting 
DEBUG in the end :)

Are you really trying to keep track of DM core messages related to your 
driver(s)?

>> In the short term, i guess we could simply define a dm_dbg macros which does
>> log(LOGC_DM, LOGL_DEBUG, ##fmt)
>> which would also replace those instances of log(LOGC_DM, LOGL_DEBUG, in
>> drivers/core/uclass.c.
>>
>> However this means that all those messages would only be available if we
>> reach the global log level to debug, which is very verbose. I have not
>> looked deeply into all those messages and their contexts and wouldn't be
>> able to quickly differentiate a debug message from a warn message, so
>> replacing only some of them is not a small thing to do and is error prone.
>>
>> I guess what we could do is have some sort of kconfig option for log level
>> per logging category? Or in some way define log filters at compile time?
>>
>> I'm not entirely sure how to go forward with this.
>>

@Simon, do you have something you could recommend or some idea in mind?

>> [...]
> 
> Not sure either.  I certainly won't mess with driver core.  My
> short-term solution will be to disable CONFIG_DM_WARN for now.
> 

I would see DM_WARN as a debugging option and would do the same.

>>
>>>> @@ -508,17 +509,17 @@ int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
>>>>    {
>>>>    	const __be16 *val;
>>>> -	debug("%s: %s: ", __func__, propname);
>>>> +	dm_warn("%s: %s: ", __func__, propname);
>>>
>>> This is no warning at all.  And there are tons of those changed by
>>> this patch.  It ended up in master as 6afdb1585112 ("dm: core: migrate
>>> debug() messages to use dm_warn") by the way.  Please review again and
>>> assign reasonable log levels for all converted messages, otherwise
>>> the destinction between DM_WARN and DM_DEBUG is useless?
>>>
>>
>> They are not exactly related, that's the issue. DM_DEBUG is not about the
>> log level, it's about enabling all debug functionalities (of which is
>> enabling the debug() calls), which renders the boot unsuccessful on my
>> machine (see original commit message).
>>
>> The second issue is, we could assign different log levels for DM, but they
>> would be printed only if the global log level would be raised above the
>> level of said DM log message's level. This means to see those I would need
>> to see ALL debug messages using the logging framework. I think something
>> more finegrained would be much more useful, but that's also not a 5min thing
>> to do I guess.
> 
> Isn't the logging framework capable of this already?  TBH I usually
> add '#define DEBUG' to modules I want to see all messages for, and
> remove that again when done with whatever the current task is.  DM
> just makes this easier simply by hooking it to Kconfig.
> 

I believe adding DEBUG in DM core would result in the same thing as 
there are many asserts there in addition to the debug messages :)

The logging framework is probably capable of doing this through filters 
yes, though the documentation specifies how to define those filters at 
runtime, which is likely too late for debugging drivers?

Cheers,
Quentin
