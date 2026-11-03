Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150D606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=inlCCXUy;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=iALjroAx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7C5F81106;
	Tue,  3 Nov 2026 13:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhMXK_i1iytZ; Tue,  3 Nov 2026 13:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6F9C810CC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711093;
	b=VEvd7XPC5lbrrunea3THNyHT7kWdJEUXbywW3uvnk9sB1Z9T6uUA1xf5v5r/fPoVmJnC
	 /N0Eg0DFuEqMe+OFNaHWUh9ofh43gvJiX4eNKWe2O0osuJCflb+yj0R6qdILu+KvJNju0
	 NCpjV6PMsIr2rhuHdw7PI7iWenRy8YkzktqE9zZQpEgfMx3y7+k0ro9G8pWRG3FiOeflA
	 YKsM28GFyuYOE3w0czGJR7oOJU/BLCzOU195P3KOiXRNiFGDorlPWCDUUSESpPRB/cHDq
	 VxL5U1VZwnhcwHuERuRmLHFNtVm51+hb6ZfPktKCdllGNPMu3xlOMqySbNcUe5zHTLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xLJplarKaBxmCUyZDhVsbNNki4NhJcVtVJt1ekYg3W0=;
	b=Y2X7FIT7osgcA9jWsErEiJDCB4aovltDc1qwiIoGFNJFjcFZGPpkVh56BgXe9KRVy7CM
	 b2Y6DIQepFeK1uzaSuP0ga2D7LrKIApsetzpNIzzuv78VON6emcQzru5MyVflFZhDXUX6
	 QGsNUrCUdsvViCi6AQEz8vBWxuyDTL1mqeYAj32qTPzkNP9WlE+bxvlnDEDVxKAEYfVpo
	 mx428SnnJAjuS+j87+EMz9TwfraWJ3oE4ItJRNIqGrOd1OQGOVctPbyTpo6aRSg/q14Pu
	 tKc4b0B9SoCXrziErzaPeD64+aYtuRBKunjP/Vpi/vB4DDpD9zS6VWXiGmzSsnuJ17g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711093;
	bh=xLJplarKaBxmCUyZDhVsbNNki4NhJcVtVJt1ekYg3W0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=inlCCXUy5/QX/FORl6V45RnmwqSEAeJTG7OV+LzXZRMOWbj3LYODqwe3Iz6A0ubh4
	 CQmw1vrRHXuVCbRZpDS2PbhmXADyzuOISvFqOHn7OpQ2pS303LUleGMGCQn4Z4ktXF
	 4e+GxGyv4QULsToNpHMzAX8D6HUB6DjGgPLip6aNj/YVsYhqJYU1WBHCdrHohF75Ft
	 rLqxNFaZyV+qQvwqYu5/XeOq0vskE72Pk9bCyrTc0Yc5Cr50CK1FbWF8fSqN1ePEPm
	 kMv8rj280TIjQJTQMQ5YpxDJwl8DLZhuUL9RNpSOGvU0DknQnATXg1zNTYsxjeg/Rl
	 FYjCMYqI6JjkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6F9C810CC;
	Tue,  3 Nov 2026 13:04:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 130B62A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB3D860670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjPpdja-6zmu for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9F72605DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698435;
 b=ZDdVeNVOZEcZxZcWG+NvdTJ27B6i65Sxx9WNahc7jEjAnpCEE3Y+2Sz4TummK7G+thUV
 MT8B8f1Lrvy61IE5xaCUFhZO/J+8jUsLvPxEnNengtG+3W/UhzOTDArxCE1CQ3Vu5ywhJ
 Njvrq1lzm9zUKmbSIsWhkzFUF+JQVskuw3tyLzGhYfL4MqgrJT+rqQcPZ04U+XRuetUw8
 zd2/JelSlxXzkPVG5ZiPDXRnjdc1mzRwlSPF/YPPcghEoMuC5FahQVjA7K39sHfPqYO86
 xiXzdavpLlGhBdUzPanMTB6g9NA1O8jiA6fKVf89+9A66oCzlsoPrf3+fRKgITrKYaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698435;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=xLJplarKaBxmCUyZDhVsbNNki4NhJcVtVJt1ekYg3W0=;
 b=i67ATqt9lbN+DxbyVw0v4kxCh2pCDOELU19BNLCx9cnuL2EdeJbBP4vJed/zjrHXBig3
 vZU62325BzmZ7693IGPqig6mV2zYwfGFChDkvAQck5+WRhQd9BZEjyg05H2VPawEG121M
 EwOvFEFOA/ZVaMlP0I8BpmL9M/P+nCAPqDc1ED6J7tAaKqCLb/ikHPQA6rPJk4EV8rZPs
 qQgLlKQzhgsMzAOOd2K42Fa+vYdfmOZ4lznNk048JGyQXounx5YKkNYwCjPKJK1M1PVP2
 addv1mFTu8HxpzhP0DAfhPPK8SrVwkVPxhpkReo5CS8SOa+nunBcyBicnJQxJVyq40w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=iALjroAx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=iALjroAx
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9F72605DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1JtTycqaLaZiTAGSYr1u7r3GgrMHTcBacTODUEm+cjKKFH6W61vwasT2XXboqLk10Y9P1USPdtWnn9DC0OzIwQUdNw6OYEvxDR8ViBl2huEg0WlfvebPS+AlvHRFeTEkUtaaP4b7aw4By2i6++0llGtouT6cELva5c91TuuZPBTaLNg8bepjFWaSZ3V7bXVkogmRESn7Z1+L6g0VHt0+7p3TRnjjSdDYYIhZaYshvc4WstZkiiap1a+4DPnGzunLaVO3iwLsuijyQbqlP3XTvicokd8OC7un9GVu+MkSiHbZFZ/4CDemp5xPyn2BISrWKyYtCRmzrHU5o0I2hhKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJplarKaBxmCUyZDhVsbNNki4NhJcVtVJt1ekYg3W0=;
 b=OuctSCO2NRfqjKr2+sMhNX0AP5BCFhguXEKoMM3HfS8DPaNNtFOj4fkmPYofQVXaAt9XsEB1L42087bBqWrcPvgDvOyqoTug+L+yXl5Di3OQExOqK2pN3Bk1qBESF1A78GK7h2gieHNzT2FszEEAy6NZHrJX+DCyuL9tGYDRnMzqzwZrpIpAFnvCYDsWA2hfd89CCY3USH9QVnOmdSI6kAMtSHkxPtOXkM0Kh6KIMYIntIHmn+HJ+SS47p1zpKETIuR8M+IRSbdSID8gpI1qSzjebx9UvI5sWZcDxYSSRD4zki/IxonjobaQ13db8tERFQ0ck/sXyFW34ls4XZMM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJplarKaBxmCUyZDhVsbNNki4NhJcVtVJt1ekYg3W0=;
 b=iALjroAxr9XgL9wOqgcc3OJ1GfK/4kh49s2wx0qin0xU2pwPPVly4JhmehIjtrCfWWprP/n8kq72994aisCGjOIjcFLrPX8aVFj0E+c03lJpa6TCvtlR6R6FAnf5wEvuq/c/p/jn2nY461XhN2Wtpw0yDQREq/OzYwjoJI/NZgW9T75JDTvprw81u6qSv91MKf4BwvY6aHQdoBRHVhRAqyoQGVN5Xga3aFpx2+vM34ccJXJf3KgE3/ud8HOVKx0p6yhxIQq07o+ORK1HqdZeHf2Z4dX9gyKzQ7T2u6zHdz2QXjdkDN8GOSnbI8rtprOZMtlQ5+UnJMNVTt+x6MIxiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:33:47 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:33:46 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 sjg@chromium.org, Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 0/3] Implement the efi timestamp protocol
