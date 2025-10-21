Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399ECCCD19F
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 06:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61722807C0;
	Tue, 21 Oct 2025 08:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CImU1IXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC23F82B20; Tue, 21 Oct 2025 08:11:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65CF80077
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6QMmHGfXRqz8eARlZ8pF/eZWmFkLvFGIiOoVUhOKP6NifGDCg9ganmL5vIdEMESI69m+KnfjnHRxzOwsieUfctErEae3nCNlMJj1Gmsj1yLXilzAe1Zos8sNz+WBk3Mecs+Io3p8c6d9kmx32ZnD3uLXAX6gpvM+H3tvDl3Famo3Hyr2kbr3wL90EcIuEmhtT+4oBg+bAvB9i2P3m3xneQiry88uzctnwdE6zcMF+1tg/gttqKNHAeOxi/XXg1hc7AobTPOinYTY2hRPHHVpGQEHBnSJnUdFGitpF7Se1OKkLsO/PEfpcbBiuAsDHZSCf2BNbf4VzZ+E2w7xmsJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Juqa7I4BvZO75bqlq/bSmwGQXFaf2XmwZlYZymxWH/0=;
 b=CrLRJoSN8krdUSa+C3czs+YFM5JFXad9BLKkJO19OPa+9k9UJ0ia11ecIVYgoEbHOtTEgH8Wm0HpUahuZFiMkfMtSRyR6TcnyvMgXd0KXFXxNEvL9jsOhgHNcUX1faGvtj/n0V7XlPJRd6V68HBQb6xit26Unvz6SfRfwpvMVhV0ylg2DEKoxVd1aHGy14fpkY2UYad3qQolV4DmxJ+n7fAYnj7XI/2Yc1a5pw7UaS8pKNFVzOjvRvdR2KTq/HL9xtZxWD5tXA32kjv5X4OXVxyPnvxWD+NroNhSvcMgmXox6tbKRwL0QUqfo2shc/DURjKZI3lOB7iyO3VzJ/JNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juqa7I4BvZO75bqlq/bSmwGQXFaf2XmwZlYZymxWH/0=;
 b=CImU1IXF3MdaFZhC1K0KQ2KnvD6lXwZomPP8AQ5VgOlPGz8h4IwDLWhRcgMRYxpeJBuliDcxc1awYnRfaCcsxSW1XR/CHBbs5pIq99jej6VUj87/rpeJYbYxQJ2fSkbNS5Qq2IBzxxGeFV/gsQgrR57PMM4YWfkGoQ4ypqqiYsxlRt5dffFqJgBP4MUVECAobnwHT++PxOK3IiMRraq7yZ/XHv4bU6hcoatZIjw4ygwsBUTrUX1WWxvWjTr5xP7sdLMqNazqdS8LFpU7cRHNRg63en1BmO3m51v+IXhK6sVzja5p9YQ2j6J6wrjuWPSHHkGRRez12Q8r97ijnGnFtQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 06:09:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 06:09:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
CC: Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMC81XSBmaXJtd2FyZTogc2NtaTogU3VwcG9ydCBT?=
 =?utf-8?Q?CMI_LMM/CPU_protocol_for_i.MX95?=
Thread-Topic: [PATCH 0/5] firmware: scmi: Support SCMI LMM/CPU protocol for
 i.MX95
