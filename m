Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C8BCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B03F608C3;
	Fri,  9 Oct 2026 17:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRVKYSwISz9Z; Fri,  9 Oct 2026 17:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEC05608B4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565740;
	b=TyyyuQumEkKjmuHqBcJS5LNZHz7MujyfVg4kJlM3PYr5tM01pXD9jhZR2F2Ba3jQ6SiY
	 Zhp4mhcAC/iS1NUlhWCORntfKOhAg8AsVMxgNlda/R9A6VKxfiCsAQwmLP/8vjXYhsCfw
	 pOZJhhd9XcTeuC+FJrHaWUsPq7lliMq7CIuDBzRJzJ9tQlGApCzyu/+MYJ8ba4btQA9tC
	 KAjhhZKJC2yrR4ux6m/Z3sHTaksDW5KvnfELKlU9y/+cq+1NIe+XS05m3orGeaZGGTN3O
	 eHgHBBNUwp9Xh1rnwcj3YXSHVbcx+AB9W0nvZ2wW9HPEUaO7HLyThuCsQr+FhEVUhTw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565740;
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
	bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
	b=OEmIXr/oWalE4r9CmgVBhMq4cKxBkFsuoGEwRGb2I4bT+xhP3vJG/z3IOPFM6aw7rHS1
	 8naoAin1cc83/Mq+arSAsqz2sbSeP+DEgu987xqvKr/GjxJ8qT9dVIe9r221N+DiKmQ+1
	 Q0YK6grK1o9M/mATcLKtnFZxx59PNU8MjRXXMKSTlxVD+l3MjYttT6fDncSgElBBrSi87
	 5dWF4TanPOuCOmFDzD04qHI4FTdfPP5RHBA6Mpg4XuddHw3LQabjMudt1p65zTd4knFSx
	 G8hmzz2qWJ6Yik59xj1FsAWwZFwCdEM6JutqDUnKDy6e8bZQh6lTTcevIW1bSDj9jJw==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="T/Ua7kOR";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="T/Ua7kOR";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565739;
	bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PRWyWaV1G/LbPtISiT/yLC8P+anGFfxK6PgvA0Xf5zSYfGemlewkHRFab40WlWzzH
	 IUPMnja4Q0CPXKWIa9BSSPF0dOr4MppQpVDDu7YKdxYQXeGY0DKm2TVo4n9LH0+Sgl
	 ENzuFv1swPDzIZyand8LNMQS0QxYNubNqrnm8iKB+BQNrhh+C/lj2dgjSvqIyP2HM4
	 Nh2E42CA2bQjB+1laSj0pQvSZE5l5WB/E3+2dwo98Cr8oWRg6hrDULuAqJxYxx1D0g
	 usplMIXb0F0EYK1jiQQz/S5T87wX3uTllxLoop1hwW/Iuq8xab06Niks1RsRAWrMV5
	 ZWD0fmegZeTjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC05608B4;
	Fri,  9 Oct 2026 17:08:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 068A5317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC114608B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWABnkrbXW13 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:08:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34B4A60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565738;
 b=IqWpK8QHiUIz3MTUktwQju1fkaw2UJbSjPdh91kjk0DWU+5V42Z9fwN0qA2TwkBxe4SM
 AtXInb9VCrfyzHr9gfar8O6wUtpQohl9jhrDG+X7LcW6lsPJbnUHpnaqF1K5SvDCj6+QG
 oGf+pqnBJcDeUlTbvr3zPbuKemGxsXro1W/ez3QhDbL9SGxI6pqeWlhX1c5TcGyjvwCh7
 r0c5QP5V+LOWfw92xQjrgMR5Rfddp4Pcvmw47PgxT1ZmaEa3MF0yzshjYqEbxOldgJZsK
 pfuGT4yjh+Bww7bIHrGz+A1Mpqg6HrGsj7ETVk5jQBLOY3QX0FV2DMGbDFiIpzkE+DA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565738;
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
 bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
 b=UDcsE1e7mdd1BsKJtESIPQXtb1HeLAOzbaea/KVBmpPJWVvBFQz8cEqLuD8WNywje6JB
 ok0CWc3AopsXqvd2MsTU+FsB8TdA6zAgTeF3dZUj2nQo1f00T53jTFHNcPoz5faxbEruF
 a63uFmBcHSAyIZtJb+ZvMDiHPGQWmDBqLoRF7vLMQlF+OkuCcHyXGCrRT4CqCA5+/1C4Y
 uDdc/RXLF2/g/OXFNawCUZBOJiX6JiOr2xPxNgRBkJcjxGe/SKRWrzGPrp28stDKVIIkf
 8fdMzHQPhL+x7qi6plPOyEDnpUxZGcLCu0nC2dNZpDKiHnZzmKps1VS3p/xvLotm0jg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="T/Ua7kOR"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="T/Ua7kOR"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T/Ua7kOR; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T/Ua7kOR
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34B4A60680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VD0YBvHCe8jkLEFgsxVUNWKr1uQ2eQ2+hovEDSKiQGijQ6tkqkacJZhP2pkEYFKqkty5ap2NR+wSN0EboiXnaMaUqeZMxSwYXdr0Gl5vq4rXf8GuoCZVAmoPudBcLU9SS0vjTD1oYEnLtcVS+j3SPkC5KwaNdJN39eNsPqF59CBOYETrh+h3+WYSySLtdz41D2ckrV1qVsl+om7fKPSXglvMCoG3H3Sq9LWhMBlKAlW4CaxbluYYXUAaN/et1owHpZ2EhWcE0ZyMWSuVSAXTWvAu+LpY40lxTyacHbFnwjW6u+GOtFYtGUjMBP+zfQlWzxBNyJqxU9mZdI4hErZpBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
 b=WePkivvjlPXmr3exOrA0SkNlmVvkBqzlbiIpR4aHzIUHgs2Eo1+UUMQc4V1b6Qex6wFjqiP4O59Zs2dUcitjLpXY8IGd4pKc7sIo9LNL6RUZAtgR8+IHh3Rs8+F6vCH3gF0JsLdEDNBb1pzpWvOslA4epdsATg1DUkG1TGeAcnmfEgQtDqSKiw+Zl+RwFP9/crrM/owXMalZ6XRd1ROKjiE/D3W02aLHcCNRQpWQcjaik8fjZS9RN8nNGegNKrdDv6KzL+gNh3oGF+ZQK9L8XliybNcuA9XwvOT1Wq1VJ0N3aDJ640oNWB6D7rHENaSCjCTV3C3BNwE4RSIwQEhpOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=bestguesspass action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
 b=T/Ua7kOR0xXIT7BwwNvqzqo5m3h2p7FiLiIQ0q1vTXdb8Eh80Lc0tG6G3ctZW9wsXoSnLy+1uwDLgVFzhYoiNET8NgNxu0rgYvKhS0y0uthxaWWtXX+6iTIhI5gYQTOhmRLzVxNtolOSBk/6ZAx9WRax+1HjSdaF2Z1rv7k+Ok4=
