Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F8CCD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53DB83FF5;
	Tue, 26 May 2026 08:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Y2qfzYRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F56C8464D; Tue, 26 May 2026 08:29:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A4383EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvMjK4g6j6GnK4w+tSDPlcXjD68Uk7kqjiOkVdEFCYE668f4Tue8DUQWQqUXmK4muuX+c7r6bqjzecOc6Ms2yeB9CkWLWUPMQYqAZ1xGWLeN4xY8wfsSRsgZYdz8RoCE68nJA5yyu6dUBH6GBTXsnA8cIgpBqmMP4x3kt5B2HrPO8CKqwx1cniVLlGlAbbkQHryQGrimbV5JzuXCCNEujhukI+Pce3Au0/LPofY5ugOb8M9sGCeRvuQJdk1ug/pEW3UTb2WnUEDMaEbLAjbubL6L8YJWPrUR6j18AvGh6r9l7iHrqqsnvqFowmh2dOvQR482jkmCn+HZCCzB2p490Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPc0PvH1kDMECCrDdc9XNxOo6Om6+fb07PsHJpVzjP8=;
 b=HknPKrgte8R5SM+Fy2+SugZcjij3uJnAESKfcoDf+34WZJYN5UyWNfqijZMRT7dhwAYV1efXm+inxD0/qPvoZ+TjXmODb7CYM7Ohd7OHyk8QyAxQZsQtrewEhEGp362AqIj8Icbd9GzuoKH60vdeC3AcB41hyLdtC3KOI1ZK+G3mtrG50+TmxP00KDQslWMkT4Iwr+gRZg6CJcjkHpk1rXasWsdl0idVvERs1VLRapTXKloPv7ZszpV6DqABzuviGTzCuVylBEmH3YXMSU9MBIay2b8E9PHv9hQQL6NoQK/V7ZLvQD/ZnLebGBQjQv+stZRuoCvh8KwO07I+P1/OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPc0PvH1kDMECCrDdc9XNxOo6Om6+fb07PsHJpVzjP8=;
 b=Y2qfzYRzrH+k+T/5DNZwmMAtJPoiJ8Dw6Eq+ld6s0iT2K3PxBrUNYrxElWWUJAg0BW2g31V3BoQPPG9a83mCUnbTxs1/neae8ZpjGfXaIqUbsiSnQ0Q3oWs8+IccqhVjiCFeBGLc65Jyd/A5ojaLMhRF282fz8UBbGZ2vgxOiWmyb93Jg6rAqR0jErnmHqaxtFesEK1US8qRF1R4kJn/vdc2SMRTf1TreCq+HgbXR6s6wIWMz5ikRRoUUYnydbwh5lleb27HdxHQGo9r3N977wypl9pittGUScYD6INwIBDTRCX2DzPE5IuVPkd8O/3KRvXPbkwmLTH3o74ytbc7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:29:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:29:37 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] ata: dwc_ahci: Use dev_read_addr_index()
