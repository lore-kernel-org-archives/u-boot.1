Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7B1CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9078848D7;
	Tue, 16 Jun 2026 07:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="URb5jySQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC7C8484C; Tue, 16 Jun 2026 07:31:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BB584105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF6AspxbZYqUJU25SMQhDfmI9TGrZMhCKrPKGIKG8aPR39o1ekawer+dx4SZoK0WZQInWdCjPLg6ySMrR6gg2ek8fy+NadUS7tVBLypo6elSUPbsKexrOUSc8+fTMxJ4HDGdOxPeipdb8vC28fNkC6CmiiC9FWA6FSh8fKeJ7jZbyojiUQMjtHiqgfI59i1zQlgTPPOeEZGMP37jgZ6No2N4tne7dC5cuC5r+KQddfUa40bQBOW1PRyuMV+lgjaB0MYtGL/HytYioeSRRvJ3Hga5ZU1wobU77tlBFgBfRzoJhkrtcrOkE96VAWLsQFgCwQTP0WQpWfzArRtkehhtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=aHM4eJL0+xdM1FP3UpuHfWarxzsQcEFxPMYysj4DPtDriaweDwbbjVylRESbL05NWfyG6hPOrISTRDNGuTlLJxg73GXLSOolKsBuZWiRk4wnwCBjjz1M+auI+p1uX7ulgSI7x6dgfeyYSguZis16/U8m9HuAT1fuPdRFaoneg/xckOC37gzFjNvDFDULR/Pb+XyTodSZ98C+Zck5jiPMJUPk/95T5r4QtQ4lYqpzrnZHwR3f2PTbZMvy92mekDi4u3FFjUx+rojm5gUGMnrnPk7IFjQ6APjOBGh/3x1RQgyVoLePBL2MmKrQbRgm9AoCOVPe4Rm5p0MCocMKdEMxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=URb5jySQdjMQqO/uhsFT/mNrmZy6qIRH2KTjV7njbCLeg6cYAYY5rO+Epzt4MkaueV3H+5queHaQ7gJVxXe0G5wof42FI4/T9fcUPK9WYhNz3aY1g9aMVezwIAHpNO/ND8hHb3wJc/gLCx2iZQPbsLI4VpyzVbb47xD5FsnZvZECW31hZ8YrCyModKkZ92TeYPey9WYRcRtUnHvfOMjv2muGsKUZE5AyIGDbyDS+R5QIMbZXfNzaysFi7Xt056oBQZdHDPfRFQHXU+PCqn3Tyha0wOvbH0f5xNyZG6j2xJNjZN4NFeIk+ytg19b/ynHU2UIEAbCDQvZnyeib9lIhkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:31:23 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v12 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Tue, 16 Jun 2026 08:30:57 +0300
