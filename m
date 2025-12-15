Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AC1D5B16E
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 13:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0044C80050;
	Mon, 15 Dec 2025 14:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="F5QnpFW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4203A80077; Mon, 15 Dec 2025 12:34:23 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A629180050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEaouURIeSyu+F2aTJt2ku+Xa+pzBPNfHzy99EsrtkHxsGBahLFXWwy4rmUpjX/R5GDNakpkno5quP9MDzTUUXgwU00akceu9oJ0a+JtCeQ6OLTIHkdCHAb0v6YrZUq/6SI9MbAl4xG4YcaFz4vnNPMEX+zUUUhlIfFM07qvfBsqcRjKo9A5Y0L53zxXy1wzeEyokVL4ZEwJK1EbPviaERPtWzJGJyplBCIlHv5sLQAjQe2dUGfS4peki+oadogGOiwyIp/gufAHR+hEpHtme6q8onXuw8J+LC3EmjRgTf9ezDjaz0vrR1uY8BQw6+rc+v/WS/a3k15z+qFQeeKtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYvTDXpzEimnSxKbj+guTJlZ8uIxEVmdmE9z+GNYpWg=;
 b=BXKZMsNZPQais9F60vRtE9gn8pB+jtuJVWUVYOg9c4q3fWunTU4tges7Q0yOFZCThBlWk4gs9uElzZVKL/SP9ZMiTBrWXKUnX/7nXmoagrpZcKGIGiVVP8KSJwBbUmB3gceaG24BFbheNLRIBf9pH8BjTQidy7ZQEfC9KX6wWdfXTLcpBx5yMNZAKETnRV5SwkJ29UvSHoH57caPuiabUsvsr0Svo7/6YJ/mFcCSPkfSKm21FyRiMMdus7JJ4LzmqGdoDZSSXPgVquITMEK/fWr3mNjfNIUjo8NkSiw+Qa7l0xeR+ks1/+c1IjIZ1kgYpoSND60sstMPY8p4N18g6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYvTDXpzEimnSxKbj+guTJlZ8uIxEVmdmE9z+GNYpWg=;
 b=F5QnpFW4DtTt/O/hTm5Zg39HrShSevhLF0t4BSgMjO+PaCZo2KQyX9wxOC2jN5tBxZ8dwZGyVGX0bTDEg27ZDhCEVfC/CoaY1PotwwhJ0F1/Ua1LJXf5lFZSUUWZSswV3OoqGnLlQcIVbtIXwaYDbUmAI/cRUmNA6hQjjYt7oiRcqO9bagjw3N9QB1xlXZ+8W3oAoSjLX4Bccrm4rWokz+ZDARsIi1vlarwppCwptTfAuixRcrbLnJpqBt/IoWAm91276y5wV3BAlfBMB+ysu9ut5cCtnfic09xA59lGQ+0uIMqqIoffgd9ILhM06KeXrnE6fp51k2Ls7DTN7AUr7Q==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VE1P194MB0733.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:169::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Mon, 15 Dec 2025 11:34:19 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 11:34:19 +0000
