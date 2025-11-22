Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23762CFC51F
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6424983B03;
	Sat, 22 Nov 2025 17:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="ex5fUOv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6030983B03; Sat, 22 Nov 2025 13:26:16 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E5383AB8
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 13:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtN4b/CJK/8J1QqQ4K0lVAyCV6Pa0Z7ozvK4Kid2F9HC1JdPxO+fqcDKKZEmaiEq0SyRahmplo40+Z/d7CTQhFnM9JxgQgCn41y3PfsZow3VQt52VvR0R+fkTCtHSiiT26YMF2VRtf3F131bJTApL8pldUbWjhHzwktVGk0gdrdQrKeUYATKMlH23L1USGLBjKQGyYkw/kQJagCzLX7h/b9E6HusLjXJ4UVaB51pxIWVh4LI9+wZ5mlVvg3U9wG2TfuciJVc5LznpxaYMZw/1gKKqFK15ZU2huVktcZA6C8CStJdPgIcTedVnEEk/kEBU2FiHo6WZ8m4IKZpUbhkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yexZT1PZTSBRk5TmXVifNCHzz9A2unMjmSdLQH7Y17Y=;
 b=OWnVFNfvpHp3cl4jAFtnXq8u60O7Sv5bXMWLIqgdrgaTwZzDIz/tT9aXuiniM0GwkkkE+HYBW5ljRFQ9tb53y3wHrbeIDo9iu4sCjEx5u61izW5Tk55gkrq7jYq59VmuLI84sve2A3GXPQV0w0G3ZgzL4x9RWOevQO4A6MrfR+Gl8ik1SPUb1wJocw8pAMdk4fXq5Ts8VxcwNvXg+EV1cMylWQWfJSzk5np5zEr7R1NOZoGARbmuTlC4+AXdHlBz8t+erebzt7mO4gY+ooDlyDUceyOirPdHaPHf0kb/SESgtI20YqsATgP3DK3nUMjAflJ07hE4VFaQbBckVB6EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yexZT1PZTSBRk5TmXVifNCHzz9A2unMjmSdLQH7Y17Y=;
 b=ex5fUOv/GjC1J45mLQEE7sSsVFU6fCCoEpyOAqkBA7jNLqPfEckvWPo527MdkP1vZ86Hv0YVM8fVqDRuR5v+Xn7lO0C3RnTyPfFb7A9BjO+mQewDinLMT0gD3iHKTcmlnjeldwCwwBmWTzKYb7OkeZoCAi34seG74Bc+LXR5hpNPEm6nn02wfvMc3ku07IqeuRE6Iua3DNPvBPYdOmNeWvRRJAO3C6nDp6wYuC2NS3yeQONTSvuftma8u+pvzTpncaEbTrb8da0tS3A+sFOF4GPi7WNncBkaZiUCfO+86h8o+yO67DrHFqSt7GenigDnEmA3W4EvlvK5SRPaBbdKfw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VI1P194MB2146.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:1c0::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.14; Sat, 22 Nov 2025 12:26:11 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 12:26:10 +0000
