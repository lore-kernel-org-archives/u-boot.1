Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD09C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 11:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DDF876BB;
	Fri,  1 Dec 2023 12:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="tml1JBs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919DF876AA; Fri,  1 Dec 2023 12:09:55 +0100 (CET)
Received: from outbound-ip21a.ess.barracuda.com
 (outbound-ip21a.ess.barracuda.com [209.222.82.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB02687185
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 12:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41]) by
 mx-outbound9-194.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 01 Dec 2023 11:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+XR4O8LeNcwqUjW/K8l8KMO/CAUbwsrNG+lXsOsbmaUwKf3q4NKxctbjtAPvwqQ+SdYuPAtxfmW5PIDYTlxcURrOMmwy7m+Sd4WI3wmr8/ReDiI7nCdo8/jehhEr+KBVx+8MO0qYzWRCvX9RkKgOUGOSCes6RILgJt/MneHskYtt6gmOpomB7DybZLqkvDZyrgUFt1FGIlVcY9p31BX07bBvmGauKsxn7Yk02oFfV9svBLFgjSfaZFKXnZTsT6QKMioHziufcgafLVlRkEVMTlaPLoH0HRf5eOmZhxSHFcGdoYR6o0Z/C2XgaOslnhGGO5vLc+kZRLRo7X4miVDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATS10hpZYp7smbF7HrHtUMSt70pwKEUj2yibuiWAVzY=;
 b=SfWPixxvsasSRsk78gl3F6BhY7XZBVQyPjnopKKfgeCrTSsH7X6HzY4XoQtCrKzADJZOYIaH74Ap4hYIXJqkRwsnHo8uCYDP2vTIUWesQe2hTeesBx0HF/j6iR7NyOuq9wkRF9tfWrI/vaL7A2LLhAhg8lf7bwP83u2beMRE/ARfqQL6XYWV8awGVuL8HmPPN5g9eRR2EGM1fVUVbSEZlgc0bTz0T0bMjCY2ybP1Gf2s/KEuQJWuJZWCjz92tmIJptIU1VKX6OUWA03W3jDdq1dLTTdd1P1DKxY4bHdBVOUuuUA/aB8lIRmCkxmktbY4JgKHcziG1JuqMFWIpsaU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATS10hpZYp7smbF7HrHtUMSt70pwKEUj2yibuiWAVzY=;
 b=tml1JBs9FHqpfoufkcbHi5ADvjgyyJ6Egy0tDZVfZPkzlsLLPFpwnak4DAouLAKtHrulf0ccILdQYm9IEUARBbIl+m+Ep4MqVnEMMOl5jWUbHGhUUVJGrqHzKtcv6znfz/kUz8d0qFaxvJBb8NFvbXwz+BMmNSRP+kkHVe8ZGtuvoZpRrcaiQZKuhiwYZBm8RG3wl4vMy5Xt2J+raH3VIFadNuXNGPULY+xbxJUFXp7vx1Ik216uOsvY7QG7VlaMB4mc4QMqeQlANwSXjlx0k4PBowlJ7TS2E9bSbYr8zzWr2AfWaBXxYSO6PP1fnH5KWFq83f2gl8cyCavvHK7oBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 11:09:45 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::bc19:1ee0:4db1:363f]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::bc19:1ee0:4db1:363f%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 11:09:45 +0000
