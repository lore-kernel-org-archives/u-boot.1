Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51FDCAC5A7
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CE0800D7;
	Wed, 24 Sep 2025 09:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L/tjd00n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79C583544; Wed, 24 Sep 2025 09:50:24 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63AD83448
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uthwOXtquTtAf1xVJMEp6BaVbtVOuO+Dj0Y2JwwAQeR4YAuLbpLTc4DlgZxe0p8RLvWWr2H0x6d8VV3GbyFrDNQK736rCqi4dnKMsaC/F7Yp1nWLK9hfsEww/6Qb93p7jT09AcP94f1jTlaLnpq4Zlxcn8r14zIpMWDrJ8tJA5JlGnJHtePHjvTi7G6zUx36zc5ty0xFRr116As+ZwelEp9qCfwVm0I586h8jxPWaD0M9Zs7QN5iB//2C8znW0KUeU+nhWpmElF8lrVYjChhy81olBrquO7nEMB1xltjCxUy/wzr9SqEyyAb8xEpOjYLT3WEV3BJ4s67/Wrm6D+cXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y0Hpyh3ZeK/nL91Rjm75f1WBznjhmpbh/8Lz5mbYz0=;
 b=GgU44P8vgOeUeKthAc+Ppnhpjf/DBGSEXuft5ffFaQEbvsvglYypOoYpyXyzjMZcNC0YYjtyoe/maJWmowdmduZGK/kRxqUwwkl2uPoVorwclfc98VRAP+544mvt9Q/faWbY0f97yTupOUbdj9iaxIlCgflczQa1dQpxSXynVNBIRWMjhB0MCr0bkA9vA4jOi6RQjx3rCXDBvqUKpBafd0IFeeZxRq8BfC2GhAuR1HnksACTCWyWIiKd7+wvfB74I5DwX2Cg7wuDOorny3IvjjXHgfma1T7N9WeUC82BPO+Zbm9qYQFrnkqOOs6zLbq5P0rIDXvAe0Pv8DIIdrkpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y0Hpyh3ZeK/nL91Rjm75f1WBznjhmpbh/8Lz5mbYz0=;
 b=L/tjd00nTAKituvdJXzjsaiLE/KEXUczO8+dxUSAtWsYOXKOadhuZ0WXyc7ha6O9L0dvlR8ITPs2n+iMQB70It7/PsP11a2wSZWDPZLA3JdRUOyuPtOb6Qu1b8ES6F/kgyr0F6uAR/CsSlMczt2eKM/yhj7pprt/f2xrlZtIHtslbnU1P32VfpckBELE4urTDuh3E6BsdSlalZZ+DYboemI+ws4Ak9J/VNo6h3+dwt2GAgEw8y8OlpYnXx9xooid1+Ob3mKGuM5HfHNw664cPkRbSY8lvqtlsg+Xb5YGKy46+wfpXk3N3yQAFmgdTLipLw6H5ympL6kEbzYyt/SxPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 07:50:08 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:50:08 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v4 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Date: Wed, 24 Sep 2025 00:49:09 -0700
