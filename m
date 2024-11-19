Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF4D60D0B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBB6894C2;
	Tue, 19 Nov 2024 03:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E848924B; Tue, 19 Nov 2024 03:06:10 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F0B89417
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpYuEWSJCi7q7H51exjTasgxxxqzFg3DuxUOj3bLxM3mscICUxAPdFBoujdF933t+62FPbq7SS0hdjCUS2bvh77evxxHsruPhWGzNogohogbJrTkbAqAR7DeTUxCoxGGN2LMNI3JSoSvT5o1wXCoB7Usrog9dCXT2PvxDg0rwjD8rwUApxHhj+y/qCsPWGI+bbKBjXX6OEWchgDr6k9aL6PjnXvmqvLs28yTfNLUmQ054Ocn4pzi7S7kLeg64PFkxV6fi2xbFUKGTGnAR53hADQV4UDNUcW8LpD+dn9qT7qYFHyphVb4UjuSTAiOYhwetCS+wqUmFO6t5UwLvPKGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puqyiKD6HLx3xa/8IWwsr3tAKZFZrFtvQXHRkp7j60E=;
 b=iTVjTaCGXTyYHGUv3FlEfFYFpDDvXQqgQvaw9csx6tnwv6f0Xhu8NsLLbq+aLHPdQXg8x1VKaN1iC3EyVsvnlxley9Oup4lFe0GUTMjauqPHEpHp7flf1Sod9/GCaG0giCbKNinYY/N5MbpXeFLCFYGMESn5Uz4HcvlnObaFazSl6yra1NRyS2zjHkT3rNFDLanbApZt3TAI3czQk+uWKGrLVaw5YYyLOupDtTY1RiDnmzWOUZMYRCU1zAEn6cTXxne5IHqa4VMhpyKkg5CHWPtDORq7gdsRRI7hDtVKd7Dp4oA9yqEkLszN1vzt0/8Kh7XX28GiTXfsgyekSTSW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 10/11] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Tue, 19 Nov 2024 10:04:24 +0800
