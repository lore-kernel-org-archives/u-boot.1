Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE8AC7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62DB82BA1;
	Fri, 20 Jun 2025 20:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="t10LtqFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E752182CBC; Fri, 20 Jun 2025 20:47:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF86780C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs1iwjUgn1BNYpkK80zU3GJmEg3SlcCorxad9WSlYiKqnnKXTi+rUTixiGziTLabKuGyD5CyJ0v/aOYA4vpM2ZVcK+KqEcN5V0+zExijCDi4GRBQnUPZG4tWggntsAeyLEuktlcQfOLgonaGAGHov7OjAanlZOyWIJqHvvjBe13mtAA4O1TtMuMvcJoCWsuQ23JbGPsKNDCbRUuRJ/kfpzyHbdnO6KxI9eN4tDb5TK50yBQnDM/xCpjynEDwphIEIJzfRYGul4e3d+mPpIxygoXk/94TbMlItMgv+Klg8tzHOK5fTARbW6WRApLezP1fFofofYvaJSe3lD8RZCfxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HslXWZt+ssYTixdls5yMZW78ADR8Ik8G30AlNIAImA=;
 b=C+L148SMEEzwr/ZRpK9NXCGWORCt02Byw3QDfy0ksai3sIfw3at8jOzzpo1pnkrq2JiYAP6zuL7unEj/wEjak0BLH5r2PqnNV9xpyDI07x9c36LCru/C+8iHve1cL/S3k01qljCY8hMQeSLNA3FOOp9eoHVQWxQgr1imy+2C59gWQc+2II5g6D5y9Ep8dkhMEN25oWBul2D2P2UxUJ1IrApS2OTVtqd3PdnG0GtuDyjH4my9bn/CnXjP4PAI0EyL5l0Ouf3i0Oww0tTeJrj5HLGDJMOJnASeudtmMWmjFS2HWjDrh5iUx9BmQJdCN5yQrpK/xmdql0W6k2+wYxaLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HslXWZt+ssYTixdls5yMZW78ADR8Ik8G30AlNIAImA=;
 b=t10LtqFsx0ksrSQyb5DtsQqZUQsvq+UH3zfSkgMgY+Hwl4brliKdjeI+aRthOK9/5WhLryaYvhDvlBGTdz3L61KD0pdBZEEWOqGF1tz6jBO4au6ejVCKM0A4ZQBB25wqNsDcFlD8elYufFcFTfG3r4StkmtczlSs1A1evOJqRMBS2TgkVGxAxW+D2mys/+Wc8AlXNfA2565bUZrbZLU19YXMvqioAXf3lfcB3Xfsz4+kAT7C3SzXlyIkOdsUy7ZzR34pypyCGpWVehvVGK48MWLWUyURMx+fH7aAgalY3nOYEso1cGInGtge50KBcAa7n23IOR7LNFzB2bPGN6KmkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 18:47:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 18:47:03 +0000
