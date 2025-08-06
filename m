Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C1C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AA084227;
	Wed,  6 Aug 2025 07:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C8vMQhop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A3883968; Wed,  6 Aug 2025 05:23:00 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0646583950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 05:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXZwk/KlFLbWJr/VBokOcsG4R0oCHJUKP0t1HIsj1M8g6Xt8rMSWQv2UVIy4uqPW2SansordjW6NX2y6kAHOHmfo6Jh9HYY8a0SBOXWW1E1q1YP6GJgrMmHIPpA8MzdqaNLR9iMhQNkA5DhCnW7WNLxAbl4IBpo7sfQzlelbF/bH+e/CNdljrfuFSx4umL++eCPLLWPRwD0zsDppkWgW185htGAkcRI2LTb33UriOncDvSStX7LRGduyF4++xK8lMj2qxtAYy7gnV9Qwz+AqDzwA4+6iezlavllqACojpChMAQEE3FHZPUyDULhZe9KU2vGgjI8UX9/mIbjr94jJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RUEq838nbLgsO1Z2AraewFJ24J75fiHRnB6//C+ViI=;
 b=EpOzOgYxdw5vT2tfsFQc9gCfjEgyZ6mAnw201YxOyWdqY9k0GnEBjl0mVNQVui2bgvuVfaU2MYUcWNPB7FPfpFqHcr2JXQy8tc2IiQzcEYZQSxmAHN+asOlCTJg86Ky56R2THgeFG6xcTFLNwshzPZ4EsjxKdvtbaQV9S1EjCdYkID2SvFKafH/HQQ+Uyv/Iqs7U1eGhgArJXew/oAkJWbPZbyjwlrpPIgEvCqezvOT+C1A3G4kIST9hNgLJXfu+9bu5vN3dTMoSKBvCm16iMOXqiTLEyz65RUvCE3MV+sE04XjfcPnuR+NjtY/2oRdvqSGZrGPaeNnqhPBgvTMZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RUEq838nbLgsO1Z2AraewFJ24J75fiHRnB6//C+ViI=;
 b=C8vMQhop+xQFmHuyPXgFKiHnKx3b7S/74nvrSw4QcgUgZTma1SgcDH/6TzLnIWCNEGCBvNxrXUqzyTl5A/Uz2Px/Rr/yvdVgUqm7TDPhStoGnYcyOgtDPOexy0fAZsByL8/bMyIwz7seLBay5PMN8mlOeaEmPiluoEpTlMT43fL9p6Vs/I0XChVtJl95t2nGe1S95XEFrUhswKKpdVoLtFCsxKQBOeQ4bv+cfjQdTmUUPrMLTl9pU3utcFYYMuTFUD+V5eGH7HmwVaiC24wWDixhsEw9kl1k5sUP3j8doOAZ4u9Eza46kMUtWJWjvtKM9SGQxRB4HB0v22oobK5iiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 03:22:53 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:22:52 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v1 3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF
