Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bquGMo5k;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=t57IKiIV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2504F607F7;
	Fri, 30 Oct 2026 14:42:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8NyUuY16iHJ; Fri, 30 Oct 2026 14:42:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36B6860A73
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793371346;
	b=Sl1bb+LsWVeU3K3ClmNvED5GTEL3C/HExG9y83T1kyZGvl8DRmR8SwUyfNu9kY287rJ+
	 cGsQ/3rZ9d1QntgcdH4nn8FaKHucsB35ueIs+kZmi1fMnwkguybQuCyc/QA0UKLQFS0X6
	 1CTpWOluPplV52KJrpiuj6yLFSm9/4nOnx5oMCKdaYmF1/rANqmsW1wUsmsSvKqskshC0
	 58SU7Q18GuMzW54sSTmoaID7+8Yr9WbJQhdO2LHMXF+WZnYEx8f81reOKl5huB7azn3o+
	 LURibFUbaffNzw76Do15QkeCxV485nvGMqe6unuza19ipCR8OZJz/2N/uHAhliIR6lw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371346;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=3eoEVry9y6p1GY+y31GOQV5jXEh0nOURDESiNL9FI2Y=;
	b=te8OQacVJPVfdhrxwUNBBg9MtM17CiGG2JoeJSVeY2ln8bQLj4AYEeltAq134BpHuVRj
	 aNBGmf398fJjjIJ9B3TYAJpZGAzTRfTBZ+1ZlruEyZuuyBUNj0PLm9RxFXUcEPvXpGzkc
	 EG8kQnXe9ZBbFO3kdW3bW4VTjBICdgMTUZfZZxVLBtSeEMJ2J7LnTv3EOZomJCmLabgo8
	 XAeXMy52qYf4RNUIheoAEOdIqqsGiH8OtQ05YfhODlb0Ua/oj9wsQUbN10dET0CjmvRw+
	 8cTYPfMwxtebiNwu/I/WcvHdLqIrtxvsBTjrHEgc+Ex9euMBmUddqLzFXKiJ7Ai6+iQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371346;
	bh=3eoEVry9y6p1GY+y31GOQV5jXEh0nOURDESiNL9FI2Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bquGMo5k3J5LRqiitTR9KRXuG9Tv1CXAUxvS9d2eVL1CvzyocRm0QeXWtLTxSGRSX
	 xbnka67aIwS5X0pmd8YGx4tGJN6b72bnfFmEdE0Q0yIC6wQylbDOsNLjTkgxYIX7kx
	 K5sp9NZo7dbvuOXZMi6+CgwWZON9gPGlI0i0I2daui8EpcFAAx9hApBDVYbJQaoZVF
	 HcFrQBuy7Iyyax751UAxc2a+IWG8eAIRmHmROEtUVy+621C6aYXh45p3vG/jHnjmIt
	 +Xa2j56CNMRLtiSm2/wlaBUl+8kKo9sx6v5LigGmowiyITPRQKuoNCLMnfZq+5Nl6t
	 fzxJteEem2KFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B6860A73;
	Fri, 30 Oct 2026 14:42:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A3DA529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B8CE40535
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMkEi6SbverG for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:38:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 44687400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371139;
 b=hwUB4lTXueu5wXvSA+Div/1ylqqzAUMSZMXSvjLc0uBpPnK6o+vhbRKHqpYoNxS0zOGJ
 0MqsO4c7iAsKBd0F5Rgs84VdFEzDesKXw0y7HFjbpNBupv/IUWDqfYX5dGqI4RatlRcAg
 OighosJixcZACY3pAHI9xIfXKc+UdmiiNgriAIWj4NFySdffOdblCbqhWqfxEHaDJjkYl
 u7Yh9AO9u6wJgVGixxEzTr1Hqr5mZOM4JfYRf84GSYBeHOG21h1535mxZK9A7SEVIicNc
 QJQ+8wiLbgMj/DoaIDpjb+Rj3N2WCyeoOeZ1Fi8B/zhu8AzqpnkGOFwbdw5TICbbDUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371139;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3eoEVry9y6p1GY+y31GOQV5jXEh0nOURDESiNL9FI2Y=;
 b=Hj3In6BQZI3EamAXlGCTIIzXBtj4Rr/7+VBjWgQ3+U9G4PDYGUvJ1h0uw0X7ls9+aj7N
 MV7sbYwHlfOMUucXArhavwXG6CVYUWjiFE7GyTcWY+3WBW1WLr69EAWTma2VQGVQqyoHm
 PUB2dG6kWPJoZHfqX9L1UHXgBHYfZ0PB0HBrSueQZ7GLGAMZ63hbXWR32GLXayqAwIqdk
 T4KEtjCJ43xxz4KlOFv4KSiheaM77PXTsK9meL0ET8Qnev5OPob8RzRLcWiShBP8g9Sxq
 EOZ9StynmQwUcOSi4Xek6rKKC9CS83ad2hsjQBeXPwQaGF43s1s1TqmzRQCXNI9eDCw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=t57IKiIV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=t57IKiIV
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44687400D5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mrz9/eSuZeX2+pFp/MAxxZZDYgG64UFMqr0QGQ50g2VSL6Xe6DrobEr7tb6Cw5tR7y3Q9MP/2EWlhuzA2zQYxZqECTC6grBlwMakgxut6FdgANS+owKvsoeFoRvmWjYt3SrtUScXq6LCsiDGDKuAdfe2Yfxh0Bbo4O0AnqzBitbQqBADlR9+Y5BVVPFcWpg7WZRzswmIcVH0oPuhvJXISCKTxPm/QnZmYUJ1nDkDKuh/+ey5B3zQ5Unu1dyMfeFHx1Ry/f/R2AegqRlxG5GUOvw814yMyI7WxVkLT6KBKiMLiPjvRpYDBBFanuZXwz5bWw409TjA2tnBeFZpnKkwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eoEVry9y6p1GY+y31GOQV5jXEh0nOURDESiNL9FI2Y=;
 b=EduSDbsQ7gMTU8VCTaORuPD/1vbjWb+oE1ygPFiTBMOasjwzG2Hdp6CqyosYEFnrGfYT6CYcbexczrKKuzoAFWacdgDVh3McBguzv1ru9eqJs+4R58V+Z1l1PmLQ3lzkEdxUZL7kQcT4rGUiwbEAKe2KsT3mTziXpsP0Jn9VEu74aVdbAEaVmVmMXxaB86uJrA4uhMK7/SleiHdcugOGxB4xjLwnveTKdJEXkAX02u2V7HQe9x+PuCp9plMzC9HZjkGpNE849N6Uxr797q++bFp2EPr1apUt2U8aQh8Rsmgxic8rF8HSZgjGn1/xz6I1DEvTK5tlOPRnJy8yMTbTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eoEVry9y6p1GY+y31GOQV5jXEh0nOURDESiNL9FI2Y=;
 b=t57IKiIVGxd5T/u5Mjuv/4SY+m3mPku6oGt3XXD6vp/ySzonp5++yWSsCi0UTJvSitNAU8fNiY5dSDO/+FneoJnHIafl/UHe5dc0fco35VOpXmeuvkgJ9TW5y1rbSg8I3dumFocPWwqEd0Ijcx86iwjv1YGR5fDUY9QMVctjnw75D355lAoMcIZCioxt5T3gW42d+F0XxnbQvGpajGq6pxOf69rzk9NUg5hOM9J6NVLnxj1b/1MwQZl8F+lP/yKc0AHyWhRJrE6BWcnVyCaPBu3R9ZKeGo4RsOVcadnVRAAjZxqKm+xYu9Qv12JGuJc5xlWLAyOFquxYfnsDyFsR+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by VI1PR10MB7733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 14:38:52 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:38:52 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 0/3] Implement the efi timestamp protocol
