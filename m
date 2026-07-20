Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A3C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 05:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9ED882991;
	Mon, 20 Jul 2026 07:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="tsPRRvB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031A883E76; Mon, 20 Jul 2026 07:24:00 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6A580517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 07:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp1BMUP7K4Kd+30EuyBZQSMtvqqrVsscthLCIDgvVZOM1lRpJSd9SzxVrZxBuG4K9vOoV4UGELbv35vQHkW6JQ+UhqfuAX/UOLS+vLs1b2w5Fsww9/Lu08rVOqKkn2iY2oiEM2cro9+k7tOfzhq2j7v1HQnoyqy61GYVXr7MfkbxHTvjnfP5S8ZbY6MSVJSVaarESfKZdfd2fODbPlpyUo9+dVsMwdCJVp+FR54EA6x+REY04hOxP2VXUVg01vWSMOjqXVuMIdsdOcce9jd68N8KiVWjv2TuUP2GBFgS6t9L2K/Qpcy+oQqtypZFi/WX8zO3AC6rZBMbN9F5ldP+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnbPUxIG1Jp0wN6nN+CnylVRwsMdwrKxYZpbVU5EO+I=;
 b=AzjhBBfQllN22Fx5kIGkDqs6bpg1q+6UfMz6T8R7JK1eqjTII2xh9bYfGR0WpJQIOthXTHRw/R3y6KQKiyLa6/dADZ1D+ACCUWSixzobcnKdCpBL8OTPVv0Hhfa9f51yHfpK3YYSU5oqej5f+cy1kGs4iivf4lST7nLhDxrlYoZwKlPqiKzj/S0ErUH/yJQds02oM6YsSPFCQFPDAg8XYpjRXu8zxqvoh6dhUfaqa/MmeUqqNOvyChmDU+7tb9Qa9QAmqvyAND8oQVQBzvdQWyFv2N/Rj5cTnSfs3yWSoVxpk+pin0L5LATMooMeqUVF3wDHSuw5p+9y/5iF+7znIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnbPUxIG1Jp0wN6nN+CnylVRwsMdwrKxYZpbVU5EO+I=;
 b=tsPRRvB8HyxhmlSorrAlmDPP+zq+BWiIVJnK938r/NWcVkymAcJlJix9+MuY9k36TjGashiKXc0oKHuD2grdZFr8Zm/6XhNl8tezyX47JPrj8cJzs6UbrzitxzNYyx1R4heEY7tbgnjkV46vncstGPDNEgZoomBHuZqFT3Fsp96Sx2sUQKE0k3jwpgbk9YQb2yNHqTfdAZzC3TYa0/QCNtnBQb8neYUeCvju77MW7CB5cCh9dxdw6VYJxU5+Xrh7zmIzcgSQP6WUDlEP/+fFBVZH9dXMVhSnJv6J2cEmsLdQBZWzI66LYcMo/UVHe9HJi2ctWtm8mtrk8VzDoajKLA==
Received: from AS4P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::13)
 by GVXPR07MB11467.eurprd07.prod.outlook.com (2603:10a6:150:325::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.8; Mon, 20 Jul
 2026 05:23:55 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::4e) by AS4P189CA0009.outlook.office365.com
 (2603:10a6:20b:5d7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 05:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.100; helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.0 via
 Frontend Transport; Mon, 20 Jul 2026 05:23:55 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id A6ECE680033;
 Mon, 20 Jul 2026 08:23:54 +0300 (EEST)
From: juuso.rinta@nokia.com
To: Simon Glass <sjg@chromium.org>
Cc: Juuso Rinta <juuso.rinta@nokia.com>, u-boot@lists.denx.de,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 1/6] watchdog: wdt-uclass: add get_timeout operation and
 helper
