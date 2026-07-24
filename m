Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B9C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B82040AD1;
	Fri, 24 Jul 2026 03:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yR3YJfh0NS-1; Fri, 24 Jul 2026 03:07:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8363A40AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784862456;
	bh=0PYdjKc/PhHbAnqh7IbJK8pVV9uuMGwPSA2dro2Cwwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HW3gXNK1HVfX+J89h0M+HhI/4tmg0akzcg90oxqwnk8fFq2gX6AQN1zwMeTZL4VGc
	 ym2atJ9XLggbzTnNmwqDxOlaS8baIOmEWM4xuY6pIqWDB829CZsVJPsk1I4BAkeWwi
	 aTtN+Nix1Yeninw7eb1nmHoLFolLqLP/rZ8kghKbPoFyOL6wAMl7AfhHRuwrkrjxQa
	 QqHfyotLLmBUQM0HI8dLcD35xsOc1LcPeo6qZWKj5chWwAdeoKDRwh+aEN5hKwh9W+
	 RuviPO7f1vVvraiLkEjZ+ovSofQ7rzyIePYPl7OpDxF0XFQR87W4SU7siUq5WUCWCY
	 5CE2zLAWCTbzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8363A40AF0;
	Fri, 24 Jul 2026 03:07:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE1352E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3F89400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Xg4h9CeUW9J for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:07:34 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E964140072
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E964140072
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E964140072
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymfeNr2uFq8KDOiJsamc3xs8MYQbZbuhUbYKWRTYttRi/DHFPneGL/7nak5fpcv2boAE+8WGqaZqwCpbfP6Hk+vX55Z/sUiEBhTCuDlgGwCojm4pRTtUUUOXsQ3L5xJ9Hhd0LLHTCRKrH/wWgvgy3s7wz9sm9W+A6YPMwqjnzwgJ87nDkTZ/cnY8NsVBbZoKmUICzPvBnvTAxGPoPU2Io8hxFB99ZGvZxW7FZPFHa/AjSSCDhXikkrh0QPZ7xX10E+RJrfFI1CG5KYi6bXmDay/hR9rb+/A0y+u075FkxH4z1zHqAVseMkViDtrPUZ3GMrkv8VM+LHd9ujjYo93YgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PYdjKc/PhHbAnqh7IbJK8pVV9uuMGwPSA2dro2Cwwc=;
 b=y08a1w3qkWL+Cgm12mUz5GLUl7ODJsRUHTf4d67xvDW7vvusoz7YdhBtv67uGUBqZwMhLYUfxo6wbjcoPB7uRWxYGuBu5ZmyimifiYnfMfk6akSoOFS8ugGh5gL8UGbvSIR/G1P1hOhFb4mQnDTeHN2CDGLwdFf3mYol0gySfni2J0PVZGC+eV3n74stXQzVoUe+yC9HYFMfjsaf6mM3B7P+rrw2QVrHqP/O0UqIR/7n+px6J5g/Tova+3odXfEW7n4ybZNcr14kUqHlJHPNS8XW4WoogNOnSyMry2XuwnZn6GqZjh0CRpxp7pjor4/4fMjdwFdZqBvSwyUltuu4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by GV4PR04MB11749.eurprd04.prod.outlook.com (2603:10a6:150:2df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:07:29 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:29 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 24 Jul 2026 11:10:45 +0800
Subject: [PATCH v3 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-imx95-v1-3-7131a9e17fe1@nxp.com>
References: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
In-Reply-To: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|GV4PR04MB11749:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bd3fcb-92e7-4537-ffb7-08dee930b222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jokvaql+0yUvdodo2debK242kq9Bd0bzkPjQUZiR+11LWEbKtHSpY4MGiXGTgjwGVG6UWV41T8jFHpfQXtRohVFKg9UkCYUkrH0KmNnM4596FEPFPIn+XWuxA9draaB3SdQhcLAfbya+462w2X3JhwhXhEixuYBU8owOXsTPqbTq1rZCJisfVMGDPsLb5ToLoM+YAUZpDqYwDRT4g6hmwJEr9oDNDU7MgXMw1H/JEEJjggjDD1kx6nxMULudWfblK7OIMWOB2yQnPJrLnAzd0/R9ZGXa+/O8ECdGzy/z8d4kNPD7qRb2NpV1w/q3LN7B2/d1JvigMEVyqlUbt+qCfiFfqoK4//awB2Z0AORU50PErcq9p2NdK6B4aaQiwm34i9gszZ1n4+rjAmhbSxppB7Cm96WD1KLGd7oqbh8Xe1pk2oGcWTKiWMUWdGpR5NX0Y9lwZqIhKTCLJBYe2EwMpoUO39wkhy5+dpDD0ZvsCnjZgZMVS3HMLniOpkiRPH1A9luutNoLp+0+lVi8dMhKPXfWgqeSlMHydSQYn5WlLWQAUbmNxpP2ObE5coUWXnxDmMqFuyy1uuH0YQCcsbwZe/KeEsNBdSVBZJHgCs/xohxMdSZFh/RNU5OxW6fXYZwIRa1e1uRrsYeYTDF5NmOaUa36jFU40IK2B6AQB7zDk4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFreWtYTkplRFUwcVUxR3VTMHREWnVweDd4K09QTlV4Rlg4cElMUFN1NEJq?=
 =?utf-8?B?dzE3L0ViZGxzVUtLRXdGdEJXcmRySkxxNktwZ0pOdFlRT2pKL0dJc1d2VWUx?=
 =?utf-8?B?OGt0SWZpTzJrdXFYSDRPNzBDL0V4RG0rTDViaHJQbUs0UUN6Mld1eWMzN0lz?=
 =?utf-8?B?MFJoNHQza3pGT3dGL0JTMlgxaDhidmw1d01Ecll5U2t5VjcyOFJ1Zm9mNzlk?=
 =?utf-8?B?MERTWEo1UC91VVdKeHV2Y3dEc0JVdGJRME56OEpxWjZpaDlydnM0SEJYS0J3?=
 =?utf-8?B?eHM5aWhuajJzc3FyNGtWMWJNY3MzSms0UWFFMGJCcmZwclU0M1hCWnRON2dy?=
 =?utf-8?B?aWRrWEh5Q2VmcjhuaDZFc3cvYzRaZWVwdG03bzN2WkNKNWU5c3RETjBDL2RG?=
 =?utf-8?B?YWVGTjcwUjB5ZlhxUHQ4OHkzemFzOVhYQ3FkU29ScTRXUm5XM3hnNUtTOW1q?=
 =?utf-8?B?MXdEcU5PY2lhN2hBcjBVbHljYWZoTVF5MTRzZXJFeHl1b2hPUDJ4OWtEbHZk?=
 =?utf-8?B?KzduSDIrdjg3ajdBb1pWYkVJdmU5T01zK05waUtpdEprOGhGcGRMZTI4TmFn?=
 =?utf-8?B?RW54bW1DOTgvZytrMHJ6NGVwUXlzWXVQMEZQVVFHckFZak5SMGRydFJXTWJt?=
 =?utf-8?B?YldiM2dIbXdsV0h6RHNsSnVXMW9CUXp0ZFZGOFBUUWNZa014UGZFNGowMjFw?=
 =?utf-8?B?RGFrTXh6SG9HVmdOZDZlY1hnNU85RVFUekl1cGVKcWx5ckV1b2hjSThXT1gx?=
 =?utf-8?B?M0RheDBSa1EvaER5ZWdxUUhNMHg3OWR6MVM0M0ExS0M5d2djSUZqY09SaVkw?=
 =?utf-8?B?aDQvaTlEMklNbTJmcG44OGtZYkx2UHBUbTc5R2plUHRPc1dVcEFuQWVxOFhm?=
 =?utf-8?B?RER6QmFJUWlVM290eHQwakZIbWk3RW1jVENndjV2SXEzUjN4SnJST3d2S0JF?=
 =?utf-8?B?RlByNDRSN2ZUZHRjU0hTWUxVRi9jZ1k4cG9sc3dMK2FXclcza2I0L2tUSSs3?=
 =?utf-8?B?Ukd2QTJBNGFMTjFxZVVTSFlaWlZBTCtCWlJiRFEwQXJtL0xoeHUyNEsvbVd0?=
 =?utf-8?B?ZWFxdVljSXhnelZVT1RzamFoMlhjVm9YcndqUVUyT3hQTkEydVVDNlAwcWIz?=
 =?utf-8?B?RjloMHVxVlU1WUhvWnFkSTlCMFFuWVByVS8xNHA2V0p3SFVUWHE4citRM3B3?=
 =?utf-8?B?b0tFOU9kWHJaNzUrVy9tdVJOM3hxaW1aTmlJNzg5YzdtKzVVVmwyVTRFWnlu?=
 =?utf-8?B?SSt4eXN3WUtOR2Z0QlhmZjZoRVNiRzMwZGpvTjFmTFc5cnZDWXRnNkFGT3RV?=
 =?utf-8?B?cGFha3ErRlQyaE8rejBOdjc2Ym8wSkNQdk1qRU9ibEhaNVgrVXpVZHFuQlVV?=
 =?utf-8?B?UnJneUY4OVp1dmNJdmNqOEZROHVXWnl0Vlg0SitzNDNwRTczWHRZRnd2dEVq?=
 =?utf-8?B?LzR0WUZXUDlFOVhpVWtQTjMwQlpTSXc5MEthMUE2R2RFWkExNzZMZ2ZPeDVs?=
 =?utf-8?B?ZVJIQjFkd3hlQ3JHTVZvdzIyZ01RTnBPdDk0VGQ0NkR6MllyZTB0N1kxYUlP?=
 =?utf-8?B?S2F1TlRrWnRocXZyeEZ1c0tCMVE1UFE0WXVXaTBFZGJoVkNBL1RvSTYzRGhH?=
 =?utf-8?B?cCtPUWZjb3FZUlRKdDlWdjNVR1lEcmVibVlFZk5qSEpQaTYwQ25mRFJCSmgr?=
 =?utf-8?B?SlhWOGRNOXplN25XcXFKWEpFcFdXZTZsNGJBQXBQdlZyc3RkVllIaGlNUnZC?=
 =?utf-8?B?QkRVTEwyZENuaEJpSFBxRGFQZFNtQUhQeDE2Zk5UZDgwbFpsaTNUU3I2U2g4?=
 =?utf-8?B?dHVJMGp3MFdCdjZVL2dIZmVZaDhaTlBTQnU3R0gwNVNhcXFYTkgySWFja1A3?=
 =?utf-8?B?V3FHUHNPRVBVYWxiMko0Z3pYOTM1bzF2TGpOa2Mrc2tRbHg5enB3N2ZUMVFY?=
 =?utf-8?B?dlBZS1g3TUp1RTRuV3BsWGkwcWUwVWVseFJtL1hrWkRwaEVkdWh5aWtiaDlF?=
 =?utf-8?B?aTRmYm9Uc20xRlMrNjB4VFdQWjdnaUxoZXFndnFPZ1IvaUhOcmZkYUZhK3Qz?=
 =?utf-8?B?dzVrOWxiZWtrNmdXMmdDdGQ0eHM5STFadXlNY1NLbWZYcXV3UnhrcHc0RVdU?=
 =?utf-8?B?b2FLM2FkL0lXTlpmZXVBNWlJTDliWFQ3Q1NUV0NCdTNHcXQ0aG1NMkhtOE0w?=
 =?utf-8?B?SXQ2L2tHUUM1MEQzUnhiOTJJN25IMzdhS1MwcDRPYTFOOUVOR2lVVFR3blEz?=
 =?utf-8?B?M0pFcVUzRzlLTEE4Yi9RdE5hMXY2OG5tSmhKZHNxOWtOSVBnMUliNURTd3ZF?=
 =?utf-8?B?RVIrUXdYSUx1V2pORWRCYVRDbHVTMCtZZU41ZnF4TEM0Mmh4cmJobC92WUNp?=
 =?utf-8?Q?/Np/Npu4fPuAvyK0JYvY0aDzD60sXLK42Su91?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bd3fcb-92e7-4537-ffb7-08dee930b222
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:29.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EfJjggng4PUFsdjQDytoapbpQPVdP8991wiQejwRiiCmZjitK2n/OJAHj55zheI7A3EyDxQql7yWKPgT3+Y3NzNK0o6gm/QIFuDLnwUGgmdOYf0QApJWe6HrVPJI9hY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11749
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PYdjKc/PhHbAnqh7IbJK8pVV9uuMGwPSA2dro2Cwwc=;
 b=GJbECRznIUsfkTerhM26Gqu5e5/+z59vdffxkDNYyOzyByGKBTVmWQCTqAQko8HtAClpwQAPZKDLxvpXbhFjZzrdTjTqU8eWoXgHdNdkCajKxpTjU7PJVnXOz5WpqdMWZuBm/zLNPIOA1GqUPW/uVTwTjiciP0dtPn2OalqTOEm8prvFlz/qz9a1ydTtTPtEJ9kydOtba+ahhEl+Q1gi01fpr8f6+LxuPLkjd/x015r5FuPTpeCNBojRE4/oz2vlr+4tXQshxkNZCqn36KSmS+KayCaQpo4DGQ8nAnh1jklo0m0W8zCHr9ofcpImI69iv4qh4lH7eGB04F3AZ9l3Qw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GJbECRzn
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
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

From: Alice Guo <alice.guo@nxp.com>

Add 1G SGMII mode configuration for i.MX95 platform in ENETC driver.

Note that 10/100 mode is not supported.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c          | 20 ++++++++++++++++++++
 drivers/net/fsl_enetc.h          |  1 +
 drivers/net/fsl_enetc_xpcs_phy.c |  9 +++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index f393af40e27..e905841f215 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -35,6 +35,12 @@ static inline int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
 	return 0;
 }
+
+static inline int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	return 0;
+}
+
 #endif
 
 #define ENETC_DRIVER_NAME	"enetc_eth"
