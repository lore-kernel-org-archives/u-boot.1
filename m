Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBE6CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 09:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6156C832BC;
	Wed, 22 Oct 2025 11:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XDyPA6iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C3D83303; Wed, 22 Oct 2025 11:19:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EA08323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 11:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlmYpZlR9luETK9kBqDiW+psUtQVS9qIx6xjt2ERmbaUTKBJUQl7EhFpNhHsdeQSFgofO4jhy0vOZApvgEs9aN6n4nk8bZxNKp+33CybE7tbwBRJpfSEASxwH5/tecoVBt2pJrWIlNDFDCr42WQNtTVA8v6O1BfgOItQ90LuT4DZQykSgTT/jWg5tDR2eKQo0gho9Y9qXEcP7cGxfMPusKUz4TlCSWLUJ0Z6HvbsPSnjDT7AOqy8dqMs/GtAvuKj/rDQJ5jFhQ6vxgwk750P9oz+IUgFH0Ga/6sgV649L0aA3d8EEvWJuwuoZvGLCEREjHnMXwb9tWYSrIyB4hIvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzp6o7/CEcuFERq8MBBqwUtlRC/Jz11J7qqKYygb2f0=;
 b=A4TaVz0n95E4nSNNmtuH6+PC9VgsyaSpUJmylrJfdCY0djedKE9XisrW3t90wBf5KZ+7emzz1r+Tlkmel7hms1RqwQUleFx0dZmqobwtNExsh3zDw3K7p0QkPoSxK2oMAItWXh20ef3zgeMi/YIp2g4t5uPeSipGVvqVipciEBF82GQGfUah7STEPuzd5TSRUXyIhC6HQii+dz4BjXC7GA1DR+A8eEoW3K3iKiOhyxOj+Wv/aeFp1fhmgWrwGojhNz2NeUXXE3gk6tLVX94KyyySfh+I41/LcXHqUw8tXXi6qaUjFuSyJcy8cS73pIeSg8MwdZU5ZlOz8L8FlPsZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzp6o7/CEcuFERq8MBBqwUtlRC/Jz11J7qqKYygb2f0=;
 b=XDyPA6iT84gPsKkyGfwZAiTVJxhJS+Kps9PDeJ4HYZE/H1Ak5AcIzmeoelHiHCjsGBS88PvfnbBR5PQyOIxGVTSpBLCQAaIzpr23livtKo9i6RQK1QJ/aoxW2DSKelClDyO20fDMeSi7w7XKv7qcNWeFX7UdsLtPCU8h0Ld4Tpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA6PR04MB11714.eurprd04.prod.outlook.com (2603:10a6:102:526::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 09:19:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:19:22 +0000
Message-ID: <3a453e3c-9ed0-41a1-858e-84f7cad7b50c@cherry.de>
Date: Wed, 22 Oct 2025 11:19:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: usage: Add general rule for `$?`
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251021202820.1272414-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA6PR04MB11714:EE_
X-MS-Office365-Filtering-Correlation-Id: 426886b0-920b-4f6c-5eef-08de114c1653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1hLUjZDZW9RaHZDQytQQjhndUcrdU53S1IyWVdnK0NIUVBvRFJZWERuUFdO?=
 =?utf-8?B?U1FOdFlJaVZGWGM3TFlyODIzYlVWUnlTbFpsYXo0RU9oN1ZLd1k4d0NZN2xJ?=
 =?utf-8?B?UEpaSFo2Z2JPZUFQNmFBMjg3dWZzdW4yUVNycDd2L1dQQ3VoeHJnMFJ5RW0y?=
 =?utf-8?B?TGc4dlg0cGlBQlBQSzVPZUJMTmNGSTh3elJKMDN6MUZOaXdJRnc3QmtZMXps?=
 =?utf-8?B?c1hFQnBiZDlEL1g1M2xoMmVVMmtWeVJZQ1c1ZFhWeDFxVUZSQXpveWVQaEhY?=
 =?utf-8?B?QUk4NjlxY0JvWFV3NENlN2pBNlJjTDBhMkxuMkppdUhrNHo5M3F0TnZ2TW5Y?=
 =?utf-8?B?VDMwMFNQSDMyUUJUK2duV081a3RrM2JDSjVoUVpNYVBtc01aclZvcGpLaEJ1?=
 =?utf-8?B?dVIwTDVQOU9PRFVkUWVVakh4eEJROTFzYWt6RVRuVTFGZkhZMHlBOGMwNmF3?=
 =?utf-8?B?MkRKSHRjcmZyb3J0WDRlSXFIa25LakJsQjV3amFDMUorT1JtZzFiZUtPa2RL?=
 =?utf-8?B?SmlwWndwZy9aNDBXWjdvdmc5U3VDOTd2RXQ5ZzZjbmkwbWZaVmJlcVJCcW5o?=
 =?utf-8?B?K0ppUE1PTWdlZTBJdWM4QXBhS3hsWnVCS3RDdkl2YXVXQVpndDBOU3lmZEZI?=
 =?utf-8?B?MG5FRU4wRnUzc1dmSlpyK1kvbWNTbnRQSHZLMk1yM0dHbTV1bjhwVnVLNm5t?=
 =?utf-8?B?MmY1RGRweUpiNWk4bkR4bHhuTm9BR0VoWWZOUUZUZi81NkMwdFlFTlZNbzB2?=
 =?utf-8?B?RjJ6cEc4NUdwSW11T0tnd1VTUkkvNmVUTHlaUnZmU2l2NUFVSmRyQmtub0ZN?=
 =?utf-8?B?ZWtkbWxPTG5yQTV4SFBIbzV4eCtXN3ZOZWhWMmZYUjVFZW1TcGJKVFQySjhV?=
 =?utf-8?B?N0RpVWdGbG5zSFJSUTJqbjJnL1FhNFZMbTN1eUNNMmwwVGxKdUk5ZHQzcGw2?=
 =?utf-8?B?OTd4TTkzTmh1WDZFVlp0R2gzYkQ5MkVDV1JJcGxrWE1UQTlOdG1kbjZDK3dG?=
 =?utf-8?B?MnJ1K3lkWVRKT0pmUjFSOXZmUXRIRHpKQmZJQklKay8xM2J4Yk9rVzNBdWQz?=
 =?utf-8?B?VVozM2tic0h1TUltbEd6UG5lY0JKNG5QNHhrTzRYVEh2Z1VEcmZxdWZiVy9Z?=
 =?utf-8?B?Ri9ma0dpZ3QzNlJqRU1GcUw5cnBMM1NvVllSYTIzNFpEZUdITjAvbUhBSEo4?=
 =?utf-8?B?SWhnSnMyQk5lbmp0VHJ1NzlROGRWQlZ2M3RLUDZFWEQ0QnZQNzN2MHUvcjlL?=
 =?utf-8?B?Y1c2MGpPUkd2V2daMHIvQWFKbDQwdVpNa3ZkZEVrTDdJM2lnWlVITjdEbmg3?=
 =?utf-8?B?Q0RDZ0VHZUMvMWhRbkhzMnY2KzlZUmRVMEsyeElDTzVVbUlwaXZnOUhxR0V5?=
 =?utf-8?B?YVNlOC90VTlza1F4dVhrdC9GK2dTN3V4TUJuOWdjMU11bXhDWGJYRHdhRFdF?=
 =?utf-8?B?ZTZTc0NCTzBuN3Z5YlNVQ3dKbmlhenFLUmNpYjRwbS8xeDBud0Zrd3c1Ynow?=
 =?utf-8?B?U1daNVJpMDhXalhvU2NMVnNPZmFRbGJ4RDRXUkZUYWVDYlczVWQ5UVZsUlNZ?=
 =?utf-8?B?L0pnSjlvQ1A2MFUvdHl4UDcrVFBwSEhCOGZSMjZYQUptY0FON3g0d29YdTJk?=
 =?utf-8?B?cjNHSUlsRWdqRVpTbkFqVWIvUDJRRW92TzhqeTgxNEdMVDJ0anNnY29FTy80?=
 =?utf-8?B?aGlIM0JiN3RrWGQwWldyRnJza0ZTK01NU2ZSU1FxUkovanJOVDRrVkhKSUJG?=
 =?utf-8?B?cy9FNnlTaWNXQ0RhZlN5b1lvS1g3N29VWmJqWFZ6SGxSOURSYUlmV0JDc3Uz?=
 =?utf-8?B?aEZkKytSOFdRWU40eExkRE02L0tsNjJBcDY3RVd4OURoZG04WXZ2RHptaS8w?=
 =?utf-8?B?UlcvQnpmT3Z5dXN3YU95b2NJd1p2SUd0bFpKUzc5T0E2bUZRVEk5YzFDUHd3?=
 =?utf-8?Q?mq3xCSaJkQSeCaxpw2wK8SYFyZ7RfxcE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENablpjRmRlMFVOZ0FhMFFDcURRVjYyZWVTQlFucVlsdFFoekZqKzlkOHZZ?=
 =?utf-8?B?SHA0VkhZMm1SMm1saG1TYmVKYlE4aFZRaG1rRTVQNmUyalpaSWdPMUZ1ZCs4?=
 =?utf-8?B?Z1U3cWx2dlMvS1lzYU5VcG1EOTJ6WUZkbGxZRml5aDBOY05wOFBMWVFCWDQw?=
 =?utf-8?B?UE9CYjhScFZNMlNyYk1zYk5velp1YWtWMzROaGJsR0taU3QwL0E3RVB0OXRG?=
 =?utf-8?B?aUxmdXRlZHZNU3JZWUJLYVJkN3NPQWlyTmtrUnJ5WDA1WUoyQ25YNE1UU0VE?=
 =?utf-8?B?Z0FZY1B6WEo2U0ZnS0FkM3lXRms5Sm1hTFIrZU5NdkljZjNtazhKditLNEMv?=
 =?utf-8?B?dndIRHNUZzVtV0NoV2NMOGdjRWZjcXRpZ2kzamRTUXhiYjR2bmdVMzMrQU4w?=
 =?utf-8?B?Ly90YmhENkZDTE1BMCtrb3R2TEpwVjVmbFlOVDZjNEoyN3NaMmhrM0g1L2d3?=
 =?utf-8?B?ODQrNWcrVG5jN2lER3Rkdmp2R25zdmxxVWo5SkwrZTBzSjlEN1ZtQjVzM3JX?=
 =?utf-8?B?YzRXdEpFWEhzMnZ4VU1peWw3Z1piWDdVUFZ1d1hobFhRTCs1RUZsazkyN3Qv?=
 =?utf-8?B?M0Q2YkViOGM2d0o5MjkyV1JXdlhjM0dCK2dkUVpueXBJYU5zaGdMRHNMTXpz?=
 =?utf-8?B?R0tkMWJiSjgxL3oxVmNaZmQ4ckdna1RnNDd5VUM3dDNpS1lrdDFyT1ZDU0Vz?=
 =?utf-8?B?QlpQMFZnczBmdEk3YnFrV1owaWFVOFNaSFFJN0k0T3BYNUxYRHhDSmJoaFp1?=
 =?utf-8?B?RERmQWp0VU15VDd4SUNVckxKc1d3eDRyQzV1enhoeWdtb1lGUzhpaVBjNCs4?=
 =?utf-8?B?QUNFb3l1OUxYK3BVcGthNU5kMkZPNiswUHMxUVhTWFRsUFRRQzc0VG1Jc09L?=
 =?utf-8?B?encvVlVYRHFpM2xjVm5saFNKUXpnYVZsdlN4ZW1lQ1IwYjJ1VUk5NlpNcThL?=
 =?utf-8?B?eHJNVnhpNWQ1OTBycFVDbllTS1VoUjVzekwyd0E5Ukxwalo3VGNFS0VVVkhI?=
 =?utf-8?B?MjZIRzdLbVN6NWdOWU15eU54WGFmMmZLbGxFcDBCL2hsOGRjZGJ3VFJjTk41?=
 =?utf-8?B?bjZJblM0K202bERabCt2VFVuMkRTSXlMTEltNzAwck5sOWpZeExXWEV6UnpS?=
 =?utf-8?B?bWNZbGdjN2J6TWpxVjI2aEJKL3hkQzVHNGxYUHZBbGNKTXVON0c3R21ReHcv?=
 =?utf-8?B?UWFkbHBxUm9XMXd6TkxyaDRNZk5nbmpkNlZVb0phNjhRRU9SU09UTlk1SFpU?=
 =?utf-8?B?Z1BwWGhQbWtmNG9wUzJueDFGanM4QzNjaFVlYlRpLy9qY0dSMTAvQzJQeEZS?=
 =?utf-8?B?eElSRzcyandBSytiRSt5Ly95RCt3SzhPcjN5NUxvLzhtem5NZld5aXNJS1U5?=
 =?utf-8?B?WWJnNURnTTNxRlVlQVU5cWJFMVp4Vk9nNW4zZTI0Sm1pNXR3OWN4bmdrcXkx?=
 =?utf-8?B?OWZ1bVFPMWI3eHA0cUdRTGQxVEZKWkZGZ0d3OURFMHJpcURqODhxSjNLYzZD?=
 =?utf-8?B?TVUraVNtRXV3aEc4UFl4U24zdldVUGVSSHBWL0QyYk1jTVRpZFhEVnBKankx?=
 =?utf-8?B?dFdzbCswMmZUQ1VYUXBrUy8rY2NidzRPL1JyaUJUdFgrRThGVlByMk9FV3pR?=
 =?utf-8?B?dUIrT3ZKaUJPTXI1cnlRYy9FY2VEUXRnOENURE1Vb3JMZnFPQURiancwRGh4?=
 =?utf-8?B?VnRGRUdTR1Z1L2lydFpSTlBZQUZYRmJtNUxOTVlnL1lJdVNhT2lWdWR0NUEy?=
 =?utf-8?B?Y2h1MkEvdU9zalB2dzg3S2paS1dZQWVSUVVtcmtGUkJmTkpLZnB1a2ROZnBJ?=
 =?utf-8?B?VElhaVNWMUYrbnlVdkpzQnd0V1YzQXA2ZGVZRTlZR2xIMXd1ZjR6MzRLR2gr?=
 =?utf-8?B?RktJWlh2bUg1NU1DQ3lFamxRNzNBYWVycExJTEJDQ2x6NWsvVnltMUl0aGg0?=
 =?utf-8?B?TkxSWjQ1NnZubUMyV1MxdWJlOXVncEJYZURSamp5WVVjaXpXVnBzNy9iN3V4?=
 =?utf-8?B?c1lHREIwU0U2ZW1SRHZOWloxRElPc28zcTJONStZS0l6MnA1TSs0Z2duc2RB?=
 =?utf-8?B?Smh2VVE3L2FwaEUxKyt1L2VzdEJMOWpqeXVqd2NpRHFEbFJCR3JBZnlBaXhC?=
 =?utf-8?B?MmZSV0JZQXdIOWY5T2ttMnBSTXRCRm11NFFiWWRKRzVkeTVaK1VqeXFIbjZj?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 426886b0-920b-4f6c-5eef-08de114c1653
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:19:22.6027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCtmnYtLd8fw8luuOVMQPssGlqqQvZBgQlArl/+m575XX+cW1dpQCqz2GWfzI5FxilOd3e5l9d2gxOiEw9xoaN31kmcTN69LkO9NCFiiGIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11714
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

Hi Tom,

On 10/21/25 10:25 PM, Tom Rini wrote:
[...]
> diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
> index 58240c5279cd..cb353975eb82 100644
> --- a/doc/usage/cmdline.rst
> +++ b/doc/usage/cmdline.rst
> @@ -55,6 +55,12 @@ General rules
>      command will cause "run" to terminate, i. e. the remaining
>      variables are not executed.
>   
> +#. The variable `?` will be set as the return value of any command. These

s/These/The possible/ ?

> +   values are 0 on success, -1 on a usage related errors, i. e. invalid syntax

s/a//
or
s/a/any/
?

I would also add a comma after "syntax".

Should i.e. be e.g.? c.f. https://en.wiktionary.org/wiki/i.e.

> +   and 1 on any other error. Any exceptions to this are documented by the
> +   specific command, i. e. :doc:`cmd/for` sets this based on the last command

s/i. e./e.g./

Cheers,
Quentin
