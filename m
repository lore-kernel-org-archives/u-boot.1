Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB6C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 03:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A29848DF;
	Tue,  2 Jun 2026 05:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="XTY2TRbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8309848A9; Mon,  1 Jun 2026 15:05:54 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B0984894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La9iJc4P9/f5vgdwQUj6vJXUxFOTooTRrMHk8D5iyNjPVZ0jGmN8FMoQTyBjZ0i3z7CDTWifV/OwmdW45GsAPAw+QmOW/E8kWoaDlSobnt0/qbH6Y21jPoVUu94+NxaW8Gc6LQewQWk/O5V18+hYNBXXUua7k95GDIDQoxL2KDKPG+WZe/70MVqXS1+xPvrH3eDMpUi5R+NsYiiVEB/iADf88ngSQKv/0r52jSHbrpD8+I+6AgYkQfj/KZbmtWvsm3BChi+pGYWlp41DnnTMrClINKC0KOzk+E0qvcq5+sbzxktacqJXbPuBADY50RQPFQX7L+amPpQoco/OVm+DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJcMP+g8prF/etoWQCtCW10JkdPMOLqiCps3CTUyWjA=;
 b=G0O6fDZEyxN65No9raLSpxQ+v6kQ49YDe+Q8EKvzPqoe/bfcHBOMDURbhNfjGDTTN3bWWzz5kqEfb6KxIczNOs8dbApU2f76dF+8wf9BTzcWpVENY4tOqYiqbioZ25oMKw4qSq61l1Jb11A4VgEwo3VtWTJh8YBxk6ufGRySdkZ5UQLPZx7Uh6LMjC8AW732NcuyvNzwsydSvOAXcvEGbPiN4vL0d4ywvMIq4gOtDYs82rbE1cXzaJmTh5H6G7LKa0X7l49Z170s5s6rIlwnGKGNZvm7do9actVCjDMcQ+MWPjxrdxFW9jYSXuldsbd4K1rdZrJGtYuFP12U0nnvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJcMP+g8prF/etoWQCtCW10JkdPMOLqiCps3CTUyWjA=;
 b=XTY2TRbTCeERHt1P/gKRZ/iHu38xzlvXB7CJdKq8J1ei66+jjV/9oi37d0zMFfLwUFIIk5kJXrOKUc2pArjeY2yuea7sBviE5vClHljAMedkmQWQtiG6j1o/dzqI/mEI/kHNLrFKt3XWo8xiKvGHgVCQ5nVxC/zfDyMaxiKbMu9sXLuWckHKEknfScQucVZOE+NHyGme+CP8/f5dvrHgMbFz8KTQ1AiQiYJJJlK61psYjbzr5LqNh47BFFsLJutJUFFnPtMDzdyGXEdaJNw0f8yWvp+Wo5BTlSQ6BbdZGnAzSphbI0etCoXrUPFJt3XolG8n3/zN1nDGpYzy29Dp4w==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DB3P194MB2033.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:429::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 13:05:51 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:05:51 +0000
