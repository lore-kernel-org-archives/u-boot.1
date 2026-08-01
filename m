Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C793C55171
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 03:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 088B440791;
	Sat,  1 Aug 2026 03:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELXuQZp0_l72; Sat,  1 Aug 2026 03:42:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7E6640783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785555756;
	bh=mTGsC8O4cqB2R914B+eFqyoAcQqqIsbxdsJ98wutlDg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suWlHM6/Y2PGGvj5Y3AoRZ1n6ujQKA4+5RghogDn0LVL+uSIPoLUWL0FcVIS/ZyTD
	 6o518E68pEs0FEtcMXaviSahg3VgH0V9a2wKC2l/u7yIK+2Mi0epn50lOIivzKop6H
	 tOTsFCyHQbAHUudJLPw/mZwpFWkSrL1AwR07Q34cyOdJrKRSfRKSThzv/l0tZ6xhuI
	 oeUzyhF1EuvK2LF2/MSyq408C4yEzA7YBsEBsqyI+TVDJjYHkOdLmiDK3RbqXVIYzZ
	 quXSxxPsNLu/IYxv8VJAdsS9pFstQlYD4sA+1PN//sxOVtWhddVtBRJSsGFRpuedF2
	 0TRWLaGD54fdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7E6640783;
	Sat,  1 Aug 2026 03:42:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CCA626E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 03:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E9C74066D
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 03:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiExu33ZWgiK for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 03:07:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1797B4066B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1797B4066B
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1797B4066B
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 03:07:24 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VM0AJg916087; Fri, 31 Jul 2026 22:06:56 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fru8kvha4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 22:06:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGogiNCxJiSMF7TUdEYqpTsEQp8IY5xSsxkh5wfpPJyrwvkZcoptBqAXBn/9+sFE5AwtDiVxV32QQ0Qk+rkW+iFsMWPVFt9mNYMPAGLqRx8PeJDPzvX5oSExp1Qo6tpwd7Pkd128E697Iv/iCS+6wu2HGrikCjhA39EqknRfdZVOdhPFZYW6FE1AB2P0TDgdM+oLjVf2cAeZ1XvpX0pArLyXV0wMHb61Mc/Amkcqjl2m6XO83AgzbN3lBZNaTfZ62yVCCkACU4ULa0mFktTUlRRzxSeRnHANQzyVpnBkZlFs99c4cEqmmfv0l6rNc39od9ljDQU968VSDWUk9quHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTGsC8O4cqB2R914B+eFqyoAcQqqIsbxdsJ98wutlDg=;
 b=l5A2S0EtE6WJmbBdc9AgbDdA1s1G5pBd/EP0ytAZ1bb6H6hSu/nod40+ocU7YoJbAcEUH3ml93d4THVsqM1VVrnQdoehzQbVYWYJPreUDzJFErpxa2L+uK9zq4FVWsD7vWtjDZtyjepRmBymNIcYFt9Dt41aNUbrkqR84PeDlcYpxFcTGqLRPsmCXS/alH13zjEMiJteIrm40yYJKiiKdIqH9FD01EatorE9mKVOCLbLfnxCrrL2lxOJ5Gn1ABI2t66kaG69pX+JBEx/vKmf18lhs2zQOoean30V6+GIVSrVgzW+rlQyFp4Oivr/i6t+U4htL0jyJyYWwWh4O/EDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BLAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:36e::29)
 by MW4PR10MB6372.namprd10.prod.outlook.com (2603:10b6:303:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 03:06:47 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::2) by BLAPR05CA0017.outlook.office365.com
 (2603:10b6:208:36e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Sat, 1
 Aug 2026 03:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sat, 1 Aug 2026 03:06:45 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 22:06:40 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 22:06:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 31 Jul 2026 22:06:40 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67136RuF1740972;
 Fri, 31 Jul 2026 22:06:28 -0500
Message-ID: <cb7eccde-b811-4572-8c30-7be4ab3fb7df@ti.com>
Date: Sat, 1 Aug 2026 08:36:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] spi: cadence_qspi: enable clock
To: Ralph Siemsen <ralph.siemsen@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Abbarapu Venkatesh Yadav
 <venkyada@qti.qualcomm.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Naman Trivedi" <naman.trivedimanojbhai@amd.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Boon Khai Ng" <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, "Mikhail
 Kshevetskiy" <mikhail.kshevetskiy@iopsys.eu>, Robert Marko
 <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer
 <ben.wolsieffer@hefring.com>, Stanley Chu <yschu@nuvoton.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, James Hilliard
 <james.hilliard1@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Phil Edworthy" <phil.edworthy@renesas.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, Julien Stephan
 <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, <u-kumar1@ti.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW4PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa1cfe1-b430-4f16-b7c8-08deef79eb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8D7GzWmhPujJ2X6rKqlNnzWNsy0ofoKjbdKPqujixZe2iiJfWuW4jmATj4R4uFF39nEypSJqOzD7Y9p3YA9ON9c/r51IfIPMawCby3svjL0FurNY2f3AlDPGXaef91y6hNfxNDjHEJDJ5g17prI7S7xtINl62gWNc0n/qJnHaQitlFXlXFyMsxyfAifBwpq/qPJBbw/JkShrQmypK7t2DxrJy7a7ms4U0HfLz73lXbdWpndTVlQuwqLL/qJyDfI+iTZCX5NjQPNf2ENajSXMn5zjfiy/8dLtJ51LQ5/tlv4nCv9RGcWATgKgFAGTLRDD1l2cf+9xyGGJlkue5wsLyjbgg+mNmylK8NRWTOuIN/X8I9hNRI3EbnzsS+0Fu0lI10DSOJ8HNfR7ZBJct0dTofWv1Xum8ho0anOVoOX9BCWigeJb7tKnbQdhmbabGB9lqAxx9n/3MbPY5h54B5S54abRgPbXPxbxzp1R0NuK6D4dNdF9m84vYzT9Vy2u/C7ibS22ZmAkHzXGqC2VZtUm4koXIlFKsrQwHCrAEZirGugJlsYFBT/o8j+vURVGtvDgsFBGJv1N316WmppQrW2DXie2zdnOJDEzpbOQzgdjVLi5n2soxwRac2h+vhCz4puJ3vB7+f1xboLoM6jZeNJ3SSSaeohjYydoo5dRjCGnULey7YaTlLyej4XlaDmI5QQYVLd9j3HENkNuUlsc68h33w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S2Dn49vIyPfxRTP1295aP+I6Y9rE4Od/H8xsnItYyPtRm+nwL8xnBDpydqbvPGJLY7HP+M4Thgom25EbN7uJ9JvKCqqSn0zqmF265mKmuRvc2VzauMJruXZzhSdGPsMwUBNZeUZQrWttQr3IhHHvBbebVKfYtn+Yfj51bAQv0Wo7QK1QMXnKBmjf1uBuNKjZVeLSfcVF7HyF+GVpD1vsBryrPwQfZhzREVnsKFf854I94Baca/fdUmMX9MjrnggyOZDj9YFcOrGOn4pGOtzxroPEZ9CyJvDLXQPH0ilGo5ea517bFevpOZG70k8X+UB8Os0n3h/AnUbYDhr1A0QdMZ2YqxZX8OtLfvX/mmYTt9Xv6ytye1l0X2xNGxif4rRaeNyxJDtrJ644DrE3wLx0rIxG2GbSO7bNIrgNGS5JhbtPFv0U5s3wm2SvAM4vBe0F
