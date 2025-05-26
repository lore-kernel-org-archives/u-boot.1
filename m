Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859E8C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5CB82CA6;
	Mon, 26 May 2025 09:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WrZYoInZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C3782CB0; Mon, 26 May 2025 09:10:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C45582B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FakXvRN4u2MuRx4Y9imFn8ZEtHDFZ+kgVnDYvEFyKXLIxUGNeeQ2NNzbbcqkewfPqegtU6btsNJnYZ5ldf3dqs1ja+37d0xlvn/2r9wUbHCY5iJbKmj1Ge9AcvFZFyqWyUK7LQ6U3SOiOkQAbOsIHrBcU2C6vnWlkqMh+Acn+T6/9h+DCfpJiptPle6QHS3YT2mLPeT9FBGLCUrcxV0sn3lbnFO3eBZmR3Ges2jxsOu/7ZCZ4PemLbNx0htJMNRsTwM6ToNZR+/fMQDv+L5ePGu7LvLH6VXinwwMUFVpa2aXTTuFpXUE4/l4UrQHbYa3NuhxknVneNCSebQ/xMCiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAtZnC0rjLjXZ+jx+pW8L9xXrPICTsjzoGChtOWqM88=;
 b=wppbSn14Dg702TnF58kxgxDz77/Cu0YI0cth+g/Z4LAQHOwwrKyk/rGqi5ccYhH88zyvzeP2AX6CkxbvesHR+oQpE1M1B/v44j69t92p20psuhTaMs6tuEnM+i2WYygDzLBu7rSyP3HlpenDURC5kIej25Jexn5m2/R5gnL2lUr3ZAkixefgDNDcfQCKC5Sm0QGc97IF2gBhCzhYD0rtT7t7pnfB+SQ2aKvC1lDF3Q/LELLY2rj0J7/2dpAEKMyjuyd0G3sHac9TTiQhcehIqyS4zS+FYGLVXaZ6pe2O30cgEl6QCLeJjbxSXSpVAyRvypoYKxtGYb0P7ZtV+Z4Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAtZnC0rjLjXZ+jx+pW8L9xXrPICTsjzoGChtOWqM88=;
 b=WrZYoInZi8di16pMrEt04GR2aYS30yG8baGPbBkDlgbbTnJ3oqbAA2CYUcIiemxB1fM+iFO09jHMFLhJ6JzBZzImPxErWHRIwc48sBYLKDjNdnNxUVJXIEiW7vWwRzQ+pOrqddKqFpFrCfWr7ulJkkT5U3XftGuX1uklXe/uEthtHyEYQuau+XZfy8shE8T96fi9W2Q/7gPCmK06jLhUnXEedg9z3PeioSV0Qbsy9hCQYAqDw1q9Eckzatv/Z5jMHbVhTSCp33XGOB72Byz8sL+oXlDgqmYWs2hj4rC8Oby+aLC6bq3JWk6smjsj/QDn5Y2FT8qyf1utUAb3z7Aidw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 07:10:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:10:28 +0000