Message-ID: <BESP194MB2805724A10F29A279E1F4A36DA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 1 Jun 2026 15:05:48 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] xilinx: zynqmp: Fix snprintf invalid size argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0289.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::6) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <1a6295c3-0585-4408-b510-d0fb1295916c@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DB3P194MB2033:EE_
X-MS-Office365-Filtering-Correlation-Id: 17286d8a-2d2e-4753-4c11-08debfde81ab
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|23021999003|8060799015|15080799012|19110799012|24021099003|55001999006|6090799003|5072599009|37011999003|5062599005|440099028|3412199025|30101999006|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG16bFVZaUMreWhmVmVtcTNacUVHZXQrTGpBYXJuODlWYVp3NWNPSW0xSTlo?=
 =?utf-8?B?VW1IajNXakJ0Nk15ZjQ4SEN3Y0ZmTEEyeXBqOUtLVG5KQlFVZVBqcmlzOUZY?=
 =?utf-8?B?Rk5qSCtyaTZuc3FzVEI1SUp3dWZYZmtNUklhaU9YVDBuNVpCbzFvbWR2aFdZ?=
 =?utf-8?B?UW1HQkRQMGRnSFJnR25vYzNEbGV1QWVwVXo3azlIODJ1b1B0ZTl5WHhkd2dk?=
 =?utf-8?B?MUxMcUJ5bWgxdlV3RzVxeGxZUmE3ekJmdUZXekhFcjZyb0RsNE1ZR3AzM1Uy?=
 =?utf-8?B?cS9EcGMrZVZRcGdjbEx3OFl3bXVYekNXWFZKWFlOUSt4cUxrY1krVitvbUlH?=
 =?utf-8?B?UitxR25GWjFRamdyZSs5ZVp1QldNKyt6dVRhWExITEVkWVM1Z3c4dTNOcUZO?=
 =?utf-8?B?VTRuRHRTL0QzMjdHTGsxclVQZ2pUa1VWQXhzdnJBSTRZeUsvSFBKVjArWUg1?=
 =?utf-8?B?b3UyY0lRNnRicHpFTUgzOVplSWQ3WTh5bnNBdUJuazV5RVhZbDNKQjBKUXdu?=
 =?utf-8?B?dkNVV2Y4Q3h1T0NIeVhiNURFb0ZHL3lTS21NMEpZekdyNVQrdXh2dXI1aFBa?=
 =?utf-8?B?NTFPQnpDeHRyM3JyYlBCeDhmUGl2Q25TYnlFQVNWbXhWcDhvRi80UFNuTUZr?=
 =?utf-8?B?SGJ3a2lTcmE1NGFjMjg4Ni9SSXF6eUNyU01WeEtQKzBRRWZmWHNBem1JTnNX?=
 =?utf-8?B?U2VIYmpxWk1YNGRpbUZYNXJuYzkyd3lFdE1iL0ZyV3ZlbzZzWEs1ZTJSSmR5?=
 =?utf-8?B?Q0p6ZGw4NkRST0Jrakk1TjQ2bFU0aVlKazNGZHN1M1hINGh4UlU3S2E2aFNE?=
 =?utf-8?B?MnRsYjQ5SXhZckFtOGpMMkc4WDBGN0MwNGRUWHRZNkk2UnIvMm9BVGptWnNG?=
 =?utf-8?B?VTRRalJLOHBSS2U5djFkL2VzVEJYeXliMmU2dnN2RFpOM1B2YXZWYTE4dE9H?=
 =?utf-8?B?c2o0eWJxUUU4Z29melFxc1BtNCtEdHcvMXBJcXZJcHNmbUFRV3pwQy9qb0F0?=
 =?utf-8?B?ekduZ0M3cGQvcU9xdm4rTXgzTExuSUptUVQ5RW5ZaVVrK2trUDhYbE4zNzBm?=
 =?utf-8?B?RXdqTWlwanE3YjIyd2g0Z2QwNTVpOTZKSVZIZzQrNitjbDRFU2tKblQwcTBX?=
 =?utf-8?B?M3IyeGljMXlzUy9zMHNORWRxbmVDSXk2dkVac2VVRUpIV3d4LytQbGlaVkpV?=
 =?utf-8?B?enN6bnU4ZG1LYkg2MjRVVWQ5TWx2MTJwSkVLTXRhdUpETElnVzRDTHljdDF4?=
 =?utf-8?B?Wkxzb2ordFV5S282NHFyUTRtVnJINzczNGJMaElySnE1RE4yVGhCcjFNMWJl?=
 =?utf-8?B?ZERIQThQVXFHa2ZHczVHNVY5NlhwZzNEdE40T2FyTXlrd002YmxxTkd1OEZa?=
 =?utf-8?B?V2djS2M0NkYzc2lKTVlxK3AvRDg5Tm53WEZVWDJ0elM0YVprbU9xR0VFNFRU?=
 =?utf-8?B?RU16d2dtdDEzNFJDdW51bnp4Um5TM0FpN1Joc3RBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZjT1FYeTBIQnZyNnozQUY2QXVIaUlSaHVsQlE4bGJOaUpES1gzNkZqQ3E2?=
 =?utf-8?B?alRHTG12NFovQThIS2F2OUcxclZqSlE1YWx3N2pIZ1lTMzU0dFo0eVczajh3?=
 =?utf-8?B?NDV1Nlo4REZncFFMaFhxWEgzN2ZHa1lOV25IM0w4VWlIYlB1bXFPR1ZiOXMv?=
 =?utf-8?B?MzRzd29ta1RrdXJsalpMYjVvWkpIR2ljeTVrSVBILzdoL1o2aVBMd3UzZ1ZV?=
 =?utf-8?B?NU9VM1poR0xRNUhla3NPZ2FHTTBCL01RaFJmSmhsRzR1ekZZVWo5RDJYY1gr?=
 =?utf-8?B?ZlZqc3NadnJsOVVGS2NWZWZtL1NYWGxkUjhScUIrUmVTTjIxRlM2Y1dTTmpB?=
 =?utf-8?B?ZVhJcHhoZFU3UFQzcnlXbm5nTW1wQVB2S0RiQytOU21xWGFrcm95L1JyZXRL?=
 =?utf-8?B?cFg3c256K0V2RngrdG02QitOMFk2ZmU4S3B5K2FpblFqN0VVU21ESlRDT1Rh?=
 =?utf-8?B?RnREVmczdlJIL2JoWEVld1kvR3VzN3B3ZDRlK3JMZFFPRFlWWllOM2U5Zmlp?=
 =?utf-8?B?ODduWXF5SFI0MmxaQ1djcnE2bTVvVjdVaXBrMDlsSzNRSmhOeDlWMkZrTVJC?=
 =?utf-8?B?WFZ3dlBZaFIvdFBjN2NVNTI2L1MvOWFLWU9QSXEvVGovdFJacnpUNnJvOXBK?=
 =?utf-8?B?b08rY3FLck5CSUsvK3hLVzN1NmhjUVZ4NWxoRVBsK1k3SWFTUkJlU25PQ2cy?=
 =?utf-8?B?UlhuK054QXJFc3VmQVgyKzFqc0NWdFdOc0dRZmlQaHdjcnJ0YU0wMVdXQ0t3?=
 =?utf-8?B?b3FLKzlkR2xHd2o2VkpXUkcvQmVLR3RZVTk0bktrZldWSmVmbU1XTnF1b1I5?=
 =?utf-8?B?R1hFRkZ6UmpQL1FCVXIrc1pQRVlIQWlRdWFMY0VSTmdWZlZZV1ltN0NVbGlK?=
 =?utf-8?B?dm1NcFdZaXlZTHpSZTV4MGc5Y3Fab1JwSlJNQWRRMlMvUjQvZnlkT3FNVXE1?=
 =?utf-8?B?aFpwWnZqallUZHAzRnl1akV3M2ZyWXk0RUZGdUxWbmROWDhuY2tJRzIyenFC?=
 =?utf-8?B?QXF3RzVJNys2dk9CT3Y1QVduaXB1dmhPZ3NZYnlvVWFtaUtvUXVqZnd0RVFE?=
 =?utf-8?B?bEtLbmU2aTU4cjZ4T21CU1lOVS9kY0lVeHpFN1VMRU8zRXR2anBwY0thNnZD?=
 =?utf-8?B?M2pFZVMrWnVSRW5zMG15TXI5dTR4NEtDR1JzcXRyOHAwMndJVGkxQm5PVWlM?=
 =?utf-8?B?ZnQ3aXBnYUlReGtCeUh0SjMyeVVnZlZOTWo4SkFFaWFNNVJPbEFWbzg3eUlp?=
 =?utf-8?B?ZFUxNGNPY2FMQlIyNWpJR2kxdG9iRFpwVGgwUjdMVlF4V3BIazFNMG1wSnU4?=
 =?utf-8?B?cEViYU5BKytGL0pyT3pNcFlHUUhzRzJncHNsanVsV1ZaOVpyM01kdlovcmE5?=
 =?utf-8?B?QVRsZFdQWDBvV1UxWWw2OEtYais4RHIvbWl1TE5hVk1FRWFML3RwNVVxaUdu?=
 =?utf-8?B?Ty9BWkUxcEFVQnNCWmJpZGFESHJBQXB4VDlTNFBxWFdMTHEzZ2J2aWhTMjFW?=
 =?utf-8?B?ekc3RFpjMEFaMlMySXNGVFphVXdISGdseTNXd2ZiN2JCSWoyN3Yyd3Z5WDVX?=
 =?utf-8?B?aXRQYjI5YzFaVUdKcEczOXdhY3dIdEUycElpYlBUZjFzVXVOY2szS1dHQ0hh?=
 =?utf-8?B?cnloSmZNU1JIcEdVRis0TU1SYjA5Z0dBY0Z1U2lSb04rYkJaNTlscGtvakZC?=
 =?utf-8?B?QU0xWmlqV2w5K0pVNEc2eHBOVmkwQkg4TW91bnpsQ0hzZXd6akVFUlR2TkVa?=
 =?utf-8?B?VnhGRTNiNktxdUlmMEN3OGN0aTV4NVN4RkpKamhUdUZ1ampqS2dTazE5MkEr?=
 =?utf-8?B?Q3c1THZvWWw0MjgyRml2dGVWYWJVYUlBbmdISW56QWtiZ0wrZDFqczJMNkJ1?=
 =?utf-8?Q?mJiSORDc31zjj?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 17286d8a-2d2e-4753-4c11-08debfde81ab
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:05:51.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P194MB2033
X-Mailman-Approved-At: Tue, 02 Jun 2026 05:54:32 +0200
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

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/xilinx/zynqmp/zynqmp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index a1d8ae26673..272e92d8465 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -706,18 +706,18 @@ void configure_capsule_updates(void)
 	case SD_MODE1:
 		bootseq = mmc_get_env_dev();
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
 			       bootseq);
 
 		if (multiboot)
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 				       "%04d", multiboot);
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, ".bin fat %d 1",
 			       bootseq);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 					";%s fat %d 1",
 					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 					bootseq);
@@ -737,12 +737,12 @@ void configure_capsule_updates(void)
 			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
 #endif
 
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 					"sf 0:0=boot.bin raw 0x%x 0x%x",
 					base, limit);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
 			if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
-				len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+				len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 						";%s raw 0x%x 0x%x",
 						CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 						base + limit, size - limit);
-- 
2.43.0

