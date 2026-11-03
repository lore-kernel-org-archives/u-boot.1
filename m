Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97153606A32E
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SjhWSykM;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=PoGKodLs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EF436082E;
	Tue,  3 Nov 2026 13:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ml_1ualvUVG; Tue,  3 Nov 2026 13:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C74260815
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711095;
	b=dMW++AkUZt5HznN4EB5J5z1i0sx7HpwzRRcV3jThKNFW9LLeBrReYtJhWhnKffkI0hrX
	 CJiNXb9FB1lrq9da9SlCqMdB57FIJxHh+p0AiHqEJWbroeTGbJLjBeKT2QpDfMpVbUCim
	 WAZq3d5fIES77tkT+ljkxkR/BzmnTD+zVkUMMIUMSqRXeMvoeDgPdqt+0nSkHKyvy1yAY
	 GBNQguvxurtr3AumdsHbeCGW72RRDe36cbbnQzK0Zg3XQGZoXoI8YJBH2LTALPoBj2ZvC
	 v8r9qqSIdr61gr1g3myCHSFrO2x3h45KhInd3XICU0Q5kg4tlMcJMtTi6HF1x2vyyIg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711095;
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
	bh=sI6vxxwpmfJB6pCNL4rJoVBJxcBJQ6lDUBWEcRhtjSk=;
	b=r2HUujqaOqvKnrvrxH5Me5B4D2socKJECl2DimzPhkIixLlnOIHfg2jCZoWeJOjdJtVx
	 d/pxJw06EbJpHORF4Krarhradakg3EVU/rLEYi6vLFp4oFX3/ajBkspkIA3X0TFjJs6e4
	 CXafs7P+q9P4ahFPT6VvjmfxEEAiDp4CLHqrmP/psdQdtTjqKIG45V44N2vMC1sYunfrw
	 y0rLYgbLsNmv3u/qA6KRq0oWibazSr5SPF0baK5XgFslx/KZAfrLb75JU5nUQTsSbi1wG
	 R0p9tTnk6Jrm7bGMVtp/79ITZc4H4bg5hejEjoempy8NX6rHn35IUBxPdcoNyMDiGng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=PoGKodLs;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711095;
	bh=sI6vxxwpmfJB6pCNL4rJoVBJxcBJQ6lDUBWEcRhtjSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjhWSykMnKAnxfKpCAcUDr3Sz/iQQbV0/MWEGe3xYGazx/Iti9rVX206/RbJc0BXw
	 N2NHE8DS9GczOWa0CIcbmmQo5MuxDzuwZzU34UaGRkqRMiZ9sNsOqORWmb37PbRFKH
	 qfL5XHz47hXjkW1Hdf6NGi/DBLyxGXtBdOgAu67XBOT0+a8XaDHz5nwzjFr5OzZVw1
	 fX9q/V+FjP+bqXSehO1AKgJ4wt5x7iXrG7dI7HuVGX5AJwJ9dhwm8yqmFVjoR2VJOz
	 7iteVQeF/GIUO7COnKoB6fKcDCO6eEFzMHUpLtXUkx2wtpw0Bmj/wqovIas+NQ4q55
	 IVqq9GbtTYznA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C74260815;
	Tue,  3 Nov 2026 13:04:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C321435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51CB1605DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ue8bqeOjwVQR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F73605CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698436;
 b=FGAIs1Uoa/Ie7loPGjSFPPA5RxapEBWVf9M/9WkU5C+Oj6PXwVGXv3TOdjuaaqgDTAqs
 wDVcpzrFk+HlbOT8h7jXunU0nzEMkF95hMnVx+d8C93grNzcKPXLZ1/f+hthckuJg9BXO
 MeNV83wDvOA0N44mowXsVHIsZW+VZxOfWR5NEbtD04mgw6/di7Z473fHUgf1QwWyGwD6w
 yV5oZP9M2teQ/uePo5yLvSJOzVUrpEhOdTmmq/Rm0VpGpXD5vk6u2I13PTXUIjl6i773X
 DTLkOhHNkaSbZ7iYbdT+eYrlrMjDS4nt8VJ5gyuBvxJPQF5G8Z3woZKbIiNzzQ6wVFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698436;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=sI6vxxwpmfJB6pCNL4rJoVBJxcBJQ6lDUBWEcRhtjSk=;
 b=UyvYM6+95q7gDviG2UsvJUZNCXNFBqP+VzwHCxOr2RML4HqqL3d/2BlMdTBwW0ai4V/f
 QFPUD5W+evu2cvta+KOZcfsAGvW1j2SI3ui14JPEqXtHYgFdy+3pFv2RE0GAR1ds5/6Y3
 +VbMZ7+Np8k4jnMAuP22kPd+3C0jLrnyiiRQmVElJcOlb9F1jSbJhBEmh4mIo7e8Ecl+a
 4j9vw1o79WiQereYWOOkP/b61lWL0iUQzSeWcPmlhvhj0917GyWRuabov27rTRzekH2Mi
 sWYb+qhrFcdjaQQ+3GS4utYB5LtlssIN/bTTG96vRjkpnXfU1+ZgjE2auXCdPHVOJNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=PoGKodLs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=PoGKodLs
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38F73605CC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0ugXDM4Hg9ecnuBHfDNJy1liFHKcR71ERL8VvRJ1zFAKIMIsgDTwx53NLAgTuJMlrndUGp9AqOEv/H49wYvekdkwrLqahNmpWpCm/Da+zgbZGNz3zHZpUwrjU95w4FjfPBlmcxb8p+Ryz04f+/fpSs5Jre2NxBI0mKwrhsWPnYU6JqonhfcBIpQxHMzkU0GnYM1pIyK2m8DOenG7sLb3LftsVvCRLjaab3o+Zj5+YE2UoPbHi1lhh+LthRgKLwy1Gn2202BpNfnnIEJD7ltQcJEjFt2ighp1XLOzJLodRysivvFvJBABYKEObOxN4f9j1DkN5y6Vm3zebeNIgtfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI6vxxwpmfJB6pCNL4rJoVBJxcBJQ6lDUBWEcRhtjSk=;
 b=JkuJS3PurB9hPPQhzOxYtBNMWrZDN7Twc1essAWmwKRkAAg4dU9JNQVzaZnaZ2G6n66LJr51MX7nPgeKFZXRze5TzNdQKu475erVLsTtVuw7oKH2voop9veIouasbp8ExJXNNf2YkQlbqJsxu31T1BcrBPPe9QTfMRhh6Qp8aBe7/8ltl7qVpzSv3auj/yzdbYauTzL3MHUhszBDgUrOLJ6PDYppt4IKzIsTTRdExDp5jTx09iDp6uj3gPZaJ/cgkq5Yd+C2ahiH2HauepKsgC/zvnzkcBc5lo0wj8adPa0trk7DEQO9SqBoowbtd2voUCAipcAcBzawOApHPySHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI6vxxwpmfJB6pCNL4rJoVBJxcBJQ6lDUBWEcRhtjSk=;
 b=PoGKodLsAhuugELmvRzDhpAqy6RQiXX2y4qqJLIzUz/MDvbwOA7W2Y+9Qb+WBpWbWgCxUVh+Sd+ZxRW1wA1cwzIBmSQWah3f9Vz3cnoEqDxf9HAZQvKThQlDlXpfTNAU52F8HjXud1877PG7V8ONQm73tnTNZxuOUr7sKjWlF5+tblA8XbdUIS6zT5Gprpbr8B4f4bwmfeCoC6Ttub97ZZUhOWLfrr4TSri4scIyJNuWk4X0nYBCbTul9Imo0T3rkDDwNAhgKgyfYMQcajS8vowbKeuD3Oj7mxuRySFw7eZoqUm5AGQ8hNR3DS9TbI+eIcszZ7FG0jei9aWfoprXHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:33:48 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:33:48 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 sjg@chromium.org, Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 1/3] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
