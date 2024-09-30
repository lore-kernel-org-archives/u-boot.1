Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A0FCE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFD189021;
	Mon, 30 Sep 2024 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C3E88FC4; Mon, 30 Sep 2024 18:55:26 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20700.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F6388D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ88m61JIB8OuRAH1yQ/dq5sdEViSCz27ckn3jrZOBKB76wOrLMX6pypOdxkObMaumAaPzmLC5uXbsVEgXXT71C04znRiq6yV2nPIVabdM9LpSrXKBapqddKpPABCsqGmNN8XdVuERSPl1pJYG0HQwyi4iQScLvxyeaYjKSCxCCM4fn067PaHsAilnrYvZWOMdg6lG8eQ9FeSAiaohX8jSMXuucNi3WLM79dEFF11CKkX9qgmhdhX0JWJ7X53Hq2/X/jBW9KsncVopA1+XJg0cfAusbM1PWpz4TMlHMlEwF734Tws2Ee967pp2HSd5aD3EGLxoyqVB41ql5GzkJzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ2hC30gC1FbCBy08/lF8MskS+yGE0b59muC6OcAX5I=;
 b=Zv42b5GRmmENufEaSDZooBGctFJeS0Txw9lFUwK8Ux+6LjcJvozO1ASIs4d7P6RQqpQDDwfyP7pcb3ScobLw9bSlcx0deWzjn9KxRPfQb6STvfH26CZET6+07az09npjKOvN0VQDn4kMPKaDvccSKu2OuNFjBXH6mEt0mmdjsSAsPQLy3pIOfRg54emx9BhkJQIJ42wmwiejWcDIhYz4JGpioFmFq0mHSGXjAngXepXWmE1DaqOKEznrn5WC4/FqUn2aRxqLu3JxAjKdpNcioTmTdsFXuiLKiLoG2bMY8CB9VpfeVoZITWW3BXjZY/P/sU+4dsu3aoPsMdn9b+Zwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:39 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:39 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 11/12] configs: visionfive2: Add OF_LIST for JH7110 based
 board DT
