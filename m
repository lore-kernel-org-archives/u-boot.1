Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2D606A32E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oq+EnT5b;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hh9SiBSd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2EFD40D0F;
	Fri, 30 Oct 2026 14:42:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlZkMeuHx4Ll; Fri, 30 Oct 2026 14:42:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDA9740D0A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793371350;
	b=YGsRQBqk2eU+ANJowqqdJHMD8bHxdkzzSQfkHG7CZd2nklj+HakpVSiuZph1zvdxMsH5
	 5tpHiiR8BCIiRJN3Tu1e6gmX1n6n6ouOll5N5bJiTZfgIfj9S3e+007oJg5LWLa69jSgX
	 nbE8aefiV0T28EnNkL4GLL1vuStPre1khXp5a19bg70GOC3qESIKRMEPn8TzS2Mk67PMm
	 Fm7UF+SwkhEweGvS7Q+OabSnx2QJd9+LiupAJTsGBN1oGGfStiGGXt/TXonskOavDs4jJ
	 KHcjh/1Hl6c+tfHGcDH7AOFObTvjSGgkw5zhun5AvUedSK9QB/Q41UbIFyjf44O30wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p/zn/6sDRlKoXMDcTfmfcLbIOODWkmkQqzILX87iokQ=;
	b=Ml+BnYIiKxG0Ex6fPh2CWRG5NGRABf0+gg94mKr0t90u7LQ7SK2tdeRDMdZVZbSYMN8+
	 7wrhEeEl694Ktymqshvaok4wpEGUdmyWuO3BWU9o3cOdyNrG9hS4Fro72K4DbWSomobmn
	 A/lUvuW+65wvvj8lbIHjwzEC6KaTs3L4m1lRdlU4NRf5xOAiTk4eiQUp1ZYOAygmbSqXT
	 X5avB0vDdh551lWwYtrA1elD1kWvKiyIj9Iuimbl71VZOtIGQk6c6XYckNr5zYySUBEvc
	 PVcfJujBJXwBtOxrtSyOhEzSXmagv00md3hrr/NMa3xaFlWvNrdNRJHAoVzKVJGadNg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hh9SiBSd;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371350;
	bh=p/zn/6sDRlKoXMDcTfmfcLbIOODWkmkQqzILX87iokQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oq+EnT5bOygdD9RWDxtgcpl1+deaXWuuz77iBfxgg8SaU1B7DApZuh3zlzTIIa2nj
	 ATW03EjGLpfiV9zjy8wL6nZP2UfkuaM3A20uuatAwGZRUlNswYQCv/jiaeBoCNq1xQ
	 hA0Hz1hqoc5ofk7ufuS9EsYHlMj0SASop+kpJ/rAfF957+cL3em62rgUYbj5o+938H
	 i98e68W8F/hCuA+yjte05reo20wpwxjhI54efB48koxyHF1xZ6G/1qeBRwl0G/bzau
	 opXBKM4KCEc4BgDnkHlUAdKDsKMjyjtJsDL3eEpAPWlENb0sdeaQhdrEtD95V1TK3T
	 YpzSEXwKhfc9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDA9740D0A;
	Fri, 30 Oct 2026 14:42:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36FCE529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CDEE40CE3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tofSTmT3tLd9 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5BB840CDF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371146;
 b=FvcllIiF9YGZkWJ2Gy23mSCYNfNoEmdCTET+D6Lu43OdIbz+RPPcRVTZNOLQZXgK5yVv
 rfaeqtmSsEZSu1yM1yYE08qYlGivP+w4iDljf0LLiAccisve7geaH0C0J7a8Q5wvnB2MU
 k40n/NCSNshVKlJVZJ4d3eFt5GRXmOF0WIc0EpOnVG/G795OJeKer+n373rJR1GTCMa/h
 GKFzeqwd/MPFlLBmilz6Os9n/wFYNMQNLRIib7bm7zsG7inDXWb+fowVSQKhV/McMinvC
 hVjSfI0nLBXXIqcxMPVzIK2a/skmSMEXlJCAUwNvaoLCDZYXsOz91uY9gRbJLB72+hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371146;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=p/zn/6sDRlKoXMDcTfmfcLbIOODWkmkQqzILX87iokQ=;
 b=D5y8gat+ZA9aTqOvHaAAtLgJg5VRVdVh/ojNgQOM87J1ajut4rYkjzUl9ELShLtT2iuq
 p8OKyUsCVmQsqpSrTdJ83mIuus1/itWH1naySZXujvYLHWnkGaozi1qLPM8K3TcCQIzSx
 tqILqCv+PRKVliz8o/EpdqlvxoxmmenKvf/twEGGa1OgXCe5pspr7k6Ann1hLjcuc5g2e
 vA70KSQE8wY7psZ3YSMBOS2CmZG5ZWZg7hwC8s4sxJ5iBUIC9qbI6jzzxVx9LxaJTslgJ
 PM/qliQ8ThjnbwSsb49BctBoKXBsPVze65FNgQ8ANTYpYwVZEwkcpCH2eeCrIozh/WA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=hh9SiBSd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=hh9SiBSd
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5BB840CDF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnYFTMhZjobG696wy4hedJCMOUo9ZAI1FX9b4L167dEGFVarBNf8bHqJKXvQqAdyGycvdtUCkXNIc/BLR6TSkojNPb5Z1EH+p4Xh5fuQc8D3zhsKIdj2w3PR9cagCK1h7wK8wNFOXWjvWz8WeMDDEnN+wG0eG7j8c1VkBLnvHM80cTZNC4U0DpWrhtY7SjUFky7tmDSUtw/QblyAK+ELEyim8UkK6U32TeGWslnyAg8Vj3s1ACymWhzaGGoHsfN/wJMZ52uU1ZJOhoo0bF7jrOspMC85Q3mWmn9I+cGX0IkmjvTeGZhkioFdfF/qy5+Z1c1c897ybcrqOzE4N7wSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/zn/6sDRlKoXMDcTfmfcLbIOODWkmkQqzILX87iokQ=;
 b=F9JT36zBhu3RgLHr+f//hsiZ50TxtEXTNhe13r/sui/6ZyE3dZpq3j/+dDm5Hcm4KdpAJWi+Vh2GOxej4OtE0JzEiDTBJn2QQcgT3fQk1zNOPlCSNKV5Zr/sIvjHF46nHEDiq2QKVENXf6JWK8hnPyjMMtBIM1NPluFGaSygX0RQHwHcBD7a58i5jgMUOr5Rto6Ha4PhXXaIcawojCuyPV0Xvzraznc5XqBE+rlW53LAelRfE70H7EAb5VimR74RoyKeuCMYy0ijGVzvLMzIMuowK9YHW+Wfk8+yVAQgQGuEJ7MA4jAHoodY/auRqQnVlIHEe/TjVF8RMAjzH5fNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/zn/6sDRlKoXMDcTfmfcLbIOODWkmkQqzILX87iokQ=;
 b=hh9SiBSdXWqlgYrcanRl7W/teQUQn50xzfbQu2L5cuCKzgmVh2mzivMDNFpvu0fJNDx/lgj+2qb0K44LwKpipGEGB94wwXa2pkYWWAedmIUixYVyU2iRegzgpfZTHgIrsGboEJoJ0bRk1H0qsGw+hUVR0jORAwrnEeWX+4t86ar0iB2DIxuGiDWyC5U1xSvxxVEo5wHnmrVV3eO1KqPcK00PsAxXEi6dJkuso85gcZm4ifsUaY7BkapDYtzlb512d5ce8LxU8pyZspNE4xLMjEcKX2psCObHXOrKA6OlKN10Dcp3EEsJmqNmDwpcVtmjWUnGzO2mX/cGoHiWrgDWzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by VI1PR10MB7733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 14:38:55 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:38:55 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
