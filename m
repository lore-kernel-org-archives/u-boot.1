Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC54CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784B98323A;
	Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lZmSY6Ug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF32801DD; Fri, 19 Sep 2025 12:10:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79EC8329B
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUq/qus96h0fSKJQtvEUvHXL+EVIqu8qbmEOCJlyVYclVzMUJYxTDFipplzPw2idk6SF4JmiNA/DZjsW8GCRw5utIoNOTMrgIOgHp9B4WUiaJ3FNdqhNECvjM+xAN4cCYNst1G3kM1j2sG/upeUfnCmlA+QD4GcCcTpA1HTZgn2/A/QH4QySWdGvopFL322jzOgyATHDVvoIYxd/70H6/QFEc6sYXr9eiSJKAJxz0GYOuubrdS/Wvu84VzH7G4ibpbiZrMwJjN0E6PPWvOUQUJQS5IxH9nz1SenFrHE4WFUUGpNyKOjBkEXEoY2ktOT7SYjKG9/1hRsRAF1GNLbpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1j7d1GXZC+sDo3L9fJ8a+BPAsF8WHGl9IAu280tINw=;
 b=ekJrHw59PBhNm0VNz+KQF+D36M1vIs3xDfHNyqAicqGhzcFgiikZ9iAk5hk0P/Ix46RwT1phOyKH9g5qhdcVxtvCWtVRpKfaTLekjfv7Fe2CveTJ4OT9Pl+WtK932J2R+QQKvhaFKuC/oUdFG3RLRkYpiKBm8jFi+Q92sAFAqqUQOqlHbAD5IPpSnUURGNc4NFnpX+DWQPmgct0k0MQi1ZMOsMqFfAjIPKNnBy/mFWBhsfdSDJnT7dC257ZmyyqpqcElvaGwRWLiL9w+jn7jnac4nRm5DarJtUEIf29WcCOnY1IO1aN1nfAVS/QF+Tomm/aCcPmWl6XcIoNr6tOmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1j7d1GXZC+sDo3L9fJ8a+BPAsF8WHGl9IAu280tINw=;
 b=lZmSY6UgJjG8u7D7ED73UKkFFsEUkdp7obhiJ9A2A6R8EiEvAQknKyodCm4mRH61jZUAGbD3C6jluDH05LLOLle2diQZ5jI8CZ9NLkc61fujiDF6PSOcIELXZ1gubRyXjneT+q7Z7TfMTaThNbAU7ML5J2EwHmd6MM0UQT/+QIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB3PR10MB6833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:439::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 10:10:09 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/9] _exports.h: drop creating dummy i2c entries and fixup
 config dependency
