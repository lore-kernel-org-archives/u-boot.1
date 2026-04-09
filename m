Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CD1EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 162E984120;
	Thu,  9 Apr 2026 13:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WbSzcMtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AA184118; Thu,  9 Apr 2026 13:39:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061A284118
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct1YBqVLi00x4KMk+XkIAs4ORtfML0xg4BZAlbNf/LAu4KlsCZ2N7uumUdu0IRCpDV2Lnso50qAmO8bXmYFObakDZTVIdwsM65TC7mdzpAH1XYWYIseiVMQXs09KO+2FO9JZJuOfoktWQkQpypR1mw4hMlDxrq8Nc0Mx3E/iV31b4DE7YnxCoc/MPdP4IOQJWgNPy+05Quw6eVpeJXXTS2FEjveZQ7TsD6776uq9ZxOUJyX6PuxEaT1eeGVG9CizVSfli0iAyPmT4pknz0jC7U4rs7FRtXkrPAiUW+qvyEmSxy9fdm7Oqj7W+kk6fvRnuLND/CSX5jR0ban0ZHXlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+P3IK9sn7hF8hXuIwMWsSFUMkAUaqr8cb6NA6Lgaco=;
 b=jWB/yhAZTY4g0j6CChzJa7iPA1Ow4+QDgaqab8J0Kt81E6QbqMmPwVc0KpsWMm0BUHwgbxmlqyQt47CjnAoiF5EE1qa4xIH4yTnHqb53UX9Sxt+kERYq3mVdnq/k6KP8YZHWwhfE3Q382dZKHFfUMNR0QTBTUcg7dZ/tyBCqAioZDFydb/L2hBX01XzhEyrBLPevQUTXvbXnKIZfgwtQ2qQFfIMTMbEkCuX47XZYmYIiS6OMQlbFP0vFEalu8sXKzBt1pYpH6py9oY5Juru/MF3wVtHSU0ye/vhNnsj8dAa1qQuhO8h1TbsJaTFKJ8/s0T3Dttonqv9QSpM/jHrxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+P3IK9sn7hF8hXuIwMWsSFUMkAUaqr8cb6NA6Lgaco=;
 b=WbSzcMtFU2P2ZD07r23muuqt//nSLY3a5WtqFeCxZdpPpa5Z/uHO6vMITDNkaJuISJnUNDkzSZo+d5xaxvC/9R6jBRj4vBhlNiLLFghLx+QU+69j+fEWAg9gpjTnCkdYPwfaHQ61d9GSDOhoTtmHn0maz+CeyP7N+3qZtcVF9wysZjatNShF1UsOKikdf+jOdb9PDVuHJJFRup+6l8lJuVAITmU/isg5KDBThUW2dpCXmUseXlgeA9Goh45t+SuIsOx4rbkulteNpL9irvMjf/GYr/hLZSxzz1uGSGcwmKCyxk6s7Pl8j/Wf7goDdti3AMlGXz0/TMzGTYSDzOWpWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 11:39:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 11:39:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rui Miguel Silva <rui.silva@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] gpio: scmi: Add gpio_scmi driver
