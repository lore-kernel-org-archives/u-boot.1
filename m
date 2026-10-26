Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rfqi5bSC;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eUzSzMzW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A148980E09;
	Mon, 26 Oct 2026 08:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bH1hRyx1pwRN; Mon, 26 Oct 2026 08:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C6E780974
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002502;
	b=cqouMQVCWM5HRkGPS0RelspALfe3oVggaW5LyeEbrPEnriwKiwbR2hJVQbXLEBJxXnY+
	 deyGM0lZbTxYopY3G++AUJCJ+yo320Q0VUVnhk5DmboB6uNPbOY5NSO434za7wBrJcJUm
	 4mN9KCiSBV/E7gJ432bRiGLsxJZ1nlKQis3vQmZOConQslnKWc57hV3kabo8PI9gdx34a
	 Tu00+KnmuptDJ9TvsNzEzEluEuEV5FJ6lRxCcZrTKJdaHqmWCoZYVgyIBTJsjwH2bEh0o
	 8w5nwIHBucKMnVxhU0gmY9Ovkxg5xhXaYJSpSpjbo4PBlNvb+zu8IDgJr/s564TSpSA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VM86F/ylwyfx2ZIYhPE467nCYVQVSeBP5/DAfkIea9c=;
	b=b8q8rm11Xby+5h4XAYH8AgAz4KLtBpRjEchQR1Dk6IOb1pLZiOc3tstia9yXSgYaeCwy
	 zVm47haotoVDGhgleuKSlZaRR/NHxO9Dn0Hrf68FRnGic/WoAFJgiVBR5rPkXHn8E/tT8
	 yD4YzyPFfTtCCbCt3SN65Iwf+Oa9wIea1DjQ6irpOECF/lTKX9Igrn2jFWE7vnmnJTpkz
	 rjFbAAaFR78pi6XTHUPpbaxojZCO8mJpDGpZuVfg/1aTmPZ0qYkAShjnWfQpd+0OojmiP
	 D4R2u7tKgynsIBQkyxynVn3iGDi2G9DTFwN008G1VuKaAl5X+JPAlAuE4oWYMrBOEAQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002502;
	bh=VM86F/ylwyfx2ZIYhPE467nCYVQVSeBP5/DAfkIea9c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rfqi5bSC6Bpr5cjqp3H+gvXnNSCRBLnMV70BJcDKSjSdyZss7yFDMV8NRDzF24lFK
	 9/2mxet4B2E5brqrUz57OvVspxRX/gpB2iOxDhUdziyaq/AI5QVsekAwKv6oP30okj
	 8iJXH1W0wt+ixTFx30swWB5M+eENihsL9UADrOdGX0oaOtjQsL6C3QJvMnNVsz4A1g
	 lVqVGeyosR13OfbdUNnynsIltk3g8zMDBEoY1QztkrIQHnD/5usN6IE9s3ee3NigfH
	 3HzeNburHNuQZy3XIHHJr7uTrHS12HhGHlSUHI/aqWx5oCkWI6DaVAnAcPAadoHETH
	 p6J74Eskk+NTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C6E780974;
	Mon, 26 Oct 2026 08:15:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3954B235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B4B3606F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjgUdY-O5uRb for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BBCC606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002499;
 b=IjaEGSc6iNQO6JTi+YwEZKCyO+fXJUVousbs+w//zlsOarAsJQrbuwsoBQz4bAqoCusS
 t0b4qLLNXUhH3HJ4fVbvUompsp8L3QUFStcIfccf80Thf60U2Np46gRJUBsVMThcqIiTa
 7aigmQOtxf/h1Ohfj9ti3N/ylgWftk9FU1HATH+Zb5MYOVenKUudd3iF5PRTB0WnIE841
 jOxaIWlnuFfMZMpngFAwuNpgzMchDAgDnjJ2RcMJzs7f5b9Dn6NomjHuVoXrR5xeFT5ri
 leGaGKKv3cYLrh+9o56U+2fBeuLdyJ3yxfL4OVlPqSU9cGBqkQAgX1ECEzKV+iYhAZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002499;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=VM86F/ylwyfx2ZIYhPE467nCYVQVSeBP5/DAfkIea9c=;
 b=QEjt+6/KseORMQVNVQhnXG7aJScQqKxIdCJSLGhJFvYHIx59ABUH159+whKwI/5j8s/F
 A5pwocHKiFA5A0TlbdLAzqxICvdR2kPASs1giycQOmwwo+IO4BaBTfeKOo+0+LrMUPySq
 3PRIfK1NV0bDPvXNNrZjRLy+zH0J1fXRUX/gAawu+KyWSSwBOfR6+Vd4ADcwceiLqd2Hv
 bo5CYiYppfHajVM2SoPJCsdl5/B6YDx9jj3INee/R+07KyHFvlF5mjaSYlSuL0YUe6nzU
 8S4PS5HSuHpNMSffRkZ19W/nZK8YDp7Swa9BIoXgWIZ9wAPpkWMQwqsxr7sxECaxCMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eUzSzMzW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=eUzSzMzW
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BBCC606CE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBXFXcbfAy3rb820NdPRxRNeNfWVWabSF2tgIT9SG7/GvCH+DsgN0/KDs0Th5mCTZFFou+NFgmAeenVygCiy3Eq7QkWGdpyXYVo6+mtIIFicNlDRGH7J7UrBcw7Ffmr2nog4acgGUSEJglbH65lQubbjFEuhbycBhn9E28QuXF/jg3tGXSZJGn4f+efA/6xxAM13ZOjdnEaPj+dodHsoV9hraWl+qie8yiSEswOOIBVL43zypJqr7jf+cz7GjONCsSUixybFJsBxU9uUzbhTi3eoIWDwubColi75iTWaUORYKceHuCPjEQL9r9EOF9FKFWEdvzs7SfHtLzYhMZcYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM86F/ylwyfx2ZIYhPE467nCYVQVSeBP5/DAfkIea9c=;
 b=LpwFx/w9Y580/sdD93X2I5rKsKuezVn3ylpyh2h0JpUREJ1tOGAby2VSs0f8dTTSjcSDXNP/fAll3ExdMdnUpnxFTePqdyi9f+NEyfY34qk09ASy6RwPFD2XEvNrsDtJN9GZHC3fEXjfi9h3LvitvKd8ZdNG4lcDeqh/DlDp/7okDyaJJ5z/Ku+KDaNmKz92CtrHnUGUKvgefz5IvSEOH3iMEXU5E2ntvJJqqu9Nvb28XsXShQLiT3YIiRf99Cri0Ko2Kjweg68LBOxj7xLWxVT83cS2LqXJwJclJQTSkuf9GuEFBag9856cWviO2x8l42JMaq6pQvr04IoQE6QfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM86F/ylwyfx2ZIYhPE467nCYVQVSeBP5/DAfkIea9c=;
 b=eUzSzMzWSPcpkHMCiFIKNm3BAhRIJ0mGK0a9YsZ3RN15BfCDKIG5joJ7brAsDGjAZGBLNIal9QhZhYXYbwWQ7qzOCk6saI7XqW6zkCTbSSbfAA9caOWuDgK0s9CH4NxoZgzoUiWJKS3E3kw3Bsl1Gqsg272NqLkj1XXdK52sK0Q=
