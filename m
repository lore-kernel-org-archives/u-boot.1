Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C542D6ACC1
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7728977F;
	Wed, 27 Nov 2024 12:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Bs/6I3ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 032788978E; Wed, 27 Nov 2024 12:35:21 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8ADB896C7
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr2QPf8XAhWJ5W8gv/DH/+F9etLBGEaylGmE8VwgHSZbuT0t5rqB2NyuIGrhnQltjzBn+G12ajFS/KvDRIrdUf6R4ImBdUEup6ZzNUX02tamSbHdDgS2pIJi4UZGZLJsIYnUD4jKENh2NXaLIkkilIDhf2MujthuutpHMzZN0NqFNylgeL4af8lDLCEMRoKt73STdXM7n+E18Eq42Fi29tkUoOsG+RWpIA001Pgg/fpPnvBvXIA7XLRGfH8AfMNCEXDrarBa4bU5HsayReD3uHrBGtww/GEQa9MBN1B8Zv4+Az/c9zbWmajP720Wuh75t8z4H3of2F0y/uYUj37+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEv8vlbBAVsz7YZFoIWjJqDJbgOXC//pV3/hACLsgs0=;
 b=qfCin3R60CzRNYC+UH7/rSwnXEVpplbdLC92F28CAZBg5TRzMYF6o1hohY4sZ0jURVEAkLEEyskL70kJo/dQM17oFN80Pbi+r+a6w5kedX6ZJKxisrNLvkoRtDTPT9aoYzwgxKly7Oivc8DIsvgPXF3Bekiv9okhdwsSkgrtIw90yiB8QxsfWCnnRkA9RZ+44D+pGTyakxKeEojPmMe8t1i1v2FodR0ZUj4GXYQ3vGZ0XLir3sPpdAhmQFfxuloIIV3IQ8Ox0GnrRb8ydhv8dCg0xhgvbj64guaMpKUJDNSBfK0y+6VZ8SdusKeMZBS2VgR7YRKQDi99SbQJ/dpaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEv8vlbBAVsz7YZFoIWjJqDJbgOXC//pV3/hACLsgs0=;
 b=Bs/6I3ih1OQZdSFv/9P1MCK8NpdELDwUcbPlKNdYkVuACRTARImRn8HrnLNY6eqmi6p5v08x+u8sWU/xNAipxCeya1kISWicOo0h2BR4l02gVpctCDDVWKtj6N8xdkh5RhCLGV2vrpCHCxEaBBwJFsfl95KoX/LMRktAkQoC+YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:35:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 11:35:16 +0000
