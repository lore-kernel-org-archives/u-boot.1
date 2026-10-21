Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67894606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SeB+BLMP;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36DE640814;
	Wed, 21 Oct 2026 09:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxqVv70s-uTJ; Wed, 21 Oct 2026 09:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26EB74080F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576299;
	b=hk+MYnHD/v0XMt16uwmkn/5faoG2i6V3QUzSNglekVKtcS0mQdZXj4DJ7JNqu9CiMMA/
	 +iq9xJArWKdx/y6c2r3WTTyLqhvVKHPitBi0JvZqWqTmvavGCZcIEZUDsJiJVgtE0KHN8
	 1SFJ+kDve9sfVAHwqVI988ceBeKpendDxk7w0qEkzyYze1wsdosE6l63TRxQxG9qgC76D
	 jatynBmwIXx3VSdgX5SWZYktRcO4H3azuEB/rmxaTU3viZFyOJXBaF/zcMVUI/G+PuchV
	 lZyD97yTWCAoK+QuMhFcsYGJgzfOny3cmT+gu5yEh/6Jvkpdd+SUSSNXu1iHjbEeoCg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576299;
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
	bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
	b=b64eKd8IsVFZagJk/BAeZl8+W83mJ+4rVhJ5X4Oz18ZuTrXnJKwxPWN/ebNj2GugBQLV
	 38JYKk8S9eRFouKixmSuLIsQPw5JcpiIGeecsfuikN+rDPVXJrWnGbzdTGimZulnDmQcs
	 F7Q0NGvWil5gNiYKkdKdDJUjhByctpuOmD5UtgrdWwmrxTL9n7diKHVJn/AOn15X7CXB/
	 LxG18ICHS1VgpMwQ4Uj1YPXR7zvWa2v8m3aKtHhff7wGcZj9VwH5y9n/d3c4D7llHCdJ9
	 Yn/r5NiZdfTctertWanp3qsw+1xXuc5fA3RFHlA8B92xZFbFWeu8gFgTAN/fWbNfPXg==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576299;
	bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SeB+BLMPOjVbrlu2a/vbwCuU2e1oe8s3veN7fwKl6STSpN5U2mcgu3VQxI9rd5Z/4
	 KfIkYy+/C84tniwMzVvXPPrV0UgGmUlca3X54W0pDOSn+qTW9H1WiVB23bJjtT8ZoG
	 LVGLl8WFSpvvc/xhy5Agog+SpnpDWZdEXu7xouTl5DxIsItCvIQPdi4NeYxL463tDv
	 7UzSHwFs/EjLyzIHPcwKdlK4eHQsAeFYQ2YNrMyMt+SNNzg2atV8ZcTONKLjOJgJkU
	 Y519hdpjVgmIskKuRWsfjTJgJpNxCcDJOJ75EZZNkdh+ZJtpwPNyTqSfWnG6qFuXA+
	 wc+f8CkSme0hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26EB74080F;
	Wed, 21 Oct 2026 09:51:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BBDF23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41D1B4080F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mclHvYs5cv9N for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6E3D4080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576296;
 b=knLZcrzmTsShgh4cvkh7ZocZsJh1Z913mlSa3fpVxvdgXg+RJY3pJ8Mq5uTVV+hXNawx
 Y0CCGF+UWc+/OO2PpjqZto9XxGBRBWyiU73ox9hVPAZA2X+9C1FMSyshOiQgJt5AjTMi8
 hBkIaOT1fa7lvjP7XWnRSzlylHrtlMxtajYCLC/B4Lfj26XjuHa2nce95MTIYygkT6taW
 pFWFRPrH5cfv+HB8df6JKKkFaN6HloP775Rj4TctnuKXD+AK1vZeBF9gzsqpQJUFAN+1Y
 rAJCZInmrVpLY6cF0mUau+vJYcRiFYRElX+kP2PQywKbNV92Ig3TtD4v9ntmzRP2WEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576296;
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
 bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
 b=XrZNA7qqcr/JCZyUbUiMZ9JchWZv35Mji3OlXEF0klDVzyFdSsk2L473l+rifkJPWbjM
 bgsDvyvIwuk7fnPgJgSkX4WblaEIpapFtH1jOI+Qwum6dGfqsf4rOONpdWqaP+bddcVUG
 CEVYqFeTy42AiEZ2OZHhAvd0k+a0HTBEc0F60cftMU+YSXpE8sJN/7R2w8/N3AUHdgYqA
 Rgxi0D/iLKVFn8gTdw/kM5gWnKlhvCgU9p9oNPhQUnPMtY8x+RERoT0hATrdoitwAbpvk
 wZ2Q+rSt/+ODnOeVWjIXMH2WomhdTigi/CZGblly9DmIpicgMEr7ktdhlDdDg20iA0A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=NHF8F3aS; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=NHF8F3aS; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=NHF8F3aS
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6E3D4080C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kjmR019vKzfZwxebl60TfzkSDw3BzaKAIec0jAqmWvrnnxuQTauKzGli6OUXlq3Cq/l+Dq+FxvYKEkBfGVlzOZ6gI/b7cFdXFFrmLN2dRBuFl2oINEtBDoaV7Zt2QveFUz6rdPYWCThAS56xw/TDRS1wFtuKJBeiR0M3Xuj2x1iArgJozuLGQw7qG+Y5Ce/2HCq2hZGJW3QuOy7cPlqjOCQWWAq5KrbGFVIQxrUkUs0lDDT3sWUI7su7WSNI2IoTXy8CchMifJJxudwJuGnp9hB+uCbvXB32PeJbPIAlQBzDfb7W2wRW8IivyzsQrWHL+fEubSd+jftonc9kBe+GwA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
 b=dqlxOwO7kh6iMnu/n3LtLJ8PRh80vbfLSwsfRBcUXUmfvXXrMVdfImFSXBF3uiHWA3BcfkHJ/fIcpo5JuqHtmQWvHFZvK9O0sBU1P7SQ4lmpDZzyBIikTj5NNwPo6GDyCUEz+rlwIn15WvFr/p1FRoSmQTD1wBkc2ZZiZ/yo+eQKnvxpNszgkMnONc0IJRuQSlZgUSeYrku1N7PHHPShb+sGgBB3eojhzPQNC24tgOH5nt4czLtpBVeLfDdOgCsd4yUQQ+T0NL56mtcCG/Gmti5gBtnE6h0a870mx5/MijqrMSZWdPPz5vugT0gfBtS2YGHFRDaDgHG7VvdEls0pCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
 b=NHF8F3aSIKF93UXgvlpu31ByVe+X08ksnZQQOilVqhc+1m0e6OaU6nK8sEzSj1AQD2xYLQHhCSzB1lpta6yF5FzCV92HpVxPE5/65wspbKK/iZR/Brff1jC+vQUbgMw8+X3hZ/2KIsxzzT7oane7gwknUymHr4Ia8YnObwVEdWo=