X-Exchange-RoutingPolicyChecked: inA+jDcnnoi677q45E6HEgSWLDx2xKwoVjnVDGq+PlP5Uvanf34W7vJy3SMseHEwUxMMWWz48++7sNq3KqKnVQ7n32iMVSPVKshvWDqhniDWvmipWFt2HuuVZ1cUqLRVMl/elG2lFolBE3WGG1CIuamEZW0g5LqqL+Fx3GfMdFJlTmaJBWVkfO7oe3Ap4eHfVfMdqoBuG23gUkJRxonrZsQLryEiepkcCZhrsNfE5TsGkXbRV5rYYEL2pfnQ9QW1Eam+yU3A545TzZtGZtcqhnH0D9f/PqUPwljFNsV9U7TyDoEWiHM4+gKSJVLAiKvICSs+YUx7V7emGWyjO8SEcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 03:06:45.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa1cfe1-b430-4f16-b7c8-08deef79eb76
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6372
X-Proofpoint-GUID: AxxiwWTAXzVnpQ5DBUErffdhOiB3pt1n
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a6d62d0 cx=c_pps
 a=+TgAdn5i6nn1e/5/V9fTSg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=KKAkSRfTAAAA:8
 a=vNVVz4q5IQvRE8xS7UMA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AxxiwWTAXzVnpQ5DBUErffdhOiB3pt1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAxNiBTYWx0ZWRfX5F/YiCf79WP2
 /RQ3aZgOIIraZlscMDk89RiDhTu+54IlauUnklfFjVibTpxaJZ4a4ja5f1+sRWACeMjQmW8g57W
 oZYmpoIa/WuV93pTdYaMQ1t7FxbCqQIBx8oqHxPX81qprmmCcT2Hmsea9f36sTLzu8einrknsan
 jxCZ9XUA2WuGIvPLbH+1n+7gCGV7q8fW/7TVFoXY9uOVer74+bvZknhL2sJC+5LAVkpko2C0qOb
 afvEIM3zM3IcbB5DdXUHPRO1ev1jYWttwOczYC6X89kTs+adEW3hNaKRyf0TojTb723hlw3a7zl
 pBYHOfrXDtdsgShl5U9lBkaJla03iMuR3Y40QFMsl6i9Y3tPQjqsDmDZmyne5q2JaRc08rw6IdC
 A/CkVkMSjJbl4VMrnFYOFNY7jR/EeeCdy2U+11X688BnjMZJrxZMH/U2lptTGcHzgl3cjxCTBki
 bhZlKUwuVH+tWJsRpSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAxNiBTYWx0ZWRfX3ShgHa9nnlch
 jNFVsxztd8mI43Xe6O34EBwJ8ZGBBfaKhYUPIc5yDcQBPd/JUxtCGPQhD70+NRz4UskFDfgEQ3Q
 IWJ8aVK8fIOePF0QvH8ownNxpOoVIjg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010016
