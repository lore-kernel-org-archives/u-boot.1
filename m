Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F688C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5988A88247;
	Thu,  6 Jun 2024 16:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C8BRFPzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3662881CE; Thu,  6 Jun 2024 16:00:09 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6AA88247
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvAiH1ewMCPqntl+WFjPECyLg5vEUV01+2jox1u1bltwn93Ohusn6k0s3a1pFz5yV6vgpQISvS0+EMmLNYeOTJeaGArN8LThoeLLNkBIbv1vjcXq/ccbwfDBfli+EbB90gqbmO2ZujvkoyKWb5KTVehLKQR9mBHX27N1K0rF2+EmKSVRTbkObifRfYb5EpKcGR0Twf4TyFaEbqcaMlOES3o4U7Xvw2i16UeT0T+jCubNDPELp9di/RItRi6gCPLfTzEqeeiSSoEowvX8cfmxNNeI5R/QC1cvFoLQK2tyv78H0aZJiwKN8MzgDFMfLUw+YT1yAggPgOdsXFj4jAnjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAbREFhAica61/PPQqnKQJbBhF+p/jLOkbZ8LMNAHjk=;
 b=iCFha+AGfOH7RtwdwgvGTzzPjPqymgnMuiLE70V4J5LwNZP5Ug5l/lRb0DVtJjhcBQ1PkOtCZxnEDDdefKSqsoVZiW6LXwU8+qyM4gtqiNt2o+sCCQm5P8q70CWjSU5H4zMRic4KyS5xLo2b7psZtiLwllOrvqp0rsZZ4KkXRnuP3rW++AhXAcUG/utMIsXAV8cpKXlRqYnMTFdHQTzOAT+KvO600tGSkFMKlta8FilGUymlsX0soUBVRCunFEu4BWZzf/2Xiz1WZWFFtYiOX+y7mioAiAyHXWmWIM1CU/CXZJYrXLw18ap3vTBngHue4HaK+zQ7YqJ9VTFSctVA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAbREFhAica61/PPQqnKQJbBhF+p/jLOkbZ8LMNAHjk=;
 b=C8BRFPzrDf3gPrR3UgoQiUB/FbzmtCmMcLCfkXX9GAPDG9tZ08kQSw2nxzvH9SrX7ui0AYxcQ4J3mIPTRR9MhLkGRyfi7WVWuTRux3jTGyKYvbP7o/zfipzFLwpJeZxC4XneOiTnY6kOjy4T0Lz5pv5besFoZcLsKzDi68/yGMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 14:00:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:00:01 +0000
