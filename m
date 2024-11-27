Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63603D6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C381F897C3;
	Wed, 27 Nov 2024 12:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SQ2kQ0sM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD67897C4; Wed, 27 Nov 2024 12:41:47 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C1A8977F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLgIJqFn3J+F/LhRL9eFzO1tybjuCOcwpXwgpcKemppKQU4MiI0zEdjWogXLh3kcP2DOhPuAAKCxbU54hPrXw8tCP00iu5rEYjCFHs8ScnOBzae8Pe3+zNEkLj8IP1G52Ij65qg7LscQ7wkiFhbiI8dZ3xK9uQWERIu543ZMU8ok0Mh3iX21Nk51mWO3/NZp7m+a5fIon+7a65fGm0IKMXRlhOhFef00Kz4TDqTcSGpJf2DfYepbAlaKycVx1rHBrUU26aIay1/gR/3loyZ5isAT7lvUAUlFFQKeB3AxKiN3+6xBUcqls+FpLPGJymWKGs++J9+10k7+JrbAwfOMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMNMBz0+R67QxUHTZKwqOZ+L0iBXHSTnzjQRmdbK2Ss=;
 b=L7eDJMC1OXt1BkQY6Gk6CI+RNQsJZwoQ6EZ+n9IbpvmmhzXt2s/vC5O68k68ZAV+2NY3nfJNPZYrwkUXFKE0V4hE5W2Um4agP3DChhJP4R8D6rkKxpjdVdm3DjqVrpp9bkS0S3XxN4pXvGD9FoU/lOWQgULDBA085URbn6KALI0kxiggbPn4PTpMc6ohKYguw3YVKa1/VJe0taF6KhzVr2zM458DE2pQXsXJ5+uiw1oCSXfj/C+CjHFKpU31ZI5UlCeByUtIWdN5hyK4co2Q+sLuPGg70/R2UZVxHJEYTptah+nN2E53gJfDEaWXLGxtbnDz+Ych4BCjsisR8an3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMNMBz0+R67QxUHTZKwqOZ+L0iBXHSTnzjQRmdbK2Ss=;
 b=SQ2kQ0sMOJ7pNTe+M/zLgCiUYpbUNRMNCZvuc6lPOEhclALR6YgjuDIUrmUGDIwS1lNUpaQ6ZVGd/myffmYCBHwy5YwK4FUmwAMVZw0RRe0/X3OPckDv7gMv0dkaJsvwaGgN5IAKhqPX0GOSL0S5+mk0ONLBXzTh0obbQO8xgp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:41:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 11:41:42 +0000
Message-ID: <a3366e7c-66c1-4f6b-a8e3-81822e520754@cherry.de>
Date: Wed, 27 Nov 2024 12:41:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/39] boot: Split pxe label_run_boot() into two parts
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-11-sjg@chromium.org>
 <c7b987aa-13ad-4fbc-b321-ef3ee161dd2c@cherry.de>
