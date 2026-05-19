Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84217CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D7F84705;
	Tue, 19 May 2026 14:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P3lk4g13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524948465A; Tue, 19 May 2026 08:20:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDFB84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP9x3cclyh/Yw6NEscNGtCh/UEUziu23Zxu9WfL0Nk7DhsHHSBUyTwXNmDl8WDoIHvauHhIcyDb+CjXhFXLJBf+NK/+DdTCnyz79X6G7liEBBSm1RyMoegx/399wejptT1c6yoPXey2rBndNkPeewi1onfJXPF8x3CUOY0Z/nqIjdFgXtrLZgUJOkOJVUcn8BB7wlkYef44iHFFq5M2jSPd96oEOiOodxCdVKZWjo2jtI/z9JRJ1rbV7xxdu+BNo2vR+x6qCA89p8JVTSTNFNJdfx1lWKGvunk9IlqqMS6VqdXbnlGWNLoK3Jt1OVLVueZ26xQ3/RUJjmLX3a2fukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StMH+2RP9sSiHt25PN2G1CnSxhlkiMh3QmkUUurpimY=;
 b=cNr2AFwQcxcrKerQwlKGXetkVJUSXgTIZvF4/J2fQmWl1Lz+ynIkmbXIcP+9hkrj9jleca2W42jnRK13x4fLLu0KECFXsqlOXZ6gcxziOeIlKE3NFcN7gb78dOf10mgNtbAIogs4F6h344Jjg3K/BiBwn5KPW4GmW6uu3FREI6qCO0HbqJKuFeEkGvoG9PEJikOVATF+Ya01OYQR2AKjx97QhYmC6JbdB4bakWZ6JSMOnVZgOb9bL5dSCVgyA4OVP/emBPo4drNFXfsnhGKv7riy874s1oMoMAMyJr8M9BcUOomUIfPezA5aI+6zsczQC1bS5wh8ZcUFdueeZVIJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StMH+2RP9sSiHt25PN2G1CnSxhlkiMh3QmkUUurpimY=;
 b=P3lk4g13mhwoYudtW8c//p2Ev3/FG7Mbsro+SEGXvX1JrOhrUACtgSCPgyu2QwdRs3ieQ90g9j99NSMEvYvDGRTdW2E8ANZ7zCK9Ad9+j+IOi7ec69S0igKh4z0ElqWBNcuFRc4cdUIVLRx7bQ3N3QZRcqI3LeXldFPkC0QtYBRQiTeecAjV85thvb2e/aV0z1QKMyPFsAh4ALvgoLPACEWaZjScwKOPk8kJEh87J1BMF3U9y29lXo6FJB1QQA8jPmVPxdRjbMlrpkdBl9iwG3mxDkPLsE4D+xyM3TzCe21jJl9QhTtEZpxBZudyZ9GAkQm1YIJ+dIJoKFoH+Kr59A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:20:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:20:08 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:03 +0800
