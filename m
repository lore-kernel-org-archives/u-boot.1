Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE11CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB2583B34;
	Sat, 11 Oct 2025 20:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aOW3tsDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF3883E11; Sat, 11 Oct 2025 11:14:58 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A9B83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7CKA0PB1hauMP47sye6NdUz2TosxAL/fDw2KKpQ6hCgPTqVVZqOBWUq31es1WGwjHJS+FPgiDh6XQM4xpERTxhpDR4KHvInouyvZ8SsJ4JuXeoPa8juTGHefpJBgXx7WV1LWGxqOPoKjTQw3jV+rtNWLEf5KB/LdMhtlDnc8/MslVTzoTOyUmMbYHY1UoOlXv+xQOdQLmlZrHL3B8mpptcXv6rvMN006OWHGH2ZUzjmoeYlLZb6iV1MfM7tut9bps1idYpaqNf7hYxIQzzBv95VqHbEzR/ZSxYH/9y7sZu3wxOzNUDFd9bP8C2ztijq1ulDmqn8HldquFrp6juk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=cb2UQC3JIk+Qk0VCMNsPehoC4HDe+xiSSn49veAPgyysGfpe098jAOyx0cFrsO64tZL+Q9flRKOFaWB6CuyfaFCoPFuAhL23bqhJIfm3f+sR7bLMhc7XKlUYTo9iNBG2cPygaYnwAuoCyrnJLZhQF5o6Nz0Laubvt5qGgSRwS6O8IbvFgmhn6+1d84t9Jt175XJYv+g2yNElTbVL+rUpaSPM990thmLEolnV+fMxxz3EkUlDwqUhQjcBXSMMd2Jw6EuYfxES37lwts0/PX+/80S/Crx5rE/hyZlNX98MqRzgh02G0yJb9TPm3L3lC7RdC+/nykumhpLI9mk5eau02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=aOW3tsDwJNiM5/jz25g3JIbmiNly2xQ8+crCOrZqChI0lEIOtDDqIYm0QBAbLvt7bgnxEynDDN8ZM2bdBQlAJjNTrLE4M/KeZ3+vtt7Rjq1fRfXXhoqpnjRXXhttAgkwjBweVCsDn/Iz6EX5xNXd8qIIAoguR/6R5SbuzO2zpjiRHmQKk6D+VhGzV/ctcV8zoMNuSS+4bleDb3EdrkH1mGPE8uLP0hSXKVkv1QhUEX9emNx1pwD7UIm/IvY9HtRvJTuDh51ExjGHWAG835gl/t3WDE6NUz5w/y3DYqOybjWbqBhS6OxU/eniHJm+AUHRyl+gVOUfTRHv/3lgq/87kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:54 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:58 +0800
