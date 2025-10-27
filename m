Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7423BCCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11EDE82C7F;
	Mon, 27 Oct 2025 14:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lYfXOJsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61A382E34; Mon, 27 Oct 2025 07:37:20 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961B280422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btKA6oHRe/t2w9M+YuI+i6vrnMyW+6HDfgWswY3YRL4/CX+8vcZD10w+eoUOKs2swJJ2Hxd0S+ln7Y+fRGQUE6evomPSYjYMSpO3XQBPGlzbWJIzl3AwwImEPwuUlAX58pPb5M/ObqdKklPNdF4NsMibym1uFhumQF5t7pIiDUMBPlLcl8TP/XX/pBwtLn7oUw0PGcBRe9+CZghNtj0rmJ7SztrvTd9k2x3O7pXRiLFVPfyyGsRKvdWOVEDAj/fnZt/A0NAV2zSAK7gW5rCmw+EiWgwPzIkDXvm6i7OnqlwHeEVKmI3F6PFV/wgS89iizHdlbjEoQesQkSGtpjQxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxCNNrv9tXkQ9lkUOfi3hCCtViTy6Q3TVA/FkF9/4qg=;
 b=vAeDI6IsOjWPeKqDLe5v5bZml2r/wJzKD1nPM/ceKQ6WxfFHF75vAyMys+dg0fYfxVx0uSpkupmAyOZ0gwSMyttsFZmvKuf3ynRTKHdJelfVfBP0mbRdxYYGNuOr0VUlzui8xAgt+LfCovmTDPZakkvGm6/rNs/VvL8urnGn4+GMyJtlKQDrQqY/ESRdnf7vJkZtWNT6ZfHeXZLul9ZE6tVhZAbaiL9a7gDERZMXf0TT2FKVfnEEjqXBR8+Ocqusnk5qslQY9pRHyJSzVnMwMOcrT5fzN0x89vmhgawWaSVglIvdsA+zaVzJ0TvZ2H9cGjViHJRdh3uxujB1A33AaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxCNNrv9tXkQ9lkUOfi3hCCtViTy6Q3TVA/FkF9/4qg=;
 b=lYfXOJsOZYYL6W9Q8pTr5yZJ+AZJFOKYOVHootg5EGCZQfZmvVfNHFabs4XPcg1oxcU7bM1duXDQQo9MK2Qv73eCIN8d0aV9oAJSH/aBZd6VhzqFIday5kngz98y66PHIGc+OqerMbCCMC2Q89BOK5YBXE1SxhNh1/niO01IwU0cvsl0JRx6xQCpWM5qdJyoqmZ8EqWbQqZVXfiS88LaM//Wawh+/EjTDq2k3BVCJCKZkAcptOaXnZ/NirzteNC6rpRf1H3AwwcWtAPa48gsZxU6e1+w91Io/msokeFIRdg7f0rRRMllgPkwJlI9JcoK8LXCd+UCqEmDVYTv59ePoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA3PR03MB7301.namprd03.prod.outlook.com (2603:10b6:806:2f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:37:16 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 06:37:16 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v2 0/1] spi: cadence: Add xSPI controller driver support
