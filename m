Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD50CD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D96A83EF9;
	Tue, 12 May 2026 06:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="thVXGY0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A395483CD3; Tue, 12 May 2026 05:08:11 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E4E483EEF
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neMtTheovtTeEfnyj7cXOOXEWAwFn1qjIZZjNKp/OTh+M0RA4M/8jKI+8LqaBVI2wqMPKQE2SIk2uCT+whnwOjX2JpPDNC8Nz9bvlgTbycrAfnVQnBUkz2DJ5aKRt32qxhumRxmv+XToV1Kt6fSbi+ZLQCBjn03/mVhLd71wF1SfwxNspy/zH45udD2F0SQvhCAYVAbK2zyvjrxf/t65lKStoKCbuzgSApABXhtHsLPuYKnrYMpWxg5AfMJmg4zQmm2nBBKhzcnzul+WtZhzPNln2jwq+1InIAfnfZNSVa0tr0n8TTwsPm56ghAOcHSKwFFwXQsWkZvP/h+tpfEm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n55P9pZHA2+01KMbpzIMBUsKEOWRAaO80kxRRQ84YQ=;
 b=rudrFYpsWoPhOayC/i2dlYYA3zcRyI0sS0mcpKKUx/ivw9K1OSMBYoT3EV1yvT1htX8UzKaJhDmKMZPzoZ8lj+E48sAdCcJupILVYucJcGgbcLWBmxAfQOyBBhaBopq2yXCQHgfaBLyQL8G4ocFnYmIINIVDGfRNyNKY9KfR2LGWTZ3Ok+3P24tzDnyi8mO8ECbIqoGgymOajvwygpJ0sZeKohkavHHBD3mrbkJl+Wv1FLR/3lpP1T7H3mF7b4pvwyMbf3uz30mCKP8Z8MyclHe8GAxzwKif1E8FKcAgYvCUaV8bpb1dUpPHeomHhILpj775LjkdC/mMHwuei0dxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n55P9pZHA2+01KMbpzIMBUsKEOWRAaO80kxRRQ84YQ=;
 b=thVXGY0UYxTSZ3Mhrfj7Xc3QydaK534oe6onZloZ+kbtvrTbwIdfdyTNhPBlBu1TXDTyzCnhEZ7O+FGgPIHtQ/iDzYAcQhqvIft0CLYkD1ZiOSafmH2+2Ry9VvGdg21OZgO1BWqrRzNo93jDtsUVK2wBfDhYVaQuPseCF+FhQ41rnNpauS7lOp3Wk0e3M3cClEIuj3c4KNCz2+cYO6FHkUHH3plJtwFEpfIMePb9c+N/jZD6p2OP+HRrP0g4r5iYb/Z4BqN7bp2UUu1WsBIsJJUNp2nKWHwb6fs8eTsa3RuIEbFJyqE1MFGmV52O8cJ8S5LdqWLt2PYbt+yprqXgBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:08:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:08:03 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:08 +0800