Date: Tue,  3 Nov 2026 10:33:35 +0100
Message-ID: <20261103093338.963328-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c27ea97-6408-4746-020c-08df398d8f05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|55112099003|3023799007|56012099006|11063799006|261022105027099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0RQmouULHZz77Nwg8pcGS0yRxynTFoR7A0W0IMiOaoZ/GRN7GzCJsHi2/BhBMNc0f5C7IQO6tYUMcoAx5wktYck1kPwZuyImAoAYLiFLCHufQiw5E6zgOFoRjqRhmsjRitRowXVe2iaK9RPIOSZZ9EXjb3i7fzeIbyZxdl6QxFvMpdMRDkliNaf+LjffwRfEHCd2dvDJ4dIzGaV7Qht4Ei9y4MY9TjfSdKVCO2OJxefq+nmM1g86iQ74nFZG719yq+ciD6w+ki8uKDRsBr3uUpdfQZzavtabaYk7ii7Xkrr50q9RSErBCfbQ5rvFoK+tOzCY6kagyHbCe4J3CS99Ipj700cGh8q7VPWvte0LBcNqqh45ZHAIo133hCPPbIIvyA768CgNgiovdxD2A/ZT/H9hVBdGI6aDbMIX+19EA3xOMVpwxtV9IeEr9Dcdqugqacxmbzwv4nDHKm6OHKEIEj7g2W7yeCj0TTcyOEyxuWnlcjQ1Y+yuDABZ7oV5HAp9N5i0X7cGJ+wjv492XaLye2eScUJyIkrrfkCp9PIHMd73xJ0UZAdOJ3rSFQKGGpcB8Ceh7YSINfOEtlg1MYWqkrG7HW2Mdo55CzGrMelFY+5g0vb5VNDYJocTAUZ41ots
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(55112099003)(3023799007)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8c2aYY1TMzt45pYr7t8errvzg9mPi0AS6yKvKdS5GrPVeldNTZVb/JeqsG66?=
 =?us-ascii?Q?Piq1TQoXK3T14iy44WCND1T2EWSi5+tj+lyy6weXSVE8C9/ILfALspIfiIpt?=
 =?us-ascii?Q?Qfm6ngs31sHkYvmA2thYJNYHzTS9WPYSQ6LhKb40P1RlCKw5/z6IamLx2qg4?=
 =?us-ascii?Q?myMzqNep/3Qn6LWaPB4b/oJE3/9qLq0brCaDbQ0CrUIaxwUHMuhpJcorZSUp?=
 =?us-ascii?Q?9mNAXusi68i9J9S8HskcWhooxCw8QxZAKnldvWe+MqQQK+0Nyty9aUeW7YA8?=
 =?us-ascii?Q?IR4y4wNm7irGuot2MVRZ2sWExuTfAT64DM0UDLx3ALbYt11QBngEcvHJLRUD?=
 =?us-ascii?Q?6B8I+KMRseMPqnIp2S/FWQ27t/IFVIQCp/7jneihRErbggBCpppST6sNaUqh?=
 =?us-ascii?Q?gc0XfONFF8ugkO1fIb/ZljT/Ygizgur+WvrMDz9xcQh3ngq9cWalCuyjko4C?=
 =?us-ascii?Q?usgmxZ+T0yj5GlfX+6D3afYbg7fvzCV5kwm9xJrEq2lGeENJZZQ+FWvaAMen?=
 =?us-ascii?Q?xLERWckPWWGAHJ885xku1LgjTzT4kjkqsKD0e+R2bthHoOZi8LAhHdYXoq+e?=
 =?us-ascii?Q?swuMryom9KJvE4a3p3NXBIeddjHeXhNMKWPxehohWgGvAiYRXYVGOtGU+cHe?=
 =?us-ascii?Q?GnwCy6tsmfNwtRBXY1gK3dQ1FZqsn2LZGKe+5wj6IvByzGWOUUkpq84zNZxx?=
 =?us-ascii?Q?z3Rhb9QzYrQ/H6KE63Dk9s8s9iBt9xWdgLGKJ4ADGjvGqZ0Sau9UAwO/MdYh?=
 =?us-ascii?Q?2U+7WQuoekuZZgEmxP4G+H332zElDr5xoTJ6C9zfsLQg/M/Dz/RcrXn4F+RS?=
 =?us-ascii?Q?yug96W4c5220ZBA7shg5y7rFmqxbj59CIA/PHrJpw+a5RrQgEiWp6TuBlq+j?=
 =?us-ascii?Q?oEw5gyobdKScYJeFmo9Xkqr2BeTe7ZSck565od/CE1Mk3EmO+74zbFRpIYTi?=
 =?us-ascii?Q?Ed+V+FaInA0fxc2FEjPHS3iMr/imYUDp4jLseBLCrR9gnNY5feYtp0wBPWX+?=
 =?us-ascii?Q?pHkV+kXZ1BvNQCaOzVT4C/W1rWRGCRkiiIpdJ5xFXsu7Uj6GW6wMXgvoyj9r?=
 =?us-ascii?Q?Ve6UnTrqSr8EqIcP5p2fHK8wwvc1FoSh0LBcn0Rw4RV6283c8BqJzdxqkloy?=
 =?us-ascii?Q?ic8jRCpsp1VNzqPutnSgspoebzQ4dydlg8GLW3Ia++V6h7/c1NwEI5aKSGfq?=
 =?us-ascii?Q?YFaqWsCHo8GdFZVwfoEYjoyBi5QtUsFMfpW3U/dGv+UNxs+nUuzLSK+oz+Z7?=
 =?us-ascii?Q?Lxygnn0r0GchdEa6G23Ewe5BuM25Gp4C10AcFa7pHExH0VWqq00X12aJSkN+?=
 =?us-ascii?Q?ImCIlOxDK4onGvwD4n2976FO+yrMYJmkpZz4wFa/hjMhSNcNVSjPt/DykBmU?=
 =?us-ascii?Q?xco4Q2C5vuPf0CKN61SNyOFw0NarBUoEa2kQ5jnwE1+sGDj8RZbknqa+IyO6?=
 =?us-ascii?Q?AJOf6xEE/IvESK43Ww+k0jRRBw1san0uetjhlEKhR8PbiYCoL7S6loMIq0+b?=
 =?us-ascii?Q?Cd0qixOCmo6Q+2ncmNna4bbo27S3ndwz+9n+Ip0zF4tgS3XTqheggNsCA9En?=
 =?us-ascii?Q?jCutrHURdRdffxKNozELUZjJ2FDnsP8ND4ls/1TqehtwtcjxVJ9Bwmd7/cLU?=
 =?us-ascii?Q?CJTnZuh9jB0PWB+FBbuMjyE9gTQIolvJp9QW3HG9OqYDxG1De7xTl/8Ada4U?=
 =?us-ascii?Q?s31HgBD3x7Ni1Zofor9U8YHffYdCZgMbX5+/o4+Idvff/AQg3KVOVYadFYn+?=
 =?us-ascii?Q?vMk76a8mqtPzRdU2UD64vGz1TxnlAYk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c27ea97-6408-4746-020c-08df398d8f05
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:33:46.3605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlgBpyBM7DocoJJtnwkLVV6JnKoIP1+k9xUyofIPKoXxpx7pOcLsmJAWzba+v6AgHdOdnulMGtINU4lHsPYgsvJekPLbeRfIQJAO58khK20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The protocol is used by bootloaders to obtain timestamps from
the firmware to measure boot delays (and where they originate from).

