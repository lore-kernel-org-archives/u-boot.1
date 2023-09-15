Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B872EED61A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 17:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713BB86571;
	Fri, 15 Sep 2023 19:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="I61jD3QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E648864F0; Fri, 15 Sep 2023 19:51:07 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B121A864F0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 19:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/AjmMyqngnoJMVZ7ThlAf05yUg1JgSnr5mPCdlev6AUz/dOouaAuCsCQM1VXYWuvp2P0XFBchLQ33FTUJBRgBpAZfVKOb61Clf+9GXuUXBsiy4LmedqI1cMyM5OthlR63DnDMgssOmRb+nNCUNs0xPVZIkOGnv5y+CBjMp0lGtBQ+DJTvYSeCRjLFYEaIwVZmM7eJkn9Iw6D/SSRlJ22lVC12jQy1fh9vo32geNcbmPHTMLvLEReOSf+bQome5E0luxxDZQS9lY6yL2BxQWhztHYigDAI8DURsr5Oj0wUUVLXV+LAzovyXJVKXjvubwlBl1idzCb4q/nswhBJ2bvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV52OpricRN8gwKIRMJtWM8V1M4lQKSUQqOCippJivM=;
 b=PENk35RBrvbBc0ovS094+5ZDaZVPnJa/aNifD47PKLr27zH1wPWXnLygCqN77/e0fgXUDXlp67SxZAKc8Kp5C11OVgvX9L1lcMc1psP3/8D0UmoFfiVn94FhoS6O0DXBNdWgMC8YFz+XlKN4bNpZGHGoeUxgWJNfxsrJAsyUTzCVHgBUSq1baAxPWpTupS94f+L0UqM9yJRola67s1nZhFmLUcXNdUmmG7uYWoGJdNVIFQEWgdJGsBmCr/KzwXIj6bB0PaL4+RpUlQ9612cqlxWByfHQSh7CRxVLU8bogojNJZ/U2dMUoq3rYjhBaQ9yBwyeclpY+isOVMaZsBHFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV52OpricRN8gwKIRMJtWM8V1M4lQKSUQqOCippJivM=;
 b=I61jD3QWuK08tmhrA72ZtTyVLvaGTpdcu4Y2d0j2TVnP0GsN9bRFolDKcDLM8kLQj3n1BTD3O58ZWgN2qcikz4vmdjXs47crTtwGLCqmCl827RooJ8dVMBO/5IRLiMH/r5Gu6si6kc4lRxxVgVzSJJUW3mto85AzusMKyE2lhdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 17:51:01 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 17:51:01 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/2] malloc_simple: add mem_malloc_init_simple()
