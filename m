Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EA7C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 15:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC2181F7B;
	Mon, 14 Apr 2025 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Zmmb9Rn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95CA082116; Mon, 14 Apr 2025 17:10:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6614B81E14
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 17:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWxv1/fGijWZaAiR3e5pV9LukTdC77wFK654dPp8/sh51fZNlDE3og4PqAt0lVhOut15ufyOMKhmkb98XIaQ0yfeQlfLaYa4rYwnelpvOdTWD1nTbbJxLfXMb+EpOAFMrTGkt2jWA7pvv8rOl9rKgMyywjUfR8r75A/SqVxfaZRq/blhKwSWZSNsOoagbiyVz9IbkIZpceyBGAw25TmudCmvvdSmPGSC4TZ6Ttus98BtXrZBMonDBFxd96p+LsW4+SXkQ4Rxxon+2PcUnpCFwbGB/G6AqsUaecK1Feo8gBuRCBiHH3gjcLBbw5KZB4MeLKyAKewpEKnvVW5K8A5jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNASMdHSpehLK3uQo6TamGD7XcX6+dESjmcX6v27ezg=;
 b=l6XVfSx5SpWC+u93fPiTWWdkOVQ4h/rqL3NqtqqoKYJur2iWOit6oycGR5NzoTWs8ingHWzTWwjFUqs4Y1SFlj5N9CAKThFPd6C3se+0CPDEuW8/iL5CsiAIjw368/fNCryktR9/304HKDVK1RV7q+8LeZkzJRIe+RZ6KuO8aQoke/zFkKA7wZMPIQ9a0NRgBo8J3PwE6c4w2ukTlsTZ9pmET+yEvCxET16Et22DQHrTAnZkTZF6xOhLlpzDE7yAzv5nYNkiYJt11GlgnltEXpZZwt3RRVnC0W/ycsNFruccOtw2Ef6L8vfjbSh1dt/ih+ovxrImusNy8fnWQLhBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNASMdHSpehLK3uQo6TamGD7XcX6+dESjmcX6v27ezg=;
 b=Zmmb9Rn3t2so/2iW3FSjiLhkdeBMuwrgbfhC9lRy2U8UVm0RDjrMDPtxrMIENXfF8t9dw5UQlnYDJQiU42F8WrTbo2aQnylHINDx5TmMPF1r2cEbaBvPnjWmiLM0wKtC/XMI384ohYNdkVpe7tBsfIDBlZM5X4tv8jrdYmiea2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:09:57 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 15:09:57 +0000
