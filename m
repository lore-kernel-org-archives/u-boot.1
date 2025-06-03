Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC4EC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C2182D3B;
	Tue,  3 Jun 2025 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="AYZQWuBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D445B81E72; Tue,  3 Jun 2025 15:40:28 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557B480F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzcKT7N6/zJ4Vk88HtigSAHYiCMoucBs1B6c8/MRrhJvcIkbf/OZyzq01u+zYcgVWZCQ/E5a35y2MSA1K8Zt7JrqN6nkdIfRPv65eL7z7CspqE37v2sz6fW1u+hZDUxnJ3yMinMZXhaOxaExhCpwVmV5s/nwrHMQO9boyxy/AnXLEb5MpVd4FnWPaP1c2wkBLeJ+p+BzyQG8DD1KIjfAdGO1JXiIhZg3K95sTpTpZWRDFmzrhQnl00in6mNvIt29JorSYSCS1TRv4ildUJ2ZFf8g1YxxfWzn1oS4+Dorgj+Rx2hYup/+srKiCebzY87ECa2j20Gfd76D+FEqUd918A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14A6XQMUNxCKA3wVaxFIquJwuGc3vYj1GDRpRkZxqZ8=;
 b=ZgLiSczRChLu90Yxn2fHBb5UmtzvRAYYaPVRyAdvjiVMUPnPQyC+D4CHKP7yF2B6aLzeLby/2ziJSsptBB1NkiKfI0cDbaZuTAdll5akPnthNm9niSEa41BLzNHUP1obgiZE39CamQWmzbtge+89CdrWjgOrxaIqvK6qkjKSpRH04NLdp6GivtY+h6VQG38HQbt6FAc6K8HPVtIhnCDBfpoEn2Nh1luU5AMgftEVK/gHe2CAsBHauivVdDgie8i8nwAOGegVZ+grStId13y2rooykMiKGDJUH073CWHjL5EHnL9wS3s9mRV54Bb847/mRvVdMqqvF77KL0W1+3b2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14A6XQMUNxCKA3wVaxFIquJwuGc3vYj1GDRpRkZxqZ8=;
 b=AYZQWuBGjehtAIb6pD9rl/MGRQQc+B798siAsMxOaOYbgJiyLwyicVau/OjLkdfinIljDzhsQH4Q5UTeBvYybbSGlqyx0BK8X6YIoTT44IfKX9suKFG10ASPi3OxgaJoQVLBCRM8Qiclb336jEbz/MkwFPRbXzBc9hB5Dl5pqHK2bxHKKFAVatLhsQJ8UBja+RpjQsSEzK8iKoEIdONre9iTG2WFLJ5UODIkvBw9UOEJLCZWEdqvghQL54HxcsrsnZUZV1EveSxekZHfrRbGI/L7T+lwJ1M935OwO9r3EZrZGDfFVMqdE7swtzgAGx55C4BqArluE0mpcWybebdFWw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB4PR09MB6623.eurprd09.prod.outlook.com (2603:10a6:10:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:40:24 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:40:24 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 08/11] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH 08/11] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Index: AQHb1I0OjPuoAKH510CTiWbt+EZVuA==
