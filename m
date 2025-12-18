Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C98D6E2BF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7232800AB;
	Thu, 18 Dec 2025 18:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="khjnmjHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F0980325; Thu, 18 Dec 2025 18:27:20 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FED80050
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOzjy3RJsI34Y7vJm1jfHWGnT7KtqP4mESavOMgl82tFLHPeqKncMWIrQdiYDKlioJn0H3DdWFR8KexEZsLXSxkDo9GdDoGg1fBd/xAIi+9wjopNG9aF963rvFGYIDKR57ya2ypLWW+P20+LMJR9AX1vCAgbdTOUYKX81a/vNAEK0IwpMeJ4bWiKnSap7Q2DmFlVHJGX8dnOAEPnak13iR+MGX46vFWerGNTPWr1ujwt+gBnDBuLTj3XeTWRWaWG3TWf5FkB08c1vQyx+qkYm/0XiUbcgXwJlZG7jHxHr7kcF5nJKFUUHt3YluN5uvy/pmdIJ8/Y3N/RdfmsmFT0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFDefOTNMveAOfJwQuRwlNdxomL8/nda4alEbAO/v64=;
 b=r1xvUvJkFvxs/XZf0adxbKACLSBkQY4FDS7g7eqXYvQY2CkRXBcnPxhaOveQX5DCalRxIyBHL6NtD8Ow1fsh05STolwfF3KO09rc+dqVLn1b2YgLaG/DgJ3Bn/2ToaPPRheqUpVBNjYDDM88QBgUlkgkHsP5sRTC6vz00uvpBV9V9+WaEizdQyNJRgD0Rbrfizcqe9DvfFIXMpIF360gDtWH1sKSVxX3JpqvQJ4SRm59Akt2cVIe3dGmJotI0ne3F9wMuQt87F2wfeSpj1T3vEM/JeWtibdZPsxI/UNSFHBBCQFen7ie2rZvtZKKV85kaEbA7Q7CoULaqDzAyOwo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFDefOTNMveAOfJwQuRwlNdxomL8/nda4alEbAO/v64=;
 b=khjnmjHegancImyDxys5i4zNYENDhKUKu4vi/aTHV34WJHP1C7t07DGlssi5W72BHdrWU4PgFMBV3EfGG7Cdk0ALmaJZStxdDjCzKrOMBYXAE+2+ReX6QwOUtD7TVZ4y4yw7Z5QpRw3PHSvf8cFi8mKQaxlEZFUuUYDEc9IwyQLp99PVE8KmmfY5VmirQysfxYL4ghLmKzrCRv1fCW7nvgOPuSiprjBZKmbcvPtYoCp162PChOQrCN5MzQn5/7ZbjJUW0svfGtT1syLCQZ6hyrRpLMqN9os5DKzExo6wpv+yiXCRYwC13PuQvPpCJj8moeKnIRA0TqBah7L7n71aHw==
