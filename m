Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDABC83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 15:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C72846D2;
	Tue,  5 Sep 2023 17:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="F7tIjrC/";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="F7tIjrC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9FA86584; Tue,  5 Sep 2023 17:03:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E53846D2
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 17:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DorunyEBWfiVIMDDZZJHJc8/b1hkJQ8khkuJ8TdLj0=;
 b=F7tIjrC/skTmPEwkCDfzcs9X6uO0/OjlVoP/erSr0kSnoLYLeLF2IAriw79XBiwrmiTJOQEBSjpE6iRUKjLK+LfZa4p/yvbIEJLoTnG4M7fKiRBIz2f/O/L0jaMJSF5yIDI8qp3PP6Lg0I/bGjwjOkm86ezgdfeiJHsUcAw/qvi941juFllkSDhp43UrWn11YmtOwlx5fLMR2HuJ2AKZjlZnhf6f52c0pIsAAC1INO4G5omRAfyGmRa3IkBPmwus1l5rloblfc56GUqrDBCYRK50xP4F188oc4v6H9Yonqq6HsN1wcCaPMjEzCrUWJB78LnEqdmNHr9AAU1i7u6IBQ==
Received: from AS9PR06CA0354.eurprd06.prod.outlook.com (2603:10a6:20b:466::9)
 by AS8PR03MB8807.eurprd03.prod.outlook.com (2603:10a6:20b:53c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 15:02:58 +0000
Received: from AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::e8) by AS9PR06CA0354.outlook.office365.com
 (2603:10a6:20b:466::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 15:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AM6EUR05FT011.mail.protection.outlook.com (10.233.241.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34 via Frontend Transport; Tue, 5 Sep 2023 15:02:57 +0000
Received: from outmta (unknown [192.168.82.135])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 C326520086FCC; Tue,  5 Sep 2023 15:02:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C31052008006E; 
 Tue,  5 Sep 2023 15:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQlGELH7Nv/qqYNPOgQnu4VLE0AC0L7j+otp4IYW7qxomioqUctSmrbNwt9gEOf/cVAFr5SPbZz+XYBLZMSqlD6hfqHxRJ+g0pkRrWCQgFIopuEYlZkPFs4O1P/sp0UlnpZJOyQCks43BBHhgwceQDDbXMY7qFJFi91gI3Mw4NTgi9h6VGyMG9CsJIhCMxph2DDOnWTZAT5SiwWEbGH0mqLg4/31aBnF8gnDLZmDlb/Q9eV/ePmnaMXQCpnUkEhsuRMFmmRwJ3cj4tJFYCFXrHMH8/Uu3PAwGommyqZbAmqgW5HzCIAF42SafBWGZb2FGCFvCs14zYfu4Ve5DyeGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DorunyEBWfiVIMDDZZJHJc8/b1hkJQ8khkuJ8TdLj0=;
 b=cZNw9XHeAbkmSYi5XhTYNLCwPiPVcrZ1IpNUZhRDKrscXOiuyN5cG71/VY/KdhlnufbJScOAVC0Gj0682UHIXFq/CoRT5QNOVS4GOrN/hzhzD8nK6T9TAq7e4/WY9yTt8oUiqcwk6Y6PBw2SD5kVws4wU0TB6xFqB0tw0vFtfLAFcZPaHiRcG/YvmiPp0117n/bo6/JgosIKs3mpEypbWPm76wK/IWeEh8hm+XGmjHjw46UbKa32YjIL7j8EACbgeOhFkVB9vodSpJwWWCqIZmLgWIytsFA3ghQrhiquvXruZwgb5wuGgm460bdjuKgI/oEPJBy6+WVpE6OAzGU0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DorunyEBWfiVIMDDZZJHJc8/b1hkJQ8khkuJ8TdLj0=;
 b=F7tIjrC/skTmPEwkCDfzcs9X6uO0/OjlVoP/erSr0kSnoLYLeLF2IAriw79XBiwrmiTJOQEBSjpE6iRUKjLK+LfZa4p/yvbIEJLoTnG4M7fKiRBIz2f/O/L0jaMJSF5yIDI8qp3PP6Lg0I/bGjwjOkm86ezgdfeiJHsUcAw/qvi941juFllkSDhp43UrWn11YmtOwlx5fLMR2HuJ2AKZjlZnhf6f52c0pIsAAC1INO4G5omRAfyGmRa3IkBPmwus1l5rloblfc56GUqrDBCYRK50xP4F188oc4v6H9Yonqq6HsN1wcCaPMjEzCrUWJB78LnEqdmNHr9AAU1i7u6IBQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8399.eurprd03.prod.outlook.com (2603:10a6:10:396::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 15:02:54 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:02:54 +0000
Message-ID: <0ca9f21a-5f22-4730-d17c-6f4a1feae737@seco.com>
Date: Tue, 5 Sep 2023 11:02:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
Content-Language: en-US
To: Xavier Drudis Ferran <xdrudis@tinet.cat>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230731224304.111081-6-sean.anderson@seco.com>
 <ZMtl65DZ0NmO7pZO@xdrudis.tinet.cat>
 <4546689a-5b75-9ae3-3dd8-1a15bf896b5a@seco.com>
 <cb381ee1-fbbf-54b3-873a-d3003cc4b528@kwiboo.se>
 <ZPXUt17X/yGVme8+@xdrudis.tinet.cat>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <ZPXUt17X/yGVme8+@xdrudis.tinet.cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB8399:EE_|AM6EUR05FT011:EE_|AS8PR03MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8869f9c9-1ed5-4cce-5564-08dbae2130d1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rLzNeqRxCW3+JpejT1iIrF+jH/aGwwUK/oN9/bXA2EWFoL3Gaq581wIasgZ9x9LSHyLVEYC22Rcj0fhr0CW5tVMwBiQVLD3q+0STaxANvIHjYFvwWEcwSLirW2+GZHf8ANdqHffOs2Yt4zb+KeOXHmjcI7EpIswTLi6Pxpw5yKAjuF//UmQFoSaqQKZdtOIR2KfFb53/KPwjKy9+b98hxctGQmkQI4BoYVPov6JJxJ/9biz2T08euUd3naENNMtlCox0gxthkRlLSvtmU2jiqhuOcLIOfZXsPT8otZm4ZGqrv+OT7HipDJNnGbN1RiGx1+RY5PGabsWklDxZxzB5EwbrKAAzE6/fKp8n0jRhfKhjQh5D4VbZtoF8PTukiwsqIXF/LppIPnl5ijBWaBQGNipo8Sn78q2yyUvLQUVWcIsJkNDC0+mJWuYi4bByXhGWSh7gDODCVgLbaom4zwbfd7reGhaEL0hy+h52KGE9WGzC0L0BSLNxa1Y5kFFtA8XHw0MpF4m1//kirkE4N/o5JQj/3YdnNIbXKMHpVDNkRJpbEwmWqghyxhokCteIuQuC82+py7/kkpvmCR0fb5zSKblp4v0lOc1rrlzZOvrl3O0PRcgoqqTyHay/K2MCVyiOJl0PDIEIRUwEqwvUueyjsWYAbACvpPPhOU9El+I5rZict2HmdhB3hODC1d0O99VV
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199024)(1800799009)(186009)(31686004)(66899024)(38350700002)(38100700002)(7416002)(44832011)(83380400001)(36756003)(5660300002)(86362001)(31696002)(41300700001)(26005)(54906003)(66556008)(66946007)(66476007)(2616005)(478600001)(6666004)(53546011)(110136005)(52116002)(2906002)(8936002)(6486002)(316002)(4326008)(6512007)(8676002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8399
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: df089d2c-9061-4d1f-5fd3-08dbae212eaf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0m35bsgTg8MW+GdrC0/uXOZ4gmoBAt4lEP6fP2Yhc/FqIX7fTmddktADNXhlsc+qTd33G2GVIIOJr/FoyVl1sfAP5SX4KCSeKGOfKAUOfWGodpA7sGodXceXnl08X/QijSo6kmuAjItWmiSh2vpdusdOwjSDelepfyZC4VZ2AlRslCGQ3EtRUDCl7U+UPHG063iO/ZOX09spCXp+dXVBcXlwXbL1GDXX/vJYHyKE0+kCtzuPOlq6m0k1hoLl06YAze0QyPUfiCUS9aBxi2U7v8EhSC+A0XiA48sOGHi2LO3y3zg1imT7T/nObyzeDx8gFgJEI5KW1GngSCQFzh/C9MhtEzz26cwDFAGpg7TfKeKymCGEkSzWfMhdEsDNEguNd6RGj7zLYDbMn5adL4y/HUjs5MeU1YHm9l6Vd/XtoxUAHhBgvAVkv+LoGT+Ocb2vTNHdPTC2DtPqHwVliDhHZjFAMbf5QYXI2dSW7diec9kEk+q0BLBFyRgttiDp344aYaXSgze+sOp2TrkQqvSZOK3YKgyQDkYYItP+KBMWjYwKtgKNSpdaokr2AONdzXB6vKP/ugVAIURaRL3iuN6K0Zzf7CSE7/pc9Qvb/2oMLaf/sGfpRUojnyHUcuhU7gr3iHLJKfcKE5dZZIUFOdV0jWs2EQLLkebQAa1NX3dpQt2CP7JK5n2WAd3rJJQNuz84x4QjdxU4EgN2PxoYkKgCf5giQ7lvCpZE+xmXsRSPHqRw71qrkUzJ9Ba5MTnkFtgbPqlUXj0xfAdnmCPkkCyo/4kxvJLKLyNpwrvKyeN/RA=
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(396003)(136003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(110136005)(70586007)(53546011)(54906003)(70206006)(44832011)(40480700001)(6486002)(6506007)(316002)(6512007)(41300700001)(478600001)(31686004)(4326008)(8676002)(40460700003)(66899024)(2616005)(26005)(5660300002)(34020700004)(36756003)(36860700001)(82740400003)(7636003)(356005)(7596003)(336012)(2906002)(7416002)(8936002)(31696002)(86362001)(47076005)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:02:57.8923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8869f9c9-1ed5-4cce-5564-08dbae2130d1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8807
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

On 9/4/23 08:59, Xavier Drudis Ferran wrote:
> El Sun, Sep 03, 2023 at 08:17:26AM +0000, Jonas Karlman deia:
> 
>> > Fundamentally, we can't really deal with unaligned images without a
>> > bounce-buffer. The method used by SPL_LOAD_FIT_IMAGE_BUFFER_SIZE will
>> > continue working, since we call into the FIT routines to load the image.
> 
> Yes
> 
>> > I would like to defer bounce buffering for other images until someone
>> > actually needs it.
>> >
> 
> Fine.
> 
>> > Note that in the FIT case, you can also do `mkimage -EB`, at least if
>> > you aren't using FIT_LOAD_FULL.
>> 
>> With the following two commits introduced in v2023.04-rc1, the alignment
>> issue for Rockchip has been fixed and all external data is now accessed
>> block aligned.
>> 
>> 9b2fd2d22852 ("binman: Add support for align argument to mkimage tool")
>> 5ad03fc77dfa ("rockchip: Align FIT image data to SD/MMC block length")
>> 
>> Regards,
>> Jonas
>>
> 
> Well, yes, thanks.
> 
> I was carrying Jerome's patch still thinking it was needed for me, but
> I just tried without and it works too, in mmc. In spi I didn't try but
> it should be even easier (bl_len=1).
> 
> For me it's still odd to write outside intended memory. Would a warning
> in case legacy image loading writes before load_addr be acceptable ?
> Just in case someone was using the memory there for something else.

We could add something, but it would have to be behind SHOW_ERRORS. This
series is already having a very tough time reducing bloat without adding
any (other) new features.

--Sean