Date: Mon, 26 May 2025 16:20:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 06/13] board: venice: use baseboard model for family
Message-ID: <20250526082013.GJ19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-6-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-6-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a57fd8c-996c-4a35-d0d0-08dd9c2464ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YhP70NG64D/hr4j0xo9c6bIHizXpNsKveX0j0/vX5UqN/2aziIP9SlOaSRZJ?=
 =?us-ascii?Q?rj/aHo5RxtADnPtvLBN9sb6oFBfmOmJkDaRkkXHFMmJRGvNEWbCTn3N/04Tm?=
 =?us-ascii?Q?bXddVUneyfCsd4/1v5Q7ZHh4lVTsQKN0s1s2LAjfUaydV0wZe0RAYai2iE1Q?=
 =?us-ascii?Q?QZyqXu9lmqRJvkFlnfapOfo0Dl38Y8X3zRlostNYD+8ZDpicXtcYzUVfVAYM?=
 =?us-ascii?Q?DJLyx2UaXLzF2C6szvFLnhvT8ZT4E7EiZQFWRwVNDP+pimRlPB5BIppo9BJX?=
 =?us-ascii?Q?eoUmwlcu1alidsIwkTD2CzDPamUJfJlHDGSHvFABs6fdHkSlB4wxKq5BVUqr?=
 =?us-ascii?Q?OZh/FV5i8kcQOe+5s3aWAX04DnfrtPI9nig57S4yRpBubHuC/lipY350Uj8U?=
 =?us-ascii?Q?z+5PuXAcqlX4UmuDh6dpxChD/tik1N3teTsIGxj7dcIEoVET/aZ4X/Qaz2l+?=
 =?us-ascii?Q?tFSYWVI/BD1dUPQZqOEWwVRtVvQBoIXCzA812w4eZlzbzJ6PlxrpJgX2BiWj?=
 =?us-ascii?Q?t3k8ZAW2HWc8zfbx4POVfajLDHxX5+lnTRvfBkdoeQIKDgl2EWMG9pFSPmk8?=
 =?us-ascii?Q?2NEi/KYF9otG4L+/50Wx6Mq7u62sKsQ/i1oMmit4KcPgE8WPoGc72aYWK55l?=
 =?us-ascii?Q?tKeLOeZoNs7VizBpMBOGj/tpC2qgTWQ6CHwoepZ6tz3/hdwG/qFmI6jg3+kJ?=
 =?us-ascii?Q?K1OgMdQkvxSJScKnbvOIV3Yjhc4pEyFmBNTbjEWPT1z9vbrxXYsWpq6YK4cd?=
 =?us-ascii?Q?spoanS9iOhyQhifY301enPPek4YHlPpBP3ZDTtO2RHcwxZ6WVf0lqzkBLdnF?=
 =?us-ascii?Q?fPqaoeh7KjYsVwhY3ytJnlhWcMXFODK4vMMXcNVb89/HHcMdaUyv3bIocvj1?=
 =?us-ascii?Q?CxxL/+Fl7wwt3wxpUyWeFXjsI/fEZO6Xh008wt0fszaVu2bohqnqrAroBhqs?=
 =?us-ascii?Q?QCeKQ5W1ED7qn4qkgAGBTDQUXX5gDmIV39gPqznaqPLTFi6hkMkQaAVHYpdX?=
 =?us-ascii?Q?REWVxqD4/2/8+ntxKvqwvggLB4juIaUD4U5deQeynym5hS6O+jWlX0t6EXtR?=
 =?us-ascii?Q?TB8IateeSAuQyoO1IG2LOrPNKIgXGTnKNrIoAEnmBS10AznMROR6L4LGKvh+?=
 =?us-ascii?Q?L9NZzvCq7ob1ErtrJbQKeBb6qmuc3hHtzoyACaoI6QiEWt9rCwVCCdCJywfe?=
 =?us-ascii?Q?wygTeOnU73p7M79AmchuKz3IgrPRBqTT7R3R4xW8kgqf5cWwnPhNOzawdmI1?=
 =?us-ascii?Q?Vkwz2V+YGUcNjYZprw2qho1C8I+0Qbc0xt4xMcicX18qYaq5kUgg4QA9KPix?=
 =?us-ascii?Q?6OkMQjky0UYTO4I60heb5GemUkHJayJY4rIlsTPIraTqk1gODlx79TWwd3Nu?=
 =?us-ascii?Q?LySQX9BgKVFR3ry/n1Oqi25XFWtJeQ0D529h+EFfGJhIQzy+9ofO4u1FHG7+?=
 =?us-ascii?Q?6S7oW7aSC6pGhl96KhbtHmttq4PxvYnC2IMqcMXI3OaAxm8NqEsBOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t86oLnFsQF3bgAw3s8JTwaVtZCWoIc0LNraWpNpAYmv+ApY6Q3nk9QI9N3dS?=
 =?us-ascii?Q?qi0qbAdl/ReSzNH35bP8ES3mAVUzDYdaTn873WZu8q8OjfMzBcMO43iEfAq/?=
 =?us-ascii?Q?KKRhFNmCdG6Kzmu+BymIhcLAZvRTF6MPYSQqWQIZ0ll+UsO2n1s0MXp09zxX?=
 =?us-ascii?Q?0Rnl0ctL3HOVL2GITl12Y9QrvHaRiFwkm+eNkWNctVckvBV3/mmLRHHYKNvY?=
 =?us-ascii?Q?iITLz/OBqaXU7AUyIkujZ6sdtfSMi5SDDYabhuXXHJh1m34x08AX6/6r/tYw?=
 =?us-ascii?Q?skb+c5pyShxVHatz2rI9i/mQdX++y/jDa5ovPLxixNQYdoTNxK3MTm+c2ElH?=
 =?us-ascii?Q?bYV2+xgpl/GPAGhLik9D2ADsad/YZ1JdS223s6oysJ3PMlXKfA2bBA+SPLzq?=
 =?us-ascii?Q?wmyZGDrHQjt1Q3FjI6f7SXrewz7mwNNaTQ35zFfYVpfTSIcjQ4aKEsWUEGk8?=
 =?us-ascii?Q?oDh9zCTFaMMr2FMVI0ICw2GJcWhnaeecpKAH/l0/yNQaZAKDA46ZONV1K1xr?=
 =?us-ascii?Q?J4oldXhkBm9COn65B+lFmSkcWGVc7rIM+qCDUhuh7SNwYNYKIwlhHcRYixxM?=
 =?us-ascii?Q?hUqkDxJV4KGN0IL0Hah2BcYtaaqnOT2PMcVtccTu1t1AsKqTNDbj5D1YqkR8?=
 =?us-ascii?Q?BqE5iEt/O4HtNPXJg4Xh2TpPQVBgPIuQehxUudIbBR3tbUHXNrn9gUxkIN4H?=
 =?us-ascii?Q?bSu7WYXnFagFBvJ187IonbTeK29MMq/6baJvX412DtpvlaeMzJVlcY44GB2e?=
 =?us-ascii?Q?6NDNWAGt41hRhNB7XLzALl9ybYosMnp41oPIGGW8gvGhx8TGKr0cwZEcrKso?=
 =?us-ascii?Q?BuG5veRQNdJxxvPaWfVqOeQ0oY5gcy9c2lioc3ZQ3uAMOWuBbJXCXXthwt6U?=
 =?us-ascii?Q?TbQ9PbxV61XG+i0OyN+iO1FUwdcjKuOLN4c8iZW1wBn4vR7jsTb+gaeb60Sa?=
 =?us-ascii?Q?hR13K2mu5Jrqc27TpYx95TQRihNTQyfPbupJOGnHQWDXEg03xCsoHBi4vGPb?=
 =?us-ascii?Q?6og/Wgl+3kydmvGBwHE/7weWZXD+C5wFeD1+uAQW8guzEl9uVF15jUEuX3Qt?=
 =?us-ascii?Q?/v1V2VCmDZIJsOnB0o1uj77f6nn/Un2g08I27CofCraKLQAUkXHiCbvmHiqA?=
 =?us-ascii?Q?cA+sa2k1jHNyVBBD49uAXrtEmsuy/ouGQgN15bF16opUN8dKtpSwluStAqrO?=
 =?us-ascii?Q?LrFjmDQ3FFsOqxhdYCsuqyFf2AbySfQRDLr1Skn1rCkP4muCj6khSwZhnDPG?=
 =?us-ascii?Q?E6LwcC0bFWk9CfK0fnMx86+ttx8gdHo/AfEnjmtT9Toy/miOpV1kV1lTQbp7?=
 =?us-ascii?Q?YaNAerwgJ3qIw4/q6IyJkC7YApLzOI+yTAsz50iwiofVxgnMHSX1+191lwjk?=
 =?us-ascii?Q?/e3t1lvGhSq3aCJCrDGAxVHSK3H3FQ7V6W5SCmzRCqEgIUUfZTDH55W8uqoJ?=
 =?us-ascii?Q?xhfH7JOLo6RSUUQjUJuRQq6Py6635UgASBlGKUnETCfpypoxzy1fmmtfUtCe?=
 =?us-ascii?Q?4k1o4TFXScK5uNpMSsWwxOWzLnyN0mYrDlX58z3V6zfN2eHyRRljdHaQD8T+?=
 =?us-ascii?Q?PW57R61AbA/snUz60bw4xn8IU872p5mboXgL6V2K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a57fd8c-996c-4a35-d0d0-08dd9c2464ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:10:28.0535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc4rE4IOYp6xi7oCuSLelsBDNbO6WP/B6Gme5+7x7IHC8mI7wlXW4hzWvHR+kkXKTRJ0AZTyE+dAGW3wetpO1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762
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

On Fri, May 23, 2025 at 10:20:11AM -0700, Tim Harvey wrote:
>The venice family of baseboards which is normally GW7xxx
>is being expanded to GW8xxx so we need to use the baseboard
>number instead of the som.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
