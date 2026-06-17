Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE8CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4183A848D1;
	Wed, 17 Jun 2026 09:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lVs2pOQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A38848D7; Wed, 17 Jun 2026 09:06:06 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DF1803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaTjJb5kP1FiD9zD1rp25NP0p5RiEvXWoiAh4HNl/xzp840R2gr54zdQ23F8WYiNVUjSd/FbeyzNnh+zjLu1e+3crk1hHJnapRCKcZneNNlbkYrwCAhP4cmLo5CMxVE5GYoguLGG4YeE3Vi/xlgd2b8F8R3Oiw5Aqrr4z4rwmVWZeR5AnaGHnRtedeKAJNC65cGZKxH8muUbTB3RadMoOC5I1FpKQHegrs0Q4nemYw517QTrSisN6QiQLAyXJVaROR4XjpuONGE42uw/Ldz+NMJvuPrjp+aPKBSQIZFg1yF10+CZ1zzeO6qtAgHmtMaqZdRAkEQdQ9cUJXBcZTV2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBdecvS9htGEjC2cxAiBzQm3MPrODev2KI3QV11FxhI=;
 b=XguVw66CZvUqcb10ZOgiLZGr4OIDYSNhZvaDbsc3W7jPYjlkVn4xs2k88FOv8cXSGn2SiNg3ZoSz59CS2HqygCWN74iZ1nPl70r7tE/v0MPiHxuy1HwrK8ewJxHOArAbmqHuNorwJAx2gakQiP6ZKM+AdcK3uuUY8rlz9zTNS18PAFjSZ6lWnAwVuyV+DvmVlVn1zIRnMZq7SCC4nsXo2H8I1Y00V5F/j7kXZCT8U1sK4uI1cruYEfoZkvqeUu17fZwkNo+Ia8xe5NShS8PP0kU2LtZ3XqqYyhXWFaTZj7jae8x+K6tEzmyI3NeGIZU6xo/Wwcp/TfJxmAa8nrOgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBdecvS9htGEjC2cxAiBzQm3MPrODev2KI3QV11FxhI=;
 b=lVs2pOQ2wJOVupm8qEdwdQ7oD5f9xoscfv5PhF9JytcnvftzkzmftVqvyTx+Ao7zo5pAG/LLmvuLY/lidDWsUcDEJzz3ZTzhfT/eVS9LMrPUAX78QD0qcJZDnrUCzZp1XAZDBV9SCXGODRSs7iCN9X/IJ4lSNjh1YwTlk0A5amokKIbzRLzrSbYsmqTaHAFD8MCs/mmKZ0tLiRuwiMxvK2dhqVS8tISvkumboJJsJsP0876MiqR5MYog4n4xzaGgS/74PQuaLmwdJwL2M8wdutERRQ53uDVeycXVs0ikU0IS4gfwOmgjQ9v5WIHtLpog2aU4MlbRUn2Fx/xwhMLTow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:02 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:00 +0800
