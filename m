Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F321CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 05:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F95B84844;
	Sun, 21 Jun 2026 07:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="KDMcQYaa";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="IkP7w9lN";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="RfRNuX+Y";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="HqmKz5bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A8C84874; Sun, 21 Jun 2026 07:15:00 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E97283FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L02aV71801358
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=FTHHwwIPb9MpMdnU/nHf0pQts
 cwf5/9Rg1GTG75Libk=; b=KDMcQYaa+oGZ2xUkyGbOftfLN6wWQgmevvEn1ggLn
 ycMfGTdOMlv+5AiZ6/Ob+YC0W+ONw4tXhMGxDNqPQ5K0Ffe9PCphY36inMzWbeTU
 gMe5Khogl9lnmy6WEBwb6UNFv5YJxjwcb75hrWtptQU/4YsomZbMhFc5cou22VaF
 zNRBPaqsQAMNYxgxzeGJKzoY+U6a8xO5swP7/SWgJ4DNyRKsOLL9xeGymZ1dn652
 +IpzPUq8+hMXJiBvqxQHVGX66Tpi5OxUMCQwtm6jBJl0xxhHS0urHO/gbpLe30sY
 89NvoiN5YebQa+d3aQDZG7XH1vW7+XNqX3LyFVblRAcPA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ex5290ruc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:14:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Caes6u1yRwajM774giMRsUb9JkiXLZICcbefsA+emE8RzjDOHHRjHyehBaytsqHi6nkFERD8zKmG3k/Z7Trfri8s3RY84OPb9fbpqcuil6+XPNBzNounte7YYjCTCi4K1AviZMrscu4dD9kuaGHE8xLM0RRkH2B4J0fh12HttGA9jKpVZh/eKz55Ng4Azp6OTAlkaTtGBWcsvxlfU1AdDeBbrlRzVL1XAekWYUU6vO/+XyyC//SzzmWVQZi5aUpS4tOCfgrf37n2+WUDtNSS5fsoiA3vWnJYnarHJnWrXM7I0cuUOQoJGlCtfoiDh6Et++ELe/EVseP2HW0AEyxLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTHHwwIPb9MpMdnU/nHf0pQtscwf5/9Rg1GTG75Libk=;
 b=kF5g9AXyYuU3i3GxTPefT3myPEyUFs436eDf4kU+v9re4m/Qkjx34NXSdUVJhbhlJGdl0piwvfZ/PX8XIojzNghT8/HFZ2FojohgueN3HmWR1ITW6edXn9BsQ3GzGPUxdeeNqmaVALP3J+YEt2boE0wm6GJSLUGCBMHP5beT4PqT7pVjHKWK40nGnwwp9i4BVqIHLEIM/AZBbwQihRKOUWHWWPT1+1yS9PIo5vcxwz0Bsv7lQYtRyg9t4U/Fbse/k2wt+S8ACIcjlGjSUW+7CmDVbSLPHblKTcz/Fh9IYUubL1iA4+nsutPLltHWSMsHz1LSBeCjKiiajRMpTedpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTHHwwIPb9MpMdnU/nHf0pQtscwf5/9Rg1GTG75Libk=;
 b=IkP7w9lN1MsaNElIyt4fh7/0s2ColHrKGkdJXlKA04w06fQ4KUBC0UPu3VHvn2mLgi8CzGez2KWqEqSSFzsw74ctym2hl3Q/Nv1PNrym8fad7xUoG/+FNooUK9EYO5+8j09NoboYQjGn2kBKXHLLYnL35d7pt3JVKzXrqtFYcBY=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by BLAPR16MB3876.namprd16.prod.outlook.com (2603:10b6:208:271::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 05:14:51 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::70) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sun,
 21 Jun 2026 05:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Sun, 21 Jun 2026 05:14:50 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KMIdxN2608695
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=FTHHwwI
 Pb9MpMdnU/nHf0pQtscwf5/9Rg1GTG75Libk=; b=RfRNuX+YaQ05xVOLlg8JEMx
 Lt6pSnMnkFMtakHX4SYoDlFf8e2EjlrZrmhx0oOsspootDAdAcSbGx+W3Q/2WCxK
 KV6DoyD2V3T6O/HyYSl0qHTfCXjQpp6fZRhxWbfsd4u3AEqu377CJ+teiONsltHO
 5aWpYF4nZyGSSO/fu9Z4749fWRgZlCUZRKn3BwwIpdqgpagjs9NwWBYWcqFV5cL6
 3es52wU8vyJL8I1Yd8mYLfgEhvAm67oNc56xxldXyXxfv9opCWd51AX3M1pR29lG
 VYTmFoN4U8TepspfIODP8ByVvkb5aHBqVqOgbc2VJIrQRZWwS+w7nmyGbromilQ=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=FTHHwwIPb9MpMdnU/nHf0pQtscwf5/9
 Rg1GTG75Libk=; b=HqmKz5bwTBj1Bs0MALY4WvFOvJL1iGa14h2H/48VF6HfZNT
 GJ0WT5tGz/wKTA8PiKo4QgPiy8a3suudptMt4am4MNcs3UVjJzz4tVZlpYDtuPyP
 rrOCk6JCoNGsPT9NTELM0yTeGAnH98bnep1DKX9dT5GLuXQLTpKImjTd1lOxxOPm
 L8iZk83svxmq68L8BzpGBPUuLurcvX7AzCxkh9Omi6vOTEhCe/Ac/qyue51qm870
 l2SZSQSIsJQcDg7+DbSXbQhFem8lM9Y8EjPrNyes5NimD7P8jmyZ9QFlNpcTnSSU
 KFwYmVH+ig0JwtUS8IgHnQiR7NgW+SWaUaR2LXQ==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eueeq5ey9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:49 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id bAW7wHBcxAurIbAW8wLElx; Sun, 21 Jun 2026 05:14:49 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bAW7wHBcxAurIbAW8wLElx
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 0/3] bootdev: few fixes for automatic boot
Date: Sat, 20 Jun 2026 22:14:42 -0700
Message-ID: <20260621051445.1763952-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606210049
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|BLAPR16MB3876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46e96e84-33fe-406a-9128-08decf5405a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /pEK34bWQ+Sk87tivJcAyxnqGf30M1WM3H9fpPB6pLLoHcl/7OBi3I7HiOQoFvJFwKtHCb3uYLugKga3KmWAJiW5lE+kS8nbPI4i1+YXaX1onVqhuw4j1AQiNwD0xQWzyh5rzRp7mNUU41QLN1x33YIIuRHvHJeTg17qTXLWePv0c31Byj49zZInRbpTF+rDng8R+1lAg5nE9gpzhr9QT/PH70+DQyG+BVilG39ciMh97aUhyEnM3oueayuTcpH7VWEqliSe5c3erfxwwssKxFsBWjqC2VVNOmMZQA/pupQdqMwHffNGoXhSb9OVG9KC8i4YcjcVNqYv3RRh6x63sdXwnb9YHjyR6rpOZINZyail43Cb2oYEJW6N/zxJvkvSfoveud1oUVvyJ7aPc8WxocESQk6fBkw0W/eU0yCVps2NWUEHOxVs0G1qQ6Kz2Mg3q0WVQZQWHmg8FYjW8fRNECyYR75E0LTs/8TyBDxxNR4ijbLGfCWOUNyvC0hBasZk2fhngHpPgoIq1QCqlR++HNCKnQmcOB8ofa9HKFIvb7sNQfyapXHSnU7dR3EmCdDIHnvXss0/I0pj0tTIOL1XRdHugotc+a+r1IG31o1hDhbCq0ln9sF1GQJJ+CCLeivENpqcSkM2YhFKFV8BJQWQ7CkHClWZSUU+qs02Ct7p1S6eV59WvDi+Sr6PHIrcpbuIP4/QcYch8vPE+3CsL28fMw==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(13003099007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QNAPyMfzpX58ao6s1Ig+MSnzM/YfG6mF7bMsCBqRaux0AA5DUah1HDdsy1Xdlanxzyavvl3G2k705DayfoqRzIBN2ZI7UhknkRTswE0SVaGXxgU63aq4ge185PdizsSJwNUj/QwSUjNqyGbS/YN0PGucQif80YY75xRvFa4B+S+EHHDwc9OiYntSDL26Q0WXfj7XJn+1DdHA5spUom7OEL/cFi9XP970s3AR7zGQJqON+Lgck5XHp7144XmQ+nT834ldIz47wNrVTMbPXCWentHmntnGjaQn1zjN/H7GtTYSL103KUFOXoqu2pNnYhsS0RaxFBPOjisPPqJIxMxsl9crBERtJNR/nub9VMCTXTGoNCyObxpiGrzAiyx1MdmH/0BNc6c03W0WdsMhlR465+nIkcJq0swc5EpknPlZiR6VC+M845w0xoAMFk7X93S0
X-Exchange-RoutingPolicyChecked: GrVcuC4VCamnSpvuuqDjIzkTPz9ce2PBSV+U5PJ3rEFhkp3YfQkKpmKT6fDdbrOjYkszyBwEkdy+EkAQQaiUbiVRerLmANeS+W+Jj1y/HzQ4VolGB8wk8TczTO4c0NGaiDbNd6eu+/weLDWwZL62LElxRbNsQUK5GRo4IMDzNnKgtyOiPQ+ruo0vGqdeAecKxLkGet+qmZdqJab92fhbA6juPn2TLBb4i4uUtkvrCL3F8vxFO5ie9YgL3c3FhrI5yq2JSSkG61Xuv7mTyhzgyzcBSFseOJ93vWawMhQpFMrkSp3Eeu0ty300G23PgdYZ6eNZYgfR2QnAUvPRXERzuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0N6z4yk61EOKdxd2XNaBmQyX2UrFx+CA1ZQO8dwr2Z3rRR4ZZAaia1MNW5A5DUBrabY7g1R2ivklGyqbIOn4d8FrUK42x1fLsbVL/wmK7mULB2igp7WGwfSqn0S8iyr4LF//2iSyzLn2/a4CVAo+xZWaUAh28Jm28cinSTX2IlASMRELVhu55Tfj8qiP4oRlAERRurJ8GvN4l6sbt09KQOjwem6R2mbD/LfTrOajP/3zUKynYmJ7iuGeiLBCjMmItHQATxS+FVr1SvZN3wy807c+9jmBx729q2DPF8IJMmSlCHNPTS4Q73HJmk4jzphgXXFwYCRgdxexO85iDkFN/buZrO6dBQILNVht0H/iWWKaHJCPvItKoASg/XC8mh3oreM8qX0xCqAhQMA4SashdQuRn1N89PZqs+g996A55uXP4mgs0F3OXRSIFXXYVtQN1qt8+peugmsVZe82comq+vLGANn6w8Cg/GGfBUEKKTCiF62mO57zkDtdP++AbM4nUvVA1C9lJ3KpUVsFB6RJgwItZSRcP7n1FIntZSBgv8Q4JJyR7GwVx2xdlpwKi/zinPclI96+robOzL2ql3kpHOdvNlTNdWH5YPFSb7HTLbju1YkYYGGvA7Gl0Jm5NLiP3+ZueTA6uJk3RZPfwUp71A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 05:14:50.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e96e84-33fe-406a-9128-08decf5405a2
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3876
X-Proofpoint-GUID: ZOwk2zCLPxLWDT1w7dUAbwctiWS6iBrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfX8AHUKqtw9NFF
 woA+02TQo8CPftsIo5pR576nOHt+0pfFsjlXLEpN11V0HdMPHAQqOz2NkQpL+WsUJ5c6HZYeSRO
 oHLLMIgv7KRzwBuxscUNpcTCCIuZ5NExk0+DA8K0V0J+GrS+SaCFaXNVW1/NTlGtgnMQiE86BmR
 j4W63hiymOSj47+fI/f6S+u+lhsPjw0ySM17SaXN3qOwMunW4E5YQMVb6RckYmWJpyaEZdyok1p
 1dUAKRLfe49m6Oeq3HVaJTpSfMcMfhdlLt6/XBpqGxz5yZz1h6G235Po3w1cYCBvYFe9saph0iB
 i8hPuYKjxFEIsp4ClKjtipnv1BRTGMcxCZ9VL/yYDfFOgpfZuWIX8zeTi7Hu6bXyTLkdnqT/ma9
 JDYuBsC9AX2Yg3PcaUAKf+BNpVpcn8cMUkEFilCSZxW7S0DxRwow4tsAknwxrqBtHzhYkcLZOwt
 ax83v/iwclGQ0sTJXQg==
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a37734e cx=c_pps
 a=VZSJMqPseUw/+4g/T0Awdw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=NEAV23lmAAAA:8
 a=vqpKa7XPMYSi4bbqPzAA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfX87DPI9jVZcmf
 gc7qGkIx47vlqEUtZgJ3bBNMolmTefeoaHdiCOagw4IQQocpj0BVjRRrwQRqhsnwu6GAY3sPi35
 2nPXC3Yx5g89iivmhduMi144S8X/BcMfrZoQfCjD0UhU1LYuRxlX
X-Proofpoint-ORIG-GUID: ZOwk2zCLPxLWDT1w7dUAbwctiWS6iBrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210049
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

This series addresses few findings in bootdev code.

Patch 1 some typo fixes in bootdev header.

Patch 2 fix for automatic boots in case higher-priority bootdevs fail
        to be hunted.

Patch 3 adds unit test for patch 2.

CI: https://github.com/u-boot/u-boot/pull/991

Denis Mukhin (3):
  bootdev: fix typos
  bootdev: scan boot devices at each priority level
  test: bootdev: scan with a broken high-priority device

 boot/bootdev-uclass.c           |  2 --
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 17 +++++++++
 drivers/block/sandbox-bootdev.c | 62 +++++++++++++++++++++++++++++++++
 include/bootdev.h               |  8 ++---
 include/sandbox_host.h          | 18 ++++++++++
 test/boot/bootdev.c             | 25 +++++++------
 test/boot/bootflow.c            | 51 +++++++++++++++++++++++++++
 test/boot/bootstd_common.h      |  2 +-
 9 files changed, 168 insertions(+), 19 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

-- 
2.54.0

