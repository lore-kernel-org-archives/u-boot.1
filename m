Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A625F8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A813842FD;
	Tue, 21 Apr 2026 14:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lwJOdVyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719F384310; Tue, 21 Apr 2026 14:26:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF4E8426E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWUphNhDP4mrsX3lDPLXldkJBRwHImh4/vy0a0qHlbWOy0IUBYrKgBCCa97rNBTiebD6slS/WoELGtqW0le9i94pm2Wpadb/lXvb+Vk08+Bhr3yU9IxlJb3oZ2Wmc0wmuu9GoO+pBKjzlQfOb88RsYp5ulS40I+OXNe09GxLRxWeeBlDMHt+LSIUzSJT7AfARnwI9zOLkYpRGD1+YVHkd8sPbxOMZ45Fq+8CS+BTQIwnmx80Wc2dLeCLGmXwtvF+Jgtie+2GvwRadD6vigXl8kkNWVdXo7Abf5CO3tAJLCDMMAL05MXgqNF6+OQrD4wns+HsO/ivuovkrnOMYXt9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd7IO+1isPwcvmE1KiiI5Xcmwc7d4ObiUbByXzrSLUk=;
 b=IRkiJgLMpnNlXqPMrjZ3Ot6xHTE2Ij3z9MVboqU/CP8OVu83253nIrQrJEh3xn7Ii8HW6Qgtgdwo5I5cz2KJ6NeCv2pU1Nb+D36TkxWvvd1yL1kA+Cgrq+RcmH9wDriM7+d1N4ILF1yXGpYAFJNPiFhrnhp/HDkjmgy4yfjaNFX0zb+9b5cAjzwk7pTrdKfQuLaSBPU07mBNoWTyhVddFfw4KShsNFH+vfstFVPBbwZriVLwlt+l3msG+9YKh7uHFtJm1LkLq3P7E1zB6+PdAGUn9TxCjxJCUgsFfsb9UVAyixPK0dwsPM3HjfMbRl0cU/6kBpMHOwVm88ryw7ZSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd7IO+1isPwcvmE1KiiI5Xcmwc7d4ObiUbByXzrSLUk=;
 b=lwJOdVyqHv0Pr41ZeHqhgo8BUj2Z53UebqPJHI4x6Ujtl/Ka5TMqqhwRnmkznfEWWN0QSXM6rFUiFFrnlguNZv7+7614/vQScRaiNftLyUEDEDw2XtDQDe3I3OQi/3eHZtKt/z17wlEsxa6u8fsc1mhQyIY7QqumOd2aq2JJiK3FaMb4QrcVifAd9Btd3gwbAzPaW9VsgeespS3UY9QL+lkD7k0uO3I+U4fkEsTs+I6Fj5Z2SHucVBz39DAWcebGcwPkTyDXfNtQJGowK3TSGWqJfzjufPupHiHP1h1dT31JIXS2Ahgu7iOO8EAWTe9M7C6h4vVgUT2bM9JjOa8/pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:26:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:25 +0800
