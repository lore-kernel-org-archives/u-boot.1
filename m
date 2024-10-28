Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B2D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0228907B;
	Mon, 28 Oct 2024 03:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E9189038; Mon, 28 Oct 2024 02:59:26 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C850088FD6
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQSfw/bKaLedNPJkUw/7DePkRVHi17qlT/FmpLl/iCuLWo5v4/ZJryYTptROQz6ZL5GyEdpVCrorXVkydo771KEu9TndqArJsX3i8XNx0EfYQrcGz3izyUWx2boCat29BtgpGDdYlo0fLYXdC2uVVQdT8x4www6IVcLJeL8LVQw4zv/L0h/bKQPF3E7wIpmewkUAbki0PRRG/d37qnSNJhg7ISJwrWxaPqN6k4q4AiUyvahSTyyN4T/6qXEa6OsjaqkCgEVJN5b7+6ha0bUQTmQY84F6zGPWSbth396hXcpajP+1vu23Cwse8Csn6p9Twr5Y5r3byltwyrfRGLp8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHCwNLtx57ArSijWlooUdWvaVsp+nu7Pjq8nUP5RFyE=;
 b=M/Ny5ZLI8vqFpxUedtAIxPpyqPFXTofoQeQfzwDxa3P9SEXDRXlr/TeyZJN33Qmvmg8NFIq5Y0br2b2lYuJUn/SS7cLlTKylTYGqay2XpQTwl7nXLqY8T+68oCL+k+H2+SWJmVoWfdwtst3X3ZKWw7b/erWNS0l3DAMhB1DwwO6GwfaIJgxJbarPrqhDC05x4N8c73RivjVskHS3d7un8AXT974lWw81GHeZPTTcsGSLnxlTQSvB8FxFG0Npg/bQ1Yg2d7CpMrqzjRiBWW3ahLZyGgKp2VvsA3zF1LrhqFrLnKEcIItJKSOhXvM+sBkfR4TYVSDlPzAb17liBnn5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:18 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:18 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 13/14] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Mon, 28 Oct 2024 09:58:46 +0800
