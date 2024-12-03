Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3CE74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF5D896BC;
	Tue,  3 Dec 2024 20:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="arJ90mQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6E189698; Tue,  3 Dec 2024 15:38:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A2A893CB
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSxqxfHUTMHRoKkVuFPmWWV0wECjLJ3SkrBl6cuJ2tsG8JlB2cmg1D4Qy61ZHFDFAV8y5vLzRkO0S79gd2ITetbdMxktLailNacpWDJ612VxcWzj982J699l3uHiEdfUyTxqa6LnrR5/0bkZeAjPH02b/HKhPf9qEk07bn8mABG+SaKq7Lkc5odOdlg+klhO4xDUb28ZXgSDs9G4PcxY/BSWd8Xvz1Ml5GhfysNAFzgy+2GedXVdJzg75/lmhOr8+Ge7SJfjlHOQfzCFUENwp5r8M8l0C9dGUlCw0YZz4u1WnjQzUrVHYsh3KVbGhiYTA4UmRlj9Vc0Dr6J7J7eTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBuPfUC4GV5P+/zwUmWzG2yAaLu9v3JXeHmT2XD3i2Q=;
 b=TsbM8nzXnwUcDeDYV08uKZDBqNO19OcbTM6ng6q2IaemUDyrx30pusbnooombXEiKtXnKAP84Olcp3m7GtpMEQf6Oha9k7e+KgAufnchnX4DOK3/E1gTCBpR8EOFeOjJPuS5WEOixWTNzhZWiruetI2XNjmo33fNmjnvEAju/CyKNIiOG6WctW2il60mPBJ92VKPzcjF/qrqb1unFDIE1e0i7MqMkfalGzhdeSYbm6GRk28OVrPl9m3ol+mIDhyC5Pkrj/zMwncW/D3e4GzFGaJ/JZ17aNDSCkXqItzPNFOQdtBlH2ouHrNQCIDk7xqmMuO38R2ApweAhBz/SbE38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBuPfUC4GV5P+/zwUmWzG2yAaLu9v3JXeHmT2XD3i2Q=;
 b=arJ90mQJfE4JAc4HbAyIilfr7QGrqVn00uWj/Px67sMjyF1e9QV0jJ9ubgSfIiF0R3ISxKGaIT8IK3IuZfmswP/eBkl1oyazu9N5xmkXdto9mahitpTI70CLlSLhoHBfksFN+imm16AIh2CN/imKWWqn5I+VSTzj++YxrNiEXvywb8lQpsKVcpJrtAJKBn58BdGJtC8xNcobkegt+BA8CSDRbKDZSbO1WCAfH7cogaDvKpDn7NaW15T/k9cUN31CIcPgW4XOB44WfXbtyzAP2kQQxxkJA40MAVRvkYVeoDq6BMiSYIR8K8p2N/LVAvnj6WxBqOdWoTpbltQQW+niFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:48 +0800
Subject: [PATCH 05/11] imx: Add iMX91 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-5-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 761558fe-c10e-4c4b-6f5b-08dd13a813f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3VPa1o5Z2FxQVNselBuNDBmNXBDR1YrZGExR0NqNzMxVDVYY1dodUxIZlZs?=
 =?utf-8?B?TUlIOTVqUUVCZC9Oc09zYjhwRFk1cmhSOEE4S0NSeE1FSnRZTTVhaVBMRmRH?=
 =?utf-8?B?b3pEZ2hmVWJxUXdtd2NvSUtDanM5ZFZQRm9ER01mMDdqYkxNeTVIa3BKR0Y1?=
 =?utf-8?B?ZHFGbVM2UWU1YVRxWkQ4TndadW51VklQVmlaSi85eHFyQTBxdEgwMjlhRmY4?=
 =?utf-8?B?V1RWZnNNam5zL1BmZHJuN3Z5TXdsS3BKNnVlMHhTR29XZTZzWTA0aTVSNUk1?=
 =?utf-8?B?ZFNVdUp2ZHBXWmFtb1dKV3ZBOEdRTFZTY3llNEYyVFd4SlRNZmo4S00wR25M?=
 =?utf-8?B?eHBsTTJzL0dhajJMdDBaTWU4dExnTWdWKzBHK2hzZitRTGhSaENIL3cvNTZl?=
 =?utf-8?B?SERnN1REMnhFQ0syelFTdjdORStIVGpsZWdlZ0x6aWN1dXc1dHc3Q2xrdDNa?=
 =?utf-8?B?bTdJRXpramR0OFhOR0d3Vm8wMkVrbzVWNHVlbW02cER5THk2MnZ0Z1djMWU0?=
 =?utf-8?B?OXVFQ2ZUWTRycHQ3K1RDbEorVHgrZTFUN1ZXUDF2U3R2MU55R09PeDF2elJJ?=
 =?utf-8?B?aVdkYTRKUDVJRDRURFBWT0V4YXdsVk1YOFZEWmZMTEhZdU9sU1NMUWtvbk1Z?=
 =?utf-8?B?WkpXMmoyMEdPV2tOTnoxU1NOM0N5TS9IeTkyZ2xEc2V3R3Vsc1gxN1RmeUov?=
 =?utf-8?B?RHhDRE4xY1VpQlNyWTMyUStKemh5ak5XczlGbGpvNGFlMkptSEtMYlZJWldn?=
 =?utf-8?B?dGQzVGNBS21EbEVnUjlHclJRUWZyQVZpYzZneDhmYm00SnFJa2lhZnVOT0xI?=
 =?utf-8?B?eFBRYkY4U0o5Wkh3V0xha0ZObkxLWFMwQUlnYjBNYmtGSHhzYlI4cmhXZVZu?=
 =?utf-8?B?a2tyY0FHT2haNVBGbUZrMEVvYnNwTnRYZFAvMUZsbUR2MStLa2RONWFnWVBi?=
 =?utf-8?B?cGFqQ3Y0TkUxOXR0cTgxWmZCeVduaUxBOGhmaitFQ0pMcnlPRGNrRm04VlFp?=
 =?utf-8?B?U3JLdnFud2plR3BBM0s5bTJSU1FtVTdlNkFWdXQ0a0RCc0RDVDUwN1lNMGRj?=
 =?utf-8?B?eURCZUxQRytwVzliOUZ0Z2FYajVnaEZ6RU55emxWSkM3SEpiRUVienBIRHFX?=
 =?utf-8?B?V3l0SmQxK3pPZGV5TTFzaXErNE1yaGpYZFdTZlA1TmZKWVVHTUsyYXNkY251?=
 =?utf-8?B?Wk0zSmQ2MDgyUTVONFFsTmVuejR6NkdsNzZjbjZBclE0UGtoZFRSU3U2ZVRM?=
 =?utf-8?B?a1VsWUhML3M0RndHa0V1ZXFSSFdrUUdjMnZaTjI0SnpGUGxCbnY3OWlZUGpD?=
 =?utf-8?B?MitDTjAyQlNQMkVyNFBHUlNyK0ZISnpKTGtLRWwvNDBpSDFIWlBteVBSelN5?=
 =?utf-8?B?TE0xQ3RHRkRhTGxYaDFDaTNZY2RuQ01wOG91MTVoeXNXN0VocTVxR3NFbnFU?=
 =?utf-8?B?U3dZSlNINEVyQnFqdzhMcmJKT2p6RXA3emo5N2dLdkZldVNlWHpVQVdGQmVh?=
 =?utf-8?B?WUY0dVJJdjRHRWplWnBSV3dRcGdianZDNHZ6TUNUeXRrUURTTDBPcWpGYzNV?=
 =?utf-8?B?Z2VHR05IK3FKTDBXNG9wUlhsTHkwS1dzYXN5dy8wTjNScnBoNGtkdVB3ZUNT?=
 =?utf-8?B?Qm1kUDFNSVdiRFgzWCtiR2xTakhXQnZJVXBMM1NNdUwwZ0J3NGh5SThxMWk3?=
 =?utf-8?B?M0lNdWRNYmR5KzlRQlFvcXVkSERBVVpya2tqK2FUUFk5UG5nNEFtMFJvbU1E?=
 =?utf-8?B?TmpQU0tiYXN2VktHTmxFK1NSTlV5dWcwMHhJVzIvdnlsaHpZd3N4Wm1naWdL?=
 =?utf-8?B?a0NvY01tU0tSaVZYOHZpVFRUSCszUzBoUVQ1akJwbmxET0dKYXczL0R1Z2ta?=
 =?utf-8?B?RzJKMEZEaUZUSmZPTmhCajhVV0FJQkNwOU1GUk5EeDB6Ymc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25JUEd4d2VtNVhCRDAwVHBWZDR4ek9rRTg3bGpWN0Q5NGxadXNnVU40cENt?=
 =?utf-8?B?R3FHbFZnR3lkYnRBenc4V0dPM2FtRXF6clBGbW9JUVdMNkwxVXdqYmRVZnlX?=
 =?utf-8?B?Q2piZzkremxsWjZubGdqSE5CTkFBb2JNSE83bzh0UWRkQzdSN2JJSGowUDNh?=
 =?utf-8?B?T2huTnFnbzNRR3lhVnBaZ2szSFM5UTJ4ZW05dWtlUTZucWg3eVJWdExFL29j?=
 =?utf-8?B?bGZXYUJxZEhldnA3a3JkZXJVdkEvQ0ZramFBeHdyalp5bHQ4U2NraHR3ZzZx?=
 =?utf-8?B?WU5OM1BXSFlOdmN0VWJpTjlWRDJCL2d1U3RjalNHN3ZCZzk0K3pVOTVkZFBH?=
 =?utf-8?B?Nkw5dmhwdTl0YUwzYkdkVWE5VTJXeFRCSWlGR1JOSmVkd2d0L2E4L0tySUxP?=
 =?utf-8?B?SHNHQnhCQy9PNlRBTEg2WVZxcmtzd0ZNQmsxZXhPVEFaQkV0VlI5dXJFc1NL?=
 =?utf-8?B?Wkxpb25NcHRoa0JhZUhsazQ1bVF3NU4zbnk2NGNiTC9HWVNaVzgzejhmZGhP?=
 =?utf-8?B?Smh0TGNuamlkdmx1eXZ0ekU5V21TU0lkKzFpclNlUS9pTDM3cVBJQVlocDBO?=
 =?utf-8?B?MjE3bGxOWVFVUjV1ek9MaFFPUDZjUEFjMGJ3RDZ2dXpsOVhYRE5yZEhYcFVN?=
 =?utf-8?B?VFVkM1pCQmVCR0M4MGZ5QjZSL0hDN2dMdnNOd3RYNlJyVmtGN0lRdXcyUlV6?=
 =?utf-8?B?Qjh2UWl2TUw1djI0NmNHd2JBOU4valZjVVdoVm1wVnV6RWszVWhwN0RxZUFi?=
 =?utf-8?B?MTM0SEppZW5waHFoTXRUNHRBaG8rR1JwOHdWRXlUb2lvVjJKNlRnS0UyYWJB?=
 =?utf-8?B?SHFCc0xhSENsTTNFREsxdEx2c2FpTVlEVVhOaEVlMmtNSjRvMUo4UFBWWGZn?=
 =?utf-8?B?ZW45QUpKQm9KQzZnbW5qVUJtTUZ0K015RDI1WjlCcEhwdElTL00rY3dpaG03?=
 =?utf-8?B?cGFmeURoMkNWYXVnVDJja2JmNFhpdElxQnJpOWsvUEplNGc1Q281QUZTMkxV?=
 =?utf-8?B?RlhLNjhBdVZzd056bFBWdS9ERlhDUWgvbk5Rc3N3UTAyU1hwVUY1K3ZKUkRO?=
 =?utf-8?B?a2J2YW9XNkVWNTFmcXA3dU80bHNmZ3dNUjM5U284YW9yOTdmWERPMCtIU25p?=
 =?utf-8?B?aGdGQUJLUkY2WmRQVzlyYnNKTGJsR3VHUzZDUXpWMVpwanV2WjdTbjJvQWVu?=
 =?utf-8?B?TGoxdzJadjZXUXJESHhGTnV3aVZUWlNpdG8rU0MwNFhndkFSOEhsdlNFdjRh?=
 =?utf-8?B?S2l4c1dCdnAxejV2ZVdxcFc0UXNYcGREeG5VVkNCV3p3aUgrK3VCcTJlYlFv?=
 =?utf-8?B?QmlLbnlQbHFHSk8wSklmV0tlZlJCTld4Y2xOeGtXWkZyRkR6UGo3YjBRUzdS?=
 =?utf-8?B?WXFSL25OQUYwcFN1UG9ObGlzR2tFTlFIbnJzVncwTXRZVFZJaHVCaWRCc09B?=
 =?utf-8?B?Q0JaUWRMckF2NVZGaGpkaStKd2d5ci9ULytlQnZZVENVN1ZzMmZOeHB6a2Iv?=
 =?utf-8?B?bWlyNUh5RkYyVldtb2pUQjB6am5YaVh1ZjlPL0lzSm1LQ2N1b0RhdGJQUDhl?=
 =?utf-8?B?cnMyd1cySWQvcmNzdzRrNVN2M2dqMExxVHRwMTAvZkZBd053SmhXUTBta3cr?=
 =?utf-8?B?VG9tQWZnNDNTTDdTTmhPdTY1UmNuMDZCVFJnOEVtUFd0VVU3Y25qSjZjR3o4?=
 =?utf-8?B?UXp1RThsKzhiR1dobkRIbW1qUjdiQUltMWd1cFVXbmFEd0ZXMTBFQzlabWJm?=
 =?utf-8?B?dHduYXpRTWRCcUMyNVdTTzN1eHRFUXlNYjBHZHJTR2hxdDRJcUcwNzB2WjMv?=
 =?utf-8?B?bThneXd3U1F4K2JKRWhMK25naUFpZVlTYXUzcTFzQXpGWGJ0OFpxNHprVVFH?=
 =?utf-8?B?VTRIcFZUTXhrQmZKcUJUendCUjM2dkFUY0xLVFovQ2U3VngrZUw5OGMxZVVy?=
 =?utf-8?B?R1FMR3lqbndUVWlpRFE2WTJLNXlWdGJGUDZuVkRrbnpMVWttNm5iZmd0WDNl?=
 =?utf-8?B?VGRtV0o5VkRFUnM2SEdFREtpem9uQTJLTFlnWlpYN2llNDFqTXNwOE5CRmt0?=
 =?utf-8?B?WWRCejJxYzZNZ0pteTM4ZVhUYlFJRkxUVW9RRHA2NU9tM1BiLy94U1VRWmJt?=
 =?utf-8?Q?Msd2H/yQQIiBoV/RZztn+50F3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761558fe-c10e-4c4b-6f5b-08dd13a813f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:57.2092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5wMf/zcFvswpjL5hgFD8sSwPOlhYT1ZbPU7VGtmcgDZKCkOd6hd8dm5rSGZ48icBNdylezvcGRIiyGuMS50Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:40:44 +0100
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

