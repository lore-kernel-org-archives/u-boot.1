Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F637C61DB6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 07:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EA0B606BA;
	Tue, 25 Aug 2026 07:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBeUAFj6bMhR; Tue, 25 Aug 2026 07:58:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787644705;
	bh=Jlcx3HhoSLdDRBhM7FXDIi0yekOZ9q+dzqX+gFPYvk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zdh8ACp3hTGBYAs3zNV302I/Hh3RDBwtk7xsrYmV3sexh6gR5BSXG7i/GY+zWZDZi
	 /bxJ4ZqnilXa5eHJF5bCOQbrNJ9Kp+5w0t5aGTANii1zzXiQztd3hO57VjRjOo4vRm
	 K+z3LAzzlwGpz0SQObC7g9z6V+8Xszq8US8Of/6/5bfwrepRbeC0YOqaHyG015VY7A
	 zM3SNJfb8xFGKzBLIJQKOjzaKOvhz/dyPw13RyIf+49EDa7kWKGPG7h38ekGqZRAzL
	 bG9A4yBBt8O+l0GOI8S62SzNE5DlYuQ0Bk/1PWC9Usfoz1qj1VyC4HTHBXitpSqFlW
	 bxnnbLtPxu0mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C710160618;
	Tue, 25 Aug 2026 07:58:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C921118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EC0140582
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rRb9Ayka74S for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:58:23 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rpS0ce7q
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E68640581
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXKyUtRb01sZULSUmI5hU2q6c9QXYkReuEBe7GHaqM9AzMQk8qcgT/COeYT0k3esgDe7EYxzDHCB+1xIwKMZaAvwypf+IitsbS9/zHLA2Kd6CAfko8UbWpgjsh4u/7GT2icmPoJOi0bcSc1FQMNPRJEIDx/dWjhdRjx75QgI1wECxpqTZPfOVQq/FQspKr6vtelrQsrNlXRXDcl/+KPhuLqPf5zU/xdDHbi/heGxXCD2LY32YRH+JiV4eb+nbEq6DGvvN/Rs7On6wqv8fLu7Nexh3BwbZlytNbLV/5gz1TEUaSZNO1T2XEs5d/mMyddzuJkL5H4+dOFy1fbb35wQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jlcx3HhoSLdDRBhM7FXDIi0yekOZ9q+dzqX+gFPYvk8=;
 b=WatQ/dG0lLK1quoHcqMvIqAOaCGo7qNBvSzqPDJUhrmuiFQPGICLuZakl3kKxyBHwILvMEsdnRYPPfxaSY5jLQfMqcQD86NeYEdzyxn3TQkxkfMULLpaxo+D9VJ5A/0Op4f0+Czd5aF3ucEJudG70G0qDXlTTSyEsSAHFF5LHX5DPH87XQSbT8SaA2aXOr1h8wa72ZVGXXQY2D1iNMsOczGdI8VN7kMrJGmq47OXhuwX1vZjHgQZwc1Mi0sGMVcIJ5J39y2ODSn3D72qxpW7eKCBMzpxvPnJIUcXzV/2hGoQMG9fdzQlK4enA6lV5yvDE4zPMYS/cIqf0fPM6O7/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jlcx3HhoSLdDRBhM7FXDIi0yekOZ9q+dzqX+gFPYvk8=;
 b=rpS0ce7qBEGMzlFGNbu/3Nt5TtCnMluHzPLf5EP2JJii2IwGqLcoFBxgFiiflY5pOjbMNFAESWoAfaROFyMJsajKpKf1zbDcsrhCyE8HplMRt+TISTluyFSR5/DmNyluwfrF95w6YtFsK0fLUqa8wEChSuT4VuQ/QF0wo/yLVkWHrLCysdUiP4T3rbyhbkhaUeLy95mGvO6tswXANYFjoXqWjtv4Lsm/T2VsqEa8/sh91AUFVYljMimO2hCCI50F0WgUtDO11doQrNM3A2c3lctBC93/fnSUaR7C8koKW+1L7JIMMcQJ5JEBLrExPOYSgtypBtcXY5BbJONs60v1CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 07:58:18 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:58:18 +0000
