Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AB606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w587qtOW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mGwSvSRL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF05606F8;
	Mon, 26 Oct 2026 08:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooieHM73eSdR; Mon, 26 Oct 2026 08:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 061A26061F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002450;
	b=BfMMDuDtUC/QhMui/TyqfpUS2t/5esNRYqjBMXeLL3wv80aOjyEGnxHsI4xQVsL2T4Xe
	 eXyZYoA1e6dEARp590QMkCHLALvNxszI3nSlt+LlVYxMgHUy6adJtZda9jDRXBMVqmYWj
	 ja2whBbb9e4kA6bq2/iQrv7hS3TbMXUfffh4CIT0HB7RRrgY3+SwNq+U7kYrRvUS6mq0G
	 6ywbSE8XGEMQsbVRdobbyMru4mGr8UuROy0KWipgxltltDPDpnyfk5H/kmRloEREv4rCw
	 vOVHDiCpDxE+rkxHDx71f9od5vgWlRjMML2dphEBaRhQtHMkKUl9PDbgwJFYvRGD1Qw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1h/mPriokI/cU+EX+MCofDJa36u21dCdwSrFsrqNFzU=;
	b=H0ogGy1pIyy1q1g55oRUdKIrwlzqNSL9M6G9HLOPZH/93kCSymkGwbtkjDVJK0hgZ/RR
	 C2CL+kXjsqcxudUVaHqPQI3YYR471UjSnNLBbO0u0IQXH+0g6l2YUjcPs2iAHxDYMf6sZ
	 yB6c16vvRIKJq1itQ0IZUUF2BFdnUpmrrZYtJZbo9V+jX7JbWKwg8C/PUm3XsNX5ED/Zs
	 9l7XgTvE/mDolpZtCF6jTA+zjSYY7JvwfdEvcepX42rBlksxrVi1CGhxLYaSnFWYJO+zX
	 iUsMjPP4nvLsRxyHK0C81rIAB9XpiS3MifazhthepxBD+yLfyq290PJpldo94cRmwoQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mGwSvSRL;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002450;
	bh=1h/mPriokI/cU+EX+MCofDJa36u21dCdwSrFsrqNFzU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w587qtOW4Jq5vxFbbqQ6GhftPAGyv7U7WeeE2SlkT+5rTlleaN1DQMranjHZVpCvf
	 wM+saz77IFtMdAh/XT7hjfRkjXxulfgUWvAZbbgIlIDzVn786YqZk5pGRVcwvTB48U
	 P0/e9z7yqZ8s+pi5t6I0z4H2C0Y2fTRG9lp1tZnEHrzq4NQf8/fq6BeOZ9Azsc5ZRf
	 3ZVtxqvg6R2MtwLWvbfzr/MA7vzy8YcEmmO8dkYDOAMIXlHm8GOJVfvhnCIngoMLBN
	 9CPy4rEdTKZGQcSnR8Hu43Jbq4Z9HSVAYlT5WXIWbZv7me6kEdhnWNwqi5jNnNFCOW
	 /ABk3j3MapQEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 061A26061F;
	Mon, 26 Oct 2026 08:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD0214D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEA2B6060C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d2dKtVHNmO7F for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E608A60604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002448;
 b=FvjjWkB5+Fya4F+HMakIviNUcZkXnPHgkbIKknkiR0UgxAQbLq4h70IaHJRhveWTYx+y
 7IWr2Llo6wtqWbrpX3EwcASg2s4+pI5ACd6hTMFdntAHV7FWdcY0HhH213JE7ioKW2ryM
 6I1MS70DN/NrQNxQEJ4w9dbNuKwBlIvxLtU4Xg7lOBNvWqZmWwx9DVLIH5HAJQUk3qMmu
 Vv8p8KMCynPEpBhhsF6EcXpWsHDhASKrYxxgmM45364ZNekr+76yDIY5tDVjDzxddwdOF
 pHGJIoGgIGi/PGQH70XghrTW0C8nezGd9yj48FlOR3+eHpCPhgqVCaQHL99NRyqkKSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002448;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1h/mPriokI/cU+EX+MCofDJa36u21dCdwSrFsrqNFzU=;
 b=fzas2m+OdyYwvKgnDiUn4o2Cy1ckMebZQjEJMn9JgHT9J170kPDUwnztOj+LpPjpoeBP
 h4GyIvPvGyFdrIEp4PhZQGw/QWqqKArFNs8yLQTR7nXo+AxbmVGOV4zD2+K3uqjfEiIt6
 hAbOFGi3JKnVm5qLVirxEAoNX4LjIzcF5MIwIKo/9Xeo3wbs7NAY8Gpe1WnHBya+4SohD
 xNXZ1EgwYQ3Yqpi9D7D/RMmkwIJEQrUfhGmtdARvYxnvYqUf+jxGUzxq1wttlYn7CPEpy
 +ohYspB0ueS1nA1ijXSic4At+2o7nn55tMNGOk/xN+EXHbmxvPoXLOTOJ9VlkYfOQ+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mGwSvSRL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mGwSvSRL
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E608A60604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMYAdBupSn2ojuegjSrINbbiT9WzNuMOJihZ2b1l0/hJZ+i87SfYGeSOrtUpb/u/Jg/NrR9oFeIbxqIKXaLHt9h7YHV9KO9ulo6l4hY8t34gzw1gxWmu/R134pMftO4DucUzi2uplfNNDoN/X3ywk2WIPU9mksd8J6ObOiDCHo/YWJtfX2wE0Aa2bhj7MAVWhLeCNHFscJ3lzHrc/0jLMTvVagsFFYPeyEtyo0oHEsUJE/mUjSGkJs9woDq/HvS9XH+Yh8gVcE2HEmXxsH7NNV/i4CsQAb7CsX4W1h5BBYpsQ6QysP7Awp+hV30jwwiWJw7EPfuADbW3RV1ni79umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h/mPriokI/cU+EX+MCofDJa36u21dCdwSrFsrqNFzU=;
 b=mF+49GjsAoj3okLHDTTcdJV+gFKTvrh2k+P8IxDVB0Snm/QGmkfingAj6YhBlgBIfQS561WKaIq/oln8v9NwHkcjwrnWgfNi1Gv4ilk7CEJ75yfKKWb8q2ZPOmZyiG/tW8ZrSOY825UmGVwu1oIUTMheDNbvbWdV3Zab09Os5tc1WHfDq0a04XD/2WFrDDcX34JeLyHsU69EJqnCbwKwF521vqyy7EBwQL+G1QMZn1zIDr7dJ9ZOJJxT202pQX22YA/sBQOuXovLXCQnfz0d6KM+XdZU4Xd1yw3zxgXT37qyGQ5j4mYbaiGzgh5zgG2ryZcz6T/WlwVjXwke2rJCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h/mPriokI/cU+EX+MCofDJa36u21dCdwSrFsrqNFzU=;
 b=mGwSvSRLBnE+bxhR4jb0LvOHYVQw+JKDQD8ZWGFdGOQH+ddYXHnARTFdhdXk+DGLDHzZQRmAHvOtKntPwcUnM1ndXAHHMGb2Qri2+fkGD9TGoNqRBGfAqN5u+k4fXzgVO0VqDoI/WipoPoTzfxWOP5KDMrij8l512XLrte83P30=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 08:14:02 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:303:85:cafe::49) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:14:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:00 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:13:59 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Leo Liang <leo.liang@sifive.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sandeep Gundlupet Raju
 <sandeep.gundlupet-raju@amd.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 00/11] xilinx: mbv: Various updates
