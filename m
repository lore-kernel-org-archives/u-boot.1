Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604BC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 149F780E66;
	Tue, 21 Jul 2026 06:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNENFVgNuJHJ; Tue, 21 Jul 2026 06:16:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACC4580E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784614608;
	bh=JBB7APtxAZRnuJLlDb0PKO5s3nTkqhrVIpfDtgktios=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EyDD6vWku79huPhzRYhgPc14zrPqT5N5rj4gtr9/g+QUoUTJ2IEb1tWP9HJQEr+VN
	 5HRND09UvoFBe2SxgDezVmoZgvWibG+KI0Gtz1RcvXs+gaPPcz+JyjAKJkA+6D5CTV
	 mKMl9+qvaCsUP7Ke3E+7oL7BUL9NqfNhDn+wjCruZnIJIpo8GOii23qCzndyKwRmtZ
	 8DdBMuAIhggVPNC9d0ZVIFUe7lgwG1ahw6JotmZ+VC3iTab0ZFVd+4Zucuij2l9Lbe
	 k5L2JFKPLhA0JcWy93xuuJm3R/N1gh2UN7lHY/Fq5T2P9bATIhpfIBLNib1FYw3csM
	 QjdwI0rYXxG1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACC4580E1B;
	Tue, 21 Jul 2026 06:16:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 874DBEB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79C14607D8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QcGcksTPbIP for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:16:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42C14607D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C14607D9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42C14607D9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BA6803F6; Tue, 21 Jul 2026 08:16:42 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAC184659
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:16:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMN6rk7XIf9iSci1kUrR+OgoA7YPjbZEHvVC//LnlzZWo1LTQ64zQPP5hv5cTvOGcQNMzBgRN0BTteYCfidlhhcX5okw0mDBeP9GIcGSKIkDu7ArYmEXOSqZ4BC8kPCGnynGDR/N6X8qwf2HqBCsnZOG//ly4Vrc6/sAZ/XDGQtwrcoHzO9Jd67gFAz1R7LG1cXezd5ecYzgmwJK1L6MU4/DRYWrT/ITrLbxWokdUr8WR8q4Gfaa4Je8rRvKN2aY+BqfI2KpxSoTZ7sopaBoEADTygl147bUrlRr3YJFEmu66B94Vl3XZsTRRheUXVV2JvTHPwNQgURDqt5xFkPCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBB7APtxAZRnuJLlDb0PKO5s3nTkqhrVIpfDtgktios=;
 b=Sj97Y3Q7gdQVGFD+VIBp28t/X02h0eKo6FluRKwb6cxwNA2+Xm40ZRRDz+V3bkbnMtYuyMfO/8IAHDKPR14IGcZi/8oc89V4C3c1lyNPZO3FPtJsm+8oVRfAHyG8WbWeNUj4lI10i4F2fDxtOchCtG4qk+SWQWbbdPNEdr7fLHYYVjN84mOTg5CczV3jYBthDhYQaSZe/1Dg9Dk0xVYhidb2RoVlTdOWqnyS+Ehk6tz2nsO+9jfDmH02bcnhlrZ7cb9opuL79GmhDciM2zjuUJzoaR3M8GMf2QhC2FDMkFQqUrNMy3UZWCNBM2+dS4VfUCpjmG/q7xltd8emRsmdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB7031.namprd03.prod.outlook.com (2603:10b6:806:337::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Tue, 21 Jul
 2026 06:16:37 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:16:37 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 3/3] arm: socfpga: Include required functions for FIT
 implementation in NAND
