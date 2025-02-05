Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64EBC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9BD807C0;
	Wed,  5 Feb 2025 09:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZafRq6xE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB5C80207; Wed,  5 Feb 2025 09:02:17 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDDD806C9
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m56ZppbjuMedIlm6iXfuejCdOsZl4eGnRwwsycoe5DX+aZpECxPRZKlvfZ5nobbx0Iq3TW1mE59Xa15PAB/Kq74DR9Lqj+XQoOWrdBoV7n2qzOmysHGkbWHTLLf2D6O19eEeVgMz9je30O2gmxUAnzGp4U+KM22UkhNzpLj7JUWerEJdBEKkDEcXDJtxS5q5ldK6FXcgbFKZj13siheeYD30naO98VjBWWBGvsrivlrs4EleGhdZe+Kw0VFA3eDn6sesJ7hn1916n8F45/y4TvO48lefacuU4M3qUN94P8HFnPWR+Vg6PemmyArTvkw1RrJ++8+TzIlVn7cB+FXKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19hQAqOUHy8qmfhqoyWYAgDp/fZWOIgjq0zeG9Wk7x8=;
 b=E6TP0qYeFoTtMMuzUX0k8i5pdODzxk6hTFPiv+VrU8uaHXtkYjA4rOWL1FcmxXqx4nuRYO6/nryWNsXz2JW3nEd+fbEFL/MwgIhHHlbDpueV3Oetaulr77OlgHEOcH7K/E9oGjzVCQn25lNXc+QiAxrh71uXQ+kNSodkyo801756jIhH7vJKl2z/COiClxIa4IFdtSRJF34lxGXVYXndvmZY9NwAA6apTxfrWMezAaPISBVig2AY/dr8VIdzP56DoFmh2hrlMSLw1BgM6Y4iiDoQe6Ma9zaQxARwI4f5pBzE66H4C7rf3DBKKKU+3h3TscQpR2HC2sDRY3l3M9YCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19hQAqOUHy8qmfhqoyWYAgDp/fZWOIgjq0zeG9Wk7x8=;
 b=ZafRq6xEdtWFkB8t1+bVeZPCFW5CYiLVzs/SKrGjER7e43roY3Zghj5S6+SIrdjsYSErbXsXaTYYFFO1ZfyY1aki1biJm9xh8IacvBmS4nPEyXFHG3DzV6otCfxileBZLDvAnzv2eoqIETIoALqNQamFp5ETFQBAhWfjljUT2CCgxOXdA4L8ucgO7mcqpXVouCyTO4N+yH3DUZ4Uyt5V3eu9l5+hwDNWmMnsQVrfgCsoN0+7t4N1xN6LKkBD4O4WLKM71TFoFn3jbQ+Rw7evyW6yXdiRYF1Ui94l7eJ2o+Aa664pCkdkFbktspGrQaEbLbGfkC7lmAOb2Rf2IR8jHg==
Received: from AM5PR0101CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::15) by DB9P195MB2131.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:3d8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:02:11 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:206:16:cafe::e) by AM5PR0101CA0002.outlook.office365.com
 (2603:10a6:206:16::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 08:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:11 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:11 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:08 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 01/10] board: phytec: common: k3: Introduce Configs to Sign
 Images
