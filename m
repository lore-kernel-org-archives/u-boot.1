Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E14606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EyNBHlrV;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=KdKLf8el
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 061454055A;
	Tue,  3 Nov 2026 02:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSG4OPpDtDZb; Tue,  3 Nov 2026 02:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A2BA4055C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793672307;
	b=eny7Rx1LRWvbXegNShFYcD+TJGssB/lS2EJRFr5BGwNyx14MT/qwQRWo4KWh7CStu31s
	 f8hcboBsgs+JStf0mZcgUgh0Qp+cyIfzJYq6mjI78VIYqRclGC64f7kE2S2W2fHwz+3/D
	 bO8mrJhCGg9BNd8GApctqbqQBWU7Us9WoyQ76O989CisPQOS2yAdSt8AIrCEo1+Kb+9WN
	 NMmDSjEDE+8CWyW/+pjFPBwckW/wT1CaqAqlJo+xEZh/ciIJWLBlbbBbxsc7cTQSzEbg+
	 hvrxK7bFh4uBP/EJUesrZC8lKk6WpYfP6M5DQg9xdKCs2R1wPX8CHek7Bm0RuLhxfzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793672307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
	b=jIIZB9STTPRTOWs7ISorA44zd2Fs3NzJqnWsqnurdLr60JVpvKSb2oIclr3G8Y8BLGFD
	 kpIkSwowDihW21uGC13P2+gKDUtoib5Awk/HdyCbF14rRiY2fitOEUfQnnzQq9umEkJuS
	 KxW0nwAyzAeTwZBBhk6ma5LvpXDJTwmcNfg9+BSB30854R1H0IYdQrhmtFLvjAxWsxRKc
	 o+tbgwAMH1Q+WkRCHNvlUvwkt4lKs/nuJZzjK51h+bcRiSSDJq/FPxc00Ka3DIfCQqFkM
	 T5IvPLMPzP0wB/x7bTXRIbgqDwNuodHN2pXYJK5Rp97m4KNuS7aEAFk9tH3MI/y8rCw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793672307;
	bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyNBHlrVc3aFFrdjSBTaU083RYvXTCnEg6Kse4of3hiduu2aJB2VVQD4hsdP3Kzox
	 +wIgt6dvlCRQSnNsWTXTMcEWR//+E+TYfg9QrpgeasFfZ+JvXauBuF4EnxCwtUYMec
	 J2CGtpGnpnPyswcq9PMK1ZENo+2AUVpejXsFmb74zxd8xydCkm4l1SJh1Xj5jvl+jV
	 FvVlH2Iy46BjdhK+GnBrG9OJWcoYMpH2Op+mV2aUOx8CRXNtyVCzCMFNKpzAqi6j1E
	 iQedhyXCbYyH3vZl0UI638z+qJub3WfyPoJ9iq4X+QP3grg1JVVplhubujcPwUMEGv
	 FApc2Ri3oN0lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A2BA4055C;
	Tue,  3 Nov 2026 02:18:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7976411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B2880D81
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hg8HELXGqyby for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 02:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D8FE80A9B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793672305;
 b=EuGPq6dLTSZdteRkoG5XEDPLmqKXqNWyWLzYq0NxHT/+LsQ9KB3ci5fgvBU/q1B5I+/d
 Lwm609kZ7MKsSTmFoi3LHbS8mf8hbVUaQQar9RBf7vGYZGnmR+4hrd8VZXpwGtNP613ba
 T1twjJ8aF/pUkWKKyeEfmxsT95C8YM7N5XO461JkIwO+BkKEE5D6sr3KV6Ds+fuzfPFqc
 epdtIjK9IW8PQ6sJ26obtQMEGgR2RZzaH4JSPw7uj5Ir9ejNZLEAs3uKK9M5cMHLlORJ0
 gaNpTv7fKsGUXeLj4TFbxSIp9EZjOkCW00bcZmkMMV7TOD47RB0bTOUIbzkQ5v1JvCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793672305;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
 b=ju5SqbEn7nYSs7MsugqhKQfxVPJbKwW4MQPieDxE4EdzAY8SimHbR+vhHkv+ksMseWro
 32+8CEI0Gxd/uWTNxf376iTez4W7m8KgXkzzLMY7h+nM90h474HzUP535wRfWawSRHyT1
 JzF9qiu44BXmqOUGGsTNvnmElF5OM6a1OlVfC1d7QHsZiqr9FsYVA+9vd3om0vMFTz033
 rjMbwl0OFAqZ4JDUwuez3+BgIcTVjPH8VeywVYK/gxO9iEpFjSSecs/j3IgcjnjU+WGig
 Q6U6t+vH0dzUaG6nxvH2udCHfFZ1i0glHaFH5DkrbUO3zZq3kjqnGb7iu/d405fARlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KdKLf8el; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KdKLf8el
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D8FE80A9B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1CD839DF; Tue,  3 Nov 2026 03:18:21 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BF883FEC
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 03:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpsCwHIcoAeZoL83tmDHFKFDYzYVqX8ehX6FZ7jOkZVjWG+fiLK8ByKwFIaXPGK23EboHtbO01bzrq5kIgTwvmfOewsM21ab8l5N1Y0xsHMemYC3fr1sD9J/L85yW4qKuLjb3IPZ2KU0/bWrnuCcNiJTLNv2c4rJoHkISwJDe3tpuFQtHuGuYw2wTywhiNbOKSNUVR0WUcs4fllKiupWn2UKxP4EuueNkB3n2JmrxM2Kbmp6l6mce3d9UNu0cc8jRjU1oa4jY5zHCGsYGYhSXaj/JwIrhGzIT7+ac78o8g0DEXTpueLRosY/46QBOK9iJB1LhK7IKwW/kKq53DyJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
 b=sO+e0UiJt3L68RAHyW7jhNHae4fbvx9EE/ZxkW4dYSuXuzFh3NcDzyN6WwDFsG9U1qjKC9UwVD6TNLfFEBAgL14rKjbw/pr2m3vk/R/LGp1o3yL8Gkf8TxJsGqr9KvIxM4TigLne5mWptU/cKExNzLTgx18M5/bbAIc9oQXdt9mLYnU7PrfPvMeqECO6bibFuy1dq4i97GgH+2H6wwJXOQcIp00ebjwQFvcelY3bT9fb/BZJpeGY+GdW9ijLUNJeV7/UrY8xMaSZmvLNU+GJzh4+JEGmucZ7HGh4LqzIC53askCPE5fG4KAjkl9y4X01e6MdDHvbdjqiUQqa8tJrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
 b=KdKLf8el8ubEZqFOP1Yo4mKICc8FqP8Ex55PuAoRoTQ3Tn+WHlSZKxkqQwH6TWsT0Nq1NPqRZ6kt+52d6vcnxlrW+BxnPKLdK1E/rUUndoZ8j5/B6KWxq6L642ZctyFaPhU5xEGDNZqwp+OtHA/2j1zS0mLxZEmZJB6gTwKuoUjJ7nLztvodz5yzYTQZE3YXXqydWQMcnZU8XJYPsxzgJbaIQDTPcjlSipEliiIMEjpJli8DQFze88h8UV44gK3pUHNNvqsqwoxllGilYCmMb6fm5abak+13K+x5Z0ahdi6nZGe2A8hZ9F23Wn9RmEYgBw6VDhFArqw+HP3tygN+zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989637.namprd03.prod.outlook.com (2603:10b6:8:41f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:18:03 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:18:03 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 2/2] cmd: i3c: drop unused includes and skip empty device slots
