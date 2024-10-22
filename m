Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5033DD2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA03B88EBA;
	Tue, 22 Oct 2024 15:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=quest-global.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=quest-global.com header.i=@quest-global.com header.b="jooDMGLB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quest-global.com header.i=@quest-global.com header.b="YCSLIFAl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quest-global.com header.i=@quest-global.com header.b="1zY8xc4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7992C88F4B; Tue, 22 Oct 2024 12:06:13 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A2E88DC8
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=quest-global.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Dharshini.V@quest-global.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quest-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpulOuedpj/WYN3hrio0Xl2YXiwxY3tNoWXZ1ef/cfs=;
 b=jooDMGLBKcvecTfNKF9ADL4eaTNMkGMLObmQJWNJGdYAzAwawXolBPBkMiTYaGzG/0cCW8SeE1Ac31w/Qxd3PRrWsz5iagEGes/rsJBoscA1A6uXWSwq8meTlNV/G9cpfXWIeVKsQKqmL261E/GU85MVXru2KUGIQp6o66aO5nYJ8P9uuU4FoNVWdp1CFlAd0EAxAw5MxpXPUomNCrWq2hvLuM7qcdF7dV/Yl5VYaiEI+KRio7Z40qavZ2tWbeIi3/Fg3Sxp0KRdHkfRAeUajbQzrq2GKDG83+ESnh6BsdvebAwtdJ19jVoNPZxf93a5P0/5cMleI3NEIqFJY2OgAQ==
Received: from MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::6)
 by MW5PR20MB4499.namprd20.prod.outlook.com (2603:10b6:303:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 10:06:08 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::94) by MN0P222CA0001.outlook.office365.com
 (2603:10b6:208:531::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 10:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.214.204.181)
 smtp.mailfrom=quest-global.com; dkim=pass (signature was verified)
 header.d=quest-global.com;dmarc=pass action=none
 header.from=quest-global.com;
Received-SPF: Pass (protection.outlook.com: domain of quest-global.com
 designates 3.214.204.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=3.214.204.181;
 helo=us-dlp.cloud-sec-av.com; pr=C
Received: from us-dlp.cloud-sec-av.com (3.214.204.181) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Tue, 22 Oct 2024 10:06:07 +0000
Received: from emails-2075420-16-mt-prod-cp-us-2.checkpointcloudsec.com
 (ip-10-10-153-185.ec2.internal [10.10.153.185])
 by mta-outgoing-dlp-967-mt-prod-cp-us-2.checkpointcloudsec.com (Postfix) with
 ESMTPS id 6207F7FF7F
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:06:07 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=vqz6MjTef2bB/efv3RdfvjApXL1IHkZbEox7vb9QRPWkDWq7Gj4ZzMnGTaeYrTCXgEJhhrIh/blx6cXrJiU9kmYxzuN7Zzx96bomDSk9yIjzGgKOgDzdNIV/67nKUuHmglxGPJi91LedsOPDbvuL/5ZPfOZY2rgzuCi3Yb2QYIn9PoSMQVTzvEKz41owI+4VJNm7770xOi9HdbILS3qGq++BNQ7k9C3ULoS+0rzLc9FqiO9xRL7saTUsugmgGb626zZuM+EtOk0hlcahUmCkUOO8cNci7J4mYnF0RaYvojX2wH7mAHXqy5nPAFJEETCINF5pU/ATkQ2F1vYCBhAJOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrS/nP+ziMOrzP6bm8QS3PV/Ge0SeGVON+on2QIefNc=;
 b=rch6uz6fgX/ggHoVGLa3zv7by8FQP/o6qJbtNeqIKY8cfWVz1LI6OAAvY/qCtpR7FVYemedN3iKxxnGg++eLSkRtw18OZLiNoE8R3icq48PqT4Jy49r1FS84mSvYxcb9r7K/x1gtqTdpM6OD1qj3AvduiqazwJ4nvg9/+IhYFOnZeKuW0DVBV4ARJ9/qfNN6DuP+cg6jTGmg1bIQDNPu+MjviTq5U0/DzTlVE8Euq30nzBSVYANiibifTsT1Vttj8AJp5uQ1UJcAmpGFgCq760unP3gwUoF5MsC5Pmfi7J07nQKitrNcmFGwu8SoGKg5I4J4gzqAYUjcdViBOkb8KQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.219.28.84) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=quest-global.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=quest-global.com; dkim=fail (body hash
 did not verify) header.d=quest-global.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quest-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrS/nP+ziMOrzP6bm8QS3PV/Ge0SeGVON+on2QIefNc=;
 b=YCSLIFAlewNx1r4juHd+hUj0PjCp5eaCjFZ7zKwwNUSEdfb0fHAtblyLpP/yOD8229wlOb+FhmZJv8K/7nR9SiJL6ThoXfjKi51hFQ5V4E4UgmKuCFGjp4RdzhRTPNP6e2SRzXqC+4b8J8/g/ZBhvzXCLe60Xx3E4DRVntORTUpXMMyTBofOW8J7YFEPjG6AyK09bwzLIpJDa9IM35+c+wdhHK/8bNrG77SSLT1vzVMMu2mQuBgkUpST40ld6OXwhHij6OCLoSOjvZP+Lo+piHjLsEHYjf6EHomQ8Q4msNA5um1Aaw6uFXeHjY6GGGyktwiiAJd7y5NqRRJv9pkZAg==
