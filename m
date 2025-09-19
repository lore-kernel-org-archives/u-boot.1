Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774CECAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF9C83071;
	Fri, 19 Sep 2025 12:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ed7ciVBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCD881E13; Fri, 19 Sep 2025 12:10:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC048323A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4lqGgjYPp4M3rAX2+q8SMHugqrRM76Vb536XEs98C3dFqFftBUrWWLaJZNFjYBzNHGxhfC5AQKphsYSvZYo97C0jG3wBiqoHt/j0sXM9ZPFc/C9NEE05O35ywVtPyXdA4a5KWfvj0nygSUe8GIf8EWbq/VBALdM9LfAm5CFJVqkZMJGKbeZOWDbkGrxMiEd1/tfrjwBPy3ZTjfB2b/+U13yu19dg52fwJD98d+bDEuxV6OaOzQGUobomez+ebu5ZfeHrvg5ChCSJ3vZ1AbeEYQQI3ieN4AqDXjx0+3dIVSGCUOuvnf1rwDiGmSRg5qfxGxOSth+RubkijtxWEJpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P0a6BdGxBysq0sJc18QraYafN1g4BD1QZX9KqvaRo0=;
 b=ZUyMs2pnqciaBHpU0scZo9JvmNNbQzDaixVx8yBe8Yy3sbQZsxidyhvljaVnG8gFU8smDJdsDPLaoJaUn+MvqzMI81U/hkVocp6t6ChowMs8TjumVug46SYuBl53cvfhkqkqqXZMeluCxJaJLr9eoCSbkcmZHZ4CaF6PR0Y6wUXtcUoBVUgAvmD/vUxfi+FSRr0xf+wjJToIX/byjTWSugnJTLvfCdb9kdWM1baU66hZDxHOqTgiqodty96AESKJdbhOQwizN1Jtzm9m8/NagmeY1NVq0RjbKBR5CiaYj+o+lv92n4MD5XVB0bfAyd6MouCqxMUWEVcpKov+kkyeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P0a6BdGxBysq0sJc18QraYafN1g4BD1QZX9KqvaRo0=;
 b=Ed7ciVBFyB/mM5zId1su2LEmtIDA64062c3snEtbSV7H0LcjC2PNxhCMeUrWPvdc61H5NRvJaeZT6AUdpM8CxTie3/Ix/bfH5c3fpUPLSrSTU1gEtOuq9Wyyd/j9cDvxdt/cSCbf9csENjm/gH/CMHVrc7cvcvU7g8rDXnFVAbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB3PR10MB6833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:439::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 10:10:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/9] malloc.h: be a bit more consistent with macro definitions
