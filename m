Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5AACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BDD86BD7;
	Mon, 16 Oct 2023 10:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="CiDypCTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5B8865D0; Mon, 16 Oct 2023 10:36:17 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105DF86BB4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpFtLNwZAKEwWO+2WjeaNiqkFgAQhSG+LozbR6GCpGW2oxumVgIN0WiQFlSkqI4GWWMDCky1kkutMWPXSF5jC/4ppY9L2RDggTf7uwDYki9LeucV1T2qVySdQp6h49Ia4g5jD6iC+dj4N6kTIc2pCMVexjGfe6nDecTpbqyLD+15/1xTHnzVLJtYl38D9zCLj7sIQAU62UFAuy9w1Dn7pjtp0M7iJOgi9W/EOuNb/n0k497ElpjkZuUCSmkxNmfRIqqLv1JEoxE084KR9gqS3B0iLzR3fVl99MyYYhBotx7/Ig4jqjgJIEB0NGfOcaUqe9fffFoP2Y42urBedjwgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hjpWYajODOYxK9N++qSmP0mtpPKMfkHbGtuRUS7oSE=;
 b=E1iuNEIUrIrhrovXbAulMflDWhHEvcqocrgCSiTddQLpqjXj6MDbw0/MUWXCIp97TugUFXV557krUTahUVbUvuuB7PCHjnM7ScrK2wASxOxSCe5ss1ePgOoZTb1OagS2ZTo3WVtF6UCkrhYUzyg1/RNvPHiVpjPVivP5hdFJdRQ76setorqFn3smFoggXWEoJd2jNDwRm4W+TabBrwHbyPIV3tJ2l9z7cTHkf942UM5MTvWCYuGAc9qEE9lIOscWCBm5LzsUrD/CShUmpnMHYIItVfTKLFPapAZH1sMCCAhTlaegbAOLOdu+sp0gJDKzZ+vNBBoAnAaScoo0DDm+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hjpWYajODOYxK9N++qSmP0mtpPKMfkHbGtuRUS7oSE=;
 b=CiDypCTFUq4RsrqLf2jT2s0C+VWjMUGbzIyT3sq0RAkp6W2QIwhJNtd+IwirfwoWfmIxh/QmZPzC6pH4DzgihpmNAsjxJ2ExlRkhn7b8438ILFWGitg6ZjWHNhffgmdxajWPjxK1M7tjs8NlzhSbSGkiXDXSh63mBhA5qVzdbp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:36:05 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:36:04 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Date: Mon, 16 Oct 2023 10:35:20 +0200
