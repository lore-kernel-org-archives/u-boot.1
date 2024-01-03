Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468F5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305528747A;
	Wed,  3 Jan 2024 11:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EiHuUIXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9E086F64; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67F1871CE
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYYtuGty6pqN8g1rE9LV0fWdzVKgRTyU/9uM6k+A6khrf577CiV8+Q/tqo0ODNRIfB1B87REmHEVps6yW62W8TVPTI0kTxmktIe+FIRyQrx2xqbiZoStzOeGhzS+5XMFtXvgh4dwbSYk+J397xkN00IBTYslnUVQv2kHVu6F3zQRdLnLRfZnhIfuXTPs2Du610p2r2JClgUc0+8f/WjNT3D/iWgFMmD4XuH1KCXvS+ioiUN9yvTq5I/FWv3D/3xv1N0KywlTFR0T0JK4z18fo8V/N28G0K3bAIyyPBagoXj1pJvI900gz9x2MRFkZX1pQVFpqWSeaDQ6Tm8kQLnMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmifkkOYQgl1OmzTWQyPnlip5sc14n7aw4Zbx8JKkZc=;
 b=BEs/s2xegRNbatGWiSDbzB1ynHtEXGHqSmAgwoYEDBKcBKvSuOC1Dk5AhfYJXPYBYDIhQjwUeqGQzzvxF7r9Th0FB6ZZu96dx1mbG5X0DEJYMHYSKxpczjGHkH4BVAsYpGaDAaGJu3PYcQvR35F9MSHnCssDrbadsvWBqrYH/TKSmQvcL9IqiedjNHWEGOBh9JJcwxa/CWAXLR8enqmB0BtBPd+sfiWx76czp1pjIO8Ed50m44ylkbTStLwhcW9z3lFOjR6LBK5UHTvMk7fbToYW48rpP+Q64N0mynXkhVVVcG7wYS3ahINY+JdNO6VddrXhe70u77/bUE2v8DjWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmifkkOYQgl1OmzTWQyPnlip5sc14n7aw4Zbx8JKkZc=;
 b=EiHuUIXfdab0N+P0HACU7xLch+Thq74e4O+t66Y8E2tadk+R0iLxQTsyitXd+4oBjV+1gkZmNsP2I859xXKzodOwwd8BrSbcWg7ZtjVqtKaAJhf1LFxXkOfjzhr8BIQ8gyjaEMeU3my6hadLPGPeOMGKqIK6sXhmpqHrJXpNWdI=
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
 10:47:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 4/8] cmd/command.c: relax length check in
 cmd_get_data_size()