Date: Mon, 20 Jul 2026 08:23:24 +0300
Message-Id: <20260720052324.1362574-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszThP7wTW6h8__pwnK2t5vgU0fB4_M43y7F+TK_adKiyFbA@mail.gmail.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-1-9a982fb93f49@nokia.com>
 <CAFLszThP7wTW6h8__pwnK2t5vgU0fB4_M43y7F+TK_adKiyFbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|GVXPR07MB11467:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60f92ba1-44c9-47a9-bc88-08dee61f17e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9xuBJ6pRLSdG8ocHMzo8jSUzdEibWQ+ulu2dqxjpiB5c70zeArCDpApD5zh/tnPpOhuzHuooH60PrF3zVokpgOM3XJziEMWcsISKEykJyWZHLqjvLgk0eQL/CYrb8q325UirociRs+gn91SqkXJTsdAsb634kkmXKr1FUZ1LN5TXHUywzvjESb3zMGYpYoOUYzO4c9zIWGSFRvJzSBtyqmjQOzbRP1SPQc0coi16zNJv7n9dn0vM76t0i2aFf2K4yCseCVRNVluaSlqzKTvlcmWsbB8L5KLoJSS358qlLUDC405qdD+0t0XHSfI3XjTlP7/Ox77d9eBYuRSiSCXwZDxNJGzgiuowzpX8ddtR0vxCkX9204k+l3SWn9wg0WAJaFnt4xfFA8o3eWWjfwPE/kapnF5X3HPE+qDBRb6555xoj0KxXYVlz+d9nF8CXIYeN3Ebljs4+yuE1a3VxUTmuTkGINXlWU1gtoc9ASPaWTaqibYdpeP9o3aCnq01cIWPXbABe3pw2kZeQmGesOGQBMadp3TXhzMtlF1MJJUqOaIvDlNUT04ar+c9pJ//w5T2nTMD0nb/FUcbWRbDMnzfp+W8WPPgt7GgULQbKJGUes/DMphRR+gDmNeriEmULl4doRorPaZU4b3tDY7U79BRfaJuN1/AZesnHe+g8K3jd7v+ieR0y6FkHaVa7k1fPI//8y7Y+3TADW1z/WpDR2fKnQ==
X-Forefront-Antispam-Report: CIP:131.228.6.100; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr711usmtp2.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: txbc0sxrvajDUJLfrUTMlXuDvsIQTMcs3JzQA1/p4+KvHwnSK0XJ5j4mLn1+P3Aapyd0JMZiljeIiDwlSPYZswddgqhM0GWHju4jgSIcocUgR9ut0EyctOZJi8kBzqqbTccBdCWbHh0EXNW53uVC1Vu12C4EZJjV2W+S4reDX9bUk0+R5TKU6bXOsPyhBI9ahDTFAeMW1Btjoqc/St/HGgY6bwcpDjK4m89PkusciQtGCkcgMUdi+/uP5SxFigJG2EJJSiFQUtFk4YuMF/du8cdVQ0kOFtZJYopYLDeQaKmfwc/uCLYNNRPHW3BjLHy1XaU+zXqZUxmxXgfDfmhi9fs9U2nNL97wYW48bgo+TFB4LWv36np+Pvol/DZV6oQayIq5BP4jHQHQ9W4HTTd+Pcuo75q+hiikvcRzKMy/acnNnbO9Y6lA06NBvwvMDbap
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 05:23:55.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f92ba1-44c9-47a9-bc88-08dee61f17e1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.100];
 Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11467
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

From: Juuso Rinta <juuso.rinta@nokia.com>

Hi Simon,

Thank you for the comments.

On 2026-07-15, Simon Glass wrote:
> Assuming this is a static value, it might be more efficient (code size
> and simplicity) to add a max_timeout_ms (max timeout in milliseconds)
> uint to the per-device uclass-plat data - 0 could mean no limit, thus
> allowing existing drivers to not set it.

I agree, using a max_timeout_ms would make this patch series a bit simpler
while still fixing the issue that motivated the series in the first place.
In this case the wdt gettimeout subcommand would no longer make sense
so I could also drop that. That's fine though, as the print we get from
calling wdt_start() is the more important thing here, the subcommand was
more of a by-product of the approach I had.

I will work out a v2 where drivers set their timeout value to the per-device
plat data during probe time, and wdt_start() considers max_timeout_ms value
of 0 as "limitless" or basically that the feature is not supported, in which
case we stick to the current approach. I'll build and run a few tests. v2 to
be delivered this week.

Best regards,
Juuso
