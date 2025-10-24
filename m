Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A9ACCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26646838BF;
	Fri, 24 Oct 2025 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1755483631; Fri, 24 Oct 2025 10:59:52 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181F383700
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHnFP2SHVXWorrTH5qzeQFXcrbfUy+ZsnvtBQFE3imrSSlkqPtVeayjI5laNf/1B9UmWvnk+hFmRzSzjdUoy9E6uFYEy3RafmGZos4ciqczvjpEEU/AiclWX1MWTovlpduS2cq36rAgauQovHT40BNvfTT0t2IzkqV7c7iCHEjVa1ipmr36cSr/QWEFThP6qsjJ/7sWYPhbBAbXyq3ljbs1Cbwmc5FaIr3FV9OEarrNFwBo+Hrl8qT6wAhO99lsCD8LYS+gHkjPW+tCsG+1Tm7u0PHAE1kFrjcFStW2RUEQ+KsBQB7aH6yKnrXxoYe0GYsXUHeBdI7PrUfDUhK4XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5B0N2z3ghuDuw7lq3RRnHkMYupk/b5CaHepUw0pqmQ=;
 b=ZdWRvAd2+2IP6+svlh9JlZ5u81sZSLDpXAz1KmzHM93lL2raBid/g4uGZiHVeXVoJrb2l16Z+R0m1SWj2JTphkYScEdgYsh41D5CQTrq9KHGMcRRGw1Q5nv6v14KR4KFbCHk7EleafKdVfKV19gA25RpSN9wXkOhxJlrhhmrho9gx4LyBFZrABlOUtEYholgE79nmkGJ22O6bC7CHxySWdGssNA/vHp3BF861Ke/0xLGdigWxDz6lLUUj9WaHoRHvMNPH29+m3CZbpOonl7NPhxWGEqwY5sdxgpAf0uqwiPEf++ShDaV3lnv4yy0KR1dEFgq8RqW5o10nsPpdBp8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:46 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 9/9] board: starfive: visionfive2: Add VisionFive 2 Lite
 fdt selection
