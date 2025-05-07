Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C6C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12664828BC;
	Wed,  7 May 2025 14:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="D8shta7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D472F820EB; Wed,  7 May 2025 14:12:58 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1E581F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csghwJZkGtUZPwOmdywb4bLo1QUzAz8Objyqv4viPcv7rUoVfrtm8TqLuyyZVoJHLwyiq9NIqX55VkF9wAcQ2pqrLIzjqUaHDWNgKDByJjRcWaEWCmDAdpi7o3Wf2/NSmokdB6lulovdc5PZzQQRYt9sqjLui9/46aoCo1NjrRejvIQW2AygXa0hXt5AKkbTzj9DuewL3MS1NYQhrWMKCyVg4tN8N/j23lvfR2BgF7MRDQD8RCNN6QzmSwhndUp+yVOqB8RGwlFEl4nxEN3RsrxK/uwmIgRFCEB2X+bXyxrT7QhAcuazucVzmrUzGBBAwHTjJe4ufF30wTrQ4xQsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBOyRL6OlpVU5CXvwA8HywUokur1nCea1Lf7yw7o4ow=;
 b=s76UhMro4pGhLR5UV68lHQ225+ACRY0qPPr3tVIscfzJ3IFOdiv/73Dy44JeUUKGTTfIZjhUj0MX55LGuF4mGt9WB3WcAzriQE1yafKol1Kv645dzsE5N8ld7r48w3g6Sjxlf+31MqonNzcdCgtOSESWAbXeXc8+0BfsP1TE7s4NjKceuoCL3QI2vX94FvEw0xQsTz5Fz/qKSfWGuqjjdHhTFYpsSRyCoHI/CIMZUB1HMLUsrkt418Mz6PVpc5CxckiqRnpSPppuiqVSHI8wxSBeBneykbrv1y5hXxSMD7T62e2vueTqhUwmbD2jfOc0uF6DxhY6S32ZgHYDxvfC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBOyRL6OlpVU5CXvwA8HywUokur1nCea1Lf7yw7o4ow=;
 b=D8shta7IJiPIH9RiJm/iEyegBpFeDSi91LplrTcP+SphNynqtCK0G+qhVkq+zSgQTRFBOLy235VE4KdHyqD/ZAiYQxNzPF2RmqiXvE6b17/7zwlegViNjEi7aOBkZEtWPyNKpIyVFX533/r0KToqLXzgBtb65GxAS2Cr0NVBHDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Wed, 7 May
 2025 12:12:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:12:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/4] linux/list.h: drop fallback definition of prefetch()
