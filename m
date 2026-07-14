Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB01BC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 07:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E230984AA5;
	Tue, 14 Jul 2026 09:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KFAkBq3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23AFA84A12; Tue, 14 Jul 2026 09:19:48 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EA484CDA
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUYzMxdpGLCzZNfHbfWA4tOtbQQThUkWh+0/ChXSo9GIp1GguDeVw/1fFcZGAp2OiGQqL/NCOmufEo3tNHgqnO02eaTLwrMBHqRZ17a1f45ZavVKB29bJ8RAybnWjac/i4sxOfqRPlVXy3GZp9Wyf+DFDmP/XfccqnEosEnk/y/fijd5+h+mE86MhqkOUZRK4eJyuAiJc5/9abMMlTofNyATujQrqEX/bJ+iaFihJYf4QJk2KD1wMmxksicjv+Owq8WF8GWvtQW4KLi/YupkD+EJYQjdmh5gN3nQlezxmMG2GDPzpRlBvs6qKhfZEOrCOlubjtOuWikjc4zawLU6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S37sWGLMycBe/v1qxPhV7xm2waKR0iVOtkSkRuC+k84=;
 b=ZCAX3N5MPjmAayuYiGY7uaAWsUheZOUKCF3yYUIyJeaRxld1B8G6pOo7MgedlfwcLtku5CTgoAUbHpLNGJgk5GCagNg9APRGQIZ5NB8c4nKbCBZfpAHWD3IwwBNHhV8ukbG3bmKJRMTecnC051NYa56OuAW75/HiRV9BJVxGnJqaZoUGPesuo6jgHh5311jw6jbQgqx6d6Flp0TESHmoEDNFJsuk6YTH6XUbmMbYaDHhvmI4I8KXbSqQt2qMgY7S83fhz6Rbawt6xsiByxbSS8FTxlIDJCkq6l5RfZbE2kYYrdMVLthwjeldMST2ZuqOGhmyIy000zEMjp6PSW9NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S37sWGLMycBe/v1qxPhV7xm2waKR0iVOtkSkRuC+k84=;
 b=KFAkBq3h9gGLbFTt7DbFxfH1kFsvElbK9hVAgYu+Pi5dcwBl4pRWMSUvekCGMLR2cE2Aow9mm7ZfMLfxPg3nnuCFJMG8tLsfeG0nk1C1DhsR+4WMgM8btV7wlHCDFQ4ixWQ1Qpb1LzN1kgJ1BV0lLZX67SqzUziplnDPyUH3GIJzw31WnkcupwTsCvtJ4WSD5WEkk4xLFlps8/j9rXI6/P6g85bEOfnbRGx7sq6g+/WRJ/11ItSw01KYbUg2WzBYdyltiZ6Nx8+ntfWvlyQaSuir3yxWBhHQLVVQjKJgrIkVbqREoQW+XbcHuvYz3kKNDP+DxC8WF1vA4zKn+3duww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5374.namprd03.prod.outlook.com (2603:10b6:208:1e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:19:41 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:19:41 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Nikunj Kela <nikunj.kela@sima.ai>, Peter Robinson <pbrobinson@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] net: dwc_eth_xgmac: Return -ENODEV when phy_connect() fails
