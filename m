Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1158EF8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A07842CD;
	Tue, 21 Apr 2026 14:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gnb5VtT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DF98426E; Tue, 21 Apr 2026 14:26:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF8D801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbGHNGHZhtG1JP9pmd8N9Bo3kU7dQwwBJAh4ruCiFdGzsal3b3Oul+6j+IgiJy6Pz71En4dTRPKXRhPAIKugX35NWKrxS7iIOrjjWs6q4ZWK6XpYffBxITH5OhxJRbTq/Sh060pbjHTOpL67bnZHsifm1lmDDuDc+g66tsKwNbAZ4Mqk+THW6VJ+BWBehEYZ4GvhRhBbKJ/6v7patn9RaMnNBx5VjG8r75aK6qc45HCmRHsg6/HalKiRzTT6s2198NWE5UdIy+Kqt8K5LjTCfyCal7C6HLuK9EgqcRkwOpxJqpuABqjaK47OSLQXqvM+lWvsqg/YvN9ijENf8uZu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJYisP5ovy4oECp9Di5amLk/e3tPVxnNruAGOWyUg4I=;
 b=GCqp1ma5u9PyhQ7dYa3ZEHX18C1a1JYede7nVmnRQ3hqZptUtDo21HlfQEV1fYKhsgmLbGuRYFIJPFBkqLtoVgQn8XntCIgIIWdEiCSZLHBErOXJL6JOdep+gVP7Xz5HQriBK2ua6bz0LFl0emrKohoTbkyM2cE/roYbXAiehmXydhn0wwydrqnnk2fT6KceUKnIaDd9xjgQtMD7blBxQdrocW/V3GAISO3kzRu85w3uzZNSBoCIKXh6QpKOGPE129GFXe/d5PTkExyMg2f4LyMDB84hNx2Qx5sqzNtQdIYjHJmvwO/nl5vf3eHGJrpKqP9avc6+UVi0FcolU5UJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJYisP5ovy4oECp9Di5amLk/e3tPVxnNruAGOWyUg4I=;
 b=gnb5VtT5PDTJIFGEMh/ph/Xpk7gjJYvH6tf8TgS0PhzIWyE8J3IrkcrrSa1H5N0vW/lml3Ir32OHJDhoYEdpG7kOFCGu44JfIHVovYcIbQaTdgd3yWqU5X1aRlT1fIRQA3lfE0PovV8CbpTBYGJhAatolz+9JPH3zNON7QyOvN88rR0EbCpxncMFYRoSQ/xPO9ICMJViNpf3PPiMJ1l+KN24i/HH4z0ZBZF5Wlz0XcLg1cEzoMCUXn493tCUw2thDUV+96ggelyuwQ85R8NsFtwMGWcY/cf5agsYzlLOMruHySGkTH1VaglWQLmIhYHt2zKAqM/aWRXYu237oR8NHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:26:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:26 +0800
