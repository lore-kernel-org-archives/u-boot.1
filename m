Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0381E9539B
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E04E839DF;
	Wed,  4 Feb 2026 14:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="bkrKTyQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7D683A64; Wed,  4 Feb 2026 14:16:56 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB94838FA
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0NIxQkp0ELTt+C2PjSJfAFnEdD3gwmnytfLctzHhlScZ2U+Oj6sxQHdgSvCjgkxdxBO8EfF6E/o/y4duFEUeO4PnpOEGIdjGnKaMbxgLcBXWhGhTkd8lQ47ofQoS+GCoX7tCpdB8IpKn7c4n516CqKLm6GLeA2oKihGe9y65g159MwwwWFbryGv1UxsnGjX+14A1yAb9qHz441VzoQ2hvNJqqh2xRnKkPa6hWEApQTM1Ocn9WWVH4wahPkJPcd2UyxJ6MCn3vvpA7wztmocGAj+tCnv7FylVayxIYHlKHuKk4svJjP69NlaxvfC3T6L9tO20SgMwSHh+3j0cXfrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBtz2Ddng6WTzz/PjUx+ESPKzMTLQfgXQRqY+uw/kB4=;
 b=umBF1MezADpdiNY2QVHA8j+9MirY3MJxl/CMmZLXAb0HQP3eHqbkuBY6ArSMZkmrrgf8EdvarG0wpwvAVJzQdvyNMs3SRUKqD+59rBszmtFAjYVSEbl0ULL4GEAWUikpHXmIII6GMKO3PkV0cwu4hywdqJ3622jzma+8gEWR+qcHkYwm3a7n6XFLjcsSeT4x7R8Je6fCSAT8CBNtLXkYFmlGemRrg63X8L7Xc1n3W7dozZJrBBNDrcMH22udaFDwI6wHPoSpKgQe/VQ4H93LzIFff2G8TPQsv6jhcjQP0ZRZMxDznvsmemENX1zBU1jyh6bumgfgt7Hb96nG25nWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBtz2Ddng6WTzz/PjUx+ESPKzMTLQfgXQRqY+uw/kB4=;
 b=bkrKTyQGQcklnKS4sK5JhzjbLiyBWwj6/UFgHgkGmqeKaga6RwnG0p60nphf2/ROyHNTvOAAVJsfvhYX+aiCh2n17pChsuzQWQazf39iUWqCDBzv1npEdqfggWL5F9eMZCdvtg+Mzur6417/c0KHOLvRdLOgVRfUJDN/YtjhHSkU9VXropLbJjCWngpIUxFIbAviPlE/WI6AZU4tyt7snMVQQLXcYzlFhVkAPU8eGeVdcMmMas9WcuUy7IOSd8/19deihPD1IF+CIOWtWQUjJZ7ualykWkh9pUVNRSA4U1c9jfxUNY6ImHEa+SEM/yEuoP0pFxMqlb3Ie88vEXRBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GV4PR06MB10191.eurprd06.prod.outlook.com (2603:10a6:150:2df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:16:47 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:16:47 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 0/3] bootcount: Small clean-up and fix,
 and dm_i2c single-word support
