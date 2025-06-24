Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3159C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 15:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1364F82D17;
	Tue, 24 Jun 2025 17:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aIwCfd1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7C782D21; Tue, 24 Jun 2025 17:42:55 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793C682C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 17:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeNkiL12+9JQmzDDjq0qOOzt6r9n5odpBSSUdaBQUswv6basXCYTflUsOcx+wFVFC7ACa8w5DlWQLttI4NHJHWImtdKEyTreH7JDQN8ngiYmFguKfraaglb3BtIM67kh6iMSvNbLQH9l8ovAXSQvkw2FPuOn8A8xJ+EC5vAhjI6Q+8npBC+96QVOtXLehFIIHhnKqdgvMnz2KeMghK/XumRMzFbSOE8+3zr3dbzDSRoVa51TvyztHL6FMk1A3KM2VL3JwPHI2hawO7UPf8Q2ZcK7UbyeIMWBSwOVBEyUW4L/kcyoRJxW6nqnMiFiYKXsv/+AVFGdc563+7QDib6orA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+RMllO+mhe67hnMa1wAuC9Nr+i6kUHYq1hp7iHGJQ4=;
 b=h4zBpB3DBdz/RmHS2BwyPk7ARFK00O+17bBeTtRgv6iTtswSOhn4eYFPR8DWZwQvR4UzGuobhQMxxA3WJScsWQPOQTQUSmOsmMiqwoJ7MEUZ+Sp6rkdy84mkHBnLGnyK/HuUtGCLz8rCfpsN/57V9LaZlVStdqOHQ2TOvGmBGox7imv4cq6bJ1W9Ll0DoMLj0ISmCdK1NvNc4/9rdXsami6+EXDF7OHW6qjmB0v+OOhCL4JbvGAFsyVeV0EZLGmNZ2QBrpsOX0wq64TCRbtyEWqSHzbDI0dRns8lw5DIUK/Ok4GDq/QoeG0Mj6o0VKeRD4k7tJAunB9+XKCQtCn6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+RMllO+mhe67hnMa1wAuC9Nr+i6kUHYq1hp7iHGJQ4=;
 b=aIwCfd1G0JSngp5kQtL7rO0xk6FDoEuo+s46RX/nrwuMTR26d0rilioKVJYhkdfMwb7mHzLMLNkagIaOjjFk+quYVkAOjLU4cQb3RG/boNFXYsqAem1NMVDt7hkMekXPYJI4gb7j1eYSm/I5dchp7wo0kpkQnz7JWjo7jLDC7mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 15:42:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 15:42:51 +0000
