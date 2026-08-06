Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBFEC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3422C60802;
	Thu,  6 Aug 2026 11:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0VG-v_bTqZ_M; Thu,  6 Aug 2026 11:00:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AE2B60763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014038;
	bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eyKPq9KstqoD/T1qfHQvlGz4cXQ3gCjWOakS6i6lNet3OXm7zo0j1sJAs2l5mODqV
	 /s+OMgAAIS4cWWD41UtN5U3LoXyBj5ejPiSTcNNC4/lzvr1ElqTG5TWy6yHYCRhgz9
	 Nv/bynbPqG1tUGQPc+wnTKA/5z4faaBQlcqz5JvxTvVMvHneYIRyxmb9luJvuCuo7u
	 sSuQgx2e9zYLwgXgh42VNKxCsQaNj83N30gsFoXsXExIQI5w/mx9BYvznkEH5Ds4EW
	 J85Gbdf1hNcoNWt7ArHtsS/wDqwTWzq/svi6XKvVb8YFGZct9e+QDG3S/+dPhJ4Vsp
	 eNm2oxJxzIdtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AE2B60763;
	Thu,  6 Aug 2026 11:00:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09689392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF37C40207;
 Thu,  6 Aug 2026 09:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ns4g4yNrB9Q2; Thu,  6 Aug 2026 09:26:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pratham.malaviya@siliconsignals.io;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7C0F340167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C0F340167
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C0F340167
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:26:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523E484873; Thu,  6 Aug 2026 11:26:33 +0200 (CEST)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c409::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53434846E2
 for <u-boot@lists.denx.de>; Thu,  6 Aug 2026 11:26:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFkoMXDGF0Fsk23yuOkcmEe/uW8xzCyzigQfZF2HI1STZ1wMyJKi0inb30FsSp9vTi9Iyw7DsCBHdi2HVXas9Bg7C755wb60o23Me4wzDKfNW48bHC668dyqDZR5itKhCDJGvovbwPDXloeR2hVFBCmJ9EQGyAgHpdK4l5/IaTOvIAdxDc8qwrF6yW9QlVrSQlI5oqF/gmQUeNAiFJ1XKy3/hgaaIhq3SEf/qvs4e3i//Q9BhHd3/KdmG0lfzx5g/bclEgml5JeKS8eH7BXKMbUN4fKVah76zTp7NVTa+yFy6pzyJPQ5aAC9ieNytNC4dn6Oj3i6gw4Ie7mgE4BLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
 b=WNLtNFTA4d4obhz57HVwYurKr4Ia2OPGuRvM2zDSz3zOFWcOFbrpG4tuiv8c/U9vwl16v+k91PEFd8NybmBiYorBpKLPOHnbMisiiR+yb9Oop2sdKtRKmYW5P9mkLPKunv2XVoqamzjSPiIoeoTexFuiBaKhJb4OV3ZAnZAAUnpv7IJarZ1cfJ/1hpDkk/7Qv4u7tE9U7Rten6A+nG6QLljcv8j7FCoOa0k8wNB58ll8P+ACVH4ltGT6FBAAJJiTgt7VzVJHUxSCJ6VPSVXoXAY+/pHPtf9JcFuRFufaHl8lJCJurZndCYIGsn9HAGYty0h+DmKy++ij/Yz/N+hjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB3499.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:144::7)
 by MA5P287MB5723.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 09:26:27 +0000
