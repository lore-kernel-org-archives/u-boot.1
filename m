Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE7C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C77882E34;
	Tue, 29 Jul 2025 13:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iPhfGljJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AE682F14; Tue, 29 Jul 2025 13:19:51 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A8A82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRPRzMuCsmWPfGoMGTyXYam4JnG9b7Z9DqDEDezwRdvKeUlHEMLogeIyECvH9HDW7jsneYrxAAXsSaqoP2b8p+3Ve1xwAqvVu/KM4iB2MYAEFIIC1iFOhMFzrt75VDqmFAt4bPETWWpNZt9tkLkxsrsGL+PGHe9TW06G/l/gozZnY8KQKF0otyoQdiZ6dIZalFrBBltycc3LTOpatC30JO28EzW5ySCr/VBLhKZLMjn8FLVvzVC8tJY5kxA7JWxJGv5fi8LPVg8XQiZTjiPwlQ+PpIEEyR4ulyOUu0Bur/EllYquffD+ZBl8GxSfWCEkmxATMI4Ahxu6VrJ57ev4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ6SlwnCT3qumRwb+ya8D9aYqFTN47PbY6NeUbtPJaM=;
 b=twf4m7JTUL2vy+PsB4M5MHrav6Tgki/jGjaFXFPVnRPVNGblGJWMr2+waVvHnca6b45MyPBOIsVvXP6tlJR8zpJtl03raBeZ2tGl9kFGS5M8C9mhN00pqBaWd8DH9ImhPz4TJ49fJJKeDwwzGV4DFStcqc/0M9z2LWZMIscgDczJh0mS0FxD9jmGGn1NbIvVq0lAX8HBicdM3trBJe+8+TQZcIwuWujD5U7aPlIuG+ksTOW0SBRp01fwyTmFv6CElzZDscDnZ1Wi/6+5qb5XGdS+P/7Iz2KoJerHP8anK0KGYAiq8+AN6fwnW3Mlz9BH2TI5pdzoxba0pNiIYxs4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ6SlwnCT3qumRwb+ya8D9aYqFTN47PbY6NeUbtPJaM=;
 b=iPhfGljJ9xFcKkBuc1snNJKXUomcJCDBHzB1KKDo9/XCeXFd7df89gAuFHzJ9s/IuK+6FHg9dPKrc7d0XN3+I/vqSXfVIvg2iYIU3OLwaVdZq3fDiLz3PVFbc7DkRSKkNa29xs2uUBQ2ou9zZiQLyYuw8BPxfm65CPgxqp4XDR9EHlCxkP+r+P1PrntP+8bPHgv2UF3aNSgVV8YXyXXQqHXqaSR+3hSJOiNDmx5L0PsBT6cj9/dyZoeS20cw6ArF/h8OCfXsmSJvXE3UYFI3eCoGQeCCrLZ0TTBld0Jt1u9KOwdR2PnQB3kJYBNg7Wk9wgaAHN7wPd5920rL5FFAeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 11:19:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:19:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:52 +0800
