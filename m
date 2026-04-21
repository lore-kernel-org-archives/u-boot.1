Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33090F8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39BC839D5;
	Tue, 21 Apr 2026 14:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bRBPjrZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1953483A91; Tue, 21 Apr 2026 14:31:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F6B805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j76Rb5Aw+d+oQDjm+5iq5V76mc2P3j1GpHvoT+0LdS3E4ujTRXf06AIjjS1G1bL+w6sjOHgjj7MsPDetMLG6/RKCEfF4GP97w1CaGG5ES6c8AUktnlJClgb169LsFxxuwWgkDrVImNIxXyaJMYkmVyvtKngSBHSR2HK2qliRw0xREjuCT3knqPIO6A4LyAIti/Rc6p1gG1OhocBjIOkjHYnKwb5nvsIgZR8SYHzc5Nk0b/PsV5eG8scVBn5R3dMr0RWvzufjLOWylH2XnNVZ5zia0D0IEPcIBAlDOoreT8FrVvnEQBn8QpR5XIFlVGw2Ms9oyhRWpWSzxbWUBnlhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9dEnnL7LNB76zsP/ixrOBbFb9AwUo/TnbyQM5e61Ig=;
 b=ZE7ZnlLCtWDrnlOK/yPY07vaL5vF6rz9h8fuMe45tJ65+XSUJ/wnRdl7xdwcZx0Gqkd5Gq4JS7XG9pxqdUElzkAl3fwriMIp3ltl3DdyOJuXuEZutliDUbW0YNM0r6RjE4U56MTP4Ki04k2KEH25LTSt16zJbfnRU98PRuoEwz36TzUxaH85ebvSS5Fe+bXB6iWsoDXQIKX1l84CPNEyJx+ZH8AC6g2z0ERiQghaEgsMUJcMasErJfYTrz/wuUhrgI0twepW6ppotlOhaYO9mjDYQ9uYI0enXSHySrgVVRazfqgvbZPsSwUUoCKI75hS7P8F3O28gHQ4eApc1pD3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9dEnnL7LNB76zsP/ixrOBbFb9AwUo/TnbyQM5e61Ig=;
 b=bRBPjrZzhVKAUTHRw4UvfoH+3zjq6zR+TxUmHk4YGyvJz8/qE6PjwrkDAYJb6D97F0fHbTmDwYf+EKVDUMNjIB7miW4SNbeFcVoCtXibWMq1OyY0CPYAiNEq+UP/gGXBY468bWGnscP+XAy4Vi4YfOvrCQ9miWwLZJMwNDaOaVjRduMiih7dotiDrc72uqffbmsIew6+dPQUOmfRa6LQMnLHyqyibLoL5w5XTh2oOahwMC4mN6oSrYf+z04qUIdN4yomZEuIEDB0FgfLShLa2cDRdB3OEfjwdpLDdXQLE4gsYbEqzPz/aaIofjY43cF5CyUAZfArmsQ2dDMFUz7hvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:31:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:31:21 +0000
Date: Tue, 21 Apr 2026 21:47:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marex@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Thomas Schaefer <thomas.schaefer@kontron.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 2/2] net: fsl_enetc: Add support for i.MX952
Message-ID: <aeeABQnCvsEFAgY6@nxa18884-linux.ap.freescale.net>
References: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
 <20260413-netc-v1-2-8670e5ce2d49@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-netc-v1-2-8670e5ce2d49@nxp.com>
