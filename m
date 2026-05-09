Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47640CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 02:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C017184DAA;
	Sat,  9 May 2026 04:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="exBKwF2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9789A84E0F; Sat,  9 May 2026 04:34:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FAB84CD2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 04:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm/i0HCAzJHs/pHqkxI43t2JxhvwJvdPfq9FmYzXzN6eJJz3xIccnDPQJPPX+gBesz6ZIdHdeQfTklan9beihfP+kvtvLBSLzFk4dvzSJShH7E8NYMGUOch13NrFanxYQJawz8EnPB+/JikViS6YIs2Iev/PwvhbX2QMc+YJSJ9/UJF2bxTJCEDWJTBbvhb2UKr8KB+vqsR+GPBhb2ao6il1cvyrAloM+vin1G8OW+/JG4etk3w9+Rx4MGeo5oqKh4bU3Vrnqa5ea1/P9nO5V7PVhQROrp17zVF1j0qxnpYkWkY6qpDOTkw7Iw30oaXqb2iCPRHRgtQvs9RS7+F8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErTAG2pAynnm95AIOZ+5sPd53mX7+oPWTe35/3p9m7A=;
 b=JDyy87MdtP2rSftWm9q5FGYffBRMp/MpNzh21sklmq/LY2wO3ELG0kOwcCCNZe94V6YE4udJiCyn1NjmEPucYfC1t6+ADn0u7pI3Pbxu0RDAiEooHsRaXKz7FQDuYgV83N8LSrqw6lHykThDwjKFmQJBP3DaXF9iFaRcDkLBVUOr4UIdhEm91ItWSj9ECvqK8+aYOO9Ho6kD4ospqXnj1Wji73HKDrDEjy4JeFdnrNxVOcFcyBBBpM+0lr9fPZ3UixgWtF3OqvfQyefT5S7nXXbVfs2VJyxoaVVW0oL7xuL7R8UNnSNlztpwoVDVi2HFjQwaI1qqITPM+USHuhe85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErTAG2pAynnm95AIOZ+5sPd53mX7+oPWTe35/3p9m7A=;
 b=exBKwF2x4ERhB+qO55zCkAm1CqaYjK2byoTy+SbX2PfQxnG+Rmvk+OGWVB8kD2i+bCL+mOqGvzDDuVFZgYLHV6RmLHi/B5kAzUc4tp6cerKmm4Q+CYpmeMfuErdXdvox2UqREkaMwbZy9W4NY3Bj9tc5A4HtenAplSA6ds9w6A5RQsGSbEIr1B7g00143rAc9aic8Yq92FS+FLpAGTX0S3bm9lhPVVWhFf6a3qOJYwXqV96Ydqox8Q/i8fqHh10mFJluhM6xuO2HLSWpk1i3hSqwfxY4iyYbJZoQ3cVRRpj74H81ohoGFbLip2sHmE2M73zzLuWc3gxi81L5VqhUbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 02:34:24 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 02:34:23 +0000
Date: Sat, 9 May 2026 11:51:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: hs@nabladev.com, festevam@gmail.com, u-boot@lists.denx.de,
 peng.fan@nxp.com, uboot-imx@nxp.com
