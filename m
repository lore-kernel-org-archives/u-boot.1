Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CF7E81BC2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 13:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056F283C29;
	Mon,  9 Feb 2026 14:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GcqR6/SC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8438B83BC9; Mon,  9 Feb 2026 09:10:26 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717508397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 09:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/o6KUydl3tprjtQuOiYOZe4HclVXLohlSZDZkM3cZZfvYEZmc+tg1FSfBtwU5DMyENqP/7QWN9Z8tSX5V3h1p0/eGb0Qtrepis7mnp+V3AkQQr/xprL+ooVHqG/VFF9alz3PRYTkwq+Mbo9EDEkWSGfRGE9O/Bd82KQ5TBftFdNx/6bq0rfKol2fjjCSqnVogqllN6VRyfRd4jTG7BYxNpec4HVKNp61Oy5oeDhdhuFc7XP6EC0ojnWbi7PD9RSn6yFaeEwfwglto+w1r7PI7M0ETl3x2PzTktTpx81gZCFmsGdLCbDKAK5HN+RjlNZJ1qdnotlIpBFmqdLkcwxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQupU0+uTkEBOD2R1Xml3izTeS5ZnAF5mLnVLc2p7Uw=;
 b=X2+o9KNciPBlMSrCuwjsvT2vaoyqID8e0xVbFLnL9kCuSo6/DUnhHhYCh+kFFsBgERRUv6doeeEi1WD7eUg/9F76FswDizD361NCcMyAZGIdpe7+aWyJ7XLGGPyIFQuJ8fdVV93PnBHllFH+rk2c9xxnMIbVUnASBi2plDQp4yqqOzFFJ02A2cCHMVDjj3zNKvlKDosCamaMGI0QFxy/pft5IUuB/Rup4wTqRtfrhlEkZPFnpPGtV/72/xBjqbRFRoMp6jZCmh+zhgcI8V1+4L9wSGfEwMlmC5WN9ox7+lQ0Np1HfBaxlvx/Ys8inmGvsalb9PbvgzBnNhoAGjojLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQupU0+uTkEBOD2R1Xml3izTeS5ZnAF5mLnVLc2p7Uw=;
 b=GcqR6/SClIXLXdk9rXIa0M0HC0gEyiN9Q6N0WZiV2f4i/IBzNAwrwHtmu+b6pmb6G8q6EYVjCHkYbzNjvhF7v3CRGGbPypOcJIEjI3K0UWQy2rnCoT8SYsb5JjA8GY6yGM6h0lsYSk8zJVGF/ySinsuz7bPJRbqRVbzBNEt41U1XMmnr2h09N5iUeZ9hMvZ1zxkzOv/q0zCwgRP+MqbnHxtXtk5mwtmR3ZxwfwM6b8mYy1An8YSx0nLRMoLwD4kbMMAwgUFQiykQ9v7Ctjxdn/k43yIxGCSBH7m2RY3bK0qPYZ2GhQ0+Mx5kwM71qMaz+Ddo9YbIpseM1qpUL7BD4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS7PR03MB5463.namprd03.prod.outlook.com (2603:10b6:5:2c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:10:21 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:10:21 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v1] spi: cadence_xspi: enable automatic platform data
 allocation