Subject: [PATCH v2 10/10] imx943_evk: Enable ENETC1 and ENETC2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-10-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: d279eb52-d173-4724-8fc1-08de08a6a3be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWFwaVhDZVlWdTlGYTZNbFp4aVNjbUkwOEZQb2U0T2lqd2U2R1ZvNDF4cEh4?=
 =?utf-8?B?UzYrU3RqQkxxcUJjS3FKcGpYTGw2TWVjbCtOUHFOM3YwbEJFRWVoU21qbTFH?=
 =?utf-8?B?ZHlFZjVEYitSLzljNVdxZkI3akVIS1ZGVGFDbzNaYnlyZUJiU3dwa3VacHp0?=
 =?utf-8?B?cU5UV2F3TzZsdXppM2lQNnZaZm1yb1R5MmQ4QlVhalRkTFpRQTgxL0hWeTJZ?=
 =?utf-8?B?TFh0K01jdjg1WHJXM0EreXNpckhKVThmSEJ1eTExQTFQYVlDUHRJbDM2WDZE?=
 =?utf-8?B?dHNxRS9CWlY0RTlkTy9OMlFIbzdqSHVGWmhuS2pyeitsbUtZVzNBai9nYTJM?=
 =?utf-8?B?cUlwL3RwMDNubndYQjVZc3BJcWd1YnkvWjVxSUVGdWF1aXpkR2kyeDRGWnhV?=
 =?utf-8?B?UkFscFA0cU5kdCtxN0Qrd0krRlBnanMyZE84bUdLNVV0VHJJdStpc2R5aDIz?=
 =?utf-8?B?UnZKenlQOHYyZGliZkFOQ1o5NUI3bUhLcWJTSzBOWE5sQnBoYkxSVWVtdUFr?=
 =?utf-8?B?OHVRbkZuL3lmMzR2dzZDejRWQitRL0YvaUJ5a3NRS0h1RXFzMnZ0Nzg3c1o0?=
 =?utf-8?B?dE5HTlI4bEhRb1JCUS9wYjRkU213RnFUNnFNQU1PUTZZNzd6K2NOSGl2R215?=
 =?utf-8?B?Vmp3VFgrcjBDQ3NZd2lxM3YwcGRINmFmVEc2WHlnVjdSQXdQM2JqTFNMTWhG?=
 =?utf-8?B?cmNaVlpuWDVDUFZSQUtUMGt5QU1KL3RmWGE2cXJua1Byb1QyMUE1QzV0MERp?=
 =?utf-8?B?WW5PTHNKSlJqZjYzVExPL0pOWXd6Ukp4ZWtpZzUrNElHcTVsLzJZdGhqS0N2?=
 =?utf-8?B?UlJaelM5YUt2eW1NOGFGWkpmbE9pdkRTMEh0eVcvTTRMU1FpRjRFWXRkelV5?=
 =?utf-8?B?Y1kzU1VYejE3ZE13Sy9aNlVxV3pjYW9QN1l0ZnhDUlg2eUFWbHorcnBjdFV4?=
 =?utf-8?B?aXNiREE5NGNFN1NKVmZYM3VJS1hYZ0Rlek9LT01KbVdma0M3TWNCVXAycUth?=
 =?utf-8?B?emlBamZQR2lxYjRPbGU2TDVFNkdzckRseUQ2TjJ1SVRLT091dG9FUGdlT0NM?=
 =?utf-8?B?RmY4VmZUeExlSkpTeUNUME5rdURSM0kzSWV6STYreDdVU1dYWC9CWS9mQk5Z?=
 =?utf-8?B?c3NTK2F3YTFuODc0MEtXaXcxdk0xZjN3N1FkUk92NjBPQkp0RXVHZitoQTN6?=
 =?utf-8?B?UVFSWDFGK0huWTlHMzNSclNrdU1vVDNjUlV5ZSsrV3JmT2ppYzhlZXBRY3h0?=
 =?utf-8?B?K0FYS1RZajgwazhNSnVlV3R2bUFPTEMxUFpCMGVicDJ5MitVWVhaTnJicHg3?=
 =?utf-8?B?bmF2elJqK2xQdVM0RVlXS3dlNHJjTk1hSGVCd1RSZU9mQVIydkNqU0N2R1l5?=
 =?utf-8?B?djdsZEpEMEhxVmM1YmE4RG16UzZXdVUrdWdDaWZ0Mm5pT0FjRTBLUTlzNmU0?=
 =?utf-8?B?OU80bDZMdDFFRG1CVlQvdUlwTjVMNC94R1ZqREdDK08rS091RzNHd2p3aXo3?=
 =?utf-8?B?YmdzcWlzVG1Ha3NXWlBWRm5WWTdtSW4yZHVjVjRhM3RlT2VRYThLRStVbHBt?=
 =?utf-8?B?cWhkOUEwUnVOcjJyaHNkWGd0ZVNsVFkrMEtxNHhCUVI4NjErOHJpWUJlVEU5?=
 =?utf-8?B?R25GNmg4cm0yL2xiSnJCUTM5NmFRNWlzQzdnSmhkdHdMQlJBSkdnR25oakJ1?=
 =?utf-8?B?RXBra0ZXMjQySGUydVhQTGcxR3RKbzFUTndWVW5ueUorZE4rOWdzVHpVV0Vo?=
 =?utf-8?B?MGxMeHJiMnQ3N1hvbTMrSVlRQXZTVEFxZmRiSkJnbFFjRmVMU0k4OUM2T0t2?=
 =?utf-8?B?ZGFzRG54S0F6N1JEOVZ4bVpVenNNeVkrNkkydnpweERxYUJFSDhhL3dnWEVj?=
 =?utf-8?B?ZU1XbytuNWFHVEZjSHNiS2JpTmJFYnYxczYvWWdoN0docHdBc1h0b21rSWhv?=
 =?utf-8?B?anJna1k2RUxTcWg5bnVMc2ZyU2hrUzFMWXBKK1luS0N1S2tQQ00vaGNzSmxC?=
 =?utf-8?B?dWR1SHZ6SEZadktxZmZXbFBhczUwc05JWFI3djhyeXlzbStvWVlVcnBRSlJL?=
 =?utf-8?Q?fyPiHh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdVNzFvM2hpRG5oeStiS0prWXhmakVUakNrWXdRd1pWYVZHZ3doZzRDTkxM?=
 =?utf-8?B?OWpsWnZFc01iYitYbzVUbHgxaElPM0lUUFN0bFlucnRNWVBid0t6SXFDekh6?=
 =?utf-8?B?bE5meVlNQTAvYkwwMmd2cFFhY2U5dFNyenEvaklsUEQ5aTRqb2k2b1RHVWJa?=
 =?utf-8?B?eFRseUNyMEw1M09QNlBXbGdaTkFxNEg3bE85Q0hPTkdsWnFHS1lSdXpjTkVr?=
 =?utf-8?B?Q2E1SkhlM2dvdjdkbnlLQllPNTNJTWRNOWVYcWc5bml3Zy93ZXdBYVlhK0FQ?=
 =?utf-8?B?T2RLQVE2eEdKYW5GSktzL3hpbFRHMnJGT1BzYXJqZHd6eTV4NmtydksyREhw?=
 =?utf-8?B?bGhwaWVPQ21MSmNjYjNVM3ZrNVg2b2lHYmR5ZkhlZ2dNQjV0N1hNNzZDdUd4?=
 =?utf-8?B?UHZkRTQ3YS9XYmtMa2E0dlZGbjNXcVZqT1FXTy9kQnZuejdaTVZhaHhvSGI2?=
 =?utf-8?B?YVZjRVJqTXhzTjNadUtlaENOS095YThDU2hJVnBpblgyYnB0TE5lRTF6YUx6?=
 =?utf-8?B?QXhlSGlYNjhaMStvSW5aaG81ZUhCbDRkc0hnNlU2MXNFdE1Oa0tLci8zSlRN?=
 =?utf-8?B?ZGRxRC9uNWJ6eFRzMksyTFp4Y05jdks1a0dVQ3pDWHgxODdudEJnYy9pLzhp?=
 =?utf-8?B?MWNGdzllK28wNzlnS2ZhMVlnMjl5YXYvVHp5VG5WemN4cXRkalBtamZ5ZU5G?=
 =?utf-8?B?TUdyOG01Rm5ISlh5VnRNOWxLK1pWNTNORjFlSkFuWS9OY2kzRnFQREpzZ2VX?=
 =?utf-8?B?NC9QWnQwcWVBTFRHblFUcHBUQWx2bkpqYmpDN21ZRjRGTDB1TEdYeXc0L2Zu?=
 =?utf-8?B?ZW43L0VBNHlpTDMrQVFMVE91T016ak1xZnd4ZTc5Vi9xNFhtcE1FbmpuRy9q?=
 =?utf-8?B?OWxMd0hLSXB5T09wVVVHMktRREZMMEI5NDhmTEtOdHluVThRUmM5R3BLOCtn?=
 =?utf-8?B?cS9rbWJXcEE5dkZXUEtKRGUzQUpGM0Y0NHBtSnFmcW9ubVpzVWxNekFqRlEw?=
 =?utf-8?B?M0ZWQyttdUh4eDByMUNlY2tHdFhwWWJHUnQzcXhvbXlmN09QbTRITGNTNlZa?=
 =?utf-8?B?aXE0c3BHb3ViSDZ0cHN5VnE5d2dRbTNQdVhCUU01UjlCRWJUUHJCTGtyTm8y?=
 =?utf-8?B?V01KZ0lyNDBqOGNQN1pNWXkrMVNXNXlNbHpLdWtTQlNyTEtNY2NsM1Y0SWd3?=
 =?utf-8?B?QzQ5ZFA1dlpBb25kYjZtQldkUDZrc3hJY2pHS0p0SkpiTnJaUUd0NFAzMG5E?=
 =?utf-8?B?ejVWeldJSUtaS1VzZTlJQ25pa3VQTTFZT0UzNnRsNEU4a0d1elhpZmk1RGpF?=
 =?utf-8?B?YWIvWVJpUzB4ZTBOekZSWkhRY3F6UzRXMGUra3U1T1BuOTUxM01XQ1llNkU4?=
 =?utf-8?B?THhZUk9kMFZGWGR0YjJhSGVGemNRcnRpTjdzS1loRUc1TFRNeXFMSGtjdVhO?=
 =?utf-8?B?amRsbWhOK2xDL2duRDYwSDhNRmZHWjk4c0ZHUUNJUk13ZTdUZEV0UWV2WkFX?=
 =?utf-8?B?Mk4zcEtLNDNkZU8zVEJmZnJzTitycWcwZUllUWFTRFlSTjJwRHZhVndVQnRR?=
 =?utf-8?B?NnNTS2tmZVVXcURKRENJWG12WGNVQmE1S2Jua3pZN3lnd3h6SDNxMWF4TFFC?=
 =?utf-8?B?UGh1UUhSOXpTT1dHcWdoUS9GckJpNDRsSXBNSnN0d0cxRTdvN3JLR1AwTi9n?=
 =?utf-8?B?ZUlmYTFuWkFCU2ZaZWtoM0Q4UlV3V2h2WEI5QWp5Z1pZVjJrRXpUTVN2akJJ?=
 =?utf-8?B?UG1Tb0g5YmFKOElJK0hnc2hoR25rMFAxTXJzdWpZTnhQOTJkYXpldFJrWVI4?=
 =?utf-8?B?LzI3Qi9sUDVjc2xpRVpCS2FOV2cxOEdyblo1T0pvRTFNWEkwc091WTV4MmJW?=
 =?utf-8?B?QnNsQUg1UkViblB2Qm00bVVsRDlicmQyWjNkZ0JsektmNEtYK0tURXlaSS9n?=
 =?utf-8?B?dW4vYldaR3pna2NVOG1pVkpjQXVTMlJ5dlVOTTJncjRoaC80R2hjZHl3dk1P?=
 =?utf-8?B?bzFLRDB0WXdJUXhWZXJrL1pNMU5ZVmk5c2d5Rk0zRVU1VzUvbm84MjE3Mk5Y?=
 =?utf-8?B?WG5WdjJRaWRYdHlTd0dVb2d0ZmtpcFdtRTRhT2tZV2YxdHlKRlRiNXg0VG9G?=
 =?utf-8?Q?pH4ugExyFIzSj2Fo/nxRjepSF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d279eb52-d173-4724-8fc1-08de08a6a3be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:53.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEAKsbXWJNfCEdjtCbNJpSBh5GdlxMsnYK0JjH7SUYCUTQ3x/dHIrJaHJngByaQB5Y5kEFTh3uRM0G1v3gzzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

