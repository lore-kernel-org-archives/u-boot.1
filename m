Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FDCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58B80FA1;
	Tue, 19 Aug 2025 12:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tNE/1TXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8367082998; Tue, 19 Aug 2025 12:47:22 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5005A802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBkDiKwwzyhvkAkou09jkjueizdqYu9qLqPXAMW6NOtADN0rfmUDMH9Q94HPzVT528BWRM/2jze5s+xi8JL3hclR4YQyOPu2yqQbZqCvwjHfJsAvaDMRvMqs2NjSe/yCwBSXt4r4jlKKFDGh4nMmgf8L6nC0XPbFRvSj1mo8NPinBeE2cBAaFYaKJUPUNd7HP9YxXX4pYPncVqKEoEJWjXrWp4ZeoE8b5gkiOYtQywztzpLzE3PdXJk5JN4F3/V8hsZlcge1wxvwyy/tkKoMczLKGAL50QVvzu94v6G2LrOIm6heLoTsQk4qWrCxFvaguBLaMvqQrfG6vhaQ5lxhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFUsNR1vrT0jWXGBQtoKCJm04DTAuDYvKLfpCXnv4Po=;
 b=ujrGAzynG406GTbCLYptfyaWTe0Up/n4drTL3R7YR3rcogH/Ynp8q08mo4ct+ZiSgpywNMt5zC6qELc6RvgHqvxijrvK2p/cpMjPbNINC5gJeSydUXjX1WttC1pK+EFUCnKGUw9nYDD/rXCRg3oKgwGkvI+HQmZY5rsnCOgDsFh4fuLVZedG7a9aIKAUV71ZDYpTL844yhybzG9FXhjoZtqGhvH5QJS1Rq+O80bT1OVroVsk2er9kPWOYEdo3n+hqV7wx5+5BqDXU5cN3O67RwoaRTjDYRmY9HnqaUKd+F6MQm1OeMRZoTjJkCu7vuyfUaljxT42dpT5Jl+g6ZyIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFUsNR1vrT0jWXGBQtoKCJm04DTAuDYvKLfpCXnv4Po=;
 b=tNE/1TXkuYm9uEMjYhv2VQ6uvDdXdohxvBRIQlen3ipuP+44c32BpzWTw7lCC/RoBNoY+V58eDX0fxUHi7EP/P69E+FfgoFuY7SuJATlPky304PaeoVIFKSm44PUX9UbJZT99oUpxBuuGErm9Q+vw3PLsdkiRTjM85z3RzhUGpHikQeR8KUEjGAgcw+XuCxj/I4kzZq7baDv7zcJUxZVzZOk0BSJQ2tnmE5am3rYczS2Joiz59qRabYsrtPYlObM7U4x9dzYFew/ohIwA8glsII0vOb28yBD/kb6A5E3L4Arqy9YZLAjYd0mNoE8Y5Ts5o0gHSjefINgHX4xOUfU5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9894.eurprd08.prod.outlook.com (2603:10a6:20b:5fc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:47:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 10:47:16 +0000
Message-ID: <d7db7457-12e4-4dd8-84a5-581095833add@iopsys.eu>
Date: Tue, 19 Aug 2025 13:47:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
 <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
 <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
 <d2f236a3-b3dc-4949-bd3b-4020a4ba108d@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <d2f236a3-b3dc-4949-bd3b-4020a4ba108d@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd38f88-4833-4a75-0a78-08dddf0dc365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHAydlRXMVRqT1FEVEV5MjZoOTRLS0RqeEw2YmIvS1NQNFZHYUpIbTJaaXFn?=
 =?utf-8?B?U1BrWGNQbjNpU1dORVVaSllta2FiZFk5cWpWbStBaUhia0xKSTFmelowWTBu?=
 =?utf-8?B?ZTVhMmM0SDZlcEdGMkMydTlHVC9Hcis3NjJJNkkzRnk2K0MwY1B1U3N1OGhm?=
 =?utf-8?B?RUpRVUZRMVkvYjJoYi9CWHJqNWs0YXBQY0NkZURLN21ZS2xRR0xuN01jcGdU?=
 =?utf-8?B?ZXNGbTZJOHNVU2NaTkFzcWsva3JGdnpKSnZHZnhaWW4zOVlJUmhtU1FZMzFk?=
 =?utf-8?B?ei9ucWo5ZVZuTHZ5Z1BQYzBhRTNYU2xjZ0pYSFVyTFBpMCtnQ1EySlFGWm1W?=
 =?utf-8?B?cTVaU2U3WHB2aXJUbHpMOTEwc0VDWlY2Y2ZOZ2hjOVQ1SVdPT21kMk9VZEtF?=
 =?utf-8?B?a20xQnR0YjlGVHZqZDlGdklJbWJ5SlNscU13aHBuSVhWSFdUSGdJdUd4L05s?=
 =?utf-8?B?UW52K3NoOHpMdityZFl6SFp6QW10eTJ2S1JLbmp6djhEMzBnWldRUm1LcU5z?=
 =?utf-8?B?MkdGenVuWm96Yk1RbFp3d2szOG9XS0pqc1B6eTFZQW5wVFRuZkVFUFZlTUsz?=
 =?utf-8?B?eDBZUklHYjVyMlBCVEIrUGxTV3gxZkJMQnB0VnNYYkt3Y0hiVFFiUnVCSjl5?=
 =?utf-8?B?bE9pUjdjdGVqeU1SWDlTS25NeVhnd2J5a3NtYm9kOHg4Q2lBS3pIRmdVUlhK?=
 =?utf-8?B?UDhISm9xQVY4THRPUVhjSXJWOEY1QUJPYnJOWGNLdncrRmF3OEFMSmpkdXBl?=
 =?utf-8?B?T2wvd2QycWw4cVNyZ0syOFdORUw5YXd0QVFVSFhOODMxOHNuSXNldUZ0MlRj?=
 =?utf-8?B?VGw5bHEycnh1b0dDS3BJZ1JhSHB1NkIyMjhDV0trT3ROV3RSZENWTmNJN20y?=
 =?utf-8?B?dEdmckFIOGU5NnJYdThRRjZWbUExL3ZOQjMvTE1ETVVrRHk5THRGVmQ4V3Bi?=
 =?utf-8?B?aHN1OFJHZk9Va0t0cTJ0SEd6djF3NFV2bEM3SjFhUWpZeDdiV3JueVVlQnZY?=
 =?utf-8?B?SlptS2VrSS93N2xsQ29aR2JhSUNhS2NmaEMwSFJxYUF4akRUOWR0VnFQOGF1?=
 =?utf-8?B?dHFFdjZjRittaVEzbXo0R0Yrc3hNMGxyQUp0RkNhUnJsc3BPZ0I2M2t5ZklG?=
 =?utf-8?B?c05UK2wxYWw0eW0vaTZHUDh1Zkp4T1kxMXNFZ1J5eENtK1c5ejc0TzNBQzZ4?=
 =?utf-8?B?M2l1ZjJ3TUY0T1RJZVRpeHc5WjFFSHdILzVQbEtUR3VFWWJDaU44cTVRZHFu?=
 =?utf-8?B?bUpLaWVKMXZ6SnQwQTd3NzQ2UUwvS01GdExVUllCWlM4Q2xqQmZMTmtPMzcr?=
 =?utf-8?B?dHV6T0lyeXk0UENZYktWSS9UU1lhOHdxM1JrUC90ZjJ4TFV1akVpV3ZzVUlx?=
 =?utf-8?B?dVJEZlhaOTBSSVlDdzF5aEJEcWU1Qk5VWEdQWG53MElFbURZSXN4M2U1UjN4?=
 =?utf-8?B?SlpQY1cwcExnSCtkYnQvclRwVTdWczlmZUw1UGcrcDFVOEFhQUVaNTRab01i?=
 =?utf-8?B?ME8rMnJJbnMxb0FqVi9ORnNSb09NaWFJalpZenZaaFU2dVR2MnVkb2I5aHU0?=
 =?utf-8?B?a2UvN2ExOFF0TTM1TnlQL0V2MXJXRG05bVlIczc3M2RJVDkyTi9ybWNYNk8v?=
 =?utf-8?B?dU8zR2xheUVOYjNYa1luQ0tQQnUzUk9RUDhLZHo0S1pDVnNiVEx5YXZjWXc5?=
 =?utf-8?B?UlN4eTg5QUlJdlNORUtXVTlBcDA1T1UycFB3M2VGZEJ5cHNyTU1KUGNqdERj?=
 =?utf-8?B?T0hSS1hWTFc5WHFETXo1TkFQa0FWaTc5MzVnNWJHbUZVU1YrTmVtNk42dWpO?=
 =?utf-8?B?N25NZEt1NlNDczdRdk1Pd1liakxDUDRGZ043VGFXcC9EcEl2dUFXay9MTXl5?=
 =?utf-8?B?STV1WmFGR21kelV5dnc4U1YwQzBtdUtIaFprbkdMRHpsTWJUaXloMFpJN0ZQ?=
 =?utf-8?B?cisxQVd1N2hqaGYwbkI5YTJRcmdkS1V2SUpqQ29IVzd4ODE1SUxRVWJoczkx?=
 =?utf-8?B?TTIvRnJKOGNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RsMW5ST0paNDh0clJBWlhlL0dnNkR5YkNXeXI5VmVuQjB6cEo5TGtNdEdl?=
 =?utf-8?B?SGFNVGxDSEtLeXRhSFVoUVBSWnljRHFMdGgxZm9MWnhoZDhkUnpoVlREZXlW?=
 =?utf-8?B?YlhRdmY5LzRpRDFySXlLUWFHeWYvZzM3TFB4Q202a3FsRnliZ2JQL1J6ellt?=
 =?utf-8?B?WXl5QUEzZ2FIRloxUTNHYklOOTVtMzJnMG5Wbzgvcldad2NMT0pFNzFJcnRv?=
 =?utf-8?B?RS9FMEtGZFN3VFhZam5vdnp1NzVMRmJDVlF0ZzBSdnJQSEc0WXNxRVRNNmpX?=
 =?utf-8?B?M2k3THhLeUUxU0JXSzExMm05dTJOaThiRGNuVVhGZjNsYWQwMXdXK0NHSDBJ?=
 =?utf-8?B?YVpoTjhORFQrZ0UrM0NPM1p3cERycnRWZ0FLOE1BMkliV1dpa0hmd0JZLzhI?=
 =?utf-8?B?dThmdjRmamxwWE1yUG4wRHhldUFPeXd5Y1YrZk02eHpURVdOeUlEdkZSWmlB?=
 =?utf-8?B?aXFhVWF4Wno4R3doTlFLZDhmWjZiTm9Cb2JhL0hGUlpMU1I2bVNXeWNFWWFB?=
 =?utf-8?B?NndwVlErZnhLK2xuQmU2YzhLTVIzYkduUEEycStxNVJIVWIvNEpmUnR1d2pW?=
 =?utf-8?B?dCtFazRZMVFBaGt6TkFhZWNmUVMyVkRnYU9uOVFNSzNaSDJ5ajY4RHk1cWty?=
 =?utf-8?B?VWdobUZqREl5dzVobzBGQmdqYTh3MXJ5RzRWRXpWRW50dUZXdlNiY2VoNnRW?=
 =?utf-8?B?bHlhbU5DVzVBTTArdTBKcUJ2VzY5Z25namtXMVI5NjBIZ1RpZ1orWEJGRURF?=
 =?utf-8?B?bVpIdzArVmpISSszTUV2QjZRcmE0WXg2MWZrUTJ0RjNnZ0FncVlrSVZPNWpp?=
 =?utf-8?B?VjhYdHh2a21QbFFKYzFxTnRCKzdaT3o2NVJFNHQ1UVQ0ekpYU3FSTHZVUytx?=
 =?utf-8?B?OUF4OHZyK3BhQ0xueHdDd3UxM2NqYmJFUDVGRXpiZk9lelR0S1ZmQ0l6Y1dV?=
 =?utf-8?B?dWFISTRkWVR0NTgzaklrNFcrWUNHWHZuRGlBWVJEK2NWRXMwY0tISERGQkw5?=
 =?utf-8?B?RU5ScTFpM0F5WTM4S24zTnJwUG5qY3VGTjg0WjF2dDl1REtMcWtaT2lnUXp2?=
 =?utf-8?B?c3BDa2FoMjRoU3BJL0Z6aHBSNG5xNVdhMzV0QXdUVWxLalZ2Tk1SUnkxRlp5?=
 =?utf-8?B?T3JUelZGcm5maFMrdzdmVWVtamNpV1RSWEVrdzJLY2tiQUJGdUc4dEFlM3pr?=
 =?utf-8?B?dVB4ZElsdlZLMHNzNWJTTHJ5a3lwRGhmaW5NTGNucXozMTlkSnlrNFdtYmJv?=
 =?utf-8?B?N1VqaHlMQmdFdFY5T3NkMnM0VUhMZUVyQUdjUVM3YW1OMkkreC8veWtIM0d5?=
 =?utf-8?B?dlQydUxsL1o1RzVCWEhMNEVsYVBJNmFCVWVXR3Vld0l5dnBQZjEvZzRRbTFy?=
 =?utf-8?B?amdMbWhIVHBuUllqVXRtVi92SWlIQzA3aFAzNjVnRHV2RzN6NXdnL0VEWjMx?=
 =?utf-8?B?MHpoY3BCWnFIdjBaUmpvUlY0VlFldUFGdFNZenRsakhqUkNxdnc3Rmh0MEtJ?=
 =?utf-8?B?M0pQVGsrSUt5RUxFVXBraXBzcExhQ291MXhtM2RqNGllRlN2c3dmRkNWdUxF?=
 =?utf-8?B?eXpJcXBLbUtnditxQTlCODY4V01jZnVZM0p5SE8waHVCNVo5WURvKzJQRS91?=
 =?utf-8?B?UDBvZk5SQVRTYk5wWUZzRHM1VFJBOUJYakZyRDB2dXNJOTU4SCtnVEZENlUx?=
 =?utf-8?B?enJHdi82YkJaTFR3ZXluZGhJSHVCUGcvdVdHaXd5RG5icGhKaThuMGR5b1ZH?=
 =?utf-8?B?WEQrOC9ZVmluSVdYbCtDVHRKMW5GdXNNTDVkYXQvYjhNTGZ5bXEzMDdtQXBn?=
 =?utf-8?B?MkRPSjlnRk9YOTk5NVR1S0VUZDkxcGFzRGloZTBJeVlPdlQ3YTNtN0UvWWlS?=
 =?utf-8?B?ZTJYeFBDSC9ObTF1ZGszMEhkL0k3RUpBQk8vQVN5V3c0K1dQbk9JREFWVHVE?=
 =?utf-8?B?THJoZHNSTVpkc1VQOFZ5cXlFQ2F3TTIwY2t6d1A2MUZmUWlKbjdmQklqTjR2?=
 =?utf-8?B?N0FPNGJmSnFYMXBWQ1ZiRldBQnVRQ3luRHJFNWUvWHlxbEZJam1vTVJ5M2hB?=
 =?utf-8?B?WmNSY2dVcmt5VU9RSVBPMDdncDRQSFY0a0pHSFdrRGQrSG0wM1VFNVNMYWNo?=
 =?utf-8?B?d0JUWUlDOFNoZ2ZmWjRKRDlKemxWdDJlRERIdUJTWVZycUpIQithUDlteGc3?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd38f88-4833-4a75-0a78-08dddf0dc365
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:47:16.3705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVdqeSk6ZoUDYw3/eo0Y+8n+1z/QzEmE+dfbHRyNUFzTEw6KSKTtOLeYswGGDg7faxMNBdO+5ZPW6GvdokbLPZ8EFHE/qeFWRAK9aAU043Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9894
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


On 19.08.2025 13:42, Frieder Schrempf wrote:
> Am 19.08.25 um 12:34 schrieb Mikhail Kshevetskiy:
>> On 19.08.2025 10:26, Frieder Schrempf wrote:
>>> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>>>> From: Gabor Juhos <j4g8y7@gmail.com>
>>>>
>>>> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
>>>> logic") the spinand_write_page() function ignores the errors returned
>>>> by spinand_wait(). Change the code to propagate those up to the stack
>>>> as it was done before the offending change.
>>>>
>>>> This is a port of linux commit
>>>> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
>>>>
>>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
>>> This seems to be a fix for a change that was introduced in patch 10 of
>>> this series. We should avoid introducing regressions and fixing them in
>>> a later patch to preserve bisectability.
>> Hm, this a bit contradict with removing fixes for continuous mode. In
>> linux, continuous mode makes some flashes (mostly macronix) almost
>> unusable on some platforms.
> Sorry, I don't understand how this is related to the continuous mode
> fixes. I'm just asking to squash patch 19 of this series into patch 10
> so the changes of patch 19 are included in patch 10 in order to make
> this a single consistent change.
you write: We should avoid introducing regressions and fixing them in a
later patch to preserve bisectability.
Continuous mode introduce regressions (see:
https://lkml.org/lkml/2025/8/14/349). My patches fixes this regressions,
but it still not accepted to upstream linux.
>
>> There are 2 possible bug scenarios
>> 1) "continuous mode" flash and spi controller without dirmap support,
>> but with restriction on transfer length in adjust_op_size()
>> 2) "continuous mode" flash and spi controller with dirmap support for a
>> single flash page
>>
>> In the first case all reading above restriction in  adjust_op_size()
>> will lead to EIO error
>> In the second case all reading above flash page size will lead to EIO
>> error or spinand driver fooling (because spi driver returns wrong number
>> of bytes was read).
>>
>> The second case looks as less critical, because u-boot up to this patch
>> series have no spinand dirmap support, so no one need to support dirmap
>> in the corresponding spi controllers.
>>
>>> Can you please fold this change into patch 10?
>>>
>>>> ---
>>>>  drivers/mtd/nand/spi/core.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>>> index daf6efb87d8..3e21a06dd0f 100644
>>>> --- a/drivers/mtd/nand/spi/core.c
>>>> +++ b/drivers/mtd/nand/spi/core.c
>>>> @@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
>>>>  			   SPINAND_WRITE_INITIAL_DELAY_US,
>>>>  			   SPINAND_WRITE_POLL_DELAY_US,
>>>>  			   &status);
>>>> -	if (!ret && (status & STATUS_PROG_FAILED))
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (status & STATUS_PROG_FAILED)
>>>>  		return -EIO;
>>>>  
>>>>  	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
