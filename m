Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91141D6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B19E89282;
	Wed, 30 Oct 2024 22:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WzXoEtLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3E789265; Wed, 30 Oct 2024 22:34:07 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA75388F47
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH33NIiUBNCi+BZOED0lyZiQ276kWR3pLAJOJKbn03gVG5sPGtYe4lTWJMOa2vxpyqjgfNE/8NVcf6dtYZkheJ07bP5tmmnwLTFBWENLbApfV+uxIAUdsAfPh3Uuc+Gy57PSkYUfpsPdZvHO0PEX0iwWLbGPwG9TEBuiu7Olu/xfTZ895rWGqrRjYhHSELoRSfIdqv++QTqLlikot6ZhVfekBx1arjXFmrXDLYjLVCsgMjB4AwlPXwAXtuAEo6DVOEBUrvtHUnb0PlQslNkX1SBs0q79A1j8VpqZw0uelkwsRDIOrTIXUZWbVvWhtCWZDF/V/o83KQImgwoJa/Zv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bHrKGhsSEo9ZMdBmr9kBt8oBeLt+4n+4vdknhg7g8w=;
 b=oAel12b6Cj/QzAL+gCzs5qPhizmejkLPDuHsYtpSX3YHnuR2lde0ca4O+Uof/AorycqAvzDJ2SOBRFqcs7LwhCEirIjH7owjvwrIjugWoGXbenQzzJkW7zfFKGZIuWw9fbyVMSiUOXMkP9JD9viG40OHsTUBMElbVcLdGFL4aelZoYGJ0WDh1IOszbb+qMcQdZdlgEXjTmNRoh/x6kRbpLtab3oP3ML6jZeYbtuZVvwSTVvmPHoA386Y9G6trtXS1AYepOwcsi/w2aB1bXqnb+ImygTvZc7knBSK56dC1LKmByh3vGVwdjqi4KRgBA6Fq4fpFIUc2p6SqaCjzj8NOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bHrKGhsSEo9ZMdBmr9kBt8oBeLt+4n+4vdknhg7g8w=;
 b=WzXoEtLM32fJWzmxvnBOi5RzjSRWQMhk5mH1057ZOHphGvDxwXjKXKehEWBt6qeEvTTOdnwuFDVsmRuaxkaMr3fJshSonf/fl/mSuHsXTcpHaOB8+eKTlK3D1RRvEqCKr2EPTCPPCTxbS4FTvrgeoeuwHlOWuTzuzFLUcdmFY9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 21:34:04 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:34:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] test: env: check that non-mentioned variables to "env
 default" are preserved
