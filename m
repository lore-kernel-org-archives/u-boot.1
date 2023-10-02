Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BF6E784B8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0044586DC3;
	Mon,  2 Oct 2023 16:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="xgX4PnYq";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="xgX4PnYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3520B8710F; Mon,  2 Oct 2023 16:38:52 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03hn2210.outbound.protection.outlook.com [52.100.13.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5CF86D91
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eia2loeIFpj8qKy/nOXrOdGcMsCie3+n0a5Lfx54F0=;
 b=xgX4PnYqQH4AjjBx6RQrE3auutVNgH8ib+gu94ByOS2jagQcty2N9iXpiszaUJAI2FU7wWu8DrJlw/S50zp2UN6VeRAy0gKWOvK+LXCzDy6/G3iH7gEQMDx2+sAT9sSQocBz8Et7nKRDMuzxAfHv1Q8otAh0BlMPZH5QuoWCl/li2bn3thYBb/h/7l9bALXc7RrXLdfof8Vz/6M1M3T5ZW1QNGMFWnbMmq6t20ijJ8itZ+tRu0cSPWELt7HWMfwK9VsVE2XFgtehc6rbT9oSwINBzlp0aMRsQD7goh3UWdVe8/BZuHUyVYerB+XMlkeANkfIu8Eh7ePqrCc1N0auuw==
