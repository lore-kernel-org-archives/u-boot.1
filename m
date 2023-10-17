Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4FCDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC2D86C2D;
	Tue, 17 Oct 2023 14:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OuLfPmsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C40486D4B; Tue, 17 Oct 2023 12:53:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52FD86D4B
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.kubik@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo39c6OrAXXfuBOSLshQ2yns+MLzAQjwpbpAey6DD8vbqcP/X/1XFK/xPc2f30T++J19yonTijgcAzARYV7ytdc1xADhQkXJr70wxq0IGxWq+U1E8cNekMTYqlxLnHYLyhRxRig7y8lgSR/NUyA2de6E63ltTkTXzc0W9O3J6d13Ll94H+TThMJ8ptlLtjzwhYwns/RQhYiR93y+8kP/Zp5bBqf8761woINn/Sf9UlDOtDvnHZIWFihQ9JSKnE+lhQ50BDcVpBgbmacw00bPQ537JlplhEPUP6wt5FG00XNC6VOTEeQ4OZmCxEl3H9V6MZtOuxic9+NZK1l1nRSziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjm7xPAWV0jMKvvUSHrCAfNmOsb0ACZAElAm3qiMqME=;
 b=PLuEjMLy8fcLJ9hK1zwuLnpZIAKyh+RWo/IMDl0Ru4IiBzVJsrtpoxUWeySDiBCm11cZalLIN13+6O1kRslAsR/erK6W4KW6QT0enxaJZJpyXQ8aUC6R2XZa+GAqbSQy6kJ26ZKSuEqPuGbbMZqgCrM/9tp+KBvCCCZPAuUZtroxBi2gnbRF7+OPHeZIRIIwH/FsFmgcqG/TB/i262j0Geun72BwXKGQSTw3R1I08Rg/KXaCgDFY8i3/JJMRplmMA4ydficfP+7jvwMCn7pIWLNdWU850HyeGfN/534waQF5RybfX+EDeYZjpEB7y2Ys9L3P4zyNLhmFjvW51ScmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjm7xPAWV0jMKvvUSHrCAfNmOsb0ACZAElAm3qiMqME=;
 b=OuLfPmsbclpkeS5AQoZapzbxypltqo/nr7+KZ6a36iA34g/4bQZokMN8j/ZCIknOhXKYFWCe9OtRJwYIXze23/DEkpNh8JrcIZqqHVRs4J4n1xhZXtZJdqerDlb/+KhZuEKzOIZLTwCRvLNaCunlqHHn2oMpQjitFDlAzsJB62c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by AS8PR08MB6632.eurprd08.prod.outlook.com (2603:10a6:20b:31c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:53:15 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::1552:c563:b67c:a454]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::1552:c563:b67c:a454%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 10:53:15 +0000
