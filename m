Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2682CC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4340F60AF6;
	Thu, 15 Oct 2026 13:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaAvoDyLnGA6; Thu, 15 Oct 2026 13:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF77760AE7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070114;
	b=HzmInU46N/zOZVf9CnZ8VtabSAN7vpkXcRZk098RWeTFeNFe0Xc/d5+hOJioYlw8a+Ev
	 NmiERMgpkOqkTwQ/3vxlWOt4NmAGTFDCbzHSUNVcmSPv72MAhA+GL+sGSs/esMbNijGEK
	 I6F+0g+NsfhwXWXMqDRE7RDO2IFIV5vDKS74GHnNGK+cwlp7rQPBoa7YMl7/QFUanj5s4
	 zIGE+AWVjSuqAF0+z/7NW84vRNkeOVZer2OxR3cuWb0EjfxX4JOhT9/EbTWyXybpNC9p/
	 wR5rkryN/Rzg8WrLGyye9xfVjPvI9svmR3qgPUYXYgD+ntjcaxvYFHASMVR7J3xG8hA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P3//b8tY/cKLLtHMP5mM8+TZ3Inbp43/F2L9tocApMA=;
	b=QBCXUh6qjneLvTNw8BLgsUSb1+QSpm7aW4b4TvPLbktGB0yeOMfeUCDg41gyam7Z4PYT
	 FaYKdGK1RQ0c/LIMYEwbF1C3IdUE+zspYydF75WjYt1KQmcCBvp4kUf7RC57YUeyY8FYU
	 GVXCtKA00Uv706syBePWqV/+44RHTcYrdsnNef/ObeVJQTOohfrITF5n0+D9QpY2eXhwc
	 lYjcA2/6ehOd/tCkcuI+5gcWxgVFaP9gQ6fqLlQL+prnfiGCP01V3Nv+txLjg+eDDA6nU
	 fBubtyQ+8A4QyMI186uJl5t1OVzjcDuwQGq28aiaRHupLDEqzBSWjOyPin0YHCZfV2w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070114;
	bh=P3//b8tY/cKLLtHMP5mM8+TZ3Inbp43/F2L9tocApMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYlEffSTX5YnTOx8ABQZVbQ+9Tfz+7hx0bpBdoLghsaxjui080o/0A1PQSjJHElOc
	 YB7pSfYxWbVQJPgADHb0FINjZ2duqGILGJWC+kHMN2CVWO9TzI6iXuY+G5B0NpVaDW
	 Kv7psVYb8ZztQqJD+vWNG2tyOOL5BQ96JxNv9abvsqyredY1kESbr9i0fTsE3rdrAJ
	 eQvAnJXU6k0YRueNMz21BuyEX67VYGCx/ukBZa3KZgEy4aIZP9Zaapqdujgz5Flxzt
	 5xQOPUkbv7T4QMlnT4wApNtst2gFU6jIYjC6Ios56HpiSI62koVql8srOOK4ubsAcB
	 OqpQroBCLteew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF77760AE7;
	Thu, 15 Oct 2026 13:15:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 81C9F235
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67A6F4080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1y7WQJ3rIFja for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CA004080D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062838;
 b=BaY5faYLDsj/QEojVQI3xhRMZrKL0/EwUdmpsm3UNkAmCt+VVZWV6/Bv0Puvd+fFIJvI
 VLqV6Ix6XusS4RTndSDXtOI9MC4E6V0vgMYN4gyFhT549xztnxahZ29WMeg9QJrSy2ZwZ
 GuWhxDLHtjlRSrZXwVrvVKPrldNdhYEKML8y7EB8qKvL5l8cVQvix4X2vwvKH150ATfwd
 ZWDWlqAaMBLEyFTxvBBctBxoceK3ujdER0x7wFDqGdDLWTOOnS3rHwM6m74zGsFQPlmmS
 ZFhtsY38F2sulsoAp0E6dYwkd69ki9YsaihXkQPb6R6pwmmdh0fNfE8xtwnq03ixFeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062838;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=P3//b8tY/cKLLtHMP5mM8+TZ3Inbp43/F2L9tocApMA=;
 b=oOcYRltQkRDg8cbRA98OHsBgxPT/F7lVA7tzRbkAFCHz3y0i7WR+NLc+OcVnpPQVGBVl
 YEl7GIHe0Ao1Jdr9w5epJf5bBr3TlgSfQGSIx+CPaabso5TTox7iMtkDJfqIeukzbPz2H
 DUlZbmqdH7dqIjARt/G/4EdSSiTl+VQ8q3GhrFD3tRMurg3FlifOFzmI8VvUl15yTOWqz
 jeRf68sEKdkrrhhLWjqiMVkOqWtVd7IzCEAo/a/nxokv47WMNnk5DP9f2CjU9IYTertl6
 56ckQqMpGGXMo+KdokKyWpT4x+DhJSVxjFxDSdDOk+YQCaYWMFPKYtqU9Ccfzktmsrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=qfRwkx4c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=qfRwkx4c
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CA004080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unhlXf8zyHeLbpFEFllEFDaMP0sH6JDkRbZpsyMuYzjpCnse8VQ1Rquw0cB4/sxehAjeMHfAdEcXZzcb9uH6ZcmU6L23X/V3497/A2CEPa5DpzdCLqNz9Q0eHQ5TfB3mUwv4iUz4uMRGPmWIkIOec1BAG/nhSKUINLx03zbOt44IkkERrfJabVfZx0xewrm1SceGmxDPOFUd/T9tpYkxIJ/rAHmKThTU4IrmRkryuMkuzIcdADtKEXss0Ft/wqqSmVRPcUOw38F+x6T/IZzN+F2KA7/qnhrddZJPJfy8ZRGbF2VUwcjxSnsYw2kmSJh00ZJu4oeh3rEH4qAa8C1iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3//b8tY/cKLLtHMP5mM8+TZ3Inbp43/F2L9tocApMA=;
 b=akODalJFKkiFZIdqLG1BwUU2Z8hyxPw8/nLdZt+e7o40N0sPQ7KtHvlbGXO5cyhPhQ5Ccsn7VMeXuV2QBXPrxmTYDo4rRfieGWxY3HeM8vHYriNja9mZz3pF7p8lMIK1nbDhW+xDpbmXx0CRhaXAfh4HdsaXwLK1MXEKJx0O4PevIDTfO/8mFkaWt58r9myHZNT+du47uaePvSL4Q31Y1+Pg5onJ2EVd+pMDdPtMIh7cwqmE3KAJODeP6Vw8wytbACbVfXWZlUPZ/93sX3SIhrFOecb1g5ajMfkqM2yXlHBlsX9XO0F7gaZlfuYC77azE+p9Uf3F5LpgMi7I8oNVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3//b8tY/cKLLtHMP5mM8+TZ3Inbp43/F2L9tocApMA=;
 b=qfRwkx4cy4o1+s0IBIBnRa2CWcALjoeiyiRa3z+9LoCgFmmy3/FKH7ovsMk/pcYA07Gtvo1/6HZA5VPfYeumKVYDDJhIQbX6aK89Vm3DshIANmJ/fe6i648DWVgRlMI6FvHD/sQMCFQPEjVQbo4xv1KDD8xZ+8k2e+N1MLF0u+7JwMdRXMWsrgTQ++tg0XGhp9A+T7J6VJKQs7AVeRFtHAnik2WtVRPjfXdty40JT/6ZPa8r1fr0Q8BwheL8rcCw9/VashaE1BlcAVE0XNKiXUvrfMpP7MuNKJObbmL1OjFBxs6shUNvZA3XPAVO/Zt6KuVApd2luBkUx1jeC5srVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:57 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] virtio: 9p: Reset the device before releasing its queues
