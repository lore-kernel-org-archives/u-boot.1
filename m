Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAFEC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3F982B00;
	Tue, 13 May 2025 14:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TccIOU2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD678091A; Tue, 13 May 2025 12:20:51 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2640580AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5C1uR0VwsymBVKUTH1BxVBEOiMmuKaikSqpvnQnpoCcTyZOddg0jG5NC75/PlyHWvcgRzTuEum0KUfMi9gffkkF07mqUoADUtLhJ9O+wtz3FlLo5JKFE3F91sMXC4XI8192KtAX9npzlbjyxgNWDlOtMnfuz3SrsARpyVWV75bFUIwJTgLBRp1fhtKygjs1f7oY+Ar0uQSuN2iD5AVp5hjtSvp4Yx1BDqTKQuzX1qA604ArgNRUeVa8IhluH1FqcB6s4xzqNrHyTL9lVBe/o6L2cE72bNeaekZyIU1GpBtj27tHtkBifhPHX24tT4pSber2HM6EAVLiYj3Jcj1j+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mbjxQNSCekcTqcMR5lrb9OzouWN5UCs0kpzfipLKo4=;
 b=O6duLMZP1m3hl5LQo2SoPcXs7ch8Xtwj+kwRzqq/sapa4HatIy8hwop+Pvm20rh2lfKeRUWHKCz6JH64SWN0LTdZKhHYiZDcwpFq1JXcftg0pJ0dOViYWanAoR+pEsvIB5/NsIAp2ABQkRsPJgpYcU3Cspc38N6Pr3gVSX389LPP64gnb5MWdU9XFzNT9bIXJud9h62xbfnbBL5HOspjqWSOcDeUa/e23+yaUysSPCm3lTj807o6v93jBRyq9LOhCrKAr3SgKNY5epZPIlkPHFrOIBAX7qpIPGQ58n26PO8CkjpPTwTqtuQ4yErtw3uQQ/B2k+e6TRuEALrNU/vkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mbjxQNSCekcTqcMR5lrb9OzouWN5UCs0kpzfipLKo4=;
 b=TccIOU2Lp4mVC4PLAs9eFlsNBkoSmob8yITQrSJtGHAMwlW1fBBF7H3ho1zEYcnoTdrXuTcUL2mn/dlcgFAgfn2muM7ceWmVnMQzQcbafcdUTAFk1u+PCGSwYScUsJ/cQVVz97EBb2mL0dIa2UBS95d7zXgg+R32GOAins+5e0U0r5tT8jY6Jfb15gOxOIRsdm493b7hBPt4eJAvD+i1s81fUzc/sb8cNpQgfOzaxn1ojybWFN+F3TrTyMhmGwnJ/OiWRT+PZtgTiz0BxeYoFx+XOywusfqRgWtNZl/Y7WyjTzT5Gh+dTZGtir4oI0ekzcoyZ13NumZnCfaXpg2F4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:47 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:46 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 07/12] drivers: i3c: master: Enable probe i3c without slave
 device