Date: Tue, 26 May 2026 15:46:16 +0800
Message-ID: <20260526074616.2800003-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526074616.2800003-1-peng.fan@nxp.com>
References: <20260526074616.2800003-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: afc7e557-6a30-453f-36a3-08debaf0287a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: SUyE3AbmQh3q2xf+eO6NwXwbhn8fpANuBArgGlSjYmYANcV66sNyd0Px6ZGTBPC4qf7rK3bsh6fhf8HqAXnZD07Z6gc1/zQtnljsinO0pRgIo1wCE0BlJUzYBRV9RliRKDg4sDoJlpzZeXqNZ2TxkQuOHUtBsPy4KqnXBKUg5JJTT5F1ijnsfhVpvmEsjZQkN7NoKirwlkpckm37x4zhxuSgdEAirBIKbfVvz+Fug4AFoyPUT2G1vwuY0roWB/86Ies//tXzrDqzSwQ9z0OTFLLZ3SQHNX8op9uj5C9LTXNx+oUAA3dGPcX+CrLUxCZIvVj6wbpt6fDnfvDKBfN2/WS6S46g73ResEJadC3yiCtoXXx7m/QJSa5rQRUDEf7CxmH1LxqNkfbnKEnKSok4ENod0490p2w8BZmG9+9aRLg6Kp7rgxHn3Sji3EJdwzQ74Zh261cC6QFU5melCzR1fcGfbNmUcEE3BKZFLQ51KgXZedRPdGFKiegZJ0xZ+UUC4CZgLZD00PDQXaIvJCj2z/MhHskUrWqZfbLe863H9aFMwZmRrffG8UuztEGJGzPty0VxZ2WVVy957KrpVEA2BcAJpKdNV/npjEwSths+3E/p+sxyBLl8AK3+TabGJXed9ybE2eLVku1YIgh2Am5Z+OfB3kuaxqW1Gy/wOojhyeFqpQJfgza5PmKO8m4KWF4njycvBiYHNf4wQSGusuoUmTEW5K9rWZTNp7Y74Wb+j7e4/2FwgRkU/1XbsDVdZvIu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvLJ4iXGHLSNPPydzuZgDxu27mY2WS+EQUFp7SgVXlF/oomAiqFN+4EPtedi?=
 =?us-ascii?Q?EwbnojsrN2U7T6DMeAHBdESpNlteDuEYKTIbxM5ZrEBoY5el8Lurh+9OCVk+?=
 =?us-ascii?Q?NK/XrVhtd28+i7Xiu7PrKBGlW0eBh1lyeJ44T3Wj0LOLQ+HasRzeBw8Avrpq?=
 =?us-ascii?Q?F5T0dr+FtDT+5eZTBw1KlG9mQERKyAfnAgShXqdPBcmfEGNU43yF/BP+a1wn?=
 =?us-ascii?Q?P6W9AiZvgMfNbL8yksmlgvmDGy/ffgmMciiAfX1+x7Kl0HkdS+371y7x6LrN?=
 =?us-ascii?Q?u4fj3NtVcoMWDfWl6svrEtsPXMvkWewP6P3MlPmzXiK0Wvk61/UF0jnwgeWV?=
 =?us-ascii?Q?Dofuw4FvShhhgwWX34tVGpavTsmlTLQvJkkDLwt9Ilni/nYuU6w3d7TqhGJK?=
 =?us-ascii?Q?ph6ZYXIDmne96JyYpEBbWBZTuRQwQRu26ZPZuEm28y+nxvtYqOQ8mWCZDLLp?=
 =?us-ascii?Q?Bar6arzDL34Tz0i7u34aSkva2WkqGRW1QpZadjNaSN91QICVZMmFWr36C1zk?=
 =?us-ascii?Q?c7LNwtN/uza+4jPZk8fCsXxHte7sd/PrZo4Tz5YF6eyjjFE3MF59pIk6UjWW?=
 =?us-ascii?Q?HLDrMGRYsMTOTA/ZG0UllDhBpEz5oaRMUNRLZLDbUEPxaYRgJYOgOdKmsEA0?=
 =?us-ascii?Q?X8ZJLM9tGd13rl+hGyTwMJpEKxS9NpvbRI74j6pLwePytLKuppATFSHQwM8T?=
 =?us-ascii?Q?rA4aQupnpFmOG9l/k4TawEk5D4GmCuJ9hIthhI7kz0kK25ICbUGo3Qu0hybn?=
 =?us-ascii?Q?QYhZ30EwQfrh7jjAGtdea3HTfiXBnDf8AMFtCN1Ny2ilo19XXI8I2MIl+XIz?=
 =?us-ascii?Q?vsCKVyVDS/56tLx17py2Wx8n7FF0vcNd8TExKALQrBThl0xO33Vrg06d0K3N?=
 =?us-ascii?Q?1Iu25Pi52F1cf8aII9G44wTA5Mh/JGximdvggdmSdQHpfYnAG5ci+kOHZUdq?=
 =?us-ascii?Q?yZmWr/IZ2BP5Z7E+YOuD8Pn9R72vjo6ruawcpNt2dBo6toA1JS8P5SmEu1mQ?=
 =?us-ascii?Q?ASBXytxMwR/ssJm71gV+QVKbYKx4xVexjH9YRRsOf4iyFAgt7K9ZF+HpAnyY?=
 =?us-ascii?Q?r+IEhwmzFt526mBaTOpbCeVSgTFxhD79UMdEAXoEsxxu5EjrMxcdEgv6pqwI?=
 =?us-ascii?Q?I5FKRyIMJ7AmzbLbR8cnzat8L6mOyeVo/Ek+4ElRvKCojlMUKTttHOpjPUMM?=
 =?us-ascii?Q?8QJTIc+BBol+IYgr9+I3UdZ9/9rxxpg+9uzDVxt6lMggENANk4DobzJhIrqW?=
 =?us-ascii?Q?d0ABpLzMerFXd5k2Jku3LIDtJowYuZ/P6hA6PoHFOBtqQAdRsFnPDw3AZQZf?=
 =?us-ascii?Q?OGpwGpKfyvLeoAp3fZ/zb8FU6Dzp8If9KvhfbT4448LNDQKPy4oEJ5DAj3Fk?=
 =?us-ascii?Q?8jnd1GDO8UnpScJIdTXq934PBxABnZ3/bnfBiBFWI6DEeGyM+O6LY0a4Oky0?=
 =?us-ascii?Q?DiG0v8EzOwXX6G1qoL6tzo21PDveAboxsBOD2k5uMTYvnQjXj5++hPI3H2Ma?=
 =?us-ascii?Q?nMyavZ1FNZbLpIDD4Qwjj4qpmfNvxsEoM1ncBVdHnvSop8D4qJrqdO1qNCUN?=
 =?us-ascii?Q?bEkKlztOh9h1knzMUjFFWo3fdvRq3qOzurWTcWwU66Lq9Yr9CRG87a5hykPY?=
 =?us-ascii?Q?2vWSHL7v33IgfxSlcX2tr19nDVBXBeDB08Lln4eH+KNN/U5DiI/7comJYQoa?=
 =?us-ascii?Q?Y6qNn+TkuKcsKyeGLh8SRDPeSy2u9FDUg14SmkJzDV/XYeLJHHBgsnuq0Y+3?=
 =?us-ascii?Q?NVwdY0Bijw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc7e557-6a30-453f-36a3-08debaf0287a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:29:36.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hu6Nrvf5f/MR4UPZx1vRQtKjBiqqCnXer/k19XNP4deUu9V1qtELXVnNWGHRH8MhVa2IK5qs+OZrzdy8dkzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ata/dwc_ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index b480cde4465..0431d370716 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -39,7 +39,7 @@ static int dwc_ahci_of_to_plat(struct udevice *dev)
 	priv->base = map_physmem(dev_read_addr(dev), sizeof(void *),
 				 MAP_NOCACHE);
 
-	addr = devfdt_get_addr_index(dev, 1);
+	addr = dev_read_addr_index(dev, 1);
 	if (addr != FDT_ADDR_T_NONE) {
 		priv->wrapper_base = map_physmem(addr, sizeof(void *),
 						 MAP_NOCACHE);
-- 
2.51.0

