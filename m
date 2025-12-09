Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18381D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C789D83B7E;
	Tue,  9 Dec 2025 03:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YSkZD7LJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A492838CE; Tue,  9 Dec 2025 03:20:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCBC83B7E
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkZz9khAw5GNlBjtdC88H5d02u41dxixaUgcj2IDm3VZCtlx6WhVUwGXAIf4KHyZ28bOqQlOVwPTlrc9tMBFAQImB9x0dPiqWAn3DJu9AAhD50LyZpf6r/AcQpMFaMth10XXHAHpbnlllzCDTx7aDeCSkQ4z9oesAPBDRPM+5RlpWvD2K1hL9wXvsITZ1RvAAcuGF7vscH0k6nxMV2uPKjn2ZoAg0g4zRBZLJqA2BmyPQWiTqHIOQRe6uA2qYdapPgr7yMoYEfrmBZyNzZSMEfcETKg5HfzfyHhdRkhLDVcjiEUd064Ql2PZ7w1fCIB3DM7foumi8mB1/Wd5vt2JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F//kKyhsFw5N0X4dc2rTGv6zS3GCxx6ek1x3WNLXGXA=;
 b=BwsUCOY87mqsXlpRtVHJ6h7vaA8kchZKWJrbDgEr9RwLxxfE9mq0X9L0SMFClQVvQQ/tucKbsYTZZGAZGJ8Q/Wde81Jn4zPei7+YRcj7r75b5hFWpFE4AtkAjDIw3ubyb0biSm9qES4N6q2iJR/cHn8/NWnhH3HkaUnYWI9ghIEu2LHoZ+jW8jIK9F6zsKl97t924JE/TuqNAc5TwBkuHWEPFJCcFY1evVNEspdoGvhZSqm+W9p+yLlJnaWPvyzJzp9eo5UM40ypGDWRIkRiqk6mRjsPdl3qw8Cu+kFogPNG9O1xGIz+FFVaoa/Rkmnxl1A9VKYPGbIx31rKn6AuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F//kKyhsFw5N0X4dc2rTGv6zS3GCxx6ek1x3WNLXGXA=;
 b=YSkZD7LJqfd4F4Yl2y/9Xd4wMWk1xKwb8WamN38srvQ1VG0bwegRyFHQAjqXzR1XQ7yABXWMJyY5blFbUAQ+nG8sdrsxAj8SxVX4eleI5OUxcLrXNg1r9SkkERDY/ZvaSwOqxKZFcbxCqqN9o42E8ozJINQVkruQUTYCJOjJKQPoJoS0HY9Wb9ORgISlPGSNG3l14PsEQWm5gJZ7DwILE7grom5HPYGwZSK0M+jpBl9IWjhNqkTDXnhHvX6ic8cb222ZBYePyEsg14kUwXTEx4QTfRfucIuJsyV5pyNmxspRJP0i6xra13ZEKKb8KBNgraydyWHzSpeCKtTLa0QM/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 02:20:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:20:36 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:19:19 +0800