Received: from DM6PR08CA0039.namprd08.prod.outlook.com (2603:10b6:5:1e0::13)
 by SJ0PR20MB4439.namprd20.prod.outlook.com (2603:10b6:a03:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 10:05:13 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::c3) by DM6PR08CA0039.outlook.office365.com
 (2603:10b6:5:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30 via Frontend
 Transport; Tue, 22 Oct 2024 10:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 66.219.28.84)
 smtp.mailfrom=quest-global.com;
 dkim=fail (body hash did not verify)
 header.d=quest-global.com;dmarc=fail action=quarantine
 header.from=quest-global.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 quest-global.com discourages use of 66.219.28.84 as permitted sender)
Received: from quest-global.com (66.219.28.84) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 10:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My3gGeZedjf1SeZCMvpm/lMwV70Nn3M5TH6AMN+QomnpT5eVfu5Kpxb5O9/OVlsKtMtsQVYGXhKv7U8NULOQcn3u3RsSSCQh5W+XxJezbCAv+2rxnOrTimSzdzCwg8qr+0qbRsXt6CV/cs5QpnNNEAV4Wywoi8G0WlBzMCv21FW6vIWHtMwkO6CSQqFieCdiur1lMYDYXJazHNgQSk5WR/Pgz7YJA+BN95TCjJFm04CgPWinYtdVNv5BgRD/ONkPOUD/sJY921TzH98bWdNRlWMEu7tL7YOktLTu6FpuxZqiKAkopoD8Nv63vDtP3heobwI8W+/TBXWnz+cmr8WBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkrsUl8mfUhbc3JWKHhStu6VGKjg6SATSK2pnFqgqQQ=;
 b=d6ZFbcIsd3o2Q+6jUFS8sqw8k81b/vtygDD4aGT8OVvS/bFXjYWil3qo9CFPzHHLJAZS3ZOM7+R1DpRpjTTCV0KJ4aHggv8fMV7w6bFcRZPiVueh6/+iQ+m9Irxhua0SRKS1QzPdJRCSQZE37x9OJpTfyu/Sl2BO3ZBPRXJ8A9nCJBUif0ebmMn6PYAFFDZYQalZiYTpKVVtKFlUewmq4o7R/X2iJukS8e8XL138f/eJ3sL29uJMVkBZfxgi/uKItP7+aCTHNEAkpPa24POQ50oKRgx/5NBpiPMP2WsJ0D2TfLbm7yKO5mhW0cbNt1TMf+ExPZj9R+gmDSmjjGOUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quest-global.com; dmarc=pass action=none
 header.from=quest-global.com; dkim=pass header.d=quest-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quest-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkrsUl8mfUhbc3JWKHhStu6VGKjg6SATSK2pnFqgqQQ=;
 b=1zY8xc4vhjbbG7JO6ML+iiqeNedR1u+6X/Y/birwEZE2KWNuo1HHYuzdPxKgLduGlfAg/qZv6F4EF5HGRaOb58mliXlughAK2aJvZ7b6lmWHZvYMwaeKyKlIVB0LsmUlRjXsh2Eqig3UXgGHD8hKc4RrFFz7oEeonyx3k5fpf37SAsCAlqnOByWe7ICCaUzSzo4egmK804svbNSM16O+/qetzNe61W5VM41Td6wHBKWId16VexzyqwAjTxkhNPNIngWV7Ix11DGAQNmh1JGUg790eXdg4xacBFkyC06PtF1hYVLjuB1pR5G1LjkzXE72yjbkVBTwh2//z5vDHejabA==
