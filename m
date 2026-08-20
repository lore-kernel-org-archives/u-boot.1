Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A2C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26A2E4056A;
	Thu, 20 Aug 2026 07:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZukdhIL3iIuM; Thu, 20 Aug 2026 07:44:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787211871;
	bh=mfQQD7zuHnObPoxPo2ZiDrbydeJJaUaprMPKBekpEYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irbUNtq4UGCAAIJJ6ayQBexMZx4nJiYfCKAojHtu9pkKF7ZX/nvwl5oHJ2Df/kbpy
	 fyUJVAF3cu4UhthV6SRli3BYv0zkFS/yKMjyYz/3QRcd9jzO7l1PIG51GpIBuJCoA7
	 f3pd1i4eC1OzH7qdoOvIBPfymyKyxn/0SbT6qJISfP7ZDhzSVwwj2Mv+rmjLOVLGkg
	 JCLep9VzPTYx6eRt71UoNbSLDHWvDcbOvUDqR5LRzsCCEoJrVqVqmhaXlNCqsfVgHW
	 ow551OJTwMAF38XcUZ8q1OBvSpHWv44KI9rFZaOLnJZTYVD5/mNrUDWXCbly2aEGr0
	 olYgbG5KXDtGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CBB340566;
	Thu, 20 Aug 2026 07:44:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C798323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45CDD40566
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NmjrdDu5VTv for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ntyn0svj; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ntyn0svj
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A5D14055B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:44:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MoWh3hDeLl9Pw7J9mduFK6kV/5sZ+65IUz4jOtWNf8kpwroFxVLvWnkiMnfXKsrSBVm4M5f46Q8Qfl6EWJb/9j1Fm8NATXItSn6UVnOMRmb+VBdwPC8X8vfYk2kYClKEkNzFww1GAR5HhuKXA/E3AX3XPz+Q8uydW32VUXA/yVY0VEPMPNWtV7z4Kk7thTidT2s7MMxASu91X0S8NbqRrQkPoi8Mc6EpcDRGHVI2/3XTbuYbFmKbeKDYJ/kt7yE5dw765Kf8+rBTZjpMbqKtW2f4WNF5IjrWZmL2IrFtiVnCDlC/vTYapOusXwLNck9O02ed9sO3xFxekRE2t/TtLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQQD7zuHnObPoxPo2ZiDrbydeJJaUaprMPKBekpEYc=;
 b=OJGHACbf3KexdG7qhVmZ0cDMdqNOIWiWYuSvpusk76u60O8JSuYBOYxz8I9+uvQcGF55czyRdwBOEyU+ANCFapr1P7Afb88mEBKx/DnLV1bquKu4xT+pleMpDZyxSaCHQKmS9H8NmhPdCQ8k7cvl1KjHsvkqN1TUNRONMuxwg0BmXi7yaN4xWTARcoLbyiejAy1jJpo2Z4XUVn6cNyOnGb0iERBX4zEOKWDXlZDtmsDLzM2Q7SukvHoTqccgCmJ/dM3dBgoHB0iE8IBg4Pz77QKprQYOhtdgAR5lUjdCznP70qY9ta5QnFKA42g0dfIfPB4DytFjc6Psm7hkvb6g5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQQD7zuHnObPoxPo2ZiDrbydeJJaUaprMPKBekpEYc=;
 b=ntyn0svj+di8f4irXhulwB8V9zFJM78Sf48n4wb596uKu0DjrmzyShf3taY+8NmthJ7FkOWf9msvjZSgOFq5ORW81ntK4RhCDIjalYfFAk6gY6SncpM3AwRr1hL/UdS0F7+TYYUQrE25ZT+EY0LrJamMWjwzh+5hmFRg/x4w+YE=
