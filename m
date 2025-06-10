Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63318C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD90882B0E;
	Tue, 10 Jun 2025 11:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NUluIWu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A87082BF6; Tue, 10 Jun 2025 11:56:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1B08070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCvlFG4oZPY9sIyvefy0xsmX61xlYZy7CIJz9cAjnaqFrBiRgI8m3hF/zIy+4A5NAJA+Cp44jBztv97j/s9uApsCUzOfJtUbQL2q8UjKkDr0bGoOSz+Edii5Yw+V9rDIaimUNuAxPYvInq8YkkK4HsVYGbjwFSnW3QoogmS50q8zaYkL0pcFmvolmVDgcwZmNSWTUP4oQIBtxRO4FhZ/VF6m+C31ri4qScgAKtbf0pXuLf9WhXfHs2p2CIE2gBYwlMxAPtthyf49G/QMdBd55sSzZF4hGpPryOeUDdqNKnmsaqgo7le8Ht4C+wx5BWc/nz6NBRspDAjPWL8ZGYnW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12XFQOuf18yLUx5mG4HxEK21sd5RRo2DICzwsBvhsuc=;
 b=BTxCJxuDqfuSvWVmpr68t3iE+/mpR95iuL7f+yDR+aR9oj7mImSuBuu3GqLX34mWpmYXB0BlkHw3qgwjZAUZlbdKist7SKYSGA7qXqKC1HHWg/sxudC2T6sHyb1j1dum80yjEjtM+sRJDtAi4Kg4qDJkc01CSu3zs6jluizw1sv4PeaBsLi8IA6R1i17+9moE8cg+Tg07H96kjskKmi9Cid0On6s2/5xM/679oiCiih1E2mDJ5A44yMJwQbBET70HTWOqhMMdLIy1BWU9keRv64Ye+qTkTFyM2nx+H8udpGMQ0l8DK8rsbbKev5P7rFLI5L6F7SlUQINSRGLtCovTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12XFQOuf18yLUx5mG4HxEK21sd5RRo2DICzwsBvhsuc=;
 b=NUluIWu6MDjTQKga5tfs4dgZrAWZfaM63HWG3OgaSOYdUMYTCvzEfDt6YsjXvXQcv7/FZEMbetfqUW46cAPkCmUWLfLqwo7z44RoLg6yAnuzVHllQbiYqoXbgVMHKCz3AezotsynNEwFNbGwaeQJSXXPrf448pjfPkAQiX+ALv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8905.eurprd04.prod.outlook.com (2603:10a6:20b:408::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 09:56:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 09:56:49 +0000
Message-ID: <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
Date: Tue, 10 Jun 2025 11:56:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: MichaIng <micha@dietpi.com>, u-boot@lists.denx.de
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0277d1e5-0b18-4b8c-615a-08dda8051e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjBJOGZ4b25EeExVTzJtYXBYSHJMaXczd0dUd0pDdEtoR1cwcDdEMHhmWlpx?=
 =?utf-8?B?cXdwRGtKTEk2dlJHd2tZSFFTVVNXMDFvVmEzbkE4MjhrQjZvTU5QSHNmSEVK?=
 =?utf-8?B?MDBjaFowSnJQSzNZeDZMblIzYUN6V2VMQ0hwUHkrdU9NN2ZoWmJQUXlXTjUy?=
 =?utf-8?B?ZXVIYzBTR2xWTHBuLzhGdHpvbmtUZlRqTGdUYm0xV0U3ckZBUmZSTjRpZjBC?=
 =?utf-8?B?dXczaUhyVXdKVkc3QWptWXRKNTVyc3BFclFpUExtem9rVGVUWkNkTXpyTHFh?=
 =?utf-8?B?a21BaklqbVk1TTc0YzJDeWw4dUc4ZXZxem90OVNVR29JZGUvRzlhc3VBOGV5?=
 =?utf-8?B?MVg3b2pPNHl1bE80YzJUR1p1dDVFK1l6TzI3RnlZRnBUejQ1VkxyZCtnekI5?=
 =?utf-8?B?QkpucUtudnNteVdxa1JEdTk0NFV4MXlQRWc0K1ZpNzJ4Tkp0aUhESm9yaHJy?=
 =?utf-8?B?Qm9iMWlteFNPTkJkcDZ4TjRvUEZqbVZlRHVRajFydVd1MHYrTWwxbWdEVlB0?=
 =?utf-8?B?SG8zcnhLM3V3UGFjSTFuVndGaTVXNUNQQXdTSDBLS1JTQ29QaE1VSElCcE5F?=
 =?utf-8?B?dXd3a0RUVmZ2YzQwQm9XS3phYUZSTlBnZEFWN2diQ0tEeUVQY0o3U2ZGd3BG?=
 =?utf-8?B?MGZ5dmtLVURMS0Nqa2FDZmgvanI1WHhhWFdZN2I5OE9Qb0FtaGN2bWhUazJ0?=
 =?utf-8?B?NnhIazRlTDhSYjBmUURxWXFldmxFdUJ1OWw3bEhsWGw1WitZaFNiNHNUWEZ5?=
 =?utf-8?B?U1V4c1VDSXdxV1lmR2NwZWFtS2puNEs0cHhtMldFYjFFZ0xLaENYTG16c2tJ?=
 =?utf-8?B?RGIwTjBKWEpuN2lJRDUyMkRXT1ZLem9UYTR4ZHllL2VBZWo1NEZWdjdscHRV?=
 =?utf-8?B?UGFYOE9rUC84eVMraHRJVEhqRTRzbTJtSzg1MzdKQlVVWXhmdDZIdHdFc3k4?=
 =?utf-8?B?UmJJRklnRkVxZDl2VWNwVlJ3Q2tsMElaVEs1UUNOR3lUejlFSU9XYjc2aHk4?=
 =?utf-8?B?NzRhejlleXBWeU1saS9kZ2JYMjBhMnR2SU1KZXE4VTZzSDlwUm9yb2hyOStq?=
 =?utf-8?B?QVhpaEI4Mmh5UE4wYXdXZEhsTzdSNyt1K0xoL1IrM0lXVTNOQUk0bkwvOGFP?=
 =?utf-8?B?N29pQ1Zva2NheTBjUE9wcDhVQWQ1UnlDZW1OMFRxVUUzWnBkK0RyZjU5azZK?=
 =?utf-8?B?b2VpN2tUbXYyYVJLeVlER2htdEFOQUE2elNpeVNsK3A1ZnpSWllQaDMzcE4x?=
 =?utf-8?B?RjRwc0VYVEd3ditlbkV0TGk3cXlVMDRLeHh3WUJNOTlZVmRXeHdtMU40b1Vq?=
 =?utf-8?B?Z1VINXo2ZG51REFqNHVSVkNuTEVRVmxFcW5GblRieFBoT2ExU2hUVG5uK3FP?=
 =?utf-8?B?MURQSlBBSEk5eDU1YWx2aUk4eWN2a3h4NnA1Y2VJLzZYMVBqWDNVV01xZ0Mr?=
 =?utf-8?B?MVMyY0lKYnJvcUYzWElwQWRzRG1PMGp6eUVHNWg1MEJEdzBTcFZpUFU5ek1B?=
 =?utf-8?B?ZGRIR3FDZGgxTFBJQlBxNmVLNXVBSXROZktNOGFqUWh4UU85Z201L0JSVmVM?=
 =?utf-8?B?UEhjSExGZUtnbElyUXVobGI2aFhsNHYwVXZ1cG9RMXk2d0NUS2NTWHlqTCtl?=
 =?utf-8?B?Sjk4a3ZVMjc5VmExZ2FpZU9FeEI5SDE3MUpsNERRa3IvelpZZEE1Zk0wU013?=
 =?utf-8?B?a2JSdDJkMHZpY1gyM3NuaWdkM1pBUlNFNlhiOEdUd2xzMURFWnY3aDFIazBK?=
 =?utf-8?B?OGtLNVg2UE5VZm00MTZOcERxSGkrMFcrZWIrVm9LVG03dFVqRHJLRll6RjNV?=
 =?utf-8?B?UHd5OU00UkNpTllvRG5tNFJmTEFCNm9RRW42VGxPR1EwaEtrWW1SQkYzbUZp?=
 =?utf-8?B?R3NNWVlWNkVDUUtOZXdYVkk5Mk5TQ1l6elRSeVJWalNjblE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVaM1UwSGlTcTRieDF5dVJtd1ZnZmlPTjEvMkF6cnRZbDY4d21VaDJOMDF5?=
 =?utf-8?B?b21Zc0NoTTBvUzFiLytSd052TjZoN1JBajVYdDdDbGZqMjJ1bGI4eTZPMDdZ?=
 =?utf-8?B?YjJOdFAyNzVSb2xKcDZHUk9IOUx4TW9OQkluNlZlMk1zUm84ZXlBTkE5S3ZX?=
 =?utf-8?B?OFBMQndJWGJGUUVObGJ4TE5zdk9ZNmwxVEpTSzJ2QXdlWEU2V0hiek0yVzVE?=
 =?utf-8?B?Yk0wNkRMQ1JZZUFKNkZVQkV5MzJQc2VvL3ZPcnhXL2Q1QXI2ZEhLa3doelJQ?=
 =?utf-8?B?SWdOclc0TXk4NnI3Q1JJTmtSUlpwbkM3NUFCMWRRNk5ubmMxeEVPd00zT2Ex?=
 =?utf-8?B?MGRpcW9IMzRoNFZONjdUNUVrUllvMFRiaDdTa2RRbThpZ0ZiUXdGQXVDN3Jo?=
 =?utf-8?B?YzFWcVFFZzVNWXloU1UvQ21oUGtRdWIwV1dac0Q5d05yb0h1Z0ZjOHgzLytJ?=
 =?utf-8?B?MWM1dGM5STZtZGJkQ0N3R3N3TlB1TkxpenNFa0RkNkhYbnFtWHp1R292QUtN?=
 =?utf-8?B?RlRjSTM4UndPemtjK3RmUHpUd2ZDaXhIYnV6MFdqWkVjdmFCQk9xaUVoNFFs?=
 =?utf-8?B?TGxTajZWRm1hazJ3WjF0RFdON3pkSTF5NGpUT3IxZkRHaGtPVFhTbE1lZUJu?=
 =?utf-8?B?NllIOS9XbVp4cmN3UGF3QmhzYmRkYXRzV2xpdTZQeTJmc055ZWI4emRyV0k2?=
 =?utf-8?B?N1VPdnlkQW1KeThqY25xWW82dks5bjJTdGFvdUFNeFFFVmc5QzQ4UjZmSlBt?=
 =?utf-8?B?cXVrd2lFK0RvSGkxSEVmczdndXlNVjc2akZwM0RVMnF1U1hjdnRqNVpqVkhk?=
 =?utf-8?B?aXU2OFZjak0yZHJGNVh0WVk1QVpNOTdJeDdKc0hTTnFjQzZaSkRWdDl0Mk53?=
 =?utf-8?B?bzBUNzVDc3piVHpGcDRYZFFTQ0FpZHhJUVRCdXNzbnVtK0ZVZ0hzVHY3aGNk?=
 =?utf-8?B?M2NIcHdOVW1odEVEaE9BeTRrbWwxVy9hclY4Smw5Qkt1aGZiOWpZd0cwNkQ1?=
 =?utf-8?B?Zk1iUStqQmhBSGRFR3BKNXQ1WDhUckpFcFByUzl6azdFbkNGcEpKbUdqM2xI?=
 =?utf-8?B?UktwbmpPMmI1OE9ydUc2OEdnTytkOUxjTTBBMHVRLzJUQktHVTlyRWZKTFl2?=
 =?utf-8?B?cXNEK0xCZlF2aGwzdUdJTS9ZL1FBYUxjOVBKbnBVZE9NSUxGL1hXWXFXRDhz?=
 =?utf-8?B?Z3owbFdMcXE3N1JLcFJteEd0UUJ2T3VxRmVpV1VjeEdpejltTW41MzVTVEVy?=
 =?utf-8?B?ZHNQU1AyVkYyWVZsRlBteFpWekdyZnlYRzFKTXhmYld4eS9GZ3hHdmlLMXNJ?=
 =?utf-8?B?VjVQK1NPbjVZVnZGaFpMVUJMMWJNaWFheUhpeGZHK1VVNy9QYm14KzdvM0o2?=
 =?utf-8?B?cHU5b1ZQRXBPQkpjMlhZVnZhTUw0SGNNV1VvOXlnZ001RGVsdmkxcHU0blJY?=
 =?utf-8?B?VnoyeC8yaVB4ejF3NkZwV1ZTSVFPU2lzYjU2Tzk1cEtMZlBtdGhpMGdKNlhX?=
 =?utf-8?B?U0hTQllWQmZXRkRGOGJ1Q01kTTMzam1sY1RkS0ovYitidWRDWHFjTGthd1Z5?=
 =?utf-8?B?dDZvbGQ0K3lsTjJuQ3lLdnl5am1BY1ZvWWV6ME5aYTZiTDM2c0pSdHhDZjZO?=
 =?utf-8?B?MWdlUzBMd3JzQm5wVnVVUE5mR3JrUjhhSmc0d1lRQXNLMVg1dmhrZndYSUxj?=
 =?utf-8?B?c3JkV1UwLzBCd2FrelBiM1VXRVZXdmZNV3IyNkR2UkI1bXBBWW5jZUlydDRW?=
 =?utf-8?B?dEkyL0wzeHdzUFgvdnMxbmdRbnVuOUpsM2NpZGVFU3J6dXlNUmJEQ295NE9x?=
 =?utf-8?B?VHlOMTZUWW9TeGphVUFsaEhSWmRYWlJBVWpaMVNhRUR4TGxpRVgrb3RYUzZU?=
 =?utf-8?B?Q1FSTkFvalFUVVZXd2lKcitRNjVVaWs0bTB5aERKc3VHRERiQ00zckJULzAz?=
 =?utf-8?B?QXdnODNFRUVWVUZObXRnZUpzWFJaUGt5dDNaQ09Obk1Dc0liZVR2dnVKYitY?=
 =?utf-8?B?UHdNN1lSNjhLQUlBazRmdWF5NU85OFAzRFZEK3R4Tk1kZTZDYTJFc3hWYlRx?=
 =?utf-8?B?ZHJxWTBxbGZ0SnRTWURiNTZIcUczZXo3Zkc0QXR1Z0RQWnVEZ3VGekFWYWor?=
 =?utf-8?B?Szd4MmFuZnJ2VUNvZ2tOVmVTTnV4RTJmUFhwSWpHQjFxYzBkeE0rOWtvMWFp?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0277d1e5-0b18-4b8c-615a-08dda8051e37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:56:49.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrIisEBhyB9GichTAY1SpG5suCuSSX4xMdalyaAGlWJ4s2LFs5TzDxixGyOwQW7WbPKrqKKcqW9W5A3J1/UXku8hXua8FzWDy2o+adOCgcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8905
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

Hi MichaIng,

On 6/7/25 7:11 PM, MichaIng wrote:
> [You don't often get email from micha@dietpi.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Some SBCs with Rockchip SoC provide 3 Ethernet ports, like the
> FriendlyELEC NanoPi R5S and NanoPi R6S. U-Boot assigns already eth*addr
> variables to ethernet* device tree node aliases, but for Rockchip
> boards, it generates only ethaddr and eth1addr so far.
> 
> To allow the assignment of 3 static MAC addresses, with this change,
> eth2addr is generated with a logic similar to how eth1addr is generated
> already:
> - eth1addr is currently derived from ethaddr by inverting the last bit,
> which raises or decreases the last hex digit of the MAC address by one.
> - Hereby, the eth2addr is derived from the value assigned to eth1addr,
> by inverting the last 2 bits. Hence, differs from the first ethaddr by
> an inverted second last bit, which raises or decreases the last hex
> digit of the MAC address by two. This assures a valid MAC address
> assigned to eth2addr, which always differs from ethaddr and eth1addr.
> 
> The change has been successfully tested on the NanoPi R5S and NanoPi
> R6S: With ethernet[0-2] device tree aliases (correctly) defined, both
> boards get 3 static MAC addresses.
> 

What's the number when we'll decide this is too many? I have a board 
with 5 Ethernet ports for example :)

You could set the eth2addr in your board file if you wanted instead of 
setting it for everybody.

I don't know how far we want to go to avoid defining unused ethXaddr 
variables in the environment? We could use of_alias_get_highest_id for 
example and generate enough environment variables based on that info?

The change looks ok though, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
