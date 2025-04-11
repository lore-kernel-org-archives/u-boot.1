Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98392C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E896783F36;
	Fri, 11 Apr 2025 10:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sz0BoOc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57D883F37; Fri, 11 Apr 2025 10:09:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59F183EDC
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6dBAccaR+gqg5QoBO4Dw4aGH55EKbs61PvKkWz1VUMYYhNQopl1Gs8OKEPipDMhRX1w4QSzcK/6/sXgyH9BMMcagcTekVud4sK7V3ec3pN7EbGYYrTiCp1OXbvR8z9jl7TJBLmOUOd8j6eAo5LnxsXoDUG5hoXzSLgnqNuK6szS31QZX9PiRPqJIC1Uj4Y7F+8NxNWHF8hu27o+HmUC0KoaamljJgo/zB+hodnS3Bor4Ezbrd/Pzh71KFvhpp9X3KhicecTkMBsQdyNlMWAoNK6jAfDcFsTNV+5RVpc0QIfOhQLRT9B4xQPkBvqE8u8ls+FN79HJ8FMNHdV8JITWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwJBSBl2JN6XouVYve2uQiMV0pnhbhdHzHIWWPEO/d0=;
 b=At2AaVFMpzDci66+P+H17jYXWF7d3XLINM8pKWfcaQbpxr9J4Tyt/lXVmPz+alz57ZGWJ3hTAnEfwms72tLjSTMFNUdbSS4/8d94t5aiJBWpOo7rc0mBqs5OcWE+2UX8O5i44O/+F/uncXduCEVvs7RUpjXPWShDsnQ9gNfYf+girXcUzVUTWgD0588crtlEFqf7L91w1ROjDvU7pNZItcWuIOFDhevie+imMwZ+xJXfB0xbfNJ+70SmkrwIp4O5T5ampJfpw9XREBvePnn2EfGDsC/IqA0FYAJiBC0qi6eZWwVYcqhtaQCOvHDh8VnWD3NZfYSTf/KB+8uRSrpPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwJBSBl2JN6XouVYve2uQiMV0pnhbhdHzHIWWPEO/d0=;
 b=Sz0BoOc2GdAc68avTGHzXS2/qji5FlTTck7n5SpVQ/CENCj4ykLZ0C+TMYVHDpZjkePsgOxQl/bF1i9j9IFTd27dWeoCQ5kGHDRhrTsF9ziJXs3znA0HSowGxpYYfBUh3FRz4QpWSuArmOSdRqXB9QFdscaj3xRRldYXMTyRexpYyG9UanpTIUWnHAM4/4iW4s0yeQqjn1CLhTYh7YG9WcBaMYm7DtGJus7yBstcgRePjerextZhtnpkLb4iRPHn3cM+0uS6g2MBlqdcHez+Sicvv6D//aVzU/mL4caBveJ+13v0s2bAzfqZhmYAOFgXHyCpMpkhNzwg19wn/ebVlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:09:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:09:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 03/20] firmware: scmi_agent: add SCMI pin control protocol
 support
