Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B7FCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA00848E6;
	Fri, 22 May 2026 23:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="feXZVZoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A53B848C1; Fri, 22 May 2026 23:28:09 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8EE848C1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlshbIkWN7pjzOWCz+a/S2E06b8LU381jOWBd8awe3Ea71de3g0Xs+uy9VS9KL6qm6qG9goR78arMpYi6b+8ipbhaVONT98KtGir/yN88Lm9uIqinU2/9Ldn0SaSk6eVXSMjv+vpKSXqZca3lRYM85UBCG3jbU/O2H8YVlFrM7KvRWDGGApQ5QhvDO6Q1kPX/livx/ELSa/LP+xOOpzhi+W+BSQPd1k9DXTxYRv9Ij1Fd6nBOF+yDkg080Ome6HVXvWkmb9En4qw9sFeKCE9lhwU7iaFesajsbFiY8i8wbNj0q7MscZnYt8KamAN+Sl3vcfOs4IPXF1C2Spcu6xzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da8FWzp4N+Uq4iGNQ0VuOwSEhvT/aJajX9etDpvTsNM=;
 b=MwevokcOUyHEAaWPMU1msUdddt3C0YhZOykve22SgO/7XrGKpXLIkx5gxiyLclAhUEmGwrcuzJC9d8Fae1c8nZ2rhOZ7Nhe3TaW3TM/2uMvNW5pbs5rffvkwdYJXB1xcIJvvQahQhAnTdvWMv/C4BAF8C+kB5Hhok2kF2mQZZzyLhl9Bc6oqLgqrFMdmAjgmGx4Do0YHzssi8TLKhq3LAEqcL7+9p7WcRG+tjR0pV/sI/FgLPNzRFsjPGSUW9677185WPcivGoqP71g94f7QMcTjSuz0MtF4z8hfTcukSOcVFUnF7alGiP+Ld4695LRJsPqCYyJS5Ak/iL0Wf/LnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da8FWzp4N+Uq4iGNQ0VuOwSEhvT/aJajX9etDpvTsNM=;
 b=feXZVZoAyjpIGzJONDQB6y3UtByF5bV14Vzkad+DbW+DiWD0vlJpl++Ns7m4EMxp2G3vMk0fvzK+fBGIb5wTTs7xNoNbV63aBM8EboQ/sJqAAxb+l/III4aA4X8PBlj+d7mQjwfqjgdOEuJ3pM4o3jdjL48FAyjB4lJ2Ein852A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:03 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
