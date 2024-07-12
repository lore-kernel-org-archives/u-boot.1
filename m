Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CDFC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9419B885EC;
	Fri, 12 Jul 2024 11:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RD9yTcnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DE48876E; Fri, 12 Jul 2024 11:07:24 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B579E885EC
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN8YtECLyb+op2ha8knJ6jAtAYUdRyfH8sxOMpH/d7CYlFTwK4WvAz3E4/N90sYM0x7shZP6lefyTjfyCkTcQigA6f6l5zQS3g6wFFuf+l5aaopZ8zUYymQ+C/kC7zAKfpWir32CL8xO5wdGxiG7NMQaptOUtV1HkEML+8tGFGMyTuUfhs7E9vOx+g6kmF80ob5G5wjWg5VPiulPchfgEQ+QFu9aNCEpL1gfoANRfu77xHCLNqCassujILTfazLS05XnyBWbSZejxg73jMZgRQ5INKFoerwX4ONtIaDl5/prJ55qVFw2zdzIWAPHE8cnTApTzNU1bPl9BrJUQf9ltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+I+hDOJHNw5X+5iR8+NrEMBvVOyF4DCmmB9HburCtI=;
 b=fwaJAIT8jWRJfPGRBuElzqkDclailJhcM6JzYxHADZSjOVCNKbLN4jCBTecdzcR/wKtNrRL2Qltk3e+9aCeT9aRJxe8oiE5RCJ8aqJQzkDXUuCn7sfZrmvjQnLZzs8HgRt83d6eH+57u2HOb7LWFG70oLjRJgawhqDOoTGjFjmVMTb34MPrZmvKH0C6uuHGSdvvqznMuPFmW6Ba7iBwdn9vaqKzSKnuvxgturLJazUvgmVkDhsiXAZAtL5J7eVGx0KkKjYqAQQAo5JJvnmGOPEhmdaO48H5F/WeKFIQct/hAUyJgaU7QnCl2fYtJBXJVpoBZkAPLTNG+Mzlm9xxLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+I+hDOJHNw5X+5iR8+NrEMBvVOyF4DCmmB9HburCtI=;
 b=RD9yTcnVTH55nudjGjQMPDel9kQjUJfI9DmVo3QnpZkTXG15R3S54qkWRfasqZP1DQeF/ukJgTI8tlcoTQzBGfMP1EZkLUNPZlOXR7n+RTUQHVJVZpSH2ElJUWvC5PDkBe324kwe1CEtyK+NtJ3zB2xONKaCzVeD4Estr2/KQUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:07:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 09:07:19 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/2] a little RPi watchdog cleanup
