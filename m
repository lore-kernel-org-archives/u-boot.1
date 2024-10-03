Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F6CCF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B8588DD4;
	Thu,  3 Oct 2024 16:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="T9oYJY0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83CB688E4A; Thu,  3 Oct 2024 16:10:37 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EE688D9E
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSFPeGzlPRumHPQY72sKfRHKIGG9YjMd+yGkrbp7WLd3lXYTSLt1N1TWes1mkU497ZhlKBUs4vKDZmOrCBVyMaBT++kc0w7wNHhDCSw5dnCqFKWIaaam7UkkZPcFs5I6USRxswku0m5VP23WeW4V69XocII1IvCFOV/x4t310214/HAOyxv/AZX9s7k008xjY9KiHGu2nkGeyjAe0OPhUj2JWFkCitOAiUkQ8MtjlDG0ELTloyyDrhn2znFc7SOunJLXqCWrnB1D+E38ZAnlA39vsy4QL086ZygHteboByI8JLINcIdGKfUbDDDFv8tQNRd0p5QDdNmS943PpF5OyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpBe+Vi+z1HEclBT5mvMc1DhJML8HXcb1ic1dFK4TzM=;
 b=yK/P6oqkpjo9kByWMIHCoA0JMSF1Bw7mJwoprXGIRi1+75A2/qLAPQ2HK9ErR7hJjgziiitXSqBvIaa4VF4kzHeuTXFfqN8+3yYsUDdzreCMmyj51qgghniLAIo+Baa9hUwmJfJAxuy9J0iMevS+X51osMIxQpGgjTGOL2TRCnj/LapxCF62/v50sCfxhWPXb7Ui33OsGy4phXf2EfNF4svUd39SyP2VncTphteVL4p8c0akctAK9576ANdyn9JMzCpyuq+5jest7InvZs0OQ4kXDkZFCwlaJGgqg2Hjgby4eMMYoILunbkF5Dxsq5iOHoKd6oCP5F0/GE7Nc4hhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpBe+Vi+z1HEclBT5mvMc1DhJML8HXcb1ic1dFK4TzM=;
 b=T9oYJY0+iDShZuWYT8cO5UiBbh15Qj46WKACgXNXAvs6HV6qbJ4b+Xnj2T1aNpfsWi4gDyC1pgWQupB6lCM7Qx2z/Le9zG7CK/hauCpE1BtZ85taZy8VT6Uomxbk6IWQzFDF6pY3F7iDSsLiePoOv1Y1dA7lHO7aPDZgq9MAyKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB5341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 14:10:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 14:10:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/4] serial: add build-time sanity check of
 CONFIG_SERIAL_RX_BUFFER_SIZE