iMX91 is reduced part from iMX93 with part number: i.MX9131/11/01
It removed A55_1, M33, MIPI DSI, LVDS, etc.

i.MX9131:
  - Support 2.4GT/s DDR and HWFFC at 1.2GT/s
i.MX9121:
  - A55 at 800Mhz and DDR at 1600MTS, with low drive mode.
i.MX9111:
  - Support 1.6GT/s DDR and HWFFC at 800MT/s
i.MX9101:
  - Support 800Mhz ARM clock
  - Support 1.6GT/s DDR and HWFFC at 800MT/s
  - No parallel display, eQOS, flexcan

Updated Clock/Container/CPU and etc for i.MX91

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h         |   5 +
 arch/arm/include/asm/arch-imx9/clock.h      |   7 +
 arch/arm/include/asm/arch-imx9/imx91_pins.h | 770 ++++++++++++++++++++++++++++
 arch/arm/include/asm/mach-imx/iomux-v3.h    |   2 +-
 arch/arm/include/asm/mach-imx/sys_proto.h   |   6 +
 arch/arm/mach-imx/imx9/Kconfig              |   6 +
 arch/arm/mach-imx/imx9/clock.c              |  37 +-
 arch/arm/mach-imx/imx9/container.cfg        |   6 +-
 arch/arm/mach-imx/imx9/imximage.cfg         |   6 +-
 arch/arm/mach-imx/imx9/soc.c                |  45 +-
 drivers/cpu/imx8_cpu.c                      |  10 +
 11 files changed, 882 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index b0468a1a1364e13e1a7eb211979c5d3f280e0c16..0d7a573461690046b27498c7174459110a73689c 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -71,6 +71,11 @@
 #define MXC_CPU_IMX9302		0xC9 /* dummy ID */
 #define MXC_CPU_IMX9301		0xCA /* dummy ID */
 
+#define MXC_CPU_IMX91		0xCB /* dummy ID */
+#define MXC_CPU_IMX9121		0xCC /* dummy ID */
+#define MXC_CPU_IMX9111		0xCD /* dummy ID */
+#define MXC_CPU_IMX9101		0xCE /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 76f12118592cd0a83cbcaa57f8d582847ffd68f3..60d48b13b11f274c9e4c8caf20954de0431d9d6a 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -205,10 +205,17 @@ struct clk_root_map {
 	u32 mux_type;
 };
 
+enum clk_soc {
+	CLK_SOC_ALL = 0,
+	CLK_SOC_IMX93 = 1,
+	CLK_SOC_IMX91 = 2,
+};
+
 struct imx_clk_setting {
 	u32 clk_root;
 	enum ccm_clk_src src;
 	u32 div;
+	enum clk_soc soc;
 };
 
 int clock_init_early(void);
