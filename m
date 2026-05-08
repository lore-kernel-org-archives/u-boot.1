Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41ADCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192B184C81;
	Fri,  8 May 2026 15:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="leiM0lmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B5B84CA1; Fri,  8 May 2026 15:44:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC20284C3C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHYPfy9S7fmDHsLXycuNFPE20iiTQkKr+QG6tnumUQrARxtw0refmx2M7ZVLbIBqkH9qM132xFIT/rfY18u65QrXyBB3CwInaNmxj/75fRYo9fTxceP1eulClkSact91dhDEL7sT8Kr0pogSajv9YXm/4l8bySoQAwjcP/8EFah/0gCCaWBqC29qgUVQMwWV7eedljbJaVnIPk3CV9EPMklIyVpsrdCpMhFssH0+r4aNCnc+V0Lr5se7/sgJs4iTgs4J1E/cvoeS+e5tJcKeA9lKpnSj0oziBBsEHF1UNEhOvYwz1GJ1hZLj6JvJ5xiEzxpb0E770Te6+8Ofq5+7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xniaDAFBIRNFa1oTV2feb6VFbhQvfrErcEb1F40oP4I=;
 b=VWv4rwAtkBtPf2KB+U3KYuqtiV1FC7EUWY20NBsKzzwXfxBx7fpiqfwVlRAglLxeGm+pIkBfqKUTjlTN6HDgmcR7lwgrKVMhJN9FsrYrl+4YVGzpV8aoZNtiK+/5OClyMpsHD2IE/0aOXaaNNGCN6OclDLTnbZIeYfg0yq0YfBEzqXtJpNmasAnpx7ITuJUoaa0jjqewjhowHyaO0/Yl1P9BfGXDd//+d4EoQturCXPtlAP35IJ6oSSfEAis//XOo0p4iELVtOdsuswF8PO1zkh928kwsS2+IlCq/SoWgr8d1u1kOoiNhuKOmpi8rRkXoGnSgvbJ8WV2vMjUbCSPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xniaDAFBIRNFa1oTV2feb6VFbhQvfrErcEb1F40oP4I=;
 b=leiM0lmJlgGY32m/BwqJKXvY3gJ8P2FEj0UcP9hMFePMtRbyzdRevu/k8qzMtZtd3nThBhR1UbxpYFO7Qk+7Q/fOipp6thKGLhO4WIITZeB4YraisNjfnryOW2iPdtm3FCQmqrrz8gkG5IPaQESvoL/zgKpjvL0Ygdd9gE6qMNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI2PR04MB10545.eurprd04.prod.outlook.com (2603:10a6:800:270::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:44:30 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:44:30 +0000
Message-ID: <060791c2-e18b-47f4-8dc9-dd7daca8b260@cherry.de>
Date: Fri, 8 May 2026 15:44:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu: armv8: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260507164338.59399-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260507164338.59399-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:802:16::26) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI2PR04MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: c95649f1-8606-48a1-3dcc-08dead07edc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: KC4QmGTKQAmT+e3qjYX+h9vr7hhmshkQrvaL/zjtMD3SGhiNhe/6blZe5R/6/av7wLukzsigXEANsV7/KFQUZ6OB9B8dNVo8O24oQJf+6fwQxqAR+9mx5JzBjRuuiZ4EjNW/xt7doB8pCtyGT8ihXNaXspXtDqYPsMn7jB4PVBNWKWfT3P5soXMOtre2l+A2DCjOYTVEaawgmPTTDWhQVFqHGy2ak3ob926sdluYqO+3/dh7UD/Zt29Rt2SC0yTh6xPF5iDGYCXGkhNjffUQ6u50HNhzFJB5dAYyGGU7scikGPSgvcD0/u4eWkYnM8EkkPWr5gGElRuc7z36NUJuoeZh0612QBJptIIpHBMg5g5SDyYT+BmL51svqgeqhUExSI6kYBItp1x4H9eLtbi46BR+Cp+VsltM/2ACTqO5Y1avqpZDx2H8JD8Y3Y2i3jROMn+oITUmkFnDYOKpnYxE0uDUY2Vl8ayQ/G14qK/EtR9jQYVjnKIZY3ORT3mzsKxuF4buXaDHJ4F90tDuJKr28oIFRzNkbuf0L0y2sg2II2WLM96g1k5xmNsjEeY5ygOzbrQWRxbZVYUZeRL7QPqp+LkC+KfNdXRX/cNXLbTRLHTx1knB6Dn6RT99Qv/NRcsaWq6j/R63Cv1MmcwmZKVnnrB5bbb01h/evCwIJDt7vsKyepIzqxd0r2dOJp8mbOKG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhPamdXNzJ4YXRONWhhQWJhU2Z2UXVzRjFkb0lXbHpRMUZ2ZUVnb1RXOStX?=
 =?utf-8?B?ai9aT3pzcHJJMGRmK0Y0aERtUkora2xTRnNiSExNYTU1Ri9CalY5T3I4THEz?=
 =?utf-8?B?eEkyOXRzdWtveTlRcTFPcVdua21CMDZzMWNjZ0M3Mm9GVWdrdHJCMzBKMGVm?=
 =?utf-8?B?WWh2Q2hRSjZWMVYwQXFvN1VZUXBQOWh6WmJZQ05LVERZa1FUeGMwRU9aU2Yz?=
 =?utf-8?B?UFFabmRiNjk2U24wRFJDYnVlRHZpUnpSS2Y4L2h4L0NkTlR1L2FabWJ3M3NU?=
 =?utf-8?B?QkhlS0VVZGZKRzFxZ2hORWU2Y0t4RjhRVmtPYkVUMldhV0RnKzhlcDc4TE9Z?=
 =?utf-8?B?RUZucEtJbnJNVTMwUDRKNnpmWmZ3cTkyT29wS1E1NVFldUw5cFczOVpvVE10?=
 =?utf-8?B?dmVZUXJDZnEyenQxY1NDNjFvZkJOQXUwYkVlaGJLSng5Qkh1clBNUWZJa3NQ?=
 =?utf-8?B?Y1owYnRqSnhiblpIUytTc29BQkM4QVNWZlpTZXFxd05yMVhITFhrTFo2NjZE?=
 =?utf-8?B?WjBwaUdGN2dUbC9tVDdwVVl2VHVvRWZoZDJraE5PR3dSTll3OTNUS0RIQnJI?=
 =?utf-8?B?djNpMWRoUERtMkVYc1ZpNithMTJlUVplY3RCTXd0RTJXTXo5Y3E4d2psakNL?=
 =?utf-8?B?SGdiYVJxY2NDdGtLTlpFOGVaeCtyYi9aZFlKZmpTbTIvczNrcm5XU1FjeVJq?=
 =?utf-8?B?cjM4dVduRDZ4SDdpTjNiQnVmQ0ZTRnEweGxVWHJQcTc0U04xRy81YmRjOUlw?=
 =?utf-8?B?VSsya1FTb3k3blNNT0NaL0ZCNUhuczJQa0EzZjluc3Y1TDBGQXFqcWV0YktX?=
 =?utf-8?B?S1NmTlBNMnRzMjNDZTNSRkxUaWtsbkZZVGFEUlRuVkJ6bEFYNHRlUzNlOThx?=
 =?utf-8?B?R0FOb1ZLTVFoa2dzSFVNdzN6bTZpRitoMU9xZnN2M3ZXNERkSFBmMGlIeHBo?=
 =?utf-8?B?bWdMQitINWtMKytDMmQrOGRsM0p6N0k5Zk9XWUdJOWpBMVpPUTNmeHFkd3Y2?=
 =?utf-8?B?TVFTcFFmVURQeDk1bXpudkZCVXRWVGtzMUlRWkRKNGlSZ3NrbHJScEdESS8y?=
 =?utf-8?B?ZUdkTHE3MFEyR2MvZkVUZmx0bDQvOGJydEwraE55dWsremQ4Sy9tYzhabE9o?=
 =?utf-8?B?dUJ1bGFNRFM2NkRnUlFhc3Voam01K25MUVNaK09LUHRxWEx1UXV4amorYi9E?=
 =?utf-8?B?WGIrSHE1YllXd2hDTkl0T1RQZzNoNUcyd0JnRnNrb055ak5ycm11Y0tLdWJn?=
 =?utf-8?B?eGpkV0s2aStxWm9TSUk5bGJ2WG9yN1NRRDhHQ2ttVlRicHZUVTFBTmJCOWF3?=
 =?utf-8?B?ZjViOU55a3R6U2xEdHJuTDZsQVZ3UEdUY3RmNkdSa2VsRTV0c2JSb1BKVXV0?=
 =?utf-8?B?cUN3c0Nkam1RL2JYeUpuN3hzRHhBWG5LNnpUaWI5REtPRlRuSGZsUUxabEN0?=
 =?utf-8?B?V3YwVk5IeTNvYVFMKzJ4NUFEeksvbXM0UVUwWkp6bFpCc2pGYXUyNjF1VFhz?=
 =?utf-8?B?b0VrclYxY0dkUElTeU1pZE9xTHZybEQrcUhUUWFmM2l1eTdDZlZ1QnhGNTV2?=
 =?utf-8?B?UGZVQ0trMnFZT01Db3d3by9EdERNYWR4bm4vdnN1WkdpVVRqNGJTUGZmeTgv?=
 =?utf-8?B?bkIvOXVIcVAxL1EvTEhSdVBJNGtHdHJ5WHN5VGFsTFZHV2F6bzY4S1J1b2hu?=
 =?utf-8?B?TEtnZmVmNS9ZOG15amM2MzR0MDh4cUx6dkpKd1NueEZlNmxrSlphZUROQXZU?=
 =?utf-8?B?Q2dTV2tRb1dMN0YyTUZ5OUdLMm9tTllsSjBYSVU2aTllT0JRTkZVYk9PRjZy?=
 =?utf-8?B?NVZReVRHUFloTDB5OE1BWVgrRXZRbVJTemJST0RiclpyUDl6Z1M5b2x5VWxE?=
 =?utf-8?B?dnJ6V3JnbkpmNFJSVlVDdUdwYTZNZ0FYUUxSanNLcEtjeGZaMzNJeGJGblpO?=
 =?utf-8?B?L09xVWxoNytKbVZ1QWNKZlZTdXZTVVEzN2J4TEo2VU5mTXRkVUJ6RE5pUU9t?=
 =?utf-8?B?LytlR2poYktjUDhOV1FwYW5qNGN4QkVmemI3N0psNVJKQVB5TmtISEMxd2Ux?=
 =?utf-8?B?TjJIN2R0WnpaZXhCTlQ4QW9uNzBjaTZrWW9BcmtrM1Z3RVQ2YVY3MGwyM3Nl?=
 =?utf-8?B?eHQxNVdwaUVab3JvU0RvMUtLT3J2ejlyNk0xWk9Vc1lwdElJRHIyZWtSRkFW?=
 =?utf-8?B?amJLQWRrcGJNMUQrcW54Sk5Ec0ZmcU9Xb1c1ZXRYMWQ5cURHUGFiSjU4MGZz?=
 =?utf-8?B?cjkrbUdTb25ZdXpHYkJpNVB4M1ZCbUE2bkhiYlR4Y2ZYWHU0ZDJ4WW1SOWNy?=
 =?utf-8?B?eUxlY0UwSFpRT2tHMHFwd3Foc1VWNkt4M0tJWGE5K1ZWS2pRWHRudz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c95649f1-8606-48a1-3dcc-08dead07edc5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:44:29.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuA2PjUthMf6cfKPVjpNgW3IqoxZ1tOae4prOwFjPd/dtyVkDuzpkmgOUvbUtJBovQK0haOe/21NYevqadr/w9Er6bYsLi1ZdCQ2r+5IF/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10545
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

On 5/7/26 6:43 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/cpu/armv8_cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
> index 4eedfe5e2c5..ed87841b723 100644
> --- a/drivers/cpu/armv8_cpu.c
> +++ b/drivers/cpu/armv8_cpu.c
> @@ -124,7 +124,7 @@ int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
>   	return 0;
>   }
>   
> -struct acpi_ops armv8_cpu_acpi_ops = {
> +static struct acpi_ops armv8_cpu_acpi_ops = {

Missing const?

or title and commit message misleading.

Cheers,
Quentin
