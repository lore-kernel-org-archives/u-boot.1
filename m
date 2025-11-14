Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DECE8D68
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265CA842E1;
	Fri, 14 Nov 2025 18:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fg289sKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC780840B0; Fri, 14 Nov 2025 14:35:12 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D11483956
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 14:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=t-pratham@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJfc3jI5YCxN8DT+JRPdDWAiLeJxmHgVhDGLpOs1w0G448eG8W+OWAItYLWBBQiqvfElQ0iI18FddWDM/Ho8Vnqiw9kn+iPTSWonG2kilPHn2eVkoooRSR2SMtKqNA/UjJEfHduoMj+TFUuhEZNwD1E29oCYWafzz7/h3dawMdLzH7BJISiTTeg25ZOnqwreBAhauEYXQHgXpJxPGfN9M2FOkN5nlezqlPyXpLDV+1qqEA/ZrrNZMAn7Tsa0YbGxzKs6fvLoJAbBDweesaCT9W3K7YyzupaW+6YLbnNAzEURouaSpvFrexxw7lWcnMor8yhqo5zJNm7r5w7tg0qi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSz10u0Ox2IWPDF42gKDwF3Hg1bD/P/6I6DC9UZFTcU=;
 b=SROSCkMhwDbmOMEH7aRv63MQpPxurNiABcn/fLY2DV+fukvWeAdGC1RkLhIqo48qvXX13r2PMFlwHF5Awi/AGIBDTu1WWKRM4oG3eHr+uiHf038aGREkgkIt0IHnD+qzTb+1C3qzs80Vo/H5/S68odwp2ChQWk6K9TFzW8zdm5iUFoZDS4uve0xiCBSt6jE9qtsJ/D5YgEECTG2jtGomqrJKkqksYsmIwacUVetx9ufDbhpG+TV/3eCtISW5sdSQ9SDeIJRNCxjn9P88PHRlzsBEug2h91uAY6rDOAGwe8CBcXZzrh0cmuhV4z3gqC4enK9gl2J+aT4k/PjL/V1g6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSz10u0Ox2IWPDF42gKDwF3Hg1bD/P/6I6DC9UZFTcU=;
 b=fg289sKeMIo5G9KjVhW/1h4C0j3qOBhfN8ddmqDs0Dq1Ly90QX3MJLbv6p8yejWUs0s7DrEDe/E4oMRHYQWlVxjSOVnsE3Urgka+d+kwoJgUW13RdjNIanSfz7cSZIP7Eo6A+9kWyCCqJ2RBzGbwMQSR8yKOc3yoAg52YxFEXbI=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by PH7PR10MB6274.namprd10.prod.outlook.com (2603:10b6:510:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:35:04 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::86) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 13:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 13:35:01 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 07:34:57 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 07:34:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 07:34:54 -0600
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com
 [10.24.69.191])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AEDYrag2094575;
 Fri, 14 Nov 2025 07:34:53 -0600
From: T Pratham <t-pratham@ti.com>
To: <glaroque@baylibre.com>
CC: <a-shenai@ti.com>, <afd@ti.com>, <anshuld@ti.com>, <bb@ti.com>,
 <d-gole@ti.com>, <devarsht@ti.com>, <ggiordano@phytec.com>,
 <ilias.apalodimas@linaro.org>, <j-humphreys@ti.com>, <jm@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <neil.armstrong@linaro.org>, <p-mantena@ti.com>,
 <peng.fan@nxp.com>, <s-k6@ti.com>, <semen.protsenko@linaro.org>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <w.egorov@phytec.de>, T Pratham <t-pratham@ti.com>
Subject: [REGRESSION]: Re: [PATCH v3 3/4] board: am64x: Use generic AM6x board
 detection functions
