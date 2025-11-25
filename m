Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E6BD0E6F9
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7150B840B1;
	Tue, 25 Nov 2025 16:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="goXXvxpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF606840B1; Tue, 25 Nov 2025 16:18:22 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76673840A9
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcQN1fpx28tWFVv/BL0IxtVJRCIh8+oelrS7RuQDS+Q3iodWKRPEGYgQr6fnmjXCV4h/RWRKpZy0ns7ArI3PbGkGrUsFr6Wk0vjG9i996hbaw0sal9G7uE/+mDyGrr23uhSzwkZGNBYh22OSVt1kwnqs3TvZqSuow+o1BUlRqB261QQKyk9Pjh/soHeyEHr3dVp9eTVKoVCmZE48OK3MvOtc5I5nwHl766+//NUGmWbf8Wup6zdghh7xplbSTok9gTzSnfq3sqmO9OYBq+lfa21rmt2e31YV8TNeE+M0ECGLGmYy1IppviodHtAbkiMI6S4TMOdGEBHK2VbchP3Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn/XJX9c1RhSfYemOzQY7HN1lNtU7eRgcAHNh72dXA8=;
 b=b6Wi2xTCaBDZbU2xkc0ZshfZTc41IwvaASdLGMBOE4X9PwwDbZKKrJg74EPKeZYnjpgCDV2MONWtGWMWQk88OxG0Mqvrgoy0MDqm4hAUyViOYRALEwlgoh4QiKJSsSFOZyjAGOlfQqaOM0BV7MPolbRTSN55M5fPq3bWxadnKH9wbdJZ5dXMz1BNdl7hmfDP/VEUudZP14pm6BNuoe+sFs2/70QznL6vfLnyFFQcyOVnFwO+1VwZs4qAQ+tBpFnylv/GcbE8/FXlcf3AuAfoqcd9oHRWGJqLwcOPy2HFHOwjSHqRyZgGsjvbHw/dqqthqbFzeHgAg0kPxJd3zXly/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn/XJX9c1RhSfYemOzQY7HN1lNtU7eRgcAHNh72dXA8=;
 b=goXXvxpwXsIdOqH7uy+aqhWN7beA8FMbSPW3DxY7IEZO+Lf6/7jMcTLqBCLQ4gQUFLhBSE23ntTF0GE4nx1ljVJLIeOnZzW5a9Yo3dONLz88woGlv/uN6AfBZz+fReLDhciqZwoTESB94DbXIv0A5kShySqHilJM6VP6SGSfoMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 15:18:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:18:16 +0000
