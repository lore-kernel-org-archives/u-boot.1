Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BFCC5DF69
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B73AB40C9C;
	Fri, 14 Aug 2026 12:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CL7lh3NRWMYa; Fri, 14 Aug 2026 12:46:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCDF940C8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786711599;
	bh=sJDr+WvRcQM3+2DTtB4OAdnHH85sNF5Q+zOLHBvnc3A=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dGqi4u2sLTUi4VynRd5rxNunWweogqnQSO4wTQAiKpqdnwpOk2RZEsY8h25u7IOUt
	 mGMPzz9S61AsBTu5jVVPz8kn0P0XgdlqcT7VgD6bHO7gVn1XpbeaaPwYs7eMoAWIQh
	 MbWmJNVdYOIxguDBVnhrYpw/1Mkaw4nLjN3WDDnV5HiWqrgUv9QKs+5ZFzSaRNSCVv
	 QS44qaCruo5RGq1MKbE1m/9V4uIAffQWW1EqDqG1tIPdVCeI90LPRp8gF/S4XW0y97
	 +i/i9lx6TC3LGsU/xcPwt3wfxtRjTr8WReXzWLVHBtFRQY3tgq/7GIgjtXFq11zJr1
	 PZGkOyFwHcBhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCDF940C8F;
	Fri, 14 Aug 2026 12:46:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F23E1B8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 151DB80EC3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ntzb1_jfR67L for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 10:22:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 15AE380EBA
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15AE380EBA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Uw4tCLpT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dO0ZdMX0
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15AE380EBA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:38 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67E9Q0aE1367694;
 Fri, 14 Aug 2026 05:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=sJDr+WvRcQM3+2DTtB4OAdnHH85sNF5Q+zOLHBvnc
 3A=; b=Uw4tCLpT3CNuVYvpBBwbrUwLtyygWN598jZfryt58oij0SemKmCyObmgw
 AxkRaGb27bhf3TdAs0Klma3rDGfrikNn+fxAL/4peAgEiArekc/7+n3I00Bhe4IN
 NQCYFFl3Xu4zoMcKfjKQ6od9GhC2KJnC3wHpLXCcJXBNkTdIggrN+49HwO5BwHLz
 OC8Qtn8+kwdXOBmgxV/YpBuOjNqQP7zRALDlm0JC0t9vsDkm5CFBp4NwaDBfXBdw
 Y8OcrG+KCxABX3Tdog55MEBMVxTVOLiFh9fRATP3YWiIpgyRgujSSL93eKyuCoXF
 4HHJgFfvO+rtbnC91uVm0zJ9p2JAg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g1tryhv83-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 05:22:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9YGR2BHKZBZfUsRBZpAKhpwdPBRZvGm5Dpj+b+F4yr+rYZWdzmj5whh1m2tFlgINBG6gzvbpTiYFmfLtn7/Zpzl/9D074S5h0eEwzTY51baphzNuBRHPFd5N/nHrIHXfbft+MTlmWi9Y5oEErfE9EF4ZZCGLRMURK8SMFSRq7Hvs0qM0+ESNyqKGJvk4nmQ2uFzemuAW6NvJeOQEfDvP9Afd5P2ln0hRtNz0F7bbWSPOUUA9vy5mWUIkhIapbpp/UeDWPjnbI1AyeT5zUU/PHS3U638EZMhA3XHOnu7MunMrhr832C9cEuXdgHDwEa4xvWT5g60NLhrennByrEQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJDr+WvRcQM3+2DTtB4OAdnHH85sNF5Q+zOLHBvnc3A=;
 b=eSEeMQTBbsuZZ5moP8jX3Na4QLvT8o60qVskZTzAdACNdBsj11s8BuWI8WVuiZlHtjx+0UsrsF1Kl98T/Rrl2RNqCSO1ZRI4m6SBxn9Rj6ehV+8iG0qvJvTKIRq7Xdfl+tgX61NGjpJYIXJtGfidUTv+1bOtk1vVc2I5me6OXH8GWlkNdCc926Q21EqlWWzsg61LxFPFuiGXB1PyDan+fI1eBnDXR/rl7p5R6QYPQyNJ2WEUbB0e887cJC8q+LVRqBJaPMv4tuXm+WGv6DTOQy0wP87hY1DIALcKfVL5I3GcKfZefJR/upWCtFFwrb8iapWl+sdRXh6kdQaAxjE+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJDr+WvRcQM3+2DTtB4OAdnHH85sNF5Q+zOLHBvnc3A=;
 b=dO0ZdMX0vHdG41/S+wW4LTo4laNn72xU/YBIDd6Gml27LsE12l67Q6aGau5dlYw8lOOAV1a+9UEngnGs98VPutO4am/kAFkn8Ba9gQMNAsCkTocgJAQVhmLQDhrgvUUY+55gWChHSa2QWIhW8wc47rb0vfasMCs/OhbZ6BuMQxE=
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by CY8PR10MB6753.namprd10.prod.outlook.com (2603:10b6:930:94::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:22:34 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::8f) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 10:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:22:31 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:25 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:22:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 05:22:25 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EALueT2569179;
 Fri, 14 Aug 2026 05:22:23 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 3/3] doc: ti: document semi-falcon mode for J784S4 EVM
