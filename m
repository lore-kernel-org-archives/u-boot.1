Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16331C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B2D8493F;
	Mon, 20 Jul 2026 10:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mWbQ1ImY";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YONrDurH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3AA84A0A; Mon, 20 Jul 2026 10:02:10 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DBE8494B
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66K6TlXF1455226;
 Mon, 20 Jul 2026 03:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=NSCu1LQ0syhoDjaPxmY3kl8IUJbcXL0b4ZhdNuXQE
 eo=; b=mWbQ1ImY6PiqimDUgs8HQ6HJb880f7fKpzTg3TrXf9OOMp/B0leHDjzAb
 yzzkPBTv4J3SfnREBxQGclOk/GFnirH0Hxipz7+s4it+W1gfXiAGrCcP0msoaNaZ
 09gdBECHcDgHt2783X969CjL4DpxnM3mGcyXwBDoKiJBwfoOzFulO37GeR7W4Ju/
 CV3TEw3nTb4ejzEM1AgLFbQTd56RcsqrY/ItNZzXHuF38kc5xT1xjGIL4lXFfhGY
 WqsFcLvwEdSLwSLu7HxLAWq0LcE7vjeebsyYkLxi5ZPQTV4q/MMiyEwGEAowPaOz
 KStzhrhIbzdbrpOcLvoDt/RpINfNw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fgtgh4mjm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:02:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGHGyPcqYeVMjqRNfegGvn3DNegY7EO8y6Ej5RZl2Zks/tI9ZPUuvmDuDLx+lO/4wU5sSONT2ptLI/Qr+ohgIvcLV3NS0HLRj9oaxVKqgEDvmg/ILvbEhyaSQtGKr1kAOgmBAiDyNhxlJLJ/wsQU8F/UvlGbH2uKjvNFBSMEF+L7AKvOmdhdYmzJsIqMLM+hEizGN9UG92WNdwLQDnEFU0gzEKrljD/QWoYZ/yQlDa338NjI3qjqGpayephTqAz0xZtHhzmY6mRSSu7DFQVUCA+Lzuhg6+MCC8TWhZ4tla9ptyL+Nr7viAVtzmV9bCGNzGSmVQYE+wU1IwuG+Ps+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSCu1LQ0syhoDjaPxmY3kl8IUJbcXL0b4ZhdNuXQEeo=;
 b=N83EH+ubQHGaf1diqWtl+TOBLjuKNx5xMXj0Qev/RPvFHF4mfeK1uc4zl2Tv27I0nOqCgComVbXXvDs+R8mE68M9ccwxVAeHxhb6jhPkbpLKTKBGLAdzeNPDE5zNQ88z15qCZWaqZ/jlPBO3mNYcyS4iNZVq7gMWwaiYmloC45x33LbwhwuXxvy/S5XFKyBRA21KSrA824WgCcxiHi7DOJfdvPbFDFf5UPnQuE4HqgKBmR9RxplQ8DYkUgyLEtp4tyHhWkuu2TwuDA2QLvBpdGE96vKvHZE/lHpgmD/9Dg4ZBaHBSZqZwem1EQZtu56QpLTJqT2NeIT+MMEN2f3Dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSCu1LQ0syhoDjaPxmY3kl8IUJbcXL0b4ZhdNuXQEeo=;
 b=YONrDurHePhJE3nc8T6mAQbYGKe6nhhywz1NSB/TwQZi3IpqAvDauQSp9jL7NZCS9tsK3pkaihCTzh9pBI451YR0OU5JXtp/NYBZa4oxpfar/qlhh+97BL+Ztw1IUiU6Y3Y/FOsZ3WnyCnWhG5GLwBKG4tI8jfWQxataJXi2t1Q=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by LVTPR10MB997840.namprd10.prod.outlook.com (2603:10b6:408:3c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 08:02:01 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::7a) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 08:02:00 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:45 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:45 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFs2478591; Mon, 20 Jul 2026 03:01:42 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 7/7] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