Date: Fri, 11 Apr 2025 16:06:46 +0800
Message-ID: <20250411080707.602371-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b030830-fdfa-483c-43b1-08dd78d0393e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C5FNfhSnGOqMg4SohsrCs06KhsSvLZgyDzDBWu6j4dzk3sgkXf3trLbjrfrO?=
 =?us-ascii?Q?IKeeruaQVsdClo9/rVbzJDGTU/OjzhU6hxmNyrLBfxeUrZrdN9Hv35Z2PR4z?=
 =?us-ascii?Q?34Oni+bEk6bXbeiyWBKSBJcWf+SWX+HvN63QWmk4p18D1B1nV4GqFNApGWeN?=
 =?us-ascii?Q?+9qS8A3Y/fUtdF/ZGkqfCfFxPDpqFbL5DRtDGrGFz4dUTldPdZmNOjcdFk5m?=
 =?us-ascii?Q?MOBTwplIRc927kXUNlCjBq4UTKnMATMeMlQfuNCUR1Z9VteNOx0aSQuD373Q?=
 =?us-ascii?Q?VohXeThJXI3P2iFlq20cUX4pZmEfs+QJFgcZTMla/3ckrcLxddG8yalBRsij?=
 =?us-ascii?Q?AvtlGH74zlrRYNjGAE/IpAImtev86x5VYBvn+g6i8BY6lQo1XIOKBy2v6G+X?=
 =?us-ascii?Q?OMnFLVpApmVaXD4QUXifjlmyehdFFTgqIFpc8ql4TxjRp43yZZE7kWNQtiML?=
 =?us-ascii?Q?ckzB1vp5vlsw8xj8BlgH3ExcB68ymg27QYycY7TFSgyGYBhp5T95vUwhryyw?=
 =?us-ascii?Q?Ov5QIWyDK/71LwY37pTA2OyoqDLVGItftudCxV4Dbb8sojBfylSF2ob+g1MI?=
 =?us-ascii?Q?lRF7xTdPSMeemajt8DcfBz5xueENt4jV1M3v1iJOGd+4TNai0IRPz10L6/8K?=
 =?us-ascii?Q?aOy00WjBTF6RZd4X6e168qka6EDFwdDF+Wc8QEa/Ov9HEL4sSrno5klQOqFk?=
 =?us-ascii?Q?4lvwAphPQduXajAeLxKohrjtepfDYN+SQKwWfIyJWhggAHTHDV5URL4WLhUn?=
 =?us-ascii?Q?25c50bJWI6dvaLrJdHXSfL0NdA7Ry8vhzsJmz4eFOlEEGaYSzWhRrEv+uTR7?=
 =?us-ascii?Q?Uao7wD5psd3deibq5TW4Nr6D2FLhlNGMW+2IcCPEEcL/G0l0LuJK/sjCnDes?=
 =?us-ascii?Q?jUpZvB+i1dgtu1jfu5OJm16V5b7XCmtee2m1G/7+r605LhIBM9Km6qWieG1S?=
 =?us-ascii?Q?43VLKpMuPyriVGz/qzBpMnSkQJK+S57kIwCWF3uuYfoCu81u6hbLwz5MyIUJ?=
 =?us-ascii?Q?wkvgxXGbgjrFivdqeRhzHl6LqNSK1WC+NFe+az82H7kHzo/HNRv6R91DNDtO?=
 =?us-ascii?Q?2IB7YNDTpJ+3hIbQpffsc+yfGHj+bxAlh/G2JYs1xjTj01cV73RLftO+t4wF?=
 =?us-ascii?Q?sdSfXzgAim3m+iBJ09WPlY6wLrSxmupklURltypG7TImvKrAl/R/nx0KbMug?=
 =?us-ascii?Q?5xva07Hnw3aT1T+5L28rXhI42wjBbcoVAeAYf+Bqrx9uOKs2UAsGoSQwXVcP?=
 =?us-ascii?Q?RzHKpSf3GjbOFhD4XbXzRU34NM4htFVE+1JfYWPzYOjFBqFeY31BSOUS1Vw8?=
 =?us-ascii?Q?Sta0xEO2rq2K1jyrccmgu8OkASbXmX7hdPD/wwuuW5HG8Fr2FU1Qs23NGIHi?=
 =?us-ascii?Q?PcpiTajyKIUza+UEsneTX/PGBG04sjNo+Sr04Ysx5j9Viab6mLxKtSAbG/oM?=
 =?us-ascii?Q?jc2kZlE9rSzWamKp29EOzfr2V37ce++CoHixlpblliznu1pEiRO0+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6qpqeUfNWWLeqRZ6MU/MsdMFs5tDiccZIrwPitTBw53h8pbG1UHpJ4StAmo?=
 =?us-ascii?Q?v9y4R0HzBmxRUgQtomHbXAXc4GQBcteC81xlaXv2VjOHgEa5/lN6gYVvYy/E?=
 =?us-ascii?Q?K4VVGchcZ4ytAOY8kPSuWa48Z/icFipuROTW8X5ZSHp9QLxM4p8dl70bxMky?=
 =?us-ascii?Q?ZTD7xD6MFR96pPfXWJ+h5ppAzBmILmlcVMaJ1OxwZdyTDmWJXz37YmA3FDNV?=
 =?us-ascii?Q?zr9j2GDNgE78ozTGjfManFc1MHq6NG++VCRQZDPfWgcXk8X9kbB4VOHHMGdL?=
 =?us-ascii?Q?Bez1LQKnAEkpM7kyIxI6JI5E0AaeFTXfSKRa/6TqAw0rspcV9sMjruHoY/33?=
 =?us-ascii?Q?cBGKPeyXaJqwMPNf5BAUconldI+sh916FDx16JqNfHIrmU0YAG6ewiUMHvPR?=
 =?us-ascii?Q?k32B0C5yAd1SAdwyttOnxPzuZQttBQvl9FAIrDhk4BOwGS7hSZSVdzztjlbA?=
 =?us-ascii?Q?Vlj9b94kaAOndapXGDVmxuSHISGnaVexgI2YTDK6hoKbQZIlgtzbWTb6NjaO?=
 =?us-ascii?Q?DPHfd0w51LWeOtSezvm82G2u5WdCA7EeccMiG+53hwOAwC2WMcMBjRJkhBHf?=
 =?us-ascii?Q?v8yKmUbZJDBerT5uusJkm9iOLeblnnyXfyO+TpBkzRie39LboA1PFxOReiqm?=
 =?us-ascii?Q?Nk0nthPlD7E+twoVeC72KORQyfHKaDZjuF3aTfBu7SI8pqd4IoNtY7NlWI2h?=
 =?us-ascii?Q?22yH+IaQEUq/kZgDqVQlpZbVgxT/4cHCh7lIbl3AfYhzoAqpjWGCnicCp1TW?=
 =?us-ascii?Q?FzonfVCGR1KXuCJwBtU8h4LiwDraIQFjy+qRCWdMPxvC5zarYuUo1oB51npk?=
 =?us-ascii?Q?JioHn++3wbllC8ZT5KX+MgK9NtcYF3J4mKoHt+M8RnOWh1jbGTqogDHLsSnY?=
 =?us-ascii?Q?n6CWXrp95OdjSG/HTDdwxVaDxW1stbQATXvMnD0K4wPjkaMcJxeCvZjibDd0?=
 =?us-ascii?Q?+ZXKIg6FQ4bJr1nYxPUwIfNWsED39R2axwrQ5+z5PLoi0G2DmJxSqClho7LF?=
 =?us-ascii?Q?vLfFtWzoX2UTfxXibbwE1E7T3rvTQDan06eyJCuG3uLiZaOocGVfLDACl+np?=
 =?us-ascii?Q?kMsctc4bLB01Gf0ov9TaifldDEGz0yBIpMAujnLXcXIXL0vHv6ZNWoM3dxAG?=
 =?us-ascii?Q?hiBoKwD3egnvus7VGfwafMVnCDWMWYu7PuDxJFEfTiaVLY9UYzr1nYsdEKRk?=
 =?us-ascii?Q?aMw9BK7kIdLs9bcwPh8UILmP+l4Ys1iMkrCM77lphFhShpvSgevvh503NWGq?=
 =?us-ascii?Q?Y+RtbDVM0Q/wmFZCYFi1jWXNdIDQOADS66/77E/fIIbsCJwwp8CAgiV3/vnF?=
 =?us-ascii?Q?C99yhkDiMqXaQ2FmIyHSGKH0BTezvwD4vTJbce4fwODxDDWhPCrzfkJYSDrZ?=
 =?us-ascii?Q?u82RGqJ4K5UJRuvon2u+s0ghDzAYnQki/GiOMxSTfuJYHSyq5TohCG9FcZlm?=
 =?us-ascii?Q?eQyS17aJPmPQT4gU6R7fO4z8x1ZwLKa3TzhykWROp1kC8syovTf9jNlLZ0XL?=
 =?us-ascii?Q?NNx3lPefcr7XNbCoUhNXQN2lvV3E3K8Ndahq4Ebi4PjnyPmYmJRQbYZMvwxp?=
 =?us-ascii?Q?UGQuzyPNPfxStv2eevcuoNYwcu6dGfIBm1xhp2zt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b030830-fdfa-483c-43b1-08dd78d0393e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:09:46.7916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEAKYm6n/K1/dpgrCL67+ljVuB9nEN9qt0omFFjsQ3A9yYSL7HRTZLGTdyS2O+QTyZapAuJlOjijPyAMC91H/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

From: Alice Guo <alice.guo@nxp.com>

This patch adds SCMI pin control protocol support to make the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-imx-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 6 ++++++
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    | 8 ++++++++
 include/scmi_agent-uclass.h               | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cc3f31d881e..e7ec2c108e6 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 20ea55d40ae..cc92dd89466 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 
 #include "pinctrl-imx.h"
@@ -152,3 +153,10 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
 	.ops = &imx_scmi_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_PINCTRL },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_pinctrl_imx, match);
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 842c56858af..d6586eb3ff9 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
-- 
2.43.0

