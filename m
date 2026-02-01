Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2D3E65294
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 15:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BBA83C02;
	Sun,  1 Feb 2026 16:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mHrzcJ0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BAB83C02; Sun,  1 Feb 2026 16:14:05 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1D683B86
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 16:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKo4t027GSMy8CMCfb7W74ZdPNEizGFAU8pGE777XlB99yQBt6TwrXZm6RAunAGaFsxQjfzgibEtzjq3NhlSsfp82A/2PGLLA3kxIeDxcnGY0F/84BoXfLNqx/LmVuU0dl7ezg9Wcz+uFgiQE8s67qhvQLEbSyrh368CTHV8s1at6TuEAVoETj4QaqARkBdUeafRVhrsiYDk+gOFY9EUriDtJeEB2qdEkHe5bRKB+Zy1JJlTii/Th8aP9cf6MFBCP3txFtOL34UmsalxES9fY+YVimiWkSPtCDqlQ+uddYAPpgj1vsXPTFGgERNuQIczDuZLFSf0I5dtcTFj246Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTaL0fEmidjoZS+VhdKW7Z2Qdc3r+hlycbHtlAR6mj4=;
 b=Ri3Kq3hFdtOyYj94B81ihuVM4dnfPhuf1AOa3yK6BNpfA1DShuwExFgJmFP5QmuuTImEjyFegP/aLU1j3cta+NBqsQ+evAwfE9YxarCsNEQbGj9U/tbGDWdgv2RnmyxMIZmq8fGhExAEnbJxZCU79SY3p/cx1mga4iiJQKEjOcBDEQL7QJaSad/Gx0Coi8tZXt8224RetRPZd3yDkNtUJqHBT8PZImdzPYNhqMZUlBe3x9/CB0qW7Ka6bBoZ/06nv/VhXKGtxUe+asdeLqLCMLnzN6qgxQBJ0h7QUdRX7fkckK8GBeQS0RP1oL5pehFPdJJdzKCsxG2ORzWg4tOE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTaL0fEmidjoZS+VhdKW7Z2Qdc3r+hlycbHtlAR6mj4=;
 b=mHrzcJ0zSC8CxB5zekG/Gq9NkKMQOQPrikZv1hz/v7GJx1PIUk4wdHS71GguWLP/uQD3UEeN7p+RGJ81s9cRZAP5XySCKFBFOnY6bd6gJS+zmY7/7QH2JKJHV51y8Yhm7vP+HGF4B/gzl5KNjQzA0s30q7CKfFby2uHYmR61AahFwf3zrBwIESsIlLKFQ1rS3q+qysmDT+FilUFgyYKnJb7VIIN6pU5B62NwzFtfAaK0x+baNn6Vn/kM/CGQ3vKucqECPDB8ApnhUqiSmwVYRqJn6tkqB57KqBKOlOP4ZmPmEbsQP712EjmA4rwS9/Xyqar/Ghhyp+xQ8hUNnDBOQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7901.namprd03.prod.outlook.com (2603:10b6:806:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:14:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 15:14:00 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v2 1/3] arm: dts: agilex5: Fix DT property naming convention