Subject: [PATCH 1/6] Update VID/PID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-1-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fc9da0-4242-460e-5ef6-08ddce91d36d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW8yb1hlM0s0WWdsbi83eEhkRTQ2SHRaZUNmbHJ3dGRVc3RBME1ib0dZTWgr?=
 =?utf-8?B?dytxSmltMktsRVNmcktvVWNQa0JMOUFRNnd2bzB1T2trTzlMVHJEOFNFcEh4?=
 =?utf-8?B?elFENzF0UFR0SzdMNFJVck1ZRkRUYWN1TEN6bWRWUFY2WVlidWlEbkFpM3ov?=
 =?utf-8?B?dWYwR1puRnZKM0tVejZTVG00VDNubkNzajBJUXc2NkFOc3NiaFlqczd5M09Q?=
 =?utf-8?B?a0JYQ05YRnZXTkkwZkNXRWVaTnJzWkxXeXNTS0wyQXpaREY4cW1BejR2eGh0?=
 =?utf-8?B?Qm15V21jQzNld05iSFByRzZwdkNqWW52NmlYSFRqY1VjZzB0MUFaditMRkd2?=
 =?utf-8?B?RVpwSGszL01ocXVGOExMaWMrOXJyWWw0cm56VlE4bjJmUVhiVXpXcStQM1Nh?=
 =?utf-8?B?elp2eWloQUc2Uk90d3Q5TjdrUWg3VkY0ODQ5VlhNaUhXeCtNOWRxclo5Q3Y0?=
 =?utf-8?B?Y3AzanBRK2MxOVJRSU5ETW1OQzRZaVpMWUVycStzL3ZTamJXUmRTSkYzUExS?=
 =?utf-8?B?UXprV0VuMHZ6N1Vycmx2WjA2NjdWVld6YnlqcThiQ0ZSMVFnMUR5ZWVvOGt6?=
 =?utf-8?B?SUk2MW1vNHZ4SmlsNEE5U0s4eEhYK2lKRzMzbEw4Q1lsTmtTRGpjaUE3NGtR?=
 =?utf-8?B?ODUyOUl6anlaSEJ3S0hPZUdicVRUL3pRczIwM2hER3JmT3hraGI1N2VoZjdG?=
 =?utf-8?B?T2FiOWZCMDAyakRBOStmR09GQlRqeTZnaEY1WTBkNjdGMENDak8vWEJ0Y2g0?=
 =?utf-8?B?Q0twL0ZHekx1SVlSelE0NFFmVURiejZjU2RFMTZVMEFWUHlHalIzMFkzMWo4?=
 =?utf-8?B?RFEvZkROYXVBT3dsTkhGV1VaOGVVNnNJOEVLS1BxUzdSZy9uM1lUK0QrZ21u?=
 =?utf-8?B?Y2NEWDc2UTBpa2hmU0JvTTRuUE9VbEdlcWlKV1d1aS9wOThPeEY3L2NJVzE2?=
 =?utf-8?B?MjlhaEh3V3JBamY3alFUSE51ZE0xSFNxSGpBN0FCTEsvSGZSRE9vWitWU0dw?=
 =?utf-8?B?eUxmMUVFdjdydm80ck1JNWFpY1Z4V1YwblEzQVVZTHRDd2tJR0czQ09BQ1Vo?=
 =?utf-8?B?R0NLSTBLWGM1Z3dMSlBUNW8zc0xmVlZ3YWtwbW9Kc0p2QXRWNVJVbTVYN0tX?=
 =?utf-8?B?emZxZm5kT1Nvb01UNEh2dVl3NkEyUktWa3V2S1hBd0dCcDQyNmhFR2VZTkt5?=
 =?utf-8?B?SkdKbXIwbldDeHlQTFlSTFVHTlpDY1hWK05zWXdlbG9XaU9leUtVVlUzcC9u?=
 =?utf-8?B?SGI4SUlTVjVaL1RXTnRWbU44SVJISWFxNlJNWUc3aHpZMHU3WkUrMEVpMDdl?=
 =?utf-8?B?Y2JLd0FLWHJaeVpOOUdoWlBKeFJOd3JjUiswODVKejhocTdTVWk4ejdLRklU?=
 =?utf-8?B?U2xTSkFVbjVGTEgvOWFjUi9TaGVTOS9TbDZQcW1mb0VEZjJ2Z1Vwa05sTjIr?=
 =?utf-8?B?TFEzbjgxWVprMjhnbFpYZTVtQXhUR1BHNGVuSVMva2lWaExzVStuYSsrYTRR?=
 =?utf-8?B?NlNiNEZobkpNang3UkJLUzdqUFE4UmZFUHBpQys2UW1BYUlEM2lWdWxaUlJy?=
 =?utf-8?B?eU1PVWxPWEFNVVh3VGlaWDNLSjZibGtmMXlrcDg4ZW5LNlRpRUxFaXVUMU9u?=
 =?utf-8?B?OXI3R2pyR01IbUtvaU8vUjY2bG0xdFlkWEhpWFljN05zSVJDRVB3blcxV1V5?=
 =?utf-8?B?dzVESEJNSmpzMzFlU1F4MHZXdDJWZzVkVklZTHlrcFpId3lKOTlkN1VUYWcy?=
 =?utf-8?B?Y0hJYkdCd3d2MUlDMzFHWnFFQUxyR3FzcHhsZUh1L29RV0pOWUZqSDhGZkFZ?=
 =?utf-8?B?SVJKYzZoSnNmcXY4SEFuOXNpbHFxV2Z6QnkxeEJ2Nmc4ZlJ0QzJpVzdVNjJY?=
 =?utf-8?B?TWZxdC8vQXZRRDVwVUlveUR1T0g4djdPamUxaDhrRUVPbHhvcnp3Yytib0hO?=
 =?utf-8?B?SFA2VEwycDh6STJKQndVU2tIOHZIamUwdmMvckUvZzNqQ2dqL2RhY0FScFpJ?=
 =?utf-8?Q?2fx9wvZeamJIviENYmfJ9XwtZXa8Nk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdhWXJJdWFqeDRaenR0eDZGV2tGUm0xeHU2MW1OVkljd3kyc2tkQ2hLRHBI?=
 =?utf-8?B?R21KQkdkb3JwWVExdkU2OXBReUNJSEdZQ3luQmw4RFBMSUgxK0tKVGV3aUM4?=
 =?utf-8?B?akxDSDRWY3RYcEg1WWU1cE1QdjdJMW1GK1FDK2NzYm94Wi9wL3pveGxlKytk?=
 =?utf-8?B?T3V4VzN3RjBwc3J3czNmQ0JBV2lzZVp6dE9vUkRSU2tRcVlRS1JHeWlYK1Jw?=
 =?utf-8?B?MGFCdzNLTXEvVHBlRU5qdnRDOW4xc0RWYTByTE1PK1prOTFuUkpuR0l2cnd0?=
 =?utf-8?B?NFZzN2hZc2RZSGF4dXVxREplVkZFbGpJUFd3QzdSS0ZTbUNTVkJJZlRrU0lG?=
 =?utf-8?B?YUZ1dkVOTDkrL1ZwZU1zNjVTdDdaekdpSjg3YnRhcm9mN0UwTTZzdjhZaEc5?=
 =?utf-8?B?bklXUkpyYTRqMUlFSUdURk81YjZWSjJnVWhHUHBJb2h0Um9HOUtSNFRFbVRj?=
 =?utf-8?B?aFAwUUwxN3B2VjAycVVQREFCSDRVUnhBelNvREdqaThMUmpsTEtZVDBmUE00?=
 =?utf-8?B?aFRzeW9ZOHlUbVNtVUdnN3FNa20yYmxFTnRYY3JCdzNSbnI1MCsybXdsb21Q?=
 =?utf-8?B?MFZDVldwaThUN0hFTnNKVjJ1anlIZTNlbGhKMHJoUXRGSTMra21XUTBaTmdq?=
 =?utf-8?B?UWdSSTZLSm9JMWFhUEd5bENUck9JTWFUT3Rtb2d4SWVpbVdPQXhhc1R6S280?=
 =?utf-8?B?NlR5T3ZIb3BNZVVrT04vY1FFeUVSZG1CbVBvQTRCeTF4blJOLzJCbjVsTHly?=
 =?utf-8?B?cExYdDFNUVliMGR2TWN3UmNJZzhRN1dJRVo2OEtPTXp0MXNpSmpEOEorTGp3?=
 =?utf-8?B?RUNCY0ZTMXA5eExKbVlqZ2hIU3hqT2VxcXBDbjBjaFg2WkpNU2lGZWRYQk8z?=
 =?utf-8?B?a1FXQTZCbXFmTjFqNkRIVXhTQWhUSE1mWEk5aHBxdGlEQVVQYnhaRXZxUTRF?=
 =?utf-8?B?K2ZobjdESFFUTVovV2oyWFpnRW1CTHZGbXdncWxTS1RZYkloZWorU0FYd3M1?=
 =?utf-8?B?YVVsM0xyOEVDL2tTbDRwb014Y0szcGk0RStEOFlERFVVL2MyZjlhNUZWK2p2?=
 =?utf-8?B?cnByR0FHeFJvMEtTQUVIbnU2SStVdEF6T2pVVlFDR29wUGY4SGZlT0hSV1pV?=
 =?utf-8?B?MkpVL3dKd0pYbWVhY2pWbHlqWkFBUXlwWkJkd29WbWJ2MlFieUpVZ2Y1N1RT?=
 =?utf-8?B?MnFkUFdHbkVmMzVJSTZSR2NnZ2ZtN2FNZXB5Q2wrVldxUjliVXRVczArSFdP?=
 =?utf-8?B?RDdqNzB3aEFPTnNiYUZ0dW9ic1N4NHZsdzc5WXdPTWFGWVo5b1prZWhGSFVZ?=
 =?utf-8?B?TkFRa3ZxdXhFNEhwaFhFajlRZkNqQzBLcnBSRm0wczNZamVDQ1Q2bi82UXBk?=
 =?utf-8?B?NmdmcHlyVjJNdzdkUjlIWGlTeTNmdk40L2lNWFhoV3Jrdzh6d0xEQWNIbnlv?=
 =?utf-8?B?TXY0Z2F0ekNWRjIwQzRwa1JUd2NFaTltaVJIeXZTN0l1VEtJRFY0OVJxcUph?=
 =?utf-8?B?NHBZNlY2YUcrVHpIYXRtNzNONFhKdnJoMzl0QzRHeE5MTVA1VThFWlp2MjMv?=
 =?utf-8?B?M3gzZDk4bEswMmlpbXlXY0l6RFNRaUZqU0NDbHlGWDRCSjBQUmpIMjhFNitL?=
 =?utf-8?B?R3RTS3Q0Z3k4dXBmb2lrVGxUNEU2ZEtKWXcrblorNVc2REw1Y3h2RVY1cUtk?=
 =?utf-8?B?VHNma1gyZWlkZkdOUC8rejJUU090ZStpMVBzaXI0d2dDWklWOHJFZXJUWVRx?=
 =?utf-8?B?U1FjVUpXSjRlVzlFRks1SHlUUzNKRFhUQUxwc3k5bWZaWEgxRUppbFJUUGFm?=
 =?utf-8?B?SjVwNnZ3blFGR1ZmNkkycm13Q3dtcmQyMFdQVE01ZWgzYlNVZnpIUC9YU09l?=
 =?utf-8?B?Z3l0dTJBUGZ6TUU0QlMyN0NoeG82VnJ3SDNGaTYvd2NZY2VLbnpLSTRUWkVy?=
 =?utf-8?B?bDYySFErb0JOQVR3VlJYTTRQYkhlSXZHMFRsc0FhbDlDYndUalZHbS9PWHR3?=
 =?utf-8?B?aVA5dFROcmdYUlZGRXAwU2FsNmxBQ0hNWmxqcnlSZVp3d0JhSkhkcElhUEpw?=
 =?utf-8?B?WjZnYmFQY1A0dFVSWVhhVjhZMHdWQlltVGRscWFEcC82U3pFanVUQlExZ0tl?=
 =?utf-8?Q?AyySNmaklX1+yfrEapHeg4dwB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fc9da0-4242-460e-5ef6-08ddce91d36d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:19:47.0467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahsVwq52mN7W8ksBOrEzQNXx3p46RfQDT983ZyNQLGI7TGX70WN0NlkdC0V1nVE+Xru8QNONf5Fp92Ll78sA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648
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

