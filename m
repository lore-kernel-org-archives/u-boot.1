Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C876C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23AB8498B;
	Mon, 20 Jul 2026 10:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N1sN+phw";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KexOFcxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2979280517; Mon, 20 Jul 2026 10:02:07 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F37F8493F
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6UiaE1435639; Mon, 20 Jul 2026 03:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=oAGHyAULHdrTFpOo6uRbnTr0KktRIwhE1jTT9dPl7
 uQ=; b=N1sN+phwJa4iJ1VaV1eVpmfVC66vw93I/UzGA/8rD5fJOGusVBEaJJlTt
 EtHmI0hbfUFpDlPpnCMRM9W+psg1RL8XiqSBjaiM83DaR8xSrECRxixuQWiSdy0z
 yTgqx2XFkWumNVARulhzachue33AxXydCqPOAk+g+D1C35IkHG/PTHZ4kf0j8NCz
 nqlQnSt57ydfIHlXfLnPlejHhto1nKNUF76P+W1fxGjQ1lggSLSrVXH56mgxceu5
 goqf0yRCynE331VRrK338YM7IEds3irOIultLjLhX+dPvw4S5FOfQsB1oaa+ZnbH
 i3wH5VLldOEw5vbZHZAg6/wigQy2w==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fgwfrv84k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:02:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI3v2/6uptq2tUW6s32I+bY3aMvGi4B6/moizj4L89HVZDWFu7lgeG7iGuTCA+bXUeKM13jwsQmevesqul7clvF4gEWnvnyXNRu4l7PjaoqnwkRpnHkV7GhMsnJpmBvKLUMO2thIrhJhpNNKDshbi+z1KSlkhSTHTG/GmnOfUB2SjSSlvkFh0TKdykv+MZ5XlshKFawDo0WWkPPhDUvYMWeqkXLaF/gPgGLrGBWcg6XwiJ0QPyxUnqLtZo0awa3LXdl2TUgO39HE92GMpdQha9W67OzFkeIdRp1NneiZZNTRRcxc1PovuTFZfXWBycFezK1ShU83h9avdDBe5GF7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAGHyAULHdrTFpOo6uRbnTr0KktRIwhE1jTT9dPl7uQ=;
 b=c+A6sy1yAceuslvlVI9KANs0hm/Hpp6D9xrask7U9OfousiKbzyH9Jhwpajsua4Chaf0GxN/c/QZ1pSxr0yKqEjaQSBAoBQywCWt6fy0PL8bZb+VOfdOTHD5rY3IF/chYWwBKizpmUXZxMeEhG5jmAsjiNgX6zy5Szp4GRM7l56TNg0H7shblVOVMhtvGXjIN4JmjM0GGSIYFCwkZQ3rJ9eBtg8vRamhrs/9z6OoKMUxK0d7e9rwUe8iaYB2AYRh8WYvtZtFs9Zj5fVhOwv7XuPz4Xjy7fhilTbAK0dHTfuPImQJSqppCmhesNZ+72+byukVvLLw3BEwftGGepBOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAGHyAULHdrTFpOo6uRbnTr0KktRIwhE1jTT9dPl7uQ=;
 b=KexOFcxmNc6EN5JIoo+S3nrRu8BEST3YE9yZmInJx19E0P+iDeEKO/XxJ7vK7GCOM8/J88xo/N9ZR0JU5CIKAEenkd16176T9i4EuSwcu5IkAY/NrgbBcF1EaNlo/0O6IINpUMH1UDi2fvvet2/Kj1kUn9gM1K2V5WwZPlCZsiA=
Received: from DS1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::13) by
 DS4PPFBEF84CD53.namprd10.prod.outlook.com (2603:10b6:f:fc00::d46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:01:56 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:455:cafe::55) by DS1P220CA0007.outlook.office365.com
 (2603:10b6:8:455::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.17 via Frontend Transport; Mon,
 20 Jul 2026 08:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 08:01:55 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:34 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:34 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFp2478591; Mon, 20 Jul 2026 03:01:30 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 4/7] binman: openssl: Add boot and load extensions to x509
 cert
