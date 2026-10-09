Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C9CCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A432D40956;
	Fri,  9 Oct 2026 17:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RvChSNRIGkN; Fri,  9 Oct 2026 17:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBCC94093F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565593;
	b=GzHUDqMPw4UN4Q8ri6CqizJCn89oKGzyHtYs66XKvNTCoz6Bt0FyxCqufITSX9QmtXYd
	 VZ/a3RoEexu9vbX9FfVKJ/u+6XfUfNIsDG3gudGItCC9Tsz09mkGvvOewta6lgtQWTPGR
	 iMirH3e+cZeHrN/mryopWGXwz/FLppsruhSTomPYSjBL7rNR3GyTHBhzNJ3DlMNRVuiK7
	 fwlhWczWaUzbZF5+uIFlvFBcz508qBsq06e8FSi6J4QRGwLNkEsz5nQhU/+TDWBWpP/ly
	 xjRQT7ko1WW2vhTc74XU2rHxgE+S23tprIcDGp6xoQQriIKuaSiza0FloXc3ufZ/rHA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565593;
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
	bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
	b=h5uoUmndDBBBNPs6HqPAwBA6qoiQtrgfcoI8d9dArURM1UwjdB2q2WKEYD4Tjn6oDSOM
	 M5AxgKnPiqE66Yk1UXVUUVi6Nk/cQHw+/kMK/MxFKs56/01onO68HikdOeeFcc1qE1jWh
	 EXmtpGD1ZVBBXeLnBN0bxlkpSD2upkYH7RvBJhdTuJOv5nW+1vMrAV2NEt6bQ68zVtr1E
	 UfSVlbZE5uH+Po+wmgUwx2TpZM56JjJDzUklxDG/vMhsJRhcDbWfeGSw6IHBBb3R0Yyzw
	 3/efg5IyPS0I/9rK3X12XkCn4dwOSvSpIYY2IzCBhmvWrdL8MtF/G4oAtwUo28bbhsw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565593;
	bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDflK1VPswqYkQXi4wAmElcKfQJcGMolgkmeKrF/34aWbqB7ZESrR3orXZZnci9Vc
	 d5Gcvy1bNzRPwYJzwyVEHv1OEVY8W/C90GcvYnzR9CdqZAV98y0qqy16zw/nvzXldv
	 0P6mY34MYMNvdL7upT0/qcFf3uzmkKYu9p9RimQWZP15RI0MDkDvVVdRpoQCligi7p
	 XqgmYnf62PekdjfWNcfY6tN0IptsreBA/4oYXQu651DI72M/Ih7ld5ugis0kFhEkeR
	 mvxnf1y53abZjQq5tLkqbhlAS/tyz0DkE3TNy9YjxNPuTLXx6q+IlsRley/y7zpLhE
	 xsiXUuZzeO6Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBCC94093F;
	Fri,  9 Oct 2026 17:06:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1730475
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF71A40050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAoQkntCL2YL for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 21F14400FD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565589;
 b=SzxM2ic/gA8FLQs+m8Xp6GefJN96IBJ72iP38bhCpsxxSoiCx35OM0q6gqcnoOslBxwr
 9XxL2033/R6o/Yi9Y76oKpV8RQEvQjNc6BM5uypbB6NrYeMHKHjRv4zDNdwbiizR/SSfI
 Jdb307Hu3g8Qp8qIcIuqCqlUBZbPlNuOnY5+G1JuPp/O1EBMQmxZt/SBgxD2cp/f0VFgA
 nYJEWe6KVDJ1TH1zjeuGG9cOknBHx1I1v8AFPd6a0AiQ6Qw0E8ujy1f8swaIwlhiFHEyF
 XIarE0m5fXB7DUY/Qkimb9SXfQMRO5VOvwhJ2GQ3YBoH/EG4UOaag6VwRSvsg9xz9Sw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565589;
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
 bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
 b=rlpcCx0zrGWmrwBCv9m6imsymEXUqmJcHbfZ48FoZoreCOC8hx7W4Eiw1tclLGqinCUJ
 raAVDeqkxY8+KRR1fVHRYQJRe7rbN8MUMBHIhR+fl9AZlRsyZhVuFTcGQ9ehD//AI4ByM
 l1E8u9XvtCnthm6PXvfGaAQQQ1hBxNMXnGan8BK33RyJp4CM3NoMBlEjlHmbsdfd2mCd6
 kGIVRjgVcGIt5va2CchvkHi5EgJUJ3sbWzBsBUnA5zAM+fZqwSH4vO5qwNfRDWK3O11F4
 naCyTs4oVJ8kdCmjxeqfV9GFYwktIVeeog6praqcJOek/Va4oZ8sBIeVUUBUHktWx4A==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CQ0Z0nPr; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CQ0Z0nPr; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CQ0Z0nPr; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CQ0Z0nPr
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21F14400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pcCaANJPBmDS3O0R3Q1Kz1ivGqsV/nTwj7eXC6BWMvJHQLwV4N1XNkqYFboiwf99WeEEDpQdXhSVCGa1rw3YCwk+1kc4EJeZ/bMPW92nuPelFhRvb3hYCi8J2KG5tqce9h2aOnXA+ZqgkgxoWeRGU2NOLufrwCY2snJmbM/Rb3vZlWOiUMixVtwcfzpv4I6YcEUSF3Qff7KrCVtj92yKH9rlepq6kiiBCsAO3g6zUY+ooBwBZN3uCGGi8zdeholnov8Cwlivu5CfUjs5wx+5Ds7XMpQmZpZ5D1R7e+STo2O0YB26QXpvfqigOjewBc18XHZB4LQb3VBccmEZ3pn7pg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
 b=rS6nUc7962tg3uz1xOsQz3/gv0Nx6VfN2NpgmPv3N1dSEhgUGCCh24beroiCwcRml/j2T4z/y6iD4zZNu/P6HOXDkj1Kt3wlLVmD+ugj3a2C4IKiILw0XjPWrkrCIRG4NfvKH8A/H5MDfd31GqpTxdKIxw4cOkjJmS413toDniyCErUfQH25ZBP4MEPToinPHwvXFM4wfEfdZ8XQXgXKCTn2WQnRtSBPe4AcTGSR92NHJzPRGKpDz0Ksxgi6Fe8W550FgJpV7hjNhlJnZLpyH26YlrZnueRnOi0KFyOfPd0wMIeAFdR9/i/1ewESyFbb9JzzPytGSRjbfs/qy57hsw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
 b=CQ0Z0nPr+9LKqXHN1LOnSaQmjkzhsbLbNIdYIyXzc34tKraqrrvMNnJZiuys2dTcH2lkUExopW8c90qvcYAgo2kAq6icOa0thFwezMIXA/UvSEtyvzpiUSPf0sGhqK0Nxp52F/awidlLKIyabHp71OPPglFLUREpDT2GOc/WDHg=
