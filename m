Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAF8CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9ABE847C8;
	Thu, 25 Jun 2026 10:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GoSBXD/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFB8848F0; Thu, 25 Jun 2026 10:38:22 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A7A8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1wgLEoyZQUbhowtjO63WUiYxfDE+E8ij8bTY9zLX1LZwtVk4U2umWgXR+kSE526OfV8+XbAgnAYMKYxNtz+AIGyQbS+8xIOwcBv6kjrP0N7q8WqsCL3jVTqTI0xmgp+T9LYk3wdYpCrodU5nB1yUOrn5vIRsXEc0L9AWhyJQ41eIjkglH03VB+ARHABF53HFjI5FHN/L/sHU/TQYF/51A1K0TkdAtGqgWgkHDVnoZzxWans/OJ0voE8C8vjNaS4Yr9CwCOB1OiEV6uGHD+DiAwJhDZEyJ6wMkHu321ghRMHrfCbl4wfTmWxmtU4L6nMHVumCYNHjieM60EiCQuFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP31b9DVf/I9gBLP+FDcB8zQHUMIC4bdF3hpWBNS8ek=;
 b=J047t3biGQ1crIX7P9dJ407hTer/JYusIcCAgfIzL4fNe1/4jS9cRzCIUrJDs3ON3XxZiwUm2igOlvfcHYyh4JS7WzIZblNad2UgUQJZLBZrVMVzzNLrfuVlz0LpYkxsp+rRiKrGDdC8Zcwg816aY5cYPZn95AJRy7WRgJaE7VWin20kxD1KVnRl97rzTEh08KXbzh3kvmLgLLy8G/9oABikM4ifsQyjeSNURU2bllplXQjx5uNp+IVfXAWEBoxvb15nSh9NCp7r+PSL6viFGJDEb0H48V9gASq4et9ufC6V0H1UgcbhdurmKJR7i5VoRspqfSA+LeDOWBaV3kLAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP31b9DVf/I9gBLP+FDcB8zQHUMIC4bdF3hpWBNS8ek=;
 b=GoSBXD/lUOhOecOR6PhiBSWkkox46Llcaxk44T2oH+1HF3zZ4afcPVRyQpTisHP8egbjxVYs9Yh/HDa0/gUF2k76OQU9rWwC4kzPB4F0q3mE2a/QRZO3Vp3ePEuv3/mKBOiVmC/rvHOyv5VaacQdfgJhxiwlTnpii87w8pBipfJWC0Sv0L7octsAtxz68np9FTsFefAS4UPmfy/2HO+kJJn13Lkx/QDbQ2LofhEkfQHHMTR6u0kdYAGIHhbWAkN50lAv8J6QLfInrHiio5KMHzvQKe/S94EAzgnp9E1RWDnr+pMbcAYyXegnVvNhj8bnXeHzWMIlpcNx+YT4n9HXSA==
Received: from DU2PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:10:234::11)
 by DU0PR10MB5430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:38:14 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::8) by DU2PR04CA0036.outlook.office365.com
 (2603:10a6:10:234::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 08:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:38:14 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 25 Jun
 2026 10:42:54 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 25 Jun
 2026 10:38:13 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 25 Jun 2026 10:38:13 +0200
Subject: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAPToPGoC/3WNQQ6CMBBFr0JmbUk7AgZX3sMQA9NBaoSaDjQaw
 t0FXLt8yfvvzyAcHAuckxkCRyfODyvgIQHq6uHOytmVATUWukBUvY98E+rYTk9Wpi0zKo9sNFl
 YN6/ArXvvvWv1Y5maB9O4RTajczL68NkPo9m8f+1olFFZk9uaMMfmpC+tF0llTMn3UC3L8gX8K
 ZoCvgAAAA==
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|DU0PR10MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e92361-5cc3-4184-d67f-08ded29518ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|13003099007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: knzksAR8KdbOt/rHQIAid+oFh0lQeYbaItiW3cTxGwhRbHZd9E/RnWoIo9wyEFSEMqTDMCU+z/tpwnuMq6smsaNcGYRMwsh+FqEb3AAbYgDvLA9Zm+F7Ec+NL14KaGgBuEVA2VHrsL6bTij0KjBUBXh+LJq8eyg3yQAT5QF/OOM7gkszgBGOV3Bqsga4Sk4xMyG9i+D5udhNTORwMDOdVoZAQrUEfpr06/9gX/T9QVvAk3O6jhrr4awEOzfeOR5Xu0hsOqTT7zhTSS4Zg3WlFZerccKfvWc6SmMy4G/zSdeeTYa6yBl60EKbXfu0K0Q34eQioxxx0obJjdCIptg1EdsDCJAoCzyTZ4hanJ9Aj49biHYxYva064LsGUYlm+RfdCX8ZV6Q9ISwgg+wxkhcVshI2+QHpokNr0vgWLsvewVE6DtYrqYOFHyUstVDrG/uW6Lvr/svgS1oJ8rl9tVRNwZf8MT2oDmesISx7Y0db3zI4KuVkiC8D43D1StPEbwYGr7cCc0Rq8QxgqaFJ6dYqZq2HmL2+rTsdO8FKjO1/FX1QbRjeqrpUGqlxI2+6Fx95nFEJkIzDH5dZa1eRorcXxbMh07ETJNSx/jSWDbplHslefJR0K5ZcKoRGJwynYfPqj4B1Ms7Ck2MCfYh5aafDw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q3pHlfEKdO/8pVJSn8teEPICc/co7wiYABBtAjh7WlmyAjVpJdd20szCTXSUClag2Y/xCHh0Hi88ufbeex8zSSiWS54IPUiYWp4PQSatUhUPGV0YXYJGcnsUdjSbsXwubqSOCUGv5yN7vNovmW72qXto/U6sVvaqxjH6aAc1GnSaHv/GBY83wywhjNpXc/sAJAima1T+JriaVkA3m8Xf+1uUsn8S7Fg9uprQQ2jSnAuD0buEGPgiNVo9wO+cP/H/KTYJbHLTRp8AxdDS+fSuvtHbkO5n4dF+fcGj+ocEUewPmKIG9YuRVEPeWeYS6Ub94+9r9Uir/DD4zURpdgSmcYW//Oz8EJHj1A2y3JmgtvfuaBHa64HpivKkiE2glcqdDu38VY65n+lI5OkrKNOF5Bk7ezfi/YU61/1r3jdM9uBhmwz8Ae/yBiqaDHzGGlBs
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:38:14.2003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e92361-5cc3-4184-d67f-08ded29518ea
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5430
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

On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
it may take a while to get the control back on the console,
sometimes around 1 second.

By moving schedule() in order to call it only every 10 loop iteration
it increases the CTRL+C reactivity.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Update commit message with more details.
- Link to v1: https://patch.msgid.link/20260622-move_schedule-v1-1-4b5dac252b70@foss.st.com

To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
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