Subject: [PATCH v3 1/9] imx7ulp: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-1-0b9e1993557b@nxp.com>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
In-Reply-To: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Brian Sune <briansune@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, David Zang <davidzangcs@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRWPR04MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: 98165242-f7ee-4cdb-e811-08deafd3ae5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|22082099003|18002099003|56012099003|3023799003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: HuFNhD2m7qUyH2WbFx/PRHdIH0gDUEU3mO0HaTnuppACwo9ryANkPx1AAiB5Yw2YuNddcl1vUon/wgNnZvtUKtiNBbKDk57FghkZEodyrX2jQ9I6JUe8fYyU8pqyyUH6bx3wH1wADoAe0V7I6HQvL6yhxO0vJBbtCTiNgaXIDvtLIPUKfWNZVLpcnCPOJLjAQuH0tS35mCb9h/+qcpaX5Dg44VrnQXlCIwDUaM11bWk1CCHqU96MYDOtLk/jhvU3Row6+ZU0bcPPmRz59PJwmEwQLAzoZw2o9//LGZyraFGoQMMhyR0FIMs52y8g7+2tRAL7M6SVFH40iZJ+Mowb/qjNifJ0I1UjYFUf1LJ3DAeGwzYl/epw642iBkXheGCsfPmdq4PBi7zMloxD7MUWdwoNhGhUyNumvWOYVxzHYZMJ7RDxZ4L6+Gy7CpRY8c3evnSpBRYE/5XAc4AvxbwPxMRLywCbGi8r8lWhSP0od+cLvO4lMijTCAhW9slXiYExn/yIoYb7qVoo/ybfTa7myS+LM9XENmt61byp7vnbB1Rxafn9djtkYikRXck2yegcUi3QRGCjYSwEUDN1Tr3bDJGMqA4eq5FOfnVWbbkNpV4UpMqGTUmib8/VlhnrX/9SJaD7uSCe9rVbZY7gK39peuPbhzuyguaeai1rYufqm6A7bEu7F4itnFxQf4RlCD1IrkQf4fCDXIC+nZX78ugY1g/yy2QuA4mBIenfSjD9ly68LI8akMAe7ngkdLVE7D4I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhQN0s3T0VaQWJmSkZ5QzgvWFhDRXN3ejRMNHg2Wk5paDBWR2JZN05sOURl?=
 =?utf-8?B?a2p2bGpldFF6cVg1MEtNTjVzZHRVd01od2ZFK1dZdEFZaExuU1owamdXWjBP?=
 =?utf-8?B?RWRDVEpmSE03eURPZXdRY2NqZFl5KzRkTUluNjFtTHJucFNhdU10TFd1S2dN?=
 =?utf-8?B?YVBTRSs3MHR1eG9MeE5jdW5td1lBcTJ5MDhIYVZ6NGtOdzVZYmk4UWJzNlVF?=
 =?utf-8?B?VzFFeU1CM05PbGcvOXo0eUdyQ093UXpZb1JLcEJmR3VaN0JITjcvdnNyRzhP?=
 =?utf-8?B?R1lyd1hUa0Y5WjJ0eHRabHNJWUpHak9nUDE4c2VRSlVzSmtZMnVNSExqTEEz?=
 =?utf-8?B?OHJ6S01XUHM5b0I4Uit3R2o5WEhMOHFTeGc5OEZZYlJDcVRmS2hFR0dBUEdk?=
 =?utf-8?B?UGpzZlU1M3B2VU92RC9HVnpYS0pORFIyN2VRWGhaSjBSeWY4RXQ3MG50UmUz?=
 =?utf-8?B?a1QzMUc4dGd5Q0JCT1JTM0tUaVlJaHZjQ0RzZURyVTVpbWx1d3g1S3FjQjJw?=
 =?utf-8?B?OWZIZ1IvUmJQUFVmK3k3Q0pYZEEzTWdwWEJvUHBwMFhFSFhGcVhUV3ZPaE5D?=
 =?utf-8?B?QTJpUGNJL3FjSkRVVHIxcm01QWx6VXR1dlBkWlQvb2lCTHdtdE0xR3E3MWRH?=
 =?utf-8?B?TTc3L1F5WjZEL29WQVVqYjR5aUlzaHNVTlNldkkwbk9wZFVBZEhycms3SEFL?=
 =?utf-8?B?MUxTcit1USt3SHFES2ZOQW5hLy9ieUptbVFhWEVreHNKUzlodXduTU84TlNa?=
 =?utf-8?B?MnVzL1czR3pHS1lURFExaU5VOFNndm0wcC9CVk9ZMzhMcTJYQ1V4cGtzV0Mx?=
 =?utf-8?B?VkdVaHRVSUwrb3VKTmg2OFNNcnlSeXVpS3hHQTVCbWFGd0wrWVJwY1IwTHhy?=
 =?utf-8?B?K2QxakdXbVp6NG5YTzFybUwxWThyMS9HUDF1VmNRQ3JDZDdFR3VIK0YvcUo0?=
 =?utf-8?B?ei9FdjJMZENBbXRCeG1qT3o5Q3MzTHBDRmdhRFIxa3dmb2lDdkFiaDVvcTJB?=
 =?utf-8?B?WGxKeXJJZEFmeEU3eDBEZnRvWDFWSEhSNU44RWk2SWZ2TGdwSGhIRmlseVIz?=
 =?utf-8?B?T2IrMWVYU1VURVBGd1p5Mzhhd3FKenJjaHJQUFA1aHJPMEpQMlJsQWxsdDRU?=
 =?utf-8?B?Uld2cnJmRFZxby9wSHNBU292L05tbUpEbUY5R255TVM2aisrREJuUXVMNkU5?=
 =?utf-8?B?U2QxYnNEblJ2TDZsK2lRRjZQbVY5MU16ME0wWGQ5UkorcWU5OFZkd1hXOHpm?=
 =?utf-8?B?bzN4bU5EckxDRG1OTUduQ2VhSFRxcDFtajRTYWtWNE9RbllJOEpiQ0VPZkl0?=
 =?utf-8?B?ZGhxUzJEUmtyNi80b0cxK21pUE5wY2dFeE96Z2d0SHFCWkllWGlVcWxwcEZa?=
 =?utf-8?B?ZTQxeVpHZjEvOG8rL2JCaVpCdVVRc2lzdnFsOGxhZW9iVDBpOElBdmo0Z1pv?=
 =?utf-8?B?QjZTb0NXVk9DNjM1UHREQ21QN3I5QWxxMDhuNUZTODBpMWdnZURSbzlvRWow?=
 =?utf-8?B?MUtYNThvUUpmRDE4QUZtRkxxd2ZGeUxVTnM5SS94OWpMOXMvZmM4eG0zZmxj?=
 =?utf-8?B?VXEyUGRoWk12REJhSmgzNklYVjlzajZtZXg1aytSKzA5YVM0Z3IvT0dURmFl?=
 =?utf-8?B?S1hCTk53UDY0VC9aUjM2cHRpREhrNkp3TU9kWmdLOXVxdHlCN3lwajR3a2x2?=
 =?utf-8?B?eWlyTlMwbkdiaDR5OTdEdkpVcmlyMVA3ZG1Za2RESG5aTG9xU2VGSStGUHdp?=
 =?utf-8?B?M2FQbmV4aEhsN0pVYVZjTCt4Q1phekd4eXRBUDNZVGtFbXVSTEVPKzNrcFVj?=
 =?utf-8?B?Z01QSEEvSVhma3JyVG5wK0psTk5wVEozMStwMmtyckFnYTFLME9RcklwMm92?=
 =?utf-8?B?RFNwTk9uTU82ZGhEUnllMHBwUEFObUU3MXVhcjZHaG1NRnppdGg3eW5hZEpP?=
 =?utf-8?B?cVU4cW5HQUdjRzRTblRBbjZsMnNnRFo5MTRFSUxHYks5ZTYyRDM0U3Y5Z0l6?=
 =?utf-8?B?Qmg1YkJ0ZjlBT0Njd0R1QjJCTHNVaGxvMDVJbEF6UG44RW1sZDNBL2syNCtZ?=
 =?utf-8?B?WURrNkVoa0FnYXVyZ1U3c1AwVUNzSVcrY2RkcnVGYmtUN2xVcTRSWVo1WDJV?=
 =?utf-8?B?ZkhKYzRMV0lQMnRydGxWNHFhSVkzZW5Fc0RxL2pBQ2poTkIvb0grOEovS3lZ?=
 =?utf-8?B?UGE0T2pxY1lpaGo4YUdsN3hkKzBESFZuVEtpeWM2RTU5SVg0RWRXM1Z1SmJ5?=
 =?utf-8?B?SDE2U2NhU1lVY3RJcEowMWZPVTNDR0NkTEhVeXZXK2ZLRElEM3lMallIdjRa?=
 =?utf-8?B?aGNxOWE1UUZLQmZmYzZOMU5KWkk4a2FLRzBwYnQ3bGVPaXQ2WmZsUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98165242-f7ee-4cdb-e811-08deafd3ae5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:08:03.2958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiXbS/Wys16GqhUGDOYNukjfknAe/Ze3NKMjt6HtRSfFt//P9LPIf9xI2WV/jHCXi0nvZfOM8S9uJBbtAZyjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