Date: Fri, 14 Aug 2026 15:51:53 +0530
Message-ID: <20260814102153.44487-4-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814102153.44487-1-g-praveen@ti.com>
References: <20260814102153.44487-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|CY8PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dccf0a-f368-4625-b624-08def9edf345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Ia0xjUkh+dSVsVTyOPDwoNuylkHXUCWrcYaKe9EvYVeZsisUZhPSHTNQqzq7D84bVFRqFyygfuvuoRTPdo4TNxIutuhiN1+bYcPcRdlHZLNpp2iJ+GcCfiIpBufWIQPmGbB+nzB7EFDgERcKqUuZTp/3wX7FOfneZ2g4fL/WnWUN40PtUkbxlkLoDdLD9AE1nCTVtfrqltA41/Y2e4sP3Xe+tYTVmyUDNVXYHMVeqT2wdO46iLp5Bl28d/bz0Lk7OsjaoZ0PooFb6h7SnyeZl/TUHqV/2/K2hWcfPeNQYiY3jKU1084F+MsNT4KI01dDQ3/XDuBnqzVQMmBnh+5pti/YVr7FeO3cKBggS08xWHcTQ023mgfvaYaoWWTzL/o5y/JYx8r7/UOyvlz+01SlGTREtzc2uBXdvpJt/DjGsEqB01VcW0e1//iUVdQn/efCmOETV8Iwqc0zbbvuUBGF7Scd8zDctbnXAZkQZHJeMAHkMMi/6QBQPjPkj+bY0L5t5K4Im5Qd6xvt+ZgQC++FuaBgKS3RbEtdBDshFL/AfL9Ma4f+mQYPWams18/OAyDdTbl0yhOpAh6NLQGsSNVvPXs8+FtvXsMFvSC5TvjEvuToorECHDMlpC55PSCbj8ExpnDgup1cneKJ7Pshc2YFpspd5Ca6xSucb5NSvkbCgkhX83sjZSaR6/LYESOiq7MpJW4kmFjy+3ehoQ0W0+1Nrw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RDtbA8ShvppvQxTw0HPF3Q5WgfpQsxTtu337G+/aMs++/luSAAiTO4KIUvglPpCYOrQVqpDGNJhZVvh4NVF6dgQR/cI3t8mGFYX/sXVyGu6PJe434r+vczJP6+xRBoWH7bjuH7p3/pZeco1qrR9m5Zs3SoeUb2D6To03WdX4HsdKOa+WekWnEWlet0cB66DVV2/+4xWF5gt3tpZFFcUwinqbxd3+dWBRfDZVmkbE/kfgOVyXIRDWLDRQ5mmDVnLV093f3qrJxdFEMiC7VS/7prfCjlSwEh2LaFOEmkdRcAKrCX4MOPW9uY2mB6ofj+Z1SvNgSsmBtu6jzX1DCRsakfz9xgXMI+SMn9A7DumskR1aeENAIqcIeXEQTAJnjrQ/1rDqxn7A0wWDsqr5bcLkvEzYykC4I8kNgAu89A+37wOfG8Wp+4kmbYZ4uxFj4Zno
X-Exchange-RoutingPolicyChecked: D8qfoidE/Xg7bttdCccS/UwnampY6EPK3+/Fl5ZXQXYJecvdc8/WQ/SD8hCqrY+aP0a1fQ3NzYodHfxsZKnDJj0IxQCPB40clfjq9yIGwlJAQ1Uts/HdqQDRdOWX/POLvJy2JsBaTqP5v5RRtySHcn7itZyk18D2bTOel+q7Qzg1wApxDZ29HYqVOnIp/fwZ+C/6HDuFwAby6fG0aw6juoZA8WWOW3Ap94Y4iztfnbzjoellAbGMEYnA3plXioTJa1C9fi+mvEXjWXv7qr/7KUkLSIF+F38rMejFMY9885J4wJ3ghh0Hj8E2dxUzDuq9wahWaetvhFcmugwuUKBOrg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:22:31.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dccf0a-f368-4625-b624-08def9edf345
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6753
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfXyJiL+TLIADo0
 CUuX+UPeVIpQvAnoz7xxS+ZcV/YK0xOSYuMkB/ogOeGkVvbxQrEe6xbsJOx9Lz3BqtqZ+8DvRQu
 2LmBtT+sRh9kfrgIe7IzucWs3jIjQRFXpiyqHxHfiBGogQBLxDW2+kQEhAmlHP/+llFCbRhzKOn
 AmkZS+4Cm1HXFNtRvLwA9Li2EfSGoScybWWSDD37q6sVU8W45zhhQqFjiuDK/GDB+G2qQezvndk
 hZUShmb94GqHSv3Z5TV6Je0hRuuOoZjhV3LpscDsw3yReSidxG2HrdpJiEozoh82WxdLrfjj7jJ
 ZNT9XJjCD2Ua4KJSjeId51J7FBb6BuGI24lXkJLLVErLb+iT7+6y88gYd45gtwmjO2++RDm9VGJ
 cRlaG1fSmeXhvfpZksD6rlf6NUbVcj88qZVTN+cVTlLWQtRxZuC2jQhcGB+rGVyHyZXSb5I1KsF
 NExCjRpAjogiTYYJqMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX38JKk+bKpsux
 l4xZBqBNqGQWwMipuhIFjL8jL2KcTW2BKeJ5B2GcByLI86wMqFPFLV5N7aiJhByGSEvf5ROcl/M
 ZPJyRiBhieh2q16I7zBJv3wxn1tsbrA=