Subject: [PATCH 13/15] imx8mq: pico: Drop SPL_POWER_LEGACY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-13-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b33bbd1-1de7-404a-0da5-08de9fa12f73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7MIpJ+M8W0eL9ukhctWW3IXI1CSJzjiWoNIE5OsWEq1c0qtjfvsTjCCul4pg8qWX4mYOyM9w0xFE2XMsls8n6zOVdwQi9UiDijuz+FSTw8ZkiWQMSsIofqbYkSHXglo/x5a6LYAWoSnoTmsxo+C3wUfttUbHBNoVJjpFwnyXifkavOHTKP7fVS+97HtUfT+GxGOZFXdL4qcEBieermg7X69CNIxeIvg/0D2+TUVJ5RM0O/U/sxKIHCV1qGy5voXox+EhAMiFG+rSFGtbAO+h06jtK1IGSQ/L5hhCKg5i9iUZfYDIpZraI6WrjerVdAEKPCMaxmnS6B++uOL9HQUV01rfNrvAMLKj77AG0ealb0wZYsOshA8RPy/mcTtnICnyPNsTUcAms+/Mth1WYPzh+R+on8U0P6BZv1cUD05vwVmfwN6UzqawW0gBKf89l6FeK/uzd6lXFWdZkdhRToZ+WzvplSKi83morxYlYxUA5V8xLzeZCyeXw4Abf3x9y0AsSVYRJAfLl28qaEM6GJsxecVlruKXpl4DcN+3DcW+l9osuSPwriUiso6kccarjpKrVEhdSq2txqRDNAy5PsqOl3LG/xwHE1QYC1S7E+AU8Cc4vYBL2GHSDVgZX11WXa6neW+TORX0KupDAD0YteuWjeUzTOAmH/b4P2gdRbZIjoio9TntLBFEqmVcTgcQd51Rtb040T/gubQZHcY096R/jpU6VGEPOVgCMVxhCQ0hzcOUAOvzDKsm2ZTKyrLMbmkN/gTJ4DqtLQja8jVlrxpKggcELZJHi7rnINJh14oHi/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VscDlabjNqN3AvbTNLcWRUL0pmcnQzanhQNXBPOXRLVUdCa3NHVXhvV0Ru?=
 =?utf-8?B?eWpSQ3hNaklad0Z0RFFSSWx6eHJVMGthNkVpU3M1YXNHZjZSRWNKaTZ0MnI1?=
 =?utf-8?B?VE1BanFUMnllU21MNUdFeElsb3k3ZHZYNmo4UUZ1ZFFpcytxQ3ZmQ2htNTJs?=
 =?utf-8?B?c0hzTDdjSDFnYytHQWlTWTB6NXU5U0NudTV3UW9oZFhaU202KzdXVXZVSVZo?=
 =?utf-8?B?My9Fc1NCSDRzN1ZRdXFaaXVNSm1jSDhoejlXVEI1SG1nenV1Nm03WFFWWkha?=
 =?utf-8?B?Zit5TUJ2ZHpUUDFacWRBQ2JxNlBxckFQOVBLdDdvN3lleGlMem83U01PK2VX?=
 =?utf-8?B?Q3kyWmMya0Q4SWUxUkdRVmJXckR4RytmUkU5eE9maC9oM3JrMlhWak96OElK?=
 =?utf-8?B?b1d6d21QaWxKaS9iNXVLRmZ5MGl2TFRTT2lqL2hGcG8yYS9EN2EyL3VJcFBh?=
 =?utf-8?B?aW5kcG9vWjMrTVV2NWJla29aU0ZOSWtSay9ERWFCeHlMVDZOOXhTSGpEZTJn?=
 =?utf-8?B?SnU4QUlxM3JUeGhsVFNmbDdET0djY3M4MDRjZmFwVG1CWnNNS2V4b3Y0MC8x?=
 =?utf-8?B?c1Z1U216VkwyR2ovSlRIU3NLTTlnZ3E4WnpjWXE5U3UzMjA4cU1qRWM3K0M3?=
 =?utf-8?B?akFhTDQ5RTN4Q2VCUDV3RkI3QlpXZ1Fla3Z6SHRKMzNadmtWSDViZG1hanVM?=
 =?utf-8?B?QTBkSVhRTmNwUmU5MnUrTGlrcitjb09PelptSURLTFc0dHVxTHZoMVhlOEJs?=
 =?utf-8?B?c0N3V01BT21CeVIwazNvU3U3QUJhTHVKL1JERHBZTEJNVWE3cnd1aXZFQzNn?=
 =?utf-8?B?NWFWRFdtMFdONkJhN09ZcnJYZ2svcjN5cFR6UVp2bFFvSXJiSm1MbEhwUUll?=
 =?utf-8?B?bFE1RkV6dkRBV014YmZQUVVBQXczOWk4OGtNQm9tOGw0dnhzRzBERkdJZVZ1?=
 =?utf-8?B?eGFza2JCcW1QVk5lMEdDclA4UUdjQWJCSUVOd0JkVG1tZnoxQ1QreDZ1ZGg1?=
 =?utf-8?B?QlJSdUlvNGw1WjlEdXBGZkFockJqb3pHcDZEM3JyMnU3ZmlUUmx0dEErV201?=
 =?utf-8?B?U05RMWxHQmw0VWQ0T0xmeGxIMW1BVkxJZW9YWng0Q2pGV3dEZmRCbmRxbHlB?=
 =?utf-8?B?YUZVWjBHMTZMRWxCaHh2bVVYUHVKZEttSVFzc1ZNRC80V3h4a1BvZmxJMzFM?=
 =?utf-8?B?UHNzb3I2R3ViK1laN2FMMHQ3c3VsK0VheFYwSERzWWU5L0pkSXNXUDFYUzEx?=
 =?utf-8?B?S2NKZ0lmVkE2Y0tVL1JoTFNUM3JtRHkzSGswaDdlZjFZOTBkK09Zdm1TTUl1?=
 =?utf-8?B?OVhQL21iUXRQR3M5MGl3bXlaWGhKUjlRZkxtVmNvdFo3ejM5eHUyc3JOS3Mw?=
 =?utf-8?B?QWN5dlpwbDdFZ0txSmF4KzEvYzROSi9qWEg4Wm5sSEZzNDh5VWdhVXhxSWNl?=
 =?utf-8?B?M25mbkY3NnhzUlFURGhXZkNTS05udkx0UXozRUxpYW5RdDg2VUhlYi91bXpV?=
 =?utf-8?B?bmkyUURSSlI1Nzd1ME90OTlXbGJ0b2VSeEtlR2paL2FEVWVNZ1dyMVBYRUo4?=
 =?utf-8?B?K1dxZGpORFRITmZ1YjZ0UjVSMnk3UWxpcFYxcjhaMjU1cVVtTkErWmQvWHZC?=
 =?utf-8?B?Y1k5ZnM0ZVdkR3VUSlJxZkFSZUNkOEZOR1Y4K2RJT2QxWDhmT0xFRUJSQ1li?=
 =?utf-8?B?amNRRDR4Qk5vT3JnNFdGS3pwdEpPS0NYQk5CWWRKOW4ybjFvKy9yVklYaWxD?=
 =?utf-8?B?WG5JT2cwZ3BzZzQ2YUpQZlJlMlRHNUttdHY0d0dUeUkrR1gzb25GSU5Fd2Ji?=
 =?utf-8?B?QXhZa204dGxjTWxJZ2dPd1ZldGFRYlY3UzhQeHJwSCtYUXpXT0VHQUJETmJt?=
 =?utf-8?B?eHc2elM0Q2tyTlg1bVZGUmFLMnVOTmtlWDNBQm1JSmNkWmVaQUMweFVPSlNW?=
 =?utf-8?B?Y1RlZEdpT0FmalpzS2MwMTduODV6ai8vTUlBUzVsUzZnajFvMFlYS2g5MEQ4?=
 =?utf-8?B?a3ZNOHdOQk4wVHpuemZ4aUcyUEFCVFoxVkVBdXZ6RGNsbm16MlkyQUthZUNE?=
 =?utf-8?B?S0VUVHZQdWFvY3RlY0NiUWRJYlJRZS9kR3NWTnVGWUluaUVJaUh6ZFBBVTFG?=
 =?utf-8?B?Z1RGL0ZUeVBkK3FRMUtWRDNqL2k2a0hoUUFMN1hYSkVIL0NwQkEyTlFORDBS?=
 =?utf-8?B?UWxkNGpTcTIzRG5QdU9iOHNkaE1uTkFxZzN0QzlUakpYUnJtdnViTm9rLzdU?=
 =?utf-8?B?ZkF3ajNLa1lKR1p3MEE0U1REOTRJcU1pNk1lQjdWZEZKRzdqaUZ2L2J1Rzdh?=
 =?utf-8?B?V3AzdTkzMmtmZ0lqOVVidmlRd2NkNFhPWjBSanVHbE9zeFo0YXo5Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b33bbd1-1de7-404a-0da5-08de9fa12f73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:17.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwL/j4hSX2K/WRGA6mn4Km72/2wBtZHaLtNdYMQkNZU1o8yUIccdkJUUjeNgicLJNSkTDUiOBWEnjQ1ME/GN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

This board does not have any code to call legacy power API, so drop the
selection of CONFIG_SPL_POWER_LEGACY.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/pico-imx8mq_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index b97bd682c1b..2567c5b4715 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -85,7 +85,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y

-- 
2.51.0