X-Mailman-Approved-At: Sat, 01 Aug 2026 03:42:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=mTGsC8O4cqB2R914B+eFqyoAcQqqIsbxdsJ98wutl
 Dg=; b=MI/TVpbig/LKwbZ7Q9bV9DY5fycatNF4E6pmJ0wtmt/iigbTOkoCm12WK
 kE+Pho0+zdNx6vhMbdBRc4mwrwq5zU6Yc+kGFU2W5xVn83606F8+cDusrMMGCGUJ
 aXPl4j1wzRXZot31n6mqXl0X8CBFyT37O2EMwZ9kj+CUVzc/CjCagyvrXsHNQGYG
 Zzd9sdKBwGylT46Oyf/EBl1DUkE0uk6/mwQjFwpqIhQKGoclJOqwWhAcSLUP0eON
 zUqs7M1WpXa5WL2dxK0Z80RAz1/QYD7bNpzVgTWkxGmyjilprGqpZ38O6ux22DCy
 GxRk4T9xTbsqVl4L2UQONSzHHFS9A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTGsC8O4cqB2R914B+eFqyoAcQqqIsbxdsJ98wutlDg=;
 b=ddo6Qn13yu9NOqJ5THb3/ELFED7KCcUo/qdakKw9oMdHvoaoFvDaIw349qook8pWBStlyrUGpH+k3MIc5UwmaYSg9JJdj7PvJeIL/0H/yjyRGBVt9iEutidPMAEFU82a5HzKfBizKLZP2Bs8BZAeAFzGkVaStcWs26/XKJfujmU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MI/TVpbi; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ddo6Qn13
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



On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
> On certain devices (such as Renesas RZ/N1) it is necessary to
> enable the clock before accessing the QSPI controller registers.
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  drivers/spi/cadence_qspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 984d4a39ded..c383caec6dd 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -253,6 +253,7 @@ static int cadence_spi_probe(struct udevice *bus)
>  			priv->ref_clk_hz = clk_get_rate(&clk);
>  			if (IS_ERR_VALUE(priv->ref_clk_hz))
>  				return priv->ref_clk_hz;
> +			clk_enable(&clk);

you should enable clock, before calling get_rate


>  		}
>  	}
>  
> 

