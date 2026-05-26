Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9E0CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D4A846CA;
	Tue, 26 May 2026 08:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RvJdf8+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEA0846CA; Tue, 26 May 2026 08:52:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275BD83EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr1kMKAJj/69kYvTbN53/QdCs5cY8FXhir+d0h4v7/apT32LH61kaYvIgYhEWBdyxHDeoYmOUorhvU947RZrD/bYuEWeBnSzQfNxJpg17tSbhHmYbUKwR1vKTYV1b4d6LNzDr06fSrnClYCEs0xQr5+bmU1L22wpEdSaGKOqMM3XHcQ1E0cJwtBtS26YvWoWPGbaDwmPwxxTSDeaUTsbmhgBxOd51VV/ZYRFpSf/ucFs4mQEpI4E1UJ2gU2Zhcre1v0MgQt7hmnPAV9rlbY15xaY4TnxTAlKIKFl5mgHzeBM3URLFCgWfZvC8SRsGVf/jFj9DIRlebt7TYVmYJf+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fajrDTXEK5mdhI6Qw7XDcPkzHVT9UfrPBwYmVayn6yQ=;
 b=RQzd62y7ItpSMxq4YtJzxt2CTSK7imnWJOkS09vi9rH2YNiOHNneBaPCL+IEIkqbhe0PAd/va1QUIND1jhYw3nS1v+0GJLP9Ay/k7/fJXs/K8/rF1t1/Y37PZxxGkvZSx/4r7Y1IMNuU9PQnV0f0R9VRlZgpXmqgA+2E9TL0OIxkPV0cfKc2iLM2ml9rocLlgCD1A8asnunYo4tYOHSZuj6SFSCRU1+5nMfi9HjqjCn7P6XfLFYNkOnD6U9dAb6hMDESbfbxGBNAd/auIz9KezrP1n0lfMkh4t18WHGYuJo3sN90yDDuUfL2Cw5d3eXiUlo1jPHVvpF4F0gIWtaz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fajrDTXEK5mdhI6Qw7XDcPkzHVT9UfrPBwYmVayn6yQ=;
 b=RvJdf8+0B5VJQMj3Q6vfZnAS7arhXvFe2fGr+pp+E71C7JhN15iSWafBAsJCSm8OuLtBhtstg5YfMND/Sja4aN6SzwHsE06H4iJHiFewhZ0uPuT2Bl5LyHKW0k58SXyZF1zeyXWBwb5hltDBu9Zf2flY3XdKzuPPjvxIUP206HQjgCHu/Xhj/Bes6fvWrGCvXE9vaGqrGQ1UvBgXQeFZLK42I8vqD+jiPz7z2IxMUk1EnqZgpTCDHSaoqcdfUIn8ULphMhCtZuQXur2sFAv8F4mGoZCmppFdvEUSzDEHGr2leNphydrQ+xGrWrnqOe4nR14k1Y7WBI0ihMSfZcv9tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:52:33 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 16:09:11 +0800
