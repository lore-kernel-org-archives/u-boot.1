Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D742C28B28
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 02:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB128192A;
	Fri, 14 Mar 2025 03:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Gwij9yeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100FA80F4C; Fri, 14 Mar 2025 03:21:32 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6B88058A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 03:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRiWP7Isf9HJcb0QlTmKaVslh4sOB1t9AQlmRPxjpbm4yTmXoT5oFc4hGc3WhyTBF50nmwfoPhg4fzavvBC1LxlAeoFnRg8GeP51fMw33EoSLbZ9gvT16mGWgqsnpAFRUSgDafrbF7XOExNLMCfhFMABeJndx0k8u8ff/rk+M5LmNmvFWNfT5reBXQQ5oR9jSUmWEGTDcVVZKg40uoEna0FWGupUv46Xd33CnuRYAKDRN8LcsxUKzGaE4gn96VAmb+oa6vg3LCqYvHqxFCZ5KmTk0rX9olBFGArHTyVIZBGpb4GdPAJpexu/RwVVyPrUnc2cNHIzfd1VwPUFu0Eaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoFepEWtHI67yKshrlz6es0qbT1E2+PxJqrp0b4NgFg=;
 b=r4WF67vfFb9uMH5T3hbHp513pOZL0nTxCUlaxJ3xyd4M/wnrltnBHuVhQLU1jVf7cQwaIC2q2H5wijdCwEmgK/MKxYlgjGpf9AxOe8Tw5BG6ZQp3A018qNojogcPLmSbXKff/S0tVZ6ZkPJhRYjPAR8W4hCgReEnWt0T8Qsx4Fz3ktEPAx9AZi1LbuVz65Ba8oS2AZ++zb9KtPANnTlYoqFboLVKQNJ491uYyLm8rV+CTIh3F6kGkDJ8mOWMBcO3eoyS64wtHda+4h2RsxRVcJFAXvve6Nu/Z7B2Ifz5ay228HNGK6U2hyu8L7lXP/G1w70qIgQ4M7dCea5wL44P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoFepEWtHI67yKshrlz6es0qbT1E2+PxJqrp0b4NgFg=;
 b=Gwij9yeOaFgNg1EiPrTqxskuHb6WN3dpXfQkz/0YgSAAhOfT6QatbaXR5Vrdn7hjLgvaiWihXfKPXQTcVzEKC4quQVwzu7T7u3YeoV+IoJqMNlPX2o5lTZmNHDF6EtnE8UwGZYCZGEc+Sk3aOAaK9VGc8j5gT6T50sCPhMSzjC0i4tqvKfHvU+YbXm/dFNp04ZIJJ6i4j+4AgVECzGljV3Z3BjZVHsMsR4jtGP1/yYqW9nUxDskRP9Rw0FuhxfkkzRbqnGmLDbV2US8iJcPOKGzZPrm/o0RLEYc6HPV/RGd5qMyiphjzOUMBLx76yYLPtLfVBSUyZk3vDiEu0pjOhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7491.namprd03.prod.outlook.com (2603:10b6:806:3a0::10)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 02:21:28 +0000
Received: from SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191]) by SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 02:21:28 +0000
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 2/2] drivers: fpga: Follow mainline to pass compatible
 flags to fpga_load
