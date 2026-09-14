Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A469C88E65
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 11:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA0D780CBA;
	Mon, 14 Sep 2026 11:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kwggwV5HOlh; Mon, 14 Sep 2026 11:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A274980CC4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789384147;
	b=X10mNLhQtpx2u/UII5J0Lmj+iZQiWuIHAlVwZrmB/xZMzM4XFEhXwFZUX5iiGaABznAs
	 bMcOMNlGFvbdegDM/ehLUgS9d2T52FlTHZdTQRmqpU9YfQKnyFLanaC+9PnJWTW4yr0WV
	 UJcRYdv5yMRjrxG42mdwzsqKm9cM2nu98rw2dBkvoxyK14RCDb6QP+Y2WEmLJmpTnPuSh
	 zbhOiN1wCtYebjjPvHCPyBwyRs8S49HwwvYcq8nG5U5T4hOgnMIWSOH3savwOwqFDcogH
	 qqH4cuknFwTX6PywtW2cm5m8YUilU2wueteiHSLM8Fd7QPhX48RYZUZO8JkmFRG8KNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789384147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lZ8XFEkw2NMHiaXxnJhG2IaewQSVOuuYx7f9CSRCpL4=;
	b=IugFAoLIBVWNkj58foqnbad5OhkEW6BL7t3pZ35xHbBZpzxUc2G0QF5rCkiMkgff/seS
	 CMdyJ4BTxP3p/+fHYqjWmAvov9g6z93rIT4kTpQRIYZOojB4ZXmlThdg2H3cCzq2II72Y
	 cOMcfA86R1vwTFiPvh8ecuF8WDdn++5eeoRu5/ZqerrTQxwSIlQq/zlYmj154y05B4FSG
	 LpI8DkCKKRydhSTWQUo/pvMtb71nMn1Is8klBZSoiuNA1qy38ir630i0/VMI9j+qwayxb
	 rLnmgXnb7Nrv/Rdp8osGptA3X78bi8PDECiohQaelaos7gMaJOX8Qktnenrg6QMhJZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789384147;
	bh=lZ8XFEkw2NMHiaXxnJhG2IaewQSVOuuYx7f9CSRCpL4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rVqexVCPLGl1SE0t1ZhKUQHZCMyuJLh95/Er834tXkl5sX68pyYPay027AqhkZxNN
	 663BnDputvL8PYh3lTD1YokWExQhDaKXsEzsibUv4+rP2PqBfq2nzlk9jRNZxhaT6o
	 KpmwN/DlS49nlpeS4JRZUOme33lhcAY7Y0E3PkpBuJzpYCj+cF8TeTWs/+UU/w60Jh
	 qW6LdJnjnawep3NPrBYcXB6kGO/WxK9uUZozHyno5mMAMECgwovNSp0Y+E1M+2UP3G
	 9SGiWv+1EkK37llipUXvSUHQPbT5Nd+tyvNOUNREJc9/9Rr9HHMTEO8CMXLY8jDKrS
	 M1+74vHdNIP5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A274980CC4;
	Mon, 14 Sep 2026 11:09:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3C83224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C57EF60689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3x8CP8UCm9EU for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:09:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4A13C605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789384145;
 b=jN4XC6qLXgVyYxe3xBZf/pin2+gBgDP65cJIJFCVTUsUqtQjnCVEjJi0cJp2o0r6Fi/o
 u7SgprYagjQTifVI8rjh41S84GfZYHFhY76/KS4y2KxmKaLvWlOvnT5iEVBShq2jMquz0
 QK+euyMgN6cPXHrWGTbbXmE+/AIgIrEWTAkzUarlkkLXkZkkNOJduocVIGiDCQluHBM2p
 IvDOpvNEEtwLJMnq8mAWQQNprW1VZ1yNEtxK9o7oSAsnVjtkFFHI38f0KzeKaomDEtdZN
 8xYKSaSVlfxZQeElUrwlsZojf/HxxMqv4gRPSQYTGj3m4Fj9lA/+i2VhTlMQfD/9d2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384145;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=lZ8XFEkw2NMHiaXxnJhG2IaewQSVOuuYx7f9CSRCpL4=;
 b=jPbqAjZD/S9QUd8dz8ShijAnlpYjJZW18gWkRKh+ZNfoKmwojpoToPJXOugtB4DoPuEw
 X+ESAoKbzTtHPxwSwmlBau3YFZxu2gbE1EH1Cq1A789gVAI1XpdiyJotwY0DWBdD/6DF/
 Y8U6el/uL469I79Y5zyHvxM7Oy7+TKfjZrxhlJ0C0kbJ5kio3IyA6tazLj+IXVhRr3Fzr
 SGcaYok184D3ME7pYtSu9Yq0zuiLKkx0kWKQVJS0NnCkKbNnmwAzyv+UX1z77BP890NG1
 +9xFvAPDuziQxCcT9WegzlTfMpQeyPhZqxz1q5faEPQADc/HDbUonXrY6uAD84Q/cdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NfIvdJ6b;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NfIvdJ6b
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A13C605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh6x2plx8uZCkInWPAFDZidyetRK/fglxcVS0NRUKdx3Kc0KHKHAXHbd7ll9SBPLpqwrnh4jIItNhLazL5Gob58eETmkGJbXNoa9Rnmdk56EDe809kve4rtdW6TnZ7nzcFCMhwVVKDw6Zhb5JlnKv0wmayBE2lKoiI2x9WRPf/o1zRDdd2kh19oJepsgNJIPBZewpsQ4HMkFteENJyRHt64/nkb/WkzVaoTfePoNc1D88Gab4bS6isLBktIqw/wFqMbg/ptDC9xiCQr0WFtMTLYjVp8AkXfiMSHvKSWNdn+VrmRiW/j+kClK1xJBET40Cz5uuPM8C9RCcHndpbPwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ8XFEkw2NMHiaXxnJhG2IaewQSVOuuYx7f9CSRCpL4=;
 b=h7pJFL06JRoGqgpca8BJU7nEMsyU2R5QpbzWnmUG0PC8l6HrNgtbzX+bXOhf6JUlqS/kFu61HOxWlB03IPBk7ltCbALOulHa6YWJAj4Ql1KX+qv56jDwrkFXE5nQRae60CU6mpu/VUOFnZLLWhWbWtaJ0vo/34607Gpn29r0OavvPscPd7N/vRiG1/g35070YGvBgITV3QYDxhox7F0Bt4S/lgTQD4+FbX4P8fIcNipXwEegt3DDOGWPTs2JPzM6UNvO11m+iCI9YyoXaG9GEpdfupuurQ3ZGCKVlTeiVCa3OCdoufbJpO3g+aH0MZmIz965HrTqYshxdlblsrayKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ8XFEkw2NMHiaXxnJhG2IaewQSVOuuYx7f9CSRCpL4=;
 b=NfIvdJ6bcImXZiZBJFId5pfED+b7uGH02MVP4hIbFT13u3i+64oADzTNW1xAn3PRHUGgTosxB/vr3tvFzHkjQ/7ThUMcbWEcjeIWXCxvAysQ4X5Zy/jXHpYHhn/2e1NreSdmK1bABIvN4dqllNRzm7dXh027MVXBcAkqr+uu0h9pgiHjN0z/JCrm7RJAkHhwpH2r4zVaMH9XNzxqWwBVLDtA8aCUaZmfpGWMFLkClaPxBgBUQs22NoTq+VA9NKfzynbGnEigcRIdrud/E29gudikkWOTAu0H/GHS1xbcKfsfFMIZ3ttcLEFGEN5Oi8wNOf/KiXQVMbtTKZGhDYXpSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:92::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:08:57 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:08:57 +0000
