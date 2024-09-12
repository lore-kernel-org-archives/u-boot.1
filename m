Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0E5EED608
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E23388FE1;
	Thu, 12 Sep 2024 15:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ECvsQOUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAD488FD8; Thu, 12 Sep 2024 15:41:56 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA7B88FA1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEnd0U0BWneI05mTXGeripjIchxyTtrPW6axWJT/s48vr4aoJe6UAoE2NTzBGtowC5hvXhQHeOLA8b7FsqG6yf0XeBxuoo2Qm4aGiKM0gZ4SjBQU+Hzv9VWjCqJRajI8t28xaGMFfCTvIrZwJdlE2p8HcSMxCDusWzCAxfFUevpS2NvtxaSdwx3ecRjRK4AvRTzuoYeNtnQ2VO6lO4+scBmrTxQ4OiP5nO4qcuvpVb62qemBY82l+AHJvLIRwek9LR0T/v8rB6HUvwAXC/MQsioSm/C+LgZtRXrg5KF/LC8DbFMQaccSazpwu9dfLutNAO/8WhtvAKRyf5fqIO7HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PErSmAMOlOG/DbkWeb9UMXubplcmykd2zEOxqKQZmT4=;
 b=J8fhidkSfjQ+YeoI4jFgsbT1SXGwPN+WlYAnUJrYVCPZriYsTOJr/z1gQTwyeFl7IJ03apEj27JKHclGS7fAuNugRoQ51fZM3pjNVZczCyVZ6K6o1ZzuIWKTieQl31TECPcthMeOFRt0flN3ZL8RqBgDGKm3FxFTn5YHgUsx8q5I4V5qrqi6ENEHdwY+6sX67ESqW9zMGj6X42wkqwdOUHv2HEmtmEiscoexodyvd8WgPxyb0UU9geB6ofEg0PfcjiSFgflfEiYsfqGOdBcWk73Y1eOj6NuFXIvV9oj/o9YnHxSEmkcl/ZcFuIdteI1qeY+3bI4vIyHMyzXz3UZL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PErSmAMOlOG/DbkWeb9UMXubplcmykd2zEOxqKQZmT4=;
 b=ECvsQOUgqrcbNDDvTm0g0N1czuEPofg42xt87YXdvIVcoEv8H00FmKgi2Wtssi5GrlS1w7yejfT+V0xTEHgvMvUDvBmI9+gmD494pjtPAdBZ2YZmxoanqgC3RAOJqMqOccBKlX0Z3il+SHqrdTmeOEkxkej23J8ImrME9CeZ2to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:41:47 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:41:47 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/3] env: mmc: rework mmc_env_partition_by_guid() to work with
 two separate partitions
