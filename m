Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036BAC5AC82
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B954780FFD;
	Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PH5j3FedNW8i; Thu,  6 Aug 2026 23:45:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2AF380FE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059905;
	bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fCFHJMOeb1xQy/39Uuxe8o3p6dcwrL8xeBunA/nYMeAjTFeWRokAdCReo1seozvqt
	 NPFagUHLWSR4pafgFQQ2v7Wj7u44MkgdjysyK+3py0MKVVJl2Ksd4Y0xZ5ZLavBvsn
	 q7lnc9QV/pSj9UyYds9jD/IVizf4vIzpsOw/yxcMYoUhHTa5i8BaFm1sPSnW4jgPIq
	 MmYWgafbgTjL7T90G2YSY5UTHwR7wxPWoNO815OJEfu3Vcx4EwKmKiRd3acDPtFHO3
	 r7/Zu2XFxy7AR67Qw8rdFtD+9xEnUzdcJQhqbYAd/45CSSfQtSElPmAWwaMq6yXYFd
	 xBT3YmRo6+1VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2AF380FE8;
	Thu,  6 Aug 2026 23:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07B17218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE24D80FA8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6DLHgyp9zdb for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 47CF180F87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47CF180F87
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47CF180F87
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGdWSPkBmElb9WNt03NeKUjWjrnhJ4c4YwYo2ZU7RUEvozAEgGhbwTu/XZRSk4K0MR2RrTZtukwljrKX/OHovfcIb9D2+NP+aX16+QMqadxNqmtIguzmIVfqnTrH2BlBBXGVPP0zzfJU24gctLQPKYNYFIwYxLtwwmQHSvPBArjWM0VUH75xMVme9X+SB/9Syq5tMSSrxGVyjGcrP0Lj8PPiGIK7ISQ9GtNKS4XJDaa1LYooOsTRxCJGK+781NyPLch8l2MWERNZ9Gv3G+XCZRRYemyd34t6QXOROo73I1E/CJdfaXdtwVNPH9IdptPrN+txg2sSCp0RcytUVYIPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
 b=kI0yM4335rUtMnSOvHyQIh3e3BKHHe1eKKPo8tzCLVRvGA/EREHlQEi2NnLneXtF76wMveQXUwFbyaMd0M1tTcz93LLQtRjsm1pQKUL1enHWDllcdWBGnSwIgYuEwWBWAhvc9Zum/aynYIbNRvgCLWGXeaGermla6Ofj+CgkTH09fwWu/0rNvTVnJ8gUeBeiA5vj+KOwKW8VGVdwuNKKPXsdW3HTd61WiX9YKqCBcbvcFqrmj4ODHC8eB6gtYmL4azY9Pz+CwuIj8xDloZ2KisCMsftyD/WDhprSTtmgYT58c1iSztIXnY1uR7XGnYgDgQI1AX62xD4j0A73PEv7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:52 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 10/16] arm: dts: an7583: add mdio child node to switch node