Message-ID: <BESP194MB28051D632021995D4D572411DAADA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 15 Dec 2025 12:34:16 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] fs: ext4fs: Free memory while handling errors
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::8) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <1e8d7aa0-f56f-4ae2-873e-d70df9f27184@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VE1P194MB0733:EE_
X-MS-Office365-Filtering-Correlation-Id: 415a9b07-3bc1-4ff6-c7c6-08de3bcde271
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|6090799003|5062599005|5072599009|51005399006|23021999003|41001999006|15080799012|19110799012|8060799015|440099028|3412199025|40105399003|12091999003|19111999003|11031999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXZBZCtPWmI2ekFmSEIvM2x2YVU1N0ZNTDUrcDloWG9mbHhIbnZNRWRCYytV?=
 =?utf-8?B?QnA3Y1FhUVFZd0NTZWtmS285eWN2ZUI3NnpiMDZFWjM1ckNmTGlybDZuRHpQ?=
 =?utf-8?B?elBDOCtRejVOTEZlaVlEUnN0cjIwUkN0Qi9NT3JDQUVyWE1veDBKSlZjUjly?=
 =?utf-8?B?dnhyVVBzaHB5TFg0czdCZHkvb1RCeTd5UDFSSXU2N0FublltcXhNYTZ4K1do?=
 =?utf-8?B?MUZhV2l5djBDcFZhSEsrVWR3ZXRZUmNRMDQrcUIvSlRQbXh6WWdDdEFiYzJk?=
 =?utf-8?B?ZFJ6QWxjS3lqRHFDSjBNMnNqRzV3QjJuWE4yVGdVTVEyc3AvdEVlRitJbWs4?=
 =?utf-8?B?WmZ2bGZ3Uk1oN0NHdk9QbDZGWXV5T3hRNG1WOU16Ulk0OG1TOE1odFd2NEhq?=
 =?utf-8?B?WC9mNEZwNGRwR0hLVlVndU5aaTc4MUpqaVp5L0RxOHlqemxXM1o1YlQ1M3Zr?=
 =?utf-8?B?dUxoNHVqamYyaTUrTmJQMTh6UnhMelQ4ZU1YNDVOOVhYQ210d2drbFVjZklG?=
 =?utf-8?B?eWV6eVRWTVVYMDljQXB1RXFyU3M1MXoxME45aVNnOENOdmMySkZwdU5oL25O?=
 =?utf-8?B?cGl0d2ZYNDFkd0hBb092ZCtsOWdROUtUSmJtN0Jyd2lESXZiTk1zSUNRcC84?=
 =?utf-8?B?OHVuc2lBS3A4ZFk0bytKVkVQd1pWeC9ISURYSHlHakx1SUo1S3BzNVdqamN1?=
 =?utf-8?B?NDg2UGVCa2NmWTFaRlNVeFgrQWVCMldFZmJ5NXFlZkFUMHpROVY5aGFDZUp0?=
 =?utf-8?B?QUdOdTZidEVhcGdNRFQzRkZWaGI2YzRyV2xxbjd2UFQ3ZTkxU1lZQTRGYVc2?=
 =?utf-8?B?cXdncmtYOFo5VmRPT2JXcU5xbkVRc0thcysxMzR4MUhTWSs5WEpQVWFPcTdt?=
 =?utf-8?B?N3hxLytIayt1QVZjQ1dFek4xWW9rakhWY1lKSW9LMEFEb3RvZjUrT0NlVmRl?=
 =?utf-8?B?Mkt3TWpDSy9zVWlRVFhzZTNsZVlacVJLQ1gzMERQRG1JcWlheFZIRnNMc21Z?=
 =?utf-8?B?NzRJSER0REt3Ylo2NWM5TzhvNHRsNUdLQ3Fwbnp5bDJ2NFJsSEw1RmpKbW1m?=
 =?utf-8?B?KzBLWS9WVXE4UDZSTW5PeDQ0Q0pQUGlMcWN6ZWxaTWp1UkdXcFFrUkZ6SzBU?=
 =?utf-8?B?V1lMTllwNDVLYjVvUHhSNGE3L1A2NU1JcXNOODFTYWNVMHBNUE9MaXV3cG1V?=
 =?utf-8?B?YWRBb0phc0hueFZiK3FPdnFKQk9WQmFycSt4cDBRUnJSR1p3RjRXdnIxQ3hM?=
 =?utf-8?B?TmpadVNxN2ZPdm1ZejJMclJZWHNHRFVnbDd2WU1VODY3cXNrRTFMUCs3dWU0?=
 =?utf-8?B?UWRWRXZMRm96MmlxK3k3azBVVExkWW80cExrTE9TeEZvbmVHY09oM1dMUUZQ?=
 =?utf-8?B?ejF0Z1RsNldUK2ZWcDJWNW10VGQ3NkJTcDhRT3kxOVppalJIb25Sdi9DZXMr?=
 =?utf-8?B?TERRbCtxVmN6L0l5ZmoyRkt3K2tFUzV0MzdCVUlsaFpFOGNKci9QdEhTSWxl?=
 =?utf-8?B?cThiTHMzU2tEZUdIK1RIcnlGNFBHZ2RBV3R6bERUVWwzeVFJSkRvOHdmTksx?=
 =?utf-8?B?dFQySktTbkRhenlCcm9VK2p6eWZiN2ZsYnQxQlJMRTk5Tnp3dmZVNzRob3NR?=
 =?utf-8?B?empWTWFDalY3U1JpZXNydDIrRHd5ekpXWWNYOGEweEJCOHd3Z3Q4Qi9Ja1VO?=
 =?utf-8?B?NTZLaTVPYk0rRVl5dkRIOTVtY0lKWHNiT3dsd09LeHZXemplSnp5ZE5DZ29I?=
 =?utf-8?B?elBxUVJIdlpXc0dQVzdRTXN4YzEvUTVuWDhwVXZBQmpFL0ZvTEVCemdrUWx3?=
 =?utf-8?Q?3CfSoWFb3rxv6a1k1w+hQHSCeAutuwY3LPags=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJrRzdTSEdkaXF0b3hIMU43K0YxTWVNVDdlQWtYcFVmLzBtcmNhbWg4NVNu?=
 =?utf-8?B?bExIY0VLS1RVank4TFJReGoyUGFMSGJNWGJqcUl4ODRRcnV3YTgzazdpcExG?=
 =?utf-8?B?ODZnM2pMOG5IanY0ZG5jOCsrc2xHNWRMWFl1WXdodlBYcXRnaTM0TEJPbGV0?=
 =?utf-8?B?ei9EaGh0RkFUOXZBWWNOZkh2R1JJaWxicXF6eVRwVjRMYjVSWnIzMnB3d2dG?=
 =?utf-8?B?Rm5BU3RibFFmM3Bhb0ZhNzcraHBmbWZ0TkZ3RXhUY1FiTENObFpnelg2dmxq?=
 =?utf-8?B?bm9oVzFDUytzdjZzNUJvM2RKY0owS08zdTNSN0s3emRIam9RMzViOXRGSm5r?=
 =?utf-8?B?ZXpjeHUxR1NMYXMwcHNKKzBNZ2VNbEE2TTljUTR0T2IrOUtMb0hWalpIaWxk?=
 =?utf-8?B?c05Id2hXaVBoNFhoNjhlaEFWSG9WV0Q5QmVrSWppZVErUWNBTGlieG5EYVQv?=
 =?utf-8?B?Z3VLL1Y4R1hoTUxxeTlwQlNGU3VDRHNac3JBVS9PZmYwZ1Z0Sk1pUThEejMr?=
 =?utf-8?B?ZVU5ZlRFMWlobGtleldlckZVVVh2UU9JNllJWG85VmxKRDZvWUdvbURBbDFK?=
 =?utf-8?B?cGdsclRYeXd1ZkkrM3B1dllBSXBySEFHLzlDNm5adkdnSVhkblg2YUE2NkZk?=
 =?utf-8?B?U0lSN1AzbUNFZjcwRUovaW1vcC9JZS9xQXArU3F2d2Q1UlowWS9jVVF6ZEFX?=
 =?utf-8?B?VWc5bDRaQ3Q5aVl1WmFVTnBaM1F4dXBUdG96Q3d6VFBBeXltZ3NGRS9EblFG?=
 =?utf-8?B?M1NDZUVBZW5MaHZYQ3pzQUlJNFovSnpla2t5YXhCZ2JPYjRRZllvSE5pZDNM?=
 =?utf-8?B?cDlNUWorcW9mRUowVGlrV2htOHJCdzQ1R05iWEw3YkNtdDJGalA4elpNS0Yz?=
 =?utf-8?B?eHMrWFFDc21hY01Qd2RjcWlYVkFiNktpMTY1OHNJVGZBK0VKMmdyajJORHBS?=
 =?utf-8?B?cENHYVk3Z01zK3d1bUJOZkZweVk4U3lkU0wwbG9jOUdMamV6TTZ4U2pqdGY3?=
 =?utf-8?B?NURFSVU1SGt6YWpxR3pqdU9XZlpWcVBRME1DcE1XbGNraHJZbWl4Yk9SbEM0?=
 =?utf-8?B?aDJRQ2Jod3VuR2NHdTBHdk1ySkZKakRwd3BXMXlKN3NUVkFUQk5hVGdCWUJu?=
 =?utf-8?B?aFFmZnNudFFKTkp6Z1V2Ump5aFBYeDV0MVZSdTMybUFOakFBL1hzNWtDTk83?=
 =?utf-8?B?NkI1WVF1S2hpUnhLTFBNck5qRUI3azdLV0s5dEZ5SHlqZFR6dFJqRVFoUldx?=
 =?utf-8?B?WUxScWJoZnA1T1B0U1lJN3lkbFNlUWcyanhqYUxRbEJKaE1wOGJaRmtUVWdu?=
 =?utf-8?B?MHd0Vno4QmJUdTdBTWZyak5mSE5pYWhiME0zMmlOYUI5UFBUNFo4OXg4TlVR?=
 =?utf-8?B?dHVaOEFlalYyUzdUeEtQWjVqWFYwZUFBU3R2SFo2WHA4VXRUS3RFdUNQSDBK?=
 =?utf-8?B?VEViMnBjbDB3MGNuTEVlTnJrd0o4WkNtditPVjUyaGl5SEYraGN5VEsxMXlt?=
 =?utf-8?B?SWV2RzFCYzN2dHZpMGJManFuZjF4TFZKNFVTREQxUXQxQW5FMHpxN2o5Tjdo?=
 =?utf-8?B?eTNyRmdHdWNzT2h0N0k5OVBVVkJUUTRpcFF0bzNseWoybEJXYk1rRENrdm15?=
 =?utf-8?Q?neTU+j5YyNmjpSSophOd423o4BfWN9+6N7wpJwhaowpk=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 415a9b07-3bc1-4ff6-c7c6-08de3bcde271
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:34:19.4763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0733
X-Mailman-Approved-At: Mon, 15 Dec 2025 14:00:27 +0100
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

