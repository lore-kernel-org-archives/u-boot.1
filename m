Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E419DC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A8C885C5;
	Thu,  4 Jul 2024 07:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD7E8887B; Thu,  4 Jul 2024 07:50:33 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314678881D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAOlgx6UKWi+clulzutkhz2I0sphdKnsEueFIhrw60TIiE82HdcFY4X+CEOnzqxqVo4ehcMvgKM+jQPAqt400pUv9+a6Js8j2AOXyGiSs+m5agS4jzHAoSrx4dLMgc3MknG1o8vZEVdgBmE/yOLZFOvrQcmSVlnnagDShyx1saqrjEcH7RZb0ZMOttwv9deiH0uQXq29jum8WxDmKKz690Gbk4ftSX0xmLM/Y/DOyv8hCauJhgaBDOEyyhHw8ASj0kbPuRS8CN2i2yIvPUqhzXe9OPFuzmrVtbYy5ttVFwqEudX9NEcHm0qiErrkC3wCY3UCn0lJSApM7CBUPA8qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oo+61BaCyqmH97E2tBm77hjMKbF17DmIIc3isXgO3s=;
 b=VT4R2iGB3LoAakC13zwE9tpDs+pl7I6P9strIKSozN14tp7/eJDrH6l6tVIr8po99GnDWVeZdw1vq6zjfur7bK/hekQaCN4SUkHB3NA0QEaGU9kVryOx4sSqtyEt6WCfj/d+N8Ip4hUhHtNT+gxjiRezb9oBGfN5EV43SfaH0MEjlIulRvetUoMekUdKiwI2TReNofYpakwG8kysXgbvZgSEmuhxgvqlmsw23rJJv5kaOswSaARwEshZ5tHyY7HKBE7H78kpwQd+kPk7LhDR/72TLnzI1IRO25lNfJL6mmbdifDp25oxhZW8+2OAI4phaZZ09WI+5jMmHQpcrTQQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:23 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:23 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 1/8] usb: cdns3: Set USB PHY mode in cdns3_core_init_role()