Date: Fri, 22 May 2026 23:27:49 +0200
Message-ID: <20260522212756.3169222-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::7) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: f0700755-cef1-4648-1457-08deb849017b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: dlBJdrKRkzfsoxu2V4WxG+XG0+4ZXhRskk1EKdWEBaF2t14nnjf7KEVcb/qva1ahw6ppSkUGsUowIdcxavomvZ4eynBkThXaOQRYJs++GGy5DYug/cMm6+xIwFTCdyD/soFND82ChcqbWxiUR23VacDi9d/gLg5CUVC/X2LRius1TT6gPwY4Jxaaq15GkTFQ7gfIw5vt8H3LHygMQYRl7b0pACKLqg9agcnEaqwC77BwoZU27OdEag8TbB9UiqQT/0XgxMNMSsNziC6vTDBgVxotA4KwDTmBDTg3wc59vTD56jCf8IgqfzRptab8K27DfxvQ4hk45FdWpDANQCGZNQ+Low2dsVj2BClJ7AnOwhydnXiLU5hJfJqOE7aUyHe8peXUn8gIU6EcMWWfPLvx5M+7JQBG+GN3qwf/OqH0rkIKxNFN5300C1TVciDhP1pvH0GNLIfIRYGcDzjQ0/8oZgJ4U+OaQCZDkE4XEo+kREQqO32VQMUSIqoPvZgaNS9NapfNfET29zIRjd0LNFHrHXFn79qmyUf0XPOv6rWsIumclJo3Wc92wUcNsKt/Gx4Xa7DPvzkbm5iBpR13ZkBJ58GtWwe4OCtVv09COWKCR1vXoqxul8/lvUSorxUPmanpjkpR88KucuhJkjUDCobuFYHgr8gutTDL+60JyxA0C7KpuAwGGiaFLOu5GmLT5dZ0rHI8ZOdlNz0W85h2Q8AibifPq6Bt3mSbq/z5xJNZvMOo2tNnkjXPRACIFRt22Kla
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFWkTEcFZ9GfDrlHLa+5Fn3qCVdZ4m0n8CLDGlPhHrYk/0dswSPZYbEbNWTG?=
 =?us-ascii?Q?ycH7KwoZI/vpI6S9N55AhaMmsxf9CaNT9+N9CLAOhlNU+zKC+0IqFBSbz7dm?=
 =?us-ascii?Q?4SSRJY5bp3KgcMmKEyBElq4pMXc9zFufu/UYHsshg3V9jGAinNHvMlGNAuV6?=
 =?us-ascii?Q?N+h+GN52gyghgky1g9ooXlBe2kjHp2XsmHc0K8izI4q6NWG9YQpk/oEJu2iW?=
 =?us-ascii?Q?2QP4UusJoWXRvx4JM4TpaaEWcVKZ5gJxp18Qrdlpg63lvp/JmiEo2Jp+fkuK?=
 =?us-ascii?Q?WpQuNmg+ox0OaRCJfupKCu2Zl2FTaWC3752znt91olhl270krbDDoavb4QnO?=
 =?us-ascii?Q?VUhmoY5m46X4k/GPm5inm7NGKT1116x0SptAAOsJRoGzc5JJjF/umIQjAPJy?=
 =?us-ascii?Q?6WfXLf+85ExVvTIG9RadtW/A0Chl5M7wqV5YOuyh0aTe98XnwdoB2wHqEfoY?=
 =?us-ascii?Q?kCS3fUKHwjc+OWm3J0lVrgQh/r4K7Kc607kGSu63TLhLAiYZNBAcCdjf+3GJ?=
 =?us-ascii?Q?p8Egtl8rETfWCntmsROmT27QS6888N4zPyDgyKK+KdP4PlfeAwsmI5Jy0N1J?=
 =?us-ascii?Q?8UQrdSfe6NEohiCkHbN0LtE06FjoAni3KDTooKWNytnFTDkADj4bRlZqh82M?=
 =?us-ascii?Q?/4yNqp6kpe71zJI694Y1XDVKOb7fGDsQuh7j9fkciKX9GVssigN29bGHrWvk?=
 =?us-ascii?Q?wGJVzuqC8XZRbThQEuWNc32xcVcsqHxDGQo0YcN0LUjRDYBQ+8HI+G4h8C9n?=
 =?us-ascii?Q?qn1Vq4Ssg6eycnhTvnGb4bcRU0Tni1e0EABg2BqU60uzOG/4oZzmusTpA+gz?=
 =?us-ascii?Q?mgxM9YzA37/RNhA3zCyMEcjB7/m4kOOcdY20lpr2/Hsz/2nm6GiU5ocLxOru?=
 =?us-ascii?Q?FwJ2LYNvn9AASaRtMMxJRMkk4AxzMp2mB15P8g7LfsKWFjh1NayuqIw4ihmr?=
 =?us-ascii?Q?EsTegt7p7VpwOQH5lX/kw+7EMNiofy7liM/vSpbg0GPWtFIVT0iq7hCbUSDx?=
 =?us-ascii?Q?zwY7Due7z/mJ9m0OxlrL5Z2MltBIBL3R96tV2WyLTp4eHlcIbb0jlxhEzcsV?=
 =?us-ascii?Q?yOuJFOFXqvoAFuM5v7Lko+76fyRZGyPJe6kd8d1GQGwR7bC6555aejVnrQj7?=
 =?us-ascii?Q?KJQ02mb9NysTS6uLof4ogR+PDMJ/wlST5LSqI7rAmOKW2XmRb42dCPIDBBuL?=
 =?us-ascii?Q?9JD07LXYLrgX3ZFS7owfTFaUwlUVLe3k/OpyRvsEs3OVfUa/4Ue9aZFCPKWg?=
 =?us-ascii?Q?rnRoSkCqqxkx1MZDb6H1nGhjv/hINCkzrej2mwX+gzMAOllJvUx+FGHJ5qTT?=
 =?us-ascii?Q?Lw3in83OVxy1EgDQTXfT41l12R/FwqhxDJbA1MmtbxMDlVBYoqev2IG8+Gwi?=
 =?us-ascii?Q?SN2Z4pKwPmfDYfOZi6IGxqxbmDJ+ws/dFkYDq3/rVej2dsiEyTcZ/ZbE4Sfi?=
 =?us-ascii?Q?b/MZaJEb+4qCmgBCyF6koLnNovhO+p9kp7+duXTYAsYDkfiQVnvPd388phB8?=
 =?us-ascii?Q?F6cefUvfByG1Fenbn981CHms4+DY/xgEZOsR8zKQK9+5Kb1yGrRzKgjJmV9F?=
 =?us-ascii?Q?Y04NOHuhGIYS0n/uchFgszQi9Y5sxVhWYexmgBGsGSe0xABwUrJMMTQOu/4F?=
 =?us-ascii?Q?zK3zktEPsnq+kQpsrKuTB5muu8Gpz0itANXifBFqyP4IFeDyvjLfycpPTiYc?=
 =?us-ascii?Q?j6sS1uYmVPoeURoC2Z/VWk2nA+jklSKSBNRE2t0eh2hmPFsbJjdg8OGm2dO8?=
 =?us-ascii?Q?PblmcOFNEGvpwCaBdKKA+TuAYFC/bnY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f0700755-cef1-4648-1457-08deb849017b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:03.1660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9PnrfWNUrwWXTdCKb5mVrTKS2cHblJWWDp48Gl5osZL+EP2yjNwJA9mDk3nME7JcjrGrShqEQMAnZ/v0OfRJ6LNvcb6xmgTOnQuahH5eLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

