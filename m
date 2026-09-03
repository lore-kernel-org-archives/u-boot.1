Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA8EC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 09:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B36C8107D;
	Thu,  3 Sep 2026 09:40:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2zfm2zfRoj6; Thu,  3 Sep 2026 09:40:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 01BA180FF7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788428415;
	b=KWQ3ALY/yriTrE8gyhC6XUA350lgDB4eRtj0QEtpu+mKz8mboB0S1QI9GqkBwS+s1I5Q
	 qVaVeMvZFyqedjYrJGOxjrN8VJEewu0zovdFyZ47IBBLanzAAknhcij7RNIztLh7askCz
	 MW5rHPzboDJ49dn7NgfTUp/Ix6dFeGuU1PwoUh6Dd5zEdWxlS/XhNesxse4p85xwcsfwZ
	 8XFSVPYfEC8bDSKIsIPv7S30EuOI9lLkR8ce+vRL2HCdvNYYCqg7p5N/SL6afAxZuVhw8
	 v63uRGcaU9mZIYCeGOWSORyl+axfvIQKvi6NMJlL6Iyd6OJ8FADqhKwdwdULXgc7xQw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788428415;
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
	bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
	b=L8bn5iRlbApOMfX7FAwynfdOvrJfrIA4CfC+IPllmIGP7l0AJUFR+ir7ZQGpZ2nqT43g
	 fE30XG+SWL7c3yzAE9ezneFiexDR1yz7LVtbqLUDBTBM8LFFHot0M94bLa/Vgmbo2rqnQ
	 86gwqlbUi+9qXcARknUv+Snf5wLqS+g/TS4GS/1tC4oG/xaw7T4Dcl6IEmHjA/JikeIQk
	 HbP8f71q/52MlTL0dqlB9xrKwwc2jaiOnNC6cphGoVHqwREOeH91l7Ip5vztwzs6W/wNk
	 71wpfiBuAvcYaweYiafPJGpUw0Zup/aV/SNm7iXRAV1Gswgjf9fN6IRUHVtdp0eahrA==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NzYz3qM3;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NzYz3qM3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788428415;
	bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R6oak1Lh41SMRogXB/M62lLPJGyDxcln+GhyA9Nte9s0GWKNCsKC/W83gscTB/tDc
	 AdXzdb8yonjyCvHKZqmU+UweLTdIiZth5KnD+t9NmKOaLNEBVqN3g3kn4lKp0mYNQ8
	 cQXmC6zSkpowEWzT5MV2DUU8LIH7LNYrgY8UXr6pXEEkYbr6Vfv7N8sHxp951BYnpU
	 3cYJ3gJwVPZpgFzWTWJhKnyvknP/ZJOglCjEiKfNRbaaotzxm4AMWI92wJZ9r6ER1A
	 0dqTOeF8W03k6iHCg5tubjYqGiWxt8DBKTq8CsJP3H9BIK+Ro6qCK2PRaqq7oYr1+x
	 967RDPNOJ16wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01BA180FF7;
	Thu,  3 Sep 2026 09:40:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5D3E230
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 822D280FF7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0XLjvLZVniu for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 09:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4268180EE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788428410;
 b=KG2ovxQSHnqFyk3MpsBFCDAEeL6ybv0H4kyP5Y4o9t0Hwfo3S8RYsEkT2wfZ50sE6ZA9
 n7jMdEjHq/kdeQ/B+LRd7gPftthoHBJqiWPmbb+vBrtNYqUDZTktbbXzoPyk0Bq0s9mIY
 WODo/Ilm/+RDrLMNdG+BAN7UatctQll6Xmyp/Tu+5X8/HK1XdxGDAq8t6fqU+HCmV87ei
 MRISy1QRmnjqwgt5o9G+41qKEALWKLehi+VpLkKg5/jCoUQ+GooHxmQPUwL11mkMqtF13
 w/X4Azob8SnPxAY5OuO6WQLzoKkyYlYS+Fg9Zp+b4Eo91F8HStxaC7qV9dypqtF6Iaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788428410;
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
 bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
 b=LucgLwDxTjy1s3kbnM1dh7+l+MywnQt7/bJlQ2CDjLTDVedZFKSd65mw6FfXhaFlRfWA
 ovuGVZzLy30S35K1wetPxp816O8OCmwAumhzX5CYCNMuNGMNwfxlbE/tfosApp3A2KEur
 fVIzjSVVTl6kI2iioDnw0hKAz60qSXieQDxAO/45hFRmrNYRHihdstKk7LXhEidR3vnCf
 HkBWRoKQmD3e5SPBagCbMuiLEEoMdptkKewE8t4h8sXdj089bwUbBe28xpdjx3MtxpsAE
 ohvCFDNJpFGnMIHUw8YwmhmuhDqDGlP9zx7Z9yGo9YMn/okTUiMM+3wO5urqokdd1hQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=NzYz3qM3; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=NzYz3qM3; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=NzYz3qM3; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=NzYz3qM3
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4268180EE6
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:40:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MeQXishsVtSyt9jdBicAnedel7/QEvHldJWSroscKbuQzFfsuOTdg+ymgwv+KTi65hlL2tDFFTiAIJz8J74yaeBisVMPPsPVJXOL0lrIBC3ycrZ3cY3nxDJSoaZat3vDy2aSfOxK+wIrTksyEktzg+xITVz0ydQzABExn/YjLKBKsZS0PHUWMovuV47SezgXNfEgkWwomPCtJQ4fkVz1bGpQxCPUfYg1LrCF4mlrU7rGjoKTjijHKj3a7rliaWWn92kkm5a9pPlXvaK8qek0tw6iTXNc0nvM7CiI9Hnut/UiXbPnN2SMhjOUjFfxPctxe1HkpTQukL9KeJOv8xZinQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
 b=M/t7b1G46XAze3KtkI1B1GdDVnTXXx/cxsQgbkFDfp8pI0jWX7io2RhgI9ILDMAB7JJIgF/GPzRR+BDTaY4Cg8ssR5f8KiBHzBTHlvu/B4ZrA4q2t6nWhRvBo/ktWpYx/S58M3GnCLuOYlDDfFUAnj/6Lr9sZzIbwUDvzIA2iZg6n7AYCuJ3dpPw1MsPOcNQaYi53DBUFSldJF27bwc6Ic8AbuJXSlOSIKiWPr7fBfOBoPd6rSqXTcf6As4+ZW09Lnz4FbuNIFs+chvHeVnB+PNtgN19WNiaMz8SGDw8wpiBx/Rr9RbmP64E8Y6lj6hj18e+/SivmjM0odMzHKvf3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=163.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
 b=NzYz3qM3xqXDUAKQVfthq5Ca9HfLe150qji6bBFl7nTlkUeipJca+tnk4hUIXVmqOKgiH7H4fSA3Ao5uqE1l08G5m8BuFRoCN/ZiaClx4/s1Hp71mBKP09tXy2lijCDEyH/q7QnqHwRATLVJT2zGcJmzggIxSpj2X59uRp9tWOA=