Received: from MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 ([fe80::c20d:ef85:f70:88e0]) by MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 ([fe80::c20d:ef85:f70:88e0%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 09:26:27 +0000
From: Pratham Malaviya <pratham.malaviya@siliconsignals.io>
To: advaitd@mechasystems.com
Cc: u-boot@lists.u-boot-project.org, ag.dev.uboot@gmail.com,
 clamor95@gmail.com, dario.binacchi@amarulasolutions.com, ion@agorria.com,
 michael@amarulasolutions.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: Re: [PATCH v4] video: add ChipWealth CH13726A AMOLED panel driver
Date: Thu,  6 Aug 2026 14:56:14 +0530
Message-Id: <20260806092614.457359-1-pratham.malaviya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722131626.77086-1-advaitd@mechasystems.com>
References: <20260722131626.77086-1-advaitd@mechasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::17) To MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:144::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB3499:EE_|MA5P287MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 148c8b01-1fc4-40b7-c038-08def39ccaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|52116014|376014|23010399003|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: BMLyLhOwoDWyNexODRbf0gLTViato5FjVOERMDEAuv/woSmBopaOwaXpoHJ7J9DVu4AcjLErZ/IRqZ3joWKidPPESWLWwm+X1eFe91TZ1GkttXESLo1zH+WZzFPQmyWRAGwAUVNsIYwESATVnfr0IE6MUyy16ry4gHHEcY66r0BrTUjJ0C6MMIrZ8GIgsy98Gq+FXyoGaNHg8clEq4GlhOKuc173+uxVx6w23UpmgTTF3kvb8NdwvNiQrEZFYz460UmwmcPyBkL4A2I6gu2X4vM80Sc4TVt/TzW6f5DP1UT7UOEUV5EoJtl1TSlKMhuYbuD8hB+KVDOHTlFSBINYY6GYww+5XAK0/SbfeM/qMxcuu5qPbxaYZrF3f8zzbzxM5PyeFShNt+KErnLMFT8wOBto7xu7zjpakHSy+GQjJHFLa3gWLYXiKrsjkx5q8iOpNFdysVXXkGv/9qPhQpUL6JML8TxwrrtibBAzop7WMhuwtEPOIiXfEa8R08NNFKHk6kClyXchugy7FdZQy0qPRH/4J8c34676rAwoqo7lWOfZpVVHk/IhH+rVEAjrU/+EGiD2Xm/Z69F7txyS0HIZJeHR1quce6rLceL1sp1cwQRut93qWBuVo1Mwjg4dn0VpEM8sFdE4cCsd79TAq5938lzc4VslF3Dk/s5eNdoHlgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MA0P287MB3499.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/wzpP0koVVnuRtbRhEotQoTlTmHgUvqyNWNULI3iDcDBtEnkrnFQgaOHmaw?=
 =?us-ascii?Q?+d7qqe+UCxJ5fHlBFRfTS6WicQiYl2arIalvpMXknapNKR5iGRHh0gw+EIms?=
 =?us-ascii?Q?tW5w/M5jfP8CIC8NFA7KsbWC51bEpSOY/7S51wY03PP8Fuv342mZ5V25cMfR?=
 =?us-ascii?Q?OrMaAhBPZJMn7IrfEIpND+QbKymlML8yV75L3GTYtJwjLeTp3ELnB0SUz8e8?=
 =?us-ascii?Q?XrnqKXrxu+r9SRtUpmAJ/Re66za3FeZdLTjhroJeCBj7G9lmgr4yd+iFv5XU?=
 =?us-ascii?Q?htCQsy2WVA+zM2Xr6URPLfcHeLAy6mg2zGZJTIN0vtF7VMvLuJ4CE7MFeLsd?=
 =?us-ascii?Q?eoExWOm4FhL9c0o+Wj81xuN/06XOXaGT/nAfqNjr1BXkBPI/ttxcbcNKS0Mb?=
 =?us-ascii?Q?jP4eJ7lj/rfgg57e1kpJi0hvZn7gxhMBUMIYJxIQY2Qmy+TfqvhwJvjuK0yF?=
 =?us-ascii?Q?Tl/Pel+qGRvioowURtIBPl42OdM9EHX9GyEecFLpg0ncSi4OAtBfl9iddzoo?=
 =?us-ascii?Q?anT/cY3eRqLYGH62NVmaNwDeuZP23/+R3XGvz5Ebj0sTN70bMKMtwfxVJmXQ?=
 =?us-ascii?Q?YtHT4OrV981PAirzR8JCSAoG6BeU9MRlTKipo6tkTWJzV8vqStDDtfK1IdwB?=
 =?us-ascii?Q?z1amwW9X4LM6h/6dkZNOqPo9eF6vaz/3s2CpmUPL1fQ+TF/V4WpSMZIM7fDm?=
 =?us-ascii?Q?XAbm9Q96xMyVrivcLJVjQYO7Eb9CAXE/djpOSd+AzI2g6WfyIHiE5efSOWPt?=
 =?us-ascii?Q?UDPfgz0EtkCwS3XuHNeEvXYzUUEWIEpa2SoOWrfPzMTovUoT9r3O96BpTv1C?=
 =?us-ascii?Q?OJsqWHE6LXcdtV+irVlH8nUTlYWNPd6RI/k+eZB3wf/ZV5u7znAC35F5hgeU?=
 =?us-ascii?Q?3HJtdjprxOPV3R6gfrCrevbLKxYIJfpF6l+KJGZMiDtyziuFgQ937I7cHr/q?=
 =?us-ascii?Q?aXK7OxCea/ypIWsOd3y6nFPr8L76k5V/aqlld4m7eOyO4bhEwzxBGJvXazL8?=
 =?us-ascii?Q?1GKapLV0WZjnQb4+lY+V4Jpp4uHDHZGJs8Dzut+jsmIJtB6VEFRwR2SAEhMZ?=
 =?us-ascii?Q?otVPtqjL1yolRZlluo171t3xoL6mhntkYgvpO98echSa7INQ2ztc6q7TCt8n?=
 =?us-ascii?Q?xgB9nejt2eXDOfZ0o23YS39EuIzdlopE08TZpItxXKNjzlD6uZYAC5OMpgn9?=
 =?us-ascii?Q?wKig5vxl/Ay/XXM8bSTrMdl19sk7k0Z8Ksn0uhjLci2YiBn6GHump34DDRke?=
 =?us-ascii?Q?QMhoR4kfoEZI6bJz5O+KrNJQGQ7FU+4B08XVUyaGZSUBPxLqa8DJbTebZ0xS?=
 =?us-ascii?Q?wIhVbuB9KTwQfcWvRVia58NKblodc3OPO+rs1PtlKUd8QCi2sjcNnJuiV3+N?=
 =?us-ascii?Q?mV81Es28lXwnMOa4ydtkJhiNJ8G5GCPQ54XqdGR0jedzP4kofTmevJb4coAr?=
 =?us-ascii?Q?EODC4kQNZIhuVc1vmbor9NRwVKOiNEHA2oiYPgmewArGLq+cYtZrz4r0BMD2?=
 =?us-ascii?Q?ZxrxzuFjgj9nZFHKYbClEW66pRiJ020PkQBDFXOS6DHZFpR+rAhKS/tHbWxl?=
 =?us-ascii?Q?XefMIxq5K2gATRDhBOlScRut+/3sAZZ1sQxw4Rxs1SWFB+597qTcRL5Ea5br?=
 =?us-ascii?Q?Mig2qCl5NJiR6obIIVv9Hn24v1TIu4LJIq+2S727LPeJs5WXoUOnqbGoKNGs?=
 =?us-ascii?Q?tpaVJNfp/2qTBluGfEpZ8Wvfo0479fwAXb+unIMZhxVJSh9D574/YPaGbYfN?=
 =?us-ascii?Q?CdkqxWj8sj++7vxPxqwqcsDs5xyTFnFzxea+QlCVPvanlOr5TqHaRUbPgtav?=
X-MS-Exchange-AntiSpam-MessageData-1: PhT9lEagPxT/SSKcoK2SqkK5CoUJabZqHyPbsaKyS/Wu5bZ1jIoLipVc
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c8b01-1fc4-40b7-c038-08def39ccaba
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3499.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:26:27.8454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMRfqCLKiFZ4ApmYi1d3n9c8FpdpUTFhg5OFQB2CfffJncYbpjAhhgrfHLaKTAOlsOA0/beLZFdvlPhxb11abAA9Xs7b9zxQdJegEe2YEqISvSoyc/Rz1pxxSK5tfQ/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB5723
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siliconsignals.io; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeC08YNQwLJ1H6lZqWmjybiDgylNgFKZ9g3/IPkM4cA=;
 b=BeRCK7iMCzl25b08PeAV27COrFfKGMpJNDuH0TbZ0fJSxv91V4oHmHlxIcy8eSwxO+dFUS7USp5VSQn9MlJcJm6t/q9QnmK+iFa5vTf8OkFVsdt7saEMOuD0tQp8fNVdrNgwDQLoOQ0YlO4ux0j8SbO4XON2VmLDbVKvISSdSHtkmqg5QItrLISqeMSC0o3ao7d5Nq3Z8MHdfXCFtgaFKJYLixV6lrur14P3457eQm21Smol1i7fFL8Cck/adYxJ5T8lPATUxg8axk+ls8FaaqeHayQvTjNPhlKf1fFWGHrmQW7Qo2wn4anOg7XPHiuMlwgzFp8rZS/uJq/bfAjOWw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=quarantine dis=none)
 header.from=siliconsignals.io
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=siliconsignals.io
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none)
 header.from=siliconsignals.io
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pratham.malaviya@siliconsignals.io
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=fail reason="key not found in DNS" (0-bit key;
 unprotected) header.d=siliconsignals.io header.i=@siliconsignals.io
 header.b="BeRCK7iM"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Advait,

> Add support for AMOLED panels based on the ChipWealth CH13726A
> MIPI DSI display driver IC.
> 
> The driver configures the MIPI DSI interface for 4 data lanes in RGB888
> video mode, performs the panel reset sequence, sends the vendor-specific
> initialization commands required by the controller, and enables the
> panel using the standard MIPI DCS Sleep Out and Display On commands.
> 
> This driver is based on an earlier implementation by Pratham Malaviya.
> 
> Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
> ---

...

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ChipWealth CH13726A DSI panel driver
> + *
> + * Copyright (C) 2026 Mecha Systems
> + * Author(s):
> + *   Advait Dhamorikar <advaitd@mechasystems.com>
> + *   Pratham Malaviya  <prathamm@mechasystems.com>

Please use pratham.malaviya@siliconsignals.io instead of prathamm@mechasystems.com

Also add Copyright (C) 2026 Silicon Signals Pvt. Ltd. along with Mecha Systems.

Best Regards,
Pratham.
