Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C103C369C2
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 02:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D11B80F03;
	Wed, 23 Apr 2025 04:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FHOPY6Ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B8B80F6B; Wed, 23 Apr 2025 04:10:13 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A842480194
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 04:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiND0h+WXe/omTNRyMWn65Y7UA0UyjkjEgRjCbIRVtSRyT+wL6o2wHtr9RqnqTBjPAxgMSmQa+wLNTSO0Wq6EPAcxhNqJAGuGjq6bPrAdgF5J5eNnrmOn+09nWCPXe8SqLA3O/k1yln+mxm0QK/HGrl19+MeSiKtd/psWB1SxEpJdw2R1mbnRCLxW4zFflLaWRcuzyTplOCuauATUIVfR4ay50ELGezoB6zNSIj+zE+AqSZRGlQ/YWblYsqWoirJ8ICukdVob1QOFH2ZA672MkhRdFavzMiSnfoNOp1tYUJ1U7wzGJQ3lNr7EvZND2zNemck2QurGp+8w6sUqSi1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e3i5jgNEnVWT1lYWanET5dhi7f6EGvBJzHl1eiGXkM=;
 b=VfGzurZ6uAFVEpCSKWvv4LI/iwbLLgJIlcicfcYmdToT6G726bzSvPU/Y7n8eV2gUI79pidqD3bXXO4dOl8t7Ofy3EAFfc3xrt6Pg2HF08Lo050ir1HGV69Exaq44Dk//Jnel1AWHq3Ph/IwMZwDF+yZR0vZTfMNFhgeURSvm/V2YdOf9oyg/M+bwR/ZUuEA1BhgK4iHcozCSgP+Lm69AjE6UkNiBBE0Ang2cEAdjSkvknAP6QNbjaZ689HI3Z7SkeHCc66HyrRJmDMjZhKjdHY91ciU6sxYrL+huPLpoaZa+mIgsEb2YQrXPK9Ee7Qbj6+X9RmXm4ac9cfjGKuaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e3i5jgNEnVWT1lYWanET5dhi7f6EGvBJzHl1eiGXkM=;
 b=FHOPY6ArDw+3Sf3QwqVPYQdJw9Z6esGaPaLPNHWBp0VuAlZ41y49e/oQJsWF/lEcM0aK3VT15K34K7N+UEKdYxCqIks5PhwgKkxL4r0FMsj/WlAm7lS3og7fhpuX4QJs/jT5uPqKUBvecSp1am5rPI8Jj2G8Bx/3ihaRDftnIbe6QzUk42sUr8WdaMQde1Vnb4gFh5k3nccuAv9G1VcQKlwk1IIXE//0qiNGGFrqu3/51aKJy7q9OoEwWPnlZvcfWpxEDoYyhp86+6SsRfegQvsnDOrpo1zgqwpGtKpdgK4ScVkV80JiDWJsv0IuICa7ZpavHJ/QxSdU8lSTWHnn5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 23 Apr
 2025 02:10:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 02:10:07 +0000
Date: Wed, 23 Apr 2025 11:18:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRd?=
 =?utf-8?Q?_=5BPATCH=5D_power=3A_regulator?= =?utf-8?Q?=3A?= scmi: Move
 regulator subnode hack to scmi_regulator
