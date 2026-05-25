Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9988ACD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 21:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD12984881;
	Mon, 25 May 2026 23:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="LJmlMH7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9498489C; Mon, 25 May 2026 22:33:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A83E846F2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 22:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeRavi7MDrTDoLNmaPDF/AHu/dUGnwNsPMo67ORxYTXMqNlXZrvhi+MqAx2pdcSGjJrQIU+g+thSxho9VXT7ge/RWVDr8H5bOf6DqiFcmnRZnxV/NRjc1bjOALWjyDpc8LaUOsZ2UQg4FzF3we/nxSi8ughvQGgfaR15sfupCJ0yzZySSjRV/UHz8hX5nkCoCJ/R3k5nIDPXaKrrw6SuH/zjglhvA6d7wgQlt5zhTKoPAOF4pqrN6HwsHwMbLVbKvb2JlLkGGl+hm3APs63PKIF9hT7rJheOL8MhanUhDVaDN1WRmwxkHRIoOMJV6wJftaL8gHFvwS5wMPQBp1/C/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hMXJSbeD7cdsSL7RkGoStWJUpAiCAn7Kg8mL5VFv9A=;
 b=mUR7E2/oTwGRVXvuVuU2JFTZKGSMya0EM2fFW1J0MvYtEQOYSvo/Fvqoe/JU3JjsG4BpHzQOg+UBY0Y9mjVqtLGfJaSdjQ9LhwWm3uiHOjSC9CHj2j9fCsiU3o25pt8vIihzj/N99sEd7+Sl7O4HDsEMH8cbatA9qan/S5eAOmxcI5gQ+lP6wYDs+DWsbqK2Y09fLpXACLsskBTXhfIu3Ul0JBb2e6GiCqxvwP3c8hls144F2Ozucc9Y1+kF1go+kkA4RFYCWWsnk4vUIzzS1u9ZKbj8XToQeBm4xVrJrhs3SFveykQPkjY/cApe1HXkbKGtDYiy1Iex+AXIKl6M8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hMXJSbeD7cdsSL7RkGoStWJUpAiCAn7Kg8mL5VFv9A=;
 b=LJmlMH7yRkWZzG10IDaDAFIB//16OxwO77jYUWV3OX5tHDQWtt8P250KlhonAI/e13SWNSYM50DD1zJcHMR62sUdzX04ZnsiIXm7dFXAcA4z906B5QaacE3PZx3Alq5LBu5yFoyEKzSkTuiWWTlD+mAE/tZ9Vx1wLZm7v9VIg6c7t7is2N9uIDJl3NfaXTYzCZvfQKX59qWS3I2bPN92ZHdLcXs18pX1c5swY7OV7engRW0EIVhccZRJ1EFsN1AkEpMwbSSO+zrkrG4+vSqQB/BA4ZTsBN0mkuTnozNbLBvkhYAqtL/ivfuENtz2Jkcqfbs1gyJxMDpR2gOgFtGb7Q==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DU0P194MB2052.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:47b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Mon, 25 May 2026 20:33:18 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 20:33:18 +0000
