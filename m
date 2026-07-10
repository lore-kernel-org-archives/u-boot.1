Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50399C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B75178498C;
	Fri, 10 Jul 2026 14:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="U0sG8tVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FB5846A4; Fri, 10 Jul 2026 14:36:36 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA5084A0B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTjnDgAZ7piIZ3jbw0R1zHIUqiqpRNuC8X2Ue8OkXhhpBBehEKEuHLwDTzAk0FXFe6Ac2AY11YoYQD5pwG0XmtZw028ILAf1LPAsDaBI3JNjDlKRFUAFfPpkaUdnfpmNDcOERqbyXgSvuCruAg6qwkMNs0E9uS9aOMLVGjUxX8sBySlPBJpjMXVRC+e0Cf/OBYyd9j2AyQkDVKUThF31NcDrOyEC2ZJT9WOvUoUAxinJno5ksIA/QNKw4onH3TX4WLCHssLSK2DzFcEu/xHHuodddjv4zFt0gKWtKfA+es6+hSyBbmcfF9ece23cUoZl5rM4NPOFpM+msVKr+E5zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzMNaWchWUNOqIgBuNaY3ma3kAnm4hY3U1ovw2ta/oY=;
 b=cU0d1UFdIrr1OvOZxesJ8lkDlxrVVMmzN/ysP06fNZJJ2KaWP7MrMWns5dm9Tf6hXTLY7jy+QDpCGl5RyQK7wrkeBAyVRXsueGl1UBLr7Y414M/v09PKk29tJbmDohbxlg+KQ+bcTUDJCnaBCtbziUy0G+/a3Xc/MahhSubYqZwLWIcH4a/PkUoxC9t5IT9iT/blpdZolnWdhdEmhl+jy/BqBeSYWNaHCs8sb3POp90kZzWD2szTTg9V+80h1+jyd8Oibe+tJeZuDpUtOfKYbnfwxeX2RJydtlBlmb3xozux0UwNapRXVFX1dp2QnGfS77ageGZuJGqE5YjkSMd8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzMNaWchWUNOqIgBuNaY3ma3kAnm4hY3U1ovw2ta/oY=;
 b=U0sG8tVpELSJUkk2TQBMCrFU0gEaOLJXdOecTT7fIs6R9yr+1iD1/XSOhCho860mHFpU17KlTuQCfTVkn5OYBtv2IYZDxY8vw9mRKEPfAzMrSkHeH9Yt57ScmXp+Qqxjj/2oCBICxGdWfkB3UuIdPDcNbcYvNDoJ/bOl+QMmAz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:32 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:32 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 5/6] k3-binman.dtsi: add empty distinguished_name_template
