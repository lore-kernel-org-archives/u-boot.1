Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14828EB365D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 03:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A7E83F63;
	Tue,  3 Mar 2026 04:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nNFGjMV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A56D83F6D; Tue,  3 Mar 2026 04:28:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222EB83F59
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 04:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7Bd1xBE3OIShAXuTAIvhdDwi+yQ4EwyH+RjqhGR1H9Y2Oc3YKLA+7stxR5TGQLDUm1VOYl7TbnIi0DGshdYTVAFta8FVAqWfuaTuzMZWZwE40a//hfQfr1PUfXgtpviDSXeIChte7El7V7GfVzC38S0L0aU5pgN5OBUOmDELwxzR9LS0oA2ys523vVTUmBmsu5fP4h5UEz53mT79f909yBSfTPP1UvFfmQfushZLei5AEzxX8Ib+/6y9lp0MX5lDwHjOhpktbaruSqvkApi7RHiqV/9g1HXski02Nwk+//ywXtBuSSVorqt3C9Oiyb51O+bVXU2fzqAw0G59uaNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrJIEPQx9TQUDC5sQxTPElTHYB1ozimjI6n3/vrczcQ=;
 b=DUWjB1oB4T+NSGo0RRxNYUNlLAKoMsw1GdsWSuVX6m02f1pIMoFILkMbnND7FoTj7tK4J3PCl3Xvq0zpZzzKmY0HF2hjeDD9WelVIJ0fb4fgtsrIrIcKpyOmXIhDVD3bFfGtJe2yN227k6r1aXIHTIP/LnyRIhQMVJVRSb0MbWrlSAVwCC04yPSTSe77Y8F+H4NbFMXa50dNIx/I/EoSxjLazUUG9UYFJaxSE258mP6H/8KaLixAtX30UiK2aq0uw8womPL2yWZfZF1mIFQZt55I4MtJHaqtR38bQzWkKF0VI7bdCwE75yvz7MK7fPwQm1F+40jC18P6zun/Inj3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrJIEPQx9TQUDC5sQxTPElTHYB1ozimjI6n3/vrczcQ=;
 b=nNFGjMV4otFBzsksznaFuobV0ePVVd+ItWdQstuCVt267lRYrKpUuQB83jhsEXOolTtWZZUTMwWHR95BRtIOkKVwDzA6KtNBdXA0J4xI2azgfRUyJ80DQBJiNGIZP8SfN5ZEd7qH0tlP2FFPDQpYMNziCeLzP/OBDkwt6G8CXvytoztULmcy2IY699ZFcOqWShjVDC97xLxozPrhbgLjnRwQVLxuJIVlAFJRZrg6zN9piND3ANC47cztZMKe7BYgDtUwJimyq/sIjpUH+YUfrElIBq7wSwbOdrxnqr1O309K2j5cVf3a4VNhh3pVsB8vZFbIZ+VLdjczdoyKUsOLsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 03:28:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Tue, 3 Mar 2026
 03:28:42 +0000
Date: Tue, 3 Mar 2026 11:30:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 3/4] imx94_evk: Get ownership of XSPI control
 registers protected by GMID in SPL