Message-ID: <20260616053106.2623475-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e208886-a640-4dc3-244e-08decb688107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|23010399003|376014|18002099003|22082099003|38350700014|921020|56012099006|9063799003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: mSWzIIq1zS3t1ESK1C8L6H9jTyzxYTn2xpwrnjnugTRGcP6JIr+i1Gvba0hxryb+oneXTrV8V8PqsUMhMm0G6b8/063/TJ8dLkipnujg5YJXYC+B+7a/KNaCed8Sf9AZkx05QoZ8rstemgwLyYrzovGZOawcphAcYf0zK3eUye+aGoMp820XFFaHpSdJx7w3E50ULG43m4x0ksMzgAHqRtQx5orVhxYL8zx/T6H3oJVYhcr80cWqdeWKyQQwcIHxXsuuwE1R520sCXCCcOy4NjKQQGvG9ty2NknRlBn/9iQoqpFnmz+Ay+gtFxZGq0LvBjNMr4NFpqODyXhK59J3/BHttP+qr9I0FSovmbi+O3yqPONk9gCTYb7JJjzsGZL53IZY1Lmk1m7utUew6rjAq3iaLmfvI0sM6AS8jCNPDOMr4dBD+z1upIwC3FtE89KkDcGxSBIdpcnGdOAP0aDNWIM/9wa/sIidZtumIHGpTc64ZbNMnOgS7yN0bRrFz8DHFGQm3L1KP69mfDNKmvEG9VGVSMq4u3ChJa6Itj8BtkdDKTkz1wia/iBjhluKq+inLQQord1E6ZTYtQRyXnAo8NmJn/ZyMCY9vqfSzdjxW6DtgTjzRP1gMaxyd6fLL0p0bWcR/NCJ/FcNmMpLrSvFt7veqaM4UUb72WwXQK7g3hgXvqewW8qj67SeTvvpx2gabt94NcZc+zHFP2pcwVb/lg7G4HlzEke8pNFycQWe87OWgL2fyh5btz8CsbGbiA+KDL98gRvv4su8WFgxf5iFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(921020)(56012099006)(9063799003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NYcUpoTXpXZ1ZFOElKbnNrc0pzK0Q2dHFKWWR3Q1BlaStWNGhLWE1FdG5U?=
 =?utf-8?B?VHY0L1pNeDRWdnlYOGN5bkdRbjIwUCsyaVdjTmFGMTVsT0Vqekd6OHJOWmhu?=
 =?utf-8?B?R1p6cG04WlBROEVhdnpOc3V3Q3ZYUjJZSlNIQ0tScXdURWp5dnowRDFSVW4z?=
 =?utf-8?B?SlltemIzenYzbVNmODFNcU1HellvdE0vLzZjbkhQdTBQYTdaZ2R1SjFtSmpD?=
 =?utf-8?B?OU1BeE15TEd6VzBqODFlZ3ovTXU4Q3NMQUFuMmtLTERHV2pTckZrWkpnM1J5?=
 =?utf-8?B?L004RndrUU5JUVZ6Z0NEOWZ2MUxEMFE2VkVIWEpGMXl1U0p4Uiszd0NBRDR3?=
 =?utf-8?B?cG13U0NZZm0vZTloVmZtMERLSGxzS1laSEtpTEpwclV4aTU3QXpWc1JZOSs3?=
 =?utf-8?B?MTVma3V1SytBR05kTXBIdG1mcHU0MUp1dkFqSUlrRXIwa2ZZbEVEd3Qzayt0?=
 =?utf-8?B?ODZqYk16eUs0MCtFc1dzT2U1Z0NuU2R4U2NrZEl1aEZSbVNTTVJ2T2VpY2hi?=
 =?utf-8?B?VG96SHpLdmhCTjg4VDE1a0I3QWFjTWlEY2daeGppWHN3RnpuZm4yQUdUbEFq?=
 =?utf-8?B?dzFhd3JTSGVuWHBKblJIMlBacUVIRzMyckFMZEMySFl0bGNpV3RBS0lKQ0NS?=
 =?utf-8?B?dE52N09YWVpWWWE5WGI3SHRaVVBSRUUwUmF4NzFKaXdZUTZPbFllQXI5UVlR?=
 =?utf-8?B?WmJBbGQ3elZDQzk4R2xVbFQrV0Q1aWxwRnZaVHJnVjhMbC9wcm1CbnZGSGNV?=
 =?utf-8?B?dUY4UFM0UXRzbVIrREpEcnVKZjdkSkhiZ1RLa3pYY0FKUmUxMlBtYnV2dUtn?=
 =?utf-8?B?dExWaTBUYWpXa29yazJVdXhOOGZCeWlGeHl0QXl4UUcrYnZNV2N6ZjB1emNL?=
 =?utf-8?B?RnQ1TUVFRng2TnBBY3ZyZzkyQ1dFTWE4OUNRd3NZQU9hb0dNQWc5b29rSFlh?=
 =?utf-8?B?UGlnMkhrWm9hNFptbEZtT0hIajYvQWVwWXBvdURCT1c4SjdRNHJWR1d6dzBO?=
 =?utf-8?B?RkROc0RiNm1IeFBuTlVrb004YUxGalp3QVJjYjRhYUszVmhsQU5xT0tPcWZL?=
 =?utf-8?B?dFpvU3M0YjBLMkVmN1MwdnBHZUxuZjlPMHhWWkxKMDFqWlYrdnpNSTVFdnhU?=
 =?utf-8?B?ZTZ2WFZGc0IxNVpkQXo1TzlNcGRFd1JkRGsrZmJBcTcwVzdLOW9kdFRJRVRy?=
 =?utf-8?B?YnVOWDJaemNxbjV3blc2elpBUmhlc2l6MjVrQzZ3UmoyNmQ1UU8xeHI2R3Vk?=
 =?utf-8?B?UkxGeExQdEpxK1M3YXB1S211S1czWjUyZ1crZmh1TE5NOE1peUNDendzMjBL?=
 =?utf-8?B?cm5PSGQ5MzJ2QW5HV2ZaOWl4cXpUTUhQTE5YWUtDL01nWDF1cVhQUDkxeGJM?=
 =?utf-8?B?YzN2QzlJT0RHZ3lTb1hsdUhzckRUNk9adFh5Q1hDc3ZaQjViSk80WVUyVlVy?=
 =?utf-8?B?NkYyNTRTTjk1SFVpajBwS0lDR3k3Zmd5d0xKbG5tdWFJTmVjeEkveGxFRnJz?=
 =?utf-8?B?RkhwLzFDRmJRRE10d0I2cFB2QTdxOU8yeEwrMjJTOTR4dSswZmdiS2dZYXpS?=
 =?utf-8?B?RlpnTmkyWmxIYVJNaU1wc21iZ0JkZURJbzlBUHRWNHRoOWhNSDJQcDJ2YTA5?=
 =?utf-8?B?eEFqelkwUDF3V3d6YmttYm5RaUlPVXNMMmNqNE5FRmdtV01IWUEyZmFwWXRo?=
 =?utf-8?B?TEJpV2twOGwxMXpYNjRrYmZvS2dTeFo1eWZkMFB5RGtLZ2J5eU83NnpLb1l1?=
 =?utf-8?B?elROb2dVMHNVNkp2Q1R0WHdwYTliMXZoN2pEWVE0MEwrSGJxaWFJdVBuNjRM?=
 =?utf-8?B?UkNwbFR4eHh6aXNrakpqbHl0MGs5YXd1NVoyNlZGQ1pHd1BITFl2YmI0NkU3?=
 =?utf-8?B?Vk5HRmx0NzFQSVV1THNZOFJtZ3cvaVIweHZGTE1WbVI4KzRiVDl3SjR4dUtu?=
 =?utf-8?B?RnFNLzloakdoT3VGbXdhVFpucHI2Qks1dnFsbDFQSzF1QVpjcWZwUDgwalhI?=
 =?utf-8?B?NTUwZnZ1cUNWZTFXWU1wV3hoRUVUaThGMGRpR2QzOThpSVcrbmJlQ0hPNlZy?=
 =?utf-8?B?cXRDVitFNkI1cjZWMisycG1KV2d0WlRVRXNvNkFjNmxwY3pmYlJyc1c2dW1T?=
 =?utf-8?B?S2xnakxvNSt5QTJwcUhBTW10aCtqaUhibThyb2hQNnB3ZFJYaUxFclNpaFRi?=
 =?utf-8?B?MFhRRlBhR0VUbFlBOHlBNTZaYjk4UzVQWjdaSGpaN0xPMHAzMTEzS3N2ZG1K?=
 =?utf-8?B?Z2M1VkZZeHBlOExZZnYxUlBMVVNLVW5wVGd4ZXljOERoY01sMlNUMXFMNXpn?=
 =?utf-8?B?dmtSZk5BdDBYeXBhY21KN25jN2xNck0zQmxyellVU0lOcVBLZGVTb1NoRWor?=
 =?utf-8?Q?vJHPHvsQfbwPpSn4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e208886-a640-4dc3-244e-08decb688107
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:23.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09JzB/P0VKFecrd8hAoOe/ionHfglpUmtEnZkdI+eDZAASnNvLCqd59K3Pol9ZcIi3GJ7Rp+5x3J0bZ3ESuKeHI6epf+n5bhprY2SL5Medk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8996
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask within new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ef81901bc41..18cf57aeb2c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -16,6 +16,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -223,4 +224,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __val = (val);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __reg =  (reg);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
-- 
2.53.0