Date: Wed,  3 Jan 2024 11:47:06 +0100
Message-Id: <20240103104710.4185383-5-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: 4ee99fb8-5b99-4ce8-db00-08dc0c495d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC9t1K7bQMKhY+F/W7KzDcqC2dzf8XVtEHXO3jHIBiurOU7ieaZcVgtoYj1r4gq+vkA8aNz3llwNvcOPFsifNiE0r+TKya+Ct30KcGb+TBcWF9td8zuByeUwJc+327IoYlomXHHrB9Y4sSFY7E1JLeW2sDYKZyLILsofLCpa0oVQcwffjrG5iLySvNWl6eLpMyPd8DWtP5Rh7ydfOmHhYqKyIsh4xcnO8vvHhhfivrpxj8DnCjHh4MVNH/rFqbxxkCuNgIgev/qHMb8G+PP+r8fA3zVAb5OA97alppnfiNCEXnMvIPI7W5jiamt2YCo0o8OGNWeoI6GIBrkeSI1DFLtd2g/xTM9ceCr7z5Z4pTygDjPUH2bS851WqZn9OuOFrcWElEpZ0xxIEx6v095G33CA9480Hb7icrJuDaCSWCdRtcbOfrmVds7KPrVsrT2XdMA4jtuRGlt+QDXKj4iMTgtYqq07Zp0uxPBo5Zllbjr0TP69RhYM3dqVnJKuWIUukFC5ZBrb8rnM/1B4Y2O5BkQGa+ijofGYtr1gj+vkJ9rDnRvqSLlOZcP474QH5KnRtY7gE+mKU5AkeSjf1ocOFDncNo1rmPVo0OxwvWzTh73L8/po5VkrO0uddXcfBqKA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(4744005)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mIuUq/PrZRw6elXwQr1BHuAAh9NEIYSTCiqOYyNJlsMjgriwoVoZ/Dfnk3G?=
 =?us-ascii?Q?SHyijyRYI5irQH4oOtMkBGiX9abziI5gdT2+XglBV+q3ebr0G31azI/j6anh?=
 =?us-ascii?Q?T1/ITwWMEgfj4CrdWIxa4hPKs9mk47jJv3hfNKw+WoKSTnbBIBOYMpgq7RMJ?=
 =?us-ascii?Q?NFxtKdp29+3qy7QBInVluzjEZM0z8BSoHjlFIxcqwaxcIghjBCexxfd1EX3t?=
 =?us-ascii?Q?Ekcn3KskphG1618xO6yUF9ZjMAKD7feHUjPTtYPM+H2kh329g+3XsALDkuQP?=
 =?us-ascii?Q?ftSSHOQnkwW9Xb7fsMzDDeeuUPh3Vlz1d1sjBS06swNALbOwi8v6z4MYnfcN?=
 =?us-ascii?Q?UYQOv8mZgpt35Od7AkCiyxd+MLp1161oxWRr1+sB2wvMO6nN5i3uVqssP0hm?=
 =?us-ascii?Q?BFsiRMusgWQ2FZFxfR4BhvqLOgbbx5Wa7NldlWwHihCx1YZiZIUfYWQ1aF4Q?=
 =?us-ascii?Q?3mFHvROKI8g4+Rg4/OGcWsHJzryxIr/JsmdxkNA9xYaDDTuMvmvUh1eAKFbh?=
 =?us-ascii?Q?EgOo8vbH3H75xRnxMrlaq1tgNmWAFu4gEdMZD+0/MdtZOqXG6DWYGSM2XZG2?=
 =?us-ascii?Q?8QXocfRwM15xyyMMv9Qf8fPEtuQvjUITtEVtqcLOjzZoBK29ZB3ahYNDf3HM?=
 =?us-ascii?Q?X3vvawieVKkEYOs5VdSdpyWCW21tUmNsVhKBx1sjgXSzwVJbrjmtwUfRuWq4?=
 =?us-ascii?Q?f9Pm8bjf95dMaZ6wUiSDU7Rkn3sLFKUaTU+8bG8rgkNZTqmoYhSezuv6pVr+?=
 =?us-ascii?Q?nKacsRtjrddbu5gfsbmgAPHVMlrC/2IOAJKmqTQ4UJhJ+Ho/7mDwC/cxAaRv?=
 =?us-ascii?Q?yTa/Z1dkfzuwfTNrp0KX2fTMzdC7ZdP2umL9IhTDQ5La+ENHVOmJJxBo8soA?=
 =?us-ascii?Q?7BGSoqiZTHLDFVTXLmBbN15pO7TkZ9qwLkTD7WC7aDtYj56waTfTIaArdRZC?=
 =?us-ascii?Q?1umOFCG8+fwbz7VOhLSKG8n5iyer5h3vxpngmfu4shOG8kAHT+U9AE8TyhRH?=
 =?us-ascii?Q?BIcncAv4rMDTGHEgmcH35vLNVPhA1+YHWoLjALai3zgK1pUhZWX8WSps3r1g?=
 =?us-ascii?Q?99hsoLYnWvoMjyJjLXy9WghTeKgvu02UZnfArIwy40+NkU4v5UfK6dPNH3Oi?=
 =?us-ascii?Q?1q4OqQNKVxCxAz86QXZ4bH4Bu+uzysXUfPi/2AkJnO2qjjiMhX8T9mclEUOd?=
 =?us-ascii?Q?iBxNvknTK/qGBj1RQymjR+BDplHWY9bKpHdXY7eEMnxuA7zzzWTekZOJ0Oq6?=
 =?us-ascii?Q?knLec2lB6yWvIg9Gw0dXmUT+6UEJPjx0h6Pn6omezbC9qOCLanSk77jMEaVK?=
 =?us-ascii?Q?V1GGlQN7McxEAWkgJN4NftXO4gl8iPNvVbWoupIw5qQV7wsWSSUySDvCpV5t?=
 =?us-ascii?Q?710EBTh5zqjnVbUEmTwRcSuiRqxXb+yOb/BZ55UaFTIU8aIxWyWv4oIe5L2R?=
 =?us-ascii?Q?dB8mF1yjld0q1y/Ju0wAIvm5IVnDgTPF6Ot3pyowDBbss0Ht8CIQh2ezF/kH?=
 =?us-ascii?Q?TH8fx2Jv6g9FG8ZGefioqjtrtLUsL94flpjs5jXfQLyItYVqVAFRO5lNRqP+?=
 =?us-ascii?Q?86uUtfFz+5dGemBUkdvUDL6zZOh4eZqzABurLHhjyf+NqIyl0sPdIhEzkbpW?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee99fb8-5b99-4ce8-db00-08dc0c495d98
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:22.3802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDUWSafCLZUfYTieCJE5fvkgwlhZ6A6OqkJt6zQwCzxAHh3WDgY8XGcrOHeriMlByG5sgbDlJ8Qmcsgmtip7ZKgAwLkoUO4WuecqOwyMbts=
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

Just check that the length is at least 2. This allows passing strings
like ".b", which can be convenient when constructing
tests (i.e. parametrizing the suffix used).

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/command.c b/common/command.c
index 474ac98bc38..f0354f41644 100644
--- a/common/command.c
+++ b/common/command.c
@@ -471,7 +471,7 @@ int cmd_get_data_size(const char *arg, int default_size)
 	/* Check for a size specification .b, .w or .l.
 	 */
 	int len = strlen(arg);
-	if (len > 2 && arg[len-2] == '.') {
+	if (len >= 2 && arg[len-2] == '.') {
 		switch (arg[len-1]) {
 		case 'b':
 			return 1;
-- 
2.40.1.1.g1c60b9335d

