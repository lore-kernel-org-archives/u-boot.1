Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0442EC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75AEE83BEF;
	Fri,  8 Aug 2025 11:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jouAMXpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4345283CEA; Fri,  8 Aug 2025 11:37:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E6883AE7
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDFH8LG0+ngzwgZYplfhI+5pdFMQ/5oeUA89y2aWOj9TmWl9a/ZgnZIjFzU9JdD+/E1nRYnXF1bbXf+Ehu60UWkFf8RGZY1hxahCvum9cYs9ffnF8vtBvMsnHQrYsuy3F1UyNTca+2vLDxVyBvvqw00ZIdy2KYHeBfstKDFERDkx+/mx+KC+GnQ0YvaBCV22Vr7kEh4memvOLGfJKx3qotbxHif4q5sVd/8U6IUMUp2xM9DyGoekVv5b8uCSrQXWum8bh5wSYanVk63NDP08aqDcB7RiEiZQEK/YcoHjMMNKKssu751B8PEu0A8bsrgAWSuT5QvkxfK7UaDbwIcBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN4B4jT0nuqMd2KJdoy7WG9/lPU6UaakTke7/zavkyo=;
 b=EKnLQiSniNbSNMu7qaR+5w3Eck1qplYV84WD8ORqziC0U1o8h3Vl9SNBcaCeo5zfetQ6XwKKTEDNcp816+cpZdISEhjCvm2bWyG3zpFPFxc3AMAiWW2gOAujPVbd9VyanI+smaDH3nAmdJVPo3/lWN6JwQ1sfUjO9hXrr9RRx4Pq9iJJNOR/FDsFfVuSjbyjnT4CCgDaELr8SxQUtUSWi5SALKc6pob3V0a5xKKVUbG+BLMtnRySJwjZg0T7sqgUxLNjp7ZqUpYa3te1z178hbE1U9ITWbjWcm5oeUALSFe68tHMxpwFB/OaMo0zAiPlgYn8NBwg5pfZWhdOIFVf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN4B4jT0nuqMd2KJdoy7WG9/lPU6UaakTke7/zavkyo=;
 b=jouAMXpLrGbP/dq+kzzOrTIYmtk+xym+UKFaq0qipikx60y0GcYSHd9NBQRgWWf00PIKvIyP0+Zf+zoBIW8P1eUrFtuWOkIZ2Q7CRQks77lMkm5B5eerR/+ouDxPibwx/qbsneT6TOQiQ0fhX3kZ84yTofI/GzDSz3pugUAB8obFGfwagxcKg03EG0KNFi43wf49XwAz/AvronMsLHeK7J/PXyq7DxE4T8B5mtXcBX+OjwlU98nObnjq7UZAy1qYIc1wKlxB1SsiqTtgWxleWzfK4K6EpiIW9xE0BpceEtghobWHuYJD2m9KIe2TTlfZ4tg2edLmJe0RUowkbFNHwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV3PR03MB7730.namprd03.prod.outlook.com (2603:10b6:408:27f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:37:09 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:37:08 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: ddr: altera: Check IOSSM mailbox compatibility
Date: Fri,  8 Aug 2025 02:36:59 -0700
Message-Id: <20250808093659.23144-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV3PR03MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f0a38d-f90f-4b01-d407-08ddd65f24f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PmCnWH85JtvLF+HKq7jhBnqP2AlMZzbP2NTOFQKuKSnBRMjjdEtLKlXSaCtN?=
 =?us-ascii?Q?J+PqRMaZ9wR9NMra688kJAtm0iz8pD4Fpz3Wzgpj4urOBlO9pfrBno0dY5pY?=
 =?us-ascii?Q?raMVNXz84lU0wwRhYJ2YplfLtFt/sodfE3X07i5Yu+nN/IO7ovu49mGMjUhJ?=
 =?us-ascii?Q?mfb4mthg6QN3P0FoLvi4ZbIamz2vV0FOwNErvhd8f5uynstPbLN89Kgc4dyB?=
 =?us-ascii?Q?WUTzYxrevPPhvygoQKInjmdL6OCtXlsNGp/UE5OEvqMa8RD3Z8pePubh9pVE?=
 =?us-ascii?Q?HtoGxaISoO0NYoxHZ4KzeTQY9NIPlhA1U+rEo71OMgVQCQVOkRxbmXELSbIB?=
 =?us-ascii?Q?8fhAU262i3p++LTezeCJpSQ/eCJkIDGJEXtaY9xFZyIDBTALKPDbUTtuJ/lb?=
 =?us-ascii?Q?jJh/I0G9xUB6ZsAHOrITuPMseL01Ejdg543VLsw/Dg4roC8/7QD3P3abmcKZ?=
 =?us-ascii?Q?z00fmDyaZI9pJrcHRFQ9JKIiVts7u9bW++CQRUue56R4vB4AHfFENFemhu+h?=
 =?us-ascii?Q?VamqXCW2iw20idV+UkkZn5E1zr6+bLHyHWaDLey7XKXx/dtJckjFtV0GOsim?=
 =?us-ascii?Q?UfrXndVNRjn/ZeFxUFf2H3mEevjsCr3mVf9RExOZwQziSpbf/CHluu4cr9g8?=
 =?us-ascii?Q?Vs1TihfsKahjKuMacgWrx86lZ/PrPfmSsSpm/4odSyS0vRRwHTz6kyu8FK8x?=
 =?us-ascii?Q?o8J4ZztErWSrGPYu2Bap2t3xjecH/kHCfKbB5byq1n0K17KL0FD1YlE9axLY?=
 =?us-ascii?Q?0HQmA5lpJ/cMxOBpSb2FfxhHn+GN06iPO+OSfzDATy5Aim9lVUkDI6cQ/ZeM?=
 =?us-ascii?Q?mlk0YF4/PHoWd9Ngi/71W0qOXhIayUf86IyqAvz+6i7m5vOVKvlfJ0dhlVP1?=
 =?us-ascii?Q?nvT+gTz3y0WYS3cLb42I2T8NQhqYbFk83d2TfmZrIsfxy33eE2JvZtvVZLU6?=
 =?us-ascii?Q?2Eq+ijI9lvDsXLdC4uVoyRMewfzscO7BpW8snBMHUoGdnXOAxdz9hlPDHivt?=
 =?us-ascii?Q?16f3uCVBBkwWZuv3DV5IM4lOWZQB/ReuRmTsyjBTVMnaPofVsenoM8avW4+E?=
 =?us-ascii?Q?Tz11+sdVF3s//aWXhri4AORNRKIIgkmTV3DLaM5/SlxJ7ccMQ8ae4A1kYxnB?=
 =?us-ascii?Q?R+rMuQ07cuE+GsrOdAwZWfmdISS+AuYyPO7wPR7ZuOXvDk0LtJMDxy8pVXS5?=
 =?us-ascii?Q?HdjTt6ENsMYWaKrsUEeYFR0KrGEwaIThULW4qDb9Id9eyHLVnSsp+Jz8I4de?=
 =?us-ascii?Q?bzkplet6L/BdIoxit5j4WJDgyuB++6Yj+LsOHE785KQQXtPyNGa7hy5e+mPw?=
 =?us-ascii?Q?2Y/jHi74ppnq5FC8kXad+Gp5Nfpz+6ai6z9GBkSktya45z83kZLrXYVOEmvO?=
 =?us-ascii?Q?QLtzUW2mMRFnDgASsI6k0Bkm1IDavUCSMwj104JgNmOMOckRaG0vJxtrS89F?=
 =?us-ascii?Q?tpRnCkGfios=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wj9binppzZaU4SoM8Nl3JZGfWdnfQwSyGdOcscsMbCPDcQDYNV1GhzhMrrm5?=
 =?us-ascii?Q?/7JmxNdwlKaEuAlJULJhzR2FEdAXkOUaRaefXLTEJKKZAbZjEwzxa30gy3Aa?=
 =?us-ascii?Q?LAVe0RIv5k3YrTvro4NbqbFa1z8LMZedl5ikuy6BOmAGuLBArm64VsivaVim?=
 =?us-ascii?Q?YffO+wYf1pItx1E050QKfDjZBl9242E0CJCi4JRZtWxFHiHJTbiLuf4HonTH?=
 =?us-ascii?Q?JSKob8AtXIP9EclaoPHvnTuZx84B9y+OnGHN6NZeGXQjp56utKDmL9p6jDvF?=
 =?us-ascii?Q?+PFK49yLcJnNMl1XPDjDaw+2DrWjKQbtfy8VVVCrbpq+Caokmv4BnMyH59tq?=
 =?us-ascii?Q?CPQN2ghV1s+cikziS8spcUgxHk6zqjLD6jjh/o+6UagaWFeRXnhOcfk50TxK?=
 =?us-ascii?Q?jE8alJFRt3WIJwxC+/toSuCfU9j9VqkYagyBcw3zErh+Hq8N4TqKkjEVEaEV?=
 =?us-ascii?Q?YE2OR0aQdF1yHcCvwamVQmkbE4oE59/0efN+xpq1j8BOanx0C34O3l+gShP3?=
 =?us-ascii?Q?jvUFvSY6IlaAIHnceR5OySXs5XjaSqaAisGaV9JSRVocofgxRw/ec4nixx8s?=
 =?us-ascii?Q?BAhsnnms0doX+88lYVe+VqRxrIYsCJmK39AbzdOX2cOCB12Sq7aO36EnrsYF?=
 =?us-ascii?Q?rohJ5RMQbmra3mHG5b0MWy6K3WxvzseIwVJN0U9/ARI7fXydEeHcSfsyYEuk?=
 =?us-ascii?Q?iaF7trj4CeQgBozdgAvAAksd0eDJq0g0FDdHUO6lMWpZaYx/39apvBFl7Cty?=
 =?us-ascii?Q?1W6M8wgOSaJ3k1mKEAOZarX3uNuOu8siprL97paanSNoeoEpxC/kFBrDQQug?=
 =?us-ascii?Q?frLZWS3Ux22Bo7faY6Un63MdEBwBeF4gsAQ1nJTKoCg7IN8BybHhzZG0CRZq?=
 =?us-ascii?Q?xr6OBrWZGlwVqPy6rYoLx/7tqdv40k5w1og7ofL66R3ypPDGaDjXav4ykI9r?=
 =?us-ascii?Q?u3DoFj6iyMpJ7aUIw0u0u+DW6nvVF9FlWk5eOMmCcf66CavP52qvMBTUaQ82?=
 =?us-ascii?Q?lTH5vMk0aAX0ltayeJAnpmNoqlcgwElP5Uz/j2cxhZcr+vYchRyr5KUIXEch?=
 =?us-ascii?Q?92J89tClm6B7CKHm7pnM5Qg3v0M7hOK34xm36h8BchhyK0Wa8sHFJxN4waaj?=
 =?us-ascii?Q?z5kOO4nxySpB8xyjDdzYXzqzs7sdxxS+4BexUQ3jJQgP7o7AP2E+V/x2UONz?=
 =?us-ascii?Q?iJUzJ4EpEZVFFlo3/No951enupTeGG+bwyxoKSuS0N9r90UiLCftiX8kLIUm?=
 =?us-ascii?Q?49ls9i/oQ1p7LHC5TKbMFAUV5uQY3gnT9gh7KxMLZuY7AIN3awOS8/xYaJCD?=
 =?us-ascii?Q?aE9GP63mk3zMXW6+Blnh7GY3X+LRHmq64PtyBFS8E0sBjEvRd4mf9lrYK+Bx?=
 =?us-ascii?Q?OWUj43Ly7MRUBXHyUctrncVpSRWKa9y3SHgkCX0mPQMnP++jUQjnv+2HL/aO?=
 =?us-ascii?Q?/myiGUcbIoizD+dlM6HJHtwVpayxm19a4dyD+NQoeUYcX1Vj+BML/ftz3+r0?=
 =?us-ascii?Q?l4DL5EoBgAG5HlYoNuMGJuzXqe/c2DpXw1cC+b4sKD/dX4RZkO45bKQtyzel?=
 =?us-ascii?Q?iPwxV88Ktz57kb/IaX6724N4AUO3A2sXmU5E2k82MGk0cbSE5fySlzTH13jx?=
 =?us-ascii?Q?15vVENR/X651nlbA6zLnlcg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0a38d-f90f-4b01-d407-08ddd65f24f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:37:08.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1oVhDA2MRlVNdjtGCzI5IQVctPTqB+sIVNzuz7LWYR6XPuCFFgG4u74rQiJx5E2gOiyU5aJevoh/Ebbx8iVR3tPJVQK0Y96ImxkTt7WsBmtbkhVUhYqcolW46OLsgwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7730
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

Compatibility check of IOSSM mailbox with U-Boot is performed
by verifying the mailbox specification version. If check fails,
appropriate error message is displayed.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/iossm_mailbox.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
index 21f94959a04..2a2f86a650e 100644
--- a/drivers/ddr/altera/iossm_mailbox.c
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -38,6 +38,8 @@
 #define IOSSM_STATUS_CMD_RESPONSE_ERROR(n)	FIELD_GET(IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK, n)
 #define IOSSM_STATUS_GENERAL_ERROR_MASK		GENMASK(4, 1)
 #define IOSSM_STATUS_GENERAL_ERROR(n)		FIELD_GET(IOSSM_STATUS_GENERAL_ERROR_MASK, n)
+#define IOSSM_MAILBOX_SPEC_VERSION_MASK		GENMASK(2, 0)
+#define IOSSM_MAILBOX_SPEC_VERSION(n)		FIELD_GET(IOSSM_MAILBOX_SPEC_VERSION_MASK, n)
 
 /* Offset of Mailbox Read-only Registers  */
 #define IOSSM_MAILBOX_HEADER_OFFSET			0x0
@@ -383,6 +385,23 @@ err:
 	return ret;
 }
 
