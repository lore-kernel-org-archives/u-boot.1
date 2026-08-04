Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B775CC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2717D80D3E;
	Tue,  4 Aug 2026 21:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOdV6dnoc9hn; Tue,  4 Aug 2026 21:55:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F92480D15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880539;
	bh=xSiFeeusBzyQCE4Zz+UQxk5Po7QMRGN8JklBkYy7f6w=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSlFZ5hesqt+2q0pO5Zmh93eZSubaTZTdgjpzZWn1dYBeRXfwDVSGgiS+qF4cnyC6
	 AiWxeKx5LoG7A6u/XJbCiLAbWbflL96yLeDkYS5uvCkKStJagEyfe3zjWvKFguTZez
	 FL/RYCKKjZ8ruMdoDEInOIo6W7sgv9qoonQErrZ+2FHMZRqKEnDOa3JUrXLOZog4uP
	 Arq3m78E1yYLn5qIBXHCgCPz2vCClk3EXvsxAjpNn8DN9G6nnQTIQtx4fBKCMSoTw8
	 Jx2ZAyIyW8S96JusDtyAPZMO40abLgTwZ4TTujrZS18IbihrM7S1tVM54yryDK9izL
	 pwBn6ZabJ03LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F92480D15;
	Tue,  4 Aug 2026 21:55:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB042270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCB3B40090
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kEoXhNWWJdX1 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 813CA400DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 813CA400DB
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 813CA400DB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoHYB3497007;
 Tue, 4 Aug 2026 16:55:27 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49dde7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrtH281PQ9kJvnwhTWaXnhsmrcDjLFXOaCNFHM3bpebj0tBIAaFKFJ/SqwJhG2ufA93oT+MQf4JGUh79loQKMJHrpYrVWFXOrU9YaB0Va6F1lg5m4pvdK2No8UvNxixkCrn7LMgVWkU51vuhF+XYFwf3pGzfe303c5sv8F0nzeGQ/dy+/w1tI6iYVp434ZwKm3jyginL0B9WL6Zg9N1f6qY+EmnlDoOTm87jtmC4raizmKkX5af46nXG00cCSaCqh54BUYO09glnCIuAPrTKCuMOfIKMaP+Gdg/S/CSW07U+RoKSDXbx52HOPSaUTid+9jGwICcdiL3WeGaH1PmgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSiFeeusBzyQCE4Zz+UQxk5Po7QMRGN8JklBkYy7f6w=;
 b=iahfX4vTI2cvYTqoS2ohnTOb7GI65eLTO51VnekdHZxt9eH9Vb/Xj7XliTocrTyTBL5kWFTpbVhaf6WYvRd9WsP/Fbbwm8rpFT6KCqHrc6u3GIf79XAwZhrhltrtwkrDbR4e3YzLWGYmtCOBU/Om5ZhbCksiDJbK9sMRxkfl383ZpbJb43CBtTgFNLc6EmUxnSKQ+kE4aByR5RvbjfObss0CZOT7TjhTyR6sHFtdELixK9hyUHss/G5lRm/75d13S/XsQj0QjZ331ma34APTSBs6wgqj+VBvL2LFp6q3W/9ZH3z6F/yXgvbRxAtmn6du/exnz3WAO7kGhIUkoC79lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH7PR17CA0043.namprd17.prod.outlook.com (2603:10b6:510:323::9)
 by IA3PR10MB8705.namprd10.prod.outlook.com (2603:10b6:208:583::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:23 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::a) by PH7PR17CA0043.outlook.office365.com
 (2603:10b6:510:323::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 21:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 21:55:22 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIPF222927;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:05 -0500
Subject: [PATCH v4 06/11] board: ti: am62lx: add initial board files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-6-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=15865; i=bb@ti.com;
 h=from:subject:message-id; bh=AMYII3m6CIWrbnd7NtZdHPsI9e5dIG8Qa0irlqXkhck=;
 b=owNCWmg5MUFZJlNZfJPxAgAAb3///7/v77/vf/PD2q+Yvt/6rV0+15b9vfNXXv2/u3r/39+wA
 RsYHag0DamgAAGgNAAaAAANB6gA00AA0AAAGgaNDQAaAaZGh6mQ0PQZNqQ6ADRiaADQ0AAADTQD
 ahoekAYjQADIaPUyAYQNPUaNAGn6oA0A0HqDQAaepocmmTQNMgyANBoBiGgPUBoAZAZAxGmQyaA
 NAwQDTIaABpkAAZNMQYI0aAKF23uCxq8OgDCn2mgCUcGAuXkClgRAJCB1AljtdoWfQwaGY2tlTt
 4wBiHxTdIDhgIeGPGjbKsiHToRwCl6l2DbLV4DdqvKIfFdzPhUvJzQDw8SpV3G9oB+w8djJhmPI
 TnjKQR4K4kXWogxFYsP9v4ESwGV9FKpGvIuqw+a83YzqtlIGgVT/eMyTLatAKKt8rkmQCmDoxgL
 3j12C3l9o+DH0meV3GkTYIORFhqMb85vuB2hVdzUhW66w4/83OaVINNEnX+XuKj/FXF2CeHrEi2
 Hmh7zejWJDz9flUhkkte2bmoAFKFzZA9K3YG2lGVoTxxNBfadZm5yYUoItUGJW7H+ikeGVLkPqk
 sOdh5oLSU74D4TV80cUAaeXEK7IYAmO4ZQUayrmBZA4n1LWuIaB+qSSksSNEKSYojQDoRMsdXgA
 ZYBh/4u5IpwoSD5J+IE
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|IA3PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eca8be3-3862-4985-58ae-08def273151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +NRBueEXIB1n89plSJvo/yhDS98oT0wbQc4szfOXQYHPa7ubEoljKwaWFY3Lr9sZlKR3S8GikAISEDI4V4Tevu+wIA9wf1Ra7hrLb4t6AnlkjRWEMK0fR/8wyXTP3Yzg8it4zfkwv3RsipicijyB3UU0k8KKTehEPeItLJGFhR5Fw+EFAx+IDTIDEv7viIktpBvV4Sm5Mypu0s4LJmxhOuMwDyP2f61LJuFuZBZjxLmDoZ0ICgEopMusudzlBh4Ppav8ynak2PmZioLTqpTvm4ZXf9IewDYNIfiMIAZXdw811xBJ6iF32K342kwHjK6ZK3gT4vi8MRU29hywl/8Sue/r05akcvh3sEasrCzEoAS5Sc4R6eOaN87fICJe7KGgZARYEfESiiWOw4U9YT34x1AnCF/en/qUuiU88RysMPsCjpqMtFPIEjWEzOeYcCaA1Wb3xrzrwaO8nxlGeCyZMWdqv8DiI1aNw2iP1XRdnRn6QB49WCUBnb84uoBvPGn1yq5twk7bD5xC1R3LhaLi/BtsdchIwe6p918D4Nd7fhlVtH82aIQrYEn24Rah4nsWoUB3UJDtHnHzqFlL1U1vp2rw8cXt05Cyd+eUHdyXqg51wA3P7SyS2kOHs1U7q9gFrKIGWcSb45QaqLMAyTwfgQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DOacdEeqz0Lb0TTzXWD0LVpoppcysE0di4bU3j9Zwa+3aJcANaXkak3wgLouQxXtbeVVyLYeda5RYiQ+9pD8T9tdZHpiAGlveWU9+tMS1BVDVyWXHzSYUy1Q7DDjQQdNrF+0fOWvUjPlm6oJh7nqK2yEcCIrs1g5IFg8zPl44vExG2zGLFEvs4KuYSp2UUK6zZTpizsE0I3V4W8SLVsLjKRC/L02B0LNXttyCmGbkyhq+9379HdwH1MVxQ3KF6+mCeqFLhs3IbsrMtatNwBR8ibXDOdPPUEWhrAyDD4hBEjF4KeIrraQNesV15R+M3UOBNEsLRRR/hhzpO4MNvSN46oneOsHt3GJjWFe7Z11Y8rxK8fL4/Q+T9aO6W3vNCOnpRgE+0+hyR/QnH824fgDu8JfAzg2WdWzRl/7vXzmpWgCkFI/o9AoRBJ+vU1HKOC0
X-Exchange-RoutingPolicyChecked: f1mak3W66IGMEdIYfripOfbtuVcvGD1cVPl6aY5VjCEy2cR43LdmP7GNtVBk9iFH7oOgT3tuXMGlJtalWZUKO2BM1r1Rd9pVWox8WE3ZhMcXR8KfOEFO17CD/SLDoQ052FjkW9PQMexneX5/RPwZLnXWIwDHd2/7HsDxGyKf+mYfFDB+NOJpiOQ7AO7R0ZIvem3NfPm87X/+rTpgWYQjojbuUncCDrtvy/I9rL15jkjczbHsp/OUY3JIrYWWNIemOawid+DraociSz2D6Ap0sC91Yjrve2kp4IqbqQnC5JvOoMINWiYJ7tBmKxmen4cCllq5D2euK5lo3IPG0SaMKw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:22.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca8be3-3862-4985-58ae-08def273151a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8705
X-Proofpoint-GUID: gB7l-lz5F5yVvlulSISUACXf9dXBIHyD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX/awiNTI6b8K3
 ebjHJitZqJaESkaqiolDVRtp1/D24153LKFDIb0r4dPbbafMUFE2q7fygLRs+pNjc7ohLQXOom5
 hy4H131FH81XweBS34Df/4Sj5uavLtCcthaIKrkGhRhufcU5d20JxBiX6ZiCoNc0ULESn6Yar+h
 b9Oy7yHsa4yVvJoWEbgXGJZi5bqYFsW4PsUFeRhpe7Y1QzvvT3hYuzdtg1oMUaG7rpZ/sYN4ICU
 MUtR/su77Ywo6dUHzDX+KIc70901rymyoa2NxUwaRJMIk7k6tcgK3WwNEdAPsMH5mBXHp+FUIbZ
 9Hvmft8oERb2rTpVkAdOETnOyW6NE/y6S7DXV7Jjz+LIo4o7OLZTEGkOkjObOgoKfxpafhmjS26
 CHowr0J9uROwAc6NlJA4vjxkX9YIUMq7BnQESgaXjVRCOl/JGVjYsxUSRDOdd0fBsD4v8XiiYoc
 C3Gt2RmRH7QQfs3y8tA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX9QpmIHlzt/om
 r2PGr2pfRTweVp0hIC9JytfmFnYoHsM54P9S2irPKVJ4A1BABTCjnSEgVGpuzWTzH9YiXZjniQi
 QtUkjJkDJcnVmz87d4GasXBJW3aSu1U=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a725fcf cx=c_pps
 a=cRSuPULe8LMj8fTR+fkUeA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8 a=PIOz4nRI_0vEO2-WwqMA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: gB7l-lz5F5yVvlulSISUACXf9dXBIHyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xSiFeeusBzyQCE4Zz+UQxk5Po7QMRGN8JklBkYy7f
 6w=; b=KdPO5aMXMrGMfd5PCME6n1FrMXdoYAB6DL/91RQ21fqzE4kVlqo3XPCKU
 GRDgWHcO5Ke+3C1G4EYSWXCC0BfuXEyknDlzsoScC8RRa+SzAertevIwL/fP8Xmf
 hVRUFfYE65McI8Uqixt+Jx0tZabmK7Ih3Gm34mJOLCYiyx1A2IHOu8OUcu3Xbqfx
 J9h7A5O5I4v87lNoNMDfw8q6Oco2W/XZOJSVbPOj9kNWSMKnOtUeKuzW7i+9xr/Q
 V79BSB2unuGrE49F5j+EeQkLrbpekNSuZy+jLITg6AS2nHSvk9wy+pzn89skDrBF
 LDBCnY7ep43M4MeRD/ZWL6GxUtc6A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSiFeeusBzyQCE4Zz+UQxk5Po7QMRGN8JklBkYy7f6w=;
 b=h6Aq/RMk9luhYHW9hbI4l2LfpDAgu4w1QiZPyGUiOt9EXxIjh4HOXIdsTmgleAYExWFcNkMJteMqWAszessJ/u5eGdu0UPa3567M6ChLY+30uXIBwPlIse/+CzAjibTqaarFa3oEEM5gwGOumJCifqzA13KhrBEMSkIKeDUyHaA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=KdPO5aMX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=h6Aq/RMk
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the initial board files to support the AM62L3-SK reference boards
for basic boot via SD and MMC

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Removed 'emulated' from the board configuration file
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 board/ti/am62lx/Kconfig        |  19 +++
 board/ti/am62lx/MAINTAINERS    |   8 +
 board/ti/am62lx/Makefile       |   7 +
 board/ti/am62lx/am62lx.env     |   8 +
 board/ti/am62lx/board-cfg.yaml |  32 ++++
 board/ti/am62lx/evm.c          |  19 +++
 board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 473 insertions(+)

diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
new file mode 100644
index 000000000000..2ee6d0221178
--- /dev/null
+++ b/board/ti/am62lx/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62L3_EVM
+
+config SYS_BOARD
+	default "am62lx"
+
+config SYS_VENDOR
+	default "ti"
+
+config SYS_CONFIG_NAME
+	default "am62l3_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
new file mode 100644
index 000000000000..e945689a7f17
--- /dev/null
+++ b/board/ti/am62lx/MAINTAINERS
@@ -0,0 +1,8 @@
+AM62Lx BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62lx/
+F:	include/configs/am62l3_evm.h
+F:	configs/am62lx_evm_defconfig
diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
new file mode 100644
index 000000000000..ac5f5e7e807a
--- /dev/null
+++ b/board/ti/am62lx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
new file mode 100644
index 000000000000..0dd86db400ee
--- /dev/null
+++ b/board/ti/am62lx/am62lx.env
@@ -0,0 +1,8 @@
+kernel_addr_r=0x82000000
+fdt_addr_r=0x88000000
+fdtoverlay_addr_r=0x89000000
+ramdisk_addr_r=0x88080000
+pxefile_addr_r=0x80100000
+
+dfu_alt_info_ram=
+	u-boot.img ram 0x83000000 0x400000
diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
new file mode 100644
index 000000000000..abb3174d4bcc
--- /dev/null
+++ b/board/ti/am62lx/board-cfg.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for the AM62L-EVM
+#
+---
+board-cfg:
+  rev:
+    boardcfg_abi_maj: 0x0
+    boardcfg_abi_min: 0x1
+
+  control:
+    subhdr:
+      magic: 0xC1D3
+      size: 7
+    main_isolation_enable: 0x5A
+    main_isolation_hostid: 0x2
+
+  bm_writer_cfg:
+    subhdr:
+      magic: 0x7D8A
+      size: 5
+    allowed_host: 10
+
+  reserved: [0, 0, 0, 0, 0, 0, 0]
+
+  debug_cfg:
+    subhdr:
+      magic: 0x020C
+      size: 8
+    trace_dst_enables: 0x00
+    trace_src_enables: 0x00
diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
new file mode 100644
index 000000000000..cafafb8ede87
--- /dev/null
+++ b/board/ti/am62lx/evm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Lx platforms
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/ti/am62lx/sec-cfg.yaml b/board/ti/am62lx/sec-cfg.yaml
new file mode 100644
index 000000000000..044e8cb09dd7
--- /dev/null
+++ b/board/ti/am62lx/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62Lx
+#
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        otp_entry:
+            -  # 1
+                host_id: 10
+                host_perms: 2
+            -  # 2
+                host_id: 10
+                host_perms: 2
+            -  # 3
+                host_id: 10
+                host_perms: 2
+            -  # 4
+                host_id: 10
+                host_perms: 2
+            -  # 5
+                host_id: 10
+                host_perms: 2
+            -  # 6
+                host_id: 10
+                host_perms: 2
+            -  # 7
+                host_id: 10
+                host_perms: 2
+            -  # 8
+                host_id: 10
+                host_perms: 2
+            -  # 9
+                host_id: 10
+                host_perms: 2
+            -  # 10
+                host_id: 10
+                host_perms: 2
+            -  # 11
+                host_id: 10
+                host_perms: 2
+            -  # 12
+                host_id: 10
+                host_perms: 2
+            -  # 13
+                host_id: 10
+                host_perms: 2
+            -  # 14
+                host_id: 10
+                host_perms: 2
+            -  # 15
+                host_id: 10
+                host_perms: 2
+            -  # 16
+                host_id: 10
+                host_perms: 2
+            -  # 17
+                host_id: 10
+                host_perms: 2
+            -  # 18
+                host_id: 10
+                host_perms: 2
+            -  # 19
+                host_id: 10
+                host_perms: 2
+            -  # 20
+                host_id: 10
+                host_perms: 2
+            -  # 21
+                host_id: 10
+                host_perms: 2
+            -  # 22
+                host_id: 10
+                host_perms: 2
+            -  # 23
+                host_id: 10
+                host_perms: 2
+            -  # 24
+                host_id: 10
+                host_perms: 2
+            -  # 25
+                host_id: 10
+                host_perms: 2
+            -  # 26
+                host_id: 10
+                host_perms: 2
+            -  # 27
+                host_id: 10
+                host_perms: 2
+            -  # 28
+                host_id: 10
+                host_perms: 2
+            -  # 29
+                host_id: 10
+                host_perms: 2
+            -  # 30
+                host_id: 10
+                host_perms: 2
+            -  # 31
+                host_id: 10
+                host_perms: 2
+            -  # 32
+                host_id: 10
+                host_perms: 2
+        write_host_id: 10
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x0
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x0
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]

-- 
2.54.0

