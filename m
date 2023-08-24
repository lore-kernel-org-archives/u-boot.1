Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F136CC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9909E8689A;
	Thu, 24 Aug 2023 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="SQos75N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2058675B; Thu, 24 Aug 2023 18:25:54 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20830.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::830])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F86E86795
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbLwFn3Zo0gcMIbCKIk6cN8hsG+1WGLREcOLovZJm5tJwAgpqLU9jh/LnyHNdb1X3aGu3uVMAazjoF4HRwRZT1cMPlgUumh1lEJD+D+nywFeZgwzaextKH6M1eHn0XJTuxcEmQjtH42ki4D6zBii2si9Vx8ytL88ncOA4gGZq5DSVBUdKPFU9SPFz9l1pF6LaBqq2P6Fk+p7LHB+I3F1KIjYpA9c4OH4hk7bpl/eUIUhMbvSBcAkHPIDo7CSDKcrMDqFaFNDS6EtkWSX4m2zRB0RV0ea24m9vf3jsWyigntLGPZCVYiUdu3SAN7Skr+GgqBOWn/ybiHoDTT5VHBedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CayHwSgeK3vhyxeugNWW7skytv+MMBeqTC/GpTVjeMM=;
 b=M6/6A2xLefOkvKWb9m4QV5oIyBSXxIT6KPocBm2yXw3qnMjHVUXs01qRc+TMKbuJ2xZBkVV4jqmxJq7JIeW9GxngrOLO5cA1khxvGvTqpgJ6a8OwYcabhqNQfypfBgtmgmKubUMUKbWtqg5IkeOZ7QZ+FC+ddNr+eGqE96oUoqJG9EPxiPoWvGEkJ7BY5T1s1QiXAnVo8AlGp9J013C66SPUt8hQyqetf0TwbLnDjy+SKAEuR145wbjuhwLkfoEjc1JK/uGoTz07bZw3FvKJZ2jqYx5CYFRgkE4cIpWEJZjnfMo0gSj6AljvRsSRx+4CIR2wbOaNLN1rBV52oh2yIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CayHwSgeK3vhyxeugNWW7skytv+MMBeqTC/GpTVjeMM=;
 b=SQos75N85v5HWEOhUMUj2+iQbyVf0wqCKC03aNxO3dp+aT9OIU5S+ggogAxf00mb+tlq4/dynVRvezv0pNppRmo+owfm51IsimoLPD5QuYvj9VyNX+KPJ+26vpW+7WT/UQ3ygSEsofT3YWN/X6Saq3LLBAQVgHGvb3RsuHVjAxEtFPLheYHM0MF39Ec3wawb7EG7lBM+/3DXZUYa7lSZNjLW08zeJd4N1GvOWqnjc/vwDMzfGdZEqPjeoouUwiow305QNqD3/7twFwvc3CaEJt3k4YQaNp+waqlXDktXC5ZQ5YskftNGFE78vF/BZtz7wDEU26sgntj2qGzogc76lA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3381.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19; Thu, 24 Aug
 2023 16:25:46 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.018; Thu, 24 Aug 2023
 16:25:46 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 sjg@chromium.org, andre.przywara@arm.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 2/4] dlmalloc: Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Fri, 25 Aug 2023 00:25:19 +0800
