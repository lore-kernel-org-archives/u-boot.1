Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02FFC5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B3840923;
	Thu,  6 Aug 2026 23:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6u9jGdGS3OTZ; Thu,  6 Aug 2026 23:45:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB27940934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059902;
	bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b+nS8yx7ComTLs7r4vgTzUPZmm38KeZb0FsvNNHlkGA74zjelxN23ubw7IS5/gF5B
	 nu2Rzr9j/Pz3ZoY1XMpbdNA+7GsS9Wnmz3rd+IDLauh0QUoQYoMfgyeYrfw20UrCYZ
	 UoLcdawR4yaXmYTngmW0GdElDdYBkujnHFej2RvRb5YpQ/TuxqdS6Aolnk78WTFUXW
	 ngv3szr00QwnwkcRvnnORkibDg+71OL0zgsAZCa9ccfPeLSJRFYMskdC4TUvlBQhhm
	 hIRFK9meJ0iuGZs7DcDnQo7IvI/DbNX1BOpVHz7ys3vEWczBKZo96m4qkWXGxqKTnj
	 sO1em3OMzwPtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB27940934;
	Thu,  6 Aug 2026 23:45:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CF83392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82DA480FA4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6logmokPMYR for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C7AA580F8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7AA580F8B
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7AA580F8B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP1FTCNt43SwHUyhxxk9iE5CHpVwdMRwnA0XFjXqhIlG2tjhL2K/316DkUFtBmjNgDGqPgSGIeLGynaG7PXRP3h9ZND886bxS22TEi0km3sgKR5CDqAnhU2mFCNuAvs6UTjNTGpZkx5YfLcDLLeMJVTzuvqYxsP++4JpVkTXC23EHR99t3YdcJmzRghGQGGRfQaRP0wldmNwy5iz20jpxSofRcSA5WYsJQ+JOFhpodJUk8Goard0eYI/rH0PMuHiODNyg7pEcMbo88sNLuAi1yDaq6Ocd/3vgACVEOhwlXW9zYj93O5DuARD+NYbiSZPwWWjiLM1Dxeu9l3L0PlaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
 b=X2BpLRe3TYJ40++2X6ijUaxyh0ux65wMGACfIs1Lywm/tyvDANgMiaq/oFlB7fNZ3B1m9NZSqf6MwQdliA0pAdZr7E4jAgJc4FGWW6kUogslymEJqhvuRRkZLIH3mKDePRZllwnHbeKII24BZwZuEdO38XudSDZxPfXxfWXCZYBQqfQSrO/VZepYV7cYiWCOrk8MjRwuONGAgn85VLYZxozoBkjlNk9UPtZaTDhvmaai2BFu52jniP/S38HGfQ9KFb5QPSl42as3tlU7UpcnC8ITuwS+dG8HcacdgnIAgARIi27HA1Q17NXQXv9jY/oRGrsWvp2Ow8/NhfhEtoVmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:50 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 09/16] configs: an7583: add mii/mdio support
