Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1101DCD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864D283E81;
	Thu, 14 May 2026 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="le/udjJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A98883FB0; Thu, 14 May 2026 12:05:13 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1811B8341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arHn4XQNHxfik+2/bxDCfyQ3M1yKBs6FLvbeakeHHMkKfSsTqLIIRY1vPq7YkD3lTGcqWsR4SMn+o5QRONCIx8QFHf+x2Sc1qLLFzux1IDlxFBat726c2+ozi2VShmbGnC5DMta3EehSbaFdjblaaqC/fzHf4kElP4aqav/GtAslJzmnOEWD4tzqKm08/e5Isls/SQxFybNiPwvW1c/IieiND/UYQtjjM9vRzyKQwsNGg2kR+Zr1EzecM8EhQ07+fKp7s83bFZ9acyFHx//dvy1CXKAj5LlAsGbbEFBItf+74mYGQR5aWCZK+PfhJIZYGJ4esshuFAWH4Dstf+VkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhXRwplZPD+khNDEd5PMYRWPVylnTlgoB7flL+TPFEA=;
 b=NtcbsT7ARho2mTLwkV50L15n/WXloD7hggl+TfkXALLanod3BnkP85tA85CJ9wWVefFDuV02fGwWAVbrblQp7O8Cgku1bWLdZHY9zdrQA9ZZPbuySX+mVU8qmGQ74SXjh3rVUBlo6/sN2hqcpT+j6KaHxRmibUaU/9CK9EbP65CAqeDAynub7d7Np8oC4NJHROD0Wj6X3dhjIdLSpJGG2xUHvcdTTfogm8HeacMMumIj+aLMLIIfrxBno4gC/XObPT2BXKHTWDi5cgoGlbx+AxUvcl88WI3GFVI7FZV/HVmQ7dCqmQNfFagzGpktx2sUf9/M6jDJIL3avb+zVl7BNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhXRwplZPD+khNDEd5PMYRWPVylnTlgoB7flL+TPFEA=;
 b=le/udjJeMfAWhr0DmWoyRmG1KegPC/Wfp9v0v/xEKICuL36iayqL/txbVioid/QPjcMAAufLhTmZd2b+m3iDoOe8MlYtMFo0DoCfr32bpVZDWB5frjdv3oyxT0E/3c2gzt3i/bNSaQL4aWb3j+5l2ViH02SQECl2JKl3ImpywfQ=
Received: from CH2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:610:54::11)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 10:05:04 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::29) by CH2PR11CA0001.outlook.office365.com
 (2603:10b6:610:54::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 14 May 2026 10:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:05:03 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 05:05:01 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 05:05:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 05:05:01 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64EA4wDH1925613;
 Thu, 14 May 2026 05:04:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] arm: dts: k3-am69-aquila: fix combined boot
 firmware image build
From: Neha Malcom Francis <n-francis@ti.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>
In-Reply-To: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
References: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
Date: Thu, 14 May 2026 15:34:56 +0530
Message-ID: <177875309603.2866518.8838543726541957983.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778753098; l=259;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=XJQWelUPt2NvqzR5cGepNsUqDC5WFrzAOu5BdqgeZNA=;
 b=FEcVp7Tha4EsjRIRx1itu5AGI42KiJAVhzKAekQEP8klNjwaAUNObRF8R35PPcEqjlhlEzJzI
 Elnv8RMt0IZB3ibjWCUVOQUvzWyVlpAeRGb18INRyj5N6qsLGQjvLWr
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a95175-e055-4b69-98eb-08deb1a0444b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8VOs+N/dakECDNL2Mx/gkL9VaTvjCZUFoz4jO6abywSr+bkEPsbeTSr0rEp2RdLBU5kK0UEeUHa9+8aJJ0UeNLl9qY6nJtRzs9n40CYlFdrjvA9B907ppNVP1IhOncYf+5PWkUwy8FI7vhEPWVsgcxz+n05znFhPINQzu+zg2ciJmllROtFhOipJMp+9Nc3H+Lh9VDKdpwdTvrJACND5y0XTb3RF+mOqwhtE5Y38l7OHwGhdOBnH/CNHe2VVnHVoILBr+rr6AVWh6v2zG4KNqz/gOalerAAshQ3BIOL7UVX+wCLY7nA5u/SXAzV3V1YQjcegtzGhACbYFRlFYhniBiekYMRZcnGOZXKBHRkVKPbbG9TFtG6JtvCEW6qUeciCkBmrBRPdn1hZTearhm5zlfDgK77ybUfQO+/O3FSSSIEXym++HE37wTOQs/WWNbJ7CsiePsJjyCSd7AUuLdXpZ47hPZJiBPuFkRnxuNX3OWy5+cdXtVVH2zcmzc/H4rdjp3R6dqLWpuahahv3tEyK3PeYZ0Xuta70CXJRQ3j8WiaLAtmNhXJnvrZifMcXpS59C4t5ZdfKgPAnrh6ct0Xac4GkCOS2ZMKMc21ElF+bStj3mmPjJ49AY1zBphRhHYeled8NlUDtgXffuQG/E1XOAAnQOFpp/Qoj8TtcY/+rYsmoVRaQ4puzjmAsklXwQ2/pjAivnftSygHZlQxB7tc8fwSYctivgRLKU7w3fObM4xs=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ceRTwuUF1m20ygRUWk1hHfX2vFkse9hSeywbIC76fGgcsZcV6LU+iU1vp0xS3smBbqhJO2xRnx2BX6euVniq6XZcXhhOSDW6VxJHpvriOkw3aZdYcr1I62+f4GPzn5TSbI0r8H2sIxjPyP8TsR50V3LC7N7nWCfTUP3b6fUZSoL/CTLfCd5htuUyFukgd3w0Oz9lOVRefw5KbeL8NnlZdJLEqz9Nxob494zHb9Grwy8km4e6KPlba/1l2Risy0+KtykNXhjVcLutEWFHeePomvTHEse5WEsGOcRrdmZSLfvxt4ijVTaXVykCaU7XcWjyquvPctTgNOPpSH1SnOZatcZNIZFkkFfjv07JHks4m6xOCnm7vp4Lej5G4dfvjqmGBBICcjmpdTl8Dh7aJ7ERwu236IGZ02AF/dqgYcxEVelaWp9tDeVjqa/tDfXC9m2v
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:05:03.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a95175-e055-4b69-98eb-08deb1a0444b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
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

On Thu, 14 May 2026 11:15:12 +0200, Emanuele Ghidoli <ghidoliemanuele@gmail.com> wrote:
> arm: dts: k3-am69-aquila: fix combined boot firmware image build

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