Message-ID: <fbd407cb-e0dd-4055-91d1-0b57b45a180e@cherry.de>
Date: Mon, 14 Apr 2025 17:09:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
 <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
 <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
 <53f32547-6758-49a2-8246-72b9046cac03@cherry.de>
 <CAFLszTh0et26pngJK1e6JjeLHaNsm7XDhZn3kfZZc7LBeAt-iw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTh0et26pngJK1e6JjeLHaNsm7XDhZn3kfZZc7LBeAt-iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b743f67-e3b8-4fab-e6e9-08dd7b666b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjBhblNpZHE5ZHY0ZitsdkVFTmVFUE5jeUZHbkNEVkx3ekZCa0xOUGY0UkY3?=
 =?utf-8?B?cWN1SlhXN3REY3JMQm0xdXNHTWYyWmVaU0lwRjF0ckRuM1ZsYmJHT2JmdmVx?=
 =?utf-8?B?TzRFYUpEa3FxcjVWZVhSOHdvdmtQOEZVLzBSVFk4ZmdhcFJBNm9LckJQVkpj?=
 =?utf-8?B?WnBnYUNKaHRlVmkxbnFVN2NnMVh5Q0F1Z21rN3d6Rm9EU3lWNkJJT2F3Q3Z1?=
 =?utf-8?B?eldhNDdtblEwU1VOcGxBY3NiMzRqemJYMlV3bjZwakNuSGptQzlxOGFHSnFD?=
 =?utf-8?B?aHEwVmt6YnFjNXV6YjR0ZWZCc2ZaanhUT3QrK09oczVuMUFXSzNNVStlbTdJ?=
 =?utf-8?B?M0FrRisrV3JWYUIwTDlOYjFza0NWcEl5WEJUSEIvV2FCeFpGYWVHZ2dJMXNv?=
 =?utf-8?B?Njl0czIzcENGdmwxU0pKQUNBZDRsb1BzSytPcU92K1R1aFZlYi9nUGdyN0xK?=
 =?utf-8?B?OFR3Z3pTZ2I5ZHBLdm9jMjhDMlNGMURETlYvd1BrMmw2TW1HUGNFR0hjbm91?=
 =?utf-8?B?WFJoU1VtS2k5dldVd2luODlEb0VOT0J0a1dzSWJmajJHNm05NHhUNi81RUxn?=
 =?utf-8?B?b1ZtK283VDRKSnhGZ010eUE2NjVMa0x2T3NnYldWSUVibmgxWkdFZElaZUIx?=
 =?utf-8?B?YmRIbS9maExtNVN1NUZZS2dlckFGWXQ4dHBIRXdzeWlVVUtDNVpEWkIyL2lp?=
 =?utf-8?B?ZWNKZzJOaVYzQXZCYjd3OS9QdHFjelluZ0xnR2dLQTQzR1dTNFdJMjUraXU2?=
 =?utf-8?B?aTdoblNOemNNamFrWXh3eWJYaUZLOHY0SEE0a0RDVTRjODZaNm9QdWZYdEJC?=
 =?utf-8?B?aWVVQ1duYktHYTlHZTFHUjNQK21tNnJCTjdrT2UyeFh6MzdMc1YvNGhUb1Np?=
 =?utf-8?B?SXV6TUd0bTlRY2EvcnJsVGNHbFBjdlRESElQT0xqNHVRRVN3ekJDMG9RTGVN?=
 =?utf-8?B?UlU2dnluM2w0dWM4YmVDb1BrL0ZURzV0OGxJREdaRFVmMkFRdEFFVU8yOXB0?=
 =?utf-8?B?Ym8ycTVlcXRZNmgycWlwTUdORjZTQ09pRVpCbXNBLzN6SE90bm0rYmdZM2ll?=
 =?utf-8?B?TmxvVnpiQzJOR0UxRkdxMFVnK3RmaWFDcm83aG9NMkw4RVVkb0U0a3FjeHZH?=
 =?utf-8?B?Q3JxWFFBUGMrTXhreGVjYllDZ21aN25YYkdHWDgxQTdtdHkvYlFUZmxlUGEr?=
 =?utf-8?B?amFBVU5EbFBQMHVwVDJUM0NnRm5ja3JnTXErQ1hVbTN5blpqQ2dYZm9TVmxt?=
 =?utf-8?B?T2RCQ2ZQMGhFY1ltS1FLUXdDcHYzTUxhMjgvY2lXYW1QczdNR0tWeGUxdU9h?=
 =?utf-8?B?MlF4Zk1iMUoxZjYxcTlHT1VKM0lYczFkRVNybFI1VURZS3BsbXY5V055MThT?=
 =?utf-8?B?TWVwbjBEdW14d0R4SU00b2M2Z2c4M3lnQjhsMGw3bS9jY3VuRFNWUGdrZ0pr?=
 =?utf-8?B?YUc0L3BVMXJnZHRDZDJnMVQzVDBWL1JDQTRrSEQ1MFBIVFgvNzBIYlZuWkVm?=
 =?utf-8?B?WUhuMWFyMG9Xb3FNdFI1d2FIUHZHcDFkMGdaaFVsSzR6UTUvVFJmclYyTmE5?=
 =?utf-8?B?WDhWdXFXSktjUi92dlhjSVZxWGx6U0tkRWN6dHVYV05YQ3ovL0RxbkpUWTBJ?=
 =?utf-8?B?Q0ZFcWFaR0tlejdOQ25WOFhsU1ByZUdMSXJIYzNUUDFuelR6NXByREl3dWds?=
 =?utf-8?B?cndGVDVzaEZEWTQyMCtUMmhYd2t2NXAyOXg0c283Zjg5Ui8xZkVHbHJqUzN1?=
 =?utf-8?B?VmM4MmhmaUFMaVpMSk5jdVcyL3llN2JFWHNOaTNnMDdwT0hnTG1PWEVENjlq?=
 =?utf-8?B?UWtHOWdOcmJMbVRqVnFScjIyYXBDQjJrRWl1S243eUtDbkxYMUE1ZEkzaUZa?=
 =?utf-8?B?NDhpcTZmamJzRUk5d0NrMmhXaGF4MklQZmh0blZmamhqSnJFVjlDN3NtblJE?=
 =?utf-8?Q?4hFYOa3Qs3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJvdkErWGN5b1VvVGhMcFFTdll5Ty9VTVFjUUN5TzkrTitGVlFJRHRDaEtU?=
 =?utf-8?B?Z0RvK0MxZkpXdWNtZk9aSFY2NU9oRlljS2YrWDlwbnRmNHdPWS9nSTBWcjg5?=
 =?utf-8?B?WWQ1WS9vbXF3b04rK0d6YjI1Y2FmRXdISHNxeCt6czdtUkR4ejRTa1loTnM4?=
 =?utf-8?B?bGJkVUhXWXExNUk1NTBOUmlyY3JYWFZocVo2TUpxSHVJRmdmVVNlWjdhcHZW?=
 =?utf-8?B?cENldkpuMEI3SUpTbUJrZXNIdTdtOG9iWVJEbk5JM3JHQmlYOXJxa1Z3R3k3?=
 =?utf-8?B?M3FPYzdQcUNrRWFQTFE0YUxJRnFCb2RWSHlBWCtwTG9ZaEZ0VGNTbUkzeVh0?=
 =?utf-8?B?SFVENlk0dEtLSkxSS2VyNDBySkNEYXU3bFVIOVFqOHQrRWhUdEI2WlVKaEpR?=
 =?utf-8?B?QU9vMUxUY0JBQXArMSsrUDlCV3ROalVYVGNpWSt1Uzk5aDlrQnQvK1BxRWR6?=
 =?utf-8?B?Vy9ZUWdRUTlIV3Q2T3Nscy8yTFYrMW1KcERDeDErK1B0TnVqbnBUaG91cUJi?=
 =?utf-8?B?eTZzSU9jS3VrdXlnNWJwT1h6K0s4eGcyeDNHU0pzMENSUHhmVHlJWVdRZVdL?=
 =?utf-8?B?dGVkVlBaRGVUbkgxZFRVYkpybDFBcUQreTYrbGcyRlI5YzRVc3poblA0eXVF?=
 =?utf-8?B?WnBucDU2UXNqcmR0SUJwc2Y5ZGFVMmV6aXRGZGwzTHg2NVNTU2Y1WnF1V25X?=
 =?utf-8?B?aVlFOGplM2FRYy9WT0dnWGYyQWtkbU5qbGZRRXo2UmdpWVNBTUVrTVZMSjQz?=
 =?utf-8?B?Q3BLbitCSThxaFUvTFUrbXY2cmxqODJNYXpJUG5XcTE4d1VNK1JYRmU0ajRL?=
 =?utf-8?B?WlN2cXNEVmNqcnVRQzlxaHRqMHZydE4vdFFXVTJ1MHB0ajZBNXV1bXBxN0NO?=
 =?utf-8?B?Nm95M3dubTV5aFdRM3QrMmJUUFM5ZVlrQUE5RnlUL2pQZWgxcWRjbjAzZlhB?=
 =?utf-8?B?QVh5c0YwYWZIQ051NG0yMk1MRUc0SitsN0k2d2wwU0dtV29sTmxiZVFDN21a?=
 =?utf-8?B?L0lvb1lSMU1oUTloVWNKTzREMFk3Z0VIK08xaitlTGtsMmdZSnhTaUgrR3hw?=
 =?utf-8?B?amZhTWJZb042V2x1Nyt4Zm5wWjB1ay9sdGxReVVDbEJsY1ZSMmU2eHBJdk41?=
 =?utf-8?B?Z1FIMWR6TlhoTk0zbHE4d0Q4anByU1BXVFVxc0syVFlxalVLb2RMNDlXYnlT?=
 =?utf-8?B?M0hhaUEwK2xPbGVXWXdsdEpiNFZOL2Z2QnBPRjNPUWdhZ3VvQ1BUb1RaaTVJ?=
 =?utf-8?B?QVBMZFMySThMelV0ZnFoV1g3dDZjTjF1aXdiQnNCNnJRYThjemZKUUVNcEY5?=
 =?utf-8?B?T3FxNTM4Tk1aczRyaWd1Wmo2RERLUkJWSzFMSnRGSnBRR1JwSVA4SmlFUjNa?=
 =?utf-8?B?bjkvQkJMT3VnUTlGeENxS1g0QWxmQ0ZtRjQ1OW43YjhYTlM5enVOdzlvMzNK?=
 =?utf-8?B?SkhYTmV6Ny9mMmUrbEFMWGxvdkpGdnNQaERkZWdOL3docXo4MkpsRTZ3MVND?=
 =?utf-8?B?aFQyaDRYOEVTUm81d21mYmVaRTVvTmwzcnd4Z1F1VnUyZ2VQQ2dZQUY5Sno5?=
 =?utf-8?B?RUJmTjM2YXlrOTluakJVcW94Y0xhcld0a2RYVVlIOFF6bjNwTnVCU00yUUtx?=
 =?utf-8?B?N2xaeTdRTVdnOU1oKzgzT1dsbUdHc2ZUUFMzWkFYR3EzdDFLSzZhMldiOEJN?=
 =?utf-8?B?c1NkQ3o1TkR0ZmJhc1NvT3RiUGtKMEkybmFzck5jT2p1VERaUVFpaU9jaU16?=
 =?utf-8?B?N3BCMVNjcWZ5YlUvdVYzU1FNY2RCMkNJbU43ZDVsa3pQSThkVlNxWnowTlNs?=
 =?utf-8?B?TWU4RzdIVU9pVXRkS2NYVFp0MjhES094WG5wbDd3dHFEWTllVE0wbXZkS3RK?=
 =?utf-8?B?VU01SndjbFAwa05ITjIxTVM1NC9Ic0plWFcxMVBLUVJXYk1kRjNWUlplUyt5?=
 =?utf-8?B?cXdOT294K055MUxiWHUxaFVBeVAybytyL0JCUGoweHdNL2h0b2RTclJ6TTha?=
 =?utf-8?B?VzRsVkFnYWRCS29YblVJV0NtRjgzT0I4RkltU1VNa1BpQk9tMm9NdktrWUdM?=
 =?utf-8?B?dFFuLzVTdXpTbDJRRVk5UUlXc3hReElVeWhYZUZrMFVLcUpiQ25XNXFCUVNT?=
 =?utf-8?B?NlBRaEpxcVpjSnlsU2s2cWFERFN1bEp0dDZDK25sYis1Sk8ycldXNFBOcVUv?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b743f67-e3b8-4fab-e6e9-08dd7b666b56
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:09:57.6047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJwzrky3AtOLqH0rc6E+9u09HTnmJH7WGt6ImtKlNTKgTfpfhXCvtvDTCN4bE46K7hK4n5Ft6jq+uMfXnOdCMPIhyqAwbrVPGjp/pHDUDFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428
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