Content-Language: en-US
In-Reply-To: <c7b987aa-13ad-4fbc-b321-ef3ee161dd2c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0186.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f079a09-0817-4627-6f0b-08dd0ed87673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bElyVHd6NnVWM2lvMHZkSlMzSXA3aklQUWtXVXZnb0dvdXgySHRIMnNYU0sw?=
 =?utf-8?B?NjVXRy8rbXFwRm9hakVjMHByclVyMms1Z1kzZ0k0SElqNmlUWVZxdXZnRk1u?=
 =?utf-8?B?ZlNGQlFMaXNCT2hacWcyRzRTRGNYSHhQNzBPQkJUeG14SUlBdmhHK2NLOVdq?=
 =?utf-8?B?YUFVdmtkT0xjWkVuSVBNQ3RKcDM5NlFPYW9aL2x3R2JpaDE2d1BLMzZBa0Z1?=
 =?utf-8?B?ZndFRlZOcjl1bFUwbkhrcGpNbU83QW1IK2piZGRSNzdVb25Ma3dSTzJQYkw3?=
 =?utf-8?B?aVdVWjN2aXdGR1ovNjVVWGFQSWU2TGROZEQvanJCM0lXTnl2OWxOTzR1dVFj?=
 =?utf-8?B?Z2UxeDg3MUMwUm5xTlIxS0Q4ci9LRWM5djlob2s4OGsxb0lsQkFSaTNDUVB2?=
 =?utf-8?B?NUN2Q2Z5TXpRdGFJQ3FUMFNxaWl1akR4ZXhKUk9XKzdDMnFudXVIZ1ZRbFo1?=
 =?utf-8?B?dEZNdzZpSFJUTjYrTm9xUTBDdEJBKy9rQ0oxUWVKWE9KVmY0dWVmQUJ0TVV2?=
 =?utf-8?B?WlR6ckwwWWMrcHdFUnNpTzZSR3VLU3pnaklrTmZyNkx4eWZyVERhWm5kNE84?=
 =?utf-8?B?YTRKY3AvNnA3ZHQrVXdWUHZTOTRUaXpERWpKZzVkUmVVemJqZFRRQTBqbi94?=
 =?utf-8?B?dWN0TFZBb0pFV1JGcTFFMmRDdFZXMDdsYnRWcGZLLzZQVEhzWkxvdXZ1VU5r?=
 =?utf-8?B?emtqNnNuNStKOW5LZDVTZ0pmVlpYM25BWlgrUVd2dVZ2emV3aUdOMWgrREFI?=
 =?utf-8?B?OXg4dmZrVzhLTWJrendKaGp6UmFXOTBSTnZZd0E1UVo5SzZNQjlhM245UXpz?=
 =?utf-8?B?eWJNaUM4WUFqWTRRQk5HL0ZaN0VzOG9Xdlo5WlZBMnQ4UXlidnhIRU9Cblht?=
 =?utf-8?B?Z3ErTnNHWDExVlBwaVVkVzVBeGtLVGh0RjBiYUxhNy9rd0tVYmFxcnJEZ2Q4?=
 =?utf-8?B?aENjZ1dUSS9pOWwvV3VKTTFmaEZwUHNvUjNrZHJrZnk3U0Y4UkVVWEh5Nm5Z?=
 =?utf-8?B?TTloejh3UXRXdWF3MjZacDR4MDRqVk4wQjBKeTJhOXJBME52VlVVMjBSTlVH?=
 =?utf-8?B?M0k0eG05SXBQVmoyRDNIRjZQL2xYK0tLNE03YUU0bzU4ZHZ3L0Q2b0pkeHFq?=
 =?utf-8?B?TDlmMm1xYW5wRnNyY1dtbjJpOGNtbk1lR1JCV09pVS9nY2EvTHN1K29ZUTdB?=
 =?utf-8?B?TDFzODQzY3dMU0h4MkMzWjVDMGRqVS9nU0lFOHF0T1JHMGZTRXRGbGc2ZVg1?=
 =?utf-8?B?UnY5VHhtZTB6bHVvZStLQWxaS2F5dms3YWF0SWxpN0s5MDJURGE2ZGozTHBS?=
 =?utf-8?B?bTVTcjB3SXJnZVRaa0hFVWkwS3B5UVZucDVyYzlmSVF0K3BZK1pMSWdxamcz?=
 =?utf-8?B?V29VOHhRWkZ0YnlUZlUydm9oZkVDRGtON3dnMGlBZnczaUt5SUhxLzJxT2s2?=
 =?utf-8?B?Nk9hMytBcnNGUzJleFlKbS9wMGc2a2ZQbUVhdUx2STQ4SDlUdW1RWDFWZyt3?=
 =?utf-8?B?R0ZUenk5TEhyNlVvNVJ1TEVnOUlJeVdCd3dlUlArN2dRZkNOUFBzcEN3bVBK?=
 =?utf-8?B?WU5hUEladW9QR244WFRXcWhWS3E1RE04TEdKYjgwVHR1dzI2QzU3c1BIQnJt?=
 =?utf-8?B?S1IyQk0yMU9vL0JsWVYrQjVxczM5dXhEeXh0aE8xMlYvNitRY2srWGM4RGtQ?=
 =?utf-8?B?VldWU0gwVjFPWkFCY3Z3azBIcEhvZGwvOXhVNTV1eXlqY25Fc2xUaHlpcm00?=
 =?utf-8?B?Mng2Sm42L0lCaWgyMysrWnNXV1FpUEdsVFo1RFB2YkpkNm5KdUx0K2ZlcjIv?=
 =?utf-8?B?QXY5d2x5aTJSSDhZdTJQUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3NvdWxDZ083aXZPTkhKTEQvRzlIbVY3K1ZwTnkrNUhwUWlRRVZhbkRVVDc5?=
 =?utf-8?B?VjMyaE9VVy9kZUJDNHZVYUVsZFNmb0RhVmpKQzU5aDNRdmtDSkYySEpXSDlP?=
 =?utf-8?B?clRZM21mQjRMcVIwNHV3OTJSUFNjOGNpQ2l1WGY3eVlscy9ZUzhLUXdiTEdK?=
 =?utf-8?B?STlaZGw5ZEFxNE5SbVA2MHlHZDZnUmsycUl4YTNxb0lMNkJ1c2xIdWZkWHhw?=
 =?utf-8?B?a0ZJVGQ3andXWk9hSUFnNzZSWmdMVThNUHFmZUViZjlVRUdHd1hYRVNDUitG?=
 =?utf-8?B?N1NGRFFtaiswSGQrMFQ3cllxK3JoNUh6QnpDVTlQOCtqRjhKUmtkbzhETTJp?=
 =?utf-8?B?ZW52MjB1a0t1NG9WL1ZSKzRmTzJmWE94bnFnQ2NUVCtqYzdValRCME5tZGNZ?=
 =?utf-8?B?MEk5UExCeWNDYTNjdmlUZ2x4WWgxenUvTHQzekVEQ2NVUlZPYXMxRkE5Vkkz?=
 =?utf-8?B?eVZiZ0x1QTBRMDFpSHhjLzlkNVF3SEpTUHp6TEhSckFCTWhrejBINVg4S2xx?=
 =?utf-8?B?VG5Dc2JSRC9rbEx2REgxYzFWL3BWZlpkU2pxWVgrN0hYcDVUNFpEaUlSeWs0?=
 =?utf-8?B?YUw4dkl1VVUzZjhRUnZ2d3pIZVdINnF6TDlidDBmY0I5cWthQ2NmSUc2Vm1Y?=
 =?utf-8?B?OFNEMVRpMHpIeTFIVXF0N3VIOFlCKy9nWUtnU0FqTmxnQnZvMjhQRDdKenFI?=
 =?utf-8?B?Nm1vLzVBK2tyclNsSm9COEErRWxUdmRxWHRaYkw1cXRaR2pEendaTGRXTGht?=
 =?utf-8?B?QXlUN00rOExCVDhHUHB2dkRoQktScSsrRkFVU2NieElPc0p1VmRWQW9WTHN6?=
 =?utf-8?B?b20yaEhGdVJlTWFkQ0NpK1p6V1RRMVhYZjBTQnV0QjN1TGxVNWcwRUV3Sm5o?=
 =?utf-8?B?SHhkVUF6UmVXbE5uZGRNRzdBRUpoanVzZm41UnRuSTg3NmtCYVo0SUx3eCsw?=
 =?utf-8?B?OGsvRW9HZThTNTF3dFdHNThGVjJzemU0ZnpXTTJFN0VyMDZiSm5WS1krTU8r?=
 =?utf-8?B?alEvUXNiMjdFc0I4a09tb3grcmdndEJydDhqVU5TSkxudnA0M1UvVUM1akNi?=
 =?utf-8?B?MUQ3OXJuMDJ2RjV6U1lleGZSUmZSdlZlbGMyblE3NmV5bFkyV2NzQS9LbGxW?=
 =?utf-8?B?MlloanBaaUdQdndzWnpyTUwxa1BmSzBDNllUblY1bEZISlhVdDhpc1h4K1Q4?=
 =?utf-8?B?NzdIa2VaM2Y4dmRSY3dabmhKWXU5QWUzN0FtRGl0WTNObFJPaXdxbFBJYkFH?=
 =?utf-8?B?ejRIbld6M09SNGZJbVlhZ0tSdUQ0Q056elprU1JOdmJwc01iaXhsS2x1V0VH?=
 =?utf-8?B?MVhadUw5ZFJ6N0xzSUlPWW9TR1JXdUxnSVI4N01va3pEb1FOOCsxVTk1SGhk?=
 =?utf-8?B?cjNRdjFQVlo2ZE1maTViL2p2a3M1QmMwcTR2SHh1MDB3ck5leGRObk5jVFk0?=
 =?utf-8?B?WlJDdk8yclpxR3ZoclZKeCtFQVZ6Um5iWnhuTUJZeU9zUE03RHZrbmZacDg2?=
 =?utf-8?B?N3l3V2hLbks4SkJsQ3IyQTdFZHdHcXoyWXVHVjg3RDRGbEJLWVR6WTdNU3FW?=
 =?utf-8?B?d0RLSFRpODRPZXZrUVQ5ejlDa2JmcmF4R1YwZ1NKUU5PMjhxU2FFY3pGVFFK?=
 =?utf-8?B?cTBNcWErK0lnbmE1dVpIYUR5QlpCdi9MWjh2NzhYcDdicU5wQkJYa0ZvOW1Z?=
 =?utf-8?B?elQxb1YrKzg4ZGEwRXRmbUNqbXJJSE5vV09salpFUm9DVlNYQ05GbkZ6TEhj?=
 =?utf-8?B?amZhZWlTUmZndVZVWi8vZVRYRDBHR1d3Y3JxYjF2cElSMi9UWnZMOGhIRm95?=
 =?utf-8?B?NEYzOVE3VGthL3VDdnhrRkI0cTFrR1p3MENwM2JYTHppbHptS2FoaVluNjVI?=
 =?utf-8?B?eTYxcWw2dVVCZ09ReEcwMmg0MDRlUjNHdUsyOHQ0SGhsWC9JclU3MUJ4TkhO?=
 =?utf-8?B?N3NwVDlXMDR5ZmF2N0RNNHgzMXI3QUdFUEh2RklILzR3cVkzK0ZOYUtFUFhj?=
 =?utf-8?B?WFlHcWFBRmVJYjBxYUVtcnZaN1Z2UjkxS2hEZjFENU1oZGtkbi9IMXFySlZC?=
 =?utf-8?B?UFVWTGhrUUNxclVGNXhlRlJ0TElxSTRPTU5wTGRvQmRTcjJrQzMydlJtU1g0?=
 =?utf-8?B?N1Vpd253cmxRUVVEUkVoM3ZkUFdCYXhPNDBqQWVwamMycktybytqUEQ0VU1E?=
 =?utf-8?Q?RDF3k/HH5FU+7jIh7eRG8Hg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f079a09-0817-4627-6f0b-08dd0ed87673
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:41:42.0616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjRihevyjypIVFfcwrdCqon3E6Gd4CxBwuu1ygmdhxNEX2pPNk7owAc7wFdwFSJ5Y6RGxL5XF9/i76oXdfRHd8Ln59ENMjQ668SyroVlIY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8412
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

