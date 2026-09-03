Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C504BC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A9E80FF2;
	Thu,  3 Sep 2026 08:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yj56i7esBYMy; Thu,  3 Sep 2026 08:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BAA780D9C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423817;
	b=Y3VnZ3Phph9LHeEE4Pbho7EtHuRUy4bIHInNtK/2ekhu38VKARHQ4L+MkRq1YNjQvdeX
	 wxEtSbajxFNKLyiX0pnDA9KFUNYFXj6H4wQBXAeluCQesk+h8fhGB3QNQMXwoGTgQIJqc
	 g4E/CwhV8jcqNUCpdR0l2bs2h3MW2OKhaBcTszxme1bew3jDKDayDlxblX5wzeDtaaISJ
	 YRsREdL/RcMErVU6u3/TXxlB4o47CIQIJgluO1Lsm+gMNkFW0uLMmCJ8yJEykDSr0/FlE
	 kwfVEIWPE1wmBkSGds5FZqClqTNYD1FZ3pFbcFgxMOaQAK/qrW/dzNH6T0yq/ECIdmg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423817;
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
	bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
	b=qTeIxUx290Zw+nDwas4SYw/nw1eZP3FV7nRT/dRPJVFCFs9GEsU4sqBJt40q4xD3K2ti
	 FXfNyRnKAcBhovFfVs3mukFoNnNruaQq7jGkZvKtNCUT264ieCTXWt+SPiNYkalAf78ms
	 zo/Ef5DIHflzDdOv/3cUVYu2i8CZM9d3b9wnSfLGR4ZT3ClT0UKl+0QkJasYeXvNU73aH
	 7bnpuJKX1jnjqILVhICz7sRVH+O/7xcvzoTWlNaVXJfR4OC7F2clGx//ZZc9dcR3JRujo
	 X951UgfjLCc3A9DQO7MkbabgPVfNbV1IEAF5jOUgFxEkQ/LTlJn1RQxiqRts/z45U7Q==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423817;
	bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0yViye6wwLFquB2T52ZDGdZsQ9SAyLCxGVPeviurEF3jWE1vzjZzu7miSCDr4yO6
	 7DhT0XAINccPbbsQVR+IQXG/4/BXCuMcaOb8DXB36opGDh37cazS7IWb6l7qEgX63k
	 WkfRVm/EBXLzNm2U7LX9Oxh+/LF4tQk0FAidQui2fGrvdZsDCxR2E2YVx7SDHYAD7a
	 JR+v+SYWNeJ2F4VmZ+Pz0ZMAG3yfwq3RWMYZgLpCK65oD0xok2g7xSw0FdicpKlcQO
	 0/YT4TjCBRsVXblphiSManleUJx6qZETv9TawFiiHjC7/nXejzJhSQmes0CR5KXjYZ
	 ZJ3GSQxevdArw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BAA780D9C;
	Thu,  3 Sep 2026 08:23:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC9222F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8E9540084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICOw14XLlv5P for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 86BB14002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423815;
 b=jvi6hjPWQD8BqFpY7d2Uy+c3V66XsqwC+3nJETR7HZiHj/yhJOte2g3EORbrFHeRStte
 UCGObYei9xtQTH91RWaMmZF2W220gU4E9Y9TluxBQ9cbt0oHO7pOwW1EJkGl8G7cp5Alq
 b/Zgir5ypELeyrc5sf29IzjYAvPTrO4k8ubX9LhS6O3juvhPYBCYBcBe368s/JhcKKHRD
 +g9Qny8fMsbkU7zrTZrRcvZoPdoVKrTSBd0DieOqxTcFKz3H7BBw2mNF05oyYPWW5iQ/f
 W/B2gYjQdQrQrOcAtN2sKSn1tz5j5Juq/6zZz9+qNFAWOVzoP5uFoVMcf2Us8a43OEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423815;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
 b=bVmGAnvqc4m9FCCRssj75DhNhfX0QNaKznuW5hdDjLHFbUviWOHI1kfmOhEAblYSLbu7
 Fny6LMnmvwoeRVybdFxYrffXa+GWS/qtoOH4S9y5pFsTR0uC9rjQOuQoiXMWlENRr8y3f
 FLKWLw3zK0OWgnKGUenB/9E4u3YHRnYNJ7T+2WSdsOgOsz9+bRXPb1yJkNWQUfNpVKIgZ
 CGpTxipJOX+vXVf66W68A5JbF2+Iam6kZY4wuwuANK6/ed7P4k3xsa3TGkjHYZ5h4fBUq
 sMRKEt7h4YyHCbsV21IK3TT8nVrPIQiSGE2w69aFwnFtDXNG6+JomG1zLlJrUFLjKlA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VLQOZdeJ; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VLQOZdeJ; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VLQOZdeJ; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VLQOZdeJ
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86BB14002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:23:32 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r6hBMWUK/zwkt3/DbOs3si9dwffxIoog/qZnja7SZ6OCNhBAKAbrjOgfNSyGCl1bmgLHK6rP/fBAk8mMk9jEQmpux2jwI64HWoVryypEL+9u7GlIxqKNpVh6CGYUNvUTiG3ebm5mXpyXq5x1EgpfGs6RhhexsndqBVHjZg2VwEStT2UXay7LqzsWW3N/f64GsTByMYK89JOsEK5eQ9GqIe2HJUW0G3FdQTJ4CVtYWTwpaoqrVMoBKSrKE1WndU/S4SIkji1igBDeuzGu7Lvux9vWojRPuF38QSh3869raIWmw0dSRQL1owy1mqerD+ps7zUjqk3nqM4NkDa25Tgnlg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
 b=qWc5m4skpv3AJt3PnQAaL1Uf8iVNsfrMmAOiSc+5rGtdRXMnY7/gnh03YfiBNB4Z+lalcDoRVf3kB540510Kr1RqG/LON3pFhSzCIMwmd9RP4WVhgMjcEqubkir/Zz2ISatSfU3FwqadxuDUSapS8CCQuc55WwKVs05zRSW2sXLJ3jiFZU88ZGk76udPpDcQimpBAtP5bAOgQwdBYNATf8RP8Ucul6/F0OoHB5vubcpCyC32vz0uYaBGqN1slCjI7ZYJm7Ofm15ptfm7dCixdFEBhF9QSDgosUzm0272gz07ulYzqT4s/r+XePCI3WMY3dBmVOqPCUHWEfSqYIUQpQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
 b=VLQOZdeJLwQq1QFG8JiuCjOutOaFGcAMuDtoO25z2wS6DfekQXntB05MjrH+E3XwcLXQP2JT0EHuotE3wb6TYRp1u2r8H56RtnaMBI1a+hRVG0cNE5zh41uT7Az2pmBhFXakHuMxriVoKlJg75Jf+WDw/XLRgDtYxd5PwTUI/iM=