Message-ID: <BESP194MB28056C2655479914772DF6BFDAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 22 Nov 2025 13:26:07 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: freescale: Fix error handling in ls1088a board setup
To: u-boot@lists.denx.de
Cc: Ashish Kumar <Ashish.Kumar@nxp.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0459.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::16) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <65c5242c-35e0-4d8d-a7a2-e47a98a7110c@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VI1P194MB2146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2efe19-6acd-4f11-6936-08de29c25139
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|12121999013|8060799015|15080799012|461199028|23021999003|41001999006|19110799012|5062599005|6090799003|5072599009|52005399003|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzM1aFRXWGFZTXpJaUxkVUUwQm9EK2F5MTU1TnZ2MFZPZXNEZ3JlbllhL0RD?=
 =?utf-8?B?MCthcVFoZE1EYy9qTHM5K0gwM2dJY2J2NWNNaDN2YkFHcUFVVTk4RG5wdWJR?=
 =?utf-8?B?d05WbHVOUEh1cSttVW9nNU1xOVJzVWxVQ0Y0N0hMSFFENVdGTzQ5VDZ5aXJV?=
 =?utf-8?B?bjR2Tm8xWHEydEpTMUxzN2kyVi9MeVZjM2lBV2dwcXZqOVRxbE8veXJCQklP?=
 =?utf-8?B?bmR2OS9SMWVvOW1lR2t4MFoyeXlZTHMycEdOdGVEZG5DVGlvak5ROXBqeURn?=
 =?utf-8?B?WTdmS2VEUG82M3RSaGZXUk1kb053Z1Y4a1YweDlxM1BIUzFDWENDVGFUNkZQ?=
 =?utf-8?B?SUxZMDJlc0lqYW0yNjlCK0MrWkRJUkpTbFA3cDVTUStHb3ZDbUVjZ1hZOUtK?=
 =?utf-8?B?OThVaGlMRHpzQnQxbDdxeVdOK2lRbEx1WFpLY09WRCs5VzV3R3VNSzFxNUFh?=
 =?utf-8?B?bjhzZzBFbXYxT2FMYm43dzFtcEVUeFlaaXQ5NjRma1hUNHBxUitCUTJuWWZq?=
 =?utf-8?B?WVJLb3V5d0FVQUFIZmt0cXRuUFFzWkJqTlVieW8ycFZ4cWxhd2UrRXoxNDFv?=
 =?utf-8?B?eDhMWFllelJWN1FNZ0p4UC8rUFVJTk5kcnYxeC9VTlE1RCtzT3VuMUYvVzlX?=
 =?utf-8?B?YUtNT0ZMRTZrTUFKaWRTbE5BZlYzZ3RjUnhWS2ljd2t2MC9sL3VrVVV2a0Fl?=
 =?utf-8?B?REk3WGM5MEQ3NXFDNDZzQmJVMExGVnZjc2hNcGwzWWZsZCtVczVMRzcrbDQw?=
 =?utf-8?B?Z1Rwb2lHT3IrUElSNmw4cDdFSDVDb0V2b29qK2IzeTBycFJMbDNJdVYyWkt3?=
 =?utf-8?B?ckhxbVFuSElzWmNNNnd2K21MOU0vTHpJT3ZzRXh4amlxSmtPcUFPRnRzVTNa?=
 =?utf-8?B?ZHd6WFMvdXNRVHo4SGVlZ0wwVER5WjNZUTY3Yk9RVDQ3S0VBeEljaWYvL0RV?=
 =?utf-8?B?RzhkZ0trTE9ETU5GeUZQQmtpK0pEWlBqMUsrTXMwZHd5MktEM3ZESHZjU0Ja?=
 =?utf-8?B?am11ck5GMjJ4emZVTnYxaWdRUnJubW8zdTJlQzNSWWlMY3RBYmtDUVhvYzlq?=
 =?utf-8?B?VUdqeGxOeHRKTHlPNFpIRnVOamh1SUxRdkF5Z2hjbm1BRitoNmVFVXdYdXFS?=
 =?utf-8?B?T1Z3cTdjR0wxVmxpRTRpeEFvMmdOZWFCcHVRSWdCY1JidTJtR0V0YTczZVll?=
 =?utf-8?B?bm9OVXdkRmVsUXFwMmxaRGo5dFFTbUZBWGpOVXlyR3NCcDIrdUc0T2h5ak12?=
 =?utf-8?B?Rll2OVRSR0ZlK3FyTDlvdld2WUl1S1JwbFZRcUxCUVJvUFA4dDJoR0VpM0hp?=
 =?utf-8?B?THZmdVpJYjg3YStkb1V2b1FVbFNlbml6TkZ0NHBlSERlYUwyR3RlTURCaVVm?=
 =?utf-8?B?NTh0cmIreDMwZWt5Zk1XTmhvMGdXekFobVpCbUlGUnJmV09IcVBnbHE0aGVM?=
 =?utf-8?B?NVJPMVlmcy9wREE4Zi90NDByU2dNcDlRTjlMMjE5Ny9waDZoSWFpYlhkSWRp?=
 =?utf-8?B?QUQvWGR1NGdlWWJXaHJNbzEweGgwY3RFcytPcEppYUpFc3duLzFhcXhZbFNk?=
 =?utf-8?B?MDlFZjdkc2xQbG1ZNUxGZjlySG5oL0ZSQ1ZWUUt1Sy83OEIwQWQrRWhISjQ1?=
 =?utf-8?B?cDdnN3VBL051cS82bUY1K3JoVXFmRzg1MEYwaUZhckVLK0F4ZkcwNmRHMjh5?=
 =?utf-8?B?b0VTQldlcEJ6L0JzRGJCbHRrazZrZ3pyQ3ZZTjcwbTZ5V28vQ2l5Q2ZSTmZj?=
 =?utf-8?B?NVlZdkxaWFNhREkzVkJGc3N0VVpla0NlSnNDN1FQMHpPRTlibTFMVFFUZUtG?=
 =?utf-8?B?TytkOWlUU0tYZXF0SjkyZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0JqU2dEVXFxNVFGMVhhK2p4K0plRjM2c29yb2R2bzdpc05tNnFwZWFLOE1H?=
 =?utf-8?B?bGhUWURNT2pWb20yaUcrZTBmU1k2eVBiU01zNzhTUjI4ci9Pd1NVTWM5RWdO?=
 =?utf-8?B?WEl2am42ZEVsNEprQ3hWZWo1WUxGa0Z4VjY4SCs3Zzl3QkVoME5JSGNmQk4x?=
 =?utf-8?B?Q1R4d2srN1VqZHg3TmlTYzd4N25GUS9RdmRCSjJ3aFY5MnR6cVZCRm5xZGtQ?=
 =?utf-8?B?b1orUmtoZ1EzbzRrZmpFcFBVZjRqQ3JkTVVnZkFwakZUWEl2SmVRSllYK3Rt?=
 =?utf-8?B?bkZaSGZmUGZCdUdvbUhHN1orNzhaRmVza2hoUHVBckx2MVJTRStSRHBOYTBn?=
 =?utf-8?B?QzB1ZHpOUzcvSU00Wnd5Rk1FVDVSbituTlo2L2Q2bVNSUy91MlpvcjZsN3Zw?=
 =?utf-8?B?N3hNK2E4dW5uWE04bThKbU5TVGN5RnNVWks3cVZaSEZDYzRlMVdiUjhrTXBp?=
 =?utf-8?B?Um1rU2dUZ1orU0cwbnVWWWw5T3ZpR1l6ZjFISzZIU0RjeFgxNXE1Rmc2R25O?=
 =?utf-8?B?YXJYdzJCRVYvYXN5UTFreWJzZmRGTXdPbDRVWGZHYWR1MDFLdllESnVMZUQ3?=
 =?utf-8?B?TnJIaFhKdjFVaXdzbnpSN0piemVNdk9BSDdxQUQ4WjNFNkRaYTVhYXpEWHll?=
 =?utf-8?B?SytSSm1odU10SHdFS3ZCeS9meVlMaHR6M2pNdFR6QTVPaE4zRzBKY0FLekli?=
 =?utf-8?B?RjFESXFuTitObzlvR1ZWL0d5VmVhWmFtcUZuQkRDTmJ3a0VJNUpOSlg1QzZx?=
 =?utf-8?B?WGdPRWdvOVVFMC84WFdUdlF4ditSQTlIOG53MjRJZVZYY0lWbGVyd0pvd2VB?=
 =?utf-8?B?YW1jWnJIK01BWFU5Q2hMNjFiaHZ6THJaaEd2YkVOR0RDMUtWVU5id3owNUh1?=
 =?utf-8?B?ZGw2c0ZOUGJHbTUrY0FhRllYVERLUFo5Y2RpZFpyZDNocUpyZlA0Smc4RExi?=
 =?utf-8?B?M3VPT0d0N3lRU1lBKzM0ekZaMDQ2UVNEWjduTHZMT21ZOWlEL2RNbnM0THo5?=
 =?utf-8?B?VHh2cmgrKzVBM0F5SldyOHRORVBvemhQMWhGYmhBZzNIb1QxQnpKVHRMSmtx?=
 =?utf-8?B?OURhOVhiNHVBTW5yS0UwZ1ROTmtCbzJnUnI1UkVTTG5SbXZtMmxyYlpqZkRo?=
 =?utf-8?B?dW02dFRZMmkvalhmM2VsZ05CckxWMStuaDBNSTE5WWEyc2YwSmRoTmk5cWh4?=
 =?utf-8?B?ZzdRZzhlNC9DK3lGSVVFMlRrSDNaNk1KbTFMb05NSS9RWmpvdjloY3hZbkl1?=
 =?utf-8?B?TGdNT1hkTjdiZk1pYm5tWFplbThXNjkxQXN5V3hOdkhCS09lMEh2b1hjK0ZQ?=
 =?utf-8?B?YVg0UzNTR01FK2tSMFM0RUYrSERvZFpQNWt0RzRMbnllb0VsVnFKWENrR012?=
 =?utf-8?B?REgrd2JoaEVFcmtyTzM2ZCt2bkdPbEtRQ0hKWno3VUkrZ1I5YjFqYVZxNUFw?=
 =?utf-8?B?QTJNbTNtK2hNN0tIY0FLeHIzc3FIaVZsNDk0dnBVcVJ2NGFFOUV2TnB0WkdV?=
 =?utf-8?B?enhDMHlUSlZmcFZIQW1pZmNkdmxpUDc0VVFWQUZnNm15SHJ4L2oydXFrWHRw?=
 =?utf-8?B?UXdSOThPWEJHYWZFSmdNaUxKdEJ6Z1hrUWxkRFV2Tm9RNG13c2duOGNLRHRP?=
 =?utf-8?Q?hPt+cxz4bk5E5IYxosJLGwSRxAFnJceUqaRSh0ZBHaSg=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2efe19-6acd-4f11-6936-08de29c25139
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 12:26:10.0939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB2146
X-Mailman-Approved-At: Sat, 22 Nov 2025 17:36:27 +0100
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

  - Add missing checks after calloc
  - Fix memory leak when handling calloc failure

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/freescale/ls1088a/ls1088a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 9606434e8ff..51ec055be63 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -948,7 +948,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	total_memory_banks = CONFIG_NR_DRAM_BANKS + mc_memory_bank;
 
 	base = calloc(total_memory_banks, sizeof(u64));
+	if (!base)
+		return -ENOMEM;
+
 	size = calloc(total_memory_banks, sizeof(u64));
+	if (!size) {
+		free(base);
+		return -ENOMEM;
+	}
 
 	/* fixup DT for the two GPP DDR banks */
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-- 
2.43.0

