Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8129606A882
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d2csztjA;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=NahjfhJu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9552581160;
	Tue, 17 Nov 2026 13:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fy1LaWzjOZYx; Tue, 17 Nov 2026 13:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB62E81136
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794923534;
	b=KMaowwxVb79JdQdo0o+AIqZkVP0FldBfoaF5rAZDVntODZTCIHSOprI6xBQKvgxxUDXJ
	 ALvoYlnoC4dD7tDKpK8kikWHeL/Ghkos8bIKMWJpG51y2kjBr9obow0wEAsoKb0jnBwAh
	 7RTuulOLKFGGw5rbiWC5bRPnDuK+AUVf+552NJdyAUqim6efUGZdzWCCgVFL71QNWDN5o
	 PLnu7raH0cGULfs5Ycz2qYErHw1liYyVBup/9sTzS91OC2ADuJDaRvNAKfLiLu0m7BZaE
	 KfeDViJQtKF3E/1apoy2TEFMSEZZaoVxN5mmet2Vcx784f93colUyvZYRbXACFCC9Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794923534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=1l74QYu8VsM35J85WmsDkdNXw1fzbDQkell5lAPZqqI=;
	b=S/OyFExXh6YnX/Fzy0E3lFtYSARkX1tb/RAFIYPmb/4/Acd4gnsV6gWrnIA0lRcU93Tx
	 tEfQknhwlA4b7gE1SRqJRne1BzdovwmnpvrwqyeZbGWAkYPnQ3X/Qc/QojG1fnYLrF+7k
	 SzjE8y860WW2UckjU+iVuKG+tcWk8nuZRoPaQdYfJ+anmw0vYaHdMQ0c4BGs00XW2LbN8
	 6ddX8EAfh7vY6RKKkHp7DvYgkGIMVBrZKWdoWWRDOf9Nj4R3KRJ6CiVWqrt2/Nm420Od8
	 Lhp0FrWREY1yvNMh22bDloZ5m+PnvZH6L8b97tJduo+IXbMh5m22yND6e9WVmPXqGKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=phytec.de;
	dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=NahjfhJu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794923534;
	bh=1l74QYu8VsM35J85WmsDkdNXw1fzbDQkell5lAPZqqI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d2csztjAVcGnoHx5ic7oCiuaC37XhLI34upf91l3En2I5JXcB2TySrt0vmmiLHvRd
	 ZKVMPvJCEgQRiX19jAlizQGu1ghDu1UdcuQuju2NlMpXBxnVaJXgwfaLLJGHgwLRE0
	 o84lb+bUZoX1Z1JyG/oaPCzzmzghu97nQ7Cy5qDfcadhUSoQeWH5+h5gFJ4+nwza2z
	 eLSmDsROXsEnvxuuLeSJCAL8RuO+yVOLq1txwyaeiwyLzAaotkG4HTXXrZyp6ZFgVB
	 877Hwcy++i6bh1XhVp3R7/Jd99xQUev8u+mVSjX2Eep5G8d0rkEW3D/fo4gyiWuF+K
	 xzKluQC0LJPkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB62E81136;
	Tue, 17 Nov 2026 13:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DE681E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43EA681139
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OeUKGJp9J8VO for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71CAE81129
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=NahjfhJu
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71CAE81129
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l74QYu8VsM35J85WmsDkdNXw1fzbDQkell5lAPZqqI=;
 b=NahjfhJuxc/3ffyLdcuBTyCgGXWsAxkriKeSZU6Wp3ao/B1I/GAlhURsl4Lc8LLvKZtjQi/L9pO+qQxqjMsXntbFOcn0C902Hwkb/nDf9Sq98hRHCNjyGEC5I89Fx70BVcKWZdhNTLYzNPacC9jBk5Kg7kdRY6wg1nPOjhA8ctlSEDQZ9ySmJue7eHzgEnLB+qhjh0Dt3W8NDwuMhv5rvJb7SVqtBQVgUP784Jg2vezdpwMG9ort1XHOxXOZ23rvgEs4Lsnlodt7qRR+oHkzwUvba/st0+BLcYccaaRXYKMK8Ph2UpBFZtdtSFfJdcx4GB6CvLolja2q79NU1+lwIw==
Received: from GVZP280CA0074.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:274::15)
 by AM0P195MB0659.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 13:52:05 +0000
Received: from WA1PEPF000099D3.eurprd04.prod.outlook.com
 (2603:10a6:150:274:cafe::99) by GVZP280CA0074.outlook.office365.com
 (2603:10a6:150:274::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Tue,
 17 Nov 2026 13:52:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 WA1PEPF000099D3.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 13:52:04 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 17 Nov
 2026 14:51:54 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 3/3] rockchip: Use the generic /chosen/bootsource fixup
