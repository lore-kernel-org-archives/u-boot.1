Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A86606A31F
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zP36J4Ga;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gXERfjyi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4758260D8D;
	Fri, 27 Nov 2026 16:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nr7ci4d9cLLJ; Fri, 27 Nov 2026 16:57:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FFB660A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798651;
	b=Szrtvm8S1LY8wWgW8YI+j7nIVSaan8tGX4/zwxO1HfG96bykX4t4o9rff5kflSLoOZzc
	 C00vQKJqNS0yWGycHpNkGj2t2jQTXJVPAhjtNxbHpam+HwaF1TIsAVXiDw38iU2kR+0XW
	 mtGzbq/fyPPq+ZizzhW6hrfuyv+MSb6MlgQwBvAwfxDfUKhzWrQTlmCXzlal+Z/g7Aefh
	 L7ZI6IWEqDcIpK6EyfpTAKrviCychKFbWIMWb6zzX5iRaFZQOcovyjNKhO1qyijNhSbj9
	 RX373IBAIARn/+iea0LwRkBY9uSHWreLQFWLCbS1FzlnceQlXFza5/9Y0qfj7fFMVGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=FjHOZm1kn32+6Q/Y4JySJWIoyPOmN/Dzz6pbcYyp+kQ=;
	b=DumWH7zWWtLHhbLnW8npnWB8MJnD5cxDWLEruYJnqtZpyA08RWdICbAmul559BnmSkFt
	 /UTkQdhuVoSx4jW47WMRQ49xvUtHwNzsH9a4+umfOWnqaJ7sPMOMuYMLzpUe9GbucD8uM
	 nTYaUs1G+zLeg0dvnje7OyAlXWKBt4fSiXMl+q+Fuga0c6gTyG0vDSg+3oLkVl60iAHTW
	 HENa9IaMtPVug6Nq1pbsjzIzyBfDyKzbDSdHJ3B3iMlncEJoLCDsQgpLFajZz6E68tIXm
	 dwBoLo/xQXaIOVD2QafWjEt3umBywWR7OSxGA/79Fx+WfMwTaJdkkWtZHP0GwkVCeiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798651;
	bh=FjHOZm1kn32+6Q/Y4JySJWIoyPOmN/Dzz6pbcYyp+kQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zP36J4GaqAFLXcFOAmpizBPDR7CbiH8bUKL2X/AnJ9O/IxAoZ99JuWtcs/O3e9oa4
	 DgrDKST9UmcImOqmuc4e6xi0Idr8swlrfXI/fXpdDvXK0pG3s1AHuKiSHK4s3ynzB2
	 y8QYFCwTppL3j7aPmw8noDKraqxVX3L/Pp8wSzhI9gAKiTJV4bEyhq/eCRr5WLmrOG
	 CCtA47BkLpl+kavWh8YYBLBriQwa1RRTuWpVVLXPQ7Qm6yc5q6Pa9kaxm708Vm+4u9
	 5hjeO10roNXaoEwb22VRHR9FTs9LHkkOLjJAx6RvfOmk/bZiEJmNGf11BC4YAcVdLQ
	 YaCOkYGpf5T/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FFB660A54;
	Fri, 27 Nov 2026 16:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C21713D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3D86407E4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84KPiFgK-Ppp for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A956B405CE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=gXERfjyi
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A956B405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjHOZm1kn32+6Q/Y4JySJWIoyPOmN/Dzz6pbcYyp+kQ=;
 b=gXERfjyi7Kqe6CyCGCMRnuN0F/heuFxgfBWhBa/iKNUo6gYJX0bOic8KWaGkkK82cE99Fc3QJmbNlBOgFPGvkOCTb1PgoLR37IG0z8gEs4AhhNl7cUPxvZYqnL9x8QRTIRJAKPSzyAY+Q1bPWoVNJdjnCbYMzyZTkrVpNMSgrQbVr6lUunTQw+FWOH8xPGgKHzkIT33gX2VfbAOFSlRKhCRqqBhrayjYTmx8P2uGm8XCnaGFw7E672PG1QNoC47Axqfu8DMUaqKQdwvAe+0jD2VTZI7MtsiV+QfWklVHoN6wvuPDY69CIik7v47YWbNQYQ+YpmLU1Sb6Eicm6N56Mg==
Received: from AS4P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::8)
 by GV1PR10MB149732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 16:57:19 +0000
