Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0ABD3E798
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 06:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F47E83655;
	Thu, 11 Dec 2025 07:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="tcGW/AIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9D48367F; Thu, 11 Dec 2025 07:39:24 +0100 (CET)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0E083642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 07:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgCNVnKHU66rLaTiXazoF6f1Dkj5nWLTkyaFbte11Ci/rOxy2UMFIzUPk4rnaZqxxC4AGdjmFyN9sJqTBGzikGJaoeO5+UvL9AkK2jWIXkXkJ3o2vhWuunVtkjUH1/PcOjj1unTff/6D5M0SrT7f8NCuKUkWthf18eH+WXCIquE+M9l8LCjahK1Mk5tjT/4RbEQ755CUQY7OoMQFxThqkyPblHIxLJJX6N4rWdhnfsqDVhUqoVE/UGaF+YEGJt8y92Ey7WyX4EitNU9xJVchBbYBCAFRdE0RucMdehGn8NpqkZHuKzFS5wx6ALajuI4hLfQHuLh9zaGGfrctS/ZYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qarrNbJKfVr2FHQFdGTlEHnhfZmDapiPVqXNK1Av1eo=;
 b=guLy/1/V4TCqbxztZS6pNgtFMNLmMGwb7gFMyz2v4y+4/vfU62qYAQoIXSivovtsIHpwEoTf//DMxDJerUznhReHecX39ENTDaSVAbmldKLYAh0exFc19tfM1vQbnfsFjYlX9TfDwA7lVj8xBhqhb7ktVPOB6p3hTyDh6gfTl+JALOa8mJlVskilQj5oTOH4Zl/RR+XXuBQi7qBQ+hpgggIqgdqLhRmIgmnrKBGELMwbm3EJBsdG09/Mb8ZAsMk1yIAQhB8b3UdOdO9OHh583CcpN9Rq10A/twwF8J0TB76h96wrMQMCnU1agopH8hyGB/wBlQ0OcTtEcWut1ZJl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qarrNbJKfVr2FHQFdGTlEHnhfZmDapiPVqXNK1Av1eo=;
 b=tcGW/AIQjA5zMuumALIYIkI+imcCai2GG82o1CMDhfEWfwu9nO0dGuHEDkIBC0usT10vrlY6mQsbGyUntxFLKlydhg61FS9ZKiIlKfOVuTTgy6XWD4kY8k6DxYdR8SnaibORO0fI53KAUlbq2HA+5nysLJFtxRXfqgYcvAZF/BqeOGN5CnFK5VegJEmmlL0FnzBSI/cOry18mN5ZuEIx/T9MitMvtgPXzzaq0iVMhiXsG3jWpIk4xiixrz5t4Vk5CLGr/pO1DnAxdv8PsnfqCyIqd7JSx7YuPw410Ene95DMvJos2l0iIun8S2UCp79eNveZj5WCoQGI6DSto595tQ==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by TYCPR01MB11896.jpnprd01.prod.outlook.com
 (2603:1096:400:3e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:39:17 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:39:17 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] common: cli_hush: clear Ctrl-C pressed flag before exiting
 loop commands
