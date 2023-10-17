Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ADCCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 05:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB6C86BC8;
	Tue, 17 Oct 2023 07:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="lNytOJsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E9886B67; Tue, 17 Oct 2023 07:20:21 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B3B869EB
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBrymc0ndeea5U9hVh00QyHrwL2Sa5wIDs16snP2jabocmeAn0YIJIETN2WJxUby1xBUM4vamCYJFY1CNXPTQFiTmL8A73pALdIb4e3IT2au+Y0nMRqrmPghgZxtVww/gI49YFoqTC+YnkoC6A1/bYINP05HEIm8LRzRsooVprM/bQxuN5Yl721A3GNqwGifuLcrvicTdwk7Mgc/Hb3GzeHLJj8DGScNXYEgEJ+QuFXUETV1bZvG9Vfj0Woi2K9T2GvwucFXBfQqX1CFCkOv0o6O+O45U5WSNpx3UMfT9wP4NZ28rz5tkbs2g6R1Pgh38cJtkkM0ocm3iv0bz1HIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX08gBvhPS/ncwYTqQ6iNaYYcXF9RffAXzlgB479uTY=;
 b=Ahw4/zbyYlwHMupAIZM5XYzQHA+lpuBP/Aik/AsHG68OMuVj5ko5hb/NmI/jftWJ8mWT3gbXJdLngYbinv/wfxfg7LCnGLXHn0vFCs2frvc4g47FKKYcomNO9Mhhvuwt1xZoZUCrbChwgIzhJMDy9ca3tlOGSEuyGuwbTQG5yPLLcfmi0/xwRxKyQ3yg44z2XZiv+1P2cP9HghRonAKCrumG/e/4EtbsiMmnc/KwEZoOXyvhYtZ8KGnStUfk2TCpESP0quPib2HouwHxCb0JxPXX4Rq+pynnMad89f1vW9GwUGJrwNOVzxvgBBORgeKCqNMFzXNqoQJfoqQaa7C+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX08gBvhPS/ncwYTqQ6iNaYYcXF9RffAXzlgB479uTY=;
 b=lNytOJsiTowRdo1rN6vOk+Zq/AK+ARHUwMyJRHYnJen1rxWYnC7FbwyLL1GuHbTwVq8VwA+csbLFNbqYonFI+d9gAOpReGUoIP27gPYmaxJcTxRXb0e/GGXjELxBW/A6PD1G29v0N/cCPET4jc+J+71UpjQLILl1mJMACVAaFlABSRkkPYiQmswvEUQagX/nDa+/hfP6ytAeQEymze0kU1Zp4zdK2q1lVgpUsZKBdD02JiG+ycKJAIvagJztksrSCaybVmFRQVgxtenKsc+1IK5NqFMvmbYDxab+y0DS0l4NVRbOcq2SeFxVuMX8Jn5K8vfIvORg5XzJlH5Lmx9AJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6362.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:536::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:20:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 05:20:17 +0000
