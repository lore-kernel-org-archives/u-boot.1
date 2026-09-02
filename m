Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27383C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B235A80EDE;
	Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DlE1z2pxwLTK; Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339218;
	bh=tCGDZ9ZUla3J0ld4WElqk/wsoLe0jgUgV4hTDU0biI8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xbfH6KI3PLw2TURS/fUpzxiNS/1XDrYj/FO3gpVb93I7IvmxxpJgxCvWw9wf6GI9t
	 gEXMyUJiHkThJYib3obrCA4JOjIHveyLZJATkH+hvk82EUWmye5F4hSMLdX4q1QkXg
	 wddKz8XZejJzQ7nFop/M50jWqrhp/nPHRtvFbpw7/hGvT9L3nriPkvdlQ+Hd9Dy2oz
	 XvpMpx4D2kaJg3hQOO64jqauPtr/88hNC0RAP+xAXZN65V5K26AT274DvdYbn+GKOD
	 jrKFjC+TU963f6Ld1eXiGuzJr+5CFV8jdBivHFHFYOrAc/KOjQwyfGH2hjM5RZsE6e
	 wIaDsyPVJt1Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB43480A7B;
	Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CE122FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5306A4032B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o6da70e6KPea for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=t39jqWib
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 120604031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAVP63X4vJ1pLQCev69uIS7dc3h4ZKGVqI0FTKX8LSzpB8qAbOEcQ6mw5HBcNAEmxWME/JqkE44eIrA3xMEq1R3+EXPeA6YigwSPMBqJbwm8sdoQpZRUP5hhBKkYHBN5fPwAgSw/lhay/+7BARjOgxNM5ICbMxMQOFdiTpz7jgVDGQqCb+/8e/Hadc6D4wt6mre41Q1nbINHNuesoL7HLMB8zbAbvqtuPkkRtoE1gNAyBrDSZ/KFjSmicsA5I70XlKQp4Vpt+j5G9zbt6Y1NqIW09G19B1/uFkSHLBDuhUvarWTSkr+LXiazPYffur6aTvx3Jkj8+CdHgENBuL2mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCGDZ9ZUla3J0ld4WElqk/wsoLe0jgUgV4hTDU0biI8=;
 b=AecBOR37mlLawlkHDxcIUOAtTuY5TNkFbxL16PSH5Imn5hzhAJUdccCCP6tnCyBh62lbfmcJw3GdJNr7ti5GbZoE6DfeTCpWWTw+INpg3N68VEo2AK1mkbDPKxXz3yAiB1+hvMe48djcyFGKcmYXkTcyc9bOtDdYCQXAupOZSZ1lot0WrFe1/QSK8jRCY7jL1erik25eC8v9R9Se8nrojWAk/P9SoGoWyfCkyvTrJiCfpXI3ruZvMOvuFQlLKpU8Isn7e+6CmdsOep04SudcqC8F4VmRDCN0Zml4gPU4ilcBAyk5gNCDuiiNqQwd4tm7lf9axp1VrPUJHwmh9zB+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCGDZ9ZUla3J0ld4WElqk/wsoLe0jgUgV4hTDU0biI8=;
 b=t39jqWibL96Ta9D5zgXPIPqqDtRhKsx9XMaYlsXcBMsMvSUYtkfGix4N9wpeERApGuT3b4ThA6loRauiLdZqmubuXDmwiE/LW/gvzmjUBb45NnTtqSmEttuzTdyA/m9GLU3uF1fwdT1/4s79URIiKkE6rWLGsN2SyPqTiPVd4iaX1MXj+FEya3w5YFSgO9TiM+RoS3EI1cU2GnZb4stzVLvEwh2MtO6Yliv7zvc1R0X/6+yaTHF697aqji4UOtkg3Z58AzCQI61mQ/srJl0YYlb1a5q+cE38aSnXbYdEY0aPezzYfJGx1qq8T/D1RsHeV9EEN9MYj/KwSSY5qjNR4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:21 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 00/16] arm: airoha: add AN7583 SoC support