Date: Mon, 14 Sep 2026 19:06:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [GIT PULL] Please pull fsl-qoriq-next-2026-09-14 for next
Message-ID: <aqfVPpJqQrdOiAOL@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0074.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: e16395f4-dea9-4c64-3c24-08df12509253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: /kUI+SJlXbzfJ1MpeA+KrLzqVFca3SJNpRs9D5EERmwhvzs+FHVKK1gpl7ViTeuzY6NvABtVsdS8EDbNPl3gd/j50G/sZbtq642RKBv9X4dzHRdHYi4QCyzFu3YVgypnaMFTQOJ1moDuCuBtw5ar5FMzUvU4QodDKkm54lsbjQ2yAmvfy44TdFv0MG7KAWl4c5udgfLXLfpvfpO17tLlm7x58WhexHEJjXeU8xZe4V9gPFpseh97xc/RbFB6gD1Xwd5DwG9ihdztABm8GCZnfl6HECXPYPn8MQfvthRgUl/hmD/rIZ0xfUWZrC21Q1sSBI4DpP81UvBtmJaOaEySuW/0nzFlUFggoJXYRY0Y5sG0zm+YoyuvxvSWMvYGtQZCcCmYaNc0kxdaO5mY1Lcf78xz7CMdTckPuUk37DdeCH8JcLBAlG+MdXJ3aahnWoG/zGhwUOYFrF8FtbHMOmUumHhDnKHydFf3OKfB+Np3nrNKxWQsJpNzP5saEqP2sVsG6hYI1794uoTphB1p2hActsdFgwobHDgel7SwEM2W1xzfRbyiWi5LWLfMlxb4BqLdX1SgTpsU9rHIGIBkBelpry0mfnB2rGsIpNhrUGjvDlVk5Q9SJDAlfc+2dVN369YiKARBt5vHeU9LBQinUEX6KXlH4S4unK4//zWw9fubH9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ynciheRyD3qvupqIoilhoDRi3Fqr8rgmxGR9ozwsDfdrRPxz+vzxg0vWQjJ?=
 =?us-ascii?Q?j9eldB4zdlu0eRG/V03xuwkiyjL4HYzIbzwGxFXrhXOFP21wHOvtO2b+FZmO?=
 =?us-ascii?Q?gXRwmxxLOm6t4Nj38mP1pbRX9jdCJDqQH+E3ETLh80KzpMdEi3czeDiPGqgm?=
 =?us-ascii?Q?e/XsIdcBxSsfJSoI8edxaULRw4iwY8ZWJWT5pzaMw255btzku86v5j3t1o7h?=
 =?us-ascii?Q?agZeyvoTU4cIaCmNM1z9ERNrGMbcUJemPwVF/mlby+a7gMguICS0vmwJgJdC?=
 =?us-ascii?Q?CtVaEFvgI6UlUL3Uwai5CZI/AyA7TGXlYxZBqZFsAz6MX0tXbkdzTtWp+6SM?=
 =?us-ascii?Q?cZvFrmFnPdvzWYoP/gKFo2pnx5ev6DQlAVjpqnE3FlHQFVfXZ94OvwQ0YiDE?=
 =?us-ascii?Q?BDI0VbKpN4Qmaa/mjHjZWoepaR5kL7jy6BhPhtA+fdxKiPgPUpYyBaAv7k7A?=
 =?us-ascii?Q?jKxaZ6FX3DpwlVMc7awLtxOp663P8zoCxSSR3zW4S27YhuM6WRGkURTcabKy?=
 =?us-ascii?Q?lvW+TyMB9WQqqhW0bGRiy1kMlkBwFRDWfzODqNf/sEiqAj9HciFGcC2CTOPD?=
 =?us-ascii?Q?jHl2GR8EtfH9rGYJvbYzF2taobCnqPlJgKocTCgmn6OdG77Ui50kp6ir4A8a?=
 =?us-ascii?Q?cWx8k+VDwtS7sNcgA6iSYTuwS+jlvAm5DX3Oe1AiUAea86Ps05CWY9TJObqd?=
 =?us-ascii?Q?dklubKK79wD45j4NR4befxs9mQDvn19n0fUs63kgj3ycZI5ORDHN4oI2QCut?=
 =?us-ascii?Q?y+4UAFrEaT4B0ahzpKH9NnY8OG5GmJIHiEHPkrJPS28VdB/U3fvLhlewpsv4?=
 =?us-ascii?Q?ej/roHmZv7fjGHh5hbLYQ3VVPxVDsWvWY7MN40qM5mNLDvwRoOwJmvPRxCTN?=
 =?us-ascii?Q?gSbL+S6876P0UGIW0Ucn3Yge7Hxox3/YqsJJNYx5dR7X2zoF9Q1ZDqFyCNHm?=
 =?us-ascii?Q?wvmbfqQLobtf/pMwPaWi8nYTljRkvRyKLAv80Or4jUe30LSJxraSEnQDqIqn?=
 =?us-ascii?Q?54nJswjO8wmRhjH4f2ypTgp8wPlEdhP29SWt7+9IPrY/hDvBavFdvTGbSjtJ?=
 =?us-ascii?Q?QeTKajmnAYfSYWeieoAZrVtKJ/F2LmAPOBr4UnBSC70i5tHCnbMsT0oIB3Qf?=
 =?us-ascii?Q?BWA1vN708wMvEaHRutTUBPjkBraNxnYuaDpKGNw4ldSdaHtsLUUBiieOIs0R?=
 =?us-ascii?Q?criCxt37ib0KPrdVaqDgUpoXAUiefgmhig3ohIgSlRa7Eb0Q76U1KgBNJw1Y?=
 =?us-ascii?Q?9e6DXz4JUbFu4W1WNV/pi8+VElidW1cVqZMyFsj2nyeWqJZ5h32gSwyfuhQv?=
 =?us-ascii?Q?DYxMBm4Z++hsAydESAmHDFEFwf1M2TM9yErekMnuBVSFvsJzvRcoxnfCy7fI?=
 =?us-ascii?Q?8XaJ8Oa72xiwjM3G9GQK98eQ6f61eIYERKaj53keXt8XcGL3OK3hwUvt3TAf?=
 =?us-ascii?Q?uv4SXCxZp9F/b9myCsF3KqZfLfWowyOvEKq3ELz3d8GVbExMapg+wGV1RaVU?=
 =?us-ascii?Q?U82xxHlKxldalie5P+oB5sybGtoeB9reggDkqQ0bflCTWhKhWITAs1ZU/tx2?=
 =?us-ascii?Q?6QDhJFJy54bTxyoUqHJV9xUCSuCxj8jpMMTW8zPinwy6Mminzk8xLwp1olG3?=
 =?us-ascii?Q?gbtpDuHvyqZhtlr7T0QhARSCB7z07HcMTwf6VsBy7hh9N2A+um/qmfXPiJsP?=
 =?us-ascii?Q?RPl7rKzlb8t5qCTmztPw9GOI65L+x7l4/7KfyTFmAKRBTigTF1MwNSzQY2TC?=
 =?us-ascii?Q?nGJp0rk2y8Ws8xpGB/EBQLLGM13QYmYcYCEawyK9URxUjnd1UKbA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16395f4-dea9-4c64-3c24-08df12509253
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:08:57.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyhrT16sumSNcxFahQ7EDUOUxcZQAVoWV2icT5lnT8X/XWjlVuj3y66y4lHxB13tXSCqYjy6zh8DJXAXnigglIkzzndtETGjlnXBtKBSP9q0JDe5EFDPgnjZwSAADAcc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209
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

