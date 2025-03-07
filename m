Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF9C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 09:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF6781298;
	Fri,  7 Mar 2025 10:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Uu21lPbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CFD812C8; Fri,  7 Mar 2025 10:39:15 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97B0811C1
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 10:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM/NwHny5qPoL5QjOQK9+wVnGTHkCCUwj2Zl7Mjn4og3ENRbf69WzJxL4WzyFVlsVUfiLmpKlj40OGAsMzP7GooTNearX8/n6ffJFiOJ4T9oR5xKYgs80jQoQdPzyiCGswtupiJlwvkKogB36RGKeV8QyjUOWUq/DZpA4/l2t9OXLpc6Ht2HLXigaiRGKJOuxJWler/lfT63R/pT8k05coj0flG/iFfhEpZQZJsgsi4yfbSSNFVlmS0PoCDjsTSvjWWKH/VdNjvfNMeBW3oDZFYyJQbo54FqdAorNoS8yfRPupXdePh4el/ct99Jy8Y4Xxz4o+MJGCubrHvkUED+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeC5PV9BtHRQ5RNN4t9JLJ/+E12bPVGgYwsDkBQbboU=;
 b=XY7wz7Wm64n+ERmVjqq1N0CV1bJcpgeqtXfxrTHh+cMXMrdPyyGhNPzLckdxiELuY77XxDsbIHRXnUbwxLhUXnuTZkFHwg5tSXHsrUEdVAk8UydZWBdhDb1/HYBFe4arqELyKixhpXyNaqm0NyYy6zIrWzyyF4fNHofcvoz3YPth1htqL8MnmLMrikSJaGFpWuH4ffpUMV50UWf7f5P873ZUWU51f82glZg14QWua2xrikx/kSDvowGBeTcm0rsAN8mmysf6zr4hmyXeehcPDQzwZRaGgSvtac5Y6XQYwNQVigdd0ExQ0KSrSgypkSh2J3fob3kNq/UWCCjFQIBnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeC5PV9BtHRQ5RNN4t9JLJ/+E12bPVGgYwsDkBQbboU=;
 b=Uu21lPbjk1Q835CFbhoYTIeeDmnFJoyRn+o8om26u5XH0jheja1kFHAlNrOSOwoAMVi481ZgvgRlc6VRbVxzJxk5l16Ez97hgZd+/xFVSHa/mn8X5kqZkkleZ6pNHMdtP8ZIPUuAYXQFkVsTaftHCw5Jue2DnyoflOWFWrOIq5mqcTbtGKpeuYYgGoR7QcAe46DFVu5wFEQ2gJlhYCm551hlac0TEXdrinAXfHTQhym5SYTfC5cByvvDjqftcH7vLCpE/48pIPEGPlxR6qYSwXAuj/s4FcwivKWMyeaymWF4/d5oSbWFi/yyzyIiXOABBuoCS+EOy6Op7NfTq5Qcbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SJ0PR03MB7150.namprd03.prod.outlook.com (2603:10b6:a03:4eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Fri, 7 Mar
 2025 09:39:10 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:39:09 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: spi: Fix data loss issue in QSPI
Date: Fri,  7 Mar 2025 01:38:26 -0800
Message-Id: <20250307093826.10882-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SJ0PR03MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8b6bfa-8d85-4f5c-bd64-08dd5d5be94c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiks9pXA3KS0lAH2hyy1Gwqs0Rh5elYRBwac/S9iPY8qHFj6cPw18T1m2opU?=
 =?us-ascii?Q?c66Y9t/V2cYE5cLq0RMXmPy51oUs1U+q2aNq+6SfDK8PpqLaxR+37OEvFipe?=
 =?us-ascii?Q?M5w23bt21pE3U4xM9cId/driIu5subab/E+EXZdtx/9klwM8LAXQI3w2+JTy?=
 =?us-ascii?Q?KIQoF/CTBu/T7+HVXAs4uNRl+rzABgKV1RpNG0txEFLp+ei6CHdAxaB4CDxQ?=
 =?us-ascii?Q?WeSLOAuezp3ihEygxeXBs7O3tY0ZIdj8SRN0HiESU8mCDKFN7+rbImNPgDeU?=
 =?us-ascii?Q?Ke3OHJ5LWGZMq0S1C7CKEOeP6nk3Zzu6ZLSY+/sLYEswNeLsITFgUAFKrqyT?=
 =?us-ascii?Q?rJbtr960FioPJPMQ8Nny/XPj2Z/yIRlvwo80md9v0MApQI4vuW78Y20LFXMA?=
 =?us-ascii?Q?eS7pGbnqilTVhLBuXejeheQOckpvQRZOwS+QUJuqZ7H+QeoMUK2ITbix86oz?=
 =?us-ascii?Q?0/7dWDsP7ohurugLPzAX7+vDTY8/Ij2Uw/anhYK0ZcIUW7vGAZCUtivbHMB7?=
 =?us-ascii?Q?lDHSV6iVJ/OEgIf4uQPi32uqkef0JVmG+osMsHSunTAAIfLzCJExoqqIfpR9?=
 =?us-ascii?Q?ZUZXP98EuobEJnpRG6TDkVO4QMDA0L/8hZne+urUAunrJkU9FP5QjXqsec55?=
 =?us-ascii?Q?dqZV02ooJLW2KMFX7xnL0aVctCg/vxV+3HFipRHi2i3Ps5ADf8H5/aLsJvP1?=
 =?us-ascii?Q?FyD42VAfwvjTEvoWWx793muWyvVXXaKyEkeZL9lS0v0GP2j4lwhUOsrpPn5+?=
 =?us-ascii?Q?rHVNFKzQxiBZDYaj2khN0IOGNuTJyNQYQ4GFrdiuNwlFZWtLu+z28gws7tkc?=
 =?us-ascii?Q?sa2UKIzGJazW+wn7mRPxZDP7iZSr4Ykn5dBedo8YVscabiVSzzSZGBVMEvgB?=
 =?us-ascii?Q?b0mCYEH1y8BzaRlBmO6QTsYUsBjjfPBCkpkYAuGVeBgdsP7gyKefRT9bl8p8?=
 =?us-ascii?Q?DcWrKe1j0QuTac8JsC7MSd+9ckJXl+qc0+w8nJ9bvIJSod33BZxd5NKVp0rf?=
 =?us-ascii?Q?+gKMG9fHhPZoS765VXuJritmbnImj2cdq/Ak07YVCJcYxq5HpWZvpyfLBBem?=
 =?us-ascii?Q?dGAa0k/5Yeaa2mygvjUiatoNzDESHDu1ZN06u+I6B5cd72d+Mn/ijS3On1VC?=
 =?us-ascii?Q?kbsGkuKoVuChoB/R5mdtwAMeHRYSd2nO2ysMOccirqEn8Pl09hGVJ/1EbJWS?=
 =?us-ascii?Q?aIc0vOkibMKppngzIpoy2l70bmvfdqIx9sjmrcdH1hawfmyEaWpnyL6JoHRj?=
 =?us-ascii?Q?o8t5y7U6AcZFDsEeLmtosj2BKb+F70Wn5gB3ZnbjaXSfKngSYe/dArAXJdtX?=
 =?us-ascii?Q?bVfwyaq3rGDIOV7tnRK7swzfdhiGJBOwdR3MYGwbCTxNGh0bj+6VX+60k5mp?=
 =?us-ascii?Q?mQ19Q3IXAP6rjyrG6Z8kfxPEB15g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxcySAIjOdf08lLOa+HKJkMPQsDcRpwm1jHiUMHwGKpxnT7hXuOoT8zhV2bt?=
 =?us-ascii?Q?UmmPkP9h3weDTZrxBh34CJxCs4dLP+cvvUnRJ4Ss4Qp92iMZF5K+stunwNIe?=
 =?us-ascii?Q?P5/XeeLWjOCTglmIQWYKM/TlATTaS7H8JZQuCHNk/sV0aH0sB2FZHhxl+k1b?=
 =?us-ascii?Q?LgfxaCujUyknujivE/wKH6Qt/Nv90XI47PLI66HMsW7YgWsOpTtb5edFvypB?=
 =?us-ascii?Q?gNLuwmY7I5kYrQk9K4rMYjx0Svz0+Zw/SnPvN+QdHEvbuvhOvyBuXCneSEH8?=
 =?us-ascii?Q?eIW4C0y9flvOoNjKayGL7I+0U9TGv/yxsA9iNSYjiYjvadeiQyrauyoDEEND?=
 =?us-ascii?Q?+B740Al3tjLB2Glnt0HRQ+pq7nBRHAsc2Z8/PVtvXRg9i0YYjp/dsFkmtfu/?=
 =?us-ascii?Q?pxWYTv/4wYX8EUbvhwpC7IMsX93AvdDqsfWym1jbuhn66z3H1V78MMlERgzR?=
 =?us-ascii?Q?Vv95oS3Qy4ONyC2Dx9pB0NHZXa9A5izxWaJq1ZIyT/ty/gsILtqqHub6BBWa?=
 =?us-ascii?Q?C9Tfym7BkjaO8iwzq6ATuBFNfbzv5Mr2OFsPDub/eHNSeh9Jyen0E2hSlcdv?=
 =?us-ascii?Q?6SGI2PjfGgN3mHX4RU4UsLkmJ4ZIsBvQs2tCnW6vC7XVO8gzoaHyMHLSxjsm?=
 =?us-ascii?Q?QBxijVi0ePQcpwH3Wu94J3Uj6/+PQimpSlCmLOGB7B6mdveBd7DCS4mFOMdH?=
 =?us-ascii?Q?0C2ziWuT70UslC+B7AyYOiYwjvVetitO/tLsKFPOHRiZhq2Zs2B/Q9ambuRK?=
 =?us-ascii?Q?R7PR05K91N0vgZRfwQItwRI0KMF/vC0WVzU+vn7L+qKf7q2QO+eXESxRh7KT?=
 =?us-ascii?Q?W4BA+GW0C7GjCBiITb0BAGgeCpDupG50cKppGLZuV6BeVkjt9xLJXAtE9yk4?=
 =?us-ascii?Q?cJLKQtMxsOXcsf9BIgs44veCZegJ5fiOgOP0gTo5EkbuSApUHrBAKaqI+2Cr?=
 =?us-ascii?Q?zSZ9fYzp23EnEJ0PMws6jIGTaq6CE+hLO/Dn+/sAILB+Vk6Lr+1gDVN26hVI?=
 =?us-ascii?Q?5PFxXHkNEUM99UF4MoGHQtQRBr84NU44JsY3uL4b4dqcr6UhkMu2zuajdz1j?=
 =?us-ascii?Q?i1E36uskuLMFkXlmXs4bJXFOEA9TFsPFKILR+SbPsP6PADIwWJBttDp76cm7?=
 =?us-ascii?Q?WwMIPo6qkaHwURvvOJLTM239w2qXFNBObZHX5Q60Jh1NOVm2QowbZ94It+FE?=
 =?us-ascii?Q?XlXfBfc/vDv2mEWYombJ7V0eKyeIWRoOUT7HI3+si1R8dYSJQ3/lrc9XdTBB?=
 =?us-ascii?Q?G9tCP+G4UcKFlGLLhydYnV05vDeftgy5w8gLxJ5kugNtXB57zJnVsvt1pJOq?=
 =?us-ascii?Q?a0x0RfD3GshxipyuuqHKtR6Jvt6bUFujm9xKpdvSpqvmyGgBdzB++BHYYxar?=
 =?us-ascii?Q?TR8b5McCxsb4JBCEmXk9iEZKmy3nxi06JjZNcVjoVGGbwSJpgrIvhWk+/lbS?=
 =?us-ascii?Q?oAEMR6fW/5MfLJK4NCQtFQ1w5f7qY2ftyd/x4XTcKdNsvoFQ46VA3oBInPut?=
 =?us-ascii?Q?5dPqrGm7/4QBYrG/EMDzpjKx3p8qrzVP4ua6DHY7+xFa0XNiBjXUxWuEVvpW?=
 =?us-ascii?Q?ZjgqUQj0mqpDZxsARTg9J0HE/oNL21UaaH13Nah4XbXEELuWZB+JOjXWpX08?=
 =?us-ascii?Q?EJb7I1U6wFxwxQ6GIT8+q6s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8b6bfa-8d85-4f5c-bd64-08dd5d5be94c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:39:09.6703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSp6q8K1tOKTUaeZWfYm6UDoV6+2AqnS7gXj9mQLSQxNiEYfDVWhRm+3Fqmjt6sOs25uoRLVilAmfKivxC9S4xBYK2kRn8JL3dTSdpWjAR3xBX4WdjjnigqXxNhTNf/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7150
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

QSPI driver performs chip select operation before every read/write
access. During this operation, driver needs to enable and disable
the QSPI controller. This may cause data loss if there is inadvertent
halting of any ongoing read/write operation. To avoid this scenario,
waiting for the QSPI status to be idle before next read/write
operation is implemented.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/spi/cadence_qspi_apb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index f2f69cf9f1..b579699d2e 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -747,6 +747,10 @@ cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
 		goto failrd;
 	}
 
+	/* Wait til QSPI is idle */
+	if (!cadence_qspi_wait_idle(priv->regbase))
+		return -EIO;
+
 	return 0;
 
 failrd:
@@ -914,6 +918,11 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 	if (bounce_buf)
 		free(bounce_buf);
+
+	/* Wait til QSPI is idle */
+	if (!cadence_qspi_wait_idle(priv->regbase))
+		return -EIO;
+
 	return 0;
 
 failwr:
-- 
2.35.3