Date: Fri, 30 Oct 2026 15:38:40 +0100
Message-ID: <20261030143843.467968-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|VI1PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dee788-6443-4ecc-73db-08df369384b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|10067099003|261022105027099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: BDO5VXNudk/emywtrkFvFM3viCU4g3Jk83C9GfU7/mnOGMaP6CsI+/1ybbdQ6+8S60TQRnFL9nIAIDmP832VXf3zpnmME4+2ZP3c613RPh58xuiPJGGbZ18MlJcRrhTyenhdgUYInKHtsCZA4tMJxg7NZL3Jrw51fQKeA1dnycAGdkjiODp0zm6enorVSj9u+u8gN0d+s+bCBWmjdRTA9HfzWKSQT+qN5vuMtSM+8XAu8zRI27kljqLYGnfc2GEeuj2UePe0l14AWBWa13Ee3Dy0KnL204cS7H5AYr/PSLMOQCqdHFgBrxJS2r1UgyuLb2qFkexNqWEUH+ZN/BrW6QbPJ+oGGeh2XwRf/IA36RkBGndoM6dhnBMY71ZaxyYgmmFFkdT/ZzPeWW5rEiF1DnbdVFWyl3QAiqDLEIvmuFBDgIdKsZcEqwr4BFNM0fpS3VnljiFfu9uxV54UnYiUzbezbp+xQJ4z0vYge7bFdeL2F40PoUlQch8LDyxiexnABCLt8e974gem41PGlwtPAiAimT2OJb4iPh3yWzzlsT8Tup9UwcYss6+Hnv+DzD04Jzp8pb1XD1s6+rbIcQBG3X/sLySo7QVX5c3GL9xSbzCGoKazXitHyn12HnaDYnc6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(18002099003)(55112099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FbTxBpOnBZhdM1U56siEDKK2upECUtBPCqX8Yp8lJJfkmmGIC800DVUSxdr?=
 =?us-ascii?Q?gFFZI5H9/gbhkFbqi1gMk9JNk2zkxwSVZ7ZeU2aimAUTBiFfeEWlNBR69H+2?=
 =?us-ascii?Q?1SqOjcbBKfuiqLg7hyELjAyHpn0cmCUmUyCEQARTeycpTKdFRxf0b/Y8h/BW?=
 =?us-ascii?Q?MM0ub2BoB7rmnBmgHyi4bM0ZyBr+AsoPNVB2Zy0aetAVqXLCbIhk6ZGGItRb?=
 =?us-ascii?Q?m/ZnzbTkN5eYlQgjSmvA23nFNG12F7O1KnmS8uf2IYo/WlM9NDoduXYH6Lp+?=
 =?us-ascii?Q?iUOGzcjTPL2n0bcdsDcxWHssKW1nQnUMetEIB+nEpn5K+irMkg/ND04bH9Eu?=
 =?us-ascii?Q?Hp/hB1m3FPGJvPZhnn1cVRzz6yRpf1Yx4Q9MsZNXyuA+HyLTHFnXOKNshwT0?=
 =?us-ascii?Q?nzTVii7819PXxsQJ0mLbXoBLPHSQKzQRQaxky8NdVzLeaalqKj1bEbu8cDn0?=
 =?us-ascii?Q?9P9B7fwhhaJW3FaLMVUGPH/+Op3OEYwi4ap9zKvofJNEAx8uS3Uz46km7vit?=
 =?us-ascii?Q?o4IvPAmT1RhEWRpI4WYLc8KXML2/ZIrUs9qYByNOP2Epaf5wTLGpqS1kCxd3?=
 =?us-ascii?Q?epWZ6yw6t2Q6RLL/r38nr0Vrb+WYoLlL5FOJjGF7Ipk9hMscEeUMvT1yl5YI?=
 =?us-ascii?Q?N8x1wnECAxcep02zVvZokUN6AGsRobNinjqMhoFc+KyNt6WTZLt3A7DpjYMA?=
 =?us-ascii?Q?CkCC9Pd539e872Szc1cigCtVgC4jCbjvNR/9buuaYC+O4L256RhJLBnVzaI1?=
 =?us-ascii?Q?/wRR4PHQVC1koondPR3pqhifyiTeqjUGtuWHdIFL4dyjnOwtV3GAU1i2nQHD?=
 =?us-ascii?Q?zXkL5X+RckgZUIaUIVIhf33mqQsDropxkey4EHhoRYJG/cJkzwRKacZgrRgF?=
 =?us-ascii?Q?ObqFirvBy20Umpdy3LyLGd/poCQveVuq+gNLuLeux+X9+oB+xbcMQ7qAW8hx?=
 =?us-ascii?Q?E8sfWpAElshnJLExho64ey/WRg1nawZfYAnDOUjOyxNtGHKqCeEIXAr3Wme8?=
 =?us-ascii?Q?Dvp319I1oAsy1btov+A/ntHLkezoZsCYXhIjm3VjO00JZ3+lb5ZLpmBTjLJs?=
 =?us-ascii?Q?eCW3TzUuEJ3rp0erVs8rteMgxpkudA+cMqT3HlIn5aOTQnxPR4Gv4on/89Gp?=
 =?us-ascii?Q?yjbw5t8epu+qAOEjiyuuZACo3CJ8CHNXZW7ULOtbVnuu2PGI0N0i5snDwC10?=
 =?us-ascii?Q?xUPaJhhXOz8RWwTsGtxpSKRS8tTIQo8v5SP9S7iuslvkRaqIAawHwcArM851?=
 =?us-ascii?Q?2BM+w+nFxGdQGWW8bcW/fxSVD5GqDLiioulo30nIFan0iElby5JuepSM1gVK?=
 =?us-ascii?Q?uQ2N3s/pT5dgN10m/2Mi53i0S4ZQrL1DW1+LaUmia7/xLvAuJBDkv9oMykDJ?=
 =?us-ascii?Q?KOB1fpFf2Rp1gGG3brPzWoyTHZgk4RbPeJuio5F++7HwfO2VE5nL+DGP0PoX?=
 =?us-ascii?Q?iAO4Bd8RFHgYKv+1utzpQt7cMng1hPdNhFXruWEqVx4nPgaLiJm++OoQ7C5O?=
 =?us-ascii?Q?S4R1dP24Vjag6ijC84KKU1ewIHItYbBLmQEg6LIyju/4Io91+Mu/rHJ1UlQN?=
 =?us-ascii?Q?BTKmywrE32uYlNx+vCjcLKlNkh+nYJ8mydKQ8V6pwAH1O8WtjmiHhljwRyxA?=
 =?us-ascii?Q?FsIgLFZL3sx6hD1A2PInVJPNjW54AUamGRd6SI6DBdSE6vgQuOOPWKu/mmz+?=
 =?us-ascii?Q?sGZZIa+VXzG56sZ9TQ7SWksaUI77H2fLeEARvW+r4ZWS6BhaAzEAuTV6QIB3?=
 =?us-ascii?Q?K5Ii+a7n8zDzJu0+lF6ogE8KWArgpLLPLqNI5PLg9GWMlsSQ8dWVmy6Psy+i?=
X-MS-Exchange-AntiSpam-MessageData-1: N822gPrSe21JhlkBop8zprKoCmh+x+5KVDM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dee788-6443-4ecc-73db-08df369384b1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:38:52.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGvw5lxK0WeUPMiWjxfpdgrJCahvNnvliGiU0th4JbVqTOSReDESycp5hf0GXjAA5Iw7S7u+GMGP1hymp3DBuRDlUxhixhzA3KYXRMpzgsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7733
X-Mailman-Approved-At: Fri, 30 Oct 2026 14:42:24 +0000
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The protocol is used by bootloaders to obtain timestamps from
the firmware to measure boot delays (and where they originate from).

This has been tested with on the corresponding efibootguard series [1].
The corresponding EDK2 implementation has already been merged [2].

[1] https://groups.google.com/g/efibootguard-dev/c/U0SED_2Kaok
[2] https://github.com/tianocore/edk2/pull/13343

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (3):
  efi_loader: implement EFI_TIMESTAMP_PROTOCOL
  efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
  doc: uefi: describe EFI_TIMESTAMP_PROTOCOL

 doc/develop/uefi/uefi.rst                 | 13 +++
 include/efi_api.h                         |  4 +
 include/efi_loader.h                      |  4 +
 include/efi_timestamp.h                   | 35 ++++++++
 lib/efi_loader/Kconfig                    |  8 ++
 lib/efi_loader/Makefile                   |  1 +
 lib/efi_loader/efi_setup.c                |  7 ++
 lib/efi_loader/efi_timestamp.c            | 79 ++++++++++++++++++
 lib/efi_selftest/Makefile                 |  1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 99 +++++++++++++++++++++++
 lib/uuid.c                                |  4 +
 11 files changed, 255 insertions(+)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

-- 
2.55.0

