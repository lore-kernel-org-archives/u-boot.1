Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21836CF318E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 10:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6472483E0E;
	Wed, 19 Nov 2025 11:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pxzADrN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224B283E3A; Wed, 19 Nov 2025 11:55:04 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C5783DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urd4Nsz4uEUVb9YjvxuSBN1Xfsk06w4wKbBOJLvSIkIGh8qOEV5efMw5F8XalnZz0MKCly6OPTj0kSssNHoQUzp0QwcfT0cRtl1YWbqoKOTb4KCxMMy4HT9CSPnmY+t/8hF28h4GJCYJqoJhKphueB/dysOMZ8XiVtWi9F8qaJNWZqyuqzkGTpjfHFA50+fFPQZ9X/MgmZlZYe+J3J6UtaKl75BJ9khBtNAzhgRMG4yXMooYJnB5RmGpP3zYAJugk0nYJsIo3KMNHHQAiVvCAn39MmJfOZXdXi5+Xs8MVXHWqevsABR06Pd/aDIGOUieAwD4A9hANXSroanV7+8vQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFc+0SDri1M86Rdz3Y+DIg0+VZhyX4Rn5n9WwhyN5WE=;
 b=DvXNdpj4ZW8zZjxFa1C8QCbeGfURJf7hKN6JeAWpHsXWyF3v8pf9lN9Omfdc1/KEA0vFIpJ24KHzr1YcZLb1iBkAJfcigFXLA+rv5S531bd56PPtgSkGNIKwAmVhR3pE2yV3kNXRe79NpBb4B9Xd5px2AQypoOmJRIhP3MHcuma07K99ELq+Q3TtkLRigjfUsJIjose6b0mEDiB71a0okXVTHePqRLkeCFDOrHYBILuKGOecTxU7makMgb3nxtsEphFUaGfR7jHVKXD3C5USJE5JQ+0+DJFjk8HLRCOLcyHKFlb2+tY2cI83mDnbX4qz1jPDvRm9SJngAMsmFH7LoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFc+0SDri1M86Rdz3Y+DIg0+VZhyX4Rn5n9WwhyN5WE=;
 b=pxzADrN5UHEk9LEMo7RZoCT7esyMh53FokWxHspVFEoTRK6nTHjhSGUisJOieUcXqJ/+5gowwFCpcOrbG53avpebR1jtqt5PQwA+NB0YOvJVaddgfLuMu5IDjjnOOu5v32z5TOmAXuMsaNoUcYJbADD9JiUttGujAGw2/7x4qBopKSmyiT2kUNbbFenN7admZU7O8WPA66Hy6M9cJ/qE/mDBgsUQjLnm3NrrTTxaJfORENfOqSF37jBoXD4XoWHNeteVdXp/GaP20JE9aJkl8RokPQ3b2utvqOxpZoVpWfDBkYrr3yCMsuUL4AJNOllKEYXRdqsWMIKZI4wUaRJOkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB5677.namprd03.prod.outlook.com (2603:10b6:a03:2dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:54:58 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 10:54:57 +0000
Message-ID: <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
Date: Wed, 19 Nov 2025 18:54:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251104223023.1613-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251104223023.1613-1-briansune@gmail.com>
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: c798ad37-2cd6-4949-dc32-08de275a13ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGVqMVJ4N09QU0lBd0QvbU9WTm1ZY290bWEyU0hBbE9Cb21mS1h5RHNnbTBs?=
 =?utf-8?B?b3FqRWFZbERmMWRiNmlkNHUveFBkdFY2RmpGVzN0TXhQMUV1MXFCTWlsaTF1?=
 =?utf-8?B?UjdUdDRQSDBSSEpYaXU1MUhGbkRrckJwTjEwYWpQZWdkRm42czFJSmJINFRm?=
 =?utf-8?B?aHZsajdhcWhxL0VCTWRUbUxobHFXU3lTRDlBZUgwRjFPKzVDbXNOclVYVzAv?=
 =?utf-8?B?VzdNbENHRi9lTzJzU2c4Q0pMYS9CKzZWbitaNjJueWIyTGVqdENzcE5nQVM1?=
 =?utf-8?B?V20yUys1OTA5NFZsNmcvMGM4M1JjVStDMXdWTTBlb296WFpjdnozZEdGWnNQ?=
 =?utf-8?B?ZGg2VXZoOEtQL0ZDZGNhM0VEbENQeHkxdWFmRmFhbVo0VFp5UjQxWkJxdVBU?=
 =?utf-8?B?bXdpL2pwSHJwOStQVS9xZEVUWjRCc2VzYWMycU0rek5FUHZsUEh1RkQ5azVs?=
 =?utf-8?B?Z1VjSy80NDBackdTeVNndkRYakliV2F6Y2I0SUltTDJSd2xkRllocjBsc2pJ?=
 =?utf-8?B?aGJlLzY4ODJHK1JmU2d4RlZXVFRtZjZnM1MvOGhISnpHUHBJV1NRczh0ZnQr?=
 =?utf-8?B?WVZxY0d0T091cmQ4RGJpQlVydWRDSVRFZDRoc3ZQeFlRck9IMStiZW55bzlR?=
 =?utf-8?B?S2ZRUGRQZUFmaTlnVWF2NHRPV1J5VXN6T1NlN2xOY2psaDJFaEZjL1ZyYk1n?=
 =?utf-8?B?NkFobmNWTm5mN29LYjVRYVlVR0hGbjlOR3BIUThYVnJiRUFEOXoxdDQ1cGhO?=
 =?utf-8?B?Rkw5OVpCWDRWRGNJNTFDQWs5LzZZSHJHQnRSZ2JiSTBqU3dIMFN6Qk1CdUlu?=
 =?utf-8?B?MCtBM3ArY1E4RlpVUW5vdkJWM1ROT0xQZnR5WGZlamVTbGhuQml5NjVxOGp4?=
 =?utf-8?B?alhMa0kycnZ4eGhWaHRQQkRQYllpR3BXVG1UcWtFQ1dldnprS0FYYzVKQ1hz?=
 =?utf-8?B?dWJjRGtxd2JYSldIKzk5S2IwTzExblk0VmxMK2NwR1ZKbE9vVWN2YjJyYUVy?=
 =?utf-8?B?dXRJb2hsa1dXL255Nnl5S3RzUVZNVHoyWXdncVNKb3U5cWd4a2tlNmw5RktP?=
 =?utf-8?B?N3UrM0VONDV4SStqZWlWSXlsS2ZCUU1YTDJIK2VUTVI2Nmd3aE5TSGhhd005?=
 =?utf-8?B?WmxSblRONHVJcVNjS0w3S09hTmxXZVlTNzMwRXRBOTA1dmhKcVdPcU53WFZH?=
 =?utf-8?B?U09tNzB4dk43aFFNT0tZa0RJQzJnZzRpaXB4ZndmcmNKWjdmNzhJRHI0Q3Zo?=
 =?utf-8?B?ZTFWNjEwMHZLZ1huanVPOTJ1cnE1T3orWWNia2gvT016dVh1a1VnK1RralNE?=
 =?utf-8?B?SUp0ZFhlM2VyU3ZKUDFTM2NicVg4dmJ2Q3hGdm9xK2J0Yk1OTHoxRXBnSmZo?=
 =?utf-8?B?Z0x2VG5Rb3AzWjhXVmMzT0FxejV4WVlHTVdGelZLRXMzREovNHMyblg2bjNY?=
 =?utf-8?B?MzN1LzlYNmMwSnFMRy9pRE9HeGpLT0p6WGtDQlYxblllMzNndWJwOHpmWHp4?=
 =?utf-8?B?QWNXN1VsU2VBYml3dFBDbFg0dUJKVG9LM2pLRUFzNVV3dWlGakx2UzRLdnIv?=
 =?utf-8?B?U3hJdHcxNHdHa3IxeWJlaStvS1B3bktzb0NudDBCTm1zZ2VISmh6dkhvZ3M5?=
 =?utf-8?B?TEZOTVhTTThBUlhlcC9sMmU4eDNmdkUwOHEwN290dUZMcC9RM2dEM0UwNXJZ?=
 =?utf-8?B?MTZ1dGZYNVBTNmRML0FZMzNDSk50NE42eW82aXZMYm51OGd0TElQMWtZTkVG?=
 =?utf-8?B?b1UrNFdRYWtHNUxvY0I5dkhjVXBJYmFHbDhoTU1MaEd1RzQxTk9lNEhHM0Rk?=
 =?utf-8?B?d0hucXhJa3ZtRXFNL1BtS3U3TUwzTFVFU0o2bHpSaG1vek1WL1BBbllpRGhH?=
 =?utf-8?B?d1p3b2lJQ1JXMVlmcHJwL1VqSUxtUFhzYXBMQVdkN21uU28rcEJPcWVlc1lr?=
 =?utf-8?Q?cc4f+3nfIIMaThL3OBZLNMudiDU1cCbI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjc3MjExTXNQV2JiSVpVWHBSTmFPT042WXVDd2t6VzF0ejlWalFFSk5PaXR1?=
 =?utf-8?B?T3lubkxtL2g3UGVwRmV1THhHNEJnZG9qOEZGS0kxeG5NeG1rNk9qdmJFRExY?=
 =?utf-8?B?aWUrMHVvTW81UVdFUDBDWVJNYXJZcG9naGtWdEEzd3NmRFhydG5HZVVYNWZm?=
 =?utf-8?B?eWxUeFg1ZGJoWG9ZKzE3a0xlU3N5UGtZT0ZTd0k5VTIyM1l5bEpMMnBlLzdt?=
 =?utf-8?B?a013eHlBUCs1N1E2YW1DT2hLVXAwakpwdVRtcW9LZTQvdTd2TXpkcHdSZjFH?=
 =?utf-8?B?WnFDWTY1YUdiWCs1TlFBZjI0TWpZTE1lQzExS3RDYmNMejJSeEZoNTVoTkJC?=
 =?utf-8?B?TmtpU3V5RG5aY0g5ZXVjcVRneEtMRDV3ZlFURTVSU1VLZzRFSncvM2MrQ01J?=
 =?utf-8?B?Y0Vnb0N5UGRTSnNqdHVuWjlmZnY3MEsrcEJVbk5DdmQ0WGV3L05pN0ZucGZW?=
 =?utf-8?B?NkxKT2NHa2phcGNwYlU0UjcwTnpySys2YmM3UVdyTGVVRjY5ZEVld3VBbjJR?=
 =?utf-8?B?WHQyNGxESmFhenJFaUhTbXl3MDRiUUFXUmRYdXFtdUNUV3ZSUTRLeHRkQzZw?=
 =?utf-8?B?dkpKVTFKNjk2QjNNYVBHZzg0ejNKNnVGU0V1OU5RYTk5eFBvZEpuLzVmUE94?=
 =?utf-8?B?M2lkdXRrUG5GUWpZeHMyMjcyUnowaElLQWhQamVzM29CNmNRVGlNRHVWTUZV?=
 =?utf-8?B?S05YQ2lOSE8wckNqS25seGxpb3pEcFZPTEJmcjRURTBnQnlhVmttamIrOGlW?=
 =?utf-8?B?K3M5MmJTTGlGL1RZalBDd0VyMGtuMWRKd1ZpTW9OOHd6b2UyajNqN2ZvV2pq?=
 =?utf-8?B?azkxT0U5M25rTkVuckNVdmZ6SzZGV1NqUlRUNlo3VE9BbTRoM29waXZ3cjVZ?=
 =?utf-8?B?U1poL0Q2anV1bmh2bHo1T1VQMlBMTDM3dHgyb044c05WMkNxcDRJK0ZhQ2Rq?=
 =?utf-8?B?R0QzeUowWW9TQ3l6bmFaUFRJR0hTYTUwNER4RmZ3ZWMyUFUrRlZaWjNDOVpJ?=
 =?utf-8?B?Z1ZpbEhQQ0xFMWNoV3FGQUFhT1dnYmZqZmIyRWZITjd5a0Z3Qjd1cm50MlFo?=
 =?utf-8?B?TzdkMGNhOWpRaGJzWVFUK3dmeFA5RGVZVDZHeWxLUkowSUJaWmY5MHZpcEhm?=
 =?utf-8?B?TFhGcGhoWTg4eHZzQUM3MC9YWVRZN0tiUGloRks2WHFBUGx0TEt3dzdXbzNm?=
 =?utf-8?B?Ujd1VnhZZ2E5L0YyUnBrY1ZjZFIxQVdnbE9VU0xvdnRKRjVtd2g2TXJkMFow?=
 =?utf-8?B?NFdSMjh2NXVoL0p4MHg0eUsxL2tKd3Rhb1VCUlE1NDU1TDVHbFZsUFRPZ0dJ?=
 =?utf-8?B?Ujh0M3VMTkZ2RmJ5THMxSDFCOHlyR3VCSFJNUncrcG8ybFNnS0tUNnBZclcw?=
 =?utf-8?B?S0EveXl6Y3duc1FDNWpFZktqRjMrT1hCOEFjWkNsMWY0QnJJK21uTGRSZ2FY?=
 =?utf-8?B?aU1MZkVYbnprMWNyQ3QyTnVFSmdUd3hhNy85Zm1lNW9kZW9qeWQ4VWZFbmZT?=
 =?utf-8?B?R1ZoNWlWa2hZNjVhMmdlaWZJdWtkQVhxZnNJMll4ZTgxem5DZWc2SCs1c1RZ?=
 =?utf-8?B?SnZiVHV0SDJHUm9PWTBzWGk0QTA2ajAvTlBFaDlORXIycmZORFNDaFVRSXJO?=
 =?utf-8?B?aHRsOUsrNDFQYUxmNDIrSWdoMFcyNzFxY1hUZHVEM1MxQVl3M1VTaDhxNFBL?=
 =?utf-8?B?N1pqUDVHSE5CYzZQeDU4cXJnWW5WTE4vMW4zWEhQMGcxSFFSSXk3aThTenpL?=
 =?utf-8?B?a2FiMXlPQXlZSE9YL09ZU1VOck5yRjczKzNVY2NBdjl5eUNxYW9nQVV4OEhG?=
 =?utf-8?B?bjVtUmdFMjZVVThlVnVOZ2FZK3dyWTBsTzlDYk9KclJhNlQzVm1xU1FWNlMv?=
 =?utf-8?B?SDdNYlJWTmJpRHVyQkdqVk1FRDNLK0FuWTFhY3FLZjJ6ZlpFOVIzN1k1aGho?=
 =?utf-8?B?V1diNVJMNlF3ODFXRTE3dkRQQVFyeDdtSndJV0NCVFBvbjNlTTljUzVhczVI?=
 =?utf-8?B?Ty82NE9QR0M5RkdaSE9KaVY0R21lamZiSXFRMjlGNmpXV2FFeWtEbG45aEgz?=
 =?utf-8?B?TjlMN09NSkl2bWVIMlJZNStnRWRjRTFGRU5ONC9yaTQ1eHl6cU5XdjFtNTJS?=
 =?utf-8?B?NmlRem55WDJyMWszd0FaRXZ4T0NWWlZucFkrSVZVZEJuOWlqbENoNXgvdys5?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c798ad37-2cd6-4949-dc32-08de275a13ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:54:57.0802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcCDBVCJfo7OP5T8fgRhya150lTQq78eKBR6zm6/dBzUp8Voe7+jye/+3A67ZsmZwp2xcSu/D2q3Vi06+2+KIRSO3V9Vyod7lVumkROJOIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5677
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,


On 5/11/2025 6:30 am, Brian Sune wrote:
> Add optimized Makefile support for SoCFPGA handoff
>
> - Introduce socfpga_g5_hanoff_prepare target in U-Boot
>    arch/arm/mach-socfpga/config.mk
> - Users can convert the handoff via make prepare.
> - Detects Altera/Intel SoCFPGA boards from .config
> - Combines vendor/board extraction into a single shell call
> - Checks for hps_isw_handoff folder and .hiof files
> - Uses ls -d instead of find for faster folder detection
> - Runs BSP generator script only if files exist
> - Non-blocking: continues if handoff folder or files are missing
> - HANDOFF_PATH user define allows overriding auto-detected folder
> - Minimizes subshells and other slow constructs for faster CI
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/config.mk | 50 +++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 arch/arm/mach-socfpga/config.mk
>
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> new file mode 100644
> index 00000000000..df1eb909129
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Brian Sune<briansune@gmail.com>
> +
> +ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
> +archprepare: socfpga_g5_hanoff_prepare


Typo: socfpga_g5_hanoff_prepar, it should be socfpga_g5_handoff_prepare


> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
> +archprepare: socfpga_g5_hanoff_prepare
> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA10),y)


