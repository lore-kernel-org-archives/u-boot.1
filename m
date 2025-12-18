Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A20D6E2BF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE3C838CE;
	Thu, 18 Dec 2025 18:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mUoCD9YG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C418A80050; Thu, 18 Dec 2025 18:27:27 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD68B82BF2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmV75yvyaOByh0s4/eNCxIVFSL2SIiRKb+GftYkLitlT3bN4C0GbGbFuhkEwjVvAm8wKliprMhWNwb2LhMxNjYkApm3dkb98F+bymbbf5T8P6wGZW2M59g1u/iGatVpAlju7+ViVTagP1NPvyBKz7gpkP/IUT17sJG24+OOWRLChwH0VNP9SvUx6jL/+Jr/hYGtfoyTugJTjL7USVd+QffvaTQjlLIaU4NfChIkZbjAujrPXCyfkUHEOPVpiqI6gmKVKxvacxsVWJFtOXTi5irJ9R27nipPu0z6Jn/n8ubEtQafVqwHtORZ579aycc63K3c5BkpL2Ryg9bHn/ZNimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txb4qt47PHDCIcpGPiby5h5ZtPI9y/j3hiOeDWupVsg=;
 b=iWSN59ODcXhwhaEqtsr3v9Px8nPUGp9gTFyhYDQiFDIvfk5Sko9N+KRIbAZZCjaprjZc+LWv6+j2xm4KQSvfCl6xocbDgSgHHQeFPy0C+Vt3NOtBiK6EkHbIoCmEU0AOCbeoIqMm/PALYz6Wo+VUnBv27hl1t73AY+QtmLcBdHyXeioqI0gze1TxkkrIEjMz0PfszLCmnf20RWjSbFXME6GrmkOZY9CEstxXLPn7WnWggIqNahY7lb2oFel60zKDx9UvTAWy8fkGVlVdW8BuAm8Aj2F7MBGmGtoUs+RDXCibREEO36r4GsJY+3F7PFeeXgkT3DfSsMt3x+ZafV1DIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txb4qt47PHDCIcpGPiby5h5ZtPI9y/j3hiOeDWupVsg=;
 b=mUoCD9YG4LkCSKpZaRXmU2T+m4wgvWTmyP9wBQJB0Jt7DXvYzvqJUMsvcakb9Uy0z3E7jQSb+lQYqZOZN2l1Q2GbliGvpqrkUoqd7/UVHjPGAWqzJMpSA9amWbXW7Wv/8TdEYmKlVeiUcsQw3AbEVSvJj75uKaCQvAvcEC0Ji4AA9vHi/Njfyy+QH5fOZ+3+l2yE+Qoyo3JfzWTLXpJf5RRbJ7RgYk5/TDUnsLOKYtdd+ogE/zFX+cdUNkqFSQKnIXhT9bfemho1YpaTWsSB5lt0OmDQudRAM5PusASBVXyQZZwk25ckdLVbeRvLt0SMzCFZlN8cgA449Uev+tiuYA==
