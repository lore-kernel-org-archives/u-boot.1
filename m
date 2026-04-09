Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB92EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00A2839D5;
	Thu,  9 Apr 2026 13:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HMtIbe2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423A8840D8; Thu,  9 Apr 2026 13:39:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7DF83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWqjLZ88h5xIr3tD/ShTFvxibSKBtaR0qF7hbxxpUxUNqprfotw8M0+maUodp+BVrDbLpSHXTWobmpWohMsnEQLaiY8KmBcgrGDbRCRO9iv3R4x9mrzZzm5lGfE+TB1U3077yNderpEB3G5G3+5OUoX2mmnJ5iqCg/yDSQpvKRXOhi3CxtAK7NsYicqcJEF/yCdpuWPOF0X3sWdC2M+lAdPVJUijX6CP0jL1AEP90T87fAZihEefYCW5+yUJBFQDf5a2ihh1fBaM0L0HCoF//pH6E7i5cLh4Svy48DgcC95inPt8mq93gwhLqzcY2SQ5fIxEnzv27iI6Tu2ijjbMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgdF171y6hvJlTJtnX24lMRDBAoJf9ylzPtruiN6PvU=;
 b=lNUYrVcDcuHjIKFudRptkk2Nes5iVPleWyKu61nwUIekgX2nkRaQ5CEkbtvF9EqRxP77iZhmASshlFah8kaomztjD++XSY+MyfCppD86o3gxay98CN+/KkQcqnVfGzRhAlGONf5Iegz9SsWEVtgfW2x3epxonxy9U/tRyS1fSNY5wvoV/au3Xwfoi/ltPzyYqaL1LpLVmrknmEqf3cBKrsydI9RKGDcBf5yr+V19Ddq1n48eu5fzLARaYs7rV+13ga+33VOA9nQV691LGkG1b7Krt2Hf+pb19vPMEAe9jYPjtCqnYnMG/5AIvOib2fLELyiOxveYRe6vvuJw/hHUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgdF171y6hvJlTJtnX24lMRDBAoJf9ylzPtruiN6PvU=;
 b=HMtIbe2UmGmZFufRiJnxnSgiLORhelKq54nrnd0hrZbjH2KI1791Ve2uUsDobaw/c9p+2iPancNUxn8v7odIbQT4Ko2hyBUqFxHN3+WXMTjzVjwebJwMqoJTYmUsh0aCbLI7rYHdiCt5NjWvwpc7WNBnuuDU1Ieioq/OhNmdxIQi2E0B4M5NyIFliG2nbGgxIWLX4LzfQ+qtaHr6ADQpGbTAOa+7MKKjY02C/alnuZfewjR5DBdOuIXy5aVg2q06JSvkYHFia8xg8V5jTQTHOU4f5SD5OVa3hSipFMdO0c2d3oR83A1XiUCbMQwkTDI1TGKQKaYIszeTn13WTyDpFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 11:39:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 11:39:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 0/2] u-boot: pinctrl: scmi: Use standard pin muxing format