You are binding the rule to:
Cyclone V
Arria V
Arria 10

However, cv_bsp_generator.py applies only to Cyclone V and Arria V.
Arria 10 does not use |.hiof| and does**not**use the CV BSP generator.

So this part should /not/ include Arria 10


> +archprepare: socfpga_g5_hanoff_prepare
> +endif
> +
> +socfpga_g5_hanoff_prepare:
> +	@SOCFAMILY="$(SOCFAMILY)"; \
> +		if [ -z "$$SOCFAMILY" ]; then \
> +			exit 0; \
> +		fi; \
> +		echo "[INFO] SOC family detected: $$SOCFAMILY";
> +		@set -- $$(awk -F'"' ' \
> +		    /^CONFIG_SYS_VENDOR=/ {v=$$2} \
> +		    /^CONFIG_SYS_BOARD=/ {b=$$2} \
> +		    END {print v, b}' .config); \
> +		VENDOR=$$1; \
> +		BOARD=$$2; \
> +		if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> +			exit 0; \
> +		fi; \
> +		BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
> +		if [ "$$HANDOFF_PATH" ]; then \
> +			echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
> +		else \
> +			HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
> +			if [ ! -d "$$HANDOFF_BASE" ]; then \
> +				exit 0; \
> +			fi; \
> +			HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 2>/dev/null | head -n1); \
> +			if [ -z "$$HANDOFF_PATH" ]; then \
> +				exit 0; \
> +			fi; \
> +			echo "[INFO] Auto-detected handoff folder: $$HANDOFF_PATH"; \
> +		fi; \
> +		HIOF_FILE=$$HANDOFF_PATH/$$(basename $$HANDOFF_PATH).hiof; \
> +		if [ ! -f "$$HIOF_FILE" ]; then \
> +			echo "[WARN] No .hiof file found in $$HANDOFF_PATH, skipping BSP generation."; \
> +			exit 0; \
> +		fi; \
> +		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> +		echo "[INFO] Running BSP generator..."; \
> +		python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \


Arria 10 boards require the A10-specific filter script under: 
arch/arm/mach-socfpga/qts-filter-a10.sh

Invocation pattern: qts-filter-a10.sh <handoff-input-directory> 
<output-qts-dir>

It processes a set of A10-specific XML and RBF inputs such as:

pinmux.xml
arria10_hps.xml
pll.xml
emif.xml
core.rbf
other Qsys-exported XML files

Because of this, the .hiof detection logic you added will always fail on 
Arria 10, and the QTS conversion will silently be skipped.


> +		echo "[DONE] SoCFPGA QTS handoff conversion complete."


Thanks.

Tien Fong