Date: Fri, 24 Oct 2025 16:59:32 +0800
Message-ID: <20251024085932.83596-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c88034-6031-499f-6b47-08de12dbae5f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 4p6K9BsyX/59j4m6uT0HQ2d6ykQ2kVNXVTLSkljiCQxGOrl2rgCDCdNBNGhpXXwDPiHuHFWlOddS4yIZ78EJf9lQsIJ/eztydeF/xyBUGtBIHoaHs/WEQKXDTYKiAeb1Lbs/WtROOmL8cw9zctLX4VSwCNoMyMToWVTN4Cj7uBoGJVn8SnsxhvwhCuIYu/pCOKfDdMfdUHFwhxCdb2/ZTC1sObdsPb5cPCAFRDjmZr6zi9kizHDCq8w2b2O8jkSStf3ZU90baPayOb7UgSnHK6Me0JKs1KqK6QcQT5JSLroliatZt9LjYaR0uxIIXl53kodCHI+4Yy7/qkYizo3IilH0bVjLoZFN4koDzQw3fJBlbxDrY8LUa48WndTFdFFM7l1Kv9BT+WDPDgcD0PeQxgXoCXmE1BrzemROhOSZbO0hUulb3cc/G+AtQbFn4rbtSqRzp76FKkIpACGT/AYMBk/oaQpx2UBBwlQPFTVL5F8zGWhTI95/1FopbgLl1Lcu74wqwJvXXZT5oF2YN47EWs8IyL0a98cTrEIFNOLxiBfkPBe8Ze4vUGBP7Cov4cbnE9LAzBoFfb8sTC7vETCfs9aTbKx2Tfg824hhlDi0B30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyGTFZqi/0CGcrHdDa0B8r+cm5OjpW3cSfC/g1p728U/hvyClpCigPXGu7xt?=
 =?us-ascii?Q?pRQAbQb/p0WLmwDQXRhnvOXXwbmuEzGcdkuq1S5YVGDFupFaH3Rw28rpYllk?=
 =?us-ascii?Q?u7mcOrg3ibiCfMBjQwGXXzA+0A61hOPockj/HhT0/SDD/mb6trsAawvPs0oR?=
 =?us-ascii?Q?q2EtWJ89+sWMu8Mt0PvsNko1AzvZiAT2m5UlBOF2OZ5UQvsQdoHPKwt6ov8X?=
 =?us-ascii?Q?mRFW39eav5cws0pvf/r5tG9Q0t1muII7HFD1JeD0w4XZJeVlZHZo2OXHzJax?=
 =?us-ascii?Q?MaF+PW0vfitSAdJRPZjJTXhdgX95Q9lA9D+UTsvrrovFjcOgspWbHTBMSt0R?=
 =?us-ascii?Q?XnHY5wkpyVqb68WWhwt5pwyZF/Xqpy77VqZzZAdaz8rHb0oYCfhlAeArlV3o?=
 =?us-ascii?Q?Hye3Lc0bnCAwPiigKYcQDDJfPT7wXvaqpFSS+CPq4e3C0n2Vy2eDpLKxoWgt?=
 =?us-ascii?Q?5HobF2bH7YvgEzP3TPvtxoW0oKxoDkVMkTrb4Z6EIiVRK6cFBQCkpfk2IpCX?=
 =?us-ascii?Q?SDGBstpehUuctl1tKirKjCEVFFj/N1oF6c1hisajneuH7mcasLYRbFsS8A5U?=
 =?us-ascii?Q?bzd3nBDi9EkWqJ623c0MfImIT9ETQHeaF8LSgHui5JK5Uj3wL9Q5HWPY7PLB?=
 =?us-ascii?Q?WvqBfG7f5DJ3vceCehDkG5L9j2LYFPel5qQY3Ce75d20b37S53E56D/FaQJs?=
 =?us-ascii?Q?xXRDmStuV4w3oJlPGy1ej2rGJJjyICK6r8Gvx5igdoiyL5BXpco8W+nfN16P?=
 =?us-ascii?Q?aGHZQZs6/YnCmlliCl95vWVHz82upxPjfqUeJhUA9ZXje27e0h/9TeUDs4Vw?=
 =?us-ascii?Q?PLtwy3hr1N8+9HaBeMsYsOLHvYGenhTVEVNocsPDkimQbgxRAvqP97Z1TC8y?=
 =?us-ascii?Q?csUrO/YbNjF3v43failumj30QUw880EYrIiLZ9m8cqifF6xwAOIYZN0jw/65?=
 =?us-ascii?Q?XbffOUaYFbd5/RQlfH32ijlSh0vKgNdTcDwa6zQShCdRqPF6Jb3jzjpfZvAo?=
 =?us-ascii?Q?tlAUs5aNFkCD3r1CSNdBSZDkg/AYskj1gw/UmFLF62OLeW9KKSKDNeFnX4VJ?=
 =?us-ascii?Q?/hiZdgXb7c3yOGLKc7sMQ8gx1HL/n9lO72xv6TKYHEBZwNncfXZjC+dx7iNe?=
 =?us-ascii?Q?iXWAAT8jhSyzi0YF75aLqJoY9ISQ/g2FPwde6ItAmyxuDi88gsdti30ZLCD8?=
 =?us-ascii?Q?kdH/So9hUpHhcV1y2vHWy9m/0IbYiCdeyA7Hrzf8n0IMHNa8iiJERaHHpuzm?=
 =?us-ascii?Q?PKI86GB0uZDyjD19H5x9DtcqQ5O+Gkci8DRQ8tU26FgXWyevS4qft7hEsbep?=
 =?us-ascii?Q?l2ZER/7fyiPNsgl8s+Kg3/bqdwqY02PHGjJsUelm2ABJzoKosaqEFPxloUur?=
 =?us-ascii?Q?HHDD4nGqCI9MV3rPUfSfX/gVGExXeD3LGQaAXv6CpzY9y8fEN+j5ziUNAezh?=
 =?us-ascii?Q?9UUFcmQIneFW9HYojYh5yWPRbhvg2+gkQKlqmTodFhDE6CM+yPlGiesYKJ/A?=
 =?us-ascii?Q?6tgcZNIX+ZLk2Hb7bYEjx9z58uWVeYAA+1eaC4fUJqXLIevZnfklUOcCDL7c?=
 =?us-ascii?Q?/9AU6NRuGv8HVfk/QyR8cVUdZZEUsm27z2JkSnV6cKn/YQlfZeYhxsJb/hjg?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c88034-6031-499f-6b47-08de12dbae5f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:46.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/P2McbZ5Q1bfhTSl56X/fGv+DQ9M4xclPb9nJ6P+UEWvxj0H4hbkd5WExlr7bHiZ2QVbgAXJ2x07VMDydtd9ZS3TMxOzyQShndnKNHsn/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Set $fdtfile to the VisionFive 2 Lite DTB if the board is matched.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 6271974b9c7..013ba63994e 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -63,6 +63,8 @@ static void set_fdtfile(void)
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		fdtfile = "starfive/jh7110s-starfive-visionfive-2-lite.dtb";
 	} else {
 		log_err("Unknown product\n");
 		return;
-- 
2.43.2

