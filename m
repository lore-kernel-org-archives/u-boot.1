Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE22C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98ACF81339;
	Fri,  7 Aug 2026 15:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bjMXcm_eclYY; Fri,  7 Aug 2026 15:45:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36BCF812F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786117502;
	bh=SKv8BBAGJDfg5uC+HCmE6MskMWpvXAdEoHSuEJrKEMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgNFMpvdy/sXFhQ/xkDFwo+8hJbuWcyZCiKEqLnukBithm1pqS2pgMJJA0hCtVqJl
	 EePaVJqk1JQrx72Mw9pxCKyswkTOKigiSicT7Kek3ILoQ6rXIpENx9cuxsGiMgA6PC
	 0AwmKWtfGj1YMONqUZPeOx5hT9/KsyymZYP9FfGv89gnrF19doKcBhNOSxuLzCUZEA
	 tDVgZHcdiePHl+H6dwphf6IyJrSsOGCvyILLWfdAyT6fId46+/pva2sPB2tnRDXdVc
	 ErZfOscuG6KNo/vZOKXSuk6K+EwjfpK4qvi2hmdrlVodimuVDmHmbA8HiZR6g1XTDt
	 bPHZMAGjlyDgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36BCF812F1;
	Fri,  7 Aug 2026 15:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11A38D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F215B607AB
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfJqtxNsaHlg for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:45:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31C22606FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31C22606FD
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31C22606FD
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy+H1R54mDgGOPjiAGBA1y1OFyiQCgtbrLBcM8M22vv8XR1uiCn8ogZxpJzYxLTDfYFvdz+NO3A6oA/jUoMgBM4fOqyammHUXsu4N8vtgVzZkXLTqEV9KjjuemxQR+LHnZ5QpZB0/II6ckn5tZp9BZZ3vRLEID1H+JaQdEvgqzzbAjANYeuOnOPmXXxSShSvfIdqN38AprkVW8+66KdVPGQQvjrmP7ZS5f0Z5P41A1xYmwQlcUauv5TinseNcM8AFtB6zUdMGqH8c7GDVTdHNF9ibTdLXHgnPMY5IS5gVhtcC0qO4wO6hhPwY1Lhy889YeRYY8TpdbqnOR7xxrq5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKv8BBAGJDfg5uC+HCmE6MskMWpvXAdEoHSuEJrKEMY=;
 b=D+b1QuL4df5gv4IeP9NwEdNzSs2FU8uJws/skjyNsL6ofq+XdI/Ef0LDxQs9AVns/e+5ANZqyEMt4qpkyVaMdUtFNeVxxr6ljGkd6KlbIOyBp105AWGstOIbqmncf69FX7eqARZOvr4lowFCNvUuAeVrn4AD8iuzmojYOwSpc0Kb+clFl8bf+Q+hm6/Z01K8FTQq0g4Vn0dvR4FQiyVLqDVnjAlI0z9qhqLy5G68q4+1vwpZtTfT8NOQsFWVmCC2GX96/F4GvEBZC1czqCn7wvGb9QDDabVJuSzBdT944ibscEUvaUJpLNfpM235wkzL+YbPKlc7/S/D3J3RRfxu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 15:44:55 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 15:44:54 +0000