Date: Fri, 19 Sep 2025 12:09:55 +0200
Message-ID: <20250919101002.568488-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab8ba30-ed8a-4d34-de3c-08ddf764b6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wcpgu2wfIzfTn7sfr9bKDeH5G1s1JpnpXvevapDhd6ULnCAF1tSfOUGqcf9+?=
 =?us-ascii?Q?HM1MHxfsN9GAxnwxqvdicl1sVFQL7t3/CVohBhQD/EjpDQq4FL4rodoOx/J4?=
 =?us-ascii?Q?iIKenhUd/7ExxbCrEtrtf0QZG2WZo1WioeYz/1s6s8sP0asfSjofcLqkrFqO?=
 =?us-ascii?Q?EEKtRedZuaMBhJUBOVExf0GOYBUdi5JY33KOPklBmmKAX7hLwXIa3Zs/qJLr?=
 =?us-ascii?Q?j9Mtf3r7FQHYr8l7eeUcDPyU54rcYoNUK2OZ1AHPYNrG4NaWBfLeFSQI8JvY?=
 =?us-ascii?Q?rKOTxbQGEnN5NB6rlSJ4osnWt/xMrpeCBkmoPEePZXrRkyH0/w14ULy9jQc3?=
 =?us-ascii?Q?dF+2fOITFZSXh6I8qeLsdlNNUbPbiejTXY68oqIVLLATD3PgmboQkqU/6DQ3?=
 =?us-ascii?Q?GefmM6mOXRFqSGVuaVzWts14dzUpu1CHYP/tX3GdcEQrC+Fibh1qSGhe4OxZ?=
 =?us-ascii?Q?Ge8/pCyLvOQTk+fl2fJ7DrRVLu9Rcu8vvAR+tSVPznaZ0fuevoMHvADop4g1?=
 =?us-ascii?Q?cNRobN3sajg9dQ2IREriY1PsfrccRK33Mvb9xqWjEyBnLtUI8C0bU/zrKQpx?=
 =?us-ascii?Q?hh4TnufJSz0SeSvsLwZgaAvAmMUur3GphaatYHrTBSMC4pq4zUkTXugwlkvv?=
 =?us-ascii?Q?yH92n+6yGS3UvuAFcHlK2Ot5YComuvcAmY86V0TM78q4ZkMdxqMXZ0XdQisX?=
 =?us-ascii?Q?dIGKTAXHw4Z9rf3lgctEojoPT5jWJihgJR/17oyjHiRs61jA05xVAtF3g1tO?=
 =?us-ascii?Q?gJdI88Z2RDvj9DzClzozpOB5WYOHbqzhy2xIIlH+5rz2hIujbO7nRLpPfDI9?=
 =?us-ascii?Q?xdJage2YCczjgPOgT4YObHrPKYN5ph1/dW7/5piHsho3LDGrVQM6oxpLmLBr?=
 =?us-ascii?Q?e5sjePocTsnkrZEpxbSTwgt8ucgmHiDPZVaLgk/5v3J/ceg3rFnhazRaZIoI?=
 =?us-ascii?Q?mVQxzgKzxteOv5hik8/NoAPR52p17hGmrmD/td3z5Iv3dJrRE6r3cdyerDfz?=
 =?us-ascii?Q?UO07TTzLD7Dw3xVYpMKhb4CaCmTRLELhDf6rVC0zvFzB1RaRKaFLbtTsJxM2?=
 =?us-ascii?Q?KKpY0fm2//nBIp+krYkRQcRQay+IjX49Wy4QMP9fyE9MHSNabRM/4RIOtdYq?=
 =?us-ascii?Q?YgpCzMoptrrUSLRbRQv2bsiXjgmWHaPRROlIyOvGISlIdHVeleTnCdtptdXg?=
 =?us-ascii?Q?gh1cBLbMVXUCfYUDSbpOZb2mYX+GhlVZ6X5FbeWUd2JTtllaBeJVLYPWYl8K?=
 =?us-ascii?Q?lHCgAMtvDn1XsuRfXQlsBe7CrO9WER8evo71/RUgklW3BSalpLxgeg7clRIg?=
 =?us-ascii?Q?A+DUN96ABlmEqp0+04JTY2KVBktt7b1kY0mZsRDp70eyVowdccNy3EyjwHC8?=
 =?us-ascii?Q?cD3ZVrLp15yAvjbyc+dR65Vs+h+fd7VIXkTOaArANc1mobOL3cvssB7vDumB?=
 =?us-ascii?Q?axArrdUWQlf4EWObiR1myHVK1v3MxEBpcP+CI7xN0Y3fdGRV77/2xg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47TdhV73cAHDye+YUSL0BQveUhhMoWsBqJvL313f+vAy91q+kWRGfNlhyO2B?=
 =?us-ascii?Q?6gjAzGSpRhfliYw29U01Q3dOfs6wrAP/VxxSYf8o37B/l/6Nj9qg55j5yk5O?=
 =?us-ascii?Q?Tn8/olx0Fjc0Sqb3h8Mbb1Zu98Iw6B0Y688M1jc8cgVhAaOThCiyeIyoIfML?=
 =?us-ascii?Q?McoND0jNV+ITVYe2Gm3Wxz3N/u2tdHAlv7AmQzCfZbzLKyVOeup3TS++c73S?=
 =?us-ascii?Q?Hsn7wmPjM8j3zwo85xm5Ng+GNSgNpEVshCjAl4mHPgx0yJtIYgTKrfCRVIB9?=
 =?us-ascii?Q?hD3aiegLUYvllML3SnDquW1dQKcpCzf7w7bzl2Q7orR26QdjZJqtiMsAQh0X?=
 =?us-ascii?Q?IB6AtURmptOJbAHXnXyF5mg60pLM4SWHfhV7MA822KV2U13qEa6KAelLoxgq?=
 =?us-ascii?Q?krXCur+gS4U1Xgc2GtWHe+TS0nd1p2F7i0v2G7EUV+mTLMFNCu872KekyhU8?=
 =?us-ascii?Q?fIEfG0BrLPfaJqwoJBhMQqQSQO9iNhb/AoxFQhH8/LW8ySW23tqZf1+Ja9ek?=
 =?us-ascii?Q?JX9MB+xc6ULc+aPIyDaPyOo29MoA01ouZxiqE6M4sOxVT2FVRrw+grpWyg4f?=
 =?us-ascii?Q?/nErrbkXbVqqx5m2Lzt6hZC6rbRb9ol7Y4NoYu5FrNitVaB1j3oK46C502Mn?=
 =?us-ascii?Q?kEy6RM04ZZBgX/LkKNODcld9qE5c2cYsz9h7UnSOMDkXGcRylrAk3XY6swu0?=
 =?us-ascii?Q?3eUaBu/e5ZUm6pTNY6LwzydDkTU3Ra0MNT9w+T8Ey4/aTgARq02KUzSUW6yQ?=
 =?us-ascii?Q?F8yvckfy/inFtnzAVWPvDtrL2I2+6mHN8rblRjc0cg6t7NNGVagOR0PPmoat?=
 =?us-ascii?Q?INdHh7myum63sZ9ZMM89YFjPnfVbFF3z8Ta5bUzx1MOzyExG/zHLoQGNRrVn?=
 =?us-ascii?Q?pQRVc721JYppH+VgRcpBbq/GmoTZHSn0MEmUdtioUxW2vjlGCikGzPqz+46B?=
 =?us-ascii?Q?UdsfyAVsTh4UKzJSVkuhLQvooa1kP2cyzUuQvZEinDS06TXZfQ0oryES2LY5?=
 =?us-ascii?Q?3S/LKM1Bbalb4N/+4byJcefZ6Zrzmkl7UtoS+VHP+yEAxwToUW8Sg1vd+uZO?=
 =?us-ascii?Q?l4xfmAquAu37bqVVOu4QetX6Rxa9LwpMjzEUf1xud4ecq5L2phzZ5T1yvHoP?=
 =?us-ascii?Q?v4130QCyTND9LjWNFSR7Bss3b3z10mu02rqEPgbi86BYlJT3OnwwSSIRiMQm?=
 =?us-ascii?Q?WdufDzK4FjXQVRZj9KfVyu6rua7CrlfEIAYO0mRcZ2WYyDhAfJj/2vcvgNhk?=
 =?us-ascii?Q?+ggUKYSWnxoi4/P6CQ8tBKThSkJvfaUrZqAiSApVQMcD825rKWH2KF++7srX?=
 =?us-ascii?Q?ATt7JWpspcEmwBVjtnVTIacaGZLWzi6OX6d5Ck81pYJpWKx1qSifMcSSO6/H?=
 =?us-ascii?Q?ZvjNehzq5cLVBOM2q6otJqsogGz+93nLJDAYbozPUiOApCBvl/sdtLZPkX7V?=
 =?us-ascii?Q?a/PUA5q3mcyGRepYNmP/7r71Cy/PYrZp+/3I62NxBbIAs6XYGRDOEQskYzWJ?=
 =?us-ascii?Q?8zIXT5D+0rGgIC0obXnF0J3jx1BrfO4hVQH/mnDM89H8htr/T0u5O743Gr2m?=
 =?us-ascii?Q?+PZVXV6P0mWVNrXMnF7MSPiQDTllXQ0OdAR6z0IMb8or7M/bkrQz5sZhMEvc?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab8ba30-ed8a-4d34-de3c-08ddf764b6b2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:09.1931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ao+iGhFKKauqWYOG5E89QJT+5tb+kpS3JLJj+Ev5mzAk/YAX1XEBMQT86vWxaf5nObggF30bvU4CufyCyg9miutxUDpUQoYoM0N2M+rQUeY=
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

