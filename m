Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08287C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95738424E;
	Wed,  6 Aug 2025 07:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Aeg/dPUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9BE83965; Wed,  6 Aug 2025 06:33:34 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43B283987
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA9QRxc+ac9OYKOBwPuOWJ3Zb86TvSFfY/iePOOx1i+EyBmknwsfJ4RFpgvCyqXAZrmOFGOw78SOiyvuMoa8mYA3yYVyuomGoVcL5iu7x8I4PsrY272CBmLnvNtVuL2SDw+hjM6vYWEG07p80r7ZLKB2X4JZcDu4BuZA1qZeUiqXC4anIMauDGatsJt2SsKuIwj93EZy1eBz8VafjUtkgw8i3fvUPW7HaFufdJYAURi1cRP3ZMCD6bH3SwEjSQpHsvJ+/nTuaP5ohH/bB3ho4pTdpB1kr0Gq02001b93oS8j9FJa3g3OutqrgGi1Jbst8ppcYgXYWPVnJG2TE6LasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=BcX00m3nv0YgS/MbkkOexysfoWeGJChgLTZFkJW9ztDjmbkwO57CrF0SGxIFgG3AFRXxULFkyrNrP3p8a/LvEqWS8+Ec6aawUV95f9/3PVB7tXqLIbRn2ZzFOd0QdWT0j+wU17CCiQhBSQYuBGV5t3OFu+/bI7Em29IkmIcKi8KiUDxdPE4NS0ckGNzIYUTmZgYHqh8GktnpVjfHdft26vrqKyh7d4GS4bZLResZMJgMuyKZ/v0dl0iJXA3MT3x1g9LVtKa1FA1uX8ODFZCuwImh2HuwHcWVZIJ9jdiIxrjLIequBOTkGMg5/mYZI1Am/2KQ25ix7q+jkugat+gv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=Aeg/dPUBrOGfdn9XTW+CUjvv33/7fa6S3Js+JraZryT9s0UW22MMXe/fZU4yUWqn4IOdIm4vwisMYr/4XxHQ2FiP3lLb0/IPqOUAxCaPUuXINWWbvYNbJGRZVJOZj2N8DdKf2+KVj932s/Z3qOKX5SABAT+f3SrBewwTYh96nlGTd/anMetsxNFojBQysHwBltsumCIi71aYk6u11vgQ/5m8VlLoqmhsxV3KCwTjHvovS2ra4t8W0I93Yqx5nn+3VZSlGZ32h8R6XVSUfT25Pe4oTKBJz40EJN2QRdZ7KXliSv2e9YgV/gL34C/87yhtVzwZEMqHZGR4mt/Tpip4sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:12 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:12 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 01/12] drivers: i3c: Add new i3c uclass id
Date: Wed,  6 Aug 2025 12:32:24 +0800
Message-Id: <20250806043235.2260-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe1ac72-96cd-4739-bb42-08ddd4a25a6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?19XCeUltFZ84wqgcnmi/+SeTTldIP2n+czrOsnoLJzDtCNombBZOyQpQ//4z?=
 =?us-ascii?Q?kVx5MFWkvD2ak2vpI+dvt94bSZmPTF6N1feNi6d3IeEXKcnSy1VMX64Q1xza?=
 =?us-ascii?Q?FZKVI0VOIekd6gEBkoofkgjF4eYzUe+LQIckL0o9e1f2QpHhkRnYMJo7zYdl?=
 =?us-ascii?Q?+VdCz54+JVMLcclIa2gGoq7IesBcwrNtw10527yUwvgIPaf0ikErxa9mLnfa?=
 =?us-ascii?Q?7ipK40zvtl2VCNkd7b/etgyIUtLUb5RiNO6UWI6gz/qzz+aCvzs+Be+peS6u?=
 =?us-ascii?Q?u6WBLTqw4jjsOG/nLmJP3o4IzSiVmhTAdL1KaL7gJUw9OU0jUG2hrKOLB5Z+?=
 =?us-ascii?Q?KB9h+ElLCZYTuNsMAd7cGqCTJbEFeaWXZuGDXStsADG33Jky9Ek4a+hP4Sli?=
 =?us-ascii?Q?7eYXcTGq+58rwcDquiGhMEt4c/NjHoY4e1b3BYGwvLoIncBr89BmUv+fxgFM?=
 =?us-ascii?Q?kJS/Z5H6SlFKFrWejHhaU3JM0dv55hTbo/YjTzNSDOYOruql0vPNK8QiNKiJ?=
 =?us-ascii?Q?bt56PbBb1XlNnuYQJf10Ia7DcsILe5bP4Gb2FklyDfB3/hOcDg1Z1kNDaqaZ?=
 =?us-ascii?Q?kP1naMaOg9Nre0biQfMUwz5LeAC9IQyfyI+/6MtT4Km7zi7JMPMelW+8EHX5?=
 =?us-ascii?Q?29YwF15hh0xYHQLfrb12f9mFlSqi22xIxhh4Jq42/zwtdpO5Khp0Mw0+Xfrz?=
 =?us-ascii?Q?kUl5xQni/WbeEk5CW6XbY5Oy3m1MutMZF7BF4pNfCZT7aXeti12pjFI/dSx7?=
 =?us-ascii?Q?t3HlUYtWlBPmzn/vrPPUgwVLL+3QZceeKv2N22XCelWVew1pQ9YysEJlfm4k?=
 =?us-ascii?Q?WdOFVhf2jzimiaKEu5rfqNi9n5Silk9EDMIR1gbSZgunqkg46tfdtee4onEa?=
 =?us-ascii?Q?Dyu8j3DTHHF7btRXPJf9dVh/X23J2ijXme64JkLpzpupJB0Tn7N4D4pE/n58?=
 =?us-ascii?Q?jTE+urRxZOjmpxpy1jX6+HjG+ew8zETEh5pAwa8elzkolD/RqkBEL6Dt8sgH?=
 =?us-ascii?Q?r/h7C9zT1eyGhwRjL3yxvzDWr+izr8NTNoE1Za+Dk3nSyNlFO2IyTBMHZpN8?=
 =?us-ascii?Q?kgSsRUPdKRFNjVHeTp95jIOXU9LFu/5ToTr0b3UOuUMDYshGibwZTo5ta8DA?=
 =?us-ascii?Q?af6mjX22vUh3W2A3NDRPjZwXvxdQQj/R7bV828I4fLlRoVMGdlDQ2R5cBkJF?=
 =?us-ascii?Q?M0a1RQx6UneGJWWyv5EcbKaHtfb1GdLsa0jWetNeaV8f8e8u2R+k+KSBaG4W?=
 =?us-ascii?Q?NsVNFiMJesodPV0V2v+1YXejNEydRqoW8jEEmL1iEbQfIeloI0Zg9xuZTM7p?=
 =?us-ascii?Q?swFvC3iuVmu1WhFe+sqFWcbqWIDqKK0n0VDfcNmp6/MPbHFGOaAipgaOxypF?=
 =?us-ascii?Q?ujpbsuYKx+LcXA2eWIQFCzstRFYkUs0ugGpHvo4Pi3fCTLqdvyeOCkTzS0IE?=
 =?us-ascii?Q?9u/sZsBAMoo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llcBaO2Nh3nMA/fAGxFK3bRQfGICkf3BmxHY/ifrm5xM/BT+qDXxV8/lv1Ea?=
 =?us-ascii?Q?x4GPADWEAWKdlTGu96h+TodKmqj2k7Ci/LGyaejzjNZkRVP0qeRBD0oAHWri?=
 =?us-ascii?Q?bZqjusq8RoeMQAgdhCfCu8z32+aI55B1CslE0lJgwGqjNlK9aTpf+kRBtZaS?=
 =?us-ascii?Q?BTgTnUnDi2Qt2RE+2+iqTkYsJSdM15Ct/DQpo5lMHP9qVAgdyMRBfCvPxwC8?=
 =?us-ascii?Q?ABWpEauVX2UPdRsvFe3G3jggNhCONzuDQJMA3xI3aGQsOEgNGoyLF2mVjeGW?=
 =?us-ascii?Q?GjOkgAX8mdWV5d1QkBHgYETc6UHF7sY9KT1wRnwkX16Oy7zWY4BCi/1oWO3Z?=
 =?us-ascii?Q?d3nV7EGwY9rMtvarF/YkBFlS37+tZHRVOm6BCkgRCJ/d8yzmsOBpQyAWJfie?=
 =?us-ascii?Q?A/FdmEkrguwT2UpwfiPsw0L0xHMAQ0YWOVeoTTNx/mGsXOtKXB9HK3OvNPt1?=
 =?us-ascii?Q?+76JWcrRZQknGVOCR5KsGNXrVnnLoK7q8hj23OwzUTHbR4452JaB10w619PL?=
 =?us-ascii?Q?V1s5QtH3GelNW09KEuvo14PsaJWkbCteb+JhpYrhuUWYw5eBnNKztD3WsFb2?=
 =?us-ascii?Q?I58uKFEYnWUp9oPa6thNO7gnC5L/4mrCJtCxpsraheMR4955Cc0tznVpd4d0?=
 =?us-ascii?Q?wbqTwufIasklLMTePM/cz3c1JXuYhI0jTi3wEvsbR4OJtwnZOoRC2D70Q9Vm?=
 =?us-ascii?Q?el12MfK2l+68iDsGe98XPMVQqFHtMQJt8JM7DX9lIN0jTFzX3427CzGlJbdv?=
 =?us-ascii?Q?dpUYdq0k5hsQo6GyhPQuRuuPdCF0Ck3BAihg/oJlvReST0OLQs2x7xFn2od3?=
 =?us-ascii?Q?FYWG3DzBKgHAFB/5FgNnAHVksoG5BWyt2p5St5dyz3ZlRvUaDs5l0mYFMpkb?=
 =?us-ascii?Q?stp1XGuOyJivHNJtlTBvOxZM/wZiGEiBrom8TB6LZgPcOWUiDZnuwOp46SHn?=
 =?us-ascii?Q?5NZR3Uy0WZZqfOMnUpzBCKqTgnt8ZweJiORuqPNz2Hj9rb8OOSgqMBRiGwXh?=
 =?us-ascii?Q?y8ukoZoVN7owe8vNetekH9+yF+G2N4pCUcNKl7GLq70UvpZ5tBrQKFntfSBZ?=
 =?us-ascii?Q?bHamMicUhgmQdJEiAkViWbWldJ+MoMSs+b5JCa3qOkkv8FAVIhWRBy4apFAs?=
 =?us-ascii?Q?vDq9SJBsfhMBZqb/jdvGj0BOWJbIPSVFockre6HbajgxvlumPE2uX6MQtL9u?=
 =?us-ascii?Q?CaVUrgio5PUKULHew5q+e7hCMAiyU/OJHZGvUMNEVtVICUBomgeOBknXtIgF?=
 =?us-ascii?Q?mrmIK5POPhyOafDhlyB4b/OnB6uUgzZskrkwYCJQ4F+yR+GsGe9zMJLyY0gQ?=
 =?us-ascii?Q?X/NJB0kJWFzzCSu15D+NalwydjT8HeL4Yb0nJmBP+vFmXeF4NsCfdXNFy9dP?=
 =?us-ascii?Q?WRNk7t8wjEPlzaouSByZGIZDIiLec+BG3Z+5yuvkykAac0wrJHQ9EU8pRMgP?=
 =?us-ascii?Q?63cAO0bVgtMBYNTW9BUhq6gOrjqStZPUOq3SIrrs7P/Puoc0Uuigpbx/puP3?=
 =?us-ascii?Q?AqfbO/wJztgwBeeVTD6fLAH0VPIfhdeB3Q80deXkOZI6M1fmDEDdTarngf84?=
 =?us-ascii?Q?gh7zyvs3RLtOLkob++3t4ASKv2Kw92FCjPPBfaLlrXoyiLB4Eg8bnN8TMus4?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1ac72-96cd-4739-bb42-08ddd4a25a6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:12.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSR9MKToSUNyCbBLh6I6DxzdcLboXLyFE3n7OtK30j7SYqGxGtGzdAEJa6DSCfSW00wzY4+9NAM+SviYA6z8OJe4jO099/IeWpKETXOTCvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.35.3

