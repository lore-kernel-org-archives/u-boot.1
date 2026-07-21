Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B3FC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B4EA40838;
	Tue, 21 Jul 2026 07:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScjKnZ_2U-rW; Tue, 21 Jul 2026 07:26:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 501D540827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784618819;
	bh=9wnPPVMnhCKCNQLV9sHK7AxrT4KOLx3QypTRZnigrAs=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Hp/tsrEqn6F3iFTqGSNAPmKpx9d7YBZWcZlIgiD6PhdIbmig/UAbMK5icJR1tLLek
	 o8XiLYz+7ksPc3VGjtM9G/4HZnKFhADSEofKPRBuhrESASjHPtveU3st0DerS4GudB
	 tgkrBWk//qjVbNg/oitweg/7GWJXikv+JRHY9drtxwZpYf0p2/prqOK/X/iuOLGc75
	 D11z3jIxKgzhPd9+zefvrK0+nlMfE1KcUvKAZt3s/jTIunMR7UooSvFWln5QN0rlRl
	 6g/P+TSwAbKZR/8kbzho+ihcARy6cpU02EFkBzgWbYowgYdl1aWOO1eTgdqkATR20O
	 AlAreDAYX7SCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 501D540827;
	Tue, 21 Jul 2026 07:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E27D224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BB94402D0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93vw43igDY9m for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:26:57 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1EFE40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1EFE40042
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1EFE40042
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:26:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905E3848BA; Tue, 21 Jul 2026 09:26:53 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B50803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:26:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1vUP1zoCu61vqFj63eZr+oMSF9P8kOSqvrNzV4IN5FRAX40VLHV3yPkivpw2QOOcCuHEj4/I6l43hlPcj2EVmoXhAbawnMr3AHJ1JuMTwYvQIyQnx+rTpwk3cHOrvq4mrVbOPqX0jK+QTkjqjkhdtj755KEWo4H2xyjcscc+O/hc40+PFWCK29veMfv0QRWB1WBRWpFqrE3JNVeKteCeDDvCstd1Am5eTkm8iAhUHwcquxmkWxzp3UuKU2UMckn41sTBslLw9LVHQwobnEcBhYliFcWJff8rNT8zhfH1+r6zquFHtve4/LIpA3sXar5Kk41tTQkvWwNZmPnZnrrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wnPPVMnhCKCNQLV9sHK7AxrT4KOLx3QypTRZnigrAs=;
 b=NLE0M0w6SIDnpPI1zzB+B9IV4U6CMx99G81H7h4aayYLxvtATPNKmF618HsarQ0h29bBQC5oSzEwoZ1pxccTqcv2JUr6HFxWYkSMsG8eKaJU1XmC5d4BssOLrZCyzW5+EdWWQm0wnJ1o3tS0NaMiui4nVjNzdkF95sZJJfB9Z/6gl2hNED0IpNTm+2GgKn2uO7JK+IShWq79jhx6OQT+hAyoldjvAkKC8lFzrphmCnFkE2MNuBI2UB+TAZ/vDE4HNRMuM0tS+Yx+2yuG2vrK0DfZgPf1Kn+0tPsEhvA4WHmg7AeBvcYTCIuvtIjUo8OETIMa1RA0fcAZN2aWhvMUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5188.namprd03.prod.outlook.com (2603:10b6:a03:223::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:26:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 07:26:47 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Brian Sune <briansune@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Yao Zi <me@ziyao.cc>, Ye Li <ye.li@nxp.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH v2] arm: socfpga: spl_agilex5: Enable MMC secure transaction
 in SPL
