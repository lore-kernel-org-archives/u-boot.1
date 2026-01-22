Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772EBC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2A683B4E;
	Thu, 22 Jan 2026 00:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mXEL8oHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13AD183A6A; Thu, 22 Jan 2026 00:51:30 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D100C8313B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh+SWmRb//5ngsVXcnKJaD+ky7SbiDOTuNxPctA0xDXkIQ2Fbjgp4hgya8+KY8pLw0WlUqrEe7hjLOfqPFjgZOVA9dtpLOnVGiuN427Pkkjnbuo0CXbvaw7AXFPWcBXiVwbCTAZJhG9wJ6CWIb5F26jB94Unxr6/kHxD9zLSrZeR2oELqP8Z6WkqbPZKMEIt8GQrOYVmpSo5H9Z4V2aG6/x/XQ2ofzfsoDfuVAEWgOZP4C7jpG0QfupVmZSbKoYXFccfJ2/4yE90jv9TuV2oLJQPzv5GQe2+yOkoXaiICpnTMA62i7njVrkQ3nRAfdSxQO6Ia4NcYeVa4n3DZ9i0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noe9UoiEGWqGYoYUDiAZViEJtRGnvbdtcaDMHfcKPH0=;
 b=bKSpLLfP7TxqVihTzYIp/avvariUvGxDcJfImpSoqsc62ReP9Jd2IDRw3jaMFrNJ6YrvFs/n/0Q4MGJmuomCd/TYl9BVo7/RU46n0JzCHp5sUJUXpGrO6lsmRbYPojsLjRlrDUaZ2kezXmTBZiUuHmgqWnHts7e5nLIPL/3AIEMmehPQwaHo+cH0Hs7bKP4TX4yoHlEn1XN1jIl841qu1EwCa/g3ilXYkY9H7z/TasPjVNZrGg3vwbZcr2YCYIr7yi4n3azOs+G/sFPBAX32yyqZMC9I0swj0mkVoddsb9Gy00CUFy8sr5KD6XZkcTu1mlEAC3pEC25C2X1rbMTJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noe9UoiEGWqGYoYUDiAZViEJtRGnvbdtcaDMHfcKPH0=;
 b=mXEL8oHDfDjh63xz1W4XytYhw1ysrnnBPe902Xjs4eQ6Wx6I7vAOX9yHnsT0PdM4jVG67LKPXgEv8zSGWIoNGIH4rTatCE90M7t59WJm43aQJ0r09i5o5W+1IHaGayxMTQ5D6Fie4vkuz8z7MD/LTRnCxyUYlcXAxQWngYd8gGmmRP9BmpC1N2JvFTBKVNuJMjAeWcEzamHyBWko8Z/32ireCz3NZeEUWmhJz/d2X7VbaUP3pXM33JnzBHAgoGN3Ul7Chhun7YaX7DFDZI8GvIqVX7Vx/gzwqI+DA2bu7CZX6MOWWcFYuJHyk4VxMQstHijnKKsO92pexpkAtSYEuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:45 +0800
