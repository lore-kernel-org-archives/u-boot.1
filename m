Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A133CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E339E83839;
	Fri, 17 Oct 2025 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G2dPDTiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A9483734; Fri, 17 Oct 2025 10:20:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA65F807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSApbrm+Z/8/pHreYZla4kiBhCpMCknH+y2yc6IUQf6KJk9EDViRLCQq+bBkQXePZg65KYiZTFD+r7JiP3YUk7f53Spy/Xt0GydEar5vYNfNdqH08X5cBKScXIuoibujIgpFposLfPk0MRDCY+G6B4dYerMKcx6vP69t/MXGeITg2KXOuEaEGVs2DQOTVRrubNy3GDs3XNHIUmtgIGAdcSdmPiqLNDfpFaeF1eVpXRUDZDkqYduxhm2NFyVuZ4ojwef1zxJ9nLDbUyuEaX3Wql+/c//a1Z73uYDNgjClWJ/OxApntFqlSNmz3hAu5sszxPPLjICldxiPzMwN2VJlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpeDLcY6oWbfTxaqnptbxbmAbHBm8bO/gl1fxA+XvWs=;
 b=He6TbU4X6lERqpkVtGmgvnHOQD8/oogVcCNzyr4fkUjGMa3dmSlSeQ3n0MXTPOMvrSyOfZ/Rhs59xK+8vXPJ4t5444tpccfVLkejDZ5uVCP3tYQ7ou1MiR7iFc53BJkskN5TvN6t+DCfUnBR6leoRGzoQZj6xRLV0qXvuBQi6Dt+mdoldFGa+Z+7cu1NSpoqAPgmce9hxVdlEZe1WwL35Qh3QTZZeLZnixtzT75uZcu6eKtxQgn9yufknvALUVx0LAbElgJ7X6COnk0LOyrIBtiTRhPEwOl29CY8zhl7Z8FDZv+d+C6fC9H52ERPOaZtK0npy3WvbQtT+7Oc6u8LvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpeDLcY6oWbfTxaqnptbxbmAbHBm8bO/gl1fxA+XvWs=;
 b=G2dPDTiXeU2PxYynVP9nwFMZ6HmuhB/LczOuoBo+bmZ2sx+4z+wJzerdpfyINgCP1Qe3ssBrFo36ZVGVDRR9uHDRao564Psi3bhJDcCobnyGUTw6q4qDJ8cuQ4Y5FpkaqqXPxga5No3+nWOpOQ/uLmZPe2oUwCdSUJUiRIvyqGqaN3Y6HZDlabgXlGueqawid2BcxYTmA83TmONSYbt9HnT4dbndp4iUh5AWxnbD675W1+Q5qPdH36jZ/CwNIAfwJgTSmZ6Ws8mwcMZ1iNxRF0xoML3TXC0CzVsW1ewFbEk1WWVyhxK3L6G5MLfFUxRIOlEQN48yL+5UtXCCp9r1WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 17 Oct 2025 17:32:30 +0800