Message-ID: <TY3P286MB26114FDA449601B09BFB88DA981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824162521.22240-1-wiagn233@outlook.com>
References: <20230824162521.22240-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DH3KghmuF6bBcwytI7NJfKk26IprvlWf]
X-ClientProxiedBy: TYAPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::21) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230824162521.22240-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: e635b2ba-5eec-474c-c1bf-08dba4bec552
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWwwxxe0VdV+IxBz80lnVIz010BjCj+MYkUvRXoP5Bc1JQRdkszmpYENDdHppDjCpRwpuPyJ9k1O0TF2gLPrbyQohVLLBRl0vIa9OGel5OVHNnTuWOzcC8t7kwtaEzlm8A4RtfnnRJklbSmamfbG7EH5n1kCH5E/0RWctKpVXmSS81Rklnu4eHUSodENfDahX8eUkXxhHOFWPV1VHLQXxTtTAV+eWwh7BjGIG77BfUuIzb6OBnG+K0P6sjtqDedHthtXmHdWlqlsq8R/dCA6jnQrgbyjyHEthU7TN7qGOVuisXTD0z+PKfq6CUlisz2A71cVYAhPVq7O64NWetC9Gu/fT7tiBlrw7SzgE2GJzxRoXrTyvZWq7d5fQcCpfbFhBkMGP4k5C/yKTcQOqIwGs1FDQC33m0vdkw9MeOkk5aMdXB6ZFoNMX0UdjHGUA3sJrFO44Tknkoh0fHUFgHkAikiTHI1a42jhte+OmOhzIC2D6k4tmSAs7u2Ey1mHZD1gE2Lg7KxDoVesMlvtnc03DNq8PJzKsGTCLVTe1zaDEhxGIx+EEH5hXShostWQJZXhFxP3jfPYa9NbijKK0vm8LKooB+i/DUgWzdoOiaWbPxThzJmM+eQj2WBiDtQWFq6tCiRfE2nhpuJgsIGj9yvA1WSWttXWOnUMbb6DDxFBA6uQZR8TnrIbB8YSa6QBJQFyOsek3Ba8yRcH/0FSSplkwWOv9T8J0RocFzeVF3vKfhrlUQM+VtM7/YO+6vysrjZBJO3BiPj+uhke8hCXpDNyB/J2mJ+2wp7FxQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpLrzrk41cby985BW4B3vqVYltyOfjel6rCHxlnM3j+G2E0CjIMk4Us2C/YAOrtn7s5RFsJrobpNh0mnjKEsPzA9dDCWSa3vt0HaoTSkaQo7lNybznc+qUkiIzcsXcJvPlmE3GpO1ElsYqDTy4PC7gFY2LZcz3/EKuONzPiL0MEEhokBWRVuHKwJXXOjKzverUAtaiHimSxccIeAym1i8f6koQNo6NCmy5VKWv+Hn30xmhi2MG3FnjrP9UPi3Std50tXE6VLhdxRzUY+gsDXeO5LZ2mjNTAkRhregKg09b0j5TPUPz7QPnkC8BD3SZFFLqfzlGwBdZNJW77y0opRFuY9C70JbGd50VRoEjG0BBaEJGYVWlmllE5bGDOKhLRrBGOWcqMH4vHvH5hHnFs30ISb7aUTdRqasxIyyIQNPnyhJKE9CccD8mblOoi0/M6yqQcrUSqVeb0NfMfDrfUuibJ1HEOmOtG62UfdVeHO8iruo7GDtv/0SfmZEdp++Vju2ehJnfCuWW42CFSx3ixFGSMdfJCnrhzxRydsF+ARJL4aZKkGroxD6YKO9fMygZ6Ski5GYkY1imkoYS+AnVZPYj8wJb+hUnwO891j/Z2c455J0pF0f4YJ7+0bqc3aqtTb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TVbyWJQd89JCopxh9z7khIC1vTs9oKCwJBq8ic6zQMmPIVN8wldzltww20s?=
 =?us-ascii?Q?jYLjpDvfbT7EC9QtIhKtnRtdZIJ/lVeOYfUdOJ0dC86mjW690OvUjLdrh2NZ?=
 =?us-ascii?Q?KVc6T09e7UqN8Za+i2iY+cHJYulasoJOmJgXegYCm/1eFQ2trv2vno4euvA2?=
 =?us-ascii?Q?OMb0XC/lhFngQiUHMltzQSfILtENbgaBMmu4mrit3qjbg2nJRZOmAzcbzO33?=
 =?us-ascii?Q?9/sPZY3no6EdnoYL5B+TJXFaTGJr/rbEUF82UDn+NgLjAxwbkxVOvTCzFq/p?=
 =?us-ascii?Q?hk/32jJO3fkvMOmFp3BH9XTZjlGzr5ua01mql/KhtmecIaFkYLkfV0GNAWEj?=
 =?us-ascii?Q?tDed2/ifxjz+gs02vZOk5e6ZMsgzp871vltSHBdCZQCuFPOYVSGkK0F6T+I0?=
 =?us-ascii?Q?s/2YobX/FwyORBlqFQaJyUWG8ZYmrLD+q+VaZcTGKrgODDHJxXoXXFgv8Swd?=
 =?us-ascii?Q?Z8fPkKkPiMTc2ANCgwqnggSsYVfHMSfWnLUcsoK5zzjfy9EAcpQTH6M8fzWM?=
 =?us-ascii?Q?y5p38MAN2NHqBy6WZxQ3bgXGKXVWdyDr/HIeAoS6+Z/BhmJJLyE1AMdy3r3u?=
 =?us-ascii?Q?S/6/0oxhujDaW72oasL9w3OrczH64ji+O9DahGL3TsS1mJKqPH5DoyEmXS18?=
 =?us-ascii?Q?RNOP8XZKxiKme+8/9Cw+ykHAkCchNuEYfBZrYSxPLJQ0E/Sj9AnTgfhWtyrJ?=
 =?us-ascii?Q?IJ4JQSziQb3Qaun40Ytf7G93K8oLNwtX1EthaC61+J+2R+MpCuQ+SRpJOICp?=
 =?us-ascii?Q?OoAWAZAZpU0csWdhxqsewuT3qNnSBG5Tt4MsXe286TfMK/+qvcOh5XfM8lYk?=
 =?us-ascii?Q?W85BGDUcr6KjYABNEjayHlvA6qTLqLVl11Cry3U0aUSXps/93qPJyalZ9eWc?=
 =?us-ascii?Q?uLuA6/RnBVgjOspGbA8sQEGH40ukV6OCs2sOPyQJB32G5lhDaEeX0sYmlhvp?=
 =?us-ascii?Q?CVUVtqrpjtS1oQQMTvIDGkob85qkAc5d9zjmjD+nIQyRiGCV8bWzxULVQuW9?=
 =?us-ascii?Q?zlbrAL8Vgzq2XkATSQiBrLro9vZFz8ne8rItELi71oyQ1t+bLqAVv2HC0GR4?=
 =?us-ascii?Q?O3dgEWU+NQ5rg1pdQiy9s6zUu3A+5Gr4sfsyKqxwDfqDOfHlQi/aU1YM9eFq?=
 =?us-ascii?Q?lt3ffnkucwEuCKGUS+uOrXqdQefkMeZkttT0hCQC/3yjocQoRBZrpwWUvL5H?=
 =?us-ascii?Q?gorBs/+0GeuggNHKJqJNw5vijaGdkfI3/4AMFA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e635b2ba-5eec-474c-c1bf-08dba4bec552
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:25:46.7763 (UTC)
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

To support SPL_SYS_MALLOC_CLEAR_ON_INIT, we have to modify
#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
to #if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 common/dlmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 0f9b7262d5..dcecdb8623 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -631,7 +631,7 @@ void mem_malloc_init(ulong start, ulong size)
 
 	debug("using memory %#lx-%#lx for malloc()\n", mem_malloc_start,
 	      mem_malloc_end);
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 	memset((void *)mem_malloc_start, 0x0, size);
 #endif
 	malloc_bin_reloc();
@@ -2153,7 +2153,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
 
 
   /* check if expand_top called, in which case don't need to clear */
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 #if MORECORE_CLEARS
   mchunkptr oldtop = top;
   INTERNAL_SIZE_T oldtopsize = chunksize(top);
@@ -2184,7 +2184,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
 
     csz = chunksize(p);
 
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 #if MORECORE_CLEARS
     if (p == oldtop && csz > oldtopsize)
     {
-- 
2.42.0