Date: Mon, 26 Oct 2026 09:13:41 +0100
Message-ID: <cover.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qc+0KRUtVK6mUt2DHO4NdRIVPxFqj+sA3wGg6fCMDMs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd595rrbh76pFYjWotM892WeOFMT1LPa+YNVcrfozVq
 EpNd/rQUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABMpaGVk+O646euFd/3Vgknn
 VC+7uyaYxNa8fDH/TAtb+L60LntNG4a/clN7dZUmPXWqOb6H46rhWe2v8d8Pfa0MTIvzfNS38Ug
 tLwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c87f3f-7b0b-4181-8a53-08df33391798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|56012099006|11063799006|261022115727099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: TxQCe5IEeQEOTIgJ0REh7/YRSqtXIAnifEBOyy4se+kti1SKSrn9pmQ41HXyudxQfObZeKHMJMEX4NIVmkTgc1r9pCzdBjKfImWyMySnqqvtjiE0pntoDQzcPORq8SG/dkkV8Pj6rWK3wpj+PKXjRwZ2VRgYqoIgqBkWgZfbFGLIGTm8fZ83tS2jdnszGP4zqkmSfzICJ46sWdvsygJIfcmjKcznpfMV2CwLCcFJRdBdofBDmC7AD5SsVa7RvEk3U/5wqi52dGWUSK5RFs6JS9OwNalLEHMGHPWJ9TJnyGKFqZR1Rta04QJu40C6a028zTI3jYM1hwKeoGlnwub2aaqpHH+uYLbi+iZMuClgz3Z5fl9Z6bUJrMS3sLpKOPhz/a7/dvtbU8PSbVFfjb4ScCyw3BDbXXrKsSgqXoz2IrOp6aHPDwHw/ZLK4wdgd/ZV2WTtnFcYAQ69qBPnHO5d1oxcDQr6T+KmvIndrXAy04BHjgr+fmVJm+M2L0HOCQxiusdTA+mThs1btg4hnNn9t2/nK4geDUxQGZhKjunf9tOj0YZjo8jDKP5LMG4lf+fU0cXUAVFRFovCTMmmf7AnTJjkb4Xwr1oCyf1D7puyxOL0sEFXl8gKIXi9HLM4Xdvwro/HyxomzQ6VKZozQRlziyKrwG/6mvmhCcMTn8BUlLEaUWTL2x90oY/j3KIfoOh5Xd6PfZFJlgGfH2/Orm4+cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261022115727099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I57N7OuZjYv6s9FD+dHxsHNaHjyhpleJXuhYq9SsFOl1U7xjiUgpFMCvd9ByiJPB4VKukxLsnvG2abyPDPj8jjh/LGF6EXcBgabjwxvcxuJj0jE311/ISqhWjyFkkJEMhxiswzNPJtz20RjVEm5xuVu1c8XZp2UUVzqx1gjV+rIPSui6kAOkg9mpKeuclpJqdN8TeG+HI5k5nOoIf9axxYMUxadA0Ra0NhvAucJbVi3grCR5kLNQ8tN8PlZVQ9RAbEIwLrSDiJEHWQcgCdBfYEzK/yCOWjgZ6i+yJgajA1Y4P+RexrvjJgu4J2mMkkw9XFqfOK6T13geg+3SO2A35aQPQwPCfO/Nbqd5v4Yv8OdpBccJ0E+KU//5fky/tNzDkORq19Q9VknVjpLJwoU7DwSRP7IF/ch0JMNtk5ft6gGsEthei6KX8tEn46V7IS1P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:01.1497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c87f3f-7b0b-4181-8a53-08df33391798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I am sending various changes which lands in downstream repository