Date: Fri, 12 Jul 2024 11:07:23 +0200
Message-ID: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cfb8e8-bd42-439a-1040-08dca252085e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/l12jnKwUTVRmRbK9rd9cl/gRRUDhWYwKpVsxY07+eMIQQC9IJUtKd4sVNmJ?=
 =?us-ascii?Q?4WUgpK4vE/lVOpXc7F4cgidepNIqV+vztA4j6jXquFXBuhH1qMOMSk2/hyWh?=
 =?us-ascii?Q?vGjuPBjcS+yHz7efbDgwfUP6o+uCHvSSmLtuPGnizucc9Cf8rcYwHKu+sno0?=
 =?us-ascii?Q?dxs7wTBZqd8csOZ5+L5LXf3m0ZYBH9KkHEYZXtrvILReXRDVpDBFpZKiakcm?=
 =?us-ascii?Q?JgGRouW50SXlnMTULHjeO/fEwsSn1h+RX7654HfOHLSygLipGhH0GuwoEird?=
 =?us-ascii?Q?GF8qusgDmSbmBIHaJIutW8WHmLcJ5WbnPk0YJxeBdvw5rmYtkaVZO61pd+eX?=
 =?us-ascii?Q?r3R6rnzEvtFpuGsUYVos+oQtHu1/NYGr0MQCziPXEFe5EznvdRKnmrYDH8Ah?=
 =?us-ascii?Q?+SKIy9fMzmjf8H0ZN/myrTb6zODUF35XFJxYs2U/6N+vU1a09c76pzAhXvt5?=
 =?us-ascii?Q?SNRpzH/sEjyBSHSEFnwMhqv9xs1DAavQ/d9Ovaakm/BLvPQKYYFYRqAWKNAy?=
 =?us-ascii?Q?WarfCXHMuRvYJjCTIdCEr0SlgeoQ4Tq0Je20wO2GD4t0Mv57b7LdsYk1LfNd?=
 =?us-ascii?Q?IfXd5ycMxpTm889XDE2HABZGCRvLV4jHnatSD505BZT8UQQsFZQxoMIJn4Iy?=
 =?us-ascii?Q?b7NyooGxAzWK9TN62RmIwuI3rJMDAM0PDLKupTOlJtFFk/8jrUNqyKf1B9L0?=
 =?us-ascii?Q?R+reptYU25dOrG6jwDaTJY+22gCp2JrimzITgsvqbakiQOPuAWOy77KKRfOu?=
 =?us-ascii?Q?rUfZCF0P6/Kgs5SOWI/0BSIqxStFKBX4Y+9FUbN5PMB/IVe9Evlz1Y7g+8eX?=
 =?us-ascii?Q?dKLEeALKUGfaAQ3pwJPGNvV4X+vcNXMVnu63He0G89a0beXRouSUm3yna/gQ?=
 =?us-ascii?Q?aeq7kbBCr8kATkqLhvbW5/tzxy0D6jw8tmUYmAGr2uRpQQ2Rd6gdtUkguXTe?=
 =?us-ascii?Q?pDIn47NJbss47F1ax9nFyHxG9taqWGmD4izcCIstR01EsmfxiIBCGO28G+6/?=
 =?us-ascii?Q?oIYtVRgbDxuwWzlzP1Ck7Jp6B8/+0KU0q4qpGg96dg2b0Tdds6vhZGkfql50?=
 =?us-ascii?Q?bpawxsmFzM1dUNBIrgRDusijfhwHIHWECqveIMoySI0Y86ifOXui0wjCfNuG?=
 =?us-ascii?Q?Im6fplJhryezc4WMxpRTdmn7di6tD2UDBjlyOK5AMLDNyKdfuYmzKqaD4G9u?=
 =?us-ascii?Q?66yP1JEX3qfebtybK62I9iBEoli2qkVWIrBhvib/HcmEugp+v5WAYK4jXkpJ?=
 =?us-ascii?Q?ThyibVkrKG481Lg/wF8wT6gpwku2bP9P2eE02gVCuBScXG1gCcEewAWvlkJR?=
 =?us-ascii?Q?a/TE2GQUTlfehezxyCz7f5/vrSXDnM1FJhcxQDmVfS0MxZRUJzjUwzEXkXO/?=
 =?us-ascii?Q?4H+s37X5J14d13+mPOH7fazHWz+whyxfnOdwLjFzfmvdiPFgkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B+na8v2P2zcvc6aP1RU3yCtebPAC7V+iWI2moKxeBbBzi9eaDxeoDgYXQ0N5?=
 =?us-ascii?Q?pYo5AWqxIy5I/0Rbi1n5YTwUs3SKHIrzzVPOS8O3VTufd3zThTUThIwefMac?=
 =?us-ascii?Q?mfK+fxPEXzfomk10q0SLB+e8F+gOzYA13X2+AfaoqUcMuyFxwmrYbr6UMZQu?=
 =?us-ascii?Q?oA1Js/pPK7v8Uluk7X3q/7QIEkQrgUxwWAZAHOZeC3tyTOYpcqwZKU3uKpzp?=
 =?us-ascii?Q?eMiFYKofzXKyTeTYonQR4LIjs1mDg3cpm803++6FSewFOq2OcYmukjPgPAY+?=
 =?us-ascii?Q?BvvUrwciUylT37L2p1InvOuQUMr+kL7C3osRUdBPR0r3C8lhfPlxz2enLT1p?=
 =?us-ascii?Q?eSVaDqyj+6uP8vt5FAjekAZ41PCn3CwNOGgGdfADvdmlILyz1WYNBQDsLzl3?=
 =?us-ascii?Q?hZPFoLmn+Bp1iQSwK3R7BdPqzIq08U4CP/GLreKQ3rgqbmYYpVkV+3QgTltt?=
 =?us-ascii?Q?D+nWRt+nwEo6nGnqgLaWQe146/CjyUdHWtfMHJbChTKySGmYpIE9gNPK91+o?=
 =?us-ascii?Q?jdge6PZ9+/RCb721CpYs266SlegcdessL5l+0DNnR/MQucNsZgKaI9kUy9pv?=
 =?us-ascii?Q?ntb2/59hFs0aCtxV+H+nP/zXF4VAvnE9LVw0HHujyaDq7HDjwZxHnA4XkNQD?=
 =?us-ascii?Q?C9d680CLwpEnppwa0YUi2OD4uq26HCde44bBopJeMpTxvCdHbXJErMbN9QYL?=
 =?us-ascii?Q?uCZ2dyQxYRCu4REOFklR3LPjdZPKcNMQmsUunjQ7el1cLICpYsmDyI+7/PrX?=
 =?us-ascii?Q?DOuRs3A84nWL9E9x+8hPvwoxwP+7wypjV11PLKkX5EH8tC9QyozGu+JrZH2d?=
 =?us-ascii?Q?oHzirlN24d+y8n5xRGNWIR+OONO/nl+j3z/5GJ1M4cDVvM6qY0mI2VQWDSCv?=
 =?us-ascii?Q?vnJUgakRHDsC8N1cnNDVO9MYTsqiAGt7qgEjsKtvKIjY6pDXkLXPtdmyfegL?=
 =?us-ascii?Q?P1HXsQ+ZJiFLFwZJXF9JCBdgEGEoyXtJsPo+v4l8zDoFCBoPAQ1oyiYaOYdi?=
 =?us-ascii?Q?yIhCYYvz3XD7JxzmL7kc/RKkJcyRU7sZTPU3TaG5klgCZZJ2C3F+86vGgwPX?=
 =?us-ascii?Q?dy4tm0auRPBf389KndcmXjMRzXzQuhukmLPQz4V0FtnAr3SVVM5Al03a4mGR?=
 =?us-ascii?Q?/ICD9pD7HedMoPSR74paH1FMiQuvRFLin1KPQhmEPQW3IR3wicQfmTwO9NlU?=
 =?us-ascii?Q?13TqhXLmsPkN0IXpInSi5AIXdoIstcROXjhyvv2fDk0heOCgAkH7RjTEhBYw?=
 =?us-ascii?Q?w3fWDJYp0VQFKTr3HVQ46+YRvLBTMcgyCZImLS6TseKxnO2+DcAxLgT7qAqO?=
 =?us-ascii?Q?IGv+35qyeP+cWstpCjr5U9yKBwqdBzH+02spdD3aT4qp4mbzRPHeg7GVePmr?=
 =?us-ascii?Q?MzaoQorRtArwG2yiJq8OIWp3vV7sDeXXcTr4TqOg3x4MRX/vzYRlQU5o1OiF?=
 =?us-ascii?Q?ZdnQJ1g9DI8QPsRimpi3VG+g55WlOL3JlpzwcZBi4RxgsXlZ5y6aEAZwfP5o?=
 =?us-ascii?Q?yj5nuVBb0r0GuCUmaW1irmgaTm10fYsb5R7meXKaZSPWtgFM27qshCu1VRrj?=
 =?us-ascii?Q?Tp3GuDz1UMOwZeaMAaSg8Du5e3FV8sm/YmyzKoP67t0HXJzDT6xuy2jF5aWj?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cfb8e8-bd42-439a-1040-08dca252085e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:07:19.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SwkNHkR0sjczwzfY7dqh9fSiqPcBIA4keh2VUChSy3Rtmy3GmYnfCR/BD7tOYRIhrPyPIMNmaUaCq4BNCk2vYeqRrjYjZ5UnySOB3FxJNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8780
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

Two related leftovers I found while looking at remaining
hw_watchdog/CONFIG_HW_WATCHDOG items.

v2: Add Stefan's R-bs. Trim commit log in patch 1. No code changes.

CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8910&view=results

I'm pretty sure the only failures are the false positive 'cyclic ...' ones.

Rasmus Villemoes (2):
  arm: bcm283x: remove unused empty hw_watchdog_disable
  board: rpi: remove leftover CONFIG_HW_WATCHDOG block

 arch/arm/mach-bcm283x/reset.c | 7 ++-----
 board/raspberrypi/rpi/rpi.c   | 4 ----
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.45.2

