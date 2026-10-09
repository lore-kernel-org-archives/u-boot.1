Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D2CCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1212C60609;
	Fri,  9 Oct 2026 17:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIvpcogkE0AL; Fri,  9 Oct 2026 17:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D432860658
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791566219;
	b=rQ9FUVD4IdD4uUUe4i+0QgeRLBQe8lAmSzeJ7SgFSlO64RuQM8os3zkeUCTGLvlo050C
	 hrvCT4i4VE9RsHXIUgq/7Sci4Uq9lSgsSKXZi25XcxGrvScHTUYEjFzpAzprcK6pJoH+E
	 I7s+Na75NFcQSskMWNcBrqoUzTIkpsExgd22RGlqbNXrNb6dlQOx2WZ6BUlH4ZWrzA/nY
	 6yqL22t3IFaYlb2Nvl2T4TCDggUE5wmtL8GJJqZy0XV4YuknRNMRnihMoT4rUHoqfMDGN
	 JTxA2dnBdeb9TwNLBFknvE3cFnB+I3JDCyduK1GSiKmLkaU6/7PzJwxCDsAA08vaBgQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791566219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
	b=OCUNm4szXrV+gmpUK/evrGjZ8NZ7IJTesQPjw86t3Zn8jQC33RokzAhbQR4TSGWsNro5
	 YcdP56of6Yj9CG7V2yPW2qQZXYPcphL5+9rk+LEqIriywbrPNSgtOXOs/am2at4xi2Tz9
	 TAk+lw/RHpBpStUOYumau/1Mu5BIRqsWJNRvOiOczOlToHJRhYkadRWj4cdAobwXK8Cew
	 QSAOJEQ6XWlpFMJpGT0quWCREHE6aP+GAYjKtNotSCE0XDBNRy+tMEty+561od67FC+wc
	 p30yNZsbCbPfYujJT0JU6cDLE4ogSvi2Z+UJeY8Ox9GqM6RjvVTkfL1jza96l2BY3qw==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bmc925w4;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bmc925w4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791566219;
	bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H9QKxTeKRuu/ITBrGwY0nsbnP/QmBrHUjp/cCbOemQk4hCObIy48Cvk09PgxtyAQI
	 McYFJQ8eQGRcpQgvuG7WKL3DAb7G+Jf1mWlJEW3b7MdDWw2whcvk+edTtz1tf/Kxtb
	 ecA3318H2uqh6OCqzovm8Y2uBeZq2U4r1ulzhxco0CX5L2BTVTm30K9bUUvSdgQFQz
	 jfV6XZgRzaAhyNfVjvciqALBCJ0GSZpTwWz3oiFb5/UEOAQTkW5WpZxgIgu6oYrvNG
	 RNpHmRUeojf9murjpKxyBnPKTwees8Z84hmA11MomhrUBmAsbpY/gvUljauRAZIVgX
	 p3oADrRWRh5xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D432860658;
	Fri,  9 Oct 2026 17:16:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A1E913B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFAD260658
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 532p-FPTr_EG for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 841B960609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791566217;
 b=AlsBVSNA5KMnZfZ0gj+L9mF0iyICnQ5oSJroXlFHMBZnRnQ5ESoFTF3KIPqzwXykNl9O
 brZchzYjrKT/L0GxYZPHzrCsGAz6DuapauXIMQdFfm5Krhs0kNBXi3rKj4Yw6DlawuDMQ
 WaQbDhIRTlqZv+4Yy8kVVboCHut7BXwSIOm4oEjJlk4uW14tTGZOBmlfDVm43rXVwlhJc
 iFnJhKTFIHsXUCATSjQUjVjn2Kok2JZJS+GGLG9JQcV1YUJgxXbHD+tTWbdxyvcwk6I/S
 JCApMWJ2M15vun2hVMO+ZKDH2cukoLB7KWjY0uXPwfPed6KlBaIKOfAFNTNTnXnYs9A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791566217;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
 b=A1lmoJBHjvLtdHDHXHvAnuLjSCxDA58/EY7A1dYzXctdw4SSCoKnCcbT9XAM3fLx4HX2
 IYOHz/0XNnesbfHzSnGcvdbtTEJ/jAvZn5sF+eU2rxQmAfhWz5eT6SZ9If6lYcZI1A81M
 0ATwKQSchWx31reWhgkeguPnIniICtDmHXCSMi6JobjHLewNWrq8Kywnatbz5VXN4QJZS
 X4GaJ29iWryi86F+WtXvhh4/QGW1hncOl3shyjXEnD1y02r98VXnysfZ8g3vcB663nAG0
 lyriYrUMZICpX1csXnAkz+qB8AuOrkub+6hDFfDvjVOMXKFjWTe8ZxvsDvFhKLngH/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=bmc925w4; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=bmc925w4; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=bmc925w4; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=bmc925w4
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 841B960609
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:16:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QlwiOg4f3VvWR+ndzb98IFAovAtZpY+Bys6c9rWfEtlBA+9lwmf1SeH/kFgxN4u1PitI0DKx3KKvpqJRLcxHCUSo5emiX95t6aELaeah4ZlM/kB+WROQeINoCLwwqVzl7GVEV5jyDCLelK9EGSppdqyEW6QFHDhPPXm6/QOpfW7b+NCCic82HWSk22JvnMV48yQADul6ElH/T85jst7DsIyAjLSx9Zt8PUmfK7RLa87nhrHxFkzmpx5nO9faet3c9FAcUIuEcNpEvFbApdgSHJfO2TVjXtug3148joNZ1Lbxpft/7hjP6eRLNSR2+quk0Io6gZ1zroj5jInbamcO2g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
 b=vd0s/ctPjWu/rZLvYU2UL7aGkYeTQA+PAd221qV1yr4HZkOjHVSkedl2DPFKt0MGk6VJ2LXMnoWyco9xPLjCB4l+8JQl1JsolCdEYBtPqUdagMj/tK7wruJDnl8bOAG755SE0o4DHPvT5XkXdi9BUfs2pVIEeLqGlg6qNzXhHAaDfB7eoeXbKK4QtCd8LpgBu+vekpWTsU6oP3D1bbYjSoRt1A689Xs505Q8KjtA1z6jTBY2BNP7aH6KM/ov2JG+1vcNOQ6833Frp2O4EX7Q4oCrCLdFMME0LKkVY+yhAJlHOM4vYC5nw5z7z5w4RYu95D0GsUQ2Vmjn/1Kg2YovQA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
 b=bmc925w4JqkC23SQkRrHyELTAKPs1SwTdU45B4LptGO+88lLUpXvrn3xGkfA0wWEphari+2ms2mF0QBIIYSjblCusVD5klUJoIg8ez8msen1E97uzHvYOvcxgXC1y0NPjthBg7c/lP4yL84AMIxji9/TEuPeGxe70gZgTWit4ik=
