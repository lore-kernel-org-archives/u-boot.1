Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3DCC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 05:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC5E82E52;
	Mon, 14 Jul 2025 07:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LgDFBr6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89B782E52; Mon, 14 Jul 2025 07:43:07 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E6382B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2jlfA6NOJKquQJyp4MPgzN5xlYvtaDglfmQLw/TPzONpJreXuRFbLDv5HDOkMfsBasCzNKOEs0Taxwv0/zYm7kUDzInEv9N5ofP6uKrLenC0swjUK5qGYR1PJG7USuaY8yLzMrRej83gNkJSqnWaAnh9gAUjAHc0/hjGlZZSHU1bgLEM3uO/RcNMZokN54UffruFzy8rAoOj9h4xqM/svNzHHSzHiTUPZaCKNxf1ZchpLncX3MFMTTJCQ3HCgYeHnSAb0cidtb8QBUr/4+ytmAutDxc3DuaL3AHQ5TlCtS2mgQsWk5ZdM7xukL+hRm4lnvO6mAr5DCcfxHPTeMNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIGkk1vYPGeSQIxRzlhkKgteOfhA4MaaBDkK7oCDMN0=;
 b=ldXP7xJOBEXygiEbhAQBmVB9WywYx4AVouaQGhKV0wiQFpCbwkiTZJ97k+X5uMr50Q1iQHs0dkGgyJYhVL61fRfKinx4EgjqeVf194mNpgSeknPa+iQkIYIb0AQBFXwVAz6oEMkguBYYgv2JnTiC2A96O1vv6rDR4rfHFmq2LmRFHBu52XWrWd6Cbkn4VVSDanyQAVHgtBiClcEv7jElKaRCc4vlYfeFj0fkkB9SUud0MxC4K+biIdR2w6rDT4x7i5jDMXJPmJtmjy15wdzWz1fPw9EAOEQ9MStXSFa+Pac7ZWNx/I/qX6/bfAJimCwtGrS/ZHMAc5Ph3mQnE0r9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIGkk1vYPGeSQIxRzlhkKgteOfhA4MaaBDkK7oCDMN0=;
 b=LgDFBr6Ns60u3RSbOioFECmiJnnxps03xFJy9ljeH35zy8s19PijFXw/4GfghdSmtXAD2DnRB+LW4dXZoDzum1ViuzcSYQnOowIw3PDaRbTpSEjQFNmsBYqLAw31OfXkwFDFa7ZHs1e2dz+Q8NG3p8Sm0J6vzaRUyKUrcUSy5qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 14 Jul
 2025 05:42:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 05:42:54 +0000
