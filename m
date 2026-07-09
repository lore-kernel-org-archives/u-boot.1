Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73C2C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8FF84A51;
	Thu,  9 Jul 2026 11:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="I/o02XI0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I/o02XI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD6C84AB8; Thu,  9 Jul 2026 11:11:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CC4849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZYAIQJSDla0GFEWrcdy3ABYPn7gF97BJR9tcmQpmgv3DVS/s1D+rj2rjICdqf78diELwujBXmvEFGtdlPfFe6psfBJCYz63zgyjn4CufmL/AkqNFI6X0tHTU12qEtelKIGCag5/aYLlNHwBYFkmZYZpDFxUXVtLsDR1q93okh7x9C2jlTjUdicJtfdyX+L0Nln9JplpEp9XWpCGkdH7auUNn5FwrNPWLMvfJtlxJCC9o+piDv7jQ3Kax5j8pdOawiXQkAugNNQSYVqqlcPHeUx+sp6tPPP/5yy55JRvawcc8rI1VzEuTBe78VFzFTteDucRpheXrHGFLJkYXGqZQpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQx9ML6M3vMwwDotQsf/CSSP5X1gBxYyto/vLqzAaSM=;
 b=GaW01PCiE6ibEmimqAJASjhogYjVXK0Uv1Pq5I6FoAb6Uds/dkKkm/JEHRZjdOaflQAMe3W7iBi7Y52IFEA02bxtUKgJAN4qcCJqJ4Pznr29RjDKv9qjII3YkfP6rQVxnrlS5ZOGEywkxD0p3qAri8TG0MNjQkEd04H1FwRTI6BjYdvp284Tu2Qb1j76lZEtyp6aE1s2P6Z8hWJap5UxM216aMTLgPnrErLY6J65/lPkwTwpFRvLfne/NoETHEL/RyJH6ehMHN7bSAjAhySH48QxqTVHGNlHDfJiPL2pOr8hXPrBACi6z4gEzzyOJ43CtesPpnbwZHXewsHbpVEZMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQx9ML6M3vMwwDotQsf/CSSP5X1gBxYyto/vLqzAaSM=;
 b=I/o02XI0TwmkdBRqWIKSCM6Hgp82wRc9sXLdxtgW6VrYiz8PkOqkisF/sU1pPK5UVC2j2WJS3RtAxnwDg/wscu4USz2MUvZG06w/7XLc1lM5GimMwOEJR41UwE9IUI52c/s+i4o8EoAHwDlld/nj+euE/rVZeNybA2WFd8t3llA=
