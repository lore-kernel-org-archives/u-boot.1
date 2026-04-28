Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC22FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67BE845E2;
	Tue, 28 Apr 2026 10:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mBC+XrUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B2C83693; Tue, 28 Apr 2026 10:46:46 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70828464E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crbz0FjCkZsZm1ffKE9lF8rHz0YtrRHJNiEmf/GrwIM84yA7JF0lVkEDFpKcLSfSw47XQoV8SiK+appq9tzLMMdWJwdPWC3YLbFX8Rf91yYD+5oLjMf0d+mT+fMK++hujkmOaRQtUzAVfGxm4TJ68tCMEG726+hn6riuLfoyH9Ag5wup8eabUDdb4Y7GLTH3/xAgYxdVU3MW1b8ERxYKnVXDOp5ejYI/yZKV4jYbx7ciKGbewIVuj7+428SFoIlYb7KVar5r/JL8Q18WcFytcuo0LX5GumoyW1RHaOwpn4J2KIQiCn1VTaUP4AEkJl4CWAtk6d20aqgJM6IzO7kQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l06DIxvBQlMTUwZXvQLPPwaiRL2V1LjtdjqOy8FcGM=;
 b=cYU4Ng7Axvp73y6T580bo5t3O2R2n8REMErtMR00NzfjWdZpO5MfpG7EGc82Xl7kCwC9Gv82OnN1b7cjdDZZqIFoUzg9/sBu7Ra36kNLP961E1RkeZ7iJOp7mgRQejd2fGobykmGh+cimULnQp1mK2tPZZQMKwNH5edJt3Y7FKVCb9eCITZdSaaY9zo8Ums/lsQYztdnOpkE5hLCf6Kf7OBqquw7toG6v/62QAYWXpk8wL0Sld7wNDrSl4ODD0SuRkY+JexB0FtlDcd2gfNqCNeQrm3fVEh9MKmrOv78DME3BZTveJ2yjCjGgEdAyfSO3mYcysUDQYlNknTceWzJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l06DIxvBQlMTUwZXvQLPPwaiRL2V1LjtdjqOy8FcGM=;
 b=mBC+XrUdCBWPnPxKQYmE0MO6SkJeVyh2dJbRTRrziBk/U+MgHDZkjaVsWOeZWf+EVlbFICMEwnnsmYRCiLGmdbKJx7Wq8gDNKDEELkj3406Fv3u8bUI3hUVGqZtL5TwyvHU/806LHTrQxYi5WcfX4AILacQV3KRQmftM6/h+v9o=
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by LV3PR10MB8058.namprd10.prod.outlook.com (2603:10b6:408:286::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:46:41 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::20) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 08:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:46:39 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:38 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:46:38 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8kSTN615433;
 Tue, 28 Apr 2026 03:46:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 05/11] arm: dts: k3-binman: Add template for packing
 HSM firmware
From: Neha Malcom Francis <n-francis@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>,
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260425033742.1519298-6-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-6-b-padhi@ti.com>
Date: Tue, 28 Apr 2026 14:16:15 +0530
Message-ID: <177736597530.3159199.3152523537066588953.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365988; l=656;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=YOpQGsN2Q5mbd6dlc8QKEoJkyEXtqbAJ9+cmAVtC2i0=;
 b=IEtkbIkxwfebbY7FGZZHjfQw5JapO4bJRqMLvWvI8Y4TmnCDWvkOMg+AlyGI5ieWq/lNo6FUC
 NnkIPCIH6tCC6qIORG9sJfmdlqBNcAHA58npjmnwcE8fMhfOzaL4ncx
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|LV3PR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: c8578907-9ada-4ff0-f166-08dea502a9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yLfHiPp+pb53A3eYc9SB04Gg8HauQ1SAv59RTq6cc5UuyfrT9vfaM66Bzk/uApmjZisdDXKziRTeQWTDXOw4UOevcEquiPwtpR7VpdUqc9BwA2BahZLvtD3oMDDa13Mh9HeKraBlmF34IL2ziC+sefQpUdcXmDsnD9IksflzzmAd19BBMTKhR0GKs+d04jof2yq/Wa2dXmcE+ktVZI1Mq/IWKHzmk/IiqJleJSsolzyYYECcjPAx1Wvsp+DcvhGX3SrRQn+i0e1rCPcMQvs+lavRTclALaq0Vc8jIE2kbe2D+WzRMf/XAlskJqbZRb44u0GOUPxyXPaM7BOE5FLk5uBn6hVcdefP+z9cfCDfH3WtH+wXwWsd/ShUAw9QVfzIbOVR32IXYDI4Lwm+Uvrgzpy5nYZda3mZNN53yi3GQREkm8tnRfCcmRnkCyK370Y7u+3sb5ZIdryiDHTxy3VomSyDDf+v4pm7VEnA3lFs3a/o0GGcuE08Vv1nUDn0f/jzDOT/mPWA2YZZtx5LvZ2W08tchUEYygCs3EQWY3iGI9NuzaAIntZQZcSvAr7cxRbWONznSvuMDZFOW9/iykVuU4kwD8zAMcZQznPa8YRM02iIFm5PVXMk+cxgGVtYCm6qY7zU9BjECKu/c1b2yJ8U2t/BDBuqqgw1Z/PsyaJyc40MJQYd5QNisF1LKNXnoTlzkAVTxR1r/RXstxKzV8+13vSAWWwtad6uIwCHcJgrJqG/BR/a9ShUcLuT0zqS44aqo9Lc78Ln6b7Au7amNozcqQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o5KDxtktgM7Hly0D2jDFkhegngsCY0KFrQ71nZUdIrQZNjRiuGwDDtTHHUCF+Y4HJvtWVjcvAvZVTpbY5HG/FhtQjSwOxmwBxzwuKc4sRw7/4Ii7bMPVfPdc5uYqVBKDB3QAunGP9ikWhkRlWW2DpalF30u/ZhuHrWnRMWuagfgw1yAkv63dlFrTZ3l4YDs8kBJdyOBqeP/fCytbLm5+tCc6r/WJpRBY5hy8n3kJ90pHhTIrm4cCL+KzEBEUkGxZMl8kC7vX6vACmSBL6eHuWPKYhumBk8SlaGFFHlAifaHO3KI+Um+TdK7nUJPjLpQhBgbrec2dHGOypC69e71p60kKBZU0Mr9e7al2gPXj1QJaj4aFTrn4VtDV6DnBYjORCgMEHtq3GgnH8nZdHCczJf+mgC2a6HwcQuneRnsfOmj1owxF7LI6O0xCaZ8Mq7sR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:46:39.0037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8578907-9ada-4ff0-f166-08dea502a9d4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8058
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

On Sat, 25 Apr 2026 09:07:36 +0530, Beleswar Padhi <b-padhi@ti.com> wrote:
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index ad127663d03..e6bb05a0bb8 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -297,6 +297,26 @@
>  					};
>  				};
>  
> +#ifdef CONFIG_K3_HSM_FW
> +				hsm {
> +					description = "HSM binary";
> +					type = "standalone";
> +					compression = "none";
> +					os = "hsm";
> +
> +					ti-secure {
> +						content = <&hsm_fw>;

This breaks bisectability as hsm_fw is introduced later in the commits

-- 
Neha Malcom Francis <n-francis@ti.com>