Date: Fri,  7 Aug 2026 02:44:25 +0300
Message-ID: <20260806234432.4098414-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b39148b-d922-429e-e98e-08def414b4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jiuWevi9Ao9007DE5qEH+7Q8nbRcANy59d2zjTNIUPIOVZXFgq+b9fiwYWLraMzknNRckKYQqLP+c4BxMz+yWtZPRaL6EYdPKyVOQKMfuT1/n9BI24Gtd5cJVk1irbv+HNdliL6FYUuoVnBe77PtlI60vs2/VminB0e79cEPghK/jCuBvjEXI6WSB7/W1I+SN+oLP/o4jz5K6dSwS3GtgchqvbGI4Wex7tzIvRjscXkKNFvc1n8JkRYWWPVbQYwsop87R+Y0QK/YPhtp85jLycFjaowuIwe7Eq2LryA7TpozV8YYVubhSwL/vKhUubBdV+DHZq3bmzEpWYVZPG8Qx6Y4rqlAhnhspd5u4QvtbdLjuYcQdUq5+G7ug3OIOzx5QpCqCvSKboj2a8s2FYDVOlRaAwL0gYIjzKZ2AfF//9aC9TOPBuoTCxLKs+mOExHJynQXEnPaLDO7dV2Dy7AFegql4AiCkXRlPaHS0+K5K7A1dE6nbSV+lo7bRMWDuf1xh0rhOz3JRPHTBNRtP3Q4o33jVT8PDI9DLiplcnqdZiLZ5KLpFCs3CtRURQn5LlTo+rT23otBnHT1GaPBX5jjv6bNsLg0rkgqe/WXkeb9rNpUuoAKz/7YlqB7iOm4/dIuh8TywmdA9jrqLslvN5QyYlc5D4LkQw2la+fomaaJOREVrQCR+JoM79eepU5XspDA0F0cm8jFEwND7M2SEGN7F4uEaC314Elf3c8TTL+cYoWMgb0Z00MHY4p7KXhEpr4P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UV2kfZluX6vnwRPi0TXtUnb1Fax1k0y7nntiABGv9cmHFA5JCcQKDM47XHsQ?=
 =?us-ascii?Q?5Lo9WWk6nWq4o8nFFGqRZnqntXfBB9zGD8f2r9cqlxL97p167VlHrmPS5d/l?=
 =?us-ascii?Q?pXBfrMAazJYV9heRCf16R7K+AKfk+sinODIoOU5fOTlLOu3C8PjSunRNuv67?=
 =?us-ascii?Q?Cct9cUpGm6kavXgFmkYFtaqYWb1yJDpfj0MjneMo3o0bx4yLo2sQhNQtGHQ4?=
 =?us-ascii?Q?03FAj+cKQv6EsSr2xSjTd0rOXbSu9PZPDNPN9h2yL8wXNxWMWvVPVwFs4jOh?=
 =?us-ascii?Q?DUOq9PJs4sUUYV4X1bDCFl3piR3oucqCIULUL22eyEnevmNaEmX16Os0DRKW?=
 =?us-ascii?Q?yolq3od2HpZIDdBimW+WKsxIL1ri11h+aRFAcYRlgzdU6R796nZKGxOuikws?=
 =?us-ascii?Q?cNnc0qxvl+zeHRqiwuAlLkW04DD9FzWrTuv6KirXKHVvhGVe8YezS18YtGU0?=
 =?us-ascii?Q?rsiV/hGC5qSnWJsk4Ggwy9y75r6T0ASTCqfR2p6VjpAz/mNxkABzdmfXSCau?=
 =?us-ascii?Q?g7uYI5LtHyvHY0/2AE5npXzMFsveRHl+aWU5Febz/5xW2b4hEER/0awyrizy?=
 =?us-ascii?Q?b0XNehyd7jY1zG8hQNYbUcQS0QFRNcs5VL3TWLr+69/Dagiofkma+PVA26cz?=
 =?us-ascii?Q?5evKMIZwPC/+gxmLFTGhlGw6iSw/neGMmy4lMZMVreKDZdsq0dvFXtKaTam4?=
 =?us-ascii?Q?1HELMYCw9D4RuqvQ+UWhIh2gTmQljmyjstGca6jkr4gzSEXKzBhBSb7ongkH?=
 =?us-ascii?Q?SR6wXgM178U2Pj99OixWdOUWyEWhe9LnhxhxG9PdcSabKfsu9h6jw7uQY04d?=
 =?us-ascii?Q?fOcXv69iS36pVfxu8MOiG0BycAxGNIES795Co7wzgQzp8ERblK+PzdT74iyZ?=
 =?us-ascii?Q?WK8pvDgUTBvZ0Vx31JjXyltNxiwnutzA6bNu9LRMut+SeBQ8icNufZZdBZUu?=
 =?us-ascii?Q?9rIKlXGhnrkpqz/EJ533DMYjOCyrwnd3DfDfyboguUD3z7q5/HTN8Aiahq2g?=
 =?us-ascii?Q?sQa/c+9CmK+1Y6MAP0xPF5ILS8cNyiEVZ8hWHf+DxW8CXkf1jvKMQlRP509v?=
 =?us-ascii?Q?Gen3zEf+cjf1gYrC1XQKmDiP3eodWXS4x/giHZgN+SybsKSZ9nEdjka2hRTS?=
 =?us-ascii?Q?K3QNJkt+Sjb+Bd8eJSoMr8toppeEnIQF96fFxI9mRwfqUeyAu3w6YjpqerFF?=
 =?us-ascii?Q?uIn5zMHGG42B7/iP6XGX3ISvn8369uRoRrDZlCvUx3geTjglcfVGjEop511J?=
 =?us-ascii?Q?YwfW+ScugR6DHm3BOMcDMQoCQ5NC+H2jx6iSRPVWDOiRG/79ZW0kzvPNdF0Y?=
 =?us-ascii?Q?CQjKqvsaoiCpIx0yr9Q6c3mz1WxK0qbfeORVUVG4q+OqEfBItWe4L9xwfCZB?=
 =?us-ascii?Q?dZTkaBTILMumr1NAZBnO1bYs3XD9BFPSwIfz0aij1W37ODJf0HoeAfsy+m0p?=
 =?us-ascii?Q?5hIDB/QZ9G1ka2oqSYFlR+sWkULMTf0hXY1NR/IKfsHMk9Utulbl0bSGsXdl?=
 =?us-ascii?Q?VY3pc7dKYKYZq0Wc/oYGql7rPfcabBQUQrnLLTocBkKQukBvn68/1NAO5ZzK?=
 =?us-ascii?Q?fkNiuBjEjmxQ47cVpWz9Y5bOB82TtLrPQ0eqJabGHd8lUoNk1kz/0gefYVqt?=
 =?us-ascii?Q?t42PCNiWPLRGjU4KDwMffDVCkZwrRqDiqDi21MMFHXPAFciYYr1toQwmd9sC?=
 =?us-ascii?Q?8aqnCMfJDoFGFs6ke3jDoNnpAmRxSRducNOIuyDmNioZHFugs96D4b2WZtKB?=
 =?us-ascii?Q?PFUpxlv/xzAXP6UYPmpuRuNQEKXMEJE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b39148b-d922-429e-e98e-08def414b4f4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:50.6921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlGqID8+tXXb6F0BprHCTgGf+OLuMLz3jf6ZXRG8+9cTjNrT5fIhgmABDR6R8w9nIi+LwTg9OGXikmITbCBJCF7JVVOzWRI9A6fom58zMq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
 b=0XDNxwLZWP/fiin/1lYlbG+u1Yj/s7f7BNKosu2Zmbg78dUsdUTdM4QQNFSVVrIogMm2zJY0LK7FW+gvhuJmxuH6w+mxG5G5Cc6jo2I6GxFu2C43+KdIOSa1Ul0Am+NQPJlvj+zgIEkiNdjFlB5wy0KWj6scxNHSW0exr58QT3a1FxOQQfncLmkNMeyiUbWokos/rJUMNbulXFOYN4fKFhbsxEdjsb8f3AyqRpuadW6K31SDYoYFKVeGF7fadWRGHxOvzXoIcUzAIAcINbFTkwDrJFEOoh4uvQimlty27+c4zzTM7P7BHMWamLjyopAw/IHfqO3UoosiDj4tqiPuaA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=0XDNxwLZ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This enables mdio/mii command support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu
---
 configs/an7583_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 16466be51b2..7178f45e3f8 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
@@ -63,6 +64,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.53.0

