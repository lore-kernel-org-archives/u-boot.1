Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693FCCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E867B81D6A;
	Tue, 28 Oct 2025 14:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lLnAd+zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7187882A9E; Tue, 28 Oct 2025 14:23:56 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazhn15011020.outbound.protection.outlook.com [52.102.137.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DBC80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogeWi8lrBXNtiS5e4vr/bU8gzzV72i7mEyoGuRdSxV73qXSBhBrBgJGLx7RQXPpqGp5+IjVpA3g3YjXCDchwqwwAR9cxEzgtMKukg4xDwObza1Ajm/b718qsnNyWP+XW3kGoQaFPII5mxEUZ3/jK+t5Mdi7nDa0poOHY9vWG+QkktJtkb/w9sEdVHPEIMLMwf4Q5kdWv6PREUFlMFPl14d3lgFrkRQAW9RkwajcWTovps80G2lyXNiNacWKy2umybU3imUY6QBF/khWuoMEXp4mdpbapCWV3dSfvYxVKXtKuQZ1cD5RB9MFvmAvZxMQisPhtwdeo/iB277C+gsAdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsFa/byHvfXECMFn3INRIsMZNYLKGVZNYu4+cIBGgaY=;
 b=tsg8qaDfUn4wn2ZFXO1OSvxjKHHap2dUHaSJoO6sAGg4nXFsY3Fmtp8OgAXr3ouHBJhNi1oQOFqHO3U/5q5yfx4jVKy4lOHzJGghU3M6ke7eiZUcLUWld/G9JdpjM1swxz4Z+xpYEQ8Fu/XQto7b7qKTuIKLM09rFeSTwO4WkLEjg6voqv7eEXtZaBF8hwwmaGufgKQtm0lA9cyGyWarF1NwXaVCiY354E+dUx3YlBM8zJuwot9slQdqEM9Kn7r+E8ZZeys0SRCyaqbG7nmNdSR5M3RhZukISBuRScz9xshH++SONmndO9JPVezgjbb0v1n0piWrW+tHQsx0w1X7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=fail (p=quarantine sp=none pct=100) action=quarantine
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsFa/byHvfXECMFn3INRIsMZNYLKGVZNYu4+cIBGgaY=;
 b=lLnAd+zrMvw74lbXYmFow23hhV/bpOdLP6BT4+i65PCVV5h/2TQmN7GXwfIs/j1ovFALAgnW1fTtkuHaTF1ME7Dy9s7Lap5PTtqQHtnmVL/XRqlMbfYA6q0LLBaRLMpE4Ex1GLj1ngArd3zSUqVWEuGFr7HWeQ5HCRrGXvw0cXc=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 13:23:45 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::b6) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 28 Oct 2025 13:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=fail
 action=quarantine header.from=ti.com;
Received-SPF: Fail (protection.outlook.com: domain of ti.com does not
 designate 198.47.23.194 as permitted sender) receiver=protection.outlook.com; 
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com;
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 13:23:44 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:23:43 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:23:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 08:23:43 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SDNg6E2384306;
 Tue, 28 Oct 2025 08:23:43 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Maxim Kochetkov <fido_max@inbox.ru>, Dhruva Gole <d-gole@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version
 3.0 and onwards
In-Reply-To: <7e1881e5-3feb-4b26-b9ea-e6e56a090873@inbox.ru>
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
 <20250909101806.bymqunywxu6pe33o@lcpd911>
 <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
 <874is9h937.fsf@kamlesh.mail-host-address-is-not-set>
 <7e1881e5-3feb-4b26-b9ea-e6e56a090873@inbox.ru>
