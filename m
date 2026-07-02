Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29454C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A2B849C8;
	Thu,  2 Jul 2026 19:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="peZ3bkc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF5C84A06; Thu,  2 Jul 2026 15:56:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE938469D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4pEPhhrbWOlMT/ltXSDOO16M5xjzxwA+JcLW9B/TnVCPMBg2WX/5VVOWhhxfECbLo3WxH6U23CvcAWinMsK5Fqx3ORyTWTOxWzPig8EMhV/AjQSXsmT4bupaoXkNUCebecNqtUFyZY7c0XEUKz3zCThLa+kDXbzvx0tKy2WPsGJL6msZLnAys4G2KcHveWmXJehaHaTyRbYrZY8HI1uJUEmQAtaO7UZqknvq3kyoY6x/57ShGX4zP1D/5wVhUqpej9l+8P15PA236LO74OWZ1Si/trFw+Vi2SEnaId+7cF2TUB3oKZ1nRRjWP5u9CWBxFdTn9wxRfboZI4d7EjG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKmOanpRYT+zWGN3rVWEAyZuUKSS8l7OuHMSIn2sKGM=;
 b=Emwo5fta6Vth5AUrpbgBITZeQ2lY7uj7wYuay38uRN1fM9TDh3boTMTFc/kLvWOIxehD/+iRBorMaJSdiDX2kbV4L9AO+wiHe4vbdeVDK8d6CfwtxBuDekdmtC4saaICoq+AJrZpvcFvzG8IsiXOHqabTRduE3eBD2j/kNO9IqzYvBuAVao37d4LkF/PHBF0e1NRK/QSnI+yBcRvffEK9qjl2ZZATUn66Y1yJ45EtrURF4F5maajvDgd8sv80dvupnyg+LD9FDvn7HfiB+hQlIk+nd/4zQBb73ccaSLn+YfQFETB0FWkM6sxz3kx6qvHVuQeMJ/AAy9/219ijzyVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKmOanpRYT+zWGN3rVWEAyZuUKSS8l7OuHMSIn2sKGM=;
 b=peZ3bkc8VnFFoXNjBly9uIM0DL9bn7eWYr4H4PzzfxSXxdmnwngYrx5j7hRnLFVNysQpDh1eSu365xq8Dp7UZR36XmIfbSP+HsIiS2dMdf9vbDh1PEhAkxTgZyGx3u0CglcqrEPEnMe4BADRIcuR3niL5DuzT1F0akOOXPOpce3CMd8zJ0Lu4nWcbLXG16sYA7qUp86qgGyiCywQ0eF3tcOic2kCXga20wQGQm3Vo3dJhHkz0GdgndgkhKnOqOzONr8MNYJiEo6wDwDtGrwW7n7cGARf7BkNVyiJol0GwPrSkqMgaizLIlI2T+ARdsw2OPGAQ+m7X9Jzi+19GX9l9g==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB2210.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:1af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 13:55:57 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:55:57 +0000