Date: Tue,  3 Nov 2026 10:17:43 +0800
Message-ID: <20261103021743.27111-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
References: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989637:EE_
X-MS-Office365-Filtering-Correlation-Id: afc9664e-9812-48fd-fcce-08df3950b08f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|55112099003|18002099003|56012099006|11063799006|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261022113327099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: lvmYPNx8+I34fl4n1O2QOLy636+OAsUPltR9fNwigzfQUDnEn0sTmypIRMICEcLm5ZHi47tF1t2WcNCq8rgG+3uY/7EjdfV4SFmaPfqXV+DrOX2EO//L9DeCW4f6dajt038w/7cjIqZw6Yjy3ZI6utAXaEbuj+qaBQ+q8h3ndm35f06QgBIzITQCqPwJ1Ij1T20jQakxwXuzNCy8rkE8izfoKRkRbriXLTjvLdr+zyCicTuahsM/uZog2lXZcH2IeQ7deR7Y1GxNvAecZsqC2VQlTC0IVkihIiFVsQwZjQMw2f6sA3natvh1WPpwWStl6uDydZeSRWDRXAeufBmrqVHLKkqCUP/XjUIjhnfvlz9wzNtSSOy76tvOekP1Tr0KyOB32p+V2lkhTV1HeQLYsH1cuIZvYkChRkMwbnCyzn+cMtRXhXYVImb5chneusvqo0bJhRFwjoFf++gsHTBHj++QjXrA2WksEvXC1IH3pgA0Dr//QrXEg2to5dLrKv4WA+Ne1Ceep327Tihl/9h8K05ZN9+yWeUKFVyqlFao0Dg5UZFs/gA1cS/ClR8KFMa4uYD3GQPKLeBewH9+sBC0+GAcXf15E/GMAgzepfNcdv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(55112099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261022113327099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zG+NtOyu3IjaA6fG4p0ZBKO5SSIlbZFMV8XmUFbpiQ/rnQWHUnQbxmBHGfvg?=
 =?us-ascii?Q?y0OlHJdmHtmvcv45ESQzZSAZhcbUocQS29eqpJ47yl/AIUg1+A0uzxJX2Fel?=
 =?us-ascii?Q?EGvqu1qVnnr72gKpPB7SqozRr64j2hbgxB9UOryIbl+yKmVcwVIdscruUS+t?=
 =?us-ascii?Q?joOAX4Wdek5KcqzFvpeWfis5sEFQQ3Y/8n7ncYwa+LQuh+BkdekN6W7B7BFQ?=
 =?us-ascii?Q?0jEpTt+PttW2UJHCttCjzZBKY1ZLuf3ALGDTYhh2yM9ZqYVM3A6R2ZD/4q8x?=
 =?us-ascii?Q?wMXn/mAvfV4q/Vexb4eNAylfOpFMClIxM6ztpt2l+XJV8qAxSiu2H3+wsYcE?=
 =?us-ascii?Q?uFo/xmz3aXu5S1PvMk1krnUXMZW1YoNIGB3qDORUpIMTuUWua7I1Jr0KreqC?=
 =?us-ascii?Q?nJpPr8MfyDmx+Ll3OlywBjc9Oq99B3SPnN+L0uFcNUIE4kjhp0btgUqVx2uf?=
 =?us-ascii?Q?IhvgRZsNX6IfQf6TAEidNsS6hDWDLX5IvWM2OlpYdXoGXOz6zvNOCCclt2Yo?=
 =?us-ascii?Q?PjL5XIgO30cQvbThf3IukXJu7tW82VQLLj1hDcrVGtuvDla4A3oWLx6YG7RT?=
 =?us-ascii?Q?tNZ8oB1XUercz+YfgDGQmVCg0PiRLUOnjs0y/4b5AY6XWqanY3KCDNVo/7ew?=
 =?us-ascii?Q?luZwU+tyKKYMyHMnD0lqAuLNqWJ2YPdMf6iZtKJHNqai/8zO+uptZTeOURP2?=
 =?us-ascii?Q?nwahGS3A7dfBrjBd3CzOjpzeGLb89hzSrcGKsO6HNX5BtGSg3E/MsVecoVoS?=
 =?us-ascii?Q?gKe3Yim1LLJ2h7czEh5Zpz3yjhfmhHjOfsXFjTA+tDXD5V8AG1P2pZTVDPCX?=
 =?us-ascii?Q?yq3GO4M+QFAGgn3qEzouujC3illyQPyn73g7VpHOukG784PYRB42pyHNoiDf?=
 =?us-ascii?Q?exyhoSJfS1fOp+83NTuf88+CvAh+nNWrxtpTO7YjDc8Ddz2vbaJhHwwuBasS?=
 =?us-ascii?Q?clm/n0EiJb+Q/0M/24JKr3oaqxl0zbEb2rCQw1s4JrhzH899vexkoofTHGCX?=
 =?us-ascii?Q?cLgbqP4APlIPAicRwsv9TtgX7rJdh3pZCYlkqmOdFsrBH3Ma0Wxu03fsSlDF?=
 =?us-ascii?Q?yYTUqTeGiAyd5rl4+h3PFA44JsXTCMGqUGXXHKXXHJ2Aw2Xxijxe9Z79kwmz?=
 =?us-ascii?Q?6pUeMj7OTRiYG5y9XWEVK4pyloATipKiLDF0OoG+baxMT4sgDSGCkdvUh3qv?=
 =?us-ascii?Q?AhoU6u/k1LzCXzeeKq6oLjv6k9L+k1lgybBy7uPBKJaYq4P1kqiiK91/LjKn?=
 =?us-ascii?Q?PuqoGUrDnFpiMWit73x8oWN4jgztCmXOM1crF1JCxxlTKEKusvepvpyyx4G6?=
 =?us-ascii?Q?D/lDFbE5/66eSAwDGXH30aTIG4orV+g9VkWjh4BiJ211/jJk2moJf4aqxhP3?=
 =?us-ascii?Q?ERhEOtbO3pmuT5eXBAeimB+AMhy7spBkByAzi+tozezsHNHfXgparY98fMds?=
 =?us-ascii?Q?n04rc3H/McTrkigF+7CkzV3zHPyBwb11hyo9OeEJd+NAfIo9nxXbctBb9Lk1?=
 =?us-ascii?Q?6/sbxnv9KR+DGVXZxDq7zkefyz4AtH0OzahDZNOowntCgrPlpal5W8B/lClw?=
 =?us-ascii?Q?PVEcIgQLJujFdGYRscVrTRG6D8KCyyezr1iJU7Qco4fjyEpVP/0H2vFpS31S?=
 =?us-ascii?Q?aOEtxmKhGHndqqn/3q3q2LhfhGqjJOxon3XEPHgVaRlFmNfNlSaSG6E98WhT?=
 =?us-ascii?Q?VzciT3ThBZb+jECwKweHycGol3jnwTjsUpgJiQLwQsEoHdSMfIkFidM9BbYR?=
 =?us-ascii?Q?psErCDly2Jy98mVq4ZlmDRZ8XP4AUsE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc9664e-9812-48fd-fcce-08df3950b08f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:18:03.5467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H958rIrU+X2dhPXQUDCLCIGISn/FiMHOvnkDBHfjAnZhiXS46J8CQpYfp7cn8gic6DKagzPf/5ye3lVB6K1JdI9h6ZKPRT+050HMieC7VQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989637
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Remove headers that the command does not use, and skip NULL i3cdev
entries when listing devices so a detached DAT slot cannot fault.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 cmd/i3c.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/cmd/i3c.c b/cmd/i3c.c
index ba99a937990..6d287ac930e 100644
--- a/cmd/i3c.c
+++ b/cmd/i3c.c
@@ -3,23 +3,14 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
-#include <bootretry.h>
-#include <cli.h>
 #include <command.h>
-#include <console.h>
 #include <dm.h>
 #include <dw-i3c.h>
-#include <edid.h>
 #include <errno.h>
 #include <hexdump.h>
-#include <log.h>
 #include <malloc.h>
-#include <asm/byteorder.h>
-#include <linux/compiler.h>
-#include <linux/delay.h>
-#include <u-boot/crc.h>
+#include <string.h>
 #include <linux/i3c/master.h>
-#include <linux/printk.h>
 #include <linux/types.h>
 
 static struct udevice *currdev;
@@ -103,7 +94,12 @@ static int handle_i3c_device_list(void)
 	}
 
 	for (int i = 0; i < master->num_i3cdevs; i++) {
-		struct i3c_device_info *info = &master->i3cdev[i]->info;
+		struct i3c_device_info *info;
+
+		if (!master->i3cdev[i])
+			continue;
+
+		info = &master->i3cdev[i]->info;
 
 		printf("Device %d:\n", i);
 		printf("  Static Address  : 0x%02X\n", info->static_addr);
-- 
2.43.7