Date: Tue, 28 Oct 2025 18:53:41 +0530
Message-ID: <87sef3p3c2.fsf@kamlesh.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA1PR10MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3015ab94-58be-4f16-41e1-08de16253836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|34070700014|36860700013|1800799024|376014|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYMkW+SbEhN0wwzB+6PKvJM48kSSg8OzQZjBudRp1KPUD0VeIISK7uxqt1ki?=
 =?us-ascii?Q?SX9aCrWxaWD+yy9zURQWUVi5kMK8ZoAM1cCyYxhbbJqk8bFcsQyRaiFut8k1?=
 =?us-ascii?Q?RlpSO4J2rSWNuZnDY3h60v2M7o2KBRaawOu8hVkvDU7sd39fUxN/UQq9Yy2s?=
 =?us-ascii?Q?L46KrhQmanwdlKHEgvUN2raPWLWYjAeD5OfZ3ua2Ul8rBug2sq/Us6sOfx2J?=
 =?us-ascii?Q?QgaNWitniYt0tb5u3jZIOi8VbtK0r7tyOmmmTu8QzaXYfrwCT3wIivg20lll?=
 =?us-ascii?Q?31hmO+0JGvNmx2cuYuYqeATiN73xzRXpPA+3fT6VvjEgMQQEcfvfJZfseORh?=
 =?us-ascii?Q?n+uWiO+nZDWn4W7gkRKZFpGZTZ4IkP4G780thYWsE7lPQ3P5cCpjLCzlzj0F?=
 =?us-ascii?Q?vj/l7vfXDzbiKg1h8aXOkSKUiUmyXJTK5oEO/skMQ3vilS+20T3DwyWn5ksp?=
 =?us-ascii?Q?q9MCqDCt8Fu5BU7yCiuo6TtIzVL3ABKMV4F1yLDllJd0BxJrcil1J0KsF1zY?=
 =?us-ascii?Q?3JSG34jF3Gl0Dw5yccXUeRvDMVkWyWTXvwWiTt72gTo8lik3E/Uiv0EJm9fL?=
 =?us-ascii?Q?O8WYUeardYtbAsrhKTHPjzMx9yYQ1O+jwS/gmZpw6lMs22jlNnTD4Xf58Llk?=
 =?us-ascii?Q?Q6q33OfjiLpOF2iqMuW1VpRQV9VyTmOsqKEFFi8DJ+RMqgWFrnX/3DN91GaA?=
 =?us-ascii?Q?rSIC61MrCXOpUJAYetZDS1jcr33exxTXVJhX8M2OPgz1JqkPYZgNX3tmeUnK?=
 =?us-ascii?Q?k3WHUbK53uTqMnEyoFkwG42clz2HiBt/864NXqQqN3BmG1yyqXPLDYFMjPgE?=
 =?us-ascii?Q?ao/J1MmejnI6lIWY+hCmnKxs7dCIY/12yyyijTuHYl4maFR6ckeft1QezpkJ?=
 =?us-ascii?Q?fE8CwoAHOUbfep+ssdOMhakWjzUTkzBoL0vZDz9Ju1la3XtGyYU6IRwwI4yX?=
 =?us-ascii?Q?6iMrmUnQLlRPpxZ0GQ1qrS1DZEfNI7fW1uxYcBEcZoQ0vik29d7xfKAwWD6T?=
 =?us-ascii?Q?wP21Xiu9bfkjlwJzlgiPTGU+9huMeqT5r0sr/XqfqrRrGcf31v/MEuSnSOF3?=
 =?us-ascii?Q?lhGLO1GAAHRnMB5zICg7WsLJbQzFOXy1pmmRf4asJ2mkaeHJRKPd+1HbOhbe?=
 =?us-ascii?Q?jUJsNGKSLiXfzss+johX2EHa4I/gAUhG35zVsTw1u+DEEPuJqtJLyqeud1nS?=
 =?us-ascii?Q?4W0tcpB3H6KwCdcS4QSdIuKDFR845KVPkkZmLVDRYoNt1hlCvQ6Vdm4gbukL?=
 =?us-ascii?Q?vEOpI1eTfyx20IT5JumlMVwSh2OC2tG99c/S06h6Dw5r4o93aP0aJ1UfV9MB?=
 =?us-ascii?Q?CFdz6ree/LZeMxmXHfADrolmMaKBX21w1tBKZwx29tOFYYmH75QE/7/ksGCa?=
 =?us-ascii?Q?Ua5+tZLPLCiWJ7IXuTxz4Md9gZ6yAO7aT8xc7cAA4Dn15We6m7DT9mg7oHoO?=
 =?us-ascii?Q?nZLy+k3MJQBwhPfcF5yAF5/SDP73JSFPVFDB+OS0qau7B96UJFY6YPvjRUAq?=
 =?us-ascii?Q?340q84h7kSvGdy/67p0TtQxOmtarc9q7lVUC3BLi1jGYQD+2/I5erzcKHvOQ?=
 =?us-ascii?Q?YcjQSV/+0epPz6/sgy8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(34070700014)(36860700013)(1800799024)(376014)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:23:44.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3015ab94-58be-4f16-41e1-08de16253836
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
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

Maxim Kochetkov <fido_max@inbox.ru> writes:

