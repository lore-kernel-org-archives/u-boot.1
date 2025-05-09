Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76569C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 09:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB913806D8;
	Fri,  9 May 2025 11:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RKcqaGfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB318210D; Fri,  9 May 2025 11:16:10 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0E08059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 11:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpJySNGRHHDDps4v2VCWgta5oAzZDkdmmEa+nTXvt+1d/vvt3LES3DMQytDajLtikxydtamOeMKIa3I6eBuo05890Kdp2Y/wl81XGl0dXdIRR/p7Z6KLCeOnz/fAISHZpZKOOBMDIhDnZQYh5+n39sfByQcYrtDkpNZvE8mw64wFHI24KHPtxga8YKmbbIZ5CHKkDk4+N64r2tyWMQzXyyWDrRpgoDdYLVzIGqRSzGrgB4Sdb/dIX5ONHVixOkxVIVTmMhT9R+BVshQ+WSrvDW6NSiZJVmZp+myeGbVDA61qpNtOMG1BUFbsYjfbYnAUDHfPIsHZCi0+i2pQpejJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LowPenvdQoSbbd6VBHFUQJoAIJ+GahbUjux3D1RVQyY=;
 b=npgGJit1GSzsqA03/gSDiIMDv95kokJVs6PAKJNp1YAA0P1SMCvc4ufp3rfkWk275XJIJg26TGeVWHM4xSuI3f+0HUXdQxB7djyFj80d614Eb1VYfghTsm9uSAGUjDJ8GV9ETfYZyZjGKVePjHSrF058kiNNcw+fKITh9hh5sQR4I/mAl6G9UXgbHx8GCQbAJOai2N8SU17rXr+ggYmBfzAC1KqbdyYl5Qgba6DRmjy/2xjZ3xTWDqCwrz02m2uSCwNw2dJDPx60922Y/klT11pKyY1rSwcxaU/nBrdMYnv7t5VA8FEhFKuE6NzPTH3I2xz0LVeN4x46wr/IuDOcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LowPenvdQoSbbd6VBHFUQJoAIJ+GahbUjux3D1RVQyY=;
 b=RKcqaGfWUoeUEd2DKg3MT0vK2lZbEivv3htzptZ5UMih/uFehZm7D3z1P2ePOjpD5PA1oduj/nllx2KvQrZgcKnDcgjNn2LC/DJe4U78VaCK1VeT723Pr1A/3sZaEqx0AcEXs7CVuGmuL53hUzQemCXNi61VEhQlCKQllzcIeNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7492.eurprd04.prod.outlook.com (2603:10a6:20b:282::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 09:16:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 09:16:06 +0000
Message-ID: <188d7dd0-8627-41d9-949d-c4dff1072bc9@cherry.de>
Date: Fri, 9 May 2025 11:16:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: correct link to QEMU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250509063904.28923-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250509063904.28923-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 2763a7fd-edc6-4146-e427-08dd8eda2063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWk3QnEweGhGZnd2WVc0NWVrb2ZRaUlma2piMHZuZGVPUTBKRnM4d2I3Z1Vo?=
 =?utf-8?B?a1IrcENCNFdRU2E5T0xtZWZINW9scGpqYmx3Mmxtd3o2KzNaVDhaWUtKTHZo?=
 =?utf-8?B?bDVpOUJydG4yMmJrS1B4N3Fnb0xGdmJoK1U0VUxTWVdlbURUOCtxNEhqWTlp?=
 =?utf-8?B?ZUFNOXdhR0gvOU1KVmM0U0dicDExL2F4bndNeVlKblcrcEVmTGlpa0dmZTc4?=
 =?utf-8?B?RlRtd1lONTRzVFQzOXhaUHdIdFk4MHliT3VGWkZwSnBYbW5hQUFWbkd3TzBh?=
 =?utf-8?B?NnBTZUJiVGRqeWdDMGtMckJ6OTg3TS9wNjVQeU1wK3FPSkVNRDREeGlVWHRa?=
 =?utf-8?B?KytvQlg5TFFiMFpkUFJnQzNyays1dXZXODNPd3JtRi9uTHhjOFhrZ1VVQU5n?=
 =?utf-8?B?RkNic2NVMGVrdzE1K2NsWHdNdURCOUFGT1hJd3JzWWpLYURuMi9qRXR1eFox?=
 =?utf-8?B?QU1jU2psOW8vSE9uU0xaQTNFTXlQa2NSdUkzV2hobldZTzQ4TllhZktHQnN0?=
 =?utf-8?B?eWtadS9KeFNFT2t5WkdVRnlrVVE3M0RqaWNvcjhIbFM0c1o3VWRuYmE3YnV1?=
 =?utf-8?B?MzJjM3dMRUFjaUlNb1lWeUpMendvbkVneVE0RXhUL2RyanBWeGwvc2g4ZDNO?=
 =?utf-8?B?bHlvVU9CbUJ4OE5FUHczNmVoQ0JsMm1obDdJM01ZMHN4dmdPb1I5dnU1YTV5?=
 =?utf-8?B?VjNrYnV0bXhGYmw1ZCtCSGN2cnJtV1RoQ3gyYjVFN25IY3cvOTUwSW96UzdC?=
 =?utf-8?B?ZzRSME9mRHRHc2xQdThjblFlUjFtK2lXMU01Sk9ScUZjK2tOb0pDelNaeXhx?=
 =?utf-8?B?a1lPVzVnWTFLSkw2eU9RaXpxRndOeU9rZlBwZDZmY3c1bEZZL3hnNzU2aHUw?=
 =?utf-8?B?cXJiVnBjaWVEdU9vU3ZHY3lQUFZTMmpqelhlYkVBWTY5Z2dDKzg4dHowbU91?=
 =?utf-8?B?VXBtU2Nkd3RXT2dSWFp6ZnRVOCtJUVNvODZMdVFUVGhDamlRNjF0MVBHOWRH?=
 =?utf-8?B?d3pSc25vbVNuK25NSFNWa0h2eUlWbzJIeTRMQXlYcXJqZXlTMHlheXBnUkl6?=
 =?utf-8?B?cHk5T2ViVis1cW16anVMY1BSUnJIaDhGd05KaGkxajM2dVMxa0pBdTdaOXJC?=
 =?utf-8?B?TkVhTkt2ZCtTTG51YlZ3MmNnNGlYZWhQSmU3eE1iZENEenViYTZ3YXRHeE1y?=
 =?utf-8?B?MWdiSkFEZDVoL0Z4QzVRR0I2cTgyL00wWndxeFFvaWtoZmZoeHczN1drTi9X?=
 =?utf-8?B?dVpsWndxZVd0ai9kQi9DU3N6MWRMMlBoTnhsR0lPRm9LTktwYUYxcktxd1Nv?=
 =?utf-8?B?bWJVK0VPWlYrRjVHNWlRdnBYTjdCdkV4S3BvQm5FZVBPc2hoUW5FSnVpbHBN?=
 =?utf-8?B?TmdsdG41clV5cUl4UEVlK2RvTTRMU1RlUUpLbFpubkRiZ3JuY09BcTVlNWhD?=
 =?utf-8?B?M0NjVyt5Tlp3OVJiNlZwcG9jYUx3MUxOamtTSkZ3L1FuSmNBRTVPTnRaa3FY?=
 =?utf-8?B?NHJxVXpkRjNJWnFPZlJQMU1mQm9JbVE1cytRUTdETXMwYkFwRDhUd214VEI2?=
 =?utf-8?B?R2tJUnNXdDZvb1NxT0FVdEFVWGJDdnJpNmJGZTNMUWRpblV1K3l1S0VnT2N5?=
 =?utf-8?B?VUdjMTFYaWdPdmVhZkRjRmEzSTRqU2FXNkJWWlBRLzdzY29CaEJoWjNXbDE5?=
 =?utf-8?B?TkN5amUzckJ1Zmo4QUR1L3QvcGgrWDJjSmtFUUVscUJuUVVKaitVTGZ6bmh3?=
 =?utf-8?B?RnBSRWk3T2pIa3pBbnJzZDQvcktwVDJ2MmR0akNHdk1NbHMyYXU0NHVua3VK?=
 =?utf-8?B?MUgzdUdJSXoybnRxTUl1OHpZcWNjaHVvM0R2RVJ6TlZOakR2RENSMWJSWFpo?=
 =?utf-8?B?azdVR0tFVml0dnY0eS9rUWU3S0IzL0JLa0xCS25GRzRSUHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enIyR053RkhpMnJNcUp6VEtKc2tRYURjclJtTUgyWDdzSDFxdUFlQ1pCMHli?=
 =?utf-8?B?YVRUbGJWVFdMNlFPZFI2RFdFOXYvV3RKRng0QzB0SlM2UkdXV2xYcEduKzFw?=
 =?utf-8?B?b2F5Z1I2YnJOaWE5a1JZeDVGTnFHT1lSanlINzI0NnNLNEsxTU4vdEZ5TUNF?=
 =?utf-8?B?b3JvaVhEQXl5dXF3SFM1YUxwZFpvcDdJRmZ3OFc3NTlzM2dhYks3OFIwZFFq?=
 =?utf-8?B?TThBK1VBSXZOc2tQeFB0cUphcGJsbUlZYVlqRVVCZXJ2MFFxNG1rYlp4U1pD?=
 =?utf-8?B?d2pCVldhRnl2cjdkS1BaRE1JaCtEMjJFbi84YTd3UGs2VE95UFhoUDM4OE9l?=
 =?utf-8?B?bkZ1TjBZKzdRK3ZadmExZU1sa29qMGM2UGoybFVrM21hS09MZWVaUXpiTUd2?=
 =?utf-8?B?Qzl2eWdZdnFubHV5b0RaSGJEN1kyV0ZCRzlMY2FabHZTcmtQZDJhNDQxMVlD?=
 =?utf-8?B?QzZyY1F5TWFPSnY4ZHhKWlo4VzlHeGVvN1Y4Z3p6ekQrREtzTEpCRzhoTTdM?=
 =?utf-8?B?ZktRR0JrSVZjdkxNWHNuT0hsaGNaQm92TE9RVWd3Yithbk5aeTdIYjhVbGpU?=
 =?utf-8?B?M3RWTk1ZRVVLdDFPMHdDOGpES1dEMEtqdExZVnQ3R0lvTjB5MUpSMHpyeWlI?=
 =?utf-8?B?RFFiMFpRd3ZmUUROaC9ZS1FQVkoxTWJEN2dlc1k5YS96czR5aHRpMjZJallS?=
 =?utf-8?B?a0dpdUFpVWFIL085N2dHRkJkS3hsM1lWYU1YZms3WnpuQUNRTWVxRUs1QVo3?=
 =?utf-8?B?ekd5Z1Y0R3lRejJmL2swVzVCNEM2ZjNIWVlRWHBVd1owM0lFOVcwOVgyWWFl?=
 =?utf-8?B?YjdDTGtXQTU0NkR4RmMvanFmTklBa09UeE5UendId3B4MDlTZFR5Qi9ucTRB?=
 =?utf-8?B?K0FGTkIxZDhHYzlON3hBdzlic05NT0dWSkZXY1hxM1F1aHVEaG94ZlZNQ3ox?=
 =?utf-8?B?RGFRWC91TDZCYmx6ZHoyNGlEY0t6clNNTzkyN2ZnVGVHSjU5UzJzWktHUnZ3?=
 =?utf-8?B?L3N2QlY1cjczcFl3N3hwTUtTTG9yNFVJblVyN3MrcG9MV3V4ZGhBSVRPVVdW?=
 =?utf-8?B?NTZTNHBpR1BKci9OYWo2SkFteGFrNzBOZ2tkenYxUjk5VDgwVkhOZWVKNUFP?=
 =?utf-8?B?amFzVlRFZURJejBhTEg5VWhpTW5mL1lLU2J5dVFXYkhGTFJpdjYzVDBvL3Ns?=
 =?utf-8?B?M2NvRXNXTmtucUozQWpLTGdqamlkV01meEY0MXU5cEpkMFd3cEI0SzJCYzB6?=
 =?utf-8?B?UW5hVDlwSGZaQjBtcFZQdXYrWGQxeDN2WUN4QjFYWHBzNkdVb1NwUnhKTXd2?=
 =?utf-8?B?OTU2UVZ6NWVqOFpJQnBNdzBsK3dlRDZNZHpHZlBlbXZVa2RhVjdmbFBnSENB?=
 =?utf-8?B?YXFaOGpKNnIwVjJrd2NLeGNSOFhEY3FLUi9EMUY2YUNueWNuMnVwbTd3WHBT?=
 =?utf-8?B?d2lMNDRTeDkyZ25rUkVDUWF3b1VCak1IUHE5L0xEM29kZGpTZmdjQkI5OTFE?=
 =?utf-8?B?ZGRmbGZsc2J5ajR2TDRpS1hzTVg2WkJMall6alpoWlBpSU0rQmJvcUlpd3JC?=
 =?utf-8?B?dXhWU05RcjMwcDJLMWVDN1RCMk45VFQ4SFZsUHJLNWoyeVhOMVVJZW95ZXdG?=
 =?utf-8?B?R2dEaG1qczNXQ1FBOThtRDkzZGV6Y1lxWGtNK1B6eTdJVVRqOGIwK3JQSDA1?=
 =?utf-8?B?TEMrT1pVNzJXcWc3ZnJDTVRNTW1BNmJjMXBHbUtlNk5pNTFQbHA0c3c2RlJr?=
 =?utf-8?B?MUZvbXY4elNxa0hEMXhuNGxYME9PN1NJS21QbisrQ3dHdFhNa2Z4di84SE1u?=
 =?utf-8?B?R2NTVnlFU21uK0NUazY2OU54S3JqS2ZlV1Rib1AzYU1odWhEb2h0c3ZmdUtE?=
 =?utf-8?B?dkJsNVVEeWw0SGFlKzdUS1A5b3FLanA3bk1wcEVEa0hjNE1iYTluUzNEeEFU?=
 =?utf-8?B?ZW11SzdXcC9CWTRJc0I3Vldhd0RuOGtUemgzTlM2Z1dINGtFM3AraWsyWmoy?=
 =?utf-8?B?RWVoNHZvQjNhN1o4VElPdkVEMW05L1Bya21UTXpPdmdoZG5MZDNEb0RDQXJV?=
 =?utf-8?B?d2pTc1JLaTlWMTJqN21qTDVDc3Q4eFhBSEI4NWVjQ3BKYjY4UUVNZXRlT3cy?=
 =?utf-8?B?ZTh3TTRJbExPelJTT3haSFVDL3JOc1RhZE8wN3VNc0gvUGovOXdHcVlLandU?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763a7fd-edc6-4146-e427-08dd8eda2063
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:16:06.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klnq4/8QBAJ+EIPj7Tb6krd8Y7pwX0pGz+yiAxKUp8HFyqRpkpmhG3S9fWncxNiIo6xNDqVFFal9XZENwSUjZNI6aTCtW+X6ZPHWL8lEGWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7492
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

Hi Heinrich,

On 5/9/25 8:39 AM, Heinrich Schuchardt wrote:
> %s/hhttps:/https:/
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