Subject: [PATCH 01/11] usb: tcpm: fix inverted poll condition in
 tcpm_pd_transmit()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-1-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0265.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c54daa-6f84-4b8c-610e-08decc3ee400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|19092799006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ole6krpmk+cKPSP0AWLIZYx6/KvXBaGv18XZShi0TxFaPyQvyKHqmLs5SzCNWEL1ZS68fyVz8uczbGs6YFFhA/WWQNhEyUUae3V7dGEtFL8+btoya/+ZhEQ5i34dyV1ytiXqAz+67NPq6SUTECq0vbSW2T6i+XVSY3iYZGlOBvf/CVnBqBLAdrQf05UflcT4Q9iWnKv6qRMPaKzqADxSWPeMyk08d6WUxbciWb0IFY+/gFhF6QPRGJGyR7u3KqL3nyLz/9O1mx+4nrCkzujSWM9iDWcOGyuQlJdURFmkScNXom/5L+4jSahA0VDjckCzwxYOcf46KttQHKorRg/SBuV+kvmlKQflwJpigIc1SzQncEb7DbVZ5I0Uq7JZL84vDrkRJzdWh15Q9W7YMAvdmbp1+MKhtohyC5TRDgHEEs093/25bg72UvHRFuHPQQQsL84fumxKsBh4+sZ5haQhzLF3f78UYuKdJBL9VBog9EpzS8vtSJsH8e12tY7ptUmuRmGiRl49pQZuhQJd0h5Teose5aSkJNg1I70YFGaJ+74+98KYC6yMkN9PgzWIP8wvlcHNK7DdvrHaCIeTy6hWVfkfUbltFoEcawtgj4rzSy76RpQZz/dMB0wGVlNQb0Tt8AMy5pLPYzLqV1lkW6ksnYZS9laIkttxKUiLEXIoBSIEc2JVKcIyb3BtXW19Uh2B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(19092799006)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckU4bUF5TTZJV2M3QytmNUZQL0hkN25OODBzQjFvem9sUXlSSVViaXB1dkp2?=
 =?utf-8?B?L0xjSGhLQXFqZCt2VmdheGhTU090UWJqamt3UkxzeTc0dDZwaEljbENBc0xx?=
 =?utf-8?B?bmY1K0hoZ3FaRlFLcmJRS3lEaHhYQWd0aCtOaW82ektZWCtleXYwY1JDa3da?=
 =?utf-8?B?czUrKzQwRjNES0xpTUVWY0FDN0JoeVJLWVpXeSsrdElKTFBveG9sNTcwSUR5?=
 =?utf-8?B?U3ZsUXFWUlRPUm5xSG5LejlTbU1mdUNHelo4RFhYWXNVL3VlMHBnR04vSDd1?=
 =?utf-8?B?aVNIMlJVUjcwdE5CeVRNWTh5aTFoVGZVakFVbDJyQjRZeVBFc2dTekRTY0cv?=
 =?utf-8?B?V2lXTEIrakVVL1NGdmtURDFLUWo2bHBUN2pmb0tCWVdsTFlOQlJFZVhnM3dt?=
 =?utf-8?B?VkNGdVNNdGQ2OU53dlRwYVRkTVdMcHkzZnZ6ejVQTXp0UzZ2Rm9lRGNSaHpl?=
 =?utf-8?B?OTIyekNnSTZiUjVaYlNaZlRvM3NoQlJ6RmlmaTRRek85Q01KaEdyRTZHQjRW?=
 =?utf-8?B?dnNCUjFudTVvRm5ZYXQxSTRRaUdFQ1hnMTNBcFFJenNtdjBxMERFc2VnWWNt?=
 =?utf-8?B?Z05TOUZpSHhOczZmMGJ2MW1LK2x6SnA5RVAzSG9tb3NSUmJCbG5OZSsybXpt?=
 =?utf-8?B?K1ByZWh4MWxVQlVZNWVpSE9FdnN3WTk1NG0vbEM1dE9Ia0RLZmtzbXpVdXFU?=
 =?utf-8?B?RHdTVmRoTUFuT1lSdGIrcytqcmtVaXQ5Z0ozWFhJdzVHUHRJMGVGVktWSDR3?=
 =?utf-8?B?Qi9OTUZLR0YyR1lESlB4QXpXQUdabDRhTHR6aUtmcm9jMVBiQVZQTFZYZDQ4?=
 =?utf-8?B?bExiUjZqam1KNmN6ZEhJVWp6UC96UDJzaVV0OFIzaDNwaVJXQVFJaDJjV0Vs?=
 =?utf-8?B?Y1plSm4yL3FYTE9lVGMzaEQ4Y0Y4a0Q5THdIOHRPQ3dPbnk4MVFlVUxkeGJN?=
 =?utf-8?B?YjhPSTkzWEJVYjV4TXpkVzZKRHVZNktjUzJhK1dJdjJDNzNWOTR2YXZFNFhD?=
 =?utf-8?B?aVNPRWRZK2tWMmh6OGlVYnJxc0ZTdGpQTnBZUmk0b0F1VldLYjRNbFY0WGlk?=
 =?utf-8?B?aGpVOVltcjBqRUN6RzJEeVlzdGJuTExNdjN0dWl5djVFTy9OcU1PRkl6Yi9o?=
 =?utf-8?B?UzJxbVhZMVdTRW04SG5nSFVMZzRGZzloZzcwNnBWMzJtTTNEcjY2SlQvc1cy?=
 =?utf-8?B?UXI2YXkzaDFXZDZiS0M3WHQwTmh5K2U3MnZJV2NnN0JabHVDMnFlbFNsb3RG?=
 =?utf-8?B?VTExNy84NE1rZmJRUElUYjJJT1JUT0l1dmp5aTZvOGRWUkxLYTYyUnRqZmxl?=
 =?utf-8?B?V1piTkhDVnZoM3lSWFpwVzBSOHdvWVJ3TmtQb2VFUEswUHI2MVpnMGpyZWRY?=
 =?utf-8?B?Vk81UHdDVVA0RENSemR3ejZVMG92emZmRXUweVlVdTYrZGdVRUxWb1RxbThk?=
 =?utf-8?B?d08rOHNkZWR4S2tRS3o0U1ZHNEFrY0o0RW51aEphaEN4UkQ5UEwzU2ZPNThD?=
 =?utf-8?B?blRVQzM0bUV4aitUUGdkbUdQQytVR0poZFE4N1krRktPd0JtTU9qL016SCtY?=
 =?utf-8?B?OUJJK0ZEd0N0MXBiNitoK0tSZmxXSHhFdUFRUlhDcXljdHdLWGhXK1RUc1hl?=
 =?utf-8?B?a0pOSHVINVI3VkVpQURQWDdMTjF6amJURnM2QVk1elZwQjRmTjZ6T0lmU1RE?=
 =?utf-8?B?ZmtaSjlHc3ZsOEZ0TGxEdFVsNStreGZWSlhXTjRTbGo1ZFFYVFZGdWp4UGU4?=
 =?utf-8?B?N1pxcEJwVGs5c3JMRWgrSXRlbVh1Wm54NjVvRXoxYUl4ZTZ3VkZ6V1llWHZO?=
 =?utf-8?B?d3dFTHJFQjNUbFg1eWR4c0Q0UTYvTmN1WGhjVmg3WWx3RHJOYkZ5VXhSSTFm?=
 =?utf-8?B?Z2ZqRXN2Yk1WZi9rcjJVV1p2YUd0Y3dlaktRQWY3ZnVNenk3a2s5akZvSnVM?=
 =?utf-8?B?M2lDblNaTzdDaElIbG5BRGZHMnIzVHJNbFRybER1R2oxRGhUbTY2SW9JSEQw?=
 =?utf-8?B?SGdxRHgxWTBxZm9LWlhJajZhSkdWdE1LQ3A3NkZVZitVRFo0OWw5WlRkdnNl?=
 =?utf-8?B?R0I4NGtUTlFDS2ZoNlZGdEZaMStGRjdoMmlJdDN2b2hrT3ZBdng5SlFoNmRv?=
 =?utf-8?B?VGdiUXlabXozNVJQekRSYUk4aFlZUVdwUDJnNm5PK2JvYUhGVXo3MktVNi9q?=
 =?utf-8?B?c1lWZ0t3ZWFLYTFSVkRiTVpRTmRyZTdwRzBscEFkM3U1QzQxMlhpYUMrcUt4?=
 =?utf-8?B?UFM5dGxPcUp0UGwyTnhwZFdPNU9TZWFrU001QVJWcDQ1aDNFNlEzbXE1V1hm?=
 =?utf-8?B?bHo5WVBNeTJQYTBWZnl1TW9vOGhwOWlobGZXanpaT2p2YlVEY1JDeHk2Q2dR?=
 =?utf-8?Q?MVMkSdGU1cYJme/btEKkm6+EBwshnoZwwhUxW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c54daa-6f84-4b8c-610e-08decc3ee400
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:02.1378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uyvcaizlw4lxLX8x2YfDzA0SqE4SGlLfu+DKnt3sxvBUCHMwxkmC/aT19ue0VT28DJrp7hNl4djbGWX9HNosjkHFP8uFY9F0G8WoNqDkOqu52rGO4AWzGmyfPIV9ezn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
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

The read_poll_timeout() macro breaks out of its loop when the condition
evaluates to true. The current code uses "!tx_complete" as the
condition, which means it exits immediately when tx_complete is false
(i.e., transmission has NOT completed yet), rather than waiting for
completion.

Fix the condition to "tx_complete" so that the poll loop waits until
the TCPC signals transmission success/failure/discard before
proceeding.

Without this fix, tcpm_pd_transmit() returns before the TCPC has
finished transmitting, causing the PD state machine to proceed with
stale tx_status values.

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 3061b466d7c..d6c0be82333 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -207,7 +207,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
 	 */
 	timeout_us *= 5;
 	ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
-				!tx_complete, false, timeout_us, dev);
+				tx_complete, false, timeout_us, dev);
 	if (ret < 0) {
 		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
 		return ret;

-- 
2.51.0