Received: from AMS1EPF0000009A.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::85) by AS4P195CA0001.outlook.office365.com
 (2603:10a6:20b:5e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 16:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000009A.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 16:57:17 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:58:24 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:57:17 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 17:57:14 +0100
Subject: [PATCH 1/3] mailbox: stm32-ipcc: support ipcc probe without clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32-ipcc-c-v1-1-b5e3503ec0cb@foss.st.com>
References: <20261127-upstream_stm32-ipcc-c-v1-0-b5e3503ec0cb@foss.st.com>
In-Reply-To: <20261127-upstream_stm32-ipcc-c-v1-0-b5e3503ec0cb@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Michel JAOUEN <michel.jaouen@st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009A:EE_|GV1PR10MB149732:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c7d16b-4ecc-46ce-4684-08df4ca77ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|261022105027099003|11063799006|261028144727099003|10067099003|261102123227099003|261021121427099003|56012099006|261021123027099003|261009223027099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wn8fxR396eJhEX3QZ3lys7WMsnNIjYyL74hOdBF1dPLU6pSsphS3eCUzp9VOgduTrtkRxlvI/urrFuUxPmhwjaB7CcEnyeujeK/ywutn+D7VXXvINVz0MaZac4/89+nq8hRDRNxg1JD7MOenPnB9lsZBXBXFpKb+u+jkSeYZ962Tn7+0EEdP5nivKzmD9V7Dgy4lvLtCIMAQp2DjXEH+SRI0kpq/AlwcyTTMzD+UQgAMP4l5WzPs2GeowbTA7epjc3NGtgAgszKjdK3yU5FS7gETt1xi5oJ9JZj4Fbm3qZZArOAPG2bCJKYPZUFWm/uFRwP1RAq8kOP+pEyxSPqKKqCSmyvaupjX+fFXzld4f8aTeKpikyExb/1Dk4nxPhQFU2Qzy3X08A/dRh8JTIblPfSIWqESYl0ZvIL7G9nkCxnL06FF4dycnaALniyQPdxS4w3IgT+61TCO69yVWY2h7BK/cb47I4Pq/x7NfkTPCWxOMg19kvG2VugNwyYr6abqYaHY1u3uE17IVnuoXI4eho2uqC9Wjl3vCe02p0HXK7utHvBU0xdafbVNnrfIjuay8b3g35mGETcHjV/UNbJhkRgxlBMTGmExLMuWsvO3dZE6otltzVslRvIganDE1Z+5/0nnhj43JtN7ElfoTCcP7VFLTSAxRH1//bdAutf+wmuG/Egf+ySF1uMUXQE8q2w72KaPSi25DQjAUShbtUX08Q==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(261022105027099003)(11063799006)(261028144727099003)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xdC5SOM/QvN6N3OCs7AfuBUvipQlO5YIjDv937+uE2tYe/5peDLmlhM1a8VByIP/c2C7B2m4CwPlu0qCh1UM2p9N4YdDPmUwsrRQ95We+wBOHhoCuIbo8u8b4sve8UhrpVhfTS8YBVzRdWXJasgfkXQk7VNxHriNW6FPPLJuk0YUoDboEgJkYH1sVukbmgYx2YGbpzSC89cUennn+YecAzRo/Zwph3Z4jQWNheT+j7qMLDoT54XdyigejJMkPmoBubO/MjRgV1W145cgKDi7M6Bu5PUDafYt32jt++xt1h/QzeA3DJ43Wju7EBkm+JtYAOWvF6X12/w1lvjoo5cCSXZ93iOFAE39e6siS5Ma5e0SM+OVkZBzLiG+t14px47VUWjToVH4FUeadA+umhTNDcl4W6x9Tlr4MUImMHZpsluS4Yz/FP5zbMDIwn5PX/sv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:57:17.7412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c7d16b-4ecc-46ce-4684-08df4ca77ea9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB149732
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michel JAOUEN <michel.jaouen@st.com>

Since ipcc is used for scmi clock service in m33td flavor,
add ipcc support without clock.

Signed-off-by: Michel JAOUEN <michel.jaouen@st.com>
---
 drivers/mailbox/stm32-ipcc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 49f7795b3cd..b38c4c393bb 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -102,7 +102,7 @@ static int stm32_ipcc_probe(struct udevice *dev)
 {
 	struct stm32_ipcc *ipcc = dev_get_priv(dev);
 	fdt_addr_t addr;
-	struct clk clk;
+	struct clk *clk;
 	int ret;
 
 	dev_dbg(dev, "\n");
@@ -126,14 +126,17 @@ static int stm32_ipcc_probe(struct udevice *dev)
 	}
 
 	ipcc->reg_proc = ipcc->reg_base + ipcc->proc_id * IPCC_PROC_OFFST;
-
-	ret = clk_get_by_index(dev, 0, &clk);
+	/*  Check if clocks is present, since clock is not present in m33td flavor */
+	clk = devm_clk_get_optional(dev, NULL);
+	ret = IS_ERR(clk);
 	if (ret)
 		return ret;
 
-	ret = clk_enable(&clk);
-	if (ret)
-		return ret;
+	if (clk) {
+		ret = clk_enable(clk);
+		if (ret)
+			return ret;
+	}
 
 	/* get channel number */
 	ipcc->n_chans = readl(ipcc->reg_base + IPCC_HWCFGR);

-- 
2.43.0

