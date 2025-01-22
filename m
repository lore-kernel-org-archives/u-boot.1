Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68DC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8607C80586;
	Wed, 22 Jan 2025 10:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="0DqU7knn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E7F80763; Wed, 22 Jan 2025 10:28:05 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3C680283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwmI/tOAEeElKgfq33HB7QR+WhM4Gkh2kpuBbL783CL16I5Uk+5q+n4YkBo7Lfei/EAWGS9x3eBgQ+8MBjMZsnUmNi1Hwv8nyvaB/ZNRyBQkTdA0rVGcfyeOj0hfLkOgWpKZNADfaxbD3aOccso46xuLBiCNjkFOjuXkJiAa7qBs9b+PgflBTjeEw9omxyLlvYpjJSu68XQBPxjXwAp8bGrnGKD7gjTg3c5Ms/QF0l91KR+rHsJVr/wjcxl+wi5UiGmoVm3P7QoQQtjYoWh/Hm2KWL+X9KOW7RcMWan8ej7OhT801J/KE570bYcrkSyB6jGv+m026Qf0ATiu1CjMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jofG7EExoEJ7q6MuTt5x2OzFyhFrNLa7skv5whjpg6o=;
 b=Sg7dOr2rhofH95mmkCC4Sq8jCQIwZ63ffQp4DiVg7QvqoSxO7JRkvBJGawFkGklEWxeeGtBqANVgha56qFevuhHcI8DT2UzrSl8i7Tyx0ywaiSFb1AbWEg2vf1rM7sci24ND2DhlapcUAfVuN118qi6de4DuVz0hlT2UT1MgEr8YL3MBhrIiqcUmJHqlEGEtf1i5ONUID4/4gOjwJhDF5UvOweqSzEOl986KRpqa3wf1iZBd0+2Nk5FXTY/ZFCAqj1Rff3VOShvKugnlg+xidYWepMiH1CRQh5DwZbZXsyI2jThuFYR8Y8z/5sAF2UvoN8EPPmCVJjkpMbvpUkdrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jofG7EExoEJ7q6MuTt5x2OzFyhFrNLa7skv5whjpg6o=;
 b=0DqU7knnIpUNZSVOOZHl6/YPLhTr9w3e5zC2Q2Xg2/wPOmxVySRMpfyMjmbA2vmE5ePMCnC2RikGfC60XEYLx1vZu1cmV8V2WhEr0KYskg2Ck3gD4DggF2LbbKc8NNQpZHCpPfBAI0YgZ4guEpfkzGJYAPnbO5KcGd3MMMWak1rJUyaBciZ0pfduSrCBbEphiiytpbMTqC1/hZKgU6Zj/1+jHSzniXIAsi4qAc/o6v+HpvIu0ODSAFjs/xbWeEbjHNae0Z0vlee3AQy69w1rgzwFt7ZrtMx53AW0PRiBUKN2EvXkbydsHFRE9fPbVnaxRiRc9TfnwMeuxRSy92pRNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by PAWPR06MB8691.eurprd06.prod.outlook.com (2603:10a6:102:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:28:00 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 09:27:59 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] Fix bridge gmii2rgmii