+static bool is_mailbox_spec_compatible(struct io96b_info *io96b_ctrl)
+{
+	u32 mailbox_header;
+	u8 mailbox_spec_ver;
+
+	mailbox_header = readl(io96b_ctrl->io96b[0].io96b_csr_addr +
+				IOSSM_MAILBOX_HEADER_OFFSET);
+	mailbox_spec_ver = IOSSM_MAILBOX_SPEC_VERSION(mailbox_header);
+	printf("%s: IOSSM mailbox version: %d\n", __func__, mailbox_spec_ver);
+
+	/* for now there are two mailbox spec versions, 0 and 1; only version 1 is compatible */
+	if (!mailbox_spec_ver)
+		return false;
+
+	return true;
+}
+
 /*
  * Initial function to be called to set memory interface IP type and instance ID
  * IP type and instance ID need to be determined before sending mailbox command
@@ -392,6 +411,11 @@ void io96b_mb_init(struct io96b_info *io96b_ctrl)
 	int i, j;
 	u32 mem_intf_info_0, mem_intf_info_1;
 
+	if (!is_mailbox_spec_compatible(io96b_ctrl)) {
+		printf("DDR: Failed to get compatible mailbox version\n");
+		hang();
+	}
+
 	debug("%s: num_instance %d\n", __func__, io96b_ctrl->num_instance);
 
 	for (i = 0; i < io96b_ctrl->num_instance; i++) {
-- 
2.35.3

