Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A2F327BD
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601AA84324;
	Tue, 21 Apr 2026 09:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="j4C4Jmq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D6E84309; Tue, 21 Apr 2026 09:55:00 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F4C84258
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLLTDPGFGCR73dDteg2RzfX0jdQxmkonjxszx28cMz9xeRvIcKDnY0U8n8QE/s8gmKEeBcYBPTik9TzK3fAWoD4aqb8tY+wEOQ06oMk6A890qIQzh3b38zVyTKBqcMKXv5nJHXEDhCYjrIhqOPARPwDaf6j6ax3DVb09sDV1MFGxNgAjyCNM5Umv0o4ehRkICYBQuKE0sopSjYmiypflSZKzk3Sr5Qf9Z3kRN0vgH69ZFyQ6Ek4K4P4z6nuijjVRc+p2sJad/AomKEMED/+Q9By85jWM9Qk+/BDU9IzKQmF+2mQsIg0FKijkpDumfDyhYuNDpQucHBzsHSWF/2amtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw1UB8jAZrUoY/P8fTibjTfGajPajqL9QXgoZakzsvI=;
 b=JvN1J5QKNl/iAy3O62DSctcJSCGWuOwuJ12t533GiBJo+9GTO3w7VhKLo03H9gcEXy2KxfVUHWHhGdRDM9qJ5uOAvrhM65700q9TqHkcUV3VAyNNaqHixKtk+1hx0XUV6ajHHhpm69HlUjpdTyYOJyJrJMbnEXIAP6uNLx2soghiE0BpMUleMXkBqgzQJyAGAPjFUoy745Na+6Ex1xIwB5yCC5NB2jiZX8hxlpX34sqTVZn1Yq7o/eMhAduMbltPYX2MV0riRodWh3Y3+iNg8W/3IgLEURPgc+tIHo1uxhYcGv/Lr0Mr+wIChL5wr0IUqoKP/9R7TvTDjr7SjzfZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw1UB8jAZrUoY/P8fTibjTfGajPajqL9QXgoZakzsvI=;
 b=j4C4Jmq3UW+LWCDOJegqDrtFNPXdrFLPG9mUfFjif7on2MC7j7PIhzrWAYdvQQx5WhWEtbRF0oq5Ku3nTKZZra8KXNu8xk165hfdbiI6WFQpEmj5K2FrsgkI34PdtCkv33tqCN3QIMvNV6TVdWPiPYJhUiWGqbcZEOuxb4GewhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/9] stdio: drop stdio_clone
