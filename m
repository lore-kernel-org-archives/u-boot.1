Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2201CD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F201B846AD;
	Mon, 25 May 2026 01:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="p8ZNA6Rm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF4D846F4; Sun, 24 May 2026 21:25:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB5F83E76
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 21:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7zj6u9G2xz7H3fz9YOlSnUTOs6l86xPxBf65mpPRSQxCB0gFEpz4JvbZZKfVrIU/k3ShLfP+rK39ICJZ766llN8P8RgLw5nx1W+np25efpuJjRkR9o9oGijHmMbaQ9uDTECN/51eU+yPL7QpKMwYS9n0mYXv+cpFp6R80tFkWc5yS3dAu2aoD/xxuuR3Pztes5TV/HhJnRcLIRsqYnMu9Q60jbzp3R4cU1ZIvZmsQJXYfbfISL/QlWbZdqA3AEv6faELTFk2Qn007mIBp5Mr9JXminaKrRbn5JeK6rbEirB5HFm296WQWO/FuFCwPkmQrE00l9ylcjZ+EuvYHp0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBW3vbLticX7+2FgCPaSxBQgzqcROLbH1dJ1G7asY08=;
 b=VQWcGXkIWNvN+TshwwczViRH5BxCSW6li4q4pSyz0T0o6IlrpKBa6INEA2l3gf/evwy91Sh09fF9b3SG4FYUHtds1xxjDSH2lS6bWWbM2aaRzSgjI42ENk1exHjdkh5+D4b6XV5JDpCZFSVi2USNqAraPU6ANQnkqpRclQQPXgyxOcMDqa+54TtycKZa9cw4p1zvpyVq/Qb6kk5JzLoyMkzOxe2dt3bb1x+PSt73t3NeaJVwlGxx+oZJk107OWUPgd6zgMB8xVo2XFQhRdk1jD/+uKTfTkQAcv+qYbe96f6u9jKDqt2aOq/cQTiQpQzMFPNE0uf4CrkbRxJQLk26Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBW3vbLticX7+2FgCPaSxBQgzqcROLbH1dJ1G7asY08=;
 b=p8ZNA6RmovcziPmzhYQa1wcnfgjX1jWTno+mjdfUT28uA5lGMXfmQsPpw3C2u02OOCvuBDosmce1B/2iQvXQvVOLsaZBn+aJroNfleLa4J1sIyxS9LOD1jZVo9JKBQo2nyRmXSikABLTVfcfqVg8Faues+z4m92qSHAUnh1lMymYXJgipTHvx2dUIQwCQZQ2t18PT0xtfOwi/Lj2TR+5qB5m+88X0zlI9V4x3s9g08qcDtbDbfpcuZVYnfykyOh7JXorOcxAGISPdOs1RXgYcT7A1ytF8ys2biKBi2Vy1YvhK/VtUGQA2naQ9ymuXW+rysUkmtDtGhFLQnByQELDKQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS8P194MB1823.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:508::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Sun, 24 May 2026 19:25:50 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 19:25:50 +0000
