Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A3606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JL87g3lp;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=HfORCFUS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AA7A8124D;
	Fri, 23 Oct 2026 09:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLi_MexnBxz4; Fri, 23 Oct 2026 09:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50E61811FB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792746417;
	b=J3s4FZ4NkNscK3l+IIi3qEz26p0ca1EUUGvEjiZtt2T0xRHya1hDSnxpEMVxAmeZiBGR
	 6CH3LOKVyBc1+vL63LkeyzNHzRJU0YjgmNHQWhnnFXrht+Xq8dxKS0Q2idmBAxpnaakFR
	 30A6u91D5iOXheN2JMuQg8E+w84mCVErqALB5I11uvbXesJ7yYfA/ClDlFjrz8GLgSMTt
	 31J/FFjjsFs5vzGj0dZrQhU9rG3dm7YRGiC5A+QKc+tTxK4KIjpdN5YZlprvHYRAMz/KH
	 w/7IqyZ/B3h9Ep2nXBUSs/ofk8jcfPCzxloMjugQFYvduJu4SM9aZ4HIQqNN2ZRXWlw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746417;
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
	bh=6LTi1YDyG4ifuYnSyKH+n2LU/JKcxknEvQzaU9RGmxE=;
	b=nY6qRXDck3WBOKtEFRw0Qa2uk6eSMJGhQqnUEvx3i+EgFeD6CnwT0K70Xs1BYdXmtqaj
	 DTN01GMueVqd2wyG4iAGqrJDShFVrh0L7qidE2jmXH/VNtW9HOe6+TU5uGI3QmWKajBsE
	 2Kq9rm7iANBVyPwbM9R+Vs6zyFlxgUiuZI0ev5ZXApJYOju2SrLg2AHVrIh61P2eTT+Cj
	 pJyXOLgGr3pucv2NBsec/ZFW60s/LSJ7RkI2Tjzbe9jZG6j/kmaJBrEULbsbl4VBkVhFy
	 DfNHs8riMF5MF5qBnH0tp36ZA2mLXdLvcrqR5zHgiIY7RTknyOa8/kQYu+FJtB5qKNg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746417;
	bh=6LTi1YDyG4ifuYnSyKH+n2LU/JKcxknEvQzaU9RGmxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JL87g3lpCVdFC9G507CcXE95CgAirlBZSTJioc11LGYQiFuwf8WeTfPZrmiDTDWKU
	 fRZ4Zm8CWeWiC74XpvN/1Yi367JgmW5anctq+kaqXRvvxqm/VZDHeJH9OY2E2x7SGS
	 C7BuWXDEKzG9utJUqRR0jEyAyQMa/uqKRIg55q9s3Y/70RvdBHKa/AAKu+iINIA9oe
	 p2HJfiQLSuoAj4pX76FzpIqhjVpTJpmlfq3Q7HxAl6Kvh7cKtoV7wwfsJhdTj9VEF1
	 hK+EPq45Mxh/cq5wuMiJD9wkdWc1dindzcJ6omgPQw4JdJjK7yUmVTIG/dYz8K6ivk
	 nI2kNm5lKPlFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50E61811FB;
	Fri, 23 Oct 2026 09:06:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 236A9371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1431B60689
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bEoKkETQQoXS for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F25C60668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746415;
 b=dItkNPeLoaO16Arp1GvRUSempTrMJkYFiG3h95iKgvz6eCwh/SLYJuCkUW8A4sn6ujBU
 kNeyPDR6DEGqTFiyHFmNzUThheXQXlvltFwwyrlQhomnKEThAyCNLePrZQqFLATgjZg3c
 IWrb+NTIeGa1iaCvV4HdaiPHpwNawAn98BTYZSTrOZJmQq0qhmnzgnsCdjyT45IjXyAWU
 UviB7gtE8tKjiMnYoqi+EdMKU4ndauRtjdC5sEHGjpxQI5jLA57cbA5QXjpblsW0eKbgs
 kHRzupGpPC5bK6HPWYfyzf2PJJnDUird88SDQNpoYFYW5hhN5DG62pOpberu+4/D7bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746415;
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
 bh=6LTi1YDyG4ifuYnSyKH+n2LU/JKcxknEvQzaU9RGmxE=;
 b=B24S9Sf70B8eW2j1acQaoDNQtIEEau9X9x3FU2o+IZBYrEOXmGyoogycflbv0WreWLks
 QTF1v+3c+Wm2hQKzQniBlYM0di/JUUdRivxB5B2MO1YUED2lxNK2pBrIGi3CHaRHKQiel
 ef1bq+VH4E+riNnaM/wut3oxbfdHBw2R0qM5G+OVuC7tFs7zZ9PNJXctmgIXZjdnJvzSs
 Qic0YttrEtK+MniTyufWDnNHgRgYPHH5P/sjToJKvgO0vU5XVFhYMUnXQW4kRw5yH4F+S
 y/KEKwZnRsWKPR0fZgHq2pgaywQjnP67ds/rH6PNSsSzdcay+l0qIWbveYy/haFUKrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=HfORCFUS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::1;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=HfORCFUS
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F25C60668
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGz0bWvlkg2ofaT0kZ1WfxJbXU3a8t3FXPAR7l75NJlCjZPcl3uynbYeg1uHV1sx0fqpWEF3E8SMcgqBGCXwYvopUNdD8qQOWYHtF28zOJHbOqPghz3VFhhdBh5yPgmQP/sM9zRpV7DdbrJ01XuhumDv/hy1zKiirNLhBiV4MftmktkSjMwoIfgBPWvmr/IKOgEC4Jo2Hygv/gG3XvrhBxHQosnMyaUecxSu5yI9WzJeCrWfGITEUOTfFvZoQHsOJfmjm9JIgWLnYqT9/+jeI6/PnlWtGFs5J5TvHjBTNf1buzBmxqY4+D1Mce/Sssv4hhuXA2pN6nU7b0qeIMSlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LTi1YDyG4ifuYnSyKH+n2LU/JKcxknEvQzaU9RGmxE=;
 b=Mk2zuKMamxbxQ45l6Jr4A5I3F6QuKjCmU/2yPCpdBwEd1Rxow42neSboGBS0qhXp+aC46FdH/PnSoMB4BuLVDynHgVe8+l28SvG/9zVssyL8dNvri5xPMX3aluYQHDiQervBq7CP2ECCWTnZIlzOeP+Uww8BeD8+JPV7qZSxiy6twpdOXCkbcXhZaxo81aPxcKwH4V7VqXBS7+IRX0MNSUDMXnHFrUdwkzMbCS3AzPKBdwm48mDkSdRNGWa1/mkPVZDNZBYY7PKqRFWR6ejF+lkcF+MagMzDhq1wHVjvB2zAx1PPPF+ZAnQxSjdECpQQc5G+urUQl1w8bFTrW2OghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LTi1YDyG4ifuYnSyKH+n2LU/JKcxknEvQzaU9RGmxE=;
 b=HfORCFUSw9bEGGYz0uxwVSSjQDzaslZ2ikxSr3VCJyh6wv0C1IFi5YAKG+GzdivQ9oaBuYFjbaof38rRGtGGhLj18sjaceMto1jVLioKdmM2dCmSSqf9m99hfyuH0U/b57js2+ur3CFEb+MaUl5l7CIxONmqzTtbMYRJ/RZ5upDvD69fWDV31WlyOEVqI9G7xjo4fR2wWGoEXgzfIO7o28p9YDlT+OBQa5UUfRc0dX2Rf31crDp7f8OKnKIeIVW4pNeOtHn6DZRrhw13MdiEn+F/SLxKKMmPgEtrkWISMIGyNuq83c/Y4QcSSQs8FEigBHlMlKGnS4YKHwQzA2kFTQ==