X-ClientProxiedBy: MAXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6da249-8aad-4334-1cb5-08de9fa1e44c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BjXBDQNKv9ybQOiSzjQIfEv7J1TaoioG9Tz3yNFHWCf9X6zbXt4nCQV5Ied/O0iKTJC4YaPUHN9H1q2LQP7MdhdJQjurEng/XK+rh433BJQE5RBopiU9RwKqeuPEdM8AnMU/A+pHWVI0AKYo0GEJ2aPSvDC/rLP/5/cY9Ihac3dXGUElrgVvawLaloaeWVU+ajV5ccCIAJVodQpUrsQLCbXu0EjB98kSFnMzmPYPufdIfpUhl2jpZlPp3XrTYMqqQySLWcIFFno2ihSDIOpq4EFozYVOu/yhtA0HmbfQ3pjXGtH3BjKS6feqwPopMJwA7Q4lrbtcVHXxMxGtJ8MPHYeSxxr2ZDOwYx3Ozvg4Xue5Hm4yTsln5VFSA0ZbqMVc/mubNnMkmtnBBrYLUu939OMo7B69XGAUYoisHbqXqs5nvSM+zr+sxF2GYelxqWk8ywYq7qkCtumdomFyp9qbtLhxRsUKHXzK8G8i5P90Xr5WtPOC50csn9fHN+KFIbp30RVYrHLH1xNK1YzG/8Q6pclFmEFTurNC/HefESCfl3Dbj/j+fjgF+GKcqOkZTyRFyBn3zcCWceHDhLnvwU7NT48YDq4LgLYvFSrlqnmO1kmq/EhQNbFL2CbSG+T7E4IsS2gzlTX6A1C+yu5KAXEKLzHTPODrltHphSyWsCkWUR6nMCko+eUB3xWhqtPG+t7ea1VLLlW3lOAnH4OC+CfmDlqesonVzCtEhN0Yo8hf1+X49e1acNUGRUnOrzTAfVZ8KCjWMHlTgPBQxUCeYBTrenn4M2dQj8WXjMse7hxdpB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VrtoKi8A29X0+ihosRaaqNlGJVhClW1ZLGdjgriizDWrJn/ONhvkkuyEOFoA?=
 =?us-ascii?Q?h58HscL3Sbm45+KKA1PnKrcVJWcIn1cGchue2JMeGQIdhu/4EFog6wUqfeTv?=
 =?us-ascii?Q?38HjJ8DuA2tHz0TpwlERi4k4CyqxgMECYAFJFojrharIKZI2ECf81hopMxrw?=
 =?us-ascii?Q?xJu1OBn9G+2lIIxgVFoBfyYHX6g0uIa30st+k9FoRHs0/7WckGwQJwN2mXFl?=
 =?us-ascii?Q?hXAIkGLSkdgzz45YyUE1od1GJrVmW9AKbqRpm4It9urEao9qvZeT5cWztDdB?=
 =?us-ascii?Q?g9+pXKpFE5cH95lkiDdJ1tvn1Q4SGD+Zpra08Kk8/QFVCvUP26XSLL37aBaO?=
 =?us-ascii?Q?1/VD9nmLMm6fFi+vcuMkytw/GSL1cAgj0rAWgYYCK1QG5k/QIJW4GucfkOgm?=
 =?us-ascii?Q?z96/2QbCP6eyBx4Q66Sg4AQYdp0xBydVeLISUS0o0mNZ9iSdw4Nwzpk3Lf6i?=
 =?us-ascii?Q?EPn5otx+LPgGZhVCX1DV+6/R1CnP8HoVeqXedESZbP/F+N+yylEH4elAuqqF?=
 =?us-ascii?Q?auErqByFmfHXPSMwuwjt/wiqC/sQcQkZtiJKYzAf+RuZq0Xiu3nyQ9BPP7xM?=
 =?us-ascii?Q?BRUXiqarGn+cU5FZSZyYGpqRG9PW9I77KDDhT/9raHeeEHziFE1lIaHesLzC?=
 =?us-ascii?Q?2/9xwepCLtvbqziqNfOw2AZH3MpTHkt7QKFjto8Q+iO+bWqYCc2NFniEbv+P?=
 =?us-ascii?Q?3ZMgu11OdnO3DTSmmjPiiBWRUYyrFKZRVSCoSOhE4VM+EzgFz+VtyAU2AxkE?=
 =?us-ascii?Q?n4Y86vuvDuPpCPB6qTA125b3xHeTMKjD/3G7PWsKw4T9G9yv89B2RDNgzbkE?=
 =?us-ascii?Q?GRvbx0uwGuYv8pEze0MAPnSmmJwNudsWhz8L0lsWGwynEWOrByQFIEnmA/hr?=
 =?us-ascii?Q?g0eoSm3bqBSrkFNCAfWjQK4K3esGLhG2KS51pgbbUzyN+UjWzmaXTlqdNCWB?=
 =?us-ascii?Q?MFsrGQ8XgD5r1HH+Y3eyTpPcFsB1D153l4LmUD6H7DO9LTQPnM1pR45wD1/1?=
 =?us-ascii?Q?xRZsZt7RrVB+67A/4ZWxWAl52UYgGu+jL66wFJh81OAYt7kAK3uHvQ63g2lL?=
 =?us-ascii?Q?n2BLekkhpKkgxt4N0lFz+cSCqqun9ptHwMO2vVceJndsciFMu4UQx7HImQ8S?=
 =?us-ascii?Q?uTExgHMjAuiaRmQNW8PBG0JMRRgo1RXp7J2PxhnXUjkoNdTd6s7LkTRCoK3J?=
 =?us-ascii?Q?L8A2cjFyrXgKtSEpeyRm3gqrfIhcdYQVCTaFWpIdQOQLU366lDit0i0XAzsU?=
 =?us-ascii?Q?vf/Gl7r/7pSbPEN7hR/NWE2OCWaUp2Eg704ZHDW9ACGZc6EImllHvBol/uEB?=
 =?us-ascii?Q?YWFewl2DC8HWi5ZkbRUDK7AYCMy37qs44+ud3lZnRQSiWkCg0w9MY7SMS2HH?=
 =?us-ascii?Q?hsst5ZHcpdxsPDhYvMtuhEQaYAxSUNjqSVZ3C0r77FioBipIL6QmkyYoBhOe?=
 =?us-ascii?Q?+JOw1b2DHFZ9lO5bJbdC18RQVk3SRz8keotw/aFSDUBccb7EQ7+xDBcjnUmV?=
 =?us-ascii?Q?+gIVn5pINOj17S6iyLcE7NAbR6I5qOL737h4cMHk53/XH6mpaqrliTx0rn5p?=
 =?us-ascii?Q?7VT5rvTrulb3wKpEzjTHUtKdohAB+xgvLBbjCOfjLDFHrNdXBJpXJSTwnfbK?=
 =?us-ascii?Q?cu5yKaN+M+NmPfcJPEWJwS/rPtBR9h/4iFsp26FfqOCeuK7/fWNCKozukJNS?=
 =?us-ascii?Q?/e+eYBNL+ejnZQ/QcMM6Yv57Z7zZFbwat404vRc5xdrynEEX5gzHdCJ8/lTQ?=
 =?us-ascii?Q?rqM1XVW7oA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6da249-8aad-4334-1cb5-08de9fa1e44c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:31:21.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JPjQA7DVoYGGbnXIHy1nZKRW8EAkACbhCYg8jv9hElsSo+PS6+tfQELNJq/UgW/g/m0Pm9IOdaRfN+4CTu1yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
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