Message-ID: <BESP194MB2805BBD03E7C92727F116585DA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sun, 24 May 2026 21:25:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] fastboot: Fix blk_dwrite error checking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <946cd4ca-aacf-466b-99e6-2747dcd61d76@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS8P194MB1823:EE_
X-MS-Office365-Filtering-Correlation-Id: 762b99a1-fae7-49b9-0d14-08deb9ca43bf
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|15080799012|5062599005|23021999003|6090799003|41001999006|5072599009|51005399006|24021099003|55001999006|37011999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVZpM25UdHNyWERzOGdXNnR5L1hTZk45N2pqUGpBSWRGdzV2MlhSRCtFYndk?=
 =?utf-8?B?eml5bHpoZmsvdkJLUVZMRCtNMTljL2ttNHpveUs0NWorTlRiUk9XK1hWU3BJ?=
 =?utf-8?B?T2lGSmQ2SHJISk1JWDA2TUJlTDBKNFJmUTJKVENxcVcyVmhRTTY4T1owOEN1?=
 =?utf-8?B?STJIWXNUdVFPcjgyc2FkNHJINUVoVURpNjg4Z0kwWDVBSE1rMnpQVGJCd3VG?=
 =?utf-8?B?cFQ3OE1oTEJYLy9BUVZLQlJrUGJUNUNXS3g5NFRKRElPQ3BJbTEwUU1vVTZ5?=
 =?utf-8?B?eW9WT2Y4NmxadmlQTHBtSnozTUhYTDVvMW1xZ3BDa0JDeVlDMG1vWEJVWXBx?=
 =?utf-8?B?N0QxbUtpQWdFV0NmdFVaQnE1QU0vdjZiYm5SS2lJVjF1TXo5TU1ObnJvbk5F?=
 =?utf-8?B?SnE1U3JSWlJJaDFac1pKbnF4S0Qvc0JlWjljQ052amNSUzVuVmlvaEFiQjYv?=
 =?utf-8?B?aGpzNENXQWlERG1CakZ1Nkg0WlN1cFdoRFE5UGNRUWxCZWMraWhHV2U1eWRG?=
 =?utf-8?B?QWdFNzZmYzBOSWJYTXVnVDFEWGZsSUYvYkdGU0JlRnVWQzJxV2hneWRzekxO?=
 =?utf-8?B?Z2lUUnBPeTVoM0xiUVc3Y3RwNndUc1R5bkhUZW01MkE5VUFqUXlxZlZQeEdx?=
 =?utf-8?B?cXNoa1JDMkc3MHV3aGRucVJhWnU2ZVk2bHpBcXRabVVZRVlWbmpNdHJxVTRK?=
 =?utf-8?B?QStCcmJ4dkdhRFBFaGpiTFdRNlBUK1RIYmVNLzVaekVPQkM0VWkrMnFBYk1m?=
 =?utf-8?B?ZVV4UGp6WUFyTXJyYWxJWFZlSjZtb3JTRk1DcmlIK2RtMEJIRmdzVXgydnho?=
 =?utf-8?B?bWxqaUNsZDRZMUtEWUJsYmo1OGc2SDN2OFhnV3FvVHRIOGNMY1RjTHZWSWQ1?=
 =?utf-8?B?N1M2RDBXQzRpNEw2b1BzNWlwSTFaQllQSURONjZuWExFc1A0NUxrb1RuV1Jz?=
 =?utf-8?B?aG5vTUdVcHNubENBaXRpWXhXdDR0K2dveXNtZG5yVjRPaStzWDZvaGpyZjcx?=
 =?utf-8?B?eXVOb241T3c1QUlEMVZhZ2N4YUtJa0R6akVrWmpYWGhXNW02YnAxaU9JWHZN?=
 =?utf-8?B?NWtrMWRDL04vUFJEWDJCZENaTG9ReU1iUHpRcldBd0ZVQU8yejRwcE5VbThs?=
 =?utf-8?B?TWRaQytEV2F4N2p6OTIzN01OSVRwdlJBYXpRU285eDVoRjY4b2tRMGFyeXdU?=
 =?utf-8?B?cG10c2Vkd3VvL3c0VjkyNjArWUFkU0tZa2FrdkFXSEZFMFM4OUp0OHhtVmhz?=
 =?utf-8?B?cWI1Rm1zVVcwNGtBTEtiN2VEREk3YjBhc2crOGdEL2tTUkg4L2ZuVG4yQ3JO?=
 =?utf-8?B?eTd3clNQUmgvbW9TVkxTclZudXFScEZuM3BXdE81aUlYVWNPTmtRbFkrYlhi?=
 =?utf-8?B?ZmpvQkhvNzV2UkhLTkROUk1mYkdGbGVXTUw5T1RZNEhPTTAvdkphQXpMeURi?=
 =?utf-8?B?M3lsblBuaFIvVHFwT3FDQWwzck1obEV3TEJqM2RRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzYyQnZqNXNUSWRNTHR4T0JsdlEyRUtkdHdneSsxTmdIalpjV09SdGwyNnlE?=
 =?utf-8?B?b1hlS2JTSmJzUzk1eWlZWXVSM1lJblZ0LzRVcm1rR2JZS21VLzRaVUpZc0d6?=
 =?utf-8?B?dUFkYzhxejhwRDRTclFhYnlyVTZ2aGZEVkFSenh0WmpBNnpibWJFc2F1ajJ4?=
 =?utf-8?B?VHZZUVF5dDczWGNmWnp2cms0Q1VnVExXM2pvcHY5Uk1XZFBIRXJ0UTIvYkRi?=
 =?utf-8?B?QUFEaEZEQzBkTy9WdmZJWHg3eGVJaDhMd0xVN1lsUjRKTmFvb1h3VUpEMUpm?=
 =?utf-8?B?cXJvK3RuUi9sVC9UU3dVeW5HTENTWnFwMHNUTHlrS3R3ZmlaMVl1Y21JeExO?=
 =?utf-8?B?cTR3RGtRYTI4ZnowcHd2QVZOdnoya3h2b0g1ZEkxSEVSMlp4ZGtkY2o5K2V1?=
 =?utf-8?B?SlpqNUwvSVJrd2NNUWZpamFBT3UvbGlZRTJiSFZoRVpvc0NMbThxckRQcmF3?=
 =?utf-8?B?ayt0LzEzdzdNYjFVdmNGY1VwYXV1SUZRODNaTE5WeTVoMHp0UHBTZUNOV2FT?=
 =?utf-8?B?YXEyY0o3dXphMXNhQzF5Z3Z6SlM5dWVrbmJhZTlaYlpKL3l4ejUxaUs4ZFdG?=
 =?utf-8?B?M0V2aEIxWWlwVHdncnFZSXNNckh1eXVmb1JMd0xtc2hpN2tTTXBMOW1NOTFU?=
 =?utf-8?B?Zk4wRGRDQUFNekI5cjByN2FZWGVmVUVxdXUxVWthaXVTNk9yeTFBL2wzZm5U?=
 =?utf-8?B?dU1tYUxhTnBHekVMQ2paZkZmUGt4c2x6Nkd6SVBPSnI1aVROUDIxVnZvM1JH?=
 =?utf-8?B?ZTR5ejRkbXVtZjdJamJZN3Z4VlJsTFZ5dFdvYVQySVVmd2JJYWVoTU1aTnlO?=
 =?utf-8?B?bmcvNWlPZVBTMUJBdkdqQ0pCYTdQNEtYM0t2NXdURExqR1Vaa3BBNm5Vam9N?=
 =?utf-8?B?a2Z3eUliSVJmYjNvVVJYWGRoMmxvWHNTdnZvWUtWU3ZlVDB6dVZhQTFuQXpo?=
 =?utf-8?B?RlJ4SHBVaVhCN3hpMjRRR1ZRZE15VHVUNnVESmVsRDArRy9oT1JIbk1qRzh4?=
 =?utf-8?B?OStsNUd3OFgvVG9lUXNPVFQrc2tiYW1rbkR4L1dSNHlLL1pmbzl6dWFqaE5Z?=
 =?utf-8?B?MlZhcjRYampBYlpCRTJJMGMwK1VqaXg5Y3ZjS1NBbitnMHF6OEFwMTY0QmIy?=
 =?utf-8?B?bFU4VXdXa1QzY0pSWDMzclh4MDltQTF4WmlvTElvb3VaOFpWcE15Zkw4WUpV?=
 =?utf-8?B?NFUzWTJNQnpQWmRrRkNBSWJVUWMwSkprNXd1OXh1d0NHWXhTQldIOWNxbnhT?=
 =?utf-8?B?OG1wNGs3ZWhVaVRqaDB3V2VvRGI4T2lvUnJzRGk0Zmh6Vm5qU0JMVjBDSFc0?=
 =?utf-8?B?T1AxVTNhM3R2dlhnTkJMQkVONHpqYVFhSy92VWNYK3pZWExKNlNybGt6VEJL?=
 =?utf-8?B?WE5pbk1zK214WmZYV2t2d1lBbTFuL1dzQ1VtSXV0Qi80Y0pySk9vcnp1UUZ4?=
 =?utf-8?B?R0h1dy9ENmtTUTA5TkFyR1NRcXR1OHJKSVhKLzRnUEtrRG5rWkxvdEJGdTk0?=
 =?utf-8?B?ZWo5L3ppcytURGhVR09QenJ2NnJ2d1N5QVhqODJIMUFzNjlvOGR6K3Y0RGV4?=
 =?utf-8?B?MStpQzAzMmpxMWd6Rk1nWStBM2xrelllSnZCa0htNXJuT1k0UUkxdkZaaGVl?=
 =?utf-8?B?M01RRDJNS0FmRWxxTzYxT3R6YkRLMkRncWFSWmdWMzU4T283N1U4M0x2NzJX?=
 =?utf-8?B?VU5INFZlOGZQaW14NE0wa2lBeEpRTUQvcm9oZlFZcGZLemJqWmZtSGdWOUsr?=
 =?utf-8?B?UDhNUkdLUkduSjB3RmN4cjV4bFJ1dy80OVppK3Y2cGxtOGl5UTZ5dDkrOUNs?=
 =?utf-8?B?bWw1eVY4OEpXVk5rbnE1c2hhaVhLYVlBVVZJd080TXFmSC91Q2dnVFU0ZExn?=
 =?utf-8?Q?ThzLjcU09ZbEC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 762b99a1-fae7-49b9-0d14-08deb9ca43bf
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 19:25:50.6686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB1823
X-Mailman-Approved-At: Mon, 25 May 2026 01:11:45 +0200
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

