Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC3ED3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E4A89A02;
	Mon, 25 Nov 2024 01:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD795895E6; Mon, 25 Nov 2024 01:33:43 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B96895E8
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li5XI+Obt9ZDbU/KuCUpFNzmPStpislV5H/vWSvqTNkATi/rnionIFakhnSY2jqJ0VPRXAllOmbLzHipj4Gzn2OdUkYzwsa5ceuG/SNKnv/bsHOepDrp0Sz6QdvxG7b0DLOg3L5tATzhQg4D9wTLmwt7n9MXAGCHTOvoToHzhhNTJ1oIzzKD6K95vne7CZuuLIVwo/phaObYzDOcC8KNazOl60ZX7fwRoG5CJJXR1AwBShrcUajHscsrryzpwwOmR1yaE17vPndO3luT9uwHFONG22RdHsMjImRZzC3cm74/2MX+tq2HqsAGChrfwu/sjWx3hPvHyEHfzkZmeQ2Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S20B5yzHmycnRkG0Ps/gkau0lzFVmjEcagpx5BpAn5s=;
 b=RQmSdDNG/IqswwE0Ij/WJ54Lo41Hwm+wr7OZbSZpw1IgbJVNCtAAoh+BjPEU2bIBtlndBFmeWjwItDesmdKHWpIJKVTe1fWBQ3e5vQKxgClWJ96JszplfDyd0TrU5XPoWGUtxRtZkTiHWIP8TogXiVgw0BlNj+eYkMiPmwYp0aNa5V47BEheLlMcjYEOi6VrBbQL283LhdFOrNJbCTR1rgfKtSmz40Rl8BktiyPQTV5mS2o8FXRqQ+mb8LD4sJoLSMmy02v4+ZQPNA8/zx25AqHAxNkcx84yhmxy+Zn0b4BjVR4bcCIfhgjqbjQ39iNQNeZ9a2Oeidyv1c3yR+LRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:34:02 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:34:02 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 10/11] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Mon, 25 Nov 2024 08:32:04 +0800
