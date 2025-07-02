Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2E7C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F74582103;
	Wed,  2 Jul 2025 08:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bOQBV/XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96A482B18; Wed,  2 Jul 2025 08:23:02 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD2581FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnkP/slUAUlKFXfx8S7FuQrNNToIwdo6+jVbWcxHHy5jm7f/HyJt1MnqME277gvQx8AWLLKD67uYqY/V53zEA1rt1mh9MCwWOXJNu3utLQsJ2B4y1kErzfKZVlvaRpb8LGc/X9QP7zY4+BRUG2Ofrm4sGZeCK89e3dM0BfakOaQvS8xDhsSIX+tZjW0fPejWSJW4ypt7hGTFKVnkrqoJo8wQ6Sj+9IGu8KGSKENCbN07aB5IAoy+u5qFXx+3oDW4wWX1vnMbqgLi3EBuTw8Zpyn+6Y2shDDTcPE31APVw0QQ3XVmJGt8QNqt2RQR4oc35twJxPMWKUQPJXgI0cCSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAUsYYSiTGtIe3UbO3zDBXP2wa1lFXgKQdYD0SOmW9s=;
 b=UH8HDnBjwDvCSB8aXOXwdM4UktGj/w3QQHSes6Oam9HQ3UnFJLdoncR762J2NK57JQ5h9NpwKZFilVsTANko02x3QrBpd2wdKxSiQaB6qU8xuhxJyWDDtscxUDa5M1UAvE+ON01INGaC/pfYZq/EryTjeXd3YGyMoK8JWgGLB3sCQC26bLVyK054AY3Ohzlo+i3XBh9Nka7D7qZG2uAaQo1vA+IBKRvbetg791jlmC5dz83nDo5sz2hEhfPmE7e0SOoszUmq7VX2LQpHNzjpyLfgJNUQ0IwFkp4T5uMu62zzFEIc05TfRhqTM+kz4mhWI4kXQxmj157noVWUy+laUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAUsYYSiTGtIe3UbO3zDBXP2wa1lFXgKQdYD0SOmW9s=;
 b=bOQBV/XJApQiJwECScboc45SeNIr62difgOJyVeoCN7nmis7WOJeEa0F3DKVdtCwJX1lJ8C8ryO/ncopE3jx/F3c8fyMFG6NOrpocXmQ57XysTDr/uGWMHyV7F6tFzBE0Qkw7qJGqcomemClyBepilVqTe5XGUnmOJvsvB60gFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 06:22:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 06:22:57 +0000