Date: Mon, 20 Jul 2026 13:31:14 +0530
Message-ID: <20260720080114.775206-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|LVTPR10MB997840:EE_
X-MS-Office365-Filtering-Correlation-Id: 810010ac-b72d-453a-b410-08dee6352d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8VCzTJzcil8MrJVuKevAudvYM9cUjPyyehbt+4/dA5VFt7Gqy4Ep5XChLzVD/HaXLc6pd/Ic5iLADbz1gWjTD6C/WoWFg0imp97SsI3E9a12OMJA/c2MuZ50gKQobnchrYVFcddZZL/sFu0ZmIloJaXm4vkGh0a0DBZBCdy+5wZ+52ZpOKjoHNTSuKnX1OQ+/POdBIy4Tu/vj78LW2f9ZuO+zQzKJ5ULkjDwcUT86ZECsOVzxDxU01r8oy54yjpJ5/BbUPwG6SMnko3A+GGI3HthnOYNYwcem+WKbPsnH5Fos1KSn14bx2B+rbvaOp6eVIKkLVvHVBg+izwqUTmkEdWl95Dn4dh+QdhSBC8UruQ6ZF/75WuVChzv1bL5GdQoRQuhD5mEPHQbB+zZ2hTmnexCANUptIIa0YgCI5phJfo2k8+p85g2axf436jPlR0mcWlLoczQ1hXH/m2fNHujI6XxIChCC9Z9L6zBYir3W9Dz59bSekx8Prr60Kj8misl1b3VZgop6P0bwUNFP556/05f2PdGIlrDULWmjTZwFaJtpwDBgjS8VGKTfus5RUc1Zyt7AZA6JkVkboSjZSVJbxOEjktcimXRBuc39/7ywWm4vKhl1601DlrYobMWHt77FPqGjtsw+YIAfaW8w67b/5ZOQjpei3gaHHSizpjeVz71g9400ec2CVWI0OPfJpZb0zwG8MvEYkD623YJomVsJw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FBFMKCedZ69Gcud0Z12qwzSGSSMnYcwmG72unaH6dKsg7g1/n4qw4xf88JBmAJrOVm+5MGS1q+0T8+h9Axv15QzmAFS/vMHHGulG2BmRPl6TXJgbZ1vj2AXIfAYhlWcJ3X2o0Y6H47VeeCgTJMCzH6tV6NROSWH69n2biwoDulbOK4+JccrtkgfrwOez5vfrbfLsmlNmM7Zk4U5VwXyZFGxxcVGrufMevrijpKvuudad5JNp4VcIS8cdkSxmynCV3rFLnFf4kdvSHPSwMdNCju2urX25vdG+tAANDMDYhhBe1dyML1KNmbU/pZW6JaOgkrBuVxpeZ0WHbXAgyzQIKsLa5DSG86QwAkINo2qOQqeYFvESXY/49cRCXID7Aj6mXYGQwsXFyQz5WFMsmvTcDXTLdqRxIvHzzMV9V6gWhxhixsU15F4041Nj0Ia+9mC8
X-Exchange-RoutingPolicyChecked: ipL7vq/kjH3Vw3uJm14JT7FmwBvMercQAnSTxtzmq+5h7OvvoW3foeG+gVbZvmi3QQ6J550y3ri4p4MW8QYVVPb2BlTTgToVBXjHL/9l9q7QCRWeEseVVMOp/rekDa1bnA4gTsriBOZnX8SRJoYDgNX1DEsiAIB7ywVaAXqfo8fEYauaoQB9Vo+CXSCz5wuJ+gxaKbMAKbXEXW+ax7UhGeWofETfPXITRmEAds709dKfQsu1jDhfFi10KhiZkraMgfOTPwGYzttTw23Is9+3lULAzqWhEgPPdEsLiuXzQGEqEx/mj4IR5xjN8cMlI+bsPL90Vf3C0VBvsStGXzpq3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:02:00.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810010ac-b72d-453a-b410-08dee6352d75
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR10MB997840
X-Proofpoint-GUID: Q4gKWJrU9V2gxL5uVJoApxXf9HUrdI5R
X-Authority-Analysis: v=2.4 cv=LtiiDHdc c=1 sm=1 tr=0 ts=6a5dd5fc cx=c_pps
 a=RGFq7D/WLd/IouGP2/vkQQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=kd79XEjvzcn9TLE12NAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX4V/u/ec/GhBt
 4NEVu1WXo5C/uRV94RK/2ANrb0MrwRWRHlXu1abFUXcBcDfGpODKuCeXehLizoYEZMMPOaO8S22
 GopfdL6syfvoC5InKgxc73ssD4GdacWjToXHYIBBRgFXu9UDJ/JNtznFAH2l76h0iwQBBoNdhDa
 DIy6C4fvRETRpsc4OZxQER6JQ53T+4yNsuwJT58q0Vy4bYp9bZNhJ8SByrM01tBqicyVDwqD2B6
 sKfGQ+CWR5pmF/qEq1YPktiKIWbHMIQ9L1gMHL88mSVM49Guqo+ufacO5aP1Vb5uD/0tWwRNmJu
 TJmEo4jOHr4KjIiDtMsau/CaY62ryJXTA17hMsB+tRzSKC196AN+U8LoBanRFdgPekvEeqjLWlj
 YqAcd/RjhfHkd/Y4K13e98HWPpjLUzWtPOOfm++xWPX60z/XHC6KirqpJcmobSPy3cTaTftnCZ6
 fHe7rGQXs+2kcZhGfNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX1bFrS6FkhsFh
 mF2VeJpkrteIRk1SzJ3J3BwJCb9KoXCM8+uvVSB3/ZxBO8BBXGBikHsJaQvpu1ogo/DwZINozVJ
 e8ndng8WJ7qavGy4ghNG/Rb9wpfy1hg=