Date: Tue, 21 Apr 2026 09:54:32 +0200
Message-ID: <20260421075439.16696-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0024.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 683e2bc2-edc6-4e9d-b315-08de9f7b460a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9WcK9RLLxILoyP2JH282mJvydCzf6B3KGLdNjt50PkgZn5o0vBkoqh/1swIAdKDqk6E2A/UF29+oZQvaapSLKhaZxXmsX6MeaKul9LcNCqbU6WTLPJg2nMwxvTLtbhSOjWP/H/pvZCII0ks9SlkMYlP8C07LQ2V4cC67NIGSlgfeaiyW2F1Es+yGZipPNKXQZgcCve82Fgqx0/wqV6FgBwCqT5qtJyQdydj3PqRBCjJc64+/q7CHvPhD9xKmHYyAY/Sp8gYGMZXKglVM1BFeLdntgLc+FByMnP347HRmOZq0htLr4fyiv6GWvTpWTcOtYSmu7kzZCij2F9kzrEX0rw+Rg4oZaChcqPEmiV/yJddWduUjJszoW42YKGwv0zADDNsdE4KxdBwN/28Vozm+DONqEFu2YLjc/iDlhuu7IhR6/8mlZai2M/670yakocMyf6SUL+KkruXpYVxfPqskXecUKfySAz3acNMWbFniP2ODMtkkGHHSVChAaHEoqBDOD1rXSRnG6yjTUcnX46nZaRYnKdXqzBW+RzznaoW9DvSLBoyd1ybMY6Y8kq2pC7s8TSJlzbLGjcS7p1Kq1VnqFkhsq5zb0dreS/gWOiCMVG1UhGjiHTuFZ3mgcEaad2dv2PoNrSSkcvR/Ri6CsEi54nfjaN5wYZiBYgakUfajTw8vc15oV0phTiaKNku/ch+5pafPQJ+leLPNadXjhxvso49vVoNLyxqEZNbFELYF8IVi1lwlimTM5n5uojf3LS018HOxQsH4WEgeUstvKCT7PbCDuieWmNi09LXrmARVi5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NSO/W4v6zbzZgXiaUNCDhv0+ztwq9mrmi8mqrEPoPVw0eXNpv+ZtVICPWoP?=
 =?us-ascii?Q?G6JnfuyVRWNH4Dq/0Cg+mZYeCDTxL3yvb2hIYyTcIz6znmWBbIf5Mu27tlvZ?=
 =?us-ascii?Q?0hB7ic2axSrWsv6oqS7wu5wcIquy+le0h6FezYc6g0aj3m3ueTxlfOK+bfxd?=
 =?us-ascii?Q?yfYJy7veDkVZEksagWhwL113wjxitLaFIEN5cTu7Xk8rj0831oK2VHnSoTB5?=
 =?us-ascii?Q?FYBA8Kb4JgRMsYMWjDRvYIz9o00Aae34UjWm/uoUHfzR3MWbesWSc1hv/DET?=
 =?us-ascii?Q?ZQ3py8mbHiG51VhXr+fd9ygG6SwAllK12ZFkz+aBAW+/MdHhQuxwzTcAuLLT?=
 =?us-ascii?Q?Jw54gnEbzMaJ7lpnYpw9Bt/EwBJl9OeS2WWxKHWrZbvEAgXzdftJ34SxiaH2?=
 =?us-ascii?Q?uOxDNgcAlVVaKotZYDWA0p9DhHuWdmJV6/XRtyaNgGEsTCfFWXsHALdixA+Z?=
 =?us-ascii?Q?uxJSuNzizDXiPxYiSJuFuR1oFD8cpNr43UgTnpz10rD21n62bF5+wDIr2oL6?=
 =?us-ascii?Q?SGDFYBQKLAPdpryZ3SWojM/+jGSMDOH75HdzmAIh9DRLDM/rUOjUsOz5H+yp?=
 =?us-ascii?Q?n6y8IEuiaf5C8vtEJbE6aAAeQmrxkUkDHYMDpj6hJl+iCHZBT4Z7t1Z9aAaN?=
 =?us-ascii?Q?W/s9zJauKlk/nxZ8Cv+skA865P0iY1N0GeUFt1m5gizkikA2j3dmbNNCSl5X?=
 =?us-ascii?Q?MMok/KqvnPmZq+GRizh37Nd1E25rhunYD3TWk+GWoSLDPXNrt/92ie2mmVAk?=
 =?us-ascii?Q?Ob95i+8GE4juM+D6PL4CxtaMzsTgzBDdx33awu57VpRMD3oodPRufqSRng22?=
 =?us-ascii?Q?F9iQwueK43Hxopm5i/NUx9tNXYp6AG838qY9KAgAkp4WEYt8iiUuQ/nDs2dv?=
 =?us-ascii?Q?axjcGI8r5ez/8ctdUllQNeA/0BFUSiKg9GTnWnZLNAC77mZRnZ7gKnqA9KTv?=
 =?us-ascii?Q?gkzM+ZsXhwebP2YtEIN+X7cPmFYIQqnuCnF2ds/EQ9Us2dupngh4Cw9nm8l8?=
 =?us-ascii?Q?ekYcLgAPM4lyFJluFSqTGG+jGbkorZKVe2J9HX2GudDm9ft3Tq8Li5af2Ees?=
 =?us-ascii?Q?21rrk7jKPE+KXn+VGVAomgkm3mSeDP63cPUhfsyjyl+lf3ArHIFpkNtXKizX?=
 =?us-ascii?Q?lXkzRxAnk2iArRZCPSw8tHxR3fVTOBHBNUB6BHNW2UFWvSVoFUVJxpfRzZNx?=
 =?us-ascii?Q?KhFD75bexeAfgFZPSWyj8d22bFt7ikMtq6ptfepTx4CROkIKMqHWCHLQ98I7?=
 =?us-ascii?Q?pAp/4XMeSZa1A0tjYPp+5NBxd91j69rzLUJWzO126zmh1zx8kaPsc+IghHO6?=
 =?us-ascii?Q?O1PbcsX3x2uWhFmoBZEDRyxvygW7GZOLbmWtjM9fWwXARRvxr1mL9xfrPsTy?=
 =?us-ascii?Q?UC5kfY8Mxh7LZHzg+5ghnTHh+c1BUzwQnFLyYBxWNb9smuc1cxb8qqi+VR3M?=
 =?us-ascii?Q?7AieiutI2wKFjNm8ga7UEMmqnbGWVSHMJMCKwGWkBQECETPKIC9GT0bJij6K?=
 =?us-ascii?Q?D8PwDP/5HeSq9gsDmlw/3wyJr91G8RiBBDccCMgJy9QxIbD0GC449yNgx04F?=
 =?us-ascii?Q?Tb7Yd9i5nSnH9GBPIFWC9ylU0FV1/HMZQKtbHX1tegfJGXU5enbCz4UDrHlk?=
 =?us-ascii?Q?vfGIWXHBiGOlO4BBoL27xVRbB35zdBuUUt7CyDtZrptuvxPyHQ4M2rjzJuqt?=
 =?us-ascii?Q?qjPSM9vpxmA0BufPgCrWCarfoTI6wEjUxYg3JlGYX3QsKkLRXJRHFE48sAuI?=
 =?us-ascii?Q?tidh2nEDpGBNf7J/QLYGqBNaZ0IKi70=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 683e2bc2-edc6-4e9d-b315-08de9f7b460a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:53.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8p5g0KorEYuwk6glBstjGMGATc8/9uyTrkZgaS8eWdQpQ6UwmrhKY1/ZAAjze8gvc/q2GnQKSR8BUVe8WYw2gCk+0bYPnsVtU2N/Btg0LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

