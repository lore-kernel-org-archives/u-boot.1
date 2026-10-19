Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA1CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12DB880E3E;
	Mon, 19 Oct 2026 11:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vljMWOBdAB9l; Mon, 19 Oct 2026 11:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D29180C74
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792408456;
	b=N9KO4NrBwAvBr/qHHGr4xsWaS1cBlnKzpEErzmCijXQzRh6jsYb89Gp31UJintTdo+BT
	 11qKAlT8ny6ZcXE5XPavmilPNr5n4LTPPtZbptJoUipMmJUQYs3Q5ywgCmJd6FS2U6KBH
	 K6vMGvPjjAeQExY2cqqamj4NR4u+1kWMQQ2gtNWhGDi654QOxXBJeIwqSYK2IkkHwaz0I
	 q8jNjjtPv8RS1P8JWJmw5zme0a4UjYMrQUNF3V6WvKaQHyWLsi/SORzildofPrtGUUhVP
	 CMakjutxLZdCo2COOfDXoKjd8U5pWRPp4iiY7Vr/4SrmOEk2sZoNVz5bBaWS+1cTu9g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3Frh9XKhctGDYcWwC0+/VdG/66/jNEm+Hq9HRpOs+Es=;
	b=ME5ld6cJkN7I1UuFLZs6ekj2IRY8Aix4OkgvSuUJ/tDC9+/ifb4QQHzXEbCa6B/9nYZf
	 ervxQnsg2W0J0k0OmcdCHPwbOXRbqCyn+zvO8zihxrRRH0tNOt8SrQQftZu1GMX0xjTZP
	 6JSbdaL7GmYWTvLILB26N0cpGPezrozpJDR0ePlNrZfRD/jel9E7h2Jz8DxoTZBDdOuAP
	 NKIdNuwkI/ANOOOes75naMPKYJmT9EG97AKR4FvDBtE/hH0FqSw7lf8cwC+nbdmb0l+By
	 eMAvzfXFoaYCSmXZ9A0BxPD07ZwhHdmeJrTJOCJHOZ0mIaM+geamqB7XepwyJ2CuTog==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408456;
	bh=3Frh9XKhctGDYcWwC0+/VdG/66/jNEm+Hq9HRpOs+Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKAGSS+26krbDbUlou7RPoBZZdggHufhf4IRJoOfbI8bbkheeg5/XO5ibm43w1QNs
	 BCeNHEXjclEwbElLaGI/Ec0OW8asNJo1DFz8ND47agWECmGSDy0IYyqQLfoSMKINFS
	 QW7WTxDB7pdLt7FrANajv4ovJ57YF4Vme9GzaiP2/gRmUJLAGfrnCCmxTUJUJ/Lndb
	 eskXFD1Y4vvtEn/ITVg3W+O8/bD4oYb2mvhSLeQvT2K8TN8pQfyikbY6R+SNzoTO3N
	 Rej6Wh77nFKECk73pcd+gTlZE56JMVVCSlB8P2gzsRiFMUGZCOCUU9rb3fNqk3r0SB
	 5vDKXHuihKJQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D29180C74;
	Mon, 19 Oct 2026 11:14:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DD51769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4BBF605FD
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Plnr8a3FpDor for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC04D605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408453;
 b=eXUK4sQgmJpLBJSVkv5hwHdZRf50GutK+n8WkGaPm4iQECB3jiNbgT0rCG6kjmMx3Laf
 iisXv43Dq6dNhfFx/xsC60gvZGAYpp9KpZzI60LT9DCnMuAEj4X5/C3FQ7igW1lutOfl6
 /WaJwefCGPX+6tjcBZ5N4WnFbXtHeDYTiF+IUjOUZkT/wHtQHTYVUeiJzvkbA/7796Tfs
 E6S8zg9dBVlXXgDC6ilVB8t+AL2QL4B8dD+aF75uogl76UipyvT4WfqD0F08Aw6bS+jLz
 QokOZRW/COtTyCVVaopMFUwkiRjs36u7EDY2VpuzwqmdVkY73T67DGxs6LKLwXoM5DA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408453;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3Frh9XKhctGDYcWwC0+/VdG/66/jNEm+Hq9HRpOs+Es=;
 b=YNNUZt578EqSWOCaug0s0htMAaTeOnRbppjdUjObhcTWg2MxrtLqUuhe0nILXuvAH7dd
 w5fTDeSbk2vI2sFsmo/ahtsImXKxULJ18zyIJ6rUe4rgvDqQy8tCZ0I53L1RHGQPqwdyX
 EfqyDxOlB9mryy4RlZiZZPAna2uz25pNPB99d1mJDR0e2Mv9fufnaxQZWKmYx3nB/bsU5
 R/gIaA+mKzIUqRg6ImJ3iImYaPRuqZe19Nx3u6vvLPdbcEUQ9Puy/iL1chx8dJH2V2G+l
 ajJdv1kTsP0ykEF0m2sihKANMrKr9x+zL54WwoO9Zs/JlYjF+AfmTlXV4l73Dz6e1Tg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=Xe7HODL8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=Xe7HODL8
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC04D605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4iIFzyHg+pd+H65iy3t3nul4jNv6ExW4p7JHWx6TiBO9V5iJIyJkndImfqBjQWyITynbIs/PmYBWreI1ypQ5pp7sB1Jqt1Vejkfh3lfX91izLB86kN5ZYgPq4GbvHRwaMZi3pJNA7zZlj4kWDQ20Y24FcSdYg0x+0BjDxO10aHOk3PeWKZEyMlS0ag8ONExJZMBR7+0J1QHoFUSS7NSoKi+VMis94zoT2nGEZegbqsF2TiWXN4LzRFvvUHIasxmbsp5e/9sXxnSdqSnxUmjUyedokKYl3xe6DNwPlZJkMVEwAk3DyxkutWE/rio3EJZp52zEDsL5+GUF5MBvAmWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Frh9XKhctGDYcWwC0+/VdG/66/jNEm+Hq9HRpOs+Es=;
 b=UGk8+JqwklWGU8yWe8OfCDi0KVrbxo4rrR3DhC14pEBElf/wKAteeKQyKBvS7XlTBmYRCKMufffe8M2ZFV5slz1CvfrQqRMwqxnUuJ2lBET6/U5FAwsKYngVhqcXTTVSn0J0XpS75rPaNCmJN/xxGWkhCne4IUsaw+B0IK95wMdNq3QD2U1/2AlFwRzzcAknvA2XZTZKvI/6MvE9RWXwctkQDlDl8nCnx9IDQg7GvflGUqQAS1jQPNJb8Y0wCBpOUA5lLYLFsZSP7zJUjhv0Xg917BAj2tMYeekmpl4NZ54OkfL8/D3FXQt1Rk/PjxwTZqyFn4svbh42hcCAXx8w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Frh9XKhctGDYcWwC0+/VdG/66/jNEm+Hq9HRpOs+Es=;
 b=Xe7HODL8HxqkHmb2XnCogiMUvtb4Y4TtUVDuVgpAiftMkjar0V1ghW3Wz3a1No3LeW5vKK3Tsls6m/YFnHfQISZUFk61c6NEmDBE6KyNUS8eX5twIAEJ6nKRwfUaEfd+LYnhYXcrGWpMb8wsywu02jYA1xMhNISqc6bTJGdovtl6V4bx4lR0wLyMs0sI4N8ojs/4yZdzofz/+8zpvmHEtYzMDl9q9idHLWbmltoC/Cmr8jC0UNaF5Rq/leDTmi3fevZOhxp1YP0dm8iicKw0y/iZ6Js1WVXMa4eMvEdmIotzzT6CtsSKGkXMwlJiCIlZz7IsKLMgd3n/LbbxiobNHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAXPR04MB8352.eurprd04.prod.outlook.com (2603:10a6:102:1cd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:14:05 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:14:05 +0000
Date: Mon, 19 Oct 2026 14:14:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v7 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Message-ID: <iesofdts7kudwygbwit2jspoxpzm6w55olnuvdtbaw2dbwyugq@2w7bnkr4pmg4>
References: <20261008224228.512353-1-vjardin@free.fr>
 <20261008224228.512353-11-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008224228.512353-11-vjardin@free.fr>
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAXPR04MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbe4fee-cc0d-4cca-8621-08df2dd21622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: 4XOZ1VIbGIDyoqb17DFgXS4fILUg1PBkoi2uVNlBPW3Lvxj+jaNUc+qxW4PH17Whz/OlX0Ml5U3hF1c3ckc1iQacO3hdCOQrSOZ9dPQhc/K9RygQC4/ucNMO5xMD/dfuv/kHLhmJOeCV5EYeX4I7Sv2+mqEiKBZaXmQsJ3BUVF4vzzlULFypRTAsD8pphOocHilBIvVdebMudFfi6KnpwHdK+PUsl0hxUx8x4JJa4CD/egYiYbetru3zZdfLY/qQ4W0/BuuLokVlgd152K+WRDRmP1NjShx1xxEYNKd3L7vrZYeR4OzTt1SYE3Oux0ss0a42jGbbmexHyX6GXwNK7DsI5gcRy+zPzvay9Al4Srs5+ITdBNmjyce/gdUVn1nfKfhBaEc71ys0VzGxEpX/Y79DQ8ZwmxnXSbig3ClwxJkzThaKqb+LkaA0+6A+iFbXZ5QzD3Cwav8tKkV/iJNjsvbx5vlC5a07QzoTt8x0MMz04Yc7Kq1GlyalGJIEnwOkg4+kWhAzLoZVgyQuoQ1DzjPtwzuqVfBO3t8GcsO+4wRS2RipV0eLfH6zHMQLMrkkyxqtBuJ5xN9cyWieGZFVU0xi3V3rZZjgyFxHubxMLeHuLDPBe+DwFwWpRVef0zqYPw58EGHzA9dDIaiFsWvByjq5SIzVWGMKJIOB/5NIMeoQmsLep+f0BSZOeGHmESBXm4DlcDVKe7EGLpMM5Zf12cW4dJasU0z4ab3kttSCPeBE2L6mAh2qyCx0M7eITq5m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uv5y9IwOCYUplTy76kkENQN2Vg/XgezdNZY+w5w9yMiKUhJjeh+ZfzhvEs3b?=
 =?us-ascii?Q?wQgjzJDg/IHA0pcHiPMkWg0ZrLFYdg3hkntBJtKo/nGHx1dq4GWBvx/uNA5i?=
 =?us-ascii?Q?aPWEGGuHHRo8pqe0Q9TQRd3xI6xA5OuxqBAXiy8GcMuzW+8Oun+MHfzeRaBL?=
 =?us-ascii?Q?t9PF4Dzabi8XDfquOSiL/8s85SzUSSTynL4KBEWA2bnVXrhsCmIxT6UA2aL3?=
 =?us-ascii?Q?5UlOqj4D3ntIgv8J+ZFNGpP1a7N5PDxPfpPYLcLk+m3nwdEeuQevmQSNoYVP?=
 =?us-ascii?Q?mTY+y6XWzxLaytIVhXSMF2aT/NkzRc4iS97uj4CZ9cueAww5L3XNu7JBMTvP?=
 =?us-ascii?Q?KH5sbhgAFy9VcgcdZKPKvs5o/1TUuR4L6+J/AcZwJGjv6GWLUJIkcTqYUmFX?=
 =?us-ascii?Q?PhVR7BylF00v/uUEzT7tq1WReWUhUJ1vVVCTq4MtP5Rb5ea4A2EDZe47JD2T?=
 =?us-ascii?Q?VJ37dmV7omv25lOxFr1nwmVihrasEN0F/yQxV8hYQT3oUaPNrjt1TicHY52a?=
 =?us-ascii?Q?HFtZGcOZ1cb3/IJapglj3Ra7BfFciPcKfCKQ9KU/xrQnv6Q9lYSkK/7fPNfQ?=
 =?us-ascii?Q?RK1gWYEr5W12nxeoiZbStCvI7m+dcrB0FWAtXrfIdGLpqMajRSjdpQ1ubAc/?=
 =?us-ascii?Q?8g+bRqPLmfcNjrnub/AkKAFpkBlFLhUUk0pmP8uOlkiT/cpL7jnLPxUBDNoM?=
 =?us-ascii?Q?rtMpcXcs6+rBis8EDsSdZDk22+X3ogj3y4LjWYQUx9Kvu4+1Yd0I4IJ/BjG7?=
 =?us-ascii?Q?JW9yMf14oohthmLz7F8H0Cofqm0yE7WpJ3HBKstBH6yuCefGFNqw9u5G4Jpv?=
 =?us-ascii?Q?3idUbD1pw2fXtSt0knyVl8P9ijZAHQ5NTh0p0p7wcXILmREB8kr6yjJyIg6d?=
 =?us-ascii?Q?TCf/lCU/jR5Jcy5RMaGwTFeLXFx0cB1wU37m/kUOVUJM3ISkedaHj21PMfES?=
 =?us-ascii?Q?x9SFsoQoaCw3hdQSU32j8yEfYph6iLTtqo5AqSrTLTj0JEsDZ6XYodX5fNjA?=
 =?us-ascii?Q?kt0ihIrKWA7ENHu6H/uZwM+prkKQ4cyX8pOPhfsg17kF1ceF8FsEo0GJBsAJ?=
 =?us-ascii?Q?KeP9a1MG2C3bYYoBvODY64HEPVSgxpUMBbVn7kOBmcKEPvsw5j0zGyGLL2tL?=
 =?us-ascii?Q?PIVIQ+Vt6iIGjsKVwaEh7v1orkF4zhl5JNpVc54xS7ar+Km5cZj2ZQw7RbcP?=
 =?us-ascii?Q?inEksHlPlQbxqfx0B7L+b4uxcGT7doKwS6TByzA6wrMDOLRS60nLi/IcFPHA?=
 =?us-ascii?Q?oitvi3NLKLnUpxX8m8dRtcda18aF8VeuVoa1G7l5u6DXhYlhOjnHqR3EcIcA?=
 =?us-ascii?Q?hvNEsBSsk9/bkgP6QOVrsk1wo2hF0IknUmGa+Im62k8Fx0/aomaKMarrI9Bz?=
 =?us-ascii?Q?rkjZ1VdQFzI1NEHkgPZkD+Y3vw4SYthbs4dJkPJQoiLzmwS1v5AanA+1p3v0?=
 =?us-ascii?Q?Bc+NYdfX7cT9U2LgTiFF1Po0xONdn2T5UJmtXJXG1Ue9z5YCCQiyNpfnkClk?=
 =?us-ascii?Q?fZzZ7qY9oS7ECvAsN+380X20gCCdZILnpckvQPhBHh3cpj34gEd8OhtOT3Mx?=
 =?us-ascii?Q?4z6zzFr14tJifyFc6OXB5Xh6cBQtcuOB7Ia73qx9m0IfXuJ0GRvZlxl+k6KK?=
 =?us-ascii?Q?hc7N61oJbAoGwlPpfakU8I+gRnV/vlFmjXtvAQIuKjwChArlf/PawjQOJIZv?=
 =?us-ascii?Q?s/kxLukhIhKSk6zqVZ9hWj5EZ/qGPWK7tWVp/5/a8SdtH1EgvN9xh+3y5G/P?=
 =?us-ascii?Q?ejOOM9gSPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbe4fee-cc0d-4cca-8621-08df2dd21622
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:14:04.9204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPpw2g6XBz1xVX9rM7zLvksCpA4rDuuPD6ONu/tkDFlgKCmzl3PMjZPCt8bBLRExNIHIbf5kKZz9EcSl/VdrXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8352
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

On Fri, Oct 09, 2026 at 12:42:23AM +0200, Vincent Jardin wrote:
> Add a SD1 mode that keeps dpmac.2 as 40GE on LNA-LND and that changes
> the LNE-LNH 40GE port 4xXFI ports, dpmac.3-6.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