Received: from SCYP215CA0049.LAMP215.PROD.OUTLOOK.COM (2603:10d6:300:149::31)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Mon, 26 Oct
 2026 08:14:54 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10d6:300:149:cafe::2f) by SCYP215CA0049.outlook.office365.com
 (2603:10d6:300:149::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:14:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:51 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/11] xilinx: mbv: Add SPI-related board config
Date: Mon, 26 Oct 2026 09:13:51 +0100
Message-ID: <c20491c0e2af31242672920ad997f798a5c6e7b5.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5f70heyx6oFxUUBWvJ4j11CpRA3oIHfiewKD0bsgnzE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z7C7dPXrrs+udR68j4Pv2kJ8v1vk91LM6b8WrPx+
 OPOCDGGjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiI1QWGv1Ibuo181yaGLXzH
 tvzj8c4WXc0HOxgXpLMqdZ3ks79W3sPwv/rcVLaiZ64KRqUnVk4p0RLk1embpV4nZ5F7u9r5+P6
 vzAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed6346a-1046-4548-f83a-08df3339360e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261022075727099003|56012099006|261009223027099003|11063799006|10067099003|261021121427099003|18002099003|22082099003|6133799003|261022115727099003;
X-Microsoft-Antispam-Message-Info: eZjJiz96QbaRsbqh49HMNQGd9vEXUqiRZa62pxC1XfzlPk2xkYBNteIyVr/7fVLWOBCsjpomk65QcHFgDurWzeUamvlLiyz3TyuOQxJXju9Q2tAPPXSFg+im/52OssbdU/RIp9FvRW5gcWLEd3KZ+h41snwkm1iqm2b0LRDCnW4HQx1Fk6Y9Ij+mEq8RB7xZyyo6ETCW5p5N9JbUTCbd2yoC7tLwls6mxwRa5YuP3bcc/1VLQMHyxBj9se1lJpotpwPrEIOcNIMfbm4L1veq8e8xcCQxBp6dDfrnEjqvdbM+XhH6qTT18uA89IVPqxpGiATLjjveciS37kMbT8/Oq5BUzSSWyNLO51EqGpFRcJ/woOvgy01YNyptVZcFbUEavbMxw+pVaEpj5Eo+kSfRZPcO1bs3wYAMYmmf9KclEu6jsaklwb9xaywbtJUpKwx9txYPVMw2vkbVNvTHVq5JASy5eaeLrozAnR3aPnrE14SjJsuxgYVFgQDJEgMvjo26jvJx3EgzVmGSuJmU1fkfX8DceZtpnruRJVsvBNRM+Y2zAUZdWGx6ntdCjZQNwDwRl/XZLaRAhAFcbwXrC4dbnpj+hHRhMNbXbeeJDjS7A0N8lhUuBYxFQDkqovgZIB2EPxHMS9ZgV2R3ztWAMFOJ4TJ4zC4IRcUSIQCaFQO/oyroU/RKW64onQqQ0KxJaaWVOVXJ82FqbTbBT7z7ZBHLWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261022075727099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZdVtf5inZrf6gUZ8ki2q57we+oDsC5daZSXiBCcUUi3xq8mDOdL+fdSnOwRbzbw0h3ldJJ6uyqruyhv0JbZ6/TZdvMbeqnALT22M8OMug1nAnfBjRX1T59nEHqNZehfpQJ52lhqia4SyDNt+lABPK0kbGPwz8NEBNXlDT7FqRT+O9FKrDyDIgb9IwfRTaRBBc1ssxW0lZdy5LiQOqCT5sMG4I4pRHn6FkBX9nxrHaYPl6W2JxObekGObtDrnNBXAKQdZcbf6F7ZrW3XeehJtnnWBd594JTO4ozfzUf3ElI2dG/M3ZJqAfSgJzoVgW9UiJgc3sWRFNhyn8YaASTVCUMZeSpWRwPpcZERCzQO874V39e950YBL5OYtjS14IRzWWIkPV3VUaC59c5ZJvaCO+NeZuk31mwcoBJN9O+1fmVEmnog/PnBIWc1mMp+XQaN4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:52.2561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed6346a-1046-4548-f83a-08df3339360e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

Add SPI-related configuration to enable SPI flash support for
U-Boot SPL. This allows SPL to boot from SPI flash and load
the FIT image from offset 0x10000.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv_spi.config | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 configs/xilinx_mbv_spi.config

diff --git a/configs/xilinx_mbv_spi.config b/configs/xilinx_mbv_spi.config
new file mode 100644
index 000000000000..34b744e8ac1d
--- /dev/null
+++ b/configs/xilinx_mbv_spi.config
@@ -0,0 +1,14 @@
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_SPL_SPI=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
+CONFIG_BOOTDEV_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI=y
+CONFIG_XILINX_SPI=y
-- 
2.43.0

