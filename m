Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D6BC5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 08:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D34740620;
	Tue, 25 Aug 2026 08:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_ITc1z0Ci42; Tue, 25 Aug 2026 08:39:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787647169;
	bh=R4ZrdBde51auMwCElLgTEAyG7igSADK6TIMRtLgY130=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mAzDfOYWdETMgfEc1qCcM7FN+78RQFDMdcGsbnrYhBn02J7Wa5eG/pTY0XszeOkIU
	 h0a/agvEgt2Q5QMnQgCZmi7HZ3bUTxlyxULToM9avdNdiTNmMJS4DJ7XKaR3RkdXYA
	 mgDkZ/rmhwVpDWlPi5+TK7NAlzxTt8Rp1OMg589cDdogJc92Vfg8UmdOMWo/KaKJcc
	 pWoH6ujznwsHif7tavJ9UXEMBYcmlut+BkQedn8o+e3QGYpKfBpr+aXDQpSp3fSLRq
	 2iOsin3g9FCPgvtZnEbsLyQAN3HhOccsMuenJelw8lpUURHubuMQNLioAyY4N0Ovc6
	 A5wklc61EWyqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C5FF405F6;
	Tue, 25 Aug 2026 08:39:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14690118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE96140068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ak23R4HRuvVk for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 08:39:27 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=i83rkJuo
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12FF440064
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q19h2cPVbWtCUh/+21vyklqaBVfwD9coxbb+QnVO6/LgcP8YBbNCxNh9/R4kdLTfnIlaLDcaaVz4aq8VZe0f7Tx5PPC5QNX0oy5EPvKm2W+7SgveeBGuldWYvQ5p72HfAFxxHMDOQll3nihFR+onr44CaGQZvfZ5fBdZ5rZCHzSsbtoxDlrUcmkFMRSnHTjL0dx9C2Fbpg8qtuwoUj6EH8k8l3pHzCSVOdFU15vvfMTnobkgCmdIN04BrgVQrzfY8n3iH+Iabhy5QSkCRyY7eF0pXkDChU6rfxl4tFAlC2EB8fZnuXSQ7Zko29gvwJshGvUO3Blitr5tq6qcSnATmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4ZrdBde51auMwCElLgTEAyG7igSADK6TIMRtLgY130=;
 b=bbNSZNxM9e4cm9VIEgElv0xA1flHa8ZS+l/h7mkaWQvlcwCQ9UlnLxAUD44eiIJFM5mmYDXYG00v5Ljjpptr1Pq24piM1a0SDpRri/vl7fOE5usN6cECqW3FsJKwSlr43ZwQOTO2AaxXzscNqat8H4O9H5qoDeLam4va/BYpvMM306cKIpwVuQimuSWLKWkGPXVV98+6cMiwQgllmPb/hNQkf5i0ojtastjOXOQHkJF4Zo8G8QuZXqvTRLxHImNxHnLwX6MRiyabDiRTocUx4Y4W0HeJmsAo+vaEECHR59OR5I8MFqPY7Hzssf31tVnzUzInutEMAVHEHZpi1paV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4ZrdBde51auMwCElLgTEAyG7igSADK6TIMRtLgY130=;
 b=i83rkJuoJAt30PQrh9SGBbXNr/p/WGYm/7eutxOWme0+0lLzk7gB7NGyxXJxJJhwhdX8s77EHmPIm44RiD5NiPO7ApbvKoavIln2eOHuUZMDIEX5s//02kqtnaCBsgIU0mUgWjNZd1S+oCcXQR2dGvjF08pigLdCMAhdiyAXWe3fzJvkOVmjMOGplgL8b2dmk4CyX0HQC+6BCF83+ftJGmCoS+rgCbRIlYBWmUz2Z++a+JTZjY0VB32EUl8kTcbuR0YbRL49hNV2//1G1ujPubU71JDVXij29ihRSjV6ngWrWNBx3xYw3/W8fOy2Tgs+++9KYSU4h3cjTzYfvHIZdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:39:19 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:39:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@nabladev.com>
Subject: [PATCH] net: fsl_enetc: fix all interfaces getting named enetc-0 on
 LS1028A
