Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B18C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3C9849F3;
	Thu,  2 Jul 2026 19:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="WZa2WqfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B0B8469D; Thu,  2 Jul 2026 15:59:27 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d202::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF3384A0A
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+5fMSRSnCULvR9ocVXtz5iCEip1NCys5Mu/IqpAg5vflUF12AFg0U2AkzsR6C5y5gfYdp1nXURYyB9sLO/ZoIPjR7uJgl0/aybhopR6s65BlrxULsBJFCozqgCFrrDkizRwKvUYrJhyKxOcwd5GPJoNUd6Dsn55JwGLKUBptIfAv3ezqGtpJyxdmWcC4+MPGfpzpjZn1n9QNb+/Y4tDfU4W7S0X3HHEK6FUCfnEG7ukDwD/uq6y7vfaS6PuEzGPqHmi8Prn8oJp6MXs6cAnAcgq0XoYM/0S7Jbcvv2ubN9iuETUFItAVxFxSzhoPP2hIPsWrS9YrU3z1j2V1KlQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRM5L8BsklbX4Z1lBgVM7sSMTY+rLgxV29n3GoWuLEo=;
 b=THU7O0G4VVd4qkJIvzf/EKAeI/g09IX+QWFbtwznewwTmljkEWtt0w5r4wbpuMLJMCWitl2EYkZASMViz1UGusTnUvKdFObF57RRh4qBI8vD55E6AoGmjEDltS853+W+qu7LAJRoXn+/TxcEpGQ1YlzJsTG0Ja2KxK34kK1YfYtwAD9KnwLJ/6Xj/HxxO030UOj3JcVm9c81kWcVCOwfTDgP5+BdP9cseJLMVExQoeW7Z9pYE6oqa9uwjob7Beoe3lR++INFSUd6rw21wmyNGnB0DlkniLhrAToZxSOOZFpCmANangLyBc6iasE6aHf0GCIOFMk59tsxROnbQL4Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRM5L8BsklbX4Z1lBgVM7sSMTY+rLgxV29n3GoWuLEo=;
 b=WZa2WqfH58ES0VOw/NnUgEseGMlKa3uSPl8bdu6tMgQipu1CNQGM4wT4PwUDQ13OMgN+4b4bZF7mxomslN3RP5uby2x7nQxBTmyEkUl4StpdrCSJZ+zsy4wxmPD0eNsrj34lRJddLvti9QnRenWNiyGkcSJS/Qr08svkGO55ySrXox0ylenFHM82v4TlYHfaQD0b+7alFgBmIWuU38HIwBCEgJueJsL2Bn172nNpyTUEoKhypN3XsrzJ4uEHFKtV7cT6zLGZEfbQ/nEAEW3AVKL1UvuLT0hJI3N5Bh4kH8evblSFrDZnKHy0lxwCrA4rTCy1Cc2YzfGKO4mRhz4Yzw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS8P194MB2066.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:5bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 2 Jul 2026 13:59:24 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:59:24 +0000