Message-ID: <31bb24cb-2d84-4524-bb25-263f8fbe16ab@siemens.com>
Date: Tue, 17 Oct 2023 07:20:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] board: siemens: iot2050: Fix M.2 detection
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ea4c65-0376-4b60-87ff-08dbced0bfb6
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9ThD0yFdvrAc6VoXjJuTzXo9Tgt4Kst6W2PyHcYLYIoWu574cWxV7mL/5eDuHyyBCSy1foUJG9val2O0jA1Sffsr1wxv4MQry4o16DrA43dXBhEZhXFlkOhEhDPQTeCf8OlOegT0qNhHF8YgupR6HvAJM930ikcToPP/J7jcKqx3pNmPHQ84Cx3gaxa7Q189O7xIhsXohvfd5W9FAh2xVQuEv4ZbI/SsFAoVE5QfTKe5NcmRwqhFo67496MFu1a6leahx5mUjHBhy9PDlWEkIJwlQCj/gAHgVB/gkenGBgWd5GZt4gxkOjdn2au1SASsxKuuA3k40MgTV07voPmAupyx0ryMcYKtkBBEU5NI9WAUhyHIpxoR27wqvLlb6YpU7G4/I1RxjmdJUqWmS6H9p7Fh33LBszQC8Vn1vH/xT/LLa/CvdKp/u4rtNKYw820GP8ZUWms1XAqOU+5PUB8v46ReRZ0ZdOBjMJqUrMyp96L4MX6qPNAXGw6SRNpvrjZOhDr6c3gEumbSs5Y3nmckVC5+dwGf3VmaDtsPJRZoMsYJ3vTi9gaSoJVC0TDeylwDj1ZkGREF9NE3hl3FHngrKTCG8Pk9R/KiR+UQLWgTgsgOceP3TvpS/zLA1odrH7HTVAW6b86r6xlODiSvz1WYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(31686004)(66556008)(66946007)(6916009)(66476007)(316002)(31696002)(86362001)(38100700002)(82960400001)(83380400001)(26005)(107886003)(2616005)(6512007)(6506007)(6666004)(8936002)(2906002)(6486002)(478600001)(41300700001)(5660300002)(8676002)(44832011)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck9zMjJXa1Fkd243VDE0UFBIU2lOZ0hITFk1NFlVeGpmRWhOOXEvcC9IUmtR?=
 =?utf-8?B?ZTNQeHFRbjRManJvRWNLY1JCZU8yaTIvcDYyeGR4dXo0RXdXQldCdjl1YlZ2?=
 =?utf-8?B?QTlVa0xDZ2FWSTR5VzB1aTZmZ1k2T3I3R0pCNzl1Tkdxc09saGdLb0JOUThX?=
 =?utf-8?B?b3hKdGE1Z3lWV20xNkZRMzVHV1k2N0NINGUzY2lQcUVqSDJmejYrM0liNzdK?=
 =?utf-8?B?ZFdXODJ6eXJ3WVE5Mi9IdE5YQUs5b3VrWW9qZ0RyTjBNVmNrQ0d6akZHMEVG?=
 =?utf-8?B?REVFREU1MCs1TnEyTWNnMm4vSTNjTHg0N3FxZG9qTkxUWXVIZmdXaWhENGlN?=
 =?utf-8?B?WGo3MGZFZmFZNmRCY09rNGpZcnpHckg0RUxJenBQVDNmckFsMUxQZUNTWFBV?=
 =?utf-8?B?OCs5QTVqOFo3L3MvTFUwQStubDg5dkN6RVltMlpVWUpaTHloQldKaVdrMUcy?=
 =?utf-8?B?YjBwamdwbXI2ZWE0WDFHaU0wR2pINEtSdlJHWDhISE4vUUljOExWZDZzMXRS?=
 =?utf-8?B?ZURLOEE5MTVxblRlUGsyMFBJQjZjRStHREdIOUZlM1ZpeGMrZVdWMTNxdGlE?=
 =?utf-8?B?MUtwTFBrdTR1MjJvTnhmSE1VSVowbXFPRXdsYnBIMFBMYXNyR0hPRjd5cDIx?=
 =?utf-8?B?RW9wK0JYUWlNQlpPRXZrM1NmWjd3VGoxd2NzWGoyREc0c29GSHlCK29rK0xV?=
 =?utf-8?B?UTNMdG5tcld5dy9OMW1neGtSNFQxdFo5OFNiYklHeEhuajZuWVhJSDJTbWQv?=
 =?utf-8?B?WDJPV2tMeVZ6V3NSYzlwSVQxQlZNWFFEL1pvTmNnbVZ2aUQzQWRxVXdMMWJI?=
 =?utf-8?B?NERITHA0U2NCemM2OGh3azV5cTBUeldYWXE3SVEwNjlCVERDMzBCR1dYblVX?=
 =?utf-8?B?V1hCUW1rZi9vSWRseTg4MkxDWkpZWElJU3JnTUo0SUkxOG9FTXo0UFppSGFo?=
 =?utf-8?B?WTVqckRiMkdublJDMHZCSUdQbXN3M0lKd1JQNWNsOEg0NXYyOGlBYnFsMHc2?=
 =?utf-8?B?ejR4QUw5VHBpRGxWcHFCd3RUdGtVL096UkkwZVZKRnJJb0IzU3puSk56cVc3?=
 =?utf-8?B?aFJ6OU5zQkpGWmIyYnFNQ09BVHM2RGhSL3JVaVF4N0pwWW95MEZVWlBaWk8w?=
 =?utf-8?B?ckN2bklPa0d6ZmhFSDNQMk9GbTZMM2tzZzhqYzNhUm4rT3ZDTTZKOVZuWHpR?=
 =?utf-8?B?eG12eVhlamFmWjNtNFNzWC81Q1BQZmtkODBaZ3NZandTc2RvLzdZR0tlME1X?=
 =?utf-8?B?Ump5S0w4QUJrbmgvbm50aGZNejM0dm94Y3l4SnBNeWlNc1I0RzN4UHJmZnFZ?=
 =?utf-8?B?enUyaWgrMzZwVS94YU91bWc3ckhpOXlCODVwaDZaTW1xcDM1Yy9TeWFpaDFC?=
 =?utf-8?B?Ym5nZGlsY2VPOGhIQlN6b2NrUWRjZjY3WEFwbUlCS3JTaUhmcHJmclc4Z3lG?=
 =?utf-8?B?d0dvTEtGdDRvZnd2NExVdHRXcTlKT1dqRmRVS09SQXBPYXRsS25YNjZHajFX?=
 =?utf-8?B?QmsxZ25tdDVaOGdxV25qdDRYVy9YMlFMaHJyTGpITGM4cm93VitHMGNRQlZi?=
 =?utf-8?B?MmRNLy91U2x3N3VmanBIRld4eUF6d2NoTmNCcFRXQkZJQmV6RzRrK2lPUFNR?=
 =?utf-8?B?Q2FRWFZLWlphNzJMYm4yQmU0TlZCT3ZJNlpWR1RtOFFiNXFyOVI3RTBqT3dm?=
 =?utf-8?B?KzgwamZJR1hPOVpVL2tLY01zNURGVEVsekU5cUhOVkl6TnF4WDRlSk5pS1ZP?=
 =?utf-8?B?N2VTSVdKTEpUQURrQk92cW1wNGE0L0lOeEFjbXk0UmsxR3prRDhjb2lKYkhz?=
 =?utf-8?B?aFhsclRtRld4YVpTODMyQ29GdlA4YzI5Wk04akRKZFNrakNzMTRZU2cwbXRt?=
 =?utf-8?B?eUdwd2lYWGpUQ2ZnQm4rZ3hnbEZ0QXFKcEp0RjhNMGZQRnpKbnpyRjY2VGZp?=
 =?utf-8?B?dzBZaFNnVWFZRlZMMDRER3lRSmo5TFdCQzhHaW9jNHdSOC81dlJMdkV3WUNy?=
 =?utf-8?B?dU1rMEpsWm54KzhpSm5CTWlXMGJrSVd1VkhGK2NaT3ZWYUNZSmJ5UVYwTEtX?=
 =?utf-8?B?QVpQeWZPdWFIRkNUa0QvL0tXZUNlTGU0bUkyVzZzdTdMUkxzaFZHS21LaERx?=
 =?utf-8?B?SzRZdnNzSU4vWG5XeGNSN1BXOVk2K3ljcHRLR0ZJK21mVHdjSDJxTW5nY0Jn?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ea4c65-0376-4b60-87ff-08dbced0bfb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:20:16.9643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVyaLDQbgryBx8QssbfZBzhNvzWfCx47beOe3sMmcec43CNTEKf/nI2zuiU/wR9jxE7WH6Y4X0G/E6CbSH5Cxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6362
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

