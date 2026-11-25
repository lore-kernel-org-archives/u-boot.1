Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDF606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z5Su0zt1;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rMn/nzJ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A226A4061A;
	Wed, 25 Nov 2026 06:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PE99lURmY_km; Wed, 25 Nov 2026 06:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0AC640609
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795589255;
	b=cUmyWK/F0fTUEmmfVTKedu7ULWvC6UiJbpYiiLTzj5DqAH7XJymHwHZ2hrwfImPMVJ4e
	 OyyPzHUq/1ptXQjOqbVCPi8xTCL8aAo58h9OONp3gq3LNuhO7pIN5xOQn3QREXSXC7WEo
	 oa/uHBNLSXOt+bk92WQiC6Jk+poSHCgZxNEZcnR3vIkhaGksibY0zRYMdew4iO25g9CgY
	 at1l/qwjVZSjFs+jHHRtIw8q1fJIDIAXkaoV2ri20XiJJ8pICONQ4fjlhABs2vbvveoCI
	 5bg/OnZ8wCpK9sQAhuNQDAgV0+PvYW7FGryARlp3xSztgNoy6vbKRCcxD18HU3SO09A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795589255;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CJUzRYaf2jKj+4dVbrT4+fWofYbPY914yxcqeqJuJYg=;
	b=O+xXqqOR4mHRH3qP+WOpPUdkI9qrKbIwx1CGBTJEcluB7rdbg3tgCq4up0C6Yc1XiQ5e
	 /wyOPWHDSh23b9VYjVkfSBr9mjeie+eUqPLKzEvHsIu4EYtZ2KsAsnMryxvi19OnsP+UB
	 08AI2Y3y2h2c2/4ZGZR0FGnmrrr03z0dtLyV8ITdaMO1mrrJ+pYCIqSHf0q/TBm6XHFBl
	 cBGTVZZi6FQ35yJg3j9bchfju636HNdDG9dK9jOZVv/awKsF1N46mV+9Vlftw9WquxDaN
	 Qwb6ZhF/tBTsCl9ygOln6dp2zRfrjLI7IEDaiL3CrV6JwrtoSdab+ZgBm35fmeskAsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="rMn/nzJ3";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795589255;
	bh=CJUzRYaf2jKj+4dVbrT4+fWofYbPY914yxcqeqJuJYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z5Su0zt1B4+GoixocvhWFmi1v9Upu3fx5zboqpvyYkoJ8tPO1n82I+9YxuN52TRTq
	 h3Hx0y+PrJZkOEsD3/whHSN5ogvdkpTs0XtGyu1wZbfZ/0d+2XIGl04IAZtQ9mEdKo
	 CJJsGNgbbzWAi++K+A8r7vsSUrFF2/PZkD1i0DG5CDUmp62K7dyshxpsJeOsHvc3x8
	 S8D1y14FhG0y/M5kZAAbvPDIij3TZ3kuvX+UKHvyVhH4g8RFqeAkEOV1Z41SHGGYkL
	 +X6klxU+1rLxWQApUhrPWuXLWVPQGGcKU+Wo9iQnrgrBqLk4Gjq8EuoZtQ3NY1FL5Q
	 bFX8lOeC4+tpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0AC640609;
	Wed, 25 Nov 2026 06:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 897B210B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72CEC40609
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8PApqaOdvhd for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 06:47:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4460540608
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rMn/nzJ3
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4460540608
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJUzRYaf2jKj+4dVbrT4+fWofYbPY914yxcqeqJuJYg=;
 b=rMn/nzJ3kM5ewya+GB2vvhdK9ypEYrS9/TEjff6BrMn6SbI7RJRy0XY+paIWASDw+D8D0bmyv/zTnym80O6H1IMdyZ9m1qJHkmbTHSHiTYhtuKbeMf9Eaz7d0lSy6c/XzJJjJuBs7Isja/WAAcWiRlDkqkeL+4utVTnsoBUyMbeN5yEgGf8KWstJTcnPJw9QKijmYhRXjQ7NwDoed5/Sp3W2Z/N3PT9PTaFm7G23drgL3sHNdXWumyzMdu78++2NBvJOchNTTSzpU2fjt/kk8B+KQ4FaI0P2nY8ihNqmhC+1azOV1h1mCrOsgKb5GtwACjQNNM7ff8aVC2le5XSEtw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 06:47:26 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 06:47:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sean Anderson <seanga2@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] mach-imx: spl_imx_romapi: respect return code of
 spl_load_imx_container