Date: Thu, 12 Sep 2024 15:41:41 +0200
Message-ID: <20240912134141.4143855-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 77545e64-da13-4be6-a49b-08dcd330a586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BYwzmQwo8Kk72BJJ9smIL61047ODgsHfTDBuMQpz2Gh856oAOf7hiH2NUQaY?=
 =?us-ascii?Q?Ht3DzUsZvGLYuPqKZr5g6OBDHWxYmxRYXtB61QsAJaB463YbuBBlHrU6MfeZ?=
 =?us-ascii?Q?BVJDCssAsgGf2k2qUfxJ150okAXMhaIL+s3viVAEfSdtIdDnIkC+ov7E2zHm?=
 =?us-ascii?Q?Eg1cQXxLGO8e5lkYeepR6vqYAGMAHOVQstds44iN65jlRHqPWaqiMf/00bYi?=
 =?us-ascii?Q?fllTuV9TTEZRNbOr8fGaQ83Zke6dyWi+dfes4vVVd1S898NipYrVrJrGa1Vc?=
 =?us-ascii?Q?YFUm1NsT7YKQ9lRZbFKPedi1KwuK+uvLvOzTYmkHHRzexQCG894Xb9qzC5fA?=
 =?us-ascii?Q?YB95vTsUUMhi2WWy6KbAQt8qmqdWkq42E50sE0snCSzKKfDSQ7mHU3YMGQUy?=
 =?us-ascii?Q?RgTXaJvoK8pEPnDFlPK+zVF7l5FUxwJ5qFkrhwFaRE6VzJxYUmkTrir6wfpc?=
 =?us-ascii?Q?Wc/oxYD7YD36CS96XeSfHtxsdrCDmfyYJCDSEYsuPK1hp+Qtg2tPLSc/JY3m?=
 =?us-ascii?Q?UPnr/jiTI4oob6egEhMzsJYNbD+ej7g1OCbe1lOzNjCVh9Vsq9wS/DliaYEu?=
 =?us-ascii?Q?6jtoMY3J0VdIACkjZLmVmmhhr48rJoNP/p3U+7QbRSIWiKsg97kWJLlfazLA?=
 =?us-ascii?Q?orEaK6e85y7lvWpiBDwzh9WpvQKzgPl416abElg+SI1FRDoXmAZUGA3tRT9n?=
 =?us-ascii?Q?XB3A3ym8+cAdSjtrBbQpWCYOr8rk6krJ9RJaAFqt0CXSBnaQsI3xqLCKfqEG?=
 =?us-ascii?Q?FJU7rc56Sek1Ri9YZoKtLlT2rxWLIgEYZCWkQmd/JJKvLwul3mzJwHGIctKU?=
 =?us-ascii?Q?fCk2cnQSKx+Bi9sDuPSZIi0TFs11tFiosCEbbj8+ozWUJeR0LWnE6Uib8esW?=
 =?us-ascii?Q?IJURGHVs493bvXaVT5OdOZgd5jIje47DRGMmeJ6lMh4FCuR94WY7Uc+cdlOL?=
 =?us-ascii?Q?mzE236wO2/CFb4MN5MWwd7zl4oFWTzRpQ6u7V+qIKCNqGGrAuMo0nOf1u48m?=
 =?us-ascii?Q?sd/ZbuauyJDhVNjVtQIZOw9zu5L7QZPSHNuJ65YfDAFGFhu259ec/I50sNTY?=
 =?us-ascii?Q?MBM6Sfp989Q8bHQk6lOATQseoKHq3veSKPONW/tViCSc2IdwCk5FbS3Xfl3A?=
 =?us-ascii?Q?tMMMjMpNdBKd+IN03AXuyqEq5KtDebgQ1glGhPqegR1RZRkn+olGknv2996M?=
 =?us-ascii?Q?Hecqzoqe0oJda8hNBxxlTIGANkHAU6xBwbXdUDk+Kg+TVHbuDlOY2AluYcK+?=
 =?us-ascii?Q?fnsdiV2B+L2bJ0BiiO6rMo8XDXRaK8GOEfyMEuAx9uNxEgdgl4PdnZC08dkR?=
 =?us-ascii?Q?ZXSVhB3YGc2aUldVbolZAnawzW2M6sbV9sqitvxvK8fkfEGX1z8f3d1f7FAj?=
 =?us-ascii?Q?LC8yLnHY+FIAZB7SiBAmHvbHpFFc0OD0yqRIY+8rJXCogg1Eow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYx2AmuYSKz4128xxB0Pz04SsVr/gsB+VusU7FASBmciN/aVuwmDuVY96Us5?=
 =?us-ascii?Q?R4miB5PIg2TshylPMe3zvQB4grg9ncJ2KjtSMhXpKe1C3N97Y7pEugBCKQgg?=
 =?us-ascii?Q?N8ZUEl9WXQvsGjVY9h4JwPp9Lf3NyfQ5tmPg66NsXhtGcpkuP3YdKPpyM8GA?=
 =?us-ascii?Q?p81yUu70FqRADNBybJaqWNC6G8yAs/GrRQi5ph5lAE9WBURHg5gpk6SbaB0v?=
 =?us-ascii?Q?kpZkomIhyjfoiPS2b+f9bOtnq2shhKlnTvVlBtPnNxVeJIjxLU3XLLN+viP9?=
 =?us-ascii?Q?KixBHIVWJ//p4nH+b1TC3KI/C1yWq7BR6F+4bnURkBIo07f5z97zxdpjoXMj?=
 =?us-ascii?Q?TSQxaaX6IyPjrIY3uiHAf3lNiYgFrvE3CHDlHMkcRSEM/hIgssZoBz1ozX9g?=
 =?us-ascii?Q?Yftv6/6WVkHjVp4ZbtYCw26vXwCcwjRq28eEoKMCMoC4MEFdgTe69o3FEhJZ?=
 =?us-ascii?Q?4LuJ/PN+EynW7q6DG7jRYBTZSux+CvCAzFv43yR4reETaltu5VwSdAYwkCcD?=
 =?us-ascii?Q?QLH5UO0EHef8beKB+obG1ydw4DLsPU2e2hWVVSTNJiMfLqXNQLClF2LaNIa6?=
 =?us-ascii?Q?aOcm3RU5HSVANXybMlxjJ1vMvWhMRN7YALb0IdD7pREU+Al/ryaWZZHuqP5x?=
 =?us-ascii?Q?Ki+U2MBQtfJ1R7buNuwRJG5A/ZeU2mSFcoXnVkJEU2PakPbfL5URRZuFOoRZ?=
 =?us-ascii?Q?C6gy8X24zc+cFajaaT9xkbl8dV3I9kad11726jxRTg83poDXsqPGPvwvjCJF?=
 =?us-ascii?Q?CuegoCqTXdop+vkpaHqTV3xd68QZ0wwtsN+g0oP66/xHyh1EnattOzujnjA4?=
 =?us-ascii?Q?T4wKkbxS8DdtWYq7Sp8Yzh1OUSfHyZ6Reoa+jzrWym2jeV1TtL71RZrx5TE+?=
 =?us-ascii?Q?u3TTpfCUqLVPSsFW7+ePdiKVxhDew3aiZsR0O5EMJsfVB1bvrmtklBf8ZOsU?=
 =?us-ascii?Q?CGK+5/ZubOwirdkjL5mpeepIKGN69vGh2SiJ0fma7mnujpGmLWS/69T9R7yE?=
 =?us-ascii?Q?t9fpHwpntLki/VVe4CXraKWp6iC2OZvSjEbZVFewfhlwEuTyG43uwn84onof?=
 =?us-ascii?Q?2KxLEgrtadr4xMYNyUgD34yOyT0xV5SQLf+wfU+zvNswSRIdYH74tqFYmOuu?=
 =?us-ascii?Q?tP7U3Pp+P9Qz5q1oq7EY7UQPetuFBIxPSpo4HrBMrRV/2i//V/T0sJHkuRas?=
 =?us-ascii?Q?rYEOGYo3szHdGUvAeHfz3FUJ/zCrHEMFWbmdNc+z4lM7/rzFm+xNLekQMj1o?=
 =?us-ascii?Q?LwMPLyLAWm+lKQQFAfbZkB+WkmUVTWr/m8s8L5ySmpi3S/2uzDiQg8+l+FKT?=
 =?us-ascii?Q?DkgLLenqVYq6gibMEhd8H0rcVG7eVjEVZjvhIWjh0q8CQo0BnaKKHOWOcN33?=
 =?us-ascii?Q?lijUVsICiaVBeFsplPopVXL38t+yEfXKEaNbsipKrOFLQtQUHeHX2JKtnJmr?=
 =?us-ascii?Q?0qbc6Dsml8FBlBry1HHiUTu1zV3gkO2S9jwdD04JFNzPYgqQ4ZP5gWeK9X14?=
 =?us-ascii?Q?vuATqBLliIrQjyXUOpAyxxqZ60ETy7hAmOWw7N2aEt6+Z8fX5NI7csLmxM7D?=
 =?us-ascii?Q?07rjzklNEn0dnUlYDbzOnot3FtgnCICmoLDmDpPniPQlRg9mm+KDTdrScaRN?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 77545e64-da13-4be6-a49b-08dcd330a586
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:41:46.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48evPl+L6Am0uc+pmgJboFzu9LfiA4YDKGAo+WL6KDFcE49W5nfqGGm/KmGL4a4xaGD6rZqiGmPDbcV49H8LXbTEx/4QK10sovMw7PfMkGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
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

