Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48467C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077B08109A;
	Wed, 29 Jul 2026 05:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrEO7uquJbPL; Wed, 29 Jul 2026 05:14:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E70E81091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302040;
	bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LdGjdp90CDXY7hDmeT+5p2vIubMkvYaRv0b+T1o7OwGs/DrdLysgI9Kjcy/hI8hbp
	 CggT/SDK+BrVYFrbciGqHm5DMStxXRtrq3CcXges8/Ao0nu7uEWnReRCMCV2JkgZTJ
	 k9wiKn5xK/9VN2T0QwTppCJuuDBGe1tanWJ1MfWFjuBZd+RBY1vTV6sitUHb9DXR90
	 ByfvTDqb//VYyv883/I2e9k/7RTYUkUA2MBt968ywx3a1IArC8cnwwo2dYcLaFqY8x
	 +37tFcV1fu96pjQvWyXeK0ysT5FEWgk8pjwpXRMKJoYZOOsBLMs8cvOy1UTp+2FFB+
	 V5OSvrHa7CnYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E70E81091;
	Wed, 29 Jul 2026 05:14:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E9F26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 799FC607E8
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EubCR3evsXgX for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B543B607E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B543B607E5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B543B607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:13:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58C58404D; Wed, 29 Jul 2026 07:13:55 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5468493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:13:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb6qt3VGkmNT5KNzf0CvY47BUaF7fm5c9eNMdNQNkd2hU1x0x5Y5GzSo9PN6mb65QVKG4oYowpvfwxcWd8pI0m0MOO6aENV1ROCSv7N+ZqtdLjrtBFjhriuDOTFSIETx+2feCPu2xySCT3EUNzJ99jo/L/g9pvqMOLoH+iqHhlwKUet70V7i2gL1Cri5jIBoQcuNyk/WDKUjoUti6nDnzW/yiC0hqQT64vGdrgQ/kz86uTMVBpLZmljyr8bytNT+0gxlLtnpawg7gU5RZe/uR625IeURHnNmC46a274Ow8JkHdSBNlvzk9xEmNIu7WrjYkECroCVoFyai8SXbsh7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
 b=t2bFXVkLy6fwu7wBVJpSuxM07Taqr0qKUN/iqPfAjR60Zwd5z/iqKaR75iC+B+S4YB1zCHP4OChnjuZxUF4Nt9tkXv2lsXP2sP+ESSCKMOsW4o3l/y82gWwD34/N6zUm/S7kVwbUuF/dRlRxZfV/7jUh85rt3o8pBTgLp+3cix1QMRvERLplVpgJXg7AS6s46eG0swydJBfZxQ4Q8tRtLMeJYT1MHMqhCloVt1HZqZl68rcuKXpU0wX18C+7KOQ4d41u0T6c05CpS5n7rNKjDkD/KkzobkPMNURlk5YG0FHt7aQ+IfU8Tsv1NGJXfbm8H2fFeeOracRVQADyqelHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:50 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::88) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:49 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:47 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 1/5] gpio: uclass: log when a gpio offset is already claimed
