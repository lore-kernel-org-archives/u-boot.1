Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFD4CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F6E846A5;
	Thu, 28 May 2026 08:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o4uuXe3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1E1803C6; Thu, 28 May 2026 08:43:44 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC65284659
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytuWlQfyu73AjQAmurYY2YnxYcj3OXICYLT9rWPjNc2tCDLTztUHmhE2pbij/CIe76Sq64hYtXGgg3xTxbBAGJl6yR1sP/Iab+37yz1+cFO+1HBSOOg8w5kB/LBnszRf3m1Q6iO70tWK+jn/zQWRYCTt7vKlHm30bcLzki16FxNxDdv8E5AcSX+o0A72WD+rI+58qLP2jOl1eWJmL+dVZr89ehqRSKz9namnLA2KOyMl3ddu2yPDbXqbeOLJ+3vvPoeHnubd7KFEuZhGuyq67pyM6hJ2Mgk7/hO0X+bAaEhCq8A+2DsQaHigh15Osp1GCC9v8MbReTccQUPtE1+XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG0Fa9eNaEXZgf5K31Lb06kEjMuTGEcI7zT3SOY8phI=;
 b=moI97NF5aQnBpAbnVddQIlfyHFxdQQ6KpVB7g/WLNLZHpuHf4hkqOBjxJOcS9fWlwtgkGddwptf+H909VkO4+7IRvZFGOueglEg5Mnxx0FpPrM0FHU+Cp2dJ0OWyOboV05e8NQ31uqNpP22AMTkyqzqt/7I2b7n/7onxB/90nA6gpzQBYnN/mVIV0Q0xe2JFoRF8cgbMBNXivz0jT+GfmzydNtHrWIJpNsQUjPsBbURMfOFmlpQUOJEJ+MTkFy0B/nB+nocc9RlRR7OQ0jUglESu27h9s001mWE8PbEBjm6qbA4DXKRvmDT7jwXEH3nYWWvkNmKTmSYKLBHNIHMpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG0Fa9eNaEXZgf5K31Lb06kEjMuTGEcI7zT3SOY8phI=;
 b=o4uuXe3g4KWKAmwbkFklDzaZT4WJVMho/oRuMNiRNNcMyZotoBlwh7aj3uLlGTt7Xl2AtxjuL+UE7GCDHi7QT2Tqq8GFuMVclvnRUpO1V9y4RrRN/s+n7ectOorfB9hvxP75coftoWkcQ4PVWZHQFEKO0iskbdPzhY3l7Q8u7nLRUyXJTz+DIqbWsFYN3ouwuIPiCIDfubs1Id6zKJhBOo0QA62xI3TRJsJu7a5dHU+4Ftl4AUeu51hRYHDrHnY36FcNsc6SXWUx/SZCEIgH6+JdcMhaTkfiDO4Me2vSzZWzcb2qOU77FH8GzvLj114Lup+rhy1w4toCP0RnfY7V3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8516.eurprd04.prod.outlook.com (2603:10a6:20b:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:20 +0800
Subject: [PATCH v2 2/6] net: qe: dm_qe_uec: Use dev_read_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-2-dc6f20b82611@nxp.com>
References: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
In-Reply-To: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a2ad16-f2e6-4e81-72e3-08debc84743a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 83tP/zSUPGZwaan7zoXIvIXudkyMp+Yqj7SyTahIbGok3Q0Iizry1G/xaTeODBYOnNYg+kFwv8w4xDYt7UUGn8LTD4JFkPgpfH8GdoRPshO396YHkfUcHiuvCdX/OqNgSebU4k5sM3c13rdZpVDWbPrP87XT3PU049isWZcIQb+I9ev5prG7Lt9Zc24bUL4ds66AoIjehO76YlhvhkUXe2DrU1KYTJKTuff4pM8TpnfO7/6uyXMCeFKu5ANK03ezxnhJ5uI0Gp2BdiELpSFBHb8ygyd3XBeLHBr9szn4RHhf85LNa+KQ3Qmk2/4gVgJ2jcpgLTT8qDySSH8w0yOpe02BbNYgKqTRxG+VJqOMnNuGvUq8Eps+348ETDGbYJRp7tnSdVOb6aMNvrsgu/AnkcWYHdfzJXzxT1xRc7fu8khr/e9OKBUWmEgayaM+UDbFeTylW2ZZOzRiMW1vfZV8y1IaBSQXESefXEEEeAP0H85MYYrsX9AtS3T2nZOQDf1E+QlyoA8oSJlYLUwvdQz3zOHBI+SRv5TFOyv4yh/q4tVZkkBWzcVzKtOvptBl0yeN1xN6ZMVAPA+nKo+JkfE90ZNQjHV7uYnT8sfIiqDjYa1RF34wAYJUEsbjh1KTEdlEi7+KhT89oQqsOy3/zpalZ/jLrDr7Kjj1u6t5Z7bHurmUi/Ii0zOm8Yr6Vq0yA/pXItg4c83KaUSs853NeHcxJwmhpnTflufBLOyKngEyFwl0a4H/x91SVSfpX0334vmM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejYwbGd2UURXS2VwQTNyTGJTYXFHVnI5SWdGYWV6ZFJObU50ZHdEajFHU0px?=
 =?utf-8?B?OUdJdE9nd2x0b1dJZzZRdzhDR1VCekpZMTlLQjc0QXFrdlF2SVA5bC9pTm50?=
 =?utf-8?B?QkM5RUE4SCtBdisrZ1RuV3lWUERFZGg0WWJrUzZ1SlFHNUlrYkJyRHhCZ050?=
 =?utf-8?B?b09Od0IrdXdsQjhtcDNYbjNQTkZaNVptV3Zzc2NKczEvSUExRExUUnBMUDZD?=
 =?utf-8?B?a2l1OXYyQzloUEFDbUc5V0JsMnRoWE9YT0IvTDg4eXNENHpYQmFkOW5tNGdP?=
 =?utf-8?B?T2M5ZkVhMWhkQWhvekJ4R3cweTJ0ZmZYeEF1YXlPbGxiUDV0NEswRXNiQ0I0?=
 =?utf-8?B?NS83S2FHV3ZIUFl3Tjh5VnBxU1VXYU96WlBZa0doN0RwMkdwQWk5aDhrT080?=
 =?utf-8?B?ekRWOVU3cnRTdGJ6V2I4TDluK2xUa1VKaE9WaWhMMTNtMmNHeVU4dy9iRjZT?=
 =?utf-8?B?WVBYYS9lSWdqQzVQa1dEU2hoalM0ZkY3OWxYMDRscjF5YkRlVksvb1dSV2NV?=
 =?utf-8?B?R3F2YkM2ck4yUEhIQ2ZRaEFZenY1cVFCVkRVekhDaWJKdDh3YUpucVk4V09u?=
 =?utf-8?B?K1BTdFpaNFRVQ3hkTUZRNzRIcGhEeDVkN0dpaTZFVEc5dmRQd2I0SVF5VCtU?=
 =?utf-8?B?d1RpRzIrNHR2V3JnUXhaY1N0R3czYitSZUlSM3FKRVRpLzdyalhmRnQyaFc5?=
 =?utf-8?B?Z2xXSm0vNFZxNisyRVIwbk02UlhqRmFjbjZRV3NxWFdMZlh2NThhaFlIcDBG?=
 =?utf-8?B?US9SREZrclppbEJ4NDhyK3YwNStzZVNPSDFzWHBzbndsY0M3T2F1bHEraFR4?=
 =?utf-8?B?SWdybnhocis4WXNsTVU0clVEdVhjUjNRN3pLSkJpMXNMV2RlVk8zODNsa1ZM?=
 =?utf-8?B?SWg1ZFUwQUIwNjExWDRmS0NtYkVKbTZYMXlrb1A3MjVZdXBGYWV3b3NyU3dX?=
 =?utf-8?B?d08xUTlvdmtJMVhNSVNneklnS0MwaXh6eFpJbFZYMXBoQk1EZWpjVzYwU3hh?=
 =?utf-8?B?UHo3cnJoOEErMDhPTWNEWkkzdEwySGJUdEhrVkhMeGM2STdKR1NBbVRaNDZ2?=
 =?utf-8?B?U3lsS3crdTgzY0ZZdC9QZmYxSjZ1YlpycHNFdjVvVlg3RDUxMEM1TGdTTGxz?=
 =?utf-8?B?U1M0ZThRV2dJOEVDT01ZY2VWOHBoYmlBSENZSDRKNDYvb2I2NFUxbE83TUtR?=
 =?utf-8?B?L0NtYzErWUd1d1BQK2kvbjBoc0UyYm1xOVJvd1pSUmI5ZFJSSTR1K3dRME5n?=
 =?utf-8?B?MlMzeFdNcng5aEVCMkswNkRyZUgzT1FrMlMxQWZrenBXTExISTBKNHhObjIr?=
 =?utf-8?B?Zlp2a2dVYlhoR1NwcUNhSkpGeWVnU1FBS21ZbkN2bC9LOXA5NFJoYzJZcnBE?=
 =?utf-8?B?dTZMbFhEMnRHSDJRc1RRdENNMXFwVEhQL2wzT3hkb0xlNmFrdnBUN3lqQTJs?=
 =?utf-8?B?b2s2RHJkNWI4ZlNPek9VZllBd211QU5WSVJCMFJMVWs4OW1rVlVlUUd6VkZW?=
 =?utf-8?B?ZnMzWm9QeDBWVzY0aVlmOUpaRzIwRFlwR1orR3B3bXhsc1NSaHI1UW5kS0dl?=
 =?utf-8?B?akl0WTQ0RnZPc21Odk5CVnFkdG91dUhDTC9SL3RWWHFzWXBMU2thelQ5YkEy?=
 =?utf-8?B?SVVmUTU5TWdOU0E5S2cwQ1ZxWGVDcUlldXlHMkt0OHRacVJYcWJUcUkrTm5R?=
 =?utf-8?B?ZGRsaW5RbjRhS3YyOXpnS2cvN3BaSTkveTAzWHBlSmZ5VkpFc2FqREQwS1Qw?=
 =?utf-8?B?VGR0aHNyeGVzMC9LeDUrS1lOaTNKR3dCeTVSVEdXZk5xNmh3cFpqdjJjcVVO?=
 =?utf-8?B?MkI5ZVRrTVhNdm9JMUhWendQbDRWMXVMUng5aXdtT2hKVTJwSW5ER3hPM3lx?=
 =?utf-8?B?ODl1aTlKNEJSSnNaWmFKZDl0RlFpZFhtSUR1aGRveE91dmlOOGE0dUtNZ2xl?=
 =?utf-8?B?eEdRUnduOWJWMVo5ay8yN2R6YWdnY3p1Qms2aVlaWFJSdXV4d2UrWFhwcDd6?=
 =?utf-8?B?OWNOV1E4ZGtjQ0VYSmZuQ01GWmVsY2FnL1A0a3RsQndrWVV6VmFMNGRZUVgw?=
 =?utf-8?B?YXJtZmM5Zk52OERYZUdDN3FEUlU3M1hiQTRUNWNOeXdZVklVdURJTkdvbHhm?=
 =?utf-8?B?Lzc1aXJSTVc3aFFiTVNUeE1zMk9kQXFrckpZaTlUTFpTUWl1SUhTSEhPS1hO?=
 =?utf-8?B?WS9ldGFsY1dKZnhNMEF2Q3ppajVkRkxGWVF3ZFRQY2Frck1ORHF2aWtybFRz?=
 =?utf-8?B?OVlMTnlNdmN0alU3WVk3UXJLSVNGUnB1UTVxb001Qkkva0FNSVZWcWFSaHdR?=
 =?utf-8?B?SDVKZTZVTExrcEVCcEY0OStEdWMwNUVFanQyajlFTVFQN3gzK3E2QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a2ad16-f2e6-4e81-72e3-08debc84743a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:40.5650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFm7C3l5HcxlICfAZxsQ+tEdePBH+XpqlnwZqMjNWGgAw8a1COEQ0GEBqn3vn3oGpPPM/fTqnBMD+7NkB98m+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8516
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

Use dev_read_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/qe/dm_qe_uec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qe/dm_qe_uec.c b/drivers/net/qe/dm_qe_uec.c
index ac3aedd8b49..f9bc5d49c8f 100644
--- a/drivers/net/qe/dm_qe_uec.c
+++ b/drivers/net/qe/dm_qe_uec.c
@@ -1133,7 +1133,7 @@ static int qe_uec_of_to_plat(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 
-	pdata->iobase = (phys_addr_t)devfdt_get_addr(dev);
+	pdata->iobase = (phys_addr_t)dev_read_addr(dev);
 
 	pdata->phy_interface = dev_read_phy_mode(dev);
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)

-- 
2.51.0

