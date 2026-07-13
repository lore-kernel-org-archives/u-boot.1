Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23274C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 05:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D41848EB;
	Mon, 13 Jul 2026 07:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="otgikj61";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="teTeBkFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857F784A0B; Mon, 13 Jul 2026 07:37:21 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DFA801A9
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66D3AHDi2430030;
 Mon, 13 Jul 2026 00:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=zBDUsTpdZQoy/
 Ob0OokioaD9VPvNOao5o76P9ZdJT/4=; b=otgikj612pRPrWuCJ9ax+2PrtZ01w
 fta7CXR41rmSNR57KSdwMxOd8zvobcEsgFalzvqC35b8C8e+fd3ojdAGBvu7bAI/
 m5mHdCeCpzLeu28UR6r40QNnoxfk+g3PjiU+wgM/7H7ZSXxsOOdG1KcuM4d5Ie8w
 JSKen3CfwuBGn1v5avoPvEmRaCT3Kof7DtpljAmtWNEgrYdSygDmRP8nW8u8hWTS
 MP1TuqNa/EiTymUaAHMr8gQwg/xIHS5/vERpkyA15jtLCq0KpCzTfUAaENfuTQlg
 HpzWDaXjIWgEAKiAwVFjNjVlYD7mAUZdzYr/QPYWzLBQ3Av9Hrib+nsAw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fc6unbvjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 00:37:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDtjTemDrJdwOLmy3DLksnN0RR8VkRyA1qfm0JgWIOMnzmCsFQQyLhhBAFSik3bbtg44QWRKZafEWv57JS5rWOu0LFw9/7jG5F4xoZhifochyjVXzok27BDLMZeDAom7zqYVDD7526aQAfbebfrN2R7flnF3tV421LMfRuh+3JApAZvsn4CiH4zWrprCHBFtCGGJK+oPF5GzpflavO7MAPbVqtZssBe249Uk5aII5EsIcZV2IHbH4tyRSD5XDLPmikE/Qek1m7JcxvC+H9CuxrEhtdfFTFZ3m14BjUkohtqPIN7xkXPNcNzUZ27LJ2Uxi/FZ/PTpAujDfOqF26JEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBDUsTpdZQoy/Ob0OokioaD9VPvNOao5o76P9ZdJT/4=;
 b=IamGIlOuutsM9wPE0EbCzUOGCgOu/j5ega7KEujx528RU+A1bXOFv4oVIHDODZIQxD5y327oiB0RxqlachUAx9QgdehXMx9IoY3/VIqE280wN8T8CpRDpkuUKpeEhQ4m5eTiuh2rhFHia5OUGhL0SSZntnqXxPNfKGxMdFf9miMufolOJ6gyFGmHvt/v++q2vHbqYBOpyXEiGlYUcgZeKaWvLSb8nL8YB+fAFgRXjCNFcBRyqxD6wyozhwDbb8aII7/YH/VF3AuzC47ZQq8X96zZN/hKdnDO2AVsZUWKCqPDOsxUhKoGRqDl1qD2Aa4+qwWuxby0syj8kt2cDjAvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBDUsTpdZQoy/Ob0OokioaD9VPvNOao5o76P9ZdJT/4=;
 b=teTeBkFTWBlEGJBts6BfFOQfqR83MO2zDM39ryaSmhvAEu4EpJu59bVVOZZM29HZHeN6dg6d8s5yN87wurFBMcXOLgN48NZF4AR7mAFarXxjhhJ37T2aum8bE3yE6gNAsR6I7ULwSTd503NAkNTEtX0Y1v7jwnnP/n5Vwf4ox0w=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by CH2PR10MB4213.namprd10.prod.outlook.com (2603:10b6:610:7f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 05:37:11 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5b) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 05:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 05:37:09 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 00:37:08 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 00:37:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 00:37:08 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66D5b7v51366001;
 Mon, 13 Jul 2026 00:37:07 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 13 Jul 2026 11:07:05 +0530