Message-ID: <dc1f5324-8927-4aca-9108-da4a24b63a83@amd.com>
Date: Mon, 14 Jul 2025 07:42:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
To: Martin Herren <sputnik@on-the-web.ch>, u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20250712082540.14091-1-sputnik@on-the-web.ch>
 <20250712082540.14091-2-sputnik@on-the-web.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250712082540.14091-2-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0de81e-9ab5-4c55-159d-08ddc29947c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2hFa1czRXBMT0RjQks0bUxPZXh4YXNWRVg0dVJQUVNhbk9LVXd6RmRXTnpG?=
 =?utf-8?B?a2JSTitYd1NtcHVKV25saDRpTWgxRmdLL3doa0IrSlZMb09QcDRqb2RxRnhQ?=
 =?utf-8?B?d3B6NHlTam95YTF1SWgxWnVJQ25UV0tPYmJPUE5ZYlZUamRTSFBreE81Zzll?=
 =?utf-8?B?b2Fick1sTHk4QTNuL2ZTbXQ3bHNNVUVJTkVTM0IydlRQeldBWlNFU091K2N2?=
 =?utf-8?B?WFU5ZUdtdi9BbnhPaUliSm11Y3ZPaGVjTWtIcldxejA1bnBtRnlPaE5VMnJx?=
 =?utf-8?B?My9yeTdaM0cwWks5dnNVUXkrRFg2NXoraXh5d1ljejVnZDhQbm9FS2Vtb1ZK?=
 =?utf-8?B?b0pnTndrS1BxS01odER3MXBtS3BNa1J3dHUzejc1Q1VaWjlHVy82OXgwNjJz?=
 =?utf-8?B?MlJYMmNwZ1RDRWFQQmFaVHNuUUx3QWVJMjBkeVNEVXlTWWZNd3lEUC96L1Zl?=
 =?utf-8?B?eGpyL3VIZExnS216VDAySUdja1NySHkwVDU3QzdXZVBMWWZEMWZmVE1iRHgz?=
 =?utf-8?B?MGtuSjM5VUF5cSt5OHk2SzZwUUdpeU4xZWxvNUl5RkppNWJjUEtnQVY0UXJa?=
 =?utf-8?B?V256Mm4zOWpFSXRxQ3hiQWp1SDZKekxRNDZLWDVlUkZKaUhEby9oczhZaFJi?=
 =?utf-8?B?NVEycEt2VnBmR2VhdENvdG92WHFpOVM2QkhxN0VNaHgwdXNWTTZ2dnBVUHVp?=
 =?utf-8?B?R3Y5aytZRWxyRzlaOEZQR1J4eWJpOE9iZTRtSWF3Y2FmQ0pOQU5DaW1UdDh2?=
 =?utf-8?B?cWNkbVlZOFAyV01TeE1IMWhUQkQ2ZEg0bzBmK0FtMGhwVEVYRGFJckFtWVZZ?=
 =?utf-8?B?N3JkUFpsYTh0cWRBQXJMOTdHb2tOaTRYbnlCdXBIZjFzQmJMWExqZFBLcUg1?=
 =?utf-8?B?V05TYllZT2pMN29EMnJEQTBHekdldEhWN2ppc1pmeDA1eHl5ei9wQi9mL2xz?=
 =?utf-8?B?aUE2VHp5VWN6VkJHbTdBamZCVVU0WjQ1RUlqejRlSk9zYnlnTlV2Z29mdkxn?=
 =?utf-8?B?ejRWM1YxbVJUcm1BL2llek14NkxrSDFwYUhIaG5sSTZncnRjL0sxNlBwcWVL?=
 =?utf-8?B?STU3MU5ETkZMT3NMblp4d3BLbkxDMksxZFJuUWJ3M0o4R2xTeXcwOXMrbGJV?=
 =?utf-8?B?c2ZxV01SQzFmd1dOWmxGa2hiUmM5MGNIVXJENmNlNk1BaWtTRzFlcW9zZFBw?=
 =?utf-8?B?TVI0VmE0eHJ6SXIyaU5GQm80bU80MWd4Z1ZMRWVaM2FyL3VKYmFUc3R2R0V1?=
 =?utf-8?B?Z0luQ0YySkZHM0lpM3c5ZUtsdFpaUVloUzR2L3lFK2JZUDNYdGhSQnpSYWxk?=
 =?utf-8?B?aXRtamgzRXZXbVVWb3p4NFZDdnB4TTJ2THVaTjdFcXZPOTRkMG5CNll5VjRh?=
 =?utf-8?B?dlk3UVpSYXJwdzN3NG5Za2tVVEJwUFNUL1psRDJMUnIxdkNQZDVDaHMzUEx1?=
 =?utf-8?B?cUUzcm1tZER0Wlc2dzFKRGxyTGlDQUVsZXU4cTh4Q0NTZStWZEJUeWkvS0Q4?=
 =?utf-8?B?ZlhlNXMzRkdTY1lxZkdHTEFjbllXRG41N0pucG00WUtSSzVqWlE0WkJwWFJV?=
 =?utf-8?B?ZnVuSTdVYk5nVHF4YmRnZFNReFF5dVFkQlRGajQwWW9OS05kbWhHeDA4VCtl?=
 =?utf-8?B?eTNCVXJMRWl6RDVhQnh1TmJub3BicDY5ZWZ6ckdKTHNzNVdJTy9sT3dITXla?=
 =?utf-8?B?clZsL014OGFOR2JWMHh5czkzc21yNFdEQnBlUTNGRlNuZFpNTGxsV3RDblNG?=
 =?utf-8?B?bzc2YkkzbVphVlFGMXZ5Q3NOdnZleXlXSTQxVHdYM1FNYXVYdnZncnZ6bFFn?=
 =?utf-8?B?SC9UU25iaTFaVENQWDhXeG5uZmtUTjB2dW5tSW5lNC9jeUQ0ZUEyWkhRSlQr?=
 =?utf-8?B?ci96eHdyM2ZEOXJHZWRlNEhHQVpzcmNEWGhjb1JHOG1yYmhkRFFxdnZSODJY?=
 =?utf-8?Q?F+AKpehVKiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGczRXJqTC9LMkU4VldGTUpPN1NTMjEvQ3R5Q1N3Y0NJbmxLRFpqc09zdzg5?=
 =?utf-8?B?YUxCK1IwL1VXckJMbkw5bUY4QlhyMTFwbHQxRGxsQUNKNGM5L2gwTEc5blpm?=
 =?utf-8?B?TVlBbmxXV3J3UlN6V2xGYVpLWEhvd2c1amU4Z2xLVmpFN2U2R3RLb3VPUFFh?=
 =?utf-8?B?a3NwSnlsa3lFUzROVTFwWTdaOFg0WXBteC9QYkpqYWpHRGxuTzRYQ0JndGk2?=
 =?utf-8?B?ZW12VCttbW5GN2RpQkJJdS8vdkQrSGxQcjNYanRmTGkvaW12aU1QSDJGMFY5?=
 =?utf-8?B?bDVhUTRSRFJIWEhkdFdmaVBCcHVYNnI5NGFwVWV0alZiYUx5dy9tVFNqLy9Q?=
 =?utf-8?B?eUdBWG9sTlZNT3g4YzllcllvR1JKdXVlVlZpRXNwWHBrVkk0ci9MMkJFS09y?=
 =?utf-8?B?U3JscTdrT2V1ZFFtcnFsQ0RtU1I4SHRNbENnbm03ODA2RE82Tk9KZlN0S0Fa?=
 =?utf-8?B?SGZHd3grZWtBSzVvWDdCOTFhVUlmN1ZHUWd1eWNWejV2ZEVCT3JoMVRoTGdR?=
 =?utf-8?B?UVVGdEZ6c0c2ZjNTekwrVWs4TERZaDIvVUtodWV5MEw4cDZ6L0FpeVJwOUtW?=
 =?utf-8?B?c2lwaEJydC9yMjBSUnF5UWVielhjYnJDZ0hWeWVjQVYyZVRtRS9FT1pZb3BU?=
 =?utf-8?B?dlpRckNxL0NjNDFUMmNtcUQ5NGZPMVpBYnZ3OFVSOWRwUC9aOEoyb09pT3Zp?=
 =?utf-8?B?L0tYVWlXNGJoc25NczN5SlpBZjRieTIveEZPUzFuRWs3MU02cHpaMVZlVU9H?=
 =?utf-8?B?TGI3WVZ3NXA5WTVtbVlmL3QxN1ltZzlKaHpJTUUvd29xZE8ySW56RnhqMzZW?=
 =?utf-8?B?ZXE3VGVZZkF1OTJWOFhDUjZZKzNVc21WWUw4azNjRCtUZmU5ZkJXdXFOdVZx?=
 =?utf-8?B?SEtBV0pHbHZMOXVTQU1RYUdIM0JmK2thanp5SGlpWWZObkUweXVKSkF2SER2?=
 =?utf-8?B?OVpoTVZ2MmJDa1RUMGIrdkkvMitXTzBUZWNFTlpvSzEySk1WYWEyUGZqQlZG?=
 =?utf-8?B?YS9lUXdSdHhJUjd0WmM4ZVBSSEtkUWRsZURIMlVnZEE0ZG01Sm1UcWJlVWdz?=
 =?utf-8?B?K0lXUXdoVXZRSmp6RHVRUXROSDdjUDEvMzhVRnFlekpvREEwWXJXNGw1elI0?=
 =?utf-8?B?TWdacFM4emR0YXd3T3dOR1dwY0FxV25TR24wTlg4N3ZHbUpnY0sxeFBXQ1dE?=
 =?utf-8?B?dTV6My9Nc1NvVDlLOXRjR3l6NElodU90OFpJbzNLM1hKYW1qNzJHOXJPWFg0?=
 =?utf-8?B?UXBzc3VLVDFmOG8zMnBNWlNucmtkR3Y2ZjZFZ0xBaVJDbGlEeWlncEt3cHhL?=
 =?utf-8?B?V2VINTFiVjBpYmFXdW5RVHZKdzUvVHBoVGF4WUgrWlBmWEwydncwNng5RmJv?=
 =?utf-8?B?TitjeEFCdUxBemZKckI2clJrZXVTSXFDcTNzZU1oOVU4dmlxTHZLYUFoVkVs?=
 =?utf-8?B?bXdZVGhyVXRsdUtSZE81YmkrdVhEOXRRM2cyNzRDRmtlYkxDYnhLQXJZRHNk?=
 =?utf-8?B?MWVTWHhQR3h1cHo0akdRbm5nSGVqVVJkR0FkUDNTVTUrTi9LdHBuWkRGZkNW?=
 =?utf-8?B?Tk91OCs0VVN6NTRHWC9DZmpwNys1RjRvQWVFemVJZGJqelRqQmlhdzJ1VzBq?=
 =?utf-8?B?Y1VUWmMwT0JVcGU2Nk80OENUaWFaTVNkaEJaL1JKVlhXbkp6UnFIbzU2UFRE?=
 =?utf-8?B?eVBydHo0ZnB5VVhQWXNwRU9ucWFMWlV6b2V2NlZCRXJmd0VxaEtHZGF4VHhk?=
 =?utf-8?B?RldOeVhLVmM3SjB1SkVsVDU1Nm8zTjNjcDFTMFRPV1BSREp6V1dJd2V6Nld0?=
 =?utf-8?B?d2hWKzR4Tng4V1dSaVJJancza25oZW5lanhiN1VLanFVK2lDTFIwNytxckg1?=
 =?utf-8?B?eS8wVFNicVVNQXNldGdJNDhxWmx1bjBTUGVUakVUbUNyUjVmWU80Mkk4VjlJ?=
 =?utf-8?B?M3psYUI3elBlRHZjNWV4VHNIVlgrakZRNUFNZ1VUWnZReFlHRFZMRHlaVHFL?=
 =?utf-8?B?RGwycEQrSmN2eW5mVnAyZTVLVkdUcXFKWm5ZdWY4MWMvR0M1R05La0MxMHVC?=
 =?utf-8?B?QjArOFovVjZZdXAvRFAxblA3cFlhYnhBK0lsWjBaWTF1cnpDQWE4ZU1samRt?=
 =?utf-8?Q?PPV4MGjjyl4hnGulpBTsy7Cco?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0de81e-9ab5-4c55-159d-08ddc29947c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:42:54.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tInTu3gZKnvJtE4GGDRnobDWl1/gfEuiSxhj8LoD1HtHN5SxhviYKgSPm5NLbA1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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



