Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E903BC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D1788D39;
	Tue, 17 Sep 2024 04:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X/sGLIC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8406488C8F; Tue, 17 Sep 2024 04:30:52 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E6788D5C
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9rjjOGl9WID8//V0ZIBI6xK/TpX4u5LDMDV+beTA9OShqkXie7LH90I738QcQZI23mQ/cFAB6Rbxn6WowD58+sh4Lv0r2seOIuvO3baNice9PjvUGjcoqwuTGEe+3u1z4G7JBUowPHmmRt4zryQvZx5GKl07HTtYwQvzzmMPqDctfrpjIXAEwHIhyUbmCknA2InPVB5qbaB5SpC+Meb89XPMx8R329UxoMP482+tHG+z2b70SDFnV90Vi1q1Ze3Q93aogxuWmsY4Duo1pgvNxTSN4iJtvyNxewwXgGkXgU1kGG8refRJrwW7D5ADGwKkJY7aBzuIIcFitFaLHjKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxHGiwaFFqB+UNyjC7XmJIvfkpDaI5zQ7ULlUObs2xU=;
 b=MkfOBJ1O6DilJwttHMHnvq6z8W06RiIpss8j3tOJRivcOpxqyFHXAInryooK3EVy8wGAGJHu9an2gIVtYzDFSzNEvDnSa1hwZIQEAqdnVm3T8HTYyiQMSLGvrWzaptfEQKYrGyh+eZtlyleKLYkMFSgOgDACFWmunEoUrnscMhRxL9A0YHrRzyZJ5wYW7vFIr2sKqaMTSGuH1fs9GcLNcZ5olmY2Y8EBewS24V+X/M4vWT/IrX5CwI5rptBLeOQEhmLRS+cazi3Rm61zhBGIUe77T9HXj9eOy9NdfpVuSauTltOhSkfvipAVcVqcCLdpfeA3bdpHAB9grqwl7cGrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxHGiwaFFqB+UNyjC7XmJIvfkpDaI5zQ7ULlUObs2xU=;
 b=X/sGLIC7FgkxzhbIAo1pB73X9etPSqAgGI4CWp2lbj7szgSDmhkXYc576ozl9P93VzSLPVlz74ycfEfJd0Y9GpQX3asTMJNiLuzWkvobVkaWrnwKNT5S0qyW1pw8ewzHG54zvkiKs+dsOuRKuEdchx8ioll0E3X1saPbpCb4dCNmnAfbCclX9ADxNmWPsBzH+PTKw25XQtaVGi3xhlQ5wKZHL3WYc7vB2pCKvDi06l+bRL0ACw2LcA5UN10hB0lTpoDhoqqZQxLRv1FwoKsg54bSZS6lhIxgxYB2kg/bGT406wPb+BrxjVOtKFgBR3TNl2VdpaU7CsAUrcHbrKyoAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:30:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:57 +0800