Subject: [PATCH 14/15] imx8mq: kontron: migrate PITX-IMX8M to DM PMIC framework
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-14-0e2b490542b1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17a6262d-e24f-44eb-deeb-08de9fa13336
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info: SZC/VX1dl6m6+mi4xayAHlYOwsoO7PujqX6IxET/oucZQIsW1256SMQ6fhP6CzOE9IWEhcx8Nc5yBITa/eGnkdJp6tyaEKm6JMn4k0VqdQ7H8TAq+DTvjb4Fg7jufslJnmPs4kJY8EBEEYDihlKAR5fSJeWY9lkbHuFC7XoZQNx1Ae4jYibehgDzA1IOF27MDWqjgCpx7G1FeIyYSAv2rPMsXSCzyxxgjtJqMrway0MOVXKN6dwCAlIN3RNrArr0OrFvAlsi5xUrfl0c3Y59DsZ/WyChlkX2Z7h+zKLefDuznRqCLcHcZ72WcLAZiStFMpWTdbPcuV2aIBKGwxvuWx2QJrFm+k7mE//FFsHOaODP5+vM+Ib3ZIEPWNuKfR0hKF0iit2/tORMpxBb1n/HCQo+D6Ks4mip2twbtsCmbsTW3Fw18q6LdC7Qq7qd0013VfDZTEDyojtsNnZXZlbFg28zt4c+kRg29zEoEahj9rDgMdtiV+gQORD9sHFSmoqm0TUg7vUlhhbyJWTtGhB+KhHjvP26jEHOXKjhCh2ZHccwnhcYVlZPsnGWjKJTlBr75/PmBfd4ApoGS/url6YcveEe447uFMWc/Y6PiLYFh2RNuw8zyj6apO8KHYSV2B0bfZxzlORz4EfzSD5BBdfH8JrW1JzZYK2Spw4mKgNaZpspeX0psKXH3G73/tFP23cVsLG7ykQA4kpkgvUbiwyUgJgFX6fBvVDj7bu5SyHbXufxaIM9kjjkNfIPS0+93eHGqnttokpbJ3vn929O35D57v5yaXqDsip1CbnwWqmei7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FkRFRSNDhpMURueDhtdmtib3plTngvVk9YcjFmekJoZ2pORklxbTMraitP?=
 =?utf-8?B?cy9OYmpuQjJDS2J6SmsyenFMY1k5eTBxeW1qRENqbncyOUl2cUFCVWJBU1NQ?=
 =?utf-8?B?VjdkZEd4dXhic282aUw0U0ZqRjFrK2NHcnI0YW1SK3JRYmgzbFE5Ry91cnB3?=
 =?utf-8?B?K2JmTmM0bkJqakd3cTVxRkVvalRqQWVISjRFSTIwcENGNG1JYzFvNlNlMmlY?=
 =?utf-8?B?MmxsYnIzRk1yVWVyQmJOSVA1dENwWUp1TkZwdG51dUZrVGpnTDVpUEdOcUdr?=
 =?utf-8?B?dVdOUllPb1cwMGJ0WE1Sc3FGUkQrSjgxVkpFR3FiUFpySGpsWHJEVDhPOGQ2?=
 =?utf-8?B?U2R6TnRoR0FWOUpXU1g4cEdvL0FGT3lsa3RSb2tBSFlpSkRMVndvUjNiQ085?=
 =?utf-8?B?NzVnd0VjbDBBcnBmVmpXSGl2Um1hUm53bUttMFUvb3VkZThVbmZKbGllTTdv?=
 =?utf-8?B?TGs3UlJReHVtTEdqNmtXM092cmlVYVUxZSt0S2RYU1Y2WC9CcjBIRTdTaEZ2?=
 =?utf-8?B?NlZQNHErQW9PWHg3UzBiZ1RRQjc1RFZZSU9nOHZzby96KzJxQWRLYlFMS050?=
 =?utf-8?B?WDdTNWVXNm1LS0RnYkZ2S2pPa1RrSmx1QXlXM2ZSaUNFWHVwT3FmaWxCWGtx?=
 =?utf-8?B?SXZMMGpqUzk4OVljbGJTZEl0cXNLSXBvd3F5WEc2Q3I4REVaTDVUdkZEMmtN?=
 =?utf-8?B?cy96Y1huN3V0b1JJK3p0ZmVKQXdoeUttYVkrb3hjcVo3WVA0VUp4VDQ5ZEVq?=
 =?utf-8?B?b1BDakxQVm53dnM3UCtobmZNYnBXSGdGODErQXUrUEtOZHdiUWVpeHhJQ2Yv?=
 =?utf-8?B?RjR4dmRCSG8rQysrem1PdmpVVHR5Nkk3ZFRwWjFhSmFDSWUxanpCejhCMlR5?=
 =?utf-8?B?d0FrYWVRUEUyb283Wi80TUpETUxSSzkyQ0h0TmZoWXYyeEtZS0lHWGZRQ01u?=
 =?utf-8?B?c3kvM3lvV0I3RFhKcjlYSVhsZjJXNS9ZNDVtejJ5UDc0N3pwWmR0WnM2cSs3?=
 =?utf-8?B?N3RYbTFpM3YyYjMxYU9YdjNpL1JIQmRZKzFVVGwyYXRFWHM1UnVKbGdueVJY?=
 =?utf-8?B?c3JmYTJZR3dLVjV4MU15d21WUXFXbDkwQ1Vnc1F1NmVyWDRZUWphcExKMFVr?=
 =?utf-8?B?MllyUHBaZnhmSURKTXhaRmlmcG9lWU9xb0ZRM3lGZ1pqWGlDMjA3U2lxSm9Q?=
 =?utf-8?B?UWQ1WnF4RTdVRVdiYjUzNmw2dXgxS2EwWnhRaHVXRFFQMXlrR3ppbWRZenJE?=
 =?utf-8?B?aWdPS0ZETmdzZjl0R1crTW9tdk5mQTd6Z0VLWkpPeVFkTHE0QmdTek9sem8w?=
 =?utf-8?B?T3JHRzY2eG9iZ2dSUXNMcGg3a3BNZWdEY0tLMWo1UlE0cStXV0ROYWpBNlVv?=
 =?utf-8?B?R2UxNk53ZkQ1YWhmTUFGazlYRmNtcjNGdHJLZk1HbUJTbHJ1akt6UUNxcEtW?=
 =?utf-8?B?VUJJNUowY2xORTdMU1dlU2d1OFg2RmFzSHp1S2EwV0hQdXdycEdSZ3NxeVB3?=
 =?utf-8?B?UEJ0eVQwYkxVZmZJVkdrNVo3eEtjNCtOMTMwRjRYTDVDRU5jRStuL21zNzdI?=
 =?utf-8?B?eThVQVcwaVlpSno0VUNCQ1pLY1VXNEtwZkhaZzh0RUNhZXlzOW1tbkQ5cjZO?=
 =?utf-8?B?Q3V4SzUweFBJUVo4VXpRL0F6dzhEZVVRNWV4QTFUR1BjTy9GQVF0KzRBOXZm?=
 =?utf-8?B?aTN1dHNuMCtoNWVQMkt4aUk1UHpiYW8rM1djNUxnN20zQUpyZ0sxdFZRcS9O?=
 =?utf-8?B?b3YySDNTZkVrazg0NEo5VFRGcXBKMWpLT3N5U0cyTlYxd28wMUdoRW9KZ2xV?=
 =?utf-8?B?OXduck41REFqMUNta0ZRWktFM0FTelU0a3R2MUMrL2NxZDBVMllYZzU0NmV5?=
 =?utf-8?B?QXh6cWl3UFVQZXV3R3hWOC9KeFVOSDBkZTRzZDFoUnBiRDczV0pyOHg0OHRL?=
 =?utf-8?B?ajJRUDNBcldCRTQ0bWtISWZvYnpvQnRsb0lDZi9KM1g3U25KT21PY2xSYW1z?=
 =?utf-8?B?QWRaOFlYeG5qdWdvT3BKeUJuVzFVL3d6eTlnRW9FTXR4RjRBVk9BOEdRaHFa?=
 =?utf-8?B?R20rR0MzbldBSmNKcnNLaGY0UFpBTGxUSG1jSlJydzJwRFRmTSsrVFdjVGFZ?=
 =?utf-8?B?ZVppMjBNSmx4UVVsVUdKNUNZblc2MjFLUHF3NU9EeWtIOExuZ09yTndWZGdo?=
 =?utf-8?B?dzhVOXVzUFVmdXdYT1V1aEt4V1VGZUxBUkwyNjZIYUZ4ck5EYzZ1WTVpR3Ey?=
 =?utf-8?B?alZzT3ZTNzZaT1N4STZJOUR6TU5FaEJGT1Aydk9uNkpWck5jRmNUTFJNd3JR?=
 =?utf-8?B?M0JTbGJ1SnFjMDE5N0tDUWd3K1Q0NDJ3R0p2TUEzMU1MVFZKUVRGQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a6262d-e24f-44eb-deeb-08de9fa13336
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:23.3108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rf1VYAUGi2VQDt1fFaBhtAAes3IDbI58wyKRe6er1ZK5xE+YdAxnIPci4mEYsN32jqpZMj11m+8RFbQWj51AQ==
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