Date: Wed, 5 Feb 2025 00:01:37 -0800
Message-ID: <20250205080146.1944928-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79B:EE_|DB9P195MB2131:EE_
X-MS-Office365-Filtering-Correlation-Id: a32a0bb0-59f9-4369-2e2c-08dd45bb6534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/f6ql44jenEFsuHlstv97M1NkqbWm8aCHM5f1s/uhZwcGjHt3FRYBvxFt236?=
 =?us-ascii?Q?RNLiOXxKIGaEQM6909xyi8/BUX17ShE+lVS/OWLmes27fewcSjBrr/IjOlMS?=
 =?us-ascii?Q?u67P1jAkFQ9h3N1RMH6qZJSLLGXGcIAa+ICIuPD+mUaatQYJv6bZUxkvbCnm?=
 =?us-ascii?Q?7j77f56VZV+d5Mi4lNQOAcCtEddp+mfxqUBkXkPksoVtxmvSiiY8YdmSGZvB?=
 =?us-ascii?Q?Pdnavns5gQKr1RCqxf8uvlG8JobSFpyAxjGk3q5K/YT1O1qXuS0/fF2nR6Mx?=
 =?us-ascii?Q?n2XQcLlTAJUdCjMaA815W4ezMQgS+nrCCJWheBH9k6iRwLUAv5G2Am4D3DpB?=
 =?us-ascii?Q?QeRmBVS1MhSV9chU1taeZQYD4j2gFDXhwf5SL7b2sUmPPg5VntwkW6G1xgUH?=
 =?us-ascii?Q?o80a2zLKm4FgKdBmKPDbrMnibvgCORDPQkEDnAGZEnC9qQweChmI/3b4sV92?=
 =?us-ascii?Q?Fx2Vg9Y/Og53f0MffErTQhL+VBI7FILTDlPtkCGC2JdD2fU/VuQJS3x0FzbA?=
 =?us-ascii?Q?Q72Ec/qfHr7U1GD+gzksKXlyDY0wICGSAVgYL9/UZxhAgmi/N5jBGIzwqJ9c?=
 =?us-ascii?Q?jkjG6wLcu+raceWCD9EWja+t+HToqWxnUVDzavec3UnS5ZFcD/q4PrneV6vP?=
 =?us-ascii?Q?IH768VlUyiCnz0EzSrvPsm/FDmJ1Tim90QCuj2v+fEal2474YcrPm54cOYzU?=
 =?us-ascii?Q?oUyD73cd+Bhng96yrIHnfbhvXRai7yUiP8bDe0yswaU1IlWainsB+d6eXafH?=
 =?us-ascii?Q?2imc4KYkjNABhNCZBuUIP0wA5MHNJl6voU+scHZyA1pLEaMIbD0PQPXfyWKm?=
 =?us-ascii?Q?vFjZQhW7PmPYyRWPVRfT1q5mP1q3+joqOaAcsvUCw18ZZIBaO0dU8zBcug+V?=
 =?us-ascii?Q?8CW+sGjnT1SIjG1GJ756uqrErDute2VBWCfVQqFACXH9wUwgpvtXOUn4SmtY?=
 =?us-ascii?Q?zUwv8C7HKNFfjdOXAcTWyN+zfzC55fk4/Yn+YKlZcRsX18WUWH+xGOo8xnvm?=
 =?us-ascii?Q?/a99P9gCUoNuOoae+EzwRnspAVInmr4YMqm7K7k9C1GCZJmBRAzYh3fU0Q3w?=
 =?us-ascii?Q?EF5gbSPGJg4lc9cehLOhF1XcR5DK2lmbYdBpz0DWzHek76Ill+4FBijpajec?=
 =?us-ascii?Q?lehk1oGpixfpn02IqI3+18qzMFyQpBXjSpgG33WFaRF8brM+8sffnlyvEx/x?=
 =?us-ascii?Q?8Du06mpp7MtRcQlFmd6qNJfxUwnC47EBC3/u+oBg1Y8nPRRvCNob4Xd45tvE?=
 =?us-ascii?Q?PySD/mfq0O2K75Dk4P//GKZUF/L33H9L8/1p0tSa3XT0fsNRVbWxBDu9JEKn?=
 =?us-ascii?Q?jTnx/TPScIRAsPvt/cdWPKxHwllWPsMkRyCpZUtuUMc4O+zEuF1baIb//jGJ?=
 =?us-ascii?Q?AZlvrIWu3+T8jtLAS+3rbTJTfVPooFHMPdIcOOWmB+XFU5AfRbBVON+NSKCA?=
 =?us-ascii?Q?Vco21yy6OGjaoGKg8N3CdtHzetx12nSX+7taiDPB9ziK6D8HNK1MfGC035KK?=
 =?us-ascii?Q?6Anz4aT3xxBqBTE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:11.5129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32a0bb0-59f9-4369-2e2c-08dd45bb6534
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2131
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

Private keys to sign bootloader images shouldn't be commit or part
of this repository. Add config entries to use keys located outside
of U-Boot to sign images.

Signed-off-by: Maik Otto <m.otto@phytec.de>
Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/Kconfig | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
index 282f4b79742..19fe927b22e 100644
--- a/board/phytec/common/k3/Kconfig
+++ b/board/phytec/common/k3/Kconfig
@@ -3,3 +3,37 @@ config PHYTEC_K3_DDR_PATCH
 	help
 	   Allow to override default DDR timings prior to
 	   DDRSS driver probing.
+
+config PHYTEC_K3_KEY_BLOB_COPY
+	bool "Copy the MPK key and the degenerate TI key to the build path"
+	default y
+	help
+	   Select how to manage the MPK and degenerate TI keys.
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, the keys will be copied into
+	   the U-Boot directory for compatibility with the TI dummy keys
+	   stored there.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, the build will use the
+	   original key directly. It is recommended to use the original key to
+	   avoid unnecessary duplication.
+
+config PHYTEC_K3_MPK_KEY
+	string "Path to customer specific MPK key"
+	default "custMpk.pem" if PHYTEC_K3_KEY_BLOB_COPY
+	default "arch/arm/mach-k3/keys/custMpk.pem" if !PHYTEC_K3_KEY_BLOB_COPY
+	help
+	   Specifies the path to the MPK signing key:
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
+	   copy of the original key.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
+	   original key.
+
+config PHYTEC_K3_DEGENERATE_KEY
+	string "Path to the degenerate TI key"
+	default "ti-degenerate-key.pem" if PHYTEC_K3_KEY_BLOB_COPY
+	default "arch/arm/mach-k3/keys/ti-degenerate-key.pem" if !PHYTEC_K3_KEY_BLOB_COPY
+	help
+	   Specifies the  path to the degenerate key:
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
+	   copy of the original key.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
+	   original key.
-- 
2.25.1

