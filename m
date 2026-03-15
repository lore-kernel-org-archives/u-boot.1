Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF3D58B0F
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 07:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0863684286;
	Sun, 15 Mar 2026 08:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zy0NNmHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7615843D1; Sun, 15 Mar 2026 08:48:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F8B84286
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 08:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV30x8N1cMXodxjYlFDS3BHd1rXQIxnZF7vP89TfA50Tol+0QmRSd9VgiJVRuA5IbpY+F6VYt/2xQx5YsNzMA+059WxdYUFzfpFM+Huelx3PbPl0YuAZvk/F/I52YALPMBf0xsXkaq3S6NoDtrCPmUZE58RiE9Xnebil7F86oBEthR66qH0BS8llEgPNjsGRGBq5r3LLqwqU4NRfvvzetHfdMzv9wqQ9b6HFhOzb06zB4MGTog/KLPrsf4ul5Xi9myUdRaZFXKLcRpqgmgnZ5tVwOZJwqJnScsJFMgqeGMoN7yGa52n24YeqvGEzdjNx8hWwJG0S4VY8yujpASfqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2xLPyR8jwW9eNM4JcsqZSEPlZ6p/rnZpScon+IKDNw=;
 b=kDgAu8+9hLQ8G3ayMQOBkPgxR3QDS2QIpHBbs3B8EyOan6N9E4oo+Zu9KCwoFb2OvBFHQsEEtjqDGNGvejCAiR6i+hZxC7Df9kbXzHopReJBGPw/f/wkgAo6HY/o5R/GTuGNFWqM83X605fAsgFLW1GtCJyqPAy2wnDbRg/du3JlEFcVgHfsR1GDRR4u6vX2KtjYjvw2cG70XH5hD+I0XCQbGS46LKpXN+JjeXAxQijfEvknAqaqZvT1VJbTxbfH1+aTurHjeXzIvRa3beoBS/Of2EXxBoRCLclCMhUuk+fBK+FBRc1w9my5tKsg1nF/FolyJhot80gwon37iVPFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2xLPyR8jwW9eNM4JcsqZSEPlZ6p/rnZpScon+IKDNw=;
 b=zy0NNmHvQYoliBtkcPFJWZrb6o2Chzs/LGG4c97Gyy9gPC5HW2mVD3aa6lp+UDpS5AhnXNslBMYR1B1au7am16oWuQ+JdtCAA/RvpKy8I8j4i7Ior4NWIKzZvHuJcXaFG6YLJ9mX8fHHOKXs1ueU7Hv/O3fMtLsxNJhs6NYhzPd0t7xfRtsrlXA97tjv5jiyMTSc6KlXGlDpLOHkqQuYJeoKZ5Fy6lBS4bf0hI1ONPj4/QtJU1Jqblik/yHi5lxEjDSMFmJ+TqlAP/0Y+W9ZvaRUtc6dY8P5lR+3sNPT9DVvsfozMDk7U6rxNWVQRANduYExXZd3gBgrYcJ6AzKQ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8613.eurprd08.prod.outlook.com (2603:10a6:10:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sun, 15 Mar
 2026 07:48:07 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 07:48:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/3] net: airoha_eth & pcs_airoha driver fixes (for
 u-boot-next)