Message-ID: <20241028015847.42344-14-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f65897-1344-4f6c-77b6-08dcf6f42221
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: MWGTNtgVts0XqE4xF6g+TRfGaJd0/dvnXp+fo7BTmxBUiXKBYU78Z9QdDJt5irspupGdwIKP1z1iCljZfVo9K50HVHXtJRoYORw4sVRgR6TjIaksF6FyVG6BVoXsPeRju2ApmAFXjm9NgLjK6UD3ul1nLca7WyMCw65pO035d+krlnuaiDcoFPcjKtVQarv9BRZGFo6A/YjLW+telx4lfXlH6LzHHmQgrKDtBm6rLhkSq2dhmKAbs5AHrr+oydClbvTXeRGRMdG7Cz0U191S08Fohrue9qWEnzk9pXnnRZWDDftbcr0rmk09T0lgrn24njLp2MX2NEOahPlm0lBlyZ7qZLzNA60ONgn+Tmmb3hiPkGUPD/QZ9G4qDMXoebZ/dD9P0Ii2lqwgM2WfmK7jxE40ytVtrKYjLrUHg6xml3QWsyW5jUUc4y7KA5IadsNDL2Dav2Onpriu0E9usJk9vVnPtXzNJd/J0vI3odkyiPzmradKVu9+iXydxX6iiC+q0wD34tMjq32JdqoPoMFmdIjo7b6Jm5PvApjEATj8Q8xB7xHzKsTCLjZV2Hl1VjC9dt+kCNT2BlwDCIuTSYp9uj9p8TugRi0dEwxeo3c/aB0yOry+KCjM1l+//UQNIaMM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/b3iJDvAXwec+fQsPUsSXPAdzobA3GvWpUDTQbumYOk4rHzqNRCctb+1csXu?=
 =?us-ascii?Q?RcB20v2jB/6hBsFWoqg/Qkta46nuEkEgBBwXgotFVoSO1EIWi18D7DE6Cy2X?=
 =?us-ascii?Q?fz1SYR5lQPY5o/Vdezzew0CvI8D6N+n6JE+LFtPFSJ10TZ/koJYHuk7QSqEL?=
 =?us-ascii?Q?H8+IbUZKWDe8IBkGwznbcEyQFjdoREtHsfNMyvB38xqqsxVdKq6sDDsakzz6?=
 =?us-ascii?Q?rLEl21kY97SXZwM6pNW8laH8IvUxmvJxf3FriPqUDaNMWJauB+HlkKlHQJUk?=
 =?us-ascii?Q?9w7sOG/4zq6Z1Jfi8JMEt0WRk4wYTzpwP9AbEMCZGriSKmtbdmzhS4w+XzdZ?=
 =?us-ascii?Q?lO+06wwIIBGUaIbVBAss9Fkxu8e5WN7u+y4/ypFHgMDaJxzZvFqE54hu7BAw?=
 =?us-ascii?Q?/c9F/v+Ah1sOquTqp6dhVknbpPMDGv1fniCOqy8VeYwkVhxvLqtfCf+yg0Go?=
 =?us-ascii?Q?gRQEGsnJ/R3+9FqPik0slqybGoYobctZaOTXt7tw4zK9ApyJ+Ei1yLZKnjBK?=
 =?us-ascii?Q?29aaSheWlBAflFg98p9NLo9ca6VapfEKatH0d1mJDqnl0TUxNGZhHwWy6bRU?=
 =?us-ascii?Q?apnzjEoOHa31smQcdyBLBxxVOdLJcD/jRfC+IFjqRcc0qJEpCoYXWa7h5vS8?=
 =?us-ascii?Q?RNnLxcwNcYu0sP9r4tbbpVhRADTL4Qoy7eWmKtEIq/v3OD5zrTMSmbE+RtL8?=
 =?us-ascii?Q?PaxchsCjH+lEMFng9SbWjIE7HIscJmmWJb4ZJCbxQHc40uOBpf/PmRu734gU?=
 =?us-ascii?Q?HwN2e5a/XBJ+rYq1UY/U9xNRXpMmM94rTQbSEFNB8nj+YL7GSkJc5clCzeYr?=
 =?us-ascii?Q?SsaWQl2k15ED8/CBcUHhph0F9o+CyjJZdOw6GSjZ4SY7d3xyCu+UdoHPFxw7?=
 =?us-ascii?Q?mMeGXbRgLI1nPK80+N9SzIgKBotIvsUMRU9SwzyYWOccPyIh5ZdNKyIkJU+2?=
 =?us-ascii?Q?IoCNdlzyOMHQeyCXaZTwiP7nHE06ikwDs7LPwZc807h9+mKHSiMvZ8tPx4r3?=
 =?us-ascii?Q?h1BviMCQLtbZht4BuxsvyclOVdN7foT6Y96N8MJ5M8B4qkCObTAopLpOdpxD?=
 =?us-ascii?Q?Sopkxel/HVlZM7N77FUuurH8khjTAaSvZmrb0H9tHk8jloPCtuYWjmY0xkAv?=
 =?us-ascii?Q?4MqaMkNJd8pyp7WfZUL/O1wDUc9rfz52GGtApUD0iov7vYQdx2jzzZVqjLzo?=
 =?us-ascii?Q?FIBLBrDhpLLleJAwlmN9vyqiCmwYBnkE+9+hsP52uNJglTHLm1RJ9QtuXZJz?=
 =?us-ascii?Q?cjrdY3T0h3S9y3QHBaPHqNhCjBmLJo6yT7i5/iL+l3b8cZZ3ElNQZQ94hYUX?=
 =?us-ascii?Q?F4pD2Ac6UXXIGDm0L+cBIahyOkJ3oZLs+gEMQJBxvif3tHF8ZJzIONmgCLDi?=
 =?us-ascii?Q?nNXY4WFaIjRWrK0jwM+ILUD01IXZWeOfAVw0eNoywhoV2t8OletuIB+cUtvh?=
 =?us-ascii?Q?Ge3nMonEkBMfGtpEztccvkYB+zKu1hAQeGOiwoiO/PhSdn8eJZNFFTt/1uQC?=
 =?us-ascii?Q?OgYw16vEFJ86f3OPPHXpQ0p2rLKuygJEoubzacDPAlEw3fQRHoyDLE3xMz1/?=
 =?us-ascii?Q?TnHcB7n7dKUfiVmyGqbBizoEinYMQtoeO/O8PAd1WhI0QW9YSRmYg9i8Exh8?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f65897-1344-4f6c-77b6-08dcf6f42221
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:18.6576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l86sdwmgj+H0/whBdqAXW+UENFbidxJX0qjYBXnPU/cgOi4knl0PYNzFpRP8QoHeAeDpd68LeoYgdIzRJclfvaSwcU8Lx+sPAAO0xUY9vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED().

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 38132ecccd..cf7f39d5c5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
 	}
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
 	/* boot using first FIT config */
-- 
2.43.2