Message-ID: <d662f964-3b41-4f32-a544-5188b93938c2@cherry.de>
Date: Tue, 24 Jun 2025 17:42:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] usb: onboard-hub: Add support for multiple power
 supplies
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
 <20250610-usb_onboard_hub_cypress_hx3-v3-4-53f03dbc3017@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-4-53f03dbc3017@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: e96b2201-8562-4626-fbe3-08ddb335c724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk9WOTRVR1RMTUdxZHdGUUc3UllXWTRDSG9LOWJwb3Zrb3ZmUVVreVJBWTJO?=
 =?utf-8?B?NWo4WVNRRzl1ZUVLZmpoclRKaHFCYURDVHh2Umh5QWZncGlkbVNrRnkwczF5?=
 =?utf-8?B?RUFjWHo0dktybjEyVkczdyt0SmtVNkZ6RmI2dG05RDBoNUQ3RjZEQ0dyUmNG?=
 =?utf-8?B?djY3c1BiVFczbGlOYVBlVUhKcXFNMXRKdVZBekRBbWNPZjNIeVZ4cXlZRTNt?=
 =?utf-8?B?eVJnN1pYUWVJTzZEcU1hVklGQ1hGWk9TWkQ1V3RXRHhYSDhMa21rOTZ6OTNk?=
 =?utf-8?B?QjZoZ0xIekY4OHZ4VTJUc0k5MEkxcUVkYS82MHNLb1NWNWljcGdWL1FRb1RX?=
 =?utf-8?B?aC96dXFwZVl6WW9KWGF6ekpUdHhmSG5MSjRVSkZiSmJHUUhFWWQwcEZ4aXdr?=
 =?utf-8?B?Tm1RL3ArTkRqd21weWZHMVgwVEM1ekdwQmxaOFp2dHB1a3JlbDUwMFQ5czVq?=
 =?utf-8?B?ZlRrUmNob09tR3Q4UVNEUmRZRzRQamhwbUxBei9NMitZaVVGRkRGaWN2cU9P?=
 =?utf-8?B?UmdOM1VIQzBEOFNYQzRBdGFrQjZDUlZldHNyWVJVQVhkSVZLdWxXaXRWUUZ5?=
 =?utf-8?B?WTRBWE03Y0YxclZTV0wrdzRFYzZLUmluZjNMMzY0TUVlQXF5NCtOTDlRNEFm?=
 =?utf-8?B?TnVrdTRBSE5sdUErVWpVU3M3QVBaV0JVNjVvT3k3ZVF4TTRJYU9XMGtlWXhw?=
 =?utf-8?B?RjRXTTByanp0SWowVHRXUWtyQmNFM3lEQWVJWlZxMHZLN0tSSElGQTJTc3pX?=
 =?utf-8?B?TThyaGMvd2lZbkU0eTd5Q0FoZEl4ZHF5dFZ5bDJnTXBKOXN2TVo0RGNxZVky?=
 =?utf-8?B?UkJnaUtaK1RZYzI0dzlYdVlNRWZqS010N3lhaCs1a2pVZGJtSUk1Zk5uN0tk?=
 =?utf-8?B?dytlcGFPVjhYSEpXTXN4cUhKZHBFR21lYko5akFnSnpLZXFMeDBkREFDSWRi?=
 =?utf-8?B?YnhhbUxLbnJvVG8wcFZJYXV0cDNhd2FwWUtvTWo2WTdPbVhteVRqS2YvRzBl?=
 =?utf-8?B?U0Y0bUlGZHBxUDZJNGlYVGhNNDdwS0lqYTdqSXA4RVMyWWRhdmw0ZTgxRWJi?=
 =?utf-8?B?czE1Z3B2bnBaRWNoSGtERmsrZy9GY21PbzJzTVlVRUxNdldPRWZxWGlIWjJ2?=
 =?utf-8?B?Uklic2E3NlFwUjNoWUFUUGFyek1UOEZ4ZW9IaDROdm41TWJobkE4TUZTVFZz?=
 =?utf-8?B?TC9WTS9US0ZoK0l4eWg5RE5KdUQveFV5M2lRQkx1WjNMRFlFM01GdmlwSkRT?=
 =?utf-8?B?c2xrdXM4VmtIM0NHaE00dkFSZkNKUXpHUEJKaWgyVzdVTytGT0ZKajFIS2V5?=
 =?utf-8?B?QkZhMXZTYThwZzR3dC9SRWlUYis4TDJ1OFo1Y2F3R3I3K0RZUmJKL1dhaU5V?=
 =?utf-8?B?MkpYRFhhVHdndjNnMUhQMVRUQlA1TEVsWSt0YmNwV2J1bGVycXVIM2ZRU2VU?=
 =?utf-8?B?TmM1VVJIVk55SmtPNHBDUEpPNGFheTFKYW1WV1BtUGRXdzU0ZUdqZmRHRk92?=
 =?utf-8?B?T3VjWUZQaDlEanRKcE5UVkpPRnRmNUF6Y3BkS3pSSkxac3lrb1gzOXlJa2dF?=
 =?utf-8?B?ZE5IUjlQRTJTZUdHaDNJVEYrSGxRZDJQakMxZjhFc2VZb0Y5VnU5R2FqbTY4?=
 =?utf-8?B?T0pWcitsVHhkTlA2Z1BhZ3lVRnRPc2JTVkt5MzJQYWNzT00vQk1FWXdBZ3Ns?=
 =?utf-8?B?NjQ0eS9IOVNjNWZVN2Q1QnJKMERMZXNBM0NlYWVVUjk1dDFEUXp6VEh0WXBW?=
 =?utf-8?B?a3d0ZXZHcVBzVXdRNHl4RmtNYzh5N2JrOWRXaXJVbWV0dkRjOFlQN2pBVkRY?=
 =?utf-8?B?Q2lSM2pnSmRzWGlXckhEdHpvbjhRdnNiL0g1b3gzdm1udGN2OXZDcC94NlNq?=
 =?utf-8?B?TThkSG9wNEZHOHBPd2VEejNKT0tMM1hzajBYc1J6R3JyZHdKTnMydncvclBo?=
 =?utf-8?Q?FxjCz2LNEbc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JSZG1DUEhJZUNhbTluSUlmRVVhazhxRW1QRzNzNVhJZEhmb3d5VkZlV0NH?=
 =?utf-8?B?VDZxVFpKL2w3aGlxV09OelY4OVRmTm5wcWVEeENjaUpHandDS21uQkZYMFpL?=
 =?utf-8?B?MWtsSnBaUTVOV1ZSMWJ2WG52NU1hd0RuaGVYNzRwelU3OHpJUi8zUmR1RWlS?=
 =?utf-8?B?SEZqNjg5SEJqNHpVaFUrNkJPWVJNc25TZ2EzUC9Zd29saFNCdHl5V3dsd3Vx?=
 =?utf-8?B?aXh1eUUyK0pGMWNETjZpMGZ2SkxISnliZzhseTRodWpZZGE5bDc4eXgrYWcw?=
 =?utf-8?B?OFZXUXdqS2J0OGpiZS9SeEpUc28yQTB6WC90RzlLRC9xYXFCZklvTzU5OEZp?=
 =?utf-8?B?RnVpNGtNaDZxOHJRc3dTZVJHa0NhQTdtTFlKaU03dnJST1IybTE4VTkvVDNq?=
 =?utf-8?B?V2lCZ0hWbUdRLzJtdmx2cVQvMHlpeHNtSDQzSE1odGkyWVVleGZ2bjhydEM1?=
 =?utf-8?B?V2lycFdLTEZQS3VFVGtyb0Y2S0JhZ3hTaWZIaGhNU2F2SUprUWJYQnlheFR5?=
 =?utf-8?B?cXIvVk1CUkRTaW4rU0lndVR4VVJtMXEvQXR6NjZ0RDQ0ZVhLUXhKWjVLbTJT?=
 =?utf-8?B?VFRRM0JvVEg4TksvRlc2SGFxaVBaTlhML3FoQjZ2R1NSMUkrMFJKQ0MrdDl5?=
 =?utf-8?B?NVJJQnlpWkh3OTFXWkljU3lXcnZrSFJ4UmZRcHZoNHNTejd5WnFIUGQ0QzRq?=
 =?utf-8?B?Wlc5SEFXNnhvZWgwVkZTR0ZCUm5mbG1LMFhDdkd1bS93T3lHRWhtMGswd1E1?=
 =?utf-8?B?RzdlZVd6MkFoVXE0ZEJ0K0U3NkJ3WG12UzJYQU1yeHdHbDVMS1BuMDE2YU5W?=
 =?utf-8?B?L05Nemd3THowdHZHQUNsZU5OQnB0ODhSWDNqS3BBTjFxam9EVnpldFlQcnU1?=
 =?utf-8?B?bjFQNm83ZTV6Q0VsM0dLcTgxcUhTNEJxV2plRUY1THA0bGkxbmxiNlI0QmI2?=
 =?utf-8?B?MDA5SmVBU2lqakhScnlBblVoZzlna3ZUalplSXZYMjEva1J1M28zSTNCMHk0?=
 =?utf-8?B?M1h0dDJNNUhNeWRuRERzbDdyZ2wySUUvdTBFbmRKVTFDWmNodUNsdUdFakRN?=
 =?utf-8?B?VG5lM0F6a00va01CVVA3eEp5NjBWVHpSMHR6VFZnc013d21RRE1hMGlhK3NL?=
 =?utf-8?B?TjBpb2Y3MkI3d3N2Q21YVFFkTkk5OGlRclYxQlQ5SVpHZ1JHVkYzL0thZkpj?=
 =?utf-8?B?TFUxTy83T0g1RklNN2tNZFZPd3ZWZ1Rmakdlc3M4eEkwRGlFZ05WTFdvK0F1?=
 =?utf-8?B?NU1NR0hhcUJFcWxhUmhhK0ZzbXlVQ3gvV3BEMUFhTU5jRC9mYjA4SW5EeVMv?=
 =?utf-8?B?QmovVzJZSnZNMGhWTUtNTjB3MHF6NnRiRnQ2LzdRYk5ZNnc2Qi9rSGU1MEFp?=
 =?utf-8?B?TmEyUFBlNjI5eVZCR0cwMkxkUDdoTHkxbGxWc0N4T0s3cUkwQmd6dW94WkR2?=
 =?utf-8?B?WDcyWlZra2JxUGcvaHd3cUt6SDBuUHN6eGxlVitxUVFHb1htOE8xTXd4S3Mv?=
 =?utf-8?B?SWQxK3FndVNTOEdYdStwYzc2Rm9wbGFUWDFqcFFLU1pDTUVBdXRaVGcrMmRM?=
 =?utf-8?B?NC9jeVdpNFJtaXg3cmpUeXRWVXhLWGlyaDBtdjFpQlVGdkRVUitPK09GcjB5?=
 =?utf-8?B?NVlNa0xPMThpSlJxYkpTMXdTcmgzY01IbkpIbEtNanZQUE03Z01rK2dkQTZ4?=
 =?utf-8?B?WDQ0ZzVUNjZBa00ycm4xVm04eDFBWFJOb0NpMFhZU3J3YmdxSkxHV0h0bk9R?=
 =?utf-8?B?dUgzOGxkSnp3RkhhSTFwVW0xQVVzQk1jallBNFEzUERQWDZxeG5vWmtpNENU?=
 =?utf-8?B?V0NyRHFIczh2TUp2YWRGVzRmTStNdHlVRkpCMDNBUGNtcUtXTTMzVStqR29x?=
 =?utf-8?B?RmdqSEwwcTFMeXFXV3BwYStTSWxLS3hrSE4ycWZCUERwZm1acWZGd3dwS2k4?=
 =?utf-8?B?WmI0ME5PZEk1bWdPc3l5cVJBdUFScVo2ODk3czc2VE1XZHltVG8wWHg4S2xh?=
 =?utf-8?B?V3JqV3dIemU3VVFZYmZYK0tkd1RPUkhTQzJHem5rTHF3Ykt3amZVV2haUkgv?=
 =?utf-8?B?QWRvd1ArRUFSN3dMOUZDQkpvbVR3Z2p3UDJaNDZweFRXSnR2QkJsa3Q0bUlh?=
 =?utf-8?B?cmNOQXBFa0VrNmc5cC9FUWlvYlg1SzYzZVQrc0t5Uko2L3BCaVhKUUdMQ1Y0?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e96b2201-8562-4626-fbe3-08ddb335c724
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:42:51.4412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUr1SJr4WZgQG4Bnz5TLw8ASBLm77n36Tcgw5/QC/xyOC3FGWQ6G2LqsjElBJkVb5t701pf7CWVbHyTMn/yZSL148O47wgPUThw520dazvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9621
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

