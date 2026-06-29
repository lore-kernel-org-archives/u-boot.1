Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4860C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 05:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F27484867;
	Mon, 29 Jun 2026 07:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gn9CEPxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A76384869; Mon, 29 Jun 2026 07:28:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF6B841F2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXSA99hijtXuvILwBx0abF8PtUKAJzm+TQyQKe+l4uChM4eh8+VTEkspsoXSYaYtIA7PHj7KxagSFY44P2jM8HzoFnwlz33K1KEs4MBloVrAseLD2F1dXZcqdz9wQ+ei7fCQqfVFrlk7wFJZmKGhMuDkRKKZtGbHus8c1jVsc5jEfttCyqmaI2VHvLXwejqpE5uEh1tErGlcgwuiQaNwubUu3ns2ogVyft3diFcdgxNZNlCq7y7vUWPYVDyA55wc1C1c7mIK/kYil4IJpKyw0hAmQBWW7HPUmmfUHm3Sc+P9yy/XyCDXOiXD5OQPtUSRBjwssmU1IFGK0Bk+A5Pa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXRYhkO9j+UGlrsMy46ICYfA3u5k8+ZoQ/FrCTFTvGc=;
 b=aFYEBag966KfDh2OLOZHX8SFFp2DW8PUWi9hmeBzZ15ZrnNBTG7yV93qbbTqBxZsAnHu1NOqfbGI8Sw2UHkG1kuZICQz8yRZUhYpDIfSOC+O24HmFf/J+yh1NWK6ZU6GbhXwHeHcMhWARl1fJeyH2hxhypXsOqHVuQTEN3Pa1iCB7BiEEgdzuJB55fFqtDUVPf9lemajXq3N8wj98nT+Vd9XBoDwvY3r+F9CCckFuOVUj9Dw+h5bTg3JWqyHPpF4o71ihwPSvel1FbzQ5fzFqd2WR53wbmsdIhjvx0i1GrZd3X4P0DOGVwnOhooqJedVeSHjr0q4k9/Y4h7aNbfvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXRYhkO9j+UGlrsMy46ICYfA3u5k8+ZoQ/FrCTFTvGc=;
 b=Gn9CEPxJB8lnnGMb8fL2CKKbS79LdrYPIpKVFGIS97iGnA99M44z8W7pNsYJGhcRqfRhlIldYHec6Wxx8zVm5DhxV0DyE6x3QolXV+Djv0lGfVndJ5LpXIdhW0Tvh3ZQ7HJR0bNOOVdYgS+HlT4Reu1IoefSgFl3kazCzJ8Q18r7Nv+qdws0EAjx5AtlJiHSDl12clhZiQsf8MssYlvKlwSJo1R+cJkc/JaPLGMNdRFbxqQtabyw3XK0u/Aui+wQaWeMXp4ZM8hrMD4ElGuMCPA14jOo3mCsD91BeQc4UqIMzZZre+PAh+tv+lLir9b/3nQC8zXJcIE4bJbyfNB/yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 05:28:11 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 05:28:11 +0000
Date: Mon, 29 Jun 2026 13:31:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] mmc: sdhci: Use CONFIG_IS_ENABLED for MMC_IO_VOLTAGE
Message-ID: <akIDN55DZ+idshr5@shlinux89>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
 <20260628102527.1247889-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628102527.1247889-5-jonas@kwiboo.se>
