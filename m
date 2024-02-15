Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1D0C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 19:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756A687DC1;
	Thu, 15 Feb 2024 20:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jO/NgIRN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="YobYVno5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2007287DC1; Thu, 15 Feb 2024 20:31:51 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB61870C4
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 20:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=A8zZzm9VJmL5wmslCZWO1XFtqh/K/D10mEi3j/6KMqWYZmzeXtKmK+TsnlcOlGwYnI+kexHM1ucc3U+8AUQ9MeKxuJm0G7n/C57n/MYJKjb/nqNa29cgl7g7yJSoaLULdoRDgpJgf8mbsdU9kOsttR3i9FSj96vX1MKKSSWAKTVi8baO34PZw1g3XME/nsajBRgS+UauPydxq/gBYEMKMB72RJ1K4UX2Xg306+sj58Hcs9KJdBaiE3G965tN7e4ii8kHWjXE0Kdjfv/mfsl7/Dgnf+XO8b/kk1Ili1CUWESI8NDoa4bvxN1E8jaKrKgz3jzW/8yaeKktQX1r5Km6Ew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzYXCgTzkIVtHMnGJFOeImgUs4+hm019ygxOB9RM9wQ=;
 b=nhiO9DTX3FTmb0s5INzdhWI0UE0okAwqMEUQSmA5oE3ESGbfQFEn7meCZ3pELt8wTg3pCeJ3CrMJbzxfcIe3nNR5gGpU7fkNVhLE4Jc/KinfyHBX4upP73JWv6XcSqaQBTbope3pTrOfLtDcRITI4fJEVayr5yRnB6AosoZRtYkGJYFbBHPckDaiGgm1gGphdLH8LAdjCtyOFPbZiPyHEsIoGLb2I51SbcdrGZ52FoTeBsdAfO5e3Ry5iUTfWhgv2iZtVcnxQqBtcSPFWLhK3oNg9t4aJdi3Q3o9oQUYKsTn6njek8HITR9XuAOYK5rhFctnymjS7QbAWAgmjMoptg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzYXCgTzkIVtHMnGJFOeImgUs4+hm019ygxOB9RM9wQ=;
 b=jO/NgIRNqi/yXlxV+uBbNodwa5K08rTEaOvKRmRvN/is6/wT3AFHcvK18CA2yZOMVKpj0AQLSbXvJrfVQD5dewK/RUtZi37xqwSJAQyuzZAai8d1C2ciq5v4yYOKPoil3QX2RgIti3Go28n9d/ilNahC2Dp1zeftQj22eyKHHS9MgaQNXZmI95V5o+1LzMP+IwPKSlvDhXZtTOp8iaPhVAHjh9P+fTbWNkSBWI8ElDO4RWEEucRJZ+24JKTG+vN2+/IpmMtwHKq15q7aR5CMNazo/ZO0Q760eggaTvoincMJw4UVVAGAzFeW98amNVBblvaLzuk09PXTiIgpa0uAcw==
