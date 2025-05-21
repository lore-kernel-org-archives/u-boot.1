Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E28C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 13:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1D182E2D;
	Wed, 21 May 2025 15:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kUiZ7bg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7915B82E31; Wed, 21 May 2025 15:10:58 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0541882D06
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 15:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAiPjbnRk54B7+l1TdZ+8dJvPLNhsQIz0uXNNtwPNpgdTrQPNjl18vutCCFJ4AtMAwAYp/qaxRIKSDwWwHoZNE9ojiSR01KXk/75Gs0D8jiQFFH7GI1F7pRBsxOiYG5CqEf9jzxgCLos41vqDBmGKQyL1Z6ENp5Yuu2wYz7G1yaaOOwBmgh30T7CTEIrlpFd9tzZV97nRlsFZXuOLk03gng447uLHB+OX8nOJqTZL46+B1IamoXcwWlSpr6xqAoOHdpYhHW0db70ApvD5GbDW4uypn1NNwy9xu8dfpY0TRQUmBouxNhtFLhbT9ZZEHVGz/MLOkrsILwJkRe4XCzWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFOTMM+XPiQPm1fo1E1usbVm/SBfYyxIa1BwZtc69KY=;
 b=izk7y2oZvqvJVY2c4IRMt26qdqCMFNypVwzELxHa0qIYKVJBg6Lzv++V3clxyowNo60/ktJtpYmLxdlbMx6e5WmFefGQhtHbI/mJKMuBVlDlJ5fD12zYClXGt2UwURN9QkSNIR4ez8nZ1boY1bwPiEHHY/AOinojLTv1gBgEkuKX0DffeGXBfhVoauvlYba5xWKdHmMjvsSnVaEjwLn+dOrdmQzc+mcHQIxCXvAbJxt+4GTXiVA2SpgIN7zeGgQvwKkQVNl+dOPw9X11txlwvfLFMJqwxyYEEmTJgQEef+yeMF774Z78MP6WYJUBlM6sRrwpxrJNceZx18OEeFcf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFOTMM+XPiQPm1fo1E1usbVm/SBfYyxIa1BwZtc69KY=;
 b=kUiZ7bg0ovvdEOCFfeuK/D0atvZinwKHvHmm/C3qnWPoJLVlFOyH2JR6yTnmfDTOcXBh5O5ifwLdS+0fb8zti2r3qIZmyNRzYL4Z0A+XSqhVJktc6x9e6tkj2RSPJUJt6pRS6jeMopiTBUDhUTTW8urKkCuwtvqQf5X9CAQU5r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:10:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 13:10:51 +0000