Date: Fri, 15 Sep 2023 19:50:50 +0200
Message-Id: <20230915175050.4109711-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3970:EE_
X-MS-Office365-Filtering-Correlation-Id: e4893a19-e6be-4249-ddf3-08dbb61452fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85CWyk42w6cY1I9WiJDKFeGvxQRzhwzxQDvXHOoHyk5WiKTliUGNKeQEAwTbCRO3mYqmAsXuZxeZbxVHAw+0+CbJ+wgfXwyJeNGUfB9GCl0bJQCYOooGMLV9WlIKfZahCRLokmQXwuKqRNSOHQ/tajBBr5XzjsM3KRPW4nmxq/Ok4dtAn+b0iOD7LutG2ZAb552IAysnoXijVKhbHCZuj1viiivnLyhzfGdTN8WKvyST+fcVdl4w8yPIBjBVUk2x/qUb5eVKU3N1jSO7L8clKo0M2wmG4EBfmc5LtZm74hjWj9z92PfZAQh8OpkYq1FJxzD5RF3U5ymRuYe/ctMVoNUIKsWzMCNe9I/IXNEd0helietOTtqEA6FulUUNWNIu1FZD4U35WJ9ecM9GENSw8ksOl3DY/+VhgBORE20me6CaiEs4HVfQfLbOI9ueTJV9mlTBDwoyBSydr0tYc2nV7X5RSvYl8srMgvN5ukJA2kDPLeaZz3F6iAuqIcxSz4Fom7R5lWlxwu2pIi4hlfU3vjNNG95IR1IVLKcaPBwIXZmc3bTbzyE6W0Ps5REKs3iNDM18wmwBpfRCr1cf8OpypwW2aCPlP18ngRmmAQzPBlB+izUz7jHKQdLRgWuHhNi9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(366004)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(52116002)(6666004)(83380400001)(38350700002)(86362001)(38100700002)(36756003)(2616005)(107886003)(1076003)(26005)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(41300700001)(2906002)(44832011)(5660300002)(8676002)(4326008)(8976002)(8936002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocelbbx5VdzsmBFnXH2wUefGDf9JXHLVp8wN6ioc84ZZ6yEzg4yFM89V2XZV?=
 =?us-ascii?Q?8OEfgE774MhYk0wmYJmRFjKzNIjM4d6a5QoaO1wAJN8b2lT/+G/OkFBPd1Ez?=
 =?us-ascii?Q?RVF+zNPVwV+YTgEsQL538owyTdNK21azr7YCafwqD/ye4l70fH8pMqHudVem?=
 =?us-ascii?Q?FDMUYpecqo6NgcBvMrukOlw2cvKFAL30gvtvI873hu5/fPtZSCJZPc3x9ciN?=
 =?us-ascii?Q?e1/MG6Q2rjUXeYIUikx1ak4fG1HjUbLit8+oQ+ICjAOQHgcdV2gQr10W9vE8?=
 =?us-ascii?Q?JacK1QNw/rNV0SzD0dCOWUWHhk22uZFRqgu9UzZ1iLP46rps1jx6Bkv1g+h3?=
 =?us-ascii?Q?R+5GRAOHmjyd6Jc4c3dtUMOEhbGWjAnXLXd+NMK1IpXAFw/WRHFkbHuxI1e1?=
 =?us-ascii?Q?QsQFAEoftLC9UOqCS8QpOLLx6X/y5FF5PLw5291+vTL3/Apeo5exTSQTIpXa?=
 =?us-ascii?Q?JivrtnpkUE9qNwYK49D0SFel2lnKfcMySf9VnnM8ft/aYt+DN5pYiQAIUnAA?=
 =?us-ascii?Q?h35L9jqXkQI7+1IThlVH6+tt1oynLV7ncsrcTWXJ/Cmb9draKDGJ8Zva7sr9?=
 =?us-ascii?Q?LCU6S0P5krXt5zCg90pVaqNfCLHj6XDLbWRAdgcLsp114F1cXv9KeZ0UsUPD?=
 =?us-ascii?Q?KB4aSb/j19LCPA3eiZnVrqCqvlk856v4X2+pzdE/1I9p7MuaqkACD0Einz5K?=
 =?us-ascii?Q?oq9G2CXbIZHAW8NEhTp04DXftGKn/kveJzyaoOCRcuvdLpJU79e7teQ4fepM?=
 =?us-ascii?Q?aI+foiQn7iFuCRxmmjFa7s4/f/QNhpMYFxhdH+EDetoGxYilPC38LMJsx4Jj?=
 =?us-ascii?Q?z12HlR4Rdg8qWP9c5u0LP9xJieup/gZI6o0zaVNUxYWRWg53uwRdSIabD6RM?=
 =?us-ascii?Q?2I6f4JzKNB4waBJTZHq4YeyquYQjkK/S7k7T7aaRF7KtX9t7d/c8tbnvYLhT?=
 =?us-ascii?Q?J8DeS5DqmzoxiOJtjUJO+iQ7BNsq9K0oHJRkP671ugueHzwF/Ta1haidHUJG?=
 =?us-ascii?Q?yqIa5aU+9kMfjz0UKy2fTrBdx8Jxcbl7JzVIh9xNw1ZJ6pctQOlMeAEy1Nxg?=
 =?us-ascii?Q?9RPCFure0Rv15M+S/z1Pru/Td3EY/cfEmBAOm2H3be2dga+/Av+k0hTBn7eW?=
 =?us-ascii?Q?Ri+ntTPLpgpTygRpIe76jwhQUEj8hnYuV7oD8KttP+QjhMGOuDYf7+LrkHEw?=
 =?us-ascii?Q?C4ARfV297mxnFNHqAD3DWjw1i83OdET2M1R7z2Qr0kp6uW6xy4WKq3x6iN3Z?=
 =?us-ascii?Q?5w1ihC/JJuB9lHfBQ7VsKPZxqcD88uYSRvjqJ85sk1PXR8NYNXDmOUpYQaTs?=
 =?us-ascii?Q?jJNWlHP9TD7Ij4riXp+dGsNki77hBvvpA+P+RgTExgBbgCcd/oOkoO7wIGPm?=
 =?us-ascii?Q?coV8kvP7xnWZ24ekFc27zciPs3RmP2Z4olu3BscVD6SiC/xNQlG9HnkUGTwb?=
 =?us-ascii?Q?oV9qNhsAT6ea6XmMHW3PF1M8NyLmiORk4NzPvPO3o/t0KQpAeehXlUMz6WcG?=
 =?us-ascii?Q?3ADR26ZW96KL2+3WQVi6QfK4tugWoSSQjGkzD16BF0HD48VHF5CI2VaXHAh5?=
 =?us-ascii?Q?tM16q+oVkVzxZr4Q5On3nzb3aThDExeuuxcH5Cfg+1wkgGheugStGoeUTmO4?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e4893a19-e6be-4249-ddf3-08dbb61452fe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:51:01.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWIHkgrRDM7NiYINldeJfEaNyqTc1lSONXdWvXnBn4UlQuKnDxk9PFhBREho6Sq4MVzUwIz6TpQDqKM8KlqvBV8zajBLQ7CRmkvFU9JRNiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3970
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

I was running out of malloc() in SPL, and the message told me to look
at CONFIG_SYS_SPL_MALLOC_SIZE. So I did, and bumped it quite a bit,
but that had no effect whatsoever.

The reason for that was that I also have
CONFIG_SPL_SYS_MALLOC_SIMPLE=y. So while board_init_r() in spl.c duly
calls

  mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);