Received: from DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) by VI0PR10MB8354.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:21b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 17:27:15 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::7b) by DUZPR01CA0217.outlook.office365.com
 (2603:10a6:10:4b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 17:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:27:15 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:56 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:07 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 18:27:03 +0100
Subject: [PATCH v5 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v5-3-9c7e2466b797@foss.st.com>
References: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
In-Reply-To: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|VI0PR10MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9687a899-401d-43d6-f753-08de3e5aafdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXdjcmgyRm51aU1LbWlUYmlBYXJMbnNVMWMrQUxlcjBOWG4xYVhLRksyZlZ5?=
 =?utf-8?B?bWxldkt5L0t0V1YrY2RhYm5lZENQS0JKQ2hMcXRERFF3aytHNjZ6dW9qWjY0?=
 =?utf-8?B?TXZ4OEZmZWE1S3JTZUlPQjN1cHR4YWtoa2thL3RIQkhmU2FlRzJHdnh0Qmsx?=
 =?utf-8?B?aTJkZ3VyTGdGQktkUkp2QlFuNXp1cEY3elNHOTZpS1l5UEZKU0lQcFFIdU0r?=
 =?utf-8?B?RzdXMFREbSs4WFJsbWlUbDd6LzN2ZWUwTVp4RmFqcDlabUl0WDdTNEZUQjVD?=
 =?utf-8?B?ZTY4Y2dnL1Q4VU9tTDlQZTF4WnZTUHExcFlCdDgzNHhEdzhJMjJvTDNYZTAr?=
 =?utf-8?B?eWFtMVdCa2IzRGFzM2hlQ3U4ZzZxNXBWaTMzTE9zeGVOQUJ2bVhBU1JmRUk1?=
 =?utf-8?B?a1VTWStwWUU5QmxWd0p0ZFhxYXJTcklydjJCYkk0dXRWVHlKZ0ZSRHBGMUNj?=
 =?utf-8?B?ZGtIYlpqQzgxOUMydEQ1c0ZmY3gzaWV4dGR1QVhuK1N5SjZYYTNxSVJvU0Vs?=
 =?utf-8?B?ekhwQlJnV3ZvQlpmNTRONERmSWd4VzVYeCtSRDByZXN4VGFGNkRwbGdHMENl?=
 =?utf-8?B?Wk9sS25OYVNoTk0zU1pmMTB4bUVaZHVLd3lpZllmRWhzaUlZSDNSZjVXbGlZ?=
 =?utf-8?B?THRwVERtb0pYWDNWRjVZVVJZYXdzODdZQ201a3lXR2IrM2pyUFBTM01iYUF1?=
 =?utf-8?B?dkpPS1didEExenpYR05OWlFoYkxYUEYyMkRIUTNucWhHeDF1SDFrTkp6RHY2?=
 =?utf-8?B?WC9rWm1MQ2wxb08rTk03aDV3R2p6WCt6TGNKV250ZlFZSnhZbTB5Y1NUOFQ5?=
 =?utf-8?B?Q1VFemVZKzZ5OWJLWTBQTGZKajYwTnNyNEp0eGw1SHFBSCt4NGkwbWwreDJw?=
 =?utf-8?B?QlpiMU9ZWnJHUkQ5TmxEb1ZPa25iZFluY1hhQ2ttUVRkMFZ1SXJlRnFaRVQy?=
 =?utf-8?B?bWxQUC9Yd2M4WWVzVEZYamNiMzM4Qm0zS1lWanc5eGFVWXFkaEs2dTJ2eXVj?=
 =?utf-8?B?M1pRYVBhWUlOdDAxYWszSk8vQytwdFd2S1Z5TWppTFQ3VUlpN1puUncvZmNI?=
 =?utf-8?B?azlKNUlFdE9oTzg0eW01bjF5QXhtcFV4dkhsd0xxay90REtWUWtLQk9HRHEz?=
 =?utf-8?B?b1RldnBCeUY2UUFhU3ZmaGlQV0Q1enFYYXBMUSszZW92cHZ5QUxqcDZDK3pO?=
 =?utf-8?B?RDRDY1lpYzB2T0M3OE5BZmVoZnUxZHY3NTBGMk1NbmVHMmJCS0NsbHpKVHp0?=
 =?utf-8?B?RThST2tYMFFvUEo4M0hsaWh5dzhuSmlkTy8reDRtMzdTRVhuUExhRlhQbzJ0?=
 =?utf-8?B?WTBsSDdlemxNVC8wSVo5SUF4QVFLNS81b1h4TGp2Rk1XSWQ4SlJxcDVTaGNS?=
 =?utf-8?B?RGpDbnJ3WmF5RFBKS20rcGQ4Z0F2Q1dvdkhuSmRFb0J4R05BM1A5dzArUGJa?=
 =?utf-8?B?cjRWeHROMG1JUVJVZWJneitleVV6ZzlnL2tkb0JENmg0Q2dlUVIvTUFpM25C?=
 =?utf-8?B?T2VKS3NSU1kwU2xaVkFHT0dicmdQWC85Y2Y2VGZPUVI0R0YyQzFVYzFaTTRY?=
 =?utf-8?B?blpNbXhQRktrRUxXWk5FbktYaDdrenpRaG1LMEs0akpJTUJoek91cllFQXdw?=
 =?utf-8?B?ekUwTTU3bW14SGxIMDZTV2s3azVYNmJaeGcreHlRVDVrWG5SYnZhWEZDM3JJ?=
 =?utf-8?B?ZHB2K1h2OHpIa2dUQWZNY3d4ZFU2c1J6dGpXQ1NZTndqbU9NdUFoYitnVFNO?=
 =?utf-8?B?R25tZ0o0OG00Nkd4RytRa0lGN1VPcWRzVWNSb3pURzNCVVpCS1MxUGk3KzRL?=
 =?utf-8?B?dm1naTNkbTlRTHVoYU9UUzRkM1FkbXFNd0prTHRaTWorekovTU1raVBEY1hM?=
 =?utf-8?B?REs0K3JYY0Y5VnRRTjVqTUtiWEtTM1ZUQnp0cE4raDl2cm84Nyt1eUNmS2pU?=
 =?utf-8?B?eGsrYk8xVlhCakVBNW9YcmxUeFlzWURtcDBISXRza2Vqc2JFcjRYYitJNkFz?=
 =?utf-8?B?S29pTFNzSzF4Z3psb3c1eERjZlNuUWU0WXZjZnlVeU1aZEdLZUcrb3l2VTB6?=
 =?utf-8?B?NGUvZkM1MlhoR2pPTzRFcjNpZTlYOHpNaVcyYlJyUmVaZndRdEtkNGpaSkJh?=
 =?utf-8?Q?4ebY=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HWs1iy8CeJTARojR7IIff52ZJ3Y5Uk13V/v0e6KQZ+FBdhhxnZpNZ+wi6fFdgKxakg59rtqRQ+FH02c3NF8S1/K5z5oZ44p5oTq+asv6zxqCht5aq0X4F9dCKbAm5FpwyyQnN6PC4EcHOxrTbIT+AI7gFXK0G0EQziPsJ2UzjSiZnHIaVA9JMunk8nGwfSjzfCsEeLnc1zf513LAgjmv4gfWPaMx5468Ee6Nb30P+IT0T1nz9LS4+4EToZ5o5NrK7MyxrZ8W4p3bmlmY6VSW6hx70oaEdRfETzp0/xssFexNdm22E+JjwHHaXigiaMzvcOoSdn9SMJLcaHYFM/Vi/P5VeoaR8KN7H7mSnKoYNgdBwP0N05nwNTleEKxmxzDSPUwNIC29DNK5Ho3Dt34V/7LNy97dFffpPrrm2k3rp119YsWdgj1ss5Ww5qOgY0nSPOO8xIZ+TZ0tbO3V2cVPXtLx0aacvRUFZ3s8UsXiaVAkk+OgH+qC+O7exOvl/1PyaAdx5BiwEKDFxUzSeRRstJhMAuUvUi3oqkWLNQjQIztnqvqHH4N7kwe3nwZH/LCCuBlMv0smQtr0bSGcxW0h8TlJUHKGXT94m+LFO+Mrepa9r1/QAw0zyHp7trih36QQ4xTiRjVvwrrSxUPKSW/d5faW7hFgB+C5/4itgfGYIoz9joC0/vGNPq9I1s77G8bwqw414xOypAun+3URj1tU7Q==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:27:15.0740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9687a899-401d-43d6-f753-08de3e5aafdf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8354
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

scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
Remove first call which is useless.

Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a4fc4f8da89..ee237ed6337 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -344,9 +344,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
-					    &priv->version);
-
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;

-- 
2.43.0