Subject: [PATCH v4 3/8] imx93-frdm: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-3-deef133b81cd@nxp.com>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
In-Reply-To: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a42fe6-65d3-4775-589d-08deb56eacda
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: TIlc2wmi/BKLzmr4igl1VdqTH4XnqVJouq73g+UxLkMWehgTwi1QZH8NGwUP4cykTwb37RFQAd/QjDzipMwexQmq8qTdgvMmY/ZgfHPrpoaSanPetUhBdnGVp3lOfqaEGdWsb/LDfkzOUoFDTLxwmWDLRhV/ueQIhLDQ726X0q2/BuJFfVt2FDxA6NNMbUy9s9z/HZsBG/KDghvetHUYnNferm639MIs6nolNPuYNiEiUHn+VSdt/hA9fttdCC0JOg+ucHK22SsDvQ7TP44K71Fp9ZHFX6E9ptls0fNrwGKlyThnYvZ6liSXVLN40RJFznxmAsOKr8gXP9nlPPgGe05J4aJJZ/NsxiGur9kGVxC4E2ApdjRQ1S8QMFA3EzeA7VRtAOHtMkaEiIePZ1duGiW0vXFAEa8iENx5htnfsKnLxrbryl9eTWQAQGoPMc59371YqHm6h+yLuQKIQIWCs0HoXb33k/VKnTqkt6mm5Yp7ldMe3k47yZrPD2mPymPlkuHQ/b3SgGe0XpD+Zmkj9dntotMSZ89ILb1cHVOFOi3DIYF7vNAewZTNegkRjEEmU2WiK9kmVEeDQQltU/gpXwXzJONQYkLKEy34LYJ+dd5vJOf2QurXkljROhu1vUQVucwxfsntGTQ2Sk02c6eKZ/jaQ2VvZda06ngarJDUyJpeBdVAzsASupwW16j+sfl5GIvQH2T55UreNx+s+ybEaFn+7oMfWY7//B0G5fN6qkhTq7HjBzOFFmBYc9wRkbyz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklWcEg5RTN1c0cxUjlQdS9kUVZNaU5ROWIzRnNkKzRlMEIvM0xXQXh2NVZO?=
 =?utf-8?B?N0N4SkpKS016RVdzSEFxa0JjWHFHM0RoaElSQ2pDZUdVUklldzdFMzV4K2U5?=
 =?utf-8?B?VldpT2lrdVVCTDhHKzcxQzJvRUt0eW1LMjh4VGp3VWZ1VWFhdWFFTkFrbE9E?=
 =?utf-8?B?K0V3eFB5bHFjbmViNmgySFk4Z0NmRjhJcmhCZCtSdEJ4R2JPMkNPSTZnUThJ?=
 =?utf-8?B?L0lZdzBlR25ONXA0cWZJQ2ZzQS82SStFSDVkaVVrSm94dGQ0U1VkTlpGbmZU?=
 =?utf-8?B?NG9FRklOaVNuVU9ZVFkrNDJ1Ym9GckxNSVdIczlXV2NyTEJKaGs3U2ZCb0ZT?=
 =?utf-8?B?cHFqYlc5QldXamx6ZmJ1R29PYzhhWmpOaXVCdVZWWnRVZXZSaCsxUDZhZE4y?=
 =?utf-8?B?OFc0cVJLQ3NlYTFZMzZ6Y1IwL3NUMWFEemFqalZ2WVlWdHBRV2VFUEdFU0Rm?=
 =?utf-8?B?VU9DTTdLWFdqdC9CQlZtY3hlamhBaXFuSDBRNElvK1FqV0dqU1FweGF2MXVa?=
 =?utf-8?B?UzRxNUFuNWZDQkVxd1loWTBheFhud0Rvb1JBU0Vvb0xDbUZyN3JwWEVBcVBv?=
 =?utf-8?B?cTN4dmhXV1ZuT3R1ZldLWXVIYUJuNmF3U0g5Q3J3QnY2NlFoVXBodkNobm9k?=
 =?utf-8?B?NitZSmxqL3MxM3dKc0ZrejJUVVJGU3hGZ05HWE0zem14TjdxZzd5WWVGUVlN?=
 =?utf-8?B?NXNHOFZONGxEMUNLRTQ3U1ZSZFNhS1dGWEs3UHBuL3NqWHBDd3dEMG93aFlW?=
 =?utf-8?B?UGhLRURJRWROZ0pvNTNueFg2UHF6YzNpRzZHdXplZkUzSEdOakkrK29WR0Nw?=
 =?utf-8?B?WS9Fc3ZVMkM4dE1MWGRDd3VTQnh1VjJJeEk4VlVhZktiZHppdHhzSm5selQ3?=
 =?utf-8?B?TXRtWUdPeGRrZ0t6SWZ5ZnQycU1YWFg1N2hqZk5IZHdhVzdLVjlaZXdhejRz?=
 =?utf-8?B?S0VLWmdRWDJpUWdaT2xzMS9DMlhnRE1XaGFoZ3VhYnZjMEJhVVFNaUZpVmpi?=
 =?utf-8?B?Y2J4WFRNUWs5NkdqQWNYNWVPVUprOGNlcE9Jdlh5a3hUOW9rZVhOWnZaUWVJ?=
 =?utf-8?B?K2tKV25mNCtxOFhmNWpyUnNzVVBoYkpTbDJCWGc2bEpZaGhpcll6Vm9STi9W?=
 =?utf-8?B?SGxIT1hUcjRrM0hncEN1NFFna0Y4WnExaTY0U2lmR1Zsb3ZHcWc5ZHE4T1Ey?=
 =?utf-8?B?QTdyOS96dytoL1ArdmNwSUpqMHJqVDNaRmtQQUhVTkJReDBOMVZhN0JncUlB?=
 =?utf-8?B?dFNrV1NnbGswWnErQlR5YTAwRDEwNjdVSGJkekxXbm1mK0VVSndvSmNsNG96?=
 =?utf-8?B?aktUdXNYWU9NWmg5NE5PaGxqczZ4L0NndFo3TW5wQ3pmaTJ3RmpQNjZpTVdT?=
 =?utf-8?B?elllTnVYRkoxNmZxTCtWOVdQWDlMNi9XWjBJSzhrTTZySy9jSmVseFVvZ05w?=
 =?utf-8?B?eTVDcUhvQllmcWl4ZE0vckpSK3hULzE0aERYYzEzM25FVzJ4RjA4VEtabWZI?=
 =?utf-8?B?WFlPaFVHb1FWRlVwMlhLeTl6UnFzTUMvOEdjTlBsclVGWUpoa2pTZ0Fjc2JU?=
 =?utf-8?B?UXQxdUY1dEY0SytMS21tbFliRmdTK04yQmk2SHE1ejE0K1BKT3VTVnJIUFZG?=
 =?utf-8?B?cmxoYm14OEFWUXBaVmZJd0o0Q1pvSEF2K0k5NVhtejdDNFRoRFI0Wk9idW5N?=
 =?utf-8?B?NUhzTmUvVnNKQ09ycmdlY0NQQmIyMVJQdEJTSDRDaWdhT3ZsclhzTGxCaVlN?=
 =?utf-8?B?aDdQWnlpbE1UTDNDOFlQR0d2Tm9IY0dseHA2WEN2RjNhOHFRYkxBTUdwU2Vk?=
 =?utf-8?B?ZGltOENvd0gxMFRuZWZEc1ZSWHAvV091VVE2RUFZcko4UnZFczdOQ0o1S3Rx?=
 =?utf-8?B?WkJPVWN5U3YwSGExREozUWprcExiNUVWVGRPY2h3YWpINVdCSllHNmdNZnha?=
 =?utf-8?B?WThVZVJlNEkzSmcvaXkzaDBsYXFjS3A0bFJyMHQrT1FqbzAvanhxR2d4TXNJ?=
 =?utf-8?B?VG1Pd3ZGVjIwb3RIZ2xCbjFiakViOU80eUYxK2RUUUNqNEIzeHBhaHNBNVBs?=
 =?utf-8?B?N3g3ckFoSVJUb3h4RjNjUHNSWWdqS2JuS2QvOWozRUR3QlZldDJiVGc3NC9N?=
 =?utf-8?B?SFgyU0dPVTlmWGZIRmt1UUZjVWRMRFZLbGI4MGRPMFJJYzNwQ1ZYSU96VDFl?=
 =?utf-8?B?UU1BMlY2TXlSeWZ1V0F1ZG9EOCtFcnEwZlR2TVkvbmJvTWdNWURBY3lHSDBu?=
 =?utf-8?B?dGZJNWJYUjBQbjVmNmJsMEwxd2lnNUxudUZvb3ZrSUZRWWdxc1hNaWhQMHp1?=
 =?utf-8?B?NlY0K0hjZ3pZd1NvdkdKbFRrWWVNajgrbkJFWUpvdTFlc29KVE1qdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a42fe6-65d3-4775-589d-08deb56eacda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:20:08.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kevtUOyaSIAne+pwu6InQ/UDcDy1+LLuDk1sTRF3exzpNNpeuNzUTFJn0HfLNpBtcPVj4Q5vK311xu6F35jyXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

