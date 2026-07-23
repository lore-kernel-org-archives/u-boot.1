Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F31C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E58C4088E;
	Thu, 23 Jul 2026 09:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewwzpTckpz6P; Thu, 23 Jul 2026 09:39:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C2584088D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799543;
	bh=ekUJrQzmfh7LUfR+59i5yt5c8XI5GWiMYrWkN33kC7Q=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=u7VjzuiKa9fvy+hzZsklSrWcYSpfjaQkJAbAIaUoJoz2tOrUue3OxFH/zXj4zGIpB
	 Sl1vxGWnNV6X5+q2dXDBUcgbU9YS0T+4UpfWZyxim7k61C8FvZz76BJexWmcATQjTX
	 iQwLMvj7wm7QUXHWCgdqUqlyMKIwD4NmjYF1engIrwtIEs0MLK2zLWCegnQ99Z1WUc
	 gXZsZ3V3CVyV3gxrNmDXJH1oQkM/Q6vuS2MhIEixm8ydYzNdreRUBzvWyGBA2Jup/g
	 SAegnPv1tKBLqz3v5cOhR/z64eL5sQbOHQ/Vu8UrmDafagORew0zxLObyKanA9ODhw
	 TnZ0IsI7NQtgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C2584088D;
	Thu, 23 Jul 2026 09:39:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4375836E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29DD74025C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSGyO282QJ2V for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2C214031F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2C214031F
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2C214031F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMuxP33byVCcnMy0J5g4HzJe4T2PjtdLoqLqWC9E8AWMHaYpkL/m9LQINzfKQlZrtsVYlmwa8otKc3YOBhzTBMgM+0YWngREZvE3IUSn0ACfhX9A/AvxhyE11nYs3aZpGT6lMrAn3XBePwITYDZA11YlLys3DMUIMZqME7UUaZW+8ydCBlvhVLnA5gSOZtj2g73J0UWVqJtyL7jdP7Jn7K4lUYm3LCN5cAMJX0FXSzHgym7suoVFDh4H4mB1LOmM5wBTRW2fg7dOc0V8QjNikPgD6QSVSX46V/o5qgmC3UO39Cx9h8w0d8Z9UmzZc3Jr122WcXX31dszumcDLdL6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekUJrQzmfh7LUfR+59i5yt5c8XI5GWiMYrWkN33kC7Q=;
 b=dmGq0LS2WdQAsXnShLPJPjy+cHgJoi6jXx7Kq8dOtVSb1v7qmQzSG3j3XMKZGv0Ewq42d1m9YXLd7BvcczdbLEpSe3t3qdsFgLNTkf7gADXU6pt1ugzrQWfLRxAc7mC9KSYlf8Ov5PjjMX+9hhjM8+VOsShEPZmOl8Y6mUcAyr4JqboH2ZxFx2SPqpSOqEN8whXEQRcEEHSOrA/QHRhyNKE7f+hWOyjkLIWWGbJ12NxGiwko6zl0jdLnUFMkgcfSE3OY+17Ubv9Wcutu0LXLTyfznW7xpSjN3iv1FTND9jWkso4ggQ1AR4L62zQg1LyVcVjW0lybhREKSVFz/O9H5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:41 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 4/7] k3-binman.dtsi: add keyfile_template node
