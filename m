Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6EBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A553787A9B;
	Wed, 10 Jan 2024 10:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="FV1t9XYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CED087977; Wed, 10 Jan 2024 10:10:55 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D2D87AB2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLIXlsclyyFkTkVjEBhPAOVfhY29fXF/pbbZCX1vnL6B9F+sZkDyJxpRYa4NIqk5v4DDQg9QimGxzff/jBfE6ElkHuLQJ0Kq6p34eWD6tW6QSuEWs4d+EiCA013KXI3QdvlpwncjCu2A29tNORqbM3dyGUzosZzUXNpjHBRsXupQ+ON6A086ixoIPBIzV6EnXc7jqsT8H2KiFeGfMU3/X2DnoqAEXW2ff9h6yBLS19rqbT48d6F0kbmNlqWc9h71lrZT+cbRhFB7ShUehF3CNnq8bD+gjsTaCsNZqLGLOJi8Vo6bNdHgWZUPjFrMfZ2LW4Lf20Po7FqTUR1MkFwrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAcslnkT1kWp7jitCdoxtzwu3fower8UhKt3L57W3Po=;
 b=ISX6O2CicZggUkKZ1NBUvOFevNhAhcxQDZGWDywsTSPOCbVEXqJ+zBUBN2swlWgIV+oR9hmtjNWujpwknADFtYb/aApq0Tj641dtbAR3mm3i4uGSUYuUDZClxmlF/esLu7BHjo03GqSZXWMXPObS/5bJhLWFjH+yAMo0ryRImYM5BLCJLifX0/nApOjazQhgi1DyRpE2X/VsddM4nNttX2NRE3TA1JiGnoLpiaphi3DxhKUtkacYIwKAQbflzlYb68NQj20x5hsz2vk6ZPOgwLzswlMpucEfXymdnKIy4raRkDJHeL6fUfSVwo0p9nQweleyQNyphLjz7UqH1Iwmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAcslnkT1kWp7jitCdoxtzwu3fower8UhKt3L57W3Po=;
 b=FV1t9XYRtVewqXCZUlCcnPLjsA+MJT8CoGTS5e4bhHCI8DWaIu8iazoX+O8bGbKzLpF3A7oPdRX3VaYQL5QGx1sY45U0NRbsLvk0kixYZcYp9uN4YxLu1qA4d7A4hL6Bl/ovDmKfc3vm1ObikUb96o9qo1Hl/g80doDEbBO3njg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:52 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 09/11] setexpr: Promote 'setexpr_get_arg()' to a public
 function