Date: Tue,  3 Nov 2026 10:33:36 +0100
Message-ID: <20261103093338.963328-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103093338.963328-1-felix.moessbauer@siemens.com>
References: <20261103093338.963328-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bab4104-62e6-45ca-2fc4-08df398d8f6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|22082099003|55112099003|3023799007|56012099006|11063799006|261022105027099003|261021135927099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: XiKdHmRe09WskMBcMYJu6Bt9RaKO4uedvdZtiG9wh5go5Uv/R9oR3IXe6dxPqAHVe8AHN77TrngTCv5o0WxpzSyNUJwMiB8VKiKKIG4shb77OK11cv/sVEPAtEzUHU1b12K3392SG7N03QlatN4yMLoKyloA+RKxtgiTTSYvuZtPhhkZ0lZgVzQXvg45Jv26kjggIJsXmc5KMZpyySpIOVP3JVi/V48GCNMVcxvk05TUB+tYn4y+0BDP/rZINOiQo28O9nOYpNasjTfFgHuunIg0hyWXNq4s6meK890sOd0otmyTUR/FqIv+NPil+fFJoGiUmnZD4TPNsK51EbWx0CGIRa0ujleQ5Vw+TEuWqTr4giWKN/AMQDSvFrxAeIWdbJaOW8E8jTDN14LByHi1fl1mlrqYRqWEYWGFwvdBAFUqebjfc6zeYgrqCe7IV9EyiwMDd0BVytilmaNY2AbdIJt4oUJBAjIKbMcMgErFdVGISmdh7KYQJ5UZjRP17UHM07mFLRVyiGWhm2Z6GSg/IzTekK43TpZENGMhrcAmpXFFP/iN+zcVOMbwhYdQL4E9qV6dKPwanxzslF1cQGiFixONv6QFyxILJ1C0UhmZYQNg0DYcrfA8Cj5dkTJJUbSNDA/euitTVOXt7rsCTmqANxfaCEXwQSJ5DaeLg/O0bK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007)(56012099006)(11063799006)(261022105027099003)(261021135927099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xz8i0sXLpOgw1MGzs0GocCb6jYZsiKF+O5fR7CvbX4LJZV+RcvVB29knf7C6?=
 =?us-ascii?Q?DPSR1WRUz8/6adj35AnKgeOCTjzw2dpweG1yJOrLu8M2iphKwFspV0iG9YMa?=
 =?us-ascii?Q?HfrQcrR0rHMJ3Ww5um0Zh9avLNkDoVx2LETm1Juq6pP0a2lkdKGxrZT70k/5?=
 =?us-ascii?Q?x5uWECNMLkCrP13LaMq13HP6eJxvVAiMhRruYWW9mFNNI4hQagXVNANkQKsC?=
 =?us-ascii?Q?p/lWD9kbImTulK73dffUaJpSp//fG4nCjB9HnyxgUTtZ2aHYjmnvaDqXHhUx?=
 =?us-ascii?Q?B7ERChu1xo/tc8eY1HcfD1XZ56afWP5ZPHYzMON+mJ6HCpSoUKjBui3Cenmg?=
 =?us-ascii?Q?XYrjuKxusg7zEj8IliTj3aV4xuK0AJv+hcZ/BO2LdEaxvT1fzuX0Cz+lwXrl?=
 =?us-ascii?Q?Rb563/ij9/CdNHo2nuJ1Um2/QvcJdE15BK+R7XCvGnbwPtiOjSmo5EGFsRze?=
 =?us-ascii?Q?/1ihlFug5JfSPD1B9WYl6JxBAnpoPTqmFWJGxouNkWGI0khvxdiLtDjxeOVJ?=
 =?us-ascii?Q?YL3onZLJvEZ9ZCMpgtTX4uXR8anOaKI9CpT+apMr8i+kwitIoS4uTbVwMAXr?=
 =?us-ascii?Q?2eK6p4DiyBcRZOTndx7xe/ajt20+Oy/zBynO2He0HgBmNPaGm97VpRiKY8uq?=
 =?us-ascii?Q?HlJvE+Y5IjBTSaVOfSDDnAyZ9wutQca76uBIBkwKp4uDvZ80QMogW0aLuu3m?=
 =?us-ascii?Q?ZpDalFudKDqK+HdJRbmVfse6o7kK4q5/QJKaCOLoQwlWAWrgb0CM4KHyXz0T?=
 =?us-ascii?Q?EPJkrQvqvJUbIXuJC/fCVRxQmgQylh67huZbzdSwZdafBam03Rx/uQTVm5xV?=
 =?us-ascii?Q?pzNJydE8JoDL4pG1zFV8DgqsUSTezeIyVzv9VPgEuB8rJ7bNQtJWlVGR9TAE?=
 =?us-ascii?Q?hSsrFk3a83eV6gq+Oe7e7WiOGqAjxh/MhVS7Y4yhsrtLc/yzHnk0rErp3w9X?=
 =?us-ascii?Q?8VoO3uVaPV4VcQnpNxmTyAUF7HB0nZUCnAoD5zyZuvS1RwVpNDSwdOX1j0pj?=
 =?us-ascii?Q?rj3ZlTUoH7k8MYiyInKJzEJaWeURrVFjXcYSM4kWPDPfO7GXSLY3gsFYe8Vm?=
 =?us-ascii?Q?NMJIY4VIO+HvS/wKz1u4GS08ObEtUl8/3JrPR01Kcs26twPoijy8GtquSOOi?=
 =?us-ascii?Q?91MNK+TQVlgOmvbbvkdHHORnzTPT+E/l3M3a4/SQ+gSHsXRB87Z2lX0TbvZ7?=
 =?us-ascii?Q?jvvzg2GhV1cIxnfrbmOhxSkOtoZaUhuGhGF4rh8gCLjLy5WXIJ/Q1rmpTk6w?=
 =?us-ascii?Q?nZpNreGtfgxUER7W/fI2n+exQrt3rkkvGtwEJB8156bCCqV86c8x0PA03x7n?=
 =?us-ascii?Q?91XxAYU9R8s4AY6AHon5yiNGmDCdTbdiPvCjQ6TgKz4cUhmg/NMpiqJBIwAM?=
 =?us-ascii?Q?W28/M4/3zvmM1wJNPhYKhfzqeRIYJETh0w1zwzNCPc0hKzF8sOvmGXveTneS?=
 =?us-ascii?Q?PmFVgOnQniNOM3YzlqKBqkhNFODECmaXYpVn5iQNZkOWvX9kuPtoizGPEQgO?=
 =?us-ascii?Q?w0UrDrrdaNR9lL0Aom8v1hW0g/Vd6n6F009LSdwLTENv5Oe63I65q4mJ4Oe0?=
 =?us-ascii?Q?59RYYEWkP0F+6tcXbhvbY2IDclxOP92boirLbBZddRu7g9xnpsDpEOi8OXAi?=
 =?us-ascii?Q?Qv7ad3ToY3kFlPY5g/DxBV5m934wJPKaI/pce9Q7fvjKOFtHnWEOJUxfvQJz?=
 =?us-ascii?Q?v/p8QLsxO2RMepXPhCbn+su81y0Da+a1DnEFFpZ821t975C+8B2g0R1qDkY7?=
 =?us-ascii?Q?aWaWS7PbAZfVF4jDaXIblL3snUlEC2I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bab4104-62e6-45ca-2fc4-08df398d8f6a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:33:47.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3yIDRAsDMPxiOxszGBbLOZ7jm8Klf84kxwKt4Sh91lkV8ZCVLQv2rrbJkAQN/xRHMhhUqwXEQdN0zNV2Kyh4lIhjEBfb6UbjQMaAMn7IXM=
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
measure the time spent inside the bootloader prior to loading the next
stage. These values are then forwarded via efi variables to systemd,
which exposes them via systemd-analyze. This helps to identify where in
the boot chain delays are happening.

Without having the protocol, bootloaders have to fall back to direct
reads of the time counters, which are architecture specific. Implement
EFI_TIMESTAMP_PROTOCOL in the EFI loader so that applications have an
architecture-independent interface.

As the implementation of the protocol is tiny, enable it by default. If
this is not desired, set CONFIG_EFI_TIMESTAMP_PROTOCOL=n.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 include/efi_api.h              |  4 ++
 include/efi_loader.h           |  4 ++
 include/efi_timestamp.h        | 35 +++++++++++++++
 lib/efi_loader/Kconfig         |  8 ++++
 lib/efi_loader/Makefile        |  1 +
 lib/efi_loader/efi_setup.c     |  7 +++
 lib/efi_loader/efi_timestamp.c | 79 ++++++++++++++++++++++++++++++++++
 lib/uuid.c                     |  4 ++
 8 files changed, 142 insertions(+)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..9789237b025 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -475,6 +475,10 @@ struct efi_runtime_services {
 	EFI_GUID(0x3152bca5, 0xeade, 0x433d, 0x86, 0x2e, \
 		 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
 
+#define EFI_TIMESTAMP_PROTOCOL_GUID \
+	EFI_GUID(0xafbfde41, 0x2e6e, 0x4262, 0xba, 0x65, \
+		 0x62, 0xb9, 0x23, 0x6e, 0x54, 0x95)
+
 #define EFI_DT_FIXUP_PROTOCOL_GUID \
 	EFI_GUID(0xe617d64c, 0xfe08, 0x46da, 0xf4, 0xdc, \
 		 0xbb, 0xd5, 0x87, 0x0c, 0x73, 0x00)
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7b865fe900a..dd91c953776 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -384,6 +384,8 @@ extern const efi_guid_t efi_guid_cert_type_pkcs7;
 
 /* GUID of RNG protocol */
 extern const efi_guid_t efi_guid_rng_protocol;
+/* GUID of timestamp protocol */
+extern const efi_guid_t efi_guid_timestamp_protocol;
 /* GUID of capsule update result */
 extern const efi_guid_t efi_guid_capsule_report;
 /* GUID of firmware management protocol */
@@ -674,6 +676,8 @@ efi_status_t efi_console_register(void);
 efi_status_t efi_disks_register(void);
 /* Called by efi_init_obj_list() to install EFI_RNG_PROTOCOL */
 efi_status_t efi_rng_register(void);
+/* Called by efi_init_obj_list() to install EFI_TIMESTAMP_PROTOCOL */
+efi_status_t efi_timestamp_register(void);
 /* Called by efi_init_obj_list() to install EFI_TCG2_PROTOCOL */
 efi_status_t efi_tcg2_register(void);
 /* Called by efi_init_obj_list() to install RISCV_EFI_BOOT_PROTOCOL */
diff --git a/include/efi_timestamp.h b/include/efi_timestamp.h
new file mode 100644
index 00000000000..0fe0c41b62d
--- /dev/null
+++ b/include/efi_timestamp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Siemens AG
+ */
+
+#if !defined _EFI_TIMESTAMP_H_
+#define _EFI_TIMESTAMP_H_
+
+#include <efi.h>
+#include <efi_api.h>
+
+/**
+ * struct efi_timestamp_properties - properties of the timestamp counter
+ *
+ * @frequency:	frequency of the timestamp counter in Hz
+ * @end_value:	value at which the counter rolls over to zero
+ */
+struct efi_timestamp_properties {
+	u64 frequency;
+	u64 end_value;
+};
+
+/**
+ * struct efi_timestamp_protocol - EFI_TIMESTAMP_PROTOCOL
+ *
+ * @get_timestamp:	retrieve the current value of the timestamp counter
+ * @get_properties:	retrieve the properties of the timestamp counter
+ */
+struct efi_timestamp_protocol {
+	u64 (EFIAPI *get_timestamp)(void);
+	efi_status_t (EFIAPI *get_properties)
+		(struct efi_timestamp_properties *properties);
+};
+
+#endif /* _EFI_TIMESTAMP_H_ */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c4b0c2137b8..25e2c4b1144 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -469,6 +469,14 @@ config EFI_RNG_PROTOCOL
 	  Provide a EFI_RNG_PROTOCOL implementation using the hardware random
 	  number generator of the platform.
 
+config EFI_TIMESTAMP_PROTOCOL
+	bool "EFI_TIMESTAMP_PROTOCOL support"
+	default y
+	help
+	  Provide an EFI_TIMESTAMP_PROTOCOL implementation giving EFI
+	  applications access to a monotonic 64-bit timestamp counter and
+	  its frequency.
+
 config EFI_TCG2_PROTOCOL
 	bool "EFI_TCG2_PROTOCOL support"
 	default y
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 567db518a8f..8ff5468ae9a 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
+obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) += efi_timestamp.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
 obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
 obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f302bb62ab9..f0b3e59c3e7 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -325,6 +325,13 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 
+	/* Install EFI_TIMESTAMP_PROTOCOL */
+	if (IS_ENABLED(CONFIG_EFI_TIMESTAMP_PROTOCOL)) {
+		ret = efi_timestamp_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_RISCV_BOOT_PROTOCOL)) {
 		ret = efi_riscv_register();
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_timestamp.c b/lib/efi_loader/efi_timestamp.c
new file mode 100644
index 00000000000..78cefd7a8c1
--- /dev/null
+++ b/lib/efi_loader/efi_timestamp.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026, Siemens AG
+ *
+ * Provides access to a monotonic 64-bit timestamp counter.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_timestamp.h>
+#include <log.h>
+#include <time.h>
+#include <linux/kernel.h>
+
+const efi_guid_t efi_guid_timestamp_protocol = EFI_TIMESTAMP_PROTOCOL_GUID;
+
+/**
+ * get_timestamp() - retrieve the current value of the timestamp counter
+ *
+ * This function implements the GetTimestamp() service of the
+ * EFI_TIMESTAMP_PROTOCOL.
+ *
+ * Return:	current value of the timestamp counter
+ */
+static u64 EFIAPI get_timestamp(void)
+{
+	EFI_ENTRY("");
+
+	return EFI_EXIT(get_ticks());
+}
+
+/**
+ * get_properties() - retrieve the properties of the timestamp counter
+ *
+ * This function implements the GetProperties() service of the
+ * EFI_TIMESTAMP_PROTOCOL.
+ *
+ * @properties:	buffer receiving the properties
+ * Return:	status code
+ */
+static efi_status_t EFIAPI
+get_properties(struct efi_timestamp_properties *properties)
+{
+	EFI_ENTRY("%p", properties);
+
+	if (!properties)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	properties->frequency = get_tbclk();
+	/* get_ticks() extends narrower hardware counters to 64 bits */
+	properties->end_value = U64_MAX;
+
+	return EFI_EXIT(EFI_SUCCESS);
+}
+
+static const struct efi_timestamp_protocol efi_timestamp_protocol = {
+	.get_timestamp = get_timestamp,
+	.get_properties = get_properties,
+};
+
+/**
+ * efi_timestamp_register() - install the EFI_TIMESTAMP_PROTOCOL
+ *
+ * The protocol is installed on the root node.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_timestamp_register(void)
+{
+	efi_status_t ret;
+
+	ret = efi_add_protocol(efi_root, &efi_guid_timestamp_protocol,
+			       (void *)&efi_timestamp_protocol);
+	if (ret != EFI_SUCCESS)
+		log_err("Cannot install EFI_TIMESTAMP_PROTOCOL\n");
+
+	return ret;
+}
diff --git a/lib/uuid.c b/lib/uuid.c
index 16ca8f37751..d7022519f0e 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -189,6 +189,10 @@ static const struct {
 		NULL, "Random Number Generator",
 		EFI_RNG_PROTOCOL_GUID,
 	},
+	{
+		NULL, "Timestamp",
+		EFI_TIMESTAMP_PROTOCOL_GUID,
+	},
 	{
 		NULL, "Simple Network",
 		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,
-- 
2.55.0

