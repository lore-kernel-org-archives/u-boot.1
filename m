Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0529ECCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185518323A;
	Thu, 23 Oct 2025 09:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TkYX+M8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69DA83303; Thu, 23 Oct 2025 09:07:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376582E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InN6ZMJClEdDUJoROgOSRi0UTZt6CorF1M45YyGyzBxHyFJxFHhSNs0Zc5aE8TQNO1JalYvYvj0Kerw8s3/yl7WCutyWxbsYmmVG6Yys2Wyfd3OQYhziY9t330MuRBvPNT3dYmvZBbskVvHlooiEp28uXizDFAp9l73h/5MKzvQ7947/zK3hQZRa7UlI2jAHEJa7bpohHZqS/DDu2nSZUrbhmZ+vSbNoCxLB5Ft62xdq93VPXjF93MMSeRqIMaFuy+adzLp4srEw+H8lD5/g3aZ/pl+bOi4gjmXVScFvERghMtzJgo15hQDmJnIvfy8UVb2nBUDaxeeAKrAB/fFuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCV59ExBcoS8p7CKhe1OcJu6MLqOwnvZ6P2j4MZfZLs=;
 b=R3RVFZpT7afces/MbRIA1/2bhyx+D/GQWCfamv1vNg/gzHr3PQ05f1HmDozm5e74JdOL+OdOYsNyyVhPIwJH1gtKeispBZz/VBExBtgPknI5I1n88qelaGSktCM5FlEhQqFqurdIv11t5/O7u41A4Kq/cOgBBIMnBIQx6sF7NohVs7FjXrFcSI7GqDGBaN7buv/iH8fgrPVAxCqh3Evnp+rf0qxAh90FmTZW9jXlzgAW+DheEuYmg5nHXGAyTS8wEip02WBfSZDcBrsHqicZt1hT0MXdlZ/F4jH6COZuBCqYOV2Rs3xaDwCPJQCPR3myQtEDJxX6g7Qt/ofsVgSMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCV59ExBcoS8p7CKhe1OcJu6MLqOwnvZ6P2j4MZfZLs=;
 b=TkYX+M8tlLTyu1AJApC4JpYM7dSnErEsPtQxS8q9ju0YBdxuqga6hNnYoifzwIsyL5BxmoUYmkIHxhaJvh3EUWYaQFd2y0EC5fgwm38jPVvjq1Oa0rwQ8AWo9E5rQd7rwNEXEImen862Z7APbfuaE3KRf4JKd8DPKamokDu9Qrnv/fDG+72z7MLTI7YVNdk+r8O1pJIyWRjUdG+qCKOKUpB/4vqcE/PTT+/gBbvn53OZCxsU6caoo9TJYnq6+1yq3m0tTfjRkNWxBKBMZsOzidFLRQ8L1DHs9AkyGLJKP5Uz47ImfPTOIzSqQy5IGhdOL8z3GhzBcdgeynlnTL9FZA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:07:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:07:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
Subject: RE: [PATCH] power: regulator: Remove duplicate include of
 regulator_common.h
Thread-Topic: [PATCH] power: regulator: Remove duplicate include of
 regulator_common.h