Date: Wed, 22 Jan 2025 09:22:48 +0000
Message-Id: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|PAWPR06MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: a208484b-ed2d-4c46-3cd1-08dd3ac70fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZGsl0Xgfi6ZbWObDNpK6Vw7GfJPBOyqwFz4xoIuMf1YTDi/zCD/l8vm4Nc6?=
 =?us-ascii?Q?mpJif4faNNT/7si3n86C/KsMq8lSAMUUiYBoWxmYLfp0vwgutIPbZAk104+6?=
 =?us-ascii?Q?oMb/iYUhpk8l0iO/ONcZfWAxt40d95uA2o3xt/iJNjydkKJB0KFg36ZpJkmm?=
 =?us-ascii?Q?CD+1PkX0Y5kOClXM26bKXkkRKOV3zLcf5IIxbSIzbQeesc4dtl1UQYHj2j4B?=
 =?us-ascii?Q?4pDPf9Mh3A0KdL4/MR6pG0XB8d3gyyZ7wQw94VH4M7Uo47jFxLRm1Fm7boe7?=
 =?us-ascii?Q?ynXaS6Vbva6L9IeyzsuMtw0t03kP+7D2uXbg7SLbPjcbXrqJjayLhRFN0+5l?=
 =?us-ascii?Q?MEZeTdBqyfW8MsAPcChyNvnF/OFMBZSaOk79YBtn5Cdg+g+NEoeb4J8rfdw5?=
 =?us-ascii?Q?r6LyYQVWL/m5FWX5FRcGJ6WW4kfsup1Cg8EAnNEFbdgp8qwsxTPovF2ZUo08?=
 =?us-ascii?Q?6ik1sy3xizDmF5T6RxYz+rN0olnEEvl2/aN0d2bBKIUprACJDTHNJU09k7B3?=
 =?us-ascii?Q?TTgXsqU0h+FXgOmiSTevHSR88xDPo3woSzH7AH/iDfjY7a9AySJTlKRjAifS?=
 =?us-ascii?Q?RUFQ/sGafwUTS/gXIRO9TsbMTyL6vUxYz/hkDaQeZj+PjRjU5ukDjj9PSpo2?=
 =?us-ascii?Q?mfmtqsOaeu1vIWabqcSq0zkwZpS3Jhs+figOTg/oja67IoU9FJdYYXODuOb1?=
 =?us-ascii?Q?MdnhAAbeNeH/nI1ORmwYYiXBXFJXOj49V8jUPb3da1U8lV7vg/Rud7QlF3hp?=
 =?us-ascii?Q?kNtuOv42J00ZH2Sqn1CnnU3RIzLtZ/zumI8BZmPgOOs2LZseqe1qWpXZa3qY?=
 =?us-ascii?Q?KRiC4rXrcdHY9AQgebgICz4ElrPfA+5qiD+5gxQXgfjK3i7BhIp/kFIBxvq0?=
 =?us-ascii?Q?xunJlHk7928Lk0/RX0bLc1vCbDSP3Ty0WeURpPXjkXU+adcvqQiAk8MC0d7S?=
 =?us-ascii?Q?HAgdl4WN2F4ksZpRncXhigu5gQQea66Wr+9x56IOjQSGQFxXIEmN0TYe5vYw?=
 =?us-ascii?Q?Vf2mwkFLeKE7luDMyAzao7Wkm/paexJq30m8XurYwM68QBwdZfRm1HggRy7h?=
 =?us-ascii?Q?4wbXrL6pR7z81fsCpEzfrO9wmJNHlAVddAOSdOhkM2Gq4iBvyYvB2pAHdNGg?=
 =?us-ascii?Q?RQHLAsozpb3Lo4XEegd7i+WP23/pDDNcszzXG1xpNjbefJxlceYtJKpEQxkz?=
 =?us-ascii?Q?O1FRuUQPC6nYz/Yln/pCHZHNJEAfeEozzcZ6dP8XFR4KBtQnqkOgw76EP6hg?=
 =?us-ascii?Q?k536IfMyCOWBzoqMnhghuwzmVWQJTZDbmHaYMpEEmHShSBRC4vcQZd5e6YhC?=
 =?us-ascii?Q?Gb3xgKRHYl+Bsj68LE8CRzFRHw+fPSRGKkMzJ6cetpa4GYQt0blWEdilgNMP?=
 =?us-ascii?Q?+CeRq5P27ioa6FKRG4SRSpzfOs3cKC4ZmTjFYTSXFsvYvojY7iYP7xq7tHl+?=
 =?us-ascii?Q?y65Xlh+qaSk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzYK6gZa05GGBAeoMPnev/1SWGnehzibPbWEX0GLCN380MmsjOUAg+8/4Ixg?=
 =?us-ascii?Q?Z76nYn30Mnz+V5FaaSHeBD8tFtdrbZXT0yrgNTCIv25psLzvtux4ySrAuboU?=
 =?us-ascii?Q?uCVXQFvPF9qQdpAqUsYQgD9auk5slQt0GjZai2BETlhLlIVHKlO81pIQwhNA?=
 =?us-ascii?Q?d8uoW1feShu+qaF3E3zzvC+vTza6jHqqSv2cxNtWWQQqLjxDODCmV/+8tAs/?=
 =?us-ascii?Q?4KW4+uSfCeqyGn1XAXgpvqXqahpc/zV/rXCVIY2Lqmqh4r0AuQPgJKN6peHN?=
 =?us-ascii?Q?cLuaHARcghpMnYu+mEI7bPNNYWOUSVoB4CdjmVVyTt7Tm9UGvdnq6dh5/Mkc?=
 =?us-ascii?Q?UTD/6anBMdd3GcNmRATu3VP2Uc3jhU8grRtmrdvXH/YTpnPFxqX5WnYVUJ4B?=
 =?us-ascii?Q?HxcDJdGVI4KKg5cIxQOt/XFIkxBv+tYHJIJB6tXzBZLz2AlaInmEFeIc2koe?=
 =?us-ascii?Q?qZwPA4M8iP8FSeJvARgBsuPRKOIxvFqLWYJljINGIs643cw6j59WkDHq/ULh?=
 =?us-ascii?Q?DTG2s+fgAsvhkSulWbTnXNTrSLvLO6k7bmuSAXicfGse7QOebUXsUuUeNhWA?=
 =?us-ascii?Q?vTSqSYr7WfL0xUgN0Dl8H1o0fVn/wYuYmjkWr5WPTBUyDbcmlbddaeas1lzI?=
 =?us-ascii?Q?VJ+pEtoZTpzdg9bHe1dDiNrRCcNj8v7mIJIJY5pnvHM2JLHod0fdEVXR47jh?=
 =?us-ascii?Q?gXildyysjeLTJT5JmOgKS3CQvlWrBTVYHmoLgRj6e2MEWYXwdEzH9gGgTYAS?=
 =?us-ascii?Q?eeA0pdk8X5dloqIF4KK2SbYN7fWdurvYPv/CtNA/r/7iwIbk17z2bws0jGLi?=
 =?us-ascii?Q?aZFqQNe3wWXeTMXlF2zHcElW6JGzTD8XCWxcIhBus51aUgEUjMIyKyi3Wy/L?=
 =?us-ascii?Q?WDBE0cPev4jWBQxRYNrPiOkZv79ofbPaXbajRMD36F1cTQb9W+3i3Dphj5Iz?=
 =?us-ascii?Q?8lXTGtOI1WZXtQe3jJvtqWVGxBylYyNOn35cAxns/8oi791BNDwrSv3/gpfl?=
 =?us-ascii?Q?785/csLPElgsUSg9LVOT9bkc/vXFzm/noxF6AYoDRIFQ/GlLC985p4S6Hq2Q?=
 =?us-ascii?Q?7W0i31S/vQ6VwQiGVAN90eiOKngTu1si0MxOQ1iMhNGTdlbuOtPldiKo9k6s?=
 =?us-ascii?Q?tqc+DcMOR5ZP7NrpN1X7+Xz+E8gp7p8ARoIKqoVB/PiacAMMQHU7J4od0NLA?=
 =?us-ascii?Q?M/wjCo5uEySPYp2BqEznxr+/36FWXJMJ+mZqCAQW8UrL9N3Ea9j8PHCYQWRT?=
 =?us-ascii?Q?7cSDyjDAM8AbQVxUUnxnnFCYmsrfz/S2pFIQ0R2y+UuKOBkGkln+YheX57Lt?=
 =?us-ascii?Q?1BVQU6lrvwHIgP2Iu4OM9P01/NIt3t1naPd42LSSixW/IwCg3sQu+kVPNPzQ?=
 =?us-ascii?Q?L1jy4CHIlgeChMENeiNly7d1yljbrHqWVJY6GYvKNTkEizpTBbG6n6kp9D4X?=
 =?us-ascii?Q?df0cdvnSYXKlK4EcfPUCjqAzmmomai3i4qDt7ESAZEWt9vrjaGZ0HpBGjw+b?=
 =?us-ascii?Q?cBgDtYqzFHMyFGKIVT/mPWOA1ruLNkzGGc+lavenLYvTDczPxWUwD0+pbLwi?=
 =?us-ascii?Q?zGqKafyw7MuQ2zn+phRT3yCmTK+lrXj/a7d9V7aWpplj4BUoCf2LnYhqU2rm?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a208484b-ed2d-4c46-3cd1-08dd3ac70fb7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:27:59.5099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgLkQRSrQyzEobXhFKAi5k+1m5rFMcbMA42M2+uC2C0MsPjS0cyypY1R6sNY7jBhIlD7mXljv8LIQXmSFXMYDufK3Wu01R8F7uEhgTZI7DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8691
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


When taken in use U-Boot v2023.04 one our board's ethernet stop to work in U-Boot,
which was working in v2022.01.

In v2022.01 the gmii2rgmii was called before PHY was created.

This patch change back the order and fix the problem. Also the ethernet-phy-id
driver is taken in use in gmii2rgmii driver.

(no changes since v1)

Tapio Reijonen (2):
  net: phy: Let gmiitorgmii converter create additional PHY
  net: phy: gmii2rgmii: Add support for phy ethernet id configuration

 drivers/net/phy/phy.c               |  8 ++++----
 drivers/net/phy/xilinx_gmii2rgmii.c | 12 +++++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.39.5