From: Ye Li <ye.li@nxp.com>

VID 0x525 and PID 0xa4a5 already registered as
PLX Technology, Inc.
Linux-USB File-backed Storage Gadget

But fastboot device is not mass storage devices
windowns 10 latest update already cached above vid/pid

Change to use Freescale VID 0x1fc9

PID 0x151, for SPL SDP HID download
PID 0x152, for Fastboot
PID 0x153, for Kernel fastboot

Need update uuu above 1.4.182

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c           | 2 +-
 configs/imx8m_data_modul.config   | 4 ++--
 configs/imx8mm_evk_defconfig      | 4 ++--
 configs/imx8mn_ddr4_evk_defconfig | 4 ++--
 configs/imx8mp_evk_defconfig      | 4 ++--
 configs/mx6qsabrelite_defconfig   | 4 ++--
 configs/mx6sabreauto_defconfig    | 4 ++--
 configs/mx6sabresd_defconfig      | 4 ++--
 configs/mx6ul_14x14_evk_defconfig | 4 ++--
 configs/mx7dsabresd_defconfig     | 4 ++--
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..4a86d8698b4 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -184,7 +184,7 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
-	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
+	put_unaligned(0x0151, &dev->idProduct);
 
 	return 0;
 }
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 4634a0972f0..d56208b6a14 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -213,8 +213,8 @@ CONFIG_USB_FUNCTION_ACM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Data Modul"
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0x1fc9
+CONFIG_USB_GADGET_VENDOR_NUM=0x0152
 CONFIG_USB_HUB_USB251XB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USE_BOOTARGS=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index c15372edc9c..0ca7eb88436 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -129,8 +129,8 @@ CONFIG_MXC_USB_OTG_HACTIVE=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index a80ceab56f5..e524beb7af7 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -103,8 +103,8 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_MXC_USB_OTG_HACTIVE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 0ad1acb94b6..8c04e12fa18 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -150,7 +150,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_IMX_WATCHDOG=y
 CONFIG_SHA384=y