Received: from PAZP264CA0053.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::18)
 by AM0PR08MB11728.eurprd08.prod.outlook.com (2603:10a6:20b:746::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Wed, 21 Oct
 2026 09:51:28 +0000
Received: from MAD0EPF000008BA.eurprd04.prod.outlook.com
 (2603:10a6:102:1fc:cafe::57) by PAZP264CA0053.outlook.office365.com
 (2603:10a6:102:1fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 09:51:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BA.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDSkaFizyrvaVl9ZLfRNgKUoEI4aF8VgAaH/gubk8wj1FYDzo3pIvFfTsRy1rI0pyVbPcSKORiCwyoHvvYedZwvJ8P5mBoLDTc3Sj436hvJI9HA6nCavexmjkvab8vwzWkO6uAA+5Jw90lme+HHyzF8glEei+UILoLOzwq07saxY4siBjEw5TcZcKHJIXRr/W7XAWhkA7XVtjZCl3TKFA4pQqSu1vaxi0B4siDyENIfkdOA8iu6hXAj/nfZqvuxBEWhFKxf7FAwsc+n8ZdM7lajx1gf4Zs2x9dF/8hCA0CqmM3fCKiJIclfQ7tuVnBQFIwI1JuN4RWyxQRdvroXwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
 b=h3A/NAtKKha65zaVTCbDUZ3GmKBZvCchWTF9qkWbEB1e8caZnaXAcArOu+FEurDDUG5pkvY2US3+cAdxtx3pv9r148GOPGn8HM6wfsArOT7rrwuKJDJRLoZZfUwhAyyJutFl0Ov8Gk5LiNHdS4eQi/WEdkuz51/UedrooAi158eTCyU8gp0jJYGFYSV7xNutKeligkPXm7tul3nYUp3noHPqe3QGyoC69PMedWMDMsbJaqNsv0ksRuDr1L+Fw4r8r8C4KZ+niefKD9S7Mk2ryej4sURKbf7JRqHNXQbemybLnMaeaxqbG65w6b4MO2di/Idl3DeEFQy+G6tFruLUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYv8p6fesvBVISBEa3SM9cihHcsth/yLEM1Y3ayCsFc=;
 b=NHF8F3aSIKF93UXgvlpu31ByVe+X08ksnZQQOilVqhc+1m0e6OaU6nK8sEzSj1AQD2xYLQHhCSzB1lpta6yF5FzCV92HpVxPE5/65wspbKK/iZR/Brff1jC+vQUbgMw8+X3hZ/2KIsxzzT7oane7gwknUymHr4Ia8YnObwVEdWo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXSPRMB0029.eurprd08.prod.outlook.com
 (2603:10a6:102:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:50:52 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:50:52 +0000
Message-ID: <cde13a24-7ee8-42a3-9f7e-46b08ae3fab0@arm.com>
Date: Wed, 21 Oct 2026 11:50:51 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>, Daniel Munic
 <v-dmunic@microsoft.com>, nd@arm.com
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXSPRMB0029:EE_|MAD0EPF000008BA:EE_|AM0PR08MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: d25201cc-6ae9-4256-9b90-08df2f58e0e6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: dZkmbJ0AJ7ZtfSaCWZqKROSXVM+tBb5EeK/qjOpXDKI5501OuiZYZsPlqGR4b1G7cqeTEX/KB+HeApq3w4om4Q8L8UatPmKgP5JYCosBCeV43kbdI9vseqFNAM+Cx85qBcaNaKUYdFWDnX2yIzfow+VLrwi+ZvBZ/O94VcKONvcjuT4I0UTHXt9cADsTXhBYZGa/4eRYwidpokxmGOhLtxLte/BlR4dV8F1m4uUYSyruya/jTcwduCGG/5v/cgarDXdHkf+eGb1hXto7iKTNTKnZzXBis1weCCLXeih/ismHN5eyUL/jqulHFt4fqRRQJmt/Ekiee/HcYnwjXlTn9fXhx6jp3evPQlTMuGNBXnuDue3PerDhXwfqPi2N6JxbtjX/oILfp8ORg/kow9gdHuZPulL+fDgjs4TofOhhB70+fkLuMc4gdWZaZhw5hSAw86D/Pota3uTzJY8oRIS5UAyVNfruhKc8979RUxY4CLQE3OE9aXgeUEXgKXkEvlIwO2IOwDTU1hS+Wz+n5heRMH+7hVaCBGScohay3S1AASKGNwcebxU71qzA36831ElIXO01Ke7NXiKBYvnyi5b0dYQogW28JszGaH8olGX7ML0SJCeMFkZSVfqJW3oilXhj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 1ECHsRji+iMo+FfYCsx5azYMOCfZTXWjeSkA9DJc0BSqOsWGucuDq9HLE9X8Ff2bSlpp8ZSbXporS0ZMId0C55XUbRJ7MRXmiogpfu+dg40z/R/+J+z9JXxjuL41xTys5ODNdEB9ILqJoclHIBC1Q8PbQNtWk4+ehXOX5bhRCv/zdknJILDSJ+JYPuTqstRNT79MsV/qaildpXzcoAkfv66cvtgPNj1O73bCjUkiNMaiRAjRonc8GN+0lGbJGh+yXpQB6KeANC0iZrhB84dkts3NIXhLAVgl0wPrmAqs3Z3pxdfDilpwTIiydPrwxLFSTW4Ivh2A0Gr1juVN7izz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0029
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7ed9a6d8-bab4-498d-c37d-08df2f58cb06
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|23010399003|36860700016|82310400026|376014|14060799003|18002099003|22082099003|11063799006|4143699003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: tjseixuoTSBnANnOz1yZJEaSU7yaBdY0WLyX8APY/kTJbJ8BLW0mt744RFZqtqOaEaWHxg4pAPSNWVyyA/8mis9KE5HZ1NvrC88CemMegJ8+sHPppJEQolnZnC7+b+Rz9AvB1j7MiHW5skQbGHfSPy6CHL0SY4TFWm30chhEzag5kWnlY+fnrbbG/tGISnQJlsresN83n+YwbwP8ggssiT97WpV7reqvelJ2VIeBo6WeXkFhaZyjqJj83dYQRabOrQcjFWyb/dMmxmqDBz5gmSdLa1CjAIaC2ymC7OSSToKnvCuN6O1RjegCyCCwflsDe/leIAytPgx5G8R7vape7ymXxvnwWEhU7n1vpGaCtSKZiqU5GoXs9cU4fQOnV6sxf7OIkacW/KCO37uDYdWZwmJ+EeYjb3R4pY5ytGmCaFVNsLpuZTtvhdcH7CrzyyhOvfnpV1E2pteOUR8UQ6kVbVbyEmn4AHFgwKZHJDFTjg1okMLCKNyG/1twvv9RdcxumF9pRWWdFYR1txh1XTQPT94TGv/8bHbkPwLuO4AuSBMDBtRTq23qHMvhb5WZRnP3BWH6Ix7ELmDNHpjkkIZJpMpsKtAM41XaU0TZVZRBOd3yedxZbtLnj0T02XNcNpSeHxhYKmi/nDmmPzg8eTs360cj3VKiWuMy17yR4igvDHM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(14060799003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vMzP3EF6tL4xdlV3CrYZwYGyR7Pr8QnRtgQhGtBE5vSLhXBZdZfVXcxw5Y70T0MHkufR/MZ9Ekhx6M8OpT+aRAcs1PbIpemUwAhpcG4KfzFLtMLZ2kqTKsf8wNgpUf7K4XnZeh2ap5dr7wna9z51qSVNQCPrzw5VmrmjHgKYZ8esBftU01I+5E65Q7BVQd2gSBkKWqCffS/20VR02CYD1ZPtfxWyTbeLO2E3r44ZET8svkRVcnGBV4jqqZxKPCKgwSNICz+NJJi/sNOpq00dvLiqqNTpPrq/HClao1cod3VWL5p9Ufc5qAUnGaiqHAcjoxJ1r4uDLXmng9JtnIp1y0HglDBm4NH5CwFbnpQDrpxYikgJggHfENHqeFqRbH+RXHEDJnw4BlI6RhI0WCKtv8xUO3XoSak+fhsfz/uIpOI1e/iXCQmjLOzlvKWBvQmP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:51:28.4605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25201cc-6ae9-4256-9b90-08df2f58e0e6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11728
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Three independent hardening fixes found by internal static analysis and
> code review. They do not depend on each other.
>
> Changes in v2:
>  - Dropped "boot: image-fit: add overflow guard for FIT decompression
>    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
>    as the allocation size and as the unc_len bound handed to
>    image_decomp(), so a wrapped multiply cannot leave the bound larger
>    than the buffer, and image_decomp() already fails cleanly on a bound
>    that is too small. The claim in that commit message was wrong, so the
>    patch is withdrawn rather than reworded.
>  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
>    single check that the packet ends in a NUL, per Tom's review. It is
>    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
>    and it also covers the dectoul() calls, which v1 left unbounded.
>    Retitled to match.
>  - Rebased onto current master (a44f46af0aa).
>  - No change to the NFS and ext4 patches.
>
> Daniel Munic (1):
>   fs: ext4: widen ext4fs_update() block-group loop counter
>
> Drew Kluemke (2):
>   net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
>   net: tftp: verify the OACK packet is NUL terminated
>
>  fs/ext4/ext4_write.c |  2 +-
>  net/nfs-common.c     | 10 ++++++++++
>  net/tftp.c           |  7 +++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/3] net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
      commit: a9631ec898a6f71334c88d29c8e6c9cdb1334a41

[2/3] net: tftp: verify the OACK packet is NUL terminated
      commit: 2044f0c8ac168e3a2d23a47e21c61f248f93f285

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