Thread-Index: AQHcPz7eoqFZ6EwtAUGPRbhwtElLZ7TMI/oQ
Date: Tue, 21 Oct 2025 06:09:21 +0000
Message-ID: <PAXPR04MB9644EBA7DDB482E34AE2DF44E2F2A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
In-Reply-To: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM0PR04MB7011:EE_
x-ms-office365-filtering-correlation-id: 59575a1d-941b-4703-bf61-08de106860d8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?T1B0TWltc2wvZjdMbUF3TGVtY0hmS3pEQ1pXY05KOUQwMUtKVyt5ajJWTCtH?=
 =?utf-8?B?Z0h5amVkcVFvbGRvWFcwQWF6Y0Iva0VMeXZhMmQ3UVpJVm1wUFg2SFQ5a2tN?=
 =?utf-8?B?SnlUUzk3VEdXb2VmbUFlZHI1RXZ4K05JRlVlU3Vmd2F2U2NXWG5ZSXhZTytw?=
 =?utf-8?B?MVRJVnlSckllcHpVQzgyYTdJUVc4QTFtSm5YdlJiRm9ZQzB0eFlLRnJ2cEx6?=
 =?utf-8?B?bmlnS2FsNG5Lejg1WXIxdG1vTFBnNDNDT3YxVkhxajBhUTg1U1dZb21pcG1L?=
 =?utf-8?B?UndzeFB5WkNpcWlCYUNKN0dKRHdvelRWT3ZOdTJWV0NrRXh6WnNwMkJaSkNj?=
 =?utf-8?B?bXBlZDQ2Qi9CRDFLOGg2T2d2d3pQeEtJVEp3Z0EraVlTVHRKS0NuaHNialls?=
 =?utf-8?B?eGFXMXJoRmZMMjBRTHhtTFVnZUNEajVHTXlEdm9Cb3Ivd1pNM1Q1RWxzL2F4?=
 =?utf-8?B?MmVEbmNkS2lpN1MxUmFiRXJOaVZXdTVKckt3YndjZEd6YVNXT1JpNnpKR1Ru?=
 =?utf-8?B?a1RvdVI0cVk3ZHFGY3JDWExqaHFORkJSZ1ZHNnRDNjVYVVdwR2FaUmtKV1c3?=
 =?utf-8?B?bUI5SGRRbWtkWXM3S0RXSWlTV25DVzI4UjNqcjJTdHFLbThaZERoeGJVYmJB?=
 =?utf-8?B?a2VHY0R5ajZ5dU9ndUd6UXJqdGVCY2ZhMjZxd3REQVNzQ2puTHNYc2VzbW1u?=
 =?utf-8?B?Vktma1Q0dDdVc0puM1ZnL1NQVytybkhOMS9XSzY5bWl2akhPb1ZsN0hKY2Jj?=
 =?utf-8?B?dXFWTFhKRVhhN29lQUNMbkJuQWtKTTBtQlhWRWo2OGRqaXYveTdrdkhleTVY?=
 =?utf-8?B?UkZCRFRhZTQ5ampZaTZNbXB5MzQrdS90TU01aUNtRUY3QTA5SXFFekxVcTU0?=
 =?utf-8?B?dFFvb1p1Q0dBZWtyK2R3VXcvVVRIcDBxRDZCR3BIaFhYZ3ZKZTVDZlNtNUZP?=
 =?utf-8?B?WEl6QktOR0FEV0toR1lPUHM0S0lBK0xFNTZsWm1wcXZtUXpRZGloTndKWmJ4?=
 =?utf-8?B?amV4b2ZkZW04UTU3WnZVWmd3bjc3RVZSc2lFSDJMWkdhaURaU3hYZVZ0VjVx?=
 =?utf-8?B?REo4WXo4NUZ5dE1PNFdVTm5ualBiV3Ric21ydEU5NkpRa2tOWUpsOEdnU29a?=
 =?utf-8?B?UGlOOERLMU1tdGx5ZzByaEdGRU5ac1o1dURvYjJqQkhNTXBCQ3YzN3g3ak4x?=
 =?utf-8?B?dE03amw5cDkvMnVtSUZRM3U2Z0s1bWVjOWg1TDBQcjNkc3NJbytDc2JVbkdB?=
 =?utf-8?B?ZUUyNEYvMTR3Z1VDa0tVOHZOTlhZd2ZvaHcybDNuZi9lNmJIN3pyZ3lCOElV?=
 =?utf-8?B?aENzNUl5ZmxocTRqYW4wNURwejlxcGMrdmVkeEtrY1BoVW5mVnlMR1lJaHY2?=
 =?utf-8?B?YjJ1dzNVY1p6MlhaNkJtSWJMYkcwU1FUWU9pUHhCc1E2SlV3UU5BQjJyMjE5?=
 =?utf-8?B?a3Z4NmRKdEdXeCtyczV3dGJScGtqUCtRak93Z2lxekdYejhTWmV0cXpIblZO?=
 =?utf-8?B?Z1liTjN1c0NrZng5Rzl2WHRZb2lja0VucnRBWnVoa3pXeXdNVzB2a2dja1FR?=
 =?utf-8?B?VXMvTWczZlVnaHBuYlZBR0RDQlhFY1E1ZGJ4NFlZRWg3NXVMM2RnWmFQclg3?=
 =?utf-8?B?dkYrSml6eVJvbFcrTjllWEkyaUUzQkwxQm5WS1RLSUpKS21TeE0xQmZFVGlZ?=
 =?utf-8?B?R3dXdXFMNkY3UjVKT1JTVUhBbXZkeUZsTVVrY2t2T3NBSmgwd0IzUUhaMHdp?=
 =?utf-8?B?bWx1SlRucEV0MitiandGNGpFSVE1b1RZQXRCNktOUXEwa1FzTzV5bCtrb1k5?=
 =?utf-8?B?cWFTRElFbnhIZDhma1FLaEdOaEZDKzNLR25NN0QzWXRETWk5NCs5VEp0NGtI?=
 =?utf-8?B?NHZJWVRyQXpyZDN1SnJoVlJ1UGJDWkl1cG5oT0EzRlB1YWVqbjNCV0NjUDB5?=
 =?utf-8?B?TVZtRFh6dXdqSDJmVkxXVEhoSFJMaHhqWDFaSkx0OWR0VHFSRmFGK3U3S1hE?=
 =?utf-8?B?a3JLemFiWlRNanhXc1J2NUZ1YlpzZ1dneWxQV3ZKOXM2TFZEcjJCblZ0ZVdU?=
 =?utf-8?Q?BWg95g?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjBzQzRSajBWQXlOQW9vWmhxTXNQbUhCUEtEUEdjaCtaRW5saThKQ1AycC8y?=
 =?utf-8?B?NVpRQVEzaitWWlJielQxY3pYL0lzNjVYaGlCcGlEdnFweERmRU1Yd09CVXdS?=
 =?utf-8?B?ZDNNUGlSVWI5NmFDY29tT05VY3N3eGJKOG9CWUwrTE93UmVMc2pWeXc5Sytk?=
 =?utf-8?B?OHozaEJnMHJ4NElyMWZNQTZ6MkFhQkw0eGlUVXFUMXQrdk4yZ2F4ZkM3aHFz?=
 =?utf-8?B?NzJMZUhFbndIYTlxNG16MlFRV0hBYmZLbXFZMWQwUm9lNExOUXNaVUJFMjAx?=
 =?utf-8?B?b2tCMjBOcVVLekM3d3JlalZUbUF6VXhheGdQc2d3UTdlQXcxMDE3M3RBb2Qv?=
 =?utf-8?B?UHhOcjdQOEQ5T1lleWpibXM2bm1qMDMrRUtIeTRINk5pV1ZDSVN5MGU4U0Z0?=
 =?utf-8?B?STcrTENVa294b013Q3JSUVJzeFpEd21udU5vQlVZRXcrUDBrbkJJeEZxQmRB?=
 =?utf-8?B?T1hoVGZPSXFjYlFJd3oxK2VxN3JtUUZ1cVYwbUQxSldYY05FRkk2RGk1d0dU?=
 =?utf-8?B?ZjE3bmN1bFErOVV0Y0RGL3BCM3pEeEJRRTVqYjI3VXRCRGY0dkh2ejBJd21E?=
 =?utf-8?B?cEUvUHh2Y1QyUDBveU5aV1BJN2orMmRZVkducVlTNHBSbDB3TjM1MU1WN292?=
 =?utf-8?B?K2ExNDlhM1NpUHpoUDhaOFptVjNxQkM1RUtpUWdDR3NqZ0s0MTUxS2Z0Qm5S?=
 =?utf-8?B?RUpsUmFnL3Y3dC9HSWRRd1JRNEhPRUJOZHVWVnA0bGxCM3RlcHgvL1ZFNzQ2?=
 =?utf-8?B?ZDBESUlmUUpZZitlSUF4RUVMZGkzVWs4RGc2VXZkd2YzdnpxRVcxcEYwSFZT?=
 =?utf-8?B?UmFnOExraTc2ZlI3Si9xMGJFd3Iwb2xwbE50dlZGdEtWYlp2aURZU1UyQy9C?=
 =?utf-8?B?UFU5UC9EN2N0aldKZlZvK3JiY2NpZUVJLzBWaFJ6TGNhNkJPZy84QzlNcVN2?=
 =?utf-8?B?a3pmRUJHMnV0WkJFZnBwMGUxRXpiemhFSnFRSkE4ek5qUjRleDNmZXFBNG5W?=
 =?utf-8?B?R3ByaFJiOUFzSmlhTCtOSGJkUHVXVnlJRnpyWXZNOUdpRjRzOGpkWWNiM0o0?=
 =?utf-8?B?YVFUQVF2NGFqUXVoSVMyOWVrbEluUjNYS0dtcUROL05OdkhPSnhia3ZtbWFH?=
 =?utf-8?B?VE94Z1czNkFSSEdqT0R2UExWTDY2aGQ0bGtocTk2bEtpR091a2FUbkhXenRE?=
 =?utf-8?B?bS81WVduYXhscnNicWJQM1hVdUI3Y2hPN29SVlAzL2JJZzE3a0NJbGdDN3NJ?=
 =?utf-8?B?TU4vYUJyRFV6a09jbUdmQlRtQzFVTmYrS3hkVytCUmNvc0F0MWFxZkdFa082?=
 =?utf-8?B?K2JOM3kzYW90VjdDZ1VoOEU5blg1N253UTBGN0I4UGRvMDJiWXZxQVcvMytw?=
 =?utf-8?B?QkF6NThvb1JUZkd2ZUpad2M0c24vdnJmY3dMbHpxSFhLVnp1dUcxOVRKUllI?=
 =?utf-8?B?VUhac2MvYkxFbmJ3RUMxdG9TMTJobThycjc1bnd2dzBKcXlrZEdHWU1rMlJH?=
 =?utf-8?B?ZjdZRHoxdUhOZ0t3Qk11NDByaWNtMUhEczFXSjJ5b2Q2YjF3VUt6WWRhdVIr?=
 =?utf-8?B?Q3dmVkh2eVFPSGczRGxZeURIRWgvaFZELytOTklGK0JQVlh2NmpYdTJiV3F1?=
 =?utf-8?B?NEdRN3NubGtDWFVpZzdTMjFwK3kySlg2OFREanppS3VJQW0rOWFqb0wvYTV4?=
 =?utf-8?B?MWgzZ056OGEyeUpranYvN2EwR09PMFY5NisyZmZQWXNwT0JWQ243VTY1TTZ5?=
 =?utf-8?B?TCtRWm5lVTB3eWxlcms0NitQTnBrRHlneXhHT3R1RDROdGdTTExFSUl1UzdL?=
 =?utf-8?B?eldlSTJqN201YUNMelkzbEZHMzhkOGtSZHlPZHZXb0ZSU29CaThYQWJMQllG?=
 =?utf-8?B?S1poT1Evd3hOODRBQzlvNEYxQ2xKcHNLZlpkV0ZvZnNpY20zZVZiYXcyVkxr?=
 =?utf-8?B?VWViMmlUT3dPZHFwTE0xdW5Zb3dKaldhTWgwU1pOZkNWU1pkZWhvMGEwdk0y?=
 =?utf-8?B?UFA1TDNlRWR4U2FrME9yK1FXNDFDWTY0OWt0SkEzK0RMUkpxaVJSZlNXVmQy?=
 =?utf-8?B?YS8rUm9zaGk2aENNMFNEZW5PUUJrNjgrRHFEU01HL0xZY0N3eDVsSHdmdi92?=
 =?utf-8?Q?c2Xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59575a1d-941b-4703-bf61-08de106860d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 06:09:21.9960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FP1uK1M0mRV/YOK4OG7G6dncfhJBt7SfnE+vMJ7kfFcqWkYGxXHgM5btHwBodju5SjjGT/3u9tRZOryKlTFekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVS1Cb290IDx1LWJvb3QtYm91
