Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB88109878D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E7B84008;
	Fri, 20 Mar 2026 15:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CIybDiKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116DB84010; Fri, 20 Mar 2026 15:58:08 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029C483FFF
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFQ7ZDUy9reJQ1R3N86quBEfvLOijCuCndnnUZoVXB5u0q7+22EaXxT2XuioJpHcwvkyd/ut8GsDwOcA6LnkLsAgx1dW0W9rPur9I7uMbMIKgfKzNxfLE5VdV5/6GTyMgJbDdfwSOnowIY00Nu4ox/YlOwq/hP08dwUL30AGslohNFCR/KgSR9tQgWNoPxv4C0ARaQwj+3MOazxTMky3a+ut6rSKbJumBBP8OkvnJ4/CSuno09AbNPfnftvzsqJzbmpoqCoCbnQ3dsjK9K3/rQ4j6zwGLGI+8clg3x086yjIWpN3t+yO6pwhAPwqgolpLrAeUjQlmwHN98mMo2twnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ4VCZCu39bSm/onz4UlNwoLmHei+pEdLI5hDQm+8Y0=;
 b=wMMw+CmBq/dK39mQq//I7Wu0Db/C/qvGnI0j52sBA2SSwFo5bofhAQdgR27MosEMHQcEfzbG4EiwAwcXagR2GaAHgRx4egd0PMR4u/WzY45oHdVz5xm+vt4u3BdzgplngYefVTLjz3UghFCoG249mDt1A61cO2sxphmKU1QEXk7dYwUP1EArAQ7EyXPjuF0hjA3tFlEfY5uX4ibQeGjXcdgbGp/NYy7mY2vlrkm+mCUDMSQIb5snCQWQ8ViZKy2Nse2uprKGyEWJz8RzB93cU6nlapzlEA93x0L5Xs4v+HbOH8eEEKlXCu83wBnTVNojV1tnsgjT26Ji+hRk2F3HJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ4VCZCu39bSm/onz4UlNwoLmHei+pEdLI5hDQm+8Y0=;
 b=CIybDiKX/h1jxq3CLYsAF49Yz3cQQ52eiYyGtwEE/0ufK3U0VnDoluLto/9Z2xEFIzjVvBS50c8u7rcMNpWYjltU2nYdaXVL7JH1JQDMtftILLwKLvGDV28FV6sVsed/c/Q3kHSpSJ9c08g0mIRAttFavYfwqrOsDk5A5+3CJmI8upT4oT7Ei8Kcrnvb/cY909YMvVjw3cDDPhPm3wjG8dDAdyxqiqc+Bv0hfWcwfc5E8ZJPD6Znb163z7JetshszSnVDF810iKF2xrp2Mnp+GH2cKgxD6cvVdBVs37awXDscK1/D9TRFtyjr8CcIbgAxA1OXfVt/JoSGfrA42G7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9800.eurprd04.prod.outlook.com (2603:10a6:20b:677::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 14:58:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 14:58:00 +0000
Date: Fri, 20 Mar 2026 23:00:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Message-ID: <ab1g/jhEfgdd6w93@shlinux89>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: 925c3ee0-4437-464f-e449-08de8691141f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|7053199007|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: bS753J0lwQfWLLeZQei9PmfK+VNHcO4T3xbymTwUqaLR8UDGcMlJSceoL5pRHGyF8GhI4fYeLUrJAknaNU/vNMbGCbCQZD6K0nEe4EctrRL2EgLBWoE2GVdcO1vWZYegTzMclM5WmT3Lu8SejsU2ZKBNOhn4EAJhO7CUkRGhd7Iu96+q+cRcHpVunNN8JOnTI1A2lv/Zbexc0LoHKKlfuJpSb5pyO+YYhY+3YSYIee+Rxs1/1TM+hrrkzQwf8vO9OlEG3HwkohF2HNcsLR7GxBiDxmkgnikQCgBtojJqdCTfxatqX/hOnkc/H14vur/5P7j6HEZ6YJZHHcTy3Y4MSKhYUCpE8mblgM2OyDb4j3rNRi78G05SQOw0S9bs/a6zec29U7PI/89Kqn6u7ulSIW8PBZqn340Q/jJOFiG8nVnOtyP1q6BRqLc3TsdSouF+9Hatqg7zLR3odeQOzJOp5YmsP1Grfy4jARdiLk3iyEJsQ1QjkbA6gZy5yK90KASEy9TkPGHEIgBeXSFinJWhknFVXyCnb71kxROZ6fKxiXwJ/3KeuSVJ+UvgcYIpqDvc4vR8OrJZbX5q46KW8KLj7UbCTNVoooAPH/DVTqcYWY5LnYNoMkm8vHVo0Oitzb1SaztdHHe79mcxvjoez/ReMhmH7ax8glB380Qy+9IWKTwE9jwXgUh2oZ7iK3JBBc4icvOc3Ry/YKBh1uC26sQnb6OjTr90oMMwk4vBSO/YFjzLVsjw+9r/obZtY/5zkJMfkimOanwf3DwojHXyScQemQSP+Wo2t32UyT2lHFhISAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(7053199007)(22082099003)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hIvesBhrCLMuNAQEdod5yIXeLSuPt8Ju6BdJJ2SDttJnjnutXlTiquG7loq?=
 =?us-ascii?Q?DrNxwZ15K8MNnBm15tzWdMOJQfnxPnNg5n//rw+QBKF9EsHg2S1w2cU7sIzU?=
 =?us-ascii?Q?qNpUF5kVYk3qfi0IWmlR2T9OKMLlGnryPba+wlvyAuPvpfXk+3JGx2mwxQXh?=
 =?us-ascii?Q?jNKaXCrjXMfCuU82QWC8NUFG1VGvDjHbUvQUlDP2nB2n8R4s5t4Rp0NLEh1n?=
 =?us-ascii?Q?hb/1Vt8qdbWE+vsQWzzSuIK0X3lzdOvHCQjI9y+5nyX+7vbrHrTdOESTXuA+?=
 =?us-ascii?Q?uumddbfUFEiTjduYlKxmEP3cWkOItAXvpKAzA52g9OsModeilohA5FhXGRsu?=
 =?us-ascii?Q?qMCiAiRSKIF8m7xyLYwSrxfe5ihJpLN7WZfD1t7Mb17rLLSu5HD2nkwIVjDK?=
 =?us-ascii?Q?euae8QwFSrS38bamLm1f9ED4GxICusPG988hUPErkwwcI1kYZOd0BUnjVMBG?=
 =?us-ascii?Q?t5gtOZMrXGzwXxP/SHD20nyiDsL4OjqUJe15i/hyiKXBdONzoOiZjod7aXmW?=
 =?us-ascii?Q?ESVeeURQaLe6+7km1ejMEutbUIrD98z8AMVX4yFg6oMJBY2h+HnuR6gB7QQH?=
 =?us-ascii?Q?xadTjQUrxp24oLBpoUnm92gshloDIgERaDElXecXgAayDfnVDkzusdH6S/El?=
 =?us-ascii?Q?a4Fo2BJOMyioix8ESwPPc27xKYHUrpWTndUnI6W68VFYOvVTtbRckDPRtbIm?=
 =?us-ascii?Q?3vyCeTlScZNKYBBqJbcdw+lypxqybmaaYvpoFJhWSbO4/xRn2Vq+6nM1FCHB?=
 =?us-ascii?Q?lNHD7SAVfRdaUxdabr4o/7LS8t0Uua+Gm2xRLOpBeQzzgcMjhCeopDjxoZUE?=
 =?us-ascii?Q?JbDV6WZsUIqLhUsCoxr3T3pj5R09bIiLuBFmm48Yc2idXvOQqGa8P6eWUuMr?=
 =?us-ascii?Q?2tXNvIjoPNssDQLolRBpRGoegH83iy1Dp46zOjGc2mrh6O/KY4rEQeqQVC2W?=
 =?us-ascii?Q?4EziJO8KLhKlyTK593Oo18QvFL/UXztJhCge/405SptrLf6hHXxi9qDtd7lY?=
 =?us-ascii?Q?c9W37db0aByi1kgSLPo3ba4A37xM/+mOpL7Psi1+92lX+gmNLugDkskX50j/?=
 =?us-ascii?Q?/lTs+aQTzHbBCSET8ufGPdMgPsSNQYUzrBEs/Lf8LaJ6cl/R7ZQk5LnA/dzQ?=
 =?us-ascii?Q?2GDnjAd9n/360EYGFHeWedqDMe38eBqK2bqL8p/mNd3u9e3x7pQEbuJFWhSS?=
 =?us-ascii?Q?u9nqHlhk+lsq1NtRkZFqWRZhP2uGcSckjGF2lmx8IOekJi+P6jeCIiJYiUWk?=
 =?us-ascii?Q?UoE2Wv2RW+PkKmkSUz4RptJmjdkirUtgGbL804Ab7rKBLO4DgWuTRVknGeu1?=
 =?us-ascii?Q?i2CrnGiuiIN+tG2CL38h3rcG4iCIYF6Zpr4g7L0WJo2URuDJICnajjZpt9dq?=
 =?us-ascii?Q?YwWKtfesRaiTuEwxj6+Purug1qsQJL0uZEodUsvvl0nXbzZ3YP7vhvVvVEfL?=
 =?us-ascii?Q?d0vVXC0Y1QFNh8c4+CfLwi2Y7bXfFYWsZIRHg2JG/tSkQGVD9tNHcXv246+S?=
 =?us-ascii?Q?tPcEw8zLCqN59Gwwos65uVsx8ps2VDJjL0ddBwqsSa9UDSCpRfHjsvXKUqVD?=
 =?us-ascii?Q?MERrQhkPgcDxTcB9/PNPEsnyK7fYGILpCCxIazrw4jN8izwJWSt6G5MLzeKe?=
 =?us-ascii?Q?tTGBy3PqGuAUCAfA7+sK3YyDT/qT7odxU2nTCYMh58kgxJsjt7etLCVI4PPt?=
 =?us-ascii?Q?Gf2BRNspDsaHdVEvzshQGYO/iTUnQiRTEc8uYi8DpsohFTmnfBoLCUIzQtAq?=
 =?us-ascii?Q?4NDrdwLU7Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925c3ee0-4437-464f-e449-08de8691141f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:58:00.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URYFt/jurrv3Oxd3nTQl2Tvp+IAlqYzvNJxPUI8cLspszXaU5GkSpwJIvJ0+1PgHwuqQXAJx1YJ0rtQGosgvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9800
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

On Fri, Mar 20, 2026 at 11:29:18AM +0100, Christoph Niedermaier wrote:
>When two Ethernet MAC addresses are fused, the first MAC address
>is incremented by one and used for the second MAC address. This
>causes the second fused MAC address to be ignored. Change this
>so that the second fused MAC address will be used.
>Keep the old behavior if there isn't any second Ethernet MAC
>defined and only the first MAC address is fused but not the
>second. In this case use the fused MAC address incremented by
>one, for the second MAC address.
>
>Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
