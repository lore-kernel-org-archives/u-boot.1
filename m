Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB22D1CDAB
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 01:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CC383B6C;
	Thu,  4 Dec 2025 02:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="v2T47ItB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2C883B82; Thu,  4 Dec 2025 02:11:59 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5ACC83B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 02:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZJwClAiTT9iGSDmSVEC/F/MdMAoLBmRGP5nbJgSpXWtZrf6GEzgrmRfLS8TddLT1Hg4oy5SBSrZG6FSg+pjkv3GVsZ1CYwNBBuA3XldsGoYgv4+pg4pNzYRFSIzMsYzFZ2pbb1CGH3YhvOVU19rP2C379HSjOD7KTA8wPfv0uRLdfhOUGbQ5k8rd0KQ4R7wXMlhLLwfGPNQhTFQR1QtYqSvqzAf6lfJX3zktdqnZuAYTn1ElR4pnpgWuRoOF4Ex/LMrKwolQmb02qdijJpNnIa7fLpU3yDZVKQeepCtRqGtGIou0fJcqn0CjMAtVKGKv5oHF3JLJf0CG6UWc1m6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9V48yJlmWyAqNMwE6MCbnnneS+cufKEa1vrDM7NXAw=;
 b=gdJk9CiFt+GYaTtQxVy4q5/6WJwD7mFspCmq8uLgRHskvZGY+qAahB9wpKy25cWoAXDL/Km5+eifqk7UV3Q74Jcss1DXi7+d3B4wkS8nFMx9nV/6kqWbD/CUE526aHyi17gXw6mJzsBgjfhMtdsC0Uv3kCkWNR6zy7EfyHXDPSs7U+Yu2EfJddh9/muuyCKjx9vM3PMgbiLewF96cfEnzplgx2D5n329S2BRZeKtUt6V+AwXDC3qaqd/c2demKhoSzJubPB2bbrfRXyvCAq94S1HtNOouegBucQH2I4yqQMvFGhced0Oe4LsmHLiqvfCxv6wRHDCC4mYyCq0epdrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9V48yJlmWyAqNMwE6MCbnnneS+cufKEa1vrDM7NXAw=;
 b=v2T47ItB8uG1ZE5jxjTJxVdIGEPx0mEaMR2VXfW5P4ixCjR7K7vOg7URIdbWjmH3KMmw3azebAP237BppXtllmCnArVjeDHgJ4NvB6TiqRakZQQQ49/TnaxcX8hxsLlOP0oXJeSxDt81E7gn+i11aAM6HohYYric/KZPmjPNAmhTrqx/o/HVUnuXglzPmwjBQVnpSpInVM+fXF7QOhoBGTVbiFdLA3ZdJcCHArXgtHI9s2HEwRrMVLIACrifVxUswG9Qh3Jg9St9CYfiFArrNaHry1dJdk/IkoJBpr6r8FUv1wIn6MRJ6+E1oh8YRbNbIwADsdQd1YC0a4C8/XE+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5572.namprd03.prod.outlook.com (2603:10b6:208:292::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 01:11:54 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 01:11:48 +0000
Message-ID: <70bc39fc-6af9-4839-99c7-46de9b14c5a5@altera.com>
Date: Thu, 4 Dec 2025 09:11:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CAN7C2SAjdQMUA+7sbeOgVg7stk_mvxVXomu+PO4+ENGbgAviTw@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SAjdQMUA+7sbeOgVg7stk_mvxVXomu+PO4+ENGbgAviTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcb7617-7f5d-40a2-d913-08de32d218fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0RzWUxNOXZCREMvSmdMNHFObWNObWd3MjhtbFpEVzVrS1l6c0Yxb05adXZC?=
 =?utf-8?B?QTNza085dFJ4T2RCSS9NUmIrTm5mZnhmc3JHbkJOemlhRXF5RjQyZ3Arc0JE?=
 =?utf-8?B?NG9wOSttSzdMSGJ0VzBBQ0pXK0s5azJFaGdxTGxMYVJiUHZINW1IdmRyTUoy?=
 =?utf-8?B?blExSTN6TUlJNnh3NWpZREhNTThZcEVCYmJNR1NPRHBUek5OelZjVjlFTzBy?=
 =?utf-8?B?c2d6WElySkc2TDlWcVl0RWYrNGtuc1BaYklPQVZ3VFlLVW5TWjZtejBjR0Ju?=
 =?utf-8?B?RkluTDlnU2JmV3ZNKzk4eW90YkxTaGJ5VHA0dWZjajh6QWFPRWJNa2tEeEV0?=
 =?utf-8?B?N3Vla0RxRUpQM0pDaHVCMEJGc1I2ODN0cDFpMUhTeFdmSmg3ZXNac3dQZGtC?=
 =?utf-8?B?ZEpQR2VVMTBNblk2VXJsSTNzSHpFYmFRbkg4OHdIdEs5ZEJzSVZobTBFbTlJ?=
 =?utf-8?B?b0JNYURKN2YvQTdLWUF6Q3F2OXJZc0ZreTk0aHlIS01KZXpPbHFxanQvalBE?=
 =?utf-8?B?bzRnZmRlV1hFZTV2ZlBVTjUyeVk2blowMk9JTURHN2NybWRFNzUzVzVBc2lE?=
 =?utf-8?B?bkIyQm5PM0tLSFhId1NpMGJOZ3dmOVRUZ3BZWmZINEZnWmdPbWNkd3hvNHp3?=
 =?utf-8?B?U1N3NklIYWhVaHNKRjEyUHNUMC8zK0kyMFVyVXhlWTZKQXVwYW82TnlGMGFl?=
 =?utf-8?B?bncyVmppdGhRMmMxSm5jM1lGdHVJU1J4WW8wem5EVm5iUmxmS3JQUUpuVjFI?=
 =?utf-8?B?OE5UdVZCc0t5N1JyTHdJOWNQOWZEeFY5RHpWSnlLVWNGamVoUnZBWkt4a1U0?=
 =?utf-8?B?WjVaUjJlQU9IeHlVL0VjbDkyL0FqWUx6WUJGL21Gb1ZLTklDWDVsNStSOWVY?=
 =?utf-8?B?SlZMSFExQXpQR1NvbCthMjBMMmxoZHNKSmR3RUUzeVE1Zk1ZQmRhelFBMzFG?=
 =?utf-8?B?RjEydHYzZEREU3BucEd3SkZLNERNbEd6VTRzWHJoaHNiMzhBbVdlTlREbXd0?=
 =?utf-8?B?YUUyT3dYWGlVSHhsS3NkWE04UklRNGJPY0lPNllVY08wY0VWdlpvLzVQSG9P?=
 =?utf-8?B?ZlJXMjdnMUFaVDIzbUxUTGtiRFF1S09IWHhtZ3Q2bVZ5V0JMaTRGWUJmVG9O?=
 =?utf-8?B?TkdLNlk0N1V1U3hXSXNsQk9aaUJkWkNVR0xMQ2pRZjhhNjN5ZXZ3QVJwR1k1?=
 =?utf-8?B?a2cyNjNGZFBObzlxUU9palFGdGdtWGVrOERHWllBNFI1UUJHRTEvYWVxTDlr?=
 =?utf-8?B?Qkt6Y0dSWldvZlRtbVUxTTRPQnZSZVlLRXJvRml0ekxHamt3TEdUSnkzaEpl?=
 =?utf-8?B?N3NtcklpVnprQ1MyVDlrUFhtcWxvNS85MVhObVo3MWZRMmZLZ1lYTUdBVVZF?=
 =?utf-8?B?N0Nydk00UlJQSmdBd0ZBWlBMZThqaEsxM3h5TXVSMU9YUFJSNzFQSkhOSXZI?=
 =?utf-8?B?amxyTVNuWXJIS0tBcXVXNmRja2ZMYWZpcmw5V0wrTno5Zm9nMFd1ZGpERFBP?=
 =?utf-8?B?M1k2a2VjQmlDUUhyUk9YdG9GTWRxSDEvV04xRFZKdUJMa1c2dEZBNjljb080?=
 =?utf-8?B?Y3VoSVVsdWlSTktKNzhnWXhEOFJoTWI1UkFvRzMxUzBnc3ZCWEVhYXg3em9i?=
 =?utf-8?B?NUROYno0R1d4Y0xNY3hUOHNFL3hQWW5QelFwanlxdEwwSlBqWVpUOXBDK0pY?=
 =?utf-8?B?R3NqVVN0RzBUanhneHdBNXFvd2ZrNzQ0bmxJa2JhN0NmTFFqT0s5aW4vMFg3?=
 =?utf-8?B?ai9Iam5kei83b1ZZNlNhUStFeXp3U1Bza2lIejM4bXBYQm11NFZCQnU5MUVr?=
 =?utf-8?B?NnJuQkVmUElORVlVdzNlK0xhODd1YWpHNWNLNkRReGpLcytkd05RaDVJSFJG?=
 =?utf-8?B?V3kxUWNhSmlNR2pldnFSbTEweDI5QThZSTVacldHVEt3NGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDRSVG9SUWM4NGpFdVNXWitvQlkwT3NFdlZHeEppY1VXNmFkOVdXYzVOTW5k?=
 =?utf-8?B?eWpyaE83YXBuUkwydE1rc01mYnZrZ1ZNN3hmbDVpeldjamF4UUszQjUvVUxZ?=
 =?utf-8?B?N1MyT1VzblI2T29QQ2dKSmtWNjNyd1YvV1RsZHlVQjVpU3gzMm9US1RNN203?=
 =?utf-8?B?MXlHT0FIM3IzRjJJNFFtNnRaMUtsUnFKcWlseWxNdGo3cEpLZHpuZGlLbk1t?=
 =?utf-8?B?UHNBNzFwUjU2eEQ1R3l1bGF0SXdWSWlaVjJKNnJSU0hrK2g3TTFKN2g5ZlZ2?=
 =?utf-8?B?b2swNGFLaE80WG1sZEQxWk1WelRMY3ViZjdrUkJwd3NRYWVZenpGTVpHQWVz?=
 =?utf-8?B?Zkc5ZVFUa3JqOFZmT3JOd3VxUXNYOUZYZUVLRkVSQS9vOGZqYUpHSFZNNFlB?=
 =?utf-8?B?ZkRlNGpQV1R5WklCMVByRkJGcEJRcHlIVEsxLzgycjRhN0FreklPblJkMVU1?=
 =?utf-8?B?ME83bnY0K1BVRFBhUFpLQ2hSZk5Jb09ROHVvNDhsQ3ppcllLWlhHWUQ3dEJO?=
 =?utf-8?B?ejhwRHNpMjFtNkdnVGRCSWFMcGNvZy9aMkRsUUNHWGloY2trdnU3N2VENGR2?=
 =?utf-8?B?dGh3YjZUSlg4cytUd3FtMmZsckVXdjFxb3p2VnNOR2ZTeEFXdnVEeXV4blpO?=
 =?utf-8?B?eHhIQVovcWd3QmNTc0p1L1hGS1ByVk1XcDdTVUx1c0JzY1JCTGJSZGNVaUh3?=
 =?utf-8?B?dndGeUFzTWZXdVA1TFBITjdYVWlUL3FrSUNqZWYxQVQwOVRPQnNhL25FYjVS?=
 =?utf-8?B?WWxGKzdHTzl6dW5sbUNqZllxd2VsN2k4Ukhmdnh3ZlA0STlGRkxwb1lRamoy?=
 =?utf-8?B?Z0dlOFl5eVFaelQ4QXlaL054K0xkSHlwWGE2YldVRGJYRzhsQk1kdXlyUmZN?=
 =?utf-8?B?SHB3YW1OeVJDUGxXSGgxbm9qeFUyeHg0N3R0SkxDRmVLTVc2YmR3RTA2YndC?=
 =?utf-8?B?Wjd5N3p3QWcyc2F3TUViTk9IaElpcE5OSnNWYjF4MUxBMHBObFlOUHJ0eWZi?=
 =?utf-8?B?N3hBOHplSlcxV0ZGbGJBc1BtWlNxTEtZbDBXRDM1UHc1aWJTYlgvT1VJTldO?=
 =?utf-8?B?dkxOUWF3bkEwM3pqeHo1R1RCaUhmdXpmUnF0amNJa2hGTGQ4NUE3V1JkZWxC?=
 =?utf-8?B?SWdWRCs0TWFMcHFiUkg3T2VJcFNEOXhyaUNjb1ZkT3kzSk92a2FabnFJN0pi?=
 =?utf-8?B?UlZxRnBvUDlIODlMNDExa2UzZmZIbkpKWDdiZGdETzNXZ3RnNnlnVDYxZmcv?=
 =?utf-8?B?WmEyL1NnZkF4MXhxcUxzU0l5Vzd2RDRxZ1ZYWmI5Q3RoWXQzTU54SWFCVmhZ?=
 =?utf-8?B?OGRaK24vZTNMOWlTWjRyb01zTzJKVTRKV3MvcFFkbVkyeXYwWVlmTnZ4dFJ0?=
 =?utf-8?B?RGF1WGc0TXpkM0R5MFYwdFlkL1BxVlRMeEE3QjhnZUV5Q1hBc3FJQ3FmMzZQ?=
 =?utf-8?B?djcwQXJnUFJTQ3lPdDk1bUFNblJZWU9kbDhOdUUrZ1dqQkhaTlQ2YkQrRUZR?=
 =?utf-8?B?UTdXeWJwQ3JmcDNudEROVmxyWjI4ZHc4OVU2UUwvS1lLY1FIMWVhaGhyK1Zj?=
 =?utf-8?B?TGdMcTlGTWd5Z3JsN2V2cDNmemN5Y3ZLMVNCeTJHR29LOFp2TkdFVHQxckhz?=
 =?utf-8?B?dHhqNkNCTnJDbzZkYlZRK2doM3dxUEZwTlN6bjJBRlNtWHNFSFpWRzFZU3U0?=
 =?utf-8?B?cW5DUWxHK1hxZ3lRbzh4U2dzM1crcjAzT2crM2FYWVJKMjQzV3F4NnNpckpy?=
 =?utf-8?B?WGlXcTVQajNqOEVWVk94RHdYK3lJK1lwNGdkMnZDM0ZITDlKZkViK1p5eTUv?=
 =?utf-8?B?ZUltOHhqY0FNd3VLRWRQd3A0Y3hnNzFTc2VTMHdjemxjdWtubFJ1L0tJeVJW?=
 =?utf-8?B?cHhOSVRuMGZwRFhqcDVkYzZjMUVZUDR0aGsrbWVsZy9zRjNLV2xaWHFsdU43?=
 =?utf-8?B?TUMwakczbWdxNGg1d0luWEpFSXlYVTBRbm1mN3dOditEWStZMldVL1JxS3lh?=
 =?utf-8?B?NGE0OWpjNVplQ21BOFZJcnh6NUwvOVNTcmpDQmFoVVlqNXRSRUJHK0pJWUQz?=
 =?utf-8?B?VDZITWs4SVY0NVk0NnBSTVc0bWpXRkdOekFuOG5FMzVody96ZzRybzg1RkF6?=
 =?utf-8?B?ZWswSUR3dEd6YzcwSmkrYmRmdkxLZTlzV2RtaERYSHZBWUZ5MkQ5NW9JQmNX?=
 =?utf-8?Q?g4lJniE6Jm0IxKcPZGsUjYs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcb7617-7f5d-40a2-d913-08de32d218fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 01:11:48.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/0xqqyOEn0MdXT/xvbd3+GhK6bECEINjL1AZgYa16TQ+tnv6lKrjhN+tGJ/z+hzFLTHKWxU5/nyJ5otIpylU7C3sfGbjyb+fsS/F9GjTG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5572
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

Hi,

On 4/12/2025 5:02 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Ralph Siemsen <ralph.siemsen@linaro.org> 於 2025年12月4日週四 上午4:52寫道：
>>
>> Hi Brian,
>>
>> On Wed, Dec 3, 2025 at 1:17 PM Sune Brian <briansune@gmail.com> wrote:
>>
>>> But did you disable also all "CYCLIC" as well?
>>
>> I have "CONFIG_CYCLIC is not set" which disables all the others.
>>
>> I also have another patch to disable the watchdog, adapted from [1].
>> This didn't seem to make any difference (but my ram calibration
>> doesn't take very long).
>>
>> [1]  https://lore.kernel.org/all/20250603115442.19971-8-nareshkumar.ravulapalli@altera.com/
>>
> 
> Hi Ralph,
> 
> I do diff the mainstream and Altera trunk.
> I cam repeat the same behavior on altera trunk when all WDT CYCLIC turned off.
> 
> I plan to investigate under another board.
> TBH if it is board specific case then there is nothing harm to simply
> turn on CYCLIC or WDT.
> But the truth is that Altera trunk force using designware WDT by default.
> Because under distro I do full "memtester" and "stressapptest".
> Nothing really fails on those two.
> 

I have tried to disable all WDT and CYCLIC configs on both Altera trunk 
and mainline U-Boot on my side.

I made some changes to the standard socfpga_cyclone5_defconfig as well 
as the common Kconfig to really disable all watchdog configs.

I cannot replicate the issue on both cases, I am able to boot via RAM 
through ARM debugger, as well as through MMC boot after triggering reset 
in Linux.

I am using our Cyclone V SoC Development Kit, details of the board can 
be found here

[1] 
https://www.rocketboards.org/foswiki/Documentation/AlteraSoCDevelopmentBoard

I am thinking this could be related to the power supply not being fully 
stable before SDRAM calibration, perhaps you could try other reset 
methods, such as cold/warm reset, or power cycling the board and see if 
there is any difference compared to using the physical reset switch key?

Thanks,
Alif

>>> 3) I use socfpga_cyclone5_defconfig and only change minimum settings
>>> that I needs.
>>>  From this issue mentioned to current day.
>>
>> Then it sounds like it is a recent issue... hmm... I'm currently on
>> 2025.10 release version (plus some cherry-picks). I'll give a try on
>> master/next once I get some other things stabilised...
>>
>> Regards,
>> Ralph
> 
> The major reason is the ECC on mainstream is completely missing.
> BTW [1] I do manually inserted and test no luck on that.
> 
> Yet still thank you for the help.
> 
> Brian

