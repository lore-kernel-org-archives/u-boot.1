Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066BDC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B4C82063;
	Thu, 24 Apr 2025 08:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uCBeJ7PB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10997806FC; Thu, 24 Apr 2025 08:34:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50C681FDE
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHE9DYFroyQGL0KrNZRK1oEI3Dx1trxKWWkS+7nJqixgD+mF42u1UPUQAbHFsj+d92RQy+ZzumWWIBgCI8R32tDncltNOfRNEkpulLFJ9jZ1B1QFzYIm4quMjEYteS7XcbtsvnNkjhvjH7vqQJE0bYaufY2ueFN9tSjuwrmXmFT24D/xoZT99ebG6ulJl2QiMe/b+J+HuUx7v2ZKKNlQf+UjkXiRKzz5sID8E5twYRwabpDA2uumiOC9ONYyBFrbyM28/Tdx4iVoOmigUeT9HpLLQGyA+/L/7MpFjM/dFB5IGl3DmZN02Ys6k7MXEAaDic6Bob+vsj1oPe4uaf0r8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOa6C6cDueoCMh0NQmygPBAy7dCnDS1dDmRXy1Fp/mc=;
 b=aGaw5uaXa+xE5U4lMLl4WyAl+31iNlXwTZsd4opHatTTwBJUuCZK9r8+bNUojV+8sLtkWtgljj4G99ggQK6xX8Msz4dESPdwVW5+AZmZdcHqLZBqgnIBUVj6LKyKzXOQhVhq9sNoKpQ9oFNioaif/Xv74dPTu3U/9/wF3F9f7SsZy+8b6NS9QTnJuBPI+YYX2dFoeqrNqDf08sPTWKSwYRFWTV/TpeEjS5Kz474NVtIDIveTW/c1SyR00IwtdmZONnxuxOF0VdaxCCjvdzMV54lGkRhmsHorl523oTZO/+SB1Jnwj0OIc1JUxNhJORJgdPwUyuO32kBHPNF0SPb6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOa6C6cDueoCMh0NQmygPBAy7dCnDS1dDmRXy1Fp/mc=;
 b=uCBeJ7PBDjv3T4fW38z2oTx7f7p7FGU949o5lJi2mwcxFLbv2NbpmHOYJsVPfAf+mA65bUH6ZLKwlyb58FjfJ2I6MZZ5tQSpytB7mV7SdVQhDHNxnvlV31KQx9HtkuaIGE3r/AtRwVlQErPN1TaxJjqbW7V5xCWokT4wBAjku8Y19wDjDk5jQl2JRJuTRC/UbGuaUM8PsBVbGsBaIvB2nDabw94DMBnwBEnHlNWBdTrEMKN98AtaSt551aKHmMGTryCs7GVriaDUnMjcsSddt4trA3rA7MDLNDUoHZy1jqw/CcvFD+mcACdDFzFqbI/pFkHXkUXgu9rUrfelkPFJgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:03 +0800
