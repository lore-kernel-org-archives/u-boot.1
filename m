Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5756AC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 16:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C088718F;
	Thu, 11 Jan 2024 17:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="y2ni7CRe";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="y2ni7CRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A0538772E; Thu, 11 Jan 2024 17:51:43 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E2086BFA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 17:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=P12kzwESVPimq7iOHNbOZy7vNg9+zzP4rapIKWTzrlSOpqlj28uZbJD7gnMOzbFwemmaQAPtSN/iTSzIOXjdSCcOncDO2r9o8rXholyeybwdQh5SND4lycaZfryoreuem4l0AxavNCC600I7SSGCH0623dG/0LstkjdAUCF/B9TZMNQr8fs3mUdDkaVtxiSNBWfcDjtZPQ0IDjNLkaqn5I7JzV5tHKZLB4COXznrld5RLtxnrmfGunkOAInMRk/TVZ8LkfYhJB9r8tBL3joY1jMnMqc0lFOEcGjthKNmgdi0UkI/z2nac9cZiwpRodajOIbmk/3OpiA7CxEasvZxPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MEhsWO4wc76eXp34Xq84HiQ109R7mqFmUIpDNasb+4=;
 b=MDA2rBYvL4kI5qYTUK23Ku3ampgg+p3FocT31UHGsB8/gUEgWs8Wg7Z3MlBmehS0PgicWtWxHabwadVJAhaAzdlNiPdghJP7U7Ld/iS0VZCuRhypHTDlAXWk2YwOh9oROAGV1EIvos1Z4DAD47lgxbZOH0/4QlaR4t2hOg3Gw7CubuWwQeMQJpkafk/OyHFmpMzTFbzH5m8Vx8dgP/chzBzNrmnL4F4+wqDhPUreBYlXdjU9qIcelZHXVCaBUWCbf2/pWByDsVCmDSsyTTeJXo1G8BdZzT+n75bDgMU3p3p/Bs5JupuvdIOCq+JQEyysbeu3+eubEiGi2gqlWki8ZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=baylibre.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MEhsWO4wc76eXp34Xq84HiQ109R7mqFmUIpDNasb+4=;
 b=y2ni7CReJ0dPvSthssN2GW1PftkkwNPHrKBAJK/YW6MAXgUsR/PI8jIt7ERj0sEgNgUHuYSLDjye3rBgCWFvRq6xO5DL9sD6HIXi1aj8GVQfeCbH9ulOcu0HDn27e3BVcws0XUNytYFlqa/ieDf6BBkEqPMWG40scIIl5CWLLDuxQvgDjXnPUs/MmchkGMHXyPrSlrPQNIrK+0a5dkmd35+apx6CtPUmlyRGFEDNRN0SXkWXnh9UX/Vgstpw8TptBKSJ1GE6rft5mztIv8tyGECJTa4PJUs1XjF0kznr1EQ398h7bHwbusnOg+GRWrze4W2AlQ3dIW4jzVNrRImoUw==
