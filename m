Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E783E68176
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D3583E36;
	Tue, 17 Feb 2026 12:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="JSolXJS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F0283CD3; Tue, 17 Feb 2026 12:53:45 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C9183AA9
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRU3mKBWObYt65eUpGSmCEK+eTQ6/HxVftSuz7IGt7paAJbbCBJQYZt5Y+CICAswr5wpIV0F19P6ANMoeDL/OeRPhOvMy33Mu0ZvDFwgi2p4db1n7yy055yXN0bueJA+UCa+6RoNyKlo275fQGn6eRqqPcXfVaUqAzYwhb8Nj6cQgVk3lMF9rRElEbLxcHX7eeha7CpPJKIje5OIBWRhDQQqMTH5QW8BNsy0CByh4nzBMqSYK8S3Sj41DCe0DrEqfmaLbM+EjJhMGNuXCFHNagjfHKxMKGeyLgypmQ4rzjX3B1jTBxwlM5Bze/Alqd3urp0Ek0pUU9ZtANra2M5aZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=apmUaNpZ6vWHu19thDJlgojb0dkaI718wg4jztlgeIjejKag6UsBUQbCiYxqh5RS7AypxFmi+usksBVcU8fUIvKMdfrZYiI8vc57cIpBXuEtc20uG6ZfUQJX7g3qGmrKy3u7FPg9Et+cb4DcvqxXfoRjvCtL775m5IgDatCk2qeYB8qphPJRRJ+BpvyHHHFZBBer89islJ9SSFipLWyWX8Vtcp037C7O5cJ06Ow2FOyeEibsofNoo+2FM94WDX7vfrg9DnTM4m8GzEOQz1/bEzzmx3Ko4+wVcnqs/b4NlBeQqduuhVq5CbbQ6cCoBl3IdDS8EUy6Q/0c/uNHCohqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=JSolXJS3NnGaLxmy527VVN/08kuu8f7yJKRXs5bg8PdLaagzdj9N6FD9aLmz7GUXI5wOenscV+6njxpwL1QdBt3BpYR5sYZoPCvI1s+KxKXzVHy7kCkH4gTNdlS2HrQomR5isQI/UTJYAmdxglTc3fEsYC542wILHTkbr2aFVOnsQViSSMv9lsPAXz6uPcjOJybuycobCuNBpG6hCw+TTVwCp9z8HNQxHHu8STr0xNOKnFbiMvobY27xUS5UcnzI1UGoCLxQO/Jk7Wb8uxUvAeEq3Fb1HqRhDwPmLE9cozCnPNzNOe+EsPH9mlJH9Aud1JFpAzFJ6OJYghgC8AYk8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:42 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:42 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 5/6] binman: DTS: Add dump-signature option for capsules
Date: Tue, 17 Feb 2026 12:53:31 +0100
Message-ID: <20260217115333.503359-6-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5801d787-f18b-49e9-cf11-08de6e1b3250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhOLTwylaxdbHERpzdODF4JcvCFsn5Go0VfSfezgz8UgG1SpTeNGK3yTThUh?=
 =?us-ascii?Q?QxVfdSPh0kh+PRpjZEInZqsJFG66lP0z06VNkThgypt3pANWE8H3mvZlRHJW?=
 =?us-ascii?Q?5M2oigAWT85j9LiiE9NDffiZYD9VnT9Z8eCmGTjFXkuRupTAhwh4g5Rjp/J+?=
 =?us-ascii?Q?IGEB7+fA23qPBEwb30VG6uG4TPwez/UWXLhNPRhO9RkYdQPTTlPISs4wXwRG?=
 =?us-ascii?Q?VB3JZXUHXhLuMM6bN+Ky8RGRB9/XINXw4GO6Pf7Gkj7AghmmVhJKNCfVpxvb?=
 =?us-ascii?Q?D77B5dP21aCW1UrYJXTFBIqJLdKmmCBam+6ykT2kcgv2VOCvPEU11j8e4eTH?=
 =?us-ascii?Q?59vx1DIRNUFLNqSOqTNspaoR1JlhOrzAEow36KZ3DB0isnTmPuxRMeG38lF9?=
 =?us-ascii?Q?4aKtdrP1M8XAV9P1lUvBrhrVKFDhywOfkbG5CUNv/0mWe6SqbTLvu9feU9cx?=
 =?us-ascii?Q?u0fjiMmoYSUf9LCo5RbmbpU/AHnRV9zNfgpkJgTp/pREzRaieM0/hC2/TtY0?=
 =?us-ascii?Q?IEjHbrllIeV977xesWCkzTdq0E7zu2vNMGBsRWc7mxheDU0xyvmg8rcHZHJp?=
 =?us-ascii?Q?P4+16+obX9LzOVxdqdjEAgbrdr9cSoGXJGMxawWQAX0W5x7xF8cshzlzF+Od?=
 =?us-ascii?Q?OSSnXhH4AqTfnJD0fcO4qDCda4D3VyoNTos8iNkRr8VeLEH84/P1m91SN29A?=
 =?us-ascii?Q?wCVfPnV7y10+ixv18R8ULB+fMJVRr9FewPUpMByvim1C3nz9Z3Ea3pjN4pTa?=
 =?us-ascii?Q?4uW6g+w7jDYjiwvP91Yjw+AQtIQL9RMJ0gyHvKu0kBGIP1rIu8myqJ4zLKfB?=
 =?us-ascii?Q?rdTLuijOG10W9Jy+tNKoOXQ4kEHFCmmCpsx1p21WuqkFlnhOcI5el+gYaShs?=
 =?us-ascii?Q?+EIBjEcVejhi1Jn6hffDGjbn19NhTimreMD9FFKuPv/r76UDlezToH/s9PEk?=
 =?us-ascii?Q?fQoKCjfxuTsf4w1o3HccqkkDYjYinisXTn3RreZSW1238olr+eaLYLZPM8z6?=
 =?us-ascii?Q?k4IxFRNPydFoK2VxFlXBtOdo1cfqEX6vGEOuP2OoEXlatzMQIyFBWS3ndY1N?=
 =?us-ascii?Q?KIfSVLJ4tkDn29OnDh84xRSHMwLKfOGDUTaMRr9cE02ls5uN15WFRCLlaAL7?=
 =?us-ascii?Q?5P8DrnLUm6ZIJX0QuKQLWvzJNnePFD4BZjl/qJhd8lIeNd2Zza3wlh8ko8yk?=
 =?us-ascii?Q?qw8jybVDEvZTnKMSnCRxwD4t1rsKiLpiX1o3KC1Gjs6VKY/YXn/rqHFbBOJ0?=
 =?us-ascii?Q?pthq6RsahYlnKvJvXoTMs7K+5rAv3QvjYJCwkFH8u38o5RV/2mUIzBJcJD34?=
 =?us-ascii?Q?laZBCygD2Kb9o9x/L5CDhl0PL34z00eRTyjKrBS3m52UT4qGLHnrcXCzDFG1?=
 =?us-ascii?Q?U9O4B0SYHvK7LYMmYppHBUfezDkSUu5A22BnoJi0/Vomd3W9iAK38Qcy+PjF?=
 =?us-ascii?Q?ujVoz9q0lDu6SenMX9VWX6p8hQFfsAVWXT3Stqb6+vHRY73gk9g+vzv7fWjR?=
 =?us-ascii?Q?XNEDOqJmiakMEdcg5U9Gp4gDVTPDHi+hmT+v7lve/Cfbw6J+eXBokyHc/Y1G?=
 =?us-ascii?Q?S8SaQAIJQgrLh9eSK2x3Xn4GeW7S9x3YpPKJ/f6kK2eBuhAr1qCp7Zdey1rt?=
 =?us-ascii?Q?zF8XuR+swXV+TBolmmkeBYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sd69RK/Q76pVEqk08MNNXwt6lhm+Cze9VGU/ErzuvN4VkeKqC/d8hFSfi+/P?=
 =?us-ascii?Q?g722vmxA1dzcwNXd9hwC95Sp+cl2VY/aEt7wtKcCIKyVazDc32gr6is/5n4v?=
 =?us-ascii?Q?rBUtXg91vlE5MQmbxNCWCIwQPX3i5PiiCU5nrxODAs5oZlvxpXWOQP8mfCqq?=
 =?us-ascii?Q?MH1c9Ig6A9Ld3IIgjmAz+0eTwMyRjmg3987LkR5leBlRs6jUTHze7UslsfA1?=
 =?us-ascii?Q?SfuT1h/b08SAxLJtdpRlrSozhFqVMUAXRa8NNM2rvYLxhIMI1uyguVQ8GCpO?=
 =?us-ascii?Q?sbiaQYSzpY//sR8/SH23Ob890sh13nOug+M8gdJiJOxLAwJDFzzExUd6t95O?=
 =?us-ascii?Q?PVaHXcCWelvcGLseCMtGdsW1IUtgXcej2ZvmEBBJdS7aETws1ev3mvJFCc/u?=
 =?us-ascii?Q?H0MrZP8CwV4LnhNxDpkakA+6J95K4Rtt1jlycGdi/WWmOJxldBszoySmib6l?=
 =?us-ascii?Q?+0/Pi6lJSg9vyTyGVmfT9Av/ofkK0S9oJ6tVtVP6umNF06QjSxoKZOEp2/Pg?=
 =?us-ascii?Q?wAXhhyFlwb4D3pK/X+D8dHMfTYBp1Cp3Fpr534lquZLK/Fpjn4mqhEFtH236?=
 =?us-ascii?Q?w0uLTKLvIVbwaeIbyd6O9KXAy4y99vr2cQvmP/68dR79TJvRbqoOvtS1wFnW?=
 =?us-ascii?Q?d5jl7D6ZDXMS4fXp+skxGCm1LIK/9UCoip07ydIjvhNJ41kvqbI0xSg0Ybzy?=
 =?us-ascii?Q?Q8jnBiLj9Wv2oGkhbGX00GqdNj+RAosnr7+KA1kVx6gzlj+hzpWlQFeW9YYY?=
 =?us-ascii?Q?Xbjspy3P9iQ2zoSrsPJV3vHLDryzPbXW6pRJ/NUMFzmmSRDcKZOvdRu/fYtH?=
 =?us-ascii?Q?PIn6VySAUsL0EMpYd6tUofhCiKm/LkeThPm32uAVTJHFUKa/LSD2d4gCiIvg?=
 =?us-ascii?Q?tqmoki5Cz+QUDVeNXKodh39AD/0k6gzKaynDLiKu3XuVT7QolODL03oyjuag?=
 =?us-ascii?Q?QogrWvNaJqv0nE1WR0Rr4QWID5fFb6joP6xI2+xy7NL2YRDQpMO3EmqdB6r4?=
 =?us-ascii?Q?z2v8pTvGZWZRPq+btDJbFSgRLpl2MLrJtnsYCps2x8Ri2zUvcaJWyi8zbGVX?=
 =?us-ascii?Q?BcnHzPXxBiF6SPM0i5ZZ/twhtQmwcg2hgUINKLlqaSKG/Ouf/5yNHK700jvY?=
 =?us-ascii?Q?bOMufpFWok4grbfqYYnQONxrpgHKuspxNCxqe6u/LJKabmo6roVOzIX1ECxr?=
 =?us-ascii?Q?yrVCfxKTqx7X1NMM/ud2Dzha+o8IrLa7+Ku1iSgrvTbESvLgfsm7s8tUlLIj?=
 =?us-ascii?Q?p8dCIgIG6+zls5X3R8jhwJ0SFBbj6CGRMDHbNsRKZsos/TDuHmYw3OzW8Zuy?=
 =?us-ascii?Q?o3TVtsK2g5BgdzM5I6U2ImyUjnmNzGzn07WVOH4sNubn/jS1vDepD7kOWmRF?=
 =?us-ascii?Q?h3L7LL9i5ew9dkrbbU6l3SjMdPE43lUelX0Fs7A+4g5I0Sdjfnj8rTmp9FRc?=
 =?us-ascii?Q?1tmbIbkvEJgnEgKP3HFQFkOiMwoa6Tudy9CpTraKH4d3KlnDJvMLEM3T57ux?=
 =?us-ascii?Q?afZJNOB/ica5n9Y6sSXca0JwLt6UiUQsgbaSdPpcu8S16bXtbc9eBYz9FB60?=
 =?us-ascii?Q?QyQrsf6uhquzlQQD+imQFbdVBVX4QcAgdHbZbsYXhfkodYWO9Y2Q4Iy+/1ma?=
 =?us-ascii?Q?hBheOmhICugerOEhjb/C7qhDR5XsrlRSCYgMGuqW6VuoxrYJZ7LYuJaBjy5i?=
 =?us-ascii?Q?Xigo/yXRKiWQ6fYKkFpqaJU10h9/4cwsDZUFKad+QKL2bOBCRLR34AZOSPmk?=
 =?us-ascii?Q?0IJSkmUgIA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801d787-f18b-49e9-cf11-08de6e1b3250
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:42.1291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4g/0hJmL34UsrSGgOurSZavMiVgkK8kpGm8Bu/ayGl/taHRAM21QSd2GA3hC4kEmOUJgjxkMQNAzZSNW+LNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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