Date: Fri, 14 Nov 2025 18:18:50 +0530
Message-ID: <20251114133303.1955041-1-t-pratham@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103-am62xeeprom-v3-3-e390779c0fc5@baylibre.com>
References: <20251103-am62xeeprom-v3-3-e390779c0fc5@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH7PR10MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 682bf980-a401-4630-ba9a-08de23829cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fY4CeJgwc0enYpVuzi3FyJKAXUCU7f+vgGsxt4H6Tvr7M+JD1tMahSww8l27?=
 =?us-ascii?Q?u/YdKU66UrJvq8OdGF3UL7TCbgB3/knuEaJa6MpzULm4tfd2FL8IXTaZe2Rw?=
 =?us-ascii?Q?AciesbxbzFcSX6c0P21SIZ625z/1hiLf67qpoGjZKmjo/Pek5at32nhbAOx0?=
 =?us-ascii?Q?bBUol13y7MNSAzu5WHAXQZdscyjl0qYj89pElg3/Vv4DGqiDwSQGrKJipGfZ?=
 =?us-ascii?Q?LTVGb0Rw1F7tt3nssM35veTHeWQ6DJP9znH7N8ri31GxTPub60P7z2mZaxi/?=
 =?us-ascii?Q?UKiGOeJApU5O5PHOxGLMguS7lnM0Fma7E9phDQ8EXOA5fhJzsdJML3sXbK1g?=
 =?us-ascii?Q?2nvkf9kkHwOrl8w04rhPRoRFBmnfgHEbKQjch5HOr4VX/PTcHw2c+uBx61JW?=
 =?us-ascii?Q?4dxVQhuy8hT6YKl2u/ru692SMiu2vVGdwnKalciThSmF9erAxedXO7cyz9Fy?=
 =?us-ascii?Q?pQZJGQyu77ZVXJgu+X/gS7lSuzIA6FG5uKx69+y2XDtuPtwZt6GhNFuL6386?=
 =?us-ascii?Q?WfygLp2y1ztHy1J02FJjw7kppPgroMTTX9R4h4zr3Atnw7/j6b2IPZDV4Up7?=
 =?us-ascii?Q?agiz4GXD0vSA/GEea8Sg9FDiE4fUUS8DYU7x/5DCiPvRb7th2+L/eJcRuqeg?=
 =?us-ascii?Q?iqzEBdj9XUcf9v1IVnM/Kr7eXMMx6I7ulL+4+Ye3kEmOyTCFp4NzfXcK1txG?=
 =?us-ascii?Q?N7wCprjOwqafRBXPrWMN5Mi4UZL8en8kn8avJ20kemvsSUxdTEwV8C2+Ck9m?=
 =?us-ascii?Q?Qy1zO+uY4kuAMkC2p/DkW7VeknvJSEpDZXDWSJC88k8a54DVhrS17b7le17E?=
 =?us-ascii?Q?3ngoy5Q7wfjHnk/ucHtUvGuy/B3O5rLOsZP1eDZlW2pbiOhN9ApRJARImiYi?=
 =?us-ascii?Q?CWNs5UXug/WUVEbTjCXz4fq6VH1ZYDhyJcIChYX0rnB8iF/8aECRgzHqduak?=
 =?us-ascii?Q?pV8HfwWgirIxSSUOqOlF+8GNtKFj5sQ53Lmm9jpoyReM0LTYLsGRZO4whgY6?=
 =?us-ascii?Q?OWNCXAB8tXAPbXqJ1z/IIN4Yoob52lAv4GISiGu9M82DYvPySwBJDsyHBJ8M?=
 =?us-ascii?Q?Tn0QBNX7OAm8zgRMqT3gIyyQpKsGcR/Iju8HSeRxfsI2DwMA4tIft/ypjZ8U?=
 =?us-ascii?Q?/iW3utvN8a/Q61QIsPcpnss53fVbFIKrovOt9ni1pK1OxRt6JQkEtlJ9nVZN?=
 =?us-ascii?Q?ZcunUiBc+oJIZ8dg+6qSbjSq3mZ1h8GXHeTzT53h0WbM3Ig2lcg++o8fv4js?=
 =?us-ascii?Q?rmAh+9U0PKlAhKPlMi9eFXCVwhVZLB+wXooZNypFMNXFzXkd2iD8IRDV/llM?=
 =?us-ascii?Q?zNAGRerR0zNTQPC3g9/FuTitniV6+yVHR7yLaK8rLSZJxYo3w2mfJYqWb2WG?=
 =?us-ascii?Q?29Pjvj8si9dzpnIeqz+lbSfORDvhLyWPRQbcVDCc9S8XBuLeEPEPJC5+yAp1?=
 =?us-ascii?Q?xsiDffwQh99YaBJ7Vg9QykhkMqDveuI9akrshwcODZx9d2wAMfC7EagOd579?=
 =?us-ascii?Q?RPPXARp2n+fqozAPDxFt2SZXyfnxjMNLyAvQNeaT0UTLfNKadr9bfbkcTTr8?=
 =?us-ascii?Q?xTlhVMACxaSpuJGCYpA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:35:01.3668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682bf980-a401-4630-ba9a-08de23829cab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274
X-Mailman-Approved-At: Fri, 14 Nov 2025 18:51:51 +0100
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

Hi,

In our daily build and boot test of u-boot master, am64x board is failing to
boot. The boot stops at SPL stage.

With git bisect, I have narrowed it down to this commit. By reverting this
commit, I'm able to boot the board. Looks like some issue with the configs when
using the common board detection functions. Bisect log:

ce56e553c31377b9cda7c53e2161c8e02071fc4e is the first bad commit
commit ce56e553c31377b9cda7c53e2161c8e02071fc4e
Author: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
Date:   Mon Nov 3 19:40:04 2025 +0100

    board: am64x: Use generic AM6x board detection functions

Regards
T Pratham <t-pratham@ti.com>