Message-ID: <c59fea96-266e-47bf-9d87-d008800b536c@cherry.de>
Date: Fri, 7 Aug 2026 17:44:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT rate set
 during probe
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-10-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0155.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::48) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 519934f3-bb08-4018-a488-08def49ad3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10070799003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: pKO6MEe2iISAZE4DBHZcY319fDOcfe+mHHuzgdk6Oi6E5OFbzAihU1DU6XZg4aLEMs/76hMWeZFnxtGhCnMjJ8O1hLA3Pdt/VOdYG2z4H272MaaOXA3oQEYvIwgfMmIivyLLvw9+/JRYG2Cfm2y/NoFyRPBmEYKXuQfkyGGPeu4cp0SWm8XriraEVF+mQnW4hviyh11ayCw8LnTtJKWIiZiVprE4ob8eTv7rhWj4nJ8cqpAYMaWPvxFlJV4WaR/RA1D9WDnL7IYKdsyNwJQxjENOnQDsYSWAW9BnbqwWlFDbgR55Xbkeeepz49EA4PF1G37v6BCL11+ME/NVviDA/SpOiPb9EtlzTjiIzvexlag/Mu+eIEeVVpyW6FLH8kLXePnPspD9SmVh34MbiTErHIstbvBYC1pkkI/nxcaiEF3IJpHjoJ254G/vLYs5bsJr7L0bgzNfVQ0Lxs5FzdWzqLIL8zxOQQ63mdY+aZ8Am3REXZjBtP/AnqGeSLnm4UikWJAMZafsaezpJr0RCLPtVPE4oV79Kz1cWsb/aM11uq1r9dCN3/1ig8q+3VLllP5/HEa4mjiBEDF8XQngdTLKGb32pyn0sbghDaGeAq9swfxybY+y7l9tDZiRs5Wq7sgMtq0mNn4q+TO8+9eyOZaY+4d8dCaiNHLhaUFfrKOpCdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVvTEdjNlNPTnp1ZU1RMnpBK3BYWWRUeGJtL3FKOWpxV0tQb3NZUDlNWUU5?=
 =?utf-8?B?c09mcTU1STBKWmFpbmRnamU2ZUxqRVhPR2Y4UG12SFVveEYyV1VtQVNDc0Yz?=
 =?utf-8?B?NEo1YmpHMmxoNkh3R2lHakk3c3lYMFFDbDZXQUNIVUZ2L2VmQ0VieUdKK3dH?=
 =?utf-8?B?dFRNN3JBSlpiUE45Z1RLVmI1azdZYUxqR2lOS2xFQ0ptYmpTYUJrTUVnaHBQ?=
 =?utf-8?B?ekFVZHlJQ2diR0R2Z0FnYVVNUG9UekZYdTNnNmV1cXFhVVFtZEpQSzRMSVZX?=
 =?utf-8?B?dVJ0bXRka3A0M3NMUVZqUjA3SUY0OVA1QW9SQWVjb1RFRitrQ0R3N1Nyd3o3?=
 =?utf-8?B?d2lCd0ZBTURFcEhYL29xMDZ4Y2VlVUd5MmpMM2ZXdm0vTXFnNU9meHA3UXlj?=
 =?utf-8?B?VHg4dEVUZU1lelNaeGYrNUhRbFNtYTF5KzFrU1l3cHZ6ODVrazlweFM3eUxl?=
 =?utf-8?B?d3ZZbTlTMS9oY1pWaUt1RTRvRUcwTEZHUnBJMVh2UngzUDZ6cXBXZzBaRm9o?=
 =?utf-8?B?K0ZQMFBCa2xuWndpRExDKytiVDIrd0lXK0dHamI3dklOdzR4ZGZydlJWL2xo?=
 =?utf-8?B?b1B2aGV1WHIySkNCNndXSVVhdGIycUhyM0Y5T29uZVdPb0RwVmtjb0tFcC9S?=
 =?utf-8?B?QjVkRVNhWlRBd1o4SVBZbXNyVEp5VXRDR0tOUWZmN2hCdm9UTFo1d2FsTVR5?=
 =?utf-8?B?ZUdZTmwyQkRnNGZsYmt1bFJUaHVvQVF6ODJwK040a1Fqc25Oa014Wmx5clM3?=
 =?utf-8?B?YkphclhHN0J6ZzVXcnhjVWgvREFYeU9KaWhWL0tJeDBMaUdIU0k2WkM3YVc4?=
 =?utf-8?B?TFdiRjJUZWZzQ1VVVnRKR09VUlVnbzNXUG9tR2t1RXU4Q3kxYVVJSmRKZnRP?=
 =?utf-8?B?dm0rcTNYTzJKTW1BR1dkUVVjQkVXUXVjaUgyNUVOdlNucnQ0ZlFGWXhFb3pC?=
 =?utf-8?B?eUVLSG5RR3l4dXJsWXBTMHNaeVR3NmZIa0FTWEdaVVl6Sld4MWpXK0l2S2Mv?=
 =?utf-8?B?NlpTZjJ0WlZDWmErSXdXUkhGM1o3VXhDN3I2akxORVBDdzc3WW43U2E3R2J0?=
 =?utf-8?B?WVdRb0VoaENPWnZhdmpiMWdxS3l4K0U0WVVyYUgwUnltWmpxTU5IczVBVG5B?=
 =?utf-8?B?WFRyWnFFdU81dHV2NjZES2doeG9sM09FRUxqTVNvOHpyMU0zU2k2ajF2Z2NZ?=
 =?utf-8?B?SHRsSnM1MHlmeTZQc2FzdzlwaW8zOWtIUTMzNlBkVGFueTFISTBZN3VJWnNQ?=
 =?utf-8?B?MDZlTWgvZ2pJR2FCakhPWi9WL0dOUFA5YWpNZnQxSlVRNGJpdXRkUHdFWmJy?=
 =?utf-8?B?NGtvU3ZoMHlTQXlnUllCcG9mVld5WU41K25DNXZNOHdKd05FVlZXMmdubyti?=
 =?utf-8?B?UTBiS0JHakpjUlJ0anZqNGM4VnFCY1ovdmo4S2oxSGZRY0NRRGtiR2FUZjh3?=
 =?utf-8?B?VW05NkVxdkNqTUoveElFa3NheTRIck1ZZy9tS2N3cmp3VnVPY0syRUVqbFdq?=
 =?utf-8?B?T2t4SWNwT05Ed2lIVXJDV1QvNGpUMWNPbi9QN3hGSTBEN005emlELysweDNQ?=
 =?utf-8?B?Umw4bXdZWWl3OU1RbmV0MXFDcjZoR1hIRHJpTVpJK203V1BOcDdnS24vN3Fu?=
 =?utf-8?B?WmY2WlZscnIwbmx4OWRRK3BXWXYwSi94d2xUakIrNjlaM3p2MU1BTE1nc3pP?=
 =?utf-8?B?RHJ1dHpxVWJocGdWN1k1WjdIcGNTTk95K05nUStkVmpmUU1mQmRTMnlpbWlS?=
 =?utf-8?B?eitLMldKbHp1V0RwbnQ1eWJtVk1hZi9ldUNIczFzQmk2dTdBNjlGbUtMQmZy?=
 =?utf-8?B?eC9zM1JBQWM0enRrNzhrRm93RFhsS2xtVDY1bFUzUUNCTXplMXNqeDQ2ekxq?=
 =?utf-8?B?R04xZUh4ZTh1TVdGcDE0ZUZaalpyMkhlQXBRTEZtNHcxend5VThUK2R4NVlh?=
 =?utf-8?B?blBhOEFMOUZsT1pmSXZwd3pJdFl3QStyV0o5ZWpCb2sxZ3RLYkliMFNjMWRI?=
 =?utf-8?B?dS9zQXA5SDR3akNWVncvTGVsclUvZEVZNnRVWXpTQzdVWnNKeVlIcnlqaFBv?=
 =?utf-8?B?ZnBuTU54NldWelNlQ0NIVkRUa0RoUXhMOTdmalo5bVR4dFg4Z2xvaitIRXpv?=
 =?utf-8?B?d1J5WmRvK0lVSWdwY3Y5WERsbkVNd2o4Z1hvUzFZOHpwM3EzUmVtTWovSyty?=
 =?utf-8?B?K0FleTIxazhJb1FrdVY1cnc2SUdqK1JrV2NtMStrdExscXJaMy9qS1ZHZ1pr?=
 =?utf-8?B?dEVDdnY3MDNSbGZQZGZmWUh3eVN1bEYvY2FUSHd4M2JSdk9FQzRsblU1bFhv?=
 =?utf-8?B?Yk1LV2dUYkRzK2xITXFtQmkzQThGT3FtTE1uK3JrU2ZhdVFhL3RQSGpRT0tm?=
 =?utf-8?Q?eqKIvvsNv9RGmdvrzDECjqcm7VbZ/k4IRKUxYRD2LHyB0?=