This has been tested with on the corresponding efibootguard series [1].
The corresponding EDK2 implementation has already been merged [2].

Note, that the protocol is defined in the UEFI Platform Initialization
(PI) specification.

Changes since v1:
- p3: clarified the docs around counter wrapping
- p2: reworked the selftest to test against an independent time source
- reworked commit messages
- rebased onto main

[1] https://groups.google.com/g/efibootguard-dev/c/U0SED_2Kaok
[2] https://github.com/tianocore/edk2/pull/13343

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (3):
  efi_loader: implement EFI_TIMESTAMP_PROTOCOL
  efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
  doc: uefi: describe EFI_TIMESTAMP_PROTOCOL

 doc/develop/uefi/uefi.rst                 |  28 +++++
 include/efi_api.h                         |   4 +
 include/efi_loader.h                      |   4 +
 include/efi_timestamp.h                   |  35 ++++++
 lib/efi_loader/Kconfig                    |   8 ++
 lib/efi_loader/Makefile                   |   1 +
 lib/efi_loader/efi_setup.c                |   7 ++
 lib/efi_loader/efi_timestamp.c            |  79 ++++++++++++
 lib/efi_selftest/Makefile                 |   1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 142 ++++++++++++++++++++++
 lib/uuid.c                                |   4 +
 11 files changed, 313 insertions(+)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

-- 
2.55.0

