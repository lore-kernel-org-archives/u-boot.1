Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7ACCCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF6D837B6;
	Fri, 24 Oct 2025 16:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9738362A; Fri, 24 Oct 2025 10:59:50 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C553836B4
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE9Pov6HGRveHcxg02lwziQQzAgoyfdkBeSLfM9jMZa63cEoMPvE9WJ6boxKVvL5TU6oysWSB/bhLnl7SAuRBN011Q9ltdEb78UfutCCue9iPfDQJFKDsDxgN+NFkv3cqKbN2MiceBSQg2oe1W6PxxsIXuzuxiVCRt4ijFPf8EVwhLPYImQK9Q2PPjc4lj+5uuI1Y99DZdKOvXakV0/XsMSee9508hS/CH+SFx2JXfj1J6rpJVuE0/Z8BrL1lZ25YvVPHHBvH8qI2AM0n+nhCmm86oatFlHF4qNLAv3DPfLbJl5dWt+xvAAPWMg0cuxSom9X/wMzCKNHzOzVtnj5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yprQeikifstwLkDdj8dO4VY6aBdQmHtCOk56ARdKl00=;
 b=c+bfzJPVRf1yY9Zxfft3o+NiXkoUfMjLfcHBbg5U/WfbaxslLZbJdL0abeSo5lU5mKDBjr2j6UrD3Mx5YJNlVHwRBq4suIZu0TVvAQDc7DOmfXJKx4Q2UZt01l13J1wYH/al3eQjFMJiXBih/oC/5Uxa+JBgXrTDUzufvRPPxRaJbd6ollvhTnNvW0Jldyf72eQp59mrpom+nbOQyJ7auTkF0mOG4YCdCOL/M9n+fZJODIdFTxsS7TJ3AUWrxaPeJkyoglen1l5/gQhtJ9IKUhIrn8jefYZ44Iz4pMm8T9KnUjkuRf/1mHgrS2+U1mD6gXqZGxpHYUSUUXRWnDHHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 7/9] configs: visionfive2: Add VisionFive 2 Lite DT to
 OF_LIST
