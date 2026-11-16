Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523E606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=chYs3vSE;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=I3lMzqwE;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=pfJpSWUq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF36405E2;
	Mon, 16 Nov 2026 05:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id my_jgYKh3-qq; Mon, 16 Nov 2026 05:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6789740600
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808334;
	b=FpVM7EhAT1BGzlk2aX/dPcbTprPEghVP0I6zNWScb0OHewvpqepbP56SLlfogJI6cF8Q
	 MX6sdellBxjyQ7DJ1es+2fWebHVhZKROE5HwO3kJVPXy86dOE45sr3H1gEr5KKb8G1IIr
	 XhjvB1b9IPZEOsBfEgjKR0+6jUv3T/KvJH4TTyYg2ZU7TabAqHcLaGKQ3APExrBjnczLu
	 GzWlJl9nkasHqdxg87hgFAvbBKF527SvZahcHMepLWDA7lTm8yu6qyR3FV2uWDNt+9/Og
	 MPK7yV2RFQsweJirBCBiIQxU0EohVqHpg8XKUhOp69EUUEJ3b8kGWEJ44OS7tYsVO+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eYxdwy9YepPSRDYWJLPd+8FAJ4LlvO6lJNlFqEmgD74=;
	b=K2KgKEh+rTGSG0sUc/xGC9H9vOa0UVOgTEQMls7tpgaiVCtr0CF/bw/EQFxVbMk0DfNn
	 ew8CIxCxrXLgKShItLAnF/AVEeDQo5aGElVx0MlP/tm5/EqAY3p8G6CylTSetAhd7dOpm
	 Zf/rqD0KGYORGd5FjwxWUuWzy4jXEMS0FCOD2KxDjXKy+hDfwZJuRhghEVJhYpVhVf/zs
	 m2RisY309Vs2nuF5/pYwKuVKJJLUG78o+bah+uqDiWOZn4Yq2J1/5K9PtLrEAHqjZeWWk
	 05DJxLthM69cz/eLmKmuWfbeORcQu4jnGG/i+S1u7NbekLAvZBplN5j0AxP1bhmz/Bg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808334;
	bh=eYxdwy9YepPSRDYWJLPd+8FAJ4LlvO6lJNlFqEmgD74=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chYs3vSEJj+pj3mOeqLYG9NBT4BLKN7Hdx2duCCeHTqd5C/OOY4fYb7PZ+jFHhqi1
	 x3oQou+H/UR3kd8SKz/r7E1+ddyPmbaVn7FZthJQDF9j3Ut1cH6twBJpiVKNf7duU9
	 ccVkI6pZy1zjlpwBNU65fXvk95pvjRvPKWDrlqEz62ZREa75ouBZHA8lKKg0Y/HLqH
	 Y30Kh0M5YBLv0rQCVYIRhXsEVhKnAQScSTJGIsIQ5z/DGHfEFKMqV4zsudfQfELeKx
	 sJZSO+tc+dqSyXP6qHA04nmVoGlKC02hx93U4XTW0trAzrSVTF7CIQFeVfcecqrvkn
	 oA45uJ4h2hwbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6789740600;
	Mon, 16 Nov 2026 05:52:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3859828C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 365584006F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bct101QD9ahZ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A1A240012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=I3lMzqwE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=pfJpSWUq
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A1A240012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:09 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4Qsga711878; Sun, 15 Nov 2026 23:52:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=eYxdwy9YepPSRDYWJLPd+8FAJ4LlvO6lJNlFqEmgD
 74=; b=I3lMzqwEVaWNjntPRzZCJqD9MXpLc6Q43OuJ9aZInOm5FiHXk6MN/punH
 wKrE1unfm8bMvFdrFyt0otm5jUXps9w71Dv64ZK1CDvBIOx4u2OCj1+67e2YmYYq
 um9CsOiWqYup6tYseWcvawl/dIYkZgzpCVS0A3PTJiAxE4wWFEPclVSCivG4tFhB
 l3mDhdgG/FxwlltbH1SuUzTde0XwCZimCy2mueZAJuL2YAUkVWA+LNry3C7P70TK
 gf3AJuPo9GOwA2h2TAQ8hAnF5BemxemEFF9jQGE8S/Eu4aDmBiu2yqXF6W9iJ07h
 6SuWtk9V4kn2fg85MDMN8VfUKREXA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hys3u8tb0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:52:07 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYxdwy9YepPSRDYWJLPd+8FAJ4LlvO6lJNlFqEmgD74=;
 b=pfJpSWUqzWtXxxfCuQcVRZAQPHaolDY8ZPpqQn10IC1jNF6EI/itZDMC750urt1d2RytIChZ+/HhUf/IK8x63VMD0V3BMhqiOiqVNEg5O38zRThNeteAHqMVDt1vvsDBpRnBc2qw17U5aS4lHoO9lV9xtuOLB+V/UPMEZkOTMp8=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 16 Nov
 2026 05:51:04 +0000
