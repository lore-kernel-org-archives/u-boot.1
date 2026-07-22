Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC7AC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42EA2607E6;
	Wed, 22 Jul 2026 14:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZ3InX2Cg9oa; Wed, 22 Jul 2026 14:12:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FD55607D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784729538;
	bh=P3acOJ3/FYKkvUwpIOwCi6MxsZmV655SGOxnMyIE0NU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gBPnEFEztdl1d6LLm6LXGCmsxnBlsLJG5PIqmUfKxAtrBKFgtm0zpZEpG2wYzojgk
	 ADNufQvMHirJaOUBR81RzjEiIW7SkI/yymDtnw3Xz/2syDsLlrZLM1jS4iTH+Yuste
	 gZsmUXfd1Mygnfk5wBVxryl6I3EpKAhXVM5foaOJMXnZW+8lPN+ULiBTTSQEAjiDyz
	 y6l903iHsfgu0duf5DGRWZ3c2YfzFDAw2gR/wd2rzCmjuBAT2SlB8tkkAAUoPAn3pT
	 S7buMhVEdtu0wZmoMcQ3S/G2oml/d1zRdiM2lGH31HA/9DLqwn3qKLDGnIs6ElJfx9
	 hDVasANzUXaWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FD55607D9;
	Wed, 22 Jul 2026 14:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 061FE224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0B23407FA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAzGYWd0zsbZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:12:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 078CE407EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 078CE407EA
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 078CE407EA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJLc7lfs45PbnX7ssqwno93sradFaD5jnWVk01busgDV2V3LXel5ZQZPEtAU5qm1uJU/hlLxc7DHFSmxIsoXr6ZK980CCAyFKFXuqt/uEVKXtSvVbu4vDOp174HrmAK/norCkj+Zv9FSxtwj4LtgplLM9rpDzDUQmZyr9BUJzMV3xeMDnH3Y1CaMWkSpXQQRkFqLWmAXMlhJii5gbOMT5XzQUtRMzcYAjAbvDPCyfBW1SOBEg0nCOaYDIlsTraDz7RXg+zrP7GsWczsQf39zytnAcUF/tvd0Ibb3USMRm44OXnRhe1OEsqOGAxZ/pAP+lu6KW3VZJqawE6bPCAiMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3acOJ3/FYKkvUwpIOwCi6MxsZmV655SGOxnMyIE0NU=;
 b=GCKES7vG2SjE8BUP+p3w+QI3WIbBxqEuOHccen0mHTcWhQa4kWG2VGgHwypKq6LLiknXuXI41D5yoRT20p762SiTK+8WHXt52uFwOMTI3dvC85PdRmam4eH3CLS9EdwpG/IxK6ra+Ad61TzVMkvEqgWzzET+8T7EVykvPPB/rpRqCyj17MzBczhO/cXtCOIdr9rDGnWA45kRPLrfBBqAlCfuN4BmChnliqa+i4hTOrELjf4POxUM/ZIvJynofB4UX7VnWjhPpQm9gpaAMQWXqnpwhBxB+RAiMfD1Tk2lwYMnHamAdtMo665w3n50BmQdTsOenIMTUXDFlpTqB+sAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA6PR04MB11779.eurprd04.prod.outlook.com (2603:10a6:102:521::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:12:08 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 14:12:08 +0000
Message-ID: <9d031252-b03b-474a-b027-d254868c035f@cherry.de>
Date: Wed, 22 Jul 2026 16:12:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] rockchip: roc-pc-rk3399: Enable redundant
 environment
To: Fabio Estevam <festevam@gmail.com>
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
 <20260722013642.1011666-5-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722013642.1011666-5-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0045.eurprd02.prod.outlook.com
 (2603:10a6:802:14::16) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA6PR04MB11779:EE_
