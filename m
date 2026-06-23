Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C360CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A25849EA;
	Tue, 23 Jun 2026 08:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fHQHRKJO";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vvQMmeKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DF3849E5; Tue, 23 Jun 2026 08:19:15 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2E0848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N6CRdH2788147;
 Tue, 23 Jun 2026 01:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=mscw1+lMOm30Y3OW558EWfWIfl5By+fEsX6twHcDb
 gY=; b=fHQHRKJOqi8ClX4/lP+S2rwF4++bt+iPaySMEOB0L+YCoOjEwIJ7YRY14
 CDRO/BqDLp2NR49SyB0F3YKy1jiB8rIZFY7RTxiTu9NTZ9HCYMWWccdwKPuhcLlD
 bWHKBrkGHa4OcyFARlIo/ioeFJtnrV5sCKaIUhiHObaCGBtTaP+Tq65Y9MfJilk6
 pc4QodQsXZhsOdfzYR+6XLPIsqJgr7/z6fpktE+eQWb4K9yfabmFAS6tb+DJ/nSA
 R6VLDx6iv+jzOQIucsG9NdzRaMu8CwvBSCXy3MdcVdsS2QIaipYaP9miS/mVKfgE
 ee6T1G6u3TpprWm/X0Y4vn3IC7sRA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ey42xwkm0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 01:19:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN5ShsYCfHdboifRN1cqyJZWkNiCVy8P9Gub/xScbKW7BMiYQtoImXkoxfyqT+fg4zMLSGULmFc8Z7kaJZ7MVxWzlmhdlzg0zedTiUB4HTiOSw1dBXdc3fzmBAMwB3djT4tta+FzbzOO+ivf8dfPEFStZkv7El6OPKJIOTEWZgQuvvSZvQG7j1+K8RfC6xIjYdklvGkDP0CfVQy2pC8LaWtJ+XV5uRAnfHHRh1pAHarZl2x40M5AiQN23PfgyKVS2XHIecfSavjMHmpXLJFfid5krTAtHgZXtK3FpmEXbkdM/NBqEm1DgWurTw8CGyWxyBCIKfmqT/CY3pCypSGTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mscw1+lMOm30Y3OW558EWfWIfl5By+fEsX6twHcDbgY=;
 b=N10eSLuBGCRyCBhqN7qdb+iHMGtBmVaY5eEPElxYOgNQRyVUwu7Unw6b/nndQsPbYVeLU9LAXofopRtjb86lZwkSKY9vb32rJebmB5QsrpYblFnYvwgazuzQjNqNPdtZgPSEOBYY6dN/LkLctSMA1pT8l7fzq1FGumD4D/45iMLyKx7XIyHrwP7ClExVXEnAjwEYge8Nbrqe8YWWWvW4ic64qYvoIRHTCQblEtaOfkbmkLyZWrOJtgCt4In7YUP6ANRNdGuLtoeRNepn/nHvGx2SbGhml2TGyBTdSS1yN+YdkbMM40PE7fUJwtC286qoRuzCKf/Ck8VNW5NMsffspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=arm.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mscw1+lMOm30Y3OW558EWfWIfl5By+fEsX6twHcDbgY=;
 b=vvQMmeKLddQ9Alc4Krb5AEOhcj8TUN5hF9/guB2Fy+XBpdLiFivHjxg63qTmwL43xOykVTZLpBA4KYLSeFFr6vL48TT0EyXPK0tepR3neo4+QBwyRQ/YNUJl1yxT/51NyxIgEMgn1IX/Pt7Trk70VoRZWk10gXFNpf5uGg1sB/M=
Received: from BLAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:335::26)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 06:19:01 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::6b) by BLAPR05CA0046.outlook.office365.com
 (2603:10b6:208:335::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 06:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 06:18:58 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:27 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 01:18:26 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N6IAZF2231492;
 Tue, 23 Jun 2026 01:18:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 4/4] arm: k3: drop redundant tifsstub runtime filter