Date: Sun, 15 Mar 2026 10:47:54 +0300
Message-ID: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8764f5-c7a2-4ebf-db5d-08de826731e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pJCE7Gd6v4M+TFe172C6raOcKo8U196gz5FH577EIgJf8KKZe0FaCWv80gEcQXPO2kr0ZKCchcCc5yn3PzzN1APSBmugwpWzxwoUmFKVH+hnWVBb1nTPbhKwdwiR2bdsxV5UOJEXa09qZEE+thXkG1reKIOSD93FtLXNkGtUg70ftvqLBcGdNUYjZpi9FxYdDnNno1ZmC8QQ/qXM4yD9HOJNeaMgcugVvrXsBWwKRlagCwg3khU/30MISxlSV+Pq46yujR+ZkTMYoOh6t9wJa1DHO/c98LCtvgIciCUiFJD+quWid5O5lBUHNZvqfxSGTYaba+RrJ/Dt4x34MF5k9gx7cOM/pH3kr2Ai78Z78SDHSFNPvPN80cXZJtLwJS3qWtQu0dKl7HlLav9WhQ+jIE4MgPFW6aSgWNPFwBP+ih+5x/UYydtqNXCqLpjrj+5oG552vP4/5hlUKxs600F/7mntYx4tDoeTthnUySP1TBIDw0/NtHlCCrEf/6+E09LZWdLS2FjiWqCFziCCss/qwGiiR28U2oOPLh13x8jUAQIFZh1oEQtDocnVnIR0itVwQru9CWCu6oViMKMjvFZioQS7BMUJ9HayHHfZ3fOd4k/5mu/kVtWkxn/9S27Jj2TSUqj5q/PZY9m8653/XJAmmYO7j7yiIoRI9spLQ+r5X8ACW2fGdzL5MhWwbLhVDR3vtqN7xCCDOOQKa1+LL4e8QV6yxw0m/ezhtMy8ITZFOBm7nHud0IuyRtS6NLFP3Vt1XtP1pAjwyop5KPT4Jb++m99XBUT6di0WmrapaYC9Inw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRpK9SA4R8sf9SDzVA1kPz7uWzGo+s/akfN8F4ELhMSTNi6P3lcxvpSpHEI/?=
 =?us-ascii?Q?/9ncNW9E4Szuk08vOgqRv2tjqBKaI/WxwAN1jPaVYt63iD6o2iVDjYHtZ6nv?=
 =?us-ascii?Q?w0A+orp+N/6Ao2FqXK8S4lhDpMokA0QOB1hY6vEV86EGMp8GX0xUzQuB+ZJm?=
 =?us-ascii?Q?Ofnoy/hftRHCVoLgp6FkCGFl7dvSNmqk9H8ez3K+wkAOZKX7s2R+zrD5uEh9?=
 =?us-ascii?Q?wLEqoAsJIMey0wuQOdM87Zj/67oRq6OER16hmQSrC5nMihtfi0EFjyxPlhvI?=
 =?us-ascii?Q?B3cY0E2X85n11MBgAvpH926PBCnX4qMXEFNAvhb8k6wXYpeqQHC45/FKw6uy?=
 =?us-ascii?Q?O/1tLmrvSZWPgxXviCkArTnngnQDgURYJthC2yXT/dtt1TZuJyaid406JayY?=
 =?us-ascii?Q?WKsPkgZ6y0aJ80pnt2LxR/y7CEPz4cTt5ws8tKnjIyBuSvYx/rdZGpZ7fc36?=
 =?us-ascii?Q?pJXPoeRx2pcDuEk9p8pnM5Cu1lxoIf6InK2KNR8NhG0p9p+oGKpVkyF/3GAY?=
 =?us-ascii?Q?C+0ic5xg6Q8P+NWaSwwi4hJ0HGMcgh/EreQg88VCttdR0PW4ZdM5rxgXcpAn?=
 =?us-ascii?Q?sJYznsBVb0MbXAFRreKNJhyHRpqHhlpf7K8HPqHI8c6khNp3vRfjxNabemE+?=
 =?us-ascii?Q?PMEbIN1EAVGEJVy4+ycPQnhCwiBE5vk8BrRXCxOrc5r8texN3jk3oLSo7svH?=
 =?us-ascii?Q?psJiEA5GnrvxQUOdBQNcW8lZfeOArsY5EGlDyJVRY4bNJKDDmzj2NDi7M3Pv?=
 =?us-ascii?Q?r+Tbwer8d9WnWZF9E5Qd3LEoOsbGxzB20bN+/xRb5Jg7frbRz/MXlV4/PV69?=
 =?us-ascii?Q?1pT+MWoQY4sPqH2cvr0ZzvLX+jsUPjZumXz0wrDO4uYv7iKj2RLfR3guDXm0?=
 =?us-ascii?Q?wbfkQpMs/zARzoG6x+qm89NRu9vfOPX4mvnwHY6o2z4nqQfQXh57hceZbe+Y?=
 =?us-ascii?Q?i3c+Bd63PLHsot4IGInRcVscb2A2/2trDVii6J7m9IalUjg4J+XRyEB+RNX1?=
 =?us-ascii?Q?En5jKpXmlO7NPMAG9hZayRriJpT44jve14d3fXpgCEFjn6MRj/AqVABrgMQ2?=
 =?us-ascii?Q?gerCPypVcy8g5X3a87mlnRIwT2aAJ/pc7R7PnPmccOCrzzs+sViP4hid9AM7?=
 =?us-ascii?Q?v3wwHtenaLkP57+8Q8h/ICZ3+SG9gxTJpzQwqYNj2aKpcIWhMnvmbiteN5lE?=
 =?us-ascii?Q?MDVzBdXRM6bdc1CI+xGuI0mohExvJlVMV/C6LwAe0Qj1i0CrngJR32zFW0i8?=
 =?us-ascii?Q?01wc1Lz+DDibLeb6+cz3Ood8LRF6pAOsAJY7CNeQ3RYjgiF7nKm0RaOO8b98?=
 =?us-ascii?Q?ldDVp3ezZ6vRBcpTx+CRtMOSSc/3KcpQK93qPUm/yDSTw5w/yc2F4Sw3HWTE?=
 =?us-ascii?Q?F82+E+4WTlxbLvrFUtnXtRG/9oQ8PW9/t3jimQnNxHzWUjzq+SKK1MBfvr2m?=
 =?us-ascii?Q?79G/J7ecWKmoNqOVcy8dxrTTQuSc8VKNWzPCAVfn8HWFyzdbz0dbD9NqDFS4?=
 =?us-ascii?Q?zy0nWlWyZjB+jph1ebkVBBwTjE8VGgnGg2vnPQ4o0DmovrwVZH6ybo3zU0iI?=
 =?us-ascii?Q?sG2mm+j+d7jUwCXfDOsYIqaxW0erpAsbPdd5xm9Sdqv7GF+gZ0ZKdAo8Oig2?=
 =?us-ascii?Q?xALtL2KtUX0bloa84bx3p6JEjmu2y3tJ0Pk7Q/v/3/5W5mbLrFk7GDHHp7ph?=
 =?us-ascii?Q?CkRHNf77zNg3jyFZVQSw0c+F4NakZb15evzk9GmSiLVBPwbYyBsFePEDlAD4?=
 =?us-ascii?Q?xp/A3U0WrWZccFje2LYCVC5I+MH0XoA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8764f5-c7a2-4ebf-db5d-08de826731e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 07:48:06.8800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI86hXamqzm5HO1B6e10Q9URaEn6gf995NHU3vc7Oo7lvybKvsifEo9Ro5yMQIwQeur4lZe3JFFwN9BCCT1X5FAHVvixxNwoHauAif059N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8613
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

This patch series:
 * apply minor fix on airoha_eth driver
 * add back pcs-airoha commit dropped due to CI error
 * fix allyesconfig issue caused by attemt to build ARCH_AIROHA specific
   driver for the x86

Mikhail Kshevetskiy (3):
  net: airoha: probe airoha switch mdio on airoha_eth probing
  net: pcs-airoha: unify code using SCU regmap helper
  net: pcs-airoha: fix allyesconfig building

 drivers/net/airoha/Kconfig             |  1 +
 drivers/net/airoha/pcs-airoha-common.c |  4 ++--
 drivers/net/airoha_eth.c               | 22 +++++-----------------
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.51.0

