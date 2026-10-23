Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599B606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J244F28B;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=PdBgsg1C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6575B6064F;
	Fri, 23 Oct 2026 09:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syV6A-f-a5H1; Fri, 23 Oct 2026 09:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 922616065A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792746390;
	b=JSAxY5JfIUu+Lg/Yy1q6JP63h16leuaz8GEZP57sNkN6E5xEUw5X9dCwSitylyJkomst
	 lz5518bYLyfwhxI1Y4W1u2l/8wOPhN1ZLDtgcBAIryAmUqeSM+Ene6H5Xz4+pSuowpHwY
	 xM0AJw4fjZCuswhcBlvMmyxlKvyXQb7VYzSaLkDrdvxOl9HpEdGp/uHp9mjOGydFSyUie
	 GOP2kmPu28tPESB/qb4xyvHTNusr/9znD1xrDHXXwtmZhGh5hPWo3wU9YwsFryPaWT9/R
	 tlxIaq+Ur3O3eFOPtn+oWpemywMZqk8BWUhyLrp+OFYuROZdxkyx2pK7mMO/q6xNKaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FoEYIOEdRjBqfnkvERgsNjd6QY8w8IQp+GugZvE5dP0=;
	b=fCktrd1Cd0M0r2EBYwgui6y60QfDa/kRe/NC/LLea8cCjSOvV1vEMFJ52Mv11xNKBhx9
	 7njgihmti6F9myS3HVQ1pFckmEcpdJ4fNZ/ezVZRvl8StQylkqdcpbfRjexjpEYjissv6
	 pLCi7ncnYJbAwXhLOaKQQXNcKqlE8uOqhZtM70I9Dfv4W+vsipIiDs3+pzWRp22meceXs
	 wi+zOx0AuRD+igfPaUX+4/tB5hYpEil4TZkN/9+7YHkwmtiqxw5CDx4ckQx/rh59uc8jo
	 Bnvvygc0HNB83Xrrn3tTjofI2jEfxuAnd27l2mkTVYhdWc3qHRiAuGKBseKMtaYwGDw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746390;
	bh=FoEYIOEdRjBqfnkvERgsNjd6QY8w8IQp+GugZvE5dP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J244F28B4xmNhbf1tI9oYV9bv/z7P5n81NPcz1Pu0ZjWvzF20U/JeZcJNFAuMNgXG
	 XJjXRfABHFNxoqaeO8eA+bt/SdV6/XqmxZ+0/VCPbsqazBjkDNslICK11Qqp7nVO3j
	 4sXsZvlaDKyrnQhXk7/1RYn1r89HPcQJC3d9s9G9YmrXUHR8oDXownGyT1imKeZaL9
	 9P1xnSzzw1enlXfnTU1s1N5g3v9Pb/j6Ox/jwjDNWKb45YZM/XOJe0vMS3GyxCCUz/
	 BteGn63XjW3eHeENVPySsjuX4j3UI13gtsq0P44U2wOxeXx1ALXqgT3l3sC+QQLySK
	 6KZezaIVTE6yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 922616065A;
	Fri, 23 Oct 2026 09:06:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BD90371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5D69400B5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1l9SMX5Q_30r for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2A784008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746388;
 b=O2tiUGzzwyeW+6IbzRDnV1INkbyAF4KuXF+zaC/MvBzjBPMZOdZJwj9UDn60paz3i2cg
 /FNI4wExz842sHKasR4fGzUutRh+2UOuu1O0cWx4DDCr0P+yyK4+UkIZtOoSXt+71PVFC
 TNUlgpLEKxzwT097tzkEyVzf8Ea93pkQyRn2bq8YRO7MPJZVSWAfhS1DvsR5fLwLVKgCJ
 MjC3G3BSsK/OA/lIOLQrGnkyWEgisss7XiaTe6VD4ZKA9I5wYhEQsfUot3JSp94UlI8GG
 KgrlyTkq2DQsRZMtCCcHZApT2czYubuK4cHSzNi5UgdcRc5r+tUTvjWjdKLH3R9R3BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746388;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 bh=FoEYIOEdRjBqfnkvERgsNjd6QY8w8IQp+GugZvE5dP0=;
 b=QSYzjnws56JyZefubfPztr0gKY8DE0Bs2uFF2rI0z0X4nH6JrjotQX9Gp8jzo9cL21eY
 H6sXW7Kpw55siyovbY3XQkKRHdWodf9Ck9amrHUMnTkkeLpqJV5AzBlGXVCLCrhaOpQiM
 mm2Z6bAECW3kXq3cb1Znw/0kHDvDDAwxLzq8ct9cbTEyR2QEXgcH/+HvxgVVwYrVLBUIF
 kCT/C/JGyUqhBR+JN1j/as7v/igidTVxrMBMphoWS9E/MZenGqCYgyHWtzW1dYO0mAqZM
 9T7pEDRqrleLNWfQ6iTWZlGsDbavqBcBYss5OTt6ZeMDA7Hsgw7mjfXAOV+EyWggOWQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=PdBgsg1C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=PdBgsg1C
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2A784008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7iDsgxzCYbvpqYNWpE7eGEjpwLMCp/IVw4prqyhLFBSF1J9JbXTGNk3nbDaN29SUR650WiRs6NmWIrqYiTomy8tJT0SgWAAiYj/TWfWI0wTXnFP5hvYWRl81u7/tJrgq3B+b0oT0MA0EA0lMJvafxkNbVUgkx+VAfrNgK1dLD9CaEvyVvwMy8n/zymxL+B+FSfW/QHquRQYyTbBoMwpp/wCgjdUyezNBEdwqvrjdiKQpMFKyY9EXJyOoY6jvv3bjXMZr7FE8m1ajR+mRg8OcdzlJ8jiNISHFzCq4yUfgmsgHCzLyHyOdWDWGYFI0XVC3o0lNkZNdHwB+wEFg1EMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoEYIOEdRjBqfnkvERgsNjd6QY8w8IQp+GugZvE5dP0=;
 b=Svp1PP49/sCbaH+QcVmJDpmDySIVTp3bgQlQiFuUVFC6b5H1aK80nHZpTSayQjGpY+k/b3SunSQm+WQceySyoGoviZLkM/YbCbOialsAhIoHaTikzHeM45whPGu9wibr/ZX32xW/VwSw9u+gsba9g8Iv76oGtfr10lvMkFNIWT5NbO3spC2fZ1SjF1pvTVl021gwK5zyXT2J/XnLLzDUdqjSwG4f+4DoFU0AeXsPM0yaZkQ3+QiOQIODuHaaHbEZ6xdLTa7VO5KdaZgJi+PUFsGRb8W/iriD4GZKQcMspsjo/Jbmwb/mO5wnujCQ7cqgOeqt/blVZTLuEWbpBZwYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoEYIOEdRjBqfnkvERgsNjd6QY8w8IQp+GugZvE5dP0=;
 b=PdBgsg1CcMxj7aXJPez2EAkrI+iobQ23bVTaeITGaZbsATwYB7iWN2+L1CIxlP6B4rfLaCEIsr8Zj+Eny1jV4fDYekDiw1ObpdCB3IC44tL2FMNBtiuK1v8IOroislYN1QrcWMrI69XXF1LXUXyR9n3wZJptWxc2nbbtTSL658SqJNqNTDdfEkke3jsay+YXQo+FJpgvWMpV1iWEgNSGxvr6AK1uHFMD5FiZPeUoi+22zJ2FPELwTVV27caPg56Kni0AX/cBN305IqI3+rp0fe5RXkdJckswwctTYYut3SgtU6AVl5qAYiO13FDB41MBSqV7PF2gneSt5T/3Lw25IQ==