diff --git a/configs/mx6qsabrelite_defconfig b/configs/mx6qsabrelite_defconfig
index da07b38b4bc..3d5ff03aab7 100644
--- a/configs/mx6qsabrelite_defconfig
+++ b/configs/mx6qsabrelite_defconfig
@@ -76,8 +76,8 @@ CONFIG_USB_KEYBOARD=y
 CONFIG_SYS_USB_EVENT_POLL_VIA_CONTROL_EP=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Boundary"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
diff --git a/configs/mx6sabreauto_defconfig b/configs/mx6sabreauto_defconfig
index 66ae436b538..26045986e49 100644
--- a/configs/mx6sabreauto_defconfig
+++ b/configs/mx6sabreauto_defconfig
@@ -103,8 +103,8 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 75a655a0e0d..6a1ffb58c88 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -117,8 +117,8 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_VIDEO=y
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index 0e35e5e6af5..a07fd510bf7 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -98,8 +98,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_VIDEO=y
diff --git a/configs/mx7dsabresd_defconfig b/configs/mx7dsabresd_defconfig
index a5a562af0c0..c3a7bd62dc5 100644
--- a/configs/mx7dsabresd_defconfig
+++ b/configs/mx7dsabresd_defconfig
@@ -83,8 +83,8 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.43.0