Message-ID: <20250423031857.GA14439@nxa18884-linux>
References: <20250322014444.174796-1-marex@denx.de>
 <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <4db49cb4-bb80-4aa8-958b-a5b14f0d22d4@denx.de>
 <PAXPR04MB96443BD51F4B7CE32A39ED54E2B42@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250418025200.GB5954@nxa18884-linux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418025200.GB5954@nxa18884-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: b7353d1b-9ecd-4dc0-4759-08dd820bf7fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2RPbEtudFdYUWdQa1lEVHZvVmlSU1JrMkw0UmhIQld5ZGYvUzErellhdElm?=
 =?utf-8?B?N1JoaGpZWUhVVmxiNUIraGwya3htWG55clVpMG1LNzRvdE5lOUZMWE1rOHV2?=
 =?utf-8?B?RlFsekowSGYvd1A5SGlYM1F4WWtyamF4MXA0V2Q0SVlzeXdMUW56OW9ZbUVE?=
 =?utf-8?B?Wmdlb2VkN0xmVkZ6RklENVVIeWN2TUd4ZE45SkZqL01vRnNVV3U1VTF1bHcv?=
 =?utf-8?B?Tmw5RnNaanF6b0lCYTVaOTRvS08zb0V2ZGI2VEJHS1BDbUdrL2x1cSt3TVFh?=
 =?utf-8?B?T2FCcGUxbGYrZ3lTS0R3eWFNTmZzM1ZQcElheFdmYjRhdzBCbVBDTysxbXRi?=
 =?utf-8?B?cktPZ095SFJiL3BPTTVrajkydEdBcmZRSXZOd1daVWxodDByb2thNWU4TCtL?=
 =?utf-8?B?VDNLTENlUXRMRm9NL3g4aXV5ZUM4R2RxS3F5MUJCb0c2MVMwVWdoeHZNeC9P?=
 =?utf-8?B?U1dRYWRmSys1dXlpL2VrbHV5N0lHK3lGU2hxdENYYm9TVHdTK0VDY0NHM1Jt?=
 =?utf-8?B?WUZOelBjL2FMTDJnYUdxVnpmODd2WE5mM0p6OXMwdEg3NzZTY2k3SjcwQzI4?=
 =?utf-8?B?M09FR3RldTloZm9TeTErQWdNQ2NlSUlzMHpEU0RYOEMwWTRwenpqWXNLbm5D?=
 =?utf-8?B?OXFDRmNDUjlldlYvU0lSVlFSbndGVGc0dTFSZ1FJTTJWbnByN0E5bHhlTU1E?=
 =?utf-8?B?RDVxZWJZV0NQOXpBWmgzUS9Za0pwQmpnbFRkVVRWZ0VkTjh3K05LUlB2T2tR?=
 =?utf-8?B?K215UUwyS0RPenpTc1ZJeEd0TFd4L0FuaVBMdmVDbEM2VVFocXloTDBRTEN2?=
 =?utf-8?B?RWQxcEZSZlRpNDZ3S3JTM1VKdmp1eXc4UnhsKzBWSGQ0M0YzMFRtN01wOHVS?=
 =?utf-8?B?VXo5WkFzblE2M243SC8rVE56QkFGa2REam02Um9lcXVLUzVlV3EwTEJFZEJJ?=
 =?utf-8?B?NkdYemdVT0huaE5sZ2VsZzAyTVUwUFgrT1J5MUwxNGpwV2dlTk9XWkRYbkFh?=
 =?utf-8?B?ZjE0M0ZFZVdCeDBLcVgwVjh2NDlBYUJGekFvK3lldVJxeFNKQmpGYkp2RmtN?=
 =?utf-8?B?ZTNjZk1UeC9YTG1WQW9nK25UdGhzZTAwMEFQSldGMm40SW0wOWUxWS84YTZa?=
 =?utf-8?B?R2s0M2Z1cEpkRStLQWxoUzVPUkZhYzJ1MmszLzhjTWRZL05md1J0ZjdHWWVt?=
 =?utf-8?B?WlRFVitzRWcyYTJneXN1RTRhdVZQZGV5YkU3MDNsbFVjTGZ2NHIwZlprTHdm?=
 =?utf-8?B?c3RBbXdsVjNrRmdmNGtFeklFRXpicElsVU1HWFVuQjRxUE5lbHhRV2dRS0pD?=
 =?utf-8?B?UzdJZUtVZG1BZjU4Z3IvYXFxdjFWRFNMWXNnK0RRd0puN2hxU3dWaDJFQm5D?=
 =?utf-8?B?ZWoxc2o3d0s2eTJGdVdvS3cvWHpaTnUxU1VkbGpJZEV6NTRlMU1IdGx3aFpt?=
 =?utf-8?B?dmhZcVkvT1pVaHRoLzZMNVdyTGk1cURsS1RtNE4renBwaFphTmM5US91cDlK?=
 =?utf-8?B?Q1BySzREMVV2WG14Q2wyRkFLNVFGd2UwMld5RkljU21HT3ZsNVBSS0lsR0ZP?=
 =?utf-8?B?bUkzMGxJZUJLeEFVUjNLbll6ei9lU1hPQVZiV1dYS0VXVjFHeDlJR2IxVTNI?=
 =?utf-8?B?QktydmhHaVUyTXdDYmhMSEdxdHVLSFJNbzFXWkVTcCttcW4yc3plc3kvdGZH?=
 =?utf-8?B?YUhDOGVaVkdkUFNhTnh3S3ZTbXh4L3I2cXNvTWI4eEN6WVk0RmNUdCtGc0FK?=
 =?utf-8?B?M1NJOXVwT0grdVNtQzFXeXl2cmxGUDk5NWF3cFhNMVVsRFJKZHlqTXdYUGU1?=
 =?utf-8?B?di9OTE1aVHZKUnVWMjQ0UHlibWtBZDZpZFo5d1EvdVMxNWkxK2xKNzQ0Z0VT?=
 =?utf-8?B?M1NKTVZKZkgxTFMzbi9QK3VoOUJqdjJYenZPdzdFVVBFWWw2OW9KU2xKeFZZ?=
 =?utf-8?B?Smsxc0ROeG9ZcERkTWdpZkRuVUxHc28rc3BPbUFSWndPSGprZUxaVU1wV0dI?=
 =?utf-8?Q?9Ks87HP8ahGZJrQuXLMHB2IvUs1F5o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpZbUU0REdwb04wRytqelQyRGNxa0N6Qll0b01mZ2lkUTMwME5WRlAwZW82?=
 =?utf-8?B?UEhDeU84TzhNYVMvOWdVMlVTV2RCTUR2aldjeHNvdW9IcmgvLzcwa0lOa2Fh?=
 =?utf-8?B?QjFoWTB5SmpyVHMrZkRTVTJTdVo5UVRHdlozeG1ZQ1BKWGFtWEMwRlM0aVoz?=
 =?utf-8?B?ZFRFcjNpdEZIbHREUGRNeWZkN0xLUTVMRFpEbGxYYWFOOFJXMXF6R3NReE9m?=
 =?utf-8?B?TnJSYitEcWR5MVJNNHhUcDlBWUttN1JCTmpjbE96NEFZS05QZkdzRG9ZOW5k?=
 =?utf-8?B?eVgyc2p1VGFwbHV0WE9rOG4rTG1STXM0akpKekNGV0RoOTF3REUwbmJpV2xM?=
 =?utf-8?B?bFIrZkNxQ1N6T09seWpndUdrMVM2Z29NK05XclZ5ZC9Sc1RXWjZ0ODJDdkNw?=
 =?utf-8?B?RDBvS2V4c0xrSGVPcStiMmcyelJ1bHozdDlROUlvKzdaZTh6YjE0cENrNXBF?=
 =?utf-8?B?L0sxRVFLNnlxMTcvcTJpWEJVODRlY3RKcy9EclE1Z21WZTdyMUFBbW81eEVF?=
 =?utf-8?B?NWxFYjdLcE0yQk81QzJxd3MzR1hjTkx6V0g1Szhpb1dlcDNMZzVtWndYcFd0?=
 =?utf-8?B?Q2dOVEkwNkxzNzRTZTJnRm8yRVRTb1JTWEp1K3AydW84L3hTMXgwNGt6WTR0?=
 =?utf-8?B?ZktHZC8xZnF3ZE83aWZ2R0x3TzNqSXRoZkMzQm9Ka0E0azdBNURJUnFWNTg0?=
 =?utf-8?B?aE8vNW5oOXNkaDlRUVM5V2tzNVBqV0gyNzUrNUNVVDgwNjEzdWY0Z3dtSnE1?=
 =?utf-8?B?VVNLaXpuTUFjZ0UzOTZnbUZtZWY0clZTTFFTRjhwYUVXT20rQzZrT2FZZ3Fo?=
 =?utf-8?B?TWpOSkVDUHlNcFR4cldWNEJGV0M5cDJhcDNEYTlqSGxBS1N6TlpVeXAva2h6?=
 =?utf-8?B?OU4yV1UzZ2t5QUlIaEZHYUpkWDdYQ3RKUVFXYjFsbktmNnBUeFVUNEdyQThU?=
 =?utf-8?B?cUJpbTRKK2pCVkdVMnJjdjlrSUttdUd6ZXNSb1NkQzhwNGt0dmxMTlFRcll5?=
 =?utf-8?B?TElldnBjOFNnRGN4TTRQMlpRQms4cVAzMnkyUDQ4ek16NUVNZXQyVmZXeXVT?=
 =?utf-8?B?VmNKcUQ2SnN6TTJJOXN5QVIzV2ZpVVFVRlFLdTRjUk44V0cwTjdIcXVMZSsv?=
 =?utf-8?B?bjB3NGNLU2pIM3ZrR3BtbU1jdkJ6L0xXWnRXclQ3NWhPWjNoZTNUeWMzL2dj?=
 =?utf-8?B?SWhRWHV1bHVKYVhXRTN6dFFHVXI2Wmg1ellMMFg3MEJ4cTBxQ09HR0QyWWxO?=
 =?utf-8?B?Rm1lL2x2Nm0yVDN0ZHZqdTlUYkxjb1AvdW5EdlJqYWJQakpxbm9zcitvaXk1?=
 =?utf-8?B?bmJyZm1lMXhNa2tZd3RUeWwwVEFyMHRHdVZ1QzRERUlKQmtFWHB6eEZqVWtN?=
 =?utf-8?B?MUp5ejkzdU5vZkNNZjZIVTUycXBrTVdzL25iVVhwaStYc0FPdGJrVUNxdUhm?=
 =?utf-8?B?RWcvbHRRWFhlVmxiUkt0bzdFWU9oREF5S3V1MVlXSGFSbEEvcmdPemtLdE1M?=
 =?utf-8?B?dkRRanJWWEFrQnduMzBiMkRSZ05HUnYyUGsrRmpRUUJNMzN6Z25TWEw3Njl1?=
 =?utf-8?B?Uno5dGZ6ZXNaNnFjbTNkZ3RDa0xJUlJwQTFucU11Z0U4emZ6dVNDU2F5ejM5?=
 =?utf-8?B?WHU3Ri9ud1dTYmNCMHFqblUvbkR0Q0puRkVZRnpsNWdxK2ZnL0hEd3lETDdh?=
 =?utf-8?B?U2d5SGpWaE11SU1HMzRabStJMitpd1BLSFpUY1hRS0N0UkdTaytTUkNIQXVZ?=
 =?utf-8?B?dktua05PbXFsc3dtS2hsT1hTWmRUbTlRTWE1aGVQL0JtaFp6MS9mTUMyb0ZM?=
 =?utf-8?B?SDErcFRMVmFJSXBmbkdIRFFrNCs0TlpibnFXME1EM1BacEV4Zi9rMTBycVlF?=
 =?utf-8?B?ZGR4WjNsdW1QdDVCSGZzRm84MnhYR0g4RVgwNnA0RnZzc0JNMnhwRnhvd2xB?=
 =?utf-8?B?QUlmMG9MZ3dXRUJiNk9kdSswN01QOUlGNjh1M0lkRTJvL05KVjFnU0gyRmd0?=
 =?utf-8?B?R1ZnNnF3KzlHUlVzdTFzN2IwZDFNMzVOS1V0UmFhVTlMSGlBMDBveDJHczhZ?=
 =?utf-8?B?S2I3SFFSbWhZTjhTWmlnN0pBbDZIZ1pWTHAvek5SZ3RLY0RUYWc0bHhJSWsy?=
 =?utf-8?Q?C4vR4JKNwGXWAUa4gU0QkDj43?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7353d1b-9ecd-4dc0-4759-08dd820bf7fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 02:10:07.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6MmBL88hTKiL7cgVEBKMlDHK1wDfc6CqO6GHlRshYmXrPgKvhQajGCfY7+GDChBucJuW/qa6Ewlbk3fgG/9Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401
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