From: Piotr Kubik <piotr.kubik@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Piotr Kubik <piotr.kubik@iopsys.eu>
Subject: [PATCH] bootm: Fix flags used for bootargs string substitution
Date: Tue, 17 Oct 2023 12:53:05 +0200
Message-ID: <20231017105305.417338-1-piotr.kubik@iopsys.eu>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To AS8PR08MB6806.eurprd08.prod.outlook.com
 (2603:10a6:20b:39b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6806:EE_|AS8PR08MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdc86b6-091c-4e3f-951d-08dbceff43d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFK1MQDQMDZrwgHHs6RUffJY1yfPdk1OF/KFecVJoddaTtEkoAXpInfbX8HLorjho5WQRaE6Ol1/bIUWJPHnqwhdWXAFZdA/o5rOcUp4SEEJ8FK+BJ3nY0aOZQg+5XMeUjok9K9wSHa5RVhvHMyXntuEsxTfcprEjUE+efbVC768BdvgOP11dQH6w5sud43gUMLCr+L4UPB7WuMh0EKYPNsFIJzcgHhLM+6vyZaYRUVPk0fSGbYswIVpE0E+MzIUFdIprXBftu6WnHu/A4JQ/wMnDHXexiMbhdApGxFCwkxBWf1a6T4TgwHyYNXHmbOTf4R0cOeTKaZQUSzQ1i/cqAk/MBHFmbbe0+T6oozZNQE+yg4LK4u1jDFEzQJDDudX5uX/sIqJ/eSpcZ7HCJ/gddPA6pjALl7zJEp2uTooDiio+ivQ67a+hhjHUDl/t9PRb8mkuc2ZfyvWRKeI8y/lFW32l6k8+AfDOqEcGHyWE8l+iWjNPaBXn51BETAppJ5ETGfXN+lZvn/kOhSQf1YUG+wYnRSL/b7klSxfsMnKyS+Hli5jG7rwxQyxLc+KpcLqu5+Z7/7+U7ftox6nQ4mKuio5X3bjfznRwLVNptz8wVnmQtS9zGaXC7lK14fKSgBU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6806.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39840400004)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(1076003)(478600001)(38100700002)(52116002)(6506007)(2616005)(38350700005)(83380400001)(26005)(6486002)(6512007)(6666004)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66476007)(6916009)(66946007)(86362001)(2906002)(66556008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avuQkkuC8ANF6yZEr5FDlLMtK/9faWRz4fX5mTA7y+APqvXqHVi1Nvh2H9lY?=
 =?us-ascii?Q?S0W2Bg7wGvtjyWLHRa+rJftnq7DOUN3n0bCGQOwwc5XJZXSL8RNeECWfAcst?=
 =?us-ascii?Q?8GeQW71jou43wFHk/kBwmgMemq/RdyD7KShmoE0IAfAvMCXg3++IN9PybZ2L?=
 =?us-ascii?Q?D9g/XZkIeami+s1fCa48cBAKxZjwom3r9pufVomyK7fFw62gde1Xt7/Gwsdi?=
 =?us-ascii?Q?urVYRMLYSjRCL+HdfX0ZMDuyxhncZN25qCAuKTwJHSI4+7W3icW6hJwtfjku?=
 =?us-ascii?Q?S4BEbDke8OBZLTkeL14VCFsUSB9X8ZREDiLZKz7dAr9FS+1QaESj8en7upxk?=
 =?us-ascii?Q?xFAUe2jGS4nYcAORtJlbvJZC/P7YrFQ9Adn8PY0+F/40oS7MN5LsL55YS47/?=
 =?us-ascii?Q?yup7l+dW+hGlmwZEUQzVF1Jr92wNRSUQtUhrI7sU3u3Qwmdmqlbv4d1q4/Zx?=
 =?us-ascii?Q?11XjF4O4+Hm46zlZzB0kEU6IljVOOknbWbnng8h0GhEd6naQjBHH9dyyvy+2?=
 =?us-ascii?Q?RmbqXGI+4ccg1T4vkFQ+tMguYQw5aaLVIkimuS+fSPaZBMBFrU8lcnElZQpo?=
 =?us-ascii?Q?eKkgJ//DRqvIVwvUch4rafiYBwertIJ32jrGxzDHZ9XVRe1mOG4hA7CowZwS?=
 =?us-ascii?Q?FiMQ01LQF7X8SQbExatCRPiFNVoMrIwtB0Zg6fpu0pjHER88TCJyL6atrfp4?=
 =?us-ascii?Q?LhMUmeSy+wj6u0lQEF88HNRGuw4R2ZLMJPIOXln8ZbtHiLZdmV3t5ZnNQn8m?=
 =?us-ascii?Q?M0YXWyGHIAqcAcWdnHA1h04wRPLX94TYdLKVbkaVGIV4uqwN0XuMe/5oDURj?=
 =?us-ascii?Q?CYXomCj+1MMM+6BNRTj7jPh8Q6RooSgXKrtIK/zjE0hh3Jr7zwXpUt6DNfk8?=
 =?us-ascii?Q?LWFIQB7KHkedg3Xm6mnj9TZRRuvaJUIFLEedkT0QEdRhuwq/z7lAmp9wgc8a?=
 =?us-ascii?Q?Bwc3+MU7PCgugqvwGZCQoMjCxZz7MHHX+uf161vp3uOjr7mMoxoRVH/Hl9Zz?=
 =?us-ascii?Q?HM1FgPiEA9vTKuOmGxRSIheZsw4KQMkLl3aZoVYqu9ilW0pQ1dSxdABrOr/y?=
 =?us-ascii?Q?9WWLVYFFY5F/4x4DAoBT82Ocg22Pws+GCscGcBuQ8emmp1WMXZp/ZGFloRaQ?=
 =?us-ascii?Q?EqKRYJC7tJW2pNpJE3W94AjL6yxVHLpJ49DNlfKEVFhU1Pzi050zMIA0BwvB?=
 =?us-ascii?Q?ah4uR3NBfcein/7qNpSbezElNdeqw9GfPafb83wmSGl4WU++vOzG0+Y72Mvu?=
 =?us-ascii?Q?BgullLFX9bN+xpg2+zA/gXTsprDzBWz8pD7m2/o9u37oyHTEevJ5BlsxIvqT?=
 =?us-ascii?Q?VAt161v2D1sm/fYddJ6A0UbI/s6KRbSlPwOUIVWYtIZaBEyFe2OdXTICbhbP?=
 =?us-ascii?Q?PdExkcwAKhNX5PAEonvMjyyefpAQwG3PO63VzVJbUNxKRQ55cD3YFN+RmyoK?=
 =?us-ascii?Q?1a4Qe7DrIeFwA8GStUTozZexdoCAwLFe+8pdY0GrH8veW0DWO4xVIpo8rNpf?=
 =?us-ascii?Q?wIKGpdh8lBmCjSrd7bV7uSaSEnQueGNN/NpIi82MthBRMOiGh05uCJ31n348?=
 =?us-ascii?Q?YKvTwC9ztvv/HpjYJwWDM20Y4Vs5NqIAvt0wdJ4r?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdc86b6-091c-4e3f-951d-08dbceff43d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6806.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:53:15.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCliztb7ylztrjhJ9hyYiB9g3jlhSrEySLAWsHQ/rN3ZfjYYt4GFUxLN6eXmY8HCLYR4t18pdr/75ILMmveNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6632
X-Mailman-Approved-At: Tue, 17 Oct 2023 14:05:14 +0200
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

Commit <51bb33846ad2> introduced a feature of bootargs
string substitution and changed a flag used in
bootm_process_cmdline_env() call to be either true or false.
With this flag value, condition in bootm_process_cmdline()
`if (flags & BOOTM_CL_SUBST)` is never true
and process_subst() is never called.

Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
---
 boot/bootm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 8f96a80d42..e96489e549 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -778,7 +778,8 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_OS_BD_T))
 		ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
 	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
-		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
+		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX ?
+										BOOTM_CL_ALL : 0);
 		if (ret) {
 			printf("Cmdline setup failed (err=%d)\n", ret);
 			ret = CMD_RET_FAILURE;
-- 
2.42.0

