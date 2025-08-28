Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82B7C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 10:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F190A832C8;
	Thu, 28 Aug 2025 12:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XAf8RdKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE7D832DD; Thu, 28 Aug 2025 12:58:41 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAEA8328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 12:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFvqkFfQBhRZc/QFFAjL13glTzSf/Jnl2jkeLFlwm+VSjaPXnoqMpjQQWeIamwgTDodGJd7IfIdjsj1XB8VlFBvCHwGyaOHj9vGtq+K6RaTycWPGiFGlo6nID/6jB2cMBPSDnwjj+aSVk/Nbfohtn+qbZd6SZFHe/zSq2Y8ZSSvTTlodpiYIvh8VDgFqRgtrnJrCioo7Ak+hS3WN5CYvNRTz7VKfgcC7ugd8e/IjcT3mYmXzLV02w8VDDmYdUeO2Wl9+wSEtjkctXDyI1ydZd9hJ2dyYVawBSw7ZnCo/8+97xpufaqrMHm4r10T4A8/+LkiBOuym1H93zq+1x07jPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYKyp4WLXPtw9L6xI4Z/Wlx3PxDYNe5x164IB3btEZg=;
 b=J/4Kel0sugJxknLF1+DkQuD5M0bc9QeYoKuNvf/pBFmLAlUvAgGUkMXxVl9pH65e4nvtdwx+uRM+Q+8hGv36IAoOuyezR5czw/DQljm0QVGhTttQyOjsm90BBIARJ64NPVXtIeUvwuFPFEYMf41uCZPngswSBzq9KBRoI278qliEzNbo/0Fpcn6oeiMA8VrFfRxwPk96NZ5f9+8l++b65aUOQ6YwGnh4VYhKa24pjeS72n+ovoii6kO7z7HNUeJL6Nw6+gXYCwF+jpiEpLNmpHSKfNQxh7Ov4cltUifBEZjTFdFmLmPwI2SMf7zcxZJB8zxd83z57UDIpnAqMTCh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYKyp4WLXPtw9L6xI4Z/Wlx3PxDYNe5x164IB3btEZg=;
 b=XAf8RdKr6uDuX7xIuJ1trc0mlAjiuWn9TYzARLDzBrvskHYyCXSBa7wUrrjoQMQGOM80GpSLNgS2l2eQtUOXR0XOYDB9SootMqX4tUOabjaMcVWqHAmTyJygjmOXikKcKZBiRtqCtPHG347W6yczE0+R12Ib+zVq1KcXOeTSwp8gY7oNMuWUFDcOYq6Ve4nlI7PTGg2pTGVrVtoqujZsJEMZnMprVn/jtsCTqgNSVKR/8X1AzLDkPOMjqktDUIDOqPFqhtRFUB5AW0owq+uGkaP5FfZnKR9y/tBehgvp2lpfCFilws3yUfBhevgoDaHxPBBECx4jdrM1XErlDAUxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB4P195MB1895.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Thu, 28 Aug
 2025 10:58:37 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 10:58:37 +0000
Message-ID: <ac106031-5de6-438b-a916-9f676ca5a0ce@phytec.de>
Date: Thu, 28 Aug 2025 13:58:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 2/2] board: phytec: phycore-imx93: Use
 CONFIG_PHYTEC_EEPROM_BUS
To: Primoz Fiser <primoz.fiser@norik.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250828082008.2978900-1-primoz.fiser@norik.com>
 <20250828082008.2978900-2-primoz.fiser@norik.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250828082008.2978900-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB4P195MB1895:EE_
