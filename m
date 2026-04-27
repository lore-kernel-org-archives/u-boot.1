Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F2FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66ED84178;
	Mon, 27 Apr 2026 18:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GiKyFkAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0DA841DF; Mon, 27 Apr 2026 18:54:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB2D8416F
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVJiVQq4z0tcl+CL2NVM8DYtQVHQ55V9qp/MzqNAMBkCj+sHwDdni8FnC9rldE/ZeLTjSKr/DRf5BTLqAmksIZiwU/wjfpxpwaVv6Yb8KGP2pSiI/ioFFcoZm6eAsJo5wc6LkI33JQyl7livV5l/GUbWg8xBXMfBCM2G0yuV+Kxvs0HYc/jt1JUU5hQxqnpQN0gFQ15nmJOs56sBfsOdOGhQzdQGuCTCxDF3v7HdBcpMImySQo7wYoKU7eFMe9W0fAILyo8TfL3mSRfgyVGLKEHToy7k3ZI/7PD3qXZP1rCprIA1UZ0LcLDp1XTnF/X/MhhMJ48/fXnbxe0vf9kUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp7yBL829GO5nZ1k+ERKTikYgOHK/hrPPgNg3rspALE=;
 b=d8HzkTo12B1h0QSrrJNZBXCl7Fl2PazrR6K7bm0R6PPcTHs/3c3pzY17MB6VzHfZ0nka8J90cg+Jr54rvsCnT1SUfhqtEvAYJJtClWs0MBf9Nje/n4OEPaIBxW4E+GBeGt4VsYeFkkRUANvNmZpJ/pjThP8q2RO/LUR8HdPO4koc9PIwpmqRqm4WmQ9WGlRikSRoLCC8EeJjjU3+2sBXYuhVFa11LSwWWXDBtvolKU7O/nBeh9hJtL6rCJaVuo1Y/DYL5O9sTP51ehl8H09gg+Jsnx2bn0TxYR+pYqezrIW+DYF/+Oi0RbYF/alVzyw7atG765jL2GqS0qSHvfEDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp7yBL829GO5nZ1k+ERKTikYgOHK/hrPPgNg3rspALE=;
 b=GiKyFkAqru1jthBV2mZUGc9SD42H0dGdsMy9bFmK8OC/e+PwUyfCfAAFr0zPVudEVMOOz699EskKbMLdTsTt+gVeBeF65ShZy+ne9la6cDOJ2s/gJqyahHi3GgYQLbhZ8mNBa/zePHHvgz53gBfGf9r8j18sD6KZy337prZ1Dc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:54:52 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 16:54:52 +0000
Message-ID: <dd20d673-2d8d-4d12-896b-d36c422325ce@cherry.de>
Date: Mon, 27 Apr 2026 18:54:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: .clang-format description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia
 <floss@jetm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