Date: Wed, 25 Nov 2026 14:44:26 +0800
Message-ID: <20261125064428.26978-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261120080017.2762904-1-Max.Merchel@ew.tq-group.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SIAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:28a::29) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: be5c169e-bd56-4e9a-ff8e-08df4abff71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: h8hIKl4VGusOBjGaxDHWHXbWWkgHe+xoFkw/htVn7JR18aH4dgv9TTuOlJ8+YAqyGGIF7abakqg3XRVYuUNgoB8HM/GXJojENvDaVI5AGevlUFOVGqkgRL0JPJmIEnX1ru+cNVuxedSMFDZ02bShQLN0ECv0+F/4pxuio+gy7SLSUqcZVvEfWUMGC6/Thp1ZdaGs2WSE0QNw/dVZTrZW5ZwwdxrjSC6TMySRiRT6cmYh7PhnWPc6DcG3+ZEpLOznQ2ifVPTtNnFHR+RpLzKbGHep+2RWymDgH9WhwNCMLd5JiKx3HmWnDn5aWlVGwdsOsUeffRf5o4vmXCV82uBxNdxG+Q+wMtI2egI1upNlHHUOlhrfNfMBFpThbjo7lVZ7KOVn3wq3aphT/WGJSjWTSip8l2P9UYfMVhfmqTBe6Ltipb+dCRF6KrZ/fEp3OFjYZnq0aOUkbJoIBAhb+owO1c6Qkp80ebG+Cf4lvMkXEaSkQCF3Wf6V23c//xkfw1kTmmBzwYi34e7QBFkunZ/sCtTQlcFjcSvUlAdQcczJUhXGsmloFXExELUrf2zxhJHM8sZtkK/94rzWhPyCja2+lf+A74ooNGWxbFcgh5+hNHtVUDPvu34x2aO4E90YDlimh9MkmLUipou5kq+l1JxPWFi0C0kx3vyqtIY1IkBXJHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5m7GAmMwvl5Lpt2hTY/AjlDlh0+Z3yF+FhEDimyPdX1zP++4eM48v0O+t5in?=
 =?us-ascii?Q?7nJnHRmY4dJ34QFeraTLBqTYeXCPhIkT4ZUovSzTtFKPNUFzPR8HMSos0U8A?=
 =?us-ascii?Q?iOOocWbNT01gDshbHq07o8DRguINYtcFX+I9bmXKi+6zP24PU8OJ7Nv/zEUg?=
 =?us-ascii?Q?beNO++YcHWT2CGQNJZ7bDHWdI8tlN8Xn9hJSaelAcXydAgICz23R+AXjhUY/?=
 =?us-ascii?Q?0ITP+0WoPWmu3Va22+sxPN+/hNuTov7QQRmtzaZkXeFnrBPotwDQ6Kva2QB7?=
 =?us-ascii?Q?AxOZV472/DV4D9TP15tf7uJHiVxZ+oy5EAUQX9epuooyerRWxRXSraldR23a?=
 =?us-ascii?Q?8BphFqt4qLiplS0Hd87fNOfmQ/ypJAWjWuBMFFAqW7LW3eQTzpnFO1Uqe7qt?=
 =?us-ascii?Q?AZYG/pvw1+h7Scl/cw/KI39XMVQaR6iJEhx6s3ojVgWpJRVkQ1yBQiW2KvPz?=
 =?us-ascii?Q?aTIRc8gGdSpPZpPx/gPKW/Tu/GqzeZv0ROzVbm+XE+7XHQ30rZs6UFZrETCL?=
 =?us-ascii?Q?UCz7kAt6BWBqU6lHQVsj53fGTfCAgdO60uPx8FdrN+8Twq5JE/qrz9IFhV9i?=
 =?us-ascii?Q?Cnd4xLczi+ipUWrF6hBMCoueGOCOMlf+OjDTrkmwr2ly/M45f5UHStw9F+SO?=
 =?us-ascii?Q?BV221GX8pIKIupEzBUxR8yg5+6Lo4mBBKSF2Zn2HGg+whsDllCwSX+TEV2df?=
 =?us-ascii?Q?N05ygVoVl/D3sFx2pO7XIbl3vMOENGD+ciQAlq35mG1wzWBywXa+gAk6z92U?=
 =?us-ascii?Q?YPmkt6tQXvPznXD+aLuRwvZ+khx4oSpkrLsFJOf09ptMDh767t785PIoDal7?=
 =?us-ascii?Q?GQbAtxeYeUxIxoMsXPdd/0XMp9cweqUexaHKqJRdzB5fq4Q1QzWBe62U2I+0?=
 =?us-ascii?Q?UKIFwTPoXJquWPuTD+mE1BUpT8Qceze7qnxTX12XP5/LZ3bz2LzUaVRnPMrT?=
 =?us-ascii?Q?AQBvTMyVhqqfOuBHDvkZE4+CpCK3E+2ND2BvksuuvG7deiJQVjQF9Zv5abZI?=
 =?us-ascii?Q?OKpUzvfmbREp36Muud7JlZhet+mwExgw4doxgNE4lZuwN1HgRSoV3/oLnGCk?=
 =?us-ascii?Q?pA9Fr6tNoJf9UQXSJVdcM4/wjrCMZ/3VIh3F4HYY7+JtKU0c+n/KVJfrQ4x/?=
 =?us-ascii?Q?PNX9WzTdMOzUvvRXYXY0nYc9f14zYw6hR0wrNQ2tbE47hL3vQi6AGofLhCeL?=
 =?us-ascii?Q?mDliZIPkK3BUErxo/reNg/UcScmi4pPAMYk81qTbtwQGHMFlG3FDlsULQCTB?=
 =?us-ascii?Q?CvfwZDUdmR+XtNLUEhhXXnAPZrPT4UuYRQaE4lPz4f1J4VbdBmu5Bzc0tkEI?=
 =?us-ascii?Q?1VxBZmq+xZgMpimn3+dDXkg04Bs1QVIiqlHFxud3TgT2KMjoJKkVhNksfmME?=
 =?us-ascii?Q?v3dDRVbw9x7HuBshFZkmGXZVXRzEnGy49xjqzMWjnLF/Hd18I2cRC7OhNGe0?=
 =?us-ascii?Q?KKvRhE4N5dGiqyg1+TQLP8rmDdbNVsTlezThxXtoPyuLey0GvnRV4svh8YpQ?=
 =?us-ascii?Q?bbwkd+hgJNFhSnYs937hB/osKLWlNryQB8unzYlg0Fy+MO0Va2v34sE9H2rY?=
 =?us-ascii?Q?gRkyeY8OP13CVi/qYhtlvHbDtdkEkeUu+Hq6OO0eoBTIFxRH0dP1I6zunaZ5?=
 =?us-ascii?Q?i1F3Bki9V/IiR5VT1czlzMh1emrtfDLtjU8UwEwUCf3u/nZXbL9h2Sexh/Yy?=
 =?us-ascii?Q?PQ2LwrA63JszEbgmnJG408rv1Z9Zek3jSW6WHM1fSqbMhabl0wIN7QRjq2UQ?=
 =?us-ascii?Q?y2Xcgz7z4ZSezP2HiKitnbclOA+F/IAn/li+Ft6DJSw/fhqq7kJF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5c169e-bd56-4e9a-ff8e-08df4abff71a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:47:25.8364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /81heszUk9SuD4wEKe+hAbKZOfeeFiMIFqMtqRkvfDPu1HYv+bGh0sxQX7toNpDNpJNU8TFWqEyzgkYCi+TnJKhs7rXZqn8FdmO87UY/h5MhMJtSgwg6L/RhYEBrRiVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 09:00:12 +0100 Max Merchel <Max.Merchel@ew.tq-group.com> wrote:

> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> The return code is assigned to a variable but never used. Since there is no
> usage of the return code and no functionality after the call just return
> with the return code of the function.
> 
> Fixes: 73c40fcb7367 ("spl: Refactor spl_load_info->read to use units of bytes")
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