Date: Tue, 21 Jul 2026 15:26:36 +0800
Message-Id: <20260721072636.16493-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260311050003.20955-1-dinesh.maniyam@altera.com>
References: <20260311050003.20955-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: a91a93e8-048a-49cc-c8f9-08dee6f96c56
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: z9jXJR9Q4QmaSX1+92v4KXVYmVnwEBLEWwa5oNwQQOTD5P6dXMRNHK3fBEW9+VslgupTukz/nRAbwHZMMZHzDByDvXMrM+HEfQ5jZmIuAkoy22i4k6Ob8W8udByzCp4ifNxKVwK3XL97FbKqnrfNeauPjuFUeBDfSy0yoS5kLHRpgHOh7EqK/n60htmqYaoOUBfF76OEj0wc9ZaFag7gojxFeBLU5oZvwu1YnhSJQ7HW4id5Por3Ay2lcSr70X2LTbGrJQbjt43aWi/uM6+dr3IITkRdl7H0kfllv9cYahIoEt/31UzPxuWMjxGI8HqKUuaWkXSAqJs2UI4McmHUCyxBAtSh4tl+00aTGFIZ8oVbXMEODbZFx9y7/fryZqO+RAx3K4P1laQFLyua/na2Oe33R4ZgYciQS5mxwqnNYw2jGNMjypJllnqYsbZRBdV95ByMqumAtICqR08fFF7mavxw65d3ELmuIGP+LzERue6/rBn4MjdlbQkw8Duzf6m7W7RWvIIAg+gDIZDm/0O6KrtFUk1RzEeB2SrFbFEHsZYQYAh2jpm+dEgxDJd85Y0ihT3CbOu9Ia0kO9Hw0L5Tk5aOAG7sDBZ8hpYspj1qE9mQcQbglWvXuP9qCFYi1tu17TF638p1Hr3icxNwCjjH4uTigIbaDJwRgpXXnU3M8e8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1EIiOsIVNuHgGRYAZAyxN77Y+irtfDLnLnmxXRETFfq6NEai7naV0b/Fv06z?=
 =?us-ascii?Q?a4BVEKH5qGigxrknQUtm3fX8lkLshKZknDR6YdDO//FSsR1uxk04EkRhF7oa?=
 =?us-ascii?Q?2Yc2bSJolS3LbEjClzjv9WOg/s19OhHD5+HAoQYhCT8n52lNTs126tlo/omg?=
 =?us-ascii?Q?DGDGqd8cZqd1+x2szS7aR9LPonw2Nyk+1XT1qB3uEazyaadN6NTb8L6w+ASU?=
 =?us-ascii?Q?3zvrHLPWf5dZdemahJGeqaR0QpNhvZjacM2GxEdoDGSlRU8NdXIgGCxx1nNl?=
 =?us-ascii?Q?vGqN5uDkFz7D8LF1rFl3Nf8R9zXrR6Yq0gIsMGBpPzQ1iiYI4RfB5c9g6kwp?=
 =?us-ascii?Q?vD01PQVjJ/a1BYOygwXft4b5oXnIzbFFD3qOXvZ5QgmNlxLIKug2gwKkWOZk?=
 =?us-ascii?Q?ek4fEdtXYeMr3ouqRkeKYM5SvZEc+fuv2+PCJQb8vqJ8R+pWpx/Mh4LP2kQ/?=
 =?us-ascii?Q?bwbiwoq69YMSzDEjPD0aKHxXCrAZuAywPm0H/KjOY4yZOLh7U89TCAogSKTO?=
 =?us-ascii?Q?s6n3RAkA/LhkxPBDP88aJsdzWiYLmigugpwdPoUBIyevRnNxEsu0R21WKoI/?=
 =?us-ascii?Q?k1CgNBlByMT7nJpJmpHk/+es6seIbLWpVhP65ek2xCFekhKRW9pGjIZu3Ksu?=
 =?us-ascii?Q?0d5A4ttS9GU4ZTCoyiXhleHJ83x/ctBD0pqbA1rTLAuXEVed3O6YTCgNoy1d?=
 =?us-ascii?Q?rIJpozqaTLI+/h2G9v+W0X6sHx/ixTBhpANM1MBxS5dHdipHTNzMTh1WreSU?=
 =?us-ascii?Q?G1alnUKvkoOIeS/iIJang3LcJemdLDfqJkFO8UmNo/Z7GFIvB6B3Z8NLUx+U?=
 =?us-ascii?Q?0tyhJ36V2/jna7d3W4bnitiD9Xag0dsO18bg08b+5LzQgbOXBDuQxBfgPMOP?=
 =?us-ascii?Q?FTjoc6C/soQVXW2xyVjCchS+4lnH1yeRw9ipmSOBeSVCBfJaRCRk7IkQuC83?=
 =?us-ascii?Q?uFaZiNEmY2b+ka0LOTHx06x3kB9DgDnxO/UhdcGRin/lAP5auQ1RHRNUZyqN?=
 =?us-ascii?Q?pWFQSPEo56hPVqZWgmOdYV6peyt1XHAwbd4vYqbh626ej7FrZYCtrTT3fLe6?=
 =?us-ascii?Q?L72BvQB1c/HvSVg2fjCp+uBaunqSc1aVaQuTIzMC0ZQe7gfDo+fJxASpo9Gw?=
 =?us-ascii?Q?eD/BhO9uKxUMdLPpo8RNqXBg51Iks0u/8dS75EWKiE9AcJ2+HZXQx+ou+bl5?=
 =?us-ascii?Q?g98zwYcWdlzmOTprEd04nKFG7DkQMs4mHarI8tH2VOtMIV8H6Sww18iZc18N?=
 =?us-ascii?Q?OoSX0zygjnLmAcuQ6fTbL4SSghQ3MNz2TOKoiWgQ1x87y6qH1dxfnf7EMuk5?=
 =?us-ascii?Q?1roaSLLomhD7aTZ0g8sa96FkiSMEI8NAJ7kWQAZfutrRf85KrMKuhtsv8qQM?=
 =?us-ascii?Q?+G12VxZKe7y6b0rvxo/eW+UhzDXAOPTjEQEgbtldiK1ku9mFBwr0Jsi+89fV?=
 =?us-ascii?Q?/zkmAu86b+Rx9kY+cRuHlrC2t8ywinkpniugdNnhbOUW6lLVmqYRI+kel7DH?=
 =?us-ascii?Q?V6FY3MBDLYyz3ODNXu7bWsfXwJsNll7pT2u80W0UbOwr5zImFiFa2Q5e0Kfm?=
 =?us-ascii?Q?jiW/D9jQvDvtPwE1TWr5EaKXTkQDJsYaEg9MgHt+SeajtNKfgcvKen2tOJyT?=
 =?us-ascii?Q?VO/9s7VR+Do6jflIG730blIqeyLYpOMJYUC4JFuEcZvHojSVMKniwt9ZWmxA?=
 =?us-ascii?Q?9kBpmA2vTmTCCQu/othBhsxHxYHWSacBqemKlAjViZ1ABUtdJWU9qCNbatxL?=
 =?us-ascii?Q?L06iYVr8EDHIkTxMRsycJBVlodd/ALc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91a93e8-048a-49cc-c8f9-08dee6f96c56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:26:47.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZFEa3gx3ew71SpVyooggemz8I19ioPzn/xuwWmhZ6j/JQo2TSEMnaUrDPL3MPdtBNiryrPikw0LFyz9prdnmQiPkoc40VrV3SYCuynlQ/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5188
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wnPPVMnhCKCNQLV9sHK7AxrT4KOLx3QypTRZnigrAs=;
 b=SRS5ZYUVaJ+fPPmIIxcKoR6/RE4t+DM0PHnkKdwo54M8BGMRuZzrF3I2JpHfC5L+xpz2UeEthBdfGvtupSoSRj3EMDtZNHIKQJRX6AcvBE2kXjIWbbYnfLlvii2Otesk23zOds2xwQFShV5kAY7D+i6k7RFAovLmJBXtG5S+FRlAv8cdw69oMvMJRnnJDDx9ot3mdA9YL7w5z5tqEIDA3JylDifD3rJEAkn0ZNs477EXKHUpHUcDbEbNpE1cjkyiakYTt5tpCTzKb4CyF5AbgN2AAfThuNbWgZOcjbEeB50Vcpx3vQ/7+0K6OIozBDZqMnJKt6dFaw3OGkU1rzP+Sw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=SRS5ZYUV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="SRS5ZYUV"; 
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

Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled so an ATF image
loaded from MMC can access the secure DDR region reserved for ATF.