Message-ID: <4eb2c0db-5486-4760-98c4-4cdcab9b5253@cherry.de>
Date: Wed, 27 Nov 2024 12:35:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/39] boot: Split pxe label_boot() into two parts
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-10-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119131844.4078144-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 621b4d18-1107-4195-8ad3-08dd0ed79078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmNTUE4vWUtjdCtoelhQVVU2Y0tkWmx4ZU0vNFlPblkyaTErVlFBUjl5OG9B?=
 =?utf-8?B?MC9kUVZ3cmpYYjQxUVpsVS8xenYzRGMzOU1uSW1yS21TRFhtVWFST1N0ejZq?=
 =?utf-8?B?eEJyNUtUSWRMR1VEaDhSdUUyQWc1TDRETStqV0c2dkVPR2RQdWhyV0xzZUtK?=
 =?utf-8?B?U1dETXlRemVnQXExdXRpVDQzdjhyNkc0b2tLbGJ6TWxLSGpKSUhoakNNSnIx?=
 =?utf-8?B?QjBxWERDTnUrZW5LcWFJbWg4Z0NZUGNaM0xpOERNQ1E2VkRGUGZYY0NxOGp2?=
 =?utf-8?B?ejU5OWtMbGVuY3NORloyS29ZUkdLa2d2WHlBZDl6b0syQWZRbUdaazBhbFE1?=
 =?utf-8?B?bGhteWxNTGRDRld3OFh6R1Q1RnR2NG0ybnV0UGdLWitMaDM1UnBYekZSNXVH?=
 =?utf-8?B?NGliVW9yZ09ndm5TZ1dpY0hjMWVJU0pMWEg2ZkdmWW9hL2lvcnBHTFMvWmhH?=
 =?utf-8?B?T2xlV21oaGo2bGp4SldDOW9kd2xkNVVVSmp3VjVVRDZqbG9PN2IyRmNmakxh?=
 =?utf-8?B?TTZqY1RPM0UrMGNkSHNVSlJMcjBTRXpCclAzVlVlOHBYem5wb3U1SWhzK3Ja?=
 =?utf-8?B?ZFIyQnNjRS9oSUlPY1dVaGJYb2tXeE9JK09ieWtmcGxKZ1pHUExpaDI0Rjkv?=
 =?utf-8?B?d2VIRHFwcHBCcVdra3pKVnpaSlM1ZXhDZU5DZkdIUnp3U0twRjNXQ285WFZN?=
 =?utf-8?B?aHNzbXdMQ2ZYOGJsUnAyTERWOG0xak9QeWNkMFhpNURPaTVuUW05L3Q3UXpo?=
 =?utf-8?B?YkNYSVJ5NHBDeDQrYTZRUnE4QVU4bk5vMEYzc0ErZXBQc1FZdTgyMWg0YnJi?=
 =?utf-8?B?Mkg0eTJuL3dhUDdFVytqak5HaitzNFJVclBkRWowUEtqQ0crbzdleE5GV0VE?=
 =?utf-8?B?eUNXVkNQblV3K1lpU01YK05ldzVuMmNWdXAwL1pGbFZ6YlB1ejBiZ2MrY25q?=
 =?utf-8?B?NTREajFWdDR6cyswWHR4OUhFZE0waFhzK0xScHdlNTRoZGJWZWxmQkxKRm9E?=
 =?utf-8?B?SnJTaVhFT1UxSWRxNmxvYytoeER4VWU4eEVjMkVrYjBpeXdtQlFBZ21pTVQz?=
 =?utf-8?B?QWVLVUZnZGJxSDZKbTZjbTRIY2ovdGs0VGpXUVJqSDlidWZHaDZUK3ZLS2Vs?=
 =?utf-8?B?bUYxSkdpcWxsRDJmcWJ0S3EveEFJQUtYai9ZdlNuUmRvSnM4UDI1bWRmcHBE?=
 =?utf-8?B?bnpKL1hPaEVoeSt4VWdCeDhmZG1aUy9EdW9jWlhHVWI5VmhyTjRMWUtDMDBS?=
 =?utf-8?B?S0hlcXpsR3AwTTBQZXVDbFN5YUxmSHRFMlhRem5KSHBJMURkaTU0QlVWdkZ6?=
 =?utf-8?B?Z3FFclNDeEc2d0dvdDd5dVRkN2dVM0luNTF1UWVlTEh3RnJVSy9POWFyL1la?=
 =?utf-8?B?U3hLUkpkRUJSSi9neVVKZmZJK3BRQTJMa2IvOHdhMk9XWmlQQjVBa2dJak16?=
 =?utf-8?B?cjdzU2xKMlpVcE4rSXRoZ09ZNkVObm91TlY3VGdhejN3R0MySEtGR3EzNHdL?=
 =?utf-8?B?WFdVTTU5alpsOU40blhqcldtZ3Y5bG5xRGU3RkVlcGlBYjhNZGlURHFzSnJT?=
 =?utf-8?B?MnVwUFVjcDRsUFo1UTFkME14dTRnTVFRcXZwL2hGc1R6aHI0TmVyekhiSGRB?=
 =?utf-8?B?cFdTYTEzRVJkTVE5TmhyQkN4cTBqd2JBL3pqSnFyd0U1NVVPaFBWdHYwWEdU?=
 =?utf-8?B?SjMySWhwamxwUnZWNmFJeGpyY3d3UWdjR3ZKQzJuVjBSdDRLT1pBSzNxVUZx?=
 =?utf-8?B?WksrcEpqMnN1Rm85eVYxUys4YWV1dzN6NU45Q0FjeDlyc1cxVldaRklQRnBq?=
 =?utf-8?B?OWYybG05bWRGTnlUYk9MZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdFWm8zWmJmU0FHUG04Z1BBSnZBQlYwUlBKYXNYemhlNjhCYmdPaFVlSUlE?=
 =?utf-8?B?VitSWmpYeWQ3eHdHTGhzMzk2V3RFU0V3MlBYdnQ1ZkwvMnhWNzhObHE0Tlph?=
 =?utf-8?B?RUkyUEN2NUZVZkV1ZVZFTSttbFlEVWY1U1h6TVZFcVAwWmZrTDdEV2RxR2F2?=
 =?utf-8?B?Z2VBbnNuSTdkUGZJclNWRmJTK2hBdCtOQitYVzhlWWF2THo5eEtwTkZHY2E2?=
 =?utf-8?B?bGg4NDAvVVg4T2RDeWFyVFNoRG9ITmdlTW53RWo2Yk9vanFOWGJ3dmxONmpo?=
 =?utf-8?B?NFBRNy9abWExWmUwRjJ3WlQ5cHducG5XN3JFK1ZKMHIvMDlHSm9FVWprMVRF?=
 =?utf-8?B?WGJiSG5VR2RWV1ZFYzJGR3NGQ2pmazBSK29YcFFaM2l1TFZQd2F1NnNmMitE?=
 =?utf-8?B?YUFtSGJvZXdZS3JzQy9UZ3lzM1JjN1o3ZE1sd1lKMDZlam1YbjNaMkZUbzU0?=
 =?utf-8?B?aGJWOEduTlI5SnVwQVlBek12VlI5ekppWjBtcjl3enFLcHpTMFJmWUlJMGlW?=
 =?utf-8?B?NVYwbTdPazRJTUNxMGYrZHR0WER2OWhnVlcxLzV6SnFIUWlQZUg0amg4V3RG?=
 =?utf-8?B?TXRERHhCdjM0b0IydHBDZTM0czBBWHI5MkFxVlRZdmxlQkZqaUtybmdOTzVB?=
 =?utf-8?B?ejdoTG1tM2lsRlZ1eWk3UmM4WEF6SW1nYXRZRzU3RTY5OHBhMy9VNDlzUVgr?=
 =?utf-8?B?TlFQK2puampoNDBVeGhYZjFadkNLaDJjWDlhUXA2R2RTalV1RE5JTE9GQ29l?=
 =?utf-8?B?YXVDOXlHZ0pXWnFoSitWVC9IaXJhbnpRVnh5bVNDeE1EUzFxNkRvWTFuUnVa?=
 =?utf-8?B?N2ZobCtJaWRVWFhkeVhhMEVmb1JXNE1BWmNTcUViUWswcW5YVWsxODRkU2d5?=
 =?utf-8?B?SWdoMXo2a01ONmdPS2ZLTUYxR2MzbERUaHNTZWtjVTViVDYwN1RvWVNTMlJG?=
 =?utf-8?B?OENTaFBmYVc0ZkpoUlBHSXZkZVhVTEFWZS92NTJlREhyVE1nOXZQZU9KaFBC?=
 =?utf-8?B?QXh1NituWEVtNDBmeHhpMTIzVzQ4cklJcGF3d0tuTHNuNFRPS1I4Mytrcncv?=
 =?utf-8?B?WGxUTDVwQXY3aSsvZzlrVnYzdHcrZnYvbnllZmdVYVF0M05GRFBqbmdtV0c3?=
 =?utf-8?B?ZE9XRTF6N3gzUGpNU01tMTQ5bC9VbHNDRU92MWU5Nk9vTUZpZFlKN0RTU0lW?=
 =?utf-8?B?eWZOOUVkSWxKTGF2Qjc4SGF1d1p2U1dwMTBOV29PbUVSVXJSRlhOR01HZzBF?=
 =?utf-8?B?SDJvZFBpSlk0NDAxMUljU29xaElQREx6U3ZZaC9FM2p5ZCtUTjZhTlV1VjQ2?=
 =?utf-8?B?QWFxUmlGeVBwSWliSUNORVJFdnp4bUhKK1ZWbWhDZ1VZOXp6bisxNHUwTDMz?=
 =?utf-8?B?eHVTdkp6bUI3NUwwTnQ5Y0pQVmhIOHp1eDVMd0s4dFg5SS9Zb0RSTkdBdS9m?=
 =?utf-8?B?ejRDSG5qZWszY2RlRUsyLzBiaDdURzlDMlc5NzdTQVRrU0h1OUdFKzQ0eTNT?=
 =?utf-8?B?RmNmYXVWOTR4dmIrR2ozVUtjYjd0dmVoa05DbUMzcmplbVJvcFEwc1BnUzFk?=
 =?utf-8?B?UGVmdzM0VjBTdEMveHpRZ0k4aGhxaEtJaCs4bmZ2VnRoVWJPSjJSenRSNGow?=
 =?utf-8?B?Sm9QY3lRTm9pRmRVS3NQSG9BQ09MbGt5R2hVQThwVXprVEtPTGxicWdsdytu?=
 =?utf-8?B?ck9jVGRhWkxrTVh5NmR2dVhBdnZOcDlVTVcvYm9sSENhckNodTVHTStrYnp6?=
 =?utf-8?B?K0F3dkdEYi9qK0dXK08yUmRRdk9zMXNicVRJUnlCM0ViTEN1Y3ZMV0ZobDRQ?=
 =?utf-8?B?MlhhbmFVTUR1T3Y0MFVyekhLTU5FamZkSUxVaXgzYU43TFlIYWE1NjJ1UEdY?=
 =?utf-8?B?L2t3SHVpd2EzYnZSM0MvQXprdFpZa1djdG90OGNxUnhxREJMN0VQdFBZSHUz?=
 =?utf-8?B?RkZFbDZrN2RPWFUyTVlPWXlJSmFuUVlpcENYMnN4am90eTQ3RFFuamZZU2Zt?=
 =?utf-8?B?UTk0bUx4NVdoRUlXZ0lXVUE2YklXRkpTNGs3V0Nqc1BSaUg4ZTl1TEthVFp0?=
 =?utf-8?B?aDRHTi9oTCsxODBNT0JTa0J0T3dId2kwS0gwVXJ3aHVHdzd6ZTlFM1FwOGJu?=
 =?utf-8?B?bU5RaGVjc1o0TmtmMkV4Zk81RGIzSDdqbGU2V3lRS2NzdnJHQ2JuSUZiZWE1?=
 =?utf-8?Q?rSAX0wl30B4usYtiGgJkv38=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 621b4d18-1107-4195-8ad3-08dd0ed79078
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:35:16.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVhl1c3WXzDfPQ0j8ScvbWT8qIgj9cOFvDlBcJtf1dTJNCXy6ES5FAb3V8ACuWGtYCqZn3dKxNbbzQEpatxyHxh1R2j0sJ6Zd13EYZoafCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