Message-ID: <BESP194MB28052A7F70CC52F63334A70ADAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 2 Jul 2026 15:55:53 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] xilinx: zynqmp: Fix snprintf invalid size argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::25) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <9acc3bc7-f4d9-483c-bb5a-3910a32252fe@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB2210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e16595b-bb1b-4e0c-dd18-08ded841a458
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRII2vDmyySRIH4gSSwzmUEw8+PSOnnSWzm7fYXP7iuTtt3LpisSp2a5gaz+loijlWa5YK0AL7Ei5njT6RSCXwTgkesoBA+L6EBLB70TPV66Qkjz/7xSzpBWmBNXPBJLCe5cosawKUe3jF1E/ChSRkN//WzXJojUIEIawZfqmW2p5XvKUh8enpI2clde3G5+dwh/92nk+XanCQ+sC1E74B110D1+lbbRkAddYJnUGVF1oodCWsNA5j0IIoLpxBAe9Jc2heKsDp9bb5FL+LISJq0BwCaj+m6RioMhIWlhHCUhrLn0KqJXQ4fU/5P6OOIr+mspS1fkRlO24BxRSnJEJXP/Gv7/4cbDSBuSsUiUAh1SxsnOuzMqwPH8fLt86JwTVFBwh1vJdnHxf7BjpIjUH1/0FhUknFcI2o/DHV2FH5JDZCeejlUt0dVrScHhCHKsJVBahh56UB/WAdFBcVoV5xbLaHCu9bYlbVNN2YQAf1OGCEYb4lE6Cr8t/KgBfVV7DUfRIX6ep2j/Dgg8W0VFvuzTU/OPuYFb9dM6J0d9w0IMEVIrDZC3iLtNz8n7xLMJNUynE/PxmFwV1H5JjaeNgiGrDRUde7Ap7CuV2i8dtXYEgtQrRGrCJHN2YFGMXYONLdRqoppQJM4kKFaKfn6DxGc5x1kYqmBowFR1PUVpkmy74JgsR6WzKlsiujTDE0QmRmbP8LNOI4TlVulibZOJtVRv68+H7UaZ1Qb2jII+aQBSs=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|6090799003|51005399006|55001999006|24021099003|5062599005|37011999003|23021999003|15080799012|5072599009|25010399006|40105399003|30101999006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRrUEYrRnlSSEFvMVFuRFJES3l3ODBwclhvYmtTaDlOY21jQmlPRktHR1pn?=
 =?utf-8?B?bFJ5eldYelVnYVUwR1NjNThmVU1wQUFqVk5pWVc4dGhJQVZxTDAzMGZZTWJi?=
 =?utf-8?B?blRHU3NlU1VJa2ZhcTZ6WGJtV2ZKa3oxV004Y2hyc204RFExeGVhZmVHbkNs?=
 =?utf-8?B?UTJDcE5xRFBqQTFZcjg3aDZ5UVBuMG04aTdxQUxpSUdtWGZtRytwZGRIWFl5?=
 =?utf-8?B?MjQ4Mk9FaFhkUmxTQ3VUVGplanZmNi9XY0U3cVdJR0hvc3BVVUV4R1VjTXRR?=
 =?utf-8?B?czdJREpGZUN2SDZKOWwrZE9QUVBSZjlEelMxelZER0Via1pSVU0zSFdWTGx4?=
 =?utf-8?B?aW9HczlYSnM1aW9IYTZsV0N5WUxsNUxZZTRtNURRbG9iTHJnRXF1T0tSV1dP?=
 =?utf-8?B?SmdtdXY3TlJOMEQ5eXZXYnZCSFVPbkVLVjQ2TGpmWStNallGRWVPMC9SRDVR?=
 =?utf-8?B?NzZaUFlFQUZZbHRQMFRnbWhsU0VXbXJENkhEM2V1S00wTmRpRGMvdk5haFpk?=
 =?utf-8?B?Zm8rNC9xeXpBRVk4djNTa3ZoTkFEL3RQZldCSndWMWd0dHlYWDZqV3lZdE9K?=
 =?utf-8?B?SWpLSUxFRTlKYmZTa0ZOZUxhM01sbE9HcDlNYkpZYTVpQ3Z4MlovV3pMQVlh?=
 =?utf-8?B?cm1oUXFjWjVmSHpJbWJ5aEFIQUxUeVRITjBEQThld1FieWdLcWtDZVJDVzRo?=
 =?utf-8?B?UmxmMUdzN0gxYXNkcFdSSFNKYjRVaXFVd21PSmh4R01oNE1hYytERmJxbzA2?=
 =?utf-8?B?YTVEaW96QTFnTWJQaHh4ZTA5dGVVTnl5dHdob0NOUUowZDB6dlJxV01pcTBV?=
 =?utf-8?B?UWpFd0hPWXFBd0dHM29HSmxDMWpLRE5TY1ZEL3FQUXR2OUppSVpDNFp1bGxK?=
 =?utf-8?B?UDdEeDNhY25kd2t5ek5oT0NTbFNTbnJsOTFlSnByTSszRndxRDRwWDVlRmtR?=
 =?utf-8?B?c201NTRqUjdFTmZtUi9CSGlrSkNQNmkvMXVIQ2dZRkRiR1ZKUks0NkVsL0lG?=
 =?utf-8?B?ck04MmtWVkxBM050SWNEcmtZWnA5NGJhYXNac3hLN0FQWmx6WG9PdmpUQkxu?=
 =?utf-8?B?MzhqSDUwUjZYRnU0Q094bXVZN1pselRlNFFzOStRanliNm5YcGo5bGQ1NG95?=
 =?utf-8?B?T3FLOUVIaFpRSWRvZ0E0U2Q2NitYMUExWWlka2RDSFUvSUFpNUMyWWdOSVJp?=
 =?utf-8?B?aGxpYzNIaUg4bzZaMlJXcGhNOWtEQTZsc2JKdFh5YUl5WTlyR291RldqWEFS?=
 =?utf-8?B?SlU1UXNkZzBCQndVaktzN0V5YldIRFBmZUJPYjZVRmNhV0x6bjlSR3dIRHZ2?=
 =?utf-8?B?V3cwTENTWVZCWWpKZnB1YU9nRDlRTTBEWnZrMCt1TS9aK0VLOHpmQkQxaTBm?=
 =?utf-8?B?eUhFdFhrWWQ2V29JSWFjSVRyMEprdTNGUlJKZ2lKQzFSa0lUMzdJbTMvOGZY?=
 =?utf-8?B?dVI3MG10TFp4VVMwckNEQU9POUhwdzVjNDBMMzBRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25TWkN0QlAvVFRmWWRYa0FPdklqSTJrT1ZpbngvVVFtYk51amd3SU5sdEd3?=
 =?utf-8?B?OUNyYWw1KzE3RWZuV3B0OEJMNXBVa2t0bUV3VWg3WE9ETXFOWnpEQTlvYWRB?=
 =?utf-8?B?TzhXZHRVamVZd0xpQ0swWHFyVkIzMklQZ2RuWnpLenpTL0ZtRjA0b0t6VnlT?=
 =?utf-8?B?MCt0MXJ6KzdUWnRDdGNVUVJPUlhoRjM0ZTF4V05xK3VqcWhFVTdoS3dGVWUz?=
 =?utf-8?B?enBnaDlISHdtWTRnV01LZU92K3JFZ3loWEpnelpEc0NLUVBhTGZTa3ExZHNo?=
 =?utf-8?B?RzJuRVBkbzBPY1BqZS9qeVFqQmRuY01OMXBlM0ladi83dkN5QVN1T3JUd2RM?=
 =?utf-8?B?RUdnQlFTanFzemNCVW9IZVBEMm5HdzRlaXJ5Tmo3QW1WaU5aeTlMV2FwVzdj?=
 =?utf-8?B?WXpHUnBQREZNc3h6NG55ZnZiMHZ2Z1RBUi8wbVByZFFTeTNMUXFTOWxoM0t3?=
 =?utf-8?B?bFlVQWpzRUxja2pBdzM2UTlxUFpIN3BlODl5Nlc4OUNGUFJOclNsV3RXTUp4?=
 =?utf-8?B?eFhQNlVNOGx1dnR1am81TFpQdFBDbzE1L3ZibGtDYTdtZnVUN3JaSXJqUEtM?=
 =?utf-8?B?K3d6VUkwRXR0MUJOM21MVW5HNkVnQ0RYMVFqOGVhWWxrZ3llQUZ2K2k2MDA5?=
 =?utf-8?B?SHhOL2JyazdNSFNzdlo1cXFoV0ZtOWM3WEltbVBIeFNGazc1TDV0Y3BPK1l0?=
 =?utf-8?B?QlZDMGZId1RUZU1rVzkyTjJidnc4UkFKaHA5UmlSK29jejdZbk5HdjJMemFS?=
 =?utf-8?B?ZWViUFhVbXJvTEJVcEpzY1J6MHBmT0tOQ3ZPMWI0NHJQUDlEMkNuamt6cExl?=
 =?utf-8?B?emtVcWRuSjY0Z3NSS1d0NFpRL3BlZG9QR1pVMEg2N0VGUUN5YjJ5bGlmK2Ey?=
 =?utf-8?B?SUE1RldFSDd0UFMrR1RJczB1SXYrU0ROd0Mzam1BaEFuQWE1eHcwVXhWQ1U4?=
 =?utf-8?B?VnRQWmhCSXZJelBvTVpuaXkvamhuK09XWTNEaDZ5VWZjaXAyV3pOdGVxdUg2?=
 =?utf-8?B?M0FpeUx4OXFvWkZWeElZUFduOGhsNURXbGIxSFUwcW13OUhHOHdVTHdzdG13?=
 =?utf-8?B?c2o3azc4TUZjSHlXd3BiRlN1YXlpbGVEYWgyd3FhR1ZGWW1ZRGs3RHl3bmt6?=
 =?utf-8?B?bXdvcStmcjdTWkZhNFB4ZTFJQ3FZTUZINmYwdUw0Z2ZvYTdvWW1nbEZvOXo4?=
 =?utf-8?B?d21iSVdCVFN6MXVWWmFRK0tBU0hMdG5BZzZhUGNKaTRONzdCLzZjRkQzRlNw?=
 =?utf-8?B?WisyeElmTktGc0xJbHlVbklnYTJBdWtOKzBqaWk1Sko3YVJmZitscXlWa0hl?=
 =?utf-8?B?Q2xZZEZOZnQ1aStqMVZZbkdZZXVFTG9XaG14bW1WOS9xZG1pUzdhVStXT0Zt?=
 =?utf-8?B?eXZxSTcrb1JSYkYvaysrbDhvMEducjhrQ2hwcEE2c01td0hjZlFhb09pSTVh?=
 =?utf-8?B?MVhVVHF3L2N0a2lWcFMxdmZRaDQwRURHNExPbytJMTJ4S2MxU1VJOHpRbFBh?=
 =?utf-8?B?eTZIeXVwQmNTTkppZXJxc3ZoU1NDVU80Y2JsYjlqd3VUdHNVMWhWSE1uWWlU?=
 =?utf-8?B?Q3lZWEQ1dmN6UDNrWGNMdmM1UWlLUEMxNjdJaVZva21zYlpMeDl0S3lCWGdu?=
 =?utf-8?B?QiszRzRPR1UyQVF0c3d3K0dVd0lrbmF1S010MXN5eXF5czJsRDI4V0ZWMnVr?=
 =?utf-8?B?U2xMcmNRNzYyQ1RwSkY1bVBFN09WTjVva1NMOVRPT2oxWENYVHdGdlVIdjh6?=
 =?utf-8?B?OUZZTjJTdUpWcDdMM0h0aVdhTWxlcEtWUStoa2VVbzZIN2p4RVRQU0ZwYnIy?=
 =?utf-8?B?U1dZMklyOEhsbVAxWnNXSk5ycUMzRkY1Z3RPcGQ1WitWTEVXRmIyNDBleWtY?=
 =?utf-8?B?c2lzMURnUXdPV1NDY0NPTllsYXQ0aGc4YXBwNUpNcXJicDdnYVVlbTM4aUs3?=
 =?utf-8?Q?pYi88QJtFQ7zRyJkLvu7yKGkENs/3iy6?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16595b-bb1b-4e0c-dd18-08ded841a458
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:55:57.6495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB2210
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