Hi Lukasz,

On 6/10/25 10:02 AM, Lukasz Czechowski wrote:
> Some of the onboard hubs require multiple power supplies, so extend
> the driver to support them.
> The implementation is inspired by the kernel driver, as introduced
> by commit [1] in the v6.10 kernel.
> 
> [1] https://github.com/torvalds/linux/commit/ec1848cd5df426f57a7f6a8a6b95b69259c52cfc
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   common/usb_onboard_hub.c | 67 ++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 046831d09668..273b626dbaee 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -20,14 +20,18 @@
>   #define USB5744_CONFIG_REG_ACCESS	0x0037
>   #define USB5744_CONFIG_REG_ACCESS_LSB	0x99
>   
> +#define MAX_SUPPLIES 2
> +
>   struct onboard_hub {
> -	struct udevice *vdd;
> +	struct udevice *vdd[MAX_SUPPLIES];
>   	struct gpio_desc *reset_gpio;
>   };
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
>   	unsigned long power_on_delay_us;
> +	unsigned int num_supplies;
> +	const char * const supply_names[MAX_SUPPLIES];
>   	int (*init)(struct udevice *dev);
>   };
>   
> @@ -139,30 +143,58 @@ int usb_onboard_hub_reset(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int usb_onboard_hub_power_off(struct udevice *dev)
> +{
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
> +	struct onboard_hub *hub = dev_get_priv(dev);
> +	int ret = 0, ret2;
> +	int i;

Could be on the same line with ret and ret2.

I assume this was maybe due to using an unsigned int in the beginning 
but then the descending for-loop just below would never return because 
"i" would never be less than 0?

An option could be to have i represent the index + 1 and then whenever 
you use i to access an item in the array, you use i-1 instead.

So something like

for (i = data->num_supplies; i > 0; i--) {
     if (hub->vdd[i - 1]) {
         ret2 = regulator_set_enable_if_allowed(hub->vdd[i - 1], false);
         if (ret2 && ret2 != -ENOSYS) {
             dev_err(dev, "can't disable %s: %d\n", data->supply_names[i 
- 1], ret2);
             ret |= ret2;
         }
     }
}

instead maybe? No strong opinion on my side on that. We could probably 
even go for an u8 instead since it's very unlikely we'll have more than 
255 supplies for a given hub :)

> +
> +	for (i = data->num_supplies - 1; i >= 0; i--)
> +		if (hub->vdd[i]) {
> +			ret2 = regulator_set_enable_if_allowed(hub->vdd[i], false);
> +			if (ret2 && ret2 != -ENOSYS) {
> +				dev_err(dev, "can't disable %s: %d\n", data->supply_names[i], ret2);
> +				ret |= ret2;
> +			}
> +		}
> +

Please have the for-loop have curly brackets.

Aside from those minor nitpicks, looks good to me so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