Message-Id: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3236:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ed3d19-74bb-4f09-83e5-08dbce22ef4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZ6zdjv1KdxksE2lop1DqadKOY3h4TmfBHS55kd2iNhHzf24k0w+Bf7mVUwmQdL8MN9gmnJodVdM3vesUVW/vQsJP8qluEZtG346bsLC6hxISOmk/uE0YVu/556S+r9WYyMl4QZTIov1VRTHCxCJcVw7DaxRCVAN9mhMXSnmi2diYfGGvzEKinSpKA3z0LOlWzFRfnJ3rBkZjKZYhxSewBhpGEzC5qL3tryUGMMN2r7NCoV0SBrAKLUpFVqGQ9yKjnVrKupdZTSR1QPvKwpLHLPvIST/zXEH3jlC7/gP+VUVy2Ggb59Q6DxS2cnEQ1bMoKr6p4CoZ5+ttPn9Pi41pjP+cqply9tDGfB31buluIthSgI+qBDP/1Rb6p6sS52pUsQ8TlEYjKc3X6ih0joQJO8hcwpR7NgfWEafVk1zK+GOvL+XQ/vvHH3k3APM2DToXTwRp1iSnCiNvk5RwVDKiLnPo4mlkMjpKflPTnHwlR4KxkgsSHHm0BdeR7hSbv8gMK7oVe1yAAE/pDfmMBmn9Q0ZSsGXnUWVnnBMcUAtj+0/tsBmQwgmgH3MvCXYm5gp61rqrQiWTNaJsWKnRD+dAP+/CVXAT1UPDwNuo6bdQWqBdTKnhre68EwNKUMywPyT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39850400004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700005)(36756003)(6486002)(2906002)(478600001)(6666004)(41300700001)(44832011)(5660300002)(6506007)(52116002)(38100700002)(107886003)(2616005)(1076003)(26005)(66946007)(66556008)(66476007)(54906003)(8976002)(6916009)(316002)(8936002)(8676002)(4326008)(83380400001)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24TIPgmx9Ujv0c9ijuWO3eJFtjLN3h47T3Li0uzEVcHwnkImZnd47B2zrruP?=
 =?us-ascii?Q?rehxP9S1MguU8pZz2kl94tAUepBRw0FAQaDhZ70KhillLZQRH3B9YdfYIE1y?=
 =?us-ascii?Q?+EGObNA0lp4mMQN5ZbxShnDHEB7fe6a/7laVRnNqEo3Xjnlhnw5nkW//yO+a?=
 =?us-ascii?Q?h7DeWqah2Fi8mAF3u/WTfZVcywTN5CY4LZVAhjdsUiJWkcsOTrxJ2bZGcYt4?=
 =?us-ascii?Q?D19b56hFPiiM/Z2WQyhksGiDNmooA+ZmvwVO7MkUe6Fznog/IgGPG8EmdR5+?=
 =?us-ascii?Q?xyyVFZ4AxxyAelflXPru6mrWNtPAREM4Lvrh2lCuLEf53Z+gkOQRLY3P9nHf?=
 =?us-ascii?Q?2s0S6YDndjKIU5FWyf7/fckLbvlUohEOeeGnNOuLt6zcCEEU70p1ZfpqicBB?=
 =?us-ascii?Q?SG+IQZF+es6RPLoVZhQ9eGHFtLCmFUHHsNUDKZRNTlgFeie7aaFlgL8/z4UR?=
 =?us-ascii?Q?kwlO1DA3yshtLR1uL7uwUOBonOmot+FWnLjNv0xpdgACdNK+AQKgEKnJwDrL?=
 =?us-ascii?Q?Zrbrh1J8GLM+RscVAUR3N8UuqyzCWoLGI5K20LuLViFzafPAP2fIWDybOW9L?=
 =?us-ascii?Q?v92MJqDe8U1k5jyQfBZLcovTzE7fn90DlGXg8RpJN6c5OC3ciMLD72YtdKrQ?=
 =?us-ascii?Q?J0TWyR2xbG49/pwHPUVmgawGyhOABVMXy8T6sKZY32BN8PKozD9K2LRN11uZ?=
 =?us-ascii?Q?LVr6OhWO+j7qxnzjfFiE/V0DpkOpTLhKRdzMUSOkjJLNR7C+kQ3OPzuooR7J?=
 =?us-ascii?Q?BAmfgpT8TYi3798r0kpfzzB/UsTeqMcu1UoRiQkzZNdocqPT9cADttSaTEzt?=
 =?us-ascii?Q?My+STvfUx3CnGub4fS1HCgGXQFlT/yV2eT74gcs7DbTEAVE7GjvFerzd0Vxz?=
 =?us-ascii?Q?/V/cojTPY0sTcv2e08MRYNQfyuHUxm8gS20iOIS68ymolQc0OxZU+8KaH0Rb?=
 =?us-ascii?Q?NWZ9AKvQSy3y4xX6eJ5IWv1sVZHAclKSQS6DSSqlCTYO/YG9OK8ez/HnlWnd?=
 =?us-ascii?Q?zELYxZ99dLv6ZqywRxW0626u5T3BxAo5/vpcV/aTjh9gfzdYVF/lDd3W4bu1?=
 =?us-ascii?Q?4Qjn19knChfYubfsqif4K0cLoiAYxGJSxW+vvFBQsjRJ3QXGf9LhzEaDR6ik?=
 =?us-ascii?Q?8P7wkRnlWWQ1zf/qkZN8/Hi9Z4dus45iXLVNKlKYHPi+Ow3H7pFYhXninh3U?=
 =?us-ascii?Q?WK3PrAk6dIvsyTLl8xIJ6Se3eGiqszaAd/sQo05LS7ElDpWFGiFpc6Uljk7K?=
 =?us-ascii?Q?8V1evfOu5SFRyLsKMbaqssEJiyQ1tivvFD0Ez4KJmlKW9Aur65lopyquLHZi?=
 =?us-ascii?Q?eoP/OJo68Oe4Z81NSqkerCZet2+pLanZHgtZFkqSmX1ALB5ofDWmjwl/UrUh?=
 =?us-ascii?Q?p622CMP7RCp4fgSWsgTCycODaQ5Sh+gRSW6osHnLyk6AscTfJfhU7UfH5VVG?=
 =?us-ascii?Q?ztinF462pxu99RVsmJiKzdIHjU4QnoPbXdP9SExi6mSvMtTb9c+0fegFr2Fm?=
 =?us-ascii?Q?nxJNh5f4FE+OOPXLYw/WyCjjtZyWzRww4YDBOLX/RsT5p/K7Nz2IPYMT6Jjs?=
 =?us-ascii?Q?9Fq6hehQr2m3TvdQMJNMKAYrBwtz+0GJeeZVSNG+HqwVy1+r/EPLvoR7eB2j?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ed3d19-74bb-4f09-83e5-08dbce22ef4a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 08:36:04.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZuTkKLc+WjnGfZsaoC2NRRw3PLYmD/icnVn0uzlxkYf2CxUBYUDOyasWGHyd2+DwgOrV0E5Krz8G4LXhKLgJoxx/gFNQ2Bw+0FtI4H+n+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3236
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

v2:
- fix implementation (lacked CONFIG_ inside IS_ENABLED...).

- drop dependency on CONSOLE_FLUSH_SUPPORT - that governs whether
  functions for explicit flushing should be built, and is not actually
  a requirement for allowing this implicit flushing, so the features
  should be selectable independently.

- add Simon's R-b to 1/2

1/2 is trivial prep. Motivation from 2/2:

When debugging, one sometimes only gets partial output lines or
nothing at all from the last printf, because the uart has a largish
buffer, and the code after the printf() may cause the CPU to hang
before the uart IP has time to actually emit all the characters. That
can be very confusing, because one doesn't then know exactly where the
hang happens.

Rasmus Villemoes (2):
  serial: serial-uclass.c: move definition of _serial_flush up a bit
  serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE

 common/Kconfig                 | 10 ++++++++++
 drivers/serial/serial-uclass.c | 28 ++++++++++++++++------------
 2 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.40.1.1.g1c60b9335d