Date: Thu, 11 Dec 2025 14:38:38 +0800
Message-ID: <OS7PR01MB13834F194560C2E3E4361E252BCA1A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251211063838.7259-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|TYCPR01MB11896:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c1daf0-7fbd-45d1-707a-08de38800060
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|41001999006|5072599009|12121999013|19110799012|23021999003|15080799012|461199028|5062599005|1602099012|40105399003|52005399003|440099028|4302099013|3412199025|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ciROf8yYuulrW11B66R6gc2JGWFHsQj8ioazV6IT/Hd1agk/bZk1/X7d0/A?=
 =?us-ascii?Q?0iU48bjkAXfZvzPjBtn92nF6qT6nQQKzDcwtxjeENLWma76eXs+Nsg8fSupB?=
 =?us-ascii?Q?eCcxz7Y+Fr6vs/kBU8Wavo1ZPjG1u+/3sqNmicN0CC8Zps3dnSDbSO20sond?=
 =?us-ascii?Q?w/d5jk0oocXZgYeWBbFF4dz2+z3oNDY2QtoMU46da/h1EpD9xS+/Gtkn7Ffb?=
 =?us-ascii?Q?sdJjYfAyB7PUjkVjfULkzLLiLlv4oG70DcKpi1LuSdWr4/bUVl/omU4YvFBu?=
 =?us-ascii?Q?Lk0KueRi981P4hhtpcXL1bELzE7mkvnuzVBSSv4dC6GcMBKSBEGnMWeR3cTx?=
 =?us-ascii?Q?Cug+wIq8jxSp35YFLp9rATCrSXQ74RPmh8UUbhBK4OFyJXmkll/x6wFKcBf3?=
 =?us-ascii?Q?mrV0JaRIEpLypzYEu1X2X87q3GyHvc4FK/GjzwekEEUBYwm7NlN6dVzmeNDv?=
 =?us-ascii?Q?EfwgT18ZAx//7354ahMk6dQ1HF+WEYj8DI4uD6pj+diwbyd5n/jvoVpmC12z?=
 =?us-ascii?Q?1pjbq+9wF8JUcsmsuc9OvNMNOg2qhUe0Mg7q61kig+ecgpuBwDri8u4sWrsg?=
 =?us-ascii?Q?AM3/mqi4mcS9zhtzsWsKcI91wQwLB5qKTqyRCfA1dz6oc5ZkvXtu1GEuwpoi?=
 =?us-ascii?Q?KT+Dy31J6qZRDfxZf5BCbV0qf4Y5lpUJqBc+acKSDe2lQ3XI1kA6olxoAx8v?=
 =?us-ascii?Q?wDNqmy950j6ERFJGBiy9Ivr+yhXhtseB4T+1obvw89weZ0gApRVWck+RKd4c?=
 =?us-ascii?Q?GAPzUQgmh4cPtwqEwrPTe3LRVA4vucwCPtirU6ahCzr9w0/PPUxy2kCtXYhM?=
 =?us-ascii?Q?1dZPJTvvAQA+uwbKA3xV6lBf2RSs9zcGxgx5A+g4W8xoc/IyW4w/6vyufrNT?=
 =?us-ascii?Q?i1I3j/YIYwo72HZyq6p/A7oUfM3+lw8Zyn49o52rAP/ZRK6cmr+hjkUXjM5S?=
 =?us-ascii?Q?ezbilA0n8+tRFQtVV+57XQg0GHgrroyZDEdouK3XoPFyluST1O1QgiMlKhW3?=
 =?us-ascii?Q?yNTiU0u8K8D8yaNWNkZNFpcXM8isTwEslfq3KfRnIAWH6VzmICF4Ke7b5rTc?=
 =?us-ascii?Q?gyAGMfgeKvOiYkYL0Gt4z0YdtTGsaefbNuKsex3Vq4J9wufO5HMktr4ZXwWg?=
 =?us-ascii?Q?bcX+FAVInyvkjK60MH9PwmWKv3vdIymFSeDpeloRVBZscoC8TiN0j4+3Rdvm?=
 =?us-ascii?Q?d7ovImapiybn8fvlnLRNNYTypN3ItbPD+CYOuB5vVDyqx6MvLbmtQXAgdZh5?=
 =?us-ascii?Q?+MYa/FWvicbK5WVD8HiURrooZ3AzArfrgwMLx/aqK3yYWRLbo1hZX3lCcI/o?=
 =?us-ascii?Q?6xhl2mOPK69TrsRgsqI10EzlpMyXkBMUPVS5P0RZwLgvMyq/pIxkZXebztrV?=
 =?us-ascii?Q?LwpxsQz5B42rXdrA+dEbU2h5NRCojgk22XsDZQI/8O87GQ7gUCkDWEkKEORM?=
 =?us-ascii?Q?/m6zIp4lmMEQu73AmNzpA6xzGNd08t0l?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYIsnObF0YEnONhKm76pxezL7CVALNFQmn2FCnz5pfLu0kVVyLVNyLA2aetG?=
 =?us-ascii?Q?7965r518PvCHG5WdHy8QfXjr4COeEaYz3Ewufz1FiQ25QHISMkucc3kTDI/W?=
 =?us-ascii?Q?kt+SSspn2N5iW2VAx9tMRY0VISQEKyZr9NwttWtFW6w/LuiEriFjq4PdgGmp?=
 =?us-ascii?Q?KXVWPxmkTnYqYqdfilWIdo0EQQD9LFA/heTeYCc+Yu4LuIimUy7bOMXmLS7Y?=
 =?us-ascii?Q?7CKYM54mi+C6JIcVNKrQzH23PQg90XVcDiRtm3rCb/iLS39CJQxje/saxuHN?=
 =?us-ascii?Q?H1vfkuZXkMr45LTHkmhx95t+jr6q3jmtpvhdLN25Z1xOqOZqzoKR8XxWgPum?=
 =?us-ascii?Q?/0ZQKPF7LR9YyqR/2ow08aCwzLzBde7/GZFNEJ0qcZOzBne9h4f6VPZ4nqXj?=
 =?us-ascii?Q?V1Bxe4ewuVUWuN6Z6Uj8vYV9sDxp22yAvIv+VityieuFdEOg5dhx2DV65Ef/?=
 =?us-ascii?Q?cWYu0N9vrjFWnDagoNFx57pnot8DpyWcG/t9OR+NA27gKpzEkJqX+fKIsK29?=
 =?us-ascii?Q?nt9CN5FI/bwBWfd4o6+RZWr7W52uqSxCCYj3/Fh4e1rlllKl6jRqZ1jULHpi?=
 =?us-ascii?Q?vBQ0wXVxy22YanPnHreE1s/SH1nWxjc8wuoYYqDz0GS13/Qhw7HCTAbcB29l?=
 =?us-ascii?Q?mHG+nO+Ez/Cl8/Fhcv4dBWowWNMRthr5moB8ufCcwz4TsrIolWPJbKd0fUN4?=
 =?us-ascii?Q?fa7dPTDb0WBw/e4RxB1oq7wJmQt3oa8v1pLE0n3Mxf5TCHuIZJq8ywOKnc4R?=
 =?us-ascii?Q?c+o3dxpSYV8b0fYVxWTAhkPMWPBaX+Z9ZrYJ6I0M+eaXohgPdzwv3AGB+473?=
 =?us-ascii?Q?z4320qtwsOmxyvhcFt7yA/nET7Hwoy0tcirPFuaQrJDT6MDskGjAzvNr9ade?=
 =?us-ascii?Q?Ng/3QUgcKyzXaegVY/D49hesUWRQduJL/WGscvhzWC5CQ1va3tp/3iIefJG4?=
 =?us-ascii?Q?0a5/Y4QN02xsLtRec/c/RrTz4J2BvgzDSGkQ58VRfku7usjeu4ESiAfDO8We?=
 =?us-ascii?Q?pk1dzqIQ3WFnTOveoxPihK2+UkrOqISWmyWLiL8XccF2eKXyLW4QUc0qxDTL?=
 =?us-ascii?Q?Uo8B2XfmNx/HeGMCq4YLUYkTKUoixjP0tmaakszaCCbRfeD/EVyjn2rfOO1B?=
 =?us-ascii?Q?/E9QQ1V/FWglDVA29R2occJVEOo7I4JoDjtchiepi8l9YNNs1P5blX86unf/?=
 =?us-ascii?Q?qw6PPRBSsIXh9nxjr8I4gjNZxvaCiqqQMxj8RIDhfsFNaaAYTz3gEvnK95/i?=
 =?us-ascii?Q?10z+tfeiahwHhFYm4WjZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c1daf0-7fbd-45d1-707a-08de38800060
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:39:15.2207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11896
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

If the Ctrl-C flag is not cleared before exiting the for/until/while
loop, the next loop command will be unconditionally interrupted.

Closes: https://lore.kernel.org/u-boot/OS7PR01MB138341D2719717E66B069F33FBCA0A@OS7PR01MB13834.jpnprd01.prod.outlook.com/
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 common/cli_hush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed..ec07bf6b3be 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1798,6 +1798,7 @@ static int run_list_real(struct pipe *pi)
 				/* check Ctrl-C */
 				ctrlc();
 				if ((had_ctrlc())) {
+					clear_ctrlc();
 					return 1;
 				}
 #endif
-- 
2.51.0