X-MS-Exchange-AntiSpam-MessageData-1: tK6TEpiJVpGnWhdOXlPeRjKDMChHApBxoLU=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 519934f3-bb08-4018-a488-08def49ad3b5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:44:54.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea/xzCcVQzpzkhDXxbMvqidpvwTHqY87w5iY6IhNzEvlw4xe6jjPZc//FMEj71WWIng3+d0VL95PpbYj/Oj+tnT8+onMvOPvuz7OBLh699g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKv8BBAGJDfg5uC+HCmE6MskMWpvXAdEoHSuEJrKEMY=;
 b=dxH0CZs4E4OeTZ+zmVsrC17XPwkyDq8jOQbqkbOkbSKXiS1UUNk2gKDKX/QP6ITzRs+am9spA9+fEwORQOJ8d/E7haPYD1V17o9ZlfWVNYJi4hOEfmf7mX4UTm+LZZiGGOnZBYs+9J9x/sIjXZK3zfonGauIn0zA2rSQybNa04E=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dxH0CZs4
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The ACLK_BUS_ROOT is typically using CPLL as parent clock and running at
> 500 MHz out of reset when CPLL is running at 1.5 GHz.
> 
> The parent and rate of ACLK_BUS_ROOT is changed to use GPLL and to run
> at 237 MHz during clock driver probe. However, the clock rate is
> hardcoded to be reported as 375 MHz.
> 
> Change to explicitly use CPLL as parent and set the rate to 375 MHz, to
> match the reported rate and closer match how the Linux configures the
> clock.
> 

For those wondering, it is statically configured to 375MHz in the Linux 
kernel via the assigned-clock-rates property in 
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi for the clock controller.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index d03ca9c4ac8d..c48743d8296f 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -1921,11 +1921,11 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
>   {
>   	int ret, div;
>   
> -	div = DIV_ROUND_UP(GPLL_HZ, 300 * MHz);
> +	div = DIV_ROUND_UP(CPLL_HZ, 375 * MHz);
>   	rk_clrsetreg(&priv->cru->clksel_con[38],
> -		     ACLK_BUS_ROOT_SEL_MASK |
> -		     ACLK_BUS_ROOT_DIV_MASK,
> -		     div << ACLK_BUS_ROOT_DIV_SHIFT);
> +		     ACLK_BUS_ROOT_SEL_MASK | ACLK_BUS_ROOT_DIV_MASK,
> +		     (ACLK_BUS_ROOT_SEL_CPLL << ACLK_BUS_ROOT_SEL_SHIFT) |
> +		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
>   

This is a bug that you fix and haven't reported in the commit log. The 
[4:0] bitfield stores div+1, so we need to remove 1 to div when writing 
it to the register. I would say this warrants its own commit. Please split.

We switch to CPLL because GPLL is set to 1.188GHz which cannot derive 
375MHz since there isn't a fractional divider for aclk_bus_root. CPLL is 
set to 1.5GHz which cleanly divides by 4 to give 375MHz.

For the div -1 fix:
Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")

For the GPLL->CPLL switch:
Fixes: 716ed2a8c0bb ("clk: rockchip: rk3588: add hardcoded assigned 
clocks values")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