Subject: [PATCH v10 07/21] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-7-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ae4816-9343-41bf-b661-08dd82fa0ad8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aCtqeWd5ekY1aWREWG53UnlOYjBYRW8yWGh1K1gxTUN5b0hVZ0tpUzNoQUtm?=
 =?utf-8?B?andsdTNpalpHeUFQRitMQkJVM3pHczNEcDRVZGplWUhObjI0RDhkR2dDY0ZJ?=
 =?utf-8?B?S1ZkamtSQndPVjkwSTAweFNvSkxGbzR4VGZDOWpJeVpMYTBaT0VUOE5DMmVN?=
 =?utf-8?B?cERNZldIQWdLYjZoUHRIdGQ0UXN3ZUM3T3JJVnN3TXdWRVZaazhUanJ5UXUz?=
 =?utf-8?B?WEpNOHR3b0I4WElWU0J0bDhMZk5sTktZOEFjR1J1dkRUVXdvNEF1N1pkdENu?=
 =?utf-8?B?QVAzNEpsMit1Q29ZN05udTZremJMaWV1UHpRdzA4bXNucTdlRzNSSzNhMXhY?=
 =?utf-8?B?bG9UcGt6RFM5azhzeENJUDQzTnIxUVE5RjdVaTNIdVRqNlRpL0M0MWV1Q3hj?=
 =?utf-8?B?RHBOQ1hHOXl1TzJ6WHFjbWJkVmo0L2tXOW1qemUvRElQWll4YWF5Y2dYQmxy?=
 =?utf-8?B?Vi9BalBvMDErY0htZStmWTc1blNnZGZUY2xNYlZUNHJvakx1UE10M3RkQW53?=
 =?utf-8?B?T3daR094Q0k1a3lPejZYSDBLVW8xRFFTWVAvMk9PN21BM2s2T2ZNU3dGdmhL?=
 =?utf-8?B?Ynk0OXBEcE9zYnpwTXZQV2pQSzZyMzVFd3pzOUJGdzdKVGFobHViZHRwZjBK?=
 =?utf-8?B?aUhYay85Z1duNm5IUk1LcGF1R3V4OUxxWmtKKzFsSGVxN29VUmFlWVU3N3NU?=
 =?utf-8?B?ZGhnR3FrZ2k3TFMvRFJBUzRZbktkenJSeW5XZjcvYlhzS0R1YU1lb28zSWo3?=
 =?utf-8?B?bWJhSDNUT0RSRUROUGNVYm5wMUE5aHY0bldhWUNMbUs4NW0yQ3lTamVwOHJ5?=
 =?utf-8?B?QnJRSHVVM2Z3c2trajlrRHVnVjFtU005Wk5HSUVtZjdIR1duejZ2d3dUMGU3?=
 =?utf-8?B?ZlQrbEwvK1htRndwVmFtNkxqMEJwVlJUelNiT2Z2RDlWUHU4bE9Ydk8yN0x6?=
 =?utf-8?B?clEvbjgxUERtMGpEdUM2SWRZT2pYYlRiVS81bG0vd3RTdGdEemRmOExPUDht?=
 =?utf-8?B?ai9kanBLTkpFQzBSRnJQbXhjaDhUU2Nxcy9TVnVrZ0RDQ2xwQmU2S1M5RjQ2?=
 =?utf-8?B?aE9iSUpxQ0RIeTN5ZHE2UWhReEh1QkZNcTlZVTVaTWpRSVE5aVVOcG5jRnVw?=
 =?utf-8?B?aGRFRlVxSjVSa1ZvbXU3enNDZ0p1SEtVVXlRbWt2VnoyWWZpZGVKMnBLcnRH?=
 =?utf-8?B?MjBTU1MxSHpCTVZGbmkzU0xQdWVVbEhqOUQzUmlFRWxIa3NUcnB5L1ZJQmhy?=
 =?utf-8?B?S0U2ZnhtMlRybm9qaFI3M3AvKzdaSUpDdFlVVTNIdDBFTkd3dGF0RHFQZk9D?=
 =?utf-8?B?WGRuM04yUlltdVVvMzdKZVJJclpIcG9JeFAwQjZCWUkrcHdKNEcrVjZEdjJh?=
 =?utf-8?B?UFF4dndxRWl0emFEcmUyMzd0bWh1bTdOem5YR1ZKa1AxWURqQnFUdWtQeWZH?=
 =?utf-8?B?a21kYXBTS1JpZmJHWnc3RjBqeFJuZDBERUphZ3U0Ly83aWl5TU93VHRQRFc2?=
 =?utf-8?B?Zk1sZ1NsSWl4VHU4eEszZFM5VGUxWktuMG4wWTZjZXArQUZuN2wxUVUvK3Vw?=
 =?utf-8?B?VTY1MExSZlFyRlcwTm4wSXNQUTRqSUJEM215bGhjSUNKKzc2aUZRUDhGYWpZ?=
 =?utf-8?B?cUFOMjBkNUd3TzhUang4ZitoTzIwRVUzMmdteWE5WiszYi83Rkh6UmswZnFC?=
 =?utf-8?B?ZTl3WmF5YVUrSDJBR1lQZk9rMDBaVEVNQU1LZkJaY0IwZlVDREVkSE1JN0lY?=
 =?utf-8?B?T050ZVprUURyaE5RUkdFRHB5TDdPUG9OSVB1N0N5dHdoWmxYZ1Z0enVwSnpu?=
 =?utf-8?B?ZkNBREhHOTZYcnZvWnp3eS9HcHRablhia1M2eEVuR0pVZFMyOU5XZmJ1T3p5?=
 =?utf-8?B?aEZiZEFDakdFd3JEcFAxNDA5QzJzRTZFaGtIRDYvTVJsQU9YVTYrMi82L2Ni?=
 =?utf-8?B?RzJvYkZ6WFhxUXhpQysyaDh1Rjc4bGNXNFZTbko1eGQ0VGZMa0U5ckRnbFRN?=
 =?utf-8?B?ajAxWHJBQVRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTExVGQ3MGxjRDcxUkFvblgyL3dPWklUcXh5anNYVEtsUFYxSU1oZ1hVbURh?=
 =?utf-8?B?K1k0d2h3QkNqNkFGWWduZ1FVdWUvT3B5di8xbitQZHIrdzBBUVI2b0ZDUk9X?=
 =?utf-8?B?MkhkVXZVQStRb2QwQTc0a01kTFdoTENqdVlNb2VZWk5HT0h5SXdYeHpIdFd5?=
 =?utf-8?B?SmhaendaQ0JVUzkzT3NUMTcrMVAxWE5PeTQwSUtUaHNDcmNCRndtQ0JtcFRx?=
 =?utf-8?B?RU9FWFNSYTZJRWdnYnZpSjMyRWtWRnhVZGJMRU9MWFpSakdYenBZV0p6WXJm?=
 =?utf-8?B?ZFpLUzZubnE2U01QQllDUThsRHFYNTRNQmYvUWhGL1c2d0NQeGxiaW90S2NF?=
 =?utf-8?B?SjduOUN2MmIxQnpTRG1WTjZYb0tGS3hmcnVQbGp5U00wN3ZsZjRMM1R2NFAw?=
 =?utf-8?B?YkFyZ3N3b3NlTGVlNU9XMVZWK25RM0tlTU9US1hZdG5DNDhFWXl6THVSZkNj?=
 =?utf-8?B?NTM1WVFXd3JEY0NmU3ZFVmRHdXNXUjhQeGxNdythaE5LYld0cDFvaXUvNHVV?=
 =?utf-8?B?amV5dXh2K2VFTzVJUkdVelc4aDJpbTZrQ2xsd2JUcWVZZHlkeEVOUGplSXA3?=
 =?utf-8?B?R3JOV3pZWjRNZy9HYVAzVDdmQVpINGdzQm5jTDYvbnQ4Q2duajI3OWhBNGNq?=
 =?utf-8?B?dlpreFZYa0w3MHJSUHdsdmhXbmxqUEJFS2lJaGs4MnQ3UVR6dE5VNWlRYXBm?=
 =?utf-8?B?NHdvRkt3TGlpTkZ1M3RRa083QmhKTzB3SndYNzZWRmNOQXZmQ3YvUkRqVVJQ?=
 =?utf-8?B?anJVaFdZM3hpNWVxdU5abVpiMjFFdGF0MTBwREZFLzduaDJZL3N1YmNLckR0?=
 =?utf-8?B?UnhqTXFFVTlOWnFWcW96RXhha3JSbS94K05wZDZCZ2s5TWNIYkVlTGJHNFdF?=
 =?utf-8?B?Q2p1eHBSUXAvTG1UajB2M2FuaFZNSGpNek1KV0RjZHVtaU45R25yQU8xY1E1?=
 =?utf-8?B?VlNsZGxQSzdxaE04YXZya25rVC8rNWJLZEx5WWJvRXpwNDdJUWV6eFpCUEVP?=
 =?utf-8?B?R1Z6eG9aMEZadVk2WjJHUW5TUURFZ1lDSk0vOTM1QmpTNyt6bnBpOFhDcGtr?=
 =?utf-8?B?ZVNQTEpVK2cwNVNjOVhaT3FlcGExcThla0VtTjZFU3pMWjkwd2t1T2VZWTFh?=
 =?utf-8?B?Wnc3SXkvZWt1YXJoOXh4UFBuaHBiV2RTZEFEbW80WmtLN1ppT1MzYUcxNzFH?=
 =?utf-8?B?U2M0cmRyMXk2cm93M2hWYVdZQjFJdFE5cTQ3RlpYcjErN3h3azRWYVh4bGR1?=
 =?utf-8?B?WFhFbkJhNEcvRkN3MHcydE1vVGl3Qk9wZWNtR1ZHMitqdmlZbVl1eXF2dmlT?=
 =?utf-8?B?V0J0clBFZUVXTEs1UGtaWG41bjhDK3dsckJpTHpyUXNiVkZDRU96aWxnVzRU?=
 =?utf-8?B?R2FWNGtXUHhLTEVFcGRBRWVEaitZWlkvY2pEZVBzMHJSSXJGUEc4SDNFYk9n?=
 =?utf-8?B?MEJGSU1aaThZbzZxQlpsTkswSDRqVW5PcEZNTE5aZzBJZTRuOGxVTWRYL3hj?=
 =?utf-8?B?SjYxV1dyUmptc2JLR2NzNDRaUFVJcHo5TnR5UERhYVByZDQyUTFOVFBRNTdx?=
 =?utf-8?B?RG54Lzd0WWlId0hPS3g4MU9URTFtdmVtTnl5WWROTlNFbHdJK2JkWVNuOWhL?=
 =?utf-8?B?bUxSWnZuRFMrZGl4cGlaYXV5QWVtQTMzdHZGWUptVG5FbHdBbG5SMWlQVnpF?=
 =?utf-8?B?VzhqT0R5SE1FSnlvWU1PeEc3aElJQlZwUXJUUzhJTmxuZHRuK05XU09JaGtI?=
 =?utf-8?B?SG5sQkdzT2NYVjZaRDBiT0I3ZjVFQVJnYVVlWW5jbExIZ3Y1SGtTdll4R0Vo?=
 =?utf-8?B?SzhMTnJQcFFqeUFFclBqREFvVEdOaGRIalFvUXVheThaQWFydUoyMWRqUGk3?=
 =?utf-8?B?YWNnTjBENzhXV2lnTUhZck9hV1pwdSt1dEpsdlBLaWI4U1JNaGN3b3FkcVA5?=
 =?utf-8?B?RU1zYkFNb2VQcy9XN29tNEtnUFZoSXNydE54ZHdsWVEwb0tQNkEvd0RFOU1U?=
 =?utf-8?B?aGtla3hyT3o0RHlyZzlCYzhrRldyc0k1RVdNZ3Jsc1AzYlBQTkYrSU9qenpU?=
 =?utf-8?B?Y2hieTFibG4vUkpQUWs1UVo3V0EwRkV4TnVSbVlzMlRKMkNOSzJxK0pRR3Jq?=
 =?utf-8?Q?238ilLPdRt6hDpPGT09xrU5Cj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ae4816-9343-41bf-b661-08dd82fa0ad8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:19.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9VGRHTow8M4vBcGwpThJdlOsSj2Pj8OAP9ShRjSnoqsuxZvxtV+RG97sIfLOh9DaRhfrSrfu4HbuKnAshxIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index b8d40cc9653..af5e8679003 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -179,11 +179,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448c..342a65ae7f4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

