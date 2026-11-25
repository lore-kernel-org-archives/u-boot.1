Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF9606A69F
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j4oVfT/K;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B87F94082E;
	Wed, 25 Nov 2026 16:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oy5NK7yUyOfs; Wed, 25 Nov 2026 16:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC3B54081A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795624396;
	b=JdIQHKyOxG1jmgG4sHfNWRgwj7TCme6yFpRhPEA2iYxCESDV5Zyl9fAWmBDpJCkjwxyt
	 w0sqKKByKBWhAbebk2XRH8rRcb5yQnG2BDQsW0Q0b/+ACprvMf9RFi99P7I5GIKiMiqNS
	 5gT+Kd4M5YTkg1ni/HeHfKzWlmt+ekIbsSOPEFiC1ZMFK+k50kKNuOsKYYcR4GGMqr/9B
	 ahG1hRrn3jzB/LXmszQ5tutE+7JpkzST2CPk37XCajh/NExIr1/KcCj6quxTGyRawJRQL
	 qQlEIbp3rhYS2yEGNA05jq7RL/t7IZQKsErsKFVwy4E1eHeYy6zyKT60Grzqkc9PWlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795624396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=ifwnFrTQYTcx5VsZoe6sYMaNLOT8h06zBAeI2SLBD14=;
	b=cInzrxDhDh8EUMmkikFbDYB2ZO7Nb7FemF24E47pxPTRhnyGs3ikCnYQKKOeskUZ0FLy
	 0irxOKbvklHDpX4MnwOKq5L9bTn+BuUAc4HtWIOBPsgn2Tv7jOY34LfXbBx/z+Mshl80q
	 PF0tmMHG/qBMkzMUZIuFii9mF4g8Y+bXz36RQwvVkedFk/AL/zdzB9jESIdZui60bGkWm
	 JBX+qX1rD2+I3zw7Uoznz+l1rq8sEjOsOc3CcSnQU7lQiEuy8oBNWLDZvRYhgoDvaUUCN
	 kG3Ebt8484iB5zYlGx0YS0pSu43alpXqcRmRfNiUrk8HL2kuphs2ruuNKsRkLqXQULA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795624396;
	bh=ifwnFrTQYTcx5VsZoe6sYMaNLOT8h06zBAeI2SLBD14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j4oVfT/KT6DavYqFaEuoc4nYXcSBqPb1sElvX6fcrqbLDq2lautTWTNsx4hFkeHAg
	 9bo51egnATD0dqPHu5uMMue2w/yAjlv/DFwUri44FjOSeAlOi4I590dyQfRiE/HyEn
	 te3G94LE77nie9IADJvRML5m3xA6VKQUZif2CLPKY6KgesmFRKsoN4BR4yf5QBzptC
	 FagRV5WvpyKNfEaqG7YTtpgt3/tZL6ZpZhXlHEPGWCc6Tp0W9Cbv6mHzg19I3wPg4H
	 l6urpzU+eGVmfnYVE1i9w1sEY0C1iA/3pYUKCvMzHl6TBlem4L9GUQOp6a3yonFzk0
	 fuweOXq+2uPvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC3B54081A;
	Wed, 25 Nov 2026 16:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5E7F32D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AD964081A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HtXOlljwQgId for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 050D440816
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=f2zzpNZW
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 050D440816
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifwnFrTQYTcx5VsZoe6sYMaNLOT8h06zBAeI2SLBD14=;
 b=f2zzpNZWRskhJs3lSJQhampMgDcXYIrG0qR2tg0w9B12wEkrgLf59Wve8EsqlJZ3dj3CL8onAP+460mgSTwy9sD/VnZ1eJUSIJyfVO1KxtkdkrtNw1sA0MjgQrYglwFgxVCfA3PJPQrvoJy8lhE5SjRU8c+EJteoiJf8cKXo5pY=