Date: Thu, 23 Jul 2026 11:38:26 +0200
Message-ID: <20260723093830.3132465-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: bde32ca6-9b8e-4527-5c4b-08dee89e2e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XfKHkQGz4Nb/DzicZY3QnqLlEmtvQTdbktrQUygXxq1WsmYwsX2lOrxyPWym+Z13fkFhhoBW1+lWiKqyR5jUf/77hkUKobaClLN2mCsH8cober6NSjfywDTnseQAJht/+01Zrt2nzfeo5F6KYybNTCiz7WiLLlv8lHz9lc9DndRBIJG61IlNRlhhOenqirTwuV00mM4WKWIA1lQo4e5Yg0KfqqpK77ZH4hyXWtueXze+9C+LCbmAPZwHnyzFqT4KZ4lfwP8V4oDWsAljCeX8PArtVjkHmPF83yebhQePVL5DrRDsq2F00xYHa4S/k5dh4ifhsIz9/PaO7zgK5qS+scFFVdADntnj7kYMxwKmxCGeqynBNmmCYJr1ULHvtodEJQcJhXdh/DQXoPC+tsTv2kx/tMG7vFevY/pPnUnKCb2sSV6+mJlKC4wHkMdNclpdvlDFwREvCa70C4sul+DglougJpOP9T6AwcynRvdgUEMYFlgju/gclPWFAL+AUpol+DDizdrINV6UpgNar4dDmjyK75EE4OIipZiQgq/lMlxpuwoCMdoAm/bcZmEpsQS4P/Fhxl9bfBlVlZ7M2W8V2MqFgauxHrwJe19DbC0Fz+p47dWsfbbQ88GQ1t+k1dJLPU9o+WvWfzxYaQP7mollsYVzcy8EQ7sEmOVvv2qSdAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7NXGWb8o+jV3Gk2Kcyw+fj0GrMc16orylG2mcPI35K29+gXkpjp2jUovlIs?=
 =?us-ascii?Q?jADLNmn0mp6neBQrw0NcoZqogW2zj56kU27CBe4wWludOYHqD0q4q0rUCilI?=
 =?us-ascii?Q?GNILh8TISEh5YYMIqKdBZty+pmGTo5/XzyOxTt50XqJ7aZWE+laR/w7uy92o?=
 =?us-ascii?Q?/fdDzi29pGR0nTbUWWPmO+wp2GS3UZ/q9/hLt/0MOvlg9H40+MHzE87kqYOr?=
 =?us-ascii?Q?WpPEC+176qG6SnXb75kOqvDBnuVXtiZrp3MSHelhctM39qShVdsiYWohbhP6?=
 =?us-ascii?Q?Y+nYEhXaAamRYUV8eZiGolZidT6j4985TuhiFlAJShI6tOmqbcZnytAtrEsu?=
 =?us-ascii?Q?Ryi57CYtc/XHWCv7105hc32/Dwy8P+QOokpu1BJ84N76ATaL1XXmwiC3JOj3?=
 =?us-ascii?Q?NwE8GIKnQJv3dkH3iw36+w2W24rz3F4NVlPLH4vRmi5d9XUpy8/niDgtojY3?=
 =?us-ascii?Q?O4ZgXNf3W40VI2rbFms6ZY1AVt3hBvkSb5OEhGeyma08vArsjDXxMp0lmHGN?=
 =?us-ascii?Q?lWtA6g6R3BLKDqRJghaJXY3A9cPlMMNV2OyZ3dHruYOKCOe+9AHuWzNu0RhZ?=
 =?us-ascii?Q?ORrR7x2jnChKrU8FJcQUFU6u6m48bOiZA1DYPeFKSv0gw+dHp9R7jkA/TVsn?=
 =?us-ascii?Q?gokZVTGyXPzcIltFQm1/gRxyWOpagaDvV4oTlORuay9PyPp2/dHxxnF/lboe?=
 =?us-ascii?Q?3NQX6bOLQXpfFc77TN0J+TEtFLsPs4EFsp1wn+sPJRsbw6UXLHpKw/N1B5TU?=
 =?us-ascii?Q?I+6FDq1shmWfzJHQzt6eV8ysmnJL3SBXBWa7z9mH75GR4q+ohQT51w4HeA0X?=
 =?us-ascii?Q?vJibvP5P8R1JdoJV18iCDZnusZIFnD9358IbdQKi7QOEt1DbpzVUM6joqtCF?=
 =?us-ascii?Q?qIXddSXxGfpVGlXYDRUFXMVUZiCwi4ETm23P3kmYR38gsdFzVu1MLqsHNJYv?=
 =?us-ascii?Q?2ig4wS8VFIHGyjp6GwN9Cgr07TZEH+2k0mqm6zGQkdfZsaKy6pJGJAh0MA8q?=
 =?us-ascii?Q?pcSDNKW3NySJD9BigI2U9LNjQ5nwu7n1y4I+MzQOTj3BS3fDQ1Q2cURq/kDL?=
 =?us-ascii?Q?qyIHdog8nP/UIto56uR9NxaFBop/hS0SJh3sCgis+e6Of5khoyqWQz6nKY0i?=
 =?us-ascii?Q?T0tgUYxpL71XfKTy4JRY2T8evfv+MIn4uPAcWupNZwbbqck10+Wlwe16qDbc?=
 =?us-ascii?Q?yVcTTh7zIyLdxDx6yVu4NMqLh//0QWOf00JkGCAIn0Uw5w5Sm1PL2UuIEj6M?=
 =?us-ascii?Q?DdpMMeSsVMVmvkKpotbtw278VERKsWFL/Zz5sow04B8E1povFgm+y+MuzyGD?=
 =?us-ascii?Q?sG88PokBXmKW4Abh6QZqG2oECkyW6K5i0LbY6du22/4TCqYLdw/8iaZPp60N?=
 =?us-ascii?Q?ZOAjob8VsShl3DbB9zwsU9bzYsv8XQfCrYz6xjndzhZV8LUPKws0vEjSGgW6?=
 =?us-ascii?Q?1Rzosv79PFx0GVQ0CWl0O+473WrO+4F4v+2TCN241nKjzSvlIthLtNORLwcj?=
 =?us-ascii?Q?oH/b1jtIvd7OHdr60Hh0O3TnwjUYZqnuVNfj5NCI6dZtzpFvtTVaa9Qyxwvz?=
 =?us-ascii?Q?sF+cnfF/NVhj4d0TwGqRQkpFM4luEk6MFboofo//V4WJb1C/vbRNP3t2hUbI?=
 =?us-ascii?Q?i7JX9XWkXcXZ7mVq45uvsPxjBRmfHTo9yNlOlRCdidyKwBrgNG5XBX6aA+vO?=
 =?us-ascii?Q?wuWyMvtdb6UaWgSxOLKPDtT17REPFrqr8S6Ra115PR6X4an3zfCbrpio5AMg?=
 =?us-ascii?Q?Jp/GkVY82ZHMGCk32x4Vnr6pmLbJ4a0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bde32ca6-9b8e-4527-5c4b-08dee89e2e04
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:41.1860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpmHGUBXrEN8QGXwolJYUTHxodJHH+66ShbdDJESHqnMm10xs9X7o4tgRSTlNO86w60VryJLUIoJJ7tjrRpKmtYexHxO/lCyCvg/GJVOQKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekUJrQzmfh7LUfR+59i5yt5c8XI5GWiMYrWkN33kC7Q=;
 b=fS9Cp0oqYr/t2bW1OK2vqTqPPN1uElE/ockkTIZAXCnisy/wJK8THZoLn2OiVTZHCLwSOvAY+CPBTtAmosmaU3MsMh/mijxZs0ksaQsmxSGAXdKBmOaVceQxRrpYEORFNYXF9wD1Brh8J3I2wmIdbLwzkPLrSIMS0A0HZkOBJ/s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=fS9Cp0oq
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Currently, it is somewhat tedious for downstream/custom boards to
override the keyfile used for signing all the various artifacts
involved in booting on K3 devices to point at their own key. For a key
stored in a file, one could override node which "generates" (copies)
custMpk.pem in the build dir from the one in the source dir and point
that at another filename=. That works, but is a little misleading.

However, when the "keyfile" needs to be, say, a pkcs#11 uri, one has
to have overrides in one's .dtsi for each and every ti-secure /
ti-secure-rom node, and a lot of those do not even have dts labels, so
one has to use their full /binman/... path.

Add a small dedicated template that only contains the keyfile
property. In a subsequent patch, we will change nodes that contain an
explicit 'keyfile = "custMpk.pem"' to instead have this template
inserted. This way, the downstream board's .dtsi file only needs to
contain something like

  &keyfile_template {
    keyfile = "pkcs11:object=my-key-identifier";
  };

and that will then automatically propagate to all the nodes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..69214bb32fb 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -25,6 +25,10 @@
 			filename = "arch/arm/mach-k3/keys/ti-degenerate-key.pem";
 		};
 	};
+
+	keyfile_template: template-keyfile {
+		keyfile = "custMpk.pem";
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