Mkeficapsule can dump signature for signed capsules. It can
be used in test to validate signature i.e. with openssl.
Add an entry for device tree node.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/entries.rst          | 4 ++++
 tools/binman/etype/efi_capsule.py | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index a81fcbd3891f..91f855f6d7a3 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -552,6 +552,10 @@ Properties / Entry arguments:
     - public-key-cert: Path to PEM formatted .crt public key certificate
       file. Mandatory property for generating signed capsules.
     - oem-flags - OEM flags to be passed through capsule header.
+    - dump-signature: Optional boolean (default: false). Instruct
+      mkeficapsule to write signature data to a separate file. The
+      filename will be <capsule file>.p7. It might be used to verify
+      capsule authentication with external tools.
 
 Since this is a subclass of Entry_section, all properties of the parent
 class also apply here. Except for the properties stated as mandatory, the
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 3b30c12ea514..022d57ee5519 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -53,6 +53,10 @@ class Entry_efi_capsule(Entry_section):
         - public-key-cert: Path to PEM formatted .crt public key certificate
           file. Mandatory property for generating signed capsules.
         - oem-flags - OEM flags to be passed through capsule header.
+        - dump-signature: Optional boolean (default: false). Instruct
+          mkeficapsule to write signature data to a separate file. The
+          filename will be <capsule file>.p7. It might be used to verify
+          capsule authentication with external tools.
 
     Since this is a subclass of Entry_section, all properties of the parent
     class also apply here. Except for the properties stated as mandatory, the
@@ -101,6 +105,7 @@ class Entry_efi_capsule(Entry_section):
         self.private_key = ''
         self.public_key_cert = ''
         self.auth = 0
+        self.dump_signature = False
 
     def ReadNode(self):
         super().ReadNode()
@@ -111,6 +116,7 @@ class Entry_efi_capsule(Entry_section):
         self.hardware_instance = fdt_util.GetInt(self._node, 'hardware-instance')
         self.monotonic_count = fdt_util.GetInt(self._node, 'monotonic-count')
         self.oem_flags = fdt_util.GetInt(self._node, 'oem-flags')
+        self.dump_signature = fdt_util.GetBool(self._node, 'dump-signature')
 
         self.private_key = fdt_util.GetString(self._node, 'private-key')
         self.public_key_cert = fdt_util.GetString(self._node, 'public-key-cert')
@@ -150,7 +156,8 @@ class Entry_efi_capsule(Entry_section):
                                                  public_key_cert,
                                                  self.monotonic_count,
                                                  self.fw_version,
-                                                 self.oem_flags)
+                                                 self.oem_flags,
+                                                 self.dump_signature)
         if ret is not None:
             return tools.read_file(capsule_fname)
         else:
-- 
2.47.3