X-MS-Office365-Filtering-Correlation-Id: 361d5050-fce2-48b1-9a85-08dee7fb3764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xjpf2ufeI095Yc3fweYi3fr1vPdVJzlfq2sXZByvoFwPBZtyu3WzKfzrmXMqd+vrChvTl9vMK5aAhPygNXP9Tx5Eg4U7zPYnQuerTliXWt2fZLiVc/svXgpYWL7VgHEvtv/fCijhTjCK36BzpUHU5mktrG+UApZ7slxuiT4Qdr8sXm26QTX7UrfNkOiSczdQZbKSZNQy3hriVY9shZoJ4OM23bQDCrzVnDzVhReNvSaD+f86ov0X2gDvdXLszaI++fSOiNy/6VIIrXraT1zjO9AvHkcT+y4T8zOOIV0AXM4ufko+idCVP/7oVQ+OxxKBNd40VPUkwwVt/oeqnHq4s0ZAiaL47sMSuWlvdlpve4SlXFpm+FHsyLe/rNg/PtmHfwlMaSSXfuaTgG8m7boVWtnGGqPQbQAfDlierTlTjVy/3n2y8HE8xYVfisjY+nVO0Iqwo0k6+COpyOTXRQ0z06eH73ebgljuusY+Dsi4qx/GcX6YGhiAnPzEjv7tM+9doLi1eKZy3VNwU7YEWQwtzve6ENxRUyJY9OeVq0R5LUB+GOizNpoHYJ5HeCqbebp038Hk2vyhtwsh5QqBwNHRPYLMa4n66YaVQjEfzqlW8qvWxpajg/P8AL51EfNAXSvm1uqC8Lucz+GYr+qy23Zo654T5f7A1wgZ9eSWy3muu3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJ3SkFUWCt2OUpuRXpQamhvUzBqL2lsaE1aVWxML2hReHovVy9TUjltcnl3?=
 =?utf-8?B?VFJHeVJ1UjJMT1VkQ29raXJ5WHorWWNSOHVhNTFoUmYzNVVQOGJTcU1sQzha?=
 =?utf-8?B?ZURETE1JcnRPTUZkaTNGc2J2VFFaMUxieldUYm5CamNzTUtrWXBBZm1NWkJt?=
 =?utf-8?B?SFlZWmFXcFUrbFNZQ0hHTktLTUl2RUdkajhwOVFTanZXNm5MWjRnNUdyZXVK?=
 =?utf-8?B?d1dFUE4yQ3pla1k0QWFNSjRYTEl2Wnd4QU55aWNldW9ncnRyc1RNbm40Vmxi?=
 =?utf-8?B?TVJkZXdRdjhlSXpIQVdwVjdvNkNIbUNMSzlMdWNiS0pSd0o4eHEwTXlsN0V2?=
 =?utf-8?B?QlgyS3VydjJGS1gzRUt4WVVUbXh4MjhQRzdkNzZjTUE0bFkxQmNuckMybFNM?=
 =?utf-8?B?bXp6QXUxUzFCTWEzSWNxWm1INEVmb0tYM3ZqV2llNStHTVpocG9hSG01a2VY?=
 =?utf-8?B?QUprMi9MUWhSOERqdy9WSElYbGV2UlFhR2pLdlRONUhHMmlVUkxkTUlxRmFy?=
 =?utf-8?B?UE5BQzFQR3gzQ2Zua29ONVd6VitibVBJeHorczIxWDVGemFyMW9pR1lNRUZ5?=
 =?utf-8?B?UUlvaGpBRityb3g0OUhYc21CSXVhK3JZeVcvcEUwZzNxU3JjdXdJRHNtOGE4?=
 =?utf-8?B?clJoZ2QxSTNzejNKb0F2WmVSQUZvdERBNkdIc0ZjV1VvZkg5QU1hcVZyMlZo?=
 =?utf-8?B?ZjJxeGt1ZHlocmFqTkxRWk12cW02Ly9uNTh5TEhBRnBZTHBOTkYzc0lIVDhY?=
 =?utf-8?B?bDZaWGlIc0Z0b3ZSV1VDNXhSWGxRbm9tM013dUtMa3ViOFRWNis3NXNOZGE5?=
 =?utf-8?B?b3FXWmlPSlNTTjM4K243eENrbVRGVjd0MGM5RjhiVEkvS2l4VnBJTmNod2hJ?=
 =?utf-8?B?aUNYTk84SFlPamFvaFFBVHh0TUM3MDkyZjdaRFRPSGJoa0x6NU43Z0FsMkVI?=
 =?utf-8?B?VjBBaWtOMFlLSUZxdWQyZ0RZWkJyYkNOZE1RYVZERzNGNjFIN2FkQjdEVzN4?=
 =?utf-8?B?cnVmbFh6VFVoZ1F4QnRVck14V3ZqTGFJekpMMnl6d2lpYzNMM0hiTnFNYW9N?=
 =?utf-8?B?azBNU3FBQlBEVFZpcjhmc3FaREZCbVNOcUlrWVVFVlRDUkMzeHl0dGZ4UUlG?=
 =?utf-8?B?bndOUzYveUwzUmFObmZNTGY5aHBVS0NQVWp0NkxiUnVubkx1L1JkOFV5WjRn?=
 =?utf-8?B?WnM5dWVPNkJaTmxkK2lEOW9pTTZ0NTNTd29LNVhROE5yNG92ZmExd3JKN3ly?=
 =?utf-8?B?Yy95TFdOdTY5RUhxdEdoQkI1cDh4aTNNOWR3VjRyVDZUY2RoejFqQldxVEZH?=
 =?utf-8?B?VklVY1VuVk1nbWV1RTBqOC9wQXc5eW04ZlBqSkRnOHROZUV3eDIyWTNPcDZo?=
 =?utf-8?B?dWp1R2orYVdpdDdqbWNSUjVXcjRkdDJOR3dMaDNuM0VkaGpXWm5QeXFXUmZQ?=
 =?utf-8?B?WjdlZ0FsTEhZK2NsMnV4aGFKUWFLSi9kV0VtUEU2VG9CSEFTNXhVQVd5NFhY?=
 =?utf-8?B?ekg2TitKLzV3eVM0T2c3WDN4RVVSVDR4VGZSeGdXMnpuK3hQNXdqTE5aR2or?=
 =?utf-8?B?SVgxbG5JcnJTSW1mMjRUNlJwWXVzSEMrNmMwNW54NDBwejNKYWxPcXJaOWJT?=
 =?utf-8?B?UkN6TDFNb2oxcUpCdDZ5MGRNbGJOcmZQL2pWWUVhM21UT05OZ3N4NjZXSlV6?=
 =?utf-8?B?bWFoVzZJUjdFTDlqbWg5S3dYeWdhWGhYN09qTVBMdUVhSG9OUUlJWWlVbjlk?=
 =?utf-8?B?VFRCUlpJNzBReGg4TU1FMVhZYUY5REgyTzNCQUJwcTUrR3ljRU5MMHdJb1Fl?=
 =?utf-8?B?YTV5NU9BVU5hVzJGZnM1QzJVNWQ5d21oYmhkb2tqSjdCMDRWTFVWK0J3V0lV?=
 =?utf-8?B?Ris1Nk00VStmTUpyL0g5NzU0YzFVK0NjK3BTaTgzMWhtNTBYblYvcEVBODNy?=
 =?utf-8?B?L05JNzhTa0laUmYwanBSTGw1Qjc2eEcvSmFxSy9xMjJXdkI0TXozTnFYaWhD?=
 =?utf-8?B?ZkVFRU5Ccklya1dVUkN1Vzg2L1huU05tdkRjeDUyc2VSS01kQy9wTCsrMVA4?=
 =?utf-8?B?ckhQVTJtREdXQkU5WE1KZzl1b2tIVHd3TXVpejl3SUhxWUNIVXdJRit2SVBi?=
 =?utf-8?B?L0pTc0tJcVlNZ2JNZzdweG5URFA1Wm5nY0ZOUk5qd2t5amJwM0VqZWdUNGlM?=
 =?utf-8?B?YlBBQ1Q4L3RuMlA2bFdoRXRYUm02Mk1ZdW5vSXdmUHlLSFFiODRYVGUwTzVp?=
 =?utf-8?B?bG9ldi9TZHcvdkVSdUlscDg0aVNmOTEwTEhkT1h0UmFzVjk0VXNrV2tzWkY1?=
 =?utf-8?B?TTBERkIrMDNSRlZ3SzVkaVdvb1VYZWdLQy93aUJqcWRvbitxOVBadz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 361d5050-fce2-48b1-9a85-08dee7fb3764
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:12:08.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdfyyU87F3Vp9NwVN9XXa15saP8mgZGeOA4F31aMILxzl/MrJlxRxtcvgoK65tU42oY0/91W5aQUQeLiQpDvijxSmscUemeVO18zPPjqJTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11779
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3acOJ3/FYKkvUwpIOwCi6MxsZmV655SGOxnMyIE0NU=;
 b=Rnep5cSS9PYmL74XsyLWQsLN0WlAVIuDiDJ7OQD12A25VYGLmAmc43+OwWNhJUUufSyudH9/dTMXwrJmY4GyJrBELZeBokQKfBD2rTdpkPJ+dfHf44TbYDIU1RI/6TWVVYcXRwlEgE0IBDWqooQUCOhJvsW7vZAwYsQ5gU2DsZ0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Rnep5cSS
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 3:36 AM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Use the final 64 KiB of the first 4 MiB of SPI NOR for two 32 KiB
> U-Boot environment copies. Place the primary copy at 0x3f0000 and
> the redundant copy at 0x3f8000.
> 

Why do we need to move primary? Forgot to ask in v1 :)

This is fine otherwise, just being curious.

Thanks!
Quentin
