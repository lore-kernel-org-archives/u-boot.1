Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A772C48295
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A705787BF4;
	Fri,  2 Feb 2024 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QN3EkiNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F17387BE5; Fri,  2 Feb 2024 16:13:45 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E913387C13
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjAwZQrzuLH7pNdQgIj4n8Pmvl7PVFLmUYOOnYE7jabJCqnQlwh1CWqR8VlZkbCH1q1RDbkU8tfV8pUcVnhrWDUmvG2Iyh2ge7/g8wLH3hHeMKvUGroxldSLsMUx3iSIXCvWHdxEBS1Gp8e+AvfEnv2hqoTWZz3lbdegrehu+K+2L6FkfF71QdMoVgHT8ZejxXidYXyBvVwXWzw3vPMq184ksy42XDE1b2HwMjd0ZbQe9IejOoPxU1KiC40VgomRaQugzuIM7Qaail2T4/rd7DZlH4qFnsrjgOuV/473SnxP+UhDr9PpeJ/0i/NElFuRkGx2HGKUCx2WvP71U75h1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oBywYuhUiP6pQcXSvXv5i2jF0UwLCom6Ssmx952pq0=;
 b=LF2EKJZdMCy0HI7zLa/7hANnZ4Av5H531XMRaXVjSINB1A05QI4/YzJiKItdF5oQow+YNSDEIJA5Cx26o8O2yCqnpu77/oQr/3++5J4s8aZrhR28SBWy095v0uZaxyIAh2xCdwMEO27nNzlGlQwgl6I/1BTfDn2UMJCOnXxAGTDTRBJQSzgBNHzZZpCqjU+5mKg6naqvXL83LhJI3gLFOD3Yqv99fWz/wa6i5SWoQZG90a+uhZgeu/tPCHyL+hiyRtu22PD8Sbz4XbBS5Y/1N3RJypMF31qD7Fs0Kq0lQibu5jbnt/2Z6+05GPxIF9Y3UvHPo5zcr2M4H+qjZscG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oBywYuhUiP6pQcXSvXv5i2jF0UwLCom6Ssmx952pq0=;
 b=QN3EkiNgD7hUucai6npznl4LcjO7ggRNTVpEPj6J6ZCaa8HllKtG+3w+23nvJas3lYB+C+SDdwXMzzqVM2fze4XE7AACAZKjqk/sEVCk0OHbBKHrg9xfQlVk174aHcBEK0Q5g/5TNjR8OuMuu4ClFJv+33UcRr8TlVn2UccBIgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 15:13:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:13:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 16:13:34 +0100
