Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D74C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E48A680E23;
	Tue, 21 Jul 2026 06:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oX1Yez0P1d15; Tue, 21 Jul 2026 06:16:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9163380E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784614599;
	bh=6aEFO0RQDrn7RB12m2jUPwQnh0Fpo6Vdfelwi+7BECk=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NALQvJvBJGh12+V7v5ewuQB8xdxmeaXeScpiEya9CF1dE47F3TP2g6jbZWHh/yDnj
	 iLG2Y/Hpxs1XHqUl1mpAYMOKY5w5Bq+bJgsM7UMuRboJYq/W3o91jnAoss37Jkeh53
	 Evd2OKdI42xNgwECs69FLAklLvN41Aa6sS4Wd3jz5cF2qdSYOkChZKXxhIIuxqETNI
	 QCwuyl3g+g7JHKVfr9GmkGzBaQRRM+Cu9OG7/ZcNcj0Tbdgx3WbJ6ERG21x3wjWMwj
	 mTCjZhB5tkem0UGTrqUhugDkUZ89lM942dzRgKFg1F4LfBn4jy4nmVYG6zBZwsVFae
	 38zayEEeeaajQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9163380E19;
	Tue, 21 Jul 2026 06:16:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B46B7EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A54140819
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPuCgA1WojZj for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:16:36 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E3A840817
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E3A840817
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E3A840817
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21354848BA; Tue, 21 Jul 2026 08:16:33 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85716803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:16:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erA0kHHI/KpADXaY7FEdafzMeUjBN6a9Ru+W46V1jhaV/5DsqglcEWcUtfbVbZb75ADv1S6E8xkOHKmUC8+tGYKUBkQkLd5XFanm4Qyxhy7NEHiJIRYfAqWK3li14sLBct+uBRU7kXTiu+GlmH5IZbCBYPfcI0AoXjvhc5ce+345XKe4OSPSSTtPA8hZm8cCWwJLIrXrlN27cgUXQNlPXKcxYnjgNe2DgZdoNBRQKJChiHFMdXfUp4ZLa/dUP/i2Cw/tXqerfCi1dLHukKoUTOKPBhDJa/vILIm22sD82cgBoUCofR0VxogzSL04/wOGgG+2bJu8q4KDZI+5Rc/1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aEFO0RQDrn7RB12m2jUPwQnh0Fpo6Vdfelwi+7BECk=;
 b=w9p124FR9N2k+4U8aRDTlq+yNBXu2TXiOgMHGZ9L4ydwUMEycR8qCOEduX62OPTJB57xktwXcrP+dxjVzRou7SHg2qvpWZJmAkxzvL9KXz21O3cOwPTIbVIgg91CEyWxSNLboEd6KepchOfJBuOchgJCgsKao9ZqHknuHOdGnulNeiSWHATPGPoPBEKmWuR/Zbbn+NKpyA9kIUcbRWkyAXuzUcq2/ePg+RL1UqRojZ9fCOkp0xUfK91eFwvJMEs6JqLh4dXSVm1C4UD1Q/F1U961eN4hq62V+elKexekLNdCzL1MPquUmjTjZOkSRzebQPWKNcKkiPkX8kqcq1E/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB7031.namprd03.prod.outlook.com (2603:10b6:806:337::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Tue, 21 Jul
 2026 06:16:26 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:16:26 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH v2 0/3] arm: socfpga: Arria10 SPL FIT support for SPI/NAND boot