Message-ID: <5e3239ff-205f-44de-ba43-8b32eefdbe73@siemens.com>
Date: Fri, 20 Jun 2025 20:47:01 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Revert "drivers: mmc: rpmb: Use R1 response"
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
 Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
 Akio Hirayama <hirayama.akio@socionext.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf574f0-83cd-4159-f1ad-08ddb02ad8e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzIyQWkraU9LampYZDlOdFZ1NlZyTGhOTDhBcjFZMDJnRXRVWFdJdGdLUnBu?=
 =?utf-8?B?cTNlOEtBTTdYN2gyZWJRNUs1MHNqL3ZQTDhtYjYrTXNHZlM2UHl6ekpCc1lD?=
 =?utf-8?B?S0dJZkNDSVZ5R1VvOTdJaGVnWGxHUUxtUjZSb01HL1libDdZYWEraURiTHZx?=
 =?utf-8?B?MUsvbkJGZ3JBQWN0MnVWSXEvWUZLOHd3aU5KbzVhSlE0eU50cldWaGNubXdS?=
 =?utf-8?B?N0xpV2VJcjVmWEI4ZjF3OU9VVUVHY0ZVV1Mxc1dieHR1dXpUMHZEaGMwK3c2?=
 =?utf-8?B?Y1d2MTRpVVh1dml6WmJrNDF2M0N5UE9kTVZIY3RFdTVqSVYzYXNUZ0ZuNkFU?=
 =?utf-8?B?MXJVcUNrOXk5MnU4WEFtK1RndjZhaCtJeTVuVm54dzVjeVB5cGpGdXl6b0V3?=
 =?utf-8?B?Vmt5SnVQeXVScXM4dCs4c2RKWjRQbllNVVJESk9MQWFKSGN2cUR2MGFNb1Qr?=
 =?utf-8?B?QU42S0VLbWc3bVB6M3BCM1hyamJaNkp2VnVTb0ROZlVOSWlvTU9ORkYxK1Ns?=
 =?utf-8?B?QXl5RTgyVHp3dU5INEtCYkRVY3Bqcmc2bVYvZGNXakRLaGhDTCsvbzkwYVRl?=
 =?utf-8?B?ZDVmemxkZnUycnFIbzdvUkJvNXJkdGxqaXBRenlLZ3RzK3ZhZTd2NU5FcEJU?=
 =?utf-8?B?WHhKQlU3YzNNeDIvdjVFY25TREloeWFGL205VWczdURiRVh0NGxhb1ZZV1dR?=
 =?utf-8?B?ODBsVW9oZzhLUlZienYweEtzcXFHL3NkR0RPK1YxbDhSZEVqTFgrUkorUnU5?=
 =?utf-8?B?YzFZREVvZHFDeUI3MEJoVUJ4QlVSQzY2MVNVRGJ6RkY2MmRRcGxNM2dkc3RQ?=
 =?utf-8?B?eEswQzdCMHJuanVGakFtQlJyVTZ6WW9HYXN0ZXZRT3AxY21uVmtIMmZrajlH?=
 =?utf-8?B?akhuU2dTbkRDWWFMYm8zRkJlU2JsWCtXYjN0NHdIL2VGbU45V3JOQ2dKT2V0?=
 =?utf-8?B?MGx2Rm9MTWIwcVBwR2RHckFkdThLcDJVMzdRRTA2L0wxUkJYTDlJQUdqcW1K?=
 =?utf-8?B?UGZpdGdEbTZMVVBTWjFqa0xkMi8vbzlGWUZna3FMbHBxdXIxdjBtZS90UHhv?=
 =?utf-8?B?Sm1rKzdZOTg1cGFTQ3VYazdFSWJmVWl3eTllam9oTVh0ZUNJc3JiOHM0TEZI?=
 =?utf-8?B?azZaN0dKT1NGVGR1RUFRTHFxTFA0R3RHYzJHRWZUSkpCY2F4TDdrUUtCL1li?=
 =?utf-8?B?UENDQVJlWDRzTWVRVU5wMVFGYVl1SGxYZG9mSExnbUpKVlkrR09xQVYwS2lQ?=
 =?utf-8?B?SGcxUGIrT2VhVDM5YmpjcnJqMU5DUmkyWlprR0FVRk5PNm81S0ovT0NiWTBL?=
 =?utf-8?B?bUxMV0dTNzV5MU85VkVEY2FLOXRSei9WZVMrZWhlL212Ukt0YndtWlVsRjZ0?=
 =?utf-8?B?NE5vcUN5R1hIVGU5OFlVMHhES1JNV2Z5cHJ1ZURBbjFMWVRYSHhNUVVFTi9t?=
 =?utf-8?B?RXd6cXFQOVVEc1laR2p2cks5MFg5VTFrYVB1Y254eWdhLzFMYmJ5d3lZNE01?=
 =?utf-8?B?VlcyMFR1elBFQnR6N0dGWkFmNjdVZWFMbGZLL2daTlBGWjhRY09rT3h4TjNs?=
 =?utf-8?B?ell3MjVNMGYzZy9PSXpDVDRQcEVQV1dVdlZUS0JXRVZQLytXeFVMZUlmVzky?=
 =?utf-8?B?ejlNM1BCU0JFNFlNVm1NUXFJcjVvc3hsUVBxdjRrYTFwY2xORXZZZ2hoYUZH?=
 =?utf-8?B?Tm8wUjB1aS9rWi81Yy90T1hTekhPMEdnMTJ3ODkvbGV6NStNK1hqbUxqNmtj?=
 =?utf-8?B?aWVwSWdodkpKSnRQNjZvNzIyN0hlWUE4cFhJemRhQ1lIREs5MkhCdmF1NUpp?=
 =?utf-8?B?b0kyaDhFQlBRK1hpM2xKNXhzUEpoS2JMZ1l0V3VzM0NsWmgzWmZJMll1RkM4?=
 =?utf-8?B?djVzZkJwOENFY01XcWdSVDRJb3dEN2VaNUhsTWExRHdQRzdIK3dxTGlGUDBT?=
 =?utf-8?Q?bpo/byT8dVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllQTHEyLzVjMENaOE9uV0NaL21ZSVVFa01VdXRFMnVUbk5kVnEwajFpaUxo?=
 =?utf-8?B?ZU5FNTJSQVo1dUxGblQybEtBRkJ6MzFvNno4UjlVamI4eUsreGhOOG5uOEpQ?=
 =?utf-8?B?aXRtS0habWQ5RldhQ1d3OC95dU8rMGhwcG5kT1dlNnV2S211K3FkOFd4NFYw?=
 =?utf-8?B?UmJydW5yV3hvSVcvNjdSTXYxRE9zWGtOcEwxQWN0QXNBeWl6THFoUDB4SHk2?=
 =?utf-8?B?ckNPaVFQK0pQTzEwUnRFTnRnUHV0UGJiakExcVBYZGRsYlgyUUpmVmNzVjhz?=
 =?utf-8?B?SVk4a1RraElWcERzUkk0MG85M1FIcTd6RHIrSnJDeGJtUG85QUVQRmxlUUla?=
 =?utf-8?B?QnBhTnZkVEhJUEwvUnp4KzJiMXJXeFBzL2U0UUxlbC90QjZsQWEzYnZtRzN3?=
 =?utf-8?B?L3ArQnRQUmI5QWZOaUFDVldLMjR4Sm03a25mWkRzdGFTSzk5U29hVEZDWmow?=
 =?utf-8?B?NURuSG9PZmE0TnRjV3VjVE02eDFBeGg2VXVRLzBwaXphUDN3cTdSN2s2MHFB?=
 =?utf-8?B?WW1uY05MSWsyUGh3QVBLLzRyKy95OW1PRU5DTUhYUm83ZzVkNjQ5ZmxuTkl1?=
 =?utf-8?B?ZExxa2tEQzU3bDRSdDVhcWVjRVd6OUdHYitxdGhIdjd0Y2VIc1p1eWdtS0s4?=
 =?utf-8?B?Vkw3VzJzYzN4RlFnaEI4NnBtTzhpZVpRekl4ckFkOVliYnJZR3RlUXBZK2d0?=
 =?utf-8?B?OHZzRUUyeWd6K3hYTWpneno0ZjB3U3BDV1d3am1KdXhaNWgvWTNqNkpEVDJn?=
 =?utf-8?B?akdQdXJmdFRjdHNhZC9sUzN4Y25zeUgxTXR3S0o3dVhYcVZYdWtEQ0ZlcExI?=
 =?utf-8?B?VkdVNTZUc2JBWUFwQW53TTRaTlAzaXhDMWM2UkRGdTJoaTFVcEFJZ3VxaDRa?=
 =?utf-8?B?RERoazhVNnpUOFlEVkIzV25ocHNBdVlmS2xHSGFnMEFVaFZjdlk2ZUdHbGtj?=
 =?utf-8?B?SG55YjBkZG9YeEh5Ty9OVVdiUXZ2bkRYSjVuUnE4RkwySUJ2elNIOVZrdnZh?=
 =?utf-8?B?Q0ZTcXVaRTUva00xMGxCNmtwL0twVmVPOWRVR1cxREs5ZThTdDB0UVVqazV1?=
 =?utf-8?B?Q1dDNkZrcHZzbUh5QnBTT2pPMC9Ra21PTkNlUU5qWC95bW9NQnMrQTFRcFBr?=
 =?utf-8?B?NTJTUmJBU2s5SHFZK2Fkd0F3SkdKTWtXR2pRQm5EQ2VLSTNDVlZ2L2src3ZR?=
 =?utf-8?B?L3pPZ3pMMWdZVTBOM2c3cHR5ZE90WjB6TlZEY091cHh2Y210N3BVK0paUHQz?=
 =?utf-8?B?eXlsWmY4QlJDRUJPdTJjMkE2T0gwN1gvQkRud0hrSi9BZFdWaTRQOWVOTjl0?=
 =?utf-8?B?ZlFob2RmalhRZktIdlZxV1ZNZFE2M0V0OTZUNkhHUERsZUNYN0Q1d250Yzlr?=
 =?utf-8?B?VHIwVGVXVnNaQlE2bjVEWjFaVFQ5ZytwRFQ3QWw5TWdDYjBSSVFYSG9OdEJy?=
 =?utf-8?B?TmhQbDF2QnpCT25XdVRycFd0cVhhVW9KZjBCNUNVTFNNcUZhaXE2RXVONG9j?=
 =?utf-8?B?aWJJeXRSR3dXdUVmTGl6a0w4ZUNtMzAvNmJQYWEzbHpUaFVXWmxITm92Z25n?=
 =?utf-8?B?VkpKQ1dzeFY4dy85MnV4SGEvOFlTNllYZXJrZUE2dzF5K2ViVk9vUGhkVHl3?=
 =?utf-8?B?bGJoV0RzOGhYd2VNakRENElwUHY0em4rOWtrZkNOS0YyQUdPREYyWC9oLzh3?=
 =?utf-8?B?NVBjdTc2TGhFL1NjMDJZbDhaOUJwdWhSdzVzeUhjZCs3Ky80OWw4SnY1SFZt?=
 =?utf-8?B?aS90RDQ2RHRTR1BJU0NqUUFXUHBTZjExR0N4OWZScURqb2ZXK3NwbTBLTFVs?=
 =?utf-8?B?MWtybUhaN2E2dmt5bld1WUx5cjhUOTloekxQcS9rblAxdU5qK2lYUXB2Tmxa?=
 =?utf-8?B?ZHM5eGxMMzhzOWpHWUdJenpxbGNjRDNNNFhBbkVRNGZWZ2htV3FNbEw4VEhP?=
 =?utf-8?B?Zk52N204aG9jNFpDNnd1NUlXcEFFbWVsN1h3MURtS0lpd2NIV2xVbXBxZERr?=
 =?utf-8?B?dWRRSFBidTY0MmRnbzIxdTZ6c1VZaHI2Y1k4NTBqT3JSRktzcUFYbyszUzNT?=
 =?utf-8?B?ZmJhc1RwRnRkMWRicitTYmprT3ZsUzlTalorYjkzcDROQnFYODNEYTlnNjkv?=
 =?utf-8?Q?iHxjJjR1FJ4mIIBRceA/DLiyx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf574f0-83cd-4159-f1ad-08ddb02ad8e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 18:47:03.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boZLjik6JRFtm04z8xWW2ZCgaVXaedIemkPVFhF3sjMwCzd8r1ksggngtvhQvpT40jGxbylOxm9nRX6yM9oC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts commit ae93d8106bdb5926efef9222d553adb295ebce96.