Message-ID: <20241125003205.75327-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 820f6769-1f4d-401a-2771-08dd0ce8dc0d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 4gE8l8lB0iY2DCpNd5nS+vRVXa8MvvxsRngEVfd4STiagw0bC7d5MUD9iTOexfor+zSnzn2iinNlLieFIkpFpZCP/6bTFWgZgbOaX7wv5mAF2XfkQvOqKRFHsszHjm/hr7XYxkoE7k3pN4b5aNfSzJNy2ZY+CekmOpNBT4QLIBUOdxjbkU/ylKkj51Jfy825oSlDZKgNH1QBCovy1LyeRzJ+hLsn+ILfOpIaxpvbo0JfBGcZPwAJTSfm7kFuaKu5vfEYDSg1mobHpI7G04mhSE3kx/7Mg85N3u5D8/jrg6GAntJgzMhZEvcadjNaYbCV11Q6wwyTGB6KcN9RIuTYwUUQXtd/ISVbEBlKmrgKggf4fiVQiIrSndE6T8mQOYHEMy5y1WXv2LZbqiDHsAB833Ak+mIy+JtZjx1UD0ZB0UvwCZoYhyi15luJZ9LTmPwapR/U/RnPoV6HAkE3fi3QfAgj6dTagF+xo8GBnwJt8iFhBOGWALMBcAkkC4SBk70ZGjtDANlvqYFFmEWLlqK0whtkzAwQiEE0VT/1cMzdIxIFVRBilk5TWYJmeIgEhCHc+nK8KRBNVr3Dk3fY4klLtk36g2WfC7ephx7+PY+D/8eBk95csOI5MZtrNggQFUl9z4YPVQw0kIiIvtPBC8Pogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q2YJvR6U55QgEzo61y5CzZMYWJUDiBKzUT8fi9P5GUBfOWXLIC9xmiUrusaj?=
 =?us-ascii?Q?LKqW2fxd8D7da/3a4VZgqQdmJIuVZXN/8PMPK4sF/nZYpJeTdk+jJhn1iEg3?=
 =?us-ascii?Q?uDwPBDydGVOhvRJMlN16MxJ19ug3NlOkfTAgAqD5jWf37EQgUQA85AW/I7t4?=
 =?us-ascii?Q?MXmhZzBX6Eg4Ro09DQZxTjy654hP4tW1gqAsfmRt9TwUurpLhUFYxWCwmfy5?=
 =?us-ascii?Q?1vK7FiOT9vwK+/xgAU/hKejVIoG1Knm7FCmwFO/RP5PgJ2IYlCuTKxIj0bjG?=
 =?us-ascii?Q?CM/2AqvRawydmIjZVAk44XX2xfaOM1dMczMlZu/Y7trfBDzkZGzlw0mfF35L?=
 =?us-ascii?Q?XjCCBOJncBGL2fEnR8s7XW4wcvV7lw1FtXl6c6esjm+SCMzBQOY0PDH5p4K4?=
 =?us-ascii?Q?1ZQHhM1oJ/EAgAfa/X3ZvXFdznt1os2fUbWxlrisa9jx/yuxHYtyK78Fa023?=
 =?us-ascii?Q?o6Y+14G+oryCYNPkx+tSlgm8yoAC8H7MY65LoJMvm3F9yfP/dKugD3AtC4zK?=
 =?us-ascii?Q?RvF1UkaB5rQWO5a8RHLg2EbDt6lsM17vZMQquKNgt1Zj4V9rssGPseAIRXUY?=
 =?us-ascii?Q?tVu81zyGxGFUPC8jXVskHSa/AXC7yD62a+v7ve9NrrErcjPMRQghojW7BlZ6?=
 =?us-ascii?Q?JKeua5xuPKGbzG+sJlbIIJSoydM8p+o2rWTymyMEmyxix7cQteV94jXWIYJ6?=
 =?us-ascii?Q?psauThclzPUmznW0ZWLdsjsOcaPbxYn65Q2+Qv1X8IPVIWoLCXIyjuVtObQW?=
 =?us-ascii?Q?K+hiHWEV6Bt9SosDbDLxdXFq6FqMUDP+Lqk3QJm3P+ird025VM51JbCQUGd/?=
 =?us-ascii?Q?LyIC5Q6Q+MTaYMSi2oonmHbqoLjvMUGiKQFE5BT187o7rgYPrRLyF128DRgc?=
 =?us-ascii?Q?kZwgxFnlCCMaHYR02+YESsg2GW1UmnFeXnxrC+Js6ad/W31vgbRCd4YB95s6?=
 =?us-ascii?Q?MfzNwjitsuTijHe3VmsJfmV9iAjnezV80Ki5wjwqveyCVZNv69XdXRqnHbI4?=
 =?us-ascii?Q?Bb72mogLtAhcYhZI8VZ33Tbxz/rRcPKKXEeRK8FrMM6CN9gElvPxNEHc5AaE?=
 =?us-ascii?Q?/71EbDETtLWaqlxB9g1GtzJy5HEtoq9oD9mPvuApxEV5El+svvxlguK9CLTi?=
 =?us-ascii?Q?tbl+iJFUP/OKINRtXcjsHEcbzXhWxqcdytazbPhjmrLk+mU5qk4wAaVy5yYu?=
 =?us-ascii?Q?Uht3fDfVlSX70vf9sVc5DKD9MhS5e2CrmvvcewMml50ucyNUACyANYGfT4JZ?=
 =?us-ascii?Q?h1Tj+Lh/Yi+x52Md4tV5JmWtbmSeF0JOX5tAaTZ0c4g1zXyXQrX4D74avjxx?=
 =?us-ascii?Q?sl128DQCQ889cMeF5fHBPJLZEB+1owGafu0iCceDFtLV8tk5S5nF4vPJtEgs?=
 =?us-ascii?Q?enm/zqlrmuJFzLIzbuVGhlilLkMz7+5WAMmEILIWHRwIJ80bhuv2LDTtzAwu?=
 =?us-ascii?Q?oBChOTzpkmkt20yDczEBO0r32lyFXQ1PiMfwhwvjzWiAJ5haiO1bZSjiN46l?=
 =?us-ascii?Q?tl8y3/Y/pd7fb+esnQjZdFCR8I0BDp7kjN4opgce6CGdEXHmYD1sO0TM6vKy?=
 =?us-ascii?Q?33vVLWdvDz0eW83ztCsu/rf3KdNnTkU3oJzfWA33K9YgbUnFnb0y8dPsMHON?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f6769-1f4d-401a-2771-08dd0ce8dc0d
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:34:02.0945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmT7KayeB9yXdyznpaZHRsdRcIRS+U2KgsT0UGODMFqXFSWco8GVoQ3ji3wK1gPK8J13tOFkC8FzHJYce4y8ECxWRtJmq6doi2eKd9FGZOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

Get product ID and the other information from EEPROM, use them to select
the correct DTB.

Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..22afd76c6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,36 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	} else if (!strncmp(product_id, "MARC", 4)) {
+		if (!get_mmc_size_from_eeprom()) {
+			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
+				return 0;
+		} else {
+			if (!strcmp(name, "jh7110-milkv-mars-cm"))
+				return 0;
+		}
+	} else if (!strncmp(product_id, "STAR64", 6) &&
+		   !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