Add the SECURE_TRANS_* register defines to firewall.h for the System
Manager secure-transaction register used by this write.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
Changes in v2:
- Rename subject to arm: socfpga: spl_agilex5: ...
- Capitalize MMC and fix comment grammar
- Remove stray closing brace after writel
- Add SECURE_TRANS_* / NON_SECURE_ACCESS defines to firewall.h and include it

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/patch/20260311050003.20955-1-dinesh.maniyam@altera.com/

 arch/arm/mach-socfpga/include/mach/firewall.h | 9 +++++++++
 arch/arm/mach-socfpga/spl_agilex5.c           | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
index b47b577ae75..ca435869c8f 100644
--- a/arch/arm/mach-socfpga/include/mach/firewall.h
+++ b/arch/arm/mach-socfpga/include/mach/firewall.h
@@ -149,6 +149,15 @@ struct socfpga_firwall_l4_sys {
 	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
 #endif
 
+/* Secure Transaction Register */
+#define SECURE_TRANS_OFFS		0x190
+#define SECURE_TRANS_REG		SOCFPGA_SYSMGR_ADDRESS +\
+					SECURE_TRANS_OFFS
+#define SECURE_TRANS_RESET		0x0
+#define SECURE_TRANS_SET		0x33
+
+#define NON_SECURE_ACCESS		0x0
+
 void firewall_setup(void);
 
 #endif /* _FIREWALL_H_ */
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index 2c3e40b664a..2c58aa5b22e 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -11,6 +11,7 @@
 #include <spl.h>
 #include <asm/arch/base_addr_soc64.h>
 #include <asm/arch/clock_manager.h>
+#include <asm/arch/firewall.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
@@ -107,6 +108,13 @@ void board_init_f(ulong dummy)
 		}
 	}
 
+	/*
+	 * Set secure transaction for MMC, so an ATF image loaded from MMC
+	 * can be loaded to the secure region reserved for ATF in DDR.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_MMC))
+		writel(SECURE_TRANS_SET, SECURE_TRANS_REG);
+
 	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
 		mbox_qspi_open();
 
-- 
2.43.7

