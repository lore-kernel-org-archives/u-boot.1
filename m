Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804E0D3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072A083655;
	Wed, 10 Dec 2025 08:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+SIYIZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417F783B48; Wed, 10 Dec 2025 08:42:04 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438FD809A5
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmHshsR3hcGJT5Bs7CdfNCJGNP1NP6muul1AaBd3bIsTqIh2DjNxFAgQK+jTeT2xXN0U9MsJ8HIYGHi3suAPAjv6QtNXTLbyZSbwS9xSXCEZ9lHAJZhIEc0/N1lvcEvg+2drFNREHbvRBTOCwO7M0QQqIMrDkiGIWuSFSqvJd9N9fmQdJS9bi2RMq3Nwr7HetogxJnTyVU8v+sFUkP1sWYynnauRzb8cEr4LJirg91mS0GxcYnD1SR9VFg/VqZ1T/jPcKf00kqLsoMYIEPK711Xk/ZO/uDjKs8V4eo3B4a+lmFzUbtcvzB1nMY9QVgSC1QGdPRX8gHPKbcyFxfvYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgwbeCA2hdVph0WHY01f+HX0kdNKcxtv+6XYNThF7Rg=;
 b=bx5S3/McnXt9R6NMchYDHcC7BrO/YbyJnQ7VQGdzYk/2qM5fJZibOaew/iRxviM16SmJwmsxtsnhy4/9sY0RO1DrvMTU1VnOB8DHEXAzAqg7M/8MXs+zmVitEpCqohIpm5s86w1ivcIfbM0vy3hJhqzymHnXMkKALj4RV9nQmgsXEhzPNthMFKldwcC2S6zM606zMgORFwuRbdg9KHPBIEL4qpdTOr0nKtoZIau5W9nWBbmKsZ0WiHqEV9VwinZ81zDu4NrQAERnNL9uwEPnlN8yWItAl2IxhsQfM6L0ufxxcwi9mb8aZInXHsiFzQQPvGce2RMDIq0tL/e5q6+lLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgwbeCA2hdVph0WHY01f+HX0kdNKcxtv+6XYNThF7Rg=;
 b=m+SIYIZwsTQedANSFRjh5lyyOkMY6zwUN/cyBsYLMn2Bu5eWCLfFxxFOuZUYg5SakejxvR8fEerv4ADs8Oc1o3X+KJrsTIT9VLFj6459VUSD27Wn7FSDqoX0yJGwZu3W7gOFjinyHvNOZNLHJ6SVfomcHr7qHjbQTkwoDmTw0+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:41:56 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:41:56 +0000