Date: Mon, 27 Oct 2025 14:36:53 +0800
Message-ID: <20251027063654.27188-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA3PR03MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a3bb3-7d23-42c8-193e-08de152344d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUh8g2FPmyGSnsl3+FI474ylswrtV0S6Z1me+aSZgvAJFrtIZ3iEklDEIwCQ?=
 =?us-ascii?Q?vGLBDNlNd/eYOSQ5eYZvbg48k86c5SV7Iqan1xTyv+IxXM3Hmmr7N6DMIIIU?=
 =?us-ascii?Q?dKuEoR9TnvtkiQbkxwROTk9v+sYnWqNxeu1Ll4aH8uviiI2Vndkofui1wbas?=
 =?us-ascii?Q?XXzvuhxegNamKrzuho+qKsL5MUPn8J5qx26ggdsQ6aHFUyXDRuxnY14r6YwY?=
 =?us-ascii?Q?iYoRPmnu9kYdACyCm6dnUyLnVlUGaW++dfzsspUfmohmJwxqZE79TqZt3lwi?=
 =?us-ascii?Q?0y8lWe8xJYOSk9GgBZqyKhSLUZKIbd9D1/FNZpW3odUi7sphAwlir8DGDsPU?=
 =?us-ascii?Q?/8hz+rIaqlzVi69+JC+TgSf98EKrDIfWJMUw2R/R4I8SgMNCA2b6vakNunkF?=
 =?us-ascii?Q?ZL0DdveSs+JVJd9m9kayhbUZhyAzo0VKOAHJBsRuqev4VRg3CYCeH8i2BIfc?=
 =?us-ascii?Q?B33ch5O0sNpsOgw2pCv2gnmcyPUbhfnzln46+S7CrD0pFMrEQR7r8VZCLc2u?=
 =?us-ascii?Q?IstbP3R3x4TAiVWz6so7ZZyROTz9MI8sKGyAlJzM6hzXWfXbN/sQd/1SQXLW?=
 =?us-ascii?Q?oXOoo5+dmO/seToyvP1V0VnWn74MzsOCVSkobJX2UJ1YC40/VDDtcKTsEuel?=
 =?us-ascii?Q?e53Kyw8iDfPXGpKApJu1ctk+650Y8fDWZ2IRlMFaFV19dlCKCmEXUMBVJLC+?=
 =?us-ascii?Q?TiyXAGc3F6l8VK+JtmmjegGllVLhTlmFqweHakZDo5JujviLOPPD6kxKfJAg?=
 =?us-ascii?Q?rNMacOePIPbBwXwxU1JqT5zle4W/RS1JQ7ZWObFC88CpG/OBoF6meI9s1HJP?=
 =?us-ascii?Q?Rs6UJzPyovU7RLCfV4PBNokRmJTHi2qVDKp9Z12QOh17YbB6X1aKJ2vzHfGM?=
 =?us-ascii?Q?654M4ZZ+8XDaCUTGEsKbS1c12LePWA22+LwDjRZKIiAkDagO+UAaf821JrcD?=
 =?us-ascii?Q?wFPXKTnW9zyGoCQEUUh4aGHv1dHCDhXMHzmjLl0PgmT1y31Sg4c2dajvVZRb?=
 =?us-ascii?Q?baivtTkprL/1Ss0iwPfOIe4fCFJYDEXabh6WpMlZkhI1qTKJ3kIgKjVReRpd?=
 =?us-ascii?Q?aCGXtxDxZPwiW5gTW8xZPKGxVPOELaN28YUNvZNTprmyuJZDMilxdTSPYUeL?=
 =?us-ascii?Q?A/aT1ZWZ5ixZzSQdrSeKO5wnAdyUFJ/clied8GlqYF7MPtJix2Lnb1D6hSNy?=
 =?us-ascii?Q?87l2GGb6dsPMNUgh4eKqsRCwbVIxq5fq55++qeoBBZkB8/17fbch2CXv+5SA?=
 =?us-ascii?Q?P3GXxRAZi98Se5pW2AMnGLlXOTJEzw5SUrg0NlFr3/TpWlM6p9ahO+Nrt8K4?=
 =?us-ascii?Q?ION8dheVmZNawbTRQyvyxxB7wuIl1OoOMWklgpn8C1h6xbNgoQA2ROUtdnIs?=
 =?us-ascii?Q?tURrmnmT22dMrb0cCMPgOjTP2VnhjGcy0cGxsejZOdKMiChiPbZaJY3byFUQ?=
 =?us-ascii?Q?X/8yl1tQQ4/bFyqMYRrpuxuk1DMyjhHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9VxvL7GRPvWIbqTluXPtfj206cozdMw+DJ4X+T9vGFrgyGR8+YtOa5PO42w?=
 =?us-ascii?Q?RyUcSovK+c7pbqrFPfr2PpYUiOqHFpFM0OUr2cLg1WEttPVvB29OKJQnJCCi?=
 =?us-ascii?Q?PAVDNnQ9GO8zFgU9x45w2eJR6jda7yH4f40rNb1kcJd7w5cnPK7OXwhaoonr?=
 =?us-ascii?Q?d9qc3D9RnuGITuqSctFXxqIZykNhv5o6cwIP9NUPmXhtioLHHb49Cbxvq5qe?=
 =?us-ascii?Q?HJhgS5YhA/KF1yfQ6RNGf/9ecg65Ejv5i8jTl+XvU+juGb5VnEa6K6RQA4Z1?=
 =?us-ascii?Q?2xaHtkj23qjIlpQbcQ28MXtFAF8uhO2nfeYildRB61fgKznmyM/7gM3qg1w3?=
 =?us-ascii?Q?H8sAs0ahSG/gTq63/cTm2pInuqhsLbgAF/+WMHp2Sj3nOe4LCI6kPcNIpECa?=
 =?us-ascii?Q?4pMfV4ppM1a8eb4veaqO5q6PHTZ4+pQnVRuqdyDnmdESIM0lfEwrQjz1KNWZ?=
 =?us-ascii?Q?IOKWezGQ/lz2Q5ZOeqbDELsdSg5gSrWi8fBi+ENVyK3wTkINRmrdRN42+kLd?=
 =?us-ascii?Q?ocPUpp5q8YJy5uZjeQq6NbIQ5d8MvZ3xQEwGmD0vUr0tltM/Uov+X0HaFQMS?=
 =?us-ascii?Q?X7we5FOZgnH/g4OTJSWM2BxpEEh6WTrqJx3Py5ZVrgfIU8wMm8lyRgtnNzR7?=
 =?us-ascii?Q?O+uQV2Yo4MUMEXVLt8pyFWTKnIKWsu2PH6Yuo3qF/krur3tbD/EBLOHZ/YLE?=
 =?us-ascii?Q?h1wJFWj5E1SQY48B3vR8wLvz+8fgKoWO9E65DFNz8ZOXAZsTxfA1Ox4mzQa9?=
 =?us-ascii?Q?skmAXuEcbTUttvFtGu8hPK7sFKzjWIKDzJSLfqNAXiT8EHQtA0rKjc4voDK8?=
 =?us-ascii?Q?r0PVEeObXOb06G+WLhQaRQT6apMZKO2w/dVYJJk5bCKqWlmYcVZTkVllidMZ?=
 =?us-ascii?Q?UecY+uWRjZntsGU+mwN6Adc6gxtMxGzSbU1Ke0h/mG4oD+mCiC190/myq9BU?=
 =?us-ascii?Q?Ah8oZPiwrJx+JbZ3yHU/UqBN8YFAd9uha3dKK99rNWNJ9G9U10/2wlhWetMn?=
 =?us-ascii?Q?edgXbEGylGkN2gpGq7Ec8n30TDGcqtY6xpiWTWNmcwTWyIweYZ08oyqrbhpr?=
 =?us-ascii?Q?i2u7kwRNnPrFXFnsxpCuVJ+RyHvyhqArpOVpg9JNvtZbbiU/hziayCWPpB0j?=
 =?us-ascii?Q?7iHQDAIJFf3utMm5d1nZyZ0qLcMvk3OdAAdekP6oSmEGUt+eja3kEmfhJmmE?=
 =?us-ascii?Q?ser4PNPqRSPxOMjIxjRSa6TzD8cD9nv4qOpmku6wXIIQ+6PIhYuI9KG5DorJ?=
 =?us-ascii?Q?p7Xi/07oXsf4iUsrAlR5vB/mGJ0smCJmTy5SMWFSxEAGLkEZ8kvVdaXg6s/3?=
 =?us-ascii?Q?yMvkh/aayx4Xlm5bOwoArJgHKJOya4I3lErEoKOfodNyzjZfqI77BZGyE+89?=
 =?us-ascii?Q?e+B6xZmipVMAUKpkc849s/O3v/ASSqm9zuqTK3hR61YlVAqWYxBOoZ0kqKCu?=
 =?us-ascii?Q?GejWlU0KqyPj50IY6oI+O1DDzn+pX4MCDnj4Vnqwy3V4FaQkkiU6aiDaiE66?=
 =?us-ascii?Q?fE1l/Bp+7nsGF7y1xMaXb+jbLFUAkaVpLdyt9W/ntMteVzR3rrb8rN7dsR0a?=
 =?us-ascii?Q?W49P9HecpQUxdfNTgTN2UDc96EunfwcZHEnMn4/3?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a3bb3-7d23-42c8-193e-08de152344d4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:37:15.9661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y27h+t04LDqKzAK5Q+JbtLxRGw59ddf2+cLJOrDAqoeWhkPSwJ2uhOpZS9EV02xjuf8QWPcN3DCIkZteH0ZfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7301
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:02:31 +0100
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

This patch introduces initial support for the Cadence xSPI controller
in U-Boot.

The driver is ported from the Linux kernel implementation and supports
three operating modes: ACMD, STIG, and Direct. Currently, only the STIG
mode is enabled. The driver has been functionally verified on the Intel
Simics platform and is intended for evaluation and experimental use at
this stage.

---
Changes in v2:
- Squashed the Kconfig and Makefile enablement patch into the main driver
  commit, as requested by the maintainer.
- No functional or behavioral changes to the driver.

Boon Khai Ng (1):
  spi: cadence: Add driver for xSPI

 drivers/spi/Kconfig        |  15 ++
 drivers/spi/Makefile       |   1 +
 drivers/spi/cadence_xspi.c | 449 +++++++++++++++++++++++++++++++++++++
 drivers/spi/cadence_xspi.h | 226 +++++++++++++++++++
 4 files changed, 691 insertions(+)
 create mode 100644 drivers/spi/cadence_xspi.c
 create mode 100644 drivers/spi/cadence_xspi.h

-- 
2.43.7

