Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4A2C5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533C983EC6;
	Fri, 20 Feb 2026 10:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="cA9eRRGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6E583E7F; Fri, 20 Feb 2026 10:15:31 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD4B83E8E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHJJpcugm5jdHHSuR/4COHeHJ+bWkipDYyQ+aLofDoQkfvMuB8wE5KT/F8/J7jZ47f3FZ860EPBO6OZJJ5nfJSajz32zIPOvCuC1qgTCL37D/KcPUzNm2LYmVeIeKBsIDfpZcG6joUYFFj9kObhoiamZcAZjxo0AiERZwNxLpwBPuC5YWJTHnKOwQ3gp2bNbrGm0O5Z5+f2dM+HBhxXch2yZUd3iMoKVDyJtfv9UyzkSpwgR1ic6Yyb+D5N1RByk4h2/jJOV0t1GRkLxsvyso6FFsGBzuOY2V/6QULfy7+WJGJLOROzyGxtHdd7cWgs8eXPPLW/zqR6udEBHmqPJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NSZ49/Xyt0mQ8/JYbmbj3pTDKFWvqMPO73X1Kueq2A=;
 b=NaeU1IpE3LjFLKmsQfNjqqGxeLuDeA74OUcgi5VJOeuWYcxeg2RqAwt718fJKSudqwzi73bekd70M92zW7CHnbLlAZNHVIhhtKWigdxPnJbZpfc302g9mGsv4nM8teZBGpXkgXClJ6FLRimnVDIHki4qAJdct5MNYpdXm0fdusxVj82NMl7r92HUgP0iQyFqG4M2ExfznG8k2cgLXqZHSvRsTIGYEsY3Ihi7gmpqoYYEnB0LuM0hbjoKbaqx7sbyTC0vSh2wr3gTr6aXOKkN9ybX+NvNrz1M6vNh3juTaop9/5E04f9nHE4v8yUahzDwgxVQenJfPNVpuWtDsDe8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NSZ49/Xyt0mQ8/JYbmbj3pTDKFWvqMPO73X1Kueq2A=;
 b=cA9eRRGLBWziMKZLthK3Qcyq36PsMOGJWPwmvXh4SZwpH5s4uxVZn2PvyLVMBx8DI+ecTJekjmVgOPDcJfTw3a1rhiVzdvb13e0mKQPXO1OgSB2+nCnBslzpps23lXj6t6H7Hi+XrNkwjbY6XEWCFcLBjwY4nG/RG73PlPMvNJ9GEsaeC9HjPUouD3cCXG3J45LV4+VH3uTRoNfEQUT98B/ywndS1exEYD/d3lx5Il00ZQg1oPzcw6Tz4pC3a7g0YSoV7BztPmaIEzgBIF6F+hzhvdu+xckruh4fClsnUAVKZFlKcLZS9R9XfPe+gk1ySuN7nGVbkFtschUHYe9FXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:25 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:25 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 3/6] tools: mkeficapsule: Fix dump signature long option
