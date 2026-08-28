Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AC1C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DDB740841;
	Fri, 28 Aug 2026 10:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2S08y750APZp; Fri, 28 Aug 2026 10:50:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914223;
	bh=PbHSFnlG6B4Z1OF3yJB3mpLR6iQFwPbIiu/HrutgUis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ObnDlBC5/Pz1AvhXGhWGRx48s9KfEZTZKx8hoKMStma1KJV1gxgFGWza8f5i34nKO
	 4mnXQ+TUgVhLRpv3gIcOLuA60V/GxK1ekoydSKnkT0pQUoVny5oN+274t40IuRVDVJ
	 uyEIvXmcT7oM/DdfzwWgBOPMCwRVFybhBlyX1sRESeGXzLom5YG4L6dVFhumQ97pK1
	 IjQdS9XCbY5VRvJnj4fGRfqQDHWmBKCYPmHRNRtYBDJWWr/FKhV22eMU2DgZRKlWc+
	 sBYmH/tNvm3JyhCZjUUAJWYD0g8fej9/vrmNrXnr4Lyp770vw3UBYBOZBmo0FOWW5z
	 61he96HlM637g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B242540830;
	Fri, 28 Aug 2026 10:50:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 475DE105
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3940240834
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydyUaXhOvtcs for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:50:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=f+eujJ7o
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94B0F40830
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edqjsGZsDUe56A81umTrIEUCEaOMdTXVxIcrmzqzFdwTiPtBPhB66Ufv/IoaYDSpBAwJnAbunvV+8xhnGkk/VoLKeI6xcGiqo4B2oE2xF30cB7Gg5681j0crLV7z1U9kVqtkGQ3wXHgPTvKkF28a1gBzAnpu/y5WrdQx5sn3xlBkkNdWZqmwPzqMBVYbgUdnNGobNzssdc3wa66SFCvXeWgtdNtesJJgkcnZYzjYMg85sPeFH8Jmbse2drqsRhyGXVkftTVJtaoziWgm2suf0Z9hFjsKZZW9UVcXWHjSZghmx+caRJBnOy8pfvqJ9bXn+mdgR26owymVsdK0gU+mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbHSFnlG6B4Z1OF3yJB3mpLR6iQFwPbIiu/HrutgUis=;
 b=qCDzMl9AKkIMxlVykMfElkLraCMj1uDVhFCqSsTjf+fiGCIZ0Yjr+gL7qeAk5s/CQ+pMPF4n8UAl8GkR8eiSB2mE+bgZCdyQ1k0kID4cgwKv/PV5V9V/couYTkeBxyA2VlXAhbSVJBZuQlv54v0B2OyOlFtYlXwyfUcZOCfapVcw7YbLf1+8yEn+c3eLEVxpranfDruk7jyC3yiIJfxNNU8SJu1+rqm+G8GskqUhrS9/tWTUr9XM38kyulRGJ3saZ/aWVZU7Ip3A0bUUuL06zSisE0QJGSIzT9cf6s2dy4GIbp18686UJM6LbKXwd5ruW6+oxuri8rNzxQUxuoAs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbHSFnlG6B4Z1OF3yJB3mpLR6iQFwPbIiu/HrutgUis=;
 b=f+eujJ7o4xwMUK9atP8ExSC/CkIxQCvUucOlQqiYj4iOwPXDOmsvWiHvprwimz/wmb5PGlZQQUtHOoncZ0Z8VjlPDBlbZwd8RXpm8WCFLaFQ7A6tDMGbgr6cRGdD/xlDD17MKXPm7sWLxI658Na9d9EsrQ/fM8Relbd4Rnjvf+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:50:09 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:50:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