On Fri, Apr 18, 2025 at 10:52:00AM +0800, Peng Fan wrote:
>On Wed, Apr 09, 2025 at 06:42:14AM +0000, Alice Guo (OSS) wrote:
>>> -----邮件原件-----
>>> 发件人: Marek Vasut <marex@denx.de>
>>> 发送时间: 2025年4月9日 2:31
>>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-boot@lists.denx.de
>>> 抄送: Alice Guo <alice.guo@nxp.com>; Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org>; Jaehoon Chung <jh80.chung@samsung.com>;
>>> Tom Rini <trini@konsulko.com>
>>> 主题: Re: 回复: [EXT] [PATCH] power: regulator: scmi: Move regulator
>>> subnode hack to scmi_regulator
>>> 
>>> On 4/3/25 12:56 PM, Alice Guo (OSS) wrote:
>>> >> -----邮件原件-----
>>> >> 发件人: Marek Vasut <marex@denx.de>
>>> >> 发送时间: 2025年3月22日 9:45
>>> >> 收件人: u-boot@lists.denx.de
>>> >> 抄送: Marek Vasut <marex@denx.de>; Alice Guo <alice.guo@nxp.com>;
>>> Ilias
>>> >> Apalodimas <ilias.apalodimas@linaro.org>; Jaehoon Chung
>>> >> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
>>> >> 主题: [EXT] [PATCH] power: regulator: scmi: Move regulator subnode hack
>>> >> to scmi_regulator
>>> >>
>>> >> Caution: This is an external email. Please take care when clicking
>>> >> links or opening attachments. When in doubt, report the message using
>>> >> the 'Report this email' button
>>> >>
>>> >>
>>> >> The current code attempts to bind scmi_voltage_domain to regulator
>>> >> subnode of the SCMI protocol node, so scmi_voltage_domain can then
>>> >> bind regulators directly to subnodes of its node. This kind of
>>> >> behavior should not be in core code, move it into scmi_voltage_domain
>>> >> driver code. Let the driver descend into regulator node and bind regulators to
>>> its subnodes.
>>> >>
>>> >> Fixes: 1f213ee4dbf2 ("firmware: scmi: voltage regulator")
>>> >> Signed-off-by: Marek Vasut <marex@denx.de>
>>> >> ---
>>> >> Cc: Alice Guo <alice.guo@nxp.com>
>>> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>> >> Cc: Tom Rini <trini@konsulko.com>
>>> >> Cc: u-boot@lists.denx.de
>>> >> ---
>>> >>   drivers/firmware/scmi/scmi_agent-uclass.c | 8 +-------
>>> >> drivers/power/regulator/scmi_regulator.c  | 6 ++++++
>>> >>   2 files changed, 7 insertions(+), 7 deletions(-)
>>> >>
>>> >> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c
>>> >> b/drivers/firmware/scmi/scmi_agent-uclass.c
>>> >> index 8c907c3b032..e6e43ae936a 100644
>>> >> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
>>> >> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
>>> >> @@ -427,14 +427,8 @@ static int scmi_bind_protocols(struct udevice *dev)
>>> >>                          break;
>>> >>                  case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>>> >>                          if
>>> (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
>>> >> &&
>>> >> -                           scmi_protocol_is_supported(dev,
>>> protocol_id))
>>> >> {
>>> >> -                               node = ofnode_find_subnode(node,
>>> >> "regulators");
>>> >> -                               if (!ofnode_valid(node)) {
>>> >> -                                       dev_err(dev, "no
>>> regulators
>>> >> node\n");
>>> >> -                                       return -ENXIO;
>>> >> -                               }
>>> >> +                           scmi_protocol_is_supported(dev,
>>> >> + protocol_id))
>>> >>                                  drv =
>>> >> DM_DRIVER_GET(scmi_voltage_domain);
>>> >> -                       }
>>> >>                          break;
>>> >>                  default:
>>> >>                          break;
>>> >> diff --git a/drivers/power/regulator/scmi_regulator.c
>>> >> b/drivers/power/regulator/scmi_regulator.c
>>> >> index 99f6506f162..2550b27246f 100644
>>> >> --- a/drivers/power/regulator/scmi_regulator.c
>>> >> +++ b/drivers/power/regulator/scmi_regulator.c
>>> >> @@ -178,6 +178,12 @@ static int scmi_regulator_bind(struct udevice *dev)
>>> >>          ofnode node;
>>> >>          int ret;
>>> >>
>>> >> +       node = ofnode_find_subnode(node, "regulators");
>>> >> +       if (!ofnode_valid(node)) {
>>> >> +               dev_err(dev, "no regulators node\n");
>>> >> +               return -ENXIO;
>>> >> +       }
>>> >> +
>>> >>          drv = DM_DRIVER_GET(scmi_regulator);
>>> >>
>>> >>          ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>>> >> --
>>> >> 2.47.2
>>> >
>>> > Hi Marek,
>>> >
>>> > Is there a problem in your patch? Should it be changed like this:
>>> What kind of problem ? Can you please elaborate ?
>>
>>I think that in the scmi_regulator_bind() function, the second parameter passed into ofnode_for_each_subnode() should be the node named "regulators".
>>
>>static int scmi_regulator_bind(struct udevice *dev)
>>{
>>	struct driver *drv;
>>	ofnode regul_node;
>>	ofnode node;
>>	int ret;
>>
>>	regul_node = ofnode_find_subnode(dev_ofnode(dev), "regulators");
>
>Right. I could correct this when apply the patch.

>
>Thanks,
>Peng
>
>>	if (!ofnode_valid(regul_node)) {
>>		dev_err(dev, "no regulators node\n");

This patch has issue, it will always return failure here.

Regards,
Peng

>>		return -ENXIO;
>>	}
>>
>>	drv = DM_DRIVER_GET(scmi_regulator);
>>
>>	ofnode_for_each_subnode(node, regul_node) {
>>		ret = device_bind(dev, drv, ofnode_get_name(node),
>>				  NULL, node, NULL);
>>		if (ret)
>>			return ret;
>>	}
>>
>>	return 0;
>>}
>>
>>Best Regards,
>>Alice Guo
>>