If zalloc fails, one needs to free memory previously
allocated in the function. This commit makes sure that
we do not leak any memory.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 fs/ext4/ext4_common.c  | 6 +++++-
 fs/ext4/ext4_journal.c | 4 +++-
 fs/ext4/ext4_write.c   | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 8e6531fa3f0..9e1d574e5b1 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -727,8 +727,12 @@ static int parse_path(char **arr, char *dirname)
 	/* add each path entry after root */
 	while (token != NULL) {
 		arr[i] = zalloc(strlen(token) + 1);
-		if (!arr[i])
+		if (!arr[i]) {
+			while (i--)
+				free(arr[i]);
+
 			return -ENOMEM;
+		}
 		memcpy(arr[i++], token, strlen(token));
 		token = strtok(NULL, "/");
 	}
diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 868a2c1804a..3a2e9f30c12 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -256,8 +256,10 @@ void ext4fs_push_revoke_blk(char *buffer)
 	}
 
 	node->content = zalloc(fs->blksz);
-	if (node->content == NULL)
+	if (!node->content) {
+		free(node);
 		return;
+	}
 	memcpy(node->content, buffer, fs->blksz);
 
 	if (first_node == true) {
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5b290f0d80d..2b8ed1cd110 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -205,7 +205,7 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 		di_buffer = zalloc(fs->blksz);
 		if (!di_buffer) {
 			printf("No memory\n");
-			return;
+			goto fail;
 		}
 		dib_start_addr = di_buffer;
 		blknr = le32_to_cpu(inode->b.blocks.double_indir_block);
@@ -304,7 +304,7 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 		tigp_buffer = zalloc(fs->blksz);
 		if (!tigp_buffer) {
 			printf("No memory\n");
-			return;
+			goto fail;
 		}
 		tib_start_addr = tigp_buffer;
 		blknr = le32_to_cpu(inode->b.blocks.triple_indir_block);
-- 
2.43.0

