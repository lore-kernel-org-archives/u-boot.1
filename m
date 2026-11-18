Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81522606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rxec+lA1;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GaB3nzL4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D51E80CBF;
	Wed, 18 Nov 2026 05:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_swJ5O5W7oo; Wed, 18 Nov 2026 05:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0E148107E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979066;
	b=mJg2QrvDS1v0M2c28sGeHXgwXwAsCnWv/c21RIV9roPlZGp7OmN84CdY+HqOFrp4+h2u
	 9nc4YhNMfhtcbhNKzQr0QCoXB3FikVpegLdNNWF2a7L7/mrkKStPhmFPBUgtNUYZ5UKXA
	 y1OTQTCrSRKxClh80Z2+vFXrZ9UldORW6nHsDpQeamDBG+nBVx49NVFT86wmrG5Fjw5d8
	 wE6GZojaMsYGL64ioknwooNKDOSuqYaaYpjl/Jt+qEGEM106aTwULM6YxEryStKejrW6a
	 dyPpfM8PGkqhcPFtX5kwrLDRf+Z3fWQgRBgQAFvC2jJSy/MvYpc5mwghMX28o0F5kIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dnNyFe3g0oCVVFqrDLy0560nplTqwIfsGFYIupRrm0M=;
	b=EEAZosF7gdZ7dl0Ik0kApsjGQOqtsCc/KxyutU/0Xs/rmeTwTSuJv78CfUlF0Ok7xtM9
	 i94Eb7G3QOedC0pRrAUtHD8QDgUCIZBcPy4zZ7ZFc28PV8EbYlM4CvTEjn/zyChI18Nlb
	 1c9rBj7Bjafw+Rf3hcAxLw/n4oynDxR29n98E40zxZC+REhdDboc9nQV42kZxWzbmhiDb
	 kQeIxDSF3gbf27OzG2dxuflQicbHm4LI13MISiuRn6MkH6DtvGB9pdWBfFA1s/uzNKvTJ
	 QHjJBaEwhqgbdGFgda26LSb7efZwdru6ZWm2NdQuN56aXuflvL4FKKnUbCdD6H3ZQ8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979066;
	bh=dnNyFe3g0oCVVFqrDLy0560nplTqwIfsGFYIupRrm0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rxec+lA148qHM63upVwPR9E3Jij6R3Z8mSlklPGVLR31CTOcgTLr15erlu/NoiTwh
	 48kzYSWAmSWsxhpIZZCzABpR+vuV/QuBcrMchPeSW2vXbmRqfBqIHZIkB5ruQuWs9R
	 yySxwOcnJNOn0kNJ5ikqVfT6lvLy6UxXtCLkfppXs2KlmNSjXc3l6xPsNu5ekPfkLh
	 ANcAXl9pRPk/5VsPa8aXXa9qhdaqFqD7OzN5srF/pjMeiXa11ReBUoXtTBcFs5pPZx
	 9saFXuFP7mwIMYUqV6xoJ2hGSlLs2ZmWPJSNZsCf30EEjiQ5FMj8z9OoOWF+Pg1ljJ
	 2XwMXeJ8oG0jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0E148107E;
	Wed, 18 Nov 2026 05:17:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F3C8A32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1152D6081D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d17irmkAMV2U for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A06660743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=GaB3nzL4
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A06660743
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnNyFe3g0oCVVFqrDLy0560nplTqwIfsGFYIupRrm0M=;
 b=GaB3nzL4/5cz+EB8PXr72dLr5AsaWtE40H/EYmQxhy51vc31arK+tC/kaWuNyqd3G4AeD/zhdVWDZ/biUFb5LFoD/pjEPMiwZHzfAcBjX9vBhNlwvyn0Yji7ByIl2mlpMuth24sk2dfIYb/1lMH9VQrZb5UHgKx76HZsD6nLENownaQDsC9pDLmaK28MNl96G1tOB8GtCUM6g7PQg0foQebqgrwqibg5Q9OTPfYhjeLmuVj1Vif+scTxx2cCWg8OWvNTiyoUHmt8HyIxejcCxZ87kXKT9sHvs2hGUaY4dqeDNwVZRAVdLJMSSqYzPwGGUUNcxfwMW0dDYLMKnGFDMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:17:40 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:17:40 +0000