Received: from MW1PEPF00018893.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::50) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 16
 Nov 2026 05:51:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00018893.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 05:51:03 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:40 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:40 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbo091724;
 Sun, 15 Nov 2026 23:50:38 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 3/7] pci: pcie_dw_ti: fetch reset-gpios from the
 device-tree and use it
Date: Mon, 16 Nov 2026 11:20:03 +0530
Message-ID: <20261116055029.3493551-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018893:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7df7ce-faee-4f94-1133-08df43a599dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|261022105027099003|56012099006|18002099003|261026121527099003|261102123227099003|22082099003|261021123027099003|261028144727099003|261009223027099003|10067099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 2IT9rvWst0Slqf5cVWx3jNvbQrsolMkuhW56gfONZ0nuSwarq3VMJCaekk1VlqyYNNGmqZxnLMMY+yK16sQTltY7HS/CDuXYHNtdtXDF5vN4jaF+EdyZvZUmvlrvCvb6NeEFWBMyqC20rQZ2RRD6X6S235YshGpy+b5Mrl5gRPyemA50LcnmWtmLH3LYSoZ1ETZWjmlvDu4gGMkiFOdnaOokl9kwCtZJZI2Otnn+i30poFTV4dT6O1+ShmTCUQnXAI6XDaJFiMZ68WytvNt3YX4BKs3Wxj3hyVHoLl+ibEQr57XOyRZsZbGf/7b25Itk9jt15SZqnY2GOuBrqoUNzmX2txrsC64QrzpSNz1Z/YBDwvlC3QPPBh1ZbBmjW9PPTCdv2PvRZwqjOPLwlcoRP4Lb04eS4vdSsXzw8V6k2uK5PLb8vwmyY7/+kyLyrINlmXm06w0gvsLd3lqUOEkHLguio8LMlamU2HzSyaYmhiJj3oEuTwhUcDU/3gE+0IpOXe5f4fwKz6rZmtDgr3+Y4ClO9XfMWRv6I46HKeIyAFfBjZF/0fQ4xxk8r8VF9rH9mwIiHM3aXpgcM2I3LmnLm/RRGSoirfALCkYnBRHa6bxhuxpQvuXMvRJJC0DFMIa7gidSpmzuhvVHoGRDPAlgpRdjNPbpz79sgJYEjIkCAJI2xHZgiA8ilziIOyUU6NvuMuEahVF9QbcX5r5hhCgf/Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(261022105027099003)(56012099006)(18002099003)(261026121527099003)(261102123227099003)(22082099003)(261021123027099003)(261028144727099003)(261009223027099003)(10067099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WCFo2aBEs3pv2o/Rp7rQfmZv9LIpn8ODz+kMirt3HrAoFGVLqrU6O6+ZA7tyyXcEsyPuss2lXcvKC54c8m5sDf7G/07qmUpsDgKF1jJ5dGVDX+42iwPz+2viZfpjmWOi8QZkEdn7GmjsdjZxUZIgJldW47SKrUC+FxbDXq9bOzf4XFrWlMHr04qUshFxhI3B+l8n7A2oEQgR0as9HdWAiZU5/o4qwsMTK3em2Rh7FGJzSQY4UqaiRdFDgDSnHRGVSmdcqcr9DjQ9g04J/r7a/6YitKubpT42UuCAdXAXLXjViKXe6FQdDAcX6HO2+C7PGrXvVzXH69eBYOaYYiCNhbGfb8o0rri9JCrNxTD/hS9o6KSdBjyDzzKhn+YVQTFtbXFia3ZR3U2kFEGv7ps4sEPmLk7Gue+QFJ9FdU4Yfg795GAKPsJh/H4d/WA9sEGT
X-Exchange-RoutingPolicyChecked: yz/RLsvuU0Veia7szFHC5bEkE06AZFUSFHjJyzsWO92v+AR8BIefc0p+6Phpg6WyNLI5oOk2qXl3qBtNiCL2Z//O5bcFcxGT+AQm64n1xhjfZejQ2P17AOrSfv8HewPObMbJxtYZ4hcav0iOOtC2vRzglZHcnNhfy3IWM3Vfqk/OL5PQHo8mI0c6UEPcfFFIll5x6CEM+LyPSbhOsmyj1tHgoO7LgHuNfMD7uQ8Lkq6CAfnnBYF755ekvBwVxfeSeNHJeha/OLQdjWAvSd8ZI5R5InE9ncdQdBiA4dgohqM0GKNzmNA3dpgEv5177X0NIYDalZmnU+GHyw++EkX4Xg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:51:03.8570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7df7ce-faee-4f94-1133-08df43a599dd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Authority-Analysis: v=2.4 cv=etZKXYpX c=1 sm=1 tr=0 ts=6afa9a07 cx=c_pps
 a=kfEGYAivpUbBRfgbjfv6iA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=KKAkSRfTAAAA:8 a=sozttTNsAAAA:8
 a=Z8kan6jJZGmnBQBbOTAA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX7j3BiXnYzGbT
 i7viEkB4RCOBMH3F3o7LNJL5hiG4LnQD8+v19WCXyMhAzwIBSU07O0cwv7asG7km5iIXJFD10yN
 mLcfcpFAXKsvWZBLXpWQhuqEyqtAIu9HzHT3RpnMOmSGRkCoQd7aOTrNuVIOwCK2YO3I5q512QM
 44WJ8zX+4SrmP98Nl7Va/exYktZvDrRjyJ3W9qnu4Xkjn3uQHMkJd+oJ/U8846ZjIeAc+WeHEGA
 FQSnNABBWnezIIQFdOU6wzYzYpF5rHlCxyWsFyKvG4MDj+i7F5GoAMqWtp+4mRCV3B3i+t9uK8Y
 13rUZJ5gtKBvFGzWZE2SmCCdU92yHiQD3hegzsqr48D7yAUSljll51DqbWGvhFFVD1NGJx0e7Hc
 mcRp4J4g789FaV3afskKDCRqUOGmkb74dW007Mrh6UxhfSDXW3L5taYW0SgaFg3epu0rO2Tse0b
 /xU0xpx+++e4oMDQHYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX+qgMvKVYcUYp
 /Cqf1In6ZpkawW/kA14Mpol6lfosgepUrej3zYztRJoqalB+3PlPvPuiVOEUV0JA5sbXOzxqscC
 xHjcDjWkXONUkg/xWpArwRbnmkOaQ5Y=
X-Proofpoint-ORIG-GUID: D6lT2NhQxsOZIGWRHuD6CD6Z33Ldwreo
X-Proofpoint-GUID: D6lT2NhQxsOZIGWRHuD6CD6Z33Ldwreo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 'reset-gpios' property specified in the device-tree corresponds to
the PCI PERST# signal that is used to reset a PCI Endpoint. Since the
on-board circuitry may not reset the PCI Endpoint, fetch the 'reset-gpios'
device-tree property and toggle the GPIO line corresponding to the PERST#
signal to enable the PCI Endpoint. In the absence of the 'reset-gpios'
property in the device-tree, existing behavior is retained rather than
returning an error.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/pcie_dw_ti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index fb39132f7c1..ac2045991c2 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	struct gpio_desc rst_gpio;
 	u32 num_lanes;
 };
 
@@ -252,6 +253,17 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 		return ret;
 	}
 
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &pci->rst_gpio,
+				   GPIOD_IS_OUT);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "failed to get reset-gpios\n");
+		return ret;
+	}
+
+	/* Keep the reset-line asserted until the PCI Controller is ready */
+	if (dm_gpio_is_valid(&pci->rst_gpio))
+		dm_gpio_set_value(&pci->rst_gpio, 0);
+
 	ret = generic_phy_get_by_name(dev,  "pcie-phy0", &phy0);
 	if (ret) {
 		dev_err(dev, "Unable to get phy0");
@@ -281,6 +293,15 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 
 	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
 
+	/*
+	 * The reset-gpio (PERST#) should be held deasserted for at-least 100 ms
+	 * before the link is brought up.
+	 */
+	if (dm_gpio_is_valid(&pci->rst_gpio)) {
+		dm_gpio_set_value(&pci->rst_gpio, 1);
+		mdelay(100);
+	}
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
-- 
2.56.0

