Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE1FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216418404D;
	Tue, 10 Mar 2026 14:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xw7nJBFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F4E83F9B; Tue, 10 Mar 2026 10:14:01 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76EB83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoXJZgj1LRcyMltSgMKhOr/NIO5GMZzewiP7eJF+bYM0qANrXJy7fb+AIsbWRydB5DxMqCU0hsLRa/ukBdoRLpTeVhUSNZoNpeRUp/l2RjfzJlyAR91liQNrXkfxEgM1bG+wPNLiz1tl0pBbLLt7tUBmLljsFHn+7VNVj9krLYOVUGjReJvLbOAmlajXwhYxaYVSS2WURhI9vAfvZ+YBtyu2yaXr3OAoDoHsaeGcejlfdWO18/vYGsa2HBeh2opyHzLESmtHvRT9eB6GSZc2PJxY9s/+/0E8rpOmFM2r0hkNeDcYYHcaWvF/4JwAlPoKPYIlbtUh7bFGT6nEmTJANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxMKpRa0rPPACjG9N5PYcXv3SvhCRFqitjQJ4qJHE9Q=;
 b=y83h+PO4RVZpqfEucZ51fefN8mRaQRyZ0KVtR8BZbXU4bOQ2mW+DB0p8jCVNl1diZa8sUw/oIXghnE7w11Ke2YC3Yz7Tqi9KZKSGndIPT2gCI5dIXC19oQciE7y8psye70fYJOAhvdisijs9MMT56qYiPs5ljVo/H1uWbemqNlMGWEFZslpLcCyBaQJ8zKar21aKH8YXBvA9hhfuVu8Ni31DoSvhGzJcguZ+y9XflNZmUF3XZkH8k5uk8cogYb7KEy9yRUeke0YMCZ4aSIdjo253Klbqy3/szqJM9IeBDRxl4DMP2bELvIi2c9zegoffwzEWxXKwAJcwXbaJZ7bwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMKpRa0rPPACjG9N5PYcXv3SvhCRFqitjQJ4qJHE9Q=;
 b=xw7nJBFX37ElgSZTn6d91DLCjoVmZKTi2dZSKa21cU0slQZ6i5PUM1mju3Ewd4oIr+/lYbkOS/magfpATkQ1YRd5JlCBX+dp8v0iA0pubph/p3ITQ84jpdqicDZFi0zaGJCyPh90Ib/2J70tZ8t06Kk5yPNxb1fh8kqTyRdWAQA3MyO+Gkk2xMD7l7g/03Wh7BF4JJRKv1Jtg37Nxqfu9EzAbqsXX6x2xHN0FXfSRSZNL8f+Lc1Lxm96tNHME+hOAZnLRLBvs7doDbduo+QcQ/AwkGQDTduWj560h9dxZ9Ez2eKKHN2JpjVBgKmzY0RWXclUPp78O/iip+1wfKjnow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:13:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:13:56 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:35 +0800