Received: from PAZP264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::18)
 by AM9PR08MB5939.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:08:52 +0000
Received: from ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
 (2603:10a6:102:21:cafe::63) by PAZP264CA0013.outlook.office365.com
 (2603:10a6:102:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:08:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6BC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXFEXFlKGWu/80FSnLnJAAWeWvnyYrkjw58R7nKIREEuYr6pUXs39nPrbYMHsRa3wZq2BNGStOad3d8dSwrJSp3SFQmEYKILoU+tkPA5YdA2+mLmYpPpDCYJU/mtY3rEUFtfHZyG/56T3KsWUGm3r5Sn1ctiCQVE7CnKSmtQMgZu2u3DgP1C/FVsjep5IxmJOBA8L/7AlDpkHv1kfhYPKf41/eSu/c6Fg8j9ILcrpGDTgVToSVHeXkuJfHT8bMmwP+LEZMYAfepz+tdZ33p+0NbJkkK3IVpoHSB+BL8SzQJ/6WeagbA4C/5GZlpdEt4xuN8DPIMA5JXHDDN3UYGmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
 b=NS0Owh8Y1FWwt3o67TtzWYI64DjYJfrGKPlVXAN3hWQl0jchPzZXCQZqf38FxBLtsi8H0WV4hi/5ngibB/raoEJWmDEzMRX4AhkMqSt8rNhOnk91e6v5KLYw0LzVrmUOaLSSjHXOvvlX92u6tqmjtk3MR2s7JS173Vej5jDDZmjclHhqcIydrV3DNn4RBbt00wx8N1H+rUQawS3O6wVESWcGIBYb7y+A0FmgVR2weT+kiCunYEnwNoZKYeKDQ13Rk28SuMYN5ybhIrxqCKhFBQX5uTxP133S0xfQmwwfGQ64xxlOqeJzzFdNTLkPuWOAztlAAJyDFpw1XwwwHr0QHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeshH2mLwV0Zl+jkkSeTzjZFTu9ru9/k/8ZBW4XWdw8=;
 b=T/Ua7kOR0xXIT7BwwNvqzqo5m3h2p7FiLiIQ0q1vTXdb8Eh80Lc0tG6G3ctZW9wsXoSnLy+1uwDLgVFzhYoiNET8NgNxu0rgYvKhS0y0uthxaWWtXX+6iTIhI5gYQTOhmRLzVxNtolOSBk/6ZAx9WRax+1HjSdaF2Z1rv7k+Ok4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB075028.eurprd08.prod.outlook.com
 (2603:10a6:150:381::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:08:18 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:08:18 +0000
Message-ID: <529bb042-9f55-4a1c-867e-c50db09eb818@arm.com>
Date: Fri, 9 Oct 2026 19:08:17 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] boot: pxe_utils: Fix leak and double free when using
 fallback
To: u-boot@lists.u-boot-project.org, michal.simek@amd.com,
 Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Martyn Welch <martyn.welch@collabora.com>, nd <nd@arm.com>
References: <20260930085220.3226707-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
In-Reply-To: <20260930085220.3226707-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB075028:EE_|ZR1PEPF0000E6BC:EE_|AM9PR08MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: ba921598-aa98-453e-8cbb-08df2627fd8c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: DlCGuOG2QCls1HN1egBh5+yO5shVBmQkwkUr99n4sKKYe0lV8cgMNZYI1NcabzVGfL51KscgA4FSrUXV/BcF5I7IOEbKiLzyzSaBCITAWP8CsDoboDCEs46sqPy9adiIJOHUhNr/l12439SecME/xzi3aNooBTGaMKIW4zB39EK1DCigeyl8ZwoIYYhmnpc3DS/iHag21bVKyq37pWLzzT9G4XHHzcUXLWuMocqDmeBgpfVEL7wUmc5hzFQ0/kNNCFfQTLsHkatEVfXo4uud8nv2wd2K7FoAJXUF0pYS/nRKv+cfREEvOgjjWLnEUAhCCtsFQ+oZYnSGJBpflslNscrjkljmxRxwbnfi1nAW5qUAGX2asi9a33IGudlIVM1fPQ9wG/3UoGbzKQwu3UpufKyig0R2aHgpGEEr6sX4qMvx/qW+aW6D7E3kjMHFhwcjtzPN1UizmZZepyBV6btxnaCRvAzEodBFh8wt0PfNFVuOOa/z1oTP85EEru0PNYx3KX+ckF9D6UXwrqiOwhzanPUfB5jVBe1iDlsAV+wzP1BpOpUD894Y7xO/GtlnUh/vo9PweaN5jv73l+G9zb0S3zfuDWlMfw74NLfsMkWhUoIrQdYfYG3zZAGMhGMSiPXnZTrWA2fazQ/M6J+JyJzeZq7oRgcvpxptsa9u6IZInWU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: k8x7p2tGqN88nitgHhv9p9MctQ9FWu461vsMeEEXZTli3+mB6ONOOa92U4h0o7yPYwavRQT3078inoAbO14QwfthFyR28En/QfDeFTfY/r+IfARuIt8E7zpFiJTDs44rRElcpTDcb2MqDVYp055kTXtg9/+jzabIy7TwJ0G4DmlR9q5lNyJu/1zsF70sLhiEvvUXuKPD9wu89wCtY4uh+Xaa9tGbbOcnJw0nz7ESyuo2BYC9xRsAZW5GiP7pQIwhvqxGt4f39ZqNER77rS17g97FRW/VFHk77pRa8OWz63Iov0jbjq/3MPcNNFt/4h6n1ILtuDUDTyxySikbJRHBrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB075028
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75079e60-ce2a-4c1d-2c91-08df2627ea29
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|32650700020|376014|1800799024|23010399003|35042699022|14060799003|82310400026|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Np3GutQ+ixew+yllp2Ts0PPWkEczwfKdQX3I9ZLiEQEeBZJ/NBWPPI0PQsJVIdyBtRZhnMb2JR2fzF+hVptq6c3fGjOLasTONEYK9CmPFhkJcggafxM16ZJq2irv7Iug3tFV/RbTTwr6yt9+OcPgHo8eBT9iLpxTMaJ+OTrP7AyxDZApJ2v2Ow3sTVzatbzThDKfXvlx346RzHPLGg/gxh86h4jesBqeavHdu6U/apzswRUGeS6AKDYRrLhRrHGaeFH4A19hx1QDhA/i7m7iJSjrVwCpcMaMd3rxZ4gsxGjwck7pp7wDJ2TGAwspNRkV+wNWSXG8f2zbfyTjdFLqTP2RQtoWtEgO5LkWrksPUEgLzfD2uwOAoYykuHG8fgTTOuhLR+Fe1NQsejsPA3BSbhu96hZFCi8YV+hCapBxIr7l/7G2rLlAL0jaB4f4XuUTQvNvZdiWObrL+kz1TtEKpnyDDQ1EWYmNZ0phbivayWQdDYvMeqoM9my0i2FVE4MkmPPKvGVvCd1rOgtwnRi0WUPyheZg3FdCLUq5GCY6f29X50OUHOaX1+G8vLj5PZEdSixTgY5eF83YhQHBzV8Pu/smeljUz6dmCpe19eNW2yw+/nFyG0YOUvJv+G9ueVmwPUsbBQa9+6sD4FdVJ0Q0uu4D+vBNOHMGTmaVnUF7mAl5ls3RbgrrMcwl0f1U2TukZTPpRyRdVDkMSsYWSrLZAg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(32650700020)(376014)(1800799024)(23010399003)(35042699022)(14060799003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m7aSMpEgtxEHaqVmsPe2BU8jJQiHL2gOJ56/kldo5zb4hJ3hOeZXjEHxg12FzoAXJB3xS+t2IkjuWwPOipGG5c/5azBIC+LGrrVRQB+UCnqnQtKZ022EHdGFfYALsRdVjcP49wZRbkwwOvtG6GwbqeRFduGOgSmQUZSVkh5S8sx3rnCDcPt9WA/9t7WTLC9gcF5LKe7xAG85U0rQ03DTKzkhQIWac/e2l6x38lR/i24dn5SFTJLwORfUhlqywDvzcpOCB+9tisfIyzP9YhDjiIBiMyXtwB7LOtRE5O69UKWNabebssbCWTnOh8auMnjBrpg4p9MW5MMGBuDe33UDyq5eUJ0dg4WnfFd3xTs6RJU2u1dSZrieLmpdmt+/RpgmWW7WyOXWGIYROHJJa1A6Cq/BY0lbodK/jLrdI0AbxZ09A3oGkKbNghNIuY2TD1vW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:08:50.7740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba921598-aa98-453e-8cbb-08df2627fd8c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5939
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

On Wed, 30 Sep 2026 14:22:14 +0530, Suraj Kakade wrote:
> When use_fallback is set and the config defines a fallback label,
> parse_pxefile() assigns fallback_label to default_label. The previous
> default_label allocation is not freed, so that string is leaked. Both
> members then point at the same buffer, and destroy_pxe_menu() frees it
> twice.
> 
> Free the previous default_label and clear fallback_label so only one
> member owns the string.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] boot: pxe_utils: Fix leak and double free when using fallback
      commit: 71996b9af04af705be67ebf0e990e21889072ecd

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