Message-ID: <b3d8ae61-1549-4126-807b-22f85ce4894c@cherry.de>
Date: Tue, 25 Nov 2025 16:18:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
 <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
 <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
 <9bb15fc9-7434-4ba4-814b-d99cdcd7a4f8@cherry.de>
 <889f9772-a50f-47e2-a678-1316a8be296a@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <889f9772-a50f-47e2-a678-1316a8be296a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 233f9ace-a4e1-49d5-b3fd-08de2c35dba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGRtcDh6ZWhhcUdTcWNkcXN6VWdiUmc2T2pBeVRQM3lTTWI4QmdGV1dhVEJR?=
 =?utf-8?B?a25tOTAzUFdjZmhPbGxLWTdMTnRjalRHRkdyNUVaM0dpZjRENllsVkM5UDRs?=
 =?utf-8?B?S0dzeWVTQUVYOXhMY1VGWHlGRGZQdWhvM3RVNEVhNHQ4eVFRZDdQUU1xdVJj?=
 =?utf-8?B?SnMvZGFwUTFpTkdxWWI0S2NkTWUrazhRTkZzcWd6bW5TeFZhMmFmLzRranhW?=
 =?utf-8?B?OXZwUHc4QkxBWE52VzFUeWVaSXMwK09EYzNrVlo0VXRzN1FCTWRXQ0lpRlRG?=
 =?utf-8?B?SEtReCtuejMzY0dNMlF2bUZuS1htWENnQS9Yc0tIS0xNNVBtaUtyM1psb2py?=
 =?utf-8?B?SW5Hb2EzZ3l5UmlyRFBPemVkb3FqR2Q2S2lrSlRkTEVPcjVmZzRHV1NYeklE?=
 =?utf-8?B?MTlyYkpNUC9Wc3kwWEFMTi9UZTVoUXZmOFhwNVViNUVjTVdibXBGZHVjNCtZ?=
 =?utf-8?B?aU1oUlVmSGI3MWllOU5xOUIxN2ZWZWdyY1VlQ3ZRZXgvTENSUHJWUGloZElG?=
 =?utf-8?B?bjhDVzh0UmNTKy9MM0FQZmlrYkExMFB1dWxBaGtMZmdCd0dTeitTdjExblhw?=
 =?utf-8?B?WCtJVkR6Qy9ac28zWkJEdDcxTWEzU3lrNjhtT3gyaG5zSlVXSEJNTURLencv?=
 =?utf-8?B?aVNXK1o3cllUVjdYd0szeHZ4T0JYR2l3VnlBZ2dIVHB4T0FEMGg5SXRWVkZV?=
 =?utf-8?B?cWtCclV2THRrbnBHOG1ES0dEMkllb05qR0JEVjBMNWVrdkVuc2hHNFYrWU5I?=
 =?utf-8?B?RUJmZGdZckNTWVpGSzZzcm9pblllVURiNElVRXpkdlJPWDVMaHZ5VmdHVjVO?=
 =?utf-8?B?U2RQV3VBQU1WT2M0Vk1aSVl0TjVRQ0M0aDNvTzZENmtQYXVnVytITlRFdk5o?=
 =?utf-8?B?cFBlRmtwbk0zTDFTY01HYmxFOGRFQUlNcmhCOW5OdWJ2eU1FY1NmM1JMUm9K?=
 =?utf-8?B?bkF0d3BrUUY1VEdpSUZiVUVaYW90VUhCdHM0dkhBTUhSODJhSmZpSldENmcz?=
 =?utf-8?B?NkhCR1hFZ1RaWWZEdGdQSnU3MEdQOXBSSk53QnRtSDJnZC9LK2JBWnZlRzJp?=
 =?utf-8?B?SDJiNUlBZWNOcGVHQVFxNmkzRU1wK09QOWhtZDBGa3JFcFZNR0Jqa3RSZzg5?=
 =?utf-8?B?Z3MxVkFJSEhCZ2VyNXlUWmtoUmtYRStIZnhQZC93cHVLRXJQcldraVFydnAw?=
 =?utf-8?B?Q2NpVXNFcEdGaVhRSk9kZ3RVbXFjbk5jUFpUY2p4a0dtZk16ZWtKUDRuSHJk?=
 =?utf-8?B?dVY3TThrZzVJWXJwTEpOM0ExRzdYYms5a2E5Q3ZUMm9lMFhRRWh4OEZuNTNj?=
 =?utf-8?B?SnlhWmdFbldwMnFWUnVSRjlJdGQ1UkY3eUgyeFF2VldjMkdHTzRITnZ5NVEr?=
 =?utf-8?B?TzZXOHJ0V2pQemRjMEg4dGFxemw0Ti9EQ2lkeFVlSGVrS3hwdGxsSDQ3Vm1D?=
 =?utf-8?B?akU1YUlIKzhWVWtJSHpyQjBTUFhxZElvcE9JNFY5TGFWamxuR1VlZlJZUmk2?=
 =?utf-8?B?TFVVRGdvZGJsbkQ3NW1JZzl5bnB1NEJtMUFMaEdJRTNEK3VQTUxjS3hBVEZL?=
 =?utf-8?B?bHlub0ZEdmoxV3loRkJ5cENveXlNOXJmZTg5SVo1V0MrVVlKWU85TXo2NTZX?=
 =?utf-8?B?UnVnTTRBdWo1ZndXL1dNaGU3ai83SGFPdm4reHNPcDNLU2xMcTUvUUs1S1hh?=
 =?utf-8?B?OTViZWs1Z1cxMjQ0Lzl2eHo1WG50NFpZOWhuMHN4cFZLaCtvREF2ZXUyeFpO?=
 =?utf-8?B?N3E0TmJqTXBSSmN6QytDQ2tacWg0L3FjQTRqaGNTcFJwSEozdUJkWFV2MEhI?=
 =?utf-8?B?SWRKU3lEYXpqK2pvRkpSeGlraGY2K3BCYUxydVZZTjNKM2h5ZnkreVVVa0RI?=
 =?utf-8?B?VzFLWFVzem43bU9Cb01ycS9JMDlJcGNXaFB5M2xVRGdTVWo5citIUkdWc0JW?=
 =?utf-8?Q?b8QOSKA5IsFp9JwiGmBS7SkndkHKmhKd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2ZkYXAwQkpIb09pOXRud21ZbzNFNjNKR2Vkd2NmcS9vWk1acVVSZXdMRWNV?=
 =?utf-8?B?Q3dvemdiMEF0UGZzdDFCV1lNblQvOUpETlQ4Z3gwWkw4aHJMa1N2aFFJUk8y?=
 =?utf-8?B?cFpNYnN0M0UycWxxRUNrV3p2dWVYdjZ3YldTTXZqakFtTUR0TW53R0loU3RD?=
 =?utf-8?B?Vm1nSUwvTk5ZUzhodjJhSlAyUHYvTUQ0QW5pMkVVLzRnaTEvU1Y5cG5pd2lD?=
 =?utf-8?B?QUU1K2h4L3hXckE5aUk3RlFMeEF1N3pKQ2hjS3dVMVNXWks4UWxoQU9SclFU?=
 =?utf-8?B?VG1DaGEwWS9QZnBaUjdubXl1MWo1SHIxVlZDbENpb0NJNTY1cThEdi9ML1BC?=
 =?utf-8?B?K1V3WEpOLy82dTdjajliSksxMUkvdGgxVWkvR2tQZ0hib3RRV3JONXpQRHdw?=
 =?utf-8?B?OHRVMHNYajl4SWVzb1UwbDU0RlNTbjdJbFN6cHZWc3N2a1hXSFAyZUlISEVE?=
 =?utf-8?B?Q1N4UW5seXBPbDExRmVNTi9MeEZIRHE5MXM5SHlPZFpiN3VTTkpsVENRMTEw?=
 =?utf-8?B?Qkh6UkNpTEJac3NuL3U3ZU1aVnljcGg2SUVGdDYzWkpqNVlDYXYwQmlLd2Vk?=
 =?utf-8?B?VlB2S1BKM3QxTVM1U2x2UVhwTTlrN3F4OHRTRHJFVDQvWWl4UlpKZll4UVlZ?=
 =?utf-8?B?REV5SFI4OEdoODU5V0hoakN2RnprbkZwcFJHdTRNRzhoR1lWek5KeDU4R0Vo?=
 =?utf-8?B?L3JjQ0haSm9Zc3RYN01Jc0xCMjU0YkdiWmZtWlM2TUFBcU9nN0lKeVdNUUFN?=
 =?utf-8?B?ZjFjYUliUWRvQk4ycFd6MWdHdnNTN2crY2tvUnFxeG4rbXhRMHpUR0JzSE12?=
 =?utf-8?B?MEdZYWdVMWVJeGVsWVp5WnQzZ3dxcVRvdWN5b3BTKzlPOFVRV01PSzVVUHQv?=
 =?utf-8?B?T3R1NEdSUkQ3eXlxbTJjMnBqaWRxcFRXQzBHYTQ3N0pLNmw3Zmh2ZEI2QkZt?=
 =?utf-8?B?eTBPUnlTc2dLSE9ZNTgzbk9TVWNJVTlGWndWTEYyLzBSQXlETFo5NHNZVTZt?=
 =?utf-8?B?RWxiQXJ0TzN2eVRUY1FYYXEzNUZOMUFneXRIYzdkSFBDWjg3dVBHcTlGRU94?=
 =?utf-8?B?V25LRGJrTFdUUzg4Tk8wWCtPRWZrVi9FanNhcFRLZ285ZjFCTHNRWG4zWFpY?=
 =?utf-8?B?M0xOOXFaNEt3a3poVEZTSmdOcFN1UEUxQm8wMlNMVDJvMGhQOS9rYUN3aDg1?=
 =?utf-8?B?djVEWkpLOFVuZUswVEJTRldQSGUrdnBEa0l3SGRvZEJMcGZXcDRTbnYxQmx3?=
 =?utf-8?B?eWRIanZFdVdEdlhseTd0N1pEUDZZMWUvMGIwdzhvb2plYkdMckVvY1ZQMlRS?=
 =?utf-8?B?QnFIYWVsSnlQeTJ3b2VoR1lUNjBxTWNZbHovbXBjUzZXbkJIQ2pmeTZTa1NS?=
 =?utf-8?B?TWxpdCsxR1ZOZmh2dW5KMWVGdXc5WkFESDdjYkF4K2dESWZPd0hlRzlyTGpB?=
 =?utf-8?B?QzgzbjVLT2tVSHl0YlhmeUM4WmZiQ0E4clNtQWpwQUJUb2VuaWsrTi9sUC82?=
 =?utf-8?B?MTd0aDZCUm5YQi9vcUxwbHkyODVxNWZtcG9ON0lvcC8yQmR2ZVZEdGhpc1dF?=
 =?utf-8?B?T3BJeTYrNFNyc0xJOHF1bXoxMGd6MkYyMVdMWFM3M2pVRmZRSHE2ZVgzc3Rv?=
 =?utf-8?B?NEJPc0NFdC9BVnJESVpQaVQ3R3c3S1V3eVIwZ3hCU29FUEhrYVZGbnk3aXhk?=
 =?utf-8?B?cXlwVTNjRjFVNkFMLzQvQ2hXbWt0czFDWG4ybGZrSzUzcytKTnZmUmU5Vm1Q?=
 =?utf-8?B?WlZUTEZsdG50bFgyclYzM3RlZS9xV09KSGxvdUg1NmxPangwLy9OVkdVSDB6?=
 =?utf-8?B?ZUp0Y2tmYlJ4OFRNSzQ2d3RDYnJ4SGhhVHdhdWdOSHNTTUNrYzl0N3RGS2h2?=
 =?utf-8?B?R21VRUVPcUl5MlZSWlRxd0xrU3dMa2RrY0JFR05CMVZwWXJWbDJDLzlNUjQw?=
 =?utf-8?B?V1pUd3l1R3p5TXBDTENUSTd4Q2dSK1RoclN6cFUyc3JjMGErM1g3UHlPSS9B?=
 =?utf-8?B?dzVtTkhXMndBVlpINkdHZm9WMi9oN0dOVXJyVUdEcGNJM2QxZjNrR2NvNklP?=
 =?utf-8?B?R1FvRC9SMVNMa0hna3UrMVRBWFdpRjJiMXFsc3l6SzJFaW9hb2ZlNk81QkpG?=
 =?utf-8?B?RzdtY1dLbEtja2g2MmtTVXpBWVVnR1Ezdkh5Vk5UU21wUWJNVzNaUWFhNERK?=
 =?utf-8?Q?08PNmO425GdAeWi2ySR4L9Y=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f9ace-a4e1-49d5-b3fd-08de2c35dba4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:18:16.4165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TriUi4bSGBo+3J3gUu1uCa+0Oi6ibl6VdWPDtMqPfvfhzR31d0UikmVpxSPWwL+05ZxvsSSHkZ4JopdZ0bhYNR2j7T7dgWvPgZgZSkh0hmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
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