Subject: [PATCH v1 01/10] imx: Add helper to get watchdog base address from
 DT alias
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-1-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c4cd3b-1544-410b-4d04-08de7e855b2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: imZ2IWvBj0TxkXe37aBqF/E2X3RWwcLn/rdOESp32xtfJwn8qeZWuN9QFolMb0WztK7LWMYm4a4ipDpibtZsx3hqjdOzFaB77SWV0uJ7bcx7OGh65Ix+TmkcSkcpY6eW8y84sf3QyGHpzc38k3vrpzx2T7UKMq1QjcL+LaSrnEkfPfOU3GG0cFJZiWqsfq8lGeEd7ZmqC9lWFZ50Bsmase6tId0LACD5Gym75R6YlLvAL2YgH454/fOmcow1ThL6Mpe7YkyEcJNCpaXztPNijM71dEQ4xX/LBUBoyAYwNOjKl4hCn+seHlsJjUwKDmuv5PK1tmSBU1sUccUCs1uw1RHwI1WzGoatCv+xDHWBIXv/MPrGj8XGePAuhHXYFrtlSafgp1mAVFsMhMEhFXHkeWhQTpWD+SzhfMEUMxxtkzKtl14Fbkw85DlP/GC9TztJaORehHytzV3bFPvl6s/htr4sbaMUnMGVwrwPClEBiOaWqwK2Pr+amRbhOKla3yY90u7N1KpIjNbsNYQ2w7xBWtEsa1MZ4mTIjcpkdza9+q80ESyUn94/gUfX07ZbCaJMQAlqgHCJKafzXsIkU9xBsd4SPQABDxcf1EKckL9uRkKcgCifL2jBi8N/mpnHOJEkhDbuG+s1JDYIkSNygVa/qSOgp8d0kEZyLENgAO98B2vbg/RLEYisXsdcByZgZI2DoacMo9rm72ivWgIxEqHIVUrDG2m5jlXo9BAfXKLuhECbB05LEe8fOa4NN0reCB4M0xdyRKIkeszPdj8wZcm4FKATM6O8RWZ6wVCPwrFyU4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pvL28yNVB2TW1hK3ZnNzRYUzJIa0FLZ3ErLzk5QVRDODJuSzVMa1VjT3g0?=
 =?utf-8?B?YWY3N2ZJbmxBaDRLbStCMXJuY1lTcjhpQjVzaE9sdTdQMzFUZm9adFUrQXR0?=
 =?utf-8?B?ckt0bS80S0ZMcDFaOHdpZXdwQmp5blNWdUV2TmNqdmdiL2s0M2NXemdEWm5n?=
 =?utf-8?B?UVF3eVJWTkJraHlsSkRKUnF2WWlQdWpKS1JmZEVsQ1dlZGcrbGsrZDdwS0th?=
 =?utf-8?B?K2RiekRVdUNsVTA0WWtpdWtNRTNETnBYYWxwVXJmWjhmZUdWaW1lYmJqU2Zo?=
 =?utf-8?B?ZU1pZDRqYmdmaHVsTFFJeGdxQW1hR3dUM2FJQUVhb3c2dlk4T3RvNVc4SSto?=
 =?utf-8?B?bXdQVUp2c1ZFVW4wQkRyUzFQYm9xTHd5TFVUOXp5amtWK2NtQkkxUmFKUnNn?=
 =?utf-8?B?aXFwUHh4aWU0VDh2RTRrK3JGMXZXY0hOa1ZCdzAvTkFXd3RJRWhzQUZ1Tllk?=
 =?utf-8?B?ajJ4NklDL3IxZTZHNFJxUXhXRklUVy9PNzV2VnEyQ0U4Z1kyK2ZQR0xsRXJY?=
 =?utf-8?B?NzV4K0U0V3YrWWsyTnI5aWo3QjlzbTZWTFFyUjQrSXNrNDc1VlV4R3BSY08x?=
 =?utf-8?B?Z0pWaTRqUzFYZUZqZTV6TGpZVlJJeDFhYTIzQkw2Q3p6UVpHbThkWXpHbk5i?=
 =?utf-8?B?dDdqTTBoVmpIWVZHeXAxUG5naGdvb1p3WEZDRURyMlJrbTdseXc0N3NrV1p6?=
 =?utf-8?B?bUFTUEhHL3dnaDN4T1E0OFp5SERvQ2JKS3RWcXdTdlczbWUzdGF6K2ZQbEtQ?=
 =?utf-8?B?Wng2MFJrYU8wOGpGV1UvaEVlR0s3VmZNWU5LLzNGdExwaVRXY0pUUFpQbFJQ?=
 =?utf-8?B?VC80bndHT3ZTR1ZJc1JFdXB0Z3JCaURyVnNuekhzQmVlNi93OVRjOFl3VXlG?=
 =?utf-8?B?NUc4SlRkZ0NyRG1ibmwxb212THdyNXpaRXhWQnhhb2RIbXVpMy9QTU1WamFS?=
 =?utf-8?B?U3NsWHhTWlFrbGJ5QWRHcU8rMzYya09QMHh0eTR0aWJEK0p6TE0rSGV6Nzlh?=
 =?utf-8?B?TTlGV0VLNUZKbnBHYlpnMTVtblFrclVheDRBWFIzT2x4aTZJOWZadDlMRnhG?=
 =?utf-8?B?TXFMQ1hUdGFGSXpWOTZQK3ByY3gvTWo3NEd5Q0hmbnc5TXYzTVNpeC9LUExC?=
 =?utf-8?B?aWNaOCs5amJ0MURyN2NzaDdQN21HbkRjbmNkbloxaTBSeFBlYkluUjM3RGpT?=
 =?utf-8?B?MTRId1RGYzBTNTBYRlRGbTRLcjFJRFNCQTdBeGhUVWdtOWJ5ZjJoeG1nNm04?=
 =?utf-8?B?VEhLNTEwQzBzSEF6VE5lT2VXMDNsUC9PVURGM2hHY25DOHpXNTJqcUprOXpx?=
 =?utf-8?B?Y1doVFF3Vk9xMWVVNzFGWlFyRGJBcy85Zm9Jb2Z6Vks0cXJ6Q0tFVW9kNnBQ?=
 =?utf-8?B?Y2RVZDhRNzZIS1hxdlN0YXp0Y2RLOHFSSVdnM25PNEdOVTRRdE9Ed0cvYVNn?=
 =?utf-8?B?RTFrMjFvbEFXaDJEWEh2YzcyK1hRK01ueWpTZnhySlN3N3QzSTM4ZXZaVUZi?=
 =?utf-8?B?MDNVQUI5cnZkM1ZKYlJ2V2JWRGRnY2daL3IzWFRyOHpKWGdpS3JUVWlJMEhB?=
 =?utf-8?B?c2FDenBiWjhoYlRtcDdTUVJEMHBkYUJySkcrLzBxaWUxREFFcGJpVWJNVExF?=
 =?utf-8?B?bnB2TnNZODZuWEU5WEpyblRHQW9lcTJ0dEpwWUNtcHJMYVhtd0ZHUmdzdnFn?=
 =?utf-8?B?N0hISDdCQWRJbk5mSkFwR3E1aGlrWTE2emxsZ2s4TDhwL2FCN0NraXZhTHlx?=
 =?utf-8?B?SDJoeWFiUi9uQ2RqWkdWajdnNjZDaC93a2dKaVJHdjVZay9qZktVb2hkU3hP?=
 =?utf-8?B?UFduUmVUbTBreCtnZ25jQ2poUWs1NVVLMTZvdDl0bzFuZTJqV0ZoUk5ZUHNj?=
 =?utf-8?B?UHhkSkEvTVpIMHNjc2lKbEtPRFFZdlZLcG5ZN3VBT016ZGtnbDhoTkdWbWFI?=
 =?utf-8?B?SXd1elBIUis3amlwdFBNeXZIRG9icWxCMkdmZU9qdVcvL1ZDN0oxZmQrTHpo?=
 =?utf-8?B?MWxmNzJxK2x0em1HZnR4Wkk4dkxYZEJMZjJBSDRGbHB3eUNxRTYrZ0xTd2g3?=
 =?utf-8?B?cUl6RGp1WGY4ZTYrS3BQQitqRHkrYWVDeHJsaHo0ZmdPNkpYMVlVTzJYblFC?=
 =?utf-8?B?OGtNb05VUmRQZVlsNENjaExFekYyZFRDQnc4ck1Gcmt4TzdmV0wzbnVNM2ZZ?=
 =?utf-8?B?bmhvWHp1MlZzN2dwZG4vMkUyU2FuMnRPdTZWT2xPU25KMVRxT29wSFk1Q1pa?=
 =?utf-8?B?bG45YW9xVjJZV0hWY0M1ODFxYzU3SWp4elBMMUQxU2pYdTQxSlEydnhXNkhh?=
 =?utf-8?B?Mng4M0NtUXMxaWsrQ0NUektMWWJWMmhUTWt5MHY4aEF6MzE0cWIwQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c4cd3b-1544-410b-4d04-08de7e855b2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:13:56.0054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozxoTNdMyl7+9W/+nkjrfNTXhqaHGElRvkkHKfPKo/vBNBkmJoWrff1gysHajrrRQrXBOg/4SFK3rUQeXHZq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

