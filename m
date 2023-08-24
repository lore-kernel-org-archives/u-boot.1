Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECFDC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DE88690B;
	Thu, 24 Aug 2023 18:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="euFXkqa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF2E867E2; Thu, 24 Aug 2023 18:25:57 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20822.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::822])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4532786795
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPVu8PrO052mjHOrtg1aVoD6UuYsSwPOFQ7WTe2X6k3T4mfH/PFQf/2oJydgQnGQPvFpISFKWP3ahn/ml/XyNa83UVBolGZpyJ4mPBUrV7U21hhDhAe2mWz3qIUIK2q3dBmJ01GrxbihG1hxaSW0pj4dOZC3nVlCbm8W4xXtkCEJka8Meo/c7IJcFxibkLz9uOaHWQfMpASUcaxSm+bbSXod+Z5k9CPyCmrieugcmamGmcycnc+/awtOlFRJ1fCNaOfynvLI9/G6/mzxRNkwJZTab9orhF7wwyB+TMlmB3qNhrsox0YQ5yu62cGlE5MVVQGboDBBwD2cKDTYqErxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTxkSQEGZUh8UFy+TF/1NAM7vzb5veYI8jNwGqFkmK0=;
 b=hiRhepFKfa4oXU0+dWc60fkHpPrIGIp2F2xkTg77Wc8yTwTJxcx2TmZh3HlS1rztaOrfAvS7tHWGUG+rad0BkuQ/KFewnvR9o+MWZmqQY5P3gtOPh3lVinJuxgeKQRMS0j2ULouBKdFY2JmuiVoYEoXCr3Ybx4FrF86PqtnlX3R1Nalpch5tHy1wJ+AfH5kNcnVV4y698BNmJQgIEjGtn8tIw6RogrNLEEaRacFJKJNaedaHFUP+VAS8d57cUPY/A+aeQem/Ygm4brn3AEiw/mH0wR5XLRL4I4dFYV2UqIcZ+p5BVC0tC57eGQ4t1eHTVwD2tBoLIGQFQHENWjaaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTxkSQEGZUh8UFy+TF/1NAM7vzb5veYI8jNwGqFkmK0=;
 b=euFXkqa0DAqPM7WCw5sE4ERmKX2QwavDfYXziCvrvnZCw/pWp0hE7tkRTGtniTEC0CUKluzHJuYZhC9M9uPSvJv3yYRImmuUssT8QXcgvqEpbEvqSVMdSl7NO9ZadrZpyB0rqVtdT1Q7thb/2191uIkjJ+I76XBugrU6bkJCwRt6VyfmyFRL5kvKaWzh5zDf1M1w9FJc+xGq6nEWgIKZ4KkQOnjeM28YePhRCc5G/NccyJzTm8LWsmh0H9DjJETCvLAzvyKgadFJhVsaK2QrLJCzqzMF0umSzef/4Fai5cgo14PFtfF0IfDg0QDCCqSoZKJY+MTWelvuABLXwxT23Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3381.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19; Thu, 24 Aug
 2023 16:25:50 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.018; Thu, 24 Aug 2023
 16:25:50 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 sjg@chromium.org, andre.przywara@arm.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v6 4/4] configs: starfive: Disable SYS_MALLOC_CLEAR_ON_INIT by
 default