On Mon, Apr 13, 2026 at 04:15:40PM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>Extend ENETC driver to support i.MX952 platform where 2 ENETC
>controllers are located on different PCIe buses.
>
>Key changes:
>- Add enetc_dev_id_imx() to derive device ID from device tree "reg"
>  property for i.MX952, mapping bus_devfn values 0x0 and 0x100 to device
>  IDs 0 and 1 respectively
>- Implement imx952_netcmix_init() to configure MII protocol and PCS
>  settings based on PHY mode parsed from device tree
>- Add i.MX952 to FSL_ENETC_NETC_BLK_CTRL Kconfig dependencies
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> drivers/net/Kconfig                   |  4 +-
> drivers/net/fsl_enetc.c               | 28 +++++++++++++-
> drivers/net/fsl_enetc_netc_blk_ctrl.c | 72 +++++++++++++++++++++++++++++++++++
> 3 files changed, 101 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>index ed07e286676..4da10ed1289 100644
>--- a/drivers/net/Kconfig
>+++ b/drivers/net/Kconfig
>@@ -1018,8 +1018,8 @@ config FSL_ENETC
> config FSL_ENETC_NETC_BLK_CTRL
> 	bool "NXP ENETC NETC blocks control driver"
> 	depends on FSL_ENETC
>-	depends on IMX95 || IMX94
>-	default y if IMX95 || IMX94
>+	depends on IMX95 || IMX94 || IMX952
>+	default y if IMX95 || IMX94 || IMX952
> 	help
> 	  This driver configures Integrated Endpoint Register Block (IERB) and
> 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
>diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
>index 766aea035d3..a1569b9d989 100644
>--- a/drivers/net/fsl_enetc.c
>+++ b/drivers/net/fsl_enetc.c
>@@ -67,10 +67,36 @@ static int enetc_is_ls1028a(struct udevice *dev)
> 	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
> }
> 
>+static int enetc_dev_id_imx(struct udevice *dev)
>+{
>+	if (IS_ENABLED(CONFIG_IMX952)) {
>+		int bus_devfn;
>+		u32 reg[5];
>+		int error;
>+
>+		error = ofnode_read_u32_array(dev_ofnode(dev), "reg", reg, ARRAY_SIZE(reg));

nit: use dev_read_u32_array. with this addressed, you could add:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>+		if (error)
>+			return error;
>+