Add imx_wdog_alias_to_addr() to get watchdog register base address from
device tree aliases. This function is used by mx7ulp, imx8ulp and imx9
SoCs to locate watchdog hardware.

The function supports:
- Matching specific alias (e.g., "wdog0") or any "wdog*" if name is
  NULL.
- Optional device tree status check via check_status parameter.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  2 ++
 arch/arm/mach-imx/Makefile                |  4 +--
 arch/arm/mach-imx/fdt.c                   | 51 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 46da7a1eff5..8b88b333b4f 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/mach-imx/regs-common.h>
 #include <asm/mach-imx/module_fuse.h>
+#include <fdtdec.h>
 #include <linux/bitops.h>
 #include "../arch-imx/cpu.h"
 
@@ -327,4 +328,5 @@ enum boot_device get_boot_device(void);
 int disable_cpu_nodes(void *blob, const char * const *nodes_path,
 		      u32 num_disabled_cores, u32 max_cores);
 int fixup_thermal_trips(void *blob, const char *name);
+fdt_addr_t imx_wdog_alias_to_addr(char *name, bool check_status);
 #endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0f6e737c0b9..b4f316d8c47 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -21,11 +21,9 @@ obj-$(CONFIG_IMX_HAB) += hab.o
 obj-y += cpu.o
 endif
 