Subject: [PATCH 1/5] firmware: scmi: Conditionally compile protocol support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-scmi-lmm-v1-1-9fd41e7a5ac0@nxp.com>
References: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
In-Reply-To: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: ee90dec3-a489-4559-be45-08de0d560172
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZStmUUVLRldFMmVxeEptSlBOU0hkT3M1Y0VFeVZZeXJ4a3hDTGp6cjMySU13?=
 =?utf-8?B?UUtpLy9KVUZGZ2FPdHlwKzczVXlmWG1CWGlCdTllbHN4dzFsamNpeWFYUlc1?=
 =?utf-8?B?NWJQaWlIZTdNRnNOQ0N4WGpETUlOVWkvQ1QvaUdIOUxqYXdsUTFCNVROUm11?=
 =?utf-8?B?OHgrT2dMOXJxa3c5SHk2Y3ZzTDdDV1VGengxSXhpZ29WWkdnR0FvbnhYNktG?=
 =?utf-8?B?WmRWeEJCaXhUem9KcHFtb0krUFV0MHdOUldyUHgzb1RUOVFMNmFHWXk4a1NX?=
 =?utf-8?B?YWErRGhPS3o2NFIxNHZoSnhQWFRVVXR3S0R6cSs5OEZobCtxSzNBMWpmK05h?=
 =?utf-8?B?dEllbHdWLzU5dGFwYkRQZlZBK2RNZStpLzBBZkVTWmh3ZGtTcVBJRkptQllF?=
 =?utf-8?B?SGRaOEk0Mlg5VGRNSEhzUkNjK2NOVDdXOVFRMWRBa01ad09wS0JGMjNGRGRW?=
 =?utf-8?B?Y1FBM2Y3c2hxbk5FWXhnblhNY1BnMURZMmFydzVSZHJUcFJRUWJtczJSSE9G?=
 =?utf-8?B?TURTdmpEU1hqckVJd3RhOTdCTWNHU1YrQ0M3ODdmRFFYQnc4anJTU2VwQ0dF?=
 =?utf-8?B?a2FCZ3dob2dTeUY0cjdnZGpTTXROZWxreWwyTEg1cE5yRVpiOTI0T05jVW5D?=
 =?utf-8?B?eTNBZndrNWpxWXZoQTJPZ0U4UlNMNUcya1pFaGJRV0VVTk5hcG5KRWZvMEtO?=
 =?utf-8?B?SWZnUFV6M0x2YXhFdHBhSndjcFRjZVo0Z2xKTlNHMnRwZEZzaVl6NDZPcWxu?=
 =?utf-8?B?Wjg5bDBXQ2NObDd5MjZZWXdnekZuUnJDTi8zcU1RNENvRVZiTThxZ1lLQVQv?=
 =?utf-8?B?Ty9ON3hlVDF5MFYvWUNnQnh5SjFBa2l3ZkRDYitkeW11eFd1L1h0TnRZNzk3?=
 =?utf-8?B?Z2w4Z010MlJnWXBndGxkU2d2YXJVNklrOWhoOGNmcHRaeWJZSlNralRuZDhO?=
 =?utf-8?B?OEhTMUYrL242RGdFcExTRm8rVlNIaWdLbFJwc1JwQVBYaXYxem9TZlpqaFdw?=
 =?utf-8?B?YTZZeDc5Yk1xNFo5bWxrZWR3RVpMeDJvVmNpYmpiVDFjVGxJZ1NTYW1iSEJR?=
 =?utf-8?B?UjBpSEtPUTZLZVVuVGc4SjdnckowUzluK1FBb0diVXc4bHZ2eFAxVnB5OVVK?=
 =?utf-8?B?b3RXWGhkNEF3NEU2dXFlTDlqMkR4dEpQNlZkWW4wZjZ3WDRQTW9KNEdUYkdi?=
 =?utf-8?B?dWpucWpQZXVMMS9pblhpSkVWVnpMckg0bHd4U1pJRHh0ZllycmkwdS9sbE5K?=
 =?utf-8?B?ZXdBMGJxN29FNGlUUFhPUWtzOHBqdWkrV1pRRWtUUFRqQ1RubElSS01JemJF?=
 =?utf-8?B?TmR2cEtIb2UwWFErMnFkUnVWMXprb0Z2dlZCWittdVZERE8vOW55WG9Oa01K?=
 =?utf-8?B?cG5KNWt0NDdkSFhpVXZLYzEwMHVQYW9vbmRTSUZUTWVUb1pNVGJ0ZnlCT2Ri?=
 =?utf-8?B?V1Q1OUwrTytNRGJJWWJmWU5jN0Z5c3BXU0c5T1dVMzlRWmhrM1hlbEJSeTk1?=
 =?utf-8?B?TFk3c2RxTXM4YU5yQUZOaHBNZFoxUWJLbXdSNmE3SXRxMHZuc0xYbWs1ekRK?=
 =?utf-8?B?ckMyQ2hlQ1BGcmlRNThFcU5jd2RpVmtEa3pZV2d1VmVBZWZxcXhxOXlJd0pL?=
 =?utf-8?B?QU5rUFRrOUE0ZklvYjMyLy9wa1Qvb1RpYlh3cVRqTCtjK0tvRGhUQjZ0MFBm?=
 =?utf-8?B?d2lPUTNlRXEwK2JJQU1zcEJ5amVwM3cycWtjengyaitKWlpUb0hzeHJscHJs?=
 =?utf-8?B?Slhqb250YVBRL3NadXBDdGprZnozWXIybUVBYkI0NGhiU2M4R0hlYVI2WGhF?=
 =?utf-8?B?T0hML2MreHRPcDUwOTVvdjlQOUxmdFhzZktpaWtNdmJLeHlIQ1VuMzV4SFNM?=
 =?utf-8?B?c09OcHZpNElvQmNpOGRudWFranBFVjN6Zm9seENIOVlya0tpa0s2bmRweFZO?=
 =?utf-8?B?ano3UVlYUW40SDd1WTlYbmdWRkc4OFI4aGx2bTFvTWQ4OTZXd2VDUGJzaFkw?=
 =?utf-8?B?Mnd6djdydHJRYlZYaWNVdnZ6RjJMazUvVWllTWFFcW00bkNNV05kZzJsSzdh?=
 =?utf-8?Q?wFXFby?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxnTzUvRW8xbDBkRGxNU2l0WFFGWktEdTN2WlFzcWZ5TGFaVGNiUzViUWNt?=
 =?utf-8?B?aXZHWU5kdW9oako2MnVDUGVkUjF3dytUSG96R1hKNTBLNDFSSkFJTTJqNFJP?=
 =?utf-8?B?UXVKMEZvMWdZMHpWa25USnFBZHlsT0laRFJZdmo2b2ZiRE9odXo4OFoxVjdI?=
 =?utf-8?B?K1NtT3NUWERWTmxpQVVMNzA0UDZoNWkrejVrWWRkb3drY3JoN1ppRjUzNXpH?=
 =?utf-8?B?dlFMTWR0eU9MV1FYMlV1em1SSVJ3ZWhxVVFXcUx6WmRoaE45Rlp5UW0rU3BI?=
 =?utf-8?B?SVdpSmRqa2NmNXlvSUFwT0RIMWJjdlRFdVp4ZTNUV3RJcXhTQmR1MWp3NVFi?=
 =?utf-8?B?NDh0ZHMzcmRjUEZ6MlBYT1ExOW5udmdZcCtQWTl1QkRRNSsrOEU5TDNTUkVs?=
 =?utf-8?B?dGIvS20yNEM2bjk3UVhtYkRPU0ZFUVVsM1lNcnBLMXVXNTBSR0U2Y0VBR0hu?=
 =?utf-8?B?ckVyb1NuMjdSeEVCeGtzTDIrdXVFTGdlSGJiL2FCOFdmYXI2cU1wK3RmMVRv?=
 =?utf-8?B?dEFqeWxrS2lUVHMwUkN2NTRVVVhlODVlcjJOTW0xVWZxckM2M0s2ZGY5S2Zu?=
 =?utf-8?B?dUtiVXR3K0NtdEVyR1dZVjdLUjRBdVd5ZUdjQXl3bGhvdlZpVGx0eldJQm52?=
 =?utf-8?B?L0RncGpmd0tndDBnOE5qYndXTHB3aStTR3ZYcnhxR3c0djZhd2FLT09RSUM3?=
 =?utf-8?B?b0dQVDRQSWw4cHVaaGtkWSs0YjhteFRsOXVlSW5FeXFLUHVPMHAxcStDYVk5?=
 =?utf-8?B?bGtqZFBmdUdsKzZJZ1U4VHBlU2JkRlZxY2lVSWZ6OWkxKzdIVWVKRHIvZ2h2?=
 =?utf-8?B?T1VnK1hYUWdtL0NOcmxjQU96MjM1QU9Qa2FqRGhtVng4ek14aXo5US9xOFJx?=
 =?utf-8?B?UDFhN2w1ZTVBT3Jhc3ZBRTA3bmtaV0dGTFRDeFNsaWZjMWlpS2dsaDFuNlhI?=
 =?utf-8?B?NzlJYWg3NlNyazJZaHJZU1N4c1h0NjZwRlFDTmU3LzJxSG1QalZRTG9hd0VC?=
 =?utf-8?B?S2dwRGV6b0RIN1B5cDVVWTBUN2NpSHAxQlpRd2Jva09vVEVZS21jY09BRGJK?=
 =?utf-8?B?NWlQNzZxQ3g2L1hPbWRhaUs1MVdqWE8rR1RpYkcrU2tyRmw3bVNqRnQvNmZr?=
 =?utf-8?B?YWZYdk5samxseDJhTUIvaVIwRHNKV0M0V3pBSVEvNFBhU1A5djBFMmIreG5x?=
 =?utf-8?B?ZnFzbjg2cGxRcWpRTTFqaHdzRXpnQVgwVzZTNlYzTEQxS0xkamIvYVdqSTVx?=
 =?utf-8?B?NVEwUmNlaDB0SFlZek1EM3l3V1gzampHUW1MMHdSSVFTWEFySEVWNmsrWGI1?=
 =?utf-8?B?RS8xcUpFUkZ6Qys2TTY0MVhYNWFHdUV1QTR3V3gxWVM0R1dhUkpuZytRcWVN?=
 =?utf-8?B?bjd3dVNJd2lFMUduakN2VU5jbitLclNoT2crbnhHUVFWUmJGVnVZb0Z2SHFk?=
 =?utf-8?B?U0NEZmk4bnc0UzY2WEdwcEV2anV0ODFHOVRMTk94OVJHWWJJTWpqVHlYTDhW?=
 =?utf-8?B?TWFCcnVxQ1psOTFhcllUbkNNK0dvSXI3NDZKV2w5L3lWbE9zMjdCZGNJSjRz?=
 =?utf-8?B?Vk5LZWt4UVZCdmRKZS9ZNVNzSWovOXM5ZDBramxJWlhlVlZVVHNmcWk1dlpl?=
 =?utf-8?B?WEd6aVNSNW1IYmRlQjk3V3F5RlA2azNwa3NRNGxpV1VwR3BXOFBjWlYzTHVR?=
 =?utf-8?B?endFWml1QkhGSlFENGhTSzREQ1Fwdi96b21LWEN0Q3dZTlVHRWs3TmZqNFZ4?=
 =?utf-8?B?RDdWeWRoWEZuVnd6YkdVKzEvMjRLcmYwL3JPOFUzVTZ4QkcvcmJ0ME1RLzkr?=
 =?utf-8?B?RG5iMEZtOEhENE1SK1JrcGVnbm1DMVZYQVpFbS9Fam1jUE9jdzIrY3FKS2tR?=
 =?utf-8?B?bjhuaEI4OFFLa3U3U2F2ejdnb0xsQmVsNHgyWGE2K0xlbmQyNHhyUXhvTWhj?=
 =?utf-8?B?b1pyRkZxc25WZ3h5Y2t1Mjc3Mlg5aUF4QXN1ZlNUMFZVbDJsRGRTbGd1NVBy?=
 =?utf-8?B?SkJoMmhrV2lTNFRQS2lIZjE3NUU0Qm01Y2pPcTd2d1lxemxQMjB4OHlCNFh5?=
 =?utf-8?B?WENrc2ordGNUUjh0aXZNdU4vNXpZY1ZmVnpCRVVQOXlGVjY1elM3aXQ3dHp4?=
 =?utf-8?Q?kDnrj1hAX/cs21HsgYrQEcG1u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee90dec3-a489-4559-be45-08de0d560172
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:17.8004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1+Uc6bVEHLCxn/g73esfmP9Wr3JwAUZws0zme8oEHVul2iXDLh3/qUCJVn86Nww3wRJa0QOm/IcTzo4lH2aiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Mailman-Approved-At: Fri, 17 Oct 2025 14:40:46 +0200
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