Received: from DB9PR06CA0005.eurprd06.prod.outlook.com (2603:10a6:10:1db::10)
 by AM7PR03MB6564.eurprd03.prod.outlook.com (2603:10a6:20b:1c1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 14:38:47 +0000
Received: from DB8EUR05FT043.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::60) by DB9PR06CA0005.outlook.office365.com
 (2603:10a6:10:1db::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 14:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DB8EUR05FT043.mail.protection.outlook.com (10.233.239.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.20 via Frontend Transport; Mon, 2 Oct 2023 14:38:47 +0000
Received: from outmta (unknown [192.168.82.135])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1001120086FCC; Mon,  2 Oct 2023 14:38:47 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.11.47])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A0E672008006E; 
 Mon,  2 Oct 2023 14:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiSPMw1kFvmYhXaGdzfq/3ZWchjKcX9VHhe5o9f4K7rxBcWLqFENW6scW7ttscogpOJMDuK8YZZ/wF75o06LSSIniLu5WjbxsiCLQyDGclN61krZDCGbJu6pqYGC6WjE5TbVKhtIU7xyPNUvmIevvkJ5BNVMtaeFlMAD8yPxWBiQrHPhjds+vfzzgxNyGBfTa5W1UX3FtXzm0c7fLbfH5744ojoHpXrWNBZ+OCyDsZDPmEyMfq3XX3B2S3krccT/YrnIq4kJZi8RYLZtsVxo2lnLDMJOYwK0Atww1DKrrIMWioclxGU2Dl+vrAlKEVSGzASxcQmbcmdOmhDablBK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eia2loeIFpj8qKy/nOXrOdGcMsCie3+n0a5Lfx54F0=;
 b=Hwzs5Xow61G07s4VzGJUBqZlE5uiXlef4QTQ2VZe6Y122jPesEFExHGEMFfkjiZMVyvxWl5BsjYZWbLnUQb0on8WE1eNAfUD4kc0cT0j03v6/tIWksVYk+DPKKoJk0bnD3q0Xsi/QhvTDaXyGsBuEFAOXFaF+h/3D6sixVM1J+XNs7fDt90JWuMCleKJmh5FplD78CSxeyXsxkNVDZ6a8sti21w2nEoM4Jnto3AbGHI4C/BfDDEeh3srvtyZWbg0VKI4feEla0FD94Kvttg/PoEcS3o+CrtTtZK4oD76fbCSRLBFg1YRUZ2g+3Yzp3B7E24hJ9fQqhue6wE2T5wTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eia2loeIFpj8qKy/nOXrOdGcMsCie3+n0a5Lfx54F0=;
 b=xgX4PnYqQH4AjjBx6RQrE3auutVNgH8ib+gu94ByOS2jagQcty2N9iXpiszaUJAI2FU7wWu8DrJlw/S50zp2UN6VeRAy0gKWOvK+LXCzDy6/G3iH7gEQMDx2+sAT9sSQocBz8Et7nKRDMuzxAfHv1Q8otAh0BlMPZH5QuoWCl/li2bn3thYBb/h/7l9bALXc7RrXLdfof8Vz/6M1M3T5ZW1QNGMFWnbMmq6t20ijJ8itZ+tRu0cSPWELt7HWMfwK9VsVE2XFgtehc6rbT9oSwINBzlp0aMRsQD7goh3UWdVe8/BZuHUyVYerB+XMlkeANkfIu8Eh7ePqrCc1N0auuw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB8842.eurprd03.prod.outlook.com (2603:10a6:20b:555::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 14:38:35 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.026; Mon, 2 Oct 2023
 14:38:35 +0000
Message-ID: <176a961f-8f1c-f926-eab2-5d0a8b2f86ec@seco.com>
Date: Mon, 2 Oct 2023 10:38:27 -0400
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
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <CAPnjgZ1NEGXOjQ9QmW7150d20Ur+V0NXs1VGtF756huwXNMayw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS2PR03MB8842:EE_|DB8EUR05FT043:EE_|AM7PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d0e8cf-123f-4d4c-a28b-08dbc355495e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vznXG9Jb/8gIdpyES0h5UGv74LGHvskaqzIXAkRmcE25bJ14c+MGMBIdDU/utY/nqmhDvoErPFESuieHuygJ3r/zJ/N6khLciWYSdg8uoWWFLyy7gAHYsh9KuU2w3p43tHCEBF6C3cR1IAO+IL1rmfkVIoHh/z1s5ePh/YhqKLOK27l7VBbT5Je2mHFiazlXoZsPh9MgoIp5+yCpGzffS+mw0HIIcGrEuL1mGjUYzfiIrrhy02xuIjxbZ92t9dFQgKeCbcLqyb4p1XYU5IRVIFPtClBsi8g802xJBt2mCBJwxrzPt540EzOQ2oRkxmB2kNQGyTr619AuAwp+2WP5UpDkt3WLT6Y6nnkTHXTsuSGPx95y6KDzAl77yq9SdLnLMMBqsbkRTwqc921MrPsSQ+p5NJ5BXjcMJfzmfrOf7Hb8vdFrixdtWZ4IxT04aRr7TJvlMJYwaystY9NFsiRB/ONkMCbE3koKfiYOkmawORZhZ14BN6ISJocQx1ekzHhSo/seKsphmTSyGw4BNeopXZtCK+Kbj1kcMjw08j1Kv+oktbwE5UdlLlneDaAZBAgfaFaEaA32iLSxXQRut//jHU8+z/wa59yzUWpSsBs2aqliNwohz9fk4a/fiZ1Y6JieTbG2Htm0v4bL/3tNkNfsXVnaKyftqbxrwH9uG4kkU8bgmJJvLSfX6Z+4x44jCgMp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(44832011)(478600001)(31686004)(6916009)(5660300002)(8936002)(8676002)(4326008)(6486002)(6666004)(66946007)(41300700001)(66556008)(66476007)(316002)(54906003)(6506007)(52116002)(53546011)(2906002)(6512007)(2616005)(36756003)(38350700002)(86362001)(38100700002)(26005)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB8842
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT043.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 16cc1018-4aea-41f2-390b-08dbc355425f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMYvQMwrgzhuWmH0iD8hDsQ1xpeofc10iZLhAiay0qeEBMB/FAbFLKFeVJBb9aVGLow23ShcK6FTkbQBNUdH//+A+k4B2+n6aAvNOpYqidARizrK1SFWisnJvvkn5iEOu2PtE6mkP6t5zkvgr6kDJCii6Aj/sEkDb2kaR1lEMoyOyTsHBXDwfXQ2y0jfHLCnl2miosCcaNLAX1/LY3XKbzu9b0bNmc+Ea4zK+nBvtZLamDvAcuqmfx4IhmQ33veFF52dkrZptBHoaPKR78JrWpqvsegI+Lc07GNwOpEN9Gq3XN32ExXiOO8pWke4fAHVnK+ZuAxtJlezZB7IC8QwmAU/vOMQHGFS+X0N8foiGWl0o3sW1+MoBrCqKicB4QYL3GnOd5MR1idOC8/UaCCGm7XcfqT/S4eEIBNAjuBoWQnDtnzeV6BhYsAVFCImySKHt4LR0v8sRt603mY7o5aRof5H+AICXS4fciY2cKE5WSck3408dA3QRIrZ28YUodFkaejlo7ogLxB5rjEs2a7KxrPszDLlwkkbuNX6PPJ+Mjw0IS76ZyqOrkEgt9oK7uj3k+5cmYHLeAPDUpvU6cZT+jec3BjZI/YMmtZVTNEaBoN+w1v4Zn0uU1eyUBAmaW7z2IBCn1+FrFofGSqU/BC18VyopIBqNdlQnHMt03RRKoA0ygI2fQcUfsEJhfSuLtFzaK0gtoVIr5UOczVwc1zdTDDMSuNzukh+8Lp6rsDzhVfmCmGTl7LIm0Jsn4q+NyjO11cizogFEoF8ekFT06vpJTivn4+PmK9A0EGdTjjY0WBKVGkk0JZbqS2Zq/3I8S5y
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39850400004)(376002)(230922051799003)(451199024)(5400799018)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(70586007)(70206006)(2906002)(4326008)(8676002)(8936002)(6916009)(5660300002)(44832011)(316002)(54906003)(41300700001)(6486002)(6512007)(478600001)(6666004)(31686004)(53546011)(6506007)(26005)(336012)(2616005)(36860700001)(47076005)(83380400001)(82740400003)(356005)(7596003)(7636003)(34070700002)(40480700001)(86362001)(31696002)(36756003)(43740500002)(12100799045);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:38:47.2851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d0e8cf-123f-4d4c-a28b-08dbc355495e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT043.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6564
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

