Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11928C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5F98313B;
	Thu, 22 Jan 2026 00:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UTEAXI7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6308313B; Thu, 22 Jan 2026 00:52:22 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828DF83B27
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNq+FvcRVQxDJkMDRBnpbtpA6f9O2rlz5JgonJo9DfeEjriY6cOQ9jkP7Mahd4PFHTndkG0GKpXSKy4kmhr6cVo5nvLM2IJKnkWwHsuwT7eQUOIQ5sag9GplIpistEEB9UKs45OCE+FipWya6E1Y39bpX1bGprafQOfWPr8DTq0GdKsj0MiIia6GJOX1/qGeSFkclWZSn0dI1ucfNNhXeIDgmMlH8ugvs9LUDLC8sJBojAJ6RkVXc06fbW6cJJf6BOF9Se5/IO85dXXxCczn0x1w0Ydo+OKv+NDtJKpkMYddmwoQ1HyVGym5Vl7X1zW2J4Rl46XQE2ZbQVWjLo/NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P33Bod7uww32MaBZ47Yaigy1DBgv1YIoSL7pST0uSoY=;
 b=F3Ju3Issc3nR7R3SEupQyU+o8y0FgKQmeUIFkUx0It8xuhJd4PzNd0lidG0Ghovahh2Z/Rz6Bco7ef4UaRtDtjNavkwraNz3hEA8Oe+N/v+dQilGPdNy/pD55YPXYrXgBcP1TCih4Fqi6pIioXmqPOOZku74d7doArE2o8VTPcrwjDear5ft4UlXI6dNeGHMT4OqukwenEbWfEukm1EQxU+06i2ApdVwIv7vgSuAvcmLedEhm9CgFTqFASo37eniNnL8Yvn8B+xr/qKQlfVbn2EAJntlfb/u3g41iizLANplwOw0jPlJXoeYMmlEk1TAQpJg8rU16MtgXKzQkJBU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P33Bod7uww32MaBZ47Yaigy1DBgv1YIoSL7pST0uSoY=;
 b=UTEAXI7cjEo6jtlDxlbkmg/weSTxGV2ielKfDP99Wa5vDYXxvwvE3u++30Z87qTR/gc9CEXqkGRlYERE/UBloBFZgNZU6tR2yW1J2PUOrN6kTUJnLTRyvDSt4raDJ/1E4NAPgUQV/IP+NhSpvHsG4pOQMsM4JaRFGJvdZpogSDPPut4aHSQeni5uFQHlbqWjDS/VvHFeh+HP7KcFS6uT7mfQHhCxxjaOL+fYmVCTo9PEBGyzr3N+eH0iulkm0fge1pOb2BN0ZJFJEogQvtq8+ZHSDtGcNSY7wuQHf8RhLv5QYembMR6QRrxY6NB9GMcq6v48qGMSQjlz3hC2+MbqQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:52:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:52:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:51 +0800
