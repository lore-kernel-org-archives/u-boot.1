Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901BCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB447848B4;
	Mon,  1 Jun 2026 21:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aNfQmEGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E592E848A9; Mon,  1 Jun 2026 21:53:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF72D848A1
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teHOvwzxBmvvAzUxbn/QGFDUo8BObM5QnoECAAabE7Nn89pbvdUp41Nf/3RJOAUx7/CFlk2MFpYAH+CqUp9fNQ6vvIRHfZY9hKFbADJxs6v8GE3+67+ANXpJ3Yz3VTR5X+dkeSRGJXXnw+UdZDFVzO//UZ17q/alCc5kfICuv9zTIT9cNrS/94uHFg3vh9Z8VM9psHDj0d0E4qRGSq5WWiOjpve+7eeEUqHH5mtoLX5KKGn79K99IUTxsvYMtdu81rvZmAqhKJMjwfAFzcvV1If8CANphBdXubE2Jk2Doy+liuzZ8Z/MwFoquiCMqMjdwIVASpSz4seICF8AlzURTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=GYSz3T5sA8Z+W/PwoKPNIBXtQRJuOq/IZ+CqlwSatOPdGsxvalzIjIZCkrvgYPnZakPYWSV4mZ2R73H+OvAKOkY2scY96Cgfko3NBpN6KL4jz7chEsSeYVpf6l0eAcYb5ppiACaw+IHkvHNtglugGKjVZZQcBLM4/Jkj3cc2gwXdmsggnFdfA5ZAq89Rl2IgRSJ0X2ccf51qRlr6HmX/qKBcmR5NTnZ44YDNyva1zJZ745ygRgidJn2dxzTDyF5ePwpjyvWLk+iv1czloMvU8AJ7N7Ezjp9V4k21eKHk+N+8PaqCK/RSRUpyB08UBa316kcpnoNhy1VagkaJlcztNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=aNfQmEGnimkanJKIpvBewgGQdJp3Rsj+GvHiWrdAjSKYa/2c0iwgs8Qcv9pKbUhgPitWkG7nsRvZVuq/zD+afhzhX1fra3WS1ILVOxfU6i5IomtaqlFu30cemY2Si+JucaVMNv4z3F6kvgkv3SmT7KEXb+91fCR4XSsCg/hd1orZa91+CN+xJKpczzxEOO1gr15XLnOJVn7lf1uCYJEiqZgStBqZ12k0kZpR473cdfITZDeY+lfY6SbOJu1v8eKu1GVRIUgjK+H1C0s7EIortagkkvzlb3VH8wEiWPTHJlUQpsmSXbqJHvG4ehHiTIlzb5znJgA03t9nchguWXGjQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:26 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v11 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Mon,  1 Jun 2026 22:53:02 +0300
Message-ID: <20260601195311.2390473-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: afe837ac-eba3-420f-5053-08dec01771c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|9063799003|18002099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2HeefsH1hgjnchvzucMjmJRfBCkUU6M1I2/p8DEJgxzXsEWWZzZby1sOJK3xizqMZTDS6IJXcYCiW7P+BWcDqrYnRtVgg/7qn0OLObNeozAi3FAOZOqi2wlZ2cIePK5dMcI76LFih1s6vFookbJKzdlTz5P4rxCnG6ticPynme0gnQoEtEjKzN0SfiZvDSp5neg9ZvUPDF6mltAA7faJ0XYj3gA47XMDMIXrkcttdGRUN1Fz1OtyzaPLA2tfxIJLc0pAFykcid/foVEA4nu/rtRXlYTRq665JgURs2SrkrO8Qiaam9+J3NC4oeQqYpCCHFlIfGbRy9e3qHHheBolWEK81962X6zalcdQ1ydLfn19JpfoLMfd2GvZLMB1mfekelChtqsaoYItBuDkiyyLYJZY/jzEsSwFOnDmNWzJ4Xx/qEILCZ24eh4B6NFNbUW2Y5H7cXzoc5uFzEirPZv6+dz5BEILjNC0N+9+62wAHV/hEBN2lQKHwfm/3u1WlrWECTs46KerCLV8W3w3YS4gScPvcFYfYTo9iUgkeOdJWAuLZN7uq03+jjBONT1hw3bYxXxPKinf4oxsTwD/L/IpcHzbpYtMBBEdega9SM3yba0sj865Eadd9xyA7A/MWYGhU9q2J+uojfoxnxS2MmITrBmw2WpvmgbyJydne3KAlsmbA2lf7tZpHhqKSGA9bb8DQ2HFCzIPFBmmGd44fHqdBrIT4rWjv9DlknAankgpWNVQP99c5KvCeoMHGIUHawBql5z2QmAS4/hpxHmi2V8mZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(9063799003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pRMG44eE1vK09BSC83d1V0YkhIckIycktZM2tLYWpEbUI0SGVWc0JJZG5F?=
 =?utf-8?B?MEM3K1dxR1FyNDNGeW80ZWZPQlBOK0xiczRZSUtydCtGc0xwd2lsM1VGNkht?=
 =?utf-8?B?WHF2eTBhWjFQcFdjb3hGSjUybGtYZmVEc0l3OHJWRk9pK2h3eWJRRXp6OXdY?=
 =?utf-8?B?WVVxN3hKQ2U4bkFqc0dtaThDNE9PS2FWSDZKMHNDWk1EZnhkakhOODdIRW1W?=
 =?utf-8?B?RFhGdGRsTEJKRDR1TW1lNDlOMDV2eGdoSy9SK2NnT0hTSFFseHljRTJEZXlk?=
 =?utf-8?B?NkRmK0szYzZKOGk5WjlVOUF6RnVOUWNTN2ltQk56cnluM2pGbU5kbUFtSWRp?=
 =?utf-8?B?dFJmTXRhNmt1c3UwYlFydlV5MzE5R0xWbGhkdG5QVCtycjJvR1h2aGI5UjB6?=
 =?utf-8?B?aUU3bThWeWhBWTI3TExwemIvSFVDSytyOHc3cXZWV3MzdzB3ZHkveW5ON3Zo?=
 =?utf-8?B?bThhdnFqWnF6V1liSkt2THcwWWplRU1ZSmlWMSs0OVQ0ZGxIYUdUeE9uVkVE?=
 =?utf-8?B?TU53R0IxT0ZiMnRkdE1WdUJSRFBqRldKbzJwVUNNNjZaTjZMcE05OSt3WW5i?=
 =?utf-8?B?Rk9ZaUdsQzkraUtuekxWMXYxem5WMVVuWVcvcjFubERIV0NCYTMyY1dLRyt5?=
 =?utf-8?B?dFYvM29Hb3oxczZzREZUVW52M2x5NW9uSDRGZlMvR01UbkcyaGJZTlQwSWx3?=
 =?utf-8?B?ZS8xeUtmaDBuUGowWWkxM0h3cHlySGVGMFBKd0FTSUcvS1F2RUhZK2VhSjVH?=
 =?utf-8?B?YjRZU2VDNk43eUlpSUkzVmJsbGx0aW1acmNDUGFUM1VoOHZ1TUczelh2dE1t?=
 =?utf-8?B?S21NajFNRFp5SWNoSThMNGNlSkRHa05JbHBxOEtOTzYxRGt4MXdHZW10Z3ha?=
 =?utf-8?B?VXZWc3o3UWlpOGtDMEI4dlhTZWxMTkEyRDl3d0dPTEJWNFE4bDl1eTJFRkVD?=
 =?utf-8?B?aXBzV0g1ai8vOTBtL0hqbVZLMVZMd1VrVmtlYnl2b1dmVDFtUDNHTXdsZ0Ew?=
 =?utf-8?B?eHp2MXFqQmdYYmRtdjhKbXdWOUJFRDc1dHk3U3hTeGkwTlREd0FsYjFFSUkv?=
 =?utf-8?B?emZqT3pmam9kTXEvTUZTNFdQMWgyNTQ5QU5SaVQ4M2ZHMHIwUjJSbmNtR3ln?=
 =?utf-8?B?b1FQMGpEeU91KzFBVG90TnZ0SS9BZmE4b1hhL3h2N1dxb1Z5QXk3NndDNnll?=
 =?utf-8?B?b044ZWZBQ054cWwzTWlTQmhrTkkrc0ZDL1JFSmZpcWNLK21uMGpmRm52TEE3?=
 =?utf-8?B?SkZnMWk2bElseEkvM3pKQ2ZqMVRJNXVXQWxJbHBiUmtOQmtZbkw1NFhlSk1a?=
 =?utf-8?B?SVIwWXdQVkcrRVNaVUhVanhKL2p0OEdUclk3Ui9Pdzk4dFBrN3k3ZlUzMG1Q?=
 =?utf-8?B?LzRVKyt6TkkycVhkU1psbUI4MTU4blpPdURWMnRjMWppT1h1SVpFS09OVWs0?=
 =?utf-8?B?Vmt1M3pkRVdJKzJBcWlHSDRwV2RZaTN3MTFIalhlUy9nNTNRMm9TTnc0RzYz?=
 =?utf-8?B?L3hBemtrMTQxS2VxU1NXd1BzZFUrS28wSjhnc244NGkwck5LdkpINW9MUzY3?=
 =?utf-8?B?ZWVpbjZKWXh3dldRVk9kOThPV1hhYlkrWXJZd0w4VGlqZVhxQWxzbzlSN3Jt?=
 =?utf-8?B?VzhVWEh2N3ZHaFVFVHc3b1o2Y29LRjlmd1lsd0pvVCtCQkZ3Y0laSUtHMTc0?=
 =?utf-8?B?Sk5iS0QzRDZoUVNBTzZqQTVUMTZpc0dnejlsbng2Yi9nVHNoVXlDTHhOOHNI?=
 =?utf-8?B?WEJOeDhHQ2UzcEJTeWZJMHdzQzRoUGNxazhoSUMzQTJLNDlCUUxtaWErcDV2?=
 =?utf-8?B?Q29QdHdaT213cDE2ZkRZY1ppSXhjZXRsT2hVNm9vZmxOSjd1OXdQLzk3VnNu?=
 =?utf-8?B?bGtJSy9ZLzMrN0x6cnQ0eERZZ0k1ZStScFc4UU84ci9JS0gyL1VjZkRZbFhR?=
 =?utf-8?B?ODRwQm9YaGozWkpKcS9IMUZad0ZtSlZnR0NwQWVpVnFIcFMxdzB4djVkUFNu?=
 =?utf-8?B?K3dpN1NxUVhqMSt5WVNXL3REOERLZTFxUzhmSTZ4QTBMZkYrYVNXY3BjTU1P?=
 =?utf-8?B?NmpTK2FUNUJaM2tQTmYxMUhDbHZWRkIxK3BlMFcyLzMyb0kxVzZlemc0R09D?=
 =?utf-8?B?T3gxcnNJdjB0MjIwcVVWYjhxaVNKZ2lnOWhxM05ib2ZzaVlrSHlHVlN5Qi90?=
 =?utf-8?B?NXdLUjlPN0k0bkpydEN2eXgrOWgycXRIL0Nna1JMenExSHM3aVd1K2dCMWlR?=
 =?utf-8?B?eFVoRTVyOWd3b2JaZWZWa281b2lic2IyN0pVRWE5ZlljU0VSNWtXN002aGN6?=
 =?utf-8?B?T3l2YTNQZS9CWmxHRGhmTGJKQzNjenR6QloyNzc0NEJkdTk2Sm4vQ0lsZlRB?=
 =?utf-8?Q?9ccOwVCTRWiubAlE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: afe837ac-eba3-420f-5053-08dec01771c3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:26.0233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSgus6/MuZc81rMR70rwsdJ9byrQ4/AldFLM8vSTfSOHflbE3FPjK7tzdzn/k6bI6SxOQkjmckWZB2eLAxEcpq003m6sqq2UPj+vbKFGxiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