Date: Tue, 3 Jun 2025 13:40:24 +0000
Message-ID: <20250603133744.278790-9-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB4PR09MB6623:EE_
x-ms-office365-filtering-correlation-id: 4aba9cc2-c17a-40e4-4ebc-08dda2a4317c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Jo8LyFCsOH8svqJe7YKkGx2QYiYorO4JKLJKcSyLq2bwqr0VTW0nWTvolq?=
 =?iso-8859-1?Q?8VXi2j+t2gh1DvlNCA6+V5G5JaAGEKoBpa9cIcwSCq/GUApJTRfnCNzrb4?=
 =?iso-8859-1?Q?fMVwuWZWkCsXpQMyjbeN5WU+8XTWsgDN55KrKg440Y2KJCrrp1UzzfvcP7?=
 =?iso-8859-1?Q?h9wA8HKsz/cHdbSQFMo1IHVl9DD0WgFbeZhQ0MknnSrGk6Uf5Ll6YIYvEr?=
 =?iso-8859-1?Q?Z30jxmUk5yNNS3U7+RTlhDUdXOmFL6B5XAsWf34tbWM24E/Sq9ad0FmaSK?=
 =?iso-8859-1?Q?H9R5IdL7W74YH6NUG3QcnHHRPvoF9SbwD3/PC3qrSJHQNebPWjsWkpar5h?=
 =?iso-8859-1?Q?5Bdg7dM0hgyGbV69xwCknwQ+Pxs37gvRXvtAEDsvAZZEhMLNumDaJtukCv?=
 =?iso-8859-1?Q?tKTt3mQ0JUOuUXv1izU6LGQdNE3TVCZwRhF5vLIbgFtGkWXHbJl6ip39B8?=
 =?iso-8859-1?Q?IKR5gud+2YCj0E6fbfVEduXTYHHdDGnnEHceAyA8ypLgOugPNmI6ZEtXfc?=
 =?iso-8859-1?Q?iApr4vY/GzEscJWo6LgeWw9SfG1+JgL2VtcTy3ex9rTRmR8o25y89t131V?=
 =?iso-8859-1?Q?owg/Ka8/CUCSuMNAdQ+rEn4/Yso3ZDDhwXniX48Y6uyC8AcjiYHaWzKIW6?=
 =?iso-8859-1?Q?4eDYI3TV/lZgcPTqtpIW74yA6H7qMwdOBZ3ZdtDZdauk306vu8jsUH/qFK?=
 =?iso-8859-1?Q?IcXZOR+zy+9cDrF14XbVlE7/FZ+jeaikyFmio0mm0aitG2/Od6YhTL2rMY?=
 =?iso-8859-1?Q?OxEL1FuTmDpD1RCg1r2Q0NeQUsBJ5PVdiI/HjHpzFLqdMVHQFYAynAesYD?=
 =?iso-8859-1?Q?1TpV4l3k1Z2Nn430X6lUnj9ZcQ8qVQk8wgN20EOZ+7OQh/3qBNvxlr7NmH?=
 =?iso-8859-1?Q?lyZdBmeh66w6j5hRmRGgSU5cp9irFRaoIUIbmNeJrOarwFlbKpCP847nnN?=
 =?iso-8859-1?Q?7zmVUABH2MblrVOS6X90j2jrTCFfPR0pIUSXmkX4VEVfaKk33oPYGOYDnk?=
 =?iso-8859-1?Q?x6dbChDdmfOrS18X3AysBFwhjNPgSOYM6y2DXah68s4JFiovKauBE1+Ts2?=
 =?iso-8859-1?Q?NDFNj6KTrADAcW+b82kY05dFDE40pkjrxocU3wdwFOuqkcSo6qgzsxDCGl?=
 =?iso-8859-1?Q?Uwku2aNZdPTsJCrnlqPKqIzl74NhuqKBRDxaHKEivwOdhioMkXkZoxMfnp?=
 =?iso-8859-1?Q?2BFZH+nwTT7D9giP0TMrvZwDMyVOQ9rI/5CJ6j44Ge2u/mw4MmECtgBBFj?=
 =?iso-8859-1?Q?ieFM6FQApSJz6b7rwr5/bSmW0wZ/l/l61stGZqgdt+xgK0EEJ0skAW6GAG?=
 =?iso-8859-1?Q?jTSg/vP4foTeq0/SuFh0zGZB+HTf1GGMT5GX6P1i4OM0tx9aPR+XoX779/?=
 =?iso-8859-1?Q?bTDv8YbOoxWC+pt2KRc5vfam0LmSQp75LXcjkXXwlwDPqvhufN3sj92CjK?=
 =?iso-8859-1?Q?K1mmjyeNJR2dHnOshXJaSENAphRg5rIM1Cmxdh79epXfIK0jyXmMmjzpcF?=
 =?iso-8859-1?Q?C4qAyUybX9xADDIbMdPzPR1+4Gdk+mg4/0gh9elXyrtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f2dvE3MR84ffM635NSFKr/Pi2137jjoa1wazMpjbXrxD4vE+hmjsJfGqfb?=
 =?iso-8859-1?Q?Q9Q2Z4MXmB4CVc/b/AXACaKe6xhQQRx8ntyqpKda9fUBCtrjrOdqEqSd2Y?=
 =?iso-8859-1?Q?oJTGwX2KWribnFPOtLJi/pKMj3agddREkl6AL6J70qX1qgT3sMnmtUaPiX?=
 =?iso-8859-1?Q?MXfQZRPOAqJIGIYJTxdGqmAU8FO8+nEszq8A3XwrxGyUnibZImCsHpOSll?=
 =?iso-8859-1?Q?iS0wawjRE3KAxk5FLU6Zw7cW3BX0L9aswyG4Ng8oCVy06WksLsmpfSYUuz?=
 =?iso-8859-1?Q?1+XsIj/wrvww0qKCCAON1CrbmHZnyJAhnaGKWh/ZIEV6+FJ2s7meyQH2AK?=
 =?iso-8859-1?Q?alfQpDv/dN3UgCRjjzG0ntmBl1lSsYU9d5P3YwefnsTcZpa+VofPgW1kMR?=
 =?iso-8859-1?Q?Sdv2JNCwDLYfLysnGP6av0jAROfh5UXnXJxfZVE734lxwSHcXQFXMKXl9l?=
 =?iso-8859-1?Q?gHG1uxALoJ8XevU28cGVjNvjxZOVyYDQUCoPKLKa9bsWRJQCiw5ovafMme?=
 =?iso-8859-1?Q?DCnn1Fhbtv+xusknVm1hm5WU0NVtVxgMRYw/wJ9E28Te+YqCvSQek6mw0+?=
 =?iso-8859-1?Q?Hyml9NqenazlobuwZjVeHSeJTRSPRNPngXUUlQonuBzOFyOqwyrstPGqtQ?=
 =?iso-8859-1?Q?XbbRgBGsX6Y5EmuEFV3INHRFW0e1iiDzSPJMMXN6tYmAAdqoXXJ/aJnidE?=
 =?iso-8859-1?Q?YlcXpF5o6E0OOaSHKjOrSDvjvzxESsivvoqQbnxHpu+N2kTZJx/KKkMROP?=
 =?iso-8859-1?Q?sMKwbHGInwoe46VG2RHFdwvGFVCbOOVcc0drc4debbEZmZbaFr0QpUxdHM?=
 =?iso-8859-1?Q?+84YBNj9s5lUTAwg0Rnr5KpAL5RTerRdiFslfz4kR5CWdktD4bZYlOYRzx?=
 =?iso-8859-1?Q?acAOhC0SXBKkph+qGA9evludgYxfrV+t6N8NzVZhElXtDFavEMxrl5R3r9?=
 =?iso-8859-1?Q?V6XZSRCp34dc2qaEq1S6wmS2h9tWJmGJ3YAyr4JOay1c1iDzaPkVp1Yj5v?=
 =?iso-8859-1?Q?gyKCVk5m84EpkLx5mAWIAFQUwXobQlXMu41VqPg9gCMV0gJ3Oh7uJemRsO?=
 =?iso-8859-1?Q?w6AzSVPsxiM7JzY+b2aI2Aml2nibc9GhH1KY6U7tuzm/oZH4gcm3eiFudn?=
 =?iso-8859-1?Q?x6FB+LZTjIONTyZOaBmvP0KdZRN2yZ2B2PgVgjrL/FA11xXSHUFCygkNFh?=
 =?iso-8859-1?Q?fJeFtt7CmX3eHycASk/6Lk4RRa8RuH92wZT5xrhS+Sfwvi14FUGOOqCPYR?=
 =?iso-8859-1?Q?89agvecKCASnDXnL7ot5TcZ/0SyoSL8OV4fV1xNfyGk9e2VwNMJIEHzwj0?=
 =?iso-8859-1?Q?n0CiMUFOOrIaMZKdKkZmW8jAXQzBJojaw/zAa52Da0nm4f0qzNV2bnyklH?=
 =?iso-8859-1?Q?XsNe3zHsT+aEKozc0jTqSN0UR8ZZaBIbNNNRVZZSSCkBarm49JA2D37Qq1?=
 =?iso-8859-1?Q?udcbwUHOX/l+ntgvJXKE0DwPaoIMHJL+0IpHsiMACjY9NdGICypfudI4Nf?=
 =?iso-8859-1?Q?RVp+TdV40kpZ5B4v5+FaWqbDr3WIe3Or43T8k7gg9PeA5Nnr8jJ3DcpjGD?=
 =?iso-8859-1?Q?LdwcBrBfFoRU+EvCd3+QuqWnmwVYXyNGMuhTBMp8BsJ9GCDUVpLDPAslsa?=
 =?iso-8859-1?Q?1Qc4hbZTTo5bTbd1nweYl5+UMRBG//k6g4EhVDQ6gabaUNLiX/Hyck7Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aba9cc2-c17a-40e4-4ebc-08dda2a4317c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:40:24.4787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUV6BdB9tr0HFkEz9OV4dgCUQt9ZUtyPBU5hiwszkX9zWApMfH2tRMoL3xSv8Ncswkwh5Jk8/8PxwKJod9Wc6jw96ZXLI/W0UlgtFSsECKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6623
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add support for Coherence Manager (CM) and IOCU discovery and
configuration on the P8700 platform.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/cpu/p8700/Makefile             |   2 +
 arch/riscv/cpu/p8700/cache.c              |  10 +++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h |  31 +++++++
 arch/riscv/include/asm/global_data.h      |   2 +
 arch/riscv/include/asm/io.h               |  86 ++++++++++++++++++
 board/mips/boston-riscv/Makefile          |   1 +
 board/mips/boston-riscv/iocu.c            | 104 ++++++++++++++++++++++
 10 files changed, 464 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 board/mips/boston-riscv/iocu.c

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index f9fcd20e2ab..3c93a703d84 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -6,3 +6,5 @@ obj-y +=3D dram.o
 obj-y +=3D cpu.o
 obj-y +=3D cache.o
 obj-y +=3D emu-amo.o
