Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B763C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2E987509;
	Wed,  3 Jan 2024 11:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="H5HQ/TNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD0787128; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF2687225
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngh+LvkXmxC9IjDPupWlyhY8A15RDp8dVorU+dMr/DfaF08ynkQ9Cc7crHNdUqolGni47ZmY///GbMz2wdQtStROB/O38XbJr3I7KPrtmOCfAusciNX+WOwcRYJDG4NJSkSFXk1rYR8W/D8E3bxoEbnapBXo7BxtjWd9V9TSEZIlgxHN4ZzLv1hzlv7YQtg7G0+uH/Ku/j0f+JHrWArxjmPU2PkCJ8JpxtiKsExtxqwI2QIJl3cn5tzGOigvZP3Hk5wClK5CTaepmnNTGTu3UQSj0UJAxBtG3pZjLjU49W0Kc49BQlDyIJ2Etn9kcI6begGBjS9mPHT1Pb/pUU3/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vWMkYTowogqjnr38HI1uJ3AChZrLP4XQ8lHBBId340=;
 b=G1SKeJtR8N1CLvZNEY2nDQ2KvEGBpVB+K9666Zu90uEj8tLghs/opDgqev5DwId0LP+rEddJhAn3KjEPok/Pun7b/0oxiRSL9aYIlV8MhNfbA59xkROCgDLtkyEfJ3/YYYJjZLIITx+abSQFxUwWCrgo35sfDeH5/0cbNoxyZrsr7c7zu2EQObF3mdJUppr4KdoYR5emVqWGH3pmU+ul18M3pV+iUdRbOueMMog3HaAWraLbwJjhff3oRMwGMyVoab8ub7P4w75dSSBaQCaDBTtF1JOKF1pT5N24TzVqOlt29Xjdehn2SpQIRRfeUBogiWHBsO/5oyCm6nuANcc0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vWMkYTowogqjnr38HI1uJ3AChZrLP4XQ8lHBBId340=;
 b=H5HQ/TNY+9L0jEcjN8KKmMJV3LghieyyOhytA5tyVHBBxpE6RfS0YQrGsXC9lIuCjScdugruc1ccHlnmSly3vLewSZ0wji1BCl3RRykJC2OUgv21B3kgCC7MUip1z+40eLayFyzB6RUZOT+DxiK1Z98Ht1GTA12OcNmdJXHAYxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:21 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 3/8] cmd/command.c: constify "arg" argument of
 cmd_get_data_size()
