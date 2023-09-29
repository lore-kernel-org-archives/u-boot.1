Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE7E728C6
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 16:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3041986EF2;
	Fri, 29 Sep 2023 18:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="f9uZX0dI";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="f9uZX0dI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D878A86F01; Fri, 29 Sep 2023 18:12:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05hn2226.outbound.protection.outlook.com [52.100.175.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F15EA86E4B
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 18:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLUxu5yE+Uj4MCguEpWfy8tk8wmUS1yEmmffC7i03i8=;
 b=f9uZX0dIwrJRmUI/bIa/G1cfJHIaQVQAwMovErpqvxNzDFV/FWdVM3AOBk193E6KNYucGly9IgwguBXw/JAYZcvpVV0POe10MwzosnsBQDHG3HSi2rEETluvP2wvgIqcsVjF5XYmQqyfnjDXpMxebTz1zy2kkoZnBKqjQndi9qlnuqeu3DApVFbY4ls/+bN+CbCGxZ8MUlh/vEQbmE3x+Ud6nC49VCpSSdNeDzva4+0MAmUerlSEQk2GFiZ0ybICZFkxF0iih6oA4Nh2wQpWQMqI8fUh+63JEg815QwiixwkBENW5oDQpxxHLlb5/HHEoBRtF4tQC665sbCkc1aitQ==