Date: Wed,  6 Aug 2025 11:22:06 +0800
Message-Id: <20250806032206.16688-4-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806032206.16688-1-boon.khai.ng@altera.com>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a97c665-169e-4116-6311-08ddd4988741
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ajBhuwXwcMxX/L39iUrVqP41srwGHbWVFXfyT9g691yqKIgqvIiUEN80VNmG?=
 =?us-ascii?Q?kjCfZ+K2lSPqsLCm3zggx1vHPOuvilyB8Hei/B3DjH0v6V95RiOkqC8lC8ep?=
 =?us-ascii?Q?txmrWOieht/s8gw3HsRHw2lUgnX6OTfLcOM65AW5Ox+1eNbZum4i2/hocwJR?=
 =?us-ascii?Q?5cD8o5VJtkmkVKlEEfVdWdnTmUtK/+jgrqxCpYT4DCX8j3uEjr/v6JWDS04q?=
 =?us-ascii?Q?5NFYZhcjt2zbT7mv+RczGv98SQ7YGME5Gk+kGNjpIKmi2uZcfkv3tZo/aWIm?=
 =?us-ascii?Q?+urTgjh8cMfFI/7Ui0JJ389H02N9Fva9Qdv7b4nc7Ud3QJYRfk7emUsZTlNv?=
 =?us-ascii?Q?4rAfWYGeuKaGJ1gMGK2zVpr06Ak25fWMMBOycdED9r85Sk8Oa3Ubc1SKe6tx?=
 =?us-ascii?Q?4Nh1GtrvSizw0uQRezhx6jOkDh4OCDA4MOMpV+ac39DTindWfzDCDdYG5ugy?=
 =?us-ascii?Q?3/zBiebD+O6HWJU0j1m9LsNNkC73LmNL2E5r1+fChqFDMNubr/VYIJCCpdWw?=
 =?us-ascii?Q?vK3BvYqY9rEtVg00JBbl1wC5UOdlF2jOW3FrsyvTEcWMKl55YY8fkVszbryo?=
 =?us-ascii?Q?F9vwIpN0bdDqBazhFp34RFgyXsjShlS7U9SLlzCIXZvS6SrDkPUw/n2APiCB?=
 =?us-ascii?Q?x08eMsMlyjPrtinNivjNbNedb/x9QalPUoCrR5O9++QgnKibAeM//5XxUdFz?=
 =?us-ascii?Q?vY5C1qQJTDxzgZJiJVr2dLZoemMxjOGLB3jDykIcpTZF5lQOAh5hEsL78jZA?=
 =?us-ascii?Q?XBIQShL17Tf+tmdPFDbj0XT4wNIyvBo2dk5AzayKZmzfy+FzVqJJ3M8ZPH1V?=
 =?us-ascii?Q?qwcspQbQhll1WDuDFt7TPD/FDgWCiF0bRWxxsYPmmB20Sd5Mr9mvycE3P1La?=
 =?us-ascii?Q?A9Kdlm4PR1tHCzq5b8lEKoDoRerZnwMnztJxnI9xTnZJJXZskHXZfFl54JNT?=
 =?us-ascii?Q?0VG1nwMjQo2RfnFCM1urQF9riKlRZCOeZ42edA1Mv4xAwStAk4/E4yKuHbPd?=
 =?us-ascii?Q?ki0Y1CB/BnJcSWf4qullOR8GBQoO345plg7HVFGBz3Y1j7ei3LvTL/154w5l?=
 =?us-ascii?Q?rGVV+FNLac5kbXaeaxQ/RMFMo+GgSwiLSp4veKl5AUJzZ5/dLT/nvgTKwHAl?=
 =?us-ascii?Q?GYVrGk0eFjQyX5ocVCo8QXlp6/hQMHDhZV+6q2YAA2jDQFcAxXzHjnM9TPpn?=
 =?us-ascii?Q?L7KMvh7fHyGz5cik52OfOuA8D1Yq27Ytto9P1ONkTPJon2RPRupfCvaD/AoJ?=
 =?us-ascii?Q?bsPeW/Ve8PbQ2xOj12Rg8TnA0LA5YkchtGNfRjz0TZ2HSS0XrRsFzUCSIA2j?=
 =?us-ascii?Q?bkTqlA+vFj2i+7xkSn4zNXuNSfmwm71qsxSZ51QIpuELEu1YoD8ckFbEJXbu?=
 =?us-ascii?Q?fRZcJuoEDinIh9xAKgRaWWc4zP2H17exo5GUkGnPuqhfdHe2WIENYbZ/XEzr?=
 =?us-ascii?Q?fNIoMWmZz4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gr0nTeg1EhmMgNHiW1x6GfRYchaYD2mKvSTvG0f83nini8QhU6IjmDCGp7eV?=
 =?us-ascii?Q?sHymmyel6Raz83FSZaZ5ABQTgTS1rVuNziBaL6PltbjDOwrjLebz3PAA9/CY?=
 =?us-ascii?Q?JpG0udufbMklYBE/IfibbEO4xFh2HqcRb+29ha0iYp+wnz2VoDy4+kDP48r5?=
 =?us-ascii?Q?O4Mv20xBNzTNqQBBRG8Vg5NE8pPcB/BGC0USqWk58MdI/0ODFiWuHHzHtQKJ?=
 =?us-ascii?Q?bzb6JJUPKM7dOlzbrHtCH5B7fIKOkJO55jWArLB/oW4PU30jx7Xa9Js9VNfo?=
 =?us-ascii?Q?wFMKKTl7yUJKMs33llifHlWVBrmA3IaKZ6enYlSte3kkNW2FXiZBWkmPpECp?=
 =?us-ascii?Q?fHyaguOf4Quy8uv2rhSwDZAvCc2x8eeZ3TSZUH2/UDvOfsHWKYHG2n4xTN+k?=
 =?us-ascii?Q?cRBsvA+FpCan/uDDNTiQlwe8+EkvVtfZnGdvb8Wn4X5cpRUjNtZ9rKjoz6pf?=
 =?us-ascii?Q?QiAYuF9SNpAZ4+tVGqs/zkG7tVK5oD4ngWHyFTUXMs6PniJRliolnwR21hIW?=
 =?us-ascii?Q?AbXR/frramwqAs7kLh4vfLC9IwgQoBwIPe5lQYWOZht49ukVEU6uXs2E9paR?=
 =?us-ascii?Q?96qdZuweOhf5rZyZOwsc6eQUtXwq9RsHZxfTikuZt/KQkgMwGqek4M6AMjXk?=
 =?us-ascii?Q?2ultUS+CpEx8pQnAGZR2g+z2gjym2LQgBKWlAMS7a1zSriIXsMguIRu+Eu5m?=
 =?us-ascii?Q?X86LWOtDowR1a3coPOmopr52qlcVfUe+mrNGD0cFfd6vtr1Q2g8E4t6HQqo6?=
 =?us-ascii?Q?thVKJEMGDp5jAqBhqDOwrNzlWsPcnietFV/LJ2AXq9mSdbSOcQ61u3gy1nyd?=
 =?us-ascii?Q?crUFMY1e5OTPit5lXEjiXuLFmt6OfRAxDI9yVzcxYdKpYfnQw8niEl5wnoOW?=
 =?us-ascii?Q?9oSUiQCTSzciD6D/O0kG1PQ3z+v3VDtiss4hPOGthJu2q1dxKccsSV0W1kUO?=
 =?us-ascii?Q?MMBiuKwXcuDtMdfhhxQL9F/dSDPf64JjcS3lQt1deuQo894RK+xC6+B3tCvs?=
 =?us-ascii?Q?WLBJR8jQ9TBvwY2iOwhUafQjLJdCf9UdRhMyXcvjIVyUBREPTi6Ueo5QSeBs?=
 =?us-ascii?Q?VAP2HNh3Ig1ZHwSf61o4JFKv0RUJPqyIZiMqfbJVgFJ9E0CM5NFxYpKieIe2?=
 =?us-ascii?Q?MdFLs4YjlGWSKtrwtt0E4iX9QeEl2JLAVyOsv/Z/6L808XMEIW7RlTZ2cicv?=
 =?us-ascii?Q?7v0zAhwEIsdw12n/2INs2TMeOdz7HLBjdDWfSxaOQzZgUV7n9i1WxOqMr9Z9?=
 =?us-ascii?Q?CBbvVVT1LPSFmf+3honBLuR9JqIJDhIHbw41qXpP7A5LslJ0v9vSVzLH5UKZ?=
 =?us-ascii?Q?6uXWmAGIYntHpmtzckEGbffYPaokZGpQLDnvMxF9EballMlixAXEjqwxv2pL?=
 =?us-ascii?Q?zFGmN2crCoJEBHNrTrkLqRqCld8LfvThQmxAQIrSmp4hyGzmEjGr9VTbBi3N?=
 =?us-ascii?Q?SJ6C0eybCpTzocS4RRUw35uTcdC6le722H7lcswnohGm3eWeT7ORSd29fwGI?=
 =?us-ascii?Q?KuH4uZTqyxRG4vuPMZd3xLyKVP3MkodfKOkD84SRj9HduZTx+saKhpcwRJbr?=
 =?us-ascii?Q?8hdE0zJeVl5mlNjYmSFk6f0D3kl7UTGCgopGBFV1?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a97c665-169e-4116-6311-08ddd4988741
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:22:52.9117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3GxfVXSKSA9t57zmU6f0B7bUWp6eHRwnNiVBtW6ouiy2lWCnK6sfV/JceIrT3PuAomXZKUgW9Zks5SziToOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Add SPL_SYS_DCACHE_OFF to Agilex5 defconfig to disable data cache for SPL

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 33a6221979a..8c31dcfea11 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -45,6 +45,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_SPL_MTD=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.35.3

