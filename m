Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6BBC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34608070C;
	Tue, 10 Jun 2025 09:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mI+T+eji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A81E82AE9; Tue, 10 Jun 2025 09:29:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B1F805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxP/QI6303gkBcuE6cqGcs6OBdTs8sylbK4IXFAziTDINvEWzczCjZ78U79oRWQZMSZDz2x9WxI+tvHe/ZalG8HWjtDTkg7bFi2NSHH2A6cvrC6pRHhnRUfRypAh9p735XmSlonywBAJyzU9ybhwsDu1t0cEG1SBqgg+tHIJke9sBMty+Q5VAaelurorMIYkugcWmnp69dOO+f+7v3VgGm/kfh9n2rlIaJ716pLuz1vT84J6Oa1mpSAY43HJ1V2ee39yl+zFpAsapk0zWjSw6ISvuSlZJfN4GoDHfOR/G/q1ipUuXRMA/k0SO2sLMn0096i3aImJMT6sXMRplcocWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHHw+4n7QUUtecBRDFKWXrE3ArzAXHlPnxjF6lGlhMU=;
 b=AhFK3+Ip+/9blwcS4klGyDilT0k8e/uoD5c2EqjmXorCoqe6WN+DkdoHGitTKLn354BZ3VtjCgu6gMsJIjXP+w5ExV3zbiDQBOfs4YIJsl5JUSNu+b3t5rdXptfhfPfoCj/fLEyTereX6mRDPUOX+w3JByyLsimev4AYIkqcTZW8QCKOh6ryqNSqmYZRWGUgwZX9Ss0luka5jpK2fRPplXX0arK65/G64WP/YLZYh0l1xNvOpHq8P7BiVBEewsDmNdomFiKljXNFvC1tMfQVZa1KRS4Fd/xlJP/Gb4P2l9/Q5d45fSoR1CEB44bb9XqmJ+9iWvrw1FdKt4lQ5ttBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHHw+4n7QUUtecBRDFKWXrE3ArzAXHlPnxjF6lGlhMU=;
 b=mI+T+ejikgvz2J7o0V8r2cVjAakIPJgxnwayP2src2oQjOHAgorkuAEh3PBEMDDi5AALfG5Pul59KPxdnwxqoMjAp8HEr4hB9xb3zaBl5YaT4NNU2TbL14AaCu70284OEmGWPA/DPmTURMbxd4VNah/6DvDGIlKq0DxH74UR5UuHoNLJSatD2ENhNK5wvFG8+ssAo4cOMCX9SxwoDJDbpZp09tY+W8bLGmlolVBRaxP4s6chC8emLW4zBWbaLU5nZKd8gcguJ+hCDUffT50XeAkOht4gE4LuSPQ7d5TQkpBoTv8fBHwHgKCtZUaPn9IFND9Z03PNNUSAOSD1RPd2gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9771.eurprd08.prod.outlook.com (2603:10a6:102:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 07:29:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 07:29:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/3] drivers/net/airoha_eth: fixes
