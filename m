Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADECBC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099BF880AF;
	Wed, 27 Mar 2024 14:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kjH3WueJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EFF48800C; Wed, 27 Mar 2024 14:11:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54416880AF
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLo/d+zn7qsW7woV1gKSxqSL88eFamTxaI+XrdoRv0/9clIHVr1eAXHu0G1ntmmEzBcM+hrvFtHE4ivaUEjLg4Zz1sSlBAMg2rKLezgLzbzoAQNNQvT7Np44tCUVlLq7zEOAWgIqOKAo+XV8aW73rbIJVR1RE/Q+3shOOV1cyvbG9EZxvWG+cJxtgXWDEwvNTsnma1NDZbRg54XhMdzwrlhxlk59hD9iKmDICwjb1NOA8IPAV5Mfsmb3uOrv39PVed7elvHsaz9yLnJox0YGqmNMR7dIOC2mq5dwRwb3Q/JOVmDi6iGZxUbHg8RlFS4qy9FrHxQ/rUY67V684bV7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=PH/FTgrw1V1OJ0F+YAzsSr34pZZy5TFSZL74oxRNSa3Q0Icikf9YHRwl/5juxRMTTnlSht8O290tNc2IJFpRwjpT9oBWWUc0nhgM44XPh8t3vA7Fp/Svq7Q2QtDZp8sWAYXVW96CZcfqzeVhN+9wsrtQ1j1XYyLGBiM9Rb2voBnVs3HJQZEpYKOzTUSTug9aeXl4Ak6+QocnXRlpRwwTeEj5OTfxErkb/uHR7KmRqXfdU6hGkexhuDmuMYxCEFXyXXRT0rzdlgNOewDhyfRYGmj8C4pJAOHDXWNcgryCFjWvOAnJB7KfqVGfsVcYGWYPEFSA096EaCdpsJ6wTNV00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=kjH3WueJyrPN7EesV+6H3gRdWCJ8JD4EmcCk5LeLdKp7gbK7SCn/cottM1uLB035zG8YBQt0MwTLJ74iKqBk1MJWQwLiJNeg6OIVEeyJtbAgXTtSYTiCncwQVuMq4JY9WTKgNS7HefLh3TODZI2CnAUYNM/w3aIj5PMoZi5dywg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:48 +0800
Subject: [PATCH 4/6] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-4-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cc7db4-1ea2-4e04-26ac-08dc4e5f6586
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdbD4r6V6VpoBKDP3nZ9L3Ozyg5dPihxWj3KP54cyNt1POhT68U8uTJmoe7fnm7fpgWDf3hN5U0smga4I4rekH6siepnYcxuAeTuFkUzDkPCIKgAsEoK4F74aghBt2lQBLz1GDgeGBBrCC+WgrZ08fccEY81M17sYP5hdp4+oP4NHE0LTxbIlAi1vAcbY3SayDKMRsMgLqvcSiAmHwQoP05M3902C0q6AGmV2c4EqQN3z2gqZIigJJI3RTqk2lx+CAh3ADUh5tNDtFcqNhJV/NHiZ42K93gtJPK0xhg9QKZJ5aJm9rcuWbfYUwS193M/SCpE8nUXSHer7L4XGakvn/YFEkjD1X9Eeu3LKCgE+i6E7goxdyVnTnZrh1wTjjj7R91tZCAVxZ5VpstBn/6Onte2hzkkDbcJQA7YE6BCFKgNV1X+c/XcGecSWOfUxUdmJ72l65u1OyFpqxeFQSMp9vnuJBFUHCZRNipSSXssdm7dmE6fuUWU3qWsSZhC0V3MJ4WPxH52/5gzQS7wXaoFCVlLUTv5hxB0N5DAuShVG08hCTVvBVUhqFuljOBEvRFY8J5fupkZxOb1nYj6aj5yAErwHCWMYtpgio5dQc7sXtDXV9gQosEmMEbdo/vVM7K9RyH2aDEHsLtE1Su8rw7cC12wuXNOBW3yF7wo0qHIxvtkCB4t9SlXquM84/UgtyGK0LvAuyRQgDbqy7ugWRf19g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVIVVUvM3BSSzd6WGpPYW1LWlpWVE44T2JKZ1FOR1F6UGNmRHJvaUVVUU9G?=
 =?utf-8?B?dmo1c2YzU211NmFWT0Q1S3J0SExnWVNsZDQvVkhMSEVha1ZuSTVkRmVYZ1RZ?=
 =?utf-8?B?QUVrM0hOcVJqY2F1OXZZTVFVY25mWnBEck1xR3RLWGVveFoySFV4ZDN4RDN4?=
 =?utf-8?B?dXJLdnlYQmY4SlAxMmRmaENYcWRtNVoxTzE5WGJjcmx3VjVNN0gxbGpIUzEv?=
 =?utf-8?B?enMvbG51NDBsTnRUcUxNZk85ZUhaQzZmejYzVFY4SHE5RTFZL2F5d2ZMdFRG?=
 =?utf-8?B?WTJrK0Qzbm5pT082L0dENTdXK2dPNmdDdTZEUGxMVkNlUjE1NWNmbDJIRGJi?=
 =?utf-8?B?eFFPcTFvUWVVeGlhZnkwaTBmR0tSOGQ4aWxqK0hhejdwSlV4MkdoZTMvVEhj?=
 =?utf-8?B?TXM0czdGRHVyTVUxNmpnMzZ3L0M1YjN3THNKT1V6dW9jaEtWUUtNN2JNb1Zj?=
 =?utf-8?B?NlFWckluYlV0dXp4aGFaT200RE02ZytYT01xSHJJUFNZY0cvejdkU0ptbTdL?=
 =?utf-8?B?dVlJYnFQZnRldU40WFhQY3VLZXhmY2NWWjhMTy9MdXBIZmxKNWp6bjNhVm5B?=
 =?utf-8?B?M3ZEbFBPUzRTUXc2Ukx6cDdvRlhXYm9EVnJSVHN0bzJIa1k3SWpvYkxRWk8w?=
 =?utf-8?B?QnNsK3FKTUVrczBKNjBjVWh3Yy9CQVZSMy9neGJUbGUyNkRmdDh0YXgvL05Q?=
 =?utf-8?B?L1BtdllpSGNKVkJWNXhTcHRocWpvR0VxY0U4alJSWENwSFM2aVNET2IyRGpH?=
 =?utf-8?B?aHNDbFVvcUc2Y0kwazlRVjBsRkxUeHo0YnhZRi90RXpRdzhnYjArN01FVVNG?=
 =?utf-8?B?d2V0SitGZ3A0MFRDcHhheEd6OUNtSWd0MDh6eW9uRm1KK3R1WFpwWGplZjRy?=
 =?utf-8?B?TlZWMlBTTDFqQ1dIdkpMNm9RWVEyVlF4V29JNjIrT1l4SDFseEhrelR1Wlcy?=
 =?utf-8?B?QTRZK09yWUFrTGM1bXRCWUxTN0lmSlhmWDU0Y21nV2lsRzE5VjNzazg5T1Fp?=
 =?utf-8?B?a0ZFN2x2NTE1Z0xqUDNiTWp4a2dQUVp4N0wrM2JlaDhjTmRrM3F2UEV4bVk0?=
 =?utf-8?B?SVArajhuaTd3a01wUWc4NktLWThLVUcyNS80YVlRNm5BVi8vdVJZSjdUZ1gv?=
 =?utf-8?B?RTJhaUtQbk5ZN2p5d3Znb3N1MDl0M01FZTdGZ3IyWUdiUHh0czVxcXkzMWlI?=
 =?utf-8?B?YlVrWmtzSHVWVFJ1UFZHTjZxMmk3TjYwemlOeHIwNDEyRDZmcFFzSDV5YTcw?=
 =?utf-8?B?T0JpZUgrVnJTTWpzNTVBZ3VVQXEzNk1HM3JZaEREVjEwcjdJVHZpNHQwRXRX?=
 =?utf-8?B?RmgzVnN6QWUyRzFkdXVVdkpVUC9pTk01ZmFJeFFMVkZERXcxVFdnTElhZ3hl?=
 =?utf-8?B?azN5VEV2djBDUFdKdzI3eEM4K29ORHpFd1h5TEg0RnEvNk1jMFlZNjdHOU0r?=
 =?utf-8?B?OHlRcDUvaVpvR1ZrUklWOWpXQlBCUTZPcTM4dTUzWTQvMFRHTEE3ajRJWlFS?=
 =?utf-8?B?cEw1NGQycGhuMnpsVE82U3hNbDlzZFVFUnlTOGZoVjNJSC9yVEVpRXVoYmNK?=
 =?utf-8?B?Y1dyWEtmbk1XSnlWdkJDTjVWNGhoVzc4SWdrM2pLa2VJd3FmNDdTRDhXWW5O?=
 =?utf-8?B?MkhrdDR6eHlTNktzYkJYdnBhYmt2VGpydEpIWTJBVHgyb09FOTRRQnI1Y0F6?=
 =?utf-8?B?N09TQitSdFFkZFY5TnE2bWRESVc4dXd2dHJMeEVVVmxsZHZEdUhVTUoyUDBr?=
 =?utf-8?B?T2hPRzZkOTE0QUtnbVRnZzI5UVJTTEFNcFQzQ2x2T2ZpcVUwMFZlTjJhdW94?=
 =?utf-8?B?cWJRd2lVYzJwM1NHcmJNWVN6dE80Ui9BZHpHVmNKZFBRMTFiVWdRVzZoL0JW?=
 =?utf-8?B?TGpVWGQyaThIMTIwNENONG9uYXZESTFRQ3QyNWFKZFZkMFREdmFpN2tKbXFt?=
 =?utf-8?B?cnBzQzRFdks2UVA2S0ZBczR4NTVaLzJiZWtuV014TUdPdmJ0bWNnVElJWjUx?=
 =?utf-8?B?RmMvTkZhNFlkTCswK2dEN0Q3enYrRmRDZTlOZS9IMzdRRnAvWGgrYlU4SVhp?=
 =?utf-8?B?d2RRdmJlTFpXYlZFSXhMSmJneXpHV1Q1Z3laVWIrckRFTi82eUVVbEZFR2pK?=
 =?utf-8?Q?jQtmXVSeimd4frGvjVov3HeFX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cc7db4-1ea2-4e04-26ac-08dc4e5f6586
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:21.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1a3vAM3fw9AwCsxWp3ECuUHTmzKAgDaRe6PpsJDmNeVEN1/wFCb28TfIYJz0aG/9yNE51nv5buUDsUKmk6ChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

From: Peng Fan <peng.fan@nxp.com>

The PLL clk needs use anatop base, otherwise wrong PLL address will
be used.

Fixes: 9c153e46661b ("clk: imx: add i.MX93 CCF driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index ce10d795316..f0cb797d975 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -289,7 +289,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2_DIV2,
 	       imx_clk_fixed_factor("sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
 
-	base = (void *)ANATOP_BASE_ADDR;
+	anatop_base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX93_CLK_ARM_PLL,
 	       imx_clk_fracn_gppll_integer("arm_pll", "clock-osc-24m",

-- 
2.35.3