Date: Mon, 20 Jul 2026 13:31:11 +0530
Message-ID: <20260720080114.775206-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS4PPFBEF84CD53:EE_
X-MS-Office365-Filtering-Correlation-Id: ce575725-60c2-4b49-daf0-08dee6352acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|22082099003|17002099007|18002099003|3023799007|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: W2V5QyPeWAagyZfP38/GIVYcSYurp5RV9+1byxCsTzoTJGk/IiJ2vO6laSvSM+3FALB7TsaK8PiSFOSa4QKBZhvhp0xe2lVewQjPqsfoXRyiOAXJaQDEobs9KTb2W93jhBTVJZnWI1uxUpYEFWkKIXbLAR0k/fszeANxXP0H4suB6cZG/p0X8yLuplfk7xa9LOAUtr6N1tB3coBxZueq7OZkNeIEFaNQjb/4RHJzdXkxoQlSckPJeYEuYtZi48xjQalmDyDLJJ8+c1J4rWLC3rVi7H0TXKI9kLpCuIRXuY2LIjeHOqU19no/I0pC7oKtwKozWCt+PR3YmhWBXmKvNufz2H26zeqFOODfs6h506jvhv4IZr9l8I1EafCjzYo74oZAC/tIDFaxK9p/axq5JvhT3EJyKL9feb/Qr+kOJc93dvkRyfglSpcwgEnyAodxqZU5hVxbNQyYW5Ue1R/wEVF8DiXXl8CHIg0SBy0j9r4Iow7KFn+ejFkAZyZcno4YdkV6Memhu0CV2Ih4BVhC3Ka5a+el1WRb9J9B7y2rUXfDJ77hPKX7Y7gA1Y09K1RuWtxDxRvh69SAanMUNv9ORf+OPozmxrPUqwbVQWNsUdIqCqkohTBjEmzSb4vUJaQ/3HA7guw7FYSQXWh8BuIBVCSwKmDZOtLFybVSRp3l+/DHITxPQZc2RIs3KUATXiAXulEWdyRh4OxxlWLsGoEasA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(22082099003)(17002099007)(18002099003)(3023799007)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kg/s2uQJvZ/siS6NG4ZWRZg8G0cl/6D3yuHNIjzKZPl2pZcHWBv4rdz8QclupsKW+jfSCogvIKW3zM9wyzTjEJx+RdHgRayrO5knOIIodydK1mHfWJUyUddt2AX0u4KmFk6/MzJC1ZhTrDc5qH4eX28FcpjrMv1rvQpbejn+I7UfyqfBv1mbWDcmg43OAbxxf0VY2ORLdQu8HnKBzMmIkrlExC6Wu62Py4L5Il8BcvUO7Gofi5u5JG6qsnIWVX1FQjzxrGY25DqXpgts4fBVr4+FXJvcAJKJbczMiPWmaw7Ps5fRO7N5HZCbod1LLVAAjNlcs/hIR7JFCdPIjmwzT1FfQXBNJvdlPsXItDJs0L7HlrKEDcXAakG0Araa/KxYi/5icayvg8ZqRW6h1dxK4mvOa7keTXQBz5FblwQQOiBMfjbGyE3/TI11+aZLgRMK
X-Exchange-RoutingPolicyChecked: HVPOsVk2nT+px+Ktv4VbFil9n3Nr/7Hzpms0Ijb1RsilpHZaF8hQUNSCLOoGeIqFggQ4dpMyQiv4jJcECSJVbIzS4JoluIkBdsZ9gDm3d/RxlPTLOHBzyz6V62/OmGjap1sD6swSPTmU7o0CnXiH46VJgRjYucaT8PZbrYrGXJuBiiVtFoCAPh97UIe662uDuKEi23RSrFFKvIA9Iry7d2D4f6UK7Qn0pRW2U/Qm2y8k9Ygn1pEpCwvFfcHEQq7pEFVZWrXeAQURn6LijGI9xYb5ZTv7F+U+GbkKCnRpWr/aWkBWhLoxNM6+nYzOuaP8G931+cJJE6EQcS2eVcJI8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:01:55.7931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce575725-60c2-4b49-daf0-08dee6352acd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBEF84CD53
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX1hgYldifbu9W
 WINZQ2BYJznxyt3Yyru+UeMoxgSU15c/f2BA7R+zXvgJIu97OkilksRBfRK3SPiagdQdY6cv6Z3
 /3DvgOuNSxpUPuCd0hFUxDVbRf+JN74=