Received: from DUZPR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::28) by AS4PR08MB7829.eurprd08.prod.outlook.com
 (2603:10a6:20b:519::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:11:09 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::a0) by DUZPR01CA0141.outlook.office365.com
 (2603:10a6:10:4bd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 09:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 09:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDE0iy3dpJyFsUaII1zNZnkauJMFTzjWc5Fb76Snx0+RpT9LEywm+rKkCKqClia2lhUQBSlIAsC2mnZ6MwQGJzON+RAa1Iu1wYR0WZtYj9DMY0670pOBjnjcVj37c/AjPPgKZmS1ubsz0zY+knqysUaOY1c89QcR2hJp0/zTlQBut55JAcfMRnItgw3RfOn3A515jmHBvr17Ym3+PNFyYLVgaacTCziwVOAPpIXjy3yEdZ7U9fEGd797eHlHJL+I9pjCo/rA0i1Z/PmWSDDel8u03vPFfUkLNOAt9qJ8577L5DFx+QoW1ROz+M52ckQRuoesvMDq2oX84paLNsxjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQx9ML6M3vMwwDotQsf/CSSP5X1gBxYyto/vLqzAaSM=;
 b=mo7somE52ykFlkQei5/ocg/eX+r3adkyQ1Rw0scn0ZjH4Z+6UhgoZMLZXAFqqL0rpSbjwAz2qMi3AJWZTjhaYDL+rmbYdsHox+jf+ypTwgsn/xieUEjZSgQ8Uu/atlpDx0P7OUCJemD/g5Ogml/7tBz6/DTyu8VrNskgF+Xat8avPVuhfGrrI05+Pagt5/1ynI+xSsC3GZ3lIegvK/+bwqhXDa/iVUKzkNqdQ5409dgkJlwVAY722ddyB2SIKyR2ZPZpbNunyvEQtt/iQeWLkDIh5+hoDUIWsrmicOgkJhNskSotZLo3s+cEelvisc/EyzoNGeCCUAsOIN3bSXseig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQx9ML6M3vMwwDotQsf/CSSP5X1gBxYyto/vLqzAaSM=;
 b=I/o02XI0TwmkdBRqWIKSCM6Hgp82wRc9sXLdxtgW6VrYiz8PkOqkisF/sU1pPK5UVC2j2WJS3RtAxnwDg/wscu4USz2MUvZG06w/7XLc1lM5GimMwOEJR41UwE9IUI52c/s+i4o8EoAHwDlld/nj+euE/rVZeNybA2WFd8t3llA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VE1PR08MB5791.eurprd08.prod.outlook.com
 (2603:10a6:800:1b1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:10:04 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 09:10:04 +0000
Message-ID: <56319b9d-0ede-42d1-991a-0ffbc8cbac3c@arm.com>
Date: Thu, 9 Jul 2026 11:10:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: lwip: add tftpsrv command
To: James Hilliard <james.hilliard1@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Johan Jonker <jbx6244@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20260708193123.2557776-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260708193123.2557776-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VE1PR08MB5791:EE_|DU2PEPF00028D10:EE_|AS4PR08MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: da6f2295-c008-42dd-a944-08dedd9a0414
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: Dps2SnTDXrt7i6Iw2UBqnRHqLAh7ozvGUUHSIa921VkE8dVEaJFE/wganG3E5l78lCbSQGR4d7QJ2V6i3ub0FBWAqLZCQpierIHgvV0f/g1aiGMx+GB+OxgyB3XTL5KatOFhYV3Ll87bVt+qqYSzkwUfG9iw6D/hR3a3qoVr+RMjEoXdVIDv/IAKOSCHfaVjLW8LaK1CdhHR9eZqq95eXKvreqOIOSsZVZZdP4+J4kYPhYzmx0cwHRS9P/IwddhRAjR9kFYe5B7aW4fVrSaxx8nuzV8EL374bzPX1FJU1ptQIEfV9ySCF90nt2rbp8zeJRCJRpU44s8g2G+py3zWeYLFZ0zVU66UrFJZHEnleNSQza1dos2CxMYh0Gty+xZvoGP15Aq1PyHWkv4T5HJyUz8EVoXnIAS/4PALXsRvtGx0aWW31lOQOEdHnyB7cJqsGEMekZi5ahXeIoYWgriJrm2f3MoeaDRmXiWEjPDTYizOAh+PkonytGxLz1psicu+a01uHAq3bXAzmz7GpG1v/GWllIYqPez7FyhRYJ8hz70o+l/qQ21tlS8KqGOpU5czopsvvOMeLLf/wGMe0hbtLmJiJ4JCeH6ArA0pagniHTM94aGZLqAjDCMf5fT1vT/yyE7vEDdkgCFjSPJzlJeR6rI4umEtKaQidofA7elkzak=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YOcML5eNCQ/jxq6tZBRsZ3rqABiKNFBf9bFiUJpMYwXQAZmgLA2UV02T6uXeLRq9wvkxJnrDSvqALkJKurOZ02On9MFX1ji5TPV9Eh1w2Nue8IywSrcioTLH4vrnJmxJks3O8HroHZ67y60j4y8K8lwB9sX0lkGjzvkWFNDWDII9tCqG8I0cm7xE8k7KPDxeXhJcQ8xRf6QUO6nkrQzU99VcTXLnxDfrrhI3LUmv7+xROEQjDobDixWxAguOgRHO20R5pz6yV52vq4ODV5xlTOCAIwScqXUEHesgFgGVrPaMCTyoVTCLEX84m0Oqp8BM/FfB8Kk45hz12J6OkdSSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5791
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c375846-20f0-46d4-db60-08dedd99dd3f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|35042699022|14060799003|36860700016|82310400026|1800799024|22082099003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VpxXAgSPMbXJ/r7rkB9s3hNZXwENtR8wiAQT6kPPArGN9G51FyUThzABdINtiCbicK0H/y2XQOFSD/IkLbdVWvTf9Hf9sy8r6Nzh9YHEz1yxgnqFawjr1FfEFcuUHyX4gDhinwkSB6BdzKGg/quvmbYuz/K/kVbmbOiqRSW3iyABHep3SQz1MtICgk09BLm1cDPa6BDc2aO4DjrI3oOdmZGFVVLy74jQIuH6k3q3jV5FVgLxcPYZaqXrc1+DOFmFd2W2Mbwf/EBT0thaI8N66g56sFyRWssVqQKVeeoprDHbWwh3wzKSNLyYhhOKk+4rp2fNXv+8lY4nA8VGTMPKfwYP+bZJlrX3KXELeDgoTDSS3lIWHXaY+3vS57IQHLHldVbrVHKD6RaS5pONjIkfnfTrYezBfVJdNF9+dHhUx+KF9mOqf3uNkRIIfBCF9OtvqiDpIxFjfdHF7lDkXNaIm9Jc0rnJfr6h25UJJYqQ4aNxloLBgF1ahFkH6lJNjgcDUnz4vXCKBq+r8ERHV4Wgq7LKlYxhXF6U3EsSNc4zzscRg8llHG2rLBJgVjPVTjQIt81R9TrYR08VAyZlOfytoSrIMjKo1i72IVg9e+yzHchwqHHLy82oAX6H+aOoazMGpuWrpfes5prLHr+Cq8wO329iMc/8xwspiVUqIu3gTGkCM4NeB16uuHY5XE0Jds66L8qcaqbW2YM1c3pX1Pxk4Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(35042699022)(14060799003)(36860700016)(82310400026)(1800799024)(22082099003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ohi8sCNydmYJ8knoOkt2sRj2L+4bZ2egNELOaQAr1kpZxrLK4hAdgu0ndmhRzjBxLtvPft9Q9F6sepUR9z25eT3pG9QLTCFLjPXMSaho9IZsOtpCsN+UiU6NcxbZNGvR1+BFxzxLlAnKo19mArOCK8sL4gMa2yG56nLXcL6u2/0lAtq0Mfe6wGekts3QdoAn+wPUlTgm7DfwdnIwNxjSSO1FJjO5I0ZOgWGcenNzKRI1OoLdIBvgjKMwmYVcdtoQOKiCSootq2Vj+dYekWZEYb8FOI8fb5xAa+EAy+yXSwkby+Gs8R6LuegWXCXwmVqm69P8jjJf+fH4qEt1Oi+RLBzbJyT8wB/f9GO2ncnHO/ORerHoBLKPTk76wJsb30i3rwTI0KVL8ZUCcLKF0ykEaq7sZX+Kz/9PD3xfvvwbUVDX75frQVMDWXs10+FM+FzK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:11:09.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f2295-c008-42dd-a944-08dedd9a0414
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7829
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

On 08/07/2026 21:31, James Hilliard wrote:
> The legacy network stack supports tftpsrv, which listens for an
> incoming TFTP write request and receives the first file into memory.
> Despite the old command help wording, the command returns after
> receiving the file and does not boot it automatically.
> 
> The lwIP stack already builds the lwIP TFTP application, but only wires
> it up for client-side tftpboot. Add a lwIP tftpsrv command and
> implement the server path with tftp_init_server(). Reuse the existing
> lwIP TFTP write callback and memory copy path so LMB checks, progress
> output, filesize/fileaddr updates and EFI bootdev handling stay
> consistent with tftpboot.
> 
> Track receive timeout and write-failure state around the lwIP callbacks
> so a stalled or rejected receive is not reported as a successful close.
> 
> Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
> enabled with either network stack. Update the command help text and add
> usage documentation for the receive-only behavior.
> 
> Add pytest coverage for tftpsrv using a generated host file and curl's
> TFTP upload support. Enable the command in qemu_arm64_lwip_defconfig so
> the test can be run with the existing lwIP QEMU build when the boardenv
> provides env__net_tftpsrv_file.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v3 -> v4:
>   - Match lwIP TFTP filename length with legacy TFTP
>   - Keep the server transfer context on the stack
>   - Use the existing net_lwip_eth_stop() helper after tftpsrv exits
> 
> Changes v2 -> v3:
>   - Use an explicit TFTPSRV_LISTEN_TIMEOUT_MS value
>   - Allocate the server transfer context dynamically
>   - Halt the lwIP Ethernet device after tftpsrv exits
> 
> Changes v1 -> v2:
>   - Add tftpsrv usage documentation  (suggested by Quentin Schulz)
>   - Add tftpsrv pytest coverage  (suggested by Quentin Schulz)
>   - Enable CMD_TFTPSRV in qemu_arm64_lwip_defconfig
>   - Allow tftpsrv pytest coverage to use an explicit upload URL
>   - Keep tftpsrv pytest coverage gated by env__net_tftpsrv_file
>   - Clarify that tftpsrv returns after receiving instead of booting
>   - Update legacy and lwIP command help text for receive-only behavior
> ---
>  cmd/Kconfig                       |  14 ++-
>  cmd/lwip/Makefile                 |   1 +
>  cmd/lwip/tftpsrv.c                |  11 ++
>  cmd/net.c                         |   4 +-
>  configs/qemu_arm64_lwip_defconfig |   1 +
>  doc/usage/cmd/tftpsrv.rst         |  73 ++++++++++++
>  include/net-lwip.h                |   1 +
>  lib/lwip/u-boot/lwipopts.h        |  11 ++
>  net/lwip/tftp.c                   | 188 +++++++++++++++++++++++++++++-
>  test/py/tests/test_net.py         |  94 +++++++++++++++
>  10 files changed, 385 insertions(+), 13 deletions(-)
>  create mode 100644 cmd/lwip/tftpsrv.c
>  create mode 100644 doc/usage/cmd/tftpsrv.rst
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ca1039f6a03..c9a6c7c33a2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2134,12 +2134,6 @@ config CMD_TFTPPUT
>  	help
>  	  TFTP put command, for uploading files to a server
>  
> -config CMD_TFTPSRV
> -	bool "tftpsrv"
> -	depends on CMD_TFTPBOOT
> -	help
> -	  Act as a TFTP server and boot the first received file
> -
>  config NET_TFTP_VARS
>  	bool "Control TFTP timeout and count through environment"
>  	depends on CMD_TFTPBOOT
> @@ -2286,6 +2280,14 @@ config CMD_TFTPBOOT
>  	help
>  	  tftpboot - load file via network using TFTP protocol
>  
> +config CMD_TFTPSRV
> +	bool "tftpsrv"
> +	depends on CMD_TFTPBOOT
> +	help
> +	  Act as a TFTP server and receive the first incoming file into
> +	  memory. The command returns successfully after the transfer so
> +	  boot scripts can boot the received image from the load address.
> +
>  config CMD_WGET
>  	bool "wget"
>  	default y if SANDBOX || ARCH_QEMU
> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
> index 90df1f5511c..245683a9672 100644
> --- a/cmd/lwip/Makefile
> +++ b/cmd/lwip/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_SNTP) += sntp.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
> new file mode 100644
> index 00000000000..6370c900489
> --- /dev/null
> +++ b/cmd/lwip/tftpsrv.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <command.h>
> +#include <net.h>
> +
> +U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
> +	   "act as a TFTP server and receive the first file",
> +	   "[loadAddress]\n"
> +	   "Listen for an incoming TFTP transfer and receive a file into memory.\n"
> +	   "The transfer is aborted if a transfer has not been started after\n"
> +	   "about 50 seconds or if Ctrl-C is pressed.");
> diff --git a/cmd/net.c b/cmd/net.c
> index f6f556f36ae..0f0b2386d87 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -89,9 +89,9 @@ static int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc,
>  
>  U_BOOT_CMD(
>  	tftpsrv,	2,	1,	do_tftpsrv,
> -	"act as a TFTP server and boot the first received file",
> +	"act as a TFTP server and receive the first file",
>  	"[loadAddress]\n"
> -	"Listen for an incoming TFTP transfer, receive a file and boot it.\n"
> +	"Listen for an incoming TFTP transfer and receive a file into memory.\n"
>  	"The transfer is aborted if a transfer has not been started after\n"
>  	"about 50 seconds or if Ctrl-C is pressed."
>  );
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index a974970c3d3..06ed5a131db 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
> +CONFIG_CMD_TFTPSRV=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_WGET_HTTPS=y
> diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
> new file mode 100644
> index 00000000000..597a2f3a8bd
> --- /dev/null
> +++ b/doc/usage/cmd/tftpsrv.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0+:

Extra ':' character. No need to respin, I can remove it when taking
the patch.

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