Date: Mon,  9 Feb 2026 16:10:07 +0800
Message-ID: <20260209081007.5166-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS7PR03MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb6dec5-0ab7-433b-0ee1-08de67b2ab27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMEPGsUXkHEvS20kYPGKDczXsuj4lP+/zWXs0fVB5FggJAkls4lcyEMEbp2/?=
 =?us-ascii?Q?lbuLWXPCXWg7qt9/8tBhdbUEF9SQXv0hWmLjz50fAntYxV/IddCGaUxlQ2Rv?=
 =?us-ascii?Q?4f3unIM3KLV1gnAVpwN0hA1fRWp+nnsIoVsA2ZO/5QfWbaN85GVGwAiEK3n7?=
 =?us-ascii?Q?TGUknJWiOG/0qhQbk7L9rlhYcWGMiMd8l4tp3YCRkeU1Ncl4tuEJfeLgKqlm?=
 =?us-ascii?Q?ObfkrvBZG8ZcxR3wGQ6K4/DXTwq6EzM7Z8sU5gVF0MkmoI64Zxcrv/kuCM5f?=
 =?us-ascii?Q?K2z1FlaiUHFXMNfajcZCYTJ/skb0yg6nRnhsSgTf8hNkBkyJFq9mOX0CD1rl?=
 =?us-ascii?Q?mYfWHQmV1tS8vEoJlAkgpaP4dfssCGptTsApMguAWg1zfnn1bu1hjuCmHzML?=
 =?us-ascii?Q?2WIDWnv7IHKpJsrp5jXF7u20SO8442GB9wTkvtgF6UkjQVlKp5WcyMGRgK2w?=
 =?us-ascii?Q?lDPtGoqrEOxUtZf0ggZFB4XbUrdu6W/i22lFSxxiYgZ50///nSlA8ITdGnhT?=
 =?us-ascii?Q?Djjf8kM66XK3uAxvWHbY7hbu+lOEwAp2j8EBUUlYgeEbq6d+SeEYnrwQHarU?=
 =?us-ascii?Q?cd28fsbA42Jxtz66oN1Ch7T6mGkG0h42V+ilzrxds/3L3/1qR02ipFCuFx4D?=
 =?us-ascii?Q?ZbrmmKEAbHFF7kZghzcej8+2FhaEcp0Uv064PoOhfyFFCUelIuunEie0UWtJ?=
 =?us-ascii?Q?cH+6TV8pHwmVBhy+xcZPT9ONQQ/KyWYBqTPBXe2silNcNFCvQ6/vGpCfssXw?=
 =?us-ascii?Q?mKAW/Tc7Vv8Rrgh2mgmCV1MbXhJbgobu5EBXzwftplRDluNIjBxUjxVldwc5?=
 =?us-ascii?Q?EXGqaCLoBE08Q6nh0TjQeU3KHVXffPpwpZAEyhCJiE9ybly9ZGsDTFJkIf9a?=
 =?us-ascii?Q?NJ4gje4rqYftenAzdNsthzVSSvX0p2ZYRZxgoFMiz1smvWa/A0FoW711Cvm6?=
 =?us-ascii?Q?4cfOV9qvCjXRmMO9Jrqfx/Cxjoqmzs/aRRHX/aAuAguD6en038QhkiRKvinB?=
 =?us-ascii?Q?dHmjdzP63uqOEhhgHViJfo3a14H4Nk+xO3kw1DeAHj92eNEh55SyjWo72Wyu?=
 =?us-ascii?Q?JclnRMt8H+ESw6gPlFYZK9HoQ/pR9+kfEb4N6WSuF+aNQxqcbf9rOHkv6gNf?=
 =?us-ascii?Q?5Cz/jU8nIIg5rKqbN57OkmKapXOpy8XzVImdKBrM1WZzx3fjeU7D06r4K2T+?=
 =?us-ascii?Q?jmf/WJqgfyBau1ZzlxL2G+t32qeVe1XH5Uc9JYW4uaO+B3ZvA4YnutaMFmbU?=
 =?us-ascii?Q?K56J6FiPr8FoUvgyAPsTSo12zUdjo1O2npnVpiVV4uoETdMa8u717ZPNGa6y?=
 =?us-ascii?Q?eqxVPK8CXu/da3RqeIEvfrqW0rUdx//lyp5zmhFiYnpNFR6W9TsRRsmQnXxy?=
 =?us-ascii?Q?v66n7yuT/lw6c1Ui8gTaMublEmqdfLzazjRWg6zCFcS/woWZ0Z15GXi5MdPx?=
 =?us-ascii?Q?TqvGtkR85kh+1IcHAcx0u+NH2Wn6iL+/wZXCyVFALTBQybcdFy9kZ1oC1zTa?=
 =?us-ascii?Q?dwJZGV9svpvv0dGPIJwc9lXsRTF7lYoWWLIH0uK5rg5q5pHsHgo4/SC+ltKp?=
 =?us-ascii?Q?u7R5x/jlw6g1kdcGQ7g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0eWUAbge8qVytJziGXVHXV1WNu6JOZOUxDNE8nDGfzmoLSbX2oW4fnZUrGq?=
 =?us-ascii?Q?vxI2LW1e5IVaQ1ZBZ/FkK4CfpcKKPzurU2iSgcVxKh/W5PTe8Uq0KB4me9M8?=
 =?us-ascii?Q?vPDR2aftLek5/lj19ag0ivfv8s36SKKeZMl9fqnRcd7+dp+bjKQRBP04V+RA?=
 =?us-ascii?Q?Jic+5UqLLQ70Bh3lq6xTk61uMTUcqDKZhM75lrJEbbXtnaWgZOF54G55V19/?=
 =?us-ascii?Q?HIqnRSp/6j28S3qTTxSX6ahW8HZ/gc8BZMvrwpKal86r6gJh87qt1ntc8sA5?=
 =?us-ascii?Q?gENlLr3B3bK/HhFzTkrgzCm+By8f6zNbwyE5grbuFHwrKmhpf9SqIdgPvA1g?=
 =?us-ascii?Q?lr7X3b9byA6tq99wWzS86C0gPQ4ojUKwK8c0AbzhT41469xWLpmgdQdGRJ7U?=
 =?us-ascii?Q?UYJKgZIVlpTxlnTdrBwC4F2doRvyVKjzemZjtEsmFneWjBc/oDB0t09cFQUG?=
 =?us-ascii?Q?gF+OKuVXWPXYhBJW3zyqcfn4SkjL5sMwa5sSm1gxO56jYvf/A1yh1T/N0b/I?=
 =?us-ascii?Q?mVyugI7/jkxRwerkVSVJpcVVSnfP68pz+N9aGn7NcYJbuUrBbKsZ1a9n7VEu?=
 =?us-ascii?Q?PDkdUKKwUGUSFetnezvntvJM9/SkKLwbQHhIgieI6N8Rcrt+NVaS9p7paNzC?=
 =?us-ascii?Q?YzBNm02Z67J5jv1WL/o94HWFJ2hXnRymP/NnHqfnulmY/6VNXf+cZ0F2+iMT?=
 =?us-ascii?Q?YnXk93xif2FX31ibSsgC16lyVG8Wsk71jRcGLIIFSWBaYBUEYpo83PwsC8cH?=
 =?us-ascii?Q?QmJBLA2CSN5yrtypX8Udv6uy4HFCoY++6P5aqPvA4IOTwjOwbkGTW6UxH/Tz?=
 =?us-ascii?Q?CauJ9Rlf1eYBt3EnxIoLOj2udLGPqMeWM1WAx72oFtxz8CXKhEnfMN7bisgx?=
 =?us-ascii?Q?E2hkYkxG3APBIi1nYGrjf5riyQ9DV5ji3U3VKgVhVXDapEYk3wqrCvxbA2AQ?=
 =?us-ascii?Q?J/hV575xnvYyv5BEWOB8O03Js6CQDPXkbfRSl5ZaASv/VES/tjHL256XP/Tv?=
 =?us-ascii?Q?hzm6opXm7HV98ImowSGuX/cVLeRgc30Us0sGbJ4a5yGRwHstCr648zGmG/es?=
 =?us-ascii?Q?VX+ybnt+MrT+hc5oWbzT23xu4LxglB/IFKTFg9jEs8aZoNxiKP1KNG+vPRo7?=
 =?us-ascii?Q?n2lOJGYr6EE+S/d2d6QsTleZx+T0v+OBZ18DB3DB1uIGe4JeVXPjBZXNFULn?=
 =?us-ascii?Q?AWnBPp1ZYaj7TySIUMv5dL+E+oEaAm320UeX5xB3wymCX3eJKjatOgYDSh3f?=
 =?us-ascii?Q?PHlBoSfQ7KmRythKj50Zz0MLf4Kt33Ud0VLsLVhrPcJ6vv6V9AK0tcGoOULn?=
 =?us-ascii?Q?wg7b5jJzoD42YvVPK7YudAYZBax9nJSJU64OXyVPj2cFOwwLnpsfEsZbzwkl?=
 =?us-ascii?Q?gGWE1v4+UEap2kXyYBYe8yOeY/JxhGT3dt8en33RvmprQuYNrShHlJa63ydF?=
 =?us-ascii?Q?gB9bMkP73uLIqLUc2HMFVMy4l4JluDDAWlnUhgsirVS/XecHD4p6CgtkEuDX?=
 =?us-ascii?Q?gLzHz52N4+Vm39aKMAszknY2ugclEvnAwuMpRwynQpdosEUSUN8DfP1NCR/D?=
 =?us-ascii?Q?VbJTLnxxA7JXaCyYUwfWJzrcm21LUSZC5JzeL6bjwserRkJQBuDKN1SOh+G6?=
 =?us-ascii?Q?V7xRnolMzsPrucARwRn7equWnafndgHaUS3LQ0zn8XNoRwmTZyj+bkoDbwJ7?=
 =?us-ascii?Q?5UJzrMPPdtuMW1bbKYcUTl5bBWVYcAbbS8TFsq2FLtzbH84NnGPJGswsYz37?=
 =?us-ascii?Q?gPRTcAOWFg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb6dec5-0ab7-433b-0ee1-08de67b2ab27
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:10:21.0666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGyCesnpt6xUAgRm0txqQP0LSk/9rWxjcB/qGMhaMrYK5m3pJaPjQWaiiX3gx1nzcHmr/vVca75PFf5f/QgkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5463
X-Mailman-Approved-At: Mon, 09 Feb 2026 14:27:24 +0100
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

Enable automatic allocation of platform data for the Cadence XSPI
controller by setting .plat_auto.

Without this, dev_get_plat() may return invalid or uninitialized
platform data when multiple XSPI controllers are present, leading
to incorrect IOBASE/SDMABASE/AUXBASE values and causing SPI flash
probe failures.

Setting .plat_auto ensures each controller instance receives a
properly sized cdns_xspi_plat structure, allowing SF probe to work
correctly.

Tested on an Altera Simics platform with multiple XSPI controllers.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/spi/cadence_xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/cadence_xspi.c b/drivers/spi/cadence_xspi.c
index 717f226b709..8a894025d02 100644
--- a/drivers/spi/cadence_xspi.c
+++ b/drivers/spi/cadence_xspi.c
@@ -441,6 +441,7 @@ static const struct udevice_id cdns_xspi_of_match[] = {
 U_BOOT_DRIVER(cadence_xspi) = {
 	.name = CDNS_XSPI_NAME,
 	.id = UCLASS_SPI,
+	.plat_auto = sizeof(struct cdns_xspi_plat),
 	.of_match = cdns_xspi_of_match,
 	.ops = &cdns_xspi_ops,
 	.probe = cdns_xspi_probe,
-- 
2.19.0