X-Proofpoint-ORIG-GUID: QbX6prwfArPVzDYAHpgqQFnl02AM69pc
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a5dd5f8 cx=c_pps
 a=8KrPlQlxEYnZEdstGaGrzw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=5iWBDtre0J39m9l84a4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX+YXadfZ/WHMD
 nfJETw9FiPW74GakyB3XV++UQncsj+qdOpSUhz5jhwoX8BX6nsOryx7FNsJZuF+0GJmfP8F1GBw
 B3Q05jWhbM1EsW/VQ5fcJ86pto38N91NqGTBeWw9Pr/t7rpQKI9T5LJUTN9XBA3PsKydXa64PFd
 NW8W4gPhpJxPbeLxgsKL1U7mN/u1zVcxCm4fDcStFvWqjjlyg5XCQWoH09zts1r/ZmzAUyevt+d
 2rPw1uDRFSfAiglxW47OwTwitGZLXrauXyvoEEoEm3GVcIB1OKb2iUllQki3HZyq4Mi0zX17Mi3
 FV8FzwWT03cmi1hR1g0mYZxbMPJ4siP2AnpWS5MddIkgK6vQwFIyEoEmWIQa03rHDec2yXSKJYw
 n8yuybDfRyieC7+3jC1WKDKrlcY23mRZc94WaVt0xq3hcvVk0/5UcRjj6wzSEimeQkCgep9L56Q
 USUBYXA44kNQU7pEmKg==
X-Proofpoint-GUID: QbX6prwfArPVzDYAHpgqQFnl02AM69pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088
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

The boot and load extensions in the x509 certificate are required for
requesting the secure entity (TIFS) to boot a core. These fields are
defined in the binman node for each core that must be booted by TIFS
and must be included when generating the signed certificate.

Add support to parse the boot and load extension properties from the
binman node and populate them into the certificate. If any of the
mandatory properties for an extension are missing, that respective
extension section is NOT added to the certificate.

Add test coverage for the boot and load extension functionality in
ti-secure certificates. The test reads the generated config file and
verifies the sysfw_boot_seq and sysfw_image_load sections contain the
expected values from the DTS. The negative test verifies that partially
specified boot/load extension properties trigger an error.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Log missing properties and raise exception rather than returning
silently.
2. Squash [PATCH v4 07/11] and [PATCH v4 08/11] into [PATCH v5 4/7]
3. Document properties in function docstring.
4. Update tests to check the load and boot sections contain the expected
values from test DTS. Add negative tests to check it raises an error
when some of the properties are missing.
5. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-8-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add support to sign HSM firmware here in U-Boot.

 tools/binman/btool/openssl.py                 | 49 ++++++++++++--
 tools/binman/etype/ti_secure.py               | 65 +++++++++++++++++++
 tools/binman/etype/x509_cert.py               |  4 +-
 tools/binman/ftest.py                         | 45 +++++++++++++
 .../test/vendor/ti_secure_boot_load_ext.dts   | 23 +++++++
 .../ti_secure_boot_load_ext_partial.dts       | 20 ++++++
 6 files changed, 201 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..39ea4a51356 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
         return self.run_cmd(*args)
 
     def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
