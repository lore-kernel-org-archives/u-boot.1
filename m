Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF2C27C50
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831F18851C;
	Tue,  4 Jun 2024 16:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="hGIKfidn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E6D88519; Tue,  4 Jun 2024 16:27:56 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1F3884DD
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m70C2XoYnfAhQLVENdTa8JsgyfQUNRA4p+DVnglxcIjZiKL67/7eOFC4i/oqYdbvpShnocLgH8RfjO9FP6ab8SNjlyTU6tkJaQ5GCduSl1zDrXHxtpsHtqk5cANpGv1Yboh0yFJcAxnNc9CRWs6mlpejjhSXnL1+JAs/FqwjODYRb7iwTYVbV0KAYZY6fkibJpTcEqsPfxwltinN3Z4cfbKRYOjUwPyTTh4SHcmC4/NaCUCszvF88Tc5g7lyZUH6vcF+PZNc7zYYFUF+k/TCoAGjk+ItFW9NOqnjOx/PKcsZoRJd/dRgEkHEnQNa7tD0p9xHz7UEvy4mz1SnUPL9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZokbyFVwCsj8GRqr/bIqo1OClUc/t+/0dX1w0ReARs=;
 b=U9FJ6LXY2aDtsj5oxOC5Brr8iXzJgw4rIKDu5CCaO0MaUd8G2MeR82J2II5JK2EWsRf45Qmb4GdaLjW3tnT37uE6jO4IxWQ2D3pLLcy+wCOWXk4lclRkfkbL/vh9teHWo1I3Oa/9lq7f6PECP6bhxLCNQy7zIwvoHZta++W8NdsXZcEFAD1Mr9bs9Olyv88+6sfYqkfzrnmwTpAKu6LDRxOLN0qS0OIFZe5K8f4NIddGoXfc5xYCzrvU4y0MMSmcmo/MyPCsNUzSy6G3g1XuSn1DGxDVi3Y1WXf6b8r6YzrHp97bMWT8ftCeQYO75E44daYAxreioj+VXEP0X7cwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZokbyFVwCsj8GRqr/bIqo1OClUc/t+/0dX1w0ReARs=;
 b=hGIKfidnlHpe1laGXhilT+6oFQkrxFnh3MoOLsVoK7hHFz4J0QJ8f3bRVBIaaBrhSmz3n0f7DvEe9wImX54pvH1kdcTDxDK12O/otKhotJcaHf4vSw2sRPYAv3B0d3aackFPxg2kkTfkTuugxGLg909uKPY+0Y7va+HIeRX7b14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:51 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:51 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/7] soc: xilinx: versal-net: Use zynqmp_pm_get_chipid() to
 get chip revision