Date: Sun,  1 Feb 2026 07:13:41 -0800
Message-Id: <20260201151343.27560-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: beb37072-c0fe-4afb-0e2c-08de61a485e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zvJuAooVIdkTwFUP3gvT9bLy0KcmNwLzhVOgstUx3N/+uw9cBpjCBdBg4Ixa?=
 =?us-ascii?Q?jZ1vq8nXnuaeBYRuQ/okwRljLzZ8+nQrMJAOn1AFVONV7Bv4FQTe1ZpOS4dW?=
 =?us-ascii?Q?zqrbLLmpnpLNbrkUVRg2HmM0h4vt24937YJ4MMbBV7yHCDBO3OAHJ1GQzltW?=
 =?us-ascii?Q?fVuCd2MiqlrgcsKkBzrzfxmOJKlQDjCx9P1fKi1y3VFGrT6vYak4mHD8v279?=
 =?us-ascii?Q?eNb3FALx7cqT/L5nq/pVzZxhq5BoHnsSoKZxgv2/9wy9/JLL8gDNPLg5gEK9?=
 =?us-ascii?Q?OweFGHnwjOHvUS1udaHnv/sGH6+xZ5xY0uh63/VOeWNy/77yKS/EepGPDYtd?=
 =?us-ascii?Q?WmHwi4Sex1Yh4syKzB8EkLOY8J01jfjCv1aBeE18qnFp4Nsqpe/kQUJlHscV?=
 =?us-ascii?Q?3VDmYxNVlyVf3+oZEO2I9kzYBWrNP2mPnUre6Sq585oImlB8mI5g4q+1JelQ?=
 =?us-ascii?Q?Xlces6sbhxOaStv4jwoSZb+DQ3MY754d6aB7tg1wrs1VCb3tHL6Id92SZpWi?=
 =?us-ascii?Q?vIjMt2iRUY4IQI1rDAjG/Cj/p5Ep1wCiJhSW2//xDBA9Cypy3KHnebhRhmaT?=
 =?us-ascii?Q?feAsJ5DT/DOGybGi/M4/2L1NZM35Xdpu4BoQQoA/pobDebcsAt0K2KxT6NoH?=
 =?us-ascii?Q?pxG5saenQK0bpI9Dfs1kXLox+NsMrKMDlwrjmwoH0VxpeOQWpKBNqIYh3gbC?=
 =?us-ascii?Q?X4yh3gDX5Jt/JLjkMg9Zrx6gw/0YTjvfCdb6x3Mh3dzPSMe+ax9HPdXun/OF?=
 =?us-ascii?Q?GqRx5Q2i/k2I02+JpxDPKee2A7q6PpibW0ezx1MZSWv6A/l32vpIFpky6w7s?=
 =?us-ascii?Q?yh1VsDdffatDZkI6FPkdfSjiJrl/OJc8Ssl1pVhv9ZiViCJB7lbJip22tpCy?=
 =?us-ascii?Q?89gkq0/zUSGtku/ha47sIkLWGym4PZkONYe9zCnQyPqzrnP9VwD5MNMw1fiL?=
 =?us-ascii?Q?reYgeuQ6H8uCfW/2Y7COdMNPMyYtoQ6Mz0bt9iMZFSb3YYgXMFa9NU1G2AQV?=
 =?us-ascii?Q?kH+KZ1OdAcQ1VdA2F4CaGjXYYkGn/9Tt4zd7dF+2hFdj1+uu6PgJmrwaZR5z?=
 =?us-ascii?Q?dJPXh2P7Gy9jyTpLVFMHxN//njJqdAmzbV6es065SWS4H14NB/PIXvfGdoFh?=
 =?us-ascii?Q?c+C5m0Pyv/ZkuZ8bZGOar1uJ3pG+zoxEI5ZpDiVM1JkT9QBULOczNOH+qhtJ?=
 =?us-ascii?Q?Ts41Opeu1rnStX09ErJWn5KNMaYp4yqXzPsLCVbLtOGYSRzRnveOFDZUOJBN?=
 =?us-ascii?Q?nQj3x9l5WTVMJQYdG6ZkhJ8+1Cb9XaKHW0Rn+jW0VwQSa+zVZk9/ZanasuBU?=
 =?us-ascii?Q?ZklSx27xtn1T1Ct456ShxEGWp/AXtz+VGf4ozbTILop2OkLMi7kXk/iFHSX7?=
 =?us-ascii?Q?xR9iEwsRypXx7ILMkVjhplMtFwn3SnAjlPOy8IYc9PovrlrwKPr+0pKlruo+?=
 =?us-ascii?Q?unR/pjfYdmZd8WgjeRfofteu3vWFaxu1dOxz3UcGP8rRvvu1pP1Wp5GquYjA?=
 =?us-ascii?Q?dFa0LejIXmWvIOQlZLcWfISKYlaR6Krzeux2RnNPOned2DO7052txc5r34Mk?=
 =?us-ascii?Q?wMbC4px4FXW41LgYLJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?irpxhMNNhepSgrFdumPkh9s4RUtdwbh/fIANu6jZjLCma4Lg+WQlfpsWw1IL?=
 =?us-ascii?Q?Pz0O2P1QUd3SmL3wht6OR+7rUhppWBwmcUCM60izYkL5Lbb3eEOK2vtfTnmq?=
 =?us-ascii?Q?yntTWWdiXsZtEWObqDuIEtFq/lxQLlcwwXAw7sFJH9xDNjr8pIkCVEOw0x2l?=
 =?us-ascii?Q?dkb03ZUOhOV1aUF7ls/RK6BeFIpwWGr6vTCVR3k5pDx0Xlj+jO9DqIQ9TNLL?=
 =?us-ascii?Q?3eHQQcRptAwOOuGuLdURaScBgzwH0VBo4I8bc0RlJ6jQ6kVUemvPSbCVb7r5?=
 =?us-ascii?Q?909nNvecD4Anm6B9iVEY6ljwKy6z7X4Q2XrHyFWdz95lbZiMtp1XVI0Ja8O2?=
 =?us-ascii?Q?PN0VVRrP6VfFqO4cQQoqh4B+rUDxGb/e/2d6TWd5UvUQj1YX585DjLFTcXxe?=
 =?us-ascii?Q?U2iPi5lTPaGBjfW1iD4fwDCsIHD/va67+gLgY9atCpnsQZvXSYKDCyJzPAOy?=
 =?us-ascii?Q?H/t9LAM8IyiYVEbfPxmOOVxhaclOP0PgjCvlkto8K4hMXtfvNZ1PtfHhes7y?=
 =?us-ascii?Q?TBdIes5pfWJrzFC7htIccuJmdwu+i22uBvVEP/A/dL+Qr8nbz9l4OXUPfJVZ?=
 =?us-ascii?Q?vAEShKmfyAv8e/mL+9gSBf41E7J1S70ANBtKlS1e+xcqOLzsifrlUHdJ09VJ?=
 =?us-ascii?Q?H/SBHfeNMk1IK3UstPD92fJi6yQtZBdX4Z/GjXEh+SfQaKnyb2S9LFsSrWbb?=
 =?us-ascii?Q?OTVqNFsoUuCQ0Tq2+DPV8DeUulbKLM67e3YdfbG5P5ryVOlxI+/lAhrEJiuU?=
 =?us-ascii?Q?6Q23a8N26f1AWeZcKCP8bfoiNdApIaQDWOpO0/eFP29ari9+MkCqDRibG95M?=
 =?us-ascii?Q?gZOWy2g37Uz5FWvh/r9w1Hma8HzpKSL9HcJ/+pmsGRx+k8Ud5NLuxSi7qZCH?=
 =?us-ascii?Q?HwSXDSA8GpqavzEo6FGBVRUlPGyZWlUGer0/r5OUwYwhzdJmsOWbzU1Bw5Zm?=
 =?us-ascii?Q?+ayMZOEYvA/wTIs7dFOvdAabVjzfiDqBN84Vqcb9brDt6KdoyQdZlr3N+L0Z?=
 =?us-ascii?Q?IA6kGKdPe0o6WufATvW3nzSK9CIguKYqhgZCPOXRhfh3F1nXzENdUpFKoNOw?=
 =?us-ascii?Q?PyilFaRVHcOQNv51ae+RtY+7X24dJCoL70eKnL0n3AGBvqFgVS9NUr+iI/LV?=
 =?us-ascii?Q?quxPx8GMRkdQ+Tk1t/5c7NqAeti1XJSI2kwvBQWiCEmI87TjcBSCL3RtcwRx?=
 =?us-ascii?Q?b4X1sXUdOoxk2LQoFsqithZdN+TmnaPpxmkxtfF30EX9zmLZrvwISOpayXmz?=
 =?us-ascii?Q?ZzIpDhglZx6tetK7E3VhuNPRsxX9WyCnHNIeS/KKIXz3H99UQ3NHuhwa8X+V?=
 =?us-ascii?Q?AutdpW4B0AOnthnzDcB7yFHYSR7e/4PFe4lsHzZ+nOLafzlo8CWZigBCkwgS?=
 =?us-ascii?Q?NlrN0H/eXXt+L+VjJH4Lz+OoIj1WnPMrZiqvNfbE8g4bNBrKnhrk4kjVodiG?=
 =?us-ascii?Q?NPD4kEX2qgxdyHlG8aigq7nWikNKrkAD0PbQ37mpDNVP5Mwcs6P8Gy6Q8OoI?=
 =?us-ascii?Q?oj3mK9zB0SgEHr+UbzXzkMM9y6sRg5sKGgfsAlbGZ33xRe2Fi2+sn8JskmVQ?=
 =?us-ascii?Q?YqRiKY2A/cFPz/9NQLx1j0qch1l9jheUbgOvREDVdL+Tz6tsFQl38RlDzpOr?=
 =?us-ascii?Q?VXijpAtN9eTBURl4o4uwmP5Mt8WQdWlXBAUxNlV6zDXCLHn8835lUi9VoCAg?=
 =?us-ascii?Q?Z47Q6CMPUuWY2YrEgK/KPgbFDB+UN9z0msDmG6qlkjTp5xxAjfbGOJ4JK8bY?=
 =?us-ascii?Q?PxyKRtvXNa3HLFGEH93Ctq/6sycdWdM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb37072-c0fe-4afb-0e2c-08de61a485e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:14:00.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qC0F7jEEivcelbm0cOuUVDX6YqCLBsqDdj4JloFc9lWPrs9nsq1dvTUKxHK5QuuJm0uPANIt1AKpD1N3z7UqAMMmgAvK5KsqzrdXn3yYVlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7901
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

Replace underscores with hyphens in the PHY timing configuration
property names to follow standard devicetree naming conventions:
- phy-gate-lpbk_ctrl-delay-sd-ds -> phy-gate-lpbk-ctrl-delay-sd-ds
- phy-gate-lpbk_ctrl-delay-sd-hs -> phy-gate-lpbk-ctrl-delay-sd-hs

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 5a7aa5841e3..b443e57b1cd 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -119,13 +119,13 @@
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-	cdns,phy-gate-lpbk_ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
 	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
 	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
 
 	/* SD card high speed and UHS-I SDR25 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
-	cdns,phy-gate-lpbk_ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
 	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
 	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
-- 
2.43.7