-                  config_fname, req_dist_name_dict, firewall_cert_data):
+                  config_fname, req_dist_name_dict, firewall_cert_data,
+                  boot_ext_data, load_ext_data):
         """Create a certificate to be booted by system firmware
 
         Args:
@@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
                 extended certificate
               - certificate (str): Extended firewall certificate with
                 the information for the firewall configurations.
+            boot_ext_data (dict):
+              - proc_id (int): The processor ID of core being booted
+              - flags_set (int): The config flags to set for core being booted
+              - flags_clr (int): The config flags to clear for core being booted
+              - reset_vector (int): The location of reset vector for core being
+                booted
+            load_ext_data (dict):
+              - dest_addr (int): The address to which image has to be copied
+              - auth_type (int): Contains the host ID for core being booted and
+                how the image is to be copied
 
         Returns:
             str: Tool output
         """
         indata = tools.read_file(input_fname)
         hashval = hashlib.sha512(indata).hexdigest()
+
+        if boot_ext_data is not None:
+            boot_ext = f'''
+[ sysfw_boot_seq ]
+bootCore = INTEGER:{boot_ext_data['proc_id']}
+bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
+bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
+resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
+# Reserved for future use
+flagsValid = FORMAT:HEX,OCT:00000000
+rsvd1 = INTEGER:0x00
+rsvd2 = INTEGER:0x00
+rsvd3 = INTEGER:0x00
+'''
+        else:
+            boot_ext = ""
+
+        if load_ext_data is not None:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
+authInPlace = INTEGER:{load_ext_data['auth_type']}
+'''
+        else:
+            load_ext = f'''
+[ sysfw_image_load ]
+destAddr = FORMAT:HEX,OCT:00000000
+authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+'''
+
         with open(config_fname, 'w', encoding='utf-8') as outf:
             print(f'''[ req ]
 distinguished_name     = req_distinguished_name
@@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
 shaValue               = FORMAT:HEX,OCT:{hashval}
 imageSize              = INTEGER:{len(indata)}
 
-[ sysfw_image_load ]
-destAddr = FORMAT:HEX,OCT:00000000
-authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
+{boot_ext}
+
+{load_ext}
 
 [ firewall ]
 numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..9573fab088f 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -59,6 +59,33 @@ class Entry_ti_secure(Entry_x509_cert):
               ( 0x02: Move the authenticated binary back to the header )
             - Upper Byte - The Host ID of the core owning the firewall
 