Date: Tue, 25 Aug 2026 11:39:12 +0300
Message-Id: <20260825083912.282514-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::25) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0a66f3-f435-4c0d-65c2-08df02845ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|23010399003|366016|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: OO324Prym0M2wjLZhuWoBU7d0Rfn/mKc+kF/Xca16l+525eMBzlxo2GTaCG8yp05ATDV7XvHPlukrqvfwL4PAfRJbxfBUxSI5i23tVPh9kXCYk80YL0O8NqXZQz8GLfaBb3glz+4Pz/eJGVyd5bZrdHQMsHzpkyBHVe2rw/kZhen/OVSr8ldfzm/FG6V42Gcmp1Qxvl0xZBVhs0cklHF8gDmYyWP/6FvQFbVeMze3C2YA6w6EDCR3jRuB3JPOCOft3fZ4HxVX8oCWZ9/eC+xBs4CwblzNKEwzcG4aJie6oiG+KyeprXBQ94NZDmULxJOQj/WGl7PmgKhYvYJGVjH9eDjlOy7x38vpbll2/wN9dAULjSCMSc3TDCvq59nlNPCPiDtURx0c3N8w1A7xdNYL9MWund403bA5sCaiBREPUT+hPKbu1lr9tEqpjKJaFgCl4++YehRKJKj3wPUQvyftHTzbnB6gtq3kO4CPLXLtj/skSWV061oWCNy7aVLDHmVYqtiiLA41o+gG5Mw+ZI9cHhUoqy0Rq4SL3GOhaCKMJ5EYm7mGe1auUjFnCNRJKCz9YEy0Az6MGjDPXvID1N426KZFgjpikFXsu7B0AMCXp8ORPB9daJZrUaSYaaVlwCDymg7B+HwLAnmIWzcjh2hLCUTfUxdA5tkwF+TTbB+o/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c55emYRtOMhT3gfzGUhckfLKSh9xB/fhaQlGD4ndCf6wnJMfarDw8pASOITq?=
 =?us-ascii?Q?npc4Y4xUDGhwTIwzEXgmPmAFD+y+8Yn/xvFjgURh871eABgFcoe+U4LM83JQ?=
 =?us-ascii?Q?FaNGQEydDH9gEgR/x6yDK1SRxHw1kn6ui6aud1GgILymu5JInvG/VyNqeRh8?=
 =?us-ascii?Q?EFnI2AXat/wuFOZezwF1/F0qFV6M5esnXQyHu7kGlWVBnLh3TNckJlnKJNg5?=
 =?us-ascii?Q?rHT06+9u0MLFZuDEyqnWe/kVYzJrtpZlf9aPcJs09XgrC6MppGpYNNiruY/4?=
 =?us-ascii?Q?73G6vHdVH7BoVYEehOpMHjrjxPi8FJd07+Kj3/CrkM3R6dMD/b7igZWCitFD?=
 =?us-ascii?Q?Qggg63kmv66x16xp4kXbxvloQgRfJhj2zqojHzl3lMgqeZ5L6iB2vPvrb4xo?=
 =?us-ascii?Q?gQ0pVOKe3h3VHnYUG2vmGIRBJx5kU7774vYcX8WTKHKOB2Okq6iINy2FHhvh?=
 =?us-ascii?Q?61jTwIX/NJ57syCuWtAYEnfp1uTcMKdkFMfxJfLdbQPy6RvNyyvzXBFe8tIz?=
 =?us-ascii?Q?xiQLS9o9/xeChyvTcFJsleoTqt/gdaf9L/A8VsYZD93meyjDAHDApOYGMA5C?=
 =?us-ascii?Q?v5Dkl+53GCkpKE7IcvqowFzk24IXmxUqMdNdFeD+xbrNY/UdmtlSsfepCcSe?=
 =?us-ascii?Q?uZtQKaUF+fEF4jGp3CH7mhHKhYMhLRsufxIHx304EjFPQaXXa4TdHmD1jTbS?=
 =?us-ascii?Q?M3jeWaGC9oJXjcooZPu/SUQgpEPoWPs6+OWvoYEkwAhMJM76UKSb7n+cwRtR?=
 =?us-ascii?Q?RESjH9pAVDPKPXKXwcYm/nCw/MIESbTTgMcnj/WCxeC8IRcE/FJuZai9icZq?=
 =?us-ascii?Q?mwPqYriFIndNLNNuK3m84XZJSUS0EbouxttwB+5gG0JiKaW+Vv/pfonhzETL?=
 =?us-ascii?Q?WQYA4LkDW0H/l9PQo+mTd6gOkZjRw3gZX5oIyxu3bgPWoyLYQKw+vom65/j+?=
 =?us-ascii?Q?LNr230vTshQb7+HshibSZsULC8BmZeAbzX3UKXM7jArQF6Z2UYzg0RoFeVIS?=
 =?us-ascii?Q?h72q2bx8fvW1Vc3nM2bW3tY371W0hbP+q63qyNWU6bv0c75A6fl+3Jhgp7Nz?=
 =?us-ascii?Q?8MbEiKPBtn2suldYVLdmL2hypxj7D4wGjWoy6rQueNB5+c/5444PFMq9WfvT?=
 =?us-ascii?Q?/EBP3hERiCs0p7+RQV/2KbigyJZVeSO3ctslieAdy/Z/98zaogFVNgpvivkT?=
 =?us-ascii?Q?SpIMlq2I1PsEzxEQP+3mG0uqoS57bC83VD/UXKhYJcRLblVPLHx0U+GlTpfO?=
 =?us-ascii?Q?Ml29XIsz+Ss0wB5JpeBEy8nEa8gKehyPk6TAc8aYF2RCO83tRGY1l/2mj553?=
 =?us-ascii?Q?LXoBNeaJPnF3nh9H5tFqSJiaENJPFqp86DgOmSLykH4itgISF7fIld2AMklo?=
 =?us-ascii?Q?2zMHX+wsc4oj9mwMyzJHRWaMMZayy4tdGcqGo5UKto3KKPluYaw3KVzYCrOu?=
 =?us-ascii?Q?ZuH+2R03MXLLMLwkSzWdBtTQ+RV/A4AYki97D21gXthfD+ZmMU1DJopYItgA?=
 =?us-ascii?Q?P7aHulQoAclOdUwnm0rO1A9G2O1VEPojPNCPBs+MGBiGBoqEXWgSRUqTcc0i?=
 =?us-ascii?Q?N+fG/bJ65sKdNzIr8Fg4cGryMj+8swtS/wgjMl9ilHIYtu3BXk3tSLYmIeVM?=
 =?us-ascii?Q?WYjAoPymM7A5Q4MxoLt7hyfPh87H+6dzNgrLXeAjlafk5t2raHvI8KHascjt?=
 =?us-ascii?Q?dg1zlJyQ1jMmnySndTmprTfZ8jP8XoRJv4iyLDqDeeaLFnyp6T/ckjOGZh3t?=
 =?us-ascii?Q?cY8jgqz81vPPEJxYbcBBjWkSBiejiL0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0a66f3-f435-4c0d-65c2-08df02845ace
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:39:19.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8h3SwIqy4hr2V7Ce+d+BYMOe9icKBuVpdvbRZayBf5BCwDd41qlp9P05EiJzDIG/cfDArVYHYRpzEGERWUuIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