Subject: [PATCH 05/21] imx9: soc: Change FSB directly access to fuse API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-5-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: ac53f10e-4146-49f5-cb00-08dcd6c0bd91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzdKSDFmVVJaNyt4NGxybDk1VGRIaVlFUW5kNkVUeXE3ZXFpcitpWlFVTFpu?=
 =?utf-8?B?ZnE2L0tyWGlhZ0tHbjNCNjlRRDV6RjdMbkM4Qk9mWG5jdyttcTNlcVU5Vm51?=
 =?utf-8?B?elhoYXRhYmtXaUVlVWFMM1dTSG5yVFhHQy9mVHAzQ0p4K3VxdEJqNXpjYmVr?=
 =?utf-8?B?QnA4Y0dIQ3NjK3dBTEhaUUdVVHhqMnhPWXliTXFPblNWWndZNGJob0d2L2p4?=
 =?utf-8?B?aEtEQWhySnYwcXFSdGoyQ3VZRUlmVUNPUlp5QnJkc25QTTV3WXZWdTF5Rnkw?=
 =?utf-8?B?WEUxMWJGN1hSYndsaWRWbWFmRUdQK1ZoZFdQZ2t0c2RUSUVuYm5HcFhIL1I2?=
 =?utf-8?B?ZTFMUnBjeFZqMDRpbGJ3NitqVmF3K2dOeUVqU2FSTWxVL3BCWDJNUTU3NW5I?=
 =?utf-8?B?cEMxa0lRdWNSR3RReGpuMlZBMEo5RGNjNjBRamhVSW9mc3JVZnNJUk4rYkdw?=
 =?utf-8?B?UnR2SkhMTElGUHF4NksyTUZYczN0RW9zVXRmdFcyUHdDRUFkNXZVTHNRZW1Y?=
 =?utf-8?B?eENHdHE1TjZjUkR4ZGNsdEVxZTZPd2xyamdSWjRmWUhrVmRHcmFTMno5c2ha?=
 =?utf-8?B?VDl1NjhVcUtYU0N3cTQxR3VraElRS09POS8zWGVENzFRaU1ZWDlkakxyNzBG?=
 =?utf-8?B?RVhGSWFkSXI5NUtVRG9RNk9IRmx6VzdlQU9mTk5ObS9WWU4yN2t0enk5ajRo?=
 =?utf-8?B?cjVFdjUvTjFUaTRtQk9yQWxTSzNxcjdUc3dkNC80U3o1dG9NaDBhTVkzYnlD?=
 =?utf-8?B?cVIxMExBQ05ibEN1RWJtaTlRN1FFK09xZWxpZjd6dDRRQlVweFJ4a25WQmg2?=
 =?utf-8?B?WmRBSGtMQUZGNTdsWEZ3SjkrNUphK1REbjJnWm0rRXVaUDkxSFRtOExva0Vm?=
 =?utf-8?B?cnlSU09YOXBhZ0hJOWlSQ21STFNYam4zR2x3YWNqem1YMUpUaVpYWXVQVWF5?=
 =?utf-8?B?NzYyZXM1R25ZSXBrQzIzTFJ3eXhIUWUzSXQrdkp4ckpaOWMwWUtCVTR6cGdP?=
 =?utf-8?B?dUlOci9jaXg1K2JkbmptWk1sTW1UeXc0SDRIZmtYSnhjTy9YbnFnUm5IK1Aw?=
 =?utf-8?B?cnFLWTZQTnA4ZWF4NERWVldtTE84RlBYcDBBamhIb3VYRHArVUk2UGRrQ1RB?=
 =?utf-8?B?MDByVXNHbjVGaHNqKzVKUk9MWThlQWRPQVFJOFhxWFg5T2pYWndvK0NBMTJR?=
 =?utf-8?B?cE5laDhMOWJBOHRGa1pza296REJxRVpvL3BhM1RCbFlzaTFkeFZObkltRG1K?=
 =?utf-8?B?ZzV4RE44d29zSk5mN1lOSGVmRFlnL0E1T2R3UWZZby8ydFpDV0dqZnpwMUtL?=
 =?utf-8?B?ODNoWDlGTGZ2TzJzOGo3M2E5OG1maklkVVVNZVZ5ZjhyN0M1c2RzcThQYmFG?=
 =?utf-8?B?UzhLYUpqbmtmR0t3blVDaVU3dFZUSTlHVmp3TG1nS21YajhPR01jSGRwdHlC?=
 =?utf-8?B?L0pmaVd5ZFpVMytudW1IM0xPTGxrUXR3ZGR5blRsMDdkc25oRHdrTEtmYmJ5?=
 =?utf-8?B?WW9jUWQwbnhobEFNRVI5bzhWQnY0bmhwMlJXcTVPTmEwTjRTQzhHbkZVZlVN?=
 =?utf-8?B?bHRoSGRHbytob0ZKaUd5c012Tm52ajNKdVdGTUYzZThCc1RlRTFqYTE4ZktS?=
 =?utf-8?B?VVFaeTZzYXV3TjNrRVQzbXg5YU54NFlsSGV3eVVoSGhRMEd0R1pFbjM1OFNW?=
 =?utf-8?B?WkNYbXZ0UVZoNmNTZWFDejBGdUZRYXJQUVMwTExoa3ZMRDlFNFEycG5uWGE4?=
 =?utf-8?B?V1hoY0p6OHRWYmhEVWxuY3RUNjdONlYvUWhNT0wvV0Q5OHpxQWhCSTV2QWZQ?=
 =?utf-8?B?Mm9rMUhERkdIOVFPQzlzejY4QzN6bjFjeFhMMzNJWVlhRVEvRGJnNlNLMFhI?=
 =?utf-8?B?WUo2TmJ1SVAvNVhwUVBnM1RnYm1kWWFBSzN4dDJvL1luRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JTaG5EaTloYk1HMW9ZUlFpTjlrTldhSjA2OXlYWHRLRjRSR2w0K29iU2g0?=
 =?utf-8?B?andVaUQ0SUtZS1NUQ0ZBQVZEZnI0QytzNlR2L3lZLy93Y3ljbFVJd092R04r?=
 =?utf-8?B?UEJ6Z1M3NXdlNEVLL2NoelVKZmRaMldjR3puZU5qc1U5ZGJwUy9NeVhmOHJD?=
 =?utf-8?B?R0RmVkZJNlVqdWhhYjNWWCtBU3R2aFVXQm9ZMHRsZkZEK0M4b2FKc1gybC9S?=
 =?utf-8?B?aFJ1aFEwSURYZmFBOXNZc2FBd1JIc3QzMVE3MHF2bU9yRzcxc2s0cksrd2E3?=
 =?utf-8?B?cVRiMjE0UkIwWktqMThWajQ1QVUrYlpkeUxUeXdmdnFJd2xwZHp3MnpHQlIy?=
 =?utf-8?B?MlU4ZzIrYWI3Qkk4QThYSmdRODkyNlBWT1FkNjRZU25OS0FSNTFlNm5hNEgy?=
 =?utf-8?B?VUhrWkljem9vY2FpNEc3VVQvVW95Z3k2VE1udFZ0aldtZVpxaXlhY0poZ1gw?=
 =?utf-8?B?d2NIeUJNWUQ4aWR3NzV5K2lvYWZaT0syYWRxOGM3SXVQS0s2SHd6Vm9hODEr?=
 =?utf-8?B?Q0JrSkxpOXNoNjBQVERMR09aOFM5bzNrT0RlZHBkQUI4d0pxWXJkYzJ3MlpJ?=
 =?utf-8?B?enZoNXVra2ZIc2d6aGlzRnlPOGtETWpqL2pQTU1qVC90WHpqUTRlOFg4WUxH?=
 =?utf-8?B?NE8xSkNyUTRpTEkwbTNlMitralZzT3NEY09XY1BZRUpQamJJVXV3SmZuSEsx?=
 =?utf-8?B?MVlsWm9QcXJLUi9kOTVpTGRqL3RoRzFYZDVGU3AvOW1tUlJlR1FIcG5WWTZm?=
 =?utf-8?B?aEJsY2NpcmFKVnpwZkgvMHlkSGtGbE9RQ2NodjlsdSs5THpnMUg2NFFlZzFW?=
 =?utf-8?B?am9UMktHdGszOTcvYjlFUmNvRTkwVVlDNmxDbGQrODZHbWVKMjc3OE85c2d0?=
 =?utf-8?B?SFpQMno2TU01WFVaa3NzeHN4VEozNHJScVIzYmdKQUFYYmVodWdyMm5jVFQr?=
 =?utf-8?B?Ylp3ZitJUzAvemZYMzZ6MzJmc054MmVSSmVwcURITTBjazlOMEpOMGZZdUdk?=
 =?utf-8?B?RFhrSVRaVnlxT0xxNEtTREVHTjJGSnM2QjhScyszNDJOTGFwc0JtYWxkYWpG?=
 =?utf-8?B?ckQ4MklsNGFLNHBhZ0xRdWxPTDZkYXBST3Q0U2xETWhmUG5GYVZ2dkJvTU9r?=
 =?utf-8?B?TFRzUjczbXBXRDBmRGdyd1lHVXZubnhXeGt3VU9iZWNDVmZsc3h3bnZoRlIy?=
 =?utf-8?B?VUJRYkZNUG1BdE5UUHBjNDdybm8zTzhmeFFFN21icUZIRXMxcTBnUW5RajQz?=
 =?utf-8?B?Nms2cGM2ek05dVZqL2NkMGUxQ1I0Q0xmSGtQQXFFSHVwWWQzcWV0R3hkbmk5?=
 =?utf-8?B?WWJ0czN3WnZaMkRlM0poYjg2ZENDMnA5a0JpcVRHWGlVYlY3NUpoaHJHS0RP?=
 =?utf-8?B?Q29vajRZd2xXM2JUbFFPdkx0bW9HRXYxMWg5alBxYUZ5SVQ5a0FSdzZsZGlE?=
 =?utf-8?B?YThQMnRzWmlRYSs4cmx0TXFISDFxNGovTENod1F4dU9NNXB3SU91QWdBRGNn?=
 =?utf-8?B?Mk1SWFQvZGp4MStobUVyUGplb29ZbXRNVExWQzV6WU0zZUZGcFhFMFY3Nytt?=
 =?utf-8?B?OVBKaHNTNmRTNEVHcTh4ZG00eFUwQ01WMVNKRXIzeFRncmFKZ3ZvNnNNSCtq?=
 =?utf-8?B?cUR1dUFzM2hCVlBVZkpJMWZoZitnV0J4U0RwTlEzbUtoMmxhZjVrYUx4cE12?=
 =?utf-8?B?WVhsQzUxTHVraVNUOGJjdXNnWWowZFZyL1Jac1VNV0xrN3lpNUE1T3VJa2c0?=
 =?utf-8?B?QW91bENmakJSSTVDUms0YXo5aUhwQkM2cDF3UnNPQmlHMCt4eXVoRFlFYkky?=
 =?utf-8?B?M1lvQzZtZkpVRTJ3ZkNCOWg4dVlnTmowWjVjZVlmVk9FTmFMZ0l3UHpTbUdB?=
 =?utf-8?B?dTZKVDA4bWplSWR2MTVsY09UbE5BK0ROZmNmbE96bTBnbzB0SjNQdkExTHlY?=
 =?utf-8?B?UU9VbkM1MDdUcEI2eHQrNUh2eGo3ZE5SOFNJUmZQcGx3QllCTnAwdkJHZzZO?=
 =?utf-8?B?clJ4c2M1QmV0b3g0cHRmaCszZ0FWRFRFMUpQMHNvdjcxSlQycHFVNUEwOHhC?=
 =?utf-8?B?NWJTY0lNL1FIZzFGSjhqckpGUVNjZXB0SFdtU09Za0lERW9jK3VtMEw5RUFB?=
 =?utf-8?Q?crCieh8iW41E6x3i7BWrsU9Si?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac53f10e-4146-49f5-cb00-08dcd6c0bd91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:48.5273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubs25hsGD932aJO45dtXmNvr1r/y2MZV5MiPQ/kww2TACl4j8Em1xucDIxc12GNzCj1wc6sHH2b1M+w1l9TVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

