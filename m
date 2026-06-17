Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8846DCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D51848C5;
	Wed, 17 Jun 2026 07:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="snkSWPPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5883846B0; Wed, 17 Jun 2026 07:30:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD92846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmHW7+OsMZt7cqYjgUzu1845THBimGOjZehovlJnLjPz7YTAdkvTwI7s5/9Falhi/o0E5i2juYYqAukWjllt7GSBOTiV7glFZ/xSmwvPnJ7RTZMz8PopIETEArFBGzlvFijjKPeAkdMCTcXT2SIJC3VAE9b3ZE0MRxLBaBo1mOF7UZ8q1XLhdsCDhRSfE1aLLSeNcXeqdnhurf4PW3M0ABZtstSaJq/BQdBllvsSxdgQQG98ne+k1d+pqFIFU0dQIQlGGnTeduRTa+MFEdeaPHUSeyM/l5DqxLHsixB8K+0EEIXoMYCUcjyZugZYMRSvp6XWsL4h3SL3lQKAbc7THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=yXSqrfmuPqTk1GZn+/SKapbuFl+SwY+yDpaoBcilrb6bCK1ewwzD/MqRaVPqVXlTN7BKCKB0Njob9manKPIJaMbGDZP3NDHu0uc0IteC0To/n3kwksulOY0HstLwkM463L18z4Li6a/xjC+bEvBEh9QzSHeN1Rio9T4dudpefiSTseOqRemoDNi/LN5Zh3czuaTA06kZAYM4Fx4QPOWXq0x/TxmdwytZ5sgo/9GXVp0Iq+uRF3AiYbOjwLreVpnZuexsJHJlsNbvK8Tj1LhrgxqF3dhAA0HTfToL6UZjVZfckh/eAATKv0Jck+McVo9a1A77ja8BGdxuGO/wv8r7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=snkSWPPOXi7G3vEZzKOLHkIeuaYEe7G5KalxFWOntIxbwOvYbzeazWG9mMK6628djfkj4IKivs2pQ6cJ29Fu3D4BmQvTaVb5/5KJqh6QoMSQyPE6auagY7f3Qa37yL9zo8UA/4mYwn/Otf41+CXcTDH43OlTkKTCl2LC7NaqvPbhVR8Jl3CLxxBL6t17IkG9U0dBDYU44D3Oe7AhXpvrTOD6duXcjALm9PtGgFivNI/N4Z6psLoVVrJBlnC4Bm1pxZ0WhuKq5Ws1MsljpjqjOsMQYEIoJW9IEh1+lGq3jq12ZFbtjZsZo8ruaXZFTN9DQrdQEI2NoKNlSPDErsBT0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:30:03 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
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
Subject: [PATCH v13 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Wed, 17 Jun 2026 08:29:39 +0300
Message-ID: <20260617052948.2815870-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b5714f64-3f26-4c44-d5c3-08decc317bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|9063799003|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8wbq2jnvSZCDCLiOJqsf00XL5eFjlnB3JI5ucNPu2vHA9cZ7kdb8jDBQJ5Pq6Q/p9RL25GWz425YsJdKY1NpRFCaD3ws8LgfLuiGpHsr0LjKy6vqgonjJiBAhMYr5BkW5mL6IgXYr6NAGWYQZTHRKKSuA5bXy2WVDu1QqcKSpAq/C9uqbjWDdZdzPcLpG67H2ULbbpO5feYazOlk6i73i/vT1MENdmEOLPxnQqXoBVx4sgmBbhVkaclDRwziS3QwF7JQ+JmoZfuOsYNEpVEmrwG+4xK6I2DkVEVqwVcs4Hca5xu+hWBQl7nojs/kB1SuCGqBiYfkaXdND329sViYgj056cIsDKGp0+Yqs0rzRIrkExQwjJ+xMm8TcS9K2iGPRc3lVrIYw9hKPWWU+CLlo8kSl3w1/P0RAfnhR6IDTyH3agpa99OaqciG0GSmJ2wZJVvdS9jTCOTxoPaakljVWbQpi/anc6kVH5OXjpqug7r5VFFoGzB3Z1MLCu65QpT5I6c3ygxslefL456QvrGlLgzXhTvEig61VB0IcgtJeY4H3omXkzgYRuE9Pi4ZhUItAbQ+bxJAM9kHhOt67f4np4sMMTVdPjxxYrbtsqt2HonPQ1HeATofWjEHrAMjHN5BEun3SH1rZQJQhCd4fpIPE0+jB0KNLiGLLq6NJKSWovHie0adnptntDmmLDJCXwd+787RFPOeNkSRmcvKfzoxXQcw7umOiuO5W2BzRpU3Uo36kHCXS2Bom/M0RfhgJ0cLlRrNHbcpJRxIiZ+9geDJcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(9063799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hXbmZYTldxZjBCRldVNW5MKy9MUVNFMzZmTitFVEZjVEsrREMwcmJXWWs2?=
 =?utf-8?B?dWZheGI5MGF2SlBPMkoyL3RyN2JqMkdjeXJHQVhJSENQOWtHUmFDSzhyQ2h4?=
 =?utf-8?B?ZmNxUTNZbTh4U2dnR2piVCtycmdKUlExVDZMTzVvT3FsWHZWcFhYVjBnUGRv?=
 =?utf-8?B?dStWZitsRXJmU1VBWjVjdjNEcUdiVi9wY0xRd213SVQzMFhUckpkSENZeWFu?=
 =?utf-8?B?RVdNc1NWUGxSenV3U3phWmRIM05aN096T3loamlTT2RkNFcwU0NzWkxrQmxp?=
 =?utf-8?B?T0Z3c3RiMkg2TzNHMnk2bkp1WmJTMHFWYjUyUXl6WjJ1L1hVOE9jb04ySm5r?=
 =?utf-8?B?SU9mVk9qcFR4MGxoTW41VUd5dTE3VEUveWtSRHlFM0g0Y3VuUDlpR3VoVmlq?=
 =?utf-8?B?VG1mVmlnSWdQV1o3bms4SnJRSmFPaXBRTnRxbDd3QjFMTURjMHAxTUhFTzNT?=
 =?utf-8?B?VTYwUWNXVUhVR05iRHpiS1Y2WStRYWV3M1R3enNaTzIzWFZUanE2NU5VUmVj?=
 =?utf-8?B?MjFFR3NKQ2NhT212NE95SUZVaWNWM1hTZG92cHRaWmtXNnppdkJ1SC9wRVQ2?=
 =?utf-8?B?U2VwLzgyRTNIajNIcFhjY21SdFkwRTVPQVN5Y1JycHVGZGVUNHpXazJvOU1X?=
 =?utf-8?B?UXFFdDhRaENTbkJmSC85M2R4eld6c3g2MFpnOURMR3lDYnFieHhnMzZVcm9h?=
 =?utf-8?B?TEtud1pNeEpMVC9leElFKzBZUHByMXhiSEM0SkpQZVdnZVJxcitRdWlWRnlP?=
 =?utf-8?B?KzJJbEFVcnQxN3Awd0pLcm54cUpJYUpPc0Q2UkJxNkk4T3FXeHFTV0pzV2F3?=
 =?utf-8?B?K25qNkV3eGtCUGVVOFJSYURFZUJNVklRUTFiNXpqWjZCdHorREc3K01rdHRS?=
 =?utf-8?B?YXhKK3A1RzM2MGlzd2NMMU9BN2orQmlzTkZSK3dVcXNWZHBaSVlnQUNPYlV5?=
 =?utf-8?B?eDVVazJJdFJKMEhSVVZ3dThMWDVodiswbzBiUlNpeGswaFhZSElNcjQ0eXJK?=
 =?utf-8?B?d21vUTdKalRiVGNJUHcxK3pITFpaOXZ0b1F5OXBhYXg1YnZVSWZpck00T0hY?=
 =?utf-8?B?SUYxQjdvQ3RHMS95b2pwbTVuUjBFYU9vUW5GTFZOMkZucE9OMUFWb0Y3MlY4?=
 =?utf-8?B?Vy9SQjNwcm4xNVc4UEg5M3RQQ01Zc2YzYTZ0Z2gxZHQ1NHNmSmpVU1JwOG5D?=
 =?utf-8?B?Z3pZcjZTUkg0QUl3VkhEcGJTTmJwS0M2L2F3Wk1SNHVuT241anRWZlJtT0c2?=
 =?utf-8?B?NzdzZS84cWFEMlJvUXcvWEx3ZFdKaEFWeDdXNGl3Uy9mQit5elg1bkVPQUJQ?=
 =?utf-8?B?eWdhaStOS0UvdU9QUXA2c205NTRqK3RSdmREMFVmRjFpMkRGamlzOG5WUHg0?=
 =?utf-8?B?ZDc3emVDajBTRVZONkFBTnB3YWp1SEpDUktRckYxUDNJYVRNZFFBRFJvNHRS?=
 =?utf-8?B?aU16TmtHaDhJL0U5WXdqTWZyNnlvUnJJUUZHQUs4VFlEUm8wTTZHbFg4L1E3?=
 =?utf-8?B?QW1HVUlwTC96TmRybXFmbTNGVEM0M3lsR3VTcVYwSnF4K0wxZFhSb2NtNlY2?=
 =?utf-8?B?Slh0aHF1MVZBMkZZSGk1LzkySlZicU44UC9Tb1NJdCtLYkRvcU9RMitiaTNI?=
 =?utf-8?B?UFk0RHk2OEV2ejZ5eVZ1NXFuak5Tc2FxWWM3YVBCVTBCWENmZmRTR3Q1VXkw?=
 =?utf-8?B?d3BDUFAyWkxvNVJ6UUhJVGg4MWR0dk9nRkltM1E3WWdYWlA3cFo0dWFBMU1S?=
 =?utf-8?B?RWNlb0lGb2hPaTVKc1l3OFExODI2QUJFSWdLbmkxNzkvRWJwbDlqU05Ob2dr?=
 =?utf-8?B?QzBtcFhpVTlFeGpwcUErbkJUYVVtbFZYSnh3WFZHNTJvdkhDM2pISStyZ1lW?=
 =?utf-8?B?N053TjhLWmk3dHh1aDFiMmRWVzdpRG1XNzFvd3RZeWtIQ0RaL3BtbUNHYmJz?=
 =?utf-8?B?cTNBL0RFYmMwdkt1RGhoUlBtKzJsQW4vdHFKcFpvMi96MHhIdjBsczFLNUFU?=
 =?utf-8?B?SnBERkE3VFZkUEUzcmw4QjZVcS9WbHNZbmhhZEtZOWU2Y1RmRDlYTEJrWUVk?=
 =?utf-8?B?bElNdjFGS2pWaTlmZ3VsaUV5Mk1wcVFZbkJFb1NhbHBLZFNLeVJyS1RlajFq?=
 =?utf-8?B?WERsYk9QNlhOZ2s4aHBwN1VzVlVxSnRpTVJNS2hzM2ViL0dldUpORFRNQzI4?=
 =?utf-8?B?aHFxMEF0MStiL0dZN29oZ2lucml1QkdVUGhYOFZIYnJiTTBJZDdUMFQrQTh2?=
 =?utf-8?B?cjYxNUxxZWd3TDY0MTNNK1lsWkxxTDFsMldjQlFWcFFCallEWi9SRU5xNThx?=
 =?utf-8?B?T3lGaU9ROE9yWXdIcmlOT3pZNjlsZ29BWDMvY2p1L0I0TEVQRGdUTDlMZXhM?=
 =?utf-8?Q?BxEGtw8PqLqa3quk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5714f64-3f26-4c44-d5c3-08decc317bc5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:03.7398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSiYHevGGlshYyNCdjIaVInsvrdJisV3MKS7jnAfhFuIQzAm2Tmj8kgutMCADNo0pEsnLCQb8usk6ABgccLjzIVDvaG+x/zQmpEQq3ZDyFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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

