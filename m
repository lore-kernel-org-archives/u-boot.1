Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64175606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cT9rFdM/;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tIXzEnXN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD5A94082E;
	Thu, 22 Oct 2026 07:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgH7oocrRDAo; Thu, 22 Oct 2026 07:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F60840820
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792654657;
	b=NNMmXxzv7+nq2oOx7cdR+Noochf4duun1uW+i/L4udFB6Fwpi4MshwU1gbLDWVabUp03
	 JIbH54fKwBtQOZplpnYO8P7I8JJi5HPXNgW+yf7k5aorDcj0Qj2/DTqLgJ1ep9QBxxf6a
	 9OlA7eRFGMM7lXFpXNaikT8DEfEqr5VlUf4p4GOhLq8GJF9Y7IOfTc79a8tF9gNcwo5va
	 jywt6T4dygtM6KeF6cxq0PI+0QCStWUceq9N26SEVdRxEsugl1NoKFvT2QLhJSrVUuBvC
	 p9elEHNo1XuWDNRp/6vFk7ehqB5R0kg9alxah3CdKsyfSo6QhRg8JuMc1xIiAwfTdLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654657;
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
	bh=llirR8NJ2WCHvj9H3QDZfHb1DBhH8pydba0hpTesZVA=;
	b=jbUtHK4A/Tf4PF0/1sbbnUMIpJjWDbRgeFyxTEP4q8CU9poYezuRCkFue9F2t/ed9xTZ
	 QlooIHuKNlO13rdnRu0gy5WO96XV7gCqwGrD9IqErMZTRNb5X6Do0bbtqfrAoSc2c3Rd4
	 W2V5vSPoMau1vHvDYoRVOPMF8r6cCgWy/UMzDtoLbUAH5rR1APYzkChnWf2/D4F1uZjTG
	 l72BsZsBZbCvHsbkf3HYHMKlFyVmiLacOPgjodMoNHQMZr04XYOj9TANzqcLmW/RTXDtW
	 zzst5jAGYlC6+9X98G+/MOe+pUnhyO4Fjwp4iHhgigd/VYedxdHjXiHQGED3x+ru+Zw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654657;
	bh=llirR8NJ2WCHvj9H3QDZfHb1DBhH8pydba0hpTesZVA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cT9rFdM/X0dvVT6EtlnQYenPPfYnjnL9lascmrJxB9Ebd3Tw/FbEftJkz/vVy0yvc
	 FX/ygOp8X60ODPqrM6/0ZAG5pJRxReEymXicG1YbHF+pFh2VbvomJM5RmxrI0nXmZX
	 NOQlTlq1lodnToB+wpGXr/q2p/k9IHhwGDJCl4toGsA60wZkpq9zSA5kkMdoLmZGw/
	 +2RCY6yUdVu7QxFSaJG51W1XgRfurudLooehbL6KCwVKsGRSroA0IBkjHTtq2cn+oo
	 dyqjvVVBBK8tBPqkuNhs0i0RbLqpHlJauAwsnugxnvICh4wXDhZKEeo9jmW7nRTbH0
	 xFe2e1BmHiG9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F60840820;
	Thu, 22 Oct 2026 07:37:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E379A3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0F4260818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfQOxtIiJqq2 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7EBC607F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654654;
 b=OEZfaa0QsY/jx33tGY5dNxvKrY/M7DLKT88IY6wVXqvfJkcWxmRt9SX6VdZLk/aePU/w
 MSgE2N1c10fDCfz/G8cIBlTwMNixFUErsYYQz3AQzC/PVmwVxHlZd/eDpcLsyUQiS9JIH
 PXXpXW0YKaKxQJ9m3pHPr0CJK/j+kAkwzpNE9IuPKr25KhvqDK2yPJ7aodDmVA/H0LsTA
 JDwGfM1Wu7wSxe6VgWbEWlT8TGugF7MPdQQ/Yp45WDNQ4Z2upOSGsgym9i96DtWNJX99K
 0HfNrq4nmxLhTWcsyei/yUquwJSLaYhSCovEZAV5LsBruX/Wi0RDmorbjlpv50PBykA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792654654;
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
 bh=llirR8NJ2WCHvj9H3QDZfHb1DBhH8pydba0hpTesZVA=;
 b=kgZgaHrjK/UViPmygoIU0AD8OYRQa/waN1lwihGUG5Bj5Oi4PZvsSvh+ol3SI8dmDXxa
 oJx4HLLFSQRv+fmkJmOnjxjyim0Zn0YvvyhG7pGFG5E719qpwfFB6NVxroEQnJuPbGnYg
 sd4ur4H7qaosaY/fmooTifN2xtefRgJsSwk472dLo3oOdH9CGOXTopU890fjhh6q4FP04
 EVZtXIdB69Qer/2wsMZMFOJBXpCMeXn0PXfOYJ4wvM9xZxMaUTVcra7lKAvHQkxnWgaj8
 kY+/tzTL4JwQJPHZWcPLoskssVmAwByT8r6Fpkxu5i59H1TXYh3x5T3IoTVjx1Batwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tIXzEnXN;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tIXzEnXN
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7EBC607F6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiotckyOcT6IvL4CJghMuFPyf4CnmlhZxbE378CTfRT3C0DIo/jylU57c5gt4Hcoju+MQP35ey9hYa3eAEHDZIP0k8dkMpDPWYJMmdAsDkLUOcEhd+RYAFCHechCk388SCpSvMGcJAWT2GCmIHqiVwQiyaVrDQSQVn0K6kmZh8bneL8A/u037GkneRe6Rk3KG/K8aeKM23PjENCFhcA06ConKTDOd4O2DpM7aMxp0JZ/J2dBedB1D8kPT7ZBrD6SO9IYmlzG9eXp/5PnJMIvb8NzcGak19OMYkBpbPge/3jNhy8MsAUmuxQg+dMO9HWuEK57KUyJPKMaW9t0FrKzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llirR8NJ2WCHvj9H3QDZfHb1DBhH8pydba0hpTesZVA=;
 b=H4ov522fhgtS6vpDbrV7pMqKtc4dqCapeKMczEUFnLUac9MjkaZ34V6wq6bc16pd413UTJAgFQqok6ISyKIZPzf7//B66bWaxT9nSWEL38h3Ap9o1owt2qqNpAE1JusZYEarO4Jdgp09KSAcM9T0V2uNHI3X9YZOp0XcXkv5OhJFwoDnGzacKRwbU+IuDMzsN72GS5PiYAUyVZU+4xEIFFRdj2igF8Uu3HsTrFUy1/D+ibYbTXtIPdjoWUVf+wu+zo9JEe2IRvFqcYZP184/xDjrnXdKwQrlqm+5OJKQ89ExxMwwprzx5zTIgPDDVh0StCl3jx0dmraUd/YiR83DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llirR8NJ2WCHvj9H3QDZfHb1DBhH8pydba0hpTesZVA=;
 b=tIXzEnXN35sktQID/xo466ATqH9ucM/i0pL7y3mY0CiciFybWdpFvV0YZHGcYs8uwSsarmsAoavQBwILqXDXEJDlyvI0sHWOYYI+jdE2Ubn2zJ36SLNGRFCtA7e4HMli3xd+kastGOkLnnJgNGiTR+Igoz2fC6sIN2oGC5gNFGiY7lda7fibzutk6XOBEeq+LNof98r6+7jACSbj9YIDxETHQBOhRoUGNuf2fxp+eIMPRGSnyxg1CPa/nTuFx+/nIySX9neDX7EM0szs3ySWOwjkbL9+pTpGh827+REJ6Ktm/zbDTwIQkJ0/c1qOafT8ud7ExKKeykKeTtLgVO50xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:37:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:37:25 +0000