The helper stdio_clone only has a single caller, so it certainly
doesn't need to be public. But in fact, it is merely an open-coded
memdup() - which for some reason uses calloc() even if the whole
allocation is obviously immediately overwritten.

Drop it and just use memdup() directly.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/stdio.c      | 18 +-----------------
 include/stdio_dev.h |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/common/stdio.c b/common/stdio.c
index fc965944209..038e576147b 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -217,27 +217,11 @@ struct stdio_dev *stdio_get_by_name(const char *name)
 	return NULL;
 }
 
-struct stdio_dev *stdio_clone(struct stdio_dev *dev)
-{
-	struct stdio_dev *_dev;
-
-	if (!dev)
-		return NULL;
-
-	_dev = calloc(1, sizeof(struct stdio_dev));
-	if (!_dev)
-		return NULL;
-
-	memcpy(_dev, dev, sizeof(struct stdio_dev));
-
-	return _dev;
-}
-
 int stdio_register_dev(struct stdio_dev *dev, struct stdio_dev **devp)
 {
 	struct stdio_dev *_dev;
 
-	_dev = stdio_clone(dev);
+	_dev = memdup(dev, sizeof(*dev));
 	if (!_dev)
 		return -ENODEV;
 	list_add_tail(&_dev->list, &devs.list);
diff --git a/include/stdio_dev.h b/include/stdio_dev.h
index f7f9c10199e..d93604331ff 100644
--- a/include/stdio_dev.h
+++ b/include/stdio_dev.h
@@ -96,7 +96,6 @@ int stdio_add_devices(void);
 int stdio_deregister_dev(struct stdio_dev *dev, int force);
 struct list_head *stdio_get_list(void);
 struct stdio_dev *stdio_get_by_name(const char *name);
-struct stdio_dev *stdio_clone(struct stdio_dev *dev);
 
 int drv_lcd_init(void);
 int drv_video_init(void);
-- 
2.53.0

