Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7C606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zydrPKFd;
	dkim=pass (1024-bit key, unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=oZpAzwkW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03AA540513;
	Sun, 25 Oct 2026 18:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RNkG7kndhWzn; Sun, 25 Oct 2026 18:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CF4540518
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792953216;
	b=WV3f8hWRSZeA7HUp2eBqevV/8ugYN9WO70nCxNdJJoWhVZU1aabwkiTZveYohSaZFKa+
	 RY7t8sK7JaFbJBUOfQzNa7pAnnTYs+4+T6tKcktGhtQScJCd6cyRsSQRtnVcKdNmrznaX
	 8m5Vhs76m5j7RCuc9JrFtBtupXVYZu/0lTswlA7w5/LmmGXN6YOyNlSbmB/4+3ty99TAd
	 4tHE1JmYwrH2WMF9XZq7jiMFw7RJG4RHPyoWpsT6gBjuMUvhvfBs3YdkqfowkY5xZhcu8
	 qrYxIJDZVuFS/tARB8gl5Cm6Sxxc2tdYHIyW9Y0nZ0zPf3V+v2P/hWOTHF9Y7NnmF3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792953216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hkAuyN6R0zkJybY7BTwFez0ZlVV6TjP5rwjNXVUccxs=;
	b=FYBEB+iWiVixXEEn3peXU7U81lNd359743qyNfWCwM1ZUWEo9yQidvt5MKTm20P0+jfs
	 TYAOgOoE4yaTtaq+fPA0sk/pmS0XGxpbWJh/igtM4pQ0x8GA1riQETSHy3HMLrWlZOYKp
	 lUHrzhEumeFxR3Jp6zbm6KT0MYi+/B8vJiOjiho1Os51McNsV21Jf67g9qjwxcHygFYl3
	 0/+M42oUyn7V+F4EOXuTp6OF2D0Fv0/4D23cwdunt0BpLVIL+3DrDS/MF4MA3t2EiLYVt
	 woKmIZBc+pcry/YrzvVATDW2pHat7uLW9/OC/Rl/xC/CCogKOMQpcf/qG9NbzkKcS/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792953216;
	bh=hkAuyN6R0zkJybY7BTwFez0ZlVV6TjP5rwjNXVUccxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zydrPKFdzgPw57YU+39pCujTQXcYb6bEXmsES7g1DZ6mxsvqNUQ9m5fz1A5XJ0JkG
	 8UPVdY57KvhOCNT4qMO7aPYXmFuwRCUR+Y/5WGBjFJxOe9yWBgYRudkye45NVt0MWL
	 hntbfcVNmvZNsS629kSRNI+Dg8mkp4ZYMa90Y15HpjlOibWhxVdTwlHO38VUTQCUEZ
	 Q5lrQpt0cutyDhzNVp/h6qUSy2RtdYC6S2ntmIKf0sYi1Yc86hGYCKoADbovDT0RdV
	 mTvIclzzoNxHP71ITpvdjpmFUBcOmNIp8lpwzD7WlpA7UKFQu+YqImSdTjlBejK71j
	 t/4yzJ8fFI3eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CF4540518;
	Sun, 25 Oct 2026 18:33:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0FE4D1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 18:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EEF980C9A
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 18:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUStqhlokYqd for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 18:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 558DB808AC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792953213;
 b=H9U1mtECikfvGjcGbqQHZe/vQImTLDZKMYVGAEcwn/L4QlGxvSu3cmcFQy09aM7qM1fX
 E1cAJA//HAt1y7b1DOx/xMYq1LnY2UFW2rQYtDeSPmG/als2072gVH91CCANLhomakepO
 rhYfwu85NJLkCFfJvnQ0oyyacFp5eyqmrG4+tn7v8GEHytaMLiAZIgi6v6F5jTpP5ZBfP
 iaUybds+ADaoDE/PiqAD6v1pJd0o//iPFg+57Y9xHtSm4Gr5rSTSXCEV9tdXUNHQU0gZN
 IvgN7zIDq+q2Mzr/rLV7LP3nh8sTG59SAfPfAjl/pHmyH4wGiOlsxch33NDY3EpRNXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792953213;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=hkAuyN6R0zkJybY7BTwFez0ZlVV6TjP5rwjNXVUccxs=;
 b=UwnDViEfXTYlH3YEoKgrWpjL7dxaOC+gKoHlYoUASUvK7On9HQC9hFJqJKeLxvRUBkkx
 M7DZ1tpQUt628/MfuLiSgOFxCEb1KmVVjZ/CGr+72QWowgXlKJI12VdpHhhZjgYJUkqIu
 yNAVISruPcTDh8f3Ok7buecfyUHNOFvLq1Kg21sim2RstVYp3VJ/o9jGgihI+FnqQONss
 /H3ghkG/Sn5lvOkTX0APhmVtp5obyEr6I8vblzaD60uQU6XLHtKs8Tt+7Z1Q4Cyk8Aimm
 ZQgQZAg0rTn/R08LNgFV3UaufmnTbXPG7EN4llf3iFHIKcGSVFibZ3oKx1Fhub10Xzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=toradex.com;
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=oZpAzwkW; 
 arc=none smtp.remote-ip=194.104.111.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=oZpAzwkW
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp1.osuosl.org (Postfix) with ESMTP id 558DB808AC
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1792953207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkAuyN6R0zkJybY7BTwFez0ZlVV6TjP5rwjNXVUccxs=;
 b=oZpAzwkWHMuSpaHiEJh/pdOv5UZCniCo6isqPjxC+3ye2Au7eKdTIQ+66O588CtqCcqTyb
 fzPqDAxRljZxdsY49Umf3Buc0QEAH1UQWlxjz+ugAD503qpIs1fVkP5BjPslBWVipQ3o/C
 dT2KE4mt2j648RcGBTJRlbgF9nmOTRk=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11020101.outbound.protection.outlook.com
 [52.101.186.101]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-48-ZKXjDM5HMeu1l79eV--3ag-1; Sun, 25 Oct 2026 19:33:25 +0100
X-MC-Unique: ZKXjDM5HMeu1l79eV--3ag-1
X-Mimecast-MFC-AGG-ID: ZKXjDM5HMeu1l79eV--3ag_1792953205
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0906.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Sun, 25 Oct 2026 18:33:23 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:33:22 +0000
Date: Sun, 25 Oct 2026 19:33:18 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] colibri_vf: separate the partition numbers in
 dfu_alt_info with a space