Date: Fri, 24 Oct 2025 16:59:30 +0800
Message-ID: <20251024085932.83596-8-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a30452a3-62bc-459b-5fe0-08de12dbad71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: sXDi5jjqnZzzt0nGDYRQN95LALI5YarfN/CheF3Mj67FE1VcPb0l13/NGuO3WV7ungJeuOtiQIjgOj97hTfSnZi3Jzcg+EghUq0Y+XjweAt5HaUNIZC3oMEsS1IVhhIW8CmLguzmO0pw6cZsW4FtmQ4+8W5YgU/VKBLU5+7wpQGG5n9nN8TZVulTvD0jgs+dCXU010f4XXYXL8Wdt4S3uxbupfccYMnSJdvriE05OltURb9G9fzX3p3fIq6FmIA/zwCMHwUHsIriKbGylQU4H9tsP7jspq1xKC5im1dTnnp8ui276Gj1PpVyJOVX++CLxkHTz3R9hWQlDTRoOq8qO3BXtt9FCxVJ+Ddf8K67DTc7uwjipI5PHS7ZfbvgY2iIQwvFC0KMgtK+5JL3+0IqGt8eprjcykqHlC8ZoY2horxc9t+WAVJ34B4E6h1Blqa70oVX64vlVSQAktH4IjWH1aTySVIF/gmZeDWDn07kXqrMU6SClnF68inQUIrKd675KA1eAgXRGh0MskpPGh1QulZHjB7uWbU2+ZHVqjm3Sf30h82hfp7Fa1cEiyb45Bi2RHVIqpYGE9aE3OgN9yCIdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSUrnxS92rvDtLZRT9QPTU1KTurynQdifMRPG55YLjvqAKP+J6WiHTZj41nA?=
 =?us-ascii?Q?8/niTC72Im32JGQgY1sFMA0XS+30ufFzG4CkqGx2gCE+jwtTHMkpy8RTGK1x?=
 =?us-ascii?Q?em04xehCYio87ZVw/k0msigd7HaIRFipNDG2Tggyb3BEmg0WJ9uE84cK+iSe?=
 =?us-ascii?Q?uA3wDY3eMf+6HSpVsprHB1jJrQ/YWgJVivlFK637bcjLITiWuezkRiTGm6XP?=
 =?us-ascii?Q?kOLKseXBjiidDmNuN8y9ySWTQL9kD8heWBMkM7VJjPWVIyie/G2osShvOpg5?=
 =?us-ascii?Q?OBdWai6ars5lffPsE46qBQfEX+ds+HqJPeu90GK3YwbAgDXsE5iA1orLuvI3?=
 =?us-ascii?Q?IABlsONFqZyCCvZekT8CnIElIZFFymZT315L5Jtf21AhhjkiAKvwKGuWDQ+l?=
 =?us-ascii?Q?qEXx4VEuwgvkcWw1ULDsxxT5K19/c0iG7d72SjxCaY/uaquplRJlYvcCDH1+?=
 =?us-ascii?Q?pQxtoHgYXiLm6RvclkcbUzfLuP3OM3Dt3RuGw1sHj9pmidFqIRTjvYTYfvEB?=
 =?us-ascii?Q?DuX5d3cfCom3o4cjnueamtlScPcCBwSSAiw2h6aHU17+7ee0sVMk+alIkBE3?=
 =?us-ascii?Q?0aaeqFB6GuRw5upJCBYGXXKVeUWLL4u2WxByZXj/jWqAUz0UtuiMqzfEUxzi?=
 =?us-ascii?Q?tTMdA2dvz8oJatdhwWEO0KrFSIjEdFVv8m4UMzlXT6OKTvPaATfrXTmI9lvM?=
 =?us-ascii?Q?LXhICC0DYtmWc1FZbbWbRStQUH8vLVy0ga69wKqIBfoH55HD7o1q5fSWYZ4l?=
 =?us-ascii?Q?nZloYXqTirQ6imkknNwQDbuqfVaX3xTx89EC6eoNr/qRNsoRFhz9RkLSnDPQ?=
 =?us-ascii?Q?3yOT56x6S17bytIWXWKG+ZrXlmmrHS/xjEQtlRKWJkfV/LW0MGPAes8gjZQB?=
 =?us-ascii?Q?CZAionn5ntwCP8QgySj2NqV+3ROWT8OT4ibeSmYT/Myss6c6+yoZY3U3b0O6?=
 =?us-ascii?Q?VnCxqncfWNsoNjY5ZcTIm4kBpAhmDZ4oQMOiXTUkODR5U+nMpjaGAzjJXw0r?=
 =?us-ascii?Q?PVoTeiBWDRBe5xNYJYrL7b9hkt03RY7/PcT8a1YbWIvVbchVbbBnOzxIBa27?=
 =?us-ascii?Q?d8635kSowjJM6Ph5o5FINlieJx29576q+9NnF3h2n/4B/vPumBKqsIspXv9v?=
 =?us-ascii?Q?04FNVIaYGO/1oWUbjwhuf2+9/SMaaYpAE59TN1Dg9VqevLMKN6AcGLjO22Qa?=
 =?us-ascii?Q?R+ucVz/fNkjzWoqrhtnIB8o474djtPkl37SGHAJWoGKOi6eJuDHca04INoJI?=
 =?us-ascii?Q?1zCMf9C1a1m/1kXifeFoQZRmHZk1M4J50zfAvCb/mOY6sV7JuvtTbttwRh4a?=
 =?us-ascii?Q?nJQHAx+1WMjONJ5Fzxzs7685s4ubilLtns318M0afyUzoUBeWt1VBSaCcwmO?=
 =?us-ascii?Q?YE9P1Eb86TJZa8L8Tg1coJEUP/fiRpQzKujWUYgxA8IeLAN6g917cHpo9rgp?=
 =?us-ascii?Q?T8XL3uPj+ih+h8b2QQ2751v7TRKkzC3HuR+O1dzDClhohRDpgF9TI79T57hz?=
 =?us-ascii?Q?bZLlXlkYJekqDj98IZ+pbQxDpc50TlLil+F8pwgCq4XCv7zY7XPFBGSBwZE8?=
 =?us-ascii?Q?6w73/EKdRAHHHSQoS6KIsTyOr3qPFuLpUKbTnD+a9aUaD4Ev8MYMqDv82C6e?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30452a3-62bc-459b-5fe0-08de12dbad71
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:45.1302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYBc9yl6y/NwkCJ4gv632x5lao9TBh1ZHKluDkbcmoru6RQqEgveVOhS/Ch2RAYpgSXDWwZLxEKr91KO+aB7njvFbYensjx/bjgE+STVpF0=
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

So the VisionFive 2 Lite DT will be built and merged into FIT.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 34ebf3b605b..005091ce1f5 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -79,7 +79,7 @@ CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110s-starfive-visionfive-2-lite"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