Date: Wed,  2 Sep 2026 11:52:55 +0300
Message-ID: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 040a1fe5-a220-4c26-6eca-08df08cfa3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 0tLX9ispD2W24SE3H8eFr2t5sG/eCrdZ3uNIS1fu0ewzy607DNSacN87DZV95/lGK8W4B73zrDFFFUtgXvixfqmY4aiCul7vOtHush7isqy8DDDzVhl4iq2A9TYUaOMqHg9cfvq2NK4QBYiIVOMlA5OGhCCyDV3spIifbxMoY656DUD97J7oQ8UzUoQSQSY+K7BLhI7UG5zUAZKlgCnQYNeSai+fLp++OAlyXLW9j1YwR4MX+nUlFMN+mq//eScsxuBfsOCCtE9Zf4wvjqdi4n28C9/j3hcSWD1uNFdbxzeuV8yhFkB6dw7xo0CcKdj0bhZlaDdtPnkxCCryV1e4nvORr0GQrSE5fyfTKdtX58LTD4pKnz1aRgMv3TvN4QyUUim0IKQHG+KhbUs69800XQLm+wWCeHNUbrlstcC+MdBDAw8eI4+//fo3L1hXALXBvvdjc6jyt9PocuR9IU34Vrnq+O6AIoTzPMlmr5mXWy1+mPIaloIaNX+UQR+EV4YNjgW98NNrwEP3BDt4HWOUZbrBdIvyN8OncDPiaMYLn/9/6OvbTjgQzvt9is/EybyXz95HHXDREVmR3wXviNMlgTyxQBeTdcc/57BxqKNyp8avgehkH9hQpvsgpuvyk88+c67g3pR8B82dH9NVp1FI7cqphk0tMTCXY7s+qB9VVvN3losEJ+OWsPGaj6DSWtKgufjzn+FiThjOTVgu5hsWc/I7611RZ3toU/CswnvAlJjsT7cc0FNNnbXtWjdedRsV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0B2JYDwQVfkZf9HrXJRI6k2aoluoSNStJh/9Td95FWgg8c0oprbobeD4M2C?=
 =?us-ascii?Q?1yYQRMCGXS8w4jlsFCgmyR6CvyzZjI62mJosajEj2BmT/qy2ACWZbXOYLZZT?=
 =?us-ascii?Q?Ai2ORXu6JmRT+hZnrj8/RdRTVpcGLMz9mL09bjsy7cUjsgwDoVVaAHX/zSEz?=
 =?us-ascii?Q?cUykrivue1yzwDoTEZNOX40Koe4u2PemQIPUv77EcwrDW4Az8uP7+F15MdQj?=
 =?us-ascii?Q?jH+obqYS6vFbRdTfmXUEZ9gXqzz+Kn0GME0x29pKYcH57/dsqfBfnvVVi3x/?=
 =?us-ascii?Q?lgY/JMwyAwyKpt7k0CpIA6KVbA2AoQxAgjtyurxnsoBX0aOz4EpIsonxVUe1?=
 =?us-ascii?Q?LUIwcLe8qo3t74XisAKg1rKlqCVxwgV4Fn0bIVKRYXbcAcAs0GNm6FvPfMSm?=
 =?us-ascii?Q?uKUWtp7n2WjZkJcxUIT4utZ4W7oeYvhi22XV2ycsPEBOZVsHmQq6HOdfRJvX?=
 =?us-ascii?Q?pYrmAS9stafDh3Gs5dPGUYwIYqUJ0rRfGPPU36hu87meH/Z4CXAdcPUsdYdG?=
 =?us-ascii?Q?6ZHQ83xJcKBIsGC/Q6nmB9YGhGilGpcLZ5M+8VucKKLMdZMYE1W1/go0xFaP?=
 =?us-ascii?Q?1+kJYMRtayaPpnlVDt1BnugetuEo1cJg1b+P6/Rya2bNZqPw9dZhhz1zniIm?=
 =?us-ascii?Q?vFyRgzp8MMGcRuR+ckrCm890EFukkeg/pwcZ61Jx+blWJgf7J+j0iJV8xELC?=
 =?us-ascii?Q?14w11VJbWVYBFRTd9HbWc1E3xxmfROfTbHahhfWIGMzTpDbI1Qzzdpfbssph?=
 =?us-ascii?Q?z+Z/jTmr/uXZiv6F5ZEdkV2n0Bm/MAxlniRGdrZCalaR5aTGKXQ/0omBeBwL?=
 =?us-ascii?Q?WtYdss7D6/sOU7o9VBxW7gKecwYwZeTbvQo7XwgKBYvSAdEepRraorpK/CgO?=
 =?us-ascii?Q?aiNzKbM8C8IAA4NOtoyNs9BP4HmgK/x9pZTgVr/t9P3Rkj3FSv1AWtTEjDT8?=
 =?us-ascii?Q?N/CMqcjCguQw3J+LV5n1UA1FBotvvw/Ygcw1aDEZ607UOzog3TGeXp64svfE?=
 =?us-ascii?Q?EFPWnG0eKSkV+4+PQMxjYEA4U01+GjPI7Gn/R9XDcAhj25JkPzBw37ecEXu+?=
 =?us-ascii?Q?7nHPQkt+3OcOkiA/1zSkJKTj1fNjpFbyzEL19hHe/1bPsBo9s0nhX6qnKb0s?=
 =?us-ascii?Q?dxMY55ER0WoOPOPbr1khY+0SXQG3tFQrzr3YhyaX/ICYERE1PzA5Xoi28SS4?=
 =?us-ascii?Q?Ri+pFrPmoruNCaficx8ui/tDmvBRu6BBanUPi1UO+0sg4BCjKl34hBd7zexZ?=
 =?us-ascii?Q?EOb2BulKCQTfup+jcPTvMwfwTHuA5m0oMpjpSFtsN1H/2HUuRfs22mvNGn9X?=
 =?us-ascii?Q?RXeC/oKip/+xZCCW6qhsnsWlLwUOPYIRWHs89mdW+Hlgu+o2RQ2LcIZmNWoz?=
 =?us-ascii?Q?fSCjH1dSCdHoSJExbqRW9VVukNIFYa6WWCOGiMs9gLXyCw6ZDbP3yQTyayA6?=
 =?us-ascii?Q?u3pZBZZ/92aR/+wBG2CpQl0yI0xAfKKoGJWuJJ1VCo1E4fGC5qFliQmvn7aI?=
 =?us-ascii?Q?4PcFtqxysKgdNCBfqHcS7DVGLbsBofWZL35OnVVRg3PSF1YEQaBZShzoeZrX?=
 =?us-ascii?Q?iaSd30WTwV+NvKvbgWWflXMe5tkD6UgPEpP/y2jao5iRNqhP+NTnx03po0q2?=
 =?us-ascii?Q?ZfOh1TsRJRqMlxVTtPoF9G/UZ8E7k60Tjved9gBn3gFPyHHKuiJ890/dM54K?=
 =?us-ascii?Q?/3maOzjdSsSEkdzPKGPDdOaNNlrXt5Cgv6HRRkp7E8CwGCnVBsIEtJc3Stip?=
 =?us-ascii?Q?7eSMV/lW5cVYJLuOBr07JrrKxfjiVZs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 040a1fe5-a220-4c26-6eca-08df08cfa3f5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:21.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHuXzaTFYmx/R95li5uu0BYRZ2MuRJdAyzDHL9EMu4LnL5xBt/8yhZpS5j1nKz4UQzSphNoaBEdWx/Dp3h0Nr408EkUTpIuw3GSeg5HcjJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This patch series adds AN7583 SoC support. It is based on u-boot patches
