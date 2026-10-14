Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D121CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 10:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18B84406A3;
	Wed, 14 Oct 2026 10:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wr_p65bZ5lVa; Wed, 14 Oct 2026 10:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41C45406AE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791972300;
	b=deOwWFfwm4fnVuCNBwcCe61ZJ117P8Dew9YyotZ7zTk+IJOEGWnQiRbb6WoTKGPW5AhO
	 SHl4r1CbdJM9htijVq5wut5Nh6uIMm/SB+mc+R+zcEp+MaINjpPpvjPDovyf0FCs+BPD6
	 Omw+mGKVC+a39cRjIaCucbPzH8Y6SakfwJ8L+qc6cxRNufl6mKwyt8o9oTCIJ2I2qPg82
	 0IZC2ExBaG/0fDEX3xq1zZIf6gBpZudY9I57OK1mro7dGWpLfNUZ4VJ0AS89LkKL4x+Fj
	 3qqhbqs5iordAVMIjUFuxwNzg/vXZRugaM9E8IMB5VxHwb/jZxUnRyuNgj9XIIGYrWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791972300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cYEr80YpR/PE/0qWmA5arsH1btlH43ly0uKx1x+SngY=;
	b=eefeJf9/GbPvrlNN7an5/nsI04zVlNua9XbtTbES+MdMae5NiK0KPlqeL+f4JoWL0NkE
	 TkRO0t0Xvi1vMOqnBif7VCL5YH81NAqjYAR+WtaCOaijZR+GHSZSSkADkdD0MIws+FpbC
	 PpgTsap86lMT1KXo/Ax/dyg0CfoGGcUHEcElyFJCcmY9CKQ/cpYdyTnMyiXZicNY4ySQC
	 8RgJJZQn4vMPRxDmRHXz8srVxtzfijSuhpCHCtcJZN0r+evLnX/oqGEWf+fEd0E/sqPIz
	 jSBsQPmVKEN1icbjJn2zTb7iGTIm2BlILwq1RtE59bfhFkstGprMYG0piSrz+tIL7fQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791972300;
	bh=cYEr80YpR/PE/0qWmA5arsH1btlH43ly0uKx1x+SngY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PrFW2OVc35L/8Voj378bl5En4vt99oeNzm+0DB2LsxO6gLfcfB6XhuwmxQXoqLoXv
	 HYAA0d4mD/RxYzIdEW7CmMAaGR7lF8brFypvth2M5btrWSD5M9BDAYU071yw7RhJ6f
	 GLU0odHlK0MCaUxYBIqtc/lQe7oOm/+pJhMG22HWuCiwH3brEE0q1PPoSx1IAjeQnI
	 lxiOXeiWiN/gbeDVRfCXNVR0oLXAAloneWgiYyCFbu3vvxwKTF/TvduBGMApPyX1Ej
	 64tFfoWkFHDqDnauJZVYcGeb9hRCyZ1ZRDVkDUaVsLiu1WHCeWBxwwWyWLSxhjz+hZ
	 3jVWMslhwTi8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41C45406AE;
	Wed, 14 Oct 2026 10:05:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA6A62E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC9B880AC4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rl0_2-rBo7Ga for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 10:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA82680AA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791972298;
 b=PXpdu1ZcDieNKX+NafTgXow1qu9kMQjXLk+ECMzB73WW1y76gHUanJNJmskLVFTv0FaO
 qpKhZ0S4WQAhZgRq8/XgGI0p7FDQaT8EtoKtRz1VVbPrRJFjexau+9Xtw4mQqicBORdju
 +AUc/yAwCgbTzgB5s/9LMd//FqsezdY9KN1cPOJ2y1Ch00VY7ZdEUAX8/8MqxDztYiVU/
 DUXPOL84RgA7AFvHbBcmCEfphYNNzMABLF07lCOv5CRN4zazhPCJ4GC1goTfVC0EbZdaf
 vS+tCwDHTvl5A2jWcJNDWcIAq3dKi88aj45d7NW2WTa9Wky+YarAlsckpWZEpV5eAfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791972298;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=cYEr80YpR/PE/0qWmA5arsH1btlH43ly0uKx1x+SngY=;
 b=DPh+bEDyEKfRl2zE/Chw8lcR1LVsH4l/5y4F5oayqfFxyy7w9QjYLzBe8rtv8r1A0PRH
 lNdVFfEJnboulfHiieveiDG7/ai8Bv6ZkZ89g7nQR/bpVcbeLJmzUoDpenDbSTi77krSV
 UXAMiQaBnFvdmUtj5fHqGTZoDQ6aa74/76b0jbbOPDIb/wHe84vPdSu/mfIhen7u6pwEQ
 1Se3qnxN4fAAkIHE86PiPwcjHr5F4pGPveP9YOwnYB6D9uDuBgpqjW6/eTGEBHQDqeBzv
 eNlSt1K4NPMMYElqVCcHpUZs+5pyfGK+jn5Y3gqSWRbIM/uZHYA9B0jtsSRn3VfJiIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com
 header.b="QFbmQGX/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QFbmQGX/
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA82680AA2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWXEwIWT8pdrHcAQb+x0yddHjtUZE4QoIUQXYUlr8Py2R7DneX47BdcYvBqiL+Ft5wLKJ3oWLxQuojT4ehrCbQqGRdXnEWU3L/phE5WQbNe9eM9As+4Ldtu3gLpxIX4/73Hru78vQQSGECblRw6vmGtT20/0RduQis3mF7ktXic/MrupAUNYs4BdrfYvv0nzivSXP/0IbiqDvWIFpYA1nuDFsj5kY4mrFZ5ynGJ4FZeyxNlEMXe9R3UoLVp6V5YaQ8MVqFM5/CJHjrFJRsPfVeN+KfezF3y2tJgusHdW94cVtmx679o4lTrLudhoCdA5+BJkfHgRo70PEwTbgTCaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYEr80YpR/PE/0qWmA5arsH1btlH43ly0uKx1x+SngY=;
 b=sU2Q2XM8diQrXUzvFQ80SWfLJPpDSTNcUe+Kg8cLAzrvpb3qUUERJ1d2pkE8/LyUBvq82Re0svsl+4P/Xo2nqzqLjRHcLGU6T2UFOtESH6d2OpRBcYZW2D1X1SyBgU10RWFteh3cr2KPcCwCZ1rVVGZiQ0JGuocyM7tLGAHj8lkC2Lia7IfMMdv52m/pYV3pqTR8fhrMPKMRzJX2XCe6Kh1Yac6ObNukVW8JKAY27Fb0dFeUFc9yJ9VqkZMLeFwC2LKHrqHSA63YQDvraoZpTiDUPIk6XIQaRwLVwu0bVVY3RgJ9WoPzDfanAWa5rcwb8KHjaOn5xK9UIRqbCZNxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYEr80YpR/PE/0qWmA5arsH1btlH43ly0uKx1x+SngY=;
 b=QFbmQGX/iQPyK5LiAeZ+6XHMWiEOLBCGX14ramV5pYCsW6ZSfHpREIxHTxq3VqTvRo1ZqVQC/qNJH/Rd0J4mmx+dE9or8KRUiYcW2WR5Y7vRDV/HuDbgP67lnrQ+IoUEk1C7kv7lb6/vTNkaDBvh5/uoAFCa1cu7+RzFcHdNrtu8ERmDRhSB1lOSsTTgjgibjsMwHlngRwHd1RXj1DMymILbWvqcvPdaLJzWsxTEO9FWyDeWn+sX1FUcuJPdiae8ksCNTbFjxe5Am/YCso507AmOOTkCV5VVvkO29SKSclQ0zD+LjR2TdrU28j4bRVPUvbeJ5iBivg7CZKTrNBdusw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by MI9PR04MB444628.eurprd04.prod.outlook.com (2603:10a6:290:85::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:04:54 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:04:54 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH v2 2/2] toradex: {aquila, smarc,
 verdin}-imx95: Enable caches in SPL