On 7/12/25 10:27, Martin Herren wrote:
> For all riscv defconfigs that use the current default value.
> 
> This is done in provision of changing the default value to the most
> common used value of 0x4000000.
> 
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
> 
>   configs/k230_canmv_defconfig            | 1 +
>   configs/microchip_mpfs_icicle_defconfig | 1 +
>   configs/sipeed_maix_bitm_defconfig      | 1 +
>   configs/sipeed_maix_smode_defconfig     | 1 +
>   configs/xilinx_mbv32_defconfig          | 1 +
>   configs/xilinx_mbv32_smode_defconfig    | 1 +
>   configs/xilinx_mbv64_defconfig          | 1 +
>   configs/xilinx_mbv64_smode_defconfig    | 1 +
>   8 files changed, 8 insertions(+)
> 
> diff --git a/configs/k230_canmv_defconfig b/configs/k230_canmv_defconfig
> index 47fa1add2a9..ed49a42b6fc 100644
> --- a/configs/k230_canmv_defconfig
> +++ b/configs/k230_canmv_defconfig
> @@ -4,6 +4,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
>   CONFIG_DEFAULT_DEVICE_TREE="k230-canmv"
> 

likely this newline shouldn't be there.


> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0xc000000
>   CONFIG_TARGET_K230_CANMV=y
>   CONFIG_ARCH_RV64I=y
> diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
> index bb110225488..8616780f2b4 100644
> --- a/configs/microchip_mpfs_icicle_defconfig
> +++ b/configs/microchip_mpfs_icicle_defconfig
> @@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFIG_SYS_MEM_TOP_HIDE=0x400000
>   CONFIG_TARGET_MICROCHIP_ICICLE=y
> diff --git a/configs/sipeed_maix_bitm_defconfig b/configs/sipeed_maix_bitm_defconfig
> index b2e21c7d7ae..c21cdace328 100644
> --- a/configs/sipeed_maix_bitm_defconfig
> +++ b/configs/sipeed_maix_bitm_defconfig
> @@ -5,6 +5,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x803fffff
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0xfff000
>   CONFIG_ENV_SECT_
> SIZE=0x1000