From: Dharshini V <Dharshini.V@quest-global.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: u-boot
Thread-Topic: u-boot
Thread-Index: AQHbJGldQOAZ8wpbqk+32PPJg1gB/Q==
Date: Tue, 22 Oct 2024 10:05:08 +0000
Message-ID: <CY8PR20MB5355DBE63E4A51970BB7DA51C74C2@CY8PR20MB5355.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quest-global.com;
x-ms-traffictypediagnostic: CY8PR20MB5355:EE_|IA2PR20MB7228:EE_|DS2PEPF0000343B:EE_|SJ0PR20MB4439:EE_|BL02EPF0001A0FA:EE_|MW5PR20MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cf09c8-608f-4be4-0c5f-08dcf28125a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:CY8PR20MB5355.namprd20.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR20MB7228
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 598f9552-e42f-46ec-84a6-08dcf28102b4
X-CLOUD-SEC-AV-Info: questglobal,office365_emails,sent,inline
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|35042699022|8096899003;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?NBcuTRCwF/kpWgBZMo1mU/s47tsujtGg8a97tbd6ziBL1c7fJlB5u+GSNsaK?=
 =?us-ascii?Q?zKbj/HI86e72/brS8Q4gPVKwnwEG3w+z2sQan2xPaJcKTB8jAGHQFmuob9dA?=
 =?us-ascii?Q?1vvHC1XdToKFiF0iT1O1WfiZDQM2OIbt286hGNBdWH86hMfX2BrzCvxa+5u5?=
 =?us-ascii?Q?57qXgWdrlMAuCjotBoMgI0Md7cTcEcjE/W/+YG3rmHST+YnZh6m/s/hgGXgm?=
 =?us-ascii?Q?10AGhEaWrgjT0s5cCdTIBb8iMdNjhi2LPbFOwAG0qInwBsm+owQDhDngMH81?=
 =?us-ascii?Q?lCDhPAWiqn6o/AakilHS6O9sD019e92F19cZRuT4rrYM4I7fZ8Yc0WRXpyn5?=
 =?us-ascii?Q?KCBTkBf9eJuAAV/mZVl4dXhbTWJlQctAVBcDwVceAdQSUKXfNP0Kyux3ccyu?=
 =?us-ascii?Q?tXO/qeXRDfVFfK/iaIQoZDD0tiK2y6fNsaPruE5kk4c6FGSGIyl+JoRh/61S?=
 =?us-ascii?Q?9eNLpRxS5PQqnQgdmvmBcPZDwUINMoPumOmIuwfWoFRaTjYAu8TkOBAxlQKa?=
 =?us-ascii?Q?Zdu8v8el7Yjmnx19mHbcoSiu9Ip6oBfy7rOHWDOD1+PC7BAEc5+UWwutdxXm?=
 =?us-ascii?Q?Oxc2NlMKC1qzFsWlPzwklLk1e2P4OllJSgcQKMMdqtQYLjd/E04YvUL5qL2K?=
 =?us-ascii?Q?bEK3/+YzMRHpayVW8jsRBo2+YuglyAgE1PglJmSi6IIbNnDIY8qsRJC1my82?=
 =?us-ascii?Q?BCa6YNHRv8ioDbpZBW1d+/RjN0omBx3hTKvCSFlsWUdJWsqmfiyw7YClLNkc?=
 =?us-ascii?Q?7Js0vtso8DNh8hRcYrur5PxmboiuTYycTs+TH59Q7Y3la446mQvjwxIITvrW?=
 =?us-ascii?Q?52z9rP3u/2bFgKlFZH8F66Tie4Xsm5tF0xBPQTyuDtXQd0H8LBHnio5VfinD?=
 =?us-ascii?Q?MpjWL+ipofolwKBjwDHm4YUsQxveRDhfOB3uY0EfuMRt9rJLGhLbjftA7plD?=
 =?us-ascii?Q?h6HvHZUf3AaWDj4S/7Ycr363pA71Hq8ilcDEqXMQ9o/iB0g5hnDrGLJIGJxY?=
 =?us-ascii?Q?cXq5PYaGSBbhkASvcnOgTRwbdfTFNNSTAiRqdmfKsTVdeqtzctpi0dEz99DU?=
 =?us-ascii?Q?jfnE/0nD87csDS4wky2WqMblpguGU/6OnquYHBZvejduceOQJEx5Gw+x2UgW?=
 =?us-ascii?Q?aY85xf/HXXF3scWeRw3yUViV8qZQcsCajsaWF+Fom76+5VSFtH95J9Fyw+St?=
 =?us-ascii?Q?nz7IFncw2pSrd/qC1sqvDFA1A872xlAa3ef402xz8rdgekO3u7z+5qGlIDwQ?=
 =?us-ascii?Q?n5d2Ut32DLLgizTjOky9VLlok3Dltwvx21zgNoCQ5t7803k64OwWEWSOCXhm?=
 =?us-ascii?Q?Bd2MCZqRmTOPpEqUMC1kLfuu19YQ0RFTIAxpvOtDRlQgaWPB+Ll8nqLZq4ek?=
 =?us-ascii?Q?vueihdeiW+/GmH+pP10Sq0wRpNU4jibgjb4gGcPBbU7py4m7XA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:66.219.28.84; CTRY:US; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:quest-global.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(35042699022)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4439
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-us-2-1.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 76043f22a96a4e008af866ff0a21f974:questglobal,
 office365_emails, sent, inline:e25eed2429a39d2a9dbcd88ffc89d42b