Received: from MR1P264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::15)
 by PR1P264MB3677.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:06:22 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f:cafe::1d) by MR1P264CA0028.outlook.office365.com
 (2603:10a6:501:2f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 23 Oct 2026 09:06:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 23 Oct 2026 09:06:21 +0000
Received: from localhost.localdomain (unknown [192.168.72.34])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9286C2024F;
 Fri, 23 Oct 2026 11:06:21 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 0/4] binman: Add HSM signing support to pre-load entry type
Date: Fri, 23 Oct 2026 11:06:06 +0200
Message-ID: <20261023090611.778581-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
References: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PR1P264MB3677:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee225ddc-3c19-4a66-3378-08df30e4e86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|261021123027099003|261022075727099003|261022105027099003|261022113327099003|261009223027099003|261021121427099003|261021130227099003|10067099003|261022115727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9SeAoEpylj4VfreJHwdwEbnQGrwDS6bSsntpnAj9j8MZIfW+HRIVGgM99/Q3dmK98dkZJOuKTzmkpa5n4YB7mccWxxioiTvhFr7ROP5t2CAxMhcqhT/Sp3UdW+2f0UaMCk39LImtWTjCMnnBykJDvJVq81vp/FMfAt7KVHin1W4MtLoVbqf9LQW1G7bhJwM1kYkRleV/MTICa/sHB5OzgiGTxnfdXibTsQ8jp6V2pVX6QlJVqD4XAsyXRbmPg6BWKnxMWHxNz+7muVFy/iQKcwYORYjbKRxsQMyTxyQ+cIExnjAMWvkkaM+ojBJUl1Dli7X/vkuQQVRXFcc7dJtNJzKXbxsDyKH7E0CfaFHtcmcKYB0Y109BHesYieRegQ+k9HJFSyk0njEbG1NmoXvDOIPy95IT5O79xESw2P8qgogwaUYmvYpP6E6qXxybsjK1gS7tUZeu2wTk8D/6rf4sek/OTzYgLolfGo3R7MrX2XNP5l+LkaOnfV7Dtm7sfl+AEo6sWkHJTPw0IG/ePSyUaIN6vfUKFB8pygmoDHhAB3py6CiS7phpWknGI2jJNdI2yooK+kGigY8CDxbp+RWpTiXFJk0lnTE+dYeN8/p81gE5/kpr9ERcrODLj47X8Y9RYml26SlS9/nrKOrPCRDSKbcCW2a/kHJoycE76jV4tDp22Mb4TA8YjU0wcSQmYmag
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(261021123027099003)(261022075727099003)(261022105027099003)(261022113327099003)(261009223027099003)(261021121427099003)(261021130227099003)(10067099003)(261022115727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wCT2AcPvIRw65ySeXgZbU89x97Ht/dRV7JV7+hAbAjhPgbzhZ6zqw/+W4wnOAltpHVEliTrToGDe1VV7K8afyNvlTaiHxRxtJAoWzRvbSdFkIfqKdfJaUz17WSrpp4d2HvGdbxmRnbIAY0aGEE3KaRGiGxkcgeS160VgzLbG4fW7/iRQVG284wOT1XiC9FOhOtt5tykL0JQu0M2u6t5UQqh4b0OMcdNPJ2s/LRrEfDFcSpZFdc0W96/JlPo4IKHKipzil6dY7ZN7uxeD9u3lCUhvAgb7jghctIpfThcI1gacjn/JjYku1MkpwvzNLaxQUd+AWRqnjSsyCYOnw3ZajTKDFZA7Hh3cqPzdS+TFUUZX7keNIRjp2ZlpXPpNHGMXQDnAA0RhDkHi+yxC/urXtAq7oP4G6k3MijubM9vCv6bZKDuQuMJdtzwhns17xqRv
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:06:21.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee225ddc-3c19-4a66-3378-08df30e4e86f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3677
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pre-load entry type currently only supports signing with a key
file on disk. This series lets it sign through a Hardware Security
Module (HSM) using PKCS#11, so that the private key never has to
leave the token.

The pkcs11_tool bintool gains a sign() method which drives pkcs11-tool
(RSA with PKCS#1 v1.5 or PSS, and ECDSA). The pre-load entry selects
the HSM with a single hsm-key property holding a PKCS#11 URI (RFC 7512),
as is done for FIT signing, e.g.:

   hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";

The PKCS#11 library and the PIN are not stored in the devicetree. They
are passed with -a pre-load-hsm-library and -a pre-load-hsm-pin (the PIN
may also come from PKCS11_SIGN_PIN). The library can also be given by
the module-path attribute of the URI.

The functional tests use SoftHSM.

Changes in v2:
- Merge the unit tests into the pkcs11_tool patch and the functional
  tests into a single patch (5 patches become 4)
- Replace the eight hsm-* devicetree properties with one hsm-key
  PKCS#11 URI
- Keep the PIN and library path out of the devicetree
- Pass the PIN to pkcs11-tool through the environment, not argv
- Read the signature from an output file instead of stdout
- Add ECDSA support, with a host-hash fallback for tokens such as
  SoftHSM
- Split the integer division and key-name fixes into their own patch
- Check the length of the returned signature
- Extend the tests: PSS, ECDSA and many error paths

yan wang (4):
  binman: bintool: Add PKCS#11 HSM signing support
  binman: pre_load: Validate file signing key
  binman: pre_load: Add HSM signing support to pre-load entry type
  binman: Add functional test for pre-load HSM signing

 tools/binman/bintool.py                       |   8 +-
 tools/binman/bintool_test.py                  | 497 ++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py             | 339 +++++++++++-
 tools/binman/etype/pre_load.py                | 238 ++++++++-
 tools/binman/ftest.py                         | 241 +++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 +
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 +
 .../security/pre_load_hsm_invalid_algo.dts    |  21 +
 .../security/pre_load_hsm_invalid_padding.dts |  22 +
 .../security/pre_load_hsm_invalid_sha.dts     |  21 +
 .../security/pre_load_hsm_invalid_uri.dts     |  21 +
 .../security/pre_load_hsm_module_path.dts     |  21 +
 .../test/security/pre_load_hsm_sign.dts       |  21 +
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 +
 .../security/pre_load_missing_key_name.dts    |  20 +
 15 files changed, 1520 insertions(+), 14 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

-- 
2.43.0

