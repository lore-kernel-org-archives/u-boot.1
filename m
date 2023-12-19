Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993BBC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05802874FB;
	Tue, 19 Dec 2023 12:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="b1l+WsXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384D6874FB; Tue, 19 Dec 2023 12:57:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF86A86590
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFVFECx1jwEEUxPeM/ppVSOkrZVavdb5cZT05Fd5w3XhE1teIKN6QskRO7LdM2SOpj1ev+juCaz++oDBb/ZnNq1GECcuLEM4a/xZlCFE8WpTpO2symtOHm216w2dS1842JWHzTvy1qJWyaMM5UUoFG+nT+pYxNt0U9tCr7A8WOudIeDJJwfMG/A+AIx9DG0G11U1XBTir/cZvd8Awq38U+HKDtrJo74hhw0UFHRtkYFK6LT7RONA17CoKnEzNeyvHCHL3vKsu1AhryJrUIthKvif2yvUnT7Y8wtDovvXflaHumFJNAtsQHRJ07l63A5GrAaPZGEwdm11vkt6Qayfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyKl+Aubc2HNVbJ9/51Ev2nBAgvFxzkYIJ9+Zv/gY5U=;
 b=kPxfG4rTuH/HW4V10qs0ZtqVwsMRtKZ8Sdy3aIwQQKXeCLr9DLCDmJuKYEj8jsWXFa92uT0+pYW5GhfqeJ19sDE2zP2/WEBRVSiN+71ST0K04R4m4/O115fjhbLVEoqepkFN/PXRM5w3E+3na8WciTFi26WrQeSQJxkfoqiDvb0nUCVWplHu7cEjzzH7hR8ELn/ambs5qBjr46FINeh/diU/fgbthoZbXGmul9nBXlvdwN9WaJRIw3f+knkdPv/Up1/rL5QZMn9Bhe8kKhfS3Pp3yh32caGksT2B6PZWcrSDAdGP55FVeepAmq4b/sIYVP3NC8Wvfs9xeVZqgqWcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyKl+Aubc2HNVbJ9/51Ev2nBAgvFxzkYIJ9+Zv/gY5U=;
 b=b1l+WsXSlHTFed0/ayEoS8ZdWirwC/BuslteXZ1MjNVVv2L2YtUHAFw24QFSdWsOv+7kOvbuTxw8xuzepiHY0ylD+aZTqgXmSz6WWNpjgs+t/gNJfwm0y7AkiHmKqejygkX7aY9v914nnM93BAxfmWX7DtRgJt5N59QETaLjRPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB6324.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:57:51 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:57:50 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] cmd/mem.c: use memmove in do_mem_cp()
