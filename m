Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04174EF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 13:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1D283642;
	Sun,  8 Feb 2026 14:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KNNKvAOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9738483C39; Sun,  8 Feb 2026 14:20:04 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C671A8341A
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 14:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTUWRp4ZqPA3zoYDu9qSK7sClKU8rdVurOEoleUWHOh3Dj307u+rfDQsiYCOLoeTIFi6Eb0FOtu+8tNNfm1blt77a2VEivpmFgud7WzA6u+yUMbdI6l4/LWjI/q4MbocMtq0SAJlD6xmzpkoBZKPFZ4NQDJj5zGmgJLTWfLkL9QypJoevmceQ4yCjhPOa4XYYtPiNQUQu6TcD0U5vBHbz50L+vini3wOnL93gozPjYEp4NYXClMx47BBunkdyAJR1Q/qgs4y70KselQXE5E5qZJF8bipTC+F/iovDaSVGFHmDeP0T1HCmBnU98bZGGaxS2yNTqrR2BnfX4zClUkQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krvmHzvO+SvSDX/VARDMaaWP/2T1gKFMgnw39yz91JI=;
 b=W6J/addA1xLuMpY9Nn1pqqqEzO08QfTWwhgSHOZyJNJmgpD3duLoUsPsebvcNG/V599RlE6paY8DdomWMa74vOVpCyJxeN1kNoh1jTYyZ/ADrsK42zubHAQCW6vIlqo9sjKw8AUOTudczMY7A00NHzDLSioP54kGp8lvRLCpmraQeIg1CliYZJso4rJaHP5Wxqm0S/jcDKPv88yJW+3aQ7eP7LsJZWWhJPCyXcLcQq1Vuzs3aFjxRtGEB6r3QuNPf4ATqmzOwt+uK4Jk5vcYKzt4YRmoh1bC8pPNjpXh/E4s+MlgkkalWCZ/EgsSLvQr8Ai5Mf4ib7VRyUG9t3eP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krvmHzvO+SvSDX/VARDMaaWP/2T1gKFMgnw39yz91JI=;
 b=KNNKvAOy4iWc6Xl3tIH4Rzfqews/0RGNQOVKdyAvZcBvfyHLrlOy358M141y/8fbYmxirx1S8JUSmUnsEweCfb2y7X8S4nWFI4aWJXxHGM3LS1x+ZBVCrnGqkzpZFWAnT03G+2iCklJ7Kqzvc5sE7GnIZrxOwZPnebwyiF4NaB99bctk03lSCO9VrtvDPb6Olmi/tO4Kc9XjiYk7Be/Q29aJeWtee46l9c0ZUSHNVXEui4+2S5hZAT8kRssKjYvUhZullDYwgBePnGnZPZEer102bDY5CW+OcjuX5M26xHZeC0rngVP9xlHITqbgS9e54itnsthfAhui4O46hdPwXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:20:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:20:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 08 Feb 2026 22:34:41 +0800
