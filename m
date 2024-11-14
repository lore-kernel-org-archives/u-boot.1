Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082FBD637DC
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7431B895AF;
	Thu, 14 Nov 2024 04:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eR/xbKl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2524895BD; Thu, 14 Nov 2024 04:36:56 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB914895A3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSAEgroDq/Qtrz4oY64q33sYyJiqqbC/fhEgiQssHlwUltzImwHxkyF1DUHjlha/HcfbyNd5eUkawUGqJK98EfAhQZL4BuQSUVWoY0j615+Lo4D+RYQhomhamhOFsrnQ7ylArjJ77FsCzJZY+kKk3anT++NPZTcj/KFunjs0H8pooVLYaXQIQWQppK7j42qCBoZdLTvaq3DWpUp3o5/rKcuFSobaC0gVglqpo53q59NZg2W0GhBIfinKhvLQGs5RuVaccv+811G8xFEQvQQMQUgWYVH1nVcd9eRZFxs+twlJMTTcwWN9HEfJO8kJgqLYqhSj0IYNUGZnQMGnCl1M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=uhMpjDeUbqahwS+MVqne0xsUJBSRauMqlBXDCUZQKBB9O3/muRde7I1EbzX1BI/UPEJC+XPoLYaO5/DxRxuieMtnQhUrYEa3jD65koqbvzRHluxenrrs1SEBXWvnrHcEKvM7vgH6/IjipRT7KsFIzv+YIkyTLJOa91O/1AFfsYfFzgtOsHLKL/3eBGn86stSc1ihJFVn9WxbK2IAAPqCBUvHL0N4jOj/+qmcdhkVLMOx6PfQu2NnZameiZBsRtMQkIfyagRi3OSxCdzLc/AIpQRpUKzEHDpjl7PwEt6QOMow4YJoNiqszBbzlFiyxt6tDrWTCL/XrjBIpoatrj8Hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=eR/xbKl8DxoYE+3oR6ogzSNv/TJ1l6tr/iVi4FKbFXR66x7nuxVcH7PKUhenGWaybidYpZw6VA5cKVgUl/7MnqEQ1whajALwMbpBxfFxkjwHUTARvk9FaSx6NF9HcRSP9tiVZWoRQNCGu5SoZBg+TaYGgGKnzV9el06cOESnQOu4c+dE9JrphvvrBuK8NLddCdWanHvR88g8kByUPLjQ63JxQRLsZt9+ZSWLaoQsvc9lwTXBgo4ZR8Gz+ceAmc+eF2JOc2TXQW2vw7YoC+AtxycuVinm2mBt9Y492b+KlNYjqefXvXzNUK395VA46YdA2Pq7nVPVK/Q/7/oZuLh4dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:36:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:36:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 01/10] net/tcp: fix TCP options processing