X-MS-Office365-Filtering-Correlation-Id: 16088bc9-4440-4796-532b-08dde621d6c8
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFZwUTZwbFZOSzNVWmhtWDA5Mnkwa0F2cTA1eGJUaVI2Nlg0SjkyaEFjclQy?=
 =?utf-8?B?Z1BGQTZWTjM3RCtWRnBOaktCS1ZNNnYzYzMraVkvdDFDdEZPRnNkZ05uVG94?=
 =?utf-8?B?WHdHOWVzNWxvTTh3b1A5OGdYeDBZdkFrYlZMOEFwT0JxYklBYXV1elpDZjZC?=
 =?utf-8?B?UXpTb2YzQjZJV2lWekNERkhYMFd6UnJ4NXVkWUc0ZE5NajdwT21EbGhrcDYv?=
 =?utf-8?B?VmlBbFdEY2x3S1lYcUVyK2Mzc3MwVm8ybkFmWmp5eTd2aGI4OUcvMWFOTlFT?=
 =?utf-8?B?UkFqdkNOMHhpVllFK09yY1hxeFg2Z0s1aDE5bS82amFkZ0E2dC9jcVF1N0Vn?=
 =?utf-8?B?Mk1RZnBsTkN3aklmNkRyTHVrNnBCOGxlL3hsZUpZdjdHdnZQczExNGVhNlJo?=
 =?utf-8?B?em1yN2pQcmxrZW5keThReDV5QXlZT3B6ODRPbFNFazhwWEtwMHdld0toMWRF?=
 =?utf-8?B?K2J4SUZ6bGk4YWUydlRWUUVMSEVhVUhjRFF0Y0VjeitKUHhTcG9sVnhVdjJw?=
 =?utf-8?B?VlFmcUQ2bjFreUV5blRITm9oMWNoQ0JuL3o1VkdMbThZWlp0U2pRZGU5aDJ1?=
 =?utf-8?B?RW55MDdPV3pLT2hIeDJvMk5rampXM2RZYkFRWHBlV3hCSnQ4R1NjRjhFaWdz?=
 =?utf-8?B?RStMcTI5alYzSVZad0ZraTVsM2I5RDFueWFyVFVNRndyNGZJN2pRTWdFUjhR?=
 =?utf-8?B?ZC9ack50eGxMVnVLeXU3NDgwSWZiV0tDOVVLbWtERmJWMWZicVN3TDJtM1Fj?=
 =?utf-8?B?ZE5EaHpjU2Q3eHJnaFV3T2c1eEZQVDlyZnp1Mk14ZURocmkvam5Ldkl2bVFH?=
 =?utf-8?B?RVZqSkFuQ2NFbFdDVHlSWE95cTJleG5YTU1qTEpGWVI0VzZFVDdRMmZGN3RN?=
 =?utf-8?B?TmxzRGFnRmFkN2MwTnF6U2lnZGhLMXJPTUtJMFhNWFVKb2NVQU5mRnNXd09V?=
 =?utf-8?B?OWJKQTJrV283VFRkRkRYWkd1T2oybENlVnFLQUY4c2h2NmFOei9FdDZGSHJ3?=
 =?utf-8?B?VVdjNElEVlp4VjFQek1jbnhwMVkrellnTEVJYnQ5cXNZN0NlQThuQzhyZDFB?=
 =?utf-8?B?WWNLd045OUVRU3dFbk4rUVZteStwb0tXVHU3ZkR2ZmtYQ2JYQmZNRmJWZ2JP?=
 =?utf-8?B?WjJuOVh2eEQxOHJhc3YxbzZjTVIrVTFJeGpHZGlndUdWdXpWRGh4YTZOZjJX?=
 =?utf-8?B?Q3dkM3R5NXZLWlg4Y3NCaytZeWphZlFoL0RSWUtyekZGOWxXT1ROMVFDVWhC?=
 =?utf-8?B?bDEyMUtGQU8vYzh5ZU55VWN5NmFjaUlNb052N3BUSytYd3ZLWTNKL3c0b0pM?=
 =?utf-8?B?YndBZk1kSktZdDVtVSt3TmtOdWNZQm5WWjN2ZTdLNUw1R2F4Mm1LeElSbGJ5?=
 =?utf-8?B?eUM5UmlzREVOYW9mZ1VGKy90eVdGRmJHRDVLNlRpdEwvV3k2eUpvMHFvajhH?=
 =?utf-8?B?eFM5ZUhqQS9UYnAvcytENE84bVJSQlhEU0hGbGdnSGhTUnhLT0QyK2xDTmV2?=
 =?utf-8?B?eHRWL2prWlFua284bWx0bFMzSThmRkpleHQzUFNXTElrK2ZGU1R5bEdSWnVI?=
 =?utf-8?B?NndQVjROL0F1TmFWOTBQdlJmMElTRDB4WFBXZXFrc3NLRUxmMlQ0WmxESzV0?=
 =?utf-8?B?MzhZMkFQcVA4alFsVXcyOHJCRDhCVm9rVDNWL3Azb053U01rQUt3K1ZwcGYr?=
 =?utf-8?B?YkVwVTJOSEdSL09mTFpiQ0NMUFVvOTNSU1lZRXdVclhIUGwraDdFQXVIUVZ4?=
 =?utf-8?B?bVh1L2hqMjJYbE8rMFhJR1lSSTNPRGxRTXA3bEhBcElaWm1mc3g4QlhwWnhR?=
 =?utf-8?B?UUgxQXVwNFB3UENyckd5a0tCaFB1c1B4cUwvdTVTRGEwaVk4cVMwVEd6SUEy?=
 =?utf-8?B?NFg4aUNqUTRBa1lIT2pJcm9FeGtmT2VhTEwrS1JBRDBuY2ZTclFZYWx1OVpQ?=
 =?utf-8?Q?FsnWXeDmNzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVwZzFWcm1KTTI4LzR6RHZlRXAvenZVbW9kbG02Z0ljSWFXUzlkUENoWkZs?=
 =?utf-8?B?VzdSTnJvbHRiRHVCalhScTdnRElxNVlnaWZmYkpvSW9oUHBNSlNzVW5rdFho?=
 =?utf-8?B?azluaWF3Y25OSUo1dTRwSzBldlhTMUlSU1kvWExtMXp3RlVhNXdKNGMySjU5?=
 =?utf-8?B?eCtBY1NSeldUclVkZXBxczdHZFIwR2d3MDFHWnVyYWYzWkRZQ1dxMEpPNGx0?=
 =?utf-8?B?cTBOOHNkRC96cjdqamFWS3N4cHNrZ09HS1BMdnRacm5rQWtXajlHdEFBaUlD?=
 =?utf-8?B?aXM2clY0RDlvN3lXQkJYa0J6TVdnbW1tNTlFODVDUnpFb3FEaGpkc1BkdUFi?=
 =?utf-8?B?YW1FUDZsSDBDTGZHSTc5NjFCMWdMWUdZcndKSFZvc2VuTnN0YVlsOGpNNloy?=
 =?utf-8?B?eE1FQUd1Mys1aFFONjZVRFVRMGpkby9WOHRaYVYvdTNlWGx6K0haSTFLOHR5?=
 =?utf-8?B?M3FXZmxRTmZ6V1ZYdFQvL2VTLzRHMHowMDVSb0VhTy8rWTMrbjQzVFh3Mlpo?=
 =?utf-8?B?OE1vVGI0R3hWcUtpbWJVZmxnN2w0NzY5QUJiaTZ3VGMreE1MYjd4ZXArTDI2?=
 =?utf-8?B?anFKQlJrZjkvcWdldnNUMVpMQk1XcG5MSlo0RGtRVTNVeEpZK0s0aHYrdWhn?=
 =?utf-8?B?a1YvRXpCRHpURGF4NnlrSjdJMHBWQkM5YldFR3BrcWNqOXNFaURSZkhQR0ND?=
 =?utf-8?B?bGhTRis4QWx5MDNpTTFHbFlaN1FsQzErd3V1N0dYblZQcFZzaWIvUUlNNUov?=
 =?utf-8?B?K252eTIvVEhTSjdrQzZudHdoRFBoQkZhTkpMTlZObzJIT3FtR3ppYklWMEJT?=
 =?utf-8?B?RnN4YWtlcms4QndBdklDanV4UmVSbG9keElZRnpXMCsxdklrVnpOYU1KU0p1?=
 =?utf-8?B?L1Zza3Ixbnd3TnhmZ29kaXlwVm5pL1B4a3orbEtkdXdHRWRUUmN2dS82TXRx?=
 =?utf-8?B?cklvWVdhNEtwTVBkakMrUmxGYlhxMVB4a0lDMjFvbUJsM1NGRkZRL0w2WVZh?=
 =?utf-8?B?eGN0dENybnRac1BEMzFJVEV5UStEN1hGVVpXMlFUanYyaWJNV0ZXWDJsZVZk?=
 =?utf-8?B?VnlWbWdwNjZMWnNHdXVtems3UTRva20vcURxVStSM1ZpQXFCMzhHaUh2ZUN5?=
 =?utf-8?B?L1c4LzFndmQrY0xWWlNOSnlZM1ZzMi9YZ01wREJGbUFseHhnNmllYkI2dDNk?=
 =?utf-8?B?NXoxUHJPbVdQb0h6Z0thY1lTQlJRM1FaWmdCQ0d3UXl1amVvSURya3FFZEho?=
 =?utf-8?B?R0MrNlpET1VVQVVxdmd3N3BNR2lwcnoyWHBSMU1OYU02REk5cm1FaUdTamla?=
 =?utf-8?B?emUrWEhOdE5WK1NiaDNPSmExWi9Ya0EzbVdvU2tCVVkxVVZIS0hIZCtLNnI5?=
 =?utf-8?B?dlpIc3BVbVBlN2NkMXpuY0VLdFBiSk5nMjRpdWJQa0ZrM2dJUTIyMXpiVlVS?=
 =?utf-8?B?NzBvTWtXcGZKR3haa3ZCQmRFTmM1UU5VVWV6QWc4eldpQVFTNklRd0hjSU0y?=
 =?utf-8?B?WWh1bDZKWCtNVWVpVWpYYnhkeHdWVnVoZXlzNklyUGNsS2NncHl3cUgwblcy?=
 =?utf-8?B?cVdMbFpPeUxwQnZuMkpXTkw3YTdKWFdrYko2dGJHbEY3SXZ2Sk56SUpRMTJv?=
 =?utf-8?B?SU9JRklIYkRoazhibW0vZUM1blc2UWsrL2VyTE5LUzFmY2NwODJZQ3ZxcTRt?=
 =?utf-8?B?dFBHOUYrMCtPRGlmOUFvVXZydXhZYkcvMERkT0xNNndaRTVwbk42dmpyQndq?=
 =?utf-8?B?d2I2ZUZpZ0c5K1QxWDlmNVVOQ0ZpTFh3Z0NYTnYxenowWU8vTHRhK0tFOUxo?=
 =?utf-8?B?dlZMM1VmZ1NUcU5iSUJHbUhRc0hveE42U0MwZEJHa2dpRFlOdWNaMml0NldL?=
 =?utf-8?B?dVphYzhBeG1jWkMvYkpmM3lPMzVjYTBKM0ppT0I2Qk1NUmJ0WjZhdkNhRUpQ?=
 =?utf-8?B?czBwQU0vN2JDMElSRWw3dStVKzZFZFhsU1V5Q3VLSHBMTDBTZm9XN0RFZCtk?=
 =?utf-8?B?ay9iRkZKUURjSDVmWnUyT21SN1NGbDB2bFpMTE5rdGFwK0loNmNZcFVaQ3hW?=
 =?utf-8?B?RDZ3eFMzMDBHREN0OEc3TmtCakhoYS9DdTVTL1AyVWlFR2ZVd2ljdm5iQXY0?=
 =?utf-8?Q?VnUeyDK7oRpAnl2BVQHNDtkoo?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 16088bc9-4440-4796-532b-08dde621d6c8
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:58:37.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0xDl6O7kY1yM5rWP2SSMUF3J8zJMQDRpv6nm8QZJxK2qYrJpNJz1pR+OF4FkNvCpUVewx+DchhEx5Lkvz/VfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB1895
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