-ifeq ($(SOC),$(filter $(SOC),imx8m imx9))
-ifneq ($(CONFIG_XPL_BUILD),y)
+ifeq ($(SOC),$(filter $(SOC),mx7ulp imx8m imx8ulp imx9))
 obj-y += fdt.o
 endif
-endif
 
 ifeq ($(SOC),$(filter $(SOC),mx5 mx6))
 obj-y	+= cpu.o speed.o
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index f19ab9edce4..93016a11acc 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -6,8 +6,11 @@
 #include <errno.h>
 #include <fdtdec.h>
 #include <malloc.h>
+#include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 max_cores)
 {
 	static const char * const thermal_path[] = {
@@ -127,3 +130,51 @@ int fixup_thermal_trips(void *blob, const char *name)
 
 	return 0;
 }
+
+fdt_addr_t imx_wdog_alias_to_addr(char *name, bool check_status)
+{
+	const void *fdt = gd->fdt_blob;
+	int aliases_off, prop_off;
+	char *wdog_name_to_match;
+	fdt_addr_t addr;
+
+	if (!fdt || fdt_check_header(fdt))
+		return FDT_ADDR_T_NONE;
+
+	aliases_off = fdt_path_offset(fdt, "/aliases");
+	if (aliases_off < 0)
+		return FDT_ADDR_T_NONE;
+
+	wdog_name_to_match = name ? name : "wdog";
+
+	fdt_for_each_property_offset(prop_off, fdt, aliases_off) {
+		const char *alias_name;
+		const char *path;
+		int len;
+		int node_off;
+
+		path = fdt_getprop_by_offset(fdt, prop_off, &alias_name, &len);
+		if (!path || !alias_name)
+			continue;
+
+		if (strncmp(alias_name, wdog_name_to_match, strlen(wdog_name_to_match)) != 0)
+			continue;
+
+		node_off = fdt_path_offset(fdt, path);
+		if (node_off < 0)
+			continue;
+
+		if (check_status) {
+			if (!fdtdec_get_is_enabled(fdt, node_off))
+				continue;
+		}
+
+		addr = fdtdec_get_addr_size_auto_noparent(fdt, node_off, "reg", 0, NULL, true);
+		if (addr == FDT_ADDR_T_NONE)
+			continue;
+
+		return addr;
+	}
+
+	return FDT_ADDR_T_NONE;
+}

-- 
2.43.0