Date: Tue, 21 Jul 2026 14:16:10 +0800
Message-Id: <20260721061613.8615-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dbf36e-557f-4bdc-7163-08dee6ef986f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: jWTS5DPceQfoH4j+Z70eVtPOaqJX4dOHm4uBjdkJJZZ8B5mYHbrK0TkdKIhknhev1r/GOUTs0W0CiRkSLNiZ5Mzwl7RpkZKm6cN8QjIuMnPGnkIXdQUbOD54HIWAL9b5jWW3GB8/vkWDh1LRldwnSGnlRVpI1hS01ftnL0OtkRcgTfX0M96mIlSTAFXHjztkZZUV+kC20OpgngKbTH7TARFAUWv7hQk6NCnNu1urrGxjK037qSorLHIvcHL2+eSR6eGbQ5WFQSvCsS3piWYoGmzUHlvUK/eGLFUJyAMJmA0BUOdlqDyyD52hUNwM7Zk59o1tn1IRDUS6NXqVW/qHi/n91FHuFFffzaqkF1gQRek29DC6K+Cu5H3jp627dfq1wcVN8diRM8Mv2uCCA4p0W2fvhaQuRl7ykEiXWji0GR0A6ocBtLq/9poALmOnj/HN7wjKQINoqvWQAuR14yJzjV1YqpkqKfNQwerdDobm7IDVH8R3w5GTj1YJEybuR1BAHpl9Y8oJhGC4Z07/lRaT/thCQTVw4EwyBCfhjmbekKtgLZfOtyKfBhDLvQQmiThWkhj/OZ5Y6eHRftYPDRtUXW41eTNFcdS4KfJWmM5kkEqcGOjqwqBJpGjLOuKoR7XydFM0jB5ndcsfrgOQvlU3pbSpd4avDWwitKJc0XSzQSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbMT5bu7U3DNctUWwnZD557yv3hp7VwSDsqGL/MFJuVZIIK+YvcHm6XF5/JZ?=
 =?us-ascii?Q?CAesAehQhYWNmwOcbbV6deNkXM8XE8FLAq8VWSURyBpDgqsHbEZ1AY2/sF/I?=
 =?us-ascii?Q?HDn5RUpqAfkxUiLacRPX8uzsku1KRg5d3bDxDh2AY3+y/HbGR9BrULoUnxgY?=
 =?us-ascii?Q?5DRXqDzNjdCQIYuANPqhMQlqsbSzYghRopeKHCkQewz4kbvQQrmd4FJMKPdo?=
 =?us-ascii?Q?r4d1cJNuA3nhKCnxNVJ66rLUyfHonjROSf2k4McolP2oe/c3oOuWA7wInmBY?=
 =?us-ascii?Q?sv1cNwqiqW691hWt897JZYF/ZFWeYrzfW6BFv3SHl67hc1lVylgpA6TcXEVo?=
 =?us-ascii?Q?nBGi6U9QO/gbM/P1y5CcQLIK+nADmbNfYyGinDeo7dTnOpOf2EFwNd/3V43n?=
 =?us-ascii?Q?xSgTpaf/9Bd/gLz3IQ2etWBN1y2R9vGEPoncGZWS5E3CJ9YrkytHiDp2zUnT?=
 =?us-ascii?Q?crBSWWuDcKPmS/09OYIn1T9eeA1bacTYhExjfFCAfWSyGyjWeE3f69Qyql68?=
 =?us-ascii?Q?Y9ZdtYAfeZ1nJzL47JqUPGLIr8y6g/+teYjplAucnp2/dR0wx4YdcA6Asdw2?=
 =?us-ascii?Q?YeKHNW9rCHlSEdmhg20FjVQ6jxO+veYX2etaXHpkDQWpqKihI4b30faqtLnW?=
 =?us-ascii?Q?UWVQc08QOrWGd+aiKRvTWm5oAa7NOYr+1MUzpZ8CqNjE46o2b9wAal8SavSl?=
 =?us-ascii?Q?EYMKqFQOfThToDahePMFjud5a3z0VJWckgiLlq8qu301C+JwClpUFB6XJqqP?=
 =?us-ascii?Q?JTkpMUig5JnGodkEh0EdWHvHDLS52uq0N8G3v31HZVER9EOzd49SKuX4v8OX?=
 =?us-ascii?Q?WNAOkj/66HNN5Ib6Cclfo/ZvX0tmZE1qbLbTck/jmxIu5EEGI7F4u+8xCkKT?=
 =?us-ascii?Q?mpNtLFa4SmBR7d0iZOZwJQbYtiLIAKjEZrKyBM8g5oI/KSgceYB0n3kub29b?=
 =?us-ascii?Q?2MMLX0rWp6jOSLnyEQTNFSLjntDuMQeB3BveamfhaJ5Usbk//oZwSWnV0Mfx?=
 =?us-ascii?Q?9P0kowU6X3KW4pE+3Jd0If+XxhGAuczqf73V/nNRM5Ek9fkYYfMU01xkWhzQ?=
 =?us-ascii?Q?+oQ8qhoBOXXyl1mHW7VHypXzLxLkHWvSHRxjsoyrT54P9SYWaFYcwx8AlXUV?=
 =?us-ascii?Q?LQCBRydDGGl15s603EFyV+Y77iLLX/eVKQimBXqhj0aMIrnNhr5Alwi+XDxS?=
 =?us-ascii?Q?/T41TnPZJ9/fVdcjpt8zgYMyBKGtNZfVNdpbX+JjAblVFoo4yApdtt2Eqn37?=
 =?us-ascii?Q?o5rJlZIAT+0i7CDHVjWQJVidM6lpRygkRFHlhnmgnqiuPp0n5HhZhgDBM3UV?=
 =?us-ascii?Q?7/HJye/ghWMdTn+zBvHFbAFEs/7uXkTPILr+av4vU3z1jod8vMPdkYKxDz8h?=
 =?us-ascii?Q?zTEHiF7b8VBNrINrOHKWndfbhFfh4ALc4PSv+a4PpoDPfKXTx5NJlAfBg+Z/?=
 =?us-ascii?Q?L97XG8fL3lQb5LNDkvbhfTU5+3hyMkW/dblnQ5psOWoSC+b21htu3ScmSjfK?=
 =?us-ascii?Q?jjUosNbKZ5KBUEBV9pRQCkCWOHSmiNGWcqFAgmE9vS+hbTCDM9pHg/bN7YXg?=
 =?us-ascii?Q?4uCgWax2L1pj7MJ1SliN1nKC2YsX+WCIUe0CHdMtIXltGr2jmSGb17TzAUwT?=
 =?us-ascii?Q?Tv2+vvdGnL8W6TBZByMqVIV9a8Hn6/hplElnShso9aPfP8i4yyDkV4KwSryU?=
 =?us-ascii?Q?7XnEXDkuOJt4g09lwRUlvRs3ivt6qzsfRUDnYK0YUTapduPPFiTg8MnnQzwO?=
 =?us-ascii?Q?DbNROzFIay41/9d30Ww7o+YBUsW+OVc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dbf36e-557f-4bdc-7163-08dee6ef986f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:16:26.5933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woBRk3xbACKGrNdkTtnrYS+OH6w78ylzACH6Not7rCeCdQI69WT6fAVFsMs3U/uxwYNkNna3DyWHyMcSf0ua8BmiAvAuW4j88oBzzR4SlKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7031
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aEFO0RQDrn7RB12m2jUPwQnh0Fpo6Vdfelwi+7BECk=;
 b=sCU61SjZK5MqbPV/vzNr0PgCwQRoRYPhEGsNAskoSmqYIPFgdrcJZi+wEh/fsipOt5bXKW6PkxrkGEVIFklm0M9UInY45Xi6lYtZ92F9YN9F2WpTDmcvUIa4mtXiMyYnT7jUksDQerng5jByLCToXX4W9+E6jyIaaWGktBO4IduXh8NQ1heudXprjlf6j1eNPzmuFz6ZKCcIlIVRQjaJP/PYGJr7pstEAfkrlz398c7PWO6JXkpIU5gR2lpj516cANX7AFCw62WHMbAcbA6NP7fkO+U4/Res80iY+uKDm7iwT1uNcl3aMgCZnoE+PG/sEv/fP1eC8ns7bddA2EAoyw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=sCU61SjZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="sCU61SjZ"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: dinesh.maniyam@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series enables basic SPL FIT support for Arria10 SoCFPGA when
booting from SPI or NAND.

It provides an SPL load buffer for FIT headers in the upper half of
DRAM and a minimal board_fit_config_name_match() implementation,
allowing SPL to load, parse, and handle FIT images during early boot.

The changes are limited to Arria10 SPL and are required for FIT-based
boot flows from SPI and NAND.

Changes in v2:
- 1/3: fix spl_get_load_buffer to use ram_base, honor offset/bounds,
  align, and drop unused includes (review feedback); use
  CONFIG_IS_ENABLED(LOAD_FIT)/SPI_LOAD so the helpers actually build
  in SPL
- 2/3, 3/3: unchanged aside from the corrected CONFIG_IS_ENABLED names

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/cover/20260304033029.10825-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (3):
  arm: socfpga: Use custom header target buffer in SPL
  arm: socfpga: Add SPL fitImage config match
  arm: socfpga: Include required functions for FIT implementation in
    NAND

 arch/arm/mach-socfpga/spl_a10.c | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- 
2.43.7

