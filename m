Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 03:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E57F84686;
	Mon,  6 Jul 2026 05:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KoCRQYk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1A9846B4; Mon,  6 Jul 2026 05:38:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F076284105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 05:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUE97qLRxewc9jVdiW+WdrhzqZOE8uIw0AOex9YVpYqPQmjdmSZKgVvEFAEqifOd31qWNiX8cQEYXJCi61aB4UnaRoFeSw+kx4EFsegKCcI2FmhSA9FjrSb9Ug3yJfd1VvmE9a3p6T/H7ECpUzYw24OZ5CQdOw0fAQN4L4anDFutkL841N17jMalY1gBrCokGtG3uQ0DtFR3Dfj3ZmWRR2MfJ1xKvVgEgkqvKVZetWctEdCuTJ73InZBHedROHuTcm1mhuIZzB15/dvyEojWuWTYFV/EslzDbAu1TqaOLr0YK27sibJ+8e63tdn7SX/1W2jHLIYgGoghnQKg0c1tbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKZM9AK7250VjIVoqNEsmpWYluhdBG1Vd6kOFGX2Uqw=;
 b=UDe4J+/aZjy8qLa6qvrQA8C5A8QNfZ0Jzh0Gr4YYfvVNZEcOujJQvbTn5WT15zcvQSLDc3mwdVrujG08s+z7VcDD9PvxDkj9bpzUd4GJqWeaeb01Lm/iKF2HdQGia+QiMQzcgCtaI7dH66I3PRbFbLUNKl7xG9QEYJ3TsDk72oPXn6Xlz21tegbsvLhNI5Aa3N2EFCMExbMWCwzAuDmHiQTPUTwk5KMPz22ow+fPJWC3afq4t07TIEN1Hyvs/bfvBUORgWJ4YEV8TfB3lJ/zAq0I3Eq6daksmhtM1l8BGN/rMurVn8UkB/Q6nR/JQ6EDDfJnCfs5TZ22fClokLr0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKZM9AK7250VjIVoqNEsmpWYluhdBG1Vd6kOFGX2Uqw=;
 b=KoCRQYk8QAx1C9P4mTV4g8q0v3ICMzXcMtXafjQGR9b+749TUKslmX6t1Rb6FSwA9jwp7dEXu35Xz3m0mFMbUXhNm2NSux08c9aE1d6qdyyYYCkQ4GVBz/7PQV7MYducWBYIzkHWBP4qsS3p/we/7t08sbn+fPrV3g9HfyIFO/rvBh4+JjfoWdwMjzj5TUuMKa+tyqtJSwktY9vRWzg+UjFhr6K9m5KNL3dZHHaj8gV8g2HfMR4hZjoD8ur8J4+f61kRf2vG76LZARSbslbiatFqTm92zu/BA3K3M0gvvnUytjRuFaU03GYsvxdEAH6LeAmuwwbLWKw2AKseNUH0ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:38:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:38:15 +0000