Date: Thu, 15 Oct 2026 19:13:20 +0800
Message-ID: <20261015111328.1269775-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7c541e-f329-4ad3-03bd-08df2aad67dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HPAUxKYsHqwVaD6ch562SV7QgRxlRCv0Eq2Cu4BfGWFpDgVaCoX/CFaQL+13j+aNmcPABi3KkCVBjL6v2EwZSlulhoIjQFvbne1+3bsyTTM43HP7gkHZOhdNcZFOKrxnsbyBDaP6AAtlDY0LkD1Kzs1Nv0VdYCll1xW3ufuSQ8ohqSZRmdTGNKHxnV6iglmf0c75mLPTQHZ+V09zwaKD4K7ikmncGnhWQ4RlHlKGYj7fV9ITYRnsi05rbkOEZmV8atS+9fYNxIcA7zkQXqeTQgfGtprqasr9CBAjLMMMCO0UCMWzkWT9A+LZHGw+8imx1CCPUWL5BjaR2VXU3w5xk7WqPo2n3EEjXVKl+hwoBEJmoAfm4Q0aFJg4ws22ELo5R5jkO/gLo0s0bDTqu4LBLQk+q2sXTVY24RV9H3/BG0j1PmkTWhf9ZldCcyc2narQdb1acI6ScdTT9RYcFbhVvul+OHkYLppcTv751/IG5lYt+nipStMZ+G8c4CAOdxGz4ACWZSAxlyWcNwtgM6caCIU3rtJToOTLlnAfKFNRTcr7tD6WQGrDPBU35xX97IDu6buhUqAj0rjTheHq90zJA5ero6s4Ai9LADOUsne7Dt/OUcE9f7lSWsd3gVu3eJsPE5RnNRLS9S1PTPHP93sFPL1ibwiEjCbYyig0aNH/FAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y203Y4VLRtnG9joIcLnCvF4U+zbcnhniQPErJ7yuSNY/Ep0CkJBDoYrP3COz?=
 =?us-ascii?Q?iL/IqNz/nB9z8sUCQREri5wqFX/rB4fVOYhETEcntzUiIDSIU9QFL8RbFJKH?=
 =?us-ascii?Q?XM00HeWaEVDCoKY9VlP5jGH4KVnll3l2XbByZIi/g65+xZ+iMTZeCuQrLAG5?=
 =?us-ascii?Q?3llKYtmYonhBIQRV9vyquKpK+Iln/C5s9ZuTJFU+WBs1Gfvk9xCWwsZhrs9b?=
 =?us-ascii?Q?McIOaHpSAjlNCad4zd56rm1KxXIa9uj5+pVOcFlSXTsBOd8hzhn3Jmfgyu/p?=
 =?us-ascii?Q?qOTN3orqty2LyXsUzPQ/rVWDnJDaL3VvmdQpsdTsK5BpcFQYs9bCuyaGaGah?=
 =?us-ascii?Q?i6kANeSCtZBQoFkPNxYBxQ59Ljxtyv9H2kZgXZ9TrerYmLIRjkEcZiDVyHxx?=
 =?us-ascii?Q?ddUEaqG/jOEBCktkL7Ebp3OGRAfHjF8wEy4Fga3ymuuvqz4TGyQCNOqbojZ5?=
 =?us-ascii?Q?VrRGLU8+qR0jRFCFLHySbi/UFfDy0dGwBOt7AVa6+JobmWvOC/nZsE/NIuI3?=
 =?us-ascii?Q?SLdNQqHJfn5G1WBnFoag3xnYA8nyoH14lT+b9WZqU3whHY1MIIQjvVUBxzET?=
 =?us-ascii?Q?gKsziDfXW1nxQYR2I1Mzg/aE0NfY/bZMTyfo3Nhv3/UWiwxnGfiPBqrurLlC?=
 =?us-ascii?Q?byZcdwnM+xnnL1LcanvpHTWRVZYMsKtJJ4HHaoMLcRncEoUa57IqHe/0++GO?=
 =?us-ascii?Q?ArpZB5GIswTnKUxCQUPh118lsNjGGdfFBRx7qOd9PiIgWPyIP2LScoI3J8ns?=
 =?us-ascii?Q?fs/7AGTv59UfwUvfWMqDtUejJThUgIpffc3vUe9KjaFRrXfsgceZh/18lwX0?=
 =?us-ascii?Q?CSco55bDaDZ0WbeUcBqIiDZ/m/CAnoix2VHcIT8+UdGikle3plCkJLV97RgZ?=
 =?us-ascii?Q?pX8kE3xbKca04Wzo23HBe/k7FBF7ontjrZm/diF3G5rXhUG43lT58qQkL/Iw?=
 =?us-ascii?Q?Z7A8yItsV+XwslAD0zKd5zuJMRgo2uUMOghDDY6r0DWtKwKJvg+HAKHS22ZJ?=
 =?us-ascii?Q?7v/5hwj/w5M7W1gb1inacAwgYGnwhKScBjey5IpBsB5BlkP7MA42HHxY72U0?=
 =?us-ascii?Q?vLQazzNKlRjEnbQzSEGEVL3M4EcygtRCbdbOcsDsG3qVD8FZycm9ZFBsZh63?=
 =?us-ascii?Q?tksT6QDF6Efp7HZqUODrd06Wuc2Jkpf9/pImA+FamNhCI5fQJpm0glfbWpPy?=
 =?us-ascii?Q?cl7Q2AOy/itfSPSKcI4SJ/YQzSuz0Ailblv6U4OJglkk9txhBZ5URdnLVqC+?=
 =?us-ascii?Q?0qLlcdLCdM2Gz7VJCezKtg6hTXHM1QZfLDCG8lli1b9iXVLFiCRKBN6JXUDb?=
 =?us-ascii?Q?splmjTIngHUqe+VIHO1rtCIdAyBe6SfeGCYdciK01dwsSlurZ9Lzw0n+115I?=
 =?us-ascii?Q?P8c1VIkq9/XbMZFYJY70i0vQquKluopT+Gwp9JlHLLepAewwNPm1ZkP8N6Ag?=
 =?us-ascii?Q?DkTuppxfyCTjInN0Dqm3sMSEtQ+aarR85w/PclbLzTpe4EDfW4x4qIkgTQNb?=
 =?us-ascii?Q?FpbTMu6ogQKRumte2YXsW6yg6kUgnxPU/9uPrzPO155g2dHRpyZxdxScnaH+?=
 =?us-ascii?Q?EVrjikE+HJJDZFdAQoyhIU2RV29w4D7DVAB1yHL/KAq+xBgz2i9jYAIdaO89?=
 =?us-ascii?Q?7TCLAGV17ybfxt8oPYB72bjTF+Rq7RqAcm5wrqfHqJz34W7D7EvIhOlnbT8Y?=
 =?us-ascii?Q?O9WLe8uDOWZSbA/80xgwzFL4XzOmBLXVn2YnL1hkzaQCq24t8iYiDVKpInLv?=
 =?us-ascii?Q?Is3/jeq1J+CvDb5pqoKqfhzhy837DOw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c541e-f329-4ad3-03bd-08df2aad67dc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:57.1918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6e8RqB3loKihKssaxbSv09HOe2+7w+HMLKmgyKYJyikvnGPXpzcOs5Zv5BAQhzIpW40kuWJEbalbBq8OSlEBIqtpl3KaI1yARDaMS6hwy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

The 9P remove callback frees virtqueues while the device can still
access them, then resets the device. Outstanding requests can therefore
race with freeing the ring memory.

Use the common reset helper, which waits for the device to stop before
releasing its queues.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio_9p.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
index fb2eb0c7223..d0fb39a1de5 100644
--- a/drivers/virtio/virtio_9p.c
+++ b/drivers/virtio/virtio_9p.c
@@ -102,19 +102,13 @@ static int virtio_9p_probe(struct udevice *dev)
 	return 0;
 }
 
-static int virtio_9p_remove(struct udevice *dev)
-{
-	virtio_del_vqs(dev);
-	return virtio_reset(dev);
-}
-
 U_BOOT_DRIVER(virtio_9p) = {
 	.name       = VIRTIO_9P_DRV_NAME,
 	.id         = UCLASS_9P,
 	.ops        = &virtio_9p_ops,
 	.bind       = virtio_9p_bind,
 	.probe      = virtio_9p_probe,
-	.remove     = virtio_9p_remove,
+	.remove     = virtio_reset,
 	.priv_auto  = sizeof(struct virtio_9p_priv),
 	.flags      = DM_FLAG_ACTIVE_DMA,
 };
-- 
2.53.0