Date: Fri, 20 Feb 2026 10:15:13 +0100
Message-ID: <20260220091518.180641-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ea819-9866-4990-136a-08de7060951b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3dbPPvpei+kO41AebifZ8GsPTuuN0yhrC9/l4DI6OrY9NFBxQteyqfYlvw5y?=
 =?us-ascii?Q?Kcffz9UWyc9VHFdab8n4lDnCZ/uyXJP31GIclnZ9r1H36ze2HvtfJ3olk44C?=
 =?us-ascii?Q?w5AcVATeTc0tK+7plAA6CiFC6U17gIHigCGF/IIY7JJ+NYhVd57T/z21ucoY?=
 =?us-ascii?Q?4kLi1Slj+GhhyEpz9QDB9fVOyrQ/bUE/ZZP93adiGXtQSHa+MvmnbQF7BKfM?=
 =?us-ascii?Q?/u+HtVntPOPdkQYvrp3k+MgPiNivujyJ24wB2jBkrtkWcHU3hw+JCXOrkheZ?=
 =?us-ascii?Q?b0NOpHTfHLsUIGf8wYMRjlC8k0wnONxzWCN2Bd9GKezsOcHsY4VXMlIhGN3p?=
 =?us-ascii?Q?leh87zJQavQXpignB4DmCdSGoS25y0pkyGNaJphx73oXPxm5S18ULSJLiWBQ?=
 =?us-ascii?Q?J9rOqltf3d+tugkFqNPnr18WTYKqJQxaGmqfFcmn7DbGmm6315xl9+kqHh04?=
 =?us-ascii?Q?bubzQSLbLD9NIasXYqBDBuIDNJKL8zmdr79ttfzGT3NA6v06LbwzzYgDz7uz?=
 =?us-ascii?Q?+gKLBpYAi+OljhHo584jHcCB4EX+8nQWblS7PcsQxw3CBstcK0pqSAOG/je2?=
 =?us-ascii?Q?1fBNEjMIXBbwANVes2QCYLD5R1coNxSBajx4owBjp5QKHiXuBOcBoirocxUE?=
 =?us-ascii?Q?FxRnUkNmEwazodwIFyt2Om7M6OfoT91EQolZ1rbn98LigibYgefSk0FXgRtC?=
 =?us-ascii?Q?OIIG9z5RNRn1n8qyAN4KZ9VJ+zxz469aUnHQyK0C/rE6SktqgiBgqALpgCQQ?=
 =?us-ascii?Q?UlkiNm/bCRdsNXJgfOw+TaSrBhFdMnJPp2PD19z7fBLryHBiORj2Av8y4lJm?=
 =?us-ascii?Q?bVF3bDI4k4CawWuDgB70pRvcOzDLC6q5256Gk53Pars0MyTv/1Icoary5GPe?=
 =?us-ascii?Q?gEVrYvtDt7MmyiBxofpKBmF+J699sIVDPoE7cb7BtzN2yA7jgvv6BQoGDxPR?=
 =?us-ascii?Q?1W+SIt9V9PltblBZjrO+6ucjadmwSyHD0hnRZe98Of5j+08DgHimyMgeNhbf?=
 =?us-ascii?Q?5Cu7OnSFUXQ9ANpGTFvdnTaY6Tb0I5usqWTXiw7x40AlrGucYcRVHcOfxIRG?=
 =?us-ascii?Q?oz7nvCRcyRBzIO146QpfTDBo6C46k+NQ/tXqOr5mw1+RiU/2sfyekNCBXLR/?=
 =?us-ascii?Q?YEduZ6bfGvkaGTPRG+dZIeO802HzTo0yVDsRte8hw9vpRQUfi6fPWn2dQHir?=
 =?us-ascii?Q?mmA2GBrWk3XoIvCLZ91Wcj6zwRHcbc4l0HI4AcGPpOlQTFrXePgC//lEa8a+?=
 =?us-ascii?Q?n36gysPkK+4WXcGJaqc+x9Pnopx64B3urRSYgAZvZqt7cD24+vHM9dcOVeHX?=
 =?us-ascii?Q?kB89d58oZI5djnqiJgfXiIh5n3TxnHlHJBekHK5CbE5WFRbmjst29Ag6iaPk?=
 =?us-ascii?Q?/XUd8UvSE5Yag4oprHpnWYU21v0ds7CltQuR+dsQNWmyUbKagYvzfgaB8smZ?=
 =?us-ascii?Q?u0TpozyG+sRcxGbkKGi0jy3F603eKWaZVrDQOqjkCpt+opJF6p4S59LU46R1?=
 =?us-ascii?Q?/I/EyV8tWkbQIG8HyqyGaepQOF5G12oIpki4Fyp4aBhs+KUByaOJqzP0hU4M?=
 =?us-ascii?Q?TeKgbvy8yNxsJMvpEXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVbVNLY+kq9y6O0bsPIUGi/PgYsk6WTqpTqbwxqMVCofVO+uGihyi4Idml0q?=
 =?us-ascii?Q?AcxuigsQgnPXMS0zBa1Fodbt8Kyj9DLrXDiAhlYxPsTxXLIwxuJ5eGoNWdKJ?=
 =?us-ascii?Q?QmHCpczqmXFJw+zKSprVypwfVJ1ISJJMHsNScD/ZFzt3kjJOC/bBfzWqhJh9?=
 =?us-ascii?Q?ayBg8VohJLR3jfcwzSvCdV3xhX9IVdh2e/Wh1OJQgl0NfYLMfatsa7Nb6YQf?=
 =?us-ascii?Q?JhkaAsKWbeRhLBRFqWXppEb0gAQkfIjE+Fcc6hFDMmQOgN4KLPHR9jnjy/34?=
 =?us-ascii?Q?zXA7bPgMkg4I5dZohOL/Ykch5rf6eEzC0sZWf39K48dX+fIAfCQ2M4nTVOCS?=
 =?us-ascii?Q?KyaybIAIABDzhWEoMy4tx0QYnnUQsECy1wsj/+dCAPru3E2gT74+R10Ht8Nb?=
 =?us-ascii?Q?dWm35lVB63HIW19CI6A7hwu8JVMdAzwmnzqYcGmv3pOQ2sVz9+EMszEYXDrI?=
 =?us-ascii?Q?6O0vSN0g4BF3AjBRnjKvlSaLu4qweqG+j7tvf2qa1hhUftH4ebmk5uxUU856?=
 =?us-ascii?Q?761b31G9g71iaW/G7cY7KxrXIcWvNCfbWfSPStjkIBWt5BcKTqV6pK/O16vr?=
 =?us-ascii?Q?TIVEL8bUKwllMzTpgZclPP/Lyc+bFhT6I6q/aOw8pJ75gmJy4EhvBp6UBS1w?=
 =?us-ascii?Q?ZxkIUlDKw/fdvxVi4vnEZQkyBRd/LC6vZXBSs+/4EGqeGaV3d5ZkgapytHsX?=
 =?us-ascii?Q?JYb5Q/FYlppiyxNfnCW5LyaknsgMIsmQqzMS2ay8LEEC4cIoRXwMgKXeWW7E?=
 =?us-ascii?Q?PWYWnRYmLTYqDxSa6I9qRE/eFDkt8olwckJ5Qf2pgPscQnzlRdcrlyEISPNC?=
 =?us-ascii?Q?woCttvTGECQgZUquwszSSm12DGvt4K3avWgdOBwKdvu7jhO1e2TEbWFX0UHE?=
 =?us-ascii?Q?e8kKj3YAxMYCN0NMYHX/UfFqqv9aBMx7dwOM4FutCoLablF4NpxTXI6WzExM?=
 =?us-ascii?Q?vQ9khmxFuwPMELowh+MPI1hjdxWoek7Goo5vbbEtKbwXYn1BkIF3ujS2OWgY?=
 =?us-ascii?Q?6GJ9NHmMmReV3O7P2yGXFABJC7bC8qwR0TOsIKJtPGUajWT07aM9FixwKBsm?=
 =?us-ascii?Q?md+MT2LVkcdAKKnJqILWKipjxRdALlKX52l7SuiVgmN9dDrIRlLadtR3GNah?=
 =?us-ascii?Q?9PGTq9Bajjga7v7HkThj9pqVYwtUd5xEQp3fAo44arjitCwhuWvyj5Ou9hf2?=
 =?us-ascii?Q?4YzdArm6dc0OD5CCGIfRZUJnyIFZ3mZS+OsXBZRsN/5/enThgZKYS8bgHYVD?=
 =?us-ascii?Q?R+z/nPQT8f6+l1e9mTys1di/wGCCrWwB6WnHk41pNleN3Gs//JkjkZTtCGar?=
 =?us-ascii?Q?qWtFAfjif8UdSzksUozgGyBQTEn0B6oi6z78vXsBI0vKuHsF2zS11RuyAOZR?=
 =?us-ascii?Q?UQA/tY2F2g0T+kfk8RhKNpmy5dzccguAGsrTZ2CE8Vt68iUE5WWCGUkOJGJh?=
 =?us-ascii?Q?kek4tPw1fYs1mUsIEuDtZ+XKYZzBEnwVerj1cVv9to6SmgPFgsvExIwP8KSn?=
 =?us-ascii?Q?MPmkCAstPJuCbQsZ4KJbSd/O7jisNk0ySBs4QApriMHTwI4N6EJExXEG2tHH?=
 =?us-ascii?Q?EcVQFU5/XNSMtW6oZ6lkJqEBCSYqj6IzK2NStEqLKf/p3/x7Bv77Qqbf9hbI?=
 =?us-ascii?Q?E128PKtXQktNaJ4+Jbl0LcX73C2OBqDuPWhSNIJ21gop5h6XDEB5llKKHloL?=
 =?us-ascii?Q?yr+UWVjxu65OEfOE36Kc4TlsuE0qke5F27WZwaLlX6zvNV4gM9fXwKA5DBMo?=
 =?us-ascii?Q?5A4YlJWT3jOz27QpzA4DBaAW61ZgnoG1Ee6P7hqZxYl5gSU2iBWW9a3JF7VU?=
