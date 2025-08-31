Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702B4CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 20:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67ED838AA;
	Sun, 31 Aug 2025 22:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gla18Fqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4931283929; Sun, 31 Aug 2025 22:04:45 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC16283447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 22:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMoFKudv/fEMSH99bnB2racyAVc5hyV4JEOYbBUGb0VXGKAfx4gzubEyLEdR7Dor74eIijZfIMpddT8kjyVNrJj3RLwICkEtjhrVP1nY/gmMAPIiQeMqu4IQYL4cK/n8ZDl4x7dcMwq48/SYrn4Y+yyIPv7SbvNeUdWPiJ4btwrly17CV3clTa5o6pGZPKaXAMvQQMbriHfPEb5Zdwjr2ORO2/+UoB2UjmlQnLvJgFg6IlJmA3J7Q5EExqoCyWISZhbv/daQ7h7kEMmPcKaYrk9671OtM4OsMWp0/B/ly5DpVXS8z7OVgglaC/6WPUdLAlQC7OYdEooVubPRoC9XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uCZBx7+Ku8ivULN6ekAuKqDi4Dm5OKhzhSdUE7sG88=;
 b=h4oYP01KLP5q6vxiGiGp8fN/TCYtqYRmidvwtMS5SuRbFqSKjPyZnXBK5jfQ+eog8lBh4Em9PsJjHZo4UdfBM3ZP7LkjF61JgcNnfu7iVS8dOwhc4kp84S5+OoZNAEH1HF4dugMckUdQaqnpp7O+a8560k5XWmc9qfjiunFilqtbIy/xilESVTFhFuBisLmwQfMB+qeOOFLyRBZvJcdUehB3XHuma2eQ8dkKLpHlQygMQcB3sRjC0OUH2Vrv87hIfc3hUzevdHUPIx7OGg2CvOV+MSGQHwg4U4WhkhxU5628rv4hZR5bI0wt2FPDARDnKu4HLLyg3gD6qi94JYUJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uCZBx7+Ku8ivULN6ekAuKqDi4Dm5OKhzhSdUE7sG88=;
 b=gla18FqkGX9TeMar2/QNcjSNuGRyWKxMMcWSAiXdw2l0Rjindpeo9EcFVwWDhmsB3azSJk4i82zP/7JqDsk1N+RWXPMqGJM3tzCHwGrfdwXxJaTJP9QgXslCCd6kUZPBFnxttrDcod23VfzXX3fs7lKYFUicD8U0c4B9vOVT8Zz9Yj43/KFYMmG9/+AbP8UWkFNF+trimZs5AqDX6ynLkMuLFz5P56rlUd0yKfEU4UpKWGJYRGTRs9T+8JhpxidO7RJGbWe6s+0fV2/MCOUaH8xinWu41KOMtFWVSaw1ZnB5dc6gRjteVE2nFmxB6A8hbZHNlQfs8Y0QU6+0lVURTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10409.eurprd08.prod.outlook.com (2603:10a6:10:52c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 20:04:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 31 Aug 2025
 20:04:39 +0000
Message-ID: <f76bcb4f-22ad-401c-8080-5d172746c3a2@iopsys.eu>
Date: Sun, 31 Aug 2025 23:04:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
 <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
 <68861451.050a0220.a546a.2ace@mx.google.com>
 <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
 <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: acb6569b-a8e5-4a17-a17a-08dde8c99d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWUzVXZGYVdRY09qbEpXbjd0UzNjalpsNjRrUmZyUFB6Mi9WdjB2cnBrY3pU?=
 =?utf-8?B?eW5WWWdma0RySzR5M1dHNzUzeUxnZ3dRNkZ1WGhCR2ZDRGdzNzhQVkttZnFn?=
 =?utf-8?B?UG1rMEkrTUVxeGVHTlZldFpyQkNxcGViTndjWFRuN04wWUVJMDF2eG0za21l?=
 =?utf-8?B?Ykd2anFBT2p3S3FIeHQvL1Q5WG9DNjZKazA1VFJjdVpPL29yV3NzK09CaGwr?=
 =?utf-8?B?UFlvMldGRXo5b1k5Q2ZyWlVwRDJXMUpyeUEvdXNEelZVbW50YmN0SzZRMTVs?=
 =?utf-8?B?ek93UHMvbWYzdC9NSDRhOXdtS0RxTG5mblQ4V0RkOGZZV09tNUluTFBHOUJH?=
 =?utf-8?B?V0VJSEZNSWZtc1JYNC9pYTZMZzhFeHhhMVhhUmwxTkQwNk5uQmk3aG0rT3do?=
 =?utf-8?B?YkMraHJFdjFxeDRlTk1ld1hkb0JwWERwQ1BKb3JYMitLMHJ0UmNWTVhKelV4?=
 =?utf-8?B?dXBub3JMNERwVEdDQmpMbldGYUFmQWNiamVEQ0Y4MnpKZmZ6UjZqWmFJazh2?=
 =?utf-8?B?bFdTbSs2dkh5RlowblU2TXh0KytHclJuYVRPK0JDMGxFbE5kVE1aYnlZVTdj?=
 =?utf-8?B?aDBWVkJIVVhEM2xZMEFCRkVVVVh5VktrYXpNTnZFeXpsYURPREZNUWE5ZTFw?=
 =?utf-8?B?WE03M2pFRDR1ZjFaaWxMN1REMVhESG8xaU1NdmI5bk41UTNSZ1l5TURCL3Ba?=
 =?utf-8?B?b29XbVlBYmZ0MEczQzIzNTB3MFZFSEZVUVR3alBEdjcwNDRMeGhtNlAwYjk0?=
 =?utf-8?B?QTVabFZudlVzOEpzc2l2V0tPNVdTeVZwZFNXMkt6YzZzenpWWUNnbE5hRGhk?=
 =?utf-8?B?YXNhT2VRWHo4QjFHdzlFKy8vd0VJY3RJL3B3NVhmdG9MNllpaHlta1RYa0JL?=
 =?utf-8?B?MmtIZkNKS1lic08vWFlRQUord2lOd1Q4Rnd3enljNE9UME1zaG9Uc2FIRWFG?=
 =?utf-8?B?MXJMUUVDamdRVmczc1NpUW52UkJHektRb2tSZXppY2pwSDJ2dTNIaDBPZnhh?=
 =?utf-8?B?aDA2bkVTNG50eDh0WnplY1MrT2F0NlV2MHY4MHlBc3V3OTNzbTFxYlA4Z0do?=
 =?utf-8?B?bnR0WmFGQ0VhUmlYZGptN2U4cXZsOXhGTTJnVHAvZVFURjZOYVZjS2x2K1JL?=
 =?utf-8?B?VlpORjVRV1Vydndsa1lmQU5DbGk1Z2ZkVjlEbUFCRHdOUzZnQXYwMnJ3QzV1?=
 =?utf-8?B?Wk04VGlMTWdHU0czVFlOVW4wQ3ZBNDU5ZlB6U2xUditraWVIblFjS2JaaFpv?=
 =?utf-8?B?cGsvcGs1UXd5ZjZTWEc2SkZwaXpqVTdOYkpQL1FPcGVVL3hXNnhSeFBJMVd5?=
 =?utf-8?B?OGFBS1hvdmFGSmVoUGFZZTJvd09UZktNOTIxVFFFV0gzQW0vMjIxUVN2cXhF?=
 =?utf-8?B?NTFUWHFXM2gyam9qZWgrbk9GcDQ0WnF1TGpvY1dINGcrUXR4cW1TbU9CclBN?=
 =?utf-8?B?U1NSNVpRdGtxYWZoY2Z3ODc4NDA1eHZhRnZqQzA1cHd1Uk1rS1ljcDB6WkND?=
 =?utf-8?B?OVJyZXJNKyttMlJzTlBTa2U0Qjhzenh0NGVaekFjSUxIbXh4ZlUwdWVrcHRU?=
 =?utf-8?B?SFJlOE9JWFBxZXlkTkN0cnBCVGFNdlc2bVJNQU1HUEF5bVdXVFYzMWJXbkFO?=
 =?utf-8?B?OENna3NzdGM3eHNaZ3IwTFJQQmFna0hCcjNKU2lKKzJPc0QyMWNZc056RXlY?=
 =?utf-8?B?V1JDN0JIRi96aThnM2g2Wmh1bWdMc3YzZVlqZ3RCVWNsZTdNdlZyUHFyMjBJ?=
 =?utf-8?B?eHQxMTljK0JRd1ZYTnhnRkxYN01vOU8wMit6eWxmS2FtYkV3V3kzc3NLVlls?=
 =?utf-8?B?dHU5Vm1WNllubzg0anZSYnpOaWRKLzNqbjd4Y0hEWWprQS8zZm5hUnJSUkF0?=
 =?utf-8?B?UjBKN0xzVWFybnpKZ0ZGb0V3SFZ3bHhKWjhFNVd2d1RiSk4vNFozbE5QazBo?=
 =?utf-8?Q?TLSXhHsmpEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZRYUZ2dSt2SGRQcFJnVVpUejZsKzRlaUJPVUpwdUZKdVU4MFBGcUZYOXgw?=
 =?utf-8?B?TWgrVVMvbTYrL0xrQlU1RkxoSHpsR3BRaUZLamdJUHF1Y3VObDVYbkJUV1dC?=
 =?utf-8?B?eGNqWjNGeGxEUHhNU3pZMUdnNGxyK3FabURpZXRBcXQ2aEZtbXZVYk8wTHpH?=
 =?utf-8?B?YXIvRjEwSjFlcjlZb1oxRHo0QkpYQlVKcm9IdFlNZk5WaW9pcnZxTmVlRVhk?=
 =?utf-8?B?TkUwS1VEa2FTQjRiUGRvTHUwMjFESS8zbTNSNGF1eG1ENWdFZnBsUEFvM08y?=
 =?utf-8?B?OFZXeWowQ0JFNm1tTE9uT24zcDhFd2xBVDBqenhFVVVOOWl1c1JlWjBvZUk1?=
 =?utf-8?B?Z3lkbGh2K0pEdzhmelUzTmYzOGRYUEJha0VMclhISEc3OGdyOEZybDNrdS8y?=
 =?utf-8?B?RzVaMFRzQUhHaG1TeUd1REdpU1Fua05MQWlCcVExMFNKSU85NFh3STB5Qm1o?=
 =?utf-8?B?RTV6L2VUY1loRkhNQ0hZdjNOVWRUZEFjZVZKZG1xRnc5VWtaWW5kUkZOajFF?=
 =?utf-8?B?TEdxcG02SXVlK3FtN2N0VU42U1dQYU9YbzQ1ak1pVkFrS2ZueHoyM3VqbXBq?=
 =?utf-8?B?NGQvZEo2eEJ1UlRBUWFzOC9vOEQ2d2pJMCt2b1BQc2NzL1FxYmMwQ1hpaDVO?=
 =?utf-8?B?Q3FhRDc2TWVzWjdHd0FBcGxJQjF1dm53RmtNTWR2TEZOMTBEZTMzcGY3SzUy?=
 =?utf-8?B?UHNod2Ywb0c3VDN3ejFPZHl6eVdpTlZOODVKd1ZJMDJVRnlIMzl5M0JkRnNq?=
 =?utf-8?B?S2gvQ2o2WDdIOEdPbHRJNTlkcys1a3pVSi9DcEFHTThlZ3lKSjlZRGpsMGk4?=
 =?utf-8?B?QllUdE9ZcS8zM095eGMxS0c0b3dUUkxQSkpyblgzVEFVcTdxZzhHSHdZczVS?=
 =?utf-8?B?L2hwdUNCSFpDOWt5d3ltelc0b1B3L1FUai8wcCtrSmk5alVOb3c2cjZ4ZEEz?=
 =?utf-8?B?aWhKa091RGltMkxadVhBK1pDZE00bkFuYzNiU2V6YXZCT0g0dWpKZG43ZXJZ?=
 =?utf-8?B?dWVURW1MZ01IVk5kZm1QNjJDUWxLQVhubW9pRE9PWHJYcFVXWDdYc21mdlBY?=
 =?utf-8?B?MkJHS3dad2xZRXBTQUNLdmNGbzY5L3VsRzAvZTVUV2REd1dyS1IrZzVjZ0Vw?=
 =?utf-8?B?RHcrUmhzNEFacDdudUZMOHo5S25FS0tMVG1QYTNOUGNYTmZGU3NQbjdqZUJW?=
 =?utf-8?B?TXM1Qk0rQ3owYytWR1lxS2R1bEgxb2ltZFRyalo4RE9NVlRIdm1QTHVJMjIv?=
 =?utf-8?B?UXFldkRoS29vdmFmVnNrU1lCL2VXaldYYTNiTkc5dWxFMXI0REZUaGpTMC9s?=
 =?utf-8?B?djVDd2FtZ1ZIWTlpaVFiakwyOUxTT0tsKzFqcVA1K2JHSDREQWQvVytQVmJ3?=
 =?utf-8?B?ekUrK2VXSnZ5K3ZNNHhKR21PdHJuQmtMNGJiUkRjZlkydy9qbSt2TUxTdFpx?=
 =?utf-8?B?YitXWEJzWXh5ek5US29HelQ0SkRUM1pBVC9wRjdFUmNHQnBNV3JZdVdRY3lI?=
 =?utf-8?B?SDdQcmg2MTh5Zk94YkJMSXJqenhJMFhycXp4V3RkSXhIQkdrRnRMY0F0WXRQ?=
 =?utf-8?B?Y2RCSHVTd3ZXMmkzRHZwTGV3ckF6VUdQT0Y3c2NFVTJJT2JkRGc4TzhJaWRj?=
 =?utf-8?B?SzdwZGM2KzNaRkgzYXFhTFFzYjNlS3FFQkExT2RBamdPQWEzSVlnTWNoQXps?=
 =?utf-8?B?RXdML1VLdWFabFRqR1htUEM4N3EzR0xQUlNTTng3Tk9pbEhCQ0Nibk1wYW94?=
 =?utf-8?B?MjNyc0YxRHZwRUdHK2dwamUyTThkQnpEV3JGUUV6enR5Y1N3cDhBMERlTmho?=
 =?utf-8?B?Z2NlM3NEM1VxbXRoWW5sOTFCTWNvSHN4dmpZYWRJWlFza2JNb1NVSHhLdHJO?=
 =?utf-8?B?bEZwM0JLZjMxREpzaXRHcHlSTnBkREZYQUs3RWRxN0kvMU9QTm55YUNJYit0?=
 =?utf-8?B?QnhiTm1tTjFHcW1XV1hoOFF4Mzk3S2NEK3VsZTdLVFVTMFNCQWJEUi9Pek9M?=
 =?utf-8?B?OVVDVkdpOWNoVXpKSXRpN29LZDU0TEM2TVZtU05xZkh6TWVIczVxNHpLak9n?=
 =?utf-8?B?ek9pQ2JpV2dDUzlHUVNDUFNMTEpqU29UVEFmemNiNVlCSEdOQkg2ZkxoTE8v?=
 =?utf-8?B?YnRqaDUzTWFjZGhRRCtDNW16R3laVmlnWDdtRDJrajV4aSttQ3JQaDlJamRt?=
 =?utf-8?Q?uGyGCUBKFfhCalN7so+AaAc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: acb6569b-a8e5-4a17-a17a-08dde8c99d94
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 20:04:38.8998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6XwTPBTi9mYU98JQ1Oo21fz//DUtEmgSe2X0kkzNcxirj2n9ovpB//rd10zuRTQXHpl4Pajze5VRKf/09u0GOoUJcIcMbQk5obg1w1QhYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10409
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

On 23.08.2025 16:26, Christian Marangi wrote:
> On Sun, Jul 27, 2025 at 03:03:30PM +0300, Mikhail Kshevetskiy wrote:
>> On 27.07.2025 14:58, Christian Marangi wrote:
>>> On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
>>>> On 22.07.2025 21:44, Christian Marangi wrote:
>>>>> There are multiple version of the same reference board with different
>>>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>>>> better support it use the get_ram_size way to scan for the actual RAM
>>>>> size of Airoha SoC and increase the size of the memory map.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
>>>>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>>>> index d149e0ee3c8..0f72365c4ab 100644
>>>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>>>> @@ -2,10 +2,14 @@
>>>>>  
>>>>>  #include <fdtdec.h>
>>>>>  #include <init.h>
>>>>> +#include <linux/sizes.h>
>>>>>  #include <sysreset.h>
>>>>>  #include <asm/armv8/mmu.h>
>>>>> +#include <asm/global_data.h>
>>>>>  #include <asm/system.h>
>>>>>  
>>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>>> +
>>>>>  int print_cpuinfo(void)
>>>>>  {
>>>>>  	printf("CPU:   Airoha AN7581\n");
>>>>> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
>>>>>  
>>>>>  int dram_init(void)
>>>>>  {
>>>>> -	return fdtdec_setup_mem_size_base();
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = fdtdec_setup_mem_size_base();
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>>>> Can we use a memory size passed by airoha trusted firmware instead of
>>>> playing with  get_ram_size()?
>>>>
>>> Hi I received some feedback from Airoha about this and sadly it's not
>>> possible. There are too much version of ATF and only some of them
>>> provide RAM size in some way or another. Also there isn't an exact HW
>>> trap to read to know the RAM size hence raw testing the ram and not
>>> depending externally is the only solution :(
>>>
>>> I will address all the other comments.
>> great.
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  int dram_init_banksize(void)
>>>>>  {
>>>>> -	return fdtdec_setup_memory_banksize();
>>>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>>>> +	gd->bd->bi_dram[0].size = gd->ram_size;
>>>> as I know u-boot can safely use only 2Gb of memory, thus it's better
>>>>
>>>>         #define CFG_MAX_MEM_MAPPED  SZ_2G
>>>>
> Sorry for coming back on this but by declaring CFG_MAX_MEM_MAPPED 
> aren't we limiting the memory to 2gb? Also these info are passed to the
> kernel so we are limiting the RAM also there. Am I wrong?
You might be right. I don't remember where this knowledge could have
come to me from.

I'll read arm documentation and look to a code to study an issue. I hope
I will have enough time for it on Monday-Tuesday.

> Also I notice the weak function dram_init_banksize is exactly the
> current one with the usage of effective ram so I guess I can drop it
> entirely?
looks reasonable.
>
> Can you help me understand the usage of MAX_MEM_MAPPED and confirm this
> doesn't limit the total RAM when loading the kernel? (we don't use ATAGS
> as we use FDT)
will try make it clear for me as well, see above

Mikhail Kshevetskiy
>>>> and replace above line with
>>>>
>>>>         gd->bd->bi_dram[0].size = get_effective_memsize();
>>>>
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  void reset_cpu(void)
>>>>> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
>>>>>  		/* DDR */
>>>>>  		.virt = 0x80000000UL,
>>>>>  		.phys = 0x80000000UL,
>>>>> -		.size = 0x80000000UL,
>>>>> +		.size = 0x200000000ULL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>>>  	}, {
>>>>>  		.virt = 0x00000000UL,
>>>>>  		.phys = 0x00000000UL,
>>>>> -		.size = 0x20000000UL,
>>>>> +		.size = 0x40000000UL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>  			 PTE_BLOCK_NON_SHARE |
>>>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
