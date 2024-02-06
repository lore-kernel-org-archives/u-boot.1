Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1B8C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 17:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9D9870A4;
	Tue,  6 Feb 2024 18:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="MEG8vtO0";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="MEG8vtO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1FA870A4; Tue,  6 Feb 2024 18:09:09 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B46686F34
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 18:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Rw4yu5DxQau1UIB1ykQ/qhfmCjywPxvD06kHFgwsABKt3w4IB3uTJofWVlYYUCoF/3Ac+GeYJObviYDZj6dfvKUD2h8AosWLrnTcVXi+oxBRixN0EsKtS2UlXUs4qYPfJ9m4euS7KDxCFLdpdJ8hyIWuEfh7FNFf8Uc8edNsA8RJR1ZuRuolltkTyiCgArPruO1E2TcfAONBjmTAEjh7llhICOEaQa0shijazJUv+LIrjxL4yUQTcXM2oW/UeucQRNG4VQoqNp5f0VLjKCEi2+RuxisLHAZrgUartjUZxubAkIYRpMInak4sPPUAgWn5eZSnLQxeL+/Z7PsBYNMcnA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3lM2vsPqTa8nBJqqBlRnIBAmdLQGpbsBgIRGnKQLMs=;
 b=GBLTzqlW7QQMtJ6z4dPtZsrrwiahnn+57PbKxrYBj6lBjvGjDpb6Bt594wG3VNKOXfmzFmIFVyCQMw3ZZ50umD0U7UuxRk+7ocGdEH/vcX7/u7V+jHHNvCrt2PrNAXxxk2XgqCGZPkjlb7C7AVW7cplictlzRHdxQN9O8yom9TTnZhs9IIkIyuXyfM4ZOmn2iEhpJXkvV7JFxnbGaynTlWAuQo3mFdyaGKM9CFAg62xBBkeLOiRinB2+4LLKbeqaJsL2mPBQw8dSpCSff2LbYexqwdV6vxXXtTnuj2Yz/svQnonsK9XmXd/Cyne/Xe+uCmFGdCisNyWrcaomdHY+cg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3lM2vsPqTa8nBJqqBlRnIBAmdLQGpbsBgIRGnKQLMs=;
 b=MEG8vtO0ypxrYFAoL10LDxcXfqB9kgMQRMikcye4LSdiNPYLV6mt/ZM7fuHNzcCe6SRVhtchPECyxS6ukiKZsR6DgmwDTTwvBdwUEimCnle6r43+LzzCv2PCh/WGXzc1yErfAzO/F3gST0vQJQHMP18rzEFV911IkR+PzJGPZkJcgw4Si+CBsr+vYyoLLyAtACgR5vL4lW7WSfV+LkL187QnRSai78fs9O5u3BK8psarzpF9sMkLFDKfqWGEUG7hBtIsB6PYAgWYgc005Nqr56N1BP2VeJew8PGX+RR82JBif/DBS/I2tT7DLNDkrtfAQA1rr291+HvnwXTnY4Rrog==
