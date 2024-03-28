Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71298815B;
	Thu, 28 Mar 2024 11:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="sA4LkaUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140158811D; Thu, 28 Mar 2024 11:48:33 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483E28813C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEHZwcMR4bZZwaYPGewLQP51mLwadxxd+QESR3jzaX59YRiz7ZgKGWmkpanrVYnOAPPrXr89iwaJVDay87Eby804azfM/rV/MB8+rJdGufnB387VYk8bT29PY11DDWv/ajgvmr3CVuHxuAUbBFR1ivg6ZgU9Sq/QKkyBwHT7qEL6yu+oDH+wO6Y0QDToq5wysl7bg3WuTlJIAHICsiybJivDF5sm/ikaJvd3WOvSjWaRrZ+5AQOSOzRJ5orHw8dWCMiQpM7davHId7s1vJ+ZtOIU4C5tj/LyWfewy3/iX4ciO8UXUfsrv5EcAwGBOdGrVjAZuZwc1mbGLaHRxmLNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG2wVR3KukS9O4pWtxJbvLxSekfZkxd3m2KwDJMamDs=;
 b=aj5XToQumnSkyODBZFGCySjFHME0qjXE0l1wCxPouidRwTt9XGGne8e3xYXXtbEytbP6uS7+iDsFNGHh22dvl5kgJIKJ9rJytIzGGuyGr0wyYtpjHWDoIXn2f3cF4IVP6h3W4NgWJv3rMQtq3UMMSwvHvAGahSKmKoB4l9rfG2AmkdRxHchvj4dmUMjGTg8RcPM6lMhlPkZ5S3MPNAc1EJFhtE14fV0g/xULHHul0G05bNqTFpG/Up0O/BSmV1O8XOyHsVb8/rtNs8UOQJH5RAtcmC09n7Wo1wFVRx0W57mVQhps/olDUsbLeZt9WU8Zp/jsfd+7HkWCgH8epsgJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG2wVR3KukS9O4pWtxJbvLxSekfZkxd3m2KwDJMamDs=;
 b=sA4LkaUL8WOTSNi8tABZUUGdwSW4F8Doym+UgConHb52fhfiVpN717tFjTWfUVO7QPXlUQZNGpgnwXpmZ1kBrb0l2Qi7Ogyw3NWQ7utVZu2xvcPMaUysJ96MdNB/gr1gzyYJOsHKD2HWQSP/vfwKuzi4wDHRSGciEHuIcgiMPW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Thu, 28 Mar
 2024 10:48:29 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:48:29 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 2/2] arm: imx9: Call imx9_probe_mu for DM post in board_r