Date: Fri, 19 Sep 2025 12:09:54 +0200
Message-ID: <20250919101002.568488-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b44c470-77ec-46bb-b594-08ddf764b5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+FzO65pliqdJvA8lGebxpc9bU8acwkFKAGLgIrf76Vr/xR2RBu9TZ+lPIXKP?=
 =?us-ascii?Q?xgmhDUf9DdGKaZJScGYc8I3RHhQs8Y3P48Z1FNNYsoudaxH8SDVct1wvThOv?=
 =?us-ascii?Q?9/x/+KAuKW+8l1UWn4Z1x2A/R5kGL+RNM9FnqR/YRvbCSNpfHDRNUH/KH46B?=
 =?us-ascii?Q?53fTqOrtN3oPZTIZ+MB3o2/XJZh1smy1BsK/6zt0um/stJ6DHfK7w0vZineE?=
 =?us-ascii?Q?+UXzAvsiad2+v41OJtbIJiENPTQ790Fw2DE03B+N9ReF8arWd6esDgDJY3LN?=
 =?us-ascii?Q?oHxBR9cbah3zU6Mgz196yOp7DFUEpXiv3pOWTt+/kvJKCILu2ytx0cLaR54q?=
 =?us-ascii?Q?fyMovPpK36iyq6gP/irCntYnK/zK/uMIHbwyIr/mpHAj0GupjJXrjyOifbPv?=
 =?us-ascii?Q?rfLEIe6RXEFosgcMdI1AM6G8cKNhsYchY4YkkMLzDMU/tagcuTHsub4ADxJN?=
 =?us-ascii?Q?e+60gHgTIeDfF8GZ7d0gPRrmMR4yPi5bfXMp9Ps5uV+LLeYGEnnIvdrIDAZq?=
 =?us-ascii?Q?WI9x7dOJzZ5vEwWbbzAcEP1YargY00l1xy84du3X9YYh9fq/xmA6e6QejiQL?=
 =?us-ascii?Q?IlgPhwZMt0YX2uzsXkaihrxNNqD6I3HStltUaS3OxeBdvZ4BOVjQByY4D5K2?=
 =?us-ascii?Q?/8MsjAe5kMGJtMfDi6KbrueQLK/6xqZ7YX9GIPlc8e+4xPOWh3BtIb3C2exq?=
 =?us-ascii?Q?mc4VpqqyN1Phdnnd3Fgy0/xqvx+zButvwWgxzOqqgATav5XaEIoOPdJBfZk7?=
 =?us-ascii?Q?GlAEOWWqXWhYWCWz0i9LVsAr8EE9C92CoFhQ0brqoOKWwykbEGryLEzETar8?=
 =?us-ascii?Q?yiskL8l4ALHLZU38CcueM+2jE5KpBRefu4agB90lPK+V9JMNWPVm9n4R5IqZ?=
 =?us-ascii?Q?+f048aDYHnpfZFpOcT+dOeCqtqGCM1fnYZLS8VbuksjckotcYzoLkJ34sXkK?=
 =?us-ascii?Q?y34Hhoq/stR5OgvpPoE2Mdln7E/GKp5nQrjD3Bijp9EeZ58KYwEDdbvY6NLq?=
 =?us-ascii?Q?oz1OLlvD4OLVbJCYRH8GH/Lb7AE0AsRUdfsynicm4W11fH+MUK9BQfUacjNe?=
 =?us-ascii?Q?lBpktQU7ks4IHxUj40hZGOWTWePoBbh4qMCMFqXTVurloEJXtvzH9vfsmrgj?=
 =?us-ascii?Q?sZee0AU6yCS6v6ZiWp/epKM3n3ZtpAAZrBJIlc+qxvGOEVgLWWG8dgWmZK7m?=
 =?us-ascii?Q?hdxtTnQzynZgn3z7RlGZJXwgvJDb1DllEo/e/rU2MLFrJckflQuZBComLKW8?=
 =?us-ascii?Q?M5TaRVYQ2IkuRXJuhfP29hhV1uAXmxP4bVIJ2Puf7+CDLzDeLIp8XPgU3vnG?=
 =?us-ascii?Q?xOHRIZbutyjKTvRDSngOouf6T0v9hD734isL/YP4CRAPtUHxNfikgR/TohPR?=
 =?us-ascii?Q?e7v6uE7LffQO4CgV6scN8Y7VxbqDtucV02iGEhB4YcGwwr4PpcW4L7h8IKCe?=
 =?us-ascii?Q?tL/jwyoyvUY/J86GXduuZ1gKQPNvgiNK0urofWsLEvqxsYusLH4DNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGOvO6ThBMJ7ngxNwnIYeOpP7ogbFnmO7yC2n2rET0qMLg5aom/7M87zK71/?=
 =?us-ascii?Q?rzBG7FgZ8/cRTUFxK8ygbv6r9/yEWc83igdMpa0iI7intMTf88YBNGUpNHJz?=
 =?us-ascii?Q?F8C4pF9W+IL1ztl0y5vtTimajZP/s6Tmg+75NxMgOyHtWwVINsGXpIAykzK9?=
 =?us-ascii?Q?4dauk77yxmOTSkcOLXqOw1DWMP3cXlq3j/vZK1EMT+oNWRIe0gXGz7qbJHbi?=
 =?us-ascii?Q?hRupoqXfFZsEZ4yDDgOwZNfG3wZCuVaOPeBxaoK9W2b1Nr3aove/7lKiBWMX?=
 =?us-ascii?Q?O/mthZpZwBlsSQSLtKn+dtO/YPJUDtndTBl5K07yGSvckV9wF1hH3Tb8qvZz?=
 =?us-ascii?Q?kx/rTNZuSA/v68zYC3eUfjhnFOfREVdbr0Z79acOJXK5DvaoRA9cPQ/XnwWY?=
 =?us-ascii?Q?rWVntg9dpg4jciqQvUAMScixrDzB94ZTO/0czW3QE57P8O9dMu0NNFpROxHM?=
 =?us-ascii?Q?GNS3oYdi4FsR4w3W9/3q1U9bj6kUp4yX8kPbnDpHBHtJXYoRVcjsD+RmG1ET?=
 =?us-ascii?Q?rsXtK6IbY9q/Zv+1AqTi0Rlh7gXE7fNoTONAPaJgM1IgA9Vq9+G6TDm7/Bbx?=
 =?us-ascii?Q?hmsYjcyFannLWnFs9MZ6dzolAb9d39CQHR5zzNfcjqxU7CI3xTvtsqvSYjIe?=
 =?us-ascii?Q?5zBAxVaXlv+xlsOD34NHtTVdPqxo8q5J7mtAxkUAmdcfSLMqm2fvPusZ2OU5?=
 =?us-ascii?Q?Z4YB1Jao7z9oBXZN1pwJTjz+Fubp8EvwwY+IiZbOVjYuy78xzqAu/AP3gp2p?=
 =?us-ascii?Q?dJipjmOlE5URDwvnq/o2m5V30qVUAtu0K/vKlE5bQW9SnEYkmlVe30OmBnbV?=
 =?us-ascii?Q?uihz+YAI9W3xGN1l7hv3S/k+emYGBRVqNRZrxK5ehG2FVw2UF4/T3yOep/tW?=
 =?us-ascii?Q?SbObJfWCb74JgV5cG/9tuwlQRzX/T0HCbRd56qgnz4aTXGjyJNH+ihx4+LHo?=
 =?us-ascii?Q?rGnRkFWe3dkcbIDGvxAvYJi5owgpyy9SUw7WHOg4qkxCBEt8aPa+nnMlMNYk?=
 =?us-ascii?Q?7aJTQqVSyNv8i/mMrnv5LyynYRKcg5vVrxO8kIMQSy5bp/zfJWmqeiqOuJ0T?=
 =?us-ascii?Q?L+QT8rNyj1BYQpSXbPBlPWoi8e9ilApSEylnUDZZ9vrCBwU63EUB+oIHL3X6?=
 =?us-ascii?Q?aLc0ORxIDqFKbU9CT59JpF2iUKv10i8BKCozRzp6EhZAOUbLfTdMfG7ZpcL1?=
 =?us-ascii?Q?DaKkTd58DGllHRNClj2FdEpsywvj6ZZWL8DVH9Hv9wWN8Yhmst5+IjHa+N6r?=
 =?us-ascii?Q?UMgJqY7RJD/jzHSTdnYP9GAltPCXA/ZOitbSoTspHUM6sSwtCR2OaD9VDajO?=
 =?us-ascii?Q?7vlRN2b618TMZgaDipZbopMdE6BvFAoKSVI8U0ygQJbhaHzRrqPpAO/y5a5+?=
 =?us-ascii?Q?xvNwEXN4cXOve52Ei7KlobGTUVQbl9Fcu1HqWFKJO3RlmUG5R1i8QdY3kqY2?=
 =?us-ascii?Q?ZiarD9PuAX4iDdOhtzDH+rIOQLHcrHoPAOAhY05acSWBKsRMH52n8ZU5AMI5?=
 =?us-ascii?Q?zWLTwyYZOWhUYQmTZ9lukSiQSdVH7kKqgN+taB+EXh5CwarSIKbprJApZomk?=
 =?us-ascii?Q?VcBSn7ypuZFxMN6sCoDpMuqvsaZL1YBDS8xaylBFOzdcNm/2HxnJ+rAA7zHi?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b44c470-77ec-46bb-b594-08ddf764b5f0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:07.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1UXpvwsBn+9L0IBTGyHM2PUxOmYQshIZM7YIw7DaGqvnnbrueXEGp4DDR9zEpgzpjin1GpNCxhdV///maqFtabJtZ5s2yFCMj1bcPxaQXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6833
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

Currrently, malloc and free are function-like macros, while calloc,
realloc and memalign are object-like macros.

Usually, this doesn't matter, but it does when the identifiers appear
without a following open parenthesis, such as when their address is
taken for building the export table. Adding calloc or realloc to that
table breaks the build on sandbox due to this inconsistency.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/malloc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/malloc.h b/include/malloc.h
index 9e0be482416..3979fc62830 100644
--- a/include/malloc.h
+++ b/include/malloc.h
@@ -904,11 +904,11 @@ void *realloc_simple(void *ptr, size_t size);
 # define mALLOPt		dlmallopt
 
 /* Ensure that U-Boot actually uses these too */
-#define calloc dlcalloc
+#define calloc(x,y) dlcalloc(x,y)
 #define free(ptr) dlfree(ptr)
 #define malloc(x) dlmalloc(x)
-#define memalign dlmemalign
-#define realloc dlrealloc
+#define memalign(a,x) dlmemalign(a,x)
+#define realloc(p,x) dlrealloc(p,x)
 #define valloc dlvalloc
 #define pvalloc dlpvalloc
 #define mallinfo() dlmallinfo()
-- 
2.51.0

