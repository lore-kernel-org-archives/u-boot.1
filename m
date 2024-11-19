Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF5D60D09
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143A8894B4;
	Tue, 19 Nov 2024 03:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D1C8924B; Tue, 19 Nov 2024 03:06:08 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC6889426
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw7cLqIpe6hrLmPYu1rJGhNvebZlN+CTQl43W7XX5P0xId0868jP2U+PMzJvYXUVFE/SXcwSUPYtccC3AruPmcjytHZkdwviBN15EkpqpBcbJZ/iHCIEwKI69mG4TrH2sNh5QQ7E++zLJXgpBNrdKOqsBIVLaZ8Z1lCIuqeKBh0haKx6wH4VhTM1mzRsXeoAHIxFRVKtBySirORZ5ajFTu1jVn7q1syM6D6JnBpsYymoWDac6t50Wdx31KocH05DEvrIyUDgYgHTjEOBxtIIUlGv0C1n3u3xAnw1hL4PcFxqkozyft3tZebeJQZtHjzoD1066GIX3NC4RRF7eNqCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXmbbTEGACnpO38ox+3LzDG7uPq/O+InZFWij05lLTk=;
 b=S8GHG6EudXhggeHtJBNg8yg3f/qTX6vLDYlFxlysvxo/fJ7PQt2ffbifUTKRAZL+aYVkgLZrFSZszdwhOwKmK/vLi9J7YwNiz+jzB+kQJKwP/yejOKcKp2ym3/otombb5u4guYxx39I/pMCb1Na0Ftc/WfbQJVXPXBqFIs0F0yB5Hy0VSbVBKGmN7y0etEIjFIM3aUqafiakyUtvdp2R48I/6ek9CJB8tHJhgqFQe2Hz61l1A8jRml4aaUHogOpH8Q9ETFBrXh7R6SgdC+4S4ox755oav2yX6N/PJOnTRxLxZbcJBFOAurIUDu3xNKA9S1UHiVIZ47W+3EqlR/yFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 09/11] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Tue, 19 Nov 2024 10:04:23 +0800