Date: Wed,  4 Feb 2026 15:17:34 +0200
Message-ID: <cover.1770197302.git.niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007563.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3fb) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GV4PR06MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: b4887bf5-8305-4583-32bc-08de63efa669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FRwvsOTBTFE9qpYstxN6nQ701uopOCEosEi6uNAQfldFh9aFi72I1LByyiX?=
 =?us-ascii?Q?1PdTFe03zAnOYQhPFljx++GCj3bq6iUB6oO8bgkB+HurMafMgP5fsUM6wwYo?=
 =?us-ascii?Q?rmERL1O43IL5i0Gc5UD1ow/CFyk17+QofsaSQ7E5s56ZHupTN4t5wgBmZLFf?=
 =?us-ascii?Q?TOkO1yluGOfOU2G82B2yyJbrGKxYsmQrlPPHhXD4IBM48Tel5Hb0tJpxqVcA?=
 =?us-ascii?Q?BDdrKLlO6Ai1hVWucbI6X7K8T/lTWkRETFpP0kG0MbdDq3neKZT9mwCbbbLt?=
 =?us-ascii?Q?HVOn2rZicx6GfZ1kurRkD0uP7xAOySDBfKhSitexIVrczt2o9js9lHwp0f4Q?=
 =?us-ascii?Q?nFChcjz/O74rpnk+2OTbJ21fblpp8e2YOFVBwG2rqlByIfB8y5/YTqhI80cQ?=
 =?us-ascii?Q?1J7Bzhs8ltXa9yE99wBnUyp84EUo07vhTAtwcuqcly4OYbZLVZoqksTckkar?=
 =?us-ascii?Q?wEXVSKPLeLaUIwaZ9/iyKTYnzU2+NQD+2OXN9nqWSiIS28ypIJ6cJFKXI4vV?=
 =?us-ascii?Q?FVeA0we2FPpVWJ7eH1kmvJKSME1QUYW5HJk0+3CV3RPsTfaq5lq4MUOAF6M/?=
 =?us-ascii?Q?vvwkSLxQwT9HH4qwnoXpbRDKeNrUCXB6yqmdrw2U3stZ0oeDwL+sWCaUZp5o?=
 =?us-ascii?Q?oXG8iKwDhWtHWUigKJ64Br98jXSqAmnR4jm1YOnW8qJP3+ypkB9aLd5ZFRmE?=
 =?us-ascii?Q?4U00EtoEE8hmpcU7wPryz/is0wKlsvdf4R/Ob93zTZPUlc7c7dgtu6qnbAGQ?=
 =?us-ascii?Q?yxtmxL7accUUADFY+BdCgvmlaGb793EBY6qVp+cj4LSAgxZ2cV2lAc3vfdjp?=
 =?us-ascii?Q?vWNC2Or01IVVtJ3Vo6C1SZ0EvcG4cPgddK7eLA+BcSvBWtY2GFdrndtgmjXw?=
 =?us-ascii?Q?asJvai+cGlDJBh3vKQGS2SPCULT9EZ1/LEo3x/akz90mgLZesAXNMHi1nVf8?=
 =?us-ascii?Q?EV35MFJxi8g/Hy+zrKPvmyggHboGmDz5c+7dyp1FSK927Q0NkxVE8sH6ZkVH?=
 =?us-ascii?Q?96oEWLHFgQQVUCg3BR6jpeb+Hc1zxpfiiAtD1HCZ45JN2NdtzBe7lDnhbR01?=
 =?us-ascii?Q?380FWtyJyw+m/PUxlk20agdhjLWdKVstFaXAakFzth23ILCNljx0Fz6LS4Ri?=
 =?us-ascii?Q?JvDqPnda7E89BvQRu1JOZS9Fp6Quh/hh5S4N/ZXUe1MlYVaMEgpPfPfLvDoz?=
 =?us-ascii?Q?Of6+Quzd9RI8cKArDnooctjPsC60ZVCxe8KST2UpRz8nyVkzNDdNEVS4ZH8X?=
 =?us-ascii?Q?GWKwMqKMokRnuCAyvuw1ZX6ie2KuuRd7yEEGdXlg5Hw1DDbrV/I/9j/xHgkI?=
 =?us-ascii?Q?gFhh4tnhfP9KNkn9z543NB4eleg7h20eTgjzD/hn6uBhJAsco7iPxU1JYQBY?=
 =?us-ascii?Q?SIfCC0fDT4F+Wg49g2xma9LV4V0H8FvoEdCBhLAPc4/KC3vFobmxee575PAL?=
 =?us-ascii?Q?FUD4m1dXyxFF6V9ogoNzVgkQgz49oxdGrRJk++bfHzMobsvFlZH5UKfj2UU7?=
 =?us-ascii?Q?cETT27MmXnNsqet2KdVFZBICxmRKgHtw7e9H77ZM6KhSrNSwYQq143uph8qE?=
 =?us-ascii?Q?iM6DYJdtrhWA/2On1a2fkI1ZcMUZkqj3RLLpTwM/x6Fg/5jw9A5ztG6mPhbc?=
 =?us-ascii?Q?5MsHC8GLeyJ12WoPXngX60s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TISAaCwTWQdC5IzZ7lABaJRbsSFhmLQ7lQHxgJwGraVh1SOlDBqWPH16zvfu?=
 =?us-ascii?Q?T5RIJeic83IliTwiF+WUJwAvXTKNqWGcjzCM3uNN5p+vB5S98Oqhug6KEdeP?=
 =?us-ascii?Q?mGo3o017lhuVpMSQh9UcBOkvVZfDwGh7NsnAI3jTCgc1RrOBhEJbhFEUFFSt?=
 =?us-ascii?Q?96d3T6zErqNiqzWkdzXyGK+UuhR+IgcoYlVRhNPheuK7WgVWouBOuT+cMyl6?=
 =?us-ascii?Q?2p+/eQPOIbWf3FHk5PmONmJ4+qBeX1RazDFfWLFQUDxjS843gFKYrYZxwftK?=
 =?us-ascii?Q?FVXSnb5TMFFh97RNsruDJD9r/6rnK2QqheWAupmjyuNhSDHM1RkZRem7Rt6h?=
 =?us-ascii?Q?nHnr/905IHrUjXqoOXQC2BazlHSSFO9wLlSJ360pY+SpYBaYfiwCZJf4DoGP?=
 =?us-ascii?Q?X5zA1v+hy5rCCJdtQ2Okmpobnsj3azM0/qIbSJ85RL+PrZ9XdBEqdb82RqPE?=
 =?us-ascii?Q?x+aJjTNXYfJAouPwYHReVPBgPnRNMFvWr96ICaEu+znWf7Cd2c+rerd1ZtYk?=
 =?us-ascii?Q?rBLLvguRsiJgsXD+XdgnZesZdhkH4IoD4Sua1HywlCxCS58XRKi9iQVlwuVM?=
 =?us-ascii?Q?9awk9NofOyUDXraCpBHNpn70a9spSHuwxqcfxZDle/7XJevzNylhqL6UjBQe?=
 =?us-ascii?Q?wUHzPSvlVJMvdu0rtdWQ2q6JcZb37FnVtJnDdmkJmtTrwj6iHqBw2Gx8Tvzu?=
 =?us-ascii?Q?zO2loKT+Cy1vSWyJL1MI57JCorakdKTjoOo2pVjJtVIIy0nVzJ2jNhY5RUPV?=
 =?us-ascii?Q?ZCn6o/Ex68oXqV5loeHcCLVNZkiceLQhiSvKDJHCH1RUkxHVm1tauSr0+858?=
 =?us-ascii?Q?bK2/hppqGG2zJ8aq6mtuNOKBXqCHf518mJb5FSOFyxsU2eFlFQYL0ciqT7aU?=
 =?us-ascii?Q?G9fhcRW0VVt8YWkziVixFiqUS3gN+oO8KIn7fwLaJlviYD/6Sr2oHiLSJ2jc?=
 =?us-ascii?Q?tWw/MfbS1Qtp8xt76FRGSONKxiXIyezqZRYGhg94eC47fIMsuJKkn30G738Y?=
 =?us-ascii?Q?SDrvnldx3OV9Sc0/MFIkdwhCkMl9vo1cthmoOc6+lOMKHB4hNpodAZ5oH/N/?=
 =?us-ascii?Q?NC7PdSMOwdQcJCo6jYD81pBCgQ8Pr4KaNX3aG0xgcXN9tiPC8A3oPufYlTQ9?=
 =?us-ascii?Q?kyi76WrLtSazwC+Ghlskxg3sn9r26aVLMzOHBh1IzUFftM9L1ST280xmKMVV?=
 =?us-ascii?Q?mL0G8q/XMGGrS/beWwN7gQyMs9nqvN69WbKApkjjCfyJdx60bBZXzRyFNVDE?=
 =?us-ascii?Q?DqZpqQ2dePSrJGsYx4dqxn3XHIfMJBmHk62weEOnjeiUe76cLg1yfZZDdwo2?=
 =?us-ascii?Q?7saIxkxESoCbhMDZQ3rbaeMyB0xAr3Xs4yWx8MniU51GrIlNm0lcrzmiLisi?=
 =?us-ascii?Q?CE3u5CgNQ8DTwLhpXJ++UdPn7XUovPv4iCGM3D4JgeorLs6IyeeFWOkMm/4h?=
 =?us-ascii?Q?IeprZW+RKypkev4mCI719glKusTfn68T6R9cdJ2XVmsF8jr5rBznOTdQaStM?=
 =?us-ascii?Q?gXS6lv0hNAMPkgCLSFz4/clcr2DAp8fkBGrNHa+VLCbBEz5vjR8bq3e7RiN/?=
 =?us-ascii?Q?uoKU1r4Y0NTmAsQfYLJtzkyQGhAq3l/xJdDi/C+3O7X/4GciYOSUO/x/jphS?=
 =?us-ascii?Q?ZeVJ1Oa02yWAS/tlFNr28VRHkKhWpL/WEYNuc5sM6U1t8A9YdTkLVaqK7Wwi?=
 =?us-ascii?Q?x1O/MCfIY0ksEE3mT75R04KX2jGstcaB4htq48R5x6DPmqB1tzkRqO/BrpA1?=
 =?us-ascii?Q?gaYSIKTbhYAcd8L2BKP08MZx09uXqFI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4887bf5-8305-4583-32bc-08de63efa669
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:16:47.4526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbWA991hNpftVdR77RLgfvpOgFy+d04sZCKLs3Bajm1dzPy9Q3KTYf1tjJn6x3SqlIupIhmLljRwTlocwcHE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10191
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