With this patch, both ENETC1 and ENETC2 are functional on the i.MX943
EVK board and can be used for networking.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 149 ++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 166 ++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  13 +++
 3 files changed, 328 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3995176f090..528b3b02a3f 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -5,10 +5,109 @@
 
 #include "imx943-u-boot.dtsi"
 
+&enetc1 {
+	clocks = <&scmi_clk IMX94_CLK_MAC4>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth3>;
+	phy-handle = <&ethphy5>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc2 {
+	clocks = <&scmi_clk IMX94_CLK_MAC5>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth4>;
+	phy-handle = <&ethphy6>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pcal6416_i2c3_u171: gpio@21 {
+				compatible = "nxp,pcal6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				ethphy2-on-hog {
+					gpio-hog;
+					gpios = <2 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy3-on-hog {
+					gpio-hog;
+					gpios = <3 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy4-on-hog {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				lvds-en-hog {
+					gpio-hog;
+					gpios = <9 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+			};
+		};
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
 
+&netc_blk_ctrl {
+	assigned-clocks = <&scmi_clk IMX94_CLK_MAC2>,
+			  <&scmi_clk IMX94_CLK_MAC4>,
+			  <&scmi_clk IMX94_CLK_MAC5>;
+	assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>;
+	assigned-clock-rates = <250000000>, <250000000>, <250000000>;
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	phy-supply = <&reg_gpy_en>;
+	status = "okay";
+
+	ethphy5: ethernet-phy@6 {
+		reg = <0x6>;
+		realtek,clkout-disable;
+	};
+
+	ethphy6: ethernet-phy@7 {
+		reg = <0x7>;
+		realtek,clkout-disable;
+	};
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -58,6 +157,56 @@
 	status = "disabled";
 };
 
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_MDC_GPIO1__NETC_EMDC		0x57e
+			IMX94_PAD_ETH4_MDIO_GPIO2__NETC_EMDIO		0x97e
+		>;
+	};
+
+	pinctrl_eth3: eth3grp {
+		fsl,pins = <
+			IMX94_PAD_ETH3_TXD3__NETC_PINMUX_ETH3_TXD3		0x57e
+			IMX94_PAD_ETH3_TXD2__NETC_PINMUX_ETH3_TXD2		0x57e
+			IMX94_PAD_ETH3_TXD1__NETC_PINMUX_ETH3_TXD1		0x57e
+			IMX94_PAD_ETH3_TXD0__NETC_PINMUX_ETH3_TXD0		0x57e
+			IMX94_PAD_ETH3_TX_CTL__NETC_PINMUX_ETH3_TX_CTL		0x57e
+			IMX94_PAD_ETH3_TX_CLK__NETC_PINMUX_ETH3_TX_CLK		0x5fe
+			IMX94_PAD_ETH3_RX_CTL__NETC_PINMUX_ETH3_RX_CTL		0x57e
+			IMX94_PAD_ETH3_RX_CLK__NETC_PINMUX_ETH3_RX_CLK		0x5fe
+			IMX94_PAD_ETH3_RXD0__NETC_PINMUX_ETH3_RXD0		0x57e
+			IMX94_PAD_ETH3_RXD1__NETC_PINMUX_ETH3_RXD1		0x57e
+			IMX94_PAD_ETH3_RXD2__NETC_PINMUX_ETH3_RXD2		0x57e
+			IMX94_PAD_ETH3_RXD3__NETC_PINMUX_ETH3_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_eth4: eth4grp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_TXD3__NETC_PINMUX_ETH4_TXD3		0x57e
+			IMX94_PAD_ETH4_TXD2__NETC_PINMUX_ETH4_TXD2		0x57e
+			IMX94_PAD_ETH4_TXD1__NETC_PINMUX_ETH4_TXD1		0x57e
+			IMX94_PAD_ETH4_TXD0__NETC_PINMUX_ETH4_TXD0		0x57e
+			IMX94_PAD_ETH4_TX_CTL__NETC_PINMUX_ETH4_TX_CTL		0x57e
+			IMX94_PAD_ETH4_TX_CLK__NETC_PINMUX_ETH4_TX_CLK		0x5fe
+			IMX94_PAD_ETH4_RX_CTL__NETC_PINMUX_ETH4_RX_CTL		0x57e
+			IMX94_PAD_ETH4_RX_CLK__NETC_PINMUX_ETH4_RX_CLK		0x5fe
+			IMX94_PAD_ETH4_RXD0__NETC_PINMUX_ETH4_RXD0		0x57e
+			IMX94_PAD_ETH4_RXD1__NETC_PINMUX_ETH4_RXD1		0x57e
+			IMX94_PAD_ETH4_RXD2__NETC_PINMUX_ETH4_RXD2		0x57e
+			IMX94_PAD_ETH4_RXD3__NETC_PINMUX_ETH4_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO16__LPI2C3_SDA		0x40000b9e
+			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+};
+
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8c89b8be04b..2b93ba9a38b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -84,6 +84,25 @@
 		};
 	};
 
+	reg_gpy_stby: regulator-gpy-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u171 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_gpy_en: regulator-gpy-en {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_gpy_stby>;
+		gpio = <&pcal6416_i2c3_u171 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	usbphynop: usbphynop {
 		compatible = "usb-nop-xceiv";
 		clocks = <&scmi_clk IMX94_CLK_HSIO>;
@@ -260,6 +279,153 @@
 		#index-cells = <1>;
 	};
 
+	netc_blk_ctrl: system-controller@4ceb0000 {
+		compatible = "nxp,imx94-netc-blk-ctrl";
+		reg = <0x0 0x4ceb0000 0x0 0x10000>,
+		      <0x0 0x4cec0000 0x0 0x10000>,
+		      <0x0 0x4c810000 0x0 0x7C>;
+		reg-names = "ierb", "prb", "netcmix";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		power-domains = <&scmi_devpd IMX94_PD_NETC>;
+		status = "disabled";
+
+		netc_bus0: pcie@4ca00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4ca00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0x0>;
+				/* Switch BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+				/* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+				/* Switch and Timer 0 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+				/* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+				/* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+
+			enetc3: ethernet@0,0 {
+				compatible = "pci1131,e110";
+				reg = <0x0 0 0 0 0>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			netc_timer0: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_switch: ethernet-switch@0,2 {
+				compatible = "pci1131,eef2", "nxp,imx943-netc-switch";
+				reg = <0x200 0 0 0 0>;
+				status = "disabled";
+
+				netc_switch_ports: ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* External ports */
+					netc_switch_port0: port@0 {
+						reg = <0>;
+						status = "disabled";
+					};
+
+					netc_switch_port1: port@1 {
+						reg = <1>;
+						status = "disabled";
+					};
+
+					netc_switch_port2: port@2 {
+						reg = <2>;
+						status = "disabled";
+					};
+
+					/* Internal port, a.k.a management port */
+					netc_switch_port3: port@3 {
+						reg = <3>;
+						phy-mode = "internal";
+						ethernet = <&enetc3>;
+						status = "disabled";
+
+						fixed-link {
+							speed = <2500>;
+							full-duplex;
+							pause;
+						};
+					};
+				};
+			};
+		};
+
+		netc_bus1: pcie@4cb00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4cb00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x1 0x1>;
+				/* ENETC 0-2 BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+				/* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+				/* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+
+			enetc0: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x10000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer1: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x10100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc1: ethernet@8,0 {
+				compatible = "pci1131,e101";
+				reg = <0x14000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc2: ethernet@10,0 {
+				compatible = "pci1131,e101";
+				reg = <0x18000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer2: ethernet@10,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x18100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_emdio: mdio@18,0 {
+				compatible = "pci1131,ee00";
+				reg = <0x1c000 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index e4fcf2eb576..39b616e266e 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -39,6 +39,7 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
@@ -83,6 +84,8 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
@@ -97,9 +100,19 @@ CONFIG_SPL_CLK_SCMI=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SPL_PHY=y
 CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y

-- 
2.43.0