Date: Mon, 6 Jul 2026 11:37:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Alexey Charkov <alchark@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] pmbus: add PMBus 1.x framework, CLI, and binding
Message-ID: <aksi3r4myOt-Meqh@nxa18884-linux-1.ap.freescale.net>
References: <20260702171618.1773206-1-vjardin@free.fr>
 <20260702195619.1857591-1-vjardin@free.fr>
 <20260702195619.1857591-2-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702195619.1857591-2-vjardin@free.fr>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 070deabf-e311-4622-c991-08dedb1002e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|23010399003|7416014|56012099006|18002099003|11063799006|4143699003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: k23z5SV7z5uIPGlAMEPrZhKWrSDWCNHnvdq+1T5vvuLXo8tBei2BkmBd/2fPlJKWJUcPSJzm25WCpGLwERVIF3LEMt5/i7pfYwfoX9QuNYXC4kkdxObjxTOpabVqAdmmpjgxl/C3PSf6d3KLx/rMbGS64PK0rHXQ51uMvfRQ+N4ONUlixCldrW5zP2KmB4GytW8taos3yBgkq2cwMt+vRy1A0yEuYxGU61XVQsizmm9zaWED4KCfWOS6f3mp5frYfxOeSLiCvChbLshTyc1XVgxvS4x4gTCDOWUUjzCc1qsK78Tx9hPDH956KeGXOf/o7YLXwqq7cPj9yxKo3jbkZ4xSgvm0HZS8z6ynpG1e9i+2ajsd44HeahVDeD+cZswgvqHU3oOxPvBeWnAj5JZrin+Bk3FKil5zca2RokqPCu/ftR3b6e0lSKwFDXhRhmLY9jprDm99b8jJSGxVRavvykgvnfuVZyJyfkQpawtQfMmy142cJ5IEuSxzgWqM7p9Uz/Kf/lBxOzSN1zy0nRMeA/ZbjgLivjNs1HQ83+TufPFbHGl3VTE18AR746k0T/6Hckqj2Q975Yup4VY3RNcaijW1cLWwgQTpZFXR36ScJoxCo+AOl4W7TwOmOhHuzzex2e0LQv1d2du7apvQChPDlpHTcz8DmlSdZsy1x0jMgIEMgU6VVQ+KPCtsBMaz1q0aU3AyBOCWmwfuQeAtunGU3TiKEkrr/dL8wQagPsBK2uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(7416014)(56012099006)(18002099003)(11063799006)(4143699003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNDLp7rccMsPzZoN8i65OraHtDNABP/voRCkffxaFFTsetT2h0IfE+OC6aiE?=
 =?us-ascii?Q?EoNx9z+OQq+lIbexwhMNCbfftPFVo3O0HPEt3BVcgK6hFo+bsrKGBI2pDxDb?=
 =?us-ascii?Q?vPr0QLwb2lN8Tasn3tpbW2Re5kw/Bi84Ulgr/NRJ6oGrNsTJz4DJjbAzqcm0?=
 =?us-ascii?Q?W4mYufOS2T7DJ3P9eGz2NBQ+0gMNA1pra+kQNX3V/1+LEjG3+2qGUEXMEVNq?=
 =?us-ascii?Q?WdgWIcTsmhGVJkHgSwMoz5xNrdnvwpN3SYglnGdv4XQ9yo+L4fofV+UZyjzP?=
 =?us-ascii?Q?7dODSI4Puef9jEuO3Pyd3mwG0rrPuXVYiFW49pbR6h6z+VF6S0sFOQqh5sx4?=
 =?us-ascii?Q?5SYMYKv7p+Z1Tyw414X1RQn0CJQlvcvQWO7PA1tl55MDXQJ4N/nZ1QxKlELV?=
 =?us-ascii?Q?xZmEZGOgLTxQMicDJDPT2Cfd0UaO+Nv3En91xRB3qca1ije01TUUpvHJqziI?=
 =?us-ascii?Q?K7qkmfTD6dvLJchT41dDG8xOo6JDNN/Hf9iOiF7PAhKs5RE/BQ7zWhYWnKxe?=
 =?us-ascii?Q?yJVx+A79XWT/c1AFS0ybCEcVwHhJj2B1I8i7p81PufCm81YSPHuLaW4XrDxf?=
 =?us-ascii?Q?8bi6t5ma0WSA1qWJn7W/mF4NAHoxMd3QaPtwYpK6UztforfWGCniA8W0mXtb?=
 =?us-ascii?Q?h/kP0I8pSOpJO64cNC5Se2LZu3Rjala2imPVBzy/MZU8m+fhWBPQdP+L9zsj?=
 =?us-ascii?Q?PvN2GZby1/XUZe5zDvBgCe9VG802gdYsphYyQpkzw2kNpPL+CtXOPSNIF/fv?=
 =?us-ascii?Q?yYM/9ln5lleNGJEQ8Ue7jIZu2O89PNaQgFM95XF+z8C/3boXaA3kVgNaij+6?=
 =?us-ascii?Q?SmDYqliXWVKg1xFL3nDG6Ab6qGIQqFkAtFpr84BvyoTWoKW5yOOf1NpJaikb?=
 =?us-ascii?Q?tHf+dW6eanwqwR+1Dpmbq4CcbSgy/Kj2XqVtKjqX84rzrBbWikYMumemoc2J?=
 =?us-ascii?Q?jGtX509Oc4Trie/8qJPaithpUN5U+yQMaJ8JQGABiFsi735EJctb5E+wnDCE?=
 =?us-ascii?Q?SN5qcrQZYHuKPKGE/lJX/TNg0Knnb8BUz0cLuH0D5GISCaCHO8oD7Ff45gc9?=
 =?us-ascii?Q?hcEdmOmiXYFW2eUrcXlewnhTxPusALsaYpCgkSGCCM2Sbh5uKGqNQ5Hq32jk?=
 =?us-ascii?Q?eFif50qeqBzleQXtMXV7NCRlAworuwPGuLpCjYaNpgEqHgRnHfGzwDuUJoZK?=
 =?us-ascii?Q?EwjG3cdH3WCZ4aKXLhvKdAtJdTqAkK9/d/uUlaXCGeNREbGRrhE/0L/XxvcW?=
 =?us-ascii?Q?0ReefhxytEiOC7uDhN5UqqpEBQpJ2dJkOy7nfZS13x92xff2/GMR43Mr+B6G?=
 =?us-ascii?Q?jY5D2sQlcn9kb5iAeaVLkihEn6jhNIewb9Mf8T7WODczzQ0JlY6arpfvcnoJ?=
 =?us-ascii?Q?NI6UuNUCbMsfn2oiHDPCqV3mbCNqawOLehf18s9LHahEw+3YKeBnj61mPB24?=
 =?us-ascii?Q?6VGo97BhrauMPrWjX3whIx+bu2dMA2D6qQHKel+eNDDAcOyFhjWgDjg1Wort?=
 =?us-ascii?Q?qjIIZEYkPKpGhOx9IfwPEn6nb9RNYg2ZiPKq5DqQghF68jQF7MhaPqfddUpd?=
 =?us-ascii?Q?LRHp84THtexOBTe95LKEydfqSwJpXEhY58AotIGEfPw6uNLDbKQyyN//GKIr?=
 =?us-ascii?Q?0nXWRC5XOZwfpAuzwzTax6wYtuM3z0UmwuJQEwF86D6GSOhG7MvW3pPmxTQV?=
 =?us-ascii?Q?tEW9X8rnMEXPGxbRpYOYjtd3XL9RTkHvn8zr0MamC1OeVoc1hq1cdwoUfWb+?=
 =?us-ascii?Q?Xrb3I9SYDYDB7TxxhONIXpA17GYJpdO9mYnUzEbUKVN7MB9EAxij?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070deabf-e311-4622-c991-08dedb1002e1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:38:15.0352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmOGClZk1J6PN/yf6eZde5Cz2lfQOwfDS/eI/rKaTanvykfnj7JKjlYhQqpnb3UVT85jo5wYaWQbYTMQ3sO48A8tPrsWvz4Tfm2Ae+qTkg40GJG3nqwuJhrRuPL32J8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
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

On Thu, Jul 02, 2026 at 09:56:03PM +0200, Vincent Jardin wrote:
>Add U-Boot's PMBus 1.x layer: the decoder/transport library, the
>pmbus CLI command and a generic DT binding.
>
>The subsequent commits provide the UCLASS_REGULATOR adapter and per-chip
>drivers.
>
...
>+		case PMBUS_MFR_REVISION: {
>+			char s[PMBUS_MFR_STRING_MAX];
>+
>+			if (pmbus_read_string(chip, reg, s, sizeof(s),
>+					      act->info ? false : false) >= 0)

Should be true : false or false: true?

>+				printf("  %02xh  %-15s s=\"%s\"\n",
>+				       reg, pmbus_reg_syms[i].name, s);
>+
...
>+int pmbus_read_string(struct udevice *dev, u8 cmd, char *out, int outsz,
>+		      bool reverse_bytes)
>+{
>+	u8 raw[PMBUS_MFR_STRING_MAX];
>+	int ret, len, i;
>+
>+	if (outsz < 2)
>+		return -EINVAL;
>+
>+	/* Stage 1: read the length byte. */
>+	ret = dm_i2c_read(dev, cmd, raw, 1);
>+	if (ret)
>+		return ret;
>+
>+	len = raw[0];
>+	if (len <= 0 || len > (int)sizeof(raw))
>+		return -EBADMSG;
>+	if (len > outsz - 1)
>+		len = outsz - 1;
>+
>+	/* Stage 2: reread length + payload (some controllers mandate this). */
>+	ret = dm_i2c_read(dev, cmd, raw, len + 1);

When len is 16, len + 1 bytes are read, so corrupt u8 raw[].

>+	if (ret)
>+		return ret;
>+

Regards
Peng