This is broken.

> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80000000
>   CONFIG_SF_DEFAULT_BUS=3
>   CONFIG_TARGET_SIPEED_MAIX=y
> diff --git a/configs/sipeed_maix_smode_defconfig b/configs/sipeed_maix_smode_defconfig
> index d838b252d53..3c77e40e47e 100644
> --- a/configs/sipeed_maix_smode_defconfig
> +++ b/configs/sipeed_maix_smode_defconfig
> @@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x803fffff
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0xfff000
>   CONFIG_ENV_SECT_SIZE=0x1000
> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80000000
>   CONFIG_SF_DEFAULT_BUS=3
>   CONFIG_TARGET_SIPEED_MAIX=y
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 7dde2fc0a8f..dfcc51cb8e6 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
>   CONFIG_SPL_STACK=0x80200000
>   CONFIG_SPL_BSS_START_ADDR=0x84000000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SYS_BOOTM_LEN=0x800000
> 

This is also weird and it is not even in the file.

>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFIG_SPL_SIZE_LIMIT=0x40000
>   CONFIG_SPL=y
> diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
> index b96b02c6125..0b14c7ce4c0 100644
> --- a/configs/xilinx_mbv32_smode_defconfig
> +++ b/configs/xilinx_mbv32_smode_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
>   CONFIG_SPL_STACK=0x80200000
>   CONFIG_SPL_BSS_START_ADDR=0x84000000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFIG_SPL_SIZE_LIMIT=0x40000
>   CONFIG_SPL=y
> diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
> index 77fcf4d6865..a437895b5ab 100644
> --- a/configs/xilinx_mbv64_defconfig
> +++ b/configs/xilinx_mbv64_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
>   CONFIG_SPL_STACK=0x80200000
>   CONFIG_SPL_BSS_START_ADDR=0x84000000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFI
> G_SPL_SIZE_LIMIT=0x40000
>   CONFIG_SPL=y
> diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
> index e53c0771baf..87d1d17d5b9 100644
> --- a/configs/xilinx_mbv64_smode_defconfig
> +++ b/configs/xilinx_mbv64_smode_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
>   CONFIG_SPL_STACK=0x80200000
>   CONFIG_SPL_BSS_START_ADDR=0x84000000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFIG_SPL_SIZE_LIMIT=0x40000
>   CONFIG_SPL=y

I think your patch has been broken on the way out. Please fix it but your 
patches can't be applied with b4.

Thanks,
Michal

