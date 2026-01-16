Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE1D4899E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 12:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF9D82BF2;
	Fri, 16 Jan 2026 13:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Dw09E+NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBCA8309A; Fri, 16 Jan 2026 13:50:41 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CBC280077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 13:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXn7eKr6swcECKemKajbo5YtrT/qKw/dC77QjrizNDD4NQuCd6zjz7BD9YnKYYn/Bu+vu4ioy8MOfR4cY4+kYfCOi+ntshkeXnXV2mkc6OrVWPgrHRIR3NO8OoBvchb8EDlfhSVOsL40Q+xIo+XM5bajejoWFgOpNOoGbyjLOLjxCq7wHnjSTtFcKiB/85h7pFtwtW0a2wseom1aXmmuQUi6ReAfq3cHAJK1Qgv5OjHz2yjwpe6xCwm4rusX9Lvg+hcVRMVslqcuS6CVwgk/sEOKWa+PyjsL8KCz7PmNPhIeODkAFCyP/qMmd534T74AZtZlRTxPtMuBIJprlKS/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w0bKCfiutnEeewRTG1OB81kRhB9K5P5xhQhQVJ9eek=;
 b=lZW2ukpL9k2f5ZmyLsGzaFmHqwbFei7NwX6kIjK6ZITmSdDFg+QGU/ZB/xFtx0iq6OYrXTReak6/blClcVzLlM+7sx0vlmjzzusk/fFZdsPKt0wgrDvdqXnYp/gEMUDZTaX6R27nmX+Y54Xbw2IyReYrpRCQh04XWPxEcRy1yjwvPfQ6SuWqz+OvNEj6XIJqceyM9YFqJSOH5moMAncU1wdANSJXR4wg1jHbw1apK7vNYa95Y2IFDwRSgF8sz9kYbP8GxJDgaWvZXN8ZqrChhGqA3A5SFgVuj07YYzUkXH6rvvzhLRnoVP5953cK8dK48W1atXmHNnYD4S5Bbq//tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w0bKCfiutnEeewRTG1OB81kRhB9K5P5xhQhQVJ9eek=;
 b=Dw09E+NZH4yByjL54y8nnMoKy9puvCk8iOLbk5qOBGhKKFTGa0QZj1OVeQYRzdK0Jkus8tepvrLMl6XDisFdVkZKzkdRIwIgEf58FN/HrywF1jZoJblSkcO2HthZsTaCxH2aUePGUDOPEkDUyrlG/nqCRfgb5q1v2V5AwIqwcA0VwyI82+5eAFmbARjk+mLM+XVGLHkMvyQJ53SNJz5eYIcijBVHzbr6yiqdJLUF5czSQrvfU5pxEiGEt3vFGZ8mBk2FsJsoYtuN+iOpy3yhe5sL7qLeF8wkHSv4MwvGmL8nUrRiP1PO61vWrk77jZzWXpwlYRi4NpHhbnUBq5usmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB5023.namprd03.prod.outlook.com (2603:10b6:208:1a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 12:50:36 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 12:50:36 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 festevam@gmail.com, ivitro@gmail.com, max.merchel@ew.tq-group.com,
 marek.vasut+renesas@mailbox.org
Subject: [PATCH v1] mmc: mmc-uclass: Use max-frequency from device tree with
 driver default fallback
Date: Fri, 16 Jan 2026 04:50:31 -0800
Message-Id: <20260116125031.3975-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff59c53-1204-4cbb-3438-08de54fdd814
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RqIUTUWRqIv8jaB33s6rmL8NknZkN2vdkoxAHiWgjMxwoXWd111zxYGelYMm?=
 =?us-ascii?Q?LvFi6ZoEL9+7nJi0cBHFX4vzObp8ocxQ+Mb7ODt+wXW7qR4IcEfZltGy1S86?=
 =?us-ascii?Q?ZRygkcyBlLFgrdQc6gN8mYlPBowCDoSKQUCYyv8woRFq+93+ik2VzGdhdr+9?=
 =?us-ascii?Q?k6HpuOSchKRvWwVFO+mB9q6/HYn6r4In+se5CvOAM24kfgFoIr1PWXsSxDfz?=
 =?us-ascii?Q?84xMZivLT3dUaYaIiAGvjvQ6J6O2ufufAUVM65Ao9H1mKE25Hb+zsNcaulhP?=
 =?us-ascii?Q?BbeLJ+A7ug8K9+kB3uqDdTkmlYJWUZdiFlvoMptXmBJl+yRhfbKq5SvegdLf?=
 =?us-ascii?Q?aDYzizA9rgAG5vM4JM2S67Bxc0iO4n9QWCSId0Hb39sC0DV3MwblCsbxOwCI?=
 =?us-ascii?Q?pdKkDchk2o1nNxbOsNeQaMAZiD7fmO6WsUPcFGLeSSeK9FUu6M6oa7JEm0Tf?=
 =?us-ascii?Q?e28GR35u+iIW9Jx81bucAPIjN4ol6ybXrQvxwT4b8CVRLbwDZWFJ5Z8knmlw?=
 =?us-ascii?Q?whphhRZO2jyxGIXXeIsanmrtCnTBrGV/YJBO6soYVykFe5GbwvWdP605341P?=
 =?us-ascii?Q?mTmUt9qcGFLmBRE63W0wY5F65EWoLamspS0d4tZsKKbmjCulaW58jqjtK9ZE?=
 =?us-ascii?Q?i8JBNpwmLfOwUWaSHD3+fpaKtD0opbkAGDbGCm6fPKv7bYLXuLWvKgSnA3Yy?=
 =?us-ascii?Q?Mz+x6AZwKkDczabLGsZQp3QsBYp1/hhHykWG7Q05LjOyOKGM/eH7xpupUE/u?=
 =?us-ascii?Q?f9wx4jvvrFEJ/XXaXnnwlge9ZNziP3xA+YBKdWAsUOkfjB1hlNkjpUw+dBqI?=
 =?us-ascii?Q?W3Q+qh1rNb1pSK7zdxffxGa/HXEta4iTSyBw3UaBoo451FzwoA6+8W1j+uRG?=
 =?us-ascii?Q?XEDApMJmhAx3kal4jRwXw5njaOQmcMt1BDWuWlJ9JW4enOad1WPeQDlW1L+7?=
 =?us-ascii?Q?el+iQddide4ZQm5gAn434LGZ4PKQGyAh2DHsTGSqlnFjZX5YMtKhSktYuP7H?=
 =?us-ascii?Q?IYqE3a/bpQ6xwWvMkKKV/yFNSMuRjKNJ5vuc4ISMTO40jZ1yg1dQrQYIpK6t?=
 =?us-ascii?Q?bhBxT7PYYAEgPIBNjJNVIVhpQkVxwUMzDYqulMXW9PXSccQyic/+WrUPgn16?=
 =?us-ascii?Q?g7Z/f0hdst736itSPs3kEZf4VeAQQpN+eZ2JUXG6v4dgk2QCAfIrax5whm5c?=
 =?us-ascii?Q?dlPy1jSwCTeHRLomPJccdQaunK0s11txphkAerWwU12rJODbZk3BJz8vtVfU?=
 =?us-ascii?Q?L/QFPVPrCZKFlAIFRHq2/wmNEmCylc3reg1ioy61CvwcfvEpY3gJlXjZ4mEG?=
 =?us-ascii?Q?PGaRcRfylUKHHRTX6zHJzbS2tdWR5SROWobt+PX3C8rEhGZhDZagBcD5IxfY?=
 =?us-ascii?Q?wNgyKa52GiAln7vd+qYE5pZw/lTWXSarBJr+Z2C9F7VOscDkxsJVYTQI/99E?=
 =?us-ascii?Q?sDOZIM2Dx7DWQXoL5rWisocU2HqCtnQWEEqRv5+GwVsSWB+9wygswO4D2Tpg?=
 =?us-ascii?Q?EktQ8VLhC0Mqkrp8jIrMNhU5yUk7mx5/uAihLCI+oJ5m4yj20aUvvCmtKNUu?=
 =?us-ascii?Q?AE7dmPm2rCLkvI9tIQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbKpXQSuFbL4tvn2OqDnUpB5LF6fMPHUfJzDtshQJdQH06Hjs1W6qwSNaLSb?=
 =?us-ascii?Q?0UxlsjWbdK8Z/eGfOWgKm73XDYMgNQaZIw+mgNCM8J8t4O2EaBKPDekgvgRK?=
 =?us-ascii?Q?d66zNiwevuGsiCcCfHh931pFdviZKe2ZeuGf0a+WzEv710P8dvaPAFAV9vjW?=
 =?us-ascii?Q?ZM/o3Gt8o8K5BnGOk+JSoxJ7mZFicvR0BEEyGGdBW4tncuBC5BivexG7iH/6?=
 =?us-ascii?Q?iuVLeUcU3+yyywkZDpR53zIR+7aX41jv7kY3HE8q0dPdKSA/Fi3aUeTcdEZD?=
 =?us-ascii?Q?gbJyf7i58axf3Dr1y58HxxlaIsMefESkqlz/QaLD3LyOr9++PEwlZj2hkc0y?=
 =?us-ascii?Q?UPKQ3ZWa2bgxNHC5WFAvzKVMI8Wat/BNzWqGL193hAbjjOCO+8+C+Hxn/Ls1?=
 =?us-ascii?Q?0T1KOH4f4H/bEw0QHOh0DoIXp67Vcua27hWPPIYI2iO5UbgeB8jU+hSW0z4B?=
 =?us-ascii?Q?VoYO78H2AHz1Kz1/eyfgz6JF7fkl6p5htL5oqUEb5DpNJSOwaL2jwCnhqgWJ?=
 =?us-ascii?Q?tgUDkNhuaI3P+ULjH6tYk1CS85rGZ/1033T2UnYiMHJP5bhHEuJJe0sOL53Q?=
 =?us-ascii?Q?5vBYRpeAGkeyYBzqZ1Fnn3J5VKaH1Ofjj69Ody2JzJgj7uvqRjn4ZCBk9+37?=
 =?us-ascii?Q?47slSGWr3l/EXhKdNekTbXryX17VEZxchT1hP1GVzrJhGbnexDvGtA3qGmjc?=
 =?us-ascii?Q?OOyoR5DJWgT9lIEH+Pq+X/BUqiBjcqi3Cnww2pgBcn0uAbwrp2f9pF2OuFeU?=
 =?us-ascii?Q?bVS5YtXY+2baznAswlfVZ3dBoCO/eg7VLpGBJk4NpLCMjSo2dzFq8zMZwasY?=
 =?us-ascii?Q?MITo5qHIv6G+u0gUEt5XgChRe6dd1tM+oeZdJahi5rizMIqun8XzJLReRztX?=
 =?us-ascii?Q?ISIdZCdhF2xVsQhAGXpEX3HBnRz0hTGcMcdtDcdapTV9LbLcUlJTHddI5+CZ?=
 =?us-ascii?Q?9S3icRNZp37zIToMxadWtQckxQlnf3rF2s9OYTAwGEHMrBSAwhx5SZEWNp9y?=
 =?us-ascii?Q?z3fD3h46mD1LlHe+OBFD8hnosNagAQXDUpLk1DiSm2RDGJv0foaOPD8luSv7?=
 =?us-ascii?Q?RWEm/cE4KUNaXB29b3G8hKkHyeznQz6ih3us8OqKhsTYgBNumtUpGPVcUkOW?=
 =?us-ascii?Q?avPrkr5ptCJZd8TkxWX7OQ9ew4+i06tSEfifw4PK3ck8I4tfJM6CgoX2c8ig?=
 =?us-ascii?Q?rjtpiOLxHsG0VwbmN/KDhqshyhMDy/lCE6p1ukbuYVJEWAKm4Wao7CFDFj7E?=
 =?us-ascii?Q?FPSPXBjJvX0MpM4QhwyCmvxrxbqW8jiuhp68XkUiMOy0/gSMnMHQN8tmDqXW?=
 =?us-ascii?Q?B/ojsToi0+FLIVlgBpuLGYlkklaZr8D/7SIGoQkGejykZcJdpf6lLk9owq+r?=
 =?us-ascii?Q?zJDgAR6N32A0kJiXU8SQSnUbx169n1HlyI9guUG+ub0YPThupMwfGq4I+emm?=
 =?us-ascii?Q?F8kJWhjInn3R8qQczXIHgyxtX0edGYSeThmhju97Hbas81goEGNEpCIejaPI?=
 =?us-ascii?Q?mVY0EkVtcWCiUAKF5f/M6Lj1pcv0T3b06fx4C9vWDz1k1/SUEnARS3gzOzFi?=
 =?us-ascii?Q?vUg38poTh5TNPStZiclXqHTgtS3zR4wBDSHDV+AsuJRLb45hyjg0VrFjuAjV?=
 =?us-ascii?Q?IW26KLAxqTQqqgtjjVgi5BEhdoycGsgo0CoAfLak+A2cOHincS7P5mN6pX/J?=
 =?us-ascii?Q?6R77DgXwYTFjhTnNOFxpeTf6j/xZ1YEUY5mG4sRdl8GWQubW+g2aQvGNJEsM?=
 =?us-ascii?Q?/AtmyfN9VJ2cbhqqrZkviN1w9weIwmE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff59c53-1204-4cbb-3438-08de54fdd814
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 12:50:36.5436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWbkeuelLbhxGzVM63oa0GvbdJqggDsyLgTTQA/EggDiD/d19wpwZcQa5MYJ9Gi3Pnu32BrQQJg7a6cImSNrUJ6KnBRhE8VcVxA1Gri0oHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5023
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

Use dev_read_u32_default() instead of dev_read_u32() to read the
"max-frequency" property from device tree. This preserves the driver-set
cfg->f_max value when the optional "max-frequency" property is not
present, ensuring the controller's default frequency is used as fallback
rather than being overwritten.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc-uclass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 2f4dc5bd887..698530088fe 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -243,8 +243,12 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
 		return -EINVAL;
 	}
 
-	/* f_max is obtained from the optional "max-frequency" property */
-	dev_read_u32(dev, "max-frequency", &cfg->f_max);
+	/*
+	 * Maximum frequency is obtained from the optional "max-frequency" DT property.
+	 * Use dev_read_u32_default() to preserve the driver-set f_max value when
+	 * "max-frequency" is not present, ensuring the controller's default is used.
+	 */
+	cfg->f_max = dev_read_u32_default(dev, "max-frequency", cfg->f_max);
 
 	if (dev_read_bool(dev, "cap-sd-highspeed"))
 		cfg->host_caps |= MMC_CAP(SD_HS);
-- 
2.19.0