Date: Wed, 18 Nov 2026 13:13:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] power: domain: Constify driver ops
Message-ID: <av00D-852toVCl-3@nxa18884-linux-1.ap.freescale.net>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
 <20261116174138.3488177-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174138.3488177-2-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 90976349-1929-4c5e-36d4-08df45334450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|376014|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: tYcr23lYm29AcyWb8NbuMIQ3HRK2aWEK5PvUldVvp5eIW19xIExjHCxrSJmHR6hruVfsLqGiScCal4jnXU//RwuV9oGijt/PafSaTcsMaUMnoc/4wMqhzCnuvJYcVnaor0O9pObpZiNjBm18ANXbmkbUg/6wZZs2l2fhCqwd4vDTKgpHHb3J6mpcVU+9w71ZuzKZD6U0sDZ2DChWDhCjUVHGkEJacJIPDekWNGDtkLYnGtppLghthYEuGbInsn1xW0/XKrVZjnq5iNCbQqIlS9QbB433ouH5tOA7TkTQdDbEFF2onwT03w+dDVKpqYlXAYsjkAlu24FqG9u8W2m/ji52q2XoCsC7P0mJnrd4X2+m0804ZUaRI4i00A1dKfrhhot0+UrTGybC5hadXNGkw3lsnY+J4qhOsx1VU9d+r8Af0bWj+dhYR4bAOmdMx10qKHBAwQvk4+W6AJoSX+C70u77ht/67qLEvNvHOPmUOeoBqBcE5VLzTBGdmzz1VGfWG2qGRnN/GvV+Y6Y1MZVOckf8FhnIjAqvZ4kergN2LMqWMYT8BHJ+v4nO7Mn7kr8NfIQTievnADSd3XS40nAcC1SR2p66f8zMpht6zS+9X/HsRqIDgnZyKGMwuuUqysh5e528JWd0ADfYtebX3GFXjJQBJqqer1UvxM/NXGy85Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNMmTcqsZiE+RzT5EljF4DH4RXU8mLZ/Qze+mE060v4VP07+GWs85nRIVXzC?=
 =?us-ascii?Q?7wcTC60U8OXq/OF8q/JqsO46qv+BJHdlHKYD/FVpAKbT3CmYlrs7PcYhBwTg?=
 =?us-ascii?Q?ts0m/2UgwO2hEz76SitI+t6ZXzU60OlRngZrA/Omc312tVJEBcqeA9KGdAn9?=
 =?us-ascii?Q?J+Y4kq6uFbeVR8VrMirxmBKTORtoWKb3Xa/i+rYQs3FYjqF6SzlVId2ixGU1?=
 =?us-ascii?Q?keJ+VhUZeP1Y9TnYAyRavALBuW9fazATUx5m1bImEFqvVeVi/34k0ZEAEaGk?=
 =?us-ascii?Q?4SWnBYV4OzTsGdLr+khY1wPe5HQs7XV/2zDW2QXb3VPiY8jpGjJPMOagxVph?=
 =?us-ascii?Q?fY71SCjQvuKxa3RfLTOOqa4JvIia2sSrQYENTOraadNp9LnjXIP5hp7biRZe?=
 =?us-ascii?Q?OVICIXhnRvMSCIoUY3hQ0AOWyUZsqBgYN8WMi8ty/+drGjDwQPkYLJFQlP1t?=
 =?us-ascii?Q?jWBi6qq1SRwv4S4etD6du1K3yEG/Kfq6gE05MbaE5sR/Ah1IDADnCUoH6gdt?=
 =?us-ascii?Q?haxe1hSApPGdWTCalUVIELWEIg0bPjGBFLGkIRVRmNv3/KIMLf+CWJ7ijaRX?=
 =?us-ascii?Q?jFoncU75hNXMHloeUtfrDMsn1r6hpFhH4wlzvVbNQTv0OXzXouQdvydjpZ0R?=
 =?us-ascii?Q?sQaWmciQRRQFudDNEt+dzyA3IuiWdbG6ZGcPV82XAcLEIPJTEkFGd3gJdSej?=
 =?us-ascii?Q?+Ku/JzlDSK6XfLIafrOdWJQGU3jZTzBaAHiz/k2vspqqaoyK66JmgjTh2cwr?=
 =?us-ascii?Q?GS48RB2yU9mAs3Uv9waSB+AJXEN4IkZ0RlsJXKp90p/9i7mwvdbkdNLDhiS3?=
 =?us-ascii?Q?ZYN3hPLFXj2FESo+YNe6CD4wwoBWBIGTQg0Ghp3cz1mQF7sSTFLTVQ+zg4lF?=
 =?us-ascii?Q?Qr33Y3cuIVnJVHAp0Qoyei/CkqWDTatRaXLtFNF/hQ9Oa0C04J0qASIkpm2U?=
 =?us-ascii?Q?S9JHQcVUDCj5OFt9jduG2npGkDjrVXzpLy3bLeJO5T8Z+LCfax7lodWOgKrw?=
 =?us-ascii?Q?zkZsWrh/CoyF2bHpNkOBTDhyX5o0duqUIXuIkiyXnrKizhlRPibYBrJS4OKY?=
 =?us-ascii?Q?ez8qVoI2kzBwONufa5G9e3QRXxgH2BljvAzIG8zsUssuLxdBx63531q8iIUh?=
 =?us-ascii?Q?6czwjP8brXIjc5g9oEGEKZbPtrXEhl/HjZx17/u8FUv1TYgI6vP38wP4p74v?=
 =?us-ascii?Q?eWpQB1dbz4Jm3elQOSuVTT/IylmtybpT5/lr3zOqLBJX4exZ6W7Dpv0vH6g1?=
 =?us-ascii?Q?yJTWOv0Wnu0fdPgU0DrE3WoSk4FauhAoVGoD3zccwygOiB8btKFFBNLaKCOb?=
 =?us-ascii?Q?LcJtlh+rRoyO1XtA9M9U3XFEBjZTeUC9f19ERjUhXjNm9cIHGIOkcIvPTVOb?=
 =?us-ascii?Q?xEUSnTTgkjcPhbD+lIBYubkP1T9wthpOXqhdItjUVV6BGCpTzNjiQAwTo45+?=
 =?us-ascii?Q?xyN0AR/pUYw+10QT2XFOgBC7ivLPNCkL2OdI4rorWokBqRD+jETBqo4Qx95r?=
 =?us-ascii?Q?lmqpfKx5DM+Ox80EtX0LNyoHWRW2AgYU2axg5PyfIqJ2Ss07bpOBDFwkBnRV?=
 =?us-ascii?Q?wGfyaOTQSCnKHeDNRWDJKJ3nAJCOTfziz8HicL7Em3bKhWWsRxQzSVEDNPuT?=
 =?us-ascii?Q?zxdwybVRo13J57rMrJxfoAaALElHX9gOvNAgNxuPvuQKIPm37OKAKdaH27q2?=
 =?us-ascii?Q?zcguqg8cJg5QZ7B4JAb5khlUejSf1dtfXIbznc//+VgyetfLNu50TgqVtPB2?=
 =?us-ascii?Q?efDSa0NK1aHO+vt2H0TgNEOYa9HYAoPfDmrYielOsgM22ETPYbcA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90976349-1929-4c5e-36d4-08df45334450
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:17:40.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a/qiU57XXnVWreaFuupdyiJonrPzkBKWSn9ahqfFDTe/kWh7WgjEhqeBB0Psb0zQUKkmemtqNpaUfVGsRs0HI4BJblNoA6lSj/gtQR4obUzgK8H3wNAwcVysAnPy007
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:41:24PM +0100, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
