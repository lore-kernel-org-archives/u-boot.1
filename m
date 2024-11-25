Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAF9D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AA3899E7;
	Mon, 25 Nov 2024 01:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1511B89559; Mon, 25 Nov 2024 01:33:42 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3602895AC
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEdPKqdVFBr1r8oV3t4PW/f23K8LflQEvEOx4X82E4qbF5vWDI4T+fjNbppSQb9uTQg620Gm8Ws1giVsYnK1pSfsUXZefhsW1PV7uaf8cvMEDvAvR61D8WTYVim9Rlhg290KvlvUecJyw/IAmwu+OuOUZ3kK/Nqu0v7np6jUuQLMvruDkVHrrKe7LwY5HzXRQcezg9Y4W4hfWkTWXS2XWIFzxO/F81BRCFSsyA8qFMpwy8QrZ0PbFW+mYmHOAk1T9s1twrFhYQyjIHgGgyYFpT6uZ5LI8560BBg1bhXo/kp50WuWeN01/fJKStkNHD+bFkzkoQ9DMoa/44Pp/dkwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PcPxjGV0C0vB5hDWlFH+gle8PPq4Af1LotwjNzs6y4=;
 b=kyurSG3NCyBfUbQa5m5BbOo3vWxGR+rkude56PZ8HTURKLOed1uNRhb/3vIYGWnM6vDu+/6RmzUrAkNuBJPNKvbUViP5Fq+vI2vlWXuT5Sm1kVUOqbT07zRTRU6qIkMmR5R8kidp+1RliB+cONGML5goaqhYxgvpSsE4g4Z0ZDMC/oOMWrqgbhfh4aU/BD/NgYjeeLQg70GFeqfsbgWaH3Ly/X1vZgVbPvZPSNjPJkwpEfIIsJy2zvEs+GRt9EIdUIxr9eWSLiqkpk9Y1tIY33laqDTRcFphNbF4XeHSsnr3+wfTFeL4Ph3uUP6qDbfoeZVYcsc3v/F3n+/ANFsk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:58 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:58 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 07/11] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Mon, 25 Nov 2024 08:32:01 +0800