Hi Simon,

On 4/9/25 4:30 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 9 Apr 2025 at 07:35, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 4/9/25 3:33 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 9 Apr 2025 at 07:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 4/9/25 3:22 PM, Simon Glass wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>
>>>>>> Hi Jonas, Simon,
>>>>>>
>>>>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>>>
>>>>>>> The simple-bin image is normally written to MMC media at block 64, which
>>>>>>> is a 32K offset from start of storage media.
>>>>>>>
>>>>>>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
>>>>>>> other embedded binman symbols in the output binary is referencing image
>>>>>>> offsets correctly.
>>>>>>>
>>>>>>
>>>>>> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
>>>>>> know it's wrong before this commit?
>>>>>>
>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>> ---
>>>>>>> Changes in v4:
>>>>>>> - Drop defconfig changes
>>>>>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Move this patch to the end of the series
>>>>>>> - Drop 0x8000 offset for SPI
>>>>>>> ---
>>>>>>>      arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>>>> index fb38b7b80c43..65b81bf58626 100644
>>>>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>>>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>>>> @@ -154,6 +154,7 @@
>>>>>>>          simple-bin {
>>>>>>>                  filename = "u-boot-rockchip.bin";
>>>>>>>                  pad-byte = <0xff>;
>>>>>>> +             skip-at-start = <0x8000>;
>>>>>>>
>>>>>>>                  mkimage {
>>>>>>>                          filename = "idbloader.img";
>>>>>>> @@ -178,7 +179,7 @@
>>>>>>>      #else
>>>>>>>                  u-boot-img {
>>>>>>>      #endif
>>>>>>> -                     offset = <CONFIG_SPL_PAD_TO>;
>>>>>>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
>>>>>>
>>>>>> This is confusing. The documentation states:
>>>>>>
>>>>>> """
>>>>>> offset:
>>>>>>         This sets the offset of an entry within the image or section containing
>>>>>>         it.
>>>>>> """
>>>>>>
>>>>>> My understanding is that it should be relative to the beginning of the
>>>>>> image but this now needs the knowledge of where it will be stored on the
>>>>>> MMC device (via the value in skip-at-start).
>>>>>>
>>>>>> Why is skip-at-start automatically deducted from offset?
>>>>>
>>>>> This is how binman works[1]. We are trying to use the feature designs
>>>>
>>>> Why is it deducted?
>>>
>>> Are you asking why skip-at-start is deducted from the offset?
>>>
>>
>> Yes
> 
> It is confusing, unfortunately.
> 
> When you use an offset (say 0x78000) then normally the entry will
> start at that offset in the image.
> 
> When you use skip-at-start 0x8000, its value is added to all top-level
> offsets in the image, so the offset becomes 0x80000
> 
> BUT the image built by binman does not contain the first 0x8000 bytes.
> It is expected that the image is written to offset 0x8000 so that the
> offsets will be correct when used within U-Boot itself.
> 

I would assume all offsets are relative to the beginning of the image in 
the binary? Adding skip-at-start doesn't add 0x8000 bytes at the 
beginning of the binary file, so why would the offsets need to be modified?

Also, while 0x8000 is the typical address the image can be flashed, it 
is not necessarily where it will be as the BootROM tries a few other 
offsets if it cannot find one at 32KiB offset in the storage medium. 
This seems to me to be a case of "somewhat helps in one case, but makes 
things more confusing in others"? Will we need different offsets 
depending on where the FIT is flashed? What happens for A/B updates then?

I understand that we currently essentially have skip-at-start = 0; and 
that it is bad because it doesn't reflect the actual address, but how is 
that worse than hardcoding a different offset?

Cheers,
Quentin