Date: Tue, 19 Dec 2023 12:57:41 +0100
Message-Id: <20231219115741.3681175-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0cbe8a-3d21-4426-835c-08dc0089b9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L0zWVtZuW9+Bn45/6C9eoN1hhNbnaAtRWQiuu2Nvyk+W1BhzzUcbrqlKZ7qSuZ8JDZ3HMx4UNN+ZBJB8ctvc8tSKkXdGtwyFfF6GNKs0zecppG/fZlKY5FwYzLb8ODyqN20Idc0HT4Geozgx/KVQoctAHQBLAU20q4xle/fEBNL5D3rxtiuj6G+rKZFFpB3f7S1JSPF+48t8v47U0ZAdzKCRS30bEbjlKW86fPqFciTC29mr/04tQvF3hKnNWBrdFzHvd6tcHtDt5r1n5gTK7oYtQ2KcNKRqov5OokhMSJFpL/1wnQETcdNm5BTE4bdATgtu3uvhO01mWtO0uSgUBX6BSjmCbUMEQq51MrtQnOix6J2gyuay/dvxnmk/Reo1K7GqSH0BPTC9IUFj1N8SUC3gqf+A+ZNcBHcjB2bg+fn76RWcLXp+y11yOSvbYG+L3UONjUlchjBWSYJZL6YqrEIy01Rk8G+VvJ4VwpiKjey9ZrXc5vLwuZMMrMNQtNVGQbQrq37xCJblZEn9Et798zhAbebGk5Es45RIDYihgCZWwVsrpRQkIhZIplJtm3LlY7jGJiH4gyF7DdtGm0nXoAuZKyGA0/Nzp4juNBqH/mYFyVLPXLk9O6MSZOTZ6Mx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39850400004)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(52116002)(1076003)(2616005)(26005)(38100700002)(4326008)(8976002)(5660300002)(44832011)(41300700001)(8936002)(4744005)(2906002)(478600001)(66556008)(6486002)(66476007)(6506007)(6512007)(6666004)(54906003)(66946007)(8676002)(316002)(6916009)(107886003)(36756003)(86362001)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VeM/JQxYt65N+bqc4Vm1m/vEKcEhgspCdiIp1oACLPZZu1rYPF0qfkrM6QB?=
 =?us-ascii?Q?e0W5FHQPZrSVZshNqy0RRTkacN98LQ2RiU+y86yuNm559B7oiKCclzO3qfpM?=
 =?us-ascii?Q?wt1TXM/2Ric2lvBWKVRET4VRf9XtvdEAEUXGtk/XIK1ZUe8I8oeiycZGUZjm?=
 =?us-ascii?Q?mTPdt8uGivZtWskFX1cKUe4pFEVjSnVrOrnpq5I8jpproS9cks2HhNwK0AzJ?=
 =?us-ascii?Q?fvZFZwXCsqHTss3R74ZD/T2E7KhNS4gZo/mWUJIz1CgABkksVHb+vb2/5yPC?=
 =?us-ascii?Q?3b1skCANJSEIvpOuEY1A56/zmtBSNf7fIAPP96ncXbyKebJXtJe43x5VC24A?=
 =?us-ascii?Q?zYEcQ0hj4NlmxP+JmFYViW7NF7DT/hXa57C3aTzEY/6F+2oWsK68pHUoHe+o?=
 =?us-ascii?Q?R6inhexFwCldkUnFOJRBKCKCH1HSrneVmhPwZidslc+J7Fx7YYMM+iQ2EwOE?=
 =?us-ascii?Q?6aa8kU8ReA0KF76q3MpfM5rhu8gHafr1720bQ2BN8KSKPXKkRSNatlmsiTov?=
 =?us-ascii?Q?4WiXVAo03DJ3dohVxm2xDWDx0+hL5I0v9FShBpSRNFXFcxeZgpw9F7uJ8la1?=
 =?us-ascii?Q?EYU11r3T0s81FoPTCrQJ8bg/imyvJIIr/SemK9vihlrGQVMohHmpJC5u5RWi?=
 =?us-ascii?Q?oX0CaiOBpEV4c7ZFBDYmInMag8gyIg6ONalhxoOF2+4kMS43dJ6WdTs5ziRz?=
 =?us-ascii?Q?0Fm4jSLdaP7+4JhalpySbjgFcIyJ8RQUogm+uLAkdUC44Tvg5XOUEif3WzBJ?=
 =?us-ascii?Q?Sof4Zuh46zkkJk+La6AnV4AvNATX/V2NIxMs3rmEoy3wrJuGZLlbOhz0a2JD?=
 =?us-ascii?Q?eMm3sd0Z17aniEHt/mSdPnG1leK1YYSwuWwo80X9I0ZRpXAeebM9GzalOek/?=
 =?us-ascii?Q?ksmZZoTQ4ICacOFWLewriRjEOW2CNK2xHhpI30CwGmANWVMp4RDNL7PhRlyQ?=
 =?us-ascii?Q?KEdv1ipPwR32Rn9Bd8EDs7kOnkEUBTLXyjiZcPGnyQLUuSQ7S6OAlDghFmCI?=
 =?us-ascii?Q?Ig7ceAc2fIgO0z+Ml7017QJjlRQpss8ehczmooVDTbuI6EGvp+OOGNcYEa0e?=
 =?us-ascii?Q?ID4WUpriBSdMk/41coWc5EoLGV7RiKkmrFCUrK+IFhDaIKURxXRi9n+BWvhY?=
 =?us-ascii?Q?e+y0JZ2XqKUS+5SrIwH3PKldb95GO9ia5HCoEDL6K/6jnKnPcUHjPeHu5b5w?=
 =?us-ascii?Q?8zMFy6ytlCOJP3TG7rtD+ZWAfNIk11ZWbaqiBCxIOnlmeBK1+9kHCQq6iK44?=
 =?us-ascii?Q?Wdkj9KeFSz7CtN+riBxBva1erVIgjtKbkrJjACPJEkQuftT0ZITIX7hH8L4+?=
 =?us-ascii?Q?MFcnUeVSMWDfDs58BK1L+A0QgIo52AEczCKXh62pLc5Ry2fRDIozZweNGlmh?=
 =?us-ascii?Q?RwDUfPc6hpS+jnSfpcPys8dNClRwg2Ijzyz7waKU16nSuwfi3em1f8kaM/5Q?=
 =?us-ascii?Q?Swa11th00M8sVCRQRRqaU6S1/9X4jFhvVSeo1qqVJRDq2vvLiHpjrnHy45Ff?=
 =?us-ascii?Q?pIQgHAPaKObQwtSbEo8GX0foRVXt0WA5mlF9T5iwFABfNh4r80Edq7il58aQ?=
 =?us-ascii?Q?3NeH2FyVw8Adxv0IZRLQUE4ObA5LvcqTsQiNSdatbTIz12eHJTU2qXAYde1Y?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0cbe8a-3d21-4426-835c-08dc0089b9ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:57:50.9205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlw/Mefoy8B+3O93tAXqr/cu7uk+mCvZCD0oRI8Tu8xPyQ7ipyXOHznE8rGIdMnyWqxknTjQfBbDu156oOJEA/s8OozpuILFhklWb4JAUqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6324
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

There's no 'mv' shell command for handling overlapping src and dst
regions, and there's no point introducing one, when we can just make
the existing 'cp' command DTRT in all cases. memmove() should at most
be a few instructions more then memcpy() (to detect the appropriate
direction to do the copy), which is of course completely in the noise
with all the string processing that a shell command does.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 cmd/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 66c2d36a148..c696b92a274 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -361,7 +361,7 @@ static int do_mem_cp(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 
-	memcpy(dst, src, count * size);
+	memmove(dst, src, count * size);
 
 	unmap_sysmem(src);
 	unmap_sysmem(dst);
-- 
2.40.1.1.g1c60b9335d