Date: Fri, 30 Oct 2026 15:38:43 +0100
Message-ID: <20261030143843.467968-4-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030143843.467968-1-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|VI1PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: a48e2dee-206a-43e6-42d7-08df3693859e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|11063799006|56012099006|261026121527099003|261022115727099003|261021135927099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: a7gTu/bGxHOY2JUHX6eRColwVhvWunSLizRlYZC4AYxV6EU8cEJVmuJlZJ43r4xWEiUNlOpzVd+tAjSPzhHmtOtB+T4GaIAKNi/Q7KBJrKh7lmipHPEebxgTjLMhCbkm1Fdgt3uP5DKJRVyxgQXEHZUK/lGohMx4SEgGq4X6Est13P8urm6mgU+ZUFzhCvh14aNu875m/lgozz+lKS2J/2S/Nkn0zH9qR4NsibzMNHJGFrEbgQQtqTGsokwKE8CcNbQILgZZZMVvoCoDftqw27013J5x/rz8MkrCYsrVg8Vmxk1dDT/UDvh9iYItzgCYP3RKaU1sREMPxpgbSBQtB30137YqlblcNqkjjX+h7BmaVhdy6Y2zCeM0lc4WQgJW1s0UiTN3hW/tQlAAQ3eVn3sipcRFBymF6mAnsJhA8FrVullD3uvXgNA//HM48WVl8h5TQmTBuOp7JcQqfbs0oqtxzhx45R1rCa9tR3Ay7hPJA5VyGs0YQmKR8Tvjrlrg5fFcY/cvcPyxcSi04XhaVpqRJxs88GzjBDE9PR4s9N+6Na7YNFmIy5EvIdS4b/COAqbOQHzX4RhgrIA9MXeWp18uHAMIZg0QAuMy56YB1FRKLGP0MTwwsxNXuq9BhGXTImDDCNBI22VV3jsqF1aZ6SCwigXeND8aklE8seIV3Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(11063799006)(56012099006)(261026121527099003)(261022115727099003)(261021135927099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(55112099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cq5WhUd+PABghnKjPJmCxbqv9/snus6+Qk9VSKkYXuhkIOOlU4Cx4KJ93xl3?=
 =?us-ascii?Q?d84YPp+ha9OjvIIOt3F31imWbWZQZNf+gt0hxoF2DSxatAzvWcJIo2CGMoDC?=
 =?us-ascii?Q?4NE2Q6AmMu1J4ElwRK5sH5JVNywHAM78EnndhuDJekTkKA1+yrWUx7XF7qNS?=
 =?us-ascii?Q?EA+7TBNJPFCCavT7bJo5Api92gPVUfoXcmIwwVhygNClJp1hjBq1XovvfAai?=
 =?us-ascii?Q?prSM1+5i1IcVNgBuLvY5hlQFj/zZbQuEyK5flR5UQhpU53BPAI1TB+meNYxY?=
 =?us-ascii?Q?fGuZjaUSjMMc2Naf6IH3oqMFktUEfIz0Miwg/eJyFkVTSwcATCxGx7PO+NVm?=
 =?us-ascii?Q?W+OKNhYeTEQVemij+B8/5/M+LSoABiHqLnk1Xl8Mmvj0vUw93GBxsi5qMP+l?=
 =?us-ascii?Q?d9TwIsq2zb/L52H444M635sFYCzCKhAuqqeS92auzDsWQ+gRqWMedhgyP2BY?=
 =?us-ascii?Q?hL+f1DCvbcjBOajJ6JgQgUvzoaF0RN0GPMzLKt/kKxN+eCbgzBRFj/EGdvyb?=
 =?us-ascii?Q?nF4D3WbASpS2dMDFyym52gTWueE0ktzAps0tcsS46zH6e4MkMTO84GpyXX3P?=
 =?us-ascii?Q?MczQCXvx9rxjOHdqXfhhDPi/yBFNDBUAEYoyejfYJ1dwrGA2UQ/8pegean+S?=
 =?us-ascii?Q?HTMFAHo0OaeAgB0HPTTk27cS1XIm/9DANqgFBaqFEDZ2+a44w77OiaFcbzsF?=
 =?us-ascii?Q?4qK4A8s8vk2PWdSozXJvRe9VD3xU5S73OhjBqDPZfvSnjsO3k7vBmjhvQN1W?=
 =?us-ascii?Q?d3yXERCNOZeyP1RD+c3QE+mQmoogldilK/hyYD0ctfYw1u4Grx5Vza2CXy+2?=
 =?us-ascii?Q?a0JWi55CkGyrj26XT97ut8283evpkT34b8HZYoNlQWF56Ib3EiEsvi6zAc5n?=
 =?us-ascii?Q?r5chuu1FIl4cLwD3JnAml4Xg8iO9i+p/HMWwdQbCRTaaxIcGiZyWmm/QeLt4?=
 =?us-ascii?Q?9bf+I7xJf/kgbBLequad7u7/bkH42JrtzEPWeBoCpm88HDy+RMUxmM3FTPDM?=
 =?us-ascii?Q?D+gOvQYM2rs4X1yua50rcVUf/gwNctDtgTNmRziFp+KsA5+AxEJ9m2AWuFTR?=
 =?us-ascii?Q?YUrnUkEnmSeUDextiNUFBn0oBocg9br8mQ3Tlc0yJ/ZYClZOljpanfUWtmyT?=
 =?us-ascii?Q?hiRhCFOL++/vFdfk9FU64L/xRj+5sOkrEcMG/tEtKOi2nEzFbK6xFY03qCQs?=
 =?us-ascii?Q?JrXOr7vEDBTrti6b5snrIPKyM/xSd9e6CDE7j7gPhvfTN0f3xpV/SS2OpTtK?=
 =?us-ascii?Q?3hkpiluqvjpgQOLFXXM4+qwHzEO9WqP1MemP2IOCHP0aQr0Cxe+tlsZilJhn?=
 =?us-ascii?Q?2z0AYCl9vUuXvfeC5s70uU/d0u6tuvu5hq31iwEk7uYhHK1tE1y6DFznGJSk?=
 =?us-ascii?Q?nNz+N8rdLNCg0FD/+oa1N1Zc8wpZ3JdEroj/43LtC3rLOtfP86q5Wg3Y2RVc?=
 =?us-ascii?Q?hAVf9+30pGXiHtyAMKqxAvCcePcNOakkCFsJ0KewCuwrZLZzuxoqLsRF6Oxe?=
 =?us-ascii?Q?LvrA8vnDCsHOplx1/l8h07nu7Wy+PhQ7gH16FsTruybiuDqVaoRyPBmcKrP3?=
 =?us-ascii?Q?FsXshykg8tcgj+8EDkHJyjF/r39LiduISNWQlWSvbftTXlHnTn2SG8i+nAeM?=
 =?us-ascii?Q?FU7jWPsw83qCbUOWhvcN/rRPoxQlScmjzvg4Xo7ybNrcpkVcj18hNzz1JaLG?=
 =?us-ascii?Q?t+UQXlMl74/6wLh1cyIp3cT00667e0K+VYz1HNy0JvihmoW466pGrtSr2SFI?=
 =?us-ascii?Q?gHuT/u7B1ApK7N1QTYTC1pn1VDhGYzUpxRAh8L8YxQ4j/BdqXvh9Y+AOnTY3?=