Message-Id: <20250924074911.15538-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f84c437-5920-4e2e-8873-08ddfb3efaf1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGBY1eNXUhKjxmWyxorsxaWVm5qGUHYy/6ZWsxevhu0659GKzk6OePLbi0g2?=
 =?us-ascii?Q?buwdqiUsKBAcUWHA65aTRpHtTEtRKTZuL5S7gHIQqt11TlSeFHpZZfv831vn?=
 =?us-ascii?Q?5VDnCMThHPaKup9jNJ/v7S2pVGBt7PvTO3TaoykaqxjtyMulzFlsYmMcHX23?=
 =?us-ascii?Q?26JmKYUZTJVHiAxHd13BV1vtNURYlYm2cjxjf//2Xit6GhnbemreJekYYaix?=
 =?us-ascii?Q?u6SKk95FaUVgO/pagsk0ec/XUAcgRu5+Wj70sFRp8bzyhXm6u7+0ZhRG2x2G?=
 =?us-ascii?Q?JmxzDLQ6yS3CTcKnAEeqoK6PILl9adg+dSsCpJjnqDILNMIxvnAgrsV9hjLe?=
 =?us-ascii?Q?H/t5Pi8OUFlRJG4B2uvjkWUZ8APRDGnTCEvgD3F/S/1cUEn+WoKALW1b98WN?=
 =?us-ascii?Q?LMwQoRHuEHbwFGpyqrSqHOhpTaHban5pQkzN7SZ+/FSGfpEXvLM7lN+o1lpD?=
 =?us-ascii?Q?a2gMbT5/cYAc3wGaQctsqZxncUxq+KCqH7lZwMmaGgNnn9uoMBXCMwYlRfnN?=
 =?us-ascii?Q?AWbeoT56IudocrmH2pqEQBdJNGWpuqvcO3/vbFMb0c17TCi2rGJbutcIP7cW?=
 =?us-ascii?Q?YVkMXaJ73H31CCJoVp1onUyZ8reCMnm70DgZOsR+l3F1cV11xTuCv81trSF3?=
 =?us-ascii?Q?lWx3N2v5ZXJ8B5vj/I0s2DDBPnm00wrpuqKw7+kUbnUsLHMja/DcgcBcopsV?=
 =?us-ascii?Q?nEkVV+XJjKW2ZuiZ30QXIPo0cavGXTsQ9L3Yfh5y+9i5tmOPSOfiVorCmHMB?=
 =?us-ascii?Q?Gctlmw0RuxVdCpFrCpx4pGh3wKLsV31wrOMJcPm7q11cgAIjD8xOKPDh42sJ?=
 =?us-ascii?Q?DDxAMDdCsBvwqyNhrVGy084A+/IlrVrDWta+STrQHKTmAVfECzTQIAg/I4WW?=
 =?us-ascii?Q?CouaXzob3p2bKMr3Iqf51dPQAAjf+WvPhJC+euxQbcOB+bfdtjf+F2ycjc5Y?=
 =?us-ascii?Q?NCENhUo+R7O8zD9WE/MD765ATPQiII0YYQxgNcnKfWH2E13O276HVFbRPjck?=
 =?us-ascii?Q?SZqtMa5kEbTKm2UEO8Rr9//15RVow/qpbtQv06Uaf8h99oWqRf6AfpvCzpEx?=
 =?us-ascii?Q?wBnc71aHt7NxfTs+dOerWgnUTdJBGCsmJJbdM/q511Z6oDibYMcur6PliUF4?=
 =?us-ascii?Q?fkTfBo4TnqDbMq3Ad7V8FHkD1q+Tx2TTAeHO7QfK8XqFKFNCjt9zlLZlf/gK?=
 =?us-ascii?Q?7dsKelStlPJrjl9Ua9C98TQzMhhin8RjlVzHDY1cNqUCI5TidkoMw6BgnIfl?=
 =?us-ascii?Q?acMhe+Ehno2TJ5AXpJw1LVvRafme1dtnok16JUeffD5lw8CdY2elwb9jypD1?=
 =?us-ascii?Q?emtnxTz5hmcx/UWELVK55LxruBYw9cC9DM3A/jxB3ZXOit42oOjnSNyrxI4L?=
 =?us-ascii?Q?1B1Kj2rOc2Vg6ogs9Tzkn1VEgvNyhEINj2wYFIVDejSeYgrcW+d1hLG5lEg5?=
 =?us-ascii?Q?l7c7Gvz+kJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2NkIyKXIjdCEZYBCjATYAzRGgmPcJewJkXx7UHPQpUMGJKre4GBW88HcTN0?=
 =?us-ascii?Q?94bIYSnVBfNcDfu/0ykyvKjKiQLQg4MTB5jjoWs0ltI05+mKWz+M4d2Im8bX?=
 =?us-ascii?Q?9SCQCiOnmpu18h7lFYEsXpIzFdaHzIJpGarA55Q3w+dZkOH/5Q8sQ9Dd5q2Q?=
 =?us-ascii?Q?4IlvaP1u0cp2CceBmL5MdLAHW2YiGGZGUynGEMgFpPQl4L6bcHc0Kr4Jvejl?=
 =?us-ascii?Q?6/oY8aRPzjtGXlA5eyi4RVZLNqG3Zc1UKY8BTqpmcao5AC0FXRwpZdDlxB49?=
 =?us-ascii?Q?iG8kDZgOV4Vst45ouHMYnmp9dB9K7p0gZ98+mYcVZuVCEkivqLJXSUcBwJaj?=
 =?us-ascii?Q?Q5wDNv7oHEgfh8K4vxAXCmTwlAByYjD4fUdrnlo69twFw0PgfiAXRtmn1GwL?=
 =?us-ascii?Q?kGSlVRyh6HqAAL3nU9rfDgMaqoVJKFbgQW0zxjvkPIhHauX/prZBI08P9V9A?=
 =?us-ascii?Q?lsws2lqMvyeWMCrpdTISCjr74arW+N58I0iFfFi/J+6JDK6x+44v5RtWgJ9y?=
 =?us-ascii?Q?htTqkGNxN+wiIEnQ76W0/Y4YkddyOsZoREaKL9zYs+BTHoPCyLAXXqR5hjTx?=
 =?us-ascii?Q?FdQCBMvXYIUDve2GXRKwL2zRLARZpOa28ty3aYFy1l6He4Hs8CSN4xFs3PHy?=
 =?us-ascii?Q?DyruYrhJnUcoydjPA8hj5ZqlCrM+vRnuoRIOVwPuuSZRVAqW1/rEHCwCcy7c?=
 =?us-ascii?Q?xXD0CLz5yhH1oQ/ith0yGI+WUbBd4/ElJicbnKj1lsziyAn4W/fXgUqrwKb5?=
 =?us-ascii?Q?WSjhv0KAqjU0n5xwK1gD8MwQduz8bHSVZ6D5u6iT0bME4EONUL+NB+JMU33D?=
 =?us-ascii?Q?tMs9sKELZWqKsZ8ERB2/7WJdQNsS/jFS18k9oRmQ0rh+NiRjYCMrT4FZEwHk?=
 =?us-ascii?Q?pqMxwMIp7wSIV2cWz/U0YwO05nzxM88YRCTR8G0J51Z1QTvH0JarKlnoGOrE?=
 =?us-ascii?Q?MUK0aoYgsGTk0JvseuH/bg2jdS4D4F13elukFJBdZdkJ+2OKH5jRnWarePlv?=
 =?us-ascii?Q?V9P7T4RaO8B1I6/gAOZtRJmai6ij4L0kYL9S4oJM00YXmtjPh4fByAkylmn8?=
 =?us-ascii?Q?SUmxtVdq5KJEWTOKZUMcpzW3O+/PwF6WGuoe22LyfceM8vPS5JJ2Pxq0k7IZ?=
 =?us-ascii?Q?d4X+KUd5rxAzToYaSdhFR3xQ9z8042Ughc3L4HbuiIvRxkmKlFKHv9CvN7bw?=
 =?us-ascii?Q?wIhaXpxV6BmuY4O4HhAvH0K83q4lS/M+xDKcNYb5v2GMEUCDgJoO+abJoU2Y?=
 =?us-ascii?Q?iP8kI/kvkMaLJL8ag55apIRQYK2mOb/QU7ONMUL5CHmyHM+7UtRkwoUJ/4hB?=
 =?us-ascii?Q?PW/E5h553lJ2s9AIWnMxiVcCXjladxuAtIl60N/vx8ZoiNYazMrGM+8TBg4h?=
 =?us-ascii?Q?6NlHjKBjzko4QUL7ITYj7F+geMNw3243Iev6ZY1pbM9NZ2Tqn8metD6GPBCL?=
 =?us-ascii?Q?7zp9MKE++eDmKopDReIl8+C8TKePmw/5sXLWXA01DAS7ZTOek9hUnaSO6mnF?=
 =?us-ascii?Q?elK6sSgcJuepA5C9WWiYuwvnxAt1aY89Un1kK4lRcmdydw1Ux2ZRMRm86KKS?=
 =?us-ascii?Q?KN/7XjgwvqB8h7sN4oh3TB6xccQElRDJPiFYMmP8IQIbQuUvr5FQ/OROhUwK?=
 =?us-ascii?Q?e8pEOB1qweS7wseeKjzsA1I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f84c437-5920-4e2e-8873-08ddfb3efaf1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:50:07.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/7bj+mmnGiGlB996lTkI8MwlSLy0VhcTBuuFLF5wxN/TZXbpzuYHrcq+cq9l2zWOaeVAgKQ12ClSXr9l2hwfXP8cetpS/LCWvi4jEEtyh7R9+Iqce8W/cfBSz13GTK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
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

Required USB DWC3 host driver configurations are enabled
for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index b373201dbaa..7cd2fcbf4ac 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -101,7 +101,9 @@ CONFIG_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_DWC3=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