References: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM0PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a344e-2541-40aa-6fab-08dea47db28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: G9y8I6wmkVkI6IJPuppmsLlmJoMRST7/1cOEqItGXMY7t/jupEG6RgvvVSTPluRUwU8WyqORRzq0QVdO8aAngGoKM7dDVGeHLlmMeSVzsrqLlO2XpP+1Zu9LOMu8lURP8uWl44eCPmmBwH0iUUNf5WFEiW6VV75GgSbXrH4CZ5h+NbcfiOtD1xZDMLxRY79AU1KrzY95eDLKDRFg1pn0dg636WlF2o1GUE21ZhRZQ4XmkOqY9RSdmXYAP7O1c9FgIOCxapimHasZJNm8Co+OPoVyRkJEvLUVjdrG2fYtNX1XcBfYeizcEfofbxR4iK7iiLZh9ALwXZkh1IBj+ZmYPePevEYn8AbQSBqy4ggP/4wMjszpNnmJEBKJaHZ9IDSbCOBLIyZ3WmaDRfZVLrYWEufwobOOG688r5fUVRJc2Ysx3ucxr3QfnX3favICudU793d5Q7khlt2YEvmCMQNi+ynr1knH1Xp2Qwc6Ckg6ERVV92ijB3Wv5yNGldavv2KYkJZTajf0JFu4C58cWzfd7tKT5mApTXvVGe2OkYGC0e0Fd05hfLAITt6yRBPBDPKuGfl/QNIKwnMsrzGXO/0SHSmr2vj1B5tn98eidjOX+sR7sc0danIg1MgG3RKkjwBZDiPXJxWXQnycQz9eWTrklcciyRvxLAy9fwKxdBYG+dNTpf/6f/8sUauOTenEm+a0f9bqNhQDyLp1efgzVfkFqwZgAV1YAUl2eYVBOZooBlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFR5aENKY1Y4T2R1Tis3ZDJDTmFwVnltdFpaakZHSHFOcHh1MDNFRUlHTE52?=
 =?utf-8?B?S215Z2xaY3V0aVg5cUJ1N3hnMVM2QXV6QitFK01jQnVNOHFzeCtoV3YvY0pw?=
 =?utf-8?B?SFlrWHoza2hpcG1VQm1obG8wMEZmYjVjTmdBOS9JY2JIeXozNEJLb0lycnRG?=
 =?utf-8?B?UGdnZnQvSFRqVzV0UW5HNUhISEsxVlQvdTMxeXMzTmFiUWxmYXhjYm9kSThq?=
 =?utf-8?B?aEk2TXVRNWtaTjhnQ2dSSU8xUStncFNyN1pnTnVrZ0pUVDVDTEc1SmtpZ0pS?=
 =?utf-8?B?YmpRL25NTmNSZVBKZUxQWmh1aEkzd2ViVG9JMVlJN0lFb01IL2hxTVk4Tm51?=
 =?utf-8?B?ZEljNUpzZ3hheFhja2xQWWxuaHB0WnpGV2JEcDJOcTMyYzY2WWtxOHZEd0d2?=
 =?utf-8?B?TEpKajFINU84QmVNcVdid0xSb0ptai92YjZIa3pkdHNLOHFqZjYvanVQMlQ3?=
 =?utf-8?B?c3JROEtnQVg3ZHMxSm1obmxMRnpLRUxpL2ljNzR2YWxKWmFBem5qcHRjZkU2?=
 =?utf-8?B?and1MnNjaXppWjl5U0pGaUZWdzFibkJPRmxiL0wrN0tEY1RoTTV4aHo2dFMz?=
 =?utf-8?B?ZGo5OXFiQjF1TFh0OEU5NDZFTUZidFpsdVJWZGpXYnJaNys0anR5aGk3cGhj?=
 =?utf-8?B?MmFEYytqQWgyU0J6MzVnREhxeGoyMTVNT3YvUDJiS1lYejVVa2drSDVMa0Jv?=
 =?utf-8?B?dmF3L2tOeTMzOWFTQzlpRm5yRGRncDFqZzM1ZmM1ZFFpTEJ0c3NJdDl5MVl0?=
 =?utf-8?B?a1pQakptbjY2ckJRQnc0bGpMa0k2VzFGZ2VDTlQ3RUdpajFwNUE2V3NyZnJM?=
 =?utf-8?B?bVJZTUh2TGZyOHhFdmdyK0ZWWE1lazVzdjBuRGRoTDFzcWswVFpzMEY2bzhs?=
 =?utf-8?B?djRnZHJ5MUk1czZCSnE5bEV3bm41SDNxMDJYNVdpd0dSNnBKVDJERENnVzB4?=
 =?utf-8?B?ZWx2bDFVaGJaNEVTcVdIYmE0WnJsOXY3bmtVbnorVTdTR3Boa1dtMDBRblVv?=
 =?utf-8?B?ZnN1MVFPbFVNWFJDb3BqdlI0RWJ1Z3VpTTdUTXFlQ3Z2VENrMHE0K0crT2Zr?=
 =?utf-8?B?UmRQZFI1RHNVdnF1ZmowN1ZaVVp0b3htc0ZBZ2NoeFMvdy9TTFZzVmNSZnJq?=
 =?utf-8?B?NW9EdFppWXdZRGlRUG9GbUFHMklPMzYwa21WYUJVWnF3cEdxUVo2bzhTdDln?=
 =?utf-8?B?N29YSmJYa3RKUkFlb2wvbkovQ1U2LzNYeDdXNzRLTTRuU1hpNGhkdkZ6VWsx?=
 =?utf-8?B?c2VjazdSeWF6ZURXcnczTEZJQ21DUGZuRXdaZ284LzNqRW9vT21lNzl2MTl4?=
 =?utf-8?B?a3lGZVdzMk5Udm9zY0RjVVdQbVlCSkdvbVRWU1pzeUtSRUdEU1RQNGlBVlVr?=
 =?utf-8?B?YWVydk9kNTd4bEpHVXd5QUVxVitUNTk0ajRmUlFudm9UVDNHWlVpUm85TU1W?=
 =?utf-8?B?a1dOYVlPMlpKSUZQcll0V3QvZmRqRzl4cWJXOXRjcXBEQWRZallOWWV5Z0dC?=
 =?utf-8?B?UUlkYWNMM29yRE1FbXF2Rmx3Vi9sMkNYK3FGZXRWdWZoZ3o5Z2lzUjdKdGJz?=
 =?utf-8?B?aDE4dFd2YS9FeHlYV1ZvODNuUjA2T3I2M3Rla1RVTEdqREx6TWdqWHlpRXRq?=
 =?utf-8?B?MnpIZFhMRWZJK3BqYWFoSnc3eGk2ZWlXVldic0hZWlJXbjFjVnJSVVluYXE0?=
 =?utf-8?B?MXREeDJVTFA0UDMyQ296dE5JeVRuVnRnaXlzTCtCUE9YcVgrd2JXaXBUVjly?=
 =?utf-8?B?MzJmOEhpaW42OTZwK0Z4MGhoTXNEWmo0OVpNalJjSld0STJWWm5uUjB4NmI1?=
 =?utf-8?B?Tlc4RXJOQ0VhNjk1WlVQcWh0NUFqdkZzamtxNmpyMjZ1dnZ0YkF6ejF4WGdr?=
 =?utf-8?B?UGx0ejhvMmw0eisrcnZJaVFTK0tBdXRZYm5KRU9BSjdaWWI4eTJaaWlobllK?=
 =?utf-8?B?em9RZEE1aWN3MnJpV3c2VUpqQWVUN25qWms1MldTZjN5Tkh0UmRGb2haRnhK?=
 =?utf-8?B?UkM5eTR1UDZwZ0RDVVQ2R0tqR0xXNEthR0JXS3ZIeGthL0pTbXladXAyRnBI?=
 =?utf-8?B?VlVvclc1M29WQW9tZ0FqdW1YaWE2OE9McVJINFhhV0Q3dlphOXFCb2ZVL081?=
 =?utf-8?B?WDhjcFF1RDBOWHMrRktsQVdEcHErZHRWOGxKWWJLT3dCTUJjSHc0UXJsTjR0?=
 =?utf-8?B?TlpFbDA4UElXRnAvdGh2VDZlZDJ4WFlIbFBJWkkyNzdTQlFUeXRkWkdjTHpB?=
 =?utf-8?B?cS8wQUxLb2pvRHpSN21FcG4za2NCQkptSEdlbGZXaWVwbGtoV1M1REMxcTBK?=
 =?utf-8?B?YnYrMlRiQ0pCUks3QTlVcjFDcUsxZ3lWd2dGbWx1VVBCRjlhb3RGZ1hFM2VV?=
 =?utf-8?Q?yLCeRJP4kbZTitTv1lCrEIgPBn3ExgEbEUr8L?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a344e-2541-40aa-6fab-08dea47db28b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:54:52.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCwv7waZeM6/5LvnFWFQcPCImz+iK6A5hM40YJ3zkNKVF7nv1yUaz3ihOKdJfnYL3S3PH1d905O8pFERss+elSnKpj/rPRWfPKR7yvzkh2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978
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

Hi Heinrich,

On 4/24/26 3:05 PM, Heinrich Schuchardt wrote:
> We cannot use .clang-format without modification. For instance U-Boot
> has some for each macros that Linux does not have.
> 
> Adjust the description.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