Date: Tue, 13 May 2025 18:19:08 +0800
Message-Id: <20250513101913.30880-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bedc6d4-3dfb-47eb-a125-08dd9207d372
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0R2yD83sOP4RvuzxN8VlqaPZDBHZ4o9NZnRU/uQKmKqX5rnlHavCIkC01vO?=
 =?us-ascii?Q?1nkK2+Ju7nKpg1A+ErTOr/nyeuy8eM6gwyLLT0WdL02opwDJyQfU2hYCLyXY?=
 =?us-ascii?Q?/i3EEXBjU4mdmrQJ+W8PMDnYiRJ/K0ZrUjjZPxzkZ+q7CNqYyw4as4NO1WRB?=
 =?us-ascii?Q?vt3xaF7JgpgPtDGOZx6KVqrMyUDiXdLY0z3SJ+KOKu2ChLgNWPlrOR3cK9YE?=
 =?us-ascii?Q?6rsOcnFmvyA7JDOTkOP8ZGrCdcxPYOLFNsA9fcnyuHStVbmByJFgP8uORAgY?=
 =?us-ascii?Q?F6nbrp8kCtt5LKS+baObaK3+ver1/6ozKt90BkhXwItoY8zn+Tkp5mhcMBqJ?=
 =?us-ascii?Q?CjFFjG2j1RfdXxWVFBj6gzgIanVxm5Fde8R0NnjfaVSHYh9v0apXA0N2ga4X?=
 =?us-ascii?Q?JJrGpSwzP1MhjceCMEzU/u4N2wXpH01KR2YhIk/VS5GbbZBuWiL/m66Llz9A?=
 =?us-ascii?Q?FTC8MxBMYkA6UcgZ23QY5fq4rwym6q5Z6mcYI+N+78EPTgfeCoz4P23ZefGt?=
 =?us-ascii?Q?yqmE3O9Gy5QIxiwAj1AT5jAINNz7Z2NRDa6qOOecGPtq7YnS6AzlPIg8ttud?=
 =?us-ascii?Q?ayYVPuRILP19i5PYxJJO3tSVtb+Ufj8jIAnhpApusHMnSa1fa3yjAD0OlEU/?=
 =?us-ascii?Q?oK/sdM9skwi0YJn56dOgPY9X5daDoZVM0QgXY9Xq6FUnarKR39PBbJxd+P5x?=
 =?us-ascii?Q?eCQ2pmiF2n8bXWcmLs4FRUOUvoDQn8fYnY/R/92CpKV+i9bpub3SFGG2ClsT?=
 =?us-ascii?Q?/yoXBzGMzOx7KWhBu/S7wgf7BewZVG2ktgmWhcAgWdEzvIkvJx+5yMNN/4+4?=
 =?us-ascii?Q?ct39Z/kps4J1ARJ3QUvXL9dSo3oANeqa6SFaaDFFaOpRVZwGVtlRLXvqh9b1?=
 =?us-ascii?Q?1arM/LKlyZSNezkLZ9KzGhkXSRxi1MYWJWTlPPDgXrood8c+mmndgwiDfRf4?=
 =?us-ascii?Q?u9PasGYHtTXb9hauca9dwukK4RW7SenRvSqpmD51dCRSgHSDjV7J3f7TmTHc?=
 =?us-ascii?Q?gJzMutRKzHvXDCqsnOzxciAm/m/OB9hRJJhEx5nbl8rKBFl8yDQWJg0G4YUx?=
 =?us-ascii?Q?KiDGXEG/wid+etH/oTB5dpsMDf7di/aMBtdl1bDyobKI3I0jVYXfl9uqsEsO?=
 =?us-ascii?Q?hpWIT9wfees0RuonhCoZzq8V+RJPsqV/WaQv7z7R0tlPRpzhLS0boUJBANzH?=
 =?us-ascii?Q?o4yfqNVlpCxn5nxW+8XT3dGGIirSCpV9o/c9uWTxfasCIvU2Nr1gkGy6lRmR?=
 =?us-ascii?Q?CGMgd+mX5Z5M6dxvToKorI8fv2MhujdquOKZKJJmOmoCzfXGOZ1ABgBuLSnu?=
 =?us-ascii?Q?SZRI3p0HKjFOpWT29BzjcHL/e1jBWil31ZmeOIDFtwtosQjQO2HwgI3Q7Kbk?=
 =?us-ascii?Q?wKio7HIQnopVNa308mgRt7t6F6BNkys9azMh3O0Y8uNG9aEqKS124DOuRhAn?=
 =?us-ascii?Q?NDF3FzSU9d0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8QP+X/CrKhJZ9eSOySqoW5kinkqZ//YhkAqIoiYtrg8eNvinIiMC3jckRrQ/?=
 =?us-ascii?Q?WPPxRJQCEjpCZgHplgVvtHntDGzvHgIOzRLh685/DpTKn6+V3mdU4K1imztu?=
 =?us-ascii?Q?zAFbg3I9Ro0S2J47tycxkM6qcUA+x/rF8EXwcoCVgNhrYQpLSpngTHhKOLew?=
 =?us-ascii?Q?fqIh2tUSfc49YCCsVEAIHj12rWMUlUpPKS7fpWSyMKUGgtdXPv7EM18jZZex?=
 =?us-ascii?Q?cmw9B6cwsUsHNIBV8X5j2F+ctB0bIHmYjTtnzd/keIcZpDRIOwzTJhXBAQBr?=
 =?us-ascii?Q?09/tiOTAcxTyg7LZ3HL1bdIyexDNous/FgXV6zyFvO39J0UBCDMOnEpbKjZb?=
 =?us-ascii?Q?klgFpsB5rCgMqWFqxIwhJN65xT0xSABd2l9rFFrJObJAb/o/fQ0Ti5h5KsXa?=
 =?us-ascii?Q?goDIO5JoWQiisTB6xhWkmuYw1OetuaYCyb/TMkKBC57GlOWW9tCErUyYzq/w?=
 =?us-ascii?Q?jWsDYRdDqshflx+zUICYs1K+w+5IET1am9j0YE+jbYwBCKCZrf0RyR5wgsWc?=
 =?us-ascii?Q?rfb8BetaQNaQVhv09lc3cOjT0xmsmIYg7LScRZ7PSefvvrm62njVPuC6LKwx?=
 =?us-ascii?Q?BtWRX3SanBcYQviY0ALEkNQzTs/baNIM+MbZ+v6sKF+8MAvUQ5Yx2aOVeTfl?=
 =?us-ascii?Q?JmpZa1r89FuhWmA2HP2UoVYX7BXml1KBCp9EiybgI6FkvawyCHwVM2edAwed?=
 =?us-ascii?Q?oEq5mwMoZDguopaecc7+6uw5ciBkifpjORFK7PC/WgPYKnYJsV28ZgVPuP86?=
 =?us-ascii?Q?N42lI3+QXviNfUsVLlFIvN5/9CFKi6ulBNweBLmDnsoTiQ0DyBadZ0th/80Y?=
 =?us-ascii?Q?16nFSC5NgHuT5uYz0NRhaDjsWdt4ZCWGiljS9o5ADkg+XnYsGk/jRiTTF8/a?=
 =?us-ascii?Q?SjhYbXv59byQ7XBJhXNwCd8C0w75QlndPqexfpcR7SwRxrO0BODcCBvQQLuG?=
 =?us-ascii?Q?bYKD/bYZqd323gHFntlUPY464I8bH1yHSoNtx7jz5vKW6CsTmFk/Fj43qrFO?=
 =?us-ascii?Q?//IE+cl4nJXw06WD6HcJ5bi2/7USGnHidlh65aTKF8dtPnfelpZaUDLv75f+?=
 =?us-ascii?Q?gHM9wycwjtXIPfUCrs3KB4PG4KXbKkLA6+gYhc4/WQ1h6irhqKmETdFv5hV3?=
 =?us-ascii?Q?uu0s3qZDR8chlHT1aC33h3tY93GJHKsqPLgv3H/MkHm87rJG5qygMFQvxRvu?=
 =?us-ascii?Q?Dy/VDud9JZvZ5FyS9Wd0XEGFpanwQLEMGqQ8hkPOuV5MGuzJ7+/INiO/Vf5l?=
 =?us-ascii?Q?900jpLI0G+lqYAc3znt1Is4VfHC2A82BuevlV4JNLtKZYKBhCgKBWLEZ6+kP?=
 =?us-ascii?Q?foNkHxSlS3Zs7SbJKNdYhtSSZiqt0mVqq9s0EIAfEx5cJnZkJdxfD5IxfaSB?=
 =?us-ascii?Q?1Zyl0AmjjaWHnN+/npT5bBEW3OC06JnCZtC/W+2etusxYdBYImuYqmm/HszU?=
 =?us-ascii?Q?1xBxlstkuUzS/6unKa7xaCSXCb3NayP4mUQ0ForwiPyU05a5rGe2yQA7D/vz?=
 =?us-ascii?Q?gY6O7/V6Y626Ix9M+DoIZUi3VCu9xzMtARca3HrHJvbJjs5tPpa1xcbFE5Fz?=
 =?us-ascii?Q?IE4Fqn88YeLoFt3PzSkUErW6VqAOZne8auANKoXPfgl3GYOhtNO/wtStOLUZ?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bedc6d4-3dfb-47eb-a125-08dd9207d372
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:46.9221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EK1mhieNMqFnAt9P8nc6np5whfAlG63nrIV9+XEQIhIy1iUCzfK29DVq8P0pQZXuU9lDfjsaQk3Vxd8+ROErw5cLdXmaDgiN0S5egSWTDgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index fe12a2a1b46..909d650e951 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -452,6 +452,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -507,6 +510,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.26.2

