Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA1DD65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7796A83B55;
	Wed, 17 Dec 2025 17:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MP2aJJkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0537F83BF4; Wed, 17 Dec 2025 17:45:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97C183B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcMH4nY84GS9o8gCvPH33HmNxglgexZVjX+tNz0rwz1/M/j61eQYb2vel0sJ+qDi8hF4mrQs4+CKsMFHJywRmJi366f2wXsaLKlmcf007ufQIz4BCgvIV7cqscitLoebwo7N7s7LDua+EwkARnvOfytg880NUZMYBiguIvxw3Z+yAotgFNiqEWva/qc5TtRe5iH/Urx49GBvwhW4Ef1sJ0sni8Xc7oskc1TToiHQcjbJpOCMYACZaLTbDVXwowLzAW6E1fgu66mvzawHtZNkFjdgHYM68+brtaT5KOypo8lmSvlecVYE6fdmeP+27MkqgyoVKDqidw8UkJx4dOW47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn8bkK6LxUrM4BHth/c+HKAfD5GxTytUEYM6SIHjmEY=;
 b=RauvA54ZLnXvpQIe+YFndGOYH1NGAA/jsqxI+2qH9P/cRy52qkIbAMF3Zt4EYwh6bO5tJ371xVxk9JX0Fy09cEuxuOwu1FN+GT2hh2EEpOBJ4bIeKAIs/znIsPtINO+97Rbwt8erPA0poF3gnCjyHfuRgnipDnlQxXRjQbOnqcRVXH7/eI2WaZqn89nqYu5WYEUAxdqD6KErEu4SJv4kqurb0xzNTQiEM2UQNILSIXG/lWKMvUSAEkRMJGnleouVSvF0GJJ+/NGHzokFFslLNU6DLLqalxm/xnWpoueI/jTJLqfA0Z9Unxiq5Xg1Kse9DPbo0frCfmSpxv0BQqJ7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn8bkK6LxUrM4BHth/c+HKAfD5GxTytUEYM6SIHjmEY=;
 b=MP2aJJkTEnO0oi4TZ0I2+KpYpz/NaO9YmUSNICHURqZsXJz6qBibj8l9/ae6wch77tiiju/72yOlhdb76SoPxUUMXD/q1VPr7gl7OyFRmPcaAe/JD7PMA6Y+UNonsywMXt9E9KoxjluuHHReSnyfa3J9svGXQiYW9NPw8z4T1wk08oYC7/2xv7Z8nBwmLToUNHoSaojxqBdwaytgofVE/X9vjxJXPLpDoYqvMzf0TEpgN9GCscLMdC3n6tyCIIsCnBTXf8BmXkhPNheSmxI1GUy2kgX+S6mx3YFbKJeNJl7h5hCONlIasjqmZHaQU7GRDgJblFF1zqUv+B/cOkzfWQ==
