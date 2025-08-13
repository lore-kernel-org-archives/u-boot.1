Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F5CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648AE831C5;
	Wed, 13 Aug 2025 13:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LZiVh+4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CD9835B6; Wed, 13 Aug 2025 13:55:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC8083542
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an4SexOtzjQ17Mz0OW5w9KYX5QVVrIzozC+62Jvp04TM4E9pbRYWNhI75/a/7OhFHiISOe3H6im9k3aiKNJyhwa1gSog3C8ZHmVoTtPpqF3Pg8wHaduEWTJSGvoa+m97lzyGhCijR0QOnuuXS2oyVuoQ13Cb9HCDAKEk+L+opAkw7GiNfUCK5WLGWWtOrq1LRUpdiz6OEjLrx4VhIATSkvZUljwk4Uu2N749igWWB6OHkk8AOhOf3VvGZyAjDBnn9iSejPQXZQRHdeze67HXRLouoE9BCOr0d7mjyUZ/+cQ/quTPqTOJb7Mnu4i4O9CrFOhAhC8b3Rf+5bLU+Owxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBe4E9YuYpCygEzjX3XoKlIDH8XARF03jXTrTeBU2CY=;
 b=rWAivEmwVpJRUv0QxRi+cZPJ27ZL2343KCikCe4hli2P06j+LZkOQpW3he+HwpmKsRBTJJYCFNhdDoPNLX0+R1DGEXYSkgJm70yZ9mN5o8yMqmLAtCwtAvfpY9ttQZ2yG1mXYGSNYeoFSyi62QNFS6hZBMySL9TScEwMgOzv07H1INzppOqgHa0lS/H+3+jV6NQF7uE4/iT3TKgKCPQ7fBHOtHwpA6FYs6ZcVme/bCDX7VFiuWL1SCeHa5GhUsGaMK41mpwxt5evId720wpTKvXEJ6NGA4hgYZRGDMrX3uEgoK1a4l05FGME/d65IIfz/16SVCOEbfAb4Yzp+sp7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBe4E9YuYpCygEzjX3XoKlIDH8XARF03jXTrTeBU2CY=;
 b=LZiVh+4bcX4uZ0RrtBnGl6n1BShHVOKQfZo3wbzJr5uJBBgUvYZwLIxXqW5RKuq6+R1BfX9xBR9tNwATw/URNYdHZUAAtzcF/yVI+tfMBM97+G4JgJ2DeNAzw+oPceiy6XdaTJAGumG190acbboum5x+Iz9hov4RXGIv4zbBYQu/DSNS4yV8yXJUOuNu0DME5/meAw9CkpdCqLKm8K1vVJllRgCFY0QKwQOE73n6xFfT/EkOmbumwNEKTk5uS6fy8xfMChzkM/7LuDmWGd3oCe6l5DBhCU6sdeCIlwDffnxuggnBOp1Sgk38nhfH9ncuUflvEfNUnageXH78Gh9QcA==