Date: Wed,  7 May 2025 14:12:46 +0200
Message-ID: <20250507121246.518691-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
References: <20250507121246.518691-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 140d77c7-6528-4e43-b0d6-08dd8d607ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLV7Y5CJodPP3yf9f4ubjklrIx4oPcHoWHxVS7femC3c+mhdBiHUK3sqA1OR?=
 =?us-ascii?Q?r4md9CRHFpglvLlcDtBevsQGZl4Am2lv0N1XwGqgdVovg96R2COTA1NQAsvd?=
 =?us-ascii?Q?4oU2PttmEs/Y/qhdfx3H6dCNmhTBtYMij0Qz2RLSeCkC+jOVaKzl3AZRpIkS?=
 =?us-ascii?Q?01bJvRBwS3MwHbaPUY3yAOPNN/n9QcGUbjrOW+MXdkMPHuGV6tZvy3pxfQnf?=
 =?us-ascii?Q?Ykzt6+5EDNiH+cjsnZ/OCGbG866OOyNUWMkotbbbNH5Lv2Q1zRwkXQE8Arbk?=
 =?us-ascii?Q?REQ6Nl0FweBPICg2TQMhRg1aKiBPwNFSHLwC8+XhfNbpNQc7TpaQoM6C8A6z?=
 =?us-ascii?Q?6nTJUOjU9oyjct38qii1iGIOHEXMdizjV0pYsVqyEbNiFoEqjbQ2ftKatS+p?=
 =?us-ascii?Q?uQANYGAmFVSkAvc3n6DW4QMjdSCtGDrlG20+J1A+bHEL25S9L86oD3h4GlWa?=
 =?us-ascii?Q?EI4sKMD4OWPUmFUCYjyBfO0osePWE2fn8v5qBH67vRyL/VOsa+MmYy58rqa+?=
 =?us-ascii?Q?IHEM8HmeOeGu4qV08mIVKG1QROi9uf4fTH5wzQswFOIXpI+AWaVhRikm7efY?=
 =?us-ascii?Q?hpqyeBjrqwvutU7UcPSFO5QXOSpMqITURlCafl5NGxGUL/UAeV3F9HswLnr+?=
 =?us-ascii?Q?3Vi2fRJgIbJFO4Yg1KoS0QAS8hSHa/Ad8m7ZlPVwTQHgEbfjEV+ntbgcRO5O?=
 =?us-ascii?Q?64G+fvjDF4+U60Dr5AUCFAjxHZe4QHpZNartS2mrHMQkwn5qY7x5HysQuKFy?=
 =?us-ascii?Q?ue/9o2FVH/N0qkwSGi27NnZoTrM2xcJGMxN7z+3h8TzcqavMx1sF4z77FCVJ?=
 =?us-ascii?Q?2N8fFL4ZaY8a3PRl+CrpDYD2hhaGYfkJdAb4fGgKnvvKNyzL7Cqaknz1J7hL?=
 =?us-ascii?Q?CEuKE5Qkwb3Kwo9vsEYWH2n9qP+7v+Kf6RyHCRMvhM61ZQtgEnsLXxDXLEHd?=
 =?us-ascii?Q?cFRJpSUi8AcP3t68OMVmPyrDbdJ4d/IjdhVL/hEnOq1o0J8j2uOGRZH2eU5V?=
 =?us-ascii?Q?g3JJVvJ1YXPP7ERGjMvC9SEU5FusfG7z+ueEOfNiIlHzOYW4sXDm4L0GTWF/?=
 =?us-ascii?Q?yKVWpTmpd5osOLAo2YAoUD27n/BNMTcGYG68sPqX+yjD+7J8auIfE9ei7R21?=
 =?us-ascii?Q?cbzOp8VnHtKYwH9xxk88ktrBwBvWoRYRE7tQIQNC3Cd3OG3XRBupBG/DG88Y?=
 =?us-ascii?Q?647MpNaNPCUw0FA98YXAd2NB09foOP67JgpHF1a6Mp9+qZbRDISlXISzhSSG?=
 =?us-ascii?Q?wLq7xF4ylxhUv4KAwoXRAMjug5dAqJvMuN3mAxta/G2VNw1MewPV591CCLNr?=
 =?us-ascii?Q?4qf+DmSwCCyBUI1vQtUBB2S9wQYmNvcfAJef0dTz6ZhmDrIJ1UfHcb6wf+w7?=
 =?us-ascii?Q?iIBX1/ggXBaIPD8mSXr6ddmuHZ+n/oih17XQ0UC5WSTzbGdAp+q0sYF8spyu?=
 =?us-ascii?Q?BftTaTdP920RD32FrJ414bmgTg1rqivL5lYIKwyJbxT97xdTOzTNYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8iUtp8w+RjCdJHRGpimy3N2mHn9yoOpP3UkH1vceeSQ0Zn0Sv/jjYeh81WX?=
 =?us-ascii?Q?X1gmBpr4k6iE5SEUEs3OtpTEVR+Fn7sJ7ghR2REiyJfaTYQ9vd0iyShV9tQG?=
 =?us-ascii?Q?LwtR0F14MP8O7mw8nNGRQ5ca6athIzKIoBZPL2/n57c58gF7SApz+WLVSedM?=
 =?us-ascii?Q?dX/FKg6Fff9Dotg1zvwYNPwKZs+sjwI1Gfm9Lyl1oj9ceBp0Jg+UAX4Dm1yL?=
 =?us-ascii?Q?QfiHBZOJmeIPk/zO05LblyZQaF9fIXNQkiw1QNdj7nfjfSy/vjBL9IGE/91d?=
 =?us-ascii?Q?6N8UlpvzR9kBzK+HijOL+nyxTvHjQvxRKVqIgx8IZccl1rmHnYsdLV1BavuK?=
 =?us-ascii?Q?T/PAbMiKCpqiNFT5z0evb0oxLMkHvLil3ZGTNsx6LO78BrWOBT46d6UXy4+P?=
 =?us-ascii?Q?m6Pjhl7LEpJzm1KqmDCDXabe7GQhCO9qlRt+oBLd2AAf57JNqwcHHnRw/wo6?=
 =?us-ascii?Q?d5w1ceh25rizfJnQX+xRODeeJrsskiONy10s4cManTXa/KtfwWgm87lMUP81?=
 =?us-ascii?Q?AgEwNsuZqe+oKw6NuwA4QCXj7/YYDm4pLAy+qcrCIaH/SR34PGLABZdjEL8f?=
 =?us-ascii?Q?ulblM0AOFXE5ifQ8yROD5Tq3Xro1utA3nSCye7WYj7t68P0p8u40MDMBSXQ5?=
 =?us-ascii?Q?KpCPUncLURI+TGknIf2YP8FQk5KZKxLhO7659tV82EauSpWT5Da3m8BYuRq2?=
 =?us-ascii?Q?IvbjRq2f7sBQzKpgCwK7SH/84kJqGiXQlOdXqSg4xQZ8yGElqgxqjypzsZDG?=
 =?us-ascii?Q?w3Fu+5+6tyniZ0E7Yw3aiJZzohTCZoiGCDaGIlb3jQidHIm/HMI2aKMKVm1G?=
 =?us-ascii?Q?0xyltNm56rLgjVP6hIcP8sMyUavDVzg2B14EeNI4Hi0QWJh8Q8HW4F0pZOQz?=
 =?us-ascii?Q?0WehibgXBuAZVeSaM8wwNmXzPPmZilk2VxsjQ2wAT9RgG4D+GPCRhzK7WiKh?=
 =?us-ascii?Q?5TJ7Fbn6TloAgcBZ86er/SjWtRItns2QeFYhSecjOjtFbUtGlhLHNSqhbmBv?=
 =?us-ascii?Q?/Ce7CSof2MjJZX7MO62posuNvlJ+0xzC1PJPMltMWcycC3OsltbNYiA/ss5H?=
 =?us-ascii?Q?F+e+NcCrwfkORbsH1fsHMAAMR2pOXXJeWC9+XFL9869DZEKDhIp0aouoZ+5l?=
 =?us-ascii?Q?SFs7t2ONBoYtOrD35bmW1ihR3MD+8XEM/OG72FlPbG7hHE7Fztj2hvK7sTlM?=
 =?us-ascii?Q?5VJQ/SPtRGoHSM+b2Si2TvO2BBoGuSPTTphnrHn823jCSdq1vkCz/cApR6hw?=
 =?us-ascii?Q?Lx+GS5Q3ceNojnH6mmjD9ChNHN3zo2ChhOuePrzJtwaiQsKgCoMN4lTC31P4?=
 =?us-ascii?Q?kLZi3drX2K5cYDdZEpCCdbt3MFAY7myr+O6W3sW14U31m/Deo4fxy9gwLMMO?=
 =?us-ascii?Q?weYhghMTA9ydCAHM6bs2Lxk088O8DnH+mXhl9SKxcZxHn8oHiMBjpicR3O/3?=
 =?us-ascii?Q?yGBOkAZrZBYy9Kg/5Ww3rPLmkrEvL3Q7ucMinJeVMYtTtQq+y7tR3EIyeGcv?=
 =?us-ascii?Q?Iud/yKNA5KgWpYB177E5dw2znYpwwv+An3nGej6CDfpvkHBl5VK5BiOTA1uf?=
 =?us-ascii?Q?mbsgxNDd4NtybdpwFB9LY/TH/eF1k0QJjftsWbRqCrNgud3cOi8BPTVJi+/w?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 140d77c7-6528-4e43-b0d6-08dd8d607ef4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:54.4431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKGZQHOkQJQOonuvo1gjNNCXkpFxCha6nJYqYOvHv+L2UCcypP776O5/4mqbA3ppePOeucEaKd9JBA86GnK1E12NWfdSDJFQR4DcObpD/8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014
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

None of the list helpers use prefetch() anymore, and no C code relies
on getting this definition from list.h. In any case, such an arch/cpu
specific thing does not belong in a header that just consists of cpp
helper macros.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/list.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index e21ae03b208..3dc38279716 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -4,11 +4,6 @@
 #include <linux/stddef.h>
 #include <linux/poison.h>
 
-#ifndef ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCH
-static inline void prefetch(const void *x) {;}
-#endif
-
 /*
  * Simple doubly linked list implementation.
  *
-- 
2.49.0