X-Proofpoint-ORIG-GUID: Q4gKWJrU9V2gxL5uVJoApxXf9HUrdI5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088
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

The tispl.bin fit image is packed with the HSM firmware image. Add
support to load and boot the HSM M4F core during R5 SPL stage using the
remoteprocessor framework.

Add IMAGE_ID_HSM enum and "hsm" OS type to detect HSM firmware in the
FIT image. Track the load address for all FIT images. Load HSM firmware
to remoteproc device 2 and start the core using the remoteprocessor
framework when CONFIG_REMOTEPROC_TI_K3_HSM_M4F is enabled.

Skip HSM firmware from R5 secure image authentication as TIFS will
authenticate it during the remoteproc load operation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Optimize if-else ladder for logging.
2. Call ti_secure_image_post_process() only once for HSM image (during
rproc load).
3. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-12-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-11-b-padhi@ti.com/

v3: Changelog:
1. Use remoteproc framework to boot HSM core.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-8-b-padhi@ti.com/

v2: Changelog:
1. Hang system boot if HSM firmware failed to boot.
2. __maybe_unused to decrease preprocessor usage.
3. Better error messages with return code.
4. Added Error case in if-elseif-else ladder.

Note:
#define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
But when patch gets applied in file, all of them have consistent
tabs.

Link to v1:
https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com

 arch/arm/mach-k3/r5/common.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index a0e1b791c82..fe4d22fe25f 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -28,6 +28,7 @@ enum {
 	IMAGE_ID_TIFSSTUB_HS,
 	IMAGE_ID_TIFSSTUB_FS,
 	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_ID_HSM,
 	IMAGE_AMT,
 };
 
@@ -40,6 +41,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tifsstub-hs",
 	"tifsstub-fs",
 	"tifsstub-gp",
+	"hsm",
 };
 #endif
 
@@ -158,6 +160,23 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 				     &loadaddr);
 	}
 
+	/*
+	 * It is assumed that remoteproc device 2 is the corresponding
+	 * Cortex-M4F HSM core. Make sure DT reflects the same.
+	 */
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
+		ret = rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
+				 fit_image_info[IMAGE_ID_HSM].image_len);
+		if (ret)
+			panic("Error while loading HSM firmware, ret = %d\n", ret);
+
+		ret = rproc_start(2);
+		if (ret)
+			panic("Error while starting HSM core\n");
+
+		printf("Successfully loaded and started HSM core\n");
+	}
+
 	/*
 	 * It is assumed that remoteproc device 1 is the corresponding
 	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
@@ -330,17 +349,19 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	int len;
 	int i;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", 0);
 
-	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
-	      addr, *p_size, os);
+	debug("%s: processing image: addr=%x, load=%x, size=%d, os=%s\n", __func__,
+	      addr, load_addr, *p_size, os);
 
 	for (i = 0; i < IMAGE_AMT; i++) {
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
+			fit_image_info[i].load = load_addr;
 			fit_image_info[i].image_len = *p_size;
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
@@ -369,7 +390,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	 * Only DM and the DTBs are being authenticated here,
 	 * rest will be authenticated when A72 cluster is up
 	 */
-	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
+	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE) && (i != IMAGE_ID_HSM)) {
 		ti_secure_image_check_binary(p_image, p_size);
 		ti_secure_image_post_process(p_image, p_size);
 	} else {
-- 
2.34.1