Message-ID: <d0bb740d-f4ca-4d20-9a62-0295438f16ae@amd.com>
Date: Wed, 10 Dec 2025 08:41:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9c8565-a3eb-44b7-c79f-08de37bf97da
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHJoZGtRZXdtUHExc01EWm1IOS9xcklwaStId0RaM2hVeVQ2WFR4YzFrSXVH?=
 =?utf-8?B?Y2V0eG8zVittbE5xYjFvdVBaOWJYT0szbDNUOGlOb2dEVytQK2xTUXRkbDc5?=
 =?utf-8?B?KzQxRndZMTFDMEpLMjJ5Sm56cUJBQXV6cGZOYWZjN1dVWHZFZkp3dDU2ZnJZ?=
 =?utf-8?B?YzR0a3Zyek9rcHRaUHpPajBURHV4bjFLdXFBNFFCenlWRklPaE52aFJTdXpO?=
 =?utf-8?B?bkhaL1N1VjhOLzI0aTZoM01uaXhabGwxL2lneG4vV2lhNXlDWnhnemYyUWZD?=
 =?utf-8?B?TWpKdEh2dW1BL0l1NUhDVHJnMkhjcHNUVVBHZUhyamt6aEpXWU0rM2tVQlh6?=
 =?utf-8?B?YzYycCtkYVZOUmY1RXlnaEtYa2I5RmJuTndPUVN6bnROUmI3VmtlZFUrT2JM?=
 =?utf-8?B?WDlGYlk3WlgrMzRtQmlHUmtrdHhNNHV3VGtoUHcxQldGMkZERm9SaXNGVCtY?=
 =?utf-8?B?T3Q0L09wbzFuL0NqMDZ3NE96SjhXWVk0ZDU1cU1TbVF0dXNwYlVmRURqUXAz?=
 =?utf-8?B?QmNvRVYwQk9TaXU2VXpKaHVBdmpXWEs5ejFid2pTK1RxeFRJSGhHQ2szbGR3?=
 =?utf-8?B?N2VvRklZM3lDQzJRcDFHOHdLaXdzMWVBUjBycXNlZm1qYnZqVlhhcmttMUs4?=
 =?utf-8?B?VDYwZjlQRjhlQWJJWCs5TWZqUmlkNG5Nc2JiaVZFaytONkJJS1Y0OVlIUUFP?=
 =?utf-8?B?aStsTWc5Qko0cThWUUZvWklaUTJsRGU1Y2hvWXJyanVLODhQZ1FVV01rNGh4?=
 =?utf-8?B?bE5TMEdGK04rVlVwZkwzVGFSK2ZYMlZ3WVJiWDBCTVkzNHNEVGlEY0ZObXhP?=
 =?utf-8?B?RDRlUGVUSFpITXZVbnMyakhOZDNoU2NyVFI1TGYvYm9lQTdteW1nQ1dpMmdW?=
 =?utf-8?B?N252clhqeExXZU1OSnpTRkF5UUVVbGkwbkZzWnpER0lLbnIrSUxPVDhERWo0?=
 =?utf-8?B?anQ2Wk1MaVdNZnp6bzU5a0pyUEd4dzJveWRGNFNseE1tSHVQa1B1THZCNDJh?=
 =?utf-8?B?UG1BYVIvNGVQNmFjNUxuN0ZBZGZ6TVgwZ0dWU0dacmFQUTBEK0ZoOEsvbnNp?=
 =?utf-8?B?QjllUWd2ZlNDN3NndTFyUXptR0Y5RVo5Z3I3bDhYTm5FNjlpQ0c4UWRvYUdk?=
 =?utf-8?B?NG0rRlB0cGFTelVhL3hVZDZ3azlwbHR2UmhFWkYrY2pJcXM3b291d1c2MnZG?=
 =?utf-8?B?SHBOZVQySjBQSEdtWWszQTdhcnNmUDJxUG4vYUtvcC9FSnNRdTJja1pOT0po?=
 =?utf-8?B?NjZocy96Q0NuQ2FsVnJyakJYWkFMSmhHaVJaMmFxRnk1ZHpqODc2Z1VjZjJ0?=
 =?utf-8?B?SU92VHFORUM4Z1FiMnEwRWp1a0FmazFzSUJucFZheE1aYlRRUEVQbjNtZUNY?=
 =?utf-8?B?TTFKRmMrR0d1OEYrbTNoOGlLVFZFdEFOWk5NSjB5NCtiZ3MxdHV5Y2dPY0Z2?=
 =?utf-8?B?Tk1QREZwTUlybGtVVTZPZUVpMzIxQm1QNkxOUlgxQXlPN2dEOWpTbzNKTHV0?=
 =?utf-8?B?ZmlBZWZYZEZ2Q1lRRVdQNm95anVHZlpPOGZ5ZWNMM1hUOEV6T2ZjLzllOHhW?=
 =?utf-8?B?REV5VW1JL2o4TzBhNkpOenNTNU9OMmNmY0lkU1FRc1dBamVsNWNicXhBUjhT?=
 =?utf-8?B?b1c4bnpBcDVrMXIvZDlhaGdrMGtEMFpnTjBWaHZMWWRnN0ZRVXo5UmlQL0tE?=
 =?utf-8?B?dmlJN3RKcXk2KzlQaGVCSzZVQ25OR3djUGxYYlgxRzR6clVjSE9kZ28rRWVK?=
 =?utf-8?B?VVlzMW9Nd2lsSGFkR2IrejBlSWEzekNFYVBnRlNwaHhDQ2I3WmtsRFhsbmxu?=
 =?utf-8?B?VFJ4SXUwOUNTQkowWDhrQy9QcUcxNTVnWXZpczd0ckYyc25zUjlkU3hBbERU?=
 =?utf-8?B?N3hJa2Q1TXIrMkFPU3d2bzh5ZEtQbGwxSFdISVQwM0JJZ1Jsc0NIN3oxajdK?=
 =?utf-8?Q?i6kwUnDTBTUy1qw8HV17FyjASgvN09Hi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFQ4MWJreitQdWpuQWJVeURLcFQ1Qld0cHlsM2dzRlcydlZPY0lHY1RFOGc3?=
 =?utf-8?B?MGRUQnRTaGJmeCt3SW9oZWcrc0dKWFF5dmhKWkxGWGJyUDI1L2QvK0dmUy93?=
 =?utf-8?B?cGFIREVUOVVvOSs2b2ZsdUE4anFtOU5mbmVqbzhoVG1FejdGZEtSS1dQWmtq?=
 =?utf-8?B?YXBRU3hGdEF0aEpjTHliQ1NTcWVxcURiaFN1aHpDZW00NkhjM2EvcHJsR0wy?=
 =?utf-8?B?L1k1Wm5TTDYyWkJoSXFoRmpvOGlBVkd0V1g4UkYyQUt6SUJIV1IyalFvOXVD?=
 =?utf-8?B?UDhnNm00NzR1bEJiY2YrV2I2YWRqSnNaREQrLytJZ0luWGVGN3RCamxSUXBn?=
 =?utf-8?B?SmZUbEREU1Bzd1NMU1UyMFBVTUViYkdGVWZJQ2FCTmY4SFNCZEorUVlZYktT?=
 =?utf-8?B?bVNmWWJ5VFBhcGFveUtNSDlENm53QUhRZWZpOHk5MnZDYkNJUVBuUW1VNnd5?=
 =?utf-8?B?cnJvbGJGYkQ3aTJobEFNcjAvSXRUY2Y2RFhGNUFnVmU2VjhzUUhRMmZqOG1i?=
 =?utf-8?B?cnpLMnZoeVh0OEZieVN3REx5anJ2TmQrcDZNQ3hJZ3d2Z2FZclFYOTR4cCtW?=
 =?utf-8?B?OUI0eHBJUlJocDUzOEZiWm13K1hBcFczSjVBZVQxTzMza1c5ZWNhWjRYMzZQ?=
 =?utf-8?B?TVZ0WS93ekpyVGFSUndVaURBNk8vMmRMVE01RTlxanN6MWFtd1oyaU1aY2tZ?=
 =?utf-8?B?UUxxSkM5T1BUTHZOUFlTWkxXTVNYQ2JOVHZhNjVYVE5IWERuNTJNU3oxNWdk?=
 =?utf-8?B?TWVCN3JFYjhRL2NHc1RSR2R0RFh2SmZINHpPNkE1dGJjcGh4aTVhSW1Heno3?=
 =?utf-8?B?dnptUFlLR2FLbExoeG1GNURHL2p0Z1pUZXNtazV3TXh3Vmh6Qlp6OGR1bG02?=
 =?utf-8?B?c3NnTFRlY01qVlJQSkF3czQ3dGljbWZtS2FpbVpldmhXZ1dHS0dXZXpwdk44?=
 =?utf-8?B?Qy9Fekx6akFVaVZycGhZbFE1OXBiVENiM0lnQXY0U01EanVkM2QrYjlWaXRs?=
 =?utf-8?B?d0t4MHROVSs0YnFTRkw0R2Uyd0FDMzJxdlBwN3N5UlJMVU5OZU0vblBxM2Qy?=
 =?utf-8?B?cWNHSHdWTTcvSTMzVlVHdUxyeU0wUk5KV1FKU2VHSmVxd3hwMGJzNWM3S3F2?=
 =?utf-8?B?WHd6WGlvdk5OSTYzWE1oN3doMEU3UjlpdXFERmwvZUJ5aHl2Ry9XUWVpN05z?=
 =?utf-8?B?bmpMR2xjT3N0NHpsVTN1aXBzbm1wQnRhU2c5V3VEQXRwcU43UlFBOUxSZFBx?=
 =?utf-8?B?b3dZRUJCV25teCtyVkhxMG1GallpNTc5TG5LeXlQZ2NHZWZkSi9kOURuMHBt?=
 =?utf-8?B?TFhteE9EbUZMZFVGVG54eEFWdzN6RG5WU1ZvamtoM1BTRmJuRHM0WEZ1aGU3?=
 =?utf-8?B?eGRGd2RzZHJ0ZHg0T0U4ZHA3UUM4U0JBTWNlV3JhZndWbHJaeUlwci9lZUYy?=
 =?utf-8?B?NUxoMllsbFQ0Z0pqSXI1ZW01NG82aVNjUC9lb2l4cFp1YXQxeUF1RFZUTTV4?=
 =?utf-8?B?ZWZ1RXEwdDRJaGplRGI4K0thTExvVllOY1E3QTVjSHp5NGhSREJEYjRLNUsv?=
 =?utf-8?B?ZXJoaG5zQmVWVUNGZXZ0czRuWVM0dzFMLzdoUDRlT0J6bzNBUFRPQmp6VWI1?=
 =?utf-8?B?NFJiR3E4L1hBajVBczRha2tIb0FPbkpjdTdxWXBXaXBhRG5qWUpNdktITkZM?=
 =?utf-8?B?Y2p3UXN4V0ZWYUVPWnpYS3JKazRvNS9QUkRPY1luZWJHMzBZRERxcmE5ZDBD?=
 =?utf-8?B?a29iRkxJdkV0MjkvSjFHSUFaUUZMUlBZWnBpZDlGQkJURkpWZG5oNjZad3Vw?=
 =?utf-8?B?bUhaSGlBUm54Wnd3WStmS2crWlZqZTB1NFUzUnJwcGU2bGVMT3B1QWQ5V3Vp?=
 =?utf-8?B?OE0rMHJLeUk0MkRMdFF3M2l2MjVUa24zVU5WUnJtYlJjMkF5TFBsVlJtUWxn?=
 =?utf-8?B?b0ZURkpoUUcwaVNDd0V0R1Vna09sZllTVlBtRzZtMy8zSWZlRnQ3VDYwb2xI?=
 =?utf-8?B?OHkvYlZsZkNQQWJTNjRwOVEyYjVXdXRnanhVUko3K0ROVzlxZWs2UVlrRWdz?=
 =?utf-8?B?K2o5Z1NxNlVvWHlndVZ3Mm5EMXJhSU9LL1V4cmtYSW1pZnZHOHNheTBvdm13?=
 =?utf-8?Q?SbudwApk9dd4dnYHBOoXZG0KH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9c8565-a3eb-44b7-c79f-08de37bf97da
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:41:56.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLwh9CleoTJmmvKrzakkXf9T4MnK2f60Ul9HgKgJz8/98Q005ttHxB5h0MvdsSEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

Hi Neal,

On 11/26/25 16:06, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> When the UFS controller is operating in slow (PWM) mode,
> the driver is disabled the timeout for UTP send commands.
> In high-speed mode, the timeout remains enabled to
> detect stalled or failed transfers. This change ensures reliable
> operation in slow mode, where command completion may take longer
> and timeouts are not required.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/ufs/ufs-uclass.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 3c8e4299259c..7a80a9d5664b 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -917,11 +917,13 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   		enabled_intr_status = intr_status & hba->intr_mask;
>   		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>   
> -		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> -			dev_err(hba->dev,
> -				"Timedout waiting for UTP response\n");
> -
> -			return -ETIMEDOUT;
> +		if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
> +		    hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
> +			if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> +				dev_err(hba->dev,
> +					"Timedout waiting for UTP response\n");
> +				return -ETIMEDOUT;
> +			}
>   		}
>   
>   		if (enabled_intr_status & UFSHCD_ERROR_MASK) {

Can you please take a look at this patch?

Thanks,
Michal