Date: Mon, 30 Sep 2024 23:59:18 +0800
Message-ID: <20240930155919.111738-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbc5896-88a0-408a-a71b-08dce168e3aa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: VfqamMDGoq99+heQ7pgkv7+wilBH+LULdvtcSbgEpMfGa7JH7Ru1NPC4TNkzm6DZixhfbIYHTBJRmA+ScXhROgdAGu7E9ikLBcjTGm1CiQxanoRnHOh1xLOvtZRGUcB9907YRyjQSytjJxbthRjzXMaco5e4GprXN1LRQ2lCU/g153i2yzC1Q7PDugoYpDg1YrGlX/jzEE8x2AmaBBEidXz9CCaLMhO6eEuq4h9t+ZnTh6fWblc4bTcgB9G/DvQ9o7nRgCaHloCIpSijCcWKBOIm+5xHrNJxbUSUPBu01YI1VV5lLEa9NtLoTTaNDC7HoVXjuAfg/IjZBZWe9Y9s89ae2N62NVqlg3V1yIB2Old18EqiNoNX9mOgbGuZIJKYHrZk7JxMjhkXWbUG93xA+cuiptECjj33wjw2N2NIubgGSXqTrn7p4P1tIm41017cqKPysJRd4rQ0+rOh3BD9JAzXl6lyPXuRm9DjuNyP4sa0DhMyKBuWcyxIp7CmpAvd8Uhg0XsyOpdoo4VZxGnO7YjZLJyUI7UslQ+6ueXJBHYaLSJLC3FYxjiabWFPHVUJTLTXD1sUnWuHaDLAdu0fnORMZ8wPVEVDnMsK5qqjtCsowsfAR9pEbOeo/0tga7zp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHc02Dw3zEMp6H7WhEm5HEag131XNIdTFYOPsILdId7ckMRmeZR8X5OGCKuG?=
 =?us-ascii?Q?Q0/EwMwRQGOmOefeLB+N86fau1IYJqKd0WRQ18+WyNADPGsiqD8+xFGTvval?=
 =?us-ascii?Q?lNL3FXBIB3KmZIM1bJdB32b8Qz0Y1r0N42JUK0r9q5xDewUecZYysLISEd5l?=
 =?us-ascii?Q?Kz/ztBos/df5Bx3TJlxD3jXtmHn6RA/hfMX6vqk3+w861vGYS2rGey5H1ebb?=
 =?us-ascii?Q?yavq8JZtpjEs2y9NcfnGH8mXCnUq7kGo1uoM2mdScETdIUdz9BGwuMbRnmhN?=
 =?us-ascii?Q?ONyvsa0FJkZ6HxckFl6rcHTmRvg4ztC2+C7CO2eG293xbiVszuDtJbH7S1e6?=
 =?us-ascii?Q?QLrK+b4HQowDMTHUR7F0tjlaypCkyeP0mUHqfPpeT1ZwMiddHjuq967ZQ+c1?=
 =?us-ascii?Q?O1gsW8ggVvGsEl3JK8etkXZWnsbV7jYEn13cq/Z2TssCH07ivu7Rlyw+gv1e?=
 =?us-ascii?Q?uHb4NGoL/en8XiyfNPD2K7Kp9BWJ2qyngyhT+NduE0AaMIc2lMbJ4rzb9mzV?=
 =?us-ascii?Q?l7YCb0IYuzwTxIpRytCMJF47gx4qQ5YKy4MoUuc0Tex1Bl2wkHfCi38nSnOo?=
 =?us-ascii?Q?9ZeWgEx5bqk8oFkuwcywnNNepbGDVKNJCur3/rW2oNV4QdH1W+QemDShEIQ5?=
 =?us-ascii?Q?mWLxdO18jUl9g3+3MHgQ/IrnxC0PR+jE1JW8xBwrOYFiSQWkrvsOX8zenjZ3?=
 =?us-ascii?Q?e8x5LjkPtNPmskcoqvbPC1DvT9bx913C14Aed+gZpKPBjsPnz/X/zaL8dW2z?=
 =?us-ascii?Q?GHTXP4kYOuh61klyVsId51H+wKyt35tqyJdbcwb7zL7MXv3CnLJqw9oTkz3w?=
 =?us-ascii?Q?NFWNLtg2xOn7HYSs4oUhUhZlhZ62+kBjNDmlacdxL6Bj8r7OwcJ/X+tOArUg?=
 =?us-ascii?Q?r/zypP2R07sdcaT3i/yQt89BB8rnwdeQVvmo1hvMmAAcYOAgTdzvRbW6m1y6?=
 =?us-ascii?Q?2ur2KIydtVhiS4ARtxaiLpNGktuU1uD6IxXB/w2p0G4saNKI3MoCTadmFUJ3?=
 =?us-ascii?Q?WGH32n7bOsMo3NbO5r2JstMbArWyoewPCq6XStmPFQdUe2du3xJzXwLgli3h?=
 =?us-ascii?Q?WrbyfUlMve/rsU+qxKytZPO8tuxKCukrZwoK7rAaajEsXk3rpxC4/m3m9iaL?=
 =?us-ascii?Q?OTV80g49MYhwp3LqOhUK0dUcCkZlCByFeKwpWfwYvB6r6j1H1PZ2bA74pboH?=
 =?us-ascii?Q?LrMfSUTdiXd2J5kHCyjuaAKD2A9BhdwMnq0xJAbgFTHl+H7Mtyu9SsYb+sMv?=
 =?us-ascii?Q?UkvvY5lwKkriQfombLHFn9hc6Tbd1jKPBuT+SylbU4dw8XIuNzUQVUnnxUtH?=
 =?us-ascii?Q?1Ir2MmOQFEsSpIZeMMHFylNvzmCciupHQpJc58Bt4xMOjTDoc+yHF82IGwUz?=
 =?us-ascii?Q?tFUM9bBa/nejrM71Z5ZmgpkwSWPB6bCCMTw3hRLUeB+pO/xMzCniiMkKPIEs?=
 =?us-ascii?Q?y1UXYbmqQT1MH6589BTVxn8HWFAnvk6wTgHBNmoTBYNvt2bJXjLccMTvscfi?=
 =?us-ascii?Q?S6xCDa+HjgpM7/AbhP8jNDiznpCX40RQzS+wfTwBScAV1m6S0UgxwJxMzem4?=
 =?us-ascii?Q?7llRfPuAcxLEgrUMP1yRErkMql+K+D4o7GMUePeDiVJIDdBGxs2EgiIMy6Qk?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbc5896-88a0-408a-a71b-08dce168e3aa
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:39.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgTaoZ2DMgqOn1DIVVJqu5qxE6AjT2yGaqUbb1yry+DjSXwMrTV3Iz5H7dF6h0X5yIcUuTcyRyOlWqREI5R9g434aMjjZaWZr+TtKlgrYzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

So all the JH7110 based board DT will be built by default.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 0068ea4d93..3002e75468 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

