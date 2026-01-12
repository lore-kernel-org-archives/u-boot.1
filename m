Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C52D25042
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9258583BD2;
	Mon, 12 Jan 2026 08:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LcfjueSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3DD83B0B; Mon, 12 Jan 2026 08:40:31 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9B483B85
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzuhKderM6kkk/LzII8f0L15cHhx6TK/N7LgeuTTInErwr7SALVk+RrzHNqWYesCvZ+gkbviuvb+MbCM/hmZ1rMgCQQzHWs+k7wKf+GRH8h6wyiEbd5eMutdFKPv/LH082lJgg8b5ZJlu+FzQjgeY1OVGmHelkWLNv8XbgG/tKNvcu8CNEaqbwFDNwMqHvVu/wVjC9Pp38fIFcw6uw3mAkU2b2b18WQ/hmlri5A7Gf79pC9XPsr5VO3XqXuvvaTDxFQjbb7KE4GF+vL+60uAnmzhSKpDkEQTh8nlZmpCPv8oM/opLAtwgEUTmB4UIvUDyxDy/t18SLr5MeffNHOO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVVTXrmj6toqYzQnJw23B6EwaEQM2l/XMymf6eXof5w=;
 b=x7oxGVFth8xgVC0ucRQORC/PaE34w6Wz7FKjaI6I5V3V4LwdM061fAekrW3AwNtQuFjErzUD69QLuc9Wu1y2IXpINNAPMRck9MUc+oCWnPFTbbxrqF7NZAxhjOV4PrZQNSOh3BIiF74uBFa7niOe+BwhW2OkfdFY6nArELcgR+FKUwBauqGRydaJyQgU3C2tHYjOSrSRxu2CGpa33u1rmDPIdIMulhAJQ7uo8OCbhAdzm1BKnXabeGk2jp4SozbIeb3Cs0UIE/ImJmv0FR0zOq+oj1OiDilDPoM2dSNMJ84krXI6gbkWaaI5zJolvaO2Xf1OBDvLXZos9koZOCsMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVVTXrmj6toqYzQnJw23B6EwaEQM2l/XMymf6eXof5w=;
 b=LcfjueSJ5VQBYHUP5BzAISaaTsW+DP4gm4b/ZXgX0ENXyTrFKkYD6ilCNnsXa+TU6MpeDElW4eFe4QxmqDPaCfTdkH4rayuKrUpHCDp/kfGNS3Aj3wY+FopR1MNzicjvadDivpqcnPGTEAc9PctOgYQ+P8WttDSBZYsJz5OTlk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:40:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:40:25 +0000