Received: from AM8P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::27)
 by DU4P195MB2690.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:573::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:55:00 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::b8) by AM8P189CA0022.outlook.office365.com
 (2603:10a6:20b:218::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 11:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:54:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
Received: from lws-schwan.phytec.de (172.25.32.54) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 13 Aug 2025 13:54:07 +0200
Subject: [PATCH 3/4] bootstd: rauc: Move freeing private struct to its own
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-wip-bootmeth-rauc-priv-free-v1-3-1ef928169469@phytec.de>
References: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
In-Reply-To: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|DU4P195MB2690:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cf81fe-a672-48ef-ef3b-08ddda603b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1uNkFITWFUWDZ4WVcxdmNjTmN5WkVvMWJLanhDWlMwK2MrZTRaN3NHeGxC?=
 =?utf-8?B?Q0xOMWREbWhvejJmNXhuWFhxRkNzMVo3QmszV09FcENBamk1R0MxM29NWmpT?=
 =?utf-8?B?QUN1ZTcwaVRsNEdDenlhcmh2djY4Zi9DYngwWXNHNW8vM3ZETHFUZnNFdzJD?=
 =?utf-8?B?ckx6aU54ZjJ0QWFBT3NCVzdzR251REU0RWZMVGtoZ2poT2hIZ0dRYk5ibUwz?=
 =?utf-8?B?RjFscWJ5Q2o4WFhubFJLSWRZdXBsUUFwOFlTU3BBRXBDZW1QV29BeXlXQTRM?=
 =?utf-8?B?eGZlUU1CTklYL2xQWDBhd3Y3NnlGeXgxS2ZLZjhxcGIwMXhjNnFERVo3NHhI?=
 =?utf-8?B?bUV0MzloMERPWmU0b3JkNnJJNE1KTi95S2lSYXk3OWlGd0ZnUTAvL3oxaTBY?=
 =?utf-8?B?UmNLUUlzTG5rU3FyeC9Sc0N4SnRQSXFUQkoxTUFBdjhFdW14L2Q4bW43RlYy?=
 =?utf-8?B?UVhjcXlkeXp1akljRVN6Tkd4WTJROW14STJ3TVg3T2hCYXVFMENqc2dHb1FP?=
 =?utf-8?B?RS9VdUs1K1g5Wit1QWM5R2JlR1plc2JJdDJIclVHd0ZiV1V4aFJ3SmhZenhM?=
 =?utf-8?B?ZWZkNi9iR3I5OWdGbGV4SlBHbktYYS8xbXZTYngyV25lWnBuSGttUXFUMEMx?=
 =?utf-8?B?c2dYTUliUHVNV0tmbXR6aVhraWtEckRIeUxkSTFnZDlWZjlSMzBmdENpMGVE?=
 =?utf-8?B?MjRWc2VaZ1VDRnMySlM1SlZmVHFxNE5sRml6ZFRJVUIvanBMNVdab3VMbVdP?=
 =?utf-8?B?emZYOUJTbDd6SkdoSFBHREpMYmUyOXptK2hickxGaVRPZDU4RStwUG55ZUFy?=
 =?utf-8?B?ZHdreWovdmx0cUMzRkFYSXJJWFh0TEFUUmYrdFYrS2hCRnJHUDZlRGxsREQz?=
 =?utf-8?B?TGJmSWk4Y21mamVhWGd1MVUwTVBQYlE4Ynk5VkdWK3RGZ3l0TTQvRDI0WXRx?=
 =?utf-8?B?NmZyT0RvNjg4aG54dnFrSnM3ZkdKck5rQll5eFF3c0NkNStGdXdCbmx5WklL?=
 =?utf-8?B?VDEyeEt0YXJlZnJpL1h2cDZ2UEZ1T0tWMGdUS2F1VTY1dkxERXIvNlA3WlMz?=
 =?utf-8?B?endHb0tSeXFBYTg0dGdGUWY2ZCtoUERxVnR0blJZRWZCS3BuVzNPSWZ0WGVL?=
 =?utf-8?B?SGt3YWc5aTZFM0JyUjJkbk1QaUVxc1JRamJBM2FtZExoRnFTYWtFYzNhNDgv?=
 =?utf-8?B?VmtSWUN5WUpQUytoczVjVUNNSjNySDlDWlIvQmhxcWYwdjA2MXZycXo0QXNS?=
 =?utf-8?B?NUcwS1M1KzBkU0drTmlMUE5uS3hqL2F0SUNPS1BVMVFIODIzM3k0OGJCVmVI?=
 =?utf-8?B?WmZQWFBjZVlIMTh6aXIySGdNYlFSOG0yWFl0bUN0aldaZy9USW42K3FZM201?=
 =?utf-8?B?WVU3NGVRNzZKZ0Z3T0xhV2h5YzdjOGJIRFRtSjZldFgwb05JSHF1THNha1Zp?=
 =?utf-8?B?LzAwaUhtcmxxSGhsUmRNTC9nblU3ZWNmVEtaMXMrNFNFdDg1bnl5N3lOYkNM?=
 =?utf-8?B?cU1kZHpaaFlJSVBsMjhhclZ3TGg1dm1aNHdBbEZvKzdZS1lpOHh2RUIwekpM?=
 =?utf-8?B?NDJOZEt1alU0dGtzSk1OcWtOL1NyWXgwWjh5MlNTVFpSTTVCTktRVldyaGVD?=
 =?utf-8?B?WDNXV2trYkdNbVZrcWZSbUJSY1NWVXBvV2xJUWVZbFNVK2w4Vm03ZE5CTVZh?=
 =?utf-8?B?SUJxMlFuNEFaQjdOejRkVTFGRXVrOGVPeU5HSXpYN2FGQzArVkdlMnpJZVFv?=
 =?utf-8?B?YTlEUGdEaFhQU0NLY3hmZkdHdUFJZjR6WmNKY0lrL1RrR3EreHZaLzJxZGF0?=
 =?utf-8?B?Y3VvNTdZc3ZkWHUrdGdqZVQvajlsOUxVdW9rUW1rWkp0eHUzbWhXQ01EN0xM?=
 =?utf-8?B?TUJzRFByN0pBSFEyUzQvTENZSG5PZkVKZ2R6d3djNWtwekVqRVJvbU1IZ2wr?=
 =?utf-8?B?Um5QWDJJK0JMWk51RFFtVjNlSCt4NTk0V1hUbGNJRXB1L0FLaUcveGhseU9R?=
 =?utf-8?B?R0tPUy9OZ0VUODAxSGRQYnl1dzBkbHRpY2xvR2Rhb1I5RGJhY1orUFJGZzdG?=
 =?utf-8?Q?jhWNzR?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:54:59.9903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cf81fe-a672-48ef-ef3b-08ddda603b22
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2690
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

Move freeing a distro_rauc_priv struct to a new, separate function for
better reuse.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index c8efdce75b9134d1c329be40a1eecc57977ffff1..f781a7fc0b5153b952afc8da38b17d93e073485d 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -52,6 +52,18 @@ struct distro_rauc_priv {
 	struct distro_rauc_slot **slots;
 };
 
+static void distro_rauc_priv_free(struct distro_rauc_priv *priv)
+{
+	int i;
+
+	for (i = 0; priv->slots[i]; i++) {
+		free(priv->slots[i]->name);
+		free(priv->slots[i]);
+	}
+	free(priv->slots);
+	free(priv);
+}
+
 static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 					 const char *slot_name)
 {
@@ -187,11 +199,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 	ret = distro_rauc_scan_parts(bflow);
 	if (ret < 0) {
-		for (i = 0; priv->slots[i]; i++) {
-			free(priv->slots[i]->name);
-			free(priv->slots[i]);
-		}
-		free(priv);
+		distro_rauc_priv_free(priv);
 		free(boot_order_copy);
 		return ret;
 	}

-- 
2.50.1

