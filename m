Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D418C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B795F835C3;
	Fri, 18 Jul 2025 10:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Mrvepqn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10C1835EA; Fri, 18 Jul 2025 10:56:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058AF835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdS/rgDTaAE5FmX8n/Cwzei9OfCAQ1wjSg61wpK7zVobR8iPc0qlwL2PfUkMb3iaE7vxavlJZMAobejjam9gkcmJNQyTE8mZhIwboR2bX8vR3/1Yf18LYrtE8CEzkyxpjJoEmYdOph7W9mGSRrf3h+/K+X8QmyCEuZucAEPu2hUDjihWyELV10W7XUcaptH89ybOghTPQYuPedxSDAY1QCHyf3KyQFSEMTwuu2/mlVuti2xCCEYfIfDRsbAVmV3Ig5Rwa1ZHSjhT02G/trckq2uL4UOCsf7TSdZ4hycEj6k9rxDL6BYJEVFi2GGr0H9eJWh5krkClewDaxmTXxBNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAL9JWk7QnuvcuIw1o6g17kkATAO4abrVbqyaRNMmZs=;
 b=s7JuOjAICYBJDFdHn3RJnS0SBZaO2M8MUjraS7S8t4nA2QzYQs3cWtKA+8fjxQbbFRuhoTusPLB8+yUZrkP6BjApeOraVSAfGKbs6kWuFXqBsUNlqEUrBIgCX9jlHkUNjGl3mbeXfiyi2p2OR6sScICGLUm2J4k8OTUHigksp+3SARVP4c+sZugBa1BohUjqOkN5n84jKwqvgfrMZ8pUKSPuY0An85CAL6fGQl6/tJdENu6VRJDhwBg7eOIHn2Xb/UseEzQbbqkg3qJhbl8S1ROrgkhfApGleLeWikAj4ekkPySnVtrlntom01ioe3ZUGm0SG9dCRfv23NCh2PWVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAL9JWk7QnuvcuIw1o6g17kkATAO4abrVbqyaRNMmZs=;
 b=Mrvepqn/NS34dlcInCnYNVhd/FQdcV4UcIyN4Yq4HbwYtRfQt3mRfU7Y8/dl00SU5QP+6W142aU4PkVcdclUqNphA+iHIuxZda0SLjC6kni4jP1+zHdqg8hZq8+oXg6jvXq6adr5xUOYptF9zLXOv3AmyyLIm+V3M9vQQrm/jis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS5PR10MB8296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:651::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 08:56:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Fri, 18 Jul 2025
 08:56:38 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] .gitignore: don't ignore .gitattributes files