Message-ID: <20241119020425.51989-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f349a9b-99d8-4c97-cc4c-08dd083ebc7e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: TUA+aXVvOOaiBlQMbZtBZyHvIqVRdgTADA17Pe2MEUw8PsmFD76oLMLcQZQfZlt8v6wYP+LR0TMW7I1zK0wggd4ckmlV+2v8xyTA9OK/RpVoXOpV2UPV4StXPRBWOzSDCIQ8s9AZC0zH2jpx9/3zLEDeLQLj2PS1SZfOeT3m45NE7n4PaV8fxuQ1OyZzBXwZbzEpYpd5o69ZDHyB+smebB3ULwiqHVkRNHaAq7VQCymDaTtzhEvUkSN0cjMmcQZ+4Ic5WNXUZwrH/q7pWB7WLrqbiNOPm3VdA9dk/fFgSZ1NyMkSIQzyj9LPx2n5r4xGZ7iE8L7KKyveIdmoJRHoVcmNNZTBAfDsz9td5lg53U5xZDSUAai8JoQXRx28240OvN+L3S+KTW/NfIzoAUHfsvJdYdcwVUREAnPEBiXmwdLB8BExEOP1JDmvQUHponXccqHAhor2heFq4Eour8kEkSW2NvKEtD3aJTdB0RJb7SCc2oGnhm4oQbnWLySTVeQkLhfFhp/oldMwomBJjKmOatFEyDCuJQJmI9HBUxITq+S034hVHyBw+Vs5C93Ie43cYu8C+kAC9mtuMu9q956CbQXYcI2B/jJlaWhEt2RuEdVSXb8aL7Ml6dC9uiAq9eIBaVBFyLuEvYyNFpABi7qKhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8Yh+PhKmjqaVUzA9XacD20HdOmC6dFo3xqrHpyIJegyKP9zjdl9LueCfNCB?=
 =?us-ascii?Q?DHNX7mYSMiytRJakubYYXECmRUE/3Ij6iKeNels/8aUeuVjUv8SLp7F0UJAv?=
 =?us-ascii?Q?9Eqx2zcH+SrKeFWmoq8O58Gdotxiq4fYw3DXxwc00Re5lD4S+wNKtSymWt6r?=
 =?us-ascii?Q?hqAdEB10ORu8Tds+Sw/tk20s/jM8DCW6KeWRt7s0Z3etfhaHnnEkop3u1GJ3?=
 =?us-ascii?Q?QlaawRcOM1UWGBHabZquBIvVhY9zksfAeDZc6Ult3+KkLTV2EqumKvYItDUv?=
 =?us-ascii?Q?i+MC9TY+r8OaLp9qRE4nIW1oSe+g2OdzdKfmqtDb83VysOYtuWoWcxormvmA?=
 =?us-ascii?Q?rql/c34yskVN30kc7mOpMezaFVPo/NEOL3+wOuo/bfTEPPJmDeAaQVOQMJLx?=
 =?us-ascii?Q?vo5DfOXqxxe+oX45/hqInzKmdIlsu2/N1QIl5WVF7A0L2HYP3g3Ex3LL/Fw5?=
 =?us-ascii?Q?Qu9uxKBj6ppgHOjVU3XqqU4f7D2mgOQibzO/7QXsC04nrq92JofLYu9wUMPv?=
 =?us-ascii?Q?dkMBLvLSUWm0ov7p04COQXUNWrfao+7U4A8IOM9cu3nNuK5x6lI1pNuTeQ1q?=
 =?us-ascii?Q?/z9bvV41paPAFiioWl0Gokj4FLv9N49MGoAeImvinIIbdRIq0DMssg4ou60/?=
 =?us-ascii?Q?OFNnKyIPVrFLrjW50fE/OIBAKcNgpyM6eXZf33lAoxuiii5NBt94quQLxXG/?=
 =?us-ascii?Q?S0gGd0aFpbq/slcBfGSX+vkycX2YZFrzXyn3S6ZGfeqjqzjaK6K7SuT0uyf9?=
 =?us-ascii?Q?xT/FXR+Xz3lCMz9VNRVcCatG/u0c8c//KWqfGUWXmoN2EXoXI8/pznXDoz+h?=
 =?us-ascii?Q?TqZkA0vCzbdHieGjYiwcqymAtdxHj7JuI0ow8BZXXX8n4yTtT6hZG5YmIQSO?=
 =?us-ascii?Q?ywmgKHIdk8MZ4wNwKne7zHN4SCHDz1CaA50kgefFW2e1Hv4/uw6fNwZwSSSK?=
 =?us-ascii?Q?6JGrZDh8yQ2333NsDHAYaMkigB714YC7mL7NQt9N1opWMFvmZdLwMpqU/io4?=
 =?us-ascii?Q?VdMO40QmlMiwVd5fqpi2A9HcL+bU36/G6LBROpzkuG6uI8Z3BzXL55QXN9qL?=
 =?us-ascii?Q?xM+WiygRXnlvDQ6lezLk3YfmXFZUr9jNuwqsPdy/fFsRCE3GYA4sWEL4BbVE?=
 =?us-ascii?Q?R3ExsZJojLy0NEiQZjqyIU3FE5Ue4IGTckRipn3TIhwfXlE1kuW8h78F1m0Y?=
 =?us-ascii?Q?tA/QsHyXwjmGiyAnBIwkJ51LoML0fDhNpATTngA078Uzepty/tnPAEmhzyc8?=
 =?us-ascii?Q?i+hfkDHtzTFPnrfm/U8diP7vNHKx8oTtBcOIk6P0o3hqsfCc9npE7KOYAFpO?=
 =?us-ascii?Q?kUPCyH46e+5k41mY25PoDIF+1N/LFMUlP3klvvK6FYywk6CB+8gTHKYD+7RS?=
 =?us-ascii?Q?c73gj13Z3oFkyufFsi05wAk1FCuMCFgfp+OPRDisIqZkwXQD1mWzjmU3OY4r?=
 =?us-ascii?Q?LIpZ5BZ6y/4fI/ewh5fSAB1/Z7w2t8+KHqLIR67hVLlVAffHrYUhpJFhdPql?=
 =?us-ascii?Q?KBlOm5X7zJ1hNqQ3JPfNE3ERuvcCja9nwuARN4Y8aAbpddt7VEFnK+RtX0S6?=
 =?us-ascii?Q?LvJR6AGMCX9Dtu4P6f2O+matNgwjhJkMoRFN8VGPGOBnloL/6E9LujsPojPk?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f349a9b-99d8-4c97-cc4c-08dd083ebc7e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:10.1439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+/+U0Xqh9T9GxxXcNRBl0hJi+eOKvCVUuAzmLdIhb3rfr/pn/ji0W+b+6tbdXhBTWNH8Hvuhal3ru6VDH6x62ZPUd2E2jWVMxS1BVNQ5Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED().

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Fixes: 5ecf9b0b8a75 ("board: starfive: add StarFive VisionFive v2 board support")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 38132ecccd..cf7f39d5c5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
 	}
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
 	/* boot using first FIT config */
-- 
2.43.2