buf is an array of size DFU_ALT_BUF_LEN bytes.
It is gradually filled with data using snprintf but the
size argument to snprintf is kept at DFU_ALT_BUF_LEN,
making it possible to overflow the buffer.
Fix this bug using the correct buffer size:
DFU_ALT_BUF_LEN - len.
Also, replace snprintf by scnprintf, otherwise len
variable is incremented incorrectly. It is now
incremented by the actual character count written
in buf.

v2: Replace snprintf by scnprintf

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/xilinx/zynqmp/zynqmp.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index a1d8ae26673..9a2f53003bb 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -706,21 +706,21 @@ void configure_capsule_updates(void)
 	case SD_MODE1:
 		bootseq = mmc_get_env_dev();
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
-			       bootseq);
+		len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
+				 bootseq);
 
 		if (multiboot)
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-				       "%04d", multiboot);
+			len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					 "%04d", multiboot);
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
-			       bootseq);
+		len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len, ".bin fat %d 1",
+				 bootseq);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-					";%s fat %d 1",
-					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-					bootseq);
+			len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					 ";%s fat %d 1",
+					 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+					 bootseq);
 #endif
 		break;
 	case QSPI_MODE_24BIT:
@@ -737,15 +737,15 @@ void configure_capsule_updates(void)
 			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
 #endif
 
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-					"sf 0:0=boot.bin raw 0x%x 0x%x",
-					base, limit);
+			len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					 "sf 0:0=boot.bin raw 0x%x 0x%x",
+					 base, limit);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
 			if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
-				len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-						";%s raw 0x%x 0x%x",
-						CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-						base + limit, size - limit);
+				len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+						 ";%s raw 0x%x 0x%x",
+						 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+						 base + limit, size - limit);
 #endif
 		}
 		break;
-- 
2.43.0