Date: Tue, 25 Aug 2026 15:55:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1] power: regulator: mpq8785: match the MPS MPQ8646
Message-ID: <ao1KjFx11WFYvwTB@nxa18884-linux-1.ap.freescale.net>
References: <20260824153640.2769317-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824153640.2769317-1-vjardin@free.fr>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2203b92d-44bc-413b-ccd1-08df027e9f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|19092799006|22082099003|18002099003|11063799006|56012099006|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: XxZaqV9Bv02g0lRSCK1deXu/JcH5M9156vDqE3++V8fDp9EEiuLJ3SHMwYHtNJ169FUG7j7pSa9NhRjOFJcNEjOq3nxg59cMwypF6xbjQntAx2mw7RQopjDRaOK0iBZlUcX28eLQuT2JRT5pBx+ankohbX5wQ3/0ALo93kW4of8ZZjEeCx7N1EDKRcS8a0pucOanlz4Y8jV932PfK8Hl6baa8n2+Ahw6yfOLHt5TtTQ5IRUjtCibF9qMKEIkQWhy7T/BNphG0BgAmOEihM2/gGiBPPHjmt2Kc3yW1deRyoAS/I8o2l7qM/H2ezWRoxDg1+f9K894PVKLC6XkhzAiyvEgiTNy2+F4CtEzRa3KTCy1vmh1LCoVW4tM3HDVorauKxOw790a8l6GNCiq95kf3hH+GhNe6uYFgqnzFpwugXI6qeTwa08OBJsFzFoq6Lf7TackUhcHEQ0pW5GC4ueszTr7nv/OdJbkHAGzzRFKvEqbwlQDkuj5bnUg9etsheSAT0iBiW9zomQJK4f7Rfkp5pwFuj6bmdJtWXHQEpmDS4K+DBe3qLirgtfRomPfz4AHovzsfHprX1VSCZdNh0P1ju0gAR2vJCdyt3kCt+ozVy41+pbSIgrmfNfpsqtRjb/e8jc4LrqS3VdzMDWbRr1SNVWcisw5HKBqfXS4mSXcMsR9ahPz3h64+1VsAFiiyRe8SjYMxcKodgS+9QwKLt6eVkDJWeRs9LoCIi2MRVQ3QVpvdzsFXXaUyg4L522Xw0se
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qLymZY0bLASNDmowM/3ExxVaw8vozBy3MDEuDDtqChUnGx9C+B0y5fomL5+?=
 =?us-ascii?Q?+/GZU1p8A8WjySUNKcyeEdCk6g4xYvQX1TvAULjUGLBaxwtpR6RfClIIbuHr?=
 =?us-ascii?Q?Ly3tU620hfkD31PSInEZYLAEZ66b6BdUvl2qVscRz048YwG2kh9STFbVldUU?=
 =?us-ascii?Q?cJuD/rawYQz/7afVN5bcNVuGBRKuYcp+YAB4DI9z5UXnFP9q43SVipNBkplU?=
 =?us-ascii?Q?kYOIDfZNmvzUL+Fj2FcnYbZIKiKEmQ89TvyKqzCxEoeYDQh25qJzd2H7vkmT?=
 =?us-ascii?Q?TpWps9lEMJ2nsDwqaz7KKbP+bvLD3x68aWYdeEnHvr/BwKYPgjJQsQs97riH?=
 =?us-ascii?Q?g74E/e8b80wwSfIVVN+6+Q0fGNGEcNzwMSAG3jpE/3EhKTECsCmWJgQDWrUR?=
 =?us-ascii?Q?IkNkcVhiyoHBPguYwd8z6iJrsVU/K4L0QNo7nHmP3SndOSBNJxz9KAKftim5?=
 =?us-ascii?Q?Iv/vQGA2eaO4QpbRNrsxM7NRQUVk2MhY9szAxqjO05RALIvCs0igozsDIS1e?=
 =?us-ascii?Q?sFZzBiKOlbpbsT2JSzGHDbBjD5SGCQlOKFK8c92b2u/h0s9dflxRGMk2HK1E?=
 =?us-ascii?Q?1Le8cuI3Nubdg/7OwAL7NVAFQN6CxJqhmd9IOEv5D7yGxdp8DOltq50O8ByW?=
 =?us-ascii?Q?ViPXWaJhEo4ITHIOHH83QDNM1w6f556JOD0LNNQ6PrcuCjHGLSkvo6Hu9eIP?=
 =?us-ascii?Q?wOFkQC9VUSVJ0MtpyhiHKV9I42Gipq9eXe7X10jyBBzKOFw5ajb/w08/Xbwp?=
 =?us-ascii?Q?yNbG8XpT56Qx6AvqqvRX2lwfJEM2winIB22a9zp8q9xieOJZDFxOe+3wQLbw?=
 =?us-ascii?Q?DD4SoRBiggv1vbuXTrqfzW1mIwhzSqzXjvfj8h10g8vou+d0lHNC/CzmnoM1?=
 =?us-ascii?Q?5y1Fp5zI5p42Ki4IVq++5ocmZNl/Xb0NnT4n5mptIE/gIz3/syZmkej4Xg1v?=
 =?us-ascii?Q?4VkDHfBjSrT2dkHVUGsBMMWouEjmyKu6rUn9RI6lRM9ZqWUndeH4Km2fH/m8?=
 =?us-ascii?Q?TPNEqbnKLSKJ+d7JcWHB5MJVinZSKi7+D14zcpxxDlvokNCme9URggFo7POv?=
 =?us-ascii?Q?Y/Pw+JPkhijL05VO3+b/LDmoblZ7A7c6Wd9TTAoC4cCkeTQOhWFCLV4mpAnK?=
 =?us-ascii?Q?vxrZmFGBtTK7MlHglWrNyxQKbGt/Z8g2oQzn6IN0PNQwP0+HbHqbDji5ESNO?=
 =?us-ascii?Q?EnkFa8xGhvgDnSj0ifrT1H1XR9jcgc/8IUf0ZLHir2LXwM1Rua3YOoZzgkCL?=
 =?us-ascii?Q?pEhDlruuhz33WYdR8MjPg69WueSzInBnGgMqLRtM5JalTHfrilOcppWUb1jy?=
 =?us-ascii?Q?1rEiUYwcftzs9K2dOoEClMzjOpR+f7u8h7MWkG9cT7/gsWaktRnkwlCZKpDl?=
 =?us-ascii?Q?lalhjCIWSO3c7671GgRtlaWS2FuSP8tC50/2H1lp0ZjC18rZ6YYo81VUYH6k?=
 =?us-ascii?Q?48CIZpn2jDuHoy+ndGp39tYWxnmmCj25Pyl1oY6Rqvh1OhWnAC8uU6f5icil?=
 =?us-ascii?Q?X0OQ1Ft0rqW2svXUkXKbmjnLylA79dAGPYdNuxJnK61gLLT9T5+v+cpXE02k?=
 =?us-ascii?Q?q0PFkGLLO7NCY5T0WaJ2/M+jZUvHYaiS5iKQ0yC7+A18vbo46O4pMuieJk2M?=
 =?us-ascii?Q?i9dWpItbcyMoxK/+4GS1TTPeqE8H+7VQeQ9QrQUNBv/JqvRH+845dxVzsG66?=
 =?us-ascii?Q?hA6VZ53sTnO22cewz13C7xopfHc7o+4U0CgAdx5SgivE6NmWZW6pH2LBYqBy?=
 =?us-ascii?Q?6nFdEygyzw1kDRKSQ+OVVQxlHbGRUeXsobzskODz2ANT+Raffbe+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2203b92d-44bc-413b-ccd1-08df027e9f77
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:58:17.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ypLcjszA43KKgK/y8kwgXbBs2X2QzzPSsT/qk1G4TKZmlbFJP3dHFmPcaErM9C77lYUEeeQ6DMRIhoGESGuiFiQf8omc46LsBVy1pTLGCRqHINzyTXTFkbO6vTWstsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 24, 2026 at 05:36:40PM +0200, Vincent Jardin wrote:
>Add the MPQ8646, which handles the same case as the MPQ8785.
>
>It shares the info table, and it shares the VOUT:
>both parts report VID in VOUT_MODE while actually encoding VOUT
>as DIRECT with m=64 R=1, which mpq8785_identify_vout() already fixes up.
>
>Linux does the same thing from the other side:
>drivers/hwmon/pmbus/mpq8646.c intercepts PMBUS_VOUT_MODE in
>read_byte_data() and returns DIRECT when the chip says
>VID.
>
>Linux gained the compatible in the shared binding
>(Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq8785.yaml,
>commit e7ba3115134b "dt-bindings: hwmon: pmbus: add MPS MPQ8646"),
>which groups it with mps,mpq8785 for mps,vout-fb-divider-ratio-permille,
>the same here.
>
>Verified against silicon on a board whose +0V8_VDD rail is an
>MPQ8646: the chip self-reports MODEL="MPQ8646" with VOUT_MODE=0x17.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