Date: Tue, 17 Nov 2026 15:51:24 +0200
Message-ID: <20261117135124.207113-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261117135124.207113-1-w.egorov@phytec.de>
References: <20261117135124.207113-1-w.egorov@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D3:EE_|AM0P195MB0659:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8f9ce7-f43f-477f-6b0e-08df44b1f68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|7416014|18002099003|22082099003|261009223027099003|11063799006|56012099006|261022075727099003|261021121427099003|261022115727099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Wf+XT2wQjhC3Bya0Szpi1ro98dEKLgM0OVEG5NeawQkwM2AhemOMSyz6ZQVetvQroac5B2F6psXWYYFwjR0BABX1XZn/QL6l6f9prJgm8VVg67/Daj0uKAV07RVHAnrCPdAeLneNl7duqNFLjznqg6YNNaxX3hogWxFEGvNsYJGl0YW1A1NLziYpw5jPGmIz3+YaAi7nzYQxrYr0gmdMu8rwL9Q/NWuS3+O07pxEeWumneraA9y6i9kfEfGR045uY3drm0sml3IZu1uvfGGV1qXxOgc3gOWILmmt4V6gxwNhdDhXNNrPWkD/F1xKWdkp9hGzy1PCgTBKmwL4IsMo9eQ6PLeyXtqDNZRWwAnVlEkJP39zAkFVrf5MTmAqXwd/O36CsBExQGooo26n93EjsValSdAsXZzjulPRML/icns2wvefzPnRCZ8v9g3okPyuy/1ze6khVP5eGk1iwNP1tMfnwVrwFJofS5W2StlKfktKUfmsVQNvXO7NTjjSfKONufONr1BDGgYoOlp58p4HYPoVj2TQo9QGWlJcnfSPuUb0SIr8sdgYf34Cjtz9rjxSdAk6bTCg5iISbrmQK/ML2PXHiQjDhKrQD3Iz75+t55LDx5VY1YJK4GyLP/IO5RHSZNVC/KOLKROEWuXL8KHpMnUdWufn28bj1ocFwHO7awliMaqr/VAmGk6d1LN4B1fq
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022115727099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xL+m2hBigZlcsowY7wK2vkKRqJtGpQRlg1c2zzat5Rb3I9TwvUpME0pqqkAeB+LvWv4mBmGighpXw0D7XshcKEwPI07LR7rJ2spVCR+31+q4FWfymTuP5njkkPD/L6y0yqqcIHuPtTpleoU9oFl4RbOdaYNuM/UHkWFtevlqHeUctvMRsxeWtuvd1CQgr2gdPvElQNlN/HidB6/OWL3lPjQJR0PCoECvSA019STjtF1WmoEsnpuJs/EajOHL6LK7W5CPhbjRVKhwDa0ZiQ+Bo1c7Dv+R9M++ypT/4G1ES36oshThm71bJ4qBn9O3S88v+HRu8p/PUSciry3p8O9Qfz9n9duxFzugxUepj3h4RZgnyMLkzeCIKVgTyAoujXHyVPAzLPpjsPboE/b/HPiiv0KHCQeK5xyrCwWWjW/qPvCSSSPsBEfkrwSiAFc+fRVu
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:52:04.5508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8f9ce7-f43f-477f-6b0e-08df44b1f68a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D3.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0659
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

Implement bootsource_get_ofpath() on top of board_spl_was_booted_from()
and use fdt_fixup_bootsource() in spl_perform_arch_fixups(). With this
U-Boot proper also passes the path on to the OS.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index d2dd5e10935..1a2fdc420d9 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -262,9 +262,13 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 #endif
 }
 
+const char *bootsource_get_ofpath(void)
+{
+	return board_spl_was_booted_from();
+}
+
 void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
-	const char *bootrom_ofpath = board_spl_was_booted_from();
 	void *blob = spl_image_fdt_addr(spl_image);
 	char boot_ofpath[512];
 	int chosen, ret;
@@ -293,9 +297,6 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 	 * Inject the ofpath of the device the BootROM loaded the very first
 	 * stage from into the FDT.
 	 */
-	if (!bootrom_ofpath)
-		pr_err("%s: could not map BootROM boot device to ofpath\n", __func__);
-	else
-		fdt_setprop_string(blob, chosen, "bootsource", bootrom_ofpath);
+	fdt_fixup_bootsource(blob);
 }
 #endif
-- 
2.48.1