Received: from DU2P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::6) by
 PAWPR08MB10994.eurprd08.prod.outlook.com (2603:10a6:102:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:16:49 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:10:231:cafe::55) by DU2P250CA0001.outlook.office365.com
 (2603:10a6:10:231::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:16:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHZeyhXRf16gCXhSkWF+WNSCuNPrqyO0h+rM/yTpWbgA4z1zcj3DFuuCjA9nYWOIczeuRVidyJERnOe1CK1ns/8v0JSgt/MEB4Mmfr9fY9sIg/+APjqou40pJO70pYUPof6IUkENmZ2u6JSYIgpdusMAWoK3tirkV991XmuX9PlJhL0AyInwsZQj4Dbb2mXvZUkiz0e4qPKODrRYtd2ogK0ZKNE/VqKyJppbquTM42aI0w4pOkyuDUHdB/bPJoa6+5TpV2nmzmJg3IoAZaFYBvUdBnwXLYLyYYztBxE2OjCDFL6D89eknP+GDvIimoBjuyFqTdcKWbBzy2Cmtbb8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
 b=n9LOUJv7jW+LnfVj8BS8/dAd3BlnFTzGzzFHNYeZ3V25Y+4AW7ZPCMU3Fr1yZ5roDW9LC93GJZkczdzDih0gq8yNqT1QxheX9YZFzwUi8NiWJ71r7DrKcQmrwElU0eU+nPL2r17e4nswLYZLiZSa1wqCcmXrdGugWac31AhbL31T/TmM+oU08vLuM3RAEeU8yi2DRRIEHYCozxysgMmZkcZqiucRpv152g4pIc6G7Ah3dA4j47KJ334cSkxHIhpdDaRBey4+pnx8+lziiFJSKC7LCNj5ZRw9VLd/5P6c82r5lysbAS17F6ApoEXx4Lsta2YrozHtOsrJavwStmkfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU5RsUx2dkQMVmgCkZqj/wj0wNlk5rk9H2tXqluKBbE=;
 b=bmc925w4JqkC23SQkRrHyELTAKPs1SwTdU45B4LptGO+88lLUpXvrn3xGkfA0wWEphari+2ms2mF0QBIIYSjblCusVD5klUJoIg8ez8msen1E97uzHvYOvcxgXC1y0NPjthBg7c/lP4yL84AMIxji9/TEuPeGxe70gZgTWit4ik=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB10890.eurprd08.prod.outlook.com
 (2603:10a6:150:1f6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:16:13 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:16:13 +0000
Message-ID: <00ae9774-169c-45a4-bbdd-89665bd45515@arm.com>
Date: Fri, 9 Oct 2026 19:16:12 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-next-20261009
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB10890:EE_|MAD0EPF000008B2:EE_|PAWPR08MB10994:EE_
X-MS-Office365-Filtering-Correlation-Id: 988a716a-9ee3-4aec-6e16-08df26291a9d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|56012099006|6133799003|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: l80+bD9OyG4iVeHlgOkpiSXoAF8xkCaDWlSpHHSZabxFsfiF8hGd8BPAP4dbIT9tbStn+nMUnGrTu52u4y66lmJ27If0JWtmefVAiaA2t7HIU/CosZuFm2WTwzZjKU85KxJbEv9syOvcNUWL/GFYoIA37U1fy/s53hJkz6Cut2cLF+g7G8jjPFWcM9xxV49voIJubAeC1Ps0zgiHKsAyRCKXk+6h+9COX9JVZqPPM0DRSjvTbhFo01A9D0dAaw1IrwJ9jfjIzUMZXZ/X4E0JqA8XxCQesHz6ZigtTtr2RjT8a/piCwyTFxyrZnyj7l942Z9CjU6XsAOZo10PZpL4RCZ80YVxnZXxGOoiokMVhtJA2HEHm1beFqYWDCEO+qmV1voHmTOtT6Xi5aGIjKa31gCiV8S9iuS/mSSrZowi9M71l/vUhvibyI76SP/zmhgMMjaud1adWIjSdFUIuRE61nvWZHt1rnG2Lgywn7GvaKPasXyt1NT1aD4JdjwwB0HNg0E9tPGVFcmG2QBcMxEZTA8Y9EhDVfr30vkQFFPjIz7qRcLdPi/+0sQM4jxnNFZgmWPgT4rNAa/xruL/bc3OXX2qMUAnRh1mV7/lIGsClTc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dzESDf2j60njmIFUCV2YEnjslRXLPZipa9zoCO4jvtZThWkc4JYwEsTomQP9XnMYtnnUZAdZsn+rRyOLbXRUy/6C6NLBE8Rm6pPPbsOtJ02GKsPEN/fDGivypgt8Xz5BUTFpWQV7rr8QeRDie8njUKoqO8kRaZjqz7oDZdVFiiuCGGWBRQDOLZOXO9R7KhktTVWPKU8bookAxoK59rlx0zF/5oywUeJOJJ1tGA5nWZyTco3CWpx5R6VAkzpHbAKJ7C3VCt1QpccwFTDitJSlpmZ8KH4239zZWjRUBKmNZP+VBzsDF3XmwLis+b6SRKP5f8cnIK6O4l1fBIov9PxmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10890
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15fc9db1-c6f4-42d8-f66c-08df262904f1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|35042699022|14060799003|1800799024|36860700016|6133799003|18002099003|3023799007|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: jCyQPFkl11WMKTyztDcaDVtJAp2e/uD5ET7lymTYu+h5klrl+oa6oaGAmdxKyA5KbG20K0i7kSeOKLi3DIXkQ40ZxuMxtteuzHiUKS7x/r+kBWqBTzeI3ym+rJbahTfJqS3g98lGs/i9wzeINwbqr+i1YSXEtEf/UU9SGsm1j9ZXHWCM7LbtMGL0HKipIbqZQlYsoJzScM+U/C1aM4eGs0ghdWBzRFSofks1C1DcV4vCVNm+XlLWM1PN/cpPLrvvDxBJ+JnLDEaPIecqVr1KaRDUbj+is+RNTP2ek7SJj9vyDgbVda5tc883oxOXMoAKLDEy9KGEEG+HfIY8/FyAra7c+ecuBtxQV+8xOo6oLZUJMEtmg9Z3DxteolBufzIqJ6O9ZM6jy/icCkh2sl4icvC+sXUZEdPFTts6v9n5+VazBAHn50xBWJ0y67oSOSK9TMDxdVLYAVg9hi5EApFMXa7Cl7qCJ5YuqoZvmzjeEz8cLpziAVwmRCoStNAdUnu5J7c1qO+ARh2fk51yiRQfF3VaGjvXrL2BuDyoBOvg47woByyccEJY1VR+CdY2wZinKpPjn/XSN2OdZYavIzaoBh4D8F6HAgdgHIcsaMivlmG5fJLSEMgRL3GqhcXjc5xuE2YRq5DXDeEB9r0/RRKrsw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(35042699022)(14060799003)(1800799024)(36860700016)(6133799003)(18002099003)(3023799007)(13003099007)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CkQc9Cj83KCX8eSCmtkj3t3O5Areyahvwdbl5nBbDcAXrnotwlmBBQQfpJrSXXHWTUlGI9+vxQrCgNZ5XB00b1+Ed7Jbx3xL+Oi0UoXkG2KPAgi9W3+/v6AqZ4sA2l1ZHqRzmZ36LLmJe03qTYvkZDjxULe1VCwpx8hUPECehCecJ4K1Z+pd4p1xTwVtNMmduRk8JFHa74+6meZd7JC74lxlyU43+d5MRQLgGtiD0713meg7vrkyYGb7y5xmfNWH3DkBK4PY+X+KLyB4HdfiiiA2Sl2qeIKk6PsRAuoa+iBh30CaKlZBjKPLaH4ERiCIvVBem13WYou/B7YgyfAO2fctBwjn5VY/W4f8u4PuwVtQCPZ3BL6+IAVBzQB2f3F7FfwaTWFbzwWqmQ+533kEu1xUr00bYw5YVjjSznsTOCKDajhrRnijgNiXm8FWx53Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:16:49.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a716a-9ee3-4aec-6e16-08df26291a9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10994
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

Hi Tom,

The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:

  Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20261009

for you to fetch changes up to b6aeb2b880fe96b51ece8909cf37a73a7927c4b3:

  net: eth-phy: Add reset control support (2026-10-09 18:22:34 +0200)

*** Please note ***

Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
error detected by CI that would otherwise be caused by "net: e1000: use all
RX descriptors". I did NOT send that one out for review to avoid delaying
this pull request, but if you'd like me to do otherwise just let me know.

Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
initally failed CI and I incorporated my own fix (see the commit
description).

*** End note ***

----------------------------------------------------------------
Pull request net-next 20261009.

net-legacy:
- dhcp6 use link local address
- fix UDP checksum check for odd-length packets

net-lwip:
- restore BOOTP, DHCPv4 boot policy and PXE parity

net:
- e1000: use all RX descriptors
- net: fsl_ls_mdio: add match fsl,fman-memac-mdio
- phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup
- dwc_eth_qos: bring PHY up before triggering DMA soft reset
- pxe_utils: Fix buffer overflow in pxe_label.num
- pxe_utils: Fix leak and double free when using fallback
- phy: dp83867: fix register number for extended read/write
- designware: Fix MDIO bus getting bound multiple times
- mdio-mux: Recover gracefully from bad parents
- dwc_eth_qos_rockchip: Fix use of mii/mdio commands
- eth-phy: Add reset control support
- dwc_eth_qos: spacemit: add support for K3 SoC

----------------------------------------------------------------
James Hilliard (20):
      net: lwip: bound NFS filename parsing and release its copy
      net: preserve the autoload value across dhcp_run
      net: lwip: finish DHCP before starting autoload
      test: net: cover lwIP DHCP autoload handoff
      net: lwip: add a hook before accepting DHCP acknowledgements
      net: lwip: carry DHCP boot options into the environment
      test: net: exercise lwIP DHCP boot option handling
      net: lwip: export DHCP DNS settings without a resolver
      net: lwip: honor configured DHCP boot-server preferences
      net: lwip: support PXE client and configuration options
      net: cache accepted DHCP acknowledgements for EFI PXE consumers
      net: lwip: honor DHCP timing controls and request header fields
      net: lwip: add a hook before parsing DHCP replies
      net: lwip: accept direct ProxyDHCP replies without a lease
      net: lwip: retain boot metadata from the selected DHCP offer
      net: lwip: retry DHCP acquisition using the network failure policy
      test: net: exercise lwIP ProxyDHCP ordering and validation
      net: lwip: separate DHCP exchange from boot configuration
      net: lwip: support standalone BOOTP
      test: net: exercise lwIP standalone BOOTP

Jerome Forissier (1):
      qemu-xtensa: Increase the U-Boot memory reservation

Jonas Karlman (4):
      net: dwc_eth_qos_rockchip: Relax dependency on reset controls
      net: dwc_eth_qos_rockchip: Do not keep reset controls asserted
      net: eth-phy: Refactor DM_GPIO guard
      net: eth-phy: Add reset control support

Mingtian Li (1):
      net: fix UDP checksum check for odd-length packets

Nora Schiffer (1):
      net: phy: dp83867: fix register number for extended read/write

Pranav Tilak (1):
      net: phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup

Sean Anderson (4):
      net: designware: Use if instead of #if for DM_MDIO
      net: designware: Fix MDIO bus getting bound multiple times
      net: mdio-mux: Don't crash if our parent never shows up
      net: mdio-mux: Remove ourselves when our parent is removed

Suraj Kakade (2):
      boot: pxe_utils: Fix buffer overflow in pxe_label.num
      boot: pxe_utils: Fix leak and double free when using fallback

Vincent Jardin (1):
      net: fsl_ls_mdio: add match fsl,fman-memac-mdio

Vitaliy Sochnev (1):
      net: e1000: use all RX descriptors

Yuxiao Zhang (1):
      net: dhcp6 use link local address

kongchen (2):
      net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
      net: phy: add support for Maxio MAE0621A Ethernet PHYs

 boot/pxe_utils.c                     |    4 +-
 cmd/Kconfig                          |   59 +-
 cmd/lwip/Makefile                    |    1 +
 cmd/lwip/bootp.c                     |    8 +
 configs/qemu-xtensa-dc233c_defconfig |    2 +-
 doc/usage/cmd/sntp.rst               |    4 +-
 drivers/net/Kconfig                  |    1 +
 drivers/net/designware.c             |   71 +--
 drivers/net/designware.h             |    1 +
 drivers/net/dwc_eth_qos.c            |   51 +-
 drivers/net/dwc_eth_qos_rockchip.c   |   21 +-
 drivers/net/dwmac_meson8b.c          |    3 +
 drivers/net/dwmac_s700.c             |    3 +
 drivers/net/dwmac_socfpga.c          |    3 +
 drivers/net/dwmac_thead.c            |    3 +
 drivers/net/e1000.c                  |   87 ++-
 drivers/net/eth-phy-uclass.c         |   38 +-
 drivers/net/fsl_ls_mdio.c            |    2 +
 drivers/net/gmac_rockchip.c          |    3 +
 drivers/net/phy/Kconfig              |    8 +
 drivers/net/phy/Makefile             |    1 +
 drivers/net/phy/dp83867.c            |    4 +-
 drivers/net/phy/maxio.c              |  228 +++++++
 drivers/net/phy/phy.c                |   12 +-
 include/efi_loader.h                 |    7 +-
 include/net-common.h                 |    8 +-
 include/net-lwip.h                   |    1 +
 include/pxe_utils.h                  |    2 +-
 lib/efi_loader/efi_net.c             |   72 ++-
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |   39 +-
 lib/lwip/lwip/src/include/lwip/opt.h |   67 ++
 lib/lwip/u-boot/lwip-dhcp.h          |   28 +
 lib/lwip/u-boot/lwipopts.h           |   78 ++-
 net/Kconfig                          |   43 +-
 net/bootp.c                          |    6 +-
 net/lwip/Makefile                    |    4 +-
 net/lwip/dhcp.c                      | 1106 +++++++++++++++++++++++++++++++---
 net/lwip/net-lwip.c                  |    6 +-
 net/lwip/nfs.c                       |   68 +--
 net/mdio-mux-uclass.c                |   39 ++
 net/net-common.c                     |   22 +-
 net/net.c                            |    3 +-
 net/net6.c                           |   25 +-
 test/dm/Makefile                     |   12 +
 test/dm/lwip.c                       |    2 +
 test/dm/lwip_bootp.c                 |  573 ++++++++++++++++++
 test/dm/lwip_dhcp.c                  |  364 +++++++++++
 test/dm/lwip_dhcp_options.c          |  691 +++++++++++++++++++++
 test/dm/lwip_dhcp_policy.c           |  286 +++++++++
 test/dm/lwip_dhcp_proxy.c            |  461 ++++++++++++++
 test/dm/lwip_nfs.c                   |   61 ++
 test/dm/nfs.c                        |    3 +-
 52 files changed, 4367 insertions(+), 328 deletions(-)
 create mode 100644 cmd/lwip/bootp.c
 create mode 100644 drivers/net/phy/maxio.c
 create mode 100644 lib/lwip/u-boot/lwip-dhcp.h
 create mode 100644 test/dm/lwip_bootp.c
 create mode 100644 test/dm/lwip_dhcp.c
 create mode 100644 test/dm/lwip_dhcp_options.c
 create mode 100644 test/dm/lwip_dhcp_policy.c
 create mode 100644 test/dm/lwip_dhcp_proxy.c
 create mode 100644 test/dm/lwip_nfs.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1531

Thanks,
-- 
Jerome