Date: Thu,  3 Oct 2024 16:10:28 +0200
Message-ID: <20241003141029.920035-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003141029.920035-1-ravi@prevas.dk>
References: <20241003141029.920035-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0106.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::25) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab8e072-1e8b-4338-bebc-08dce3b524f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M29Dd1gyQ05LQlNHcjc0SVdEbXZsWXJ3eGE5YmVxbkIxUXBmWDBSRHRXQy9t?=
 =?utf-8?B?dFZwRVVhTWxtTEVLT2txVk0vaUdWZ3BGTTBXSFZvalB0dkxyb2J3UDZGYit3?=
 =?utf-8?B?U2NqZFBxTm1hek11blhZOERUZ0RxSFRRbkpjNy9JNjhCRUhoY2NyblM5a0Nj?=
 =?utf-8?B?Nk5hZmJ1N3lvQW1ZT0JmQnd6aDNrcE1RV2s0bHFZR0t6UmREVmlpZjV1dHIx?=
 =?utf-8?B?K0h6VHhlY013Q3Z1ZGl3SVk1d245d3dnQVpqSmNVT1N3ZGp4U1ZhYXJVSnJW?=
 =?utf-8?B?dTYwdDlPTGdNSitYRzg2ZHhkTEpueS8rL2l4M3JRZnh3WGROUW1KRWU3ZUlT?=
 =?utf-8?B?MzBORXJ6K0VqOXRQTDduUWRiTEd3N3c1TUlpMFlpYzNRNDEwVEpHTm5oRzN5?=
 =?utf-8?B?Yy9NWDdBWGluUzRSN1plLzRUMWhvVWIweiswYUI0NjAzLyt4NlBLcUVBaytV?=
 =?utf-8?B?TEV1VzA5VFEvaVNZVThlZ05UZ0svYnJJb2NVQ21zekhiZUFvUWw2MkFqNUVj?=
 =?utf-8?B?U3dTTVRHMXo4cSthTW81ZWRZc0lJNCtRVnR5QVMveGVsbXN4NUR5YUtRNjVr?=
 =?utf-8?B?cWo5cmszZmRBZktLUVRoRlJUSGxqL3BZM2Zmbm0xUFQ2eVd2d1Z3d0YrN3h4?=
 =?utf-8?B?NjRRWldHbk9PNCtXanNoOFg1NGozNUlDc3JMTzdneXRVSmhIWnQ1SFdGbm00?=
 =?utf-8?B?T0NocGRVRURUYzJsblhtL2d3UmRPN25LQ005bnQwMWFhU0UrSHZhaEFQdFo5?=
 =?utf-8?B?eUl5Q2hEcnVOYmp2S3lXbGw4SXJQeHV0aE03VXlPd3lzdTVJZkV4c2Y4d05K?=
 =?utf-8?B?OFJFM1FIa3NsVG9qcnBPVnBQdXd3M1p0K1Q3cXgzZmdLcTFvS3JVUnNIZ1VG?=
 =?utf-8?B?a2lHVDZUWGZwdFVTZzE1N3hDMWNGL0ZKVEdyRlRUQnJRSmlhQTVCMHVXaWtq?=
 =?utf-8?B?dmNzZUxJY09wem5SbzUxcjR5eDNub0FiVTlDWCtJYU96Ynh1c2JNUzhoaFA0?=
 =?utf-8?B?NUpVOCswZkM3V0lpaWlPMHhUbGFoWkIwamhvbk1tWGZFZTZOdmpPVnovS1Vi?=
 =?utf-8?B?eDN4dCtYc2xTL0p2Ky9MSXBVelR5SE5XSm5TcEdlZHU3QTRCMVJ2cGh2cXBa?=
 =?utf-8?B?N2ZzYW5rWXZiczY3bmc4NUNldVRmRjZCMm1PSGtxVUxiSmZubnl4aHJPRmtC?=
 =?utf-8?B?ellUd1R1OVhUSFQ2UzdiMmp2clhxTFE3ckQyaFh1UXArUGZUYlo5NTJsZmNj?=
 =?utf-8?B?VE5GQzdMV3FtY0NCVkRxWUkvQ2hJcW1oRVg1WXNzL1RCZjEyeUxiSVF5UUI3?=
 =?utf-8?B?ZlVtWkZmTGFXaEFUTFdvYTFWWXF5dkQ4UTdiRCtrUHlCL1RLNmsxV2JYUWFo?=
 =?utf-8?B?Z2hYelBxM1JJZnYxTVYva2NmV3ZrdmloUDhzSjZLUGpTdnFWd0JoMGFyNFRP?=
 =?utf-8?B?VVpUcER6dUV1R2FOaHI4QkRDUzBFM1lJZW1hOUJTcFZvRjJaOGo4cVl3NG1V?=
 =?utf-8?B?M0k0ZnVnejZIRGRnZVlPZXpOZm9tWk1PYmt1bTUwZUprSi9Tdm1Ha2s5UzZ2?=
 =?utf-8?B?T21CeG00SU9vQzExTEo3WjlTTEEzaGVKUi9RMS93eE1MRkdvS3h4d3FwdXZR?=
 =?utf-8?B?REg0c1lNbHZvRVFwMkFKb29GS3g5T0xkTkkvbEpJYTVNSUV1NjBWaGdPS3Zw?=
 =?utf-8?B?SXRXZFFnSEtBMmIzRE5RUFJUcHlhY3MyS2YxV1dpWTl6T2lqK0phZ0pKS3BP?=
 =?utf-8?B?MUFZdkRWM25BMFJFZ3ZyeUtFVFBXR2t1dW9uWHhKY2xpdlMzekRSNmlMQmVn?=
 =?utf-8?B?a2ZaN081UlRXejRFT1RTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpmRmlBU3djTVlLUHF3YmNWYVBFbnA2ZHlGenJ1Z0NoV1NicXdoOXFJNG9C?=
 =?utf-8?B?YTVXZmN2MVZQRXhuRHhaWU9pdWdjczJyZGlBb2V1WXdFNlJ2N1lhSHN0c1VS?=
 =?utf-8?B?elVsUERLdTh5Z3E5dVZvMzhTbmI2OEZZclBnU2ovQTA2U2ZKR2dKYnEzUzdH?=
 =?utf-8?B?eHh2Zk9vbHRtbUhXLzNVVU9zYTU2LzRQUjI3SG5pVkNDMnRkNnhyYmU0emd2?=
 =?utf-8?B?QmpXL3ZEU2IrTTRld0xrTzRQWTZVVWxkTmhjODM5bW9hQ3VMUDY2eVNBd3gy?=
 =?utf-8?B?Z1Npb2ZpVGZNSGFLMHpJZ0QrKzdBM1h3UWQ3Wm5LZloxR1owZGNjVW5GU2Vs?=
 =?utf-8?B?dTlSSkdWYndyNXFYMFRYZzhqc1pyZmI3eUNFZ0JRVUd0dzBWWC82Tnh5a1R5?=
 =?utf-8?B?ZU1Md2M3VGJOK0JnTVlOMENRU3p1Z0pKZ2hlcEdoUmF2Z0Fpb2tORC9XNW54?=
 =?utf-8?B?NXRaUHRSSjYvcXhqWlE3YnBaSVRmNlAvQ2duTnMwS3RkbWtuZkttWUVCVjUv?=
 =?utf-8?B?ZzdNZ3ZxYittUENFY2wwM0dxWUtTOWtFakFzcjQxUlpUby96akFXWGVJYmNQ?=
 =?utf-8?B?VUNwTzJJWFRoY1RNWWJUdTIvc0VkdlpiVFVjbjhrVEgyMkFUSVhVUC9KbFZ0?=
 =?utf-8?B?Tk5Qa2I2VWNzK2R1OTBQMnlhei9TSDJDWmlQalZ3MDIrbjU1NjNJcXZnMjZJ?=
 =?utf-8?B?dmFLRm5VbkNUN2NYLzlyNHA0ZERRNjdjcE1LRThRNkgyRG1JQkgvNzdYU0tC?=
 =?utf-8?B?SUFoaWV0RkhCNm5OSVZZSmdiR3hBWjhPZmlPUVpyUFFlNzZQR05rQW1mQ05x?=
 =?utf-8?B?UUFTVmlDUFFkOWt4Q3hNa1A1emFEcCs1cEtrYUYzblFvRXhpQy9SMStzUElR?=
 =?utf-8?B?RHpJNTRDQnZNUWtxU1licEI1RzI3UkNqeXlvNzJHejh1VHBpNUZDaDJUb01K?=
 =?utf-8?B?QWx1SFA4Ti9NT2w2T1lhSTlMdi9CZHhjQUExek51T0ZHbWZUSk04L2h1Sld4?=
 =?utf-8?B?cEE0VVZ3cXkybmIyRDE1ZEpjYXpjMXhET3JlMVJxdExjMWVHUGpLODFNMnZI?=
 =?utf-8?B?VDNZNUxSQmtoUmZLYjdZeWVoOEZRNlk1cFE5NUd5TGNib2tydk5wdTRoellY?=
 =?utf-8?B?WGRuU09SMFFUVHV1NjcyQ1dmOVNUa2lNWVhWNTZielArUzZmQ1ZNUjJhaEM1?=
 =?utf-8?B?a3Nma0N6bmFOdEhEU3BwbVhoMldDa3kweUhGNHlLMWhEb2VTaEE0VnNiaXNT?=
 =?utf-8?B?MWhHb3BIcDlXdEdGVjJ3MkhVZTV4SGpNTFZTak5pSFl6Qm9Cc2R1ZzU0R3dy?=
 =?utf-8?B?OFJ5S0FXSWw4TEowdzdMd2hBSVkvVUdoM0FEN1NYQllETXVKTVhyYjBaaDRZ?=
 =?utf-8?B?TUNGZHp5RHdEZzFJaXJyay84RWV0Z3pENVBJNDhwb2RRYW1LWTQwQVc0d0Rq?=
 =?utf-8?B?TkVJcmcvQzBjblkxU2VXbUU1UnJxdHFwcXJoU2NQdFhyNHYzcGtTR2VNV2dW?=
 =?utf-8?B?UmEwekR5amszNlcwTVM0OUE4KzBVY3h1Y01iZWZaNVRlWmFmNlFIdE4ycEZC?=
 =?utf-8?B?Z291bXJmdi9oZktXcTcvMGdXeDJHQnBPaEM4YkpjanBmYW5wL3B5OUdwYm11?=
 =?utf-8?B?VUdWTlVjTEU1TDE3dVB4N1J5cytrbUlIUXA1QXkvQW50d0Zka25tQ3JzVnlR?=
 =?utf-8?B?TTVSWDc3V2tPc0NOTUFVRXRjYVcwKzRzc1ZuVEJsNFYxZVVvZHVmclJ3VCtk?=
 =?utf-8?B?M1Q2QXFuUGlydERUckZpUEJDNHVHTmJTY2NyRjBwZ04wWmJLYzhNYVB4VXFD?=
 =?utf-8?B?TEhnK3NDdVlJVGl1UGk5WE5IVmIrOUpGenBuOEhTbnpNSnlJckRBSzhXMit2?=
 =?utf-8?B?M0xqd2thbGhVd2p6VDNwL0lTL3NJU09MN09oMGNOR2RkUXE5aWo3SzBYNlZD?=
 =?utf-8?B?NDJ0MHgvOUtVS3pWa0hFSDZyd2xtK0FkR1NPUmg2RDVnUlp0dEx4SGIrRnhX?=
 =?utf-8?B?MDFPUWg1MFBzNm14MmRrK3NSdkUwMzYvanZrajI5b2NvVXEyNzY1MGhwZnZX?=
 =?utf-8?B?OXEwRnZyVDFWQmt1YUswdkRsZmVXQUdpeVdPVjFLQjlJcEkyR3BQOXN2UTlZ?=
 =?utf-8?B?K0c1Mjc5dnQ1L3I1cWs3TktPemFYbXdqYTR2MmlIai82bmtDeElaQmNIVU5K?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab8e072-1e8b-4338-bebc-08dce3b524f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:10:33.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqymZcQProVmPlqSydPlLxES2rWD/zad6yZ6MjNgQ6h+yBOIqy68j2zoiStWN+Yky7gfeLG416ilkjfcTcmyrj8PEW7XWN2rU+mvUMQhWUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5341
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

