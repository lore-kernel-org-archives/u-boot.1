Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962FCED62A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72EF8911E;
	Wed,  9 Oct 2024 10:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="go4iHqNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7368915B; Wed,  9 Oct 2024 10:18:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFF289137
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDNQWQC/KKP0/QOlp+WVacpqWqZ8KbkwpgDfAgttYi7vmLf1C8/Ds0aHht5bkMW4c5XxbdNpQsIC1uJi79CDYluka25hjVPeEV8O55UyPKjI6U6u1R4wXyYYlOApqhTI93UATbDarlVXz3o2lttA34H2ax3w8qzwhav1Vj30NIf3gJxBEPu+K/p0mOdOxRoYiQW5RjsaDkCDx5AYKxr5x6q8sa7dk6ub/GOdl5B9DrLy/oDsfSQ/EgmsKIMHKq2+0nSXJQsXAsFsIme5sWt1qtKTRmmTFRWgaxWllHE/e3c5OLnvO0cZDbBIrvTuemrd6PUyL2QGUuM16ufTwfXz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Wc56kZnqX9xGekEr4tpiTCkbYNGmPTK7nbMxa8GeGg=;
 b=yHYoB8hx8ayiYU+57YZ9vwhpOTbaX6tnpKrNpt8+RcucFehOoNGd6QL4uC+3JvLvPXdYoUNJFqGMztkH5Emtnx4HhV7LrjBW5z0ljhWYAPL3Kn5tTwId8jOGSJMvpiFGnNl5Onyre6yqSv+R0uk+PQVEMBabgELKyQcuLAp17FwKiltZsVJ6dNHcKbrzhi9Y1mhVN3CRxGtIYsUkSlMoJ93iQo1bI0xKSaMmmYlVZaKe0o5AJ8A92O863+1sjaDIVRd0R9QhoFcT+SadoC0XCQYeJnvrJubt4M/EdHOG02DJdtuWcHTrPEVru43+TuvoAdnI0bBXddJJXQ2XQw9UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wc56kZnqX9xGekEr4tpiTCkbYNGmPTK7nbMxa8GeGg=;
 b=go4iHqNmqpUteTn7T6HWoQVyGR93UWpOMIIQbeYo6zuwxqzHJkH0iKshSLcpnDETmhy4s68QbfHlg3RibMfj3Wqij6izLNfh/lufcq5dWcbjIRsJp7BokRf4OCm3PEtuGr18hhzXVyepfNHjuL18shDwr8R0i5kVv7vfE0K/JSlqq3Jc436Y//BGVcWnbggB3GnF8AE6AMGgoJAyBnzGDdTkmC895mWcCEoDHud9UjE28FrwFiK9J4ds3YaTg3PwJC5/Ir7d4w1F8U8RZsuXEHfWhrkWQhUdAkNaqGmYT6obWZr6sJ24k3I5vKBTtKZtK2lVbPnrucPKF615fI7sVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB7799.eurprd08.prod.outlook.com (2603:10a6:150:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:18:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:18:43 +0000