On 8/28/25 11:20 AM, Primoz Fiser wrote:
> Switch to use CONFIG_PHYTEC_EEPROM_BUS instead of the hard coded value
> of 2 for the EEPROM I2C bus for both SPL and U-Boot proper. Possible
> since commit 88a1816a9b4e ("board: phytec: common: Add PHYTEC_EEPROM_BUS
> to Kconfig").

^ is this not a next-commit? I am not sure if the commit hash will survive.

> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Besides that,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/phycore_imx93/phycore-imx93.c | 2 +-
>   board/phytec/phycore_imx93/spl.c           | 2 +-
>   configs/imx93-phycore_defconfig            | 1 +
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
> index fab66caf2a1c..c6a4e923b074 100644
> --- a/board/phytec/phycore_imx93/phycore-imx93.c
> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
> @@ -20,7 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   int board_init(void)
>   {
> -	int ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
> +	int ret = phytec_eeprom_data_setup(NULL, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
>   
>   	if (ret)
>   		printf("%s: EEPROM data init failed\n", __func__);
> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
> index beaa536c6007..7feee4bcf6fa 100644
> --- a/board/phytec/phycore_imx93/spl.c
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -52,7 +52,7 @@ void spl_dram_init(void)
>   	int ret;
>   	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
>   
> -	ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
> +	ret = phytec_eeprom_data_setup(NULL, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
>   	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
>   		goto out;
>   
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
> index 53cd28dfcba6..0acdfd2bf53c 100644
> --- a/configs/imx93-phycore_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -7,6 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_PHYTEC_SOM_DETECTION=y
> +CONFIG_PHYTEC_EEPROM_BUS=2
>   CONFIG_ENV_SOURCE_FILE="phycore_imx93"
>   CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x700000