Message-ID: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 25 May 2026 22:33:14 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::16) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <a47612e6-d662-49fe-9ee4-bd86e737f6a9@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DU0P194MB2052:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c47679-60e5-4a80-023c-08deba9cdaa6
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpOzn+FyY7u0ciAUhyJrQwV44SGBc1c4csdYKTXFA8LhWj5nS2oFPOrQFTsg9wWwYXeMp7XIhSd40nA6x3A3OgBkeqoepNvsGnShmm7FBUZVzDSASdBCCNE9PoFlf83QlwZqDbIt50cxpg4YISMOBLvPoL5jpBV1jFFe0z4jf9KJ1okd7P6mVGLrcDm4FFQwezLQ2umCCutJrfQKVA7AqLlKEl8brDJj6iLI5j3aKBNTX5VTcvCbJY75nBZM9mdIc0l2Z+vtLcSDdO/BSOeTIuoZumlRj5zW1hdQIdWeUTLlKw3j5W81oCFwD51b6B9eHJCOMuQItdISMa4feDAigGH37ir691BeTxHp8BG7MBJchsCI5z3czm6ih+LCyOQyj3oIi/kbQACHCBYv5Rkj3lJ5K81st5Gf2qUI54O+9OF5UrtTi0zUivGtLmZ5W3FSFh1k/973EFJi85D+2W6iKneVokJPXtgIO5nAXKiZEdK4wGIOhOS4AfBEAbvoX7klm86s+dZtQ5MalQucsdWCsvMFzHJe8kxGGbLJkK8krF2KOwNbe6ZbC65QTnSZ3CoNRMjh4a/EX/t7te1heHsOggqTWVXs0AZIPdLFSCoMI+2ESaET90iRkRitkg4z0IQ+jPUMP6LWbfgS+dQxhuIDNG89FXerRfMbuj+hp40qAneO/C9o/2diJnSIa8QhTnsNtqhRivedWjP/3+4uRTRyx7Vi66IZsMPUEb0MmYHY86wqLC17PGPn1Rmn7p6ejXDvDQ=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|41001999006|15080799012|19110799012|8060799015|23021999003|6090799003|24021099003|37011999003|5072599009|55001999006|3412199025|440099028|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2tmWnhNM2xYY0YwTStoN24xdUVwZm1SUEhRRmRFcVdJMHhJZC9QWG1tbFBz?=
 =?utf-8?B?c01lWGFDcndoYlZKTVE5Tm11ZjFWSjAvek1sRjUwVmI2VHJvMXg3KzlnL2dm?=
 =?utf-8?B?c3dvNTRDc09kZE44akFXZGNLdVFwMGpDdnlIdlZlYXBQbWVnNmFUK21MeDdu?=
 =?utf-8?B?NWZ2M1RKWWlxYllrMnNmdlhUL01OMWVCWHFvNHdxcG5wN1c5V0J3R3MyRGFz?=
 =?utf-8?B?SVpJYUNnMENzYVlNZ3cyVktXVXI5ZHU1VUxRWmFsY3dVYW5sQm0vYk5HVThj?=
 =?utf-8?B?MmNyQWE1aVYvbExEQWJacGIzMUpYVnRjay9JbTl6eWk3R0FlbTJraFBDZkVZ?=
 =?utf-8?B?VUJYeUhHWWpiZ2w5WE5XM2I1eCtjLzZXQ0xuYXhQRXBvdCtyNFJrSUltMmo5?=
 =?utf-8?B?R1hTNVlFdGg1bzBta1k0b3V3b0FsRy9VZXZkRyt3b0E5TFV5SFV1RGpGNHhJ?=
 =?utf-8?B?dWdwVUJPdlhwMEorM2FQYU5GakN2UE92VWdQSXltU3ZkL1BMQndpa3ByUk9O?=
 =?utf-8?B?NnRyZ3hXUHZ0U3lHeEVvSm5Sa0pUOFNZSWhQbkJFL2hHck1DNlJZemlFazly?=
 =?utf-8?B?MVQzUVZqVkNKNFlxNjhneFJrUHYwaUZJSU4xTXBLcSt6Q1BwdTVjbDg4Vzky?=
 =?utf-8?B?TWh5OXdjN0ZYZlY1QXlHYURoOGJreFR6UStzUC93THlNZnptNjNMS25uQ1hR?=
 =?utf-8?B?cXE5Myt3UTNYRGs1ZVJhc0c2ZTBMNmpDR24wQ3JnakFZWnJQMjBSVTZNc3hN?=
 =?utf-8?B?VTdyK0c4MXZRL0xPMTRaZGdISW8yRXhZTlNwYjRCL3FQbXMzb3pObW1WcERr?=
 =?utf-8?B?dzFOb1Bjc2lUS3ZycHZFdVBoankwQjljUE1ETUpBaGpoVmR6VTk4c1QwRDF2?=
 =?utf-8?B?WS81WTRjVkZ1TTZzZTMvZEtHRHZMVWN0YVVhSmptRXV1N2cyUEtiWVdqZmsr?=
 =?utf-8?B?dExGd1lTWCtwd3YxU2QwanM5OHMzVXBOM1RIanBPb0ZoYjd2a3dlSk9tajNx?=
 =?utf-8?B?VUliSXRhdkt4Tk1yc0hiSDgxRWcvdFlTU1pwY3BCcWJjakU1eW5QQ08rYXAy?=
 =?utf-8?B?ZFFwVG9SRE51T2JTYWxkdTV2NzdOUG5NSkw1Q1daZXJhM2lRcWVBQ2tLeUo5?=
 =?utf-8?B?YVFjbTR1NnNySWpmNFVDY2NSZXpPMHdaa29Tb3ozTmR3RFppS25tdXZKWUxJ?=
 =?utf-8?B?WXN2ajM3bFJxZ1ZMY1RoalpHWWs1dy9uaWFMVVVsS0YwMzRJNmlXR3Y1NmFl?=
 =?utf-8?B?V1ZEdnExeFBsNE1OdVpEWU5Db3RZUitCTDBHc3lieGw1bktEdi9Vc2JCYzls?=
 =?utf-8?B?NDZHQjNKenpSVVB2eW9tV1ZIMENDRGJrekV4Z0wzRi92dU5RSEQycWx0ZHRi?=
 =?utf-8?B?MEE2MVBhNU9ERVB0bEVJeEhlbzByYVFSeDVTb0pmeEZPbDFWc3hkeUdqc3lK?=
 =?utf-8?B?WXdDRFN2b2lESG5NMU8vMlRpSXBSTit1K3FiMUJBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNOQUFsUFJhZFVyMFVSWDhlcU15cXdieWh2SCticGhiNGxnQzVmWHpXMkI5?=
 =?utf-8?B?M2hqK0JuUnJGaElhOEhudkR4c1V4MktEaEIzcEQzSmU3SUNwclJkNmRhMVEy?=
 =?utf-8?B?M25VNDlzSGtGaWRXdmwxMXN2Wkd5TDViRUtsenlWU2NTcHI1OEltYzNMSWVQ?=
 =?utf-8?B?R0oxaHJUMFNUQld4MFViWVUvOXFzMkdvZXcySzJWK3NOWE9HaWZZS25tY21R?=
 =?utf-8?B?S2t0QzdRZXpBbnB3czdqRC82eThhUUYvREh1VGNTL05KM0pNTUlSeUpJbXpw?=
 =?utf-8?B?dnlNTjNQdFpvUGhLQW84RU9UWEhtSHQraTBGekZNL3JKTEkxQUNydjByRGla?=
 =?utf-8?B?MkZRNFlxZFVVMGtUSUhGN2NkV3JUSisyTDNGWWVhaXZxV3dLVUhyRHliMDJC?=
 =?utf-8?B?YUFvMVJCUElUZzlheWY3UXNUb0UrWXl6VDJEU0hzSFE4eGRLZFhkUzF2aGRv?=
 =?utf-8?B?eWVPVERNM2FXSS9yY1JQdnk2cURaU2x4cTM0ZXRvS1ZGb1BNOThzYkxwYnA3?=
 =?utf-8?B?aGpENjFFUFBjM0phTlMrSDJ5NmVBTFJEcEJUV3RmYkVMYjRHQ1F3V2hlaGdV?=
 =?utf-8?B?MHc5b0g1TlRtOWpKVkJrWXdrRjUvcW9QY242ZVVFL2ZaeHFuRzVZK2JWQ2FD?=
 =?utf-8?B?SW5mMVY3WktvTmFFcjlDK1VIanRkSFBiZzdqZE9SaXk1ZnY2dDE1RnNxdVRO?=
 =?utf-8?B?RjBTUlhYNUNrU1IzUnpPTzNyYzBnTDRteDJ1ZGFpMVU0dXZzUThsbytSbVBX?=
 =?utf-8?B?TUdwTkdaamhaVGNyaXNseXJBRm9Fak0rYzZhN0Rmb2Nlc0oxaDBGd2NYd25p?=
 =?utf-8?B?SW1pTWFIMVluUW9hZGNLVTlkak55K29zL1lCejZBTXdIU3YySXNFNy9XWDJH?=
 =?utf-8?B?OWFpalJlc2RJNUZmSW9lYWJsemlDNHM2aWtVZzlVRTQvK0F0RXArbW10SjZP?=
 =?utf-8?B?N20rK2tuc3h0ZVpaSVoyUU1MbEdkbm4yTkVJd1BxQm5DZWpUWXFNSGtFbEVH?=
 =?utf-8?B?VWY5cUJlWTI4QVBSMG91bldqekpFdGc5eGFWUmJ6andzQW5FelV6OHh3dFM3?=
 =?utf-8?B?VWhWSU0wTSt3YzFuTEh6OUt0SEQ5NGVwQ1EwVUpJekRsb3dQcmZPSHZaeVdD?=
 =?utf-8?B?emxGZmdSTE5qRUhqa294UEllODVNU3p1SzVZTndhc3oxRkUxVnJlMTkwZVpn?=
 =?utf-8?B?SU9jT1JKTGZjVWozZnNRK3VqNjlkMUVyS05Jb29lRm9qT2FmSTRqcnNmUTVz?=
 =?utf-8?B?cTZXQW1rR05nVUFUZVhkUnY3dGdEMVZ2enlqN0FuTGNBYllzVFgyMm82bGpH?=
 =?utf-8?B?dkhxL2tmbFRpdTdZYlB1bEQ3WldPYzY0b0ttajNCM1IrUTFOOVNaQ3FXL0dH?=
 =?utf-8?B?eVhYOVRON1dWMGRyL1FHYy9oSFRNK1I5bHI2YU0xdGdud1l4V2svZ2RYa3BI?=
 =?utf-8?B?N1ZPVC9xZVJWSy9xemxjQ1l1U3FrNm1DSzRSMTlpclE2VjBIOEFQSUV3Mm50?=
 =?utf-8?B?bnNZQ2hxV3FoTElWWGczaWFNai9LQklLU2tGUG9LOU9ma01yY0RXZElOU1ha?=
 =?utf-8?B?Vk5SWFA3QnFJYVBTMnNxcVZyUktiV3hFNVVKSnJoVHFubFhQcGdSVkJ2d2tv?=
 =?utf-8?B?VDRiOUVHMnVFa0lKakdVVXlSLzkrWG5oWnRQVnFzc0pqK1hKZ0QxNjAyRWRy?=
 =?utf-8?B?NDZyelhmNkJBdFpxMlVvemFic2hQY0JXYnFmV0h2a0JzeWg5WEVUaEs4eE43?=
 =?utf-8?B?ZU5DUStVSEQ3QWxReGJrZjZtTHNlcmVlWUdrcEpEMTdtQTN5b2ZNRm5sc0Rn?=
 =?utf-8?B?NzhqR3hMMzNOV1ljdnVERDRTcVpWaWNWdXNtY2VCUU1kZWxHQlZQd1BMYVZH?=
 =?utf-8?Q?R5stILke9fdMj?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c47679-60e5-4a80-023c-08deba9cdaa6
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 20:33:18.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P194MB2052
X-Mailman-Approved-At: Mon, 25 May 2026 23:59:46 +0200
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

dev_read_addr does not return a void* but fdt_addr_t.
Replace invalid usage of dev_read_addr by dev_read_addr_ptr.

v2:
 - Replace dev_read_addr by dev_read_addr_ptr
 - Change error to EINVAL

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/watchdog/starfive_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
index ee9ec4cdc3a..d2c16150f4c 100644
--- a/drivers/watchdog/starfive_wdt.c
+++ b/drivers/watchdog/starfive_wdt.c
@@ -290,9 +290,9 @@ static int starfive_wdt_of_to_plat(struct udevice *dev)
 {
 	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
 
-	wdt->base = (void *)dev_read_addr(dev);
+	wdt->base = dev_read_addr_ptr(dev);
 	if (!wdt->base)
-		return -ENODEV;
+		return -EINVAL;
 
 	wdt->apb_clk = devm_clk_get(dev, "apb");
 	if (IS_ERR(wdt->apb_clk))
-- 
2.43.0