Received: from MA2P292CA0006.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::7) by
 AS8PR08MB6230.eurprd08.prod.outlook.com (2603:10a6:20b:29d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:23:23 +0000
Received: from MAD0EPF000008B8.eurprd04.prod.outlook.com
 (2603:10a6:250:1:cafe::2a) by MA2P292CA0006.outlook.office365.com
 (2603:10a6:250:1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B8.mail.protection.outlook.com (10.167.241.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlbdoC3XaKNaGwOABQP4QP8Qnng/zQhNyXPuq41X6om7K1pmarnsI7L2f/EdYItyGXNRYzMX3TBxWgSpL0DMIwFWsMvvVXjZJ9NZp6GsmFZZuZNi2KrA7skkoy6y5Wa+VTkOYo6x2y5mnXoqA/1gR02V5wRRN/0bwp5Hr5LJ1qdaK9vOR0ovO5NNagp5oTlSQbyDyHNEGbMy4qjJ9OWxkgn1pjufITR5jJCEUQLOn7KMNrPrcm6yUamx2Moi+FVFWu6CxXzJ4x0M6fz2aXJCH5MvoLggLUOF+jGGqwxurnPGYCqRQvOa+CcgVn8Cre3+H0bvV4nDc+2OJfWOfc0OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
 b=juePceQYlCCkVx+xZcELvtvsPPUZsfzq0Gdt6C8CqYUKMkdchWnWHd9wV9/69vd0tuSDAL3+8od8LizB1B8RPKqJLSoLpJ+R/cdY22rmilpExRoFt3QuraO78lW0uweGiXpeQ5LC2TtAfr8MgHJH/lVOEEE7zt9n/5NYvU+KwDterEIbofCtPzPlQR+jsWJHY8/7au8MTZjkjHF7LEcMi/InuEMZ8onhZr0l9Wz1GDoH0t7Kz9S/iHAU+8m9JUN5dCmx8Elz9gaZLbhx1cJtwh6cyOjsbGzbtfv566AXzI6FHefmLhXYHF4A9exb6JjdcUJrtcSmZBfri3PjVQg9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1axE5xtP6HT/CW9p/XOvfgYffXST07a/+dF9yBxWutc=;
 b=VLQOZdeJLwQq1QFG8JiuCjOutOaFGcAMuDtoO25z2wS6DfekQXntB05MjrH+E3XwcLXQP2JT0EHuotE3wb6TYRp1u2r8H56RtnaMBI1a+hRVG0cNE5zh41uT7Az2pmBhFXakHuMxriVoKlJg75Jf+WDw/XLRgDtYxd5PwTUI/iM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB8675.eurprd08.prod.outlook.com
 (2603:10a6:10:3d1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:22:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 08:22:49 +0000
Message-ID: <8fc66dc1-e8dd-4a69-93b7-54c558816e43@arm.com>
Date: Thu, 3 Sep 2026 10:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: lwip: support syslog
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20260826-lwip-syslog-v1-v2-1-8c457f2b35ea@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260826-lwip-syslog-v1-v2-1-8c457f2b35ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB8675:EE_|MAD0EPF000008B8:EE_|AS8PR08MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ae5c16-0d85-4c2a-4aed-08df09949e60
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: +BVj643SXeUhsvTMrFF5lz4Dje6iXjcVhhy6QflP6SGcwpug/0JPOuPtoluEB3GbsQFJ6M+07D9MzJF1IZiuTK0iu8Gdw3FTSyZiltPHVT4E8B82sF0Ts6iIMVINvTcbFWtJr5tOeKY2EhETLAtLo80KSGysueTKnIwQ76gHHrUlic5arqQs5RXfUNEorkjc5wLahY9cIQsw/Sahl3GhYeulZt2UgqIccXIWdGnwssJ3W7Twl5uvzp7/lowymDwHP3i1OPNseriHvs9ORJSNhSxSSm75zvWZUsgOWg3AJ8N9i36E2DtIe4EcWVf+K1k46xfrvess7zESGg2k6k0nsTVyMyyIFPLMDXXmj24eNYV2Q1TcRsmkE+SkTaY3kD2VI8o0DC47iIg8oqhmaxC4oGW3CFl8xa6+1LdaOldMFPOmKpBoKj4XahwWs+ppIcxElJtk2bySm7sEmqGmoqDkkq3wHLaAxqKI1ewF0xi3+tVQ9+7FpdqoP8cTbCrV0ba6dzPoaxueGk8u98k6ZBsUxjB7vDnsckpc1mR/9nog4ZtS2m/LDPK7hzV/PlGRaf1YO6ty5pYzeRTjXsNh08OJRas0LPxQMMr1V1D+jS9IKXg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pquC5VhikhgO7MPS3ZPWzFXJFq65SbuetK9nD6vLKqsU6vLLdAHBT1O4+6YrRaya0gkKuAxu7q177LiGJd2YgNdAQXUECwVlNqCknNAlO+IfaP5KZsJmxpquNwTvHpOoAzw45X3HCMjNRtdPijWu7dXzrvf/nUJsFqy98YiZP1nfsoGk7T4Xzr4LGLb/q2CkiF0oWVNfdmjNYHpEzbW2FdG9Fo12OR/Khhvp19/Q925xwpF4nOd7mCkE/YcvB2AJw9o/oz7dpFF51lJmV1csRvWcPNqpvlnpP2S10lTvqm7EIG+fqRDeYVH/JjS7Z3qWlj4qUALFy2ipSLBsyJrl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8675
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B8.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b52091c5-01b2-4ab4-de75-08df09948a71
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|14060799003|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: lStNh1eH7FwF1GgJ7LTiGOUzEVaW1nxCOaNupQRSTaDQtInPaD16nzcE5Vhtw6SocMKflzV09qki2XFUm7tDU9yFjVJ1tKmbN+U7uSONtyEWF3JtnEucTL/nUbsUu952P9qBMORF8VwOBSiF6yTMg9FO58UcN4DOY/n3CtoZIcpx/bQc4Xsbs56Yni3LAPP4Fap6i9rYizFfF30WUUhc6awfklz46E8Ns9+De/y03q3fhztKr+AC2zk53qr57YSppe/13QFEVk+j3KWB9wXXlmfNgm5slCgShRnu2eI15d8ncsULVgJeZLsmYXAR2sx5wFksE5ivMzGi2HiVcJjhVtGEpfa/SYzyKYAifXjlgHpPag1FfRBblb+crJzQm44sCc/Llk2wRhgxNY4b3HDk2v2AnPUjXBlvV29yOJpgKiNipt+dGKCrMB66xIkaDuaFhmmE+jJyPwsCL6Dvq7/iVehJ02HNikZx9PJLh4TQq0S3Ue/q3V4KHqThbNdPYKwBYAtTfwyGVf1AcyvElt4J8XIB/HQKb/FmLFNvOB23nKvEv95yd0me2PE9USeC0pFXfrrzrhRIJhqPumMtjuzNW221dGTp34B77rLHoAuBXXc=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(14060799003)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k9oav0zv8djXKNOdXjsTCe6R65+Aydfg0AC60bstmRnCrgFrNpsXVIxKhRieG/yF7MlvMQOlqbDLQDFeJPEEjdmkCWOLfTcNI8cZReqXj4cTbKWulF/CeDYH1l94NyXfVpQOXCouGsYkdbEn9+c+Q+rs8xq84hbtOzaCHD9kVZoFVwCooo3DezUEeXcZrADcE6bsNpvk67JJKhHFxP3Lvkx51+ZZS4v6Xy1KyPOYNoK3omqrW2iExteAvEo5DMANtU4H3G41kgDtaQGt6nWOWj5ROPiABWljLuKnB89DyxYRqdfAZQglf6pFpYqdDpsF5lB3CRZga+zmcvsI7aAHs+Fp28DvDXC6o//mbrmNu1AmrF4AJq61k9X9od8Vk29oHCz49SsNf7eDRHhnba5i+lC2oP39E4lETUhUPwcDE5Co2hXMjA6KI15R0+vbquV5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:23:22.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ae5c16-0d85-4c2a-4aed-08df09949e60
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6230
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

On 26/08/2026 19:36, James Hilliard wrote:
> LOG_SYSLOG depends on NET, but the raw Ethernet and UDP header
> builders it uses are only available with the legacy network stack. This
> makes LOG_SYSLOG fail to build with NET_LWIP.
> 
> Provide lwIP implementations using the selected Ethernet device and its
> indexed IP address from the environment. Move the shared declarations to
> net-common.h and extend the syslog test to check the source MAC address
> and IPv4 header checksum.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Guard the lwIP raw-header helpers with LOG_SYSLOG  (suggested by Peter Robinson)
>   - Link to v1: https://patch.msgid.link/20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com
> ---
>  include/net-common.h   |  7 ++++++
>  include/net-legacy.h   |  4 ----
>  net/lwip/net-lwip.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/log/syslog_test.c |  2 ++
>  test/log/syslog_test.h |  4 ++--
>  5 files changed, 71 insertions(+), 6 deletions(-)
Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