Date: Tue, 14 Jul 2026 15:19:27 +0800
Message-ID: <20260714071927.27877-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 4288dd48-36aa-4199-563c-08dee1784509
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|55112099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: IJGi8voEB3JmQw1xtWo+B0DTDCgehE+uvrKMQ4hn9f4LkelM0eDcW6rd4yQmPelKWtMWVVTd3fUkDIdbr6WUJn9dkU6kdXwml0KaOXFa1Hz12TihSh/tSjQPoUrokHcgWkrti3Kn6ew1zjSrdQGWu7nD5J2t4T2aZvw1hiHGEl13ojiaHoc7tqrJrSWk0wm+q6JgDd4vzL0GIUSARfj00DUD6ApsZJTc9Ml67eOnO2gr9od9PxSz8TfRWhbMXlPEEUPHznsThxa8dpF0BcZhLcmvs91vJe5AvNFgcbgvJuu1gqoKUEyrsRL+7I8thdIYc1+GHQgxRWsyAD0OpnbomNePRFPRcqMNMQBsYhHYP8mBQZAY4iBA/uPSebRBbp/3WQsDsS2AcxVzU78KpcDRS4J+5ac4Br4x5z3XTQDsf+1qGfKcS9xc4iD8lIfwjCRa2f2k6eF7OCnDyX9pmK1W1p4uCUuxRMUPIAX2m8fH25rbZ9Q54qXhDrxt+uvEqwHU7jWM1NOx4zuxb7toqn1k/g/eBScoSzvKKdV7kMT1cq7QkP+hFawB3K/+3p9PzJp0oDjjsikG8KV7UstF6aIY7+xiAahV9YlU4lqOeO65+qTjzNrJtxjLjDTaU5Cj67F+bdH5TKhZGpJ9pR5PNtvvUCR+tvxODpRoH6tuvbO8l10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V58erbcQtf2JJzjXZJdocuVWBgxBSOpCTF9F/WNwlp0dtQLQwwjdQL2/ZVFH?=
 =?us-ascii?Q?2H2UpJMbBStRpBwhwpaCsPBruGaGYrIJDv1I8fx75Z0WjfKzLpdMxNuZdVOU?=
 =?us-ascii?Q?YATXKif7aOUk0Ss8RTEvXpAVcIRKBlS6FUPSHJTXSXq3P/9UOvRg01NAX98v?=
 =?us-ascii?Q?nd4t7bE3XxNPuNOxwjv3DVLouyio+gWRgGeIYB9/YD8CLi/3E5Coh5EEzQB1?=
 =?us-ascii?Q?KtaHRg2wCvmgd8oba4+VlBUmr6SBok6rMlqHu0NlinyZ+PLRSTPg2SZ2jxP0?=
 =?us-ascii?Q?+KL1e4w5o9I5IUUD2EnB0WEYfCewVUBzskcGYcwIqDaRcSoFFljx0XIyPrdi?=
 =?us-ascii?Q?RNkkaoVz5nDQIqSARPie33ABdYtEnt2pjwYJoet62JOIdfEPRokmQbETrLkg?=
 =?us-ascii?Q?58srXtbINzBCU7eGZX1yx6XRFfMMI/9k+MK8OkBRlH7jOth4yPmzqihxgTv5?=
 =?us-ascii?Q?abJ8eDUbJkffRyiMezfwS/QiXiQWnDnZNbjmCNqygw8grvP+6cv/kc/xx/Cd?=
 =?us-ascii?Q?pDq5Rjx+mtpwyNO0cYGbZ0Ljnp8rf9xu5NbaFJg0Dbv3wLmSxzIKfwhcXxVs?=
 =?us-ascii?Q?sIrPG64SFjWUAkkK823jnAPM1oEAQ/dYiiuc6j5B4nkYqmklBvVx3CG2Atxa?=
 =?us-ascii?Q?yxXaZzhVOM9+NlpOy2IviQi+iyaqb3W0Czd3lgd2o4EUSmIIOOI95OjAGORt?=
 =?us-ascii?Q?vbVQdmkDXGHT/uPJLQtX8q1YhaVIk4aO+DTLw9UAq9c7fbivzHlocgFQl4d6?=
 =?us-ascii?Q?q5fHK3EM6iUJo87qkF8WqdAYlMZ0xxMLsM1RCA7RSHoEAsyMJaEwfuZabdNe?=
 =?us-ascii?Q?DBcI3Rz4hzrZzi6ZlyQdcDFpGj6iphcoV+srxXatoqx3GAWa8lT2qN06eurH?=
 =?us-ascii?Q?onlxsQaUI4lB8jqIyFfUmURFyG+8IBDsGQC21Wfzmk7ILEcy89C9p4a4c8zc?=
 =?us-ascii?Q?IHmfkp+OSKTCC5gyBv59aqoJxpdVqzN5ebPMEeDTb+Px30CwHLJHxT0y4KGH?=
 =?us-ascii?Q?yu3JpRDEnoyXzArt9FYln1MwGN4pJzub/iOupNt9IlGROPokn6jHKUmM7hxA?=
 =?us-ascii?Q?1CWa8bo6lYf1YbTxuZMfeRzLzi5yoxwl2PDraRRJcWw+dd9SREGGaZ/rz2Yl?=
 =?us-ascii?Q?8PiSjfD5iUcCEFeGLM/7umLxebCtQDlZjAZEO79kwvFfIdmXyFoQejwnYBEy?=
 =?us-ascii?Q?lr+DMYg6vIIgbNbrK9ms0yI3/tmEfz5/m1KJMcF//Ew8X9mnx7pa0WhtR6Wh?=
 =?us-ascii?Q?V6rK+K1N5E4Pgt5y+O93/rnADlXPJfAyuvATQKCMfqFUavQ+a+jfGCApU5ic?=
 =?us-ascii?Q?dFilFj9KUztBzHXMBaUbItufxBdl4q5DHbpem2YjrGnHwvhjBC2gqOVbT66Q?=
 =?us-ascii?Q?R/y6nEp6D+1rZR1KdF/6Q0NIWvP63+fJ87GkeLDGbyWduYIuwsTd4Jh1tiMz?=
 =?us-ascii?Q?ZCwoJtImRcydzv8oaoknDJb4YcUfU/v78RDyen5NjkVp0X9gMLGaVlOJfUQG?=
 =?us-ascii?Q?bASI+b6DP94DIja7o4lBKwHs8xCZQvBV4sjzH66JxEIjpUg8twjIR5U2xJoZ?=
 =?us-ascii?Q?sOiaPB57HcdTRiHJaamfdTeESG9CysXdgS21wDrrU5Dv/lgzdmCzy5pvYNnq?=
 =?us-ascii?Q?5RI8ZlP01enZGRxOavFM0QBLobXht/353nu/cGnFyCjaPMQYb7Igp75Pt8vr?=
 =?us-ascii?Q?E3jk3eAqx5pbe5kDfcojU8oXGOYgx0Sklidb+xno3wFdrjTuqFhu/stkAMV8?=
 =?us-ascii?Q?1N3hpsVnvg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4288dd48-36aa-4199-563c-08dee1784509
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:19:41.5969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya1lcPEvYjgAIV7W6Tb5VnC3ArT7s6zjlzvFtza+pQySYDObw0nTNvyaVzfIZntmDUJoiBbIB083S9aahIVHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5374
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

When multiple Ethernet controllers are enabled in the device tree,
but only one controller is actually present in hardware, the
non-existent controller still attempts to connect to a PHY.

In this case, phy_connect() may return NULL without setting an
error code. The current driver only logs the failure but does not
propagate an error, causing the initialization flow to continue
with an invalid PHY handle.

This leads to failures later in the initialization sequence.

Fix this by explicitly setting ret = -ENODEV when phy_connect()
returns NULL, ensuring the driver exits cleanly on failure.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/dwc_eth_xgmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index 311b57011c3..4e664a88f68 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -507,6 +507,7 @@ static int xgmac_start(struct udevice *dev)
 					 xgmac->config->interface(dev));
 		if (!xgmac->phy) {
 			pr_err("%s phy_connect() failed\n", dev->name);
+			ret = -ENODEV;
 			goto err_stop_resets;
 		}
 
-- 
2.43.7