X-MS-Exchange-Transport-CrossTenantHeadersStripped: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92599155-f53d-4de5-58e3-08dcf281047e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|36860700013|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3h2TXlPTmdhNitJZ1E5UkdrNjYzVDltTmJUdEhXdm1SRmU3VkJ5T2tEWnBn?=
 =?utf-8?B?UWdlTkxPUHptQnpqUHRQcklid1BxZUgxNHdhQzAveHlLV0g0dWhScUIvalA3?=
 =?utf-8?B?U2dZTUNJV2t4ZGtxNk9wc1JlY1FiZmgwL0drTW9KNHQ4cFNtSHE4Q0xER2M4?=
 =?utf-8?B?OVp3RmtiNGk0WU4xbm0zSUR2MXo5SHNmU2F1ZFY2ZTNxbUR2bFJIeURPZU5R?=
 =?utf-8?B?UFV1b0NyWVJDSEcwU0Y5Yi9xNFZ4SlZXUVhnbUdIWDBvQ2RIN0JKbnNxSVc0?=
 =?utf-8?B?MzVyTzRNeTY1cnR2WThTTFEvZGNacW5yY3dFOU4zeC9xajhkeTlkQjluS2dl?=
 =?utf-8?B?Qm1TV1doRHpCQU82c29vdTh2aEVZRnFTSjIzbXBHeGt0WG54RnlESk1Wakwv?=
 =?utf-8?B?RlJHTkhLbGJVWVJZZHJaL3lGOVptTTZqNnZCdHJPaFJ5S2JSdWJNUWpwY0JT?=
 =?utf-8?B?ZnhDVEVVUzhQTDlxM01KZlF4d1FKVmZLZkhqVGZDM1dwalllcmNVNVlBcnR2?=
 =?utf-8?B?aThJMlI0dnI1b2VRN1pmSjhKWURhY2I2NzdDU1oxNlZFRDhIdFpjeW04VTds?=
 =?utf-8?B?REhlVERVZjN3M3N6SXRILzlRMG0vSm9ObkxSQytqdWpYZm5uOE1mWlFiZWNQ?=
 =?utf-8?B?V05IZ0cyVWxnVnNOa1cvNVRHMDE2UzZZMk9OOGR1Q2tJRXlaMVlkN0tQUkpv?=
 =?utf-8?B?cVFwU081V2FOb1RjQzdiWGZ0Q3p5cE1UR1UwMzlJaFMvYjRnblRDRzlOZ00v?=
 =?utf-8?B?czRqZVZSM1ljTzYzWm9JdXB1cUlxMS9ueDkxSjNSQkl0SldGZHFtTnJkZ1Jx?=
 =?utf-8?B?eW8xUjAxOEt3TUg3akZtVFdMTjlKVjZXV1E3a0JmbW5WRk96bG9zdDJQZDcz?=
 =?utf-8?B?TFVvY3IxZWhpRDVFN1lML1htanpHci9NcUd6MWZHTFUrZk9ZUmdDMU5QejVQ?=
 =?utf-8?B?TjJJVzlyNDlwd2VKVnJaN01odGdTT1dWYm83OUNtaFdaSmptSndFVVZad2Zo?=
 =?utf-8?B?WE1sbm5ENjZkSkxtWTlranNuQ1JvZlp5aGlUSnFCcllieDl0TzlwTUpkaDZP?=
 =?utf-8?B?aXVPRzRqajUramh6elgrTTVwMENNUmNWcWRyT1FiUUtIdzZEOWVXb0Yxd1A2?=
 =?utf-8?B?c3AzVzl5UkJrUjNRM1l5VkRlOHJSRm0zNzEyUjlDZjVVQzZNV0YyTG4raXRR?=
 =?utf-8?B?VnZkcTRxTklPK3RnYWpzb2xTaS8zT3hrTzltRHgxcmU0eXV6cDFuYWFJL3FZ?=
 =?utf-8?B?bldaOW9Zd09tMzNOaGNYTzJJZFhJZGRMVVRVckYzbi9VeXFXUFA5bmdkNE8y?=
 =?utf-8?B?bGhkUWZrNmJRY28xYm8xaFZTQlRXMllhNWtNdVF4REg0WnBNY05HM0pzbEd4?=
 =?utf-8?B?UVNOS011Q0lkQkJPQVNJYzIyOWhqRklVVTIwNVBxZm9Bc3B5SVlGQjJneldX?=
 =?utf-8?B?NlVDU0RWV1VKR1NibU1wbzdyY1oyU3pDL0orcG1Bbkk5dkFvYm50MWNvMWxm?=
 =?utf-8?B?c3FZa2UxMHRDWXg3TW0vSElESFlUVkdtNDNxUEx4VENwelNyMnl4S1hEeFBs?=
 =?utf-8?B?a0Z5ZTlsR045R2FHOVZYZW96WkJBL1U5SEwvakxsbXVTWmV1TVhiVzNIaWls?=
 =?utf-8?B?VEhSY1hoNWhDSjIrMzFRUGcwOTNwMTlBbU5xQm85cjZjaVVjcm5ueHBpODVu?=
 =?utf-8?B?ZlY0bE4vbm4zZEJ0cGJoeWUxY2ZBbFc1UnRZNUdBemlrTWpwcFMrTURneitD?=
 =?utf-8?B?bjJiUGVhY0VmY2NjeFRMNDJyVTh3Q01Od2hMYVNXWTlwRmh3QmlhdG1lRU50?=
 =?utf-8?B?SVFTQmRjZ29XVGZVR2JYZ084TkVKTHI5MWk4T0ZlRnVpZ3l5Z2lJMXpkbmxV?=
 =?utf-8?B?UWY3dWE5ZUZLRHVYNFZySytaNk1ad2haNWhtelk3UHphUWc9PQ==?=