Subject: [PATCH v2 3/3] board: helios-4: add config fragment for spi
 booting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-helios4-spi-v2-3-df085461d894@solid-run.com>
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
In-Reply-To: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3c5a2d-5804-4686-f9b6-08dc240189b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKuPwEyWD3MpCMjbrBFn8Cgp6NXW4a+TlLT5MQYIe/f/8S8cewy+llDW1J1T9mt8hdys+H8rRKH4JYtpJPSyTcVM6Mu2OHSugv5GoV/dUlADTnjhfz8LUQYH68sM3SAQRZCO7aSq02zD2pxgmr8rSy8HN6Ii0a0Fk1iT47Ua42f3HARJ3prLMljCUZHhA0aA4k7MxpRA1X5S8we0CNKnxFJv8YfYRNQF/pwUENsOZG7mPLCXZC46YXuSgJG9YN2p8V+MGqOmEj6z1cZPlxG6EJSvvIHsfytFJwu2XPsYo//fyWYGsEqg15Kint3SRRmlH5TAGyuMhERRHkPDFRs7Ax4UJ6jsE3ZSnHDHTXOUVxBz64zAFtaiemd233XN6Fv9TopB1T0WojxBPjmYP8SSo4mrm5Kskx1YNS2FUgVU2bTLXAd28bxq8NrjyeIz0JacwwdwZ8hAbwWQYaj+E1vNNLWxfot9hCRcikcQ98UbE8rv+HFo7YacrL1WJ+1mMxhXF4SaKOuwSph0YEsKZDl1lLpX1puhsuj/VE7YNkVKj5L9qDGlJPRm2qtHzCOp/HSIId/Q4BebYpaTKUGzhNj4MobSvES4IPwGEtjL01VC0kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(54906003)(110136005)(38100700002)(26005)(107886003)(41300700001)(6506007)(6666004)(2616005)(6512007)(52116002)(5660300002)(2906002)(8676002)(4326008)(8936002)(4744005)(316002)(66556008)(478600001)(6486002)(966005)(86362001)(66476007)(36756003)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dlSFNTbHdQZXoyR2pNVmYyeEE3UlZyblVoQUtSZ2pZbzlramhlNGhJelNj?=
 =?utf-8?B?RGp3SS9sQUJvV0VuMnBnWkJtTGxEd2R6dEM4REduM01WT2tTT1V1ZjdTUVlO?=
 =?utf-8?B?Q3BFcEJ1T3I4cStJNGZNdWhFNzZvaUQ3RjdNV0Rrcjl4L0hKL3J4emgzZlcx?=
 =?utf-8?B?RHo2M2tTTmZqOHhKNy9iOGlZcUZmMmhjRHFzTko2THdmb1kyTFRhSWh6YjJ0?=
 =?utf-8?B?Z0hGR0FNeEs5U3Q1Wk9FQU15L1Jrd2hCd1ZLdGZYeXZNMkZlUVl6QlhhdTJs?=
 =?utf-8?B?Z3FYYlpSYzVFZjZDb3lMYWlKN1Q5OGFuSllvbmZhTEFWSmhadUg5U2VmWVhp?=
 =?utf-8?B?V01JSFdpc2U0TVBDRlFIWWUwM1BiUFB2OEF5TCtVOHRkNmFMbUovZHQ5K0tJ?=
 =?utf-8?B?VlpJSkJyMzU5VHFZSUN3WmFRd3FJMlBXMzZ6WmU3bGw4TnpXdkFDd2Z1TmU4?=
 =?utf-8?B?aFgyN092YVhhMzBUR1RNcm5STGdaclgvVHVnMm9CQitQUnpRN2QzLzR1VzdE?=
 =?utf-8?B?a0s3aGJPaHpjckxQb2VLUmFBK1N6YktmSTA0VkVWNkNEbmVJTjBpYWcxTDdK?=
 =?utf-8?B?Slg4dFdWOWZ2S3UxT2NhTjhPVk00N0g2Y3BVejhHSFIzcS9kUlQrRWlheXJL?=
 =?utf-8?B?ZSt4VnA5dkdxQ0NlU1VlK0JxTkFLNzQzNjNhUVpNSjQ3elMvejkra3lCWDlW?=
 =?utf-8?B?eFFpZ1ZnZmRrQkhvd1hIbHhUYmRTd2xGeVRpYkxyWnozc1NleEFqQUorRDAx?=
 =?utf-8?B?L2N5NWxpbllRN0ZUcWRKQnFkL2hkeE0ydlpka2U3RUc3b2J5SmFyWFZRVXZH?=
 =?utf-8?B?S0N2N2RMcjhlSXR6ZUozMEpTMnRrdktEeTk2dmFSWTdLREQvZHlwTDZJVmhC?=
 =?utf-8?B?dUIzOGI0dklnUGQwMzI4Z0IxY2dKdW9CejNYNktHTzlBT1BVODlFN3I5UmF2?=
 =?utf-8?B?alIzLzdhd2RjVE9QaW53ZExORkcvTDlXUzZzN2hZT3Uzd3hHdHhSVlhQZ0tx?=
 =?utf-8?B?a1JsYkU0elBYSmcraGt3aG9qL2ZHWU0xang2R0JEalRHdFo0UURqZWU2ZkQ4?=
 =?utf-8?B?RVBTbEk3aldvNHEzRDJWN2poSGhyN3hUbnh3T2xYU2tVN2JVUmFvUy9YSzlV?=
 =?utf-8?B?SVYxdG54eG9KL1FhVVlLWWhjT0RWTk9uQ0U3OU16WWtLU3NOUVlFTDN4dG9o?=
 =?utf-8?B?UG5sd3Raeno0NmhHUzJlQ3ZUUVVneU5YTHNVNDRBTHVCcDE3a0xNTnNBQ0c0?=
 =?utf-8?B?dFZlZnI0TUtVemtIcmtocjhtMUdjVWgyVWlRYTFJVzVINFZpYTNtQUlzQUJK?=
 =?utf-8?B?T2pNMVVNU083dVJWTUIxK1dWZnJvb2g4bWRadkQvWFVoWXFTQS8weUxKdTM2?=
 =?utf-8?B?MjZlYmRnNXJtN0dkTmFPNHVYWUMvdzFhVlU4ZlIyTjRtMGdCaEx4VjZFbDFl?=
 =?utf-8?B?WEJCS1lwZk4wRmVKaE92TWI2OC95Nkd0bThRU2tENytvTWtBNlBCVUtjQVpl?=
 =?utf-8?B?YXRmbTlON3ByYkFWTmsxUmpBdHJXZkg2OHlBM1AwK1hIdnRkbGY2bzduZEsv?=
 =?utf-8?B?L1k1WDcrVjUwU2RJdFZRQkwrWTQ2cEI3NnlmM0dWTVU3UWdCenNFQXI3dHlZ?=
 =?utf-8?B?UDFhWFMvWnI2dWI0RUNycXdBS21HcFltclQ3QXdkZnBnS3lJWlkrTU1PaTJ0?=
 =?utf-8?B?dW0vOCt0cldGRFRocm5Gdk5sQ2FRbDNlcytWNHNzK1k1UnpxQTJUR29CTW1Y?=
 =?utf-8?B?dUNwZXB4TjhIaGJHYjZRakNXNmZ2YjFqY0dWM2dobFljNXVFTC9xUTVVYk81?=
 =?utf-8?B?QTVla2M1WkhpNGFRYkJ0NFNBUGZoeE1MaWlnc2JRc2tPZCtkTUJCckNtMTh5?=
 =?utf-8?B?NUdoZ0VxODdlWEVjMVExcFhONlNHeHBrMVlmNmxqTFlzVjZZbllqNmUwSk9a?=
 =?utf-8?B?bXNsVm9Da204amZuT3kyZXFvZFVRR1l3cFZVcGVvRjRPTnBUYi9DaDlIZ21q?=
 =?utf-8?B?MDRxVnRSbzJ4TlFLMEdKVGlzV0lySlRlNE5BRVZaT2NqMDJudWVJNC8ya3pO?=
 =?utf-8?B?dHBjeS9xOFZBc0l4ZHpITkZKZ0JXemM4TXpmRGZFRmVubC85VXRBaUs3WFV1?=
 =?utf-8?Q?8ICQjcsNpmk2dmfHRdS+nCl6o?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3c5a2d-5804-4686-f9b6-08dc240189b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:13:40.5357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWfiolStz3UpSZXLE+qQXHay7BOrS+fARwuFeCshSjsa35IcpiBzdWraEHlC/KN+JBCLzE331fsYQzWqWvgFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
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

Add a config fragment with required differences for booting from spi
flash instead of sd-card (default).

Settings for environment location are based on vendor u-boot:
https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h#L59

The fragment can be applied on top of helios4_defconfig by make:
make helios4_defconfig spiboot.config

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/kobol/helios4/spiboot.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/kobol/helios4/spiboot.config b/board/kobol/helios4/spiboot.config
new file mode 100644
index 0000000000..5ffb7d2e3b
--- /dev/null
+++ b/board/kobol/helios4/spiboot.config
@@ -0,0 +1,4 @@
+CONFIG_MVEBU_SPL_BOOT_DEVICE_SPI=y
+# CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC is not set
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x10000

-- 
2.35.3