On 11/27/24 12:39 PM, Quentin Schulz wrote:
> Hi Simon,
> 
> On 11/19/24 2:18 PM, Simon Glass wrote:
>> This function is quite long. Split out the FDT processing into its own
>> function.
>>
>> Add a function comment for the new label_process_fdt() function.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   boot/pxe_utils.c | 100 ++++++++++++++++++++++++++++-------------------
>>   1 file changed, 60 insertions(+), 40 deletions(-)
>>
>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>> index edccb29e770..97dd5a36150 100644
>> --- a/boot/pxe_utils.c
>> +++ b/boot/pxe_utils.c
>> @@ -432,51 +432,37 @@ skip_overlay:
>>   }
>>   #endif
>> -/**
>> - * label_run_boot() - Set up the FDT and call the appropriate bootm/ 
>> z/i command
>> +/*
>> + * label_process_fdt() - Process FDT for the label
>>    *
>>    * @ctx: PXE context
>>    * @label: Label to process
>> - * @kernel_addr: String containing kernel address (cannot be NULL)
>> - * @initrd_addr_str: String containing initaddr address (NULL if none)
>> - * @initrd_filesize: String containing initrd size (only used if
>> - *    @initrd_addr_str)
>> - * @initrd_str: initrd string to process (only used if @initrd_addr_str)
>> - * Return: does not return on success, or returns 0 if the boot command
>> - * returned, or -ve error value on error
>> + * @kernel_addr: String containing kernel address
>> + * @bootm_argv: bootm arguments to fill in (this only adjusts 
>> @bootm_argv[3])
>> + * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if FDT file 
>> could not be
>> + *    loaded
>> + *
>> + * fdt usage is optional:
>> + * It handles the following scenarios.
>> + *
>> + * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
>> + * defined in pxe file, retrieve fdt blob from server. Pass 
>> fdt_addr_r to
>> + * bootm, and adjust argc appropriately.
>> + *
>> + * If retrieve fails and no exact fdt blob is specified in pxe file with
>> + * "fdt" label, try Scenario 2.
>> + *
>> + * Scenario 2: If there is an fdt_addr specified, pass it along to
>> + * bootm, and adjust argc appropriately.
>> + *
>> + * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
>> + * bootm, and adjust argc appropriately, unless the image type is 
>> fitImage.
>> + *
>> + * Scenario 4: fdt blob is not available.
>>    */
>> -static int label_run_boot(struct pxe_context *ctx, struct pxe_label 
>> *label,
>> -              char *kernel_addr, char *initrd_addr_str,
>> -              char *initrd_filesize, char *initrd_str)
>> +static int label_process_fdt(struct pxe_context *ctx, struct 
>> pxe_label *label,
>> +                 char *kernel_addr, char *bootm_argv[])
>>   {
>> -    char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
>> -    char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
>> -    ulong kernel_addr_r;
>> -    int bootm_argc = 2;
>> -    int zboot_argc = 3;
>> -    void *buf;
>> -
>> -    /*
>> -     * fdt usage is optional:
>> -     * It handles the following scenarios.
>> -     *
>> -     * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" 
>> label is
>> -     * defined in pxe file, retrieve fdt blob from server. Pass 
>> fdt_addr_r to
>> -     * bootm, and adjust argc appropriately.
>> -     *
>> -     * If retrieve fails and no exact fdt blob is specified in pxe 
>> file with
>> -     * "fdt" label, try Scenario 2.
>> -     *
>> -     * Scenario 2: If there is an fdt_addr specified, pass it along to
>> -     * bootm, and adjust argc appropriately.
>> -     *
>> -     * Scenario 3: If there is an fdtcontroladdr specified, pass it 
>> along to
>> -     * bootm, and adjust argc appropriately, unless the image type is 
>> fitImage.
>> -     *
>> -     * Scenario 4: fdt blob is not available.
>> -     */
>> -    bootm_argv[3] = env_get("fdt_addr_r");
>> -
> 
> I would keep this in the label_process_fdt function as it seems awfully 
> related to fdt handling :)
> 

Ignore that, I see it is making sense with the next patch.

Cheers,
Quentin