From: Javier Viguera <javier.viguera@digi.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com
Subject: [PATCH] env: mmc: fix environment on hw boot partition 2
Date: Fri,  1 Dec 2023 12:09:29 +0100
Message-ID: <20231201110929.1758518-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:5:190::22) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: da0abec2-f8db-40c0-18a8-08dbf25e05f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oE8DIOF96ulA0UhfFMzLxSpuilk0oYqFofga/xJcqleYdsq1rThWLWVJhIlWp+M538HROtIQM48kltNSwC405z/is2GF7QEVWoVAj6QRB9OTjgy5IEejJjw1fFHqPzBReHg7hX1fPfh4uVqgVwUJoDnVuxYHmxynuS8SfxHr+FhPdAbp+TKLuza88N9ye4By9+a3agZI25YppxRLXO0s/VWjM3DjRwRFenrBoZJHKp8+brFluB8wuw4BjY/vcmJGqmONB8fBSPdHah0u47XGfZBiqMcljsVr0uk2w8y7QdtoCvL+e3dtwD/UMJKyQQ6zdC/eB3UBIy5omGfDcCgEdmOZqRwwV3wVDJGugo4CiGcEA3Dky8MG47WUm73X9P9yh9Wn3rDZ6X/3hwCncoRvSgEbh9wYontS2b89BgpEoPt62Eb3sfi/50dzZ3K1e4E/527/mZYH8uyDTSOn+2gWS3g2LW2it6XvsgVe48q98p3GMGITHjPM1ly6N06cjp6l1qN1oC6W8T1+QdDlORA8SKpy8IH51GaLoE6pFIFJH8sHttRxWK9M4aKrZDdNpue0R8T+eb+FaC5Hg5XcSyeU9GVNU/GgjOuL70+9a86WtY42B220WAzc4i0PSni8t0pk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(41300700001)(4744005)(2906002)(5660300002)(83380400001)(6666004)(6512007)(36756003)(52116002)(38100700002)(26005)(6506007)(2616005)(44832011)(6486002)(478600001)(1076003)(66476007)(66556008)(86362001)(66946007)(4326008)(316002)(6916009)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHad+elSeQMtVYsOM7FtNgg1mC0ecU7zlMJlSInnNp/B7pH02AEv8eNIDRm3?=
 =?us-ascii?Q?OJ5zjABIxlRY6cb+4I21B3zubqq9Y4XrdJawnhWilUx/MqljGoPTSQzLhu0F?=
 =?us-ascii?Q?oX/T+j4akso+xvgwyrIGM9LnWvLud5iYZUg9BgIePm6VTSEFo9txAJtoD6C8?=
 =?us-ascii?Q?qqIBr2REU7zcNXD1cgsHaYd1cAjmUUL/s2DC4eXmIZHDHScaWGYPnsVO/ISO?=
 =?us-ascii?Q?SkRJFA4DxkK2WaUGfqOsA4h13OPy71DEeA18gH7NfOww1uYDD2QYdGxqXHS6?=
 =?us-ascii?Q?FTJMwOCDjfRFcyg2ZNKryRPFrX+f41laqbTvWrXGu3+qHEyShaIV01jazxDh?=
 =?us-ascii?Q?apvSbY9Dn+TjpSrwR4Mmn8Pa2O2SY9R0G8E+u4IGyRnhWxNQ+SA6U+y5LdFB?=
 =?us-ascii?Q?nWyP+igyk9jyHCHQvQKyEZbECrWhzcmpVgHWDP1q/YI73t0dYT8JUnZemWuU?=
 =?us-ascii?Q?zOpIQfnK9EVEIlIPfulpIC8Y6CN5BrEHCvkVFZYoK7gJKwLywbN7SNmFzI1+?=
 =?us-ascii?Q?uWkZI139bpfn6/f40hFnGblMbIMYtUQ0mqvjmeRTPkOvXfUbF2p1smrOmrS6?=
 =?us-ascii?Q?G4j9BrBKd6D1NjNomHAhbTY8/k3IlGwZIR2JAJdG5M76Pa5J5qzAjM6NiYb/?=
 =?us-ascii?Q?YvirLZqHpczJuhvU2lqcUH+vd5QkZxXdyyPSMC3aPM4m2MFhBT9weGrRWuOB?=
 =?us-ascii?Q?Lc9VTJm3B/KSB8z3yucBO04b1sPhvLwckTH1KRWXgz3Jca3rkQW6go+rWPbl?=
 =?us-ascii?Q?/AkddDj5aqILHSD6a4SvvB4b7Vgv7U9ArZB5YHOFiV34M24JoqfarBz2W3PK?=
 =?us-ascii?Q?fJ93yKaVlEu/lOi09F8g7+tCXLvbT7fqFtqFCr7dwCcAFbaZB5MBjFLmKBmP?=
 =?us-ascii?Q?my6Tdkl+zNXDcM+zRGiZTe8tRW6JxP4McqRSsLwGI98M9XpYQoIke2J5mjGx?=
 =?us-ascii?Q?qf/OXNg0MwEkAA54k37iCBTJ3Q/yWPIZrdkDkFGesxfcVVn4kts+UVfqT3Tw?=
 =?us-ascii?Q?SG/sOfvITPcAE740OPdB9rMwf8j9b5RMl3SxFFkdvlAT04LVHvhZCeyyG1O8?=
 =?us-ascii?Q?TNADSdThgnPI6eEuXlY8dYzRLdsD98L5DVSaVZUW94kQIMCuNFRQPVTb5DTc?=
 =?us-ascii?Q?vsSyts3f9Ee8+hK0BMuS/fKdBqdh+6zl+YAPrwxolU6OdV+eVSfRVG/K2V/y?=
 =?us-ascii?Q?8pH1eNymJ5dGyqmCjKJ1OWFYj4IdNHIcNPjJGFF/suRUo7c8rU+NYP12rpOo?=
 =?us-ascii?Q?M/Nv/9TrJ/zqljgSFnrrynV3oL05XSeIYbbuhbENHKCo1m/L/UMhUbvsS6an?=
 =?us-ascii?Q?rmqJNXwO5VwzGgeIds4nr0pOGXEk4Qn8vRPbbpCYs+eXYkpwHo8DF7y1cgDe?=
 =?us-ascii?Q?lIaW8DKAy3QCIxszMGg5mOd4ZaFKlfULA84WCrbLM12+QpJnNen8EXMuYrqz?=
 =?us-ascii?Q?Dx0HoA5dlgXHOQUFiGsKplDshfw06zaG2h/tfDrjNA11vRa9Pj0+kWZ62rJD?=
 =?us-ascii?Q?jV3IRf82RvjPLN7953H/AMWpwA6FQvAXfNx+ka2JoIXQirWad5V4qMWL5hmB?=
 =?us-ascii?Q?L486Uz5J00f2qaXgGl8O+ljQez3wBQPcZK5L+rOu?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0abec2-f8db-40c0-18a8-08dbf25e05f2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 11:09:44.6708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeZamHlVKipDb978oGG8QUN1d7XVumDnYHRZ4/Jh0UGeauvcSGzst4zi+B7sboB20BFoLtAs+h9DBMT4ZCXrgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-BESS-ID: 1701428990-102498-12363-1217-1
X-BESS-VER: 2019.1_20231116.1739
X-BESS-Apparent-Source-IP: 104.47.56.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaWxkBGBlAs0cjQKCkt0TDZ2M
 Ay1dg4Nc0cyE1NSTE0TUpJTjOzUKqNBQB+8SouQAAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.252523 [from 
 cloudscan11-115.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Fri, 01 Dec 2023 12:20:40 +0100
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

SYS_MMC_ENV_PART is an integer option. If it is set to 2 to use the
second hardware boot partition, the IS_ENABLED check fails as it expects
a boolean, and then it does not get the correct hwpart.

Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---
 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index cb14bbb58f13..df82969d4231 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -111,7 +111,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	int hwpart = 0;
 	int err;
 
-	if (IS_ENABLED(CONFIG_SYS_MMC_ENV_PART))
+	if (CONFIG_VAL(SYS_MMC_ENV_PART))
 		hwpart = mmc_get_env_part(mmc);
 
 #if defined(CONFIG_ENV_MMC_PARTITION)