Message-ID: <aaZV3KhB+0SgBUVu@shlinux89>
References: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
 <20260303-xspi-v1-3-8383ba6fdda8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-xspi-v1-3-8383ba6fdda8@nxp.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d04f51a-f25b-47c5-90f6-08de78d4f807
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: jzGdbPv6GR197S+dkHdMjCoRcSdorctBtjo7151VXh90QEpPBXz3Volk+CSmRoZten+5sx3kAdlBDUh+qx+VqV95bAscdxi6sKCllG/4wLbH5gXif6b0CAqKETqNfOUqL00P0HNILyuu+6Asylu62nOs1glvhKeEZIZQ/bnCWycafe+HSrhC/MWoOr4H72yoIJy8O08zksbfZXrW19G0rTFbbKK/amvin9KosCCT+YIweOEJzhNY/SCSWtLCsoaufBpMCHmMXS7I51cXw8KcmJqoLqgrhtyBJwUGjZVNnNRHVOySn4E4H2/YP4g9iBgNbY6env1B5oD5bvxipIbI6vTMAiU05joZ6FSf9v9dZXIJsErbxgcUSM1uR00KHQd2eNvoIcXyJTxPyr+7eIbRSb2Qa0y8AS0Tl6UylaKiX4s3aYT4x8yqb/qgXjAW2Wq/+tLsBZ9WvjuAWS/aK++s5KRN4s4FSFx3PvIBES23WmqY7t86opqkpuVklDZtk3wL8wTTpCR9DCUPH60aHqn9NO1ZPsiCOlfLHVHczN+wefiIzbVtpkixrUl/NBMDzhA9B8n7fKfMJnCEFrSEip0zwW9HmLLs9LidN9tur5qaSCdxvJ1WFJFRBeON0L0je6OMxI+TiPSc/CdjNMXGu6EXeNutWkaCL2gdMsuEXX5Ei/kjAp28Zadap70QqQdZQrs/q/2OYoXJH6F4YUiMNX4j/XvnTnlYmOI57yO95rdW44neggcRALmrImUfurLw+NBIYRszJqlCgQ1rUnuLB3LakWx1PQ8k1vqx1PgkFpvd8dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n5gV9QXpCdcUOhqsgytkW2FLBO8z9h4FM7Wqnrnjiaw6VrGX0RvtiOQGTBM?=
 =?us-ascii?Q?JowHvOe1OzN9Sspkrd6kH+Hza0m8Iv6hl2k+sK1438UyZO1WuEHT4NZBZm8T?=
 =?us-ascii?Q?MYWHNTQjNkrCQ0kiJElbQYFPI9N7BDgJznKGHP5O/d7sjnu3e/8fMrYnJ2zS?=
 =?us-ascii?Q?jbnZKPhiyG8OJ8GgvBnkXvtuXT/D/Vu6bfsWOLJOcxBRoRnwewNZHc1Ulni9?=
 =?us-ascii?Q?Ri+WRC4k1hhoaOBj2D4FUsTKH2grjqoY8DpuVEa3CN2OjfkG5TV6DEuA0rDg?=
 =?us-ascii?Q?TZO6fjbi3hWB+WKjTEH6tq6JgNmNC3WzDMuSAZyE0YoYGUJ/GPI+l0048767?=
 =?us-ascii?Q?n+w9ah8gHukjxLXzUVQmglOh56Q93s5BX1OZykNrn135zt2G3gHrCPiwrpPN?=
 =?us-ascii?Q?5oCw65SnhzKRdpLq7Z3vJgJ6t3eRjstfLSsBsuMTjMos7Y409zaMZXlyyg7M?=
 =?us-ascii?Q?QYIVeS1ogWOJcC0cmqzl/nPGRXkXD8AqICkEKTDkIViBD4sBwMJnlbk4AWex?=
 =?us-ascii?Q?9eYpqJm+X6w5EtzXFCuvCEPO8a3aLkS/GGaBJ5mB7tkYBxExJhK9YNUE8Vk7?=
 =?us-ascii?Q?u5rH25xL48lpb3zb2f5xBhke39jkxS5aMs8GVJBCJm0gvPHim2JBfjcj80+w?=
 =?us-ascii?Q?aCO0YZkmOnpNV9cC1eNtr1tVne3uD7VAc0THaTxAJAOhq684rsfIg+mTu4bM?=
 =?us-ascii?Q?/QxeGJHCMT3XSG+2NQmVMjuBDd7cf3bdh/CFWkscusSqU6Q4acOTW8OfmiyA?=
 =?us-ascii?Q?9GVRAIKDqyVtxmNeKcvJDRSm/HEQDAS+CIEQW+nEieZZAcjv8A8R0WRxmTJK?=
 =?us-ascii?Q?h7tOLPk5/jCHOXT781phD0SCpLAehIXWiBnHxDRjaT4OexruIkSKbsIuqNSm?=
 =?us-ascii?Q?a6mopFHbbsOe9p70ta+AFMaGLErdNTo/KqxjIykWt3vtti9yZhKQgcy/00dr?=
 =?us-ascii?Q?PMoP7u9TLTzq2MgRmYuEa6g4aWuILoSOwDqiOhfmFwUkhlrOX/vAljgM60aR?=
 =?us-ascii?Q?m3ya6RIio1CAUO4Lqp2ZevuFnOqJbYbnIUq5cvXBhZ5qFWzS+BiTATdb2AUO?=
 =?us-ascii?Q?Ixg41UlPABRW+jmJ/0jAcGdO+IO04dTcgiz0BCTIMAM5WJnuHXvzmYKck1Au?=
 =?us-ascii?Q?jgnjRCxy0W/mRfYnWaFbW0OLvYDK6DXnScjHtftJt1DoYsZyXGm9TLLjKINZ?=
 =?us-ascii?Q?CoWVps2Nx+9DtLekIl9YIUHwhnxGebSJLnnF7dYhjAQ/CMdBUMAW2vautogO?=
 =?us-ascii?Q?WNtFl6L6gq7Wsw40eLJunaK2YXFF1vFwKKzQyc7KuQ9gltVGln+28MQ+ezWq?=
 =?us-ascii?Q?7BekVT/gISUskQHNZ8CQcZkLTx7zbRLVLIqwzheGKfyEcLQqTWufVtIU1Sws?=
 =?us-ascii?Q?Tn9BznfNirxsE9TgHMDu5vxOGUFujCSDmPh+oKS6qwYM0nUblLmlzSoXoP1p?=
 =?us-ascii?Q?0en+5g0+Ki0j6Sv2dbrkbzkvsnFRe5ngldUOEzX1jhUigKMCL1zwDwn0j7p1?=
 =?us-ascii?Q?Ef0Pj338BHQTEnEWH5r78G9wupWQk4D875UvVMH3myHR4LPGIbsazoR75c4r?=
 =?us-ascii?Q?5rQgnG2sKXwjHzzUFuHll9hsW2DDSIoJCq1BzbA+4PNVBVsTFAuELdN7rWIh?=
 =?us-ascii?Q?wT64XCbqjbWDl2XdRz/qTaQwx6kLMpp7m6IdDHUkTT8iRObtYgVURLbYCD0L?=
 =?us-ascii?Q?rJ+lBdp93VbWkUINZT8D5I6pJCFz9+jpcn5szV8ryAQ9Yv/IGPCqA9gxK6ru?=
 =?us-ascii?Q?Jwn+SioG9Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d04f51a-f25b-47c5-90f6-08de78d4f807
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:28:42.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgteeZQy0x8p8YI0hkO+xhhG70SWK8h2wt9/IU57sl+Nhn8h85eklTf9WX2Kf3HPQMbveeac6Qnpp9drmz2Cyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498
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

On Tue, Mar 03, 2026 at 09:10:28AM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>To gain access to certain registers that are protected by GMID, the SPL
>must release XSPI ownership to the current core.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