Date: Tue, 21 Jul 2026 14:16:13 +0800
Message-Id: <20260721061613.8615-4-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b00d9d7-226c-456c-d733-08dee6ef9eda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3iCXsR+saO/WecwxwwFK2xZ3BSJVKlUD2zMr7i1iHTZoZt28VfgnUJIEeqkCtzUwCuefeW/cKLHD3DksHZnhQ+r7AEM+WZ4Gxfs5zu9v/lpo4bevUjhbY7291Bi50/FfzCFrgeJ65V8o6M9/uNmNmGkzl44WKxATpJbTkusQsrgIiHWIUV0QsnyuV2zEE8h8EZligOk4MecrFYMmLWVeRnPoDVA+pXrJbb4IJIHD58UpFADHb5ZyGwCCBTUGlLCgidgb1KllQHB7ee8657ueUsujh2/XZJGkgRTEocDXnHCjYiWnoi9NW8u6r8lVhl5gGmOsjv+D1uYyHSJZfrI6VINapz6y+Ai5z9uqf7QvTrDtwunO4neDYw3f2KW6Kfh5Bcp6uzCN1ChLHZNL99Uu9oUgM5fd+Y1F9bKyRcnSRtfpoqAJgTiFFj0aPA5znsTB8izhKln9HeAmVvaX5pXbmS7cevM0Yfp6q6J331CBUEZN+WwNbpfYTu6aEhs5RC81s9LxBCU3HcZ8JhVZ18QsH/gfwv2vpsYp1ggSW7RDlwSS+zqELLqjYSvmLA/GYyYGicwC9RKuae74g7Ok6QzedycgPUKvELlKZ6i4s50matL2dpxn6Oa5JraX7cyr3MeLXCgk6Fq4zxaB1UXZzTbWIdIRq6BsOuc/CuqxKwXYAa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOekuDu5C4th7sHsQC0LLyZLkfT+8j5dDyLPR6BZWeiE7EUjsYEHjRJgT/x3?=
 =?us-ascii?Q?CNnCpuwtT7+PYZXbIV5vmmng7GVAK97UFrxkvwZTrSzeC8a0NdA1AiOWqZRj?=
 =?us-ascii?Q?NF7IcwCMZGx30NCTHn5cCdJZWu/fyIdARyE9ukwoAwGRl4/AqJicI1YlfTlm?=
 =?us-ascii?Q?1KDe3ZSUNcsM+L/FIDzgSlwZy6SXcU0lTKsxmZEjIp68H+wSv5MP3wXr0gec?=
 =?us-ascii?Q?VoQUPVQ9QGpzzlTlDBsPnI8cue6Z69Hx3BPvTzKs0713+g0/P2g2Sdub2OBm?=
 =?us-ascii?Q?LCvdaqj7jJpzxo/JfvNhcP1lxBWXd2GgHTnqa6wWYSLPeHY1icXP57Q1Vt+x?=
 =?us-ascii?Q?hu04YrXtklvreE4MPZaclJuuEMTUnTUHOQaCAqpxJUyHAXQncbksIcbtvCFr?=
 =?us-ascii?Q?ENiYKo0Vd0fq1QHPjko2zC6qa+rbdBZqzvrOegUe7uBYLg4Aml1QrqYTsuQl?=
 =?us-ascii?Q?UeRqTqHblxMqg3RIMMno+30li3yGzhtEnIV9Je6A1acdKiN3BWJy58aSGUvi?=
 =?us-ascii?Q?49zstFNZPfVpv/s3QibAnUpFJS//oO5X0WuNp9u75RLVW1A4M0utiMlWtW0I?=
 =?us-ascii?Q?LcU/gfPEmXgLZqtFf6OKTM70NeouxKgvbUavWYQ3RqtHuV1vI+unFpuzHQXW?=
 =?us-ascii?Q?Xp9LwwL21CmuOjwvcTO7S9OSIXRRBWoBVhMiOkZjy9ZRfHUy2GQwNTyCrws3?=
 =?us-ascii?Q?C5eVmzKpzikFf67SjNX0HK0ykIE6Kj1KECCu3Zt1LPAKvEk3v4h7HE/v9Ey+?=
 =?us-ascii?Q?wM+3TkvvlSUGxDoYSkf/cGV39KfDX9ZCKoPgPiSoqTJEcd5AOavAR1/apfyI?=
 =?us-ascii?Q?+DKrcScnnDqnrYOnR/EJ9a4Ue/tJZsX8NpbjNNfCNb9EdL7reYjGaKLEmL/N?=
 =?us-ascii?Q?QSy5W+trW/sNP8bQkybOxmYEX6XuRRzx8pN1ELnSnm8X4F07trEfJHZJOWar?=
 =?us-ascii?Q?KLq/+xsCZQxjVQdU7i9LZ9yVd5xcqloJCbTOYiuFOQ5Xdur+SfiJdGPllFVc?=
 =?us-ascii?Q?qobybQhfJ3sXhorxS+ukWF6+BycyVzMiMmQpzJLacoenxwDO97m1J8WynNRA?=
 =?us-ascii?Q?SP6XkpUIaBda3NlMkA4zB5xirmaQZJKY9EGnYOnSvQlHrejkPYUEniQcYFGt?=
 =?us-ascii?Q?DdbDh/LK+KlWzl6KULjDdhEfyATBdAg+UKsPoC8O0MfAdO0HxP8k0To8a7ri?=
 =?us-ascii?Q?Ww6ZaIWKoX8UtHxEmJFL3zAy7N274sI+a3+P2Le6TCccq79jcwizPguhMl+1?=
 =?us-ascii?Q?lurmDhaqPASlFdEKLyBpyHEnoZK9Cn45mN24IGF49H6AUQbNDvB4RSCoNQXT?=
 =?us-ascii?Q?f35IbFCbnZkFVRRLfqsn8E9N/upgHmWzp/8g+1nqzcbqIYI5J+1ldHkS6/J2?=
 =?us-ascii?Q?qNn8hq1ZvVDVqrCZDvviJsaAGYIqEVFUuhKLG/0psQ6IhdBtOx0OMaLHxrbz?=
 =?us-ascii?Q?DD68SeK/jAeUHYS2RerQGWAGjfM+AxWPL0eCB9B1XZnf7LozFtZgLLDXdyPC?=
 =?us-ascii?Q?YphcqiBI8IOWI/vgAe5tmv1mx3pmr6IJdSMT/85Q4Pt5haqvDSC1MVUEnVeG?=
 =?us-ascii?Q?3Rj0OqQyvKZZ7QRVP99MtPctOvNN5wpc1XaNSGxT112Ut2DOaHabdCPv2YnT?=
 =?us-ascii?Q?vUEoi+BedydlfGsKWg3p96qq5wNpeBaXSeqAOxK86HeW8kWgdlA+yyBKnEC6?=
 =?us-ascii?Q?3bOPCxC0v7aOSRcjGiC9N5ZgggKgTnLXFs8dCKmbTCjB2CcINbUC35qrCwvd?=
 =?us-ascii?Q?YXkvavthEsF2zH/6CMbNHqVzav66XE4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b00d9d7-226c-456c-d733-08dee6ef9eda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:16:37.3202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnPkCI+xNg8jx8slBidlM77bLshEeHAooIF62RSMATarTolXN+/RjO80y9L8H16/R62FP2iDXlHVHp2lRxD7neKnAGsWFpJ5q6uQQyDDaBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7031
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBB7APtxAZRnuJLlDb0PKO5s3nTkqhrVIpfDtgktios=;
 b=kqqw/pJwvFgWWZ2QR042l+BusZeXpOwCgAxmmhd00835GjitroKtrxAOf3rQAYpSO01Jo50howYKsor4MoaUdjdnREd51y3Be7KipZSCoX3Y4DXpDYnFvL9u6UFPnrLW8cBDnQlT45hIQOaJUJTcI6aw67Kj3t6m5UvF9LFM56AOZ/xH/XVthPd6LaPu9hwDhSnjK8EgM2FuBnqSC4W4vHVy4agRegs6QlCBbfv5LB1WczQy5p5/xL9sDGXq/vol1yfeZMXyPBgbRxpLC78tWONn9WLgA/fEqsX9BcvBoswxNqJ0EFZRAKAkkGJBbZkT9q+m4pKlSg2nSeTKzvKCzQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=kqqw/pJw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="kqqw/pJw"; 
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

Those functions are required in NAND FIT implementation, so include them in
NAND build.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index a6c4ca39f71..06d3d70c164 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -286,7 +286,8 @@ void spl_board_prepare_for_boot(void)
 	       SYSMGR_A10_ROMCODE_INITSWSTATE);
 }
 
-#if CONFIG_IS_ENABLED(LOAD_FIT) && CONFIG_IS_ENABLED(SPI_LOAD)
+#if CONFIG_IS_ENABLED(LOAD_FIT) && (CONFIG_IS_ENABLED(SPI_LOAD) || \
+	CONFIG_IS_ENABLED(NAND_SUPPORT))
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	uintptr_t hdr_base, addr;
-- 
2.43.7