Add conditional compilation for SCMI protocol support in scmi_get_protocol()
and scmi_add_protocol() based on corresponding Kconfig options. This ensures
that only the enabled protocols are compiled and accessed, and reducing binary
size.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 20 ++++++++++++++++++++
 include/scmi_agent-uclass.h               | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 69a277e8786b46994ccb83a04c155175858791ad..f48c2fdb27b16e0693eca6316d2ef6b27bc1eedf 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -86,21 +86,31 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_BASE:
 		proto = priv->base_dev;
 		break;
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
 		proto = priv->pwdom_dev;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_CLK_SCMI)
 	case SCMI_PROTOCOL_ID_CLOCK:
 		proto = priv->clock_dev;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_RESET_SCMI)
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 		proto = priv->resetdom_dev;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		proto = priv->pinctrl_dev;
 		break;
+#endif
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -139,21 +149,31 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_BASE:
 		priv->base_dev = proto;
 		break;
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
 		priv->pwdom_dev = proto;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_CLK_SCMI)
 	case SCMI_PROTOCOL_ID_CLOCK:
 		priv->clock_dev = proto;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_RESET_SCMI)
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 		priv->resetdom_dev = proto;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		priv->pinctrl_dev = proto;
 		break;
+#endif
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index d6586eb3ff9d48073cafbb4c036874dbe4e0ee6a..ccedd42f3670c95376412f686c67d462e9740c06 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -40,11 +40,21 @@ struct scmi_agent_priv {
 	u8 *agent_name;
 	u32 agent_id;
 	struct udevice *base_dev;
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
 	struct udevice *pwdom_dev;
+#endif
+#if IS_ENABLED(CONFIG_CLK_SCMI)
 	struct udevice *clock_dev;
+#endif
+#if IS_ENABLED(CONFIG_RESET_SCMI)
 	struct udevice *resetdom_dev;
+#endif
+#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
 	struct udevice *voltagedom_dev;
+#endif
+#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	struct udevice *pinctrl_dev;
+#endif
 };
 
 static inline u32 scmi_version(struct udevice *dev)

-- 
2.35.3