Date: Wed, 14 Oct 2026 18:09:15 +0800
Message-Id: <20261014100915.3470159-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014100915.3470159-1-ye.li@oss.nxp.com>
References: <20261014100915.3470159-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|MI9PR04MB444628:EE_
X-MS-Office365-Filtering-Correlation-Id: c278ee6e-e156-4821-5ce0-08df29da987a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|3023799007|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: xQbX9t3Q4FhPHBIK6YTjPODvIoucoVJ/7bA65q3WtCuTADqHfTqsM351bTWNMTTJfQL9YR/j9Nf0cuzI6Ft9fKENidMRJkPDYe9uXrppnMB/ICXISozepTQ02TFZRMJq8B0QekqMokmkt6Amn7ZgemRYWw/w0s7Yp3kN4pQomnWD01j+cBPHUnx6i7i7IROqdBHffeZPj8POISNFc2tl40OknGZZrO4Czl14q6TJPcMIb9crS/73QZIYaEqLo4QKE6ULd1B/6YXeymNXeu4J8Wqt+IL1G70J2h/Xdf1VAnqHpKbLW48p5BRQTqpvLVtt/oMKQNH6bACvXs16uSPu5n314gJIMFCfFMPSyxkCXbSuIdhTPP12ty/Kp171isvo+0Ah+Z8chNHQ6WktaWyXHqZ66vP0CU+yCXjDxvZiDQLO1lXkDFrcs4/RemRgck15rXyDZoHl1h5+S64amubIg4TiRTDddmRG0WybQg2OCr+mI3PxENt+KRmdSIxwKxkLEy0h5ppegUdnhTyHfa+dFDBMekr1u2drprSn5EB20Kz+CDDkM7AxuIIZNFl6VUH5GDSb/uCy6he5Ej3KhE2lmBBBSrQTBG3GP2mD70yowrm00+IZlX6VBtKorIIdCHODAdD/+FRMTmeQMNtEBvs4/LdH3eHUeRG41X/cUCTj4OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZlAqfW84Q9RdH6pNeaZDc+7Gx8aF/sXuhIr3PxRGjpUQ3xfOTuaZJZzh3eB?=
 =?us-ascii?Q?goDtJlA9Np5oFrp1JFSwQQyaePLDTI31yPPZSlcho24zWUPJfIct0GLNP299?=
 =?us-ascii?Q?tlhRUWDPB32nHUsnM0lohcYl2Vs7cq52saZkEiU7ipjuVaujMkEgRGj1y0Q5?=
 =?us-ascii?Q?Nf88eSTSrfbDnlbS2VnDyTm0LG7y98AZf2kZBDjf6dmWA6fkNJHu/1oXfsSn?=
 =?us-ascii?Q?HqBBi+pElaYHrkH8cvdgv7XyXfzSbMUEcUvyjzfgdbC2hK7XqVd505kHdCW8?=
 =?us-ascii?Q?V4ksRHB6c1BzMNixFPj8YSSKShO7eXXTnk+hsLerLvreofTkPPLvNJo341P4?=
 =?us-ascii?Q?yv5qZBUemOGX9iPIuKUG4M33QsVK7dNIOKeu9AqF0yxlLy5qO2w2gcTvqG/g?=
 =?us-ascii?Q?+GdFeS+puESrn1vJrQ2JlVEGIbPrc7W2FBhSMyT7jGDFgzjui1HUhrI0X+JO?=
 =?us-ascii?Q?IKJON+eSc/ri3D+E4J3mZI2AByamKjAkPRm1BeZH0/oM4lfmsNSeCuTf1byB?=
 =?us-ascii?Q?NzxiusVaCT38EJcVRuF/ksJPJGfxZkl7iwcztQcHMHhNdNieTgXX3ktroru0?=
 =?us-ascii?Q?182/dmUZo7UnZu4w6f3ODmXu9oAjugHWC+xR9D9n1sOauPJpWtBltcVBrcLd?=
 =?us-ascii?Q?PnB4h3TQbk1kf+y59vv8BtxMJZtbK8RfrrULh9s0CJAwXd2cAivSJAW4QDKK?=
 =?us-ascii?Q?YoaNvrDfUGLKrTxid22HOzPwGmjSHMEo5ayip+VzpZGWJLsEL9djbMkYWADi?=
 =?us-ascii?Q?q8lNAYEPyaXYZv5M1dbXNX9+/pXT3ubTvSyUJYlHl+kCWGQwruFymiEDo94k?=
 =?us-ascii?Q?zhG0AyIZ6e1iz9G5Kkk/nP+jjGbQaFen+6lo72jRZ3fOxNxafVNEaYnkvc+n?=
 =?us-ascii?Q?Y/6qQAfLMNs6t3EdwL4sLWsOazYMzFoQ4U9bhegFLWYYnQYTkVs5pGZZ70gR?=
 =?us-ascii?Q?ldGpEc/HG7xvqiV+P27WbhK+3AGRqNCQUwHBVQNd68NwXmilHO0WhFZC5CAw?=
 =?us-ascii?Q?i0YcEfEpOa8c7fpNNoG74UiK85mNl+8BbcjSHTJVAKZP15sibdPf7yrYJSru?=
 =?us-ascii?Q?wRmQngtozjki8tVJy8Xp/2Uz/xHQcGAMJXPgcSskZvCdHghSV6qxaQbJsAcq?=
 =?us-ascii?Q?mTKCR0sONx/fLMfGExsoRV5oGJoU2jIxHuw4rVLHNTQ60GhXCoPZqAtzVcqi?=
 =?us-ascii?Q?igBNCeWl5etSjPPAlpUfFcLCPWBZPn7OAD50YsJ+BZFqZTZ0RO6uiRRJFIjX?=
 =?us-ascii?Q?c3vimGA9aRFHdmfunlaI1+yM6EEI2kNYY5KmXJKE0A70vt7uWlDX5NiwbutH?=
 =?us-ascii?Q?2vYOYPNAUTXlWhgESCp3nUWt6lSTe6LTbf9i6NvXkWEW8i7GEqX5sOSfekGF?=
 =?us-ascii?Q?RUtVKEXaB88czVrUN00RA9/mbu4DHP9V0i9n6MpDX3IbhwToGsksl1LKc/eB?=
 =?us-ascii?Q?tivHyERorGz5/HjUsBvmbk3ZN/OyuTy9VEi0TCKDVhgNNUdxpcQqjkkxnmzW?=
 =?us-ascii?Q?uZHrq/Dx0zFXrg/d4PkCBQYJVf2RsjUJh6BXHjN3qrSNfkugY4t1CWFIdaVo?=
 =?us-ascii?Q?LutlQ7h9C8rh5oVkJGpWjVYVyRrJalKvi788y/k1SpzCb4kds0nXDwbXujhc?=
 =?us-ascii?Q?SoExDQ7HMfHl7yFAlPNucDodIyNnKiuCz5IjXwH1cYEq6b/Qn4LoxOTnQzhG?=
 =?us-ascii?Q?YxyEPgZCsigMg6RV7if8KVeIY9n8ebr53IekcgAiuLBuMTdxoQjyjsHaqoWw?=
 =?us-ascii?Q?e9a1U/BZWVaqG0PsmyYwdFmmqPx++nY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c278ee6e-e156-4821-5ce0-08df29da987a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:04:54.8912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIPW7QXC8KvznwPB98KXiX0f8u1VuYW7NuuZAWk2MHVO6nB4SZeM7j+Lvy6t/uENiezVVC2+nSLmCUbbzoZYttat4iLxPefeULScziMmJyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB444628
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