Subject: [PATCH 3/5] pci: dw_mvebu: Use dev_read_addr_x APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-pci-v1-3-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf432a1-1a3a-4a52-cd2e-08debaf35d12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7eRKv3xj0Q8oQvDN6krO9aP5zzAbuT9HXnU3V7Ww6lLntrNbkPBdpzLOmgjas288B49aa/YWwjkavH5yCc7VQ1ZNLYV2cnMZMRqao7+tBh8PQhR1S65KQ+BSp5smYvmiraFEksST4HbWsRBzo1IH7ZliGfuQQMIWon9cs2obQxZvlkv5G1biIufqNEG1o1LYO7aQIi/h/Fh4kBCJh0vXpNuyocOwrnimypCuh6T3YV3mFZomo1G6a8HUiaHShMaLYmQ/Xc7+g7dpJVYKHcgS+VvVN/FLOrnbINn2kJ2WdFu2OJnm3FdZg4ya6gAQcSofzN6HVPUSinKJGFEOJUK6I8YTIEYfgdBTkE+1FfN87HcXjRgRrZ0gQusbx8oSYLq78z+swIDqBI/1ldXRkraB1boIk7Im4Y9yJjSs0Znkzg9pYnh/+GozOssoRmX619FwDhulO9IZ7rM1vBZ7TehFdrPdflOAaNCmlL29d1tu94BNUYgTtvF8vxqQbqOki+LM6CeheVYKF7Kt51TLQx1djWwKqn673zafUvd/4ZguAd/3nq/TBReAB42qmSyTfGAs539M8j3udoENg6h+mKYx4s59aFdX2CV3b4rPm4H6YPDnfj31VmYfzZwtAkyrzIsjCG1TBypm7mYQDpT8IDAen8KYUqXKJ/EQHdFYdIeRleld9c/wRs0yQfpT7Rs1jCeKwFI45XUiB4kdx/PD6jYl3wo+2c9LRXMeviNWxFFR1dXdrFHQZatUwYQ641EuNhL9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3F0eWU3SkdPUmhRc0RQUVNHMGQvU1JvZXN2WVRXMndWeGJKa2Y0RnI5aUhS?=
 =?utf-8?B?SWRkYmNOUkpwdTBuUXpib1VTbHBEL0U5OFhuSUtMU3dQMmNOd2R0RFJReWlo?=
 =?utf-8?B?K3o0ZGlCSTB3Tk1zMzZpZkozUUJJaTZFZEdHcTF3QlU0R29DcFcxVUVzWDFO?=
 =?utf-8?B?T0xlc011M2RTTC80czlHTEZYU2c0U3dDMVczelpRL3JoNXdnNDlzd2pRekVL?=
 =?utf-8?B?aXpFM2o5anlFY05IQ2ZjU0NOMFBJYlFFZ0ZlT1p1STJhOWhkSFNyN09ybFFB?=
 =?utf-8?B?MTltTTNjVVRwUnJHRHFLQmtUR3dkOFN6cHZQMVVHbnBOQkozYnRzNlgrR3ND?=
 =?utf-8?B?aitOT24vT09nUVRLS3BwcE5Kc1l1blBpSkNpTU5pYndWMWp2M3ZSUmFRNW9j?=
 =?utf-8?B?dk15VnZtUHFrWXlTc1F3K1FudGRMYUNkWmRsS2FqbU9BVms3WnZVY2dqMWtI?=
 =?utf-8?B?V1ByVndrYkthT2FEY2VwR2F0UU9pb0RjV3l3TmdaLzVmVGtKWnFQbVNoK05F?=
 =?utf-8?B?YjNyN0J1TnpWUGI4K2JWcllBeEdjZ09Gcmtod0lORDlydUd0eXBLcXlYblhh?=
 =?utf-8?B?cS80THVnRlRCUDY4TnRWbkM3QTdqazRWVVJzKzFsVzY5RHpjNm9tdGFtM256?=
 =?utf-8?B?UUtEUHZDS012b0kwSEtYdDJjRzJEaXN6em1CUlh4dTBUOFFZeTZFUnkxKzJa?=
 =?utf-8?B?NGRFdVY0ek1TbVN0NXNzZVNBSW5ZQXdwZW9UUzRmRnFGVnI2MmJ3SzJ2cDBw?=
 =?utf-8?B?WTNLZVlRc3BCL3FPdlhab2N5RHlEOUhOQnYyekhGc0J1a1l5ejFhcDlybWIz?=
 =?utf-8?B?MVhkNDlmclRrbVlKZ0Z5ODV1QlJzSkRMV1FLYjBVYk1rV01SZThRSmJnL1ZO?=
 =?utf-8?B?MUJNak4weURGTHVOQS9TcXJVWmpDb3hpS0h1UW5mN3VmOEJCM3M2STJQakcy?=
 =?utf-8?B?YjJ3Y0NoejNzUnJKSGRwSUh1VHQ2clVlQys4bytyL1RTZjFMT1lLcWl4cFB0?=
 =?utf-8?B?MHZQMC94VDFlWERFN3U0TTVIdG5PY0ZTRG9ubEVyMjhjcHF3V1hHcEpadW94?=
 =?utf-8?B?bE9wclZ1ZHB0TEhqYkNVYm5jYU51em1BMitweVVKWmRpcEZuMzg1elJ0TUtI?=
 =?utf-8?B?VGZFRC9yWFV4bWJMSkF1QU1samQ5Tk1jRHdRVXdCR3QzOVgyOGlYT3ZSRmpE?=
 =?utf-8?B?MjJwVHczdGsrL2l3bVZQUXkrWm5RNUtRd2ljcEpBQ0gwdUNqeWxTSjNhV28w?=
 =?utf-8?B?bDF3M1ZqUXEzNHliZ1hqZWlmdFBQUFMzRTFzVWpyS2RzL1h3NlhuZzY0RS9W?=
 =?utf-8?B?SDBqU2VGUW1MSjRQa2V4UXNBVEt6cTkxdElWRnl5elJVSldhZEY0eURpUnRl?=
 =?utf-8?B?R3V2NjV6SmcwVDk0VE9XbTJReXQ1ZWFEdmpoYks3WDlDOGFCWm4rNmtlS1JF?=
 =?utf-8?B?TTAvNmhGbDh4QnRQMmp6NHNRZHRNbHdka2VZcVM2Ni9EL3dmTDRMeTllWmpv?=
 =?utf-8?B?ZzZub3dod1NIK2NTRExCQlExMG0yYzlEOGw2QURWbDF1dlJUMlZaVG1IRDVU?=
 =?utf-8?B?V1dRa0c1dG1rV29wRDMyL0UxOEVPMGlzQjMwdVJveTI4TXdKVFpETG5oc1d4?=
 =?utf-8?B?RmpYNVh1UEdRRGF5TTUxTWV4SUc0Tmc4NTl0bXpSVE1QT1BTU3ZGNGI3UUd1?=
 =?utf-8?B?VEl1Y3ZzTmJaYkNrR0JQWVRicXFqSlo3dHlGV0YxckJEQm5wVnRaSWFQNVlO?=
 =?utf-8?B?Nkk4dWdHVDNCRmFCVGcvSnpDN1hPQWxGT1pDeTdxUlNJWXBZSUIyckpOZWxh?=
 =?utf-8?B?Nml6SzhhRXZ1QlJxb0VNTlhGSzd6YU8wNFZkMXJaZFlBUVphM3JMYUhKbW1s?=
 =?utf-8?B?OUtaMGE1SXB2T2NBeUNCcGlsQzkxQnlOem01R0xSVW93QWlzNDNaNGdTTW56?=
 =?utf-8?B?UjBDYnY1OG0xUzVUM3FjVW1IUzdYckNUdnl5ekJHTmdiOWZwd2JNSmp2ajd4?=
 =?utf-8?B?SVVGNU1SSHkwVDJhU1Jra2FOUXJDQzA2U3gxTGh1a1E0RkhpazkrTTFqMlBB?=
 =?utf-8?B?QWtFbFh3RllRWEtGY2VqVElXVFNDNXNTRTU3WndzZ1RzN2hoa3BhSTBsMWM2?=
 =?utf-8?B?TkU3MzM1SzdoanpZMnQwRW1yRy9XbDM5RXVSL29OZlpZekhNUFZzQTVVT21J?=
 =?utf-8?B?c0ZleDVlcEp4Y2xKSklJSFVGbFlzd2dtdFZRWEN0Q3N1dnBVS25uNE9idWRn?=
 =?utf-8?B?STh3dUgrU2tpaG9IbmlRZEU3OU41ZHh6dVh1cHF6cFBidFQ0dkozNmgrV2hJ?=
 =?utf-8?B?czdnUmRZMEZ0ZUF5clNkOElveVZ2Ly9mYkloa0tObVZRdk82MVp2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf432a1-1a3a-4a52-cd2e-08debaf35d12
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:33.5305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxGuh3AsLb0IRE+0O95NsiR6go0PM4/I43sobzRy/joA+hG/N4SzoKQRzs0Bkyjj+fQrmvlGf8/5V/iOIpsSaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
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

Use dev_read_addr_x APIs which support both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pcie_dw_mvebu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie_dw_mvebu.c b/drivers/pci/pcie_dw_mvebu.c
index 43b919175c9..5a177478afc 100644
--- a/drivers/pci/pcie_dw_mvebu.c
+++ b/drivers/pci/pcie_dw_mvebu.c
@@ -565,13 +565,12 @@ static int pcie_dw_mvebu_of_to_plat(struct udevice *dev)
 	struct pcie_dw_mvebu *pcie = dev_get_priv(dev);
 
 	/* Get the controller base address */
-	pcie->ctrl_base = devfdt_get_addr_index_ptr(dev, 0);
+	pcie->ctrl_base = dev_read_addr_index_ptr(dev, 0);
 	if (!pcie->ctrl_base)
 		return -EINVAL;
 
 	/* Get the config space base address and size */
-	pcie->cfg_base = devfdt_get_addr_size_index_ptr(dev, 1,
-							&pcie->cfg_size);
+	pcie->cfg_base = dev_read_addr_size_index_ptr(dev, 1, &pcie->cfg_size);
 	if (!pcie->cfg_base)
 		return -EINVAL;
 

-- 
2.51.0