Received: from OS6P279CA0006.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::7) by
 DB4PR08MB9333.eurprd08.prod.outlook.com (2603:10a6:10:3f6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Wed, 25 Nov 2026 16:32:59 +0000
Received: from CPH1EPF00000526.eurprd05.prod.outlook.com
 (2603:10a6:e10:30:cafe::5d) by OS6P279CA0006.outlook.office365.com
 (2603:10a6:e10:30::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:32:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000526.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifwnFrTQYTcx5VsZoe6sYMaNLOT8h06zBAeI2SLBD14=;
 b=f2zzpNZWRskhJs3lSJQhampMgDcXYIrG0qR2tg0w9B12wEkrgLf59Wve8EsqlJZ3dj3CL8onAP+460mgSTwy9sD/VnZ1eJUSIJyfVO1KxtkdkrtNw1sA0MjgQrYglwFgxVCfA3PJPQrvoJy8lhE5SjRU8c+EJteoiJf8cKXo5pY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB603259.eurprd08.prod.outlook.com
 (2603:10a6:250:119::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 16:32:25 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:32:25 +0000
Message-ID: <38840147-2312-41ec-ab21-f5af59aa4a2a@arm.com>
Date: Wed, 25 Nov 2026 17:32:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: accept IPv6 literals with a dotted IPv4 tail
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20261123-submit-lwip-ipv6-dotted-tail-v1-v1-1-1356075a38fb@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261123-submit-lwip-ipv6-dotted-tail-v1-v1-1-1356075a38fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::33) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB603259:EE_|CPH1EPF00000526:EE_|DB4PR08MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e17c40a-74e1-4686-f98a-08df4b11c44b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026121527099003|261026140227099003|261102123227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: AfWcSy+sFRCZXlgyR/ucruh0ecU3R9pFxUpqAE14bEoqxkUF+AWz4bptam9ZHy6v5wHdPpDO+nL6g1K9MQVNPy0mceBBKo050ZCK4iVASUfsMydj9fFSbylrp6FL4Zve56OTqmQhPjSD8/rZxZhxvstipdEcDbZUxTuta7GC/Y7LMkw23sXVWhctTnM2DvI/yz0y0FrscRJG6BaG9eD66eIkXJ3u8KFPYKkFs7bF8UeDFQM0Z6xlWOCnsZ+0KhO/UwXApmpe15MWCD+Kgv9bJ1Kv5aGdxEugpTDqKOSxRukGLWnZ9VxUvypCXvfY6SoPcXL1Tt2plDTbh4HqFr3oMVMZT+jQwDuIMpuaJPZ1fQxzKkwx3U97CCnp97APrmftedJNZeQoxL60O9URE5160oh5H/k4qyO8ssvhMdlc7wySTE1EVvpLWq5hPQvnxzOqXye8YGuDbr65ibM0f/J6WjhP3Nk6ZWWgJSVVq4UqjtoCXMdCZqK8Mce2dOEnuaCbbG2A3kVuMvbULEYQTetVQAaPXc733fBs7LDMlIZQSgphMl/Oa5AnXb+Eqs+czdYS6GNfP/0sA0x+EaAu2lvQd+qdblG65dkl7JSIhFENUQ6sK6yIDgCiYRmB1q+4V2Mj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026121527099003)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: mn6OwRBxCBUHim+sjjr5TfZI206CptUdYr3gECt/3IvGayXa+E/AbIqa3hmnlFTfez9adCKbRecaPhMEy4jmgqF43iYfB9HvBSO4eCBSW6y0BmWwiatSE8+Jziz8+eF31IXbbcLbFVKyAUq0g0Y02lhhxyx2bbnCsdivf8G/C7Yz6yd8P7wcPX+kjxHFPbPHzSMcL7a5P87wYdxtceXtx5UhizrvI8WF0doNLpVeJ9IFfyKS82S715OspXGbLXx1guMeRrc3Y9/RZ5who2g5S4LVVJPGrHtlX4O1p4sHWo+znEWBAU/FR/26jYVbFK1uMYk7rulPeRwQEwAWXbFj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB603259
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000526.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d819ff96-1c46-4962-d6bd-08df4b11affd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|376014|35042699022|23010399003|36860700016|82310400026|10067099003|261026121527099003|56012099006|11063799006|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003|261021121427099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: tR7qyyqhCQZwXcQqUYmmvfr4bZr6815d4RX83ghVSfGk+PhWqPIw65rY+kuVf961UYTvb8uMDW6oJ9saLROJ74C9SHswQ652AbACLmFcM3aeaJZHCzFEWTf8bept8noLoqD1mLWF3+kT5qfi3GesZz7/Jh6s8nReK20q67I31SI/A8/nnEuu9xJmUK0/tj1ioQgbLXE0mImIsljrkoQoE4y4mqGvvmJ/WEZcVBfepMmrqjxcvFiSP+QewD/tY9RoS22SttjEw3zJWI767ukhwBBmRlwAHxDjxASF1zVb+vXRxfPx/gjRGHWRzx9V64gdGSN7nVG2u9ef/1zeoIhChHdl5PKxtHc7bljZCe5w/ZnrLp8EFuGJ/daMmL0AAsu8v7vsu21KH/FG54BAYmgCvaZvIgtYHpQjHA2RGUhsqefwCmSj0pXbVQIfWP2CvooSEt9gmZHN9Wr2oz9wnREL8OB97iKah2rlckTvbcVFhQOCxYnStjmCd8sNACg0NxV6OEp+0ZTDeauJA9T+dysAGAT8Gv+qXz/5RlgmdVJS9vMIZ99ll6zIouGEpkxn9awSzSMXuyJOW/TfaXvftHkOGrDrDCE5yqqMr2MkvNhoJlfJxq+3TxqoN/21A8JnjbviJAu7M3i07m8ZCrLPJSqzLKX84EZYV4lV/w2J1i8/AIQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(376014)(35042699022)(23010399003)(36860700016)(82310400026)(10067099003)(261026121527099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(261021121427099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0WVJa2yyDfvPIS//slxRGXM/7R2wIHWdLHDbZGNDLTgb9iUCN9adPsICbhZk401n9BB54vT483A7zSeFXDE4C5Ulelhh9sOLlmT/+jKBa7d6i9VMHQGQzvlY4uBt6tL+szb90raHO78Oa5xccicbzfaEDo3BjFtZbNXSOy6DEgFaRNdyE0+jzQpchR7XvXBlDHgfdfQ4T7C2eGG7B232ONlyIa5e9Zr4Y6+x4f1V8JGA2h7necC482PPnK3cUUM8Ly4keMmRaiZ6Cf1bwQoDmak5wAKhcVeBN7V8CGOS72yd4wCKYiSX1Vij3Cx4/qD9OK4618Yq7ojOvUx1D63Z9zNyqNNsCSWt1rw3jwTTuWExOIWV3NgHhxfuLxP1f+ly4kjDaSgwRgkL40H+0XDBauZf0xSRbuKHXkpj8MBM3hYvsToiXCsnqyHTDdfHw6dV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:58.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e17c40a-74e1-4686-f98a-08df4b11c44b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000526.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9333
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

On 23/11/2026 17:58, James Hilliard wrote:
> Setting ip6addr to 2001:db8::192.0.2.1 fails even though it names
> the same address as 2001:db8::c000:201. The U-Boot validator only
> accepts hexadecimal groups, and lwIP's parser only recognizes a
> dotted tail with certain colon counts.
> 
> Decode the final four decimal octets as the last two IPv6 groups and
> apply the existing address checks to the binary result. Use the same
> parsing for numeric destinations and DNS servers, and check the address
> length separately from any prefix on ip6addr.
> 
> Reported-by: Jerome Forissier <jerome.forissier@arm.com>
> Closes: https://lore.kernel.org/r/e4e021c4-af32-48fd-9891-454f36ba0242@arm.com/
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Follow-up to the applied lwIP IPv6 networking series.
> ---
>  include/net-lwip.h  |  1 +
>  net/lwip/dns.c      |  7 +---
>  net/lwip/net-lwip.c | 97 +++++++++++++++++++++++++++++++++++++++++------------
>  test/dm/lwip_ipv6.c | 25 ++++++++++++--
>  4 files changed, 100 insertions(+), 30 deletions(-)
> 

LGTM.
Acked-by: Jerome Forissier <jerome.forissier@arm.com>