Date: Thu, 13 Mar 2025 19:19:53 -0700
Message-Id: <20250314021953.18379-3-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
References: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To SA3PR03MB7491.namprd03.prod.outlook.com
 (2603:10b6:806:3a0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7491:EE_|MN2PR03MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3f66cf-f810-4cc1-e826-08dd629eed24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EkOR4q1zmOiXMrYdfprSuKYtvE27XLujp/8VvcfYcPVII0SgsQE+ehkd1aCI?=
 =?us-ascii?Q?f4R9azdL37Z+s30yJsnzbL5iG2/636wrJoIMm3vvpf2E5cSYioRBP/HvS/Nl?=
 =?us-ascii?Q?QwqtnhzeljUKgGt9RmstEtv6V5DL/S2x1Bek2xET0m5NH3/Dvum88QJ7Ocfg?=
 =?us-ascii?Q?xVtR26Ch1wUeunv6ViDTpmZ8dyQTTkwwag5re9s/MzGWsT3nc3qvT9jSMIzY?=
 =?us-ascii?Q?T2JlnLGgTXuQ4fHsroMOwTz7PQ2aLeqP4TBESKivz/rM2l18FCxxsOEamxpN?=
 =?us-ascii?Q?T9bjriE6BrvvfDbHQKi5HS5qTYbV5W66OzRGMB6aPC9KsnAopS/fMkx8+L1B?=
 =?us-ascii?Q?SjgWiqC4YOVso3xfaNwsI8cVSszpbCQ9kA3bdvpsYO54vzBvSHmUF87j7ZEV?=
 =?us-ascii?Q?Z6qOTloyNxt8Osz+8Z441sxXBQP4Uar6MZhiq7dsH7tVnwSavCdJy4dY+MqP?=
 =?us-ascii?Q?Gj+xznDuxEjMOPVOMgjGS/ghUBEqLiLOsEj/1KQaOyKIp6hsWN0xD/qaA9ys?=
 =?us-ascii?Q?4qMaR/E75W23Yy3SBPU19uBsPiDddYao/4xnT8DFDMH21sSTI5GXsbbk7xrW?=
 =?us-ascii?Q?XviJIjmk4RPMkbrZ2pMRy+zdRXHMOAwzykjP5nHvmoBM/IkAJUHd3UC6hbfm?=
 =?us-ascii?Q?dzAFpIpT0AeeW9q2I3Qd3KS0YT+InqFjyffn7+bbf+yb5H4B11z6y47sZ675?=
 =?us-ascii?Q?6R8unXtrnm4sln2tIZQa1Bje4y1iGkn6aOhs4KecPak+ouJX0dlZDmHtPuTy?=
 =?us-ascii?Q?4r8kyGhZMPX7TopSxPROnFK9QWa5sttq50dJytyMUYsku4k2PTRCg5xfjr09?=
 =?us-ascii?Q?PUXHmuzMzE4IZ4hSAe3Ej/8U5L9X+SOEEdzKhmomo4yQsnzy0hZcqyzrWh2i?=
 =?us-ascii?Q?AsdOfB4Jv5T6i5W/fkf6Nsrfqa2F4WrQrWWeHosKj2APLr4Av3XH/jmh2zLp?=
 =?us-ascii?Q?zn/eWvhcWeCqhV7y65ENbTcMQ130FuPobitPFxkMsPeW2NN2HjIEFek+TpaR?=
 =?us-ascii?Q?PODQdSyVoqMG9Fzu3cyk8yoUBUyvKjy2LQ2cLAOMhL+XkHhwz7pU2/ywhDs0?=
 =?us-ascii?Q?lqwPOoMcKnFAHGTmkmfsIo6jTtxuHTvViPqFs84kYHf57B8fiNlzkUVhtfcy?=
 =?us-ascii?Q?Ajdr9sfi/SKLNp07bzH/IBWIGLY/obhe1zksL8zJ8W2vsFEK6eiyjPvrspSp?=
 =?us-ascii?Q?kqM7ps3tje5Qw3lUFtAxGxguAL1WgB1vuVRRLI/AjW+Ch9uz8K69QDD2vD8x?=
 =?us-ascii?Q?y4zdn8wq10Nrmuz9JLnxiZKjedBwfaV2+3cylzbvW46uANPktyvc+2CU4NSZ?=
 =?us-ascii?Q?3/7XURRLhzIC/2mVoN/iTdUezNwcpphT5fz5qYSLctj45gZw2yuTCSsMy8fR?=
 =?us-ascii?Q?L5+jlIw4uelAaczqePRRFY4HVYZY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7491.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PzxJ869U/8bijDTQlmUAh7GaGvXbnJR8a+q50qZKLhxXcLV7jCPGGE/A4SZR?=
 =?us-ascii?Q?GeinuCM/Y/jUL5WmTxENl8l/yrhkoqvWjyakAPO5XwnaKBItLo5Yn923dgKc?=
 =?us-ascii?Q?ci/rQWJ/h6rLtnDHW10MpMmryyzCOx44vD3cvkNNqxijGM/lV6D07Vz7Q+Jx?=
 =?us-ascii?Q?f6C98SuiKLZTfXNjYzjKhdBl4JxFm9ROxjWhqdsK9qpHMOw8WQi7++In52wI?=
 =?us-ascii?Q?CtKVKF7Dsn9AexWgK1GgjgMNM4s1t8KLpJhlf60gQJTwGM3aNomQM2p/qR/s?=
 =?us-ascii?Q?ZPUXDjmRrGelmeeQ4UZe6plPOSzdC4E3nnODF+76Qpfi28NRwYXKkVyln6mL?=
 =?us-ascii?Q?CMaI830VQloF/k1zoSmzP0isHJfmJg4Om9YR/4tzzY7tpATQA7mtjCGliVEs?=
 =?us-ascii?Q?CLWOI2uxuWLxESuK5BIHIj9rDk5PTVAWOY659zrhAB/MBAg1yHPy683chA4r?=
 =?us-ascii?Q?idXS4UkW1doQBsG/W+12ytl3Wvd22eHAul1VIjs51VIGLeBZvaI5Eel80nx2?=
 =?us-ascii?Q?3bP3BOZuvUMfgcn7fctYO5edvSVJOqH0+zsDYEhPkU6/x7j2sGzJhKRwoed0?=
 =?us-ascii?Q?8OQFW1xGwu8ol5J54CD7JxztDzRmPBmiVH4lHXAeE0smX3jYXiLq0k5IYx/R?=
 =?us-ascii?Q?Ky7XjmlcSIMIw4cv82hvXZ2Afu8OzoruumFtCNqHN4RRudhUJOKeg4VyS0SX?=
 =?us-ascii?Q?VkEkv9aOPgv12EunBMaXgEux5DYTgDHdLma6Bi1Y+B9g33opnnUTC9O3UE4O?=
 =?us-ascii?Q?KrkLfI2clDb00XBbS2P+Pr2bYLlgCHNjueJjQiAeb92svLreqntXUMCOFbcS?=
 =?us-ascii?Q?wAF9SKoVq/2f3v7Ueua6ZRHHTuk9il8L6iWqdhLpEMAef+07Kk9FhsYoBjVf?=
 =?us-ascii?Q?CL1/MURd7NhqZ9PFSvrArb3CirNDYUqh/gTRg4A2vvHN7jPMzhLViNZUHoER?=
 =?us-ascii?Q?m1UpdFYZICA5owdDewF1DyWAbbFlElae3EaT0wFpLoWau4tthrcEdhr70pCN?=
 =?us-ascii?Q?lFHJZYlhGD5osrgmS9L+XyddJNcJ2Xlu6zlAQhk0FPeYTbtSF/hVg7bB5H6b?=
 =?us-ascii?Q?Uf2cEaMsBI2NniMM4RxzfjQWSm8+y4cwXkM+3JHFxca7oe+FbVaGL7FJrped?=
 =?us-ascii?Q?lL6Qc/7VeGAQ6n98yiqW+9HdAE+wXj4MLyyEGynbDGvKYE1SXZXHCfBjayN+?=
 =?us-ascii?Q?2ssAb9qMEXxXdHkiucClSjfbDKrexIDnkcYMF6zmi6kCqSir0VOXUJwerJ1y?=
 =?us-ascii?Q?255k7uwPH2DTWyiKzj0ZG1kLwSSKk0CDRl4kQcLLFsFYpfMqIzY5s9fwWjAq?=
 =?us-ascii?Q?XDCjUmwjF9QqgyT+rWHsvt9DbLTelEqM/PL5sfWg8I3XCgZDZMzmLD9Rc4bQ?=
 =?us-ascii?Q?yLWD5Kez3e+nnpQGLrfTwT9cvdYdzVpX/0sYR3eVkY6Gpkgv/aVQY2RTuYtA?=
 =?us-ascii?Q?Fc0W3XmKM5JOHwfLqqNVKmt1dme89S51frYl3VcfCe4JywFntEoEWeEYTEev?=
 =?us-ascii?Q?7JPNcT49eDcp/YbDF8p8Ho/qdcpLZKp+NEkFbpSS21B7gF99IbJQd0KN7MiM?=
 =?us-ascii?Q?LU6Ywe97LjpT4EL1i0EiH4XFpko+0FLmZDO7T3toJbIRoVPgd9iVTd+wABvL?=
 =?us-ascii?Q?k+Ie1Y2YvsxdHROaQUQdpDs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3f66cf-f810-4cc1-e826-08dd629eed24
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7491.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:21:28.1403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG0KuecOLHxcN4iJN9AQjziIdr8GObDJip9ypCT4ge5FZ9NEcd+5OgvVVdaH1u+v1gMxqFyjGPR/yasjZO+0qsy/Inwc5sW9W7KLHCKSdMSKW4sdu2YsHBfSqmYwRev7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

Introducing additional flag to check whether an FPGA driver is able to
load a particular FPGA bitstream image.

Generally, flag variable is used to enable or disable certain features,
specify additional parameters (such as error handling), or modify how
the function operates.

Hence, in this function flags is an integer that can be used to pass
configuration options to the fpga_load function. Here, it's
initialized to 0, meaning no special options are enabled, but it could
modify the flags to influence the function's behavior.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
---
 drivers/fpga/altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 136ccfc2de4..64fda3a307c 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -70,8 +70,9 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 		       bitstream_type bstype)
 {
 	int ret_val;
+	int flags = 0;

-	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype);
+	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype, flags);

 	/*
 	 * Enable the HPS to FPGA bridges when FPGA load is completed
--
2.25.1