Message-ID: <20241119020425.51989-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: c339f7a8-fa34-4eac-1a04-08dd083ebd15
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: S9JoNlE75cESaHCA0gB5383ve2CXcYgjz2c49/8Zda9GYCxmhSoY8S9JxtopEv8T8C11o5bq/LPHTacu+MMeF0QAdZhaZgz74xvfknB1cGvc4T6OSAVynPfVySkX4Hm5MaNDckjMyIJZ6V5eqkud08xbw1YU7tLuLRi6Hc/9QUX0skep107TOsmXfbVFqX/BBZXb/gXoSDgf/oe6vDO0msKtOwy/YG4m8kOhvg+ZJpbrJULlUh/g2YiXQhLaMwFLQOkTq+p0OUk4gSy3nES3U22IMJdgYSX7GQOaOKMApWCAZ+RulUC2M9CwizwCiERpeQ5/ZfMaYPzD9jEwlixn5BQhb4gXmURIEf4UECboSIGsM7/HFLb3fLA4aoGIBiWFWIQFmDTrM7movn3bz5SUswBQoCaarWOUibxW8ug/R2eD95mLeelEDir8JwAoxT4nKv03kIhvPqY2UfF3xKSBWNbMLTn4EcXi+UGPDpJafLTgfoT7IC/FWC8O8pALF/kLMsbp4IX2Sgd/cifEQ7LbpfvqY7BgG1btDqMPUz+P8id9RorBUP6+TcdwevJKhMoSYTBE4Bt533LVo2qO2k2N05CR//DkrM8FChDKA45INrVeVC+SqLqKWUPM/EMxko9w4HgghtANWjMjudQLs31D8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zC6SoqnT9NDvZLsZGFLI4dJjvsyVdwrBJ/gGaiHYRhIxxfnw4SxWMIAznfv?=
 =?us-ascii?Q?W4ZjTI2SXfExHFKxXw4DvQITkByg5SrIIlY/JjEy9pDLKd7hIYc/oZo1Bw+2?=
 =?us-ascii?Q?svtjb43g+5Ci2q9Io87Pjws38PSAw9ybrj64lbQeEkdR6Cg0xZHTS4gCX7G2?=
 =?us-ascii?Q?zNAf+k7Xe+JB4LaOe7hhI2YkuM5FkjtNJrY9eaWAihn5kS93LcPLB1MWxr4T?=
 =?us-ascii?Q?F8U2xiLJ9Gb9klIZOA6Lwj5lACNEI4lH3XPAgUpykwhlDw2TUYa5y8/SNv22?=
 =?us-ascii?Q?etW6XeeSeDzt759YytX/WStnSjky7gWmLbbG2gSLtuw//Dbz+iI6mX4QTlE0?=
 =?us-ascii?Q?tsiWRbkIU5qeDpbdp2MN5Dgnt3BiTvqZO4T4XNYx2SxJqyrCsHOD/J7JiFIl?=
 =?us-ascii?Q?BMsYpdSDoasztWl4VMBaZkmydTxRUf4ZuOg1jaruEhhnFPWLOysp7LA3kcyj?=
 =?us-ascii?Q?EcyBkwJ/1XYJAqkCbt0PUD6VwooDbYKR5XRePOD4FMmYwwawTy6o/Gp27T/O?=
 =?us-ascii?Q?aZX2gzsYXLnfcOOXlmNmPm4wBFgrR+nX0VPrpj8cl5o10EUkQ5qLfAPBn13J?=
 =?us-ascii?Q?PsFxqeWNZhUNRa0iTZQenX8MOTC/Muf+VH7YeurZ/1qjcPVglpFWxAen4jJ8?=
 =?us-ascii?Q?l/M3P4wvfp/BwknY6Xg6KaOvtUKIfInPj19WH1U2XzWb0sQrR6NjdsABaU4g?=
 =?us-ascii?Q?XzvDySwM0FUWwaZaO3Qx1V7QN1WZVhwQPVOtLrlLH/gXYeBwFtEZ1a/nHnYB?=
 =?us-ascii?Q?OBymmoO5nJQ4NGkJaj4xwSUnsSNgJNp4POnpj/BkArT8JDhpEdgDc0DItnA6?=
 =?us-ascii?Q?S0Z/WliokzPh4IuTOFyqXGd9PTXW8dn5Q4kRJq9GYsI7ebkZumQi9X6PIk8g?=
 =?us-ascii?Q?yBAcTNTnplS9EDquA65J6iD8tzRefeE13ohOcN2p+tQAfTA4KwAcaysqsdms?=
 =?us-ascii?Q?YgMjA097675N8iESxan5HxiD9M9OdutlUaGiLuj2waHZ8j6OoKQQk6Sx5R5U?=
 =?us-ascii?Q?KTpKkPXGNQxGoQyMaQkUeMH1wsyqT9pSdnKt1Qr6RwXssDJhWQLKI9wvm6nx?=
 =?us-ascii?Q?vM6K+a13ewuhsHRXRkirNlDtlRmlyglejCY0Pf4B3TSp+DTfmeFUu+zyNYDd?=
 =?us-ascii?Q?CVGX9O2zxPrfM1+AjEK0TUGzHL4B8t5mEq4TamwFmMupqUvUoBXBE+cIlBih?=
 =?us-ascii?Q?Yep/7yY99YH47IRuxwgf/5oZYcSqxmSAn6FhTUVbm82p/S6dadxF7zvCbI4w?=
 =?us-ascii?Q?bj7aPvZY/zYzszsPnN72VxjWMpz2dWrjDIBgDlk8SWxiSPUTxdJcj87ElxEp?=
 =?us-ascii?Q?FCzoEKdxhX8ldcIdh/NaKwUNPXnLGqBmRWBCo/XAzodccLjsn+2Glqnezc+5?=
 =?us-ascii?Q?qNu6BB1OXP4+pjCnkn35hABgxOx6BUwudFEpNLWYYLggS8sFmgVbZEKxrdZf?=
 =?us-ascii?Q?2D+qQTtFIwMPM4kLcJSfC00okktt2Oh9Arp/XOvWn0NrxnYQQqidi2fyEGgo?=
 =?us-ascii?Q?PTSR0dUQGzmMzSyZg8PeQTk91uXnncC9pJ+KbVqCpNZIEh0KpHgKg/N/XD8J?=
 =?us-ascii?Q?i4uj9ZtPTLLKi+m/QMC+RCjUqkPZB0NK0692cuV+zAI2POtpzBzkkawEh/hB?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c339f7a8-fa34-4eac-1a04-08dd083ebd15
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:11.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnLQPFkuGr6dEH431KFA3jvQWtKR7BquN2iLI2cFBcrCqU2UZIGpUU+lBvqaZHjTEJPYaKg1R4xR5HtoRcMa/SyO+xviwbetjkzEch4bJ0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

Get product ID and the other information from EEPROM, use them to select
the correct DTB.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..22afd76c6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,36 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	} else if (!strncmp(product_id, "MARC", 4)) {
+		if (!get_mmc_size_from_eeprom()) {
+			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
+				return 0;
+		} else {
+			if (!strcmp(name, "jh7110-milkv-mars-cm"))
+				return 0;
+		}
+	} else if (!strncmp(product_id, "STAR64", 6) &&
+		   !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

