Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454EFE9E30A
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEEC83D71;
	Wed, 11 Feb 2026 14:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lxsR8iQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40FB83E1E; Wed, 11 Feb 2026 08:21:50 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB558367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSKGGsF3mPCO7llMUmjHiPJqlBC8cH1fSTLj2C4AU4gkdyALQielAcN3M9378J7aJOXJdzoz18qN3J3P7HHhmQ32YsGAkFKdQ8jI+/+KijRg+ldG289Xfl9DQBV/SR3pHaQ0qUT5D2lafIUbfQbU6jzMEcfSkSQhWEQ2d2bJgxvq0wAL0DI67cvQMHAbpf7VhAVYDJTlb1Qnm8qR9D5MXEH1Wg2mMJXbzvhCOSzWz5g1PGSzMb3TxHXlHrp7HMhRVt2M7N8r0fE3kK8Nc9OXavTpA+qthsSj35t+ANdvhFhFNQZqaanh7HzQyOFT3DC+RimE8L8N34j3krdOGTo/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACcEtb0GiiCHq62LEbtSUd2LoqsRbPFW33wLuR378To=;
 b=YwAhlfPzWh79eM8Nj3at6Yi8AXDjDDc+Viha/fOaQuqsWoyMKCYTGkB7wUvisvk4TQGZ6lBQOrtbob2RY59oXJHG6FTQIN911Fo1h6dQIHuwYtUvxqEn7wSTTplJsbp8UYyonTqmeckt9XEv3BzYGdZj9YIqT47+4qbDIlJ/xPHgW1nQljqMfXeXdoqnSq/uMeN+1FcpgbEBmg6RkxWNLcuoX2vhN1G7tYszFl5xHSVxbZBBCDjnfFHP/ugdp0kPdLUWfs5rDTXH6dT0jeJchClOZh/G5hjWfGE5qJ/FDjIT9mgSYHZEXitOClyTC308pjYz62xBTZZ6XVI9a24wVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACcEtb0GiiCHq62LEbtSUd2LoqsRbPFW33wLuR378To=;
 b=lxsR8iQU1LwP5m9nLBmr27sXD+tzjxaGDLn96itMmlu69rViwjR7lfu5oYStMnWQfj+ShOVVsJ9/U4xshu4mhwKt6qKW6iu2Vos7r6gLFf6v1GB4A/UI+GjOUb8SFquI8yOrWpGy7UhzYOHtXddUD8yELLbHSUGXBIBY4K7iYtnYvauxOQU0npy+Hioy0c1VNQKeAFoyKIk6vvy36jmMAB10lfNEEzsdhNbB9aU8G2gnosAmE41jFz+R7e8qp0ejTl5tL8tH96rGJ9F1sbel3f45lf1mJKkJmd8o7oNgKblaDOVlKf/4ThMzkOBwaOZWVNz86iNyq19jEuHo0s42jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB6627.namprd03.prod.outlook.com (2603:10b6:806:1ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 11 Feb
 2026 07:21:45 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:21:45 +0000
Message-ID: <ed6bafef-7ae9-4920-86ea-79a6e8eaa7ff@altera.com>
Date: Wed, 11 Feb 2026 15:21:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mtd: nand: add generic SPL NAND MTD loader
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-3-dinesh.maniyam@altera.com>
 <20260203145750.GI2603314@bill-the-cat>
 <CAOf5uwktpTzTqASRGXs+vsgfR=3TXUvZTX0pFDMW=AuZ9vgCZQ@mail.gmail.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <CAOf5uwktpTzTqASRGXs+vsgfR=3TXUvZTX0pFDMW=AuZ9vgCZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:820:c::10) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: f92e2c49-6336-456d-0794-08de693e35d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2tRaVF5elphc0ozVHFGTjg3aXZPc0JoUE1UY2hhZFZ4T0hITzQrYUlQaU9Y?=
 =?utf-8?B?c0hJQ2pzSC9wcThBMy96dDJRMXZuUXR5NTJ3UG5taHhoTUVBdTIzTkUwMG9w?=
 =?utf-8?B?bDBYOHA5MlNEQnd2UzNuelJzV2xmSVE4Qk5ud2g2R2lPQ0NUbFhvOExxanBM?=
 =?utf-8?B?U0lkMmFrdExyak9wbmtZTGdkMHVnQ205ZDRrQ1BQYUNNWHNzNDMvNDRaQmJQ?=
 =?utf-8?B?NEdSV1Mrb2hlSFRpSXphb2lkZ1RUSnlvLzd4WFBLQm5VaEZmOEh3VTF1bjE1?=
 =?utf-8?B?cjNtY0tOVHc2ck0reVVKd2pKSDA2RkliQ2lwenIxZklYR0RMQzRQTTU0R3dm?=
 =?utf-8?B?cUJoRTRoQkUxcDViZTRHMkRHZ1NLckNZK0hXdlRxT0VGM0VsdUdxeVJzeUdu?=
 =?utf-8?B?SmMra1N6bmQ4YXRQc0JDNEtuV05LTXVkMnc1aHowRjZ0dVhjTEpZbVE4NzNX?=
 =?utf-8?B?S01ncmhNOVF4NmFFaGd5enA5SFNBemNPckVoTitjTkZQWTc1STVyRVlKc3JV?=
 =?utf-8?B?NmdxRXVSNXc5OVVESWJGMlVTRm9HdVg1ak9aNk8wZ09zUWFlRjlSYm51R1dO?=
 =?utf-8?B?VXRyZVd0WDFSZ2syNktVTzRlZ3lHQVo0cks2ZjA0aWNEVHcxTEptS3VEbEY4?=
 =?utf-8?B?M3Z3NzBNZDV0NUJtSUxaYUREN3hGcjJUeVoyNXdtZklSSU42eDU3WXZuWjRV?=
 =?utf-8?B?QUp2UHpGV0hJdzJYM0ZhRmpvY3Fpb0x1ZmMxMW5QSFlzRnptL3dFek1VSzM5?=
 =?utf-8?B?YWJWNnp3SnN6V0RsM091VTA3UnNtK01pNGR3emUvQlpHTXc0T1A2Nmc1SXFa?=
 =?utf-8?B?ZVNhMWtKUXl0Yzk1MnFROFQzMUJ3TTh6SG04ZmRTTFVKQmtsTWNvQUNGODZp?=
 =?utf-8?B?SHQvOWlrcWRhZHVDOEhyeDRjNTJtY1VFNU9MU0dyTmhoRTBXQlpJNDFYWXk5?=
 =?utf-8?B?a2ordGU1aFpwSzBKR2ZwdStmaTk0cnF2MitKS2pBVkkrcVgxUlpSSEF5YWVy?=
 =?utf-8?B?MUllOGgzczAvZkJLVWxIeXZVN0xDbm4zeW5JcjQrcEZ0VmhTU3JMQkRvVHE5?=
 =?utf-8?B?bG5zR0lySVdlMzYvOUVzMXBxbWNKUVNhQ0pETndNdDVGQURNUSsyQXJzRXJz?=
 =?utf-8?B?bW5hb0pKQVNhSmZpb3ZJR0hGR3NlMkpvZ2lhSGsxVHBDNE90TCtQRVV1REVQ?=
 =?utf-8?B?NnBlaGxGalBFaHdWeFNTaTRiWXlCWWRDdHVpVEVYMkl5STZkbjFJS28yVGsw?=
 =?utf-8?B?SkxSM09PalBJQUZvNXpzZWJqcHB5Wi9BQ1ZiMm9kWTBVV2d3d0RZbi8rbndJ?=
 =?utf-8?B?dUxYMXMvVUVZYW9hM25nTXFua2VtTDFkKzJwUG9la3BWNkMrTzZtd2h6L1BV?=
 =?utf-8?B?Vmg1d3NVRUJxRW9HcWl1OWttWEJ0ZndEV21sT0kwOGY5ZEI5aXkrVDVQeS9u?=
 =?utf-8?B?V0dyaTJhNlVPZ0g1Uk9Zc3FMcmVsbTkvTWNsZVlIdXdPR0tUTE5mYzFqTDVZ?=
 =?utf-8?B?aUU2d0xWc1BiMjhWWERVRjhqYkJSWGtvYzdwck52bXZuSi9TbStwN3hnV2hG?=
 =?utf-8?B?UjlZbFhpUjl5SkRWVjBpVnRldWhWRjNINGJrVERMMW56ajhqYnp0d3FNbW5i?=
 =?utf-8?B?cHBYUnhWRXdHTVljUFQwWjhtZ082ajUybElUbDlqWlFwVUdMa3kxMDBwN3gv?=
 =?utf-8?B?cTBTSi9OejdKSCs5K3JyNTVRWlgwYkQvNEZRRDB5dktCdTNDK24yTjlNc1dl?=
 =?utf-8?B?WFNMeUhua2t6c2JpekJoNkUwTHd6Y2ZaOE1EYmFwbkpCS2IxYmxoNkptamdP?=
 =?utf-8?B?UDd0SHdxc2ZXMEQ3cm5PNHoxQlNSV2VuOTNyMkRtcFJFUkRQeGkyWThwSFFD?=
 =?utf-8?B?NkFWdC9lME1yTGZMK3NnSEsrRytFemlLaDRheXp6ckNoR043eTlrakZsUHdj?=
 =?utf-8?B?YlNtTlI4RGRDU2I1ekhWcUl4RnZXSWk1cHRKdkZqaW9tcjBKVWx2WE8xTlJy?=
 =?utf-8?Q?eDjYYzobhdhYZ6fbgU9wrY+ltLglBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRWU1Zhb1RUYTZYeUNGZ2kxNFJXM2R4RmZ2cWtySTdaK1d0c2s3TTBLWFZi?=
 =?utf-8?B?S2duaVVDa2JnYzBmNDV0eFVpbkk0Tll0UFBXZEVuMG1EQ0c3bmJGL3MrSExC?=
 =?utf-8?B?bS9LK0JwdU1BV1FYM0hCSVhXYlQ0NmlONng5WE5oMTZFYjRqVUU5UFNWMXpE?=
 =?utf-8?B?UzllZmdUS3lRcXdUTklJWERCMC9QSzQzTnRxVW5PNzBzdGNTZE9xLzF2b3Ur?=
 =?utf-8?B?OGtGdXoyMFhzUVRQZ3NXQjZVUzNMVXUydEowaU9KTTlCUEprWFJ4UnpZYW9t?=
 =?utf-8?B?ai8zQVcvMUJIK0J0b0JnMUhFaUpvTFgzTUsvdGZTck1Hc1NxZDBtSXdYMnVD?=
 =?utf-8?B?OGdaQ1BLamNvY3BWa3g5T01lYjg4S0h3Z3haUWJ5b1l5R1pGQU54VGJ2M05J?=
 =?utf-8?B?WkszOFhob1hZem03VGdMNVNZaUV0TzlTNlZHS1NveWlQNzR6UkR4aHIrRWNS?=
 =?utf-8?B?MGtVbzVycWUwc21lMGJ6WDRZMTdRcmZodFpVYnQ4UEs5YkJ4SXdtK1IrVVU4?=
 =?utf-8?B?VWRKczdZb0dKaGg2Z0d2Zk0zNmJHNXptc0xwYjZ5VGZTaEpyc2MwMmJSMnRN?=
 =?utf-8?B?Mm1LNGlnY1ZjMTlPS2NxVmhWMitvVDd2blArNm5oNmVOWFMwVUlFV1hGT2Q2?=
 =?utf-8?B?Sm4wWDFJdW10NFJDU3ZkTm9zNVNoV1pZUW1GVjZJWUtSOXBwbmJpaTlFeDI2?=
 =?utf-8?B?ODdKaDVpb0l5anNFdk80ZHE2RHptQVE0WlJsejNVN3BGcGF5d0dWQmNiK0o3?=
 =?utf-8?B?UXd0b1hZSWM4aXpFMU9SUSt6K2pRaUlVZDBaSnMycUFjb0V5cW1JKzdjYTR0?=
 =?utf-8?B?SzhaNTl0dnI3Y2FVNFJ3VEY3UzVGSzh1U2thcVl4cDhSL1lpKysxSys2SitD?=
 =?utf-8?B?by90VkZJYmNncEhNdVdTamRPdHlHNmRHNkJCdTd5WUFIWVEvakl5eWFjSmpo?=
 =?utf-8?B?OHdWSzFmaHZocjNLSDk0bmRqZkVaWnFmd2ErQUFiQVUxREMwa1VzcXZUUS9p?=
 =?utf-8?B?NDl6aGp4Y2FUUTVyTlZWUndFWmtmbnB6dUo0alVPajB3Zm5jVG9RbEwxUnhD?=
 =?utf-8?B?cXozWmxkTjJWeVM2cHV0bjBHOU9HeUlYYThobmJzaHhWWXRBaFNzNDlzeW9M?=
 =?utf-8?B?eHpGYytOOEJtWm5tV0ExUGFiMTRObnI5eDBnS04vWWtWNjJxSDc3K3V4eFNQ?=
 =?utf-8?B?QlBPc1FmQnEwUXQwWG9MWEJhNmtqN1prSlZOai9SWVhRQXRsRCtYb2o5L2Np?=
 =?utf-8?B?dzNwSG9pWWhDWFlPMStuT3JLOTM3OXo1SkZoMjFGbnVPeGJjeENFMHN1Z21r?=
 =?utf-8?B?VTE3M0l3a1MyMmNIK2ZyOUNuM3JkUTJOSHc5elJidGRjVDBNdUpsdDVrK1FD?=
 =?utf-8?B?U2haOFJPQXZVT0JGdkdaY3VKSE5NVThKMDM1WWxZUEZJRm9lcW40ZTFMTk91?=
 =?utf-8?B?aFZIb2Q2cmlzRFlJZHdOMDF1K1h2RnhUTjA3c3E5K0RmSGZ3UFpGMlZMVmVy?=
 =?utf-8?B?cDZNL2RSajFpUk11b25kT2RHeUdoWXJqOWI5cjRuQ3VpSjBDYVJCRVk1bUJi?=
 =?utf-8?B?ejFIdEM3TnpWaGxaUTluRGEzNXdmcjhDSDFoeVNSZG4zWVhhaXovbjNXUVpX?=
 =?utf-8?B?Y3dEUzRVUnNNZ2g2di90MHNsVjJCNG9vbmVNMFV2SkpYdmpyWDR0VXgyc0FH?=
 =?utf-8?B?UGpKUmdudW9qdTgvbitRelBtajhTNmU4WFNoUTUybStRN0F6dG55NGd5ZkZI?=
 =?utf-8?B?SXN3aFBFKy9oZUprVDlZVjlLa3ZaOCtmUG85enEvMjdyeHFnWENyQmF4ZE9k?=
 =?utf-8?B?emFoZyt1NEZScExwRFpQQlZKdWlNUWlROEJ3aXVHcHh3K1lKMVZuTjlmMFhX?=
 =?utf-8?B?clBjTXJBWm1XUlZVLzVJV2tvUVcxL2F5aExMY294YmthWE15YmFrTktMSi8w?=
 =?utf-8?B?U3lZK2U4dHo4SXhTVHk2V1lkTVpoUE9TS3VRQWxWQmtGSkpSZDNIQThqQnho?=
 =?utf-8?B?d0tkVjhiZkgzdTFKUHdHR3llYnlUQmlKUEVidFE0R3Y0Z1kzS3NBaEpTVURE?=
 =?utf-8?B?Y3FoREVTbEE1M2NQKzc5TmpsaGRVbGtBSzIwZGxRUHExVG5nQXBSemJOUDFy?=
 =?utf-8?B?enBKS2ZjeTNnaFl6dGJrek1IYWRBQ3hxNUZiM2VlaGQxVkR1ZkNsdy9pOFBr?=
 =?utf-8?B?VFdEcG5FWkpXYTRWMksyWEhTNXY3Y1ZnWmFpdmlqcm1QLzF5UUdQN0FIYk9F?=
 =?utf-8?B?eklkTWxJL01uR0VRNDdZWjdtcy8xUlVPclpxVE00Nms3VUhNeURQZlZLVHQ5?=
 =?utf-8?B?T1hXeUIzV2lsRkpLc1c1V2RzbHM1MFRFTzZ4QlZqWWIySTdtQlg4ZmZ3b0JR?=
 =?utf-8?Q?VNaosVY5GWsMFOLA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92e2c49-6336-456d-0794-08de693e35d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:21:44.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OcO0fI6aItFCpwgpPm8zgzASB+UttTTVtdgQ8hpA5HQtALZe3moymwvLa9E4GS+F/7jMI5U+Q3oG+6zrUEjQGg1kdgism/O57y7LYjIyok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6627
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:53:33 +0100
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

Hi Tom, Michael

On 10/2/2026 4:17 am, Michael Nazzareno Trimarchi wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi
>
> On Tue, Feb 3, 2026 at 3:57 PM Tom Rini <trini@konsulko.com> wrote:
>> On Tue, Feb 03, 2026 at 03:47:18PM +0800, dinesh.maniyam@altera.com wrote:
>>
>>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>
>>> Add a generic SPL NAND MTD loader providing nand_get_mtd() and
>>> nand_spl_load_image() helpers.
>>>
>>> This allows SPL NAND MTD loading logic to be shared across NAND
>>> controllers instead of being embedded in individual drivers.
>>>
>>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>> ---
>>>   drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>   create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c
> Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
>
>> This is a good idea, and I'd like to see a follow-up RFC that switches
>> at least one other platform over showing that this really is generic
>> enough.
>>
>> --
>> Tom
> Thanks for the feedback.
>
> I’ll send this as an RFC. I don’t currently have access to additional
> NAND platforms to validate the change myself, so testing and feedback
> from other maintainers would be greatly appreciated to help confirm
> that the solution is sufficiently generic.
>
> Dinesh
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