Message-ID: <fcffae16-227e-405e-858f-e7481e2658ac@amd.com>
Date: Wed, 21 May 2025 15:10:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: zynqmp: Fix the pcireg base
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, sr@denx.de
Cc: trini@konsulko.com, git@amd.com
References: <20250516092314.939424-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250516092314.939424-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b39ef4-4018-48cf-2499-08dd9868e93c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzIvL2xBVlNnVmZVckxqa3BYL3kwZW1pdmxkOFR0bHlvOXdoSXNEcU5yN0Vr?=
 =?utf-8?B?TmZ6ZHNvd0lqTWxCNHB6RHI5RW1JNVNVUWVseHNlc2Z6UnpMR1pwdXJab3Rx?=
 =?utf-8?B?YUlodUxYY0xpYTdkYlAxbmpqVUY4YkwxMXY2cnR2bWVua2ZHektqbW9iVUMw?=
 =?utf-8?B?czZUK29OY3c1RHhCRmZxTzFURWJmY3I2dnBuNS93ejJJTzBVVm9yb09KTE5q?=
 =?utf-8?B?Q01aSFdqZUthaktUakEvMWRTNDllL1lSS0Y3SXFrL04xckRnRlZvOVNmS3RL?=
 =?utf-8?B?VjA5SUYzNHU1RkZvQUJqc3pxVnBPZHFpSkx3cUI2ZW0xQ2FVb3Z1SDEwN0dB?=
 =?utf-8?B?TmgyRmp1dUVoc01kTmFsL1RubnAxRitNYzNnUDh5V0FQUGt3a254UUdWb0s2?=
 =?utf-8?B?S0VoYU00c0VrTVhFeVh1N1JQV05NQWY0bnJaeEJxUTNOdGhnV280MHN6cTNX?=
 =?utf-8?B?MTdoM0ZjZnFvbmZlMFQwMnAvR0tjcHlQOHFNc1VJRHF6OTdaUkFSYTk3SnZI?=
 =?utf-8?B?ekFpcXltcndyQmUzbWQ1LzNRNVdoRU4xUFVITmVySnkwOVdIWEV6T1NIa0c5?=
 =?utf-8?B?OFk0UW92NitOaUNEVmNoSUlJc0ZOWDVPTXYvZC9iM0w3M2tVZEpDdjZFcHJ2?=
 =?utf-8?B?djlFSFBEak5IdlZySzF3UUZTaE1xdUpVblUyZ0oyVU5VaWdrbzlGZm1rb0dj?=
 =?utf-8?B?OHNZb1c0R2Z3QStUV2xBWTRoUGlieEIyZXlHR1hiV2VYZks5M3dpK1pGVDc3?=
 =?utf-8?B?djUycmtrZ2JVRStNNGlOTHZ1bEsybVhGV2N6OHUrc1lCR3RoTEVoeGxRZU83?=
 =?utf-8?B?NExMTVdCTEZTOG5BRjNySVRKSmEwUFNhZGc0dkhJMFd4bnFwT1pXQmE3Mmwy?=
 =?utf-8?B?MEZmREFYNFJUaFpxa0krZ0NENzlaQnZ5d0xrcHRka1Z3SVhLd1NwclB3VFJF?=
 =?utf-8?B?WnpML2ZNVjgycklEUURJVnpBbDVDNEtWNC9RbzU5TEVwelBUemMxVGlnMDlJ?=
 =?utf-8?B?TnlYbkNBaDc2WXVGaXhpT0lxMytuRWwzVkJ6eTkwTkNQSkoxYkZURTdMTE9J?=
 =?utf-8?B?M3NDd3B2K0x5SDVSWTROc1REcGpxdURXeGFDYzdtNjlPL3dxaUc1K3FnS0lC?=
 =?utf-8?B?Qk1SY3d2akJDRGY3dmZ4b3FIWnBIdzVpcmpXNDYwZTV0dUVzYUNDcmFnM3Fl?=
 =?utf-8?B?dDlVWFBDRzY5cTJpUEtpcDArQnMrR3hxVy9jd2FGS0pKbDVyTTRhdGxwL1Na?=
 =?utf-8?B?WHl4eVBKTlBCaUtMQTUrTlVRckdRZ2tNMk5qcFBhZGNJcXFZOVdQbjd1RkI3?=
 =?utf-8?B?U0hWQS96SmtmOUtOdXF2T0FoMEZRNHVGb20yLzlubzljQmJvTU5EWWM2OTlZ?=
 =?utf-8?B?cWlETERDMnVSZElaUEJtamFXK2lNTzY2NkJObkUrWUVodVdnYjFzQ1dKekMy?=
 =?utf-8?B?ZDQrazVHamZMd2htZ2NJM0plMlY3bVgwWmZTMVFURHJmTkxZUDY2dnlNNkhE?=
 =?utf-8?B?SmZSU2JZMmJxa3dKUWFFVTcwajdFTkVuYTFIanM5blJkM0JoRkgrTktNZnNJ?=
 =?utf-8?B?VWkxVkozNCtoSmxDczAxMytTcTA5WXN5MWpzSWVFWU1Xc3VMUS9WSmVvbWVV?=
 =?utf-8?B?OENyVCtLNnp6d3hyamQxQkh4eEYzVWNCUGdjMnJSR3kxZVY3bHo3Zjh4M2li?=
 =?utf-8?B?QzF3VUkvQm1tN0xwVm1DT3djcCtYTkwrSW5EeUpYTUN2MlB3dCtLOEVnQ05S?=
 =?utf-8?B?NGpudnMrOXM2K1JDeFdzenZ5eURvanBhRmxGb1JwUTVTWXJrWlFRcU9aakF4?=
 =?utf-8?B?Qlg5NFBhdTdmVU9EcmdNMlFOMEhSSC8vTkh6alY3d1prSlJFemhsSGF0K1Ex?=
 =?utf-8?B?bVM4WU13MmtqZFpFUk96T3hicWxPa2s3NVJsaFNhb3BzVGR4QXRFKzZodWVt?=
 =?utf-8?Q?4wslizRxU9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG9Xa0s5L2lYQWk2NnJrM25iN1l3aDQrbU9KMURoUjZMQ2ZmbmJ0cWdQYThI?=
 =?utf-8?B?dDNrdFlrdXBHSk13UkpBaSt4NkdjandqaklsaHo5UnRJOVpBUU5ST0NIRjk3?=
 =?utf-8?B?M3VoRzJEa1NzSmFHTG80NzhIZXdtOVh0dHNRM1E4K0JTTEJPanlzOEZaMjBY?=
 =?utf-8?B?QllIVVM5Yk05OTFhOFEyZmRoTEpyZUhPVFl4bk93QWkwd1RmOU5NRVIzQVdB?=
 =?utf-8?B?ZHhxTHRKV2lqTzhpSjFmMk9HYmw0Y1UwTFFRaU85NTFjTllvdTBBRWlYVzVX?=
 =?utf-8?B?c0kyb3lKTzlCVWNGcFF3WkV5emFDL1kxWDZSZmJTTng3V1I0REY5eitQNENW?=
 =?utf-8?B?MEJhS1dDcUNBUU5WVHZhTURiS09NMlZHdTZaODZVUVVEUDV0S1o2Y3VDWWtW?=
 =?utf-8?B?RUo4MUVwZXhqOXQ2WWxoSy9wVHlrdU01V3Z0QkVrUi9ETzBUbjJmdUNFNVRq?=
 =?utf-8?B?WGM0Q1AvMjlLSTdWa3hRczdTeStiaXl3d1JTcUxMNVBscGNNUlVUQWFQdEUz?=
 =?utf-8?B?a1p3MEcweHpKd0tSajBzQUJveEVRNUNibEl5TjUzTjhjbUNCMWRSQWIreUFk?=
 =?utf-8?B?eTZIc0w3ejFHUW9odXVFOWp4TDhKMUdVMWwrQlJ6REUxNjZiSmdlSHBnK0wx?=
 =?utf-8?B?SFQrRVpCelh1R0tZMk9IOStkUmlXNXR3YU0waE5mRVUyNnVSNnArODhBNXg2?=
 =?utf-8?B?dkhFUGFNUmd5MjlISlZROUlaMEQ3NTN0QlFxdE1JTDhSczZrcTVYaWx5MGNB?=
 =?utf-8?B?Q1g4T1o2Z0J1RjZINkZhSTZpK2UyR2dlV3NWSFQwT2xjTTNaYTBhdWRGcnZU?=
 =?utf-8?B?amZ4TVZCS3E3d0tVMnBuUnB2RFVTNHdxbGdTVDJ5WEtreUV0ZGF3b0ZDeHhH?=
 =?utf-8?B?cS9lOWNtNGR5dm5aY04wSHRlTmlURExDNFc0SCtnOUdRbGZCVVFjUzErSEpS?=
 =?utf-8?B?UTFFMWQ5K09iSXRHc21yUHNqQlZQeUg1OHFPLzRXSXc0dHpkc0hoTW14aUVs?=
 =?utf-8?B?VUlPODJrUnF6bHlpUHUxT2pTMHJrRnExZUtZclVoQU9WMUZFOGdWY2R3Mk83?=
 =?utf-8?B?ZlY4WE9zZDhYck11NmFhd1JNYU9aSkw4NWdHSG1HVmVNSG1XUk1CeElFN0pP?=
 =?utf-8?B?US9pOFBFZGFlS0dmY2xjM1pVSzZubWJtS1Q0OHFxQmZDQTNYb3pmS09Md3Zk?=
 =?utf-8?B?dW1lamRKeEowNVhOR2NlWjJEekhIeTFLZnU5Q3ZEZjk3OVdZRmVtUVYyTmdF?=
 =?utf-8?B?akt4TnZqVStNd3JkalpFeDcxTTNFSGU5dU1GdTlacUVnc0ZuUXo4eTNmaXBt?=
 =?utf-8?B?aERpQ2E5SDZCeFpYRXcxb01rNWFKMHZ1bXdXQnoxZnhHK2E0eHVDalZIRGRz?=
 =?utf-8?B?cHQzNDZJUUhCc1ZWVlo3TjNnSnJQRDFXREVHSytET24wbGIzMzBHOUNUN0Jn?=
 =?utf-8?B?SkdlUS80Y3AwYTIzdU0xUWM2aDhoRnhWM1lZWVl0Sy80dmxlRXJyTmJnQXo0?=
 =?utf-8?B?SWdJeTBpWXN1cmlOcytyd1I1dUJnSHdFTGhiVXlZOUc0WThrNGdUczJjU3dl?=
 =?utf-8?B?V0dPQTBEUzU1N1VsaVhwZ0FFU3kxQWJ3YVVERXE1NkliVGttZXRFV1ZXTThK?=
 =?utf-8?B?ZCtwVzM1dEhmVWVsNVRhQXZyN0w2dGhLNGFlTzJLUU9vNW9uM3ZFQ25jN0tv?=
 =?utf-8?B?SE1UN0dod2tXNGVtcGtDQzdwOERoOW81cnNrVDJ2ZW8xeWVWZGgzRGhzeXJ5?=
 =?utf-8?B?czI0cTFmQVhtVmkyYmxKajFia0RWZlFmWkZrVjlQUzBSc0ZaQ2xYanZLakpH?=
 =?utf-8?B?dlNFQjFWRFBoVXhBK1BqUlNQT1g1RERCS2pIUFp6V2F5Z0FVYTNQdEJJNVZV?=
 =?utf-8?B?UjZzRHZROXBCWGJkRDZCNU9LWjJoWXpqUzg3Q3doU0hwWmgwSExMcmM2MlVY?=
 =?utf-8?B?OE4wT2ZDZVptZlVKbGdVUTBKYXdQWGdudWtMZU9PWGdacWg1NkcraVN3cDls?=
 =?utf-8?B?YkcyZGh2dVhscmF6c0tCaW9wa0hrNjZVQlhoZWEzYzlQZlhFM1p4T1FIVE9Q?=
 =?utf-8?B?WS92TFZDZm15RTUvOGpKcFB6cVRlelRDV1dzdnl5cS9Fdk5DOTFoOW1SdnJu?=
 =?utf-8?Q?kop8fN5pj8ekxKGh1wUUNR8eg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b39ef4-4018-48cf-2499-08dd9868e93c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:10:51.4990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GEtVPwCb2Zpo4qWu4xhwf3/mWgcClaTC0s676i9/saQIETJezLCvNQQWIbKjHWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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



On 5/16/25 11:23, Venkatesh Yadav Abbarapu wrote:
> The pcireg base is not assigned to any address, reading the
> pcireg base with PS_LINKUP_OFFSET which is incorrect and
> giving random values. So update the pcireg base from
> devicetree so that we can read the valid PCIE link status
> and PHY ready status.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/pci/pcie-xilinx-nwl.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
> index 7ef2bdf57b5..e03ab3be912 100644
> --- a/drivers/pci/pcie-xilinx-nwl.c
> +++ b/drivers/pci/pcie-xilinx-nwl.c
> @@ -303,6 +303,13 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie)
>   		return PTR_ERR(pcie->breg_base);
>   	pcie->phys_breg_base = res.start;
>   
> +	ret = dev_read_resource_byname(dev, "pcireg", &res);
> +	if (ret)
> +		return ret;
> +	pcie->pcireg_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (IS_ERR(pcie->pcireg_base))
> +		return PTR_ERR(pcie->pcireg_base);
> +
>   	ret = dev_read_resource_byname(dev, "cfg", &res);
>   	if (ret)
>   		return ret;

Applied.
M