From: Tom Rini <trini@konsulko.com>

Whenever we declare something to be in a linker list, we want it to be
included. This is why all of our linker scripts have a line similar to:
	KEEP(*(SORT(__u_boot_list*)));
to ensure that any linker list found in any of the archives we are
linking together makes it to the final object. Remove the places where
we set an attribute saying that it is unused, or maybe_unused.

Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 4425fcb6785..a8b7e2c9f2b 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -69,7 +69,6 @@
  */
 #define ll_entry_declare(_type, _name, _list)				\
 	_type _u_boot_list_2_##_list##_2_##_name __aligned(4)		\
-			__attribute__((unused))				\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /**
@@ -92,7 +91,6 @@
  */
 #define ll_entry_declare_list(_type, _name, _list)			\
 	_type _u_boot_list_2_##_list##_2_##_name[] __aligned(4)		\
-			__attribute__((unused))				\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /*
@@ -125,7 +123,6 @@
 #define ll_entry_start(_type, _list)					\
 ({									\
 	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__attribute__((unused))					\
 		__section("__u_boot_list_2_"#_list"_1");			\
 	_type * tmp = (_type *)&start;					\
 	asm("":"+r"(tmp));						\
@@ -167,7 +164,7 @@
  */
 #define ll_entry_end(_type, _list)					\
 ({									\
-	static char end[0] __aligned(1) __attribute__((unused))		\
+	static char end[0] __aligned(1)					\
 		__section("__u_boot_list_2_"#_list"_3");			\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
@@ -251,7 +248,7 @@
  */
 #define ll_start_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__maybe_unused __section("__u_boot_list_2_" #_list "_1")
+		__section("__u_boot_list_2_" #_list "_1")
 
 /*
  * ll_end_decl uses __aligned(1) to avoid padding before the end marker.
@@ -259,7 +256,7 @@
  */
 #define ll_end_decl(_sym, _type, _list)					\
 	static _type _sym[0] __aligned(1)				\
-		__maybe_unused __section("__u_boot_list_2_" #_list "_3")
+		__section("__u_boot_list_2_" #_list "_3")
 
 /**
  * ll_entry_get() - Retrieve entry from linker-generated array by name
-- 
2.54.0