The help text says it must be a power of 2, and the implementation
does rely on that. Enforce it.

A violation gives a wall of text, but the last few lines should be
reasonably obvious:

drivers/serial/serial-uclass.c:334:9: note: in expansion of macro ‘BUILD_BUG_ON_NOT_POWER_OF_2’
  334 |         BUILD_BUG_ON_NOT_POWER_OF_2(CONFIG_SERIAL_RX_BUFFER_SIZE);

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/serial/serial-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 28d7a202afc..484f0f7d3e8 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -18,6 +18,7 @@
 #include <dm/lists.h>
 #include <dm/device-internal.h>
 #include <dm/of_access.h>
+#include <linux/build_bug.h>
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -330,6 +331,8 @@ static int _serial_tstc(struct udevice *dev)
 	struct serial_dev_priv *upriv = dev_get_uclass_priv(dev);
 	uint wr, avail;
 
+	BUILD_BUG_ON_NOT_POWER_OF_2(CONFIG_SERIAL_RX_BUFFER_SIZE);
+
 	/* Read all available chars into the RX buffer while there's room */
 	avail = CONFIG_SERIAL_RX_BUFFER_SIZE - (upriv->wr_ptr - upriv->rd_ptr);
 	while (avail-- && __serial_tstc(dev)) {
-- 
2.46.2