From: Niko Mauno <niko.mauno@vaisala.com>

In this series, we first introduce a clean-up where we switch to use
predefined bit masks instead of hard-coded values for count and magic
halves in the single-word (32-bit) boot count scheme.

Then we fix a case of missing boot count value masking in single-word
scenario in bootcount.c, which allowed clobbering of the magic half
when storing the value. With this change the clobbering preventing
behavior becomes consistent with existing single word bootcount storing
implementations in bootcount_at91.c and bootcount_davinci.c.

Finally, we enable the DM I2C bootcount driver to work also in single
word (4 byte) mode, in addition to the pre-existing half-word (2 byte)
mode. By default the driver still operates in half word mode as so far,
but can now be used alternatively in single word mode by adding
'size = <0x4>;' in the associated device tree node.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
--
Niko Mauno (3):
  bootcount: Use predefined count/magic bit masks
  bootcount: Fix potential clobbering issue
  bootcount: dm_i2c: Support also single word mode

 drivers/bootcount/bootcount.c         | 14 ++---
 drivers/bootcount/bootcount_at91.c    |  7 +--
 drivers/bootcount/bootcount_davinci.c |  6 +--
 drivers/bootcount/bootcount_dm_i2c.c  | 74 +++++++++++++++++++--------
 include/bootcount.h                   |  5 ++
 5 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.47.3