> 08.10.2025 15:27, Kamlesh Gurudasani wrote:
>
>>>> Could you elaborate?
>>>> I think clk->dev should be fine, similar to other instances in the same
>>>> file. Maybe I am missing something?
>>>>
>>>
>>> clk->dev points to hw clock device. It has no struct scmi_clock_priv
>>> stored in priv data. So we have to step up to parent device to get SCMI
>>> protocol device to get struct scmi_clock_priv to get protocol version
>>> priv->version.
>> Hi Maxim,
>> 
>> in probe function, we are making sure that priv data is available
>> 	struct scmi_clock_priv *priv = dev_get_priv(dev);
>> 	size_t num_clocks, i;
>> 	int ret;
>> 
>> 	ret = devm_scmi_of_get_channel(dev);
>> 	if (ret)
>> 		return ret;
>> 
>> 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
>> 					    &priv->version);
>> 
>> 
>> Also, the code is working just fine and returns correct version with
>> clk->dev
>> 
>> Let me know if I missed something
>
> Here is my debug path:
>
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -135,6 +135,10 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>          struct scmi_clk_state_out out;
>          int ret;
>
> +       printf("%s name:%s dev:0x%px dev->priv:0x%px     parent->name:%s 
> parent->dev:0x%px parent->dev->priv:0x%px\n", __FUNCTION__,
> +               clk->dev->name, clk->dev, dev_get_priv(clk->dev),
> +               clk->dev->parent->name, clk->dev->parent, 
> dev_get_priv(clk->dev->parent));
> +
>          if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
>                  struct scmi_clk_state_in_v2 in = {
>                          .clock_id = clk_get_id(clk),
> @@ -288,6 +292,8 @@ static int scmi_clk_probe(struct udevice *dev)
>          size_t num_clocks, i;
>          int ret;
>
> +       printf("%s name:%s dev:0x%px dev->priv:0x%px\n", __FUNCTION__, 
> dev->name, dev, priv);
> +
>          ret = devm_scmi_of_get_channel(dev);
>          if (ret)
>                  return ret;
>
> And output:
>
> DRAM:  510 MiB
> scmi_clk_probe name:protocol@14 dev:0x000000041f51fc50 
> dev->priv:0x000000041f520ae0
> scmi_clk_gate name:UART0 dev:0x000000041f522710 
> dev->priv:0x0000000000000000     parent->name:protocol@14 
> parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
> Core:  132 devices, 22 uclasses, devicetree: board
> MMC:   scmi_clk_gate name:EMMC_S dev:0x000000041f521950 
> dev->priv:0x0000000000000000     parent->name:protocol@14 
> parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
> sdhci@0: 0
> Loading Environment from nowhere... OK
> In:    serial
> Out:   serial
> Err:   serial
>
> As we can see here, we have two different devs in scmi_clk_probe() and 
> scmi_clk_gate(). dev from scmi_clk_gate() have NULL in dev->priv. So we 
> can't get scmi version form clk->dev direcrly.
>
> P.S.: I have CONFIG_CLK_CCF=y
Thanks for the logs Maxim.

Looks like the behaviour is different for CCF and non CCF

We have parent->dev->priv as NULL. (and no prints from probe func for r5)

*r5 core logs*
U-Boot SPL 2025.01-00667-g8d2958a533ce-dirty (Oct 28 2025 - 18:43:57 +0530)
SPL initial stack usage: 1984 bytes
Trying to boot from DFU
scmi_clk_gate name:protocol@14 dev:0x82b7a400x dev->priv:0x82b7a588x parent->name:scmi parent->dev:0x82b7a1d0x parent->dev->pr\
iv:0x0x
#####DOWNLOAD ... OK
Ctrl+C to exit ...
ERROR:   Agent 0 Protocol 0x10 Message 0x7: not supported

*A53 core logs*
U-Boot 2025.01-00667-g8d2958a533ce-dirty (Oct 28 2025 - 18:43:57 +0530)

SoC:   AM62LX SR1.0 HS-FS
Model: Texas Instruments AM62L3 Evaluation Module
DRAM:  2 GiB
ERROR:   Agent 0 Protocol 0x10 Message 0x7: not supported
scmi_clk_probe name:protocol@14 dev:0x00000000fdeb65a0 dev->priv:0x00000000fdeb6f30
Core:  84 devices, 32 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from nowhere... OK


If you have suggestion for solutions please let me know.

Regards,
Kamlesh