Received: from AS4P189CA0045.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::17)
 by DU5PR08MB10824.eurprd08.prod.outlook.com (2603:10a6:10:526::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:39:50 +0000
Received: from AMS1EPF00000099.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::7e) by AS4P189CA0045.outlook.office365.com
 (2603:10a6:20b:5dd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 09:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000099.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 09:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXdglDmTXOBDaBVJh0iOozZEZcVB9A79nv+rZt8h+OaMpW1UJuYq6DG8OtoYp1V1l0Q9GTIfLeG/bKS/o8BjCfpCQhhPfw2CesjGt2SlyBYbKeNfMVHnwspOx7jfbGRhZyLb8w3c6CzCK5zMFzeCcsHE6lKrRb0ZTcGdXjjxxo4ue4xQ89k9Jg3EWIoI2xmXBuDbzzAMCM1w9As5s2sETwhWS1C+X1LLu4Wmf5ZU+oE4qAT2+3gAPjEIur3SFrQCskU+gMOk+XAt0yTEjHxKsADRY3v8OAIT1ceCkCOF90doZ2AYBSF+ZJyYgW56QIqiu9ygWHRaVutxq4kEvQ6bGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
 b=yHjOgnbDlJ2M3d5P4sQBCEoaHIDtuJEFsmiW4q7uPkgGYvgB4iMdrckge/x3lFiIqK8Z2QqL6oHwr7bEmpYnYTKe/A0ZRXt5mX5ehvePswxvVe3lJ8t+DoDFfZopBOI4SsClkkrZVpYDnXtLNfykM9gilUGb6xsYv7WNcHCRpxOkUb91yrafIyro7Mnc0mP/yu5TjBHtEcH2a/uNBHSNXmp1UwibHSG1UVlLerBmPt58que2sHFBCIL5TC5J4tWP4N5eQx/UuI5uI9IoeqMaltNXZv3ejyLcazFpJhKE7lWYiffZHJFMySOq019urBbHSi6f+KPpyOQ0qyx5kWnOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjNLIU9401vgZAu1ABOZXh6SA0p+krWpiIpTtXYH53k=;
 b=NzYz3qM3xqXDUAKQVfthq5Ca9HfLe150qji6bBFl7nTlkUeipJca+tnk4hUIXVmqOKgiH7H4fSA3Ao5uqE1l08G5m8BuFRoCN/ZiaClx4/s1Hp71mBKP09tXy2lijCDEyH/q7QnqHwRATLVJT2zGcJmzggIxSpj2X59uRp9tWOA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB11543.eurprd08.prod.outlook.com
 (2603:10a6:150:2e4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:39:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 09:39:14 +0000
Message-ID: <7f78e744-9000-460b-8b2d-a8a80933abc5@arm.com>
Date: Thu, 3 Sep 2026 11:39:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha: fix PCS calibration retry limit
To: Li Xiao <cincinnatust@163.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Li Xiao <Li.Xiao@airoha.com>, nd <nd@arm.com>
References: <20260818-fix-airoha-pcs-calibration-retry-v1-1-5963d388c1ad@airoha.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260818-fix-airoha-pcs-calibration-retry-v1-1-5963d388c1ad@airoha.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0311.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB11543:EE_|AMS1EPF00000099:EE_|DU5PR08MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: d9378f43-059d-46bd-5456-08df099f4c8c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: wo5nU0fpJ+L9XDTnhoigiLmyPaOm5q04K1tRF+UUz1hlV4xE39r8zHcy3B365fopNM34Avgqjato+JTq0wEHhf0Pt79te+r08hJfQz4wqG8HUKsmJoXyRvvVbAzjJzX8ht12XDyxC+sSZBddti+bKd8CH2tqPqdRxHKPlGpNFAtCPAoKAsMgB21J+1a7LUofVCYLukXpFAQV+kbOmvuZUUp5suhEI1sZdrFsIsLXNx/TfhuV6q8SxXNpDECo21oDsPzfIy/bxUSUkDgbldLxcBihOL02gPI8KdlxsG7fbnCY4Cp249uIPEVlVwLSRHrM8AChhjmUZ3E2aFCcghxJUJI7+AIwdWXez9ECrB5jzeIp9sDNd5OeVKeZEgFxG4BQWIbaypUrN0TBFiVynsSoUOj3p8pL26z1aPp3yUBPV2EOW9rGuQARDg/xU2Eo0gLafmvivsvG3T711MVGC3RW1VBe2jZbPt9eUz+IL4XSFxdz3Sy9daByaQkx2Hn17gavjwGdaKdEcFRcJKVZG3nFvKFCkMmQqFH9tTFyoXrUXl1X555O8TEM3wz+Y1OdhH7OpUsbFHfo3lE8fv5xYgVT+LgillAJwZE/BBZn9HCD0tKmK7mXNmmHi2Ciu/sKHnjTh/CmLRCoYBviZ2WaOTgX+clVkO5jDWVYg7gfxZYe3Ys=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: i9r2Po3VLMHuC9lmCW1lr4stLa7rdX3mlmHz2kPRmX1+inBAD9HKXAgo9gjzMgrczbtOkPoGW1++/WwM81HVgR2MSVvieTBXTAf7iBraXHA9t5fjrVF2/cf/nh94h5Cn+7zNgw4wisXI565lRJ+FukNVMW/pxmX464Ta/4Hptt531UDei+2raSlm+ci2xcxsGE+td5Ab8BOG8IMkD+2u/Tp8ZkTlVaGCFNS0xx5SUHEU6zr2ao+xVfN2YO832ncnwylBx3xqTuAolS7lqYKyR1Rmw+pqe7ORFK1eIYYm3oElD/A0GZAS52HXwsaIqBVoGPjm0X4pwCdrSyNHMQ3EBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11543
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000099.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d533de2a-67e6-4a2d-4917-08df099f3767
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|1800799024|35042699022|23010399003|376014|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: JrYyfDbNMUDhc4UGyk20LsHkJwTqH0f89P+ObpbvL5O3u8lFfcRFu30zKBOSLnErYDQreWj0T24XKIPaPz3lUiTXjZzCMUtTd8Kr6P+/rg0+SSaxc3cExoIQQfIaCqozxCcI0SQWjUkYkw4oSoAA/3yLBikQRzqFZpgla8qAJLeD1VWOs2p3gRZjzcatyzq29aqEZLig774C8q7QJHEzkKVTI4yujRIZ2bZBQfjzmv6Ht8yZggPUDvvNgekmaLM9LjHdrqyJ9QRv3gyOUunfx5ZLGCYfOPSJtS/QoKah/7Ii/xVInE0v3KIjbcL73648tWQwJXC65BYA7uqjvew1/jAHQnVgVqHpqsFTuBhRj0N7zSns7+nLa9KZozgGciZHI1A44dc6feTC2bkmG293czks9HR4JTHjn9OaqWwU3m+8EgvZumgZ2yk69f2rHfmp5zUO308oTIVLyYGaYdk25ufnEMQHPtadUlVhUsPaV/RujTIdOdjeOGTaobZ+yBdRbwGMqcDGQcxu1SVNwU8g7h/6Forsty7gSp9JMvRYBqAeG1jSZ5VPFTBvM0QPeZhvkft4hDL9b6EHUDVaeTMHSsd6E1Iu0ukwuACKmkOD7QYPrg5Ow/1kzharvccq1SO1Lg9v3GKBdXnFMjnrLAw/Z+o3/CQgTy9FJX6rFDk6OmA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(1800799024)(35042699022)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7GgsImkUQkoKZ5D2X5+TMXleuftHonXNVqn9hcx5u7UGxd9y8m3ucogD0ZzcyjObnsqYrsEz2AAHNj0NsK1WkFaO/di7HnEa4vH6x91F5+myXHCgVmqMXWWKPdUrfa//AI0Pyjr9GmmujeitLTz0qPamFIEXvbrGQVHd3SkuBDBbFkHLTK0NazcFMat144/dJvJtoSjyxch5a63ykXjDuRtc4mUF7xKrU6BPc+a0O0ywWlZC2e4eTwYe6beUEPT7CPqh3XPqAbqlqizYWS0rAZQhp7766xiRLkDfn7v3AdLcLsaLq0mo/brNlAL4BnVN6FS8/VVok9CKmxPXrTL4sv3r2yW7UjYzyqF3HRE1nWr5buC69qiNJwqHZ3KXoVLxn69GnKXJSMsxhVclgStzqPaINZyVEgZuKVXYbPL4vcYfwImlAEw4Wzs9Kpk/R8nm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:39:49.7646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9378f43-059d-46bd-5456-08df099f4c8c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000099.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10824
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

Hi Xiao,

On 18/08/2026 10:20, Li Xiao wrote:
> From: Li Xiao <Li.Xiao@airoha.com>
> 
> The calibration retry counter starts at zero and is incremented after
> the limit check. Using a strict greater-than comparison therefore allows
> one more retry than AIROHA_PCS_MAX_CALIBRATION_TRY specifies.
> 
> Use a greater-than-or-equal comparison so the function stops after the
> configured number of retries.
> 
> Fixes: d4dd6eb29bda ("net: airoha: add support for Airoha PCS driver")
> 
> Signed-off-by: Li Xiao <Li.Xiao@airoha.com>
> ---
> Fix an off-by-one condition in the Airoha AN7581 PCS calibration retry
> loop. The current comparison permits one retry beyond the configured
> limit.
> 
> The change was build-tested with an7581_evb_defconfig.
> ---
>  drivers/net/airoha/pcs-an7581.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/airoha/pcs-an7581.c b/drivers/net/airoha/pcs-an7581.c
> index 746ff55d72..bc15d9d07c 100644
> --- a/drivers/net/airoha/pcs-an7581.c
> +++ b/drivers/net/airoha/pcs-an7581.c
> @@ -1321,7 +1321,7 @@ retry_calibration:
>  	 */
>  	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_RX_FREQDET, &val);
>  	if (!(val & AIROHA_PCS_PMA_FBCK_LOCK)) {
> -		if (calibration_try > AIROHA_PCS_MAX_CALIBRATION_TRY) {
> +		if (calibration_try >= AIROHA_PCS_MAX_CALIBRATION_TRY) {
>  			dev_err(priv->dev, "No FBCK Lock from FreqDet module after %d calibration try. PCS won't work.\n",
>  				AIROHA_PCS_MAX_CALIBRATION_TRY);
>  			return -EIO;
> 
> ---
> base-commit: 527115ef6783cec49e5610c523c124b399011361
> change-id: 20260814-fix-airoha-pcs-calibration-retry-f0c9f06f8122
> 
> Best regards,
> --  
> Li Xiao <Li.Xiao@airoha.com>

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