Hi Marek,

On 11/25/25 3:20 PM, Marek Vasut wrote:
> On 11/25/25 11:07 AM, Quentin Schulz wrote:
> 
> Hello Quentin,
> 
>>>>> Example invocation:
>>>>> "
>>>>> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>>>>>            -d arch/arm/boot/zImage \
>>>>>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>>>>>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
>>>>>       -Z 0xde000000 \
>>>>>            /path/to/output/fitImage
>>>>> "
>>>
>>> ...
>>>
>>>> Which formats are supported for the --tee-file parameter? OP-TEE OS 
>>>> itself has multiple versions for the binary header (v1 and v2?) and 
>>>> we can pass either a binary (tee.bin) or an ELF (tee.elf) in binman, 
>>>> c.f. tools/binman/etype/tee_os.py
>>>
>>> The raw binary only, see the example invocation above.
>>>
>>
>> Must be documented then please.
> 
> Where would you document this ? In the manpage ? Elsewhere ?
> 

Wherever the user can see it when using the tool. The manpage for sure 
yes. Maybe in the mkimage usage help string but I'm worried it'll make 
it harder to read.

Also, turns out that one really is supposed to use the raw binary format 
for OP-TEE OS (since 3.8.0). I had missed that part so it kinda makes 
sense to only support that, after all 3.8.0 is already 6 years old! 
Blobs from Rockchip do have a .bin extension so I assume they are raw 
binaries.

>>> [...]
>>>
>>>> OK so... On Rockchip we have TF-A and OP-TEE OS split in multiple 
>>>> entries with different load addresses (see @atf-seq and @tee-seq in 
>>>> arch/arm/dts/rockchip-u-boot.dtsi). I guess this means we wouldn't 
>>>> be able to use this auto FIT?
>>>
>>> Are those multiple "versions" of these binaries or are those really 
>>> separate parts of a single binary ? The later seems a bit odd. Do you 
>>> have an example of such configuration?
>>>
>>
>> Same binary split.
>>

[...]

> 
> Neither of the binaries listed above is TEE ?
> 

Oopsies. Got distracted by reviewing both tf-a (already merged) and tee 
support in mkimage -f auto. So this applies to TF-A part only, where we 
(Rockchip) use the ELF file (for Rockchip blobs; maybe upstream TF-A is 
loadable in raw binary form as well?) and that is split by binman. Since 
one is supposed to use the raw bin for OP-TEE OS and that binman doesn't 
actually split this into multiple entries, this doesn't apply, sorry for 
the noise.

> I can imagine you can have tee header and something else bundled in the 
> fitImage, but for such more complex case, better use .its file to 
> describe it.

Fair.

Quentin
