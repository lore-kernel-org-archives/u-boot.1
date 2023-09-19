Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32749CD54B5
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936E686B55;
	Tue, 19 Sep 2023 13:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SnSRL6Fl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D566F86B38; Tue, 19 Sep 2023 13:37:20 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B2886B48
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRTYMP3Hd0zhgeBAAl5bXTfnlUcQ1puXxBqA8BaN54GMEuvx9EMEDAieysPbQSEYOUcVQJswgkw8mPv98KvwZu9NGMYm9yk7y/ev95rFiMYsC3TKG9FiA2pnf52dN3vnQad0VvPcebakY47swpclU4AodmRYaK+IK3Xv9f3DDIDbqL7EMaO4kW/moOsEAoPkf7pnVcDO9bwC2o+5D/HhCrmaBhm1425jDQuluBVn53a8UkB0KLn2ouhbP25zM8tq1YnjLW9e1r2SP1F9kZoQYAiYogp/XBOmgnsXVHcggnBrvm0wY+YzK+HVZJrjRahKDZxo5iPlIcIxG0kE8CIb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2usS8X6FqrhASkVYySIML2AWhPRXTsz48b8n5Uy5IE=;
 b=On8CGn1/hoR/O4Rxp2oHsiSLFfp6JajuI72SBDOqwgNGgzXIYRUFamOPwezGpcdvv0snu0nZ+A1R/7ydRWWAu1eLmNrUMjjGFIt/1Huu7dJ9GB6CIQcrfg4G/llkjBOnJuIRCXgdJnqyx5gxbWU+mrnuEVaN6RNvHden3cvrdfij9LT+2SZpnk6RZCebsZ2nRlZk3m8jWmLOA0bu9PZbl3dsz3jNQEYePSNMFp8HbjDzgiCQpr5Ddyygib6ARIIRzpIIwIv3afwpr217cZt2o7phm8x4ELvjb4o06/wI0E4Xj6zFaqkU1/Z3orJk3sypHUv+MZF3QtH1VxxoJfghwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2usS8X6FqrhASkVYySIML2AWhPRXTsz48b8n5Uy5IE=;
 b=SnSRL6Flj/Esc2uMS52/YE1mGMul1TVxsD667Izs1CfZfGxyKJbwoUT+a3RHnxlC/p3iOXAX1XqnNBFBYmLyCq2doBF9fLeS5uzI6t0Sv/ubO8yP1ttHpvCAYL6kybvKGRZKBS1wN+CJvY1rxNUGNBJ8MdHeG263PcVASjfndHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:37:17 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:37:17 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4/4] binman: update documentation for fit,align property