Date: Fri, 28 Aug 2026 12:50:03 +0200
Message-ID: <20260828105005.200338-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828105005.200338-1-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBCD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ab) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf193a4-a183-4dd3-6827-08df04f22146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: smVbmTkyPOqGjtEm+8IGdtM+n4Kry7RJkKObDP3kwmf6NejjanD778LuxINMxkmzCDF0yQYVrrrO0GmmMtKaPbxvsfmJ7SKc0jcv2FcjmzgCN+HISK4En4OCpnCzqR2hk081lKZchcvdI6y036yv24I70OiWTaUTmmyjHufvjKLKDbfPNNjigoMHbUXIZunKIidbb9j1Mhg2Hbbchhhc14BQEwbKclTXES1TIyxgvBnDDD8pSIdTlhwSsuMldCY9kb+5iDykNMZl+mQD4yQn+pBsjoQXNcPX5rjsMH61G9YdEwPokXsAsSDVnEWCEFrtCQXPC6OdXbaqmN3KSaKTVEOxDlUKyQL992mGN9CY/pk3Fuz/Bcjlri5i/jYdrAegULhy+FvDE5DCMOz4wXqYSVDY64ONcdDnreRYNIEBRaXpMwD1yuhG9dPMCzb+j81BN9wWZc7mOg75EuFfGlDKo7He3VvFxJV9xJHLJ5Uzdm71LXRUB7Il1MztFmdiIzURsd4ZfLyB0TlY84eK1BHkvNmxwfNfGePt4HL1WQtyr4keRHy4GonjJHFvR7rNjmxn0aUUJ72c45y2tnojAo+giKaWVg2B2TojF8G2vRNsPXSINIAtS8ezbiFOeld3ZVv6IyAnZIh62qeeaEduk2ljVLm0jtfh6WnqpfWMvs0mQZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+tmhJZ4n8vt8grZb4eCuecFxAhT+xaRF+PpVf1chOZtJVOHfLlvN70jl4gH?=
 =?us-ascii?Q?yJZ/m+1R2rNWAd4DubU2sfajNAmbtqxXqPhIuGKaDfgXfjtAxsFLNUfWqEQW?=
 =?us-ascii?Q?DrWWX09chsjSl+OUKFgsc4Vnlm38m2zJnJzO3xhLtYqWpdnmgCDeL4o239tT?=
 =?us-ascii?Q?/B1NwOhyc6UnFejWX7Y8DlR1RWbWv75tCnos10KRP3juG8DTRZtBCy60PeYj?=
 =?us-ascii?Q?fT6ZVxzkWUKCQ7GZOO9tcnpVg0obc3PTGKS54zofXyl601qhTJngkfyCmw2s?=
 =?us-ascii?Q?hR8VHVyY0FOjv9/seuJUcjpxcjmvszseYoA2xTUYjCFBWP30EEPVJeI8T3On?=
 =?us-ascii?Q?blZeW+yrvwLDXr6suksXe1HTn2vMfqy3UnlGoQoyg2l5Tofek4KqeCfFevRd?=
 =?us-ascii?Q?xyG1Wtuiya4+zuUrYtZ4dxX5Am2J7b76bFU33IKZUXz8w4YiZvjfqAg1E8gS?=
 =?us-ascii?Q?4EjlpmUx6mf2+lieXdZKTupsfqDc59orEja2IanMPAHoU/Ihq58ywRm0XEbE?=
 =?us-ascii?Q?4hx1tnyror42r3C80RnYf9jd60z8f8ohllwbaTMGnvco1SRrz8KsiU5h6C9U?=
 =?us-ascii?Q?7H4HHscVBlF/gEWXkdLVRmMdaCVCuQAGcabdqUkaVkZ4C3sqInx4ZyTyCtks?=
 =?us-ascii?Q?5Y20S7QWrS+I1T6rsUFjcrQ+dRqeSVqbCupHBPObQ+1mPtI/CAZzjURDpEb9?=
 =?us-ascii?Q?e4NLajjZG1VMafDveOpiJOIkuUDzdnYhWgCK+kYw3o8x20lGe0X6owHt+o5j?=
 =?us-ascii?Q?47Oj0fmjfrXZzOAhidkFZkwWYJv5VUwngtRpc9zJqIBHecPxXxbuns/XAD1v?=
 =?us-ascii?Q?damHooiS31QyWe7ODviuJtwRj/w74Lus0RgP6illigJHnIqfOUDturjhVBLh?=
 =?us-ascii?Q?nRpjfC8uEjlHFGQtK8f0VqnrrPfx9JUuJJ4MfZjcnh1iGwkrpsbiuHnzqMJK?=
 =?us-ascii?Q?Uupbgz13ZQEVzhbfGvvuDd5dDwH/hzY17Y5MkVGUWKunE3B38yoZFb+PM8Je?=
 =?us-ascii?Q?TS7ytYY5zku34GvbExZLqvn3otxdyyOp0fyOri3KKmIQ8dfeCUFVEHei/ibn?=
 =?us-ascii?Q?7R+lh96kGnq9ACQt7vKwExNxTE0eWzkx2oYmVwEz3tqJ7fwsU9RASwlwSBgo?=
 =?us-ascii?Q?lwjIaP2WI4Q/l61H85PgAQoA9o7RDsNtxR4zKi/UaTlikYjA//AymkDUBawk?=
 =?us-ascii?Q?MnrfLVIa7C5COTb8DdY6byZyRJKcwGVjxVnKE0Oa1GMRPYyNSz0I+36196Kb?=
 =?us-ascii?Q?im6PXHCE3ZIXCn297yAfCjgDGw8WS0wcJZuyjCqrCIKuNc9Zy0O7Hu/zUDcP?=
 =?us-ascii?Q?l2+U820NYFtrGp5VMgIfqo7Cp2HIGJ+uAtTqQBid5r+tLV2ljzbGmmvH2TZD?=
 =?us-ascii?Q?+pjP7zrEmDi4Ff5izHaoODcj7Ytj2t4cz8KvSbnlauFNugqzB7WlerEMxdpg?=
 =?us-ascii?Q?iQAdUZ75NmKo/KQG4L7sKD+nNaCzH/RGWRpcFVCucTnGXZZjjFGgZXzHQLfG?=
 =?us-ascii?Q?0dMsp8pqFWSVf74xl/l92ba3wocolEhea6tGvplOhgvplOeZmZa0sn5a1Yvt?=
 =?us-ascii?Q?H8QXo/+qPXjaSDWSkrBTo8WLRbWui0HKIticRBfBnyQF68yIXgyOXQakM7eL?=
 =?us-ascii?Q?SA8Yf0zmxs/MVOQSi42a8lv8gS3Qg4GewLHdhYZRmoAkKAaSsbfKBx43m0OA?=
 =?us-ascii?Q?n/KxUplve3x1mQP0Ft9UYzmBMGz7tt26yjh24LLzYzIEuU2dfqVAw86pdFTf?=
 =?us-ascii?Q?MRFvlmSCRpXJqybLCdc2LFkFirYItxs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf193a4-a183-4dd3-6827-08df04f22146
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:50:09.8000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnSjxHEFXPz6WTkNcYzj3uLoQ756WzRN5UnXcR7Yx02yVDMwsdxLLrtkhiKftMRxExke1PVn/A8t9O0JYzEUTDjreXaobjwUgiBo69lR5Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
we have -ENOMEM which is more fitting for the former.

Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
went wrong".

None of the callers currently care about the actual error code, so
this makes no functional change, but we will add special handling of
the -ENOSPC in a later patch.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index b155278ee2a..cc384c7041e 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -52,10 +52,11 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 	case TEE_SUCCESS:
 		return 0;
 	case TEE_ERROR_OUT_OF_MEMORY:
+		return -ENOMEM;
 	case TEE_ERROR_STORAGE_NO_SPACE:
 		return -ENOSPC;
 	case TEE_ERROR_ITEM_NOT_FOUND:
-		return -EIO;
+		return -ENOENT;
 	case TEE_ERROR_TARGET_DEAD:
 		/*
 		 * The TA has paniced, close the session to reload the TA
-- 
2.55.0