It is no longer needed since 24b1e0c7e2e3.

Since the obsolete include pulled in byteorder.h which is needed by now,
include this one directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/mmc/rpmb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
index fa3ac2d9e37..8bfdffd56f5 100644
--- a/drivers/mmc/rpmb.c
+++ b/drivers/mmc/rpmb.c
@@ -11,7 +11,7 @@
 #include <log.h>
 #include <memalign.h>
 #include <mmc.h>
-#include <sdhci.h>
+#include <asm/byteorder.h>
 #include <u-boot/sha256.h>
 #include "mmc_private.h"
 
@@ -91,7 +91,6 @@ static int mmc_rpmb_request(struct mmc *mmc, const struct s_rpmb *s,
 {
 	struct mmc_cmd cmd = {0};
 	struct mmc_data data;
-	struct sdhci_host *host = mmc->priv;
 	int ret;
 
 	ret = mmc_set_blockcount(mmc, count, is_rel_write);
@@ -106,9 +105,6 @@ static int mmc_rpmb_request(struct mmc *mmc, const struct s_rpmb *s,
 	cmd.cmdarg = 0;
 	cmd.resp_type = MMC_RSP_R1;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_R1B)
-		cmd.resp_type = MMC_RSP_R1;
-
 	data.src = (const char *)s;
 	data.blocks = 1;
 	data.blocksize = MMC_MAX_BLOCK_LEN;
-- 
2.43.0