@@ -387,6 +393,9 @@ static int enetc_init_sgmii(struct udevice *dev)
 	if (!enetc_has_imdio(dev))
 		return 0;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		return xpcs_phy_sgmii_1g_config(dev);
+
 	if (priv->uclass_id == PHY_INTERFACE_MODE_2500BASEX)
 		is2500 = true;
 
@@ -482,6 +491,14 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
+		if (enetc_is_imx95(dev)) {
+			if_mode &= ~(ENETC_PM_IF_IFMODE_MASK_IMX | ENETC_PM_IF_MODE_AN_ENA);
+			if_mode |= IFMODE_SGMII;
+		}
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
+		break;
 	};
 }
 
@@ -565,6 +582,9 @@ static int enetc_config_phy(struct udevice *dev)
 	if (enetc_is_imx95(dev))
 		supported |= PHY_10G_FEATURES;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		supported = PHY_1000BT_FEATURES | PHY_DEFAULT_FEATURES;
+
 	priv->phy->supported &= supported;
 	priv->phy->advertising &= supported;
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 6d868e82f8c..bcab6f252a0 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -104,6 +104,7 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
 #define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
 #define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  IFMODE_SGMII			5
 #define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
 
 /* i.MX95 specific registers */
diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 6414324e7d2..e7fed59a0cd 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -1471,6 +1471,15 @@ int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
 	return 0;
 }
 
+int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	if (is_imx95())
+		return imx95_xpcs_phy_sgmii_1g_config(dev);
+
+	dev_dbg(dev, "SGMII 1G config skipped\n");
+	return -ENODEV;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

