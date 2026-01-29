Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B744D6B067
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E552A83FDB;
	Thu, 29 Jan 2026 16:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WoB235s8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WoB235s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF13283FD4; Thu, 29 Jan 2026 16:24:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9084B83FDC
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WHhmuFGE2vRjNl1P0Sw7HIPERB7OJKdOH+tKLARhMDl+8MmS+BNzoaxWZ8dReLPj2utYushaY/9iT733NRHsl5rAxJ8s9JOxitOxmDM6lzRNIM9PG5mnar8pUhzV5jcZ6YbRt+HbUTXb5pAACD9kQMM8rfL4Z/RxjpXGet8YwI/Cdiq0wwxau6Z6Ry2RWcOEPGzOE3g4DE2LhDvtwxW7Igi5ywLKj+buRXHpuCGtQ/+hE3bgS8E9HlPTI2qBadt4jWBEGiFgcQaEfH3xdcPmljEyjozz04UvNFSoQcWIzDR9/as8EGu71MpL/huDZtQnIbYUGtEa7m7mq92JULFFLw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmkr4sl6pRR3zUbuej3PxXGQJB2qq8VtAr5WzcTaW5M=;
 b=eq3LQmiWowaPSc4m0I5EMGGHYXNb+WogqU0EdiTYtC6XtCJnYx2w2f35Iu5/3h8mRpl6UmVOLcQIuawrf5n52jjdf/bKcN5ZmyV3o7u7Lw5qnzgTXJS6yRy/khcsDzmJHVQEH88drhaADDH7U1VKfZvSmHdFjmNPb6TlquPrul7Bqb2UxPBnytUociklRPuUFYczJ+joxmUDUCvFklIyZy5of7hEdm0uPqOflgWTGjZOB1I8Vyy+ZPzhMfx7lSgiBt/2toIJg6Thf/fEjxBxshfaoWipA4L/By9i0OSh6ACsZEg18VAUDByCtrM7TkKOkfpI2Mo0vy9SsuRWv3rgJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmkr4sl6pRR3zUbuej3PxXGQJB2qq8VtAr5WzcTaW5M=;
 b=WoB235s8U4DqjmRCVdfdq5cWd9r8HHtk4+I1mNls3PCZc0JGNCVmTjkfC6LIymJHVlHnnDjR+3TC7OI8kNcdKrb0ZX4rwAT556Se2VDVDPlMcxcklttJ6St7MLzHNgndBTgTDefd0wc9IRyPOpZUziKgzL+3lUWGjdug9htsi4Q=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by DB9PR08MB8388.eurprd08.prod.outlook.com
 (2603:10a6:10:3d7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 15:24:38 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::82) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 15:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Thu, 29 Jan 2026 15:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoPpROSxsYFPpXwtFVxsJQZsgr/LsFeXV7tUDdF8xg1pF53zgyyWwYPS/ov5b5lzkNhNfoONwGp+zH1om1UdMRamrBtnlpWJj4vF/uZx4jluT2GJ8s3X+KeMILZ0qG06oKACViog2nOocFMrL8fTDc84JE4K6RjKe9svt81hTk+xY6pObeajBB85DJdMy4MewO1IOJpC3Cdqx5R6gtWqtUnPSVOAwPnRCTzYgDT6boVV5sDt98egFL7X5V0Tgm65S3B5hD5cmlQLzCoMqtF1CjYmUFklAX4dIRTEw/wDdnI8YLqH4tPq26E3s4mWc8QnsgDmJtZRAVcT+Zr6nRNmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmkr4sl6pRR3zUbuej3PxXGQJB2qq8VtAr5WzcTaW5M=;
 b=GihBqeVuoYPiSloEuRE6BcEc2dCvnHxqOH/zJrFPIuWO/pnPK4m9fgOfLdntkURHd0hFfA3oGcemBiYM2t+4nARnbeyBZJIyTIlknsqG67BxLwI/FZTxhI2WUoR7xYkV/lebDgR9VSv+emNaQA8q0wQthDybzey8JhOXGJRVnOugulSMIscjPQPFTmm7eBOhlMN9/BfEkrBTnmhrcAHjY66sGGA6ZFtxQTPOInQXpUNEmNVsGjOKU/cTzGY7nso1++nx/VpeKcPsS6/nGF3BX8xUXuUTUH5xddNYQK8GCO3u2jy28XBED4EMjwYP8UBe23pesMTI1Sxj8aziqmjtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmkr4sl6pRR3zUbuej3PxXGQJB2qq8VtAr5WzcTaW5M=;
 b=WoB235s8U4DqjmRCVdfdq5cWd9r8HHtk4+I1mNls3PCZc0JGNCVmTjkfC6LIymJHVlHnnDjR+3TC7OI8kNcdKrb0ZX4rwAT556Se2VDVDPlMcxcklttJ6St7MLzHNgndBTgTDefd0wc9IRyPOpZUziKgzL+3lUWGjdug9htsi4Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB4PR08MB8102.eurprd08.prod.outlook.com
 (2603:10a6:10:386::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 15:23:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 15:23:34 +0000
Message-ID: <61dbba55-c093-4afa-95cd-b9c65589041c@arm.com>
Date: Thu, 29 Jan 2026 16:23:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: tftp: add support of tsize option to client
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <20260128234351.405945-1-marek.vasut+renesas@mailbox.org>
 <51b1c31a-427e-400d-9692-14e4b90c0a2c@arm.com>
 <674aaf9d-bda1-4480-afd9-2f68e25e4ee4@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <674aaf9d-bda1-4480-afd9-2f68e25e4ee4@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB4PR08MB8102:EE_|DU2PEPF00028CFC:EE_|DB9PR08MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6ed845-e39b-4b6e-ad23-08de5f4a8457
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?V2VGelg0aW1wV0YrM1JLbDdIVHpPYWJSUW5RL1dFZlZCZGJWNTRndXNVanZE?=
 =?utf-8?B?bklJRkMvTDdTcDdab2NZZnluTVB5RmVST1NhV1JzRWpYZWhnbElMUzA1djcx?=
 =?utf-8?B?eXoxNDR5cHlzNklJN3VQblQ2Y2dWMVd3eSs4TDlHZ0VySEZmclJCRUQrUWlj?=
 =?utf-8?B?bkwyMFNjck9SUkdtSjJzbUZPYWN4SVFrTXJFeUEyZXhIemN2UXdIYlhtNXJo?=
 =?utf-8?B?bEdNQktwTk5uZ25zeStnT2lQRXdzU3IzOFk3R3FaOUVjbS96czJOUkZiS3gv?=
 =?utf-8?B?K3lucnB5bURveGxjNjBwVjhnR1YzdEwrVHp2M3BkVnQ2NEVQL2xSTk1jTlJ1?=
 =?utf-8?B?WVc0NFRLS3FBenZzNm9DWmRpcDZVN3BQQjlRREo4RFBJNk02U0xCSEFTTkxZ?=
 =?utf-8?B?NGFTNWRSR1JTR1Uya0hKT0tDODZiSERIeDdiczg5Wk53UU9DVXRCZTJvWW91?=
 =?utf-8?B?RUlHUERlc3ZFSzBpcmdFVUorakNKYlhCUVV1ZEl4MHBOZWV6c2d5YkhqVDgw?=
 =?utf-8?B?SVRWcjgyVStnUUZZbHlZdGlIT1RheFM0azN3WENvMmdZTEFEaXJQWmJxK0pL?=
 =?utf-8?B?SmY0T2ZuZ29iNnFLZ0dLSVE0RUNvMmtCSnQ1UUpCM01DZWY5WmhEYWtkR3Iv?=
 =?utf-8?B?UlJkck9nVkZZS2lkZjkwN2dOUVQwSWRKMVpsMFE4Yjc2SzdYbGxhNDhOTk10?=
 =?utf-8?B?bFh1cTJWeDd2ZHdudE92Lzk4NzhqRzFScDJDK3FITVNGakp3MWNCbU0rV3da?=
 =?utf-8?B?RHFMc3VmNXlBQkZKNjIwOXdMK1hnWWpQckMwYWNuK2xYelJTczVZckRSUkpt?=
 =?utf-8?B?M0dxWTh2VW5JcFd0M2MxbFNEWTZDemJhNjdlN0xiZG9uaGxGcytHZjFSUFlN?=
 =?utf-8?B?MHdTZ2l6U0RjaWZQcGgwMnkxL3Q3Mk9RaXQxZFp0aGtIc0orS3J0OEpXR2Uz?=
 =?utf-8?B?eGhveUJnQVhMemd3Yi9iai9FcWtSZm5TRDd3SFdYNFJxVnV5NVRqMENEVlcy?=
 =?utf-8?B?TW80bDA1Vm1lTXlpeU1qTkhJUVZQNDJJYlhEQ2tJdENhck1YMUJEbVd0TUpM?=
 =?utf-8?B?bGNNZjZiQmx0aXZZZXRPRFZvNDR1TjVFVWxsVngxeGExdys5ZHgzaXR0cVRk?=
 =?utf-8?B?TkMxcjFOUDl4S3NCdExzeEZ3dzdiNGV1TXlVemVsbmExL3QwRk40RHRRWDZQ?=
 =?utf-8?B?dENDZXQrc3BYUVpxL3ZvaUhqUFJZbzFKaWZCNFVDdzN1QVRxNFFXOU5pdDBl?=
 =?utf-8?B?OGRBWVdlVGhMc20wU1dxZzlaSCtNSmpPT0VNVFZlV0phU1ZKOEEyeGJmUnVL?=
 =?utf-8?B?RWMvSVY5Yml3V3BYWUJENUdYbmpIYW95VzgwelgwWmpCaFdIT2U4T1pmWTg3?=
 =?utf-8?B?dFFzRTZFOU94eVBJdHY3KzZWaFB3TlBnbHpONEMwMHgwYllzOVFHRkFpTTBS?=
 =?utf-8?B?TnFuTEVMVEVuVjUwSlNCbHpyelVJWHQrb0FVUUJnSHFoMjJNVGViTmIzUVVX?=
 =?utf-8?B?U3dIOFlPTlpYNU5OcTZCeDdkTkJKeWVFTDMzT3hPdVhCbGJLa3M5QXJ6QUp6?=
 =?utf-8?B?a1BzWTlIeEdZM2tBYTY3WkhWQ2ZTLzBJUzdaeDgvZWFaaUlPZnZUaDE4d2JR?=
 =?utf-8?B?eTdiMllZS3loZm5rd05EWCtEN0RjMThnYmQxSjVpVkwzSXEveDNjSlZUMjF5?=
 =?utf-8?B?UTBRRUUzSGRld3VtMlFYbS83c2xFUEhUSDFOVCs0akREUFl4R3NNZElVTXkv?=
 =?utf-8?B?VlNRWGhkeTlpenRKUmcwcnVCZU5YL0xaTVRBZGlUVlVadUhOdHFxdDV3dm9Z?=
 =?utf-8?B?Y2RmLzk2QVlodHVZMEsyUFE0WUhHY2wrc0lUTUU5dll3SnBWclN0T1h5TGll?=
 =?utf-8?B?VHFBdXBqeUkxc2ZiOXFkOHRaMWZ0NUNXbDc3WnV3SysyMVFyYjZhS3pZSnky?=
 =?utf-8?B?VVJjOEZiUHpnaUkxeEMxQ2RlSC9xZlVWTVM0ZDZvQ0p4bjJvTjg0WVNSNEV5?=
 =?utf-8?B?aGN3WEJ0ZWJXUmQ3Q3IzcThBOGhlaDdlcXc5NjBOOG5VejlseDhVR0ZxTVN3?=
 =?utf-8?B?UGFXRXAzbk1GRW1XS09FTDFrMU5HVjl3SU0rRTNSSUVDQWo5aWJYRjJSeUYx?=
 =?utf-8?Q?m65U=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8102
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ee9bca5-3f90-462d-5329-08de5f4a5e53
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|7416014|36860700013|1800799024|14060799003|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2VVRFBLVDExc1FLL3BtNmxqSWkwelU5V2x1RTdLWW5QKzJ2OGVNQlhGTkpH?=
 =?utf-8?B?RS9XUXRSUnFlcjdPZ1lCOXdBSGtoZ2tQM3NmWW93eFlaelp1SkY4WTlSeHhQ?=
 =?utf-8?B?VlpwYUZxY1pyL0lScUlMWjNRWklSRGEyYUwzaVFhQzhZTnhJRDRLdXZOYWw0?=
 =?utf-8?B?TG16WmxCWUpsWnBMdmRwTGptSGlBUmlsY1RyQkRuMTdZT2k1OHY2V3BWWUJz?=
 =?utf-8?B?bWY3aUZiMXo2RE13S2NFRnU4dFUzckxvRmNKNzJ6MU9ZK290d3JZaExIQXdt?=
 =?utf-8?B?RHRFN3hTZFpzNWt0VUcxOHVnekNtcVRGMlhMWUEzRUR2bGVXcG1NK0wzSW9v?=
 =?utf-8?B?L2J1bU9qNkR4SVY2ZCtoOG5yUmh4SDI1Z1J1RlFLZmJidS81R1NSY2FhUTV4?=
 =?utf-8?B?d3BSN2k3TXdPYnZJeDRvT3NwcWZYRm9wd2JJdmNEbVhGN3JKOHp3TUVoWVc2?=
 =?utf-8?B?VzE2MUJEUWRQT1Q5THNjOGlUTS9sOEY5L1UycmJKczlOVUJPME9Jc0UvRHp5?=
 =?utf-8?B?SXB5MytaeFJqc2ppQzB3aEZGSzJKZHJwYnVLR1JyQ1lsNGVyYU40Sk13UWli?=
 =?utf-8?B?UGozYk1zeG5vWEEyeTBQamRrNE1JNENiRnlZYUpPdEM1NHVvOGhtcFBmN3B6?=
 =?utf-8?B?Sk1ycUpIbVJ0MWdIZ1o1N2JreVlwUzcraytUNFNCS0plcmljYTNabUd2T3di?=
 =?utf-8?B?WnlrS2pYbXBuMVVKdFpIQ2F5VytpRXBNbjBEMzRaVVZmdHM4VGh2VjFtMlk0?=
 =?utf-8?B?NG5OWWtDS3BMem81TE1mdHdOUlVRT3RiQ1B1WlN6MmE1eHZma0IzTVBTZ1dm?=
 =?utf-8?B?d2kwblBOM0srMU1qejB4d1o3d3c0VTdBWHVmMUlPMjZkTlJCcWZQcnhlVExQ?=
 =?utf-8?B?Q012UFpOU0Ezcm9LWmZlSnlWckhQUXZxMzF4MExrMXZZVGNBYWZQUDA2U3RT?=
 =?utf-8?B?Z3pLVmM3MlI3SkhIUnlkb1lKdkQ2TjQycWZ1K2V2RDZrc3NYTlgwL1pkRktj?=
 =?utf-8?B?Z2V2dEFOQUpyOEtmTjVTYi9QQnRCZi83UkxXTTNHVGJaMm9HN24yaEd6dThJ?=
 =?utf-8?B?V0pYV1Z4UUZabWN0aTQvaVg1cklNWnBVWHlQUVRZQ1JIejI3c0hQK3l4UlZh?=
 =?utf-8?B?K2xtanlKVXlPeVp5bjZxZ1AvRFZmODFXZWo4T255YjVzeGpoekZ3MmdaR2hy?=
 =?utf-8?B?Wmdqa09Nb1o0K0JvcVljcGpvUmRTcWo0UjlPWXlveW94dUMzZzJMblhRYjFo?=
 =?utf-8?B?WTdldWF5VGVMazNrSVdZZTFRbEM5Q2tyMnZ3cWZNckt6ZkRSUUd6ZWphTkNj?=
 =?utf-8?B?eEd2dlpuVjlTODJGR2ZTaW5SNUtWUnZ3T3Z4OXp5Wjd5KzQwN0M4V2hGTDJZ?=
 =?utf-8?B?TTVHU1ZSenlBN3AxSWF0T0UwM0h0RzBOMjZQOG1zV25SVmxxNDhIVHVZaUdV?=
 =?utf-8?B?aHRIQTVIR0lSd2ZobEFxOXZjTkdGeFZrRUo4b3BGSkY5M2xWS3gzRFVtWGp4?=
 =?utf-8?B?YitBaUp3d3ppM1puZWMyNlVCcHBTWktBMnlUQTQvMDNsbXRpYk1SbVFNOXk1?=
 =?utf-8?B?OEF6WWFpV3BkckJpUkQ2K3Nac3BUV1NidzN1UUMyd1RIRHUzdmx5NWRVY0Z4?=
 =?utf-8?B?bEZvQU1KS3Fic3UyL0Z6d1RmcTlxWW90Q1I4bDRQSlBzV0Y0bTZrYndXWkJm?=
 =?utf-8?B?UFBORTJDUDR2SFNKT2xhVys0S0NzL09RbVJRMjhWbjV1MktUWVcxSTR5VGxQ?=
 =?utf-8?B?ck9maEJGMk10UGhTTFpGcE5XejA0c0sxd1M2SUpkS1hGekxqcTIvbWJNWFY2?=
 =?utf-8?B?YnVhanpySEJBUmVnRFJGSmZNeEppN3hUNktPdytNWTZkYU95R2F1cVYxcGRs?=
 =?utf-8?B?ZWhSajdPSFRCbFViVnZrQkpYZ1hMYXZzSUJra21mMnZDQWJ5ZUkyTVd1S1Ev?=
 =?utf-8?B?NS8vT2RuY1FXWU91T3dTN2h5djFvbWJxUzJPekkwaWR0V3BVa2IvSjhReThK?=
 =?utf-8?B?MVE0MSsvZGEzLzlTODFSNnVLSWYxbHZ1cXdMbDZqZXBma3EyS01rRkw1eFNP?=
 =?utf-8?B?RnRmRWx5NHhjdjk1TXRjOWFGVUhYNml1N1BhNjRaNkt2V25tRHdZUWgzSy9O?=
 =?utf-8?B?eThKSThDRWVHMnFBK0FudmxEVE03Qm5WSnFKOEJDZjVtb3Y0RllYcitYRkl4?=
 =?utf-8?B?SGJzSlZqV1RxWlhHU2wvb3hyRjJDSUxVbGZ3NXR3VGFiV3VxWDRVK1pqYUJV?=
 =?utf-8?B?N2ppRSszMU8vdTVXbFlEcVhjSWV3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(7416014)(36860700013)(1800799024)(14060799003)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e1/toeoT4SFyMqTAouLizkKCHrj9YmWj47bOQudRvM+ifV3qkRvrnAnyxZd9dUJYn4VKKNPaABTjmGZaXv7FDonZQtpHFGffXuwK3QE8JdnbdHRsUXRpcbGB00ohkMf9Cv9jYyF6dzPiJaXAK60giWuz/IE8hZMGwJzT+UGR7IpXN3zuNfE8AsgkjnR4gGLLnk4msDohCV9/qJAIeMiN7H3Pn4WqXT4/872rzo+6s6ssFToS7rpGtjD5s2/Tt9EMM+MEM4je0zEWin8nc/DOXUbKF8hInRvY+pThHRg5cE8ZU8Zi8mGqSJkpHsDtuaVi6Mc7lzMJLkv7T9XMpMudfNo9YlsxPW5MWdwiBl5JUheADE0VoLMBO4XJvQMacBld1Lbu2TlVGdmKdaFJO66j/g+eWBUy3/FKg2gq6roFWfToMokVkQ/ztU79+6Wmv5/Q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 15:24:38.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6ed845-e39b-4b6e-ad23-08de5f4a8457
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8388
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



On 29/01/2026 15:54, Marek Vasut wrote:
> On 1/29/26 11:04 AM, Jerome Forissier wrote:
> 
> Hello Jerome,
> 
>> On 29/01/2026 00:43, Marek Vasut wrote:
>>> The TFTP server can report the size of the entire file that is about to
>>> be received in the Transfer Size Option, this is described in RFC 2349.
>>> This functionality is optional and the server may not report tsize in
>>> case it is not supported.
>>>
>>> Always send tsize request to the server to query the transfer size,
>>> and in case the server does respond, cache that information locally
>>> in tftp_state.tsize, otherwise cache size 0. Introduce new function
>>> tftp_client_get_tsize() which returns the cached tftp_state.tsize so
>>> clients can determine the transfer size and use it.
>>>
>>> Update net/lwip/tftp.c to make use of tftp_client_get_tsize() and
>>> avoid excessive printing of '#' during TFTP transfers in case the
>>> transfer size is reported by the server.
>>>
>>> Submitted upstream: https://savannah.nongnu.org/patch/index.php?item_id=10557
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> Nice feature! One minor comment below.
>>
>> Acked-by: Jerome Forissier <jerome.forissier@arm.com>
> 
> Good to have you back

Thanks :)

> 
> [...]
> 
>>> -    if (ctx->block_count % 10 == 0) {
>>> -        putc('#');
>>> -        if (ctx->block_count % (65 * 10) == 0)
>>> -            puts("\n\t ");
>>> +
>>> +    tftp_tsize = tftp_client_get_tsize();
>>> +    if (tftp_tsize) {
>>> +        pos = clamp(ctx->size, 0UL, tftp_tsize);
>>> +
>>> +        while (ctx->hash_count < pos * 50 / tftp_tsize) {
>>> +            putc('#');
>>> +            ctx->hash_count++;
>>> +        }
>>
>> Nit: with this format being the same as the non-tsize one, the user has no
>> way to know how many hashes to expect. How about printing percentages instead?
>>
>>   0%....10%....20%.... etc.
>>
>> (functional tests may need adjusting though)
> Do we already have such a pretty printing function ?

As I said for wget, I don't think so.

-- 
Jerome
