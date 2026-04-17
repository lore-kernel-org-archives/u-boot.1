Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B8EF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F9B84286;
	Fri, 17 Apr 2026 15:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="D0avr5Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53A58422D; Fri, 17 Apr 2026 15:02:19 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA00C84308
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJUaRNtNhelqC84QN6BrgsV2Spee6vjuwMUl8wFkF0Y1+xVfa7xC0bfpoBRg4gTrJB02Pj5Gy+Uss9TUUpF6XTqZvnEBYx5hWKvDGrLThIsFVEj/o/UZzdcWbkmhRJ8YBK3waA1UeW8HSD4fLA1LsL4wdIdfRvILdejjpJkK09yUvF7q/CQ9CYaNppF3ez+3gSIJ0zV/rBZdLZIVMhYzLc80skMD37nyY++PCBSpBNzbwlcuLYgfT/ZNbkhBfolmFHQ0ohNEU2JeBMq8SFeQYYiQxB4FaT/aKYk6HaUX8jop+dS6WfCdTjjIyR8QGg2o93yRX3mzaYjxiao4Ln+r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3BSbxB7gZ/qROP/3M3gt7H67bc5MelqIUHYJCp38qs=;
 b=wR/xYwWhac4Jt6Jur3lqb3s1FgF52zNNd7QYVfzCExOVW+hNj8vPMmgD6Lz1Q7tOWMNsqmLXZhy6aRKMRWkheRO9EaaRkNMUDPg2/1rgUyuLWahFvWSts42IUhpemnW0OuXHSsn1eaPUTeJaN/0+g1HwRjp7i2xmsyaUOaGv0zbjHwOV1b6kRNexfw6l0Qvx5eYXFimzy1B4ecGp6UZU0e/bRQSscDwIPBireguqlJUn1P4eOf3ZR9Fg2Nycjv/5a0owtnz4DBJRgFo+nroh3hyGtxax9uX7edm0cBidH9E6gqOXFNvrYb1t8056XGE84ekuANwsCo2m6H2MgcbBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3BSbxB7gZ/qROP/3M3gt7H67bc5MelqIUHYJCp38qs=;
 b=D0avr5OkYyFb4JktZ7Ie29xC9iwMWylehexrPGCvv2KloWtiwXRcMc4FJj5IKhyTWdG9DtAJkNjBx/zaBdMc86Iy9AlD+BfrmhiFtvQdjUrNfOfILwAKgRnqqDKxvDlHEWoM2UlzhD61WX0urMmBHKuz98Jce5kzu1lzlStJVgvWMGHNsJZx6SKWSTlTIPU7amJJqoaS11A867cxjyh9HqUV08vZ5+rC2/MQWUpczAz1MHFJFKs4LvphR6wx3pQrtvB5FRctNTgupnLYVGjk/LkebCR4Jir9fc3rMlaV9PfY6rTJA7FyXDMJH7e3XXcR8OHHAowdF+s73URAQWbE2A==
Received: from MR1P264CA0093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3f::21)
 by MRZP264MB3244.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f:cafe::f2) by MR1P264CA0093.outlook.office365.com
 (2603:10a6:501:3f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 961AA20C30;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 12/14] tools: preload_check_sign: add support of ecdsa
Date: Fri, 17 Apr 2026 15:02:02 +0200
Message-ID: <20260417130204.49896-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MRZP264MB3244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4feb6220-2fe7-4fee-c154-08de9c8189c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: w08u/SOA865aLxU5fXsbH376+IKoZv2sfXJawkKPZyMDoC5fYxSyvMdO+4MxiTULAyLX128zyZT4rTkolLoGiPKLwfDfU7v6yOQk5/sc6nCb7VvwPG8GKz+6FNQXd7vAii4aC9cDsh20DRMiRQDYZU4ZZBEuS0kQU/R4O/r+Gtimq+xjJgTLG3GQC95UsDtoRFfst/gwdJUJzJFFKgnSkczyzj8agsPC9B1oWsqAuhHRW466oNSQMzBhS8hzU71RhR/HLTcPFp+pVUHhUxvzufLd9sE6Z+F4QDss0UOmLYq0X3goqW5BZsTUdZnZj9set+h1Ys6EfH3aVA7etiRtMWLWr1+PvE98MSuURHmS6Uv52UfJh3qG68+gln4LWTOmfnIhXsXqApQzvuVcsAC3bWemrXR6JLtiy754vjW1M4qrIiOBNzCRoivr9wmSeIOmv9X3WDDjJeEtbon0nPT2cyLYsCzGijb0+wnNTHbcKa/P+Rp6T4bWtsSoTy+oHXZ0kJlj9HTdDkbcWSoNy3759OqGGov1UtAvvSJy0o+p5v0wy3F3AuX1SjKcNOuGbx8rR3ZgM20LnjAfO64q+ZI74ki0sx3nDGFT7npqk2h321Gu7uWnuhf5CNDfmR31BDTqKOUcpPESexGnjg3tFsNNgRfz2E7t84Vz+owV0Kz0mKBaVm/08/zNLP+z4pxOBAfs/pUrDYZaPFhUCgCFyj3mvF6eDyAnh20CMLjFQSxUmGl7c3XKxi2cS1X0YS372nyjX2s+UtB85fDdzt0Bj9kbQQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vz9wqq2eIwyVN+2d10jdCeNpWzGXe3UgZmjnrjmpvxQr/rFCZjsg1pzHLKrYPNGMuFR8p11+PcRO3Dog0OCAKLdlYpaxjo3yMauWCLEK2WnD6qWs5VmYsEmUT0UznIW89tSv9QbFZNPrbX1qULY+P2Lpvb3uK5bgpbrOLVwyinXI9uo0ky2BL8trr1bU0C+HNF/C6LhZvI+kbLCQ59UdqG3nMo1fy8V6xQ/HbxnfnlTQG1IC1ukdwfIQN9qKfFBjX/Fedvap2jHeYZo86sQfFzaR2d2ZFUVmprq4jb8BjsTL6jzDephkW8fcGTElAnc7ULYbUXHROshbMBvxIKYJlephwiXd2o9zWmvjGpNL45feZI0yaWZ96SqeIlqHV4eBHEejl2amDFHDTmUWIr80OTP5cFlZjpIW88feONHCWxgsGv1O2+BkSB6f6ZNQDTzw
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.8401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feb6220-2fe7-4fee-c154-08de9c8189c1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3244
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)

 tools/preload_check_sign.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..f74cfdd8671 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,6 +8,9 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
@@ -144,6 +147,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0