Subject: [PATCH 02/12] imx8mp_evk: spl: Drop i2c_pad_info1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-2-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ed3276-0644-4334-762d-08de5947fb3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUZPNkJJaDJWYWdoQ01yajJ3SlRDaU5oV25Za1NsK1B3MkNyaTFFYmk1d1RT?=
 =?utf-8?B?d09wSVB4SDRITmQwc0JQbk4zaGZDTmhEdzhONkJxalV5T0dhZnkrRG1XQlM1?=
 =?utf-8?B?RXB0QVFzUmhmTzlMaTZjbmNqMjFxNkNCS3BpcTg3K01KYXpQb2p1NEZEVjdF?=
 =?utf-8?B?N2M1VzFYNHdZUEJUMDVwUTlFQmROV0VmMUd2Sm1xaERZTmNZNnVGNlZGVjBk?=
 =?utf-8?B?UmlVV0xrMnk3cmpkaDhYV2RGYWZFQW5nd01LN2JMeExTbUhpb0pyQWZrV2NH?=
 =?utf-8?B?MW1aeVdCRkUyZWFiZWI3T24wVFNUcVliTUhFZE85c2N6ejJjMXgzYlFpT0lL?=
 =?utf-8?B?aUJwczJLVjhQbjlvOTlYZWRONzFtL0oybFFwQlVUM0s1NjJhS0tEa1hLdjBt?=
 =?utf-8?B?UnEwK0dWdHFMYVk2d1VrdS9wL3RBL2szU2tmQjhDSXhkQ1B6OG5mUVd5SzRG?=
 =?utf-8?B?ZThvNko2NkpvNzVqNXBIWWFIK01qdHorNnpJSjZVNmhKTmU0aWdDenAvZkpW?=
 =?utf-8?B?UkFrWlBVWUZ6QVRsTjY3eEhMb2F2SURKRWVmNlVrY0xmS3duYzFZb2d1R3la?=
 =?utf-8?B?MWJvVjR1czVuYTNxVnhTQ3FnWk9mRytFM2ltK1M1NHZMY1BnZ0hpdGlNR25M?=
 =?utf-8?B?Z0sxZkc5ZDQ3dlErZEp1TEhvem5ESkl1U0oxQXlRb1NVeFJ4N2U1cGhocS9Z?=
 =?utf-8?B?ZTdPaG1sbGl1RUc3UGpzRDQwRUUrckJQV2QwcjNUaFVBQ3VqOUlwbE5aWURU?=
 =?utf-8?B?R2prOGQ1K3o3aklQZ1Vhb0NxRld2SGhKbERTdWNielZIbDd4UjJDU2tqWnJI?=
 =?utf-8?B?cnp0TjUxTlBxN25kV244MVQ2bDZSc3hxK2M0cytsb2FRdzRqVkl4YWpXWDR0?=
 =?utf-8?B?NmJMaHd6dmZuNi9jNzZsTThIVU55UmFNTjZQb0JLVGF4Ymg0Q3J4SGFGU0xh?=
 =?utf-8?B?RGJMeHBSTXdxU0t3Qmd4Q1VRRTNUVlhiZE5yRi9RNnJoSktEVmt2RHhPbmth?=
 =?utf-8?B?MFI1akVieUw1M0tiSTJRSXFSUW5XcndRRDJDZ2RYSTVrSXBmNVorbmZXYTk1?=
 =?utf-8?B?b0tJMDVIeFZZenpmb2NBOWN0cjlmTU4yOXlid0wxRGtWZUJRcVlMTmFmWXhV?=
 =?utf-8?B?dDlDMTluM2tvN1lkVDArRElBYWQ2M2JZMjdyMUdBOWVXWkJaRGVQbTBTWnJD?=
 =?utf-8?B?TTR5OXMwNHpqdUlGWnA1c1BzcENsWnFrbFhzMHdaekhRektSdjg3R1lnWk5S?=
 =?utf-8?B?c1VsbWxCdHBxRzVtRTlqUExyRjY5SjJnNXRTaG9lcFc5VW5rWW5udUxCTUJG?=
 =?utf-8?B?ZlhaMDJhNW43Mk1VZUk3WUdya1BjVWdMcTNYcnNTSitWVm9iazkxRUgyd0hS?=
 =?utf-8?B?RlFsODFWcmYrcmVRNmZJOEc0bjRIaE9WdjJoN2tXeFI0SER1N3Yzb2NmTVA1?=
 =?utf-8?B?dktXM245TXFMR2FmUmIrNlNnY0NUY1hIbUU2ZTBkK2Mxb0hxVE1mMVloZTBt?=
 =?utf-8?B?MXdkNVBMTkpkem03S2x5Z2VwYzVsMm1nOHR5MTk1VjVkRDNWTWZSVDQ1YjZi?=
 =?utf-8?B?NFB2QmM0dGs4QmtINC9HUGlLZEQzSHBoNGJhb2NvMWdEUm8rMlNYMDFSM2VY?=
 =?utf-8?B?dEFsZjBaL0hORkNKdXdIaU1nSlNhQ0orNFJ0NGZlbVdRSXBuNE9zUWJ6Nm05?=
 =?utf-8?B?Y2trSEZpRDRtRXZvSlQxR1RidjU3OXJxaGRMUDIrUEtrYjB3SHpXYk8wWWx0?=
 =?utf-8?B?SnJ6aS9TZGN3OWpnTXpCbmxqTnNxYVRHbXlBZlZsSjcweUszaHJlYXdEM1RZ?=
 =?utf-8?B?YlQ1bmdMak8xZVh0RlhSS0p4TjRRZjhBRURxL3c2WnZ4RjRnZU1lZlhyNTdn?=
 =?utf-8?B?SWp2YytkYkpWdVN4Nm1mSE1IMVJHa3ZkSGxWcW9SWDlCSmNQdDhlZ0JETEo4?=
 =?utf-8?B?U1RQdis3YXlrU1lXcUlSamVXT0VPdk95Q1VkWjI2b1loTUpCZ1ZNOFZabUZk?=
 =?utf-8?B?TGJ5TXQvU3FCUnZCTmJRSjhGd09HMHliOWt3QUZObVR4clRpRDVWY0V0ZU45?=
 =?utf-8?B?TGtEK2lTaDRFN1pmODhKalZkNW9ReTI4cktqM3I0RExLVmtsNlQzUC9Xek13?=
 =?utf-8?B?NUV5RG9RVlc0emJDMytxR0RIaHdSY0lVdHhnWUdSQ2lyTGgwSUJQK1hpWDl0?=
 =?utf-8?Q?XLhMDcRu0qCY7i3OyS4qkoo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzErYVhaSmtYTldZajZLQkV3TWlaTkN0ZW5FNU1mL0djZWp2TWhRbEQzNHVG?=
 =?utf-8?B?U1hvV1hpQkV6dUZKQk9hTG1MVWVMcEV4Q01qaU1DR3BhaHdOSTlxU1ZCV2VD?=
 =?utf-8?B?N0ZiZUZSVUQ3SUtCU2dHbHVaZkFCV1QwUExWZXdUanJFbWFaTU9ocVdhSFVi?=
 =?utf-8?B?U2pPdnV5cTJmays1aGpWd2dSM3lMb0xXMDg3dWcxOUtKZ3R2bFJ6bUFCbUxj?=
 =?utf-8?B?a3RrNXF3MzlmSmQ1VlJnUVZJb0tuZzlOdjJYMWwvNmdCVXVObDlvVTRuQ1Zv?=
 =?utf-8?B?OTQ3SlFXRFJIMmtpN3dNdGgzeUdER0pKMkY5bDE1Mk9tdHNqQzd4Rm1ITU5t?=
 =?utf-8?B?a1JSc2xjc094cDBsVFZsRDRIQ2tlSmJxazg0SGNPYUJxRkhWMG96ZXF3WVNt?=
 =?utf-8?B?K3lyNEY0ekd1NzU5a05UUFI4YUF3ZURTcGpZdktMMHZINitJUmgrTWk2ZWUv?=
 =?utf-8?B?NEJqcE8wcS9vdFlXbFFGd2JybkNaSFJleDc0NjMybWxxTFVwNnRRek4rKy9h?=
 =?utf-8?B?dGY1a1pRYTY3bXVKR0txbGlyUXJyeVFQZHQ5d1RiSDM4OW5hcml0ZSttdFpO?=
 =?utf-8?B?L28yNkRhZnNoUDV6N2N6VVI3WFRSY0kyZ05jc05WQWFRSXB1UmZCcmkzWHV6?=
 =?utf-8?B?U2t1QnRlNHNxMU1DL2pVRGdPd0pJdEY5MllHWHFhZDlmRUU3bHhna0g1VEhk?=
 =?utf-8?B?VVJGb0NpSURKTVpCbnRneXdPdHcvaHc2ckJXMTk1SC9XelJEUjZxdjJNZHd4?=
 =?utf-8?B?eGRaNHBqVGozQzc1Vk1MT1EyZVNYN3d0c1VlWXJUdGJ1Nm9nK2kwM2xCeU1l?=
 =?utf-8?B?bUtuLzhrZjlxb0pqekFyQnFaQ0x6ekErd1FVQ016RlNsczhBd3hKYXpxbVVJ?=
 =?utf-8?B?MHBNRzg2WDIzNTN1RVNOVTAzV0VZUzRPYjRiTmt5Z2NIdStsQTBRL2VtSTBF?=
 =?utf-8?B?YzRFVE44ZVNsdUU5RmxJNEpRYm9CYUM4TEZNb2JleWU2WUZsOXIwR2tvc1F5?=
 =?utf-8?B?WU5mdkRhZE1qMS8vcENuM05XRkVHeklGLzkrbkt6SzN0UU5TTHRpUllCVEhG?=
 =?utf-8?B?YXR1VjhDWHNURnBROWxZbDRxM0QwbDlSck5tN05Jb01YZTI4VHp6MTZMd1ZH?=
 =?utf-8?B?WStDSzc2UVdsd2M5U2cxV2w1Sy9zUGZZL0VqVWxvN3FsdVcyYkY2QzUzd2xy?=
 =?utf-8?B?NHZBY3AyU3BoK2hiOVZLRkFSMGhNRUdDY2IrZVM4NjAxL3FQWGJiOE1xWFV5?=
 =?utf-8?B?K0ljdS9pZTRSNlN2VFFxV3FHSWlTNTZuVUpEVGVNVzFLbFA2cERPKzFzbEJz?=
 =?utf-8?B?WEhMc0pOYXI0YlA0L1l6T29uSVlnVnpDWDArODVSWDU4dXlwSjA2czVGL0lE?=
 =?utf-8?B?SmllczlLWlpoc3h4bndSOTNGa1NlOUJ4RXBlSXhFMk1TbUoyK3ZGc0RjQVFF?=
 =?utf-8?B?OFpRY3hsYTY3TGN3N1NNdmY0N0JOVnBKR1VWTXFYbjRHRG5VT1hHaWl6SW5P?=
 =?utf-8?B?RkEzeVJKTnpPSitzRkVoR2NXcG14cmQxS2M5cnlJZTREU0F5ZzZoVEMrc0Rq?=
 =?utf-8?B?Q3pDckZtY2cyL2xJb2kva3VtcWczM3hRNVJ6YjlsV01PVi9SVFR0K3hzenRT?=
 =?utf-8?B?VmpyTjN3SjlMeEpQNkoxOUFnVVI5SlNNQ1ZjZDhtcmd6VWVURGI3bytrZEVl?=
 =?utf-8?B?WW52U3g3TnUwY28wWXZuZWo2SVg5QzBxdU8xR1IraHJCZ0ZuMDRKM3BEU2wx?=
 =?utf-8?B?OTJWeWVYSklkRFRsZGZHaDc4OFNZVHdaOXBpeU8xUDJDblY4NDdxR2txNjd3?=
 =?utf-8?B?ME9TOUhPaUt5L3ZpN2o0T3loUFl4MTR2REZ0SHZpZHBUOERyV0ZUQXQ0TExM?=
 =?utf-8?B?cGJPZElJVEQzd2szcTAyKzIxLzdFempPekpWNVVrU3J5TFVldUpjWmkyckFo?=
 =?utf-8?B?aS9oTzZsQll0aHRwOG03TTJWRlBLNU91eWNmMFdHNFUya09hZHA2UnprQzh0?=
 =?utf-8?B?MExjb0ZzUVEzOE1RU0RPMHowRjZoMVNyU2VqNU5iWHBJaUNHb3c0OG5ERmxM?=
 =?utf-8?B?azhQTzF6R2JFejFqQnFQRUZiUEQxSml3aWJReWpoaktjTWsvOVQrZU4yc0M4?=
 =?utf-8?B?MXRvVmZFRnZSNEw2Q0NpZUNJa0U4Sk5oNGxRZDlCM21KUDBnMHFPRzJ0ajhL?=
 =?utf-8?B?WTg1L1BZQmdCQVVQa2dLRUVmcnVoUkl0WFpJL1AxWHhtVk12b2tKTGd0aTFw?=
 =?utf-8?B?M3E4SnlCYUZaZzM2ZVNuOVQ2UkxocENsdGpOaHRoT25qbGdGVkI4a2VTMkNT?=
 =?utf-8?B?OG9MTytyY1JjdWZ3ZUkyYWxLY2RkeWQ2ZzNvZGU4QXR3MWFKM2EvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ed3276-0644-4334-762d-08de5947fb3e
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:25.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThLRcAaTsltgsg3uG5bhMDTcpEt2hCjd2bRfxfXorDeSRNEYCYARq1emAZ9btQx4SKlsPbg5wawRJnQX5NARSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

With commit 6e6492c85def ("imx8mp_evk: Convert to DM_PMIC"),
i2c_pad_info1 is no longer needed, remove it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mp_evk/spl.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
index 12da1b2abfb..552bf689228 100644
--- a/board/freescale/imx8mp_evk/spl.c
+++ b/board/freescale/imx8mp_evk/spl.c
@@ -10,12 +10,8 @@
 #include <spl.h>
 #include <asm/global_data.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
@@ -51,21 +47,6 @@ void spl_board_init(void)
 	puts("Normal Boot\n");
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
 #if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
 int power_init_board(void)
 {

-- 
2.51.0