There's really no good reason to create stub entries that would call a
function that doesn't even return anything sensible.

The existence of these two i2c_* functions depends on
CONFIG_IS_ENABLED(SYS_I2C_LEGACY), which does depend on !DM_I2C, but
is not equivalent to it. They are probably rather hard to use unless
CMD_I2C and something in U-Boot has called "i2c dev foo" to set the
current i2c bus before calling the standalone app, so keep that
dependency.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/_exports.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/_exports.h b/include/_exports.h
index 1af946fac32..39278a34942 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -1,7 +1,6 @@
 /*
  * You need to use #ifdef around functions that may not exist
  * in the final configuration (such as i2c).
- * use a dummyfunction as first parameter to EXPORT_FUNC.
  * As an example see the CONFIG_CMD_I2C section below
  */
 #ifndef EXPORT_FUNC
@@ -43,12 +42,9 @@
 	EXPORT_FUNC(simple_strtol, long, simple_strtol,
 		    const char *, char **, unsigned int)
 	EXPORT_FUNC(strcmp, int, strcmp, const char *cs, const char *ct)
-#if defined(CONFIG_CMD_I2C) && !CONFIG_IS_ENABLED(DM_I2C)
+#if defined(CONFIG_CMD_I2C) && CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	EXPORT_FUNC(i2c_write, int, i2c_write, uchar, uint, int , uchar * , int)
 	EXPORT_FUNC(i2c_read, int, i2c_read, uchar, uint, int , uchar * , int)
-#else
-	EXPORT_FUNC(dummy, void, i2c_write, void)
-	EXPORT_FUNC(dummy, void, i2c_read, void)
 #endif
 
 #if !defined(CONFIG_CMD_SPI) || defined(CONFIG_DM_SPI)
-- 
2.51.0