Received: from MR1P264CA0142.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::11)
 by PARP264MB6571.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 23 Oct
 2026 09:06:25 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::87) by MR1P264CA0142.outlook.office365.com
 (2603:10a6:501:51::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:06:25 +0000
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
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Fri, 23 Oct 2026 09:06:25 +0000
Received: from localhost.localdomain (unknown [192.168.72.34])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4644620078;
 Fri, 23 Oct 2026 11:06:25 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 2/4] binman: pre_load: Validate file signing key
Date: Fri, 23 Oct 2026 11:06:08 +0200
Message-ID: <20261023090611.778581-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023090611.778581-1-yan.wang@softathome.com>
References: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
 <20261023090611.778581-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PARP264MB6571:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42eb0958-ff43-4a26-e957-08df30e4ea9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|261021123027099003|22082099003|261022105027099003|261022075727099003|261009223027099003|18002099003|6133799003|56012099006|10067099003|4143699003|261021121427099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: fvQHvOPPWyV970dO3/XFkmt1WTvMIf21975tRRJQ1CYwHjK4oKq30IcgxRS0t+TeHUvL701Aec2spseAqZClAFzgQbnjhFfmOnyHIM8TcQS1rBaOA5iX3KfYrHL5bMJox3Q8l2AU9OZK7zSU1UnyrJCVZuICwzNEvcPUipxoelDy0NiPPpW4zlxhav5HtUuI1zXVn7S3sJjh4DfK15MrsxKJRkSx8tnCoUQJ1zrS6KIRyaYjDimUYusLMXCSZEqEYqFcyzXzY3ms1HEdsiEiBrYh+Czb65CDYhVAMyHSBHfe3ENH+M9oy9dXrsnT0OPJmyLtyvkoszUKnDn58S8bb3f/7i8x4uNjOk7IZiiusBsmhsG9uNvK1l0UcMGRM8hxQeBWNSq8XJlRvnfjxHu8uMpK0wU1Zsp9iq5EDrMcIs3nICoecfNg3geDVzGu1ABgsmxX9piGeMqu3jKtcyCwNvI7qw514Fw595c00l1NVv20M42HSqu71KfVpG1J/VBw31qJ4vpjZVwESPw2t4epxffj+etGtixOFTWR86HfeiZMDI1q2Lcfn/sazOwRzOER1+QAfOhjhP+hctG4TuTHaYRVNIm9AZND1Bx+4Im0/T98RLEdWz500MMQTbEu1gz4JQLiNzkJPzH+JGhqP1MbvM/WHmltEIoA5nQ5FmXO4i726AbZHbSxipGmMaGyJHMCYWTUwQ5bO1Ilv3ClMM0fTg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(261021123027099003)(22082099003)(261022105027099003)(261022075727099003)(261009223027099003)(18002099003)(6133799003)(56012099006)(10067099003)(4143699003)(261021121427099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80aRRdD4G/d9A9Ku80UFrtmXVqgytb8aMqbKuTvY//KOaqM4itKXeK4eBDLlBR9IvKmd+3SBrHotxF0TWxolh2OBhwfM+34XDNeigAvi+oOm1rqOcVnIuWiMfubsWWWIpsNRqizxq2W22xI7JQvKMEcFe/V9rt+IgDk0i3FM9RQsdHZHAz7Ptol81nyOVIQR8zRRYq+lpaT/8dnvhVC30XnXMBMAbuorB0bzK2MjwsGZu0fseCggBPYA+0No5niaaOUZ07uZ3q1jk3GPODaFBBbcZGt0TTqMif9zZpNzHb55H0rokcrXRBIqrpsiLR+YzPUAfTzU/nwFVmCwWc5Vycl5MF06LTrrmYfIUP3rnBV7hbL+QLo8XsazXiidN3UtFIBqsLp0B2qLZR04BRvYSr7DavSeuZYch9pcmUDDXa1+ZLydbd5qzPf6peQcS/P/
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:06:25.5786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb0958-ff43-4a26-e957-08df30e4ea9a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6571
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use integer division when calculating RSA and ECDSA signature sizes
and reject file-based signing without a key-name property.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v2:
- New patch, split out of v1 patch 3
- Use integer division for the RSA and ECDSA signature sizes
- Reject file-based signing when key-name is missing
- Add testPreLoadMissingKeyName and its devicetree (moved from v1 patch 5)

 tools/binman/etype/pre_load.py                | 16 +++++++++------
 tools/binman/ftest.py                         | 11 ++++++++++
 .../security/pre_load_missing_key_name.dts    | 20 +++++++++++++++++++
 3 files changed, 41 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 7890c1c62a8..49a63ecaafa 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -24,15 +24,15 @@ from Cryptodome.Signature import DSS
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
-    'rsa1024': 1024 / 8,
-    'rsa2048': 2048 / 8,
-    'rsa4096': 4096 / 8
+    'rsa1024': 1024 // 8,
+    'rsa2048': 2048 // 8,
+    'rsa4096': 4096 // 8
 }
 
 ECDSAS = {
-    'ecdsa256': 256 / 8 * 2,
-    'ecdsa384': 384 / 8 * 2,
-    'ecdsa521': (521 + 7) / 8 * 2
+    'ecdsa256': 256 // 8 * 2,
+    'ecdsa384': 384 // 8 * 2,
+    'ecdsa521': (521 + 7) // 8 * 2
 }
 
 SHAS = {
@@ -199,6 +199,10 @@ class Entry_pre_load(Entry_collection):
 
     def _CreateHeader(self):
         """Create a pre load header"""
+
+        # File-based path: dispatch on signing algorithm
+        if not self.key_name:
+            self.Raise('key-name is required for file-based signing')
         hash_name, sign_name = self.algo_name.split(',')
         padding_name = self.padding_name
         key_name = os.path.join(self.key_path, self.key_name)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d466..d4522e905e0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5981,6 +5981,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
                       str(exc.exception))
 
+    def testPreLoadMissingKeyName(self):
+        """Test file-based signing with missing key-name property"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_missing_key_name.dts',
+                                entry_args=entry_args)
+        self.assertIn('key-name is required for file-based signing',
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_missing_key_name.dts b/tools/binman/test/security/pre_load_missing_key_name.dts
new file mode 100644
index 00000000000..262219fb6ab
--- /dev/null
+++ b/tools/binman/test/security/pre_load_missing_key_name.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