Message-ID: <602f0efd-c408-4cb7-a527-e7139ff9f3a9@amd.com>
Date: Mon, 12 Jan 2026 08:40:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: tftp: Do not write past buffer end
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260109-tftp_fix-v1-1-64bd50abc72b@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260109-tftp_fix-v1-1-64bd50abc72b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 93574e2c-3436-4529-7941-08de51add9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtucTF3bnlGcUpIWDcvcUJPczhuQTJWSGFxYmZwV0tTZ2kwd2FRVkx1ZVpS?=
 =?utf-8?B?Q1ZZMkpyY2xXN2QwNERHWE8wL2hBb2N3RUM4MkV2amVBdCs4SmpWaHpicnNX?=
 =?utf-8?B?NlNPaUdHOTBZaWhmdXg4a09waEk4NHpTMm0xQjlldWZCcWorSFV0ZXgzWnI1?=
 =?utf-8?B?NjY3ZGNjK0p6amtEazRvRzROQ21seWljazJOemxEY1hzZmJpKzRoRHlEZ3da?=
 =?utf-8?B?NzJuOUVHNW1zYXUvc3FzMU9RR0ZVNG5rMW1WZzQ1eWJzVjVXL1BaNnhHdTcv?=
 =?utf-8?B?eituWW9Ra0FFVEVUQkJ0OG5RM0s0UDAxZUZkT1FNZ3h6WExrb0xPcXZ3bGE5?=
 =?utf-8?B?STU0TEdKeEtEL1lZRExsVHNHZ2hFU0I1bU9yUUJxak5GZ3dFY0VlL2VFUW5m?=
 =?utf-8?B?dm5kNkM0eW5CNzBTcEUyVHVFd2Z0b3I4aTJLL2dxakFvU0hLdWdDYkxPaDBN?=
 =?utf-8?B?aDBkMzB1M2FyZDdDU1lyS0Y4MkticnZrNk1obm9LZjJJa0NMSU9ERGNndmpo?=
 =?utf-8?B?ZWRReFZyODZLT2RVdHNhU0NXSUJpcVJ2RHQweVAyL2tITTMrWkpLQkI2dUNt?=
 =?utf-8?B?TDdkV3Z3TXBUR1FmZ1hFSDkyazRDSktVV0NpcEJpdWl5aGFGYmRYZ0hDZzFI?=
 =?utf-8?B?Wm4xYWJxMHNkMXc2TFpzZ3FqQTdSWXQ1RVdjZ0tJUXZXbWZtakx0Nmg2dGs3?=
 =?utf-8?B?NzRDU3p1UjRXbVRwUURGOE95dytwL2RIcGcxaWhJWEhRVklERkFKMkhkNS9q?=
 =?utf-8?B?dnMwYi85eEZZWEYzVUV2cUxjOFlhcHhoZGJGZmVpQjRLSVl0b2Z5Z2Z6Q1g5?=
 =?utf-8?B?TXZ0d0JlTExBcUFjWkJ4K2FQbkljL2srRlBlWmZZQTFkc0xvaGxRYitPemtz?=
 =?utf-8?B?K2Y0bFhXVGR2VlNiUVpxc3lST1FsVFU4MlNoMFlSaVNBSkl6eGRiaEdFY0RC?=
 =?utf-8?B?RVJwRjh1NzlvSVRaTUN4LzVsbDRUcjVsNEtwOWE3eHhBLzl1RTY1ejBWUkla?=
 =?utf-8?B?UkszNUY3V0FSOWttTzNUQk0wZUdibEtGY0NReVc4RytHU2V6eE5BbXcrbjNY?=
 =?utf-8?B?aHdhVFMyS0R6c1hUQjh5MGpGL3VockNWUVhrbGs5d0N2QXVlQjRveURhR284?=
 =?utf-8?B?U3ZST1Avcmszb0hneUhvSEJTcmdnRjhUUUpIa0ZJUzVLV2RhY09FZnZBV0pn?=
 =?utf-8?B?UWU2dHd2bEs4WG9IT3NDM0ExYTVOZjZPOWJpTUovZWg0Qk96Wlg0WDBEU1BV?=
 =?utf-8?B?VHhxY3FJZE02ZFFwVzNXK1RUUlo1Rkl5WVhJMk5Renp5RlBHendIbjRjOC81?=
 =?utf-8?B?U250NlR2NTR0MnZreHNrWEViWWNhbGs5ZTJRWVppbnp6TG1sbmdocGFWNE5C?=
 =?utf-8?B?VEFWSDJIY2wxMHVvQmVUNFdyVUVBanc1M3o3U0RaSTBXMlQ5RUdmSldwUHpo?=
 =?utf-8?B?SFZkc2RiRERGdmdyTEhEREpkcFdtajduUmVKelNBRUM2dkNaN0VNUW8rTFB0?=
 =?utf-8?B?MG9HbERERm12TkZyd2FaMGZmclh2dGpNQUl2S0hhY3Vza0kxMWp5N21UN056?=
 =?utf-8?B?cTR0KzA3Z0pWcHdTWkp5VGxXQlZiTFdyOUppaVdPOUdMMjJsOFNpbkx0RmpV?=
 =?utf-8?B?aDZlUTkxV0V5OFhVQ1JqYjNmL1lmbE01VlY4VHdwblBHaWtqcmZiSUh6MnFY?=
 =?utf-8?B?dWlSQjcwZEFVWVhlQjV5Sm11OERHS1R2UEFQZFN3a0NOTXNIczAvRXFZWXZ2?=
 =?utf-8?B?dkU3SkpPNmJaMm9md0xSWlM2dWZqZXE1Z0hrZHRpVzJYd1daYzVwakxoUTcv?=
 =?utf-8?B?a2hPaXlQOEtLR1ZBSnIrbGVpa3YxdVdZWUFmWmw4ZTM3bmlNTWNuenp2em9Q?=
 =?utf-8?B?RkhSK001UjdWdVNmMm5zVk11VzhLWDBMVHhMem9DUHNPWmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1OWVk4bXFYL2NUTEdSellzZ3RtZFYzL1Q0bUdRRmVqYjl3eWpnbWljN2N6?=
 =?utf-8?B?OGFmNlNEcXhaaXg3U1k1ZXNjVXZJaUlVTENsNDlOTEhMdGJtbUkvMGlCc2Js?=
 =?utf-8?B?Z0MwSDhCRG00UjBrUnd2Q0xtS1JJSFpTZ1RBLzZzYVRDb2VtS1lRWTNuOHBL?=
 =?utf-8?B?VmdoZjlRaDFrM2hzQThNb3FyQ2dZMTBMWlJCVEZiTElleVJpZU1lMHdWU2U0?=
 =?utf-8?B?b29TbUEzU3dYdStoRURObHhZellHK2JJT2Z5NG80Mys4SEFnOC9zNjk2OGt5?=
 =?utf-8?B?VVpweC9CcUl0RWI5Q3hLV0ZEVWU4dW9xOFF6aHVDNzVpOUlCb1FuUU8xNC9R?=
 =?utf-8?B?TTF2SXFManA0MUR2REs3TlV5aDdpd3piTEYzb2xtYjdzMkxoNzk5UlJBcnY2?=
 =?utf-8?B?N1VUbTlUWWlzNTF5eU50WnJ5K0ZZY3FHcEduYXlYUFRBMGU4U2pjSmRhb0ta?=
 =?utf-8?B?bVJwaVRuTUdKdGxkMGlRUFFzbjF2c093a290VGFrRFF0Ym5RUEQzRFRWTFVL?=
 =?utf-8?B?SWdINEtWYUYvNjU4aWdwOXNuaDVGTjRrRjRVd1lBY2Q5Z1pYbE8vTGkwSVc0?=
 =?utf-8?B?alc5czR1alNNbXBtVnNzWittamdEOXhiTWIyNVFuQUE0SXVUVG8wVk50WEVB?=
 =?utf-8?B?K0NFcFNrMm5GVGFLMHF1ME1VQkVaRDJmUCtJc0RPcGN2RnRnd3VTZm9OSFkr?=
 =?utf-8?B?dEZWZyt5NldtT2I3RWNFK2tkSlluVUdOWUo1dWJrbFBObm9JbWhmby81Lzd4?=
 =?utf-8?B?UUQwN2Q0MzhEYTJlVmw3VjhTeGpVNCtwSUd3YmNNQ0hmakF4cW9sTEdSZGw4?=
 =?utf-8?B?N01hOW01QjNmTVpuTlh4OGdzNE4wVjFjZG9OSnE0OWdLZ0Vxa2NPblgrQWxX?=
 =?utf-8?B?b0wyZGN5a2dXVUpxQjlyWFpPNElIc3RRem5nWnpuYTNhYk9zbVpVMUZONVdQ?=
 =?utf-8?B?TDJnYUIzdzdZN3hYcE9IUUJsMEdWU1laZWlaMWZFUWdvVE45L0RQUlJXMURM?=
 =?utf-8?B?OTh1S3dDSkNRUytmRkdoVjVIVG5KMTVlanQxWk1Hbi9HV0dWeFVGUEppcjZM?=
 =?utf-8?B?Njcyb001SkVlNWM3Y0VGczFqWjVjSDlVTEl5QzNZS0RrU0xhdVFpQVVrbkhK?=
 =?utf-8?B?ZnJYRTNTbHV1SUZZajlYMGtvRk5XWjUyVzNpV296Sm5tVWttVkY1U2lEYXFB?=
 =?utf-8?B?NmZ3dlNLd01QQkorbXBSZ0NXQUQ2NG5ENTBlYTFGUUpYRzJjRE9tOGVPdms0?=
 =?utf-8?B?dlYyY1dHQktsaDgrdmMzT3FJS203ZHFwS0llK2RzNVVmcUhQSEJVZVBwNTlj?=
 =?utf-8?B?YjRvTW1sMVkxZm43RzdEOENIQktTd1F0NUZwL3NETjZPUHpyOE92SHlOT2Nk?=
 =?utf-8?B?UG5NUzYwbzVSc2pJUUw0ZklVaVVocW5uVUw3SFYvVllEaVBZSy9SZHgwM0pL?=
 =?utf-8?B?TVFQUWYvdi92b1dxTUtGdU43R2ZPbjI3QVBISE1DTGRJZkltWnp3ak1TK1Z4?=
 =?utf-8?B?OHRuVWk4UHJhMlRYQWpRMjVXTHZYL3Y2TU1TNG1XMk9IVDBXb1hTTkwvSnVN?=
 =?utf-8?B?ZjliMXVrT01hL0c0K2pwR1h0OHBDdjh4OWFMSU5nQm82Y3VocEZVYU84cXJa?=
 =?utf-8?B?VTY2QXFlMHF1SjZqM291Z3NRQmFMTi9IYU5PMWVQSURUMWtCdHY0RXBOWG5R?=
 =?utf-8?B?ajFHUXJURi9mcDNlYTNNTDJ5QXdIeUNHb1V2eWYvamJnanRSeG4wQTlGZ0lY?=
 =?utf-8?B?S01JWGpDbytGWnZSS21IQmU1MFdZSUZ4Y1lZMXBleXFFaDF6ZW9RTC9tTXpN?=
 =?utf-8?B?bjQvMk02blY2ajFiMzJXNmdWaDNWQUlnZ295VmJRaGhJRVY4YTdvaXcyMGZX?=
 =?utf-8?B?ZW9pVHFqa2ZWTGVWSGVhZVhJd1RZTHRSTEI4YUpNRUh6RzV2RnpuakVJVkxH?=
 =?utf-8?B?T0dsb3hOcmpyUnY0a0FsbXRqY1hhcHRCeTdreEo3OTFTNnJtZUJlOFFjZ1kx?=
 =?utf-8?B?TWYxY1VzVGozWEpVUmNuY0N2eFBIejFtVUJ4T0hMUC9RV3NhU0xQNVl6aVdo?=
 =?utf-8?B?NzF3aGFHS1daNjQ2OGlQSkUxdncwV0l1VWkxMklWb2EwY29nMThZbThqZHRa?=
 =?utf-8?B?cGRLTWdKdEVicUhnSEwrdHVycXU4NEhsbXBNc1ZRamQ3aGZHbWNsWlMwRDdk?=
 =?utf-8?B?R3lkQkpPR3N3M1pTbkVrcDRHRWpIN1Q2alhKU2tkY0ZSaUUyVUtSd2JCWjI4?=
 =?utf-8?B?R0FlUkM5eWdwdUtVTGlxRDdyY0I0RTZmeDZnUTZxRFZBS0JmOWk2ZFkyU0F4?=
 =?utf-8?Q?A/pjofaYqTsrbq/jGB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93574e2c-3436-4529-7941-08de51add9a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:40:25.7166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xb/uXkYbf+uXFzBQnyZK71FiMraNvLnANKQHyu9C9uvRzDNXDALlZOYHM11jnGlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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