that doesn't actually do anything, because that function just sets
some variables in dlmalloc.c, and (as the linker map shows), the rest
of dlmalloc.o has been garbage-collected.

I don't want to have the full dlmalloc implementation in SPL - code
size is still precious. However, once SDRAM is initialized, the heap
is practically infinite, if only CONFIG_SYS_SPL_MALLOC_SIZE actually
had an effect.

So just as CONFIG_SPL_SYS_MALLOC_SIMPLE redirects malloc() and friends
at build-time to the _simple variants, add a _simple variant of
mem_malloc_init() which will actually update the bookkeeping variables
relevant to the actual and active malloc() implementation.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/dlmalloc.c      | 2 +-
 common/malloc_simple.c | 7 +++++++
 include/malloc.h       | 7 +++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index dcecdb8623..d42b26410f 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -619,7 +619,7 @@ void *sbrk(ptrdiff_t increment)
 	return (void *)old;
 }
 
-void mem_malloc_init(ulong start, ulong size)
+void mem_dlmalloc_init(ulong start, ulong size)
 {
 	mem_malloc_start = start;
 	mem_malloc_end = start + size;
diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 0a004d40e1..9ecf05cf2e 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -17,6 +17,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+void mem_malloc_init_simple(ulong start, ulong size)
+{
+	gd->malloc_base = start;
+	gd->malloc_ptr = 0;
+	gd->malloc_limit = size;
+}
+
 static void *alloc_simple(size_t bytes, int align)
 {
 	ulong addr, new_ptr;
diff --git a/include/malloc.h b/include/malloc.h
index 161ccbd129..f59942115b 100644
--- a/include/malloc.h
+++ b/include/malloc.h
@@ -899,6 +899,7 @@ void malloc_disable_testing(void);
 #define malloc malloc_simple
 #define realloc realloc_simple
 #define memalign memalign_simple
+#define mem_malloc_init mem_malloc_init_simple
 #if IS_ENABLED(CONFIG_VALGRIND)
 #define free free_simple
 #else
@@ -908,6 +909,9 @@ void *calloc(size_t nmemb, size_t size);
 void *realloc_simple(void *ptr, size_t size);
 #else
 
+#define mem_malloc_init mem_dlmalloc_init
+void mem_dlmalloc_init(ulong start, ulong size);
+
 # ifdef USE_DL_PREFIX
 # define cALLOc		dlcalloc
 # define fREe		dlfree
@@ -955,6 +959,7 @@ int initf_malloc(void);
 /* Simple versions which can be used when space is tight */
 void *malloc_simple(size_t size);
 void *memalign_simple(size_t alignment, size_t bytes);
+void mem_malloc_init_simple(ulong start, ulong size);
 
 #pragma GCC visibility push(hidden)
 # if __STD_C
@@ -997,8 +1002,6 @@ extern ulong mem_malloc_start;
 extern ulong mem_malloc_end;
 extern ulong mem_malloc_brk;
 
-void mem_malloc_init(ulong start, ulong size);
-
 #ifdef __cplusplus
 };  /* end of extern "C" */
 #endif
-- 
2.37.2