X-Mailman-Approved-At: Tue, 12 May 2026 06:40:14 +0200
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

Migrate i.MX7ULP boards to use OF_UPSTREAM feature, which allows U-Boot
to directly use device trees from the Linux kernel upstream.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx7ulp-com.dts        |  79 ------
 arch/arm/dts/imx7ulp-evk.dts        | 133 -----------
 arch/arm/dts/imx7ulp.dtsi           | 461 ------------------------------------
 arch/arm/mach-imx/mx7ulp/Kconfig    |   2 +
 configs/mx7ulp_com_defconfig        |   2 +-
 configs/mx7ulp_evk_defconfig        |   2 +-
 configs/mx7ulp_evk_plugin_defconfig |   2 +-
 7 files changed, 5 insertions(+), 676 deletions(-)

diff --git a/arch/arm/dts/imx7ulp-com.dts b/arch/arm/dts/imx7ulp-com.dts
deleted file mode 100644
index d76fea3b35c..00000000000
--- a/arch/arm/dts/imx7ulp-com.dts
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright 2019 NXP
-
-/dts-v1/;
-
-#include "imx7ulp.dtsi"
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Embedded Artists i.MX7ULP COM";
-	compatible = "ea,imx7ulp-com", "fsl,imx7ulp";
-
-	chosen {
-		stdout-path = &lpuart4;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x4000000>;
-	};
-};
-
-&lpuart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1_id>;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	status = "okay";
-};
-
-&usdhc0 {
-	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_APLL_PFD1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	non-removable;
-	bus-width = <8>;
-	no-1-8-v;
-	status = "okay";
-};
-
-&iomuxc1 {
-	pinctrl_lpuart4: lpuart4grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC3__LPUART4_RX	0x3
-			IMX7ULP_PAD_PTC2__LPUART4_TX	0x3
-		>;
-	};
-
-	pinctrl_usbotg1_id: otg1idgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC13__USB0_ID	0x10003
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
-			IMX7ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			IMX7ULP_PAD_PTD3__SDHC0_D7	0x43
-			IMX7ULP_PAD_PTD4__SDHC0_D6	0x43
-			IMX7ULP_PAD_PTD5__SDHC0_D5	0x43
-			IMX7ULP_PAD_PTD6__SDHC0_D4	0x43
-			IMX7ULP_PAD_PTD7__SDHC0_D3	0x43
-			IMX7ULP_PAD_PTD8__SDHC0_D2	0x43
-			IMX7ULP_PAD_PTD9__SDHC0_D1	0x43
-			IMX7ULP_PAD_PTD10__SDHC0_D0	0x43
-			IMX7ULP_PAD_PTD11__SDHC0_DQS	0x42
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx7ulp-evk.dts b/arch/arm/dts/imx7ulp-evk.dts
deleted file mode 100644
index eff51e113db..00000000000
--- a/arch/arm/dts/imx7ulp-evk.dts
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
- *   Dong Aisheng <aisheng.dong@nxp.com>
- */
-
-/dts-v1/;
-
-#include "imx7ulp.dtsi"
-
-/ {
-	model = "NXP i.MX7ULP EVK";
-	compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp";
-
-	chosen {
-		stdout-path = &lpuart4;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
-	};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&tpm4 1 50000 0>;
-		brightness-levels = <0 20 25 30 35 40 100>;
-		default-brightness-level = <6>;
-		status = "okay";
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbotg1_vbus>;
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio_ptc 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vsd_3v3: regulator-vsd-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc0_rst>;
-		gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&lpuart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart4>;
-	status = "okay";
-};
-
-&tpm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm0>;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1_id>;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-&usdhc0 {
-	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_APLL_PFD1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_vsd_3v3>;
-	status = "okay";
-};
-
-&iomuxc1 {
-	pinctrl_lpuart4: lpuart4grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC3__LPUART4_RX	0x3
-			IMX7ULP_PAD_PTC2__LPUART4_TX	0x3
-		>;
-		bias-pull-up;
-	};
-
-	pinctrl_pwm0: pwm0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTF2__TPM4_CH1	0x2
-		>;
-	};
-
-	pinctrl_usbotg1_vbus: otg1vbusgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC0__PTC0		0x20000
-		>;
-	};
-
-	pinctrl_usbotg1_id: otg1idgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC13__USB0_ID	0x10003
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
-			IMX7ULP_PAD_PTD2__SDHC0_CLK	0x40
-			IMX7ULP_PAD_PTD7__SDHC0_D3	0x43
-			IMX7ULP_PAD_PTD8__SDHC0_D2	0x43
-			IMX7ULP_PAD_PTD9__SDHC0_D1	0x43
-			IMX7ULP_PAD_PTD10__SDHC0_D0	0x43
-			IMX7ULP_PAD_PTC10__PTC10	0x3	/* CD */
-		>;
-	};
-
-	pinctrl_usdhc0_rst: usdhc0-gpio-rst-grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD0__PTD0		0x3
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx7ulp.dtsi b/arch/arm/dts/imx7ulp.dtsi
deleted file mode 100644
index bcec98b9641..00000000000
--- a/arch/arm/dts/imx7ulp.dtsi
+++ /dev/null
@@ -1,461 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
- *   Dong Aisheng <aisheng.dong@nxp.com>
- */
-
-#include <dt-bindings/clock/imx7ulp-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-#include "imx7ulp-pinfunc.h"
-
-/ {
-	interrupt-parent = <&intc>;
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		gpio0 = &gpio_ptc;
-		gpio1 = &gpio_ptd;
-		gpio2 = &gpio_pte;
-		gpio3 = &gpio_ptf;
-		i2c0 = &lpi2c6;
-		i2c1 = &lpi2c7;
-		mmc0 = &usdhc0;
-		mmc1 = &usdhc1;
-		serial0 = &lpuart4;
-		serial1 = &lpuart5;
-		serial2 = &lpuart6;
-		serial3 = &lpuart7;
-		usbphy0 = &usbphy1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@f00 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <0xf00>;
-		};
-	};
-
-	intc: interrupt-controller@40021000 {
-		compatible = "arm,cortex-a7-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x40021000 0x1000>,
-		      <0x40022000 0x1000>;
-	};
-
-	rosc: clock-rosc {
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-		clock-output-names = "rosc";
-		#clock-cells = <0>;
-	};
-
-	sosc: clock-sosc {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "sosc";
-		#clock-cells = <0>;
-	};
-
-	sirc: clock-sirc {
-		compatible = "fixed-clock";
-		clock-frequency = <16000000>;
-		clock-output-names = "sirc";
-		#clock-cells = <0>;
-	};
-
-	firc: clock-firc {
-		compatible = "fixed-clock";
-		clock-frequency = <48000000>;
-		clock-output-names = "firc";
-		#clock-cells = <0>;
-	};
-
-	upll: clock-upll {
-		compatible = "fixed-clock";
-		clock-frequency = <480000000>;
-		clock-output-names = "upll";
-		#clock-cells = <0>;
-	};
-
-	ahbbridge0: bus@40000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x40000000 0x800000>;
-		ranges;
-
-		edma1: dma-controller@40080000 {
-			#dma-cells = <2>;
-			compatible = "fsl,imx7ulp-edma";
-			reg = <0x40080000 0x2000>,
-				<0x40210000 0x1000>;
-			dma-channels = <32>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "dma", "dmamux0";
-			clocks = <&pcc2 IMX7ULP_CLK_DMA1>,
-				 <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
-		};
-
-		crypto: crypto@40240000 {
-			compatible = "fsl,sec-v4.0";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40240000 0x10000>;
-			ranges = <0 0x40240000 0x10000>;
-			clocks = <&pcc2 IMX7ULP_CLK_CAAM>,
-				 <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>;
-			clock-names = "aclk", "ipg";
-
-			sec_jr0: jr@1000 {
-				compatible = "fsl,sec-v4.0-job-ring";
-				reg = <0x1000 0x1000>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			sec_jr1: jr@2000 {
-				compatible = "fsl,sec-v4.0-job-ring";
-				reg = <0x2000 0x1000>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		lpuart4: serial@402d0000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x402d0000 0x1000>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-			assigned-clock-rates = <24000000>;
-			status = "disabled";
-		};
-
-		lpuart5: serial@402e0000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x402e0000 0x1000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		tpm4: pwm@40250000 {
-			compatible = "fsl,imx7ulp-pwm";
-			reg = <0x40250000 0x1000>;
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		tpm5: tpm@40260000 {
-			compatible = "fsl,imx7ulp-tpm";
-			reg = <0x40260000 0x1000>;
-			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&pcc2 IMX7ULP_CLK_LPTPM5>;
-			clock-names = "ipg", "per";
-		};
-
-		usbotg1: usb@40330000 {
-			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
-			reg = <0x40330000 0x200>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_USB0>;
-			phys = <&usbphy1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			ahb-burst-config = <0x0>;
-			tx-burst-size-dword = <0x8>;
-			rx-burst-size-dword = <0x8>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@40330200 {
-			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc";
-			#index-cells = <1>;
-			reg = <0x40330200 0x200>;
-		};
-
-		usbphy1: usb-phy@40350000 {
-			compatible = "fsl,imx7ulp-usbphy", "fsl,imx6ul-usbphy";
-			reg = <0x40350000 0x1000>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_USB_PHY>;
-			#phy-cells = <0>;
-		};
-
-		usdhc0: mmc@40370000 {
-			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
-			reg = <0x40370000 0x10000>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&pcc2 IMX7ULP_CLK_USDHC0>;
-			clock-names = "ipg", "ahb", "per";
-			bus-width = <4>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step = <2>;
-			status = "disabled";
-		};
-
-		usdhc1: mmc@40380000 {
-			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
-			reg = <0x40380000 0x10000>;
-			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&pcc2 IMX7ULP_CLK_USDHC1>;
-			clock-names = "ipg", "ahb", "per";
-			bus-width = <4>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step = <2>;
-			status = "disabled";
-		};
-
-		scg1: clock-controller@403e0000 {
-			compatible = "fsl,imx7ulp-scg1";
-			reg = <0x403e0000 0x10000>;
-			clocks = <&rosc>, <&sosc>, <&sirc>,
-				 <&firc>, <&upll>;
-			clock-names = "rosc", "sosc", "sirc",
-				      "firc", "upll";
-			#clock-cells = <1>;
-		};
-
-		wdog1: watchdog@403d0000 {
-			compatible = "fsl,imx7ulp-wdt";
-			reg = <0x403d0000 0x10000>;
-			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
-			timeout-sec = <40>;
-		};
-
-		pcc2: clock-controller@403f0000 {
-			compatible = "fsl,imx7ulp-pcc2";
-			reg = <0x403f0000 0x10000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&scg1 IMX7ULP_CLK_DDR_DIV>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
-				 <&scg1 IMX7ULP_CLK_UPLL>,
-				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_ROSC>,
-				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
-			clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
-				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk",
-				      "firc_bus_clk", "rosc", "spll_bus_clk";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM5>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-		};
-
-		smc1: clock-controller@40410000 {
-			compatible = "fsl,imx7ulp-smc1";
-			reg = <0x40410000 0x1000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_CORE_DIV>,
-				 <&scg1 IMX7ULP_CLK_HSRUN_CORE_DIV>;
-			clock-names = "divcore", "hsrun_divcore";
-		};
-
-		pcc3: clock-controller@40b30000 {
-			compatible = "fsl,imx7ulp-pcc3";
-			reg = <0x40b30000 0x10000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&scg1 IMX7ULP_CLK_DDR_DIV>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
-				 <&scg1 IMX7ULP_CLK_UPLL>,
-				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_ROSC>,
-				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
-			clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
-				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk",
-				      "firc_bus_clk", "rosc", "spll_bus_clk";
-		};
-	};
-
-	ahbbridge1: bus@40800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x40800000 0x800000>;
-		ranges;
-
-		lpi2c6: i2c@40a40000 {
-			compatible = "fsl,imx7ulp-lpi2c";
-			reg = <0x40a40000 0x10000>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPI2C6>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPI2C6>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpi2c7: i2c@40a50000 {
-			compatible = "fsl,imx7ulp-lpi2c";
-			reg = <0x40a50000 0x10000>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPI2C7>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPI2C7>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpuart6: serial@40a60000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x40a60000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPUART6>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPUART6>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpuart7: serial@40a70000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x40a70000 0x1000>;
-			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3  IMX7ULP_CLK_LPUART7>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPUART7>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		memory-controller@40ab0000 {
-			compatible = "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
-			reg = <0x40ab0000 0x1000>;
-			clocks = <&pcc3 IMX7ULP_CLK_MMDC>;
-		};
-
-		iomuxc1: pinctrl@40ac0000 {
-			compatible = "fsl,imx7ulp-iomuxc1";
-			reg = <0x40ac0000 0x1000>;
-		};
-
-		gpio_ptc: gpio@40ae0000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40ae0000 0x1000 0x400f0000 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLC>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 0 20>;
-		};
-
-		gpio_ptd: gpio@40af0000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40af0000 0x1000 0x400f0040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLD>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 32 12>;
-		};
-
-		gpio_pte: gpio@40b00000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40b00000 0x1000 0x400f0080 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 64 16>;
-		};
-
-		gpio_ptf: gpio@40b10000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40b10000 0x1000 0x400f00c0 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLF>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 96 20>;
-		};
-	};
-
-	m4aips1: bus@41080000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x41080000 0x80000>;
-		ranges;
-
-		sim: sim@410a3000 {
-			compatible = "fsl,imx7ulp-sim", "syscon";
-			reg = <0x410a3000 0x1000>;
-		};
-
-		ocotp: efuse@410a6000 {
-			compatible = "fsl,imx7ulp-ocotp", "syscon";
-			reg = <0x410a6000 0x4000>;
-			clocks = <&scg1 IMX7ULP_CLK_DUMMY>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/mx7ulp/Kconfig b/arch/arm/mach-imx/mx7ulp/Kconfig
index e8cb58bc89f..eac3a2ad6af 100644
--- a/arch/arm/mach-imx/mx7ulp/Kconfig
+++ b/arch/arm/mach-imx/mx7ulp/Kconfig
@@ -35,6 +35,7 @@ config TARGET_MX7ULP_COM
 	select SPL_SEPARATE_BSS if SPL
 	select SPL_SERIAL if SPL
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_MX7ULP_EVK
 	bool "Support mx7ulp EVK board"
@@ -42,6 +43,7 @@ config TARGET_MX7ULP_EVK
 	select SYS_ARCH_TIMER
 	select FSL_CAAM
 	select ARCH_MISC_INIT
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index a49cb2a728f..d63168fe886 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -7,7 +7,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-com"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-com"
 CONFIG_LDO_ENABLED_MODE=y
 CONFIG_TARGET_MX7ULP_COM=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
diff --git a/configs/mx7ulp_evk_defconfig b/configs/mx7ulp_evk_defconfig
index 98b99dd78e1..6a42acc16ef 100644
--- a/configs/mx7ulp_evk_defconfig
+++ b/configs/mx7ulp_evk_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-evk"
 CONFIG_TARGET_MX7ULP_EVK=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_SYS_LOAD_ADDR=0x60800000
diff --git a/configs/mx7ulp_evk_plugin_defconfig b/configs/mx7ulp_evk_plugin_defconfig
index af0efbd3ebf..148b706d17a 100644
--- a/configs/mx7ulp_evk_plugin_defconfig
+++ b/configs/mx7ulp_evk_plugin_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-evk"
 CONFIG_TARGET_MX7ULP_EVK=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_SYS_LOAD_ADDR=0x60800000

-- 
2.34.1