Hi Simon,

On 11/19/24 2:18 PM, Simon Glass wrote:
> This function is far too long. Split out the part which builds and runs
> the bootm/i/z commands into its own function.
> 
> Add a function comment for the new label_run_boot() function.
> 
> Also change a strncpy() to strlcpy() to keep checkpatch happy.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   boot/pxe_utils.c | 284 ++++++++++++++++++++++++++---------------------
>   1 file changed, 156 insertions(+), 128 deletions(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 82f217aaf86..edccb29e770 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -433,142 +433,29 @@ skip_overlay:
>   #endif
>   
>   /**
> - * label_boot() - Boot according to the contents of a pxe_label
> - *
> - * If we can't boot for any reason, we return.  A successful boot never
> - * returns.
> - *
> - * The kernel will be stored in the location given by the 'kernel_addr_r'
> - * environment variable.
> - *
> - * If the label specifies an initrd file, it will be stored in the location
> - * given by the 'ramdisk_addr_r' environment variable.
> - *
> - * If the label specifies an 'append' line, its contents will overwrite that
> - * of the 'bootargs' environment variable.
> + * label_run_boot() - Set up the FDT and call the appropriate bootm/z/i command
>    *
>    * @ctx: PXE context
>    * @label: Label to process
> - * Returns does not return on success, otherwise returns 0 if a localboot
> - *	label was processed, or 1 on error
> + * @kernel_addr: String containing kernel address (cannot be NULL)
> + * @initrd_addr_str: String containing initaddr address (NULL if none)

s/initaddr/initrd/

And would have preferred the strncpy/strlcpy swap to not be hidden in 
the big diff :)

Otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