Received: from AS4PR09CA0023.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::13)
 by AS2PR10MB7045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 17:27:21 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::f2) by AS4PR09CA0023.outlook.office365.com
 (2603:10a6:20b:5d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 17:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:27:21 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:52 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 18:27:02 +0100
Subject: [PATCH v5 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v5-2-9c7e2466b797@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|AS2PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ffec56-342d-4a95-f331-08de3e5ab369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJqVWlrV0NHVmZ6YkFmbC85SER0Mjg4K0ZjTWR6dU1XWk9HM1NPVHRwVmZU?=
 =?utf-8?B?WG1hZWkzVjBxbEVBMHY4WG9EanUxQyt5V1QxTzZ5bWVYbG4vb2g2Y3c4UXZz?=
 =?utf-8?B?ZzMwQUN0QXRzVGhLZWpBc3BOYXd0blVUMjNpeWhGcjBvQTRKZjdndWtITzk5?=
 =?utf-8?B?K2U0VStDU3Y5dlEwK1lUVHovbEd6elRIam9Daks0Nk5YMTN1U2hEUGVHQnVm?=
 =?utf-8?B?ZVVZSVZEakV0aFB1cGJxaWhXdVBnUzhpM1VGeVZJSHZIa3hLbmlYTTlZRytC?=
 =?utf-8?B?QUp2TU95Zy9UR1dlUm13ZTVoR3pjWGRTaGZ4M2lWZUV5R053QW1WVmdXV3Ax?=
 =?utf-8?B?Nkxub2ZEY2hkQ1kwdDJick4xSkYzOThwWVN5WW8zMCtNdUMrWVNRQ2JUbEt4?=
 =?utf-8?B?bVBmQjE0ald3dGtwMmdzc2owOW1uaVhjMjMvZUpCZnoyVm1nZUVGS2cwMGhq?=
 =?utf-8?B?eUdCQ2k4cU5jRTBrTyt0S0U4TnByWnVKSFRvVFJkQzUwQzh4WHk0ZFZUdktK?=
 =?utf-8?B?eG1lMi95cjlzSDVRczRKNkpsck96OEpxbk5vVzluRlNaMTRLVTNQQ3Q4Kzk3?=
 =?utf-8?B?VXZkcW1ZNVFPTWlXMFpYVnc1cEgrSFlPUWc3NWhFY2VRMUlDOFpxVzJBTnQ3?=
 =?utf-8?B?SVdTeGZqR3VyRjZnSkdheElYaWhnL1lrc1NMZ0xzYm9WaXFMTlFDOWhTc1BI?=
 =?utf-8?B?YklpcWVUM2dZTG5ZcmxoZ3FRZG02TzY0bWhHVjYwcXBOUWUxVXNsQlNWbnhx?=
 =?utf-8?B?OFhudVJLWmdNYVlpbFFUamZIM2pVOWNBZytNWDVsNFU1aENIMEVXQ0dDVW5q?=
 =?utf-8?B?QzhRYVhud0x1b2F3aUxvWG9ZQURRSFhlN3l6T0FIalpxZlB4WWZXbkk1QmJV?=
 =?utf-8?B?MEFTMHBGZnJiRmJjd2FnWnRMQy9OR1ZPbjA4ZGhrcEhTUXhNbmdJanFnVjV1?=
 =?utf-8?B?UnpLNjBmUVdBWWVYL2hKeWZvUnF5Q2huQ3VwNmx4QUhyNUJRRDBJdnd6VFhW?=
 =?utf-8?B?Sm4wYlRpRW1MMHNpSmNvTENnOUowaFVtbHRabE9Xc3habS93VjVFY282ZGMw?=
 =?utf-8?B?VFU4dW9sMGhmampUSnIzdjRwQTBHLy8rdzRRd3ViWm1JRFovd0srL2wvOEVW?=
 =?utf-8?B?UEN3UG5JaTF2WTVnb2lLSC8xV3VhQk1mck5COU5meU4wZlBTbmx3SnpiQzFp?=
 =?utf-8?B?TjZjMzBGSFBJYVV3K0NrcVQzeGR6Mkg5Z0Eybkh0Q2R1VFhyUHNmWjNNcnRo?=
 =?utf-8?B?NmQwM1VpNXp0TytxRVJVd3RiK20yQTR4MnNUa2Rwa3FhWmdUWDJWUVBXc3Vt?=
 =?utf-8?B?SkUzM1AyVGpXVzRNb2FkL29XMjQvK28rTlU5N3cweW5ZaXBOdjA2VkcvU2Vk?=
 =?utf-8?B?QStWUXIwc0FBclBvWVVjREc4REQ4a21oYkJWREdYOEVuV3RXMlp6MTUyRzZ1?=
 =?utf-8?B?SGE3NlBaSUtjaHZKR2cyaGdVejlaaTdxWEhxTnBsYjMxNk5udjZ2d1NMMTNU?=
 =?utf-8?B?TkkrK2hUYTB4eW1zM2xVQmlvS3FPZmNlaExlNTB5NUZ6ejVtK0pwYTlUU0tV?=
 =?utf-8?B?eDVHTEhrYjF1enU2dlJLbmFpWmQwMkk3Tmo2T05JYVgvTk0xYkZkbE5KcUJq?=
 =?utf-8?B?UTlERktjMlFxQUxGb0xVZ085VXFFeDZrM0ZPeVd1bStTTFZ5Q2UvSEtyNzh5?=
 =?utf-8?B?RUU5K0Y2Q1VlSjU5OW1reTJYTlFwcmpqaGFoMGxMckx6MTd0cmxWa0dyd1RG?=
 =?utf-8?B?TzJ6Yi9jVFBLSllzSWphTkgzUW9FR1g1dHpqcGp3eE9oWmN6ZFhXcU9kZlIr?=
 =?utf-8?B?dHBZdGhDbHBaTHJXb1ZmRHFneHJVZ3JubEY2OUxnRTZDRVQzSllidHhjQTFK?=
 =?utf-8?B?NWorWENFcUNYbE9JQTB2MFd4eEhIcW0vbGZQMzZBZ2NjTTFja09wOGZxOEs0?=
 =?utf-8?B?Ny9XM3ZheEhoSDhIRkQvWlZPc2E1aUtvZHVyQzRBWitUdFdBUG9VOHNCR0lv?=
 =?utf-8?B?Z1dQT2RFNmlFWCtTWHRtUTVWakJvNzkxZURGU3hMMmVmNjNFcUxGYTBvUE1n?=
 =?utf-8?B?ZnNJenRvYks5WXdGWHpVUGs3RVM3MjF0TnVxZXlIZDVaMmFjemYwNmdHQ2d5?=
 =?utf-8?Q?i07I=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VPybI7rE5k2pEzqvcmWeJCE27geurJTwNAos7eX+KJqHlob8h7kGUu5mizGSIub41hNDRqUG7q3iJCBXLnSbdg1eKd92X9iUsgv1RE6VAtHCcw25AUYO46YvTiNezFHXyYypXAEH8OWs8CKrK9Gdin28kUbiS9lpDLY52hNH7SzJt6kvdoactYJN68R40GxwQgPd4zzF1dEW2Fi/taz2E1IIIaUb/VHpeBeqYBLNZrjsBXIci3IuxNHvER6S64knr8ECyLSVPKzmr1TX4zqSOe7jPT7eQ8SuMIw16M5toPyJn8aQ/7ONELAyKARdtx2hxQV07S2A647m2Ocz+rziaZ6jzNmFg1kvBBciAOlt1praTTdNnCUQkmcKkoHcA+th1hcN7HgTQFeY64mxSuTjIXaW6v/K09Cz9jD0A9gvKWWfmx1JUt68uBkbGSlbCJ5ymQaqjeQLAso2V91E3iHASup/4ReJ8G2lgFLjXdksE8UZyZdtA3prD+iPx+G3VrDFQYopruSstUBxgK+iOCv4+TJr2QVVHUO2SQxU1f63A/aFfMstNqNt5ZCAE+b5PlGjssRVe+eVU04qWdKFL8kspOaOtsmWuRUtIo9VhP35gKtUWIDulcbY3Fm8zluk1q69QHu8sV31s9s47dMQkZpYu0wNRT5sxvkUx6KReJC/qp/XZ0Ja9TNdyO96nOsB2aoo/GGNLhhMFGAiy4P9A5fw/g==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:27:21.0376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ffec56-342d-4a95-f331-08de3e5ab369
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7045
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

In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
retrieved.

SCMI request is performed either using scmi_clk_state_in_v1 or
scmi_clk_state_in_v2 struct depending of the unpredictable value of
priv->version which leads to error during SCMI clock enable.

Issue detected on STM32MP157C-DK2 board using the SCMI device tree
stm32mp157c-dk2-scmi.dts.

Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
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
 drivers/clk/clk_scmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f6132178205..a4fc4f8da89 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
+	struct scmi_clock_priv *priv;
 	struct scmi_clk_state_in_v1 in_v1 = {
 		.clock_id = clk_get_id(clk),
 		.attributes = enable,
@@ -156,6 +156,16 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					     in_v2, out);
 	int ret;
 
+	/*
+	 * In scmi_clk_probe(), in case of CLK_CCF is set, SCMI clock
+	 * version is set in dev's parent priv struct. Otherwise
+	 * SCMI clock version is set in dev priv struct.
+	 */
+	if (CONFIG_IS_ENABLED(CLK_CCF))
+		priv = dev_get_parent_priv(clk->dev);
+	else
+		priv = dev_get_priv(clk->dev);
+
 	ret = devm_scmi_process_msg(clk->dev,
 				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
 				    &msg_v1 : &msg_v2);

-- 
2.43.0

