Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5021AEF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BB283D6C;
	Mon,  9 Feb 2026 02:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s41ofgt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF07C83CF3; Mon,  9 Feb 2026 02:29:21 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355D183D7A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx5ltiEjf8b22cw+SGhbwIM+t9pjfmzlnDOfY03TngRHp0596JS0TpBwZ7VD3FVCt9i8t3evzaX1L3tQhP+HSiqw2c+ckSF/wM8VKyPon9Brx5gwytyVv8BfwUifdih0/wYzB0MFNtxewOOkQutaeP/jQDoTiso6EwXpSK1qqiSPQUSuEK6eUmgp2AcorIr9iiKsLDeRlFW2bcVMfvCM8GFFY7RKD0Q6/7RZvk0vLyURp3482D0DdsC7v4n2z5XMxpQdEZwx7nkMmbQREmBI9ctJf9pBFduoCqDRMUDtiVYGXzlUeX04ZpD7bUDkLDqtHF0OsQ4+brMjjxVRVwXIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxr2jUKCE5NVCIiZd2yTFs/kv17Tlr345m+t0mwdNYE=;
 b=cRqO90fI5jeQe94O/1TdTFylLCjMMGDJNOHKdeMfqFfdaWcU3j+2ebDG+cvMAok3mr5mtKV7YkVV0/mUan9oQPgvEikBlDDFrPDopXdeuH501/+xf9bMcRygJJp2j5vY/wIcgUTyUF3RSsLBnOv2pBi76gsaoek+enVE8GDX4QtOrhZJGcE9R9/5E0kU+gNogRz+VoIqkSd1Gv0ehfdL46M6sbYiQTDBAvlMgbgUgxtkdUndPMzqKctvUUwmPJYhU8lbDDegCWqfITYv+KtCUZ2aytmZz9rdzTKv7ilEMn0p1gV0rIpxG+w0wyYkYnYIOsTZsrDJqvnUnOGN8ZEjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxr2jUKCE5NVCIiZd2yTFs/kv17Tlr345m+t0mwdNYE=;
 b=s41ofgt2lp2QA7GnZQ5bQ5VT8x16PEZ7Ek2hrh/jFHWH6Bz9lM440DYkyxs1PWwOc+AaEMUALtxlyokWbirNmh9JFrBXxGkZoR3dJGjeYeypTGz7KrTi3607mXMPpCVZw0rFbhcB/0F5Acs9cEzQBrp6W2kkFRjdqOkR9hgsk681YRiJya3nsVnRi2+zEjqXZHyPD2y7LwDWvKMTa0RXZntQXczyhVlEM8eRAjUNo5rCJnal/KeaCwg9F2pBQI/qWhKmQKnEWtcONQ9NyZwgiaIzO/mKgJBvGQgnlYeW1VKW35TBgRG9S0ZyeNqXyvHjUOJG8+3S4p6KvP4sEaaD3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 01:29:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:17 +0800