Date: Tue, 10 Jun 2025 10:29:21 +0300
Message-ID: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa2d0db-0317-4c42-3d9b-08dda7f08a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5TNnrVsPcAlrPd1zJG0zGIk7RVCTGgGu29SC6rQiSmbHwWbHkO5814342MBN?=
 =?us-ascii?Q?VSt5w/gA2NHLc8lEv442PzsD6LnK0EeRt2igEpFvVuLPe5rKwdMCHXq4hrOY?=
 =?us-ascii?Q?X8+W6t6X29CIYwh4y61ex+YxahIovniC+Nh7Og4d16PYTBp0BiJJI7VnWT/z?=
 =?us-ascii?Q?pHadpElbjVv0EjVgliZIaJ/KJxMjRYMldECzFtOQGGhwbz1snp6eflPVAE/e?=
 =?us-ascii?Q?avVbeMCj7pyIyKGIg0ucTdiECcRZyFpr21FWzqJ6T05qnw+T9BPbwGj06SAs?=
 =?us-ascii?Q?GqWyxsYvs+s1eROrtzqfojuNo+hD+x/yTUuZM+LUDbxRPqP00/9HQg9dqLNi?=
 =?us-ascii?Q?60yU4BTknIua/T3gV/A5DMmyZhPsDJZ6BeGSIFCQ5jVB2fr5134aQQjMMLGx?=
 =?us-ascii?Q?uJpPQs2v9eMV5PRWM8ZxP5sXfLFWPsQAK3tZ2WmKGB/ls5y+fIdUlsT74cei?=
 =?us-ascii?Q?51SreB0FNcFGB0wAAcUqz58LlDGDsZO4ssIIvbCv9tEEAkxW/UTo7uMRyxfG?=
 =?us-ascii?Q?tKwSsAFUtleJRQfnIcbvHElZKHhDDmrUG7Jepv9FXageq7v9QbVo/NtKPu7U?=
 =?us-ascii?Q?rrpT2eiLCvMPeI3kk8Dc0olInymozZzW60Si34sgS5U987DfV398ESbmlHJ8?=
 =?us-ascii?Q?AZMEEq9S2cELKLnYlKi0digwWjdHQ1Ap0c71q6uceku5G7tTaElNR+Yhfn8J?=
 =?us-ascii?Q?j70y1O+K+LLNn5K0a723XwuxUP2Rexvjyh5Ajdhsye0SPJzS1GOg6QYJQyFR?=
 =?us-ascii?Q?3lWom3vw8qgQgMTf044U4+lBCuS8KRAiJJIIJyvV36zzS//BvH33zeCvldCW?=
 =?us-ascii?Q?DCFHIyVccBB09BcIgIt0H6uTWnkK9BfDsaT573yOEQju+p0CprRjwU6FC2I5?=
 =?us-ascii?Q?ow81/PysMBDNrkvr6hTW9TFnxC47MKCfk/hkOtg4XDcpQo01xjcjT9IHHnCw?=
 =?us-ascii?Q?Iv5I5k6IpUcvKBsQOcbORlME0Ps/L7X5azFM0tC0wGNf/JEKq5JLyBr0qP/P?=
 =?us-ascii?Q?mJSMqR72P1+y8EdPVwWr84hGetZ7TB8sXM6KMXa10qX3RH193v6JPKmWSj3G?=
 =?us-ascii?Q?FJQGnYX3e4vt3X93c9dO7ZNnEJjEH0+UYeBZvyShv5ncn00nWfPP7Hmgs9RK?=
 =?us-ascii?Q?XfMZfuWB8IyUD3y/1jLdDFSgA0Cg2KXPpA6ShpGIGAGD+Zn+zaexSa+neLIL?=
 =?us-ascii?Q?0dWM7F8ZQ/Hn0Xsz1yAzjB6XHSidA0DbquDxCC9cnjtzAp1yUrUd/eb6QsAE?=
 =?us-ascii?Q?h8FlW4rKsydY45PYDC4oL+7SGeFYE4Nw00j38wDaFI2oj2aL0tBDnmXzqoyZ?=
 =?us-ascii?Q?DMlhDljfMaYJQQ0N07l0OJU2eL6kvC3va6eNL9j6OG7DfEUzIlJs9hazuQhb?=
 =?us-ascii?Q?oQMeCUP9RRqZRJELpfmgyMii6XdUbjKNY6I0LwizZdShEBJblIUgT8vfCovM?=
 =?us-ascii?Q?IZFl1icGY2saI97pNlNybtrnvfwGUCIwm1HbU5mGXVo0+TMJ70vRrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7wUUMsuf/y8PKgV8Vp4x79N6tfmWUTkAMi+Nov22AUxK+JUNWzovNNpby00M?=
 =?us-ascii?Q?DXIj73hPjeNOIrUsJCny91tqGKcS7qScEbiPtpl3VWOgtUaRQoV0iFzHKuYD?=
 =?us-ascii?Q?kTK8L0oeRIHFmHCaHgdeMluG58taAgtoZif05hwtwuIkBmmNC7MzZhjS1jYB?=
 =?us-ascii?Q?qtOErvaYEVFTAdlrf5d0lF5Xs88Fu/OgVZffZzVIpXvJdWuaV0OZ7V3ej8Nz?=
 =?us-ascii?Q?MNFMz12u0GCJzUWhlSWRRyeGJhJPXdk99KtZcE2+n0ovvdT7Emm6e2+e/Pl1?=
 =?us-ascii?Q?lS33ptBOGIo536YsGVBr0FAbrTY0WQ+Cs99ZphZzQU1Bf4Qysz5b8CjcAMEb?=
 =?us-ascii?Q?X0eZwbXLWgxlFnM0V8KS+tJaLPy7VoRiAiqdmRZYehgdNjmhSlro+VfXn73b?=
 =?us-ascii?Q?RGS8iDYFbSMM660DjzGF0WrCeQfWwOCxxmSx6W4gNqcar9Fsat+89tavoBuK?=
 =?us-ascii?Q?U1RsZOSn8p3SgVrcC4v++V4Bok0R8/2pukEhkARlYaR6yW21/RTjPRGoZlwz?=
 =?us-ascii?Q?HE38uHETLbHBOUEKoyftsfOLv+dTMFgH3b+uDl8Y7x8FOjx53ini3VvbAeLV?=
 =?us-ascii?Q?f36C1sLg+r304Opkwp6JhU6ZxlfGZg4fU1d6qKrPvXXm3LBjr8iBl0B489dm?=
 =?us-ascii?Q?i/0DHD1HSOr+Nsi3YkwoFFAho/okMmHS+MrZf1Uu5iHSKE7a6H8afy/2/hjH?=
 =?us-ascii?Q?sex8PMYuUG+kobFVMCQdyjqicBYGgveTUDQGwQGWn1teU4+jjn/tkxH3KV4D?=
 =?us-ascii?Q?S9IQ9kTQydgiBo2tOJN/kWRrMWAg8m/nuy2l9rQdcma7XEsLs3LUTr4lx1bb?=
 =?us-ascii?Q?/JJs2UrpgCGUuatmYNyZgXdjCp3pxEyZ6HepLxoxxqsEOei85pXgGdLPB2Kz?=
 =?us-ascii?Q?OYlrJ3+yQeJ25goXll+KN6TKdpK1YEDCBmsF9qmDbbhWINIal0NTNVTRHOpE?=
 =?us-ascii?Q?fpdLl/flyyqVUkXczumjYIQ0w//4f6+ACjelhXB5TUlwIyBaJElvgbi4aAp6?=
 =?us-ascii?Q?gkAXkOKQK4aNXFXkDDxZcyFQZlOsnI7MZ/XllNOlNXm6KBLcceLpD6RsIl8R?=
 =?us-ascii?Q?xgIo3EtmsqDEGlmclA9hrX6PL8PQlvZLJiwalKnwVtWJzgzN38Gfwn2C4x9v?=
 =?us-ascii?Q?cxtkPlVobqWJXQhOvfXTBHs2FQrXn2WTco96P2qHVszsokGKe7dEDyj6+Tvk?=
 =?us-ascii?Q?D1W+vVRZjc/gcMq+yrEesWZwBspzpA6arm03FjmadYje7grAlamujmmeyzX6?=
 =?us-ascii?Q?w22hF1w7hrlxuR+9MOxOmd3PTY/KjmHLqoZgMP7Is/Tu2BGZIJTjpetEY9/f?=
 =?us-ascii?Q?zGf7M3GHbrSO02ZjdbXvWNFpfgy4VIg1uUKbCEE3alFKoe1swidKd1F4p5jV?=
 =?us-ascii?Q?oH8dQTYYC3f0LVF8plEJRpAzR355Z7O4ldUzi4+A7Xgu8L48xX8wuxkuAy+7?=
 =?us-ascii?Q?X/SiQl1vkyl7eseAcXruV7yxUKYkexIta1tq7C7CaBV5hEq0be89Uic8CZfR?=
 =?us-ascii?Q?JuHFhNnGSIYbXe89FX0QDSaHp/5cxLn7365zZIt+UFuu3ip5X17zJIR2XYml?=
 =?us-ascii?Q?ha/CnSjmkk/N4HT2BLH1fJgKnzOXwrf10a93XSWYjG70xIXDivdVPhWq3lRL?=
 =?us-ascii?Q?Lg0wD2+MmbWoNvxcBh/15t4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa2d0db-0317-4c42-3d9b-08dda7f08a26
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:29:31.2024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZSkJlJ++eQo009m1D66zKW6A1DrVNphEqAGtP38O1rnKQC0gjmUxb2o+HBVJF/pvbCu8QnewWGn+u00xZctSSK/czBWVwSCBY8ywnSddTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9771
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

several fixes for airoha ethernet driver

Changes v2:
 * update patches description
 * improve formatting a bit

Changes v3:
 * national letters were replaced with the corresponding english letters
 * code was tested on 32-bit and 64-bit airoha boards both

Mikhail Kshevetskiy (3):
  drivers/net/airoha_eth: add missing terminator for compatible devices
    list
  drivers/net/airoha_eth: fix packet transmission errors
  drivers/net/airoha_eth: fix stalling in package receiving

 drivers/net/airoha_eth.c | 69 +++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

-- 
2.47.2