Message-ID: <at5LbuF_qeaSAAtQ@francesco-nb>
References: <20261024113459.3259910-1-mehmet.fide@gmail.com>
In-Reply-To: <20261024113459.3259910-1-mehmet.fide@gmail.com>
X-ClientProxiedBy: ZR1PEPF000077CF.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::406) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GVAP278MB0906:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cfec0b-29d1-42f1-4a3c-08df32c6731d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|261022105027099003|10067099003|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: gfZV4MUb2oYzzW5FIXoUYVyJQBU1vsFcHu7qEQiBw7W2Tmgd1LcSLPl+u3Z8KVsVKars7+d/Qb5NjoL5wVsSgdcebJQCwDKq8LlJ9iWDauYud2chYaoe0vT/TK6i8assGFaFOasBfqJA3TYbFJypJxp3q9I0TlKPhtU6vqS9iiCiIQsasYR1YCdFbmcztEEM264b8SecwRohPWgZMYBzGe68bQyagtkMWfBNF33JTvPpWvZEDZ3lXlNyjb3A+x9te8JFdGhZ6dgCGelzp/hGKWK+iAx7POnvmXmFFNM60nSfX+JxSdr/Na/AAdeQl+/wafphTdnUD94WWAlJQaLxht8voVIkVCctHbdNLFfdZ7evnkF+cUZbZFDZOVkmbqSEYUGJkmK8NnQep9F2FXpLEGDIsk66orUxlFA53I4D4aUUalHqJgmJD0CICBpLRnVzXKqATgQztNVlbXd9P5sa+LoHPDFtF0JC5VCMONdQjj0sPnnckzCK+n+F1oqqKUPU8JJ8b6S8DyVmkj+XmelXh2svEfkdX/BDnXauhXvsAQbHKXmTL27XRxrdxg0Vn5lv8kE5c03sExXLwmuRBqmc1bYhpMRxIlFv/X0Ua+1a2QtnNSe/akjorbvemsAO2+zCVszVBYHm8ievLouvhPHUVUxxuemp0Vy+GQVNdU8t6/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIx1wHkah90pK3a7z1cHQ0Ps1wgVVa4axmUFveOXhf+k/30IdN2U7XoJXrhw?=
 =?us-ascii?Q?kiBnvUoX7vkLMqFopTAoI8a0ml71ccPg43eENLMCQxGinjyaPEsmv6b+tDOW?=
 =?us-ascii?Q?yhYOfvLg+2PqB3CBemIn60L17ktIvvEkOBD40VahiYQ94pmp/hUdz9bxa8Rh?=
 =?us-ascii?Q?Yd3lxEB3rQPemlwYa60lR4ec013SUm9HlR0mKzB4XNGV9NjC52CLsQoxuVL8?=
 =?us-ascii?Q?jAIr7X2p0gu8aBxqUomfDjdk6G4y8bXQHlZn2V0TQv32zNZPhTQF1lfeg2Td?=
 =?us-ascii?Q?9YST5v4lDR6Jf++u2bgJiGH8J4s2z705UH3evMOaHMCYzibQ+BSUfRZzDu21?=
 =?us-ascii?Q?2LRLHVJ5XdzlmSxlIP8OHHXJHOR0Qg09NTb2BHKL5eJHLo43qY8zcFyjdNiy?=
 =?us-ascii?Q?79rnJT01UprfQUPr/WeOehHtTyX6PRh5tv9i6J6UrbYncxh1dAQB4cKjWKIJ?=
 =?us-ascii?Q?ILSWMZmULNIAzfa9qm1FBnF2EiZ+FdjPsrnlJ7M2G4KPVKad6nwmqtdBpmsG?=
 =?us-ascii?Q?JtHf1GF9VcZcs72DKesfOdV0mErqI6HB81ITvqkopWAQsQHlAgnas3WQ+UsZ?=
 =?us-ascii?Q?CcQl9EFz3jzyAQD4TrDFNUdyeooxdy5MNoND3PRm8lh2ftNwk56984cIAstS?=
 =?us-ascii?Q?dryc8av8BzuYkzaGrpPEJO5KczTlw6NNF4ieVflPfO0dNlvw6ayW+Oa8XCkL?=
 =?us-ascii?Q?Th3H7qGg2ohuVqmr4KCG0XBoZz/xSmFj/CKVA1MM23x4oX/gmJT7uLvwbmcO?=
 =?us-ascii?Q?JRNjaAkaIuZZ1s0LYuI+IwkltLoXkzMBcfaUDcM6xPVblzWhjYebpHaKYCvK?=
 =?us-ascii?Q?ILmAyx/VXoDwW/5gnY/It6qEvEB6rIB5U6T6Z9XJyIl2KAC1MzkXGhNP1Sqp?=
 =?us-ascii?Q?RyGAFGwlh6NQUTdAbfhBovhivCYVru8k/XP2ekYtWyiDPeY/L0BU/Gi3uYSt?=
 =?us-ascii?Q?hJyHp0JEXcndFruQyRKlvUkd+781YY+ShwCDK9xsYgfwSZGxLS2uu7cqHOkg?=
 =?us-ascii?Q?n97EzVjkKSAXmifuIHx8UAondCroka9euVyDqWsB9TZSgkYp8w3NQBSyurbO?=
 =?us-ascii?Q?QDq6s1e4WBpYgeK1a2CD7AGzQcUTolqDGGDgtHgh0fVjdQiJhsFEPUA8fclO?=
 =?us-ascii?Q?tgVYXdYWT3jhmh+OOAmb+xfnrCGsXwLksz8ARVpv8wwAJsg3+BPZG22ioY3R?=
 =?us-ascii?Q?H7kGxnEWLQCay/2w2F43OT/Dshz6s3SL1cbI8wnmfLbvdZTY1OeDDPgLM/zJ?=
 =?us-ascii?Q?5EdBMgigb7itIkdTT38GCMQRZt6Okkw0JrJZVanlgDCCEAXIcT6dCTYrgp2J?=
 =?us-ascii?Q?tlKF4Noq//5CharhAa2jpqalfAQDzbuxvXU3DTQnz+K9GdgiJyoCpZOsvHdi?=
 =?us-ascii?Q?dXVauQpq4zyBrhLJs2t3c8ufSEFS3TH2K5eUNNRxpwLDCr/Lc86knesWV+fJ?=
 =?us-ascii?Q?tC+zqMZtkMcIqC7Odko9irWvvKqwcKl0P7wS9pPQZbTkwXso12Abit87u4lN?=
 =?us-ascii?Q?yPHgB7Q7tAanYqTpD3fo8ew9YsMtSL0vs1NS1x2bQPFecFjxa4gE/QSqV4fS?=
 =?us-ascii?Q?w7tgSrih9HBmIn6gAy+NBHxE6+eM2zLqCm7V7xrnH+HwK6UJrHE6gzuEg6bv?=
 =?us-ascii?Q?D5Hycw19urg/RefYhEz6N+AbeZtDQm4LC60nVhdC0fgxrlyuAzOdxsWei9I4?=
 =?us-ascii?Q?/AoqpKEToq4zbPhpZxyhMgQrnnR1xxb17nl0K27R91alxXSSc4wqiRrz+1/K?=
 =?us-ascii?Q?MzA8KFi14Kctr4dAkLNILE59N8eIJDM=3D?=
