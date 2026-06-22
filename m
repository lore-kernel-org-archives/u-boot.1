Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0237CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 17:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB03784931;
	Mon, 22 Jun 2026 19:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="d+R/U2e0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C30849BA; Mon, 22 Jun 2026 19:18:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493CF848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 19:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqmdlVza9KB4kWtesSn0ULRCRNUW2JwmoW0mRRwEihqQbGMTdD/W9YyczQTe2zFYnNQwr4isNxsr3CzwN59c1Eodq2qXHMBt9j/suH4oieEuP1RUR1rLFY655L1MfiJ6IntYNIRFIoBx/mcHxeLk53SsOKdcV4IXlOXs4Wm4BTAHK/G2OmVXpgw+MapXtUkHNjuDViYbEb73hTzD3H8Ih4P6oEJafcTIEbuRH5VkI55I8ClMAG9osh/2x4fS640hpWwRGecct0H26+LXX7JIANUXQ8+QlHOVXgPXYE0Rr6kfz9YKmUuFB73VysPVumzyvj/xrmxMEc9obIqw44+5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWfKuhCbTL+Q2fGMEiktLP6W4RAzrooqBXWnmYpDvOs=;
 b=dIoLL3pU3kEFRexaC0k8+p/kVFjGMXE3KO1iYeuWX2RF1ZkVKpOKndscBGNVbeP94j68Eg4ijbVyIyY/bLYqzmb9uakdEEa0UnnoocF2i5Qgp9V2tw4tnD9usuLQ1buQ+Qx9LtXT940fD+2im9P9pgxbhSt0/rHY2NkuYyGwg+BWyBuwxOjBG/IWmUbK2EDk68AvTlQ9NWN/YjzetUwmjnTH3DA292mCJniDDtQGLikWzT2IEUSUVhp3haH+lW9ubH0CPni5jnrQYvXeYhX+jkKmXGO3uQAUIs3XPq9nu3fpqy55ri29MOhe282C8KnYupeh7g7bZvW4FZLxPGvNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWfKuhCbTL+Q2fGMEiktLP6W4RAzrooqBXWnmYpDvOs=;
 b=d+R/U2e0F3od2OOt0H9y6uuTeWC/OSvwfaNtg5LnkPd5JJAxAYARj67hD4CHgoJYgpCvz3ok7/sUNYZr4jKYY9IObuvH3oa4/XJViaovu/V2zlrYjqHV9q+f/GUGGXu6FXOF1B7vhg6Qs4IGoc2piyvTNdHY/0ajRgjx2vM18zrcmjq7URRNyXv558eVAxDvDe2wFKEEHE5hRrRjm1pDxIyYpG38HestLMOEAbcV7LTuYEIWm8qXvy6x+ywLkNY62ayifOtX/4Cad+hbC3umuT6RZ3OqUdVRRrHX+RL8wULloKINhbVItlG1DyBld70t5/EhZGPU1X8S7j8HUiKhwA==
Received: from CWLP123CA0247.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::9)
 by PAWPR10MB7152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 17:18:30 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::87) by CWLP123CA0247.outlook.office365.com
 (2603:10a6:400:19e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 17:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 17:18:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 22 Jun
 2026 19:22:41 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 22 Jun
 2026 19:18:29 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 22 Jun 2026 19:18:28 +0200
Subject: [PATCH] usb: gadget: f_mass_storage: Move schedule() in sleep_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260622-move_schedule-v1-1-4b5dac252b70@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAGNuOWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMj3dz8stT44uSM1JTSnFRdwzRLk2RL41RDg+QUJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAIdCTTVxAAAA
X-Change-ID: 20260622-move_schedule-1f94c93e10cd
To: <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PAWPR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ec55bf-b7ce-42fa-179e-08ded0824811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jTgXaZJuC3SEJU5NwH6P7JInA2oXbB5w/7LMqojRjSyd0U/dm9k4VeRK1CSYH6jDfTqShJuy/PqkdSJKVhd04/Ro2Wz+qxUXiGpgwfsA5/9dAOzbQ/a3bLvbvg9SMbjMQrNM1FyKLFsA6nSUwKv1DoI7Z9uHSiSBbxyVcHjGIIG3OOAMNCZa90fokw4wHy5eO1fvo/HeMUKqDEG0FT2Is2QKmxn5GFzgZ2UdNhPfDpU/tIk+ZZPHx+en2V0JjK1AKzOdhg4tLqkyZ3EGoWVqSwCVHrYtwK6f6jDgzZ4rg2qIHEXTdAfmy/QmCTUD4K8Nnn3lG262JdFudIZVbEsPV2Yw5FfIMH6CDplnLRbsRvTzSl8jK+r4jhKMqpEmE2+utzi5mcs+W3jVpSKmT4HmdJITD0Qr+l8TYdoz/HQlYR47Zc+Ci5TXhlCaRg5WOfvc32Bcwx31QNNOrq9WGthNU9ty/yh7OHbRkPoE1NklgMN8VWsWryO5Zdae1gkOoCwIfEme2t0vVR+UFxFrUxH9E2xh3uO9PkJWpS/jMyLY7JX21vgLMEZekA1Tc1TzLONUQWWuKODUcWVdhaGuEVXGaqwRyhdD2gZQMLwHlcKsygubvWwdPu54kzmx+wkVjKKntJXvIYH1LpFbu4qPb6sVFvHbXcW0pkEwbEqUj458Z9Rycb+s1Xt9uwlJae/xglqQ
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WwF1g+To7c5HB8zaFyR//KnROtXQL3gpp2Lcg+Y+eTm99XozvJ82boYhgGkl+Ur87Rb5AEOeIpW99M8yt6BTvwPyfRB8Nsh5PUBfIDogFPfBkTLcZF763iFBZvMeW/pVa3Ae7MBixfksYL+sLfeH4bO3KHuqWWcatdsuAYHpz3rp8lBynvDJ+4PUPxNFiH/Pmc9CCtCJHJVprclvwuqAh+/jt8fFWBJTjgI5gK20gXs2I5zh/kwE7liz5woJ3D1VBc22cI4dPFTfHtmB/GuU3WTllBPRWcikBxWWBg9PrOt72/oBZV+YRNdSqezAekWvt3tX0WNiv1aHnj+PPevXzn0rFh3KXjPIcWs30setd2T1y5ioz9NrZy8WlFRfXSH1nDo6b3v95ahqOBGrWOE4rbblDwpkKgtjZJXF3q+areoFjRDtzvgnKX4aCpXRO9zL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:18:30.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ec55bf-b7ce-42fa-179e-08ded0824811
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7152
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

Move schedule() in order to call it only every 10 loop iteration
to avoid useless overhead.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/f_mass_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 71dc58da3f0..fb0803e856f 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -676,10 +676,10 @@ static int sleep_thread(struct fsg_common *common)
 			if (!g_dnl_board_usb_cable_connected())
 				return -EIO;
 
+			schedule();
 			k = 0;
 		}
 
-		schedule();
 		dm_usb_gadget_handle_interrupts(udcdev);
 	}
 	common->thread_wakeup_needed = 0;

---
base-commit: 1296a428c67cf103eca482d4a63349661c1b799f
change-id: 20260622-move_schedule-1f94c93e10cd

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