Date: Thu,  9 Apr 2026 20:55:44 +0800
Message-ID: <177573926837.4193161.1238579928452667096.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774526652.git.dan.carpenter@linaro.org>
References: <cover.1774526652.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: f1822c6c-8db3-4100-a7f1-08de962cb448
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E+u7QCWL9KRz1RWtRdRFe48BLKUbKjcoumrNmSg2BdqSsrZsRmp/DW2aCsmscUB2rV5agKegZZ6b9UZI2HR9sSpF7gfpHlzO2DFJYI5u7cH8yXXG5WyP2g6LPWQOkAFOgmkfvaqbu/XsRerojHi4R7hme1o1AWYPP/m6eGdw/YI8Mk3QUnGoVYMGfpnM+Scth2HPpvBEN45FtsE03ssQb5WWYSjffSckECKqVvdrg9O1Hemk923oVwoV8JNr397vgXchR0UucbIlaAmLkUJD+L4d4jmJNbxauEfNZloqs8mqzURW+kOzl2VqqX9m8SSyQHKnw2OdcMj8kO85vyi8HFw9gyAmFMHbBWbeQGkOqyO8x5Vigs2/zVNW+3iHHj8rYh/0h4ut+bURJPqSCzmXCajkEobYfI8BYeqTbHzR3580gWkWK1ncgHzwRgcBXJQUsxqz6RIsZbS3IPgo5hdUmpjhKg76zDE6vAbuk46+qqyTHX68WMIb11wS8AFxC8ZmIKBANhMnkk7nbcgt6u/NSEo0ILk1ixk1ZLrAXR3DnzWN41TR0bhEzBnq0U6q7QmFTcu212qMk4w7mzy5V4qoBa4m/9A/gxOEJTK9tmLWCfJA4F0LMMX9lAn7ik/79trKfZqhEY+hs7NMwATmeDKHcHAjuQ5UqbZIClkx34FcRC70xETmUmdzsmavilLBt3ZsforTu+XBP3HGTQO1OMBDvLt8tP+xmLqcS/muNR49zzYTEz3KNTa2Mgj5VP4WfOQHwKguu6IotrIB7kjnzMweCrZBBAT81iZFtI7ArQe6I08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURpOTBYTTRDWU5VY0ptazBsZ2FodEhoZVBrMGlPd0V5RUtKdzlyQnVmbzFC?=
 =?utf-8?B?OEw2SkpHYlpGT0FHSVN3WE9GeENNN2hJTHY2UEppMG1WZjBDSHhRUnVoS1Yw?=
 =?utf-8?B?ZnUya3FINSs0KytIalJ1eGpGUnF5RjVyR2R2eVpRbUVhcEtMa08yM1laZ2tn?=
 =?utf-8?B?WUdpRFgwOUwxTlhXaHg2bzQ1dlhFRWpaaExQTEQrTmIrYVc5T1FsMktyaVVK?=
 =?utf-8?B?aEJGNS9hQmhvd1pXeVc0elVUVTdLekhOdUQrdnJjSUdpV1pIanppT1d6YkJ0?=
 =?utf-8?B?Q1ZlSUExWmRaSlpXN1dhbXZpV3lMa3ZLaUZYRVpLVWNiTjh5Ni80N0xFbGFX?=
 =?utf-8?B?aVhleEJOWEdESmV4Vm1lZ3pWZTl3TDlBckN0RDd5U2RFbGZFWVVXREhENTMx?=
 =?utf-8?B?d2tXMzBHOWJPeHFEY3hjNnB5V244T0NIWStqM3ZZN2pSWW1mRjVLeVg0c0ZG?=
 =?utf-8?B?dzV1NDJ6NkppMzllbHM5elhmZTJuekdjNStxNzV0UUJZbXE5VXNScldrUXVx?=
 =?utf-8?B?S28xSkEwaXRML3dBWTFtMlB5Vnc2Z3grRnI1bDZvZFBGQWJRMGxpUDhHbDFQ?=
 =?utf-8?B?VkdWUFdlYVpMenFBbWpQQy9kdWM0YU82T3pKeU5FLzRRcVJlbnRDUnlwYTNo?=
 =?utf-8?B?NXJOR3E2TFExa2NXYmdkdkFsbGFvNFZCTmIyV3g2a2JRZUx2eHR1dE8yem83?=
 =?utf-8?B?ck1MTVVWc2xRWXFDS3EwY0JuOEY0L1VlcEFsRnVUR3VNbC91OVNwSGlieWVF?=
 =?utf-8?B?SzBDdFhVSEpkRHhMOG9jNHpHbTgyZ2lUZTdHM0VDbmI2WkVJWTZmWVRzWGto?=
 =?utf-8?B?YWRzcU5ZbmtQdGlDQy96MTdLOE5WM2FIMEpMNXpPeUhXclF2THRhMVBacGlu?=
 =?utf-8?B?MzdZTml1UlIrUVFjbTd3dzRGamNZM2RrdHpzd3dYOG9GMk1zQk1md3R1bk80?=
 =?utf-8?B?R3RwSWk4WFdBeGZUUTIvUW01cmhMSGtnZEx2aFp3MTBvVmZPN0FTL2VzYWVo?=
 =?utf-8?B?MTRKTTBPN0VGNmtyWkxiNnpDVGVRN3dzV2tUR1h2VkFPN29DMTFZd2pFVlhE?=
 =?utf-8?B?c2xTKysvYjRKampqQU95SWh3eHpvc0hJZ0pqNlFwZ0VjWXFJY0FkWStBNEJV?=
 =?utf-8?B?dktNbVhDS2tRYU1PNHprNFFReHVEVmd0cDNmWmtSVVZnT29tVlZGclBEblZz?=
 =?utf-8?B?SlJpRnVrcEpCWXRUM3l0SUcxWjlhNEwxYUI1SzR5VTFxbEZaUTFHckhacHdW?=
 =?utf-8?B?dklYaXZzNHZ4RHE5d2hudTJJTHNlQ3V1RGdaMzdJelZQRUJoR3pBMHBROGJQ?=
 =?utf-8?B?WDVCVHpPNWF1MUhNWnVEWERGaUxnSlpkc2ZhZFVmT3hxR1lTN3JRU01IMDE1?=
 =?utf-8?B?VjFDR0VQcWs4d0JhckwvSEp1K0lqRmYrTFA3b3hScnI0anBpcmY0ZWtDMXEy?=
 =?utf-8?B?OEh6b3NUMytmTmJuWjF0U1MxYlpQV210SHVsOEx0cVRVdVhUcEt4aDFDNVdq?=
 =?utf-8?B?WjhPK0kzVWV2K2YwVGJWQjlXUzEzcW13QS81ZWJ4YTRTSms0SysrY2RINHcx?=
 =?utf-8?B?bktwc3hocWN5ZlNwT1ZFSEcrUlJRaUJzTExCNjg0TUlVTXBmUWd5WXR4Y2d4?=
 =?utf-8?B?S1lnTEtacE9VMEtoaktYS1QwcjcxREUxd3Q3TFVwRTVXSk85RUhuelJoNHRB?=
 =?utf-8?B?S1MwV2d0QXNpUGxONUVGV2dXdkpuZnNIU08xbWdUL091MzcvM1V0WWdKUGZp?=
 =?utf-8?B?MXJKcVUzSHF5UmUweDhzQ1JDV2dEUG02S2tIOFhqZ0NhejlWaU1Ea2VHcnFm?=
 =?utf-8?B?eTUxbUFFS0FWM0hUeThuK2NjWElSTkk5V0UwdVB2UmN2N3d1aW9jd09kbW1B?=
 =?utf-8?B?aTYyM1JCSjVqTm1KMy8yRm5zSUtxekEwdzAvelh6U3pUUzQreUx1M2hxMDZB?=
 =?utf-8?B?N3ZtN2tQQlRmU0RLOWw0UGpieHBGSnpNVVhyUXd5cHZHYmlDUXpVdk5YRGhu?=
 =?utf-8?B?N01rUnd2VnMrQlpJY25mKytDOFVxdk5MTlF4L0ljaFFmT3g0RW1PVXZ2c1hP?=
 =?utf-8?B?RTZ5YjA4SFh3MnpGdXFUNVlLSHdBZUhZSDJkYlMwZE5MTkt4eXcvRVlxOUdH?=
 =?utf-8?B?b2ZBZUoxaDJiTjNYQjkvM3VQcE1hdnk1cWxpQ1JoSVh1ZmY5TU1acU5HNVUx?=
 =?utf-8?B?NzhjQXNRYnJaMEJWWFI2OHUvQUZWS3BlcVRLTVNzMHlMdk13NjBxb3BibVNN?=
 =?utf-8?B?R2RpSk9SOGZtVW8rTW1JL3hNekFoQ09SNVFFNk5FaW0yUG9LZ2w4eWtTa1Uv?=
 =?utf-8?B?VkZCa1ZWNUpKelpjR3FkeXhMUllHcWF0NUo2Wld1SWxGaFdvOFBmZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1822c6c-8db3-4100-a7f1-08de962cb448
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:39:48.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtqbEe3F1XmOFC1cj9q2WFj+MjCSDoQU6Do7YANo1Lr7Gd9UmWRoDwqS/AlJTWqgIIKi8Qeqn+kcps4KVhr+2w==
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


On Thu, 26 Mar 2026 15:08:12 +0300, Dan Carpenter wrote:
> In my original code I created a custom format for pin muxing but it's
> better to use the standard format.  I also found a bug trying to use
> set the function.  (That code wasn't used previously).
> 
> My GPIO driver is not affected by this change:
> https://lore.kernel.org/all/ff0756d9a26c95540fb65a35765e9a43949a5814.1774350851.git.dan.carpenter@linaro.org/
> 
> [...]

Applied to fsl-qoriq-for-2026.07-rc1, thanks!

[1/2] firmware: scmi: Fix setting the function
      commit: 15594704f794245e14f5c8fa4109be42c88c1b6e
[2/2] pinctrl: scmi: Use standard device tree pin muxing format
      commit: 6aba443c41ae4774b6ec7298dca96c5ba08306cd

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