Date: Thu, 28 Mar 2024 18:48:02 +0800
Message-Id: <1711622882-61969-2-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711622882-61969-1-git-send-email-ye.li@nxp.com>
References: <1711622882-61969-1-git-send-email-ye.li@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f3c6ca-aa85-4de7-e72d-08dc4f149a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OKt6YNcaetiBsGlN6TDv/IFgZ64vK1nQsY8k3TV2EQ1ProkmoCZjSZfifoStY17P2FiMVd00MDVzqERo98LszAciVO9JGA2O4UFV3vi+z40rmPbXlMtOVpJeQbvFCH6r5raRiyE/3xUcoQi3oPzRaNhitbKnZa9P93uhTNtXoNFt76yKc2j37CBs0Vj4oJY4sy1P1GhIbxXLCi+Liq58/VcSFF1Dofy29pJGwkctIowuUjzfSlO7uBsGhEHStT4D5g0kGaxLnPBWxG298H2CWRElA4Cp/rxEmdO0CvEGOV21ZO75FGWt28suaJeS33TFPOMkvtqLEnsTp1HjeJ5qJrnep1obDUOi2OzUsvu1oOKeZNOBtHE3CjHDy8R7dr3YvFSJPKEahKcX7ic4lD3hfBy5qps5k6dKmRtYltMOGrviONknp6e2tr04pcFIk26HEGEUC+ZTMysN2pMjYJlYIVpZvTDizAwUiLV6xTW7qj4KcFi8F7QH43w3XIus2p1ivYgQ8M8tf6VYsENUOYGWwSA6rDJ/GoWd5NhYHtAnBif3cbNmiCew0Lb5JSKm0sP2YAlW3u+IsvdM46Bbo5YYltJNh7WtBWd4VX84dHufTKOXI72dzKMAXHnQFydqY+6zLzh+Fp3EtTpEcXCsMs2sCQh2uy2kiupfLAdaYq074/Gf+IWOVkw+Nmhr8f6g/iyghvNwrQ4JAFxa9yki4WIb86f/FB5Qm379Vn97kMeibQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ljB9jINKMFuBTLwQn+bUgrkwnit9fbLDG9/hIlRez3DlkvEvWrPqgVnnKaMh?=
 =?us-ascii?Q?MSp/25Tr8cSMG4gUUP87nimuFcEzWMALc1HM7anZf9tAXHMPVZIh62zI6zmF?=
 =?us-ascii?Q?R29PH3w2tvIsaj0V+XwXDxf6UEFaR/s9mFCaYHUrOLCiQ5CTf+HzbTqWTmSP?=
 =?us-ascii?Q?K2zYPganb2eFunbiFYZlv6aEh7/G9fXr4WGh/MN4F+4O+p5r5wRBCqrMsFw5?=
 =?us-ascii?Q?Be4GwQ8bYTSUxlxCcmBTw6QziJ7q+8H3V3N1juXx+qkVwjIha/NtRypIDwR3?=
 =?us-ascii?Q?FRGjaGjIOWfelGxMY+uY/U+/MWqrWShGGPEYzNYd9xqiyINWDqu0lNnChxcT?=
 =?us-ascii?Q?S3BktYlMT0velb3LxCZFnKDniocC5KYmeurenyvGegCSJl1GXehWpo2yY4g1?=
 =?us-ascii?Q?W5cHj3u9WnZ39jN1UD9bPa4OtpI5XigU2qgs+tXyz2wH5XfFA/iWqDzYAqXA?=
 =?us-ascii?Q?zk7+QgfZ8N2/aQriJ1WL5OzU0M+qIK8FCdTpnu6VOl6OKjoAJ6PErilG2BZ6?=
 =?us-ascii?Q?agfz1OBvjnHyCROkFwGnmVG/VYAPAlqpgZbL6AnhArRlciC3fb0hSjLCwQby?=
 =?us-ascii?Q?F+ZUPlRLCfV6AkpJDxfsdJUCyS+hCTNUaaFaau0SmOvZcbJZcFo5gkMjkmIq?=
 =?us-ascii?Q?lpluOmyPue1V81YFSicU1gpi/j4J/n8WtpwawjA7O0OIGvbWc08X18kvE0Pv?=
 =?us-ascii?Q?oiS8WNY+wY5Q+UIA3pP0NgAtyP+6C6yKoCEy+Ithh/zAAaowEO9x3b8P2v54?=
 =?us-ascii?Q?FmCc62CxsrSdKWxJjADIfv9q+Ho420SRUNzet4c4WtVCzPKfE4C5pmI8jps4?=
 =?us-ascii?Q?GxxoWGK1IYM7DRZNSjadYxfW4gJJnBXeakU8eFqoKpWmvILTIMrFY3gX8EHa?=
 =?us-ascii?Q?VVYZ+w0PD9cpad4XCdkvICo4kdQC182PnzrAGVVY+jvfLmtYf65DmFoEEMcb?=
 =?us-ascii?Q?mN3IAFZyLXIxhHjFPI82boUycftE3p8GJKQyDIniPEfWNxa2gKpIQ5V6hchb?=
 =?us-ascii?Q?9iRwZhM6UyN4L2BPni23SJiC/4LrSu1bihEhUfQ80gJ0ihQeZlzKW+vBipwl?=
 =?us-ascii?Q?rrjWa64y1uhE0mAa/vVmEXn0Q0+4mwGqcLx92k+S0F6xyV8tNZuuuxW2aUWF?=
 =?us-ascii?Q?ocSK1fIyu11wYhAFIScG/xrHAVM9bO+ImYAMdiyeerfN5qJwiaebWZYEn9v/?=
 =?us-ascii?Q?2sH/K92jZP8vUqdlrhzBR8FfNBzggBKQNaEzeXgQGWZGzwmDcIKnjy8ifdVx?=
 =?us-ascii?Q?5hvdvo54yyUIHE7Hd2EcCb0UQmSodi3T0rjed6Nx1WIepJsxuZrn2mK/48Mp?=
 =?us-ascii?Q?9zjZIbPoxTO3CgnbFYnHOzteMNEU/RQADI2F5Krbhfy9RgpG1zrpPFeWH/tg?=
 =?us-ascii?Q?VMnR99tI5vFWNcCENqn/Yr3Gf+4zpXUsEwJ2JVAGO2QqOTlWpKpecSnzg1eL?=
 =?us-ascii?Q?NOdjnt6mSAKlnF3fg34OD2tE6sToWIhVZ/+5tHTG/HD0wGr3vA8Y3afa+QnV?=
 =?us-ascii?Q?4SE16s5Bg2ZQLUkOd4xG6xMpHkteuF74ga9kwUKnywSUmqmk6gKkQbI6sBBC?=
 =?us-ascii?Q?9vfGENwpFYJQhOK5/vI8Jrk+s7n86n6GxedVVAS3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3c6ca-aa85-4de7-e72d-08dc4f149a6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:48:29.1655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3JcVt8dBP6jAw4Gwq0aOTcrVZGzm3dhsiVNw/7jW8TUMEMx/CiH8ofPBDZ2NyXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
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

This event callback imx9_probe_mu needs to be called in board_r
as well, because many ELE APIs depending on this MU probed

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f06339f..15e87b8 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -622,6 +622,7 @@ int imx9_probe_mu(void)
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
 
 int timer_init(void)
 {
-- 
2.7.4