X-Proofpoint-GUID: 4H546P1_Q9JnITsrzHmnxE_U2KhGvXba
X-Authority-Analysis: v=2.4 cv=H87rBeYi c=1 sm=1 tr=0 ts=6a7eec6d cx=c_pps
 a=J5CYyyHZZtesdUd/yj239g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=tlSJXLxGV86A4UsorCoA:9
X-Proofpoint-ORIG-GUID: 4H546P1_Q9JnITsrzHmnxE_U2KhGvXba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140078
X-Mailman-Approved-At: Fri, 14 Aug 2026 12:46:31 +0000
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

This patch adds user documentation for semi-falcon mode for J784S4
EVM. Boot flow and steps to build semi-falcon support and usage
have been documented.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab90..c0b3fc98eb6 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,149 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+Semi-Falcon Mode
+----------------
+
+Semi-Falcon Mode on J784S4 platforms is a hybrid boot approach that bypasses
+the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
+boot times compared to normal boot while maintaining U-Boot's flexibility for
+kernel loading and system configuration.
+
+**Key differences from Normal Boot:**
+
+* Skips A72 SPL execution
+* U-Boot binary included in tisemifalcon.bin alongside TFA, OP-TEE, and DM
+* U-Boot loads at CONFIG_TEXT_BASE=0x80080000(sA72 SPL earlier load location)
+
+Boot Flow
+^^^^^^^^^
+
+**Normal boot flow:**
+
+.. code-block::
+
+             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
+             |-------------+----------------------------+------------+---------|
+    R5 Core  |    SPL      |                            |            |         |
+    ---------|       \     |                            |            |         |
+    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
+
+**With semi-falcon mode:**
+
+.. code-block::
+
+             | tiboot3.bin |      tisemifalcon.bin       |  Image  |
+             |-------------+-----------------------------+---------|
+    R5 Core  |    SPL      |                             |         |
+    ---------|       \     |                             |         |
+    A72 Core |        ------> TFA -> OP-TEE -> DM -> U-Boot --> Kernel |
+
+Build Process
+^^^^^^^^^^^^^
+
+Enabling semi-falcon mode requires re-building U-Boot as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. U-Boot:
+""""""""""
+
+* **1.1 R5:**
+
+.. prompt:: bash $
+
+ # use the semi-falcon config fragment for K3 platforms
+ export UBOOT_SEMIFALCON_CFG_FRAGMENTR="k3_r5_semifalcon.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_SEMIFALCON_CFG_FRAGMENTR}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* **1.2 A72:**
+
+.. prompt:: bash $
+
+ # use the semi-falcon config fragment for A72
+ export UBOOT_SEMIFALCON_CFG_FRAGMENTA="k3_a72_semifalcon.config"
+ export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_SEMIFALCON_CFG_FRAGMENTA}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+.. note::
+
+    The ``tisemifalcon.bin`` file is automatically generated by binman during
+    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
+    the U-Boot binary with its device tree.
+
+Usage
+^^^^^
+
+Semi-Falcon Mode uses a specialized binary called ``tisemifalcon.bin`` which
+contains all necessary components to boot directly to U-Boot without loading
+the A72 SPL.
+
+**tisemifalcon.bin structure:**
+
+The tisemifalcon.bin is a FIT image containing:
+
+* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
+* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
+* **DM (Device Manager)** - loaded at 0x89000000
+* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
+* **DTB (Device Tree Blob)** - U-Boot device tree
+
+The R5 SPL requires both ``tiboot3.bin`` and ``tisemifalcon.bin`` to be present
+in the boot partition (first partition) of the MMC device. By default, the SD
+card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
+defaults to 1:2, specifying the second partition of the SD card.
+
+To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
+following diff:
+
+.. code-block:: diff
+
+    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
+    index 82b9f0741bb..73d59ac425c 100644
+    --- a/board/ti/j784s4/j784s4.env
+    +++ b/board/ti/j784s4/j784s4.env
+    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+     boot_targets=mmc1 mmc0 usb pxe dhcp
+     boot=mmc
+    -mmcdev=1
+    -bootpart=1:2
+    +mmcdev=0
+    +bootpart=0:2
+     bootdir=/boot
+     rd_spec=-
+
+**List of files required on SD/eMMC for Semi-Falcon Mode:**
+
+.. list-table::
+   :widths: 10 15 10 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tiboot3.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - R5 SPL binary
+
+   * - ``tisemifalcon.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - Combined binary with TFA, OP-TEE, DM, and U-Boot
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