Received: from AS9PR0301CA0051.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::28) by DBBPR03MB7130.eurprd03.prod.outlook.com
 (2603:10a6:10:20e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:51:38 +0000
Received: from AM6EUR05FT038.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::a5) by AS9PR0301CA0051.outlook.office365.com
 (2603:10a6:20b:469::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 16:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT038.mail.protection.outlook.com (10.233.241.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19 via Frontend Transport; Thu, 11 Jan 2024 16:51:38 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 C844F2009538D; Thu, 11 Jan 2024 16:51:37 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.13.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id AEA6D2008006F; 
 Thu, 11 Jan 2024 16:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3W7v5CCIcfK4vKqn+3k9ZhD87r+ck4mEfY/b01luMewp5Cl8DGn5Yl4H5Q2QiUYCWPOP33vvSAFS24WIi8nqbhMJzqjD9y8HvSwIYcx5T7TVfKeO8Zwddu3aK+uSwVeyplx6cdTk1hK0q9oTnKh3dON7IOlhblE75PoGK5r0pm8UdAgOWmOObAv6snrKs0smp9m2iufG8787jcujZGF/Byr6SeVB93aaJdA0GyAgquZCR/uSIakqgaE8dGUYpc91Z78WS1a6T7enkSrv94e6rK8Pmt1ZIw2srqjGic5MUs8D9GWCtdgCbk2aJO7efoelz33kS70ad2aRWWteAjUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MEhsWO4wc76eXp34Xq84HiQ109R7mqFmUIpDNasb+4=;
 b=HEMI6jAVySZhVs04UlwPdhIg9NwwayaPoFSJl0CIJGHDThU+vU+OcdBJyDceQgueja3Pnv2Qjvibck8h5kk8UMCZfpuWIl/iDErkmrylzkLkwuP4K1KL3jigzDa84hUbSya3xIQQIhLjSNSdKfLMtyqSm2cZ6CMzgRxjnsqcozg6JbmSSXItFGKR3rHx4n28pZMLy4XOON3HNDYRvDAqQ66+geCrgYFFIRUIHLgoGaSDc/hUMhlUj6vTZu/L+WbVys4BuvVWRjQ0x7x6fd7CJSIQs4w2jSJLg22iemOc7LOddZstcU19VkiwebnAKgLHx6iQxn4BAK4N3zcZ5YqwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MEhsWO4wc76eXp34Xq84HiQ109R7mqFmUIpDNasb+4=;
 b=y2ni7CReJ0dPvSthssN2GW1PftkkwNPHrKBAJK/YW6MAXgUsR/PI8jIt7ERj0sEgNgUHuYSLDjye3rBgCWFvRq6xO5DL9sD6HIXi1aj8GVQfeCbH9ulOcu0HDn27e3BVcws0XUNytYFlqa/ieDf6BBkEqPMWG40scIIl5CWLLDuxQvgDjXnPUs/MmchkGMHXyPrSlrPQNIrK+0a5dkmd35+apx6CtPUmlyRGFEDNRN0SXkWXnh9UX/Vgstpw8TptBKSJ1GE6rft5mztIv8tyGECJTa4PJUs1XjF0kznr1EQ398h7bHwbusnOg+GRWrze4W2AlQ3dIW4jzVNrRImoUw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8351.eurprd03.prod.outlook.com (2603:10a6:10:392::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:51:34 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 16:51:34 +0000
Message-ID: <72ac233d-c18d-4f57-bc66-451fe0bd2997@seco.com>
Date: Thu, 11 Jan 2024 11:51:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "dimorinny@google.com" <dimorinny@google.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
 <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
 <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB8351:EE_|AM6EUR05FT038:EE_|DBBPR03MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2c1cca-7dca-4506-71bf-08dc12c5941d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MZ48iPRD6W6/sOJJXi+cwze1T9sedEGQ39kjcB03jyv+bJeRKFo/8mpRtn5lNYu3SKR48MVgmfkjI305OMlXOObAJVs/0qafSaO5g7zJ3YWlQn/FWXadM6uFTCfNYxmX/byhlCWwfAg1N1glNnUlwo/yFAy6lGu/a8EIHw9tty/va/chfoKOezH7Bmxc+dJGlQ1D9O0hqzfi/J6qKg+ghfjScPnHR1o356m2PqsJ/g9oYNahwwzmZg+b5wG4N8ezv3G/UzG0gurY7BBMnAGbU54IwMb2UFpd9OiiPNnRq4L3Z2XUC8IUQqrPDUr4v2IYJF0jOw39bNfsJPCuU0rL5lVG7b9eKkxkzzUrNlncv95KrczOBLzClFdiXM2o1ue+a3h4PqbmqeY+RmNAaeatCrnOkcM636FgLwUcoIKCVeMz7IgPH++fT9/DX9+MXMNQQtA9J8NbyrLOO9uX7N0GxPTVeBETq3MtrPx42u54QK+IFGwe3BlqS44xm/IYU3q1vfljKkOi8jP1uQ4Zu1k0zzEHqY36vyWTlknf+/W5H5wdl7gEYJbiZzzSt1aNGalpKOtpQeAKfvtnM5rIEiYnFqWpl2EwnEJCse9KBco36AJ3aZy/nlJITN4cFn1KZ4BOsw5VDnntcHYzGrk5jNpkE+3cKSFTDgejzeooBFLKcc0o4W3k+qYyESTIYN7v5OwXHAcoRJxDozZ9eLFfPIJjDA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(2906002)(86362001)(31696002)(36756003)(38350700005)(41300700001)(52116002)(38100700002)(6512007)(53546011)(66946007)(66476007)(6506007)(8676002)(66556008)(54906003)(6666004)(316002)(6916009)(8936002)(6486002)(31686004)(4326008)(44832011)(478600001)(2616005)(83380400001)(26005)(45980500001)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8351
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT038.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6e63b0b7-6311-42ef-4223-08dc12c59178
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cGRHYoqghHI2XvUfzeUUJtIkACSNGCyntEtzC3VLAkuKD2/kw6iTqIOnQmt43znHBA4DPEw6CdpQ7vrl3Ll73mk+uOS9zAs2eKnVsTyROD0QZytpkCMJDGJj/GAFskC7FKvTgWv51qUj0zlJdv+zfhLsgEj2dvMUvC88JKuJLxTf8WQkoobcJE4uTx+9A7pAx118THVc6dqM8fRV3pfalOqMA1a6BZ2HQzQAi62EaVGlzRZYOWAH9FiPDknhEpkf+d+PCzF0LYxXKOLJ61NbGP1QJ4qfbkUDHBynDO6kh7Hxiw08TjENypyJa4UyR7xtHaCpSp4CROvg8wFAs6kjlFILxmmrskeVRUCl+49UHVp8Zs55IXAeFNdwNyaKGG02RjpPLqxM9N0ilG5E4tK3+qDT8pj7h0L8Qn+8a1OGlU7+c0HiCWnwXRut8TnyE3MUsmi1Cwx4Htuv42+Mw1ZOtPmPVsz9/NFMnnyjvTZ2RVuagRfB16GIM4gIkeHC7NKn33l4jKL4Gk3DOxr4iEw0qoWM3FchBRwHa+bhEwoCMS0dGPIuazUMe856AMZMxX0vSA8kHrner+kT9fZF04/Vhxx0Tz5EDdHdJt7mzZAtfi70Sw6xMWw+R2pmvzmaoOggod7HpmgrEshlul9M842qrsC+9VUbGuNF0vC/yxfKCHEoj/a75BGyjFrnmItRHyRw0GgRKaHHmsdhaFv/l9X2ClQJhNkEw6Z0kbDYXHKcPQSmzZBMztpdZgXsQhcGiM0Yt1tCaU3qmR5MVj74KzftvcqDeUMzUmxYPsJQQuFbVVx9RUsW3AMydMiEI+FKtL4938cjYujApj1xjAoym+vRw==
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(7596003)(356005)(7636003)(6486002)(31696002)(86362001)(82740400003)(36860700001)(41300700001)(53546011)(83380400001)(26005)(336012)(36756003)(2616005)(47076005)(6666004)(6512007)(6506007)(34070700002)(478600001)(8676002)(8936002)(4326008)(5660300002)(44832011)(70586007)(70206006)(31686004)(316002)(40460700003)(40480700001)(6916009)(2906002)(54906003)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:51:38.1957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c1cca-7dca-4506-71bf-08dc12c5941d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT038.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7130
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

On 1/10/24 03:03, Alexey Romanov wrote:
> Hi,
> 
> On Tue, Jan 09, 2024 at 10:45:46AM -0500, Sean Anderson wrote:
>> On 1/9/24 05:27, Alexey Romanov wrote:
>> > Hello Sean!
>> > 
>> > Thanks for you reply.
>> > 
>> > On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
>> >> On 12/28/23 10:25, Alexey Romanov wrote:
>> >> > Currently, fastboot protocol in U-Boot has no opportunity
>> >> > to execute vendor custom code with verifed boot.
>> >> 
>> >> Well, I would say the most conventional way to do this would be something like
>> >> 
>> >> => fastboot 0
>> >> => source \# CONFIG_FASTBOOT_BUF_ADDR
>> >> 
>> >> and on your host machine,
>> >> 
>> >> $ fastboot stage my_script.itb
>> >> 
>> >> where my_script.its looks like
>> >> 
>> >> /dts-v1/;
>> >> 
>> >> / {
>> >>     description = "my script";
>> >>     #address-cells = <1>;
>> >> 
>> >>     images {
>> >>         my-script {
>> >>             data = /incbin/("my_script.scr");
>> >>             type = "script";
>> >>             arch = "arm64";
>> >>             compression = "none";
>> >>             hash-1 {
>> >>                 algo = "sha256";
>> >>             };
>> >>         };
>> >>     };
>> >> 
>> >>     configurations {
>> >>         default = "conf";
>> >>         conf {
>> >>             description = "Load my script";
>> >>             script = "my-script";
>> >>             signature {
>> >>                 algo = "sha256,rsa2048";
>> >>                 key-name-hint = "vboot";
>> >>                 sign-images = "script";
>> >>             };
>> >>         };
>> >>     };
>> >> };
>> >> 
>> >> This method is especially useful to pass complex parameters to your command.
>> >> This method of course requires commit bcc85b96b5f ("cmd: source: Support
>> >> specifying config name").
>> >> 
>> >> Would it be possible to use the above method for your use case?
>> > 
>> > This method sounds good for some cases, but we have encountered some
>> > problems that prevent us from applying it:
>> > 
>> > 1. Looks like this method requires access to UART (for typing 'source'
>> > command). Open the UART is unsafe at devices with verified boot.
>> 
>> Generally the idea is that you run source after you run fastboot. E.g. you set
>> your altbootcmd (or whatever) to something like
>> 
>> while true; fastboot 0; source \# || boot; done
>> 
>> so you try to source whatever gets staged, and boot it otherwise.
> 
> If I understand right, U-Boot always will try fastboot mode?

Well, you do this however you would enable fastboot normally. So usually
you run fastboot if you main boot fails or if the user holds down a
button or something.  Same thing here.

> Yes, it seems like it will work. But the code for complex
> fastboot scripts will be complex and difficult to read.

If you write a (regular) command to call meson_bootloader_write_bl2 you
can do it in a script with imxtract. Although the latter command does
not check signatures. I have a patch for that, but I still need to write
tests for it.

> I think my version looks more elegant and simple.
> 
>> 
>> > 2. We use automation scripts to flash our devices using fastboot
>> > protocol. A typical example of flashing scripts (device is already in
>> > fastboot mode):
>> > 
>> >   $ fastboot erase bootloader
>> >   $ fastboot stage bootloader.img
>> >   $ fastboot oem board:write_bootloader
>> > 
>> >   $ fastboot reboot-bootloader
>> > 
>> >   $ fastboot erase super
>> >   $ fastboot flash super super.bin
>> > 
>> >   $ fastboot reboot
>> > 
>> > This method doesn't assume what something typing additional command in
>> > U-Boot shell, even if we have access to UART.
>> 
>> I'm curious what you actual usage for this is? That is, what do you need
>> a custom command for.
> 
> Our SoC vendor use custom scheme for flashing bootloader partition.
> So we can't just use fastbooot flash command - we have to use custom
> flashing logic. We also don't want to use hacks in generic fastboot
> code, for example something like this in _fb_nand_write():
> 
>   ...
> 
>   if (!strcmp(part->name, "bootloader"))
>      write_bootloader_custom_logic(...)
>   else
>     nand_write_skip_bad(...)
> 

I'm a little curious why you do this via a custom command and not mkimage.

Anyway, I think fastboot already has a lot of features (especially for
something which is often used with secure boot enabled) so I think it is
good to try and use existing features if possible. TBH I would prefer to
promote the use of signed scripts to do this sort of thing, but I agree
that it can be a bit clunky. That said, this is something which can be
generated automatically as part of a build.

For v2 can you include the board command you want to run as a separate
patch? I think it would have sped up the discussion if there had been a
concrete example.

--Sean

>> 
>> --Sean
>> 
>> >> 
>> >> --Sean
>> >> 
>> >> > This patch
>> >> > introduce new fastboot subcommand fastboot oem board:<cmd>,
>> >> > which allow to run custom oem_board function.
>> >> > =
>> >> > Default implementation is __weak. Vendor must redefine it in
>> >> > board/ folder with his own logic.
>> >> > 
>> >> > For example, some vendors have their custom nand/emmc partition
>> >> > flashing or erasing. Here some typical command for such use cases:
>> >> > 
>> >> > - flashing:
>> >> > 
>> >> >   $ fastboot stage bootloader.img
>> >> >   $ fastboot oem board:write_bootloader
>> >> > 
>> >> > - erasing:
>> >> > 
>> >> >   $ fastboot oem board:erase_env
>> >> > 
>> >> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> >> > ---
>> >> >  drivers/fastboot/Kconfig      |  7 +++++++
>> >> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>> >> >  include/fastboot.h            |  1 +
>> >> >  3 files changed, 23 insertions(+)
>> >> > 
>> >> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> >> > index 3cfeea4837..4c955cabab 100644
>> >> > --- a/drivers/fastboot/Kconfig
>> >> > +++ b/drivers/fastboot/Kconfig
>> >> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>> >> >  	  this feature if you are using verified boot, as it will allow an
>> >> >  	  attacker to bypass any restrictions you have in place.
>> >> >  
>> >> > +config FASTBOOT_OEM_BOARD
>> >> > +	bool "Enable the 'oem board' command"
>> >> > +	help
>> >> > +	  This extends the fastboot protocol with an "oem board" command. This
>> >> > +	  command allows running vendor custom code defined in board/ files.
>> >> > +	  Otherwise, it will do nothing and send fastboot fail.
>> >> > +
>> >> >  endif # FASTBOOT
>> >> >  
>> >> >  endmenu
>> >> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>> >> > index 71cfaec6e9..4d2b451f46 100644
>> >> > --- a/drivers/fastboot/fb_command.c
>> >> > +++ b/drivers/fastboot/fb_command.c
>> >> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
>> >> >  static void oem_format(char *, char *);
>> >> >  static void oem_partconf(char *, char *);
>> >> >  static void oem_bootbus(char *, char *);
>> >> > +static void oem_board(char *, char *);
>> >> >  static void run_ucmd(char *, char *);
>> >> >  static void run_acmd(char *, char *);
>> >> >  
>> >> > @@ -106,6 +107,10 @@ static const struct {
>> >> >  		.command = "oem run",
>> >> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>> >> >  	},
>> >> > +	[FASTBOOT_COMMAND_OEM_BOARD] = {
>> >> > +		.command = "oem board",
>> >> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
>> >> > +	},
>> >> >  	[FASTBOOT_COMMAND_UCMD] = {
>> >> >  		.command = "UCmd",
>> >> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
>> >> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>> >> >  	else
>> >> >  		fastboot_okay(NULL, response);
>> >> >  }
>> >> > +
>> >> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
>> >> > +{
>> >> > +	fastboot_fail("oem board function not defined", response);
>> >> > +}
>> >> > +
>> >> > +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
>> >> > +{
>> >> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
>> >> > +}
>> >> > diff --git a/include/fastboot.h b/include/fastboot.h
>> >> > index 296451f89d..06c1f26b6c 100644
>> >> > --- a/include/fastboot.h
>> >> > +++ b/include/fastboot.h
>> >> > @@ -37,6 +37,7 @@ enum {
>> >> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
>> >> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>> >> >  	FASTBOOT_COMMAND_OEM_RUN,
>> >> > +	FASTBOOT_COMMAND_OEM_BOARD,
>> >> >  	FASTBOOT_COMMAND_ACMD,
>> >> >  	FASTBOOT_COMMAND_UCMD,
>> >> >  	FASTBOOT_COMMAND_COUNT
>> >> 
>> > 
>> 
> 
