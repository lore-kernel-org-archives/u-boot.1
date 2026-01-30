Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86827E6BF10
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA1784581;
	Fri, 30 Jan 2026 23:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BzTds0um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD48C84582; Fri, 30 Jan 2026 23:07:05 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AE984582
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeDJuX+5NIstF9x4bgu+e6ipMRTQRG78cWgB2SwUINyNtKU4P27j5hH0sobSswSQ6nuEVfNd9+EhlMXQWBMhg1dbGChWUPbinqww+LlhjC9Rm5+jVTmh2vxuznnsthhX5XcBGsZqY+G4MwGTUVC2XeQYiiUhKgFVqDXl/tWoWfoKBbnTTQw/IhdSGN4TuLrW6gn5rNZhaMmxwesd7THJ3bRoyCoXoqwcFUcMRYYlyuIlzkxFG6Wrshf0yzz78vYCH93i0QC4E42/+3+sBucZiIFXqiJNV4kLS9reCY71RvErqf0kXwEz458vWR+0q/q6PRiUmNALDeu99gvrfvDibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fh0hITdkQc25PQyRxtgQVOqWVU76zTC4c2wVFIHGWE=;
 b=OTEDvvorNNE6NMXqxsTfm0Z2YVUyLR7iOpH+g9l4Gop8slncTgCjA0YFwqFepkHoSN55k0dnwMtaAJJtzW/tIg9vDVNetVcyjdfw0K6vFfIthRwpQ3p2hYyYUekQ3TPg1U+AJZpnMALTpVrm5SwE5OaBMu24/t9LcF1B/JMea6Sz6IS3ej5IqgfvW6g/IqHbKMw7LcHPZy59PPIvKU+8zKXW62tEbFin2+dm3JmNhEGeBXxVKc2NXhOlgtHUfRpemgHDIn+asmn5oHEV0wZ/T9dz0bUyBL02pkwIodt4jo/BCOiTtQBj55XY5eOYwjzdvstCSGaX93vFFXAxybONMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fh0hITdkQc25PQyRxtgQVOqWVU76zTC4c2wVFIHGWE=;
 b=BzTds0umSrf2a1HxyrdeYwPODPooP7M5WCVbECGwL2SecnRcw4/Wcy9QyKpnrxsB+lyezpclFDwKZONpmLJclCSyR0HKyZ+ezfM9DrLd7Nxph+BCcqMk2tgcN7e/G+O2glol6KNuqCUyBD0iwtbkGyKuZFHf+NVKqlwJke2k0vflWvuwY7oockQ+jqxSRJZKaqnzNVGVOqXvuB9QVgOkO4yHdBpAphOvCugZP1eqolFPUpypsVmS2Zt9ZQTB0RepdsE5NA56X9yFP7lhntVbWgJ5xUchMTbV5mU4Cje/zBDRf5kDsNIybnAmx2jtPOy1CPGmcpRfvBb4A3JyRh8lxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:07:00 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:07:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 7/7] arm: dts: en7523: add mdio child node to switch node