Subject: [PATCH v2 13/14] socfpga: clock_manager_s10: Add missing header files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-13-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9fc3c6-9b43-4379-ac8e-08de677aa373
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2x4S0JSdXB1YXZSb0pXTFB2WlBsblkrT2dKem5WckZvNk1hR3IrZGFsUnJu?=
 =?utf-8?B?ZWFUUTZpak5nVTY4UW9GY3F0ZTJ5SGJndGgrMHJ4MnlJdDdObGNUdDRaUFk3?=
 =?utf-8?B?V3NFQWVMSUg3RjRNekRjY3JiNDQxaXowMThLZGNBdm5IV0M5OUVNVnBwS0Nl?=
 =?utf-8?B?Z2Y4LzNPRjBBd092bHlKdktHdWVhUkRjMzIxeURsZ3QvNjl5U2RvYWpZMFRr?=
 =?utf-8?B?WGVpck9HYjBOa3pTUm9CaXlKZU15Y1RleWlCU3F0N0h4MUpiZmRaWEE1blh6?=
 =?utf-8?B?VjlNQnNZNHRONERSR29vNmdFUnliM0JGbmZLOWlKZ1VrdGJUc2FLMHJlcXcr?=
 =?utf-8?B?UnR5WjdUZ1JQOUQvOWtvZit2bitNSUFvWUw4QnlLQjIwcExZVmFHbksxVkd5?=
 =?utf-8?B?blZmL291cHVuL1Vwd1QreFR0bWw0VHRnVVcyRkplUzBWN3Z2ckpyZWZnemFj?=
 =?utf-8?B?S1BtcVJnMUxHeXZXM2pwdjVSbVNyWWxiamhCRWhPeHZ1ZHQ0RFRsMzVWemlC?=
 =?utf-8?B?RnBpdXA0MGVOVFB4R2RQNzhUSk9ZeFJISGE3dEE2QUZodEVZc1Y3LzV2dlU2?=
 =?utf-8?B?cHVhTkdKQUw2V2xvRTdWMnlHaTVoajNrdUprOXk0cjdFcVpENU5kMHREcnhk?=
 =?utf-8?B?d2xlSXBKSUxIdEVWTmFvcW15ZGllQ2NYcXd3U05oWkVjT3NlOHo5WnZMUGY2?=
 =?utf-8?B?bXQweGxvS2krSmtQSWlZQjYxUVlJRGV3bmMrNzllazRQRC93QzJhVWxWcnln?=
 =?utf-8?B?M25tWmc0endCV2RZenhOendrZlJhRGJpWXpNQUIwVFlmYzNiU0FPdDZhMU9I?=
 =?utf-8?B?cUFEVmpRcFVHYm5QTnZmTGhMVk1zanNiWEU1ZGhKa0YrTXZqT2NzK1NzOFNL?=
 =?utf-8?B?QnZBUml6cDdpMXc1bjNsS0d3bkhoQWVyaGgzS0Z5MmN2ajk5U3Q3ZkFTMS9v?=
 =?utf-8?B?YUs5NURXeVVCUmVralZhWmxLZzZ6QmhJS2ZhZjRvUFRYMjFnbkZRcTdZNjhB?=
 =?utf-8?B?TmQyc0FaVkg5RWt2MFBTcld4eWwvNlZFUFRpYm1qT1hzTk5RamdHZWM3ZFVi?=
 =?utf-8?B?NUFQRFAvc0xFUEt6T2Y2dkdZMEdZVUhlSWcvUTVZRjhTS0ZWVlNLdWduY3JS?=
 =?utf-8?B?THJUYXIzMXFHNkl3UTBOeDdEZ1hqb1I2dmdudWk4dnRHSjF6NXFZV2tvbWV5?=
 =?utf-8?B?TElYSUx3cmg2YnF4dkQ3MVZtQTNVdFdFTWcwQ3c2dm1CaGNDUzdmWkNSakRw?=
 =?utf-8?B?L2V6SU1ORHZ6ZlB6WE9EVmdReEdWeEF4VmVYTHRERlhQRGtUekRzNnhLbGFr?=
 =?utf-8?B?TzMyNlRFNE5OL0tJMy9nTngzTkI4aC9YcWNvaTRNY1VYOHlCRENwYmhTVHYw?=
 =?utf-8?B?TmNSTmVsUG1qUTBHeHpVcjh3cXpUOC9oeTlNTUlqTTQzRkkvZkgyT2ZjbWM5?=
 =?utf-8?B?UHNhNzNhajg2dzRpRXJ0d1hROVQwaEtramJzMXRtb3Y1a0hiU2NvQUtvT3FH?=
 =?utf-8?B?cWV6STlnMmhxa3JTQWpBb1BCMGx2K2tjUkE1OUFjMDJnaU9sWklrd0xjSnNQ?=
 =?utf-8?B?c3NOR2xCMmk4ZHBaZ2QwdTA3NnBjdnZjcjhXOVNBM0R5RmpFalVEdzltWTZS?=
 =?utf-8?B?WW1INS9uR1JrSURzbkFPcUxnQ2tWRUhXQVRtSkxWanJKbHpwY3BpN0ZvcUxO?=
 =?utf-8?B?NTlkODhjRm44dW4ybUZJZ2NieGE0N2hvelJjaGp0WUFDcnpOZFBnZG1sSnAx?=
 =?utf-8?B?N00xUzR3OEhWc3ZzcFY4bVlYQnBMNVJqNWxsVU9WK0p3RmNpWkVmRnJuOWcr?=
 =?utf-8?B?eUlLTEZMbGdQNDNqSnJ2Y3VKZVRXUkxybGs3d2Zod3hBZzFKTHRCQ0xFN3lN?=
 =?utf-8?B?Umw5Mlg3SkN6ZDBtcitUM2VxR2ZHSVRUaG9RTTBEQ0F4YXZEUS9UU0Z2eE51?=
 =?utf-8?B?c1I3OFo5SkRUNXBRWWdTSDdVZTlJVUh4bGNRdWhEZEtMaGVsWHZHNi93eTRM?=
 =?utf-8?B?MXE3ZEJDVmJJK2JWUTJoMXIvWFpxdG92M0YvYmhVeDZMUjZCZ2lyOHpNV2Vo?=
 =?utf-8?B?Nm83R0x0NTIwU1ZxeTZIUSt2OWU5REd0Y2F4YXp6OERaZVBFYlVKeVIrNGI0?=
 =?utf-8?B?WWU3dXNENk81cDV6MXVvcDhpUXB5ek9QQ0ZJRHY2U2VKKzkrVTYrbUJkM1R0?=
 =?utf-8?Q?wQteoflvxwW+gatxf45RUHg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlwc29vTUdQUFBKdENzNE8vdGpCbFIxV25MK2MzMldQdit4REhSZmRGRDJv?=
 =?utf-8?B?Wmw1ZUpZdFhmY2ZROUtqS21hK2FOZ2xHVnpJSjNtMk1KNE9yL2d0bGVjU3A4?=
 =?utf-8?B?T2gvK2pWM01qYWgyQThkVFp6YUJoOXR1K09HUzBQNmVoZXVvWWtKQkQ3cm5o?=
 =?utf-8?B?MURwRzN0SW10SlJtSzN0clpsbmVSTFFzd0I5aGF2eTMxaXVHcGh2VkNTckJD?=
 =?utf-8?B?TGhBMWZlTFdGaGtLRDk3OHdHaUVCNmJON3c2bUwyVnIxSGQ5aFFOT0VWMDho?=
 =?utf-8?B?YkhBVTJmMTFJUmdEUExvWE1wTHdnRWVzbnZ5UkpHMWZKa3h2cTlYbXNRV3l5?=
 =?utf-8?B?ZjNYNkdSNUxFQVVUUHo0bExPSmtZYit5bEd2c2VkSnBOM1ZmVFVkOFFlODRn?=
 =?utf-8?B?T1ZTM3Iza2trRHFKYWtzamVBRUpQSjE4dW1qQW9PbnN3NVFNUzRxcXY5V1hm?=
 =?utf-8?B?TnhNQXNMUXJCbElkUkhQb21FaFdPZW04NjZTdk12WkdRZG1aTGRXTDR6Z1g2?=
 =?utf-8?B?SkdnTm15bVNFS3U1VmVKUTVBdUJWRU9BRVpkd1dPT1FpT3piSnc0VVpPclkr?=
 =?utf-8?B?MFI3SElNZ3FUeGVzTEhzb1JsRDNndXNaZ01NVFo1eFFWZGVmZnAvWllTZy9J?=
 =?utf-8?B?RzIrZ2F0d3dNTDArVUVOaTY0eWRraHUyRGZidXNxVHB3YUxMa3FydTFGMTdZ?=
 =?utf-8?B?R0NUT2NzYTdhRGZ2cjRqd2V0NWwzOW1lbVNKT0Rkd2JVaC9KRFBsUFhDRmI0?=
 =?utf-8?B?K3htdmwyRzI1ckRqanE1VDBtdld0MjhOZnhTSVBFSlRjaUt3T1BXYmlIMnIw?=
 =?utf-8?B?TkpLNkhZZFpRZTdZYnhVOVR2ZHlGdE5PRFpNS3ZkM0tOdGFlVzBLamx0NmhM?=
 =?utf-8?B?L3RsVDNqWnFkWWVwdnJPY2xhUUFEM0thL1k3eXFETzRnNVQwb1dOaUVodHhn?=
 =?utf-8?B?Z2JGejNVTzdqdmtmTCttZkhmWWh1MFg4UnRUWEFxUEtpMkJVYWNtMktkbUsx?=
 =?utf-8?B?ODRMQ0NHeFF0d0NaVjJHN2o2UVh5aDNQSkNzMG1EUDYyZTcwMkpwOGxuNzNI?=
 =?utf-8?B?MTIrKzJ1K3ZycCtlOXlOUi9BeTZ1K1Fwc1Z2cXVGOHdZcHRMdDhoSnBXOXF5?=
 =?utf-8?B?b0lNV2ZkTmhac211alZBVEROUkJJL1BuSGJURGZrS0liejV1TUI2NmFhcVR5?=
 =?utf-8?B?blRUWVFTUGRJbGFkNzloOGZxVWNGM3pOSkpjMWxDQjFja0ZVZnNQS3VGcGM4?=
 =?utf-8?B?cktlc2I0eUdCaktJOXhhUGZVTENwejhpYTVzQ2o1bk8yTll6ZDErRzVWSS9B?=
 =?utf-8?B?b09oaTZNUFg2OWlCc0xyR2l5SG5oOHRReTZOckFxVHViTFp0elZCV0hJNU1E?=
 =?utf-8?B?M0hKTlhKdEZKS2tEV2NOc2dWTEdiVlhCck9XRS9VUTRmQW5kYzB3K21Ya0N3?=
 =?utf-8?B?NStKWkY1RlJURU1qTDFaMDYyZ1czU0FjNmlvZkpEMy9saGx2VnpxNWdBZnB3?=
 =?utf-8?B?RGNqV1M0NnJiMDIzZVFZREJwdmxmWFZBNVAxd1N1TmNDNFJXMm1nNlVZWStl?=
 =?utf-8?B?amxFbExmd0dTZEhqRW8xdDQ2c1QyZXlnUkRQL1E4b3RMY0JqVGRlTWxGbi81?=
 =?utf-8?B?NDhaSjRrczNGWlNLc3VIZlhTMlBZb3owVW1RMysyRTFFRTJMZ1lsdEEybXZO?=
 =?utf-8?B?L2dDbXZJV1VLdXpad0VadEVKTmhidFVTSmhHbU0ySnpCem5BallnSTY2V3lt?=
 =?utf-8?B?cFp5QjRlRDVOQWpMRU9OalQzemJyaXFFQ2VwZXBJV2JJWW1oQktvZWFGa2Fq?=
 =?utf-8?B?QlZJUk0zcm92UU00VHlBSEU2ejVsc05uZ1ZwWjE5TGdERjFuZVk0cmxCejk0?=
 =?utf-8?B?OVBnRGNmYTE0Mm9ZSFN4QWdZbE9zWG93dDBFNUFNNlhlaVNBVWlGL1Y0TU9M?=
 =?utf-8?B?UndmYW5FOU9uMjBqYzZ6MEJLQlFrKy9xSTRWdW8wMXkzSVcvODFaZFNmTnhZ?=
 =?utf-8?B?ZmtocHdFSGU5Q04vWW5IMTZYcGNTMEhQeThNdXAvQ2ZiODh4SEhDK3pSS0RV?=
 =?utf-8?B?QTViSmJKd1FsdmJ2OWF3Z1dYZnF3NENaKzBxd3hXTHRPblpVZXV3d2JOMTR3?=
 =?utf-8?B?R0hjZXBPMmZBbWpBMGc4Q1V4UU1VSjQ2TU00V3FlRHRBWGt1UThyc3FkdVd5?=
 =?utf-8?B?Ly9GK3M3TmVUR2U1Y2liZks4dHJGRjh2c2doN1RUV2hXQ0xHN2x6WUEzeVJz?=
 =?utf-8?B?NEJ3SmsxdWFDV0VEREd4MDUrNVpLR2xLb1loMjdwTWY3MUViN2lUcTE5QUNx?=
 =?utf-8?B?Wmd0anliK0p5ZjNDOVRmOFhEalRFK1Uzb2Z5RlRtVUh0c2FIT3k3QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9fc3c6-9b43-4379-ac8e-08de677aa373
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:16.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRtuXTX0/lkA3B1ceRY6eF2XAXerPEK4B/1fvYs851yqlIL56dj3FbYHUN2mVWqmDPHKnLzppd3AlgAiUHngMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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

struct udevice and u32 are used in this file. Add missing header to avoid
building break after asm/global_data.h is removed from this file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-socfpga/clock_manager_s10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index 1e148947a3385ff1b9ed3ab5ae4e3ac65c2cfa8d..d6c64e9801076824a32c096b9260a58fd25b01f5 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -4,6 +4,8 @@
  *
  */
 
+#include <compiler.h>
+#include <dm/device.h>
 #include <linux/errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>

-- 
2.37.1