Received: from PA7P264CA0122.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::10)
 by GVXPR08MB11638.eurprd08.prod.outlook.com (2603:10a6:150:326::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:06:24 +0000
Received: from ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
 (2603:10a6:102:36e:cafe::5a) by PA7P264CA0122.outlook.office365.com
 (2603:10a6:102:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9Es5//CmMOTm4/WhRSXUBBkB/ZWGAwLAhKh8EbNjf+wjMQiSXLVU4KqYQ29sqE2zxAGPT7UlrgPxXsEN5QsEJ4amszTcq4xYQZdsWtY3GOINpq/2ZIxZGA3rzpEox/h1WOGbtN/CoKX+K4tFAZd0HJm0sNXgZ8VQ5ENwh4Qw+QM3QWBS8GYbQgNrGGf2DZQmkfn3Qv8/MsVDs2TFIQqVtKiaTNa+i8yAGRMrshQMektQzk5Ox2vU3jnoDauMH3ynXw8bXOAQJZfo5us5VexQxkjQo6aDSufb7WKFIdrDxpzSzxFoK5yeCHiSu1DgzCAYnQUgt2dszuLMarXnqQCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
 b=ZzJEzZorC4dSiUSbk3KuZxhz3cKht04FQwjV+bojTmuF3Kk1ROop6R41W1rp9CSuhGQ437Ytf5ywVeAyp1h4HMwTbkdDEIGPfBi12kLEOyxIbmnlKu4sxHhKlkTHxFrid79bpFCPuEhQ10sIOQIYhb3kttfgZdgGdtKMhIZOtvKcmWJskliwodfoX5YmWwyLvPjbZ6hyZI2Xy3cE3hhxw8d77QlX/kCHqJC2FHxwRRhKOQy0ny4zgzFtXimzxLZ8Ay7ghBBCRsytXh/Iboz/PQYR+ZLOM5EhLDiyKDf/3EKMeF6jTZS07j3xnxBQwRNsvKRSl6pW83EtFJ9E+O/EYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0+KKbaXJ7A6Jr36tzTSHg+dDHwSwkkBfOrnsvZOLLw=;
 b=CQ0Z0nPr+9LKqXHN1LOnSaQmjkzhsbLbNIdYIyXzc34tKraqrrvMNnJZiuys2dTcH2lkUExopW8c90qvcYAgo2kAq6icOa0thFwezMIXA/UvSEtyvzpiUSPf0sGhqK0Nxp52F/awidlLKIyabHp71OPPglFLUREpDT2GOc/WDHg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VE1PR08MB5822.eurprd08.prod.outlook.com
 (2603:10a6:800:1a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:05:50 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:50 +0000
Message-ID: <9865ac37-b473-4131-ae12-e875d96430cf@arm.com>
Date: Fri, 9 Oct 2026 19:05:47 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/2] net: mdio-mux: Recover gracefully from bad parents
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, nd <nd@arm.com>
References: <20261005135551.510145-1-sanderson@brivo.com>
Content-Language: en-US
In-Reply-To: <20261005135551.510145-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VE1PR08MB5822:EE_|ZR1PEPF0000E6B7:EE_|GVXPR08MB11638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2a7a93-1e2b-469e-0fe7-08df2627a5ed
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Gp6cVYGFE0ddwunoCdWjQFiy7nD1h1TPUVfD/ol8AfuDvkdyfKWdctOYRNN7k3cHdeuJVjh0L0hxoWQwxY5m/D1ZWBZJb0UkTJ57HF/HP44A5s9tAW7WcXBwNuktGohvTLfHfxgS8J6leuA8XROPpzcMRHDo7PRKMdtb83a3GVmXavQimHduRZ5rOe2lHOEbenrJCrvr7B/DCg6ttR7qwt7jTwZ/FpdtMlZTH3BSk5/EfuM2PFRTBFeVbeOH8XLuRHAgoMUKZdOQcgvmjuryvunXs0DvJBY+lg9wmr/TDeDi1hp8+Y1000FE3o8O39w6mvzvvuRNs8Mn/MN3idEFYiJN9uX8BYRe1uq0lPY/evpxGX0XIu0jiX1GAn2ltWxfYtoGkRD5181LbZBVVQ3DDVNQyjuuNQ8gx691SmuksZNtt4CpIgdhQznDqnWUwpmTj9DSlIoGv81L3Fwga3Oh8ojQ6MpoSjKcLWQGxD/Szj70RbCiO97DR9ZS39CGmpwBz96Hfnh67HDyp66vaQRYfqDhd3qJ+nRhurY6AkMDk4A2mDfrGWZCzmUHkrKRpdxujjvkrNbYtR0yu4SromYUqwTzr1V+nkUBaK3nMQfFI0kFkeMY50Ue5GXGCfaL8LJkIGB3YqceTGyd36Sz5DjZDMDDzVCtOr24XwtnoWUuvIY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ERlRdPPAcMml/LgpIhyg/GmyzvO8y3jxjUIG2tGA/N9DVXYafXX1ERPPt0uqC1S5uoL42MrEh8QWmM3Ppf5l/x0irfPXGq2R70yMCtZJcB7Xez3TCy6X4G4dr80cPLv5bS0hlf9SZSB866QMsoFjDzq0A34oPjqQ8W1zuXaNvxGrA9B6VFjEe3YUxm8WNBeXBUkmHCJgAIjuG4P8Ai4sgn5YDYiwvFu03NWc2G17ZVZmCJEG0uAgogWlYonS53Gd65CDgCD+75RdntxC/nD0PdUAA8dlGdNTdK8q5L97x2pJP8hAGfBdv/je2pHmZL7YFJJmGiS2y+rODumOry17zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5822
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3420294f-bf9f-457c-db56-08df262790de
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|35042699022|14060799003|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SiZYw7e/uBWezw0tTt9w9YhJe9Ez+mBrLRBIsTmTvEgd6by56CGolBgZyvhJMZCxV3tR8GSoI0+lZ6+aMOp+UsBpF0TYCynfchNCcZHDCIZfyhXepJUDpN1SUkeQI5mAgo1hZ2cfNWfMSXnXV1IBA2FzO+KiL4PAtOZ/N1Li9COpMJy5NFnsz/LGHHtngBG90zXQsI4ec81c+UYSVsDvjWSfKCFQ2Vb7lQEZTL08f9SRnjsyVh3gREW0LxV5F0G4dBjdlKgbHjfFJ54IdIINSpOSyGcbSQNRx8WoLLky5Xl6rXfffPYzsGrr8f9ZIl9bqax+derxdqWkEtGqrfiKehEISm3K0m7vFmBth0D857XGY4LPeKlAWaHKDtZ2phGfU7c4lSDLKfhuAkXQsEndEg6DTGDexDgo2Jm7VLfA3Q4Qz2StVAuPeE875846DXS74R0kkeDJOTbO/Tebkvryfz5MC0cHqQO/2Ro1kJS5UtdQT3s0t00x29N6YcIPAEdfc9rZgvCrIgR396IhD01eRlGI/8tlcOxn+iiRwS63TStW8YsondKRVV+TunXexjgfwETESOKJwH/x0NGQggC7Lk8Brjp9c944gA+VJDS4J/zvNezKmGLaKKyeh1hEElAzCE/FI/23hahd5K2cyZ4dgN2JGgyAQqRrKJixogNjon/FbqI2xxwE+RafitrPafMY9tMmNnKbmmnICOWlNa4/Bg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(35042699022)(14060799003)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZbbotNtVU2uYFiBwG0KgXGDdG5SZ9+yriz/SnFYmIlp0EY7VUAB2ZxLMI0tO325GFZAVs5bU8tpbe2HjwI++eeCRQ4LypObMMfttVTdeYj1AGXeOLqBKHlTrZjtaj1seNUg5721UfpScw83FmFpUhA4VzSoz0syOI5MPeQ16++BMbHY1FTykdxbN06wWJ8PqoyTd528WsBv4NGTd/80PWRSuEVpLyMsB5QvGGerM9Dg2gMln7lDfC+/AxSHKQcfxERxdgr7hFWrZTjN+h8v1ypDoZEaJnqOdv8l09mk4CaQCovZqfmI+HRCf1KOzoyQMFCYkfGpp2EH+g5LMLRI4P3DDvVA/d3/9qixBKQJRxqoCBRxQmjkudvOEE6tEzs6XEmJ0XOKa6KQJJmj7dD1zm9jJ3sP0VFCoJ8lP7DsDywPinVzoAAixjfEgxtWBgmjB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:06:23.7749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2a7a93-1e2b-469e-0fe7-08df2627a5ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11638
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

On Mon, 05 Oct 2026 09:55:46 -0400, Sean Anderson wrote:
> This series fixes a few bugs I ran into when the parent MDIO bus doesn't
> behave. You can reproduce these problems by running `mdio list` on a
> board where the parent MDIO bus fails to probe (such as if there's no
> MAC and NET_RANDOM_ETHADDR is disabled).
> 
> Changes in v2:
> - Don't try to get the parent unless the mux is active
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: mdio-mux: Don't crash if our parent never shows up
      commit: c89733c1f43383d447895cf94fedcf9ed57b8101
[2/2] net: mdio-mux: Remove ourselves when our parent is removed
      commit: 2e27bbb8803f40ea828b3a681735d47be5909ffb

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