Subject: [PATCH v3 3/3] imx8ulp_evk: Switch to use devicetree imported from
 Linux kernel release
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-3-c58c22834737@nxp.com>
References: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-c58c22834737@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: c9724c81-49a2-4502-92e0-08de36c98a22
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?di9aNHlCekNhbTAwdlNMbXBlNzJrMUlFQmd0M0U3OXNoM1h6NEY4dDJxdk1q?=
 =?utf-8?B?TVd1Z0lYaCt6M3l5Y3h5L2FJSTc5MEZITlZzbGpyZ1RKTzJ5OGg2Ui9mSUJM?=
 =?utf-8?B?Q1ZDUHZJNFN6M0FnY1FtVzVYVVlvUTJHMUNCS3ordWJHM0NrMHp1YXpvMWg4?=
 =?utf-8?B?QWVmT09iRVpZTXM0aUpGYTZIbTE3VXJyYTFUb2kxN0w0VGtEY2JxaGg2WW5l?=
 =?utf-8?B?TlVwMjh4Q0RuckhKYkRSdTJDayt1SDQzcXkzaktaRHRWdFlvalEwSU5PaEpy?=
 =?utf-8?B?dUMxR2FVMkFlMzJ5RUdHZi8vZDZUc21sZmhvdHBXM0c4ZlpPdlMrU3ArK3k3?=
 =?utf-8?B?b2ZWbGRNSTJzZGxIYmVNbEZiRFkvRUZON09NSGRkM1ZNdG5LS0hJRXFadUgw?=
 =?utf-8?B?M3JuY1hFdHpaeEtDVksrYlpzUjlEL3RWNTg2N2Z2ZTZnNi92dW1IR0lDckd5?=
 =?utf-8?B?aGcyM1Y2eFNYTlNHTkhoQXNRUGVSditwYm1RQkIwK2tRWnNKTGxkSjVTRjQr?=
 =?utf-8?B?UlY2Wk1ncjU2R2hlTUtFVWVhZkFQN05OY3cxbmJhbGlvclRDNERjVjZXU0dz?=
 =?utf-8?B?WWtsTDJFWm5vTUkrUjNZRHFtd3pUSlJqUTBhV1F0NVNPNGFKYk03TTYxNkw4?=
 =?utf-8?B?Y2JpWjcxRUNPY0pzdStwT3piVVo4ZGxISkxpN21JOGExckVUUGk4c2lGaEh4?=
 =?utf-8?B?ZHA4Zys1WGhDcVJNOXNzcDk5Nkk4b0kvVE5KMFZsYitWVkV3RXUvUWhPbkg0?=
 =?utf-8?B?YXNpWjBFRkljcy9WaWp6TjJGSFBlUlpuQ25DRHVuZkt3VHFtbUVZSmNSK3Zx?=
 =?utf-8?B?VFp4YTQxWVI4WmQ2NWZkVkl2djI2S0YyeTZtNS9SOVJPTzRacVhsSThSU08z?=
 =?utf-8?B?QTZxUXFMK2hRckZheDRpRnFwemlDUE1QdHRqbU1ncm11Tk02cEtvN3lYbFZ3?=
 =?utf-8?B?MGtvZVQ5VFk1UU9UOUZuODFOK0FxK0ZxNEU4T3A1Y1U3NTk0QUV3S2tXQUFQ?=
 =?utf-8?B?QmFWRU44aWNISUNaR0ZibDM5ZGNlVUYxZ2hLbklkSmQxNkR3YzJXVytRL1J1?=
 =?utf-8?B?cW0xQTg2c0NqNEFld0RKamFoOGRNZ1hWMDN4TkRjSENYMFZLb0tCWHhYYW5H?=
 =?utf-8?B?NlR4L3ZyMnFMYXVvSFBIbTFoc0NZSktseGxPUGxhNVBNMFBFUUhQYnFyQjla?=
 =?utf-8?B?R0d2WDNMMkdXdzVrSzRCV1FOd291ZXpsd2pid2xiMWhKby9tdGxHTU42d0Y1?=
 =?utf-8?B?NThlOXk0VXhYNlVmKzZscllCNUpPeXRMK081TkZoZkNCQkoxRXY4RHFsL0k5?=
 =?utf-8?B?ZjVhK3ZtZ1I5bmRsYTVzeW83cXZJdld6MStNeXBWUFhPMXhvRVpUenZveWFn?=
 =?utf-8?B?NlY4VDl5VllJVmZDby9uTHJ1OU0rUisrcGtpaUM1UG9CUW5sd0pta2JrWU01?=
 =?utf-8?B?V0dja093VTdwbDlQT3pUTjl6MmZpN25EY0VEWXBRNlM2ZlhMa2k5Nis5RTk4?=
 =?utf-8?B?dmpOTms4YnJGeVR1QXg5Sk1kc2pMYWlQVENnaUpxMzFLMk5hMktsWnNEc0RG?=
 =?utf-8?B?enpScGhSY04rczdJSHZmanduSWx4SW5USEFobjhodFlkOXZtTUJ0ZXIyakxO?=
 =?utf-8?B?UGk1ZFVFNFY4NkJIdGxmNC94U1VxVktGL3pvSVRMQ0NVSytBZGJSTkZRRksw?=
 =?utf-8?B?OTZFMyt5dVE1T043RThCekVic1pBZzRISkN2Z0FWQ3F5eXllSnZPTFJ2Lzlm?=
 =?utf-8?B?TU5YSStnZUFyekNxTjFWNjdwYmNlZ3BqVUd0Ylc0WXNEUFc1bm1PNWJESTZR?=
 =?utf-8?B?OGwwbDVHb2dLMThMaFNuUUpXdys3YnNwalA1bUpMVCttU1Zua2F6VXhhdWFw?=
 =?utf-8?B?MUgyaEhzZEtTUTcwMU9iRk5wTUZqMWY1Y0hCRUl6OHhwSjlOQTJrUjJsN2ZY?=
 =?utf-8?B?NmJPUEV4clUxSnZ3NWF3YXFmclhIc3NlZUxiRW5TZzBlcUo1OFBVNXh2cEln?=
 =?utf-8?B?cThJdVhBYW15U3VOekFaMUpKODd1TGZseXliclhQRGNZWjNzQzZINTVkOStn?=
 =?utf-8?Q?LEJZ2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWxES08rbFNyNVpNWVFLaFgyOU5lYlhQVDZpaWwveS8xN2h3dmp5Ry9tSjhX?=
 =?utf-8?B?Tzg1VUVZSjE5VUFuTU1UcjJ4VGlBNXZSR2dkUDJmWm1ScHFJbzRBRHZYbkpS?=
 =?utf-8?B?NXBlMzBieHplQmhhOXFLbng4QytXVEdWeWZSYTRqQklXblpZa21tZUhFUzhl?=
 =?utf-8?B?MFNzTkdUYlgzWTJNR1Z2cWFrTTRVTUoyQjYvSERHL1VaaWVOSmU1UzdjdlZP?=
 =?utf-8?B?TUxpaXNRMDY5c1IzeHU2N3NQdjlvNTdlenNxa1kwOHpzVU5XN2xzQUNHRDdv?=
 =?utf-8?B?VTVTWlRaaVZ0STNneVlQYStzWCsxakx1Q2J2djVBdTFGcnoyU1NjSm1XeStm?=
 =?utf-8?B?cFd5UzlwVFJBYlB5OGFMNUJMMVVJblNsanBTQ2FUd1pIZHZxQUVhRCs3L0JT?=
 =?utf-8?B?T3ZjeEhUbTQzZVpZMjRpVDI0THYzMTdZMEdaMGwxTWJ5YTc2Ky9TUHd2azNE?=
 =?utf-8?B?OExBMDZZaUF4ajVuUTJUOHVSZVZXaThxRkhKUjdNMkNGT2R1bVFzUGRDcDYx?=
 =?utf-8?B?dVd4a1FodWlRelJyRnJGQ3YzaXBBOUdTa2VhWFAzQnM3NWRnb2k0djdEbWdL?=
 =?utf-8?B?alRTeW9oaGVtLzZjSE9URm53WGtLcnZwTE4rVHZEYUkvcmVoUktvZTRZblZE?=
 =?utf-8?B?eWJyWVlJMkUwMU04cXA4Rm5WVWVrWmo3VC9ib0hrVlQzazhIbmF3SVFXTjdY?=
 =?utf-8?B?dXBPMk5PM2JVcnduNDVGTzFLaStCTVZwMTFvdDg5Ymx4TnBENHp3b2ZRU1hk?=
 =?utf-8?B?WG40WFYrL21FTjZ6b2QvdGJqSFNxazlLRTA5eHQvcU5YTVV0VzhQWnowV3Fv?=
 =?utf-8?B?VnZHK1JqYWZBblUxVTNiSjNJeDlCemw5Sll3N3VzczlGalgyUm5BUVFIaHkv?=
 =?utf-8?B?dUhXdDhaZkxackl5ajFRY3RQeVV0SVRKWkFIYW9hV2g2QzJGSTZObUpvR2hL?=
 =?utf-8?B?V25SelMrRWRlektsK1pLdmlmRFpZa0N5cG1sMzJ4M3pKNERmSGlneFg5RkhI?=
 =?utf-8?B?SUdwNGpQSkNCdHZlM3VaZDlxbFJwN0J3ZUtacFlIdDlBOElHQVgwQngzdjlk?=
 =?utf-8?B?RDJxRWJHcVBnOWJ0VUZuMFlzRjhHcjFraWJDWmJiRldHSHJvNU4xWXkwMk1J?=
 =?utf-8?B?Z2xDMTErMnlpZ0tLbzM4NFlpZFJ1eGVvd0JUeWZObXFoTUQ5QUdWQytZeElt?=
 =?utf-8?B?cEgrbzdvRXdCZUJjY3ZLUUs3a3ZoRVJQN3E5NE16UWdmUjU2NHE2YW1HSEFW?=
 =?utf-8?B?SmtGOUt1RXNUTW9JYnphNi9ULzJUWDNHendmQWx6dk9oVkV3NE1hUWJubTB2?=
 =?utf-8?B?MnVBK2hVemRpN0ZEWmc5OWd4NTYramhTWHVHd2UvbVFJa2FaY0poZzl3K0dw?=
 =?utf-8?B?MzI1U2RLYmQvaHJiWVMvZ2Y3L0lJMDV5VElXbkpoQzc1UjBYNDROK01UZkFJ?=
 =?utf-8?B?K0VnRDVHQ05PUWFUZ1ozYWt2d3I2aXBMOHFtVVRhYUp3WllFUGFPelJQNFI0?=
 =?utf-8?B?azRtdDJ6VGVBTlZlZk0zaGt2S1k0Zjh0ck1RUW1GVzk5T1FjcjlJUE1GRGNh?=
 =?utf-8?B?YXEwMHpCY2tCSXdwK2pER0tTNUJXeGVqODBFcFdYOG4vMlBtOTJIRU8rOXRP?=
 =?utf-8?B?RG9jcWlKdkg0MGgyZUZZMWkzbnJxZkh0YU9HcmNaNW5PRDRIRGZuWUs0TExu?=
 =?utf-8?B?bHFJM3BoM1BKUFdpWUROcit3ZmN0dTdnQ3FXOXlIZTkwTDZ4K1Jxb2FKTzBU?=
 =?utf-8?B?MXhOb2piVlU3L3F4ZmREamt1THJXYUZVZWpiVi8wcnRFSmUxUU1mcmxpOXlM?=
 =?utf-8?B?Tnp0eGVqNElYa0RQOWpoYVpXZVBvR21kdkZ0ZHhudDFpZC81TE9UUEN6NmRl?=
 =?utf-8?B?TWQ2azIxZlMvb254WDdWbDBUWTEwemplN25vWUFwU3JWTDM4QTQ0V0dVaTdH?=
 =?utf-8?B?ZWw3L01WbWhMdEh0dWc4MzBQS1NPUFZEWE9mNkIrUWtCUnpHWS9LdDNLenFx?=
 =?utf-8?B?NjBpcW9QNjdkWUpHR2Z6c3o4WmNsUnlwODBPN1E0cGNTd0NEYlF5SUs1VTB4?=
 =?utf-8?B?am5nT2grV2FOSVo3RFFPdzNUL0NSekZoWEwvT1B4TExJRU5kTXlNQkVVUFZT?=
 =?utf-8?Q?siRBqWhLoPXfMe5HcCVkOuZ+E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9724c81-49a2-4502-92e0-08de36c98a22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:20:36.8381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5k5rNrIfBb6CzjFjWLm1D8gUwcZKfi0iFdKCWQHLqYswAWO2oD5N9gg9mhQu2wzjkUNoe9TqpUFVLnulddod2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
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