Date: Wed, 29 Jul 2026 10:43:35 +0530
Message-ID: <20260729051339.221699-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729051339.221699-1-pranav.sanwal@amd.com>
References: <20260729051339.221699-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS0PR12MB999265:EE_
X-MS-Office365-Filtering-Correlation-Id: 859a22e6-ca11-409d-4a34-08deed302d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: qaQP7qRiUaLFJnXSwbQk4mLfMNqYKRuh/Rm+uQzxVgkno1Hd9WAfpu9Dn3ojgTTqbpGPzlGfmPy5cLhchvMmS87Qt7qULvasDgn/118Oly9lU2w4GYldVHIe4NKuL91NUfteKoLTVIOZD9vy0A7DzBey5JlE4CRkK/s8y5z37JGE6HgxWjZ4f2RC/9ai7tD2R62lRhJ7FRqgm+dm92O22nWMaUsWM5DN0RVXeTttgKm7h8vMyjql9Pbas5jWrrpTi3v5i3zptlLnFeUrlljxdSjYFSGoSO+ne88UZ26oSrHHOpq7nzWVj2+y8ZtHIdffAEhr29A/vdyeGKkqkj/XmGOW4IGyOOTay51LSJZqiSc/xbuURkUKw5i/uUjNwb5ui8jNmNfoPcMg6A85AOJALSfk6fTS8BM0UGuXr2RjCWi/n3L323MhQ1gWYcB3rMPEwtdOpYrG0k8Nm9pch78JooDpWLwogIWZhaVBusH1pjy92s+Blab5PeEVPwh6tJ9e59mLHNv/1WKv4Xm8KsAvbC9WrrLxrkCkvWzjQfMiOsT0tcrfM3wEjtXAqSp0BRGcmkTvppn64F8AO9gZuK87r3i5BhCpGqufY8hRbuTV14MZCtrsoYV8SDDfY+Vt/z/o33VFfMLOPPgRtfkuU6JAUmnFr5Fr74ByYBRlekASBHtI1cgyUN/yJ1O5tyGP3zjR38UBaadBE+l5Ey6mN+sGbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JxVG1HPQvteccE0/X792AY9TFWVxa1jOwYxuvxNJwFdOgFqlhcj6CeOmonzLV2VDZXGYZxj0CUCWpiMhq+7B5BlJgx1AS2tj8mFR+MZYSioMsuet0L2Gma6oj7nWZULzZRGPlAx31yVPw0QUZ/mlnru+y0i7Od6cxR9Tdfch/MmmFAG4Ef3J4kmJWY3AreVhpxIHkvU5z9NPF19jucXACJlMk3lMIXo+q1S17HyqW9C5fR4Vnl2W5MW6ERsJINJk5jtwfshQOnkasvGrToxhwdioz09KbCCY3sRddk3XpEd7OYC3RQYcRynq2yKP2j9yjI3IunGGmK+tmh/Rkshjzgh5bDrWy0bPDJb+OSMSXm1KN99AtSRSLotOtGJ9z9ewQkkumq5xE9TQljezAuRfXcQcKUsNkPQh+7sw2elkCGGUiypc4uz1oaALa3lOOKzt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:50.3275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a22e6-ca11-409d-4a34-08deed302d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
 b=wldJr5OtAsbK8bPy27C7Fbs/AfAwJ+5A+EgQw3uyPwRxxwOnEDJ2wyRTAqsKRozA7TqWixtx1XPEfGfJ/odORWEjHLS2MKDEcLVFPh69cMu7dQtvf8EV+XItASPJ35At2sJkXYHn+NQBBCMc0dhW8YywWFSg13fCkofofNknUC4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wldJr5Ot
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="wldJr5Ot"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

dm_gpio_request() returns -EBUSY when the requested offset is already
claimed, but gives no indication of which label already holds it. Any
caller going through the uclass API directly, rather than the "gpio"
command, has no way to see this at all.

Log it at dev_dbg() level: silent by default, available when actively
debugging with this device's debug output enabled.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---

Changes in v2:
- Downgraded dev_warn() to dev_dbg(); moved the user-facing warning to
  patch 2/5 instead. (Simon)

 drivers/gpio/gpio-uclass.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7559b8dc7e2..9451b7db4af 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -391,8 +391,11 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 	int ret;
 
 	uc_priv = dev_get_uclass_priv(dev);
-	if (gpio_is_claimed(uc_priv, desc->offset))
+	if (gpio_is_claimed(uc_priv, desc->offset)) {
+		dev_dbg(dev, "gpio offset %u already claimed by '%s', requested label '%s'\n",
+			desc->offset, uc_priv->name[desc->offset], label);
 		return -EBUSY;
+	}
 	str = strdup(label);
 	if (!str)
 		return -ENOMEM;
-- 
2.43.7