+obj-y +=3D cm.o
+obj-y +=3D cm-iocu.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 27641035d80..e9297d9881b 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -37,6 +37,11 @@ static void probe_cache_config(void)
=20
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
@@ -56,6 +61,11 @@ void flush_dcache_range(unsigned long start, unsigned lo=
ng end)
=20
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
diff --git a/arch/riscv/cpu/p8700/cm-iocu.c b/arch/riscv/cpu/p8700/cm-iocu.=
c
new file mode 100644
index 00000000000..5850647d20f
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm-iocu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/arch-p8700/cm.h>
+
+__weak bool plat_iocu_usable(unsigned int cluster, unsigned int iocu)
+{
+	return true;
+}
+
+static int init_cluster_iocus(unsigned int cluster)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	void __iomem *global_gcrs;
+	u32 cfg, num_iocus, num_iocus_usable, local_cluster;
+	int i;
+
+	local_cluster =3D mips_cluster_id();
+
+	global_gcrs =3D mips_cm_base();
+	if (cluster !=3D local_cluster) {
+		// FIXME
+		return 1;
+	}
+
+	cfg =3D __raw_readl(global_gcrs + GCR_CONFIG);
+	num_iocus =3D cfg >> GCR_CONFIG_NUMIOCU_SHIFT;
+	num_iocus &=3D GCR_CONFIG_NUMIOCU_MASK;
+	gd->arch.num_iocus +=3D num_iocus;
+
+	/* Discover how many IOCUs are usable */
+	num_iocus_usable =3D num_iocus;
+	for (i =3D num_iocus - 1; i >=3D 0; i--) {
+		if (!plat_iocu_usable(cluster, i))
+			num_iocus_usable--;
+	}
+	gd->arch.num_iocus_usable +=3D num_iocus_usable;
+
+	/* If the cluster has no usable IOCUs there's nothing to do */
+	if (num_iocus_usable =3D=3D 0) {
+		if (cluster !=3D local_cluster)
+			power_down_cluster(cluster);
+
+		return 0;
+	}
+
+	/* If the IOCUs are in the local cluster we're good to go already */
+	if (cluster =3D=3D local_cluster)
+		return 0;
+
+	/* Ensure that the cluster's L2 cache is initialised */
+	return init_cluster_l2(cluster);
+}
+
+int mips_cm_init_iocus(void)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	unsigned int cluster;
+	int err;
+
+	for (cluster =3D 0; cluster < mips_cm_num_clusters(); cluster++) {
+		err =3D init_cluster_iocus(cluster);
+		if (err) {
+			gd->arch.num_iocus_usable =3D err;
+			return 0;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/cm.c b/arch/riscv/cpu/p8700/cm.c
new file mode 100644
index 00000000000..ce7485c564d
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include <asm/arch-p8700/p8700.h>
+
+static void mips_cpc_init(void)
+{
+}
+
+__weak const struct mmio_region *get_mmio_regions(void)
+{
+	return NULL;
+}
+
+static void p8700_setup_mmio_limits(void)
+{
+	void __iomem *gcrs =3D mips_cm_base();
+	const struct mmio_region *rgn =3D get_mmio_regions();
+	unsigned int num_clusters =3D mips_cm_num_clusters();
+	unsigned int limit =3D MIPS_CM_MMIO_LIMIT / num_clusters;
+	unsigned int i, reg_off;
+
+	if (!rgn)
+		return;
+
+	if (num_clusters !=3D 1) {
+		// FIXME! Need to support multiple clusters.
+		return;
+	}
+
+	reg_off =3D GCR_MMIO0_BOTTOM;
+
+	for (i =3D 0; rgn[i].addr_high; i++) {
+		__raw_writeq(rgn[i].addr_high & GCR_MMIO0_TOP_ADDR,
+			     gcrs + reg_off + (GCR_MMIO0_TOP - GCR_MMIO0_BOTTOM));
+
+		__raw_writeq((rgn[i].addr_low & GCR_MMIO0_BOTTOM_ADDR) |
+			     (rgn[i].port << GCR_MMIO0_BOTTOM_PORT_SHIFT) |
+			     (rgn[i].enable ? GCR_MMIO0_BOTTOM_ENABLE : 0),
+			     gcrs + reg_off);
+		reg_off +=3D GCR_MMIO1_BOTTOM - GCR_MMIO0_BOTTOM;
+	}
+
+	__raw_writel(limit, gcrs + GCR_MMIO_REQ_LIMIT);
+}
+
+int power_up_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int power_down_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int init_cluster_l2(unsigned int cluster)
+{
+	return 0;
+}
+
+int mips_cm_init(void)
+{
+	int err;
+
+	mips_cpc_init();
+
+	err =3D mips_cm_init_iocus();
+	if (err)
+		return err;
+
+	p8700_setup_mmio_limits();
+
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	int err;
+
+	err =3D mips_cm_init();
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/arch/riscv/include/asm/arch-p8700/cm.h b/arch/riscv/include/as=
m/arch-p8700/cm.h
new file mode 100644
index 00000000000..ab5ea7385b2
--- /dev/null
+++ b/arch/riscv/include/asm/arch-p8700/cm.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __P8700_CM_H__
+#define __P8700_CM_H__
+
+#include <asm/arch-p8700/p8700.h>
+
+struct mmio_region {
+	phys_addr_t addr_low;
+	phys_addr_t addr_high;
+	unsigned int port : 4;
+	unsigned int enable : 1;
+};
+
+const struct mmio_region *get_mmio_regions(void);
+
+void setup_redirect(unsigned int cluster, unsigned int core,
+		    unsigned int vp, unsigned int block);
+
+int mips_cm_init_iocus(void);
+
+int power_up_cluster(unsigned int cluster);
+int power_down_cluster(unsigned int cluster);
+int init_cluster_l2(unsigned int cluster);
+
+static inline void *mips_cm_base(void)
+{
+	return (void *)CM_BASE;
+}
+
+static inline void *mips_cpc_base(void)
+{
+	return (void *)CPC_BASE;
+}
+
+static inline unsigned int mips_cm_num_clusters(void)
+{
+	u32 cfg;
+
+	cfg =3D __raw_readl(mips_cm_base() + GCR_CONFIG);
+	cfg >>=3D GCR_CONFIG_NUMCLUSTERS_SHIFT;
+	cfg &=3D GCR_CONFIG_NUMCLUSTERS_MASK;
+
+	return cfg;
+}
+
+static inline unsigned int mips_cluster_id(void)
+{
+	u32 temp;
+
+	asm volatile("csrr %0, mhartid" : "=3Dr"(temp));
+	temp >>=3D MHARTID_CLUSTER_SHIFT;
+	temp &=3D MHARTID_CLUSTER_MASK;
+
+	return temp;
+}
+
+#endif /* __P8700_CM_H__ */
diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index 5ca9b4b9497..6c47de9a633 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -65,6 +65,10 @@
 #define CM_BASE			0x16100000
 #define CPC_BASE		(CM_BASE + 0x8000)
=20
+/* Block offsets */
+#define GCR_OFF_GLOBAL		0x0000
+#define GCR_OFF_LOCAL		0x2000
+
 /* CPC Block offsets */
 #define CPC_OFF_LOCAL		0x2000
=20
@@ -75,6 +79,33 @@
 #define CPC_Cx_CMD		0x0000
 #define CPC_Cx_CMD_RESET	0x4
=20
+/* GCR_CONFIG */
+#define GCR_CONFIG						0x0000
+#define GCR_REV							0x0030
+#define GCR_CONFIG_NUMCLUSTERS_SHIFT	23
+#define GCR_CONFIG_NUMCLUSTERS_MASK	    0x7f
+#define GCR_CONFIG_NUMIOCU_SHIFT	    8
+#define GCR_CONFIG_NUMIOCU_MASK		    0xf
+#define GCR_CONFIG_NUMCORES_SHIFT	    0
+#define GCR_CONFIG_NUMCORES_MASK	    0xff
+
+/* GCR_REV CM versions */
+#define GCR_REV_CM3			0x0800
+#define GCR_REV_CM3_5		0x0900
+
+#define GCR_MMIO_REQ_LIMIT				0x06f8
+#define GCR_MMIO0_BOTTOM				0x0700
+#define GCR_MMIO0_BOTTOM_ADDR			(0xffffffffull << 16)
+#define GCR_MMIO0_BOTTOM_PORT_SHIFT		2
+#define GCR_MMIO0_BOTTOM_PORT			(0xf << 2)
+#define GCR_MMIO0_BOTTOM_DISABLE_LIMIT	(0x1 << 1)
+#define GCR_MMIO0_BOTTOM_ENABLE			(0x1 << 0)
+#define GCR_MMIO0_TOP					0x0708
+#define GCR_MMIO0_TOP_ADDR				(0xffffffffull << 16)
+#define GCR_MMIO1_BOTTOM				0x0710
+
+#define MIPS_CM_MMIO_LIMIT	4
+
 #define P8700_GCR_C0_COH_EN	0x20f8
 #define P8700_GCR_C1_COH_EN	0x21f8
 #define P8700_GCR_C2_COH_EN	0x22f8
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/=
global_data.h
index 47b5e2cfc8f..7dbd164f154 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -44,6 +44,8 @@ struct arch_global_data {
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
 	struct resume_data *resume;
+	int num_iocus;
+	int num_iocus_usable;
 };
=20
 #include <asm-generic/global_data.h>
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index da165858034..fb79d0a8d32 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -15,6 +15,91 @@ static inline void sync(void)
 {
 }
=20
+/*
+ * Generic virtual read/write.  Note that we don't support half-word
+ * read/writes.  We define __arch_*[bl] here, and leave __arch_*w
+ * to the architecture specific code.
+ */
+
+#if CONFIG_P8700_RISCV
+#ifdef CONFIG_ARCH_MAP_SYSMEM
+static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
+{
+	if (paddr < PHYS_SDRAM_0_SIZE + PHYS_SDRAM_1_SIZE)
+		paddr =3D paddr | 0x40000000;
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline void *unmap_sysmem(const void *vaddr)
+{
+	phys_addr_t paddr =3D (phys_addr_t)vaddr;
+
+	paddr =3D paddr & ~0x40000000;
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline phys_addr_t map_to_sysmem(const void *ptr)
+{
+	return (phys_addr_t)(uintptr_t)ptr;
+}
+#endif
+
+static inline unsigned char __arch_getb(const volatile void __iomem *mem)
+{
+	unsigned char value;
+
+	asm volatile("lbu %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned short __arch_getw(const volatile void __iomem *mem)
+{
+	unsigned short value;
+
+	asm volatile("lhu %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned int __arch_getl(const volatile void __iomem *mem)
+{
+	unsigned int value;
+
+	asm volatile("lw %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline unsigned long long __arch_getq(const volatile void __iomem *=
mem)
+{
+	unsigned long long value;
+
+	asm volatile("ld %0,0(%1)" : "=3Dr"(value) : "r"(mem));
+
+	return value;
+}
+
+static inline void __arch_putb(unsigned char value, volatile void __iomem =
*mem)
+{
+	asm volatile("sb %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putw(unsigned short value, volatile void __iomem=
 *mem)
+{
+	asm volatile("sh %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putl(unsigned int value, volatile void __iomem *=
mem)
+{
+	asm volatile("sw %0,0(%1)"::"r"(value), "r"(mem));
+}
+
+static inline void __arch_putq(unsigned int value, volatile void __iomem *=
mem)
+{
+	asm volatile("sd %0,0(%1)"::"r"(value), "r"(mem));
+}
+#else
 #define __arch_getb(a)			(*(volatile unsigned char *)(a))
 #define __arch_getw(a)			(*(volatile unsigned short *)(a))
 #define __arch_getl(a)			(*(volatile unsigned int *)(a))
@@ -24,6 +109,7 @@ static inline void sync(void)
 #define __arch_putw(v, a)		(*(volatile unsigned short *)(a) =3D (v))
 #define __arch_putl(v, a)		(*(volatile unsigned int *)(a) =3D (v))
 #define __arch_putq(v, a)		(*(volatile unsigned long long *)(a) =3D (v))
+#endif
=20
 #define __raw_writeb(v, a)		__arch_putb(v, a)
 #define __raw_writew(v, a)		__arch_putw(v, a)
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 9032e2ad6bb..007f68287bd 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -5,4 +5,5 @@
 obj-y +=3D checkboard.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D boston-riscv.o
+obj-y +=3D iocu.o
 obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/iocu.c b/board/mips/boston-riscv/iocu.=
c
new file mode 100644
index 00000000000..8478670f350
--- /dev/null
+++ b/board/mips/boston-riscv/iocu.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <dm.h>
+#include <env_callback.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include "boston-regs.h"
+
+static const struct mmio_region mmio_regions[] =3D {
+	{ 0x10000000, 0x160f0000, .enable =3D 1 },
+	{ 0x17ff0000, 0x17ff0000, .enable =3D 1 },
+	{ 0 },
+};
+
+const struct mmio_region *get_mmio_regions(void)
+{
+	return mmio_regions;
+}
+
+static int set_io_coherent(bool coherent)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (!coherent) {
+		printf("I/O:   Non-Coherent (Forced by environment)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable < 0) {
+		printf("I/O:   Non-Coherent (IOCU init error %d)\n",
+		       gd->arch.num_iocus_usable);
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus =3D=3D 0) {
+		printf("I/O:   Non-Coherent (No IOCU)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable =3D=3D 0) {
+		printf("I/O:   Non-Coherent (IOCU not connected)\n");
+		goto noncoherent;
+	}
+
+	/*
+	 * We have some number of connected IOCUs. Map all PCIe DMA access to
+	 * hit the IOCU by offsetting the addresses as they pass from the PCIe
+	 * controller to the NoC.
+	 */
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	/* Record that I/O is coherent */
+	gd->flags |=3D GD_FLG_COHERENT_DMA;
+
+	printf("I/O:   Coherent\n");
+	return 0;
+
+noncoherent:
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	/* Record that I/O is not coherent */
+	gd->flags &=3D ~GD_FLG_COHERENT_DMA;
+	return 0;
+}
+
+static int on_io_coherent(const char *name, const char *value,
+			  enum env_op op, int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+		if (!strcmp(value, "0")) {
+			set_io_coherent(false);
+		} else if (!strcmp(value, "1")) {
+			set_io_coherent(true);
+		} else {
+			printf("### io.coherent must equal 0 or 1\n");
+			return -EINVAL;
+		}
+		return 0;
+
+	case env_op_delete:
+		set_io_coherent(true);
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
+U_BOOT_ENV_CALLBACK(io_coherent, on_io_coherent);
+
+int misc_init_f(void)
+{
+	return set_io_coherent(env_get_yesno("io.coherent") !=3D 0);
+}
--=20
2.34.1