Date: Sat, 31 Jan 2026 01:06:29 +0300
Message-ID: <20260130220629.4040550-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 61623de4-b108-4576-974c-08de604be47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KTYQjjchRm1pXoLTWvuZRf0mRXAbYUd6h1zNaMZxZDlklXjZ6OtRLNo/KZq/?=
 =?us-ascii?Q?z0uAJOI+WEUyVSdxyCCL1lvYSq616ONj1SovJjhS7SjWElzsPodnMM29H7PV?=
 =?us-ascii?Q?gSZRQjlVJN27qUv+ruGnECaIb+id8FqrgazHprw5E/Fw5WlmrWg16yY+Igj2?=
 =?us-ascii?Q?WssY8WyfIWiZe3tNRMSVHREJdad6ZcVGOwGgLT9AQ2yAtMBctZDG3bIp7gHN?=
 =?us-ascii?Q?7cHhCHlsNal3p+CceZrRLPljRLz+xnoqbZmUxWztNfHmG7Kagh4O1GU01Tiz?=
 =?us-ascii?Q?I+1LN3mhmXUcmMLqon9a5583TWUTtbsT8HaRjfnagyk35LY/lfR2ZiC2GxKU?=
 =?us-ascii?Q?lLSklg1mXhxFDbxW3ynER9AAhW3W41ZlrHCIwvl0A0/5b3GjgnHui+sLNimV?=
 =?us-ascii?Q?hIeToBNqnfY7rKEo6MLG1niIA45XbndHl168O0qA3553tl7GwofvUXMZm6uE?=
 =?us-ascii?Q?Z6X6wB8KXFsiO81csJRxLDscRF1CxAFsVXWjZFylTlKtfTyik2rgDCsrt2zG?=
 =?us-ascii?Q?+6u7O4U+xy2iyaoU7DkEYHk5h+FMrbT5vyh7ifThWQlL4KBfK939SYkUZexT?=
 =?us-ascii?Q?gApMiJHM83V51HlU3tnjy2HXvyyL6YLtXhfyfDx605Z+orrYQtWpTf5S7qwy?=
 =?us-ascii?Q?1lK14IeumRjK9cBtoqcUX3MV8wUqTroWlQd0o1m8Q8ZIPj1DDLSV8iV6WuMz?=
 =?us-ascii?Q?gEbBpH87e1kVLjNi3DzhSCyURp6TAwDst1h7nMcHnxmjamSbsu4Rhq7Ucy9O?=
 =?us-ascii?Q?jLSvre7p7GV1y4UL1WhAgPitXflCzJnIuvUnlWMVcF4wDkepuS/8V7mpI/d4?=
 =?us-ascii?Q?asDPdRykq+11vnxJxl2sM53vdnBkpCdVQzSrIR/i0RXqrDoGgEbHlMe+BTj9?=
 =?us-ascii?Q?9Wb/vQx9cJsbc8rcN7oErYd1GjUaQ4R+tJF9sz3+fs9G4wuSQlUzWUb8bjUe?=
 =?us-ascii?Q?TzlZKEFJqg/NH5p0F0oKDfUFMBbqPZ8AFh7PNp5d4187Vx+RKJktobUh3t7b?=
 =?us-ascii?Q?8MzSMucADyiOl+lmhyBkfGKAK/lvEp7G9gcJLgfNRhrZgb7wLFqUOY31tpi2?=
 =?us-ascii?Q?RDdfxACK4/17FWEOBqnrQDvOZLtt+tD76yajxo66WbVmZzPtV7IjRKwKnk4Y?=
 =?us-ascii?Q?GiQCZD1EyCG4jaRjlmPgDIdnjj9Kfa4pjWk42vKSLGKQWN4d/99Ts6VjBW/j?=
 =?us-ascii?Q?IRYLui4DT0Ajbds5AI0feqBQ+RQx4PBbXREr392XcLN8eT0wdHAbDqBfNC7i?=
 =?us-ascii?Q?GuTkajC0na616t6gG80JNi3grovnttL2WmYlPlYn9B72xuVzt/nheuyBOauv?=
 =?us-ascii?Q?vGeA8zD2Wu96NwnNUIXYJhL9YLvbBmvP04tnxpzOKPFswjrlu7JpPWzERFdn?=
 =?us-ascii?Q?qcy1L/Vt9VpXD4AzshGkQfC1bQWg1Um8NDdsngAWwl92DfGnSo/UMc2SvyN0?=
 =?us-ascii?Q?c//lN/ZVJzYIw5J4vJlQHdpVjYEpYoXyXwt6B8DXWA0w8rIztQmpdsbeZSnW?=
 =?us-ascii?Q?efG9zD9Qhjcw+ylpmfvHIoSUoSroSapKT7tfsivMPqPCQ3ISYvi9v4qEeHbC?=
 =?us-ascii?Q?pMnXA5c+WkdMfNOoW1qfT2I3Ap9GxLkMa+I5LLiQhGhHckndSn0qokQEIJ3U?=
 =?us-ascii?Q?DJtkHG25jnnUQWrOYp4P7Cxjv/yQBVIa6DdltjFIv2TE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnckECdHbcGukx6AEH/WzSQnt8xKfgMCn/yzizD4r6LYnkCsoLQz/HO6e0Vt?=
 =?us-ascii?Q?YFsxMplU2DPTGRwhTFR/tbyrdLz8nWxAU1hRmSS7kxZn8JzQ7Y1YGQAvf3rY?=
 =?us-ascii?Q?TvJD2GdPwZDfXb6B5/7D4XYegUX+2n08EYDetrm+y/qbYGM4gsEvdiXyEoMd?=
 =?us-ascii?Q?LBsq8WfRuNTzBC1wt6uwPUU/llPhTI+BeCowzOWHIaxSgd2uEGo4j9fdJ7tE?=
 =?us-ascii?Q?HV8kmfNYopduRdujP5lAzNWd4CkS1kh9KtgzQUAQYkIMlWmw5hLLs+ncx0rI?=
 =?us-ascii?Q?AdEi60Lr2RsPfJrPpV5aTn2gRY83NPEaO0QToDqpIFhnEppEQQQQ0V7YkP0g?=
 =?us-ascii?Q?iZCTnloNlmLH8QeujmatwlBmRxOq2DgSyHR/vDGPj8IYPmob+ta8UJndM2/h?=
 =?us-ascii?Q?D7JPIwqk5ajt1Xtrioc7NCEGy35gySBE9CWQzXTqjCV7T68J6tpNtTEURdj3?=
 =?us-ascii?Q?cBk+quFWR/Z0iB/zPqrRkfM9BZ3yRBtDwI0E/UzY890bgtli1+sTOhk5cWPA?=
 =?us-ascii?Q?nd2GrjTkbbQSTpaGxarxdtZR3BvFoW5ppG34eRpWy/vN+w+S1v2Ep2B7wpsV?=
 =?us-ascii?Q?z6e9ZUYcWrFu/4eVYyu2Wipjz3sweWZ7azWk7gG78SsHbgECPp1ym+CFhzQc?=
 =?us-ascii?Q?U48rNKcRCdus7/NT3vsAsuLwJ6UkOjLShwbmNYwmmNNxH407ZVTdspDapgMm?=
 =?us-ascii?Q?gra8c3YVQ9gzWmkKZOL4UJ5oCg5WjMJojtUekwShXS/K8Zf7gsQ8IGH5o8QE?=
 =?us-ascii?Q?mk2bLYM0taLK+OJwl25s6yhVGsbaDRj5zyWFvIt1DKdOvPlG0m1LNIK9NVuB?=
 =?us-ascii?Q?80394HoVETWna1l+fAEfOkNKsrhM6uq96B6R4lMfU5T5PnTBcTGgE541ddS/?=
 =?us-ascii?Q?5/A9NzK4zkp1zsG6mvAz65ksi0jslj/bv6Bl+MHsPYjX3MIA6VIuHSLp6Udv?=
 =?us-ascii?Q?FMFyojs1edXZMW82irg+FoXcSUQnpYAyqtsQp1THoOkygcl2/z/kZbbMWAdS?=
 =?us-ascii?Q?ASirFGz8TGLbDej+lTCp8Bhgs9XglTg48+2NDZN94exF3jo9JMvsQC6KwqYH?=
 =?us-ascii?Q?yBACQ1N9m4S5XC8uhA2YXB/rxOgFPRPIY3LZSJuYqh/wyEVldW3kbio5wLZc?=
 =?us-ascii?Q?mlzs2NhnCgfoUS5X20VbRg+YnDhCPa6wt7x2Fdir/wsni1JR9xK5fEOAyUp7?=
 =?us-ascii?Q?bphj2hkEaEWJ5Qx7Nk/nA42yfnm9amLNMi+LBuQukBo06bI8U5jw/qJ22JyD?=
 =?us-ascii?Q?oL7QP1IFO8yjQ1CRwT5+u+ddqdoiYGia6BOQUYmzEzg+x9+ufx9SMCZAHZvf?=
 =?us-ascii?Q?9nyk0FdOL3bAnarOAI6ON07NNYuExo1aC/wuaVP+qvv0Sa5mUV3L8agwXkKJ?=
 =?us-ascii?Q?mhD7fKS5DvMH143DviSutVn8B+zYDHp66c6gYxsY1SQfURZzSZJRNJ0UMPc0?=
 =?us-ascii?Q?qe2I1OmNkc0omQMfN0xMtmxbO0Cvd8HSPhDXUhFnD6zF7yAJ3L1joMeS2sHM?=
 =?us-ascii?Q?EVsx9M0jO+NY+ah0opQZwWSIb1jTS/+kNgd/10P09xgqx8069g7005shPXIe?=
 =?us-ascii?Q?v0C5kO/u4H4os3f8e0a997VK7cLq3hvR3gfzoDxaq5kPwhxnZ4Ywwt7Ddi7r?=
 =?us-ascii?Q?4XHvDMdeJ2ollu61eX6AYFSJUpp4xqL7fXnUkzsiwYVDrDvRP27hb11CqqKs?=
 =?us-ascii?Q?BAaQ3yOk8uhVTP/8UvYM+sRcsWype3/u1aqhei8eDH9ocesDHVaTVsbDxxDl?=
 =?us-ascii?Q?RcLG/ijsb6Xn8HxXyllr53BTZ+QLM8k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61623de4-b108-4576-974c-08de604be47b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:07:00.7843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiqM4+Ca/f7QzdpjAiSi3lpqd3hIpHowvZp7Edbe4k93VVVa0Ibcn5X0Tqvuql2/6vvozI3DOqqqD+ZjoLdJ3R4eDIyM/ZXYkhvQXA9SL9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

add mdio node to be able see switch port states

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index f031f81515a..9eadaccc500 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -42,6 +42,11 @@
 	switch: switch@1fb58000 {
 		compatible = "airoha,en7523-switch";
 		reg = <0x1fb58000 0x8000>;
+
+		mdio: mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	snfi: spi@1fa10000 {
-- 
2.51.0