X-Exchange-RoutingPolicyChecked: 5dtv+c5z6rsV8/L1polblr9M/w0JW2rpljuMS3XcbjWp6lJ7DW6mk4DkOIo4Koritvl8NxU8kJ7xCnkr/sMdzbjg8lsCVIoGeyGqforylQDyi1gVYIIrH8kzjcXKSUdJHllK9g9xYkSpRI+yTNxAZ2/X6U4Dp7axW+dMg37ISOHTpXeu5rJP47ZibyPrXP5w/JBYlLQ3rDGGg69/l21MXu+AUv2IKMRR87o65oeFAcTPXhhE82rUjCsBUVisoNgHzvXwPTIV8oDGWYje0llyYvSA8KVtaxTRu6q2SrjC8DAL1U/nH6FGCKicy61GB1qMOCKseZ9SxHMudDMuzuvX1A==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cfec0b-29d1-42f1-4a3c-08df32c6731d
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:33:22.7736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfFljCg74AztdVHH33vPUT2SwEHzDuE+7X32AJkd8SNAeD4lqNZpJ9Fkp1pu17bWONlWcFEhx04POaWPCGTQQjOtk4l/YH1FFNzeoDKAdfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0906
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s2wNhkaw5QwiuHnkNrjf5zgwPiouFzPCaqWXkuHVP-8_1792953205
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 01:34:59PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> Since commit 53b406369e9d ("DFU: Check the number of arguments and
> argument string strictly") the NAND backend takes an entry as
> "<name> part <dev> <part>", three arguments. The default dfu_alt_info
> of colibri_vf still uses the older "part 0,1" form, two arguments, so
> its first entry already fails with -EINVAL and "dfu 0 nand 0" returns
> at once, before the gadget starts.
>=20
> Separate the device and the partition number with a space. The
> partitions stay the same: vf-bcb, u-boot and ubi.
>=20
> Fixes: 53b406369e9d ("DFU: Check the number of arguments and argument str=
ing strictly")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