To support OSCCA enabled part which has disabled FSB access from SOC,
change directly read from FSB to use fuse_read API.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 7df3c686350..42c6deedbf2 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -96,10 +96,14 @@ int mmc_get_env_dev(void)
  */
 u32 get_cpu_speed_grade_hz(void)
 {
+	int ret;
 	u32 speed, max_speed;
 	u32 val;
 
-	fuse_read(2, 3, &val);
+	ret = fuse_read(2, 3, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
 	val = FIELD_GET(SPEED_GRADING_MASK, val) & 0xF;
 
 	speed = MHZ(2300) - val * MHZ(100);
@@ -122,9 +126,13 @@ u32 get_cpu_speed_grade_hz(void)
  */
 u32 get_cpu_temp_grade(int *minc, int *maxc)
 {
+	int ret;
 	u32 val;
 
-	fuse_read(2, 3, &val);
+	ret = fuse_read(2, 3, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
 	val = FIELD_GET(MARKETING_GRADING_MASK, val);
 
 	if (minc && maxc) {
@@ -160,9 +168,17 @@ static void set_cpu_info(struct ele_get_info_data *info)
 
 static u32 get_cpu_variant_type(u32 type)
 {
-	/* word 19 */
-	u32 val = readl((ulong)FSB_BASE_ADDR + 0x8000 + (19 << 2));
-	u32 val2 = readl((ulong)FSB_BASE_ADDR + 0x8000 + (20 << 2));
+	u32 val, val2;
+	int ret;
+
+	ret = fuse_read(2, 3, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	ret = fuse_read(2, 4, &val2);
+	if (ret)
+		val2 = 0; /* If read fuse failed, return as blank fuse */
+
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);

-- 
2.35.3