Date: Fri, 18 Jul 2025 10:56:34 +0200
Message-ID: <20250718085634.13542-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS5PR10MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: df9ba6c3-f1bd-4990-badf-08ddc5d90173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W0nHTwjJr0bpcxzdjuZhnm86y9NCfzAS8+MPhh4hffFR79Le9O12JyHQwfRV?=
 =?us-ascii?Q?es7rdmXEwuA1Wy9QaRPFnOjmPB+mG8NUScU1ntNu7ZALm+sWuuYaeAEZYSOo?=
 =?us-ascii?Q?LjdaSyg2JJofR+ijZMt9aq6f00hge5VpCYskg3kaYWaCmpr7ZDs5nthaYSdh?=
 =?us-ascii?Q?dhVFv0kGwvbBLjwSN9eVNrjOTi3i6YaaWG+MTLRKIVaR2RBDQJtGPVaP1XcD?=
 =?us-ascii?Q?2zhoRIO1FPNY3VJdouF8zpcOA58q3YKRAkNo6ehGCXl1dUx5ijkB7PfJ7z2H?=
 =?us-ascii?Q?LRZBuPe/ex+IqFeoLESib1uzXFQx3OfAi6ljuV3wmzqyI6mohKpfuYRGl38/?=
 =?us-ascii?Q?xq21Imi1osuh6+/ZBPQREWUre2Qz7RuNL/vybW+qpO/Zt9jfu97IMixnFp/C?=
 =?us-ascii?Q?vLmlI+om9vLn8uLU/QOuQBI13MYESXasBn3uSKwsgcwwUnDdQWFW5u6qFeAG?=
 =?us-ascii?Q?0HpndPyplmISKPmIDrXnD9o7qbmlAar/eFS+/Q7lRXWlHFPuubSLm7nYFVs+?=
 =?us-ascii?Q?V+cTjwMRsOo6apXKJg1+sdeEYu8jtR5XOi2GG8cjYZQUfNic69ZIIL3oLYYv?=
 =?us-ascii?Q?SJHrzAF0qmGDK2e4M7muo+1Tv2nFSWqoMyg16a1wnqDxH+PN3HYVS3ml7Rhj?=
 =?us-ascii?Q?7ztc+UK8EYKzkbzdde6vHSB/b2d7Giu6kIihzc6d5dEXmhb3mzAod32vBiD7?=
 =?us-ascii?Q?MN3y9nD4Aj+ZZ2lVX9TqRMjw/+i+kJgujCVg6FcCfQCv58POtDOwROAO4lgq?=
 =?us-ascii?Q?/FUQqruEOPuga8nz5lkmDu4F14pLyr6dzkJO4CyxV1tMjEuGefBbEbNYNik2?=
 =?us-ascii?Q?TpaFWuXxRtuXm2aQQ7fkdnHF055RgeYS0c/Jc5XXojzZ4Nn7NpPE0rzmuBcc?=
 =?us-ascii?Q?wGKJoftMtOFe15xqc+KK58yvgBrtsUPA3F0JPugzX4zpoDq5S/KuLQ3JBNrL?=
 =?us-ascii?Q?FacRUqiPSCP41m/GejOA2maRu2SkgXATVQyUmCsraewgS8w57QO9n9dOyCJQ?=
 =?us-ascii?Q?PVgf3yDMQIRrAmIXaVEdGZSPLOgP3a1XwIZhsfOQCzQ762Qb4o6ZtaP2cCwo?=
 =?us-ascii?Q?vX1Lyhm+r9ZKnRUoPPLeij4sNCG2OUsARmWLzkXRHbx5JeZlKmqBU5nhJvVt?=
 =?us-ascii?Q?wNCOPk6MFEk3PbndMs+FDMMMZDwf73XHW3dneW0dyppd+bjo2PRiMi3IWkEB?=
 =?us-ascii?Q?SnlNH/WI+pngpcSEL9qDBsXx/1kadGngyO/D/SpfLpAQc+AH2thHR2ZpAL84?=
 =?us-ascii?Q?6n8Nlg49uzsPHNfaelKOU+PvPWqFO1lEn84THxaVCXTmGUNkuAc9kubV13Q5?=
 =?us-ascii?Q?LuQeNqk11DonipvHYGTu0+ZcsmiRHVs2aAbtCVG66OdwHUwb77BeKW+pi//Q?=
 =?us-ascii?Q?fvzc/jjbYDsg6K5KXGBNX+Rm8f30mEufwiGbbrxjOpL2w2Bnel3QJATE6BQa?=
 =?us-ascii?Q?w7YvdSJO0s2VbaF/0tIh45A1V8Vyr27reQMW1q8PGJhCU9to4F47zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRJwLM3EdNtQWYOlCmJBt00YkXSGW5veS/7D1BJEr/fm4sdYFsJXTt4ajoTB?=
 =?us-ascii?Q?MWMUaqeBVOjjAxM8QXSLr0eCNhOe3QO2ySNpI1jfQERqY+9nk3IKR/FhRwtb?=
 =?us-ascii?Q?/K7rwm56/nB5diwhOrElBzgB57o7bmuJ4FzOsxiL8vWD6vTCl+gsGI73dbsL?=
 =?us-ascii?Q?GvSqNxJucGJTdCeWatikj7/eDbdDSq/uKBpNsH3LaYwQI0Aq8lKu4YPw9ziZ?=
 =?us-ascii?Q?3aLPVLBD1Ok8YM+uPgm9chBwMEksMdhwC91sBaOmo7WmaU6bpu+9C1qkYEEm?=
 =?us-ascii?Q?meM62r8oITBdYWnU2YK01yLcqGpArO6XpyKlBOyMuJq2rJTUCkzo704HZ6b0?=
 =?us-ascii?Q?1dUys6N9aDtB7oswu73FsDbLrAyGWJ6KROPezo6yoHOTxU9eCJx+Agn3ztGg?=
 =?us-ascii?Q?28eCjNMQe9uc2+nruqINRFeiRWDWONZjas4sRw5+tPdvagNrkvEy9iFopE5p?=
 =?us-ascii?Q?j1TG8NRK9vb8N9fvimHkOZZS/+fm1GdkdB/JCsCso7qfzEM+BjpiN+kcye41?=
 =?us-ascii?Q?6I0nnYMvuslLD4XDMbLtoV95wCHp4QMiEy74iSlsyuoBQdneEkmJjtYp3a0H?=
 =?us-ascii?Q?u9z7R8JBL3pSiOvJYdwt+P5XkVQFr9Pih3BJRqwc1l8l6iskhQ8gFG7U5F5I?=
 =?us-ascii?Q?d1Ul/qTZrWkk4/2PkW7s7PRmz6ezvr00ycDQj1s6bsQS1hRZ10MC/bKe8hoi?=
 =?us-ascii?Q?hBAD0fyV5Lc+uJAcVNu+N7kYHFkSc9kPZVi6CvFcWKvszyM2YeG5Q7WCExUF?=
 =?us-ascii?Q?xEPHbcslPgJiAOpjKb8xuLO/FTw7XcjY2Gf9w4eYVF5qgArCzQq28VcjTDnG?=
 =?us-ascii?Q?0ZIQwTOJKsohoP+qGtGW7S/TMCancPnLBrNlLQJENJOUIZQpuXQCaVTE57ee?=
 =?us-ascii?Q?qpfIgxZpErSno77E03UEVVR/cb5LrlSH/KFsqXezf7wMZk2R/9UtNB/xluBd?=
 =?us-ascii?Q?uN9jbenHAcgPyeRQ8fNDkHLBrNC3vhZTjVHJ/7/U3bSMp4bEqe1I/BNJDvuH?=
 =?us-ascii?Q?oHrDrD02L2sObVLkLoscpt/aGRAv51gL3YDo8PkTy/lLJPNmuaa8FIIenR+e?=
 =?us-ascii?Q?T5ONTW+CykzWoJq8ZSma9+GZygQOdayqWRkwm0MwaRk5qQ5edoz26NUCouE/?=
 =?us-ascii?Q?yOdq5yMw5Dmr13k+LTxq0c9D0FdhDNt+AmSKgaYcM3sLobSJVm6VkQiGOjEh?=
 =?us-ascii?Q?v3qclzEsByn1GcUxPxh8tCrOjt9u1hxOlNbvn/tIvnAY2MEULS8ozx0eWxK0?=
 =?us-ascii?Q?lVEtI6FnIY5Okd3ijt5F/4GTe9l4CcsWfwS1aLhysnbMAKsmpEBHuO4fogpc?=
 =?us-ascii?Q?2ZeaBfWy3XKbmigl3IVZLVFWTi/O5BofnJppF5hNCzjEsjLTI+BWkxwbWkUT?=
 =?us-ascii?Q?p6eJlpH4ivuXSv165g9GflUTXSmFpIbuna+OxQHrB+WkqeACjOKjBKKC3CYs?=
 =?us-ascii?Q?XAQRwxFTX1UahHGst5vZQzPdZg47LvUw1YmMsIKqhEoaJ39Pn+9rqS19ftd3?=
 =?us-ascii?Q?7bLjN/k36DQyAIFloh0F+CxgkXJoE1w8KK59Gr6XahP8w7/2uKN5TTpDDLLx?=
 =?us-ascii?Q?ymjtwWoibp1KHsoPa1rEPqxNsCDci9ff0fVZcIRca3ytzGnkWvT0jNtUeEWE?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: df9ba6c3-f1bd-4990-badf-08ddc5d90173
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:56:38.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGxsfUxFk79H8DydasvLGVTwCVEM2ioWnlz0GhkzZKyeNYr7cZl0GRYViicmtp7+dy7ntjB00hylTk4H1UOZrOQ0675gRs271jBICZ9v0JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8296
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

In a private fork, it's not unreasonable to commit various binary
files associated to one's project, and thus put a suitable
.gitattributes file next to it to force git to treat that file as
binary. In my case, I have a .xslx spreadsheet used for computing
suitable RAM timing tables, which I wanted to put in
board/<vendor>/<project>. Git duly warned me that it would do LF/CRLF
mangling, so I also added a .gitattributes file next to it with

  *.xlsx binary

but upon adding that file, git told me that I'd have to use -f because
it's a dot-file that is by default ignored.

Add .gitattributes to the list of dot-files that should not be
ignored.

While in here, sort the list and update the comment, as there are also
files which git itself does not make use of in the list, cf. linux
commit f46e65da48b2 (".gitignore: exclude .get_maintainer.ignore and
.gitattributes").

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index bb03833b5f2..6d85b3aa238 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,11 +56,12 @@ fit-dtb.blob*
 /*.log
 
 #
-# git files that we don't want to ignore even it they are dot-files
+# We don't want to ignore the following even if they are dot-files
 #
+!.get_maintainer.*
+!.gitattributes
 !.gitignore
 !.mailmap
-!.get_maintainer.*
 
 #
 # Generated files
-- 
2.50.1