Subject: Re: [PATCH] i2c: imx_lpi2c: Fix MSR status check issue in STOP
Message-ID: <af6vOv10HDSLajel@nxa18884-linux.ap.freescale.net>
References: <20260428085312.1808358-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428085312.1808358-1-ye.li@nxp.com>
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: e67eac83-a881-4fc0-a5c4-08dead737b6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: PTFCWGgKyPVNk0BFqlbUX7w+hzHMx8fqeVlPP4ZhblMFOUsjUBdgAZQa0IaZZmFtvUUaEYct6qDYns5FK/WkKVz87n7OKM1I0LPN6CQceVhRZc7C0JeQHXyQvV7I6HJ2SOD1ANMjjeEdcImIMgJvzh1XhiZf9e91GbMCHbiRc+jqCWeXrUxOcy+ArIEbKMeXkgaWJNipIRY7DKf2ev4vL0uny10wwxc3X9N7xBo9YMNxQ04mk4ytTKd6TSXI27iUAISinKR6P/hVZL5+lhh+EyRB0sZpyZaFaxfuKPnP3mnOMESbKjt6EMCv6X8sv3wYDAVWXLD3ISA80RkCzZMOxjpcBK513x1fo4uM4jlazfkD8/udCTTxl1EAzZnNtevPtd4snQApw1q1FlZroS01pQ63X7SUl1U23Rs6ejmT0hMVqM5gcG4lr9FD9UrOcV+XZ+Q6i2weCdp8z1n6E9Oqt2w3PoDNS2gifdpCJKRBlaG5Yd+xM53xup+y5dOuyBs6QpnVv9KPN3ooC+wkc1maYJpxa7Fk7Zdawxj/F2HUmAt6d4751YMSUSogErKC9b0NzzDIKVPD2ip3kkq7XoLxWx6NV/f9hGq/F8C67Tz9QL8vfWg6r4k1IBzar+CgDcspJ+UUs8u0WyC2jmKr9XCH9YNAxc2b0s5zWrF6fdHdCuNupAMeauKFNwxeiK3OViJfCqY2Sv3Yobed7XmdMhhWf5xVqaKJQOBapONTJEwaWAc5bBHewVh6k3XWwCUXJOF4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kMWojKsOwL6N2IfwmQxVnIfySPfC7vtMW6PVNx8awesMyb/sLcfg/52DmY8?=
 =?us-ascii?Q?KCf2Waj4btBPxDoHV6YnP6cd5jR88rPunPbPhXyyPS/qBVeOQPfNoTxmh6Tj?=
 =?us-ascii?Q?ilOuxv5M3tCcxXEotKYCqvX7+EotYloQ5dkoC4sBhUEZ4HtRn8bXCWAqxpIG?=
 =?us-ascii?Q?cNoXtuYhcMWdf1VxLOxZVdYogUrkMYz+2yR87dmbl3uUIDWQEF9+CmcGUT/S?=
 =?us-ascii?Q?BSLQ1yZZJuB/Oo/q+27pg84F6WyxztojaBw3o4v4m2Hq9+m2i0iHBUQOrkhd?=
 =?us-ascii?Q?bUqQmNisDRVc9iUjFpas99+twgw/4d6rSq0fO6dqxlcvyoivsK+H9Pw4BrFQ?=
 =?us-ascii?Q?WrL/tpVV3uV1AuXCZft3Dsyl0vATJJinV/KfhXHPYk2wpqwK//m4GKPENz4n?=
 =?us-ascii?Q?r+RUlDM0brgzLy0ZC3X3sr/MgnPCZsfxttUooL/LapHfE58lfdipWyx9+n8j?=
 =?us-ascii?Q?kXt8oC92bQdErYlSo5NGLUdn3BKX4ZdgGjbRZyuvQosWWm4g2S2mUcfLsNmV?=
 =?us-ascii?Q?wW8Xsa5JV4HppWGZqbTk1rRbw0CaoRLFKyZJiXlNQk5OV0L7VAhyFarDTki8?=
 =?us-ascii?Q?R7FsHiWMpg5Ye3WLRnPqLtzR7ws41Cb99mnLYOKPKZfMM3NZZ52Ydh2hlFpI?=
 =?us-ascii?Q?evbuSI4jbUeZKCOz5rjwYVtoFR1WGn5ONxvyEO8KN52HrbA0xK25dn+p0s+p?=
 =?us-ascii?Q?YtQyPOBloXVOHYDWZq1sot8VvRMn/CbryE/34FucbUEBnYbfYsb/JTsHmPXw?=
 =?us-ascii?Q?1ChA+jTBNrLyF3u+aeLp2yIHad+3s6R15Scw9imu/iO1U6e1J18XHKNSsJJR?=
 =?us-ascii?Q?YcRrOoqiMfmJDjKuo8F+8hInxnuZlwzWAuBxQ5QS7nRVD/KNYZWOkLfgSc4s?=
 =?us-ascii?Q?uqOr2Oj7Ih7Nmmg92eQMTq9P3V5yBOEdsNPJ4/Bbuty1q1PHiIPTRcuYJHWF?=
 =?us-ascii?Q?h0WKgcZd/aI3WvbJlJb8HvV4OA6rxCYwrnmUDqTtraUU7AyYEpu53CKPpvFP?=
 =?us-ascii?Q?bqGyPFvQMlrCfecD4Af5XHBd2nQCHdg5gm+DvNRACOhInvVDP2uFQv+LLiRL?=
 =?us-ascii?Q?zySwloNPSysJQ+/Wjvauv7hPKzfVrcPgVCnPfg02CfYwg/gpKpIjZRJDoycG?=
 =?us-ascii?Q?/gZPEetl67tU36D/zaqzNKexPJ+pXtaiCZW90ttkGFpLmWeDIJqjtm7m9MhW?=
 =?us-ascii?Q?8z+jFC/K5knp/hBD7WZj+2czM/FaYZXhwbCzlKwoJ35Y4qc1CTRnpe+41UYd?=
 =?us-ascii?Q?S4Mn71E99QUlfG5o8DTep7vlqWaJd6uhjWz6fbdLUHdY5kTalfdvcPnqtSV6?=
 =?us-ascii?Q?gceAyhgBrUyqv0WXYwRbONNtPo0oVi/OuefgG4bU61J/DrRsTx4gzD6IVoo8?=
 =?us-ascii?Q?RWfoAQc5/f8UByYwO+02Kmo9vwR6N2Fd8W1C4pu1APcW/O9wfYdx6TN/eFi/?=
 =?us-ascii?Q?RTYiLY6Sg/kUlgd1RiAz50IlB1NIAm0woaJQGe91CLjjikrxjmQJ3oLbRiSx?=
 =?us-ascii?Q?bq4QJ4dwCGqxo0+OX2B9xSXFABplGIaWJNNnG75CPx+U7ytagpATT2dMf7lR?=
 =?us-ascii?Q?XeviFj2caHC8L2tp+zxjLSN0me3mu3BVBei+eUoGw+I/K9jFXVH4ujhYYlSs?=
 =?us-ascii?Q?eivkB+6fCECrBIFGLgqCEG0P+W28sKi8Y0wLF5S1af9bws9qN1bIwmCuNedN?=
 =?us-ascii?Q?a1+2WtOcTmGSHmX2a1udXZs2FLjYWeQCO+bZu9jU2QVuGD7D2Rjvje66+fzA?=
 =?us-ascii?Q?+hHrPiqvPw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67eac83-a881-4fc0-a5c4-08dead737b6d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 02:34:23.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S334FHonF5QAZFQNoLqCUbxEbQnaDk1RZG7aoXKj2jyjOZlfIUWx7d0ChiIZsqxCWmgKbrOmxB8N2RhramN0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
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

On Tue, Apr 28, 2026 at 04:53:12PM +0800, Ye Li wrote:
>In bus_i2c_stop, the MSR SDF is checked in a loop after stop command
>is sent. Meanwhile, some error status in MSR is also checked by
>imx_lpci2c_check_clear_error. But the imx_lpci2c_check_clear_error
>will clear the MSR.
>
>It causes problem in below situation:
>In current loop, SDF does not set, but error status is found by
>imx_lpci2c_check_clear_error (for example, NDF), then NDF will be cleared
>and result has NDF error. However, because SDF does not set in this loop,
>it goes not next loop. When SDF is set in next loop,
>imx_lpci2c_check_clear_error is re-executed, but as the MSR is cleared,
>the result is 0. Then the stop return 0. But it should return NDF error.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