Date: Tue,  4 Jun 2024 16:27:38 +0200
Message-Id: <20240604142741.425307-5-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 285a75be-2ae7-4aad-2b63-08dc84a28404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dz16HgHnQdAOqtAthR34b1tSEtAS8LAfeRuoUrkNA2/pwWxCAgMULSD+Hmv7?=
 =?us-ascii?Q?MVK2FL1lM9pb2p1fjRB/bKhEOri6Jdg4VTcgwy8C3i5kCQGI59cnhSlWiwxC?=
 =?us-ascii?Q?QknomfoBWeeL3Ys1CjnBgUmo3PyE3+JDE4bfuUyTI9qr4ha11i2rjdjxVws5?=
 =?us-ascii?Q?Khr/cQZY938tYtjQe9hTXu7k1rRXYbw3r3RRR+X2m6TXGWw6/39eniMq1zpR?=
 =?us-ascii?Q?PSYF7vdJ/0Rr11ejOqHQVCvxhY4e9NDqN1CU5WrNnDun1/2oYnzTbOZGUNsG?=
 =?us-ascii?Q?XO4+S4Rvd2YvAUbxOS8VueOmdjP/6qBjvS16bgKZMSQvI7JBS9jUs6otRP0M?=
 =?us-ascii?Q?xJ7b6ZX+vK+poHbpI5DdbwKNHXNLghusKv9NIAbpCa6cDLzdL1D25FwLBTEc?=
 =?us-ascii?Q?dfd1F08Dur9D6R/Q9vPxOrX3JWuMGJfOYFprGVikauWeNVsTRlZCC1ZSRbn8?=
 =?us-ascii?Q?0JYpC6TdbTXSj0Bgwr6PCa/szjnnIxeTgwTfuW+1269RD12IgNMw5xo2l/m7?=
 =?us-ascii?Q?hRH7Fsl9PxEK+cv5porRw8uNkrTwkx11yXurxl/8hK0U84TuhKGTLRs0//NQ?=
 =?us-ascii?Q?ZRsM846X/RqFKJ0jQQ+XfBYk5XlksgngLZhpcKqvFYx+PZr3YZun8zz0J60h?=
 =?us-ascii?Q?IF+T41FCVMZqMHhptAu/OWr9zY0baprK/2qMerfsOSp5DLl1ydWfYS13pvLQ?=
 =?us-ascii?Q?3Fn6MFxiu6JKsdww0iw0sPtwXs+ywvfbwnjsvSq2LYBc9xmmB1VsESttUcaO?=
 =?us-ascii?Q?cqYbKHQD+Q8ZTPeDFxeB+q1Z6UH0LyHrca+nlyKPn70W/sktQy3z59EBqmDu?=
 =?us-ascii?Q?SCEbGas6vW8MZcZwBqsTVZnqwttG/GbHyzISo/nuIF4tUrxDOvZepIPOBr8T?=
 =?us-ascii?Q?ngkxvLDswf3QBWdunTyl3x7YaMrJ5Id24B6UEb1/yXW9j8HiWzCdjsYoqA0m?=
 =?us-ascii?Q?TN3v2/9i1oNsR2/Gl7ofascKc2bs56cIzdg3hQyUBOEV6VsHkdRcDnV+AN4U?=
 =?us-ascii?Q?eygJYa1+lKiV4tekOA1200RUWDevcFSXFxdcrHoWESja43/kbgQJKh+n8IlI?=
 =?us-ascii?Q?JwwDkOMDpCJz487Eyb6adopdcIMVDLOwLVYtPvbVRT8OB0gU3pXvCngnFv3s?=
 =?us-ascii?Q?YJJujBCPdmXQa5CitEPTtLTw6wfYtS6NLJcY0Ggj2PGUDqoEKyLHxXuHZpxQ?=
 =?us-ascii?Q?deiTuL0IYPvHSb1+eb0BER0H9ZdmZ3PgZpbZzJQK8PIr2RhACko9Xs+5NsUQ?=
 =?us-ascii?Q?t/58A5EnnKs/4pH2euX4SR4oH2fuD0tyb6Fdshc+MTi+bofUCXfieksOpWDM?=
 =?us-ascii?Q?ZTpEy2wHUq2Gb+eqV2MdyWSN4EPYUN4jrqYBJE2+M4lfKSDIZ437KwRV6Rzx?=
 =?us-ascii?Q?6LF/IBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8HAvJvp/NW2McVyY70JwEl/N+m8cF+rTe69yOZEhM1SlWHUb9cluLkxBUfm?=
 =?us-ascii?Q?B21it/3wqhx37agw+4hwriZz2HF1oYCVcooR3U3ps639Y7zJ9AE7vNudD3QC?=
 =?us-ascii?Q?VzXVnnPOqGi2ND7aTA6NGMk1iwszj6QTNQc1HoGpVsY313cb+olfNiyQdgIu?=
 =?us-ascii?Q?ds7vGW/ze+RV45Gvz372hRju6Ig43K54DpCFpLfgVAumGQ4++ngY1NIF8K35?=
 =?us-ascii?Q?SZ2FpHa6zryhZUSmQOxLYo9Df9GsQwUxyFZQNsg/OfbhYdZ9fesRcMiwaGkk?=
 =?us-ascii?Q?Unp0VyKAl6LXC5F1v7MKWelHasJli2pWYKbWekhWC5Rq9aVHwAYddF0mOCAC?=
 =?us-ascii?Q?V6epbum4v1eiaUmYGPJmdTje2Z54eEw0S8gddXX1Cej3mW74vQTsDaqnUxDj?=
 =?us-ascii?Q?wmkbDJj0HbdMLOQfOFgrzM8gR8i9k3J/Oqxp8tLmKIAEU/T0OxYYjjxSI4nt?=
 =?us-ascii?Q?e9g91Pqn86odehAcD0Nm/wzzRupg51y5AFf1SkzwrqejWhDQh1X9PcL74lFJ?=
 =?us-ascii?Q?moRjxfSwJUpE26zf4T5neyWy+/K5bRjaUjk9iDfFZ7G7Z0LKkAYMF+SO7hRl?=
 =?us-ascii?Q?Zr8wsFJLcA2ChkhvBEWY+oDzp457tEL1tR+Pb+1UAmYV5r8StbjG+nNFzVOl?=
 =?us-ascii?Q?RCkwZerak92h+6IXmjNSWm0Y9gB6fXTj+HZGq8P1Mo7U6RS+qYuMhy/d81f4?=
 =?us-ascii?Q?IO+8l3RJ/f11DPYoHkgIKbStZL3ykcNtPNVlOEIi9hBZcsqdW/b+SGtZ7872?=
 =?us-ascii?Q?tzDw5PTe00BRA7Ydmn0yhUqalfa8HoceV+Je3SlDWzqxlRtIttmyjW1YMjdv?=
 =?us-ascii?Q?CbkWo2i5C+VaqzAjfTtBXRVuED+jRNOCFHRUNLp7JLp8aNxhUyJyQ3tg3XuJ?=
 =?us-ascii?Q?YJzIEVEWzoCcWne+QKy/DuT3Bo/SrjM1IVSIdz6rwJJ7fdYsXfkLe2ZsuMVf?=
 =?us-ascii?Q?t04ZohPjMJXR91t2MS1EpnHgnUXnpKaG/35H21QceYnTnFEeyMToPFRuesJ+?=
 =?us-ascii?Q?Gg6sXXLM7or4i6Hwtqxrz28P5X7X3tfaEyWLkA545ZCBBDs5tVWgv714dYRr?=
 =?us-ascii?Q?7S8pJkrVLhhCZSF2uVli69GBOkn7/Zth4mS+oi213QKGqK01vT2kSqICNhS+?=
 =?us-ascii?Q?LwBqpVa3tT7VNwPfQfwrr0ORHpYhufT3aIjtx8Z8CcaQmI6A3ugTb0NTLzvK?=
 =?us-ascii?Q?pryl+Q4fE3ZlJpTRtDp0tCBk7eGyrYtX+17E8g9dOAfOAOphfH0xc+nbeGt2?=
 =?us-ascii?Q?S735YM5Vv3/ge5eqeZ7lMB24XEG/wJf8ThT6ra29gV8ZP4yjVtmVquzrsePD?=
 =?us-ascii?Q?98q9cNdLDIaCDU+MJigQxgkcOs7rJLCEd6h9comK4jSigam5jXKYwmWBbdc0?=
 =?us-ascii?Q?+a3cE8MKE8V953T0qo2P+8MovPeVXTnXQVzjjD6eI3gO1dnfddK91DIcVxEC?=
 =?us-ascii?Q?SRrIBKjG6qmpae/iELj50SlDIw4ALspCKt8Bop8NQkEIZPjcq7bunNnfh8DI?=
 =?us-ascii?Q?hwsfVyXyspkHnV1uKRAa8otRu3h6fen8nP0490ExrftMNKXeR6yP3AR7qYeN?=
 =?us-ascii?Q?CdbQUJz2fCUH6J9NHhTUcR0+9CraXCleGBCstR163O7sTzHItgNpd1MmFJBQ?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a75be-2ae7-4aad-2b63-08dc84a28404
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:51.5090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUeAn+gjTXlatedjf+iV1SVqx/8mGH0lpy2R/8ceYO+7RZTAhgV6iwqkIDqade8Gpn+6R92DJjMHWCVR9a+qfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Use common zynqmp_pm_get_chipid() function to get the chip revision

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 drivers/soc/soc_xilinx_versal_net.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
index 146d068bb4a..76467a3bbb5 100644
--- a/drivers/soc/soc_xilinx_versal_net.c
+++ b/drivers/soc/soc_xilinx_versal_net.c
@@ -47,23 +47,22 @@ static const struct soc_ops soc_xilinx_versal_net_ops = {
 static int soc_xilinx_versal_net_probe(struct udevice *dev)
 {
 	struct soc_xilinx_versal_net_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode, version;
 	int ret;
 
 	priv->family = versal_family;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
+		ret = zynqmp_pm_get_chipid(&idcode, &version);
 		if (ret)
 			return ret;
 	} else {
-		ret_payload[2] = readl(PMC_TAP_VERSION);
-		if (!ret_payload[2])
+		version = readl(PMC_TAP_VERSION);
+		if (!version)
 			return -EINVAL;
 	}
 
-	priv->revision = FIELD_GET(PS_VERSION_MASK, ret_payload[2]);
+	priv->revision = FIELD_GET(PS_VERSION_MASK, version);
 
 	return 0;
 }
-- 
2.30.2

