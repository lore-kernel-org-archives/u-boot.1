Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dsANp0u+;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GxXqiVYh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GxXqiVYh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1751E605F1;
	Wed, 21 Oct 2026 13:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vyuDBSBEL9D; Wed, 21 Oct 2026 13:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F190B6069C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792587869;
	b=rUkWdPoqGQFX4NjWRsNg1YVmfi7XF855+kHi/nUkUhZZDwtdgh3dJfb+x0ggwmRzfAvT
	 zop9skl9ECMlh8KuqbcieGs/cluMytvp98MsPouGudec3xCfgitYKJ/T0kDlqoXgN5DcC
	 yrJqAs6KS+dTLXF775W9RLlogYHAl1AJ44t3J1PPekNikYGD4VqwiYZwazxZzSMN1DS/n
	 Y7T9iMArEoFQ1P/FStiKoBB8B4mtVFnIUz5YeQcGnESa2+xlAJaQd5P2egh+jrznfaVt+
	 ci2B1X2qS51bJvgvuAGVYhkrc0s2XkLoj71mepob+v6ANw6J8tGH2OiP6dTyeOfFBwg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
	b=TKHbtHRd3aMJtYwxD3b3vXjid7nMchHjXsekwUTxKADdvs+FGfXKnjInxnjowXo2TECW
	 CPToVBbQO6XR+G5gsl3XZknju8q09sIIwPNo3+JucmL4x+pcjIuwLZrCdYqX1tJwkZEHB
	 RQNNWmlhROietjiRpBV4ryHlN3S0jQ95DKLD4rdAKYHXB7b/yZxdnM5hqH46p1jX99FyD
	 9DhMdD/lsfYcY8EdrHpTdvHh6QrcXGP804E8d2dzpHVTYLBNck8slaljO2mtLOr72pJWh
	 p5eopN6mIDsoPXfR400+b7DqJBMwJr5cVqjPNXg8MYKW554Nl4Iq5aUa3z4uu1aWj1w==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587869;
	bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsANp0u+C0SjHwtiEP6MvFnFy710tl6cIpmlMp3GNImGpaMaeH/QEx7/3swTprd/o
	 ZllAaH31TiCqlCgMPRO8Vk2BLIq1bIyvV7ez8eUNXwenSishKMF3hrdrOhv8fi0dWR
	 WYu57DsEBq3rc7l+iEUMomcMGgvt+ROUD7XdBvd3m+nM1T8ZKfbqbMjfgo4oJUoaCB
	 g3Gu1NkhxUh6B+tZ0WQ1rno8Smr//EtpdYM3p1lGnlNgUxk0uZ5MiKbRvXzXGbAmcM
	 +uEe3nib+AHjba8g5y2DzyaN/DmBFYaSnQPbMdB4AMNaz06Ws4EnY0efwOQh4F464m
	 93HaOasvDZyhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F190B6069C;
	Wed, 21 Oct 2026 13:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32540930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24763403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NnP2n0TGY2hW for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 773E7403AD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587867;
 b=SpHoA0i5uxaVYRZCs1URTiWVh4B6sElGIARZkI0LVTGS/oR8a+cpCoZXwAsljwRLXqxO
 uf9DSjDD9FvcrJDSSTPhOLskHOotjk8H8KykzuA1Y3YtJNMoKVDwYokiMqNb6TVPclGkC
 Ku8ieWSRBui8qm2fUsba5YukpeND/fy217V2yU7OhpnRTukCaee41B6rqBfHuxsFHaW6h
 jAFV2SNwR2l2oR2MnQ+SRAbIfI+arApiE83W6mQpcrJXqGsNChqiUrffipFHawV6CbrYM
 t9M3fl6kKODDynqA4BkYnsv89pKHhVVF8KhrXdeVV9RAqdlGPMXz1cpaJHrgEhaY1Uw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587867;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
 b=dcdtjYmYwJT62mhozP0PzJoPEwFhaCXZJo6oJpef5N2TsuCdWsJnRPwhfUMacTM8siMo
 H8QXVyZLevw2Hx2sPuX1j29KzSPPkorY+MqGc50orxOh1E2ivgy2qDEtkF4MwHkQ0OilL
 sEYumrUJjiNMLSLCk4kTzM8KtuHQenJ8KmD0y/38tBBNV+on88EVlR9zKOdTsChGZkOCv
 qhkcoxja1T0iqHhPVefUf8KEqASH828ZXha+53hUpBlYb27eHh82GxuhjZLWmQMtQBkLC
 eXclSbxceIvCdhbyFR5mRpP0EyVIjkMCFVhL1+6IagdsmNTLDJzPGheGkkZi03HcvUA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=GxXqiVYh; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=GxXqiVYh; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GxXqiVYh; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GxXqiVYh
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 773E7403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:04:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Qv/tU51xXhdxY5a2SxR6kjEiWx6Wck98KU34rzTj/poGno4TOaALo5oTnLqL0uu3zqX8W2RQROg8UH3iuMRDUh5Lk4ZVKhdMqqHzAnvyoOt4g3SLLA2ZTltTQXKgcd6HuBOB6nwTZAvnpQJ/fcSJ9utWkaYBdFaR0uk/1cGn3k7LBmZmokqpa03qOlIzE5vxxX+2YVhhbKNjVEJkyC+AmoTS1pmsMHVSf+Fafg0Zc8yCsD9gv45PUhXbh3M/3TM9YcRwbS+tfo3SsN+jN+Ito4zPx++8+KcSUV2kyc6P3kFD0aSTyFVacEBgpidXwl+VnZd1v1C0rDXnebis5pzFpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
 b=tInCER0/26CzK96CCSA0a5KFnFDQUVbWQBx3Uj8+qV5Gx6D3Sjkt6+WUBQrjZ4BLSB12cEvs4n/0QsF10LY4jni8CEzilVfX4S8fzDCmkows5zLHL0kmEqVKYigKvB2PTRa0Jm98l6jGeWsyQIdiheAHVoWjjkjK9Ly4UE2s7BvyKkHbv96Ct07HvzdtzhzIN7bPuU1U6FH1FrVH9KT9e10q3YFoPg6yBz/+qdYw1/KBlr84k9iYYMfAQJ/IFl29dTAXTKehRjaCkqn+6H+RGJowUZHF0Xk3kvnrJ4aB+LWjRecgE/NdrytbvOV34iWxiTwK3eYAKGW5N3OU5nVNdA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
 b=GxXqiVYhDAJpWumHPlVNgOsEMPl6dC30ppHGshzy8W9qexIJDyWucDvwHFdHNH+mS3Xb98HWgFL/k447woxG9/4Qq5idEHga6TqC60i+tTqMYJOIZ1/Y8hrCWJxfGUX0GTkJlXJkZYm+AYlo315ea+I+Te9iQN4UCuVE0zjMl/4=