enetc_bind() names each interface by calling enetc_dev_id(), which for
LS1028A is supposed to return PCI_FUNC(pci_get_devfn(dev)) - the PCI
function number of each port, giving "enetc-0", "enetc-1", "enetc-2"
(and "enetc-6", if enabled).

The guard that selects this path is enetc_is_ls1028a(), which checks
pplat->vendor == PCI_VENDOR_ID_FREESCALE.  However, pplat->vendor is
not yet populated when enetc_bind() runs. It was thought this extra
check would not introduce a functional change, but it did.

The bind sequence in device_bind() calls uclass_bind_device() first,
which invokes pci_uclass_child_post_bind().  That callback tries to
parse the vendor ID from a "pciVVVV,DDDD"-format compatible string via
ofnode_read_pci_vendev(), but the LS1028A ENETC DT nodes carry
"fsl,enetc", not a PCI compatible - so pplat->vendor stays 0.

The actual PCI config-space read that sets pplat->vendor = 0x1957
happens only after device_bind() returns, when the PCI bus enumerator
processes the scanned BDF.  By that point enetc_bind() has already run
and named all three ports "enetc-0".

pci_get_devfn() is not affected by this ordering problem: it reads the
"reg" property of the DT node directly via ofnode_read_pci_addr(), and
is called by the same pci_uclass_child_post_bind() to populate
pplat->devfn before enetc_bind() is invoked.

Remove the enetc_is_ls1028a() guard from enetc_dev_id() and call
pci_get_devfn() unconditionally for the LS1028A path.  This is safe
because enetc_dev_id() is only reached from the ofnode_valid() branch
of enetc_bind(), and the iMX95 case is already handled above by
enetc_dev_id_imx() (which also reads the "reg" property directly).

Fixes: 4eb5ef73a956 ("net: fsl_enetc: Introduce enetc_dev_id()")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/fsl_enetc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index f393af40e275..0bff1cca4a6e 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -105,10 +105,8 @@ static int enetc_dev_id(struct udevice *dev)
 {
 	if (enetc_is_imx95(dev))
 		return enetc_dev_id_imx(dev);
-	if (enetc_is_ls1028a(dev))
-		return PCI_FUNC(pci_get_devfn(dev));
 
-	return 0;
+	return PCI_FUNC(pci_get_devfn(dev));
 }
 
 static void enetc_inval_rxbd(struct udevice *dev)
-- 
2.34.1