Message-ID: <3d2ace19-e688-4bff-8c02-6d8259b8c7d1@iopsys.eu>
Date: Wed, 9 Oct 2024 11:18:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc
 engines
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiJMO+0+tMVPCM8Ho95TzvfqCgYvSLBJzmNbPJXJk-rYQ@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAFLszTiJMO+0+tMVPCM8Ho95TzvfqCgYvSLBJzmNbPJXJk-rYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002E3C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::45) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f8108556-85f9-44be-e0e2-08dce83afd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFVoUUVXNU9hVEFBVERpa3o5Qi90ZTFTaDdQQUxpaDRyQ1lGOUtRVktSNzZO?=
 =?utf-8?B?Z04rNlQyRks1bVpFejdrUnhRSkh1Ykg2SU5QckNCSUhOOWJUb1RvQVF1dlB6?=
 =?utf-8?B?ZTJZemoxN01ROVhRQVJZOWVSMU5VeGFsL0NoZFdKNTVaMFEvQy80Ulp0azh5?=
 =?utf-8?B?OFpmaHBEVkZPK1EybjlxZTZSc1ROSXEvUU9ubHdvWURGZEpMT0s3Unc1eHA5?=
 =?utf-8?B?WWs0NjFDeXd2SWxpUWlLbG9kb0x3RTlYWE56Z1J3UitHLzlkNlBLMWd4ckRQ?=
 =?utf-8?B?KzJSS1JZNThtYU4xcXc0TE9pb0VJRlRQOVZNcDVWakNVZU1xdFRqSDRwdGd4?=
 =?utf-8?B?c2MxVVloR2xha3FkQlJtaVRZbzN6VXdFbVVNemxtOW43bGt2YUtLTzdmYklX?=
 =?utf-8?B?NGRzaGhsOEQ2M2tCeWVmUllNc1ZyQ2srZm0yK2M2ZjJWdGk1VzltRU1kU3VP?=
 =?utf-8?B?TDJaZGc1eHRycDZ4cVVYNTFWY3p3U1lPb3JhbHZCN3J3aUhHNlVaaFZGTlBN?=
 =?utf-8?B?NnE5WDNJN2tZSUo4Yy9PaG1McEJZcWpKT3hVZjY5bk1HZ2ZZNlZwdTJRWnM4?=
 =?utf-8?B?dkNEdlZ0bUUwSUs1TTNWQlFaSmJxMW51MWMrZU56ZUpMeVZpQmFjdjJPTG9l?=
 =?utf-8?B?VDFUSDJmNDJObDFSWVN5b1Y0cmVnbDdaOFRYdTI4T0pVSHBxT2RFY0pmWkZT?=
 =?utf-8?B?VXZZUUNWWWo0c1ZBYnlLbWhJLzFHTEU5SUZCVjhGbjZmRzU5WmpESm9FNWRk?=
 =?utf-8?B?WXJ6Yi9xZHRocWZKZkw4clMyS3BNVVU2SE5ySWpBdnNLWDV1eVZtSDRQa2FQ?=
 =?utf-8?B?ZTJoSEllOUM4UFVzS3lDa3hnV0t1L2FTVFlyTitDMDJvOVdqQVd3OTIvWXIr?=
 =?utf-8?B?Tld2OVV4bGN5NWRYVmJWQkt4OFU3SHZIdlV1RFYyRXJhUU5xMENMVDNVQko5?=
 =?utf-8?B?TllPbHJEN2wySWNjMCttRHhEZDBhbjE4ckZWSTY1dllLUTVYbm1xd1lkK2NZ?=
 =?utf-8?B?TjZUQmtTQXlERlJ1eWdablZXempnOGx0RmJoWjRueldtK0VpYmJ3VFR2cEQz?=
 =?utf-8?B?bHpNSmVCemIxSWs0VlJYenRBbEp3c2dScldqVTZrQ0FEVlVQeXNBQ0F1TDZa?=
 =?utf-8?B?N2g3VkVKK1YxaTcwdWU5STdPS1JDMmVYbEFMNTlMeUVCZzNiMXBRU1lnUlpB?=
 =?utf-8?B?dTNaN2NMNjVENEJVdjU5U28yOTZRMVBiMFJzYTFQMFJSLy9RVWJ1OVNpWnNJ?=
 =?utf-8?B?bUJtRWFXY0tlOUJtV2dLOGw5NXZNTGswKzZWLzN4cEM3Tno5bWVsUWZQaVpo?=
 =?utf-8?B?b1pEK05POUJFaVh0cko3MFpmM1BNbWFQcHlla2NnRURxVjRGbDNSQjVHcFhw?=
 =?utf-8?B?STdua0JOa1I2d2lKN0t3TWJmQ2RIeFVaemh4U0h3RU9YM21KQTZCVXVxUjNE?=
 =?utf-8?B?ZmJHZ1AzR1BXejFQWStFa0ZqNVFKUkViUlpVQXlGaS9COGR6MmRGNVQ2V21Q?=
 =?utf-8?B?cVJkRHQ3bnkxc2hRaW1wbkdFeXlhbS9pSURIbWMyU3BCWUk3ejZ4TmFIQ0VG?=
 =?utf-8?B?d1NXWmZ6NXlHcTBmUlpmUGMzbHNDZzFrQjFFMSt4SDh0cWVyYkZUbWxXcmQ4?=
 =?utf-8?B?NWNuUllacHBnRkhKMy9iaDRPTkYra3ZySFZUbllTdjdPWlZFSWdUTndoQ0tR?=
 =?utf-8?B?NVNYdmNQUE1sRWQzMEtMbzAxODZqZHhXNFBudVJ5bUJQcmo4NjA4Z0ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnY4QXM0WThYc2c2ZWhUTFFhVGJMWWdwVzl1MGZ0czNSOTFvNVRjMExibHQy?=
 =?utf-8?B?bWtpNWQ3aVRUU2RSYVpYdjlBeFRTRzhCbG5oUTBnckJjVnEwZDdvVUtja282?=
 =?utf-8?B?V21kOGVtU3MybnV0dEtVd3FzVG1qcjVENlpoLzFWR1Jpb0wxSlhldXp5OTNa?=
 =?utf-8?B?VGg1Qm5CMDlSWHo1TmhkWHBpWXZHdE1SYmlqaDFxR1lRMSttV3VtbENQZ2dS?=
 =?utf-8?B?aWJwL0F6NmEzWms1L1lEcmswdzJMOElFNURwTHJ4cUZVV3FlWmwvbWlRRVd2?=
 =?utf-8?B?WFh3N28zMnNUTkdSdmFLOGYrbWxqTFd3MGViV1djMENEOGtrb2k0bEl3c1ZZ?=
 =?utf-8?B?RUlzWEkxc3NJVzhhYk52U1BqL2VBaHJTVHpMZzBGU2ZFQWhMT2trSGxPWTM0?=
 =?utf-8?B?SWlEakhEUzdRbmhjUUlDcnNsVXhxMk0wR2VYSzM2YmJNRVBKVDkwdjVweXQr?=
 =?utf-8?B?YzByYTlqY0p2Y0QxVXI3eUtTVnFScUE3M2EvaHd6UnQvVW5qdzNWY0J0Z01N?=
 =?utf-8?B?SFZYOUZEV1RobXRZdDYwT0gydVByY0lhb1R5RVVNcmNpWHI2M2NHd2xtanpJ?=
 =?utf-8?B?TEVvd3RMUGpjNnE4Slh0U3grcGhKUER6UkJsNG5KSEpYUVhGMUxwQmtwRHpS?=
 =?utf-8?B?UzkrMUcwWlFmb281RTRnSTVoTXhYdGpZZXlFMDdUeWFYOHd1TEdaMUdOLzFo?=
 =?utf-8?B?dUNiS3FxV0pHa0FuRVIyK0FpRlpUcGs3UDB6VlB2b1NtTHBTQ085Mlc2aU5w?=
 =?utf-8?B?VS9TeFJ4MEEzdnpZeERUOU5xcGpyWnZXOWRpQWc0QURucWpzUVl1aTQwSEpk?=
 =?utf-8?B?cWtFa01CeDgzOTNSSEhUNFhqMEtHVXhqMDFWSkI1WjFML2JINGFUaDJ0RXBp?=
 =?utf-8?B?YzNCM1pmZlZKNE14MWsxRlQwRTlGUW5vajRwVU1NZ3Y5VGFzTlk2bzFCU3Zz?=
 =?utf-8?B?ekJJTnZUcXlNbC9ub0hocCs5QStHZEQzSE9Mb2syc0xqWXY4M2phNjJadmp0?=
 =?utf-8?B?V0YyUU54OEJpZU9rTGZLWFhqM0JtZjFzdGhTd1FEOGZqY3RUUkNSS2QxZU5G?=
 =?utf-8?B?eHZiR3ZTSTNVUlpFMHM0VVNLd0VCbnd4NURaWHpwQlNjZy8wL3FnTllMZkxX?=
 =?utf-8?B?eGxlOGhCV2h2VDl6Qmx2WFNnZGxyNDRObU9JVEdPTTJ2TVU5eUo3cldrMXcr?=
 =?utf-8?B?dVpKYzdMQUhyRmZTY09KZENOTzliQmh3N0swcFh6OW9OSUhrdXJ6M2E0UzNp?=
 =?utf-8?B?RW52SWdITm95czUwaUZLSHpBSDExTkNKRXFXZ2RhQS91MHJwcGJ4VW9HZndO?=
 =?utf-8?B?TEJrdFpnYmN5ZUs4Kzh5ZlpZY3kzdjV6RlMzc3lydGkwamxscVJPMS81RzZz?=
 =?utf-8?B?cGV3bWhqZm50Rmt2YXhOeXZ4RlV0aDlsWmxUeFhiRFFEOHRTdFFhT0ZTOFln?=
 =?utf-8?B?TU9XNzZMM0lTOEJwSXRkM2x3K0V3NVlFKzhoU1Exc3d6elI1b0dyNkFhWCtP?=
 =?utf-8?B?cnloS0lSOWJzTlpTUEZGbllQem42eWZMM01RclBQcEJETEhsVmFxUkJ0WjQz?=
 =?utf-8?B?ZDl2ejg3ZzdHdStrK1VIQjNNczFDczd2cmVldlNLZzV3SjRrYXhrd1VaSVdt?=
 =?utf-8?B?SHVVNGVTeXNxSGtPenJRT0VkaDNWUHVnbE9mRUV3MnptbTk2b29HVWlQTGdE?=
 =?utf-8?B?eWlPUjRCekNLNUhvd0xOVFRCYWtSWUdmcFhDS2c1aVIvOTArb3BwVHQ1U29Q?=
 =?utf-8?B?WUJMaGJRTEhWbFZBSExCRGNNamhCRXZOUHVrMkZLcnBjUy9WNVV4bk1jR09Q?=
 =?utf-8?B?RXRORTVDYllYWHRLbDBWMjIyaHduTWFqL1RvT3lxUTUvcUhrWXhnb1UzOGE4?=
 =?utf-8?B?eUdWMHhKVlJXUTZ3QWY4M2d1T3F0N1A4UFk5cUswSDBpRzBZWGxsUHY5ZXk2?=
 =?utf-8?B?Mjcwd2dTbnlUa0x4N2p5ZDJCMW51Rm1abWxwcUJMaGkrNWlxOG80VnMvVGVK?=
 =?utf-8?B?NW5HQXM2WksxY2F1YzJVM1lhLy9nV2hoWlRwSThabnJWRExLM3QybXd4T08x?=
 =?utf-8?B?TnBGL05HUzd3d2xzNndSTVgxaFREbzhMSmcvVXpCbmRqRkRvU2srNk5LNTZU?=
 =?utf-8?B?RmRVQVh1LzFkK3d6VE54TmJCRmFwRGVyQnM1VmNNdUFDL2E1TjRUUnNOUjBN?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8108556-85f9-44be-e0e2-08dce83afd28
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:18:43.5148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37IgYIMUB3YL8SWSU1SWTXukhcvycb+EFsiKvSUglKJYdvIxojQdSsG2mfLq+SCMVlVNXZlvjYK02AhRhhILY4byamL3cDu6FEOUlwwB/vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7799
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