Subject: [PATCH v2] mach-k3: am64x: clear MCU_RST_SRC before reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2Zp2pdR48j8MIVBXWRPAdCtiC
 P9uwbvHN5l5M4NQYBI4ZTMEGll46BPgLgPf1v2dFF8TA2ostNOo6q7Ip0reVZBY3XhS1Nj8UBh
 Ed9SQZs9AKd6Ul/LH8moe5OPqWRstSxzCZ/sczdr7ox+NMsrntnbOElrnz5H3fuigXJblC+m1M
 va/AAAA
X-Change-ID: 20260702-am64x_sw_rst_fix-eb5436122780
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>, T Pratham
 <t-pratham@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783921026; l=1323;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=FQvQMFbCSEAPAZRfZuuvyJ0zrqCawGXTbxtnUmOGClw=;
 b=p2CcGU9kQqjT7u2Iofk/MjA9bUD2igTc25hDSCX/61ji+fzte0DDCj+WhNGHrjzHGwaRizkl9
 bkcQEL/kfX8D/DYFs0NQk0wsY7VsFJJjCp7eeNOsybaOs3wHKMe31NC
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH2PR10MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5291be-50ee-4093-d84a-08dee0a0c893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: MOyodW79gMyrFtxyE7v+zIwQMT07lELfmsz9gdda2RVS22ReL+pTHSN9Tuy/1GW/4snpJX4XhBR4t6OyNrbkMTFYkicOK8WaqTmi//r1GHPoavGiS1yhG7IQG9ex0HwNPf4iwABm40BJLKBM89n6eDcbq0INpq1Y61x/ez1r/C6qGB1NvbL4ox0+ofrMn/LsOfE0vc5HVa4V2HvFAlg9GGXChVr6fh8+DMsKKuz6tZyDtlcnFbAdTO7yWpQgElXs1b70ABiRofig8kU946kbafRRwI5w0VDHwywOlC+f1hwTmCsSHhlcpg2P4MV4qs72btNqtxVpuelitA2i0BBQbk3tCzAMbA3t8S7TtKxR+Q/gJ5rlTD1oQUkvbRZXj/M+NVQSKjizw2v6spQtJIJ7sE/IU7Da4EPtmu3U8ffZki0VRBIvSR0NJEOD4sV909c412fmoan2lNe1oKIceWJ0DIZINWqxMS8DwhJzyF8bJyD+zbrka13OVnygPDr52l3ONV2f/QIrSfJnRhR97jzM2x6eig4qrJcM95gulG3u/VWNbwA9Dp4h5dT0fMq0Zg6SCzORnBq92iA5v9kTyz3fr3UHd3ZQV/1mgZdV28cMMZ2MOqGpEUGi2b44BvKQqROrkkAA//G/IKnQZ2lIA7C7cuAKNske4JLPrMyTO11zZV0=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E4GMoJQYxnjwOZSUjANrUfnuihm3m+kGkIeepWfOTFAgspnAdLJz93PHqiZ5mCqTDCj7pj1xGwhxUtdPWDUy3IoCxRQmgx1qHcxQoSNqHadFXBNIsQozHwPMHOg2ixwbEX3vPDW6kNhVk0Jxn5RjI46DJvSYyYcusFJCsmYnJnRKdVhjr+EUC00j4NsKOD8bVoWnwbsl0lYqK4ogkJK1X9KRYe41BEZdCj1JyZosA0QS9HZYkFbcZSFnHvqsibVSvm2IQQH00J7qmjEvU7fgSRk9qjMYpbPrd9q0yMmcZ97ximM4DwPB38nWypeMbUJrwEUl5ttFmn+9EMBowckk7+69c1vduzGE703Yi4Z5wiwHcUiE1v3OYc9HipWSt3KTJ7aoDfyHSsek4n8uVycVUF6Jn2AKBcbeaJtNYkFRIchLgEU/cmdqt0giZWyKXlNl
X-Exchange-RoutingPolicyChecked: duviIogfVSXvnRZ8P1GRnRaK1H9PY4KySOMx+KE8129MsV6j/rMD+XYWdCaE9pmjxLZzcPYV/sH0a4yhYY5RvtxXD0KvsluZM11TFJVIqY+q7+YAQMKWk7EP9f897HrLyf1W3ZHymne0m9N7iFdyPtjRqU+uFTTXp+thrMUPVerewaXREg4Me0611W4untkSRQOKtNK4D2YLumf4FqzA9NHQsTkxXNhKO9omqsrK15q6roloGJ/Atr6FW3WhKSQWTKAD4jeq/PglrWCuh0MPGoC7bZR/3vSlMYfk5cN1XUpuqxksZwmn4nOsXaJ6H21rd9cc6iatP59MFTb+CPmekA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 05:37:09.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5291be-50ee-4093-d84a-08dee0a0c893
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1NSBTYWx0ZWRfX3IBqtQvnCBVc
 l6NWkk6VNfHuZ3w2Qh703+LAyGlsUtuz2zqh1Qztg+VyB/Xm/PDgJ4S2jm3rEUhxyDKSyup4Am/
 lDqUetLmFd6sIKF4sIlbchk+mD1igXXrKSmrRicuGRlj8iB/IoZltTBEgfuWbZSj9lk+73E44nl
 oaTdydILUICbSDJAY7XaAMo7N8IFsUcK7EAXFn39AjIzj3zBKuuRjo5CGqwz57oA7qoLSdbZYAn
 h9a02r6Nz1Hf9eROAFu1wWEgltzFIOUTjuavuzPXJG05BMPaBkj9rU558/wSJC+wrnrlwU8f60I
 SCer/Xl6O5EScWe2L3dxS0jxaO8NNjx9JIb9Kaw094jQYW2XBgle2dmVnG52ScMfB1v+WBCZ68/
 qPi8TH21mfI9SPE9rr94AhkfKEjDNVamFngSYjXWF2gFbk2MesGnWj3NJZoeBhTlT85uTAqm5Px
 E3cmtNCA0lokY/aQ82g==