On 10/1/23 15:36, Simon Glass wrote:
> Hi Sean,
> 
> On Fri, 29 Sept 2023 at 10:12, Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> On 9/29/23 12:06, Sean Anderson wrote:
>> > SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
>> > tree. Don't skip them even if they don't use the devicetree.
>> >
>> > Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
>> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> > ---
>> >
>> >  test/test-main.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/test/test-main.c b/test/test-main.c
>> > index 778bf0a18a0..edb20bc4b9c 100644
>> > --- a/test/test-main.c
>> > +++ b/test/test-main.c
>> > @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
>> >        *   (for sandbox we handle this by copying the tree, but not for other
>> >        *    boards)
>> >        */
>> > -     if ((test->flags & UT_TESTF_SCAN_FDT) &&
>> > +     if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
>> > +          (test->flags & UT_TESTF_SCAN_FDT)) &&
>> >           !(test->flags & UT_TESTF_LIVE_TREE) &&
>> >           (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
>> >            !(test->flags & UT_TESTF_OTHER_FDT)) &&
>>
>> Upon further review, do we even need 6ec5178c0ef in the first place?
>> ut_test_run_on_flattree looks like it's trying to do the same thing.
> 
> Well one problem is that many tests are not run at all unless OF_LIVE
> is enabled. The code as is is assuming that OF_LIVE is active.
> 
> On boards where OF_LIVE is not active, many tests won't run at all
> unless they are marked with UT_TESTF_SCAN_FDT.
> 
> So I think that UT_TESTF_SCAN_FDT line needs to be removed.

OK, so to clarify, since 6ec5178c0ef added that UT_TESTF_SCAN_FDT, you would like to
revert that commit?

--Sean