Thread-Index: AQHcQ9n127zVtzmL8EOHm/+USI0MjrTPT5tQ
Date: Thu, 23 Oct 2025 07:07:36 +0000
Message-ID: <PAXPR04MB8459625FF3318D11C5CDF23D88F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251023050017.4580-1-tanmay.kathpalia@altera.com>
In-Reply-To: <20251023050017.4580-1-tanmay.kathpalia@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10023:EE_
x-ms-office365-filtering-correlation-id: f9245429-84cc-4d5b-79bf-08de1202d8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FTefw4rOUHE9pC0KvPzUp5u2rhGKyU6tW7VJUyqcK3h1vGbc6iBtxcnBqCQf?=
 =?us-ascii?Q?sL4pnxGXVOVWGrdBX9Ck8ghwikbcd8fWab4aUrMuY7Z83QiN9TialfMbI3l4?=
 =?us-ascii?Q?fCNLyAAENN87gYk2MtifopaUQuCI1z8TRLBwVWnTsNU7dFxgI79QmqOm5oxX?=
 =?us-ascii?Q?/EOnUamq72xA9YwrZfsj6b2jXvny5nnlsTPMcEc5xhXI+FbIFK8B/jp+I07a?=
 =?us-ascii?Q?tRU0ZI+NObjavJLtBlysBTrAR+YGlO1DR99S7QDP6THBg6w0IYiBosVu7pUx?=
 =?us-ascii?Q?T2zRxSUDJIrQS4co4LxYURVVcFy/nrt80wQUJCPFFO1mjMzL/gST2vrkS96z?=
 =?us-ascii?Q?vrlG9rPTenHbLywbw2NYsBksY1yA2dl8kf+I+F5JhVnefM2ml643dAQHXPWR?=
 =?us-ascii?Q?KmlwFCSpBk7GQQzrusFqwGsOfk1F83liIArNURPcMtnEdc058sxzpCZIhxSl?=
 =?us-ascii?Q?s5qvzzWluPUSZuDx8jKCA7xarcA4cd/a7tz7hzy1uXW9YiTaB115hCyPb+bf?=
 =?us-ascii?Q?/s4VurUMNfcYAIvuyvwRCkpfMHwVvDBei9lxHkK0AOX4Xfd85OM6fkivi04i?=
 =?us-ascii?Q?osjnt0vhwBJgvKB8w+X/WJDFM5q8IAAlDe2HTKYW+s15XxYSsh3TT36Mmg6K?=
 =?us-ascii?Q?57fpNSSKGhxh670bbnqp2mKn/PTVYiHwF0gxWBB1/IyQFYzPrV60v1XfVdE0?=
 =?us-ascii?Q?E44ky/77WmmEBotpXs5tcmeBlrfEgPeGamksNjVGwpwIgrwwAmp8rsZ7KAXc?=
 =?us-ascii?Q?Wpi1s0QSfnX1iGWAdE09Fr2P8y9LSRdZUsKx8jKS4+8ympM0yDnbaRBalBuK?=
 =?us-ascii?Q?A6oQwf+lxqyJu+nEJahl0odRfGQiWye66QA5hO0QKM+2esoPdUGP2tdy78WL?=
 =?us-ascii?Q?bjXVdFLzm8tRsDWxfvIbvTjb+Ad2P0SyoK8n6YXtRXGeher73Xel4mml2Lnq?=
 =?us-ascii?Q?Vo+aiVoyRA8kMcOoRSB8MrDRZtl2QZYD9NfzAvoeo4c6uDRdyrZYj7LP6Fyl?=
 =?us-ascii?Q?YkaCqmcHTBSRBhZQ0L+FjObJD9sJzUMsF64OxBDO2Gt+a5AD0y9s1ahhDDFs?=
 =?us-ascii?Q?nwCBqBB9C7xN+y5gsdBDb7LaI6I81s3OvYClYlRsQhC0BE7tEDCJuaKAsE9d?=
 =?us-ascii?Q?gQArlzGqloMkfVsgSltLH4lvN0kYcg0vMqqbrcl9+Ax8jbBjxuuBaFnCeMVR?=
 =?us-ascii?Q?DNn6UYPZFkyYxAl53/bhiGb+pZsYxyx1isbqc/9cV3KNIIzQ6a/Xs6HhwXNq?=
 =?us-ascii?Q?kxw3RhvlHjc6O7wA5PCc+Cmor7ThlkOyShlsmPnIw2S6zIbdbX9wqDfNwOQy?=
 =?us-ascii?Q?HQyqFMpSb4C+H1/VRH2ienej7+geeeoQh01BUEpSyIVTHaHbpnLMEN6N/OqN?=
 =?us-ascii?Q?gU85YhkaRv9D3aTjWTVSaARgcnRCEpky+2iA4ZsRy8mbT6+Si3AYZ5Ltq7kX?=
 =?us-ascii?Q?Xjy3sJXm4yA2udJLUJvACotfKNH8te3uVczBNzv3y8dCF0ArxDC1nDn5TrM6?=
 =?us-ascii?Q?2OE8wtd84EvyQ4OpZ+kgJiGvV11rmuenz/az?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oXf595T+dihF/GQZ9FUXxxNT33TjlhXJFfcihQeCLMy6trqRSyRSHKiHvdew?=
 =?us-ascii?Q?29yPthJdInOa3XCa+JnzOpFXDsMooHB9aKrfv1QydiLRVRmBKcDGU05dzwAx?=
 =?us-ascii?Q?OFqkJWiHxX0EtksC7zoPeNKaJZgnZNLFWHsmtqgJnbNHEPA9vYgcFf5TIIhI?=
 =?us-ascii?Q?CWJz+Yh//txT2IVFJaTm3FqbxNeetnxNqdNQpG7MwT9OHwo5yo9QhEf4SWqP?=
 =?us-ascii?Q?anRDcDfC1pJx6dZFp+Hkxh+3bryYfYSj7HoBHQwO1AtGm+SiroEH99fgQzSR?=
 =?us-ascii?Q?Lb+auwsvU/GhmGZCvm/GnOX20CwP7KSJKNZ/AEh6V3BBOm6nKAEZayTiseaW?=
 =?us-ascii?Q?U334rfOZAQxtIByA+sBinOXzxIHrWRbdA09eexf4BXRCUfrdo23RWsMMQONF?=
 =?us-ascii?Q?jDqQ9z94AEI9W/Q5r0CjRCfI/N1W5qHSoMSubwUc3VSy0Z7olbv9JG2KuQFR?=
 =?us-ascii?Q?yXZ5nw+j2gTY82de43k+ccGATO4vmlhzlVOfo8y/8JcJOMbLbzZM75m4d9yI?=
 =?us-ascii?Q?n5G/fXjoMurUiSoBihscXRYore3jnTzfQKea0wHTqqrMqjLn8CDOF9x15jaI?=
 =?us-ascii?Q?qnE4cfS0QJ8pwyFIhDuVQYfANIXZuTmnVUNycM9utvTVGcOfgHvwT8eE/oQ5?=
 =?us-ascii?Q?sESbMWznhSuVGMVrmBrdOSGndoAeu1SdCC0it8blSWWAkMcaohnIUFLKw77y?=
 =?us-ascii?Q?NgCmpOAawxqsqv7pGHyiL5t72dvqZz0r9Ipo5PH4GJMzyBohJP45wO+xyjt1?=
 =?us-ascii?Q?ZNPNsisOW910PyrM2OjQ9s01HpUNQapW/D5bE4+FeAExBReskbyTakpHGeGI?=
 =?us-ascii?Q?wvjJEkfK8MbIKAjgryJfndZJfohcA/L60NYFrjxMybuNcDnVWHorwR2Zmp3E?=
 =?us-ascii?Q?EpjzU3I7pwjXiWHq2tBOxKHaFTxWiw68fzG0yql4/uDLQk+vEDy6rk3IKvAX?=
 =?us-ascii?Q?8yQElDd3AQxRttQ6W7f0H+VJeqgMLAzJNMY2eYMVwtBPC9CrTSlINwAAeMdk?=
 =?us-ascii?Q?AMoNXtYguehCSF7O527q0N2ym69pkSLgO53PuHVKHqggFoaedGuJygDUKni1?=
 =?us-ascii?Q?9PXueH3Aj07liiFCBb4eSa6LHT/M5rLQ5y8X6QtBmh6outkXslED8MW+fnfS?=
 =?us-ascii?Q?eyJe2PMY79vL+7XxMQPQk3u9kf6XOQBX6R3+cLRWU9JqvpX4eePWjMWa5W8T?=
 =?us-ascii?Q?Nd641C3jhOHMnmkS58RmPrSNVJAwNNwM7l9MFVHrn2Ur/eiyih7xAHZdwv38?=
 =?us-ascii?Q?/p7OXb8hjUolLqcOEaTAH0Rl7NP3FNYtOvHYR7OWCYVFFbLEl8fd2ht6qWLD?=
 =?us-ascii?Q?z9U+kcUq9AmabwV3b94uhJB2SB5k2dlsldPHZcFnjwYz6zB8npsy7yUHH+yT?=
 =?us-ascii?Q?9IjIHEWHtBhYOnnaIWJLGFdRTSbD5kFb+XO7iGWHzeUsNDrJubkKn9irMkYF?=
 =?us-ascii?Q?lSu6eUQKafXrB9svZOPaxi0NTXSRphr7foKKc8foBjhrNWs0+IGNOGAqdiTO?=
 =?us-ascii?Q?C/JT118MEs6iDQLVWWuzIpEZ+qMUxu1enIlyUjpZvU1oME1My7KcSgXt9Fcd?=
 =?us-ascii?Q?66YAccHunxZLLzCFZUw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9245429-84cc-4d5b-79bf-08de1202d8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 07:07:36.6514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdnHKp3i0ynuytRt1en4UXhz+AnUFNBCJOwJTwRscP8mSQZHmePfopnT6Qp/XOhojXSDOw36F7gsgTSRV8UohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023
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

> Subject: [PATCH] power: regulator: Remove duplicate include of
> regulator_common.h
>=20
> Remove duplicate #include "regulator_common.h" statements from
> regulator driver files.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