X-ClientProxiedBy: MA5PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c64660-56c3-4378-48f0-08ded59f35fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U9Mbv4JZiY9fA48+Ax0gPvmZkZc1/ILKsZzrDqaVGaaYqPSafsk0zzfgKA+RA+s3/5MKv7Bnl6DoUcfqxFkj8SDDt6Ns+BnPWRBwNskeUSPW4oHxWxBzOjhZ30MDc0uNtGgJAND+yEyC1NfzqEHuMDoyPjZNYf775p/TZHA9MoE4fzotI0Ir/QwL4ipfuSNxhPNiLf1uzrNqltFv1iwMmacYLqWSOw648mRKE+z1bgHo5dCRhc9onVXgjHcCqNYuLbH50pKoPums8jMAJPhetyfJxBauLloYek9PTVtzQe7su/vVronJAjEXZUqnNRpjlr4s9HUrsDwdp/tzVP0azLeWXxwe2eK9DT3UGdxANNyT8Hz7X4kQm+Rk9+vA3RDlWaMWiw8bgQgbHmp8dmXRlxxAwchZV/6KzHlDhdygbzXId4jnuXPnQYxPmUEib/oHPoKmDsFpABv93nZrLeDbj/P0ceeC5+IFCO+C51dwLnFKslcNRDKd5LdJn4l9l3EeFH28DTqwSprf1M0TKRKUiyQiWNGaa+u8MWZlusFijTfg37EnzJeOXNWQoam9J5C8+UXZFG+HcM47stagWhy6LZvn4ws5S55tex39NHwWyI2/jiRdmqZd1v30zG2zVYJVMoYA9jws9WYoEZ7Gg2+Z9UXtLjiA6nLP2uPHlagydhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87KiaezWWcyQ1IqwDvzDOLS+REHiR3VpbCAJEnb/zOkrVyY/9lyI6HyH7VK4?=
 =?us-ascii?Q?x6SrPHHfuWzHMasBL6K8Obd56Qk+g1fWggk5Pp3ChitaxK7bhBY9o5jtl1Ps?=
 =?us-ascii?Q?w4ZYu4JG4xitspWerWNLUZfCBLPCODYDhZsCtfdP/7lI0mwJZHiDpv6HEyg2?=
 =?us-ascii?Q?wNRy9qqMsfUVhvnqZ4eS1hHzo4s6vjREaFVPgSCMj61SNj8UJ5hhTqifwu0d?=
 =?us-ascii?Q?ZSViiJHA8VN5/GO0Aoo92XjAyUBVKYIciOw2J28lSvSwBSKGcVvEvz94IRFG?=
 =?us-ascii?Q?Sh6ufcsKXcs8LgX/Gex+DCD1nDGE0JFoq9OUoUQLnaO0GMiKBkHEunxYa7UJ?=
 =?us-ascii?Q?nyheY9rY6fElaa2wnz7zAVcJJ0hvm9gigBCySmVSmOe/Xz8/4iE38isOLvEI?=
 =?us-ascii?Q?biGjyGRDOLoc6OPmzI0vibhSCzS3UZ0F/zXH1ehIYl+CEgQzBKmsSPXvOYpi?=
 =?us-ascii?Q?eW1xQjr+QL4LFN9wN18xxc5JvmMNy0a9zF9x6KsIpjm8x7JXd9TKbrubMhBA?=
 =?us-ascii?Q?cHN/cOfxveMjhk/IXOqrj15i5vntipm30zLotOieEJ2tjpZvP5enQEQC4Hig?=
 =?us-ascii?Q?STsfFDpTE6DPAP3dcJzVlEZvmLFfbqHwI0axTYb/8/H/S1YIdjgnPTitBwML?=
 =?us-ascii?Q?iBjy3fRJJF9pkeOl0BcvCjSswL+SskjqnNNe5aP1KUhleryGUVtUXCK5QQlS?=
 =?us-ascii?Q?SC30x5QiIUhwYSZCAy+3zSiCgIKU8jep8hgRvhjIOAsqiL4AiPLAkiyah4UE?=
 =?us-ascii?Q?prz30HAcF+m4Wq94fpdGmpAi4FJfEIg5baZSMVM9Wz4iSfpAEyukZpi12Qfz?=
 =?us-ascii?Q?sIGGBfqJvKOEDL/bZT9pOZef9k7EqYOncaGlYvMMwvTepvtlhF22nwMjoI0X?=
 =?us-ascii?Q?/YW1V7j+dfPzDtx0LHYuGjs6dpDpQIG/U25b+1L7rm5HZ/FokE7kqAzPs4tJ?=
 =?us-ascii?Q?WI56nxq+bSzcBUoWhQTFwtnuz3TSQS4lhnQpqa1cqLrNaYKPcxrlFyZQTp0t?=
 =?us-ascii?Q?03rUBDSiPDduum8ECc3DO+bJss0Lrx6bdJBfhYuszHV50jbBEE0PsUVG8SRh?=
 =?us-ascii?Q?WLjOTTFToMEbspy7yJiuYSeywTl5hfUp1lRjyD20TJYQ0I/HDlOJPgPetr48?=
 =?us-ascii?Q?b/mld9mA9MDCobrefunzml/kgrNUNrV5LEwU0tFzmr+PtGn7yz0XIMzGAMzh?=
 =?us-ascii?Q?D1n1SQh3VKjI71hTb81MSC3sDqplkUsFU52AtKg6YXJLGaURfbU/eMFa5ch7?=
 =?us-ascii?Q?OfL2qNL4zoDbEoOnIDD0WaDz/B5z4E6U20e8LNSCXny4CevDeeLTvTGZBrhV?=
 =?us-ascii?Q?vNn1bUvgM311E8BRqn1JEXJ4rFkzwu5G6r8colnpI2Rk0S7YsAQp+RYqKnBj?=
 =?us-ascii?Q?/wIu1tcQ+bvyIxsKg1ttjEWqFowoiU1ncZC6C8BXpeqaFFHBtcg7AlP4QNgX?=
 =?us-ascii?Q?fZd8YUfg7Ehv7n4GQnIzyac+EG1icBLPYJ4hqMiZs2p/400sMOF/PUf3sBVd?=
 =?us-ascii?Q?61/TUn/ubLCmtlcS9jxmIajGS8yyampM1+WxE00rKReagfdRyXSGlXZtq0xK?=
 =?us-ascii?Q?HKLdSE4wZmd7/Hw0QRXRhbe10mmCu9wmuK+9Q4MvSgWCJQgXj9nv3Q7ocdua?=
 =?us-ascii?Q?uiW4HKPAQjiTF+wZHvqNrKYf+Ta5AwPZoRlbo02yMqhakDMHxSnhCD+kuvea?=
 =?us-ascii?Q?gW2IYDrXF1hb/5azjXgsNf+h/ToSMwR9fp+tYGqpq9aTx0alHTJTIPBish2a?=
 =?us-ascii?Q?nmWs8HeO0IMSTlhyd9Evz+WGJYfAkaQxJjwqcfAzNINaSu9ef+6z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c64660-56c3-4378-48f0-08ded59f35fb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:28:11.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8SAb51qVBm/TMdZ88dDqOtYOCZZUulKEaY5bw1zFd1psZR19lTDTeVuQ8c9awkfcDHi5ov+tHv2WRFUXNzjfQEHGsHWV+HfiiCMSA+HzEQA8CFCJ2n9Jg6KAefz8rrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622
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

On Sun, Jun 28, 2026 at 10:25:26AM +0000, Jonas Karlman wrote:
>Use CONFIG_IS_ENABLED() instead of IS_ENABLED() when checking the
>MMC_IO_VOLTAGE symbol so the Kconfig option is evaluated correctly for
>xPL builds.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