Received: from AM9P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::7)
 by DBBPR03MB7132.eurprd03.prod.outlook.com (2603:10a6:10:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 16:12:10 +0000
Received: from VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:21f:cafe::8f) by AM9P195CA0002.outlook.office365.com
 (2603:10a6:20b:21f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 16:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 VI1EUR05FT068.mail.protection.outlook.com (10.233.242.179) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26 via Frontend Transport; Fri, 29 Sep 2023 16:12:10 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 9B2FB200813AA; Fri, 29 Sep 2023 16:12:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.17.169])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id BD80C2008006E; 
 Fri, 29 Sep 2023 16:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ2lWHmSgwkjn34J5MRxbzOm1BWbkNySyO3dcr1mcXqu79hs0zGY+45Z0UkWrqg3fB90N4Fp9MRf07STsYvGz3O4P8id8hFcOGr3DGa19WPbO6FeD6bPJwA3m5o9S0xdjSbYMxX8ahOxJ0ilUpB8VJRBQUuRyRHccdhHLvR0LaDYwnt+fanH9dqfBFuhYTEzay2c7wxKRGaV4QC9fOqN5IwEQp/23bojb99skuYeUOyoH7do1pr47UYTQAjBh21uFLrIkAsF0OWvRUBD8lxJ6DeoWjmcCj0HXg2b5He/8kK1948ixEMNUs0eaBsVVVQEBUDJGiHbDIB+olOVk3y9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLUxu5yE+Uj4MCguEpWfy8tk8wmUS1yEmmffC7i03i8=;
 b=IkPx93HV+HJ1GxaC141n1mK0Qspl3EgYof8yytsZuFFSdpOf0LyXNzBvH95AwQR31zqQQdm2kcrzzmPdYS3/eYTyDS7NEu8szZsPS5WU+KqZG7ol9+js0Hl/3NI4kxTRcWaLNrkIyiSZIsxPb5WIxfjB3iCb4z2rme6tzIXNa2MLK2J4M9AhK3t9C94Nrn5H7xw/afUiyQQ5inFl5bTzj9w+uDbT5ZHLauWKJy5hBRH3Y2HSkpuVYuEdDniWPfA12KI5LAOmzQ6ZeBmg4jNeEdrmasqKdhNRpQm485PNGm0pv7qLxAw2X4Ee+MejaGfa4S+flM73ZpD6Zb1OY52eDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLUxu5yE+Uj4MCguEpWfy8tk8wmUS1yEmmffC7i03i8=;
 b=f9uZX0dIwrJRmUI/bIa/G1cfJHIaQVQAwMovErpqvxNzDFV/FWdVM3AOBk193E6KNYucGly9IgwguBXw/JAYZcvpVV0POe10MwzosnsBQDHG3HSi2rEETluvP2wvgIqcsVjF5XYmQqyfnjDXpMxebTz1zy2kkoZnBKqjQndi9qlnuqeu3DApVFbY4ls/+bN+CbCGxZ8MUlh/vEQbmE3x+Ud6nC49VCpSSdNeDzva4+0MAmUerlSEQk2GFiZ0ybICZFkxF0iih6oA4Nh2wQpWQMqI8fUh+63JEg815QwiixwkBENW5oDQpxxHLlb5/HHEoBRtF4tQC665sbCkc1aitQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB6896.eurprd03.prod.outlook.com (2603:10a6:102:f0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 16:12:05 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.026; Fri, 29 Sep 2023
 16:12:05 +0000
Message-ID: <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
Date: Fri, 29 Sep 2023 12:12:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] test: Fix SPL tests not being run
Content-Language: en-US
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
References: <20230929160654.3475279-1-sean.anderson@seco.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230929160654.3475279-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB6896:EE_|VI1EUR05FT068:EE_|DBBPR03MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb55c21-fa47-4465-d84a-08dbc106d5aa
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: t/LgA1jEhWvH8M1MotluGpGXvt6ovA8kkINGEitI3TAf/7tcbUhX5D7AH8SFg5Kfn+Mw+0Bk2IZWdSWKlDIt19+VwKTTKbi2IRFR19+zXtW1/w2nymQfCeHTgPM12WX4cIDmjVnNDQd9lFaC1rMMm9BYVyQRlCMSw5P4OgjbE3Lf3tZ4ptLGt8mJLQdlZhE40iOpLFaQTw8d5LTFkydj6XtCHbPvLtu/kYoI17eaJ+bHqdxRfEaT6iuY0s7CLz4oNOFxShL5zC5z+JiUVJRT46EeVe472/FOM0gx8N6I9AYp5tXdRJxegF09exWnwWFaN4HwTEAE/gwuSERg1qp/rxLdQaFP4GntcIpWmkIGP2dmwTFM6f3eI2UH7gTLfM2tzgj+t6xi7mAYwLp2rOQS/w41u5U18TMp8oPe6a+vumRBus3BJ9XWsAt6gablR9uEiHPG8q4rHXPdz70Kxv24Oivv/JYK/Qj37FqAlYU/9ioxCOg7CSkY0wyvyuXrLJ1DNJgEMNbFqLZFirh39gkJrx4XeLlEVOLIyu3oZwcua5vkp+TbPTwwIlPSLMLvMFJlZGgleYUxd8ZkGTgrknVWSGYx2seuohE9L+QdTooCIjEQavW8uh7ewRYtNM3hGREj25ytqvh1z6k1XaktQw6kaVXNj0lCMZv+dAH+Ki4jECtALlKrPcnsjWynoWN2sYt4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(44832011)(5660300002)(31686004)(8936002)(4326008)(8676002)(26005)(36756003)(2616005)(41300700001)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(52116002)(6506007)(83380400001)(6486002)(478600001)(6666004)(53546011)(38100700002)(38350700002)(6512007)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0fea7360-fe7a-4652-16af-08dbc106d28c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0FyMlmr2fqGwNuWlyI6e68nFyCL2RpoWq46o8JtmtGEIZJuqNlzknZEE8vVRaScVbBwFd8tfu6P6cs7r51Z/b55lIFlyZ63Fwa0RjJzBXLaf5OD1utQV0x8CQH8UwUgeg/1JH4HDIhEVlYbIP7v/M5kqvhhL1MkuCSlWtJQ0SAbL6LLJ7Y7WqAZlEYGlQuUFoa4QmgLnL13kbyx8IljkQGp3FODw+IxFQK1YO982OKkZ4LzrI9zS9nsQqWYatxjT6rbmOJPNDhSLusuutAsyxgfvfUxRlCSRaZMM/LjmuKXKwF4IA53WTALR/SYhnuE2aFzUHfNHMzzniUwaKas0SckGKeZHBn4t7QSp7/QioVcGxDuvucbRB2+JKmlNj8Ntsl3Bund1U97r5t3rdI4sc+ec2t8oNZT7UTzACLakv5YkMs2Xf8tqOTx0uNBmj4Q9Edkgai5AVXPQt+T0mPIOgDi0BTBkmERDZlNYnzCDVcxUfwPftb0G4VxtfIZPAC/3Sjtqz/6LXQVBlAtMrFfEfBa/+wAMLOGzUeY9FeJPuU/JKE+xROSx39bMZcnGcfX6XJ7sz2BkAuS06tQJ0nj7+rC5HHk7LP5Npux2125m0olziV3JbOYthTQuXDFTJ7T2TBLsrLLkPz1bSneai0lx7m1DZk6BojVaKdRrlBBS6LoUJnOQIhSQ3wamlBhLfj8v8jQnVFnnNjlEH1tIwx/DmxTFXKeXpP/PGYcqk68unEPyBsvdnDsAI1TDGcY8+de+E/CRclhLJel2TS4tJ8hXAwbek1ktTR24pZIBL8YCTLWXZANahUsXUB1FhEl9Pl97aUYLZYgO3vDGJzmBeDB4w==
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(5400799018)(46966006)(40470700004)(36840700001)(6512007)(40460700003)(6666004)(6506007)(6486002)(53546011)(7636003)(86362001)(7596003)(356005)(82740400003)(83380400001)(31696002)(34070700002)(2616005)(47076005)(36860700001)(36756003)(26005)(40480700001)(31686004)(2906002)(41300700001)(316002)(336012)(6916009)(8936002)(70586007)(70206006)(478600001)(54906003)(4326008)(8676002)(5660300002)(44832011)(43740500002)(12100799045);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:12:10.0983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb55c21-fa47-4465-d84a-08dbc106d5aa
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7132
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

On 9/29/23 12:06, Sean Anderson wrote:
> SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
> tree. Don't skip them even if they don't use the devicetree.
> 
> Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  test/test-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/test/test-main.c b/test/test-main.c
> index 778bf0a18a0..edb20bc4b9c 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
>  	 *   (for sandbox we handle this by copying the tree, but not for other
>  	 *    boards)
>  	 */
> -	if ((test->flags & UT_TESTF_SCAN_FDT) &&
> +	if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
> +	     (test->flags & UT_TESTF_SCAN_FDT)) &&
>  	    !(test->flags & UT_TESTF_LIVE_TREE) &&
>  	    (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
>  	     !(test->flags & UT_TESTF_OTHER_FDT)) &&

Upon further review, do we even need 6ec5178c0ef in the first place?
ut_test_run_on_flattree looks like it's trying to do the same thing.

--Sean