Message-ID: <ff8e4d29-0f57-45ee-b6c7-5890e22c770d@amd.com>
Date: Thu, 6 Jun 2024 15:59:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] configs: zynqmp_kria: Enable CMD_FUSE and
 ZYNQMP_EFUSE
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-2-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0086.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d41dfc0-955e-442a-2ac8-08dc8630f50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFFBc1RGZGU2dFZBSm5zSlN3cm1kQzdQa2VDa01WMWpobnFlbmthSGxHS2Z4?=
 =?utf-8?B?T1JKK2dGSXJqV1BzcGtwZExRc2x6OUtpZjBSYmtNczd6Unh3NGVtVWlhOXZk?=
 =?utf-8?B?SjRDR1ZCcTgzbzB4N2svTDJUT3FDWjJJZGV5b1lZV081OVJVMkVTdnM1VVpm?=
 =?utf-8?B?OXlOVTlISTQ2bG9FZDUxSzNwMHU3NVp3dWtBdHNRYlNWZ1VQRVowUW5RVEEr?=
 =?utf-8?B?a0NQd0t2MGVuRG4vWFJTWE5MVmtOQ01NZldQaWhuQzJ3akMzckNUbmt0SFRQ?=
 =?utf-8?B?eUY3OE1RYTQwRUFmcDlrMHhpWlAyNEJJQU5NS0g5TnpmM01WRm9YNWY1ZU9U?=
 =?utf-8?B?cnZDSllMcjEvaEg3TGpRWUwrNzFyeCtsTXh5ZGpTdGxBQnR1WnlseHpJSHBP?=
 =?utf-8?B?ck9aQzJDakJ3K2o1cWl5Q3ErNnorV1NZUDQ2QU0yTmFhWWtGYm9WOVVmRHFt?=
 =?utf-8?B?bXFWSFNGbHhSQ3FPb1dvSy9SNTlYVldrQXZENG1jVG5GeC9NV056Ym1ORjRO?=
 =?utf-8?B?cnM0YmRTSFJ5UG13V1NUczJCYTAyL2hCZXFGREdGeTJiSmR2M09VT2hodDk3?=
 =?utf-8?B?ZkJPV3hxbHNrYU9ldXNaZmVqa2lZN1FOcVY1Z0I4M3BZTDZpQjFKZmJ6bWR5?=
 =?utf-8?B?d21TdmE1VEMwR2lGYTNDYTI2YTRLQXFpWlQzMHduSWFZRHcvaUxDbHBXWGVz?=
 =?utf-8?B?cXJvdmhrcVhTRUUxYlNZRHk5OElEdjRpTDhlcVpnMmFJMWlBTTJTaVhLeDE5?=
 =?utf-8?B?aVJ6ZVJhby8yUTVvYnk1TGNqOUNoazVmb3lpZEZqZWFjeXQzc0ZORXBNaEVM?=
 =?utf-8?B?NStnV3ZhUmRBUU02ZnhEYmRJNlNXTzFZMTBBWU9TNUdVYUJxSGtlWVgvMllS?=
 =?utf-8?B?NkY1b215Q0NENXM3R003cHVueVIvbU1ZeEc3VlRFbW42b3hqWXRXRTJYeW1K?=
 =?utf-8?B?VnZkeGwwV0xPZDlWUlhMZWJwTXFCVUlvdy92VXJCaE5tdUtqcWN1MHFjbTRr?=
 =?utf-8?B?NnAzanR6MGZuTWhLNFpZSm9HYkJvejdvSVh6UFMwWklOQmVHUEJNeGorZHhh?=
 =?utf-8?B?VGh1UGM2TjJ6MnJ1QXdXQnQrazVlYWFwb25oK2lKMGFwbkRhbExSdVhiWnZp?=
 =?utf-8?B?a1d2enIvQWJYWnhvck5SMGZrWUJHMzZ3dDNFVWRvSW5EZ3oxQUdEeEVLZEIz?=
 =?utf-8?B?T2RMOGxsSmZYb1QybkRBZW1YUW9BOVBNdUpmQVEyb1RUL0lodHJhc1FDNjJJ?=
 =?utf-8?B?WFVEOGJZU0lscDMrS3k2bjlDdVVzVnRXc3pIcFo1clA0UUdzZXBQS3UxTURz?=
 =?utf-8?B?eHN2cUtLRU9sZGRCQnFJVzJHKy9WM0ZHYlFjRUlSQUI5SmNnZkN1MFR2UEFL?=
 =?utf-8?B?a2d3SDNDcjhid2d2a2srTGFlaGpLQTdBMlBVbE5OcVdqSG9KRXAxR2lEcURN?=
 =?utf-8?B?V1dDLzhyTmpFaFZyOUNGQ09hUjYyL3ZBay9LdzBDdzR4NkxSb3RWSDV1dU5F?=
 =?utf-8?B?VERmTFhRZjNmK0xvdG1ldTN3cnBTNWREaWdRMCt3bDV3UjZiVGl4S0w0WmdH?=
 =?utf-8?B?a3RvdS9DQVFjSmdyK0lqOTlCNUtVSDExcDErQVRnTnZhQ3pGWFN0TE41NDVG?=
 =?utf-8?B?UElNOTVybm5CdDU5MTJEZjQ0M0hjUWZwZjhaSjVheVRjdGQxUVJkR3JrRGts?=
 =?utf-8?B?VVQyMkFpZGc5ZDdROER6WEQwb0oyZnc1eC9ObnNPN3dxUUR2cUJWZFByNUJX?=
 =?utf-8?Q?Nlx0DNOryTsTxeaQl4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THk3c0FXbjhmaDlZcEVIRzZFZ0c5M1ducjVJcHU0LzdZT3drcTJ3bmNMU3du?=
 =?utf-8?B?aU1VU3hLN0FFenprT3d0TlpRbXVCZnFlamxsREZkMlFUdThVOFpFMXlja3BM?=
 =?utf-8?B?NG10cnoxTlVQcDUvS2s3NVZYWGdMWlM0b2NqUFB2TEZJejlGSDB4bHZzYTNm?=
 =?utf-8?B?d1lmV1VSVFJDVlFXcHVsQW9lSDRjT3g4dnl4SjRHKzNEdUhrdVdCOHZrTjZR?=
 =?utf-8?B?UTlHMkRCVDEwenZPc2U1SkFiallRSzVsZVFzWDJDamFFK2ZmVXhYSlhHMzV3?=
 =?utf-8?B?Y1Rmc1Z6U25NaFl2a0JvSlcwdGhHc1RHRHc5c2x5c0lDejlmYlR2MU11cDZM?=
 =?utf-8?B?MUpFaVJoU21vM2xxSTdpWXZKTGlkaU9CUXB6bXlnMkQ3UTNQQkZhcUo0QWgz?=
 =?utf-8?B?VnNGUnB2dGhCaFI4dDFIcDhSanhMNlhRNytPZDhZSWs2VGMxUEkyMWFvV0Fl?=
 =?utf-8?B?bjgrcDg4cGlDZVhacEVMWUplcUhPR2dBZzl3a25RWUFXMXZsNVBzZ0toZW9B?=
 =?utf-8?B?TzJPUmh4azJSZG8xa1BHWHBSTHhTZysycHNNbVZod29kUmNjVVNyYUNHZGhG?=
 =?utf-8?B?Uk1mNzB3OGFDR3ZpejFqWkFBTytRZVdxQ1J2R09SdXY5MXlPck5hNG1NNEIr?=
 =?utf-8?B?NXdUS0d3RUlpcS9WM1lSNnRva0NGVWpsOUtVYVpYMHQvM0tDb1JadElXNHdO?=
 =?utf-8?B?MVdyaDFGS2hJWGxuc1dpL2pUM3dUZ1ByOUc1eTBraVFheTlmUy9lQUc3a3p2?=
 =?utf-8?B?VjB4ZFlEWnI2T1l6U2lEcXVpcmVYbWhMR2ZXSkIwT1FaZ0dHUXhoSEZyVkND?=
 =?utf-8?B?cHByK0xHN3NCSC9ia29JeitqMUdCNEwrWjAyUGJGUWpBZmlqZWNFck9BRWds?=
 =?utf-8?B?TVdFL2VRa08zbGRjRThCWXZMaDBoOHpXU3hsR0JqL1F6cHVwUTZnbXRpeXcv?=
 =?utf-8?B?UlR4dnVDYk1xSDU4NE1wbU9wY244czJxb0luWVQ3dWdsYTVVZHJ3NFQzeWlx?=
 =?utf-8?B?NWg3aGVJeDB5czZmdHoxaEdlTWxxU1g5aitRcTkrWWJEMCtJc2JHUHp6Sm1n?=
 =?utf-8?B?aGF6c2hFUW5QN25WSm94ZWs5Ly93cVExbVlIV0RJeWVMckh0SWpKZlIxRlVE?=
 =?utf-8?B?bzN1dXNWY0xyd3liRHBENzdOVHYwazJCTEd0clI5b3lER012YzM5UERLWlJz?=
 =?utf-8?B?eFphc05aM1F6TWZWOHVYNFVEaGdWQ3BGdFlFcGFvdXowVW96elBUY3hFZk5s?=
 =?utf-8?B?L09jeHE0dEtMQldjU1U4bVREOVVLWklKbVNwVTNBZDVnbWo0ZmhnUjFQTTU4?=
 =?utf-8?B?VGN0dW56QmlXSzV5UEEwN3FSekV3WWVONHRuNG5TZXBpcHhtQTBCUU9Ga044?=
 =?utf-8?B?bVFFUkMrNjFXaWp6RiszamxORGh1WkhUR3g4cUNweFNJZGpXWGd4UDZONFAx?=
 =?utf-8?B?R0x0SDNrTFpvWldST3hwR2Zsblp3QlFKSytySWVXdzdPeTlSV3FjZUNzVS9p?=
 =?utf-8?B?a0hBc1RvUGFOTHZnTlFrYmdCRVFpNmczRG1uems4ZHNPRG1RVUEvVFlCb1Rx?=
 =?utf-8?B?ZU91M2hqSlBrSldMK2MwTWwzMVdRanh3UDZDMW5ZSWtUM1E1R0g3M1VLTTkz?=
 =?utf-8?B?U1pWZEg3WFlmU0tFREUxeDJiT1d0ck4yYUlzYk1RZHR0WENGRlB5M3dMaDla?=
 =?utf-8?B?WDl6L2lnNU9JWFVYK2FwZUZ5RFNwUHhDWDRqNm8xYjVGVTloR0pTK1hhU2JE?=
 =?utf-8?B?QjZZNHRuVnV0amJBelZxUDhRcEVTWjl2d081eGVVQlk1VnVyYUtqMkpsZlJZ?=
 =?utf-8?B?eVpUekZQMWlDTklDUzEyaHNBUE5QcXBjckxtMkVBYnVGbGxMbHlQK0xXcml1?=
 =?utf-8?B?cjRpR2FiNjlta3h2NVVkQmQ1a0Y4SStxeEtBTi9CdUpOTWtjTHduOGVVNlds?=
 =?utf-8?B?T0w1U1NPekRRRWhwYTNlaXplSlpGY2xOVzBNK0oyUVExRFlmbWR3Y2xTd3VQ?=
 =?utf-8?B?cndidk9JNndUUnJLMDVlRk9sTjZvaXgyRE56V3MrN1BZME5JY1krREZKZUc5?=
 =?utf-8?B?U3Via0Fkc3ZoQWxoWG92YlpReXFTQ0o4NE9nYjFVVWxtZGt0bm53VE9QRGZv?=
 =?utf-8?Q?PnGpu2Gur66LfPTpGA8yvlTbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41dfc0-955e-442a-2ac8-08dc8630f50b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:00:01.0215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D6sWdqM5XX+KQOV5GHhXFd4Rv+9eIbjpYic7cG0PuMmmfWkwUPTUayE9z0n2zeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Enable CMD_FUSE and ZYNQMP_EFUSE in order to be able to write
> ZyqnMP eFuses from within the bootloader for Kria SoM.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   configs/xilinx_zynqmp_virt_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index ee87beb19c6..1edd4ac77b1 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -65,6 +65,7 @@ CONFIG_CMD_DFU=y
>   CONFIG_CMD_FPGA_LOADBP=y
>   CONFIG_CMD_FPGA_LOADP=y
>   CONFIG_CMD_FPGA_LOAD_SECURE=y
> +CONFIG_CMD_FUSE=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_PWM=y
>   CONFIG_CMD_GPT=y
> @@ -147,6 +148,7 @@ CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
> +CONFIG_ZYNQMP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_IO_VOLTAGE=y


The patch itself is fine but it should be after symbol is defined.
It means Kconfig change first and then enable it.

M