From: Jan Kiszka <jan.kiszka@siemens.com>

The "simpler" the logic, the higher the probability to not test and get
things wrong, again: The absence of a "-PG2" suffix is not sufficient to
derive that we are on PG1. There is also "IOT2050-ADVANCED-M2".

Finally fix that by exactly matching against the two PG1 device names.

While changing this, we can also drop the not really needed check for
!board_is_sr1 in board_is_m2 and call the boards by their names
("board_is_pg1").

Reported-and-tested-by: Bao Cheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index e35e55fb5de..0b0686e2628 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -155,19 +155,20 @@ static bool board_is_advanced(void)
 		strstr((char *)info->name, "IOT2050-ADVANCED") != NULL;
 }
 
-static bool board_is_sr1(void)
+static bool board_is_pg1(void)
 {
 	struct iot2050_info *info = IOT2050_INFO_DATA;
 
 	return info->magic == IOT2050_INFO_MAGIC &&
-		strstr((char *)info->name, "-PG2") == NULL;
+		(strcmp((char *)info->name, "IOT2050-BASIC") == 0 ||
+		 strcmp((char *)info->name, "IOT2050-ADVANCED") == 0);
 }
 
 static bool board_is_m2(void)
 {
 	struct iot2050_info *info = IOT2050_INFO_DATA;
 
-	return !board_is_sr1() && info->magic == IOT2050_INFO_MAGIC &&
+	return info->magic == IOT2050_INFO_MAGIC &&
 		strcmp((char *)info->name, "IOT2050-ADVANCED-M2") == 0;
 }
 
@@ -217,14 +218,14 @@ void set_board_info_env(void)
 	}
 
 	if (board_is_advanced()) {
-		if (board_is_sr1())
+		if (board_is_pg1())
 			fdtfile = "ti/k3-am6548-iot2050-advanced.dtb";
 		else if(board_is_m2())
 			fdtfile = "ti/k3-am6548-iot2050-advanced-m2.dtb";
 		else
 			fdtfile = "ti/k3-am6548-iot2050-advanced-pg2.dtb";
 	} else {
-		if (board_is_sr1())
+		if (board_is_pg1())
 			fdtfile = "ti/k3-am6528-iot2050-basic.dtb";
 		else
 			fdtfile = "ti/k3-am6528-iot2050-basic-pg2.dtb";
-- 
2.35.3