Date: Thu,  9 Apr 2026 20:55:45 +0800
Message-ID: <177573926836.4193161.9920900798883677678.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ff0756d9a26c95540fb65a35765e9a43949a5814.1774350851.git.dan.carpenter@linaro.org>
References: <ff0756d9a26c95540fb65a35765e9a43949a5814.1774350851.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 996b747a-b26f-4e7b-2526-08de962cb6b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|7416014|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E8GTjn7wsfOHYazlnJ+oI7442EnuARA3V+IFel5qOlBFur+0ZJSFNAP/lAlF0KUChOKoKLrB7YBfd4QytqoEfrxXhqX6yUpzR2aSy8Hntap9ywi3LfdWvLDSS9LAwHDaKHxPLoAmcMS+O0hjJKETQzjjDgq/EqG/5dYnzLBzq+AG/X6f+Dpu912ImctwJSZVVXSkkmL3QMAtS4AMjd2SLvwKpvDoSfVrprX3XbedpbYw1xKStF1wLiYfKhPHaa2YKoY0NCpgc9fnfbJlJp4RQ4bTLuaN0oz3FKtmX3hUSZmLj2ZkZ0lTLOfuVgmV2QuTbkInkCykm5F/Ucvvaj/M67gni1H2YBkaUml1IBixsdqJu7AyuDhxOVpHS/8n1eub1nVBZDjzi4jPtd+R33evftpvWzwH865UltiYYmcGxLoyoZwnSKgInZQHdx3bwNnQ6gi8wTIEhOki/auwP5syi4elEYJmbxOU9/qx5xPIL9aw/LjxXznZOXIdPgrgriCGllV5Hbfmxe6NEmeffPZ9mzcaLbnZpHNNe+dpzVunieaY/NOn/s1eEBmjVNYDJQzjMOTLHt/bsKfYIzX5bMbOxFhd8duBEGOAo49Q78eL4ZVYqia1l1Gt1e4VbRY2j3vPLm9qsQfS8Ra2n6MG/Bbj1URSSzpGf8dqsd21yzIvKkKAxMI+KovL0c+ZY63VxsOvmeBUAYS6yB+veN3VjQMauatKgne7ycKtR8RwaDRjWuou3bJ4JSgciLyIURDWRyu+GqhmnlkgSwzsRwBR71VdTlz800YgkYgtfgRwUTXKdlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(7416014)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNrbm11ZENwQ1E4VFg2SjBXc0dRSzhBVytqdkRwYnRUSysvK0Nnbm5MaGVp?=
 =?utf-8?B?ajhjRkVSUUswUlExMEhKb0hYRUN4QkR4R1lQMUozaUw5WUpPMDJoSWtwVnk4?=
 =?utf-8?B?MEpxU1dyK0dnOXU5VktzUWtvK3dEMUdQbzZMZVlKRzhWUlI2OWxuY1A2Z2JS?=
 =?utf-8?B?SVRhVzBPbGZETTBnNUc0TWRITTZFMUJUT2NmdEU5NE9WSkZnSHVxczdhR2RU?=
 =?utf-8?B?UlU0eDk2L3plNDJRc3lsSWdza1c2QkdHT1pybXVsNmVjbWpqTlp1ZjAxSmF6?=
 =?utf-8?B?Z2xLdzNCRFdkR3NJVmwyb3dlQ1MzNWp6QkZvNFloUFFQdytWMW1aSmljWjI4?=
 =?utf-8?B?SHU4eDVYL0Jidm52TENvM2U5aVkyMHdaK0swRG1tdWNHKzNRRHZKQncvWGht?=
 =?utf-8?B?OFlkUFpCcDhTZ0JGKzFhVEE4bWZ3cEY3bXlnV2NlWVp4QmFvZU5ZWGlnTVBD?=
 =?utf-8?B?aVZoZHpjdFc1ZDJDL0lLRnRBeC9PNkFVN2RJN0xqUWp3amxPMEF4MTFZYTdm?=
 =?utf-8?B?Ym1uNFpjU09QWlBoUFp2WjRrZUFJdnFXUDBxcnkxZzVOc1EvMWlwd2N3RnF0?=
 =?utf-8?B?bGZLbUNJR3A1L1JmT0hwT28rTCtyTlR6anZxcWdHMVoxYWxTT2lmaGVXSlBp?=
 =?utf-8?B?cEhvNEExd2ZUN1VKNFVOd2hqWWZMZW5PZk9hdWpSV21LNGNzZnNrRjB6UmVD?=
 =?utf-8?B?WEREYyt2b3B1OEVrSjdBZWxaeWlaSGtMS2NJVEMzeEhvblEwcEFmWHk4aitm?=
 =?utf-8?B?dTJYMUZFSklyVG1VWEkra2srb0pnTkZXdEhGZklsdVlpY1Z4UVNoenBJeWJG?=
 =?utf-8?B?N2ErdFdKZm9aL21raXhmNG54NlFqajNGNURJT3BpeXJjQm5rN3ZDdkk2d1BT?=
 =?utf-8?B?OHU1aHRmQ1BVYWRxTVE2bEdQbDdLczR2eUgrVUFERE9LbXJudzRTLzNUOGZh?=
 =?utf-8?B?UjR1d1NtSTdjRmYwV0lKOTJ6MkpUMlFWOWdxLzdqNFFFTFBYenhYdEtYUDJm?=
 =?utf-8?B?RnhLQU9ZcXg2WU1GRHVsdHFpenlUVjRnc0FjcjlEUnp4ZWZlVUIraDdhaEJn?=
 =?utf-8?B?R0F0WEZxMmZMc0VJUEs2cThBWGFocHJjV01oczhKTmNEUVBvcUVFOG82ZzF4?=
 =?utf-8?B?czl4cnFUV1NSbXgzczFXMDloeitiWDNqTzNqZEo2ZVBZSmNPb2tpeERVM1Zy?=
 =?utf-8?B?VnJTNHdoOUZzR3RyVExHZzh1UldsNldPQTd4NHVIQ1B1Nk4vZUpPYnRyWEd5?=
 =?utf-8?B?cXdhUmN0UXd2bk9nd0lXZUtzTzltZUhDQUN2UTBwNGRpZU16ODIyL0VIZVBu?=
 =?utf-8?B?ZXZjQUJtNXFxYnVxYTN4TnV2WU9YYWJFR2lQVlNnaTBOVVBVaC9uOWo3c0Yy?=
 =?utf-8?B?c2xBTFNka2d0T2RwZlBKOUhUZUpiU29oNXFXZ0hsbWRiaFA5QURJTFdqMFFY?=
 =?utf-8?B?TkdOQ1JDMmJCK2dtelJHMmZ0UmY1ZStsZE51K2pEdWlOTGs4aHJqSER6Q3JE?=
 =?utf-8?B?K3JkQ1VBZFF3OWVURm1ZVU9veFZ3Znc0azdhcXBBVXZ1K09LMTV1Q3NjMllM?=
 =?utf-8?B?TCtDcERjVVMxcmgxTVk0cTJlTHVnNjJGelpWMHJDQzcvcnBJaEs3MzVNN2Rk?=
 =?utf-8?B?emx2SlgraTNob3BHQjdnbFFDZy9vbGVxdFZrUmd6SmQ1OUhwalJ4WVJaYklQ?=
 =?utf-8?B?bnE2SGNyMkFpREN3QTd3cjFyUXd4NlBpckgraHByRDAwNk5uU2h1WDZtbEVD?=
 =?utf-8?B?SnpyZ05GZWp3eHE5VHRIMzB2aFRVRnUxd0NXYnExMEF0TWZaQnhQdW8wZXQ1?=
 =?utf-8?B?d0hDUWV2K3BIY05TWURtcFVpU2FzTmhQZ0FKWVI1d3R3bVRyZndxWldXTXFK?=
 =?utf-8?B?QXU1cTVrSVhFRCsyT1d4NUtYL1VhWUZyczRhRFRodXJteUhZU1Q5QXJyeCtV?=
 =?utf-8?B?blpJdUtYZlNSdVV2cnZLUEZZT2J2a2s0d2FuN0RUeElwbTBJYTUzOGV1VWVs?=
 =?utf-8?B?ZEJtVk1sOTJHdC8wbVAxRXNabWEwRElvaGIzVXNCYVhpNmZjaUtzUmRFWDMz?=
 =?utf-8?B?a25LaHlQRDFTNlM4OUw2WGZCWWRldTZuYUc1MHRsSTFzTHFoS3ptNFh0SmV3?=
 =?utf-8?B?K3ZVTFloQTNlVlF3UWRtOTlsNlAzbTRLbDNXcWxlTm1NdkFPZjFOUGRXS1V1?=
 =?utf-8?B?MjloZjI2TCsvdWN1Z0R3ZHlwYmgwUzBVZ1BFTHpiK0MwajdTNGxLanM2bzRJ?=
 =?utf-8?B?RHRpZ2FGM0ZhYktKZVh3ZkRFT1VoaDkxa1NucSs3NEpvY3pYSjNsU1dia3hs?=
 =?utf-8?B?Y05WTkdvRlliRis2MzlHYVQ3MVA5ZWFnWnJ2VnRvYXpKcXJacFlpdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996b747a-b26f-4e7b-2526-08de962cb6b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:39:52.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8euqtwWSJbR9tuku37DYNHgAU97gxcCElnnd8fYsTySF/NLxVETN0qj4SRJ15kjBmzr96xWZZbF3JyShGhxNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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


On Tue, 24 Mar 2026 14:16:56 +0300, Dan Carpenter wrote:
> This provides GPIO support over SCMI.  It is built on top of the
> pinctrl-scmi driver.  A typical device tree entry might look like
> this:
> 
>     gpio1 {
>         compatible = "scmi-pinctrl-gpio";
>         gpio-controller;
>         #gpio-cells = <2>;
>         ngpios = <10>;
>         gpio-ranges = <&scmi_pinctrl 0 8 4>,
>                       <&scmi_pinctrl 4 12 1>,
>                       <&scmi_pinctrl 5 15 1>,
>                       <&scmi_pinctrl 6 17 4>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c2_pins>;
>     };
> 
> [...]

Applied to fsl-qoriq-for-2026.07-rc1, thanks!

[1/1] gpio: scmi: Add gpio_scmi driver
      commit: af7b6bb05a810a0ec94fd864e3477401b3d1b60a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