Date: Thu, 14 Nov 2024 06:36:34 +0300
Message-ID: <20241114033643.623355-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: c78e867a-3ba3-4367-d439-08dd045d9471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RX/yWJzO1DKU8LitF6xRQeZIl4gYtXrLbtEoFw1++hdb1DcGqempChr8dzlS?=
 =?us-ascii?Q?2EOWK83YX/CjV1vxI5iJPEqQSgssVND2MXckLmCZMDNCVaroeY4uOvutVN+q?=
 =?us-ascii?Q?ydVOOsnNDvW9ez8ZsXPjn7Ox2S4tEwfgYIT79fMrSDYfaaBEN/V0hlboYLNF?=
 =?us-ascii?Q?Y0Jb0bsR2TfRTQBD7YyJWZ59dceMkcqAYTEOkD1/tPLqUkcqTSfQ4liyfKMG?=
 =?us-ascii?Q?VotCGhljiLfeGgIAbg6d8ZF+Ej0p0uKm0Vl/ieLmNKK5ihUGfAnfQELNNHTy?=
 =?us-ascii?Q?6xHbbxSOOkO5HV+EA8CkMwj+/kGIwqSYU+6vc9fpyuwzPxCH8uuuNCZmvJca?=
 =?us-ascii?Q?SH2c1wVhFHUjjTpAqWYFO/xKoZMhSks7EI7Uw1q2+5Hmi+vQm3LUTZiO0lSY?=
 =?us-ascii?Q?J/6jOyBIRzAz/rMsrEc2ayu5VEcRWwIm5+M2uLommvpTpJL38eihZWlkuJ6C?=
 =?us-ascii?Q?FwqJczF1LQTkQyvxxLimxxxyUJduzwcIiAHf7cnR8rt9WwixeRoVLOf/7rWx?=
 =?us-ascii?Q?YiHgKZvMPs3mJLVDjoxx0tIm2d6JOJ/rFnexhpTKHPgc1xDL+3rqeFswN1wC?=
 =?us-ascii?Q?dZ5dYUg45a4A6bRWFw4ePBiS590KWwdu97n8hDTVmGZr/Y1XsaJ+FUnwRPcQ?=
 =?us-ascii?Q?jgLWyx5CV7oyaDphnQChgWu1Os9Di2MJX1XUnNPMJYukrRs86nnPC0DX0zUg?=
 =?us-ascii?Q?9mWiXcUQz29YgOiJyOVFrY+McHLNBsnhWZm3JX2j2ab5G4mQJL7DWcD+Gg40?=
 =?us-ascii?Q?mBstreMlXmMi3LojFkweoSWMXEulIIHxVLJe7dVZQ5myTCix36+5loMArNJz?=
 =?us-ascii?Q?FzcdON1PLKnqfXJRi+K1dPeBYCYq11fR4DeVlph3Ed4jfqRfjcqicTUdj+Sv?=
 =?us-ascii?Q?iiHJCYAMBX2tiRh/HgoUJxgsm+jadmKw1fBO2aBHAzzrRgfXsUV0el/jUpX2?=
 =?us-ascii?Q?vuVEytQMPx+wArekwptZ03aqSrGAFppCkw70Zn63aUK3djd3I0I2ElTV7/Xf?=
 =?us-ascii?Q?/YI/znlhF/17o+ipyJn7VxUbHVwjMeU5jxVWfDN7W+pvA7J+TOLYZLQL2gaO?=
 =?us-ascii?Q?HOQokxP8t17sjI4xTuwSkRlKieosoolClMsDF2xKll2EIq/R/b/n/DgCt1X/?=
 =?us-ascii?Q?pfsdknVRxoYISzeYmvmWaEwsxNFhjv4um+zkAijgeqVQNY7IoUItkeKkH+HP?=
 =?us-ascii?Q?NEuQ4flCu1FvXbstAtUjTtuNscefsRiLez4npeVzXXgYE3q04sS56B5/FFZL?=
 =?us-ascii?Q?abI5OalLrNbKNfyYkPThnvxyrFp809QUtGm5mTAoUOYzET9QVHMG1YLxGerU?=
 =?us-ascii?Q?vOsErzomz04hM0UhKRexGvlBbwosKqfkEX0AgMasVsySIk2TASBb2FAayZpU?=
 =?us-ascii?Q?Xbxug1mg05NezB4SHTHnu0AfdINv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBhCWnvBWKGH52/w3I4RU8GMXe8x0mLINCibTkHwncQPmYOBXu1sTY48+MsH?=
 =?us-ascii?Q?yYFlsAWAQ5hzkmom381sLDLlMCXcYs3l6U+64TFrIQPw4dLtGMFNaI9Mamlf?=
 =?us-ascii?Q?9on48LhuuUmsQxQ6E16DqVqlmQJpSfhMNGB0bVp1b9bDV1D1pYBT5Fblfh4B?=
 =?us-ascii?Q?6lzHbIvi0tCYMWEnAEpSuMmmA7gKUXi1ina19wDDHGGrjRYkBULO/V4T16R8?=
 =?us-ascii?Q?p3Q0tz0xMqlVlcK+RUZ+XQN6j7N+2RtVb25CxXc33nWcimUdSUn/bX8bfDDZ?=
 =?us-ascii?Q?9zSdMAXfA+5awqf71RH3GUYP94M4fTudLBfeHwjuVf0AYESknpE9P/EL66Nv?=
 =?us-ascii?Q?lxDoJ08ZHY0w0MzsSQSRtSRjEwy7qbWsI+fsXd0MS3OMJr5OBHDrlkfUanM1?=
 =?us-ascii?Q?yDGH0ahR8X6KOAKlYQI5jPMJpzh0cC/cdAO7QAcMymHIJ7Q+ANNMeRIkSo+R?=
 =?us-ascii?Q?uQxGqxgqt6MrPVGmUNoQukUDnVLP33O/azD7LDqfrs2uwIxqkL3MF3KCJM7j?=
 =?us-ascii?Q?p7gG6jU4YWsJ+WnDRRmJX+sxdGPu4mRtRakW8PH9WDJGQk3uhbmCClL3DYK5?=
 =?us-ascii?Q?j1jvpFLoagIPeqsNGsI9T2kKC6a5bBi3fILeXz+hR9kmYyDKV8HkPM7TKzNG?=
 =?us-ascii?Q?W9+0eCrwbA+zoDLbHnlNKbWOtLDkTaQMMVl7X3D7FViA4jWExBdTkOUFKg9V?=
 =?us-ascii?Q?0kEvj2eHJYh8Vb6vMLJHasBVlYZd8mIMLT9wZYYIdHBDcKIC7b/ccRsAtbKs?=
 =?us-ascii?Q?HIGKiXkPZDkNc9Ob+5APlT1Yj2p/HWSqBSVH4M0POtuUoEDyrYrwGxNPj09/?=
 =?us-ascii?Q?b4nUx+YXAiG4Oo8R7iX8RIVlX9kPKfmb1TPC8rB0tLTWrx0vClLJk4VzRBs6?=
 =?us-ascii?Q?heYjD2sdm09rJ7gHrJSE+2m0aSk9YGC2T5YhMa3aT5xAIoLz125hJzMt1IuG?=
 =?us-ascii?Q?4T15U6aZtedlM6D1f257cERNiaK65SMqs0AOFc+0XoobPJkwcIn+A6Gkvrh/?=
 =?us-ascii?Q?KnYeXZFAIM977WdabqOei+cNsBekpx6MO4W1fWe664nT4rpvQI2QATyGUVAE?=
 =?us-ascii?Q?Y8nW2hrvU/hZk+IWKbyTWUNb9o27yLfe+Gn1hMuR0eDEudVYAlCfWbi3rPDG?=
 =?us-ascii?Q?mjMevrQU5agZm58bNjMjCdZlYeI4KX5sl54pb4rYTo01mzqQvoRMLjzYgUkr?=
 =?us-ascii?Q?p1U9Vm0/8hqaOe6BqOa26ZUrokADJyP8cHCXdG3Mr0NsK/nO1oL80kcInhQb?=
 =?us-ascii?Q?UqZWaJbrm5oHQWLHAKS932ukUL9DVT8lpRvX9Q71G3NKOzDnbRW/eZMd677M?=
 =?us-ascii?Q?1rpUf5hkWKtFkHDlzglcmeVm5+9GAWxeLHtfxx0702VzNQD7qm5Dh/lYTigL?=
 =?us-ascii?Q?F7S1H6WE4wYMOdR0sMBkmP9aKJxcelZNicOCiFsMSRdLHcu5m6ELpDCFO9qW?=
 =?us-ascii?Q?/eMIFoIfYV+JgKzW3e3N1bRKjBU91qqZTh6mwPMN5Ay8YJoUBXG1p6B74mS/?=
 =?us-ascii?Q?DEh/HfKQr3vOxv8GqrGWCd4aWUi9s1uQ0JGGd3p9FXAAuxbLTYW/8ozh0ug2?=
 =?us-ascii?Q?gacfmmxr/xDX3RsikQCFROYHyMaZ9rec/ASTrXBwYmvfHecwocdVd0KgQtTE?=
 =?us-ascii?Q?jPSQAGCYmoIx3Err6dClQUs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c78e867a-3ba3-4367-d439-08dd045d9471
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:36:52.7290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBOOV0IRzsPAPe9vlp/N0TMeKHao/xiGGZUxXKpvFt+53adJ86uymEAUMfW3qh96uF6WuJtRwBFGavsiR0n5vp7aDlf6wKSDvjyMkllPDio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

