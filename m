Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FD2CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 20:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AD9848D8;
	Tue, 16 Jun 2026 22:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VTaO2YdX";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hv64ASfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B73A84908; Tue, 16 Jun 2026 22:38:09 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FED848BF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 22:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65GIPPFI2816298;
 Tue, 16 Jun 2026 15:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=cG236PMiZc+Z30OCYeTlhRupr1RSj8ur+fX4UpTmY
 Jc=; b=VTaO2YdXJvSzAwHdncUGxwvOjATfWw/yVCtmCtzkijyG+Qx4483stT36O
 pZNZqFZg5A+0ehCpYGodgPpO4JAPsEsOE7XERigxdsTFfjmeb5IL2e4z8R0U3RQi
 2V72csPWYRioC98uYuVcEodKEun2bUvERkAdtQliRnmKkTRom9y2FVUCdqfAOXKV
 mrP4qXKzE0V0V/BSwO4m9QxYvKhRrHkTvQv0iicUeUWSR18MCe9ZHFvbfg3rvND3
 NtZIHkD5ZevBvXeMOMajd0/fzLN1+HZrdjNFz+WRybYAdN+SAH18sbhd6RpK+d3u
 fhGvsBl1zm6HEyyU4OwFEYVJ/tWtw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by m0384305.ppops.net (PPS) with ESMTPS id 4eu5e5bq9q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 15:38:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K76P2NyXlNeJVCKfH1qM6DPNWQ1UO/O9faqzQZQYCYK/7h3bkPyV3TLI0LTIUSK2AR4gUFd96VtUd1p5k1pkH/zzd7IN9BEkApytjh+Xr9C2Ss3ZX3ubSDYklIcQL2/twvUWk/EcTQHTGhkjGr86KnFWyXOWrm1rmDh534Gif7iHLtCb5TluLpjDjS8Y/YXbaRZWYI4M8F/czuxIbOOkLig3JZcGGLeRxfW/tpOsng2E9xgXeJV2bqrAqRAx5Nx35w+7gGYJcWoLI8KRwDVD3uxa2xci5YIc5DCT7bdLyqY4rYi0ctuB3zdj/ZYCdupNm26GS9uNbtLJDEevBWwKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG236PMiZc+Z30OCYeTlhRupr1RSj8ur+fX4UpTmYJc=;
 b=RAtRwU4Y3mpy4nC/XGfhWohUNKI8uufr6l/Wjl7dNgA+D/PdwhBM+UEl5HVLMUFI8y65WVCMphr3WgUVmMUHKm957aDMfmvyeBXcvNYwGtVNtsN5DCCIMlHBwgcL43TRgvBPrfuVDIVE1citihE4LxUxMHxY50REDiGlDSu+o3U7mCDIRu35Plo9Pa0d0H4XsgEvQ2hhxwxOIqQ1BF52/y0wXQKLNtDVTHCLcZFE/r8NYW9oL0BtQQo31a44BxPa3KdcAc7GdCUFJhHGzraPGYQJlmFbI65kVXIAXc5FuczavqvtU1cUS/fgZMQIrzvx1nemq5d9T+Utvzev0Elt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG236PMiZc+Z30OCYeTlhRupr1RSj8ur+fX4UpTmYJc=;
 b=hv64ASfcrxzj3GUncP4JJfxW0mhMvpPzk5HUMCdDoF7GXGgTULdJfLrZ1qUAZjLHi3EW/ndMfSLH5OUjg8N9rFg3C6m1kY5PZfpsTLLxMWjZBEpZtRaPchA4B7EepLQUovreHjvXU5Swd7/u0QhQR4/BIW82TxR242YA6zcS+BI=