Subject: [PATCH 2/3] nxp: imx8m[m,p]_evk: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-imx8m-uart-spl-v1-2-c3e81cadd160@nxp.com>
References: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
In-Reply-To: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: 6126a5db-917a-469f-4f76-08de6714c2d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2ZrMlNjK2JZTjRJUGd4TVJQMFVmb2p5SGhONTZ0UmNkcjAyTGUya0p0QVYw?=
 =?utf-8?B?SUFXRUpzMXJPV3BOTFRzbE5ERU9ZZHk2aGZPaTZGN0RwbWo0MUhYcFlSNjNr?=
 =?utf-8?B?a1lWTUpLZ21iWmdNV2tYanh5MnNuQTZnRFNxK2xCYmU5d0lTN281UjQvUnc1?=
 =?utf-8?B?OFdwZS94OUZuWEwwNVVaOG45ay9sNG94RW4yZEd3d09WKy9tTFVkMllIYWRm?=
 =?utf-8?B?anJVVjZVK3BSTHNwVWVKcWsreCs2L1ZINitIbXhUenliOXNISDlRMi9Vbmc5?=
 =?utf-8?B?SXkvWHpFeW5kTmU0STBadzZGWXF6RHNFd25WV0cvMzZkbEl1eWt3NExsOVFF?=
 =?utf-8?B?OGRsT2Y3ZzhydzEzOWdpVlNucU9CK0dIbWZxcEgwb2o1dzJscjg5enNLOG8r?=
 =?utf-8?B?MmlmSTZiU2lIaS9ocUkvMVpidVMwUndiVXdVeFZXd0FESmU5a28rZE1zYy9L?=
 =?utf-8?B?OExra2YrSHU0UzNCOTlmdjAwMUFod001MXk1VUdtUjU5cHk5S2Rtb0hudDZy?=
 =?utf-8?B?SHl3cXFGR3RJNDFhOFNvSlJXVTJCUDU1S0k4c2RTL1I4WkwrRUtacFN2N2ty?=
 =?utf-8?B?NUgrdTlNVGdCTUdnVXJSbm5KbGU0dnJVU24rZlhUeHFERkF5N1VzVWhSNklt?=
 =?utf-8?B?amlZdStWMU1BNE5HcUNNbjRDckRSWFNVVUlzN0VYa2xFeWJIcGVaUEFNem1j?=
 =?utf-8?B?aGthSDZ4WUV3QjdJTUY2dm5jWWpXek0ycjlucGtvZVNjVUhnU1VLQUxWWE1E?=
 =?utf-8?B?eFQvT1V4OXBzbXpGUnkwYUxVWTA4RnJLZ2N2QmN0Zm44Sk02eUFmV0I5MVhB?=
 =?utf-8?B?SDg1eDhYTEZMNFRiY0lSdTZMRUhNSmtsZEM4SmM1YkgrdExLVFpIc0ZZekxj?=
 =?utf-8?B?UHFpSDZlNVp0SjFuVTZ0Q3pIZTlIeW1JT3VMakhqT1J3U0hodVV0eG1KaGlE?=
 =?utf-8?B?L1RwL3hCS3owYlRFYTVCVzMwQmlHQVNjSmtwNUF5SGc3cjU0VHBzTk5FR1Jr?=
 =?utf-8?B?OGpiNGVPNTErdE5MYXN5eTVpS0puR24zeGhDWEpUOUxmV3VBUWpZS3NBeUU1?=
 =?utf-8?B?STBzN3hySlRJT1ZwaFhuV1pndHRHbmZwVnJpUmVFa1N2Nmd0ZFZEYVN2Sk9D?=
 =?utf-8?B?c1dIeWZaM3d4aWdnZ0V2aW5zS3NaakRKbEdKT1pKUzNXSldzR1VNckVvNC8v?=
 =?utf-8?B?RFNyVDRJekZ3Q3ZIdWlmS2JUblJ6SVZON05MOEoxMWR5R3kveVNMOXAzVW1F?=
 =?utf-8?B?M2hZaGVWUkNOTVdPdmo1Rzg3UjBGU2tUWm5QZUQ0VFc5elJlYXRabmdTMWNw?=
 =?utf-8?B?aG5Ha1dtNXI4MnBhSDBEQlpxY1BRREpzNlZkRWFFc2F5ZkpVYlU4OFUzdDhl?=
 =?utf-8?B?alZuUHV0SzNWazJSeXRxVDdmRkVaY05JQ0g1Rnhqc0lSQ2dLdlRoTk96RU9V?=
 =?utf-8?B?bmsrTVpBamtWQkk3MUExS2FzOGpyTmowU2lxV2hxejVsVXVyN0Vpd3p3MmVx?=
 =?utf-8?B?VVdEd2hpSmd3Y3JkR1NvR1ppdHBvUzhGMUxaWHBVc1R0WkY5RURUNktTc0J3?=
 =?utf-8?B?QnNIbDM4OStMT3hud3RaQmd0cS81VG5ZU0oxcVpUWW9ueG9aRkZTZnE1LzVC?=
 =?utf-8?B?ZjJHOTdMMDN2WlphNndMdmg2ZFk5SWlGU2NSTkRrN3NWWWRnaGkxVXdFYzkw?=
 =?utf-8?B?bHpUdnYwYXlvdFNDejhlVTBSSUxwRVpDZEFMd3FTZmZLRFRDWEFrTFVqNFZE?=
 =?utf-8?B?SFZHR3hCdmVqRTBMeGdjOG5nQkk0YjdQUEVMMzJsdE1adWIvTkZXNnVjai9B?=
 =?utf-8?B?eHd5OXZGejBXM09mNVkxa3pGNndJRFhmbG4xd0JiRnZEWWRHZVhLc3dFdW03?=
 =?utf-8?B?cFlRalZYWENCVk83TGJMK0d2SjBoWUxSRjVwNDFJL3NiZWE4TkRMTVZLcWdw?=
 =?utf-8?B?Q1c0amNkMnVlb2FISXkrTVAyV2lnOFBCTmZTdDNpaXloVkRGcWxHRXA0VVhj?=
 =?utf-8?B?ZXBUd2dRdHF2cE5YS0pNREpkY1k3TS9SR0VEL1VXQnY4TE9VSUhZQVZMcjJ4?=
 =?utf-8?B?U3I5QTlvOHVrWitOa2t2RVFjMGo1RWpuTzE1M3Npa29weUxQc055VEcwcFB6?=
 =?utf-8?B?bzZIVm1PbXpwVTgvZjQ5ZmNRNjUwUGVpckE2aGZiUFMzSml4cnNiRmFKWThB?=
 =?utf-8?Q?rLap0I2o/rq3uASVkqVzCZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5QUnZYTy9lbFM1VStoK21IN2w2ejZBRDlnRXhuSk1rQUpxbzlmcThIWlhC?=
 =?utf-8?B?dmYwY29uMnhZYjNsdm8yNGxhVUZmUmVvLzFPN0o1Zk43UVlpdXNBRUxDbndh?=
 =?utf-8?B?cG03aWE4VjNIVHBWc2hrVThYWC9rZ2ZaTm5IaHAwNTUxak9RN2RleUpsNlFz?=
 =?utf-8?B?R0tQNEliN0dzN0w5djJsS0llUjVZZGRUeEtFS2lDZnV6cTEwbjExZWhVeWpN?=
 =?utf-8?B?R2F5Ni9SY0RCaitQYVZ5QkpnbGhPWnh1ZzNqbmRkUTVxUVdEWWt3T0JROEVm?=
 =?utf-8?B?bGRZRmpoYkNmU2Z0MkwzdDZHd1lYdGlhTGZSSGcyVENBZlFXV2JIckxDU09w?=
 =?utf-8?B?b1hCTzZOMkpPdVpENm1rTjFxYXZVcE1hY09CdFMzRHV2ZEl3djVJVDZCaTQ1?=
 =?utf-8?B?SnRoZUw5T29XbWVZWmVlYWdQQkVaQjJRUVpTd1M1a09OT01ZREc4QmEvUllQ?=
 =?utf-8?B?Mk8ydVR3UE55VzZFR0h0OHJBak05QXJRVFF0NnhTeXIxUE84ZXRucHozT3lx?=
 =?utf-8?B?V1lCYTA4V0lDNUlSVy8xeEdBQ2xOTHljM3JlQUZnWG1ObVlSajhzTDF6cGE1?=
 =?utf-8?B?bTBUTUVoTm5jY2ZyVTdtUHhPZExmUGtOSS90R0lTYis5WUppejlSekFCekZE?=
 =?utf-8?B?VVZyUlVuOTM0c21SWXpweXYwN1hqYlN4SmVBMkpKam1vZjBseUNRZnE3azJO?=
 =?utf-8?B?NWlmTndiS0FkZ3hkK1VoV2h1TXYreUlNMlVhYldKVzU1QkJBcllGQjV1NnMv?=
 =?utf-8?B?bVp2VFU4cHova1dLQVZpY0RMMTl1clN2UW0yYnV6cHdnWlV5SHVCZnZvWW1C?=
 =?utf-8?B?OHYrZmdRbDdBMXl3Z2drcTNaRzFCaWRYZ29TeHBZWW1oT0pRT3cvVDlLbHNm?=
 =?utf-8?B?SHlmL1lBMkwzTlcrU0Q2TVBkUldPbENpYlU2REdTTE5FR3R3aE05NVRxSmFz?=
 =?utf-8?B?YzVnZlEyaXZHdWNWVTN3b04xRnpCSzJnSHRoOWFKdCt6ZWQyTU9jZ1VTU3dP?=
 =?utf-8?B?L2FxV1BOSUZ0L25takEvdUZxOWRSeHpOUVkwc1FzWjB5VWJTcW4rL3FDRVh0?=
 =?utf-8?B?N0tzekw0N3BXVGVJR3ZxQmw5WEh4V0dQZ3Y4a3RsQW91UGw5RkhtZFJ5d011?=
 =?utf-8?B?YmhnWmcwc1c3RlhNam53bFNsbC9UazRSQVRmVXlUaGJQSER0K1RHVC9QT21s?=
 =?utf-8?B?YWw5SlZzTVVvbXlSOUJrcUExWVVZUnBONWpGaGtCYnFPSWRUSFBxTkFoeU1w?=
 =?utf-8?B?Wk0wSG5MNTUxNFhLT29uQUxLUW5ZWmd1RytxWmNvVHhMZzdZOU56Q2VHcXFv?=
 =?utf-8?B?QTY2K1BhVElBZ0VhS2h4bmk3TERleDZCa09EUERJbXBNTDRaQ0pZcjh2cW1S?=
 =?utf-8?B?RUFRQWorZzQvKy8rY0R1ZlU2UW5ZSVM3c3liZGZTZzBjNW80SWJkSmlvK2Ex?=
 =?utf-8?B?aWNyVWdMR3FhcE1memlGdkxqbTllditDUnpXU1p5U2JVNEd4MFFGdzhXSFhz?=
 =?utf-8?B?MXQ0MHlRYVVmYmNjZTlQV1F2Vk9XUEduNG51NzFZTExMSC9NOUUrTWJYbThP?=
 =?utf-8?B?czVQclYvWGQ5c1Z1dEJ3dXZsOUd4bUF1NEJPazE5eE5rc2dBM2dEZHRqMVJY?=
 =?utf-8?B?MzVCQmJycnBBZ3JGaEEvR0pKYjFNQ2lKS2Q2ZHkweE0xWkZSYUtTdlNRQXZF?=
 =?utf-8?B?d2oxKzBDVTNHUWtZcDZlSS9Ic3lCNmZnWFJyQUJUd2JRcjVNZ2p3ekMySFEv?=
 =?utf-8?B?Y2pHRUw0QlJOVkxzVG9HOGtTMi9wVGNOaTFxcFJBclhrd2pFUDNGQmpEOE0x?=
 =?utf-8?B?Q2FCUXMxK3lMMkNCelQ0TmdpVGthK1VpZmFvcHprbjNSREl1YkdoYThmNFNZ?=
 =?utf-8?B?bERNUm1JU2JuWWs3RWE1RDJNcEhuYVdwWUxjamJKbERYTVNrVDZObHlyMFFh?=
 =?utf-8?B?a3MxYUlFS0YzcElhYVFjZVR5VTBycTlmOWNaUEdaTlNWOVRpRWVzUnRYSXM5?=
 =?utf-8?B?RDNxQWZFNFYrNjhXTDUvaXJudzQ0dkdQRlJTVURuZVBvTDVxbEd4VWFOZTlW?=
 =?utf-8?B?aDJqRnhNMzhodWlDc0ZhM1ZVbzlWWisxVTlXR0pXYUNGU2pFbThLUUJrNmw1?=
 =?utf-8?B?YjBnRkpnMlVDTmxRZEhrOWtPOWx6YnhGa2lPL3M1Mkk1N0lWT1gyeEZPVHFi?=
 =?utf-8?B?QzNNZGZlVE1Rc2JqUktDUkNQVUh3VmxaQStzTTUwZGZjQ0JlZGZDbVRaSjBI?=
 =?utf-8?B?VVUxUlBub0ZIUFQ5cjFkNUpiUFBPam1pRW12UU05eElXSDl3RnVyUGVDVmxH?=
 =?utf-8?B?YTRQbTFtdzJneW94bWtkelNvenJOalhsS2g3UDJ2SFpnM2lyako3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6126a5db-917a-469f-4f76-08de6714c2d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:20:00.0930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N4/Nh5hKN5sLchUXTsW5/DRyU5c0Q/tb2W8LqPvytLiKDHqQIzrWchxVjvXLyQiTXOYi68wsWChlMiL0pCHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813
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

Both the two boards have clk framework enabled, so rely on serial driver
calling clk_enable to enable the uart clk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mm_evk/spl.c | 2 --
 board/nxp/imx8mp_evk/spl.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/board/nxp/imx8mm_evk/spl.c b/board/nxp/imx8mm_evk/spl.c
index cd251d274ff..c5b82a42968 100644
--- a/board/nxp/imx8mm_evk/spl.c
+++ b/board/nxp/imx8mm_evk/spl.c
@@ -109,8 +109,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	timer_init();
 
 	/* Clear the BSS. */
diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 5b4aac42830..27cd82e745a 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -102,8 +102,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	ret = spl_early_init();
 	if (ret) {
 		debug("spl_init() failed: %d\n", ret);

-- 
2.51.0

