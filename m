Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D077E7F141
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 22:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F14286BE1;
	Wed, 27 Sep 2023 00:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="YP3p1edV";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="YP3p1edV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B2686C13; Wed, 27 Sep 2023 00:15:28 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF9C86B94
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 00:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZBxRuw0cMf0ySUQdiHoePw/mfiZvtOJsj4tcSQpUG0=;
 b=YP3p1edViwoshRusJczwydr8UPeg6bp2amys1TFqgPwClItr91I3msP7GKp6XTUfvUFin/tW6Fh6HHxClvUGRdnuFyP44k4xFIPuQcunmoV2fbVhIAx6eA7Z9QuUtob0RTGSt0ig3+q6VKEiISNSa+whkrD4/Dw7pRvpRamfsWhmDHaS19khe6QNQqThQkaZJKVRvJbMOTFMLhXVhbqytoHBcG9H5HVQw9A3f8NzB5DwgCCHF7PGraio29dBa1VOJmgH2nEHW+Proc7h5DMFBk5vJ6cNu9Zd9va64FZZUlXz2b7GLcZXAxLWXwIenmFvWNB/lcZmBieeFxGoaloM/g==
Received: from DB7PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:10:36::19)
 by AS8PR03MB7832.eurprd03.prod.outlook.com (2603:10a6:20b:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 22:15:24 +0000
Received: from DB8EUR05FT032.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::9c) by DB7PR05CA0006.outlook.office365.com
 (2603:10a6:10:36::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 22:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 DB8EUR05FT032.mail.protection.outlook.com (10.233.238.240) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Tue, 26 Sep 2023 22:15:23 +0000
Received: from outmta (unknown [192.168.82.132])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 9DE2620086FCA; Tue, 26 Sep 2023 22:15:23 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown
 [104.47.51.239])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0092C2008006B; 
 Tue, 26 Sep 2023 22:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb0HDDshL3wf9//Os2NucE1lbmOeW4sgH6z70fG4p6whELogAsWVWDWhMsY6bUd3Y9UiajPnF7AsHD554ylm4bjl/O6rKWDbstUWwBRl24kvKl84SdJAl1MizoZf0+AA8PEFZ0gdNpWFZqZGevzk+CrcHSwvt/qwGKo6vK7FwzmIWCESDZmRW+J0DlG+B6gEusfbux07kAdqo0OwZkYcjCk2PxoNoAzg+nYBDmLFtj2m32dd6xr+fhB8R3GsANSXLTfAqVmHtwDgOZfrQwlxdngWX/0/3xkfpxLQUmxIOTRe/EeNtBncikteyr6ttmaxkNP7XbM5OTwsORYIdYYbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZBxRuw0cMf0ySUQdiHoePw/mfiZvtOJsj4tcSQpUG0=;
 b=cmPL90nmqMYaPNHT+2NsW+3dOySB6GwIHaaYKyxWK5X2Ru+aorxAxUZyhPBZynRnrTULQpuoLcruoqWvUGShSnk+YoB+AfaVfRAbkE7P7Z7GO+/wSIOi3ZljijOMW00VSKW1DZmEHghg4JTHgaTFGgVM3yrWdYAXtzEWBZl49HKDiWR/jBVf3hkqTYJgUx+MPfyCENs5n4uYFsJGpYdpO0MG7jWKssAoE60eu4tLm/HPyrDmZ23Xl9ZUM+r9gx1AZDYYrC8DhepN1nDf7slT+BQJz3p4EkWp2+wZ2QBVMDRHHg53V/yDB5DS64W5cGrP7IvfaOt0Cb3tc8HWZ4NQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZBxRuw0cMf0ySUQdiHoePw/mfiZvtOJsj4tcSQpUG0=;
 b=YP3p1edViwoshRusJczwydr8UPeg6bp2amys1TFqgPwClItr91I3msP7GKp6XTUfvUFin/tW6Fh6HHxClvUGRdnuFyP44k4xFIPuQcunmoV2fbVhIAx6eA7Z9QuUtob0RTGSt0ig3+q6VKEiISNSa+whkrD4/Dw7pRvpRamfsWhmDHaS19khe6QNQqThQkaZJKVRvJbMOTFMLhXVhbqytoHBcG9H5HVQw9A3f8NzB5DwgCCHF7PGraio29dBa1VOJmgH2nEHW+Proc7h5DMFBk5vJ6cNu9Zd9va64FZZUlXz2b7GLcZXAxLWXwIenmFvWNB/lcZmBieeFxGoaloM/g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB8PR03MB6140.eurprd03.prod.outlook.com (2603:10a6:10:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 22:15:18 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 22:15:18 +0000
Message-ID: <4c2dec59-dd2b-049b-9a4b-71c437234ed6@seco.com>
Date: Tue, 26 Sep 2023 18:15:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Sean Anderson <sean.anderson@seco.com>
Subject: Enable thumb on AT91?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB8PR03MB6140:EE_|DB8EUR05FT032:EE_|AS8PR03MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce746a1-b8ab-4772-6123-08dbbede1494
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b3xYfxH1hg7dBqVor0zv7NvnUnt0ThorJWW1tMOnyhHOi3zIvX7ekL9LvVVKsLIsx8KwScxGgS0byLs4bfHo7dLsGG4P7Iu3/CT1uES8fwfLYCMP40GsSeKrzIi4/WueprNmRdWVmr0+A5lXw4whaXJWS49pPM6Smp9NQtdfnhr0bqmZ35khD6B9GjPMGLKv3yKFW/4rb8C1CExblp1Fh1lSlkomatQjomsN5GjR7IUIJpwc94YPMT3sXlpKEzbcR9ygbsxK4LHdwrymFow5awrzb1GpNnvOJvgtQYPY7VTi24hCvQBiGxhvCM4eZfMKWhXJfM0PbmehOuScuPqTyVtYmh+wYMUi2jrUGMiaqsNUezza57zC9+EL+VIz8KjFr05sa/Aud7hvGRrcU1mkQJIBsl56jrwtn+tMit3MWlZ6OpIvwdyfUdzvwO4IYfZzecigr8eXp3C3mKHNQyLont5ZADT84T/3goaV0wDUAY/RPJv5pZqRi1HEKifHUtz6ooMyvXQd80xIbWCciUCyaBrc+VQNF0s6EBCVvrX80VVEBQb0qvp9XQH3UrUv/5mNVC5+Efha2g58e2qd3ts2vfmYWPLoFnIVnvdMW92Bt0SU2FiMyKo2F8lroBNUpP3zbf1+shAcQErPb5BeaCRw57V7tG04E3DWwD0z4pZsz+zdcOB7fyLtm36jzC40EN3F
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39850400004)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(2906002)(8936002)(5660300002)(4326008)(44832011)(8676002)(31686004)(4744005)(6916009)(316002)(6506007)(41300700001)(66556008)(66476007)(66946007)(26005)(6666004)(2616005)(38100700002)(6512007)(86362001)(31696002)(38350700002)(83380400001)(6486002)(52116002)(36756003)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6140
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT032.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 78146f1b-5d43-4aa7-0a29-08dbbede10be
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7++LPoMooS8ZFEcNySPF1L2Wj0cbrUXPuwedQlikjc/gjR8tSPXhGYb4Dte5DQoEAR5CDdkQgCe3g8ndN4Li9xZ9KaUHSJF4Fi9InsH22pN11D3U7GvJYUH/8CU/1XIj7KApWWeC/YnVEvesgEYVQPDmE4z9Dirtx+TPZP47cXRTk5NUi65yM9hTR4Akprz32N+RNXu6TSH9FYa9IF/Fa23v78l1WwtGRWa5nEUPbVG9pXgdo4N7ISqzWyJGeaC79l3pwcCj+TAEzkTH/84zJjZDq+I6/4LrdOWwICIaW9rEV6sbMTAjf9/5zg2yobUjhfFcKfjy9+0Eeg95joXdf19l6BwkI1nYMTZT7cWXnGgJExOjWvk2aX5+QqA3OPdl2+GlLD06RELiu661gTWmkls1+JUC/axfCqgFjCBBVMSUd2oBYf3KInZbrUmW2euhW3+Kh1P8II6PjAdc+9JkoS7+V3GWss5CKcWEaO7hmCSTDOtk10yeoo01F67yClxv5KuGmRalrttCHRvNTDJGqPv/pLE9rzmGfAGy63HeoslDG1RsF4YOxuOZmJWZ67EA4tzqdGooXq0BsF7B0QkCaiXj7hzx49Ol9pfmQmAyHJW8ibsF/WkRWkZRrsf5vjvyMnnPkPmz6oghjIi6VqOrDzSMoBvtE6NlAHAzORZCFA8hV/GXiG6R4As7ASCp+ygGsQdOi6Qlg3dgC9Oc2YramGCXfkmgDImhXDWqAhMHZvPXrvpgoPYHquNWJQDOzieos5s9BXi9FPvsPw9/0dgf0E33JAAi9jOA912pKMe6xq3eVZ0nqBpihI43Bw/HUkg
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(8936002)(5660300002)(44832011)(4326008)(31686004)(8676002)(4744005)(6916009)(41300700001)(40460700003)(70586007)(316002)(36860700001)(40480700001)(70206006)(26005)(6666004)(336012)(2616005)(31696002)(82740400003)(356005)(6512007)(7596003)(86362001)(6486002)(47076005)(83380400001)(6506007)(478600001)(7636003)(36756003)(34020700004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 22:15:23.9561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce746a1-b8ab-4772-6123-08dbbede1494
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT032.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7832
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

Hi Eugen,

I noticed that several AT91 boards are quite close to their SPL size
limit. For example, sama5d27_wlsom1_ek_mmc is just 173 bytes short of
its limit and doesn't even git with older GCCs. I looked at the
datasheet for that processor, and noticed that it has thumb support.
Have you considered enabling SYS_THUMB_BUILD? This shrinks SPL by around
30%. I don't have a board to test with, so I don't know if there are any
technical reasons blocking this.

--Sean