Message-ID: <BESP194MB2805F883C01AC352DD5EC738DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 2 Jul 2026 15:59:21 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] usb: Fix timeout detection in usb_control_msg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0349.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::13) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <5f5b74b5-6cfe-4b9a-b284-8c278446651a@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS8P194MB2066:EE_
X-MS-Office365-Filtering-Correlation-Id: f57ad156-ae40-478e-5bb0-08ded8421f7e
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayHq8QFbWW6Ra03gxaeZK6u4qEkdLPq2eQJn5aGIh/+AW/OzP1Ho0DStiqbA4zNnRpS/JLBerEbWKIJmfPlKTG2SLHGBN0ujIBGy6zJz3mznG4DRt3eRRZGj3p48MZeanfFulvCVDr+aHwJ3rzC2aLODBYFWwjjpkZHMkxlYP6DquhZDLj+WDVx9L7CcR4z9fuolcuZRhMYIiWNNc3+LyyP0ZkUFaH4X84cpkRyaYKaACuM0FxIVu/2PbfVAvGZVwditrUoqDtUuXFFQdtow/a3nf6nVoxm+D5LIvf0FlN6Y5e+yU/JY7mcb6v79prClqjII7A7pe6382wqUdxf5agZvC85LPSTzJGi9JGDmi7U3xQ79REpwDm0glH+DyJHvMtBYHhl1UDn5xSAJ0AVarSnL8Qdff5cCnhxZc8GJBWaJi5L4jKOuGCWHOn2MW6UaGR+kfxk2rVYfTK56ZGZiImUHQvkcXnLo+vDCyIl2zZbVl+5nKnCwIy+RvM+DgxW8qQLp2K6d/6aDxiIpnPbXnt25J/gKCKb8dJrjEW+pKE9k1cN9uvPk4H3kBBSTiPc8WzrdgkqquikdKUKVJsLm+lEBLgwZuchY3LLRi5C+32UsE/9SOiyPFvxPSJPzdTYUVEYGFmYSFuHZ+8a18qlKvpOrmbhLZFhwp2GCGIcEQwDV8K1JFqKbWCv6jLH5wTryWIqTiX/W5n4Modf6MiSnwPsOntf0c8MR5dQ=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|23021999003|55001999006|51005399006|19110799012|8060799015|37011999003|15080799012|6090799003|24021099003|5062599005|5072599009|25010399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHMvNTM0dUErWmp0V0pKZ2FWYTJWTzlBU2RCSm9pb2lUMU9OZm1IMWsvQmZs?=
 =?utf-8?B?Nnp2Y3hzU3V4UHVoc1RvVmkzMHF1WkptTzVxbndmSVlveXYxYkt0SzRCVjJR?=
 =?utf-8?B?azlTN1IvQS9DTVBkMzd6Wm1DTXMwS3E3U2tIei9HdWxLbzlWaGJlQi9Cb2dH?=
 =?utf-8?B?SThJUTVWeldKaU1NVEU2eUFuU3N2a2o1eXJySW1rQjV2dmFJUUhmdVZGa3RX?=
 =?utf-8?B?Rms5elpvUGYzSjVyNUZZYlRENFV5ZHo3ak5UMGxuNW54N2MzWUc0STNuR0pG?=
 =?utf-8?B?QjZQVjg4cVp6d042cnk0SVNxOWFkeVpISHd4VEdEZElFMXh3OTM2NWxxREMr?=
 =?utf-8?B?c2F6enh6dWVaQ1kybjhRU1Y2S2JzbHdSVXhOY2xKcFhTZmNCNUNMSDN2OU1E?=
 =?utf-8?B?RVQ5c0lzdUg0YlRtM2gxOGtPZVdyRHdmOXpOMUhHV0dJU1ZnREpLT3F5clVV?=
 =?utf-8?B?U3pqV3NDbFNhMHNSTGdSMU5EN3ZXNktmbjIyTVFmaHFvRFZxK3pKOE84TDhu?=
 =?utf-8?B?QUpHYmV2aVdweWFUUGJUSE5oU3Irc0VXYStjVEh1U2Nua1BoS2tDdWdlamEy?=
 =?utf-8?B?S3puM2dwd09zUmNQSHJ3SmhtT3I3dXdlNFZQVXpaeU1DTnNzODFIUmQzUEtt?=
 =?utf-8?B?aXZYWXdlUFowVXJDWG0vRjdnK09nWTNpRm1jU092UW44N2FuaGZlMUdjTm1s?=
 =?utf-8?B?V3ZLZ0FmUmNuRkdlUGxYZTBvMHIySjVxUVFocHAzR3lVbjRSVk1XYnI4eWRC?=
 =?utf-8?B?Yjd3K1RhN1ducEpHQWRrcUhtOGdSOUtHMEVFd2ZIM3ZYYmF0RE1DbjIrT0Q0?=
 =?utf-8?B?am5EcG02dmhnZTVhTkNLaWRkVVB4cmx2Q0NoNkp6amQrcUhTWCt2dStFOTUw?=
 =?utf-8?B?UkhaaHgwSzh1SURuZGdubUZyd1lhVjBCTndKMzBoTG9iVUNpKzRFcEF3b21R?=
 =?utf-8?B?Zll6WnVhRWdoV1NQajlYWG1xVFg1Z3pBT3prTTludHpHYVZ4S29ZWk5JcXky?=
 =?utf-8?B?OHprL0hwUFlKOWpJSXNJcnBPTXhMOWJEdFNWS002MGdqa1B3NVdnekhpWVB6?=
 =?utf-8?B?dGhjVE5XL09WRUNIV0V6S3Zwa1M2U3IxY0I0bThNRUVETWFZUW5kdmRqQ1Y3?=
 =?utf-8?B?dTdidk0reCtGUDBpaVl6aVVQUm9qbTdXUlJUS3JadkRuRk9ESk1uWTM3b05t?=
 =?utf-8?B?MURncmNjbDJEOVBIWU1QS2EzZEZYTE8xNEhKNU5iY1hDNU1ucFE0ZzVGZlUz?=
 =?utf-8?B?d1BTVjhRam92TTVzVzZ4Q3V2SWFpTWhZUUYxaHl2RGNXZXJSM1hYb2R5NXV1?=
 =?utf-8?B?NHF6KzNGSjVDRVdMNktVVkxCTEk5OGNXN2Y4ZDgrdGQzbVhvRGhRZVRoeW1r?=
 =?utf-8?B?OXEyU0M2Wk9mUVNpMWdyYW1iSTVXZnJqUzIyc2FCOXQxd2diTlFoWVZ1QUk3?=
 =?utf-8?B?WlRIcW0xTWVHTEJOQ2pnLzUyejJtOFZwWjJPQTlBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdJNlZsNkZBTUk3TW96UVNmZGdXZG1POFFrcnlVbUY2RHMzRjlpeDRyQ2hO?=
 =?utf-8?B?MngzanBOeVBRQTlVUzRIbDFlQksrSHowU0NGb3ZZRHdnbnV5V3ZPbnpRSStq?=
 =?utf-8?B?WTEwbU9kSGVDOVVSeWxhN1pxV1lwU2FjdE4rS3ZVK2RSTUs3WXhvK3B3UDY5?=
 =?utf-8?B?Z1NJenY2eDNkaE8wQzlJK3czcjZCVXlvZmVMaXphY2s4b2wxbU5kdEV2L3Nr?=
 =?utf-8?B?U1pNb2FTdU41VlRwcmd4K1FsLzBsZk8rY28ydTd2cEw2SG1oS0djSmZIWHZ4?=
 =?utf-8?B?RGtxRW9aRkVZVCtZYW43Q2ZSY1hGellxNXB2VFozQmNiQll1TG1sSWxRQlZI?=
 =?utf-8?B?RHorVmtmYkRuclkvZUx5REVkM3pxKzVBTUdIRmZlUnVReGZERXd3YitoWXRr?=
 =?utf-8?B?YXdYVVZiT1VYdUF6Tk9TVEpBb0FJTjhsekR3SGl1SzludDRta0lBNXB6SkVw?=
 =?utf-8?B?WGdIWXRnRzQweGZSc09UKzJkTWhyOS9Ha3BDYjZZZkc2ektZVVhwQkFFZHl0?=
 =?utf-8?B?Sms1NjdNVis1cFlsRS9mdDVteEdRcnVacjhVNE1yRHVZYXIrbjhYL2FpL0c1?=
 =?utf-8?B?VUZSNGdLS0ZtbjJWTURYa3JEcGU4Q1Rya3dmTkF6djhSRm03RDhXMzBqci9K?=
 =?utf-8?B?Yy84VGhFeldjT2VsbnVzdUQwSVJvN0ZtTzdGeHJZZWk0Y3BONGdIM0NZTDI3?=
 =?utf-8?B?bWpzZnNuTXJzOUdWWG9mVTVpZml0SnkrUjNWYnFMOXB2ejhaZ3V6TmpJTkx1?=
 =?utf-8?B?SVZzUUl6WjdhTEczTi9Hbk5SMlIvalF1NHBIZFRHVkFCVUJrMmQvQm05UzFU?=
 =?utf-8?B?bERyTWlKL0p2a1BPVkQwbXdxR2hNYk9JeTlEaEhvU3ppQlVwaHpBTkRLOTNY?=
 =?utf-8?B?eVQyQVAvZ0k4Ui9SWEtMUXZUbG9hcnFINnVCTDlma2h3NTdycFRGL0NFY29S?=
 =?utf-8?B?SWMzdU9WT2szWmtjOUo4N0l1VzA5YnhFOXFBZW9ZckFTUmluZEpiNGRaZ01N?=
 =?utf-8?B?ZmdLUTNLMDZjVmluZ1RqU3I2ckQxL1VHVm55VExHM1JpMHpDTTQ5bnlwbEsx?=
 =?utf-8?B?S1o0T1ZPcm1UL2JIU1M0YTBJdHJLWEZYZzRHTTc3Y1BpcFZuc0V6bHRuWXk3?=
 =?utf-8?B?NDFFU3o5QTM5SENDWitUb0d4bklYNDRpbjNaTnFWbkZWWEJaSlNiaXRSMEtU?=
 =?utf-8?B?M3pMQjlwVzNEdngzeDNzUVRjR3NXTTJqSHV5L1ZyY2piTGxPL3Y4V0FCbEJx?=
 =?utf-8?B?M1lMbE94b1hWN2ZwZXoyUzYwemozOFNqb0Q3WVZPb2FLMmJ6cDZaeWliaTF0?=
 =?utf-8?B?eHNwNE1hNEl1QmpNNThyQTB1dFdpRFordzNIMDRWRDJ2czM3OW9FTi9uNUx2?=
 =?utf-8?B?Y0lCc1d0WnBSWitkd3NyUEZXMks5MHNCbEFuNWJOaml6Vm8wN1dWUXl2dFlF?=
 =?utf-8?B?SndQR0w2Zy8yb1VkSy9Ba1N3ZHQyNWZLa1MwUWUvZkgrZXVSRldteElDV0hC?=
 =?utf-8?B?eGlkYnVSZzRDWUh3ak9UNytkZ0V6enZ3TkNaOXZXUkZmZkcrbkZrNlQvanNo?=
 =?utf-8?B?dWc5a0JQS2wvalppV29TdDE4Uk9kZTBwaC9UYzRLMHZLNVkvb2djVmVFak80?=
 =?utf-8?B?VHBDbmJ6czlHMzlhU0c3bitzOEhjMXlTWnJocWd4dEZUWldSeE40MWw3RWtP?=
 =?utf-8?B?Slk2RlhoZUVBbUx2aTZFNWswb0Q3YkNGNDJzZHVsNzRFV3RSbHdueHVCenVh?=
 =?utf-8?B?NmxLSDV1dDhIeEJTZ0ZQaXlIbS9mR05TRXJmRW8vK0tCV2pwRFJjUDE0WU0v?=
 =?utf-8?B?SERGa1lsdkJEeStpL3VRaUZOSHFxWUV5ZlJOa3EvNWVBbkEwbHJJQ0QxMkg5?=
 =?utf-8?B?czFRa2t6M1dyL1BKVkdmTXU3bFhTdWtuNlByTjg5K3JlUzMzU1ZlUUtBWlRH?=
 =?utf-8?Q?0YdxAQK+hQipu01SLyHAESNJLhyu9VnC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f57ad156-ae40-478e-5bb0-08ded8421f7e
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:59:24.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB2066
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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

The loop exits once timeout variable reaches 0.
However, due to the post-decrement operator, timeout
is decremented and set to -1 upon exiting the loop
if a timeout occurs. This means that:
  - a break in the last loop iteration was considered
  a timeout
  - actual timeouts did not return -ETIMEDOUT

Fix comparing timeout variable to -1 instead of 0 to
detect timeouts.

Found with smatch.

Fixes: 2fc8638403c7 ("usb: Assimilate usb_get_descriptor() to linux")
Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 common/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4b..5905b2b5d7b 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -259,7 +259,7 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 		mdelay(1);
 	}
 
-	if (timeout == 0)
+	if (timeout == -1)
 		return -ETIMEDOUT;
 
 	if (dev->status)
-- 
2.43.0