Received: from AS8P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::13)
 by DU2PR03MB9919.eurprd03.prod.outlook.com (2603:10a6:10:499::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:31:43 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::16) by AS8P250CA0008.outlook.office365.com
 (2603:10a6:20b:330::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 19:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:31:42 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 A75572009538A; Thu, 15 Feb 2024 19:31:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.13.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 1AB412008006E; 
 Thu, 15 Feb 2024 19:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN9V5ta1ZO1WMMdR+RGR7XuxHiMi1aP9hZGhWWadFXPFYWBpcwisQtM4Gl1xbgu4JzQQcTOBUwW6UE/nICqG9c0CihmtF9uPsrzaAwWr4KzWSqffAQw5m7lzilCq+9bvdhwn5+SQW/yoMMqrdOpA35FJ6v1b7Z2NTSGH+iCJXg5515ifKPRfpZOCJtLVUFdBRpDqfVUboWeH8gpUj/owmWlqYA/S+ovlfH2x0HDi/JsuMxoFy8j4gZwabYG0WwJnjOcvI7xxw7GgaRoivdO5cAoqAABhG1DySWytv0obd3GrSO3VuLuANsDD8U1z+CLvOox8TeA6whVy3ZOolhse9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62gN4jsVlttXN7aa4N29G17Oz3Xj5ydHP6faV0IU8fc=;
 b=gONOxz9UkjrBErCQOaAOPvUqDABEOFuHrA9gmYDEOf36adA+2waWCvBstX052Ou0lU3S3QSpDZTDdnX95Xvk+9yCvNwkzArL7qr/RKHouH8J5dh569x/ccbCfUOdNIAyQYBwFNcsfpSLMhKuHv2uSFTQS2s5Lb1NVIXIPRSHAgbpkrvYSJCPC6mM9k9p8P4iJa2iURah4K8NEBRDb72hPmHyi9P1dYQbEDtQgCPIPJ4QgeHc1fkYNCRqIv+tskgFhogwQlFTQRsEJaL7zg46dP8sgb6z9zG6uly9QqVae/DCOiRLks7UOngQ3x47kojf/MaAWb19eUMGwcSsEVzXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62gN4jsVlttXN7aa4N29G17Oz3Xj5ydHP6faV0IU8fc=;
 b=YobYVno5zTx4Oe9+188E+YoryODdZyyvbvrsUqyn6fDMf0le7DIUCpKxqDZVYptIfF/dZWpS5uaSh5rZC8JXF6XhP9QBjkfZzQdQbndffcfPQgjpennuauZP67uQIv2oWT5zkVdPVcsk9Dk6THWx8NsilpmNKdJ2hBKyefItyLpnOJwhWDszM2LPx1D1Os6fKIBH2VsSOu6VULEfNRVaBWI3JvblSlEPZv1s3IyveCepje3D6q0jBa8macoHHocOeuyJLB3uVaFbV7hYxw2RLKF4XKHhxZAq3afuSir36qWPIV4j06u5Vks2EV3mtWdBgCYQVoGZsH1KZynPVqYvnQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GV2PR03MB8605.eurprd03.prod.outlook.com (2603:10a6:150:ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Thu, 15 Feb
 2024 19:31:37 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:31:37 +0000
Message-ID: <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
Date: Thu, 15 Feb 2024 14:31:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:208:15e::31) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GV2PR03MB8605:EE_|AMS0EPF0000019C:EE_|DU2PR03MB9919:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e8953e-6271-4f39-ebac-08dc2e5cbd58
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SNabPnPdG4+yxk1FrTaSTfrAqo9IxQRyhyk7/tzYY5rlYX4db/kTXnSFIb4/W8wC216t6fqk+tIGOqLOEztV1j9t8bSj3Zcy9adw384526yCGOkoFr94AHrUvxmKMXtNZFXKiyboe2M4uO0GiZxfRxhaBe5864wzcy40T0RmBhhOAumgQC4a7bYTihsWTZE1MrJgwa2HOWkByMdoYJSa49p00oSxUNZWeV8S2bwD1sDSvfFkiTtjZz4uIfegFdcKUvZElVMGyTDE1iXllIsrGoy6Sx66SNPRkIuT6MM1XOq7adMGC+/MWZhF/uOWCAnEXP8BcPkR9jLxOzB22frFHugMEEgxnYrQYi/u9Xwc8Bdn1/JAezqFL7r8/27SjXxRCYKFaupE4Lg3TRxX6T+XuqcY9mimGQtWEdPQxk1eD0wJ9ySSWRCvkuff2+LPueZuXpR6LycKV+Yv0fxB6dqIYWqjfrztRhWoV2t83lpcHdrsjf0NipwE0TeeXq6lBEtOHRI3X0j3wiQf313UWJUIErJUXtYRtxFWTGRW0cEdETYUU+s6Q7tSTVom4aqJ6QnXwlEIDFms+dhyL3qX3iN6P0jZFBmLCieHqLKPH1VgGI8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(396003)(366004)(136003)(346002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(44832011)(8676002)(5660300002)(86362001)(8936002)(2906002)(38350700005)(2616005)(26005)(38100700002)(36756003)(31696002)(66946007)(316002)(66476007)(6506007)(83380400001)(53546011)(52116002)(6666004)(66556008)(478600001)(6512007)(31686004)(41300700001)(6486002)(966005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8605
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6f3535c3-b3fd-467b-bea8-08dc2e5cba0d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I72i+/a4rJFbLReuKCaFKfIQMu/1Aof2KZvWSouOCZp3umUAD1L1Td6idRT6f1dZGfzf46z1Ks2k02PCUT2vMKZXgrCrtIfDMIfIfOxYj81sgMM3SuyZsgy8UZGi3TJvlagakr30uny8oow1J9oz98pQxFw/TwfaRjYTMHk8jr0o9fZ3MwEES/yefz97OqzcN+QQnrK/hoF6eEFAwODjDDAe0xs+PtFhH3n6e1b1xtLv1r8FPkkQeCCP/UbkoVky1Ft/BjQxYxYZNpmCL5XVNbEmqiNZqkYE+iKWW2/o92gBC2VH7Cih+KRYjBwWgkPI/lRmS1/XkPmPnqVKKIy3tEMebwqwOfw3CKOY47S+1IC3TiIQKRqz7vYDQVPWjBrLGhfgu7+01NNIQOROBKw1YtNbB7je/6/HxVzM29BWMFj3qldLwfPkeC2zCVhUgpdKENRYgAlVEu2EYr/3L1kbpxNMa6IiSfFVxW4fOxFMLKW8E7715gjf9aoiD0BEhPs5jc0q5F/ttQ0AZEbxS/H4XXCCAV2I7Yos2ao/OIhfzJ4CeXdxHUwNhQsyb94DmHCK2XDJmHsJf2RZMFtm8vFZqYPSTR/aU3NUuO/T7cUnTLeQ/aKrgHittLk60wiQ+OX9zH3Zd9/8uaxPwLiWAZxDg==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39850400004)(376002)(136003)(230922051799003)(230273577357003)(1800799012)(451199024)(36860700004)(64100799003)(82310400011)(186009)(46966006)(7636003)(356005)(2906002)(7596003)(478600001)(31696002)(82740400003)(36756003)(966005)(6512007)(53546011)(6486002)(6666004)(6506007)(2616005)(26005)(336012)(83380400001)(70206006)(44832011)(70586007)(86362001)(5660300002)(316002)(31686004)(8936002)(41300700001)(8676002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:31:42.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8953e-6271-4f39-ebac-08dc2e5cbd58
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB9919
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

On 2/15/24 14:08, Michal Simek wrote:
>
>
> On 2/15/24 18:19, Sean Anderson wrote:
>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>> However, this is a bit tricky to time, since the debugger has to wait
>> for SPL to initialize RAM before it can load U-Boot. This can result in
>> long waits, since occasionally initializing RAM (and other things in
>> psu_init) takes a long time to complete and the debugger must wait for
>> this worst case.
>>
>> Support semihosting if it is enabled, as it lets U-Boot tell the
>> debugger when we are ready for the image. This means we don't have to
>> wait any more than necessary. We don't change the default config to
>> ensure we don't break compatibility with existing debuggers that don't
>> expect us to hit semihosting breakpoints.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>>   arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>> index a0f35f36faa..5af735aa5ce 100644
>> --- a/arch/arm/mach-zynqmp/spl.c
>> +++ b/arch/arm/mach-zynqmp/spl.c
>> @@ -9,6 +9,7 @@
>>   #include <image.h>
>>   #include <init.h>
>>   #include <log.h>
>> +#include <semihosting.h>
>>   #include <spl.h>
>>   #include <linux/delay.h>
>>
>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>   }
>>   #endif
>>
>> +static u32 jtag_boot_device(void)
>> +{
>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM=
;
>> +}
>> +
>>   void board_boot_order(u32 *spl_boot_list)
>>   {
>>          spl_boot_list[0] =3D spl_boot_device();
>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>          if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>                  spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>
>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>> +       spl_boot_list[2] =3D jtag_boot_device();
>>   }
>>
>>   u32 spl_boot_device(void)
>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>
>>          switch (bootmode) {
>>          case JTAG_MODE:
>> -               return BOOT_DEVICE_RAM;
>> +               return jtag_boot_device();
>>   #ifdef CONFIG_SPL_MMC
>>          case SD_MODE1:
>>          case SD1_LSHFT_MODE: /* not working on silicon v1 */
>
> Good timing. Can you please tell me how to test this? What's the setup?
> Which debugger are you using?

I am using OpenOCD with the patches at https://review.openocd.org/c/openocd=
/+/8133

My boot flow is

SPL -> ATF -> U-Boot (no FSBL)

This allows me to use a FIT which saves some time since I can
compress the bitstream. Right now I am using
xilinx_zynqmp_virt_defconfig with the following modifications:

CONFIG_SYS_LOAD_ADDR=3D0x30000000
# CONFIG_SPL_OS_BOOT is not set
CONFIG_SPL_SEMIHOSTING=3Dy

I also have CONFIG_XILINX_PS_INIT_FILE,
CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE, and CONFIG_PMUFW_INIT_FILE defined as
appropriate. I use the following FIT for U-Boot:

/dts-v1/;

/ {
    description =3D "U-Boot and ATF";
    #address-cells =3D <1>;

    images {
        atf {
            description =3D "Arm Trusted Firmware";
            data =3D /incbin/("arm-trusted-firmware.bin");
            type =3D "firmware";
            os =3D "arm-trusted-firmware";
            arch =3D "arm64";
            compression =3D "none";
            load =3D <0xfffea000>;
            entry =3D <0xfffea000>;
        };

        fpga {
            description =3D "PL Bitstream";
            data =3D /incbin/("system.bit.gz");
            type =3D "fpga";
            arch =3D "arm64";
            compression =3D "gzip";
            load =3D <0x7c000000>;
            compatible =3D "u-boot,fpga-legacy";
        };

        u-boot {
            description =3D "U-Boot";
            data =3D /incbin/("u-boot-nodtb.bin");
            type =3D "firmware";
            os =3D "u-boot";
            arch =3D "arm64";
            compression =3D "none";
            load =3D <0x00080000>;
            entry =3D <0x00080000>;
        };

        fdt {
            description =3D "U-Boot FDT";
            data =3D /incbin/("u-boot.dtb");
            type =3D "flat_dt";
            arch =3D "arm64";
            compression =3D "none";
            hash-1 {
                algo =3D "crc32";
            };
        };
    };

    configurations {
        default =3D "conf";
        conf {
            description =3D "Boot ATF and U-Boot";
            firmware =3D "atf";
            loadables =3D "u-boot", "fpga";
            fdt =3D "fdt";
        };
    };
};

Boot output looks like

U-Boot SPL 2024.01 (Feb 15 2024 - 17:03:10 +0000)
Loading new PMUFW cfg obj (1848 bytes)
PMUFW:  v1.1
Silicon version:        3
EL Level:       EL3
Secure Boot:    not authenticated, not encrypted
Multiboot:      0
Trying to boot from MMC1
FPGA image loaded from FIT
NOTICE:  BL31: v2.6(release):xlnx_rebase_v2.6_2022.2
NOTICE:  BL31: Built : 03:55:03, Sep  9 2022

U-Boot 2024.01 (Feb 15 2024 - 17:03:10 +0000)

CPU:   ZynqMP
Silicon: v3
Chip:  zu4
Board: Xilinx ZynqMP
DRAM:  2 GiB (effective 4 GiB)
PMUFW:  v1.1
EL Level:       EL2
Secure Boot:    not authenticated, not encrypted
Core:  67 devices, 29 uclasses, devicetree: board
Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
NAND:  0 MiB
MMC:   PMUFW:  No permission to change config object
arasan_sdhci mmc@ff170000: Sdhci card detect state not stable
arasan_sdhci mmc@ff170000: Sdhci card detect state not stable
mmc@ff170000 - probe failed: -110
mmc@ff160000: 0arasan_sdhci mmc@ff170000: Sdhci card detect state not stabl=
e

Loading Environment from nowhere... OK
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Bootmode: JTAG_MODE
Reset reason:   EXTERNAL
Net:   zynq_gem ethernet@ff0b0000: failed to get tx_clock
zynq_gem ethernet@ff0c0000: failed to get tx_clock
zynq_gem ethernet@ff0d0000: failed to get tx_clock
zynq_gem ethernet@ff0e0000: failed to get tx_clock
No ethernet found.

scanning bus for devices...
SATA link 0 timeout.
SATA link 1 timeout.
AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
starting USB...
Bus usb@fe300000: Register 2000440 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@fe300000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0

> Also curious if semihosting serial can be used in your setup.

I haven't tested it.

Hope that helps. Unfortunately, I don't think all of the above is
documented in one place.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
