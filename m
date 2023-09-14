Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC90EEAA49
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 14:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95AE386A8A;
	Thu, 14 Sep 2023 16:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="LgbgFwPG";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="LgbgFwPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4F286A14; Thu, 14 Sep 2023 16:36:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA87866DA
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+NbqIN8s3Ty8ZvzgRnKsylSrP1IyaxrAJUAoarZC1s=;
 b=LgbgFwPGu7uU/dot4UvCHZj7Znk2InGdKwbCrpF0nggzTOUNgTy0Ej/hPoIj4hYKo3tOqW521iuLhwWYIJnfIr+DFIKNO31dGm+LOqZJRYpcylbAAm9VVc05wUqg894c1EWHdJsOf3rXjEdq+yMQwvo8AgJ/bVfYIJzv2yyQzem8vq+B/wA8Gs9D/hB90X9zxpdsmcquIJk88Fq98dmDxAsws9w6sijgoPmH0tTYF5sLQqDStn6QJ9nKuUlYOiWxrFxGj+hPzli2irBNU/dQsaik+KowFwyIaVHGWxVBYu8DF+v7uej3y++Xev3W4tuyJWnnXGky6Q4YRoG12/0jGQ==
Received: from DU2P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::25)
 by AM9PR03MB6851.eurprd03.prod.outlook.com (2603:10a6:20b:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:36:14 +0000
Received: from DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::6e) by DU2P251CA0010.outlook.office365.com
 (2603:10a6:10:230::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 14:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.84) by
 DB8EUR05FT008.mail.protection.outlook.com (10.233.238.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 14:36:14 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 284CA200813AA; Thu, 14 Sep 2023 14:36:14 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.0.53])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 406472008006E; 
 Thu, 14 Sep 2023 14:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKFKJkp5oFutFvml+ktIPxHVf2W10147e0BhwSewqbEEwZ8HgQ/9g2q4883w6o1nU5XhY08NwlKK8aLHDwBKyoBPMpvBfXl3EGEIHuj7Db1CtgsOj5pC20DBcwm9Mq5d7AkU9XG6jRNliwoMzztw/WRRRYc/ZCXt++0YwTmEn6OpbYOESrb1unaNq9VoPLHA0us81YKAMQ+sNtwP9iYT34oOaA0wiMdWqqhwOPiCNqGe/RV1fKyeI7ZKJsCk+e4Nb7NTf85zrlded3CrPYoWnB9VX1Rsds4NPmy0D5V4Lzudmup98Doqffio4c17EBSjh1GdnWL86iXc5LNVIcRdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+NbqIN8s3Ty8ZvzgRnKsylSrP1IyaxrAJUAoarZC1s=;
 b=MoVGoSnXDf9zmmzaZNegcVJFgat1xvTdDPG/IEHuBbZtMxv+G0klK19hHOj8XJKca9UBH5u6cGmiv/gR9o8IlgHZc7Jc/Wr/h14aliBVJVhC0z/mFeTv8r+SfhWY1Zm/wxFuF+o81TZ89d2aL1beveYI5ITII85AJ0wYnOD0gYrtWYHDm9htn666dTLs7AXr9VIVD1ovRgEWptv1cWKexuJZ+w6qQwsGwvsfrvcCI0T6HoqP8iQz+9yNIMZrv+dAeXY9Tcz1GxSA+fmmhjeqLFbHk+nY8A275ZBvUozC86rxtvrqMuo/YvneAWJXWUktdhbKM1HNJojGrjl1SUVwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+NbqIN8s3Ty8ZvzgRnKsylSrP1IyaxrAJUAoarZC1s=;
 b=LgbgFwPGu7uU/dot4UvCHZj7Znk2InGdKwbCrpF0nggzTOUNgTy0Ej/hPoIj4hYKo3tOqW521iuLhwWYIJnfIr+DFIKNO31dGm+LOqZJRYpcylbAAm9VVc05wUqg894c1EWHdJsOf3rXjEdq+yMQwvo8AgJ/bVfYIJzv2yyQzem8vq+B/wA8Gs9D/hB90X9zxpdsmcquIJk88Fq98dmDxAsws9w6sijgoPmH0tTYF5sLQqDStn6QJ9nKuUlYOiWxrFxGj+hPzli2irBNU/dQsaik+KowFwyIaVHGWxVBYu8DF+v7uej3y++Xev3W4tuyJWnnXGky6Q4YRoG12/0jGQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9880.eurprd03.prod.outlook.com (2603:10a6:20b:547::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 14:36:09 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 14:36:09 +0000
Message-ID: <141dff74-1ca1-cdc6-0ead-d2d5ad2705b4@seco.com>
Date: Thu, 14 Sep 2023 10:36:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 0/2] SPL EBBR - EFI System Partition support
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <ea8895a7-4812-4c65-8c63-8051237ad77f@gmx.de>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <ea8895a7-4812-4c65-8c63-8051237ad77f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS2PR03MB9880:EE_|DB8EUR05FT008:EE_|AM9PR03MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b28c435-af34-4587-1b8c-08dbb52ff2c5
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Jr1eM9SVwsb6J7F0PC5aJB7igC7FKvxJLyFRt8tcNeuWqW1lQmJqW7w3xQkZgdrvBWxKzHdCY5Gv8Pd0PegunX4Xtt+DmkHyOd5kArz2cCdS2A1wQ11zJsDhBKyl65l4mjbwejF/uPHjrb0ihFVle007S8sar50Aku8Cr0WUKRioSUfl20WyRlxsIqRjIX6LpP9P0Ls/LFwCDbumbTYGlwvw0n7yLLT6scVRXqAIiNtRs2Hrgk9QeQEFcyjTwDHu0NqWaeDcyCpIwTSHawb+drq51atoeIHvoKzPTiPD/XU03zQSJNmFvC8DKpy4H2fGSNUp/uq9f3hZmt+8tYPT7PC8oGBHaK2sLxXgvo17GmUg2iIeQJdqcYGWksEyqpgASvbZPVK7sntuG0jSzSyx8C6K4i+S+uRwhaqoKM2Pr9PL9v/N316PfJH0VIDyhV4am2e8axPaAJysxpKQDSfgtvSCvPlIXghU4pBoz78+/OPgvuSzbUi+pK7IHnGXt0IF/gV6Ag7D/uSAW4c00y2IfvcEI1WoxxwNjahH40CADrt6bK1ju3zK/EZEVihfPWdL7licehKknmXJgpR5quGx+hcTlD2275woAbJM4Yv0MJnke7YeSVSyssm8EeKz9cH8lUynBr1xDErQx/Xukpq0BB8WXkVsxxU52FQ6kHKUFMs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(1800799009)(186009)(451199024)(83380400001)(6512007)(44832011)(5660300002)(8676002)(8936002)(4326008)(53546011)(31686004)(6486002)(52116002)(6506007)(26005)(2616005)(6666004)(478600001)(6916009)(66476007)(966005)(41300700001)(316002)(66556008)(66946007)(31696002)(54906003)(86362001)(36756003)(2906002)(38350700002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9880
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ba3c972c-812f-4907-ee2a-08dbb52fefac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHUp3V1xXxTht8btnvWmzeJnFnNmsQgkryoHPqzkXLFcY9hF5773MasFDJdQpHSjvwI8QC9Lro5MYrNlGdjscss4RUwV0WncS/uCPhjpiBPisR0JBSp4SFQn6AvF9MaPxYz6nZhgFEjAfSIf88t3cBmUREHa2CchVzlL3Ybm3qcnJ8MxCqllyG9QPMFtLnafWf8qF/CSOYUHTdy3PO/qLcA5Lu8m2JNds4O+GVL4E2mlV0aY+6v9CON1d3wv7yvin6ZfW/DJqaKJBubLGM/obXgBpbx/IlDe9f3iN3840q8ig2CpHRBJkNB5XVF58f77It+Y3DkhFSbtVAE5ZiJPvuhWeH7oF1WDevJWQza5abA8KS4uUYCk+zOC76XvfqxZgREG9nLcMDtG/QNIMwP8vkWKIuk5N21WoBllupuECFoSzGR6V2znEomoOaxYcSMO7Chpp+n06rgEYFLlbk0KhOxoQJoPxwMkavEwbNOqAvNjTAMCaW1uqvyGkogu0eooiszF/+nNNhxhOXtR01CkC5TPvctMEf+AZ7TURXh7UVKZoWDJ7Nki4tBWADZAT/ZfJRR0efEoQEhaviFyUmnCAiwg4vuW8PkhBgPRXNjR85j5NhFRsRX3H/fbmEbbDspTU2BoGvbekrPYAG2XaSxUDP5ItML686+OPOAvXtUGb8iADLEnLhEkpGsTGs9k6SXVStAtJkNh8vDHY8VbWenAqazcwanhnA1el0zWkVX3902JqlrVW4FqrW34TXaOu/LC/ye9SYcz/6uW/KcHl6aT+4n3OXFroakAMqEGT+AInrI=
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(31686004)(40480700001)(6506007)(6666004)(53546011)(478600001)(966005)(6512007)(47076005)(7636003)(36860700001)(6486002)(82740400003)(34070700002)(356005)(7596003)(336012)(2616005)(83380400001)(26005)(31696002)(86362001)(36756003)(6916009)(70206006)(41300700001)(54906003)(316002)(44832011)(8936002)(4326008)(2906002)(8676002)(70586007)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:36:14.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b28c435-af34-4587-1b8c-08dbb52ff2c5
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6851
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

Hi Heinrich,

On 9/14/23 10:15, Heinrich Schuchardt wrote:
> On 14.09.23 12:08, Mayuresh Chitale wrote:
>> This series adds support to locate an EFI System Partition on a disk and
>> boot the next stage from such a parition if found. The next stage image
>> is expected to be under the FIRMWARE directory as described in the EBBR
>> specification [1]. Also update the spl_blk_fs and spl_fat drivers to
>> prefer booting from ESP and fall back to the configured parition in
>> case of a failure.
>>
>> These patches are built on top of the following series from Sean Anderson:
>> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flists.denx.de%2fpipermail%2fu%2dboot%2f2023%2dAugust%2f525665.html&umid=9846b220-30e5-47d9-980b-6b2a067d6959&auth=d807158c60b7d2502abde8a2fc01f40662980862-8c7a372e72c3ce6a78488f17bac32c55586848b7
>>
>> [1] : https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fgithub.com%2fARM%2dsoftware%2febbr%2fblob%2f854ba0e68590102667b84a5ba4e0b076a3f5f2cb%2fsource%2fchapter4%2dfirmware%2dmedia.rst&umid=9846b220-30e5-47d9-980b-6b2a067d6959&auth=d807158c60b7d2502abde8a2fc01f40662980862-c4109227e8dc78dcfe731b6e4cfe9dfef856e354
> 
> Hello Sean,
> 
> your series [1] is in status "changes requested". Will a new version
> come up soon, or can this change go first?

I had been working to incorporate your suggestion regarding bl_len.
However, I have not had the time recently to finish that. I also need to
have another look at the size changes once that is implemented. I had
been hoping to use [1] to get some general size reductions on most
platforms, but I am going to have to revisit that as well. I would like
to work on this, but at the moment it's not high priority for me.
Changes like this should likely go in first, since I suspect it will
take another revision or two to finish up that series.

--Sean

[1] https://lore.kernel.org/u-boot/20230810221138.GY3630934@bill-the-cat/

> 
> 
>>
>> The patches are also present in the branch below:
>> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fgithub.com%2fmdchitale%2fu%2dboot%2ftree%2fmchitale%5fspl%5febbr%5fv1&umid=9846b220-30e5-47d9-980b-6b2a067d6959&auth=d807158c60b7d2502abde8a2fc01f40662980862-6f91c84d8d5661347bae86e4cb72a96341f7048d
>>
>> Mayuresh Chitale (2):
>>    part: Add a function to find ESP partition
>>    spl: Add support for booting from ESP
>>
>>   common/spl/Kconfig      |  7 +++++
>>   common/spl/spl_blk_fs.c | 61 +++++++++++++++++++++++++++++------------
>>   common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
>>   disk/part.c             | 16 +++++++++++
>>   include/part.h          | 10 +++++++
>>   5 files changed, 107 insertions(+), 21 deletions(-)
>>
> 