Date: Wed, 30 Oct 2024 22:34:03 +0100
Message-ID: <20241030213404.2894247-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030213404.2894247-1-ravi@prevas.dk>
References: <20241030213404.2894247-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3201:EE_
X-MS-Office365-Filtering-Correlation-Id: bff974b4-7ff4-4874-14f8-08dcf92a93f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U1g2qvjsLjHSa+3vyFCw0HrLIj3x6EFip2R1wJxhaEU7mfPnfzFDQIiMw8JD?=
 =?us-ascii?Q?icvRoh4NmPnBTWgHth73QN3eDBGawUgPfNSnx/W1xWvy83h58vNt3AqwnEbS?=
 =?us-ascii?Q?5qiQtgZQr4ZLpyV/hEDIBb/yoGDA72gyDngd6F2QoH+271uz+PxCHIAcnwyI?=
 =?us-ascii?Q?SH3t3iTD+pmxiS5chcr0A3BFBAgJQMXFawrldl5dbjV8yJoS6uOsCqlwskly?=
 =?us-ascii?Q?SjfMB0rMi4yyOIczaIOd6Ziw9NWH87MDivMs5KWKvP2+lGmA1aAdwWbMWDih?=
 =?us-ascii?Q?gaRYFeO7hFaSXzR3sLqZHmUVUJj9kbFk328rLPutoq1UKZuiDDYc18RBFoiE?=
 =?us-ascii?Q?JuVHi8LRckNkLV4WEji1OXBmDDd0n8gFCg1imGSTd41DJIvRNNWmaBOLh8so?=
 =?us-ascii?Q?hObf2tgoXhUg24D33hsYBY0CJ6/HUwheRTBK4+OGitxbRnBxbx5a3kt/DxrM?=
 =?us-ascii?Q?L7ywZCs8XGmTGJ5p8WpoloBC08PrtVENXOa8z/cxIA08Swc53Qv2bsi3JfGE?=
 =?us-ascii?Q?G7i+NesJAhEw1K7pMVUBUzFKR+O4eigpM6Eldj5Uj/5dU3x1vDWtaFebnQDz?=
 =?us-ascii?Q?3xFBlHNXWiRgVyIldm3F9s6TICbCRIJ7uyXn0bvdFBGPdUBLjoA/eoyOflhX?=
 =?us-ascii?Q?WKd+pK5XXqLq7ngDqh2Qhi8PfDx3PpoXHOBDrEx2V1MVme5holph5pQ776W8?=
 =?us-ascii?Q?H1xmg4c31xot8tbWxteFoaOZDucHwPtGyxsiHF1HHTpkswWfddGJCjUZDoIE?=
 =?us-ascii?Q?+oTOB5tvW7QUJSIlKBvgrlACRkWuvngl3jB65+wDZC3s40XEXyQuk98XRxgw?=
 =?us-ascii?Q?CwO3RFtjlcdtOEvBTyAcprEYzeOZTkRv5VSRCAuit/LhHnOfG6bB4gIS1Uhm?=
 =?us-ascii?Q?UEEd1LSKRuI6dcNS+6WCykxSwXVSbUCfho8NUoh+DFF9gyyVs2Ue/s2tO25q?=
 =?us-ascii?Q?etPrw5Vkrqwy9CfXcGJR6VxJv0x+KR9wWc5JrHi8J7kjfTDrSyZaTTo/8eIA?=
 =?us-ascii?Q?rGY+8+EyPiXUlHhX/gCCK52Ne60o+mg0hjkdziWhuDB3WxWRDotvK8kP+9BW?=
 =?us-ascii?Q?IVfTI5cP43+nfoJCiRbLcIX4yNL0wYBip3feR9tANXMvWfK89fYkyGDbzT8R?=
 =?us-ascii?Q?XeMMo4Q7t/+N2GkDa8toNv2DO2gOE7e1sIU+Sxlt3c1qoXw5syT+PF0jnvef?=
 =?us-ascii?Q?Dpd2dLuor8r4SgnyjnGnE8SLD31d0bEc5sKOgf6sAZ9ixD4rUDJHFD7FNPeL?=
 =?us-ascii?Q?L2jrQtFl2cSdgcvwde9eyHzOQhPEJEJYj7kGOkAezdoU0BTqmVDvEt58tq/o?=
 =?us-ascii?Q?t7vE60x6qS5ehXjFy6hIrfQtax5sKTSUjolnOtW75ZqaJFpVNUGcquEb3qdl?=
 =?us-ascii?Q?7JKCew4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yn8UClV7fpgaKTjlNovCOyecJ8+vRggn5/+EHGRCeqe0ZpKvJ2JCDTbNu3v2?=
 =?us-ascii?Q?tw2G7XMxS844iw+EJAuJ5+RK3YrNIPUo3JSo5ZQhYKPoq8/3pS+uvlwnbGzo?=
 =?us-ascii?Q?+FU9B1lvCwt+DXHes8E1Mb8GR5zFfP1gv9G9h5Tup7GJdivWkdsGboZFBZHn?=
 =?us-ascii?Q?BfO4odNnZ4qKiq/sVq6ah2LiWdEquIg+GAHNtnNkfoTIchCH8bpPwHwoXeTa?=
 =?us-ascii?Q?h1isQXpvAT9WdR6UZVSC4WIVzN3KhWhwFojufSV2ivfXB43j4t1i89cikihk?=
 =?us-ascii?Q?5perNLmW/9nVVnK7CtwauRnetVG0RenfMSyX8EGI9rn4p889SlLCFw5SRiWz?=
 =?us-ascii?Q?mewQsOVg5BPP/REkMouB8qOjm/7XcVMuZ5DItUWir/5BQaFtz5ViWBnM0owo?=
 =?us-ascii?Q?vL1uvfIJ+fUMQySHxIMCsT5GACXzYcjAwODSGDJSgisPJUuGNfMwXNmQSkUh?=
 =?us-ascii?Q?vas7DdC12NpQLLqUGKN1umhdHMznUtEKE4zRgzYM6cHTHit0DbpDUUnbj/aF?=
 =?us-ascii?Q?dM7NzG1dE1r5js87OLEfPkqfzDeg4soNbEgJgBRFy27ipcoJh0TV2iAk6Dcl?=
 =?us-ascii?Q?EFpUyYiCqsfGwcmg6ejoY5cZToDkuYJZ7rH16brjFTavPMUVguaUMmuc6p7S?=
 =?us-ascii?Q?BBYdVtizjZ+cOM/gYDFhJbV1afT8xJ2iaYPaeXJI00LLTuN1zXOe2aoA2qEC?=
 =?us-ascii?Q?4iVo50p8n68j5+SgD7CYF7DljSUUJ6PCDJXyT2UtV45vpFsNyGKsIHK9Orgd?=
 =?us-ascii?Q?q5kcXzWdVCY27jo0tr4yii9zA5P7atqSKLXQx8C74PUi4vZk2T2sFrO43FqA?=
 =?us-ascii?Q?Lr/FXrH/wu3vuU8DL6BKe6Q9GJ5CYT88yezL4aFTaAy/ts2leJlIg0P5H04d?=
 =?us-ascii?Q?wQ6Zt2C/Ph7ENOUv9JwV8VHMLn/aB2ilFdep+e7840dRk0N8hhhpgYnGTluj?=
 =?us-ascii?Q?dswbwbQn4ByD0h3TB3e7z4rQ+l7CudUOyYzm79OFy50cR366m1IKzQa7QepV?=
 =?us-ascii?Q?1udy3EO5ZLpx0N3YkbOZ0IU/hYHQO+ndcJnVroGdUvqAPqrXKKx+CSbq3+Bu?=
 =?us-ascii?Q?ybj+995+NSRkqElFckYzaP6cRbXUHevQW3k7p5OSQal9OHU9cvExWGWe3Avv?=
 =?us-ascii?Q?YQqrzX51YSsLZociaZwiQhs0LKLmVTM986G8GncIxY9JKpzsJlw68/ya73o+?=
 =?us-ascii?Q?NiBv8qCsfumy/wCJnPWK4/Qz3E9SWaowviKWknmWBStA04FDZMBlM5XrZaS8?=
 =?us-ascii?Q?PY7lQWsBiU4M7WFI0C60Kx3ubzbC5E7M2aNi9NUQHSndR7li283HuknQcpw6?=
 =?us-ascii?Q?WhUwElR38kkpcF+h1LgCx2vutbLMRf1wZI5vIQfsqKezEaCP2RLw0VPYIA/m?=
 =?us-ascii?Q?biA6I1fGYSVgaQXZL0ty9eES/u2DjfYkWSdn2cgvckDlbcdxGxZa0NuTiU/I?=
 =?us-ascii?Q?5ufMA5xmwbu38XJ3v1P5xjNPu1yK3sFCX4rUjAyAlCceny3kBC2UChXF/0/i?=
 =?us-ascii?Q?6C2MNoTQtmBGFFm8eyDB0mFK7YXsNQhJuKs9X9Xfte11N+RoIPJuC/8YgFVm?=
 =?us-ascii?Q?Kneh/tRCbAav9M7uabvEFPrlj1+ElpFKk28HghgrPwVe2S0ipXkklEwWHbgL?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bff974b4-7ff4-4874-14f8-08dcf92a93f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:04.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/J6ekT72A6bCIlP7UIzdlkFOmt+fFls8wUTV3JqAxthT3+QyAIThaWRTfJbgzZCONp0tZUKoo2AG58c30/7DsH5curu3PvmdbyWAFSMQwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3201
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