Subject: [PATCH 08/12] imx8ulp_evk: Drop board_phy_config
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-8-a52a94b7e173@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e000e94-e804-4cbf-4168-08de59481479
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REJWaEdtcWFTMWdZNUlkTWxodkVUcy9EKzRFY3VUUlVPNlBGMW54RzltUy9a?=
 =?utf-8?B?QkxWcWFhVTk5dFZjb3FOa0tuWHJVSnUyb1FNZzAyRWxaaUk5b0NUZ3NZRVRM?=
 =?utf-8?B?QWNsNm1CVEZ0ZkFUa1ZscWRvV1RhK0w5Y0ZGdi9nbVp0Qi9HL09XQzEvL2FE?=
 =?utf-8?B?OUY2czQxZytFTFpZZk5sRGZhRHpYY2VJZWxXL2FrU2tFdERyNWZ5TUd0ejZY?=
 =?utf-8?B?WEFZN29Ea1RQbndRWnluUUZNVDJVdHBjRzN2SHVkZmNwd0FqRjBSNXNtaVhJ?=
 =?utf-8?B?R0VYYVNIc2FVbm5kVVptT3VMNXhQbmxCNGlrUk9NTTJZZG5Ga0d1Rlg4QzVR?=
 =?utf-8?B?RTVuUlJBMjdxSjdlTGE0NkxZNG40bE1KdVk2RzhuS1M5QnhObzYrUFplczZM?=
 =?utf-8?B?YUY3U0lYcmtLNHZ1K21HVzg3TTVtck5TeFZYS2EvbTN3SFhBNDl0VDIrYk5H?=
 =?utf-8?B?OTNRSktjRFM0N2g2RFM5bFNLeDhIeHA1YkF1YlRXaHBNZWV4ejZORDVNRHNQ?=
 =?utf-8?B?ZDZsZVFNNVhVMVpVQ1F0eGU0cVh3NzQ0WVhyeEJMZm1ma3FnSytFUThRdnpJ?=
 =?utf-8?B?dDRjcDBHN2kzSEIyQmY0UEhvTjNxOXdWdnRXYjNMTmxPMUMvWmxqS3hXZVRN?=
 =?utf-8?B?TmROaHVrdkJlN0MraDBPK1JxS1BrSVB1WXdQZHJFbTgyamd5Z3IxQWIveTd6?=
 =?utf-8?B?S3ZvbWtkcEo0RzdNR2c3S3ZDSkVrczhoZ0RNVUFTVks5YjJwUjJvWmI5RkQ3?=
 =?utf-8?B?eG9EVVVFS2pBSmdneWVmQVpsKzM0c1paYkVVZmQ4aU41dUVvQWdzQmE5ZzY1?=
 =?utf-8?B?bE12Wlk0eDArUmxXVE8wV0xHbnZaOEtDdGYvVzFxcHlQaUNVRnJmM0NRcHFS?=
 =?utf-8?B?TUtwQys4MVduanB3WUlUYklkVFM1UnRKWmpDbjZ1TEt0c3hDMm10bDBrbENL?=
 =?utf-8?B?RUZsZWhidnFFblBjVERRbmhMSmZ6VXBhS3FaeVBaYWlER08xZFhmVkhGWnNs?=
 =?utf-8?B?RVdJZFBzTytTMUhMbjZlMWFjNHpjMmhyWDk5UkRHMXBzOUxJMTRoSkN6aG5Q?=
 =?utf-8?B?QS9uUzV6QUlJODdSOE9qTno3NTR3aHA1NGI1b3RzT0VxUEI5Y25NNkNwRUIw?=
 =?utf-8?B?TjArUnFrMEY4b3lJRTFZWjgvL3RQbzZqZXJ2c1FmZVR2T05aSmJLbS9ZcHNQ?=
 =?utf-8?B?U1BjdlFCZTVPczd2cGduVzVzWXpIc1dOUDRuVzNTZWoxVDlGUGwwU2hnTytp?=
 =?utf-8?B?NzFXSkRQcFNYa2F5WXJNMllrdE5nNEJudXEzblY2SDdtSS9xSWhRVUxIcDlN?=
 =?utf-8?B?U05YejJWRzBKTnNpSU5XRElVL1RLeFRxU21kYjQ3UU1GOFlwNlVBdVZtczlh?=
 =?utf-8?B?bzhqQS9SSnFGUGR6VnZ1WUszb2FXZmpWd2FjNERnL21MWForOUdFZWlWWUI4?=
 =?utf-8?B?cU8vWEtJbnlQaXVJdDhnenVpcURkS2J2cmROWWRZRTFLZjdXWUp0MlRUSmgr?=
 =?utf-8?B?KzRhTlFWb0FZRWVUNldYV21KSUQ3blNpMkFmak9YWGN5YStwenA1L3Y3RlBD?=
 =?utf-8?B?ajg1aGdueG91N200TityT0JneFVMVkRFaThRendqREREOHZpS1laOGFMV3gz?=
 =?utf-8?B?RUN1aks5djRTZk41L05LR1lTRG9Fdit4R0pyZXVxQjYrdzBlaXdoa3R3d2Zz?=
 =?utf-8?B?ZUhVZVBmTWhKdmpsSnVtTXEzTkVreXF5cVZlV1Y0UUxhQTBMU1I4TTVScC9U?=
 =?utf-8?B?U1dBd21qRCtJeVNVZ3hJUy9oVm5Ca1FTb1RVZUdRS0c3aVE1c0pGZzd4bldK?=
 =?utf-8?B?Y2RWRGIxbFhoeWlWcklLQkNDL0o0akJnL0ptekVZVFlqMVVYZlhxaWYyM0Rr?=
 =?utf-8?B?aXF2bUZjSXdYOVY0YWtRT0syUnI5a3RuVjJSajVHV0YydEtsSXlibERaWGRO?=
 =?utf-8?B?N1ozYWdLRWE5UjBHQ2dTZVljd1RJcU5EeVhnWmt0b2o0eER0dDh1b0RBc1dY?=
 =?utf-8?B?QkZpVlZGV3lqa0FpY0xJdm85TTZadTNjTngzaEJEUStJVjhxbWVVcVI5bUg4?=
 =?utf-8?B?enorM0tvb2ZaSGhFVllKWC90VlJ3QW5IWXpHL0hmdlA2QXkwT2JZWFg4dHJ2?=
 =?utf-8?B?Z01keFZWNkZHcXRFTW40cW15Z29XTXBScU5NOVROcW9ZQjFMS3d5MVNSUzRI?=
 =?utf-8?Q?OcKNhWmEOJjaPpBRMlt0wi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1U0Wll4Wk1rTW0yZ0Q2VWVHbFlZWDFybzBFNnBacFlNOE9QN09pMStvSkpy?=
 =?utf-8?B?bUt1T3RrZDNyVzIxVzlWYzFhZ0g1NG5jcTZFcjFFdE40UnR2TENpQ3JUd2Fh?=
 =?utf-8?B?cHkyMzFWbmllTTNXVzI5ZXdXOFFxYWJ1ZDRwdTMzcFVNMkJIcVVhR1h5UGJI?=
 =?utf-8?B?WlVNS2lVTXNEUVpWYUhWRmRVbW9SWjRrVkNYSXgyRzZVeFE5TlM1L1c4M1Y0?=
 =?utf-8?B?aC9MK3h1YmpWZlJnYXkyalFGSEtkU3NURXhjMURiTlRqZXVwdHhrcDBzMmRk?=
 =?utf-8?B?L3N0KzdtNmFCeE5SY0dyMUJaWHV5OVZ3dkcweWtkYVpkRFpETU8vOExNUmhI?=
 =?utf-8?B?YkRDWkhSajI1WmZSZTFEcVV5bVJHVllkenBCSXl0OWxXQk5YQi9JZVZvaE5p?=
 =?utf-8?B?QjJ3SCtnNEI1bWsxNlBLS0hucC9vWjN1YXBEb1JPdHdUdElwNDZteUJmZ0h2?=
 =?utf-8?B?SDBsQ2c2cTJwZlA0aWptTmlzMmVjSjVMOE42dnp2ZFVQZmFsVWo0WXdrd0Fa?=
 =?utf-8?B?QjJhdnZxZHQvWnNaY3VZcWRjc2wzb3k4Q2lnU2hyNEJIRVduQzQ5RnQrMDA2?=
 =?utf-8?B?TStRbmlkRTVzd2l2eEl5V1JWbjJYemRIRWFHbzBTR0dkUDk2NVIwZTEzcVRp?=
 =?utf-8?B?UTJnWlg5WjFXZmhJd3M4Y0pEMWxzWkswWktlNlNwTEh6M2JaVUtYb2U4Q0hw?=
 =?utf-8?B?VkpKUy9aSHR6U2R0b3FKdWJVa2o5dnVPWm5KVUNDTXpNb3VydWk5cEJXbVVz?=
 =?utf-8?B?OEcvNnhHTExGUmhrZ2E2WHZHK1ErN1B3c1FGK0FlSVNFaXBSbXRWUFJUWDAz?=
 =?utf-8?B?bGVXbFkyOE9VZFpkN0h1cGZNM3I2NzNjeXRKRmdoREtYb3VrN1YyUlhLdmww?=
 =?utf-8?B?ZjB5MlozUHZ3b0RDUzZGQWhsbkFJNVlCbnhYYllrZ2JYM2hLek50cnN6V0Zj?=
 =?utf-8?B?WDBBZVpEWGkyR1dBUEVBaGRzdDlLTnNLVFY5d1hpL2tGTzdnRmFFZzVab25N?=
 =?utf-8?B?SUhLT1VLRWduWDI3cmRKN2dpWEFEZjhta1pCMERRbUNxdlQ2VEJyMk5Sa1Zl?=
 =?utf-8?B?b3EyUnFPYXRBMFJ0TDVERXphZFE0KzVsalR6dSt0emdYakJzdGluUThhemR2?=
 =?utf-8?B?UG5xZEZuRDZMZ2RsK2ZJNFFObkw2NnlSdjYrQTMvV2MvL0VsQ050NUJaOUFq?=
 =?utf-8?B?aVJCYncyQXE4KzZoSnBKT0Qxb0dETVJvclhOdXhla3JKSnQxOHNHcXRwcytU?=
 =?utf-8?B?cnZYSTczb3NCTlR5ZGl6RDhLUDFoUVZBZW9vb21DM01VbkduNEhDNVU5VWFH?=
 =?utf-8?B?Z1JEZDB6eUU3REpDTUZGcWdpYzZBdUpyQlZnUFRpK3Z2ajNEYzNXTk9abjZX?=
 =?utf-8?B?Rkp6dFFmTjQrSmo1KzZabktRNHRpeWRQbHJWdjI2WEFCNTZYckxlUVlscDQx?=
 =?utf-8?B?LzVoQ1k0WEk0YlovYkJwSnlnN20yV1hUSitLbzBBZnJHVE5NN3NiRWNuMloy?=
 =?utf-8?B?YTM1UUw1MlBSVExiSEk2ZG95bmMzTEY3c0l4SnVKR0syaGVGSy8xS0wwc24y?=
 =?utf-8?B?c2JxYjRHdHFQUGp1S0x1a1l0VmdiUmdyWFZyVlhHMmF4RGNacS9ZcHNXNW96?=
 =?utf-8?B?MEJRN0p6U3JDL2orblBIRzhUZDFVUmxXNTl2ZTVXaXV3NWRmM25VY0dyMGtJ?=
 =?utf-8?B?cDhkQm93cXZkQjFSam9iWlh6Mk5yNXdKdmJZT2Zhc1JtWjM2Rks1L0JxTllD?=
 =?utf-8?B?TldJWmcyQXIxYVl2WHB3WWQwNUtNL09lTy9IcUtWdFo4L1dLZVlnK21WTXZk?=
 =?utf-8?B?eEx1MTBXVjVzL1cyeUVwUlRjZHFhazJ3Q0cxaThaemJWdFM5SzgvK0JCSksz?=
 =?utf-8?B?UGxpZ2E5eDUzWkJhOGhWbENuSWIvSldScWdHYWdneTkzMzlGVUEyendoenNN?=
 =?utf-8?B?dlNUWHZLT0pZS2tQVzYrV1pYRHBsVWZidUFabVMwNmpsWEpWTUZpamNhb0Vx?=
 =?utf-8?B?YnYvTk95V0ZMdEwrM3RuL1l5NG5tUDlIc1JQU1FrS2ZrQzVQMWQ3aXY0YlZT?=
 =?utf-8?B?WXAzRjV2SjMzMkEveWtlUHV3Y2YzTnVNSDd0QU1uRi9Peng1alp6cDhjRmpH?=
 =?utf-8?B?c1Q1TWFValErcVc1cTRLdzRaOGtGelYvTjBlNHJmZkxDbXZ1QlUvUStPWm5o?=
 =?utf-8?B?eDhWMjkydDMvbWttNFZ5ZFJiTlFqZXE2MzZuMVdHY0xSc3JjK0owelhOcEFP?=
 =?utf-8?B?Wm5aUTN5TGplOG5sY05jTEZoLzF0Y1BkR0llSWRybjA4WTU4bmtXSmVSNGhw?=
 =?utf-8?B?TDZxQjlGRzJqalltQ3JmS3VPM3MxUzFjK1k4a2NXNHNoOHN0MW5Kdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e000e94-e804-4cbf-4168-08de59481479
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:52:18.0080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8w2Szfec+G6O0wCSxiV7GuG+8Z1beRx9nRB9Cu/dKn0fC/tAPqZhLii46rVwqUM9tDu5Y1FrUjVz316t5YIk4Q==
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

There is already a weak function in drivers/net/phy/phy.c, which
does the same thing. So drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8ulp_evk/imx8ulp_evk.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index cd17f6960c7..dc4054b92be 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -4,14 +4,10 @@
  */
 
 #include <env.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/arch/imx8ulp-pins.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/pcc.h>
 #include <asm/arch/sys_proto.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/gpio.h>
 
 #if IS_ENABLED(CONFIG_FEC_MXC)
@@ -38,13 +34,6 @@ static int setup_fec(void)
 
 	return 0;
 }
-
-int board_phy_config(struct phy_device *phydev)
-{
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-	return 0;
-}
 #endif
 
 #define I2C_PAD_CTRL	(PAD_CTL_ODE)

-- 
2.51.0