Having two separate partitions for use in a redundant environment
setup works just fine, if one only relies on setting CONFIG_ENV_OFFSET
and CONFIG_ENV_OFFSET_REDUND. However, if CONFIG_PARTITION_TYPE_GUID
is enabled, the current logic in mmc_env_partition_by_guid() means
that only the first partition will ever be considered, and prior to
the previous commit, lead to silent data corruption.

Extend the logic so that, when we are looking for the location for the
second copy of the environment, we keep track of whether we have
already found one matching partition. If a second match is found,
return that, but also modify *copy so that the logic in the caller
will use the last ENV_SIZE bytes of that second partition - in my
case, and I suppose that would be typical, both partitions have been
created with a size of exactly the desired ENV_SIZE.

When only a single matching partition exists, the behaviour is
unchanged: We return that single partition, and *copy is left as-is,
so the logic in the caller will either use the last (copy==0) or
second-to-last (copy==1) ENV_SIZE bytes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 env/mmc.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 5d09140655f..e2f8e7ece28 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -69,21 +69,49 @@ static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
 	}
 }
 
-static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info)
+/*
+ * Look for one or two partitions with the U-Boot environment GUID.
+ *
+ * If *copy is 0, return the first such partition.
+ *
+ * If *copy is 1 on entry and two partitions are found, return the
+ * second partition and set *copy = 0.
+ *
+ * If *copy is 1 on entry and only one partition is found, return that
+ * partition, leaving *copy unmodified.
+ */
+static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info,
+				     int *copy)
 {
 	const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
 	efi_guid_t type_guid;
-	int i, ret;
+	int i, ret, found = 0;
+	struct disk_partition dp;
 
 	for (i = 1;; i++) {
-		ret = part_get_info(desc, i, info);
+		ret = part_get_info(desc, i, &dp);
 		if (ret < 0)
-			return ret;
-
-		uuid_str_to_bin(disk_partition_type_guid(info), type_guid.b, UUID_STR_FORMAT_GUID);
-		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
-			return 0;
+			break;
+
+		uuid_str_to_bin(disk_partition_type_guid(&dp), type_guid.b, UUID_STR_FORMAT_GUID);
+		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t))) {
+			memcpy(info, &dp, sizeof(dp));
+			/* If *copy is 0, we are only looking for the first partition. */
+			if (*copy == 0)
+				return 0;
+			/* This was the second such partition. */
+			if (found) {
+				*copy = 0;
+				return 0;
+			}
+			found = 1;
+		}
 	}
+
+	/* The loop ended after finding at most one matching partition. */
+	if (found)
+		ret = 0;
+	return ret;
 }
 
 
@@ -103,7 +131,7 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
 	if (str) {
 		ret = mmc_env_partition_by_name(desc, str, &info);
 	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {
-		ret = mmc_env_partition_by_guid(desc, &info);
+		ret = mmc_env_partition_by_guid(desc, &info, &copy);
 	}
 	if (ret < 0)
 		return ret;
-- 
2.46.0