+        - proc-id: (optional) The processor ID of the core being booted.
+          Used in TIFS Boot Extension to identify the target core.
+
+        - flags-set: (optional) Configuration flags to set for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - flags-clr: (optional) Configuration flags to clear for the core being
+          booted. Used in TIFS Boot Extension.
+
+        - reset-vector: (optional) The memory address where the core should
+          start execution after being released from reset. Used in TIFS Boot
+          Extension.
+
+        - dest-addr: (optional) The destination address to which the image
+          should be copied. Used in TIFS Load Extension.
+
+        - auth-type: (optional) This is an integer field that contains two pieces
+          of information used in TIFS Load Extension:
+
+            - Upper Byte - The Host ID of the core being booted
+            - Lower Byte - Load type (e.g., 0x00: Copy to dest-addr,
+              0x02: Authentication in place)
+
+        Note: The proc-id, flags-set, flags-clr, reset-vector, dest-addr, and
+        auth-type properties form a group. If any are present, all must be
+        specified together to configure loadable core boot parameters.
+
     Output files:
         - input.<unique_name> - input file passed to openssl
         - config.<unique_name> - input file generated for openssl (which is
@@ -116,6 +143,7 @@ class Entry_ti_secure(Entry_x509_cert):
         if auth_in_place:
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
+        self.ReadLoadableCoreNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
@@ -126,6 +154,43 @@ class Entry_ti_secure(Entry_x509_cert):
                 'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
+    def ReadLoadableCoreNode(self):
+        # Map DTS property names (with dashes) to Python dict keys (with underscores)
+        boot_ext_props = {
+            'proc-id': 'proc_id',
+            'flags-set': 'flags_set',
+            'flags-clr': 'flags_clr',
+            'reset-vector': 'reset_vector'
+        }
+        load_ext_props = {
+            'dest-addr': 'dest_addr',
+            'auth-type': 'auth_type'
+        }
+
+        self.boot_ext = self.ReadIntProps(boot_ext_props)
+        self.load_ext = self.ReadIntProps(load_ext_props)
+
+    def ReadIntProps(self, props_map):
+        props_dict = {}
+        missing_props = []
+
+        for dts_prop, dict_key in props_map.items():
+            val = fdt_util.GetInt(self._node, dts_prop)
+            if val is None:
+                missing_props.append(dts_prop)
+            else:
+                props_dict[dict_key] = val
+
+        # If all properties are missing, return None
+        if len(missing_props) == len(props_map):
+            return None
+
+        # If some but not all properties are present, raise an error
+        if len(missing_props) > 0:
+            self.Raise(f"Loadable core configuration incomplete. Missing properties: {','.join(missing_props)}")
+
+        return props_dict
+
     def ReadFirewallNode(self):
         self.firewall_cert_data['certificate'] = ""
         self.firewall_cert_data['num_firewalls'] = 0
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..b6028f6be84 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -102,7 +102,9 @@ class Entry_x509_cert(Entry_collection):
                 config_fname=config_fname,
                 sw_rev=self.sw_rev,
                 req_dist_name_dict=self.req_dist_name,
-                firewall_cert_data=self.firewall_cert_data)
+                firewall_cert_data=self.firewall_cert_data,
+                boot_ext_data=self.boot_ext,
+                load_ext_data=self.load_ext)
         elif type == 'rom':
             stdout = self.openssl.x509_cert_rom(
                 cert_fname=output_fname,
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..9d4f510c927 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7291,6 +7291,51 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureBootLoadExt(self):
+        """Test that an image with TI secured binary having boot & load extensions can be created"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data = self._DoReadFileDtb('vendor/ti_secure_boot_load_ext.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data), len(TI_UNSECURE_DATA))
+
+        # Verify that boot and load extensions are correctly written to config file
+        image = control.images['image']
+        entries = image.GetEntries()
+        ti_secure_entry = entries['ti-secure']
+        uniq = ti_secure_entry.GetUniqueName()
+        config_fname = tools.get_output_filename('config.%s' % uniq)
+
+        # Read the generated config file
+        with open(config_fname, 'r') as f:
+            config_data = f.read()
+
+        # Verify boot extension values from the DTS
+        self.assertIn('[ sysfw_boot_seq ]', config_data)
+        self.assertIn('bootCore = INTEGER:32', config_data)  # 0x20 = 32
+        self.assertIn('bootCoreOpts_set = INTEGER:1', config_data)  # 0x00000001 = 1
+        self.assertIn('bootCoreOpts_clr = INTEGER:2', config_data)  # 0x00000002 = 2
+        self.assertIn('resetVec = FORMAT:HEX,OCT:70000000', config_data)  # 0x70000000
+
+        # Verify load extension values from the DTS
+        self.assertIn('[ sysfw_image_load ]', config_data)
+        self.assertIn('destAddr = FORMAT:HEX,OCT:80000000', config_data)  # 0x80000000
+        self.assertIn('authInPlace = INTEGER:2', config_data)  # 0x02
+
+    def testPackTiSecureBootLoadExtPartial(self):
+        """Test that partially specified boot/load extension properties raise an error"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('vendor/ti_secure_boot_load_ext_partial.dts',
+                               entry_args=entry_args)
+        self.assertIn('Loadable core configuration incomplete', str(e.exception))
+        self.assertIn('Missing properties:', str(e.exception))
+
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
new file mode 100644
index 00000000000..226415f39ea
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			flags-clr = <0x00000002>;
+			reset-vector = <0x70000000>;
+			dest-addr = <0x80000000>;
+			auth-type = <0x02>;
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
new file mode 100644
index 00000000000..e90d27cb087
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc-id = <0x20>;
+			flags-set = <0x00000001>;
+			// Missing: flags-clr, reset-vector, dest-addr, auth-type
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
-- 
2.34.1