Date: Thu, 22 Oct 2026 15:34:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <brads@mainlining.org>,
 Vincent Jardin <vjardin@free.fr>, Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: 0795ef4e-7b6e-4957-1562-08df300f50e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|261021123027099003|11063799006|56012099006|261009223027099003|261009221227099003|10067099003|6133799003|18002099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: 2JlgRade9BX+6B47iJPpWXxOwXAKW0965rarIqhPgH+4QuVYIurw+APEebeBJBXbOfwtpC/CuD3/T1hJSfi77b5ZopsbCKyZy1T99JMYXe0+Y9vjj+3Vkes1uRLCPsZUyFMxiQqtK+q6BzKcD2bNe9k6xLzdbqIXYAGMDRXSOWTXqpJCWbT35B7r3TbJnhzBSVDHIWIyNUmN6W6oQtKmOjQEf5oY3WRX5xrcBjWC4ezpDzhgdi18TNtxEdRIFx2/RamwG9+bkRLFQKG5BiqtjRgx0XQbhp1nA1S353PpxPpjdI1Vsxlu7c3xVn7Wc1cwVPPEtiW3qpGs7JjI+w5DinQrqM8/XsLppiPYzYCil33wjnZppQ2zG2vOnNq+zNLql3DVDtqffKzd2GMRR3JaPAg3IRDzpPtGDJOfYOW6BxNekCnK3TVFeb0DtULdpKxYv6e1IGq2OMtR1+4E6WcylK91qpjBRcTyneglnYmQo7kVxavBWzOMgihXdTEYVFSzZNlRSUt+YSJz1EXbH7A0DUoT40pTbjvB0ctfnCLy7xjOwhXreYReSOAy3nJIGLcKo1I9Q2rHXSKVWw9hC0jLzTVHY6xGoJRCty4XUpGmICFcMXe+hZxKPZJ65CyWUk/ZlA2bqn3WFXr4XZa7fFJtIZOSWt8f2MOwAsxAmpn8YXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(10067099003)(6133799003)(18002099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yY0eMV6JT5f/2d6+k4sEkeaNqZvu3f1b+ZWWybF1XASQ8ZqxtoaRouiJz7UZ?=
 =?us-ascii?Q?koQVJQ+5cseGu8ZIA6R3qXODA/hUDZ9sEX5H+v7FRe9bN2IJXJGN8JYOfeBO?=
 =?us-ascii?Q?ucgAwah1wgtytdmNAKqT2IzC8XkEJruNXyf7gitKWJRtj8PjvCO6tYcuedoV?=
 =?us-ascii?Q?zV8cDq9D9YMCt5jFsoQH7Fd8kW/iaTAa5Ppd8em1lX4MHQMZmLLuQOkU97/d?=
 =?us-ascii?Q?ifsnnTs6JGBeXWqrmwaHo3u9GA0AMxoxW5WHoM0olasCpv00eHsnlhTVqsDt?=
 =?us-ascii?Q?K18oXTJajgv4DA+u0dF5++nsV/mRh1dHWilucCBLpo2u9KERZVASsA8wqQI1?=
 =?us-ascii?Q?3D1V/K/p0qnjZP7cQ+BtSbrbHXz8jVjxBvS2onDzUBwO+VYZIhgbgNT/vNLg?=
 =?us-ascii?Q?vOd/ry6uNM4boMyGkdoO919ZEprWsTwY/5QmMUMAyJ0CJ96n8QtT9JlCXytD?=
 =?us-ascii?Q?bPbaBNRHE5VpSOiDDlmhdmb3FyAUQ3zkvBej+9W4mWgN4CLU2V9IJoDeLXii?=
 =?us-ascii?Q?l0Ama8GpdJtBihljM8HMAKi4+o7llBg1yP7XDasuLwut2R+RmCtwnhrRAy4n?=
 =?us-ascii?Q?Dk3s7JngKo21qhdzdBlAu3Hr3XrQTRc4VxWrww4oqXPElLWoDklDvAhXtdwL?=
 =?us-ascii?Q?E5WBuo7mKP1QV+u8qSA79oOBgLJf6dDzQx3KEGLC4IqM6G+8Q5MfeGVHdavX?=
 =?us-ascii?Q?IodfjKodfTZtkRKSOPkI1TxbYI5hETdH37nXOvJ6nsRHaviQN8YHr9nE/S8F?=
 =?us-ascii?Q?+LiRMsBn9IgqmI7LKG652LApsShyL8I6cgmBVYmWDa5TQ8WvXhfaqnGiYQcA?=
 =?us-ascii?Q?P9yTzxNAWf5PAUxisgPUuqUxLPWXTDjv3orQ69S9QiNUCKHboxOtsY5HKzgx?=
 =?us-ascii?Q?kUtK5ir4680T+eCrfSJXz64KPvY7VsdMGvrtYHALv9AB34sb8hIIYT1hKFzq?=
 =?us-ascii?Q?T6ZxoJoIYEfA4w7k/qkiGAQICrJ4iBviJl7QeQaIQR2GbtJ210SjZkR/KZNu?=
 =?us-ascii?Q?L/YwSN9CqN0PQaiknL+CJdfubUU1Zut2yCJ/Pf+MyvJ+vZGfHAMt9sBYnzzf?=
 =?us-ascii?Q?2sTjmwOts45jgQCz918z0Eo+jsJ7EF4059RA/BBPbj1tB3h7bRzY7/NywrAW?=
 =?us-ascii?Q?5K6QGBLcP/HD5l3i8p/n9gf69MmSYGz3G9ZjBX6IN8Z9LBaN31zwXayXGMQ5?=
 =?us-ascii?Q?lG/b3/ChqPgCG3y2Mfwd9f5Tzs2EdvarjsM+4ue3lDmXaebbzwFcpniI8hN3?=
 =?us-ascii?Q?g6uMXeis9nvmPkV8go/O8ICSEbudMKrqUwNa3qL949PFonDPN1EpmuYn0v5U?=
 =?us-ascii?Q?pYHOSgKvyyskR0w8gEV5GwXVlLjKZNQlVs2zi1+63yUILfeDyWeo37AGFEtz?=
 =?us-ascii?Q?UXssDq/85biZAkU3CpUcwEYC+MY4+hm2gTkxAUaE1v9uUCX1exmH8xQUyqLd?=
 =?us-ascii?Q?NHObahIRIv7ryAT0nGPEzcmGPBlFEX/jkxCLFSv//6mvQre4RoiO0Y/iuabH?=
 =?us-ascii?Q?b+L/DlJ0RcLHN+VK1ED1nPD+ZS34OZ5gI0qRt+dIkDWny4D7whvfhE+Wdvq2?=
 =?us-ascii?Q?pSEBRd/wvK2o4bUdZ5dwDoOJ3YnSzP8xbDyK/JLCMolWvOpzPbMVaMpFvhEg?=
 =?us-ascii?Q?c2BVThhjJ6FUnSfAZLTk/zhFtu21mZOHz4CZGLb1MCAFCoVEHPRaI0y7/IQn?=
 =?us-ascii?Q?DzEHsSLp4yZfTc7VZCsRSrFEA9a/uzJt0FOHPnKv5P/HF+7069tvXiWWGx7f?=
 =?us-ascii?Q?d+Ye53IN9Be9jNS50LHsFmPP1pDI/q2O/v5Q49+CbQaDwYQb4FLZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0795ef4e-7b6e-4957-1562-08df300f50e3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:37:25.1855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc+gaxLYKeYEid22IAFGsvLlv/6KxoRQSPY0mi3MDoL4k7iz1M6b2vYgYf+V6Ti4nTBKNa6B0bk34xhLV2aIPNPbYAnx4holuk051O2HaNtDw0zU1GuQR+xvu6SxvwJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull fsl-qoriq-for-2027-01-rc1

---------------------------------------------------
Drop various legacy powerpc support from Bradley
Make BASE_DISCOVER_AGENT it optional following spec
Various update for lx2160a serdes from Vincent
Check LSB_FIRST for fsl_espi
---------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1672

Thanks
Peng

The following changes since commit e36b675ebc4c41f1f4187c46d363d581c371d538:

  Merge patch series "rsa: fix rsa_gen_key_prop() buffer-sizing and zero-modulus handling" (2026-10-19 16:52:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2027-01-rc1

for you to fetch changes up to 20adeef914d05628583138733449596f17450b3d:

  MAINTAINERS: powerpc: Add me as PowerPC maintainer (2026-10-22 07:32:56 +0800)

----------------------------------------------------------------
Bradley Morgan (26):
      board: powerpc: Remove MPC8548CDS support
      board: powerpc: Remove MPC837XERDB support
      board: powerpc: Remove P2020RDB-PC support
      board: powerpc: Remove P3041DS support
      board: powerpc: Remove P4080DS support
      board: powerpc: Remove P5040DS support
      board: powerpc: Remove T1042D4RDB support
      powerpc: mpc85xx: Remove P3041 support
      powerpc: mpc85xx: Remove P4080 support
      powerpc: mpc85xx: Remove P5040 support
      powerpc: mpc83xx: Remove MPC837x support
      powerpc: mpc85xx: Remove C29x support
      powerpc: mpc85xx: Remove P1011 support
      powerpc: mpc85xx: Remove P1023 support
      powerpc: mpc85xx: Remove P1025 support
      powerpc: mpc85xx: Remove MPC8536 support
      powerpc: mpc85xx: Remove MPC8540 support
      powerpc: mpc85xx: Remove MPC8560 support
      powerpc: mpc85xx: Remove BSC9132 support
      powerpc: mpc83xx: Remove MPC831x support
      powerpc: mpc83xx: Remove MPC834x support
      powerpc: mpc85xx: Remove P1024 support
      powerpc: mpc85xx: Remove BSC9131 support
      powerpc: mpc83xx: Remove MPC8309 support
      powerpc: Remove MPC86xx support
      MAINTAINERS: powerpc: Add me as PowerPC maintainer

Bryan Brattlof (1):
      firmware: scmi: check if BASE_DISCOVER_AGENT is implemented

Tomas Alvarez Vanoli (1):
      spi: fsl_espi: check user's LSB_FIRST

Vincent Jardin (18):
      power: regulator: pmbus: check the device in the exported helpers
      power: regulator: pmbus: read back the VOUT_COMMAND setpoint
      test: dm: pmbus: test pmbus_regulator_read_vout_command()
      board: nbxv3: VID handoff writes table value, no droop compensation
      armv8: fsl-layerscape: icid: also find DWC3 nodes as fsl, ls1028a-dwc3
      board: lx2160a: serdes: drop the split subcommand
      board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
      board: lx2160a: serdes: rename SPLIT_POLL_US to SRDS_POLL_US
      board: lx2160a: serdes: move the SD1 halt and reset into helpers
      board: lx2160a: serdes: set SD1 with a table
      board: lx2160a: serdes: report unknown SD1 cases
      board: lx2160a: serdes: no SD1 config once MC runs
      board: lx2160a: serdes: add serdes1:2x40g
      board: lx2160a: serdes: enter a SD1 mode through the mode it starts from
      board: lx2160a: serdes: add serdes1:40g4x10g
      board: lx2160a: serdes: add serdes1:100g4x10g
      doc: lx2160a: document the sd1 hwconfig option
      board: nbxv3: apply sd1 hwconfig before MC starts

 MAINTAINERS                                        |   3 +-
 README                                             |   2 +-
 api/api_platform-powerpc.c                         |   2 +-
 arch/Kconfig                                       |   7 +-
 arch/Kconfig.nxp                                   |   9 +-
 arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
 arch/arm/cpu/armv8/fsl-layerscape/icid.c           |  18 +-
 arch/powerpc/cpu/Makefile                          |   1 -
 arch/powerpc/cpu/mpc83xx/Kconfig                   |  44 --
 arch/powerpc/cpu/mpc83xx/cpu.c                     |  17 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c                |  24 -
 arch/powerpc/cpu/mpc83xx/fdt.c                     |  47 +-
 arch/powerpc/cpu/mpc83xx/hid/Kconfig               |   4 +-
 arch/powerpc/cpu/mpc83xx/hid/hid.h                 |   5 -
 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig              |  82 +--
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr      |   6 +-
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr      |   2 +-
 arch/powerpc/cpu/mpc83xx/pci.c                     |   2 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c               |   4 +-
 arch/powerpc/cpu/mpc83xx/speed.c                   | 112 +---
 arch/powerpc/cpu/mpc83xx/traps.c                   |   1 -
 arch/powerpc/cpu/mpc85xx/Kconfig                   | 443 +-------------
 arch/powerpc/cpu/mpc85xx/Makefile                  |  14 -
 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c          | 101 ----
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c             |  70 ---
 arch/powerpc/cpu/mpc85xx/cmd_errata.c              |  43 +-
 arch/powerpc/cpu/mpc85xx/cpu.c                     |  17 -
 arch/powerpc/cpu/mpc85xx/cpu_init.c                |  49 +-
 arch/powerpc/cpu/mpc85xx/fdt.c                     |  28 +-
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c      | 665 ---------------------
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h      |   4 -
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c          | 250 --------
 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c          |  57 --
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c            |  59 --
 arch/powerpc/cpu/mpc85xx/p3041_ids.c               | 112 ----
 arch/powerpc/cpu/mpc85xx/p3041_serdes.c            | 133 -----
 arch/powerpc/cpu/mpc85xx/p4080_ids.c               | 112 ----
 arch/powerpc/cpu/mpc85xx/p4080_serdes.c            |  80 ---
 arch/powerpc/cpu/mpc85xx/p5040_ids.c               | 111 ----
 arch/powerpc/cpu/mpc85xx/p5040_serdes.c            |  99 ---
 arch/powerpc/cpu/mpc85xx/release.S                 |  23 +-
 arch/powerpc/cpu/mpc85xx/speed.c                   |   6 +-
 arch/powerpc/cpu/mpc8xxx/Makefile                  |   1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c                     |  23 +-
 arch/powerpc/cpu/mpc8xxx/fdt.c                     |   8 +-
 arch/powerpc/cpu/mpc8xxx/srio.c                    |   6 -
 arch/powerpc/dts/Makefile                          |   7 -
 arch/powerpc/dts/mpc8379erdb.dts                   | 153 -----
 arch/powerpc/dts/mpc8548-post.dtsi                 |  36 --
 arch/powerpc/dts/mpc8548.dtsi                      |  27 -
 arch/powerpc/dts/mpc8548cds.dts                    |  29 -
 arch/powerpc/dts/mpc8548cds_36b.dts                |  29 -
 arch/powerpc/dts/p2020rdb-pc.dts                   |  59 --
 arch/powerpc/dts/p2020rdb-pc.dtsi                  |  50 --
 arch/powerpc/dts/p2020rdb-pc_36b.dts               |  59 --
 arch/powerpc/dts/p3041.dtsi                        | 149 -----
 arch/powerpc/dts/p3041ds.dts                       | 158 -----
 arch/powerpc/dts/p3041si-post.dtsi                 |  43 --
 arch/powerpc/dts/p4080.dtsi                        | 148 -----
 arch/powerpc/dts/p4080ds.dts                       | 220 -------
 arch/powerpc/dts/p4080si-post.dtsi                 |  62 --
 arch/powerpc/dts/p5040.dtsi                        | 137 -----
 arch/powerpc/dts/p5040ds.dts                       | 281 ---------
 arch/powerpc/dts/p5040si-post.dtsi                 |  70 ---
 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi            |  12 -
 arch/powerpc/dts/t1042d4rdb.dts                    |  89 ---
 arch/powerpc/dts/t104x.dtsi                        | 148 -----
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h       |   4 +-
 arch/powerpc/include/asm/arch-mpc83xx/soc.h        |  37 +-
 arch/powerpc/include/asm/config.h                  |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h          |  56 +-
 arch/powerpc/include/asm/fsl_law.h                 |   8 -
 arch/powerpc/include/asm/fsl_lbc.h                 |  15 +-
 arch/powerpc/include/asm/fsl_pci.h                 |   7 -
 arch/powerpc/include/asm/fsl_secure_boot.h         |   1 -
 arch/powerpc/include/asm/fsl_serdes.h              |   3 -
 arch/powerpc/include/asm/global_data.h             |  19 +-
 arch/powerpc/include/asm/immap_83xx.h              | 123 +---
 arch/powerpc/include/asm/immap_85xx.h              | 253 +-------
 arch/powerpc/include/asm/mpc8349_pci.h             | 165 -----
 arch/powerpc/include/asm/mpc8xxx_spi.h             |   5 +-
 arch/powerpc/include/asm/ppc.h                     |  14 +-
 arch/powerpc/include/asm/processor.h               |  36 +-
 arch/powerpc/lib/bdinfo.c                          |   2 +-
 arch/powerpc/lib/bootm.c                           |   7 -
 arch/powerpc/lib/ppccache.S                        |   4 +-
 arch/powerpc/lib/stack.c                           |   2 +-
 board/nxp/common/Makefile                          |  11 -
 board/nxp/common/cds_pci_ft.c                      |  17 -
 board/nxp/common/cds_via.c                         |  95 ---
 board/nxp/common/ics307_clk.c                      | 149 -----
 board/nxp/common/ics307_clk.h                      |  14 -
 board/nxp/common/ngpixis.c                         | 247 --------
 board/nxp/common/ngpixis.h                         |  60 --
 board/nxp/common/sdhc_boot.c                       |   2 +-
 board/nxp/lx2160a/eth_lx2160aqds.c                 |   4 +-
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c                |   3 +
 board/nxp/lx2160a/nbxv3/vid_handoff.c              |  77 +--
 board/nxp/lx2160a/serdes_split.c                   | 532 ++++++++++++++---
 board/nxp/lx2160a/serdes_split.h                   |  16 +-
 board/nxp/mpc837xerdb/Kconfig                      |  15 -
 board/nxp/mpc837xerdb/MAINTAINERS                  |   6 -
 board/nxp/mpc837xerdb/Makefile                     |   6 -
 board/nxp/mpc837xerdb/README                       |  97 ---
 board/nxp/mpc837xerdb/mpc837xerdb.c                | 242 --------
 board/nxp/mpc8548cds/Kconfig                       |  24 -
 board/nxp/mpc8548cds/MAINTAINERS                   |   8 -
 board/nxp/mpc8548cds/Makefile                      |  10 -
 board/nxp/mpc8548cds/ddr.c                         |  51 --
 board/nxp/mpc8548cds/law.c                         |  18 -
 board/nxp/mpc8548cds/mpc8548cds.c                  | 170 ------
 board/nxp/mpc8548cds/tlb.c                         |  87 ---
 board/nxp/p1_p2_rdb_pc/Kconfig                     |   3 +-
 board/nxp/p1_p2_rdb_pc/MAINTAINERS                 |   8 -
 board/nxp/p1_p2_rdb_pc/README                      |   7 +-
 board/nxp/p1_p2_rdb_pc/ddr.c                       |  68 ---
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c              |   2 -
 board/nxp/t104xrdb/Kconfig                         |  12 -
 board/nxp/t104xrdb/MAINTAINERS                     |  13 -
 board/nxp/t104xrdb/Makefile                        |  13 -
 board/nxp/t104xrdb/README                          | 386 ------------
 board/nxp/t104xrdb/cpld.c                          | 116 ----
 board/nxp/t104xrdb/cpld.h                          |  45 --
 board/nxp/t104xrdb/ddr.c                           | 148 -----
 board/nxp/t104xrdb/ddr.h                           |  56 --
 board/nxp/t104xrdb/law.c                           |  31 -
 board/nxp/t104xrdb/spl.c                           | 131 ----
 board/nxp/t104xrdb/t1040_nand_rcw.cfg              |   7 -
 board/nxp/t104xrdb/t1040_sd_rcw.cfg                |   7 -
 board/nxp/t104xrdb/t1040_spi_rcw.cfg               |   7 -
 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg            |   7 -
 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg              |   7 -
 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg             |   7 -
 board/nxp/t104xrdb/t1042_nand_rcw.cfg              |   7 -
 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg           |   7 -
 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg             |   7 -
 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg            |   7 -
 board/nxp/t104xrdb/t1042_sd_rcw.cfg                |   7 -
 board/nxp/t104xrdb/t1042_spi_rcw.cfg               |   7 -
 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg            |   7 -
 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg              |   7 -
 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg             |   7 -
 board/nxp/t104xrdb/t104x_pbi.cfg                   |  36 --
 board/nxp/t104xrdb/t104x_pbi_sb.cfg                |  38 --
 board/nxp/t104xrdb/t104xrdb.c                      | 159 -----
 board/nxp/t104xrdb/t104xrdb.h                      |  11 -
 board/nxp/t104xrdb/tlb.c                           | 132 ----
 boot/Kconfig                                       |   4 +-
 common/board_r.c                                   |   2 +-
 configs/MPC837XERDB_defconfig                      | 193 ------
 configs/MPC8548CDS_36BIT_defconfig                 | 108 ----
 configs/MPC8548CDS_defconfig                       | 106 ----
 configs/MPC8548CDS_legacy_defconfig                | 106 ----
 configs/P2020RDB-PC_36BIT_NAND_defconfig           | 164 -----
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig         | 145 -----
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig       | 147 -----
 configs/P2020RDB-PC_36BIT_defconfig                | 125 ----
 configs/P2020RDB-PC_NAND_defconfig                 | 162 -----
 configs/P2020RDB-PC_SDCARD_defconfig               | 142 -----
 configs/P2020RDB-PC_SPIFLASH_defconfig             | 145 -----
 configs/P2020RDB-PC_defconfig                      | 123 ----
 configs/T1042D4RDB_NAND_defconfig                  | 144 -----
 configs/T1042D4RDB_SDCARD_defconfig                | 138 -----
 configs/T1042D4RDB_SPIFLASH_defconfig              | 141 -----
 configs/T1042D4RDB_defconfig                       | 114 ----
 doc/README.fsl-hwconfig                            |  70 +++
 doc/README.mpc83xxads                              |  97 ---
 doc/README.mpc85xx-sd-spi-boot                     |   8 -
 doc/README.mpc85xxcds                              | 225 -------
 doc/README.pblimage                                |   6 +-
 doc/README.sata                                    |  68 ---
 doc/README.srio-pcie-boot-corenet                  | 118 ----
 doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt |   7 +-
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt       |  13 +-
 .../gpio/fsl,mpc83xx-spisel-boot.txt               |   4 +-
 drivers/clk/mpc83xx_clk.c                          |  19 +-
 drivers/clk/mpc83xx_clk.h                          |  30 +-
 drivers/cpu/mpc83xx_cpu.c                          |  62 +-
 drivers/cpu/mpc83xx_cpu.h                          |  44 --
 drivers/crypto/fsl/jr.c                            |  14 +-
 drivers/ddr/fsl/Kconfig                            |   8 +-
 drivers/ddr/fsl/ctrl_regs.c                        |   1 -
 drivers/dma/fsl_dma.c                              |   4 -
 drivers/firmware/scmi/base.c                       |   5 +
 drivers/gpio/mpc83xx_spisel_boot.c                 |   1 -
 drivers/gpio/mpc8xxx_gpio.c                        |   1 -
 drivers/mmc/Kconfig                                |   3 +-
 drivers/net/Kconfig                                |   4 -
 drivers/net/fm/Makefile                            |   6 +-
 drivers/net/fm/fm.h                                |   4 -
 drivers/net/fm/p1023.c                             |  72 ---
 drivers/net/fm/p4080.c                             |  98 ---
 drivers/net/fm/p5040.c                             | 106 ----
 drivers/pci/Kconfig                                |   2 +-
 drivers/pci/pci_auto.c                             |  14 -
 drivers/pci/pcie_fsl.c                             |  23 -
 drivers/power/regulator/pmbus_helper.c             |  64 +-
 drivers/qe/Kconfig                                 |   3 +-
 drivers/qe/qe.c                                    |   1 -
 drivers/ram/mpc83xx_sdram.c                        |  14 +-
 drivers/spi/fsl_espi.c                             |   7 +-
 drivers/usb/common/fsl-errata.c                    |  15 -
 drivers/usb/host/Kconfig                           |   2 +-
 env/Kconfig                                        |   3 +-
 include/asm-generic/u-boot.h                       |   2 +-
 include/configs/MPC837XERDB.h                      | 218 -------
 include/configs/MPC8548CDS.h                       | 312 ----------
 include/configs/T104xRDB.h                         | 397 ------------
 include/configs/p1_p2_rdb_pc.h                     |  21 -
 include/dt-bindings/clk/mpc83xx-clk.h              |   1 -
 include/fsl_immap.h                                |   2 +-
 include/fsl_sec.h                                  |   3 -
 include/mpc83xx.h                                  | 319 +---------
 include/pci_ids.h                                  |   4 -
 include/pmbus.h                                    |  14 +
 include/serial.h                                   |   1 -
 test/dm/pmbus.c                                    |  41 ++
 217 files changed, 860 insertions(+), 13052 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/c29x_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_serdes.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_serdes.c
 delete mode 100644 arch/powerpc/dts/mpc8379erdb.dts
 delete mode 100644 arch/powerpc/dts/mpc8548-post.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548cds.dts
 delete mode 100644 arch/powerpc/dts/mpc8548cds_36b.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dtsi
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc_36b.dts
 delete mode 100644 arch/powerpc/dts/p3041.dtsi
 delete mode 100644 arch/powerpc/dts/p3041ds.dts
 delete mode 100644 arch/powerpc/dts/p3041si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p4080.dtsi
 delete mode 100644 arch/powerpc/dts/p4080ds.dts
 delete mode 100644 arch/powerpc/dts/p4080si-post.dtsi
 delete mode 100644 arch/powerpc/dts/p5040.dtsi
 delete mode 100644 arch/powerpc/dts/p5040ds.dts
 delete mode 100644 arch/powerpc/dts/p5040si-post.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/t1042d4rdb.dts
 delete mode 100644 arch/powerpc/dts/t104x.dtsi
 delete mode 100644 arch/powerpc/include/asm/mpc8349_pci.h
 delete mode 100644 board/nxp/common/cds_pci_ft.c
 delete mode 100644 board/nxp/common/cds_via.c
 delete mode 100644 board/nxp/common/ics307_clk.c
 delete mode 100644 board/nxp/common/ics307_clk.h
 delete mode 100644 board/nxp/common/ngpixis.c
 delete mode 100644 board/nxp/common/ngpixis.h
 delete mode 100644 board/nxp/mpc837xerdb/Kconfig
 delete mode 100644 board/nxp/mpc837xerdb/MAINTAINERS
 delete mode 100644 board/nxp/mpc837xerdb/Makefile
 delete mode 100644 board/nxp/mpc837xerdb/README
 delete mode 100644 board/nxp/mpc837xerdb/mpc837xerdb.c
 delete mode 100644 board/nxp/mpc8548cds/Kconfig
 delete mode 100644 board/nxp/mpc8548cds/MAINTAINERS
 delete mode 100644 board/nxp/mpc8548cds/Makefile
 delete mode 100644 board/nxp/mpc8548cds/ddr.c
 delete mode 100644 board/nxp/mpc8548cds/law.c
 delete mode 100644 board/nxp/mpc8548cds/mpc8548cds.c
 delete mode 100644 board/nxp/mpc8548cds/tlb.c
 delete mode 100644 board/nxp/t104xrdb/Kconfig
 delete mode 100644 board/nxp/t104xrdb/MAINTAINERS
 delete mode 100644 board/nxp/t104xrdb/Makefile
 delete mode 100644 board/nxp/t104xrdb/README
 delete mode 100644 board/nxp/t104xrdb/cpld.c
 delete mode 100644 board/nxp/t104xrdb/cpld.h
 delete mode 100644 board/nxp/t104xrdb/ddr.c
 delete mode 100644 board/nxp/t104xrdb/ddr.h
 delete mode 100644 board/nxp/t104xrdb/law.c
 delete mode 100644 board/nxp/t104xrdb/spl.c
 delete mode 100644 board/nxp/t104xrdb/t1040_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi.cfg
 delete mode 100644 board/nxp/t104xrdb/t104x_pbi_sb.cfg
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.c
 delete mode 100644 board/nxp/t104xrdb/t104xrdb.h
 delete mode 100644 board/nxp/t104xrdb/tlb.c
 delete mode 100644 configs/MPC837XERDB_defconfig
 delete mode 100644 configs/MPC8548CDS_36BIT_defconfig
 delete mode 100644 configs/MPC8548CDS_defconfig
 delete mode 100644 configs/MPC8548CDS_legacy_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_defconfig
 delete mode 100644 configs/P2020RDB-PC_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_defconfig
 delete mode 100644 configs/T1042D4RDB_NAND_defconfig
 delete mode 100644 configs/T1042D4RDB_SDCARD_defconfig
 delete mode 100644 configs/T1042D4RDB_SPIFLASH_defconfig
 delete mode 100644 configs/T1042D4RDB_defconfig
 delete mode 100644 doc/README.mpc83xxads
 delete mode 100644 doc/README.mpc85xxcds
 delete mode 100644 doc/README.sata
 delete mode 100644 doc/README.srio-pcie-boot-corenet
 delete mode 100644 drivers/net/fm/p1023.c
 delete mode 100644 drivers/net/fm/p4080.c
 delete mode 100644 drivers/net/fm/p5040.c
 delete mode 100644 include/configs/MPC837XERDB.h
 delete mode 100644 include/configs/MPC8548CDS.h
 delete mode 100644 include/configs/T104xRDB.h