blk_dwrite() returns the number of blocks written.
The code was only checking if the return value was different
than 0. Hence, partial writes were considered successful.
Fix blk_dwrite error handling by checking that all blocks
are written.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/fastboot/fb_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 11d9c8e8460..9bc782ccd02 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -263,7 +263,7 @@ static int fb_mmc_update_zimage(struct blk_desc *dev_desc,
 	/* Write new kernel size to boot image header */
 	hdr->kernel_size = download_bytes;
 	res = blk_dwrite(dev_desc, info.start, hdr_sectors, (void *)hdr);
-	if (res == 0) {
+	if (res != hdr_sectors) {
 		pr_err("cannot writeback boot image header\n");
 		fastboot_fail("cannot write back boot image header", response);
 		return -1;
@@ -275,7 +275,7 @@ static int fb_mmc_update_zimage(struct blk_desc *dev_desc,
 				      sectors_per_page;
 	res = blk_dwrite(dev_desc, kernel_sector_start, kernel_sectors,
 			 download_buffer);
-	if (res == 0) {
+	if (res != kernel_sectors) {
 		pr_err("cannot write new kernel\n");
 		fastboot_fail("cannot write new kernel", response);
 		return -1;
@@ -287,7 +287,7 @@ static int fb_mmc_update_zimage(struct blk_desc *dev_desc,
 					     sectors_per_page;
 	res = blk_dwrite(dev_desc, ramdisk_sector_start, ramdisk_sectors,
 			 ramdisk_buffer);
-	if (res == 0) {
+	if (res != ramdisk_sectors) {
 		pr_err("cannot write back original ramdisk\n");
 		fastboot_fail("cannot write back original ramdisk", response);
 		return -1;
-- 
2.43.0

