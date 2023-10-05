Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0B6E92FCB
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 22:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A07C86D19;
	Fri,  6 Oct 2023 00:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="cz3DHTPb";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="cz3DHTPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BBA86D21; Fri,  6 Oct 2023 00:24:49 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05hn2203.outbound.protection.outlook.com [52.100.174.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D9F86C2F
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 00:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Fs9JmmCJuBPcrG076WFbLu8qv1Bt5woExlhnDoBU4=;
 b=cz3DHTPbFj7jcTg9oyiEp4platPqG9R27r6K6VT06Rfz4+FCqgiKfLGe8GHmNbtXslGqXVQpQ7r8yvtrF5f55+RXDdjO8RsLWG8gEgsBN7Y79tHoOFOlvsicbjTHqprbifrTGHzxqpRxw2xTsuA5y6zAwnQpL5wpSwCwHdmRPyEcAXdkE2A60KxLQ7UxjUwZLgsINb3JtLaoftcyZJhgj6q48pxiM1+ro3AdbvKRVUhKT5bfL+1ED92FGEXIPGnVMBurD32hoshzPxLBMajnRJhL9OvthQxfmkbj1vyoJVnnBIrRVKMRciRlOnHKlp4OzJ2i7JN2uf3sPYpEn9R/hg==
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by DB4PR03MB10108.eurprd03.prod.outlook.com (2603:10a6:10:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 22:24:44 +0000
Received: from DB8EUR05FT015.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::c6) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 22:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB8EUR05FT015.mail.protection.outlook.com (10.233.238.127) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.30 via Frontend Transport; Thu, 5 Oct 2023 22:24:44 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 CFDCF20086FCA; Thu,  5 Oct 2023 22:24:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.13.53])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 11F3A2008006E; 
 Thu,  5 Oct 2023 22:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOc/ZrLpgutXjpzBdLhGeqUg+CIIosXOgcpia3XgY4xQewivR0/ahvGggj/UtO/hGfkEm41jC6imIDm6EbHpyBNg923O0kSDsqUTSZ0N5Q/lZ04sIT7hQ91sTbdXTeKkYdRf1Q3p5TSPua7hrLZzpJwa8/1IE5nRAaCF29PWxA54q5Fsid6IT+fWdqLymCQM7KVB34/Mzxabe8pTx+fgjnV/ok+yYC96cqfSHTaNxndDYDYijYN3e1WmBwL3N96ietB+FGONc5V9VffSuK0uHahFKVqgGje5NIx6K1izKOjLoz6GVsPVjtIK3OruLwnEMSRnCBPLHBsW0ZydScIYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5Fs9JmmCJuBPcrG076WFbLu8qv1Bt5woExlhnDoBU4=;
 b=fF9thWgbg5M/GGgeGdOc/rJOjM3NF8DfPHfZKrazQ6yk+Z5IHnltdQya8JUPILE8hL7ziD9zbJZWl6UwahOcOoBGhTJ3A1i8BktT/6P2ucfjMvH2qt/peoYJvGtsBYnHgJA8fqozCKmQXwHnxuRAnj8vBozoBHjvdgpppglx36tLdE/y0zpczwpBSmO4UMg6Lvyi2BVSzEkpQYxK7YXeE51frFc9Pz8w/HCN2JvLDINRQZ8Cikuhfz3E8ZhzLAOZ/gYbFxPjfTt++byWHzwzuFy31pPAsCxvC0tlgnOHykG5b9XZcQ/cTjX2DqbzYe9YaPnMalGbFEkHJSukU7nuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Fs9JmmCJuBPcrG076WFbLu8qv1Bt5woExlhnDoBU4=;
 b=cz3DHTPbFj7jcTg9oyiEp4platPqG9R27r6K6VT06Rfz4+FCqgiKfLGe8GHmNbtXslGqXVQpQ7r8yvtrF5f55+RXDdjO8RsLWG8gEgsBN7Y79tHoOFOlvsicbjTHqprbifrTGHzxqpRxw2xTsuA5y6zAwnQpL5wpSwCwHdmRPyEcAXdkE2A60KxLQ7UxjUwZLgsINb3JtLaoftcyZJhgj6q48pxiM1+ro3AdbvKRVUhKT5bfL+1ED92FGEXIPGnVMBurD32hoshzPxLBMajnRJhL9OvthQxfmkbj1vyoJVnnBIrRVKMRciRlOnHKlp4OzJ2i7JN2uf3sPYpEn9R/hg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB8670.eurprd03.prod.outlook.com (2603:10a6:10:3ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 22:24:41 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 22:24:41 +0000
Message-ID: <2cb8bc98-567e-3267-0a2f-fc5e951f98c5@seco.com>
Date: Thu, 5 Oct 2023 18:24:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] test: Fix SPL tests not being run
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20230929160654.3475279-1-sean.anderson@seco.com>
 <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
 <CAPnjgZ1NEGXOjQ9QmW7150d20Ur+V0NXs1VGtF756huwXNMayw@mail.gmail.com>
 <176a961f-8f1c-f926-eab2-5d0a8b2f86ec@seco.com>
 <CAPnjgZ2Bzo1+v+Kb7onxEd7_E=O_nnnU2F+h1X1KAazRUCRniA@mail.gmail.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <CAPnjgZ2Bzo1+v+Kb7onxEd7_E=O_nnnU2F+h1X1KAazRUCRniA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB8670:EE_|DB8EUR05FT015:EE_|DB4PR03MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: e5903e0d-6097-434c-6a33-08dbc5f1e057
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: H7qVfL/88hI1yOSKu/xMROJGyjQB+jy8C7LpjGbQfILTg0d/bGhsgwrfzuVKzxBiL2Ar+LYberA1Jky9zgv3t56eI1OwOaiggCmf9ireflFdk9+MNB+/rG3z4gpmPCyc/8rd+03J2nhjk3JeB+qjD4hMBPMYEgtvGTS3jJXjURehohf/g4EDokX3IVzx4cOqZ7U0lgGWF4KQO4RzMiP0N3oGTcEIS/UuMKeuao7i6EhmHmnDNhDmzu0ak8M2A6xoP3/C1Fiz/Ouo24jpucXmKYS4L7qZmRx5OkkoZDB8CqsnJm2P1RKxF6hr3f5Z1/nK1WU8UvWmpX+9FZxcQOn5WFKm+wFfbRKOfG6unEIsj/p7Hk9oWn6oS4u7WwUujvEWH96OG/Sy8T/I20BLlTQ+yg58Hslm5Eo0e2ihmKJBQUTapGos0bMKf0HusB0+rekfIEjUSzvutP7D7nhr+y+iAQZsoGDkdxSkIBtagKj7etfUeye3uUJ8FKZ/liNf4edXgKvinDJfqzbVKwz4q/zXnxVJJOGWWn6mmvOT/YR7hq2qLeKdUoUWmYquNl0HT8mQauURocmh7ifaxl98jRVGqdcwu9Vkigz4hMHt3hPVBUf+H2y5qGErJ9/AF8PKKeHqXc1T27oQsSUQ/GTK0P4Xs6mE1Kn2Fxud3jogzM9oLnylq8y/gy5AVa34FJ+Qy67d
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38350700002)(38100700002)(36756003)(31696002)(86362001)(44832011)(6666004)(2616005)(6506007)(4326008)(6486002)(478600001)(53546011)(41300700001)(54906003)(31686004)(6512007)(66476007)(316002)(6916009)(8936002)(52116002)(2906002)(8676002)(66556008)(66946007)(83380400001)(26005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8670
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT015.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 944c0de7-7bca-4143-5f2a-08dbc5f1ddfc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9ORjaGwXnOdpKZNDkS6Pedhj6Auz30/hS0qHBsa8dI5vrtREYVVKAIdrvvF4+z861Ft8R62rzMGJ1kUFAKJqy3oMyMRs1O0ZHLoNJ3dGsbiBWnjy8jFs4omb8vTnC8vS9e/V5KVjvazo47HUt0/Lxv5ufGhtQrR7aBUN5wkxLf35oUSt7/3ETMTRn7O/xgkjxfhcCwwIsy+Y0U5GFeIQAYnSEP7Z2sCZHFsRy0QFakJKXJSBG+tRe7i1qtcyoNRQeBkrsgVIMGHZ51SkEfTHSQr634YrcopB0q7qFglibsJ4keQpm6YniaVL7HXxWvzB0dj6CxcSWR94wkIhe5mh8lWoh10K+G0mzE8e3xHQqXS4nxhoS8ytMoTGvVHOxBGJzCNqtoJxg/23+vAYdkcQmyMkvmI04WOTI7rMjBeS+60tJmTs2ViSheaktnwU3CL4tCFE7iPsZQVLsbD2poMajc9Yr5RVbe7c+lu+Z/kpJO7B5FQ1bWIaNF8UfR7K1sqBtraZPjqZY5IbmYD0nai3jhjYI5xgF6F6OISepVdPslZ0OxHd5c+1VL8M/hClWveOC7cIkONtvcs40/8TeEiu9RwNoNHa+msb1gw3kO8fbTz5UAuwtUt960f0cH4pwh63XdY2rZe+1gSk/ejrY62CmlNEM8Z7AwY27Fqhh4SVcfs5oMU5wue51PHEc488ak7zIm/2ul3mphQfP891LvUKtz3/N3/ftd4c0WT0IhgtSKn2umYW3FylW0eZ7o7OYkK3+JuKHwndxuC3ZwYEByEU/jNtG/Ke7Pp06boyA2p+AdSvpvEQF12WMgRG6x77k0z
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(5400799018)(186009)(1800799009)(36840700001)(46966006)(44832011)(31686004)(316002)(8676002)(40480700001)(8936002)(47076005)(41300700001)(36860700001)(70586007)(34070700002)(356005)(7596003)(82740400003)(7636003)(4326008)(31696002)(2906002)(6486002)(86362001)(36756003)(54906003)(83380400001)(70206006)(6506007)(478600001)(336012)(5660300002)(6512007)(6666004)(26005)(6916009)(53546011)(2616005)(43740500002)(12100799045);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 22:24:44.4046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5903e0d-6097-434c-6a33-08dbc5f1e057
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT015.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10108
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

On 10/2/23 14:56, Simon Glass wrote:
> Hi Sean,
> 
> On Mon, 2 Oct 2023 at 08:38, Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> On 10/1/23 15:36, Simon Glass wrote:
>> > Hi Sean,
>> >
>> > On Fri, 29 Sept 2023 at 10:12, Sean Anderson <sean.anderson@seco.com> wrote:
>> >>
>> >> On 9/29/23 12:06, Sean Anderson wrote:
>> >> > SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
>> >> > tree. Don't skip them even if they don't use the devicetree.
>> >> >
>> >> > Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
>> >> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> > ---
>> >> >
>> >> >  test/test-main.c | 3 ++-
>> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/test/test-main.c b/test/test-main.c
>> >> > index 778bf0a18a0..edb20bc4b9c 100644
>> >> > --- a/test/test-main.c
>> >> > +++ b/test/test-main.c
>> >> > @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
>> >> >        *   (for sandbox we handle this by copying the tree, but not for other
>> >> >        *    boards)
>> >> >        */
>> >> > -     if ((test->flags & UT_TESTF_SCAN_FDT) &&
>> >> > +     if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
>> >> > +          (test->flags & UT_TESTF_SCAN_FDT)) &&
>> >> >           !(test->flags & UT_TESTF_LIVE_TREE) &&
>> >> >           (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
>> >> >            !(test->flags & UT_TESTF_OTHER_FDT)) &&
>> >>
>> >> Upon further review, do we even need 6ec5178c0ef in the first place?
>> >> ut_test_run_on_flattree looks like it's trying to do the same thing.
>> >
>> > Well one problem is that many tests are not run at all unless OF_LIVE
>> > is enabled. The code as is is assuming that OF_LIVE is active.
>> >
>> > On boards where OF_LIVE is not active, many tests won't run at all
>> > unless they are marked with UT_TESTF_SCAN_FDT.
>> >
>> > So I think that UT_TESTF_SCAN_FDT line needs to be removed.
>>
>> OK, so to clarify, since 6ec5178c0ef added that UT_TESTF_SCAN_FDT, you would like to
>> revert that commit?
> 
> Yes, I think that will work...but just check that tests without the
> UT_TESTF_SCAN_FDT flag don't then run twice with sandbox. There was
> perhaps something else wrong at the time.

Actually, upon further review, I think that the above patch is correct. A revert would
cause tests with UT_TESTF_DM but without UT_TESTF_SCAN_FDT to run twice.

--Sean