bmNlc0BsaXN0cy5kZW54LmRlPiDku6PooaggUGVuZyBGYW4gKE9TUykNCj4g5Y+R6YCB5pe26Ze0
OiAyMDI15bm0MTDmnIgxN+aXpSAxNzozMg0KPiDmlLbku7bkuro6IHUtYm9vdEBsaXN0cy5kZW54
LmRlOyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVz
dGV2YW1AZ21haWwuY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IEFs
aWNlIEd1bw0KPiA8YWxpY2UuZ3VvQG54cC5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT47IFBh
dHJpY2UgQ2hvdGFyZA0KPiA8cGF0cmljZS5jaG90YXJkQGZvc3Muc3QuY29tPjsgVmFsZW50aW4g
Q2Fyb24gPHZhbGVudGluLmNhcm9uQGZvc3Muc3QuY29tPg0KPiDmioTpgIE6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6IFtQQVRDSCAwLzVdIGZpcm13YXJlOiBzY21pOiBT
dXBwb3J0IFNDTUkgTE1NL0NQVSBwcm90b2NvbCBmb3IgaS5NWDk1DQo+IA0KPiBpLk1YOTUgU3lz
dGVtIE1hbmFnZXIoU00pIGltcGxlbWVudHMgTG9naWNhbCBNYWNoaW5lIE1hbmFnZW1lbnQoTE1N
KQ0KPiBhbmQgQ1BVIHByb3RvY29sIHRvIG1hbmFnZSBMb2dpY2FsIE1hY2hpbmUoTE0pIGFuZCBD
UFVzKGVnLCBNNykuDQo+IA0KPiBUbyBtYW5hZ2UgTTcgaW4gYSBzZXBhcmF0ZSBMTSBvciBpbiBz
YW1lIExNIGFzIFUtQm9vdC9MaW51eCBpdHNlbGYuIExNTSBBUElzDQo+IGFuZCBDUFUgQVBJcyBh
cmUgbmVlZGVkLg0KPiANCj4gV2hlbiBNNyBpcyBpbiBMTSAnbG0tbTcnLCBhbmQgdGhpcyBMTSBp
cyBtYW5hZ2FibGUgYnkgJ3Vib290LWxtJywgVS1Cb290IGNvdWxkDQo+IHVzZSBMTU1fQk9PVCwg
TE1NX1NIVVRET1dOIGFuZCBldGMgdG8gbWFuYWdlICdsbS1tNycuDQo+IA0KPiBJZiBpbiBzYW1l
IExNLCB1c2UgQ1BVX1NUQVJULCBDUFVfU1RPUCwgQ1BVX1JFU0VUX1ZFQ1RPUl9TRVQgYW5kIGV0
YyB0bw0KPiBtYW5hZ2UgTTcuDQo+IA0KPiBCb3RoIExNTS9DUFUgQVBJcyB3aWxsIGJlIHVzZWQg
YnkgcmVtb3RlcHJvYyBkcml2ZXIuDQo+IA0KPiBUaGUgZG9jdW1lbnRhdGlvbiBjb3VsZCBiZSBm
b3VuZCBpbiBMaW51eCBLZXJuZWw6DQo+IGRyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvdmVuZG9y
cy9pbXgvaW14OTUucnN0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gLS0tDQo+IFBlbmcgRmFuICg1KToNCj4gICAgICAgZmlybXdhcmU6IHNjbWk6
IENvbmRpdGlvbmFsbHkgY29tcGlsZSBwcm90b2NvbCBzdXBwb3J0DQo+ICAgICAgIGZpcm13YXJl
OiBzY21pOiBDbGVhbnVwIHRoZSBTQ01JIE1JU0MgSUQNCj4gICAgICAgZmlybXdhcmU6IHNjbWk6
IFN1cHBvcnQgcHJvYmUgdmVuZG9yIElEIDB4ODAgYW5kIDB4ODINCj4gICAgICAgZmlybXdhcmU6
IHNjbWk6IEFkZCBpLk1YOTUgU0NNSSBMTU0gcHJvdG9jb2wgZHJpdmVyDQo+ICAgICAgIGZpcm13
YXJlOiBzY21pOiBBZGQgaS5NWDk1IFNDTUkgQ1BVIFByb3RvY29sDQo+IA0KSGksDQoNCkkgaGF2
ZSByZXZpZXdlZCB0aGUgZW50aXJlIHBhdGNoIHNldCBhbmQgaXQgbG9va3MgZ29vZCB0byBtZS4N
Cg0KUmV2aWV3ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkJlc3QgcmVn
YXJkcywNCkFsaWNlIEd1bw0KDQo=