Date: Wed, 10 Jan 2024 10:10:35 +0100
Message-Id: <20240110091037.392520-10-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a5e1ef-f190-4282-7188-08dc11bc0a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIH4gnLdnYExa6lSiCXgsdiSYr5psLGQoRGtMiAae9VVkjV53dOUhYQ/bPUHun6doGCrSYZBQlNUCGaElqZUzIDXhk7ltWfC3xvkshzu7aLCMhqPJttrKbchzO1UcgVTQHE+SQrNenifYKVKVgeW1/XcZkND0PRnh7329tjkQaVqC6RVXTsPJLuKZHpaRszD4BZxB5IlzzVdwF+jn9ldhR+rZsN/cxZwz3KFxfmoC55zICuqs4znzLnS94B7MbyJ4AMDqcAoA64hNG2EBdTyRsiumxQpOihRLj25UpFfAXyKfzJXTDnM3EsjknoeZDqDjeuR1GZOvuH2whSnDPkCWz6x+Wf28AJ1RyLTMSjOX2AkDO9iKjosE68fhEczEle7LQ/lWV34XkpW9Bp2qNzHZnFRvR7Py/RBl5DjmKLPf5t0TFvBGfrQxd+UGIBWzqGo55+EJSJODcih/M2jiUEAm6YlQA5fhyLummp+NEFpueTNch9fDb4KGJsJf9dh56R33j1rbmEJG9664ZghZiLNYIEnuWIQvR3xIAGnFHmE/2V4VVJTeYjKDidYcbjKDXE2q4IRnD5lQv+B8OMVDA3Hn5O9yOD4yhwGg83BWJWReDlizA9gQXqdWEVrzDk65dfR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2aqgMaeVTQJI4ol/QaNwyBtrjn3VumqMNxHPn22N6y+4Cukp4HO2ZqXQVGht?=
 =?us-ascii?Q?u5sdVQHMYFxRycQFELrkoHGJ1pu/ZCUrViHgXV7YwIK1D4U5Tg0v3An4/gAR?=
 =?us-ascii?Q?72wj4wEpPBrYX6MegsVNKUao1Pzk4o/67GFEcu8qPEq9wkCz+8ROxuIstyhx?=
 =?us-ascii?Q?qBf8aOZaHJY0EQXiDQm5f3xLetFHL3ENrIr0ciIQOIKVhzf0yf1giwV11lLh?=
 =?us-ascii?Q?FbFJtrY1gKNbdeRVkRfjyDO73oUAuib2BggzSdYqxCkf4VMffJOht70FuOf3?=
 =?us-ascii?Q?oL+YCs2MHU9rSknMdj2BR6l8ZUgAvvY2s+LgX/iNNvahY8fIuyb3tDN/jVW7?=
 =?us-ascii?Q?Pfybz9C7/AluFwcSOlFBmGmj4Whvw4s1CT5y6Ajpp/idNMUiGI0Sw5Zn+JAJ?=
 =?us-ascii?Q?/lx1g5nUexCu5KOAbC0hbu0m5fW31K99clXvTurGOH45GXDdLF7moSzDhKvP?=
 =?us-ascii?Q?m6RzQajTPsmMYdLBhLTOO5Y34AoRWG5P8RTYcEJ35lXYH03aU+QGYgHyELbl?=
 =?us-ascii?Q?FoxTEIGwkRmeaB7RhiJTlyO8o2MF2PYZqdvwbZZ1HgPOl8zxkAl1PBocGOXq?=
 =?us-ascii?Q?B7e+BWsv70t5dF3g2hPVoJ0sORS++2tuKpbsNFk/toLY6Aiv8qtiTufJ4GpT?=
 =?us-ascii?Q?F3KhSrC6Kfs3XKU5K7aDYlpSOf5vrSfHADkhsOr3nKYiyYtWqLz1W0Nchnss?=
 =?us-ascii?Q?pHWCoOKtaRHntcmQZDafmiugzSf879Jx5XEWOPF7wZlHGxBFuhZ7GjVfWHxx?=
 =?us-ascii?Q?q2h7BSmn47HMCv98MP340hQ6p6m6+9F0MuZiB764qW2FsTEQsA40/lyjCsts?=
 =?us-ascii?Q?MlFgzTSAvkJdOImOy3UEiWMJzjvP/nmq/8TO/rngBwOYNhu69ybBpDV6bpnl?=
 =?us-ascii?Q?ekQ0jdryql6bhU+x7H7QxLdlIQbRr+8OBzZ6uJP6ELcwfNS06RPLAl0Wwnzq?=
 =?us-ascii?Q?TIlzzF4fPKQHIYdFn2ES4Jz+7zejLxD/A7TAFUPOzjvAza/awVdtbrGLi971?=
 =?us-ascii?Q?pSYRvY6j+FJP3olKmrtkoeNIIxm0+rUsCcf9yN/vqPk2bX8x4jOoBdAPPk0P?=
 =?us-ascii?Q?sAReAtwOrGbssePmt0tN/cGmMdBVd2rnaJSTtCkk2nzGt9rfXeB5GxalWCaD?=
 =?us-ascii?Q?/ohdGE4S3g0e2qemefiMgUYRl4ES6qUCD7u4rg39Uf5sCHr4XfUd/JK3fWMj?=
 =?us-ascii?Q?ZY8uB/0uV24tFkLwy9ytCAXm22D9RPDHupkLNhZUsjDts+v4PSCqkAuS49tw?=
 =?us-ascii?Q?CFEgewy+iHrMen5/ShKjd7leDktqpFBufTuys7bKsge6yBiEL6gFhtqSOj3V?=
 =?us-ascii?Q?V/QCYHSRVEjDQzYp15vH6jNpvTP8v52dbdAERoSPxmY8R/IiOV9i84qDW5qE?=
 =?us-ascii?Q?LKJbwzzrGCkfgs2UtCR0OH5/QqKi5xh+FCIgCy9vte8+kPzLCmoY9py11P7t?=
 =?us-ascii?Q?ACQToPyVf39o1QZFgtojAL9wBgWVOc4TuhZ0CJIvM61FW+Vc7AyKtPWzmU1E?=
 =?us-ascii?Q?K9sL8lPVMlNPI2oXC/+u1CuBMULBBqSR1ZBdyZINpCitV0jbJYEIU+MsZNh8?=
 =?us-ascii?Q?91kKx57RCl55VU0+seEMZF1GcRl/2orBbSoZrDNzSXQ5iZlg7RuEO1x0KuuV?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a5e1ef-f190-4282-7188-08dc11bc0a89
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:50.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxYLShaCGz8MRRoSy8k+S/RrHvAVVImH34BfU/Om312gns3t9pUiFXOGUus1obFcEq+SKO1W3W/nGW2pkkgV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Promote 'setexpr_get_arg()' to a public function in order to use it
from the setexpr command and in the printf-internals.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 cmd/setexpr.c     | 15 +--------------
 include/command.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index bc57d41448..9caa68d20d 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -21,20 +21,7 @@
 
 #define MAX_STR_LEN 128
 
-/**
- * struct expr_arg: Holds an argument to an expression
- *
- * @ival: Integer value (if width is not CMD_DATA_SIZE_STR)
- * @sval: String value (if width is CMD_DATA_SIZE_STR)
- */
-struct expr_arg {
-	union {
-		ulong ival;
-		char *sval;
-	};
-};
-
-static int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
+int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
 {
 	struct expr_arg arg;
 
diff --git a/include/command.h b/include/command.h
index 4cec634545..d0aa98b1f6 100644
--- a/include/command.h
+++ b/include/command.h
@@ -248,6 +248,33 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
 		      const char *r, const char *s, bool global);
 
+/**
+ * struct expr_arg: Holds an argument to an expression
+ *
+ * @ival: Integer value (if width is not CMD_DATA_SIZE_STR)
+ * @sval: String value (if width is CMD_DATA_SIZE_STR)
+ * @bmap: Bitmap value (if width is > u64)
+ */
+struct expr_arg {
+	union {
+		ulong ival;
+		char *sval;
+		uchar *bmap;
+	};
+};
+
+/**
+ * setexpr_get_arg() - Converts a string argument to it's value. If argument
+ * starts with a '*' treat it as a pointer and dereference.
+ *
+ * @s: Argument string
+ * @w: Byte width of argument
+ * @argp: Pointer where the value should be stored
+ *
+ * Return: 0 on success, -EINVAL on failure
+ */
+int setexpr_get_arg(char *s, int w, struct expr_arg *argp);
+
 /*
  * Error codes that commands return to cmd_process(). We use the standard 0
  * and 1 for success and failure, but add one more case - failure with a
-- 
2.30.2