Hi Tom,

Please pull fsl-qoriq-next-2026-09-14 for next

--------------------------------------------
Adds the Free Mobile Nodebox v3 CPU Module
Correct SCMI regulator Kconfig dependency
--------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1271

Thanks,
Peng

The following changes since commit ff22b8227d2531e3698ef1e2623805d0bfb20bbb:

  Merge patch series "fit: cipher: bounds checks on the ciphered image path" (2026-09-11 17:20:14 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2026-09-14

for you to fetch changes up to 90e4eaa6bf09051ac5d5857e85af6d174a4128cd:

  board: nbxv3: enable +3V3_FAN rail fixed regulator (2026-09-14 09:34:08 +0800)

----------------------------------------------------------------
Pengpeng Hou (1):
      power: regulator: require SCMI firmware for SCMI regulators

Vincent Jardin (9):
      lx2160: add lx2160_serdes split and management
      board: nxp: add Nodebox v3 CPU Module (LX2160A)
      doc: board: nxp: add the Nodebox v3 CPU Module
      board: nbxv3: add MPQ8785 PMBus core-rail readback
      board: nbxv3: add boot-time PMBus PSU traces
      board: nbxv3: add VID-fuse driven core voltage
      board: nbxv3: select carrier at boot
      board: nbxv3: add DPLL status (ZL30733, ZL30643)
      board: nbxv3: enable +3V3_FAN rail fixed regulator

 arch/arm/Kconfig                           |  12 +
 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi |  67 ++++
 arch/arm/dts/fsl-lx2160a-nbxv3.dts         |  16 +
 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi        | 342 +++++++++++++++++++
 board/nxp/lx2160a/Kconfig                  |  45 +++
 board/nxp/lx2160a/MAINTAINERS              |  11 +
 board/nxp/lx2160a/Makefile                 |   2 +
 board/nxp/lx2160a/eth_lx2160aqds.c         |   9 +
 board/nxp/lx2160a/nbxv3/Makefile           |  11 +
 board/nxp/lx2160a/nbxv3/carrier.c          |  64 ++++
 board/nxp/lx2160a/nbxv3/carrier.h          |  17 +
 board/nxp/lx2160a/nbxv3/dpll_zl30733.c     | 184 +++++++++++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c        |  63 ++++
 board/nxp/lx2160a/nbxv3/fan_power.c        |  33 ++
 board/nxp/lx2160a/nbxv3/mps_pmbus.c        |  99 ++++++
 board/nxp/lx2160a/nbxv3/psu_pmbus.c        |  72 ++++
 board/nxp/lx2160a/nbxv3/vid_handoff.c      | 144 ++++++++
 board/nxp/lx2160a/serdes_split.c           | 509 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/serdes_split.h           |  35 ++
 configs/nbxv3_tfa_defconfig                | 106 ++++++
 doc/board/nxp/index.rst                    |   1 +
 doc/board/nxp/nbxv3.rst                    | 212 ++++++++++++
 drivers/power/regulator/Kconfig            |   2 +-
 include/configs/nbxv3.h                    |  57 ++++
 25 files changed, 2113 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dtsi
 create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h
 create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c
 create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
 create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c
 create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/vid_handoff.c
 create mode 100644 board/nxp/lx2160a/serdes_split.c
 create mode 100644 board/nxp/lx2160a/serdes_split.h
 create mode 100644 configs/nbxv3_tfa_defconfig
 create mode 100644 doc/board/nxp/nbxv3.rst
 create mode 100644 include/configs/nbxv3.h