On 1/9/26 16:56, Andrew Goodbody wrote:
> sprintf will add a trailing \0 so manually adding a trailing \0 will
> result in an extra unaccounted for character being written. This
> overwrote the first byte of the following allocation block resulting in
> unexpected behaviour.

behavior

I think it would be also good to say how that issue was found.
That calling pxe get multiple times was the first symptom which was able to 
stuck bootloader.

> 
> Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")

Origin Jerome's patch wasn't merged upstream. Do you have any plan to send v3 of it?

https://savannah.nongnu.org/patch/index.php?10462

> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index ecb6c55ae1100779187e7b138d098a0ef1e48ca1..25da952e92566cbca1c64bc89c89102e74d0a42c 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -191,7 +191,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>     MEMCPY(payload+2,              fname, fname_length);
>     MEMCPY(payload+2+fname_length, mode,  mode_length);
>     if (tftp_state.blksize)
> -    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
> +    sprintf(payload+2+fname_length+mode_length, "blksize%c%d", 0, tftp_state.blksize);
>   
>     tftp_state.wait_oack = true;
>     ret = udp_sendto(tftp_state.upcb, p, addr, port);
> 
> ---
> base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
> change-id: 20260109-tftp_fix-3ab9bd66a6ad
> 
> Best regards,


With above commit message fix feel free to add
Reported-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