Date: Tue, 19 Sep 2023 13:37:05 +0200
Message-Id: <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:208:be::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e84ae7b-1581-437e-56ec-08dbb904c70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+UiInNZWVUTFlMzX7ohkHSnDoMWBUCXefVb+v5FBistmAke3pfDWLtw6Sw1vggQMJ1g5pAJbiKJGlt5fRZz8ib72qHfMd8+QH2/XoaA+s5cPrId5Pp/wCC3+IlvW0IntbhissualZohjKbCqHLLgNrDbgHpfNHpwJMCOK8EOlvSLaBF9r70i/qYJg6Rbxk5f00zsQDVjfuAnehcyX1YR+RgvmMeQ9nNNqE8JcDQTP5Z9MM6bVqqDyUptCHHVTWCxrh1iB+Z03mzl8tLErrtU+jbGGyZ1xZsHhwNQtgGqIDY7bnUNHIpRNuBjlye6OCzV9MxXBHXUTfCnlB1lPhCEX9GjTBJ3zdb7Fuez0uR2RdLvy6N15LXRFsuqGwm0adxzE8BDulSEXXmILeL/z+SZPzJ0KTSpy7P3n2SPnr3574PD/KNjY9lTRlVHtasQe3tN+YyN7PkNLohyddmiQe/W0JLtUVu2D08CtgnXWlyM0BxvAtksTKYZJRGp7O6MLPw/GMJPauHSfSGf7AHhYxuMl9ce7SHsqll/Z/VfBdydb12R3pI/0VC2+qt7VVKCqjiGd43b3z87dvny6bnK0l70Bsw6l31fOwgkB/Xkvvso07Jw889lmbSx56+Jv2M7/nY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(83380400001)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(316002)(6916009)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6486002)(8976002)(6666004)(52116002)(478600001)(6506007)(86362001)(36756003)(38100700002)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?asEmmaB4SfI7AekVynMtvLpOkcJRLF9400U29ap3awxCIHQchUgHUuwnqVRc?=
 =?us-ascii?Q?8RvBMkjhkVZf2he0p7p9yPATQ5SV9siSuws50pdFSiCeFmGlfwFLrZVXv6Lq?=
 =?us-ascii?Q?vK9Htr1H07ZwnN7XoVtDpDFMZan2ovvNiOjUA/eTmz/Cbyegli4LCPZIqZlK?=
 =?us-ascii?Q?yUrAL79cD/ykZRRdaFO4AmHlcxI61DHVDG4zYQJJ3EeP+QKgrYCkwuQ1p9IN?=
 =?us-ascii?Q?KT6MPThk4wncX9ONnoJI8Q41eyBR15sOQNNd3yzWJcdfL/oQcjQMbbDKOwbo?=
 =?us-ascii?Q?bJAuxNJzZIA7XO4hl9bO6qoTdqwksbPriIor4UNk95lhe3ULFOPb0Pnegvfe?=
 =?us-ascii?Q?y21MhfpId6qH7ywGcsGsM7jqG+1jdBtpMp+9vBYwlabolumflJG+fgaFsKZP?=
 =?us-ascii?Q?bnarHQv9YiuuFwd+dFjqg8yjB/qQoN4wkrWZNY9zBUAodLa0saJZFRZEZzy/?=
 =?us-ascii?Q?Pc7taqwq1hZYvqBJ2S2nDnuvQc25eKRp45m7lgYc5m5shQkUdvpWlUOAM7EN?=
 =?us-ascii?Q?hTYNfXfbRaHdpFV4T2FUywiPYsKaIJ8jvELoHVIZtmpzwKeFlHBdk9s2S5KW?=
 =?us-ascii?Q?AIirQPzkIJwov6LK6k1yj7GdOAxHEtpm8bRwP6V84g8RKyM6pC3pzWGUyYv0?=
 =?us-ascii?Q?lJ/m7ktzSpJ6IuGaqliJR0oX2Y/pSPHexYggT2h89cnNIyWYs1l55ubunz8F?=
 =?us-ascii?Q?O5kjA4xwV5ySv8esT5A512N+B8oZPp+BrTWYIkt7Z+kdWNL/oN2pGwGyghfH?=
 =?us-ascii?Q?koTJ30HP+jMCEYUqDfErsoVKTe+MoQgzBrQHV3lhVirbdBGNcpVemU2oJIXX?=
 =?us-ascii?Q?/ugzQNDhrynNTwRtffBPz2aFvTuFxTH+6jaN4FVWTkQZPpgie3JAcEwSSWdH?=
 =?us-ascii?Q?4iTbj941AZlScUc/6V7kk/qFG0CKEPyJuBWYriYJyu0Sr7YeMJFhrQEO6iE/?=
 =?us-ascii?Q?9HorUTUgWSi4W9YCpnkIVcODnR8lTdnNfendelwrXnRsKBUh/Sg555Nfx6Vb?=
 =?us-ascii?Q?CwRpfYY3OFNEyR1e7XcJXadWr4tHtIT5ZJWqvdbYphzhL2Wyg6kQG9lyOTWl?=
 =?us-ascii?Q?4i7xenLM6jHp+/tMosAfA7d4Rw2mDYq0bdAn8scKKotplG1lGHeSfA6TcezD?=
 =?us-ascii?Q?9jGVoZeapITv8EO54wWLcr2v/+aQ0y9QnThISe7M78r2Y01uhax8Y25GG8ag?=
 =?us-ascii?Q?e+h+5HQNSv7yVX82NkMMMIZ2pVyCc/qN4oCK1SZb1ZQvYVTQJAZ5R4PmrJJa?=
 =?us-ascii?Q?3WkQeFA95BTpnK3twn22p8SaRJO/kkgK4hwM5CW9S790mCbfpdnjEb2EGXA+?=
 =?us-ascii?Q?rrwU9kOfqfp/+dG5BQvwV2O88fN7H4ot7Q91m84QWbbrU9zsYRkgF3odOeIp?=
 =?us-ascii?Q?K9GYe5z8bL5sBmnY33OY0k8vPsGV8vB93KfzoMS6lc2erCivmK1QsxEs4ZLO?=
 =?us-ascii?Q?fkjYGEANz3bj/ONIKuPi93EeYVn8M+tU6zJty+JZPv8t9CkWtwgQRg04CI4X?=
 =?us-ascii?Q?tHvXAAcWlxSt4k5H+1fSki1e1UPlooXsueSQxSnYSfLYVUoGGn2EhODwSEev?=
 =?us-ascii?Q?d0bordz/UTfMpN/XucpMXy5mZdGglutLwxT7mVkVn3RmovI7siCoKSoAwABo?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e84ae7b-1581-437e-56ec-08dbb904c70b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:37:17.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cfWODuPfTIQYqzy+XMR6HvqE0Nhx9ZO/i9VcwW3p/Z2LcpmVLcD6B6e16LOYHJvrSI/wyNigugse0jjAMd5WnEc0eiGPW74o0K6iN+5eOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
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

Eliminate the repetition "what alignment to use ... and provides the
alignment to use", and indicate that fit,align can both be used by
itself and together with fit,external-offset.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 tools/binman/entries.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e7dfe6b2a3..f9ad27ce8c 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -691,9 +691,8 @@ The top-level 'fit' node supports the following special properties:
         external offset. This is passed to mkimage via the -E and -p flags.
 
     fit,align
-        Indicates what alignment to use for the FIT and its external data,
-        and provides the alignment to use. This is passed to mkimage via
-        the -B flag.
+        Indicates what alignment to use for the FIT and, if applicable,
+        its external data. This is passed to mkimage via the -B flag.
 
     fit,fdt-list
         Indicates the entry argument which provides the list of device tree
-- 
2.37.2