Received: from AS8PR07CA0052.eurprd07.prod.outlook.com (2603:10a6:20b:459::13)
 by AM8PR08MB5859.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:44:23 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:20b:459:cafe::a1) by AS8PR07CA0052.outlook.office365.com
 (2603:10a6:20b:459::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 07:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 07:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtsQ8EaSKR/SYJ4JDQkOf7uOa7szGU8uNf/c2FJl/qJ+BGmSEjXfEmRA+8NVKerUhKnkLCDnp341opHhx15hlFJ61UFYLzr0wIyupDEhFMcu0V8ro7fYNB8HuOBPrvs1Pfhck1QmmXpsk40cV+Wk0Fjh6+rU186dUPKoiNWTCQBcNFCFq+0poWbq77sWuCxgn5doOA8DmK/hdCqPoy6oJ2XWbVxU/I3xBkf7ijd8IhXrww/lcjwyzoJtTIjuwYrQEv+7P3D2Clo8IXr6OxI8HuRIcuZgC51L4Z4RaJXiQWnhYbZO5nhceH1FLS47tYERTiTS8F4mj8CLWGiw1QFQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQQD7zuHnObPoxPo2ZiDrbydeJJaUaprMPKBekpEYc=;
 b=uBioHLPcN/IDtEmsDOZiPotu0ZCYXFXpJXmqnR9fdoThTpJNxq9kn+3vkhg3Or044FZrkzmHlIc0HPhXHPxQewamZW7rKNHiTxPeGnFVFRVGxqejYWVeXgY6I65uvE1YU7e8i0pIDOei7NdMYff8O02nXcuqLDCc8/2UfXGc/uz4XA9+G/OyaWEMHiAoUyu+f/T8sHksrrOarMhtIe0HhyAngvPS9jcjHRhEb1JXlTFObkmbueQ0zMvIaOzx9JwPiYhcayuoD7OziSdVCbCbIbgvqf77rDkgT5/g8IDCnd6dRDe/7e3k7rZESNlfXuteUqjpCRo1SXZ/JZfo6HoJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQQD7zuHnObPoxPo2ZiDrbydeJJaUaprMPKBekpEYc=;
 b=ntyn0svj+di8f4irXhulwB8V9zFJM78Sf48n4wb596uKu0DjrmzyShf3taY+8NmthJ7FkOWf9msvjZSgOFq5ORW81ntK4RhCDIjalYfFAk6gY6SncpM3AwRr1hL/UdS0F7+TYYUQrE25ZT+EY0LrJamMWjwzh+5hmFRg/x4w+YE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5691.eurprd08.prod.outlook.com
 (2603:10a6:102:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:43:50 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 07:43:49 +0000
Message-ID: <10934097-912d-4acd-a88f-be811df9aec4@arm.com>
Date: Thu, 20 Aug 2026 09:43:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: lwip: wget: free the transfer context after
 an aborted request
To: shj <shahriyar@byteray.co.uk>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
 <20260813-lwip-httpc-uaf-v2-2-1c3f0b3aa1eb@byteray.co.uk>
 <7d18b896-cf1b-4953-a513-b9ea53ec86e1@arm.com>
 <3a0281b2-2f73-4551-9692-1597ac99fa51@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <3a0281b2-2f73-4551-9692-1597ac99fa51@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5691:EE_|DB1PEPF000509F9:EE_|AM8PR08MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: a375d91f-079b-424d-4ce8-08defe8eda1b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info-Original: sWaWSq1SJ8Uv4CJKPyAsjXL/5gUzXjxBE25MCYbJHFfK5VUPcXHuSfmbPPDjnlJQpLLiMjioRRQE7qEFZTaUtiPYxARF+QJo7Obzvqsh3HKnc+pG7a4RrOGt/mq3kGVX4+yrGm/HvxV2XhoS/0bs2bpFP/RMsq0ZxrGCycKittL6Dkb4hGnjgT8GnppXDGt51VLKtTmhBoIY6wb0W/4hxyLYfStNB38ak/Zz3pI0CwIlwnGOdLhIQYNxCtQgK7WT9ET6poSOTbyN0qq/xcoA0AnukVMY1Sppl9Wf9tvy73daf52P4xIeXnzWeUoD2u6mdZruKJaTVuvUql31uanLprKcz6I6GkeX5bF/UUHWeaL2i07LNyxbH5+ZjOoJ1tWcdlrhGcs0QHb0Btetz1NEN3G29LWl7EvRCVBPVdiLi1PGuz3L3BsNAAsAvshKdLUupwez93dP59LGmzme4hwc1tWdvYjKC6ulnpbHSP9r/TgKRqtKX9yG9lxo4pw0enhzRy50Ch+Wvj7S0bdApY6CmCY0PWPa0uJnZ9Kygusm9BdFogmQPBk2nx3HI8QdAuyHVZ1JtFeL4p7EKHj55WK3PNisVhEnak0s5WaFrq+5RLiW6ykmQcSqG37ZKHGMghPVjFOAoR6ZeMXcECtRMFwkVJ2wRpXA0sN2S847+NIYOzI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: OBBW2eroD7u8/AZTPDS4IKc6F/bpI7QKP5zSBvvs6RsOhtpQN+0Lxx95Jq4SwemSDZXTeIuhOjUxRy1+Mfs9q+cRHw8/6JiPztjhW/tkJA1ordB9T6QZVusTZRRE+Kk2K5yuND8ut8ev6xx2zw8bfCXqFACIGPb2H+PcIKSSoOSTK4KvCLSMPCR7Xrqgr170cXyctZku40G3clLFh9wwAPEH4qjPk6aH9nAzSjb2dkBRrGxrdCmN3y8GSUVuhL7nwHjMN+Quf4n6FFnd/WARF+9QzRetPbW92CyRJnWGFtF5kSCkpERuZ25uGqG7gCQqoFt3eGIOAJUy0cq0WYa+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5691
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e67dbfeb-a3b4-492a-8636-08defe8ec607
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|376014|23010399003|1800799024|36860700016|82310400026|6133799003|10067099003|11063799006|4143699003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TVTdlXNjCavriNM+VPuEur0CGBffMAvsjCtR7uvzhS1+ch0+knivz1A6ksg1ORung4ddArozWF+oqWPOOZYTo8xV4lZHggaNxFmI899IuZwTbORvXoyawOd8/RDgzygGIwxLvqkQcDLPccAUF6WGnfVRTu2pi581TU57Q9bdAZnpWkHJ9VgRFCxlT/VwOCrGl/4uTnJU9Gau2Fye3E2KMBXIjwGIVUHZrS4jhAaKhbpJoL+7fYDdKFfGFRUO1DP4otPFchZXDuHHbGwJZ4iLM996E3c/cPaY9zBJot3AAv2Mw3P4rGUqxfdOH+rSwaRpVcu/uczrEMq90byj+Qrp+fMsianwFXo6tPICqPuAunqsoqDknj7zEWHS/bc1Ussw4ch+fo3L35kTM6pH6D6kDfVoGj5xh50DmQuqQ8BdsJ7mWqL4RYpGQUnRJmj5LaQ4FE5sMm6fJv3vogJLD57RiY755jnXMURiHrHLDDiLb4TgGz1TZAf3lxzWk6x57ul8LcxQyb+3Q9HPB1juy7cXWxf0ivh04jbuWekeD48L9bTYM+fa57HMsNRWXMfFrB5qIzC3JBQauS01vdqEGhrCKnFWAbTxYAPBsP2OOJhwWXF+GsiBwv7/0Dy6MXZPKvoOLZW1NtONBh+2Mgs7l27vYOH/wqwf6yJse1Iri/Dd9Ojj0k+yVELvOxK8qAYded/173ov/ISNf3gdyfBLkKNaaA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cRI19jsLaSpYF6GBgV8Nwtw3SRiMiUNiXyshCDqcoDOZBfo0ROjA0PaFta87U6GiwhBmKA+4eqeVd9vwoPWmQAvzJENoJvAPY6ZwJILe9zSBzuZSGpteVe58IWf0oaR07k/3RPW94p5n8EQg/oRwgvMn5yKdQgop4TQK0aLOTRPol8kSLXTGIL+UafNlKCzy1WuePTQLqFgY9voVcJfW3wiCQVs4HtGuR/bzpUDur8wCP1JEzjvuwma/lRQSqq0v54yHzGPwe+9YJvWJ+ZjB7XFvkyRL4B/SSRR5k6RPJr6KVGyDluDwtc0LQ5MkCz+BE9C2Cd+a3rFF3RjPiFXMbs/FHzNGBolfL3ZrWAkbGarMxPhSJW/vnC8NKucRFtMDxGuH6OWtm3CRH7OLmHtptWGSlgQWz7ll8oqLyaSB0J5FT40+ns2iDw9bCn+2+1vD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:44:23.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a375d91f-079b-424d-4ce8-08defe8eda1b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5859
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

Hi Shahriyar,

On 19/08/2026 18:56, shj wrote:
> Hi Jerome,
> 
> On 14.08.26 16:28, Jerome Forissier wrote:
>> Hi Shahriyar,
>>
>> On 13/08/2026 18:28, Shahriyar Jalayeri wrote:
>>> wget_do_request() keeps the transfer context on the stack and passes its
>>> address to the lwIP httpc callbacks. If the user interrupts the transfer
>>> with Ctrl-C while the host name is still resolving, wget_handle_request()
>>> leaves its receive loop without tearing the connection down. The pending
>>> DNS lookup (which lwIP cannot cancel) later resolves, the connection is
>>> established, and httpc_recv_cb() runs against a stack frame that no longer
>>> exists. It writes attacker-controlled TCP data through store_block() to
>>> map_sysmem(ctx->daddr), with ctx read from reused stack.
>>>
>>> The httpc_connection_t passed to httpc_get_file_dns() has the same lifetime
>>> problem. lwIP stores a pointer to it in httpc_state_t.conn_settings rather
>>> than a copy, and dereferences that pointer later for the result and
>>> headers-done callbacks, so an abandoned request reads its result_fn and
>>> headers_done_fn from a stack frame that is gone.
>>>
>>> Allocate the context on the heap, move the connection settings into it
>>> (along with the TLS allocator the settings point at, so nothing lwIP
>>> retains points back at the stack), and add an 'abandoned' flag. On Ctrl-C
>>> with a request still in flight, mark it abandoned and hand ownership to the
>>> lwIP callback, which frees the context when the connection finally tears
>>> down; the receive, headers-done and result callbacks return early so a
>>> stale callback neither stores data nor touches wget_info.
>> The problem I see is that this relies on a later callback to reclaim the
>> heap context, but that callback is not guaranteed to run, especially once
>> the command removes the netif and stops the device. That fixes the UAF by
>> extending the lifetime, but can turn Ctrl-C into a leak.
>>
>> I suggest cancelling the in-flight lwIP operation before returning from
>> wget, while the stack objects are still valid. That likely means adding a
>> small DNS callback cancellation helper and an httpc_abort() helper, then
>> calling it on Ctrl-C and freeing the TLS config before returning.
>>
>> Thanks,
> 
> 
> Agreed, the heap can leak on Ctrl-C. I looked at cancelling, and from what I understand lwIP exposes no way to do it today, So both helpers are new lwIP API, and since lib/lwip/lwip is a vendored upstream import I'd like your call, upstream to lwIP first, or add them U-Boot-local?

Well, the former would be ideal, but upstream lwIP is a bit slow at processing
pull requests (I’m not blaming anyone here; that’s just how OSS projects work
sometimes). So I suggest applying local U-Boot patches and then upstreaming
them. If the upstream request changes, we can apply fixups later.

Thanks,
-- 
Jerome
> 
> Thanks,
> Shah
> 