X-MS-Exchange-AntiSpam-MessageData-1: mpUxIV1BryPSzU+BS3+zjogXEvnwGz5/jIE=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ea819-9866-4990-136a-08de7060951b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:25.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/ZLODSY5MDc2XvB1a6GE/IWQymbfsBMoBDCHDfK8Zux3STuveBlM9mmKgn6kWhJlGH6yHACacpH4KBJx9/k5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8544
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

Only short option has been present. Also rename dump_sig
to dump-sig to match with other parameter names.

Fixes: 16abff246b40 ("tools: mkeficapsule: add firmware image signing")

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/mkeficapsule.1                 | 4 ++--
 tools/binman/btool/mkeficapsule.py | 2 +-
 tools/mkeficapsule.c               | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index a726149ba2ce..d6653ec42472 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -121,8 +121,8 @@ Specify a monotonic count which is set to be monotonically incremented
 at every firmware update.
 
 .TP
-.B "-d\fR,\fB --dump_sig"
-Dump signature data into *.p7 file
+.B "-d\fR,\fB --dump-sig"
+Dump signature data into <capsule-file-name>.p7 file
 
 .SH "GUIDGEN OPTIONS"
 
diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f7e5a8868495..f2ac654db81e 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -16,7 +16,7 @@ Options:
 	-p, --private-key <privkey file>  private key file
 	-c, --certificate <cert file>     signer's certificate file
 	-m, --monotonic-count <count>     monotonic count
-	-d, --dump_sig              dump signature (*.p7)
+	-d, --dump-sig              dump signature to <output file>.p7
 	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
 	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
 	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index a0ee76295a1a..ec640c57e8a5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -56,6 +56,7 @@ static struct option options[] = {
 	{"fw-revert", no_argument, NULL, 'R'},
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
+	{"dump-sig", no_argument, NULL, 'd'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -83,7 +84,7 @@ static void print_usage_mkeficapsule(void)
 		"\t-p, --private-key <privkey file>  private key file\n"
 		"\t-c, --certificate <cert file>     signer's certificate file\n"
 		"\t-m, --monotonic-count <count>     monotonic count\n"
-		"\t-d, --dump_sig              dump signature (*.p7)\n"
+		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
-- 
2.47.3