Switch the i.MX93 FRDM board to use the upstream device tree instead of
maintaining a local copy.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile             |   1 -
 arch/arm/dts/imx93-11x11-frdm.dts | 603 --------------------------------------
 arch/arm/mach-imx/imx9/Kconfig    |   1 +
 configs/imx93_frdm_defconfig      |   2 +-
 4 files changed, 2 insertions(+), 605 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d5dd0867622..6dda2d2f807 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -889,7 +889,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-librem5-r4.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-frdm.dtb \
 	imx93-var-som-symphony.dtb
 
 dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-evk.dtb \
diff --git a/arch/arm/dts/imx93-11x11-frdm.dts b/arch/arm/dts/imx93-11x11-frdm.dts
deleted file mode 100644
index 993567e767d..00000000000
--- a/arch/arm/dts/imx93-11x11-frdm.dts
+++ /dev/null
@@ -1,603 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/dts-v1/;
-
-#include <dt-bindings/usb/pd.h>
-#include "imx93.dtsi"
-
-/ {
-	compatible = "fsl,imx93-11x11-frdm", "fsl,imx93";
-	model = "NXP i.MX93 11X11 FRDM board";
-
-	aliases {
-		mmc0 = &usdhc1; /* EMMC */
-		mmc1 = &usdhc2; /* uSD */
-		rtc0 = &pcf2131;
-		serial0 = &lpuart1;
-	};
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-name = "vref_1v8";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		off-on-delay-us = <12000>;
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		pinctrl-names = "default";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc3_vmmc: regulator-usdhc3 {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "WLAN_EN";
-		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		/*
-		 * IW612 wifi chip needs more delay than other wifi chips to complete
-		 * the host interface initialization after power up, otherwise the
-		 * internal state of IW612 may be unstable, resulting in the failure of
-		 * the SDIO3.0 switch voltage.
-		 */
-		startup-delay-us = <20000>;
-	};
-
-	reserved-memory {
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		linux,cma {
-			compatible = "shared-dma-pool";
-			alloc-ranges = <0 0x80000000 0 0x30000000>;
-			reusable;
-			size = <0 0x10000000>;
-			linux,cma-default;
-		};
-
-		rsc_table: rsc-table@2021e000 {
-			reg = <0 0x2021e000 0 0x1000>;
-			no-map;
-		};
-
-		vdev0vring0: vdev0vring0@a4000000 {
-			reg = <0 0xa4000000 0 0x8000>;
-			no-map;
-		};
-
-		vdev0vring1: vdev0vring1@a4008000 {
-			reg = <0 0xa4008000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring0: vdev1vring0@a4010000 {
-			reg = <0 0xa4010000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring1: vdev1vring1@a4018000 {
-			reg = <0 0xa4018000 0 0x8000>;
-			no-map;
-		};
-
-		vdevbuffer: vdevbuffer@a4020000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa4020000 0 0x100000>;
-			no-map;
-		};
-	};
-
-	usdhc3_pwrseq: usdhc3_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pcal6524 12 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&eqos {
-	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_eqos>;
-	pinctrl-1 = <&pinctrl_eqos_sleep>;
-	pinctrl-names = "default", "sleep";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&fec {
-	phy-handle = <&ethphy2>;
-	phy-mode = "rgmii-id";
-	pinctrl-0 = <&pinctrl_fec>;
-	pinctrl-1 = <&pinctrl_fec_sleep>;
-	pinctrl-names = "default", "sleep";
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&lpi2c2 {
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		reg = <0x22>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		pinctrl-names = "default";
-	};
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-
-		regulators {
-
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4 {
-				regulator-name = "BUCK4";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			buck5: BUCK5 {
-				regulator-name = "BUCK5";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-
-	eeprom: eeprom@50 {
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-		pagesize = <64>;
-	};
-};
-
-&lpi2c3 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110", "tcpci";
-		reg = <0x50>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			data-role = "dual";
-			label = "USB-C";
-			op-sink-microwatt = <15000000>;
-			power-role = "dual";
-			self-powered;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "sink";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					typec1_dr_sw: endpoint {
-						remote-endpoint = <&usb1_drd_sw>;
-					};
-				};
-			};
-		};
-	};
-
-	pcf2131: rtc@53 {
-		compatible = "nxp,pcf2131";
-		reg = <0x53>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-	};
-};
-
-&lpuart1 { /* console */
-	pinctrl-0 = <&pinctrl_uart1>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usbotg1 {
-	adp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-
-	port {
-
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	status = "okay";
-};
-
-&usdhc1 {
-	bus-width = <8>;
-	non-removable;
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	status = "okay";
-};
-
-&usdhc2 {
-	bus-width = <4>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	no-mmc;
-	no-sdio;
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&wdog3 {
-	status = "okay";
-};
-
-&iomuxc {
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_eqos_sleep: eqossleepgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__GPIO4_IO00				0x31e
-			MX93_PAD_ENET1_MDIO__GPIO4_IO01				0x31e
-			MX93_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
-			MX93_PAD_ENET1_RD1__GPIO4_IO11				0x31e
-			MX93_PAD_ENET1_RD2__GPIO4_IO12				0x31e
-			MX93_PAD_ENET1_RD3__GPIO4_IO13				0x31e
-			MX93_PAD_ENET1_RXC__GPIO4_IO09                          0x31e
-			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08			0x31e
-			MX93_PAD_ENET1_TD0__GPIO4_IO05                          0x31e
-			MX93_PAD_ENET1_TD1__GPIO4_IO04                          0x31e
-			MX93_PAD_ENET1_TD2__GPIO4_IO03				0x31e
-			MX93_PAD_ENET1_TD3__GPIO4_IO02				0x31e
-			MX93_PAD_ENET1_TXC__GPIO4_IO07                          0x31e
-			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06                       0x31e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x58e
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_fec_sleep: fecsleepgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__GPIO4_IO14			0x51e
-			MX93_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
-			MX93_PAD_ENET2_RD0__GPIO4_IO24			0x51e
-			MX93_PAD_ENET2_RD1__GPIO4_IO25			0x51e
-			MX93_PAD_ENET2_RD2__GPIO4_IO26			0x51e
-			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x51e
-			MX93_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
-			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
-			MX93_PAD_ENET2_TD0__GPIO4_IO19			0x51e
-			MX93_PAD_ENET2_TD1__GPIO4_IO18			0x51e
-			MX93_PAD_ENET2_TD2__GPIO4_IO17			0x51e
-			MX93_PAD_ENET2_TD3__GPIO4_IO16			0x51e
-			MX93_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
-			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
-			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
-		>;
-	};
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c3: lpi2c3grp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
-			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__GPIO3_IO01            0x51e
-			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
-			MX93_PAD_SD2_DATA0__GPIO3_IO03		0x51e
-			MX93_PAD_SD2_DATA1__GPIO3_IO04		0x51e
-			MX93_PAD_SD2_DATA2__GPIO3_IO05		0x51e
-			MX93_PAD_SD2_DATA3__GPIO3_IO06		0x51e
-			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 94958fc3c46..92cc688cbc7 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -115,6 +115,7 @@ config TARGET_IMX93_FRDM
 	select REMOTEPROC_IMX
 	select REGMAP
 	select SYSCON
+	imply OF_UPSTREAM
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
index adcf2125c73..749879375fa 100644
--- a/configs/imx93_frdm_defconfig
+++ b/configs/imx93_frdm_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-frdm"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-frdm"
 CONFIG_TARGET_IMX93_FRDM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y

-- 
2.34.1