Date: Thu,  4 Jul 2024 13:50:07 +0800
Message-Id: <20240704055014.55117-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1fdb94-6156-4e69-a75a-08dc9bed326a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: W5PYlquz2nHt0fid4zrFaEpxQ0hauYqFFmb8GgV+ELsw88IMNBbHYNJN605nOIOWGKrIALY0cgzaAgKfuqlTBBXXMbxN/g5dNtIkYUxErwiRM2AszMGncE7hdB3k1PpsRpT8i1YsfTeJtJbXZNKfvm71AmxGau9/zqVaoG5BPh2+a1z0nq8mc0vJ6r1BBXsAMDi+/si+zAo9Kbi8cfn9RxLCXoAExjPAO8UR0gX3PMshRu4AQyM/DsN/TL3XAi8F/Hvn0bx3zVUwZHOvizWxsYl2GuT8s9ANhjKMydTR1f2b9YuYiF59+Eg8PlAqR1C/A5M3bY3sbaIktt/8vHQOoXC8VJM/dlx+HIahoYX6+tlXSX/hEwgLb5PGppqLbYx6c1I71PsuyrZvgEnsjB0cwwJFxsKM2GPjO7OLttVNbOX7AXkYyd7AXqpaZvPlsw0vadvE3rZAq6ExslaOeXQAN42LF7b8GomqdR+epzxTj5evr6x3rfv2tQduLIv5w5LPogFcqLH8MxtHOl6IClu9ZJfMqddF5jw+WMTn94N1rCujmNSF7GCABEMjPK8CKkQJ+vclwP7CX4B0XccaO03HipIHSzKE5F90TmGzqwwNN4nZyUEOToTAja9KGx55fgzjGSE7JIE0fMslytmxJxi9BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIA07PAVZjL8yqRI8m40Ryb0+ZMD9h2CLS+238Hc0ADEwRsltA99VcbjDnKu?=
 =?us-ascii?Q?ZFi3cSfXNHsZdDB/SbCLIomn4kxhtkZ1zwiMbe48O2MHcKWi699LGKBh2I31?=
 =?us-ascii?Q?8J1wqIw0ySC0aKC+QnCvblZroBksamjudH4akUP+cmSp8amExJOx/dVsCRtd?=
 =?us-ascii?Q?7HK2Dj1jVn61OaqcprSCDwLGl0fH7r3xc5e8zGfYs8QFR5K9ztA/F4ypRh0s?=
 =?us-ascii?Q?ECEGI8EqW6l+SxwSbx4/oSDGUn9t7nyPvJv7klXF15XYhLI+QKqrpmiVA2nk?=
 =?us-ascii?Q?ezwzjmcDIk0M912i08N6y/xHKGET/R0aZdpo2fVhBbspwXKdwMzFE+t/HaB/?=
 =?us-ascii?Q?2Eu7qqxbaZFiQWjaX5+N/wSsCYifpGnwmzM31aWk/JsvwKv3Xo51ZSBvn6SW?=
 =?us-ascii?Q?F+2GLmaB6F4RQN2ABWo+dWlR8wakF/95xvlfPG46l9fHM4dzk26ma5DxjAdb?=
 =?us-ascii?Q?MXF8rjAsUNNhtG5er7JyQK5JyroXPg6+7s9abD1ut8N73/G/RZmaSBx9ZLLY?=
 =?us-ascii?Q?oFG8QhT7nVE0W0ScBD6PJn0/iiSjBRLrSsChv9fnnEJHwDxBoywNXwKil0aW?=
 =?us-ascii?Q?SJOjlue0dKbOzltPLuy3Pz52iY/bUIxiuQih7mgz+hmoAk+qmCWmGyBlbf82?=
 =?us-ascii?Q?nq3HgagB71EpRpeqfQsvw4RJccULnvtYM+uBqPwpkMhpTzDufjzy4NwWLu4F?=
 =?us-ascii?Q?Dhk0WxlX0NYYtq9PZtTztHqdPsONlS1764NNnFKy/Q0qbpG9kHnHJLoYBX/c?=
 =?us-ascii?Q?/1CRn7NZ0CHmjOOBVdAxFc5DsrDH5SvLTw+Xi8AKoSSI/PviOesrwNKH6Sy+?=
 =?us-ascii?Q?uqamQhRjf3RFnB+OUIG6Z+hLD8NqFlx26NgrmRITStPbdYwsb1JYZ0jfPqU5?=
 =?us-ascii?Q?Ay7WexGZIeap6VU+5Rsp4efysT5aPECMEaDe7s+ARpJYV7yCH9fRqZAeERax?=
 =?us-ascii?Q?ECoyEGFAz2VmIOL9bqnwcQnP1d+5DKwczwB/poKnFytVYEpmTqqZrsnCVTwl?=
 =?us-ascii?Q?bPI7P7rMpiM8OONtxou7vzMF/AIBgT4X/fSsttxMCdqOOJFEMhdWegLp5xIg?=
 =?us-ascii?Q?wE35TCyw6Nj1nGgtQq+Toh19wEXzb3ZRgKj+rzeEEvrRHL6T9RHXThQlFmkV?=
 =?us-ascii?Q?+4GvVn6YriTjdIAdvRWL1OQUIgMke9t3ykT43kKGsZDSWz/ZkpbD1l51azhH?=
 =?us-ascii?Q?5kcL2MJJNXTjTPNWtgQouUmYPe4KvTClLwxJFAaQ8/V5VbGjMuckrNxMcG3K?=
 =?us-ascii?Q?NC0e/KbNtbEBqBIEDsEgDvDxvSoExMB9tyr6AznAVzQb1z+uEzt8WtbnT/2s?=
 =?us-ascii?Q?mYlX9qJEvYea+VZfq0D/XgjmpgN2NUzEfJCtK66NosmC9HcZyJ41nVcMq+QQ?=
 =?us-ascii?Q?bvXZbT79QZ6LEHb/7u3SAuYMgZlmDZQt+xH2vjr3dJOwl8gRaGFzBm5lM1YE?=
 =?us-ascii?Q?O9vs2ButyPZERiG1NfDrtXHF9M+NJPmpph8pxytN/L3CIbMgh+zVboAGr9eX?=
 =?us-ascii?Q?PnYnIUBSY356VZYNiExnjkGuDTA/vkLpYONNKOkTAo6L3Hoj/x1wNxuJQn7u?=
 =?us-ascii?Q?yricQDb1VH/kUNtKrgFq4RjItVnorhb7DwgQneGEY/fPiv6CM0qC4K9EoYcM?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1fdb94-6156-4e69-a75a-08dc9bed326a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:23.6250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTHYaB9tgNOuP3yL0e24PfI6Md9hG5dFhBxQ2Yn2dDgUi7qjPO5gztdPj9asqbffeM7d979Ij1pA6Jfmvog11vDadF4bY5inXnEYDi/IqrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

USB PHY maybe need to set PHY mode in different USB
dr mode. So translate to generic PHY mode and call
generic_phy_set_mode().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 12a741c6ea..1e863bed89 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -107,6 +107,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 {
 	struct udevice *dev = cdns->dev;
 	enum usb_dr_mode best_dr_mode;
+	int mode = PHY_MODE_INVALID;
 	enum usb_dr_mode dr_mode;
 	int ret = 0;
 
@@ -173,6 +174,30 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	cdns->dr_mode = dr_mode;
 
+	if (cdns->dr_mode == USB_DR_MODE_HOST) {
+		mode = PHY_MODE_USB_HOST;
+	} else if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL) {
+		mode = PHY_MODE_USB_DEVICE;
+	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
+		mode = PHY_MODE_USB_OTG;
+	} else {
+		dev_err(dev, "Unknown dr mode %d\n", cdns->dr_mode);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
+	if (ret) {
+		dev_err(dev, "Set usb 2.0 PHY mode failed %d\n", ret);
+		goto err;
+	}
+
+	ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
+	if (ret) {
+		dev_err(dev, "Set usb 3.0 PHY mode failed %d\n", ret);
+		goto err;
+	}
+
 	ret = cdns3_drd_update_mode(cdns);
 	if (ret)
 		goto err;
-- 
2.17.1