based on tests which were done against the latest RTL.

Thanks,
Michal

Changes in v2:
- change subject and enable only ethernet because upstream QEMU has no
  riscv internal timer enabled

Michal Simek (5):
  riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
  xilinx: mbv: Enable GPIO driver and command
  xilinx: mbv: Enable CMD_EXCEPTION
  xilinx: mbv: Add support for using bigger boot images via bootm
  xilinx: mbv: Enable MTD command by default

Padmarao Begari (4):
  xilinx: mbv: Enable Ethernet support
  xilinx: mbv: Update stack, heap, and OpenSBI memory
  xilinx: mbv: Disable SPL raw image support
  xilinx: mbv: Add SPI-related board config

Sandeep Gundlupet Raju (2):
  riscv: dts: mbv: Update mem size to 2GB
  xilinx: mbv: Add sys prompt for mbv32 and mbv64

 arch/riscv/dts/xilinx-mbv64.dts      |  8 +++++---
 configs/xilinx_mbv32_defconfig       | 24 ++++++++++++++++++++----
 configs/xilinx_mbv32_smode_defconfig |  2 +-
 configs/xilinx_mbv64_defconfig       |  1 +
 configs/xilinx_mbv64_smode_defconfig |  2 +-
 configs/xilinx_mbv_spi.config        | 14 ++++++++++++++
 6 files changed, 42 insertions(+), 9 deletions(-)
 create mode 100644 configs/xilinx_mbv_spi.config

---
-- 
2.43.0