Instead of testing the same expected behaviour for both
non_default_varX, test that when var1 is not in the default env but is
mentioned in the "env default" cmdline, it is removed, while var2 is
untouched.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/env/cmd_ut_env.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 4af05764fb8..e1dd1a14cb0 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -14,22 +14,21 @@ static int env_test_env_cmd(struct unit_test_state *uts)
 	ut_assertok(run_command("setenv non_default_var1 1", 0));
 	ut_assert_console_end();
 
-	ut_assertok(run_command("setenv non_default_var2 1", 0));
+	ut_assertok(run_command("setenv non_default_var2 2", 0));
 	ut_assert_console_end();
 
 	ut_assertok(run_command("env print non_default_var1", 0));
 	ut_assert_nextline("non_default_var1=1");
 	ut_assert_console_end();
 
-	ut_assertok(run_command("env default non_default_var1 non_default_var2", 0));
+	ut_assertok(run_command("env default non_default_var1", 0));
 	ut_assert_nextline("WARNING: 'non_default_var1' not in imported env, deleting it!");
-	ut_assert_nextline("WARNING: 'non_default_var2' not in imported env, deleting it!");
 	ut_assert_console_end();
 
 	ut_asserteq(1, run_command("env exists non_default_var1", 0));
 	ut_assert_console_end();
 
-	ut_asserteq(1, run_command("env exists non_default_var2", 0));
+	ut_asserteq(0, run_command("env exists non_default_var2", 0));
 	ut_assert_console_end();
 
 	return 0;
-- 
2.47.0