On 09.10.2024 04:50, Simon Glass wrote:
> Hi Mikhail,
>
> On Tue, 1 Oct 2024 at 14:45, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> This patch series:
>>  * sync spinand driver code with linux-6.10
>>  * sync spinand flash support with linux-6.10
>>  * add initial support of ecc engines
>>
>> Up to now only software ecc is supported, but other engines can be add quite easily
> Is there a uclass for ECC?
no uclass. Is it needed?
I tried to make the code similar to linux as much as possible
>
>> Changes v2
>>  * update description of some patches
>>
>> Changes v3:
>>  * split some patches to a smaller one for more easy checking/verification
>>  * sync spinand flash support with linux-6.10
>>  * add some ecc engine comments (taken from linux driver)
>>  * slightly change patch order
>>
>> Changes v4:
>>  * avoid double increments of error counters
>>
>> Mikhail Kshevetskiy (10):
>>   mtd: spinand: Use the spi-mem dirmap API
>>   mtd: spinand: Add a NAND page I/O request type
>>   mtd: spinand: add missed add missed MODULE_DEVICE_TABLE()
>>   mtd: spinand: simulate behavior of linux's function spinand_wait()
>>   mtd: spinand: more use of spinand_to_{something} helpers
>>   mtd: spinand: replace enable_ecc variable with disable_ecc and update
>>     corresponding logic
>>   mtd: spinand: minor refactoring
>>   mtd: spinand: more refactoring
>>   mtd: spinand: sync supported flashes with linux-6.10
>>   mtd: nand: add initial ecc engine support
>>
>>  drivers/mtd/nand/Makefile             |   2 +-
>>  drivers/mtd/nand/core.c               | 130 +++++-
>>  drivers/mtd/nand/ecc.c                | 249 ++++++++++
>>  drivers/mtd/nand/spi/Makefile         |   4 +-
>>  drivers/mtd/nand/spi/alliancememory.c | 155 ++++++
>>  drivers/mtd/nand/spi/ato.c            |  84 ++++
>>  drivers/mtd/nand/spi/core.c           | 649 ++++++++++++++++----------
>>  drivers/mtd/nand/spi/esmt.c           |  16 +-
>>  drivers/mtd/nand/spi/foresee.c        |  97 ++++
>>  drivers/mtd/nand/spi/gigadevice.c     | 194 +++++++-
>>  drivers/mtd/nand/spi/macronix.c       |  32 +-
>>  drivers/mtd/nand/spi/micron.c         |   2 +-
>>  drivers/mtd/nand/spi/toshiba.c        |  43 +-
>>  drivers/mtd/nand/spi/winbond.c        |  67 ++-
>>  include/linux/mtd/nand.h              | 279 ++++++++++-
>>  include/linux/mtd/spinand.h           |  47 +-
>>  include/spi-mem.h                     |   2 +
>>  17 files changed, 1778 insertions(+), 274 deletions(-)
>>  create mode 100644 drivers/mtd/nand/ecc.c
>>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>>  create mode 100644 drivers/mtd/nand/spi/ato.c
>>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>>
>> --
>> 2.45.2
>>
> Regards,
> Simon
