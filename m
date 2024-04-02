Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E0CC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5568837B;
	Tue,  2 Apr 2024 15:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="VUembMOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040398837C; Tue,  2 Apr 2024 15:56:43 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2025887E9B
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQzVKfobrRww6/BV1RsibTRnqFNwNqgXe9Cz6dDCZP4/bqwbu8Yx7xAZClJAZIab3+8VezEWo09m6fvmt7W31VKCMxKZ8DdZLeDgggOhuLRjNP7AxVwWbbsK82HWdW+VGaan3rPh7rz2m5JdRrzg/QSPFnrCzMc/a86kJ1hVEdl6+y7e+8OxIb2mTppCQULVIJKoW9eX76BoEOrdqnUzPDpgrz3TeQL8nYWnIiHKjnAVrAkIqOjjn/Q6HO09PRioIoOyOEznqUJkwQ5vU1j4AcWJaus8T9YCQROkzcwUzXaoqtWKpwQbsbBUqTae5gqjbWFs7ZJaAG0/uHTDY3wOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjBdRzuw18RbEJt9ilmMEiS4y/c0prPntNVwSCuQpwQ=;
 b=UyJ1T8VagPC63Re7VkZpA/E03XLCGmAawOeC8DyqhCe7m3zryHebtrt8Am1XtsbryPFUI8syLeSCmFYxhLuI9Z5DOkZyiAue7Y9jqZF3zBzmh1zrPT3kCzE8bAqiSmf2t4hMaEZ42/kmcrWVVeqYaau271eXlpxBzHr31LUKbbsMQJ7pdAw13IyRZQ+oNhH+dTOXFFQQSO2Jcg6tpUOyVP2BqTXTcFSWPxFZtv6lPFIAL7DFb7UAJ37dxamxzCcMpcN5CXzzSvb6HjugjX6dPoa04DI4qsRDWqe+89nwsrZ32fkK6aKP0JJQNnavOpi8Yu47mTCdccoLCX5Np/VgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjBdRzuw18RbEJt9ilmMEiS4y/c0prPntNVwSCuQpwQ=;
 b=VUembMOVWgywo5WEWg/dgSlWuNSpqP5FCzoCEj4FRIaq+YRBaIibPaKVnYY4SHJZzSnbux9Q7vqlAueuKucCCXzrrrQT8e57hHzEUowHciVIFJ+6gdl5CfyUW34pStvRdmk/WQ8C0a+pKiCQk1NnVLVhIJG4JhGgKtHpiVJWdWhIlJl0LK480QLEwAwfbzYSAIw8uLfHxaJXKdRbWnjlht2QbunvVlXgHOs45rDHP9RYv95nPe/P0jx/sQSMLkrk5NEznoLseb2IBigh59aUtf+eqjUa49cPHF6A6tE0TI40wUTJ9KhaAgjdzZHjezxEOKTSDjo32z15onIiUfcpSg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8882.eurprd04.prod.outlook.com (2603:10a6:20b:42d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:56:40 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:56:39 +0000
Message-ID: <1dc6a00e-4278-4549-8bd7-2d90f98e3786@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:56:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/31] rockchip: rk3399: Enable DT overlay support on all
 boards
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8882:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVLUuzT0JUh1Z81B6iQPgkPKK1y9xoQj0l8yO3DjuHVUHGZVHkgbptDtkIMI59aW69Z7RadSVVzcHQkRicRs2tbK+B6P7fY7ixdmKxe01fmq/oPcYvgSqHeOprEwS8EgfITLREMFxYR4cHozIJl6XlS8OGguy/QNdo6Rp2orENk2IBkq0qQCdMj90ZgWLfVsvVkEAtsk4Uc9q1qZcp/ZtptkfTsgFkJqM7NrJVvHcnbgYupgHdclVR5yemeTTFcYTwesA7LsprJYkNyc8AJCd1jkqb0Zuf8ZFKXfQ/WBVd+2xcpI/N2IoRbhQHu1ObJQkZWCqvTy4M+HHoG6sOWI0QKIuZ8+iih4vgEG+zK2cXzeqEqRhQrGuRICSYlvTl2JnqBMEqBRX+wqPFTmBfmcyQBNHYf8R9ndSswmc7we8EXZ8I9XbwiPqeo+RoQE1wkkrqRHPbOagZKT3Tt6PH5i5q/0rmIYp7K9HAFfn0UQoATVtreG6SnxqfhidS9P1MOlo5sVA0dE4fOXhevNIF06kJJNF7o6RwGHCr0uU7ZEXxdTPAjjHwezMQNT6TpDl1iS4ZGwMo/00BicK15e2ZSRv+gBBAjuzhfHogmnMqJwPAjoSWeducyEYPrqGIwujXYiNvzaHtF2sDvhWA6rp84tD+A+gsu0gom1+/Csd1WTgj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNRT1FFNjF3cUIxTUEySkhQZDNlbVoyMVBxVmcraUJPZWFIeExSVEtTUGta?=
 =?utf-8?B?YTk3VXpxY3ZUSWl3YXVtek8zN3BodklaVHBNSERVTXY1TXhIaUNTWk9sOXVM?=
 =?utf-8?B?cUFvUnpiMlFWRU1Ed29jWGkxUjFOcjJsWkl2eWdPVnZ0NStrNjZUSGpISkpB?=
 =?utf-8?B?S1ZtaUJQRnVrY1Nrc1JmdmY0L3JFcGVDTlNFRWYyaTBGbms3NGRUcURJNmVm?=
 =?utf-8?B?MkU4c016ZkUrOWFaN092UExWYlBRNExWeThraTFSNld0ZUpRdUFkd3dadDBu?=
 =?utf-8?B?STBFNWdIbVh5QmtqS253bElGNFE0U2huOTc3bGhYcE1MclFLZHJnUk9QdzBi?=
 =?utf-8?B?VHd4L2hjMkxDQ3A2Uzh0K2RlZXZFcnBaNTEwOXVmSjFObmRTNExxa2RZdDl5?=
 =?utf-8?B?Z2tBYjdvS3V4SFo3cWplaG1HSXk4dk1QNXU2ZlBJTzI2QmI5UGtZbWFtMlRR?=
 =?utf-8?B?OWVaTHZvT1pMbkdPT0ZPL3JWNEt6bXZRMWNVTVNBNmxUb3Q0UisrYS9TWWFP?=
 =?utf-8?B?SERpU29XZE0yVDhxK25BRXoxRjRHS3NBRmpMRCsvVGVNUnJzMm9HNmhlcHZL?=
 =?utf-8?B?MCtrVk0wOHJzVTc3MDREcklDcVAzQ3ZzMmNxY0NKaWphWmJPcnU5TndaVHZN?=
 =?utf-8?B?MTMzdzVJdzRDT2VucG5jK2paYzRrWVF6SnpIdk4vaERBazV0cFpzZE5vaCtn?=
 =?utf-8?B?QklxdkFMbVRSaXlXY1Z2MFpwZjNmNnltZDBtVkcyQWhQWWYvWjJkczJXZklj?=
 =?utf-8?B?WEI4Qll2Wlhheml3SzVKOHdJWWtKQkRKNHlCdDg4WllWQUY3V09qMDRLOEp4?=
 =?utf-8?B?VVo5eGQvQzJSSzd6ckRHUkhYVy9nRUR3WW0reUV0NE9iUnhxWWg0dVhzZ0RK?=
 =?utf-8?B?RE5sVXdjUU9xZFhCN1dRMXh4MDcwNkVacFlndUZPVkM1MkVWUHFKVm1aa0R3?=
 =?utf-8?B?a1N0cmdJWkhCMndnSUt5SnlWc3MxVFdhSU1mZGpzRWh6bjRzTCtnWjhEemhZ?=
 =?utf-8?B?cm51VVNsQ0grL2s0dGFUU092ODQ1ai9HanJ5MXdzTmZqN1BObVhIZ0tVTXlZ?=
 =?utf-8?B?Z0s5TkZGaWNNL1RkbERhOG5obXN3cDZjOFBsdlZCYkl4SUdVdUE5aWxDOHdN?=
 =?utf-8?B?ZkxtRVcwem9zYzIzNWJqbHcycmVsUSs3Tmt5VFpNMlF5aTU1REx4U0JmdzZM?=
 =?utf-8?B?YnozMUxMUWpCcERHZ2VwRXNGZGg1MmRvaG5IaFlNNlhrNitaR2VyejdXV0hR?=
 =?utf-8?B?UDlnMzNDNEtSRDliZVZ5MVJMd2o5R0N4YTFwZUhXMUdTblJCRzIyelZMUHZq?=
 =?utf-8?B?cDE5MHRLNk9ZdXdOdy9YUUdKeHZBQ2lYOTRnZFRNQ3FIOVlzSHJpKzJUcDdU?=
 =?utf-8?B?dzFaUFZDcnBBY09YZmpMdGszdTN5ZGRWSHcrT2RkZ05OTklSdlpwMWtjL2VR?=
 =?utf-8?B?YWJEdUNwUWtFd2RDZEdhMUIxRW9zL2w4RUJBU1hxTVVYc0FoY1ZkbU1BN1FG?=
 =?utf-8?B?UzFtTnAxSDloOVVUaVB3Y0dJaGFWcDJReHl2RWdtTzNmeHBIUE53ZTNISldR?=
 =?utf-8?B?STl5OE9ET3ZaMC9lbHREWS9HT2RiK3BCYkl0ZUdjZW5OaXlObCtBd0NJaERs?=
 =?utf-8?B?WVdnN0dXVWVzdVN5aHQza2wxeVlaMHJHNk82YkZrampCbWZxWTVweStwaVhF?=
 =?utf-8?B?b0p4UjByWm00U3VTdmg3Q3VQYzIvTE1oTHRJcE5yMXZTdDdnbURjZTFiay9E?=
 =?utf-8?B?anRHcTZWL2RzZG5FdVE3TTJ1bWI3S1l4OEUxUlZLbUtvRnFuRitiV3pNbUdx?=
 =?utf-8?B?eTVwWm5CdlZ5NmpvQk43US83ZnViVmVNZStMUlc0TVdENS9FNTJuN3U4Q3F1?=
 =?utf-8?B?Z3hZODU5VmVVaS9mcFhiK1hBNXpBSVlYdFE3cE5hc3pCYlI2SWhMRlRYN0Zl?=
 =?utf-8?B?RnV2V0VwSmRJY2RNNFVOU2FrNlZ1cXh6ajhnRkx1SGtsd29KWk4xanVTcHlF?=
 =?utf-8?B?TW5VRFNGUEdBbC9xL1dUVGt3RzN2TFJQcVprZWxZNHoweTQ4aWU3U0R1ZE54?=
 =?utf-8?B?ZERXakU1a1NrbXVlT0gvTlJWaGVPY1FRUlJ6eGdnR3B3YmxpdmwvT1V1eXl0?=
 =?utf-8?B?Tlg3ajdMUTdGakpyN2JPc0YwSjdNOWt4TGpDeG1ubEJva0R4U0tWd0RQTEdu?=
 =?utf-8?Q?VTCcIpEJwNbcAFtXI1cLkPE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b883190-a5f4-4f13-9597-08dc531cb868
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:56:39.9564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P1bDZATT+uR+FAq/EclYG+DDlygeaEATUh+panzGgxYJf7S2Msh1pbkz5v3hzDm5Mt+pDjVEeRy0N9Tnaozmw9qCJe0knTC2s5QPh2Cgrfy4cvjsj2EAAD+z2f1Cb8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882
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

Hi Jonas,

On 3/31/24 22:28, Jonas Karlman wrote:
> Imply OF_LIBFDT_OVERLAY Kconfig options to add device tree overlay
> support on all RK3399 boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