Message-ID: <20241125003205.75327-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c59a68f-e0bd-483f-823c-08dd0ce8d9f2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Ii0G9TIgGd/3vDgkAgvDVc8jW+k6iMcBaed3Vjhe0X2pjeDkYDySKVOZfIpCadzae6qRXAMjNQP18SGmGaIIJU+66SojHofDJk0n70p8Qw50KN5jxEvu4c2BGzdp4SHR+/sfU0iCD8UBNAUHfUX+T5mivxZtOhACCONRpRI8IGvYpAHW6wvC5hHHVqE3vAF3yL+p3nkwBW0QlednkbXru8CDmLS+XAou2Aby2bswTASeuNT+l9gF2+BtWuvO+XmeDdH7Knbkzc7AB+tEkrxGKqaaNzduUe92vBC0H/xMJLJvGJ5dblKdJLO2e9xgnlqJIu89CvYkCEejYQrWIsINXqPWq6RsDXKcPOLJwKDcabp4oRdcH2E9PabDbzR8HOQdDVFtmZNlXGS3fgqx2fdmhJ0237ah39NsqykcEV1x/eHfpbwMmNB2LaLm3jlWO2XK2zuXY91gAStaYpDuSPKbMrbbp50cCFXkQrDK0CU46k5EAc4mCU97Hhgmq+E7zJ2vwtj9drq5SVf94h7uScT9hP5SAO4lWLlOpxJHUZDEeyZLTxXoxz8e+eFltt2Kvq/tGx1aTvgpqb2tTP0vKhFF/7QzHpa9QqaFM457CB9niJsyOOirF/bMahi1C0JL2IxBeNrwXTO2VCeKApTzjPe4Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZl0MN/efoDPShDt4fktltjgftUb3BNGqDLGs8FpKYKUcQ5bmyTmx67W4iTQ?=
 =?us-ascii?Q?h0uY5h00Xx7TE5WPbhhX0DsmO2w/8RugcEAHs7ca0Uvv8mCAB7ntIkopODF7?=
 =?us-ascii?Q?5KSnjk0njPotgHuxrnUA96U1mzbADhvOx61f+RzQF49aYDBSsWzrEGRL+yTs?=
 =?us-ascii?Q?+RhW4KRABH/VL3BqVL6Tf4d7Ui7f1skoKnWbz5hjo6CMNfj/AdHorJsCMQI7?=
 =?us-ascii?Q?aBFKfYEjHaDRdiPcIDlqF9s4DSTvWCgEoHpMcUzml41Xe6h4w/SsJPklYDY7?=
 =?us-ascii?Q?a4RNTiVQyOupXrlOqd4FqVFSQZvhp34YoDDRyOeblrSLEfbPLSGAgLC12C8q?=
 =?us-ascii?Q?XNVw+KTok8q51sFTER8oynUtXiEmec/dIaa6PATPF2mI9hvFXwSrGMJVk3E1?=
 =?us-ascii?Q?3EISG/dC+QiGNUEpRIEUMv3jfdxJztwSD319Gq/ovw1ICXwk539MisKR7We9?=
 =?us-ascii?Q?Pr56G4FZDDQ21QnqFFuohSgPpfMHZ0dy48zJspJC+DwmvjazRVLECc8ME+33?=
 =?us-ascii?Q?7E2Yh2QNszJ2eU6dkAP7JogeLaQ+wAk06GGGrzzew8UhzObSpFhyZdEpr62q?=
 =?us-ascii?Q?bqwC9ZI5AsOBE3vvlpXh1O5u9F9MY4gTQw+w/3HiRhDPLNKcu9E2BVIziIiV?=
 =?us-ascii?Q?BMu6aKM/FB8K23fL38r5ZPpOwUobkybCOfP2X1lEMCZOyee3OXUNKD7D5ddf?=
 =?us-ascii?Q?zxcZM8zCTXtea1XZZKOvaz0PCRosYHStE8iwkGL/zmP055BSkSCniOUlWouk?=
 =?us-ascii?Q?ZqW9AijfLBSQ1Jy2OAnNvD2gmzIWD/ZnNDtuBt62jya+fc64cUqcJ84qLny8?=
 =?us-ascii?Q?FD3o8J54mXFt13nUuNo6oy3X1acjLWtqUCRMMiN6I0NRC3eXGOh9ASlf3mKJ?=
 =?us-ascii?Q?HZmpTP9lEOFZeUjyf4d6wh8JNgqg4WOYRkMcWOO3Of5FBSIrGXk9UYxePxGP?=
 =?us-ascii?Q?vSqV/M3od2YzA3p5l+eM387Pl0WzGgXy3Snsvw43GmJB7mEoc13MgJDQoN70?=
 =?us-ascii?Q?Vo+nB8sSoz71kbVie65+GNvlE7UuGsz0d0Gc5kTVG5Riro4zfNXASkzvfExC?=
 =?us-ascii?Q?8cso46fdSrk7KbCn4Ip2JZY8O/CFVJHoe/HW5T5HCupBC9m/5rF7ltLPPeWg?=
 =?us-ascii?Q?xU/BbwN+SN2taiwn4m/QztKSlsGo8mL7FnUHMtVTOs/uhdavylEkdzn+WX2i?=
 =?us-ascii?Q?zHGJKduVxngKnl8lOpztwHdQTKftBAQKdYKZym2GU7ppkThgg/+5Plry+AvC?=
 =?us-ascii?Q?qNSzYE2uQYKPIQvioDgdAuqPXn1YvTQW7qvbGCxqeiXIell1jxx0Zvwa7gTl?=
 =?us-ascii?Q?sIO1H61vni0qao+nk65jqXXMnPddYb2ljZpJOqqHHumQjvH5dz4+nXXFVDZr?=
 =?us-ascii?Q?lE4/6BNfl93r1p6l/kp3mbhGNnPgCZ8nPf5eu+wBsEfG5PeyNWT1eMEsU58c?=
 =?us-ascii?Q?w8/rwvQhCVSMY/1Zr7OOLuIBroK/mfpuJ4CQOnD7IGtyC4YKxgTNN58uLdtC?=
 =?us-ascii?Q?QobrWm3hg4TON8FRnGFmcvsUQuX7SBKTLci/CQ1H6a4ZR8fcJSyInOlxIbyf?=
 =?us-ascii?Q?wCQsqSVVK5N9MixoJqmm+wYBax1+P+1fh/E3hBPXXI6qW1Mc6LMJ3wftdLkp?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c59a68f-e0bd-483f-823c-08dd0ce8d9f2
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:58.6515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2DfSOxiaaf74RIe8d0/Qwc6+20jt8O5le36lUdYjYZG7k2/t3oM42szReeX119rdrP9QGiuHV+WjsI0B7oOsGdMMgk7rAFaZXHn/uM1PeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

So JH7110 based boards can select their own DT at runtime.

Tested-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index cb86582fd6..5b7a94ddee 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -79,6 +79,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