Received: from BL1PR13CA0111.namprd13.prod.outlook.com (2603:10b6:208:2b9::26)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:37:59 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::18) by BL1PR13CA0111.outlook.office365.com
 (2603:10b6:208:2b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 20:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:37:56 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 15:37:55 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 15:37:54 -0500
Received: from DFLE204.ent.ti.com ([fe80::7070:5561:87ec:432d]) by
 DFLE204.ent.ti.com ([fe80::7070:5561:87ec:432d%11]) with mapi id
 15.02.2562.037; Tue, 16 Jun 2026 15:37:54 -0500
From: "Mahaveer, Vishal" <vishalm@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, "Brattlof, Bryan" <bb@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul <anshuld@ti.com>
Subject: RE: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
Thread-Topic: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
Thread-Index: AQHc9SLuHmPlRfX5q0ODpFuO58ewq7ZBbCCAgAAThYCAAIcfAP//rPnw
Date: Tue, 16 Jun 2026 20:37:54 +0000
Message-ID: <85355f8d895f494d9b958de8cf12c82f@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
 <20260605193829.395161-2-vishalm@ti.com>
 <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
 <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
 <e88d88b5-1671-4d47-b2f8-70993dcd943a@phytec.de>
In-Reply-To: <e88d88b5-1671-4d47-b2f8-70993dcd943a@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.247.75.170]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: f74ec27b-8972-48fe-b82c-08decbe7261e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|5023799004|4143699003|22082099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: eTglf+jbz8u13xvDVZSV/AsYbULV/67fxzAHVQKRs5tmxrsXBKZ1WgyVO5SYD97FaUImzC3ZqFhk22RN7lSl7MOIrfXDBckiKdpksLF9723AxNZTpoWbsOqnqcSdvXlcgZ2+eFMgYlRtCX3R4GD+rrkw64n53mzynWqe5MCUP5OhX4UfsdPEGgXO1UOhDTaFKk2zb/DhG4pbhpXOrokcacbKwuPQc9u6qkIN6WNLxIDxOvK/ougADMiy4xRxuTDmWq+qS6o8MsUX6Z4YoRIMLo623Kr0ni/7zME2shZV7i5tFUd1hEdOxmnzOfnMZ9JAtFRshHZt9EjEOKSpwY5p5IpMskafhV7R2/AorrmCMuO5AVdVEYZ70qwNMGKj7fJ29howLMoNjM+6mgGNbNScJwA6IdCZd1WrAy0IjcrNZ7mAni7ehkI0Q8xwAc0SqWOqTdBRiZ6XZ3Yai9YUpdPpipgfjqZqfuI4WXnr5MJ0gDYPWU0QFyJNEDemuHmsFh/N1faLT7Sxwe0DQ6f7lMkPjNn/XxR84HSgdU7BCorfBYCob9ebA7DmgO5bCSP2/maioxKtQRzEDwmSM6/KquYXSMcUNy12IjLerzCgKjE/a5zPLwFjrtPsYgJZUoFxF2PAYOyL6DlOErAwuoARsDsd13kJhEuZj4vWExh/GtmzOSFOIHrXHIgyjBCBCCBPLHY4NoK487AhwxLFiHq0Vq4QzydNBnEzSvDzkPIrnYeRyTE=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(5023799004)(4143699003)(22082099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t/+bfGxvtz6CvR+ps6/7Ep7Du26ha1NucQ0X5yAIgqSKPplY/NYeqoM33+KY6PMJ87DuT5nIN3Ny36MUoEGEWbQj35+otSFEev7H8hkKEp+zXv9Hv7Q38sguN4QNdO/ygJz+XNQZCJ/eY+lh9EPPBAzQsijNw76Pbp/4fhGxGyweww0UIvxl6+Nbb7y1uIDrRFVnIEwUEwk/2Dcwo6Tuo6qeH207nP/7DeQpfMA9hqpyMmqvQVzlr3zrrhTEAxai38h1GCwGTUDcq0G7g7IeLsebkWkxpJXegt15FMSprPhL0n1M1bptg1Pq+ArNZ9YPzEP6bYdI5inPShYfPQnqEtw2MimXWL1I0nE5crJOv94nPh6qMcSEj4J3xWvu3D5F+fnX7WDyUiaLk0EnKyIZx8WpI7OvSJ75Rqgi84l+zw4lzRKIXRN6IA/HyAbRgOkp
X-Exchange-RoutingPolicyChecked: fdirlKbJwpLr49tzlnLMwXEs5HuPcJPuRBb7T0VnypSK0JbndjMB6lrzi/Rg5WlRlpRozzO6hWbCa5a6le2U5Hw/qUvVv54GppCptCTEeTt0zagBRj2nqrqlHCHLVYQkZ9xwLYAuUIwwVFWlnsu1+gpSOdZyJzXJZmtYjufOtvDz5duG1gH8zY95ZfcaXXUCTBnoJfhCeKt+6wnMU3ew/zc+ZVSNgR1iDyZlrpq9afRbgLv1Y5ixSiXcNtBVC0rEczMMzyZqQvvQQSFdhqK+09KmGCdGg9e2NGxOhKhiAzLxlPTnEdI2ejSwW7PfWRhAKZmWEYxWaj+BpdGCzXYxTg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:37:56.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74ec27b-8972-48fe-b82c-08decbe7261e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIwOSBTYWx0ZWRfX6WXDRyPNEiHx
 tJf1OLDqkD2wZR4MdJvYoDduzZa2lBfOgumZE1j/9gXtW/Fy4yWWU5q4LYcoYAfG21Zs5AbzGEC
 dySyxWd9//UaXHJgZ+Ny56g64+HHKuA=
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a31b42a cx=c_pps
 a=+8K2uRBjRfMG8L7NFMG7mA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=Pwoh_uLrkz8A:10
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=FlY8dDV_VrbDKQQZkK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zfQqkezDhQ_25ZG220XmR9MeYruIyZPH
X-Proofpoint-ORIG-GUID: zfQqkezDhQ_25ZG220XmR9MeYruIyZPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIwOSBTYWx0ZWRfX006Eiy5yKqjR
 xJems5sf0WYvPOiyYRplmVKpBL+jKYOCO80C/0WWKP2j7g8JIOlx0aRmWQci8NWMphEFjNIkpCN
 Trp9+EAn83POXsmEWNJDlQmFai68bXN+ErL0nO7++m9smPt0LpiLIoiyio/JrJtgj2/xFjIQ4fw
 Nw3pfCYDxEfle+jyqrWPGrLuNrZi5tj+qUDgTGDlYBxN8mqtSOM2/oHk1kVmN3wVfBZD0r0no5t
 77Mm9XrkNNpJ1LlIy8zYfaTkwMuFeFonoU4XNUep305XY0X9iRhBjzEzGRIXDIxPtWEwf7rHFUe
 DnYl5tbdSdxXcf42++nZqtwK/QNLC+I/Ej0MxKlvrJd1oE3dYbgAe4Q+/jxy7fMIZJNqmNKXbt8
 cZ8tdS7t1ZoKw2rVpp4TTc6g5qQmo2US1m/rpF13bBwyYZKVevcSuRxzyTg3TWl5Fa2jt2Ywasd
 t2xomIsr0DhUiiOcHOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160209
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

PiANCj4gT24gNi8xNi8yNiAyOjI0IFBNLCBCcnlhbiBCcmF0dGxvZiB3cm90ZToNCj4gPiBPbiBK
dW5lIDE2LCAyMDI2IHRodXMgc2F5ZXRoIFdhZGltIEVnb3JvdjoNCj4gPj4gSGksDQo+ID4+DQo+
ID4+IE9uIDYvNS8yNiA5OjM4IFBNLCBWaXNoYWwgTWFoYXZlZXIgd3JvdGU6DQo+ID4+PiBUaGUg
dXBzdHJlYW0gZGV2aWNlIHRyZWUgY2hhbmdlZCB0aGUgc2VyaWFsIGFsaWFzIGZvciBNQUlOIFVB
UlQxDQo+ID4+PiBmcm9tDQo+ID4+DQo+ID4+IHVwc3RyZWFtIHdoZXJlPyBDYW4geW91IHBvaW50
IG1lIHRvIHRoZSByZWxhdGVkIGNoYW5nZT8NCj4gPj4NCj4gPg0KPiA+IEhtbSBhIHF1aWNrIHNj
YW4gdGhyb3VnaCB0aGUgaGlzdG9yeSBub3RoaW5nIHNlZW1zIHRvIGJlIHN0YW5kaW5nIG91dC4N
Cj4gPiBTZXJpYWwxIGxvb2tzIHRvIGhhdmUgYWx3YXlzIGJlZW4gd2hlcmUgRE1TQyBwdXQgaXRz
IHRyYWNlcy4gSSB3b25kZXINCj4gPiBpZiB0aGlzIHdhcyBldmVyIHdvcmtpbmcuDQo+IA0KPiBP
dXIgYm9hcmRzIGRvIG5vdCByZXNlcnZlIHRoZSBtYWluX3VhcnQxLiBCdXQgc28gZmFyIHdlIG5l
dmVyIG5vdGljZWQgYW55DQo+IHN0cmFuZ2UgYmVoYXZpb3Igb24gaXQuIE1heWJlIGJlY2F1c2Ug
bm8gdHJhY2luZyBpcyBlbmFibGVkIHBlciBkZWZhdWx0Pw0KPiBJIHdvbmRlciBpZiB3ZSBjYW4g
Y2hhbmdlIHRoZSB1YXJ0IERNU0MgaXMgdXNpbmc/DQoNClllcywgaXQgaXMgZGlzYWJsZWQgYnkg
ZGVmYXVsdC4gVHJhY2luZyBpcyBvbmx5IGVuYWJsZWQgZHVyaW5nIGRlYnVnLg0KDQpUaGUgVUFS
VCB1c2VkIGZvciBTWVNGVyB0cmFjaW5nIGlzIGZpeGVkLg0KQnV0LCB0aGVyZSBhcmUgb3RoZXIg
bWVhbnMgdG8gZ2V0IHRyYWNlcyBsaWtlIHRyYWNlIG1lbW9yeSBidWZmZXIgYW5kIElUTS4NCg0K
aHR0cHM6Ly9zb2Z0d2FyZS1kbC50aS5jb20vdGlzY2kvZXNkL2xhdGVzdC80X3RyYWNlL3RyYWNl
Lmh0bWwNCg0KPiANCj4gDQo+ID4NCj4gPiBJJ2xsIHRyeSB0byBzZWUgaWYgb2xkZXIgdmVyc2lv
bnMgd29ya2VkIGJ1dCBJJ20gdGhpbmtpbmcgd2UgbWF5IG5lZWQ6DQo+ID4NCj4gPiAgICBGaXhl
czogZDJlZGFiZmE4ZGU1ICgiYXJtOiBtYWNoLWszOiBhbTY0MjogTG9hZCBTWVNGVyBiaW5hcnkg
YW5kDQo+ID4gY29uZmlnIGZyb20gYm9vdCBtZWRpYSIpDQo+ID4NCj4gPiB+QnJ5YW4NCg0K