of Christian Marangi airoha openwrt branch

  https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/

AN7583 is not included to upstream linux, but actively supported by
upstream openwrt. The patches were adapted for latest U-Boot.

Tom Rini, could you use this patch series instead of

  https://lore.kernel.org/u-boot/20260821070345.138264-1-ansuelsmth@gmail.com/

It have the same commit as a base, but provides much more complete an7583
support. Changes from above patch:
 * fixed arch/arm/mach-airoha/an7583/init.c compilation issue
 * added an7583 specific helper needed for clk-airoha
 * patches for proper support of clk, reset, network


Christian Marangi (12):
  airoha: add support for Airoha AN7583 SoC
  dt-bindings: clock: airoha: Document support for AN7583 clock
  clk: airoha: add support for Airoha AN7583 SoC clock
  reset: airoha: Add support for Airoha AN7583 reset
  net: airoha: add support for Airoha AN7583
  airoha: add Ethernet node in AN7583 dtsi
  airoha: add MMC node for Airoha AN7583
  net: airoha: add support for Airoha AN7583 PCS driver
  airoha: add PCS node for AN7583
  configs: enable PCS for Airoha AN7583
  net: Add support for Airoha AN7583 MDIO Controller
  an7583: enable MDIO_AIROHA by default

Mikhail Kshevetskiy (4):
  arm: airoha: introduce AN7583 helpers to get SCU and CHIP_SCU regmaps
  configs: an7583: add mii/mdio support
  arm: dts: an7583: add mdio child node to switch node
  an7583: fix system controller mdio nodes

 arch/arm/dts/an7583-evb.dts                   |   85 +
 arch/arm/dts/an7583.dtsi                      |  522 ++++
 arch/arm/include/asm/arch-an7583              |    1 +
 arch/arm/mach-airoha/Kconfig                  |   14 +
 arch/arm/mach-airoha/Makefile                 |    1 +
 arch/arm/mach-airoha/an7583/Makefile          |    4 +
 arch/arm/mach-airoha/an7583/init.c            |   66 +
 arch/arm/mach-airoha/an7583/scu-regmap.c      |   34 +
 board/airoha/an7583/MAINTAINERS               |    5 +
 board/airoha/an7583/Makefile                  |    3 +
 board/airoha/an7583/an7583_rfb.c              |   16 +
 configs/an7583_evb_defconfig                  |   83 +
 drivers/clk/airoha/clk-airoha.c               |  158 ++
 drivers/net/Kconfig                           |    7 +
 drivers/net/Makefile                          |    1 +
 drivers/net/airoha/Kconfig                    |    8 +
 drivers/net/airoha/Makefile                   |    1 +
 drivers/net/airoha/pcs-airoha-common.c        |   27 +
 drivers/net/airoha/pcs-airoha.h               |   17 +
 drivers/net/airoha/pcs-an7583.c               | 2202 +++++++++++++++++
 drivers/net/airoha_eth.c                      |   94 +
 drivers/net/mdio-airoha.c                     |  221 ++
 drivers/reset/reset-airoha.c                  |   60 +
 .../include/dt-bindings/clock/en7523-clk.h    |    3 +
 include/configs/an7583.h                      |   19 +
 .../dt-bindings/reset/airoha,an7583-reset.h   |   62 +
 26 files changed, 3714 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 drivers/net/airoha/pcs-an7583.c
 create mode 100644 drivers/net/mdio-airoha.c
 create mode 100644 include/configs/an7583.h
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

-- 
2.53.0