Message-ID: <f44bf6a8-e736-4e9d-a18a-519aa04a767f@amd.com>
Date: Wed, 2 Jul 2025 08:22:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: Tighten dependencies for ZYNQMP_FIRMWARE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250702010410.18828-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250702010410.18828-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa623be-96aa-452d-4ea2-08ddb930e309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STU4aXBpVzUrVzRsUzA5cjI5TWIwNUFlZWU0L3AvMDZDRDI3T3Vkdyt1ZVBR?=
 =?utf-8?B?Zlg1R21BUzl5cTNSNDJhWllRRlZqaWlBRTlxTE4zOWRPVFRBZDVkNlpCcTJS?=
 =?utf-8?B?Smo0Nk0xMkF4bjJEMVcyNGxweXF1SnoxVEJSa0ZXb3BDRWY0MVVIamlLN2g4?=
 =?utf-8?B?blpPTmtyWm0yN2krZGUrcjBwU09OZGlTeGFwd0dSaGJpS1pwcUQwZHd2eDRm?=
 =?utf-8?B?SFYzaFlYanJPK045VEI2STl3bUtSTTdoZ1N2emNWVHI3R01ISzBqMCtFRkhC?=
 =?utf-8?B?QXJCY0lGQktqZkhTRXpXWUpsN1BGS3dHL1R3L0QvakF1K3c0K3lSTUY4M1Rm?=
 =?utf-8?B?S0dzd1ZwdHUybzRvNEV1Mm94d1JJT1dscTVrRFh5NWlLS3FXeWI3Y21ZYVU4?=
 =?utf-8?B?YytvS3VDNVVkekxlbFdxRDRaNGdaWFJqM2N3UlNUN20vOUwxZFJQRlpLQUdo?=
 =?utf-8?B?cHJ5bzJPZ1N2RTlGVFhtYmduTzMxL1dRZTF4UGwzanc2OXZOQjlacVdiNkxz?=
 =?utf-8?B?cXVSMERST0plcm52QlB5eTJKUDUweWNWcnNUMndNZkVrZ2dENk81eW9UUzJ6?=
 =?utf-8?B?blRXaWl1Wm1iSWxvc3VkWGFZSTVWeXpuZmE4VGZPUXpkQVVsbjZ5QVNCWExS?=
 =?utf-8?B?dzd1VUoxRHZiaG9SK1Z3ZGlER21pYlp3M3RWb3k4TVA2eldFMUIzOGRCdmpo?=
 =?utf-8?B?VVRHTVUrK1dCT29Mc3VNc0xhd0M3RWhkWDdZbUFZU1hIckdIYWhtOFNzVmlH?=
 =?utf-8?B?WkhhRTE0c2lUcWRvekhEQkZBYmV4dTlQVTl5by9EWWJTb010V3MrS2lFd1c5?=
 =?utf-8?B?SFZiL250RDVKYkEvaDdkUXA2WmpuUEYvY1pkMW9sL0V4ZWtPWTdvdmZEUGlo?=
 =?utf-8?B?bWxlU3RNVnpXVHJVOHk3Qm1xTkZNRjNyZXFtV0Q0cUVFTzRsVmRvRTBNV0t0?=
 =?utf-8?B?YU1tK2x3ZXhGdTYwZmVjUHh3cFFLVVBRdVlpRkZXTUlORStDY3h2NVY1UnJ6?=
 =?utf-8?B?d1VIVVdxaEcrUnZLenlTSDIvcysyQ1pzYUM4WGhGWWdDbXRQT21mNEwyMVlE?=
 =?utf-8?B?UXp3TTRiL0FJS0ZMYXMzM1BBTVlNRXNINWZGaEpvMlVsYW15THBGTmViNTJK?=
 =?utf-8?B?TW91bGV4T1p5L3B0UTFBdXJreGs1YUV0eDAzaGV5OHFjYTYxU3dkbExSRkJn?=
 =?utf-8?B?dmQ0MThDdFNpMjlBTjEySHN4QUJqNDJYenU1ZDJJcm5xWDM0NFp6YVRjMVBp?=
 =?utf-8?B?OEVyS0NlaFQ1QWhtMVRiOHQrK2tTdjRNblRPNEdRUk50a3Y3ZVUyOGV1cW9Z?=
 =?utf-8?B?azIvcGpNUkpGU2tEWDN4TW9qYjBHOXhEZ1cySlhPR2lqQTNZRnRhMnNoTWov?=
 =?utf-8?B?NTBGZVlRRCtqQ0VtNmRkQ3RFSmJ0V2JGTFUwWUZmZ2I3ZzZlN0NteUk3bkNH?=
 =?utf-8?B?LzBZMXVjMnUrVDNnaUZDNW9qdHVwbGttUTJBK0hHSDZxQUVlK3FSTGxlbUIy?=
 =?utf-8?B?dTRqclNqZzVGTnZoVnhYRldaV3ArRExXTzJERzJwNzk3VEhRaEc4SFc2NFh6?=
 =?utf-8?B?UEtaeFNGWHE0K2o5bzF1QzJ2N1hKb0g2QWgzRkdIdGdwbmc1VUN4bVdlUXBL?=
 =?utf-8?B?WWpBRVB6b3FHMnNtc05oVkduUTB3b3krRFkvTjhPcVdnN2wyVkdPQ1RPdGUz?=
 =?utf-8?B?b2J2VVpXSTZwQWZzdEpPL3VIYU10bDJlb3A1NkJUTnZCbjRzUjQwTUxIRmJI?=
 =?utf-8?B?T1ZEVEc2S3FSRktsaTRETjBHQWVoK1VUVklvMTZCY0Rxcld6S0RhVHRlUkgr?=
 =?utf-8?B?N2lUVEhTVW5WVXJIbGdxNGV1MndoaE4wZlhtT2lELzZUekFIc3pZRCt3UUNu?=
 =?utf-8?B?a1pFd3l0Z0V6YTAvTHJENHFZdnpLdjR2ekJuNERWdTFuTlZxdHRPaHI3c2h0?=
 =?utf-8?Q?HmhZkri1F0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xnay9EcmdIMHE1WlNEY1dqcEhJU0txZUZjdGIxZ1pHYVg2YllVNUg5WmZG?=
 =?utf-8?B?VXB2MCt3ZFBkdG11WjNDNUd6cnk5MUdCZlNTdy9ob1VVSFVlYWNpbFBGaGp6?=
 =?utf-8?B?SjJQY1hSdCs2czFrSmFIV1ozU3RCMUU4TDhWWU5ITTY2cHRFeWErZGJNK1V1?=
 =?utf-8?B?YTE4VTVYSXJac3ZwSklRc29PN3Y3cEh1eGp3Ylh1TFVpZkt5aTNkelc3endi?=
 =?utf-8?B?dzdMVGZmRFRqWVBkdk1zM2szbzFMdDdIcjdpcWhmWlBVSVJTUmxoK1hEWERB?=
 =?utf-8?B?OS9ZekJDa3J1dzJScXBhY1pCZXpWVFhEV2pad1l5U2RuZTlPaCtsV3hJakFB?=
 =?utf-8?B?ajBZR2NYTnRCRmZaU0U3QkxHMlQ2NWp2WmR3azBObnZhZFl6dCtNcFhwekhK?=
 =?utf-8?B?dk9QemtldjhuUHlsTFVmTjErdk1ZSlJvMlRtanpELzhJUlpOWmxkemgwRTdh?=
 =?utf-8?B?T0ZHWWxSRENpQXFPQlFRQWlMOUs4RW9xdlI0OWFwckRoYkVUL1Zhb2M3VmZD?=
 =?utf-8?B?aE84aklnRUZ5OWwwYkhGTGt3OEtqSFc2eXY3L044NW9XL1dXdFhnSTZiZER2?=
 =?utf-8?B?czhhc0ZHTTZMYjVBY1RLRFlsTXRMUFpoMDNONlJjQkk5VUt3MWpOL3dqNGdF?=
 =?utf-8?B?RTNaZVQ1cGtXT0FkNy9pRHRZNEFyNnUyaXdtZVAyTWRrRHl3QjlhWGhOdndt?=
 =?utf-8?B?anVHcHg2dXZYWWZHYS8vTVM2anlaeTFtV01idFo3YzFxbHU0aGxkYmtUaWwy?=
 =?utf-8?B?WVphZGxVRUh1dHhiT2lFUlJZK1pqaDdBVnZ6Nk1lVXdiOFNpWDA4Y0QvQ0Vh?=
 =?utf-8?B?c2tnNVViN2pCcjljVzZScG52N3R1UkhVWFlLN1lMMGI0TkpZNE5qQS9jS3Jk?=
 =?utf-8?B?VXJ5Z1lLS2hKbGI0YmVxWWJpbUVBcG91M0VxM0xvY2szYWFEU2pxMStCTy9r?=
 =?utf-8?B?M3BUSzVLb0dod2lCNE5sMEhGT0xxTWxoSFBnZWV5bmlUTzR4TnMxZStNMGtK?=
 =?utf-8?B?M0c2MVp6VXdybE0zZmhiRktKNEpidXJ6MWI2MkhHM0JuTFFPUWp2emx4TThS?=
 =?utf-8?B?SXUwQWMySkhwSWpxdXlMVXdBUzlSYVFaSkJVZHg1TU1PcmNaZjY4RlFvRHpN?=
 =?utf-8?B?d2FwNW0wcWFOL0RhWTlKUUZZV1h0M1RuWEtlT3c4cjM4blFxSUl0YkhCaXRo?=
 =?utf-8?B?cVd5cWFVUXJmbE1VblRzSzdqQTlCQktwamRGOWgybXRSMFF1NkZDUEpUYmY2?=
 =?utf-8?B?cWZFOEhRSEJucVlEVkJaVDBFRlA0R0hFdU1BM3REQ0xMUlpNTEVCTW5nUFlZ?=
 =?utf-8?B?OE9CTndJd1RFNU5YaHBHQmY4L1M0dHV0Yk1jcW5EcllqbThjU3dTNW56WSs5?=
 =?utf-8?B?QVg0dGcvemRlOHoxakZUYWtvUUZGVGtPWUR1a1NqOG9tNTRid0N4czZYUStY?=
 =?utf-8?B?TGR3bGJaMTdFaXBneEVrTVRVdDVWSlZQNm9LYnpCUDVCczhiV0l4UUZISHV4?=
 =?utf-8?B?ZVdXK0crZzdOUytzZHQyeGZGengzOUFSZm02RGZvOVZ1aG1LR2hKWmxpQ2Vk?=
 =?utf-8?B?VUtlblhYczRhU1lLL3VjNk16MjlIOTN1MytJUG9GTzZwTDBaMytaMk9Ib1pP?=
 =?utf-8?B?NzVPdWptUnhkZFNQc2tEeVE4K3g4WUlLN0cvdXhHM0lvS0VlOHlJcHZlaTBC?=
 =?utf-8?B?QzlYNVlwWmZBQk9wcm5jV0ZWRTlKRlg4QTJaWUhxYnJoTmpuc0Mwa0crT2lq?=
 =?utf-8?B?WnNwYkhrSDZCd3BWcm1iNmJOVzNRc2s0VklwUGFReHU1R1UyR09yY2NnM3Vn?=
 =?utf-8?B?TlBxbjMzNHdQcEF2elZtZHlUcWJNV1RDa09GRG5TSDRLWDRmaG9BdkhNRDVm?=
 =?utf-8?B?ay82UG5XbEhMWkJyakZjVEZGTjRNbHJBdFRlK3I2TVhjdmZxYWs0b1lMSEpI?=
 =?utf-8?B?U0FQbnhKV3lLUHdmM1dMZUV3b0VCY3dobHJaZEFqaFFKNFIyOG02SHptU0ox?=
 =?utf-8?B?VnZSaEZqTDVxUkZVVk13VXlRQWJ1S2Q5RWg1YTVhaUlrNWtvSGxXNk8yeXAx?=
 =?utf-8?B?WUtuUVRCMGRBQUNqNEtrY3B0aTg0R3JjWnZ2czNWY2ZUN3FOdzB3TWlRbWl5?=
 =?utf-8?Q?1IG1M+Q6WjvV3+ZCatHuHRD8W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa623be-96aa-452d-4ea2-08ddb930e309
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:22:57.5940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re9zhK0nFHgNXFupgzSEq/4WI1IOLLhCkt5Hxab4wr28+9ICdkpznJFH5EFtnJxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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



On 7/2/25 03:04, Tom Rini wrote:
> The ZYNQMP_FIRMWARE code  cannot build without platform specific headers
> being available. Express that requirement in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   drivers/firmware/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 8789b1ea1415..a094e6c3afef 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -29,6 +29,7 @@ config TI_SCI_PROTOCOL
>   
>   config ZYNQMP_FIRMWARE
>   	bool "ZynqMP Firmware interface"
> +	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
>   	select FIRMWARE
>   	help
>   	  Firmware interface driver is used by different

Applied.
M