From: Anshul Dalal <anshuld@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>, Jerome Forissier <jerome.forissier@arm.com>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>
In-Reply-To: <20260528132746.719699-5-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-5-aristo.chen@canonical.com>
Date: Tue, 23 Jun 2026 11:48:05 +0530
Message-ID: <178219548554.1317404.4115484534630285049.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782195486; l=644;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=AyqDGHBG5TVidkib1I/mkS3aEqMKQZACmBZ3+ROYhLk=;
 b=ZPYUHq/CvBTvisixUvmXWs5XMVDlIcLjEhcam8SQFLsNQNkaqG54N3AaEMtnL6vUMNBIRFOlY
 R0AvSJyyieTCZ90GlK+RG2080k51UXMf4n/0aVqt4A3acCg1si035xw
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 431a6d46-0c1e-4313-2a0b-08ded0ef4fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|22082099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 9wArSrQ8FXu4MBpVZgEXNToEHarVKe11g3Vgkqz161P9CSBrLhEjq65EyOyrKygHv00xzEMcp707yIS/urnANabfhd+npZMfOPmuKyyiQUrNXJYkYzJmvuM0RyLjJz5rZmSQVACKM2l89cAUO+WkhwNNvCnc2LfnpUqDhgqwwGfTrMGVu4vg+SwREEva+MIriGtZSFEdAEYjheJzemkLW2hPG9W5NUfmnOBvrIZLQf5wlfw/RZhuINXkxf3s1U8q9R+rJCH5tSkKzXV6XcLIGfkuHBXtTundKKVkyi0SAOSwO4YgFjf4eG7FAwy4qTWRpa96g+wKLh5RU4NHdP+1xsGJs9wUVBNAax+dthxYlVHkthHEQlBEjOcQ2DZQQQTfTJau6wsq1eK6uh8bo0qNk9a9Yf/zUi0sHvUACn4smE9hu2q05bo19CbHwLrhl6XoV08Yx/X6gxkrOMcBmqcAbfIF1SIA4G7rJeQv13bMKmfJ57HEHufuf8RhmD1PgY9sOP4kDQ2clA+PluZunSgpREziZbbnU33k0O5FYto7Jn86IkN39fJjvkN47qDM3J8O8qlbMmzRJxGaVrrYXSVK6XtHPnobK3iwtfXDqHnpIKSHjt5pnliQ3NJSPGHvwpOiaPZhQrwH5UNrCelxNi0rHNQoqTuzKyXm1PwlxAJK6uWAfiVL5Buk4z84SKSgOahuZubwPQJjBHioeHa6QnYIag==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sGi4Wv5FPOKhMPPS/IO/RYupe1tOr5xBHCOgjGKn1SI4+SfiFFBDg+OBK1wOMue/ly037+D7JiP4I+ZKLqTWKQBDoXeN47+HAmlia9eRWwtYvZjY8+hCTeJVPc2Zi6pVb4uDfiBFAcRInckJvfFpcBZGjyGVCWiY1jxo3HNbdpYwDGeDeGiazo4VsWXDcBXEyRZO/obSYCfhn67D1yQVm8QtSOxhIScU5ryGx2o9irQRFo14Mg8S7B93IhxrG2zZxKd10ke1H0ZxW8muDHRgAUAtvHAHhD6/pp2mcKqGCMBBkMbJXZ+xeBylDjucR+BHpiYNCZ1NdnU19UKHj85ADtZQQ63geLeq6yPmxohwg+wjIzQNE+kaPphG4PR/GYeSARKPTt7akCSc5keT4pcXIeNKCzzZfSfhzq4+se8b9vIr4t1xhVwpO0fFw8EeO3gk
X-Exchange-RoutingPolicyChecked: YDFk/riKdkHYL6DssDB76epC4iL1hXB6K0unEpis7qNf9CDzOinwBPm3rs92GfdIdnDyqUBm0NVSFZAD0NLCkCNm42nPnTyJwgWQS70Ek4Vgu5427FUSPa6aK1BB02goKiBY053yqVdK0qACb89xtXPZOsIVTrqJjNCCYpcO8XI67lHa4MXPkQxl1O3TJK2v3TuUW/TtkHv3Tq6M3j5H7QoAn3uNANa5sWPHu9oIJkmTJejfX2gQIkQKjjGgdsPbQxsit0g7AiTZK5azlsc6uF/0mCkk0svGTft4nY7RMmFw2fPSHlY8bY2j6UxKZYVnqlYu2cj8ue4GGFlZDULLsg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:18:58.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a6d46-0c1e-4313-2a0b-08ded0ef4fdd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX+mNza2wIsfDJ
 XO7Ur6yMUUS4fU9Y+W5FqLeovgKQyOsI5wkxoWxRruQyFfl3cT9hIuNbBZyvrAeD/llCH64Fmmi
 +KJn+BtgVvKLhwibUAW3JxDpDRpDr3Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfXzToBNoNtnp7k
 OW3C0f5dyVbWo40J8zsOIMFozDB/Tt1VCkiTNY8/2Cc45WT74zZH/3S3Xvd2dTWfVyD1VZfunCk
 wa2dOC4vvv7d0ahMvZl/jvAORdqq0hygSkhn4Jxci2LZNQ85XW1hvFd8C8PhGE02kpPWfze46Zd
 O2tFPdCCo2yjjaw5dTDBF8o/c0wGhe2K7f8vs1UyDrbqOSjRCd/DELLdBIRAcYNttKWV/nAReRR
 0W6zDjcq5Tlneqj4NQUozdDGfb8K35HydCqR6j6aHSCiKdzWsau4w5w9A+c3ay9MeK9tVplkYXq
 UH3Sfjto4oopoh6UlBbveDsmm5VWdGoU6T2vKnJvv9yMGjmktsvKvgcSAtqw2Ac5Ks6n4E025JG
 TYJ0KQF0sP81+pU0TNrNX1WebM+0NYX/zSxHrsIj6LAXnzcrWiR5tykTdxmKabMRUH7WtKPgTHm
 /D2MKi7tyZP7kc6mLdw==
X-Proofpoint-GUID: _Da-33NdumzCo4QjSw71DOXJ3BKoVAzh
X-Authority-Analysis: v=2.4 cv=INgyzAvG c=1 sm=1 tr=0 ts=6a3a2558 cx=c_pps
 a=NNTlVNVDZfSUkWkRvmJkNA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=DfNHnWVPAAAA:8 a=sozttTNsAAAA:8
 a=vGpJ2D0REXEXaXbbVxQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: _Da-33NdumzCo4QjSw71DOXJ3BKoVAzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230048
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

On Thu, 28 May 2026 13:27:13 +0000, Aristo Chen <aristo.chen@canonical.com> wrote:
> With all AM62x family boards (TI EVMs, phytec phycore, toradex
> verdin) now using per-security-state FIT configurations and selecting
> the right one via board_fit_config_name_match(), the runtime filter
> in board_fit_image_post_process() that zero'd out *p_size for the
> wrong tifsstub variant is no longer reached. Only one tifsstub
> variant is present in the selected FIT configuration, and it is
> always the correct one for the current silicon.
> 
> [...]

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