Received: from DU7P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::25)
 by VI1PR10MB7671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:45:35 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::8f) by DU7P250CA0012.outlook.office365.com
 (2603:10a6:10:54f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 16:45:34 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:46:18 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:45:33 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 17 Dec 2025 17:45:31 +0100
Subject: [PATCH v3 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-sqqs-v3-2-f3405fb2ad1f@foss.st.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
In-Reply-To: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|VI1PR10MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a792499-b62c-4875-4ffb-08de3d8bb2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWQxL2o5RUp1Y3R0Zk9obW9ZaWk4Qm9HTFFRS1JwWFl5NkUxdHpiN2Z5OUpT?=
 =?utf-8?B?NzlNTytvYlJNQWk1OHpVbG9LZVR6N25WYlhZYTZtL3d5Ym5GNVdDL1psdVpu?=
 =?utf-8?B?eWQrcFRPNWdINzQ3MTVGUFlZTWNLUGlVVlpoWWMxZTNFVkVoVWdPUTFOaVpS?=
 =?utf-8?B?b3I0NlhpbUxxY1B4SGVGaGJnTFlQRDBGSkNpdVlPRnozVng2RjlITkYzM3di?=
 =?utf-8?B?N1ZrK3N3TmdDbXFmZndxUXpZZzhnL1ZRdkM4Lzg0Q01IaGZaaFBtZjI3eldW?=
 =?utf-8?B?M0tVU0ZoK2YwWFBnQXgwN3R1N0RyMW1qM3VkNXBublBFdlI2Z2pkMUg3cDRI?=
 =?utf-8?B?Rk5VYmFDTUN5L2VFYXRveVNvWG5VczZMUjNzSEJCNCswS3Q2dnd2RVIzSzI5?=
 =?utf-8?B?RElvUEdrVUZmelRjVVFJdEVnSjlIMEJ5SnE3STN4OWhlU1ZUVHRoV2dhdDJy?=
 =?utf-8?B?L29OMU5sR0RWaWJwK1N3Lzlod3U4ZjIreUNUaXRvbTlwa1pjN0JjZmlWamtS?=
 =?utf-8?B?Q1k0ZkZsWW91d2Vla3dtdmUvVVEvQXRTYk1WeG5CbXdWS2I0eUZNUHh3d0pR?=
 =?utf-8?B?bXUxZkRBMndjVkVsQmh6dmIxQnhFNlc4ODR1ZWhKR1k5MVVOaVl4bmd3c3Qy?=
 =?utf-8?B?bUZZSlMxems4U2czUXBnbm81aDJVK0d4Vy80WTZWOTJiZEhWQWZVZk4zQkpl?=
 =?utf-8?B?VmRObStyZ3d1UEFwS29hZWh3bEVNUm9xYnFkUTlJdUtYWkdiQndIUkxzc0g1?=
 =?utf-8?B?M1Vxa0FudVFMTk9jd05nUmd0WjdPSkdONjhKUDBWYzBoYXNkMG5nUDgxQzlI?=
 =?utf-8?B?RnQ2Um1lMDZ0V0dOcURxUnMwVUFTY0VzZTdRZVJWamFERHArd2xvQ3lFczFa?=
 =?utf-8?B?NnNtSnVCbm5vdGUwOVMvdjNKVVc5SnVyallzT3Y4TDF2SkpTWDF0VnZiRTZV?=
 =?utf-8?B?KzFoalpRWHJZQktWcG9kKzhHY1hiL0tSU0ZuTTJRYXFlNW5IZldXNk0xd2ZJ?=
 =?utf-8?B?YXVjYm1XWTVNT1pPbWViZWdyT2QxaEtqcjBEMWZyb1dTSnlKZnZKNStOUlAv?=
 =?utf-8?B?ZXFLbm9Sd2o0VUdjK1dBMVdWZGNtUStNaTRncmt0MmZzSEo0ZHpWWmVISWNW?=
 =?utf-8?B?eFd2bnNtNkJPRlRMc2U3UTMxMUErL2d6MGxESFdsemhmemUyb2dvbFF1RWRq?=
 =?utf-8?B?WlFKR0owTkc0YmwzRGVDaGFqb1JSN2VVYzZtRzdqMWtRMVdFcFpldmlWOStN?=
 =?utf-8?B?TURKVi9VTjltN2tjQ01NUGVDQmF4UHB6ZmY3WEFBb2thMnd0NTJVdlArZDQ3?=
 =?utf-8?B?RkFFbkY5eHhaQVNRUTdRMCtCQ1RVNU9SSldVUE9Sbmd4VEU4SW15bEtsUnla?=
 =?utf-8?B?WjEvK0FaTzB2STRjcEE1QTM4aTFmbWYwSi9SY0tMdlVUN0pPYTR6N2w0QlZL?=
 =?utf-8?B?a1NXNDhvTFY3VFA0SU5tL0YwL3M3NmVIMHd5L1Rsbi9RNXVNaHJSVlFORlZS?=
 =?utf-8?B?dktPQ2J4ZXB0em1LT2w3UitSVzNERngvcHB1Rmt3akd5cm9aRHg2ZE5pbHkx?=
 =?utf-8?B?UUFHUU00UlU1Z3hacmlDQkFrMzdTK0F5d0lIRjRyUGxuZVovSzBzSDBoNktv?=
 =?utf-8?B?OHh6QTNjNUc2NkZkcFB6SFZ3L3lwblRBSzJ1U29JUmxrRXQrYWl5emwxaEZC?=
 =?utf-8?B?bmxsemR0eGNQMmM2U1dnNVRFMUZydjlMRndxb3lOUGk5b3hUL0pySFlnYXBJ?=
 =?utf-8?B?U2d1Z0orS0U3d3h4d1kvNnp6RlM2NXlVTGRZNmJIRFRFNkVaaGp0cG5meC8z?=
 =?utf-8?B?MEljbTZJQWYyaWFMOFN2dTdYeXFmL09Qb2ltdTFiVlJyS2hkYlI1YmdWK2V5?=
 =?utf-8?B?RXB2VmVSazhubk1YY0plUlFyM1l4RTVrb3UyTDl6S3VFaGJjYmpyellaYUpX?=
 =?utf-8?B?eTlacW00TXZCNzM3ZDJ2b1hnanRSdDUwNUN2ck9TanF3Q2dzSmRpL29ZNmNW?=
 =?utf-8?B?K0hCZkkvUVpha2YvcFJLZFBmRjRkcmVHb2dPY1VsVWU0OHdYdXpUWEdVdlZX?=
 =?utf-8?B?bG5vNno5NGxJZE1BTUhuZHpTRHFYaFoxK3dKZGNIMm55cnNvL2tHcC9FeS9q?=
 =?utf-8?Q?88Ao=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jsuf4rmVSnc0i/8ItDeG0jmlKI6+OKFlk4K9E9zXsp8D+W0kE+9qRn+DT/PqTjOsv0Z+epd5sVR3rbUD08Ml3T/394fRRYBLhOdcfpdzILmIAZO1+crMyPj0+kmf1ADfs1ZJN9j6RpCi8cc66mqUCLYIVhsZpWFpUxBJnRmiDqdwvMNrH6kOQc4yeqcdtWZ+u9RokKH2BnpMRqXgZvNIDmVrJkU7eQ6nx0+5QGLnvk85+uulYzCI+Du7lOcM1x11YQkgZWGn/Hlgxmu2ocmOT9FyjWQdyVuTB7qLqWKVkSVm+aARVLrYpEAABcZuy7u/oqG3ysIhXKwVumWfreX5NT4yKr7V0CfKhnDITaXc/yELtG4L2DXsgK0x1cqF/GKriabsFy5oQ43VYulQm2RNvecD9wVxL590ZNAxPbGcCuJQnt4WAPQjGrvm4Tcm5RnN2OYrAaAX5GbShL/FVr4czZHN/shWL3WMKs+vcyF90ZsT/moFG6KTXZqpg36acLgjSyrfIO5j8KUiDVv8gsBj3L+rSvUd7o/mVkzMhOuDEXCRlsjxExopK92PHATHrovzwOJP3zTkR/7IBJA6za9aMS434sA/j24lxSu0326TRSe4G7/Uh23jDNjZ+bArKH97GOy7JoBvbo84O7D4B4yjv8P0Biy9Tzpps9beS87AjJBz2kyT+9NGL/aGk447dI2QQ3/kv8pD5NF2uWyM8pTVmw==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:45:34.0426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a792499-b62c-4875-4ffb-08de3d8bb2ba
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7671
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

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f6132178205..3dcb18a7664 100644
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
@@ -156,6 +156,15 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					     in_v2, out);
 	int ret;
 
+	/*
+	 * retrieve the correct priv which was set in scmi_clk_probe().
+	 * in case CLK_CCF is set, priv was set in parent_priv
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