X-MS-Exchange-AntiSpam-MessageData-1: vZ1XBdDqQAai2egb+Pdz16gcd7Jq+o52axY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48e2dee-206a-43e6-42d7-08df3693859e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:38:54.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaDx8C3e1i+V2rwarCPP6VkPbkxkBUcWbq0Y9KhxUeU0YfRF8ZdKLLJIlM3XPjcikliJVthZzQvsSomNnasagalq1RLnKwmphW5iZ9xwF6w=
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let users know that the protocol exists and how to disable it.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 doc/develop/uefi/uefi.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..7d5d8943360 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -1015,6 +1015,19 @@ So our final format of the FilePathList[] is::
 
     Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
 
+Timestamp protocol
+~~~~~~~~~~~~~~~~~~
+
+The EFI_TIMESTAMP_PROTOCOL gives UEFI applications access to a monotonic
+timestamp counter, e.g. for performance measurements. It is enabled by
+default and can be disabled with::
+
+    CONFIG_EFI_TIMESTAMP_PROTOCOL=n
+
+GetTimestamp() returns the value of U-Boot's tick counter (get_ticks()).
+GetProperties() reports the tick frequency (get_tbclk()) and an end value of
+0xffffffffffffffff as U-Boot extends narrower hardware counters to 64 bits.
+
 Links
 -----
 
-- 
2.55.0