Migrate the Kontron PITX-IMX8M board from the legacy power framework
to the DM PMIC infrastructure.

The SPL power initialization is converted to use DM_PMIC_PFUZE100,
dropping all legacy I2C, GPIO, pinmux, and MMC setup code that is
now handled through the device tree and driver model instead.

Key changes:
- Switch PFUZE100 access to DM PMIC APIs
- Enable SPL OF_CONTROL and mark required nodes with bootph*
- Remove legacy I2C and power configuration
- Enable SPL DM, pinctrl, regulator, and PMIC support
- Adjust SPL stack placement for DM usage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi |  64 +++++++
 board/kontron/pitx_imx8m/spl.c                     | 184 ++++-----------------
 configs/kontron_pitx_imx8m_defconfig               |  16 +-
 3 files changed, 100 insertions(+), 164 deletions(-)

diff --git a/arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi b/arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi
index d361f3f5592..7ab7706d7a7 100644
--- a/arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi
@@ -2,26 +2,90 @@
 
 #include "imx8mq-u-boot.dtsi"
 
+&aips1 {
+	bootph-all;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&i2c1 {
+	bootph-all;
+};
+
+&soc {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@8} {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@8/regulators} {
+	bootph-all;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&uart1 {
+	bootph-pre-ram;
+};
+
 &usdhc1 {
+	bootph-pre-ram;
 	mmc-hs400-1_8v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
 };
 
 &usdhc2 {
+	bootph-pre-ram;
 	sd-uhs-sdr104;
 	sd-uhs-ddr50;
 };
 
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
 &uart1 {
+	bootph-pre-ram;
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 };
 
 &uart2 {
+	bootph-pre-ram;
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 };
 
 &uart3 {
+	bootph-pre-ram;
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 };
diff --git a/board/kontron/pitx_imx8m/spl.c b/board/kontron/pitx_imx8m/spl.c
index b9e864d3f05..0396967fe36 100644
--- a/board/kontron/pitx_imx8m/spl.c
+++ b/board/kontron/pitx_imx8m/spl.c
@@ -2,21 +2,14 @@
 
 #include <config.h>
 #include <errno.h>
-#include <fsl_esdhc_imx.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <spl.h>
 #include <asm/arch/ddr.h>
-#include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/io.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/sections.h>
-#include <linux/delay.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
 
@@ -50,120 +43,6 @@ static void spl_dram_init(void)
 	ddr_init(dram_timing);
 }
 
-#define I2C_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-static struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = IMX8MQ_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = IMX8MQ_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = IMX8MQ_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = IMX8MQ_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
-#if CONFIG_IS_ENABLED(MMC)
-#define USDHC2_CD_GPIO	IMX_GPIO_NR(2, 12)
-#define USDHC1_PWR_GPIO IMX_GPIO_NR(2, 10)
-#define USDHC2_PWR_GPIO IMX_GPIO_NR(2, 19)
-
-int board_mmc_getcd(struct mmc *mmc)
-{
-	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
-
-	switch (cfg->esdhc_base) {
-	case USDHC1_BASE_ADDR:
-		/* the eMMC does not have a CD pin */
-		return 1;
-	case USDHC2_BASE_ADDR:
-		return !gpio_get_value(USDHC2_CD_GPIO);
-	}
-
-	return 0;
-}
-
-#define USDHC_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | \
-			 PAD_CTL_FSEL2)
-#define USDHC_GPIO_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_DSE1)
-
-static iomux_v3_cfg_t const usdhc1_pads[] = {
-	IMX8MQ_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_CMD__USDHC1_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA0__USDHC1_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA1__USDHC1_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA2__USDHC1_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA3__USDHC1_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA4__USDHC1_DATA4 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA5__USDHC1_DATA5 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA6__USDHC1_DATA6 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA7__USDHC1_DATA7 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_RESET_B__GPIO2_IO10 | MUX_PAD_CTRL(NO_PAD_CTRL),
-};
-
-static iomux_v3_cfg_t const usdhc2_pads[] = {
-	IMX8MQ_PAD_SD2_CLK__USDHC2_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CMD__USDHC2_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA0__USDHC2_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA1__USDHC2_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA2__USDHC2_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0x16 */
-	IMX8MQ_PAD_SD2_DATA3__USDHC2_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CD_B__GPIO2_IO12 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-	IMX8MQ_PAD_SD2_RESET_B__GPIO2_IO19 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-};
-
-static struct fsl_esdhc_cfg usdhc_cfg[2] = {
-	{USDHC1_BASE_ADDR, 0, 8},
-	{USDHC2_BASE_ADDR, 0, 4},
-};
-
-int board_mmc_init(struct bd_info *bis)
-{
-	int i, ret;
-	/*
-	 * According to the board_mmc_init() the following map is done:
-	 * (U-Boot device node)    (Physical Port)
-	 * mmc0                    USDHC1
-	 * mmc1                    USDHC2
-	 */
-	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
-		switch (i) {
-		case 0:
-			init_clk_usdhc(0);
-			usdhc_cfg[0].sdhc_clk = mxc_get_clock(USDHC1_CLK_ROOT);
-			imx_iomux_v3_setup_multiple_pads(usdhc1_pads,
-							 ARRAY_SIZE(usdhc1_pads));
-			gpio_request(USDHC1_PWR_GPIO, "usdhc1_reset");
-			gpio_direction_output(USDHC1_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC1_PWR_GPIO, 1);
-			break;
-		case 1:
-			init_clk_usdhc(1);
-			usdhc_cfg[1].sdhc_clk = mxc_get_clock(USDHC2_CLK_ROOT);
-			imx_iomux_v3_setup_multiple_pads(usdhc2_pads,
-							 ARRAY_SIZE(usdhc2_pads));
-			gpio_request(USDHC2_PWR_GPIO, "usdhc2_reset");
-			gpio_direction_output(USDHC2_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC2_PWR_GPIO, 1);
-			break;
-		default:
-			printf("Warning: you configured more USDHC controllers "
-				"(%d) than supported by the board\n", i + 1);
-			return -EINVAL;
-		}
-
-		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 const char *spl_board_loader_name(u32 boot_device)
 {
 	switch (boot_device) {
@@ -175,18 +54,14 @@ const char *spl_board_loader_name(u32 boot_device)
 		return NULL;
 	}
 }
-#endif
-
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
 
-static int pfuze_mode_init(struct pmic *p, u32 mode)
+static int pfuze_mode_init(struct udevice *dev, u32 mode)
 {
 	unsigned char offset, i, switch_num;
 	u32 id;
 	int ret;
 
-	pmic_reg_read(p, PFUZE100_DEVICEID, &id);
+	id = pmic_reg_read(dev, PFUZE100_DEVICEID);
 	id = id & 0xf;
 
 	if (id == 0) {
@@ -200,14 +75,14 @@ static int pfuze_mode_init(struct pmic *p, u32 mode)
 		return -EINVAL;
 	}
 
-	ret = pmic_reg_write(p, PFUZE100_SW1ABMODE, mode);
+	ret = pmic_reg_write(dev, PFUZE100_SW1ABMODE, mode);
 	if (ret < 0) {
 		printf("Set SW1AB mode error!\n");
 		return ret;
 	}
 
 	for (i = 0; i < switch_num - 1; i++) {
-		ret = pmic_reg_write(p, offset + i * SWITCH_SIZE, mode);
+		ret = pmic_reg_write(dev, offset + i * SWITCH_SIZE, mode);
 		if (ret < 0) {
 			printf("Set switch 0x%x mode error!\n",
 			       offset + i * SWITCH_SIZE);
@@ -220,44 +95,45 @@ static int pfuze_mode_init(struct pmic *p, u32 mode)
 
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
+	int reg;
 	int ret;
-	unsigned int reg;
 
-	ret = power_pfuze100_init(I2C_PMIC);
-	if (ret)
-		return -ENODEV;
-
-	p = pmic_get("PFUZE100");
-	ret = pmic_probe(p);
-	if (ret)
-		return -ENODEV;
+	ret = pmic_get("pmic@8", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@8\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
-	pmic_reg_read(p, PFUZE100_SW3AVOL, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW3AVOL);
 	if ((reg & 0x3f) != 0x18) {
 		reg &= ~0x3f;
 		reg |= 0x18;
-		pmic_reg_write(p, PFUZE100_SW3AVOL, reg);
+		pmic_reg_write(dev, PFUZE100_SW3AVOL, reg);
 	}
 
-	ret = pfuze_mode_init(p, APS_PFM);
+	ret = pfuze_mode_init(dev, APS_PFM);
 	if (ret < 0)
 		return ret;
 
 	/* set SW3A standby mode to off */
-	pmic_reg_read(p, PFUZE100_SW3AMODE, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW3AMODE);
 	reg &= ~0xf;
 	reg |= APS_OFF;
-	pmic_reg_write(p, PFUZE100_SW3AMODE, reg);
+	pmic_reg_write(dev, PFUZE100_SW3AMODE, reg);
 
 	return 0;
 }
-#endif
 
 void board_init_f(ulong dummy)
 {
 	int ret;
 
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
 	arch_cpu_init();
 
 	init_uart_clk(2);
@@ -266,26 +142,22 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
-	preloader_console_init();
-
-	/* Clear the BSS. */
-	memset(__bss_start, 0, __bss_end - __bss_start);
-
-	ret = spl_init();
+	ret = spl_early_init();
 	if (ret) {
-		debug("spl_init() failed: %d\n", ret);
+		debug("spl_early_init() failed: %d\n", ret);
 		hang();
 	}
 
-	enable_tzc380();
+	preloader_console_init();
 
-	setup_i2c(0, 100000, 0x7f, &i2c_pad_info1);
+	enable_tzc380();
 
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
 	power_init_board();
-#endif
 
 	spl_dram_init();
 
+	init_clk_usdhc(0);
+	init_clk_usdhc(1);
+
 	board_init_r(NULL, 0);
 }
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 4c0eb48216e..39aeb7bf01c 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x300000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mq-kontron-pitx-imx8m"
 CONFIG_TARGET_KONTRON_PITX_IMX8M=y
@@ -18,7 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x187ff0
+CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x180000
@@ -73,16 +70,17 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
+CONFIG_SPL_DM=y
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -94,15 +92,17 @@ CONFIG_MII=y
 CONFIG_PHY=y
 CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
-CONFIG_POWER_PFUZE100=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PFUZE100=y
+CONFIG_SPL_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_DM_SERIAL=y

-- 
2.51.0

