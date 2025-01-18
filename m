Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB0AC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464DD8063E;
	Sat, 18 Jan 2025 09:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IWf20kgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EA38070C; Sat, 18 Jan 2025 09:35:34 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB6880312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd75izmbN//08OuLyOwe5etkxeHNCWxkJroNEYJ+6dqSXNZcpGwwR3prsX/UwgLhq5VazonyZNLhs3I1D+ndpmdU9kxg8wyEXTf1CgcsSr+NrQOImgiU66R0OUHur8LFb3GuDfzi2FsuXOEmwi+NzVMaaqaYpaV8DfN/Yt736hFxR0lugvAE6cB9C9ekmsUFC7MeFaI7GL+pD6BUDfZnyiubkWekN/t6TyLv0eKG1CrthwrGnj8+zt2+SvRx0N1opSyz8VazdaNaQy31grhz++4NW6ScFM7SVorw5fxvt2fIoRC/qUOSLxOk6NHkdHKQZTIfQTf61QuCUeNriNaklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98J0t+4g4Ojf6lbqEYjlNLWK8sfxkGJEe7VxmKuHPuM=;
 b=xe/CHCaY7D+ddNR9Fr80+NCxQSlal2egIkpPXsHShkLghnTv/qLWIowYH4EcltkgI1TaiVlV028VcKZXkJYVdinsEuySQp7QYD9aBi6gah9wU+xHkePchSicD4V8POYSYiSQLDYQWZx8zUQl6QBft/plqN3CJQGBxsxqeCZpGEu78312DPml1OQrw9GvS+FCtGVfdgDJn4xPy5EkCNUflAgqgzIP/pTssBpJ+sT9jbRuM9J0o8lHOuUjCW3BcNjqYTtC8Ysl0/oFge+2gQPr6Ppnih4+VGZ68QHha5gluBrBLnsFaOieXM7r3bm9R9h95PDlVkLxeBDYt8RKhUAcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98J0t+4g4Ojf6lbqEYjlNLWK8sfxkGJEe7VxmKuHPuM=;
 b=IWf20kgwrn36cQCBWqgUBx1mzhV7AnhQ9RvVRvJPCRI+HNMrSkpoXTQtloLkshoI67irKHyjNUUYkr33sM24fQ4GcyCFs+5jJDHVykc8NWlc8gtQqhZVfX9wZSXMNGgNiWmoOzeEQnTQK8rtA0Wl36WJeEcT4akicJTwNw/BIZQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB6959.jpnprd01.prod.outlook.com (2603:1096:400:d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sat, 18 Jan
 2025 08:35:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 08:35:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Rob Herring <robh@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>
CC: "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: RE: [RFC] Adding bootsource and reset-source* to /chosen
Thread-Topic: [RFC] Adding bootsource and reset-source* to /chosen
Thread-Index: AQHbZsQGOZPljJvnFk6LmV+wO/MKIbMbPK6AgAD9e6A=
Date: Sat, 18 Jan 2025 08:35:22 +0000
Message-ID: <TY3PR01MB11346FA60E3163A19FA8B206086E52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <48defa98-9718-4997-86cb-b171187708a6@cherry.de>
 <CAL_JsqLJ86n8iX5wt4dEuZz6rudxXKFOuuEGXbk7f4ydvTZLjg@mail.gmail.com>
 <a56549fe-8071-4bc0-9f37-6e857f6c4eea@cherry.de>
In-Reply-To: <a56549fe-8071-4bc0-9f37-6e857f6c4eea@cherry.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB6959:EE_
x-ms-office365-filtering-correlation-id: f901b189-2ace-48d5-9fe6-08dd379b0c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWNxalNLaUVuQm40UFBNb1hxaVZvS1RYSXplcHVzYUsvbGtKeGhwSzBqQ25B?=
 =?utf-8?B?L2hZbGgyZk05OXl2YThlMGRjM1VJMVoyWm5rSXNuaXZtUDNkZXlOTTJtRmFJ?=
 =?utf-8?B?U0M0a3JSQVo0bzdhZ0pYKzJDKzk0MTRZTzBBdTFKajJ6eHpiTFJUQjNHaU0r?=
 =?utf-8?B?dHI5aWxWb084TzFDWGsybkZ6WFpLdFgxMHJXTWw5ZUtYWjYyaks2R1RyZW5G?=
 =?utf-8?B?Y0JIMDJibDFJcHJPVzVPNTdxZ0hVSkFRMUYvOTRqbWcvKzBkUkxzYldVQUxq?=
 =?utf-8?B?dzFiOEZwejhlMnFvTlU5d1ZqalFZL1dnZlkvL2E2QVJMRDQrUDRneEY5aDhQ?=
 =?utf-8?B?RHo1YUh6SUpSSlF4KzhsVzRoMFkyblcwWExFOU1vVHNaYmFvNTUwTkdrWmdG?=
 =?utf-8?B?VkdHZXdWNDFxak04TDFVMU9ZaW90REF6QmM4QkRwN0kzUmpaNzA2OE1Rak5P?=
 =?utf-8?B?SlRpeWtJWFJhNzlCYnlvVmQzZXJSNFREUUxIVWFPdXZpbDM0OTJ6VFhvVHRO?=
 =?utf-8?B?SER6WGV6WitRY0QvcVNKVEFHMi9jekRtYVFRWFlyQU9Md2RZYkx0U0M5eUdB?=
 =?utf-8?B?QTg4NGhjZWVrWjJSM3pLcGZWMmRSa2ZVMEd2dWYxRmY2T2pTeDdmSFRIaUNz?=
 =?utf-8?B?WHk3RmV6WFJVUy91VVM1SmtyMGlJQkF6Vi8zMGlqbnNxcUd2ZmV5VnJadkZZ?=
 =?utf-8?B?WG5QYkJJbEw2ODVwL29sSnJPRnBJVlJYMUkwS0RuTk9TckJ2eUF6dEpINXZr?=
 =?utf-8?B?Z1ZkUGFvWXdMMUs3L2tweDlWcnZzWURhNFZvMmJGZEZWVlg0Y29Vd0VEVElR?=
 =?utf-8?B?dE1FT0VVUkh6ZjZMS2l4NzlVV2pQV2xKdkxadDd0YWVtVnhEcVdWblVHQ2Zl?=
 =?utf-8?B?OGtzUEh1bVZOWnJKUWtpd0pmMWZaQUIyZFhjbmhUdWxzQWhoRjRXU1dTWGw2?=
 =?utf-8?B?TGEwN3RLUndxTmxYTjErc3ZlbFEwKys1Z0dvaVNFNlE1WXEzUXJjUDJPYTVQ?=
 =?utf-8?B?c1JMbTZONTMvc0I1T3p5T2hmVXdsMktjOTRmQUhBcXMxbkpHMFJKRG83QjRC?=
 =?utf-8?B?eGRPTjVLTXE5MXVoTjVWZ0FwRmlWV1A3ZzF3OGRncG5SV1Z5eWNEWmtxSzRm?=
 =?utf-8?B?TDJLVUFpYmJDOUN2RzMrUmFvZVlyUnBHaXcvN2FZY01yMGZhVDMyZjJ3ZlRa?=
 =?utf-8?B?YnlEbTNDSVZubmZPOWxoT1Q5dTBnUGNCZGFqU29aY0wrV1I4S0pZS2VkOHpZ?=
 =?utf-8?B?elg5SXRFRTI4bHVsSVI1ZVhIdnoyVlBHL2tSWEVTTVhUOUZWSGJzZ3FSOUhK?=
 =?utf-8?B?d2x1TDU0RmxvZUJEZGxQenJJcmU1M2gzWFNkZnFmVHBpWDkvc0R5R3A0SVpu?=
 =?utf-8?B?em1HM0crbzZjOFB2cGRabitsWXJoYy9XamVCZkhsM0hVSFJ2UHZSMVJvY1hn?=
 =?utf-8?B?RzRCMWhIV0h0RGpZbytDa0xnMmtiMDRoT0dWbmxXWVU5dkdLdVBMakJ1QkV3?=
 =?utf-8?B?WFBJSW1NaHFpb1lnbEF3cmxmS2l2OWJtY1ZIUWNTMnR5VTUwckFSNi8rNWxT?=
 =?utf-8?B?WG1YNC9EdWZiWEV2bGxqU1RaU2hEUEIwU3ljSFR4MHQ5eDlPNWFXK1lVUnk3?=
 =?utf-8?B?TVlnNnVIUzI1bTdyS1N0YXF3amxoRWdtZVIyaG4xdXdSMTRRVkVsQm1rYmw4?=
 =?utf-8?B?YlEvRlVTb0FMa2NEblppamh6WmdMcCtRYWU3NFhRVGNVSVJTNDZKU1Y2OUZU?=
 =?utf-8?B?WmhybS9RTGx0YXRZNjVyMGU2MDlJQ2Y5QjJCTDBFcFh3VlBsT1BsbXh3OWdm?=
 =?utf-8?B?QjZPMWdhYzU1Vk5NYXBjTCtpeFI1YWJwSnpxRXJnZjUya0ZHelBYcG8zYWdN?=
 =?utf-8?B?Rm4xMW05dzRObUhTL1J1dlNXbkJ5cTMxZE9MOEtrWjh0UXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFpWU3duWnhMbmE2T01TSjB0VE5XOTcvV3laV2MwTnJtN1RJeWh6K3dYdmpw?=
 =?utf-8?B?RTNuUnZuQmQ0WmYrZEZ5dzc4L0VpeFBnRXlCV0Q1dnVjUE9kY2FtZThSTXhP?=
 =?utf-8?B?dUtqN0E1VGxyT2dmeHc3TWpBVGN6WDVRNVFLOTlFdFFUeEo0K1drdjlCR1c4?=
 =?utf-8?B?RzFlTTJLL3ZMb0EvMTc2S2tKMHloN3NXQTJ5bElHcm1RYTNNY25pZkhPcVkx?=
 =?utf-8?B?NjNIZWpVayt5RWpHNThZN3JVOW9CSGtQcUR2WXNyMnJzcllZaVRRV1JObzZT?=
 =?utf-8?B?SUEvZDBEaWRUTjJCTEdsYm9DeDhBYXo0aTgzd21ENm9ZRldtN0RlRW40L1I0?=
 =?utf-8?B?dUxBdURTV3BEdEN4TEtaSko1RjQ0N0R4M2lSdGpBb0t5UmpOVXdKVmlWUWJ0?=
 =?utf-8?B?MnJOZ1duRVE4aWZPbVg4NnQxWWNLT1JkNTlKVWsrTDZnL3hpV0lTYmk0MHpU?=
 =?utf-8?B?QWZ4eTA4cGptN2IvU2tKRTFvK0NXcXNYU0I5amx5dmF6NU96QUZoWVZ4V1Vi?=
 =?utf-8?B?N2lPNkhpcnh5MTJnOGlQcVpLNXdoWGxQUkpOZGRkY1MyZThaRS8rZU1SeCt5?=
 =?utf-8?B?cnJ1MGkzNjZENUFHcEhTVkU1YXRVMEtyR3dhQmpmREtsNFc0SlgrdlpvZkhO?=
 =?utf-8?B?QmlsTFNFOVFmdnkxRDREdWNVUC9wdzI2SVNNYnRnK0grZElxL2ZOMXZtenBK?=
 =?utf-8?B?ZzFxOTJwVWxZSUZjTC9KVFpJL3hOcnRGSXpvWHJ3K1dYWlpaVklmVVJoYmhJ?=
 =?utf-8?B?bnBFR013ZVFMczNTRmJHTnRtSUE2eEJyOGZNQmdXam85R2VsOVpiYzE4Qk02?=
 =?utf-8?B?c1RmbVVpei9lc2NiV2VzWUVva1dKRnJyQ3ZMaG52bWNnckkyQUhudzlFL0N1?=
 =?utf-8?B?WFVjM2J4dFVVK3ZtU3hGaVRVc2czOFc2SGg4Qm9vWWV5Tm5WS2ZiUVdUUlh3?=
 =?utf-8?B?Q3Q5bG5kb3RJWEdlaXVrQTZWOTVmcHFYTGxmSFNVNDljTWxZdTRlb2NCc1pF?=
 =?utf-8?B?eXVacjBlUFBRRjVBeGZ5c0dyN2E4dzFxc1l4RXQ1a3ljMkN1ZVE4SUxuaFZI?=
 =?utf-8?B?bDFFUjROWkFSQlozNjlkSGVBRzkxYngvRTJ4Z2g1bXc5eUpvV0NXMSswVEFK?=
 =?utf-8?B?c0U2Njc3WTNOdjR1eDd4M3pTVDVoWVJFUzhRbXp0MlB4bWh2eFFRMVRQbWUv?=
 =?utf-8?B?WVAyUzF5NmNhZUJoZWNXc2ZYU1BNckdaWm1nY25NKzdscERTUkwvcXVGUWhq?=
 =?utf-8?B?VmtnbmQ5Z2tSSktpN3c4TDBOeis0anZ0OG5RbHdjS3R0MXE0TGRjOEZnUnZp?=
 =?utf-8?B?UFpwUlN3MndHdHZDVWRLRCtUQjhjU3pxUnVVeTBkdzVnSmVMS0EwYUl4c1J5?=
 =?utf-8?B?eFpTdDVveTQxRUN5TnBrSTQ2RlJ5czNyTTVQdWZ5QkFHK2hqQXc0cC9nMnU1?=
 =?utf-8?B?ZVdiWUtCUDFDUFdadTgrdFJVWkxzYXJLZDg4cUZ3S2dGY2FjeFg0RXozTTdX?=
 =?utf-8?B?K29qemF3R3doOVFJUXd5UjB2alRvanNpMWdUWDU2TndNUDJ0eWhuUUwvTE5M?=
 =?utf-8?B?bTgrMzAwZkJjdnRyL3VkV3RTUm96Ry9pQXpyUkhzckR2UzMxc1BsWmFWZnlV?=
 =?utf-8?B?WDRPVVVqRzcwcEJmOWRCblNtbUx2cTVWNmtKSjNFZWg5UVRYb2FVYVVRK3lm?=
 =?utf-8?B?ZEg1MjRxR2EraWFOMFUyN3MyZXZXam1vRW9KWE1XSHFzMXNkSmFPQjJKSlJq?=
 =?utf-8?B?M3B0Ri83TmttOVJaMTRJYUdZSkNMMVV2SWd1eTlxUmJvcG5UYndSajB2ZC9j?=
 =?utf-8?B?SW05S0hld3NJMVdZRnNndmZzemQxSUJKMkhodHIwb3M1bTFWQUlVaWJqYnJp?=
 =?utf-8?B?S2EwdDhudGVpTUQ1b0RBd0d1aklzbjN4bU4rdlhZRVIrdkNXUVVNSUtGN2J5?=
 =?utf-8?B?Y2Y0R2c4OWR4QXFUNHkwMnJiT1BkR2JpZmhYaTkwMldNNWhIU1g1WjExc3hX?=
 =?utf-8?B?RVI1TGxCSFI4UFZxL0prcWZyRmRFb0p6bG9KdkQ5VDcvTElYalU0dzRkSEZa?=
 =?utf-8?B?VUc3TGVId2UvY2FOSzhkcE96c2Rhby9KQ25RUUsyZktqeEozWmttV3FKOGNj?=
 =?utf-8?B?T0tsRUhYT25VVUNrTWx1ZzFmcHRnYlRmVnVlMmdER01pajRvMWNveit2eU9V?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f901b189-2ace-48d5-9fe6-08dd379b0c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 08:35:22.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cmlsDvq5mR4VB4WNleDhFKI4mSmMQNts2HJhFExCSoHUMb2NRbLz84fhK45Fjyxa5mZ+5av4C1d5mePTAJR2C8VQv++JjZ+MMTnFeM48To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6959
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

KyBHdWVudGVyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVS1Cb290
IDx1LWJvb3QtYm91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgUXVlbnRpbiBTY2h1
bHoNCj4gU2VudDogMTcgSmFudWFyeSAyMDI1IDE3OjI4DQo+IFRvOiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KPiBDYzogZGV2aWNldHJlZS1zcGVjQHZnZXIua2VybmVsLm9yZzsgVS1C
b290IE1haWxpbmcgTGlzdCA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+IFN1YmplY3Q6IFJlOiBb
UkZDXSBBZGRpbmcgYm9vdHNvdXJjZSBhbmQgcmVzZXQtc291cmNlKiB0byAvY2hvc2VuDQo+IA0K
PiBIaSBSb2IsDQo+IA0KPiBPbiAxLzE0LzI1IDk6MzYgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiA+IE9uIEZyaSwgRGVjIDEzLCAyMDI0IGF0IDEyOjA44oCvUE0gUXVlbnRpbiBTY2h1bHoNCj4g
PiA8cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPiB3cm90ZToNCj4gPj4NCj4gPj4gSGkgYWxsLA0K
PiA+Pg0KPiA+PiBJbiBVLUJvb3QsIHRoZXJlIGFyZSBtdWx0aXBsZSBzdGFnZXMgd2hpY2ggY2Fu
IGJlIGxvYWRlZCBmcm9tDQo+ID4+IGRpZmZlcmVudCBtZWRpYSBlYWNoLiBPbiBSb2NrY2hpcCBT
b0NzLCBpdCBtb3N0bHkgZ29lcyB0aGlzIHdheSwgU29DDQo+ID4+IEJvb3RST00gbG9hZHMgZnJv
bSBhIG1lZGl1bSAoc3RvcmFnZSBvciBvdmVyIFVTQikgYW5kIGV4ZWN1dGVzIHRoZQ0KPiA+PiBU
UEwgKG9yIFNQTCBpZiBubyBUUEwgc3VwcG9ydGVkKSwgdGhlIFRQTCBnb2VzIGJhY2sgdG8gQm9v
dFJPTSBhbmQNCj4gPj4gcmVhZHMgdGhlIFNQTCBmcm9tIHRoZSBzYW1lIG1lZGl1bSBhbmQgZXhl
Y3V0ZXMgaXQuIFRoZSBTUEwgd2lsbA0KPiA+PiBmYXZvciB0aGUgc2FtZSBtZWRpdW0gZm9yIGxv
YWRpbmcgdGhlIFUtQm9vdCBGSVQgaW1hZ2UgKGNvbnRhaW5pbmcNCj4gPj4gVEYtQSBCTDMxLCBP
UC1URUUgT1MgQkwzMiBhbmQgVS1Cb290IHByb3BlciBpbWFnZSksIGJ1dCBpbiBjYXNlIGl0DQo+
ID4+IGZhaWxzLCBmYWxscyBiYWNrIHRvIG90aGVyIHBvc3NpYmxlIG1lZGlhLiBJbiBVLUJvb3Qg
d2UgaGF2ZSB0aGUNCj4gPj4gc3RvcmFnZSBtZWRpdW0gdXNlZCBmb3IgbG9hZGluZyB0aGUgVS1C
b290IEZJVCBpbWFnZSBzdG9yZWQgaW4gdGhlDQo+ID4+IERUQiB1bmRlciAvY2hvc2VuL3UtYm9v
dCxzcGwtYm9vdC1kZXZpY2UgcHJvcGVydHkuIEJ1dCB3ZSBkbyBub3QgaGF2ZQ0KPiA+PiBhIHBy
b3BlcnR5IGZvciB0aGUgbWVkaXVtIHRoZSBCb290Uk9NIGxvYWRlZCB0aGUgVFBMIChvciBTUEwp
IGZyb20uDQo+ID4+IFRoaXMgY291bGQgYmUgdXNlZnVsIGluZm9ybWF0aW9uLiBGb3IgZXhhbXBs
ZSwgSSBoYXZlIHNvbWUgQ0kgd2hlcmUgSQ0KPiA+PiB3YW50IHRvIGNoZWNrIHdoZXRoZXIgdGhl
IEJvb3RST00gbG9hZGVkIHRoZSBUUEwgZnJvbSB0aGUgZXhwZWN0ZWQNCj4gPj4gbG9jYXRpb24g
KGltcG9ydGFudCB3aGVuIGNoZWNraW5nIHRoYXQgdGhleSBhbGwgd29yayBhbmQgZG9uJ3QgZGVw
ZW5kDQo+ID4+IG9uIGEgYm9vdGxvYWRlciBmbGFzaGVkIGluIGEgZmFsbGJhY2sgbWVkaXVtIGZv
ciBleGFtcGxlKS4gQW5vdGhlcg0KPiA+PiB1c2VjYXNlIGNvdWxkIGJlIHRvIGRldGVjdCB3aGVu
ZXZlciBvbmUgbG9hZHMgdGhlIFRQTCBmcm9tIFVTQiAobm90IGENCj4gPj4gVVNCIHN0aWNrLCBz
b21lIFVTQiB0cmFuc2Zlcjsgc2VlIHJvY2t1c2IgZm9yIFJvY2tjaGlwIGZvciBleGFtcGxlKQ0K
PiA+PiBhbmQgZGVjaWRlIHRvIGRvIHNvbWV0aGluZyBlbHNlIGluIFUtQm9vdCBvciB0aGUgT1Mg
ZGVwZW5kaW5nIG9uIHRoYXQNCj4gPj4gKGNvdWxkIGJlIHN0YXJ0aW5nIERGVSBmb3IgZmxhc2hp
bmcgdGhlIGRldmljZSwgb3IgZmFzdGJvb3QgZm9yIGxvYWRpbmcgdGhlIHJlc3Qgb2YgdGhlIHN5
c3RlbSkuDQo+ID4+DQo+ID4+IEJhcmVib3ggY3VycmVudGx5IGRvZXMgdGhhdCBieSBzZXR0aW5n
IC9jaG9zZW4vYm9vdHNvdXJjZSB0byB0aGUgZnVsbA0KPiA+PiBwYXRoIG9mIHRoZSBkZXZpY2Ug
dGhlIEJvb3RST00gc2F5cyBpdCBib290ZWQgZnJvbSwgYnV0IHRoYXQgaXNuJ3QNCj4gPj4gcGFy
dCBvZiB0aGUgRFQgc3BlYyBzbyBiZWZvcmUgSSBhZGQgc3VwcG9ydCBpbiBVLUJvb3QgZm9yIHRo
YXQsIEknbQ0KPiA+PiBhc2tpbmcgd2hldGhlciB0aGF0J3MgZmluZSBvciBpZiB3ZSBzaG91bGQg
Y29ycmVjdCBjb3Vyc2UgaW4gQmFyZWJveA0KPiA+PiBhbmQgdXNlIGFub3RoZXIgbmFtZSBhbmQv
b3IgbG9jYXRpb24uDQo+ID4+DQo+IA0KPiBJIGRvbid0IHNlZSBhbnl0aGluZyBpbiB5b3VyIGFu
c3dlciB0aGF0IHdvdWxkIGJlIGFwcGxpY2FibGUgdG8gL2Nob3Nlbi9ib290c291cmNlLCBhbSBJ
IGNvcnJlY3QgaW4NCj4gYXNzdW1pbmcgdGhhdCB0aGlzIHBhcnQgY2FuIGdvIGFoZWFkIGFuZCBi
ZSBzdWJtaXR0ZWQgdG8gdGhlIERldmljZSBUcmVlIHNjaGVtYS9zcGVjPw0KPiANCj4gPj4gSSd2
ZSBhbHNvIGJlZW4gbWFkZSBhd2FyZSBvZiBvdGhlciAic291cmNlcyIgdGhhdCBhcmUgYWRkZWQg
dG8gdGhlDQo+ID4+IC9jaG9zZW4gbm9kZSBpbiBCYXJlYm94LCByZXNldC1zb3VyY2UsIHJlc2V0
LXNvdXJjZS1pbnN0YW5jZSBhbmQNCj4gPj4gcmVzZXQtc291cmNlLWRldmljZS4gSSBhbSBub3Qg
ZW50aXJlbHkgc3VyZSB3aGF0IHRob3NlIGV4YWN0bHkgYXJlDQo+ID4+IGZvciBCVVQgaXQgc2Vl
bXMgdGhhdCB0aGlzIGlzIG9mIGludGVyZXN0IHRvIFUtQm9vdCBhcyB3ZWxsIHNpbmNlIHdlDQo+
ID4+IGRvIHRyeSB0byByZXBvcnQgYSByZXNldCBjYXVzZSBhcyByZWFkIGZyb20gdGhlIENQVSBm
b3IgUm9ja2NoaXAgU29DcywgYy5mLg0KPiA+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS91
LWJvb3QvdjIwMjQuMTAvc291cmNlL2FyY2gvYXJtL21hY2gtcm9ja2NoaXAvY3B1LWluZm8uYyNM
MTQuDQo+ID4+IEkgYmVsaWV2ZSAvY2hvc2VuL3Jlc2V0LXNvdXJjZSB3b3VsZCBiZSB0aGUgcmVh
c29uLCBlLmcuICJQT1IiLA0KPiA+PiAiUlNUIiwgIldERyIsICJXS0UiLCAiVEhFUk0iLCBldGMu
IC9jaG9zZW4vcmVzZXQtc291cmNlLWRldmljZQ0KPiA+PiBjb250YWlucyB0aGUgbm9kZSBwYXRo
IHRvIHRoZSBkZXZpY2UgdGhhdCB0cmlnZ2VyZWQgdGhhdCwgdGhhdCBjb3VsZA0KPiA+PiBiZSB1
c2VmdWwgaW4gdGhlIGV2ZW50IHRoZXJlIGFyZSBtb3JlIHRoYW4gb25lIHRoZXJtYWwgdHJpcCBw
b2ludA0KPiA+PiAoZS5nLiBDUFUgb3IgR1BVKSwgb3IgbW9yZSB0aGFuIG9uZSBoYXJkd2FyZSB3
YXRjaGRvZyAoSSBmb3IgZXhhbXBsZQ0KPiA+PiBoYXZlIGEgc3lzdGVtIHdpdGggcG90ZW50aWFs
bHkgNDogU29DLCBQTUlDLCAyIHNlcGFyYXRlIGluIGFuDQo+ID4+IGV4dGVybmFsIE1DVSkuIEkg
Z3Vlc3MgL2Nob3Nlbi9yZXNldC1zb3VyY2UtaW5zdGFuY2UgaXMgZm9yIEhXIGJsb2Nrcw0KPiA+
PiB0aGF0IGV4cG9zZSB0aGUgc2FtZSByZXNldCBidXQgZnJvbSB0d28gZGlmZmVyZW50IHNvdXJj
ZXMgd2hpY2gNCj4gPj4gYXJlbid0IG1vZGVsZWQgaW4gRGV2aWNlIFRyZWUuIEFnYWluLCB0aGlz
IHdvdWxkIGJlIHVzZWZ1bCBmb3IgdGhlDQo+ID4+IGJvb3Rsb2FkZXIgb3IgT1MgdG8gZGVjaWRl
IHRvIGRvIHNvbWV0aGluZyBlbHNlIGJhc2VkIG9uIHRoZSByZXNldA0KPiA+PiBjYXVzZSAoZS5n
LiBoYXZlIGRhdGEgb24gd2h5IHNvbWUgZGV2aWNlcyByZWJvb3QgaW4gdGhlIGZpZWxkLCBlLmcu
DQo+ID4+IGJlY2F1c2Ugb2YgdGhlcm1hbHMsIHBvd2VyIGxvc3MsIGJyb3dub3V0LCBldGMuLiku
DQo+ID4NCj4gPiBJcyB0aGUgaGFuZGxpbmcgb2YgdGhlc2UgcHJvcGVydGllcyBzb21ldGhpbmcg
Y29tbW9uL2dlbmVyaWMgb3IgZ29pbmcNCj4gPiB0byBiZSBkZXZpY2UgKGUuZy4gd2RvZywgcG1p
Yykgc3BlY2lmaWMuIEZvciB0aGUgZm9ybWVyLCB0aGVuIC9jaG9zZW4NCj4gPiBtYWtlcyBzZW5z
ZS4gRm9yIHRoZSBsYXR0ZXIsIG1heWJlIGV2ZXJ5dGhpbmcgYmVpbmcgaW4gdGhlIGRldmljZQ0K
PiA+IG5vZGVzIG1ha2VzIG1vcmUgc2Vuc2UuIFRoZW4geW91IHdvdWxkbid0IG5lZWQgYSBsaW5r
IHRvIHRoZSBkZXZpY2UuDQo+ID4NCj4gDQo+IEkgd291bGQgaW1hZ2luZSByZXNldC1zb3VyY2Ug
KHRoZSByZWFzb24pIHRvIGJlIGRldmljZS1zcGVjaWZpYy4gSSdtIHN1cmUgdGhlcmUnbGwgYmUg
c29tZSBIVyBpbiB0aGUNCj4gZnV0dXJlIHdpdGggc29tZSBvZGQgcmVhc29uIHRvIGRvIGEgZnVs
bCBIVyByZXNldCBvciBzb21laG93IHN1cHBvcnQgMTAgZGlmZmVyZW50IHdhdGNoZG9ncyBpbiB0
aGUNCj4gc2FtZSBJUCBhbmQgd2UgbWF5IHdhbnQgdG8ga25vdyB3aGljaCBvbmUgdHJpZ2dlcmVk
IGl0LCBJIGFzc3VtZSBmb3IgdGhhdCB3ZSB3b3VsZG4ndCB3YW50IFdERzEgdG8NCj4gV0RHMTAg
YXMgcG9zc2libGUgcmVzZXQtc291cmNlPyBUaG91Z2ggaXQgc2VlbXMgdGhhdCdzIHdoYXQgcmVz
ZXQtc291cmNlLWluc3RhbmNlIHdvdWxkIGJlIGZvci4gRG8gd2UNCj4gd2FudCB0byBsaW1pdCB3
aGF0IHRoZSB2YWx1ZXMgb2YgL2Nob3Nlbi9yZXNldC1zb3VyY2UgY291bGQgYmUgaW4gdGhlIHNj
aGVtYT8gZS5nLiBXREcgZm9yIHdhdGNoZG9nDQo+IHJlc2V0LCBUSEVSTSBmb3IgdGVtcGVyYXR1
cmUgdGhyZXNob2xkIGV4Y2VlZGVkLCBldGMuLg0KPiANCj4gVGhlIGlzc3VlIEkgc2VlIHdpdGgg
bm90IGhhdmluZyAvY2hvc2VuL3Jlc2V0LXNvdXJjZS1kZXZpY2UgYnV0IGhhdmUgc29tZSBvdGhl
ciBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNlDQo+IG5vZGUgYXJlIHR3byBmb2xkczoNCj4gDQo+IC0g
aW4gb3JkZXIgdG8ga25vdyB3aGljaCBkZXZpY2UgdHJpZ2dlcmVkIHRoZSByZXNldCwgb25lIHdp
bGwgbmVlZCB0byBwYXJzZSB0aGUgd2hvbGUgdHJlZSBmb3IgYQ0KPiBzcGVjaWZpYyBwcm9wZXJ0
eSwNCj4gLSBJIGNvdWxkIGltYWdpbmUgYSBzY2VuYXJpbyB3aGVyZSBhIGRldmljZSBub3Qgc3Vw
cG9ydGVkIGJ5IHRoZSBPUyAob3Igb25seSBhdXRvLWRpc2NvdmVyYWJsZT8pDQo+IHRyaWdnZXJz
IGEgSFcgcmVzZXQgKGUuZy4gZnJvbSBURi1BLCBPUC1URUUsIGEgc2lkZWNhciBtaWNyb2NvbnRy
b2xsZXIsIGV0Yy4uLiksIEkgd291bGRuJ3QgYmUgYWJsZSB0bw0KPiBhZGQgdGhlIHByb3BlcnR5
IHRvIGEgbm9kZS4gSSBhbHNvIGNvbmNlZGUgdGhhdCBJIGRvbid0IGtub3cgd2hhdCBraW5kIG9m
IHBhdGggd291bGQgbWFrZSBzZW5zZSBpbg0KPiB0aGF0IHByb3BlcnR5IGluIHRoYXQgZXZlbnQs
IHNvIG1heWJlIHRoYXQncyBzb21ldGhpbmcgd2UgY2FuIGp1c3QgaWdub3JlIGZvciB0aGUgbW9t
ZW50LCBvciBpcyBub3QNCj4gcmVhbGlzdGljLg0KPiANCj4gPj4gSSdtIHJlYWNoaW5nIG91dCB0
byB0aGUgZGV2aWNldHJlZS1zcGVjIGNvbW11bml0eSBiZWZvcmUgSSBhZGQgY29kZQ0KPiA+PiBp
biBVLUJvb3QgdG8gaW1wbGVtZW50IHRoaXMgc28gd2UgZG9uJ3QgYWRkIHVubmVjZXNzYXJ5IGJh
Y2t3YXJkDQo+ID4+IGNvbXBhdGliaWxpdHkgY29kZSwgd2VyZSB0aGUgcHJvcGVydGllcyBvciBs
b2NhdGlvbnMgdG8gYmUgbW9kaWZpZWQNCj4gPj4gdG8gbWF0Y2ggdGhlIHNwZWMuDQo+ID4+DQo+
ID4+IERvZXMgYW55b25lIGRpc2FncmVlIHdpdGggYWRkaW5nIHRoaXMgdG8gdGhlIHNwZWM/IERv
ZXMgYW55b25lIGhhdmUNCj4gPj4gYW5vdGhlciBzdWdnZXN0aW9uIGZvciB0aGUgbmFtaW5nIG9y
IGxvY2F0aW9uIG9mIHRoZSBwcm9wZXJ0aWVzPw0KPiA+DQo+ID4gSSBhbHdheXMgZmVlbCBiZXR0
ZXIgaWYgd2UgaGF2ZSBtdWx0aXBsZSB1c2VycyBmb3IgYSBuZXcsIGNvbW1vbg0KPiA+IGJpbmRp
bmcuIEEgbmV3IGJpbmRpbmcgZXh0ZW5kZWQgYnkgYSAybmQgdXNlciBzaG9ydGx5IGFmdGVyIGRl
ZmluaW5nDQo+ID4gaXQgbWFrZXMgbWUgZ3J1bXB5LiBIZXJlJ3MgYSB0aHJlYWQgdGhhdCBjYW1l
IHVwIHdpdGggdGhlIHNhbWUgdHlwZSBvZg0KPiA+IGlzc3VlOg0KPiA+DQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMTEzMTEyMzQ5LjgwMTg3NS0xLXByYWJoYWthci5tYWhh
ZGV2LQ0KPiA+IGxhZC5yakBicC5yZW5lc2FzLmNvbS8NCj4gPg0KPiANCj4gSSBzZWUuLi4NCj4g
DQo+IFRoZSBib290bG9hZGVyIHNob3VsZCBiZSBhYmxlIHRvIGRvIHNvbWV0aGluZyBiYXNlZCBv
biB0aGUgcmVzZXQgc291cmNlIGFuZCByZXNldCBkZXZpY2UuIFNvbWUgSFcNCj4gZGV2aWNlcyBk
byBoYXZlIGNsZWFyIG9uIHJlYWQgc3RhdHVzIHJlZ2lzdGVycywgc28gZXhwZWN0aW5nIHRoZSBi
b290bG9hZGVyIHRvIG5vdCB0b3VjaCBzdGF0dXMNCj4gcmVnaXN0ZXJzIGlzIHVucmVhbGlzdGlj
IGluIG15IG9waW5pb24uDQo+IA0KPiBBbHNvLCBhcyBhIHVzZXIvZGlzdHJvIEkgd291bGQgbmVl
ZCB0byB0cnkgdG8gZ2V0IGZyb20gYWxsIHBvc3NpYmxlIGRldmljZXMgaWYgYW55IGhhcyBhIHJl
YXNvbiBmb3INCj4gdGhlIGxhc3Qgc3lzdGVtIHJlc2V0LCBhY3Jvc3MgZGlmZmVyZW50IHN1YnN5
c3RlbXMgSSBhc3N1bWUsIHNvIGRpZmZlcmVudCBBUElzIGFuZCBhbGwuIFRoaXMgc2VlbXMNCj4g
bGlrZSBhIGxvdCBvZiB3b3JrIGFuZCBlcnJvci1wcm9uZS4NCj4gDQo+IFRoZSBpc3N1ZSBjb3Vs
ZCBiZSB0aGF0IHRoZXkgbmVlZCB0aGUgZHJpdmVyIHRvIGRvIHNvbWV0aGluZyBzcGVjaWZpYyBp
ZiB0aGUgZGV2aWNlIGhhbmRsZWQgYnkgdGhhdA0KPiBkcml2ZXIgaXMgdGhlIHJlYXNvbiBmb3Ig
dGhlIGxhc3Qgc3lzdGVtIHJlc2V0LiBJZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4gd2UgY291bGQg
cGFyc2UgL2Nob3Nlbi9yZXNldC0NCj4gc291cmNlLWRldmljZSBhbmQgc2VlIGl0IGl0J3MgdGhl
IHNhbWUgcGF0aCBhcyB0aGUgZGV2aWNlJ3MgYW5kIGRvIHNvbWV0aGluZyBiYXNlZCBvbiB0aGF0
IGFuZCB0aGUNCj4gb3RoZXIgL2Nob3Nlbi9yZXNldC0qIHByb3BlcnRpZXMuIEhvd2V2ZXIsIGlm
IHRoZXJlJ3MgYSByZWFkLW9uLWNsZWFyIHN0YXR1cyByZWdpc3RlciBhbmQgd2UgZG9uJ3QNCj4g
cGFzcyBlbm91Z2ggaW5mb3JtYXRpb24gdGhyb3VnaCB0aG9zZSBwcm9wZXJ0aWVzLCB0aGUgZGV2
aWNlIGRyaXZlciB3aWxsIG5vdCBiZSBhYmxlIHRvIGhhbmRsZSB0aGluZ3MNCj4gdGhlIHdheSB0
aGV5IHdhbnQgdG8uDQo+IA0KPiBDaGVlcnMsDQo+IFF1ZW50aW4NCg==