Date: Fri,  7 Aug 2026 02:44:26 +0300
Message-ID: <20260806234432.4098414-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: c64eed44-2595-4341-41ab-08def414b5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q7F3FXBLsOF1/Z/GOxkfMeNgd1vJSsbp/d4tGEXG21v5akcSjSsYh1MYqjvohVvvzzRTt4BcqgsyRhMEsm3A3dl/uecLiBJqeDKHlL3OBvx/DHA73uaKUwVDX7m6RtknGJA+IeyfEFJEaGpKgEeAGT05ocMc3R4bO2RLVTWRkJWAvdjyYprQWc4pLDeAAV1R2ol3UXyXLknofazpAoIUs2o4BcgLlbanyRzZmx1Qf8mOzniWWTjFaZPhNoA028VCvYmcPKjUcxceIHdwZIrNrGbwD63HjXXKZ5bqDYS42vt0jvy9/dnSG5PaNF2UV/2hSHDJoQVy1rrKkrAlCqllWUNLa9xjWJjHWCrFGf6DQizPSoB0GCRYWasOCQE28kXWbSpnyIKm19O7nblbDFnfug4ddqOBE5sI2zhL9iajed4G0hfcmEgAP/w4WSvvkY1hQPjeQEPPSiVErBlntFchRMndaMxq1uC52mEGZxoCkXKlxEVCPsGkWQXkYcjkJB+0G+6MH+tPE+EdlfGPAuDzFLgqQLo+BNzyxZgG/Ohzk+OLvT2ZAwNLmJssD5J/aTWO3prO2FHAFEbHdfQRjOL8w8OuvDu6UsYswTpH69v+pwUk2bSp33FAvHNsla8/Ztq4PaalRRyPwdpYcgJYCgotqDQPRWBMwa1NNuzjgemYYqHt8ALCHe3oDbX4emfomkc1BdgKONyvEvf5T0vmdWLoPr0T8ZHsU0pWfzpv+LXqaxA3zKdB6C69Gze5h9Pq3Cjq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSseDGXV6xzuB7DXQW8n9ioo7N6V5DVO95GRtSo3pQxp6AAfZ/IfcVG4+kX1?=
 =?us-ascii?Q?if5zK9qlcV0nYJeQKN4/IpNBVodHAkKNq3wExpXch6jvA834xDjbGuK5YBu6?=
 =?us-ascii?Q?pG1LycL/wbUMyHl3oqaOFap2ENOfUJqzH9lgD3QdAnQ1NyNQy6RSVGKmXbLm?=
 =?us-ascii?Q?AlcynSITFokkyUH60HjO20sDSZZPZoT7YcRbJgSkTdTt+woew2gYZdm0rBXA?=
 =?us-ascii?Q?/ARbEHvE3W0sxCp7kwzBIU1L2yqKw8p2yHFrSCRzgqgzsA4oAUTl0vKdwYDr?=
 =?us-ascii?Q?Y98q38S+zFR/1rCSNdG5mTm2zhfnow481qPVcYrBY3OQboqJb9yaBgUNRlzL?=
 =?us-ascii?Q?MngKrGe47r92r9qzzE4vMDJAWGJRc3+2RAAUqEogrb4OxTNjytywHnClgg5s?=
 =?us-ascii?Q?cv8EKN25syy71Smw56NSoMKK3Jjt8K7lyowmgP33X0jXuRBFW/YoOvgRvOQp?=
 =?us-ascii?Q?7aDz9pR9Z/IDLTCsim076k7NAUC4FOZJQPW9UZAa/T59RR6Y1i5Fj++d+IbJ?=
 =?us-ascii?Q?P7Ntqacf1M9GOERWAumh8EzOBtBf50FmRIfvwjRZ6Jukhx2ItsydY20ntF6D?=
 =?us-ascii?Q?jhANkG42lM+zOHpo9oSjonR+aLJuOf920aAlFuetbRWV3xbxxfQB0a+gYZCE?=
 =?us-ascii?Q?RolX7DvwRYLKFzoiPFgQptHJVDuCy78t2FEYE9zf6hB/L6CDa4wWuQOIccYF?=
 =?us-ascii?Q?ubstx6bTZwDwy6bHSn+6Grp2EomrQPDYgIZuv98206VM5olkgcvrqwr/L0Wl?=
 =?us-ascii?Q?bu5jCRyrtzZLuAvKPNAxFRV+4i5zdHZUa9B+tRIpvAT/pU7RPyQsHjSn4orP?=
 =?us-ascii?Q?y62wb0vQZg1neQZhmwkbykFyznsgOp5sVQtPZ95vNxIzOrBWIfmKqFUUAQkG?=
 =?us-ascii?Q?cgMkm+h/eaYDGSZ7fvOHF+uieUsUb4Z35tQNTo/rhLQ9ZhJ5Y6Wtmr2gttJV?=
 =?us-ascii?Q?15E3FWpDMDOHdKsd8rnP0YzwNcwZkdCDIOUeKQOBGenYFNzqXbTAT8Hk8Ofh?=
 =?us-ascii?Q?TAr3MiUXVu8OGLpHLlOzHPDj6Vn/90CmM19hkcoXm6STdlS//Y9D5CXLS/Nn?=
 =?us-ascii?Q?dcIp0n7d5Kdv0wM2UfCKds81zfyMXbzA4XmPnuro72rNtWgQpHgqCj58qe+5?=
 =?us-ascii?Q?tdYSgkZqAxKxYMTklLHpDJdrC1sa8/n9rsY444UJqyA0zAfPiFnqJXA1j7o6?=
 =?us-ascii?Q?uhqjySml/t21LJdNW5ACZTlS54jBi38h/wYjTzTgBeVGJOXAvhZtuylPgVV8?=
 =?us-ascii?Q?yhWCCDI4+AB/NXFNIJi3zhYC2nUM0qhzKEW4Hg8Y4bl+s6teL6JxrgfkL9cQ?=
 =?us-ascii?Q?8gcfK0dTTCJRNqd7s7HiWrriTyjoX6o6kRpPHNn99jn5Ivq2dmkUgN0vpbUm?=
 =?us-ascii?Q?53ontTqqzINnQGu4yXa/dtcZSi/YFJbWaoe9v1XkS2/9toCaVri7spZo8ijS?=
 =?us-ascii?Q?EQ4Wq1/UJ/3Rh1Ga0d8ObFCSIQTB93XinMG6sbQRWKHwyhr4naHyUWzgeOj+?=
 =?us-ascii?Q?Yor9p15PDDdQY5V72XX7sAQWPv00RVmrRkrNGOb9U8s4UK1WK8kGeyMztWGX?=
 =?us-ascii?Q?cSzc3sed/S0u7FCmx0WAOlVdbNBswWs7VohoDbfrB+KWsH7yvytKARTfoxC8?=
 =?us-ascii?Q?HvFVEkJvCftOpO9QpWHfJknDlNiE+FPAi5X+ehumdJCrxcTYyJFoiGrEnbCt?=
 =?us-ascii?Q?g4CmqD2JOSOGgrxgj+MmHtglUa6NyIOKW2oi/Q6wqASdotg50laRoHrt6kro?=
 =?us-ascii?Q?ptNdT+Dlsoinras16VtobKOQCaTW5WE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c64eed44-2595-4341-41ab-08def414b5ad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:51.9455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1hJQ7qwNZHYPWQ04jBMglxiN4uecvD6LBHjot/jz9IlZd2/ru92/A9UidYlchfh6HS63ZODC7cILE5ZKWZzFKLgiD6SisOYwK6o7i9elog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
 b=P5RJxtzEkMtNKVw/8HAfgwodeX/6sjtksTsX6eNzYylzowSMM64vYTkN9ZNCEAc/61OK6ruxv8/oYQ8rLfd12P9QdwY5Z5HsWeOtutSB7GOQQsw7VJ3TtTB3a3jIxvrqA3aPidVjn0srUZV91KBvAswCBWOZEBvBEQcV+AgJrSVL7VFG8mPHzT+Ji63bcAv849qgBHU49V5SAOItDWlYUaKbYNAyg/OMRi4qzb9g0ck4C1Rgbscau1Ia6hX3k2Awx/blNEPcAn2VtfvHRaEsTb4fRQQ4dbvIj7IZJzPhaDfoNzDt+mjNgoVw+bk6Z0b0emRwzWyBcDRZT5xcDjyosQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=P5RJxtzE
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

add mdio node to be able see switch port states

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7583.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index 1a64f48e5f1..ec6eab327db 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -166,6 +166,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,an7583-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		syscon@1fbe3400 {
-- 
2.53.0