X-Forefront-Antispam-Report: CIP:3.214.204.181; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:us-dlp.cloud-sec-av.com; PTR:us-dlp.cloud-sec-av.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: quest-global.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:06:07.5247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf09c8-608f-4be4-0c5f-08dcf28125a0
X-MS-Exchange-CrossTenant-Id: 93aa23a4-6ee1-4601-8592-31a762489359
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=93aa23a4-6ee1-4601-8592-31a762489359; Ip=[3.214.204.181];
 Helo=[us-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4499
X-Mailman-Approved-At: Tue, 22 Oct 2024 15:18:11 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

R29vZCBBZnRlcm5vb24sDQoNCuKAguKAguKAguKAguKAguKAgkkgd2FudCB0byBsZWFybiBVLUJv
b3QgYW5kIGNyZWF0ZSB1LWJvb3QgZm9yIFhpbGlueCBaeW5xIDcwMDAgc2VyaWVzLiBBcmUgdGhl
cmUgYW55IHRyYWluaW5nIGNvdXJzZXMgb3IgcmVzb3VyY2VzIGF2YWlsYWJsZT8gSeKAmW0gcGFy
dGljdWxhcmx5IGludGVyZXN0ZWQgaW4gaGFuZHMtb24gcHJvamVjdHMgdG8gZGVlcGVuIG15IHVu
ZGVyc3RhbmRpbmcuIEFueSByZWNvbW1lbmRhdGlvbnMgZm9yIHR1dG9yaWFscyBvciBndWlkZXMg
d291bGQgYmUgaGVscGZ1bCB0b28uDQoNClJlZ2FyZHMsDQpEaGFyc2hpbmkuVg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCkRJU0NMQUlNRVI6IFRoaXMgZS1tYWlsIGNvbnRhaW5z
IFBSSVZJTEVHRUQgQU5EIENPTkZJREVOVElBTCBJTkZPUk1BVElPTiBpbnRlbmRlZCBzb2xlbHkg
Zm9yIHRoZSB1c2Ugb2YgdGhlIGFkZHJlc3NlZShzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IGUtbWFpbCBhbmQgZGVs
ZXRlIHRoZSBvcmlnaW5hbCBtZXNzYWdlLiBPcGluaW9ucywgY29uY2x1c2lvbnMgYW5kIG90aGVy
IGluZm9ybWF0aW9uIGluIHRoaXMgdHJhbnNtaXNzaW9uIHRoYXQgZG8gbm90IHJlbGF0ZSB0byB0
aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgUXVlc3QgR2xvYmFsIGFuZC9vciBpdHMgc3Vic2lkaWFy
aWVzLCBzaGFsbCBiZSB1bmRlcnN0b29kIGFzIG5laXRoZXIgZ2l2ZW4gbm9yIGVuZG9yc2VkIGJ5
IGl0LiBBbnkgc3RhdGVtZW50cyBtYWRlIGhlcmVpbiB0aGF0IGFyZSB0YW50YW1vdW50IHRvIGNv
bnRyYWN0dWFsIG9ibGlnYXRpb25zLCBwcm9taXNlcywgY2xhaW1zIG9yIGNvbW1pdG1lbnRzIHNo
YWxsIG5vdCBiZSBiaW5kaW5nIG9uIHRoZSBDb21wYW55IHVubGVzcyBmb2xsb3dlZCBieSB3cml0
dGVuIGNvbmZpcm1hdGlvbiBieSBhbiBhdXRob3JpemVkIHNpZ25hdG9yeSBvZiB0aGUgQ29tcGFu
eS4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=