diff --git a/arch/arm/include/asm/arch-imx9/imx91_pins.h b/arch/arm/include/asm/arch-imx9/imx91_pins.h
new file mode 100644
index 0000000000000000000000000000000000000000..26246702a9607cd1ba6c8a15be9313db63b2a4af
--- /dev/null
+++ b/arch/arm/include/asm/arch-imx9/imx91_pins.h
@@ -0,0 +1,770 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __ASM_ARCH_IMX91_PINS_H__
+#define __ASM_ARCH_IMX91_PINS_H__
+
+#include <asm/mach-imx/iomux-v3.h>
+
+enum {
+	MX91_PAD_DAP_TDI__JTAG_MUX_TDI                                                  = IOMUX_PAD(0x01B0, 0x0000, 0x00, 0x03D8, 0x00, 0x00),
+	MX91_PAD_DAP_TDI__MQS2_LEFT                                                     = IOMUX_PAD(0x01B0, 0x0000, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDI__CAN2_TX                                                       = IOMUX_PAD(0x01B0, 0x0000, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDI__FLEXIO2_FLEXIO30                                              = IOMUX_PAD(0x01B0, 0x0000, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDI__GPIO3_IO28                                                    = IOMUX_PAD(0x01B0, 0x0000, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDI__LPUART5_RX                                                    = IOMUX_PAD(0x01B0, 0x0000, 0x06, 0x0488, 0x00, 0x00),
+
+	MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                                            = IOMUX_PAD(0x01B4, 0x0004, 0x00, 0x03DC, 0x00, 0x00),
+	MX91_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                                        = IOMUX_PAD(0x01B4, 0x0004, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TMS_SWDIO__GPIO3_IO29                                              = IOMUX_PAD(0x01B4, 0x0004, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                                           = IOMUX_PAD(0x01B4, 0x0004, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                                           = IOMUX_PAD(0x01B8, 0x0008, 0x00, 0x03D4, 0x00, 0x00),
+	MX91_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                                       = IOMUX_PAD(0x01B8, 0x0008, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                                             = IOMUX_PAD(0x01B8, 0x0008, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                                          = IOMUX_PAD(0x01B8, 0x0008, 0x06, 0x0484, 0x00, 0x00),
+
+	MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                                         = IOMUX_PAD(0x01BC, 0x000C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                                           = IOMUX_PAD(0x01BC, 0x000C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDO_TRACESWO__CAN2_RX                                              = IOMUX_PAD(0x01BC, 0x000C, 0x03, 0x0364, 0x00, 0x00),
+	MX91_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31                                     = IOMUX_PAD(0x01BC, 0x000C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                                           = IOMUX_PAD(0x01BC, 0x000C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                                           = IOMUX_PAD(0x01BC, 0x000C, 0x06, 0x048C, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO00__GPIO2_IO0                                                   = IOMUX_PAD(0x01C0, 0x0010, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__LPI2C3_SDA                                                  = IOMUX_PAD(0x01C0, 0x0010, 0x01, 0x03F4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                                            = IOMUX_PAD(0x01C0, 0x0010, 0x02, 0x04BC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                                           = IOMUX_PAD(0x01C0, 0x0010, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__LPSPI6_PCS0                                                 = IOMUX_PAD(0x01C0, 0x0010, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__LPUART5_TX                                                  = IOMUX_PAD(0x01C0, 0x0010, 0x05, 0x048C, 0x01, 0x00),
+	MX91_PAD_GPIO_IO00__LPI2C5_SDA                                                  = IOMUX_PAD(0x01C0, 0x0010, 0x06, 0x0404, 0x00, 0x00),
+	MX91_PAD_GPIO_IO00__FLEXIO1_FLEXIO0                                             = IOMUX_PAD(0x01C0, 0x0010, 0x07, 0x036C, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO01__GPIO2_IO1                                                   = IOMUX_PAD(0x01C4, 0x0014, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__LPI2C3_SCL                                                  = IOMUX_PAD(0x01C4, 0x0014, 0x01, 0x03F0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA0                                          = IOMUX_PAD(0x01C4, 0x0014, 0x02, 0x0490, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                                            = IOMUX_PAD(0x01C4, 0x0014, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__LPSPI6_SIN                                                  = IOMUX_PAD(0x01C4, 0x0014, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__LPUART5_RX                                                  = IOMUX_PAD(0x01C4, 0x0014, 0x05, 0x0488, 0x01, 0x00),
+	MX91_PAD_GPIO_IO01__LPI2C5_SCL                                                  = IOMUX_PAD(0x01C4, 0x0014, 0x06, 0x0400, 0x00, 0x00),
+	MX91_PAD_GPIO_IO01__FLEXIO1_FLEXIO1                                             = IOMUX_PAD(0x01C4, 0x0014, 0x07, 0x0370, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO02__GPIO2_IO2                                                   = IOMUX_PAD(0x01C8, 0x0018, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__LPI2C4_SDA                                                  = IOMUX_PAD(0x01C8, 0x0018, 0x01, 0x03FC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                                          = IOMUX_PAD(0x01C8, 0x0018, 0x02, 0x04C0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                                         = IOMUX_PAD(0x01C8, 0x0018, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__LPSPI6_SOUT                                                 = IOMUX_PAD(0x01C8, 0x0018, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__LPUART5_CTS_B                                               = IOMUX_PAD(0x01C8, 0x0018, 0x05, 0x0484, 0x01, 0x00),
+	MX91_PAD_GPIO_IO02__LPI2C6_SDA                                                  = IOMUX_PAD(0x01C8, 0x0018, 0x06, 0x040C, 0x00, 0x00),
+	MX91_PAD_GPIO_IO02__FLEXIO1_FLEXIO2                                             = IOMUX_PAD(0x01C8, 0x0018, 0x07, 0x0374, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO03__GPIO2_IO3                                                   = IOMUX_PAD(0x01CC, 0x001C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__LPI2C4_SCL                                                  = IOMUX_PAD(0x01CC, 0x001C, 0x01, 0x03F8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                                          = IOMUX_PAD(0x01CC, 0x001C, 0x02, 0x04B8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                                         = IOMUX_PAD(0x01CC, 0x001C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__LPSPI6_SCK                                                  = IOMUX_PAD(0x01CC, 0x001C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__LPUART5_RTS_B                                               = IOMUX_PAD(0x01CC, 0x001C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__LPI2C6_SCL                                                  = IOMUX_PAD(0x01CC, 0x001C, 0x06, 0x0408, 0x00, 0x00),
+	MX91_PAD_GPIO_IO03__FLEXIO1_FLEXIO3                                             = IOMUX_PAD(0x01CC, 0x001C, 0x07, 0x0378, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO04__GPIO2_IO4                                                   = IOMUX_PAD(0x01D0, 0x0020, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__TPM3_CH0                                                    = IOMUX_PAD(0x01D0, 0x0020, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__PDM_CLK                                                     = IOMUX_PAD(0x01D0, 0x0020, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0                                         = IOMUX_PAD(0x01D0, 0x0020, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__LPSPI7_PCS0                                                 = IOMUX_PAD(0x01D0, 0x0020, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__LPUART6_TX                                                  = IOMUX_PAD(0x01D0, 0x0020, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO04__LPI2C6_SDA                                                  = IOMUX_PAD(0x01D0, 0x0020, 0x06, 0x040C, 0x01, 0x00),
+	MX91_PAD_GPIO_IO04__FLEXIO1_FLEXIO4                                             = IOMUX_PAD(0x01D0, 0x0020, 0x07, 0x037C, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO05__GPIO2_IO5                                                   = IOMUX_PAD(0x01D4, 0x0024, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__TPM4_CH0                                                    = IOMUX_PAD(0x01D4, 0x0024, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__PDM_BIT_STREAM0                                             = IOMUX_PAD(0x01D4, 0x0024, 0x02, 0x04C4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1                                         = IOMUX_PAD(0x01D4, 0x0024, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__LPSPI7_SIN                                                  = IOMUX_PAD(0x01D4, 0x0024, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__LPUART6_RX                                                  = IOMUX_PAD(0x01D4, 0x0024, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO05__LPI2C6_SCL                                                  = IOMUX_PAD(0x01D4, 0x0024, 0x06, 0x0408, 0x01, 0x00),
+	MX91_PAD_GPIO_IO05__FLEXIO1_FLEXIO5                                             = IOMUX_PAD(0x01D4, 0x0024, 0x07, 0x0380, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO06__GPIO2_IO6                                                   = IOMUX_PAD(0x01D8, 0x0028, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__TPM5_CH0                                                    = IOMUX_PAD(0x01D8, 0x0028, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__PDM_BIT_STREAM1                                             = IOMUX_PAD(0x01D8, 0x0028, 0x02, 0x04C8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2                                         = IOMUX_PAD(0x01D8, 0x0028, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__LPSPI7_SOUT                                                 = IOMUX_PAD(0x01D8, 0x0028, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__LPUART6_CTS_B                                               = IOMUX_PAD(0x01D8, 0x0028, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__LPI2C7_SDA                                                  = IOMUX_PAD(0x01D8, 0x0028, 0x06, 0x0414, 0x00, 0x00),
+	MX91_PAD_GPIO_IO06__FLEXIO1_FLEXIO6                                             = IOMUX_PAD(0x01D8, 0x0028, 0x07, 0x0384, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO07__GPIO2_IO7                                                   = IOMUX_PAD(0x01DC, 0x002C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__LPSPI3_PCS1                                                 = IOMUX_PAD(0x01DC, 0x002C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA1                                          = IOMUX_PAD(0x01DC, 0x002C, 0x02, 0x0494, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3                                         = IOMUX_PAD(0x01DC, 0x002C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__LPSPI7_SCK                                                  = IOMUX_PAD(0x01DC, 0x002C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__LPUART6_RTS_B                                               = IOMUX_PAD(0x01DC, 0x002C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__LPI2C7_SCL                                                  = IOMUX_PAD(0x01DC, 0x002C, 0x06, 0x0410, 0x00, 0x00),
+	MX91_PAD_GPIO_IO07__FLEXIO1_FLEXIO7                                             = IOMUX_PAD(0x01DC, 0x002C, 0x07, 0x0388, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO08__GPIO2_IO8                                                   = IOMUX_PAD(0x01E0, 0x0030, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__LPSPI3_PCS0                                                 = IOMUX_PAD(0x01E0, 0x0030, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA2                                          = IOMUX_PAD(0x01E0, 0x0030, 0x02, 0x0498, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4                                         = IOMUX_PAD(0x01E0, 0x0030, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__TPM6_CH0                                                    = IOMUX_PAD(0x01E0, 0x0030, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__LPUART7_TX                                                  = IOMUX_PAD(0x01E0, 0x0030, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO08__LPI2C7_SDA                                                  = IOMUX_PAD(0x01E0, 0x0030, 0x06, 0x0414, 0x01, 0x00),
+	MX91_PAD_GPIO_IO08__FLEXIO1_FLEXIO8                                             = IOMUX_PAD(0x01E0, 0x0030, 0x07, 0x038C, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO09__GPIO2_IO9                                                   = IOMUX_PAD(0x01E4, 0x0034, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__LPSPI3_SIN                                                  = IOMUX_PAD(0x01E4, 0x0034, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA3                                          = IOMUX_PAD(0x01E4, 0x0034, 0x02, 0x049C, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5                                         = IOMUX_PAD(0x01E4, 0x0034, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__TPM3_EXTCLK                                                 = IOMUX_PAD(0x01E4, 0x0034, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__LPUART7_RX                                                  = IOMUX_PAD(0x01E4, 0x0034, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO09__LPI2C7_SCL                                                  = IOMUX_PAD(0x01E4, 0x0034, 0x06, 0x0410, 0x01, 0x00),
+	MX91_PAD_GPIO_IO09__FLEXIO1_FLEXIO9                                             = IOMUX_PAD(0x01E4, 0x0034, 0x07, 0x0390, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO10__GPIO2_IO10                                                  = IOMUX_PAD(0x01E8, 0x0038, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__LPSPI3_SOUT                                                 = IOMUX_PAD(0x01E8, 0x0038, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA4                                          = IOMUX_PAD(0x01E8, 0x0038, 0x02, 0x04A0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6                                         = IOMUX_PAD(0x01E8, 0x0038, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__TPM4_EXTCLK                                                 = IOMUX_PAD(0x01E8, 0x0038, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__LPUART7_CTS_B                                               = IOMUX_PAD(0x01E8, 0x0038, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__LPI2C8_SDA                                                  = IOMUX_PAD(0x01E8, 0x0038, 0x06, 0x041C, 0x00, 0x00),
+	MX91_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                                            = IOMUX_PAD(0x01E8, 0x0038, 0x07, 0x0394, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO11__GPIO2_IO11                                                  = IOMUX_PAD(0x01EC, 0x003C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__LPSPI3_SCK                                                  = IOMUX_PAD(0x01EC, 0x003C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA5                                          = IOMUX_PAD(0x01EC, 0x003C, 0x02, 0x04A4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7                                         = IOMUX_PAD(0x01EC, 0x003C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__TPM5_EXTCLK                                                 = IOMUX_PAD(0x01EC, 0x003C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__LPUART7_RTS_B                                               = IOMUX_PAD(0x01EC, 0x003C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__LPI2C8_SCL                                                  = IOMUX_PAD(0x01EC, 0x003C, 0x06, 0x0418, 0x00, 0x00),
+	MX91_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                                            = IOMUX_PAD(0x01EC, 0x003C, 0x07, 0x0398, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO12__GPIO2_IO12                                                  = IOMUX_PAD(0x01F0, 0x0040, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__TPM3_CH2                                                    = IOMUX_PAD(0x01F0, 0x0040, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__PDM_BIT_STREAM2                                             = IOMUX_PAD(0x01F0, 0x0040, 0x02, 0x04CC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8                                         = IOMUX_PAD(0x01F0, 0x0040, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__LPSPI8_PCS0                                                 = IOMUX_PAD(0x01F0, 0x0040, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__LPUART8_TX                                                  = IOMUX_PAD(0x01F0, 0x0040, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO12__LPI2C8_SDA                                                  = IOMUX_PAD(0x01F0, 0x0040, 0x06, 0x041C, 0x01, 0x00),
+	MX91_PAD_GPIO_IO12__SAI3_RX_SYNC                                                = IOMUX_PAD(0x01F0, 0x0040, 0x07, 0x04DC, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO13__GPIO2_IO13                                                  = IOMUX_PAD(0x01F4, 0x0044, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__TPM4_CH2                                                    = IOMUX_PAD(0x01F4, 0x0044, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__PDM_BIT_STREAM3                                             = IOMUX_PAD(0x01F4, 0x0044, 0x02, 0x04D0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9                                         = IOMUX_PAD(0x01F4, 0x0044, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__LPSPI8_SIN                                                  = IOMUX_PAD(0x01F4, 0x0044, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__LPUART8_RX                                                  = IOMUX_PAD(0x01F4, 0x0044, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO13__LPI2C8_SCL                                                  = IOMUX_PAD(0x01F4, 0x0044, 0x06, 0x0418, 0x01, 0x00),
+	MX91_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                                            = IOMUX_PAD(0x01F4, 0x0044, 0x07, 0x039C, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO14__GPIO2_IO14                                                  = IOMUX_PAD(0x01F8, 0x0048, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__LPUART3_TX                                                  = IOMUX_PAD(0x01F8, 0x0048, 0x01, 0x0474, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA6                                          = IOMUX_PAD(0x01F8, 0x0048, 0x02, 0x04A8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                                        = IOMUX_PAD(0x01F8, 0x0048, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__LPSPI8_SOUT                                                 = IOMUX_PAD(0x01F8, 0x0048, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__LPUART8_CTS_B                                               = IOMUX_PAD(0x01F8, 0x0048, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__LPUART4_TX                                                  = IOMUX_PAD(0x01F8, 0x0048, 0x06, 0x0480, 0x00, 0x00),
+	MX91_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                                            = IOMUX_PAD(0x01F8, 0x0048, 0x07, 0x03A0, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO15__GPIO2_IO15                                                  = IOMUX_PAD(0x01FC, 0x004C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__LPUART3_RX                                                  = IOMUX_PAD(0x01FC, 0x004C, 0x01, 0x0470, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA7                                          = IOMUX_PAD(0x01FC, 0x004C, 0x02, 0x04AC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                                        = IOMUX_PAD(0x01FC, 0x004C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__LPSPI8_SCK                                                  = IOMUX_PAD(0x01FC, 0x004C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__LPUART8_RTS_B                                               = IOMUX_PAD(0x01FC, 0x004C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__LPUART4_RX                                                  = IOMUX_PAD(0x01FC, 0x004C, 0x06, 0x047C, 0x00, 0x00),
+	MX91_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                                            = IOMUX_PAD(0x01FC, 0x004C, 0x07, 0x03A4, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO16__GPIO2_IO16                                                  = IOMUX_PAD(0x0200, 0x0050, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__SAI3_TX_BCLK                                                = IOMUX_PAD(0x0200, 0x0050, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__PDM_BIT_STREAM2                                             = IOMUX_PAD(0x0200, 0x0050, 0x02, 0x04CC, 0x01, 0x00),
+	MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                                        = IOMUX_PAD(0x0200, 0x0050, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__LPUART3_CTS_B                                               = IOMUX_PAD(0x0200, 0x0050, 0x04, 0x046C, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__LPSPI4_PCS2                                                 = IOMUX_PAD(0x0200, 0x0050, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__LPUART4_CTS_B                                               = IOMUX_PAD(0x0200, 0x0050, 0x06, 0x0478, 0x00, 0x00),
+	MX91_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                                            = IOMUX_PAD(0x0200, 0x0050, 0x07, 0x03A8, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO17__GPIO2_IO17                                                  = IOMUX_PAD(0x0204, 0x0054, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__SAI3_MCLK                                                   = IOMUX_PAD(0x0204, 0x0054, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA8                                          = IOMUX_PAD(0x0204, 0x0054, 0x02, 0x04B0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                                        = IOMUX_PAD(0x0204, 0x0054, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__LPUART3_RTS_B                                               = IOMUX_PAD(0x0204, 0x0054, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__LPSPI4_PCS1                                                 = IOMUX_PAD(0x0204, 0x0054, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__LPUART4_RTS_B                                               = IOMUX_PAD(0x0204, 0x0054, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                                            = IOMUX_PAD(0x0204, 0x0054, 0x07, 0x03AC, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO18__GPIO2_IO18                                                  = IOMUX_PAD(0x0208, 0x0058, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__SAI3_RX_BCLK                                                = IOMUX_PAD(0x0208, 0x0058, 0x01, 0x04D8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA9                                          = IOMUX_PAD(0x0208, 0x0058, 0x02, 0x04B4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                                        = IOMUX_PAD(0x0208, 0x0058, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__LPSPI5_PCS0                                                 = IOMUX_PAD(0x0208, 0x0058, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__LPSPI4_PCS0                                                 = IOMUX_PAD(0x0208, 0x0058, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__TPM5_CH2                                                    = IOMUX_PAD(0x0208, 0x0058, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                                            = IOMUX_PAD(0x0208, 0x0058, 0x07, 0x03B0, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO19__GPIO2_IO19                                                  = IOMUX_PAD(0x020C, 0x005C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO19__SAI3_RX_SYNC                                                = IOMUX_PAD(0x020C, 0x005C, 0x01, 0x04DC, 0x01, 0x00),
+	MX91_PAD_GPIO_IO19__PDM_BIT_STREAM3                                             = IOMUX_PAD(0x020C, 0x005C, 0x02, 0x04D0, 0x01, 0x00),
+	MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                                        = IOMUX_PAD(0x020C, 0x005C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO19__LPSPI5_SIN                                                  = IOMUX_PAD(0x020C, 0x005C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO19__LPSPI4_SIN                                                  = IOMUX_PAD(0x020C, 0x005C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO19__TPM6_CH2                                                    = IOMUX_PAD(0x020C, 0x005C, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO19__SAI3_TX_DATA0                                               = IOMUX_PAD(0x020C, 0x005C, 0x07, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO20__GPIO2_IO20                                                  = IOMUX_PAD(0x0210, 0x0060, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__SAI3_RX_DATA0                                               = IOMUX_PAD(0x0210, 0x0060, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__PDM_BIT_STREAM0                                             = IOMUX_PAD(0x0210, 0x0060, 0x02, 0x04C4, 0x01, 0x00),
+	MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                                        = IOMUX_PAD(0x0210, 0x0060, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__LPSPI5_SOUT                                                 = IOMUX_PAD(0x0210, 0x0060, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__LPSPI4_SOUT                                                 = IOMUX_PAD(0x0210, 0x0060, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__TPM3_CH1                                                    = IOMUX_PAD(0x0210, 0x0060, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                                            = IOMUX_PAD(0x0210, 0x0060, 0x07, 0x03B4, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO21__GPIO2_IO21                                                  = IOMUX_PAD(0x0214, 0x0064, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__SAI3_TX_DATA0                                               = IOMUX_PAD(0x0214, 0x0064, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__PDM_CLK                                                     = IOMUX_PAD(0x0214, 0x0064, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                                        = IOMUX_PAD(0x0214, 0x0064, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__LPSPI5_SCK                                                  = IOMUX_PAD(0x0214, 0x0064, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__LPSPI4_SCK                                                  = IOMUX_PAD(0x0214, 0x0064, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__TPM4_CH1                                                    = IOMUX_PAD(0x0214, 0x0064, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO21__SAI3_RX_BCLK                                                = IOMUX_PAD(0x0214, 0x0064, 0x07, 0x04D8, 0x01, 0x00),
+
+	MX91_PAD_GPIO_IO22__GPIO2_IO22                                                  = IOMUX_PAD(0x0218, 0x0068, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__USDHC3_CLK                                                  = IOMUX_PAD(0x0218, 0x0068, 0x01, 0x04E8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__SPDIF_IN                                                    = IOMUX_PAD(0x0218, 0x0068, 0x02, 0x04E4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                                        = IOMUX_PAD(0x0218, 0x0068, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__TPM5_CH1                                                    = IOMUX_PAD(0x0218, 0x0068, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__TPM6_EXTCLK                                                 = IOMUX_PAD(0x0218, 0x0068, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO22__LPI2C5_SDA                                                  = IOMUX_PAD(0x0218, 0x0068, 0x06, 0x0404, 0x01, 0x00),
+	MX91_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                                            = IOMUX_PAD(0x0218, 0x0068, 0x07, 0x03B8, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO23__GPIO2_IO23                                                  = IOMUX_PAD(0x021C, 0x006C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO23__USDHC3_CMD                                                  = IOMUX_PAD(0x021C, 0x006C, 0x01, 0x04EC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO23__SPDIF_OUT                                                   = IOMUX_PAD(0x021C, 0x006C, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                                        = IOMUX_PAD(0x021C, 0x006C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO23__TPM6_CH1                                                    = IOMUX_PAD(0x021C, 0x006C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO23__LPI2C5_SCL                                                  = IOMUX_PAD(0x021C, 0x006C, 0x06, 0x0400, 0x01, 0x00),
+	MX91_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                                            = IOMUX_PAD(0x021C, 0x006C, 0x07, 0x03BC, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO24__GPIO2_IO24                                                  = IOMUX_PAD(0x0220, 0x0070, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__USDHC3_DATA0                                                = IOMUX_PAD(0x0220, 0x0070, 0x01, 0x04F0, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                                        = IOMUX_PAD(0x0220, 0x0070, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__TPM3_CH3                                                    = IOMUX_PAD(0x0220, 0x0070, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__JTAG_MUX_TDO                                                = IOMUX_PAD(0x0220, 0x0070, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__LPSPI6_PCS1                                                 = IOMUX_PAD(0x0220, 0x0070, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                                            = IOMUX_PAD(0x0220, 0x0070, 0x07, 0x03C0, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO25__GPIO2_IO25                                                  = IOMUX_PAD(0x0224, 0x0074, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__USDHC3_DATA1                                                = IOMUX_PAD(0x0224, 0x0074, 0x01, 0x04F4, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__CAN2_TX                                                     = IOMUX_PAD(0x0224, 0x0074, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                                        = IOMUX_PAD(0x0224, 0x0074, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__TPM4_CH3                                                    = IOMUX_PAD(0x0224, 0x0074, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__JTAG_MUX_TCK                                                = IOMUX_PAD(0x0224, 0x0074, 0x05, 0x03D4, 0x01, 0x00),
+	MX91_PAD_GPIO_IO25__LPSPI7_PCS1                                                 = IOMUX_PAD(0x0224, 0x0074, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                                            = IOMUX_PAD(0x0224, 0x0074, 0x07, 0x03C4, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO26__GPIO2_IO26                                                  = IOMUX_PAD(0x0228, 0x0078, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO26__USDHC3_DATA2                                                = IOMUX_PAD(0x0228, 0x0078, 0x01, 0x04F8, 0x00, 0x00),
+	MX91_PAD_GPIO_IO26__PDM_BIT_STREAM1                                             = IOMUX_PAD(0x0228, 0x0078, 0x02, 0x04C8, 0x01, 0x00),
+	MX91_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                                        = IOMUX_PAD(0x0228, 0x0078, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO26__TPM5_CH3                                                    = IOMUX_PAD(0x0228, 0x0078, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO26__JTAG_MUX_TDI                                                = IOMUX_PAD(0x0228, 0x0078, 0x05, 0x03D8, 0x01, 0x00),
+	MX91_PAD_GPIO_IO26__LPSPI8_PCS1                                                 = IOMUX_PAD(0x0228, 0x0078, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO26__SAI3_TX_SYNC                                                = IOMUX_PAD(0x0228, 0x0078, 0x07, 0x04E0, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO27__GPIO2_IO27                                                  = IOMUX_PAD(0x022C, 0x007C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO27__USDHC3_DATA3                                                = IOMUX_PAD(0x022C, 0x007C, 0x01, 0x04FC, 0x00, 0x00),
+	MX91_PAD_GPIO_IO27__CAN2_RX                                                     = IOMUX_PAD(0x022C, 0x007C, 0x02, 0x0364, 0x01, 0x00),
+	MX91_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                                        = IOMUX_PAD(0x022C, 0x007C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO27__TPM6_CH3                                                    = IOMUX_PAD(0x022C, 0x007C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO27__JTAG_MUX_TMS                                                = IOMUX_PAD(0x022C, 0x007C, 0x05, 0x03DC, 0x01, 0x00),
+	MX91_PAD_GPIO_IO27__LPSPI5_PCS1                                                 = IOMUX_PAD(0x022C, 0x007C, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                                            = IOMUX_PAD(0x022C, 0x007C, 0x07, 0x03C8, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO28__GPIO2_IO28                                                  = IOMUX_PAD(0x0230, 0x0080, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO28__LPI2C3_SDA                                                  = IOMUX_PAD(0x0230, 0x0080, 0x01, 0x03F4, 0x01, 0x00),
+	MX91_PAD_GPIO_IO28__CAN1_TX                                                     = IOMUX_PAD(0x0230, 0x0080, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                                            = IOMUX_PAD(0x0230, 0x0080, 0x07, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_GPIO_IO29__GPIO2_IO29                                                  = IOMUX_PAD(0x0234, 0x0084, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_GPIO_IO29__LPI2C3_SCL                                                  = IOMUX_PAD(0x0234, 0x0084, 0x01, 0x03F0, 0x01, 0x00),
+	MX91_PAD_GPIO_IO29__CAN1_RX                                                     = IOMUX_PAD(0x0234, 0x0084, 0x02, 0x0360, 0x00, 0x00),
+	MX91_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                                            = IOMUX_PAD(0x0234, 0x0084, 0x07, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                                          = IOMUX_PAD(0x0238, 0x0088, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                                            = IOMUX_PAD(0x0238, 0x0088, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO1__GPIO3_IO26                                                  = IOMUX_PAD(0x0238, 0x0088, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_CCM_CLKO2__GPIO3_IO27                                                  = IOMUX_PAD(0x023C, 0x008C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                                          = IOMUX_PAD(0x023C, 0x008C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                                            = IOMUX_PAD(0x023C, 0x008C, 0x04, 0x03C8, 0x01, 0x00),
+
+	MX91_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                                          = IOMUX_PAD(0x0240, 0x0090, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                                            = IOMUX_PAD(0x0240, 0x0090, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO3__GPIO4_IO28                                                  = IOMUX_PAD(0x0240, 0x0090, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                                          = IOMUX_PAD(0x0244, 0x0094, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                                            = IOMUX_PAD(0x0244, 0x0094, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_CCM_CLKO4__GPIO4_IO29                                                  = IOMUX_PAD(0x0244, 0x0094, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_MDC__ENET1_MDC                                                   = IOMUX_PAD(0x0248, 0x0098, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__LPUART3_DCB_B                                               = IOMUX_PAD(0x0248, 0x0098, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__I3C2_SCL                                                    = IOMUX_PAD(0x0248, 0x0098, 0x02, 0x03CC, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                                             = IOMUX_PAD(0x0248, 0x0098, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__FLEXIO2_FLEXIO0                                             = IOMUX_PAD(0x0248, 0x0098, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__GPIO4_IO0                                                   = IOMUX_PAD(0x0248, 0x0098, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDC__LPI2C1_SCL                                                  = IOMUX_PAD(0x0248, 0x0098, 0x06, 0x03E0, 0x00, 0x00),
+
+	MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                                              = IOMUX_PAD(0x024C, 0x009C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__LPUART3_RIN_B                                              = IOMUX_PAD(0x024C, 0x009C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__I3C2_SDA                                                   = IOMUX_PAD(0x024C, 0x009C, 0x02, 0x03D0, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                                           = IOMUX_PAD(0x024C, 0x009C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__FLEXIO2_FLEXIO1                                            = IOMUX_PAD(0x024C, 0x009C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__GPIO4_IO1                                                  = IOMUX_PAD(0x024C, 0x009C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_MDIO__LPI2C1_SDA                                                 = IOMUX_PAD(0x024C, 0x009C, 0x06, 0x03E4, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                                          = IOMUX_PAD(0x0250, 0x00A0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__CAN2_TX                                                     = IOMUX_PAD(0x0250, 0x00A0, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__GPIO4_IO3                                                   = IOMUX_PAD(0x0250, 0x00A0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__LPI2C2_SCL                                                  = IOMUX_PAD(0x0250, 0x00A0, 0x06, 0x03E8, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                          = IOMUX_PAD(0x0254, 0x00A4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD2__ENET_QOS_CLOCK_GENERATE_CLK                                 = IOMUX_PAD(0x0254, 0x00A4, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD2__CAN2_RX                                                     = IOMUX_PAD(0x0254, 0x00A4, 0x02, 0x0364, 0x02, 0x00),
+	MX91_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                                             = IOMUX_PAD(0x0254, 0x00A4, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD2__FLEXIO2_FLEXIO3                                             = IOMUX_PAD(0x0254, 0x00A4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD2__GPIO4_IO3                                                   = IOMUX_PAD(0x0254, 0x00A4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD2__LPI2C2_SDA                                                  = IOMUX_PAD(0x0254, 0x00A4, 0x06, 0x03EC, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                                             = IOMUX_PAD(0x0258, 0x00A8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__LPUART3_RTS_B                                               = IOMUX_PAD(0x0258, 0x00A8, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__I3C2_PUR                                                    = IOMUX_PAD(0x0258, 0x00A8, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                                             = IOMUX_PAD(0x0258, 0x00A8, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__FLEXIO2_FLEXIO4                                             = IOMUX_PAD(0x0258, 0x00A8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__GPIO4_IO4                                                   = IOMUX_PAD(0x0258, 0x00A8, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD1__I3C2_PUR_B                                                  = IOMUX_PAD(0x0258, 0x00A8, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                                          = IOMUX_PAD(0x025C, 0x00AC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD0__LPUART3_TX                                                  = IOMUX_PAD(0x025C, 0x00AC, 0x01, 0x0474, 0x01, 0x00),
+	MX91_PAD_ENET1_TD0__FLEXIO2_FLEXIO5                                             = IOMUX_PAD(0x025C, 0x00AC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD0__GPIO4_IO5                                                   = IOMUX_PAD(0x025C, 0x00AC, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL                                    = IOMUX_PAD(0x0260, 0x00B0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TX_CTL__LPUART3_DTR_B                                            = IOMUX_PAD(0x0260, 0x00B0, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO6                                          = IOMUX_PAD(0x0260, 0x00B0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                                                = IOMUX_PAD(0x0260, 0x00B0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TX_CTL__LPSPI2_SCK                                               = IOMUX_PAD(0x0260, 0x00B0, 0x02, 0x043C, 0x00, 0x00),
+
+	MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK                          = IOMUX_PAD(0x0264, 0x00B4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TXC__ENET_QOS_TX_ER                                              = IOMUX_PAD(0x0264, 0x00B4, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TXC__FLEXIO2_FLEXIO7                                             = IOMUX_PAD(0x0264, 0x00B4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TXC__GPIO4_IO7                                                   = IOMUX_PAD(0x0264, 0x00B4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TXC__LPSPI2_SIN                                                  = IOMUX_PAD(0x0264, 0x00B4, 0x02, 0x0440, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL                                    = IOMUX_PAD(0x0268, 0x00B8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RX_CTL__LPUART3_DSR_B                                            = IOMUX_PAD(0x0268, 0x00B8, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                                         = IOMUX_PAD(0x0268, 0x00B8, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO8                                          = IOMUX_PAD(0x0268, 0x00B8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                                                = IOMUX_PAD(0x0268, 0x00B8, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RX_CTL__LPSPI2_PCS0                                              = IOMUX_PAD(0x0268, 0x00B8, 0x02, 0x0434, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                                          = IOMUX_PAD(0x026C, 0x00BC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RXC__ENET_QOS_RX_ER                                              = IOMUX_PAD(0x026C, 0x00BC, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RXC__FLEXIO2_FLEXIO9                                             = IOMUX_PAD(0x026C, 0x00BC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RXC__GPIO4_IO9                                                   = IOMUX_PAD(0x026C, 0x00BC, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RXC__LPSPI2_SOUT                                                 = IOMUX_PAD(0x026C, 0x00BC, 0x02, 0x0444, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                                          = IOMUX_PAD(0x0270, 0x00C0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD0__LPUART3_RX                                                  = IOMUX_PAD(0x0270, 0x00C0, 0x01, 0x0470, 0x01, 0x00),
+	MX91_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                                            = IOMUX_PAD(0x0270, 0x00C0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD0__GPIO4_IO10                                                  = IOMUX_PAD(0x0270, 0x00C0, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                                          = IOMUX_PAD(0x0274, 0x00C4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD1__LPUART3_CTS_B                                               = IOMUX_PAD(0x0274, 0x00C4, 0x01, 0x046C, 0x01, 0x00),
+	MX91_PAD_ENET1_RD1__LPTMR2_ALT1                                                 = IOMUX_PAD(0x0274, 0x00C4, 0x03, 0x0448, 0x00, 0x00),
+	MX91_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                                            = IOMUX_PAD(0x0274, 0x00C4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD1__GPIO4_IO11                                                  = IOMUX_PAD(0x0274, 0x00C4, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                                          = IOMUX_PAD(0x0278, 0x00C8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD2__LPTMR2_ALT2                                                 = IOMUX_PAD(0x0278, 0x00C8, 0x03, 0x044C, 0x00, 0x00),
+	MX91_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                                            = IOMUX_PAD(0x0278, 0x00C8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD2__GPIO4_IO12                                                  = IOMUX_PAD(0x0278, 0x00C8, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                                          = IOMUX_PAD(0x027C, 0x00CC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER                                     = IOMUX_PAD(0x027C, 0x00CC, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD3__LPTMR2_ALT3                                                 = IOMUX_PAD(0x027C, 0x00CC, 0x03, 0x0450, 0x00, 0x00),
+	MX91_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                                            = IOMUX_PAD(0x027C, 0x00CC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_RD3__GPIO4_IO13                                                  = IOMUX_PAD(0x027C, 0x00CC, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET2_MDC__ENET2_MDC                                                   = IOMUX_PAD(0x0280, 0x00D0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDC__LPUART4_DCB_B                                               = IOMUX_PAD(0x0280, 0x00D0, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDC__SAI2_RX_SYNC                                                = IOMUX_PAD(0x0280, 0x00D0, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                                            = IOMUX_PAD(0x0280, 0x00D0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDC__GPIO4_IO14                                                  = IOMUX_PAD(0x0280, 0x00D0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDC__MEDIAMIX_CAM_CLK                                            = IOMUX_PAD(0x0280, 0x00D0, 0x06, 0x04BC, 0x01, 0x00),
+
+	MX91_PAD_ENET2_MDIO__ENET2_MDIO                                                 = IOMUX_PAD(0x0284, 0x00D4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDIO__LPUART4_RIN_B                                              = IOMUX_PAD(0x0284, 0x00D4, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDIO__SAI2_RX_BCLK                                               = IOMUX_PAD(0x0284, 0x00D4, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                                           = IOMUX_PAD(0x0284, 0x00D4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDIO__GPIO4_IO15                                                 = IOMUX_PAD(0x0284, 0x00D4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_MDIO__MEDIAMIX_CAM_DATA0                                         = IOMUX_PAD(0x0284, 0x00D4, 0x06, 0x0490, 0x01, 0x00),
+
+	MX91_PAD_ENET2_TD3__SAI2_RX_DATA0                                               = IOMUX_PAD(0x0288, 0x00D8, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                                            = IOMUX_PAD(0x0288, 0x00D8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD3__GPIO4_IO16                                                  = IOMUX_PAD(0x0288, 0x00D8, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD3__MEDIAMIX_CAM_VSYNC                                          = IOMUX_PAD(0x0288, 0x00D8, 0x06, 0x04C0, 0x01, 0x00),
+	MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                                             = IOMUX_PAD(0x0288, 0x00D8, 0x00, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                                             = IOMUX_PAD(0x028C, 0x00DC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD2__ENET2_TX_CLK2                                               = IOMUX_PAD(0x028C, 0x00DC, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                                            = IOMUX_PAD(0x028C, 0x00DC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD2__GPIO4_IO17                                                  = IOMUX_PAD(0x028C, 0x00DC, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD2__MEDIAMIX_CAM_HSYNC                                          = IOMUX_PAD(0x028C, 0x00DC, 0x06, 0x04B8, 0x01, 0x00),
+
+	MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                                             = IOMUX_PAD(0x0290, 0x00E0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD1__LPUART4_RTS_B                                               = IOMUX_PAD(0x0290, 0x00E0, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                                            = IOMUX_PAD(0x0290, 0x00E0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD1__GPIO4_IO18                                                  = IOMUX_PAD(0x0290, 0x00E0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD1__MEDIAMIX_CAM_DATA1                                          = IOMUX_PAD(0x0290, 0x00E0, 0x06, 0x0494, 0x01, 0x00),
+
+	MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                                             = IOMUX_PAD(0x0294, 0x00E4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD0__LPUART4_TX                                                  = IOMUX_PAD(0x0294, 0x00E4, 0x01, 0x0480, 0x01, 0x00),
+	MX91_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                                            = IOMUX_PAD(0x0294, 0x00E4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD0__GPIO4_IO19                                                  = IOMUX_PAD(0x0294, 0x00E4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TD0__MEDIAMIX_CAM_DATA2                                          = IOMUX_PAD(0x0294, 0x00E4, 0x06, 0x0498, 0x01, 0x00),
+
+	MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL                                       = IOMUX_PAD(0x0298, 0x00E8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TX_CTL__LPUART4_DTR_B                                            = IOMUX_PAD(0x0298, 0x00E8, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                                             = IOMUX_PAD(0x0298, 0x00E8, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                                         = IOMUX_PAD(0x0298, 0x00E8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                                               = IOMUX_PAD(0x0298, 0x00E8, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TX_CTL__MEDIAMIX_CAM_DATA3                                       = IOMUX_PAD(0x0298, 0x00E8, 0x06, 0x049C, 0x01, 0x00),
+
+	MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                                             = IOMUX_PAD(0x029C, 0x00EC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TXC__ENET2_TX_ER                                                 = IOMUX_PAD(0x029C, 0x00EC, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TXC__SAI2_TX_BCLK                                                = IOMUX_PAD(0x029C, 0x00EC, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                                            = IOMUX_PAD(0x029C, 0x00EC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TXC__GPIO4_IO21                                                  = IOMUX_PAD(0x029C, 0x00EC, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_TXC__MEDIAMIX_CAM_DATA4                                          = IOMUX_PAD(0x029C, 0x00EC, 0x06, 0x04A0, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL                                       = IOMUX_PAD(0x02A0, 0x00F0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RX_CTL__LPUART4_DSR_B                                            = IOMUX_PAD(0x02A0, 0x00F0, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RX_CTL__SAI2_TX_DATA0                                            = IOMUX_PAD(0x02A0, 0x00F0, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                                         = IOMUX_PAD(0x02A0, 0x00F0, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                                               = IOMUX_PAD(0x02A0, 0x00F0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RX_CTL__MEDIAMIX_CAM_DATA5                                       = IOMUX_PAD(0x02A0, 0x00F0, 0x06, 0x04A4, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                                             = IOMUX_PAD(0x02A4, 0x00F4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RXC__ENET2_RX_ER                                                 = IOMUX_PAD(0x02A4, 0x00F4, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                                            = IOMUX_PAD(0x02A4, 0x00F4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RXC__GPIO4_IO23                                                  = IOMUX_PAD(0x02A4, 0x00F4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RXC__MEDIAMIX_CAM_DATA6                                          = IOMUX_PAD(0x02A4, 0x00F4, 0x06, 0x04A8, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                                             = IOMUX_PAD(0x02A8, 0x00F8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD0__LPUART4_RX                                                  = IOMUX_PAD(0x02A8, 0x00F8, 0x01, 0x047C, 0x01, 0x00),
+	MX91_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                                            = IOMUX_PAD(0x02A8, 0x00F8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD0__GPIO4_IO24                                                  = IOMUX_PAD(0x02A8, 0x00F8, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD0__MEDIAMIX_CAM_DATA7                                          = IOMUX_PAD(0x02A8, 0x00F8, 0x06, 0x04AC, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                                             = IOMUX_PAD(0x02AC, 0x00FC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD1__SPDIF_IN                                                    = IOMUX_PAD(0x02AC, 0x00FC, 0x01, 0x04E4, 0x01, 0x00),
+	MX91_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                                            = IOMUX_PAD(0x02AC, 0x00FC, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD1__GPIO4_IO25                                                  = IOMUX_PAD(0x02AC, 0x00FC, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD1__MEDIAMIX_CAM_DATA8                                          = IOMUX_PAD(0x02AC, 0x00FC, 0x06, 0x04B0, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                                             = IOMUX_PAD(0x02B0, 0x0100, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD2__LPUART4_CTS_B                                               = IOMUX_PAD(0x02B0, 0x0100, 0x01, 0x0478, 0x01, 0x00),
+	MX91_PAD_ENET2_RD2__SAI2_MCLK                                                   = IOMUX_PAD(0x02B0, 0x0100, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD2__MQS2_RIGHT                                                  = IOMUX_PAD(0x02B0, 0x0100, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                                            = IOMUX_PAD(0x02B0, 0x0100, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD2__GPIO4_IO26                                                  = IOMUX_PAD(0x02B0, 0x0100, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD2__MEDIAMIX_CAM_DATA9                                          = IOMUX_PAD(0x02B0, 0x0100, 0x06, 0x04B4, 0x01, 0x00),
+
+	MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                                             = IOMUX_PAD(0x02B4, 0x0104, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD3__SPDIF_OUT                                                   = IOMUX_PAD(0x02B4, 0x0104, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD3__SPDIF_IN                                                    = IOMUX_PAD(0x02B4, 0x0104, 0x02, 0x04E4, 0x02, 0x00),
+	MX91_PAD_ENET2_RD3__MQS2_LEFT                                                   = IOMUX_PAD(0x02B4, 0x0104, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                                            = IOMUX_PAD(0x02B4, 0x0104, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET2_RD3__GPIO4_IO27                                                  = IOMUX_PAD(0x02B4, 0x0104, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD1_CLK__FLEXIO1_FLEXIO8                                               = IOMUX_PAD(0x02B8, 0x0108, 0x04, 0x038C, 0x01, 0x00),
+	MX91_PAD_SD1_CLK__GPIO3_IO8                                                     = IOMUX_PAD(0x02B8, 0x0108, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_CLK__USDHC1_CLK                                                    = IOMUX_PAD(0x02B8, 0x0108, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_CLK__LPSPI2_SCK                                                    = IOMUX_PAD(0x02B8, 0x0108, 0x03, 0x043C, 0x01, 0x00),
+
+	MX91_PAD_SD1_CMD__USDHC1_CMD                                                    = IOMUX_PAD(0x02BC, 0x010C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_CMD__FLEXIO1_FLEXIO9                                               = IOMUX_PAD(0x02BC, 0x010C, 0x04, 0x0390, 0x01, 0x00),
+	MX91_PAD_SD1_CMD__GPIO3_IO9                                                     = IOMUX_PAD(0x02BC, 0x010C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_CMD__LPSPI2_SIN                                                    = IOMUX_PAD(0x02BC, 0x010C, 0x03, 0x0440, 0x01, 0x00),
+
+	MX91_PAD_SD1_DATA0__USDHC1_DATA0                                                = IOMUX_PAD(0x02C0, 0x0110, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                                            = IOMUX_PAD(0x02C0, 0x0110, 0x04, 0x0394, 0x01, 0x00),
+	MX91_PAD_SD1_DATA0__GPIO3_IO10                                                  = IOMUX_PAD(0x02C0, 0x0110, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA0__LPSPI2_PCS0                                                 = IOMUX_PAD(0x02C0, 0x0110, 0x03, 0x0434, 0x01, 0x00),
+
+	MX91_PAD_SD1_DATA1__USDHC1_DATA1                                                = IOMUX_PAD(0x02C4, 0x0114, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                                            = IOMUX_PAD(0x02C4, 0x0114, 0x04, 0x0398, 0x01, 0x00),
+	MX91_PAD_SD1_DATA1__GPIO3_IO11                                                  = IOMUX_PAD(0x02C4, 0x0114, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                                       = IOMUX_PAD(0x02C4, 0x0114, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA1__LPSPI2_SOUT                                                 = IOMUX_PAD(0x02C4, 0x0114, 0x03, 0x0444, 0x01, 0x00),
+
+	MX91_PAD_SD1_DATA2__USDHC1_DATA2                                                = IOMUX_PAD(0x02C8, 0x0118, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                                            = IOMUX_PAD(0x02C8, 0x0118, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA2__GPIO3_IO12                                                  = IOMUX_PAD(0x02C8, 0x0118, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY                                     = IOMUX_PAD(0x02C8, 0x0118, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA2__LPSPI2_PCS1                                                 = IOMUX_PAD(0x02C8, 0x0118, 0x03, 0x0438, 0x00, 0x00),
+
+	MX91_PAD_SD1_DATA3__USDHC1_DATA3                                                = IOMUX_PAD(0x02CC, 0x011C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                                            = IOMUX_PAD(0x02CC, 0x011C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                                            = IOMUX_PAD(0x02CC, 0x011C, 0x04, 0x039C, 0x01, 0x00),
+	MX91_PAD_SD1_DATA3__GPIO3_IO13                                                  = IOMUX_PAD(0x02CC, 0x011C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA3__LPSPI1_PCS1                                                 = IOMUX_PAD(0x02CC, 0x011C, 0x03, 0x0424, 0x00, 0x00),
+
+	MX91_PAD_SD1_DATA4__USDHC1_DATA4                                                = IOMUX_PAD(0x02D0, 0x0120, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA4__FLEXSPI1_A_DATA4                                            = IOMUX_PAD(0x02D0, 0x0120, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                                            = IOMUX_PAD(0x02D0, 0x0120, 0x04, 0x03A0, 0x01, 0x00),
+	MX91_PAD_SD1_DATA4__GPIO3_IO14                                                  = IOMUX_PAD(0x02D0, 0x0120, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA4__LPSPI1_PCS0                                                 = IOMUX_PAD(0x02D0, 0x0120, 0x03, 0x0420, 0x00, 0x00),
+
+	MX91_PAD_SD1_DATA5__USDHC1_DATA5                                                = IOMUX_PAD(0x02D4, 0x0124, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA5__FLEXSPI1_A_DATA5                                            = IOMUX_PAD(0x02D4, 0x0124, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA5__USDHC1_RESET_B                                              = IOMUX_PAD(0x02D4, 0x0124, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                                            = IOMUX_PAD(0x02D4, 0x0124, 0x04, 0x03A4, 0x01, 0x00),
+	MX91_PAD_SD1_DATA5__GPIO3_IO15                                                  = IOMUX_PAD(0x02D4, 0x0124, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA5__LPSPI1_SIN                                                  = IOMUX_PAD(0x02D4, 0x0124, 0x03, 0x042C, 0x00, 0x00),
+
+	MX91_PAD_SD1_DATA6__USDHC1_DATA6                                                = IOMUX_PAD(0x02D8, 0x0128, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA6__FLEXSPI1_A_DATA6                                            = IOMUX_PAD(0x02D8, 0x0128, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA6__USDHC1_CD_B                                                 = IOMUX_PAD(0x02D8, 0x0128, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                                            = IOMUX_PAD(0x02D8, 0x0128, 0x04, 0x03A8, 0x01, 0x00),
+	MX91_PAD_SD1_DATA6__GPIO3_IO16                                                  = IOMUX_PAD(0x02D8, 0x0128, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA6__LPSPI1_SCK                                                  = IOMUX_PAD(0x02D8, 0x0128, 0x03, 0x0428, 0x00, 0x00),
+
+	MX91_PAD_SD1_DATA7__USDHC1_DATA7                                                = IOMUX_PAD(0x02DC, 0x012C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA7__FLEXSPI1_A_DATA7                                            = IOMUX_PAD(0x02DC, 0x012C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA7__USDHC1_WP                                                   = IOMUX_PAD(0x02DC, 0x012C, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                                            = IOMUX_PAD(0x02DC, 0x012C, 0x04, 0x03AC, 0x01, 0x00),
+	MX91_PAD_SD1_DATA7__GPIO3_IO17                                                  = IOMUX_PAD(0x02DC, 0x012C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_DATA7__LPSPI1_SOUT                                                 = IOMUX_PAD(0x02DC, 0x012C, 0x03, 0x0430, 0x00, 0x00),
+
+	MX91_PAD_SD1_STROBE__USDHC1_STROBE                                              = IOMUX_PAD(0x02E0, 0x0130, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_STROBE__FLEXSPI1_A_DQS                                             = IOMUX_PAD(0x02E0, 0x0130, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                                           = IOMUX_PAD(0x02E0, 0x0130, 0x04, 0x03B0, 0x01, 0x00),
+	MX91_PAD_SD1_STROBE__GPIO3_IO18                                                 = IOMUX_PAD(0x02E0, 0x0130, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                                            = IOMUX_PAD(0x02E4, 0x0134, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_VSELECT__USDHC2_WP                                                 = IOMUX_PAD(0x02E4, 0x0134, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_VSELECT__LPTMR2_ALT3                                               = IOMUX_PAD(0x02E4, 0x0134, 0x02, 0x0450, 0x01, 0x00),
+	MX91_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                                          = IOMUX_PAD(0x02E4, 0x0134, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_VSELECT__GPIO3_IO19                                                = IOMUX_PAD(0x02E4, 0x0134, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1                                     = IOMUX_PAD(0x02E4, 0x0134, 0x06, 0x0368, 0x00, 0x00),
+
+	MX91_PAD_SD3_CLK__USDHC3_CLK                                                    = IOMUX_PAD(0x02E8, 0x0138, 0x00, 0x04E8, 0x01, 0x00),
+	MX91_PAD_SD3_CLK__FLEXSPI1_A_SCLK                                               = IOMUX_PAD(0x02E8, 0x0138, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_CLK__LPUART1_CTS_B                                                 = IOMUX_PAD(0x02E8, 0x0138, 0x02, 0x0454, 0x00, 0x00),
+	MX91_PAD_SD3_CLK__FLEXIO1_FLEXIO20                                              = IOMUX_PAD(0x02E8, 0x0138, 0x04, 0x03B4, 0x01, 0x00),
+	MX91_PAD_SD3_CLK__GPIO3_IO20                                                    = IOMUX_PAD(0x02E8, 0x0138, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD3_CMD__USDHC3_CMD                                                    = IOMUX_PAD(0x02EC, 0x013C, 0x00, 0x04EC, 0x01, 0x00),
+	MX91_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                                              = IOMUX_PAD(0x02EC, 0x013C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_CMD__LPUART1_RTS_B                                                 = IOMUX_PAD(0x02EC, 0x013C, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_CMD__FLEXIO1_FLEXIO21                                              = IOMUX_PAD(0x02EC, 0x013C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_CMD__GPIO3_IO21                                                    = IOMUX_PAD(0x02EC, 0x013C, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD3_DATA0__USDHC3_DATA0                                                = IOMUX_PAD(0x02F0, 0x0140, 0x00, 0x04F0, 0x01, 0x00),
+	MX91_PAD_SD3_DATA0__FLEXSPI1_A_DATA0                                            = IOMUX_PAD(0x02F0, 0x0140, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_DATA0__LPUART2_CTS_B                                               = IOMUX_PAD(0x02F0, 0x0140, 0x02, 0x0460, 0x00, 0x00),
+	MX91_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                                            = IOMUX_PAD(0x02F0, 0x0140, 0x04, 0x03B8, 0x01, 0x00),
+	MX91_PAD_SD3_DATA0__GPIO3_IO22                                                  = IOMUX_PAD(0x02F0, 0x0140, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD3_DATA1__USDHC3_DATA1                                                = IOMUX_PAD(0x02F4, 0x0144, 0x00, 0x04F4, 0x01, 0x00),
+	MX91_PAD_SD3_DATA1__FLEXSPI1_A_DATA1                                            = IOMUX_PAD(0x02F4, 0x0144, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_DATA1__LPUART2_RTS_B                                               = IOMUX_PAD(0x02F4, 0x0144, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                                            = IOMUX_PAD(0x02F4, 0x0144, 0x04, 0x03BC, 0x01, 0x00),
+	MX91_PAD_SD3_DATA1__GPIO3_IO23                                                  = IOMUX_PAD(0x02F4, 0x0144, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD3_DATA2__USDHC3_DATA2                                                = IOMUX_PAD(0x02F8, 0x0148, 0x00, 0x04F8, 0x01, 0x00),
+	MX91_PAD_SD3_DATA2__LPI2C4_SDA                                                  = IOMUX_PAD(0x02F8, 0x0148, 0x02, 0x03FC, 0x01, 0x00),
+	MX91_PAD_SD3_DATA2__FLEXSPI1_A_DATA2                                            = IOMUX_PAD(0x02F8, 0x0148, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                                            = IOMUX_PAD(0x02F8, 0x0148, 0x04, 0x03C0, 0x01, 0x00),
+	MX91_PAD_SD3_DATA2__GPIO3_IO24                                                  = IOMUX_PAD(0x02F8, 0x0148, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD3_DATA3__USDHC3_DATA3                                                = IOMUX_PAD(0x02FC, 0x014C, 0x00, 0x04FC, 0x01, 0x00),
+	MX91_PAD_SD3_DATA3__FLEXSPI1_A_DATA3                                            = IOMUX_PAD(0x02FC, 0x014C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD3_DATA3__LPI2C4_SCL                                                  = IOMUX_PAD(0x02FC, 0x014C, 0x02, 0x03F8, 0x01, 0x00),
+	MX91_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                                            = IOMUX_PAD(0x02FC, 0x014C, 0x04, 0x03C4, 0x01, 0x00),
+	MX91_PAD_SD3_DATA3__GPIO3_IO25                                                  = IOMUX_PAD(0x02FC, 0x014C, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_CD_B__USDHC2_CD_B                                                  = IOMUX_PAD(0x0300, 0x0150, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                                      = IOMUX_PAD(0x0300, 0x0150, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CD_B__I3C2_SCL                                                     = IOMUX_PAD(0x0300, 0x0150, 0x02, 0x03CC, 0x01, 0x00),
+	MX91_PAD_SD2_CD_B__FLEXIO1_FLEXIO0                                              = IOMUX_PAD(0x0300, 0x0150, 0x04, 0x036C, 0x01, 0x00),
+	MX91_PAD_SD2_CD_B__GPIO3_IO0                                                    = IOMUX_PAD(0x0300, 0x0150, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CD_B__LPI2C1_SCL                                                   = IOMUX_PAD(0x0300, 0x0150, 0x03, 0x03E0, 0x01, 0x00),
+
+	MX91_PAD_SD2_CLK__USDHC2_CLK                                                    = IOMUX_PAD(0x0304, 0x0154, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                                      = IOMUX_PAD(0x0304, 0x0154, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CLK__I2C1_SDA                                                      = IOMUX_PAD(0x0304, 0x0154, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CLK__I3C2_SDA                                                      = IOMUX_PAD(0x0304, 0x0154, 0x02, 0x03D0, 0x01, 0x00),
+	MX91_PAD_SD2_CLK__FLEXIO1_FLEXIO1                                               = IOMUX_PAD(0x0304, 0x0154, 0x04, 0x0370, 0x01, 0x00),
+	MX91_PAD_SD2_CLK__GPIO3_IO1                                                     = IOMUX_PAD(0x0304, 0x0154, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                                         = IOMUX_PAD(0x0304, 0x0154, 0x06, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CLK__LPI2C1_SDA                                                    = IOMUX_PAD(0x0304, 0x0154, 0x03, 0x03E4, 0x01, 0x00),
+
+	MX91_PAD_SD2_CMD__USDHC2_CMD                                                    = IOMUX_PAD(0x0308, 0x0158, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CMD__ENET2_1588_EVENT0_IN                                          = IOMUX_PAD(0x0308, 0x0158, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CMD__I3C2_PUR                                                      = IOMUX_PAD(0x0308, 0x0158, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CMD__I3C2_PUR_B                                                    = IOMUX_PAD(0x0308, 0x0158, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CMD__FLEXIO1_FLEXIO2                                               = IOMUX_PAD(0x0308, 0x0158, 0x04, 0x0374, 0x01, 0x00),
+	MX91_PAD_SD2_CMD__GPIO3_IO2                                                     = IOMUX_PAD(0x0308, 0x0158, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                                         = IOMUX_PAD(0x0308, 0x0158, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_DATA0__USDHC2_DATA0                                                = IOMUX_PAD(0x030C, 0x015C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA0__ENET2_1588_EVENT0_OUT                                       = IOMUX_PAD(0x030C, 0x015C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA0__CAN2_TX                                                     = IOMUX_PAD(0x030C, 0x015C, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA0__FLEXIO1_FLEXIO3                                             = IOMUX_PAD(0x030C, 0x015C, 0x04, 0x0378, 0x01, 0x00),
+	MX91_PAD_SD2_DATA0__GPIO3_IO3                                                   = IOMUX_PAD(0x030C, 0x015C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA0__LPUART1_TX                                                  = IOMUX_PAD(0x030C, 0x015C, 0x03, 0x045C, 0x00, 0x00),
+	MX91_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                                       = IOMUX_PAD(0x030C, 0x015C, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_DATA1__USDHC2_DATA1                                                = IOMUX_PAD(0x0310, 0x0160, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA1__ENET2_1588_EVENT1_IN                                        = IOMUX_PAD(0x0310, 0x0160, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA1__CAN2_RX                                                     = IOMUX_PAD(0x0310, 0x0160, 0x02, 0x0364, 0x03, 0x00),
+	MX91_PAD_SD2_DATA1__FLEXIO1_FLEXIO4                                             = IOMUX_PAD(0x0310, 0x0160, 0x04, 0x037C, 0x01, 0x00),
+	MX91_PAD_SD2_DATA1__GPIO3_IO4                                                   = IOMUX_PAD(0x0310, 0x0160, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA1__LPUART1_RX                                                  = IOMUX_PAD(0x0310, 0x0160, 0x03, 0x0458, 0x00, 0x00),
+	MX91_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                                           = IOMUX_PAD(0x0310, 0x0160, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_DATA2__USDHC2_DATA2                                                = IOMUX_PAD(0x0314, 0x0164, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA2__ENET2_1588_EVENT1_OUT                                       = IOMUX_PAD(0x0314, 0x0164, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA2__MQS2_RIGHT                                                  = IOMUX_PAD(0x0314, 0x0164, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA2__FLEXIO1_FLEXIO5                                             = IOMUX_PAD(0x0314, 0x0164, 0x04, 0x0380, 0x01, 0x00),
+	MX91_PAD_SD2_DATA2__GPIO3_IO5                                                   = IOMUX_PAD(0x0314, 0x0164, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA2__LPUART2_TX                                                  = IOMUX_PAD(0x0314, 0x0164, 0x03, 0x0468, 0x00, 0x00),
+	MX91_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                                           = IOMUX_PAD(0x0314, 0x0164, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_DATA3__USDHC2_DATA3                                                = IOMUX_PAD(0x0318, 0x0168, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA3__LPTMR2_ALT1                                                 = IOMUX_PAD(0x0318, 0x0168, 0x01, 0x0448, 0x01, 0x00),
+	MX91_PAD_SD2_DATA3__MQS2_LEFT                                                   = IOMUX_PAD(0x0318, 0x0168, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA3__FLEXIO1_FLEXIO6                                             = IOMUX_PAD(0x0318, 0x0168, 0x04, 0x0384, 0x01, 0x00),
+	MX91_PAD_SD2_DATA3__GPIO3_IO6                                                   = IOMUX_PAD(0x0318, 0x0168, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_DATA3__LPUART2_RX                                                  = IOMUX_PAD(0x0318, 0x0168, 0x03, 0x0464, 0x00, 0x00),
+	MX91_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET                                    = IOMUX_PAD(0x0318, 0x0168, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SD2_RESET_B__USDHC2_RESET_B                                            = IOMUX_PAD(0x031C, 0x016C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_RESET_B__LPTMR2_ALT2                                               = IOMUX_PAD(0x031C, 0x016C, 0x01, 0x044C, 0x01, 0x00),
+	MX91_PAD_SD2_RESET_B__FLEXIO1_FLEXIO7                                           = IOMUX_PAD(0x031C, 0x016C, 0x04, 0x0388, 0x01, 0x00),
+	MX91_PAD_SD2_RESET_B__GPIO3_IO7                                                 = IOMUX_PAD(0x031C, 0x016C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET                                 = IOMUX_PAD(0x031C, 0x016C, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_I2C1_SCL__LPI2C1_SCL                                                   = IOMUX_PAD(0x0320, 0x0170, 0x00, 0x03E0, 0x02, 0x00),
+	MX91_PAD_I2C1_SCL__I3C1_SCL                                                     = IOMUX_PAD(0x0320, 0x0170, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SCL__LPUART1_DCB_B                                                = IOMUX_PAD(0x0320, 0x0170, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SCL__TPM2_CH0                                                     = IOMUX_PAD(0x0320, 0x0170, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SCL__GPIO1_IO0                                                    = IOMUX_PAD(0x0320, 0x0170, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_I2C1_SDA__LPI2C1_SDA                                                   = IOMUX_PAD(0x0324, 0x0174, 0x00, 0x03E4, 0x02, 0x00),
+	MX91_PAD_I2C1_SDA__I3C1_SDA                                                     = IOMUX_PAD(0x0324, 0x0174, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SDA__LPUART1_RIN_B                                                = IOMUX_PAD(0x0324, 0x0174, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SDA__TPM2_CH1                                                     = IOMUX_PAD(0x0324, 0x0174, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C1_SDA__GPIO1_IO1                                                    = IOMUX_PAD(0x0324, 0x0174, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_I2C2_SCL__LPI2C2_SCL                                                   = IOMUX_PAD(0x0328, 0x0178, 0x00, 0x03E8, 0x01, 0x00),
+	MX91_PAD_I2C2_SCL__I3C1_PUR                                                     = IOMUX_PAD(0x0328, 0x0178, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                                = IOMUX_PAD(0x0328, 0x0178, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__TPM2_CH2                                                     = IOMUX_PAD(0x0328, 0x0178, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                                 = IOMUX_PAD(0x0328, 0x0178, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__GPIO1_IO3                                                    = IOMUX_PAD(0x0328, 0x0178, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__I3C1_PUR_B                                                   = IOMUX_PAD(0x0328, 0x0178, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_I2C2_SDA__LPI2C2_SDA                                                   = IOMUX_PAD(0x032C, 0x017C, 0x00, 0x03EC, 0x01, 0x00),
+	MX91_PAD_I2C2_SDA__LPUART2_RIN_B                                                = IOMUX_PAD(0x032C, 0x017C, 0x02, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SDA__TPM2_CH3                                                     = IOMUX_PAD(0x032C, 0x017C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SDA__SAI1_RX_BCLK                                                 = IOMUX_PAD(0x032C, 0x017C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SDA__GPIO1_IO3                                                    = IOMUX_PAD(0x032C, 0x017C, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_UART1_RXD__LPUART1_RX                                                  = IOMUX_PAD(0x0330, 0x0180, 0x00, 0x0458, 0x01, 0x00),
+	MX91_PAD_UART1_RXD__ELE_UART_RX                                                 = IOMUX_PAD(0x0330, 0x0180, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART1_RXD__LPSPI2_SIN                                                  = IOMUX_PAD(0x0330, 0x0180, 0x02, 0x0440, 0x02, 0x00),
+	MX91_PAD_UART1_RXD__TPM1_CH0                                                    = IOMUX_PAD(0x0330, 0x0180, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART1_RXD__GPIO1_IO4                                                   = IOMUX_PAD(0x0330, 0x0180, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_UART1_TXD__LPUART1_TX                                                  = IOMUX_PAD(0x0334, 0x0184, 0x00, 0x045C, 0x01, 0x00),
+	MX91_PAD_UART1_TXD__ELE_UART_TX                                                 = IOMUX_PAD(0x0334, 0x0184, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART1_TXD__LPSPI2_PCS0                                                 = IOMUX_PAD(0x0334, 0x0184, 0x02, 0x0434, 0x02, 0x00),
+	MX91_PAD_UART1_TXD__TPM1_CH1                                                    = IOMUX_PAD(0x0334, 0x0184, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART1_TXD__GPIO1_IO5                                                   = IOMUX_PAD(0x0334, 0x0184, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_UART2_RXD__LPUART2_RX                                                  = IOMUX_PAD(0x0338, 0x0188, 0x00, 0x0464, 0x01, 0x00),
+	MX91_PAD_UART2_RXD__LPUART1_CTS_B                                               = IOMUX_PAD(0x0338, 0x0188, 0x01, 0x0454, 0x01, 0x00),
+	MX91_PAD_UART2_RXD__LPSPI2_SOUT                                                 = IOMUX_PAD(0x0338, 0x0188, 0x02, 0x0444, 0x02, 0x00),
+	MX91_PAD_UART2_RXD__TPM1_CH2                                                    = IOMUX_PAD(0x0338, 0x0188, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART2_RXD__SAI1_MCLK                                                   = IOMUX_PAD(0x0338, 0x0188, 0x04, 0x04D4, 0x00, 0x00),
+	MX91_PAD_UART2_RXD__GPIO1_IO6                                                   = IOMUX_PAD(0x0338, 0x0188, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_UART2_TXD__LPUART2_TX                                                  = IOMUX_PAD(0x033C, 0x018C, 0x00, 0x0468, 0x01, 0x00),
+	MX91_PAD_UART2_TXD__LPUART1_RTS_B                                               = IOMUX_PAD(0x033C, 0x018C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART2_TXD__LPSPI2_SCK                                                  = IOMUX_PAD(0x033C, 0x018C, 0x02, 0x043C, 0x02, 0x00),
+	MX91_PAD_UART2_TXD__TPM1_CH3                                                    = IOMUX_PAD(0x033C, 0x018C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART2_TXD__GPIO1_IO7                                                   = IOMUX_PAD(0x033C, 0x018C, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_UART2_TXD__SAI3_TX_SYNC                                                = IOMUX_PAD(0x033C, 0x018C, 0x07, 0x04E0, 0x02, 0x00),
+
+	MX91_PAD_PDM_CLK__PDM_CLK                                                       = IOMUX_PAD(0x0340, 0x0190, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_CLK__MQS1_LEFT                                                     = IOMUX_PAD(0x0340, 0x0190, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_CLK__LPTMR1_ALT1                                                   = IOMUX_PAD(0x0340, 0x0190, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_CLK__GPIO1_IO8                                                     = IOMUX_PAD(0x0340, 0x0190, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_CLK__CAN1_TX                                                       = IOMUX_PAD(0x0340, 0x0190, 0x06, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0                                       = IOMUX_PAD(0x0344, 0x0194, 0x00, 0x04C4, 0x02, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                                            = IOMUX_PAD(0x0344, 0x0194, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                                           = IOMUX_PAD(0x0344, 0x0194, 0x02, 0x0424, 0x01, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                                           = IOMUX_PAD(0x0344, 0x0194, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                                           = IOMUX_PAD(0x0344, 0x0194, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9                                             = IOMUX_PAD(0x0344, 0x0194, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM0__CAN1_RX                                               = IOMUX_PAD(0x0344, 0x0194, 0x06, 0x0360, 0x01, 0x00),
+
+	MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1                                       = IOMUX_PAD(0x0348, 0x0198, 0x00, 0x04C8, 0x02, 0x00),
+	MX91_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                                           = IOMUX_PAD(0x0348, 0x0198, 0x02, 0x0438, 0x01, 0x00),
+	MX91_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                                           = IOMUX_PAD(0x0348, 0x0198, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                                           = IOMUX_PAD(0x0348, 0x0198, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10                                            = IOMUX_PAD(0x0348, 0x0198, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1                                 = IOMUX_PAD(0x0348, 0x0198, 0x06, 0x0368, 0x01, 0x00),
+
+	MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC                                                = IOMUX_PAD(0x034C, 0x019C, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXFS__SAI1_TX_DATA1                                               = IOMUX_PAD(0x034C, 0x019C, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXFS__LPSPI1_PCS0                                                 = IOMUX_PAD(0x034C, 0x019C, 0x02, 0x0420, 0x01, 0x00),
+	MX91_PAD_SAI1_TXFS__LPUART2_DTR_B                                               = IOMUX_PAD(0x034C, 0x019C, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXFS__MQS1_LEFT                                                   = IOMUX_PAD(0x034C, 0x019C, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXFS__GPIO1_IO11                                                  = IOMUX_PAD(0x034C, 0x019C, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SAI1_TXC__SAI1_TX_BCLK                                                 = IOMUX_PAD(0x0350, 0x01A0, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXC__LPUART2_CTS_B                                                = IOMUX_PAD(0x0350, 0x01A0, 0x01, 0x0460, 0x01, 0x00),
+	MX91_PAD_SAI1_TXC__LPSPI1_SIN                                                   = IOMUX_PAD(0x0350, 0x01A0, 0x02, 0x042C, 0x01, 0x00),
+	MX91_PAD_SAI1_TXC__LPUART1_DSR_B                                                = IOMUX_PAD(0x0350, 0x01A0, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXC__CAN1_RX                                                      = IOMUX_PAD(0x0350, 0x01A0, 0x04, 0x0360, 0x02, 0x00),
+	MX91_PAD_SAI1_TXC__GPIO1_IO12                                                   = IOMUX_PAD(0x0350, 0x01A0, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0                                               = IOMUX_PAD(0x0354, 0x01A4, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXD0__LPUART2_RTS_B                                               = IOMUX_PAD(0x0354, 0x01A4, 0x01, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXD0__LPSPI1_SCK                                                  = IOMUX_PAD(0x0354, 0x01A4, 0x02, 0x0428, 0x01, 0x00),
+	MX91_PAD_SAI1_TXD0__LPUART1_DTR_B                                               = IOMUX_PAD(0x0354, 0x01A4, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXD0__CAN1_TX                                                     = IOMUX_PAD(0x0354, 0x01A4, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXD0__GPIO1_IO13                                                  = IOMUX_PAD(0x0354, 0x01A4, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_TXD0__SAI1_MCLK                                                   = IOMUX_PAD(0x0354, 0x01A4, 0x06, 0x04D4, 0x01, 0x00),
+
+	MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0                                               = IOMUX_PAD(0x0358, 0x01A8, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_RXD0__SAI1_MCLK                                                   = IOMUX_PAD(0x0358, 0x01A8, 0x01, 0x04D4, 0x02, 0x00),
+	MX91_PAD_SAI1_RXD0__LPSPI1_SOUT                                                 = IOMUX_PAD(0x0358, 0x01A8, 0x02, 0x0430, 0x01, 0x00),
+	MX91_PAD_SAI1_RXD0__LPUART2_DSR_B                                               = IOMUX_PAD(0x0358, 0x01A8, 0x03, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_RXD0__MQS1_RIGHT                                                  = IOMUX_PAD(0x0358, 0x01A8, 0x04, 0x0000, 0x00, 0x00),
+	MX91_PAD_SAI1_RXD0__GPIO1_IO14                                                  = IOMUX_PAD(0x0358, 0x01A8, 0x05, 0x0000, 0x00, 0x00),
+
+	MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY                                               = IOMUX_PAD(0x035C, 0x01AC, 0x00, 0x0000, 0x00, 0x00),
+	MX91_PAD_WDOG_ANY__GPIO1_IO15                                                   = IOMUX_PAD(0x035C, 0x01AC, 0x05, 0x0000, 0x00, 0x00),
+};
+#endif  /* __ASM_ARCH_IMX91_PINS_H__ */
diff --git a/arch/arm/include/asm/mach-imx/iomux-v3.h b/arch/arm/include/asm/mach-imx/iomux-v3.h
index 0492abd298cb0dab0ed59e3997c6084fc4a0ef00..149c7b756793e150e3af456955dfbd0e9c2d52ed 100644
--- a/arch/arm/include/asm/mach-imx/iomux-v3.h
+++ b/arch/arm/include/asm/mach-imx/iomux-v3.h
@@ -86,7 +86,7 @@ typedef u64 iomux_v3_cfg_t;
 #define IOMUX_CONFIG_LPSR       0x20
 #define MUX_MODE_LPSR           ((iomux_v3_cfg_t)IOMUX_CONFIG_LPSR << \
 				MUX_MODE_SHIFT)
-#ifdef CONFIG_IMX93
+#if defined(CONFIG_IMX93) || defined(CONFIG_IMX91)
 #define PAD_CTL_FSEL2		(0x2 << 7)
 #define PAD_CTL_FSEL3		(0x3 << 7)
 #define PAD_CTL_PUE		(0x1 << 9)
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 31ace977d2bd9264fd0f0a43e0c79e18d5a65673..109a806852ab42d018ce45a4e96af5b57adb6a9c 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,12 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
+#define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))
+#define is_imx9101() (is_cpu_type(MXC_CPU_IMX9101))
+#define is_imx91() (is_cpu_type(MXC_CPU_IMX91) || is_cpu_type(MXC_CPU_IMX9111) || \
+	is_cpu_type(MXC_CPU_IMX9101) || is_cpu_type(MXC_CPU_IMX9121))
+
 #define is_imxrt1020() (is_cpu_type(MXC_CPU_IMXRT1020))
 #define is_imxrt1050() (is_cpu_type(MXC_CPU_IMXRT1050))
 
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 2465e31d738454eb1f28dd6ec061059d4c3d4c52..4554e215f0dc09518428a63b057871251462b3b4 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -16,6 +16,12 @@ config IMX93
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX91
+	bool
+	select IMX9
+	select ARMV8_SPL_EXCEPTION_VECTORS
+
+
 config SYS_SOC
 	default "imx9"
 
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index c00be19c4fa9c60f480ddff1da0a2df9261ace46..e65cabef2c96a3e707112ba07a646fd5babbbe6a 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -30,6 +30,7 @@ static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
 	INT_PLL_RATE(1400000000U, 1, 175, 3), /* 1.4Ghz */
 	INT_PLL_RATE(1000000000U, 1, 166, 4), /* 1000Mhz */
 	INT_PLL_RATE(900000000U, 1, 150, 4), /* 900Mhz */
+	INT_PLL_RATE(800000000U, 1, 200, 6), /* 800Mhz */
 };
 
 static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
@@ -37,12 +38,14 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(933000000U, 1, 155, 4, 1, 2), /* 933Mhz */
 	FRAC_PLL_RATE(800000000U, 1, 200, 6, 0, 1), /* 800Mhz */
 	FRAC_PLL_RATE(700000000U, 1, 145, 5, 5, 6), /* 700Mhz */
+	FRAC_PLL_RATE(600000000U, 1, 200, 8, 0, 1), /* 600Mhz */
 	FRAC_PLL_RATE(484000000U, 1, 121, 6, 0, 1),
 	FRAC_PLL_RATE(445333333U, 1, 167, 9, 0, 1),
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
 	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
+	FRAC_PLL_RATE(200000000U, 1, 200, 24, 0, 1), /* 200Mhz */
 };
 
 /* return in khz */
@@ -723,7 +726,7 @@ struct imx_clk_setting imx_clk_ld_settings[] = {
 	/* SWO TRACE to 133M */
 	{SWO_TRACE_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3},
 	/* M33 systetick to 24M */
-	{M33_SYSTICK_CLK_ROOT, OSC_24M_CLK, 1},
+	{M33_SYSTICK_CLK_ROOT, OSC_24M_CLK, 1, CLK_SOC_IMX93},
 	/* NIC to 250M */
 	{NIC_CLK_ROOT, SYS_PLL_PFD0, 4},
 	/* NIC_APB to 133M */
@@ -753,13 +756,17 @@ struct imx_clk_setting imx_clk_settings[] = {
 	 * WAKEUP_AXI to 312.5M, because of FEC only can support to 320M for
 	 * generating MII clock at 2.5M
 	 */
-	{WAKEUP_AXI_CLK_ROOT, SYS_PLL_PFD2, 2},
+	{WAKEUP_AXI_CLK_ROOT, SYS_PLL_PFD2, 2, CLK_SOC_IMX93},
+	/* Wakeup AXI 250M*/
+	{WAKEUP_AXI_CLK_ROOT, SYS_PLL_PFD0, 4, CLK_SOC_IMX91},
 	/* SWO TRACE to 133M */
 	{SWO_TRACE_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3},
 	/* M33 systetick to 24M */
-	{M33_SYSTICK_CLK_ROOT, OSC_24M_CLK, 1},
+	{M33_SYSTICK_CLK_ROOT, OSC_24M_CLK, 1, CLK_SOC_IMX93},
 	/* NIC to 400M */
-	{NIC_CLK_ROOT, SYS_PLL_PFD1, 2},
+	{NIC_CLK_ROOT, SYS_PLL_PFD1, 2, CLK_SOC_IMX93},
+	/* NIC to 333M */
+	{NIC_CLK_ROOT, SYS_PLL_PFD0, 3, CLK_SOC_IMX91},
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
@@ -769,8 +776,12 @@ void bus_clock_init_low_drive(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(imx_clk_ld_settings); i++) {
-		ccm_clk_root_cfg(imx_clk_ld_settings[i].clk_root,
-				 imx_clk_ld_settings[i].src, imx_clk_ld_settings[i].div);
+		if (imx_clk_ld_settings[i].soc == CLK_SOC_ALL ||
+		    (is_imx91() && imx_clk_ld_settings[i].soc == CLK_SOC_IMX91) ||
+		    (is_imx93() && imx_clk_ld_settings[i].soc == CLK_SOC_IMX93)) {
+			ccm_clk_root_cfg(imx_clk_ld_settings[i].clk_root,
+					 imx_clk_ld_settings[i].src, imx_clk_ld_settings[i].div);
+		}
 	}
 }
 
@@ -779,8 +790,12 @@ void bus_clock_init(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(imx_clk_settings); i++) {
-		ccm_clk_root_cfg(imx_clk_settings[i].clk_root,
-				 imx_clk_settings[i].src, imx_clk_settings[i].div);
+		if (imx_clk_settings[i].soc == CLK_SOC_ALL ||
+		    (is_imx91() && imx_clk_settings[i].soc == CLK_SOC_IMX91) ||
+		    (is_imx93() && imx_clk_settings[i].soc == CLK_SOC_IMX93)) {
+			ccm_clk_root_cfg(imx_clk_settings[i].clk_root,
+					 imx_clk_settings[i].src, imx_clk_settings[i].div);
+		}
 	}
 }
 
@@ -857,7 +872,7 @@ u32 imx_get_fecclk(void)
 	return ccm_clk_root_get_rate(WAKEUP_AXI_CLK_ROOT);
 }
 
-#if defined(CONFIG_IMX93) && defined(CONFIG_DWC_ETH_QOS)
+#if (CONFIG_IS_ENABLED(IMX93) || CONFIG_IS_ENABLED(IMX91)) && CONFIG_IS_ENABLED(DWC_ETH_QOS)
 static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interface_type)
 {
 	struct blk_ctrl_wakeupmix_regs *bctrl =
@@ -901,12 +916,12 @@ static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interf
 
 int board_interface_eth_init(struct udevice *dev, phy_interface_t interface_type)
 {
-	if (IS_ENABLED(CONFIG_IMX93) &&
+	if ((IS_ENABLED(CONFIG_IMX93) || IS_ENABLED(CONFIG_IMX91)) &&
 	    IS_ENABLED(CONFIG_DWC_ETH_QOS) &&
 	    device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
 		return imx93_eqos_interface_init(dev, interface_type);
 
-	if (IS_ENABLED(CONFIG_IMX93) &&
+	if ((IS_ENABLED(CONFIG_IMX93) || IS_ENABLED(CONFIG_IMX91)) &&
 	    IS_ENABLED(CONFIG_FEC_MXC) &&
 	    device_is_compatible(dev, "fsl,imx93-fec"))
 		return 0;
diff --git a/arch/arm/mach-imx/imx9/container.cfg b/arch/arm/mach-imx/imx9/container.cfg
index 72fe791eae61645a15d05488e3258f8da394f8e8..91a973161d107ac0dea3db396166d71e68462aee 100644
--- a/arch/arm/mach-imx/imx9/container.cfg
+++ b/arch/arm/mach-imx/imx9/container.cfg
@@ -6,6 +6,10 @@
 BOOT_FROM SD 0x400
 SOC_TYPE IMX9
 CONTAINER
+#ifdef CONFIG_IMX91
+IMAGE A55 bl31.bin 0x204C0000
+#else
 IMAGE A55 bl31.bin 0x204E0000
+#endif
 IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
-IMAGE A55 tee.bin 0x96000000
\ No newline at end of file
+IMAGE A55 tee.bin 0x96000000
diff --git a/arch/arm/mach-imx/imx9/imximage.cfg b/arch/arm/mach-imx/imx9/imximage.cfg
index d327d6a6ef47d9647c9fe1de1fa218431fccc9ad..118dfb3ec793f387a295aab75c151345368da99d 100644
--- a/arch/arm/mach-imx/imx9/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/imximage.cfg
@@ -5,6 +5,10 @@
 
 BOOT_FROM SD 0x400
 SOC_TYPE IMX9
+#ifdef CONFIG_IMX91
+APPEND mx91a0-ahab-container.img
+#else
 APPEND mx93a1-ahab-container.img
+#endif
 CONTAINER
-IMAGE A55 u-boot-spl-ddr.bin 0x2049A000
\ No newline at end of file
+IMAGE A55 u-boot-spl-ddr.bin CONFIG_SPL_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index d30a3b0a5f5944b536b4c7fc29b4aa80a91eff10..bb13ca742e3a245e0ca63b8fb8c69068d5339d7a 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -118,6 +118,8 @@ u32 get_cpu_speed_grade_hz(void)
 
 	if (is_imx93())
 		max_speed = MHZ(1700);
+	else if (is_imx91())
+		max_speed = MHZ(1400);
 
 	/* In case the fuse of speed grade not programmed */
 	if (speed > max_speed)
@@ -196,6 +198,29 @@ static u32 get_cpu_variant_type(u32 type)
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(5) | BIT(17) | BIT(19) | BIT(24);
+	u32 nxp_recog = (val & GENMASK(23, 16)) >> 16;
+
+	/* For iMX91 */
+	if (type == MXC_CPU_IMX91) {
+		switch (nxp_recog) {
+		case 0x9:
+		case 0xA:
+			type = MXC_CPU_IMX9111;
+			break;
+		case 0xD:
+		case 0xE:
+			type = MXC_CPU_IMX9121;
+			break;
+		case 0xF:
+		case 0x10:
+			type = MXC_CPU_IMX9101;
+			break;
+		default:
+			break;	/* 9131 as default */
+		}
+
+		return type;
+	}
 
 	/* Low performance 93 part */
 	if (((val >> 6) & 0x3F) == 0xE && npu_disable)
@@ -217,8 +242,14 @@ static u32 get_cpu_variant_type(u32 type)
 u32 get_cpu_rev(void)
 {
 	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
+	u32 type;
 
-	return (get_cpu_variant_type(MXC_CPU_IMX93) << 12) |
+	if ((gd->arch.soc_rev & 0xFFFF) == 0x9300)
+		type = MXC_CPU_IMX93;
+	else
+		type = MXC_CPU_IMX91;
+
+	return (get_cpu_variant_type(type) << 12) |
 		(CHIP_REV_1_0 + rev);
 }
 
@@ -539,7 +570,8 @@ int print_cpuinfo(void)
 
 	cpurev = get_cpu_rev();
 
-	printf("CPU:   i.MX93 rev%d.%d\n", (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
+	printf("CPU:   i.MX%s rev%d.%d\n", is_imx93() ? "93" : "91",
+	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
 
 	return 0;
 }
@@ -893,7 +925,9 @@ void disable_isolation(void)
 void soc_power_init(void)
 {
 	mix_power_init(MIX_PD_MEDIAMIX);
-	mix_power_init(MIX_PD_MLMIX);
+
+	if (is_imx93())
+		mix_power_init(MIX_PD_MLMIX);
 
 	disable_isolation();
 }
@@ -919,6 +953,9 @@ int m33_prepare(void)
 			(struct blk_ctrl_s_aonmix_regs *)BLK_CTRL_S_ANOMIX_BASE_ADDR;
 	u32 val, i;
 
+	if (is_imx91())
+		return -ENODEV;
+
 	if (m33_is_rom_kicked())
 		return -EPERM;
 
@@ -1007,7 +1044,7 @@ enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
 	u32 speed = get_cpu_speed_grade_hz();
 	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
 
-	if (is_imx93()) {
+	if (is_imx93() || is_imx91()) {
 		if (speed == 1700000000)
 			voltage = VOLT_OVER_DRIVE;
 		else if (speed == 1400000000)
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 51262befaff7683d5831be683f53b7776e23ff02..53d31b3c0bf7c01335ab01ba1d1eb1e6fb5dde37 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -65,6 +65,14 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "93(02)";/* iMX93 900Mhz Low performance Dual core without NPU */
 	case MXC_CPU_IMX9301:
 		return "93(01)";/* iMX93 900Mhz Low performance Single core without NPU */
+	case MXC_CPU_IMX91:
+		return "91(31)";/* iMX91 11x11 Full feature */
+	case MXC_CPU_IMX9121:
+		return "91(21)";/* iMX91 11x11 Low drive mode */
+	case MXC_CPU_IMX9111:
+		return "91(11)";/* iMX91 9x9 Reduced feature */
+	case MXC_CPU_IMX9101:
+		return "91(01)";/* iMX91 9x9 Specific feature */
 	default:
 		return "??";
 	}
@@ -127,6 +135,8 @@ static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
 	if (IS_ENABLED(CONFIG_IMX8)) {
 		if (plat->cpu_rsrc == SC_R_A72)
 			idx = 2; /* use "cpu-thermal1" device */
+	} else if (IS_ENABLED(CONFIG_IMX91)) {
+		idx = 0;
 	} else {
 		idx = 1;
 	}

-- 
2.35.3