Date: Fri, 10 Jul 2026 14:36:17 +0200
Message-ID: <20260710123618.2036728-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 797f59b8-2027-46dc-7bcd-08dede7fde7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /fvWr0UnMFK3Kyb8oFJnRhN+eSHOqLRXBgZuP5rv02JOJ2LCnKicbZJYwuYyE0oaWYiAGxPRgtHcxRJKsRb5vuFvIRStPKpd9PCh8Gc3XfVF5d6ycK9XOIIMM1gHBcE91joxTHxw+g0gRQSVjlvxv+sfDaxC8QJkFT9coLizHk5CLr5159A0jq+14RzYTInigSGtw2j0+W4zxZAuXVR8iyzpwhZzcs3s35xs+yPHw3vJU2R5XESFsD2L+80JcV6aY/tSkrp/tIJqec8NWVSw4RmOEE1gxtgLk1dz3B5bSyS1XtxaRNjb6cdyEmqfQGj77Fpl4RVS4ApLgIukRii7LTTR5nqmhBhwI+/yv2uwh1bv9E0VwVbh+il/UWXIClnwp09wPSRsew9NtIUudlu+Lo5Ib+T41zfUXQOsVO2D4x+X3v80eBjLwJFZogKi3e/5hTJuLSmkXbdkc22fdzTqX30vK3n1iMcYtxRNWc88mxr74X+8ZuevwEgCIqqZSFJrOF6rPaBd1q+1dxZ88TvjO1N5jpjP5rJ/TCDwPmv2/wnrq/EWJldjpdWU9D9SMK6T6GoFh2oVXI16oUk6j0UJsoXxAjaKWNPez/ln4pqr8I83S5upwruclDsbCfhUt1c48QosUUGFpLxP/A3ZcGJ1vZJ4j2sLPnWtrNYezQhHos4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQnpxv85+9GxJuU1gpIf8z0SBAAm1f/beptfrKBbvsdvHl1b1Y4GxH/RxWCs?=
 =?us-ascii?Q?Wuh28mLECWp1Fq+TXKcldTRmO4E5y+v8s+BSobanbCG3c7jRo66azAxhsusQ?=
 =?us-ascii?Q?flehTM/qvNLDFNe+emzaSTevzH5FpqX8E1doLKi3WzlILrjqZRmsB7DddwcN?=
 =?us-ascii?Q?uBntJ2/gpfizLXeWa70l4LdE0TZxlttOStwZOd3pS390cKgtChXtkxyGQMJS?=
 =?us-ascii?Q?gNvYsTIojojNkxar+sglbx2dtZOBPJCyzMaBBjM5VB8LXHlnhrPoWRRVRlly?=
 =?us-ascii?Q?joj99FovlZM/6cvNGYJTIhu0VVvqt51H9EMc25FNM/cZnWN6XT3QsqvpnBjH?=
 =?us-ascii?Q?BwRbjD0FpHLLnTE4bAV+Lv2l8DeRJBdXnu0SrVTpyzq1/Bl02GyUm3STcYht?=
 =?us-ascii?Q?Hu5A76QcGWFDjxTlZmmuKOVFE34E+2xkgZ5tBMIucOMDT1ZkTRFAzTvaAQ0m?=
 =?us-ascii?Q?bN234Doy8GIOEUfz/qPBvsbqfHaK3DLn2glgtQl64jk0uebBynmH0baO3FR3?=
 =?us-ascii?Q?4FbVIaiZFSVkoVjKZZNkjlckmh5o9Tt6sYxt8WlO0f0wjAYUQGfG7VALSnbu?=
 =?us-ascii?Q?SjtwZwb8grpE5c3TZXoqjTkuoT+eeRC0xe2kAUDGCT31iwkqDuTUOIH1TAA4?=
 =?us-ascii?Q?tigMD5qXlXZK5Fwa5+7HQqnTEYRQ9hSGhjsN/OJBkJiQ9OEp21oYMlmus2dO?=
 =?us-ascii?Q?pwFW8xa7Kbfs1lybPIRAi6mTjnY/R7inkFsssU8M96ZdESMXPBPxvlcTOs0+?=
 =?us-ascii?Q?Yke2AICkwy/vQKE3hIXpZhDsRNSCJabCM4nMUxVLxRQ8aFTcljfpRUCLu7bw?=
 =?us-ascii?Q?W1Gl2z7gNO2w5lWHcy6jZeZefOD93CEVg6D5bD/m1V9kOAhNTziSz3Qfw2hu?=
 =?us-ascii?Q?C9btnqlL+m4Z+seutTpKUwENadNMS4cDvbqp2EedVOGCjriMhPt1bsMFg+Wl?=
 =?us-ascii?Q?JkwjS4A4nlMiHmEAA/CVBljVRWO/em1J92BgraUjIvkdFEyNDiX3NTMiEqS9?=
 =?us-ascii?Q?i6i5IXfa6miTO9s1x3jnBuIrwyMYHlR0qmXpE2Phn9jNhrvTJQT04oIJmh3s?=
 =?us-ascii?Q?UZzdLhpmiEL14zIAN59ja7TvucKco206F8H4z2xhh/HfSQsZupstdhcvRo+c?=
 =?us-ascii?Q?bAtRjAUXv1+Q1Edr/sLJQNXALg/pJe+EiayQyOcjVmPcsSo4pyGLNn5Wm3Cp?=
 =?us-ascii?Q?Si7Om6CN2MBKOyBhq3awEYl9LpfArJhLkgupST882z8GZAFSGX2TDr6x+Mq3?=
 =?us-ascii?Q?iPGzXvhXkCA2VcJXQi/ClUDix9/seVOisxKw/j5LluzXdBuzhn92j8qCqMfo?=
 =?us-ascii?Q?msLAn7zkI7Z6diQtTZrPKHvZmkU3sU57wEvvywlVUujROFYx4lj0YNqcl9GL?=
 =?us-ascii?Q?F7Ff/1InWHTwAzwuMwLcENbvT/RXlTAeztNv9nAU6TF/YbFEkKPkpy5cSJTR?=
 =?us-ascii?Q?z9pM0bL4KujyhsIQDwssRAnjcHosSrjFP+8Rjz12Nb23PJfw3MLm9g/Vxljh?=
 =?us-ascii?Q?MvZ6Xu1WYG15ocXA6PbhnGUqVdZKk6Ygx1FbvG52or3VvC7srsJBkREU1nLp?=
 =?us-ascii?Q?2zctPb+ojzebLacKBU7eQlM2Jh4lp38PWCd1jO+Id9z/SP/0TLArDKtCdYiN?=
 =?us-ascii?Q?xuWNjqkskzUnvJvzUsGHqmPcORg4tO5mvmN39JafIUMz4MgDYuu8qDdTKzld?=
 =?us-ascii?Q?6+heBxUbNFtBy1MN5vpIDfdoxpF87n3iyb8jYOLpboi2RCmbREVN/+pHDU2D?=
 =?us-ascii?Q?bQfhtsQOie+Ihyi+3oar2yy+llr06Fw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f59b8-2027-46dc-7bcd-08dede7fde7c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:30.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utEqSAQnYYuNRUoYOGNVbnSYaGus7awxwyD/fyOaH6/aNrMwQQRVoatBSIEkoV1qaQ6TuhksrxOgTZxSr/uiUFEvtPzIPClpLIs3h9J3SVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
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

With the previous commit, "binman: x509_cert: allow and parse
distinguished-name subnode", it is possible for downstream boards to
put more appropriate values in the req_distinguished_name section in
the certificate being generated than the hard-coded TI
values. However, that requires adding a distinguished-name section to
each and every ti-secure or ti-secure-rom binman node.

In order to avoid lots of repetition and make it easier to just add
the information in one place, add an empty template-dist-name template
which we can inject in every such binman node. That makes no
difference for existing boards, but makes it possible for downstream
boards to simply do

    &distinguished_name_template {
        distinguished-name {
            C = "DK";
            ...
        };
    };

in their -u-boot.dtsi.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 69214bb32fb..2c9e5b619b7 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -29,6 +29,16 @@
 	keyfile_template: template-keyfile {
 		keyfile = "custMpk.pem";
 	};
+
+	distinguished_name_template: template-dist-name {
+		/*
+		 * Empty, but allows downstreams to inject a
+		 * distinguished-name subnode with appropriate
+		 * contents from their -u-boot.dtsi, which will
+		 * propagate to all ti-secure(-rom) nodes including
+		 * this template.
+		 */
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