Received: from AS4P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::15)
 by AS8PR03MB6757.eurprd03.prod.outlook.com (2603:10a6:20b:292::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:08:59 +0000
Received: from AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:5da:cafe::ac) by AS4P192CA0001.outlook.office365.com
 (2603:10a6:20b:5da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Tue, 6 Feb 2024 17:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT036.mail.protection.outlook.com (10.233.241.222) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7270.18
 via Frontend Transport; Tue, 6 Feb 2024 17:08:59 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 567CE20080F89; Tue,  6 Feb 2024 17:08:59 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id BF7652008006E; 
 Tue,  6 Feb 2024 17:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7ouMRo6h2Vo5chYtPV6tZX7IR60tSftRw2HLjUjMDQCsGMzvv/Ig4AyLqL85HqnU226O1YrfzZKWZqOzGbKlwDcNgT1UhgSME6t1m4qsz4FrntKE/hWXrfGEeS6dY5sUnCWjMpm6Opftn3I7KTO9rjBYA4ljPlJCcQPBtCMmXIzEbAWzS+/LOqo+e8LqAB52IDJNWYQ6jY/Kx0MIIJ40CZ1ekh+msrxvHv/11eIRX/4DTuBYiJcr+PLLAdWeAV12PlZwtL6RqGXCJnCEsjy6d6oGFfMZvvYor5Na6PA/vh5AtnxR6WoaNer2fEBjv2dYSIx9dBS490wtxykj31QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3lM2vsPqTa8nBJqqBlRnIBAmdLQGpbsBgIRGnKQLMs=;
 b=aRYiPk1tkxKnWQkWQgzGvuYftbLZeqkoQLqfY3V/XqhlmCpBH80TlV4i8u0u38D+F8JF5DxFmgANIbfv3gsY/LjvpQljUg/qjNnU5TmBY9vi9y7K1h9B50oEcTHpypFizNRPqWrp6VdjAIDmjzeZIkEhK9SAWhOdBIa7Dnycz1QAE3MRjuBzF8kiPj3NFVdoP9VfCIqd4/+8e40K5nYIVkZNY0WdqkHBr4xG1PmyjCpp5VOKdeKLQ3SxM22KRJwP+NbMxR9LIrLg/JNtodRmaMXn11/SJgSKKi2fcRS0VGpBp+ytCdiXAG9w3dZ86yYXxSu+fDuRao3FQW2FC7C0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3lM2vsPqTa8nBJqqBlRnIBAmdLQGpbsBgIRGnKQLMs=;
 b=MEG8vtO0ypxrYFAoL10LDxcXfqB9kgMQRMikcye4LSdiNPYLV6mt/ZM7fuHNzcCe6SRVhtchPECyxS6ukiKZsR6DgmwDTTwvBdwUEimCnle6r43+LzzCv2PCh/WGXzc1yErfAzO/F3gST0vQJQHMP18rzEFV911IkR+PzJGPZkJcgw4Si+CBsr+vYyoLLyAtACgR5vL4lW7WSfV+LkL187QnRSai78fs9O5u3BK8psarzpF9sMkLFDKfqWGEUG7hBtIsB6PYAgWYgc005Nqr56N1BP2VeJew8PGX+RR82JBif/DBS/I2tT7DLNDkrtfAQA1rr291+HvnwXTnY4Rrog==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM7PR03MB6465.eurprd03.prod.outlook.com (2603:10a6:20b:1b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Tue, 6 Feb
 2024 17:08:51 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 17:08:50 +0000
Message-ID: <2e86e6a4-2c47-4429-a818-f6e899076993@seco.com>
Date: Tue, 6 Feb 2024 12:08:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] board: Add support for Conclusive WHLE-LS1088A
Content-Language: en-US
To: Artur Rojek <artur@conclusive.pl>, Peng Fan <peng.fan@nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass
 <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de
References: <20231128103457.45802-1-artur@conclusive.pl>
 <20231128103457.45802-4-artur@conclusive.pl>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231128103457.45802-4-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM7PR03MB6465:EE_|AM6EUR05FT036:EE_|AS8PR03MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: fd17b4fd-6349-4c63-3c4f-08dc27364f7f
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y9ut0LMs5hfb+Uw/mFGWbH1iO3lCdU3DsRXOU1WdyLli+6yOIYkS/4n39LHnEsaZ+WsfxZ2iB3Pu83QAUXaX/J9EPJqywKpiRaMFrR04aC29XRvn7gW9XEzdSgEhHejjWun6boQovN84vJgl7PpIBci3JQCQUQmoq4op4q3WLeMbGiWzzTlI4JYNrGS0R12M1/IodjcwuE0XqMFSpyzDiKdp6/PgbATv0vjsHyOKj1OnD8jUof45Sar74Nu4t2Ox0D9W23mqf9RLFKjeXpmp0ScFjAmRJ2EBPUF5ui3c9yTkVl9nPp1VWpXeCQK2pNs/Sh5PqYWkLSniSBteaT32rZtj2AeceGBWNZ4v5YhaJvVqqfITKVsXjzWNhz5CT5tar66Tl/5xxPUCK75vjfE4fhYSbFQrf1bzIqV9+cW+g1GDO7T703IBq2UsPzhVZMCjXR+bcqaJcjUxMyq/cDupiL093jBqDOszkGuIQ9q8lXnuVG+zcfa2oiRu3Vr5qm71G0LY1vVp9ATXDjq+ASa7l6I1L99wiozYLbeG1z29YgoqVXq+gOsj0YCiSDHskfOzSny72k9Yo1MWo2B/1nm8H/pwopu8pEg4nNqci5BN0YtUO6H9sQEjd0x6CdlP2mcMGXiprQO0KYsBGNOXt0WLxJSWYwNT89Jr5s+n3nSu2ag=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(66946007)(31686004)(6666004)(30864003)(54906003)(110136005)(5660300002)(2906002)(44832011)(31696002)(36756003)(8676002)(66476007)(316002)(4326008)(6486002)(66556008)(8936002)(86362001)(478600001)(38350700005)(41300700001)(38100700002)(966005)(6506007)(53546011)(2616005)(52116002)(83380400001)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6465
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bcd1fbbf-f3c4-45a1-ef3d-08dc27364a38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WCVNkWI+mTBHNGBJRweoQpsCI5bW1V1JCVhPXFvzKiRIwB4rFFLBL8YdS1IEOQyOqlPJg/CBGGZxUtUp7m4H/X3bYWH/j8P1d1gAIGOfxXJqw0/BEuNSQQQR6SYlS/h3ZkYmdJ7S1RCh2jD7GjIhaoHHA02Sr8/3BbP73VsJJ+uzJKzlnx9UqJIaLZ9YXB9L7kpA2HZ4FaqMCdX709XgH94xDNP2+vwz7H80qXZ8iY7dPgypDTenY9/EQo4Xr+Wl/D/0ZSKrQAmVQkBvGY/mZn8zNqwGvLnY2hAgoSb044R1YseRhiRhwi6O2gun18ZOlmMPfaaQ1YMz+LRZaF2Mv1JkznRyGuL6jq6G+sL+iu9+sM7rfPL+n55cfyqFT6bLY/T96afN+r5PQsvEcZhUqARYEYZ511ddgoNkmaLFnuWSI6QtN8x1woTIGCPa/RMVFlX8pnHYwt5XTQYvhaaNyzQ7KGKFV/R68Fmo52gH0JyhbSvYrwNijbOqyDutxUVuWpFByCXwVSeXswetaot6zfffl4SoivFG6zI1xm0LYSaptIk61SIFzqgXTcUY3Am4qjFjdzRnJpP8PGNwHFVstvkb2Kf57cYY5qpNtRs/TD0OFefaM54oFvMOgWTSGBBJsUFev3sqs5/9W77Cu4oCsRPVAQKTO894T0NLF2/p4hE20ZBGSw0sLqYZvOB6BzbXrRooBuqLMApYnzJ3/YTtN5u0wVryxKK6/6XuEJS81ci4fi/8CPQvmnMoe4LQGZOzVQXHCj27HW3s+euGyJZ2U49pN7rcqYGlRQ2R2gB1Nk=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(376002)(396003)(136003)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(6512007)(34070700002)(31686004)(40460700003)(47076005)(40480700001)(7596003)(7636003)(356005)(82740400003)(36860700001)(6506007)(2616005)(966005)(6486002)(31696002)(26005)(86362001)(336012)(44832011)(478600001)(83380400001)(6666004)(53546011)(36756003)(70206006)(70586007)(316002)(41300700001)(54906003)(110136005)(8676002)(4326008)(8936002)(5660300002)(2906002)(30864003)(43740500002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:08:59.4754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd17b4fd-6349-4c63-3c4f-08dc27364f7f
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6757
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

On 11/28/23 05:34, Artur Rojek wrote:
> Introduce support for Conclusive WHLE-LS1088A Single Board Computer.
> 
> Co-developed-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
> 
> v3: new patch
> 
>  arch/arm/Kconfig                              |  19 ++
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi     |   8 +
>  arch/arm/dts/fsl-ls1088a-whle.dts             | 235 ++++++++++++++
>  board/conclusive/whle-ls1088a/Kconfig         |  29 ++
>  board/conclusive/whle-ls1088a/MAINTAINERS     |  11 +
>  board/conclusive/whle-ls1088a/Makefile        |   7 +
>  board/conclusive/whle-ls1088a/ddr.c           | 134 ++++++++
>  board/conclusive/whle-ls1088a/ddr.h           |  47 +++
>  board/conclusive/whle-ls1088a/eth.c           |  13 +
>  board/conclusive/whle-ls1088a/whle-ls1088a.c  | 301 ++++++++++++++++++
>  .../conclusive/whle-ls1088a/whle-ls1088a.env  |  13 +
>  configs/whle_ls1088a_emmc_defconfig           |  84 +++++
>  configs/whle_ls1088a_qspi_defconfig           |  84 +++++
>  include/configs/whle_ls1088a.h                |  92 ++++++
>  15 files changed, 1078 insertions(+)
>  create mode 100644 arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi
>  create mode 100644 arch/arm/dts/fsl-ls1088a-whle.dts
>  create mode 100644 board/conclusive/whle-ls1088a/Kconfig
>  create mode 100644 board/conclusive/whle-ls1088a/MAINTAINERS
>  create mode 100644 board/conclusive/whle-ls1088a/Makefile
>  create mode 100644 board/conclusive/whle-ls1088a/ddr.c
>  create mode 100644 board/conclusive/whle-ls1088a/ddr.h
>  create mode 100644 board/conclusive/whle-ls1088a/eth.c
>  create mode 100644 board/conclusive/whle-ls1088a/whle-ls1088a.c
>  create mode 100644 board/conclusive/whle-ls1088a/whle-ls1088a.env
>  create mode 100644 configs/whle_ls1088a_emmc_defconfig
>  create mode 100644 configs/whle_ls1088a_qspi_defconfig
>  create mode 100644 include/configs/whle_ls1088a.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 609571e6e421..cd53fcaac883 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1869,6 +1869,24 @@ config TARGET_WHLE_LS1046A
>  	  Layerscape Architecture processor:
>  	  https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fconclusive.tech%2fproducts%2fwhle%2dls1%2dsbc%2f&umid=54a8c79f-0cf2-4f48-aefc-d35c76864d4f&auth=d807158c60b7d2502abde8a2fc01f40662980862-cf53e7a0650a67cfac22b122ae0b3fcf9018c729
>  
> +config TARGET_WHLE_LS1088A
> +	bool "Support Conclusive WHLE-LS1088A"
> +	select ARCH_LS1088A
> +	select ARM64
> +	select ARMV8_MULTIENTRY
> +	select ARCH_SUPPORT_TFABOOT
> +	select BOARD_EARLY_INIT_F
> +	select BOARD_LATE_INIT
> +	select GPIO_EXTRA_HEADER
> +	select DM_SPI_FLASH if DM_SPI
> +	imply SCSI
> +	help
> +	  Support for Conclusive WHLE-LS1088A platform.
> +	  The WHLE-LS1088A is a high-performance Single Board Computer with
> +	  extensive connectivity features that supports the QorIQ LS1088A
> +	  Layerscape Architecture processor:
> +	  https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fconclusive.tech%2fproducts%2fwhle%2dls1%2dsbc%2f&umid=54a8c79f-0cf2-4f48-aefc-d35c76864d4f&auth=d807158c60b7d2502abde8a2fc01f40662980862-cf53e7a0650a67cfac22b122ae0b3fcf9018c729
> +
>  config TARGET_TEN64
>  	bool "Support ten64"
>  	select ARCH_LS1088A
> @@ -2318,6 +2336,7 @@ source "board/broadcom/bcmns/Kconfig"
>  source "board/broadcom/bcmns3/Kconfig"
>  source "board/cavium/thunderx/Kconfig"
>  source "board/conclusive/whle-ls1046a/Kconfig"
> +source "board/conclusive/whle-ls1088a/Kconfig"
>  source "board/eets/pdu001/Kconfig"
>  source "board/emulation/qemu-arm/Kconfig"
>  source "board/freescale/ls2080aqds/Kconfig"
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 8dcbf29df363..b0782b4f29bc 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -591,6 +591,7 @@ dtb-$(CONFIG_FSL_LSCH3) += fsl-ls2080a-qds.dtb \
>  	fsl-ls1088a-qds.dtb \
>  	fsl-ls1088a-qds-21-x.dtb \
>  	fsl-ls1088a-qds-29-x.dtb \
> +	fsl-ls1088a-whle.dtb \
>  	fsl-ls1028a-rdb.dtb \
>  	fsl-ls1028a-qds-duart.dtb \
>  	fsl-ls1028a-qds-lpuart.dtb \
> diff --git a/arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi
> new file mode 100644
> index 000000000000..bbe93a1d6e4f
> --- /dev/null
> +++ b/arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR X11
> +/*
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <config.h>
> +
> +#include "fsl-ls1088a-u-boot.dtsi"
> diff --git a/arch/arm/dts/fsl-ls1088a-whle.dts b/arch/arm/dts/fsl-ls1088a-whle.dts
> new file mode 100644
> index 000000000000..76ef1c748059
> --- /dev/null
> +++ b/arch/arm/dts/fsl-ls1088a-whle.dts
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR X11
> +/*
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1088a.dtsi"
> +
> +/ {
> +	model = "Conclusive WHLE-LS1088A";
> +	compatible = "conclusive,whle-ls1088a", "fsl,ls1088a";
> +
> +	chosen {
> +		stdout-path = &duart0;
> +	};
> +
> +	aliases {
> +		spi0 = &qspi;
> +	};
> +};
> +
> +&dpmac1 {
> +	status = "okay";

Not necessary.

> +	phy-connection-type = "10gbase-r";

Are you missing managed/sfp properties?

> +};
> +
> +&dpmac2 {
> +	status = "okay";
> +	phy-connection-type = "10gbase-r";
> +};
> +
> +&dpmac3 {
> +	status = "okay";
> +	phy-handle = <&sgmii_phy3>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&dpmac4 {
> +	status = "okay";
> +	phy-handle = <&rgmii_phy0>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dpmac5 {
> +	status = "okay";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dpmac6 {
> +	status = "disabled";
> +};
> +
> +&dpmac7 {
> +	status = "okay";
> +	phy-handle = <&sgmii_phy2>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&dpmac8 {
> +	status = "disabled";
> +};
> +
> +&dpmac9 {
> +	status = "disabled";
> +};
> +
> +&dpmac10 {
> +	status = "disabled";
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	rgmii_phy0: ethernet-phy@1 {
> +		reg = <0x1>;

Missing compatibles.

> +	};
> +
> +	rgmii_phy1: ethernet-phy@2 {
> +		reg = <0x2>;
> +	};
> +
> +	sgmii_phy2: ethernet-phy@3 {
> +		reg = <0x3>;
> +	};
> +
> +	sgmii_phy3: ethernet-phy@4 {
> +		reg = <0x4>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	spd@50 {
> +		compatible = "spd";
> +		reg = <0x50>;
> +		status = "okay";
> +	};
> +
> +	eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +		status = "okay";
> +	};
> +
> +	eeprom@57 {
> +		compatible = "24c01";
> +		reg = <0x57>;
> +		status = "okay";
> +	};
> +
> +	leds@62 {
> +		compatible = "nxp,pca9633";
> +		reg = <0x62>;
> +		status = "okay";
> +	};
> +
> +	rtc@6f {
> +		compatible = "microchip,mcp7941x";
> +		reg = <0x6f>;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		status = "okay";
> +
> +		pcie0_i2c: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		sfp0_i2c: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		sfp1_i2c: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		ext_i2c: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&qspi {
> +	status = "okay";
> +
> +	gd25lq128: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +
> +		partitions {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fixed-partitions";
> +
> +			partition@0 {
> +				label = "bl2";
> +				reg = <0 0x100000>;
> +			};
> +
> +			partition@100000 {
> +				label = "fip1";
> +				reg = <0x100000 0x400000>;
> +			};
> +
> +			partition@500000 {
> +				label = "fip2";
> +				reg = <0x500000 0x400000>;
> +			};
> +
> +			partition@900000 {
> +				label = "uboot-env";
> +				reg = <0x900000 0x10000>;
> +			};
> +
> +			partition@910000 {
> +				label = "mc-firmware";
> +				reg = <0x910000 0x200000>;
> +			};
> +
> +			partition@b10000 {
> +				label = "dpc";
> +				reg = <0xb10000 0x10000>;
> +			};
> +
> +			partition@b20000 {
> +				label = "dpl";
> +				reg = <0xb20000 0x10000>;
> +			};
> +
> +			partition@b30000 {
> +				label = "dtb";
> +				reg = <0xb30000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&esdhc {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> diff --git a/board/conclusive/whle-ls1088a/Kconfig b/board/conclusive/whle-ls1088a/Kconfig
> new file mode 100644
> index 000000000000..3111ccc84e0c
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/Kconfig
> @@ -0,0 +1,29 @@
> +if TARGET_WHLE_LS1088A
> +
> +config SYS_BOARD
> +	default "whle-ls1088a"
> +
> +config SYS_VENDOR
> +	default "conclusive"
> +
> +config SYS_SOC
> +	default "fsl-layerscape"
> +
> +config SYS_CONFIG_NAME
> +	default "whle_ls1088a"
> +
> +if FSL_LS_PPA
> +config SYS_LS_PPA_FW_ADDR
> +        hex "PPA Firmware Addr"
> +	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP
> +	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
> +
> +if CHAIN_OF_TRUST
> +config SYS_LS_PPA_ESBC_ADDR
> +	hex "PPA Firmware HDR Addr"
> +	default 0x20680000 if SYS_LS_PPA_FW_IN_XIP
> +	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
> +endif
> +endif
> +
> +endif
> diff --git a/board/conclusive/whle-ls1088a/MAINTAINERS b/board/conclusive/whle-ls1088a/MAINTAINERS
> new file mode 100644
> index 000000000000..49a3c5616969
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/MAINTAINERS
> @@ -0,0 +1,11 @@
> +WHLE-LS1088A Board
> +M:	Jakub Klama <jakub@conclusive.pl>
> +M:	Artur Rojek <artur@conclusive.pl>
> +S:	Maintained
> +F:	board/conclusive/whle-ls1088a
> +F:	include/configs/whle-ls1088a.h
> +F:	configs/whle_ls1088a_emmc_defconfig
> +F:	configs/whle_ls1088a_qspi_defconfig
> +F:	arch/arm/dts/fsl-ls1088a-whle.dts
> +F:	arch/arm/dts/fsl-ls1088a-whle-u-boot.dtsi
> +
> diff --git a/board/conclusive/whle-ls1088a/Makefile b/board/conclusive/whle-ls1088a/Makefile
> new file mode 100644
> index 000000000000..9c37d961c433
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2020-2023 Conclusive Engineering Sp. z o. o.
> +
> +obj-y += whle-ls1088a.o
> +obj-y += eth.o
> +obj-y += ddr.o
> diff --git a/board/conclusive/whle-ls1088a/ddr.c b/board/conclusive/whle-ls1088a/ddr.c
> new file mode 100644
> index 000000000000..be0f9669177c
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/ddr.c

Why are you using SPL on this board but not the other one?

> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 NXP
> + * Copyright (C) 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <config.h>
> +#include <fsl_ddr_sdram.h>
> +#include <fsl_ddr_dimm_params.h>
> +#include <log.h>
> +#include <asm/arch/soc.h>
> +#include <asm/arch/clock.h>
> +#include <asm/global_data.h>
> +#include "ddr.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
> +static void fsl_ddr_setup_0v9_volt(memctl_options_t *popts)
> +{
> +	int vdd;
> +
> +	vdd = get_core_volt_from_fuse();
> +	if (vdd < 0)
> +		return;
> +
> +	if (vdd == 900) {
> +		popts->ddr_cdr1 |= DDR_CDR1_V0PT9_EN;
> +		debug("VID: configure DDR to support 900 mV\n");
> +	}
> +}
> +#endif
> +
> +void fsl_ddr_board_options(memctl_options_t *popts,
> +			   dimm_params_t *pdimm,
> +			   unsigned int ctrl_num)
> +{
> +	const struct board_specific_parameters *pbsp, *pbsp_highest = NULL;
> +	ulong ddr_freq;
> +
> +	if (ctrl_num > 1) {
> +		printf("Not supported controller number %d\n", ctrl_num);
> +		return;
> +	}
> +	if (!pdimm->n_ranks)
> +		return;
> +
> +	/*
> +	 * we use identical timing for all slots. If needed, change the code
> +	 * to pbsp = rdimms[ctrl_num] or pbsp = udimms[ctrl_num];
> +	 */
> +	pbsp = udimms[0];
> +
> +	/* Get clk_adjust, wrlvl_start, wrlvl_ctl, according to the board ddr
> +	 * frequency and n_banks specified in board_specific_parameters table.
> +	 */
> +	ddr_freq = get_ddr_freq(0) / 1000000;
> +	while (pbsp->datarate_mhz_high) {
> +		if (pbsp->n_ranks == pdimm->n_ranks) {
> +			if (ddr_freq <= pbsp->datarate_mhz_high) {
> +				popts->clk_adjust = pbsp->clk_adjust;
> +				popts->wrlvl_start = pbsp->wrlvl_start;
> +				popts->wrlvl_ctl_2 = pbsp->wrlvl_ctl_2;
> +				popts->wrlvl_ctl_3 = pbsp->wrlvl_ctl_3;

Do you need to set this based on the frequency? These are just initial values, so almost anything can work. I use e.g. 

	popts->wrlvl_start = 0x08; /* 1 clock delay */
	popts->wrlvl_ctl_2 = popts->wrlvl_start * 0x01010101;
	popts->wrlvl_ctl_3 = popts->wrlvl_start * 0x01010101;

which is the same as on one of the FRWY designs.

> +				goto found;
> +			}
> +			pbsp_highest = pbsp;
> +		}
> +		pbsp++;
> +	}
> +
> +	if (!pbsp_highest)
> +		panic("DIMM is not supported by this board");
> +
> +	printf("Error: board specific timing not found for %lu MT/s\n",
> +	       ddr_freq);
> +	printf("Trying to use the highest speed (%u) parameters\n",
> +	       pbsp_highest->datarate_mhz_high);
> +	popts->clk_adjust = pbsp_highest->clk_adjust;
> +	popts->wrlvl_start = pbsp_highest->wrlvl_start;
> +	popts->wrlvl_ctl_2 = pbsp->wrlvl_ctl_2;
> +	popts->wrlvl_ctl_3 = pbsp->wrlvl_ctl_3;
> +
> +found:
> +	debug("Found timing match: n_ranks %d, data rate %d, rank_gb %d\n"
> +		"\tclk_adjust %d, wrlvl_start %d, wrlvl_ctrl_2 0x%x, wrlvl_ctrl_3 0x%x\n",
> +		pbsp->n_ranks, pbsp->datarate_mhz_high, pbsp->rank_gb,
> +		pbsp->clk_adjust, pbsp->wrlvl_start, pbsp->wrlvl_ctl_2,
> +		pbsp->wrlvl_ctl_3);
> +
> +	popts->half_strength_driver_enable = 0;
> +
> +	/* Write leveling override */
> +	popts->wrlvl_override = 1;
> +	popts->wrlvl_sample = 0xf;
> +
> +	/* Enable ZQ calibration */
> +	popts->zq_en = 1;
> +
> +	/* Enable DDR hashing */
> +	popts->addr_hash = 1;
> +
> +	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_60ohm);
> +#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
> +	fsl_ddr_setup_0v9_volt(popts);
> +#endif
> +
> +	popts->ddr_cdr2 = DDR_CDR2_ODT(DDR_CDR_ODT_60ohm) |
> +			  DDR_CDR2_VREF_TRAIN_EN | DDR_CDR2_VREF_RANGE_2;
> +}
> +
> +#ifdef CONFIG_TFABOOT
> +int fsl_initdram(void)
> +{
> +	gd->ram_size = tfa_get_dram_size();
> +
> +	if (!gd->ram_size)
> +		gd->ram_size = fsl_ddr_sdram_size();
> +
> +	return 0;
> +}
> +#else
> +int fsl_initdram(void)
> +{
> +	puts("Initializing DDR....using SPD\n");
> +
> +#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
> +	gd->ram_size = fsl_ddr_sdram_size();
> +#else
> +	gd->ram_size = fsl_ddr_sdram();
> +#endif
> +	return 0;
> +}
> +#endif /* CONFIG_TFABOOT */
> diff --git a/board/conclusive/whle-ls1088a/ddr.h b/board/conclusive/whle-ls1088a/ddr.h
> new file mode 100644
> index 000000000000..462c5cfe6b06
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/ddr.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2017 NXP
> + */
> +
> +#ifndef __LS1088A_DDR_H__
> +#define __LS1088A_DDR_H__
> +struct board_specific_parameters {
> +	u32 n_ranks;
> +	u32 datarate_mhz_high;
> +	u32 rank_gb;
> +	u32 clk_adjust;
> +	u32 wrlvl_start;
> +	u32 wrlvl_ctl_2;
> +	u32 wrlvl_ctl_3;
> +};
> +
> +/*
> + * These tables contain all valid speeds we want to override with board
> + * specific parameters. datarate_mhz_high values need to be in ascending order
> + * for each n_ranks group.
> + */
> +
> +static const struct board_specific_parameters udimm0[] = {
> +	/*
> +	 * memory controller 0
> +	 *   num|  hi| rank|  clk| wrlvl |   wrlvl   |  wrlvl
> +	 * ranks| mhz| GB  |adjst| start |   ctl2    |  ctl3
> +	 */
> +#if defined(CONFIG_TARGET_LS1088ARDB)

This will never be true. So what's the point?

> +	{2,  1666, 0, 8,     8, 0x090A0B0E, 0x0F10110D,},
> +	{2,  1900, 0, 8,     9, 0x0A0B0C10, 0x1112140E,},
> +	{2,  2300, 0, 8,     9, 0x0A0C0E11, 0x1214160F,},
> +	{}
> +#elif defined(CONFIG_TARGET_LS1088AQDS)
> +	{2,  1666, 0, 8,     8, 0x0A0A0C0E, 0x0F10110C,},
> +	{2,  1900, 0, 8,     9, 0x0A0B0C10, 0x1112140E,},
> +	{2,  2300, 0, 4,     9, 0x0A0C0D11, 0x1214150E,},
> +	{}
> +
> +#endif
> +};
> +
> +static const struct board_specific_parameters *udimms[] = {
> +	udimm0,
> +};
> +#endif
> diff --git a/board/conclusive/whle-ls1088a/eth.c b/board/conclusive/whle-ls1088a/eth.c
> new file mode 100644
> index 000000000000..fb6f9c1a813f
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/eth.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2017 NXP
> + */
> +
> +#include <fsl-mc/fsl_mc.h>
> +
> +#if defined(CONFIG_RESET_PHY_R)
> +void reset_phy(void)
> +{
> +	mc_env_boot();
> +}
> +#endif /* CONFIG_RESET_PHY_R */
> diff --git a/board/conclusive/whle-ls1088a/whle-ls1088a.c b/board/conclusive/whle-ls1088a/whle-ls1088a.c
> new file mode 100644
> index 000000000000..dab367f85145
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/whle-ls1088a.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * whle-ls1088a.c - Board init file for Conclusive WHLE-LS1088A board
> + * Copyright (C) 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <config.h>
> +#include <display_options.h>
> +#include <env.h>
> +#include <i2c.h>
> +#include <init.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <errno.h>
> +#include <netdev.h>
> +#include <fsl_ifc.h>
> +#include <fsl_ddr.h>
> +#include <fsl_sec.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <fdt_support.h>
> +#include <linux/delay.h>
> +#include <linux/libfdt.h>
> +#include <fsl-mc/fsl_mc.h>
> +#include <env_internal.h>
> +#include <asm/arch-fsl-layerscape/soc.h>
> +#include <hwconfig.h>
> +#include <asm/arch/fsl_serdes.h>
> +#include <asm/arch/soc.h>
> +#include <asm/arch-fsl-layerscape/fsl_icid.h>
> +#include <fsl_immap.h>
> +
> +#define	BOARD_REV_MASK	0x0f
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_early_init_f(void)
> +{
> +	fsl_lsch3_early_init_f();
> +	return 0;
> +}
> +
> +static inline uint8_t get_board_version(void)
> +{
> +	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
> +
> +	return in_be32(&gur->gpporcr1) & BOARD_REV_MASK;
> +}
> +
> +static int settings_r(void)
> +{
> +	serial_read_from_eeprom(0);
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
> +
> +#if defined(CONFIG_DISPLAY_BOARDINFO_LATE)
> +int checkboard(void)
> +{
> +	const char *serial_number = env_get("serial#");
> +
> +	printf("Board: WHLE-LS1088A, Rev: %s\n",
> +	       get_board_version() == 0x00 ? "0" : "unknown");
> +
> +	if (!serial_number)
> +		printf("Warning: unknown serial number.\n");
> +	else
> +		printf("S/N:   %s\n", serial_number);
> +
> +	return 0;
> +}
> +#endif
> +
> +unsigned long get_board_sys_clk(void)
> +{
> +	return CONFIG_SYS_CLK_FREQ;
> +}
> +
> +unsigned long get_board_ddr_clk(void)
> +{
> +	return CONFIG_DDR_CLK_FREQ;
> +}
> +
> +#ifdef CONFIG_MISC_INIT_R
> +int misc_init_r(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#if !defined(CONFIG_SPL_BUILD)
> +int board_init(void)
> +{
> +#ifdef CONFIG_FSL_CAAM
> +	sec_init();
> +#endif
> +
> +#if !defined(CONFIG_SYS_EARLY_PCI_INIT)
> +	pci_init();
> +#endif
> +
> +	return 0;
> +}
> +
> +void detail_board_ddr_info(void)
> +{
> +	puts("\nDDR:   ");
> +	print_size(gd->bd->bi_dram[0].size + gd->bd->bi_dram[1].size, "");
> +	print_ddr_info(0);
> +}
> +
> +#ifdef CONFIG_FSL_MC_ENET
> +void board_quiesce_devices(void)
> +{
> +	fsl_mc_ldpaa_exit(gd->bd);
> +}
> +
> +void fdt_fixup_board_enet(void *fdt)
> +{
> +	int offset;
> +
> +	offset = fdt_path_offset(fdt, "/fsl-mc");
> +
> +	if (offset < 0)
> +		offset = fdt_path_offset(fdt, "/soc/fsl-mc");
> +
> +	if (offset < 0) {
> +		printf("%s: ERROR: fsl-mc node not found in device tree (error %d)\n",
> +		       __func__, offset);
> +		return;
> +	}
> +
> +	if (get_mc_boot_status() == 0 &&
> +	    (is_lazy_dpl_addr_valid() || get_dpl_apply_status() == 0))
> +		fdt_status_okay(fdt, offset);
> +	else
> +		fdt_status_fail(fdt, offset);
> +}
> +#endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +void fsl_fdt_fixup_flash(void *fdt)
> +{
> +	int offset;
> +#ifdef CONFIG_TFABOOT
> +	u32 __iomem *dcfg_ccsr = (u32 __iomem *)DCFG_BASE;
> +	u32 val;
> +#endif
> +
> +/*
> + * IFC-NOR and QSPI are muxed on SoC.
> + * So disable IFC node in dts if QSPI is enabled or
> + * disable QSPI node in dts in case QSPI is not enabled.
> + */
> +
> +#ifdef CONFIG_TFABOOT
> +	enum boot_src src = get_boot_src();
> +	bool disable_ifc = false;
> +
> +	switch (src) {
> +	case BOOT_SOURCE_IFC_NOR:
> +		disable_ifc = false;
> +		break;
> +	case BOOT_SOURCE_QSPI_NOR:
> +		disable_ifc = true;
> +		break;
> +	default:
> +		val = in_le32(dcfg_ccsr + DCFG_RCWSR15 / 4);
> +		if (DCFG_RCWSR15_IFCGRPABASE_QSPI == (val & 0x3))
> +			disable_ifc = true;
> +		break;
> +	}
> +
> +	if (disable_ifc) {
> +		offset = fdt_path_offset(fdt, "/soc/ifc/nor");
> +
> +		if (offset < 0)
> +			offset = fdt_path_offset(fdt, "/ifc/nor");
> +	} else {
> +		offset = fdt_path_offset(fdt, "/soc/quadspi");
> +
> +		if (offset < 0)
> +			offset = fdt_path_offset(fdt, "/quadspi");
> +	}
> +
> +#else
> +#ifdef CONFIG_FSL_QSPI
> +	offset = fdt_path_offset(fdt, "/soc/ifc/nor");
> +
> +	if (offset < 0)
> +		offset = fdt_path_offset(fdt, "/ifc/nor");
> +#else
> +	offset = fdt_path_offset(fdt, "/soc/quadspi");
> +
> +	if (offset < 0)
> +		offset = fdt_path_offset(fdt, "/quadspi");
> +#endif
> +#endif
> +	if (offset < 0)
> +		return;
> +
> +	fdt_status_disabled(fdt, offset);
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	u16 total_memory_banks, mc_memory_bank = 0;
> +	u64 *base, *size, mc_memory_base = 0, mc_memory_size = 0;
> +	int i;
> +
> +	ft_cpu_setup(blob, bd);
> +
> +	fdt_fixup_mc_ddr(&mc_memory_base, &mc_memory_size);
> +
> +	if (mc_memory_base != 0)
> +		mc_memory_bank++;
> +
> +	total_memory_banks = CONFIG_NR_DRAM_BANKS + mc_memory_bank;
> +
> +	base = calloc(total_memory_banks, sizeof(u64));
> +	size = calloc(total_memory_banks, sizeof(u64));
> +
> +	/* fixup DT for the two GPP DDR banks */
> +	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		base[i] = gd->bd->bi_dram[i].start;
> +		size[i] = gd->bd->bi_dram[i].size;
> +	}
> +
> +#ifdef CONFIG_RESV_RAM
> +	/* reduce size if reserved memory is within this bank */
> +	if (gd->arch.resv_ram >= base[0] &&
> +	    gd->arch.resv_ram < base[0] + size[0])
> +		size[0] = gd->arch.resv_ram - base[0];
> +	else if (gd->arch.resv_ram >= base[1] &&
> +		 gd->arch.resv_ram < base[1] + size[1])
> +		size[1] = gd->arch.resv_ram - base[1];
> +#endif
> +
> +	if (mc_memory_base != 0) {
> +		for (i = 0; i <= total_memory_banks; i++) {
> +			if (base[i] == 0 && size[i] == 0) {
> +				base[i] = mc_memory_base;
> +				size[i] = mc_memory_size;
> +				break;
> +			}
> +		}
> +	}
> +
> +	fdt_fixup_memory_banks(blob, base, size, total_memory_banks);
> +
> +	fdt_fsl_mc_fixup_iommu_map_entry(blob);
> +
> +	fsl_fdt_fixup_flash(blob);
> +
> +#ifdef CONFIG_FSL_MC_ENET
> +	fdt_fixup_board_enet(blob);
> +#endif
> +
> +	fdt_fixup_icid(blob);
> +
> +	return 0;
> +}
> +#endif
> +#endif /* !defined(CONFIG_SPL_BUILD) */
> +
> +#ifdef CONFIG_TFABOOT
> +#ifdef CONFIG_MTD_NOR_FLASH
> +int is_flash_available(void)
> +{
> +	char *env_hwconfig = env_get("hwconfig");
> +	enum boot_src src = get_boot_src();
> +	int is_nor_flash_available = 1;
> +
> +	switch (src) {
> +	case BOOT_SOURCE_IFC_NOR:
> +		is_nor_flash_available = 1;
> +		break;
> +	case BOOT_SOURCE_QSPI_NOR:
> +		is_nor_flash_available = 0;
> +		break;
> +	/*
> +	 * In Case of SD boot,if qspi is defined in env_hwconfig
> +	 * disable nor flash probe.
> +	 */
> +	default:
> +		if (hwconfig_f("qspi", env_hwconfig))
> +			is_nor_flash_available = 0;
> +		break;
> +	}
> +	return is_nor_flash_available;
> +}
> +#endif
> +
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +void *env_sf_get_env_addr(void)
> +{
> +	return (void *)(CFG_SYS_FSL_QSPI_BASE + CONFIG_ENV_OFFSET);
> +}
> +#endif
> +#endif
> diff --git a/board/conclusive/whle-ls1088a/whle-ls1088a.env b/board/conclusive/whle-ls1088a/whle-ls1088a.env
> new file mode 100644
> index 000000000000..f48d4800f3a0
> --- /dev/null
> +++ b/board/conclusive/whle-ls1088a/whle-ls1088a.env
> @@ -0,0 +1,13 @@
> +hwconfig=fsl_ddr:bank_intlv=auto
> +kernel_addr_r=0x81000000
> +kernel_size=0x07000000
> +kernel_comp_addr_r=0x88000000
> +kernel_comp_size=0x04000000
> +ramdisk_addr_r=0x90000000
> +ramdisk_size=0x08000000
> +fdt_addr_r=0x98000000
> +pxefile_addr_r=0x99000000
> +scriptaddr=0x9a000000
> +fdtfile=fsl-ls1088a-whle.dtb
> +console=ttyS0,115200
> +mcmemsize=0x70000000
> diff --git a/configs/whle_ls1088a_emmc_defconfig b/configs/whle_ls1088a_emmc_defconfig
> new file mode 100644
> index 000000000000..a7b2744b8639
> --- /dev/null
> +++ b/configs/whle_ls1088a_emmc_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_TARGET_WHLE_LS1088A=y
> +CONFIG_TFABOOT=y
> +CONFIG_TEXT_BASE=0x82000000
> +CONFIG_SYS_MALLOC_LEN=0x202000
> +CONFIG_SYS_MALLOC_F_LEN=0x6000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1088a-whle"
> +CONFIG_QSPI_AHB_INIT=y
> +CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
> +CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
> +CONFIG_PCI=y
> +CONFIG_AHCI=y
> +CONFIG_REMAKE_ELF=y
> +CONFIG_MP=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=10
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"

Same comments regarding console/earlycon.

> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_RESET_PHY_R=y
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_DM=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_EXT4=y
> +CONFIG_ENV_EXT4_INTERFACE="mmc"
> +CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
> +CONFIG_ENV_EXT4_FILE="/boot/uboot.env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="DPMAC4@rgmii-id"
> +CONFIG_FSL_CAAM=y
> +CONFIG_DDR_ECC=y
> +CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
> +CONFIG_MPC8XXX_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_FSL_ESDHC=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHYLIB=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_E1000=y
> +CONFIG_MII=y
> +CONFIG_MDIO_MUX_I2CREG=y
> +CONFIG_NVME_PCI=y
> +CONFIG_DM_PCI_COMPAT=y
> +CONFIG_PCIE_LAYERSCAPE_RC=y
> +CONFIG_DM_SCSI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_FSL_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> diff --git a/configs/whle_ls1088a_qspi_defconfig b/configs/whle_ls1088a_qspi_defconfig
> new file mode 100644
> index 000000000000..cfde387a4068
> --- /dev/null
> +++ b/configs/whle_ls1088a_qspi_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_TARGET_WHLE_LS1088A=y
> +CONFIG_TFABOOT=y
> +CONFIG_TEXT_BASE=0x82000000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x900000
> +CONFIG_ENV_SECT_SIZE=0x1000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1088a-whle"
> +CONFIG_QSPI_AHB_INIT=y
> +CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
> +CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
> +CONFIG_PCI=y
> +CONFIG_AHCI=y
> +CONFIG_REMAKE_ELF=y
> +CONFIG_MP=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=10
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"

Ditto.

> +CONFIG_BOOTCOMMAND="sf probe; mtd read dtb $fdt_addr_r; bootflow scan -lb"
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_RESET_PHY_R=y
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_CMD_BOOTMENU=y
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_DM=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_SECT_SIZE_AUTO=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="DPMAC4@rgmii-id"
> +CONFIG_FSL_CAAM=y
> +CONFIG_DDR_ECC=y
> +CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
> +CONFIG_MPC8XXX_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_FSL_ESDHC=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHYLIB=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_E1000=y
> +CONFIG_MII=y
> +CONFIG_NVME_PCI=y
> +CONFIG_DM_PCI_COMPAT=y
> +CONFIG_PCIE_LAYERSCAPE_RC=y
> +CONFIG_DM_SCSI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_FSL_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> diff --git a/include/configs/whle_ls1088a.h b/include/configs/whle_ls1088a.h
> new file mode 100644
> index 000000000000..260643b4447d
> --- /dev/null
> +++ b/include/configs/whle_ls1088a.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#ifndef __WHLE_LS1088A_H__
> +#define __WHLE_LS1088A_H__
> +
> +#include <asm/arch/stream_id_lsch3.h>
> +#include <asm/arch/config.h>
> +#include <asm/arch/soc.h>
> +
> +/* Link Definitions */
> +#define CFG_SYS_FSL_QSPI_BASE		0x20000000
> +
> +#define CFG_SYS_DDR_SDRAM_BASE		0x80000000UL
> +#define CFG_SYS_FSL_DDR_SDRAM_BASE_PHY	0
> +#define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
> +#define CFG_SYS_DDR_BLOCK2_BASE		0x8080000000ULL
> +#define CFG_SYS_FSL_DDR_MAIN_NUM_CTRLS	1
> +
> +/* SMP Definitinos */

Definitions

> +#define CPU_RELEASE_ADDR		secondary_boot_addr
> +
> +#define COUNTER_FREQUENCY_REAL		25000000	/* 25MHz */
> +#define SPD_EEPROM_ADDRESS		0x50
> +#define CFG_SYS_LS_MC_BOOT_TIMEOUT_MS	5000
> +#define PWM_CHANNEL0                    0x0
> +
> +#define CFG_SYS_FLASH_BASE		0x580000000ULL
> +#define CFG_SYS_FLASH_BASE_PHYS		0x80000000
> +#define CFG_SYS_FLASH_BASE_PHYS_EARLY	0x00000000

Hm, shouldn't this be set in something like ls1088a.h?

(to clarify, this would be a cleanup independent of this patch)

> +/* Serial Port */
> +#define CFG_SYS_NS16550_CLK          (get_bus_freq(0) / 2)
> +
> +#define HWCONFIG_BUFFER_SIZE		128
> +
> +/* RTC configuration */
> +#ifndef SPL_NO_RTC
> +#define RTC
> +#define CFG_SYS_I2C_RTC_ADDR         0x51  /* Channel 3*/
> +#endif
> +

Use DM_RTC

> +/* TF-A */

Not TFA-related

> +#define QSPI_NOR_BOOTCOMMAND	CONFIG_BOOTCOMMAND
> +#define QSPI_NAND_BOOTCOMMAND	CONFIG_BOOTCOMMAND
> +#define SD_BOOTCOMMAND		CONFIG_BOOTCOMMAND
> +
> +/*
> + * Carve out a DDR region which will not be used by u-boot/Linux
> + *
> + * It will be used by MC and Debug Server. The MC region must be
> + * 512MB aligned, so the min size to hide is 512MB.
> + */
> +
> +#ifdef CONFIG_FSL_MC_ENET
> +#define CFG_SYS_LS_MC_DRAM_BLOCK_MIN_SIZE		(128UL * 1024 * 1024)
> +#endif
> +
> +/* MC firmware */
> +#define CFG_SYS_LS_MC_DPC_MAX_LENGTH		0x20000
> +#define CFG_SYS_LS_MC_DRAM_DPC_OFFSET		0x00F00000
> +#define CFG_SYS_LS_MC_DPL_MAX_LENGTH		0x20000
> +#define CFG_SYS_LS_MC_DRAM_DPL_OFFSET		0x00F20000
> +#define CFG_SYS_LS_MC_AIOP_IMG_MAX_LENGTH	0x200000
> +#define CFG_SYS_LS_MC_DRAM_AIOP_IMG_OFFSET	0x07000000
> +#define CFG_SYS_LS_MC_DRAM_BLOCK_MIN_SIZE	(128UL * 1024 * 1024)
> +
> +#define RESERVED_MC_INIT_CMD				\
> +	"fsl_mc start mc 0x83000000 0x84000000 && "	\
> +	"fsl_mc lazyapply DPL 0x85000000\0"
> +
> +#define QSPI_MC_INIT_CMD				\
> +	"sf probe; "					\
> +	"mtd read mc-firmware 0x83000000; "		\
> +	"mtd read dpc 0x84000000; "			\
> +	"mtd read dpl 0x85000000; "			\
> +	"fsl_mc start mc 0x83000000 0x84000000 && "	\
> +	"fsl_mc lazyapply DPL 0x85000000\0"
> +
> +#define SD_MC_INIT_CMD					\
> +	"mmcinfo;"					\
> +	"mmc read 0x83000000 0x5000 0x2000 && "		\
> +	"mmc read 0x84000000 0x7000 0x100 && "		\
> +	"mmc read 0x85000000 0x6800 0x100 && "		\

Why not just use files? You have an MMC with a filesystem on it...

> +	"fsl_mc start mc 0x83000000 0x84000000 && "	\
> +	"fsl_mc lazyapply DPL 0x85000000\0"
> +
> +#include <asm/fsl_secure_boot.h>
> +
> +#endif /* __WHLE_LS1088A_H__ */