Date: Wed,  3 Jan 2024 11:47:05 +0100
Message-Id: <20240103104710.4185383-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: d4843492-8a1b-4963-2cdf-08dc0c495d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPT7Fbc3NsmC/PimZUodwqH49MTw6apNil2hEOrXf6Ht1OhpVKWFVZYyjYsDUIiQBfUgNXpMBNE29eF32NcHCqDB69Ud335yZDjjmUW1z6wKS533oQ0CWnaOAFDmaFu+XZeorxYJTtxKQrtOFYV/ZykpX/kgpqBpj2Ej8GFgvFO1eK4fWcfU+dBq++kr1RRA2r/az9lAyevNBUHIoyvZLSlxFO3SM+nuvu5lEUg24d7qF3I9ff6WEQyFlldbXCicIRlAEEPweWb9VKu6XYpuSuiGC6mELzaKhWAsNTH8hpDQ53TYf6KPNv9PN+YxT2ueIev2dXGHpuKGas2+SyqSID9YdloG/KK7+BvT5u78nLM+l79mTWqskaLJP+Ly8Svmngstmsv9F17bLmnZef8mJFgBR5vAstFEG+6q3vFryhzzP7L/jB7obdMPoTsCel5s+F13mgvBQFY+u8pS8Aj05DQ2+CIZQVZrpjE1FP/I3iBcbiZKuf7+It1ZNVnz70V6rwywquUV7fJZFb5gBPI+YjJKdsCfFkWX8Tga7bGpboSOIP1D/rHceY29tQAYY1GGHj4/AASvtogmmAeEhYyNz+2GcH6cOMGYhw4qcBrtY7Xh7pFNjJVxPNtua58UkRHw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQn4nV/Ma/Q6bmlTqJWMye2/tzQIrZoA9lSijTsSO0XmHly9XL6tMcxqOTmg?=
 =?us-ascii?Q?zTokR43v8RPRofShPNqv1B1pId6I7HzG7f2sCqxpXoeqA+WvkIP930/2mGG1?=
 =?us-ascii?Q?BQUabtqpieqS1w6G0DpxRiauR9h+7KKG5dy0rV/zzQveusgGgriYteVAQ5jw?=
 =?us-ascii?Q?+GwHZq8JzlLJcvyxIRYr6EuySdJT6CW0AMQdDwh2OUPOqhsQNcxveTOaItg0?=
 =?us-ascii?Q?iKawepsfWZe3S0GyUDdB8sO9uZaCatf5JJbEr86TAe2Suz3UE+Fz4EedaJ5V?=
 =?us-ascii?Q?MRHwq+FwtdITuNWnHJtFJg9B9XfJ+HA9jAT2d0YLtAOeEpyos6eia/pYd0Rc?=
 =?us-ascii?Q?c9vMDUeXetiU5QhZbz7G1CwdWxMozd4Fk8qIOwo7PtowQrgIQuMaM83g7Ut4?=
 =?us-ascii?Q?pKYpIwOzVSPJJh/92Y/Pjs+kfYjaQseclUwDXdQU7DGEsxdXTCPPRc3S4Ted?=
 =?us-ascii?Q?Rjy3YrLc15mTCPCYJAemxnZ8IG4OaYlt0z4mYzjjMmmMKJgbJwjxYliZrHPA?=
 =?us-ascii?Q?rZ+3XELsps35u8kE7dMMCnspfWMDp2ya+EgLf5fDWi+2g05ceZ9dcA3hFq6s?=
 =?us-ascii?Q?wiCWHv9rhTDAagL8QFpiRX8mpeumTbMVWGi7qyytn+N5Qrqg8e5IBwdLPCGy?=
 =?us-ascii?Q?G3QolJO/XVhRue71wg1aiKwj5pcqczgAFI9kGH3dWLg5pMXf+Yp1PDbbzbGu?=
 =?us-ascii?Q?8G9giolk6IvdU5LqnI4Zz07W/DzdPAdDhbepPGMh/x8hHsbmlFZYEWLTLDwk?=
 =?us-ascii?Q?kz4I06ciLbYnTbvzy7oKfT3uQ87drclSRj+tRWEGWAXfFA/kcU7YRLEwI2NY?=
 =?us-ascii?Q?rXZzn5nP0PlSPW6qATzz7JK5NDQDARy6RcAj7Ts4HxlNIqwfFXgB1jAfXX+D?=
 =?us-ascii?Q?InIeEYmmbanUwpczJyrT4/RHDF3SYj4GUSm2xHNRf4UUvleNIJkcY9KeuvWZ?=
 =?us-ascii?Q?pPAIJdLowQKBtJozJ6nYgAWmtvtrrC+czVz0NBJWucydziwoMNKGns+oNGfq?=
 =?us-ascii?Q?yPxukADftBEFDGqafdyinjk3zPvoaA6bvQL6mkaaFrxs0cHwrhOYDhDQGszp?=
 =?us-ascii?Q?8LDcWO3UdMr4S+ao1UmkOJgB3N18FTFP8O4yMJVtV1QspYtjcfxYmXmxJ3vD?=
 =?us-ascii?Q?WLwVPzJYz4dD4HKRHoJU74WqxY2n016Zw/2DY0xFKk8TIWBOafqI9PV2QrgM?=
 =?us-ascii?Q?55vTO5zL4OwDGtcIaGfmYQAkl7ieI/Uq9VHSfE0CY1jROvqwGKmuGwMtS3Pb?=
 =?us-ascii?Q?bpvhiBGbnq6ahnXcxgkW72+uCo/4+jbkQS+kW1TYN8Qsy+fOW2E6Vn3vTkyS?=
 =?us-ascii?Q?kIYDqVxAUUU26v1GEDGUjaWsDryBJ/8GWoC9FeJxmT/Z2X5KEsw5huloj4pr?=
 =?us-ascii?Q?UpNC+LsNCG277hCzo+2nDTNnUsk/tEHG3PDhkfjx7vmay6RmwwICUMZpfd82?=
 =?us-ascii?Q?r4BHwde5gSl14wKXbCDsqw5plX0jQejj++CxvM6zidq4ZAhEWV3/UW9efHb9?=
 =?us-ascii?Q?yAUjmUPVdKYLt8sAGeYlsi3DY32j4cc0oKvY93nsP6HgoyuM6J4ktICSYWQ5?=
 =?us-ascii?Q?u7sIvLC6+wTbJVacxFv+AXF9QxXjcE8/B/yCS8f1qyGtNSNCLVZitF45i6Qo?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d4843492-8a1b-4963-2cdf-08dc0c495d4a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:21.8534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2cHVYDB9b6n9pzURlgi2k+Ps2K3ZTbQQ83giOO8rQYY68p9NY+H18UCu3iVp1maxgMiHFK90KvxU3Ff2vj9Cif6ay/nzig7fGt2ixI8eIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
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

This function obviously does not and must not modify "arg". Change the
prototype to allow passing an argument of type "const char*" without
requiring a cast.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/command.c  | 2 +-
 include/command.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/command.c b/common/command.c
index 846e16e2ada..474ac98bc38 100644
--- a/common/command.c
+++ b/common/command.c
@@ -466,7 +466,7 @@ int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
 #endif
 
 #ifdef CMD_DATA_SIZE
-int cmd_get_data_size(char* arg, int default_size)
+int cmd_get_data_size(const char *arg, int default_size)
 {
 	/* Check for a size specification .b, .w or .l.
 	 */
diff --git a/include/command.h b/include/command.h
index 6262365e128..6ea678fbbe6 100644
--- a/include/command.h
+++ b/include/command.h
@@ -153,7 +153,7 @@ int cmd_process_error(struct cmd_tbl *cmdtp, int err);
  * Return: data size in bytes (1, 2, 4, 8) or CMD_DATA_SIZE_ERR for an invalid
  *	character, or CMD_DATA_SIZE_STR for a string
  */
-int cmd_get_data_size(char *arg, int default_size);
+int cmd_get_data_size(const char *arg, int default_size);
 #endif
 
 #ifdef CONFIG_CMD_BOOTD
-- 
2.40.1.1.g1c60b9335d