X-Authority-Analysis: v=2.4 cv=IMQyzAvG c=1 sm=1 tr=0 ts=6a54798a cx=c_pps
 a=mOf1MaddDbw/YSD//5QIpg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=bC-a23v3AAAA:8 a=sozttTNsAAAA:8
 a=OAlMMrMIfnwMU6RXJ2oA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1NSBTYWx0ZWRfX53KUG4P3Smhq
 X4BVT2I718JiEAhO0Otw78MM8jU95spoDkRPs0huRLVTPTwBdhyATzsSxYxZNEbj13QUCTBQKyi
 axPXbKKoRuwKlxB4ia0Lgsseu/CG5FA=
X-Proofpoint-ORIG-GUID: k-RHuchhVxmpjcwiqO26HzutFxv88qUo
X-Proofpoint-GUID: k-RHuchhVxmpjcwiqO26HzutFxv88qUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130055
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

In warm reset, the value of CTRLMMR_MCU_RST_SRC was not being reset.

This leads to a reset-loop boot failure when a warm reset is triggered
from the MAIN domain (by writing 0x2006 to MCU_RST_CTRL).

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Fix commit message where the issue was observed on a 'warm reset' and not a 'cold boot'
- Link to v1: https://patch.msgid.link/20260702-am64x_sw_rst_fix-v1-1-c45a775e257c@ti.com
---
 arch/arm/mach-k3/am64x/am642_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
index a15adf1cb1e7..a177c2658d49 100644
--- a/arch/arm/mach-k3/am64x/am642_init.c
+++ b/arch/arm/mach-k3/am64x/am642_init.c
@@ -255,6 +255,8 @@ void board_init_f(ulong dummy)
 	if (rst_src == COLD_BOOT || rst_src & (SW_POR_MCU | SW_POR_MAIN)) {
 		printf("Resetting on cold boot to workaround ErrataID:i2331\n");
 		printf("Please resend tiboot3.bin in case of UART/DFU boot\n");
+		/* clear MCU_RST_SRC register before reset */
+		writel(0xFFFFFFFF, CTRLMMR_MCU_RST_SRC);
 		do_reset(NULL, 0, 0, NULL);
 	}
 #endif

---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-am64x_sw_rst_fix-eb5436122780

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

