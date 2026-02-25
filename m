Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7D9FD3764
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC578401F;
	Wed, 25 Feb 2026 15:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZzxjQgZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E032D84034; Wed, 25 Feb 2026 15:54:57 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8300084011
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co+I5HEFqo9BMOIxPl64zYIg7gtwhpf79C2tvKGKRnN9PR/v6I+heikhBrZp1SGnbpm70irf0K+J9VCWV5bk2rzTe9pIX05qQl1PAUdxc20/7nBK+PFm1ZbtfXWlMnI4oM3MbMpc7JRf7EFT2RdwOc+GAVPhPyx7bzFfPMbQMiesljjZziJ/5IUfXclhM7g0fKj0dHXUKsXxL4CZ5A0sjaGJKg9Wnb4puAqEkpLFxx34QpqlIJGpbLojFcx1ve7UJ0QtNS5ZhyAkh/sAQCOBZc56VpBmjJp9OnZwlSbRPPQoL8vb+/BLYLpPMydBB8YUBXJwaye+EvTXJqCrMIHPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nifLM0JPZf+ccQQcYlEgdTNKiZYFpQppR2gWyaEDc1U=;
 b=CMxQJVB6dIytTzkHNe0K9hXfPYoz8UrU3/SUEyCXXre0ALTT6FKSHLh7bVQcKT+j9orESJRuOURx+LTFxBCGIwS5R5rfZaJBHFjuk0hhLsLC6ZoYokkuv4LA27G4Bz37wSKsTlOCHOrVBdmxcUGUpDFqfas8SSINeYAG42C0/I2Errm5z2iePXK0np7tS0vZQ0IDr9181XoA3MAYZzKsLUyDpD5HEuAF1T9JYjbdAkJUdVDIHY4XwqTrbpshkovL8a7rsSut1CsB3y0t63pt8G7zUokpATBvmEn/ZJynErBUIQIutDL+Uq5Yg4oADBlNBSSfKKQPx1yg/bquuTzCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nifLM0JPZf+ccQQcYlEgdTNKiZYFpQppR2gWyaEDc1U=;
 b=ZzxjQgZ+jqOTJlo1q/WOMkEFvAFGKhiLPVil+ThFw/dWW+ihK4kMH97QY4rkt/6rlBTArRIcNRzrKAexRybffderv9Yow81BeWt9MQo/AuLOLBoXtr7MUZv6s/v6Ay2t8Q75IsRz1ZLGMeijfJb8JLMmip0vwYdydZdC7pSJ+v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by FRWPR04MB11176.eurprd04.prod.outlook.com (2603:10a6:d10:173::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 14:53:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:53:38 +0000
Message-ID: <c68c7b43-3dcc-400b-86bd-57f118e74d09@cherry.de>
Date: Wed, 25 Feb 2026 15:52:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: Drop phandle from diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260215140535.691319-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260215140535.691319-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|FRWPR04MB11176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4323dfdf-88f7-4bb2-eff7-08de747da8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: m4gKcgNK8DvjozPXdKOr2r7eiTdJAKGBYH8Vrfqs/6Zb4FXzi9ySkmaGNcj49YA/4H0MRd/BMpFvMwi591lP2feXqBHD7g+8y7A1wnLC3QekG7uHQjUIvlM25lbGBceg9+I+4oSOZCfSf3JZPmvwwSvsnDiH3FoodpOZnz//4o/Ui6cW1D9q1E54YIxg0g1gFWYxS4ctsFgTLCxpOEBT/Ha6ZqLPob0MKkuNqc81O4FXp76DlcDLMJWUu9q7o8Appd74ffTz0aGpJ0wRuLLP2lJYjaHghmnlkHD6jCTpoCC6NS5Ulq68Gnwf5TjGkrcwMvxCoZbVVrrhcaTLfnPPFFO+pZ10E8Qp9a0SUWRsjUFO+XowkACpgYDKs6DAWLQOrcpCY1/hVRux43OR4b4jq7l1L9A+4RynJx+c4L+XZMpZzFZ/gQ03++ZeLeYu+VVtzvJGPWa7tujbsm52O+L9pRUUq9fkN+gPs6WpiEu+rCROGUTvkcGMzz7Gl5xUBtJ6RjM+ugwDIRlO0r1fGeXclnCCfXzYuFNfQ8GsZXNwHOf+HtEfCzTUb0OKxgYue/3GoNSQhRfZ5hol3PlljL1TIDmgX08iUm+1XLEr9t9BhU2LcmKWgiLPu2sI7v1EwM3qb116crlYlZWq4AGvifXOFnI9VU/dkCcgIsW07MzIdgFWE0nB3G5OwI5LkwEwYrxWa2czQmA4rJrOTjYTgcJcPRXMTwl+Z0svjT6xlekHg8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5QMVlwSnFUSm1KczA0VXJhcXZyQ2FuZktnMXJvMkNEZlFHYnNDcFFKcnJw?=
 =?utf-8?B?ZHh1aStZcmNrYmRSV2llbDVXME9kUVp4Qnh4VUYwZlNVUkVvZmp1SHZ4ZzUz?=
 =?utf-8?B?SXBsV29xMTBuYTRYcEN0L2ZscmQrTEdzaGpRY1E5UEZtZnI3YTRCbWxnY1U2?=
 =?utf-8?B?UmljOTlSUXJvQlVtQUZJbUo3a1JXVVVmbmhmUVY5Y0xEbzlXMURvRnpVVThS?=
 =?utf-8?B?UGZuVjExb2lsMXJLMWJjbk9tbDhhdHl4TE9Zd0t4aGZNa1BXZ1BOaE1IUklj?=
 =?utf-8?B?ZFBJUWovaDE2NkpIOUkwWk93UkVGMHpJS0hQbXQ1bUJ0K2lDckJaOEtaNGZw?=
 =?utf-8?B?aWwyZXllS0lPak5tQTRIMFBiWVF1R2hTVG1YbktGUWNuS1NKcDMrTm5YUzJ2?=
 =?utf-8?B?eEZQa0hheDNwVXZLMlhBNWxBSitmdmIvQko4eUFJaHVVaDcrTDdzYWZZSCs3?=
 =?utf-8?B?NkU3bEU3d29wNjJOWkJZemowQkxoQkJ4anY4VWZOQVJabGVvZUNOL1lrelhD?=
 =?utf-8?B?aGNkcGNTelJkTVljYXNtaHU1bU55aXUwd3Y3Y0tqYkFqVUJIR2VvbVdOU1R2?=
 =?utf-8?B?djVLbDhjemtFM3dvWjhHcm5mblo5NlhPS1RjQ3JxQU5mdXdZM01IVzBreXJi?=
 =?utf-8?B?MElCR2lLZTZOZ1F1L2gvNUlJZkxEVTM4amRhMVBNbWwzQ0MxSUFuZWRtVkll?=
 =?utf-8?B?Vk83MjluVmFhelFMM2YrSGd2L29nZTJncDYzbVJYYWlqN1JLT3VyMTczWU8r?=
 =?utf-8?B?NHgrWVdlaXNQc3RwMGcxUDI0UFVDbjhtdW1PSWl3Q0FxZnpLcTNjaUJQQmU5?=
 =?utf-8?B?REx4eTY2eEQ3eitUbk92eUpqVnBkcGhZK0JDbGphNmdHczVmd3d4Q2RQajQ0?=
 =?utf-8?B?ODhrL2lHVy9SRDUwZm93VmxldE5ha3RneGZyS0s2RGVpQzhac3IyRUtsb1Iw?=
 =?utf-8?B?OTlnZXMyVmsxSldDcWR1eGhDYmhSTUN2QVRrclNsdEF0alZsNFpDbDBLZWMy?=
 =?utf-8?B?VjExYlpjRVhoSTRRWWhOOFNqRVBlR0I0WUNQTDRHaDYzRWcrSVJrS0NteWFQ?=
 =?utf-8?B?LzJ6Q3FOU0JkYTZ5WnVJT1ZUZTBzcUpKRFdhMmFONHNDbnIzdS83Q0RWdkVp?=
 =?utf-8?B?SkxrMWVJZElDRkU1MTBYTWZRUmh4QTI4aDhhTHVqUnVyRjNjVCt3U2lkZHRB?=
 =?utf-8?B?VDVxM25BOXhPS2ROOWpzVkt6OXFjSllQUmtsWjRaUzU4MEFBbnNmSzZzOWtM?=
 =?utf-8?B?N3BNOStPTnRqTnViTGZ1VU1RRjJxWWNJd2Z0MjNNdGpRUHZyOGRiNHkzRTh0?=
 =?utf-8?B?dlJzV3dlTkRkMkNSZzIwazZ6bEFtZkQ1eXZWVzFGcGltai9rQVljMTY4SGxq?=
 =?utf-8?B?UkY1V2ZNWk50d0RXNjZIUE54RXZPaHFzaGszMnFlei9GQ2xYa3pBNlhkUTJz?=
 =?utf-8?B?d29Bd3dTcFJhcGhHeDlmMWFZNXVCSENtaHVCeUt2QUFYQTRxaW15N2cyZlFz?=
 =?utf-8?B?R0pTR3VuZjhsWFlBbFFmdEE2QTZRUGtEM3NsNGlnZ1RiVHpCMUpWbG5KZEJ1?=
 =?utf-8?B?M3cvQVZ0b3ZVNkI4VDZWS3BkY016M0JPcmNObTBST1NYcmFkK2VTNEFMYWo4?=
 =?utf-8?B?VXBaV0tlNkpaTW1JdUZLVFZFbS83MWFIb01yaURkaXBDRjZzZjVHSi96NU9U?=
 =?utf-8?B?bVlYejN2NjhwWU4wRVVtUStVTEtYWmwrU1dBYlpCc2U3WjZQZ3EwYnZScUc3?=
 =?utf-8?B?dEdYOVpLNmFxd2djSmk1MnVTVjlWMDQrNzVGV2pxL2FuUjhxOGJ0MnY0MDI0?=
 =?utf-8?B?Z25FR0JDdXlzM01mUy91bDVPZkRHQlA2UU9xQmhXVWRCc21YRHovamhrYSta?=
 =?utf-8?B?aUg5V3Bzc2dKYVpvSU5YODNOZzFLbVYxN2lJTlNaYm1mYW0xelNBV2Rtbncr?=
 =?utf-8?B?M0RLdGxadlpQWEthV0M1SkxodVVhRGtsOFY2R2ZCLzJkeHB4Wm1PR0lXL2w4?=
 =?utf-8?B?NzFZbzVDbFZaQ3ZUam5mUDV3UDVONFUzb0NjbjJzZnpTN2NzMDUrTVFIRXNI?=
 =?utf-8?B?NWF2UDJFVW5MSmJhcU9QNjczdUlIRkIraEl1dWhkeEtrYnFxZFZWRmlGb1N6?=
 =?utf-8?B?UW1sNkZoVmExc1BnTStXRG5YRnpSWW85QXJxUEkwL0lrRlZrbUJRRnlmM1pI?=
 =?utf-8?B?dk45akwvdlo0MkxucGFlRU01MnlMbUhpNUZCd3NXL29sbUQ0eVRvakQ5MTF3?=
 =?utf-8?B?WVRKR0xtak1PWTh5cFlaWGZxNVZKb2tDdFlsU0VBbURJZjhBN0VQQ0JJdVln?=
 =?utf-8?B?L1VqMG0yTi9xOWp2T3ozME0wMjZLR2JMYmtJRkI1QlJZWHZWbHRxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4323dfdf-88f7-4bb2-eff7-08de747da8de
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:53:38.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKPqpeMK4BvqJVfLNgbzGzWkl9Sp+GIMSDUjOUV+GVSXiNdfhK0WW2epT1zt24bIvULRHpJwtXp5El7yFgHg1F+hZGRhW3Bbcek0xHLU+nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11176
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

Hi Marek,

On 2/15/26 3:04 PM, Marek Vasut wrote:
> Remove the "phandle = <0x..>;" properties from the DT diff between
> unpatched base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1.
> The phandle numbers are only generated by DTC, but not referenced
> anywhere in the DT, because the original references are specifically
> not replaced by phandle numbers when recent DTC is invoked with the
> -I dts -O dts flags . The phandle number are therefore only a noise
> in the diff, filter them out.
> 

I didn't see this patch on the ML and actually implemented something 
similar (using grep -v :) see my patch on the ML).

My patch handled an unspecified of whitespaces anywhere in the line but 
I guess dtc outputs something with always the same amount of whitespaces 
in the same places, so:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