Received: from OS6P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::12)
 by DU0PR08MB8730.eurprd08.prod.outlook.com (2603:10a6:10:402::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:04:17 +0000
Received: from CPH1EPF00000530.eurprd05.prod.outlook.com
 (2603:10a6:e10:32:cafe::6e) by OS6P279CA0043.outlook.office365.com
 (2603:10a6:e10:32::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 13:04:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000530.mail.protection.outlook.com (10.167.241.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 13:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFEdkQJybJaOsSiJsjSYE3ou9UzoWONfqd8hpGgHrdnfFPgfxwbMonT9YwEmoyOabYuEeyOxKKr3eYayeU5j+2PuMdN+J2l+VaIafq2sVRJ6qcjYb9Yvvhrw67JQVdxVunVw1RJdB3YCD+Nzk8WRMzMaXAeqrSs5DgQ/4N0iErzEYk6dEFYtd3i+bqoE4R8UyCe2V2jAFCYX7tOl6Xro6l6A3W8n6kloVX+8lxhSUfNj0pTE0uy7sEG7WcfWzxrBI7FWgtD2HupIdeVKs9RlOY9YdtZDCQYcAN3gb9n29hOndZTN7sdYdzXH46pWXsfOUvSaOjQdKUytJlLI78wChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
 b=qiESLzq6Pm8YiFMIsbilDyLH5j97eX6RqgQSwr+7Xsy3GWDcM13Q12MFGDU+W2yEdAMWZhBui2niN6GvddgVy5t1tQUik1DcEmLmn8PK9aydB1bSmVNK/JRKfglUbjuMp+5N9QJr9LJic+GRu20eUOOaVmIJVS/rwH0g9O7+D8andkI4duV/DXqbrhynTWOYyDgnadTcRz8vZCwKT2xHznPrjYxYgJKTSsBCVGIhd/Q7FlzceBjBWTVHtnxKoE/BVHhqGYCmVAjKKgATBzDyTUcS+HOgcqgJwN/s6Ke11YnWcUSUjBPX7n605FiYUGh3pETgx/GJsZ1oqu8g+0snBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKP5SBBQFbwDG48jbUb3ngBxIRGZcFzq2jGBtxTGvjE=;
 b=GxXqiVYhDAJpWumHPlVNgOsEMPl6dC30ppHGshzy8W9qexIJDyWucDvwHFdHNH+mS3Xb98HWgFL/k447woxG9/4Qq5idEHga6TqC60i+tTqMYJOIZ1/Y8hrCWJxfGUX0GTkJlXJkZYm+AYlo315ea+I+Te9iQN4UCuVE0zjMl/4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXSPRMB0029.eurprd08.prod.outlook.com
 (2603:10a6:102:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:50:59 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:50:59 +0000
Message-ID: <d892be21-b9a8-4223-85be-d18fae6ad5dc@arm.com>
Date: Wed, 21 Oct 2026 11:50:58 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: designware: Disable SGMII auto negotiation on NPCM845
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, trini@konsulko.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, Stanley Chu <yschu@nuvoton.com>, nd@arm.com
References: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
Content-Language: en-US
In-Reply-To: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXSPRMB0029:EE_|CPH1EPF00000530:EE_|DU0PR08MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff1704-a1dc-4f21-515e-08df2f73d071
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Ek3+G7f/qD4bhpZLcRTPOL4gkScWrQtIPe2NGOzX+B9SA882dCsXPnrBOEbmWzohpeHnrhUzU/lRGZfYpBPBf9dHjyk9M0ycRfV8ZuNeXI1ZvKryjKKdvxIgIl9GCk6DYMyfXAB2UjCywJpobf6Hrh9csyluHjuQ2aqcrLDzrhhW/+R8vu7CPCkol+jiiUDP6Fi9l8RSU9fKI5YkFVXD4rsVG88pWkAaKlfmnr1CnSRTU/0xTLwZkVBb0tkOmw0cPofQLn9rYiVu5n+Kc2vGeCSK4/vx2z1EEdaeY33Q+PYtvD5yOshRhXQrq03e8Paq3YznvFC4Ah5gGuQAJA87xelYt9VStkplz1W9ZI4CryhyZ2fJhDIyhRDE0Cde7TwALu3L+4dZSoTrzYTQXNP/kGCchLyliY9Qzr8hkGwuj8sCxtryGyaGRhB0oLHvarBpS1uXVO7M5fJNrSMglv8950dKRICTR4ZjZW/dCCoP7QtCiSz16Yi1NbqZ5FoSSL1Rqd/UMIqO33hLpCR2uL2LCAoXS66J9as98m22/e6JIbp+bcOjrO9DjblAlRpulhzqZedS98Q6O6dzrzSfzjIlBejRM1ucVlceCezQyu4B/YMPUxvzPm0tKX8iqoOSWLjl
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 0D3dY0bYPSlIVVYQ1fCgxyV12eO4hvcU+ZF4VDve5G0qm/j/ME+KbPcX6i7HorsNQr1vISvahou9BUpAp7cNIfUBBgVskcl+RFyG8JDFsn5mGx0cRB+0gEmGt1UyP3zSk6qPaNHGwDni/3NrEwLDPoz0vZKaAScSX/oFV0Gj5IGVia6Hui3Z699uWMcouu3ao8Vq7EIc1NqHvdZkn4Y3Xx2lc21ShfZ12MnyjhXiyOLUSxJiO2RC5FUVil1Ae1qrmyJzITrEVwZAmGGlqdvmXEKswO9XdszLHxwOI32sXA9S3uE0qhJ5pW4MB81xUuCzrzfWunjcMJ9r/enfutkrdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0029
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0fd77967-d43d-405a-b58f-08df2f58cf9a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|82310400026|36860700016|1800799024|14060799003|23010399003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7GEkNJ5ruwGvLg1wZyiOh3jjdcbP3Qr4l9SjdSuBJFMu3lUWlWrM03ZffxLyFZdG/i1Qc8OH0Vv6NAxj0/BcF0ZTe24A7b0iS9shaXjiioNW87CwQ6X0cBRR2X90ScSFr37G99gpcxJFpwMGcC4Yz2Bf5zPaECUpFTrpR30TQ/N2UOoqfXy/iyMQe8Fnkwck/1sgnRKAXpzXbNmOL60UNJvpxgQsE9OJ80VRdVata3wNpj0ng19E2n3ACt9x6GIuXdd4IlHlK6Mwg0skyohZ5V+X8+Eb9J8+gH8KVAKDSCmo/ayn6SDWwJ950RNYo/68q+3QLvZeahipbQqLZKObB741jSSXDMZC1NXI1DWyEhYMd+B+l6cIRYnp4w6wf6iD/0NbxnR1fS3/p4qjpATyALwmzytDAXJfa9W5sK7c5u9Qe08u0oENO1xOJqsOdNOAyHgB5jbgsl2o115QW0KMwQw6l6eG5fXmx+BKWvZg6dY4xUBDPZ5Plr5AlK+cX0/hlynwfhMvGBfPkgqH/3Pdp1wfoTcwhCcjNJQ/CBIQX6wjYF05lTvzh5g9k5MSQNNYcWyTH5DCsTkiqIp0K4vjkCoH0omVzB4umHnYG8Y0+lqNMSP4mDjm9cZqFBF3vTVgMbXVymNNQPUjLJjagFIH8Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uILOoaZPIq3kYy+9+dDBubUiwdkRDG1KsgC/kax11ANSM9eT6JfOUzd70oySdN+VdNcFM7xKYku0MNjhBHjAyIawkAlysBWVjb8lMOeFpHa0PjsP+xHIiq7iEMwMNetIv2ZBxOWTWFmvFnjLfFpmWPB65vWsOxD2XqusMyi3OY93J8FErf0V73v1cBFBX/tbKGr/FyJKNSo8t585UN8ImwCL4hLPGRHJzbyPoB3T1mozDzhY2gYfq2hzjrsgLUj28ggBdaynu7i8j0/s437B3HWIcxrCcU3u+eVAT3P/V/zGKKpDmGIZJY4MYHdkvOQuECaGblWNCORhJrfJCgylJrfKOCA8TRwuyGzqcod3o9VBq76jWzRhvilpR0BKJutdo2JT/iqZGkh5GTJZTx8zdLxdJ+vxtLzOzu9l1dHw2PxskQeEiq/L++4Lm7Mb+plu
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:04:17.3374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff1704-a1dc-4f21-515e-08df2f73d071
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8730
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Stanley Chu <yschu@nuvoton.com>
>
> Disable SGMII auto negotiation to avoid link-up timeout on NPCM845.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/net/designware.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: designware: Disable SGMII auto negotiation on NPCM845
      commit: d163d6021239f0d56797d07a3550201a60feba1b

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