Enable OF_UPSTREAM for i.MX8ULP EVK so that devicetree imported from
Linux kernel release can be used.

If mailbox@29220000 is enabled, gd->arch.ele_dev will be set to this
device for communication with ELE firmware. This is incorrect because
mu@27020000 is the MU used for communication with the ELE firmware. To
prevent misconfiguration, disable mailbox@29220000.

The driver model for watchdog timer is not enabled yet, so disable wdog3
temporarily.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/Makefile                |   3 -
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |   8 +
 arch/arm/dts/imx8ulp-evk.dts         | 125 ---------
 arch/arm/dts/imx8ulp.dtsi            | 476 -----------------------------------
 arch/arm/mach-imx/imx8ulp/Kconfig    |   1 +
 configs/imx8ulp_evk_defconfig        |   2 +-
 6 files changed, 10 insertions(+), 605 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcad6fb2fc7..28d3f701f3f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -880,9 +880,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	fsl-imx8qxp-mek.dtb \
 	imx8-capricorn-cxg3.dtb \
 
-dtb-$(CONFIG_ARCH_IMX8ULP) += \
-	imx8ulp-evk.dtb
-
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 2782dc7dd75..860994129ae 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -22,6 +22,14 @@
 	bootph-all;
 };
 
+&mu {
+	status = "disabled";
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
 &per_bridge4 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
deleted file mode 100644
index 7aec1706382..00000000000
--- a/arch/arm/dts/imx8ulp-evk.dts
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- */
-
-/dts-v1/;
-
-#include "imx8ulp.dtsi"
-
-/ {
-	model = "NXP i.MX8ULP EVK";
-	compatible = "fsl,imx8ulp-evk", "fsl,imx8ulp";
-
-	chosen {
-		stdout-path = &lpuart5;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0 0x80000000>;
-	};
-
-	clock_ext_rmii: clock-ext-rmii {
-		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "ext_rmii_clk";
-		#clock-cells = <0>;
-	};
-
-	clock_ext_ts: clock-ext-ts {
-		compatible = "fixed-clock";
-		/* External ts clock is 50MHZ from PHY on EVK board. */
-		clock-frequency = <50000000>;
-		clock-output-names = "ext_ts_clk";
-		#clock-cells = <0>;
-	};
-};
-
-&lpuart5 {
-	/* console */
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpuart5>;
-	pinctrl-1 = <&pinctrl_lpuart5>;
-	status = "okay";
-};
-
-&usdhc0 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	pinctrl-1 = <&pinctrl_usdhc0>;
-	non-removable;
-	bus-width = <8>;
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_enet>;
-	pinctrl-1 = <&pinctrl_enet>;
-	clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-		 <&pcc4 IMX8ULP_CLK_ENET>,
-		 <&cgc1 IMX8ULP_CLK_ENET_TS_SEL>,
-		 <&clock_ext_rmii>;
-	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
-	assigned-clocks = <&cgc1 IMX8ULP_CLK_ENET_TS_SEL>;
-	assigned-clock-parents = <&clock_ext_ts>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@1 {
-			reg = <1>;
-			micrel,led-mode = <1>;
-		};
-	};
-};
-
-&iomuxc1 {
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX8ULP_PAD_PTE15__ENET0_MDC     0x43
-			MX8ULP_PAD_PTE14__ENET0_MDIO    0x43
-			MX8ULP_PAD_PTE17__ENET0_RXER    0x43
-			MX8ULP_PAD_PTE18__ENET0_CRS_DV  0x43
-			MX8ULP_PAD_PTF1__ENET0_RXD0     0x43
-			MX8ULP_PAD_PTE20__ENET0_RXD1    0x43
-			MX8ULP_PAD_PTE16__ENET0_TXEN    0x43
-			MX8ULP_PAD_PTE23__ENET0_TXD0    0x43
-			MX8ULP_PAD_PTE22__ENET0_TXD1    0x43
-			MX8ULP_PAD_PTE19__ENET0_REFCLK  0x43
-			MX8ULP_PAD_PTF10__ENET0_1588_CLKIN 0x43
-		>;
-	};
-
-	pinctrl_lpuart5: lpuart5grp {
-		fsl,pins = <
-			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
-			MX8ULP_PAD_PTF15__LPUART5_RX	0x3
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
-			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			MX8ULP_PAD_PTD10__SDHC0_D0	0x43
-			MX8ULP_PAD_PTD9__SDHC0_D1	0x43
-			MX8ULP_PAD_PTD8__SDHC0_D2	0x43
-			MX8ULP_PAD_PTD7__SDHC0_D3	0x43
-			MX8ULP_PAD_PTD6__SDHC0_D4	0x43
-			MX8ULP_PAD_PTD5__SDHC0_D5	0x43
-			MX8ULP_PAD_PTD4__SDHC0_D6	0x43
-			MX8ULP_PAD_PTD3__SDHC0_D7	0x43
-			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10042
-		>;
-	};
-};
-
-&wdog3 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/imx8ulp.dtsi b/arch/arm/dts/imx8ulp.dtsi
deleted file mode 100644
index 06ce5f19aa8..00000000000
--- a/arch/arm/dts/imx8ulp.dtsi
+++ /dev/null
@@ -1,476 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- */
-
-#include <dt-bindings/clock/imx8ulp-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/imx8ulp-power.h>
-
-#include "imx8ulp-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &fec;
-		gpio0 = &gpiod;
-		gpio1 = &gpioe;
-		gpio2 = &gpiof;
-		mmc0 = &usdhc0;
-		mmc1 = &usdhc1;
-		mmc2 = &usdhc2;
-		serial0 = &lpuart4;
-		serial1 = &lpuart5;
-		serial2 = &lpuart6;
-		serial3 = &lpuart7;
-	};
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		A35_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&A35_L2>;
-		};
-
-		A35_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x1>;
-			enable-method = "psci";
-			next-level-cache = <&A35_L2>;
-		};
-
-		A35_L2: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	gic: interrupt-controller@2d400000 {
-		compatible = "arm,gic-v3";
-		reg = <0x0 0x2d400000 0 0x10000>, /* GIC Dist */
-		      <0x0 0x2d440000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a35-pmu";
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_PPI 7
-			     (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-		interrupt-affinity = <&A35_0>, <&A35_1>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
-	};
-
-	frosc: clock-frosc {
-		compatible = "fixed-clock";
-		clock-frequency = <192000000>;
-		clock-output-names = "frosc";
-		#clock-cells = <0>;
-	};
-
-	lposc: clock-lposc {
-		compatible = "fixed-clock";
-		clock-frequency = <1000000>;
-		clock-output-names = "lposc";
-		#clock-cells = <0>;
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
-	sram@2201f000 {
-		compatible = "mmio-sram";
-		reg = <0x0 0x2201f000 0x0 0x1000>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x0 0x2201f000 0x1000>;
-
-		scmi_buf: scmi-sram-section@0 {
-			compatible = "arm,scmi-shmem";
-			reg = <0x0 0x400>;
-		};
-	};
-
-	firmware {
-		scmi {
-			compatible = "arm,scmi-smc";
-			arm,smc-id = <0xc20000fe>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			shmem = <&scmi_buf>;
-
-			scmi_devpd: protocol@11 {
-				reg = <0x11>;
-				#power-domain-cells = <1>;
-			};
-
-			scmi_sensor: protocol@15 {
-				reg = <0x15>;
-				#thermal-sensor-cells = <1>;
-			};
-		};
-	};
-
-	soc: soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x40000000>;
-
-		s4muap: mailbox@27020000 {
-			compatible = "fsl,imx8ulp-mu-s4";
-			reg = <0x27020000 0x10000>;
-			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-		};
-
-		per_bridge3: bus@29000000 {
-			compatible = "simple-bus";
-			reg = <0x29000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			mu: mailbox@29220000 {
-				compatible = "fsl,imx8ulp-mu";
-				reg = <0x29220000 0x10000>;
-				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			mu3: mailbox@29230000 {
-				compatible = "fsl,imx8ulp-mu";
-				reg = <0x29230000 0x10000>;
-				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_MU3_A>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: watchdog@292a0000 {
-				compatible = "fsl,imx8ulp-wdt", "fsl,imx7ulp-wdt";
-				reg = <0x292a0000 0x10000>;
-				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SOSC_DIV2>;
-				timeout-sec = <40>;
-			};
-
-			cgc1: clock-controller@292c0000 {
-				compatible = "fsl,imx8ulp-cgc1";
-				reg = <0x292c0000 0x10000>;
-				#clock-cells = <1>;
-			};
-
-			pcc3: clock-controller@292d0000 {
-				compatible = "fsl,imx8ulp-pcc3";
-				reg = <0x292d0000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-
-			tpm5: tpm@29340000 {
-				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
-				reg = <0x29340000 0x1000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_TPM5>,
-					 <&pcc3 IMX8ULP_CLK_TPM5>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@29370000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29370000 0x10000>;
-				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>,
-					 <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@29380000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29380000 0x10000>;
-				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>,
-					 <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpuart4: serial@29390000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29390000 0x1000>;
-				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPUART4>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart5: serial@293a0000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x293a0000 0x1000>;
-				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPUART5>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpspi4: spi@293b0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
-				reg = <0x293b0000 0x10000>;
-				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>,
-					 <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpspi5: spi@293c0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
-				reg = <0x293c0000 0x10000>;
-				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>,
-					 <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-		};
-
-		per_bridge4: bus@29800000 {
-			compatible = "simple-bus";
-			reg = <0x29800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pcc4: clock-controller@29800000 {
-				compatible = "fsl,imx8ulp-pcc4";
-				reg = <0x29800000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-
-			lpi2c6: i2c@29840000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29840000 0x10000>;
-				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>,
-					 <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@29850000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29850000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>,
-					 <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpuart6: serial@29860000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29860000 0x1000>;
-				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPUART6>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart7: serial@29870000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29870000 0x1000>;
-				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPUART7>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			iomuxc1: pinctrl@298c0000 {
-				compatible = "fsl,imx8ulp-iomuxc1";
-				reg = <0x298c0000 0x10000>;
-			};
-
-			usdhc0: mmc@298d0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298d0000 0x10000>;
-				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_XBAR_AD_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC0>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			usdhc1: mmc@298e0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298e0000 0x10000>;
-				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC1>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@298f0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298f0000 0x10000>;
-				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC2>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			fec: ethernet@29950000 {
-				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
-				reg = <0x29950000 0x10000>;
-				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "int0";
-				fsl,num-tx-queues = <1>;
-				fsl,num-rx-queues = <1>;
-				status = "disabled";
-			};
-		};
-
-		gpioe: gpio@2d000080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pcc4 IMX8ULP_CLK_RGPIOE>,
-					 <&pcc4 IMX8ULP_CLK_PCTLE>;
-				clock-names = "gpio", "port";
-				gpio-ranges = <&iomuxc1 0 32 24>;
-		};
-
-		gpiof: gpio@2d010080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pcc4 IMX8ULP_CLK_RGPIOF>,
-					 <&pcc4 IMX8ULP_CLK_PCTLF>;
-				clock-names = "gpio", "port";
-				gpio-ranges = <&iomuxc1 0 64 32>;
-		};
-
-		per_bridge5: bus@2d800000 {
-			compatible = "simple-bus";
-			reg = <0x2d800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			cgc2: clock-controller@2da60000 {
-				compatible = "fsl,imx8ulp-cgc2";
-				reg = <0x2da60000 0x10000>;
-				#clock-cells = <1>;
-			};
-
-			pcc5: clock-controller@2da70000 {
-				compatible = "fsl,imx8ulp-pcc5";
-				reg = <0x2da70000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-		};
-
-		gpiod: gpio@2e200080 {
-			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc5 IMX8ULP_CLK_RGPIOD>,
-				 <&pcc5 IMX8ULP_CLK_RGPIOD>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 0 24>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index fbca241e106..37a8cefd6cc 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -27,6 +27,7 @@ config TARGET_IMX8ULP_EVK
 	select IMX8ULP
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index baca0b41099..ff6cd8e6c98 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx8ulp/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8ulp-evk"
 CONFIG_TARGET_IMX8ULP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y

-- 
2.43.0