From: Ye Li <ye.li@nxp.com>

To enable icache and dcache in SPL, add the definition of secure DDR
space which could be accessed by SPL and move arch_cpu_init before
spl_early_init.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 - Change spaces to tabs in #defines 

 board/toradex/aquila-imx95/spl.c      | 4 ++--
 board/toradex/smarc-imx95/spl.c       | 4 ++--
 board/toradex/verdin-imx95/spl.c      | 4 ++--
 include/configs/aquila-imx95.h        | 2 +-
 include/configs/toradex-smarc-imx95.h | 3 +++
 include/configs/verdin-imx95.h        | 3 +++
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/board/toradex/aquila-imx95/spl.c b/board/toradex/aquila-imx95/spl.c
index 93e76be6145..31730fc22c8 100644
--- a/board/toradex/aquila-imx95/spl.c
+++ b/board/toradex/aquila-imx95/spl.c
@@ -58,6 +58,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -66,8 +68,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
index aebb4a2f0b6..a3fd11a50db 100644
--- a/board/toradex/smarc-imx95/spl.c
+++ b/board/toradex/smarc-imx95/spl.c
@@ -99,6 +99,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -107,8 +109,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/board/toradex/verdin-imx95/spl.c b/board/toradex/verdin-imx95/spl.c
index 93e76be6145..31730fc22c8 100644
--- a/board/toradex/verdin-imx95/spl.c
+++ b/board/toradex/verdin-imx95/spl.c
@@ -58,6 +58,8 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();
 
@@ -66,8 +68,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */
 
-	arch_cpu_init();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/include/configs/aquila-imx95.h b/include/configs/aquila-imx95.h
index 96c11ff2d5b..9c48d2b2736 100644
--- a/include/configs/aquila-imx95.h
+++ b/include/configs/aquila-imx95.h
@@ -26,6 +26,6 @@
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
 #define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
-#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
 
 #endif
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index 97e3322ac28..77af630f5a1 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -22,4 +22,7 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
+
 #endif
diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
index b6df4d48695..98fc6f3757f 100644
--- a/include/configs/verdin-imx95.h
+++ b/include/configs/verdin-imx95.h
@@ -22,4 +22,7 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_30G
 
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
+
 #endif
-- 
2.50.1

