Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24284C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDA080C83;
	Mon, 12 May 2025 18:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FdMXHN6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D9B826AA; Mon, 12 May 2025 18:50:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9BD80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0FWmvF7vjOVz6BNcn7QOBW4MMsqHFGSIPwk8mnNfv+x77brFrfUDoE0OsEj2HtOx9y3v5cFkvRAiMz9UgoGLTTpjvWFNfJ1yFKKDxlxZ79lYcaI5JJlp5sRa8zxIaGi6/y7eeyO0SlHwjZD8o2V9rDYM7R371BoNMw78tPxzdqoEdjNP2B3rtx/EL+7scQBLjfG3C5xuhUEvho0nO9cWoAEHQEQhg17PEOaw5m5s/IIJYkYveTlVCDyF750D8V0ExZogllLoRh2J6GW1ujbXfMqBktacNTatAO/IlRbxKiUjYjGO41O4twlVI0YK9SpXoRZLEjS3PUpPeeB46vrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Puj/S3P9/3pBuSocI+fV27la/jfqHgtdvbQyLGI6MM=;
 b=NPuiIlSmMp/J2aU1eF6jxMMloRjS2c9E4g/DqjXqbiAQd6qxrujb3aLU7bmX2MGW8XwhQOMkji7iQGYQHkuOsmImm1956g11mkaGbz3c3E+W2fvf7bSTWosB0KAQL/ZMdz2vt8RFMeKM5osdadtPj3fRTAOYmdbRGJb4+t4K8aRwtVluSr3NBIKpnR/RfJeyP/qI9H4WyYTr/twKoNAfXqf6Pzt+Pz10O6hxErTpkSPsnRjOGl0mB0A/u1PfU3zQJGukNDqqgw+KJVnrMxgSl+iIMfqVnHm6FLthfGOK6nOjToCW8ZE02sM9pm83gSGdHhfEOQ20y0tGERc9zdyuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Puj/S3P9/3pBuSocI+fV27la/jfqHgtdvbQyLGI6MM=;
 b=FdMXHN6fAsswgWEpKYVcwXsfw6fhUKyqwxSeVKytcEz4eQSD1LQlvJjgJGJ1vGk0o2VY/VaZB7x5JrmDCJUMtQ/l+lLhf4XZ1t74ugoXL4itGTTKQyAAj3rlRfg/fSr5Hu/k0MOZSb5yiBOT/AtY2Kjy1faWNohz7IjhehSOAzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9807.eurprd04.prod.outlook.com (2603:10a6:102:384::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:50:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:50:38 +0000
Message-ID: <291de23e-2f9f-4683-90ab-d52cf2dc9d49@cherry.de>
Date: Mon, 12 May 2025 18:50:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250512161033.146396-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512161033.146396-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6e6eed-4c26-47fd-3d12-08dd91751fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVR1N0NMVDFjOWdGYVc0Q2tCUHh1bGdMUUprS1BTNWNGZkJTbkpOMFFUaWFt?=
 =?utf-8?B?N3QvZldOZy9VNE1VWGFkTXhhWHVrZnBaekk3V0hDVHdkQVp2MnJKMGFTZk5N?=
 =?utf-8?B?RjJoeFVkNzJqMUphK3RjOS85OXZFU3FZOGRMM3FjNnh0TERWMjRTVTNNREZj?=
 =?utf-8?B?TVZmcWZ5aks2SXErblgwa2Z0Q0JzbFovSzgwa1hYbldNNFc2MEhWQllwZkRq?=
 =?utf-8?B?WS9rNFB6SWlwQVllVi9hcndkT1hQckQvQTl6RjVXOVE3VEdoVW9LRFNhdHpQ?=
 =?utf-8?B?cjRBZjBEYXh1N0xHZmRhMTRQZERmTmRCOHRIUnRaMW9hWjJiRnNMKytKRnU4?=
 =?utf-8?B?Zkdnd3ZITkNFRjVjNzNyd1NDZUwyeGVtOGpnRlJKNzNOMGpFdHU4cjVpbllG?=
 =?utf-8?B?VWVXS2dwMjA4dE1BK0tIM2o4cllybUx2OXBSaFIvMmhoODhicU9IZnFjWlc4?=
 =?utf-8?B?QzR1aE9wQm43L1lGM2Vtb0dJNHBIUHBiZGxzR21JZUl3MGlVTytSVEZvSE8z?=
 =?utf-8?B?eWtETHI3RXkxT2JlSkpQZjFxWG1YeXFEQlJ6UjlWUmYxZEd6c3JFdVV5amQr?=
 =?utf-8?B?Y1NmSXYwUC9uS2FLbXBIT0ZFOHV0L1FvUDkwUDV3THpVWTNCb01VN3JFZE1T?=
 =?utf-8?B?TkNJUGJEQmdoSzlrZ3ZJaFpiUlo3czJPdXphUDJIUFU5WWNtOXBaT3gxY0tW?=
 =?utf-8?B?Q0x0dC9kdTV0SGJKRXhJV21QKzExVEE1YVFDMUZEMW94bEQ3TGdZUEtkeGVh?=
 =?utf-8?B?SStsRGNWb3Nha1NWL3NPcTFsbHBkSHYvUCt4WnBGMUNUSWhRWWJsZnVnNmtJ?=
 =?utf-8?B?V0pCT1NPS2UzejlGTzRVNzFpcHFMUllmb05URmYwUnFGWG9Ud3JPTzN2V0ow?=
 =?utf-8?B?NXc0Uk9SS3BwY2JvdTdJKzdYcWxoUGV0VzBpcDZyN3MzU05pWitOR2xYNXB4?=
 =?utf-8?B?cWFwTVVTUWZKTEtTSUFtRmRtbWNkL0k5VnNwU29NRDF0QlB3RzJBOGNQcmJK?=
 =?utf-8?B?WjYxbHE0alhMUklCeDlKb0p4U0RVUzNaUzd0eG90ZUFyNll5YlBLelVYN0Jo?=
 =?utf-8?B?cnd0TGFic2doOG1qMVBlOWJacGF2L2RqeEt5YU1RblppdHVzVkFObDNrQnRH?=
 =?utf-8?B?dGxubXBKd0RyVGFIRm9VRW9zMTZzd3JaRlZJaTY0bjBSV2NUeG9Dd3ZQS003?=
 =?utf-8?B?aHhHVytJNmhJNHZVdVU2OE1UaWtiQlg0cFo1NFRvcllNVkxpNkhqMk1zUkJB?=
 =?utf-8?B?a1IwbCtVMTdSMmdaa3ZwNXo1d3FidHNjZGViVm13YjFBdXRIZTRSR21xNUVq?=
 =?utf-8?B?dnFJMjE2TWozcXBGcDhFbisyRFhwdVRIV2RZMllObjY1bWxRWW9RcDFyR2s4?=
 =?utf-8?B?eU1NSmgrTE9Id3ZIU3MvYWQzcW5XK2FNcUp1Z1BYZjNsZDZKenVCc0l1dnlF?=
 =?utf-8?B?VWFQWTk3NGx0SmZSdXZTQm93enlmaExzTVBOdUczZUdyR25wK25aUUh4eWRv?=
 =?utf-8?B?bFB2UlB5T0ZnZG42ZDhDYUZKRWlSZ1RmWDFBRERYalJxMUMyc3c3aU9IZnoy?=
 =?utf-8?B?VlZONmYwWFBLaG5hVGxsVzdUZnNiNVFlUCtneVBIN0VDNk1hWmZiT3FBMzBE?=
 =?utf-8?B?SlhBTTJMTDV4dWxzOXpaM3M2Qmt2RkIwaXdiTDNBOWZnb0ZpZTQrQkFvTWlB?=
 =?utf-8?B?SFF5bGUrKzhzTUVJRnU4RDNKZS81SzBLZzVXWlNiUnM3eUJQWTBjRXk4WXI4?=
 =?utf-8?B?U1gweTFoTDhGazk5K3ErM2NmYXVkbmhNY0h3UXk5UTR3VGFDRGMyY29SM0RY?=
 =?utf-8?B?ZUZGRTBockN1ZlNiZG1Eem94emptV0RTam5DcjkxK1BFVUNqT3VQYTFEdzZC?=
 =?utf-8?B?b3JwQ2ZENHZsRWQvUVNLcVg0bXc2TWRWTExOTFU5MTRPMzdrb2Q2ZHpNcmFn?=
 =?utf-8?Q?7VcC8elWLfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3pkSkVVQU1aSTdZc2cvUjlwNDY0Q0lqTXNXMlVlVFZJcmxydlpKRFg1R3Rm?=
 =?utf-8?B?V2hPQ05hNHR5RmdNUDFaTTZ0d2xSSXByRnNjZkdQYS84VGZ5ai92VlN2VUVN?=
 =?utf-8?B?cEx0a0dXUlh2ak03VlFGcmF0WUhaOXgzVlhrcy94WEErYXhEY2Zzc2t4dFk5?=
 =?utf-8?B?dkoybTV6ODN6QWpqdkEwcyt4NmJaUnozT2lDVmJxU1ptSHJEQ2hzR05pb1ly?=
 =?utf-8?B?TnlhdVBqd1ZHNE02SHcxV3FSRVhncWQ2R1c1ZExUWEJHNWtzOTdpbzZENVB1?=
 =?utf-8?B?MEJlbGcxdE84aUF2VHVLSmEvSk9iayt0ajJQV2JUUjVlZVZhY3VZRmVycDln?=
 =?utf-8?B?OXZnVnFYcmlIMGtJMkdvZjkzTmtlZ2hISFhtd25LSzZKNXdxMHVsVlpDQlQy?=
 =?utf-8?B?anBRb0VvMGpIcmozcVFtYjgxczRvWjlheHlNWFRBOWNncitYK2pzb3pZSit4?=
 =?utf-8?B?WmR5WGtwL1B4dnN1K29KYnVzam1aSlBQaU1RWmlzb0cyT054MDRhNlgxSW13?=
 =?utf-8?B?d0tLV2VWRUtrWjBKNFQ3eXUvaFcvSDNLelBNWkNSY0hEN3dJekMzVmRmdlBX?=
 =?utf-8?B?UkVwQ3R6cnl5N3NFbmd1NU92L3FOM3lkT2JMNmJjU1lEQkJpTXBiY0pGekd5?=
 =?utf-8?B?Zk0zMWhZUER2R1NmdElHT2JxWEJFMkwwRkJFZS9lTkFlSkFvaElINk5yTjB5?=
 =?utf-8?B?RnRqS3NJNWV3ZmV6Z21USmtkNWJMU1Z6Q3NFT28yT3Bsa3lmcDRSektldm8w?=
 =?utf-8?B?V1dQYUNuN21ZQkYrVkJsTHduamsyc2pBVHNGeGcwaEU0RFZmSGllczduU0dv?=
 =?utf-8?B?TzVaWGk2Z0VkZ0puWlRmQnRoaDloSFgzTkROa2hkOU9LWTF1YXBzcE54c0tD?=
 =?utf-8?B?b2lodGdiSzJBWnJjeDM5bDJ2eTVKaWF2ZDBzOGZRTFBrSUs3clY5L0NKMVJk?=
 =?utf-8?B?MnBlWVphOGx3VVVWeDFUSGx5ZFFDbm1TWlFNeGRCdWtreUE5cndFaDBXc1pK?=
 =?utf-8?B?dHhrejdvK3Y1clVnTWkzaGpBWHFFOE9PRUQ5R2JYZHdYVVUvOWpUNmlsenVQ?=
 =?utf-8?B?ajAycnE5OE82WURiMDZKSHZ0dFpMdForeVNvdWdTVFFJSXlJckI5SkNVWVgr?=
 =?utf-8?B?bUNkOHQ1UCt5dVFDZTVNdlFTS2V4VTl1UUwzQ3hBMkVmTndsY1MyOFgyUXhV?=
 =?utf-8?B?cHpDeWVEc1N2RW80SnM5ZS9tb01LZEFmeDFDeWZJeXAwbkdEMSttSTN3cTVk?=
 =?utf-8?B?aHRMSUVVNVJkMHI2UjA1S2hiNW1xdjB2TmRDa1lWVG4xVVhCL0E1aFgveU03?=
 =?utf-8?B?Nkdzby9kc3IxMlhzeTQrWGVaMmU0dkxFNmhVNEV0dmMzTllsbWcrOG1oMUph?=
 =?utf-8?B?K016bHltS2dPTHhLdTZsblJCNXNNbU9tN3BaMDJ3U1VxWk5kVHFsREVPc0VF?=
 =?utf-8?B?UFFJYWYzK2dVT2NJZnVKLytKdkRaaHkxQU9PWVA5TVprdnRrSnJ4SHNaNmtN?=
 =?utf-8?B?eFd1NDRuNmkxRG0vUTF4aWJRamhtcUtnOVI3Vk9WczM1bHBmaXJqVU9SZ1Nl?=
 =?utf-8?B?WGN2em9VWk9JOW02cjZHUFB6OFZiY3VEYXRkalE3UER2MS9QNHo2L2lVQ1Fy?=
 =?utf-8?B?eHkrYzd4bE1kV3pjdFNtL1N5ZVhjc1pCQnYrcVlrZEVyS2tpdUdtYXVFNldK?=
 =?utf-8?B?b0pmNkdGQlRmMnFYeUZkUTlJaWh4cVJ4TFpkQzY4WFF2Z1dmSVovcExtM2JN?=
 =?utf-8?B?VnA0SXQyY3R2TSs1bzVNblRXN2xtN1cwZUtWdmYrM2lYd3pKNzlVVUprd055?=
 =?utf-8?B?d0RrT2ltN3RsOUtuNUtWdGRpTk9vbnpKWHNGaStMazFPTVE1aVZFNkFaWEh4?=
 =?utf-8?B?M2hXZjRFYzBpYkcrTUtOczVQMHFnNHh3eStUN2FqSk9SZ2dQeGFoUTBmVkln?=
 =?utf-8?B?M0t4U1A3V0tXM2tTWTdrS0k5TlNZWWUyN2U5QlhoMll1NzVqSjF4N1NBY29R?=
 =?utf-8?B?dVlqUXZaYkl0VEhteVBnYjdROFk0T2EwS1pweXJlTCsrTTdMdGk3M0JRQ05u?=
 =?utf-8?B?MUFBUDJxWndUR2F2UWFhY2tLU0l0VjIzaGRsVURlek5SRC9vMmt5Rmo5MUtZ?=
 =?utf-8?B?bGNLLzJXeE9XM2E0MWNBTE5oZ0pHTU5odDZCbGxvdlRYbEwzSWx3L0tlSlJB?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6e6eed-4c26-47fd-3d12-08dd91751fcf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:50:38.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US8RCxhNvpCi+hTbCZGChs9H+MOvngQXDWKc4YJIsBT4MdluxeJcZ7wFj9y8dp4WR9c6ZsCMrCYQVEpLT7r96sJDUx6cUy5OXVNBMKePSfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9807
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

On 5/12/25 6:10 PM, Marek Vasut wrote:
> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
> is fulfilled. This fixes a possible failure in fdt_find_separate() in
> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
> end at already 8 Byte aligned offset.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/arm/cpu/u-boot.lds | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 817e7a983ae..b2109e03ce3 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -153,14 +153,14 @@ SECTIONS
>   		__efi_runtime_rel_stop = .;
>   	}
>   
> -	. = ALIGN(4);
> +	. = ALIGN(8);
>   	__image_copy_end = .;
>   
>   	/*
>   	 * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
>   	 * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
>   	 */

While 8 is a multiple of 4, it's now a bit confusing to have this 
comment just above the following line. Maybe you can update it?

Cheers,
Quentin