Date: Fri, 25 Aug 2023 00:25:21 +0800
Message-ID: <TY3P286MB2611C8919347A7E4B420FF54981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824162521.22240-1-wiagn233@outlook.com>
References: <20230824162521.22240-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hAaHWUz4lzb0IpEp9zVBpLq7aQol1jhB]
X-ClientProxiedBy: TYAPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::21) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230824162521.22240-5-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: 80575f06-85fb-45a4-4bec-08dba4bec7c3
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWwwxxe0VdV+IxBz80lnVIzkGim3gDZrSGvbPlAiTJOnxias9WnGLv1cCT0IiOs1cmvMPPuUyLp/Z85BbFwha7WIw9MblVM1nolaUhnuXRjOARz5LE6bxSQ/QfBI6RlLXFv7BhCvJs+lbaUkT7yKB84W01E/ldgNC4X3iVvZxTMfcnjfvPAWX503oB0PhHxi5TInqkcBQNGA1zQm66ncwsJgYNYsxjUnPJLyQZFCKhFyLuO5hOODhboyh+a2hsUgk4b2If9j90D/1X3NEpxX0oO7OZzCUwWkwuEaOppLWKDBS2DA5yqjwH9uMNmg8uB3kzVGHr3TrLTOsjucmUEIktAmrb1CVVsAo1rIzChP8xj4WN9Jjpo1kimxniDragFArK+hUf/nmTlLsdPtNyS1TBlu6X+qH/Jnk6yqElQWKE6fwhBi/Rloj3hVkQXYRDKD6K7LOzp3HBtRYoudjvIOgAV44XQZiV5+znzt6jdLFXVGLWCBLTh/Lyos3vktiOL3qf4GaLVUpMQu9O5obaYhkpwlVFzfT6Sl+oMijELVTj7G3hDKQhqQoEh4+QtbQZU9Q/eCIuwKyPP2oSoPXwLru5DSVWJb05nbV5/N6uB9i53HM8ECRcGfZA8YQL7+hoBaYQCF6A7u3C83mOuEmMRG/ScePb38L3f0/pRNDgXT60VAwXBK84mTh3//YHAg/LQxJBHSGNcq4rK1AnS8q5JMzqQ6rfeTSzQk2dO8Pse/LDFaWEnP9xTALLa28T/b6MLr4g+e1fq3ic8oGLYuH0RtdOThoznvvYyPjA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufL89xpSr8gGcdJoDcVT/CkPqQqgfRrWZ7WMdGG7g+lX1MPTVd/90WunlKJ4yW6J8fSIwZLxKBOoURrrQsCFaBbb11eLfs4qDNqtuNkuY3qtdi2fK5OjGur34BsoCOi2f1AB/kstrCWMV32/sSrj59Wn2S3wCR5n45EGhmH8gjQB+0w8a6PWcVpuJvhbJj/yC/8AVyCgsFSjrFP7qt0tamaEXeM7YurUv4rEFRUgtg/HEBx+hGhmAFQlXNvYsmH3CLnaQXunps59QE4FT9h3ODMTjEiNKsVNl+1kz9tH5ul6RZfcjD1XYCmBsBX+rcvkVHGCCbOfz2S+mtpS404OOLiE7NI2Ofa65R0jR5cAYp7e6wfChWghzECI96SyLm4UwaJ4mUVOZEZSjB1nxKOwjFDjPE0Q0yBQH1dOjFGX6OmXTrNrbPj3Mmhqb4AKOxLlGjZyE3zy99u2qrjSIkiDoUmxvtR94WwgSimzeqUPY4xobc1k+e/2m0Zc/cte7Z66Sh9y3iVlM0YQJ0K2lzx0lIlvFsj7pDO855vTypRiF37ZFxZSeLheWunsfZ53jq1F5gTuLJ7j1vM7yTlBSA9buSejl/8CiXwGO8MfT5RGXJIP5fg01tgrXcz0T6B3ejT8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+SBdJVDjPrpiiwmVvWbpaXX8Bue1mdb6jHgl6wy0TV5IFWIPIMzdR1PeVB/?=
 =?us-ascii?Q?BnJaM4OEjb0vvj6sG1EFH6Gq108PD88ExQGlk16Nk7HxQ+JsGl/qRXKDzF21?=
 =?us-ascii?Q?ofEMyu4nXwS2i/Y7H4Iu92fuKlrwXV5gxqcMfMDxPJRqT+Sogd5r/3AuxxTO?=
 =?us-ascii?Q?ZDXeT9AwSob/tZYgNK9cOlXzV4ZQJohhxR86LbPLIIfXJ18kIxHkkTpjQz6s?=
 =?us-ascii?Q?eNc6k+AvrGy+BN4rvovREsfLfQR5baLSRQWazereH+kGVNkfqSHXn7MgYaLV?=
 =?us-ascii?Q?Cl7X0+U4SuLdM5ULcMonp58cbH+ba+RWN4rzOWQDGnaFgVSRMcDc/pf/TadH?=
 =?us-ascii?Q?VyqwiD2LkEOvDiM5d0c/qvgWYZvvE6X9pqx1HufSnERkoMYME9Fz2dNcOC4F?=
 =?us-ascii?Q?w4zUXSKsfhg0DS1DlO4cF6Bh7+CJKZjyajinHrGQSQEphCHcCn5R+ZgRohfS?=
 =?us-ascii?Q?xta5/U6j+VkTGr/1hYdEtFhkXrzeNgkCSYXitKNQs6tYtbYK6WRMyELQhSJK?=
 =?us-ascii?Q?hOa9/NNiOPP5NOFTuw9T+GVgqMbzlPSE/49gPEiriGnGRb2aLpbKdGXABvQk?=
 =?us-ascii?Q?WzVnHoGrYLv6o/yyBNppHzAxudC8lXaE1gQzwaOtEK3g68fMZVzkV7gV/ITS?=
 =?us-ascii?Q?LKrpiDg98krGObpdqu+rp1X5/oSedhx9LPM51AoCz3N2Rtk7+HVkoJlMSrCj?=
 =?us-ascii?Q?UWfC4XmKNgFnDvEU019aaLSO+svBZcM5wb4AlTcgTMmNbecU6/CAbrXimi4g?=
 =?us-ascii?Q?lQzSeWwmEltxDhDiwulvab6eFjyA/skNXTksTLnu8YR3WU0a++jMdn6APoM4?=
 =?us-ascii?Q?IdN0WaqJs0UacW4+7KXyOarA5otLLpXSlq2MX3Y6udwueUZhvwWbLRvZ+qxV?=
 =?us-ascii?Q?ATWgJuec5JWytXcuKOLVtOPUdNxCOQEyyJKQSA6wXV0sFPl4oyh7WQvnR7lL?=
 =?us-ascii?Q?sFURVJXHdScVV0/PBMsTSnXeKHq1TEkzHkq9A+pZ19C3ksHpoGnll7maDtlu?=
 =?us-ascii?Q?MM3fZBP8sz6UbDkNSxqCxmhuXQ529qlKFJMEkUx8q7TyDIBooosCgZXQhE1U?=
 =?us-ascii?Q?FdU8qVdb69qrXvv2tgZAGTgTzIB9yT5j5IUfwj9zPNPjUhPGtaTtDiCt5U1E?=
 =?us-ascii?Q?HxxulesDF5IVcwm+k4Y9II1CUYGM1ppkqfU784FKnkcf3YZ2pUCws7mmxJ78?=
 =?us-ascii?Q?094l3ga4oHghEkJ/KsJJaT5WdOMZCo5pougRoA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80575f06-85fb-45a4-4bec-08dba4bec7c3
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:25:50.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3381
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

SPL_SYS_MALLOC_CLEAR_ON_INIT would enable SYS_MALLOC_CLEAR_ON_INIT by
default, but that's not need on JH7110, so disable that.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e9b63e5b84..efe3c2205a 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -58,6 +58,8 @@ CONFIG_SYS_SPL_MALLOC=y
 CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
 CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80000000
 CONFIG_SYS_SPL_MALLOC_SIZE=0x400000
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_SYS_MALLOC_CLEAR_ON_INIT=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2
 CONFIG_SPL_I2C=y
-- 
2.42.0

